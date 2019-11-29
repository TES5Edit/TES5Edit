{*******************************************************************************

     The contents of this file are subject to the Mozilla Public License
     Version 1.1 (the "License"); you may not use this file except in
     compliance with the License. You may obtain a copy of the License at
     http://www.mozilla.org/MPL/

     Software distributed under the License is distributed on an "AS IS"
     basis, WITHOUT WARRANTY OF ANY KIND, either express or implied. See the
     License for the specific language governing rights and limitations
     under the License.

*******************************************************************************}

unit wbInit;

{$I wbDefines.inc}

interface

uses
  Classes;

var
  wbApplicationTitle   : string;
  wbScriptToRun        : string;
  wbSettingsFileName   : string;
  wbPluginToUse        : string;  // Passed a specific plugin as parameter
  wbLogFile            : string;  // Optional log file for this session
  wbMyProfileName      : string;

  wbMasterUpdateDone   : Boolean;
  wbDontBackup         : Boolean = False;
  wbRemoveTempPath     : Boolean = True;
  wbQuickShowConflicts : Boolean;
  wbVeryQuickShowConflicts : Boolean;
  wbQuickClean         : Boolean;
  wbQuickCleanAutoSave : Boolean;
  wbAutoLoad           : Boolean;
  wbAutoExit           : Boolean;
  wbAutoGameLink       : Boolean;

  wbParamIndex         : integer = 1;     // First unused parameter
  wbPluginsToUse       : TStringList;

function wbFindNextValidCmdLineFileName(var startingIndex : integer; out aValue  : string; defaultPath : string = '') : Boolean;
function wbFindNextValidCmdLinePlugin(var startingIndex : integer; out aValue  : string; defaultPath : string) : Boolean;
function wbFindCmdLineParam(const aSwitch : string; out aValue : string): Boolean; overload;

function wbLoadMOHookFile: Boolean;
procedure SwitchToCoSave;

function wbDoInit: Boolean;

implementation

uses
  System.UITypes,
  SysUtils,
  Windows,
  Registry,
  ShellApi,
  Dialogs,
  ShlObj,
  IOUtils,
  IniFiles,
  wbHelpers,
  wbInterface,
  wbImplementation,
  wbLocalization,
  wbDefinitionsFNV,
  wbDefinitionsFNVSaves,
  wbDefinitionsFO3,
  wbDefinitionsFO3Saves,
  wbDefinitionsFO4,
  wbDefinitionsFO4Saves,
  wbDefinitionsFO76,
  wbDefinitionsTES3,
  wbDefinitionsTES4,
  wbDefinitionsTES4Saves,
  wbDefinitionsTES5,
  wbDefinitionsTES5Saves;

function wbFindCmdLineParam(const aSwitch     : string;
                            const aChars      : TSysCharSet;
                                  aIgnoreCase : Boolean;
                              out aValue      : string)
                                              : Boolean; overload;
var
  i : Integer;
  s : string;
begin
  Result := False;
  aValue := '';
  for i := 1 to ParamCount do begin
    s := ParamStr(i);
    if (aChars = []) or (s[1] in aChars) then begin
      Delete(s, 1, 1);
      if s.StartsWith(aSwitch + ':', aIgnoreCase) then begin
        aValue := Copy(s, Length(aSwitch) + 2, High(Integer));
        Exit(True);
      end;
      if aIgnoreCase then begin
        if SameText(s, aSwitch) then
          Exit(True)
      end else
        if s = aSwitch then
          Exit(True);
    end;
  end;
end;

function wbFindCmdLineParam(var   startingIndex : integer;
                            const aChars        : TSysCharSet;
                              out aValue        : string)
                                                : Boolean; overload;
var
  i : integer;
  s : string;
begin
  Result := False;
  aValue := '';
  for i := startingIndex to ParamCount do begin
    s := ParamStr(i);
    if (aChars = []) or (s[1] in aChars) then // skipped
      Inc(startingIndex)
    else begin
      aValue := ParamStr(i);
      startingIndex := i+1;
      Result := True;
      break;
    end
  end;
end;

function wbFindCmdLineParam(const aSwitch : string;
                              out aValue  : string)
                                          : Boolean; overload;
begin
  Result := wbFindCmdLineParam(aSwitch, SwitchChars, True, aValue);
end;

function wbFindCmdLineParam(var startingIndex : integer; out aValue  : string) : Boolean; overload;
begin
  Result := wbFindCmdLineParam(startingIndex, SwitchChars, aValue);
end;

function wbCheckForValidExtension(aFilePath : string; const anExtension : string): Boolean; overload;
begin
  Result := aFilePath.EndsWith(anExtension, True);
end;

function wbCheckForPluginExtension(aFilePath : string): Boolean;
begin
  Result := wbIsPlugin(aFilePath);
end;

function wbCheckForValidExtension(aFilePath : string): Boolean; overload;
begin
  Result := wbCheckForPluginExtension(aFilePath) or
            wbCheckForValidExtension(aFilePath, '.fos') or wbCheckForValidExtension(aFilePath, '.ess');
end;

function wbFindNextValidCmdLineFileName(var startingIndex : integer; out aValue  : string; defaultPath : string = '') : Boolean;
begin
  Result := wbFindCmdLineParam(startingIndex, SwitchChars, aValue);
  if Result and not FileExists(aValue) then
    if (defaultPath<>'') then
      if FileExists(defaultPath+'\'+aValue) then
        aValue := ExpandFileName(defaultPath+'\'+aValue)
      else
        Result := False
    else
      Result := False;
end;

function wbFindNextValidCmdLinePlugin(var startingIndex : integer; out aValue  : string; defaultPath : string) : Boolean;
begin
  repeat
    Result := wbFindNextValidCmdLineFileName(startingIndex, aValue, defaultPath);
  until not Result or wbCheckForPluginExtension(aValue);
  if Result  then
    if (AnsiCompareText(ExtractFilePath(ExpandFileName(aValue)), ExpandFileName(defaultPath)) = 0) then begin
      aValue := ExtractFileName(aValue);
      if not Assigned(wbPluginsToUse) then wbPluginsToUse := TStringList.Create;
      wbPluginsToUse.Add(aValue);
    end else
      Result := False;
end;

// several ini settings should be read before record definitions
// they may affect definitions like wbSimpleRecords
// and should be overridden by command line parameters
function ReadSettings: Boolean;
var
  ResetSettings: Boolean;
  Settings: TMemIniFile;
  Shift,Ctrl,Alt: Boolean;
  s : string;
  sl: TStringList;
  i: Integer;
begin
  Result := True;

  if FileExists(wbSettingsFileName) then begin
    ResetSettings := FindCmdLineSwitch('resetsettings');
    if not ResetSettings then begin
      Shift := GetAsyncKeyState(VK_SHIFT) < 0;
      Ctrl := GetAsyncKeyState(VK_CONTROL) < 0;
      Alt := GetAsyncKeyState(VK_MENU) < 0;
      if Shift and Ctrl and Alt then
        ResetSettings := MessageDlg('Reset ALL settings? (Existing settings file will be backed up.)',
          mtConfirmation, [mbYes, mbNo], 0, mbNo) = mrYes;
    end;

    if ResetSettings then begin
      s := wbSettingsFileName + '.backup.' + FormatDateTime('yyyy_mm_dd_hh_nn_ss', Now);

      if not RenameFile(PChar(wbSettingsFileName), PChar(s)) then begin
        ShowMessage(Format('Could not rename existing settings file to "%s".', [s]));
        Exit(False);
      end else
        ShowMessage(Format('ALL settings have been reset. Existing settings file has been renamed to "%s".', [s]));
    end;
  end;

  if FileExists(wbSettingsFileName) then try
    Settings := TMemIniFile.Create(wbSettingsFileName);
    try
      wbLoadBSAs := Settings.ReadBool('Options', 'LoadBSAs', wbLoadBSAs);
      wbSimpleRecords := Settings.ReadBool('Options', 'SimpleRecords', wbSimpleRecords);
      wbShowFlagEnumValue := Settings.ReadBool('Options', 'ShowFlagEnumValue', wbShowFlagEnumValue);
      wbTrackAllEditorID := Settings.ReadBool('Options', 'TrackAllEditorID', wbTrackAllEditorID);
      wbAllowDirectSave := Settings.ReadBool('Options', 'AllowDirectSave', wbAllowDirectSave);
      wbExtendedESL := Settings.ReadBool('Options', 'ExtendedESL', wbExtendedESL);
      wbSortINFO := Settings.ReadBool('Options', 'SortINFO', wbSortINFO);
      wbFillPNAM := Settings.ReadBool('Options', 'FillPNAM', wbFillPNAM);
      wbCollapseConditions := Settings.ReadBool('Options', 'CollapseConditions', wbCollapseConditions);
      wbCollapseBenignArray := Settings.ReadBool('Options', 'CollapseBenignArray', wbCollapseBenignArray);
      sl := TStringList.Create;
      try
        Settings.ReadSection('cpoverride', sl);
        for i := 0 to Pred(sl.Count) do try
          s := sl[i];
          wbAddLEncodingIfMissing(s, Settings.ReadString('cpoverride', s, ''), False);
        except
          on E:Exception do
            ShowMessage('Could not add code page override "'+sl[i]+'" from wbSettingsFileName: ['+E.ClassName+'] ' + E.Message);
        end;
      finally
        sl.Free;
      end;

      if not Settings.ReadBool('Init', 'FirstStart', False) then try
        Settings.WriteBool('Init', 'FirstStart', True);
        if VersionString.Minor mod 2 = 0 then begin
          wbNoGitHubCheck := True;
          Settings.WriteBool('Options', 'NoGitHubCheck', wbNoGitHubCheck);
        end;
        Settings.UpdateFile;
      except end;
    finally
      Settings.Free;
    end;
  except end;
end;

function GetCSIDLShellFolder(CSIDLFolder: integer): string;
begin
  SetLength(Result, MAX_PATH);
  SHGetSpecialFolderPath(0, PChar(Result), CSIDLFolder, True);
  SetLength(Result, StrLen(PChar(Result)));
  if (Result <> '') then
    Result := IncludeTrailingBackslash(Result);
end;

function CheckAppPath: string;
var
  s: string;
begin
  Result := '';
  s := ExtractFilePath(ParamStr(0));
  while Length(s) > 3 do begin
    if FileExists(s + wbGameExeName) and DirectoryExists(s + 'Data') then begin
      Result := s;
      Exit;
    end;
    s := ExtractFilePath(ExcludeTrailingPathDelimiter(s));
  end;
end;

function PathRelativeToFull(const BasePath: string; const AddPath: string) : string;
var CDir : string;
begin
  CDir := GetCurrentDir;
  try
    SetCurrentDir(BasePath);
    Result := ExpandFileName(AddPath);
  finally
    SetCurrentDir(CDir);
  end
end;

{===SafeLoadLibrary============================================================}
{$IFDEF CPUX86}
function TestAndClearFPUExceptions(AExceptionMask: Word): Boolean;
asm
      PUSH    ECX
      MOV     CX, AX
      FSTSW   AX
      TEST    AX, CX
      JNE     @@bad
      XOR     EAX, EAX
      INC     EAX
      JMP     @@exit
@@bad:
      XOR     EAX, EAX
@@exit:
      POP     ECX
      FCLEX
      RET
end;
{------------------------------------------------------------------------------}
function SafeLoadLibrary(const Filename: string; ErrorMode: UINT): HMODULE;
var
  OldMode: UINT;
  FPUControlWord: Word;
begin
  OldMode := SetErrorMode(ErrorMode);
  try
    FPUControlWord := Get8087CW();
    Result := LoadLibrary(PChar(Filename));
    TestAndClearFPUExceptions(0);
    Set8087CW(FPUControlWord);
  finally
    SetErrorMode(OldMode);
  end;
end;
{==============================================================================}
{$ENDIF CPUX86}


function wbLoadMOHookFile: Boolean;
var
  HookDll : HMODULE;
  Init    : function(logLevel: Integer; profileName: LPCWSTR): BOOL; cdecl;
begin
  if not wbShouldLoadMOHookFile then
    Exit(True);
  Result := False;
  if not FileExists(wbMOHookFile) then
    Exit;

  HookDll := SafeLoadLibrary(wbMOHookFile, SEM_NOOPENFILEERRORBOX);
  if HookDll <> 0 then begin
    Pointer(@Init) := GetProcAddress(HookDll, 'Init');
    if Assigned(Pointer(@Init)) then
      Result := Init(0, PWideChar(UnicodeString(wbMOProfile)));
  end;
end;

procedure DoInitPath(const ParamIndex: Integer);
const
  sBethRegKey             = '\SOFTWARE\Bethesda Softworks\';
  sUninstallRegKey        = '\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\';
  sSureAIRegKey           = '\Software\SureAI\';

var
  s, regPath, regKey, client: string;
  IniFile : TMemIniFile;
begin
  wbModGroupFileName := wbProgramPath + wbAppName + wbToolName + '.modgroups';

  if not wbFindCmdLineParam('S', wbScriptsPath) then
    wbScriptsPath := wbProgramPath + 'Edit Scripts\';

  if not wbFindCmdLineParam('T', wbTempPath) then
    wbTempPath := IncludeTrailingPathDelimiter(TPath.GetTempPath + wbAppName + 'Edit')
  else
    wbRemoveTempPath := not DirectoryExists(wbTempPath);

  if not wbFindCmdLineParam('D', wbDataPath) then begin
    wbDataPath := CheckAppPath;

    if (wbDataPath = '') then with TRegistry.Create do try
      Access  := KEY_READ or KEY_WOW64_32KEY;
      RootKey := HKEY_LOCAL_MACHINE;
      client  := 'Steam';

      case wbGameMode of
      gmTES3, gmTES4, gmFO3, gmFNV, gmTES5, gmFO4, gmSSE, gmTES5VR, gmFO4VR: begin
        regPath := sBethRegKey + wbGameNameReg + '\';
      end;
      gmEnderal: begin
        RootKey := HKEY_CURRENT_USER;
        regPath := sSureAIRegKey + wbGameNameReg + '\';
      end;
      gmFO76: begin
        regPath := sUninstallRegKey + wbGameNameReg + '\';
        client  := 'Bethesda.net Launcher';
      end;
      end;

      if not OpenKey(regPath, False) then begin
        Access := KEY_READ or KEY_WOW64_64KEY;
        if not OpenKey(regPath, False) then begin
          s := 'Fatal: Could not open registry key: ' + regPath;
          ShowMessage(Format('%s'#13#10'This can happen after %s updates, run the game''s launcher to restore registry settings', [s, client]));
          wbDontSave := True;
          Exit;
        end;
      end;

      case wbGameMode of
      gmTES3, gmTES4, gmFO3, gmFNV, gmTES5, gmFO4, gmSSE, gmTES5VR, gmFO4VR:
                  regKey := 'Installed Path';
      gmEnderal:  regKey := 'Install_Path';
      gmFO76:     regKey := 'Path';
      end;

      wbDataPath := ReadString(regKey);
      wbDataPath := StringReplace(wbDataPath, '"', '', [rfReplaceAll]);

      if (wbDataPath = '') then begin
        s := Format('Fatal: Could not determine %s installation path, no "%s" registry key', [wbGameName2, regKey]);
        ShowMessage(Format('%s'#13#10'This can happen after %s updates, run the game''s launcher to restore registry settings', [s, client]));
        wbDontSave := True;
      end;
    finally
      Free;
    end;

    if (wbDataPath <> '') then
      wbDataPath := IncludeTrailingPathDelimiter(wbDataPath) + 'Data\';

  end else
    wbDataPath := IncludeTrailingPathDelimiter(wbDataPath);

  wbOutputPath := wbDataPath;
  if wbFindCmdLineParam('O', s) and (Length(s) > 0) then
    if s[1] = '.' then
      //assume relative path
      wbOutputPath := IncludeTrailingPathDelimiter(wbOutputPath + s)
    else
      //assume absolute path
      wbOutputPath := IncludeTrailingPathDelimiter(s);

  wbMOHookFile := wbDataPath + '..\Mod Organizer\hook.dll';

  if not wbFindCmdLineParam('I', wbTheGameIniFileName) then begin
    wbMyProfileName := GetCSIDLShellFolder(CSIDL_PERSONAL);
    if wbMyProfileName = '' then begin
      ShowMessage('Fatal: Could not determine my documents folder');
      Exit;
    end;

    if wbGameMode in [gmFO76] then
      wbMyGamesTheGamePath := wbMyProfileName + 'My Games\' + wbGameNameReg + '\'
    else
      wbMyGamesTheGamePath := wbMyProfileName + 'My Games\' + wbGameName2 + '\';

    if wbGameMode in [gmFO3, gmFNV] then
      wbTheGameIniFileName := wbMyGamesTheGamePath + 'Fallout.ini'
    else
      wbTheGameIniFileName := wbMyGamesTheGamePath + wbGameName + '.ini';

    // VR games don't create ini file in My Games by default, use the one in the game folder
    if (wbGameMode in [gmTES5VR, gmFO4VR]) and not FileExists(wbTheGameIniFileName) then
      wbTheGameIniFileName := ExtractFilePath(ExcludeTrailingPathDelimiter(wbDataPath)) + '\' + ExtractFileName(wbTheGameIniFileName);
  end;

  if not wbFindCmdLineParam('G', wbSavePath) then begin
    if wbMyGamesTheGamePath = '' then
      wbMyGamesTheGamePath := ExtractFilePath(wbTheGameIniFileName);

    s := 'Saves\';
    if FileExists(wbTheGameIniFileName) then begin
      IniFile := TMemIniFile.Create(wbTheGameIniFileName);
      try
        s := IniFile.ReadString('General', 'SLocalSavePath', s);
      finally
        FreeAndNil(IniFile);
      end;
    end;
    wbSavePath := PathRelativeToFull(wbMyGamesTheGamePath, s);
  end;
  wbSavePath := IncludeTrailingPathDelimiter(wbSavePath);

  wbParamIndex := ParamIndex;
  if not wbFindCmdLineParam('P', wbPluginsFileName) then
    if not (wbFindNextValidCmdLineFileName(wbParamIndex, wbPluginsFileName) and SameText(ExtractFileExt(wbPluginsFileName), '.txt'))
       or wbCheckForValidExtension(wbPluginsFileName)
    then begin
      wbParamIndex := ParamIndex;
      wbPluginsFileName := GetCSIDLShellFolder(CSIDL_LOCAL_APPDATA);
      if wbPluginsFileName = '' then begin
        ShowMessage('Fatal: Could not determine the local application data folder');
        Exit;
      end;

      wbPluginsFileName := wbPluginsFileName + wbGameName2 + '\Plugins.txt';
    end;
  if ExtractFilePath(wbPluginsFileName) = '' then
    wbPluginsFileName := ExpandFileName(wbPluginsFileName);

  // settings in the ini file next to app, or in the same folder with plugins.txt
  wbSettingsFileName := wbProgramPath + wbAppName + wbToolName + '.ini';
  if not FileExists(wbSettingsFileName) then
    wbSettingsFileName := ChangeFileExt(wbPluginsFileName, '.'+LowerCase(wbAppName)+'viewsettings');

  wbBackupPath := '';
  if not (wbDontSave or wbFindCmdLineParam('B', wbBackupPath)) then
    wbBackupPath := wbDataPath + wbAppName + 'Edit Backups\';

  wbCachePath := '';
  if not (wbDontCache or wbFindCmdLineParam('C', wbCachePath)) then
    if wbDataPath <> '' then
      wbCachePath := wbDataPath + wbAppName + 'Edit Cache\';
  if wbCachePath = '' then
    wbDontCache := True;
  if not wbDontCache then
    if not DirectoryExists(wbCachePath) then
      if not ForceDirectories(wbCachePath) then
        wbDontCache := True;
  if wbDontCache then
    wbCachePath := '';

  wbFindCmdLineParam('R', wbLogFile);
end;

var
  wbForcedModes: string;
  AppGameMode, AppToolMode, AppSourceMode: string;

procedure DetectAppMode;
const
  SourceModes : array [1..2] of string = ('plugins', 'saves');
  GameModes: array [1..10] of string = ('tes5vr', 'fo4vr', 'tes4', 'tes5', 'enderal', 'sse', 'fo3', 'fnv', 'fo4', 'fo76');
  ToolModes: array [1..15] of string = (
    'edit', 'view', 'lodgen', 'script', 'translate', 'onamupdate', 'masterupdate', 'masterrestore',
    'setesm', 'clearesm', 'sortandclean', 'sortandcleanmasters',
    'checkforerrors', 'checkforitm', 'checkfordr');
var
  s, p: string;
begin
  // Detecting game mode
  // check command line params first for mode overrides
  // they should take precedence over application name detection
  // AppSourceMode := SourceModes[1];
  for s in SourceModes do
    if FindCmdLineSwitch(s) or wbFindCmdLineParam(s, p) or (Pos(s, wbForcedModes) <> 0) then begin
      AppSourceMode := s;
      Break;
    end;
  // if no overrrides, then check by executable name
  if AppSourceMode = '' then
    for s in SourceModes do
      if (Pos(s, LowerCase(ExtractFileName(ParamStr(0)))) <> 0) or (Pos(s, wbForcedModes) <> 0) then begin
        AppSourceMode := s;
        Break;
      end;
  // if still nothing, then default value
  if AppSourceMode = '' then
    AppSourceMode := 'plugins';

  for s in GameModes do
    if FindCmdLineSwitch(s) or wbFindCmdLineParam(s, p) or (Pos(s, wbForcedModes) <> 0) then begin
      AppGameMode := s;
      Break;
    end;
  // if no overrrides, then check by executable name
  if AppGameMode = '' then
    for s in GameModes do
      if (Pos(s, LowerCase(ExtractFileName(ParamStr(0)))) <> 0) or (Pos(s, wbForcedModes) <> 0) then begin
        AppGameMode := s;
        Break;
      end;
  // if still nothing, then default value
  if AppGameMode = '' then
    AppGameMode := 'fo4';

  // the same for tool mode
  for s in ToolModes do
    if FindCmdLineSwitch(s) or wbFindCmdLineParam(s, p) or (Pos(s, wbForcedModes) <> 0) then begin
      AppToolMode := s;
      Break;
    end;
  if AppToolMode = '' then
    for s in ToolModes do
      if (Pos(s, LowerCase(ExtractFileName(ParamStr(0)))) <> 0) or (Pos(s, wbForcedModes) <> 0) then begin
        AppToolMode := s;
        Break;
      end;
  if AppToolMode = '' then
    AppToolMode := 'edit';
end;

function isMode(aMode: String): Boolean;
begin
  aMode := LowerCase(aMode);
  Result := (AppGameMode = aMode) or (AppToolMode = aMode) or (AppSourceMode = aMode);
end;

// Force app modes
function CheckForcedMode: Boolean;
var
  s: string;
  i: integer;
begin
  Result := False;
  // there is a game specific script provided to execute
  // go into 'script' tool mode and detect game mode by script's extension
  i := 1;
  if wbFindCmdLineParam('script', s) or wbFindNextValidCmdLineFileName(i, s) then begin
    wbScriptToRun := s;
    s := ExtractFileExt(s);
    i := Pos(UpperCase('pas'), UpperCase(s));
    if (i > 0) and (i = Length(s) - 2) then begin
      wbForcedModes := Copy(s, 2, Length(s) - 4) + ',script';
      Result := True;
    end;
  end;
end;

function wbDoInit: Boolean;
var
  s: string;
  ToolModes: TwbSetOfMode;
  ToolSources: TwbSetOfSource;
  i: Integer;
  ExeName: string;
begin
  ExeName := ChangeFileExt(ExtractFileName(ParamStr(0)), '').ToLowerInvariant;

  if not wbIsAeroEnabled then
    wbThemesSupported := False;

  Result := True;
  wbReportMode := False;
  wbEditAllowed := True;
  wbDontSave    := False;
  wbDevMode := FindCmdLineSwitch('devmode');

  CheckForcedMode;
  DetectAppMode;

  if isMode('Saves') then begin
    wbToolSource := tsSaves;
    wbSourceName := 'Saves';
    wbUseFalsePlugins := True;
  end else begin // defaults to plugin
    wbToolSource := tsPlugins;
    wbSourceName := 'Plugins';
  end;

  if isMode('View') then begin
    wbToolMode    := tmView;
    wbToolName    := 'View';
    wbEditAllowed := False;
    wbDontSave    := True;
  end else if isMode('MasterUpdate') then begin
    wbToolMode    := tmMasterUpdate;
    wbToolName    := 'MasterUpdate';
  end else if isMode('OnamUpdate') then begin
    wbToolMode    := tmOnamUpdate;
    wbToolName    := 'OnamUpdate';
  end else if isMode('MasterRestore') then begin
    wbToolMode    := tmMasterRestore;
    wbToolName    := 'MasterRestore';
  end else if isMode('LODGen') then begin
    wbToolMode    := tmLODgen;
    wbToolName    := 'LODGen';
    wbEditAllowed := False;
    wbDontSave    := True;
  end else if isMode('Script') then begin
    wbToolMode    := tmScript;
    wbToolName    := 'Script';
  end else if isMode('Translate') then begin
    wbToolMode    := tmTranslate;
    wbToolName    := 'Trans';
  end else if isMode('setESM') then begin
    wbToolMode    := tmESMify;
    wbToolName    := 'SettingESMflag';
  end else if isMode('clearESM') then begin
    wbToolMode    := tmESPify;
    wbToolName    := 'ClearingESMflag';
  end else if isMode('SortAndClean') then begin
    wbToolMode    := tmSortAndCleanMasters;
    wbToolName    := 'SortAndCleanMasters';
  end else if isMode('CheckForErrors') then begin
    wbToolMode    := tmCheckForErrors;
    wbToolName    := 'CheckForErrors';
  end else if isMode('CheckForITM') then begin
    wbToolMode    := tmCheckForITM;
    wbToolName    := 'CheckForITM';
  end else if isMode('CheckForDR') then begin
    wbToolMode    := tmCheckForDR;
    wbToolName    := 'CheckForDR';
  end else if isMode('Edit') then begin
    wbToolMode    := tmEdit;
    wbToolName    := 'Edit';
  end else begin
    ShowMessage('Application name must contain Edit, View, LODGen, OnamUpdate, MasterUpdate, MasterRestore, setESM, clearESM, sortAndCleanMasters, CheckForITM, CheckForDR or CheckForErrors to select mode.');
    Exit(False);
  end;

  if not (wbToolMode in [tmView, tmEdit]) then
    wbPrettyFormID := False;

  wbLanguage := 'English';

  wbGameExeName := '';
  if isMode('FNV') then begin
    wbGameMode := gmFNV;
    wbAppName := 'FNV';
    wbGameName := 'FalloutNV';
    ToolModes := wbAlwaysMode + [tmMasterUpdate, tmMasterRestore];
    ToolSources := [tsPlugins, tsSaves];
  end

  else if isMode('FO3') then begin
    wbGameMode := gmFO3;
    wbAppName := 'FO3';
    wbGameName := 'Fallout3';
    ToolModes := wbAlwaysMode + [tmMasterUpdate, tmMasterRestore];
    ToolSources := [tsPlugins];
  end

  else if isMode('TES3') then begin
    wbGameMode := gmTES3;
    wbAppName := 'TES3';
    wbGameName := 'Morrowind';
    ToolModes := [];
    ToolSources := [];
  end

  else if isMode('TES4') then begin
    wbGameMode := gmTES4;
    wbAppName := 'TES4';
    wbGameName := 'Oblivion';
    ToolModes := wbAlwaysMode;
    ToolSources := [tsPlugins];
  end

  else if isMode('TES5') then begin
    wbGameMode := gmTES5;
    wbAppName := 'TES5';
    wbGameName := 'Skyrim';
    wbGameExeName := 'TESV';
    ToolModes := wbAlwaysMode + [tmOnamUpdate];
    ToolSources := [tsPlugins, tsSaves];
  end

  else if isMode('Enderal') then begin
    wbGameMode := gmEnderal;
    wbAppName := 'Enderal';
    wbGameName := 'Enderal';
    wbGameExeName := 'TESV';
    wbGameMasterEsm := 'Skyrim.esm';
    ToolModes := wbAlwaysMode + [tmOnamUpdate];
    ToolSources := [tsPlugins, tsSaves];
  end

  else if isMode('TES5VR') then begin
    wbGameMode := gmTES5VR;
    wbAppName := 'TES5VR';
    wbGameName := 'Skyrim';
    wbGameName2 := 'Skyrim VR';
    wbGameExeName := 'SkyrimVR';

    ToolModes := wbAlwaysMode + [tmOnamUpdate];
    ToolSources := [tsPlugins];
  end

  else if isMode('SSE') then begin
    wbGameMode := gmSSE;
    wbAppName := 'SSE';
    wbGameName := 'Skyrim';
    wbGameExeName := 'SkyrimSE';
    wbGameName2 := 'Skyrim Special Edition';
    ToolModes := wbAlwaysMode + [tmOnamUpdate];
    ToolSources := [tsPlugins, tsSaves];
  end

  else if isMode('FO4') then begin
    wbGameMode := gmFO4;
    wbAppName := 'FO4';
    wbGameName := 'Fallout4';
    wbArchiveExtension := '.ba2';
    wbLanguage := 'En';
    ToolModes := wbAlwaysMode;
    ToolSources := [tsPlugins, tsSaves];
  end

  else if isMode('FO4VR') then begin
    wbGameMode := gmFO4VR;
    wbAppName := 'FO4VR';
    wbGameName := 'Fallout4';
    wbGameExeName := 'Fallout4VR';
    wbGameName2 := 'Fallout4VR';
    wbGameNameReg := 'Fallout 4 VR';
    wbLanguage := 'En';
    wbArchiveExtension := '.ba2';
    ToolModes := wbAlwaysMode;
    ToolSources := [tsPlugins];
  end

  else if isMode('FO76') then begin
    wbGameMode := gmFO76;
    wbAppName := 'FO76';
    wbGameName := 'Fallout76';
    wbGameNameReg := 'Fallout 76';
    wbGameMasterEsm := 'SeventySix.esm';
    wbLanguage := 'En';
    wbArchiveExtension := '.ba2';
    ToolModes := wbAlwaysMode;
    ToolSources := [tsPlugins];
    VersionString.Title := 'EXPERIMENTAL';
  end

  else begin
    ShowMessage('Application name must contain FNV, FO3, FO4, FO4VR, FO76, SSE, TES4, TES5, TES5VR, or Enderal to select game.');
    Exit(False);
  end;

  if wbGameExeName = '' then
    wbGameExeName := wbGameName;

  wbGameExeName := wbGameExeName + csDotExe;

  if wbGameMode in [gmFO3, gmFNV] then begin
    wbUDRSetZ := False;
    wbUDRSetZValue := -15000;
  end;

  if not (wbToolMode in ToolModes) then begin
    ShowMessage('Application ' + wbGameName + ' does not currently support ' + wbToolName);
    Exit(False);
  end;

  if not (wbToolSource in ToolSources) then begin
    ShowMessage('Application ' + wbGameName + ' does not currently support ' + wbSourceName);
    Exit(False);
  end;

  if (wbToolSource = tsSaves) and (wbToolMode = tmEdit) then begin
    ShowMessage('Application ' + wbGameName + ' does not currently support ' + wbSourceName + ' in ' + wbToolName + ' mode.');
    Exit(False);
  end;

  if wbGameName2 = '' then
    wbGameName2 := wbGameName;

  if wbGameNameReg = '' then
    wbGameNameReg := wbGameName2;

  if wbGameMasterEsm = '' then
    wbGameMasterEsm := wbGameName + csDotEsm;

  if FindCmdLineSwitch('DontCache') then
    wbDontCache := True;
  if FindCmdLineSwitch('DontCacheLoad') then
    wbDontCacheLoad := True;
  if FindCmdLineSwitch('DontCacheSave') then
    wbDontCacheSave := True;
  if wbDontCacheLoad and wbDontCacheSave then
    wbDontCache := True;

  DoInitPath(wbParamIndex);

  // specific Game settings
  case wbGameMode of
    gmFNV: begin
      wbVWDInTemporary := True;
      wbLoadBSAs := False;
      wbCanSortINFO := True;
    end;
    gmFO3: begin
      wbVWDInTemporary := True;
      wbLoadBSAs := False;
      wbCanSortINFO := True;
    end;
    gmTES3: begin
      wbLoadBSAs := False;
      wbAllowInternalEdit := false;
    end;
    gmTES4: begin
      wbLoadBSAs := True;
      wbAllowInternalEdit := false;
      wbCanSortINFO := True;
    end;
    gmTES5, gmEnderal, gmTES5VR, gmSSE: begin
      wbVWDInTemporary := True;
      wbLoadBSAs := True; // localization won't work otherwise
      wbHideIgnored := False; // to show Form Version
      wbCanSortINFO := True;
    end;
    gmFO4, gmFO4VR: begin
      wbVWDInTemporary := True;
      wbVWDAsQuestChildren := True;
      wbLoadBSAs := True; // localization won't work otherwise
      wbHideIgnored := False; // to show Form Version
      wbAlwaysSaveOnam := True;
      wbAlwaysSaveOnamForce := True;
    end;
    gmFO76: begin
      wbVWDInTemporary := True;
      wbVWDAsQuestChildren := True;
      wbLoadBSAs := True; // localization won't work otherwise
      wbHideIgnored := False; // to show Form Version
      wbAlwaysSaveOnam := True;
      wbAlwaysSaveOnamForce := True;
    end;
  else
    ShowMessage('Unknown GameMode');
    Exit(False);
  end;

  wbSortINFO := wbCanSortINFO;

  if not ReadSettings then
    Exit(False);

  if wbCanSortINFO then begin
    if FindCmdLineSwitch('sortinfo') then
      wbSortINFO := True;

    if FindCmdLineSwitch('nosortinfo') then
      wbSortINFO := False;

    if FindCmdLineSwitch('FillPNAM') then
      wbFillPNAM := True;

    if FindCmdLineSwitch('NoFillPNAM') then
      wbFillPNAM := False;
  end;

  // Was gmTES5, but is now gmEnderal
  if wbGameMode <= gmEnderal then
    wbAddDefaultLEncodingsIfMissing(False)
  else begin
    wbLEncodingDefault[False] := TEncoding.UTF8;
    case wbGameMode of
    gmSSE, gmTES5VR:
      wbAddLEncodingIfMissing('english', '1252', False);
    else {FO4, FO76}
      wbAddLEncodingIfMissing('en', '1252', False);
    end;
  end;

  wbAddDefaultLEncodingsIfMissing(True);

  if wbFindCmdLineParam('AllowDirectSaves', s) then begin
    wbAllowDirectSaveFor := TStringList.Create;
    wbAllowDirectSaveFor.Sorted := True;
    wbAllowDirectSaveFor.Duplicates := dupIgnore;
    wbAllowDirectSaveFor.AddStrings(s.Split([',']).ForEach(Trim).RemoveEmpty);
    if wbAllowDirectSaveFor.Count < 1 then begin
      FreeAndNil(wbAllowDirectSaveFor);
      wbAllowDirectSave := True;
    end;
  end else
    if FindCmdLineSwitch('AllowDirectSaves') then
      wbAllowDirectSave := True;

    if FindCmdLineSwitch('ExtendedESL') then
      wbExtendedESL := True;

  if FindCmdLineSwitch('IKnowWhatImDoing') then
    wbIKnowWhatImDoing := True;

  if wbIKnowWhatImDoing and FindCmdLineSwitch('AllowMasterFilesEdit') then
    wbAllowMasterFilesEdit := True;

  if wbIKnowWhatImDoing and FindCmdLineSwitch('StripEmptyMasters') then
    wbStripEmptyMasters := True;

  if wbToolMode = tmEdit then begin
    if   FindCmdLineSwitch('quickshowconflicts') or FindCmdLineSwitch('qsc')
      or ExeName.Contains('quickshowconflicts') or ExeName.Contains('qsc') then
      wbQuickShowConflicts := True;

    if   FindCmdLineSwitch('veryquickshowconflicts') or FindCmdLineSwitch('vqsc')
      or ExeName.Contains('veryquickshowconflicts') or ExeName.Contains('vqsc') then begin
      wbQuickShowConflicts := True;
      wbVeryQuickShowConflicts := True;
      wbAutoLoad := True;
    end;

    if FindCmdLineSwitch('autoload') then
      wbAutoLoad := True;

    if FindCmdLineSwitch('autoexit') then
      wbAutoExit := True;

    if   FindCmdLineSwitch('autogamelink') or FindCmdLineSwitch('agl')
      or ExeName.Contains('autogamelink') or ExeName.Contains('agl') then begin
      wbAutoLoad := True;
      wbAutoGameLink := True;
    end;

    if wbAutoLoad then
      if wbQuickShowConflicts then
        wbVeryQuickShowConflicts := True;

    if (FindCmdLineSwitch('quickclean') or FindCmdLineSwitch('qc')
      or ExeName.Contains('quickclean') or ExeName.Contains('qc')) and (wbToolSource in [tsPlugins]) then
      wbQuickClean := True;

    if (FindCmdLineSwitch('quickautoclean') or FindCmdLineSwitch('qac')
      or ExeName.Contains('quickautoclean') or ExeName.Contains('qac')) and (wbToolSource in [tsPlugins]) then begin
      wbQuickClean := True;
      wbQuickCleanAutoSave := wbQuickClean;
    end;
  end;

  i := 0;
  if wbQuickShowConflicts then
    Inc(i);
  if wbQuickClean then
    Inc(i);
  if wbAutoGameLink then
    Inc(i);

  if i > 1 then begin
    ShowMessage('Can''t activate more than one out of Quick Clean, Quick Show Conflicts, or Auto GameLink modes same time.');
    Exit(False);
  end;

  if wbQuickClean then begin
    wbIKnowWhatImDoing := True;
  end;

  if FindCmdLineSwitch('fixup') then
    wbAllowInternalEdit := True
  else if FindCmdLineSwitch('nofixup') then
    wbAllowInternalEdit := False;

  if FindCmdLineSwitch('skipbsa') then
    wbLoadBSAs := False
  else if FindCmdLineSwitch('forcebsa') then
    wbLoadBSAs := True;

  if FindCmdLineSwitch('skipInternalEditing') then
    wbAllowInternalEdit := False
  else if FindCmdLineSwitch('forceInternalEditing') then
    wbAllowInternalEdit := True;

  if FindCmdLineSwitch('showfixup') then
    wbShowInternalEdit := True
  else if FindCmdLineSwitch('hidefixup') then
    wbShowInternalEdit := False;

  if wbQuickClean then begin
    wbFixupPGRD := True;
    wbAllowInternalEdit := True;
    wbSimpleRecords := False;
  end;

  if wbFindCmdLineParam('l', s) then begin
    wbLanguage := s;
  end else
    if FileExists(wbTheGameIniFileName) then begin
      with TMemIniFile.Create(wbTheGameIniFileName) do try
        case wbGameMode of
          gmTES4: case ReadInteger('Controls', 'iLanguage', 0) of
            1: s := 'German';
            2: s := 'French';
            3: s := 'Spanish';
            4: s := 'Italian';
          else
            s := 'English';
          end;
        else
          s := Trim(ReadString('General', 'sLanguage', '')).ToLower;
        end;
        if (s <> '') and not SameText(s, wbLanguage) then
          wbLanguage := s;
      finally
        Free;
      end;
    end;

  wbEncodingTrans := wbEncodingForLanguage(wbLanguage, False);

  if wbFindCmdLineParam('cp-general', s) then
    wbEncoding :=  wbMBCSEncoding(s);

  if wbFindCmdLineParam('cp', s) or wbFindCmdLineParam('cp-trans', s) then
    wbEncodingTrans :=  wbMBCSEncoding(s);

  // definitions
  case wbGameMode of
    gmFNV: case wbToolSource of
      tsSaves:   DefineFNVSaves;
      tsPlugins: DefineFNV;
    end;
    gmFO3: case wbToolSource of
      tsSaves:   DefineFO3Saves;
      tsPlugins: DefineFO3;
    end;
    gmFO4, gmFO4VR: case wbToolSource of
      tsSaves:   DefineFO4Saves;
      tsPlugins: DefineFO4;
    end;
    gmFO76: case wbToolSource of
      tsPlugins: DefineFO76;
    end;
    gmTES3: case wbToolSource of
      tsPlugins: DefineTES3;
    end;
    gmTES4: case wbToolSource of
      tsSaves:   DefineTES4Saves;
      tsPlugins: DefineTES4;
    end;
    gmTES5, gmTES5VR: case wbToolSource of
      tsSaves:   DefineTES5Saves;
      tsPlugins: DefineTES5;
    end;
    gmEnderal: case wbToolSource of
      tsSaves:   DefineTES5Saves;
      tsPlugins: DefineTES5;
    end;
    gmSSE: case wbToolSource of
      tsSaves:   DefineTES5Saves;
      tsPlugins: DefineTES5;
    end
  end;

  if FindCmdLineSwitch('speed') then
    wbSpeedOverMemory := True;
  if FindCmdLineSwitch('memory') then
    wbSpeedOverMemory := False;

  if FindCmdLineSwitch('report') then
    wbReportMode := (DebugHook <> 0);
  if FindCmdLineSwitch('MoreInfoForIndex') then
    wbMoreInfoForIndex := true;

  if wbIKnowWhatImDoing and FindCmdLineSwitch('IKnowIllBreakMyGameWithThis') then
    wbAllowEditGameMaster := True;

  if FindCmdLineSwitch('TrackAllEditorID') then
    wbTrackAllEditorID := True;

  if FindCmdLineSwitch('IgnoreESL') then
    wbIgnoreESL := True
  else
    if FindCmdLineSwitch('PseudoESL') then
      wbPseudoESL := True;

  if FindCmdLineSwitch('SimpleFormIDs') then
    wbPrettyFormID := False;

  if wbToolMode in wbPluginModes then // look for the file name
    if not wbFindNextValidCmdLinePlugin(wbParamIndex, wbPluginToUse, wbDataPath) then begin
      ShowMessage(wbToolName+' mode requires a valid plugin name!');
      Exit(False);
    end;

  // specific Tool Mode settings overrides
  case wbToolMode of
    tmLODgen: begin
      wbIKnowWhatImDoing := True;
      wbAllowInternalEdit := False;
      wbShowInternalEdit := False;
      wbLoadBSAs := True;
      wbBuildRefs := False;
    end;
    tmScript: begin
      wbIKnowWhatImDoing := True;
      wbLoadBSAs := True;
      wbBuildRefs := True;
    end;
    tmOnamUpdate, tmMasterUpdate, tmESMify: begin
      wbIKnowWhatImDoing := True;
      wbAllowInternalEdit := False;
      wbShowInternalEdit := False;
      wbLoadBSAs := False;
      wbBuildRefs := False;
      wbMasterUpdateFilterONAM := wbToolMode in [tmESMify];
      if wbToolMode = tmOnamUpdate then begin
        wbAlwaysSaveOnam := True;
        wbAlwaysSaveOnamForce := True;
      end;
    end;
    tmMasterRestore, tmESPify, tmCheckForDR, tmCheckForITM, tmCheckForErrors: begin
      wbIKnowWhatImDoing := True;
      wbAllowInternalEdit := False;
      wbShowInternalEdit := False;
      wbLoadBSAs := False;
      wbBuildRefs := False;
    end;
    tmTranslate: begin
      if wbGameMode >= gmTES5 then
        wbLoadBSAs := True; //needed for localization
      wbTranslationMode := True;
      wbHideUnused := True;
      wbHideIgnored := True;
      wbHideNeverShow := True;
    end;
  end;

  if FindCmdLineSwitch('alwayssaveonam') then
    wbAlwaysSaveOnam := True;

  if FindCmdLineSwitch('filteronam') then
    wbMasterUpdateFilterONAM := True
  else if FindCmdLineSwitch('noFilteronam') then
    wbMasterUpdateFilterONAM := False;

  if FindCmdLineSwitch('FixPersistence') then
    wbMasterUpdateFixPersistence := True
  else if FindCmdLineSwitch('NoFixPersistence') then
    wbMasterUpdateFixPersistence := False;

  if FindCmdLineSwitch('AutoMarkModified') then
    wbAutoMarkModified := True;
  if FindCmdLineSwitch('NoAutoMarkModified') then
    wbAutoMarkModified := False;

  if FindCmdLineSwitch('ForceMarkModified') then
    wbForceMarkModified := True;
  if FindCmdLineSwitch('NoForceMarkModified') then
    wbForceMarkModified := False;


  if wbVeryQuickShowConflicts then
    wbSubMode := 'Very Quick Show Conflicts'
  else if wbQuickShowConflicts then
    wbSubMode := 'Quick Show Conflicts'
  else if wbQuickCleanAutoSave then
    wbSubMode := 'Quick Auto Clean'
  else if wbQuickClean then
    wbSubMode := 'Quick Clean'
  else if wbAutoGameLink then
    wbSubMode := 'Auto Game Link';

  wbApplicationTitle := wbAppName + wbToolName + ' ' + VersionString;
  {$IFDEF LiteVersion}
  wbApplicationTitle := wbApplicationTitle + ' Lite';
  {$ENDIF}
  {$IFDEF WIN64}
  wbApplicationTitle := wbApplicationTitle + ' x64';
  {$ENDIF WIN64}
  if wbSubMode <> '' then
    wbApplicationTitle := wbApplicationTitle + ' (' + wbSubMode + ')';

  if wbAutoLoad then
    wbApplicationTitle := wbApplicationTitle + ' [Auto Load]';

  if wbAutoExit then
    wbApplicationTitle := wbApplicationTitle + ' [Auto Exit]';

  if FindCmdLineSwitch('nobuildrefs') then
    wbBuildRefs := False;

  if FindCmdLineSwitch('fixuppgrd') then
    wbFixupPGRD := True;

  wbShouldLoadMOHookFile := wbFindCmdLineParam('moprofile', wbMOProfile);

  try
    if (wbToolMode = tmEdit) and not wbIsAssociatedWithExtension('.' + wbAppName + 'pas') then
      wbAssociateWithExtension('.' + wbAppName + 'pas', wbAppName + 'Script', wbAppName + wbToolName + ' script');
  except end;

end;

procedure SwitchToCoSave;
begin
  case wbGameMode of
    gmFNV:  SwitchToFNVCoSave;
    gmFO3:  SwitchToFO3CoSave;
    gmTES4: SwitchToTES4CoSave;
    gmTES5: SwitchToTES5CoSave;
    gmEnderal:  SwitchToTES5CoSave;
    gmSSE:  SwitchToTES5CoSave;
  end;
end;

initialization
end.

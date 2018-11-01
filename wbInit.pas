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
    if (aChars = []) or (s[1] in aChars) then
      if aIgnoreCase then begin
        if AnsiCompareText(Copy(s, 2, Length(aSwitch)), aSwitch) = 0 then begin
          if (length(s)>(length(aSwitch)+2)) and (s[Length(aSwitch) + 2] = ':') then begin
            aValue := Copy(s, Length(aSwitch) + 3, MaxInt);
            Result := True;
          end;
          Exit;
        end;
      end else
        if AnsiCompareStr(Copy(s, 2, Length(aSwitch)), aSwitch) = 0 then begin
          if s[Length(aSwitch) + 2] = ':' then begin
            aValue := Copy(s, Length(aSwitch) + 3, MaxInt);
            Result := True;
          end;
          Exit;
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
    finally
      Settings.Free;
    end;
  finally
  end;
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
const
  ExeName : array[TwbGameMode] of string = (
    'FalloutNV.exe',  // gmFNV
    'Fallout3.exe',   // gmFO3
    'Morrowind.exe',  // gmTES3
    'Oblivion.exe',   // gmTES4
    'TESV.exe',       // gmTES5
    'SkyrimVR.exe',   // gmTES5VR
    'SkyrimSE.exe',   // gmSSE
    'Fallout4.exe',   // gmFO4
    'Fallout4VR.exe', // gmFO4VR
    'Fallout76.exe'   // gmFO76
  );
var
  s: string;
begin
  Result := '';
  s := ExtractFilePath(ParamStr(0));
  while Length(s) > 3 do begin
    if FileExists(s + ExeName[wbGameMode]) and DirectoryExists(s + 'Data') then begin
      Result := s;
      Exit;
    end;
    s := ExtractFilePath(ExcludeTrailingPathDelimiter(s));
  end;
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
  sBethRegKey64           = '\SOFTWARE\WOW6432Node\Bethesda Softworks\';
  sTempRegKey             = '\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\';
  sTempRegKey64           = '\SOFTWARE\WOW6432Node\Microsoft\Windows\CurrentVersion\Uninstall\';
var
  s: string;
  IniFile : TIniFile;
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

    if wbDataPath = '' then with TRegistry.Create do try
      RootKey := HKEY_LOCAL_MACHINE;

      if wbGameMode = gmFO76 then begin
        if not OpenKeyReadOnly(sTempRegKey + wbGameNameReg + '\') then
          if not OpenKeyReadOnly(sTempRegKey64 + wbGameNameReg + '\') then begin
            s := 'Fatal: Could not open registry key: ' + sTempRegKey + wbGameNameReg + '\';
            // this message is probably a lie...
            ShowMessage(s + #13#10'This can happen after Bethesda Launcher updates, run game''s launcher to restore registry settings');
            wbDontSave := True;
            Exit;
          end;

        wbDataPath := ReadString('Path');
            wbDataPath := StringReplace(wbDataPath, '"', '', [rfReplaceAll]);

        if wbDataPath = '' then begin
          s := 'Fatal: Could not determine ' + wbGameName2 + ' installation path, no "Path" registry key';
          // this message is probably a lie...
          ShowMessage(s + #13#10'This can happen after Bethesda Launcher updates, run game''s launcher to restore registry settings');
          wbDontSave := True;
        end;
      end else begin
        if not OpenKeyReadOnly(sBethRegKey + wbGameNameReg + '\') then
          if not OpenKeyReadOnly(sBethRegKey64 + wbGameNameReg + '\') then begin
            s := 'Fatal: Could not open registry key: ' + sBethRegKey + wbGameNameReg + '\';
            ShowMessage(s + #13#10'This can happen after Steam updates, run game''s launcher to restore registry settings');
              wbDontSave := True;
              Exit;
            end;

        wbDataPath := ReadString('Installed Path');

        if wbDataPath = '' then begin
          s := 'Fatal: Could not determine ' + wbGameName2 + ' installation path, no "Installed Path" registry key';
          ShowMessage(s + #13#10'This can happen after Steam updates, run game''s launcher to restore registry settings');
          wbDontSave := True;
        end;
      end;
    finally
      Free;
    end;
    if wbDataPath <>'' then
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
      IniFile := TIniFile.Create(wbTheGameIniFileName);
      try
        s := IniFile.ReadString('General', 'SLocalSavePath', s);
      finally
        FreeAndNil(IniFile);
      end;
    end;
    wbSavePath := wbMyGamesTheGamePath + s;
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
  GameModes: array [1..9] of string = ('tes5vr', 'fo4vr', 'tes4', 'tes5', 'sse', 'fo3', 'fnv', 'fo4', 'fo76');
  ToolModes: array [1..12] of string = (
    'edit', 'view', 'lodgen', 'script', 'translate',
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
begin
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
    ShowMessage('Application name must contain Edit, View, LODGen, MasterUpdate, MasterRestore, setESM, clearESM, sortAndCleanMasters, CheckForITM, CheckForDR or CheckForErrors to select mode.');
    Exit(False);
  end;

  if not (wbToolMode in [tmView, tmEdit]) then
    wbPrettyFormID := False;

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
    wbLanguage := 'English';
    ToolModes := wbAlwaysMode + [tmTranslate];
    ToolSources := [tsPlugins, tsSaves];
  end

  else if isMode('TES5VR') then begin
    wbGameMode := gmTES5VR;
    wbAppName := 'TES5VR';
    wbGameName := 'Skyrim';
    wbGameName2 := 'Skyrim VR';
    wbLanguage := 'English';
    ToolModes := wbAlwaysMode + [tmTranslate];
    ToolSources := [tsPlugins];
  end

  else if isMode('SSE') then begin
    wbGameMode := gmSSE;
    wbAppName := 'SSE';
    wbGameName := 'Skyrim';
    wbGameName2 := 'Skyrim Special Edition';
    wbLanguage := 'English';
    ToolModes := wbAlwaysMode + [tmTranslate];
    ToolSources := [tsPlugins, tsSaves];
  end

  else if isMode('FO4') then begin
    wbGameMode := gmFO4;
    wbAppName := 'FO4';
    wbGameName := 'Fallout4';
    wbArchiveExtension := '.ba2';
    wbLanguage := 'En';
    ToolModes := wbAlwaysMode + [tmTranslate];
    ToolSources := [tsPlugins, tsSaves];
  end

  else if isMode('FO4VR') then begin
    wbGameMode := gmFO4VR;
    wbAppName := 'FO4VR';
    wbGameName := 'Fallout4';
    wbGameName2 := 'Fallout4VR';
    wbGameNameReg := 'Fallout 4 VR';
    wbLanguage := 'En';
    wbArchiveExtension := '.ba2';
    ToolModes := wbAlwaysMode + [tmTranslate];
    ToolSources := [tsPlugins];
  end

  else if isMode('FO76') then begin
    wbGameMode := gmFO76;
    wbAppName := 'FO76';
    wbGameName := 'Fallout76';
    wbGameName2 := 'Fallout 76';
    wbLanguage := 'En';
    wbArchiveExtension := '.ba2';
    ToolModes := wbAlwaysMode + [tmTranslate];
    ToolSources := [tsPlugins];
  end
  
  else begin
    ShowMessage('Application name must contain FNV, FO3, FO4, FO4VR, FO76, SSE, TES4, TES5 or TES5VR to select game.');
    Exit(False);
  end;

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
    end;
    gmFO3: begin
      wbVWDInTemporary := True;
      wbLoadBSAs := False;
    end;
    gmTES3: begin
      wbLoadBSAs := False;
      wbAllowInternalEdit := false;
    end;
    gmTES4: begin
      wbLoadBSAs := True;
      wbAllowInternalEdit := false;
    end;
    gmTES5, gmTES5VR, gmSSE: begin
      wbVWDInTemporary := True;
      wbLoadBSAs := True; // localization won't work otherwise
      wbHideIgnored := False; // to show Form Version
    end;
    gmFO4, gmFO4VR: begin
      wbVWDInTemporary := True;
      wbVWDAsQuestChildren := True;
      wbLoadBSAs := True; // localization won't work otherwise
      wbHideIgnored := False; // to show Form Version
    end;
    gmFO76: begin
      wbVWDInTemporary := True;
      wbVWDAsQuestChildren := True;
      wbLoadBSAs := True; // localization won't work otherwise
      wbHideIgnored := False; // to show Form Version
    end;
  else
    ShowMessage('Unknown GameMode');
    Exit(False);
  end;

  if not ReadSettings then
    Exit(False);

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

  if FindCmdLineSwitch('IKnowWhatImDoing') then
    wbIKnowWhatImDoing := True;

  if wbIKnowWhatImDoing and FindCmdLineSwitch('AllowMasterFilesEdit') then
    wbAllowMasterFilesEdit := True;

  if FindCmdLineSwitch('quickshowconflicts') then
    wbQuickShowConflicts := True;

  if FindCmdLineSwitch('veryquickshowconflicts') then begin
    wbQuickShowConflicts := True;
    wbVeryQuickShowConflicts := True;
  end;

  if FindCmdLineSwitch('quickclean') and (wbToolSource in [tsPlugins]) then
    wbQuickClean := True;

  if FindCmdLineSwitch('quickautoclean') and (wbToolSource in [tsPlugins]) then begin
    wbQuickClean := True;
    wbQuickCleanAutoSave := wbQuickClean;
  end;

  if wbQuickShowConflicts and wbQuickClean then begin
    ShowMessage('Can''t activate Quick Clean and Quick Show Conflicts modes at the same time.');
    Exit(False);
  end;

  if wbQuickClean then
    wbIKnowWhatImDoing := True;

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
    gmSSE: case wbToolSource of
      tsSaves:   DefineTES5Saves;
      tsPlugins: DefineTES5;
    end
  end;

  if wbFindCmdLineParam('l', s) then
    wbLanguage := s;

  if wbFindCmdLineParam('cp', s) then begin
    if SameText(s, 'utf-8') then
      wbStringEncoding := seUTF8;
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
    tmMasterUpdate, tmESMify: begin
      wbIKnowWhatImDoing := True;
      wbAllowInternalEdit := False;
      wbShowInternalEdit := False;
      wbLoadBSAs := False;
      wbBuildRefs := False;
      wbMasterUpdateFilterONAM := wbToolMode in [tmESMify];
    end;
    tmMasterRestore, tmESPify, tmCheckForDR, tmCheckForITM, tmCheckForErrors: begin
      wbIKnowWhatImDoing := True;
      wbAllowInternalEdit := False;
      wbShowInternalEdit := False;
      wbLoadBSAs := False;
      wbBuildRefs := False;
    end;
    tmTranslate: begin
      wbTranslationMode := True;
      wbHideUnused := True;
      wbHideIgnored := True;
      wbHideNeverShow := True;
    end;
  end;

  if FindCmdLineSwitch('filteronam') then
    wbMasterUpdateFilterONAM := True
  else if FindCmdLineSwitch('noFilteronam') then
    wbMasterUpdateFilterONAM := False;

  if FindCmdLineSwitch('FixPersistence') then
    wbMasterUpdateFixPersistence := True
  else if FindCmdLineSwitch('NoFixPersistence') then
    wbMasterUpdateFixPersistence := False;

  wbApplicationTitle := wbAppName + wbToolName + ' ' + VersionString;
  {$IFDEF LiteVersion}
  wbApplicationTitle := wbApplicationTitle + ' Lite';
  {$ENDIF}
  {$IFDEF WIN64}
  wbApplicationTitle := wbApplicationTitle + ' x64';
  {$ENDIF WIN64}

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
    gmSSE:  SwitchToTES5CoSave;
  end;
end;

initialization
end.

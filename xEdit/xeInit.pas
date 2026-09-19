{******************************************************************************

  This Source Code Form is subject to the terms of the Mozilla Public License,
  v. 2.0. If a copy of the MPL was not distributed with this file, You can obtain
  one at https://mozilla.org/MPL/2.0/.

*******************************************************************************}

unit xeInit;

{$I xeDefines.inc}
{$R 'xEdit\xeIcons.res'}

interface

uses
  System.Classes,
  wbInterface;

var
  xeContextRef             : IwbGameContext;
  xeContext                : TwbGameContext;
  xeScriptToRun            : string;
  xeSettingsFileName       : string;
  xePluginToUse            : string;          // Passed a specific plugin as parameter
  xeLogFile                : string;          // Optional log file for this session
  xeMyProfileName          : string;

  xeIconResource           : string;

  xeMasterUpdateDone       : Boolean;
  xeDontBackup             : Boolean = False;
  xeRemoveTempPath         : Boolean = True;
  xeQuickShowConflicts     : Boolean;
  xeVeryQuickShowConflicts : Boolean;
  xeQuickClean             : Boolean;
  xeQuickEdit              : Boolean;
  xeQuickCleanAutoSave     : Boolean;
  xeQuickSEQ               : Boolean;
  xeAutoLoad               : Boolean;
  xeAutoExit               : Boolean;
  xeAutoGameLink           : Boolean;
  xeTestConflicts          : Boolean;
  xeTestConflictsFile      : string;
  xeTestConflictsCompareTo : string;
  xeTestConflictsFieldsFile: string;
  xeTestConflictsModGroups : Boolean;
  xeTestNavCopy            : Boolean;
  xeTestNavCopyFile        : string;
  xeTestNavCopyEach        : Boolean;
  xeTestNavCopyTwo         : Boolean;
  xeTestNavCopySave        : Boolean;
  xeTestNavCopyDisk        : Boolean;
  xeTestNavCopyNoTouch     : Boolean;
  xeTestNavCopyEsm         : Boolean;
  xeTestNavCopyInject      : Boolean;
  xeTestNavCopyStart       : string = '000001';
  xeTestNavCopyMaster      : string = 'NavCopyA.esp';
  xeTestNavCopyPlugin      : string = 'NavCopyB.esp';
  xeTestNavCopyCount       : Integer = 12;

  xeParamIndex             : Integer = 1;     // First unused parameter
  xeModulesToUse           : TStringList;

  xeSortGroupsByFullName   : Boolean = True;

const
  xeDefaultScriptHost = 'JvI';

function xeFindNextValidCmdLineModule(var aStartIndex  : Integer;
                                      out aValue       : string;
                                    const aDefaultPath : string)
                                                       : Boolean;

function xeLoadMOHookFile: Boolean;

function xeDoInit: Boolean;
procedure xeInitStyles;

implementation

uses
  System.IniFiles,
  System.IOUtils,
  System.SysUtils,
  System.UITypes,
  System.Win.Registry,

  Vcl.Dialogs,
  Vcl.Themes,

  Winapi.ShlObj,
  Winapi.Windows,

  wbCommandLine,
  wbDefinitionsFNV,
  wbDefinitionsFNVSaves,
  wbDefinitionsFO3,
  wbDefinitionsFO3Saves,
  wbDefinitionsFO4,
  wbDefinitionsFO4Saves,
  wbDefinitionsFO76,
  wbDefinitionsSF1,
  wbDefinitionsTES3,
  wbDefinitionsTES4,
  wbDefinitionsTES4Saves,
  wbDefinitionsTES5,
  wbDefinitionsTES5Saves,
  wbHelpers,
  wbImplementation,
  wbSteamVDFParser,

  xeGameSelectForm,
  xeScriptHost;

function xeCheckForValidExtension(const aFilePath : string): Boolean;
begin
  Result := wbIsModule(aFilePath, wbGameExeName) or wbIsSave(aFilePath);
end;

function xeFindNextValidCmdLineFileName(var aStartIndex  : Integer;
                                        out aValue       : string;
                                      const aDefaultPath : string = '')
                                                         : Boolean;
begin
  Result := wbFindCmdLineParam(aStartIndex, SwitchChars, aValue);
  if Result and not FileExists(aValue) then
    if (aDefaultPath<>'') then
      if FileExists(aDefaultPath+'\'+aValue) then
        aValue := ExpandFileName(aDefaultPath+'\'+aValue)
      else
        Result := False
    else
      Result := False;
end;

function xeFindNextValidCmdLineModule(var aStartIndex  : Integer;
                                      out aValue       : string;
                                    const aDefaultPath : string)
                                                       : Boolean;
begin
  repeat
    Result := xeFindNextValidCmdLineFileName(aStartIndex, aValue, aDefaultPath);
  until not Result or wbIsModule(aValue, wbGameExeName);
  if Result  then
    if (AnsiCompareText(ExtractFilePath(ExpandFileName(aValue)), ExpandFileName(aDefaultPath)) = 0) then begin
      aValue := ExtractFileName(aValue);
      if not Assigned(xeModulesToUse) then
        xeModulesToUse := TStringList.Create;
      xeModulesToUse.Add(aValue);
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

  if FileExists(xeSettingsFileName) then begin
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
      s := xeSettingsFileName + '.backup.' + FormatDateTime('yyyy_mm_dd_hh_nn_ss', Now);

      if not RenameFile(PChar(xeSettingsFileName), PChar(s)) then begin
        ShowMessage(Format('Could not rename existing settings file to "%s".', [s]));
        Exit(False);
      end else
        ShowMessage(Format('ALL settings have been reset. Existing settings file has been renamed to "%s".', [s]));
    end;
  end;

  if FileExists(xeSettingsFileName) then try
    Settings := TMemIniFile.Create(xeSettingsFileName);
    try
      xeContext.Settings.LoadBSAs := Settings.ReadBool('Options', 'LoadBSAs', xeContext.Settings.LoadBSAs);
      xeContext.GameDefObj.DefineOptions.SimpleRecords := Settings.ReadBool('Options', 'SimpleRecords', xeContext.GameDefObj.DefineOptions.SimpleRecords);
      xeContext.GameDefObj.DefineOptions.DecodeTextureHashes := Settings.ReadBool('Options', 'DecodeTextureHashes2', xeContext.GameDefObj.DefineOptions.DecodeTextureHashes); {changed name to enforce new default value}
      wbShowFlagEnumValue := Settings.ReadBool('Options', 'ShowFlagEnumValue', wbShowFlagEnumValue);
      wbTrackAllEditorID := Settings.ReadBool('Options', 'TrackAllEditorID', wbTrackAllEditorID);
      xeContext.Settings.AllowDirectSave := Settings.ReadBool('Options', 'AllowDirectSave', xeContext.Settings.AllowDirectSave);
      xeContext.Settings.SortINFO := Settings.ReadBool('Options', 'SortINFO', xeContext.Settings.SortINFO);
      xeContext.Settings.FillPNAM := Settings.ReadBool('Options', 'FillPNAM', xeContext.Settings.FillPNAM);
      xeContext.Settings.WriteOffsetData := Settings.ReadBool('Options', 'WriteOffsetData2', xeContext.Settings.WriteOffsetData); {changed name to enforce new default value}
      for var lCollapse := Low(TwbCollapseOption) to High(TwbCollapseOption) do
        xeContext.GameDefObj.DefineOptions.SetCollapse(lCollapse, Settings.ReadBool('Options', TwbGameDefineOptions.CollapseSettingsKey(lCollapse), lCollapse in xeContext.GameDefObj.DefineOptions.Collapse));
      wbCollapseBenignArray := Settings.ReadBool('Options', 'CollapseBenignArray', wbCollapseBenignArray);
      sl := TStringList.Create;
      try
        Settings.ReadSection('cpoverride', sl);
        for i := 0 to Pred(sl.Count) do try
          s := sl[i];
          xeContext.AddLEncodingIfMissing(s, Settings.ReadString('cpoverride', s, ''), False);
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

function GetCSIDLShellFolder(CSIDLFolder: Integer): string;
begin
  SetLength(Result, MAX_PATH);
  SHGetSpecialFolderPath(0, PChar(Result), CSIDLFolder, True);
  SetLength(Result, StrLen(PChar(Result)));
  if (Result <> '') then
    Result := IncludeTrailingBackslash(Result);
end;

const
  DataName : array[Boolean] of string = (
    'Data',
    'Data Files'   // gmTES3
  );

function CheckAppPath: string;

  function CheckPath(const aStartFrom: string): string;
  var
    s: string;
  begin
    Result := '';
    s := aStartFrom;
    while Length(s) > 3 do begin
      if FileExists(s + wbGameExeName) and DirectoryExists(s + DataName[wbGameMode = gmTES3]) then begin
        Result := s;
        Exit;
      end;
      s := ExtractFilePath(ExcludeTrailingPathDelimiter(s));
    end;
  end;

var
  CurrentDir, ExeDir: string;
begin
  CurrentDir := IncludeTrailingPathDelimiter(GetCurrentDir);
  Result := CheckPath(CurrentDir);
  if (Result = '') then begin
    ExeDir := ExtractFilePath(ParamStr(0));
    if not SameText(CurrentDir, ExeDir) then
      Result := CheckPath(ExeDir);
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


function xeLoadMOHookFile: Boolean;
var
  HookDll : HMODULE;
  Init    : function(logLevel: Integer; profileName: LPCWSTR): BOOL; cdecl;
begin
  if not xeContext.Settings.ShouldLoadMOHookFile then
    Exit(True);
  Result := False;
  if not FileExists(xeContext.Settings.MOHookFile) then
    Exit;

  HookDll := SafeLoadLibrary(xeContext.Settings.MOHookFile, SEM_NOOPENFILEERRORBOX);
  if HookDll <> 0 then begin
    Pointer(@Init) := GetProcAddress(HookDll, 'Init');
    if Assigned(Pointer(@Init)) then
      Result := Init(0, PWideChar(UnicodeString(xeContext.Settings.MOProfile)));
  end;
end;

procedure DoInitPath(const ParamIndex: Integer; var aSettings: TwbGameContextSettings);
const
  sBethRegKey             = '\SOFTWARE\Bethesda Softworks\';
  sUninstallRegKey        = '\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\';
  sSureAIRegKey           = '\Software\SureAI\';

var
  s, regPath, regKey, client: string;
  isEpicNV : Boolean;
  IniFile : TMemIniFile;
  lDataPath, lOutputPath, lMyGamesTheGamePath, lTheGameIniFileName, lCustomIniFileName, lSavePath, lBackupPath, lCachePath: string;
begin
  var lIsOblivionR := wbGameMode = gmTES4R;
  aSettings.ModGroupFileName := wbProgramPath + wbAppName + wbToolName + '.modgroups';
  isEpicNV := false;

  if not wbFindCmdLineParam('S', s) then
    s := wbProgramPath + 'Edit Scripts\';
  aSettings.ScriptsPath := s;

  if not wbFindCmdLineParam('T', s) then
    s := IncludeTrailingPathDelimiter(TPath.GetTempPath + wbAppName + 'Edit')
  else
    xeRemoveTempPath := not DirectoryExists(s);
  aSettings.TempPath := s;

  if not wbFindCmdLineParam('D', lDataPath) then begin
    lDataPath := CheckAppPath;

    if (lDataPath = '') then
      for var lID in wbGameSteamID.Split([',']) do
        begin
          lDataPath := GetInstallPathBySteamID(lID);
          if lDataPath <> '' then
            break;
        end;

    if (lDataPath = '') then with TRegistry.Create do try
      Access  := KEY_READ or KEY_WOW64_32KEY;
      RootKey := HKEY_LOCAL_MACHINE;
      client  := 'Steam';

      case wbGameMode of
        gmTES3, gmTES4, gmFO3, gmFNV, gmTES5, gmFO4, gmSSE, gmTES5VR, gmFO4VR: begin
          regPath := sBethRegKey + wbGameNameReg + '\';
        end;
        gmEnderal, gmEnderalSE: begin
          RootKey := HKEY_CURRENT_USER;
          regPath := sSureAIRegKey + wbGameNameReg + '\';
        end;
        gmFO76, gmSF1, gmTES4R: begin
          regPath := sUninstallRegKey + wbGameNameReg + '\';
        end;
      end;

      if not OpenKey(regPath, False) then begin
        Access := KEY_READ or KEY_WOW64_64KEY;
        if not OpenKey(regPath, False) then begin
          s := 'Fatal: Could not open registry key: ' + regPath;
          ShowMessage(Format('%s'#13#10'This can happen after %s updates, run the game''s launcher to restore registry settings', [s, client]));
          aSettings.DontSave := True;
          aSettings.DataPath := lDataPath;
          Exit;
        end;
      end;

      case wbGameMode of
      gmTES3, gmTES4, gmFO3, gmFNV, gmTES5, gmFO4, gmSSE, gmTES5VR, gmFO4VR:
                  regKey := 'Installed Path';
      gmEnderal, gmEnderalSE:  regKey := 'Install_Path';
      gmFO76, gmSF1, gmTES4R:  regKey := 'InstallLocation';
      end;

      lDataPath := ReadString(regKey);
      lDataPath := StringReplace(lDataPath, '"', '', [rfReplaceAll]);

      if (lDataPath = '') then begin
        s := Format('Fatal: Could not determine %s installation path, no "%s" registry key', [wbGameName2, regKey]);
        ShowMessage(Format('%s'#13#10'This can happen after %s updates, run the game''s launcher to restore registry settings', [s, client]));
        aSettings.DontSave := True;
      end;
    finally
      Free;
    end;

    if lDataPath <> '' then
    begin
      if lIsOblivionR then
        lDataPath := IncludeTrailingPathDelimiter(lDataPath) + 'OblivionRemastered\Content\Dev\ObvData\Data\'
      else
        lDataPath := IncludeTrailingPathDelimiter(lDataPath) + DataName[wbGameMode = gmTES3] + '\';
    end;
  end else
    lDataPath := IncludeTrailingPathDelimiter(lDataPath);
  aSettings.DataPath := lDataPath;

  lOutputPath := lDataPath;

  if wbFindCmdLineParam('O', s) and (Length(s) > 0) then
    if s[1] = '.' then
      //assume relative path
      lOutputPath := IncludeTrailingPathDelimiter(lOutputPath + s)
    else
      //assume absolute path
      lOutputPath := IncludeTrailingPathDelimiter(s);
  aSettings.OutputPath := lOutputPath;

  aSettings.MOHookFile := lDataPath + '..\Mod Organizer\hook.dll';

  if not wbFindCmdLineParam('M', lMyGamesTheGamePath) then begin
    xeMyProfileName := GetCSIDLShellFolder(CSIDL_PERSONAL);
    if xeMyProfileName = '' then begin
      ShowMessage('Fatal: Could not determine my documents folder');
      aSettings.MyGamesTheGamePath := lMyGamesTheGamePath;
      Exit;
    end;

    case wbGameMode of
      gmTES3:
        lMyGamesTheGamePath := IncludeTrailingPathDelimiter(ExtractFilePath(ExcludeTrailingPathDelimiter(lDataPath)));
    else
      lMyGamesTheGamePath := xeMyProfileName + 'My Games\' + wbGameName2 + '\';
    end;

    if (wbGameMode in [gmFNV]) and FileExists(IncludeTrailingPathDelimiter(ExtractFilePath(ExcludeTrailingPathDelimiter(lDataPath))) + 'EOSSDK-Win32-Shipping.dll') then begin
        lMyGamesTheGamePath := xeMyProfileName + 'My Games\FalloutNV_Epic\';
        isEpicNV := true;
    end;
  end;

  if not wbFindCmdLineParam('I', lTheGameIniFileName) then begin
    if wbGameMode in [gmFO3, gmFNV] then
      lTheGameIniFileName := lMyGamesTheGamePath + 'Fallout.ini'
    else
      lTheGameIniFileName := lMyGamesTheGamePath + wbGameName + '.ini';

    // VR games don't create ini file in My Games by default, use the one in the game folder
    if (wbGameMode in [gmTES5VR, gmFO4VR, gmSF1]) and not FileExists(lTheGameIniFileName) then
      lTheGameIniFileName := ExtractFilePath(ExcludeTrailingPathDelimiter(lDataPath)) + '\' + ExtractFileName(lTheGameIniFileName)
    else if lIsOblivionR and not FileExists(lTheGameIniFileName) then
      lTheGameIniFileName := ExtractFilePath(ExcludeTrailingPathDelimiter(lDataPath)) + 'Oblivion.ini';
  end;

  if not wbFindCmdLineParam('CustomIni', lCustomIniFileName) then begin
    if wbGameMode in [gmFO3, gmFNV] then
      lCustomIniFileName := lMyGamesTheGamePath + 'FalloutCustom.ini'
    else
      lCustomIniFileName := lMyGamesTheGamePath + wbGameName + 'Custom.ini';
  end;

  if not wbFindCmdLineParam('G', lSavePath) then begin
    if lMyGamesTheGamePath = '' then
      lMyGamesTheGamePath := ExtractFilePath(lTheGameIniFileName);

    s := 'Saves\';
    if FileExists(lTheGameIniFileName) then begin
      IniFile := TMemIniFile.Create(lTheGameIniFileName);
      try
        s := IniFile.ReadString('General', 'SLocalSavePath', s);
      finally
        FreeAndNil(IniFile);
      end;
    end;

    if FileExists(lCustomIniFileName) then begin
      with TMemIniFile.Create(lCustomIniFileName) do try
        if ValueExists('General', 'SLocalSavePath') then
          s := ReadString('General', 'SLocalSavePath', s);
      finally
        Free;
      end;
    end;

    // Oblivion Remastered has a hard coded path and ignores ini settings
    if lIsOblivionR then
      s := 'Saved\SaveGames\';

    lSavePath := PathRelativeToFull(lMyGamesTheGamePath, s);
  end;
  lSavePath := IncludeTrailingPathDelimiter(lSavePath);
  aSettings.MyGamesTheGamePath := lMyGamesTheGamePath;
  aSettings.TheGameIniFileName := lTheGameIniFileName;
  aSettings.CustomIniFileName := lCustomIniFileName;
  aSettings.SavePath := lSavePath;

  xeParamIndex := ParamIndex;
  var lPluginsFileName: string;
  if not wbFindCmdLineParam('P', lPluginsFileName) then
    if not (xeFindNextValidCmdLineFileName(xeParamIndex, lPluginsFileName) and SameText(ExtractFileExt(lPluginsFileName), '.txt'))
       or xeCheckForValidExtension(lPluginsFileName)
    then begin
      xeParamIndex := ParamIndex;
      lPluginsFileName := GetCSIDLShellFolder(CSIDL_LOCAL_APPDATA);
      if lPluginsFileName = '' then begin
        ShowMessage('Fatal: Could not determine the local application data folder');
        Exit;
      end;

      if wbGameMode = gmFO76 then
        lPluginsFileName := lPluginsFileName + wbGameName + '\Plugins.txt'
      else if (wbGameMode = gmFNV) and isEpicNV then
        lPluginsFileName := lPluginsFileName + wbGameName + '_Epic' + '\Plugins.txt'
      else if lIsOblivionR then
        lPluginsFileName :=  IncludeTrailingPathDelimiter(aSettings.DataPath) + 'Plugins.txt'
      else
        lPluginsFileName := lPluginsFileName + wbGameName2 + '\Plugins.txt';
    end;
  if ExtractFilePath(lPluginsFileName) = '' then
    lPluginsFileName := ExpandFileName(lPluginsFileName);
  aSettings.PluginsFileName := lPluginsFileName;

  // settings in the ini file next to app, or in the same folder with plugins.txt
  xeSettingsFileName := wbProgramPath + wbAppName + wbToolName + '.ini';
  if not FileExists(xeSettingsFileName) then
  begin
    if lIsOblivionR then
      xeSettingsFileName := GetCSIDLShellFolder(CSIDL_LOCAL_APPDATA) + wbGameName2 + '\Plugins.'+LowerCase(wbAppName)+'viewsettings'
    else
      xeSettingsFileName := ChangeFileExt(aSettings.PluginsFileName, '.'+LowerCase(wbAppName)+'viewsettings');
  end;

  lBackupPath := '';
  if not (aSettings.DontSave or wbFindCmdLineParam('B', lBackupPath)) then
    lBackupPath := lDataPath + wbAppName + 'Edit Backups\';
  aSettings.BackupPath := lBackupPath;

  lCachePath := '';
  if not (aSettings.DontCache or wbFindCmdLineParam('C', lCachePath)) then
    if lDataPath <> '' then
      lCachePath := lDataPath + wbAppName + 'Edit Cache\';
  if lCachePath = '' then
    aSettings.DontCache := True;
  if not aSettings.DontCache then
    if not DirectoryExists(lCachePath) then
      if not ForceDirectories(lCachePath) then
        aSettings.DontCache := True;
  if aSettings.DontCache then
    lCachePath := '';
  aSettings.CachePath := lCachePath;

  wbFindCmdLineParam('R', xeLogFile);
end;

var
  wbForcedModes: string;
  AppGameMode, AppToolMode, AppSourceMode: string;

procedure DetectAppMode;
const
  SourceModes : array of string = ['plugins', 'saves'];
  GameModes: array of string = ['tes4r', 'tes5vr', 'fo4vr', 'tes3', 'tes4', 'tes5', 'enderalse', 'enderal', 'sse', 'fo3', 'fnv', 'fo4', 'fo76', 'sf1'];
  ToolModes: array of string = [
    'edit', 'view', 'lodgen', 'script', 'translate', 'onamupdate', 'masterupdate', 'masterrestore',
    'setesm', 'clearesm', 'sortandclean', 'sortandcleanmasters',
    'checkforerrors', 'checkforitm', 'checkfordr'];
var
  s, p: string;
  sl : TStringList;
  i : Integer;
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
  if AppGameMode = '' then begin
    sl := TStringList.Create;
    with TfrmGameSelect.Create(nil) do try
      sl.Sorted := True;
      for s in GameModes do
        sl.Add(s);

      ListBox1.Items.Assign(sl);

      if ShowModal = mrOK then
        for i := 0 to Pred(ListBox1.Items.Count) do
          if ListBox1.Selected[i] then begin
             AppGameMode := ListBox1.Items[i];
             Break;
          end;
    finally
      Free;
      sl.Free;
    end;
  end;

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
  i: Integer;
begin
  Result := False;
  // there is a game specific script provided to execute
  // go into 'script' tool mode and detect game mode by script's extension
  i := 1;
  if wbFindCmdLineParam('script', s) or xeFindNextValidCmdLineFileName(i, s) then begin
    xeScriptToRun := s;
    s := ExtractFileExt(s);
    i := Pos(UpperCase('pas'), UpperCase(s));
    if (i > 0) and (i = Length(s) - 2) then begin
      wbForcedModes := Copy(s, 2, Length(s) - 4) + ',script';
      Result := True;
    end;
  end;
end;

function _DoInit: Boolean;
var
  s: string;
  ToolModes: TwbSetOfMode;
  ToolSources: TwbSetOfSource;
  i: Integer;
  ExeName: string;
  lInputs: TwbGameDefInputs;
  lSettings: TwbGameContextSettings;
begin
  ExeName := ChangeFileExt(ExtractFileName(ParamStr(0)), '').ToLowerInvariant;
  lInputs := Default(TwbGameDefInputs);
  lSettings := TwbGameContextSettings.Defaults;

  if not wbIsAeroEnabled then
    wbThemesSupported := False;

  Result        := True;
  wbReportMode  := False;
  lSettings.EditAllowed := True;
  lSettings.DontSave := False;
  wbDevMode     := FindCmdLineSwitch('devmode');

  CheckForcedMode;
  DetectAppMode;

  if isMode('Saves') then begin
    wbToolSource := tsSaves;
    wbSourceName := 'Saves';
    lSettings.UseFalsePlugins := True;
  end else begin // defaults to plugin
    wbToolSource := tsPlugins;
    wbSourceName := 'Plugins';
  end;

  if isMode('View') then begin
    wbToolMode    := tmView;
    wbToolName    := 'View';
    lSettings.EditAllowed := False;
    lSettings.DontSave := True;
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
    lSettings.EditAllowed := False;
    lSettings.DontSave := True;
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

  lSettings.Language := 'English';

  wbGameExeName        := '';
  if isMode('FNV') then begin
    wbGameMode         := gmFNV;
    wbAppName          := 'FNV';
    wbGameName         := 'FalloutNV';
    wbGameSteamID      := '22380,22490';
    ToolModes          := wbAlwaysMode + [tmMasterUpdate, tmMasterRestore];
    ToolSources        := [tsPlugins, tsSaves];
  end

  else if isMode('FO3') then begin
    wbGameMode         := gmFO3;
    wbAppName          := 'FO3';
    wbGameName         := 'Fallout3';
    wbGameSteamID      := '22370,22300';
    ToolModes          := wbAlwaysMode + [tmMasterUpdate, tmMasterRestore];
    ToolSources        := [tsPlugins];
  end

  else if isMode('TES3') then begin
    wbGameMode         := gmTES3;
    wbAppName          := 'TES3';
    wbGameName         := 'Morrowind';
    wbGameSteamID      := '22320';
    (**)
    ToolModes          := (**)[tmView];(** )wbAlwaysMode - [tmLODgen];(**)
    ToolSources        := [tsPlugins];
    (**)
  end

  else if isMode('TES4') then begin
    wbGameMode         := gmTES4;
    wbAppName          := 'TES4';
    wbGameName         := 'Oblivion';
    wbGameSteamID      := '22330,900883';
    ToolModes          := wbAlwaysMode;
    ToolSources        := [tsPlugins];
  end

  else if isMode('TES4R') then begin
    wbGameMode         := gmTES4R;
    wbAppName          := 'TES4R';
    wbGameName         := 'Oblivion';
    wbGameExeName      := 'Oblivion Remastered';
    wbGameName2        := 'Oblivion Remastered';
    wbGameMasterEsm    := 'Oblivion.esm';
    wbGameNameReg      := 'Steam App 2623190';
    wbGameSteamID      := '2623190';
    ToolModes          := wbAlwaysMode;
    ToolSources        := [tsPlugins];
  end

  else if isMode('TES5') then begin
    wbGameMode         := gmTES5;
    wbAppName          := 'TES5';
    wbGameName         := 'Skyrim';
    wbGameExeName      := 'TESV';
    wbGameSteamID      := '72850';
    ToolModes          := wbAlwaysMode + [tmOnamUpdate];
    ToolSources        := [tsPlugins, tsSaves];
  end

  else if isMode('EnderalSE') then begin
    wbGameMode         := gmEnderalSE;
    wbAppName          := 'EnderalSE';
    wbGameName         := 'Enderal';
    wbGameExeName      := 'SkyrimSE';
    wbGameName2        := 'Enderal Special Edition';
    wbGameNameReg      := 'EnderalSE';
    wbGameMasterEsm    := 'Skyrim.esm';
    wbGameSteamID      := '976620';
    ToolModes          := wbAlwaysMode + [tmOnamUpdate];
    ToolSources        := [tsPlugins, tsSaves];
  end

  else if isMode('Enderal') then begin
    wbGameMode         := gmEnderal;
    wbAppName          := 'Enderal';
    wbGameName         := 'Enderal';
    wbGameExeName      := 'TESV';
    wbGameMasterEsm    := 'Skyrim.esm';
    wbGameSteamID      := '933480';
    ToolModes          := wbAlwaysMode + [tmOnamUpdate];
    ToolSources        := [tsPlugins, tsSaves];
  end

  else if isMode('TES5VR') then begin
    wbGameMode         := gmTES5VR;
    wbAppName          := 'TES5VR';
    wbGameName         := 'Skyrim';
    wbGameName2        := 'Skyrim VR';
    wbGameExeName      := 'SkyrimVR';
    wbGameSteamID      := '611670';
    ToolModes          := wbAlwaysMode + [tmOnamUpdate];
    ToolSources        := [tsPlugins];
  end

  else if isMode('SSE') then begin
    wbGameMode         := gmSSE;
    wbAppName          := 'SSE';
    wbGameName         := 'Skyrim';
    wbGameExeName      := 'SkyrimSE';
    wbGameName2        := 'Skyrim Special Edition';
    wbGameSteamID      := '489830';
    ToolModes          := wbAlwaysMode + [tmOnamUpdate];
    ToolSources        := [tsPlugins, tsSaves];
  end

  else if isMode('FO4') then begin
    wbGameMode         := gmFO4;
    wbAppName          := 'FO4';
    wbGameName         := 'Fallout4';
    lSettings.Language := 'En';
    wbGameSteamID      := '377160';
    ToolModes          := wbAlwaysMode;
    ToolSources        := [tsPlugins, tsSaves];
  end

  else if isMode('FO4VR') then begin
    wbGameMode         := gmFO4VR;
    wbAppName          := 'FO4VR';
    wbGameName         := 'Fallout4';
    wbGameExeName      := 'Fallout4VR';
    wbGameName2        := 'Fallout4VR';
    wbGameNameReg      := 'Fallout 4 VR';
    lSettings.Language := 'En';
    wbGameSteamID      := '611660';
    ToolModes          := wbAlwaysMode;
    ToolSources        := [tsPlugins];
  end

  else if isMode('FO76') then begin
    wbGameMode         := gmFO76;
    wbAppName          := 'FO76';
    wbGameName         := 'Fallout76';
    wbGameName2        := 'Fallout 76';
    wbGameNameReg      := 'Steam App 1151340';
    wbGameMasterEsm    := 'SeventySix.esm';
    lSettings.Language := 'En';
    wbGameSteamID      := '1151340';
    ToolModes          := wbAlwaysMode;
    ToolSources        := [tsPlugins];
  end

  else if isMode('SF1') then begin
    wbGameMode         := gmSF1;
    wbAppName          := 'SF1';
    wbGameName         := 'Starfield';
    wbGameNameReg      := 'Steam App 1716740';
    lSettings.Language := 'En';
    wbGameSteamID      := '1716740';
    ToolModes          := wbAlwaysMode - [tmESMify, tmESPify, tmLODgen];
    ToolSources        := [tsPlugins];
    wbLightName        := 'Small';

    if    FindCmdLineSwitch('ItJustWorksTM')
      and FindCmdLineSwitch('ThisIsFine')
      and FindCmdLineSwitch('GiveMeTheRedPill')
    then begin
      VersionString.Title := 'ItJustWorks[TM] Edition';
      lSettings.RedPill := True;
      wbStarfieldIsABugInfestedHellhole := False; //you wish... but lets pretend
    end;
  end

  else begin
    ShowMessage('Application name or game mode argument must contain FNV, FO3, FO4, FO4VR, FO76, SSE, TES4, TES4R, TES5, TES5VR, Enderal, EnderalSE, or SF1 to select game.');
    Exit(False);
  end;

  if wbGameExeName = '' then
    wbGameExeName := wbGameName;

  wbGameExeName := wbGameExeName + csDotExe;

  if wbGameMode in [gmFO3, gmFNV] then begin
    lSettings.UDRSetZ := False;
    lSettings.UDRSetZValue := -15000;
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
    lSettings.DontCache := True;
  if lSettings.DontCache or FindCmdLineSwitch('DontCacheLoad') then
    lSettings.DontCacheLoad := True;
  if lSettings.DontCache or FindCmdLineSwitch('DontCacheSave') then
    lSettings.DontCacheSave := True;
  if lSettings.DontCacheLoad and lSettings.DontCacheSave then
    lSettings.DontCache := True;

  DoInitPath(xeParamIndex, lSettings);

  // specific Game settings
  case wbGameMode of
    gmFNV: begin
      lInputs.VWDInTemporary  := True;
      lSettings.LoadBSAs := False;
      lSettings.CanSortINFO := True;
      lSettings.AllowESPMasters := True;
      lSettings.AllowESPMastersOnSave := True;
      lInputs.HNVSE           := FileExists(lSettings.DataPath + 'NVSE\Plugins\Hnvse.dll');
    end;
    gmFO3: begin
      lInputs.VWDInTemporary := True;
      lSettings.LoadBSAs := False;
      lSettings.CanSortINFO := True;
      lSettings.AllowESPMasters := True;
      lSettings.AllowESPMastersOnSave := True;
    end;
    gmTES3: begin
      lSettings.LoadBSAs := False;
      lSettings.AllowInternalEdit := false;
      lSettings.DontCache := True;
      lSettings.DontCacheLoad := True;
      lSettings.DontCacheSave := True;
      lSettings.BuildRefs := False;
      lInputs.VWDInTemporary := True;
      lSettings.CreateContainedIn := False;
      lSettings.AllowESPMasters := True;
      lSettings.AllowESPMastersOnSave := True;
    end;
    gmTES4: begin
      if (not FileExists(lSettings.DataPath + 'Oblivion.esm')) and FileExists(lSettings.DataPath + 'Nehrim.esm') then begin
        wbAppName           := 'Nehrim';
        wbGameMasterEsm     := 'Nehrim.esm';
      end;
      lSettings.LoadBSAs := True;
      lSettings.AllowInternalEdit := false;
      lSettings.CanSortINFO := True;
      lSettings.AllowESPMasters := True;
      lSettings.AllowESPMastersOnSave := True;
    end;
    gmTES4R: begin
      lSettings.LoadBSAs := False;
      lSettings.AllowInternalEdit := False;
      lSettings.CanSortINFO := True;
      lSettings.AllowESPMasters := True;
      lSettings.AllowESPMastersOnSave := True;
    end;
    gmTES5, gmEnderal, gmTES5VR, gmSSE, gmEnderalSE: begin
      lInputs.VWDInTemporary := True;
      lSettings.LoadBSAs := True;  // localization won't work otherwise
      lSettings.HideIgnored := False; // to show Form Version
      lSettings.CanSortINFO := True;
      var lVRESL := (wbGameMode in [gmTES5VR]) and FileExists(lSettings.DataPath + 'SKSE\Plugins\skyrimvresl.dll');
      lInputs.LightSupport := lVRESL;
      lInputs.UpdateSupport := lVRESL;
      lInputs.CS := (wbGameMode in [gmTES5VR, gmSSE, gmEnderalSE]) and FileExists(lSettings.DataPath + 'SKSE\Plugins\CommunityShaders.dll');
      lSettings.AllowESPMasters := True;
      lSettings.AllowESPMastersOnSave := True;
    end;
    gmFO4, gmFO4VR: begin
      lInputs.VWDInTemporary := True;
      lInputs.VWDAsQuestChildren := True;
      lSettings.LoadBSAs := True;  // localization won't work otherwise
      lSettings.HideIgnored := False; // to show Form Version
      lSettings.AlwaysSaveOnam := True;
      lSettings.AlwaysSaveOnamForce := True;
      var lVRESL := (wbGameMode in [gmFO4VR]) and (FileExists(lSettings.DataPath + 'F4SE\Plugins\falloutvresl.dll') or
                                                    FileExists(lSettings.DataPath + 'F4SE\Plugins\Daytripper4.dll'));
      lInputs.LightSupport := lVRESL;
      lInputs.UpdateSupport := lVRESL;
      lSettings.AllowESPMasters := True;
      lSettings.AllowESPMastersOnSave := True;
    end;
    gmFO76: begin
      lInputs.VWDInTemporary := True;
      lInputs.VWDAsQuestChildren := True;
      lSettings.LoadBSAs := True;  // localization won't work otherwise
      lSettings.HideIgnored := False; // to show Form Version
      lSettings.AlwaysSaveOnam := True;
      lSettings.AlwaysSaveOnamForce := True;
    end;
    gmSF1: begin
      lInputs.ComplexFileFileID := True;
      lSettings.EnforceAllMasters := True;
      lInputs.VWDInTemporary := True;
      lInputs.VWDAsQuestChildren := True;
      lSettings.LoadBSAs := True;  // localization won't work otherwise
      lSettings.HideIgnored := False; // to show Form Version
      lSettings.AlwaysSaveOnam := True;
      lSettings.AlwaysSaveOnamForce := True;
    end;
  else
    ShowMessage('Unknown GameMode');
    Exit(False);
  end;

  lInputs.GameName := wbGameName;
  lInputs.GameExeName := wbGameExeName;
  lInputs.GameMasterEsm := wbGameMasterEsm;
  lInputs.AppName := wbAppName;
  xeContextRef := wbCreateGameContext(wbCreateGameDef(wbGameMode, wbToolSource, lInputs, False));
  xeContext := xeContextRef as TwbGameContext;
  lSettings.CreationClubContentFileName := xeContext.Settings.CreationClubContentFileName;
  xeContext.Settings := lSettings;

  xeContext.Settings.SortINFO := xeContext.Settings.CanSortINFO;

  if not ReadSettings then
    Exit(False);

  if xeContext.GameDefObj.GameMode = gmSF1 then
    xeContext.GameDefObj.DefineOptions.DecodeTextureHashes := True;

  if xeContext.Settings.CanSortINFO then begin
    if FindCmdLineSwitch('sortinfo') then
      xeContext.Settings.SortINFO := True;

    if FindCmdLineSwitch('nosortinfo') then
      xeContext.Settings.SortINFO := False;

    if FindCmdLineSwitch('FillPNAM') then
      xeContext.Settings.FillPNAM := True;

    if FindCmdLineSwitch('NoFillPNAM') then
      xeContext.Settings.FillPNAM := False;
  end;

  // Was gmTES5, but is now gmEnderal
  if xeContext.GameDefObj.GameMode <= gmEnderal then
    xeContext.AddDefaultLEncodingsIfMissing(False)
  else begin
    wbLEncodingDefault[False] := TEncoding.UTF8;
    case xeContext.GameDefObj.GameMode of
    gmSSE, gmTES5VR, gmEnderalSE:
      xeContext.AddLEncodingIfMissing('english', '1252', False);
    else {FO4, FO76}
      xeContext.AddLEncodingIfMissing('en', '1252', False);
    end;
  end;

  xeContext.AddDefaultLEncodingsIfMissing(True);

  if wbFindCmdLineParam('AllowDirectSaves', s) then begin
    xeContext.AllowDirectSaveFor.AddStrings(s.Split([',']).ForEach(Trim).RemoveEmpty);
    if xeContext.AllowDirectSaveFor.Count < 1 then
      xeContext.Settings.AllowDirectSave := True;
  end else
    if FindCmdLineSwitch('AllowDirectSaves') then
      xeContext.Settings.AllowDirectSave := True;

  if FindCmdLineSwitch('IKnowWhatImDoing') then
  begin
    wbIKnowWhatImDoing := True;

    if FindCmdLineSwitch('AllowMakePartial') then
      wbAllowMakePartial := True;

    if FindCmdLineSwitch('AllowMasterFilesEdit') then
      xeContext.GameDefObj.DefineOptions.AllowMasterFilesEdit := True;

    if FindCmdLineSwitch('AllowEditHEDRVersion') then
      xeContext.GameDefObj.DefineOptions.AllowEditHEDRVersion := True;

    if FindCmdLineSwitch('StripEmptyMasters') then
      xeContext.Settings.StripEmptyMasters := True;

    if wbFindCmdLineParam('StripMasters', s) then
    begin
      xeContext.Settings.StripMasters := True;

      xeContext.StripMastersFileNames.AddStrings(s.Split([',']).ForEach(Trim).RemoveEmpty);

      if xeContext.StripMastersFileNames.Count < 1 then
        xeContext.Settings.StripMasters := False;
    end;

    if FindCmdLineSwitch('AllowESPMaster') then
      xeContext.Settings.AllowESPMasters := True;
  end;

  if wbToolMode in [tmEdit, tmScript] then begin
    if FindCmdLineSwitch('autoload') then
      xeAutoLoad := True;

    if FindCmdLineSwitch('autoexit') then
      xeAutoExit := True;
  end;

  if wbToolMode = tmEdit then begin
    if   FindCmdLineSwitch('quickshowconflicts') or FindCmdLineSwitch('qsc')
      or ExeName.Contains('quickshowconflicts') or ExeName.Contains('qsc') then
      xeQuickShowConflicts := True;

    if   FindCmdLineSwitch('veryquickshowconflicts') or FindCmdLineSwitch('vqsc')
      or ExeName.Contains('veryquickshowconflicts') or ExeName.Contains('vqsc') then begin
      xeQuickShowConflicts := True;
      xeVeryQuickShowConflicts := True;
      xeAutoLoad := True;
    end;

    if wbFindCmdLineParam('testconflicts', xeTestConflictsFile) then begin
      if xeTestConflictsFile = '' then begin
        ShowMessage('testconflicts requires an output file, as -testconflicts:<filename>');
        Exit(False);
      end;
      xeTestConflicts := True;
      xeAutoLoad      := True;
      wbFindCmdLineParam('comparetofile', xeTestConflictsCompareTo);
      wbFindCmdLineParam('fieldsfile', xeTestConflictsFieldsFile);
      xeTestConflictsModGroups := FindCmdLineSwitch('modgroups');
    end;

    if wbFindCmdLineParam('testnavcopy', xeTestNavCopyFile) then begin
      if xeTestNavCopyFile = '' then begin
        ShowMessage('testnavcopy requires an output file, as -testnavcopy:<filename>');
        Exit(False);
      end;
      xeTestNavCopy := True;
      xeAutoLoad    := True;
      xeTestNavCopyEach := FindCmdLineSwitch('testnavcopyeach');
      xeTestNavCopyTwo := FindCmdLineSwitch('testnavcopytwo');
      xeTestNavCopySave := FindCmdLineSwitch('testnavcopysave');
      xeTestNavCopyNoTouch := FindCmdLineSwitch('testnavcopynotouch');
      xeTestNavCopyEsm := FindCmdLineSwitch('testnavcopyesm');
      xeTestNavCopyDisk := FindCmdLineSwitch('testnavcopydisk');
      xeTestNavCopyInject := FindCmdLineSwitch('testnavcopyinject');
      if xeTestNavCopySave then
        xeTestNavCopyTwo := True;
      var lValue: string;
      if wbFindCmdLineParam('testnavcopystart', lValue) and (lValue <> '') then
        xeTestNavCopyStart := lValue;
      if wbFindCmdLineParam('testnavcopymaster', lValue) and (lValue <> '') then
        xeTestNavCopyMaster := lValue;
      if wbFindCmdLineParam('testnavcopyplugin', lValue) and (lValue <> '') then
        xeTestNavCopyPlugin := lValue;
      if wbFindCmdLineParam('testnavcopycount', lValue) then
        xeTestNavCopyCount := StrToIntDef(lValue, xeTestNavCopyCount);
    end;

    if   FindCmdLineSwitch('autogamelink') or FindCmdLineSwitch('agl')
      or ExeName.Contains('autogamelink') or ExeName.Contains('agl') then begin
      xeAutoLoad := True;
      xeAutoGameLink := True;
    end;

    if xeAutoLoad then
      if xeQuickShowConflicts then
        xeVeryQuickShowConflicts := True;

    if (FindCmdLineSwitch('quickclean') or FindCmdLineSwitch('qc')
      or ExeName.Contains('quickclean') or ExeName.Contains('qc')) and (wbToolSource in [tsPlugins]) then begin
      if xeContext.Settings.CanSortINFO then
        xeContext.Settings.FillPNAM := True;
      xeQuickClean := True;
    end;

    if (FindCmdLineSwitch('quickautoclean') or FindCmdLineSwitch('qac')
      or ExeName.Contains('quickautoclean') or ExeName.Contains('qac')) and (wbToolSource in [tsPlugins]) then begin
      if xeContext.Settings.CanSortINFO then
        xeContext.Settings.FillPNAM := True;
      xeQuickClean := True;
      xeQuickCleanAutoSave := xeQuickClean;
    end;
  end;

  if FindCmdLineSwitch('showlargesubrecords') then
    xeContext.GameDefObj.DefineOptions.HideLargeSubrecords := False;

  if xeQuickClean then
    xeContext.Settings.WriteOffsetData := True;

  if xeQuickClean then begin
    wbIKnowWhatImDoing := True;
    xeContext.Settings.FillINOM := False;
    xeContext.Settings.FillINOA := False;
  end;

  if FindCmdLineSwitch('fixup') then
    xeContext.Settings.AllowInternalEdit := True
  else if FindCmdLineSwitch('nofixup') then
    xeContext.Settings.AllowInternalEdit := False;

  if FindCmdLineSwitch('skipbsa') then
    xeContext.Settings.LoadBSAs := False
  else if FindCmdLineSwitch('forcebsa') then
    xeContext.Settings.LoadBSAs := True;

  if FindCmdLineSwitch('skipInternalEditing') then
    xeContext.Settings.AllowInternalEdit := False
  else if FindCmdLineSwitch('forceInternalEditing') then
    xeContext.Settings.AllowInternalEdit := True;

  if FindCmdLineSwitch('showfixup') then
    wbShowInternalEdit := True
  else if FindCmdLineSwitch('hidefixup') then
    wbShowInternalEdit := False;

  if xeQuickClean then begin
    xeContext.Settings.FixupPGRD := True;
    xeContext.Settings.AllowInternalEdit := True;
    xeContext.GameDefObj.DefineOptions.SimpleRecords := False;
  end;

  if wbFindCmdLineParam('l', s) then begin
    xeContext.Settings.Language := s;
  end else begin
    if FileExists(xeContext.Settings.TheGameIniFileName) then begin
      with TMemIniFile.Create(xeContext.Settings.TheGameIniFileName) do try
        case xeContext.GameDefObj.GameMode of
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
      finally
        Free;
      end;
    end;

    if FileExists(xeContext.Settings.CustomIniFileName) then begin
       with TMemIniFile.Create(xeContext.Settings.CustomIniFileName) do try
        case xeContext.GameDefObj.GameMode of
          gmTES4: begin
            if ValueExists('Controls', 'iLanguage') then
              case ReadInteger('Controls', 'iLanguage', 0) of
                1: s := 'German';
                2: s := 'French';
                3: s := 'Spanish';
                4: s := 'Italian';
              else
                s := 'English';
              end;
          end else begin
            if ValueExists('General', 'sLanguage') then
              s := Trim(ReadString('General', 'sLanguage', '')).ToLower;
          end;
        end;
      finally
        Free;
      end;
    end;

    if (s <> '') and not SameText(s, xeContext.Settings.Language) then
      xeContext.Settings.Language := s;
  end;

  xeContext.Settings.EncodingTrans := xeContext.EncodingForLanguage(xeContext.Settings.Language, False);

  if wbFindCmdLineParam('cp-general', s) then
    xeContext.Settings.Encoding :=  wbMBCSEncoding(s);

  if wbFindCmdLineParam('cp', s) or wbFindCmdLineParam('cp-trans', s) then
    xeContext.Settings.EncodingTrans :=  wbMBCSEncoding(s);

  xeContext.GameDefObj.EnsureDefined;
  xeContext.Settings.CreationClubContentFileName := xeContext.GameDefObj.CreationClubContentFileName;

  if FindCmdLineSwitch('reportinjected') then
    wbReportInjected := True;
  if FindCmdLineSwitch('noreportinjected') then
    wbReportInjected := False;

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


  if FindCmdLineSwitch('IgnoreESL') or FindCmdLineSwitch('IgnoreLight') or FindCmdLineSwitch('IgnoreSmall') then
    xeContext.Settings.IgnoreLight := True
  else
    if FindCmdLineSwitch('PseudoESL') or FindCmdLineSwitch('PseudoLight') or FindCmdLineSwitch('PseudoSmall') then
      xeContext.Settings.PseudoLight := True;

  if FindCmdLineSwitch('IgnoreMedium') then
    xeContext.Settings.IgnoreMedium := True
  else
    if FindCmdLineSwitch('PseudoMedium') then
      xeContext.Settings.PseudoMedium := True;

  if FindCmdLineSwitch('IgnoreUpdate') then
    xeContext.Settings.IgnoreUpdate := True
  else
    if FindCmdLineSwitch('PseudoUpdate') then
      xeContext.Settings.PseudoUpdate := True;

  if gcComplexFileFileID in xeContext.GameDefObj.Capabilities then begin
    xeContext.Settings.IgnoreLight := False;
    xeContext.Settings.PseudoLight := False;
    xeContext.Settings.IgnoreMedium := False;
    xeContext.Settings.PseudoMedium := False;
    xeContext.Settings.IgnoreUpdate := False;
    xeContext.Settings.PseudoUpdate := False;
  end;

  if FindCmdLineSwitch('SimpleFormIDs') then
    wbPrettyFormID := False;

  if FindCmdLineSwitch('EnforceAllMasters') then
    xeContext.Settings.EnforceAllMasters := True;

  if wbFindCmdLineParam('quickedit', xePluginToUse) then begin
    if not (wbToolMode = tmEdit) then
      ShowMessage(wbToolName+' is incompatible with quickedit request!')
    else
      xeQuickEdit := True;
  end;

  if (not xeQuickEdit) and wbFindCmdLineParam('generateseq', xePluginToUse) then begin
    xeAutoLoad := True;
    xeQuickSEQ := True;
  end;

  i := 0;
  if xeQuickShowConflicts then
    Inc(i);
  if xeQuickClean then
    Inc(i);
  if xeAutoGameLink then
    Inc(i);
  if xeTestConflicts then
    Inc(i);
  if xeQuickEdit then
    Inc(i);
  if xeQuickSEQ then
    Inc(i);

  if i > 1 then begin
    if xeTestConflicts then
      ExitCode := 255
    else
      ShowMessage('Can''t activate more than one out of Quick Clean, Quick Show Conflicts, Auto GameLink, Test Conflicts, Quick Edit, or Generate SEQ modes same time.');
    Exit(False);
  end;

  if wbToolMode in wbPluginModes then // look for the file name
    if not xeFindNextValidCmdLineModule(xeParamIndex, xePluginToUse, xeContext.Settings.DataPath) then begin
      ShowMessage(wbToolName+' mode requires a valid plugin name!');
      Exit(False);
    end;

  // specific Tool Mode settings overrides
  case wbToolMode of
    tmLODgen: begin
      wbIKnowWhatImDoing       := True;
      xeContext.Settings.AllowInternalEdit := False;
      wbShowInternalEdit       := False;
      xeContext.Settings.LoadBSAs := True;
      xeContext.Settings.BuildRefs := False;
    end;
    tmScript: begin
      wbIKnowWhatImDoing       := True;
      xeContext.Settings.LoadBSAs := True;
      xeContext.Settings.BuildRefs := True;
    end;
    tmOnamUpdate, tmMasterUpdate, tmESMify: begin
      wbIKnowWhatImDoing       := True;
      xeContext.Settings.AllowInternalEdit := False;
      wbShowInternalEdit       := False;
      xeContext.Settings.LoadBSAs := False;
      xeContext.Settings.BuildRefs := False;
      xeContext.Settings.MasterUpdateFilterONAM := wbToolMode in [tmESMify];
      if wbToolMode = tmOnamUpdate then begin
        xeContext.Settings.AlwaysSaveOnam := True;
        xeContext.Settings.AlwaysSaveOnamForce := True;
      end;
    end;
    tmMasterRestore, tmESPify, tmCheckForDR, tmCheckForITM, tmCheckForErrors: begin
      wbIKnowWhatImDoing       := True;
      xeContext.Settings.AllowInternalEdit := False;
      wbShowInternalEdit       := False;
      xeContext.Settings.LoadBSAs := False;
      xeContext.Settings.BuildRefs := False;
    end;
    tmTranslate: begin
      if xeContext.GameDefObj.GameMode >= gmTES5 then
        xeContext.Settings.LoadBSAs := True; //needed for localization
      xeContext.Settings.TranslationMode := True;
      wbHideUnused             := True;
      xeContext.Settings.HideIgnored := True;
      wbHideNeverShow          := True;
    end;
  end;

  if FindCmdLineSwitch('alwayssaveonam') then
    xeContext.Settings.AlwaysSaveOnam := True;

  if FindCmdLineSwitch('filteronam') then
    xeContext.Settings.MasterUpdateFilterONAM := True
  else if FindCmdLineSwitch('noFilteronam') then
    xeContext.Settings.MasterUpdateFilterONAM := False;

  if FindCmdLineSwitch('FixPersistence') then
    xeContext.Settings.MasterUpdateFixPersistence := True
  else if FindCmdLineSwitch('NoFixPersistence') then
    xeContext.Settings.MasterUpdateFixPersistence := False;

  if xeVeryQuickShowConflicts then
    wbSubMode := 'Very Quick Show Conflicts'
  else if xeQuickShowConflicts then
    wbSubMode := 'Quick Show Conflicts'
  else if xeQuickCleanAutoSave then
    wbSubMode := 'Quick Auto Clean'
  else if xeQuickClean then
    wbSubMode := 'Quick Clean'
  else if xeAutoGameLink then
    wbSubMode := 'Auto Game Link';

  if not wbFindCmdLineParam('scripthost', s) then
    s := xeDefaultScriptHost;
  TxeScriptHost.Init(s);

  wbApplicationTitle := wbAppName + wbToolName + ' ' + VersionString;
  {$IFDEF LiteVersion}
  wbApplicationTitle := wbApplicationTitle + ' Lite';
  {$ENDIF}
  {$IFDEF WIN64}
  wbApplicationTitle := wbApplicationTitle + ' x64';
  {$ENDIF WIN64}
  if wbSubMode <> '' then
    wbApplicationTitle := wbApplicationTitle + ' (' + wbSubMode + ')';

  if xeAutoLoad then
    wbApplicationTitle := wbApplicationTitle + ' [Auto Load]';

  if xeAutoExit then
    wbApplicationTitle := wbApplicationTitle + ' [Auto Exit]';

  if FindCmdLineSwitch('nobuildrefs') then
    xeContext.Settings.BuildRefs := False;

  if FindCmdLineSwitch('fixuppgrd') then
    xeContext.Settings.FixupPGRD := True;

  var lMOProfile: string;
  xeContext.Settings.ShouldLoadMOHookFile := wbFindCmdLineParam('moprofile', lMOProfile);
  xeContext.Settings.MOProfile := lMOProfile;

  if FindCmdLineSwitch('moreunknown') then
    wbMoreInfoForUnknown := True;

  try
    if (wbToolMode = tmEdit) and not wbIsAssociatedWithExtension('.' + wbAppName + 'pas') then
      wbAssociateWithExtension('.' + wbAppName + 'pas', wbAppName + 'Script', wbAppName + wbToolName + ' script');
  except end;

  case xeContext.GameDefObj.GameMode of
    gmTES3, gmTES4, gmTES4R,  gmTES5, gmEnderal, gmSSE, gmTES5VR, gmEnderalSE:
      xeIconResource := 'xTESICON';
    gmFO3, gmFNV, gmFO4, gmFO4VR, gmFO76:
      xeIconResource := 'xFOICON';
    gmSF1:
      xeIconResource := 'xSFICON';
  end;

  if FindCmdLineSwitch('exceptiontest') then try
    raise Exception.Create('Exception Test');
  except end;
end;

function xeDoInit: Boolean;
begin
  try
    Result := _DoInit;
  except
    on E: Exception do begin
      Result := False;
      if not (E is EAbort) then
        ShowMessage('Initialization failed: [' + E.ClassName + '] ' + E.Message);
    end;
  end;
end;

procedure xeInitStyles;
begin
  var Path := IncludeTrailingPathDelimiter(ExtractFilePath(ParamStr(0))) + 'Themes';
  if TDirectory.Exists(Path) then
    for var s in TDirectory.GetFiles(Path, '*.vsf' ) do try
      TStyleManager.LoadFromFile(s);
    except
      on E: Exception do
        ShowMessage(Format('Error loading theme file "%s": %s', [s, E.Message]));
    end;
end;

end.

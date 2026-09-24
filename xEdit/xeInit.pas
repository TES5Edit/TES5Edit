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
  xeGameMode               : TwbGameMode;
  xeToolMode               : TwbToolMode;
  xeSubMode                : string;
  xeApplicationTitle       : string;
  xeToolName               : string;
  xeContextRef             : IwbGameContext;
  xeContext                : TwbGameContext;
  xeSaveContexts           : TArray<IwbSaveContext>;
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
  xeSavesMode              : Boolean;
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
  xeTestNavCopyNew         : Boolean;
  xeTestNavCopySignature   : string = 'QUST';
  xeTestSaveContexts       : Boolean;
  xeTestSaveContextsFile   : string;
  xeTestSaveContextsSave   : string;
  xeTestSaveContextsCompare: string;

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
function xeNexusModsUrl: string;

implementation

uses
  System.IniFiles,
  System.IOUtils,
  System.Rtti,
  System.SysUtils,
  System.TypInfo,
  System.UITypes,

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

  xeGameSelectForm,
  xeScriptHost;

function xeCheckForValidExtension(const aFilePath : string): Boolean;
begin
  Result := wbIsModule(aFilePath, wbGameIdentities[xeGameMode].GameExeName) or wbIsSave(aFilePath);
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
  until not Result or wbIsModule(aValue, wbGameIdentities[xeGameMode].GameExeName);
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
      xeContext.Settings.TrackAllEditorID := Settings.ReadBool('Options', 'TrackAllEditorID', xeContext.Settings.TrackAllEditorID);
      xeContext.Settings.AllowDirectSave := Settings.ReadBool('Options', 'AllowDirectSave', xeContext.Settings.AllowDirectSave);
      xeContext.Settings.SortINFO := Settings.ReadBool('Options', 'SortINFO', xeContext.Settings.SortINFO);
      xeContext.Settings.FillPNAM := Settings.ReadBool('Options', 'FillPNAM', xeContext.Settings.FillPNAM);
      xeContext.Settings.WriteOffsetData := Settings.ReadBool('Options', 'WriteOffsetData2', xeContext.Settings.WriteOffsetData); {changed name to enforce new default value}
      for var lCollapse in TwbGameDefineOptions.CheckableCollapse do
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
var
  s, lRegistryName: string;
  isEpicNV : Boolean;
  IniFile : TMemIniFile;
  lDataPath, lOutputPath, lMyGamesTheGamePath, lTheGameIniFileName, lCustomIniFileName, lSavePath, lBackupPath, lCachePath: string;
begin
  var lLocation := wbGameLocations[xeGameMode];
  var lIdentity := wbGameIdentities[xeGameMode];
  aSettings.ModGroupFileName := wbProgramPath + lIdentity.AppName + xeToolName + '.modgroups';
  isEpicNV := false;

  if not wbFindCmdLineParam('S', s) then
    s := wbProgramPath + 'Edit Scripts\';
  aSettings.ScriptsPath := s;

  if not wbFindCmdLineParam('T', s) then
    s := IncludeTrailingPathDelimiter(TPath.GetTempPath + lIdentity.AppName + 'Edit')
  else
    xeRemoveTempPath := not DirectoryExists(s);
  aSettings.TempPath := s;

  if not wbFindCmdLineParam('D', lDataPath) then begin
    case aSettings.FindDataPath(xeGameMode, lRegistryName) of
      dpsNoRegistryKey: begin
        s := 'Fatal: Could not open registry key: ' + lRegistryName;
        ShowMessage(Format('%s'#13#10'This can happen after %s updates, run the game''s launcher to restore registry settings', [s, 'Steam']));
        aSettings.DontSave := True;
        Exit;
      end;
      dpsNoRegistryValue: begin
        s := Format('Fatal: Could not determine %s installation path, no "%s" registry key', [lIdentity.GameName2, lRegistryName]);
        ShowMessage(Format('%s'#13#10'This can happen after %s updates, run the game''s launcher to restore registry settings', [s, 'Steam']));
        aSettings.DontSave := True;
      end;
    end;
    lDataPath := aSettings.DataPath;
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

    lMyGamesTheGamePath := aSettings.DefaultMyGamesPath(xeGameMode, xeMyProfileName, isEpicNV);
  end;

  if not wbFindCmdLineParam('I', lTheGameIniFileName) then
    lTheGameIniFileName := aSettings.DefaultGameIniFileName(xeGameMode, lMyGamesTheGamePath);

  if not wbFindCmdLineParam('CustomIni', lCustomIniFileName) then
    lCustomIniFileName := aSettings.DefaultCustomIniFileName(xeGameMode, lMyGamesTheGamePath);

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

    if lLocation.FixedSaveFolder <> '' then
      s := lLocation.FixedSaveFolder;

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

      if lLocation.PluginsInData then
        lPluginsFileName := IncludeTrailingPathDelimiter(aSettings.DataPath) + 'Plugins.txt'
      else if isEpicNV then
        lPluginsFileName := lPluginsFileName + lLocation.PluginsFolder + '_Epic' + '\Plugins.txt'
      else
        lPluginsFileName := lPluginsFileName + lLocation.PluginsFolder + '\Plugins.txt';
    end;
  if ExtractFilePath(lPluginsFileName) = '' then
    lPluginsFileName := ExpandFileName(lPluginsFileName);
  aSettings.PluginsFileName := lPluginsFileName;

  // settings in the ini file next to app, or in the same folder with plugins.txt
  xeSettingsFileName := wbProgramPath + lIdentity.AppName + xeToolName + '.ini';
  if not FileExists(xeSettingsFileName) then
  begin
    if lLocation.PluginsInData then
      xeSettingsFileName := GetCSIDLShellFolder(CSIDL_LOCAL_APPDATA) + lLocation.PluginsFolder + '\Plugins.'+LowerCase(lIdentity.AppName)+'viewsettings'
    else
      xeSettingsFileName := ChangeFileExt(aSettings.PluginsFileName, '.'+LowerCase(lIdentity.AppName)+'viewsettings');
  end;

  lBackupPath := '';
  if not (aSettings.DontSave or wbFindCmdLineParam('B', lBackupPath)) then
    lBackupPath := lDataPath + lIdentity.AppName + 'Edit Backups\';
  aSettings.BackupPath := lBackupPath;

  lCachePath := '';
  if not (aSettings.DontCache or wbFindCmdLineParam('C', lCachePath)) then
    if lDataPath <> '' then
      lCachePath := lDataPath + lIdentity.AppName + 'Edit Cache\';
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
  SourceName: string;
  i: Integer;
  ExeName: string;
  lInputs: TwbGameDefInputs;
  lSettings: TwbGameContextSettings;
begin
  ExeName := ChangeFileExt(ExtractFileName(ParamStr(0)), '').ToLowerInvariant;
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

  xeSavesMode := isMode('Saves');
  if xeSavesMode then begin
    SourceName := 'Saves';
    lSettings.UseFalsePlugins := True;
  end else // defaults to plugin
    SourceName := 'Plugins';

  if isMode('View') then begin
    xeToolMode    := tmView;
    xeToolName    := 'View';
    lSettings.EditAllowed := False;
    lSettings.DontSave := True;
  end else if isMode('MasterUpdate') then begin
    xeToolMode    := tmMasterUpdate;
    xeToolName    := 'MasterUpdate';
  end else if isMode('OnamUpdate') then begin
    xeToolMode    := tmOnamUpdate;
    xeToolName    := 'OnamUpdate';
  end else if isMode('MasterRestore') then begin
    xeToolMode    := tmMasterRestore;
    xeToolName    := 'MasterRestore';
  end else if isMode('LODGen') then begin
    xeToolMode    := tmLODgen;
    xeToolName    := 'LODGen';
    lSettings.EditAllowed := False;
    lSettings.DontSave := True;
  end else if isMode('Script') then begin
    xeToolMode    := tmScript;
    xeToolName    := 'Script';
  end else if isMode('Translate') then begin
    xeToolMode    := tmTranslate;
    xeToolName    := 'Trans';
  end else if isMode('setESM') then begin
    xeToolMode    := tmESMify;
    xeToolName    := 'SettingESMflag';
  end else if isMode('clearESM') then begin
    xeToolMode    := tmESPify;
    xeToolName    := 'ClearingESMflag';
  end else if isMode('SortAndClean') then begin
    xeToolMode    := tmSortAndCleanMasters;
    xeToolName    := 'SortAndCleanMasters';
  end else if isMode('CheckForErrors') then begin
    xeToolMode    := tmCheckForErrors;
    xeToolName    := 'CheckForErrors';
  end else if isMode('CheckForITM') then begin
    xeToolMode    := tmCheckForITM;
    xeToolName    := 'CheckForITM';
  end else if isMode('CheckForDR') then begin
    xeToolMode    := tmCheckForDR;
    xeToolName    := 'CheckForDR';
  end else if isMode('Edit') then begin
    xeToolMode    := tmEdit;
    xeToolName    := 'Edit';
  end else begin
    ShowMessage('Application name must contain Edit, View, LODGen, OnamUpdate, MasterUpdate, MasterRestore, setESM, clearESM, sortAndCleanMasters, CheckForITM, CheckForDR or CheckForErrors to select mode.');
    Exit(False);
  end;

  if not (xeToolMode in [tmView, tmEdit]) then
    wbPrettyFormID := False;

  if isMode('FNV') then begin
    xeGameMode         := gmFNV;
    ToolModes          := wbAlwaysMode + [tmMasterUpdate, tmMasterRestore];
  end

  else if isMode('FO3') then begin
    xeGameMode         := gmFO3;
    ToolModes          := wbAlwaysMode + [tmMasterUpdate, tmMasterRestore];
  end

  else if isMode('TES3') then begin
    xeGameMode         := gmTES3;
    (**)
    ToolModes          := (**)[tmView];(** )wbAlwaysMode - [tmLODgen];(**)
    (**)
  end

  else if isMode('TES4') then begin
    xeGameMode         := gmTES4;
    ToolModes          := wbAlwaysMode;
  end

  else if isMode('TES4R') then begin
    xeGameMode         := gmTES4R;
    ToolModes          := wbAlwaysMode;
  end

  else if isMode('TES5') then begin
    xeGameMode         := gmTES5;
    ToolModes          := wbAlwaysMode + [tmOnamUpdate];
  end

  else if isMode('EnderalSE') then begin
    xeGameMode         := gmEnderalSE;
    ToolModes          := wbAlwaysMode + [tmOnamUpdate];
  end

  else if isMode('Enderal') then begin
    xeGameMode         := gmEnderal;
    ToolModes          := wbAlwaysMode + [tmOnamUpdate];
  end

  else if isMode('TES5VR') then begin
    xeGameMode         := gmTES5VR;
    ToolModes          := wbAlwaysMode + [tmOnamUpdate];
  end

  else if isMode('SSE') then begin
    xeGameMode         := gmSSE;
    ToolModes          := wbAlwaysMode + [tmOnamUpdate];
  end

  else if isMode('FO4') then begin
    xeGameMode         := gmFO4;
    ToolModes          := wbAlwaysMode;
  end

  else if isMode('FO4VR') then begin
    xeGameMode         := gmFO4VR;
    ToolModes          := wbAlwaysMode;
  end

  else if isMode('FO76') then begin
    xeGameMode         := gmFO76;
    ToolModes          := wbAlwaysMode;
  end

  else if isMode('SF1') then begin
    xeGameMode         := gmSF1;
    ToolModes          := wbAlwaysMode - [tmESMify, tmESPify, tmLODgen];

    if    FindCmdLineSwitch('ItJustWorksTM')
      and FindCmdLineSwitch('ThisIsFine')
      and FindCmdLineSwitch('GiveMeTheRedPill')
    then begin
      VersionString.Title := 'ItJustWorks[TM] Edition';
      lSettings.RedPill := True;
    end;
  end

  else begin
    ShowMessage('Application name or game mode argument must contain FNV, FO3, FO4, FO4VR, FO76, SSE, TES4, TES4R, TES5, TES5VR, Enderal, EnderalSE, or SF1 to select game.');
    Exit(False);
  end;

  var lIdentity := wbGameIdentities[xeGameMode];

  if not (xeToolMode in ToolModes) then begin
    ShowMessage('Application ' + lIdentity.GameName + ' does not currently support ' + xeToolName);
    Exit(False);
  end;

  if FindCmdLineSwitch('DontCache') then
    lSettings.DontCache := True;
  if lSettings.DontCache or FindCmdLineSwitch('DontCacheLoad') then
    lSettings.DontCacheLoad := True;
  if lSettings.DontCache or FindCmdLineSwitch('DontCacheSave') then
    lSettings.DontCacheSave := True;
  if lSettings.DontCacheLoad and lSettings.DontCacheSave then
    lSettings.DontCache := True;

  DoInitPath(xeParamIndex, lSettings);

  lSettings.ApplyGameDefaults(xeGameMode);
  lSettings.ToolName := xeToolName;
  lInputs := TwbGameDefInputs.Detect(xeGameMode, lSettings.DataPath);

  xeContextRef := wbCreateGameContext(wbCreateGameDef(xeGameMode, lInputs, False));
  xeContext := xeContextRef as TwbGameContext;
  xeContext.Settings := lSettings;

  if xeSavesMode and not xeContext.GameDefObj.HasSaveDef then begin
    ShowMessage('Application ' + xeContext.GameDefObj.GameName + ' does not currently support ' + SourceName);
    Exit(False);
  end;

  if xeSavesMode and (xeToolMode = tmEdit) then begin
    ShowMessage('Application ' + xeContext.GameDefObj.GameName + ' does not currently support ' + SourceName + ' in ' + xeToolName + ' mode.');
    Exit(False);
  end;

  xeContext.Settings.SortINFO := gcCanSortINFO in xeContext.GameDefObj.Capabilities;

  if not ReadSettings then
    Exit(False);

  if xeContext.GameDefObj.GameMode = gmSF1 then begin
    xeContext.GameDefObj.DefineOptions.DecodeTextureHashes := True;
    if xeContext.Settings.RedPill then
      xeContext.GameDefObj.DefineOptions.StarfieldIsABugInfestedHellhole := False; //you wish... but lets pretend
  end;

  if gcCanSortINFO in xeContext.GameDefObj.Capabilities then begin
    if FindCmdLineSwitch('sortinfo') then
      xeContext.Settings.SortINFO := True;

    if FindCmdLineSwitch('nosortinfo') then
      xeContext.Settings.SortINFO := False;

    if FindCmdLineSwitch('FillPNAM') then
      xeContext.Settings.FillPNAM := True;

    if FindCmdLineSwitch('NoFillPNAM') then
      xeContext.Settings.FillPNAM := False;
  end;

  xeContext.AddGameDefaultLEncodings;

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
      xeContext.Settings.AllowMakePartial := True;

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

  if xeToolMode in [tmEdit, tmScript] then begin
    if FindCmdLineSwitch('autoload') then
      xeAutoLoad := True;

    if FindCmdLineSwitch('autoexit') then
      xeAutoExit := True;
  end;

  if xeToolMode = tmEdit then begin
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
      xeTestNavCopyNew := FindCmdLineSwitch('testnavcopynew');
      if wbFindCmdLineParam('testnavcopysig', lValue) and (Length(lValue) = 4) then
        xeTestNavCopySignature := lValue;
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
      or ExeName.Contains('quickclean') or ExeName.Contains('qc')) and not xeSavesMode then begin
      if gcCanSortINFO in xeContext.GameDefObj.Capabilities then
        xeContext.Settings.FillPNAM := True;
      xeQuickClean := True;
    end;

    if (FindCmdLineSwitch('quickautoclean') or FindCmdLineSwitch('qac')
      or ExeName.Contains('quickautoclean') or ExeName.Contains('qac')) and not xeSavesMode then begin
      if gcCanSortINFO in xeContext.GameDefObj.Capabilities then
        xeContext.Settings.FillPNAM := True;
      xeQuickClean := True;
      xeQuickCleanAutoSave := xeQuickClean;
    end;
  end;

  if wbFindCmdLineParam('testsavecontexts', xeTestSaveContextsFile) then begin
    if (xeTestSaveContextsFile = '') or not xeSavesMode or
       not wbFindCmdLineParam('testsavecontextssave', xeTestSaveContextsSave) or
       not wbFindCmdLineParam('testsavecontextscompare', xeTestSaveContextsCompare) then begin
      ShowMessage('testsavecontexts runs in saves mode and requires -testsavecontexts:<filename> -testsavecontextssave:<save> -testsavecontextscompare:<save>');
      Exit(False);
    end;
    xeTestSaveContexts := True;
    xeAutoLoad := True;
    xeAutoExit := True;
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

  if wbFindCmdLineParam('l', s) then
    xeContext.Settings.Language := s
  else
    xeContext.ApplyGameIniLanguage;

  xeContext.Settings.EncodingTrans := xeContext.EncodingForLanguage(xeContext.Settings.Language, False);

  if wbFindCmdLineParam('cp-general', s) then
    xeContext.Settings.Encoding :=  wbMBCSEncoding(s);

  if wbFindCmdLineParam('cp', s) or wbFindCmdLineParam('cp-trans', s) then
    xeContext.Settings.EncodingTrans :=  wbMBCSEncoding(s);

  xeContext.GameDefObj.EnsureDefined;

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
    xeContext.Settings.AllowEditGameMaster := True;

  if FindCmdLineSwitch('TrackAllEditorID') then
    xeContext.Settings.TrackAllEditorID := True;


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
    if not (xeToolMode = tmEdit) then
      ShowMessage(xeToolName+' is incompatible with quickedit request!')
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

  if xeToolMode in wbPluginModes then // look for the file name
    if not xeFindNextValidCmdLineModule(xeParamIndex, xePluginToUse, xeContext.Settings.DataPath) then begin
      ShowMessage(xeToolName+' mode requires a valid plugin name!');
      Exit(False);
    end;

  // specific Tool Mode settings overrides
  case xeToolMode of
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
      xeContext.Settings.MasterUpdateFilterONAM := xeToolMode in [tmESMify];
      if xeToolMode = tmOnamUpdate then begin
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
      if xeContext.GameDefObj.GameMode in [gmTES5, gmEnderal, gmFO4, gmSSE, gmTES5VR, gmEnderalSE, gmFO4VR, gmFO76, gmSF1] then
        xeContext.Settings.LoadBSAs := True; //needed for localization
      xeContext.Settings.TranslationMode := True;
      wbHideUnused             := True;
      xeContext.Settings.HideIgnored := True;
      wbHideNeverShow          := True;
    end;
  end;

  xeContext.Settings.IgnoreESMFlagForLoadOrder := xeToolMode in [tmMasterUpdate, tmMasterRestore];

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
    xeSubMode := 'Very Quick Show Conflicts'
  else if xeQuickShowConflicts then
    xeSubMode := 'Quick Show Conflicts'
  else if xeQuickCleanAutoSave then
    xeSubMode := 'Quick Auto Clean'
  else if xeQuickClean then
    xeSubMode := 'Quick Clean'
  else if xeAutoGameLink then
    xeSubMode := 'Auto Game Link';

  if not wbFindCmdLineParam('scripthost', s) then
    s := xeDefaultScriptHost;
  TxeScriptHost.Init(s);

  xeApplicationTitle := xeContext.GameDefObj.AppName + xeToolName + ' ' + VersionString;
  {$IFDEF LiteVersion}
  xeApplicationTitle := xeApplicationTitle + ' Lite';
  {$ENDIF}
  {$IFDEF WIN64}
  xeApplicationTitle := xeApplicationTitle + ' x64';
  {$ENDIF WIN64}
  if xeSubMode <> '' then
    xeApplicationTitle := xeApplicationTitle + ' (' + xeSubMode + ')';

  if xeAutoLoad then
    xeApplicationTitle := xeApplicationTitle + ' [Auto Load]';

  if xeAutoExit then
    xeApplicationTitle := xeApplicationTitle + ' [Auto Exit]';

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
    if (xeToolMode = tmEdit) and not wbIsAssociatedWithExtension('.' + xeContext.GameDefObj.AppName + 'pas') then
      wbAssociateWithExtension('.' + xeContext.GameDefObj.AppName + 'pas', xeContext.GameDefObj.AppName + 'Script', xeContext.GameDefObj.AppName + xeToolName + ' script');
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

function xeNexusModsUrl: string;
begin
  Result := xeContext.GameDefObj.NexusModsUrl;
  if (xeToolMode = tmLODgen) and (xeContext.GameDefObj.LODGenNexusModsUrl <> '') then
    Result := xeContext.GameDefObj.LODGenNexusModsUrl;
end;

procedure xeDumpInitState(const aFileName: string);

  function ValueText(const aValue: TValue): string;
  begin
    case aValue.Kind of
      tkClass: begin
        var lObject := aValue.AsObject;
        if not Assigned(lObject) then
          Result := 'nil'
        else if lObject is TEncoding then
          Result := lObject.ClassName + ':' + IntToStr(TEncoding(lObject).CodePage)
        else
          Result := lObject.ClassName;
      end;
      tkMethod:
        Result := BoolToStr(Assigned(PMethod(aValue.GetReferenceToRawData).Code), True);
      tkDynArray: begin
        Result := '';
        for var lIdx := 0 to Pred(aValue.GetArrayLength) do
          Result := Result + '|' + aValue.GetArrayElement(lIdx).ToString;
        Result := '[' + Copy(Result, 2, MaxInt) + ']';
      end;
    else
      Result := aValue.ToString;
    end;
  end;

var
  lLines         : TStringList;
  lRtti          : TRttiContext;
  lField         : TRttiField;
  lCapabilities  : string;
  lSettings      : TwbGameContextSettings;
  lDefineOptions : TwbGameDefineOptions;
begin
  lLines := TStringList.Create;
  try
    lLines.Add('host.GameMode=' + GetEnumName(TypeInfo(TwbGameMode), Ord(xeGameMode)));
    lLines.Add('host.ToolMode=' + GetEnumName(TypeInfo(TwbToolMode), Ord(xeToolMode)));
    lLines.Add('host.ToolName=' + xeToolName);
    var lIdentity := xeContext.GameDefObj.Identity;
    lLines.Add('host.AppName=' + lIdentity.AppName);
    lLines.Add('host.GameName=' + lIdentity.GameName);
    lLines.Add('host.GameExeName=' + lIdentity.GameExeName);
    lLines.Add('host.GameName2=' + lIdentity.GameName2);
    lLines.Add('host.GameNameReg=' + lIdentity.GameNameReg);
    lLines.Add('host.GameMasterEsm=' + lIdentity.GameMasterEsm);
    lLines.Add('host.GameSteamID=' + lIdentity.SteamID);
    lLines.Add('host.LightName=' + lIdentity.LightName);
    lLines.Add('host.ApplicationTitle=' + xeApplicationTitle);
    lLines.Add('host.IconResource=' + xeIconResource);
    lLines.Add('host.NexusModsUrl=' + xeNexusModsUrl);
    lLines.Add('def.GameMode=' + GetEnumName(TypeInfo(TwbGameMode), Ord(xeContext.GameDefObj.GameMode)));
    lLines.Add('def.AppName=' + xeContext.GameDefObj.AppName);
    lLines.Add('def.GameName=' + xeContext.GameDefObj.GameName);
    lLines.Add('def.GameExeName=' + xeContext.GameDefObj.GameExeName);
    lLines.Add('def.GameMasterEsm=' + xeContext.GameDefObj.GameMasterEsm);
    lCapabilities := '';
    for var lCapability := Low(TwbGameCapability) to High(TwbGameCapability) do
      if lCapability in xeContext.GameDefObj.Capabilities then
        lCapabilities := lCapabilities + ' ' + GetEnumName(TypeInfo(TwbGameCapability), Ord(lCapability));
    lLines.Add('def.Capabilities=' + Trim(lCapabilities));
    lLines.Add('def.HasSaveDef=' + BoolToStr(xeContext.GameDefObj.HasSaveDef, True));
    lRtti := TRttiContext.Create;
    lSettings := xeContext.Settings;
    for lField in lRtti.GetType(TypeInfo(TwbGameContextSettings)).GetFields do
      lLines.Add('settings.' + lField.Name + '=' + ValueText(lField.GetValue(@lSettings)));
    lDefineOptions := xeContext.GameDefObj.DefineOptions;
    for lField in lRtti.GetType(TypeInfo(TwbGameDefineOptions)).GetFields do
      lLines.Add('defineoptions.' + lField.Name + '=' + ValueText(lField.GetValue(@lDefineOptions)));
    lLines.SaveToFile(aFileName);
  finally
    lLines.Free;
  end;
end;

function xeDoInit: Boolean;
var
  s: string;
begin
  try
    Result := _DoInit;
    if Result and wbFindCmdLineParam('dumpinit', s) then begin
      xeDumpInitState(s);
      Result := False;
    end;
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

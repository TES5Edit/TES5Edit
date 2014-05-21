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

interface

var
  wbApplicationTitle   : string;
  wbTheGameIniFileName : String;
  wbProgramPath        : string;
  wbScriptsPath        : string;
  wbBackupPath         : string;
  wbTempPath           : string;
  wbMyGamesTheGamePath : string;
  wbPluginsFileName    : String;
  wbSettingsFileName   : string;
  wbModGroupFileName   : string;

  wbMasterUpdateDone : Boolean;
  wbDontSave         : Boolean;
  wbDontBackup       : Boolean = False;
  wbRemoveTempPath   : Boolean = True;


implementation

uses
  SysUtils,
  Windows,
  Registry,
  ShellApi,
  Dialogs,
  ShlObj,
  IOUtils,
  IniFiles,
  wbInterface,
  wbImplementation,
  wbDefinitionsTES4,
  wbDefinitionsTES3,
  wbDefinitionsFO3,
  wbDefinitionsFNV,
  wbDefinitionsTES5;

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

function wbFindCmdLineParam(const aSwitch : string;
                              out aValue  : string)
                                          : Boolean; overload;
begin
  Result := wbFindCmdLineParam(aSwitch, SwitchChars, True, aValue);
end;

// several ini settings should be read before record definitions
// they may affect definitions like wbSimpleRecords
// and should be overridden by command line parameters
procedure ReadSettings;
var
  Settings: TMemIniFile;
begin
  try
    Settings := TMemIniFile.Create(wbSettingsFileName);
    try
      wbLoadBSAs := Settings.ReadBool('Options', 'LoadBSAs', wbLoadBSAs);
      wbSimpleRecords := Settings.ReadBool('Options', 'SimpleRecords', wbSimpleRecords);
      wbShowFlagEnumValue := Settings.ReadBool('Options', 'ShowFlagEnumValue', wbShowFlagEnumValue);
      wbTrackAllEditorID := Settings.ReadBool('Options', 'TrackAllEditorID', wbTrackAllEditorID);
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
  //gmFNV, gmFO3, gmTES3, gmTES4, gmTES5
  ExeName : array[TwbGameMode] of string =
    ('FalloutNV.exe', 'Fallout3.exe', 'Morrowind.exe', 'Oblivion.exe', 'TESV.exe');
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

procedure DoInitPath;
const
  sBethRegKey             = '\SOFTWARE\Bethesda Softworks\';
  sBethRegKey64           = '\SOFTWARE\Wow6432Node\Bethesda Softworks\';
var
  s : String;
begin
  wbProgramPath := IncludeTrailingPathDelimiter(ExtractFilePath(ParamStr(0)));
  wbModGroupFileName := ChangeFileExt(ParamStr(0), '.modgroups');
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

      if not OpenKeyReadOnly(sBethRegKey + wbGameName + '\') then
        if not OpenKeyReadOnly(sBethRegKey64 + wbGameName + '\') then begin
          s := 'Fatal: Could not open registry key: ' + sBethRegKey + wbGameName + '\';
          if wbGameMode = gmTES5 then
            ShowMessage(s+#13+#10+'This can happen after Steam updates, run game''s launcher to restore registry settings');
          wbDontSave := True;
          Exit;
        end;

      wbDataPath := ReadString('Installed Path');

      if wbDataPath = '' then begin
        s := 'Fatal: Could not determine '+wbGameName+' installation path, no "Installed Path" registry key';
        if wbGameMode = gmTES5 then
          ShowMessage(s+#13+#10+'This can happen after Steam updates, run game''s launcher to restore registry settings');
        wbDontSave := True;
      end;
    finally
      Free;
    end;
    if wbDataPath <>'' then
      wbDataPath := IncludeTrailingPathDelimiter(wbDataPath) + 'Data\';
  end else
    wbDataPath := IncludeTrailingPathDelimiter(wbDataPath);

  if not wbFindCmdLineParam('I', wbTheGameIniFileName) then begin
    wbTheGameIniFileName := GetCSIDLShellFolder(CSIDL_PERSONAL);
    if wbTheGameIniFileName = '' then begin
      ShowMessage('Fatal: Could not determine my documents folder');
      Exit;
    end;
    wbMyGamesTheGamePath := wbTheGameIniFileName + 'My Games\'+ wbGameName +'\';

    if wbGameMode in [gmFO3, gmFNV] then
      wbTheGameIniFileName := wbMyGamesTheGamePath + 'Fallout.ini'
    else
      wbTheGameIniFileName := wbMyGamesTheGamePath + wbGameName + '.ini';
  end;

  wbPluginsFileName := '';
  if ParamCount >= 1 then begin
    wbPluginsFileName := ParamStr(ParamCount);
    if (Length(wbPluginsFileName) > 0) and (wbPluginsFileName[1] in SwitchChars) then
      wbPluginsFileName := '';
  end;

  if wbPluginsFileName = '' then begin
    wbPluginsFileName := GetCSIDLShellFolder(CSIDL_LOCAL_APPDATA);
    if wbPluginsFileName = '' then begin
      ShowMessage('Fatal: Could not determine the local application data folder');
      Exit;
    end;

    wbPluginsFileName := wbPluginsFileName + wbGameName + '\Plugins.txt';
  end;
  wbSettingsFileName := ChangeFileExt(wbPluginsFileName, '.'+LowerCase(wbAppName)+'viewsettings');

  wbBackupPath := '';
  if not (wbDontSave or wbFindCmdLineParam('B', wbBackupPath)) then begin
    wbBackupPath := wbDataPath + wbAppName + 'Edit Backups\';
    if not DirectoryExists(wbBackupPath) then
      if not ForceDirectories(wbBackupPath) then
        wbBackupPath := wbDataPath;
  end;
end;

function isMode(aMode: String): Boolean;
begin
  Result := FindCmdLineSwitch(aMode) or (Pos(Uppercase(aMode), UpperCase(ExtractFileName(ParamStr(0))))<>0);
end;

procedure wbDoInit;
var
  s: string;
begin
  wbReportMode := False;

  if isMode('Saves') then begin
    wbToolSource := tsSaves;
    wbSourceName := 'Saves';
  end else begin // defaults to plugin
    wbToolSource := tsPlugins;
    wbSourceName := 'Plugins';
  end;

  wbEditAllowed := True;
  wbDontSave    := False;
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
  end else if isMode('LODgen') then begin
    wbToolMode    := tmLODgen;
    wbToolName    := 'LODgen';
    wbEditAllowed := False;
    wbDontSave    := True;
  end else if isMode('Translate') then begin
    wbToolMode    := tmTranslate;
    wbToolName    := 'Trans';
  end else if isMode('Edit') then begin
    wbToolMode    := tmEdit;
    wbToolName    := 'Edit';
  end else begin
    ShowMessage('Application name must contain Edit, View, LODgen, MasterUpdate or MasterRestore to select mode.');
    Exit;
  end;

  if isMode('FNV') then begin
    wbGameMode := gmFNV;
    wbAppName := 'FNV';
    wbGameName := 'FalloutNV';
    if not (wbToolMode in [tmView, tmEdit, tmMasterUpdate, tmMasterRestore]) then begin
      ShowMessage('Application '+wbGameName+' does not currently supports '+wbToolName);
      Exit;
    end;
    if not (wbToolSource in [tsPlugins]) then begin
      ShowMessage('Application '+wbGameName+' does not currently supports '+wbSourceName);
      Exit;
    end;
  end else if isMode('FO3') then begin
    wbGameMode := gmFO3;
    wbAppName := 'FO3';
    wbGameName := 'Fallout3';
    if not (wbToolMode in [tmView, tmEdit, tmMasterUpdate, tmMasterRestore]) then begin
      ShowMessage('Application '+wbGameName+' does not currently supports '+wbToolName);
      Exit;
    end;
    if not (wbToolSource in [tsPlugins]) then begin
      ShowMessage('Application '+wbGameName+' does not currently supports '+wbSourceName);
      Exit;
    end;
  end else if isMode('TES3') then begin
    wbGameMode := gmTES3;
    wbAppName := 'TES3';
    wbGameName := 'Morrowind';
    if not (wbToolMode in []) then begin
      ShowMessage('Application '+wbGameName+' does not currently supports '+wbToolName);
      Exit;
    end;
    if not (wbToolSource in []) then begin
      ShowMessage('Application '+wbGameName+' does not currently supports '+wbSourceName);
      Exit;
    end;
  end else if isMode('TES4') then begin
    wbGameMode := gmTES4;
    wbAppName := 'TES4';
    wbGameName := 'Oblivion';
    if not (wbToolMode in [tmView, tmEdit, tmLODgen]) then begin
      ShowMessage('Application '+wbGameName+' does not currently supports '+wbToolName);
      Exit;
    end;
    if not (wbToolSource in [tsPlugins]) then begin
      ShowMessage('Application '+wbGameName+' does not currently supports '+wbSourceName);
      Exit;
    end;
  end else if isMode('TES5') then begin
    wbGameMode := gmTES5;
    wbAppName := 'TES5';
    wbGameName := 'Skyrim';
    if not (wbToolMode in [tmView, tmEdit, tmTranslate]) then begin
      ShowMessage('Application '+wbGameName+' does not currently supports '+wbToolName);
      Exit;
    end;
    if not (wbToolSource in [tsPlugins]) then begin
      ShowMessage('Application '+wbGameName+' does not currently supports '+wbSourceName);
      Exit;
    end;
  end else begin
    ShowMessage('Application name must contain FNV, FO3, TES4 or TES5 to select game.');
    Exit;
  end;

  DoInitPath;

  if isMode('FNV') then begin
    wbVWDInTemporary := True;
    wbLoadBSAs := False;
    ReadSettings;
  end else if isMode('FO3') then begin
    wbVWDInTemporary := True;
    wbLoadBSAs := False;
    ReadSettings;
  end else if isMode('TES3') then begin
    wbLoadBSAs := False;
    wbAllowInternalEdit := false;
    ReadSettings;
  end else if isMode('TES4') then begin
    wbLoadBSAs := True;
    wbAllowInternalEdit := false;
    ReadSettings;
  end else if isMode('TES5') then begin
    wbVWDInTemporary := True;
    wbLoadBSAs := True; // localization won't work otherwise
    wbHideIgnored := False; // to show Form Version
    ReadSettings;
  end else begin
    Exit;
  end;

  if wbGameMode = gmFNV then
    DefineFNV
  else if wbGameMode = gmFO3 then
    DefineFO3
  else if wbGameMode = gmTES3 then
    DefineTES3
  else if wbGameMode = gmTES4 then
    DefineTES4
  else if wbGameMode = gmTES5 then
    case wbToolSource of
      tsPlugins: DefineTES5;
    end
  else begin
    ShowMessage('Application name must contain FNV, FO3, TES4 or TES5 to select game.');
    Exit;
  end;

  wbLanguage := 'English';
  if wbFindCmdLineParam('l', s) then
    wbLanguage := s;

  if FindCmdLineSwitch('report') then
    wbReportMode := (DebugHook <> 0);
  if FindCmdLineSwitch('MoreInfoForIndex') then
    wbMoreInfoForIndex := true;

  if FindCmdLineSwitch('fixup') then
    wbAllowInternalEdit := True
  else if FindCmdLineSwitch('nofixup') then
    wbAllowInternalEdit := False;

  if FindCmdLineSwitch('skipbsa') then
    wbLoadBSAs := False
  else if FindCmdLineSwitch('forcebsa') then
    wbLoadBSAs := True;

  if FindCmdLineSwitch('showfixup') then
    wbShowInternalEdit := True
  else if FindCmdLineSwitch('hidefixup') then
    wbShowInternalEdit := False;

  if FindCmdLineSwitch('TrackAllEditorID') then
    wbTrackAllEditorID := True;

  if wbToolMode = tmLODgen then begin
    wbIKnowWhatImDoing := True;
    wbAllowInternalEdit := False;
    wbShowInternalEdit := False;
    wbLoadBSAs := True;
    wbBuildRefs := False;
  end else if wbToolMode = tmMasterUpdate then begin
    wbIKnowWhatImDoing := True;
    wbAllowInternalEdit := False;
    wbShowInternalEdit := False;
    wbLoadBSAs := False;
    wbBuildRefs := False;
    if FindCmdLineSwitch('filteronam') then
      wbMasterUpdateFilterONAM := True;
    if FindCmdLineSwitch('FixPersistence') then
      wbMasterUpdateFixPersistence := True
    else if FindCmdLineSwitch('NoFixPersistence') then
      wbMasterUpdateFixPersistence := False;
  end else if wbToolMode = tmMasterRestore then begin
    wbIKnowWhatImDoing := True;
    wbAllowInternalEdit := False;
    wbShowInternalEdit := False;
    wbLoadBSAs := False;
    wbBuildRefs := False;
  end else if wbToolMode = tmTranslate then begin
    wbTranslationMode := True;
  end;

  wbApplicationTitle := wbAppName + wbToolName + ' ' + VersionString;
  {$IFDEF LiteVersion}
  wbApplicationTitle := wbApplicationTitle + ' Lite';
  {$ENDIF}

  if FindCmdLineSwitch('fixuppgrd') then
    wbFixupPGRD := True;
  if FindCmdLineSwitch('IKnowWhatImDoing') then
    wbIKnowWhatImDoing := True;
end;

initialization
  wbDoInit;

end.

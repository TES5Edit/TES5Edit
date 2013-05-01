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
  wbApplicationTitle: string;

procedure wbDoInit;

implementation

uses
  SysUtils,
  Dialogs,
  ShlObj,
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
  Result := wbFindCmdLineParam(aSwitch, ['-', '/'], True, aValue);
end;

// several ini settings should be read before record definitions
// they make affect definitions like wbSimpleRecords
// and should be overridden by command line parameters
procedure ReadSettings;
var
  AppData, SettingsFileName: string;
  Settings: TMemIniFile;
begin
  SetLength(AppData, 260);
  SHGetSpecialFolderPath(0, PChar(AppData), CSIDL_LOCAL_APPDATA, True);
  SetLength(AppData, StrLen(PChar(AppData)));
  if (AppData <> '') then
    AppData := IncludeTrailingBackslash(AppData);

  SettingsFileName := AppData + wbGameName + '\Plugins.' + LowerCase(wbAppName) + 'viewsettings';
  try
    Settings := TMemIniFile.Create(SettingsFileName);
    try
      wbLoadBSAs := Settings.ReadBool('Options', 'LoadBSAs', wbLoadBSAs);
      wbSimpleRecords := Settings.ReadBool('Options', 'SimpleRecords', wbSimpleRecords);
    finally
      Settings.Free;
    end;
  finally
  end;
end;

procedure wbDoInit;
var
  s: string;
begin
  wbReportMode := False;

  if FindCmdLineSwitch('FNV') or SameText(Copy(ExtractFileName(ParamStr(0)), 1, 3), 'FNV') then begin
    wbGameMode := gmFNV;
    wbAppName := 'FNV';
    wbGameName := 'FalloutNV';
    wbVWDInTemporary := True;
    wbLoadBSAs := False;
    ReadSettings;
    DefineFNV;
  end else
  if FindCmdLineSwitch('FO3') or SameText(Copy(ExtractFileName(ParamStr(0)), 1, 3), 'FO3') then begin
    wbGameMode := gmFO3;
    wbAppName := 'FO3';
    wbGameName := 'Fallout3';
    wbVWDInTemporary := True;
    wbLoadBSAs := False;
    ReadSettings;
    DefineFO3;
  end else if FindCmdLineSwitch('TES3') or SameText(Copy(ExtractFileName(ParamStr(0)), 1, 4), 'TES3') then begin
    ShowMessage('TES3 - Morrowind is not supported yet.');
    Exit;
    wbGameMode := gmTES3;
    wbAppName := 'TES3';
    wbGameName := 'Morrowind';
    wbLoadBSAs := False;
    wbAllowInternalEdit := false;
    ReadSettings;
    DefineTES3;
  end else if FindCmdLineSwitch('TES4') or SameText(Copy(ExtractFileName(ParamStr(0)), 1, 4), 'TES4') then begin
    wbGameMode := gmTES4;
    wbAppName := 'TES4';
    wbGameName := 'Oblivion';
    wbLoadBSAs := True;
    wbAllowInternalEdit := false;
    ReadSettings;
    DefineTES4;
  end else if FindCmdLineSwitch('TES5') or SameText(Copy(ExtractFileName(ParamStr(0)), 1, 4), 'TES5') then begin
    wbGameMode := gmTES5;
    wbAppName := 'TES5';
    wbGameName := 'Skyrim';
    wbLanguage := 'English';
    if wbFindCmdLineParam('l', s) then
      wbLanguage := s;
    wbVWDInTemporary := True;
    wbLoadBSAs := True; // localization won't work otherwise
    wbHideIgnored := False; // to show Form Version
    ReadSettings;
    DefineTES5;
  end else begin
    ShowMessage('Application name must start with FNV, FO3, TES4 or TES5 to select mode.');
    Exit;
  end;

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

  wbApplicationTitle := wbAppName + 'View ' + VersionString;
  if FindCmdLineSwitch('lodgen') or SameText(ExtractFileName(ParamStr(0)), wbAppName + 'LODGen.exe') then begin
    if wbGameMode <> gmTES4 then begin
      ShowMessage('LODGen mode is only possible for TES4.');
      Exit;
    end;
    wbApplicationTitle := wbAppName + 'LODGen ' + VersionString;
    wbEditAllowed := False;
    wbDontSave := True;
    wbMasterUpdate := False;
    wbLODGen := True;
    wbIKnowWhatImDoing := True;
    wbAllowInternalEdit := False;
    wbShowInternalEdit := False;
    wbLoadBSAs := True;
    wbBuildRefs := False;
  end else if FindCmdLineSwitch('masterupdate') or SameText(ExtractFileName(ParamStr(0)), wbAppName + 'MasterUpdate.exe') then begin
    if not (wbGameMode in [gmFO3, gmFNV]) then begin
      ShowMessage('MasterUpdate mode is only possible for FO3 and FNV.');
      Exit;
    end;
    wbApplicationTitle := wbAppName + 'MasterUpdate ' + VersionString;
    wbEditAllowed := True;
    wbMasterUpdate := True;
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
  end else if FindCmdLineSwitch('masterrestore') or SameText(ExtractFileName(ParamStr(0)), wbAppName + 'MasterRestore.exe') then begin
    if not (wbGameMode in [gmFO3, gmFNV]) then begin
      ShowMessage('MasterRestore mode is only possible for FO3 and FNV.');
      Exit;
    end;
    wbApplicationTitle := wbAppName + 'MasterRestore ' + VersionString;
    wbEditAllowed := True;
    wbMasterUpdate := True;
    wbMasterRestore := True;
    wbIKnowWhatImDoing := True;
    wbAllowInternalEdit := False;
    wbShowInternalEdit := False;
    wbLoadBSAs := False;
    wbBuildRefs := False;
  end else if FindCmdLineSwitch('edit') or SameText(ExtractFileName(ParamStr(0)), wbAppName + 'Edit.exe') then begin
    wbApplicationTitle := wbAppName + 'Edit ' + VersionString;
    wbEditAllowed := True;
  end else if FindCmdLineSwitch('translate') or SameText(ExtractFileName(ParamStr(0)), wbAppName + 'Trans.exe') then begin
    wbApplicationTitle := wbAppName + 'Trans ' + VersionString;
    wbEditAllowed := True;
    wbTranslationMode := True;
  end else
    wbDontSave := True;
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

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

// JCL_DEBUG_EXPERT_INSERTJDBG ON
// JCL_DEBUG_EXPERT_GENERATEJDBG ON
// JCL_DEBUG_EXPERT_DELETEMAPFILE ON
program TES5Dump;

{$I Compilers.inc}

{$APPTYPE CONSOLE}

uses
  Classes,
  SysUtils,
  Windows,
  wbDefinitionsFNV in 'wbDefinitionsFNV.pas',
  wbDefinitionsFO3 in 'wbDefinitionsFO3.pas',
  wbDefinitionsTES3 in 'wbDefinitionsTES3.pas',
  wbDefinitionsTES4 in 'wbDefinitionsTES4.pas',
  wbDefinitionsTES5 in 'wbDefinitionsTES5.pas',
  wbImplementation in 'wbImplementation.pas',
  wbInterface in 'wbInterface.pas',
  wbLocalization in 'wbLocalization.pas',
  wbSavedGames in 'wbSavedGames.pas',
  wbTES5ScriptDef in 'wbTES5ScriptDef.pas',
  wbBSA in 'wbBSA.pas';

const
  IMAGE_FILE_LARGE_ADDRESS_AWARE = $0020;

{$SetPEFlags IMAGE_FILE_LARGE_ADDRESS_AWARE}

var
  StartTime  : TDateTime;
  DumpGroups : TStringList;

procedure ReportProgress(const aStatus: string);
begin
  WriteLn(ErrOutput, FormatDateTime('<nn:ss.zzz>', Now - StartTime), ' ', aStatus);
end;

procedure WriteElement(aElement: IwbElement; aIndent: string = ''); forward;

procedure WriteContainer(aContainer: IwbContainer; aIndent: string = '');
var
  i            : Integer;
  GroupRecord  : IwbGroupRecord;
  ContainerRef : IwbContainerElementRef;
begin
  if (aContainer.ElementType = etGroupRecord) then
    if Supports(aContainer, IwbGroupRecord, GroupRecord) then
      if GroupRecord.GroupType = 0 then begin
        if Assigned(DumpGroups) and not DumpGroups.Find(TwbSignature(GroupRecord.GroupLabel), i) then
          Exit;
        ReportProgress('Dumping: ' + GroupRecord.Name);
      end;

  if aContainer.Skipped then begin
    if not wbReportMode then WriteLn(aIndent, '<contents skipped>');
  end else begin
    Supports(aContainer, IwbContainerElementRef, ContainerRef);
    for i := 0 to Pred(aContainer.ElementCount) do
      WriteElement(aContainer.Elements[i], aIndent);
  end;
end;

procedure WriteElement(aElement: IwbElement; aIndent: string = '');
var
  Container   : IwbContainer;
  Name        : string;
  Value       : string;

  i            : Integer;
  GroupRecord  : IwbGroupRecord;
begin
  if Assigned(DumpGroups) and (aElement.ElementType = etGroupRecord) then
    if Supports(aElement, IwbGroupRecord, GroupRecord) then
      if GroupRecord.GroupType = 0 then
        if not DumpGroups.Find(TwbSignature(GroupRecord.GroupLabel), i) then
          Exit;

  Name := aElement.Name;
  Value := aElement.Value;

  if (Name <> '') or (Value <> '') then begin
    if not wbReportMode then
      Write(aIndent, Name);
    aIndent := aIndent + '  ';
    if Value <> '' then begin
      if not wbReportMode then
        WriteLn(': ', Value);
    end else begin
      if not wbReportMode then
        WriteLn;
    end;
  end;

  if Supports(aElement, IwbContainer, Container) then
    WriteContainer(Container, aIndent);
end;

{==============================================================================}
function CheckForErrors(const aIndent: Integer; const aElement: IwbElement): Boolean;
var
  Error                       : string;
  Container                   : IwbContainerElementRef;
  i                           : Integer;
begin
  Error := aElement.Check;
  Result := Error <> '';
  if Result then
    WriteLn(StringOfChar(' ', aIndent * 2) + aElement.Name, ' -> ', Error);

  if Supports(aElement, IwbContainerElementRef, Container) then
    for i := Pred(Container.ElementCount) downto 0 do
      Result := CheckForErrors(aIndent + 1, Container.Elements[i]) or Result;

  if Result and (Error = '') then
    WriteLn(StringOfChar(' ', aIndent * 2), 'Above errors were found in: ', aElement.Name);
end;
{==============================================================================}


{==============================================================================}
function wbFindCmdLineSwitch(const aSwitch: string): Boolean;
begin
  Result := FindCmdLineSwitch(aSwitch, ['-', '/'], True);
end;
{------------------------------------------------------------------------------}
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
{------------------------------------------------------------------------------}
function wbFindCmdLineParam(const aSwitch : string;
                              out aValue  : string)
                                          : Boolean; overload;
begin
  Result := wbFindCmdLineParam(aSwitch, ['-', '/'], True, aValue);
end;
{==============================================================================}

var
  NeedsSyntaxInfo : Boolean;
  s               : string;
  _File           : IwbFile;
  Masters         : TStringList;
begin
  SysUtils.DecimalSeparator := '.';
  wbProgressCallback := ReportProgress;
  wbAllowInternalEdit := False;
  wbMoreInfoForUnknown := False;

  try
    if wbFindCmdLineSwitch('TES5') or SameText(Copy(ExtractFileName(ParamStr(0)), 1, 4), 'TES5') then begin
      wbGameMode := gmTES5;
      wbAppName := 'TES5';
      wbGameName := 'Skyrim';
      DefineTES5;
    end else if wbFindCmdLineSwitch('FNV') or SameText(Copy(ExtractFileName(ParamStr(0)), 1, 3), 'FNV') then begin
      wbGameMode := gmFNV;
      wbAppName := 'FNV';
      wbGameName := 'FalloutNV';
      DefineFNV;
    end else if wbFindCmdLineSwitch('FO3') or SameText(Copy(ExtractFileName(ParamStr(0)), 1, 3), 'FO3') then begin
      wbGameMode := gmFO3;
      wbAppName := 'FO3';
      wbGameName := 'Fallout3';
      DefineFO3;
    end else if wbFindCmdLineSwitch('TES4') or SameText(Copy(ExtractFileName(ParamStr(0)), 1, 4), 'TES4') then begin
      wbGameMode := gmTES4;
      wbAppName := 'TES4';
      wbGameName := 'Oblivion';
      DefineTES4;
    end else begin
      WriteLn(ErrOutput, 'Application name must start with FNV, FO3, TES4, TES5 to select mode.');
      Exit;
    end;

    if not wbFindCmdLineSwitch('q') and not wbReportMode then begin
      WriteLn(ErrOutput, wbAppName, 'Dump ', VersionString);
      WriteLn(ErrOutput);

      WriteLn(ErrOutput, 'This Program is subject to the Mozilla Public License');
      WriteLn(ErrOutput, 'Version 1.1 (the "License"); you may not use this program except in');
      WriteLn(ErrOutput, 'compliance with the License. You may obtain a copy of the License at');
      WriteLn(ErrOutput, 'http://www.mozilla.org/MPL/');
      WriteLn(ErrOutput);
      WriteLn(ErrOutput, 'Software distributed under the License is distributed on an "AS IS"');
      WriteLn(ErrOutput, 'basis, WITHOUT WARRANTY OF ANY KIND, either express or implied. See the');
      WriteLn(ErrOutput, 'License for the specific language governing rights and limitations');
      WriteLn(ErrOutput, 'under the License.');
      WriteLn(ErrOutput);
    end;

    if wbFindCmdLineParam('dg', s) then begin
      DumpGroups := TStringList.Create;
      DumpGroups.Sorted := True;
      DumpGroups.Duplicates := dupIgnore;
      DumpGroups.CommaText := s;
      DumpGroups.Sort;
    end;

    if wbFindCmdLineSwitch('more') then
      wbMoreInfoForUnknown:= True
    else
      wbMoreInfoForUnknown:= False;

    if wbFindCmdLineParam('xr', s) then
      RecordToSkip.CommaText := s
    else begin
//    RecordToSkip.Add('LAND');
//    RecordToSkip.Add('REGN');
//    RecordToSkip.Add('PGRD');
//      RecordToSkip.Add('SCEN');
//      RecordToSkip.Add('PACK');
//      RecordToSkip.Add('PERK');
//      RecordToSkip.Add('NAVI');
//      RecordToSkip.Add('CELL');
//      RecordToSkip.Add('WRLD');
//      RecordToSkip.Add('REFR');
    end;

    if wbFindCmdLineParam('xg', s) then
      GroupToSkip.CommaText := s
    else begin
//    GroupToSkip.Add('LAND');
//    GroupToSkip.Add('REGN');
//    GroupToSkip.Add('PGRD');
//      GroupToSkip.Add('SCEN');
//      GroupToSkip.Add('PACK');
//      GroupToSkip.Add('PERK');
//      GroupToSkip.Add('NAVI');
//      GroupToSkip.Add('CELL');
//      GroupToSkip.Add('WRLD');
    end;

    s := ParamStr(ParamCount);

    NeedsSyntaxInfo := False;
    if (ParamCount >= 1) and not FileExists(s) then begin
      if s[1] in ['-', '/'] then
        WriteLn(ErrOutput, 'No inputfile was specified. Please check the command line parameters.')
      else
        WriteLn(ErrOutput, 'Can''t find the file "',s,'". Please check the command line parameters.');
      WriteLn;
      NeedsSyntaxInfo := True;
    end;

    if NeedsSyntaxInfo or (ParamCount < 1) or wbFindCmdLineSwitch('?') or wbFindCmdLineSwitch('help') then begin
      WriteLn(ErrOutput, 'Syntax:  '+wbAppName+'Dump [options] inputfile');
      WriteLn(ErrOutput);
      WriteLn(ErrOutput, wbAppName + 'Dump will load the specified esp/esm files and all it''s masters and will dump the decoded contents of the specified file to stdout. Masters are searched for in the same directory as the specified file.');
      WriteLn(ErrOutput);
      WriteLn(ErrOutput, 'You can use the normal redirect mechanism to send the output to a file.');
      WriteLn(ErrOutput, 'e.g. "'+wbAppName+'Dump '+wbGameName+'.esm > '+wbGameName+'.txt"');
      WriteLn(ErrOutput);
      WriteLn(ErrOutput, 'Currently supported options:');
      WriteLn(ErrOutput, '-? / -help   ', 'This help screen');
      WriteLn(ErrOutput, '-q           ', 'Suppress version message');
      WriteLn(ErrOutput, '-xr:list     ', 'Excludes the contents of specified records from being');
      WriteLn(ErrOutput, '             ', 'decompressed and processed. When not specified the');
      WriteLn(ErrOutput, '             ', 'following default value applies:');
      WriteLn(ErrOutput, '             ', 'REFR');
      WriteLn(ErrOutput, '-xg:list     ', 'Excludes complete top level groups from being processed');
      WriteLn(ErrOutput, '             ', 'When not specified the following default value applies:');
      WriteLn(ErrOutput, '             ', 'SCEN, PACK, PERK, NAVI, CELL, WRLD');
      WriteLn(ErrOutput, '-dg:list     ', 'If specified, only dump the listed top level groups');
      WriteLn(ErrOutput, '-check       ', 'Performs "Check for Errors" instead of dumping content');
      WriteLn(ErrOutput, '             ', '');
      Exit;
    end;

    StartTime := Now;

    _File := wbFile(s);

    ReportProgress('Finished loading record. Starting Dump.');

    if wbFindCmdLineSwitch('check') and not wbReportMode then
      CheckForErrors(0, _File)
    else
      WriteContainer(_File);

    if wbReportMode then
      ReportDefs;

    ReportProgress('All Done.');
  except
    on e: Exception do
      WriteLn(ErrOutput, 'Unexpected Error: <',e.ClassName, ': ', e.Message,'>');
  end;
  if wbReportMode or (DebugHook <> 0) then
    ReadLn;
end.

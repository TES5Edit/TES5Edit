{******************************************************************************

  This Source Code Form is subject to the terms of the Mozilla Public License,
  v. 2.0. If a copy of the MPL was not distributed with this file, You can obtain
  one at https://mozilla.org/MPL/2.0/.

*******************************************************************************}

{$I xdDefines.inc}

{$IFDEF EXCEPTION_LOGGING_ENABLED}
// JCL_DEBUG_EXPERT_GENERATEJDBG OFF
// JCL_DEBUG_EXPERT_INSERTJDBG ON
// JCL_DEBUG_EXPERT_DELETEMAPFILE ON
{$ENDIF}

program xDump;

{$APPTYPE CONSOLE}

uses
  {$IFDEF EXCEPTION_LOGGING_ENABLED}
  nxExceptionHook,
  {$ENDIF}
  TypInfo,
  Classes,
  SysUtils,
  Windows,
  Registry,
  IniFiles,
  ZlibEx,
  lz4,
  wbBSA in 'Core\wbBSA.pas',
  wbCommandLine in 'Core\wbCommandLine.pas',
  wbSort in 'Core\wbSort.pas',
  wbInterface in 'Core\wbInterface.pas',
  wbSaveInterface in 'Core\wbSaveInterface.pas',
  wbImplementation in 'Core\wbImplementation.pas',
  wbLocalization in 'Core\wbLocalization.pas',
  wbHelpers in 'Core\wbHelpers.pas',
  wbLoadOrder in 'Core\wbLoadOrder.pas',
  wbHardcoded in 'Core\wbHardcoded.pas',
  wbDefinitionsCommon in 'Core\wbDefinitionsCommon.pas',
  wbDefinitionsFNV in 'Core\wbDefinitionsFNV.pas',
  wbDefinitionsFNVSaves in 'Core\wbDefinitionsFNVSaves.pas',
  wbDefinitionsFO3 in 'Core\wbDefinitionsFO3.pas',
  wbDefinitionsFO3Saves in 'Core\wbDefinitionsFO3Saves.pas',
  wbDefinitionsFO4 in 'Core\wbDefinitionsFO4.pas',
  wbDefinitionsFO4Saves in 'Core\wbDefinitionsFO4Saves.pas',
  wbDefinitionsFO76 in 'Core\wbDefinitionsFO76.pas',
  wbDefinitionsTES3 in 'Core\wbDefinitionsTES3.pas',
  wbDefinitionsTES4 in 'Core\wbDefinitionsTES4.pas',
  wbDefinitionsTES4Saves in 'Core\wbDefinitionsTES4Saves.pas',
  wbDefinitionsTES5 in 'Core\wbDefinitionsTES5.pas',
  wbDefinitionsTES5Saves in 'Core\wbDefinitionsTES5Saves.pas';

{$R *.res}
{$MAXSTACKSIZE 2097152}

const
  IMAGE_FILE_LARGE_ADDRESS_AWARE = $0020;

{$SetPEFlags IMAGE_FILE_LARGE_ADDRESS_AWARE}

var
  StartTime       : TDateTime;
  DumpGroups      : TStringList;
  SkipChildGroups : TStringList;
  DumpChapters    : TStringList;
  DumpForms       : TStringList;
  DumpCount       : Integer;
  DumpMax         : Integer;
  DumpCheckReport : Boolean = False;
  DumpSize        : Boolean = False;
  DumpHidden      : Boolean = False;

procedure ReportProgress(const aStatus: string);
begin
  WriteLn(ErrOutput, FormatDateTime('<hh:nn:ss.zzz>', Now - StartTime), ' ', aStatus);
end;

type
  TExportFormat = (efUESPWiki, efRaw);
  TwbDefProfile = string;
  TwbExportPass = ( epRead, epSimple, epShared, epChapters, epRemaining, epNothing);
var
  wbDefProfiles : TStringList = nil;
function StrToTExportFormat(aFormat: string): TExportFormat;
begin
  Result := efRaw;
  if Uppercase(aFormat)='RAW' then
    Result := efRaw
  else if Uppercase(aFormat)='UESPWIKI' then
    Result := efUESPWiki;
end;

function UESPName(aName: String): String;
begin
  while Pos(' ', aName)>0 do
    aName[Pos(' ', aName)] := '_';
  Result := aName;
end;

function UESPType(aType: String): String;

  function UESParrayType(aType: String): String; forward;

  function UESPsingleType(aType, aStandard, aResult: String): String;
  var
    i: Integer;
    l: Integer;
  begin
    i := Pos(UpperCase(aStandard), Uppercase(aType));
    if i>0 then begin
      Result := '';
      l := Length(aStandard);
      if i>1 then begin
        Result := Copy(aType, 1, i-1);
        Delete(aType, 1, i+l-1);
      end else
        Delete(aType, 1, l);
      Result := Result + aResult + aType;
    end else
      Result := aType;
  end;

  function UESParrayCount(aType: String): String;
  var
    i: Integer;
    c: String;
  begin
    i := Pos('_', aType);
    if i>1 then begin
      c := Copy(aType, 1, i-1);
      Delete(aType, 1, i);
    end else
      c := '';
    Result := '_'+aType+'['+c+']';
  end;

  function UESParrayType(aType: String): String;
  const
    cArray = '_ARRAY';
    cof = '_OF_';
  var
    i: Integer;
    j : Integer;
    l: Integer;
    t: String;
  begin
    i := Pos(cArray, UpperCase(aType));
    l := Length(cArray);
    if (i>0) and ((i+l-1) = Length(aType)) then begin
      Delete(aType, i, l);
      j := Pos(cOf, UpperCase(aType));
      if j>1 then begin
        Result := Copy(aType, 1, j-1);
        Delete(aType, 1, j+Length(cOf)-1);
        t := UESParrayCount(aType);
        Result := Result + t;
      end;
    end else
      Result := aType;
  end;

begin
  Result := UESPName(aType);
  Result := UESParrayType(Result);

  Result := UESPsingleType(Result, 'Unsigned_Bytes', 'uint8');
  Result := UESPsingleType(Result, 'Signed_Bytes', 'int8');
  Result := UESPsingleType(Result, 'Bytes', 'int8');
  Result := UESPsingleType(Result, 'Unsigned_Byte', 'uint8');
  Result := UESPsingleType(Result, 'Signed_Byte', 'int8');
  Result := UESPsingleType(Result, 'Byte', 'int8');
  Result := UESPsingleType(Result, 'Unsigned_DWord', 'uint32');
  Result := UESPsingleType(Result, 'Signed_DWord', 'int32');
  Result := UESPsingleType(Result, 'DWord', 'int32');
  Result := UESPsingleType(Result, 'Unsigned_Word', 'uint16');
  Result := UESPsingleType(Result, 'Signed_Word', 'int16');
  Result := UESPsingleType(Result, 'Word', 'int16');
  Result := UESPsingleType(Result, 'Float', 'float32');

  Result := UESPsingleType(Result, 'FormID', 'formid');
end;

const
  UESPWikiTable = '{| class="wikitable" border="1" width="100%"'+#13+#10+
  '! width="3%" | [[Tes5Mod:File Format Conventions|C]]'+#13+#10+
  '! width="10%" | SubRecord'+#13+#10+
  '! width="15%" | Name'+#13+#10+
  '! width="15%" | [[Tes5Mod:File Format Conventions|Type/Size]]'+#13+#10+
  '! width="57%" | Info';
  UESPWikiClose ='|}'+#13+#10;

function AnchorProfile(aFormat: TExportFormat; aIndent, aProfile: String; useProfile: Boolean; aName, aType: String): String;
begin
  case aFormat of
    efUESPWiki: begin
      if aIndent='' then
        Result := '=== [[Tes5Mod:Save File Format/'+aProfile+'|'+UESPName(aName)+']] ==='+#13+#10+UESPWikiTable
      else begin
        Result := '|-'+#13+#10+'|'+UESPName(aName)+#13+#10+'|';
        if useProfile then
          Result := Result+'[[Tes5Mod:Save File Format/'+aProfile+'|'+UESPType(aType)+']]'
        else
          Result := Result+UESPType(aType);
        Result := Result+#13+#10+'|';
      end;
    end;
    efRaw: begin
      Result := aIndent+aName+' as '+aType;
      if useProfile then Result := Result+' ['+aProfile+']';
    end;
  end;
end;

procedure AddProfile(aProfile: String);
var
  i       : Integer;
begin
  i := wbDefProfiles.IndexOf(aProfile);
  if i >= 0 then begin
    wbDefProfiles.Objects[i] := Pointer(Integer(wbDefProfiles.Objects[i])+1);
  end else begin
    wbDefProfiles.AddObject(aProfile, Pointer(1));
  end;
end;

function FindProfile(aProfile: String): Integer;
var
  i       : Integer;
begin
  i := wbDefProfiles.IndexOf(aProfile);
  if i >= 0 then begin
    Result := Integer(wbDefProfiles.Objects[i]);
  end else
    Result := 0;
end;

procedure MarkProfile(aProfile: String);
var
  i       : Integer;
begin
  i := wbDefProfiles.IndexOf(aProfile);
  if i >= 0 then
    wbDefProfiles.Objects[i] := Pointer(-1);
end;

procedure LockProfile(aProfile: String);
var
  i       : Integer;
begin
  i := wbDefProfiles.IndexOf(aProfile);
  if i >= 0 then
    wbDefProfiles.Objects[i] := Pointer(-2);
end;

procedure ProfileContainer(aFormat: TExportFormat; aElement: IwbNamedDef; var aProfile: String;
  Pass: TwbExportPass; aIndent: String); forward;

procedure ExportElement(aFormat: TExportFormat; aElement: IwbNamedDef; var aProfile: String;
  Pass: TwbExportPass; aIndent: string = ''); forward;

procedure ExportContainer(aFormat: TExportFormat; aElement: IwbNamedDef; var aProfile: String;
  Pass: TwbExportPass; aIndent: String; skipFirst: Boolean);
var
  i       : Integer;
  j       : Integer;
  Profile : String;
begin
  case aElement.DefType of
    dtSubRecordStruct,
    dtSubRecordUnion,
    dtRecord :
      with aElement as IwbRecordDef do
        for i := 0 to Pred(MemberCount) do begin
          Profile := '';
          ExportElement(aFormat, Members[i], Profile, Pass, aIndent);
          aProfile := aProfile + Profile;
        end;
    dtSubRecord :
      with aElement as IwbSubRecordDef do begin
        Profile := '';
        ExportElement(aFormat, Value, Profile, Pass, aIndent);
        aProfile := aProfile + Profile;
      end;
    dtString,
    dtLString,
    dtLenString,
    dtByteArray,
    dtInteger,
    dtIntegerFormater,
    dtFloat : ;
    dtSubRecordArray :
      with aElement as IwbSubRecordArrayDef do begin
        Profile := '';
        ExportElement(aFormat, Element, Profile, Pass, aIndent);
        aProfile := aProfile + Profile;
      end;
    dtArray :
      with aElement as IwbArrayDef do begin
        Profile := '';
        ExportElement(aFormat, Element, Profile, Pass, aIndent);
        aProfile := aProfile + Profile;
      end;
    dtStruct,
    dtStructChapter :
      with aElement as IwbStructDef do
        for i := 0 to Pred(MemberCount) do begin
          Profile := '';
          ExportElement(aFormat, Members[i], Profile, Pass, aIndent);
          aProfile := aProfile + Profile;
        end;
    dtUnion :
      with aElement as IwbUnionDef do begin
        if skipFirst then j := 1 else j := 0;
        for i := j to Pred(MemberCount) do begin
          Profile := '';
          ExportElement(aFormat, Members[i], Profile, Pass, aIndent);
          aProfile := aProfile + Profile;
        end;
      end;
    dtEmpty: ;
  end;
end;

procedure ExportElement(aFormat: TExportFormat; aElement: IwbNamedDef; var aProfile: String;
  Pass: TwbExportPass; aIndent: string = '');
var
  doIt       : Boolean;
  skipFirst  : Boolean;
  theElement : IwbNamedDef;
  theIndent  : String;
  Profile    : String;
begin
  doIt := False;
  skipFirst := False;
  theElement := aElement;
  if aElement.defType in dtArrays then begin
    case aElement.DefType of
      dtArray: with aElement as IwbArrayDef do begin
        doIt := Element.DefType in dtNonValues;
        theElement := Element;
      end;
      dtSubRecordArray: with aElement as IwbSubRecordArrayDef do begin
        doIt := Element.DefType in dtNonValues;
      end;
    end;
  end else if aElement.defType in [dtSubrecord] then begin
    with aElement as IwbSubRecordDef do begin
      doIt := Value.DefType in dtNonValues;
      theElement := Value;
    end;
  end else if aElement.defType in [dtUnion] then begin
    with aElement as IwbUnionDef do if MemberCount>0 then begin
      doIt := True;
      skipFirst := Members[0].DefTypeName = 'Null';
    end;
  end else if (aElement.defType in dtNonValues) then
    doIt := True;

  Profile := ':' + wbDefToName(aElement)+'='+aElement.DefTypeName;
  aProfile := aProfile + Profile;
  if doIt then begin
    Profile := '';
    ProfileContainer(aFormat, theElement, Profile, Pass, aIndent);
    aProfile := aProfile + Profile;
  end;
  Write(AnchorProfile(aFormat, aIndent, aProfile, doIt, wbDefToName(aElement), aElement.DefTypeName));
  if skipFirst then Write(' Present only if ...');
  WriteLn;
  theIndent := aIndent + '  ';
  if ((aIndent='') or (FindProfile(aProfile)<>-1)) and doIt then begin
    Profile := '';
    ExportContainer(aFormat, theElement, Profile, Pass, theIndent, skipFirst);
  end;
  if aIndent = '' then begin
    case aFormat of
      efUESPWiki: Write(UESPWikiClose);
    end;
    WriteLN;
  end;
end;

procedure ProfileElement(aFormat: TExportFormat; aElement: IwbNamedDef; var aProfile: String;
  Pass: TwbExportPass; aIndent: String); forward;

procedure ProfileContainer(aFormat: TExportFormat; aElement: IwbNamedDef; var aProfile: String;
  Pass: TwbExportPass; aIndent: String);
var
  i       : Integer;
  Profile : string;
begin
  Profile := '';
  case aElement.DefType of
    dtSubRecordStruct,
    dtSubRecordUnion,
    dtRecord :
      with aElement as IwbRecordDef do
        for i := 0 to Pred(MemberCount) do begin
          Profile := '';
          ProfileElement(aFormat, Members[i], Profile, Pass, aIndent);
          aProfile := aProfile + Profile;
        end;
    dtSubRecord :
      with aElement as IwbSubRecordDef do begin
        Profile := '';
        ProfileElement(aFormat, Value, profile, Pass, aIndent);
        aProfile := aProfile + Profile;
      end;
    dtString,
    dtLString,
    dtLenString,
    dtByteArray,
    dtInteger,
    dtIntegerFormater,
    dtFloat : ;
    dtSubRecordArray :
      with aElement as IwbSubRecordArrayDef do begin
        Profile := '';
        ProfileElement(aFormat, Element, Profile, Pass, aIndent);
        aProfile := aProfile + Profile;
      end;
    dtArray :
      with aElement as IwbArrayDef do begin
        Profile := '';
        ProfileElement(aFormat, Element, Profile, Pass, aIndent);
        aProfile := aProfile + Profile;
      end;
    dtStruct,
    dtStructChapter :
      with aElement as IwbStructDef do
        for i := 0 to Pred(MemberCount) do begin
          Profile := '';
          ProfileElement(aFormat, Members[i], Profile, Pass, aIndent);
          aProfile := aProfile + Profile;
        end;
    dtUnion :
      with aElement as IwbUnionDef do
        for i := 0 to Pred(MemberCount) do begin
          Profile := '';
          ProfileElement(aFormat, Members[i], Profile, Pass, aIndent);
          aProfile := aProfile + Profile;
        end;
    dtEmpty: ;
  end;
end;

procedure ProfileElement(aFormat: TExportFormat; aElement: IwbNamedDef; var aProfile: String; Pass: TwbExportPass;
  aIndent: String);
var
  Profile    : String;
  doIt       : Boolean;
  doubleIt   : Boolean;
  theElement : IwbNamedDef;
  n          : Integer;

  procedure doFindSimpleProfile(aProfile: String);
  begin
    n := FindProfile(aProfile);
    if not (aElement.DefType in dtNonValues) and (n>1) then begin
      LockProfile(aProfile);
    end;
  end;

  procedure doFindSharedProfile(aProfile: String);
  begin
    if (aElement.DefType in [dtStruct, dtSubRecordStruct]) and (FindProfile(aProfile)>0) then begin
      MarkProfile(aProfile);
      ExportElement(aFormat, aElement, Profile, Pass, aIndent);
    end;
    if (aElement.DefType in [dtUnion, dtSubRecordUnion]) and (FindProfile(aProfile)>1) then begin
      MarkProfile(aProfile);
      ExportElement(aFormat, aElement, Profile, Pass, aIndent);
    end;
  end;

  procedure doFindChaptersProfile(aProfile: String);
  begin
    if (aElement.DefType in [dtRecord, dtStructChapter]) then begin
      MarkProfile(aProfile);
      ExportElement(aFormat, aElement, Profile, Pass, aIndent);
    end;
  end;

  procedure doFindProfile(aProfile: String);
  begin
    if FindProfile(aProfile)>0 then begin
      MarkProfile(aProfile);
    end;
  end;

  procedure CheckPass(Pass: TwbExportPass; aProfile: String);
  begin
    Profile := '';
    case Pass of
      epRead:      AddProfile(aProfile);
      epSimple:    doFindSimpleProfile(aProfile);
      epShared:    doFindSharedProfile(aProfile);
      epChapters:  doFindChaptersProfile(aProfile);
      epRemaining: doFindProfile(aProfile);
    end;
  end;

begin
  if not Assigned(wbDefProfiles) then begin
    wbDefProfiles := TStringList.Create;
    wbDefProfiles.Sorted := True;
    wbDefProfiles.Duplicates := dupIgnore;
  end;

  Profile := ':' + wbDefToName(aElement)+'='+aElement.DefTypeName;
  aProfile := aProfile + Profile;

  doIt := False;
  doubleIt := False;
  theElement := aElement;
  if aElement.defType in dtArrays then begin
    case aElement.DefType of
      dtArray: with aElement as IwbArrayDef do begin
        doIt := Element.DefType in dtNonValues;
        doubleIt := doIt;
        theElement := Element;
      end;
      dtSubRecordArray: with aElement as IwbSubRecordArrayDef do begin
        doIt := Element.DefType in dtNonValues;
        doubleIt := doIt;
      end;
    end;
  end else if aElement.defType in [dtSubrecord] then begin
    with aElement as IwbSubRecordDef do begin
      doIt := Value.DefType in dtNonValues;
      theElement := Value;
    end;
  end else if (aElement.defType in dtNonValues) then
    doIt := True;
  if doIt then begin
    Profile := '';
    ProfileContainer(aFormat, theElement, Profile, Pass, aIndent);
    aProfile := aProfile + Profile;
    if doubleIt then begin
      Profile := '';
      ProfileContainer(aFormat, theElement, Profile, Pass, aIndent);
      aProfile := aProfile + Profile;
    end;

  end;
  CheckPass(Pass, aProfile);
end;

procedure ProfileHeader(aFormat: TExportFormat; Pass: TwbExportPass);
var
  RecordDef : PwbMainRecordDef;
  Profile   : String;
begin
  Profile := '';
  case wbToolSource of
    tsPlugins: begin
      if wbFindRecordDef(wbHeaderSignature, RecordDef) then
        ProfileElement(aFormat, RecordDef^, Profile, Pass, '');
    end;
    tsSaves: begin
      ProfileElement(aFormat, wbFileHeader, Profile, Pass, '');
    end;
  end;
end;

procedure ProfileArray(aFormat: TExportFormat; Pass: TwbExportPass);
var
  i         : Integer;
  RecordDef : PwbMainRecordDef;
  Profile   : String;
begin
  case wbToolSource of
    tsPlugins: for i := 0 to Pred(wbGroupOrder.Count) do
      if wbGroupOrder[i]<>wbHeaderSignature then begin
        Profile := '';
        if wbFindRecordDef(AnsiString(wbGroupOrder[i]), RecordDef) then
          ProfileElement(aFormat, RecordDef^, Profile, Pass, '');
      end;
  end;
end;

procedure ProfileChapters(aFormat: TExportFormat; Pass: TwbExportPass);
var
  i         : Integer;
  Profile   : String;
begin
  Profile := '';
  case wbToolSource of
    tsSaves: for i := 0 to Pred(wbFileChapters.MemberCount) do begin
      ProfileElement(aFormat, wbFileChapters.Members[i], Profile, Pass, '');
    end;
  end;
end;

procedure WriteElement(aElement: IwbElement; aIndent: string = ''); forward;

procedure WriteContainer(aContainer: IwbContainer; aIndent: string = '');
var
  i            : Integer;
  GroupRecord  : IwbGroupRecord;
  ContainerRef : IwbContainerElementRef;
  Chapter      : IwbChapter;
begin
  if (wbToolSource in [tsPlugins]) then if (aContainer.ElementType = etGroupRecord) then
    if Supports(aContainer, IwbGroupRecord, GroupRecord) then
      if GroupRecord.GroupType = 0 then begin
        if Assigned(DumpGroups) and not DumpGroups.Find(String(TwbSignature(GroupRecord.GroupLabel)), i) then
          Exit;
        ReportProgress('Dumping: ' + GroupRecord.Name);
      end
      else
        if Assigned(SkipChildGroups) and Assigned(GroupRecord.ChildrenOf) and
           SkipChildGroups.Find(String(TwbSignature(GroupRecord.ChildrenOf.Signature)), i)
        then
          Exit;
  if (wbToolSource in [tsSaves]) and Assigned(DumpChapters) and Supports(aContainer, IwbChapter, Chapter) then begin
    if not DumpChapters.Find(IntToStr(Chapter.ChapterType), i) then
      Exit;
    ReportProgress('Dumping: ' + aContainer.Name);
  end;
  if (wbToolSource in [tsSaves]) and Assigned(ChaptersToSkip) and Supports(aContainer, IwbChapter, Chapter) then
    if ChaptersToSkip.Find(IntToStr(Chapter.ChapterType), i) then begin
      ReportProgress('Skiping: ' + Chapter.ChapterTypeName);
      Exit;
    end;

  if aContainer.Skipped then begin
    if ((not wbReportMode) or DumpCheckReport) then WriteLn(aIndent, '<contents skipped>');
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
  Error       : string;

  i            : Integer;
  GroupRecord  : IwbGroupRecord;
begin
  if Assigned(DumpGroups) and (aElement.ElementType = etGroupRecord) then
    if Supports(aElement, IwbGroupRecord, GroupRecord) then
      if GroupRecord.GroupType = 0 then begin
        if not DumpGroups.Find(String(TwbSignature(GroupRecord.GroupLabel)), i) then
          Exit;
      end
      else
        if Assigned(SkipChildGroups) and Assigned(GroupRecord.ChildrenOf) and
           SkipChildGroups.Find(String(TwbSignature(GroupRecord.ChildrenOf.Signature)), i)
        then
          Exit;

  if aElement.ElementType = etMainRecord then
    Inc(DumpCount);
  if (DumpMax > 0) and (DumpCount > DumpMax) then
    Exit;

  if DumpCheckReport then
    Error := aElement.Check;

  if wbToolMode in [tmDump] then begin

    Name := aElement.DisplayName[True];
    Value := aElement.Value;

    if DumpHidden or ((aElement.Name <> 'Unused') and (Name <> 'Unused')) then begin
      if (Name <> '') and ((not wbReportMode) or DumpCheckReport) then
        Write(aIndent, Name);
      if (Name <> '') or (Value <> '') then begin
        aIndent := aIndent + '  ';
        if DumpSize then
          if (not wbReportMode) or DumpCheckReport then begin
            if Name <> '' then
              Write(' ');
            Write('[', aElement.DataSize, ']');
          end;
      end;
      if (Value <> '') and (DumpHidden or (Pos('Hidden: ', Name)<>1)) then begin
        if ((not wbReportMode) or DumpCheckReport) then
          WriteLn(': ', Value);
      end else begin
        if (Name <> '') and ((not wbReportMode) or DumpCheckReport) then
          WriteLn;
      end;
    end;
  end;

  if DumpCheckReport and (Error <> '') then
    WriteLn(aIndent, '[ERROR: ', Error ,']');

  if Supports(aElement, IwbContainer, Container) and (DumpHidden or (Pos('Hidden: ', Name)<>1)) then
    WriteContainer(Container, aIndent);
end;

{==============================================================================}
function CheckForErrors(const aIndent: Integer; const aElement: IwbElement): Boolean;
var
  Error                       : string;
  Container                   : IwbContainerElementRef;
  i                           : Integer;
  GroupRecord                 : IwbGroupRecord;
begin
  Error := aElement.Check;
  Result := Error <> '';
  if Result then
    WriteLn(StringOfChar(' ', aIndent * 2) + aElement.Name, ' -> ', Error);

  if Supports(aElement, IwbContainerElementRef, Container) then begin

    if (wbToolSource in [tsPlugins]) then if (Container.ElementType = etGroupRecord) then
      if Supports(Container, IwbGroupRecord, GroupRecord) then
        if GroupRecord.GroupType = 0 then begin
          if Assigned(DumpGroups) and not DumpGroups.Find(String(TwbSignature(GroupRecord.GroupLabel)), i) then
            Exit;
          ReportProgress('Checking: ' + GroupRecord.Name);
        end
        else
          if Assigned(SkipChildGroups) and Assigned(GroupRecord.ChildrenOf) and
             SkipChildGroups.Find(String(TwbSignature(GroupRecord.ChildrenOf.Signature)), i)
          then
            Exit;

    for i := Pred(Container.ElementCount) downto 0 do
      Result := CheckForErrors(aIndent + 1, Container.Elements[i]) or Result;
  end;

  if Result and (Error = '') then
    WriteLn(StringOfChar(' ', aIndent * 2), 'Above errors were found in: ', aElement.Name);
end;
{==============================================================================}

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

function CheckParamPath: string; // for Dump, do we have bsa in the same directory
var
  s: string;
  F : TSearchRec;
begin
  Result := '';
  s := ParamStr(ParamCount);
  s := ChangeFileExt(s, '*' + wbArchiveExtension);
  if FindFirst(s, faAnyfile, F)=0 then begin
    Result := ExtractFilePath(ParamStr(ParamCount));
    SysUtils.FindClose(F);
  end;
end;

procedure DoInitPath;
const
  sBethRegKey             = '\SOFTWARE\Bethesda Softworks\';
  sUninstallRegKey        = '\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\';
  sSureAIRegKey           = '\Software\SureAI\';

var
  regPath, regKey, client: string;
  ProgramPath : String;
  DataPath    : String;
begin
  ProgramPath := IncludeTrailingPathDelimiter(ExtractFilePath(ParamStr(0)));

  if not wbFindCmdLineParam('D', DataPath) then begin
    DataPath := CheckAppPath;

    if (DataPath = '') then with TRegistry.Create do try
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
          ReportProgress('Warning: Could not open registry key: ' + regPath);
          Exit;
        end;
      end;

      case wbGameMode of
      gmTES3, gmTES4, gmFO3, gmFNV, gmTES5, gmFO4, gmSSE, gmTES5VR, gmFO4VR:
                  regKey := 'Installed Path';
      gmEnderal:  regKey := 'Install_Path';
      gmFO76:     regKey := 'Path';
      end;

      DataPath := ReadString(regKey);
      DataPath := StringReplace(DataPath, '"', '', [rfReplaceAll]);

      if DataPath = '' then begin
        ReportProgress(Format('Warning: Could not determine %s installation path, no "%s" registry key', [wbGameName2, regKey]));
      end;
    finally
      Free;
    end;

    if (DataPath <> '') then
      DataPath := IncludeTrailingPathDelimiter(DataPath) + 'Data\';

  end else
    DataPath := IncludeTrailingPathDelimiter(DataPath);

  wbDataPath := DataPath;
end;

function isMode(aMode: String): Boolean;
begin
  Result := FindCmdLineSwitch(aMode) or (Pos(Uppercase(aMode), UpperCase(ExtractFileName(ParamStr(0))))<>0);
end;

function isFormatValid(aFormatName: String): Boolean;
begin
  if Uppercase(aFormatName) = 'RAW' then
    Result := True
  else if Uppercase(aFormatName) = 'UESPWIKI' then
    Result := True
  else
    Result := False;
end;

procedure SwitchToCoSave;
begin
  case wbGameMode of
    gmFNV:            SwitchToFNVCoSave;
    gmFO3:            SwitchToFO3CoSave;
    gmFO4, gmFO4vr:   SwitchToFO4CoSave;
    gmTES4:           SwitchToTES4CoSave;
    gmTES5, gmTES5vr, gmEnderal: SwitchToTES5CoSave;
    gmSSE:            SwitchToTES5CoSave;
  end;
end;

var
  NeedsSyntaxInfo : Boolean;
  s, t            : string;
  i,j             : integer;
  c               : Integer;
  _File           : IwbFile;
  Masters         : TStringList;
  IsLocalized     : Boolean;
//  F               : TSearchRec;
  n,m             : TStringList;
  Pass            : TwbExportPass;
  ts              : TwbToolSource;
  tm              : TwbToolMode;
  gm              : TwbGameMode;
  tss             : TwbSetOfSource;
  tms             : TwbSetOfMode;
  Found           : Boolean;
  b               : TBytes;
begin
  {$IF CompilerVersion >= 24}
  FormatSettings.DecimalSeparator := '.';
  {$ELSE}
  SysUtils.DecimalSeparator := '.';
  {$IFEND}
  _wbProgressCallback := ReportProgress;
  wbDontSave := True;
  wbAllowInternalEdit := False;
  wbMoreInfoForUnknown := False;
  wbSimpleRecords := False;
  wbHideUnused := False;
  StartTime := Now;

  try
    try
      t := ExtractFileName(ParamStr(0)).ToLowerInvariant;

      Found := False;
      for ts := Low(TwbToolSource) to High(TwbToolSource) do begin
        s := GetEnumName(TypeInfo(TwbToolSource), Ord(ts) );
        Delete(s, 1, 2);
        if FindCmdLineSwitch(s) then begin
          wbToolSource := ts;
          Found := True;
          Break;
        end;
      end;
      if not Found then
        for ts := Low(TwbToolSource) to High(TwbToolSource) do begin
          s := GetEnumName(TypeInfo(TwbToolSource), Ord(ts) ).ToLowerInvariant;
          Delete(s, 1, 2);
          if t.Contains(s) then begin
            wbToolSource := ts;
            Found := True;
            Break;
          end;
        end;
      if not Found then
        wbToolSource := tsPlugins;

      Found := False;
      for tm := Low(TwbToolMode) to High(TwbToolMode) do begin
        s := GetEnumName(TypeInfo(TwbToolMode), Ord(tm) );
        Delete(s, 1, 2);
        if FindCmdLineSwitch(s) then begin
          wbToolMode := tm;
          Found := True;
          Break;
        end;
      end;
      if not Found then
        for tm := Low(TwbToolMode) to High(TwbToolMode) do begin
          s := GetEnumName(TypeInfo(TwbToolMode), Ord(tm) ).ToLowerInvariant;
          Delete(s, 1, 2);
          if t.Contains(s) then begin
            wbToolMode := tm;
            Found := True;
            Break;
          end;
        end;
      if not Found then begin
        WriteLn(ErrOutput, 'Can''t determine ToolMode.');
        Exit;
      end;

      Found := False;
      for gm := Low(TwbGameMode) to High(TwbGameMode) do begin
        s := GetEnumName(TypeInfo(TwbGameMode), Ord(gm) );
        Delete(s, 1, 2);
        if FindCmdLineSwitch(s) then begin
          wbGameMode := gm;
          Found := True;
          Break;
        end;
      end;
      if not Found then
        for gm := Low(TwbGameMode) to High(TwbGameMode) do begin
          s := GetEnumName(TypeInfo(TwbGameMode), Ord(gm) ).ToLowerInvariant;
          Delete(s, 1, 2);
          if t.Contains(s) then begin
            wbGameMode := gm;
            Found := True;
            Break;
          end;
        end;
      if not Found then begin
        WriteLn(ErrOutput, 'Can''t determine GameMode.');
        Exit;
      end;

      wbToolName := GetEnumName(TypeInfo(TwbToolMode), Ord(wbToolMode) );
      Delete(wbToolName, 1 ,2);
      wbSourceName := GetEnumName(TypeInfo(TwbToolSource), Ord(wbToolSource) );
      Delete(wbSourceName, 1 ,2);
      wbAppName := GetEnumName(TypeInfo(TwbGameMode), Ord(wbGameMode) );
      Delete(wbAppName, 1 ,2);

      wbLoadBSAs := FindCmdLineSwitch('bsa') or FindCmdLineSwitch('allbsa');
      tss := [tsPlugins, tsSaves];
      tms := [tmDump, tmExport];

      wbLanguage := 'English';

      DefineCommon;

      wbGameExeName := '';
      case wbGameMode of
        gmFNV: begin
          wbGameName := 'FalloutNV';
          case wbToolSource of
            tsSaves:   DefineFNVSaves;
            tsPlugins: DefineFNV;
          end;
        end;
        gmFO3: begin
          wbGameName := 'Fallout3';
          case wbToolSource of
            tsSaves:   DefineFO3Saves;
            tsPlugins: DefineFO3;
          end;
        end;
        gmTES3: begin
          wbGameName := 'Morrowind';
          wbLoadBSAs := false;
          tms := [tmDump];
          tss := [tsPlugins];
          DefineTES3;
        end;
        gmTES4: begin
          wbGameName := 'Oblivion';
          case wbToolSource of
            tsSaves:   DefineTES4Saves;
            tsPlugins: DefineTES4;
          end;
        end;
        gmTES5: begin
          wbGameName := 'Skyrim';
          wbGameExeName := 'TESV';
          case wbToolSource of
            tsSaves:   DefineTES5Saves;
            tsPlugins: DefineTES5;
          end;
        end;
        gmEnderal: begin
          wbGameName := 'Enderal';
          wbGameExeName := 'TESV';
          wbGameMasterEsm := 'Skyrim.esm';
          case wbToolSource of
            tsSaves:   DefineTES5Saves;
            tsPlugins: DefineTES5;
          end;
        end;
        gmTES5VR: begin
          wbGameName := 'Skyrim';
          wbGameName2 := 'Skyrim VR';
          wbGameExeName := 'SkyrimVR';
          tss := [tsPlugins];
          case wbToolSource of
            //tsSaves:   DefineTES5Saves;
            tsPlugins: DefineTES5;
          end;
        end;
        gmFO4: begin
          wbGameName := 'Fallout4';
          wbCreateContainedIn := False;
          case wbToolSource of
            tsSaves:   DefineFO4Saves;
            tsPlugins: DefineFO4;
          end;
        end;
        gmFO4VR: begin
          wbGameName := 'Fallout4';
          wbGameExeName := 'Fallout4VR';
          wbGameName2 := 'Fallout4VR';
          wbGameNameReg := 'Fallout 4 VR';
          wbCreateContainedIn := False;
          tss := [tsPlugins];
          case wbToolSource of
            //tsSaves:   DefineFO4Saves;
            tsPlugins: DefineFO4;
          end;
        end;
        gmSSE: begin
          wbGameName := 'Skyrim';
          wbGameExeName := 'SkyrimSE';
          wbGameName2 := 'Skyrim Special Edition';
          case wbToolSource of
            tsSaves:   DefineTES5Saves;
            tsPlugins: DefineTES5;
          end;
        end;
        gmFO76: begin
          wbGameName := 'Fallout76';
          wbGameNameReg := 'Fallout 76';
          wbGameMasterEsm := 'SeventySix.esm';
          wbCreateContainedIn := False;
          tss := [tsPlugins];
          case wbToolSource of
            tsPlugins: DefineFO76;
          end;
        end;
      else
        WriteLn(ErrOutput, 'Application name must contain FNV, FO3, FO4, FO4VR, FO76, SSE, TES4, TES5 or TES5VR to select game.');
        Exit;
      end;

      if wbGameName2 = '' then
        wbGameName2 := wbGameName;

      if wbGameNameReg = '' then
        wbGameNameReg := wbGameName2;

      if wbGameMasterEsm = '' then
        wbGameMasterEsm := wbGameName + csDotEsm;

      if wbGameExeName = '' then
        wbGameExeName := wbGameName;
      wbGameExeName := wbGameExeName + csDotExe;

      if not (wbToolMode in tms) then begin
        WriteLn(ErrOutput, 'Application '+wbGameName+' does not currently support ToolMode: '+wbToolName);
        Exit;
      end;
      if not (wbToolSource in tss) then begin
        WriteLn(ErrOutput, 'Application '+wbGameName+' does not currently support ToolSource: '+wbSourceName);
        Exit;
      end;

      if wbGameMode in [gmFO4, gmFO4vr, gmFO76] then
        wbArchiveExtension := '.ba2';

      DoInitPath;
      if (wbToolMode in [tmDump]) and (wbDataPath = '') then // Dump can be run in any directory configuration
        wbDataPath := CheckParamPath;

      wbLoadModules;

      if FindCmdLineSwitch('report') then
        wbReportMode := True
      else
        wbReportMode := False;

      if FindCmdLineSwitch('dcr') then begin
        wbReportMode := True;
        DumpCheckReport := True;
      end;

      if FindCmdLineSwitch('es') then begin
        DumpSize := True;
      end;

      if FindCmdLineSwitch('dh') then begin
        DumpHidden := True;
      end;
	  
      if wbReportMode then
        wbShowFlagEnumValue := True;

     var SourceName := wbSourceName;
     if SourceName = 'Plugins' then
       SourceName := '';

     wbApplicationTitle := wbAppName + wbToolName + SourceName +  ' ' + VersionString;
     {$IFDEF WIN64}
     wbApplicationTitle := wbApplicationTitle + ' x64';
     {$ENDIF WIN64}
     if wbSubMode <> '' then
       wbApplicationTitle := wbApplicationTitle + ' (' + wbSubMode + ')';

     {$IFDEF EXCEPTION_LOGGING_ENABLED}
     nxEHAppVersion := wbApplicationTitle;
     {$ENDIF}

      if not FindCmdLineSwitch('q') and not wbReportMode then begin
        WriteLn(ErrOutput, wbApplicationTitle);
        WriteLn(ErrOutput);

        WriteLn(ErrOutput, 'The Source Code Form is subject to the terms of the Mozilla Public License,');
        WriteLn(ErrOutput, 'v. 2.0. If a copy of the MPL was not distributed with this file, You can obtain');
        WriteLn(ErrOutput, 'one at https://mozilla.org/MPL/2.0/.');
        WriteLn(ErrOutput);
        WriteLn(ErrOutput, 'The Source Code Form is available at https://github.com/TES5Edit/TES5Edit');
        WriteLn(ErrOutput);
      end;

      if wbFindCmdLineParam('dg', s) then begin
        DumpGroups := TStringList.Create;
        DumpGroups.Sorted := True;
        DumpGroups.Duplicates := dupIgnore;
        DumpGroups.CommaText := s;
        DumpGroups.Sort;
      end;

      if wbFindCmdLineParam('xcg', s) then begin
        SkipChildGroups := TStringList.Create;
        SkipChildGroups.Sorted := True;
        SkipChildGroups.Duplicates := dupIgnore;
        SkipChildGroups.CommaText := s;
        SkipChildGroups.Sort;
      end;

      if wbFindCmdLineParam('dc', s) or wbFindCmdLineParam('df', s) then begin
        DumpChapters := TStringList.Create;
        DumpChapters.Sorted := True;
        DumpChapters.Duplicates := dupIgnore;
      end;

      if wbFindCmdLineParam('dc', s) then begin
        DumpChapters.CommaText := s;
        DumpChapters.Sort;
      end;

      if wbFindCmdLineParam('df', s) then begin
        DumpForms := TStringList.Create;
        DumpForms.Sorted := True;
        DumpForms.Duplicates := dupIgnore;
        DumpForms.CommaText := s;
        DumpForms.Sort;
        for i := 0 to DumpForms.Count-1 do try
          c := StrToInt(DumpForms[i]);
          DumpChapters.Add(IntToStr(wbChangedFormOffset+c));
        finally
        end;
        DumpForms.Free;
      end;

      wbLoadAllBSAs := FindCmdLineSwitch('allbsa');

      if FindCmdLineSwitch('more') then
        wbMoreInfoForUnknown:= True
      else
        wbMoreInfoForUnknown:= False;

      if wbFindCmdLineParam('xr', s) then
        RecordToSkip.CommaText := s;

      if wbFindCmdLineParam('xg', s) then
        GroupToSkip.CommaText := s
      else if FindCmdLineSwitch('xbloat') then begin
        GroupToSkip.Add('LAND');
        GroupToSkip.Add('REGN');
        GroupToSkip.Add('PGRD');
        GroupToSkip.Add('SCEN');
        GroupToSkip.Add('PACK');
        GroupToSkip.Add('PERK');
        GroupToSkip.Add('NAVI');
        GroupToSkip.Add('CELL');
        GroupToSkip.Add('WRLD');
      end;

      if wbFindCmdLineParam('xc', s) then
        ChaptersToSkip.CommaText := s
      else if FindCmdLineSwitch('xcbloat') then begin
        ChaptersToSkip.Add('1001');
      end;

      if wbFindCmdLineParam('xf', s) then begin
        DumpForms := TStringList.Create;
        DumpForms.Sorted := True;
        DumpForms.Duplicates := dupIgnore;
        DumpForms.CommaText := s;
        DumpForms.Sort;
        for i := 0 to DumpForms.Count-1 do try
          c := StrToInt(DumpForms[i]);
          ChaptersToSkip.Add(IntToStr(wbChangedFormOffset+c));
        finally
        end;
        DumpForms.Free;
      end;

      if wbGameMode in [gmFO4, gmFO4vr, gmFO76] then
        wbLanguage := 'En';

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

      if wbFindCmdLineParam('bts', s) then
        wbBytesToSkip := StrToInt64Def(s, wbBytesToSkip);
      if wbFindCmdLineParam('btd', s) then
        wbBytesToDump := StrToInt64Def(s, wbBytesToDump);

      if wbFindCmdLineParam('do', s) then
        wbDumpOffset := StrToInt64Def(s, wbDumpOffset);

      if wbFindCmdLineParam('top', s) then
        DumpMax := StrToIntDef(s, 0);

      s := ParamStr(ParamCount);

      NeedsSyntaxInfo := False;

      if not FileExists(s) then
        if FileExists(wbDataPath + s) then
          s := wbDataPath + s;

      if (wbToolMode in [tmDump]) and (ParamCount >= 1) and not FileExists(s) then begin
        if s[1] in SwitchChars then
          WriteLn(ErrOutput, 'No inputfile was specified. Please check the command line parameters.')
        else
          WriteLn(ErrOutput, 'Can''t find the file "',s,'". Please check the command line parameters.');
        WriteLn;
        NeedsSyntaxInfo := True;
      end else if (wbToolMode in [tmExport]) and (ParamCount >=1) and not isFormatValid(s) then begin
        if s[1] in SwitchChars then
          WriteLn(ErrOutput, 'No format was specified. Please check the command line parameters.')
        else
          WriteLn(ErrOutput, 'Cannot handle the format "',s,'". Please check the command line parameters.');
        WriteLn;
        NeedsSyntaxInfo := True;
      end;
      if wbToolSource = tsSaves then
        case wbGameMode of
          gmFNV:    if SameText(ExtractFileExt(s), '.nvse') then SwitchToCoSave;
          gmFO3:    if SameText(ExtractFileExt(s), '.fose') then SwitchToCoSave
            else
              WriteLn(ErrOutput, 'Save are not supported yet "',s,'". Please check the command line parameters.');
          gmFO4,
          gmFO4vr:  if SameText(ExtractFileExt(s), '.f4se') then SwitchToCoSave;
          gmTES4:   if SameText(ExtractFileExt(s), '.obse') then SwitchToCoSave
            else
              WriteLn(ErrOutput, 'Save are not supported yet "',s,'". Please check the command line parameters.');
          gmTES5,
          gmTES5vr,
          gmEnderal: if SameText(ExtractFileExt(s), '.skse') then SwitchToCoSave;
          gmSSE:    if SameText(ExtractFileExt(s), '.skse') then SwitchToCoSave;
        else
            WriteLn(ErrOutput, 'CoSave are not supported yet "',s,'". Please check the command line parameters.');
        end;

      if NeedsSyntaxInfo or (ParamCount < 1) or FindCmdLineSwitch('?') or FindCmdLineSwitch('help') then begin
        WriteLn(ErrOutput, 'Syntax:  '+wbAppName+'Dump [options] inputfile');
        WriteLn(ErrOutput, '  or     '+wbAppName+'Export [options] format');
        WriteLn(ErrOutput);
        WriteLn(ErrOutput, wbAppName + 'Dump will load the specified esp/esm files and all it''s masters and will dump the decoded contents of the specified file to stdout. Masters are searched for in the same directory as the specified file.');
        WriteLn(ErrOutput);
        WriteLn(ErrOutput, wbAppName + 'Dump -Saves will load the specified save or coSave file and all it''s masters and will dump the decoded contents of the specified file to stdout. Masters are searched for in the game directory.');
        WriteLn(ErrOutput);
        WriteLn(ErrOutput, wbAppName + 'Export will dump the plugin definition in the specified format.');
        WriteLn(ErrOutput, wbAppName + 'Export -Saves will dump the save file definition in the specified format.');
        WriteLn(ErrOutput);
        WriteLn(ErrOutput, 'You can use the normal redirect mechanism to send the output to a file.');
        WriteLn(ErrOutput, 'e.g. "'+wbAppName+'Dump '+wbGameMasterEsm+' > '+wbGameName+'.txt"');
        WriteLn(ErrOutput);
        WriteLn(ErrOutput, 'Currently supported options:');
        WriteLn(ErrOutput, '-? / -help   ', 'This help screen');
        WriteLn(ErrOutput, '-q           ', 'Suppress version message');
        WriteLn(ErrOutput, '-more        ', 'Displays aditional information on Unknowns');
        WriteLn(ErrOutput, '-l:language  ', 'Specifies language for localization files (since TES5)');
        WriteLn(ErrOutput, '             ', '  Default language is English for TES5 or SSE and En for FO4');
        WriteLn(ErrOutput, '-bsa         ', 'Loads default associated BSAs');
        WriteLn(ErrOutput, '             ', ' (plugin'+wbArchiveExtension+' and plugin - interface.'+wbArchiveExtension+')');
        WriteLn(ErrOutput, '-allbsa      ', 'Loads all associated BSAs (plugin*.bsa)');
        WriteLn(ErrOutput, '             ', '   useful if strings are in a non-standard BSA');
        WriteLn(ErrOutput, '-d:datapath  ', 'Path to the game plugins directory');
        WriteLn(ErrOutput, '-do:value    ', 'Dump objects offsets and size and/or array count');
        WriteLn(ErrOutput, '             ', '  -do:0 nothing');
        WriteLn(ErrOutput, '             ', '  -do:1 starting offset');
        WriteLn(ErrOutput, '             ', '  -do:2 starting offset and array count  PERFORMANCE PENALTY');
        WriteLn(ErrOutput, '             ', '  -do:3 starting and ending offset, size and array count  PERFORMANCE PENALTY');
        WriteLn(ErrOutput, '-bts         ', 'BytesToSkip  = number of undecoded bytes to skip, default = 0');
        WriteLn(ErrOutput, '-btd         ', 'BytesToDump  = number of undecoded bytes to dump as unknown, default = all');
        WriteLn(ErrOutput, '             ', '');
        WriteLn(ErrOutput, 'Plugin mode ONLY');
        WriteLn(ErrOutput, '-xr:list     ', 'Excludes the contents of specified records from being');
        WriteLn(ErrOutput, '             ', '  decompressed and processed.');
        WriteLn(ErrOutput, '-xg:list     ', 'Excludes complete top level groups from being processed');
        WriteLn(ErrOutput, '-xcg:list    ', 'Excludes record child groups from being processed');
        WriteLn(ErrOutput, '-xbloat      ', 'The following value applies:');
        WriteLn(ErrOutput, '             ', '  -xg:LAND,REGN,PGRD,SCEN,PACK,PERK,NAVI,CELL,WRLD');
        WriteLn(ErrOutput, '-dg:list     ', 'If specified, only dump the listed top level groups');
        WriteLn(ErrOutput, '-top:N       ', 'If specified, only dump the first N records');
        WriteLn(ErrOutput, '-check       ', 'Performs "Check for Errors" instead of dumping content');
        WriteLn(ErrOutput, '-dcr         ', 'Dumps record content while performing "Check for Errors" on each element and generates a report');
        WriteLn(ErrOutput, '-es          ', 'Dumps size for all elements');
        WriteLn(ErrOutput, '-dh          ', 'Dumps normally hidden elements');
        WriteLn(ErrOutput, '             ', '');
        WriteLn(ErrOutput, 'Saves mode ONLY');
        WriteLn(ErrOutput, '-df:list     ', 'If specified, only dump the listed ChangedForm type');
        WriteLn(ErrOutput, '-xf:list     ', 'Excludes complete ChangedForm type from being processed');
        WriteLn(ErrOutput, '-dc:GlobalDataIDlist   ', 'If specified, only process those global data ID');
        WriteLn(ErrOutput, '-xc:GlobalDataIDlist   ', 'Excludes those global data from being processed');
        WriteLn(ErrOutput, '-xcbloat     ', 'The following value applies:');
        WriteLn(ErrOutput, '             ', '  -xc:1001');
        WriteLn(ErrOutput, '             ', '    1001 is the ID of Papyrus data the largest part of the save.');
        WriteLn(ErrOutput, '             ', '');
        WriteLn(ErrOutput, 'Example: full dump of Fallout4.esm excluding "bloated" records');
        WriteLn(ErrOutput, '  TES5Dump.exe -FO4 -xr:NAVI,NAVM,WRLD,CELL,LAND,REFR,ACHR Fallout4.esm');
        WriteLn(ErrOutput, '             ', '');
        WriteLn(ErrOutput, 'Currently supported export formats:');
        WriteLn(ErrOutput, 'RAW          ','Private format for debugging');
        WriteLn(ErrOutput, 'UESPWIKI     ','UESP Wiki table format [Very WIP]');
        WriteLn(ErrOutput, '             ', '');
        Exit;
      end;

      if wbToolMode in [tmExport] then begin
        wbLoadBSAs := False;
        wbReportMode := False;
        wbMoreInfoForUnknown:= False;
        DumpCheckReport := False;
      end;

      if not Assigned(wbContainerHandler) then
        wbContainerHandler := wbCreateContainerHandler;

      StartTime := Now;
      ReportProgress('Application name : ' + wbApplicationTitle);
      if Assigned(Dumpgroups) then
        ReportProgress('['+s+']   Dumping groups : '+DumpGroups.CommaText);
      if Assigned(GroupToSkip) and (GroupToSkip.Count>0) then
        ReportProgress('['+s+']   Excluding groups : '+GroupToSkip.CommaText);
      if Assigned(RecordToSkip) and (RecordToSkip.Count>0) then
        ReportProgress('['+s+']   Excluding records : '+RecordToSkip.CommaText);

      if Assigned(DumpChapters) then
        ReportProgress('['+s+']   Dumping chapters : '+DumpChapters.CommaText);
      if Assigned(ChaptersToSkip) and (ChaptersToSkip.Count>0) then
        ReportProgress('['+s+']   Excluding chapters : '+ChaptersToSkip.CommaText);
      if wbBytesToSkip>0 then
        ReportProgress('['+s+']   BytesToSkip : '+IntToStr(wbBytesToSkip));
      if wbBytesToDump<$FFFFFFFF then
        ReportProgress('['+s+']   BytesToDump : '+IntToStr(wbBytesToDump));
      if wbDumpOffset>0 then
        ReportProgress('['+s+']   Dump Offset mode : '+IntToStr(wbDumpOffset));

      if wbToolMode in [tmDump] then begin

        Masters := TStringList.Create;
        try
          IsLocalized := False;
          wbMastersForFile(s, Masters, nil, nil, @IsLocalized);
          if not IsLocalized then
            for i := 0 to Pred(Masters.Count) do begin
              wbMastersForFile(Masters[i], nil, nil, nil, @IsLocalized);
              if IsLocalized then
                Break;
            end;
          Masters.Add(ExtractFileName(s));
          if IsLocalized and not wbLoadBSAs and not FindCmdLineSwitch('nobsa') then begin
            for i := 0 to Pred(Masters.Count) do begin
              t := ExtractFilePath(s) + 'Strings\' + ChangeFileExt(Masters[i], '') + '_' + wbLanguage + '.STRINGS';
              if not FileExists(t) then begin
                wbLoadBSAs := True;
                Break;
              end;
            end;
          end;
          if wbLoadBSAs then begin

            if wbLoadAllBSAs then begin
              n := TStringList.Create;
              try
                m := TStringList.Create;
                try
                  if (Length(wbTheGameIniFileName)>0) and (FindBSAs(wbTheGameIniFileName, wbDataPath, n, m)>0) then begin
                    for i := 0 to Pred(n.Count) do begin
                      ReportProgress('[' + n[i] + '] Loading Resources.');
                      wbContainerHandler.AddBSA(MakeDataFileName(n[i], wbDataPath));
                    end;
                  end;
                finally
                  FreeAndNil(m);
                end;
              finally
                FreeAndNil(n);
              end;
            end;

            for i := 0 to Pred(Masters.Count) do begin
              if wbLoadAllBSAs then begin
                n := TStringList.Create;
                try
                  m := TStringList.Create;
                  try
                    if HasBSAs(ChangeFileExt(Masters[i], ''), wbDataPath,
                        wbGameMode in [gmTES5, gmEnderal, gmTES5vr, gmSSE], wbGameMode in [gmTES5, gmEnderal, gmTES5vr, gmSSE], n, m)>0 then begin
                      for j := 0 to Pred(n.Count) do begin
                        ReportProgress('[' + n[j] + '] Loading Resources.');
                        wbContainerHandler.AddBSA(MakeDataFileName(n[j], wbDataPath));
                      end;
                    end;
                  finally
                    FreeAndNil(m);
                  end;
                finally
                  FreeAndNil(n);
                end;
              end else begin
                n := TStringList.Create;
                try
                  m := TStringList.Create;
                  try
                    if HasBSAs(ChangeFileExt(Masters[i], ''), wbDataPath, true, false, n, m)>0 then begin
                      for j := 0 to Pred(n.Count) do begin
                        ReportProgress('[' + n[j] + '] Loading Resources.');
                        wbContainerHandler.AddBSA(MakeDataFileName(n[j], wbDataPath));
                      end;
                    end;
                    m.Clear;
                    n.Clear;
                    if HasBSAs(ChangeFileExt(Masters[i], '')+' - Interface', wbDataPath, true, false, n, m)>0 then begin
                      for j := 0 to Pred(n.Count) do begin
                        ReportProgress('[' + n[j] + '] Loading Resources.');
                        wbContainerHandler.AddBSA(MakeDataFileName(n[j], wbDataPath));
                      end;
                    end;
                    m.Clear;
                    n.Clear;
                    if HasBSAs(ChangeFileExt(Masters[i], '')+' - Localization', wbDataPath, true, false, n, m)>0 then begin
                      for j := 0 to Pred(n.Count) do begin
                        ReportProgress('[' + n[j] + '] Loading Resources.');
                        wbContainerHandler.AddBSA(MakeDataFileName(n[j], wbDataPath));
                      end;
                    end;
                  finally
                    FreeAndNil(m);
                  end;
                finally
                  FreeAndNil(n);
                end;
              end;
            end;
          end;
        finally
          FreeAndNil(Masters);
        end;
      end;

      ReportProgress('[' + wbDataPath + '] Setting Resource Path.');
      wbContainerHandler.AddFolder(wbDataPath);

      if wbToolMode in [tmDump] then
        _File := wbFile(s, High(Integer));

      with wbModuleByName(wbGameMasterEsm)^ do
        if mfHasFile in miFlags then begin
          b := TwbHardcodedContainer.GetHardCodedDat;
          if Length(b) > 0 then
            wbFile(wbGameExeName, 0, wbGameMasterEsm, [fsIsHardcoded], b);
        end;

      ReportProgress('Finished loading record. Starting Dump.');

      if wbToolMode in [tmDump] then begin
        if FindCmdLineSwitch('check') and not wbReportMode then
          CheckForErrors(0, _File)
        else
          WriteContainer(_File);

        if wbReportMode then begin
          if DumpCheckReport then begin
            WriteLn;
            WriteLn('==================================== REPORT ====================================');
            WriteLn;
          end;

          ReportDefs;
        end;
      end else if wbToolMode in [tmExport] then begin
        for Pass := epRead to epRemaining do begin
          ProfileHeader(StrToTExportFormat(s), Pass);
          ProfileArray(StrToTExportFormat(s), Pass);
          ProfileChapters(StrToTExportFormat(s), Pass);
        end;

        wbDefProfiles.SaveToFile(wbAppName+wbToolName+wbSourceName+'.txt');
      end;

      ReportProgress('All Done.');
    except
      on e: Exception do
        ReportProgress('Unexpected Error: <'+e.ClassName+': '+e.Message+'>');
    end;
  finally
    if DebugHook <> 0 then begin
      ReportProgress('Press enter to continue...');
      ReadLn;
    end;
  end;
end.

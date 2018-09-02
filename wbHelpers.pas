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

unit wbHelpers;

{$I wbDefines.inc}

interface

uses
  Classes,
  Windows,
  SysUtils,
  Graphics,
  Forms,
  ShellAPI,
  ShlObj,
  IniFiles,
  Registry,
  RegularExpressionsCore,
  wbInterface,
  Imaging,
  ImagingTypes;

Const
  CRCSeed = $ffffffff;
//{$IFDEF WIN64}
  CRC32tab : Array[0..255] of DWord = (
      $00000000, $77073096, $ee0e612c, $990951ba, $076dc419, $706af48f,
      $e963a535, $9e6495a3, $0edb8832, $79dcb8a4, $e0d5e91e, $97d2d988,
      $09b64c2b, $7eb17cbd, $e7b82d07, $90bf1d91, $1db71064, $6ab020f2,
      $f3b97148, $84be41de, $1adad47d, $6ddde4eb, $f4d4b551, $83d385c7,
      $136c9856, $646ba8c0, $fd62f97a, $8a65c9ec, $14015c4f, $63066cd9,
      $fa0f3d63, $8d080df5, $3b6e20c8, $4c69105e, $d56041e4, $a2677172,
      $3c03e4d1, $4b04d447, $d20d85fd, $a50ab56b, $35b5a8fa, $42b2986c,
      $dbbbc9d6, $acbcf940, $32d86ce3, $45df5c75, $dcd60dcf, $abd13d59,
      $26d930ac, $51de003a, $c8d75180, $bfd06116, $21b4f4b5, $56b3c423,
      $cfba9599, $b8bda50f, $2802b89e, $5f058808, $c60cd9b2, $b10be924,
      $2f6f7c87, $58684c11, $c1611dab, $b6662d3d, $76dc4190, $01db7106,
      $98d220bc, $efd5102a, $71b18589, $06b6b51f, $9fbfe4a5, $e8b8d433,
      $7807c9a2, $0f00f934, $9609a88e, $e10e9818, $7f6a0dbb, $086d3d2d,
      $91646c97, $e6635c01, $6b6b51f4, $1c6c6162, $856530d8, $f262004e,
      $6c0695ed, $1b01a57b, $8208f4c1, $f50fc457, $65b0d9c6, $12b7e950,
      $8bbeb8ea, $fcb9887c, $62dd1ddf, $15da2d49, $8cd37cf3, $fbd44c65,
      $4db26158, $3ab551ce, $a3bc0074, $d4bb30e2, $4adfa541, $3dd895d7,
      $a4d1c46d, $d3d6f4fb, $4369e96a, $346ed9fc, $ad678846, $da60b8d0,
      $44042d73, $33031de5, $aa0a4c5f, $dd0d7cc9, $5005713c, $270241aa,
      $be0b1010, $c90c2086, $5768b525, $206f85b3, $b966d409, $ce61e49f,
      $5edef90e, $29d9c998, $b0d09822, $c7d7a8b4, $59b33d17, $2eb40d81,
      $b7bd5c3b, $c0ba6cad, $edb88320, $9abfb3b6, $03b6e20c, $74b1d29a,
      $ead54739, $9dd277af, $04db2615, $73dc1683, $e3630b12, $94643b84,
      $0d6d6a3e, $7a6a5aa8, $e40ecf0b, $9309ff9d, $0a00ae27, $7d079eb1,
      $f00f9344, $8708a3d2, $1e01f268, $6906c2fe, $f762575d, $806567cb,
      $196c3671, $6e6b06e7, $fed41b76, $89d32be0, $10da7a5a, $67dd4acc,
      $f9b9df6f, $8ebeeff9, $17b7be43, $60b08ed5, $d6d6a3e8, $a1d1937e,
      $38d8c2c4, $4fdff252, $d1bb67f1, $a6bc5767, $3fb506dd, $48b2364b,
      $d80d2bda, $af0a1b4c, $36034af6, $41047a60, $df60efc3, $a867df55,
      $316e8eef, $4669be79, $cb61b38c, $bc66831a, $256fd2a0, $5268e236,
      $cc0c7795, $bb0b4703, $220216b9, $5505262f, $c5ba3bbe, $b2bd0b28,
      $2bb45a92, $5cb36a04, $c2d7ffa7, $b5d0cf31, $2cd99e8b, $5bdeae1d,
      $9b64c2b0, $ec63f226, $756aa39c, $026d930a, $9c0906a9, $eb0e363f,
      $72076785, $05005713, $95bf4a82, $e2b87a14, $7bb12bae, $0cb61b38,
      $92d28e9b, $e5d5be0d, $7cdcefb7, $0bdbdf21, $86d3d2d4, $f1d4e242,
      $68ddb3f8, $1fda836e, $81be16cd, $f6b9265b, $6fb077e1, $18b74777,
      $88085ae6, $ff0f6a70, $66063bca, $11010b5c, $8f659eff, $f862ae69,
      $616bffd3, $166ccf45, $a00ae278, $d70dd2ee, $4e048354, $3903b3c2,
      $a7672661, $d06016f7, $4969474d, $3e6e77db, $aed16a4a, $d9d65adc,
      $40df0b66, $37d83bf0, $a9bcae53, $debb9ec5, $47b2cf7f, $30b5ffe9,
      $bdbdf21c, $cabac28a, $53b39330, $24b4a3a6, $bad03605, $cdd70693,
      $54de5729, $23d967bf, $b3667a2e, $c4614ab8, $5d681b02, $2a6f2b94,
      $b40bbe37, $c30c8ea1, $5a05df1b, $2d02ef8d  );
//{$ENDIF}

function wbDistance(const a, b: TwbVector): Single; overload
function wbDistance(const a, b: IwbMainRecord): Single; overload;
function wbStringToSignatures(aSignatures: string): TwbSignatures;
function wbGetSiblingREFRsWithin(const aMainRecord: IwbMainRecord; aDistance: Single): TDynMainRecords;
function wbGetSiblingRecords(const aElement: IwbElement; aSignatures: TwbSignatures; aOverrides: Boolean): TDynMainRecords;
function FindMatchText(Strings: TStrings; const Str: string): Integer;
function IsFileESM(const aFileName: string): Boolean;
function IsFileESP(const aFileName: string): Boolean;
function IsFileESL(const aFileName: string): Boolean;
function IsFileCC(const aFileName: string): Boolean;
procedure DeleteDirectory(const DirName: string);
function FullPathToFilename(aString: string): string;
procedure wbFlipBitmap(aBitmap: TBitmap; MirrorType: Integer); // MirrorType: 1 - horizontal, 2 - vertical, 0 - both
function wbAlphaBlend(DestDC, X, Y, Width, Height,
  SrcDC, SrcX, SrcY, SrcWidth, SrcHeight, Alpha: integer): Boolean;
procedure SaveFont(aIni: TMemIniFile; aSection, aName: string; aFont: TFont);
procedure LoadFont(aIni: TMemIniFile; aSection, aName: string; aFont: TFont);
function wbDDSDataToBitmap(aData: TBytes; Bitmap: TBitmap): Boolean;
function wbDDSStreamToBitmap(aStream: TStream; Bitmap: TBitmap): Boolean;
function wbCRC32Ptr(aData: Pointer; aSize: Integer): TwbCRC32;
function wbCRC32Data(aData: TBytes): TwbCRC32;
function wbCRC32File(aFileName: string): TwbCRC32;
function wbCRC32App: TwbCRC32;
function bscrc32(const aText: string): Cardinal; // hashing func used in Fallout 4
function wbDecodeCRCList(const aList: string): TDynCardinalArray;
function wbSHA1Data(aData: TBytes): string;
function wbSHA1File(aFileName: string): string;
function wbMD5Data(aData: TBytes): string;
function wbMD5File(aFileName: string): string;
function wbIsAssociatedWithExtension(aExt: string): Boolean;
function wbAssociateWithExtension(aExt, aName, aDescr: string): Boolean;
function ExecuteCaptureConsoleOutput(const aCommandLine: string): Cardinal;
function wbExpandFileName(const aFileName: string): string;


type
  PnxLeveledListCheckCircularStack = ^TnxLeveledListCheckCircularStack;
  TnxLeveledListCheckCircularStack = record
    rllcLast       : PnxLeveledListCheckCircularStack;
    rllcMainRecord : IwbMainRecord;
  end;

procedure wbLeveledListCheckCircular(const aMainRecord: IwbMainRecord; aStack: PnxLeveledListCheckCircularStack);

function wbExtractNameFromPath(aPathName: String): String;

function wbCounterAfterSet(aCounterName: String; const aElement: IwbElement): Boolean;
function wbCounterByPathAfterSet(aCounterName: String; const aElement: IwbElement): Boolean;
function wbCounterContainerAfterSet(aCounterName: String; anArrayName: String; const aElement: IwbElement): Boolean;
function wbCounterContainerByPathAfterSet(aCounterName: String; anArrayName: String; const aElement: IwbElement): Boolean;
function wbFormVerDecider(aBasePtr: Pointer; aEndPtr: Pointer; const aElement: IwbElement; aMinimum: Integer): Integer;
function wbFormVer78Decider(aBasePtr: Pointer; aEndPtr: Pointer; const aElement: IwbElement): Integer;

// BSA helper

function MakeDataFileName(FileName, DataPath: String): String;
function FindBSAs(IniName, DataPath: String; var bsaNames: TStringList; var bsaMissing: TStringList): Integer;
function HasBSAs(ModName, DataPath: String; Exact, modini: Boolean; var bsaNames: TStringList; var bsaMissing: TStringList): Integer;

function wbStripDotGhost(const aFileName: string): string;

type
  TPassThroughFunc<T> = reference to function (const a: T): T;

  TStringArrayHelper = record helper for TArray<string>
    function ForEach(const aFunc: TPassThroughFunc<string>): TArray<string>;
    function AddPrefix(const aPrefix: string): TArray<string>;
    function RemoveEmpty: TArray<string>;
    function ToCommaText: string;
    function ToText: string;
    procedure ReportAsProgress;
    procedure Add(const s: string);
  end;

  TPointerArrayHelper = record helper for TArray<Pointer>
    procedure Add(p: Pointer);
  end;

function  wbIsAeroEnabled: Boolean;

function wbGetLastWriteTime(const s: string): TDateTime;

implementation

uses
  System.SyncObjs,
  System.IOUtils,
  StrUtils,
  wbSort;

function TStringArrayHelper.AddPrefix(const aPrefix: string): TArray<string>;
begin
  Result := Self.ForEach(function(const s: string): string begin
    Result := aPrefix + s;
  end);
end;

function TStringArrayHelper.ForEach(const aFunc: TPassThroughFunc<string>): TArray<string>;
var
  i: Integer;
begin
  Result := nil;
  SetLength(Result, Length(Self));
  for i := Low(Self) to High(Self) do
    Result[i] := aFunc(Self[i]);
end;

function TStringArrayHelper.RemoveEmpty: TArray<string>;
var
  i, j: Integer;
begin
  Result := Copy(Self);
  j := 0;
  for i := Low(Result) to High(Result) do begin
    if Result[i] <> '' then begin
      if i <> j then
        Result[j] := Result[i];
      Inc(j);
    end;
  end;
  SetLength(Result, j);
end;

procedure TStringArrayHelper.ReportAsProgress;
var
  i: Integer;
begin
  for i := Low(Self) to High(Self) do
    wbProgress(Self[i]);
end;

function TStringArrayHelper.ToCommaText: string;
begin
  with TStringList.Create do try
    AddStrings(Self);
    Result := CommaText;
  finally
    Free;
  end;
end;

function TStringArrayHelper.ToText: string;
begin
  with TStringList.Create do try
    AddStrings(Self);
    Result := Text;
  finally
    Free;
  end;
end;

procedure TStringArrayHelper.Add(const s: string);
var
  Len: Integer;
begin
  Len := Length(Self);
  SetLength(Self, Succ(Len));
  Self[Len] := s;
end;

procedure TPointerArrayHelper.Add(p: Pointer);
var
  Len: Integer;
begin
  Len := Length(Self);
  SetLength(Self, Succ(Len));
  Self[Len] := p;
end;


function wbStripDotGhost(const aFileName: string): string;
begin
  Result := aFileName;
  if aFileName.EndsWith(csDotGhost, True) then
    SetLength(Result, Length(Result) - Length(csDotGhost));
end;

procedure wbLeveledListCheckCircular(const aMainRecord: IwbMainRecord; aStack: PnxLeveledListCheckCircularStack);
var
  Stack    : TnxLeveledListCheckCircularStack;
  s          : string;
  CER        : IwbContainerElementRef;
  Entries    : IwbContainerElementRef;
  Entry      : IwbContainerElementRef;
  i          : Integer;
  Reference  : IwbElement;
  MainRecord : IwbMainRecord;
  RefPath    : string;
begin
  Stack.rllcLast := aStack;
  Stack.rllcMainRecord := aMainRecord;

  while Assigned(aStack) do begin
    if aStack.rllcMainRecord.LoadOrderFormID = aMainRecord.LoadOrderFormID then begin
      s := aMainRecord.Name;
      aStack := Stack.rllcLast;
      while Assigned(aStack) do begin
        s := ' -> ' + s;
        s := aStack.rllcMainRecord.Name + s;
        if aStack.rllcMainRecord.LoadOrderFormID = aMainRecord.LoadOrderFormID then
          Break;
        aStack := aStack.rllcLast;
      end;
      s := 'Circular Leveled List found: ' + s;
      raise Exception.Create(s);
    end;
    aStack := aStack.rllcLast;
  end;

  if aMainRecord.IsTagged then
    Exit;
  aMainRecord.Tag;

  if wbGameMode = gmTES4 then
    RefPath := 'Reference'
  else
    RefPath := 'LVLO\Reference';

  if Supports(aMainRecord, IwbContainerElementRef, CER) then begin
    if Supports(CER.ElementByName['Leveled List Entries'], IwbContainerElementRef, Entries) then begin
      for i := 0 to Pred(Entries.ElementCount) do
        if Supports(Entries.Elements[i], IwbContainerElementRef, Entry) then begin
          if Supports(Entry.ElementByPath[RefPath], IwbElement, Reference) then begin
            if Supports(Reference.LinksTo, IwbMainRecord, MainRecord) then begin
              if (MainRecord.Signature = aMainRecord.Signature) then begin
                MainRecord := MainRecord.WinningOverride;
                wbLeveledListCheckCircular(MainRecord, @Stack);
              end;
            end;
          end;
        end;
    end;
  end;
end;

function Vec3Subtract(out vOut: TwbVector; const v1, v2: TwbVector): TwbVector;
begin
  with vOut do
  begin
    x:= v1.x - v2.x;
    y:= v1.y - v2.y;
    z:= v1.z - v2.z;
  end;
  Result := vOut;
end;

function Vec3Length(const v: TwbVector): Single;
begin
  with v do Result:= Sqrt(x*x + y*y + z*z);
end;

function wbDistance(const a, b: TwbVector): Single;
var
  t: TwbVector;
begin
  Result := Vec3Length(Vec3Subtract(t,a,b));
end;

function wbDistance(const a, b: IwbMainRecord): Single; overload;
var
  PosA, PosB: TwbVector;
begin
  if not a.GetPosition(PosA) then
    raise Exception.Create('GetPosition failed');
  if not b.GetPosition(PosB) then
    raise Exception.Create('GetPosition failed');
  Result := wbDistance(PosA, PosB);
end;

function wbStringToSignatures(aSignatures: string): TwbSignatures;
var
  i: integer;
  s: AnsiString;
begin
  with TStringList.Create do try
    if Pos(',', aSignatures) <> 0 then Delimiter := ',' else Delimiter := ' ';
    StrictDelimiter := True;
    DelimitedText := aSignatures;
    for i := 0 to Pred(Count) do begin
      s := AnsiString(Strings[i]);
      if Length(s) >= SizeOf(TwbSignature) then begin
        SetLength(Result, Succ(Length(Result)));
        System.Move(s[1], Result[Pred(Length(Result))][0], SizeOf(TwbSignature));
      end;
    end;
  finally
    Free;
  end;
end;

function wbGetSiblingREFRsWithin(const aMainRecord: IwbMainRecord; aDistance: Single): TDynMainRecords;
var
  Count       : Integer;
  Position    : TwbVector;
  MaxLoadOrder: Integer;

  procedure FindREFRs(const aElement: IwbElement);
  var
    MainRecord : IwbMainRecord;
    Container  : IwbContainerElementRef;
    i          : Integer;
    Temp       : TwbVector;
  begin
    if Supports(aElement, IwbMainRecord, MainRecord) then begin
      if not (aMainRecord.LoadOrderFormID = MainRecord.LoadOrderFormID) and
        MainRecord.GetPosition(Temp) and
        (wbDistance(Temp,Position) <= aDistance) then begin

        if High(Result) < Count then
          SetLength(Result, Length(Result) * 2);
        Result[Count] := MainRecord.HighestOverrideOrSelf[MaxLoadOrder];
        Inc(Count);

      end;
    end else
      if Supports(aElement, IwbContainerElementRef, Container) then
        for i := 0 to Pred(Container.ElementCount) do
          FindREFRs(Container.Elements[i]);
  end;

var
  GroupRecord : IwbGroupRecord;
  CellMaster  : IwbMainRecord;
  i, j        : Integer;
begin
  Result := nil;
  if not aMainRecord.GetPosition(Position) then
    Exit;
  if not Supports(aMainRecord.Container, IwbGroupRecord, GroupRecord) then
    Exit;
  if not (GroupRecord.GroupType in [8..10]) then
    Exit;
  CellMaster := GroupRecord.ChildrenOf;
  if not Assigned(CellMaster) then
    Exit;
  CellMaster := CellMaster.MasterOrSelf;
  MaxLoadOrder := aMainRecord._File.LoadOrder;

  Count := 0;
  SetLength(Result, 1024);
  FindREFRs(CellMaster.ChildGroup);
  for i := 0 to Pred(CellMaster.OverrideCount) do
    if CellMaster.Overrides[i]._File.LoadOrder <= aMainRecord._File.LoadOrder then
      FindREFRs(CellMaster.Overrides[i])
    else
      Break;
  SetLength(Result, Count);


  if Length(Result) > 1 then begin
    wbMergeSortPtr(@Result[0], Length(Result), CompareElementsFormIDAndLoadOrder);

    j := 0;
    for i := Succ(Low(Result)) to High(Result) do begin
      if (Result[j].LoadOrderFormID <> Result[i].LoadOrderFormID) and not (Result[j].IsDeleted) then
        Inc(j);
      if j <> i then
        Result[j] := Result[i];
    end;
    SetLength(Result, Succ(j));
  end;
end;

function wbGetSiblingRecords(const aElement: IwbElement; aSignatures: TwbSignatures; aOverrides: Boolean): TDynMainRecords;

  procedure FindRecords(const aElement: IwbElement; var aSignatures: TwbSignatures; var Records: TDynMainRecords; var Count: Integer);
  var
    MainRecord : IwbMainRecord;
    Container  : IwbContainerElementRef;
    i          : Integer;
  begin
    if Supports(aElement, IwbMainRecord, MainRecord) then begin
      for i := Low(aSignatures) to High(aSignatures) do
        if MainRecord.Signature = aSignatures[i] then begin
          if High(Records) < Count then
            SetLength(Records, Length(Records) * 2);
          Records[Count] := MainRecord;
          Inc(Count);
          Break;
        end;
    end else if Supports(aElement, IwbContainerElementRef, Container) then
      for i := 0 to Pred(Container.ElementCount) do
        FindRecords(Container.Elements[i], aSignatures, Records, Count);
  end;

var
  MainRecord, Master  : IwbMainRecord;
  i, j, Count         : Integer;
begin
  Count := 0;
  SetLength(Result, 4096);
  if Supports(aElement, IwbMainRecord, MainRecord) then begin
    FindRecords(MainRecord.ChildGroup, aSignatures, Result, Count);
    // include overrides from plugins loaded later for that record
    if aOverrides then begin
      Master := MainRecord.MasterOrSelf;
      for i := 0 to Pred(Master.OverrideCount) do
        if Master.Overrides[i]._File.LoadOrder > MainRecord._File.LoadOrder then
          FindRecords(Master.Overrides[i].ChildGroup, aSignatures, Result, Count);
    end;
  end else
    // if Group or File object is passed, no overrides
    FindRecords(aElement, aSignatures, Result, Count);

  SetLength(Result, Count);
  // removing duplicates (overridden records)
  if aOverrides and (Length(Result) > 1) then begin
    wbMergeSortPtr(@Result[0], Length(Result), CompareElementsFormIDAndLoadOrder);
    j := 0;
    for i := Succ(Low(Result)) to High(Result) do begin
      if Result[j].LoadOrderFormID <> Result[i].LoadOrderFormID then
        Inc(j);
      if j <> i then
        Result[j] := Result[i];
    end;
    SetLength(Result, Succ(j));
  end;
end;

function FindMatchText(Strings: TStrings; const Str: string): Integer;
begin
  for Result := 0 to Strings.Count-1 do
    if SameText(Strings[Result], Str) then
      Exit;
  Result := -1;
end;

function IsFileESM(const aFileName: string): Boolean;
const
  ghostesm = '.esm.ghost';
begin
  Result := SameText(ExtractFileExt(aFileName), '.esm') or
    SameText(Copy(aFileName, Length(aFileName) - Length(ghostesm) + 1, Length(ghostesm)), ghostesm)
end;

function IsFileESP(const aFileName: string): Boolean;
const
  ghostesp = '.esp.ghost';
begin
  Result := SameText(ExtractFileExt(aFileName), '.esp') or
    SameText(Copy(aFileName, Length(aFileName) - Length(ghostesp) + 1, Length(ghostesp)), ghostesp)
end;

function IsFileESL(const aFileName: string): Boolean;
const
  ghostesl = '.esl.ghost';
begin
  Result := SameText(ExtractFileExt(aFileName), '.esl') or
    SameText(Copy(aFileName, Length(aFileName) - Length(ghostesl) + 1, Length(ghostesl)), ghostesl)
end;

function IsFileCC(const aFileName: string): Boolean;
const
  ccFileMask = 'cc([a-z]{3})(sse|fo4)(\d{3})\-(\S+)\.(esp|esm|esl)';
begin
  if Length(wbCreationClubContent) <> 0 then
    Result := MatchText(aFileName, wbCreationClubContent)
  else
  with TPerlRegEx.Create do try
    Subject := aFileName;
    RegEx := ccFileMask;
    Options := [preCaseLess, preSingleLine];
    Result := MatchAgain;
  finally
    Free;
  end;
end;

procedure DeleteDirectory(const DirName: string);
var
  FileOp: TSHFileOpStruct;
begin
  FillChar(FileOp, SizeOf(FileOp), 0);
  FileOp.wFunc := FO_DELETE;
  FileOp.pFrom := PChar(DirName+#0);//double zero-terminated
  FileOp.fFlags := FOF_SILENT or FOF_NOERRORUI or FOF_NOCONFIRMATION;
  SHFileOperation(FileOp);
end;

function FullPathToFilename(aString: string): string;
var
  i: Integer;
  s: string;
begin
  s := aString;
  for i := Length(s) downto 1 do
    if Copy(s, i, 3) = ' \ ' then begin
      Delete(s, i, 1);
      Delete(s, i+1, 1);
    end else if Copy(s, i, 2) = ' \' then begin
      Delete(s, i, 1);
  	end else if s[i] = '"' then
      s[i] := ''''
  	else if s[i] = ':' then
      s[i] := '-'
  	else if s[i] = '/' then
      s[i] := ' ';
  while (Length(s)>0) and (s[Length(s)]=' ') do
    Delete(s, Length(s), 1);
  Result := s;
end;

procedure wbFlipBitmap(aBitmap: TBitmap; MirrorType: Integer);
var
  MemBmp: TBitmap;
  Dest: TRect;
begin
  if not Assigned(aBitmap) then
    Exit;

  MemBmp := TBitmap.Create;
  try
    MemBmp.Assign(aBitmap);
    case MirrorType of
      1:
        begin
          Dest.Left := MemBmp.Width;
          Dest.Top := 0;
          Dest.Right := -MemBmp.Width;
          Dest.Bottom := MemBmp.Height
        end;
      2:
        begin
          Dest.Left := 0;
          Dest.Top := MemBmp.Height;
          Dest.Right := MemBmp.Width;
          Dest.Bottom := -MemBmp.Height
        end;
      0:
        begin
          Dest.Left := MemBmp.Width;
          Dest.Top := MemBmp.Height;
          Dest.Right := -MemBmp.Width;
          Dest.Bottom := -MemBmp.Height
        end;
    end;
    StretchBlt(MemBmp.Canvas.Handle, Dest.Left, Dest.Top, Dest.Right, Dest.Bottom,
               MemBmp.Canvas.Handle, 0, 0, MemBmp.Width, MemBmp.Height,
               SRCCOPY);
    aBitmap.Assign(MemBmp);
  finally
    FreeAndNil(MemBmp);
  end;
end;

function wbAlphaBlend(DestDC, X, Y, Width, Height,
  SrcDC, SrcX, SrcY, SrcWidth, SrcHeight, Alpha: integer): Boolean;
var
  BlendFunc: TBlendFunction;
begin
  BlendFunc.BlendOp := AC_SRC_OVER;
  BlendFunc.BlendFlags := 0;
  BlendFunc.SourceConstantAlpha := Alpha;
  if Alpha = 255 then
    BlendFunc.AlphaFormat := AC_SRC_ALPHA
  else
    BlendFunc.AlphaFormat := 0;
  Result := Windows.AlphaBlend(DestDC, X, Y, Width, Height, SrcDC, SrcX, SrcY, SrcWidth, SrcHeight, BlendFunc);
end;

procedure SaveFont(aIni: TMemIniFile; aSection, aName: string; aFont: TFont);
begin
  aIni.WriteString(aSection, aName + 'Name', aFont.Name);
  aIni.WriteInteger(aSection, aName + 'CharSet', aFont.CharSet);
  aIni.WriteInteger(aSection, aName + 'Color', aFont.Color);
  aIni.WriteInteger(aSection, aName + 'Size', aFont.Size);
  aIni.WriteInteger(aSection, aName + 'Style', Byte(aFont.Style));
end;

procedure LoadFont(aIni: TMemIniFile; aSection, aName: string; aFont: TFont);
begin
  aFont.Name    := aIni.ReadString(aSection, aName + 'Name', aFont.Name);
  aFont.CharSet := TFontCharSet(aIni.ReadInteger(aSection, aName + 'CharSet', aFont.CharSet));
  aFont.Color   := TColor(aIni.ReadInteger(aSection, aName + 'Color', aFont.Color));
  aFont.Size    := aIni.ReadInteger(aSection, aName + 'Size', aFont.Size);
  aFont.Style   := TFontStyles(Byte(aIni.ReadInteger(aSection, aName + 'Style', Byte(aFont.Style))));
end;

function wbExpandFileName(const aFileName: string): string;
begin
  if ExtractFilePath(aFileName) = '' then
    Result := wbDataPath + ExtractFileName(aFileName)
  else
    Result := aFileName;
end;


var
  crctbl: array[0..7] of array[0..255] of cardinal;

procedure CRCInit;
var
  c: cardinal;
  i, j: integer;
begin;
  for i:=0 to 255 do begin;
    c:=i;
    for j:=1 to 8 do if odd(c)
                     then c:=(c shr 1) xor $EDB88320
                     else c:=(c shr 1);
    crctbl[0][i]:=c;
    end;

  for i:=0 to 255 do begin;
    c:=crctbl[0][i];
    for j:=1 to 7 do begin;
      c:=(c shr 8) xor crctbl[0][byte(c)];
      crctbl[j][i]:=c;
      end;
    end;
end;

{$IFDEF WIN64}
function crc32_update(inbuffer: pointer; buffersize, crc: DWord): DWord;
// crc-32.  Processes 4 bytes at a time.
type
  PDWord = ^DWord;
  PByte = ^Byte;
var
  currptr: pointer;
  i: byte;
begin
  currptr := inbuffer;
  Result := crc;
  while buffersize > 4 do
    begin
      Result := Result xor PDWord(currptr)^;
      inc(PByte(currptr), 4);
      Result := (Result shr 8) xor Crc32Tab[Byte(Result)];
      Result := (Result shr 8) xor Crc32Tab[Byte(Result)];
      Result := (Result shr 8) xor CRC32Tab[Byte(Result)];
      Result := (Result shr 8) xor crc32Tab[Byte(Result)];
      dec(buffersize, 4);
    end;
  for i := 1 to buffersize do
    begin
      Result := CRC32tab[Byte(Result xor DWord(PByte(currptr)^))] xor (Result shr 8);
      inc(PByte(currptr), 1);
    end;
end;
{$ENDIF}

Function CRCend( crc : DWord ): DWord;
begin
  CRCend := (crc xor CRCSeed);
end;

function ShaCrcRefresh(OldCRC: cardinal; BufPtr: pointer; BufLen: integer): cardinal;
// Fast CRC32 calculator
// (c) Aleksandr Sharahov 2009
// Free for any use
{$IFDEF WIN64}
begin
  Result := crc32_update(BufPtr, BufLen, OldCRC);
{$ENDIF WIN64}
{$IFDEF WIN32}
asm
  test edx, edx
  jz   @ret
  neg  ecx
  jz   @ret
  push ebx
@head:
  test dl, 3
  jz   @bodyinit
  movzx ebx, byte [edx]
  inc  edx
  xor  bl, al
  shr  eax, 8
  xor  eax, [ebx*4 + crctbl]
  inc  ecx
  jnz  @head
  pop  ebx
@ret:
  ret
@bodyinit:
  sub  edx, ecx
  add  ecx, 8
  jg   @bodydone
  push esi
  push edi
  mov  edi, edx
  mov  edx, eax
@bodyloop:
  mov ebx, [edi + ecx - 4]
  xor edx, [edi + ecx - 8]
  movzx esi, bl
  mov eax, [esi*4 + crctbl + 1024*3]
  movzx esi, bh
  xor eax, [esi*4 + crctbl + 1024*2]
  shr ebx, 16
  movzx esi, bl
  xor eax, [esi*4 + crctbl + 1024*1]
  movzx esi, bh
  xor eax, [esi*4 + crctbl + 1024*0]

  movzx esi, dl
  xor eax, [esi*4 + crctbl + 1024*7]
  movzx esi, dh
  xor eax, [esi*4 + crctbl + 1024*6]
  shr edx, 16
  movzx esi, dl
  xor eax, [esi*4 + crctbl + 1024*5]
  movzx esi, dh
  xor eax, [esi*4 + crctbl + 1024*4]

  add ecx, 8
  jg  @done

  mov ebx, [edi + ecx - 4]
  xor eax, [edi + ecx - 8]
  movzx esi, bl
  mov edx, [esi*4 + crctbl + 1024*3]
  movzx esi, bh
  xor edx, [esi*4 + crctbl + 1024*2]
  shr ebx, 16
  movzx esi, bl
  xor edx, [esi*4 + crctbl + 1024*1]
  movzx esi, bh
  xor edx, [esi*4 + crctbl + 1024*0]

  movzx esi, al
  xor edx, [esi*4 + crctbl + 1024*7]
  movzx esi, ah
  xor edx, [esi*4 + crctbl + 1024*6]
  shr eax, 16
  movzx esi, al
  xor edx, [esi*4 + crctbl + 1024*5]
  movzx esi, ah
  xor edx, [esi*4 + crctbl + 1024*4]

  add ecx, 8
  jle @bodyloop
  mov eax, edx
@done:
  mov edx, edi
  pop edi
  pop esi
@bodydone:
  sub ecx, 8
  jl @tail
  pop ebx
  ret
@tail:
  movzx ebx, byte [edx + ecx];
  xor bl,al;
  shr eax,8;
  xor eax, [ebx*4 + crctbl];
  inc ecx;
  jnz @tail;
  pop ebx
  ret
{$ENDIF WIN32}
end;

function wbCRC32Ptr(aData: Pointer; aSize: Integer): TwbCRC32;
begin
  Result := not ShaCrcRefresh($FFFFFFFF, aData, aSize);
end;

function wbCRC32Data(aData: TBytes): TwbCRC32;
begin
  Result := not ShaCrcRefresh($FFFFFFFF, @aData[0], Length(aData));
end;

function wbCRC32File(aFileName: string): TwbCRC32;
var
  Data: TBytes;
begin
  Result := 0;
  if FileExists(aFileName) then
    with TFileStream.Create(aFileName, fmOpenRead + fmShareDenyNone) do try
      SetLength(Data, Size);
      ReadBuffer(Data[0], Length(Data));
      Result := wbCRC32Data(Data);
    finally
      Free;
    end;
end;

var
  _CRC32AppLock : TRTLCriticalSection;
  _CRC32App     : Cardinal;

function wbCRC32App: TwbCRC32;
begin
  if (DebugHook <> 0) or wbDevMode then
    Exit(wbDevCRC32App);

  Result := _CRC32App;
  if Result = 0 then begin
    _CRC32AppLock.Enter;
    try
      Result := _CRC32App;
      if Result = 0 then begin
        Result := wbCRC32File(ParamStr(0));
        _CRC32App := Result;
      end;
    finally
      _CRC32AppLock.Leave;
    end;
  end;
end;

function wbDecodeCRCList(const aList: string): TDynCardinalArray;
var
  i: Integer;
  s: string;
  j: Int64;
begin
  Result := nil;
  try
    with TStringList.Create do try
      CommaText := aList;
      for i := 0 to Pred(Count) do begin
        s := Trim(Strings[i]);
        if Length(s) <> 8 then
          Abort;
        j := StrToInt64('$'+s);
        if (j < Low(Cardinal)) or (j > High(Cardinal)) then
          Abort;
        SetLength(Result, Succ(Length(Result)));
        Result[High(Result)] := j;
      end;
    finally
      Free;
    end;
  except
    SetLength(Result, 1);
    Result[0] := $FFFFFFFF;
  end;
end;

function bscrc32(const aText: string): Cardinal;
var
  i: Integer;
begin
  Result := 0;
  for i := 1 to Length(aText) do
    Result := (Result shr 8) xor CRC32tab[(Result xor Byte(AnsiChar(aText[i]))) and $FF];
end;


function CryptAcquireContext(var phProv: DWORD;
  pszContainer, pszProvider: LPCSTR; dwProvType, dwFlags: DWORD): BOOL;
  stdcall; external advapi32 name 'CryptAcquireContextA';
function CryptCreateHash(hProv,Algid,hKey,dwFlags: DWORD;
  var phHash: DWORD): BOOL; stdcall; external advapi32;
function CryptHashData(hHash: DWORD; pbData: PBYTE; dwDataLen,
  dwFlags: DWORD): BOOL; stdcall; external advapi32;
function CryptGetHashParam(hHash, dwParam: DWORD; pbData: PBYTE;
  var pdwDataLen: DWORD; dwFlags: DWORD): BOOL; stdcall; external advapi32;
function CryptDestroyHash(hHash: DWORD): BOOL; stdcall; external advapi32;
function CryptReleaseContext(hProv: DWORD; dwFlags: DWORD): BOOL; stdcall; external advapi32;

function CryptoAPIGetHash(Data: Pointer; nSize: Cardinal; HashType: Cardinal): TBytes;
const
  HP_HASHVAL           = $0002; {hash value}
  PROV_RSA_FULL        = 1;
  CRYPT_VERIFYCONTEXT  = $F0000000;
var
  hProv, hHash: Cardinal;
begin
  if CryptAcquireContext(hProv, nil, nil, PROV_RSA_FULL, CRYPT_VERIFYCONTEXT) then try
    if CryptCreateHash(hProv, HashType, 0, 0, hHash) then try
      if CryptHashData(hHash, Data, nSize, 0) then begin
        if CryptGetHashParam(hHash, HP_HASHVAL, nil, nSize, 0) then begin
          SetLength(Result, nSize);
          if not CryptGetHashParam(hHash, HP_HASHVAL, @Result[0], nSize, 0) then
            SetLength(Result, 0);
        end;
      end;
    finally
      CryptDestroyHash(hHash);
    end;
  finally
    CryptReleaseContext(hProv, 0);
  end;
end;

const
  ALG_CRC32 = $0001;
  ALG_MD2 = $8001;
  ALG_MD4 = $8002;
  ALG_MD5 = $8003;
  ALG_SHA = $8004;

function wbCryptoApiHashData(aData: TBytes; aALG: Cardinal): string;
  function BytesToHexStr(aBytes: TBytes): string;
  var
    i: Cardinal;
    bt: Byte;
  const
    Hex = '0123456789abcdef';
  begin
    Result:= '';
    for i:= Low(aBytes) to High(aBytes) do begin
      bt := aBytes[i];
      Result:= Result + Hex[bt shr $4 + 1] + Hex[bt and $0f + 1]
    end;
  end;
begin
  Result := BytesToHexStr(CryptoAPIGetHash(@aData[0], Length(aData), aALG));
end;

function wbSHA1Data(aData: TBytes): string;
begin
  Result := wbCryptoApiHashData(aData, ALG_SHA);
end;

function wbSHA1File(aFileName: string): string;
var
  Data: TBytes;
begin
  Result := '';
  if FileExists(aFileName) then
    with TFileStream.Create(aFileName, fmOpenRead + fmShareDenyNone) do try
      SetLength(Data, Size);
      ReadBuffer(Data[0], Length(Data));
      Result := wbSHA1Data(Data);
    finally
      Free;
    end;
end;

function wbMD5Data(aData: TBytes): string;
begin
  Result := wbCryptoApiHashData(aData, ALG_MD5);
end;

function wbMD5File(aFileName: string): string;
var
  Data: TBytes;
begin
  Result := '';
  if FileExists(aFileName) then
    with TFileStream.Create(aFileName, fmOpenRead + fmShareDenyNone) do try
      SetLength(Data, Size);
      ReadBuffer(Data[0], Length(Data));
      Result := wbMD5Data(Data);
    finally
      Free;
    end;
end;

function wbExtractNameFromPath(aPathName: String): String;
begin
  Result := aPathName;
  while Pos('\', Result) > 0 do
    Delete(Result, 1, Pos('\', Result))
end;

function wbCounterAfterSet(aCounterName: String; const aElement: IwbElement): Boolean;
var
  Element         : IwbElement;
  Container       : IwbContainer;
  SelfAsContainer : IwbContainer;
begin
  Result := False;
  if wbBeginInternalEdit then try
    if (Length(aCounterName) >= 4) and Supports(aElement.Container, IwbContainer, Container) and
      Supports(aElement, IwbContainer, SelfAsContainer) then begin
      Element := Container.ElementByName[aCounterName];
      if not Assigned(Element) then  // Signatures not listed in mrDef cannot be added
        Element := Container.Add(Copy(aCounterName, 1, 4));
      if Assigned(Element) and (SameText(Element.Name, aCounterName)) then try
        if Element.GetNativeValue <> SelfAsContainer.GetElementCount then
          // if count = 0 and counter element is not required, then just remove it
          if (SelfAsContainer.GetElementCount = 0) and not Element.Def.Required then
            Element.Remove
          else
            Element.SetNativeValue(SelfAsContainer.GetElementCount);

        Result := True;
      except
        // No exception if the value cannot be set, expected non value
      end;
    end;
  finally
    wbEndInternalEdit;
  end;
end;

function wbCounterByPathAfterSet(aCounterName: String; const aElement: IwbElement): Boolean;
var
  Element         : IwbElement;
  Container       : IwbContainer;
  SelfAsContainer : IwbContainer;
begin
  Result := False;
  if wbBeginInternalEdit then try
    if (Length(aCounterName) >= 4) and Supports(aElement.Container, IwbContainer, Container) and
      Supports(aElement, IwbContainer, SelfAsContainer) then begin
      Element := Container.ElementByPath[aCounterName];
//      if not Assigned(Element) then  // Signatures not listed in mrDef cannot be added
//        Element := Container.Add(Copy(aCounterName, 1, 4));
      if Assigned(Element) and (SameText(Element.Name, wbExtractNameFromPath(aCounterName))) then try
        if Element.GetNativeValue <> SelfAsContainer.GetElementCount then
          // if count = 0 and counter element is not required, then just remove it
          if (SelfAsContainer.GetElementCount = 0) and not Element.Def.Required then
            Element.Remove
          else
            Element.SetNativeValue(SelfAsContainer.GetElementCount);

        Result := True;
      except
        // No exception if the value cannot be set, expected non value
      end;
    end;
  finally
    wbEndInternalEdit;
  end;
end;

function wbCounterContainerAfterSet(aCounterName: String; anArrayName: String; const aElement: IwbElement): Boolean;
var
  Element         : IwbElement;
  Elems           : IwbElement;
  Container       : IwbContainer;
begin
  Result := False;  // You may need to check alternative counter name
  if wbBeginInternalEdit then try
    if not Supports(aElement, IwbContainer, Container) then
      Exit;

    Element := Container.ElementByName[aCounterName];
    if not Assigned(Element) then
      Exit;

    Elems   := Container.ElementByName[anArrayName];
    if not Assigned(Elems) then
      if Element.GetNativeValue <> 0 then
        Element.SetNativeValue(0)
      // if count = 0 and counter element is not required, then just remove it
      else if not Element.Def.Required then
        Container.RemoveElement(aCounterName);

    Result := True; // Counter member exists
  finally
    wbEndInternalEdit;
  end;
end;

function wbCounterContainerByPathAfterSet(aCounterName: String; anArrayName: String; const aElement: IwbElement): Boolean;
var
  Element         : IwbElement;
  Elems           : IwbElement;
  Container       : IwbContainer;
begin
  Result := False;  // You may need to check alterative counter name
  if wbBeginInternalEdit then try
    if Supports(aElement, IwbContainer, Container) then begin
      Element := Container.ElementByPath[aCounterName];
      Elems   := Container.ElementByName[anArrayName];
      if Assigned(Element) then begin
        if not Assigned(Elems) then
          if Element.GetNativeValue <> 0 then
            Element.SetNativeValue(0);
        Result := True; // Counter member exists
      end;
    end;
  finally
    wbEndInternalEdit;
  end;
end;

// BSA helper

function MakeDataFileName(FileName, DataPath: String): String;
begin
  // MO uses 3 chars aliases
  if Length(FileName) < 3 then
    Result := ''
  else if not ((FileName[1] = '\') or (FileName[2] = ':')) then
    Result := DataPath + FileName
  else
    Result := FileName;
end;

function FindBSAs(IniName, DataPath: String; var bsaNames: TStringList; var bsaMissing: TStringList): Integer;
var
  i: Integer;
  j: Integer;
  s: String;
  t: String;
begin
  Result := 0;
  j := 0;
  if Assigned(bsaNames) then
    j := bsaNames.Count;
  if Assigned(bsaMissing) then
    j := j + bsaMissing.Count;

  if Assigned(bsaNames) then
    // TIniFile uses GetPrivateProfileString() to read data, it is virtualized by MO
    // TMemIniFile reads from string list directly, not supported by MO
    with TIniFile.Create(iniName) do try
      with TStringList.Create do try
        if wbGameMode in [gmTES4, gmFO3, gmFNV] then begin
          s := StringReplace(ReadString('Archive', 'sArchiveList', ''), ',' ,#10, [rfReplaceAll]);
          // Update.bsa is hardcoded to load in FNV
          if wbGameMode = gmFNV then begin
            if s <> '' then s := s + #10;
            s := s + 'Update.bsa';
          end;
          Text := s;
        end else if wbIsSkyrim then
          Text := StringReplace(
            ReadString('Archive', 'sResourceArchiveList', '') + ',' +
            ReadString('Archive', 'sResourceArchiveList2', ''),
            ',', #10, [rfReplaceAll]
          )
        else if wbIsFallout4 then
          Text := StringReplace(
            ReadString('Archive', 'sResourceIndexFileList', '') + ',' +
            ReadString('Archive', 'sResourceStartUpArchiveList', '') + ',' +
            ReadString('Archive', 'sResourceArchiveList', '') + ',' +
            ReadString('Archive', 'sResourceArchiveList2', ''),
            ',', #10, [rfReplaceAll]
          );
        for i := 0 to Pred(Count) do begin
          s := Trim(Strings[i]);
          t := MakeDataFileName(s, DataPath);
          if (Length(t)>0) then
            if FileExists(t) then begin
              if wbContainerHandler.ContainerExists(t) then
                Continue;
              bsaNames.Add(s);
            end else
              if Assigned(bsaMissing) then
                bsaMissing.Add(s);
        end;
        Result := bsaNames.Count  + bsaMissing.Count - j; // How many were added
      finally
        Free;
      end;
    finally
      Free;
    end;
end;

function HasBSAs(ModName, DataPath: String; Exact, modini: Boolean; var bsaNames: TStringList; var bsaMissing: TStringList): Integer;
var
  j: Integer;
  t: String;
  F: TSearchRec;
begin
  Result := 0;
  j := 0;
  if Assigned(bsaNames) then
    j := bsaNames.Count;
  if Assigned(bsaMissing) then
    j := j + bsaMissing.Count;
  // All games prior to Skyrim load BSA files with partial matching, Skyrim requires exact name match and
  //   can use a private ini to specify the bsa to use.
  if not exact then
    ModName := ModName + '*';
  if FindFirst(DataPath + ModName + wbArchiveExtension, faAnyFile, F) = 0 then try
    repeat
      if wbContainerHandler.ContainerExists(DataPath + F.Name) then
        Continue;
      t := MakeDataFileName(F.Name, DataPath);
      if (Length(t)>0) and FileExists(t) then begin
        if not wbContainerHandler.ContainerExists(t) then
          if Assigned(bsaNames) then
            bsaNames.Add(F.Name);
      end else
        if Assigned(bsaMissing) then
          bsaMissing.Add(F.Name);
    until FindNext(F) <> 0;
    Result := bsaNames.Count  + bsaMissing.Count - j;
  finally
    FindClose(F);
  end;

  if modIni then
    Result := Result + FindBSAs(DataPath+ChangeFileExt(ModName, '.ini'), DataPath, bsaNames, bsaMissing);
end;

function wbDDSDataToBitmap(aData: TBytes; Bitmap: TBitmap): Boolean;
var
  img: TImageData;
  ms: TMemoryStream;
begin
  Result := False;
  if not LoadImageFromMemory(@aData[0], Length(aData), img) then
    Exit;
  ms := TMemoryStream.Create;
  try
    if SaveImageToStream('BMP', ms, img) then begin
      ms.Position := 0;
      Bitmap.LoadFromStream(ms);
      Result := True;
    end;
  finally
    FreeImage(img);
    ms.Free;
  end;
end;

function wbDDSStreamToBitmap(aStream: TStream; Bitmap: TBitmap): Boolean;
var
  img: TImageData;
  ms: TMemoryStream;
begin
  Result := False;
  if not LoadImageFromStream(aStream, img) then
    Exit;
  ms := TMemoryStream.Create;
  try
    if SaveImageToStream('BMP', ms, img) then begin
      ms.Position := 0;
      Bitmap.LoadFromStream(ms);
      Result := True;
    end;
  finally
    FreeImage(img);
    ms.Free;
  end;
end;

function wbIsAssociatedWithExtension(aExt: string): Boolean;
var
  Name: string;
begin
  Result := False;
  with TRegistry.Create do try
    RootKey := HKEY_CURRENT_USER;
    if OpenKey('\Software\Classes\' + LowerCase(aExt), False) then begin
      Name := ReadString('');
      if OpenKey('\Software\Classes\' + Name + '\DefaultIcon', False) then
        if SameText(ReadString(''), ParamStr(0)) then
          Result := True;
    end;
  finally
    Free;
  end;
end;

function wbAssociateWithExtension(aExt, aName, aDescr: string): Boolean;
begin
  Result := False;

  if aExt = '' then
    Exit
  else
    aExt := LowerCase(aExt);

  if aExt[1] <> '.' then
    aExt := '.' + aExt;

  with TRegistry.Create do try
    RootKey := HKEY_CURRENT_USER;

    if OpenKey('\Software\Classes\' + aExt, True) then
      WriteString('', aName)
    else
      raise Exception.Create('Not enough rights to modify the registry');

    if OpenKey('\Software\Classes\' + aName, True) then
      WriteString('', aDescr);

    if OpenKey('\Software\Classes\' + aName + '\DefaultIcon', True) then
      WriteString('', ParamStr(0));

    if OpenKey('\Software\Classes\' + aName + '\shell\open\command', True) then
      WriteString('', ParamStr(0) + ' "%1"');

    Result := True;
  finally
    Free;
  end;

  SHChangeNotify(SHCNE_ASSOCCHANGED, SHCNF_IDLIST, nil, nil);
end;

function wbFormVerDecider(aBasePtr: Pointer; aEndPtr: Pointer; const aElement: IwbElement; aMinimum: Integer): Integer;
var
  FormVer    : Integer;
  MainRecord : IwbMainRecord;
  Element    : IwbElement;
begin
  Result := 1;
  if not Assigned(aElement) then Exit;
  MainRecord := aElement.GetContainingMainRecord;
  if not Assigned(MainRecord) then Exit;

  Element := MainRecord.ElementByPath['Record Header\Form Version'];
  if Assigned(Element) then begin
    FormVer := Element.NativeValue;
    if FormVer<aMinimum then
      Result := 0;
  end;
end;

function wbFormVer78Decider(aBasePtr: Pointer; aEndPtr: Pointer; const aElement: IwbElement): Integer;
begin
  Result := wbFormVerDecider(aBasePtr, aEndPtr, aElement, 78);
end;

function ExecuteCaptureConsoleOutput(const aCommandLine: string): Cardinal;
type
  OemString = type AnsiString(CP_OEMCP);
const
  CReadBuffer = 4096;
var
  saSecurity: TSecurityAttributes;
  hRead: THandle;
  hWrite: THandle;
  suiStartup: TStartupInfo;
  piProcess: TProcessInformation;
  pBuffer: array [0..CReadBuffer] of AnsiChar;
  dBuffer: array [0..CReadBuffer] of Char;
  pCmdLine: array [0..MAX_PATH] of Char;
  dRead, dRunning, dw: DWord;
  s: string;
begin
  saSecurity.nLength := SizeOf(TSecurityAttributes);
  saSecurity.bInheritHandle := True;
  saSecurity.lpSecurityDescriptor := nil;

  if CreatePipe(hRead, hWrite, @saSecurity, 0) then begin
    try
      FillChar(suiStartup, SizeOf(TStartupInfo), #0);
      suiStartup.cb := SizeOf(TStartupInfo);
      suiStartup.hStdInput := hRead;
      suiStartup.hStdOutput := hWrite;
      suiStartup.hStdError := hWrite;
      suiStartup.dwFlags := STARTF_USESTDHANDLES or STARTF_USESHOWWINDOW;
      suiStartup.wShowWindow := SW_HIDE;

      StrPCopy(pCmdLine, aCommandLine);
      if CreateProcess(nil, pCmdLine, @saSecurity, @saSecurity, True, NORMAL_PRIORITY_CLASS, nil, nil, suiStartup, piProcess) then begin
        try
          repeat
            dRunning := WaitForSingleObject(piProcess.hProcess, 100);
            Application.ProcessMessages;

            if wbForceTerminate or (GetKeyState(VK_ESCAPE) and 128 = 128) then begin
              dw := Integer(TerminateProcess(piProcess.hProcess, 1));
              if dw <> 0 then begin
                dw := WaitForSingleObject(piProcess.hProcess, 1000);
                if dw = WAIT_FAILED then
                  Result := GetLastError;
              end else
                Result := GetLastError;

              wbProgressCallback('Interrupted by user!');
              Exit;
            end;

            if PeekNamedPipe(hRead, nil, 0, nil, @dRead, nil) then begin
              if dRead > 0 then repeat
                dRead := 0;
                ReadFile(hRead, pBuffer[0], CReadBuffer, dRead, nil);
                pBuffer[dRead] := #0;
                OemToChar(pBuffer, dBuffer);
                s := Trim(string(Oemstring(pBuffer)));
                if s <> '' then
                  wbProgressCallback(s);
              until dRead < CReadBuffer;
            end;
          until dRunning <> WAIT_TIMEOUT;
          GetExitCodeProcess(piProcess.hProcess, Result);
        finally
          CloseHandle(piProcess.hProcess);
          CloseHandle(piProcess.hThread);
        end;
      end else
        RaiseLastOSError;

    finally
      CloseHandle(hRead);
      CloseHandle(hWrite);
    end;
  end else
    RaiseLastOSError;
end;

function wbIsAeroEnabled: Boolean;
type
  _DwmIsCompositionEnabledFunc = function(var IsEnabled: BOOL): HRESULT; stdcall;
var
  Flag                       : BOOL;
  DllHandle                  : THandle;
  OsVersion                  : TOSVersionInfo;
  DwmIsCompositionEnabledFunc: _DwmIsCompositionEnabledFunc;
begin
  Result:=False;
  ZeroMemory(@OsVersion, SizeOf(OsVersion));
  OsVersion.dwOSVersionInfoSize := SizeOf(TOSVERSIONINFO);

  if ((GetVersionEx(OsVersion)) and (OsVersion.dwPlatformId = VER_PLATFORM_WIN32_NT) and (OsVersion.dwMajorVersion >= 6)) then //is Vista or Win7?
  begin
    DllHandle := LoadLibrary('dwmapi.dll');
    try
      if DllHandle <> 0 then
      begin
        @DwmIsCompositionEnabledFunc := GetProcAddress(DllHandle, 'DwmIsCompositionEnabled');
        if (@DwmIsCompositionEnabledFunc <> nil) then
        begin
          if DwmIsCompositionEnabledFunc(Flag)= S_OK then
           Result:=Flag;
        end;
      end;
    finally
      if DllHandle <> 0 then
        FreeLibrary(DllHandle);
    end;
  end;
end;

function wbGetLastWriteTime(const s: string): TDateTime;
var
  F: TSearchRec;
begin
  if FindFirst(s, faAnyFile, F) = 0 then try
    Result := F.TimeStamp;
  finally
    FindClose(F);
  end else
    Result := TFile.GetLastWriteTime(s);
end;


initialization
  CRCInit;
  _CRC32AppLock.Initialize;
finalization
  _CRC32AppLock.Destroy;
end.

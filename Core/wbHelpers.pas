{******************************************************************************

  This Source Code Form is subject to the terms of the Mozilla Public License,
  v. 2.0. If a copy of the MPL was not distributed with this file, You can obtain
  one at https://mozilla.org/MPL/2.0/.

*******************************************************************************}

unit wbHelpers;

{$I wbDefines.inc}

interface

uses
  System.Classes,
  System.IniFiles,
  System.SysUtils,

  Vcl.Graphics,

  JSonDataObjects,

  wbHash,
  wbInterface;

function GetContainerFromUnion           (const aElement: IwbElement): IwbContainer;
function GetContainerRefFromUnionOrValue (const aElement: IwbElement): IwbContainerElementRef;
function GetElementFromUnion             (const aElement: IwbElement): IwbElement;

function wbTryGetContainerByName             (const aElement: IwbElement; out aContainer: IwbContainerElementRef; const aName: string): Boolean;
function wbTryGetContainerFromUnion          (const aElement: IwbElement; out aContainer: IwbContainer): Boolean;
function wbTryGetContainerRefFromUnionOrValue(const aElement: IwbElement; out aContainer: IwbContainerElementRef): Boolean;
function wbTryGetContainerWithValidMainRecord(const aElement: IwbElement; out aContainer: IwbContainerElementRef; out aMainRecord: IwbMainRecord): Boolean;
function wbTryGetContainingMainRecord        (const aElement: IwbElement; out aMainRecord: IwbMainRecord): Boolean;
function wbTryGetMainRecord                  (const aElement: IwbElement; out aMainRecord: IwbMainRecord; const aSignature: string = ''): Boolean;
function wbTrySetContainer                   (const aElement: IwbElement; aType: TwbCallbackType; out aContainer: IwbContainerElementRef): Boolean;


function wbDistance(const a, b: TwbVector): Single; overload
function wbDistance(const a, b: IwbMainRecord): Single; overload;
function wbStringToSignatures(const aSignatures: string): TwbSignatures;
function wbGetSiblingREFRsWithin(const aMainRecord: IwbMainRecord; aDistance: Single): TDynMainRecords;
function wbGetSiblingRecords(const aElement: IwbElement; aSignatures: TwbSignatures; aOverrides: Boolean): TDynMainRecords;
function FindMatchText(Strings: TStrings; const Str: string): Integer;
procedure DeleteDirectory(const DirName: string);
function FullPathToFilename(const aString: string): string;
procedure wbFlipBitmap(aBitmap: Vcl.Graphics.TBitmap; MirrorType: Integer); // MirrorType: 1 - horizontal, 2 - vertical, 0 - both
function wbAlphaBlend(DestDC, X, Y, Width, Height,
  SrcDC, SrcX, SrcY, SrcWidth, SrcHeight, Alpha: integer): Boolean;
procedure SaveFont(aIni: TMemIniFile; const aSection, aName: string; aFont: TFont);
procedure LoadFont(aIni: TMemIniFile; const aSection, aName: string; aFont: TFont);
function wbDDSDataToBitmap(const aData: TBytes; Bitmap: Vcl.Graphics.TBitmap): Boolean;
function wbDDSStreamToBitmap(aStream: TStream; Bitmap: Vcl.Graphics.TBitmap): Boolean;
function wbCRC32App: TwbCRC32;
function wbIsAssociatedWithExtension(const aExt: string): Boolean;
function wbAssociateWithExtension(aExt: string; const aName, aDescr: string): Boolean;
function ExecuteCaptureConsoleOutput(const aCommandLine: string): Cardinal;
procedure SerializeArray(const aElement: IwbElement; const aJsonArray: TJsonArray);
procedure SerializeElement(const aElement: IwbElement; const aJsonObj: TJsonObject);
function  SerializeElementToJson(const aElement: IwbElement): TJsonObject;
procedure SerializeStreamArray(const aElement: IwbElement; const aJsonArray: TJsonArray);

type
  PnxLeveledListCheckCircularStack = ^TnxLeveledListCheckCircularStack;
  TnxLeveledListCheckCircularStack = record
    rllcLast       : PnxLeveledListCheckCircularStack;
    rllcMainRecord : IwbMainRecord;
  end;

procedure wbLeveledListCheckCircular(const aMainRecord: IwbMainRecord; aStack: PnxLeveledListCheckCircularStack);

function wbExtractNameFromPath(const aPathName: String): String;

// BSA helper

function MakeDataFileName(const FileName, DataPath: String): String;
function CheckAddFilesToString(var mIni: TIniFile; var cIni: TIniFile; const Section, Ident: String): String;
function FindBSAs(const aContext: TwbGameContext; const IniName, DataPath: String; var bsaNames: TStringList; var bsaMissing: TStringList): Integer; overload;
function FindBSAs(const aContext: TwbGameContext; const IniName, CustomIniName, DataPath: String; var bsaNames: TStringList; var bsaMissing: TStringList): Integer; overload;
function HasBSAs(const aContext: TwbGameContext; ModName : string; const DataPath: String; Exact, modini: Boolean; var bsaNames: TStringList; var bsaMissing: TStringList): Integer;

function wbStripDotGhost(const aFileName: string): string;

type
  TPassThroughFunc<T> = reference to function (const a: T): T;

  TDynStringArray = TArray<string>;

  TStringArrayHelper = record helper for TDynStringArray
    function ForEach(const aFunc: TPassThroughFunc<string>): TArray<string>;
    function AddPrefix(const aPrefix: string): TArray<string>;
    function RemoveEmpty: TArray<string>;
    function ToCommaText: string;
    function ToText: string;
    procedure ReportAsProgress;
    procedure Add(const s: string);
  end;

  TDynPointerArray = TArray<Pointer>;

  TPointerArrayHelper = record helper for TDynPointerArray
    procedure Add(p: Pointer);
  end;

function  wbIsAeroEnabled: Boolean;

function wbGetLastWriteTime(const s: string): TDateTime;

type
  wb<T> = record
    class function Iff(aCond: Boolean; const aTrue, aFalse: T): T; static;
  end;

procedure wbCodeBlock(const aProc: TProc);

function wbVarArray(const aElements: array of Variant): Variant;

implementation

uses
  System.AnsiStrings,
  System.IOUtils,
  System.RegularExpressionsCore,
  System.StrUtils,
  System.SyncObjs,
  System.UITypes,
  System.Variants,
  System.Win.Registry,

  Vcl.Forms,

  Winapi.ShellAPI,
  Winapi.ShlObj,
  Winapi.Windows,

  Imaging,
  ImagingTypes,

  wbSort;

function GetContainerFromUnion(const aElement: IwbElement): IwbContainer;
begin  // Should change the name to GetContainerFromUnionOrValue :)
  if (aElement.ElementType = etUnion) or (aElement.ElementType = etValue) then begin
    Result := aElement.Container;
    while Result.ElementType = etUnion do
      Result := Result.Container
  end else
    Result := aElement as IwbContainer;
end;

function GetContainerRefFromUnionOrValue(const aElement: IwbElement): IwbContainerElementRef;
begin
  Result := nil;
  if (aElement.ElementType = etUnion) or (aElement.ElementType = etValue) then begin
    Supports(aElement.Container, IwbContainerElementRef, Result);
    while Assigned(Result) and (Result.ElementType = etUnion) do
      Supports(Result.Container, IwbContainerElementRef, Result);
  end else
    Supports(aElement, IwbContainerElementRef, Result);
end;

function GetElementFromUnion(const aElement: IwbElement): IwbElement;
begin
  if (aElement.ElementType = etUnion) then begin
    Result := aElement.Container;
    while Assigned(Result) and (Result.ElementType = etUnion) do
      Result := Result.Container;
  end else
    Result := aElement;
end;

function wbTryGetContainerByName(const aElement   : IwbElement;
                                   out aContainer : IwbContainerElementRef;
                                 const aName      : string): Boolean;
begin
  Result := False;

  if not Assigned(aElement) then
    Exit;

  if aElement.Name = aName then
    aContainer := aElement as IwbContainerElementRef
  else
    aContainer := aElement.Container as IwbContainerElementRef;

  if not Assigned(aContainer) then
    Exit;

  while Assigned(aContainer) and (aContainer.Name <> aName) do
    aContainer := aContainer.Container as IwbContainerElementRef;

  if not Assigned(aContainer) then
    Exit;

  Result := True;
end;

function wbTryGetContainerFromUnion(const aElement: IwbElement; out aContainer: IwbContainer): Boolean;
begin
  Result := False;

  if not Assigned(aElement) then
    Exit;

  aContainer := GetContainerFromUnion(aElement);

  if not Assigned(aContainer) then
    Exit;

  Result := True;
end;

function wbTryGetContainerRefFromUnionOrValue(const aElement: IwbElement; out aContainer: IwbContainerElementRef): Boolean;
begin
  Result := False;

  if not Assigned(aElement) then
    Exit;

  aContainer := GetContainerRefFromUnionOrValue(aElement);
  if not Assigned(aContainer) then
    Exit;

  Result := True;
end;

function wbTryGetContainerWithValidMainRecord(const aElement: IwbElement; out aContainer: IwbContainerElementRef; out aMainRecord: IwbMainRecord): Boolean;
begin
  Result := False;

  if not Supports(aElement, IwbContainerElementRef, aContainer) then
    Exit;
  if aContainer.ElementCount < 1 then
    Exit;
  if not Supports(aElement, IwbMainRecord, aMainRecord) then
    Exit;
  if aMainRecord.IsDeleted then
    Exit;

  Result := True;
end;

function wbTryGetContainingMainRecord(const aElement: IwbElement; out aMainRecord: IwbMainRecord): Boolean;
begin
  Result := False;

  if not Assigned(aElement) then
    Exit;

  aMainRecord := aElement.ContainingMainRecord;

  if not Assigned(aMainRecord) then
    Exit;

  Result := True;
end;

function wbTryGetMainRecord(const aElement: IwbElement; out aMainRecord: IwbMainRecord; const aSignature: string = ''): Boolean;
begin
  Result := False;

  if not Assigned(aElement) then
    Exit;

  if not Supports(aElement.LinksTo, IwbMainRecord, aMainRecord) then
    Exit;

  if not SameText(aSignature, '') then
    if aMainRecord.Signature <> aSignature then
      Exit;

  Result := True;
end;

function wbTrySetContainer(const aElement: IwbElement; aType: TwbCallbackType; out aContainer: IwbContainerElementRef): Boolean;
begin
  Result := (aType = ctToSummary) and Supports(aElement, IwbContainerElementRef, aContainer);
end;

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
  Stack      : TnxLeveledListCheckCircularStack;
  s, s1      : string;
  CER        : IwbContainerElementRef;
  Entries    : IwbContainerElementRef;
  Entry      : IwbContainerElementRef;
  i          : Integer;
  Sig        : TwbSignature;
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

  Sig := aMainRecord.Signature;
  if Sig = 'LVLB' then s1 := 'Base Form';
  if Sig = 'LVLC' then s1 := 'Creature';
  if Sig = 'LVLI' then s1 := 'Item';
  if Sig = 'LVLN' then s1 := 'NPC';
  if Sig = 'LVLP' then s1 := 'Pack In';
  if Sig = 'LVPC' then s1 := 'Perk Card';
  if Sig = 'LVSC' then s1 := 'Space Cell';
  if Sig = 'LVSP' then s1 := 'Spell';

  if aMainRecord.GameDefObj.IsOblivion then
    RefPath := s1
  else
    RefPath := 'LVLO\' + s1;

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

function wbStringToSignatures(const aSignatures: string): TwbSignatures;
var
  i: integer;
  s: AnsiString;
begin
  with TStringList.Create do try
    if Pos(',', aSignatures) <> 0 then Delimiter := ',' else Delimiter := ' ';
    StrictDelimiter := True;
    DelimitedText := aSignatures;
    for i := 0 to Pred(Count) do begin
      s := Trim(AnsiString(Strings[i]));
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

function FullPathToFilename(const aString: string): string;
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

procedure wbFlipBitmap(aBitmap: Vcl.Graphics.TBitmap; MirrorType: Integer);
var
  MemBmp: Vcl.Graphics.TBitmap;
  Dest: TRect;
begin
  if not Assigned(aBitmap) then
    Exit;

  MemBmp := Vcl.Graphics.TBitmap.Create;
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
  Result := AlphaBlend(DestDC, X, Y, Width, Height, SrcDC, SrcX, SrcY, SrcWidth, SrcHeight, BlendFunc);
end;

procedure SaveFont(aIni: TMemIniFile; const aSection, aName: string; aFont: TFont);
begin
  aIni.WriteString(aSection, aName + 'Name', aFont.Name);
  aIni.WriteInteger(aSection, aName + 'CharSet', aFont.CharSet);
  aIni.WriteInteger(aSection, aName + 'Color', aFont.Color);
  aIni.WriteInteger(aSection, aName + 'Size', aFont.Size);
  aIni.WriteInteger(aSection, aName + 'Style', Byte(aFont.Style));
end;

procedure LoadFont(aIni: TMemIniFile; const aSection, aName: string; aFont: TFont);
begin
  aFont.Name    := aIni.ReadString(aSection, aName + 'Name', aFont.Name);
  aFont.CharSet := TFontCharSet(aIni.ReadInteger(aSection, aName + 'CharSet', aFont.CharSet));
  aFont.Color   := TColor(aIni.ReadInteger(aSection, aName + 'Color', aFont.Color));
  aFont.Size    := aIni.ReadInteger(aSection, aName + 'Size', aFont.Size);
  aFont.Style   := TFontStyles(Byte(aIni.ReadInteger(aSection, aName + 'Style', Byte(aFont.Style))));
end;

var
  _CRC32AppLock : TRTLCriticalSection;
  _CRC32App     : Cardinal;

function wbCRC32App: TwbCRC32;
begin
  if IsDebuggerPresent or (DebugHook <> 0) or wbDevMode then
    Exit(wbDevCRC32App);

  Result := _CRC32App;
  if Result = 0 then begin
    _CRC32AppLock.Enter;
    try
      Result := _CRC32App;
      if Result = 0 then begin
        Result := TwbHash.CRC32(ParamStr(0));
        _CRC32App := Result;
      end;
    finally
      _CRC32AppLock.Leave;
    end;
  end;
end;

function wbExtractNameFromPath(const aPathName: String): String;
begin
  Result := aPathName;
  while Pos('\', Result) > 0 do
    Delete(Result, 1, Pos('\', Result))
end;

// BSA helper

function MakeDataFileName(const FileName, DataPath: String): String;
begin
  // MO uses 3 chars aliases
  if Length(FileName) < 3 then
    Result := ''
  else if not ((FileName[1] = '\') or (FileName[2] = ':')) then
    Result := DataPath + FileName
  else
    Result := FileName;
end;

function CheckAddFilesToString(var mIni: TIniFile; var cIni: TIniFile; const Section, Ident: String): String;
begin
  Result := '';
  if cIni.ValueExists(Section, Ident) then
    Result := StringReplace(cIni.ReadString(Section, Ident, ''), ',' ,#10, [rfReplaceAll])
  else
    Result := StringReplace(mIni.ReadString(Section, Ident, ''), ',' ,#10, [rfReplaceAll]);
end;

function FindBSAs(const aContext: TwbGameContext; const IniName, DataPath: String; var bsaNames: TStringList; var bsaMissing: TStringList): Integer;
var
  i: Integer;
  j: Integer;
  s: String;
  t: String;
  lGameDef: TwbGameDef;
begin
  lGameDef := aContext.GameDefObj;
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
        if lGameDef.IsOblivion or lGameDef.IsFallout3 then begin
          s := StringReplace(ReadString('Archive', 'sArchiveList', ''), ',' ,#10, [rfReplaceAll]);
          // Update.bsa is hardcoded to load in FNV
          if gcUpdateArchiveAlwaysLoaded in lGameDef.Capabilities then begin
            if s <> '' then s := s + #10;
            s := s + 'Update.bsa';
          end;
          Text := s;
        end else if lGameDef.IsSkyrim then
          Text := StringReplace(
            ReadString('Archive', 'sResourceArchiveList', '') + ',' +
            ReadString('Archive', 'sResourceArchiveList2', ''),
            ',', #10, [rfReplaceAll]
          )
        else if lGameDef.IsFallout4 or lGameDef.IsFallout76 or lGameDef.IsStarfield then
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
              if aContext.ContainerHandler.ContainerExists(t) then
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

function FindBSAs(const aContext: TwbGameContext; const IniName, CustomIniName, DataPath: String; var bsaNames: TStringList; var bsaMissing: TStringList): Integer;
var
  i: Integer;
  j: Integer;
  s: String;
  t: String;
  cIni, mIni: TIniFile;
  lGameDef: TwbGameDef;
begin
  lGameDef := aContext.GameDefObj;
  j := 0;
  if Assigned(bsaNames) then
    j := bsaNames.Count;
  if Assigned(bsaMissing) then
    j := j + bsaMissing.Count;

  if Assigned(bsaNames) then
    // TIniFile uses GetPrivateProfileString() to read data, it is virtualized by MO
    // TMemIniFile reads from string list directly, not supported by MO
    cIni := TIniFile.Create(CustomIniName);
    try
      if not cIni.SectionExists('Archive') then
        Result := FindBSAs(aContext, IniName, DataPath, bsaNames, bsaMissing)
      else begin
        mIni := TIniFile.Create(IniName);
        try
          with TStringList.Create do try
            if lGameDef.IsOblivion or lGameDef.IsFallout3 then begin
              s := CheckAddFilesToString(mIni, cIni, 'Archive', 'sArchiveList');
              // Update.bsa is hardcoded to load in FNV
              if gcUpdateArchiveAlwaysLoaded in lGameDef.Capabilities then begin
                if s <> '' then s := s + #10;
                s := s + 'Update.bsa';
              end;
              Text := s;
            end else if lGameDef.IsSkyrim then begin
              s := CheckAddFilesToString(mIni, cIni, 'Archive', 'sResourceArchiveList');
              if s <> '' then s := s + #10;
              s := s + CheckAddFilesToString(mIni, cIni, 'Archive', 'sResourceArchiveList2');
              Text := s;
            end else if lGameDef.IsFallout4 or lGameDef.IsFallout76 or lGameDef.IsStarfield then begin
              s := CheckAddFilesToString(mIni, cIni, 'Archive', 'sResourceIndexFileList');
              if s <> '' then s := s + #10;
              s := s + CheckAddFilesToString(mIni, cIni, 'Archive', 'sResourceStartUpArchiveList');
              if s <> '' then s := s + #10;
              s := s + CheckAddFilesToString(mIni, cIni, 'Archive', 'sResourceArchiveList');
              if s <> '' then s := s + #10;
              s := s + CheckAddFilesToString(mIni, cIni, 'Archive', 'sResourceArchiveList2');
              Text := s;
            end;

            for i := 0 to Pred(Count) do begin
              s := Trim(Strings[i]);
              t := MakeDataFileName(s, DataPath);
              if (Length(t)>0) then
                if FileExists(t) then begin
                  if aContext.ContainerHandler.ContainerExists(t) then
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
          FreeAndNil(mIni);
        end;
      end;
    finally
      FreeAndNil(cIni);
    end;
end;

function HasBSAs(const aContext: TwbGameContext; ModName: string; const DataPath: String; Exact, modini: Boolean; var bsaNames: TStringList; var bsaMissing: TStringList): Integer;
var
  j: Integer;
  t: String;
  F: TSearchRec;
begin
  Result := 0;

  if modIni then
    Result := Result + FindBSAs(aContext, DataPath+ChangeFileExt(ModName, '.ini'), DataPath, bsaNames, bsaMissing);

  j := 0;
  if Assigned(bsaNames) then
    j := bsaNames.Count;
  if Assigned(bsaMissing) then
    j := j + bsaMissing.Count;
  // All games prior to Skyrim load BSA files with partial matching, Skyrim requires exact name match and
  //   can use a private ini to specify the bsa to use.
  if not exact then
    ModName := ModName + '*';
  if FindFirst(DataPath + ModName + aContext.GameDefObj.ArchiveExtension, faAnyFile, F) = 0 then try
    repeat
      if aContext.ContainerHandler.ContainerExists(DataPath + F.Name) then
        Continue;
      t := MakeDataFileName(F.Name, DataPath);
      if (Length(t)>0) and FileExists(t) then begin
        if not aContext.ContainerHandler.ContainerExists(t) then
          if Assigned(bsaNames) then
            bsaNames.Add(F.Name);
      end else
        if Assigned(bsaMissing) then
          bsaMissing.Add(F.Name);
    until FindNext(F) <> 0;
    Result := bsaNames.Count  + bsaMissing.Count - j;
  finally
    System.SysUtils.FindClose(F);
  end;
end;

function wbDDSDataToBitmap(const aData: TBytes; Bitmap: Vcl.Graphics.TBitmap): Boolean;
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

function wbDDSStreamToBitmap(aStream: TStream; Bitmap: Vcl.Graphics.TBitmap): Boolean;
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

function wbIsAssociatedWithExtension(const aExt: string): Boolean;
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

function wbAssociateWithExtension(aExt: string; const aName, aDescr: string): Boolean;
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
    System.SysUtils.FindClose(F);
  end else
    Result := TFile.GetLastWriteTime(s);
end;

class function wb<T>.Iff(aCond: Boolean; const aTrue, aFalse: T): T;
begin
  if aCond then
    Result := aTrue
  else
    Result := aFalse;
end;

procedure wbCodeBlock(const aProc: TProc);
begin
  aProc;
end;

function wbVarArray(const aElements: array of Variant): Variant;
var
  Elements : array of Variant;
  i        : Integer;
begin
  SetLength(Elements, Length(aElements));
  for i := Low(aElements) to High(aElements) do
    Elements[i] := aElements[i];
  Result := Elements;
end;

// **************** PERK Challenge JSON serialization support
procedure SerializeStreamArray(const aElement: IwbElement; const aJsonArray: TJsonArray);
var
  lContainer: IwbContainer;
  i: Integer;
begin
  if not Supports(aElement, IwbContainer, lContainer) then Exit;

  aJsonArray.Clear;

  for i := 0 to Pred(lContainer.ElementCount) do
  begin
    var lChild := lContainer.Elements[i];
    if Assigned(lChild) and (lChild.ElementType = etValue) then
      aJsonArray.Add(IntToStr(lChild.NativeValue))
    else
      aJsonArray.AddObject(nil);
  end;
end;

procedure SerializeArray(const aElement: IwbElement; const aJsonArray: TJsonArray);
var
  lContainer: IwbContainer;
  lChild: IwbElement;
  i: Integer;
begin
  if not Supports(aElement, IwbContainer, lContainer) then Exit;

  for i := 0 to Pred(lContainer.ElementCount) do
  begin
    lChild := lContainer.Elements[i];

    if not Assigned(lChild) then
    begin
      aJsonArray.AddObject(nil);
      Continue;
    end;

    case lChild.ElementType of
      etValue:
        if VarIsNull(lChild.EditValue) or (lChild.EditValue = '') or
           (lChild.EditValue = '<null>') then
          aJsonArray.AddObject(nil)
        else
          aJsonArray.Add(lChild.EditValue);

      etStruct, etArray:
        aJsonArray.AddObject(SerializeElementToJson(lChild));
    else
      aJsonArray.Add(lChild.EditValue);
    end;
  end;
end;

procedure SerializeElement(const aElement: IwbElement; const aJsonObj: TJsonObject);
var
  lContainer: IwbContainer;
  lChild: IwbElement;
  i: Integer;
  lName: string;
begin
  if not Assigned(aElement) or not Assigned(aJsonObj) then Exit;

  if not Supports(aElement, IwbContainer, lContainer) then
  begin
    aJsonObj.S[aElement.Name] := aElement.EditValue;
    Exit;
  end;

  for i := 0 to Pred(lContainer.ElementCount) do
  begin
    lChild := lContainer.Elements[i];
    if not Assigned(lChild) then Continue;

    lName := lChild.Name;

    // ==================== SPECIAL HANDLING ====================
    if SameText(lName, 'Type') then
    begin
      aJsonObj.S['Type'] := lChild.EditValue;
      Continue;
    end;

    if SameText(lName, 'Stream') then
    begin
      SerializeStreamArray(lChild, aJsonObj.A['Stream']);
      Continue;
    end;
    // ========================================================

    case lChild.ElementType of
      etValue:
        begin
          if VarIsNull(lChild.EditValue) or (lChild.EditValue = '') or
             (lChild.EditValue = '<null>') or (lChild.EditValue = 'NULL') then
            aJsonObj.O[lName] := nil
          else
            aJsonObj.S[lName] := lChild.EditValue;
        end;

      etStruct:
        begin
          // Most "Data" fields are structs
          if SameText(lName, 'Data') then
            aJsonObj.O[lName] := SerializeElementToJson(lChild)
          else
            aJsonObj.O[lName] := SerializeElementToJson(lChild);
        end;

      etArray:
        begin
          if not SameText(lName, 'Stream') then   // already handled above
            SerializeArray(lChild, aJsonObj.A[lName]);
        end
    else
      aJsonObj.S[lName] := lChild.EditValue;
    end;
  end;
end;

function SerializeElementToJson(const aElement: IwbElement): TJsonObject;
begin
  Result := TJsonObject.Create;
  if Assigned(aElement) then
    SerializeElement(aElement, Result);
end;
// **************** End PERK Challenge JSON serialization support

initialization
  _CRC32AppLock.Initialize;
finalization
  _CRC32AppLock.Destroy;
end.

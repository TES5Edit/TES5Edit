{******************************************************************************

  This Source Code Form is subject to the terms of the Mozilla Public License, 
  v. 2.0. If a copy of the MPL was not distributed with this file, You can obtain 
  one at https://mozilla.org/MPL/2.0/.

*******************************************************************************}

unit wbDataFormatNif;

interface

uses
  Types, SysUtils, StrUtils, Classes, Variants, wbDataFormat, JsonDataObjects,
  wbNifMath;

type
  TwbNifVersion = (nfUnknown, nfTES3, nfTES4, nfFO3, nfTES5, nfSSE, nfFO4);
  TwbNifOption = (nfoCollapseLinkArrays, nfoRemoveUnusedStrings);
  TwbNifOptions = set of TwbNifOption;

  TwbNiRefDef = class(TdfIntegerDef)
  private
    FTemplate: string;
    FPtr: Boolean;
  public
    function CreateElement(const aParent: TdfElement): TdfElement; override;
    function Clone: TdfDef; override;
    procedure Assign(const aDef: TdfDef); override;
    property Template: string read FTemplate write FTemplate;
    // False - NiRef (points to previous blocks)
    // True - NiPtr (points to following blocks)
    property Ptr: Boolean read FPtr write FPtr;
  end;

  TwbNiRef = class(TdfInteger)
  protected
    function GetTemplate: string;
    function GetPtr: Boolean;
  public
    property Template: string read GetTemplate;
    property Ptr: Boolean read GetPtr;
  end;

  TwbNifBlock = class;
  TwbNifBlocks = array of TwbNifBlock;
  TwbNifFile = class;

  TwbNifBlockDef = class(TdfStructDef)
    function CreateElement(const aParent: TdfElement): TdfElement; override;
  end;

  TwbNifBlock = class(TdfStruct)
  private
    // NiRef and NiPtr elements in this block
    FRefs: TList;
    // indexed string elements in this block
    FStrings: TList;
  protected
    function GetName: string; override;
    function GetBlockType: string;
    function GetNifFile: TwbNifFile;
    function GetRef(Index: Integer): TwbNiRef;
    function GetRefsCount: Integer;
    function GetString(Index: Integer): TdfElement;
    function GetStringsCount: Integer;
  public
    constructor Create(const aDef: TdfDef; const aParent: TdfElement); override;
    destructor Destroy; override;
    function Index: Integer; override;
    procedure AddRef(const aElement: TdfElement);
    procedure RemoveRef(const aElement: TdfElement);
    procedure AddString(const aElement: TdfElement);
    procedure RemoveString(const aElement: TdfElement);
    function IsNiObject(const aTemplate: string; aInherited: Boolean = True): Boolean;
    function IsReferenced: Boolean;
    function AddChild(const aBlockType: string): TwbNifBlock;
    function AddExtraData(const aBlockType: string): TwbNifBlock;
    function AddProperty(const aBlockType: string): TwbNifBlock;
    function PropertyByName(const aName: string): TwbNifBlock;
    function ExtraDataByName(const aName: string): TwbNifBlock;
    function ChildrenByType(const aBlockType: string; aInherited: Boolean = False): TwbNifBlocks;
    function ChildByType(const aBlockType: string; aInherited: Boolean = False): TwbNifBlock;
    function PropertiesByType(const aBlockType: string; aInherited: Boolean = False): TwbNifBlocks;
    function PropertyByType(const aBlockType: string; aInherited: Boolean = False): TwbNifBlock;
    function ExtraDatasByType(const aBlockType: string; aInherited: Boolean = False): TwbNifBlocks;
    function ExtraDataByType(const aBlockType: string; aInherited: Boolean = False): TwbNifBlock;
    function BlockByPath(const aBlockPath: string): TwbNifBlock;
    function GetVertices(aElement: TdfElement = nil): TVector3Array;
    function GetNormals(aElement: TdfElement = nil): TVector3Array;
    function GetTexCoord(aElement: TdfElement = nil): TVector2Array;
    function GetTriangles(aElement: TdfElement = nil): TTriangleArray;
    function GetStrips(aElement: TdfElement = nil): TStripArray;
    function UpdateBounds: Boolean;
    function UpdateNormals(aAddIfMissing: Boolean = True): Boolean;
    function UpdateTangents(aAddIfMissing: Boolean = True): Boolean;
    function GetAssetsList: TStringDynArray;
    procedure RemoveBranch;
    property BlockType: string read GetBlockType;
    property NifFile: TwbNifFile read GetNifFile;
    property RefsCount: Integer read GetRefsCount;
    property StringsCount: Integer read GetStringsCount;
    property Refs[Index: Integer]: TwbNiRef read GetRef;
    property Strings[Index: Integer]: TdfElement read GetString;
  end;

  TwbNifFile = class(TdfContainer)
  private
    FNifVersion: TwbNifVersion;
    FOptions: TwbNifOptions;
    FInternalUpdates: Boolean;
    FStopAtIndex: Integer;
    function ReadBlock(const aBlockType: string; const aDataStart, aDataEnd: Pointer): Integer;
  protected
    function GetHeader: TwbNifBlock;
    function GetFooter: TwbNifBlock;
    function GetBlocksCount: Integer;
    function GetBlock(Index: Integer): TwbNifBlock;
    procedure SetNifVersion(aVersion: TwbNifVersion);
    procedure RemapBlocks(const aMap: array of Integer);
  public
    Version, UserVersion, UserVersion2: Cardinal;
    constructor Create; reintroduce; overload;
    function DataSize: Integer; override;
    function UnSerialize(const aDataStart, aDataEnd: Pointer; const aDataSize: Integer): Integer; override;
    function Serialize(const aDataStart, aDataEnd: Pointer): Integer; override;
    procedure SerializeToJSON(const aJSON: TJSONBaseObject); override;
    procedure UnSerializeFromJSON(const aJSON: TJSONBaseObject); override;
    procedure Delete(Index: Integer); override;
    procedure Move(CurIndex, NewIndex: Integer); override;
    procedure UpdateNifVersion;
    procedure UpdateHeader;
    function AddBlock(const aBlockType: string): TwbNifBlock;
    function InsertBlock(Index: Integer; const aBlockType: string): TwbNifBlock;
    procedure ConvertBlock(Index: Integer; const aBlockType: string);
    function CopyBlock(Index: Integer): TwbNifBlock;
    function BlocksByType(const aBlockType: string; aInherited: Boolean = False): TwbNifBlocks;
    function BlockByType(const aBlockType: string; aInherited: Boolean = False): TwbNifBlock;
    function BlockByName(const aBlockName: string): TwbNifBlock;
    function BlockByPath(const aBlockPath: string): TwbNifBlock;
    function SpellTriangulate: Boolean;
    function SpellFaceNormals: Boolean;
    function SpellUpdateTangents: Boolean;
    function SpellAddUpdateTangents: Boolean;
    function GetAssetsList: TStringDynArray;
    property NifVersion: TwbNifVersion read FNifVersion write SetNifVersion;
    property Options: TwbNifOptions read FOptions write FOptions;
    property Header: TwbNifBlock read GetHeader;
    property Footer: TwbNifBlock read GetFooter;
    property BlocksCount: Integer read GetBlocksCount;
    property Blocks[Index: Integer]: TwbNifBlock read GetBlock;
    property InternalUpdates: Boolean read FInternalUpdates write FInternalUpdates;
    property StopAtIndex: Integer read FStopAtIndex write FStopAtIndex;
  end;


{
function wbNiObjectExists(const aNiObject: string): Boolean;
procedure wbNiObjectCheckDups;
}

implementation

uses
  wbDataFormatNifTypes, Math, SyncObjs;

const
  sNifMagicGamebryo = 'Gamebryo File Format, Version ';
  sNifMagicNetImmerse = 'NetImmerse File Format, Version ';

type
  TNiObjectInfo = record
    Def: TdfDef;
    Name: string;
    Inherit: string;
    InheritIndex: Integer;
    NameHash: Cardinal;
    IsAbstract: Boolean;
  end;

  TNiObjectInfos = record
    NiObjects: array of TNiObjectInfo;
    procedure Add(const aInherit: string; aIsAbstract: Boolean; aDef: TdfDef; aInsertIndex: Integer);
    function IndexOf(const aName: string): Integer;
    procedure FreeDefs;
  end;

var
  NiObjectInfos: TNiObjectInfos;
  v4002    : Cardinal;
  v4101    : Cardinal;
  v41012   : Cardinal;
  v4202    : Cardinal;
  v4210    : Cardinal;
  v4220    : Cardinal;
  v5001    : Cardinal;
  v10010   : Cardinal;
  v10012   : Cardinal;
  v10013   : Cardinal;
  v10100   : Cardinal;
  v10018   : Cardinal;
  v1010101 : Cardinal;
  v1010106 : Cardinal;
  v10200   : Cardinal;
  v10401   : Cardinal;
  v20103   : Cardinal;
  v20004   : Cardinal;
  v20005   : Cardinal;
  v20007   : Cardinal;
  v20101   : Cardinal;
  v20102   : Cardinal;
  v20205   : Cardinal;
  v20207   : Cardinal;

  NifDefsInitialized: Boolean;
  {$IF CompilerVersion >= 34.0} { Delphi 10.4 }
  Sync: TLightweightMREW;
  {$ELSE}
  Sync: IReadWriteSync;
  {$IFEND}

procedure wbDefineNif; forward;


{ Helper functions }

function wbNifVersionToInt(const aVersion: string): Cardinal;
var
  i: integer;
  j: Cardinal;
begin
  Result := 0;
  with TStringList.Create do try
    Delimiter := '.';
    StrictDelimiter := True;
    DelimitedText := aVersion;
    for i := 0 to 3 do begin
      if i < Count then
        j := StrToIntDef(Strings[i], 0)
      else
        j := 0;
      Result := Result or (j shl (24 - i*8));
    end;
  finally
    Free;
  end;
end;

function wbIntToNifVersion(aVersion: Cardinal): string;
begin
  Result := Format('%d.%d.%d.%d', [
    aVersion shr 24 and $ff,
    aVersion shr 16 and $ff,
    aVersion shr 8 and $ff,
    aVersion and $ff
  ]);
end;

function nif(const e: TdfElement): TwbNifFile; inline;
begin
  Result := TwbNifFile(e.Root);
end;

function nifblk(const e: TdfElement): TwbNifBlock; inline;
var
  Element: TdfElement;
begin
  Element := e.Parent;
  // get to the containing nif block
  while Assigned(Element) and not (Element is TwbNifBlock) do
    Element := Element.Parent;
  Result := TwbNifBlock(Element);
end;

procedure wbGetVector2(var Vector: TVector2; const aElement: TdfElement; asText: Boolean = False); inline;
begin
  if asText then begin
    Vector.v[0] := dfStrToFloat(aElement.EditValues['[0]']);
    Vector.v[1] := dfStrToFloat(aElement.EditValues['[1]']);
  end
  else begin
    Vector.v[0] := aElement.NativeValues['[0]'];
    Vector.v[1] := aElement.NativeValues['[1]'];
  end;
end;

procedure wbSetVector2(const Vector: TVector2; const aElement: TdfElement; asText: Boolean = False); inline;
begin
  if asText then begin
    aElement.EditValues['[0]'] := dfFloatToStr(Vector.v[0]);
    aElement.EditValues['[1]'] := dfFloatToStr(Vector.v[1]);
  end
  else begin
    aElement.NativeValues['[0]'] := Vector.v[0];
    aElement.NativeValues['[1]'] := Vector.v[1];
  end;
end;

procedure wbGetVector3(var Vector: TVector3; const aElement: TdfElement; asText: Boolean = False); inline;
begin
  if asText then begin
    Vector.v[0] := dfStrToFloat(aElement.EditValues['[0]']);
    Vector.v[1] := dfStrToFloat(aElement.EditValues['[1]']);
    Vector.v[2] := dfStrToFloat(aElement.EditValues['[2]']);
  end
  else begin
    Vector.v[0] := aElement.NativeValues['[0]'];
    Vector.v[1] := aElement.NativeValues['[1]'];
    Vector.v[2] := aElement.NativeValues['[2]'];
  end;
end;

procedure wbSetVector3(const Vector: TVector3; const aElement: TdfElement; asText: Boolean = False); inline;
begin
  if asText then begin
    aElement.EditValues['[0]'] := dfFloatToStr(Vector.v[0]);
    aElement.EditValues['[1]'] := dfFloatToStr(Vector.v[1]);
    aElement.EditValues['[2]'] := dfFloatToStr(Vector.v[2]);
  end
  else begin
    aElement.NativeValues['[0]'] := Vector.v[0];
    aElement.NativeValues['[1]'] := Vector.v[1];
    aElement.NativeValues['[2]'] := Vector.v[2];
  end;
end;

procedure wbGetTriangle(var Tri: TTriangle; const aElement: TdfElement); inline;
begin
  Tri[0] := aElement.NativeValues['[0]'];
  Tri[1] := aElement.NativeValues['[1]'];
  Tri[2] := aElement.NativeValues['[2]'];
end;

procedure wbSetTriangle(const Tri: TTriangle; const aElement: TdfElement); inline;
begin
  aElement.NativeValues['[0]'] := Tri[0];
  aElement.NativeValues['[1]'] := Tri[1];
  aElement.NativeValues['[2]'] := Tri[2];
end;


{ NiObjectInfos }

procedure TNiObjectInfos.Add(const aInherit: string; aIsAbstract: Boolean; aDef: TdfDef; aInsertIndex: Integer);
var
  i: integer;
begin
  if IndexOf(aDef.Name) <> -1 then
    raise Exception.Create('Definition of ' + aDef.Name + ' already exists');

  if aInherit <> '' then begin
    i := IndexOf(aInherit);
    if i = -1 then
      raise Exception.Create('Unknown NiObject to inherit from: ' + aInherit);
    aDef.InsertDefsFrom(NiObjects[i].Def, aInsertIndex);
  end else
    i := -1;

  SetLength(NiObjects, Succ(Length(NiObjects)));
  with NiObjects[Pred(Length(NiObjects))] do begin
    Def := aDef;
    Name := aDef.Name;
    NameHash := dfCalcHash(Name);
    Inherit := aInherit;
    InheritIndex := i;
    IsAbstract := aIsAbstract;
  end;
end;

function TNiObjectInfos.IndexOf(const aName: string): Integer;
var
  i: integer;
  h: Cardinal;
begin
  Result := -1;
  h := dfCalcHash(aName);
  for i := Low(NiObjects) to High(NiObjects) do
    if NiObjects[i].NameHash = h then begin
      Result := i;
      Break;
    end;
end;

procedure TNiObjectInfos.FreeDefs;
var
  i: integer;
begin
  for i := Low(NiObjects) to High(NiObjects) do
    NiObjects[i].Def.Free;
end;

procedure FreeNiObjectDefs;
begin
  NiObjectInfos.FreeDefs;
end;

procedure wbNiObject(aDef: TdfDef; const aInherit: string; aIsAbstract: Boolean; aInsertIndex: Integer = 0); overload;
begin
  NiObjectInfos.Add(aInherit, aIsAbstract, aDef, aInsertIndex);
end;

procedure wbNiObject(aDef: TdfDef); overload;
begin
  NiObjectInfos.Add('', False, aDef, 0);
end;

{
function wbNiObjectExists(const aNiObject: string): Boolean;
begin
  Result := NiObjectInfos.IndexOf(aNiObject) <> -1;
end;

procedure wbNiObjectCheckDups;

  procedure Check(d: TdfDef; const aParent: string);
  var
    i: integer;
    sl: TStringList;
  begin
    if d.DataType <> dtStruct then Exit;
    sl := TStringList.Create;
    for i := Low(d.Defs) to High(d.Defs) do begin
      if not (Assigned(d.Defs[i].OnGetEnabled)) and (d.Defs[i].Name <> '') then
        if sl.IndexOf(d.Defs[i].Name) <> -1 then
          WriteLn(aParent + ' \ ' + d.Defs[i].Name)
        else
          sl.Add(d.Defs[i].Name);
      Check(d.Defs[i], aParent + ' \ ' + d.Name);
    end;
    sl.Free;
  end;

var
  i: integer;
begin
  for i := Low(NiObjectInfos.NiObjects) to High(NiObjectInfos.NiObjects) do
    Check(NiObjectInfos.NiObjects[i].Def, NiObjectInfos.NiObjects[i].Def.Name);
end;
}

function wbNiObjectDef(const aNiObject: string): TdfDef;
var
  i: integer;
begin
  // initialize NIF definitions if missing
  if not NifDefsInitialized then begin
    Sync.BeginWrite;
    try
      if not NifDefsInitialized then begin
        wbDefineNif;
        NifDefsInitialized := True;
      end;
    finally
      Sync.EndWrite;
    end;
  end;

  i := NiObjectInfos.IndexOf(aNiObject);

  if i = -1 then
    raise Exception.Create('Unknown NiObject: ' + aNiObject);

  if NiObjectInfos.NiObjects[i].IsAbstract then
    raise Exception.Create('Can not initialize from abstract NiObject: ' + aNiObject);

  Result := NiObjectInfos.NiObjects[i].Def;
end;

function wbIsNiObject(const aNiObject, aTemplate: string): Boolean; overload;
var
  i: Integer;
  h: Cardinal;
begin
  h := dfCalcHash(aTemplate);
  i := NiObjectInfos.IndexOf(aNiObject);
  Result := False;
  repeat
    if NiObjectInfos.NiObjects[i].NameHash = h then begin
      Result := True;
      Exit;
    end;
    i := NiObjectInfos.NiObjects[i].InheritIndex;
  until i = -1;
end;

function wbIsNiObject(aElement: TdfElement; const aTemplate: string): Boolean; overload;
begin
  // get to the containing nif block
  while Assigned(aElement) and not (aElement is TwbNifBlock) do
    aElement := aElement.Parent;

  if Assigned(aElement) then
    Result := wbIsNiObject(aElement.Def.Name, aTemplate)
  else
    Result := False;
end;


{ TwbNifBlock }

function wbNifBlock(
  const aName: string;
  const aDefs: array of TdfDef;
  const aEvents: array of const
): TwbNifBlockDef; overload;
begin
  Result := TwbNifBlockDef.Create(aName, dtStruct, aDefs);
  Result.AssignEvents(aEvents);
end;

function wbNifBlock(const aName: string; const aDefs: array of TdfDef): TwbNifBlockDef; overload;
begin
  Result := wbNifBlock(aName, aDefs, []);
end;

function wbNifBlock(const aName: string): TwbNifBlockDef; overload;
begin
  Result := wbNifBlock(aName, [], []);
end;

function TwbNifBlockDef.CreateElement(const aParent: TdfElement): TdfElement;
begin
  Result := TwbNifBlock.Create(Self, aParent);
end;

constructor TwbNifBlock.Create(const aDef: TdfDef; const aParent: TdfElement);
begin
  inherited;
  FRefs := TList.Create;
  FStrings := TList.Create;
end;

destructor TwbNifBlock.Destroy;
begin
  inherited;
  FRefs.Free;
  FStrings.Free;
end;

function TwbNifBlock.GetName: string;
begin
  Result := BlockType;
  if (Result <> 'NiHeader') and (Result <> 'NiFooter') then
    Result := IntToStr(Index) + ' ' + Result;
end;

function TwbNifBlock.GetBlockType: string;
begin
  Result := Def.Name;
end;

function TwbNifBlock.GetNifFile: TwbNifFile;
begin
  Result := nif(Self);
end;

function TwbNifBlock.Index: Integer;
begin
  Result := inherited;

  // -1 to exclude NiHeader
  if BlockType <> 'NiHeader' then
    Dec(Result);
end;

function TwbNifBlock.GetRef(Index: Integer): TwbNiRef;
begin
  Result := TwbNiRef(FRefs[Index]);
end;

function TwbNifBlock.GetRefsCount: Integer;
begin
  Result := FRefs.Count;
end;

function TwbNifBlock.GetString(Index: Integer): TdfElement;
begin
  Result := TdfElement(FStrings[Index]);
end;

function TwbNifBlock.GetStringsCount: Integer;
begin
  Result := FStrings.Count;
end;

procedure TwbNifBlock.AddRef(const aElement: TdfElement);
begin
  FRefs.Add(aElement);
end;

procedure TwbNifBlock.RemoveRef(const aElement: TdfElement);
begin
  if not (dsDestroying in DataState) then
    FRefs.Remove(aElement);
end;

procedure TwbNifBlock.AddString(const aElement: TdfElement);
begin
  FStrings.Add(aElement);
end;

procedure TwbNifBlock.RemoveString(const aElement: TdfElement);
begin
  if not (dsDestroying in DataState) then
    FStrings.Remove(aElement);
end;

function TwbNifBlock.IsNiObject(const aTemplate: string; aInherited: Boolean = True): Boolean;
begin
  Result := (not aInherited and (BlockType = aTemplate)) or (aInherited and wbIsNiObject(BlockType, aTemplate));
end;

function TwbNifBlock.IsReferenced: Boolean;
var
  i, j: Integer;
  b: TwbNifBlock;
begin
  Result := False;
  for i := 0 to Pred(Self.NifFile.BlocksCount) do begin
    b := Self.NifFile.Blocks[i];
    // skip checking for self referencing
    if b = Self then
      Continue;

    for j := 0 to Pred(b.RefsCount) do
      if TwbNifBlock(b.Refs[j].LinksTo) = Self then begin
        Result := True;
        Exit;
      end;
  end;
end;

function TwbNifBlock.AddChild(const aBlockType: string): TwbNifBlock;
var
  Children, Child: TdfElement;
  i: integer;
begin
  Children := Elements['Children'];
  if not Assigned(Children) then
    DoException('Can not have children');

  // find existing None entry if any
  Child := nil;
  for i := 0 to Pred(Children.Count) do
    if Children[i].NativeValue = -1 then begin
      Child := Children[i];
      Break;
    end;

  // or add a new one
  if not Assigned(Child) then
    Child := Children.Add;

  Result := NifFile.AddBlock(aBlockType);
  Child.NativeValue := Result.Index;
end;

function TwbNifBlock.AddExtraData(const aBlockType: string): TwbNifBlock;
var
  Datas, Data: TdfElement;
  i: integer;
begin
  Datas := Elements['Extra Data List'];
  if not Assigned(Datas) then
    Datas := Elements['Extra Data'];

  if not Assigned(Datas) then
    DoException('Can not have extra data');

  // if a single value (Morrowind meshes)
  if Datas is TdfValue then
    Data := Datas

  else begin
    // find existing None entry if any
    Data := nil;
    for i := 0 to Pred(Datas.Count) do
      if Datas[i].NativeValue = -1 then begin
        Data := Datas[i];
        Break;
      end;

    // or add a new one
    if not Assigned(Data) then
      Data := Datas.Add;
  end;

  if Data.NativeValue <> -1 then
    DoException('Can not add more extra data');

  Result := NifFile.AddBlock(aBlockType);
  Data.NativeValue := Result.Index;
end;

function TwbNifBlock.AddProperty(const aBlockType: string): TwbNifBlock;
var
  Props, Prop: TdfElement;
  i: integer;
begin
  Prop := Elements['Shader Property'];
  if Assigned(Prop) and wbIsNiObject(aBlockType, 'BSShaderProperty') then begin
    if Prop.LinksTo <> nil then
      raise Exception.Create('Block already has a shader property, can not add a new one');
    Result := NifFile.AddBlock(aBlockType);
    Prop.NativeValue := Result.Index;
    Exit;
  end;

  Prop := Elements['Alpha Property'];
  if Assigned(Prop) and wbIsNiObject(aBlockType, 'NiAlphaProperty') then begin
    if Prop.LinksTo <> nil then
      raise Exception.Create('Block already has an alpha property, can not add a new one');
    Result := NifFile.AddBlock(aBlockType);
    Prop.NativeValue := Result.Index;
    Exit;
  end;

  Props := Elements['Properties'];
  if not Assigned(Props) then
    DoException('Block can not have properties');

  // find existing None entry if any
  Prop := nil;
  for i := 0 to Pred(Props.Count) do
    if Props[i].NativeValue = -1 then begin
      Prop := Props[i];
      Break;
    end;

  // or add a new one
  if not Assigned(Prop) then
    Prop := Props.Add;

  Result := NifFile.AddBlock(aBlockType);
  Prop.NativeValue := Result.Index;
end;

function TwbNifBlock.PropertyByName(const aName: string): TwbNifBlock;
var
  Props: TdfElement;
  i: integer;
begin
  Props := Elements['Shader Property'];
  if Assigned(Props) and (Props.LinksTo <> nil) and (Props.LinksTo.EditValues['Name'] = aName) then begin
    Result := TwbNifBlock(Props.LinksTo);
    Exit;
  end;

  Props := Elements['Alpha Property'];
  if Assigned(Props) and (Props.LinksTo <> nil) and (Props.LinksTo.EditValues['Name'] = aName) then begin
    Result := TwbNifBlock(Props.LinksTo);
    Exit;
  end;

  Props := Elements['Properties'];
  if Assigned(Props) then
    for i := 0 to Pred(Props.Count) do begin
      Result := TwbNifBlock(Props[i].LinksTo);
      if Assigned(Result) and (Result.EditValues['Name'] = aName) then
        Exit;
    end;

  Result := nil;
end;

function TwbNifBlock.ExtraDataByName(const aName: string): TwbNifBlock;
var
  Datas: TdfElement;
  i: integer;
begin
  Datas := Elements['Extra Data List'];
  if Assigned(Datas) then begin
    for i := 0 to Pred(Datas.Count) do begin
      Result := TwbNifBlock(Datas[i].LinksTo);
      if Assigned(Result) and (Result.EditValues['Name'] = aName) then
        Exit;
    end;
  end
  else begin
    Datas := Elements['Extra Data'];
    if Assigned(Datas) then begin
      Result := TwbNifBlock(Datas.LinksTo);
      if Assigned(Result) and (Result.EditValues['Name'] = aName) then
        Exit;
    end;
  end;
  Result := nil;
end;

function TwbNifBlock.ChildrenByType(const aBlockType: string; aInherited: Boolean = False): TwbNifBlocks;
var
  Children: TdfElement;
  Child: TwbNifBlock;
  i: integer;
begin
  Result := nil;
  Children := Elements['Children'];

  if not Assigned(Children) then
    Exit;

  for i := 0 to Pred(Children.Count) do begin
    Child := TwbNifBlock(Children[i].LinksTo);
    if Assigned(Child) and Child.IsNiObject(aBlockType, aInherited) then begin
      SetLength(Result, Succ(Length(Result)));
      Result[Pred(Length(Result))] := Child;
    end;
  end;
end;

function TwbNifBlock.ChildByType(const aBlockType: string; aInherited: Boolean = False): TwbNifBlock;
var
  Children: TwbNifBlocks;
begin
  Children := ChildrenByType(aBlockType, aInherited);
  if Length(Children) <> 0 then
    Result := Children[0]
  else
    Result := nil;
end;

function TwbNifBlock.PropertiesByType(const aBlockType: string; aInherited: Boolean = False): TwbNifBlocks;
var
  Props: TdfElement;
  Prop: TwbNifBlock;
  i: integer;
begin
  Result := nil;
  Props := Elements['Shader Property'];
  if Assigned(Props) then begin
    Prop := TwbNifBlock(Props.LinksTo);
    if Assigned(Prop) and Prop.IsNiObject(aBlockType, aInherited) then begin
      SetLength(Result, Succ(Length(Result)));
      Result[Pred(Length(Result))] := Prop;
    end;
  end;

  Props := Elements['Alpha Property'];
  if Assigned(Props) then begin
    Prop := TwbNifBlock(Props.LinksTo);
    if Assigned(Prop) and Prop.IsNiObject(aBlockType, aInherited) then begin
      SetLength(Result, Succ(Length(Result)));
      Result[Pred(Length(Result))] := Prop;
    end;
  end;

  Props := Elements['Properties'];
  if Assigned(Props) then
    for i := 0 to Pred(Props.Count) do begin
      Prop := TwbNifBlock(Props[i].LinksTo);
      if Assigned(Prop) and Prop.IsNiObject(aBlockType, aInherited) then begin
        SetLength(Result, Succ(Length(Result)));
        Result[Pred(Length(Result))] := Prop;
      end;
    end;
end;

function TwbNifBlock.PropertyByType(const aBlockType: string; aInherited: Boolean = False): TwbNifBlock;
var
  Props: TwbNifBlocks;
begin
  Props := PropertiesByType(aBlockType, aInherited);
  if Length(Props) <> 0 then
    Result := Props[0]
  else
    Result := nil;
end;

function TwbNifBlock.ExtraDatasByType(const aBlockType: string; aInherited: Boolean = False): TwbNifBlocks;
var
  Datas: TdfElement;
  Data: TwbNifBlock;
  i: integer;
begin
  Result := nil;
  Datas := Elements['Extra Data List'];
  if Assigned(Datas) then begin
    for i := 0 to Pred(Datas.Count) do begin
      Data := TwbNifBlock(Datas[i].LinksTo);
      if Assigned(Data) and Data.IsNiObject(aBlockType, aInherited) then begin
        SetLength(Result, Succ(Length(Result)));
        Result[Pred(Length(Result))] := Data;
      end;
    end;
  end
  else begin
    Datas := Elements['Extra Data'];
    if Assigned(Datas) then begin
      Data := TwbNifBlock(Datas.LinksTo);
      if Assigned(Data) and Data.IsNiObject(aBlockType, aInherited) then begin
        SetLength(Result, Succ(Length(Result)));
        Result[Pred(Length(Result))] := Data;
      end;
    end;
  end;
end;

function TwbNifBlock.ExtraDataByType(const aBlockType: string; aInherited: Boolean = False): TwbNifBlock;
var
  Datas: TwbNifBlocks;
begin
  Datas := ExtraDatasByType(aBlockType, aInherited);
  if Length(Datas) <> 0 then
    Result := Datas[0]
  else
    Result := nil;
end;

function TwbNifBlock.BlockByPath(const aBlockPath: string): TwbNifBlock;
var
  i, p: Integer;
  curpath, path: string;
begin
  Result := nil;

  path := aBlockPath;
  while (path <> '') and (path[1] = '\') do
    System.Delete(path, 1, 1);

  if path = '' then
    Exit;

  p := Pos('\', path);
  if p <> 0 then begin
    curpath := Copy(path, 1, p - 1);
    path := Copy(path, p + 1, Length(path));
  end
  else begin
    curpath := path;
    path := '';
  end;

  for i := 0 to Pred(RefsCount) do begin
    var b: TwbNifBlock := TwbNifBlock(Refs[i].LinksTo);
    if not Assigned(b) then
      Continue;

    if SameText(b.BlockType, curpath) or (b.EditValues['Name'] = curpath) then begin
      if path <> '' then
        Result := b.BlockByPath(path)
      else
        Result := b;

      Exit;
    end;
  end;
end;

function TwbNifBlock.GetVertices(aElement: TdfElement = nil): TVector3Array;
var
  i: integer;
  Entries: TdfElement;
begin
  Result := nil;

  if not Assigned(aElement) then
    aElement := Self;

  if IsNiObject('BSTriShape') or IsNiObject('NiSkinPartition') then begin
    if not aElement.NativeValues['VertexDesc\VF\VF_VERTEX'] then
      Exit;

    Entries := aElement.Elements['Vertex Data'];
    if not Assigned(Entries) then
      Exit;

    SetLength(Result, Entries.Count);
    for i := 0 to Pred(Entries.Count) do
      wbGetVector3(Result[i], Entries[i][0], True); // Elements['Vertex'];
  end

  else if IsNiObject('NiTriBasedGeomData') then begin
    Entries := aElement.Elements['Vertices'];
    if not Assigned(Entries) then
      Exit;

    SetLength(Result, Entries.Count);
    for i := 0 to Pred(Entries.Count) do
      wbGetVector3(Result[i], Entries[i]);
  end;
end;

function TwbNifBlock.GetNormals(aElement: TdfElement = nil): TVector3Array;
var
  i: integer;
  Entries: TdfElement;
begin
  Result := nil;

  if not Assigned(aElement) then
    aElement := Self;

  if IsNiObject('BSTriShape') then begin
    if not aElement.NativeValues['VertexDesc\VF\VF_NORMAL'] then
      Exit;

    Entries := aElement.Elements['Vertex Data'];
    if not Assigned(Entries) then
      Exit;

    SetLength(Result, Entries.Count);
    for i := 0 to Pred(Entries.Count) do
      wbGetVector3(Result[i], Entries[i][4], True); // Elements['Normal'];
  end

  else if IsNiObject('NiTriBasedGeomData') then begin
    Entries := aElement.Elements['Normals'];
    if not Assigned(Entries) then
      Exit;

    SetLength(Result, Entries.Count);
    for i := 0 to Pred(Entries.Count) do
      wbGetVector3(Result[i], Entries[i]);
  end;
end;

function TwbNifBlock.GetTexCoord(aElement: TdfElement = nil): TVector2Array;
var
  i: integer;
  Entries: TdfElement;
begin
  Result := nil;

  if not Assigned(aElement) then
    aElement := Self;

  if IsNiObject('BSTriShape') then begin
    if not aElement.NativeValues['VertexDesc\VF\VF_UV'] then
      Exit;

    Entries := aElement.Elements['Vertex Data'];
    if not Assigned(Entries) then
      Exit;

    SetLength(Result, Entries.Count);
    for i := 0 to Pred(Entries.Count) do
      wbGetVector2(Result[i], Entries[i][3], True); // Elements['UV'];
  end

  else if IsNiObject('NiTriBasedGeomData') then begin
    Entries := aElement.Elements['UV Sets'];
    if Assigned(Entries) and (Entries.Count <> 0) then begin
      Entries := Entries[0];
      SetLength(Result, Entries.Count);
      for i := 0 to Pred(Entries.Count) do
        wbGetVector2(Result[i], Entries[i]);
    end;
  end;
end;

function TwbNifBlock.GetTriangles(aElement: TdfElement = nil): TTriangleArray;
var
  i: integer;
  Entries: TdfElement;
begin
  Result := nil;

  if not Assigned(aElement) then
    aElement := Self;

  Entries := aElement.Elements['Triangles'];
  if Assigned(Entries) then begin
    SetLength(Result, Entries.Count);
    for i := 0 to Pred(Entries.Count) do
      wbGetTriangle(Result[i], Entries[i]);
  end
  else
    Result := TriangulateStrips(GetStrips);
end;

function TwbNifBlock.GetStrips(aElement: TdfElement = nil): TStripArray;
var
  i, j: integer;
  Entries, e: TdfElement;
begin
  Result := nil;

  if not Assigned(aElement) then
    aElement := Self;

  Entries := aElement.Elements['Strips'];
  if Assigned(Entries) then begin
    for i := 0 to Pred(Entries.Count) do begin
      SetLength(Result, Succ(Length(Result)));
      e := Entries[i];
      SetLength(Result[i], e.Count);
      for j := 0 to Pred(e.Count) do
        Result[i][j] := e[j].NativeValue;
    end;
  end;
end;

function TwbNifBlock.UpdateBounds: Boolean;
var
  skin, skinpart: TwbNifBlock;
  verts: TVector3Array;
  center: TVector3;
  r: Extended;
  e: TdfElement;
begin
  Result := False;

  verts := GetVertices;

  if Length(verts) = 0 then
    // skinned BSTriShapes have vertices in NiSkinPartition
    if IsNiObject('BSTriShape') then begin
      skin := TwbNifBlock(Elements['Skin'].LinksTo);
      e := skin.Elements['Skin Partition'];
      if Assigned(e) then begin
        skinpart := TwbNifBlock(e.LinksTo);
        if Assigned(skinpart) then
          verts := skinpart.GetVertices;
      end;
    end;

  if Length(verts) = 0 then
    Exit;

  CalculateCenterRadius(verts, center, r,
    // Oblivion and volatile meshes require a different center algorithm
    (NifFile.NifVersion = nfTES4) or (EditValues['Consistency Flags'] = 'CT_VOLATILE')
  );

  e := Elements['Bounding Sphere'];
  if Assigned(e) then begin
    wbSetVector3(center, e.Elements['Center']);
    e.NativeValues['Radius'] := r;
    Result := True;
  end;

  e := Elements['Center'];
  if Assigned(e) then begin
    wbSetVector3(center, e);
    NativeValues['Radius'] := r;
    Result := True;
  end;
end;

function TwbNifBlock.UpdateNormals(aAddIfMissing: Boolean = True): Boolean;
var
  verts, norms: TVector3Array;
  triangles: TTriangleArray;
  IsBSTriShape, IsGeomData: Boolean;
  Entries: TdfElement;
  i: integer;
begin
  Result := False;
  IsBSTriShape := IsNiObject('BSTriShape');
  IsGeomData := IsNiObject('NiTriBasedGeomData');

  if not (IsBSTriShape or IsGeomData) then
    Exit;

  if not aAddIfMissing then
    if (IsBSTriShape and not NativeValues['VertexDesc\VF\VF_NORMAL']) or
       (IsGeomData and (NativeValues['Has Normals'] = 0))
    then
      Exit;

  verts := GetVertices;
  if Length(verts) = 0 then
    Exit;

  triangles := GetTriangles;
  if Length(triangles) = 0 then
    Exit;

  CalculateFaceNormals(verts, triangles, norms);

  if Length(norms) = 0 then
    Exit;

  if IsBSTriShape then begin
    NativeValues['VertexDesc\VF\VF_NORMAL'] := 1;
    Entries := Elements['Vertex Data'];
    for i := 0 to Pred(Entries.Count) do
      wbSetVector3(norms[i], Entries[i][4], True); // Elements['Normal'];
  end
  else if IsGeomData then begin
    NativeValues['Has Normals'] := 1;
    Entries := Elements['Normals'];
    Entries.Count := Length(norms);
    for i := Low(norms) to High(norms) do
      wbSetVector3(norms[i], Entries[i]);
  end;

  Result := True;
end;

function TwbNifBlock.UpdateTangents(aAddIfMissing: Boolean = True): Boolean;
const
  sTES4ExtraDataName = 'Tangent space (binormal & tangent vectors)';
var
  verts, norms: TVector3Array;
  texco: TVector2Array;
  triangles: TTriangleArray;
  tan, bin: TVector3Array;
  Entries, e: TdfElement;
  i: integer;
  IsBSTriShape, IsGeomData: Boolean;
  b, exdata: TwbNifBlock;
  Bytes: TBytes;
begin
  Result := False;

  if NifFile.NifVersion <= nfTES3 then
    Exit;

  IsBSTriShape := IsNiObject('BSTriShape');
  IsGeomData := IsNiObject('NiTriBasedGeomData');

  if not (IsBSTriShape or IsGeomData) then
    Exit;

  if not aAddIfMissing then
    if (IsBSTriShape and not NativeValues['VertexDesc\VF\VF_TANGENT']) or
       (IsGeomData and not (NativeValues['Vector Flags\Has_Tangents'] or (NifFile.NifVersion = nfTES4)))
       // Oblivion meshes don't use tangents flag
    then
      Exit;

  verts := GetVertices;
  if Length(verts) = 0 then
    Exit;

  norms := GetNormals;
  if Length(norms) = 0 then
    Exit;

  texco := GetTexCoord;
  if Length(texco) = 0 then
    Exit;

  triangles := GetTriangles;
  if Length(triangles) = 0 then
    Exit;

  //CalculateTangentsBitangents(verts, norms, texco, triangles, tan, bin); // nifskope
  CalculateTangentsBitangents2(verts, norms, texco, triangles, tan, bin); // nifskope + unity

  if Length(tan) = 0 then
    Exit;

  if IsBSTriShape then begin
    NativeValues['VertexDesc\VF\VF_TANGENT'] := 1;
    Entries := Elements['Vertex Data'];
    for i := Low(tan) to High(tan) do begin
      e := Entries[i];
      e[1].EditValue := dfFloatToStr(bin[i].x); // Bitangent X
      e[5].EditValue := dfFloatToStr(bin[i].y); // Bitangent Y
      e[7].EditValue := dfFloatToStr(bin[i].z); // Bitangent Z
      wbSetVector3(tan[i], e[6], True); // Elements['Tangent'];
    end;
  end

  else if IsGeomData then begin

    if NifFile.NifVersion <> nfTES4 then begin
      NativeValues['Vector Flags\Has_Tangents'] := 1;

      Entries := Elements['Tangents'];
      Entries.Count := Length(tan);
      for i := 0 to Pred(Entries.Count) do
        wbSetVector3(tan[i], Entries[i]);

      Entries := Elements['Bitangents'];
      Entries.Count := Length(bin);
      for i := 0 to Pred(Entries.Count) do
        wbSetVector3(bin[i], Entries[i]);
    end

    // in Oblivion tangents are stored in NiBinaryExtraData of the parent Shape/Strips block
    else begin
      // find which blocks link us as Data
      for b in NifFile.BlocksByType('NiTriBasedGeom', True) do begin
        if b.NativeValues['Data'] <> Index then
          Continue;

        exdata := b.ExtraDataByName(sTES4ExtraDataName);

        if not Assigned(exdata) and aAddIfMissing then begin
          exdata := b.AddExtraData('NiBinaryExtraData');
          exdata.EditValues['Name'] := sTES4ExtraDataName;
        end;

        if not Assigned(exdata) then
          Continue;

        SetLength(Bytes, SizeOf(TSingleVector3) * (Length(tan) + Length(bin)));
        // can't Move because need to convert from Extended to Single
        for i := Low(tan) to High(tan) do
          with PSingleVector3(@Bytes[SizeOf(TSingleVector3) * i])^ do begin x := tan[i].x; y := tan[i].y; z := tan[i].z; end;
        for i := Low(bin) to High(bin) do
          with PSingleVector3(@Bytes[SizeOf(TSingleVector3) * (Length(tan) + i)])^ do begin x := bin[i].x; y := bin[i].y; z := bin[i].z; end;

        exdata.NativeValues['Data'] := Bytes;
      end;
    end;
  end;
  Result := True;
end;

function TwbNifBlock.GetAssetsList: TStringDynArray;

  procedure AddAsset(const aFileName: string);
  var
    i: integer;
  begin
    if aFileName = '' then
      Exit;

    for i := Low(Result) to High(Result) do
      if SameText(Result[i], aFileName) then
        Exit;

    SetLength(Result, Succ(Length(Result)));
    Result[Pred(Length(Result))] := aFileName;
  end;

var
  i: integer;
  e: TdfElement;
begin
  Result := nil;

  // check for material file in the Name field of FO4 meshes
  if (NifFile.NifVersion = nfFO4) and (BlockType = 'BSLightingShaderProperty') then
    AddAsset(EditValues['Name'])

  else if BlockType = 'BSEffectShaderProperty' then begin
    if NifFile.NifVersion = nfFO4 then
      AddAsset(EditValues['Name'])
    else begin
      AddAsset(EditValues['Source Texture']);
      AddAsset(EditValues['Grayscale Texture']);
      AddAsset(EditValues['Env Map Texture']);
      AddAsset(EditValues['Normal Texture']);
      AddAsset(EditValues['Env Mask Texture']);
    end;
  end

  else if BlockType = 'BSShaderTextureSet' then begin
    e := Elements['Textures'];
    for i := 0 to Pred(e.Count) do
      AddAsset(e[i].EditValue);
  end

  else if (BlockType = 'BSShaderNoLightingProperty') or
          (BlockType = 'TallGrassShaderProperty') or
          (BlockType = 'TileShaderProperty') or
          IsNiObject('NiTexture', True)
  then
    AddAsset(EditValues['File Name'])

  else if BlockType = 'BSSkyShaderProperty' then
    AddAsset(EditValues['Source Name'])

  else if BlockType = 'BSBehaviorGraphExtraData' then
    AddAsset(EditValues['Behavior Graph File'])

  else if BlockType = 'BSSubIndexTriShape' then
    AddAsset(EditValues['Segment Data\SSF File']);
end;

procedure TwbNifBlock.RemoveBranch;

  function Exists(var blocks: TwbNifBlocks; block: TwbNifBlock): Boolean;
  begin
    Result := False;
    for var b: TwbNifBlock in blocks do
      if b = block then begin
        Result := True;
        Break;
      end;
  end;

var
  LinkedBlocks: TwbNifBlocks;
  b: TwbNifBlock;
begin
  if IsReferenced then
    Exit;

  // list of used blocks
  SetLength(LinkedBlocks, 0);
  for var i: Integer := 0 to Pred(Self.RefsCount) do begin
    b := TwbNifBlock(Self.Refs[i].LinksTo);
    if Assigned(b) and not Exists(LinkedBlocks, b) then
      LinkedBlocks := LinkedBlocks + [b];
  end;

  NifFile.Delete(Index);

  // remove linked blocks
  for b in LinkedBlocks do
    b.RemoveBranch;
end;



{ TwbNifFile }

constructor TwbNifFile.Create;
begin
  inherited Create(wbNiObjectDef('NIF'), nil);
  FInternalUpdates := True;
  FStopAtIndex := -1;
  FOptions := [nfoRemoveUnusedStrings];
end;

function TwbNifFile.DataSize: Integer;
var
  BlockSize: TdfElement;
  i, Size: Integer;
begin
  Result := 0;

  if InternalUpdates then begin
    UpdateHeader;
    BlockSize := Header.Elements['Block Size'];
  end else
    BlockSize := nil;

  if Assigned(BlockSize) then
    BlockSize.Count := BlocksCount;

  for i := 0 to Pred(Count) do begin
    Size := Items[i].DataSize;
    Inc(Result, Size);
    // account for block type sized string before each block for TES3 meshes
    // and block type index before each block in TES4 meshes version 10.1.0.106
    // excluding header and foooter
    if (i <> 0) and (i <> Pred(Count)) then begin
      // update block sizes list
      if Assigned(BlockSize) then
        BlockSize[Pred(i)].NativeValue := Size;

      if NifVersion = nfTES3 then
        Inc(Result, 4 + Length(Blocks[Pred(i)].BlockType)) // size prefix length + string length
      else if Version = v1010106 then
        Inc(Result, 4);
    end;
  end;
end;

function TwbNifFile.UnSerialize(const aDataStart, aDataEnd: Pointer; const aDataSize: Integer): Integer;
var
  elMagic, elBlockType, elBlockTypes: TdfElement;
  PData: PByte;
  NumBlocks, CurBlock: Integer;
  BlockType: string;
begin
  if Assigned(aDataStart) then begin
    elMagic := dfChars('Magic', Length(sNifMagicGamebryo), '', #0, False, []).CreateElement(nil);
    try
      elMagic.UnSerialize(aDataStart, aDataEnd, 0);
      if elMagic.EditValue <> sNifMagicGamebryo then begin
        elMagic.Def.Size := Length(sNifMagicNetImmerse);
        elMagic.UnSerialize(aDataStart, aDataEnd, 0);
        if elMagic.EditValue <> sNifMagicNetImmerse then
          raise Exception.Create('Not a valid NIF file');
      end;
    finally
      elMagic.Def.Free;
      elMagic.Free;
    end;
  end;

  Clear;
  Result := 0;
  PData := aDataStart;
  NumBlocks := 2; // NiHeader and NiFooter by default
  CurBlock := 0;

  // suppress compiler warning
  elBlockTypes := nil;
  // used to read block type stored before each block in TES3 nifs
  elBlockType := wbSizedString('Block Type').CreateElement(nil);
  try

    try

    while CurBlock < NumBlocks do begin

      // first block is NiHeader
      if CurBlock = 0 then
        BlockType := 'NiHeader'

      // last block is NiFooter
      else if CurBlock = Pred(NumBlocks) then
        BlockType := 'NiFooter'

      // get block type from block type index if exists
      else if Assigned(elBlockTypes) then
        BlockType := elBlockTypes[Pred(CurBlock)].EditValue

      // older meshes have block type in SizedString before each block
      else begin
        Result := Result + elBlockType.UnSerialize(PData + Result, aDataEnd, 0);
        BlockType := elBlockType.EditValue;
      end;

      // 10.1.0.106 meshes have en empty block type index before each block except NiFooter. Bypass it
      // TES4: meshes\creatures\horse\bridle.nif
      if (Version = v1010106) and (CurBlock <> Pred(NumBlocks)) then
        Inc(Result, 4);

      Result := Result + ReadBlock(BlockType, PData + Result, aDataEnd);

      // num blocks after reading the header
      if BlockType = 'NiHeader' then begin
        NumBlocks := NumBlocks + Header.NativeValues['Num Blocks'];
        Capacity := NumBlocks;
        elBlockTypes := Header.Elements['Block Type Index'];
      end;

      if CurBlock = FStopAtIndex then Exit;

      Inc(CurBlock);
    end;

    except
      on E: Exception do
        if (CurBlock = 0) or (CurBlock = Pred(NumBlocks)) then
          raise Exception.CreateFmt('Error reading %s: %s', [BlockType, E.Message])
        else
          raise Exception.CreateFmt('Error reading NIF block %d %s: %s', [Pred(CurBlock), BlockType, E.Message]);
    end;

    //if Assigned(aDataStart) and (Result < (PByte(aDataEnd) - PByte(aDataStart))) then
    //  raise Exception.CreateFmt('Read size is less than the available NIF stream data (%d bytes remaining)', [Integer(aDataEnd) - Integer(aDataStart) - Result]);

  finally
    elBlockType.Def.Free;
    elBlockType.Free;
  end;

  inherited;
end;

function TwbNifFile.Serialize(const aDataStart, aDataEnd: Pointer): Integer;
var
  i: integer;
  elBlockType: TdfElement;
begin
  Result := 0;
  elBlockType := wbSizedString('Block Type').CreateElement(nil);
  elBlockType.SetToDefault;
  try
    for i := 0 to Pred(Count) do begin
      // prefix data before each block except header and footer
      if (i <> 0) and (i <> Pred(Count)) then
        if NifVersion = nfTES3 then begin
          elBlockType.EditValue := Items[i].Def.Name;
          Result := Result + elBlockType.Serialize(PByte(aDataStart) + Result, aDataEnd);
        end
        else if Version = v1010106 then begin
          // always 0
          PCardinal(PByte(aDataStart) + Result)^ := 0;
          Inc(Result, 4);
        end;

      Result := Result + Items[i].Serialize(PByte(aDataStart) + Result, aDataEnd);
    end;
  finally
    elBlockType.Def.Free;
    elBlockType.Free;
  end;
end;

procedure TwbNifFile.SerializeToJSON(const aJSON: TJSONBaseObject);
var
  i: integer;
begin
  // inherited generic TdfContainer doesn't have JSON serialization
  for i := 0 to Pred(Count) do
    Items[i].SerializeToJSON(aJSON);
end;

procedure TwbNifFile.UnSerializeFromJSON(const aJSON: TJSONBaseObject);
var
  obj: TJSONObject;
  oname, blocktype: string;
  ss: TStringDynArray;
  i: integer;
  Block: TdfElement;
begin
  Clear;

  obj := TJSONObject(aJSON);
  for i := 0 to Pred(obj.Count) do begin
    oname := obj.Names[i];
    ss := SplitString(oname, ' ');
    if Length(ss) > 1 then
      blocktype := ss[1]
    else
      blocktype := ss[0];

    if (i = 0) and (blocktype <> 'NiHeader') then
      DoException('First block must be NiHeader');

    if (i = Pred(obj.Count)) and (blocktype <> 'NiFooter') then
      DoException('Last block must be NiFooter');

    ReadBlock(blocktype, nil, nil);
    Block := Items[Pred(Count)];
    Block.UnSerializeFromJSON(obj);
  end;
end;

procedure TwbNifFile.RemapBlocks(const aMap: array of Integer);
var
  i, j, b: integer;
  NifBlock: TwbNifBlock;
begin
  // iterate over refs of all blocks including footer
  for i := 0 to BlocksCount do begin
    if i < BlocksCount then
      NifBlock := Blocks[i]
    else
      NifBlock := Footer;
    for j := 0 to Pred(NifBlock.RefsCount) do begin
      b := NifBlock.Refs[j].NativeValue;
      if (b < Low(aMap)) or (b > High(aMap)) then
        Continue;
      if b <> aMap[b] then
        NifBlock.Refs[j].NativeValue := aMap[b];
    end;
  end;
end;

procedure TwbNifFile.Delete(Index: Integer);
var
  i: integer;
  map: array of Integer;
begin
  // check index range
  Blocks[Index];

  SetLength(map, BlocksCount);
  // blocks before deleted one have the same indices
  for i := Low(map) to Pred(Index) do
    map[i] := i;
  // deleted block refs are replaced with None
  map[Index] := -1;
  // blocks after deletion are shifted
  for i := Succ(Index) to High(map) do
    map[i] := i - 1;

  RemapBlocks(map);

  // +1 to account for NiHeader
  inherited Delete(Succ(Index));
end;

procedure TwbNifFile.Move(CurIndex, NewIndex: Integer);
var
  i: integer;
  map: array of Integer;
begin
  // check index range
  Blocks[CurIndex];
  Blocks[NewIndex];

  SetLength(map, BlocksCount);
  // blocks before movement range are unchanged
  for i := Low(map) to Pred(Min(CurIndex, NewIndex)) do
    map[i] := i;
  // blocks after movement range are unchanged
  for i := Succ(Max(CurIndex, NewIndex)) to High(map) do
    map[i] := i;

  // moving backward - blocks in between are shifted to the right
  if CurIndex > NewIndex then
    for i := NewIndex to Pred(CurIndex) do
      map[i] := i + 1
  // moving forward - blocks in between are shifted to the left
  else
    for i := Succ(CurIndex) to NewIndex do
      map[i] := i - 1;

  map[CurIndex] := NewIndex;
  RemapBlocks(map);

  // +1 to account for NiHeader
  inherited Move(Succ(CurIndex), Succ(NewIndex));
end;

function TwbNifFile.ReadBlock(const aBlockType: string; const aDataStart, aDataEnd: Pointer): Integer;
var
  NiBlock: TdfElement;
begin
  NiBlock := wbNiObjectDef(aBlockType).CreateElement(Self);
  Put(Count, NiBlock);
  Result := NiBlock.UnSerialize(aDataStart, aDataEnd, 0);
end;

function TwbNifFile.AddBlock(const aBlockType: string): TwbNifBlock;
var
  f: TdfElement;
begin
  Result := TwbNifBlock(wbNiObjectDef(aBlockType).CreateElement(Self));
  Result.SetToDefault;
  // store NiFooter
  f := Footer;
  // put new block over footer
  Put(Count-1, Result);
  // append NiFooter back at the end
  Put(Count, f);
  // if it is the first NiNode type block, add it as a root by default
  if (BlocksCount = 1) and wbIsNiObject(aBlockType, 'NiNode') then
    f.Elements['Roots'].Add.NativeValue := 0;
end;

function TwbNifFile.InsertBlock(Index: Integer; const aBlockType: string): TwbNifBlock;
begin
  // check index range
  Blocks[Index];

  Result := AddBlock(aBlockType);
  Move(Result.Index, Index);
end;

procedure TwbNifFile.ConvertBlock(Index: Integer; const aBlockType: string);
var
  Block, NewBlock: TwbNifBlock;
  i: Integer;
  bTriangulate: Boolean;
  tris: TTriangleArray;
  Entries: TdfElement;
begin
  Block := Blocks[Index];
  NewBlock := TwbNifBlock(wbNiObjectDef(aBlockType).CreateElement(Self));
  NewBlock.SetToDefault;

  bTriangulate := (Block.BlockType = 'NiTriStripsData') and (NewBlock.BlockType = 'NiTriShapeData');
  if bTriangulate then
    tris := TriangulateStrips(Block.GetStrips);

  try
    NewBlock.Assign(Block);
  except
    NewBlock.Free;
    DoException('Incompatible block type: ' + aBlockType);
  end;
  // +1 to account for NiHeader
  Put(Succ(Index), NewBlock);
  Block.Free;

  if bTriangulate then begin
    NewBlock.NativeValues['Has Triangles'] := 1;
    NewBlock.NativeValues['Num Triangles'] := Length(tris);
    Entries := NewBlock.Elements['Triangles'];
    Entries.Count := Length(tris);
    for i := 0 to Pred(Entries.Count) do
      wbSetTriangle(tris[i], Entries[i]);
  end;
end;

function TwbNifFile.CopyBlock(Index: Integer): TwbNifBlock;
begin
  Result := AddBlock(Blocks[Index].BlockType);
  Result.Assign(Blocks[Index]);
end;

function TwbNifFile.BlockByType(const aBlockType: string; aInherited: Boolean = False): TwbNifBlock;
var
  i, cnt: Integer;
begin
  cnt := Pred(BlocksCount);
  for i := 0 to cnt do
    if (not aInherited and (Blocks[i].BlockType = aBlockType)) or
       (aInherited and wbIsNiObject(Blocks[i].BlockType, aBlockType))
    then begin
      Result := Blocks[i];
      Exit;
    end;
  Result := nil;
end;

function TwbNifFile.BlocksByType(const aBlockType: string; aInherited: Boolean = False): TwbNifBlocks;
var
  i, cnt: Integer;
begin
  cnt := Pred(BlocksCount);
  for i := 0 to cnt do
    if (not aInherited and (Blocks[i].BlockType = aBlockType)) or
       (aInherited and wbIsNiObject(Blocks[i].BlockType, aBlockType))
    then begin
      SetLength(Result, Succ(Length(Result)));
      Result[Pred(Length(Result))] := Blocks[i];
    end;
end;

function TwbNifFile.BlockByName(const aBlockName: string): TwbNifBlock;
var
  i, cnt: Integer;
begin
  if aBlockName = '' then
    raise Exception.Create('Can not find block by an empty name');

  cnt := Pred(BlocksCount);
  for i := 0 to cnt do
    if Blocks[i].EditValues['Name'] = aBlockName then begin
      Result := Blocks[i];
      Exit;
    end;
  Result := nil;
end;

function TwbNifFile.BlockByPath(const aBlockPath: string): TwbNifBlock;
var
  i, cnt, p: Integer;
  curpath, path: string;
begin
  Result := nil;

  path := aBlockPath;
  while (path <> '') and (path[1] = '\') do
    System.Delete(path, 1, 1);

  if path = '' then
    Exit;

  p := Pos('\', path);
  if p <> 0 then begin
    curpath := Copy(path, 1, p - 1);
    path := Copy(path, p + 1, Length(path));
  end
  else begin
    curpath := path;
    path := '';
  end;

  cnt := Pred(BlocksCount);
  for i := 0 to cnt do
    if SameText(Blocks[i].BlockType, curpath) or (Blocks[i].EditValues['Name'] = curpath) then begin
      if path <> '' then
        Result := Blocks[i].BlockByPath(path)
      else
        Result := Blocks[i];

      Exit;
    end;
end;

function TwbNifFile.SpellTriangulate: Boolean;
var
  i, j, p: integer;
  Parts, Part, Entries: TdfElement;
  tris: TTriangleArray;
begin
  Result := False;
  for i := 0 to Pred(BlocksCount) do
    if Blocks[i].BlockType = 'NiTriStrips' then begin
      ConvertBlock(i, 'NiTriShape');
      Result := True;
    end

    else if Blocks[i].BlockType = 'NiTriStripsData' then begin
      ConvertBlock(i, 'NiTriShapeData');
      Result := True;
    end

    else if Blocks[i].BlockType = 'NiSkinPartition' then begin
      Parts := Blocks[i].Elements['Partitions'];
      for p := 0 to Pred(Parts.Count) do begin
        Part := Parts[p];
        if Part.NativeValues['Num Strips'] = 0 then
          Continue;
        tris := TriangulateStrips(Blocks[i].GetStrips(Part));
        Part.NativeValues['Num Strips'] := 0;
        Part.NativeValues['Num Triangles'] := Length(tris);
        Entries := Part.Elements['Triangles'];
        Entries.Count := Length(tris);
        for j := 0 to Pred(Entries.Count) do
          wbSetTriangle(tris[j], Entries[j]);
        Result := True;
      end;
    end;
end;

function TwbNifFile.SpellFaceNormals: Boolean;
var
  i: Integer;
begin
  Result := False;
  for i := 0 to Pred(BlocksCount) do
    if Blocks[i].UpdateNormals(True) then
      Result := True;
end;

function TwbNifFile.SpellUpdateTangents: Boolean;
var
  i: Integer;
begin
  Result := False;
  for i := 0 to Pred(BlocksCount) do
    if Blocks[i].UpdateTangents(False) then
      Result := True;
end;

function TwbNifFile.SpellAddUpdateTangents: Boolean;
var
  i: Integer;
begin
  Result := False;
  for i := 0 to Pred(BlocksCount) do
    if Blocks[i].UpdateTangents(True) then
      Result := True;
end;

function TwbNifFile.GetAssetsList: TStringDynArray;
var
  i, j, k: integer;
  a: TStringDynArray;
  b: Boolean;
begin
  for i := 0 to Pred(BlocksCount) do begin
    a := Blocks[i].GetAssetsList;

    for j := Low(a) to High(a) do begin
      b := False;
      for k := Low(Result) to High(Result) do
        if SameText(Result[k], a[j]) then begin
          b := True;
          Break;
        end;

      if not b then begin
        SetLength(Result, Succ(Length(Result)));
        Result[Pred(Length(Result))] := a[j];
      end;
    end;

  end;
end;

function TwbNifFile.GetHeader: TwbNifBlock;
begin
  if Count = 0 then
    SetToDefault;

  Result := TwbNifBlock(Items[0]);
end;

function TwbNifFile.GetFooter: TwbNifBlock;
begin
  if Count = 0 then
    SetToDefault;

  Result := TwbNifBlock(Items[Pred(Count)]);
end;

function TwbNifFile.GetBlocksCount: Integer;
begin
  if Count = 0 then
    SetToDefault;

  Result := Count - 2;
end;

function TwbNifFile.GetBlock(Index: Integer): TwbNifBlock;
begin
  if (Index >= 0) and (Index < BlocksCount) then
    // +1 to skip NiHeader
    Result := TwbNifBlock(Items[Succ(Index)])
  else
    raise Exception.Create('Invalid block index ' + IntToStr(Index));
end;

procedure TwbNifFile.UpdateHeader;
var
  i, j, l: integer;
  s: string;
  slTypes: TStringList;
  BlockTypes, BlockTypeIndex, {BlockSize, }Strings: TdfElement;
  Block: TwbNifBlock;
  map: array of integer;
begin
  Header.NativeValues['Num Blocks'] := BlocksCount;

  BlockTypes := Header.Elements['Block Types'];
  if Assigned(BlockTypes) then begin
    slTypes := TStringList.Create;
    try
      // unique list of block types
      for i := 0 to Pred(BlocksCount) do begin
        s := Blocks[i].BlockType;
        if slTypes.IndexOf(s) = -1 then
          slTypes.Add(s);
      end;

      // store it
      BlockTypes.Count := slTypes.Count;
      for i := 0 to Pred(slTypes.Count) do
        BlockTypes[i].EditValue := slTypes[i];

      // type indices for blocks
      BlockTypeIndex := Header.Elements['Block Type Index'];
      if Assigned(BlockTypeIndex) then begin
        BlockTypeIndex.Count := BlocksCount;
        for i := 0 to Pred(BlocksCount) do
          BlockTypeIndex[i].NativeValue := slTypes.IndexOf(Blocks[i].BlockType);
      end;
    finally
      slTypes.Free;
    end;
  end;

  // block sizes
  // done in DataSize calculation to avoid double blocks scanning
  {BlockSize := Header.Elements['Block Size'];
  if Assigned(BlockSize) then begin
    BlockSize.Count := BlocksCount;
    for i := 0 to Pred(BlocksCount) do
      BlockSize[i].NativeValue := Blocks[i].DataSize;
  end;}

  // strings table
  Strings := Header.Elements['Strings'];
  if Assigned(Strings) then begin

    // removing unused strings
    if nfoRemoveUnusedStrings in Options then begin
      SetLength(map, Strings.Count);
      for i := Low(map) to High(map) do map[i] := -1;

      // mapping used strings, unused will remain as -1 in the map
      for i := 0 to Pred(BlocksCount) do begin
        Block := Blocks[i];
        for j := 0 to Pred(Block.StringsCount) do begin
          l := Block.Strings[j].NativeValue;
          if (l >= Low(map)) and (l <= High(map)) then
            map[l] := l;
        end;
      end;

      // reindexing map
      j := 0;
      for i := Low(map) to High(map) do
        if map[i] = -1 then
          Inc(j)
        else if j <> 0 then
          Dec(map[i], j);

      // updating strings indices
      for i := 0 to Pred(BlocksCount) do begin
        Block := Blocks[i];
        for j := 0 to Pred(Block.StringsCount) do begin
          l := Block.Strings[j].NativeValue;
          if (l >= Low(map)) and (l <= High(map)) then
            Block.Strings[j].NativeValue := map[l]
          else
            // fix out of bounds string index
            Block.Strings[j].NativeValue := -1;
        end;
      end;

      // removing unused strings from the table
      for i := Pred(Strings.Count) downto 0 do
        if map[i] = -1 then
          Strings.Delete(i);
    end;

    Header.NativeValues['Num Strings'] := Strings.Count;
    l := 0;
    for i := 0 to Pred(Strings.Count) do begin
      j := Length(Strings[i].EditValue);
      if j > l then l := j;
    end;
    Header.NativeValues['Max String Length'] := l;
  end;
end;

procedure TwbNifFile.UpdateNifVersion;
begin
  Version := wbNifVersionToInt(Header.EditValues['Version']);
  UserVersion := Header.NativeValues['User Version'];
  UserVersion2 := Header.NativeValues['User Version 2'];

  if Version = v4002 then
    FNifVersion := nfTES3
  // some 3rd party Oblivion meshes have user version 0
  else if (Version = v20005) and (UserVersion in [0, 11]) and (UserVersion2 in [0, 11]) then
    FNifVersion := nfTES4
  else if (Version = v20004) and (UserVersion in [10, 11]) and (UserVersion2 = 11) then
    FNifVersion := nfTES4
  else if (Version = v1010106) and (UserVersion = 10) and (UserVersion2 = 5) then
    FNifVersion := nfTES4
  else if (Version = v10200) and (UserVersion = 10) and (UserVersion2 in [6, 7, 8, 9, 11]) then
    FNifVersion := nfTES4
  //else if (Version = v10010) then
  //  FNifVersion := nfTES4
  else if (Version = v20207) and (UserVersion = 11) then
    FNifVersion := nfFO3
  else if (Version = v20207) and (UserVersion = 12) and (UserVersion2 = 83) then
    FNifVersion := nfTES5
  else if (Version = v20207) and (UserVersion = 12) and (UserVersion2 = 100) then
    FNifVersion := nfSSE
  else if (Version = v20207) and (UserVersion = 12) and (UserVersion2 = 130) then
    FNifVersion := nfFO4
  else
    FNifVersion := nfUnknown;

  if FNifVersion = nfUnknown then
    raise Exception.CreateFmt('Unknown NIF version "%s" ("User Version"=%d, "User Version 2"=%d)', [wbIntToNifVersion(Version), UserVersion, UserVersion2]);
end;

procedure TwbNifFile.SetNifVersion(aVersion: TwbNifVersion);
var
  v: string;
  h: TwbNifBlock;
begin
  h := Header; // access and create header if missing

  if aVersion = nfTES3 then begin
    v := '4.0.0.2';
    UserVersion := 0;
    UserVersion2 := 0;
  end
  else if aVersion = nfTES4 then begin
    v := '20.0.0.5';
    UserVersion := 11;
    UserVersion2 := 11;
  end
  else if aVersion = nfFO3 then begin
    v := '20.2.0.7';
    UserVersion := 11;
    UserVersion2 := 34;
  end
  else if aVersion = nfTES5 then begin
    v := '20.2.0.7';
    UserVersion := 12;
    UserVersion2 := 83;
  end
  else if aVersion = nfSSE then begin
    v := '20.2.0.7';
    UserVersion := 12;
    UserVersion2 := 100;
  end
  else if aVersion = nfFO4 then begin
    v := '20.2.0.7';
    UserVersion := 12;
    UserVersion2 := 130;
  end else
    Exit;

  Version := wbNifVersionToInt(v);
  h.NativeValues['Version'] := Version;
  h.NativeValues['User Version'] := UserVersion;
  h.NativeValues['User Version 2'] := UserVersion2;
  if aVersion = nfTES3 then
    h.EditValues['Magic'] := sNifMagicNetImmerse + v
  else
    h.EditValues['Magic'] := sNifMagicGamebryo + v;

  FNifVersion := aVersion;
end;



{ Widely used events, simple version checks }

function EnBefore4002(const e: TdfElement): Boolean; begin Result := nif(e).Version <= v4002; end;
function EnBefore41012(const e: TdfElement): Boolean; begin Result := nif(e).Version <= v41012; end;
function EnSince4210(const e: TdfElement): Boolean; begin Result := nif(e).Version >= v4210; end;
function EnBefore4220(const e: TdfElement): Boolean; begin Result := nif(e).Version <= v4220; end;
function EnBefore10010(const e: TdfElement): Boolean; begin Result := nif(e).Version <= v10010; end;
function EnSince10010(const e: TdfElement): Boolean; begin Result := nif(e).Version >= v10010; end;
function EnBefore10012(const e: TdfElement): Boolean; begin Result := nif(e).Version <= v10012; end;
function EnSince10012(const e: TdfElement): Boolean; begin Result := nif(e).Version >= v10012; end;
function EnSince10013(const e: TdfElement): Boolean; begin Result := nif(e).Version >= v10013; end;
function EnBefore10100(const e: TdfElement): Boolean; begin Result := nif(e).Version <= v10100; end;
function EnSince10100(const e: TdfElement): Boolean; begin Result := nif(e).Version >= v10100; end;
function EnBefore10200(const e: TdfElement): Boolean; begin Result := nif(e).Version <= v10200; end;
function EnSince10200(const e: TdfElement): Boolean; begin Result := nif(e).Version >= v10200; end;
function En1010106(const e: TdfElement): Boolean; begin Result := nif(e).Version = v1010106; end;
function EnSince1010101(const e: TdfElement): Boolean; begin Result := nif(e).Version >= v1010101; end;
function EnSince1010106(const e: TdfElement): Boolean; begin Result := nif(e).Version >= v1010106; end;
function EnBefore10401(const e: TdfElement): Boolean; begin Result := nif(e).Version <= v10401; end;
function EnSince10401(const e: TdfElement): Boolean; begin Result := nif(e).Version >= v10401; end;
function EnSince20004(const e: TdfElement): Boolean; begin Result := nif(e).Version >= v20004; end;
function EnBefore20005(const e: TdfElement): Boolean; begin Result := nif(e).Version <= v20005; end;
function EnSince20103(const e: TdfElement): Boolean; begin Result := nif(e).Version >= v20103; end;
function EnSince20205(const e: TdfElement): Boolean; begin Result := nif(e).Version >= v20205; end;
function EnSince20207(const e: TdfElement): Boolean; begin Result := nif(e).Version >= v20207; end;
function EnSSE(const e: TdfElement): Boolean; begin with nif(e) do Result := (Version = v20207) and (UserVersion2 = 100); end;

// before save event to remove None links from Refs list
procedure RemoveNoneLinks(const aElement: TdfElement);
var
  i: Integer;
begin
  with nif(aElement) do
  if InternalUpdates and (nfoCollapseLinkArrays in Options) and not (aElement.Def.Size > 0) then
    for i := Pred(aElement.Count) downto 0 do
      if aElement[i].NativeValue < 0 then begin
        aElement.Delete(i);
        //WriteLn('Removing none link index ' + IntToStr(i) + ' in ' + aElement.Path);
      end;
end;


{ Bool Type }

function wbBool_Decider(const e: TdfElement): Integer; begin if nif(e).Version < v4101 then Result := 1 else Result := 0; end;
procedure wbBool_GetValue(const aElement: TdfElement; var aValue: Variant); begin if aValue <> 0 then aValue := 1; end;

function wbBool(const aName: string; const aDefaultValue: string; const aEvents: array of const): TdfDef; overload;
begin
  Result := dfUnion([
    dfEnum(aName,  dtU8, [0, 'no', 1, 'yes'], aDefaultValue, []),
    dfEnum(aName, dtU32, [0, 'no', 1, 'yes'], aDefaultValue, [DF_OnGetValue, @wbBool_GetValue])
  ], aEvents);
  Result.OnDecide := @wbBool_Decider;
end;

function wbBool(const aName: string; const aEvents: array of const): TdfDef; overload;
begin
  Result := wbBool(aName, '', aEvents);
end;

function wbBool(const aName: string): TdfDef; overload;
begin
  Result := wbBool(aName, '', []);
end;


{ String Type }

function wbString_Decider(const e: TdfElement): Integer; begin if nif(e).Version < v20103 then Result := 1 else Result := 0; end;

procedure wbString_OnCreate(const aElement: TdfElement);
begin
  nifblk(aElement).AddString(aElement);
end;

procedure wbString_OnDestroy(const aElement: TdfElement);
begin
  nifblk(aElement).RemoveString(aElement);
end;

procedure wbString_AfterLoad(const aElement: TdfElement; const aDataStart: Pointer; aDataSize: Integer);
begin
  if aDataStart = nil then
    aElement.NativeValue := -1;
end;

procedure wbString_Get(const aElement: TdfElement; var aText: string);
var
  i: integer;
  Strings: TdfElement;
begin
  i := aElement.NativeValue;
  if i = -1 then
    aText := ''
  else begin
    Strings := nif(aElement).Header.Elements['Strings'];
    if Assigned(Strings) and (i < Strings.Count) then
      aText := Strings[i].EditValue
    else
      aText := '<Error: Invalid string index ' + aText + '>';
  end;
end;

procedure wbString_Set(const aElement: TdfElement; var aText: string);
var
  Strings: TdfElement;
  i: integer;
begin
  // empty string
  if aText = '' then begin
    aText := IntToStr(-1);
    Exit;
  end;

  Strings := nif(aElement).Header.Elements['Strings'];
  if not Assigned(Strings) then
    aElement.DoException('Strings table not found in NiHeader');

  // reuse existing string
  for i := 0 to Pred(Strings.Count) do
    if Strings[i].EditValue = aText then begin
      aText := IntToStr(i);
      Exit;
    end;
  // or add a new one
  Strings.Add.EditValue := aText;
  aText := IntToStr(Pred(Strings.Count));
end;

function wbString(const aName: string; const aDefaultValue: string; const aEvents: array of const): TdfDef; overload;
begin
  Result := dfUnion([
    dfInteger(aName, dtS32, aDefaultValue, [
      DF_OnCreate,  @wbString_OnCreate,
      DF_OnDestroy, @wbString_OnDestroy,
      DF_OnAfterLoad,  @wbString_AfterLoad,
      DF_OnGetText, @wbString_Get,
      DF_OnSetText, @wbString_Set
    ]),
    wbSizedString(aName, aDefaultValue, [])
  ], aEvents);
  Result.OnDecide := @wbString_Decider;
end;

function wbString(const aName: string; const aEvents: array of const): TdfDef; overload;
begin
  Result := wbString(aName, '', aEvents);
end;

function wbString(const aName: string): TdfDef; overload;
begin
  Result := wbString(aName, '', []);
end;


{ NiRef Type }

function TwbNiRefDef.CreateElement(const aParent: TdfElement): TdfElement;
begin
  Result := TwbNiRef.Create(Self, aParent);
end;

function TwbNiRefDef.Clone: TdfDef;
begin
  Result := TwbNiRefDef.Create(Name, DataType, []);
  Result.Assign(Self);
end;

procedure TwbNiRefDef.Assign(const aDef: TdfDef);
begin
  inherited;
  if aDef is TwbNiRefDef then begin
    FTemplate := TwbNiRefDef(aDef).Template;
    FPtr := TwbNiRefDef(aDef).Ptr;
  end;
end;

function TwbNiRef.GetTemplate: string;
begin
  Result := TwbNiRefDef(Def).Template;
end;

function TwbNiRef.GetPtr: Boolean;
begin
  Result := TwbNiRefDef(Def).Ptr;
end;


procedure wbNiRef_OnCreate(const aElement: TdfElement);
begin
  nifblk(aElement).AddRef(aElement);
end;

procedure wbNiRef_OnDestroy(const aElement: TdfElement);
begin
  nifblk(aElement).RemoveRef(aElement);
end;

function wbNiRef_GetLinksTo(const aElement: TdfElement): TdfElement;
var
  BlockIndex: Integer;
begin
  Result := nil;
  BlockIndex := aElement.NativeValue;
  if (BlockIndex >= 0) and (BlockIndex < nif(aElement).BlocksCount) then
    Result := nif(aElement).Blocks[BlockIndex];
end;

procedure wbNiRef_GetText(const aElement: TdfElement; var aText: string);
var
  BlockIndex: Integer;
  Block: TwbNifBlock;
  Name: string;
begin
  BlockIndex := aElement.NativeValue;
  if BlockIndex = -1 then
    aText := 'None'
  else begin
    Block := TwbNifBlock(aElement.LinksTo);
    if Assigned(Block) then begin
      Name := Block.EditValues['Name'];
      aText := aText + ' ' + Block.BlockType;
      if Name <> '' then
        aText := aText + ' "' + Name + '"';
    end;
  end;
    //aText := '<Error: Invalid block index' + aText + '>';
end;

procedure wbNiRef_SetText(const aElement: TdfElement; var aText: string);
begin
  if aText <> '' then
    aText := SplitString(aText, ' ')[0];
  if (aText = '') or (aText = 'None') then
    aText := '-1';
end;

function wbNiRef(const aName, aTemplate: string; const aEvents: array of const): TwbNiRefDef; overload;
begin
  Result := TwbNiRefDef.Create(aName, dtS32, []);
  Result.Template := aTemplate;
  Result.DefaultValue := '-1';
  Result.AssignEvents(aEvents);
  Result.OnCreate := @wbNiRef_OnCreate;
  Result.OnDestroy := @wbNiRef_OnDestroy;
  Result.OnLinksTo := @wbNiRef_GetLinksTo;
  Result.OnGetText := @wbNiRef_GetText;
  Result.OnSetText := @wbNiRef_SetText;
end;

function wbNiRef(const aName, aTemplate: string): TwbNiRefDef; overload;
begin
  Result := wbNiRef(aName, aTemplate, []);
end;


{ NiPtr Type }

function wbNiPtr(const aName, aTemplate: string; const aEvents: array of const): TwbNiRefDef; overload;
begin
  Result := wbNiRef(aName, aTemplate, aEvents);
  Result.Ptr := True;
end;

function wbNiPtr(const aName, aTemplate: string): TwbNiRefDef; overload;
begin
  Result := wbNiPtr(aName, aTemplate, []);
end;


{ Fields that require version checks or bool/string values }

function wbTES4_FO3_TES5_Decider(const e: TdfElement): Integer;
begin
  with nif(e) do
    if (Version >= v20004) and (Version <= v20005) then
      Result := 0
    else if (Version = v20207) and (UserVersion2 <= 34) then
      Result := 1
    else if (Version = v20207) and (UserVersion2 > 34) then
      Result := 2
    else
      Result := 2;
end;

function wbHavokMaterial(const aName, aDefaultValue: string; const aEvents: array of const): TdfDef;
begin
  Result := dfValueUnion(dtU32, wbTES4_FO3_TES5_Decider, [
    wbOblivionHavokMaterial(aName, aDefaultValue, []),
    wbFallout3HavokMaterial(aName, aDefaultValue, []),
    wbSkyrimHavokMaterial(aName, aDefaultValue, [])
  ], aEvents);
end;

function wbHavokLayer(const aName, aDefaultValue: string; const aEvents: array of const): TdfDef;
begin
  Result := dfValueUnion(dtU32, wbTES4_FO3_TES5_Decider, [
    wbOblivionLayer(aName, aDefaultValue, []),
    wbFallout3Layer(aName, aDefaultValue, []),
    wbSkyrimLayer(aName, aDefaultValue, [])
  ], aEvents);
end;

function wbHavokFilter(const aName: string; const aEvents: array of const): TdfDef;
begin
  Result := dfStruct(aName, [
    wbHavokLayer('Layer', '1', []),
    dfInteger('Flags and Part Number', dtU8),
    dfInteger('Group', dtU16)
  ], aEvents);
end;

function wbbhkCMSDMaterial(const aName: string; const aEvents: array of const): TdfDef;
begin
  Result := dfStruct(aName, [
    wbSkyrimHavokMaterial('Material', '', []),
    wbHavokFilter('Havok Filter', [])
  ], aEvents);
end;

function wbOblivionSubShape(const aName: string; const aEvents: array of const): TdfDef;
begin
  Result := dfStruct(aName, [
    wbHavokFilter('Havok Filter', []),
    dfInteger('Num Vertices', dtU32),
    wbHavokMaterial('Material', '', [])
  ], aEvents);
end;

function wbTexDesc_EnTranslation(const e: TdfElement): Boolean; begin Result := (nif(e).Version >= v10100) and (e.NativeValues['..\Has Texture Transform'] <> 0); end;

function wbTexDesc(const aName: string; const aEvents: array of const): TdfDef;
begin
  Result := dfStruct(aName, [
    wbNiRef('Source', 'NiSourceTexture'),
    wbTexClampMode('Clamp Mode', 'WRAP_S_WRAP_T', [DF_OnGetEnabled, @EnBefore20005]),
    wbTexFilterMode('Filter Mode', 'FILTER_TRILERP', [DF_OnGetEnabled, @EnBefore20005]),
    dfInteger('Flags', dtU16, [DF_OnGetEnabled, @EnSince20103]),
    dfInteger('UV Set', dtU32, [DF_OnGetEnabled, @EnBefore20005]),
    dfInteger('PS2 L', dtS16, '0', [DF_OnGetEnabled, @EnBefore10401]),
    dfInteger('PS2 K', dtS16, '-75', [DF_OnGetEnabled, @EnBefore10401]),
    dfInteger('Unknown1', dtU16, [DF_OnGetEnabled, @EnBefore41012]),
    wbBool('Has Texture Transform', [DF_OnGetEnabled, @EnSince10100]),
    wbTexCoord('Translation', [DF_OnGetEnabled, @wbTexDesc_EnTranslation]),
    wbTexCoord('Scale', [DF_OnGetEnabled, @wbTexDesc_EnTranslation]),
    dfFloat('Rotation', '', [DF_OnGetEnabled, @wbTexDesc_EnTranslation]),
    dfEnum('Transform Method', dtU32, [
      0, 'Maya Deprecated',
      1, 'Max',
      2, 'Maya'
    ], 'Maya Deprecated', [DF_OnGetEnabled, @wbTexDesc_EnTranslation]),
    wbTexCoord('Center', [DF_OnGetEnabled, @wbTexDesc_EnTranslation])
  ], aEvents);
end;

function wbShaderTexDesc_EnMapData(const e: TdfElement): Boolean; begin Result := (nif(e).Version >= v10100) and (e.NativeValues['..\Has Map'] <> 0); end;

function wbShaderTexDesc(const aName: string; const aEvents: array of const): TdfDef;
begin
  Result := dfStruct(aName, [
   wbBool('Has Map'),
   wbTexDesc('Map', [DF_OnGetEnabled, @wbShaderTexDesc_EnMapData]),
   dfInteger('Map ID', dtU32, [DF_OnGetEnabled, @wbShaderTexDesc_EnMapData])
  ], aEvents);
end;

const
  // VF flags mask
  VF_VERTEX = 1 shl 4;
  VF_UV = 1 shl 5;
  VF_UV_2 = 1 shl 6;
  VF_NORMAL = 1 shl 7;
  VF_TANGENT = 1 shl 8;
  VF_COLORS = 1 shl 9;
  VF_SKINNED = 1 shl 10;
  VF_LANDDATA = 1 shl 11;
  VF_EYEDATA = 1 shl 12;
  VF_FULLPREC = 1 shl 14;

procedure wbVertexDesc_SetValue(const e: TdfElement; var aValue: Variant);
const
  szByte = 1;
  szFloat = 4;
  szHalfFloat = 2;
var
  VF: Word;
  bFullPrec: Boolean;
  el: TdfElement;
  ofst           : Byte;
  //szVertexData   : Byte;
  //szVertex       : Byte;
  oTexCoord0     : Byte;
  oTexCoord1     : Byte;
  oNormal        : Byte;
  oTangent       : Byte;
  oColor         : Byte;
  oSkinningData  : Byte;
  oLandscapeData : Byte;
  oEyeData       : Byte;
begin
  VF := aValue;
  bFullPrec := (VF and VF_FULLPREC > 0) or (nif(e).NifVersion = nfSSE);

  ofst := 0;
  if VF and VF_VERTEX > 0 then begin
    // either Bitangent X or unknown int/short is present with vertex
    if bFullPrec then Inc(ofst, szFloat * 3 + szFloat) else Inc(ofst, szHalfFloat * 3 + szHalfFloat);
  end;

  // offset to UVs
  oTexCoord0 := 0;
  if VF and VF_UV > 0 then begin
    oTexCoord0 := ofst div 4;
    Inc(ofst, szHalfFloat * 2);
  end;

  // offset to second UVs, always 0
  oTexCoord1 := 0;

  // offset to Normal
  oNormal := 0;
  if VF and VF_NORMAL > 0 then begin
    oNormal := ofst div 4;
    // Bitangent Y is present with normal
    Inc(ofst, szByte * 3 + szByte);
  end;

  // offset to Tangent
  oTangent := 0;
  if (VF and VF_NORMAL > 0) and (VF and VF_TANGENT > 0) then begin
    oTangent := ofst div 4;
    // Bitangent Z is present with tangent
    Inc(ofst, szByte * 3 + szByte);
  end;

  // offset to Color
  oColor := 0;
  if VF and VF_COLORS > 0 then begin
    oColor := ofst div 4;
    Inc(ofst, szByte * 4);
  end;

  // offset to skinning data
  oSkinningData := 0;
  if VF and VF_SKINNED > 0 then begin
    oSkinningData := ofst div 4;
    Inc(ofst, szHalfFloat * 4 + szByte * 4); // bone weights and indices
  end;

  // offset to landscape data, always 0
  oLandscapeData := 0;

  // offset to eye data
  oEyeData := 0;
  if VF and VF_EYEDATA > 0 then begin
    oEyeData := ofst div 4;
    Inc(ofst, szFloat);
  end;

  // ofst has the full vertex size at this point
  e.NativeValues['..\VF1'] := ofst div 4;
  // SSE has a separate Vertex Size field holding size in bytes
  e.NativeValues['..\..\Vertex Size'] := ofst;
  // update cached VF value on Vertex Data array
  el := e.Elements['..\..\Vertex Data'];
  if Assigned(el) then el.UserData := VF;
  e.NativeValues['..\VF2'] := oTexCoord0 or (oTexCoord1 shl 4);
  e.NativeValues['..\VF3'] := oNormal or (oTangent shl 4);
  e.NativeValues['..\VF4'] := oColor or (oSkinningData shl 4);
  e.NativeValues['..\VF5'] := oLandscapeData or (oEyeData shl 4);
  e.NativeValues['..\VF8'] := 0;
end;

function wbVertexDesc(const aName: string; const aEvents: array of const): TdfDef;
begin
  Result := dfStruct(aName, [
    dfInteger('VF1', dtU8),
    dfInteger('VF2', dtU8),
    dfInteger('VF3', dtU8),
    dfInteger('VF4', dtU8),
    dfInteger('VF5', dtU8),
    wbVertexFlags('VF', 'VF_VERTEX | VF_UV | VF_NORMAL | VF_TANGENT', [DF_OnSetValue, @wbVertexDesc_SetValue]),
    dfInteger('VF8', dtU8)
  ], aEvents);
end;

// VF is cached on the array itself (Vertex Data OnEnabled event and VF's OnSetValue)
function VF(const e: TdfElement): Word; inline; begin Result := e.Parent.Parent.UserData; end;
function wbBSVertexData_DecideFullPrecision(const e: TdfElement): Integer; begin if (VF(e) and VF_FULLPREC <> 0) or (nif(e).NifVersion = nfSSE) then Result := 1 else Result := 0; end;
function wbBSVertexData_EnVertex(const e: TdfElement): Boolean;     var ARG: Word; begin ARG := VF(e); Result := (ARG and VF_VERTEX <> 0); end;
function wbBSVertexData_EnBitangentX(const e: TdfElement): Boolean; var ARG: Word; begin ARG := VF(e); Result := (ARG and VF_VERTEX <> 0) and (ARG and VF_TANGENT <> 0); end;
function wbBSVertexData_EnUnknown(const e: TdfElement): Boolean;    var ARG: Word; begin ARG := VF(e); Result := (ARG and VF_VERTEX <> 0) and (ARG and VF_TANGENT = 0); end;
function wbBSVertexData_EnUV(const e: TdfElement): Boolean;         var ARG: Word; begin ARG := VF(e); Result := (ARG and VF_UV <> 0); end;
function wbBSVertexData_EnNormal(const e: TdfElement): Boolean;     var ARG: Word; begin ARG := VF(e); Result := (ARG and VF_NORMAL <> 0); end;
function wbBSVertexData_EnTangent(const e: TdfElement): Boolean;    var ARG: Word; begin ARG := VF(e); Result := (ARG and VF_NORMAL <> 0) and (ARG and VF_TANGENT <> 0); end;
function wbBSVertexData_EnColors(const e: TdfElement): Boolean;     var ARG: Word; begin ARG := VF(e); Result := (ARG and VF_COLORS <> 0); end;
function wbBSVertexData_EnSkinned(const e: TdfElement): Boolean;    var ARG: Word; begin ARG := VF(e); Result := (ARG and VF_SKINNED <> 0); end;
function wbBSVertexData_EnEyeData(const e: TdfElement): Boolean;    var ARG: Word; begin ARG := VF(e); Result := (ARG and VF_EYEDATA <> 0); end;

function wbBSVertexData(const aName: string): TdfDef;
begin
  Result := dfStruct(aName, [
    {0} dfUnion([
      wbHalfVector3('Vertex'),
      wbVector3('Vertex')
    ], [DF_OnGetEnabled, @wbBSVertexData_EnVertex, DF_OnDecide, @wbBSVertexData_DecideFullPrecision]),
    {1} dfUnion([
      dfFloat('Bitangent X', dtFloat16),
      dfFloat('Bitangent X')
    ], [DF_OnGetEnabled, @wbBSVertexData_EnBitangentX, DF_OnDecide, @wbBSVertexData_DecideFullPrecision]),
    {2} dfUnion([
      dfInteger('Unknown Short', dtU16),
      dfInteger('Unknown Int', dtS32)
    ], [DF_OnGetEnabled, @wbBSVertexData_EnUnknown, DF_OnDecide, @wbBSVertexData_DecideFullPrecision]),
    {3} wbHalfTexCoord('UV', [DF_OnGetEnabled, @wbBSVertexData_EnUV]),
    {4} wbByteVector3('Normal', [DF_OnGetEnabled, @wbBSVertexData_EnNormal]),
    {5} wbByteFloat('Bitangent Y', [DF_OnGetEnabled, @wbBSVertexData_EnNormal]),
    {6} wbByteVector3('Tangent', [DF_OnGetEnabled, @wbBSVertexData_EnTangent]),
    {7} wbByteFloat('Bitangent Z', [DF_OnGetEnabled, @wbBSVertexData_EnTangent]),
    {8} wbByteColor4('Vertex Colors', [DF_OnGetEnabled, @wbBSVertexData_EnColors]),
    {9} dfArray('Bone Weights', dfFloat('Bone Weights', dtFloat16), 4, '', [DF_OnGetEnabled, @wbBSVertexData_EnSkinned]),
   {10} dfArray('Bone Indices', dfInteger('Bone Indices', dtU8), 4, '', [DF_OnGetEnabled, @wbBSVertexData_EnSkinned]),
   {11} dfFloat('Eye Data', [DF_OnGetEnabled, @wbBSVertexData_EnEyeData])
  ]);
end;

function wbKeyGroup_EnInterpolation(const e: TdfElement): Boolean; begin Result := e.NativeValues['..\Num Keys'] <> 0; end;
function wbKeyGroup_EnForward(const e: TdfElement): Boolean; begin Result := e.NativeValues['..\..\..\Interpolation'] = 2; end;
function wbKeyGroup_EnTBC(const e: TdfElement): Boolean; begin Result := e.NativeValues['..\..\..\Interpolation'] = 3; end;

function wbKeyGroup(const aName, aTemplate: string; const aEvents: array of const): TdfDef;
  function wbKeyValue(const aName, aTemplate: string; const aEvents: array of const): TdfDef;
  begin
    if SameText(aTemplate, 'string') then
      Result := wbString(aName, aEvents)
    else if SameText(aTemplate, 'float') then
      Result := dfFloat(aName, aEvents)
    else if SameText(aTemplate, 'byte') then
      Result := dfInteger(aName, dtU8, aEvents)
    else if SameText(aTemplate, 'vector3') then
      Result := wbVector3(aName, aEvents)
    else if SameText(aTemplate, 'vector4') then
      Result := wbVector4(aName, aEvents)
    else if SameText(aTemplate, 'color3') then
      Result := wbColor3(aName, aEvents)
    else if SameText(aTemplate, 'color4') then
      Result := wbColor4(aName, aEvents)
    else
      raise Exception.Create('Unknown KeyGroup template: ' + aTemplate);
  end;
begin
  Result := dfStruct(aName, [
    dfInteger('Num Keys', dtU32),
    wbKeyType('Interpolation', '', [DF_OnGetEnabled, @wbKeyGroup_EnInterpolation]),
    dfArray('Keys', dfStruct('Keys', [
      dfFloat('Time'),
      wbKeyValue('Value', aTemplate, []),
      wbKeyValue('Forward', aTemplate, [DF_OnGetEnabled, @wbKeyGroup_EnForward]),
      wbKeyValue('Backward', aTemplate, [DF_OnGetEnabled, @wbKeyGroup_EnForward]),
      wbTBC('TBC', [DF_OnGetEnabled, @wbKeyGroup_EnTBC])
    ]), 0, 'Num Keys', [])
  ], aEvents);
end;

function wbControlledBlock_EnPriority(const e: TdfElement): Boolean; begin with nif(e) do Result := (Version >= v1010106) and (UserVersion2 > 0); end;
function wbControlledBlock_EnStringPalette(const e: TdfElement): Boolean; begin with nif(e) do Result := (Version >= v10200) and (Version <= v20005); end;
function wbControlledBlock_EnNodeName(const e: TdfElement): Boolean; begin with nif(e) do Result := (Version >= v20101) or (Version = v1010106); end;

function wbControlledBlock(const aName: string; const aEvents: array of const): TdfDef;
begin
  Result := dfStruct(aName, [
    wbString('Target Name', [DF_OnGetEnabled, @EnBefore10100]),
    // NiControllerSequence::InterpArrayItem
    wbNiRef('Interpolator', 'NiInterpolator', [DF_OnGetEnabled, @EnSince1010106]),
    wbNiRef('Controller', 'NiTimeController'{, [DF_OnGetEnabled, @EnSince1010106]}),
    wbNiRef('Blend Interpolator', 'NiObject', [DF_OnGetEnabled, @En1010106]),
    dfInteger('Blend Index', dtU16, [DF_OnGetEnabled, @En1010106]),
    // Bethesda-only
    dfInteger('Priority', dtU8, [DF_OnGetEnabled, @wbControlledBlock_EnPriority]),
    // From 10.2 to 20.1
    wbNiRef('String Palette', 'NiStringPalette', [DF_OnGetEnabled, @wbControlledBlock_EnStringPalette]),
    dfInteger('Node Name Offset', dtU32, [DF_OnGetEnabled, @wbControlledBlock_EnStringPalette]),
    dfInteger('Property Type Offset', dtU32, [DF_OnGetEnabled, @wbControlledBlock_EnStringPalette]),
    dfInteger('Controller Type Offset', dtU32, [DF_OnGetEnabled, @wbControlledBlock_EnStringPalette]),
    dfInteger('Controller ID Offset', dtU32, [DF_OnGetEnabled, @wbControlledBlock_EnStringPalette]),
    dfInteger('Interpolator ID Offset', dtU32, [DF_OnGetEnabled, @wbControlledBlock_EnStringPalette]),
    // After 20.1 (and 10.0.1.106)
    wbString('Node Name', [DF_OnGetEnabled, @wbControlledBlock_EnNodeName]),
    wbString('Property Type', [DF_OnGetEnabled, @wbControlledBlock_EnNodeName]),
    wbString('Controller Type', [DF_OnGetEnabled, @wbControlledBlock_EnNodeName]),
    wbString('Controller ID', [DF_OnGetEnabled, @wbControlledBlock_EnNodeName]),
    wbString('Interpolator ID', [DF_OnGetEnabled, @wbControlledBlock_EnNodeName])
  ], aEvents);
end;

function wbSkinPartition_EnVertexMap(const e: TdfElement): Boolean; begin with nif(e) do Result := (Version <= v10012) or ((Version >= v10100) and (e.NativeValues['..\Has Vertex Map'] <> 0)); end;
function wbSkinPartition_EnVertexWeights(const e: TdfElement): Boolean; begin with nif(e) do Result := (Version <= v10012) or ((Version >= v10100) and (e.NativeValues['..\Has Vertex Weights'] <> 0)); end;
function wbSkinPartition_EnStrips(const e: TdfElement): Boolean; begin with nif(e) do Result := ((Version <= v10012) or ((Version >= v10100) and (e.NativeValues['..\Has Faces'] <> 0))) and (e.NativeValues['..\Num Strips'] <> 0); end;
procedure wbSkinPartition_GetCountStrips(const e: TdfElement; var aCount: Integer); begin aCount := e.NativeValues['..\..\Strip Lengths\Strip Lengths #' + IntToStr(e.Index)]; end;
procedure wbSkinPartition_SetCountStrips(const e: TdfElement; var aCount: Integer); begin e.NativeValues['..\..\Strip Lengths\Strip Lengths #' + IntToStr(e.Index)] := aCount; end;
function wbSkinPartition_EnTriangles(const e: TdfElement): Boolean; begin with nif(e) do Result := ((Version <= v10012) or ((Version >= v10100) and (e.NativeValues['..\Has Faces'] <> 0))) and (e.NativeValues['..\Num Strips'] = 0); end;
function wbSkinPartition_EnBoneIndices(const e: TdfElement): Boolean; begin Result := e.NativeValues['..\Has Bone Indices'] <> 0; end;
function wbSkinPartition_EnUnknownShort(const e: TdfElement): Boolean; begin Result := nif(e).UserVersion2 > 34; end;

function wbSkinPartition(const aName: string; const aEvents: array of const): TdfDef;
begin
  Result := dfStruct(aName, [
    dfInteger('Num Vertices', dtU16),
    dfInteger('Num Triangles', dtU16),
    dfInteger('Num Bones', dtU16),
    dfInteger('Num Strips', dtU16),
    dfInteger('Num Weights Per Vertex', dtU16),
    dfArray('Bones', dfInteger('Bones', dtU16), 0, 'Num Bones', []),
    wbBool('Has Vertex Map', [DF_OnGetEnabled, @EnSince10100]),
    dfArray('Vertex Map', dfInteger('Vertex Map', dtU16), 0, 'Num Vertices', [DF_OnGetEnabled, @wbSkinPartition_EnVertexMap]),
    wbBool('Has Vertex Weights', [DF_OnGetEnabled, @EnSince10100]),
    dfArray('Vertex Weights',
      dfArray('Vertex Weights', dfFloat('Vertex Weights'), 0, '..\Num Weights Per Vertex', []),
      0, 'Num Vertices', [DF_OnGetEnabled, @wbSkinPartition_EnVertexWeights]),
    dfArray('Strip Lengths', dfInteger('Strip Lengths', dtU16), 0, 'Num Strips', []),
    wbBool('Has Faces', [DF_OnGetEnabled, @EnSince10100]),
    dfArray('Strips',
      dfArray('Strips', dfInteger('Points', dtU16), 0, '', [
        DF_OnGetCount, @wbSkinPartition_GetCountStrips,
        DF_OnSetCount, @wbSkinPartition_SetCountStrips
      ]),
      0, 'Num Strips', [DF_OnGetEnabled, @wbSkinPartition_EnStrips]),
    dfArray('Triangles', wbTriangle('Triangles'), 0, 'Num Triangles', [DF_OnGetEnabled, @wbSkinPartition_EnTriangles]),
    wbBool('Has Bone Indices'),
    dfArray('Bone Indices',
      dfArray('Bone Indices', dfInteger('Bone Indices', dtU8), 0, '..\Num Weights Per Vertex', []),
      0, 'Num Vertices', [DF_OnGetEnabled, @wbSkinPartition_EnBoneIndices]),
    dfInteger('Unknown Short', dtU16, [DF_OnGetEnabled, @wbSkinPartition_EnUnknownShort]),
    wbVertexDesc('VertexDesc', [DF_OnGetEnabled, @EnSSE]),
    dfArray('Triangles Copy', wbTriangle('Triangles Copy'), 0, 'Num Triangles', [DF_OnGetEnabled, @EnSSE])
  ], aEvents);
end;

function wbbhkPositionConstraintMotor(const aName: string; const aEvents: array of const): TdfDef;
begin
  Result := dfStruct(aName, [
    dfFloat('Min Force', '-1000000.0'),
    dfFloat('Max Force', '1000000.0'),
    dfFloat('Tau', '0.8'),
    dfFloat('Damping', '1.0'),
    dfFloat('Proportional Recovery Velocity', '2.0'),
    dfFloat('Constant Recovery Velocity', '1.0'),
    wbBool('Motor Enabled')
  ], aEvents);
end;

function wbbhkVelocityConstraintMotor(const aName: string; const aEvents: array of const): TdfDef;
begin
  Result := dfStruct(aName, [
    dfFloat('Min Force', '-1000000.0'),
    dfFloat('Max Force', '1000000.0'),
    dfFloat('Tau'),
    dfFloat('Target Velocity'),
    wbBool('Use Velocity Target'),
    wbBool('Motor Enabled')
  ], aEvents);
end;

function wbbhkSpringDamperConstraintMotor(const aName: string; const aEvents: array of const): TdfDef;
begin
  Result := dfStruct(aName, [
    dfFloat('Min Force', '-1000000.0'),
    dfFloat('Max Force', '1000000.0'),
    dfFloat('Spring Constant'),
    dfFloat('Spring Damping'),
    wbBool('Motor Enabled')
  ], aEvents);
end;

function wbMotorDescriptor_EnType1(const e: TdfElement): Boolean; begin Result := e.NativeValues['..\Type'] = 1; end;
function wbMotorDescriptor_EnType2(const e: TdfElement): Boolean; begin Result := e.NativeValues['..\Type'] = 2; end;
function wbMotorDescriptor_EnType3(const e: TdfElement): Boolean; begin Result := e.NativeValues['..\Type'] = 3; end;

function wbMotorDescriptor(const aName: string; const aEvents: array of const): TdfDef;
begin
  Result := dfStruct(aName, [
    wbMotorType('Type', 'MOTOR_NONE', []),
    wbbhkPositionConstraintMotor('Position Motor', [DF_OnGetEnabled, @wbMotorDescriptor_EnType1]),
    wbbhkVelocityConstraintMotor('Velocity Motor', [DF_OnGetEnabled, @wbMotorDescriptor_EnType2]),
    wbbhkSpringDamperConstraintMotor('Spring Damper Motor', [DF_OnGetEnabled, @wbMotorDescriptor_EnType3])
  ], aEvents);
end;

function wbBallAndSocketDescriptor(const aName: string; const aEvents: array of const): TdfDef;
begin
  Result := dfStruct(aName, [
    wbVector4('Pivot A'),
    wbVector4('Pivot B')
  ], aEvents);
end;

function wbStiffSpringDescriptor(const aName: string; const aEvents: array of const): TdfDef;
begin
  Result := dfStruct(aName, [
    wbVector4('Pivot A'),
    wbVector4('Pivot B'),
    dfFloat('Length')
  ], aEvents);
end;

function wbRagdollDescriptor_En1(const e: TdfElement): Boolean; begin with nif(e) do Result := (Version <= v20005) or ((Version >= v20207) and (UserVersion2 = 16)); end;
function wbRagdollDescriptor_En2(const e: TdfElement): Boolean; begin with nif(e) do Result := (Version >= v20207) and (UserVersion2 > 16); end;

function wbRagdollDescriptor(const aName: string; const aEvents: array of const): TdfDef;
begin
  Result := dfStruct(aName, [
    wbVector4('Pivot A', [DF_OnGetEnabled, @wbRagdollDescriptor_En1]),
    wbVector4('Plane A', [DF_OnGetEnabled, @wbRagdollDescriptor_En1]),
    wbVector4('Twist A', [DF_OnGetEnabled, @wbRagdollDescriptor_En1]),
    wbVector4('Pivot B', [DF_OnGetEnabled, @wbRagdollDescriptor_En1]),
    wbVector4('Plane B', [DF_OnGetEnabled, @wbRagdollDescriptor_En1]),
    wbVector4('Twist B', [DF_OnGetEnabled, @wbRagdollDescriptor_En1]),
    wbVector4('Twist A', [DF_OnGetEnabled, @wbRagdollDescriptor_En2]),
    wbVector4('Plane A', [DF_OnGetEnabled, @wbRagdollDescriptor_En2]),
    wbVector4('Motor A', [DF_OnGetEnabled, @wbRagdollDescriptor_En2]),
    wbVector4('Pivot A', [DF_OnGetEnabled, @wbRagdollDescriptor_En2]),
    wbVector4('Twist B', [DF_OnGetEnabled, @wbRagdollDescriptor_En2]),
    wbVector4('Plane B', [DF_OnGetEnabled, @wbRagdollDescriptor_En2]),
    wbVector4('Motor B', [DF_OnGetEnabled, @wbRagdollDescriptor_En2]),
    wbVector4('Pivot B', [DF_OnGetEnabled, @wbRagdollDescriptor_En2]),
    dfFloat('Cone Max Angle'),
    dfFloat('Plane Min Angle'),
    dfFloat('Plane Max Angle'),
    dfFloat('Twist Min Angle'),
    dfFloat('Twist Max Angle'),
    dfFloat('Max Friction'),
    wbMotorDescriptor('Motor', [DF_OnGetEnabled, @wbRagdollDescriptor_En2])
  ], aEvents);
end;

function wbHingeDescriptor(const aName: string; const aEvents: array of const): TdfDef;
begin
  Result := dfStruct(aName, [
    wbVector4('Pivot A', [DF_OnGetEnabled, @EnBefore20005]),
    wbVector4('Perp2 Axle In A1', [DF_OnGetEnabled, @EnBefore20005]),
    wbVector4('Perp2 Axle In A2', [DF_OnGetEnabled, @EnBefore20005]),
    wbVector4('Pivot B', [DF_OnGetEnabled, @EnBefore20005]),
    wbVector4('Axle B', [DF_OnGetEnabled, @EnBefore20005]),
    wbVector4('Axle A', [DF_OnGetEnabled, @EnSince20207]),
    wbVector4('Perp2 Axle In A1', [DF_OnGetEnabled, @EnSince20207]),
    wbVector4('Perp2 Axle In A2', [DF_OnGetEnabled, @EnSince20207]),
    wbVector4('Pivot A', [DF_OnGetEnabled, @EnSince20207]),
    wbVector4('Axle B', [DF_OnGetEnabled, @EnSince20207]),
    wbVector4('Perp2 Axle In B1', [DF_OnGetEnabled, @EnSince20207]),
    wbVector4('Perp2 Axle In B2', [DF_OnGetEnabled, @EnSince20207]),
    wbVector4('Pivot B', [DF_OnGetEnabled, @EnSince20207])
  ], aEvents);
end;

function wbLimitedHingeDescriptor_En1(const e: TdfElement): Boolean; begin with nif(e) do Result := (Version <= v20005) or ((Version >= v20207) and (UserVersion2 = 16)); end;
function wbLimitedHingeDescriptor_En2(const e: TdfElement): Boolean; begin with nif(e) do Result := (Version >= v20207) and (UserVersion2 > 16); end;

function wbLimitedHingeDescriptor(const aName: string; const aEvents: array of const): TdfDef;
begin
  Result := dfStruct(aName, [
    wbVector4('Pivot A', [DF_OnGetEnabled, @wbLimitedHingeDescriptor_En1]),
    wbVector4('Axle A', [DF_OnGetEnabled, @wbLimitedHingeDescriptor_En1]),
    wbVector4('Perp2 Axle In A1', [DF_OnGetEnabled, @wbLimitedHingeDescriptor_En1]),
    wbVector4('Perp2 Axle In A2', [DF_OnGetEnabled, @wbLimitedHingeDescriptor_En1]),
    wbVector4('Pivot B', [DF_OnGetEnabled, @wbLimitedHingeDescriptor_En1]),
    wbVector4('Axle B', [DF_OnGetEnabled, @wbLimitedHingeDescriptor_En1]),
    wbVector4('Perp2 Axle In B2', [DF_OnGetEnabled, @wbLimitedHingeDescriptor_En1]),
    wbVector4('Axle A', [DF_OnGetEnabled, @wbLimitedHingeDescriptor_En2]),
    wbVector4('Perp2 Axle In A1', [DF_OnGetEnabled, @wbLimitedHingeDescriptor_En2]),
    wbVector4('Perp2 Axle In A2', [DF_OnGetEnabled, @wbLimitedHingeDescriptor_En2]),
    wbVector4('Pivot A', [DF_OnGetEnabled, @wbLimitedHingeDescriptor_En2]),
    wbVector4('Axle B', [DF_OnGetEnabled, @wbLimitedHingeDescriptor_En2]),
    wbVector4('Perp2 Axle In B1', [DF_OnGetEnabled, @wbLimitedHingeDescriptor_En2]),
    wbVector4('Perp2 Axle In B2', [DF_OnGetEnabled, @wbLimitedHingeDescriptor_En2]),
    wbVector4('Pivot B', [DF_OnGetEnabled, @wbLimitedHingeDescriptor_En2]),
    dfFloat('Min Angle'),
    dfFloat('Max Angle'),
    dfFloat('Max Friction'),
    wbMotorDescriptor('Motor', [DF_OnGetEnabled, @wbLimitedHingeDescriptor_En2])
  ], aEvents);
end;

function wbPrismaticDescriptor_En2(const e: TdfElement): Boolean; begin with nif(e) do Result := (Version >= v20207) and (UserVersion2 > 16); end;

function wbPrismaticDescriptor(const aName: string; const aEvents: array of const): TdfDef;
begin
  Result := dfStruct(aName, [
    // TES4
    wbVector4('Pivot A', [DF_OnGetEnabled, @EnBefore20005]),
    wbVector4('Rotation A', [DF_OnGetEnabled, @EnBefore20005]),
    wbVector4('Plane A', [DF_OnGetEnabled, @EnBefore20005]),
    wbVector4('Sliding A', [DF_OnGetEnabled, @EnBefore20005]),
    wbVector4('Pivot B', [DF_OnGetEnabled, @EnBefore20005]),
    wbVector4('Rotation B', [DF_OnGetEnabled, @EnBefore20005]),
    wbVector4('Plane B', [DF_OnGetEnabled, @EnBefore20005]),
    wbVector4('Sliding B', [DF_OnGetEnabled, @EnBefore20005]),
    // FO3+
    wbVector4('Sliding A', [DF_OnGetEnabled, @EnSince20207]),
    wbVector4('Rotation A', [DF_OnGetEnabled, @EnSince20207]),
    wbVector4('Plane A', [DF_OnGetEnabled, @EnSince20207]),
    wbVector4('Pivot A', [DF_OnGetEnabled, @EnSince20207]),
    wbVector4('Sliding B', [DF_OnGetEnabled, @EnSince20207]),
    wbVector4('Rotation B', [DF_OnGetEnabled, @EnSince20207]),
    wbVector4('Plane B', [DF_OnGetEnabled, @EnSince20207]),
    wbVector4('Pivot B', [DF_OnGetEnabled, @EnSince20207]),
    dfFloat('Min Distance'),
    dfFloat('Max Distance'),
    dfFloat('Friction'),
    wbMotorDescriptor('Motor', [DF_OnGetEnabled, @wbPrismaticDescriptor_En2])
  ], aEvents);
end;

function wbMalleableDescriptor_EnType0(const e: TdfElement): Boolean; begin Result := e.NativeValues['..\Type'] = 0; end;
function wbMalleableDescriptor_EnType1(const e: TdfElement): Boolean; begin Result := e.NativeValues['..\Type'] = 1; end;
function wbMalleableDescriptor_EnType2(const e: TdfElement): Boolean; begin Result := e.NativeValues['..\Type'] = 2; end;
function wbMalleableDescriptor_EnType6(const e: TdfElement): Boolean; begin Result := e.NativeValues['..\Type'] = 6; end;
function wbMalleableDescriptor_EnType7(const e: TdfElement): Boolean; begin Result := e.NativeValues['..\Type'] = 7; end;
function wbMalleableDescriptor_EnType8(const e: TdfElement): Boolean; begin Result := e.NativeValues['..\Type'] = 8; end;

function wbMalleableDescriptor(const aName: string; const aEvents: array of const): TdfDef;
begin
  Result := dfStruct(aName, [
    wbhkConstraintType('Type', '', []),
    dfArray('Entities', wbNiPtr('Entities', 'bhkEntity'), -4, '', [DF_OnBeforeSave, @RemoveNoneLinks]),
    dfInteger('Priority', dtU32, '1'),
    wbBallAndSocketDescriptor('Ball and Socket', [DF_OnGetEnabled, @wbMalleableDescriptor_EnType0]),
    wbHingeDescriptor('Hinge', [DF_OnGetEnabled, @wbMalleableDescriptor_EnType1]),
    wbLimitedHingeDescriptor('Limited Hinge', [DF_OnGetEnabled, @wbMalleableDescriptor_EnType2]),
    wbPrismaticDescriptor('Prismatic', [DF_OnGetEnabled, @wbMalleableDescriptor_EnType6]),
    wbRagdollDescriptor('Ragdoll', [DF_OnGetEnabled, @wbMalleableDescriptor_EnType7]),
    wbStiffSpringDescriptor('Stiff Spring', [DF_OnGetEnabled, @wbMalleableDescriptor_EnType8]),
    dfFloat('Tau', [DF_OnGetEnabled, @EnBefore20005]),
    dfFloat('Damping', [DF_OnGetEnabled, @EnBefore20005]),
    dfFloat('Strength', [DF_OnGetEnabled, @EnSince20207])
  ], aEvents);
end;

function wbConstraintData_EnType0(const e: TdfElement): Boolean; begin Result := e.NativeValues['..\Type'] = 0; end;
function wbConstraintData_EnType1(const e: TdfElement): Boolean; begin Result := e.NativeValues['..\Type'] = 1; end;
function wbConstraintData_EnType2(const e: TdfElement): Boolean; begin Result := e.NativeValues['..\Type'] = 2; end;
function wbConstraintData_EnType6(const e: TdfElement): Boolean; begin Result := e.NativeValues['..\Type'] = 6; end;
function wbConstraintData_EnType7(const e: TdfElement): Boolean; begin Result := e.NativeValues['..\Type'] = 7; end;
function wbConstraintData_EnType8(const e: TdfElement): Boolean; begin Result := e.NativeValues['..\Type'] = 8; end;
function wbConstraintData_EnType13(const e: TdfElement): Boolean; begin Result := e.NativeValues['..\Type'] = 13; end;

function wbConstraintData(const aName: string; const aEvents: array of const): TdfDef;
begin
  Result := dfStruct(aName, [
    wbhkConstraintType('Type', '', []),
    dfArray('Entities', wbNiPtr('Entities', 'bhkEntity'), -4, '', [DF_OnBeforeSave, @RemoveNoneLinks]),
    dfInteger('Priority', dtU32, '1'),
    wbBallAndSocketDescriptor('Ball and Socket', [DF_OnGetEnabled, @wbConstraintData_EnType0]),
    wbHingeDescriptor('Hinge', [DF_OnGetEnabled, @wbConstraintData_EnType1]),
    wbLimitedHingeDescriptor('Limited Hinge', [DF_OnGetEnabled, @wbConstraintData_EnType2]),
    wbPrismaticDescriptor('Prismatic', [DF_OnGetEnabled, @wbConstraintData_EnType6]),
    wbRagdollDescriptor('Ragdoll', [DF_OnGetEnabled, @wbConstraintData_EnType7]),
    wbStiffSpringDescriptor('Stiff Spring', [DF_OnGetEnabled, @wbConstraintData_EnType8]),
    wbMalleableDescriptor('Ragdoll', [DF_OnGetEnabled, @wbConstraintData_EnType13])
  ], aEvents);
end;



//===========================================================================
{ Basic NIF data structures: NIF, Header, Footer }

function NiHeader_EnSince20004(const e: TdfElement): Boolean; begin Result := e.NativeValues['..\Version'] >= v20004; end;
function NiHeader_EnSince10018(const e: TdfElement): Boolean; begin Result := e.NativeValues['..\Version'] >= v10018; end;
function NiHeader_EnSince5001(const e: TdfElement): Boolean; begin Result := e.NativeValues['..\Version'] >= v5001; end;

function NiHeader_EnUserVersion2(const e: TdfElement): Boolean;
var
  Version, UserVersion: Cardinal;
begin
  Version := e.NativeValues['..\Version'];
  UserVersion := e.NativeValues['..\User Version'];
  Result := (Version >= v10010) and ((UserVersion >= 10) or ((UserVersion = 1) and (Version <> v10200)));
end;

function NiHeader_EnExportInfo(const e: TdfElement): Boolean; begin Result := (e.NativeValues['..\Version'] >= v10010) and (e.NativeValues['..\User Version'] >= 3); end;
function NiHeader_EnBefore10012(const e: TdfElement): Boolean; begin Result := e.NativeValues['..\..\Version'] <= v10012; end;
function NiHeader_EnMaxFilepath(const e: TdfElement): Boolean; begin Result := (e.NativeValues['..\Version'] = v20207) and (e.NativeValues['..\User Version 2'] = 130); end;
function NiHeader_EnSince20207(const e: TdfElement): Boolean; begin Result := e.NativeValues['..\Version'] >= v20207; end;
function NiHeader_EnSince20103(const e: TdfElement): Boolean; begin Result := e.NativeValues['..\Version'] >= v20103; end;
procedure NiHeader_GetTextVersion(const e: TdfElement; var aText: string); begin aText := wbIntToNifVersion(e.NativeValue); end;
procedure NiHeader_SetTextVersion(const e: TdfElement; var aText: string); begin aText := IntToStr(wbNifVersionToInt(aText)); end;

procedure NiHeader_GetTextBlockType(const e: TdfElement; var aText: string);
var
  BlockTypes: TdfElement;
  i: Integer;
begin
  BlockTypes := e.Elements['..\..\Block Types'];
  i := StrToInt(aText);
  if Assigned(BlockTypes) and (i >= 0) and (i < BlockTypes.Count) then
    aText := BlockTypes[i].EditValue
  else
    e.DoException('Invalid block type index ' + aText);
end;

procedure NiHeader_SetTextBlockType(const e: TdfElement; var aText: string);
var
  BlockTypes: TdfElement;
  i: integer;
begin
  BlockTypes := e.Elements['..\..\Block Types'];
  if Assigned(BlockTypes) then
    for i := 0 to Pred(BlockTypes.Count) do
      if BlockTypes[i].EditValue = aText then begin
        aText := IntToStr(i);
        Exit;
      end;
  e.DoException('Block type not found in NiHeader: ' + aText);
end;

procedure NiHeader_AfterLoad(const e: TdfElement; const aDataStart: Pointer; aDataSize: Integer); begin nif(e).UpdateNifVersion; end;

procedure wbDefineNifHeaderFooter;
begin
  { NIF File }
  wbNiObject(TdfStructDef.Create('NIF', dtStruct, []));

  { NiHeader }
  wbNiObject(wbNifBlock('NiHeader', [
    dfChars('Magic', 0, sNifMagicGamebryo + '20.2.0.7', #$0A, True, []),
    dfInteger('Version', dtU32, '20.2.0.7', [
        DF_OnGetText, @NiHeader_GetTextVersion,
        DF_OnSetText, @NiHeader_SetTextVersion
    ]),
    dfEnum('Endian Type', dtU8, [
      0, 'ENDIAN_BIG',
      1, 'ENDIAN_LITTLE'
    ], 'ENDIAN_LITTLE', [DF_OnGetEnabled, @NiHeader_EnSince20004]),
    dfInteger('User Version', dtU32, '12', [DF_OnGetEnabled, @NiHeader_EnSince10018]),
    dfInteger('Num Blocks', dtU32),
    // BSStreamHeader
    dfInteger('User Version 2', dtU32, '83', [DF_OnGetEnabled, @NiHeader_EnUserVersion2]),
    dfStruct('Export Info', [
      dfInteger('Unknown Int', dtU32, '3', [DF_OnGetEnabled, @NiHeader_EnBefore10012]),
      wbShortString('Author'),
      wbShortString('Process Script'),
      wbShortString('Export Script')
    ], [DF_OnGetEnabled, @NiHeader_EnExportInfo]),
    wbShortString('Max Filepath', [DF_OnGetEnabled, @NiHeader_EnMaxFilepath]),
    // BSStreamHeader
    dfArray('Block Types', wbSizedString('Type'), -2, '', [DF_OnGetEnabled, @NiHeader_EnSince5001]),
    dfArray(
      'Block Type Index',
      dfInteger('Block', dtU16, [
        DF_OnGetText, @NiHeader_GetTextBlockType,
        DF_OnSetText, @NiHeader_SetTextBlockType
      ]),
      0, 'Num Blocks',
      [DF_OnGetEnabled, @NiHeader_EnSince5001]
    ),
    dfArray('Block Size', dfInteger('Size', dtU32), 0, 'Num Blocks', [DF_OnGetEnabled, @NiHeader_EnSince20207]),
    dfInteger('Num Strings', dtU32, [DF_OnGetEnabled, @NiHeader_EnSince20103]),
    dfInteger('Max String Length', dtU32, [DF_OnGetEnabled, @NiHeader_EnSince20103]),
    dfArray('Strings', wbSizedString('String'), 0, 'Num Strings', [DF_OnGetEnabled, @NiHeader_EnSince20103]),
    dfInteger('Num Groups', dtU32, [DF_OnGetEnabled, @NiHeader_EnSince5001])
  ], [DF_OnAfterLoad, @NiHeader_AfterLoad]));

  { NiFooter }
  wbNiObject(wbNifBlock('NiFooter', [
    dfArray('Roots', wbNiRef('Roots', 'NiObject'), -4, '', [DF_OnBeforeSave, @RemoveNoneLinks])
  ]));
end;


//===========================================================================
{ NiObject }
procedure wbDefineNiObject;
begin
  wbNiObject(wbNifBlock('NiObject'), '', True);
end;

//===========================================================================
{ NiObjectNET }
procedure wbDefineNiObjectNET;
begin
  wbNiObject(wbNifBlock('NiObjectNET', [
    wbString('Name'),
    wbNiRef('Extra Data', 'NiExtraData', [DF_OnGetEnabled, @EnBefore4220]),
    dfArray('Extra Data List', wbNiRef('Extra Data List', 'NiExtraData'), -4, '', [
      DF_OnGetEnabled, @EnSince10010,
      DF_OnBeforeSave, @RemoveNoneLinks
    ]),
    wbNiRef('Controller', 'NiTimeController')
  ]), 'NiObject', True);
end;

//===========================================================================
{ NiAVObject }
function NiAVObject_DecideFlags(const e: TdfElement): Integer; begin if nif(e).UserVersion2 > 26 then Result := 1 else Result := 0; end;
function NiAVObject_EnProperties(const e: TdfElement): Boolean; begin Result := nif(e).UserVersion2 <= 34; end;
function NiAVObject_EnBoundingVolume(const e: TdfElement): Boolean; begin Result := (nif(e).Version <= v4220) and (e.NativeValues['..\Has Bounding Volume'] <> 0); end;

procedure wbDefineNiAVObject;
begin
  wbNiObject(wbNifBlock('NiAVObject', [
    dfUnion([
      dfInteger('Flags', dtU16),
      dfInteger('Flags', dtU32, '14')
    ], [DF_OnDecide, @NiAVObject_DecideFlags]),
    wbMTransform('Transform'),
    wbVector3('Velocity', [DF_OnGetEnabled, @EnBefore4220]),
    dfArray('Properties', wbNiRef('Properties', 'NiProperty'), -4, '', [
      DF_OnGetEnabled, @NiAVObject_EnProperties,
      DF_OnBeforeSave, @RemoveNoneLinks
    ]),
    wbBool('Has Bounding Volume', [DF_OnGetEnabled, @EnBefore4220]),
    wbBoundingVolume('Bounding Volume', [DF_OnGetEnabled, @NiAVObject_EnBoundingVolume]),
    wbNiRef('Collision Object', 'NiCollisionObject', [DF_OnGetEnabled, @EnSince10010])
  ]), 'NiObjectNET', True);
end;

//===========================================================================
{ NiAVObjectPalette }
procedure wbDefineNiAVObjectPalette;
begin
  wbNiObject(wbNifBlock('NiAVObjectPalette'), 'NiObject', True);
end;

//===========================================================================
{ NiDefaultAVObjectPalette }
procedure wbDefineDefaultNiAVObjectPalette;
begin
  wbNiObject(wbNifBlock('NiDefaultAVObjectPalette', [
    wbNiPtr('Scene', 'NiObject'),
    dfArray('Objects', dfStruct('Object', [
      wbSizedString('Name'),
      wbNiPtr('AV Object', 'NiAVObject')
    ]), -4)
  ]), 'NiAVObjectPalette', False);
end;

//===========================================================================
{ NiPalette * }
procedure NiPalette_SetNumEntries(const e: TdfElement; var aValue: Variant);
begin
  if (aValue <> 16) and (aValue <> 256) then
    e.DoException('Can be 16 or 256 only');
end;

procedure wbDefineNiPalette;
begin
  wbNiObject(wbNifBlock('NiPalette', [
    dfInteger('Has Alpha', dtU8),
    dfInteger('Num Entries', dtU32, '256', [DF_OnSetValue, @NiPalette_SetNumEntries]),
    dfArray('Palette', wbByteColor4('Palette'), 0, 'Num Entries', [])
  ]), 'NiObject', False);
end;

//===========================================================================
{ NiStringPalette }
procedure wbDefineNiStringPalette;
begin
  wbNiObject(wbNifBlock('NiStringPalette', [
    wbSizedString('Palette'),
    dfInteger('Length', dtU32)
  ]), 'NiObject', False);
end;

//===========================================================================
{ NiSequenceStreamHelper }
procedure wbDefineNiSequenceStreamHelper;
begin
  wbNiObject(wbNifBlock('NiSequenceStreamHelper'), 'NiObjectNET', False);
end;

//===========================================================================
{ NiNode }
function NiNode_EnEffects(const e: TdfElement): Boolean; begin Result := nif(e).UserVersion2 < 130; end;

procedure wbDefineNiNode;
begin
  wbNiObject(wbNifBlock('NiNode', [
    dfArray('Children', wbNiRef('Children', 'NiAVObject'), -4, '', [DF_OnBeforeSave, @RemoveNoneLinks]),
    dfArray('Effects', wbNiRef('Effects', 'NiDynamicEffect'), -4, '', [
      DF_OnGetEnabled, @NiNode_EnEffects,
      DF_OnBeforeSave, @RemoveNoneLinks
    ])
  ]), 'NiAVObject', False);
end;

//===========================================================================
{ NiBillboardNode }
procedure wbDefineNiBillboardNode;
begin
  wbNiObject(wbNifBlock('NiBillboardNode', [
    wbBillboardMode('Billboard Mode', '', [DF_OnGetEnabled, @EnSince10100])
  ]), 'NiNode', False);
end;

//===========================================================================
{ NiBone * }
procedure wbDefineNiBone;
begin
  wbNiObject(wbNifBlock('NiBone'), 'NiNode', False);
end;

//===========================================================================
{ NiAccumulator * }
procedure wbDefineNiAccumulator;
begin
  wbNiObject(wbNifBlock('NiAccumulator'), 'NiObject', True);
end;

//===========================================================================
{ NiSortAdjustNode * }
procedure wbDefineNiSortAdjustNode;
begin
  wbNiObject(wbNifBlock('NiSortAdjustNode', [
    dfEnum('Sorting Mode', dtU32, [
      0, 'SORTING_INHERIT',
      1, 'SORTING_OFF'
    ], 'SORTING_INHERIT', []),
    wbNiRef('Accumulator', 'NiAccumulator', [DF_OnGetEnabled, @EnBefore10200])
  ]), 'NiNode', False);
end;

//===========================================================================
{ NiBSAnimationNode }
procedure wbDefineNiBSAnimationNode;
begin
  wbNiObject(wbNifBlock('NiBSAnimationNode'), 'NiNode', False);
end;

//===========================================================================
{ NiBSParticleNode }
procedure wbDefineNiBSParticleNode;
begin
  wbNiObject(wbNifBlock('NiBSParticleNode'), 'NiNode', False);
end;

//===========================================================================
{ RootCollisionNode }
procedure wbDefineRootCollisionNode;
begin
  wbNiObject(wbNifBlock('RootCollisionNode'), 'NiNode', False);
end;

//===========================================================================
{ AvoidNode }
procedure wbDefineAvoidNode;
begin
  wbNiObject(wbNifBlock('AvoidNode'), 'NiNode', False);
end;

//===========================================================================
{ BSFadeNode }
procedure wbDefineBSFadeNode;
begin
  wbNiObject(wbNifBlock('BSFadeNode'), 'NiNode', False);
end;

//===========================================================================
{ BSLeafAnimNode }
procedure wbDefineBSLeafAnimNode;
begin
  wbNiObject(wbNifBlock('BSLeafAnimNode'), 'NiNode', False);
end;

//===========================================================================
{ BSTreeNode }
procedure wbDefineBSTreeNode;
begin
  wbNiObject(wbNifBlock('BSTreeNode', [
    dfArray('Bones 1', wbNiRef('Bones 1', 'NiNode'), -4, '', [DF_OnBeforeSave, @RemoveNoneLinks]),
    dfArray('Bones', wbNiRef('Bones', 'NiNode'), -4, '', [DF_OnBeforeSave, @RemoveNoneLinks])
  ]), 'NiNode', False);
end;

//===========================================================================
{ BSOrderedNode }
procedure wbDefineBSOrderedNode;
begin
  wbNiObject(wbNifBlock('BSOrderedNode', [
    wbVector4('Alpha Sort Bound'),
    wbBool('Static Bound')
  ]), 'NiNode', False);
end;

//===========================================================================
{ BSRangeNode }
procedure wbDefineBSRangeNode;
begin
  wbNiObject(wbNifBlock('BSRangeNode', [
    dfInteger('Min', dtU8),
    dfInteger('Max', dtU8),
    dfInteger('Current', dtU8)
  ]), 'NiNode', False);
end;

//===========================================================================
{ BSBlastNode }
procedure wbDefineBSBlastNode;
begin
  wbNiObject(wbNifBlock('BSBlastNode'), 'BSRangeNode', False);
end;

//===========================================================================
{ BSDamageStage }
procedure wbDefineBSDamageStage;
begin
  wbNiObject(wbNifBlock('BSDamageStage'), 'BSBlastNode', False);
end;

//===========================================================================
{ BSDebrisNode }
procedure wbDefineBSDebrisNode;
begin
  wbNiObject(wbNifBlock('BSDebrisNode'), 'BSRangeNode', False);
end;

//===========================================================================
{ BSValueNode }
procedure wbDefineBSValueNode;
begin
  wbNiObject(wbNifBlock('BSValueNode', [
    dfInteger('Value', dtU32),
    dfFlags('Value Node Flags', dtU8, [
      0, 'BillboardWorldZ',
      1, 'UsePlayerAdjust'
    ])
  ]), 'NiNode', False);
end;

//===========================================================================
{ BSMultiBoundNode }
function BSMultiBoundNode_EnCullingNode(const e: TdfElement): Boolean; begin Result := nif(e).UserVersion2 >= 83; end;

procedure wbDefineBSMultiBoundNode;
begin
  wbNiObject(wbNifBlock('BSMultiBoundNode', [
    wbNiRef('Multi Bound', 'BSMultiBound'),
    wbBSCPCullingType('Culling Node', '', [DF_OnGetEnabled, @BSMultiBoundNode_EnCullingNode])
  ]), 'NiNode', False);
end;

//===========================================================================
{ BSMultiBound }
procedure wbDefineBSMultiBound;
begin
  wbNiObject(wbNifBlock('BSMultiBound', [
    wbNiRef('Data', 'BSMultiBoundData')
  ]), 'NiObject', False);
end;

//===========================================================================
{ BSMultiBoundData }
procedure wbDefineBSMultiBoundData;
begin
  wbNiObject(wbNifBlock('BSMultiBoundData'), 'NiObject', True);
end;

//===========================================================================
{ BSMultiBoundAABB }
procedure wbDefineBSMultiBoundAABB;
begin
  wbNiObject(wbNifBlock('BSMultiBoundAABB', [
    wbVector3('Position'),
    wbVector3('Extent')
  ]), 'BSMultiBoundData', False);
end;

//===========================================================================
{ BSMultiBoundOBB }
procedure wbDefineBSMultiBoundOBB;
begin
  wbNiObject(wbNifBlock('BSMultiBoundOBB', [
    wbVector3('Center'),
    wbVector3('Size'),
    wbRotMatrix33('Rotation')
  ]), 'BSMultiBoundData', False);
end;

//===========================================================================
{ BSMultiBoundSphere }
procedure wbDefineBSMultiBoundSphere;
begin
  wbNiObject(wbNifBlock('BSMultiBoundSphere', [
    wbVector3('Center'),
    dfFloat('Radius')
  ]), 'BSMultiBoundData', False);
end;

//===========================================================================
{ NiSwitchNode }
procedure wbDefineNiSwitchNode;
begin
  wbNiObject(wbNifBlock('NiSwitchNode', [
    wbNiSwitchFlags('Flags', '', [DF_OnGetEnabled, @EnSince10100]),
    dfInteger('Index', dtU32)
  ]), 'NiNode', False);
end;

//===========================================================================
{ NiLODNode * }
function NiLODNode_EnLODCenter(const e: TdfElement): Boolean; begin with nif(e) do Result := (Version >= v4002) and (Version <= v10010); end;

procedure wbDefineNiLODNode;
begin
  wbNiObject(wbNifBlock('NiLODNode', [
    wbVector3('LOD Center', [DF_OnGetEnabled, @NiLODNode_EnLODCenter]),
    dfArray('LOD Levels', dfStruct('LOD Levels', [
      dfFloat('Near Extent'),
      dfFloat('Far Extent')
    ]), -4, '', [DF_OnGetEnabled, @EnBefore10010]),
    wbNiRef('LOD Level Data', 'NiLODData', [DF_OnGetEnabled, @EnSince10100])
  ]), 'NiSwitchNode', False);
end;

//===========================================================================
{ NiLODData * }
procedure wbDefineNiLODData;
begin
  wbNiObject(wbNifBlock('NiLODData'), 'NiObject', True);
end;

//===========================================================================
{ NiRangeLODData * }
procedure wbDefineNiRangeLODData;
begin
  wbNiObject(wbNifBlock('NiRangeLODData', [
    wbVector3('LOD Center'),
    dfArray('LOD Levels', dfStruct('LOD Levels', [
      dfFloat('Near Extent'),
      dfFloat('Far Extent')
    ]), -4)
  ]), 'NiLODData', False);
end;

//===========================================================================
{ NiScreenLODData * }
procedure wbDefineNiScreenLODData;
begin
  wbNiObject(wbNifBlock('NiScreenLODData', [
    wbNiBound('Bound'),
    wbNiBound('World Bound'),
    dfArray('Proportion Levels', dfFloat('Proportion Levels'), -4)
  ]), 'NiLODData', False);
end;

//===========================================================================
{ NiExtraData }
function NiExtraData_EnName(const e: TdfElement): Boolean; begin Result := (nif(e).Version >= v10010) and not wbIsNiObject(e, 'BSExtraData'); end;

procedure wbDefineNiExtraData;
begin
  wbNiObject(wbNifBlock('NiExtraData', [
    wbString('Name', [DF_OnGetEnabled, @NiExtraData_EnName]),
    wbNiRef('Next Extra Data', 'NiExtraData', [DF_OnGetEnabled, @EnBefore4220])
  ]), 'NiObject', False);
end;

//===========================================================================
{ NiBinaryExtraData }
procedure wbDefineNiBinaryExtraData;
begin
  wbNiObject(wbNifBlock('NiBinaryExtraData', [
    wbByteArray('Data')
  ]), 'NiExtraData', False);
end;

//===========================================================================
{ NiBooleanExtraData }
procedure wbDefineNiBooleanExtraData;
begin
  wbNiObject(wbNifBlock('NiBooleanExtraData', [
    dfInteger('Boolean Data', dtU8)
  ]), 'NiExtraData', False);
end;

//===========================================================================
{ NiColorExtraData * }
procedure wbDefineNiColorExtraData;
begin
  wbNiObject(wbNifBlock('NiColorExtraData', [
    wbColor4('Color Data')
  ]), 'NiExtraData', False);
end;

//===========================================================================
{ NiFloatExtraData }
procedure wbDefineNiFloatExtraData;
begin
  wbNiObject(wbNifBlock('NiFloatExtraData', [
    dfFloat('Float Data')
  ]), 'NiExtraData', False);
end;

//===========================================================================
{ NiFloatsExtraData }
procedure wbDefineNiFloatsExtraData;
begin
  wbNiObject(wbNifBlock('NiFloatsExtraData', [
    dfArray('Float', dfFloat('Float'), -4)
  ]), 'NiExtraData', False);
end;

//===========================================================================
{ NiIntegerExtraData }
function NiIntegerExtraData_DecideFlags(const e: TdfElement): Integer; begin if wbIsNiObject(e, 'BSXFlags') then Result := 1 else Result := 0; end;

procedure wbDefineNiIntegerExtraData;
begin
  wbNiObject(wbNifBlock('NiIntegerExtraData', [
    dfUnion(nil, [
      dfInteger('Data', dtU32),
      dfFlags('Flags', dtU32, [
        0, 'Animated',
        1, 'Havok',
        2, 'Ragdoll',
        3, 'Complex',
        4, 'Addon',
        5, 'Editor Marker',
        6, 'Dynamic',
        7, 'Articulated',
        8, 'Needs Transform Updates',
        9, 'External Emit'
      ])
    ], [DF_OnDecide, @NiIntegerExtraData_DecideFlags])
  ]), 'NiExtraData', False);
end;

//===========================================================================
{ NiIntegersExtraData }
procedure wbDefineNiIntegersExtraData;
begin
  wbNiObject(wbNifBlock('NiIntegersExtraData', [
    dfArray('Data', dfInteger('Data', dtU32), -4)
  ]), 'NiExtraData', False);
end;

//===========================================================================
{ NiStringExtraData }
procedure wbDefineNiStringExtraData;
begin
  wbNiObject(wbNifBlock('NiStringExtraData', [
    dfInteger('Bytes Remaining', dtU32, [DF_OnGetEnabled, @EnBefore4220]),
    wbString('Data')
  ]), 'NiExtraData', False);
end;

//===========================================================================
{ NiStringsExtraData }
procedure wbDefineNiStringsExtraData;
begin
  wbNiObject(wbNifBlock('NiStringsExtraData', [
    dfArray('Data', wbSizedString('Data'), -4)
  ]), 'NiExtraData', False);
end;

//===========================================================================
{ NiTextKeyExtraData }
procedure wbDefineNiTextKeyExtraData;
begin
  wbNiObject(wbNifBlock('NiTextKeyExtraData', [
    dfInteger('Unknown Int', dtU32, [DF_OnGetEnabled, @EnBefore4220]),
    dfArray('Text Keys', dfStruct('Text Keys', [
      dfFloat('Float'),
      wbString('Value')
    ]), -4, '', [])
  ]), 'NiExtraData', False);
end;

//===========================================================================
{ NiVectorExtraData * }
procedure wbDefineNiVectorExtraData;
begin
  wbNiObject(wbNifBlock('NiVectorExtraData', [
    wbVector4('Vector Data')
  ]), 'NiExtraData', False);
end;

//===========================================================================
{ NiVertWeightsExtraData }
procedure wbDefineNiVertWeightsExtraData;
begin
  wbNiObject(wbNifBlock('NiVertWeightsExtraData', [
    dfInteger('Num Bytes', dtU32),
    dfArray('Weights', dfFloat('Weights'), -2)
  ]), 'NiExtraData', False);
end;

//===========================================================================
{ BSXFlags }
procedure BSXFlags_AfterLoad(const aElement: TdfElement; const aDataStart: Pointer; aDataSize: Integer);
begin
  // Must have BSX name
  if aDataStart = nil then
    aElement.EditValues['Name'] := 'BSX';
end;

procedure wbDefineBSXFlags;
begin
  wbNiObject(wbNifBlock('BSXFlags', [], [DF_OnAfterLoad, @BSXFlags_AfterLoad]), 'NiIntegerExtraData', False);
end;

//===========================================================================
{ BSInvMarker }
procedure BSInvMarker_AfterLoad(const aElement: TdfElement; const aDataStart: Pointer; aDataSize: Integer);
begin
  // Must have INV name
  if aDataStart = nil then
    aElement.EditValues['Name'] := 'INV';
end;

procedure wbDefineBSInvMarker;
begin
  wbNiObject(wbNifBlock('BSInvMarker', [
    dfInteger('Rotation X', dtU16, '4712'),
    dfInteger('Rotation Y', dtU16, '6283'),
    dfInteger('Rotation Z', dtU16, '0'),
    dfFloat('Zoom', '1.0')
  ], [DF_OnAfterLoad, @BSInvMarker_AfterLoad]),
  'NiExtraData', False);
end;

//===========================================================================
{ BSFurnitureMarker }
function BSFurnitureMarker_EnOrientation(const e: TdfElement): Boolean; begin Result := nif(e).UserVersion2 <= 34; end;
function BSFurnitureMarker_EnHeading(const e: TdfElement): Boolean; begin Result := nif(e).UserVersion2 > 34; end;

procedure wbDefineBSFurnitureMarker;
begin
  wbNiObject(wbNifBlock('BSFurnitureMarker', [
    dfArray('Positions', dfStruct('Positions', [
      wbVector3('Offset'),
      dfInteger('Orientation', dtU16, [DF_OnGetEnabled, @BSFurnitureMarker_EnOrientation]),
      dfInteger('Position Ref 1', dtU8, [DF_OnGetEnabled, @BSFurnitureMarker_EnOrientation]),
      dfInteger('Position Ref 2', dtU8, [DF_OnGetEnabled, @BSFurnitureMarker_EnOrientation]),
      dfFloat('Heading', [DF_OnGetEnabled, @BSFurnitureMarker_EnHeading]),
      wbAnimationType('Animation Type', '', [DF_OnGetEnabled, @BSFurnitureMarker_EnHeading]),
      wbFurnitureEntryPoints('Entry Properties', '', [DF_OnGetEnabled, @BSFurnitureMarker_EnHeading])
    ]), -4)
  ]), 'NiExtraData', False);
end;

//===========================================================================
{ BSFurnitureMarkerNode }
procedure wbDefineBSFurnitureMarkerNode;
begin
  wbNiObject(wbNifBlock('BSFurnitureMarkerNode'), 'BSFurnitureMarker', False);
end;

//===========================================================================
{ BSBoneLODExtraData }
procedure wbDefineBSBoneLODExtraData;
begin
  wbNiObject(wbNifBlock('BSBoneLODExtraData', [
    dfArray('Bone LOD', dfStruct('Bone LOD', [
      dfInteger('Distance', dtU32),
      wbString('Bone Name')
    ]), -4)
  ]), 'NiExtraData', False);
end;

//===========================================================================
{ BSBound }
procedure wbDefineBSBound;
begin
  wbNiObject(wbNifBlock('BSBound', [
    wbVector3('Center'),
    wbVector3('Dimension')
  ]), 'NiExtraData', False);
end;

//===========================================================================
{ BSBehaviorGraphExtraData }
procedure BSBehaviorGraphExtraData_AfterLoad(const aElement: TdfElement; const aDataStart: Pointer; aDataSize: Integer);
begin
  // Must have BGED name
  if aDataStart = nil then
    aElement.EditValues['Name'] := 'BGED';
end;

procedure wbDefineBSBehaviorGraphExtraData;
begin
  wbNiObject(wbNifBlock('BSBehaviorGraphExtraData', [
    wbString('Behavior Graph File'),
    wbBool('Controls Base Skeleton')
  ], [DF_OnAfterLoad, @BSBehaviorGraphExtraData_AfterLoad]), 'NiExtraData', False);
end;

//===========================================================================
{ BSDecalPlacementVectorExtraData }
procedure wbDefineBSDecalPlacementVectorExtraData;
begin
  wbNiObject(wbNifBlock('BSDecalPlacementVectorExtraData', [
    dfArray('Vector Blocks', dfStruct('Vector Blocks', [
      dfInteger('Num Vectors', dtU16),
      dfArray('Points', wbVector3('Points'), 0, 'Num Vectors', []),
      dfArray('Normals', wbVector3('Points'), 0, 'Num Vectors', [])
    ]), -2)
  ]), 'NiFloatExtraData', False);
end;

//===========================================================================
{ BSDistantObjectLargeRefExtraData }
procedure wbDefineBSDistantObjectLargeRefExtraData;
begin
  wbNiObject(wbNifBlock('BSDistantObjectLargeRefExtraData', [
    wbBool('Large Ref')
  ]), 'NiExtraData', False);
end;

//===========================================================================
{ BSWArray }
procedure wbDefineBSWArray;
begin
  wbNiObject(wbNifBlock('BSWArray', [
    dfArray('Items', dfInteger('Items', dtS32), -4)
  ]), 'NiExtraData', False);
end;

//===========================================================================
{ BSExtraData }
procedure wbDefineBSExtraData;
begin
  wbNiObject(wbNifBlock('BSExtraData'), 'NiExtraData', False);
end;

//===========================================================================
{ BSClothExtraData }
procedure wbDefineBSClothExtraData;
begin
  wbNiObject(wbNifBlock('BSClothExtraData', [
    wbByteArray('Binary Data')
  ]), 'BSExtraData', False);
end;

//===========================================================================
{ BSEyeCenterExtraData }
procedure wbDefineBSEyeCenterExtraData;
begin
  wbNiObject(wbNifBlock('BSEyeCenterExtraData', [
    dfArray('Data', dfFloat('Data'), -4)
  ]), 'NiExtraData', False);
end;

//===========================================================================
{ BSPackedCombinedSharedGeomDataExtra }
procedure wbDefineBSPackedCombinedSharedGeomDataExtra;
begin
  wbNiObject(wbNifBlock('BSPackedCombinedSharedGeomDataExtra', [
    wbVertexDesc('VertexDesc', []),
    dfInteger('Num Vertices', dtU32),
    dfInteger('Num Triangles', dtU32),
    dfInteger('Unknown Flags 1', dtU32),
    dfInteger('Unknown Flags 2', dtU32),
    dfInteger('Num Data', dtU32),
    dfArray('Object', dfStruct('Object', [
      dfInteger('Unknown Int 1', dtU32),
      dfInteger('Object Hash', dtU32)
    ]), 0, 'Num Data', []),
    dfArray('Object Data', dfStruct('Object Data', [
      dfInteger('Num Verts', dtU32),
      dfArray('LOD', dfStruct('LOD', [
        dfInteger('Triangle Count', dtU32),
        dfInteger('Triangle Offset', dtU32)
      ]), -4),
      dfArray('Combined', dfStruct('Combined', [
        dfFloat('Grayscale to Palette Scale'),
        wbRotMatrix33('Rotation'),
        wbVector3('Translation'),
        dfFloat('Scale', '1.0'),
        wbNiBound('Bounding Sphere')
      ]), -4),
      wbVertexDesc('VertexDesc', [])
    ]), 0, 'Num Data', [])
  ]), 'NiExtraData', False);
end;

//===========================================================================
{ BSPackedCombinedGeomDataExtra }
function wbDefineBSPackedCombinedGeomDataExtra_EnVertexData(const e: TdfElement): Boolean;
begin
  Result := True;
  e.UserData := e.NativeValues['..\VertexDesc\VF']; // cache VF here
end;

procedure wbDefineBSPackedCombinedGeomDataExtra_GetCountTriangles(const e: TdfElement; var aCount: Integer);
var
  el: TdfElement;
  i: integer;
begin
  // sum of LOD Triangle Count
  el := e.Elements['..\LOD'];
  if Assigned(el) then
    for i := 0 to Pred(el.Count) do
      Inc(aCount, Integer(el[i][0].NativeValue));
end;

procedure wbDefineBSPackedCombinedGeomDataExtra;
begin
  wbNiObject(wbNifBlock('BSPackedCombinedGeomDataExtra', [
    wbVertexDesc('VertexDesc', []),
    dfInteger('Num Vertices', dtU32),
    dfInteger('Num Triangles', dtU32),
    dfInteger('Unknown Flags 1', dtU32),
    dfInteger('Unknown Flags 2', dtU32),
    dfInteger('Num Data', dtU32),
    dfArray('Object Data', dfStruct('Object Data', [
      dfInteger('Num Verts', dtU32),
      dfArray('LOD', dfStruct('LOD', [
        dfInteger('Triangle Count', dtU32),
        dfInteger('Triangle Offset', dtU32)
      ]), -4),
      dfArray('Combined', dfStruct('Combined', [
        dfFloat('Grayscale to Palette Scale'),
        wbRotMatrix33('Rotation'),
        wbVector3('Translation'),
        dfFloat('Scale', '1.0'),
        wbNiBound('Bounding Sphere')
      ]), -4),
      wbVertexDesc('VertexDesc', []),
      dfArray('Vertex Data', wbBSVertexData('Vertex Data'), 0, 'Num Verts', [
        DF_OnGetEnabled, @wbDefineBSPackedCombinedGeomDataExtra_EnVertexData
      ]),
      dfArray('Triangles', wbTriangle('Triangles'), 0, '', [
        DF_OnGetCount, @wbDefineBSPackedCombinedGeomDataExtra_GetCountTriangles
      ])
    ]), 0, 'Num Data', [])
  ]), 'NiExtraData', False);
end;

//===========================================================================
{ BSPositionData }
procedure wbDefineBSPositionData;
begin
  wbNiObject(wbNifBlock('BSPositionData', [
    dfArray('Data', dfFloat('Data', dtFloat16), -4)
  ]), 'NiExtraData', False);
end;

//===========================================================================
{ BSConnectPoint::Parents }
procedure BSConnectPointParents_AfterLoad(const aElement: TdfElement; const aDataStart: Pointer; aDataSize: Integer);
begin
  // Must have CPA name
  if aDataStart = nil then
    aElement.EditValues['Name'] := 'CPA';
end;

procedure wbDefineBSConnectPoint__Parents;
begin
  wbNiObject(wbNifBlock('BSConnectPoint::Parents', [
    dfArray('Connect Points', dfStruct('Connect Points', [
      wbSizedString('Parent', 'WorkshopConnectPoints', []),
      wbSizedString('Name'),
      wbQuaternion('Rotation'),
      wbVector3('Translation'),
      dfFloat('Scale', '1.0')
    ]), -4)
  ], [DF_OnAfterLoad, @BSConnectPointParents_AfterLoad]),
  'NiExtraData', False);
end;

//===========================================================================
{ BSConnectPoint::Children }
procedure wbDefineBSConnectPoint__Children;
begin
  wbNiObject(wbNifBlock('BSConnectPoint::Children', [
    wbBool('Skinned'),
    dfArray('Name', wbSizedString('Name'), -4)
  ]), 'NiExtraData', False);
end;

//===========================================================================
{ BSAnimNote }
function BSAnimNote_EnType1(const e: TdfElement): Boolean; begin Result := e.NativeValues['..\Type'] = 1; end;
function BSAnimNote_EnType2(const e: TdfElement): Boolean; begin Result := e.NativeValues['..\Type'] = 2; end;

procedure wbDefineBSAnimNote;
begin
  wbNiObject(wbNifBlock('BSAnimNote', [
    dfEnum('Type', dtU32, [
      0, 'ANT_INVALID',
      1, 'ANT_GRABIK',
      2, 'ANT_LOOKIK'
    ]),
    dfFloat('Time'),
    dfInteger('Arm', dtU32, [DF_OnGetEnabled, @BSAnimNote_EnType1]),
    dfFloat('Gain', [DF_OnGetEnabled, @BSAnimNote_EnType2]),
    dfInteger('State', dtU32, [DF_OnGetEnabled, @BSAnimNote_EnType2])
  ]), 'NiObject', False);
end;

//===========================================================================
{ BSAnimNotes }
procedure wbDefineBSAnimNotes;
begin
  wbNiObject(wbNifBlock('BSAnimNotes', [
    dfArray('Anim Notes', wbNiRef('Anim Notes', 'BSAnimNote'), -2, '', [DF_OnBeforeSave, @RemoveNoneLinks])
  ]), 'NiObject', False);
end;

//===========================================================================
{ NiProperty }
procedure wbDefineNiProperty;
begin
  wbNiObject(wbNifBlock('NiProperty'), 'NiObjectNET', True);
end;

//===========================================================================
{ NiAlphaProperty }
procedure wbDefineNiAlphaProperty;
begin
  wbNiObject(wbNifBlock('NiAlphaProperty', [
    dfInteger('Flags', dtU16, '4844'),
    dfInteger('Threshold', dtU8, '128')
  ]), 'NiProperty', False);
end;

//===========================================================================
{ NiDitherProperty }
procedure wbDefineNiDitherProperty;
begin
  wbNiObject(wbNifBlock('NiDitherProperty', [
    dfInteger('Flags', dtU16)
  ]), 'NiProperty', False);
end;

//===========================================================================
{ NiFogProperty }
procedure wbDefineNiFogProperty;
begin
  wbNiObject(wbNifBlock('NiFogProperty', [
    dfInteger('Flags', dtU16),
    dfFloat('Fog Depth', '1.0'),
    wbColor3('Fog Color')
  ]), 'NiProperty', False);
end;

//===========================================================================
{ NiMaterialProperty }
function NiMaterialProperty_EnAmbientColor(const e: TdfElement): Boolean; begin Result := nif(e).UserVersion2 < 26; end;
function NiMaterialProperty_EnEmissiveMult(const e: TdfElement): Boolean; begin Result := nif(e).UserVersion2 > 21; end;

procedure wbDefineNiMaterialProperty;
begin
  wbNiObject(wbNifBlock('NiMaterialProperty', [
    dfInteger('Flags', dtU16, [DF_OnGetEnabled, @EnBefore10012]),
    wbColor3('Ambient Color', '#FFFFFF', [DF_OnGetEnabled, @NiMaterialProperty_EnAmbientColor]),
    wbColor3('Diffuse Color', '#FFFFFF', [DF_OnGetEnabled, @NiMaterialProperty_EnAmbientColor]),
    wbColor3('Specular Color', '#FFFFFF', []),
    wbColor3('Emissive Color', '#000000', []),
    dfFloat('Glossiness', '10.0'),
    dfFloat('Alpha', '1.0'),
    dfFloat('Emissive Mult', '1.0', [DF_OnGetEnabled, @NiMaterialProperty_EnEmissiveMult])
  ]), 'NiProperty', False);
end;

//===========================================================================
{ NiShadeProperty }
function NiShadeProperty_EnFlags(const e: TdfElement): Boolean; begin Result := nif(e).UserVersion2 <= 34; end;

procedure wbDefineNiShadeProperty;
begin
  wbNiObject(wbNifBlock('NiShadeProperty', [
    dfInteger('Flags', dtU16, '1', [DF_OnGetEnabled, @NiShadeProperty_EnFlags])
  ]), 'NiProperty', False);
end;

//===========================================================================
{ NiStencilProperty }
procedure wbDefineNiStencilProperty;
begin
  wbNiObject(wbNifBlock('NiStencilProperty', [
    dfInteger('Flags', dtU16, '', [DF_OnGetEnabled, @EnBefore10012]),
    dfInteger('Stencil Enable', dtU8, [DF_OnGetEnabled, @EnBefore20005]),
    wbStencilCompareMode('Stencil Function', 'TEST_GREATER', [DF_OnGetEnabled, @EnBefore20005]),
    dfInteger('Stencil Ref', dtU32, [DF_OnGetEnabled, @EnBefore20005]),
    dfInteger('Stencil Mask', dtU32, '4294967295', [DF_OnGetEnabled, @EnBefore20005]),
    wbStencilAction('Fail Action', 'ACTION_KEEP', [DF_OnGetEnabled, @EnBefore20005]),
    wbStencilAction('Z Fail Action', 'ACTION_KEEP', [DF_OnGetEnabled, @EnBefore20005]),
    wbStencilAction('Pass Action', 'ACTION_INCREMENT', [DF_OnGetEnabled, @EnBefore20005]),
    wbStencilDrawMode('Draw Mode', 'DRAW_BOTH', [DF_OnGetEnabled, @EnBefore20005]),
    dfInteger('Flags', dtU16, '19840', [DF_OnGetEnabled, @EnSince20103]),
    dfInteger('Stencil Ref', dtU32, [DF_OnGetEnabled, @EnSince20103]),
    dfInteger('Stencil Mask', dtU32, '4294967295', [DF_OnGetEnabled, @EnSince20103])
  ]), 'NiProperty', False);
end;

//===========================================================================
{ NiSpecularProperty }
procedure wbDefineNiSpecularProperty;
begin
  wbNiObject(wbNifBlock('NiSpecularProperty', [
    dfInteger('Flags', dtU16)
  ]), 'NiProperty', False);
end;

//===========================================================================
{ NiTexturingProperty }
function NiTexturingProperty_EnFlags(const e: TdfElement): Boolean; begin with nif(e) do Result := (Version <= v10012) or (Version >= v20103); end;
function NiTexturingProperty_EnApplyMode(const e: TdfElement): Boolean; begin with nif(e) do Result := Version <= v20101; end;
function NiTexturingProperty_EnAmbientColor(const e: TdfElement): Boolean; begin with nif(e) do Result := not ((Version = v20207) and (UserVersion >= 11) and (UserVersion2 > 21)); end;
function NiTexturingProperty_EnEmitMult(const e: TdfElement): Boolean; begin with nif(e) do Result := (Version = v20207) and (UserVersion >= 11) and (UserVersion2 > 21); end;
function NiTexturingProperty_EnBaseTexture(const e: TdfElement): Boolean; begin Result := e.NativeValues['..\Has Base Texture'] <> 0; end;
function NiTexturingProperty_EnDarkTexture(const e: TdfElement): Boolean; begin Result := e.NativeValues['..\Has Dark Texture'] <> 0; end;
function NiTexturingProperty_EnDetailTexture(const e: TdfElement): Boolean; begin Result := e.NativeValues['..\Has Detail Texture'] <> 0; end;
function NiTexturingProperty_EnGlossTexture(const e: TdfElement): Boolean; begin Result := e.NativeValues['..\Has Gloss Texture'] <> 0; end;
function NiTexturingProperty_EnGlowTexture(const e: TdfElement): Boolean; begin Result := e.NativeValues['..\Has Glow Texture'] <> 0; end;
function NiTexturingProperty_EnHasBumpMapTexture(const e: TdfElement): Boolean; begin with nif(e) do Result := e.NativeValues['..\Texture Count'] >= 6; end;
function NiTexturingProperty_EnBumpMapTexture(const e: TdfElement): Boolean; begin Result := e.NativeValues['..\Has Bump Map Texture'] <> 0; end;
function NiTexturingProperty_EnHasNormalTexture(const e: TdfElement): Boolean; begin with nif(e) do Result := (nif(e).Version >= v20205) and (e.NativeValues['..\Texture Count'] >= 7); end;
function NiTexturingProperty_EnNormalTexture(const e: TdfElement): Boolean; begin Result := e.NativeValues['..\Has Normal Texture'] <> 0; end;
function NiTexturingProperty_EnHasParallaxTexture(const e: TdfElement): Boolean; begin with nif(e) do Result := (nif(e).Version >= v20205) and (e.NativeValues['..\Texture Count'] >= 8); end;
function NiTexturingProperty_EnParallax(const e: TdfElement): Boolean; begin Result := e.NativeValues['..\Has Parallax Texture'] <> 0; end;
function NiTexturingProperty_EnHasDecal0Texture(const e: TdfElement): Boolean; begin with nif(e) do Result := ((Version < v20205) and (e.NativeValues['..\Texture Count'] >= 7)) or ((Version >= v20205) and (e.NativeValues['..\Texture Count'] >= 9)); end;
function NiTexturingProperty_EnDecal0Texture(const e: TdfElement): Boolean; begin Result := e.NativeValues['..\Has Decal 0 Texture'] <> 0; end;
function NiTexturingProperty_EnHasDecal1Texture(const e: TdfElement): Boolean; begin with nif(e) do Result := ((Version < v20205) and (e.NativeValues['..\Texture Count'] >= 8)) or ((Version >= v20205) and (e.NativeValues['..\Texture Count'] >= 10)); end;
function NiTexturingProperty_EnDecal1Texture(const e: TdfElement): Boolean; begin Result := e.NativeValues['..\Has Decal 1 Texture'] <> 0; end;
function NiTexturingProperty_EnHasDecal2Texture(const e: TdfElement): Boolean; begin with nif(e) do Result := ((Version < v20205) and (e.NativeValues['..\Texture Count'] >= 9)) or ((Version >= v20205) and (e.NativeValues['..\Texture Count'] >= 11)); end;
function NiTexturingProperty_EnDecal2Texture(const e: TdfElement): Boolean; begin Result := e.NativeValues['..\Has Decal 2 Texture'] <> 0; end;
function NiTexturingProperty_EnHasDecal3Texture(const e: TdfElement): Boolean; begin with nif(e) do Result := ((Version < v20205) and (e.NativeValues['..\Texture Count'] >= 10)) or ((Version >= v20205) and (e.NativeValues['..\Texture Count'] >= 12)); end;
function NiTexturingProperty_EnDecal3Texture(const e: TdfElement): Boolean; begin Result := e.NativeValues['..\Has Decal 3 Texture'] <> 0; end;

procedure wbDefineNiTexturingProperty;
begin
  wbNiObject(wbNifBlock('NiTexturingProperty', [
    dfInteger('Flags', dtU16, '', [DF_OnGetEnabled, @NiTexturingProperty_EnFlags]),
    wbApplyMode('Apply Mode', 'APPLY_MODULATE', [DF_OnGetEnabled, @EnBefore20005]),
    dfInteger('Texture Count', dtU32, '7'),
    wbBool('Has Base Texture'),
    wbTexDesc('Base Texture', [DF_OnGetEnabled, @NiTexturingProperty_EnBaseTexture]),
    wbBool('Has Dark Texture'),
    wbTexDesc('Dark Texture', [DF_OnGetEnabled, @NiTexturingProperty_EnDarkTexture]),
    wbBool('Has Detail Texture'),
    wbTexDesc('Detail Texture', [DF_OnGetEnabled, @NiTexturingProperty_EnDetailTexture]),
    wbBool('Has Gloss Texture'),
    wbTexDesc('Gloss Texture', [DF_OnGetEnabled, @NiTexturingProperty_EnGlossTexture]),
    wbBool('Has Glow Texture'),
    wbTexDesc('Glow Texture', [DF_OnGetEnabled, @NiTexturingProperty_EnGlowTexture]),
    wbBool('Has Bump Map Texture', [DF_OnGetEnabled, @NiTexturingProperty_EnHasBumpMapTexture]),
    wbTexDesc('Bump Map Texture', [DF_OnGetEnabled, @NiTexturingProperty_EnBumpMapTexture]),
    dfFloat('Bump Map Luma Scale', [DF_OnGetEnabled, @NiTexturingProperty_EnBumpMapTexture]),
    dfFloat('Bump Map Luma Offset', [DF_OnGetEnabled, @NiTexturingProperty_EnBumpMapTexture]),
    wbMatrix22('Bump Map Matrix', [DF_OnGetEnabled, @NiTexturingProperty_EnBumpMapTexture]),
    wbBool('Has Normal Texture', [DF_OnGetEnabled, @NiTexturingProperty_EnHasNormalTexture]),
    wbTexDesc('Normal Texture', [DF_OnGetEnabled, @NiTexturingProperty_EnNormalTexture]),
    wbBool('Has Parallax Texture', [DF_OnGetEnabled, @NiTexturingProperty_EnHasParallaxTexture]),
    wbTexDesc('Parallax Texture', [DF_OnGetEnabled, @NiTexturingProperty_EnParallax]),
    dfFloat('Parallax Offset', [DF_OnGetEnabled, @NiTexturingProperty_EnParallax]),
    wbBool('Has Decal 0 Texture', [DF_OnGetEnabled, @NiTexturingProperty_EnHasDecal0Texture]),
    wbTexDesc('Decal 0 Texture', [DF_OnGetEnabled, @NiTexturingProperty_EnDecal0Texture]),
    wbBool('Has Decal 1 Texture', [DF_OnGetEnabled, @NiTexturingProperty_EnHasDecal1Texture]),
    wbTexDesc('Decal 1 Texture', [DF_OnGetEnabled, @NiTexturingProperty_EnDecal1Texture]),
    wbBool('Has Decal 2 Texture', [DF_OnGetEnabled, @NiTexturingProperty_EnHasDecal2Texture]),
    wbTexDesc('Decal 2 Texture', [DF_OnGetEnabled, @NiTexturingProperty_EnDecal2Texture]),
    wbBool('Has Decal 3 Texture', [DF_OnGetEnabled, @NiTexturingProperty_EnHasDecal3Texture]),
    wbTexDesc('Decal 3 Texture', [DF_OnGetEnabled, @NiTexturingProperty_EnDecal3Texture]),
    dfArray('Shader Textures', wbShaderTexDesc('Shader Textures', []), -4, '', [DF_OnGetEnabled, @EnSince10010])
  ]), 'NiProperty', False);
end;

//===========================================================================
{ NiVertexColorProperty }
procedure wbDefineNiVertexColorProperty;
begin
  wbNiObject(wbNifBlock('NiVertexColorProperty', [
    dfInteger('Flags', dtU16),
    wbVertMode('Vertex Mode', '', [DF_OnGetEnabled, @EnBefore20005]),
    wbLightMode('Light Mode', '', [DF_OnGetEnabled, @EnBefore20005])
  ]), 'NiProperty', False);
end;

//===========================================================================
{ NiWireframeProperty }
procedure wbDefineNiWireframeProperty;
begin
  wbNiObject(wbNifBlock('NiWireframeProperty', [
    dfInteger('Flags', dtU16)
  ]), 'NiProperty', False);
end;

//===========================================================================
{ NiZBufferProperty }
function NiZBufferProperty_EnFunction(const e: TdfElement): Boolean; begin with nif(e) do Result := (Version >= v41012) and (Version <= v20005); end;

procedure wbDefineNiZBufferProperty;
begin
  wbNiObject(wbNifBlock('NiZBufferProperty', [
    dfInteger('Flags', dtU16, '3'),
    wbZCompareMode('Function', 'ZCOMP_LESS_EQUAL', [DF_OnGetEnabled, @NiZBufferProperty_EnFunction])
  ]), 'NiProperty', False);
end;

//===========================================================================
{ BSShaderProperty }
function BSShaderProperty_EnShaderType(const e: TdfElement): Boolean; begin Result := nif(e).UserVersion2 <= 34; end;

procedure wbDefineBSShaderProperty;
begin
  wbNiObject(wbNifBlock('BSShaderProperty', [
    wbBSShaderType('Shader Type', 'SHADER_DEFAULT', [DF_OnGetEnabled, @BSShaderProperty_EnShaderType]),
    wbBSShaderFlags('Shader Flags 1', 'Specular | Remappable_Textures | ZBuffer_Test', [DF_OnGetEnabled, @BSShaderProperty_EnShaderType]),
    wbBSShaderFlags2('Shader Flags 2', 'ZBuffer_Write', [DF_OnGetEnabled, @BSShaderProperty_EnShaderType]),
    dfFloat('Environment Map Scale', '1.0', [DF_OnGetEnabled, @BSShaderProperty_EnShaderType])
  ]), 'NiShadeProperty', False);
end;

//===========================================================================
{ BSShaderLightingProperty }
function BSShaderLightingProperty_EnClampMode(const e: TdfElement): Boolean; begin Result := nif(e).UserVersion2 <= 34; end;

procedure wbDefineBSShaderLightingProperty;
begin
  wbNiObject(wbNifBlock('BSShaderLightingProperty', [
    wbTexClampMode('Texture Clamp Mode', '', [DF_OnGetEnabled, @BSShaderLightingProperty_EnClampMode])
  ]), 'BSShaderProperty', True);
end;

//===========================================================================
{ BSShaderNoLightingProperty }
function BSShaderNoLightingProperty_En(const e: TdfElement): Boolean; begin Result := nif(e).UserVersion2 > 26; end;

procedure wbDefineBSShaderNoLightingProperty;
begin
  wbNiObject(wbNifBlock('BSShaderNoLightingProperty', [
    wbSizedString('File Name'),
    dfFloat('Falloff Start Angle', '1.0', [DF_OnGetEnabled, @BSShaderNoLightingProperty_En]),
    dfFloat('Falloff Stop Angle', '0.0', [DF_OnGetEnabled, @BSShaderNoLightingProperty_En]),
    dfFloat('Falloff Start Opacity', '1.0', [DF_OnGetEnabled, @BSShaderNoLightingProperty_En]),
    dfFloat('Falloff Stop Opacity', '0.0', [DF_OnGetEnabled, @BSShaderNoLightingProperty_En])
  ]), 'BSShaderLightingProperty', False);
end;

//===========================================================================
{ BSShaderPPLightingProperty }
function BSShaderPPLightingProperty_EnRefraction(const e: TdfElement): Boolean; begin Result := nif(e).UserVersion2 > 14; end;
function BSShaderPPLightingProperty_EnParallax(const e: TdfElement): Boolean; begin Result := nif(e).UserVersion2 > 24; end;
function BSShaderPPLightingProperty_EnEmissive(const e: TdfElement): Boolean; begin Result := nif(e).UserVersion2 > 34; end;

procedure wbDefineBSShaderPPLightingProperty;
begin
  wbNiObject(wbNifBlock('BSShaderPPLightingProperty', [
    wbNiRef('Texture Set', 'BSShaderTextureSet'),
    dfFloat('Refraction Strength', [DF_OnGetEnabled, @BSShaderPPLightingProperty_EnRefraction]),
    dfInteger('Refraction File Period', dtS32, [DF_OnGetEnabled, @BSShaderPPLightingProperty_EnRefraction]),
    dfFloat('Parallax Max Passes', '4.0', [DF_OnGetEnabled, @BSShaderPPLightingProperty_EnParallax]),
    dfFloat('Parallax Scale', '0.4', [DF_OnGetEnabled, @BSShaderPPLightingProperty_EnParallax]),
    wbColor4('Emissive Color', [DF_OnGetEnabled, @BSShaderPPLightingProperty_EnEmissive])
  ]), 'BSShaderLightingProperty', False);
end;

//===========================================================================
{ BSEffectShaderProperty }
function BSEffectShaderProperty_DecideShaderFlags(const e: TdfElement): Integer; begin if nif(e).UserVersion2 <> 130 then Result := 0 else Result := 1; end;
function BSEffectShaderProperty_EnEnvMap(const e: TdfElement): Boolean; begin with nif(e) do Result := (Version = v20207) and (UserVersion2 = 130); end;

procedure wbDefineBSEffectShaderProperty;
begin
  wbNiObject(wbNifBlock('BSEffectShaderProperty', [
    dfUnion([
      wbSkyrimShaderPropertyFlags1('Shader Flags 1', '2147483648', []),
      wbFallout4ShaderPropertyFlags1('Shader Flags 1', '2147483648', [])
    ], [DF_OnDecide, @BSEffectShaderProperty_DecideShaderFlags]),
    dfUnion([
      wbSkyrimShaderPropertyFlags2('Shader Flags 2', '32', []),
      wbFallout4ShaderPropertyFlags2('Shader Flags 2', '32', [])
    ], [DF_OnDecide, @BSEffectShaderProperty_DecideShaderFlags]),
    wbTexCoord('UV Offset'),
    wbTexCoord('UV Scale', '1 1', []),
    wbSizedString('Source Texture'),
    dfInteger('Texture Clamp Mode', dtU8),
    dfInteger('Lighting Influence', dtU8),
    dfInteger('Env Map Min LOD', dtU8),
    dfInteger('Unknown Byte', dtU8),
    dfFloat('Falloff Start Angle', '1.0'),
    dfFloat('Falloff Stop Angle', '1.0'),
    dfFloat('Falloff Start Opacity'),
    dfFloat('Falloff Stop Opacity'),
    wbColor4('Emissive Color'),
    dfFloat('Emissive Multiple'),
    dfFloat('Soft Falloff Depth'),
    wbSizedString('Grayscale Texture'),
    wbSizedString('Env Map Texture', [DF_OnGetEnabled, @BSEffectShaderProperty_EnEnvMap]),
    wbSizedString('Normal Texture', [DF_OnGetEnabled, @BSEffectShaderProperty_EnEnvMap]),
    wbSizedString('Env Mask Texture', [DF_OnGetEnabled, @BSEffectShaderProperty_EnEnvMap]),
    dfFloat('Environment Map Scale', [DF_OnGetEnabled, @BSEffectShaderProperty_EnEnvMap])
  ]), 'BSShaderProperty', False);
end;

  //===========================================================================
{ BSLightingShaderProperty }
function BSLightingShaderProperty_EnShaderType(const e: TdfElement): Boolean; begin Result := nif(e).UserVersion2 >= 83; end;
function BSLightingShaderProperty_DecideShaderFlags(const e: TdfElement): Integer; begin if nif(e).UserVersion2 <> 130 then Result := 0 else Result := 1; end;
function BSLightingShaderProperty_EnWet(const e: TdfElement): Boolean; begin Result := nif(e).UserVersion2 = 130; end;
function BSLightingShaderProperty_EnLightingEffect(const e: TdfElement): Boolean; begin Result := nif(e).UserVersion2 < 130; end;
function BSLightingShaderProperty_EnBacklightPower(const e: TdfElement): Boolean; begin Result := (nif(e).UserVersion2 = 130) and (e.EditValues['..\Rimlight Power'] = 'Max'); end;
function BSLightingShaderProperty_EnEnvMapScale(const e: TdfElement): Boolean; begin Result := e.NativeValues['..\Shader Type'] = 1; end;
function BSLightingShaderProperty_EnUnknownEnvMapShort(const e: TdfElement): Boolean; begin Result := (nif(e).UserVersion2 = 130) and (e.NativeValues['..\Shader Type'] = 1); end;
function BSLightingShaderProperty_EnSkinTintColor(const e: TdfElement): Boolean; begin Result := e.NativeValues['..\Shader Type'] = 5; end;
function BSLightingShaderProperty_EnUnknownSkinTintInt(const e: TdfElement): Boolean; begin Result := (nif(e).UserVersion2 = 130) and (e.NativeValues['..\Shader Type'] = 5); end;
function BSLightingShaderProperty_EnHairTintColor(const e: TdfElement): Boolean; begin Result := e.NativeValues['..\Shader Type'] = 6; end;
function BSLightingShaderProperty_EnMaxPasses(const e: TdfElement): Boolean; begin Result := e.NativeValues['..\Shader Type'] = 7; end;
function BSLightingShaderProperty_EnParallax(const e: TdfElement): Boolean; begin Result := e.NativeValues['..\Shader Type'] = 11; end;
function BSLightingShaderProperty_EnSparkleParameters(const e: TdfElement): Boolean; begin Result := e.NativeValues['..\Shader Type'] = 14; end;
function BSLightingShaderProperty_EnEyes(const e: TdfElement): Boolean; begin Result := e.NativeValues['..\Shader Type'] = 16; end;

procedure wbDefineBSLightingShaderProperty;
begin
  wbNiObject(wbNifBlock('BSLightingShaderProperty', [
    wbBSLightingShaderPropertyShaderType('Shader Type', '', [DF_OnGetEnabled, @BSLightingShaderProperty_EnShaderType]),
    dfUnion([
      wbSkyrimShaderPropertyFlags1('Shader Flags 1', '2185233153', []),
      wbFallout4ShaderPropertyFlags1('Shader Flags 1', '2151678465', [])
    ], [DF_OnDecide, @BSLightingShaderProperty_DecideShaderFlags]),
    dfUnion([
      wbSkyrimShaderPropertyFlags2('Shader Flags 2', '32801', []),
      wbFallout4ShaderPropertyFlags2('Shader Flags 2', '1', [])
    ], [DF_OnDecide, @BSLightingShaderProperty_DecideShaderFlags]),
    wbTexCoord('UV Offset'),
    wbTexCoord('UV Scale', '1 1', []),
    wbNiRef('Texture Set', 'BSShaderTextureSet'),
    wbColor3('Emissive Color', '#000000', []),
    dfFloat('Emissive Multiple'),
    wbString('Wet Material', [DF_OnGetEnabled, @BSLightingShaderProperty_EnWet]),
    wbTexClampMode('Texture Clamp Mode', '3', []),
    dfFloat('Alpha', '1.0'),
    dfFloat('Refraction Strength'),
    dfFloat('Glossiness', '80.0', [DF_OnGetEnabled, @BSLightingShaderProperty_EnLightingEffect]),
    dfFloat('Smoothness', '1.0', [DF_OnGetEnabled, @BSLightingShaderProperty_EnWet]),
    wbColor3('Specular Color'),
    dfFloat('Specular Strength', '1.0'),
    dfFloat('Lighting Effect 1', '0.3', [DF_OnGetEnabled, @BSLightingShaderProperty_EnLightingEffect]),
    dfFloat('Lighting Effect 2', '2.0', [DF_OnGetEnabled, @BSLightingShaderProperty_EnLightingEffect]),
    dfFloat('Subsurface Rolloff', '0.3', [DF_OnGetEnabled, @BSLightingShaderProperty_EnWet]),
    dfFloat('Rimlight Power', 'Max', [DF_OnGetEnabled, @BSLightingShaderProperty_EnWet]),
    dfFloat('Backlight Power', [DF_OnGetEnabled, @BSLightingShaderProperty_EnBacklightPower]),
    dfFloat('Grayscale to Palette Scale', [DF_OnGetEnabled, @BSLightingShaderProperty_EnWet]),
    dfFloat('Fresnel Power', '5.0', [DF_OnGetEnabled, @BSLightingShaderProperty_EnWet]),
    dfStruct('Wetness', [
      dfFloat('Spec Scale', '-1.0'),
      dfFloat('Spec Power', '-1.0'),
      dfFloat('Min Var', '-1.0'),
      dfFloat('Env Map Scale', '-1.0'),
      dfFloat('Fresnel Power', '-1.0'),
      dfFloat('Metalness', '-1.0')
    ], [DF_OnGetEnabled, @BSLightingShaderProperty_EnWet]),
    dfFloat('Environment Map Scale', '1.0', [DF_OnGetEnabled, @BSLightingShaderProperty_EnEnvMapScale]),
    dfInteger('Unknown EnvMap Short', dtU16, [DF_OnGetEnabled, @BSLightingShaderProperty_EnUnknownEnvMapShort]),
    wbColor3('Skin Tint Color', [DF_OnGetEnabled, @BSLightingShaderProperty_EnSkinTintColor]),
    dfInteger('Unknown SkinTint Int', dtU32, [DF_OnGetEnabled, @BSLightingShaderProperty_EnUnknownSkinTintInt]),
    wbColor3('Hair Tint Color', [DF_OnGetEnabled, @BSLightingShaderProperty_EnHairTintColor]),
    dfFloat('Max Passes', [DF_OnGetEnabled, @BSLightingShaderProperty_EnMaxPasses]),
    dfFloat('Scale', [DF_OnGetEnabled, @BSLightingShaderProperty_EnMaxPasses]),
    dfStruct('Parallax', [
      dfFloat('Inner Layer Thickness'),
      dfFloat('Refraction Scale'),
      wbTexCoord('Inner Layer Texture Scale'),
      dfFloat('Envmap Strength')
    ], [DF_OnGetEnabled, @BSLightingShaderProperty_EnParallax]),
    wbVector4('Sparkle Parameters', [DF_OnGetEnabled, @BSLightingShaderProperty_EnSparkleParameters]),
    dfStruct('Eyes', [
      dfFloat('Cubemap Scale'),
      wbVector3('Left Eye Reflection Center', []),
      wbVector3('Right Eye Reflection Center', [])
    ], [DF_OnGetEnabled, @BSLightingShaderProperty_EnEyes])
  ]), 'BSShaderProperty', False, 1);
end;

//===========================================================================
{ BSSkyShaderProperty }
procedure wbDefineBSSkyShaderProperty;
begin
  wbNiObject(wbNifBlock('BSSkyShaderProperty', [
    wbSkyrimShaderPropertyFlags1('Shader Flags 1', '', []),
    wbSkyrimShaderPropertyFlags2('Shader Flags 2', '', []),
    wbTexCoord('UV Offset'),
    wbTexCoord('UV Scale', '1 1', []),
    wbSizedString('Source Texture'),
    wbSkyObjectType('Sky Object Type', '', [])
  ]), 'BSShaderProperty', False);
end;

//===========================================================================
{ BSWaterShaderProperty }
procedure wbDefineBSWaterShaderProperty;
begin
  wbNiObject(wbNifBlock('BSWaterShaderProperty', [
    wbSkyrimShaderPropertyFlags1('Shader Flags 1', '', []),
    wbSkyrimShaderPropertyFlags2('Shader Flags 2', '', []),
    wbTexCoord('UV Offset'),
    wbTexCoord('UV Scale', '1 1', []),
    wbSkyrimWaterShaderFlags('Water Shader Flags', '', []),
    dfInteger('Water Direction', dtU8, '3'),
    dfInteger('Unknown Short 3', dtU16)
  ]), 'BSShaderProperty', False);
end;

//===========================================================================
{ BSDistantTreeShaderProperty }
procedure wbDefineBSDistantTreeShaderProperty;
begin
  wbNiObject(wbNifBlock('BSDistantTreeShaderProperty'), 'BSShaderProperty', False);
end;

//===========================================================================
{ DistantLODShaderProperty }
procedure wbDefineDistantLODShaderProperty;
begin
  wbNiObject(wbNifBlock('DistantLODShaderProperty'), 'BSShaderProperty', False);
end;

//===========================================================================
{ HairShaderProperty }
procedure wbDefineHairShaderProperty;
begin
  wbNiObject(wbNifBlock('HairShaderProperty'), 'BSShaderProperty', False);
end;

//===========================================================================
{ Lighting30ShaderProperty }
procedure wbDefineLighting30ShaderProperty;
begin
  wbNiObject(wbNifBlock('Lighting30ShaderProperty'), 'BSShaderPPLightingProperty', False);
end;

//===========================================================================
{ TallGrassShaderProperty }
procedure wbDefineTallGrassShaderProperty;
begin
  wbNiObject(wbNifBlock('TallGrassShaderProperty', [
    wbSizedString('File Name')
  ]), 'BSShaderProperty', False);
end;

//===========================================================================
{ TileShaderProperty }
procedure wbDefineTileShaderProperty;
begin
  wbNiObject(wbNifBlock('TileShaderProperty', [
    wbSizedString('File Name')
  ]), 'BSShaderLightingProperty', False);
end;

//===========================================================================
{ SkyShaderProperty }
procedure wbDefineSkyShaderProperty;
begin
  wbNiObject(wbNifBlock('SkyShaderProperty', [
    wbSizedString('File Name'),
    wbSkyObjectType('Sky Object Type', '', [])
  ]), 'BSShaderLightingProperty', False);
end;

//===========================================================================
{ VolumetricFogShaderProperty }
procedure wbDefineVolumetricFogShaderProperty;
begin
  wbNiObject(wbNifBlock('VolumetricFogShaderProperty'), 'BSShaderProperty', False);
end;

//===========================================================================
{ WaterShaderProperty }
procedure wbDefineWaterShaderProperty;
begin
  wbNiObject(wbNifBlock('WaterShaderProperty'), 'BSShaderProperty', False);
end;

//===========================================================================
{ BSShaderTextureSet }
procedure BSShaderTextureSet_AfterLoad(const aElement: TdfElement; const aDataStart: Pointer; aDataSize: Integer);
begin
  if aElement.Elements['Textures'].Count = 0 then
    aElement.Elements['Textures'].Count := 6;
end;

procedure wbDefineBSShaderTextureSet;
begin
  wbNiObject(wbNifBlock('BSShaderTextureSet', [
    dfArray('Textures', wbSizedString('Textures'), -4)
  ], [{DF_OnAfterLoad, @BSShaderTextureSet__AfterLoad}]), 'NiObject', False);
end;

//===========================================================================
{ NiTexture }
procedure wbDefineNiTexture;
begin
  wbNiObject(wbNifBlock('NiTexture'), 'NiObjectNET', True);
end;

//===========================================================================
{ NiSourceTexture }
function NiSourceTexture_EnFileName(const e: TdfElement): Boolean; begin Result := e.NativeValues['..\Use External'] = 1; end;
function NiSourceTexture_EnUnknownLink(const e: TdfElement): Boolean; begin Result := (nif(e).Version >= v10100) and (e.NativeValues['..\Use External'] = 1); end;
function NiSourceTexture_EnUnknownByte(const e: TdfElement): Boolean; begin Result := (nif(e).Version <= v10010) and (e.NativeValues['..\Use External'] = 0); end;
function NiSourceTexture_EnFileName2(const e: TdfElement): Boolean; begin Result := (nif(e).Version >= v10100) and (e.NativeValues['..\Use External'] = 0); end;
function NiSourceTexture_EnPixelData(const e: TdfElement): Boolean; begin Result := e.NativeValues['..\Use External'] = 0; end;

procedure wbDefineNiSourceTexture;
begin
  wbNiObject(wbNifBlock('NiSourceTexture', [
    dfInteger('Use External', dtU8, '1'),
    wbString('File Name', [DF_OnGetEnabled, @NiSourceTexture_EnFileName]),
    wbNiRef('Unknown Link', 'NiObject', [DF_OnGetEnabled, @NiSourceTexture_EnUnknownLink]),
    dfInteger('Unknown Byte', dtU8, '1', [DF_OnGetEnabled, @NiSourceTexture_EnUnknownByte]),
    wbString('File Name', [DF_OnGetEnabled, @NiSourceTexture_EnFileName2]),
    wbNiRef('Pixel Data', 'NiPixelFormat', [DF_OnGetEnabled, @NiSourceTexture_EnPixelData]),
    wbPixelLayout('Pixel Layout', 'PIX_LAY_PALETTISED_4', []),
    wbMipMapFormat('Use Mipmaps', 'MIP_FMT_DEFAULT', []),
    wbAlphaFormat('Alpha Format', 'ALPHA_DEFAULT', []),
    dfInteger('Is Static', dtU8, '1'),
    wbBool('Direct Render', 'yes', [DF_OnGetEnabled, @EnSince1010106]),
    wbBool('Persist Render Data', [DF_OnGetEnabled, @EnSince20207])
  ]), 'NiTexture', False);
end;

//===========================================================================
{ NiSourceCubeMap * }
procedure wbDefineNiSourceCubeMap;
begin
  wbNiObject(wbNifBlock('NiSourceCubeMap'), 'NiSourceTexture', False);
end;

//===========================================================================
{ NiGeometry }
function NiGeometry_EnBSParticles(const e: TdfElement): Boolean; begin with nif(e) do Result := (UserVersion2 >= 100) and wbIsNiObject(e, 'NiParticleSystem'); end;
function NiGeometry_EnBSNoParticles(const e: TdfElement): Boolean; begin with nif(e) do Result := (UserVersion2 < 100) or ( (UserVersion2 >= 100) and not wbIsNiObject(e, 'NiParticleSystem') ); end;
function NiGeometry_EnHasShader(const e: TdfElement): Boolean; begin with nif(e) do Result := (Version >= v10010) and (Version <= v20103); end;
function NiGeometry_EnShaderName(const e: TdfElement): Boolean; begin Result := NiGeometry_EnHasShader(e) and (e.NativeValues['..\Has Shader'] <> 0); end;
function NiGeometry_EnMaterialData(const e: TdfElement): Boolean; begin with nif(e) do Result := (Version >= v10010) and ( (UserVersion2 < 100) or ( (UserVersion2 >= 100) and not wbIsNiObject(e, 'NiParticleSystem') ) ); end;
function NiGeometry_EnMaterialUpdateFlag(const e: TdfElement): Boolean; begin with nif(e) do Result := (Version = v20207) and ( (UserVersion2 < 100) or ( (UserVersion2 >= 100) and not wbIsNiObject(e, 'NiParticleSystem') ) ); end;
function NiGeometry_EnBSProperties(const e: TdfElement): Boolean; begin with nif(e) do Result := (Version >= v20207) and (UserVersion = 12); end;

procedure wbDefineNiGeometry;
begin
  wbNiObject(wbNifBlock('NiGeometry', [
    // BSGeometry: Used by Bethesda Stream 100+ NiParticleSystem
    wbNiBound('Bound', [DF_OnGetEnabled, @NiGeometry_EnBSParticles]),
    wbNiRef('Skin', 'NiObject', [DF_OnGetEnabled, @NiGeometry_EnBSParticles]),
    // NiGeometry: excluding NiParticleSystem for Bethesda Stream 100+
    wbNiRef('Data', 'NiGeometryData', [DF_OnGetEnabled, @NiGeometry_EnBSNoParticles]),
    wbNiRef('Skin Instance', 'NiSkinInstance', [DF_OnGetEnabled, @NiGeometry_EnBSNoParticles]),
    dfStruct('Material Data', [
      wbBool('Has Shader', [DF_OnGetEnabled, @NiGeometry_EnHasShader]),
      wbSizedString('Shader Name', [DF_OnGetEnabled, @NiGeometry_EnShaderName]),
      dfInteger('Shader Extra Data', dtS32, [DF_OnGetEnabled, @NiGeometry_EnShaderName]),
      dfInteger('Num Materials', dtU32, [DF_OnGetEnabled, @EnSince20207]),
      dfArray('Material Name', wbString('Material Name'), 0, 'Num Materials', [DF_OnGetEnabled, @EnSince20207]),
      dfArray('Material Extra Data', dfInteger('Material Extra Data', dtS32, '-1'), 0, 'Num Materials', [DF_OnGetEnabled, @EnSince20207]),
      dfInteger('Active Material', dtS32, '-1', [DF_OnGetEnabled, @EnSince20207]),
      wbBool('Material Needs Update', [DF_OnGetEnabled, @NiGeometry_EnMaterialUpdateFlag])
    ], [DF_OnGetEnabled, @NiGeometry_EnMaterialData]),
    // Bethesda
    wbNiRef('Shader Property', 'BSShaderProperty', [DF_OnGetEnabled, @NiGeometry_EnBSProperties]),
    wbNiRef('Alpha Property', 'NiAlphaProperty', [DF_OnGetEnabled, @NiGeometry_EnBSProperties])
  ]), 'NiAVObject', False);
end;

//===========================================================================
{ NiTriBasedGeom }
procedure wbDefineNiTriBasedGeom;
begin
  wbNiObject(wbNifBlock('NiTriBasedGeom'), 'NiGeometry', True);
end;

//===========================================================================
{ NiGeometryData }
function NiGeometryData_EnNumVertices(const e: TdfElement): Boolean;
begin
  Result := not wbIsNiObject(e, 'NiPSysData');
  if not Result then
    Result := nif(e).UserVersion2 < 34;
end;

function NiGeometryData_EnBSMaxVertices(const e: TdfElement): Boolean; begin with nif(e) do Result := (UserVersion2 >= 34) and wbIsNiObject(e, 'NiPSysData'); end;
function NiGeometryData_EnVertices(const e: TdfElement): Boolean; begin Result := e.NativeValues['..\Has Vertices'] <> 0; end;
function NiGeometryData_DecideVectorFlags(const e: TdfElement): Integer; begin if nif(e).Version = v20207 then Result := 1 else Result := 0; end;
function NiGeometryData_EnMaterialCRC(const e: TdfElement): Boolean; begin with nif(e) do Result := (Version = v20207) and (UserVersion = 12); end;
function NiGeometryData_EnNormals(const e: TdfElement): Boolean; begin Result := e.NativeValues['..\Has Normals'] <> 0; end;
function NiGeometryData_EnTangents(const e: TdfElement): Boolean; begin Result := (nif(e).Version >= v10100) and (e.NativeValues['..\Has Normals'] <> 0) and (e.NativeValues['..\Vector Flags'] and 4096 <> 0); end;
function NiGeometryData_EnVertexColors(const e: TdfElement): Boolean; begin Result := e.NativeValues['..\Has Vertex Colors'] <> 0; end;

procedure NiGeometryData_GetCountUVSets(const e: TdfElement; var aCount: Integer);
var vfmask: Cardinal;
begin
  if nif(e).Version = v20207 then vfmask := 1 else vfmask := 63;
  aCount := (e.NativeValues['..\Num UV Sets'] and 63) or (e.NativeValues['..\Vector Flags'] and vfmask);
end;

procedure NiGeometryData_SetCountUVSets(const e: TdfElement; var aCount: Integer);
begin
  e.NativeValues['..\Num UV Sets'] := e.NativeValues['..\Num UV Sets'] and not 63 + aCount;
  e.NativeValues['..\Vector Flags'] := e.NativeValues['..\Vector Flags'] and not 63 + aCount;
end;

procedure wbDefineNiGeometryData;
begin
  wbNiObject(wbNifBlock('NiGeometryData', [
    dfInteger('Group ID', dtS32, [DF_OnGetEnabled, @EnSince10200]),
    dfInteger('Num Vertices', dtU16, [DF_OnGetEnabled, @NiGeometryData_EnNumVertices]),
    dfInteger('BS Max Vertices', dtU16, [DF_OnGetEnabled, @NiGeometryData_EnBSMaxVertices]),
    dfInteger('Keep Flags', dtU8, [DF_OnGetEnabled, @EnSince10100]),
    dfInteger('Compress Flags', dtU8, [DF_OnGetEnabled, @EnSince10100]),
    wbBool('Has Vertices', '1', []),
    dfArray('Vertices', wbVector3('Vertices'), 0, 'Num Vertices', [DF_OnGetEnabled, @NiGeometryData_EnVertices]),
    dfUnion([
      wbVectorFlags('Vector Flags', '', []),
      wbBSVectorFlags('Vector Flags', '', [])
    ], [DF_OnGetEnabled, @EnSince10010, DF_OnDecide, @NiGeometryData_DecideVectorFlags]),
    dfInteger('Material CRC', dtU32, [DF_OnGetEnabled, @NiGeometryData_EnMaterialCRC]),
    wbBool('Has Normals', '', []),
    dfArray('Normals', wbVector3('Tangents'), 0, 'Num Vertices', [DF_OnGetEnabled, @NiGeometryData_EnNormals]),
    dfArray('Tangents', wbVector3('Tangents'), 0, 'Num Vertices', [DF_OnGetEnabled, @NiGeometryData_EnTangents]),
    dfArray('Bitangents', wbVector3('Bitangents'), 0, 'Num Vertices', [DF_OnGetEnabled, @NiGeometryData_EnTangents]),
    wbVector3('Center'),
    dfFloat('Radius'),
    wbBool('Has Vertex Colors', '', []),
    dfArray('Vertex Colors', wbColor4('Vertex Colors'), 0, 'Num Vertices', [DF_OnGetEnabled, @NiGeometryData_EnVertexColors]),
    dfInteger('Num UV Sets', dtU16, [DF_OnGetEnabled, @EnBefore4220]),
    wbBool('Has UV', [DF_OnGetEnabled, @EnBefore4002]),
    dfArray('UV Sets',
      dfArray('Set', wbTexCoord('UV'), 0, '..\Num Vertices', []),
      0, '', [DF_OnGetCount, @NiGeometryData_GetCountUVSets, DF_OnSetCount, @NiGeometryData_SetCountUVSets]
    ),
    wbConsistencyType('Consistency Flags', 'CT_MUTABLE', [DF_OnGetEnabled, @EnSince10010]),
    wbNiRef('Additional Data', 'AbstractAdditionalGeometryData', [DF_OnGetEnabled, @EnSince20004])
  ]), 'NiObject', True);
end;

//===========================================================================
{ NiTriBasedGeomData }
procedure NiTriBasedGeomData_SetNumTriangles(const e: TdfElement; var aValue: Variant); begin e.NativeValues['..\Num Triangle Points'] := aValue*3; end;

procedure wbDefineNiTriBasedGeomData;
begin
  wbNiObject(wbNifBlock('NiTriBasedGeomData', [
    dfInteger('Num Triangles', dtU16, [DF_OnSetValue, @NiTriBasedGeomData_SetNumTriangles])
  ]), 'NiGeometryData', True);
end;

//===========================================================================
{ NiLines * }
procedure wbDefineNiLines;
begin
  wbNiObject(wbNifBlock('NiLines'), 'NiTriBasedGeom', False);
end;

//===========================================================================
{ NiLinesData * }
procedure wbDefineNiLinesData;
begin
  wbNiObject(wbNifBlock('NiLinesData'), 'NiGeometryData', False);
end;

//===========================================================================
{ NiTriShape }
procedure wbDefineNiTriShape;
begin
  wbNiObject(wbNifBlock('NiTriShape'), 'NiTriBasedGeom', False);
end;

//===========================================================================
{ NiTriShapeData }
function NiTriShapeData_EnTriangles(const e: TdfElement): Boolean;
begin
  with nif(e) do
    Result := (nif(e).Version <= v10012) or ((nif(e).Version >= v10013) and (e.NativeValues['..\Has Triangles'] <> 0));
end;

procedure wbDefineNiTriShapeData;
begin
  wbNiObject(wbNifBlock('NiTriShapeData', [
    dfInteger('Num Triangle Points', dtU32),
    wbBool('Has Triangles', [DF_OnGetEnabled, @EnSince10100]),
    dfArray('Triangles', wbTriangle('Triangles'), 0, 'Num Triangles', [DF_OnGetEnabled, @NiTriShapeData_EnTriangles]),
    dfInteger('Num Match Groups', dtU16),
    dfArray('Match Groups', wbMatchGroup('Match Groups'), 0, 'Num Match Groups', [])
  ]), 'NiTriBasedGeomData', False);
end;

//===========================================================================
{ NiTriStrips }
procedure wbDefineNiTriStrips;
begin
  wbNiObject(wbNifBlock('NiTriStrips'), 'NiTriBasedGeom', False);
end;

//===========================================================================
{ NiTriStripsData }
function NiTriStripsData_EnPoints(const e: TdfElement): Boolean;
begin
  with nif(e) do
    Result := (nif(e).Version <= v10012) or ((nif(e).Version >= v10013) and (e.NativeValues['..\Has Points'] <> 0));
end;

procedure NiTriStripsData_GetCountStrips(const e: TdfElement; var aCount: Integer);
begin
  aCount := e.NativeValues['..\..\Strip Lengths\Strip Lengths #' + IntToStr(e.Index)];
end;

procedure NiTriStripsData_SetCountStrips(const e: TdfElement; var aCount: Integer);
begin
  e.NativeValues['..\..\Strip Lengths\Strip Lengths #' + IntToStr(e.Index)] := aCount;
end;

procedure wbDefineNiTriStripsData;
begin
  wbNiObject(wbNifBlock('NiTriStripsData', [
    dfInteger('Num Strips', dtU16),
    dfArray('Strip Lengths', dfInteger('Strip Lengths', dtU16), 0, 'Num Strips', []),
    wbBool('Has Points', [DF_OnGetEnabled, @EnSince10013]),
    dfArray('Strips',
      dfArray('Strips', dfInteger('Points', dtU16), 0, '', [
        DF_OnGetCount, @NiTriStripsData_GetCountStrips,
        DF_OnSetCount, @NiTriStripsData_SetCountStrips
      ]),
      0, 'Num Strips', [DF_OnGetEnabled, @NiTriStripsData_EnPoints])
  ]), 'NiTriBasedGeomData', False);
end;

//===========================================================================
{ NiScreenElements * }
procedure wbDefineNiScreenElements;
begin
  wbNiObject(wbNifBlock('NiScreenElements'), 'NiTriShape', False);
end;

//===========================================================================
{ NiScreenElementsData * }
procedure wbDefineNiScreenElementsData;
begin
  wbNiObject(wbNifBlock('NiScreenElementsData', [
    dfInteger('Max Polygons', dtU16),
    dfArray('Polygons', dfStruct('Polygons', [
      dfInteger('Num Vertices', dtU16),
      dfInteger('Vertex Offset', dtU16),
      dfInteger('Num Triangles', dtU16),
      dfInteger('Triangle Offset', dtU16)
    ]), 0, 'Max Polygons', []),
    dfArray('Polygon Indices', dfInteger('Polygon Indices', dtU16), 0, 'Max Polygons', []),
    dfInteger('Polygon Grow By', dtU16, '1'),
    dfInteger('Num Polygons', dtU16),
    dfInteger('Max Vertices', dtU16),
    dfInteger('Vertices Grow By', dtU16, '1'),
    dfInteger('Max Indices', dtU16),
    dfInteger('Indices Grow By', dtU16, '1')
  ]), 'NiTriShapeData', False);
end;

//===========================================================================
{ BSLODTriShape }
procedure wbDefineBSLODTriShape;
begin
  wbNiObject(wbNifBlock('BSLODTriShape', [
    dfInteger('LOD0 Size', dtU32),
    dfInteger('LOD1 Size', dtU32),
    dfInteger('LOD2 Size', dtU32)
  ]), 'NiTriBasedGeom', False);
end;

//===========================================================================
{ BSSegmentedTriShape }
procedure wbDefineBSSegmentedTriShape;
begin
  wbNiObject(wbNifBlock('BSSegmentedTriShape', [
    dfArray('Segment', wbBSGeometrySegmentData('Segment', []), -4)
  ]), 'NiTriShape', False);
end;

//===========================================================================
{ BSTriShape }
function BSTriShape_DecideNumTriangles(const e: TdfElement): Integer; begin if nif(e).UserVersion2 = 130 then Result := 0 else Result := 1; end;

function BSTriShape_EnVertexData(const e: TdfElement): Boolean;
begin
  Result := (nif(e).UserVersion2 in [100, 130]) and (e.NativeValues['..\Data Size'] > 0);
  if Result then e.UserData := e.NativeValues['..\VertexDesc\VF']; // cache VF here
end;

function BSTriShape_EnTriangles(const e: TdfElement): Boolean; begin Result := e.NativeValues['..\Data Size'] > 0; end;
function BSTriShape_EnParticleDataSize(const e: TdfElement): Boolean; begin Result := nif(e).UserVersion2 = 100; end;
function BSTriShape_EnVertices(const e: TdfElement): Boolean; begin Result := (nif(e).UserVersion2 = 100) and (e.NativeValues['..\Particle Data Size'] > 0); end;

procedure BSTriShape_BeforeSaveDataSize(const e: TdfElement);
var
  el: TdfElement;
  size: Cardinal;
begin
  size := 0;
  el := e.Elements['..\Vertex Data'];
  if Assigned(el) then Inc(size, el.DataSize);
  el := e.Elements['..\Triangles'];
  if Assigned(el) then Inc(size, el.DataSize);
  e.NativeValue := size;
end;

procedure BSTriShape_BeforeSaveParticleDataSize(const e: TdfElement);
begin
  // code to update particle data

//  // Find NiOptimizeKeep string
//  for (auto& extraData : bsOptShape->extraDataRefs) {
//    auto stringData = hdr.GetBlock<NiStringExtraData>(extraData);
//    if (stringData) {
//      if (stringData->stringData.get().find("NiOptimizeKeep") != std::string::npos) {
//        bsOptShape->particleDataSize = bsOptShape->GetNumVertices() * 6
//                         + static_cast<uint32_t>(triangles.size()) * 3;
//        bsOptShape->particleVerts = *vertices;
//
//        bsOptShape->particleNorms.resize(vertices->size(), Vector3(1.0f, 0.0f, 0.0f));
//        if (normals && normals->size() == vertices->size())
//          bsOptShape->particleNorms = *normals;
//
//        bsOptShape->particleTris = triangles;
//      }
//    }
//  }

  // we are just updating the data size if it was already set
  // updating relevant vertices and triangles copy arrays is up to the user
  if e.NativeValue > 0 then
    e.NativeValue := e.NativeValues['..\Num Vertices'] * 6 + e.NativeValues['..\Num Triangles'] * 3;
end;

procedure wbDefineBSTriShape;
begin
  wbNiObject(wbNifBlock('BSTriShape', [
    wbNiBound('Bounding Sphere'),
    wbNiRef('Skin', 'NiObject'),
    wbNiRef('Shader Property', 'BSShaderProperty'),
    wbNiRef('Alpha Property', 'NiAlphaProperty'),
    wbVertexDesc('VertexDesc', []),
    dfUnion([
      dfInteger('Num Triangles', dtU32),
      dfInteger('Num Triangles', dtU16)
    ], [DF_OnDecide, @BSTriShape_DecideNumTriangles]),
    dfInteger('Num Vertices', dtU16),
    // nonzero value so other elements are enabled by default
    dfInteger('Data Size', dtU32, '1', [DF_OnBeforeSave, @BSTriShape_BeforeSaveDataSize]),
    dfArray('Vertex Data', wbBSVertexData('Vertex Data'), 0, 'Num Vertices', [DF_OnGetEnabled, @BSTriShape_EnVertexData]),
    dfArray('Triangles', wbTriangle('Triangles'), 0, 'Num Triangles', [DF_OnGetEnabled, @BSTriShape_EnTriangles]),
    dfInteger('Particle Data Size', dtU32, [
      DF_OnGetEnabled, @BSTriShape_EnParticleDataSize,
      DF_OnBeforeSave, @BSTriShape_BeforeSaveParticleDataSize
    ]),
    dfArray('Vertices', wbVector3('Vertices'), 0, 'Num Vertices', [DF_OnGetEnabled, @BSTriShape_EnVertices]),
    dfArray('Triangles Copy', wbTriangle('Triangles'), 0, 'Num Triangles', [DF_OnGetEnabled, @BSTriShape_EnVertices])
  ]), 'NiAVObject', False);
end;

//===========================================================================
{ BSDynamicTriShape }
function BSDynamicTriShape_EnVertices(const e: TdfElement): Boolean; begin Result := e.NativeValues['..\Dynamic Data Size'] > 0; end;

procedure BSDynamicTriShape_BeforeSaveVertexDataSize(const e: TdfElement);
var
  el: TdfElement;
begin
  el := e.Elements['..\Dynamic Vertices'];
  if Assigned(el) then e.NativeValue := el.DataSize;
end;

procedure wbDefineBSDynamicTriShape;
begin
  wbNiObject(wbNifBlock('BSDynamicTriShape', [
    dfInteger('Dynamic Data Size', dtU32, '1', [DF_OnBeforeSave, @BSDynamicTriShape_BeforeSaveVertexDataSize]),
    dfArray('Dynamic Vertices', wbVector4('Dynamic Vertices'), 0, 'Num Vertices', [DF_OnGetEnabled, @BSDynamicTriShape_EnVertices])
  ]), 'BSTriShape', False);
end;

//===========================================================================
{ BSMeshLODTriShape }
procedure wbDefineBSMeshLODTriShape;
begin
  wbNiObject(wbNifBlock('BSMeshLODTriShape', [
    dfInteger('LOD0 Size', dtU32),
    dfInteger('LOD1 Size', dtU32),
    dfInteger('LOD2 Size', dtU32)
  ]), 'BSTriShape', False);
end;

//===========================================================================
{ BSSubIndexTriShape }
function BSSubIndexTriShape_EnFO4HasData(const e: TdfElement): Boolean; begin Result := (nif(e).UserVersion2 = 130) and (e.NativeValues['..\Data Size'] > 0); end;

function BSSubIndexTriShape_EnFO4SubSegmentData(const e: TdfElement): Boolean;
begin
   Result := (nif(e).UserVersion2 = 130) and (e.NativeValues['..\Data Size'] > 0) and (e.NativeValues['..\Num Segments'] < e.NativeValues['..\Total Segments']);
end;

function BSSubIndexTriShape_EnSegmentSSE(const e: TdfElement): Boolean; begin Result := nif(e).UserVersion2 = 100; end;

procedure wbDefineBSSubIndexTriShape;
begin
  wbNiObject(wbNifBlock('BSSubIndexTriShape', [
    // FO4
    dfInteger('Num Primitives', dtU32, [DF_OnGetEnabled, @BSSubIndexTriShape_EnFO4HasData]),
    dfInteger('Num Segments', dtU32, [DF_OnGetEnabled, @BSSubIndexTriShape_EnFO4HasData]),
    dfInteger('Total Segments', dtU32, [DF_OnGetEnabled, @BSSubIndexTriShape_EnFO4HasData]),
    dfArray('Segment', dfStruct('Segment', [
      dfInteger('Start Index', dtU32),
      dfInteger('Num Primitives', dtU32),
      dfInteger('Parent Array Index', dtU32),
      dfArray('Sub Segment', dfStruct('Sub Segment', [
        dfInteger('Start Index', dtU32),
        dfInteger('Num Primitives', dtU32),
        dfInteger('Parent Array Index', dtU32),
        dfInteger('Unknown Int 1', dtU32)
      ]), -4)
    ]), 0, 'Num Segments', [DF_OnGetEnabled, @BSSubIndexTriShape_EnFO4HasData]),
    dfStruct('Segment Data', [
      dfInteger('Num Segments', dtU32),
      dfInteger('Total Segments', dtU32),
      dfArray('Segment Starts', dfInteger('Segment Starts', dtU32), 0, 'Num Segments', []),
      dfArray('Per Segment Data', dfStruct('Per Segment Data', [
        dfInteger('User Index', dtU32),
        dfInteger('Bone ID', dtU32),
        dfArray('Cut Offsets', dfFloat('Cut Offsets'), -4)
      ]), 0, 'Total Segments', []),
      dfChars('SSF File', -2, '', #0, False, [])
    ], [DF_OnGetEnabled, @BSSubIndexTriShape_EnFO4SubSegmentData]),
    // SSE
    dfArray('Segment', wbBSGeometrySegmentData('Segment', []), -4, '', [DF_OnGetEnabled, @BSSubIndexTriShape_EnSegmentSSE])
  ]), 'BSTriShape', False);
end;

//===========================================================================
{ AbstractAdditionalGeometryData }
procedure wbDefineAbstractAdditionalGeometryData;
begin
  wbNiObject(wbNifBlock('AbstractAdditionalGeometryData'), 'NiObject', True);
end;

//===========================================================================
{ NiAdditionalGeometryData }
procedure wbDefineNiAdditionalGeometryData;
begin
  wbNiObject(wbNifBlock('NiAdditionalGeometryData', [
    dfInteger('Num Vertices', dtU16),
    dfArray('Block Infos', wbAdditionalDataInfo('Block Infos', []), -4),
    dfArray('Blocks', wbAdditionalDataBlock('Blocks', []), -4)
  ]), 'AbstractAdditionalGeometryData', False);
end;

//===========================================================================
{ BSPackedAdditionalGeometryData * }
procedure wbDefineBSPackedAdditionalGeometryData;
begin
  wbNiObject(wbNifBlock('BSPackedAdditionalGeometryData', [
    dfInteger('Num Vertices', dtU16),
    dfArray('Block Infos', wbAdditionalDataInfo('Block Infos', []), -4),
    dfArray('Blocks', wbBSPackedAdditionalDataBlock('Blocks', []), -4)
  ]), 'AbstractAdditionalGeometryData', False);
end;

//===========================================================================
{ NiSkinInstance }
procedure wbDefineNiSkinInstance;
begin
  wbNiObject(wbNifBlock('NiSkinInstance', [
    wbNiRef('Data', 'NiSkinData'),
    wbNiRef('Skin Partition', 'NiSkinPartition', [DF_OnGetEnabled, @EnSince1010101]),
    wbNiPtr('Skeleton Root', 'NiNode'),
    dfArray('Bones', wbNiPtr('Bones', 'NiNode'), -4, '', [DF_OnBeforeSave, @RemoveNoneLinks])
  ]), 'NiObject', False);
end;

//===========================================================================
{ BSDismemberSkinInstance }
procedure wbDefineBSDismemberInstance;
begin
  wbNiObject(wbNifBlock('BSDismemberSkinInstance', [
    dfArray('Partitions', wbBodyPartList('Partitions', []), -4)
  ]), 'NiSkinInstance', False);
end;

//===========================================================================
{ NiSkinData }
function NiSkinData_EnVertexWeights(const e: TdfElement): Boolean; begin with nif(e) do Result := (Version <= v4210) or ((Version >= v4220) and (nifblk(e).NativeValues['Has Vertex Weights'] <> 0)); end;

procedure wbDefineNiSkinData;
begin
  wbNiObject(wbNifBlock('NiSkinData', [
    wbNiTransform('Skin Transform'),
    dfInteger('Num Bones', dtU32),
    wbNiRef('Skin Partition', 'NiSkinPartition', [DF_OnGetEnabled, @EnBefore10100]),
    dfInteger('Has Vertex Weights', dtU8, '1', [DF_OnGetEnabled, @EnSince4210]),
    dfArray('Bone List', dfStruct('Bone List', [
      wbNiTransform('Skin Transform'),
      wbVector3('Bounding Sphere Offset'),
      dfFloat('Bounding Sphere Radius'),
      dfInteger('Num Vertices', dtU16),
      dfArray('Vertex Weights', dfStruct('Vertex Weights', [
        dfInteger('Index', dtU16),
        dfFloat('Weight')
      ]), 0, 'Num Vertices', [DF_OnGetEnabled, @NiSkinData_EnVertexWeights])
    ]), 0, 'Num Bones', [])
  ]), 'NiObject', False);
end;

//===========================================================================
{ NiSkinPartition }
function NiSkinPartition_EnVertexData(const e: TdfElement): Boolean;
begin
  Result := enSSE(e) and (e.NativeValues['..\Data Size'] > 0);
  if Result then e.UserData := e.NativeValues['..\VertexDesc\VF']; // cache VF
 end;

procedure NiSkinPartition_GetCountVertexData(const e: TdfElement; var aCount: Integer);
begin
  aCount := e.NativeValues['..\Vertex Size'];
  if aCount > 0 then try aCount := e.NativeValues['..\Data Size'] / aCount; except aCount := 0; end;
end;

procedure NiSkinPartition_BeforeSaveDataSize(const e: TdfElement);
begin
  e.NativeValue := e.Elements['..\Vertex Data'].Count * e.NativeValues['..\Vertex Size'];
end;

procedure wbDefineNiSkinPartition;
begin
  wbNiObject(wbNifBlock('NiSkinPartition', [
    dfInteger('Num Partitions', dtU32),
    dfInteger('Data Size', dtU32, '1', [DF_OnGetEnabled, @EnSSE, DF_OnBeforeSave, @NiSkinPartition_BeforeSaveDataSize]),
    dfInteger('Vertex Size', dtU32, [DF_OnGetEnabled, @EnSSE]),
    wbVertexDesc('VertexDesc', [DF_OnGetEnabled, @EnSSE]),
    dfArray('Vertex Data', wbBSVertexData('Vertex Data'), 0, '', [
      DF_OnGetEnabled, @NiSkinPartition_EnVertexData,
      DF_OnGetCount, @NiSkinPartition_GetCountVertexData
    ]),
    dfArray('Partitions', wbSkinPartition('Partitions', []), 0, 'Num Partitions', [])
  ]), 'NiObject', False);
end;

//===========================================================================
{ NiCollisionObject }
procedure wbDefineNiCollisionObject;
begin
  wbNiObject(wbNifBlock('NiCollisionObject', [
    wbNiPtr('Target', 'NiAVObject')
  ]), 'NiObject', False);
end;

//===========================================================================
{ NiCollisionData * }
function NiCollisionData_EnBoundingVolume(const e: TdfElement): Boolean; begin Result := e.NativeValues['..\Use ABV'] = 1; end;

procedure wbDefineNiCollisionData;
begin
  wbNiObject(wbNifBlock('NiCollisionData', [
    wbPropagationMode('Propagation Mode', '', []),
    wbCollisionMode('Collision Mode', '', [DF_OnGetEnabled, @EnSince10100]),
    dfInteger('Use ABV', dtU8),
    wbBoundingVolume('Bounding Volume', [DF_OnGetEnabled, @NiCollisionData_EnBoundingVolume])
  ]), 'NiCollisionObject', False);
end;

//===========================================================================
{ bhkNiCollisionObject }
procedure wbDefinebhkNiCollisionObject;
begin
  wbNiObject(wbNifBlock('bhkNiCollisionObject', [
    wbbhkCOFlags('Flags', 'ACTIVE', []),
    wbNiPtr('Body', 'bhkWorldObject')
  ]), 'NiCollisionObject', True);
end;

//===========================================================================
{ bhkCollisionObject }
procedure wbDefinebhkCollisionObject;
begin
  wbNiObject(wbNifBlock('bhkCollisionObject'), 'bhkNiCollisionObject', False);
end;

//===========================================================================
{ bhkBlendCollisionObject }
function bhkBlendCollisionObject_EnUnknownFloat(const e: TdfElement): Boolean; begin Result := nif(e).UserVersion2 < 9; end;

procedure wbDefinebhkBlendCollisionObject;
begin
  wbNiObject(wbNifBlock('bhkBlendCollisionObject', [
    dfFloat('Heir Gain'),
    dfFloat('Val Gain'),
    dfFloat('Unknown Float 1', [DF_OnGetEnabled, @bhkBlendCollisionObject_EnUnknownFloat]),
    dfFloat('Unknown Float 2', [DF_OnGetEnabled, @bhkBlendCollisionObject_EnUnknownFloat])
  ]), 'bhkCollisionObject', False);
end;

//===========================================================================
{ bhkPCollisionObject }
procedure wbDefinebhkPCollisionObject;
begin
  wbNiObject(wbNifBlock('bhkPCollisionObject'), 'bhkCollisionObject', False);
end;

//===========================================================================
{ bhkSPCollisionObject }
procedure wbDefinebhkSPCollisionObject;
begin
  wbNiObject(wbNifBlock('bhkSPCollisionObject'), 'bhkPCollisionObject', False);
end;

//===========================================================================
{ bhkRefObject }
procedure wbDefinebhkRefObject;
begin
  wbNiObject(wbNifBlock('bhkRefObject'), 'NiObject', True);
end;

//===========================================================================
{ bhkSerializable }
procedure wbDefinebhkSerializable;
begin
  wbNiObject(wbNifBlock('bhkSerializable'), 'bhkRefObject', True);
end;

//===========================================================================
{ bhkWorldObject }
procedure wbDefinebhkWorldObject;
begin
  wbNiObject(wbNifBlock('bhkWorldObject', [
    wbNiRef('Shape', 'bhkShape'),
    wbHavokFilter('Havok Filter', []),
    dfBytes('Unused 1', 4),
    wbBroadPhaseType('Broad Phase Type', 'BROAD_PHASE_ENTITY', []),
    dfBytes('Unused 2', 3),
    wbhkWorldObjCinfoProperty('Cinfo Property', [])
  ]), 'bhkSerializable', True);
end;

//===========================================================================
{ bhkPhantom }
procedure wbDefinebhkPhantom;
begin
  wbNiObject(wbNifBlock('bhkPhantom'), 'bhkWorldObject', True);
end;

//===========================================================================
{ bhkShapePhantom }
procedure wbDefinebhkShapePhantom;
begin
  wbNiObject(wbNifBlock('bhkShapePhantom'), 'bhkPhantom', True);
end;

//===========================================================================
{ bhkSimpleShapePhantom }
procedure wbDefinebhkSimpleShapePhantom;
begin
  wbNiObject(wbNifBlock('bhkSimpleShapePhantom', [
    dfBytes('Unused 3', 8),
    wbMatrix44('Transform')
  ]), 'bhkShapePhantom', False);
end;

//===========================================================================
{ bhkAabbPhantom }
procedure wbDefinebhkAabbPhantom;
begin
  wbNiObject(wbNifBlock('bhkAabbPhantom', [
    dfBytes('Unused', 8),
    wbVector4('AABB Min'),
    wbVector4('AABB Max')
  ]), 'bhkShapePhantom', False);
end;

//===========================================================================
{ bhkEntity }
procedure wbDefinebhkEntity;
begin
  wbNiObject(wbNifBlock('bhkEntity'), 'bhkWorldObject', True);
end;

//===========================================================================
{ bhkRigidBody }
function bhkRigidBody_EnUserVersion2gt34(const e: TdfElement): Boolean; begin Result := nif(e).UserVersion2 > 34; end;
function bhkRigidBody_EnUserVersion2lte34(const e: TdfElement): Boolean; begin Result := nif(e).UserVersion2 <= 34; end;
function bhkRigidBody_DecideBodyFlags(const e: TdfElement): Integer; begin if nif(e).UserVersion2 < 76 then Result := 0 else Result := 1; end;

procedure wbDefinebhkRigidBody;
begin
  wbNiObject(wbNifBlock('bhkRigidBody', [
    wbhkResponseType('Collision Response', 'RESPONSE_SIMPLE_CONTACT', []),
    dfInteger('Unused Byte 1', dtU8),
    dfInteger('Process Contact Callback Delay', dtU16, '65535'),
    dfInteger('Unknown Int 1', dtU32),
    wbHavokFilter('Havok Filter Copy', []),
    dfBytes('Unused 3', 4),
    dfInteger('Unknown Int 2', dtU32, [DF_OnGetEnabled, @bhkRigidBody_EnUserVersion2gt34]),
    wbhkResponseType('Collision Response 2', 'RESPONSE_SIMPLE_CONTACT', []),
    dfInteger('Unused Byte 2', dtU8),
    dfInteger('Process Contact Callback Delay 2', dtU16, '65535'),
    dfInteger('Unknown Int 2', dtU32, [DF_OnGetEnabled, @bhkRigidBody_EnUserVersion2lte34]),
    wbVector4('Translation'),
    wbhkQuaternion('Rotation'),
    wbVector4('Linear Velocity'),
    wbVector4('Angular Velocity'),
    wbhkMatrix3('Inertia Tensor'),
    wbVector4('Center'),
    dfFloat('Mass', '1.0'),
    dfFloat('Linear Damping', '0.1'),
    dfFloat('Angular Damping', '0.05'),
    dfFloat('Time Factor', '1.0', [DF_OnGetEnabled, @bhkRigidBody_EnUserVersion2gt34]),
    dfFloat('Gravity Factor', '1.0', [DF_OnGetEnabled, @bhkRigidBody_EnUserVersion2gt34]),
    dfFloat('Friction', '0.5'),
    dfFloat('Rolling Friction Multiplier', '', [DF_OnGetEnabled, @bhkRigidBody_EnUserVersion2gt34]),
    dfFloat('Restitution', '0.4'),
    dfFloat('Max Linear Velocity', '104.4'),
    dfFloat('Max Angular Velocity', '31.57'),
    dfFloat('Penetration Depth', '0.15'),
    wbhkMotionType('Motion System', 'MO_SYS_DYNAMIC', []),
    wbhkDeactivatorType('Deactivator Type', 'DEACTIVATOR_NEVER', [DF_OnGetEnabled, @bhkRigidBody_EnUserVersion2lte34]),
    wbBool('Enable Deactivation', [DF_OnGetEnabled, @bhkRigidBody_EnUserVersion2gt34]),
    wbhkSolverDeactivation('Solver Deactivation', 'SOLVER_DEACTIVATION_OFF', []),
    wbhkQualityType('Motion Quality', 'MO_QUAL_FIXED', []),
    dfBytes('Unknown Bytes 1', 12),
    dfBytes('Unknown Bytes 2', 4, [DF_OnGetEnabled, @bhkRigidBody_EnUserVersion2gt34]),
    dfArray('Constraints', wbNiRef('Constraints', 'bhkSerializable'), -4, '', [DF_OnBeforeSave, @RemoveNoneLinks]),
    dfUnion([
      dfEnum('Body Flags', dtU32, [1, 'Respond to wind']),
      dfEnum('Body Flags', dtU16, [1, 'Respond to wind'])
    ], [DF_OnDecide, @bhkRigidBody_DecideBodyFlags])
  ]), 'bhkEntity', False);
end;

//===========================================================================
{ bhkRigidBodyT }
procedure wbDefinebhkRigidBodyT;
begin
  wbNiObject(wbNifBlock('bhkRigidBodyT'), 'bhkRigidBody', False);
end;

//===========================================================================
{ bhkConstraint }
procedure wbDefinebhkConstraint;
begin
  wbNiObject(wbNifBlock('bhkConstraint', [
    dfArray('Entities', wbNiPtr('Entities', 'bhkEntity'), -4, '', [DF_OnBeforeSave, @RemoveNoneLinks]),
    dfInteger('Priority', dtU32, '1')
  ]), 'bhkSerializable', True);
end;

//===========================================================================
{ bhkBreakableConstraint }
procedure wbDefinebhkBreakableConstraint;
begin
  wbNiObject(wbNifBlock('bhkBreakableConstraint', [
    wbConstraintData('Constraint Data', []),
    dfFloat('Threshold'),
    wbBool('Remove When Broken')
  ]), 'bhkConstraint', False);
end;

//===========================================================================
{ bhkBallAndSocketConstraint }
procedure wbDefinebhkBallAndSocketConstraint;
begin
  wbNiObject(wbNifBlock('bhkBallAndSocketConstraint', [
    wbBallAndSocketDescriptor('Ball and Socket', [])
  ]), 'bhkConstraint', False);
end;

//===========================================================================
{ bhkBallSocketConstraintChain }
procedure wbDefinebhkBallSocketConstraintChain;
begin
  wbNiObject(wbNifBlock('bhkBallSocketConstraintChain', [
    dfArray('Pivots', wbVector4('Pivots'), -4),
    dfFloat('Tau', '1.0'),
    dfFloat('Damping', '0.6'),
    dfFloat('Constraint Force Mixing', '0.0001'),
    dfFloat('Max Error Distance', '0.1'),
    dfArray('Entities A', wbNiPtr('Entities A', 'bhkRigidBody'), -4, '', [DF_OnBeforeSave, @RemoveNoneLinks]),
    dfInteger('Num Entities', dtU32, '2'),
    wbNiPtr('Entity A', 'bhkRigidBody'),
    wbNiPtr('Entity B', 'bhkRigidBody'),
    dfInteger('Priority', dtU32)
  ]), 'bhkSerializable', False);
end;

//===========================================================================
{ bhkHingeConstraint }
procedure wbDefinebhkHingeConstraint;
begin
  wbNiObject(wbNifBlock('bhkHingeConstraint', [
    wbHingeDescriptor('Hinge', [])
  ]), 'bhkConstraint', False);
end;

//===========================================================================
{ bhkLimitedHingeConstraint }
procedure wbDefinebhkLimitedHingeConstraint;
begin
  wbNiObject(wbNifBlock('bhkLimitedHingeConstraint', [
    wbLimitedHingeDescriptor('Limited Hinge', [])
  ]), 'bhkConstraint', False);
end;

//===========================================================================
{ bhkMalleableConstraint }
procedure wbDefinebhkMalleableConstraint;
begin
  wbNiObject(wbNifBlock('bhkMalleableConstraint', [
    wbMalleableDescriptor('Hinge', [])
  ]), 'bhkConstraint', False);
end;

//===========================================================================
{ bhkPrismaticConstraint }
procedure wbDefinebhkPrismaticConstraint;
begin
  wbNiObject(wbNifBlock('bhkPrismaticConstraint', [
    wbPrismaticDescriptor('Prismatic', [])
  ]), 'bhkConstraint', False);
end;

//===========================================================================
{ bhkRagdollConstraint }
procedure wbDefinebhkRagdollConstraint;
begin
  wbNiObject(wbNifBlock('bhkRagdollConstraint', [
    wbRagdollDescriptor('Ragdoll', [])
  ]), 'bhkConstraint', False);
end;

//===========================================================================
{ bhkStiffSpringConstraint }
procedure wbDefinebhkStiffSpringConstraint;
begin
  wbNiObject(wbNifBlock('bhkStiffSpringConstraint', [
    wbStiffSpringDescriptor('Stiff Spring', [])
  ]), 'bhkConstraint', False);
end;

//===========================================================================
{ bhkShape }
procedure wbDefinebhkShape;
begin
  wbNiObject(wbNifBlock('bhkShape'), 'bhkSerializable', True);
end;

//===========================================================================
{ bhkPlaneShape }
procedure wbDefinebhkPlaneShape;
begin
  wbNiObject(wbNifBlock('bhkPlaneShape', [
    wbHavokMaterial('Material', '', []),
    wbVector3('Unknown'),
    wbVector3('Direction'),
    dfFloat('Constant'),
    wbVector4('Half Extents'),
    wbVector4('Center')
  ]), 'bhkShape', False);
end;

//===========================================================================
{ bhkSphereRepShape }
procedure wbDefinebhkSphereRepShape;
begin
  wbNiObject(wbNifBlock('bhkSphereRepShape', [
    wbHavokMaterial('Material', '', []),
    dfFloat('Radius')
  ]), 'bhkShape', True);
end;

//===========================================================================
{ bhkTransformShape }
procedure wbDefinebhkTransformShape;
begin
  wbNiObject(wbNifBlock('bhkTransformShape', [
    wbNiRef('Shape', 'bhkShape'),
    wbHavokMaterial('Material', '', []),
    dfFloat('Radius'),
    dfBytes('Unused', 8),
    wbMatrix44('Transform')
  ]), 'bhkShape', False);
end;

//===========================================================================
{ bhkConvexShape }
procedure wbDefinebhkConvexShape;
begin
  wbNiObject(wbNifBlock('bhkConvexShape'), 'bhkSphereRepShape', True);
end;

//===========================================================================
{ bhkConvexListShape }
procedure wbDefinebhkConvexListShape;
begin
  wbNiObject(wbNifBlock('bhkConvexListShape', [
    dfArray('Sub Shapes', wbNiRef('Sub Shapes', 'bhkConvexShape'), -4, '', [DF_OnBeforeSave, @RemoveNoneLinks]),
    wbHavokMaterial('Material', '', []),
    dfFloat('Radius'),
    dfInteger('Unknown Int 1', dtU32),
    dfFloat('Unknown Float 1'),
    wbhkWorldObjCinfoProperty('Child Shape Property', []),
    dfInteger('Unknown Byte 1', dtU8),
    dfFloat('Unknown Float 2')
  ]), 'bhkShape', False);
end;

//===========================================================================
{ bhkConvexTransform }
procedure wbDefinebhkConvexTransformShape;
begin
  wbNiObject(wbNifBlock('bhkConvexTransformShape'), 'bhkTransformShape', False);
end;

//===========================================================================
{ bhkSphereShape }
procedure wbDefinebhkSphereShape;
begin
  wbNiObject(wbNifBlock('bhkSphereShape'), 'bhkConvexShape', False);
end;

//===========================================================================
{ bhkMultiSphereShape }
procedure wbDefinebhkMultiSphereShape;
begin
  wbNiObject(wbNifBlock('bhkMultiSphereShape', [
    dfFloat('Unknown Float 1'),
    dfFloat('Unknown Float 2'),
    dfArray('Spheres', wbNiBound('Spheres'), -4)
  ]), 'bhkSphereShape', False);
end;

//===========================================================================
{ bhkBoxShape }
procedure wbDefinebhkBoxShape;
begin
  wbNiObject(wbNifBlock('bhkBoxShape', [
    dfBytes('Unused', 8),
    wbVector3('Dimensions'),
    dfFloat('Unused Float')
  ]), 'bhkConvexShape', False);
end;

//===========================================================================
{ bhkCapsuleShape }
procedure wbDefinebhkCapsuleShape;
begin
  wbNiObject(wbNifBlock('bhkCapsuleShape', [
    dfBytes('Unused', 8),
    wbVector3('First Point'),
    dfFloat('Radius 1'),
    wbVector3('Second Point'),
    dfFloat('Radius 2')
  ]), 'bhkConvexShape', False);
end;

//===========================================================================
{ bhkConvexVerticesShape }
procedure wbDefinebhkConvexVerticesShape;
begin
  wbNiObject(wbNifBlock('bhkConvexVerticesShape', [
    wbhkWorldObjCinfoProperty('Vertices Property', []),
    wbhkWorldObjCinfoProperty('Normals Property', []),
    dfArray('Vertices', wbVector4('Vertices'), -4),
    dfArray('Normals', wbVector4('Normals'), -4)
  ]), 'bhkConvexShape', False);
end;

//===========================================================================
{ bhkCompressedMeshShape }
procedure wbDefinebhkCompressedMeshShape;
begin
  wbNiObject(wbNifBlock('bhkCompressedMeshShape', [
    wbNiPtr('Target', 'NiAVObject'),
    dfInteger('User Data', dtU32),
    dfFloat('Radius', '0.005'),
    dfFloat('Unknown Float 1'),
    wbVector4('Scale'),
    dfFloat('Radius Copy', '0.005'),
    wbVector4('Scale Copy'),
    wbNiRef('Data', 'bhkCompressedMeshShapeData')
  ]), 'bhkShape', False);
end;

//===========================================================================
{ bhkCompressedMeshShapeData }
procedure wbDefinebhkCompressedMeshShapeData;
begin
  wbNiObject(wbNifBlock('bhkCompressedMeshShapeData', [
    dfInteger('Bits Per Index', dtU32),
    dfInteger('Bits Per W Index', dtU32),
    dfInteger('Mask W Index', dtU32),
    dfInteger('Mask Index', dtU32),
    dfFloat('Error'),
    wbVector4('Bounds Min'),
    wbVector4('Bounds Max'),
    dfInteger('Wielding Type', dtU8),
    dfInteger('Material Type', dtU8),
    dfArray('Materials 32', dfInteger('Materials', dtU32), -4),
    dfArray('Materials 16', dfInteger('Materials', dtU32), -4),
    dfArray('Materials 8', dfInteger('Materials', dtU32), -4),
    dfArray('Chunk Materials', wbbhkCMSDMaterial('Chunk Materials', []), -4),
    dfInteger('Num Named Materials', dtU32),
    dfArray('Chunk Transforms', wbbhkCMSDTransform('Chunk Transforms', []), -4),
    dfArray('Big Verts', wbVector4('Big Verts'), -4),
    dfArray('Big Tris', wbbhkCMSDBigTris('Big Tris', []), -4),
    dfArray('Chunks', wbbhkCMSDChunk('Chunks', []), -4),
    dfInteger('Num Convex Piece A', dtU32)
  ]), 'bhkRefObject', False);
end;

//===========================================================================
{ bhkBvTreeShape }
procedure wbDefinebhkBvTreeShape;
begin
  wbNiObject(wbNifBlock('bhkBvTreeShape'), 'bhkShape', True);
end;

//===========================================================================
{ bhkMoppBvTreeShape }
function bhkMoppBvTreeShape_EnBuildType(const e: TdfElement): Boolean; begin Result := nif(e).UserVersion2 > 34; end;

procedure bhkMoppBvTreeShape_GetSizeMOPP(const e: TdfElement; var aCount: Integer);
begin
  aCount := e.NativeValues['..\MOPP Data Size'];
  if (nif(e).Version <= v10010) and (aCount > 0) then Dec(aCount);
end;

procedure bhkMoppBvTreeShape_BeforeSaveMOPPDataSize(const e: TdfElement);
var
  size: Cardinal;
begin
  size := e.Elements['..\MOPP Data'].DataSize;
  if (nif(e).Version <= v10010) and (size > 0) then Dec(size);
  e.NativeValue := size;
end;

procedure wbDefinebhkMoppBvTreeShape;
begin
  wbNiObject(wbNifBlock('bhkMoppBvTreeShape', [
    wbNiRef('Shape', 'bhkShape'),
    dfBytes('Unused', 12),
    dfFloat('Shape Scale', '1.0'),
    dfInteger('MOPP Data Size', dtU32, [DF_OnBeforeSave, @bhkMoppBvTreeShape_BeforeSaveMOPPDataSize]),
    wbVector3('Origin'),
    dfFloat('Scale'),
    wbMOPPDataBuildType('Build Type', '', [DF_OnGetEnabled, @bhkMoppBvTreeShape_EnBuildType]),
    dfBytes('MOPP Data', 0, [DF_OnGetCount, @bhkMoppBvTreeShape_GetSizeMOPP])
  ]), 'bhkBvTreeShape', False);
end;

//===========================================================================
{ bhkShapeCollection }
procedure wbDefinebhkShapeCollection;
begin
  wbNiObject(wbNifBlock('bhkShapeCollection'), 'bhkShape', True);
end;

//===========================================================================
{ bhkListShape }
procedure wbDefinebhkListShape;
begin
  wbNiObject(wbNifBlock('bhkListShape', [
    dfArray('Sub Shapes', wbNiRef('Sub Shapes', 'bhkShape'), -4, '', [DF_OnBeforeSave, @RemoveNoneLinks]),
    wbHavokMaterial('Material', '', []),
    wbhkWorldObjCinfoProperty('Child Shape Property', []),
    wbhkWorldObjCinfoProperty('Child Filter Property', []),
    dfArray('Unknown Ints', dfInteger('Unknown Ints', dtU32), -4)
  ]), 'bhkShapeCollection', False);
end;

//===========================================================================
{ bhkMeshShape * }
procedure wbDefinebhkMeshShape;
begin
  wbNiObject(wbNifBlock('bhkMeshShape', [
    dfArray('Unknown 1', dfFloat('Unknown 1'), 9),
    dfArray('Unknown Floats', dfArray('Unknown Floats', dfFloat('Unknown'), 3), -4),
    dfArray('Unknown 2', dfInteger('Unknown 1', dtU32), 3),
    dfArray('Strips Data', wbNiRef('Strips Data', 'NiTriStripsData'), -4, '', [
      DF_OnGetEnabled, @EnBefore10010,
      DF_OnBeforeSave, @RemoveNoneLinks
    ])
  ]), 'bhkShape', False);
end;

//===========================================================================
{ bhkNiTriStripsShape }
procedure wbDefinebhkNiTriStripsShape;
begin
  wbNiObject(wbNifBlock('bhkNiTriStripsShape', [
    wbHavokMaterial('Material', '', []),
    dfFloat('Radius', '0.1'),
    dfArray('Unused', dfInteger('Unused', dtU32), 5),
    dfInteger('Grow By', dtU32, '1'),
    wbVector4('Scale'),
    dfArray('Strips Data', wbNiRef('Strips Data', 'NiTriStripsData'), -4, '', [DF_OnBeforeSave, @RemoveNoneLinks]),
    dfArray('Data Layers', wbHavokFilter('Data Layers', []), -4)
  ]), 'bhkShapeCollection', False);
end;

//===========================================================================
{ hkPackedNiTriStripsData }
procedure wbDefinehkPackedNiTriStripsData;
begin
  wbNiObject(wbNifBlock('hkPackedNiTriStripsData', [
    dfArray('Triangles', dfStruct('Triangles', [
      wbTriangle('Triangle'),
      dfInteger('Welding Info', dtU16),
      wbVector3('Normal', [DF_OnGetEnabled, @EnBefore20005])
    ]), -4),
    dfInteger('Num Vertices', dtU32),
    dfInteger('Unknown Byte 1', dtU8, [DF_OnGetEnabled, @EnSince20207]),
    dfArray('Vertices', wbVector3('Vertices'), 0, 'Num Vertices', []),
    dfArray('Sub Shapes', wbOblivionSubShape('Sub Shapes', []), -2, '', [DF_OnGetEnabled, @EnSince20207])
  ]), 'bhkShapeCollection', False);
end;

//===========================================================================
{ bhkPackedNiTriStripsShape }
procedure wbDefinebhkPackedNiTriStripsShape;
begin
  wbNiObject(wbNifBlock('bhkPackedNiTriStripsShape', [
    dfArray('Sub Shapes', wbOblivionSubShape('Sub Shapes', []), -2, '', [DF_OnGetEnabled, @EnBefore20005]),
    dfInteger('User Data', dtU32),
    dfInteger('Unused 1', dtU32),
    dfFloat('Radius', '0.1'),
    dfInteger('Unused 2', dtU32),
    wbVector4('Scale'),
    dfFloat('Radius Copy', '0.1'),
    wbVector4('Scale Copy'),
    wbNiRef('Data', 'hkPackedNiTriStripsData')
  ]), 'bhkShapeCollection', False);
end;

//===========================================================================
{ bhkLiquidAction }
procedure wbDefinebhkLiquidAction;
begin
  wbNiObject(wbNifBlock('bhkLiquidAction', [
    dfInteger('User Data', dtU32),
    dfInteger('Unknown Int 2', dtU32),
    dfInteger('Unknown Int 3', dtU32),
    dfFloat('Initial Stick Force'),
    dfFloat('Stick Strength'),
    dfFloat('Neighbor Distance'),
    dfFloat('Neighbor Strength')
  ]), 'bhkSerializable', False);
end;

//===========================================================================
{ bhkOrientHingedBodyAction }
procedure wbDefinebhkOrientHingedBodyAction;
begin
  wbNiObject(wbNifBlock('bhkOrientHingedBodyAction', [
    wbNiPtr('Body', 'bhkRigidBody'),
    dfInteger('Unknown Int 1', dtU32),
    dfInteger('Unknown Int 2', dtU32),
    dfBytes('Unused 1', 8),
    wbVector4('Hinge Axis LS'),
    wbVector4('Forward LS'),
    dfFloat('Strength'),
    dfFloat('Damping'),
    dfBytes('Unused 2', 8)
  ]), 'bhkSerializable', False);
end;

//===========================================================================
{ bhkPoseArray }
procedure wbDefinebhkPoseArray;
begin
  wbNiObject(wbNifBlock('bhkPoseArray', [
    dfArray('Bones', wbString('Bones'), -4),
    dfArray('Poses',
      dfArray('Transforms', dfStruct('Transforms', [
        wbVector3('Translation'),
        wbhkQuaternion('Rotation'),
        wbVector3('Scale')
      ]), -4)
    , -4)
  ]), 'NiObject', False);
end;

//===========================================================================
{ bhkRagdollTemplate }
procedure wbDefinebhkRagdollTemplate;
begin
  wbNiObject(wbNifBlock('bhkRagdollTemplate', [
    dfArray('Bones', wbNiRef('Bones', 'NiObject'), -4, '', [DF_OnBeforeSave, @RemoveNoneLinks])
  ]), 'NiExtraData', False);
end;

//===========================================================================
{ bhkRagdollTemplateData }
procedure wbDefinebhkRagdollTemplateData;
begin
  wbNiObject(wbNifBlock('bhkRagdollTemplateData', [
    wbString('Name'),
    dfFloat('Mass', '9.0'),
    dfFloat('Restitution', '0.8'),
    dfFloat('Friction', '0.3'),
    dfFloat('Radius', '1.0'),
    wbHavokMaterial('Material', '', []),
    dfArray('Constraint Data', wbConstraintData('Constraint Data', []), -4)
  ]), 'NiObject', False);
end;

//===========================================================================
{ bhkSystem }
procedure wbDefinebhkSystem;
begin
  wbNiObject(wbNifBlock('bhkSystem'), 'NiObject', True);
end;

//===========================================================================
{ bhkNPCollisiobObject }
procedure wbDefinebhkNPCollisionObject;
begin
  wbNiObject(wbNifBlock('bhkNPCollisionObject', [
    dfInteger('Flags', dtU16),
    wbNiRef('Data', 'bhkSystem'),
    dfInteger('Body ID', dtU32)
  ]), 'NiCollisionObject', False);
end;

//===========================================================================
{ bhkPhysicsSystem }
procedure wbDefinebhkPhysicsSystem;
begin
  wbNiObject(wbNifBlock('bhkPhysicsSystem', [
    wbByteArray('Binary Data')
  ]), 'bhkSystem', False);
end;

//===========================================================================
{ bhkRagdollSystem }
procedure wbDefinebhkRagdollSystem;
begin
  wbNiObject(wbNifBlock('bhkRagdollSystem', [
    wbByteArray('Binary Data')
  ]), 'bhkSystem', False);
end;

//===========================================================================
{ NiDynamicEffect }
function NiDynamicEffect_EnSwitchState(const e: TdfElement): Boolean; begin with nif(e) do Result := (Version >= v1010106) and (UserVersion2 < 130); end;
function NiDynamicEffect_EnNodes(const e: TdfElement): Boolean; begin with nif(e) do Result := (Version >= v10100) and (UserVersion2 < 130); end;

procedure wbDefineNiDynamicEffect;
begin
  wbNiObject(wbNifBlock('NiDynamicEffect', [
    wbBool('Switch State', '1', [DF_OnGetEnabled, @NiDynamicEffect_EnSwitchState]),
    dfArray('Affected Node Pointers', dfInteger('Pointer', dtU32), -4, '', [DF_OnGetEnabled, @EnBefore4002]),
    dfArray('Affected Nodes', wbNiPtr('Node', 'NiNode'), -4, '', [
      DF_OnGetEnabled, @NiDynamicEffect_EnNodes,
      DF_OnBeforeSave, @RemoveNoneLinks
    ])
  ]), 'NiAVObject', True);
end;

//===========================================================================
{ NiLight }
procedure wbDefineNiLight;
begin
  wbNiObject(wbNifBlock('NiLight', [
    dfFloat('Dimmer', '1.0'),
    wbColor3('Ambient Color', '#000000', []),
    wbColor3('Diffuse Color', '#000000', []),
    wbColor3('Specular Color', '#000000', [])
  ]), 'NiDynamicEffect', True);
end;

//===========================================================================
{ NiAmbientLight }
procedure wbDefineNiAmbientLight;
begin
  wbNiObject(wbNifBlock('NiAmbientLight'), 'NiLight', False);
end;

//===========================================================================
{ NiDirectionalLight }
procedure wbDefineNiDirectionalLight;
begin
  wbNiObject(wbNifBlock('NiDirectionalLight'), 'NiLight', False);
end;

//===========================================================================
{ NiPointLight }
procedure wbDefineNiPointLight;
begin
  wbNiObject(wbNifBlock('NiPointLight', [
    dfFloat('Constant Attenuation'),
    dfFloat('Linear Attenuation', '1.0'),
    dfFloat('Quadratic Attenuation')
  ]), 'NiLight', False);
end;

//===========================================================================
{ NiSpotLight * }
procedure wbDefineNiSpotLight;
begin
  wbNiObject(wbNifBlock('NiSpotLight', [
    dfFloat('Outer Spot Angle'),
    dfFloat('Inner Spot Angle', [DF_OnGetEnabled, @EnSince20205]),
    dfFloat('Exponent', '1.0')
  ]), 'NiPointLight', False);
end;

//===========================================================================
{ NiTextureEffect }
procedure wbDefineNiTextureEffect;
begin
  wbNiObject(wbNifBlock('NiTextureEffect', [
    wbMatrix33('Model Projection Matrix'),
    wbVector3('Model Projection Transform'),
    wbTexFilterMode('Texture Filtering', 'FILTER_TRILERP', []),
    wbTexClampMode('Texture Clamping', 'WRAP_S_WRAP_T', []),
    wbTextureType('Texture Type', 'TEX_ENVIRONMENT_MAP', []),
    wbCoordGenType('Coordinate Generation Type', 'CG_SPHERE_MAP', []),
    wbNiRef('Source Texture', 'NiSourceTexture'),
    dfInteger('Enable Plane', dtU8),
    wbNiPlane('Plane'),
    dfInteger('PS2 L', dtS16, '0', [DF_OnGetEnabled, @EnBefore10200]),
    dfInteger('PS2 K', dtS16, '-75', [DF_OnGetEnabled, @EnBefore10200]),
    dfInteger('Unknown Short', dtU16, [DF_OnGetEnabled, @EnBefore41012])
  ]), 'NiDynamicEffect', False);
end;

//===========================================================================
{ NiBoolData }
procedure wbDefineNiBoolData;
begin
  wbNiObject(wbNifBlock('NiBoolData', [
    wbKeyGroup('Data', 'byte', [])
  ]), 'NiObject', False);
end;

//===========================================================================
{ NiColorData }
procedure wbDefineNiColorData;
begin
  wbNiObject(wbNifBlock('NiColorData', [
    wbKeyGroup('Data', 'color4', [])
  ]), 'NiObject', False);
end;

//===========================================================================
{ NiFloatData }
procedure wbDefineNiFloatData;
begin
  wbNiObject(wbNifBlock('NiFloatData', [
    wbKeyGroup('Data', 'float', [])
  ]), 'NiObject', False);
end;

//===========================================================================
{ NiMorphData }
function NiMorphData_EnForward(const e: TdfElement): Boolean; begin Result := e.NativeValues['..\..\..\Interpolation'] = 2; end;
function NiMorphData_EnTBC(const e: TdfElement): Boolean; begin Result := e.NativeValues['..\..\..\Interpolation'] = 3; end;
function NiMorphData_EnLegacyWeight(const e: TdfElement): Boolean; begin with nif(e) do Result := (Version >= v1010106) and (Version <= v20102) and (UserVersion2 < 10); end;

procedure wbDefineNiMorphData;
begin
  wbNiObject(wbNifBlock('NiMorphData', [
    dfInteger('Num Morphs', dtU32),
    dfInteger('Num Vertices', dtU32),
    dfInteger('Relative Targets', dtU8, '1'),
    dfArray('Morphs', dfStruct('Morphs', [
      wbString('Frame Name', [DF_OnGetEnabled, @EnSince1010106]),
      dfInteger('Num Keys', dtU32, [DF_OnGetEnabled, @EnBefore10100]),
      wbKeyType('Interpolation', '', [DF_OnGetEnabled, @EnBefore10100]),
      dfArray('Keys', dfStruct('Keys', [
        dfFloat('Time'),
        dfFloat('Value'),
        dfFloat('Forward', [DF_OnGetEnabled, @NiMorphData_EnForward]),
        dfFloat('Backward', [DF_OnGetEnabled, @NiMorphData_EnForward]),
        wbTBC('TBC', [DF_OnGetEnabled, @NiMorphData_EnTBC])
      ]), 0, 'Num Keys', [DF_OnGetEnabled, @EnBefore10100]),
      dfFloat('Legacy Weight', [DF_OnGetEnabled, @NiMorphData_EnLegacyWeight]),
      dfArray('Vectors', wbVector3('Vectors'), 0, '..\..\Num Vertices', [])
    ]), 0, 'Num Morphs', [])
  ]), 'NiObject', False);
end;

//===========================================================================
{ NiPosData }
function NiPosData_EnInterpolation(const e: TdfElement): Boolean; begin Result := e.NativeValues['..\Num Keys'] <> 0; end;
function NiPosData_EnForward(const e: TdfElement): Boolean; begin Result := nifblk(e).NativeValues['Interpolation'] = 2; end;
function NiPosData_EnTBC(const e: TdfElement): Boolean; begin Result := nifblk(e).NativeValues['Interpolation'] = 3; end;

procedure wbDefineNiPosData;
begin
  wbNiObject(wbNifBlock('NiPosData', [
    dfInteger('Num Keys', dtU32),
    wbKeyType('Interpolation', '', [DF_OnGetEnabled, @NiPosData_EnInterpolation]),
    dfArray('Keys', dfStruct('Keys', [
      dfFloat('Time'),
      wbVector3('Value'),
      wbVector3('Forward', [DF_OnGetEnabled, @NiPosData_EnForward]),
      wbVector3('Backward', [DF_OnGetEnabled, @NiPosData_EnForward]),
      wbTBC('TBC', [DF_OnGetEnabled, @NiPosData_EnTBC])
    ]), 0, 'Num Keys', [])
  ]), 'NiObject', False);
end;

//===========================================================================
{ NiUVData }
procedure wbDefineNiUVData;
begin
  wbNiObject(wbNifBlock('NiUVData', [
    dfArray('UV Groups', wbKeyGroup('UV Groups', 'float', []), 4)
  ]), 'NiObject', False);
end;


//===========================================================================
{ NiVISData }
procedure wbDefineNiVISData;
begin
  wbNiObject(wbNifBlock('NiVISData', [
    dfArray('Keys', dfStruct('Keys', [
      dfFloat('Time'),
      dfInteger('Value', dtU8)
    ]), -4, '', [])
  ]), 'NiObject', False);
end;

//===========================================================================
{ ATextureRenderData }
procedure wbDefineATextureRenderData;
begin
  wbNiObject(wbNifBlock('ATextureRenderData', [
    wbPixelFormat('Pixel Format', '', []),
    dfInteger('Red Mask', dtU32, [DF_OnGetEnabled, @EnBefore10200]),
    dfInteger('Green Mask', dtU32, [DF_OnGetEnabled, @EnBefore10200]),
    dfInteger('Blue Mask', dtU32, [DF_OnGetEnabled, @EnBefore10200]),
    dfInteger('Alpha Mask', dtU32, [DF_OnGetEnabled, @EnBefore10200]),
    dfInteger('Bits Per Pixel', dtU8, [DF_OnGetEnabled, @EnBefore10200]),
    dfBytes('Unknown 3 Bytes', 3, [DF_OnGetEnabled, @EnBefore10200]),
    dfBytes('Unknown 8 Bytes', 8, [DF_OnGetEnabled, @EnBefore10200]),
    dfInteger('Bits Per Pixel', dtU8, [DF_OnGetEnabled, @EnSince20004]),
    dfInteger('Unknown Int 2', dtS32, [DF_OnGetEnabled, @EnSince20004]),
    dfInteger('Unknown Int 3', dtU32, [DF_OnGetEnabled, @EnSince20004]),
    dfInteger('Flags', dtU8, [DF_OnGetEnabled, @EnSince20004]),
    dfInteger('Unknown Int 4', dtU32, [DF_OnGetEnabled, @EnSince20004]),
    dfArray('Channels', dfStruct('Channels', [
      wbChannelType('Type', '', []),
      wbChannelConvention('Convention', '', []),
      dfInteger('Bits Per Channel', dtU8),
      dfInteger('Is Signed', dtU8)
    ]), 4, '', [DF_OnGetEnabled, @EnSince20004]),
    wbNiRef('Palette', 'NiPalette'),
    dfInteger('Num Mipmaps', dtU32),
    dfInteger('Bytes Per Pixel', dtU32),
    dfArray('Mipmaps', dfStruct('Mipmaps', [
      dfInteger('Width', dtU32),
      dfInteger('Height', dtU32),
      dfInteger('Offset', dtU32)
    ]), 0, 'Num Mipmaps', [])
  ]), 'NiObject', True);
end;

//===========================================================================
{ NiPixelData }
procedure NiPixelData_GetNumPixels(const e: TdfElement; var aCount: Integer); begin aCount := e.NativeValues['..\..\Num Pixels']; end;
procedure NiPixelData_GetNumFaces(const e: TdfElement; var aCount: Integer); begin aCount := e.NativeValues['..\Num Faces']; if aCount = 0 then aCount := 1; end;

procedure wbDefineNiPixelData;
begin
  wbNiObject(wbNifBlock('NiPixelData', [
    dfInteger('Num Pixels', dtU32),
    dfInteger('Num Faces', dtU32, [DF_OnGetEnabled, @EnSince20004]),
    dfArray('Pixel Data', dfBytes('Pixel Data', 0, [DF_OnGetCount, @NiPixelData_GetNumPixels]), 0, '', [DF_OnGetCount, @NiPixelData_GetNumFaces])
  ]), 'ATextureRenderData', False);
end;

//===========================================================================
{ NiInterpolator }
procedure wbDefineNiInterpolator;
begin
  wbNiObject(wbNifBlock('NiInterpolator'), 'NiObject', True);
end;

//===========================================================================
{ NiKeyBasedInterpolator }
procedure wbDefineNiKeyBasedInterpolator;
begin
  wbNiObject(wbNifBlock('NiKeyBasedInterpolator'), 'NiInterpolator', True);
end;

//===========================================================================
{ NiFloatInterpolator }
procedure wbDefineNiFloatInterpolator;
begin
  wbNiObject(wbNifBlock('NiFloatInterpolator', [
    dfFloat('Pose Value', 'Min'),
    wbNiRef('Data', 'NiFloatData')
  ]), 'NiKeyBasedInterpolator', False);
end;

//===========================================================================
{ NiTransformInterpolator }
procedure wbDefineNiTransformInterpolator;
begin
  wbNiObject(wbNifBlock('NiTransformInterpolator', [
    wbNiQuatTransform('Transform'),
    dfBytes('Unknown Bytes', 3, [DF_OnGetEnabled, @En1010106]),
    wbNiRef('Data', 'NiTransformData')
  ]), 'NiKeyBasedInterpolator', False);
end;

//===========================================================================
{ NiPoint3Interpolator }
procedure wbDefineNiPoint3Interpolator;
begin
  wbNiObject(wbNifBlock('NiPoint3Interpolator', [
    wbVector3('Pose Value', 'Min Min Min', []),
    wbNiRef('Data', 'NiPosData')
  ]), 'NiKeyBasedInterpolator', False);
end;

//===========================================================================
{ NiPathInterpolator }
procedure wbDefineNiPathInterpolator;
begin
  wbNiObject(wbNifBlock('NiPathInterpolator', [
    wbPathFlags('Flags', '3', []),
    dfInteger('Bank Dir', dtU32, '1'),
    dfFloat('Max Bank Angle'),
    dfFloat('Smoothing'),
    dfInteger('Follow Axis', dtU16),
    wbNiRef('Path Data', 'NiPosData'),
    wbNiRef('Percent Data', 'NiFloatData')
  ]), 'NiKeyBasedInterpolator', False);
end;

//===========================================================================
{ NiBoolInterpolator }
procedure wbDefineNiBoolInterpolator;
begin
  wbNiObject(wbNifBlock('NiBoolInterpolator', [
    wbBool('Value', '2', []),
    wbNiRef('Data', 'NiBoolData')
  ]), 'NiKeyBasedInterpolator', False);
end;

//===========================================================================
{ NiBoolTimelineInterpolator }
procedure wbDefineNiBoolTimelineInterpolator;
begin
  wbNiObject(wbNifBlock('NiBoolTimelineInterpolator'), 'NiBoolInterpolator', False);
end;

//===========================================================================
{ NiBlendInterpolator }
function NiBlendInterpolator_EnData(const e: TdfElement): Boolean; begin Result := e.NativeValues['..\Flags'] and 1 = 0; end;

procedure wbDefineNiBlendInterpolator;
begin
  wbNiObject(wbNifBlock('NiBlendInterpolator', [
    wbInterpBlendFlags('Flags', '', []),
    dfInteger('Array Size', dtU8),
    dfFloat('Weight Threshold'),
    dfStruct('Interpolator Data', [
      dfInteger('Interp Count', dtU8),
      dfInteger('Single Index', dtU8, '255'),
      dfInteger('High Priority', dtS8, '-128'),
      dfInteger('Next High Priority', dtS8, '-128'),
      dfFloat('Single Time', 'Min'),
      dfFloat('High Weighs Sum', 'Min'),
      dfFloat('Next High Weighs Sum', 'Min'),
      dfFloat('Next Ease Spinner', 'Min'),
      dfArray('Interp Array Items', dfStruct('Interp Array Items', [
        wbNiRef('Interpolator', 'NiInterplator'),
        dfFloat('Weight'),
        dfFloat('Normalized Weight'),
        dfInteger('Priority', dtU8),
        dfFloat('Ease Spinner')
      ]), 0, '..\Array Size', [])
    ], [DF_OnGetEnabled, @NiBlendInterpolator_EnData])
  ]), 'NiInterpolator', False);
end;

//===========================================================================
{ NiBlendBoolInterpolator }
procedure wbDefineNiBlendBoolInterpolator;
begin
  wbNiObject(wbNifBlock('NiBlendBoolInterpolator', [
    dfInteger('Bool Value', dtU8)
  ]), 'NiBlendInterpolator', False);
end;

//===========================================================================
{ NiBlendFloatInterpolator }
procedure wbDefineNiBlendFloatInterpolator;
begin
  wbNiObject(wbNifBlock('NiBlendFloatInterpolator', [
    dfFloat('Float Value')
  ]), 'NiBlendInterpolator', False);
end;

//===========================================================================
{ NiBlendPoint3Interpolator }
procedure wbDefineNiBlendPoint3Interpolator;
begin
  wbNiObject(wbNifBlock('NiBlendPoint3Interpolator', [
    wbVector3('Point Value')
  ]), 'NiBlendInterpolator', False);
end;

//===========================================================================
{ NiBlendTransformInterpolator }
procedure wbDefineNiBlendTransformInterpolator;
begin
  wbNiObject(wbNifBlock('NiBlendTransformInterpolator'), 'NiBlendInterpolator', False);
end;

//===========================================================================
{ NiLookAtInterpolator }
procedure wbDefineNiLookAtInterpolator;
begin
  wbNiObject(wbNifBlock('NiLookAtInterpolator', [
    wbLookAtFlags('Flags', '', []),
    wbNiPtr('Look At', 'NiNode'),
    wbString('Look At Name'),
    wbNiQuatTransform('Transform'),
    wbNiRef('Interpolator: Translation', 'NiPoint3Interpolator'),
    wbNiRef('Interpolator: Roll', 'NiFloatInterpolator'),
    wbNiRef('Interpolator: Scale', 'NiFloatInterpolator')
  ]), 'NiInterpolator', False);
end;

//===========================================================================
{ NiBSplineInterpolator }
procedure wbDefineNiBSplineInterpolator;
begin
  wbNiObject(wbNifBlock('NiBSplineInterpolator', [
    dfFloat('Start Time', 'Min'),
    dfFloat('Stop Time', 'Min'),
    wbNiRef('Spline Data', 'NiBSplineData'),
    wbNiRef('Basis Data', 'NiBSplineBasisData')
  ]), 'NiInterpolator', True);
end;

//===========================================================================
{ NiBSplineFloatInterpolator }
procedure wbDefineNiBSplineFloatInterpolator;
begin
  wbNiObject(wbNifBlock('NiBSplineFloatInterpolator', [
    dfFloat('Value'),
    dfInteger('Handle', dtU32)
  ]), 'NiBSplineInterpolator', True);
end;

//===========================================================================
{ NiBSplineCompFloatInterpolator }
procedure wbDefineNiBSplineCompFloatInterpolator;
begin
  wbNiObject(wbNifBlock('NiBSplineCompFloatInterpolator', [
    dfFloat('Float Offset'),
    dfFloat('Float Half Range')
  ]), 'NiBSplineFloatInterpolator', False);
end;

//===========================================================================
{ NiBSplinePoint3Interpolator }
procedure wbDefineNiBSplinePoint3Interpolator;
begin
  wbNiObject(wbNifBlock('NiBSplinePoint3Interpolator', [
    wbVector3('Value'),
    dfInteger('Handle', dtU32, '65535')
  ]), 'NiBSplineInterpolator', True);
end;

//===========================================================================
{ NiBSplineCompPoint3Interpolator }
procedure wbDefineNiBSplineCompPoint3Interpolator;
begin
  wbNiObject(wbNifBlock('NiBSplineCompPoint3Interpolator', [
    dfFloat('Position Offset', 'Min'),
    dfFloat('Position Half Range', 'Min')
  ]), 'NiBSplinePoint3Interpolator', False);
end;

//===========================================================================
{ NiBSplineTransformInterpolator }
procedure wbDefineNiBSplineTransformInterpolator;
begin
  wbNiObject(wbNifBlock('NiBSplineTransformInterpolator', [
    wbNiQuatTransform('Transform'),
    dfInteger('Translation Handle', dtU32, '65535'),
    dfInteger('Rotation Handle', dtU32, '65535'),
    dfInteger('Scale Handle', dtU32, '65535')
  ]), 'NiBSplineInterpolator', False);
end;

//===========================================================================
{ NiBSplineCompTransformInterpolator }
procedure wbDefineNiBSplineCompTransformInterpolator;
begin
  wbNiObject(wbNifBlock('NiBSplineCompTransformInterpolator', [
    dfFloat('Translation Offset'),
    dfFloat('Translation Half Range'),
    dfFloat('Rotation Offset'),
    dfFloat('Rotation Half Range'),
    dfFloat('Scale Offset'),
    dfFloat('Scale Half Range')
  ]), 'NiBSplineTransformInterpolator', False);
end;

//===========================================================================
{ NiBSplineData }
procedure wbDefineNiBSplineData;
begin
  wbNiObject(wbNifBlock('NiBSplineData', [
    dfArray('Float Control Points', dfFloat('Float Control Points'), -4),
    dfArray('Compact Control Points', dfInteger('Compact Control Points', dtU16), -4)
  ]), 'NiObject', False);
end;

//===========================================================================
{ NiBSplineBasisData }
procedure wbDefineNiBSplineBasisData;
begin
  wbNiObject(wbNifBlock('NiBSplineBasisData', [
    dfInteger('Num Control Points', dtU32)
  ]), 'NiObject', False);
end;

//===========================================================================
{ BSRotAccumTransfInterpolator }
procedure wbDefineBSRotAccumTransfInterpolator;
begin
  wbNiObject(wbNifBlock('BSRotAccumTransfInterpolator'), 'NiTransformInterpolator', False);
end;

//===========================================================================
{ BSTreadTransfInterpolator }
procedure wbDefineBSTreadTransfInterpolator;
begin
  wbNiObject(wbNifBlock('BSTreadTransfInterpolator', [
    dfArray('Tread Transforms', dfStruct('Tread Transforms', [
      wbString('Name'),
      wbNiQuatTransform('Transform 1'),
      wbNiQuatTransform('Transform 2')
    ]), -4),
    wbNiRef('Data', 'NiFloatData')
  ]), 'NiInterpolator', False);
end;

//===========================================================================
{ NiTimeController }
procedure wbDefineNiTimeController;
begin
  wbNiObject(wbNifBlock('NiTimeController', [
    wbNiRef('Next Controller', 'NiTimeController'),
    dfFlags('Flags', dtU16, [
      0, 'Anim Bit',
      1, 'Cycle Bit1',
      2, 'Cycle Bit2',
      3, 'Active',
      4, 'Play Backwards',
      5, 'Is manager controlled',
      6, 'Compute scaled time',
      7, 'Force update'
    ]),
    dfFloat('Frequency', '1.0'),
    dfFloat('Phase'),
    dfFloat('Start Time', 'Min'),
    dfFloat('Stop Time', 'Min'),
    wbNiPtr('Target', 'NiObjectNET')
  ]), 'NiObject', True);
end;

//===========================================================================
{ NiLookAtController * }
procedure wbDefineNiLookAtController;
begin
  wbNiObject(wbNifBlock('NiLookAtController', [
    wbLookAtFlags('Flags', '', [DF_OnGetEnabled, @EnSince10100]),
    wbNiPtr('Look At Node', 'NiNode')
  ]), 'NiTimeController', False);
end;

//===========================================================================
{ NiInterpController }
procedure wbDefineNiInterpController;
begin
  wbNiObject(wbNifBlock('NiInterpController', [
    wbBool('Manager Controlled', [DF_OnGetEnabled, @En1010106])
  ]), 'NiTimeController', True);
end;

//===========================================================================
{ NiMorpherController * }
procedure wbDefineNiMorpherController;
begin
  wbNiObject(wbNifBlock('NiMorpherController', [
    wbNiRef('Data', 'NiMorphData')
  ]), 'NiInterpController', False);
end;

//===========================================================================
{ NiSingleInterpController }
procedure wbDefineNiSingleInterpController;
begin
  wbNiObject(wbNifBlock('NiSingleInterpController', [
    wbNiRef('Interpolator', 'NiInterpolator', [DF_OnGetEnabled, @EnSince1010106])
  ]), 'NiInterpController', True);
end;

//===========================================================================
{ NiRollController * }
procedure wbDefineNiRollController;
begin
  wbNiObject(wbNifBlock('NiRollController', [
    wbNiRef('Data', 'NiFloatData')
  ]), 'NiSingleInterpController', False);
end;

//===========================================================================
{ NiBoolInterpController }
procedure wbDefineNiBoolInterpController;
begin
  wbNiObject(wbNifBlock('NiBoolInterpController'), 'NiSingleInterpController', True);
end;

//===========================================================================
{ NiVisController }
procedure wbDefineNiVisController;
begin
  wbNiObject(wbNifBlock('NiVisController', [
    wbNiRef('Data', 'NiVisData', [DF_OnGetEnabled, @EnBefore10100])
  ]), 'NiBoolInterpController', False);
end;

//===========================================================================
{ NiExtraDataController }
procedure wbDefineNiExtraDataController;
begin
  wbNiObject(wbNifBlock('NiExtraDataController', [
    wbString('Extra Data Name', [DF_OnGetEnabled, @EnSince10200])
  ]), 'NiSingleInterpController', True);
end;

//===========================================================================
{ NiFloatExtraDataController }
procedure wbDefineNiFloatExtraDataController;
begin
  wbNiObject(wbNifBlock('NiFloatExtraDataController', [
    dfInteger('Num Extra Bytes', dtU8, [DF_OnGetEnabled, @EnBefore10100]),
    dfBytes('Unknown Bytes', 7, [DF_OnGetEnabled, @EnBefore10100]),
    dfArray('Unknown Extra Bytes', dfInteger('Unknown Extra Bytes', dtU8), 0, 'Num Extra Bytes', [DF_OnGetEnabled, @EnBefore10100]),
    wbNiRef('Data', 'NiFloatData', [DF_OnGetEnabled, @EnBefore10100])
  ]), 'NiExtraDataController', False);
end;

//===========================================================================
{ NiFloatsExtraDataController }
procedure wbDefineNiFloatsExtraDataController;
begin
  wbNiObject(wbNifBlock('NiFloatsExtraDataController', [
    dfInteger('Floats Extra Data Index', dtS32),
    wbNiRef('Data', 'NiFloatData', [DF_OnGetEnabled, @EnBefore10100])
  ]), 'NiExtraDataController', False);
end;

//===========================================================================
{ NiFloatsExtraDataPoint3Controller }
procedure wbDefineNiFloatsExtraDataPoint3Controller;
begin
  wbNiObject(wbNifBlock('NiFloatsExtraDataPoint3Controller', [
    dfInteger('Floats Extra Data Index', dtS32)
  ]), 'NiExtraDataController', False);
end;

//===========================================================================
{ NiPoint3InterpController }
procedure wbDefineNiPoint3InterpController;
begin
  wbNiObject(wbNifBlock('NiPoint3InterpController'), 'NiSingleInterpController', True);
end;

//===========================================================================
{ NiMaterialColorController }
procedure wbDefineNiMaterialColorController;
begin
  wbNiObject(wbNifBlock('NiMaterialColorController', [
    wbMaterialColor('Target Color', '', [DF_OnGetEnabled, @EnSince10100]),
    wbNiRef('Data', 'NiPosData', [DF_OnGetEnabled, @EnBefore10100])
  ]), 'NiPoint3InterpController', False);
end;

//===========================================================================
{ NiLightColorController }
procedure wbDefineNiLightColorController;
begin
  wbNiObject(wbNifBlock('NiLightColorController', [
    wbLightColor('Target Color', '', [DF_OnGetEnabled, @EnSince10100]),
    wbNiRef('Data', 'NiPosData', [DF_OnGetEnabled, @EnBefore10100])
  ]), 'NiPoint3InterpController', False);
end;

//===========================================================================
{ NiBoneLODController }
function NiBoneLODController_EnShapeGroups(const e: TdfElement): Boolean; begin with nif(e) do Result := (Version >= v4220) and (UserVersion = 0); end;

procedure wbDefineNiBoneLODController;
begin
  wbNiObject(wbNifBlock('NiBoneLODController', [
    dfInteger('LOD', dtU32),
    dfInteger('Num LOD', dtU32),
    dfArray('Node Groups',
      dfArray('Node Groups', wbNiPtr('Nodes', 'NiNode'), -4, '', [DF_OnBeforeSave, @RemoveNoneLinks]),
    -4),
    dfArray('Shape Groups',
      dfArray('Shape Groups', dfStruct('Skin Info', [
        wbNiPtr('Shape', 'NiTriBasedGeom'),
        wbNiRef('Skin Instance', 'NiSkinInstance')
      ]), -4),
    -4, '', [DF_OnGetEnabled, @NiBoneLODController_EnShapeGroups]),
    dfArray('Shade Groups 2',
      dfArray('Shade Groups 2', wbNiRef('Nodes', 'NiTriBasedGeom'), -4, '', [DF_OnBeforeSave, @RemoveNoneLinks]),
    -4, '', [DF_OnGetEnabled, @NiBoneLODController_EnShapeGroups])
  ]), 'NiTimeController', False);
end;

//===========================================================================
{ NiBSBoneLODController }
procedure wbDefineNiBSBoneLODController;
begin
  wbNiObject(wbNifBlock('NiBSBoneLODController'), 'NiBoneLODController', False);
end;

//===========================================================================
{ bhkBlendController }
procedure wbDefinebhkBlendController;
begin
  wbNiObject(wbNifBlock('bhkBlendController', [
    dfInteger('Keys', dtU32)
  ]), 'NiTimeController', False);
end;

//===========================================================================
{ NiKeyframeController }
procedure wbDefineNiKeyframeController;
begin
  wbNiObject(wbNifBlock('NiKeyframeController', [
    wbNiRef('Data', 'NiKeyframeData', [DF_OnGetEnabled, @EnBefore10100])
  ]), 'NiSingleInterpController', False);
end;

//===========================================================================
{ BSKeyframeController }
procedure wbDefineBSKeyframeController;
begin
  wbNiObject(wbNifBlock('BSKeyframeController', [
    wbNiRef('Data 2', 'NiKeyframeData')
  ]), 'NiKeyframeController', False);
end;

//===========================================================================
{ NiKeyframeData }
function NiKeyframeData_EnRotationType(const e: TdfElement): Boolean; begin Result := e.NativeValues['..\Num Rotation Keys'] <> 0; end;
function NiKeyframeData_EnQuatKeys(const e: TdfElement): Boolean; begin Result := e.NativeValues['..\Rotation Type'] <> 4; end;
function NiKeyframeData_EnQuatKeysTime(const e: TdfElement): Boolean; begin with nif(e) do Result := (Version <= v10100) or ((Version >= v1010106) and (e.NativeValues['..\Rotation Type'] <> 4)); end;
function NiKeyframeData_EnQuatKeysValue(const e: TdfElement): Boolean; begin Result := nifblk(e).NativeValues['Rotation Type'] <> 4; end;
function NiKeyframeData_EnQuatKeysTBC(const e: TdfElement): Boolean; begin Result := nifblk(e).NativeValues['Rotation Type'] = 3; end;
function NiKeyframeData_EnUnknownFloat(const e: TdfElement): Boolean; begin Result := (nif(e).Version <= v10100) and (e.NativeValues['..\Rotation Type'] = 4); end;
function NiKeyframeData_EnXYZRotations(const e: TdfElement): Boolean; begin Result := e.NativeValues['..\Rotation Type'] = 4; end;

procedure wbDefineNiKeyframeData;
begin
  wbNiObject(wbNifBlock('NiKeyframeData', [
    dfInteger('Num Rotation Keys', dtU32),
    wbKeyType('Rotation Type', '', [DF_OnGetEnabled, @NiKeyframeData_EnRotationType]),
    dfArray('Quaternion Keys', dfStruct('Quaternion Keys', [
      dfFloat('Time', [DF_OnGetEnabled, @NiKeyframeData_EnQuatKeysTime]),
      wbQuaternion('Value', [DF_OnGetEnabled, @NiKeyframeData_EnQuatKeysValue]),
      wbTBC('TBC', [DF_OnGetEnabled, @NiKeyframeData_EnQuatKeysTBC])
    ]), 0, 'Num Rotation Keys', [DF_OnGetEnabled, @NiKeyframeData_EnQuatKeys]),
    dfFloat('Order', [DF_OnGetEnabled, @NiKeyframeData_EnUnknownFloat]),
    dfArray('XYZ Rotations', wbKeyGroup('XYZ Rotations', 'float', []), 3, '', [DF_OnGetEnabled, @NiKeyframeData_EnXYZRotations]),
    wbKeyGroup('Translations', 'vector3', []),
    wbKeyGroup('Scales', 'float', [])
  ]), 'NiObject', False);
end;

//===========================================================================
{ NiTransformData }
procedure wbDefineNiTransformData;
begin
  wbNiObject(wbNifBlock('NiTransformData'), 'NiKeyframeData', False);
end;

//===========================================================================
{ NiTransformController }
procedure wbDefineNiTransformController;
begin
  wbNiObject(wbNifBlock('NiTransformController'), 'NiKeyframeController', False);
end;

//===========================================================================
{ NiMultiTargetTransformController }
procedure wbDefineNiMultiTargetTransformController;
begin
  wbNiObject(wbNifBlock('NiMultiTargetTransformController', [
    dfArray('Extra Targets', wbNiPtr('Extra Targets', 'NiAVObject'), -2)
  ]), 'NiInterpController', False);
end;

//===========================================================================
{ NiParticleSystemController }
procedure wbDefineNiParticleSystemController;
begin
  wbNiObject(wbNifBlock('NiParticleSystemController', [
    dfFloat('Speed'),
    dfFloat('Speed Random'),
    dfFloat('Vertical Direction'),
    dfFloat('Vertical Angle'),
    dfFloat('Horizontal Direction'),
    dfFloat('Horizontal Angle'),
    wbVector3('Unknown Normal?'),
    wbColor4('Unknown Color?'),
    dfFloat('Size'),
    dfFloat('Emit Start Time'),
    dfFloat('Emit Stop Time'),
    dfInteger('Unknown Byte', dtU8),
    dfFloat('Emit Rate'),
    dfFloat('Lifetime'),
    dfFloat('Lifetime Random'),
    dfInteger('Emit Flags', dtU16),
    wbVector3('Start Random'),
    wbNiPtr('Emitter', 'NiObject'),
    dfInteger('Unknown Short 2', dtU16),
    dfFloat('Unknown Float 13', '1.0'),
    dfInteger('Unknown Int 1', dtU32),
    dfInteger('Unknown Int 2', dtU32, '1'),
    dfInteger('Unknown Short 3', dtU16),
    dfInteger('Num Particles', dtU16),
    dfInteger('Num Valid', dtU16),
    dfArray('Particles', dfStruct('Particles', [
      wbVector3('Velocity'),
      wbVector3('Unknown Vector'),
      dfFloat('Lifetime'),
      dfFloat('Lifespan'),
      dfFloat('Timestamp'),
      dfInteger('Unknown Short', dtU16),
      dfInteger('Vertex ID', dtU16)
    ]), 0, 'Num Particles', []),
    wbNiRef('Unknown Link', 'NiObject'),
    wbNiRef('Particle Extra', 'NiParticleModifier'),
    wbNiRef('Unknown Link 2', 'NiObject'),
    dfInteger('Trailer', dtU8)
  ]), 'NiTimeController', False);
end;

//===========================================================================
{ NiBSPArrayController }
procedure wbDefineNiBSPArrayController;
begin
  wbNiObject(wbNifBlock('NiBSPArrayController'), 'NiParticleSystemController', False);
end;

//===========================================================================
{ NiPathController }
procedure wbDefineNiPathController;
begin
  wbNiObject(wbNifBlock('NiPathController', [
    wbPathFlags('Path Flags', '', [DF_OnGetEnabled, @EnSince10100]),
    dfInteger('Bank Dir', dtS32, '1'),
    dfFloat('Max Bank Angle'),
    dfFloat('Smoothing'),
    dfInteger('Follow Axis', dtS16),
    wbNiRef('Path Data', 'NiPosData'),
    wbNiRef('Percent Data', 'NiFloatData')
  ]), 'NiTimeController', False);
end;

//===========================================================================
{ NiGeomMorpherController }
//function NiGeomMorpherController_EnUnknown2(const e: TdfElement): Boolean; begin Result := nif(e).Version = v1010106; end;
function NiGeomMorpherController_EnInterpolators(const e: TdfElement): Boolean; begin with nif(e) do Result := (Version >= v1010106) and (Version <= v20005); end;
function NiGeomMorpherController_EnUnknownInts(const e: TdfElement): Boolean; begin with nif(e) do Result := (Version >= v10200) and (Version <= v20005) and (UserVersion2 > 9); end;

procedure wbDefineNiGeomMorpherController;
begin
  wbNiObject(wbNifBlock('NiGeomMorpherController', [
    dfInteger('Extra Flags', dtU16, [DF_OnGetEnabled, @EnSince10012]),
    //dfInteger('Unknown 2', dtU8, [DF_OnGetEnabled, @NiGeomMorpherController_EnUnknown2]),
    wbNiRef('Data', 'NiMorphData'),
    dfInteger('Always Update', dtU8),
    dfInteger('Num Interpolators', dtU32, [DF_OnGetEnabled, @EnSince1010106]),
    dfArray('Interpolators', wbNiRef('Interpolators', 'NiInterpolator'), 0, 'Num Interpolators', [DF_OnGetEnabled, @NiGeomMorpherController_EnInterpolators]),
    dfArray('Interpolator Weights', dfStruct('Interpolator Weights', [
      wbNiRef('Interpolator', 'NiInterpolator'),
      dfFloat('Weight')
    ]), 0, 'Num Interpolators', [DF_OnGetEnabled, @EnSince20103]),
    dfArray('Unknown Ints', dfInteger('Unknown Ints', dtU32), -4, '', [DF_OnGetEnabled, @NiGeomMorpherController_EnUnknownInts])
  ]), 'NiInterpController', False);
end;

//===========================================================================
{ NiUVController }
procedure wbDefineNiUVController;
begin
  wbNiObject(wbNifBlock('NiUVController', [
    dfInteger('Unknown Short', dtU16),
    wbNiRef('Data', 'NiUVData')
  ]), 'NiTimeController', False);
end;

//===========================================================================
{ NiPSysModifierCtlr }
procedure wbDefineNiPSysModifierCtlr;
begin
  wbNiObject(wbNifBlock('NiPSysModifierCtlr', [
    wbString('Modifier Name')
  ]), 'NiSingleInterpController', True);
end;

//===========================================================================
{ NiPSysEmitterCtlr }
procedure wbDefineNiPSysEmitterCtlr;
begin
  wbNiObject(wbNifBlock('NiPSysEmitterCtlr', [
    wbNiRef('Data', 'NiPSysEmitterCtlrData', [DF_OnGetEnabled, @EnBefore10100]),
    wbNiRef('Visibility Interpolator', 'NiInterpolator', [DF_OnGetEnabled, @EnSince10100])
  ]), 'NiPSysModifierCtlr', False);
end;

//===========================================================================
{ NiPSysEmitterCtlrData * }
procedure wbDefineNiPSysEmitterCtlrData;
begin
  wbNiObject(wbNifBlock('NiPSysEmitterCtlrData', [
    wbKeyGroup('Birth Rate Keys', 'float', []),
    dfArray('Active Keys', dfStruct('Active Keys', [
      dfFloat('Time'),
      dfInteger('Value', dtU8)
    ]), -4)
  ]), 'NiObject', False);
end;

//===========================================================================
{ NiPSysModifierBoolCtlr }
procedure wbDefineNiPSysModifierBoolCtlr;
begin
  wbNiObject(wbNifBlock('NiPSysModifierBoolCtlr'), 'NiPSysModifierCtlr', True);
end;

//===========================================================================
{ NiPSysModifierActiveCtlr }
procedure wbDefineNiPSysModifierActiveCtlr;
begin
  wbNiObject(wbNifBlock('NiPSysModifierActiveCtlr', [
    wbNiRef('Data', 'NiVisData', [DF_OnGetEnabled, @EnBefore10100])
  ]), 'NiPSysModifierBoolCtlr', False);
end;

//===========================================================================
{ NiPSysModifierFloatCtlr }
procedure wbDefineNiPSysModifierFloatCtlr;
begin
  wbNiObject(wbNifBlock('NiPSysModifierFloatCtlr', [
    wbNiRef('Data', 'NiFloatData', [DF_OnGetEnabled, @EnBefore10100])
  ]), 'NiPSysModifierCtlr', True);
end;

//===========================================================================
{ NiPSysEmitterDeclinationCtlr }
procedure wbDefineNiPSysEmitterDeclinationCtlr;
begin
  wbNiObject(wbNifBlock('NiPSysEmitterDeclinationCtlr'), 'NiPSysModifierFloatCtlr', False);
end;

//===========================================================================
{ NiPSysEmitterDeclinationVarCtlr }
procedure wbDefineNiPSysEmitterDeclinationVarCtlr;
begin
  wbNiObject(wbNifBlock('NiPSysEmitterDeclinationVarCtlr'), 'NiPSysModifierFloatCtlr', False);
end;

//===========================================================================
{ NiPSysEmitterInitialRadiusCtlr }
procedure wbDefineNiPSysEmitterInitialRadiusCtlr;
begin
  wbNiObject(wbNifBlock('NiPSysEmitterInitialRadiusCtlr'), 'NiPSysModifierFloatCtlr', False);
end;

//===========================================================================
{ NiPSysEmitterLifeSpanCtlr }
procedure wbDefineNiPSysEmitterLifeSpanCtlr;
begin
  wbNiObject(wbNifBlock('NiPSysEmitterLifeSpanCtlr'), 'NiPSysModifierFloatCtlr', False);
end;

//===========================================================================
{ NiPSysInitialRotSpeedCtlr }
procedure wbDefineNiPSysInitialRotSpeedCtlr;
begin
  wbNiObject(wbNifBlock('NiPSysInitialRotSpeedCtlr'), 'NiPSysModifierFloatCtlr', False);
end;

//===========================================================================
{ NiPSysInitialRotSpeedVarCtlr }
procedure wbDefineNiPSysInitialRotVarSpeedCtlr;
begin
  wbNiObject(wbNifBlock('NiPSysInitialRotSpeedVarCtlr'), 'NiPSysModifierFloatCtlr', False);
end;

//===========================================================================
{ NiPSysInitialRotAngleCtlr }
procedure wbDefineNiPSysInitialRotAngleCtlr;
begin
  wbNiObject(wbNifBlock('NiPSysInitialRotAngleCtlr'), 'NiPSysModifierFloatCtlr', False);
end;

//===========================================================================
{ NiPSysInitialRotAngleVarCtlr }
procedure wbDefineNiPSysInitialRotAngleVarCtlr;
begin
  wbNiObject(wbNifBlock('NiPSysInitialRotAngleVarCtlr'), 'NiPSysModifierFloatCtlr', False);
end;

//===========================================================================
{ NiPSysEmitterPlanarAngleCtlr }
procedure wbDefineNiPSysEmitterPlanarAngleCtlr;
begin
  wbNiObject(wbNifBlock('NiPSysEmitterPlanarAngleCtlr'), 'NiPSysModifierFloatCtlr', False);
end;

//===========================================================================
{ NiPSysEmitterPlanarAngleVarCtlr }
procedure wbDefineNiPSysEmitterPlanarAngleVarCtlr;
begin
  wbNiObject(wbNifBlock('NiPSysEmitterPlanarAngleVarCtlr'), 'NiPSysModifierFloatCtlr', False);
end;

//===========================================================================
{ NiPSysEmitterSpeedCtlr }
procedure wbDefineNiPSysEmitterSpeedCtlr;
begin
  wbNiObject(wbNifBlock('NiPSysEmitterSpeedCtlr'), 'NiPSysModifierFloatCtlr', False);
end;

//===========================================================================
{ NiPSysGravityStrengthCtlr }
procedure wbDefineNiPSysGravityStrengthCtlr;
begin
  wbNiObject(wbNifBlock('NiPSysGravityStrengthCtlr'), 'NiPSysModifierFloatCtlr', False);
end;

//===========================================================================
{ NiPSysAirFieldAirFrictionCtlr * }
procedure wbDefineNiPSysAirFieldAirFrictionCtlr;
begin
  wbNiObject(wbNifBlock('NiPSysAirFieldAirFrictionCtlr'), 'NiPSysModifierFloatCtlr', False);
end;

//===========================================================================
{ NiPSysAirFieldInheritVelocityCtlr * }
procedure wbDefineNiPSysAirFieldInheritVelocityCtlr;
begin
  wbNiObject(wbNifBlock('NiPSysAirFieldInheritVelocityCtlr'), 'NiPSysModifierFloatCtlr', False);
end;

//===========================================================================
{ NiPSysAirFieldSpreadCtlr * }
procedure wbDefineNiPSysAirFieldSpreadCtlr;
begin
  wbNiObject(wbNifBlock('NiPSysAirFieldSpreadCtlr'), 'NiPSysModifierFloatCtlr', False);
end;

//===========================================================================
{ NiPSysFieldAttenuationCtlr * }
procedure wbDefineNiPSysFieldAttenuationCtlr;
begin
  wbNiObject(wbNifBlock('NiPSysFieldAttenuationCtlr'), 'NiPSysModifierFloatCtlr', False);
end;

//===========================================================================
{ NiPSysFieldMagnitudeCtlr * }
procedure wbDefineNiPSysFieldMagnitudeCtlr;
begin
  wbNiObject(wbNifBlock('NiPSysFieldMagnitudeCtlr'), 'NiPSysModifierFloatCtlr', False);
end;

//===========================================================================
{ NiPSysFieldMaxDistanceCtlr * }
procedure wbDefineNiPSysFieldMaxDistanceCtlr;
begin
  wbNiObject(wbNifBlock('NiPSysFieldMaxDistanceCtlr'), 'NiPSysModifierFloatCtlr', False);
end;

//===========================================================================
{ NiPSysResetOnLoopCtlr }
procedure wbDefineNiPSysResetOnLoopCtlr;
begin
  wbNiObject(wbNifBlock('NiPSysResetOnLoopCtlr'), 'NiTimeController', False);
end;

//===========================================================================
{ NiPSysUpdateCtlr }
procedure wbDefineNiPSysUpdateCtlr;
begin
  wbNiObject(wbNifBlock('NiPSysUpdateCtlr'), 'NiTimeController', False);
end;

//===========================================================================
{ BSPSysMultiTargetEmitterCtlr }
procedure wbDefineBSPSysMultiTargetEmitterCtlr;
begin
  wbNiObject(wbNifBlock('BSPSysMultiTargetEmitterCtlr', [
    dfInteger('Max Emitters', dtU16),
    wbNiRef('Master Particle System', 'BSMasterParticleSystem')
  ]), 'NiPSysEmitterCtlr', False);
end;

//===========================================================================
{ NiFloatInterpController }
procedure wbDefineNiFloatInterpController;
begin
  wbNiObject(wbNifBlock('NiFloatInterpController'), 'NiSingleInterpController', True);
end;

//===========================================================================
{ NiFlipController }
procedure wbDefineNiFlipController;
begin
  wbNiObject(wbNifBlock('NiFlipController', [
    wbTexType('Texture Slot', '', []),
    dfInteger('Start Time', dtU32, [DF_OnGetEnabled, @EnBefore10100]),
    dfFloat('Delta', [DF_OnGetEnabled, @EnBefore10100]),
    dfArray('Sources', wbNiRef('Sources', 'NiSourceTexture'), -4, '', [DF_OnBeforeSave, @RemoveNoneLinks])
  ]), 'NiFloatInterpController', False);
end;

//===========================================================================
{ NiAlphaController }
procedure wbDefineNiAlphaController;
begin
  wbNiObject(wbNifBlock('NiAlphaController', [
    wbNiRef('Data', 'NiFloatData', [DF_OnGetEnabled, @EnBefore10100])
  ]), 'NiFloatInterpController', False);
end;

//===========================================================================
{ NiLightDimmerController }
procedure wbDefineNiLightDimmerController;
begin
  wbNiObject(wbNifBlock('NiLightDimmerController'), 'NiFloatInterpController', False);
end;

//===========================================================================
{ NiLightRadiusController }
procedure wbDefineNiLightRadiusController;
begin
  wbNiObject(wbNifBlock('NiLightRadiusController'), 'NiFloatInterpController', False);
end;

//===========================================================================
{ NiTextureTransformController }
procedure wbDefineNiTextureTransformController;
begin
  wbNiObject(wbNifBlock('NiTextureTransformController', [
    dfInteger('Shader Map', dtU8),
    wbTexType('Texture Slot', '', []),
    wbTransformMember('Operation', '', []),
    wbNiRef('Data', 'NiFloatData', [DF_OnGetEnabled, @EnBefore10100])
  ]), 'NiFloatInterpController', False);
end;

//===========================================================================
{ BSEffectShaderPropertyFloatController }
procedure wbDefineBSEffectShaderPropertyFloatController;
begin
  wbNiObject(wbNifBlock('BSEffectShaderPropertyFloatController', [
    wbEffectShaderControlledVariable('Type of Controlled Variable', '', [])
  ]), 'NiFloatInterpController', False);
end;

//===========================================================================
{ BSEffectShaderPropertyFloatController }
procedure wbDefineBSEffectShaderPropertyColorController;
begin
  wbNiObject(wbNifBlock('BSEffectShaderPropertyColorController', [
    wbEffectShaderControlledColor('Type of Controlled Color', '', [])
  ]), 'NiPoint3InterpController', False);
end;

//===========================================================================
{ BSLightingShaderPropertyFloatController }
procedure wbDefineBSLightingShaderPropertyFloatController;
begin
  wbNiObject(wbNifBlock('BSLightingShaderPropertyFloatController', [
    wbLightingShaderControlledVariable('Type of Controlled Variable', '', [])
  ]), 'NiFloatInterpController', False);
end;

//===========================================================================
{ BSLightingShaderPropertyFloatController }
procedure wbDefineBSLightingShaderPropertyColorController;
begin
  wbNiObject(wbNifBlock('BSLightingShaderPropertyColorController', [
    wbLightingShaderControlledColor('Type of Controlled Color', '', [])
  ]), 'NiPoint3InterpController', False);
end;

//===========================================================================
{ BSLightingShaderPropertyUShortController }
procedure wbDefineBSLightingShaderPropertyUShortController;
begin
  wbNiObject(wbNifBlock('BSLightingShaderPropertyUShortController', [
    dfInteger('Type of Controlled Variable', dtU32)
  ]), 'NiFloatInterpController', False);
end;

//===========================================================================
{ BSFrustumFOVController }
procedure wbDefineBSFrustumFOVController;
begin
  wbNiObject(wbNifBlock('BSFrustumFOVController'), 'NiFloatInterpController', False);
end;

//===========================================================================
{ BSLagBoneController }
procedure wbDefineBSLagBoneController;
begin
  wbNiObject(wbNifBlock('BSLagBoneController', [
    dfFloat('Linear Velocity'),
    dfFloat('Linear Rotation'),
    dfFloat('Maximum Distance')
  ]), 'NiTimeController', False);
end;

//===========================================================================
{ BSMaterialEmittanceMultController }
procedure wbDefineBSMaterialEmittanceMultController;
begin
  wbNiObject(wbNifBlock('BSMaterialEmittanceMultController'), 'NiFloatInterpController', False);
end;

//===========================================================================
{ BSNiAlphaPropertyTestRefController }
procedure wbDefineBSNiAlphaPropertyTestRefController;
begin
  wbNiObject(wbNifBlock('BSNiAlphaPropertyTestRefController'), 'NiFloatInterpController', False);
end;

//===========================================================================
{ BSProceduralLightningController }
procedure wbDefineBSProceduralLightningController;
begin
  wbNiObject(wbNifBlock('BSProceduralLightningController', [
    wbNiRef('Interpolator 1: Generation', 'NiInterpolator'),
    wbNiRef('Interpolator 2: Mutation', 'NiInterpolator'),
    wbNiRef('Interpolator 3: Subdivision', 'NiInterpolator'),
    wbNiRef('Interpolator 4: Num Branches', 'NiInterpolator'),
    wbNiRef('Interpolator 5: Num Branches Var', 'NiInterpolator'),
    wbNiRef('Interpolator 6: Length', 'NiInterpolator'),
    wbNiRef('Interpolator 7: Length Var', 'NiInterpolator'),
    wbNiRef('Interpolator 8: Width', 'NiInterpolator'),
    wbNiRef('Interpolator 9: Arc Offset', 'NiInterpolator'),
    dfInteger('Subdivisions', dtU16),
    dfInteger('Bum Branches', dtU16),
    dfInteger('Bum Branches Variation', dtU16),
    dfFloat('Length'),
    dfFloat('Length Variation'),
    dfFloat('Width'),
    dfFloat('Child Width Mult'),
    dfFloat('Arc Offset'),
    wbBool('Fade Main Bolt'),
    wbBool('Fade Child Bolts'),
    wbBool('Animate Arc Offset'),
    wbNiRef('Shader Property', 'BSShaderProperty')
  ]), 'NiTimeController', False);
end;

//===========================================================================
{ BSRefractionFirePeriodController }
procedure wbDefineBSRefractionFirePeriodController;
begin
  wbNiObject(wbNifBlock('BSRefractionFirePeriodController', [
    wbNiRef('Interpolator', 'NiInterpolator', [DF_OnGetEnabled, @EnSince20207])
  ]), 'NiTimeController', False);
end;

//===========================================================================
{ BSRefractionStrengthController }
procedure wbDefineBSRefractionStrengthController;
begin
  wbNiObject(wbNifBlock('BSRefractionStrengthController'), 'NiFloatInterpController', False);
end;

//===========================================================================
{ NiControllerManager }
procedure wbDefineNiControllerManager;
begin
  wbNiObject(wbNifBlock('NiControllerManager', [
    wbBool('Cumulative'),
    dfArray('Controller Sequences', wbNiRef('Controller Sequences', 'NiControllerSequence'), -4, '', [DF_OnBeforeSave, @RemoveNoneLinks]),
    wbNiRef('Object Palette', 'NiDefaultAVObjectPalette')
  ]), 'NiTimeController', False);
end;

//===========================================================================
{ NiCamera }
procedure wbDefineNiCamera;
begin
  wbNiObject(wbNifBlock('NiCamera', [
    dfInteger('Camera Flags', dtU16, [DF_OnGetEnabled, @EnSince10100]),
    dfFloat('Frustum Left'),
    dfFloat('Frustum Right'),
    dfFloat('Frustum Top'),
    dfFloat('Frustum Bottom'),
    dfFloat('Frustum Near'),
    dfFloat('Frustum Far'),
    wbBool('Use Orthographic Projection', [DF_OnGetEnabled, @EnSince10100]),
    dfFloat('Viewport Left'),
    dfFloat('Viewport Right'),
    dfFloat('Viewport Top'),
    dfFloat('Viewport Bottom'),
    dfFloat('LOD Adjust'),
    wbNiRef('Scene', 'NiAVObject'),
    dfInteger('Num Screen Polygons', dtU32),
    dfInteger('Num Screen Textures', dtU32, [DF_OnGetEnabled, @EnSince4210])
  ]), 'NiAVObject', False);
end;

//===========================================================================
{ NiSequence }
procedure wbDefineNiSequence;
begin
  wbNiObject(wbNifBlock('NiSequence', [
    wbString('Name'),
    wbString('Accum Root Name', [DF_OnGetEnabled, @EnBefore10100]),
    wbNiRef('Text Keys', 'NiTextKeyExtraData', [DF_OnGetEnabled, @EnBefore10100]),
    dfInteger('Num Controlled Blocks', dtU32),
    dfInteger('Array Grow By', dtU32, [DF_OnGetEnabled, @EnSince1010106]),
    dfArray('Controlled Blocks', wbControlledBlock('Controlled Blocks', []), 0, 'Num Controlled Blocks', [])
  ]), 'NiObject', False);
end;

//===========================================================================
{ NiControllerSequence }
function NiControllerSequence_EnPhase(const e: TdfElement): Boolean; begin with nif(e) do Result := (Version >= v1010106) and (Version <= v10401); end;
function NiControllerSequence_EnStringPalette(const e: TdfElement): Boolean; begin with nif(e) do Result := (Version >= v10200) and (Version <= v20005); end;
function NiControllerSequence_EnAnimNotes(const e: TdfElement): Boolean; begin with nif(e) do Result := (Version >= v20207) and (UserVersion2 >= 24) and (UserVersion2 <= 28) and (UserVersion2 <= 28); end;
function NiControllerSequence_EnAnimNotesArray(const e: TdfElement): Boolean; begin with nif(e) do Result := (Version >= v20207) and (UserVersion2 > 28); end;

procedure wbDefineNiControllerSequence;
begin
  wbNiObject(wbNifBlock('NiControllerSequence', [
    dfFloat('Weight', '1.0', [DF_OnGetEnabled, @EnSince1010106]),
    wbNiRef('Text Keys', 'NiTextKeyExtraData', [DF_OnGetEnabled, @EnSince1010106]),
    wbCycleType('Cycle Type', '', [DF_OnGetEnabled, @EnSince1010106]),
    dfFloat('Frequency', '1.0', [DF_OnGetEnabled, @EnSince1010106]),
    dfFloat('Phase', [DF_OnGetEnabled, @NiControllerSequence_EnPhase]),
    dfFloat('Start Time', 'Min', [DF_OnGetEnabled, @EnSince1010106]),
    dfFloat('Stop Time', 'Min', [DF_OnGetEnabled, @EnSince1010106]),
    dfInteger('Play Backwards', dtU8, [DF_OnGetEnabled, @En1010106]),
    wbNiPtr('Manager', 'NiControllerManager', [DF_OnGetEnabled, @EnSince1010106]),
    wbString('Accum Root Name', [DF_OnGetEnabled, @EnSince1010106]),
    wbNiRef('String Palette', 'NiStringPalette', [DF_OnGetEnabled, @NiControllerSequence_EnStringPalette]),
    wbNiRef('Anim Notes', 'BSAnimNotes', [DF_OnGetEnabled, @NiControllerSequence_EnAnimNotes]),
    dfArray('Anim Notes Array', wbNiRef('Anim Notes', 'BSAnimNotes'), -2, '', [
      DF_OnGetEnabled, @NiControllerSequence_EnAnimNotesArray,
      DF_OnBeforeSave, @RemoveNoneLinks
    ])
  ]), 'NiSequence', False);
end;

//===========================================================================
{ NiParticles }
function NiParticles_EnVertexDesc(const e: TdfElement): Boolean; begin Result := nif(e).UserVersion2 >= 100; end;

procedure wbDefineNiParticles;
begin
  wbNiObject(wbNifBlock('NiParticles', [
    wbVertexDesc('VertexDesc', [DF_OnGetEnabled, @NiParticles_EnVertexDesc])
  ]), 'NiGeometry', False);
end;

//===========================================================================
{ NiAutoNormalParticles }
procedure wbDefineNiAutoNormalParticles;
begin
  wbNiObject(wbNifBlock('NiAutoNormalParticles'), 'NiParticles', False);
end;

//===========================================================================
{ NiRotatingParticles }
procedure wbDefineNiRotatingParticles;
begin
  wbNiObject(wbNifBlock('NiRotatingParticles'), 'NiParticles', False);
end;

//===========================================================================
{ NiParticleMeshes }
procedure wbDefineNiParticleMeshes;
begin
  wbNiObject(wbNifBlock('NiParticleMeshes'), 'NiParticles', False);
end;

//===========================================================================
{ NiParticleSystem }
function NiParticleSystem_EnFar(const e: TdfElement): Boolean; begin Result := nif(e).UserVersion2 >= 83; end;
function NiParticleSystem_EnData(const e: TdfElement): Boolean; begin Result := nif(e).UserVersion2 >= 100; end;

procedure wbDefineNiParticleSystem;
begin
  wbNiObject(wbNifBlock('NiParticleSystem', [
    dfInteger('Far Begin', dtU16, [DF_OnGetEnabled, @NiParticleSystem_EnFar]),
    dfInteger('Far End', dtU16, [DF_OnGetEnabled, @NiParticleSystem_EnFar]),
    dfInteger('Near Begin', dtU16, [DF_OnGetEnabled, @NiParticleSystem_EnFar]),
    dfInteger('Near End', dtU16, [DF_OnGetEnabled, @NiParticleSystem_EnFar]),
    wbNiRef('Data', 'NiPSysData', [DF_OnGetEnabled, @NiParticleSystem_EnData]),
    wbBool('World Space', '1', [DF_OnGetEnabled, @EnSince10100]),
    dfArray('Modifiers', wbNiRef('Modifiers', 'NiPSysModifier'), -4, '', [
      DF_OnGetEnabled, @EnSince10100,
      DF_OnBeforeSave, @RemoveNoneLinks
    ])
  ]), 'NiParticles', False);
end;

//===========================================================================
{ NiMeshParticleSystem }
procedure wbDefineNiMeshParticleSystem;
begin
  wbNiObject(wbNifBlock('NiMeshParticleSystem'), 'NiParticleSystem', False);
end;

//===========================================================================
{ NiParticlesData }
function NiParticlesData_EnRadii(const e: TdfElement): Boolean; begin with nif(e) do Result := ((Version >= v10100) and (e.NativeValues['..\Has Radii'] <> 0)) and not ((Version = v20207) and (UserVersion2 > 0)); end;
function NiParticlesData_EnSizes(const e: TdfElement): Boolean; begin with nif(e) do Result := (e.NativeValues['..\Has Sizes'] <> 0) and not ((Version = v20207) and (UserVersion2 > 0)); end;
function NiParticlesData_EnRotations(const e: TdfElement): Boolean; begin with nif(e) do Result := ((Version >= v10010) and (e.NativeValues['..\Has Rotations'] <> 0)) and not ((Version = v20207) and (UserVersion2 > 0)); end;
function NiParticlesData_EnRotationAngles(const e: TdfElement): Boolean; begin with nif(e) do Result := (e.NativeValues['..\Has Rotation Angles'] <> 0) and not ((Version = v20207) and (UserVersion2 > 0)); end;
function NiParticlesData_EnRotationAxes(const e: TdfElement): Boolean; begin with nif(e) do Result := ((Version >= v20004) and (e.NativeValues['..\Has Rotation Axes'] <> 0)) and not ((Version = v20207) and (UserVersion2 > 0)); end;
function NiParticlesData_EnHasHasTextureIndices(const e: TdfElement): Boolean; begin with nif(e) do Result := (Version = v20207) and (UserVersion2 > 0); end;
function NiParticlesData_EnNumSubtextureOffsets(const e: TdfElement): Boolean; begin with nif(e) do Result := (UserVersion2 > 34) or ( (Version = v20207) and (UserVersion2 <= 34) ); end;
function NiParticlesData_DecideNumSubtextureOffsets(const e: TdfElement): Integer; begin if nif(e).UserVersion2 > 34 then Result := 1 else Result := 0; end;
function NiParticlesData_EnAspect(const e: TdfElement): Boolean; begin Result := nif(e).UserVersion2 > 34; end;

procedure wbDefineNiParticlesData;
begin
  wbNiObject(wbNifBlock('NiParticlesData', [
    dfInteger('Num Particles', dtU16, [DF_OnGetEnabled, @EnBefore4002]),
    dfFloat('Particle Radius', [DF_OnGetEnabled, @EnBefore10010]),
    wbBool('Has Radii', [DF_OnGetEnabled, @EnSince10100]),
    dfArray('Radii', dfFloat('Radii'), 0, 'Num Vertices', [DF_OnGetEnabled, @NiParticlesData_EnRadii]),
    dfInteger('Num Active', dtU16),
    wbBool('Has Sizes'),
    dfArray('Sizes', dfFloat('Sizes'), 0, 'Num Vertices', [DF_OnGetEnabled, @NiParticlesData_EnSizes]),
    wbBool('Has Rotations', [DF_OnGetEnabled, @EnSince10010]),
    dfArray('Rotations', wbQuaternion('Rotations'), 0, 'Num Vertices', [DF_OnGetEnabled, @NiParticlesData_EnRotations]),
    wbBool('Has Rotation Angles', [DF_OnGetEnabled, @EnSince20004]),
    dfArray('Rotation Angles', dfFloat('Rotation Angles'), 0, 'Num Vertices', [DF_OnGetEnabled, @NiParticlesData_EnRotationAngles]),
    wbBool('Has Rotation Axes', [DF_OnGetEnabled, @EnSince20004]),
    dfArray('Rotation Axes', wbVector3('Rotation Axes'), 0, 'Num Vertices', [DF_OnGetEnabled, @NiParticlesData_EnRotationAxes]),
    wbBool('Has Texture Indices', [DF_OnGetEnabled, @NiParticlesData_EnHasHasTextureIndices]),
    dfUnion([
      dfInteger('Num Subtexture Offsets', dtU8),
      dfInteger('Num Subtexture Offsets', dtU32)
    ], [DF_OnGetEnabled, @NiParticlesData_EnNumSubtextureOffsets, DF_OnDecide, @NiParticlesData_DecideNumSubtextureOffsets]),
    dfArray('Subtexture Offsets', wbVector4('Subtexture Offsets'), 0, 'Num Subtexture Offsets', [DF_OnGetEnabled, @NiParticlesData_EnHasHasTextureIndices]),
    dfFloat('Aspect Ratio', [DF_OnGetEnabled, @NiParticlesData_EnAspect]),
    dfInteger('Aspect Flags', dtU16, [DF_OnGetEnabled, @NiParticlesData_EnAspect]),
    dfFloat('Speed to Aspect Aspect 2', [DF_OnGetEnabled, @NiParticlesData_EnAspect]),
    dfFloat('Speed to Aspect Speed 1', [DF_OnGetEnabled, @NiParticlesData_EnAspect]),
    dfFloat('Speed to Aspect Speed 2', [DF_OnGetEnabled, @NiParticlesData_EnAspect])
  ]), 'NiGeometryData', False);
end;

//===========================================================================
{ NiAutoNormalParticlesData }
procedure wbDefineNiAutoNormalParticlesData;
begin
  wbNiObject(wbNifBlock('NiAutoNormalParticlesData'), 'NiParticlesData', False);
end;

//===========================================================================
{ NiRotatingParticlesData }
function NiRotatingParticlesData_EnRotations2(const e: TdfElement): Boolean; begin Result := (nif(e).Version <= v4220) and (e.NativeValues['..\Has Rotations 2'] <> 0); end;

procedure wbDefineNiRotatingParticlesData;
begin
  wbNiObject(wbNifBlock('NiRotatingParticlesData', [
    wbBool('Has Rotations 2', [DF_OnGetEnabled, @EnBefore4220]),
    dfArray('Rotations 2', wbQuaternion('Rotations 2'), 0, 'Num Vertices', [DF_OnGetEnabled, @NiRotatingParticlesData_EnRotations2])
  ]), 'NiParticlesData', False);
end;

//===========================================================================
{ NiParticleMeshesData * }
procedure wbDefineNiParticleMeshesData;
begin
  wbNiObject(wbNifBlock('NiParticleMeshesData', [
    wbNiRef('Unknown Link 2', 'NiAVObject')
  ]), 'NiRotatingParticlesData', False);
end;

//===========================================================================
{ NiParticleModifier }
procedure wbDefineNiParticleModifier;
begin
  wbNiObject(wbNifBlock('NiParticleModifier', [
    wbNiRef('Next Modifier', 'NiParticleModifier'),
    wbNiRef('Controller', 'NiParticleSystemController')
  ]), 'NiObject', True);
end;

//===========================================================================
{ NiParticleBomb * }
function NiParticleBomb_EnSymmetryType(const e: TdfElement): Boolean; begin Result := nif(e).Version >=v41012; end;

procedure wbDefineNiParticleBomb;
begin
  wbNiObject(wbNifBlock('NiParticleBomb', [
    dfFloat('Decay'),
    dfFloat('Duration'),
    dfFloat('DeltaV'),
    dfFloat('Start'),
    wbDecayType('Decay Type', '', []),
    wbSymmetryType('Symmetry Type', '', [DF_OnGetEnabled, @NiParticleBomb_EnSymmetryType]),
    wbVector3('Position'),
    wbVector3('Direction')
  ]), 'NiParticleModifier', False);
end;

//===========================================================================
{ NiSphericalCollider * }
function NiSphericalCollider_EnShort2(const e: TdfElement): Boolean; begin Result := nif(e).Version <= v4202; end;

procedure wbDefineNiSphericalCollider;
begin
  wbNiObject(wbNifBlock('NiSphericalCollider', [
    dfFloat('Unknown Float 1'),
    dfInteger('Unknown Short 1', dtU16),
    dfFloat('Unknown Float 2'),
    dfInteger('Unknown Short 2',  dtU16, [DF_OnGetEnabled, @NiSphericalCollider_EnShort2]),
    dfFloat('Unknown Float 3', [DF_OnGetEnabled, @EnSince4210]),
    dfFloat('Unknown Float 4'),
    dfFloat('Unknown Float 5')
  ]), 'NiParticleModifier', False);
end;

//===========================================================================
{ NiParticleColorModifier }
procedure wbDefineNiParticleColorModifier;
begin
  wbNiObject(wbNifBlock('NiParticleColorModifier', [
    wbNiRef('Color Data', 'NiColorData')
  ]), 'NiParticleModifier', False);
end;

//===========================================================================
{ NiParticleMeshModifier }
procedure wbDefineNiParticleMeshModifier;
begin
  wbNiObject(wbNifBlock('NiParticleMeshModifier', [
    dfArray('Particle Meshes', wbNiRef('Particle Meshes', 'NiAVObject'), -4, '', [DF_OnBeforeSave, @RemoveNoneLinks])
  ]), 'NiParticleModifier', False);
end;

//===========================================================================
{ NiGravity }
procedure wbDefineNiGravity;
begin
  wbNiObject(wbNifBlock('NiGravity', [
    dfFloat('Unknown Float 1'),
    dfFloat('Force'),
    wbFieldType('Type', '', []),
    wbVector3('Position'),
    wbVector3('Direction')
  ]), 'NiParticleModifier', False);
end;

//===========================================================================
{ NiParticleGrowFade }
procedure wbDefineNiParticleGrowFade;
begin
  wbNiObject(wbNifBlock('NiParticleGrowFade', [
    dfFloat('Grow'),
    dfFloat('Fade')
  ]), 'NiParticleModifier', False);
end;

//===========================================================================
{ NiParticleRotation }
procedure wbDefineNiParticleRotation;
begin
  wbNiObject(wbNifBlock('NiParticleRotation', [
    dfInteger('Random Initial Axis', dtU8),
    wbVector3('Initial Axis'),
    dfFloat('Rotation Speed')
  ]), 'NiParticleModifier', False);
end;

//===========================================================================
{ NiPlanarCollider }
function NiPlanarCollider_En4220(const e: TdfElement): Boolean; begin Result := nif(e).Version = v4220; end;

procedure wbDefineNiPlanarCollider;
begin
  wbNiObject(wbNifBlock('NiPlanarCollider', [
    dfInteger('Unknown Short', dtU16, [DF_OnGetEnabled, @EnSince10010]),
    dfFloat('Unknown Float 1'),
    dfFloat('Unknown Float 2'),
    dfInteger('Unknown Short 2', dtU16, [DF_OnGetEnabled, @NiPlanarCollider_En4220]),
    dfFloat('Unknown Float 3'),
    dfFloat('Unknown Float 4'),
    dfFloat('Unknown Float 5'),
    dfFloat('Unknown Float 6'),
    dfFloat('Unknown Float 7'),
    dfFloat('Unknown Float 8'),
    dfFloat('Unknown Float 9'),
    dfFloat('Unknown Float 10'),
    dfFloat('Unknown Float 11'),
    dfFloat('Unknown Float 12'),
    dfFloat('Unknown Float 13'),
    dfFloat('Unknown Float 14'),
    dfFloat('Unknown Float 15'),
    dfFloat('Unknown Float 16')
  ]), 'NiParticleModifier', False);
end;

//===========================================================================
{ NiPSysCollider }
procedure wbDefineNiPSysCollider;
begin
  wbNiObject(wbNifBlock('NiPSysCollider', [
    dfFloat('Bounce', '1.0'),
    wbBool('Spawn on Collide'),
    wbBool('Die on Collide'),
    wbNiRef('Spawn Modifier', 'NiPSysSpawnModifier'),
    wbNiPtr('Parent', 'NiPSysColliderManager'),
    wbNiRef('Next Collider', 'NiPSysCollider'),
    wbNiPtr('Collider Object', 'NiAVObject')
  ]), 'NiObject', True);
end;

//===========================================================================
{ NiPSysPlanarCollider }
procedure wbDefineNiPSysPlanarCollider;
begin
  wbNiObject(wbNifBlock('NiPSysPlanarCollider', [
    dfFloat('Width'),
    dfFloat('Height'),
    wbVector3('X Axis'),
    wbVector3('Y Axis')
  ]), 'NiPSysCollider', False);
end;

//===========================================================================
{ NiPSysSphericalCollider }
procedure wbDefineNiPSysSphericalCollider;
begin
  wbNiObject(wbNifBlock('NiPSysSphericalCollider', [
    dfFloat('Radius')
  ]), 'NiPSysCollider', False);
end;

//===========================================================================
{ NiPSysData }
function NiPSysData_EnDescriptions(const e: TdfElement): Boolean; begin with nif(e) do Result := not ((Version = v20207) and (UserVersion2 > 0)); end;
function NiPSysData_EnRotationSpeeds(const e: TdfElement): Boolean; begin with nif(e) do Result := ((Version >= v20004) and (e.NativeValues['..\Has Rotation Speeds'] <> 0)) and not ((Version = v20207) and (UserVersion2 > 0)); end;
function NiPSysData_EnParticles(const e: TdfElement): Boolean; begin with nif(e) do Result := not ((Version = v20207) and (UserVersion > 0)); end;

procedure wbDefineNiPSysData;
begin
  wbNiObject(wbNifBlock('NiPSysData', [
    dfArray('Particle Descriptions', dfStruct('Particle Descriptions', [
      wbVector3('Translation'),
      dfArray('Unknown Floats 1', dfFloat('Unknown Floats 1'), 3, '', [DF_OnGetEnabled, @EnBefore10401]),
      dfFloat('Unknown Float 1', '0.9'),
      dfFloat('Unknown Float 2', '0.9'),
      dfFloat('Unknown Float 3', '3.0'),
      dfInteger('Unknown Int', dtS32)
    ]), 0, 'Num Vertices', [DF_OnGetEnabled, @NiPSysData_EnDescriptions]),
    wbBool('Has Rotation Speeds', [DF_OnGetEnabled, @EnSince20004]),
    dfArray('Rotation Speeds', dfFloat('Unknown Floats 3'), 0, 'Num Vertices', [DF_OnGetEnabled, @NiPSysData_EnRotationSpeeds]),
    dfInteger('Num Added Particles', dtU16, [DF_OnGetEnabled, @NiPSysData_EnParticles]),
    dfInteger('Added Particles Base', dtU16, [DF_OnGetEnabled, @NiPSysData_EnParticles])
  ]), 'NiParticlesData', False);
end;

//===========================================================================
{ NiMeshPSysData }
procedure wbDefineNiMeshPSysData;
begin
  wbNiObject(wbNifBlock('NiMeshPSysData', [
    dfInteger('Unknown Int 2', dtU32, [DF_OnGetEnabled, @EnSince10200]),
    dfInteger('Unknown Byte 3', dtU8, [DF_OnGetEnabled, @EnSince10200]),
    dfArray('Unknown Ints 1', dfInteger('Unknown Ints 1', dtU32), -4, '', [DF_OnGetEnabled, @EnSince10200]),
    wbNiRef('Unknown Node', 'NiNode')
  ]), 'NiPSysData', False);
end;

//===========================================================================
{ NiPSysModifier }
procedure wbDefineNiPSysModifier;
begin
  wbNiObject(wbNifBlock('NiPSysModifier', [
    wbString('Name'),
    dfInteger('Order', dtU32),
    wbNiPtr('Target', 'NiParticleSystem'),
    wbBool('Active', '1', [])
  ]), 'NiObject', True);
end;

//===========================================================================
{ NiPSysColliderManager }
procedure wbDefineNiPSysColliderManager;
begin
  wbNiObject(wbNifBlock('NiPSysColliderManager', [
    wbNiRef('Collider', 'NiPSysCollider')
  ]), 'NiPSysModifier', False);
end;

//===========================================================================
{ NiPSysAgeDeathModifier }
procedure wbDefineNiPSysAgeDeathModifier;
begin
  wbNiObject(wbNifBlock('NiPSysAgeDeathModifier', [
    wbBool('Spawn on Death'),
    wbNiRef('Spawn Modifier', 'NiPSysSpawnModifier')
  ]), 'NiPSysModifier', False);
end;

//===========================================================================
{ NiPSysBombModifier }
procedure wbDefineNiPSysBombModifier;
begin
  wbNiObject(wbNifBlock('NiPSysBombModifier', [
    wbNiPtr('Bomb Object', 'NiNode'),
    wbVector3('Bomb Axis'),
    dfFloat('Decay'),
    dfFloat('Delta V'),
    wbDecayType('Decay Type', '', []),
    wbSymmetryType('Symmetry Type', '', [])
  ]), 'NiPSysModifier', False);
end;

//===========================================================================
{ NiPSysBoundUpdateModifier }
procedure wbDefineNiPSysBoundUpdateModifier;
begin
  wbNiObject(wbNifBlock('NiPSysBoundUpdateModifier', [
    dfInteger('Update Skin', dtU16)
  ]), 'NiPSysModifier', False);
end;

//===========================================================================
{ NiPSysColorModifier }
procedure wbDefineNiPSysColorModifier;
begin
  wbNiObject(wbNifBlock('NiPSysColorModifier', [
    wbNiRef('Data', 'NiColorData')
  ]), 'NiPSysModifier', False);
end;

//===========================================================================
{ NiPSysDragModifier }
procedure wbDefineNiPSysDragModifier;
begin
  wbNiObject(wbNifBlock('NiPSysDragModifier', [
    wbNiPtr('Drag Object', 'NiAVObject'),
    wbVector3('Drag Axis', '1.0 0.0 0.0', []),
    dfFloat('Percentage', '0.05'),
    dfFloat('Range', 'Max'),
    dfFloat('Range Falloff', 'Max')
  ]), 'NiPSysModifier', False);
end;

//===========================================================================
{ NiPSysGravityModifier }
function NiPSysGravityModifier_EnWorldAligned(const e: TdfElement): Boolean; begin Result := nif(e).UserVersion2 > 16; end;

procedure wbDefineNiPSysGravityModifier;
begin
  wbNiObject(wbNifBlock('NiPSysGravityModifier', [
    wbNiPtr('Gravity Object', 'NiAVObject'),
    wbVector3('Gravity Axis', '1.0 0.0 0.0', []),
    dfFloat('Decay'),
    dfFloat('Strength', '1.0'),
    wbForceType('Force Type', '', []),
    dfFloat('Turbulence'),
    dfFloat('Turbulence Scale', '1.0'),
    wbBool('World Aligned', [DF_OnGetEnabled, @NiPSysGravityModifier_EnWorldAligned])
  ]), 'NiPSysModifier', False);
end;

//===========================================================================
{ NiPSysGrowFadeModifier }
function NiPSysGrowFadeModifier_EnBaseScale(const e: TdfElement): Boolean; begin Result := nif(e).UserVersion2 >= 34; end;

procedure wbDefineNiPSysGrowFadeModifier;
begin
  wbNiObject(wbNifBlock('NiPSysGrowFadeModifier', [
    dfFloat('Grow Time'),
    dfInteger('Grow Generation', dtU16),
    dfFloat('Fade Time'),
    dfInteger('Fade Generation', dtU16),
    dfFloat('Base Scale', [DF_OnGetEnabled, @NiPSysGrowFadeModifier_EnBaseScale])
  ]), 'NiPSysModifier', False);
end;

//===========================================================================
{ NiPSysMeshUpdateModifier }
procedure wbDefineNiPSysMeshUpdateModifier;
begin
  wbNiObject(wbNifBlock('NiPSysMeshUpdateModifier', [
    dfArray('Meshes', wbNiRef('Meshes', 'NiAVObject'), -4, '', [DF_OnBeforeSave, @RemoveNoneLinks])
  ]), 'NiPSysModifier', False);
end;

//===========================================================================
{ NiPSysPositionModifier }
procedure wbDefineNiPSysPositionModifier;
begin
  wbNiObject(wbNifBlock('NiPSysPositionModifier'), 'NiPSysModifier', False);
end;

//===========================================================================
{ NiPSysRotationModifier }
procedure wbDefineNiPSysRotationModifier;
begin
  wbNiObject(wbNifBlock('NiPSysRotationModifier', [
    dfFloat('Rotation Speed'),
    dfFloat('Rotation Speed Variation', [DF_OnGetEnabled, @EnSince20004]),
    dfFloat('Rotation Angle', [DF_OnGetEnabled, @EnSince20004]),
    dfFloat('Rotation Angle Variation', [DF_OnGetEnabled, @EnSince20004]),
    wbBool('Random Rot Speed Sign', [DF_OnGetEnabled, @EnSince20004]),
    wbBool('Random Axis', '1', []),
    wbVector3('Axis', '1.0 0.0 0.0', [])
  ]), 'NiPSysModifier', False);
end;

//===========================================================================
{ NiPSysSpawnModifier }
procedure wbDefineNiPSysSpawnModifier;
begin
  wbNiObject(wbNifBlock('NiPSysSpawnModifier', [
    dfInteger('Num Spawn Generations', dtU16),
    dfFloat('Percentage Spawned', '1.0'),
    dfInteger('Min Num to Spawn', dtU16, '1'),
    dfInteger('Max Num to Spawn', dtU16, '1'),
    dfFloat('Spawn Speed Variation'),
    dfFloat('Spawn Dir Variation'),
    dfFloat('Life Span'),
    dfFloat('Life Span Variation')
  ]), 'NiPSysModifier', False);
end;

//===========================================================================
{ NiPSysFieldModifier * }
procedure wbDefineNiPSysFieldModifier;
begin
  wbNiObject(wbNifBlock('NiPSysFieldModifier', [
    wbNiRef('Field Object', 'NiAVObject'),
    dfFloat('Magnitude'),
    dfFloat('Attenuation'),
    wbBool('Use Max Distance'),
    dfFloat('Max Distance')
  ]), 'NiPSysModifier', True);
end;

//===========================================================================
{ NiPSysAirFieldModifier * }
procedure wbDefineNiPSysAirFieldModifier;
begin
  wbNiObject(wbNifBlock('NiPSysAirFieldModifier', [
    wbVector3('Direction', '-1.0 0.0 0.0', []),
    dfFloat('Air Friction'),
    dfFloat('Inherit Velocity'),
    wbBool('Inherit Rotation'),
    wbBool('Component Only'),
    wbBool('Enable Spread'),
    dfFloat('Spread')
  ]), 'NiPSysFieldModifier', False);
end;

//===========================================================================
{ NiPSysDragFieldModifier * }
procedure wbDefineNiPSysDragFieldModifier;
begin
  wbNiObject(wbNifBlock('NiPSysDragFieldModifier', [
    dfInteger('Use Direction', dtU8),
    wbVector3('Direction')
  ]), 'NiPSysFieldModifier', False);
end;

//===========================================================================
{ NiPSysGravityFieldModifier * }
procedure wbDefineNiPSysGravityFieldModifier;
begin
  wbNiObject(wbNifBlock('NiPSysGravityFieldModifier', [
    wbVector3('Direction', '0.0 -1.0 0.0', [])
  ]), 'NiPSysFieldModifier', False);
end;

//===========================================================================
{ NiPSysRadialFieldModifier * }
procedure wbDefineNiPSysRadialFieldModifier;
begin
  wbNiObject(wbNifBlock('NiPSysRadialFieldModifier', [
    dfFloat('Radial Type')
  ]), 'NiPSysFieldModifier', False);
end;

//===========================================================================
{ NiPSysVortexFieldModifier * }
procedure wbDefineNiPSysVortexFieldModifier;
begin
  wbNiObject(wbNifBlock('NiPSysVortexFieldModifier', [
    wbVector3('Direction')
  ]), 'NiPSysFieldModifier', False);
end;

//===========================================================================
{ NiPSysTurbulenceFieldModifier * }
procedure wbDefineNiPSysTurbulenceFieldModifier;
begin
  wbNiObject(wbNifBlock('NiPSysTurbulenceFieldModifier', [
    dfFloat('Frequency')
  ]), 'NiPSysFieldModifier', False);
end;

//===========================================================================
{ BSParentVelocityModifier }
procedure wbDefineBSParentVelocityModifier;
begin
  wbNiObject(wbNifBlock('BSParentVelocityModifier', [
    dfFloat('Damping')
  ]), 'NiPSysModifier', False);
end;

//===========================================================================
{ BSWindModifier }
procedure wbDefineBSWindModifier;
begin
  wbNiObject(wbNifBlock('BSWindModifier', [
    dfFloat('Strength')
  ]), 'NiPSysModifier', False);
end;

//===========================================================================
{ BSPSysHavokUpdateModifier }
procedure wbDefineBSPSysHavokUpdateModifier;
begin
  wbNiObject(wbNifBlock('BSPSysHavokUpdateModifier', [
    dfArray('Nodes', wbNiRef('Nodes', 'NiNode'), -4, '', [DF_OnBeforeSave, @RemoveNoneLinks]),
    wbNiRef('Modifier', 'NiPSysModifier')
  ]), 'NiPSysModifier', False);
end;

//===========================================================================
{ BSPSysInheritVelocityModifier }
procedure wbDefineBSPSysInheritVelocityModifier;
begin
  wbNiObject(wbNifBlock('BSPSysInheritVelocityModifier', [
    wbNiPtr('Target 2', 'NiNode'),
    dfFloat('Chance To Inherit'),
    dfFloat('Velocity Modifier'),
    dfFloat('Velocity Variation')
  ]), 'NiPSysModifier', False);
end;

//===========================================================================
{ BSPSysLODModifier }
procedure wbDefineBSPSysLODModifier;
begin
  wbNiObject(wbNifBlock('BSPSysLODModifier', [
    dfFloat('LOD Begin Distance', '0.1'),
    dfFloat('LOD End Distance', '0.7'),
    dfFloat('End Emit Scale', '0.2'),
    dfFloat('End Size', '1.0')
  ]), 'NiPSysModifier', False);
end;

//===========================================================================
{ BSPSysRecycleBoundModifier }
procedure wbDefineBSPSysRecycleBoundModifier;
begin
  wbNiObject(wbNifBlock('BSPSysRecycleBoundModifier', [
    wbVector3('Bound Offset'),
    wbVector3('Bound Extent'),
    wbNiPtr('Target 2', 'NiNode')
  ]), 'NiPSysModifier', False);
end;

//===========================================================================
{ BSPSysSimpleColorModifier }
procedure wbDefineBSPSysSimpleColorModifier;
begin
  wbNiObject(wbNifBlock('BSPSysSimpleColorModifier', [
    dfFloat('Fade In Percent'),
    dfFloat('Fade out Percent'),
    dfFloat('Color 1 End Percent'),
    dfFloat('Color 1 Start Percent'),
    dfFloat('Color 2 End Percent'),
    dfFloat('Color 2 Start Percent'),
    dfArray('Colors', wbColor4('Colors'), 3)
  ]), 'NiPSysModifier', False);
end;

//===========================================================================
{ BSPSysScaleModifier }
procedure wbDefineBSPSysScaleModifier;
begin
  wbNiObject(wbNifBlock('BSPSysScaleModifier', [
    dfArray('Scales', dfFloat('Scales'), -4)
  ]), 'NiPSysModifier', False);
end;

//===========================================================================
{ BSPSysStripUpdateModifier }
procedure wbDefineBSPSysStripUpdateModifier;
begin
  wbNiObject(wbNifBlock('BSPSysStripUpdateModifier', [
    dfFloat('Update Delta Time')
  ]), 'NiPSysModifier', False);
end;

//===========================================================================
{ BSPSysSubTexModifier }
procedure wbDefineBSPSysSubTexModifier;
begin
  wbNiObject(wbNifBlock('BSPSysSubTexModifier', [
    dfInteger('Start Frame', dtU32),
    dfFloat('Start Frame Fudge'),
    dfFloat('End Frame'),
    dfFloat('Loop Start Frame'),
    dfFloat('Loop Start Frame Fudge'),
    dfFloat('Frame Count'),
    dfFloat('Frame Count Fudge')
  ]), 'NiPSysModifier', False);
end;

//===========================================================================
{ NiPSysEmitter }
procedure wbDefineNiPSysEmitter;
begin
  wbNiObject(wbNifBlock('NiPSysEmitter', [
    dfFloat('Speed'),
    dfFloat('Speed Variation'),
    dfFloat('Declination'),
    dfFloat('Declination Variation'),
    dfFloat('Planar Angle'),
    dfFloat('Planar Angle Variation'),
    wbColor4('Initial Color'),
    dfFloat('Initial Radius', '1.0'),
    dfFloat('Radius Variation', [DF_OnGetEnabled, @EnSince10401]),
    dfFloat('Life Span'),
    dfFloat('Life Span Variation')
  ]), 'NiPSysModifier', True);
end;

//===========================================================================
{ NiPSysVolumeEmitter }
procedure wbDefineNiPSysVolumeEmitter;
begin
  wbNiObject(wbNifBlock('NiPSysVolumeEmitter', [
    wbNiPtr('Emitter Object', 'NiNode', [DF_OnGetEnabled, @EnSince10100])
  ]), 'NiPSysEmitter', True);
end;

//===========================================================================
{ NiPSysBoxEmitter }
procedure wbDefineNiPSysBoxEmitter;
begin
  wbNiObject(wbNifBlock('NiPSysBoxEmitter', [
    dfFloat('Width'),
    dfFloat('Height'),
    dfFloat('Depth')
  ]), 'NiPSysVolumeEmitter', False);
end;

//===========================================================================
{ NiPSysCylinderEmitter }
procedure wbDefineNiPSysCylinderEmitter;
begin
  wbNiObject(wbNifBlock('NiPSysCylinderEmitter', [
    dfFloat('Radius'),
    dfFloat('Height')
  ]), 'NiPSysVolumeEmitter', False);
end;

//===========================================================================
{ NiPSysSphereEmitter }
procedure wbDefineNiPSysSphereEmitter;
begin
  wbNiObject(wbNifBlock('NiPSysSphereEmitter', [
    dfFloat('Radius')
  ]), 'NiPSysVolumeEmitter', False);
end;

//===========================================================================
{ NiPSysMeshEmitter }
procedure wbDefineNiPSysMeshEmitter;
begin
  wbNiObject(wbNifBlock('NiPSysMeshEmitter', [
    dfArray('Emitter Meshes', wbNiRef('Emitter Meshes', 'NiAVObject'), -4, '', [DF_OnBeforeSave, @RemoveNoneLinks]),
    wbVelocityType('Initial Velocity Type', '', []),
    wbEmitFrom('Emission Type', '', []),
    wbVector3('Emission Axis', '1.0 0.0 0.0', [])
  ]), 'NiPSysEmitter', False);
end;

//===========================================================================
{ BSPSysArrayEmitter }
procedure wbDefineBSPSysArrayEmitter;
begin
  wbNiObject(wbNifBlock('BSPSysArrayEmitter'), 'NiPSysVolumeEmitter', False);
end;

//===========================================================================
{ BSMasterParticleSystem }
procedure wbDefineBSMasterParticleSystem;
begin
  wbNiObject(wbNifBlock('BSMasterParticleSystem', [
    dfInteger('Max Emitter Objects', dtU16),
    dfArray('Particle Systems', wbNiPtr('Particle Systems', 'NiAVObject'), -4, '', [DF_OnBeforeSave, @RemoveNoneLinks])
  ]), 'NiNode', False);
end;

//===========================================================================
{ BSStripParticleSystem }
procedure wbDefineBSStripParticleSystem;
begin
  wbNiObject(wbNifBlock('BSStripParticleSystem'), 'NiParticleSystem', False);
end;

//===========================================================================
{ BSStripsParticleSystem }
procedure wbDefineBSStripPSysData;
begin
  wbNiObject(wbNifBlock('BSStripPSysData', [
    dfInteger('Max Point Count', dtU16),
    dfFloat('Start Cap Size'),
    dfFloat('End Cap Size'),
    wbBool('Do Z Prepass')
  ]), 'NiPSysData', False);
end;

//===========================================================================
{ BSSkin::Instance }
procedure wbDefineBSSkin__Instance;
begin
  wbNiObject(wbNifBlock('BSSkin::Instance', [
    wbNiPtr('Skeleton Root', 'NiAVObject'),
    wbNiRef('Data', 'BSSkin::BoneData'),
    dfArray('Bones', wbNiPtr('Bones', 'NiObject'), -4, '', [DF_OnBeforeSave, @RemoveNoneLinks]),
    dfArray('Unknown', wbVector3('Unknown'), -4)
  ]), 'NiObject', False);
end;

//===========================================================================
{ BSSkin::BoneData }
procedure wbDefineBSSkin__BoneData;
begin
  wbNiObject(wbNifBlock('BSSkin::BoneData', [
    dfArray('Bones', dfStruct('Bones', [
      wbNiBound('Bounding Sphere'),
      wbRotMatrix33('Rotation'),
      wbVector3('Translation'),
      dfFloat('Scale')
    ]), -4)
  ]), 'NiObject', False);
end;



procedure wbDefineNif;
begin
  v4002    := wbNifVersionToInt('4.0.0.2');
  v4101    := wbNifVersionToInt('4.1.0.1');
  v41012   := wbNifVersionToInt('4.1.0.12');
  v4202    := wbNifVersionToInt('4.2.0.2');
  v4210    := wbNifVersionToInt('4.2.1.0');
  v4220    := wbNifVersionToInt('4.2.2.0');
  v5001    := wbNifVersionToInt('5.0.0.1');
  v10010   := wbNifVersionToInt('10.0.1.0');
  v10012   := wbNifVersionToInt('10.0.1.2');
  v10013   := wbNifVersionToInt('10.0.1.3');
  v10100   := wbNifVersionToInt('10.1.0.0');
  v10018   := wbNifVersionToInt('10.0.1.8');
  v1010101 := wbNifVersionToInt('10.1.0.101');
  v1010106 := wbNifVersionToInt('10.1.0.106');
  v10200   := wbNifVersionToInt('10.2.0.0');
  v10401   := wbNifVersionToInt('10.4.0.1');
  v20103   := wbNifVersionToInt('20.1.0.3');
  v20004   := wbNifVersionToInt('20.0.0.4');
  v20005   := wbNifVersionToInt('20.0.0.5');
  v20007   := wbNifVersionToInt('20.0.0.7');
  v20101   := wbNifVersionToInt('20.1.0.1');
  v20102   := wbNifVersionToInt('20.1.0.2');
  v20205   := wbNifVersionToInt('20.2.0.5');
  v20207   := wbNifVersionToInt('20.2.0.7');


  // Blocks marked with * are not used by vanilla meshes
  // but supported by engine and probably used by mods

  wbDefineNifHeaderFooter;
  wbDefineNiObject;
  wbDefineNiObjectNET;
  wbDefineNiAVObject;
  wbDefineNiAVObjectPalette;
  wbDefineDefaultNiAVObjectPalette;
  wbDefineNiPalette; // *
  wbDefineNiStringPalette;
  wbDefineNiSequenceStreamHelper;
  wbDefineNiNode;
  wbDefineNiBillboardNode;
  wbDefineNiBone; // *
  wbDefineNiAccumulator; // *
  wbDefineNiSortAdjustNode; // *
  wbDefineNiBSAnimationNode;
  wbDefineNiBSParticleNode;
  wbDefineRootCollisionNode;
  wbDefineAvoidNode;
  wbDefineBSFadeNode;
  wbDefineBSLeafAnimNode;
  wbDefineBSTreeNode;
  wbDefineBSOrderedNode;
  wbDefineBSRangeNode;
  wbDefineBSBlastNode;
  wbDefineBSDamageStage;
  wbDefineBSDebrisNode;
  wbDefineBSValueNode;
  wbDefineBSMultiBoundNode;
  wbDefineBSMultiBound;
  wbDefineBSMultiBoundData;
  wbDefineBSMultiBoundAABB;
  wbDefineBSMultiBoundOBB;
  wbDefineBSMultiBoundSphere;
  wbDefineNiSwitchNode;
  wbDefineNiLODNode; // *
  wbDefineNiLODData; // *
  wbDefineNiRangeLODData; // *
  wbDefineNiScreenLODData; // *
  wbDefineNiExtraData;
  wbDefineNiBinaryExtraData;
  wbDefineNiBooleanExtraData;
  wbDefineNiColorExtraData; // *
  wbDefineNiFloatExtraData;
  wbDefineNiFloatsExtraData;
  wbDefineNiIntegerExtraData;
  wbDefineNiIntegersExtraData;
  wbDefineNiStringExtraData;
  wbDefineNiStringsExtraData;
  wbDefineNiTextKeyExtraData;
  wbDefineNiVectorExtraData; // *
  wbDefineNiVertWeightsExtraData;
  wbDefineBSXFlags;
  wbDefineBSInvMarker;
  wbDefineBSFurnitureMarker;
  wbDefineBSFurnitureMarkerNode;
  wbDefineBSBoneLODExtraData;
  wbDefineBSBound;
  wbDefineBSBehaviorGraphExtraData;
  wbDefineBSDecalPlacementVectorExtraData;
  wbDefineBSDistantObjectLargeRefExtraData;
  wbDefineBSWArray;
  wbDefineBSExtraData;
  wbDefineBSClothExtraData;
  wbDefineBSEyeCenterExtraData;
  wbDefineBSPackedCombinedSharedGeomDataExtra;
  wbDefineBSPackedCombinedGeomDataExtra;
  wbDefineBSPositionData;
  wbDefineBSConnectPoint__Parents;
  wbDefineBSConnectPoint__Children;
  wbDefineBSAnimNote;
  wbDefineBSAnimNotes;
  wbDefineNiProperty;
  wbDefineNiAlphaProperty;
  wbDefineNiDitherProperty;
  wbDefineNiFogProperty;
  wbDefineNiMaterialProperty;
  wbDefineNiShadeProperty;
  wbDefineNiStencilProperty;
  wbDefineNiSpecularProperty;
  wbDefineNiTexturingProperty;
  wbDefineNiVertexColorProperty;
  wbDefineNiWireframeProperty;
  wbDefineNiZBufferProperty;
  wbDefineBSShaderProperty;
  wbDefineBSShaderLightingProperty;
  wbDefineBSShaderNoLightingProperty;
  wbDefineBSShaderPPLightingProperty;
  wbDefineBSEffectShaderProperty;
  wbDefineBSLightingShaderProperty;
  wbDefineBSSkyShaderProperty;
  wbDefineBSWaterShaderProperty;
  wbDefineBSDistantTreeShaderProperty;
  wbDefineDistantLODShaderProperty;
  wbDefineHairShaderProperty;
  wbDefineLighting30ShaderProperty;
  wbDefineTallGrassShaderProperty;
  wbDefineTileShaderProperty;
  wbDefineSkyShaderProperty;
  wbDefineVolumetricFogShaderProperty;
  wbDefineWaterShaderProperty;
  wbDefineBSShaderTextureSet;
  wbDefineNiTexture;
  wbDefineNiSourceTexture;
  wbDefineNiSourceCubeMap; // *
  wbDefineNiGeometry;
  wbDefineNiTriBasedGeom;
  wbDefineNiGeometryData;
  wbDefineNiTriBasedGeomData;
  wbDefineNiLines; // *
  wbDefineNiLinesData; // *
  wbDefineNiTriShape;
  wbDefineNiTriShapeData;
  wbDefineNiTriStrips;
  wbDefineNiTriStripsData;
  wbDefineNiScreenElements; // *
  wbDefineNiScreenElementsData; // *
  wbDefineBSLODTriShape;
  wbDefineBSSegmentedTriShape;
  wbDefineBSTriShape;
  wbDefineBSDynamicTriShape;
  wbDefineBSMeshLODTriShape;
  wbDefineBSSubIndexTriShape;
  wbDefineAbstractAdditionalGeometryData;
  wbDefineNiAdditionalGeometryData;
  wbDefineBSPackedAdditionalGeometryData; // *
  wbDefineNiSkinInstance;
  wbDefineBSDismemberInstance;
  wbDefineNiSkinData;
  wbDefineNiSkinPartition;
  wbDefineNiCollisionObject;
  wbDefineNiCollisionData; // *
  wbDefinebhkNiCollisionObject;
  wbDefinebhkCollisionObject;
  wbDefinebhkBlendCollisionObject;
  wbDefinebhkPCollisionObject;
  wbDefinebhkSPCollisionObject;
  wbDefinebhkRefObject;
  wbDefinebhkSerializable;
  wbDefinebhkWorldObject;
  wbDefinebhkPhantom;
  wbDefinebhkShapePhantom;
  wbDefinebhkSimpleShapePhantom;
  wbDefinebhkAabbPhantom;
  wbDefinebhkEntity;
  wbDefinebhkRigidBody;
  wbDefinebhkRigidBodyT;
  wbDefinebhkConstraint;
  wbDefinebhkBallAndSocketConstraint;
  wbDefinebhkBallSocketConstraintChain;
  wbDefinebhkHingeConstraint;
  wbDefinebhkLimitedHingeConstraint;
  wbDefinebhkMalleableConstraint;
  wbDefinebhkPrismaticConstraint;
  wbDefinebhkRagdollConstraint;
  wbDefinebhkStiffSpringConstraint;
  wbDefinebhkBreakableConstraint;
  wbDefinebhkShape;
  wbDefinebhkPlaneShape;
  wbDefinebhkSphereRepShape;
  wbDefinebhkTransformShape;
  wbDefinebhkConvexShape;
  wbDefinebhkConvexListShape;
  wbDefinebhkConvexTransformShape;
  wbDefinebhkSphereShape;
  wbDefinebhkMultiSphereShape;
  wbDefinebhkBoxShape;
  wbDefinebhkCapsuleShape;
  wbDefinebhkConvexVerticesShape;
  wbDefinebhkCompressedMeshShape;
  wbDefinebhkCompressedMeshShapeData;
  wbDefinebhkBvTreeShape;
  wbDefinebhkMoppBvTreeShape;
  wbDefinebhkShapeCollection;
  wbDefinebhkListShape;
  wbDefinebhkMeshShape; // *
  wbDefinebhkNiTriStripsShape;
  wbDefinehkPackedNiTriStripsData;
  wbDefinebhkPackedNiTriStripsShape;
  wbDefinebhkLiquidAction;
  wbDefinebhkOrientHingedBodyAction;
  wbDefinebhkPoseArray;
  wbDefinebhkRagdollTemplate;
  wbDefinebhkRagdollTemplateData;
  wbDefinebhkSystem;
  wbDefinebhkNPCollisionObject;
  wbDefinebhkPhysicsSystem;
  wbDefinebhkRagdollSystem;
  wbDefineNiDynamicEffect;
  wbDefineNiLight;
  wbDefineNiAmbientLight;
  wbDefineNiDirectionalLight;
  wbDefineNiPointLight;
  wbDefineNiSpotLight; // *
  wbDefineNiTextureEffect;
  wbDefineNiBoolData;
  wbDefineNiColorData;
  wbDefineNiFloatData;
  wbDefineNiMorphData;
  wbDefineNiPosData;
  wbDefineNiUVData;
  wbDefineNiVISData;
  wbDefineATextureRenderData;
  wbDefineNiPixelData;
  wbDefineNiInterpolator;
  wbDefineNiKeyBasedInterpolator;
  wbDefineNiFloatInterpolator;
  wbDefineNiTransformInterpolator;
  wbDefineNiPoint3Interpolator;
  wbDefineNiPathInterpolator;
  wbDefineNiBoolInterpolator;
  wbDefineNiBoolTimelineInterpolator;
  wbDefineNiBlendInterpolator;
  wbDefineNiBlendBoolInterpolator;
  wbDefineNiBlendFloatInterpolator;
  wbDefineNiBlendPoint3Interpolator;
  wbDefineNiBlendTransformInterpolator;
  wbDefineNiLookAtInterpolator;
  wbDefineNiBSplineInterpolator;
  wbDefineNiBSplineFloatInterpolator;
  wbDefineNiBSplineCompFloatInterpolator;
  wbDefineNiBSplinePoint3Interpolator;
  wbDefineNiBSplineCompPoint3Interpolator;
  wbDefineNiBSplineTransformInterpolator;
  wbDefineNiBSplineCompTransformInterpolator;
  wbDefineNiBSplineData;
  wbDefineNiBSplineBasisData;
  wbDefineBSRotAccumTransfInterpolator;
  wbDefineBSTreadTransfInterpolator;
  wbDefineNiTimeController;
  wbDefineNiLookAtController; // *
  wbDefineNiInterpController;
  wbDefineNiMorpherController; // *
  wbDefineNiSingleInterpController;
  wbDefineNiRollController; // *
  wbDefineNiBoolInterpController;
  wbDefineNiVisController;
  wbDefineNiExtraDataController;
  wbDefineNiFloatExtraDataController;
  wbDefineNiFloatsExtraDataController;
  wbDefineNiFloatsExtraDataPoint3Controller;
  wbDefineNiPoint3InterpController;
  wbDefineNiMaterialColorController;
  wbDefineNiLightColorController;
  wbDefineNiBoneLODController;
  wbDefineNiBSBoneLODController;
  wbDefinebhkBlendController;
  wbDefineNiKeyframeController;
  wbDefineBSKeyframeController;
  wbDefineNiKeyframeData;
  wbDefineNiTransformData;
  wbDefineNiTransformController;
  wbDefineNiMultiTargetTransformController;
  wbDefineNiParticleSystemController;
  wbDefineNiBSPArrayController;
  wbDefineNiGeomMorpherController;
  wbDefineNiPathController;
  wbDefineNiUVController;
  wbDefineNiPSysModifierCtlr;
  wbDefineNiPSysEmitterCtlr;
  wbDefineNiPSysEmitterCtlrData; // *
  wbDefineNiPSysModifierBoolCtlr;
  wbDefineNiPSysModifierActiveCtlr;
  wbDefineNiPSysModifierFloatCtlr;
  wbDefineNiPSysEmitterDeclinationCtlr;
  wbDefineNiPSysEmitterDeclinationVarCtlr;
  wbDefineNiPSysEmitterInitialRadiusCtlr;
  wbDefineNiPSysEmitterLifeSpanCtlr;
  wbDefineNiPSysInitialRotSpeedCtlr;
  wbDefineNiPSysInitialRotVarSpeedCtlr;
  wbDefineNiPSysInitialRotAngleCtlr;
  wbDefineNiPSysInitialRotAngleVarCtlr;
  wbDefineNiPSysEmitterPlanarAngleCtlr;
  wbDefineNiPSysEmitterPlanarAngleVarCtlr;
  wbDefineNiPSysEmitterSpeedCtlr;
  wbDefineNiPSysGravityStrengthCtlr;
  wbDefineNiPSysAirFieldAirFrictionCtlr; // *
  wbDefineNiPSysAirFieldInheritVelocityCtlr; // *
  wbDefineNiPSysAirFieldSpreadCtlr; // *
  wbDefineNiPSysFieldAttenuationCtlr; // *
  wbDefineNiPSysFieldMagnitudeCtlr; // *
  wbDefineNiPSysFieldMaxDistanceCtlr; // *
  wbDefineNiPSysResetOnLoopCtlr;
  wbDefineNiPSysUpdateCtlr;
  wbDefineBSPSysMultiTargetEmitterCtlr;
  wbDefineNiFloatInterpController;
  wbDefineNiFlipController;
  wbDefineNiAlphaController;
  wbDefineNiLightDimmerController;
  wbDefineNiLightRadiusController;
  wbDefineNiTextureTransformController;
  wbDefineBSEffectShaderPropertyFloatController;
  wbDefineBSEffectShaderPropertyColorController;
  wbDefineBSLightingShaderPropertyFloatController;
  wbDefineBSLightingShaderPropertyColorController;
  wbDefineBSLightingShaderPropertyUShortController;
  wbDefineBSFrustumFOVController;
  wbDefineBSLagBoneController;
  wbDefineBSMaterialEmittanceMultController;
  wbDefineBSNiAlphaPropertyTestRefController;
  wbDefineBSProceduralLightningController;
  wbDefineBSRefractionFirePeriodController;
  wbDefineBSRefractionStrengthController;
  wbDefineNiControllerManager;
  wbDefineNiCamera;
  wbDefineNiSequence;
  wbDefineNiControllerSequence;
  wbDefineNiParticles;
  wbDefineNiAutoNormalParticles;
  wbDefineNiRotatingParticles;
  wbDefineNiParticleMeshes;
  wbDefineNiParticleSystem;
  wbDefineNiMeshParticleSystem;
  wbDefineNiParticlesData;
  wbDefineNiAutoNormalParticlesData;
  wbDefineNiRotatingParticlesData;
  wbDefineNiParticleMeshesData; // *
  wbDefineNiParticleModifier;
  wbDefineNiParticleBomb; // *
  wbDefineNiSphericalCollider; // *
  wbDefineNiParticleColorModifier;
  wbDefineNiParticleMeshModifier;
  wbDefineNiGravity;
  wbDefineNiParticleGrowFade;
  wbDefineNiParticleRotation;
  wbDefineNiPlanarCollider;
  wbDefineNiPSysCollider;
  wbDefineNiPSysPlanarCollider;
  wbDefineNiPSysSphericalCollider;
  wbDefineNiPSysData;
  wbDefineNiMeshPSysData;
  wbDefineNiPSysModifier;
  wbDefineNiPSysColliderManager;
  wbDefineNiPSysAgeDeathModifier;
  wbDefineNiPSysBombModifier;
  wbDefineNiPSysGravityModifier;
  wbDefineNiPSysGrowFadeModifier;
  wbDefineNiPSysBoundUpdateModifier;
  wbDefineNiPSysColorModifier;
  wbDefineNiPSysDragModifier;
  wbDefineNiPSysMeshUpdateModifier;
  wbDefineNiPSysPositionModifier;
  wbDefineNiPSysRotationModifier;
  wbDefineNiPSysSpawnModifier;
  wbDefineNiPSysFieldModifier; // *
  wbDefineNiPSysAirFieldModifier; // *
  wbDefineNiPSysDragFieldModifier; // *
  wbDefineNiPSysGravityFieldModifier; // *
  wbDefineNiPSysRadialFieldModifier; // *
  wbDefineNiPSysVortexFieldModifier; // *
  wbDefineNiPSysTurbulenceFieldModifier; // *
  wbDefineBSParentVelocityModifier;
  wbDefineBSWindModifier;
  wbDefineBSPSysHavokUpdateModifier;
  wbDefineBSPSysInheritVelocityModifier;
  wbDefineBSPSysLODModifier;
  wbDefineBSPSysRecycleBoundModifier;
  wbDefineBSPSysSimpleColorModifier;
  wbDefineBSPSysScaleModifier;
  wbDefineBSPSysStripUpdateModifier;
  wbDefineBSPSysSubTexModifier;
  wbDefineNiPSysEmitter;
  wbDefineNiPSysVolumeEmitter;
  wbDefineNiPSysBoxEmitter;
  wbDefineNiPSysCylinderEmitter;
  wbDefineNiPSysSphereEmitter;
  wbDefineNiPSysMeshEmitter;
  wbDefineBSPSysArrayEmitter;
  wbDefineBSMasterParticleSystem;
  wbDefineBSStripParticleSystem;
  wbDefineBSStripPSysData;
  wbDefineBSSkin__Instance;
  wbDefineBSSkin__BoneData;
end;


initialization
  {$IF CompilerVersion < 34.0}
  Sync := TReadWriteSync.Create;
  {$IFEND}
  NifDefsInitialized := False;

finalization
  FreeNiObjectDefs;

end.

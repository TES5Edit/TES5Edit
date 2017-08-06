unit wbDataFormatMisc;

interface

uses
  SysUtils, wbDataFormat;

type
  // Tree LOD index file (*.LST in Skyrim, SSE, Fallout3 and New Vegas)
  TwbLODTreeLSTFile = class(TdfArray)
    constructor Create; reintroduce; overload;
  end;

  // Tree LOD references file (*.BTT in Skyrim and SSE, *.DTL in Fallout3 and New Vegas)
  TwbLODTreeBTTFile = class(TdfArray)
    constructor Create; reintroduce; overload;
  end;

  // Tree LOD references file (*.BTT in Skyrim and SSE, *.DTL in Fallout3 and New Vegas)
  TwbFUZFile = class(TdfStruct)
    constructor Create; reintroduce; overload;
    function UnSerialize(const aDataStart, aDataEnd: Pointer; const aDataSize: Integer): Integer; override;
  end;


implementation

var
  dfLODTreeLST: TdfArrayDef;
  dfLODTreeBTT: TdfArrayDef;
  dfFUZ: TdfStructDef;

procedure FUZ_GetLIPSize(const e: TdfElement; var aCount: Integer); begin aCount := e.NativeValues['..\LIP Size']; end;
procedure FUZ_BeforeSaveLIPSize(const e: TdfElement); begin e.NativeValue := e.Elements['..\LIP Data'].DataSize; end;

procedure wbDefineMisc;
begin
  if Assigned(dfLODTreeLst) then
    Exit;

  dfLODTreeLST :=
    dfArray('Trees', dfStruct('Tree', [
      dfInteger('Type', dtU32),
      dfFloat('Width'),
      dfFloat('Height'),
      dfStruct('Atlas Position', [
        dfStruct('Min', [
          dfFloat('U'),
          dfFloat('V')
        ]),
        dfStruct('Max', [
          dfFloat('U'),
          dfFloat('V')
        ])
      ]),
      dfInteger('Unknown', dtU32)
    ]), -4);

  dfLODTreeBTT :=
    dfArray('Trees', dfStruct('Tree', [
      dfInteger('Type', dtU32),
      dfArray('References', dfStruct('Refefence', [
        dfFloat('X'),
        dfFloat('Y'),
        dfFloat('Z'),
        dfFloat('Rotation'),
        dfFloat('Scale', '1.0'),
        dfInteger('FormID', dtU32),
        dfInteger('Unknown 1', dtU32),
        dfInteger('Unknown 2', dtU32)
      ]), -4)
    ]), -4);

  dfFUZ := dfStruct('FUZ', [
    dfChars('Magic', 4, 'FUZE', #0, False, []),
    dfInteger('Version', dtU32, '1'),
    // keeping LIP Size separate from data so LoadFromFile/SaveToFile can be used directly on LIP Data
    dfInteger('LIP Size', dtU32, [DF_OnBeforeSave, @FUZ_BeforeSaveLIPSize]),
    dfBytes('LIP Data', 0, [DF_OnGetCount, @FUZ_GetLIPSize]),
    dfBytes('XWM Data', 0)
  ]);
end;


constructor TwbLODTreeLSTFile.Create;
begin
  wbDefineMisc;
  inherited Create(dfLODTreeLST, nil);
end;

constructor TwbLODTreeBTTFile.Create;
begin
  wbDefineMisc;
  inherited Create(dfLODTreeBTT, nil);
end;

constructor TwbFUZFile.Create;
begin
  wbDefineMisc;
  inherited Create(dfFUZ, nil);
end;

function TwbFUZFile.UnSerialize(const aDataStart, aDataEnd: Pointer; const aDataSize: Integer): Integer;
type
  TMagic = array [0..3] of AnsiChar;
  PMagic = ^TMagic;
const
  sMagicFUZ: TMagic = 'FUZE';
begin
  Result := PByte(aDataEnd) - PByte(aDataStart);

  if Assigned(aDataStart) and not ((Result > SizeOf(TMagic)) and (PMagic(aDataStart)^ = sMagicFUZ)) then
    raise Exception.Create('Not a FUZ file');

  Result := inherited;
end;


initialization

finalization

  FreeAndNil(dfLODTreeLST);
  FreeAndNil(dfLODTreeBTT);
  FreeAndNil(dfFUZ);


end.

unit FileContainer;

interface

uses
  System.SysUtils, System.Classes;

type
  TFileContainer = class(TComponent)
  protected {private}
    fCompressed: Boolean;
    fData: TBytes;

    function GetData: TBytes;
    procedure SetData(const Value: TBytes);

    procedure ReadCompressedData(aStream: TStream);
    procedure WriteCompressedData(aStream: TStream);
  protected {private}
    procedure DefineProperties(Filer: TFiler); override;
  public
    constructor Create(aOwner: TComponent); virtual;

    procedure LoadFromFile(const aFileName: string);
    procedure LoadFromStream(aStream: TStream);
    procedure SaveToFile(const aFileName: string);
    procedure SaveToStream(aStream: TStream);

    function CreateReadStream: TStream;

    property Data: TBytes
      read GetData //returns a copy
      write SetData;
  published
    property Compressed: Boolean
      read fCompressed
      write fCompressed
      default True;
  end;

function SameBytes(const a,b: TBytes): Boolean;

implementation

uses
  zlib;

function SameBytes(const a,b: TBytes): Boolean;
var
  i: Integer;
begin
  Result := Length(a) = Length(b);
  if Result then
    for i := Low(a) to High(a) do
      if a[i] <> b[i] then
        Exit(False);
end;

{ TFileContainer }

constructor TFileContainer.Create(aOwner: TComponent);
begin
  fCompressed := True;
  inherited;
end;

function TFileContainer.CreateReadStream: TStream;
begin
  Result := TBytesStream.Create(GetData);
end;

procedure TFileContainer.DefineProperties(Filer: TFiler);

  function DoWrite: Boolean;
  begin
    if Assigned(Filer.Ancestor) then begin
      Result := True;
      if Filer.Ancestor is TFileContainer then
        Result := not SameBytes(TFileContainer(Filer.Ancestor).fData, fData);
    end else
      Result := Length(fData) > 0;
  end;

begin
  inherited;
  Filer.DefineBinaryProperty('Data', LoadFromStream, SaveToStream, not fCompressed and DoWrite);
  Filer.DefineBinaryProperty('CompressedData', ReadCompressedData, WriteCompressedData, fCompressed and DoWrite);
end;

function TFileContainer.GetData: TBytes;
begin
  Result := Copy(fData);
end;

procedure TFileContainer.LoadFromFile(const aFileName: string);
var
  Stream: TFileStream;
begin
  Stream := TFileStream.Create(aFileName, fmOpenRead);
  try
    LoadFromStream(Stream);
  finally
    Stream.Free;
  end;
end;

procedure TFileContainer.LoadFromStream(aStream: TStream);
var
  l     : Int64;
  Bytes : TBytes;
begin
  l := aStream.Size;
  Bytes := nil;
  SetLength(Bytes, l);
  aStream.Position := 0;
  if l > 0 then
    aStream.Read(Bytes, l);
  fData := Bytes;
end;

procedure TFileContainer.ReadCompressedData(aStream: TStream);
var
  Stream: TBytesStream;
begin
  Stream := TBytesStream.Create;
  try
    ZDecompressStream(aStream, Stream);
    fData := Copy(Stream.Bytes);
    if Length(fData) > Stream.Size then
      SetLength(fData, Stream.Size);
  finally
    Stream.Free;
  end;
end;

procedure TFileContainer.SaveToFile(const aFileName: string);
var
  Stream: TFileStream;
begin
  Stream := TFileStream.Create(aFileName, fmCreate);
  try
    SaveToStream(Stream);
  finally
    Stream.Free;
  end;
end;

procedure TFileContainer.SaveToStream(aStream: TStream);
var
  l: Int64;
begin
  l := Length(fData);
  if l > 0 then
    aStream.Write(fData, l);
end;

procedure TFileContainer.SetData(const Value: TBytes);
begin
  fData := Copy(Value);
end;

procedure TFileContainer.WriteCompressedData(aStream: TStream);
var
  Stream: TStream;
begin
  Stream := CreateReadStream;
  try
    ZCompressStream(Stream, aStream);
  finally
    Stream.Free;
  end;
end;

end.

unit uESSFile;

{$IF CompilerVersion >= 17} {$DEFINE USEREGION} {$IFEND}

interface

uses
  Windows, Graphics, ZLib;

{$IF Defined(USEREGION)}{$REGION 'ESS Types'}{$IFEND}
const
  C_TESVESS = 'TESV_SAVEGAME';

type
  TBytes = array of Byte;
  PBytes = ^TBytes;

  uint32 = cardinal;
  uint16 = word;
  uint8 = byte;
  int32 = integer;
  int16 = smallint;
  int8 = shortint;
  float32 = single;
  float64 = double;
  float = float32;
  wstring = record
    w: word;
    s: array of char;
  end;
  filetime= TFileTime;

  TRefID = packed record
    byte0, byte1, byte2: uint8;
  end;

  vsval = uint32;

  TMagic = array[0..12] of char;

  THeader = packed record
    version: uint32;
    saveNumber: uint32; //Save number, used for default name of save file. Presumably this is a counter keeping track of the total number of saves you have made to date.
    playerName: wstring;
    playerLevel: uint32;
    playerLocation: wstring;
    gameDate:	wstring; //In-game date at the time of saving.
    playerRaceEditorId:	wstring;
    unknown1:	uint16;
    unknown2:	float32;
    unknown3:	float32;
    filetime:	filetime;
    shotWidth:	uint32;	//Screenshot width (in pixels).
    shotHeight:	uint32;	//Screenshot height (in pixels).
  end;

  TPluginInfo = packed record
    pluginCount: uint8;
    plugins: array of wstring; //pluginCount
  end;

  TFileLocationTable = packed record
    formIDArrayOffest: uint32; //Absolute offset to the start of File.formIDArray.
    unknownTable3Offset: uint32; //Absolute offset to the start of File.unknown3TableSize.
    globalDataTable1Offset:	uint32;	//Absolute offset to the start of File.globalDataTable1.
    globalDataTable2Offset:	uint32;	//Absolute offset to the start of File.globalDataTable2.
    changeFormsOffset: uint32; //	Absolute offset to the start of File.changeForms.
    globalDataTable3Offset:	uint32;	//Absolute offset to the start of File.globalDataTable3.
    globalDataTable1Count: uint32; //The number of Global Data in File.globalDataTable1 (9).
    globalDataTable2Count: uint32; //The number of Global Data in File.globalDataTable2 (15).
    globalDataTable3Count: uint32; //The number of Global Data in File.globalDataTable3 (5 -- bugged).
                                   //Note: This count is currently bugged (as of version 112) that it
                                   //does not include type 1001 (Papyrus) in the count. This causes
                                   //Skyrim to never read the final type in this table, which is typically
                                   //type 1005 (Main), thankfully the bug is harmless since this type
                                   //never has any data.
    changeFormCount: uint32;
    unused:	array [1..15] of uint32;
  end;

  TGlobalData = packed record
    _type: uint32;
    _length:	uint32;
    data: TBytes; //length
  end;

  TChangeForm = packed record
    formID: TRefID;
    changeFlags: uint32;
    _type: uint8;
    version: uint8; //Current as of Skyrim 1.1.21.0 is 57
    length1: uint32; //depends on flags	Length of following data.
    length2:uint32;	//depends on flags	If this value is non-zero, data is compressed. This value then represents the uncompressed length.
    data: TBytes; //length1
  end;
  TChangeForms = array of	TChangeForm;
  PChangeForms = ^TChangeForms;

  TUnknown3Table = packed record
    count: uint32;
    unknown: array of wstring; //count
  end;
{$IF Defined(USEREGION)}{$ENDREGION 'ESS Types'}{$IFEND}

  TESSFile = packed record
    magic: TMagic;  //Constant: "TESV_SAVEGAME"
    headerSize: uint32; //Size of the header.
    Header: THeader;
    screenshotData: TBytes; //[3*shotWidth*shotHeight]	RGB pixel data of the image.
    formVersion: uint8; //current as of Skyrim 1.1.21 is 57.
    pluginInfoSize: uint32; //Size of the plugin information.
    pluginInfo:	TPluginInfo;
    fileLocationTable: TFileLocationTable;
    globalDataTable1:	array of TGlobalData; //Types 0 to 8. fileLocationTable.globalDataTable1Count
    globalDataTable2:	array of TGlobalData;	//Types 100 to 114. fileLocationTable.globalDataTable2Count
    changeForms: TChangeForms; //fileLocationTable.changeFormCount
    globalDataTable3: array	of TGlobalData; //Types 1000 to 1005. fileLocationTable.globalDataTable3Count
    formIDArrayCount:	uint32;
    formIDArray: array of	record
                   ID: TRefID; //fileLocationTable.formIDArrayCount
                   Count: uint8
                 end;
    unknown2TableCount:	uint32;
    unknown2Table: array of	uint32; //unknownTable2Count
    unknown3TableSize:	uint32;	//Size in bytes of unknown3Table.
    unknown3Table: TUnknown3Table;
  end;
  TProgress = procedure (const Percent: Integer; var Break: Boolean) of object;
  TESSFileInfo = packed record
    saveNumber: uint32;
    playerName: string;
    playerLevel: uint32;
    playerLocation: string;
    gameDate:	string;
    playerRaceEditorId:	string;
    shotWidth:	uint32;
    shotHeight:	uint32;
    screenshotData: TBytes;
  end;

var
  LastIOState: Integer;

{$IF Defined(USEREGION)}{$REGION 'ESS Convert Funtions'}{$IFEND}
function IntToBin(value: Int64; digits: integer): string;
function BinToInt(value: string): Int64;
function MagicToString(v: TMagic): string;
function StringToMagic(v: string): TMagic;
function wstringToString(v: wstring): string;
function StringTowstring(v: string): wstring;
function FileTimeToString(v: TFileTime): string;
function RefIDToString(v: TRefID): string;
function RefIDToHex(v: TRefID): string;
function ScreenShotToBMP(Width, Height: uint32; var v: TBytes): TBitmap;
function BMPToScreenShot(var Width, Height: uint32; v: TBitmap): TBytes;
function DecompressData(var Data: TBytes; var DestSize: uint32): Boolean;
function CompressData(var Data: TBytes; CompressionLevel: TCompressionLevel = clMax): Boolean;
{$IF Defined(USEREGION)}{$ENDREGION}{$IFEND}

{$IF Defined(USEREGION)}{$REGION 'ESS Read Funtions'}{$IFEND}
//f - file open to read and with byte by byte access - 'Reset(f, 1)'
function Get_uint32(var f: file; var v: Cardinal): Boolean;
function Get_uint16(var f: file; var v: Word): Boolean;
function Get_uint8(var f: file; var v: Byte): Boolean;
function Get_int32(var f: file; var v: integer): Boolean;
function Get_int16(var f: file; var v: SmallInt): Boolean;
function Get_int8(var f: file; var v: ShortInt): Boolean;
function Get_float32(var f: file; var v: Single): Boolean;
function Get_float64(var f: file; var v: Double): Boolean;
function Get_RefID(var f: file; var v: TRefID): Boolean;
function Get_data(var f: file; var v: TBytes): Boolean;
function Get_wstring(var f: file; var v: wstring): Boolean;
function Get_magic(var f: file; var v: TMagic): Boolean;
function Get_filetime(var f: file; var v: TFileTime): Boolean;
function Get_screenshotData(var f: file; Width, Height: uint32; var v: TBytes): Boolean;
function Get_vlen(var f: file; s: uint; var v: uint): Boolean;
{$IF Defined(USEREGION)}{$ENDREGION}{$IFEND}

{$IF Defined(USEREGION)}{$REGION 'Read buffer function'}{$IFEND}
//after read FromPos moved to new position or set to 0 if read space is not enough
function Read_uint32(var Buf: TBytes; var FromPos: Integer): uint32;
function Read_uint16(var Buf: TBytes; var FromPos: Integer): uint16;
function Read_uint8(var Buf: TBytes; var FromPos: Integer): uint8;
function Read_int32(var Buf: TBytes; var FromPos: Integer): int32;
function Read_int16(var Buf: TBytes; var FromPos: Integer): int16;
function Read_int8(var Buf: TBytes; var FromPos: Integer): int8;
function Read_float32(var Buf: TBytes; var FromPos: Integer): float32;
function Read_float64(var Buf: TBytes; var FromPos: Integer): float64;
function Read_RefID(var Buf: TBytes; var FromPos: Integer): TRefID;
function Read_wstring(var Buf: TBytes; var FromPos: Integer): wstring;
function Read_vsval(var Buf: TBytes; var FromPos: Integer): vsval;
{$IF Defined(USEREGION)}{$ENDREGION}{$IFEND}

{$IF Defined(USEREGION)}{$REGION 'String represenations'}{$IFEND}
function GetCategoryString(Category: uint8): string;
function GetTypeString(_Type: uint32): string;
function GetFormString(Form: uint32): string;
{$IF Defined(USEREGION)}{$ENDREGION}{$IFEND}

procedure FreeESSFile(var ESSFile: TESSFile);
procedure FreeESSFileInfo(var ESSFileInfo: TESSFileInfo);

function ReadESSFile(var ESSFile: TESSFile; sFileName: string; Progress: TProgress = nil): integer;
function ReadESSFileUncompressed(var ESSFile: TESSFile; sFileName: string; Progress: TProgress = nil): integer;
function SaveESSFile(var ESSFile: TESSFile; sFileName: string; Progress: TProgress = nil): Integer;
function SaveESSFileUncompressed(var ESSFile: TESSFile; sFileName: string; Progress: TProgress = nil): Integer;
function SaveESSFileCompressed(var ESSFile: TESSFile; sFileName: string; Progress: TProgress = nil; CompressionLevel: TCompressionLevel = clMax): Integer;
function ReadESSFileInfo(var ESSFileInfo: TESSFileInfo; sFileName: string): integer;

function RefID(byte0, byte1, byte2: Byte): TRefID;
function RefIDCompare(Ref1, Ref2: TRefID): integer;

function AddToChangeForm(aForms: PChangeForms; aID: TRefID; aFlags: uint32; aType: uint8; aData: PBytes = nil; aLen: uint32 = 0; aCompress: Boolean = False): integer;

implementation

uses
  SysUtils, Classes;

{$IF Defined(USEREGION)}{$REGION 'Convert functions'}{$IFEND}
function IntToBin(value: Int64; digits: integer): string;
begin
  Result := StringOfChar('0', digits);
  while value > 0 do
  begin
    if (value and 1) <> 0 then
      Result[digits] := '1';
    Dec(digits) ;
    value := value shr 1;
  end;
end;

function BinToInt(value: string): Int64;
begin
  Result := 0;
  if Length(value) > 32 then
    SetLength(Value, 32);
  while value <> '' do
  begin
    Result := Result shl 1;
    if Value[1] = '1' then
      Result := Result or 1;
    Delete(value, 1, 1);
  end;
end;

function MagicToString(v: TMagic): string;
begin
  if Length(v) > 0 then
    SetString(Result, PAnsiChar(@v[0]), Length(v));
end;

function StringToMagic(v: string): TMagic;
begin
  if Length(v) < SizeOf(Result) then
  begin
    ZeroMemory(@Result[0], SizeOf(Result));
    if v <> '' then
      Move(v[1], Result[0], Length(v));
  end
  else
    Move(v[1], Result[0], SizeOf(Result));
end;

function wstringToString(v: wstring): string;
begin
  if v.w > 0 then
    SetString(Result, PAnsiChar(@v.s[0]), v.w)
  else
    Result := '';
end;

function StringTowstring(v: string): wstring;
begin
  Result.w := Length(v);
  SetLength(Result.s, Result.w);
  if Result.w > 0 then
    Move(v[1], Result.s[0], Result.w)
end;

function FileTimeToString(v: TFileTime): string;
var
  LocalFileTime: TFileTime;
  SystemTime: TSystemTime;
begin
  if FileTimeToLocalFileTime(v, LocalFileTime) and FileTimeToSystemTime(LocalFileTime, SystemTime) then
    Result := DateTimeToStr(SystemTimeToDateTime(SystemTime))
  else
    Result := '';
end;

function RefIDToString(v: TRefID): string;
begin
  Result := IntToHex(v.byte0, 2) + ' ' + IntToHex(v.byte1, 2) + ' ' + IntToHex(v.byte2, 2);
end;

function RefIDToHex(v: TRefID): string;
begin
  Result := IntToHex(v.byte0, 2) + IntToHex(v.byte1, 2) + IntToHex(v.byte2, 2);
end;

type
  TRGBArray = array[0..MaxInt div SizeOf(TRGBTriple) - 1] of TRGBTriple;
  PRGBArray = ^TRGBArray;

function ScreenShotToBMP(Width, Height: uint32; var v: TBytes): TBitmap;
var
  w, h: Integer;
  Row: PRGBArray;
begin
  if Integer(3 * Width * Height) = Length(v) then
  begin
    Result := TBitmap.Create;
    Result.PixelFormat := pf24bit;
    Result.Width := Width;
    Result.Height := Height;
    with Result do
      for h := 0 to Height - 1 do
      begin
        Row := PRGBArray(Scanline[h]);
        for w := 0 to Width - 1 do
        begin
          Row[w].rgbtRed := v[(h * Width + w) * 3 + 0];
          Row[w].rgbtGreen := v[(h * Width + w) * 3 + 1];
          Row[w].rgbtBlue := v[(h * Width + w) * 3 + 2];
        end;
      end;
  end
  else
    Result := nil;
end;

function BMPToScreenShot(var Width, Height: uint32; v: TBitmap): TBytes;
var
  w, h: Integer;
  Row: PRGBArray;
begin
  if v.PixelFormat = pf24bit then
  begin
    SetLength(Result, 3 * Width * Height);
    Width := v.Width;
    Height := v.Height;
    for h := 0 to Height - 1 do
    begin
      Row := PRGBArray(v.Scanline[h]);
      for w := 0 to Width - 1 do
      begin
        Result[(h * Integer(Width) + w) * 3 + 0] := Row[w].rgbtRed;
        Result[(h * Integer(Width) + w) * 3 + 1] := Row[w].rgbtGreen;
        Result[(h * Integer(Width) + w) * 3 + 2] := Row[w].rgbtBlue;
      end;
    end;
  end
  else
  begin
    Width := 0;
    Height := 0;
    SetLength(Result, 0);
  end;
end;

function DecompressData(var Data: TBytes; var DestSize: uint32): Boolean;
var
  DS: TDecompressionStream;
  MS: TMemoryStream;
begin
  Result := False;
  if DestSize > 0 then
  begin
    MS := TMemoryStream.Create;
    MS.WriteBuffer(Data[0], Length(Data));
    MS.Position := 0;
    try
      try
        DS := TDecompressionStream.Create(MS);
        try
          SetLength(Data, DestSize);
          DS.ReadBuffer(Data[0], Length(Data));
          Result := True;
        finally
          DS.Free;
        end;
      except
      end;
    finally
      MS.Free;
    end;
  end;
end;

function CompressData(var Data: TBytes; CompressionLevel: TCompressionLevel = clMax): Boolean;
var
  CS: TCompressionStream;
  MS: TMemoryStream;
begin
  Result := False;
  if Length(Data) > 0 then
  begin
    MS := TMemoryStream.Create;
    try
      try
        CS := TCompressionStream.Create(CompressionLevel, MS);
        try
          CS.WriteBuffer(Data[0], Length(Data));
        finally
          CS.Free;
        end;
        if MS.Size < Length(Data) then
        begin
          SetLength(Data, MS.Size);
          MS.Position := 0;
          MS.ReadBuffer(Data[0], Length(Data));
          Result := True;
        end;
      except
      end;
    finally
      MS.Free;
    end;
  end;
end;
{$IF Defined(USEREGION)}{$ENDREGION}{$IFEND}

{$IF Defined(USEREGION)}{$REGION 'Read file functions'}{$IFEND}
function Get_uint32(var f: file; var v: Cardinal): Boolean;
begin
  {$IFOPT I+} {$DEFINE IOCHECKS_ON} {$ENDIF} {$I-}
  BlockRead(f, v, SizeOf(v));
  LastIOState := IOResult; Result := LastIOState = 0;
  {$IFDEF IOCHECKS_ON} {$I+} {$UNDEF IOCHECKS_ON} {$ENDIF}
end;

function Get_uint16(var f: file; var v: Word): Boolean;
begin
  {$IFOPT I+} {$DEFINE IOCHECKS_ON} {$ENDIF} {$I-}
  BlockRead(f, v, SizeOf(v));
  LastIOState := IOResult; Result := LastIOState = 0;
  {$IFDEF IOCHECKS_ON} {$I+} {$UNDEF IOCHECKS_ON} {$ENDIF}
end;

function Get_uint8(var f: file; var v: Byte): Boolean;
begin
  {$IFOPT I+} {$DEFINE IOCHECKS_ON} {$ENDIF} {$I-}
  BlockRead(f, v, SizeOf(v));
  LastIOState := IOResult; Result := LastIOState = 0;
  {$IFDEF IOCHECKS_ON} {$I+} {$UNDEF IOCHECKS_ON} {$ENDIF}
end;

function Get_int32(var f: file; var v: integer): Boolean;
begin
  {$IFOPT I+} {$DEFINE IOCHECKS_ON} {$ENDIF} {$I-}
  BlockRead(f, v, SizeOf(v));
  LastIOState := IOResult; Result := LastIOState = 0;
  {$IFDEF IOCHECKS_ON} {$I+} {$UNDEF IOCHECKS_ON} {$ENDIF}
end;

function Get_int16(var f: file; var v: SmallInt): Boolean;
begin
  {$IFOPT I+} {$DEFINE IOCHECKS_ON} {$ENDIF} {$I-}
  BlockRead(f, v, SizeOf(v));
  LastIOState := IOResult; Result := LastIOState = 0;
  {$IFDEF IOCHECKS_ON} {$I+} {$UNDEF IOCHECKS_ON} {$ENDIF}
end;

function Get_int8(var f: file; var v: ShortInt): Boolean;
begin
  {$IFOPT I+} {$DEFINE IOCHECKS_ON} {$ENDIF} {$I-}
  BlockRead(f, v, SizeOf(v));
  LastIOState := IOResult; Result := LastIOState = 0;
  {$IFDEF IOCHECKS_ON} {$I+} {$UNDEF IOCHECKS_ON} {$ENDIF}
end;

function Get_float32(var f: file; var v: Single): Boolean;
begin
  {$IFOPT I+} {$DEFINE IOCHECKS_ON} {$ENDIF} {$I-}
  BlockRead(f, v, SizeOf(v));
  LastIOState := IOResult; Result := LastIOState = 0;
  {$IFDEF IOCHECKS_ON} {$I+} {$UNDEF IOCHECKS_ON} {$ENDIF}
end;

function Get_float64(var f: file; var v: Double): Boolean;
begin
  {$IFOPT I+} {$DEFINE IOCHECKS_ON} {$ENDIF} {$I-}
  BlockRead(f, v, SizeOf(v));
  LastIOState := IOResult; Result := LastIOState = 0;
  {$IFDEF IOCHECKS_ON} {$I+} {$UNDEF IOCHECKS_ON} {$ENDIF}
end;

function Get_RefID(var f: file; var v: TRefID): Boolean;
begin
  {$IFOPT I+} {$DEFINE IOCHECKS_ON} {$ENDIF} {$I-}
  BlockRead(f, v, SizeOf(v));
  LastIOState := IOResult; Result := LastIOState = 0;
  {$IFDEF IOCHECKS_ON} {$I+} {$UNDEF IOCHECKS_ON} {$ENDIF}
end;

function Get_data(var f: file; var v: TBytes): Boolean;
begin
  {$IFOPT I+} {$DEFINE IOCHECKS_ON} {$ENDIF} {$I-}
  if Length(v) > 0 then
    BlockRead(f, v[0], Length(v));
  LastIOState := IOResult; Result := LastIOState = 0;
  {$IFDEF IOCHECKS_ON} {$I+} {$UNDEF IOCHECKS_ON} {$ENDIF}
end;

function Get_wstring(var f: file; var v: wstring): Boolean;
begin
  {$IFOPT I+} {$DEFINE IOCHECKS_ON} {$ENDIF} {$I-}
  BlockRead(f, v.w, SizeOf(v.w));
  LastIOState := IOResult; Result := LastIOState = 0;
  if Result then
  begin
    SetLength(v.s, v.w);
    if v.w > 0 then
      BlockRead(f, v.s[0], v.w);
    LastIOState := IOResult; Result := LastIOState = 0;
  end;
  if not Result then
  begin
    v.w := 0;
    SetLength(v.s, 0);
  end;
  {$IFDEF IOCHECKS_ON} {$I+} {$UNDEF IOCHECKS_ON} {$ENDIF}
end;

function Get_magic(var f: file; var v: TMagic): Boolean;
begin
  {$IFOPT I+} {$DEFINE IOCHECKS_ON} {$ENDIF} {$I-}
  if SizeOf(TMagic) > 0 then
    BlockRead(f, v[0], SizeOf(TMagic));
  LastIOState := IOResult; Result := LastIOState = 0;
  {$IFDEF IOCHECKS_ON} {$I+} {$UNDEF IOCHECKS_ON} {$ENDIF}
end;

function Get_filetime(var f: file; var v: TFileTime): Boolean;
begin
  {$IFOPT I+} {$DEFINE IOCHECKS_ON} {$ENDIF} {$I-}
  BlockRead(f, v, SizeOf(v));
  LastIOState := IOResult; Result := LastIOState = 0;
  {$IFDEF IOCHECKS_ON} {$I+} {$UNDEF IOCHECKS_ON} {$ENDIF}
end;

function Get_screenshotData(var f: file; Width, Height: uint32; var v: TBytes): Boolean;
begin
  {$IFOPT I+} {$DEFINE IOCHECKS_ON} {$ENDIF} {$I-}
  if (Width < 1024 * 1024) and (Height < 1024 * 1024) then
  begin
    SetLength(v, 3 * Width * Height);
    if Length(v) > 0 then
      BlockRead(f, v[0], Length(v));
    LastIOState := IOResult; Result := LastIOState = 0;
  end
  else
    Result := False;
  {$IFDEF IOCHECKS_ON} {$I+} {$UNDEF IOCHECKS_ON} {$ENDIF}
end;

function Get_vlen(var f: file; s: uint; var v: uint): Boolean;
var
  b: uint8;
  w: uint16;
  c: uint32;
begin
  {$IFOPT I+} {$DEFINE IOCHECKS_ON} {$ENDIF} {$I-}
  case s shr 6 of
    0: begin
         BlockRead(f, b, SizeOf(b));
         v := b;
       end;
    1: begin
         BlockRead(f, w, SizeOf(w));
         v := w;
       end;
    2: begin
         BlockRead(f, c, SizeOf(c));
         v := c;
       end;
    else
    begin
      Result := False;
      Exit;
    end;
  end;
  LastIOState := IOResult; Result := LastIOState = 0;
  {$IFDEF IOCHECKS_ON} {$I+} {$UNDEF IOCHECKS_ON} {$ENDIF}
end;

function Get_vsval(var f: file; var v: vsval): Boolean;
var
  b: Byte;
  w: Word;
  c: Cardinal;
begin
  {$IFOPT I+} {$DEFINE IOCHECKS_ON} {$ENDIF} {$I-}
  BlockRead(f, b, SizeOf(b));
  LastIOState := IOResult;
  if LastIOState = 0 then
  begin
    Seek(f, FilePos(f) - SizeOf(b));
    b := b and 3;
    case b of
      0: begin
           BlockRead(f, b, SizeOf(b));
           v := b;
         end;
      1: begin
           BlockRead(f, w, SizeOf(w));
           v := w;
         end;
      2: begin
           BlockRead(f, c, SizeOf(c));
           v := c;
         end;
      else
      begin
        Result := False;
        Exit;
      end;
    end;
    LastIOState := IOResult; Result := LastIOState = 0;
  end
  else
    Result := False;
  {$IFDEF IOCHECKS_ON} {$I+} {$UNDEF IOCHECKS_ON} {$ENDIF}
end;
{$IF Defined(USEREGION)}{$ENDREGION}{$IFEND}

{$IF Defined(USEREGION)}{$REGION 'Read buffer function'}{$IFEND}
function Read_uint32(var Buf: TBytes; var FromPos: Integer): uint32;
begin
  if (FromPos + SizeOf(Result)) <= Length(Buf) then
  begin
    Move(Buf[FromPos], Result, SizeOf(Result));
    FromPos := FromPos + SizeOf(Result);
  end
  else
  begin
    ZeroMemory(@Result, SizeOf(Result));
    FromPos := 0;
  end;
end;

function Read_uint16(var Buf: TBytes; var FromPos: Integer): uint16;
begin
  if (FromPos + SizeOf(Result)) <= Length(Buf) then
  begin
    Move(Buf[FromPos], Result, SizeOf(Result));
    FromPos := FromPos + SizeOf(Result);
  end
  else
  begin
    ZeroMemory(@Result, SizeOf(Result));
    FromPos := 0;
  end;
end;

function Read_uint8(var Buf: TBytes; var FromPos: Integer): uint8;
begin
  if (FromPos + SizeOf(Result)) <= Length(Buf) then
  begin
    Move(Buf[FromPos], Result, SizeOf(Result));
    FromPos := FromPos + SizeOf(Result);
  end
  else
  begin
    ZeroMemory(@Result, SizeOf(Result));
    FromPos := 0;
  end;
end;

function Read_int32(var Buf: TBytes; var FromPos: Integer): int32;
begin
  if (FromPos + SizeOf(Result)) <= Length(Buf) then
  begin
    Move(Buf[FromPos], Result, SizeOf(Result));
    FromPos := FromPos + SizeOf(Result);
  end
  else
  begin
    ZeroMemory(@Result, SizeOf(Result));
    FromPos := 0;
  end;
end;

function Read_int16(var Buf: TBytes; var FromPos: Integer): int16;
begin
  if (FromPos + SizeOf(Result)) <= Length(Buf) then
  begin
    Move(Buf[FromPos], Result, SizeOf(Result));
    FromPos := FromPos + SizeOf(Result);
  end
  else
  begin
    ZeroMemory(@Result, SizeOf(Result));
    FromPos := 0;
  end;
end;

function Read_int8(var Buf: TBytes; var FromPos: Integer): int8;
begin
  if (FromPos + SizeOf(Result)) <= Length(Buf) then
  begin
    Move(Buf[FromPos], Result, SizeOf(Result));
    FromPos := FromPos + SizeOf(Result);
  end
  else
  begin
    ZeroMemory(@Result, SizeOf(Result));
    FromPos := 0;
  end;
end;

function Read_float32(var Buf: TBytes; var FromPos: Integer): float32;
begin
  if (FromPos + SizeOf(Result)) <= Length(Buf) then
  begin
    Move(Buf[FromPos], Result, SizeOf(Result));
    FromPos := FromPos + SizeOf(Result);
  end
  else
  begin
    ZeroMemory(@Result, SizeOf(Result));
    FromPos := 0;
  end;
end;

function Read_float64(var Buf: TBytes; var FromPos: Integer): float64;
begin
  if (FromPos + SizeOf(Result)) <= Length(Buf) then
  begin
    Move(Buf[FromPos], Result, SizeOf(Result));
    FromPos := FromPos + SizeOf(Result);
  end
  else
  begin
    ZeroMemory(@Result, SizeOf(Result));
    FromPos := 0;
  end;
end;

function Read_RefID(var Buf: TBytes; var FromPos: Integer): TRefID;
begin
  if (FromPos + SizeOf(Result)) <= Length(Buf) then
  begin
    Move(Buf[FromPos], Result, SizeOf(Result));
    FromPos := FromPos + SizeOf(Result);
  end
  else
  begin
    ZeroMemory(@Result, SizeOf(Result));
    FromPos := 0;
  end;
end;

function Read_wstring(var Buf: TBytes; var FromPos: Integer): wstring;
begin
  if (FromPos + SizeOf(Result.w)) <= Length(Buf) then
  begin
    Move(Buf[FromPos], Result.w, SizeOf(Result.w));
    FromPos := FromPos + SizeOf(Result.w);
    SetLength(Result.s, Result.w);
    if ((FromPos + Length(Result.s)) <= Length(Buf)) and (Result.w > 0) then
    begin
      Move(Buf[FromPos], Result.s[0], Length(Result.s));
      FromPos := FromPos + Length(Result.s);
      Exit;
    end
  end;
  Result.w := 0;
  SetLength(Result.s, 0);
  FromPos := 0;
end;

function Read_vsval(var Buf: TBytes; var FromPos: Integer): vsval;
var
  b: Byte;
  w: Word;
  c: Cardinal;
begin
  if (FromPos + SizeOf(b)) <= Length(Buf) then
  begin
    Move(Buf[FromPos], b, SizeOf(b));
    b := b and 3;
    case b of
      0: begin
           Move(Buf[FromPos], b, SizeOf(b));
           FromPos := FromPos + SizeOf(b);
           Result := b shr 2;
         end;
      1: begin
           Move(Buf[FromPos], w, SizeOf(w));
           FromPos := FromPos + SizeOf(w);
           Result := w shr 2;
         end;
      2: begin
           Move(Buf[FromPos], c, SizeOf(c));
           FromPos := FromPos + SizeOf(c);
           Result := c shr 2;
         end;
      else
      begin
        ZeroMemory(@Result, SizeOf(Result));
        FromPos := 0;
      end;
    end;
  end
  else
  begin
    ZeroMemory(@Result, SizeOf(Result));
    FromPos := 0;
  end;
end;
{$IF Defined(USEREGION)}{$ENDREGION}{$IFEND}

{$IF Defined(USEREGION)}{$REGION 'String represenations'}{$IFEND}
function GetCategoryString(Category: uint8): string;
begin
  case Category of
    0: Result := 'General';
    1: Result := 'Quest';
    2: Result := 'Combat';
    3: Result := 'Magic';
    4: Result := 'Crafting';
    5: Result := 'Crime';
    else
      Result := 'Unknown';
  end;
end;

function GetTypeString(_Type: uint32): string;
begin
  case _Type of
    0: Result := 'Misc Stats';
    1: Result := 'Player Location';
    2: Result := 'TES';
    3: Result := 'Global Variables';
    4: Result := 'Created Objects';
    5: Result := 'Effects';
    6: Result := 'Weather';
    7: Result := 'Audio';
    8: Result := 'SkyCells';
    100: Result := 'Process Lists';
    101: Result := 'Combat';
    102: Result := 'Interface';
    103: Result := 'Actor Causes';
    104: Result := 'Detection Manager';
    105: Result := 'Location MetaData';
    106: Result := 'Quest Static Data';
    107: Result := 'Story Teller';
    108: Result := 'Magic Favorites';
    109: Result := 'PlayerControls';
    110: Result := 'Story Event Manager';
    111: Result := 'Ingredient Shared';
    112: Result := 'Menu Controls';
    113: Result := 'Menu Topic Manager';
    114: Result := 'Unknown 114';
    1000: Result := 'Temp Effects';
    1001: Result := 'Papyrus';
    1002: Result := 'Anim Objects';
    1003: Result := 'Timer';
    1004: Result := 'Synchronized Animations';
    1005: Result := 'Main';
  else
    Result := 'unknown';
  end;
end;

function GetFormString(Form: uint32): string;
begin
  case Form and $3F of
    00: Result := 'REFR-63';
    01: Result := 'ACHR-64';
    02: Result := 'PMIS-65';
    03: Result := 'PGRE-67';
    04: Result := 'PBEA-68';
    05: Result := 'PFLA-69';
    06: Result := 'CELL-62';
    07: Result := 'INFO-78';
    08: Result := 'QUST-79';
    09: Result := 'NPC_-45';
    10: Result := 'ACTI-25';
    11: Result := 'TACT-26';
    12: Result := 'ARMO-27';
    13: Result := 'BOOK-28';
    14: Result := 'CONT-29';
    15: Result := 'DOOR-30';
    16: Result := 'INGR-31';
    17: Result := 'LIGH-32';
    18: Result := 'MISC-33';
    19: Result := 'APPA-34';
    20: Result := 'STAT-35';
    21: Result := 'MSTT-37';
    22: Result := 'FURN-42';
    23: Result := 'WEAP-43';
    24: Result := 'AMMO-44';
    25: Result := 'KEYM-47';
    26: Result := 'ALCH-48';
    27: Result := 'IDLM-49';
    28: Result := 'NOTE-50';
    29: Result := 'ECZN-105';
    30: Result := 'CLAS-10';
    31: Result := 'FACT-11';
    32: Result := 'PACK-81';
    33: Result := 'NAVM-75';
    34: Result := 'WOOP-120';
    35: Result := 'MGEF-19';
    36: Result := 'SMQN-115';
    37: Result := 'SCEN-124';
    38: Result := 'LCTN-106';
    39: Result := 'RELA-123';
    40: Result := 'PHZD-72';
    41: Result := 'PBAR-71';
    42: Result := 'PCON-70';
    43: Result := 'FLST-93';
    44: Result := 'LVLN-46';
    45: Result := 'LVLI-55';
    46: Result := 'LVSP-84';
    47: Result := 'PARW-66';
    48: Result := 'ENCH-22';
    else
      Result := 'UNKN-???';
  end;
end;
{$IF Defined(USEREGION)}{$ENDREGION}{$IFEND}

{$IF Defined(USEREGION)}{$REGION 'Memory release'}{$IFEND}
procedure FreeESSFile(var ESSFile: TESSFile);
begin
  with ESSFile do
  begin
    magic := StringToMagic('');
    with Header do
    begin
      playerName := StringTowstring('');
      playerLocation := StringTowstring('');
      gameDate := StringTowstring('');
      playerRaceEditorId := StringTowstring('');
    end;
    SetLength(screenshotData, 0);
    with pluginInfo do
      while Length(plugins) > 0 do
      begin
        plugins[Length(plugins) - 1] := StringTowstring('');
        SetLength(plugins, Length(plugins) - 1);
      end;
    while Length(globalDataTable1) > 0 do
    begin
      SetLength(globalDataTable1[Length(globalDataTable1) - 1].data, 0);
      SetLength(globalDataTable1, Length(globalDataTable1) - 1);
    end;
    while Length(globalDataTable2) > 0 do
    begin
      SetLength(globalDataTable2[Length(globalDataTable2) - 1].data, 0);
      SetLength(globalDataTable2, Length(globalDataTable2) - 1);
    end;
    while Length(changeForms) > 0 do
    begin
      SetLength(changeForms[Length(changeForms) - 1].data, 0);
      SetLength(changeForms, Length(changeForms) - 1);
    end;
    while Length(globalDataTable3) > 0 do
    begin
      SetLength(globalDataTable3[Length(globalDataTable3) - 1].data, 0);
      SetLength(globalDataTable3, Length(globalDataTable3) - 1);
    end;
    SetLength(formIDArray, 0);
    with unknown3Table do
      while Length(unknown) > 0 do
      begin
        unknown[Length(unknown) - 1] := StringTowstring('');
        SetLength(unknown, Length(unknown) - 1);
      end;
  end;
end;

procedure FreeESSFileInfo(var ESSFileInfo: TESSFileInfo);
begin
  with ESSFileInfo do
  begin
    playerName := '';
    playerLocation := '';
    gameDate := '';
    playerRaceEditorId := '';
    SetLength(screenshotData, 0);
  end;
end;
{$IF Defined(USEREGION)}{$ENDREGION}{$IFEND}

{$IF Defined(USEREGION)}{$REGION 'Read ESS file'}{$IFEND}
function ReadESSFile(var ESSFile: TESSFile; sFileName: string; Progress: TProgress = nil): integer;
var
  F: File;
  i: Integer;
  iProcess: Integer;
  bBreak: Boolean;
begin
  Result := 1;
  if ESSFile.magic = C_TESVESS then
    FreeESSFile(ESSFile);
  Inc(Result);
  AssignFile(F, sFileName);
  {$IFOPT I+} {$DEFINE IOCHECKS_ON} {$ENDIF} {$I-}
  FileMode := fmOpenRead;
  Reset(F, 1);
  LastIOState := IOResult;
  if LastIOState = 0 then
  try
    with ESSFile do
    begin
      Inc(Result); if not Get_magic(F, magic) then Exit;
      Inc(Result); if not Get_uint32(F, headerSize) then Exit;
      with Header do
      begin
        Inc(Result); if not Get_uint32(F, version) then Exit;
        Inc(Result); if not Get_uint32(F, saveNumber) then Exit;
        Inc(Result); if not Get_wstring(F, playerName) then Exit;
        Inc(Result); if not Get_uint32(F, playerLevel) then Exit;
        Inc(Result); if not Get_wstring(F, playerLocation) then Exit;
        Inc(Result); if not Get_wstring(F, gameDate) then Exit;
        Inc(Result); if not Get_wstring(F, playerRaceEditorId) then Exit;
        Inc(Result); if not Get_uint16(F, unknown1) then Exit;
        Inc(Result); if not Get_float32(F, unknown2) then Exit;
        Inc(Result); if not Get_float32(F, unknown3) then Exit;
        Inc(Result); if not Get_filetime(F, filetime) then Exit;
        Inc(Result); if not Get_uint32(F, shotWidth) then Exit;
        if shotWidth > 4096 then
          Exit;
        Inc(Result); if not Get_uint32(F, shotHeight) then Exit;
        if shotHeight > 4096 then
          Exit;
      end;
      Inc(Result); if not Get_screenshotData(F, Header.shotWidth, Header.shotHeight, screenshotData) then Exit;
      Inc(Result); if not Get_uint8(F, formVersion) then Exit;
      Inc(Result); if not Get_uint32(F, pluginInfoSize) then Exit;
      with pluginInfo do
      begin
        Inc(Result); if not Get_uint8(F, pluginCount) then Exit;
        SetLength(plugins, pluginCount);
        for i := 0 to pluginCount - 1 do
          begin Inc(Result); if not Get_wstring(F, plugins[i]) then Exit; end;
      end;
      with fileLocationTable do
      begin
        Inc(Result); if not Get_uint32(F, formIDArrayOffest) then Exit;
        Inc(Result); if not Get_uint32(F, unknownTable3Offset) then Exit;
        Inc(Result); if not Get_uint32(F, globalDataTable1Offset) then Exit;
        Inc(Result); if not Get_uint32(F, globalDataTable2Offset) then Exit;
        Inc(Result); if not Get_uint32(F, changeFormsOffset) then Exit;
        Inc(Result); if not Get_uint32(F, globalDataTable3Offset) then Exit;
        Inc(Result); if not Get_uint32(F, globalDataTable1Count) then Exit;
        Inc(Result); if not Get_uint32(F, globalDataTable2Count) then Exit;
        Inc(Result); if not Get_uint32(F, globalDataTable3Count) then Exit;
        Inc(Result); if not Get_uint32(F, changeFormCount) then Exit;
        for i := 1 to 15 do
          begin Inc(Result); if not Get_uint32(F, unused[i]) then Exit; end;
      end;
      SetLength(globalDataTable1, fileLocationTable.globalDataTable1Count);
      for i := 0 to fileLocationTable.globalDataTable1Count - 1 do
        with globalDataTable1[i] do
        begin
          Inc(Result); if not Get_uint32(F, _type) then Exit;
          Inc(Result); if not Get_uint32(F, _length) then Exit;
          SetLength(data, _length);
          if _length > 0 then
            begin Inc(Result); if not Get_data(F, data) then Exit; end;
        end;
      SetLength(globalDataTable2, FileLocationTable.globalDataTable2Count);
      for i := 0 to FileLocationTable.globalDataTable2Count - 1 do
        with globalDataTable2[i] do
        begin
          Inc(Result); if not Get_uint32(F, _type) then Exit;
          Inc(Result); if not Get_uint32(F, _length) then Exit;
          SetLength(data, _length);
          if _length > 0 then
            begin Inc(Result); if not Get_data(F, data) then Exit; end;
        end;
      SetLength(changeForms, FileLocationTable.changeFormCount);
      iProcess := 0;
      bBreak := False;
      if Assigned(Progress) then
        Progress(iProcess, bBreak);
      for i := 0 to FileLocationTable.changeFormCount - 1 do
        with changeForms[i] do
        begin
          Inc(Result); if not Get_RefID(F, formID) then Exit;
          Inc(Result); if not Get_uint32(F, changeFlags) then Exit;
          Inc(Result); if not Get_uint8(F, _type) then Exit;
          Inc(Result); if not Get_uint8(F, version) then Exit;
          Inc(Result); if not Get_vlen(F, _type, length1) then Exit;
          Inc(Result); if not Get_vlen(F, _type, length2) then Exit;
          SetLength(data, length1);
          if length1 > 0 then
            begin Inc(Result); if not Get_data(F, data) then Exit; end;
          if FileLocationTable.changeFormCount > 1 then
            if Round(i / (FileLocationTable.changeFormCount - 1) * 100) <> iProcess then
            begin
              iProcess := Round(i / (FileLocationTable.changeFormCount - 1) * 100);
              if Assigned(Progress) then
                Progress(iProcess, bBreak);
              if bBreak then
              begin
                Result := -1;
                Exit;
              end;
            end;
        end;
      SetLength(globalDataTable3, FileLocationTable.globalDataTable3Count + 1); //bugged
      for i := 0 to FileLocationTable.globalDataTable3Count do
        with globalDataTable3[i] do
        begin
          Inc(Result); if not Get_uint32(F, _type) then Exit;
          Inc(Result); if not Get_uint32(F, _length) then Exit;
          SetLength(data, _length);
          if _length > 0 then
            begin Inc(Result); if not Get_data(F, data) then Exit; end;
        end;
      Inc(Result); if not Get_uint32(F, formIDArrayCount) then Exit;
      SetLength(formIDArray, formIDArrayCount);
      for i := 0 to formIDArrayCount - 1 do
      begin
        Inc(Result);
        if not Get_RefID(F, formIDArray[i].ID) then Exit;
        if not Get_uint8(F, formIDArray[i].Count) then Exit;
      end;
      Inc(Result); if not Get_uint32(F, unknown2TableCount) then Exit;
      SetLength(unknown2Table, unknown2TableCount);
      for i := 0 to unknown2TableCount - 1 do
        begin Inc(Result); if not Get_uint32(F, unknown2Table[i]) then Exit; end;
      Inc(Result); if not Get_uint32(F, unknown3TableSize) then Exit;
      with unknown3Table do
      begin
        Inc(Result); if not Get_uint32(F, Count) then Exit;
        SetLength(unknown, Count);
        for i := 0 to Count - 1 do
          begin Inc(Result); if not Get_wstring(F, unknown[i]) then Exit; end;
      end;
    end;
    Result := 0;
  finally
    CloseFile(F);
    {$IFDEF IOCHECKS_ON} {$I+} {$UNDEF IOCHECKS_ON} {$ENDIF}
  end;
end;

function ReadESSFileUncompressed(var ESSFile: TESSFile; sFileName: string; Progress: TProgress = nil): integer;
var
  F: File;
  i: Integer;
  iProcess: Integer;
  bBreak: Boolean;
begin
  Result := 1;
  if ESSFile.magic = C_TESVESS then
    FreeESSFile(ESSFile);
  Inc(Result);
  AssignFile(F, sFileName);
  {$IFOPT I+} {$DEFINE IOCHECKS_ON} {$ENDIF} {$I-}
  FileMode := fmOpenRead;
  Reset(F, 1);
  LastIOState := IOResult;
  if LastIOState = 0 then
  try
    with ESSFile do
    begin
      Inc(Result); if not Get_magic(F, magic) then Exit;
      Inc(Result); if not Get_uint32(F, headerSize) then Exit;
      with Header do
      begin
        Inc(Result); if not Get_uint32(F, version) then Exit;
        Inc(Result); if not Get_uint32(F, saveNumber) then Exit;
        Inc(Result); if not Get_wstring(F, playerName) then Exit;
        Inc(Result); if not Get_uint32(F, playerLevel) then Exit;
        Inc(Result); if not Get_wstring(F, playerLocation) then Exit;
        Inc(Result); if not Get_wstring(F, gameDate) then Exit;
        Inc(Result); if not Get_wstring(F, playerRaceEditorId) then Exit;
        Inc(Result); if not Get_uint16(F, unknown1) then Exit;
        Inc(Result); if not Get_float32(F, unknown2) then Exit;
        Inc(Result); if not Get_float32(F, unknown3) then Exit;
        Inc(Result); if not Get_filetime(F, filetime) then Exit;
        Inc(Result); if not Get_uint32(F, shotWidth) then Exit;
        if shotWidth > 4096 then
          Exit;
        Inc(Result); if not Get_uint32(F, shotHeight) then Exit;
        if shotHeight > 4096 then
          Exit;
      end;
      Inc(Result); if not Get_screenshotData(F, Header.shotWidth, Header.shotHeight, screenshotData) then Exit;
      Inc(Result); if not Get_uint8(F, formVersion) then Exit;
      Inc(Result); if not Get_uint32(F, pluginInfoSize) then Exit;
      with pluginInfo do
      begin
        Inc(Result); if not Get_uint8(F, pluginCount) then Exit;
        SetLength(plugins, pluginCount);
        for i := 0 to pluginCount - 1 do
          begin Inc(Result); if not Get_wstring(F, plugins[i]) then Exit; end;
      end;
      with fileLocationTable do
      begin
        Inc(Result); if not Get_uint32(F, formIDArrayOffest) then Exit;
        Inc(Result); if not Get_uint32(F, unknownTable3Offset) then Exit;
        Inc(Result); if not Get_uint32(F, globalDataTable1Offset) then Exit;
        Inc(Result); if not Get_uint32(F, globalDataTable2Offset) then Exit;
        Inc(Result); if not Get_uint32(F, changeFormsOffset) then Exit;
        Inc(Result); if not Get_uint32(F, globalDataTable3Offset) then Exit;
        Inc(Result); if not Get_uint32(F, globalDataTable1Count) then Exit;
        Inc(Result); if not Get_uint32(F, globalDataTable2Count) then Exit;
        Inc(Result); if not Get_uint32(F, globalDataTable3Count) then Exit;
        Inc(Result); if not Get_uint32(F, changeFormCount) then Exit;
        for i := 1 to 15 do
          begin Inc(Result); if not Get_uint32(F, unused[i]) then Exit; end;
      end;
      SetLength(globalDataTable1, fileLocationTable.globalDataTable1Count);
      for i := 0 to fileLocationTable.globalDataTable1Count - 1 do
        with globalDataTable1[i] do
        begin
          Inc(Result); if not Get_uint32(F, _type) then Exit;
          Inc(Result); if not Get_uint32(F, _length) then Exit;
          SetLength(data, _length);
          if _length > 0 then
            begin Inc(Result); if not Get_data(F, data) then Exit; end;
        end;
      SetLength(globalDataTable2, FileLocationTable.globalDataTable2Count);
      for i := 0 to FileLocationTable.globalDataTable2Count - 1 do
        with globalDataTable2[i] do
        begin
          Inc(Result); if not Get_uint32(F, _type) then Exit;
          Inc(Result); if not Get_uint32(F, _length) then Exit;
          SetLength(data, _length);
          if _length > 0 then
            begin Inc(Result); if not Get_data(F, data) then Exit; end;
        end;
      SetLength(changeForms, FileLocationTable.changeFormCount);
      iProcess := 0;
      bBreak := False;
      if Assigned(Progress) then
        Progress(iProcess, bBreak);
      for i := 0 to FileLocationTable.changeFormCount - 1 do
        with changeForms[i] do
        begin
          Inc(Result); if not Get_RefID(F, formID) then Exit;
          Inc(Result); if not Get_uint32(F, changeFlags) then Exit;
          Inc(Result); if not Get_uint8(F, _type) then Exit;
          Inc(Result); if not Get_uint8(F, version) then Exit;
          Inc(Result); if not Get_vlen(F, _type, length1) then Exit;
          Inc(Result); if not Get_vlen(F, _type, length2) then Exit;
          SetLength(data, length1);
          if length1 > 0 then
            begin Inc(Result); if not Get_data(F, data) then Exit; end;
          if (length2 > 0) and DecompressData(Data, length2) then
          begin
            length1 := Length(Data);
            length2 := 0;
          end;
          if FileLocationTable.changeFormCount > 1 then
            if Round(i / (FileLocationTable.changeFormCount - 1) * 100) <> iProcess then
            begin
              iProcess := Round(i / (FileLocationTable.changeFormCount - 1) * 100);
              if Assigned(Progress) then
                Progress(iProcess, bBreak);
              if bBreak then
              begin
                Result := -1;
                Exit;
              end;
            end;
        end;
      SetLength(globalDataTable3, FileLocationTable.globalDataTable3Count + 1); //bugged
      for i := 0 to FileLocationTable.globalDataTable3Count do
        with globalDataTable3[i] do
        begin
          Inc(Result); if not Get_uint32(F, _type) then Exit;
          Inc(Result); if not Get_uint32(F, _length) then Exit;
          SetLength(data, _length);
          if _length > 0 then
            begin Inc(Result); if not Get_data(F, data) then Exit; end;
        end;
      Inc(Result); if not Get_uint32(F, formIDArrayCount) then Exit;
      SetLength(formIDArray, formIDArrayCount);
      for i := 0 to formIDArrayCount - 1 do
      begin
        Inc(Result);
        if not Get_RefID(F, formIDArray[i].ID) then Exit;
        if not Get_uint8(F, formIDArray[i].Count) then Exit;
      end;
      Inc(Result); if not Get_uint32(F, unknown2TableCount) then Exit;
      SetLength(unknown2Table, unknown2TableCount);
      for i := 0 to unknown2TableCount - 1 do
        begin Inc(Result); if not Get_uint32(F, unknown2Table[i]) then Exit; end;
      Inc(Result); if not Get_uint32(F, unknown3TableSize) then Exit;
      with unknown3Table do
      begin
        Inc(Result); if not Get_uint32(F, Count) then Exit;
        SetLength(unknown, Count);
        for i := 0 to Count - 1 do
          begin Inc(Result); if not Get_wstring(F, unknown[i]) then Exit; end;
      end;
    end;
    Result := 0;
  finally
    CloseFile(F);
    {$IFDEF IOCHECKS_ON} {$I+} {$UNDEF IOCHECKS_ON} {$ENDIF}
  end;
end;
{$IF Defined(USEREGION)}{$ENDREGION}{$IFEND}

{$IF Defined(USEREGION)}{$REGION 'Save ESS file'}{$IFEND}
function SaveESSFile(var ESSFile: TESSFile; sFileName: string; Progress: TProgress = nil): Integer;
var
  F: File;
  i, iFAT: Integer;
  b: uint8;
  w: uint16;
  c: uint32;
  iProcess: Integer;
  bBreak: Boolean;
begin
  Result := -2;
  if ESSFile.magic <> C_TESVESS then
    Exit;
  Result := 1;
  AssignFile(F, sFileName);
  {$IFOPT I+} {$DEFINE IOCHECKS_ON} {$ENDIF} {$I-}
  ReWrite(F, 1);
  LastIOState := IOResult;
  if LastIOState = 0 then
  try
    with ESSFile do
    begin
      Inc(Result); BlockWrite(f, magic[0], SizeOf(TMagic)); LastIOState := IOResult; if LastIOState <> 0 then Exit;
      with Header do
      begin
        headerSize := 5 * SizeOf(uint32) + 2 * SizeOf(float32) + SizeOf(uint16) + SizeOf(TFileTime) + 4 * SizeOf(playerName.w) + playerName.w + playerLocation.w + gameDate.w + playerRaceEditorId.w;
        Inc(Result); BlockWrite(f, headerSize, SizeOf(headerSize)); LastIOState := IOResult; if LastIOState <> 0 then Exit;
        Inc(Result); BlockWrite(f, version, SizeOf(version)); LastIOState := IOResult; if LastIOState <> 0 then Exit;
        Inc(Result); BlockWrite(f, saveNumber, SizeOf(saveNumber)); LastIOState := IOResult; if LastIOState <> 0 then Exit;
        Inc(Result); BlockWrite(f, playerName.w, SizeOf(playerName.w)); LastIOState := IOResult; if LastIOState <> 0 then Exit;
        if playerName.w > 0 then
          begin Inc(Result); BlockWrite(f, playerName.s[0], playerName.w); LastIOState := IOResult; if LastIOState <> 0 then Exit; end;
        Inc(Result); BlockWrite(f, playerLevel, SizeOf(playerLevel)); LastIOState := IOResult; if LastIOState <> 0 then Exit;
        Inc(Result); BlockWrite(f, playerLocation.w, SizeOf(playerLocation.w)); LastIOState := IOResult; if LastIOState <> 0 then Exit;
        if playerLocation.w > 0 then
          begin Inc(Result); BlockWrite(f, playerLocation.s[0], playerLocation.w); LastIOState := IOResult; if LastIOState <> 0 then Exit; end;
        Inc(Result); BlockWrite(f, gameDate.w, SizeOf(gameDate.w)); LastIOState := IOResult; if LastIOState <> 0 then Exit;
        if gameDate.w > 0 then
          begin Inc(Result); BlockWrite(f, gameDate.s[0], gameDate.w); LastIOState := IOResult; if LastIOState <> 0 then Exit; end;
        Inc(Result); BlockWrite(f, playerRaceEditorId.w, SizeOf(playerRaceEditorId.w)); LastIOState := IOResult; if LastIOState <> 0 then Exit;
        if playerRaceEditorId.w > 0 then
          begin Inc(Result); BlockWrite(f, playerRaceEditorId.s[0], playerRaceEditorId.w); LastIOState := IOResult; if LastIOState <> 0 then Exit; end;
        Inc(Result); BlockWrite(f, unknown1, SizeOf(unknown1)); LastIOState := IOResult; if LastIOState <> 0 then Exit;
        Inc(Result); BlockWrite(f, unknown2, SizeOf(unknown2)); LastIOState := IOResult; if LastIOState <> 0 then Exit;
        Inc(Result); BlockWrite(f, unknown3, SizeOf(unknown3)); LastIOState := IOResult; if LastIOState <> 0 then Exit;
        Inc(Result); BlockWrite(f, filetime, SizeOf(filetime)); LastIOState := IOResult; if LastIOState <> 0 then Exit;
        Inc(Result); BlockWrite(f, shotWidth, SizeOf(shotWidth)); LastIOState := IOResult; if LastIOState <> 0 then Exit;
        Inc(Result); BlockWrite(f, shotHeight, SizeOf(shotHeight)); LastIOState := IOResult; if LastIOState <> 0 then Exit;
      end;
      if Length(screenshotData) > 0 then
        Inc(Result); BlockWrite(f, screenshotData[0], Length(screenshotData)); LastIOState := IOResult; if LastIOState <> 0 then Exit;
      Inc(Result); BlockWrite(f, formVersion, SizeOf(formVersion)); LastIOState := IOResult; if LastIOState <> 0 then Exit;
      with pluginInfo do
      begin
        pluginInfoSize := SizeOf(pluginCount);
        pluginCount := Length(plugins);
        for i := 0 to pluginCount - 1 do
          pluginInfoSize := pluginInfoSize + SizeOf(plugins[i].w) + plugins[i].w;
        Inc(Result); BlockWrite(f, pluginInfoSize, SizeOf(pluginInfoSize)); LastIOState := IOResult; if LastIOState <> 0 then Exit;
        Inc(Result); BlockWrite(f, pluginCount, SizeOf(pluginCount)); LastIOState := IOResult; if LastIOState <> 0 then Exit;
        for i := 0 to pluginCount - 1 do
        begin
          Inc(Result); BlockWrite(f, plugins[i].w, SizeOf(plugins[i].w)); LastIOState := IOResult; if LastIOState <> 0 then Exit;
          if plugins[i].w > 0 then
            begin Inc(Result); BlockWrite(f, plugins[i].s[0], plugins[i].w); LastIOState := IOResult; if LastIOState <> 0 then Exit; end;
        end;
      end;
      iFAT := FilePos(F);
      Inc(Result); BlockWrite(f, fileLocationTable, SizeOf(fileLocationTable)); LastIOState := IOResult; if LastIOState <> 0 then Exit;
      fileLocationTable.globalDataTable1Count := Length(globalDataTable1);
      fileLocationTable.globalDataTable1Offset := FilePos(F);
      for i := 0 to fileLocationTable.globalDataTable1Count - 1 do
        with globalDataTable1[i] do
        begin
          Inc(Result); BlockWrite(f, _type, SizeOf(_type)); LastIOState := IOResult; if LastIOState <> 0 then Exit;
          _length := Length(data);
          Inc(Result); BlockWrite(f, _length, SizeOf(_length)); LastIOState := IOResult; if LastIOState <> 0 then Exit;
          if _length > 0 then
            begin Inc(Result); BlockWrite(f, data[0], _length); LastIOState := IOResult; if LastIOState <> 0 then Exit; end;
        end;
      fileLocationTable.globalDataTable2Count := Length(globalDataTable2);
      fileLocationTable.globalDataTable2Offset := FilePos(F);
      for i := 0 to fileLocationTable.globalDataTable2Count - 1 do
        with globalDataTable2[i] do
        begin
          Inc(Result); BlockWrite(f, _type, SizeOf(_type)); LastIOState := IOResult; if LastIOState <> 0 then Exit;
          _length := Length(data);
          Inc(Result); BlockWrite(f, _length, SizeOf(_length)); LastIOState := IOResult; if LastIOState <> 0 then Exit;
          if _length > 0 then
            begin Inc(Result); BlockWrite(f, data[0], _length); LastIOState := IOResult; if LastIOState <> 0 then Exit; end;
        end;
      FileLocationTable.changeFormCount := Length(changeForms);
      fileLocationTable.changeFormsOffset := FilePos(F);
      iProcess := 0;
      bBreak := False;
      if Assigned(Progress) then
        Progress(iProcess, bBreak);
      for i := 0 to FileLocationTable.changeFormCount - 1 do
        with changeForms[i] do
        begin
          Inc(Result); BlockWrite(f, formID, SizeOf(formID)); LastIOState := IOResult; if LastIOState <> 0 then Exit;
          Inc(Result); BlockWrite(f, changeFlags, SizeOf(changeFlags)); LastIOState := IOResult; if LastIOState <> 0 then Exit;
          length1 := Length(data);
          if ((length1 shr 16) <> 0) or ((length2 shr 16) <> 0) then
            _type := (_type and $3F) or (2 shl 6)
          else
            if ((length1 shr 8) <> 0) or ((length2 shr 8) <> 0) then
              _type := (_type and $3F) or (1 shl 6)
            else
              _type := _type and $3F;
          Inc(Result); BlockWrite(f, _type, SizeOf(_type)); LastIOState := IOResult; if LastIOState <> 0 then Exit;
          Inc(Result); BlockWrite(f, version, SizeOf(version)); LastIOState := IOResult; if LastIOState <> 0 then Exit;
          case _type shr 6 of
            0: begin
                 b := length1;
                 Inc(Result); BlockWrite(f, b, SizeOf(b)); LastIOState := IOResult; if LastIOState <> 0 then Exit;
                 b := length2;
                 Inc(Result); BlockWrite(f, b, SizeOf(b)); LastIOState := IOResult; if LastIOState <> 0 then Exit;
               end;
            1: begin
                 w := length1;
                 Inc(Result); BlockWrite(f, w, SizeOf(w)); LastIOState := IOResult; if LastIOState <> 0 then Exit;
                 w := length2;
                 Inc(Result); BlockWrite(f, w, SizeOf(w)); LastIOState := IOResult; if LastIOState <> 0 then Exit;
               end;
            2: begin
                 c := length1;
                 Inc(Result); BlockWrite(f, c, SizeOf(c)); LastIOState := IOResult; if LastIOState <> 0 then Exit;
                 c := length2;
                 Inc(Result); BlockWrite(f, c, SizeOf(c)); LastIOState := IOResult; if LastIOState <> 0 then Exit;
               end;
          end;
          if length1 > 0 then
            begin Inc(Result); BlockWrite(f, data[0], length1); LastIOState := IOResult; if LastIOState <> 0 then Exit; end;
          if FileLocationTable.changeFormCount > 1 then
            if Round(i / (FileLocationTable.changeFormCount - 1) * 100) <> iProcess then
            begin
              iProcess := Round(i / (FileLocationTable.changeFormCount - 1) * 100);
              if Assigned(Progress) then
                Progress(iProcess, bBreak);
              if bBreak then
              begin
                Result := -1;
                Exit;
              end;
            end;
        end;
      FileLocationTable.globalDataTable3Count := Length(globalDataTable3) - 1; //buggy
      fileLocationTable.globalDataTable3Offset := FilePos(F);
      for i := 0 to fileLocationTable.globalDataTable3Count do
        with globalDataTable3[i] do
        begin
          Inc(Result); BlockWrite(f, _type, SizeOf(_type)); LastIOState := IOResult; if LastIOState <> 0 then Exit;
          _length := Length(data);
          Inc(Result); BlockWrite(f, _length, SizeOf(_length)); LastIOState := IOResult; if LastIOState <> 0 then Exit;
          if _length > 0 then
            begin Inc(Result); BlockWrite(f, data[0], _length); LastIOState := IOResult; if LastIOState <> 0 then Exit; end;
        end;
      formIDArrayCount := Length(formIDArray);
      fileLocationTable.formIDArrayOffest := FilePos(F);
      Inc(Result); BlockWrite(f, formIDArrayCount, SizeOf(formIDArrayCount)); LastIOState := IOResult; if LastIOState <> 0 then Exit;
      for i := 0 to formIDArrayCount - 1 do
        begin Inc(Result); BlockWrite(f, formIDArray[i], SizeOf(formIDArray[i])); LastIOState := IOResult; if LastIOState <> 0 then Exit; end;
      unknown2TableCount := Length(unknown2Table);
      Inc(Result); BlockWrite(f, unknown2TableCount, SizeOf(unknown2TableCount)); LastIOState := IOResult; if LastIOState <> 0 then Exit;
      for i := 0 to unknown2TableCount - 1 do
        begin Inc(Result); BlockWrite(f, unknown2Table[i], SizeOf(unknown2Table[i])); LastIOState := IOResult; if LastIOState <> 0 then Exit; end;
      fileLocationTable.unknownTable3Offset := FilePos(f);
      with unknown3Table do
      begin
        unknown3TableSize := SizeOf(Count);
        Count := Length(unknown);
        for i := 0 to Count - 1 do
          unknown3TableSize := unknown3TableSize + SizeOf(unknown[i].w) + unknown[i].w;
        Inc(Result); BlockWrite(f, unknown3TableSize, SizeOf(unknown3TableSize)); LastIOState := IOResult; if LastIOState <> 0 then Exit;
        Inc(Result); BlockWrite(f, Count, SizeOf(Count)); LastIOState := IOResult; if LastIOState <> 0 then Exit;
        for i := 0 to Count - 1 do
        begin
          Inc(Result); BlockWrite(f, unknown[i].w, SizeOf(unknown[i].w)); LastIOState := IOResult; if LastIOState <> 0 then Exit;
          if unknown[i].w > 0 then
            begin Inc(Result); BlockWrite(f, unknown[i].s[0], unknown[i].w); LastIOState := IOResult; if LastIOState <> 0 then Exit; end;
        end;
      end;
      Seek(F, iFAT);
      Inc(Result); BlockWrite(f, fileLocationTable, SizeOf(fileLocationTable)); LastIOState := IOResult; if LastIOState <> 0 then Exit;
    end;
    Result := 0;
  finally
    CloseFile(F);
    {$IFDEF IOCHECKS_ON} {$I+} {$UNDEF IOCHECKS_ON} {$ENDIF}
  end;
end;

function SaveESSFileUncompressed(var ESSFile: TESSFile; sFileName: string; Progress: TProgress = nil): Integer;
var
  F: File;
  i, iFAT: Integer;
  b: uint8;
  w: uint16;
  c: uint32;
  iProcess: Integer;
  bBreak: Boolean;
begin
  Result := -2;
  if ESSFile.magic <> C_TESVESS then
    Exit;
  Result := 1;
  AssignFile(F, sFileName);
  {$IFOPT I+} {$DEFINE IOCHECKS_ON} {$ENDIF} {$I-}
  ReWrite(F, 1);
  LastIOState := IOResult;
  if LastIOState = 0 then
  try
    with ESSFile do
    begin
      Inc(Result); BlockWrite(f, magic[0], SizeOf(TMagic)); LastIOState := IOResult; if LastIOState <> 0 then Exit;
      with Header do
      begin
        headerSize := 5 * SizeOf(uint32) + 2 * SizeOf(float32) + SizeOf(uint16) + SizeOf(TFileTime) + 4 * SizeOf(playerName.w) + playerName.w + playerLocation.w + gameDate.w + playerRaceEditorId.w;
        Inc(Result); BlockWrite(f, headerSize, SizeOf(headerSize)); LastIOState := IOResult; if LastIOState <> 0 then Exit;
        Inc(Result); BlockWrite(f, version, SizeOf(version)); LastIOState := IOResult; if LastIOState <> 0 then Exit;
        Inc(Result); BlockWrite(f, saveNumber, SizeOf(saveNumber)); LastIOState := IOResult; if LastIOState <> 0 then Exit;
        Inc(Result); BlockWrite(f, playerName.w, SizeOf(playerName.w)); LastIOState := IOResult; if LastIOState <> 0 then Exit;
        if playerName.w > 0 then
          begin Inc(Result); BlockWrite(f, playerName.s[0], playerName.w); LastIOState := IOResult; if LastIOState <> 0 then Exit; end;
        Inc(Result); BlockWrite(f, playerLevel, SizeOf(playerLevel)); LastIOState := IOResult; if LastIOState <> 0 then Exit;
        Inc(Result); BlockWrite(f, playerLocation.w, SizeOf(playerLocation.w)); LastIOState := IOResult; if LastIOState <> 0 then Exit;
        if playerLocation.w > 0 then
          begin Inc(Result); BlockWrite(f, playerLocation.s[0], playerLocation.w); LastIOState := IOResult; if LastIOState <> 0 then Exit; end;
        Inc(Result); BlockWrite(f, gameDate.w, SizeOf(gameDate.w)); LastIOState := IOResult; if LastIOState <> 0 then Exit;
        if gameDate.w > 0 then
          begin Inc(Result); BlockWrite(f, gameDate.s[0], gameDate.w); LastIOState := IOResult; if LastIOState <> 0 then Exit; end;
        Inc(Result); BlockWrite(f, playerRaceEditorId.w, SizeOf(playerRaceEditorId.w)); LastIOState := IOResult; if LastIOState <> 0 then Exit;
        if playerRaceEditorId.w > 0 then
          begin Inc(Result); BlockWrite(f, playerRaceEditorId.s[0], playerRaceEditorId.w); LastIOState := IOResult; if LastIOState <> 0 then Exit; end;
        Inc(Result); BlockWrite(f, unknown1, SizeOf(unknown1)); LastIOState := IOResult; if LastIOState <> 0 then Exit;
        Inc(Result); BlockWrite(f, unknown2, SizeOf(unknown2)); LastIOState := IOResult; if LastIOState <> 0 then Exit;
        Inc(Result); BlockWrite(f, unknown3, SizeOf(unknown3)); LastIOState := IOResult; if LastIOState <> 0 then Exit;
        Inc(Result); BlockWrite(f, filetime, SizeOf(filetime)); LastIOState := IOResult; if LastIOState <> 0 then Exit;
        Inc(Result); BlockWrite(f, shotWidth, SizeOf(shotWidth)); LastIOState := IOResult; if LastIOState <> 0 then Exit;
        Inc(Result); BlockWrite(f, shotHeight, SizeOf(shotHeight)); LastIOState := IOResult; if LastIOState <> 0 then Exit;
      end;
      if Length(screenshotData) > 0 then
        Inc(Result); BlockWrite(f, screenshotData[0], Length(screenshotData)); LastIOState := IOResult; if LastIOState <> 0 then Exit;
      Inc(Result); BlockWrite(f, formVersion, SizeOf(formVersion)); LastIOState := IOResult; if LastIOState <> 0 then Exit;
      with pluginInfo do
      begin
        pluginInfoSize := SizeOf(pluginCount);
        pluginCount := Length(plugins);
        for i := 0 to pluginCount - 1 do
          pluginInfoSize := pluginInfoSize + SizeOf(plugins[i].w) + plugins[i].w;
        Inc(Result); BlockWrite(f, pluginInfoSize, SizeOf(pluginInfoSize)); LastIOState := IOResult; if LastIOState <> 0 then Exit;
        Inc(Result); BlockWrite(f, pluginCount, SizeOf(pluginCount)); LastIOState := IOResult; if LastIOState <> 0 then Exit;
        for i := 0 to pluginCount - 1 do
        begin
          Inc(Result); BlockWrite(f, plugins[i].w, SizeOf(plugins[i].w)); LastIOState := IOResult; if LastIOState <> 0 then Exit;
          if plugins[i].w > 0 then
            begin Inc(Result); BlockWrite(f, plugins[i].s[0], plugins[i].w); LastIOState := IOResult; if LastIOState <> 0 then Exit; end;
        end;
      end;
      iFAT := FilePos(F);
      Inc(Result); BlockWrite(f, fileLocationTable, SizeOf(fileLocationTable)); LastIOState := IOResult; if LastIOState <> 0 then Exit;
      fileLocationTable.globalDataTable1Count := Length(globalDataTable1);
      fileLocationTable.globalDataTable1Offset := FilePos(F);
      for i := 0 to fileLocationTable.globalDataTable1Count - 1 do
        with globalDataTable1[i] do
        begin
          Inc(Result); BlockWrite(f, _type, SizeOf(_type)); LastIOState := IOResult; if LastIOState <> 0 then Exit;
          _length := Length(data);
          Inc(Result); BlockWrite(f, _length, SizeOf(_length)); LastIOState := IOResult; if LastIOState <> 0 then Exit;
          if _length > 0 then
            begin Inc(Result); BlockWrite(f, data[0], _length); LastIOState := IOResult; if LastIOState <> 0 then Exit; end;
        end;
      fileLocationTable.globalDataTable2Count := Length(globalDataTable2);
      fileLocationTable.globalDataTable2Offset := FilePos(F);
      for i := 0 to fileLocationTable.globalDataTable2Count - 1 do
        with globalDataTable2[i] do
        begin
          Inc(Result); BlockWrite(f, _type, SizeOf(_type)); LastIOState := IOResult; if LastIOState <> 0 then Exit;
          _length := Length(data);
          Inc(Result); BlockWrite(f, _length, SizeOf(_length)); LastIOState := IOResult; if LastIOState <> 0 then Exit;
          if _length > 0 then
            begin Inc(Result); BlockWrite(f, data[0], _length); LastIOState := IOResult; if LastIOState <> 0 then Exit; end;
        end;
      FileLocationTable.changeFormCount := Length(changeForms);
      fileLocationTable.changeFormsOffset := FilePos(F);
      iProcess := 0;
      bBreak := False;
      if Assigned(Progress) then
        Progress(iProcess, bBreak);
      for i := 0 to FileLocationTable.changeFormCount - 1 do
        with changeForms[i] do
        begin
          Inc(Result); BlockWrite(f, formID, SizeOf(formID)); LastIOState := IOResult; if LastIOState <> 0 then Exit;
          Inc(Result); BlockWrite(f, changeFlags, SizeOf(changeFlags)); LastIOState := IOResult; if LastIOState <> 0 then Exit;
          if length1 < length2 then
            if not DecompressData(data, length2) then
              Exit
            else
              length2 := 0;
          length1 := Length(data);
          if ((length1 shr 16) <> 0) or ((length2 shr 16) <> 0) then
            _type := (_type and $3F) or (2 shl 6)
          else
            if ((length1 shr 8) <> 0) or ((length2 shr 8) <> 0) then
              _type := (_type and $3F) or (1 shl 6)
            else
              _type := _type and $3F;
          Inc(Result); BlockWrite(f, _type, SizeOf(_type)); LastIOState := IOResult; if LastIOState <> 0 then Exit;
          Inc(Result); BlockWrite(f, version, SizeOf(version)); LastIOState := IOResult; if LastIOState <> 0 then Exit;
          case _type shr 6 of
            0: begin
                 b := length1;
                 Inc(Result); BlockWrite(f, b, SizeOf(b)); LastIOState := IOResult; if LastIOState <> 0 then Exit;
                 b := length2;
                 Inc(Result); BlockWrite(f, b, SizeOf(b)); LastIOState := IOResult; if LastIOState <> 0 then Exit;
               end;
            1: begin
                 w := length1;
                 Inc(Result); BlockWrite(f, w, SizeOf(w)); LastIOState := IOResult; if LastIOState <> 0 then Exit;
                 w := length2;
                 Inc(Result); BlockWrite(f, w, SizeOf(w)); LastIOState := IOResult; if LastIOState <> 0 then Exit;
               end;
            2: begin
                 c := length1;
                 Inc(Result); BlockWrite(f, c, SizeOf(c)); LastIOState := IOResult; if LastIOState <> 0 then Exit;
                 c := length2;
                 Inc(Result); BlockWrite(f, c, SizeOf(c)); LastIOState := IOResult; if LastIOState <> 0 then Exit;
               end;
          end;
          if length1 > 0 then
            begin Inc(Result); BlockWrite(f, data[0], length1); LastIOState := IOResult; if LastIOState <> 0 then Exit; end;
          if FileLocationTable.changeFormCount > 1 then
            if Round(i / (FileLocationTable.changeFormCount - 1) * 100) <> iProcess then
            begin
              iProcess := Round(i / (FileLocationTable.changeFormCount - 1) * 100);
              if Assigned(Progress) then
                Progress(iProcess, bBreak);
              if bBreak then
              begin
                Result := -1;
                Exit;
              end;
            end;
        end;
      FileLocationTable.globalDataTable3Count := Length(globalDataTable3) - 1; //buggy
      fileLocationTable.globalDataTable3Offset := FilePos(F);
      for i := 0 to fileLocationTable.globalDataTable3Count do
        with globalDataTable3[i] do
        begin
          Inc(Result); BlockWrite(f, _type, SizeOf(_type)); LastIOState := IOResult; if LastIOState <> 0 then Exit;
          _length := Length(data);
          Inc(Result); BlockWrite(f, _length, SizeOf(_length)); LastIOState := IOResult; if LastIOState <> 0 then Exit;
          if _length > 0 then
            begin Inc(Result); BlockWrite(f, data[0], _length); LastIOState := IOResult; if LastIOState <> 0 then Exit; end;
        end;
      formIDArrayCount := Length(formIDArray);
      fileLocationTable.formIDArrayOffest := FilePos(F);
      Inc(Result); BlockWrite(f, formIDArrayCount, SizeOf(formIDArrayCount)); LastIOState := IOResult; if LastIOState <> 0 then Exit;
      for i := 0 to formIDArrayCount - 1 do
        begin Inc(Result); BlockWrite(f, formIDArray[i], SizeOf(formIDArray[i])); LastIOState := IOResult; if LastIOState <> 0 then Exit; end;
      unknown2TableCount := Length(unknown2Table);
      Inc(Result); BlockWrite(f, unknown2TableCount, SizeOf(unknown2TableCount)); LastIOState := IOResult; if LastIOState <> 0 then Exit;
      for i := 0 to unknown2TableCount - 1 do
        begin Inc(Result); BlockWrite(f, unknown2Table[i], SizeOf(unknown2Table[i])); LastIOState := IOResult; if LastIOState <> 0 then Exit; end;
      fileLocationTable.unknownTable3Offset := FilePos(f);
      with unknown3Table do
      begin
        unknown3TableSize := SizeOf(Count);
        Count := Length(unknown);
        for i := 0 to Count - 1 do
          unknown3TableSize := unknown3TableSize + SizeOf(unknown[i].w) + unknown[i].w;
        Inc(Result); BlockWrite(f, unknown3TableSize, SizeOf(unknown3TableSize)); LastIOState := IOResult; if LastIOState <> 0 then Exit;
        Inc(Result); BlockWrite(f, Count, SizeOf(Count)); LastIOState := IOResult; if LastIOState <> 0 then Exit;
        for i := 0 to Count - 1 do
        begin
          Inc(Result); BlockWrite(f, unknown[i].w, SizeOf(unknown[i].w)); LastIOState := IOResult; if LastIOState <> 0 then Exit;
          if unknown[i].w > 0 then
            begin Inc(Result); BlockWrite(f, unknown[i].s[0], unknown[i].w); LastIOState := IOResult; if LastIOState <> 0 then Exit; end;
        end;
      end;
      Seek(F, iFAT);
      Inc(Result); BlockWrite(f, fileLocationTable, SizeOf(fileLocationTable)); LastIOState := IOResult; if LastIOState <> 0 then Exit;
    end;
    Result := 0;
  finally
    CloseFile(F);
    {$IFDEF IOCHECKS_ON} {$I+} {$UNDEF IOCHECKS_ON} {$ENDIF}
  end;
end;

function SaveESSFileCompressed(var ESSFile: TESSFile; sFileName: string; Progress: TProgress = nil; CompressionLevel: TCompressionLevel = clMax): Integer;
var
  F: File;
  i, iFAT: Integer;
  b: uint8;
  w: uint16;
  c: uint32;
  iProcess: Integer;
  bBreak: Boolean;
begin
  Result := -2;
  if ESSFile.magic <> C_TESVESS then
    Exit;
  Result := 1;
  AssignFile(F, sFileName);
  {$IFOPT I+} {$DEFINE IOCHECKS_ON} {$ENDIF} {$I-}
  ReWrite(F, 1);
  LastIOState := IOResult;
  if LastIOState = 0 then
  try
    with ESSFile do
    begin
      Inc(Result); BlockWrite(f, magic[0], SizeOf(TMagic)); LastIOState := IOResult; if LastIOState <> 0 then Exit;
      with Header do
      begin
        headerSize := 5 * SizeOf(uint32) + 2 * SizeOf(float32) + SizeOf(uint16) + SizeOf(TFileTime) + 4 * SizeOf(playerName.w) + playerName.w + playerLocation.w + gameDate.w + playerRaceEditorId.w;
        Inc(Result); BlockWrite(f, headerSize, SizeOf(headerSize)); LastIOState := IOResult; if LastIOState <> 0 then Exit;
        Inc(Result); BlockWrite(f, version, SizeOf(version)); LastIOState := IOResult; if LastIOState <> 0 then Exit;
        Inc(Result); BlockWrite(f, saveNumber, SizeOf(saveNumber)); LastIOState := IOResult; if LastIOState <> 0 then Exit;
        Inc(Result); BlockWrite(f, playerName.w, SizeOf(playerName.w)); LastIOState := IOResult; if LastIOState <> 0 then Exit;
        if playerName.w > 0 then
          begin Inc(Result); BlockWrite(f, playerName.s[0], playerName.w); LastIOState := IOResult; if LastIOState <> 0 then Exit; end;
        Inc(Result); BlockWrite(f, playerLevel, SizeOf(playerLevel)); LastIOState := IOResult; if LastIOState <> 0 then Exit;
        Inc(Result); BlockWrite(f, playerLocation.w, SizeOf(playerLocation.w)); LastIOState := IOResult; if LastIOState <> 0 then Exit;
        if playerLocation.w > 0 then
          begin Inc(Result); BlockWrite(f, playerLocation.s[0], playerLocation.w); LastIOState := IOResult; if LastIOState <> 0 then Exit; end;
        Inc(Result); BlockWrite(f, gameDate.w, SizeOf(gameDate.w)); LastIOState := IOResult; if LastIOState <> 0 then Exit;
        if gameDate.w > 0 then
          begin Inc(Result); BlockWrite(f, gameDate.s[0], gameDate.w); LastIOState := IOResult; if LastIOState <> 0 then Exit; end;
        Inc(Result); BlockWrite(f, playerRaceEditorId.w, SizeOf(playerRaceEditorId.w)); LastIOState := IOResult; if LastIOState <> 0 then Exit;
        if playerRaceEditorId.w > 0 then
          begin Inc(Result); BlockWrite(f, playerRaceEditorId.s[0], playerRaceEditorId.w); LastIOState := IOResult; if LastIOState <> 0 then Exit; end;
        Inc(Result); BlockWrite(f, unknown1, SizeOf(unknown1)); LastIOState := IOResult; if LastIOState <> 0 then Exit;
        Inc(Result); BlockWrite(f, unknown2, SizeOf(unknown2)); LastIOState := IOResult; if LastIOState <> 0 then Exit;
        Inc(Result); BlockWrite(f, unknown3, SizeOf(unknown3)); LastIOState := IOResult; if LastIOState <> 0 then Exit;
        Inc(Result); BlockWrite(f, filetime, SizeOf(filetime)); LastIOState := IOResult; if LastIOState <> 0 then Exit;
        Inc(Result); BlockWrite(f, shotWidth, SizeOf(shotWidth)); LastIOState := IOResult; if LastIOState <> 0 then Exit;
        Inc(Result); BlockWrite(f, shotHeight, SizeOf(shotHeight)); LastIOState := IOResult; if LastIOState <> 0 then Exit;
      end;
      if Length(screenshotData) > 0 then
        Inc(Result); BlockWrite(f, screenshotData[0], Length(screenshotData)); LastIOState := IOResult; if LastIOState <> 0 then Exit;
      Inc(Result); BlockWrite(f, formVersion, SizeOf(formVersion)); LastIOState := IOResult; if LastIOState <> 0 then Exit;
      with pluginInfo do
      begin
        pluginInfoSize := SizeOf(pluginCount);
        pluginCount := Length(plugins);
        for i := 0 to pluginCount - 1 do
          pluginInfoSize := pluginInfoSize + SizeOf(plugins[i].w) + plugins[i].w;
        Inc(Result); BlockWrite(f, pluginInfoSize, SizeOf(pluginInfoSize)); LastIOState := IOResult; if LastIOState <> 0 then Exit;
        Inc(Result); BlockWrite(f, pluginCount, SizeOf(pluginCount)); LastIOState := IOResult; if LastIOState <> 0 then Exit;
        for i := 0 to pluginCount - 1 do
        begin
          Inc(Result); BlockWrite(f, plugins[i].w, SizeOf(plugins[i].w)); LastIOState := IOResult; if LastIOState <> 0 then Exit;
          if plugins[i].w > 0 then
            begin Inc(Result); BlockWrite(f, plugins[i].s[0], plugins[i].w); LastIOState := IOResult; if LastIOState <> 0 then Exit; end;
        end;
      end;
      iFAT := FilePos(F);
      Inc(Result); BlockWrite(f, fileLocationTable, SizeOf(fileLocationTable)); LastIOState := IOResult; if LastIOState <> 0 then Exit;
      fileLocationTable.globalDataTable1Count := Length(globalDataTable1);
      fileLocationTable.globalDataTable1Offset := FilePos(F);
      for i := 0 to fileLocationTable.globalDataTable1Count - 1 do
        with globalDataTable1[i] do
        begin
          Inc(Result); BlockWrite(f, _type, SizeOf(_type)); LastIOState := IOResult; if LastIOState <> 0 then Exit;
          _length := Length(data);
          Inc(Result); BlockWrite(f, _length, SizeOf(_length)); LastIOState := IOResult; if LastIOState <> 0 then Exit;
          if _length > 0 then
            begin Inc(Result); BlockWrite(f, data[0], _length); LastIOState := IOResult; if LastIOState <> 0 then Exit; end;
        end;
      fileLocationTable.globalDataTable2Count := Length(globalDataTable2);
      fileLocationTable.globalDataTable2Offset := FilePos(F);
      for i := 0 to fileLocationTable.globalDataTable2Count - 1 do
        with globalDataTable2[i] do
        begin
          Inc(Result); BlockWrite(f, _type, SizeOf(_type)); LastIOState := IOResult; if LastIOState <> 0 then Exit;
          _length := Length(data);
          Inc(Result); BlockWrite(f, _length, SizeOf(_length)); LastIOState := IOResult; if LastIOState <> 0 then Exit;
          if _length > 0 then
            begin Inc(Result); BlockWrite(f, data[0], _length); LastIOState := IOResult; if LastIOState <> 0 then Exit; end;
        end;
      FileLocationTable.changeFormCount := Length(changeForms);
      fileLocationTable.changeFormsOffset := FilePos(F);
      iProcess := 0;
      bBreak := False;
      if Assigned(Progress) then
        Progress(iProcess, bBreak);
      for i := 0 to FileLocationTable.changeFormCount - 1 do
        with changeForms[i] do
        begin
          Inc(Result); BlockWrite(f, formID, SizeOf(formID)); LastIOState := IOResult; if LastIOState <> 0 then Exit;
          Inc(Result); BlockWrite(f, changeFlags, SizeOf(changeFlags)); LastIOState := IOResult; if LastIOState <> 0 then Exit;
          if length1 < length2 then
            if not DecompressData(data, length2) then
              Exit
            else
              length2 := 0;
          length2 := Length(data);
          if not CompressData(data, CompressionLevel) then
            length2 := 0;
          length1 := Length(data);
          if ((length1 shr 16) <> 0) or ((length2 shr 16) <> 0) then
            _type := (_type and $3F) or (2 shl 6)
          else
            if ((length1 shr 8) <> 0) or ((length2 shr 8) <> 0) then
              _type := (_type and $3F) or (1 shl 6)
            else
              _type := _type and $3F;
          Inc(Result); BlockWrite(f, _type, SizeOf(_type)); LastIOState := IOResult; if LastIOState <> 0 then Exit;
          Inc(Result); BlockWrite(f, version, SizeOf(version)); LastIOState := IOResult; if LastIOState <> 0 then Exit;
          case _type shr 6 of
            0: begin
                 b := length1;
                 Inc(Result); BlockWrite(f, b, SizeOf(b)); LastIOState := IOResult; if LastIOState <> 0 then Exit;
                 b := length2;
                 Inc(Result); BlockWrite(f, b, SizeOf(b)); LastIOState := IOResult; if LastIOState <> 0 then Exit;
               end;
            1: begin
                 w := length1;
                 Inc(Result); BlockWrite(f, w, SizeOf(w)); LastIOState := IOResult; if LastIOState <> 0 then Exit;
                 w := length2;
                 Inc(Result); BlockWrite(f, w, SizeOf(w)); LastIOState := IOResult; if LastIOState <> 0 then Exit;
               end;
            2: begin
                 c := length1;
                 Inc(Result); BlockWrite(f, c, SizeOf(c)); LastIOState := IOResult; if LastIOState <> 0 then Exit;
                 c := length2;
                 Inc(Result); BlockWrite(f, c, SizeOf(c)); LastIOState := IOResult; if LastIOState <> 0 then Exit;
               end;
          end;
          if length1 > 0 then
            begin Inc(Result); BlockWrite(f, data[0], length1); LastIOState := IOResult; if LastIOState <> 0 then Exit; end;
          if FileLocationTable.changeFormCount > 1 then
            if Round(i / (FileLocationTable.changeFormCount - 1) * 100) <> iProcess then
            begin
              iProcess := Round(i / (FileLocationTable.changeFormCount - 1) * 100);
              if Assigned(Progress) then
                Progress(iProcess, bBreak);
              if bBreak then
              begin
                Result := -1;
                Exit;
              end;
            end;
        end;
      FileLocationTable.globalDataTable3Count := Length(globalDataTable3) - 1; //buggy
      fileLocationTable.globalDataTable3Offset := FilePos(F);
      for i := 0 to fileLocationTable.globalDataTable3Count do
        with globalDataTable3[i] do
        begin
          Inc(Result); BlockWrite(f, _type, SizeOf(_type)); LastIOState := IOResult; if LastIOState <> 0 then Exit;
          _length := Length(data);
          Inc(Result); BlockWrite(f, _length, SizeOf(_length)); LastIOState := IOResult; if LastIOState <> 0 then Exit;
          if _length > 0 then
            begin Inc(Result); BlockWrite(f, data[0], _length); LastIOState := IOResult; if LastIOState <> 0 then Exit; end;
        end;
      formIDArrayCount := Length(formIDArray);
      fileLocationTable.formIDArrayOffest := FilePos(F);
      Inc(Result); BlockWrite(f, formIDArrayCount, SizeOf(formIDArrayCount)); LastIOState := IOResult; if LastIOState <> 0 then Exit;
      for i := 0 to formIDArrayCount - 1 do
        begin Inc(Result); BlockWrite(f, formIDArray[i], SizeOf(formIDArray[i])); LastIOState := IOResult; if LastIOState <> 0 then Exit; end;
      unknown2TableCount := Length(unknown2Table);
      Inc(Result); BlockWrite(f, unknown2TableCount, SizeOf(unknown2TableCount)); LastIOState := IOResult; if LastIOState <> 0 then Exit;
      for i := 0 to unknown2TableCount - 1 do
        begin Inc(Result); BlockWrite(f, unknown2Table[i], SizeOf(unknown2Table[i])); LastIOState := IOResult; if LastIOState <> 0 then Exit; end;
      fileLocationTable.unknownTable3Offset := FilePos(f);
      with unknown3Table do
      begin
        unknown3TableSize := SizeOf(Count);
        Count := Length(unknown);
        for i := 0 to Count - 1 do
          unknown3TableSize := unknown3TableSize + SizeOf(unknown[i].w) + unknown[i].w;
        Inc(Result); BlockWrite(f, unknown3TableSize, SizeOf(unknown3TableSize)); LastIOState := IOResult; if LastIOState <> 0 then Exit;
        Inc(Result); BlockWrite(f, Count, SizeOf(Count)); LastIOState := IOResult; if LastIOState <> 0 then Exit;
        for i := 0 to Count - 1 do
        begin
          Inc(Result); BlockWrite(f, unknown[i].w, SizeOf(unknown[i].w)); LastIOState := IOResult; if LastIOState <> 0 then Exit;
          if unknown[i].w > 0 then
            begin Inc(Result); BlockWrite(f, unknown[i].s[0], unknown[i].w); LastIOState := IOResult; if LastIOState <> 0 then Exit; end;
        end;
      end;
      Seek(F, iFAT);
      Inc(Result); BlockWrite(f, fileLocationTable, SizeOf(fileLocationTable)); LastIOState := IOResult; if LastIOState <> 0 then Exit;
    end;
    Result := 0;
  finally
    CloseFile(F);
    {$IFDEF IOCHECKS_ON} {$I+} {$UNDEF IOCHECKS_ON} {$ENDIF}
  end;
end;
{$IF Defined(USEREGION)}{$ENDREGION}{$IFEND}

{$IF Defined(USEREGION)}{$REGION 'Read ESS file info'}{$IFEND}
function ReadESSFileInfo(var ESSFileInfo: TESSFileInfo; sFileName: string): integer;
var
  F: File;
  sTmp: wstring;
begin
  Result := 1;
  FreeESSFileInfo(ESSFileInfo);
  Inc(Result);
  AssignFile(F, sFileName);
  {$IFOPT I+} {$DEFINE IOCHECKS_ON} {$ENDIF} {$I-}
  FileMode := fmOpenRead;
  Reset(F, 1);
  LastIOState := IOResult;
  if LastIOState = 0 then
  try
    with ESSFileInfo do
    begin
      Inc(Result); Seek(F, SizeOf(TMagic) + 2 * SizeOf(uInt32)); LastIOState := IOResult; if LastIOState <> 0 then Exit;
      Inc(Result); if not Get_uint32(F, saveNumber) then Exit;
      Inc(Result); if not Get_wstring(F, sTmp) then Exit;
      playerName := wstringToString(sTmp);
      Inc(Result); if not Get_uint32(F, playerLevel) then Exit;
      Inc(Result); if not Get_wstring(F, sTmp) then Exit;
      playerLocation := wstringToString(sTmp);
      Inc(Result); if not Get_wstring(F, sTmp) then Exit;
      gameDate := wstringToString(sTmp);
      Inc(Result); if not Get_wstring(F, sTmp) then Exit;
      playerRaceEditorId := wstringToString(sTmp);
      Inc(Result); Seek(F, FilePos(F) + SizeOf(uint16) + 2 * SizeOf(float32) + SizeOf(TFileTime)); LastIOState := IOResult; if LastIOState <> 0 then Exit;
      Inc(Result); if not Get_uint32(F, shotWidth) then Exit;
      if shotWidth > 4096 then
        Exit;
      Inc(Result); if not Get_uint32(F, shotHeight) then Exit;
      if shotHeight > 4096 then
        Exit;
      Inc(Result); if not Get_screenshotData(F, shotWidth, shotHeight, screenshotData) then Exit;
    end;
    Result := 0;
  finally
    CloseFile(F);
    {$IFDEF IOCHECKS_ON} {$I+} {$UNDEF IOCHECKS_ON} {$ENDIF}
  end;
end;
{$IF Defined(USEREGION)}{$ENDREGION}{$IFEND}

function RefID(byte0, byte1, byte2: Byte): TRefID;
begin
  Result.byte0 := byte0;
  Result.byte1 := byte1;
  Result.byte2 := byte2;
end;

function RefIDCompare(Ref1, Ref2: TRefID): integer;
begin
  if (Ref1.byte0 = Ref2.byte0) and (Ref1.byte1 = Ref2.byte1) and (Ref1.byte2 = Ref2.byte2) then
    Result := 0
  else
    if (Ref1.byte0 > Ref2.byte0) or
      ((Ref1.byte0 = Ref2.byte0) and (Ref1.byte1 > Ref2.byte1)) or
      ((Ref1.byte0 = Ref2.byte0) and (Ref1.byte1 = Ref2.byte1) and (Ref1.byte2 > Ref2.byte2)) then
      Result := 1
    else
      Result := -1
end;

function AddToChangeForm(aForms: PChangeForms; aID: TRefID; aFlags: uint32; aType: uint8; aData: PBytes = nil; aLen: uint32 = 0; aCompress: Boolean = False): integer;
var
  i: integer;
begin
  Result := 0;
  for i := 0 to Length(aForms^) - 1 do
    if RefIDCompare(aForms^[i].formID , aID) = 0 then
    begin
      Result := -1;
      Exit;
    end;
  SetLength(aForms^, Length(aForms^) + 1);
  with aForms^[Length(aForms^) - 1] do
  begin
    formID := aID;
    changeFlags := aFlags;
    _type :=  aType;
    version := 57;
    length1 := aLen;
    if (aLen > 0) and (aData <> nil) then
    begin
      SetLength(data, aLen);
      Move(aData^[0], data[0], aLen);
      if not aCompress or not CompressData(data) then
        length2 := 0
      else
      begin
        length1 := Length(data);
        length2 := aLen;
      end;
    end
    else
    begin
      length2 := 0;
      SetLength(data, 0);
    end;
  end;
end;

end.

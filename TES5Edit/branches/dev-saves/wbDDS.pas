unit wbDDS;

{$POINTERMATH ON}

interface

uses
  Windows, Graphics, SysUtils, Classes;

function wbDDSStreamToBitmap(aStream: TStream; Bitmap: TBitmap): Boolean;
function wbDDSDataToBitmap(aData: TBytes; Bitmap: TBitmap): Boolean;

implementation

const
  DDS_FORMAT        = $20534444;
  DXT1_FORMAT       = $31545844;
  DXT3_FORMAT       = $33545844;
  DXT5_FORMAT       = $35545844;
  DDPF_FOURCC       = $00000004;
  DDPF_RGB          = $00000040;
  DDPF_ALPHAPIXELS  = $00000001;

type
  TDDSPixelFormat = record
    dwSize: Cardinal;
    dwFlags: Cardinal;
    dwFourCC: Cardinal;
    dwRGBBitCount: Cardinal;
    dwRBitMask: Cardinal;
    dwGBitMask: Cardinal;
    dwBBitMask: Cardinal;
    dwABitMask: Cardinal;
  end;

  TDDSHeader = record
    dwSize: Cardinal;
    dwFlags: Cardinal;
    dwHeight: Cardinal;
    dwWidth: Cardinal;
    dwPitchOrLinearSize: Cardinal;
    dwDepth: Cardinal;
    dwMipMapCount: Cardinal;
    dwReserved1: array[0..10] of Cardinal;
    ddspf: TDDSPixelFormat;
    dwCaps: Cardinal;
    dwCaps2: Cardinal;
    dwCaps3: Cardinal;
    dwCaps4: Cardinal;
    dwReserved2: Cardinal;
  end;

  TR5G6B6 = Word;
  TARGB = packed record
    B: Byte;
    G: Byte;
    R: Byte;
    A: Byte;
  end;
  PARGB = ^TARGB;

procedure RGB(C: TR5G6B6; out Result: TARGB);
var
  R, G, B: Byte;
begin
  R := C shr 11;
  G := (C shr 5) and 63;
  B := C and 31;
  Result.A := 255;
  Result.R := (R shl 3) or (R shr 2);
  Result.G := (G shl 2) or (G shr 4);
  Result.B := (B shl 3) or (B shr 2);
end;

function DecodeDXT1(aStream: TStream; Width, Height: Cardinal;
    Bitmap: TBitmap): Boolean;
var
  Rx, Cx, Rn, Cn: Cardinal;
  Data, PData: PByte;
  C0, C1: TR5G6B6;
  C: array [0..3] of TARGB;
  Pc: PARGB;
  Ofs: Cardinal;
  Mask, Selector: Cardinal;
  LinearSize: Cardinal;
begin
  Result := True;
  try
    LinearSize := ((Width + 3) shr 2) shl 3;
    GetMem(Data, LinearSize);
    try
      for Rn := 0 to (Height shr 2) - 1 do
      begin
        aStream.ReadBuffer(Data^, LinearSize);
        PData := Data;
        for Cn := 0 to (Width shr 2) - 1 do
        begin
          C0 := PWord(PData + 0)^;
          C1 := PWord(PData + 2)^;
          RGB(C0, C[0]); RGB(C1, C[1]); Inc(PData, 4);
          Mask := PCardinal(PData)^; Inc(PData, 4);
          if C0 > C1 then
          begin
            C[2].A := 255;
            C[2].R := (2 * C[0].R + C[1].R + 1) div 3;
            C[2].G := (2 * C[0].G + C[1].G + 1) div 3;
            C[2].B := (2 * C[0].B + C[1].B + 1) div 3;
            C[3].A := 255;
            C[3].R := (C[0].R + 2 * C[1].R + 1) div 3;
            C[3].G := (C[0].G + 2 * C[1].G + 1) div 3;
            C[3].B := (C[0].B + 2 * C[1].B + 1) div 3;
          end
          else
          begin
            C[2].A := 255;
            C[2].R := (C[0].R + C[1].R) shr 1;
            C[2].G := (C[0].G + C[1].G) shr 1;
            C[2].B := (C[0].B + C[1].B) shr 1;
            C[3].A := 0;
          end;
          Ofs := Cn shl 2;
          for Rx := 0 to 3 do
          begin
            Pc := PARGB(Bitmap.ScanLine[Rn shl 2 + Rx]) + Ofs;
            for Cx := 0 to 3 do
            begin
              Selector := Mask and 3;
              Pc^ := C[Selector];
              Inc(Pc);
              Mask := Mask shr 2;
            end;
          end;
        end;
      end;
    finally
      FreeMem(Data);
    end;
  except
    Result := False;
  end;
end;

function DecodeDXT3(aStream: TStream; Width, Height: Cardinal;
    Bitmap: TBitmap): Boolean;
var
  Rx, Cx, Rn, Cn: Cardinal;
  Data, PData: PByte;
  C0, C1: TR5G6B6;
  C: array [0..3] of TARGB;
  Pc: PARGB;
  Ofs: Cardinal;
  Mask, Selector: Cardinal;
  Alpha: array [0..3] of Word;
  LinearSize: Cardinal;
begin
  Result := True;
  try
    LinearSize := ((Width + 3) shr 2) shl 4;
    GetMem(Data, LinearSize);
    try
      for Rn := 0 to (Height shr 2) - 1 do
      begin
        aStream.ReadBuffer(Data^, LinearSize);
        PData := Data;
        for Cn := 0 to (Width shr 2) - 1 do
        begin
          Alpha[0] := PWord(PData + 0)^;
          Alpha[1] := PWord(PData + 2)^;
          Alpha[2] := PWord(PData + 4)^;
          Alpha[3] := PWord(PData + 6)^;
          C0 := PWord(PData + 8)^;
          C1 := PWord(PData + 10)^;
          Mask := PCardinal(PData + 12)^;
          Inc(PData, 16);
          RGB(C0, C[0]);
          RGB(C1, C[1]);
          C[2].A := 255;
          C[2].R := (2 * C[0].R + C[1].R + 1) div 3;
          C[2].G := (2 * C[0].G + C[1].G + 1) div 3;
          C[2].B := (2 * C[0].B + C[1].B + 1) div 3;
          C[3].A := 255;
          C[3].R := (C[0].R + 2 * C[1].R + 1) div 3;
          C[3].G := (C[0].G + 2 * C[1].G + 1) div 3;
          C[3].B := (C[0].B + 2 * C[1].B + 1) div 3;
          Ofs := Cn shl 2;
          for Rx := 0 to 3 do
          begin
            Pc := PARGB(Bitmap.ScanLine[Rn shl 2 + Rx]) + Ofs;
            for Cx := 0 to 3 do
            begin
              Selector := Mask and 3;
              C[Selector].A := Alpha[Rx] and 15;
              Alpha[Rx] := Alpha[Rx] shr 4;;
              Pc^ := C[Selector];
              Inc(Pc);
              Mask := Mask shr 2;
            end;
          end;
        end;
      end;
    finally
      FreeMem(Data);
    end;
  except
    Result := False;
  end;
end;

function DecodeDXT5(aStream: TStream; Width, Height: Cardinal;
    Bitmap: TBitmap): Boolean;
var
  Rx, Cx, Rn, Cn: Cardinal;
  Data, PData: PByte;
  C0, C1: TR5G6B6;
  C: array [0..3] of TARGB;
  Pc: PARGB;
  Ofs: Cardinal;
  Mask, Selector: Cardinal;
  A: array [0..7] of Byte;
  PAMask: PByte;
  AMask: Cardinal;
  LinearSize: Cardinal;
begin
  Result := True;
  try
    LinearSize := ((Width + 3) shr 2) shl 4;
    GetMem(Data, LinearSize);
    try
      for Rn := 0 to (Height shr 2) - 1 do
      begin
        aStream.ReadBuffer(Data^, LinearSize);
        PData := Data;
        for Cn := 0 to (Width shr 2) - 1 do
        begin
          A[0] := PData[0];
          A[1] := PData[1];
          PAMask := PData + 2;
          C0 := PWord(PData + 8)^;
          C1 := PWord(PData + 10)^;
          Mask := PCardinal(PData + 12)^;
          Inc(PData, 16);
          RGB(C0, C[0]);
          RGB(C1, C[1]);
          C[2].A := 255;
          C[2].R := (2 * C[0].R + C[1].R + 1) div 3;
          C[2].G := (2 * C[0].G + C[1].G + 1) div 3;
          C[2].B := (2 * C[0].B + C[1].B + 1) div 3;
          C[3].A := 255;
          C[3].R := (C[0].R + 2 * C[1].R + 1) div 3;
          C[3].G := (C[0].G + 2 * C[1].G + 1) div 3;
          C[3].B := (C[0].B + 2 * C[1].B + 1) div 3;
          if A[0] > A[1] then
          begin
            A[2] := (6 * A[0] + 1 * A[1] + 3) div 7;
            A[3] := (5 * A[0] + 2 * A[1] + 3) div 7;
            A[4] := (4 * A[0] + 3 * A[1] + 3) div 7;
            A[5] := (3 * A[0] + 4 * A[1] + 3) div 7;
            A[6] := (2 * A[0] + 5 * A[1] + 3) div 7;
            A[7] := (1 * A[0] + 6 * A[1] + 3) div 7;
          end
          else
          begin
            A[2] := (4 * A[0] + 1 * A[1] + 2) div 5;
            A[3] := (3 * A[0] + 2 * A[1] + 2) div 5;
            A[4] := (2 * A[0] + 3 * A[1] + 2) div 5;
            A[5] := (1 * A[0] + 4 * A[1] + 2) div 5;
            A[6] := 0;
            A[7] := 255;
          end;
          Ofs := Cn shl 2;
          AMask := PCardinal(PAMask)^;
          Inc(PAMask, 3);
          for Rx := 0 to 3 do
          begin
            Pc := PARGB(Bitmap.ScanLine[Rn shl 2 + Rx]) + Ofs;
            for Cx := 0 to 3 do
            begin
              Selector := Mask and 3;
              if Rx = 2 then AMask := PCardinal(PAMask)^;
              C[Selector].A := A[AMask and 7];
              AMask := AMask shr 3;;
              Pc^ := C[Selector];
              Inc(Pc);
              Mask := Mask shr 2;
            end;
          end;
        end;
      end;
    finally
      FreeMem(Data);
    end;
  except
    Result := False;
  end;
end;

function wbDDSStreamToBitmap(aStream: TStream; Bitmap: TBitmap): Boolean;
var
  MagicNumber: Cardinal;
  Header: TDDSHeader;
  Data: PByte;
  LinearSize: Cardinal;
  FourCC: Cardinal;
  W, H: Cardinal;
  Row: Cardinal;
begin
  Result := True;
  try
    aStream.Position := 0;
    aStream.Read(MagicNumber, 4);
    if MagicNumber = DDS_FORMAT then
    begin
      aStream.ReadBuffer(Header, SizeOf(Header));
      W := Header.dwWidth;
      H := Header.dwHeight;
      Bitmap.Assign(nil);
      Bitmap.PixelFormat := pf32bit;
      Bitmap.SetSize(W, H);
      if (Header.ddspf.dwFlags and DDPF_FOURCC) <> 0 then
      begin
        FourCC := Header.ddspf.dwFourCC;
        if FourCC = DXT1_FORMAT then
          Result := DecodeDXT1(aStream, W, H, Bitmap)
        else if FourCC = DXT3_FORMAT then
          Result := DecodeDXT3(aStream, W, H, Bitmap)
        else if FourCC = DXT5_FORMAT then
          Result := DecodeDXT5(aStream, W, H, Bitmap)
        else
          ; // Unsupported
      end
      else if (Header.ddspf.dwFlags and DDPF_RGB) <> 0 then
      begin
        LinearSize := ((W * Header.ddspf.dwRGBBitCount + 7 ) shr 3);
        GetMem(Data, LinearSize);
        try
          for Row := 0 to H - 1 do
          begin
            aStream.ReadBuffer(Data^, LinearSize);
            CopyMemory(Bitmap.ScanLine[Row], Data, LinearSize);
          end;
        finally
          FreeMem(Data);
        end;
      end
      else
        ; // Unsupported
    end;
  except
    Result := False;
  end;
end;

function wbDDSDataToBitmap(aData: TBytes; Bitmap: TBitmap): Boolean;
var
  BytesStream: TBytesStream;
begin
  BytesStream := TBytesStream.Create(aData);
  try
    Result := wbDDSStreamToBitmap(BytesStream, Bitmap);
  finally
    FreeAndNil(BytesStream);
  end;
end;


end.

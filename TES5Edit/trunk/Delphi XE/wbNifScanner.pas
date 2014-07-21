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

unit wbNifScanner;

{$I wbDefines.inc}

interface

uses
  SysUtils,
  Classes;

function NifTextures(aNifData: TBytes; aTextures: TStrings): Boolean;

implementation

{
  Get the list of textures from Nif data into aTextures
}
function NifTextures(aNifData: TBytes; aTextures: TStrings): Boolean;
const
  NifMagic = 'Gamebryo File Format';
  cNifMaxBlocks = 7000;
  cNifMaxBlockTypes = 2000;
  cNifMaxSizedString = 1024;

  // read string terminated by $0A
  function ReadLineString(data: TBinaryReader): string;
  var
    c: Char;
  begin
    Result := '';
    repeat
      c := Char(data.ReadByte);
      if c <> #$0A then
        Result := Result + c;
    until c = #$0A;
  end;

  // read null terminated string, 1 byte prefix with length including null
  function ReadShortString(data: TBinaryReader): string;
  begin
    Result := TEncoding.ASCII.GetString(data.ReadBytes(data.ReadByte - 1));
    data.ReadByte; // skip null
  end;

  // read string with 4 byte prefix
  function ReadSizedString(data: TBinaryReader): string;
  var
    i: integer;
  begin
    i := data.ReadInt32;
    if i > cNifMaxSizedString then
      raise Exception.CreateFmt('Probably invalid Nif file, SizedString length > %d', [cNifMaxSizedString]);
    Result := TEncoding.ASCII.GetString(data.ReadBytes(i));
  end;

var
  aStream: TBytesStream;
  data: TBinaryReader;
  i, j, n: integer;
  s: string;
  NifVersion: Cardinal;
  NifNumBlocks, NifNumBlockTypes, NifNumStrings: Integer;
  NifBlockTypes: array of string;
  NifBlockType: array of integer;
  NifBlockSizes: array of integer;
  NifBlockOffsets: array of integer;
begin
  Result := False;

  if Length(aNifData) = 0 then
    Exit;

  if not Assigned(aTextures) then
    Exit;

  aTextures.Clear;

  aStream := TBytesStream.Create(aNifData);
  data := TBinaryReader.Create(aStream);

  try
    // check Nif header
    if TEncoding.ASCII.GetString(data.ReadBytes(Length(NifMagic))) <> NifMagic then
      Exit;

    // skip the rest of header
    ReadLineString(data);

    // Version, Skyrim is $14020007
    NifVersion := data.ReadUInt32;
    if NifVersion < $14000000 then
      Exit;
    //WriteLn(IntToHex(NifVersion, 8));

    // Endianness
    if NifVersion >= $14000004 then
      data.ReadByte;

    // skip User version
    data.ReadUInt32;

    // Num Blocks
    NifNumBlocks := data.ReadUInt32;
    if NifNumBlocks > cNifMaxBlocks then
      raise Exception.CreateFmt('Probably invalid Nif file, NifNumBlocks > %d', [cNifMaxBlocks]);
    //WriteLn(Format('NumBlocks = %d', [NifNumBlocks]));

    data.ReadUInt32; // skip User version 2
    ReadShortString(data); // skip Export Info \ Creator
    ReadShortString(data); // skip Export Info \ Export Info 1
    ReadShortString(data); // skip Export Info \ Export Info 2

    // Num Block Types
    NifNumBlockTypes := data.ReadUInt16;
    if NifNumBlockTypes > cNifMaxBlockTypes then
      raise Exception.CreateFmt('Probably invalid Nif file, NifNumBlockTypes > %d', [cNifMaxBlockTypes]);
    //WriteLn(Format('NumBlockTypes = %d', [NifNumBlockTypes]));
    //WriteLn('Position = ' + IntToHex(aStream.Position, 8));

    // block types
    SetLength(NifBlockTypes, NifNumBlockTypes);
    for i := 0 to Pred(NifNumBlockTypes) do
      //WriteLn(ReadSizedString(data));
      NifBlockTypes[i] := ReadSizedString(data);

    // block type index
    SetLength(NifBlockType, NifNumBlocks);
    for i := 0 to Pred(NifNumBlocks) do
      NifBlockType[i] := data.ReadUInt16;
      //WriteLn(data.ReadUInt16);

    // Block sizes
    if NifVersion >= $14020007 then begin
      SetLength(NifBlockSizes, NifNumBlocks);
      for i := 0 to Pred(NifNumBlocks) do
        NifBlockSizes[i] := data.ReadUInt32;
        //WriteLn(Format('Block Size[%d] = %d', [i, data.ReadUInt32]));
    end;

    // strings in header
    if NifVersion >= $14010003 then begin
      NifNumStrings := data.ReadUInt32;
      data.ReadUInt32; // skip max string length
      for i := 0 to Pred(NifNumStrings) do
        ReadSizedString(data);
    end;
    data.ReadUInt32; // skip Unknown Int 2

    if Length(NifBlockSizes) = 0 then
      Exit;

    // calculate blocks offsets
    SetLength(NifBlockOffsets, NifNumBlocks);
    j := aStream.Position;
    for i := 0 to Pred(NifNumBlocks) do begin
      NifBlockOffsets[i] := j;
      j := j + NifBlockSizes[i];
    end;

    // get used textures
    for i := 0 to Pred(NifNumBlocks) do begin

      if NifBlockTypes[NifBlockType[i]] = 'BSShaderTextureSet' then begin
        aStream.Position := NifBlockOffsets[i];
        j := data.ReadUInt32; // number of textures
        for n := 1 to j do
          aTextures.Add(ReadSizedString(data));
      end

      else if NifBlockTypes[NifBlockType[i]] = 'BSEffectShaderProperty' then begin
        aStream.Position := NifBlockOffsets[i];
        if NifVersion >= $14010003 then  // name is string index if version >= 20.1.0.3
          data.ReadUInt32;
        j := data.ReadUInt32; // Num Extra Data List
        data.ReadBytes(SizeOf(Integer) * j); // Extra Data List
        data.ReadInt32; // Controller
        data.ReadInt32; // Shader Flags 1
        data.ReadInt32; // Shader Flags 2
        data.ReadBytes(8); // UV Offset
        data.ReadBytes(8); // UV Scale
        aTextures.Add(ReadSizedString(data));
        data.ReadInt32; // Texture clamp mode
        data.ReadBytes(SizeOf(Single) * 10); // different falloff and emissive data
        aTextures.Add(ReadSizedString(data));
      end;

    end;

    // remove empty lines, trim others
    for i := Pred(aTextures.Count) downto 0 do begin
      s := Trim(aTextures[i]);
      if s = '' then
        aTextures.Delete(i)
      else
        aTextures[i] := s;
    end;

    Result := True;

  finally
    data.Free;
    aStream.Free;
  end;
end;



end.

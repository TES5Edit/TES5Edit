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

{>>>
  Anything written here is a temp hack for dump to show lstrings.
  The purpose is to make it work without large modifications to wbInterface or
  other core files.
  It doesn't free memory.
  Needs complete rewrite for TES5Edit.
<<<}

unit wbLocalization;

interface

uses
  Classes, SysUtils, StrUtils,
  wbInterface, wbBSA;

type
  TwbLocalizationString = (
    lsDLString,
    lsILString,
    lsString
  );

  TwbLocalizationFile = class
  private
    fName        : string;
    fFileName    : string;
    fFileType    : TwbLocalizationString;
    fStrings     : TStrings;
    fModified    : boolean;

    procedure Init;
    function FileStringType(aFileName: string): TwbLocalizationString;
    function ReadZString(aStream: TStream): string;
    function ReadLenZString(aStream: TStream): string;
    procedure WriteZString(aStream: TStream; aString: string);
    procedure WriteLenZString(aStream: TStream; aString: string);
    procedure ReadDirectory(aStream: TStream);
  protected
    function Get(Index: Integer): string;
    procedure Put(Index: Integer; const S: string);
  public
    property Strings[Index: Integer]: string read Get write Put; default;
    property Name: string read fName;
    property FileName: string read fFileName;
    property Modified: boolean read fModified;
    constructor Create(const aFileName: string); overload;
    constructor Create(const aFileName: string; aData: TBytes); overload;
    destructor Destroy; override;
    function Count: Integer;
    function IndexToID(Index: Integer): Integer;
    procedure WriteToFile(const aFileName: string);
    procedure ExportToFile(const aFileName: string);
  end;

  TwbLocalizationHandler = class
  private
    lFiles: TStrings;
  protected
    function Get(Index: Integer): TwbLocalizationFile;
  public
    NoTranslate: boolean;
    property Items[Index: Integer]: TwbLocalizationFile read Get; default;
    constructor Create;
    destructor Destroy; override;
    function Count: Integer;
    function LocalizedValueDecider(aElement: IwbElement): TwbLocalizationString;
    function AddLocalization(const aFileName: string): TwbLocalizationFile; overload;
    function AddLocalization(const aFileName: string; aData: TBytes): TwbLocalizationFile; overload;
    function GetValue(ID: Cardinal; aElement: IwbElement): string;
    function GetLocalizationFileName(aElement: IwbElement; var aFileName, aFullName: string): boolean;
  end;

var
  wbLocalizationHandler: TwbLocalizationHandler;

implementation

constructor TwbLocalizationFile.Create(const aFileName: string);
var
  fs: TFileStream;
  fStream: TStream;
  Buffer: PByte;
begin
  fFileName := aFileName;
  Init;
  // cache file in mem
  fStream := TMemoryStream.Create;
  try
    fs := TFileStream.Create(aFileName, fmOpenRead or fmShareDenyNone);
    GetMem(Buffer, fs.Size);
    fs.ReadBuffer(Buffer^, fs.Size);
    fStream.WriteBuffer(Buffer^, fs.Size);
    fStream.Position := 0;
    ReadDirectory(fStream);
  finally
    FreeMem(Buffer);
    FreeAndNil(fs);
    FreeAndNil(fStream);
  end;
end;

constructor TwbLocalizationFile.Create(const aFileName: string; aData: TBytes);
var
  fStream: TStream;
begin
  fFileName := aFileName;
  Init;
  fStream := TMemoryStream.Create;
  try
    fStream.WriteBuffer(aData[0], length(aData));
    fStream.Position := 0;
    ReadDirectory(fStream);
  finally
    FreeAndNil(fStream);
  end;
end;

destructor TwbLocalizationFile.Destroy;
begin
  FreeAndNil(fStrings);
  inherited;
end;

procedure TwbLocalizationFile.Init;
begin
  fModified := false;
  fName := ExtractFileName(fFileName);
  fFileType := FileStringType(fFileName);
  fStrings := TwbFastStringList.Create;
end;

function TwbLocalizationFile.FileStringType(aFileName: string): TwbLocalizationString;
var
  ext: string;
begin
  ext := ExtractFileExt(aFileName);
  if SameText(ext, '.dlstrings') then Result := lsDLString else
  if SameText(ext, '.ilstrings') then Result := lsILString else
    Result := lsString;
end;

function TwbLocalizationFile.ReadZString(aStream: TStream): string;
var
  s: AnsiString;
  c: AnsiChar;
begin
  s := '';
  while aStream.Read(c, 1) = 1 do begin
    if c <> #0 then s := s + c else break;
  end;
  Result := s;
end;

function TwbLocalizationFile.ReadLenZString(aStream: TStream): string;
var
  s: AnsiString;
  Len: Cardinal;
begin
  aStream.ReadBuffer(Len, 4);
  Dec(Len); // trailing null
  SetLength(s, Len);
  aStream.ReadBuffer(s[1], Len);
  Result := s;
end;

procedure TwbLocalizationFile.WriteZString(aStream: TStream; aString: string);
const z: AnsiChar = #0;
var
  s: AnsiString;
begin
  s := aString;
  aStream.WriteBuffer(PAnsiChar(s)^, length(s));
  aStream.WriteBuffer(z, SizeOf(z));
end;

procedure TwbLocalizationFile.WriteLenZString(aStream: TStream; aString: string);
const z: AnsiChar = #0;
var
  s: AnsiString;
  l: Cardinal;
begin
  s := aString;
  l := length(s) + SizeOf(z);
  aStream.WriteBuffer(l, SizeOf(Cardinal));
  aStream.WriteBuffer(PAnsiChar(s)^, length(s));
  aStream.WriteBuffer(z, SizeOf(z));
end;

procedure TwbLocalizationFile.ReadDirectory(aStream: TStream);
var
  scount, id, offset, i: Cardinal;
  oldPos: int64;
  s: string;
begin
  if aStream.Size < 8 then
    Exit;

  aStream.Read(scount, 4); // number of strings
  aStream.Position := aStream.Position + 4; // skip dataSize
  for i := 0 to scount - 1 do begin
    aStream.Read(id, 4); // string ID
    aStream.Read(offset, 4); // offset of string relative to data (header + dirsize)
    oldPos := aStream.Position;
    aStream.Position := 8 + scount*8 + offset; // header + dirsize + offset
    if fFileType = lsString then
      s := ReadZString(aStream)
    else
      s := ReadLenZString(aStream);
    fStrings.AddObject(s, pointer(id));
    aStream.Position := oldPos;
  end;
end;

procedure TwbLocalizationFile.WriteToFile(const aFileName: string);
var
  dir, data: TMemoryStream;
  f: TFileStream;
  i, c: Cardinal;
begin
  dir := TMemoryStream.Create;
  data := TMemoryStream.Create;
  c := fStrings.Count;
  dir.WriteBuffer(c, SizeOf(c)); // number of strings
  dir.WriteBuffer(c, SizeOf(c)); // dataSize, will overwrite later
  try
    for i := 0 to fStrings.Count - 1 do begin
      c := Cardinal(fStrings.Objects[i]);
      dir.WriteBuffer(c, SizeOf(c)); // ID
      c := data.Position;
      dir.WriteBuffer(c, SizeOf(c)); // relative position
      if fFileType = lsString then
        WriteZString(data, fStrings[i])
      else
        WriteLenZString(data, fStrings[i]);
    end;
    c := data.Size;
    dir.Position := 4;
    dir.WriteBuffer(c, SizeOf(c)); // dataSize

    f := TFileStream.Create(aFileName, fmCreate or fmShareDenyNone);
    f.CopyFrom(dir, 0);
    f.CopyFrom(data, 0);
  finally
    FreeAndNil(f);
    FreeAndNil(dir);
    FreeAndNil(data);
  end;
end;

function TwbLocalizationFile.Count: Integer;
begin
  Result := fStrings.Count;
end;

function TwbLocalizationFile.IndexToID(Index: Integer): Integer;
begin
  if Index < Count then
    Result := Integer(fStrings.Objects[Index])
  else
    Result := -1;
end;

function TwbLocalizationFile.Get(Index: Integer): string;
var
  idx: integer;
begin
  Result := '';
  idx := fStrings.IndexOfObject(Pointer(Index));
  if idx <> -1 then
    Result := fStrings[idx]
  else
    Result := '<Error: Unknown lstring ID ' + IntToHex(Index, 8) + '>';
end;

procedure TwbLocalizationFile.Put(Index: Integer; const S: string);
var
  idx: integer;
begin
  idx := fStrings.IndexOfObject(Pointer(Index));
  if idx <> -1 then
    if fStrings[idx] <> S then begin
      fStrings[idx] := S;
      fModified := true;
    end;
end;

procedure TwbLocalizationFile.ExportToFile(const aFileName: string);
var
  i: integer;
  sl: TStringList;
begin
  sl := TStringList.Create;
  try
    for i := 0 to fStrings.Count - 1 do begin
      sl.Add('[' + IntToHex(Integer(fStrings.Objects[i]), 8) + ']');
      sl.Add(fStrings[i]);
    end;
    sl.SaveToFile(aFileName);
  finally
    FreeAndNil(sl);
  end;
end;

constructor TwbLocalizationHandler.Create;
begin
  lFiles := TwbFastStringListCS.CreateSorted;
  NoTranslate := false;
end;

destructor TwbLocalizationHandler.Destroy;
var
  i: integer;
begin
  for i := 0 to lFiles.Count - 1 do
    TwbLocalizationFile(lFiles[i]).Free;
  FreeAndNil(lFiles);
end;

function TwbLocalizationHandler.Count: Integer;
begin
  Result := lFiles.Count;
end;

function TwbLocalizationHandler.Get(Index: Integer): TwbLocalizationFile;
begin
  if Index < Count then
    Result := TwbLocalizationFile(lFiles.Objects[Index])
  else
    Result := nil;
end;

function TwbLocalizationHandler.AddLocalization(const aFileName: string): TwbLocalizationFile;
begin
  Result := TwbLocalizationFile.Create(aFileName);
  lFiles.AddObject(ExtractFileName(aFileName), Result);
end;

function TwbLocalizationHandler.AddLocalization(const aFileName: string; aData: TBytes): TwbLocalizationFile;
begin
  Result := TwbLocalizationFile.Create(aFileName, aData);
  lFiles.AddObject(ExtractFileName(aFileName), Result);
end;

function TwbLocalizationHandler.LocalizedValueDecider(aElement: IwbElement): TwbLocalizationString;
var
  sigElement, sigRecord: TwbSignature;
  aRecord: IwbSubRecord;
begin
  if Supports(aElement, IwbSubRecord, aRecord) then
    sigElement := aRecord.Signature
  else
    sigElement := '';

  sigRecord := aElement.ContainingMainRecord.Signature;

  if (sigRecord <> 'LSCR') and (sigElement = 'DESC') then Result := lsDLString else // DESC always from dlstrings except LSCR
  if (sigRecord = 'QUST') and (sigElement = 'CNAM') then Result := lsDLString else // quest log entry
  if (sigRecord = 'BOOK') and (sigElement = 'CNAM') then Result := lsDLString else // Book CNAM description
  if (sigRecord = 'INFO') and (sigElement <> 'RNAM') then Result := lsILString else // dialog, RNAM are lsString, others lsILString
    Result := lsString; // others
end;

function TwbLocalizationHandler.GetLocalizationFileName(aElement: IwbElement; var aFileName, aFullName: string): boolean;
var
  Extension: String;
begin
  Result := False;

  if not Assigned(aElement) then
    Exit;

  case LocalizedValueDecider(aElement) of
    lsDLString: Extension := 'DLSTRINGS';
    lsILString: Extension := 'ILSTRINGS';
    lsString  : Extension := 'STRINGS';
  end;

  aFileName := aElement._File.FileName;
  aFullName := aElement._File.GetFullFileName;

  aFileName := Format('%s_%s.%s', [
    ChangeFileExt(aFileName, ''),
    wbLanguage,
    Extension
  ]);
  aFullName := ExtractFilePath(aFullName) + 'Strings\' + aFileName;

  Result := True;
end;

function TwbLocalizationHandler.GetValue(ID: Cardinal; aElement: IwbElement): string;
var
  lFileName, lFullName, BSAName: string;
  idx: integer;
  wblf: TwbLocalizationFile;
  res: TDynResources;
  bFailed: boolean;
begin
  Result := '';

  if NoTranslate then begin
    Result := IntToHex(ID, 8);
    Exit;
  end;

  if ID = 0 then
    Exit;

  if not GetLocalizationFileName(aElement, lFileName, lFullName) then
    Exit;

  idx := lFiles.IndexOf(lFileName);
  if idx = -1 then begin
    bFailed := true;
    if Assigned(wbContainerHandler) then begin
      res := wbContainerHandler.OpenResource('Strings\' +  lFileName);
      if length(res) > 0 then begin
        wblf := AddLocalization(lFullName, res[low(res)].GetData);
        bFailed := false;
      end;
    end;
    if bFailed then begin
      Result := '<Error: No localization for lstring ID ' + IntToHex(ID, 8) + '>';
      Exit;
    end;
  end else
    wblf := TwbLocalizationFile(lFiles.Objects[idx]);

  Result := wblf[ID];
end;

initialization
  wbLocalizationHandler := TwbLocalizationHandler.Create;

end.

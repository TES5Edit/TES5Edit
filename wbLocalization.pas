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
    fStream      : TStream;
    fName        : string;
    fFileName    : string;
    fFileType    : TwbLocalizationString;
    fStrings     : TStrings;
    fModified    : boolean;

    function ReadZString: string;
    function ReadLenZString: string;
    procedure ReadDirectory;
  protected
    function Get(Index: Integer): string;
    procedure Put(Index: Integer; const S: string);
  public
    property Strings[Index: Integer]: string read Get write Put; default;
    property Name: string read fName;
    constructor Create(const aFileName: string); overload;
    constructor Create(const aFileName: string; aData: TBytes); overload;
    destructor Destroy; override;
    function Count: Integer;
    function IndexToID(Index: Integer): Integer;
    procedure ExportToFile(const aFileName: string);
  end;

  TwbLocalizationHandler = class
  private
    lFiles: TStrings;
  protected
    function Get(Index: Integer): TwbLocalizationFile;
  public
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
  ext: string;
  fs: TFileStream;
  Buffer: PByte;
begin
  fModified := false;
  fFileName := aFileName;
  fName := ExtractFileName(aFileName);
  ext := ExtractFileExt(aFileName);
  if SameText(ext, '.dlstrings') then fFileType := lsDLString else
  if SameText(ext, '.ilstrings') then fFileType := lsILString else
    fFileType := lsString;
  // cache file in mem
  fStream := TMemoryStream.Create;
  try
    fs := TFileStream.Create(aFileName, fmOpenRead or fmShareDenyNone);
    GetMem(Buffer, fs.Size);
    fs.ReadBuffer(Buffer^, fs.Size);
    fStream.WriteBuffer(Buffer^, fs.Size);
    fStream.Position := 0;
  finally
    FreeMem(Buffer);
    FreeAndNil(fs);
  end;
  fStrings := TwbFastStringList.Create;
  ReadDirectory;
end;

constructor TwbLocalizationFile.Create(const aFileName: string; aData: TBytes);
var
  ext: string;
begin
  fModified := false;
  fFileName := aFileName;
  fName := ExtractFileName(aFileName);
  ext := ExtractFileExt(aFileName);
  if SameText(ext, '.dlstrings') then fFileType := lsDLString else
  if SameText(ext, '.ilstrings') then fFileType := lsILString else
    fFileType := lsString;
  fStream := TMemoryStream.Create;
  try
    fStream.WriteBuffer(aData[0], length(aData));
    fStream.Position := 0;
  finally
  end;
  fStrings := TStringList.Create;
  ReadDirectory;
end;

destructor TwbLocalizationFile.Destroy;
var
  i: Integer;
begin
  FreeAndNil(fStrings);
  inherited;
end;

function TwbLocalizationFile.ReadZString: string;
var
  s: AnsiString;
  c: AnsiChar;
begin
  s := '';
  while fStream.Read(c, 1) = 1 do begin
    if c <> #0 then s := s + c else break;
  end;
  Result := s;
end;

function TwbLocalizationFile.ReadLenZString: string;
var
  s: AnsiString;
  Len: Cardinal;
begin
  fStream.ReadBuffer(Len, 4);
  Dec(Len); // exclude zero
  SetLength(s, Len);
  fStream.ReadBuffer(s[1], Len);
  Result := s;
end;

procedure TwbLocalizationFile.ReadDirectory;
var
  scount, id, offset, i: Cardinal;
  oldPos: int64;
  s: string;
begin
  try
    fStream.Read(scount, 4); // number of strings
    fStream.Position := fStream.Position + 4; // skip dataSize
    for i := 0 to scount - 1 do begin
      fStream.Read(id, 4); // string ID
      fStream.Read(offset, 4); // offset of string relative to data (header + dirsize)
      oldPos := fStream.Position;
      fStream.Position := 8 + scount*8 + offset; // header + dirsize + offset
      if fFileType = lsString then
        s := ReadZString
      else
        s := ReadLenZString;
      fStrings.AddObject(s, pointer(id));
      fStream.Position := oldPos;
    end;
  finally
    FreeAndNil(fStream);
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
      sl.Add(IntToHex(Integer(fStrings.Objects[i]), 8));
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

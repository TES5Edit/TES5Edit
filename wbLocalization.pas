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
// Thanks to zilav18
unit wbLocalization;

interface

uses
  Classes, SysUtils, StrUtils,
  wbInterface;

type
  TwbLocalizationString = (
    lsDLString,
    lsILString,
    lsString
  );

  TwbLocalizationFile = class
  private
    fStream      : TStream;
    fFileName    : string;
    fFileType    : TwbLocalizationString;
    fStrings     : TStringList;

    function ReadZString: string;
    function ReadLenZString: string;
    procedure ReadDirectory;
  protected
  public
    constructor Create(const aFileName: string);
    destructor Destroy; override;
    function ResolveString(ID: Cardinal): string;
  end;

function GetLocalizedValue(ID: Cardinal; aElement: IwbElement): string;

implementation

var
  lFiles: TStringList;

constructor TwbLocalizationFile.Create(const aFileName: string);
var
  ext: string;
  fs: TFileStream;
  Buffer: PByte;
begin
  ext := LowerCase(ExtractFileExt(aFileName));
  if ext = '.dlstrings' then fFileType := lsDLString else
  if ext = '.ilstrings' then fFileType := lsILString else
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
  c: Char;
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

function TwbLocalizationFile.ResolveString(ID: Cardinal): string;
var
  idx: integer;
begin
  Result := '';
  idx := fStrings.IndexOfObject(pointer(ID));
  if idx <> -1 then
    Result := fStrings[idx]
  else
    Result := Format('Unknown lstring ID %08x', [ID]);
end;

function LocalizedValueDecider(aElement: IwbElement): TwbLocalizationString;
var
  sigEl, sigRec: TwbSignature;
  aRecord: IwbSubRecord;
begin
  if Supports(aElement, IwbSubRecord, aRecord) then
    sigRec := aRecord.Signature
  else
    sigRec := '';
  sigEl := aElement.ContainingMainRecord.Signature;

  if sigRec = 'DESC' then Result := lsDLString else // DESC always from dlstrings
  if (sigEl = 'QUST') or (sigEl = 'BOOK') then Result := lsDLString else //journal/book
  if sigEl = 'DIAL' then Result := lsILString else // dialog
    Result := lsString; // others
end;

function GetLocalizedValue(ID: Cardinal; aElement: IwbElement): string;
var
  lFileName, lFullName, Extension: string;
  idx: integer;
  wblf: TwbLocalizationFile;
begin
  Result := '';
  if ID = 0 then Exit;

  if not Assigned(lFiles) then lFiles := TStringList.Create;

  case LocalizedValueDecider(aElement) of
    lsDLString: Extension := 'DLSTRINGS';
    lsILString: Extension := 'ILSTRINGS';
    lsString  : Extension := 'STRINGS';
  end;

  lFileName := aElement._File.FileName;
  lFullName := aElement._File.GetFullFileName;

  lFullName := Format('%sStrings\%s_%s.%s', [
    ExtractFilePath(lFullName),
    ChangeFileExt(lFileName, ''),
    'English',
    Extension
  ]);

  idx := lFiles.IndexOf(lFullName);
  if idx = -1 then begin
    if not FileExists(lFullName) then begin
      Result := Format('No localization for lstring ID %08x', [ID]);
      Exit;
    end;
    wblf := TwbLocalizationFile.Create(lFullName);
    lFiles.AddObject(lFullName, wblf);
  end else
    wblf := TwbLocalizationFile(lFiles.Objects[idx]);

  Result := wblf.ResolveString(ID);
end;

end.

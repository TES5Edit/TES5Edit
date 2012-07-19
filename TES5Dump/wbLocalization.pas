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
    fStream      : TFileStream;
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
begin
  ext := LowerCase(ExtractFileExt(aFileName));
  if ext = '.dlstrings' then fFileType := lsDLString else
  if ext = '.ilstrings' then fFileType := lsILString else
    fFileType := lsString;
  fStream := TFileStream.Create(aFileName, fmOpenRead);
  fStrings := TStringList.Create;
  ReadDirectory;
end;

destructor TwbLocalizationFile.Destroy;
var
  i: Integer;
begin
  FreeAndNil(fStream);
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
  Len: Cardinal;
begin
  fStream.ReadBuffer(Len, 4);
  Dec(Len); // exclude zero
  SetLength(Result, Len);
  fStream.ReadBuffer(Result[1], Len);
end;

procedure TwbLocalizationFile.ReadDirectory;
var
  scount, id, offset, i: Cardinal;
  oldPos: int64;
  s: string;
begin
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
end;

function TwbLocalizationFile.ResolveString(ID: Cardinal): string;
var
  idx: integer;
begin
  Result := '';
  idx := fStrings.IndexOfObject(pointer(ID));
  if idx <> -1 then Result := fStrings[idx];
end;

function GetLocalizedValue(ID: Cardinal; aElement: IwbElement): string;
var
  lfile, ext: string;
  sig: TwbSignature;
  idx: integer;
  wblf: TwbLocalizationFile;
begin
  Result := '';
  lfile := aElement._File.GetFullFileName;
  sig := aElement.ContainingMainRecord.Signature;
  if (sig = 'QUST') or (sig = 'BOOK') then ext := '.DLSTRINGS' else //journal/book
  if sig = 'DIAL' then ext := '.ILSTRINGS' else // dialog
    ext := '.STRINGS'; // others
  lfile := Format('%sStrings\%s_%s%s', [
    ExtractFilePath(lfile),
    ChangeFileExt(ExtractFileName(lfile), ''),
    'English',
    ext
  ]);

  if not Assigned(lFiles) then lFiles := TStringList.Create;
  idx := lFiles.IndexOf(lfile);
  if idx = -1 then begin
    if not FileExists(lfile) then begin
      Result := Format('lstring ID %d', [ID]);
      Exit;
    end;
    wblf := TwbLocalizationFile.Create(lfile);
    lFiles.AddObject(lfile, wblf);
  end else
    wblf := TwbLocalizationFile(lFiles.Objects[idx]);

  Result := wblf.ResolveString(ID);
end;

end.

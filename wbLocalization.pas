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
    fFileName    : string;
    fFileType    : TwbLocalizationString;
    fStrings     : TStringList;

    function ReadZString: string;
    function ReadLenZString: string;
    procedure ReadDirectory;
  protected
  public
    constructor Create(const aFileName: string); overload;
    constructor Create(const aFileName: string; aData: TBytes); overload;
    destructor Destroy; override;
    function ResolveString(ID: Cardinal): string;
  end;

function GetLocalizedValue(ID: Cardinal; aElement: IwbElement): string;

implementation

var
  lFiles: TStringList;
  ContainerHandler: IwbContainerHandler;

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

constructor TwbLocalizationFile.Create(const aFileName: string; aData: TBytes);
var
  ext: string;
begin
  ext := LowerCase(ExtractFileExt(aFileName));
  if ext = '.dlstrings' then fFileType := lsDLString else
  if ext = '.ilstrings' then fFileType := lsILString else
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

function TwbLocalizationFile.ResolveString(ID: Cardinal): string;
var
  idx: integer;
begin
  Result := '';
  idx := fStrings.IndexOfObject(pointer(ID));
  if idx <> -1 then
    Result := fStrings[idx]
  else
    Result := '<Error: Unknown lstring ID ' + IntToHex(ID, 8) + '>';
end;

function LocalizedValueDecider(aElement: IwbElement): TwbLocalizationString;
var
  sigElem, sigRec: TwbSignature;
  aRecord: IwbSubRecord;
begin
  if Supports(aElement, IwbSubRecord, aRecord) then
    sigElem := aRecord.Signature
  else
    sigElem := '';
  sigRec := aElement.ContainingMainRecord.Signature;

  if sigElem = 'DESC' then Result := lsDLString else // DESC always from dlstrings
  if (sigRec = 'QUST') and (sigElem = 'CNAM') then Result := lsDLString else // quest log entry
  if (sigRec = 'INFO') and (sigElem <> 'RNAM') then Result := lsILString else // dialog, RNAM are lsString, others lsILString
    Result := lsString; // others
end;

function GetLocalizedValue(ID: Cardinal; aElement: IwbElement): string;
var
  lFileName, lFullName, Extension, BSAName: string;
  idx: integer;
  wblf: TwbLocalizationFile;
  res: TDynResources;
  bFailed: boolean;
begin
  Result := '';
  if ID = 0 then Exit;

  if not Assigned(lFiles) then
    lFiles := TStringList.Create;

  case LocalizedValueDecider(aElement) of
    lsDLString: Extension := 'DLSTRINGS';
    lsILString: Extension := 'ILSTRINGS';
    lsString  : Extension := 'STRINGS';
  end;

  lFileName := aElement._File.FileName;
  lFullName := aElement._File.GetFullFileName;

  lFileName := Format('%s_%s.%s', [
    ChangeFileExt(lFileName, ''),
    wbLanguage,
    Extension
  ]);
  lFullName := ExtractFilePath(lFullName) + 'Strings\' +  lFileName;

  idx := lFiles.IndexOf(lFileName);
  if idx = -1 then begin
    bFailed := false;
    // checking for file on disk
    {>>>
      better to use ContainerHandler for this, but...
      it'll require to add TwbFolder for 'Strings\'
      and there is no way to check if it is already been added without
      modifications to wbBSA and wbInterface, which I tried to avoid
    <<<}
    if FileExists(lFullName) then begin
      wblf := TwbLocalizationFile.Create(lFullName);
      lFiles.AddObject(lFileName, wblf);
    end else
    // checking for file in bsa
    begin
      {>>>
        ok this will load only 1 bsa file, hack is a hack
        real TES5Edit probably has its own ContainerHandler with added bsas
      <<<}
      if not Assigned(ContainerHandler) then begin
        ContainerHandler := wbCreateContainerHandler;
        BSAName := ChangeFileExt(aElement._File.GetFullFileName, '.bsa');
        if FileExists(BSAName) then
          ContainerHandler.AddBSA(BSAName);
      end;
      res := ContainerHandler.OpenResource('Strings\' +  lFileName);
      if length(res) > 0 then begin
        wblf := TwbLocalizationFile.Create(lFullName, res[low(res)].GetData);
        lFiles.AddObject(lFileName, wblf);
      end else
        bFailed := true;
    end;
    if bFailed then begin
      Result := '<Error: No localization for lstring ID ' + IntToHex(ID, 8) +'>';
      Exit;
    end;
  end else
    wblf := TwbLocalizationFile(lFiles.Objects[idx]);

  Result := wblf.ResolveString(ID);
end;

end.

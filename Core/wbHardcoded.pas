{******************************************************************************

  This Source Code Form is subject to the terms of the Mozilla Public License, 
  v. 2.0. If a copy of the MPL was not distributed with this file, You can obtain 
  one at https://mozilla.org/MPL/2.0/.

*******************************************************************************}

unit wbHardcoded;

interface

uses
  System.SysUtils, System.Classes, FileContainer;

type
  TwbHardcodedContainer = class(TDataModule)
    fcMorrowind: TFileContainer;
    fcOblivion: TFileContainer;
    fcSkyrim: TFileContainer;
    fcEnderal: TFileContainer; // This is the same as Skyrim
    fcFallout3: TFileContainer;
    fcFalloutNV: TFileContainer;
    fcFallout4: TFileContainer;
    fcFallout76: TFileContainer;
  public
    class function GetHardCodedDat: TBytes;
  end;

implementation

uses
  wbInterface;

{$R *.dfm}

{ TwbHardcodedContainer }

class function TwbHardcodedContainer.GetHardCodedDat: TBytes;
var
  s             : string;
  FileContainer : TFileContainer;
begin
  Result := nil;
  with Create(nil) do try
    s := wbProgramPath + wbGameName + '.Hardcoded.Override.dat';
    if FileExists(s) then
      with TBytesStream.Create do try
        LoadFromFile(s);
        Result := Copy(Bytes);
        SetLength(Result, Size);
        Exit;
      finally
        Free;
      end;
    FileContainer := FindComponent('fc' + wbGameName) as TFileContainer;
    if Assigned(FileContainer) then
      Result := FileContainer.Data;
  finally
    Free;
  end;
end;

end.

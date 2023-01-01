{******************************************************************************

  This Source Code Form is subject to the terms of the Mozilla Public License,
  v. 2.0. If a copy of the MPL was not distributed with this file, You can obtain
  one at https://mozilla.org/MPL/2.0/.

*******************************************************************************}

unit ProcTriangulate;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes,
  Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, SniffProcessor,
  Vcl.StdCtrls;

type
  TFrameTriangulate = class(TFrame)
    StaticText1: TStaticText;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

  TProcTriangulate = class(TProcBase)
  private
    Frame: TFrameTriangulate;
  public
    constructor Create(aManager: TProcManager); override;
    function GetFrame(aOwner: TComponent): TFrame; override;

    function ProcessFile(const aInputDirectory, aOutputDirectory: string; var aFileName: string): TBytes; override;
  end;


implementation

{$R *.dfm}

uses
  wbDataFormat,
  wbDataFormatNif;

constructor TProcTriangulate.Create(aManager: TProcManager);
begin
  inherited;

  fTitle := 'Convert strips to shapes';
  fSupportedGames := [gtTES4, gtFO3, gtFNV, gtTES5];
  fExtensions := ['nif'];
end;

function TProcTriangulate.GetFrame(aOwner: TComponent): TFrame;
begin
  Frame := TFrameTriangulate.Create(aOwner);
  Result := Frame;
end;

function TProcTriangulate.ProcessFile(const aInputDirectory, aOutputDirectory: string; var aFileName: string): TBytes;
var
  nif: TwbNifFile;
begin
  nif := TwbNifFile.Create;
  try
    nif.LoadFromFile(aInputDirectory + aFileName);

    if nif.SpellTriangulate then
      nif.SaveToData(Result);
  finally
    nif.Free;
  end;

end;


end.

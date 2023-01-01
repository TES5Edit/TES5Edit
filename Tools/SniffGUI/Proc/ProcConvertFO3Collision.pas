{******************************************************************************

  This Source Code Form is subject to the terms of the Mozilla Public License,
  v. 2.0. If a copy of the MPL was not distributed with this file, You can obtain
  one at https://mozilla.org/MPL/2.0/.

*******************************************************************************}

unit ProcConvertFO3Collision;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes,
  Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, SniffProcessor,
  Vcl.StdCtrls;

type
  TFrameConvertFO3Collision = class(TFrame)
    StaticText1: TStaticText;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

  TProcConvertFO3Collision = class(TProcBase)
  private
    Frame: TFrameConvertFO3Collision;
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

constructor TProcConvertFO3Collision.Create(aManager: TProcManager);
begin
  inherited;

  fTitle := 'Convert FO3 collision';
  fSupportedGames := [gtFO3];
  fExtensions := ['nif'];
end;

function TProcConvertFO3Collision.GetFrame(aOwner: TComponent): TFrame;
begin
  Frame := TFrameConvertFO3Collision.Create(aOwner);
  Result := Frame;
end;

function TProcConvertFO3Collision.ProcessFile(const aInputDirectory, aOutputDirectory: string; var aFileName: string): TBytes;
var
  nif: TwbNifFile;
  Block: TwbNifBlock;
  bChanged: Boolean;
  i: Integer;
begin
  nif := TwbNifFile.Create;
  nif.Options := [nfoCollapseLinkArrays];
  bChanged := False;

  try
    nif.LoadFromFile(aInputDirectory + aFileName);

    for i := 0 to Pred(nif.BlocksCount) do begin
      block := nif.Blocks[i];

      if block.BlockType <> 'bhkConvexListShape' then
        Continue;

      nif.ConvertBlock(i, 'bhkListShape');
      block := nif.Blocks[i];
      block.Elements['Unknown Ints'].Count := 2;

      bChanged := True;
    end;

    if bChanged then
      nif.SaveToData(Result);

  finally
    nif.Free;
  end;
end;



end.

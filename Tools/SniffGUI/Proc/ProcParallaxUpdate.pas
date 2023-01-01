{******************************************************************************

  This Source Code Form is subject to the terms of the Mozilla Public License,
  v. 2.0. If a copy of the MPL was not distributed with this file, You can obtain
  one at https://mozilla.org/MPL/2.0/.

*******************************************************************************}

unit ProcParallaxUpdate;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes,
  Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, SniffProcessor,
  Vcl.StdCtrls, Vcl.ExtCtrls;

type
  TFrameParallaxUpdate = class(TFrame)
    StaticText1: TStaticText;
    edMaxPasses: TLabeledEdit;
    edScale: TLabeledEdit;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

  TProcParallaxUpdate = class(TProcBase)
  private
    Frame: TFrameParallaxUpdate;
    fMaxPasses: string;
    fScale: string;
  public
    constructor Create(aManager: TProcManager); override;
    function GetFrame(aOwner: TComponent): TFrame; override;
    procedure OnShow; override;
    procedure OnHide; override;
    procedure OnStart; override;

    function ProcessFile(const aInputDirectory, aOutputDirectory: string; var aFileName: string): TBytes; override;
  end;

implementation

{$R *.dfm}

uses
  wbDataFormat,
  wbDataFormatNif;

constructor TProcParallaxUpdate.Create(aManager: TProcManager);
begin
  inherited;

  fTitle := 'Update parallax settings';
  fSupportedGames := [gtFO3, gtFNV];
  fExtensions := ['nif'];
end;

function TProcParallaxUpdate.GetFrame(aOwner: TComponent): TFrame;
begin
  Frame := TFrameParallaxUpdate.Create(aOwner);
  Result := Frame;
end;

procedure TProcParallaxUpdate.OnShow;
begin
  Frame.edMaxPasses.Text := StorageGetString('sMaxPasses', Frame.edMaxPasses.Text);
  Frame.edScale.Text := StorageGetString('sScale', Frame.edScale.Text);
end;

procedure TProcParallaxUpdate.OnHide;
begin
  StorageSetString('sMaxPasses', Frame.edMaxPasses.Text);
  StorageSetString('sScale', Frame.edScale.Text);
end;

procedure TProcParallaxUpdate.OnStart;
begin
  fMaxPasses := Frame.edMaxPasses.Text;
  fScale := Frame.edScale.Text;

  try
    fMaxPasses := dfFloatToStr(StrToFloat(fMaxPasses));
  except
    raise Exception.Create('Parallax max passes is not a float value');
  end;

  try
    fScale := dfFloatToStr(StrToFloat(fScale));
  except
    raise Exception.Create('Parallax max passes is not a float value');
  end;
end;

function TProcParallaxUpdate.ProcessFile(const aInputDirectory, aOutputDirectory: string; var aFileName: string): TBytes;
var
  nif: TwbNifFile;
  i: Integer;
  shader: TwbNifBlock;
  elMaxPasses, elScale: TdfElement;
  bChanged: Boolean;
begin
  bChanged := False;
  nif := TwbNifFile.Create;
  try
    nif.LoadFromFile(aInputDirectory + aFileName);

    for i := 0 to Pred(nif.BlocksCount) do begin
      shader := nif.Blocks[i];

      if shader.BlockType <> 'BSShaderPPLightingProperty' then
        Continue;

      elMaxPasses := shader.Elements['Parallax Max Passes'];
      elScale := shader.Elements['Parallax Scale'];

      if not Assigned(elMaxPasses) or not Assigned(elScale) then
        Continue;

      if elMaxPasses.EditValue <> fMaxPasses then begin
        elMaxPasses.EditValue := fMaxPasses;
        bChanged := True;
      end;

      if elScale.EditValue <> fScale then begin
        elScale.EditValue := fScale;
        bChanged := True;
      end;

    end;

    if bChanged then
      nif.SaveToData(Result);

  finally
    nif.Free;
  end;

end;




end.

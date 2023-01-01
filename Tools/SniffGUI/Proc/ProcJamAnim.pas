{******************************************************************************

  This Source Code Form is subject to the terms of the Mozilla Public License,
  v. 2.0. If a copy of the MPL was not distributed with this file, You can obtain
  one at https://mozilla.org/MPL/2.0/.

*******************************************************************************}

unit ProcJamAnim;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes,
  Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, SniffProcessor,
  Vcl.StdCtrls;

type
  TFrameJamAnim = class(TFrame)
    StaticText1: TStaticText;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

  TProcJamAnim = class(TProcBase)
  private
    Frame: TFrameJamAnim;
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

constructor TProcJamAnim.Create(aManager: TProcManager);
begin
  inherited;

  fTitle := 'Jamilla''s anim thing';
  fSupportedGames := [gtTES4, gtFO3, gtFNV];
  fExtensions := ['kf'];
end;

function TProcJamAnim.GetFrame(aOwner: TComponent): TFrame;
begin
  Frame := TFrameJamAnim.Create(aOwner);
  Result := Frame;
end;

function TProcJamAnim.ProcessFile(const aInputDirectory, aOutputDirectory: string; var aFileName: string): TBytes;
var
  nif: TwbNifFile;
  i: integer;
  interpolator, transfdata: TwbNifBlock;
  qkey: TdfElement;
  bChanged: Boolean;
begin
  bChanged := False;
  nif := TwbNifFile.Create;
  try
    nif.LoadFromFile(aInputDirectory + aFileName);

    for i := 0 to Pred(nif.BlocksCount) do begin
      interpolator := nif.Blocks[i];

      if interpolator.BlockType <> 'NiTransformInterpolator' then
        Continue;

      if interpolator.NativeValues['Data'] >= 0 then
        Continue;

      transfdata := nif.AddBlock('NiTransformData');
      interpolator.NativeValues['Data'] := transfdata.Index;

      transfdata.NativeValues['Num Rotation Keys'] := 2;
      transfdata.EditValues['Rotation Type'] := 'LINEAR_KEY';

      qkey := transfdata.Elements['Quaternion Keys'].Add;
      qkey.EditValues['Value'] := interpolator.EditValues['Transform\Rotation'];

      qkey := transfdata.Elements['Quaternion Keys'].Add;
      qkey.NativeValues['Time'] := nif.Blocks[0].NativeValues['Stop Time'];
      qkey.EditValues['Value'] := interpolator.EditValues['Transform\Rotation'];

      bChanged := True;
    end;

    if bChanged then
      nif.SaveToData(Result);

  finally
    nif.Free;
  end;

end;

end.

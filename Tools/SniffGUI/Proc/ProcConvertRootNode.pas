{******************************************************************************

  This Source Code Form is subject to the terms of the Mozilla Public License,
  v. 2.0. If a copy of the MPL was not distributed with this file, You can obtain
  one at https://mozilla.org/MPL/2.0/.

*******************************************************************************}

unit ProcConvertRootNode;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes,
  Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, SniffProcessor,
  Vcl.StdCtrls;

type
  TFrameConvertRootNode = class(TFrame)
    StaticText1: TStaticText;
    cmbNodeFrom: TComboBox;
    Label1: TLabel;
    Label2: TLabel;
    cmbNodeTo: TComboBox;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

  TProcConvertRootNode = class(TProcBase)
  private
    Frame: TFrameConvertRootNode;
    fNodeFrom: string;
    fNodeTo: string;
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

constructor TProcConvertRootNode.Create(aManager: TProcManager);
begin
  inherited;

  fTitle := 'Convert root node';
  fSupportedGames := [gtTES3, gtTES4, gtFO3, gtFNV, gtTES5, gtSSE, gtFO4];
  fExtensions := ['nif'];
end;

function TProcConvertRootNode.GetFrame(aOwner: TComponent): TFrame;
begin
  Frame := TFrameConvertRootNode.Create(aOwner);
  Result := Frame;
end;

procedure TProcConvertRootNode.OnShow;
const
  sNodes: array [0..2] of string = ('NiNode', 'BSFadeNode', 'BSLeafAnimNode');
var
  i: Integer;
begin
  for var s: string in sNodes do
    Frame.cmbNodeFrom.Items.Add(s);

  Frame.cmbNodeTo.Items.Assign(Frame.cmbNodeFrom.Items);

  i := Frame.cmbNodeFrom.Items.IndexOf(StorageGetString('sNodeFrom', Frame.cmbNodeFrom.Text));
  if i = -1 then i := 0;
  Frame.cmbNodeFrom.ItemIndex := i;

  i := Frame.cmbNodeTo.Items.IndexOf(StorageGetString('sNodeTo', Frame.cmbNodeTo.Text));
  if i = -1 then i := 1;
  Frame.cmbNodeTo.ItemIndex := i;
end;

procedure TProcConvertRootNode.OnHide;
begin
  StorageSetString('sNodeFrom', Frame.cmbNodeFrom.Text);
  StorageSetString('sNodeTo', Frame.cmbNodeTo.Text);
end;

procedure TProcConvertRootNode.OnStart;
begin
  fNodeFrom := Frame.cmbNodeFrom.Text;
  fNodeTo := Frame.cmbNodeTo.Text;

  if fNodeFrom = fNodeTo then
    raise Exception.Create('From and To node types must be different');
end;

function TProcConvertRootNode.ProcessFile(const aInputDirectory, aOutputDirectory: string; var aFileName: string): TBytes;
var
  nif: TwbNifFile;
  bChanged: Boolean;
begin
  bChanged := False;
  nif := TwbNifFile.Create;
  try
    nif.LoadFromFile(aInputDirectory + aFileName);

    if nif.BlocksCount = 0 then
      Exit;

    if nif.Blocks[0].BlockType = fNodeFrom then begin
      nif.ConvertBlock(0, fNodeTo);
      bChanged := True;
    end;

    if bChanged then
      nif.SaveToData(Result);

  finally
    nif.Free;
  end;

end;


end.

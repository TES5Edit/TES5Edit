{******************************************************************************

  This Source Code Form is subject to the terms of the Mozilla Public License,
  v. 2.0. If a copy of the MPL was not distributed with this file, You can obtain
  one at https://mozilla.org/MPL/2.0/.

*******************************************************************************}

unit ProcTangents;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes,
  Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, SniffProcessor,
  Vcl.StdCtrls;

type
  TFrameTangents = class(TFrame)
    chkNormals: TCheckBox;
    StaticText1: TStaticText;
    StaticText2: TStaticText;
    chkAddIfMissing: TCheckBox;
    StaticText3: TStaticText;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

  TProcTangents = class(TProcBase)
  private
    Frame: TFrameTangents;
    fAddIfMissing: Boolean;
    fFaceNormals: Boolean;
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

constructor TProcTangents.Create(aManager: TProcManager);
begin
  inherited;

  fTitle := 'Update tangents and binormals';
  fSupportedGames := [gtTES4, gtFO3, gtFNV, gtTES5, gtSSE, gtFO4];
  fExtensions := ['nif'];
end;

function TProcTangents.GetFrame(aOwner: TComponent): TFrame;
begin
  Frame := TFrameTangents.Create(aOwner);
  Result := Frame;
end;

procedure TProcTangents.OnShow;
begin
  Frame.chkAddIfMissing.Checked := StorageGetBool('bAddIfMissing', Frame.chkAddIfMissing.Checked);
  Frame.chkNormals.Checked := StorageGetBool('bFaceNormals', Frame.chkNormals.Checked);
end;

procedure TProcTangents.OnHide;
begin
  StorageSetBool('bAddIfMissing', Frame.chkAddIfMissing.Checked);
  StorageSetBool('bFaceNormals', Frame.chkNormals.Checked);
end;

procedure TProcTangents.OnStart;
begin
  fAddIfMissing := Frame.chkAddIfMissing.Checked;
  fFaceNormals := Frame.chkNormals.Checked;
end;

function TProcTangents.ProcessFile(const aInputDirectory, aOutputDirectory: string; var aFileName: string): TBytes;
var
  nif: TwbNifFile;
  bChanged: Boolean;
begin
  bChanged := False;
  nif := TwbNifFile.Create;
  try
    nif.LoadFromFile(aInputDirectory + aFileName);

    if fFaceNormals then
      bChanged := nif.SpellFaceNormals;

    // "or" bChanged afterwards to not short circuit (not calling tangents code) if it is already True from facing normals
    if fAddIfMissing then
      bChanged := nif.SpellAddUpdateTangents or bChanged
    else
      bChanged := nif.SpellUpdateTangents or bChanged;

    if bChanged then
      nif.SaveToData(Result);
  finally
    nif.Free;
  end;

end;

end.

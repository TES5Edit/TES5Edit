{******************************************************************************

  This Source Code Form is subject to the terms of the Mozilla Public License,
  v. 2.0. If a copy of the MPL was not distributed with this file, You can obtain
  one at https://mozilla.org/MPL/2.0/.

*******************************************************************************}

unit ProcRenameControlledBlocks;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes,
  Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, SniffProcessor,
  Vcl.StdCtrls, Vcl.ExtCtrls;

type
  TFrameRenameControlledBlocks = class(TFrame)
    StaticText1: TStaticText;
    edOldName: TLabeledEdit;
    edNewName: TLabeledEdit;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

  TProcRenameControlledBlocks = class(TProcBase)
  private
    Frame: TFrameRenameControlledBlocks;
    fOldName: string;
    fNewName: string;
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

constructor TProcRenameControlledBlocks.Create(aManager: TProcManager);
begin
  inherited;

  fTitle := 'Rename controlled blocks';
  fSupportedGames := [gtTES4, gtFO3, gtFNV];
  fExtensions := ['kf'];
end;

function TProcRenameControlledBlocks.GetFrame(aOwner: TComponent): TFrame;
begin
  Frame := TFrameRenameControlledBlocks.Create(aOwner);
  Result := Frame;
end;

procedure TProcRenameControlledBlocks.OnShow;
begin
  Frame.edOldName.Text := StorageGetString('sOldName', Frame.edOldName.Text);
  Frame.edNewName.Text := StorageGetString('sNewName', Frame.edNewName.Text);
end;

procedure TProcRenameControlledBlocks.OnHide;
begin
  StorageSetString('sOldName', Frame.edOldName.Text);
  StorageSetString('sNewName', Frame.edNewName.Text);
end;

procedure TProcRenameControlledBlocks.OnStart;
begin
  fOldName := Frame.edOldName.Text;
  fNewName := Frame.edNewName.Text;

  if fOldName = '' then
    raise Exception.Create('Old name can not be empty');

  if fNewName = '' then
    raise Exception.Create('New name can not be empty');
end;

function TProcRenameControlledBlocks.ProcessFile(const aInputDirectory, aOutputDirectory: string; var aFileName: string): TBytes;
var
  nif: TwbNifFile;
  entries, entry: TdfElement;
  i: Integer;
  bChanged: Boolean;
begin
  bChanged := False;
  nif := TwbNifFile.Create;
  try
    nif.LoadFromFile(aInputDirectory + aFileName);

    if nif.BlocksCount = 0 then
      Exit;

    entries := nif.Blocks[0].Elements['Controlled Blocks'];

    if not Assigned(entries)then
      Exit;

    for i := 0 to Pred(entries.Count) do begin
      entry := entries[i];

      if SameText(entry.EditValues['Node Name'], fOldName) then begin
        entry.EditValues['Node Name'] := fNewName;
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

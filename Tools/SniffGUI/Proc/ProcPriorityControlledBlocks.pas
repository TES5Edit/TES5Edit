{******************************************************************************

  This Source Code Form is subject to the terms of the Mozilla Public License,
  v. 2.0. If a copy of the MPL was not distributed with this file, You can obtain
  one at https://mozilla.org/MPL/2.0/.

*******************************************************************************}

unit ProcPriorityControlledBlocks;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes,
  Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, SniffProcessor,
  Vcl.StdCtrls, Vcl.ExtCtrls;

type
  TFramePriorityControlledBlocks = class(TFrame)
    StaticText1: TStaticText;
    edNames: TLabeledEdit;
    edPriorityMatched: TLabeledEdit;
    edPriorityNotMatched: TLabeledEdit;
    chkExactMatch: TCheckBox;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

  TProcPriorityControlledBlocks = class(TProcBase)
  private
    Frame: TFramePriorityControlledBlocks;
    fNames: array of string;
    fExactMatch: Boolean;
    fPriorityMatched: string;
    fPriorityNotMatched: string;
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
  StrUtils,
  wbDataFormat,
  wbDataFormatNif;

constructor TProcPriorityControlledBlocks.Create(aManager: TProcManager);
begin
  inherited;

  fTitle := 'Update priority of controlled blocks';
  fSupportedGames := [gtTES4, gtFO3, gtFNV];
  fExtensions := ['kf'];
end;

function TProcPriorityControlledBlocks.GetFrame(aOwner: TComponent): TFrame;
begin
  Frame := TFramePriorityControlledBlocks.Create(aOwner);
  Result := Frame;
end;

procedure TProcPriorityControlledBlocks.OnShow;
begin
  Frame.edNames.Text := StorageGetString('sNames', Frame.edNames.Text);
  Frame.chkExactMatch.Checked := StorageGetBool('bExactMatch', Frame.chkExactMatch.Checked);
  Frame.edPriorityMatched.Text := StorageGetString('sPriorityMatched', Frame.edPriorityMatched.Text);
  Frame.edPriorityNotMatched.Text := StorageGetString('sPriorityNotMatched', Frame.edPriorityNotMatched.Text);
end;

procedure TProcPriorityControlledBlocks.OnHide;
begin
  StorageSetString('sNames', Frame.edNames.Text);
  StorageSetBool('bExactMatch', Frame.chkExactMatch.Checked);
  StorageSetString('sPriorityMatched', Frame.edPriorityMatched.Text);
  StorageSetString('sPriorityNotMatched', Frame.edPriorityNotMatched.Text);
end;

procedure TProcPriorityControlledBlocks.OnStart;
begin
  with TStringList.Create do try
    Delimiter := ',';
    StrictDelimiter := True;
    DelimitedText := Frame.edNames.Text;
    SetLength(fNames, Count);
    for var i: Integer := 0 to Pred(Count) do
      fNames[i] := Trim(Strings[i]);
  finally
    Free;
  end;

  if Length(fNames) = 0 then
    raise Exception.Create('Names field can not be empty');

  fExactMatch := Frame.chkExactMatch.Checked;

  fPriorityMatched := Trim(Frame.edPriorityMatched.Text);
  fPriorityNotMatched := Trim(Frame.edPriorityNotMatched.Text);

  if (fPriorityMatched = '') and (fPriorityNotMatched = '') then
    raise Exception.Create('Both priorities can not be empty');

  if (fPriorityMatched <> '') and (StrToIntDef(fPriorityMatched, -1) < 0) then
    raise Exception.Create('Matched priority value is invalid');

  if (fPriorityNotMatched <> '') and (StrToIntDef(fPriorityNotMatched, -1) < 0) then
    raise Exception.Create('Not matched priority value is invalid');
end;

function TProcPriorityControlledBlocks.ProcessFile(const aInputDirectory, aOutputDirectory: string; var aFileName: string): TBytes;
var
  nif: TwbNifFile;
  entries, entry: TdfElement;
  name: string;
  bMatched, bChanged: Boolean;
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

    for var i: Integer := Pred(entries.Count) downto 0 do begin
      entry := entries[i];

      bMatched := False;
      name := entry.EditValues['Node Name'];
      for var s: String in fNames do
        if ( fExactMatch and SameText(name, s) ) or ( not fExactMatch and ContainsText(name, s) ) then
          bMatched := True;

      if bMatched and (fPriorityMatched <> '') then begin
        entry.EditValues['Priority'] := fPriorityMatched;
        bChanged := True;
      end;

      if not bMatched and (fPriorityNotMatched <> '') then begin
        entry.EditValues['Priority'] := fPriorityNotMatched;
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

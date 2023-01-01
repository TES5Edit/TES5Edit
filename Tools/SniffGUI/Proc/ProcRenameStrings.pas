{******************************************************************************

  This Source Code Form is subject to the terms of the Mozilla Public License,
  v. 2.0. If a copy of the MPL was not distributed with this file, You can obtain
  one at https://mozilla.org/MPL/2.0/.

*******************************************************************************}

unit ProcRenameStrings;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes,
  Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, SniffProcessor,
  Vcl.StdCtrls, Vcl.ExtCtrls;

type
  TFrameRenameStrings = class(TFrame)
    StaticText1: TStaticText;
    edSearchText: TLabeledEdit;
    edReplaceText: TLabeledEdit;
    chkExactMatch: TCheckBox;
    chkTrim: TCheckBox;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

  TProcRenameStrings = class(TProcBase)
  private
    Frame: TFrameRenameStrings;
    fSearch: string;
    fReplace: string;
    fExactMatch: Boolean;
    fTrim: Boolean;
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

constructor TProcRenameStrings.Create(aManager: TProcManager);
begin
  inherited;

  fTitle := 'Rename strings';
  fSupportedGames := [gtFO3, gtFNV, gtTES5, gtSSE, gtFO4];
  fExtensions := ['nif', 'kf'];
end;

function TProcRenameStrings.GetFrame(aOwner: TComponent): TFrame;
begin
  Frame := TFrameRenameStrings.Create(aOwner);
  Result := Frame;
end;

procedure TProcRenameStrings.OnShow;
begin
  Frame.edSearchText.Text := StorageGetString('sSearch', Frame.edSearchText.Text);
  Frame.edReplaceText.Text := StorageGetString('sReplace', Frame.edReplaceText.Text);
  Frame.chkExactMatch.Checked := StorageGetBool('bFullMatch', Frame.chkExactMatch.Checked);
  Frame.chkTrim.Checked := StorageGetBool('bTrim', Frame.chkTrim.Checked);
end;

procedure TProcRenameStrings.OnHide;
begin
  StorageSetString('sSearch', Frame.edSearchText.Text);
  StorageSetString('sReplace', Frame.edReplaceText.Text);
  StorageSetBool('bFullMatch', Frame.chkExactMatch.Checked);
  StorageSetBool('bTrim', Frame.chkTrim.Checked);
end;

procedure TProcRenameStrings.OnStart;
begin
  fSearch := Frame.edSearchText.Text;
  fReplace := Frame.edReplaceText.Text;
  fExactMatch := Frame.chkExactMatch.Checked;
  fTrim := Frame.chkTrim.Checked;

  if fSearch = '' then
    raise Exception.Create('Search text can not be empty');

  if fSearch = fReplace then
    raise Exception.Create('Search and replacement texts are the same');
end;

function TProcRenameStrings.ProcessFile(const aInputDirectory, aOutputDirectory: string; var aFileName: string): TBytes;
var
  nif: TwbNifFile;
  entries, entry: TdfElement;
  s1, s2: string;
  i: Integer;
  bChanged: Boolean;
begin
  bChanged := False;
  nif := TwbNifFile.Create;
  try
    nif.LoadFromFile(aInputDirectory + aFileName);

    entries := nif.Header.Elements['Strings'];

    if not Assigned(entries)then
      Exit;

    for i := 0 to Pred(entries.Count) do begin
      entry := entries[i];
      s1 := entry.EditValue;

      if fExactMatch then begin

        if SameText(s1, fSearch) then
          s2 := fReplace
        else
          s2 := s1;

      end else
        s2 := StringReplace(s1, fSearch, fReplace, [rfReplaceAll, rfIgnoreCase]);

      if fTrim then
        s2 := Trim(s2);

      if s1 <> s2 then begin
        entry.EditValue := s2;
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

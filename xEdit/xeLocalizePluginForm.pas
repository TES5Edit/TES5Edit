{******************************************************************************

  This Source Code Form is subject to the terms of the Mozilla Public License, 
  v. 2.0. If a copy of the MPL was not distributed with this file, You can obtain 
  one at https://mozilla.org/MPL/2.0/.

*******************************************************************************}

unit xeLocalizePluginForm;

{$I xeDefines.inc}

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, CheckLst;

type
  TfrmLocalizePlugin = class(TForm)
    gbTranslation: TGroupBox;
    cbTranslation: TCheckBox;
    Label1: TLabel;
    clbFrom: TCheckListBox;
    Label2: TLabel;
    Label3: TLabel;
    clbTo: TCheckListBox;
    btnOK: TButton;
    btnCancel: TButton;
    procedure cbTranslationClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmLocalizePlugin: TfrmLocalizePlugin;

implementation

uses
  xeMainForm;

{$R *.dfm}


procedure TfrmLocalizePlugin.cbTranslationClick(Sender: TObject);
begin
  gbTranslation.Enabled := cbTranslation.Checked;
end;

procedure TfrmLocalizePlugin.FormClose(Sender: TObject;
  var Action: TCloseAction);
var
  i, j: integer;
begin
  if cbTranslation.Checked then begin
    j := 0;
    for i := 0 to Pred(clbFrom.Count) do begin
      if clbFrom.Checked[i] and clbTo.Checked[i] then begin
        MessageBox(0, PChar('Translation files should not match'), 'Error', 0);
        Action := caNone;
        Exit;
      end;
      if clbFrom.Checked[i] then Inc(j);
      if clbTo.Checked[i] then Dec(j);
    end;
    if j <> 0 then begin
      MessageBox(0, PChar('Translation files should come in pairs'), 'Error', 0);
      Action := caNone;
    end;
  end;
end;

procedure TfrmLocalizePlugin.FormCreate(Sender: TObject);
begin
  wbApplyFontAndScale(Self);
end;

end.

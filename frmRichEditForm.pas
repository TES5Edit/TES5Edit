unit frmRichEditForm;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, JvExStdCtrls, JvRichEdit,
  Vcl.ExtCtrls, Vcl.ComCtrls;

type
  TfrmRichEdit = class(TForm)
    btnOk: TButton;
    reMain: TJvRichEdit;
    tmrEnableButton: TTimer;
    cbDontShowAgain: TCheckBox;
    edSearch: TLabeledEdit;
    tbrZoom: TTrackBar;
    Label1: TLabel;
    procedure FormCreate(Sender: TObject);
    procedure tmrEnableButtonTimer(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure edSearchKeyPress(Sender: TObject; var Key: Char);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure tbrZoomChange(Sender: TObject);
  private
    InRedirectKey: Integer;
  public
    { Public declarations }
  end;

implementation

{$R *.dfm}

uses
  wbInterface,
  frmViewMain,
  Vcl.Styles.Utils.SystemMenu;

procedure TfrmRichEdit.edSearchKeyPress(Sender: TObject; var Key: Char);
begin
  if Key = #13 then
    Key := #0;
end;

procedure TfrmRichEdit.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  if not btnOk.Enabled then
    Action := caNone;
end;

procedure TfrmRichEdit.FormCreate(Sender: TObject);
begin
  wbApplyFontAndScale(Self);

  if wbThemesSupported then
    with TVclStylesSystemMenu.Create(Self) do begin
      ShowNativeStyle := True;
      MenuCaption := 'Theme';
    end;

  tbrZoom.ThumbLength := tbrZoom.Height - 4;
end;

procedure TfrmRichEdit.FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
var
  i: Integer;
begin
  if InRedirectKey > 0 then
    Exit;

  case Key of
    VK_UP, VK_DOWN, VK_NEXT, VK_PRIOR: begin
      if not reMain.Focused then begin
        Inc(InRedirectKey);
        try
          reMain.Perform(WM_KEYDOWN, Key, 0);
        finally
          Dec(InRedirectKey);
        end;
        Key := 0;
      end;
      Exit;
    end;
  end;

  if Shift = [ssCtrl] then
    case Key of
      VK_ADD: begin
        tbrZoom.Position := tbrZoom.Position + tbrZoom.Frequency;
        tbrZoomChange(tbrZoom);
      end;
      VK_SUBTRACT: begin
        tbrZoom.Position := tbrZoom.Position - tbrZoom.Frequency;
        tbrZoomChange(tbrZoom);
      end;
      VK_NUMPAD0, Ord('0'): begin
        tbrZoom.Position := 100;
        tbrZoomChange(tbrZoom);
      end;
    end;

  if edSearch.Focused then begin

    if Key = VK_RETURN then begin
      Key := 0;

      if edSearch.Text = '' then
        Exit;

      i := 0;
      if SameText(reMain.SelText, edSearch.Text) then
        i := reMain.SelStart + reMain.SelLength;

      reMain.FindText(edSearch.Text, i, 1000000, [stSetSelection]);
    end else
      if Key = VK_ESCAPE then
          edSearch.Clear;

    Exit;
  end;

  if reMain.Focused and (Key = VK_F3) then begin
    if edSearch.Text = '' then
      Exit;

    reMain.FindText(edSearch.Text, reMain.SelStart + reMain.SelLength, 1000000, [stSetSelection]);
    Exit;
  end;

  if (Shift = [ssCtrl]) and (Key = Ord('F')) then begin
    edSearch.SetFocus;
    edSearch.SelectAll;
    Key := 0;
    Exit;
  end;

  if (Key = VK_RETURN) or (Key = VK_ESCAPE) then begin
    btnOk.Click;
    Key := 0;
    Exit;
  end;
end;

procedure TfrmRichEdit.FormShow(Sender: TObject);
begin
  tmrEnableButton.Enabled := True;
  if Assigned(frmMain) and Assigned(frmMain.Settings) then begin
    tbrZoom.Position := frmMain.Settings.ReadInteger(Name, 'Zoom', tbrZoom.Position);
    reMain.Zoom := tbrZoom.Position;
  end;
end;

procedure TfrmRichEdit.tbrZoomChange(Sender: TObject);
begin
  reMain.Zoom := tbrZoom.Position;
  if Assigned(frmMain) and Assigned(frmMain.Settings) then begin
    frmMain.Settings.WriteInteger(Name, 'Zoom', tbrZoom.Position);
    frmMain.Settings.UpdateFile;
  end;
end;

procedure TfrmRichEdit.tmrEnableButtonTimer(Sender: TObject);
begin
  tmrEnableButton.Enabled := False;
  btnOk.Enabled := True;
end;

end.

{******************************************************************************

  This Source Code Form is subject to the terms of the Mozilla Public License, 
  v. 2.0. If a copy of the MPL was not distributed with this file, You can obtain 
  one at https://mozilla.org/MPL/2.0/.

*******************************************************************************}

unit xeRichEditForm;

{$I xeDefines.inc}

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, JvExStdCtrls, JvRichEdit,
  Vcl.ExtCtrls, Vcl.ComCtrls, VirtualTrees, JvExExtCtrls, JvSplitter, xePushLikeButton;

type
  TfrmRichEdit = class(TForm)
    btnOk: TButton;
    tmrEnableButton: TTimer;
    cbDontShowAgain: TCheckBox;
    edSearch: TLabeledEdit;
    tbrZoom: TTrackBar;
    Label1: TLabel;
    pnlMain: TPanel;
    reMain: TJvRichEdit;
    splTOC: TJvSplitter;
    btnTOC: TButton;
    pnlTOC: TPanel;
    vstTOC: TVirtualStringTree;
    procedure FormCreate(Sender: TObject);
    procedure tmrEnableButtonTimer(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure edSearchKeyPress(Sender: TObject; var Key: Char);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure tbrZoomChange(Sender: TObject);
    procedure vstTOCGetText(Sender: TBaseVirtualTree; Node: PVirtualNode;
      Column: TColumnIndex; TextType: TVSTTextType; var CellText: string);
    procedure vstTOCNodeDblClick(Sender: TBaseVirtualTree;
      const HitInfo: THitInfo);
    procedure btnTOCClick(Sender: TObject);
    procedure vstTOCCollapsing(Sender: TBaseVirtualTree; Node: PVirtualNode;
      var Allowed: Boolean);
    procedure splTOCMoved(Sender: TObject);
  protected
    procedure UpdateActions; override;
  private
    NeedRebuildTOC : Boolean;
    NeedToggleTOC : Boolean;
    InRedirectKey: Integer;
    procedure BuildTOC;
    procedure TOCSelected(aNode: PVirtualNode);
  public
    { Public declarations }
  end;

implementation

{$R *.dfm}

uses
  wbInterface,
  TOM2,
  xeMainForm,
  Vcl.Styles.Utils.SystemMenu;

procedure TfrmRichEdit.btnTOCClick(Sender: TObject);
begin
  pnlTOC.Visible := btnTOC.Checked;
  splTOC.Visible := pnlTOC.Visible;
  if pnlTOC.Visible then
    if splTOC.Left <= pnlTOC.Width then
      splTOC.Left := pnlTOC.Width + 1;
  if Assigned(frmMain) and Assigned(frmMain.Settings) then begin
    frmMain.Settings.WriteBool(Name, 'TOC', pnlTOC.Visible);
    frmMain.Settings.UpdateFile;
  end;
end;

procedure TfrmRichEdit.BuildTOC;
var
  TD       : ITextDocument;
  TR       : ITextRange;
  i        : Integer;
  LastEnd  : Integer;
  LastNode : PVirtualNode;
  LastTR   : ITextRange;
  NewNode : PVirtualNode;
  NewTR   : ITextRange;
begin
  vstTOC.BeginUpdate;
  try
    vstTOC.Clear;
    vstTOC.NodeDataSize := SizeOf(Pointer);
    NeedRebuildTOC := False;

    if not Supports(reMain.RichEditOle, ITextDocument, TD) then
      Exit;

    TR := TD.Range(0,0);

    LastNode := nil;
    LastTR := nil;

    LastEnd := 0;
    i := TR.MoveEnd(tomCharFormat, 1);
    while TR.End_ > LastEnd do begin
      LastEnd := TR.End_;
      if TR.Font.Bold = tomTRUE then begin
        NewTR := TR.Duplicate;
        while Assigned(LastNode) do begin
          if NewTR.Font.Size < LastTR.Font.Size then
            Break;
          LastNode := LastNode.Parent;
          if LastNode = vstTOC.RootNode then
            LastNode := nil;
          if Assigned(LastNode) then
            LastTR := ITextRange(PPointer(LastNode.GetData)^);
        end;

        NewNode := vstTOC.AddChild(LastNode, NewTR);

        LastNode := NewNode;
        LastTR := NewTR;
      end;
      TR.Start := TR.End_;
      i := TR.MoveEnd(tomCharFormat, 1);
    end;

    vstTOC.FullExpand;
  finally
    vstTOC.EndUpdate;
  end;
end;

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
  btnTOC.PushLike := True;

  xeApplyFontAndScale(Self);

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

  if vstTOC.Focused then begin
    if Key = VK_RETURN then begin
      Key := 0;
      TOCSelected(vstTOC.FocusedNode);
      Exit;
    end;
  end else
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

  if (Shift = [ssAlt]) and (Key = Ord('T')) then begin
    btnTOC.Checked := not btnTOC.Checked;
    if btnTOC.Checked then
      vstTOC.SetFocus;
    Key := 0;
    Exit;
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
  if Assigned(frmMain) and Assigned(frmMain.Settings) then begin
    pnlTOC.Width := frmMain.Settings.ReadInteger(Name, 'TOCWidth', pnlTOC.Width);
    splTOC.Left := pnlTOC.Width + 1;
    btnTOC.Checked := frmMain.Settings.ReadBool(Name, 'TOC', pnlTOC.Visible);
  end;

  pnlMain.Margins.Top := edSearch.BoundsRect.Bottom + pnlMain.Margins.Left;
  if btnOk.Visible then
    pnlMain.Margins.Bottom := (ClientHeight - btnOk.Top) + pnlMain.Margins.Left
  else
    pnlMain.Margins.Bottom := pnlMain.Margins.Left;

  btnTOC.Left := pnlMain.Margins.Left;
  btnTOC.Top := edSearch.Top;
  btnTOC.Height := edSearch.Height;

  tmrEnableButton.Enabled := True;
  if Assigned(frmMain) and Assigned(frmMain.Settings) then begin
    tbrZoom.Position := frmMain.Settings.ReadInteger(Name, 'Zoom', tbrZoom.Position);
    reMain.Zoom := tbrZoom.Position;
  end;
  BuildTOC;
  NeedToggleTOC := True;
end;

procedure TfrmRichEdit.splTOCMoved(Sender: TObject);
begin
  if pnlTOC.Visible then
    if Assigned(frmMain) and Assigned(frmMain.Settings) then begin
      frmMain.Settings.WriteInteger(Name, 'TOCWidth', pnlTOC.Width);
      frmMain.Settings.UpdateFile;
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

procedure TfrmRichEdit.TOCSelected(aNode: PVirtualNode);
var
  p : PPointer;
begin
  p := vstTOC.GetNodeData(aNode);
  if Assigned(p) then begin
    ITextRange(p^).ScrollIntoView(tomStart);
    ITextRange(p^).Select;
  end;
end;

procedure TfrmRichEdit.UpdateActions;
begin
  if NeedRebuildTOC then
    BuildTOC;
  if NeedToggleTOC then begin
    NeedToggleTOC := False;
    if btnTOC.Checked then begin
      LockWindowUpdate(Handle);
      try
        btnTOC.Checked := not btnTOC.Checked;
        btnTOC.Checked := not btnTOC.Checked;
      finally
        LockWindowUpdate(0);
      end;
    end;
  end;
  inherited;
end;

procedure TfrmRichEdit.vstTOCCollapsing(Sender: TBaseVirtualTree;
  Node: PVirtualNode; var Allowed: Boolean);
begin
  Allowed := False;
end;

procedure TfrmRichEdit.vstTOCGetText(Sender   : TBaseVirtualTree;
                                     Node     : PVirtualNode;
                                     Column   : TColumnIndex;
                                     TextType : TVSTTextType;
                                 var CellText : string);
var
  p : PPointer;
begin
  if not NeedRebuildTOC then begin
    p := vstTOC.GetNodeData(Node);
    if Assigned(p) then try
      CellText := ITextRange(p^).Text;
      CellText := CellText.Trim;
    except
      NeedRebuildTOC := True;
    end;
  end;
end;

procedure TfrmRichEdit.vstTOCNodeDblClick(Sender: TBaseVirtualTree; const HitInfo: THitInfo);
begin
  TOCSelected(HitInfo.HitNode);
end;

end.

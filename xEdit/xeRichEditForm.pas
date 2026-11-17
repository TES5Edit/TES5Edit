{******************************************************************************

  This Source Code Form is subject to the terms of the Mozilla Public License, 
  v. 2.0. If a copy of the MPL was not distributed with this file, You can obtain 
  one at https://mozilla.org/MPL/2.0/.

*******************************************************************************}

unit xeRichEditForm;

{$I xeDefines.inc}

interface

uses
  VirtualTrees.Types,
  System.Classes,

  Winapi.Messages,

  Vcl.ComCtrls,
  Vcl.Controls,
  Vcl.ExtCtrls,
  Vcl.Forms,
  Vcl.Mask,
  Vcl.StdCtrls,

  JvExExtCtrls,
  JvExStdCtrls,
  JvRichEdit,
  JvSplitter,

  VirtualTrees,

  xePushLikeButton;

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
    procedure UpdateActions; override; final;
  private
    NeedRebuildTOC : Boolean;
    NeedToggleTOC : Boolean;
    InRedirectKey: Integer;
    RichText: string;
    procedure BuildTOC;
    procedure TOCSelected(aNode: PVirtualNode);
    procedure ShowRichText;
    procedure CMStyleChanged(var aMessage: TMessage); message CM_STYLECHANGED;
  public
    procedure LoadRichText(aStream: TStream);
  end;

implementation

{$R *.dfm}

uses
  Winapi.RichEdit,

  System.SysUtils,
  System.UITypes,

  Vcl.Graphics,
  Vcl.Styles.Utils.SystemMenu,
  Vcl.Themes,

  Winapi.Windows,

  TOM2,

  wbInterface,

  xeMainForm;

function BlendColor(aFrom, aTo: TColor; aWeight: Integer): TColor;
begin
  var lFrom := ColorToRGB(aFrom);
  var lTo := ColorToRGB(aTo);
  Result := RGB(
    (GetRValue(lFrom) * (256 - aWeight) + GetRValue(lTo) * aWeight) shr 8,
    (GetGValue(lFrom) * (256 - aWeight) + GetGValue(lTo) * aWeight) shr 8,
    (GetBValue(lFrom) * (256 - aWeight) + GetBValue(lTo) * aWeight) shr 8);
end;

function RelativeLuminance(aColor: TColor): Double;

  function Channel(aValue: Byte): Double;
  begin
    Result := aValue / 255;
    if Result <= 0.03928 then
      Result := Result / 12.92
    else
      Result := Exp(2.4 * Ln((Result + 0.055) / 1.055));
  end;

begin
  var lColor := ColorToRGB(aColor);
  Result := 0.2126 * Channel(GetRValue(lColor)) + 0.7152 * Channel(GetGValue(lColor)) + 0.0722 * Channel(GetBValue(lColor));
end;

function ContrastRatio(aFirst, aSecond: TColor): Double;
begin
  var lFirst := RelativeLuminance(aFirst);
  var lSecond := RelativeLuminance(aSecond);
  if lFirst < lSecond then
    Result := (lSecond + 0.05) / (lFirst + 0.05)
  else
    Result := (lFirst + 0.05) / (lSecond + 0.05);
end;

function RtfColor(aColor: TColor): string;
begin
  var lColor := ColorToRGB(aColor);
  Result := Format('\red%d\green%d\blue%d;', [GetRValue(lColor), GetGValue(lColor), GetBValue(lColor)]);
end;

function RtfWithColors(const aRtf: string; aText, aBackground: TColor): string;
begin
  var lStart := aRtf.IndexOf('{\colortbl');
  if lStart < 0 then
    Exit(aRtf);
  var lEnd := aRtf.IndexOf('}', lStart);
  if lEnd < 0 then
    Exit(aRtf);

  var lBlue: TColor;
  if RelativeLuminance(aBackground) >= 0.18 then
    lBlue := RGB(9, 105, 218)
  else
    lBlue := RGB(88, 166, 255);
  var lLink := lBlue;
  var lWeight := 0;
  while (ContrastRatio(lLink, aBackground) < 4.5) and (lWeight < 256) do begin
    Inc(lWeight, 16);
    lLink := BlendColor(lBlue, aText, lWeight);
  end;

  var lCodeContrast := ContrastRatio(aText, aBackground);
  if lCodeContrast > 4.5 then
    lCodeContrast := 4.5;
  var lCodeBox := BlendColor(aBackground, aText, 24);
  if ContrastRatio(aText, lCodeBox) < lCodeContrast then
    if RelativeLuminance(aText) > RelativeLuminance(aBackground) then
      lCodeBox := BlendColor(aBackground, clBlack, 24)
    else
      lCodeBox := BlendColor(aBackground, clWhite, 24);

  Result := aRtf.Substring(0, lStart) +
    '{\colortbl;' +
      RtfColor(aText) +
      RtfColor(lCodeBox) +
      RtfColor(lLink) +
      RtfColor(BlendColor(aBackground, aText, 64)) +
      RtfColor(aText) +
    '}' +
    aRtf.Substring(Succ(lEnd));
end;

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
    TR.MoveEnd(tomCharFormat, 1);
    while TR.End_ > LastEnd do begin
      LastEnd := TR.End_;

      var lText := Trim(TR.Text);
      if (lText <> '') and not lText.StartsWith('HYPERLINK') then
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
      TR.MoveEnd(tomCharFormat, 1);
    end;

    vstTOC.FullExpand;
  finally
    vstTOC.EndUpdate;
  end;
end;

procedure TfrmRichEdit.CMStyleChanged(var aMessage: TMessage);
begin
  inherited;
  if (RichText = '') or (csDestroying in ComponentState) then
    Exit;
  var lFirstLine := reMain.Perform(EM_GETFIRSTVISIBLELINE, 0, 0);
  var lSelStart := reMain.SelStart;
  var lSelLength := reMain.SelLength;
  ShowRichText;
  reMain.SelStart := lSelStart;
  reMain.SelLength := lSelLength;
  reMain.Perform(EM_LINESCROLL, 0, lFirstLine - reMain.Perform(EM_GETFIRSTVISIBLELINE, 0, 0));
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

procedure TfrmRichEdit.LoadRichText(aStream: TStream);
begin
  var lBytes: TBytes;
  SetLength(lBytes, aStream.Size - aStream.Position);
  if Length(lBytes) > 0 then
    aStream.ReadBuffer(lBytes[0], Length(lBytes));
  var lLatin1 := TEncoding.GetEncoding(28591);
  try
    RichText := lLatin1.GetString(lBytes);
  finally
    lLatin1.Free;
  end;
  ShowRichText;
end;

procedure TfrmRichEdit.ShowRichText;
begin
  var lText := ColorToRGB(reMain.Font.Color);
  var lBackground := ColorToRGB(reMain.Color);
  reMain.Perform(EM_SETBKGNDCOLOR, 0, lBackground);

  vstTOC.Clear;
  var lHasPalette := RichText.Contains('{\*\xeditcolors}');
  var lRtf := RichText;
  if lHasPalette then
    lRtf := RtfWithColors(RichText, lText, lBackground);
  var lLatin1 := TEncoding.GetEncoding(28591);
  try
    var lStream := TBytesStream.Create(lLatin1.GetBytes(lRtf));
    try
      reMain.Lines.LoadFromStream(lStream);
    finally
      lStream.Free;
    end;
  finally
    lLatin1.Free;
  end;
  reMain.Zoom := tbrZoom.Position;
  if not lHasPalette and TStyleManager.IsCustomStyleActive then begin
    reMain.SelectAll;
    reMain.SelAttributes.Color := clWindowText;
    reMain.SelStart := 0;
    reMain.SelLength := 0;
  end;
  NeedRebuildTOC := True;
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

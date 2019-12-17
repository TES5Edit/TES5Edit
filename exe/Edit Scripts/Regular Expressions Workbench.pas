{
  Script to create and test PCRE regular expressions.
  Demonstrates how to use them.
}
unit userscript;

var
  frm: TForm;
  pnlTop, pnlBottom: TPanel;
  spl: TSplitter;
  mText, mFound: TMemo;
  lblText, lblLink: TLabel;
  edExp: TLabeledEdit;
  chkCaseLess, chkMultiLine, chkSingleLine, chkExtended, chkAnchored, chkUnGreedy: TCheckBox;
  btnFind: TButton;

//===========================================================================
// on click event handler for "Find" button
procedure FindClick(Sender: TObject);
var
  regexp: TPerlRegEx;
  m, i: integer;
begin
  mFound.Text := '';

  if (Length(mText.Text) = 0) or (Length(edExp.Text) = 0) then
    Exit;

  regexp := TPerlRegEx.Create;
  try
    regexp.Subject := mText.Text;
    regexp.RegEx := edExp.Text;
    regexp.Options := [];
    if chkCaseLess.Checked then regexp.Options := regexp.Options + [preCaseLess];
    if chkMultiLine.Checked then regexp.Options := regexp.Options + [preMultiLine];
    if chkSingleLine.Checked then regexp.Options := regexp.Options + [preSingleLine];
    if chkExtended.Checked then regexp.Options := regexp.Options + [preExtended];
    if chkAnchored.Checked then regexp.Options := regexp.Options + [preAnchored];
    if chkUnGreedy.Checked then regexp.Options := regexp.Options + [preUnGreedy];
    m := 1;
    while regexp.MatchAgain do begin
      mFound.Lines.Add(Format('Match %d=%s', [m, regexp.MatchedText]));
      for i := 0 to regexp.GroupCount do
        mFound.Lines.Add(Format('Group[%d]=%s', [i, regexp.Groups[i]]));
      mFound.Lines.Add('');
      Inc(m);
    end;
  finally
    regexp.Free;
  end;
end;

//===========================================================================
// on key down event handler for expression field
procedure RegExpKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  if Key = VK_RETURN then
    FindClick(Sender);
end;

//===========================================================================
// on click event handler for help label
procedure LinkClick(Sender: TObject);
begin
  ShellExecute(TForm(frmMain).Handle, 'open', 'http://www.regular-expressions.info/tutorial.html', '', '', SW_SHOWNORMAL);
end;

//===========================================================================
procedure MainForm;
begin
  frm := TForm.Create(nil);
  try
    frm.Caption := 'Regular Expressions Workbench';
    frm.Width := 750;
    frm.Height := 600;
    frm.Position := poScreenCenter;

    pnlTop := TPanel.Create(frm);
    pnlTop.Parent := frm;
    pnlTop.BevelOuter := bvNone;
    pnlTop.Align := alTop;
    pnlTop.Height := 250;
    pnlTop.Caption := '';

    lblText := TLabel.Create(frm);
    lblText.Parent := pnlTop;
    lblText.Top := 6;
    lblText.Left := 8;
    lblText.Caption := 'Source text';

    mText := TMemo.Create(frm);
    mText.Parent := pnlTop;
    mText.Left := 0;
    mText.Top := 22;
    mText.Width := pnlTop.Width;
    mText.Height := pnlTop.Height - mText.Top;
    mText.Anchors := [akLeft, akTop, akRight, akBottom];
    mText.ScrollBars := ssBoth;
    mText.Text := 'Str:100  Int:77  Wil:57  Agi:94  Spd:98  End:100  Per:61  Lck:40';

    spl := TSplitter.Create(frm);
    spl.Parent := frm;
    spl.Top := pnlTop.Width + 1;
    spl.Height := 3;
    spl.Align := alTop;
    spl.Beveled := True;
    spl.MinSize := 150;

    pnlBottom := TPanel.Create(frm);
    pnlBottom.Parent := frm;
    pnlBottom.BevelOuter := bvNone;
    pnlBottom.Align := alClient;
    pnlBottom.Caption := '';

    edExp := TLabeledEdit.Create(frm);
    edExp.Parent := pnlBottom;
    edExp.LabelPosition := lpLeft;
    edExp.EditLabel.Caption := 'PCRE Expression:';
    edExp.Left := 8 + edExp.EditLabel.Width;
    edExp.Top := 6;
    edExp.Width := pnlBottom.Width - edExp.Left - 10;
    edExp.Anchors := [akLeft, akTop, akRight];
    edExp.OnKeyDown := RegExpKeyDown;
    edExp.Text := '(\w+):(\d+)';
    
    chkCaseLess := TCheckBox.Create(frm);
    chkCaseLess.Parent := pnlBottom;
    chkCaseLess.Caption := 'CaseLess /i';
    chkCaseLess.Top := 32;
    chkCaseLess.Left := 8;
    chkCaseLess.Checked := True;

    chkMultiLine := TCheckBox.Create(frm);
    chkMultiLine.Parent := pnlBottom;
    chkMultiLine.Caption := 'MultiLine /m';
    chkMultiLine.Top := 32;
    chkMultiLine.Left := chkCaseLess.Left + 100;
    chkMultiLine.Checked := True;

    chkSingleLine := TCheckBox.Create(frm);
    chkSingleLine.Parent := pnlBottom;
    chkSingleLine.Caption := 'SingleLine /s';
    chkSingleLine.Top := 32;
    chkSingleLine.Left := chkMultiLine.Left + 100;
    chkSingleLine.Checked := True;
    
    chkExtended := TCheckBox.Create(frm);
    chkExtended.Parent := pnlBottom;
    chkExtended.Caption := 'Extended /x';
    chkExtended.Top := 32;
    chkExtended.Left := chkSingleLine.Left + 100;

    chkAnchored := TCheckBox.Create(frm);
    chkAnchored.Parent := pnlBottom;
    chkAnchored.Caption := 'Anchored /A';
    chkAnchored.Top := 32;
    chkAnchored.Left := chkExtended.Left + 100;

    chkUnGreedy := TCheckBox.Create(frm);
    chkUnGreedy.Parent := pnlBottom;
    chkUnGreedy.Caption := 'UnGreedy';
    chkUnGreedy.Top := 32;
    chkUnGreedy.Left := chkAnchored.Left + 100;

    lblLink := TLabel.Create(frm);
    lblLink.Parent := pnlBottom;
    lblLink.Top := 32;
    lblLink.Left := chkUnGreedy.Left + 100;
    lblLink.Caption := 'Help';
    lblLink.Font.Color := clBlue;
    lblLink.Font.Style := [fsUnderLine];
    lblLink.Cursor := -21; //crHandPoint;
    lblLink.OnClick := LinkClick;

    btnFind := TButton.Create(frm);
    btnFind.Parent := pnlBottom;
    btnFind.Caption := 'Find';
    btnFind.Width := 80;
    btnFind.Left := edExp.Left + edExp.Width - btnFind.Width;
    btnFind.Top := 30;
    btnFind.Anchors := [akTop, akRight];
    btnFind.OnClick := FindClick;

    mFound := TMemo.Create(frm);
    mFound.Parent := pnlBottom;
    mFound.Left := 0;
    mFound.Top := 60;
    mFound.Width := pnlBottom.Width;
    mFound.Height := pnlBottom.Height - mFound.Top;
    mFound.Anchors := [akLeft, akTop, akRight, akBottom];
    mFound.ScrollBars := ssBoth;
    mFound.ReadOnly := True;
    
    frm.ShowModal;
  finally
    frm.Free;
  end;
end;

//===========================================================================
function Initialize: Integer;
begin
  MainForm;
  Result := 1;
end;

end.
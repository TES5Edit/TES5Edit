{
  制作中！
  
  插件整合。
}
unit UserScript;


{------------------------------------------------------------------------------}
// Check for same master files
function CheckMasters(File1, File2: IInterface): boolean;
var
  i: integer;
begin
  Result := False;
  
  if MasterCount(File1) <> MasterCount(File2) then
    Exit;
    
  for i := 0 to MasterCount(File1) - 1 do
    if not SameText(Name(MasterByIndex(File1, i)), Name(MasterByIndex(File2, i))) then
      Exit;
      
  Result := True;
end;

{------------------------------------------------------------------------------}
// Called when OK is pressed
procedure Merger(BaseFile, MergedFile: IInterface);
begin
  AddMessage(Format('正在整合 "%s" 到 "%s"...', [GetFileName(MergedFile), GetFileName(BaseFile)]));
  
  // check that the masters are the same for both plugins
  if not CheckMasters(BaseFile, MergedFile) then begin
    MessageDlg('两个插件存在相同 Master ！', mtError, [mbOk], 0);
    Exit;
  end;
  
  // TO DO
  // 1. Renumber FormIDs in MergedFile to not overlap with BaseFile
  // 2. Copy records from MergedFile to BaseFile
  
end;

{------------------------------------------------------------------------------}
// Files selection window
procedure SelectFilesForm;
var
  i: integer;
  frmMerge: TForm;
  btnOk, btnCancel: TButton;
  cbFile1, cbFile2: TComboBox;
  lbl1, lbl2: TLabel;
begin
  frmMerge := TForm.Create(nil);
  try
    frmMerge.Caption := '选择要整合的插件';
    frmMerge.Width := 400;
    frmMerge.Height := 300;
    frmMerge.Position := poScreenCenter;
    
    btnOk := TButton.Create(frmMerge);
    btnOk.Parent := frmMerge;
    btnOk.Caption := '确定';
    btnOk.ModalResult := mrOk;
    btnOk.Left := 200;
    btnOk.Top := 220;
    
    btnCancel := TButton.Create(frmMerge);
    btnCancel.Parent := frmMerge;
    btnCancel.Caption := '取消';
    btnCancel.ModalResult := mrCancel;
    btnCancel.Left := btnOk.Left + btnOk.Width + 16;
    btnCancel.Top := 220;
    
    cbFile1 := TComboBox.Create(frmMerge);
    cbFile1.Parent := frmMerge;
    cbFile1.Left := 8;
    cbFile1.Top := 40;
    cbFile1.Width := 360;
    cbFile1.Style := csDropDownList;
    
    cbFile2 := TComboBox.Create(frmMerge);
    cbFile2.Parent := frmMerge;
    cbFile2.Left := 8;
    cbFile2.Top := 100;
    cbFile2.Width := 360;
    cbFile2.Style := csDropDownList;

    for i := 0 to FileCount - 1 do begin
      cbFile1.Items.Add(GetFileName(FileByIndex(i)));
      cbFile2.Items.Add(GetFileName(FileByIndex(i)));
    end;
    cbFile1.ItemIndex := 0;
    cbFile2.ItemIndex := 0;
    
    lbl1 := TLabel.Create(frmMerge);
    lbl1.Parent := frmMerge;
    lbl1.Top := cbFile1.Top - 16;
    lbl1.Left := cbFile1.Left;
    lbl1.Caption := '基础插件 (整合进去)';
    
    lbl2 := TLabel.Create(frmMerge);
    lbl2.Parent := frmMerge;
    lbl2.Top := cbFile2.Top - 16;
    lbl2.Left := cbFile2.Left;
    lbl2.Caption := '被整合插件 (整合自)';

    if frmMerge.ShowModal = mrOk then
      Merger(FileByIndex(cbFile1.ItemIndex), FileByIndex(cbFile2.ItemIndex));
    
  finally
    frmMerge.Free;
  end;
end;

{------------------------------------------------------------------------------}
// Script initialization
function Initialize: integer;
begin
  SelectFilesForm;
  Result := 1;
end;


end.
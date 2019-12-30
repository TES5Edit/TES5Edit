{
  Batch NIF to JSON and JSON to NIF Converter

  Performs conversion of NIF files to JSON and vice versa
  in specified directory including subdirectories.
  
  Keep in mind that reconstructed (from json) NIF files won't be binary identical
  to the source nifs because of floating values rounding when converting to text and back.
  You can increase precision by setting larger number of FP decimal digits if needed.
  
  Saving a nif file also does minor automatic sanitizations (collapsing array links
  and removing unused string) which also could lead to binary differences and changed files sizes.
  
  Some fields are automatically updated when saving a nif
  and there is no point in changing them in json, including:
    - NiHeader Block Types, Block Types Index, Block Sizes and Strings
    - fields containing "Data Size" in name
  
  Supports all game NIF formats starting from Morrowind.
}
unit NifBatchJsonConverter;

const
  bJsonCompact = False; // True to save Json files without formatting


//============================================================================
procedure Convert(aPath: string; aDigits: integer);
var
  TDirectory: TDirectory; // to access member functions
  i, d: integer;
  Nif: TwbNifFile;
  files: TStringDynArray;
  f, ext: string;
begin
  if aPath = '' then Exit;

  d := dfFloatDecimalDigits;
  dfFloatDecimalDigits := aDigits;
  Nif := TwbNifFile.Create;
  try
    files := TDirectory.GetFiles(aPath, '*.*', soAllDirectories);
    AddMessage('Processing files in "' + aPath + '", press and hold ESC to abort...');
    
    for i := 0 to Pred(Length(files)) do begin
      f := files[i];
      ext := ExtractFileExt(f);
      
      // break the files processing loop if Escape is pressed
      if GetKeyState(VK_ESCAPE) and 128 = 128 then
        Break;

      if SameText(ext, '.nif') then begin
        AddMessage('Converting to Json: ' + f);
        Nif.LoadFromFile(files[i]);
        Nif.SaveToJsonFile(ChangeFileExt(f, '.json'), bJsonCompact);
      end
      
      else if SameText(ext, '.json') then begin
        AddMessage('Converting to Nif: ' + f);
        Nif.LoadFromJsonFile(files[i]);
        Nif.SaveToFile(ChangeFileExt(f, '.nif'));
      end
    end;
  
  finally
    Nif.Free;
    dfFloatDecimalDigits := d;
  end;
end;

//============================================================================
procedure btnSrcClick(Sender: TObject);
var
  edSrc: TLabeledEdit;
  s: string;
begin
  edSrc := TLabeledEdit(TForm(Sender.Parent).FindComponent('edSrc'));
  s := SelectDirectory('Select a directory', '', edSrc.Text, nil);
  if s <> '' then
    edSrc.Text := s;
end;

//============================================================================
function Initialize: Integer;
var
  frm: TForm;
  edSrc: TLabeledEdit;
  btnOk, btnCancel, btnSrc: TButton;
  lbl: TLabel;
  cmbDigits: TComboBox;
  pnl: TPanel;
  i: integer;
begin
  frm := TForm.Create(nil);
  try
    frm.Caption := 'Batch JSON Converter';
    frm.Width := 500;
    frm.Height := 190;
    frm.Position := poMainFormCenter;
    frm.BorderStyle := bsDialog;
    
    edSrc := TLabeledEdit.Create(frm); edSrc.Parent := frm;
    edSrc.Name := 'edSrc';
    edSrc.Left := 12;
    edSrc.Top := 24;
    edSrc.Width := frm.Width - 70;
    edSrc.LabelPosition := lpAbove;
    edSrc.EditLabel.Caption := 'Source folder with *.nif or *.json files';
    edSrc.Text := wbDataPath;

    btnSrc := TButton.Create(frm);
    btnSrc.Parent := frm;
    btnSrc.Top := edSrc.Top - 1;
    btnSrc.Left := edSrc.Left + edSrc.Width + 6;
    btnSrc.Width := 32; btnSrc.Height := 22; btnSrc.Caption := '...';
    btnSrc.OnClick := btnSrcClick;
    
    lbl := TLabel.Create(frm); lbl.Parent := frm;
    lbl.Left := edSrc.Left;
    lbl.Top := edSrc.Top + 32;
    lbl.Caption := 'Json floating values decimal digits';
    
    cmbDigits := TComboBox.Create(frm); cmbDigits.Parent := frm;
    cmbDigits.Left := edSrc.Left;
    cmbDigits.Top := lbl.Top + 18;
    cmbDigits.Width := 40;
    cmbDigits.Style := csDropDownList;
    cmbDigits.DropDownCount := 12;
    for i := dfFloatDecimalDigits to dfFloatDecimalDigits + 10 do
      cmbDigits.Items.Add(IntToStr(i));
    cmbDigits.ItemIndex := 0;

    btnOk := TButton.Create(frm); btnOk.Parent := frm;
    btnOk.Caption := 'OK';
    btnOk.ModalResult := mrOk;
    btnOk.Left := frm.Width - 176;
    btnOk.Top := frm.Height - 62;
    
    btnCancel := TButton.Create(frm); btnCancel.Parent := frm;
    btnCancel.Caption := 'Cancel';
    btnCancel.ModalResult := mrCancel;
    btnCancel.Left := btnOk.Left + btnOk.Width + 8;
    btnCancel.Top := btnOk.Top;

    pnl := TPanel.Create(frm); pnl.Parent := frm; pnl.Left := 8; pnl.Top := btnOk.Top - 12; pnl.Width := frm.Width - 20; pnl.Height := 2;

    if frm.ShowModal = mrOk then
      if edSrc.Text <> '' then
        Convert( edSrc.Text, StrToInt(cmbDigits.Text) );
    
  finally
    frm.Free;
  end;
  
  Result := 1;
end;

end.

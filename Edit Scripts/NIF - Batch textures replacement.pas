{
  Batch text replacement in textures and materials file names inside *.nif files
  Optionally perform replacement inside material files (*.bgsm and *.bgem)

  Search is case insensitive.
  
  Supports all game NIF formats starting from Morrowind.
}
unit NifBatchTextureReplacement;

const
  bFixAbsolutePaths = True; // automatically fix absolute paths if found
  iShowProgress = 100; // show progress message for each 100 processed files, 0 to disable
  
  sDefaultSourcePath = ''; // Data folder will be used if empty
  sDefaultDestinationPath = ''; // Data folder will be used if empty
  sDefaultReplacement = 'Textures\'#13'Textures\New\'; // default replacements

var
  bMaterial, bInMaterial, bReportOnly: Boolean;


//============================================================================
procedure BatchReplace(aSrcPath, aDstPath: string; aFind, aReplace: TStringList);
var
  TDirectory: TDirectory; // to access member functions
  i, j, k, p, Processed, Updated: integer;
  Elements: TList;
  el: TdfElement;
  Nif: TwbNifFile;
  Block: TwbNifBlock;
  BGSM: TwbBGSMFile;
  BGEM: TwbBGEMFile;
  files: TStringDynArray;
  f, f2, ext: string;
  s, s2: WideString;
  bChanged: Boolean;
begin
  if (aSrcPath = '') or (aDstPath = '') then Exit;
  aSrcPath := IncludeTrailingBackslash(aSrcPath);
  aDstPath := IncludeTrailingBackslash(aDstPath);
  Processed := 0;
  Updated := 0;
  
  Elements := TList.Create;
  Nif := TwbNifFile.Create;
  BGSM := TwbBGSMFile.Create;
  BGEM := TwbBGEMFile.Create;

  try
    // list of all files in the source folder
    files := TDirectory.GetFiles(aSrcPath, '*.*', soAllDirectories);
    AddMessage('Processing files in "' + aSrcPath + '", press and hold ESC to abort...');
    
    // processing files
    for i := 0 to Pred(Length(files)) do begin
      f := files[i];
      f2 := aDstPath + Copy(f, Length(aSrcPath) + 1, Length(f));
      ext := ExtractFileExt(f);
      Inc(Processed);

      // break the files processing loop if Escape is pressed
      if GetKeyState(VK_ESCAPE) and 128 = 128 then
        Break;
      
      // show progress if set
      if iShowProgress > 0 then
        if (i > 0) and (i mod iShowProgress = 0) then
          AddMessage(IntToStr(i) + ' files processed');

      // collecting elements with textures
      // *.NIF file
      if SameText(ext, '.nif') then begin
        Nif.LoadFromFile(f);
        
        // iterate over all blocks in a nif file and locate elements holding textures
        for j := 0 to Pred(Nif.BlocksCount) do begin
          Block := Nif.Blocks[j];
          
          // BGSM/BGEM file in the Name field of FO4 meshes
          if bMaterial and (Nif.NifVersion = nfFO4) and (Block.BlockType = 'BSLightingShaderProperty') then
            Elements.Add(Block.Elements['Name'])
          
          else if Block.BlockType = 'BSShaderTextureSet' then begin
            el := Block.Elements['Textures'];
            for j := 0 to Pred(el.Count) do
              Elements.Add(el[j]);
          end
          
          else if Block.BlockType = 'BSEffectShaderProperty' then begin
            Elements.Add(Block.Elements['Source Texture']);
            Elements.Add(Block.Elements['Grayscale Texture']);
            Elements.Add(Block.Elements['Env Map Texture']);
            Elements.Add(Block.Elements['Normal Texture']);
            Elements.Add(Block.Elements['Env Mask Texture']);
            // BGSM/BGEM file in the Name field of FO4 meshes
            if bMaterial and (Nif.NifVersion = nfFO4) then
              Elements.Add(Block.Elements['Name']);
          end

          else if (Block.BlockType = 'BSShaderNoLightingProperty') or
                  (Block.BlockType = 'TallGrassShaderProperty') or
                  (Block.BlockType = 'TileShaderProperty')
          then
            Elements.Add(Block.Elements['File Name'])

          else if Block.BlockType = 'BSSkyShaderProperty' then
            Elements.Add(Block.Elements['Source Texture'])

          // any block inherited from NiTexture
          else if Block.IsNiObject('NiTexture', True) then
            Elements.Add(Block.Elements['File Name']);

        end;    
      end
      
      // *.BGSM file
      else if SameText(ext, '.bgsm') then begin
        BGSM.LoadFromFile(f);
        el := BGSM.Elements['Textures'];
        for j := 0 to Pred(el.Count) do
          Elements.Add(el[j]);
      end
      
      // *.BGEM file
      else if SameText(ext, '.bgem') then begin
        BGEM.LoadFromFile(f);
        el := BGEM.Elements['Textures'];
        for j := 0 to Pred(el.Count) do
          Elements.Add(el[j]);
      end;
      
      // skip to the next file if nothing was found
      if Elements.Count = 0 then Continue;
      
      // do text replacement in collected elements
      for j := 0 to Pred(Elements.Count) do begin
        if not Assigned(Elements[j]) then
          Continue
        else
          el := TdfElement(Elements[j]);
        
        // getting file name stored in element
        s := el.EditValue;
        // skip to the next element if empty
        if s = '' then Continue;
      
        // perform replacements, trim whitespaces just in case
        s2 := Trim(s);
        for k := 0 to Pred(aFind.Count) do begin
          if aFind[k] <> '' then
            // replace if text to find is not empty
            s2 := StringReplace(s2, aFind[k], aReplace[k], [rfIgnoreCase, rfReplaceAll])
          else
            // prepend if empty
            s2 := aReplace[k] + s2;
        end;
        
        if bFixAbsolutePaths then
          // detect an absolute path
          if (Length(s2) > 2) and (Copy(s2, 2, 1) = ':') then begin
            // remove path up to Data including it
            p := Pos('\data\', LowerCase(s2));
            if p <> 0 then
              s2 := Copy(s2, p + 6, Length(s2));
            // remove path up to Data Files including it for Morrowind
            if p = 0 then begin
              p := Pos('\data files\', LowerCase(s2));
              if p <> 0 then
                s2 := Copy(s, p + 12, Length(s2));
            end;
          end;

        // if element's value has changed
        if s <> s2 then begin
          // store it
          el.EditValue := s2;
          
          // report
          if not bChanged then
            AddMessage(#13#10 + f);
          AddMessage(#9 + el.Path + #13#10#9#9'"' + s + '"'#13#10#9#9'"' + el.EditValue + '"');
          
          // mark file to be saved
          bChanged := True;
        end;
      end;

      // save the file if changed and not in report only mode
      if bChanged and not bReportOnly then begin
        // create the same folders structure as the source file in the destination folder
        s := ExtractFilePath(f2);
        if not DirectoryExists(s) then
          if not ForceDirectories(s) then
            raise Exception.Create('Can not create destination directory ' + s);
        
        // get the root of the last processed element (the file element itself) and save
        el.Root.SaveToFile(f2);
        Inc(Updated);
      end;
      
      // clear mark and elements list
      bChanged := False;
      Elements.Clear;
    end;
  
    AddMessage(Format(#13#10'Processed Files: %d,  Updated: %d', [Processed, Updated]));
  finally
    Elements.Free;
    Nif.Free;
    BGSM.Free;
    BGEM.Free;
  end;
end;

//============================================================================
procedure btnSrcClick(Sender: TObject);
var
  ed: TLabeledEdit;
  s: string;
begin
  ed := TLabeledEdit(TForm(Sender.Parent).FindComponent('edSrc'));
  s := SelectDirectory('Select source', '', ed.Text, nil);
  if s <> '' then begin
    ed.Text := s;
    ed := TLabeledEdit(TForm(Sender.Parent).FindComponent('edDst'));
    if ed.Text = '' then
      ed.Text := s;
  end;
end;

//============================================================================
procedure btnDstClick(Sender: TObject);
var
  ed: TLabeledEdit;
  s: string;
begin
  ed := TLabeledEdit(TForm(Sender.Parent).FindComponent('edDst'));
  s := SelectDirectory('Select destination', '', ed.Text, nil);
  if s <> '' then
    ed.Text := s;
end;

//============================================================================
function Initialize: Integer;
var
  frm: TForm;
  edSrc, edDst: TLabeledEdit;
  lblReplace: TLabel;
  memoReplace: TMemo;
  btnOk, btnCancel, btnSrc, btnDst: TButton;
  chkMaterial, chkInMaterial, chkReportOnly: TCheckBox;
  pnl: TPanel;
  slFind, slReplace: TStringList;
  i: integer;
begin
  slFind := TStringList.Create;
  slReplace := TStringList.Create;

  frm := TForm.Create(nil);
  try
    frm.Caption := 'NIF/BGSM/BGEM Batch Textures Replacement';
    frm.Width := 500;
    frm.Height := 400;
    frm.Position := poMainFormCenter;
    frm.BorderStyle := bsDialog;
    
    edSrc := TLabeledEdit.Create(frm); edSrc.Parent := frm;
    edSrc.Name := 'edSrc';
    edSrc.Left := 12;
    edSrc.Top := 24;
    edSrc.Width := frm.Width - 70;
    edSrc.LabelPosition := lpAbove;
    edSrc.EditLabel.Caption := 'Source folder';
    if sDefaultSourcePath <> '' then
      edSrc.Text := sDefaultSourcePath
    else
      edSrc.Text := wbDataPath;

    btnSrc := TButton.Create(frm);
    btnSrc.Parent := frm;
    btnSrc.Top := edSrc.Top - 1;
    btnSrc.Left := edSrc.Left + edSrc.Width + 6;
    btnSrc.Width := 32; btnSrc.Height := 22; btnSrc.Caption := '...';
    btnSrc.OnClick := btnSrcClick;

    edDst := TLabeledEdit.Create(frm); edDst.Parent := frm;
    edDst.Name := 'edDst';
    edDst.Left := 12;
    edDst.Top := edSrc.Top + 46;
    edDst.Width := frm.Width - 70;
    edDst.LabelPosition := lpAbove;
    edDst.EditLabel.Caption := 'Destination folder';
    if sDefaultDestinationPath <> '' then
      edDst.Text := sDefaultDestinationPath
    else
      edDst.Text := wbDataPath;

    btnDst := TButton.Create(frm);
    btnDst.Parent := frm;
    btnDst.Top := edDst.Top - 1;
    btnDst.Left := edDst.Left + edDst.Width + 6;
    btnDst.Width := 32; btnDst.Height := 22; btnDst.Caption := '...';
    btnDst.OnClick := btnDstClick;

    chkMaterial := TCheckBox.Create(frm); chkMaterial.Parent := frm;
    chkMaterial.Left := edDst.Left + 12;
    chkMaterial.Top := edDst.Top + 32;
    chkMaterial.Width := frm.Width - 60;
    chkMaterial.Caption := '[FO4] Replace in material file names defined in NIF';
    chkMaterial.Checked := True;

    chkInMaterial := TCheckBox.Create(frm); chkInMaterial.Parent := frm;
    chkInMaterial.Left := chkMaterial.Left;
    chkInMaterial.Top := chkMaterial.Top + 24;
    chkInMaterial.Width := frm.Width - 60;
    chkInMaterial.Caption := '[FO4] Replace textures inside material files (*.BGSM, *.BGEM)';
    chkInMaterial.Checked := True;

    chkReportOnly := TCheckBox.Create(frm); chkReportOnly.Parent := frm;
    chkReportOnly.Left := chkMaterial.Left;
    chkReportOnly.Top := chkInMaterial.Top + 24;
    chkReportOnly.Width := frm.Width - 60;
    chkReportOnly.Caption := 'Report only, do not save any changes';

    lblReplace := TLabel.Create(frm); lblReplace.Parent := frm;
    lblReplace.Left := 12;
    lblReplace.Top := chkReportOnly.Top + 34;
    lblReplace.AutoSize := False;
    lblReplace.WordWrap := True;
    lblReplace.Width := frm.Width - 34;
    lblReplace.Height := 30;
    lblReplace.Caption := 'Replacement pair(s): odd lines specify what text to replace, even lines text to replace with. If odd line is empty then replacement text is prepended to all textures.';

    memoReplace := TMemo.Create(frm); memoReplace.Parent := frm;
    memoReplace.Left := 12;
    memoReplace.Top := lblReplace.Top + lblReplace.Height + 8;
    memoReplace.Height := 90;
    memoReplace.Width := frm.Width - 34;
    memoReplace.ScrollBars := ssVertical;
    memoReplace.Lines.Text := sDefaultReplacement;

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

    if frm.ShowModal = mrOk then begin
      bMaterial := chkMaterial.Checked;
      bInMaterial := chkInMaterial.Checked;
      bReportOnly := chkReportOnly.Checked;
      
      for i := 0 to memoReplace.Lines.Count div 2 do
        // skip if both odd and even lines are empty
        if (memoReplace.Lines[i * 2] <> '') or (memoReplace.Lines[i * 2 + 1] <> '') then begin
          slFind.Add(memoReplace.Lines[i * 2]);
          slReplace.Add(memoReplace.Lines[i * 2 + 1]);
        end;
      
      if slFind.Count <> 0 then
        BatchReplace( edSrc.Text, edDst.Text, slFind, slReplace )
      else
        AddMessage('No replacements specified!');
    end;
    
  finally
    frm.Free;
    slFind.Free;
    slReplace.Free;
  end;
  
  Result := 1;
end;

end.

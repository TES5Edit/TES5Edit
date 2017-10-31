{
  Convert OBJ file to NIF

  This is a very simple converter which supports limited number of features.
  For demonstration purposes only.
  
  Tested on free mesh
  https://free3d.com/download-page.php?url=low-poly-cow-75171  
}
unit ConvertObjToNif;

const
  // default file names and format
  sObjFileName = '';
  sNifFileName = '';
  iNifFormat = nfTES5;

var
  Vertices, Triangles, Normals, UVs: TStringList;
  HasNormals, HasUVs, bFullPrecision: Boolean;
  edSrc, edDst: TLabeledEdit;
  

//============================================================================
function ReadObj(aFileName: string): Boolean;
var
  slObj, sl: TStringList;
  i, j, f1, f2, f3: Integer;
  s: string;
begin
  slObj := TStringList.Create;
  sl := TStringList.Create; sl.Delimiter := ' '; sl.StrictDelimiter := True;
  
  // OBJ Format https://en.wikipedia.org/wiki/Wavefront_.obj_file
  // multiple shapes are not supported, whole file is treated as a single shape
  try
    slObj.LoadFromFile(aFileName);
    
    for i := 0 to Pred(slObj.Count) do begin
      sl.DelimitedText := StringReplace(slObj[i], '  ', ' ', [rfReplaceAll]);
      
      if sl.Count < 3 then
        Continue;
      
      // getting vertices
      // a line starting with 'v' and at least 3 float values
      if (sl[0] = 'v') and (sl.Count >= 4) then
        Vertices.Add(sl[1] + ' ' + sl[2] + ' ' + sl[3])
      
      // getting normals
      // a line starting with 'vn' and 3 float values
      else if (sl[0] = 'vn') and (sl.Count >= 4) then
        Normals.Add(sl[1] + ' ' + sl[2] + ' ' + sl[3])
      
      // getting texture coordinates
      // a line starting with 'vt' and at least 2 float values
      else if (sl[0] = 'vt') and (sl.Count >= 3) then
        UVs.Add(sl[1] + ' ' + sl[2]);
    
    end;
    
    // no need to load triangles if there are no valid vertices
    if Vertices.Count = 0 then
      Exit;
    
    // getting faces (triangles)
    // negative indices are supported, however custom /vn/vt indices are not supported for simplicity
    for i := 0 to Pred(slObj.Count) do begin
      sl.DelimitedText := slObj[i];
      
      if sl.Count < 4 then
        Continue;
      
      if sl[0] = 'f' then begin
        s := sl[1]; j := Pos('/', s); if j = 0 then f1 := StrToInt(s) else f1 := StrToInt(Copy(s, 1, j - 1));
        s := sl[2]; j := Pos('/', s); if j = 0 then f2 := StrToInt(s) else f2 := StrToInt(Copy(s, 1, j - 1));
        s := sl[3]; j := Pos('/', s); if j = 0 then f3 := StrToInt(s) else f3 := StrToInt(Copy(s, 1, j - 1));
        if f1 < 0 then f1 := Vertices.Count + f1 else f1 := f1 - 1;
        if f2 < 0 then f2 := Vertices.Count + f2 else f2 := f2 - 1;
        if f3 < 0 then f3 := Vertices.Count + f3 else f3 := f3 - 1;
        Triangles.Add(IntToStr(f1) + ' ' + IntToStr(f2) + ' ' + IntToStr(f3));
      end;
    end;
    
  finally
    sl.Free;
    slObj.Free;
  end;
  
  Result := (Vertices.Count <> 0) and (Triangles.Count <> 0);
  HasNormals := Result and (Normals.Count = Vertices.Count);
  HasUVs := Result and (UVs.Count = Vertices.Count);
end;

//============================================================================
procedure CreateNif(aFileName: string; aVersion: TNifVersion);
var
  Nif: TwbNifFile;
  Node, Prop, TriShape, TriShapeData: TwbNifBlock;
  arr, v: TdfElement;
  i: Integer;
begin
  Nif := TwbNifFile.Create;
  try
    // create default NiHeader and NiFooter
    Nif.SetToDefault;
    
    // set NiHeader version numbers for the specified game
    Nif.NifVersion := aVersion;
    
    // root Node
    if Nif.NifVersion >= nfFO3 then begin
      Node := Nif.AddBlock('BSFadeNode');
      Node.NativeValues['Flags'] := 524302;
    end else
      Node := Nif.AddBlock('NiNode');
    
    // create appropriate TriShape
    if Nif.NifVersion >= nfSSE then
      TriShape := node.AddChild('BSTriShape')
    else
      TriShape := node.AddChild('NiTriShape');
    
    // add a shader, NifScope doesn't render without it
    if Nif.NifVersion < nfFO3 then
      TriShape.AddProperty('NiTexturingProperty')
    else if nif.NifVersion = nfFO3 then
      TriShape.AddProperty('BSShaderPPLightingProperty')
    else begin
      Prop := TriShape.AddProperty('BSLightingShaderProperty');
      // OBJ doesn't have vertex colors
      Prop.NativeValues['Shader Flags 2\Vertex_Colors'] := 0;
    end;
    
    //-----------------------------------
    // BSTriShape handling
    if Nif.NifVersion >= nfSSE then begin
      // setting vertex flags
      TriShape.NativeValues['VertexDesc\VF'] := 0;
      TriShape.NativeValues['VertexDesc\VF\VF_VERTEX'] := 1;
      TriShape.NativeValues['VertexDesc\VF\VF_NORMAL'] := HasNormals;
      TriShape.NativeValues['VertexDesc\VF\VF_UV'] := HasUVs;
      // full precision in FO4 meshes
      TriShape.NativeValues['VertexDesc\VF\VF_FULLPREC'] := bFullPrecision and (nif.NifVersion = nfFO4);

      // write vertex data (vertices + normals + uv)
      TriShape.NativeValues['Num Vertices'] := Vertices.Count;
      arr := TriShape.Elements['Vertex Data'];
      arr.Count := Vertices.Count;
      for i := 0 to Pred(Vertices.Count) do begin
        v := arr[i];
        v.EditValues['Vertex'] := Vertices[i];
        if HasNormals then v.EditValues['Normal'] := Normals[i];
        if HasUVs then v.EditValues['UV'] := UVs[i];
      end;

      // write triangles
      TriShape.NativeValues['Num Triangles'] := Triangles.Count;
      arr := TriShape.Elements['Triangles'];
      arr.Count := Triangles.Count;
      for i := 0 to Pred(Triangles.Count) do
        arr[i].EditValue := Triangles[i];
      
      // update Bounding Sphere values
      TriShape.UpdateBounds;

      // BSTriShape doesn't render correctly without tangents
      // they require UVs and normals
      if HasUVs then begin
        // add normals if missing
        if not HasNormals then TriShape.UpdateNormals;
        TriShape.UpdateTangents;
      end;
    end
    
    //-----------------------------------
    // older games NiTriShapeData
    else begin
      // adding NiTriShapeData
      TriShapeData := nif.AddBlock('NiTriShapeData');
      // linking to NiTriShape
      TriShape.NativeValues['Data'] := TriShapeData.Index;
      
      // write vertices
      TriShapeData.NativeValues['Num Vertices'] := Vertices.Count;
      arr := TriShapeData.Elements['Vertices'];
      arr.Count := Vertices.Count;
      for i := 0 to Pred(Vertices.Count) do
        arr[i].EditValue := Vertices[i];
      
      // write triangles
      TriShapeData.NativeValues['Num Triangles'] := Triangles.Count;
      if nif.NifVersion > nfTES3 then
        TriShapeData.NativeValues['Has Triangles'] := 1;
      arr := TriShapeData.Elements['Triangles'];
      arr.Count := Triangles.Count;
      for i := 0 to Pred(Triangles.Count) do
        arr[i].EditValue := Triangles[i];
      
      // write normals
      if HasNormals then begin
        TriShapeData.NativeValues['Has Normals'] := 1;
        arr := TriShapeData.Elements['Normals'];
        arr.Count := Normals.Count;
        for i := 0 to Pred(Normals.Count) do
          arr[i].EditValue := Normals[i];
      end;
      
      // write UVs
      if HasUVs then begin
        if nif.NifVersion = nfTES3 then begin
          TriShapeData.NativeValues['Num UV Sets'] := 1;
          TriShapeData.NativeValues['Has UV'] := 1;
        end else
          // "Vector Flags" holds "Num UV Sets" in lower bits and tangent flags
          // but we don't have tangents so just assign a single UV set
          TriShapeData.NativeValues['Vector Flags'] := 1;
        
        // UV Sets is an array of UV Set which in turn is an array of (u,v) values
        // add new UV Set
        arr := TriShapeData.Elements['UV Sets'].Add;
        arr.Count := UVs.Count;
        for i := 0 to Pred(UVs.Count) do
          arr[i].EditValue := UVs[i];
      end;
      
      // update Center and Radius values
      TriShapeData.UpdateBounds;
    end;

    Nif.SaveToFile(aFileName);
  finally
    Nif.Free;
  end;
end;

//============================================================================
procedure Convert(aObjFile, aNifFile: string; aNifVersion: TwbNifVersion);
begin
  Vertices := TStringList.Create;
  Triangles := TStringList.Create;
  Normals := TStringList.Create;
  UVs := TStringList.Create;
  try
    AddMessage('Loading OBJ file ' + aObjFile);
    ReadObj(aObjFile);
    
    AddMessage(Format('Vertices: %d   Normals: %d   UVs: %d   Triangles: %d', [Vertices.Count, Normals.Count, UVs.Count, Triangles.Count]));
    
    if (Vertices.Count = 0) or (Triangles.Count = 0) then begin
      AddMessage('No vertices or triangles found.');
      Exit;
    end;
    
    //bFullPrecision := True;
    AddMessage('Creating NIF file...');
    CreateNif(aNifFile, aNifVersion);
    
    AddMessage('Done.');
  finally
    Vertices.Free;
    Triangles.Free;
    Normals.Free;
    UVs.Free;
  end;
end;

//============================================================================
procedure btnSrcClick(Sender: TObject);
var
  dlg: TOpenDialog;
begin
  dlg := TOpenDialog.Create(nil);
  try
    dlg.Filter := 'OBJ Files (*.obj)|*.obj';
    dlg.InitialDir := ExtractFilePath(edSrc.Text);
    if dlg.InitialDir = '' then
      dlg.InitialDir := wbDataPath;
    if dlg.Execute then begin
      edSrc.Text := dlg.FileName;
      if edDst.Text = '' then
        edDst.Text := ChangeFileExt(dlg.FileName, '.nif');
    end;
  finally
    dlg.Free;
  end;
end;

//============================================================================
procedure btnDstClick(Sender: TObject);
var
  dlg: TSaveDialog;
begin
  dlg := TSaveDialog.Create(nil);
  try
    dlg.Filter := 'NIF Files (*.nif)|*.nif';
    dlg.InitialDir := ExtractFilePath(edDst.Text);
    if dlg.InitialDir = '' then
      dlg.InitialDir := wbDataPath;
    if dlg.Execute then
      edDst.Text := dlg.FileName;
  finally
    dlg.Free;
  end;
end;

//============================================================================
function Initialize: Integer;
var
  frm: TForm;
  btnOk, btnCancel, btnSrc, btnDst: TButton;
  rg: TRadioGroup;
  pnl: TPanel;
  chkFullPrec: TCheckBox;
begin
  frm := TForm.Create(nil);
  try
    frm.Caption := 'OBJ to NIF Converter';
    frm.Width := 600;
    frm.Height := 380;
    frm.Position := poMainFormCenter;
    frm.BorderStyle := bsDialog;
    //frm.KeyPreview := True;
    //frm.OnKeyDown := FormKeyDown;
    
    edSrc := TLabeledEdit.Create(frm);
    edSrc.Parent := frm;
    edSrc.Left := 12;
    edSrc.Top := 24;
    edSrc.Width := frm.Width - 70;
    edSrc.LabelPosition := lpAbove;
    edSrc.EditLabel.Caption := 'Source OBJ File';
    edSrc.Text := sObjFileName;

    btnSrc := TButton.Create(frm);
    btnSrc.Parent := frm;
    btnSrc.Top := edSrc.Top - 1;
    btnSrc.Left := edSrc.Left + edSrc.Width + 6;
    btnSrc.Width := 32; btnSrc.Height := 22; btnSrc.Caption := '...';
    btnSrc.OnClick := btnSrcClick;

    edDst := TLabeledEdit.Create(frm);
    edDst.Parent := frm;
    edDst.Left := 12;
    edDst.Top := edSrc.Top + 46;
    edDst.Width := frm.Width - 70;
    edDst.LabelPosition := lpAbove;
    edDst.EditLabel.Caption := 'NIF File';
    edDst.Text := sNifFileName;

    btnDst := TButton.Create(frm);
    btnDst.Parent := frm;
    btnDst.Top := edDst.Top - 1;
    btnDst.Left := edDst.Left + edDst.Width + 6;
    btnDst.Width := 32; btnDst.Height := 22; btnDst.Caption := '...';
    btnDst.OnClick := btnDstClick;

    rg := TRadioGroup.Create(frm); rg.Parent := frm;
    rg.Top := edDst.Top + 30;
    rg.Left := 20;
    rg.Width := frm.Width - 40;
    rg.Height := 170;
    rg.Caption := 'NIF Format';
    rg.Items.AddObject('Morrowind', nfTES3);
    rg.Items.AddObject('Oblivion', nfTES4);
    rg.Items.AddObject('Falout 3 / New Vegas', nfFO3);
    rg.Items.AddObject('Skyrim', nfTES5);
    rg.Items.AddObject('Skyrim Special Edition', nfSSE);
    rg.Items.AddObject('Fallout 4', nfFO4);
    rg.ItemIndex := rg.Items.IndexOfObject(iNifFormat);
    
    chkFullPrec := TCheckBox.Create(frm); chkFullPrec.Parent := frm;
    chkFullPrec.Top := rg.Top + rg.Height + 8;
    chkFullPrec.Left := rg.Left;
    chkFullPrec.Width := frm.Width - 40;
    chkFullPrec.Caption := 'Fallout 4 Full Precision (32 bit floats instead of 16 bit)';

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
      if (edSrc.Text <> '') and (edDst.Text <> '') then begin
        bFullPrecision := chkFullPrec.Checked;
        Convert(edSrc.Text, edDst.Text, rg.Items.Objects[rg.ItemIndex]);
      end;
    
  finally
    frm.Free;
  end;
  
  Result := 1;
end;

end.

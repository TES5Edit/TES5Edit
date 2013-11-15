{
  Visual worldspace browser.
  Supports Oblivion, Fallout 3, New Vegas, Skyrim.
  
  Hotkey: Alt+F3
}
unit WorldspaceBrowser;

const
  CellSize = 4096;
  ColorBackground = $000000; // background map color RGB
  ColorTransparent = $000001; // transparent color for overlay
  // cell grid font sizes for lod level 32
  FontSizeBlock = 20;
  FontSizeSubBlock = 7;
  FontSizeCell = 5;

var
  MapSizeX, MapSizeY: integer;
  LODLevel, LODSize: integer;
  MapWidthPx, MapHeightPx, CellSizePx: integer;
  PosSizePx: real;
  MapViewScale: real;
  GridOpacity: integer;
  fMapDrawn, fMapNormals: boolean;
  CurrentWorld: IInterface;
  slPlugin, slRegion: TStringList;

  frmMain, frmWorld: TForm;
  mnMain: TMainMenu;
  mi, miWorldspace, miOverlay, miRegion, miCell: TMenuItem;
  memoInfo: TMemo;
  sbxMap: TScrollBox;
  imgMap, imgOver: TImage;
  cmbWorld, cmbMapSize, cmbLODLevel, cmbLODSize, cmbScale, cmbGrid: TComboBox;
  chkNormals: TCheckBox;


  
//============================================================================
// name of LOD settings file for worldspace
function LODSettingsFileName(wrld: IInterface): string;
begin
  if wbGameMode = gmTES4 then
    Result := ''
  else if (wbGameMode = gmFO3) or (wbGameMode = gmFNV) then
    Result := 'lodsettings\' + EditorID(wrld) + '.dlodsettings'
  else
    Result := 'lodsettings\' + EditorID(wrld) + '.lod';
end;

//============================================================================
// name of LOD texture for worldspace
function LODTextureFileName(aGame, aFormID: integer; aEditorID: string;
  x, y, aLODLevel: integer; aNormals: boolean): string;
var
  texname: string;
begin
  // Oblivion
  if aGame = gmTES4 then begin
    if not aNormals then texname := 'textures\landscapelod\generated\%s.%.2d.%.2d.%d.dds'
                    else texname := 'textures\landscapelod\generated\%s.%.2d.%.2d.%d_fn.dds';
    Result := Format(texname, [IntToStr(aFormID and $FFFFFF), x, y, aLODLevel]);
  end
  // Fallout
  else if (aGame = gmFO3) or (aGame = gmFNV) then begin
    if not aNormals then texname := 'textures\landscape\lod\%s\diffuse\%s.n.level%d.x%d.y%d.dds'
                    else texname := 'textures\landscape\lod\%s\normals\%s.n.level%d.x%d.y%d.dds';
    Result := Format(texname, [aEditorID, aEditorID, aLODLevel, x, y]);
  end
  // Skyrim (and probably later games)
  else begin
    if not aNormals then texname := 'textures\terrain\%s\%s.%d.%d.%d.dds'
                    else texname := 'textures\terrain\%s\%s.%d.%d.%d_n.dds';
    Result := Format(texname, [aEditorID, aEditorID, aLODLevel, x, y]);
  end;
end;

//============================================================================
// does worldspace have a lod?
function HasLOD(wrld: IInterface): boolean;
begin
  // for Oblivion it is a presence of 0,0 quad lod texture
  if wbGameMode = gmTES4 then
    Result := ResourceExists(LODTextureFileName(wbGameMode, FormID(wrld), EditorID(wrld), 0, 0, 32, False))
  // for other games a presence of lod settings file
  else
    Result := ResourceExists(LODSettingsFileName(wrld));
end;

//============================================================================
// get south west cell of lod
procedure LODCellSW(wrld: IInterface; var SWCellX, SWCellY: integer);
var
  BytesStream: TBytesStream;
  lodsettings: TBinaryReader;
begin
  // for Oblivion it is a mapsize, also default values for other games
  SWCellX := -MapSizeX;
  SWCellY := -MapSizeY;

  if not HasLOD(wrld) then
    Exit;

  // read from lod settings file
  if wbGameMode <> gmTES4 then begin
    BytesStream := TBytesStream.Create(ResourceOpenData('', LODSettingsFileName(wrld)));
    lodsettings := TBinaryReader.Create(BytesStream);
    try
      if (wbGameMode = gmFO3) or (wbGameMode = gmFNV) then
        BytesStream.Position := 12;
      SWCellX := lodsettings.ReadSmallInt;
      SWCellY := lodsettings.ReadSmallInt;
    finally
      lodsettings.Free;
      BytesStream.Free;
    end;
  end;
end;

//============================================================================
// returns LAND record for CELL record
function GetLandscapeForCell(cell: IInterface): IInterface;
var
  cellchild, r: IInterface;
  i: integer;
begin
  cellchild := FindChildGroup(ChildGroup(cell), 9, cell); // get Temporary group of cell
  for i := 0 to Pred(ElementCount(cellchild)) do begin
    r := ElementByIndex(cellchild, i);
    if Signature(r) = 'LAND' then begin
      Result := r;
      Exit;
    end;
  end;
end;

//============================================================================
// returns NAVM or PGRD record for CELL record
function GetPathingForCell(cell: IInterface): IInterface;
var
  cellchild, r: IInterface;
  i: integer;
begin
  cellchild := FindChildGroup(ChildGroup(cell), 9, cell); // get Temporary group of cell
  for i := 0 to Pred(ElementCount(cellchild)) do begin
    r := ElementByIndex(cellchild, i);
    if (Signature(r) = 'NAVM') or (Signature(r) = 'PGRD') then begin
      Result := r;
      Exit;
    end;
  end;
end;

//============================================================================
// Cell X to pixel
function CellX2px(x: integer): integer;
begin
  Result := (x + MapSizeX) * CellSizePx;
end;

//============================================================================
// Cell Y to pixel
function CellY2px(y: integer): integer;
begin
  Result := (-y + MapSizeY) * CellSizePx;
end;

//============================================================================
// Game unit (position) X to pixel
function PosX2px(x: single): integer;
begin
  Result := Round((x + MapSizeX * CellSize) * PosSizePx);
end;

//============================================================================
// Game unit (position) Y to pixel
function PosY2px(y: single): integer;
begin
  Result := Round((-y + MapSizeY * CellSize) * PosSizePx);
end;

//============================================================================
// pixel to game unit (position) X
function px2PosX(x: integer): single;
begin
  Result := x / PosSizePx - MapSizeX * CellSize;
end;

//============================================================================
// pixel to game unit (position) Y
function px2PosY(y: integer): single;
begin
  Result := -(y / PosSizePx - MapSizeY * CellSize);
end;

//============================================================================
// game units to X position in pixels for overlay depending on view scale
function OverX(x: single): integer;
begin
  Result := PosX2px(x) * MapViewScale;
end;

//============================================================================
// game units to Y position in pixels for overlay depending on view scale
function OverY(y: single): integer;
begin
  Result := PosY2px(y) * MapViewScale;
end;

//============================================================================
// draw a grid of exterior blocks, subblocks and cells over bitmap with opacity
procedure DrawCellGrid(bmp: TBitmap; Opacity: integer);
var
  x, y, i, j, col: integer;
  r: TRect;
  FontMult: real;
  s: string;
  grid: TBitmap;
begin
  FontMult := (32 div LODLevel)*LODSize/256; // font size multiplier depending on lod level and texture size
  grid := TBitmap.Create;
  try
    // subblock
    grid.SetSize(bmp.Width, bmp.Height);
    grid.Canvas.Font.Color := clWhite;
    grid.Canvas.Font.Style := [fsBold];
    grid.Canvas.Font.Size := Round(FontSizeSubBlock*FontMult);
    col := 0;
    y := -MapSizeY;
    while y < MapSizeY do begin
      x := -MapSizeX;
      while x < MapSizeX do begin
        r := Rect(CellX2Px(x), CellY2Px(y + 8), CellX2Px(x + 8), CellY2px(y));
        if col mod 2 = 0 then
          grid.Canvas.Brush.Color := $606060
        else
          grid.Canvas.Brush.Color := $808080;
        grid.Canvas.FillRect(r);
        s := Format('Sub %d,%d', [(x + 8) div 8 - 1, (y + 8) div 8 - 1]);
        grid.Canvas.TextOut(
          r.Left + (r.Right - r.Left - grid.Canvas.TextWidth(s)) div 2,
          r.Top + (r.Bottom - r.Top - grid.Canvas.TextHeight(s)) div 2,
          s
        );
        x := x + 8;
        Inc(col);
      end;
      y := y + 8;
      Inc(col);
    end;

    // blocks
    grid.Canvas.Font.Size := Round(FontSizeBlock*FontMult);
    grid.Canvas.Font.Style := [];
    grid.Canvas.Pen.Color := $B0B0B0;
    y := -MapSizeY;
    while y < MapSizeY do begin
      x := -MapSizeX;
      while x < MapSizeX do begin
        r := Rect(CellX2Px(x), CellY2Px(y + 32), CellX2Px(x + 32), CellY2px(y));
        s := Format('Block %d,%d', [(x + 32) div 32 - 1, (y + 32) div 32 - 1]);
        grid.Canvas.Brush.Style := bsClear;
        grid.Canvas.TextOut(
          r.Left + (r.Right - r.Left - grid.Canvas.TextWidth(s)) div 2,
          r.Top + (r.Bottom - r.Top - grid.Canvas.TextHeight(s)) div 2,
          s
        );
        // frame
        grid.Canvas.Rectangle(r.Left, r.Top, r.Right, r.Bottom);
        x := x + 32;
      end;
      y := y + 32;
    end;

    // cells
    grid.Canvas.Brush.Style := bsClear;
    grid.Canvas.Font.Style := [fsBold];
    grid.Canvas.Font.Size := Round(FontSizeCell*FontMult);
    y := -MapSizeY;
    while y < MapSizeY do begin
      x := -MapSizeX;
      while x < MapSizeX do begin
        s := Format('%d,%d', [x, y]);
        i := CellX2Px(x) + 3;
        j := CellY2Px(y) - grid.Canvas.TextHeight(s) - 3;
        grid.Canvas.Font.Color := clBlack;
        grid.Canvas.TextOut(i + 1, j + 1, s);
        grid.Canvas.Font.Color := clWhite;
        grid.Canvas.TextOut(i, j, s);
        x := x + 8;
      end;
      y := y + 8;
    end;

    wbAlphaBlend(bmp.Canvas.Handle, 0, 0, bmp.Width, bmp.Height,
      grid.Canvas.Handle, 0, 0, grid.Width, grid.Height, Opacity);
  finally
    grid.Free;
  end;
end;

//============================================================================
// create map from lod texture, requires FormID and EditorID of worldspace
function CreateWorldspaceMap(wrld: IInterface; bmpMap: TBitMap): Boolean;
var
  wrldFormID, x, y, bmpx, bmpy: integer;
  SWx, SWy: integer;
  wrldEDID, texName: string;
  bmp: TBitmap;
begin
  Result := False;

  MapWidthPx := (MapSizeX div LODLevel)*2*LODSize; // Map width in pixels
  MapHeightPx := (MapSizeY div LODLevel)*2*LODSize; // Map height in pixels
  CellSizePx := LODSize div LODLevel; // Cell size in pixels
  PosSizePx := CellSizePx / CellSize; // Game unit size in pixels

  wrldFormID := FormID(wrld);
  wrldEDID := EditorID(wrld);
  // determine x,y of SW cell for lod textures
  LODCellSW(wrld, SWx, SWy);
  // round them to map size if less
  while SWx < -MapSizeX do SWx := SWx + LODLevel;
  while SWy < -MapSizeY do SWy := SWy + LODLevel;
  
  bmp := TBitmap.Create;
  try
    bmpMap.SetSize((MapSizeX div LODLevel)*2*LODSize, (MapSizeY div LODLevel)*2*LODSize);
    bmpMap.Canvas.Brush.Color := ColorBackground;
    bmpMap.Canvas.FillRect(Rect(0, 0, bmpMap.Width, bmpMap.Height));
    y := SWy;
    while y < MapSizeY do begin
      x := SWx;
      while x < MapSizeX do begin
        texName := LODTextureFileName(wbGameMode, wrldFormID, wrldEDID, x, y, LODLevel, fMapNormals);
        if ResourceExists(texName) then begin
          if wbDDSDataToBitmap(ResourceOpenData('', texName), bmp) then begin
            Result := True;
            if wbGameMode = gmTES4 then begin
              bmpx := CellX2px(x);
              bmpy := CellY2px(-y-LODLevel);
            end
            else if (wbGameMode = gmFO3) or (wbGameMode = gmFNV) then begin
              bmpx := CellX2px(-x-LODLevel);
              bmpy := CellY2px(-y-LODLevel);
            end
            else begin
              bmpx := CellX2px(x);
              bmpy := CellY2px(y);
            end;
            // canvas is top left based, lod is bottom left, so subtract lod size
            bmpy := bmpy - LODSize;
            if bmp.Width = LODSize then
              bmpMap.Canvas.Draw(bmpx, bmpy, bmp)
            else
              bmpMap.Canvas.StretchDraw(Rect(bmpx, bmpy, bmpx + LODSize, bmpy + LODSize), bmp);
          end;
        end;
        x := x + LODLevel;
      end;
      y := y + LODLevel;
    end;
  finally
    bmp.Free;
  end;

  if (wbGameMode = gmFO3) or (wbGameMode = gmFNV) then
    wbFlipBitmap(bmpMap, 0) // flip horizontal and vertical
  else if wbGameMode = gmTES4 then
    wbFlipBitmap(bmpMap, 2); // flip vertical
end;
  
//============================================================================
// draws a map for WRLD record
procedure DrawMap(wrld: IInterface);
var
  bmp: TBitmap;
  i, j: integer;
  ent, regns, regn: IInterface;
begin
  bmp := TBitmap.Create;
  bmp.PixelFormat := pf32bit;
  try
    fMapDrawn := CreateWorldSpaceMap(wrld, bmp);
    CurrentWorld := wrld;
    if GridOpacity > 0 then
      DrawCellGrid(bmp, GridOpacity);
    if MapViewScale <> 1 then imgMap.Stretch := True
      else imgMap.Stretch := False;
    imgMap.Width := Round(bmp.Width * MapViewScale);
    imgMap.Height := Round(bmp.Height * MapViewScale);
    imgMap.Picture.Assign(bmp);
    imgOver.Width := imgMap.Width;
    imgOver.Height := imgMap.Height;
    imgOver.Picture.Bitmap.SetSize(imgOver.Width, imgOver.Height);
    miOverlayClearClick(nil);
  finally
    bmp.Free;
  end;
  if not fMapDrawn then
    memoInfo.Lines.Text : = Format('No LOD level %d textures for worldspace %s, try other levels.', [LODLevel, Name(wrld)]);
  frmMain.Caption := Format('Worldspace Browser - %s %dx%d', [Name(wrld), imgMap.Width, imgMap.Height]);
  frmMainFormResize(nil);

  // list of overriding plugins
  slPlugin.Clear;
  for i := 0 to Pred(OverrideCount(wrld)) do begin
    ent := OverrideByIndex(wrld, i);
    slPlugin.AddObject(Name(GetFile(ent)), ent);
  end;
  miCell.Enabled := (slPlugin.Count > 0);

  // list of regions
  slRegion.Clear;
  for i := Pred(FileCount) downto 0 do begin
    regns := GroupBySignature(FileByIndex(i), 'REGN');
    for j := 0 to Pred(ElementCount(regns)) do begin
      regn := ElementByIndex(regns, j);
      if SameText(GetElementEditValues(regn, 'WNAM'), Name(CurrentWorld)) and ElementExists(regn, 'Region Areas') then
        slRegion.AddObject(EditorID(regn), regn);
    end;
  end;
end;

//============================================================================
// resize event for main form
procedure frmMainFormResize(Sender: TObject);
var
  a: integer;
begin
  if not fMapDrawn then Exit;
  sbxMap.HorzScrollBar.Position := 0;
  sbxMap.VertScrollBar.Position := 0;
  a := (sbxMap.Width - imgMap.Width) div 2;
  if a < 0 then a := 0;
  imgMap.Left := a;
  a := (sbxMap.Height - imgMap.Height) div 2;
  if a < 0 then a := 0;
  imgMap.Top := a;
  imgOver.Left := imgMap.Left;
  imgOver.Top := imgMap.Top;
end;

//============================================================================
function CreateLabel(aForm: TForm; aText: string; aLeft, aTop: integer): TLabel;
begin
  Result := TLabel.Create(aForm);
  Result.Parent := aForm;
  Result.Caption := aText;
  Result.Left := aLeft; Result.Top := aTop;
end;

//============================================================================
function CreateComboList(aForm: TForm; aLeft, aTop, aWidth: integer): TComboBox;
begin
  Result := TComboBox.Create(aForm);
  Result.Parent := aForm;
  Result.Style := csDropDownList; Result.DropDownCount := 20;
  Result.Left := aLeft; Result.Top := aTop; Result.Width := aWidth;
end;

//============================================================================
procedure miWorldspaceClick(Sender: TObject);
var
  s: string;
begin
  cmbWorld.ItemIndex := cmbWorld.Items.IndexOf(EditorID(CurrentWorld));
  if frmWorld.ShowModal = mrOk then begin
    if cmbWorld.ItemIndex = -1 then
      Exit;
    s := cmbMapSize.Text;
    MapSizeX := StrToIntDef(Copy(s, 1, Pos('x', s)-1), 128) div 2;
    MapSizeY := StrToIntDef(Copy(s, Pos('x', s)+1, 3), 128) div 2;
    LODLevel := StrToInt(cmbLODLevel.Text);
    LODSize := StrToInt(cmbLODSize.Text);
    MapViewScale := StrToInt(cmbScale.Text)/100;
    GridOpacity := StrToIntDef(cmbGrid.Text, 0);
    fMapNormals := chkNormals.Checked;
    DrawMap(ObjectToElement(cmbWorld.Items.Objects[cmbWorld.ItemIndex]));
  end;
end;

//============================================================================
// save map as separate lod textures to be used with landscape lod meshes
procedure miWorldspaceSaveAsLODClick(Sender: TObject);
var
  x, y, lev, cnt: integer;
  tile: TBitmap;
  SrcRect, DestRect: TRect;
  edid, texpath, fname: string;
begin
  //imgMap.Picture.Bitmap.SaveToFile('e:\3\1.bmp'); Exit;
  
  if not InputQuery('Enter', 'Worldspace Editor ID', edid) then Exit;
  if edid = '' then Exit;
  texpath := SelectDirectory('Destination path for LOD textures', '', '', nil);
  if (texpath = '') or not DirectoryExists(texpath) then Exit;
  texpath := IncludeTrailingBackslash(texpath);
  
  cnt := 0;
  tile := TBitmap.Create;
  tile.PixelFormat := pf32bit;
  try
    lev := 32;
    while lev >= 4 do begin
      AddMessage(Format('Savind LOD level %d tiles...', [lev]));
      tile.SetSize(Round(LODSize*lev/32), Round(LODSize*lev/32));
      DestRect := Rect(0, 0, tile.Width, tile.Height);
      y := -MapSizeY;
      while y < MapSizeY do begin
        x := -MapSizeX;
        while x < MapSizeX do begin
          SrcRect := Rect(CellX2Px(x), CellY2Px(y + lev), CellX2Px(x + lev), CellY2px(y));
          tile.Canvas.CopyRect(DestRect, imgMap.Canvas, SrcRect);
          fname := ExtractFileName(LODTextureFileName(gmTES5, 0, edid, x, y, lev, fMapNormals));
          fname := texpath + ChangeFileExt(fname, '.bmp');
          tile.SaveToFile(fname);
          Inc(cnt);
          x := x + lev;
        end;
        y := y + lev;
      end;
      lev := lev div 2;
    end;
    AddMessage(Format('Done. The total number of LOD textures: %d.', [cnt]));
    AddMessage('Use http://www.xnview.com/en/nconvert/ to convert bitmap files to dds format: nconvert.exe -out dds *.bmp');
  finally
    tile.Free;
  end;
end;

//============================================================================
procedure miOverlayClearClick(Sender: TObject);
begin
  imgOver.Canvas.Brush.Color := ColorTransparent;
  imgOver.Canvas.FillRect(Rect(0, 0, imgOver.Picture.Bitmap.Width, imgOver.Picture.Bitmap.Height));
end;

//============================================================================
procedure OverlayRegion(regn: IInterface);
var
  i, j: integer;
  areas, area, points, point: IInterface;
  x, y: real;
begin
  imgOver.Canvas.Pen.Color := clYellow;
  areas := ElementByName(regn, 'Region Areas');
  for i := 0 to Pred(ElementCount(areas)) do begin
    area := ElementByIndex(areas, i);
    points := ElementBySignature(area, 'RPLD');
    for j := 0 to Pred(ElementCount(points)) do begin
      point := ElementByIndex(points, j);
      if j = 0 then begin
        x := OverX(GetElementNativeValues(point, 'X'));
        y := OverY(GetElementNativeValues(point, 'Y'));
        imgOver.Canvas.MoveTo(x, y);
      end else
        imgOver.Canvas.LineTo(OverX(GetElementNativeValues(point, 'X')), OverY(GetElementNativeValues(point, 'Y')));
    end;
    if ElementCount(points) > 0 then
      imgOver.Canvas.LineTo(x, y);
  end;
end;

//============================================================================
procedure OverlayCell(wrld: IInterface);
var
  blockidx, subblockidx, cellidx: integer;
  wrldgrup, block, subblock, cell: IInterface;
  x, y, x1, y1: real;
begin
  imgOver.Canvas.Pen.Color := clYellow;
  wrldgrup := ChildGroup(wrld);
  // traverse Blocks
  for blockidx := 0 to Pred(ElementCount(wrldgrup)) do begin
    block := ElementByIndex(wrldgrup, blockidx);
    // traverse SubBlocks
    for subblockidx := 0 to Pred(ElementCount(block)) do begin
      subblock := ElementByIndex(block, subblockidx);
      // traverse Cells
      for cellidx := 0 to Pred(ElementCount(subblock)) do begin
        cell := ElementByIndex(subblock, cellidx);
        if Signature(cell) <> 'CELL' then Continue;
        if not ElementExists(cell, 'XCLC') then Continue;
        x := OverX(GetElementNativeValues(cell, 'XCLC\X')*CellSize);
        y := OverY(GetElementNativeValues(cell, 'XCLC\Y')*CellSize);
        x1 := x + CellSizePx*MapViewScale;
        y1 := y + CellSizePx*MapViewScale;
        if Assigned(GetLandscapeForCell(cell)) then
          imgOver.Canvas.Pen.Style := psSolid // landscape overrides shown as solid rect
        else
          imgOver.Canvas.Pen.Style := psDot; // cell only override shown as dotted rect
        imgOver.Canvas.MoveTo(x, y);
        imgOver.Canvas.LineTo(x1, y);
        imgOver.Canvas.LineTo(x1, y1);
        imgOver.Canvas.LineTo(x, y1);
        imgOver.Canvas.LineTo(x, y);
        if Assigned(GetPathingForCell(cell)) then begin
          imgOver.Canvas.Pen.Style := psDot;
          imgOver.Canvas.MoveTo(x, y);
          imgOver.Canvas.LineTo(x1, y1);
          imgOver.Canvas.MoveTo(x, y1);
          imgOver.Canvas.LineTo(x1, y);
        end;
      end;
    end;
  end;
end;

//============================================================================
procedure miRegionClick(Sender: TObject);
var
  frm: TForm;
  clb: TCheckListBox;
  i: integer;
begin
  frm := frmFileSelect;
  try
    frm.Caption := 'Region';
    clb := TCheckListBox(frm.FindComponent('CheckListBox1'));
    clb.Items.Assign(slRegion);
    if frm.ShowModal <> mrOk then Exit;
    for i := 0 to Pred(clb.Items.Count) do
      if clb.Checked[i] then
        OverlayRegion(ObjectToElement(slRegion.Objects[i]));
  finally
    frm.Free;
  end;
end;

//============================================================================
procedure miCellClick(Sender: TObject);
var
  frm: TForm;
  clb: TCheckListBox;
  i: integer;
begin
  frm := frmFileSelect;
  try
    frm.Caption := 'Overriding plugins';
    clb := TCheckListBox(frm.FindComponent('CheckListBox1'));
    clb.Items.Assign(slPlugin);
    if frm.ShowModal <> mrOk then Exit;
    for i := 0 to Pred(clb.Items.Count) do
      if clb.Checked[i] then
        OverlayCell(ObjectToElement(slPlugin.Objects[i]));
  finally
    frm.Free;
  end;
end;

//============================================================================
// create forms
procedure BuildForms;
var
  btn: TButton;
  i, j: integer;
  sl: TStringList;
  wrlds, wrld: IInterface;
begin
  frmMain := TForm.Create(nil);
  frmMain.Caption := 'Worldspace Browser';
  frmMain.Width := 900;
  frmMain.Height := 650;
  frmMain.Position := poMainFormCenter;
  frmMain.KeyPreview := True;
  frmMain.OnResize := frmMainFormResize;
  //frmMain.OnKeyDown := FormKeyDown;

  mnMain := TMainMenu.Create(frmMain);
  mnMain.AutoHotKeys := maManual;
  miWorldspace := TMenuItem.Create(mnMain);
  miWorldspace.Caption := 'Wordspace';
  mnMain.Items.Add(miWorldspace);
  miOverlay := TMenuItem.Create(mnMain);
  miOverlay.Caption := 'Overlay';
  mnMain.Items.Add(miOverlay);
  
  mi := TMenuItem.Create(mnMain);
  mi.Caption := 'Select';
  mi.OnClick := miWorldspaceClick;
  miWorldspace.Add(mi);
  mi := TMenuItem.Create(mnMain);
  mi.Caption := 'Save as LOD tiles';
  mi.OnClick := miWorldspaceSaveAsLODClick;
  miWorldspace.Add(mi);
  

  miRegion := TMenuItem.Create(mnMain);
  miRegion.Caption := 'Region';
  miRegion.OnClick := miRegionClick;
  miOverlay.Add(miRegion);

  miCell := TMenuItem.Create(mnMain);
  miCell.Caption := 'Cell overrides';
  miCell.OnClick := miCellClick;
  miOverlay.Add(miCell);

  mi := TMenuItem.Create(mnMain); mi.Caption := '-'; miOverlay.Add(mi);
  mi := TMenuItem.Create(mnMain);
  mi.Caption := 'Clear';
  mi.OnClick := miOverlayClearClick;
  miOverlay.Add(mi);
  
  memoInfo := TMemo.Create(frmMain);
  memoInfo.Parent := frmMain;
  memoInfo.Height := 60;
  memoInfo.Align := alBottom;
  memoInfo.Color := clBtnFace;
  memoInfo.ReadOnly := True;

  sbxMap := TScrollBox.Create(frmMain);
  sbxMap.Parent := frmMain;
  sbxMap.Align := alClient;
  sbxMap.BorderStyle := bsNone;
  sbxMap.Color := ColorBackground;
  sbxMap.HorzScrollBar.Increment := 1;
  sbxMap.HorzScrollBar.Tracking := True;
  sbxMap.VertScrollBar.Increment := 1;
  sbxMap.VertScrollBar.Tracking := True;
  
  imgMap := TImage.Create(frmMain);
  imgMap.Parent := sbxMap;
  imgOver := TImage.Create(frmMain);
  imgOver.Parent := sbxMap;
  imgOver.Picture.Bitmap.TransparentColor := ColorTransparent;
  imgOver.Transparent := True;
  miOverlayClearClick(nil);
  
  // worldspace select window
  frmWorld := TForm.Create(nil);
  frmWorld.Caption := 'Worldspace';
  frmWorld.BorderStyle := bsDialog;
  frmWorld.Position := poMainFormCenter;
  frmWorld.Width := 265; frmWorld.Height := 265;
  CreateLabel(frmWorld, 'Worldspaces with LOD data', 16, 13);
  CreateLabel(frmWorld, 'Map Size', 16, 69);
  CreateLabel(frmWorld, 'LOD Level', 112, 69);
  CreateLabel(frmWorld, 'LOD Tile size', 171, 69);
  CreateLabel(frmWorld, 'Grid Opacity (0 - disabled)', 16, 125);
  CreateLabel(frmWorld, 'View Scale %', 171, 125);
  cmbWorld := CreateComboList(frmWorld, 16, 32, 228);
  cmbMapSize := CreateComboList(frmWorld, 16, 88, 78);
  cmbLODLevel := CreateComboList(frmWorld, 112, 88, 48);
  cmbLODSize := CreateComboList(frmWorld, 171, 88, 73);
  cmbScale := CreateComboList(frmWorld, 171, 144, 73);
  cmbGrid := CreateComboList(frmWorld, 16, 144, 78);
  chkNormals := TCheckBox.Create(frmWorld); chkNormals.Parent := frmWorld; chkNormals.Left := 16; chkNormals.Top := 181;
  chkNormals.Width := 89; chkNormals.Caption := 'Normal maps';
  btn := TButton.Create(frmWorld); btn.Parent := frmWorld; btn.Left := 92; btn.Top := 204; btn.Width := 73;
  btn.Caption := 'Cancel'; btn.ModalResult := mrCancel;
  btn := TButton.Create(frmWorld); btn.Parent := frmWorld; btn.Left := 171; btn.Top := 204; btn.Width := 73;
  btn.Caption := 'OK'; btn.ModalResult := mrOk;
  for i := 1 to 4 do
    for j := 1 to 4 do
      cmbMapSize.Items.Add(Format('%dx%d', [i*64, j*64]));
  if wbGameMode = gmTES4 then
    cmbLODLevel.Items.Text := '32' // Oblivion uses only 32
  else
    cmbLODLevel.Items.Text := '4'#13'8'#13'16'#13'32';
  cmbLODSize.Items.Text := '256'#13'512'#13'1024'#13'2048'#13'4096';
  for i := 1 to 6 do
    cmbScale.Items.Add(IntToStr(i*25));
  for i := 0 to 255 do
    cmbGrid.Items.Add(IntToStr(i));
  cmbMapSize.ItemIndex := cmbMapSize.Items.IndexOf(Format('%dx%d', [MapSizeX+MapSizeX, MapSizeY+MapSizeY]));
  cmbLODLevel.ItemIndex := cmbLODLevel.Items.IndexOf(IntToStr(LODLevel));
  cmbLODSize.ItemIndex := cmbLODSize.Items.IndexOf(IntToStr(LODSize));
  cmbScale.ItemIndex := cmbScale.Items.IndexOf(IntToStr(Round(MapViewScale*100)));
  cmbGrid.ItemIndex := cmbGrid.Items.IndexOf(IntToStr(GridOpacity));
  chkNormals.Checked := fMapNormals;
  // filling list of worldspaces
  sl := TStringList.Create;
  try
    sl.Duplicates := dupIgnore;
    sl.Sorted := True;
    for i := Pred(FileCount) downto 0 do begin
      wrlds := GroupBySignature(FileByIndex(i), 'WRLD');
      for j := 0 to Pred(ElementCount(wrlds)) do begin
        wrld := ElementByIndex(wrlds, j);
        if HasLOD(wrld) then
          sl.AddObject(EditorID(wrld), MasterOrSelf(wrld));
      end;
    end;
    cmbWorld.Items.Assign(sl);
  finally
    sl.Free;
  end;
end;

//============================================================================
// initialize variables
procedure InitBrowser;
begin
  MapSizeX := 64;
  MapSizeY := 64;
  LODLevel := 32;
  LODSize := 256; // default lod texture size for level 32
  MapViewScale := 1;
  GridOpacity := 75;
  fMapNormals := False;
  if wbGameMode = gmTES4 then begin
    LODSize := 1024; // Oblivion uses 1024x1024 lod textures only
    MapViewScale := 0.5; // scale them down since they are huge
  end;
end;

//============================================================================
function Initialize: integer;
var
  wrld: IInterface;
begin
  InitBrowser;
  try
    slRegion := TStringList.Create;
    slRegion.Duplicates := dupIgnore;
    slRegion.Sorted := True;
    slPlugin := TStringList.Create;
    BuildForms;
    if wbGameMode = gmFNV then
      wrld := RecordByFormID(FileByIndex(0), $000DA726, False)
    else
      wrld := RecordByFormID(FileByIndex(0), $0000003C, False);
    if Assigned(wrld) and HasLOD(wrld) then
      DrawMap(wrld);
    frmMain.ShowModal;
  finally
    frmWorld.Free;
    frmMain.Free;
    slRegion.Free;
    slPlugin.Free;
  end;

  Result := 1;
end;

end.
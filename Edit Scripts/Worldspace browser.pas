{
  Worldspace Browser v0.2 for Oblivion, Fallout 3, New Vegas, Skyrim.
  Hotkey: Alt+F3
  
  Reconstructs worldspace map from distand LOD (level of detail) landscape textures.
  Push and hold left mouse button to pan map.
  Menu actions:
    Worldspace \ Select - draw a map for selected worldspace
    Worldspace \ Save as Image - save map as a single large image
    Worldspace \ Save as LOD Tiles - split map image back into separate LOD textures used by a game (Skyrim's format)
    Worldspace \ Load Image - load bitmap image, for example to be split by previous function after adjusting with graphical editors
    Overlay \ Region - draw selected regions
    Overlay \ Map Marker - draw selected map marker types
    Overlay \ Base Object References - draw references of selected objects in the current worldspace
    Overlay \ Cell Overrides - draw worldspace overrides for selected plugins
      dotted square: cell record (CELL) is overridden
      solid square: landspace record (LAND) in this cell is added or overridden
      dotted cross: navmesh or pathgrid records (NAVM or PGRD) in this cell are added or overridden
    Overlay \ Change Color - select color to be used by overlay drawing functions
    Overlay \ Clear - clear all overlayed objects
}
unit WorldspaceBrowser;

const
  CellSize = 4096;
  ColorBackground = $000000; // background map color RGB
  ColorTransparent = $000001; // transparent color for overlay
  ColorOverlayDefault = clYellow; // default overlay drawing color
  OverlaySizeReference = 3; // drawing size of reference
  // font sizes for lod level 32, automatically scaled for other lod levels
  FontSizeBlock = 20;
  FontSizeSubBlock = 7;
  FontSizeCell = 5;
  FontSizeMapMarker = 7;

var
  MapSizeX, MapSizeY: integer;
  LODLevel, LODSize: integer;
  MapWidthPx, MapHeightPx, CellSizePx: integer;
  PosSizePx, MapViewScale, FontMult: real;
  GridOpacity: integer;
  fMapDrawn, fMapNormals: boolean;
  CurrentWorld: IInterface;
  slPlugin, slRegion, slWorldspaces: TStringList;

  frmMain, frmWorld: TForm;
  mnMain: TMainMenu;
  mi, miWorldspace, miOverlay, miRegion, miCell, miMapMarker, miReferences: TMenuItem;
  sbInfo: TStatusBar;
  sbxMap: TScrollBox;
  imgMap, imgOver: TImage;
  cmbWorld, cmbMapSize, cmbLODLevel, cmbLODSize, cmbScale, cmbGrid: TComboBox;
  chkNormals: TCheckBox;
  PanningX, PanningY: integer;
  ColorOverlay: integer;


  
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
// get cell record by X,Y grid coordinates from worldspace
procedure GetCellFromWorldspace(Worldspace: IInterface; CellX, CellY: integer);
var
  blockidx, subblockidx, cellidx: integer;
  wrldgrup, block, subblock, cell: IInterface;
  BlockName, SubBlockName: string;
begin
  BlockName := Format('Block %d, %d', [(CellX + 32) div 32 - 1, (CellY + 32) div 32 - 1]);
  SubBlockName := Format('Sub-Block %d, %d', [(CellX + 8) div 8 - 1, (CellY + 8) div 8 - 1]);
  wrldgrup := ChildGroup(Worldspace);
  // iterate over Exterior Blocks
  for blockidx := 0 to Pred(ElementCount(wrldgrup)) do begin
    block := ElementByIndex(wrldgrup, blockidx);
    if ShortName(block) <> BlockName then Continue;
    // iterate over SubBlocks
    for subblockidx := 0 to Pred(ElementCount(block)) do begin
      subblock := ElementByIndex(block, subblockidx);
      if ShortName(subblock) <> SubBlockName then Continue;
      // iterate over Cells
      for cellidx := 0 to Pred(ElementCount(subblock)) do begin
        cell := ElementByIndex(subblock, cellidx);
        if (Signature(cell) <> 'CELL') or GetIsPersistent(cell) then Continue;
        if (GetElementNativeValues(cell, 'XCLC\X') = CellX) and (GetElementNativeValues(cell, 'XCLC\Y') = CellY) then begin
          Result := cell;
          Exit;
        end;
      end;
      Break;
    end;
    Break;
  end;
end;

//============================================================================
// check if reference belongs to current worldspace or it's children worldspaces
function IsReferenceInWorldspace(refr: IInterface): Boolean;
begin
  Result := slWorldspaces.IndexOf(IntToHex(FormID(LinksTo(ElementByName(LinksTo(ElementByName(refr, 'Cell')), 'Worldspace'))), 8)) <> -1;
end;

//============================================================================
// Game units position to Cell
function Pos2Cell(p: double): integer;
begin
  Result := Floor(p/CellSize);
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
  s: string;
  grid: TBitmap;
begin
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
// create map from lod textures, requires FormID and EditorID of worldspace
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
  FontMult := (32 div LODLevel)*LODSize/256; // font size multiplier depending on lod level and texture size

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
// draw a map for WRLD record
procedure DrawMap(wrld: IInterface);
var
  bmp: TBitmap;
  i, j, k: integer;
  ents, ent, w, regns, regn: IInterface;
begin
  bmp := TBitmap.Create;
  bmp.PixelFormat := pf32bit;
  try
    fMapDrawn := CreateWorldSpaceMap(wrld, bmp);
    CurrentWorld := wrld;
    // draw grid if grid's opacity is not zero
    if GridOpacity > 0 then
      DrawCellGrid(bmp, GridOpacity);
    // stretch TImage of map if scale is not 100%
    if MapViewScale <> 1 then imgMap.Stretch := True
      else imgMap.Stretch := False;
    // adjust sise of map TImage depending on scale
    imgMap.Width := Round(bmp.Width * MapViewScale);
    imgMap.Height := Round(bmp.Height * MapViewScale);
    // draw a map on TImage
    imgMap.Picture.Assign(bmp);
    // adjust overlay TImage to match map TImage
    imgOver.Width := imgMap.Width;
    imgOver.Height := imgMap.Height;
    imgOver.Picture.Bitmap.SetSize(imgOver.Width, imgOver.Height);
    // clear overlay
    miOverlayClearClick(nil);
  finally
    bmp.Free;
  end;
  if not fMapDrawn then
    ShowMessage(Format('No LOD level %d textures for worldspace %s, try other levels.', [LODLevel, Name(wrld)]));
  frmMain.Caption := Format('%sEdit Worldspace Browser - %s %dx%d', [wbAppName, Name(wrld), imgMap.Width, imgMap.Height]);
  frmMainFormResize(nil);
  sbInfo.SimpleText := '';
  
  // collect additional data about selected worldspace used by overlaying functions
  
  // list of worldspaces including current worldspace and it's children worldspaces flagged "use land data" (except Oblivion, no flags there)
  // list of overriding plugins for worldspaces
  slPlugin.Clear;
  slWorldspaces.Clear;
  slWorldspaces.AddObject(IntToHex(FormID(wrld), 8), wrld);
  for k := 0 to Pred(OverrideCount(wrld)) do begin
    w := OverrideByIndex(wrld, k);
    slPlugin.AddObject(Name(GetFile(w)), w);
  end;
  for i := 0 to Pred(FileCount) do begin
    ents := GroupBySignature(FileByIndex(i), 'WRLD');
    for j := 0 to Pred(ElementCount(ents)) do begin
      ent := ElementByIndex(ents, j);
      if FormID(wrld) = FormID(LinksTo(ElementByPath(ent, 'Parent\WNAM'))) then
        if (wbGameMode = gmTES4) or (GetElementNativeValues(ent, 'Parent\PNAM\Flags') and 1 = 1) then begin
          slWorldspaces.AddObject(IntToHex(FormID(ent), 8), ent);
          for k := 0 to Pred(OverrideCount(ent)) do begin
            w := OverrideByIndex(ent, k);
            if slPlugin.IndexOf(Name(GetFile(w))) = -1 then
              slPlugin.AddObject(Name(GetFile(w)), w);
          end;
        end;
    end;
  end;
  miCell.Enabled := (slPlugin.Count > 0);

  // list of regions with points data
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
// draw a region on overlay
procedure OverlayRegion(regn: IInterface);
var
  i, j, x, y: integer;
  areas, area, points, point: IInterface;
begin
  imgOver.Canvas.Pen.Color := ColorOverlay;
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
// draw a map marker (REFR record type) on overlay
procedure OverlayMapMarker(refr: IInterface);
var
  x, y, r: real;
  s: string;
begin
  // getting marker position
  imgOver.Canvas.Pen.Color := ColorOverlay;
  x := GetElementNativeValues(refr, 'DATA\Position\X');
  y := GetElementNativeValues(refr, 'DATA\Position\Y');
  // getting marker radius
  if ElementExists(refr, 'XRDS') then r := GetElementNativeValues(refr, 'XRDS')
    else r := 2000;
  // draw marker as a cirle
  imgOver.Canvas.Ellipse(OverX(x-r), OverY(y-r), OverX(x+r), OverY(y+r));
  // draw marker name
  s := GetElementEditValues(refr, 'Map Marker\FULL');
  if s <> '' then begin
    imgOver.Canvas.Font.Color := ColorOverlay;
    imgOver.Canvas.Font.Size := Round(FontSizeMapMarker*FontMult);
    imgOver.Canvas.Font.Style := [fsBold];
    imgOver.Canvas.Brush.Style := bsClear;
    imgOver.Canvas.TextOut(OverX(x+r), OverY(y-r), s);
  end;
end;

//============================================================================
// draw a reference on overlay
procedure OverlayReference(refr: IInterface);
var
  x, y: integer;
begin
  // getting reference position
  x := OverX(GetElementNativeValues(refr, 'DATA\Position\X'));
  y := OverY(GetElementNativeValues(refr, 'DATA\Position\Y'));
  // draw reference
  imgOver.Canvas.Pen.Color := ColorOverlay;
  imgOver.Canvas.Pen.Style := psSolid;
  imgOver.Canvas.MoveTo(x - OverlaySizeReference, y);
  imgOver.Canvas.LineTo(x, y - OverlaySizeReference);
  imgOver.Canvas.LineTo(x + OverlaySizeReference, y);
  imgOver.Canvas.LineTo(x, y + OverlaySizeReference);
  imgOver.Canvas.LineTo(x - OverlaySizeReference, y);
end;

//============================================================================
// draw a cell conflicts on overlay
procedure OverlayCell(wrld: IInterface);
var
  blockidx, subblockidx, cellidx: integer;
  wrldgrup, block, subblock, cell: IInterface;
  x, y, x1, y1: real;
begin
  imgOver.Canvas.Pen.Color := ColorOverlay;
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
        // we are interested in CELLs only
        if Signature(cell) <> 'CELL' then Continue;
        // skip persistent cell
        if GetIsPersistent(cell) then Continue;
        // skip cells without grid position
        if not ElementExists(cell, 'XCLC') then Continue;
        // calculation cell's rectangle on overlay
        x := OverX(GetElementNativeValues(cell, 'XCLC\X')*CellSize);
        y := OverY(GetElementNativeValues(cell, 'XCLC\Y')*CellSize);
        x1 := x + CellSizePx*MapViewScale;
        y1 := y - CellSizePx*MapViewScale;
        // type of rectangle depending on conflict type
        if Assigned(GetLandscapeForCell(cell)) then
          imgOver.Canvas.Pen.Style := psSolid // landscape overrides shown as solid rect
        else
          imgOver.Canvas.Pen.Style := psDot; // cell only override shown as dotted rect
        imgOver.Canvas.MoveTo(x, y);
        imgOver.Canvas.LineTo(x1, y);
        imgOver.Canvas.LineTo(x1, y1);
        imgOver.Canvas.LineTo(x, y1);
        imgOver.Canvas.LineTo(x, y);
        // draw a dotted cross for navmesh/pathgrid conflicts
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
// click event for worldspace select menu
procedure miWorldspaceClick(Sender: TObject);
var
  s: string;
begin
  // setting worldspace combobox to the current drawn worldspace
  cmbWorld.ItemIndex := cmbWorld.Items.IndexOf(EditorID(CurrentWorld));
  // selector form
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
// click event for worldspace load image menu
procedure miWorldspaceLoadImageClick(Sender: TObject);
var
  ImageFileName: string;
  dlgOpen: TSaveDialog;
  bmp: TBitmap;
begin
  dlgOpen := TOpenDialog.Create(nil);
  try
    dlgOpen.Filter := 'Windows Bitmap (*.bmp)|*.bmp';
    dlgOpen.InitialDir := DataPath;
    if dlgOpen.Execute then
      ImageFileName := dlgOpen.FileName;
  finally
    dlgOpen.Free;
  end;
  
  if ImageFileName = '' then
    Exit;

  bmp := TBitmap.Create;
  try
    bmp.LoadFromFile(ImageFileName);
    if bmp.Width = imgMap.Width then
      imgMap.Canvas.Draw(0, 0, bmp)
    else
      imgMap.Canvas.StretchDraw(Rect(0, 0, imgMap.Width, imgMap.Height), bmp);
  finally
    bmp.Free;
  end;
end;

//============================================================================
// click event for worldspace save as image menu
procedure miWorldspaceSaveAsImageClick(Sender: TObject);
var
  dlgSave: TSaveDialog;
begin
  if not fMapDrawn then
    Exit;
    
  dlgSave := TSaveDialog.Create(nil);
  try
    dlgSave.Options := dlgSave.Options + [ofOverwritePrompt];
    dlgSave.Filter := 'Windows Bitmap (*.bmp)|*.bmp';
    dlgSave.InitialDir := DataPath;
    dlgSave.FileName := EditorID(CurrentWorld) + '.bmp';
    if dlgSave.Execute then begin
      imgMap.Picture.Bitmap.SaveToFile(dlgSave.FileName);
    end;
  finally
    dlgSave.Free;
  end;
end;

//============================================================================
// click event for worldspace save as lod tiles menu
// save map as separate lod textures to be used with landscape lod meshes
procedure miWorldspaceSaveAsLODClick(Sender: TObject);
var
  x, y, lev, cnt: integer;
  tile: TBitmap;
  SrcRect, DestRect: TRect;
  edid, texpath, fname: string;
begin
  if not fMapDrawn then
    Exit;
  
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
// click event for overlay region menu
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
// click event for overlay map marker menu
procedure miMapMarkerClick(Sender: TObject);
var
  frm: TForm;
  clb: TCheckListBox;
  i: integer;
  MapMarkerStat, e: IInterface;
  slMarkerType: TStringList;
  s: string;
begin
  if ContainerStates(GetFile(CurrentWorld)) and (1 shl csRefsBuild) = 0 then
    MessageDlg(Format('References are not built for %s, this function won''t work properly. Please use right click "Other\Build Reference Info" menu of %sEdit', [
      GetFileName(GetFile(CurrentWorld)),
      wbAppName
    ]), mtInformation, [mbOk], 0);
  // get MapMarker [STAT:00000010]
  MapMarkerStat := RecordByFormID(FileByIndex(0), $00000010, False);
  // getting the list of all map marker types
  slMarkerType := TStringList.Create;
  slMarkerType.Duplicates := dupIgnore;
  slMarkerType.Sorted := True;
  for i := 0 to Pred(ReferencedByCount(MapMarkerStat)) do begin
    e := ReferencedByIndex(MapMarkerStat, i);
    if not IsReferenceInWorldspace(e) then Continue;
    s := GetElementEditValues(e, 'Map Marker\TNAM\Type');
    if s <> '' then
      slMarkerType.Add(s);
  end;
  
  frm := frmFileSelect;
  try
    frm.Caption := 'Map Marker Type';
    clb := TCheckListBox(frm.FindComponent('CheckListBox1'));
    clb.Items.Assign(slMarkerType);
    if frm.ShowModal <> mrOk then Exit;
    // getting list of checked marker types
    slMarkerType.Clear;
    for i := 0 to Pred(clb.Items.Count) do
      if clb.Checked[i] then
        slMarkerType.Add(clb.Items[i]);
    if slMarkerType.Count > 0 then
      for i := 0 to Pred(ReferencedByCount(MapMarkerStat)) do begin
        e := ReferencedByIndex(MapMarkerStat, i);
        if not IsReferenceInWorldspace(e) then Continue;
        s := GetElementEditValues(e, 'Map Marker\TNAM\Type');
        if slMarkerType.IndexOf(s) <> -1 then
          OverlayMapMarker(e);
      end;
  finally
    frm.Free;
    slMarkerType.Free;
  end;
end;

//============================================================================
// click event for overlay base object references menu
procedure miReferencesClick(Sender: TObject);
var
  frm: TForm;
  clb: TCheckListBox;
  i, j, k: integer;
  grp, ent, baseobj: IInterface;
  slBaseObject: TStringList;
  s: string;
begin
  if ContainerStates(GetFile(CurrentWorld)) and (1 shl csRefsBuild) = 0 then
    MessageDlg(Format('References are not built for %s, this function won''t work properly. Please use right click "Other\Build Reference Info" menu of %sEdit', [
      GetFileName(GetFile(CurrentWorld)),
      wbAppName
    ]), mtInformation, [mbOk], 0);

  // first ask for base object types
  slBaseObject := TStringList.Create;
  slBaseObject.Duplicates := dupIgnore;
  slBaseObject.Sorted := True;
  frm := frmFileSelect;
  try
    frm.Width := 500;
    frm.Caption := 'Base Object Type';
    clb := TCheckListBox(frm.FindComponent('CheckListBox1'));
    GetRecordDefNames(clb.Items);
    if frm.ShowModal <> mrOk then
      Exit;

    // iterate through selected signatures
    for i := 0 to Pred(clb.Items.Count) do
      if clb.Checked[i] then begin
        s := Copy(clb.Items[i], 1, 4); // signature
        // iterate through loaded plugins
        for j := 0 to Pred(FileCount) do begin
          grp := GroupBySignature(FileByIndex(j), s);
          // iterate through records
          for k := 0 to Pred(ElementCount(grp)) do begin
            ent := ElementByIndex(grp, k);
            // adding only master records to skip overrides
            if IsMaster(ent) then begin
              // but actually adding the last winning override
              ent := WinningOverride(ent);
              slBaseObject.AddObject(Name(ent), ent);
            end;
          end;
        end;
      end;

    if slBaseObject.Count = 0 then
      Exit;
      
    clb.Items.Assign(slBaseObject);
    frm.Caption := 'Base Object';
    if frm.ShowModal <> mrOk then
      Exit;

    for i := 0 to Pred(clb.Items.Count) do
      if clb.Checked[i] then begin
        baseobj := ObjectToElement(clb.Items.Objects[i]);
        for j := 0 to Pred(ReferencedByCount(baseobj)) do begin
          ent := ReferencedByIndex(baseobj, j);
          if IsReferenceInWorldspace(ent) then
            OverlayReference(ent);
        end;
      end;

  finally
    frm.Free;
    slBaseObject.Free;
  end;
end;

//============================================================================
// click event for overlay cell overrides menu
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
// click event for overlay change color menu
procedure miOverlayChangeColorClick(Sender: TObject);
var
  dlgColor: TColorDialog;
begin
  dlgColor := TColorDialog.Create(frmMain);
  try
    dlgColor.Options := [cdFullOpen, cdAnyColor];
    dlgColor.Color := ColorOverlay;
    if dlgColor.Execute then
      ColorOverlay := dlgColor.Color;
  finally
    dlgColor.Free;
  end;
end;

//============================================================================
// click event for overlay clear menu
procedure miOverlayClearClick(Sender: TObject);
begin
  imgOver.Canvas.Brush.Color := ColorTransparent;
  imgOver.Canvas.FillRect(Rect(0, 0, imgOver.Picture.Bitmap.Width, imgOver.Picture.Bitmap.Height));
end;

//============================================================================
// on mouse down event
procedure imgOverMouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  // start of mouse panning, store cursor position
  PanningX := X;
  PanningY := Y;
end;

//============================================================================
// on mouse up event
procedure imgOverMouseUp(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  PanningX := -1;
end;

//============================================================================
// on mouse move event
procedure imgOverMouseMove(Sender: TObject; Shift: TShiftState; X,
  Y: Integer);
var
  dX, dY: integer;
begin
  // Panning map view with mouse while left mouse button is pressed
  if Shift = [ssLeft] then begin
    if PanningX = -1 then Exit;
    // delta
    dX := PanningX - X;
    dY := PanningY - Y;
    // scrollbars range is 0..Range
    if sbxMap.HorzScrollBar.Position + dX < 0 then dX := -sbxMap.HorzScrollBar.Position else
      if sbxMap.HorzScrollBar.Position + dX > sbxMap.HorzScrollBar.Range then dX := sbxMap.HorzScrollBar.Range - sbxMap.HorzScrollBar.Position;
    if sbxMap.VertScrollBar.Position + dY < 0 then dY := -sbxMap.VertScrollBar.Position else
      if sbxMap.VertScrollBar.Position + dY > sbxMap.VertScrollBar.Range then dY := sbxMap.VertScrollBar.Range - sbxMap.VertScrollBar.Position;
    sbxMap.HorzScrollBar.Position := sbxMap.HorzScrollBar.Position + dX;
    sbxMap.VertScrollBar.Position := sbxMap.VertScrollBar.Position + dY;
    // save current mouse position modified by deltas
    PanningX := X + dX;
    PanningY := Y + dY;
  end
  else if fMapDrawn then begin
    sbInfo.SimpleText := Format('Cell: %d, %d   Position: %.0n, %.0n', [Pos2Cell(px2PosX(X)), Pos2Cell(px2PosY(Y)), px2PosX(X), px2PosY(Y)]);
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
// create forms
procedure BuildForms;
var
  btn: TButton;
  i, j: integer;
  sl: TStringList;
  wrlds, wrld: IInterface;
begin
  frmMain := TForm.Create(nil);
  frmMain.Caption := wbAppName + 'Edit Worldspace Browser';
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
  mi.ShortCut := TextToShortCut('F3');
  mi.OnClick := miWorldspaceClick;
  miWorldspace.Add(mi);

  mi := TMenuItem.Create(mnMain);
  mi.Caption := 'Load Image';
  mi.OnClick := miWorldspaceLoadImageClick;
  miWorldspace.Add(mi);

  mi := TMenuItem.Create(mnMain);
  mi.Caption := 'Save as Image';
  mi.OnClick := miWorldspaceSaveAsImageClick;
  miWorldspace.Add(mi);

  mi := TMenuItem.Create(mnMain);
  mi.Caption := 'Save as LOD Tiles';
  mi.OnClick := miWorldspaceSaveAsLODClick;
  miWorldspace.Add(mi);
  
  miRegion := TMenuItem.Create(mnMain);
  miRegion.Caption := 'Region';
  miRegion.ShortCut := TextToShortCut('Alt+R');
  miRegion.OnClick := miRegionClick;
  miOverlay.Add(miRegion);

  miMapMarker := TMenuItem.Create(mnMain);
  miMapMarker.Caption := 'Map Marker';
  miMapMarker.ShortCut := TextToShortCut('Alt+M');
  miMapMarker.OnClick := miMapMarkerClick;
  miOverlay.Add(miMapMarker);

  miReferences := TMenuItem.Create(mnMain);
  miReferences.Caption := 'Base Object References';
  miReferences.ShortCut := TextToShortCut('Alt+B');
  miReferences.OnClick := miReferencesClick;
  miOverlay.Add(miReferences);

  miCell := TMenuItem.Create(mnMain);
  miCell.Caption := 'Cell Overrides';
  miCell.ShortCut := TextToShortCut('Alt+O');
  miCell.OnClick := miCellClick;
  miOverlay.Add(miCell);

  mi := TMenuItem.Create(mnMain); mi.Caption := '-'; miOverlay.Add(mi);

  mi := TMenuItem.Create(mnMain);
  mi.Caption := 'Change Color';
  mi.ShortCut := TextToShortCut('Alt+C');
  mi.OnClick := miOverlayChangeColorClick;
  miOverlay.Add(mi);

  mi := TMenuItem.Create(mnMain);
  mi.Caption := 'Clear';
  mi.ShortCut := TextToShortCut('F8');
  mi.OnClick := miOverlayClearClick;
  miOverlay.Add(mi);
  
  sbInfo := TStatusBar.Create(frmMain);
  sbInfo.Parent := frmMain;
  sbInfo.SimplePanel := True;

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
  imgOver.OnMouseDown := imgOverMouseDown;
  imgOver.OnMouseUp := imgOverMouseUp;
  imgOver.OnMouseMove := imgOverMouseMove;
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
  cmbLODSize.Items.Text := '128'#13'256'#13'512'#13'1024'#13'2048'#13'4096';
  for i := 1 to 6 do
    cmbScale.Items.Add(IntToStr(i*25));
  for i := 0 to 255 div 5 do
    cmbGrid.Items.Add(IntToStr(i*5));
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
  GridOpacity := 0;
  fMapNormals := False;
  if wbGameMode = gmTES4 then begin
    LODSize := 1024; // Oblivion uses 1024x1024 lod textures only
    MapViewScale := 0.5; // scale them down since they are huge
  end;
  ColorOverlay := ColorOverlayDefault;
end;

//============================================================================
function Initialize: integer;
var
  wrld: IInterface;
begin
  InitBrowser;
  try
    slWorldspaces := TStringList.Create; slWorldspaces.Duplicates := dupIgnore; slWorldspaces.Sorted := True;
    slRegion := TStringList.Create; slRegion.Duplicates := dupIgnore; slRegion.Sorted := True;
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
    slWorldspaces.Free;
    slRegion.Free;
    slPlugin.Free;
  end;

  Result := 1;
end;

end.
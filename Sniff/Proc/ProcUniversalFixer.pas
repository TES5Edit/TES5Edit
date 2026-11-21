{******************************************************************************

  This Source Code Form is subject to the terms of the Mozilla Public License,
  v. 2.0. If a copy of the MPL was not distributed with this file, You can obtain
  one at https://mozilla.org/MPL/2.0/.

*******************************************************************************}

unit ProcUniversalFixer;

interface

uses
  System.Classes,
  System.SyncObjs,
  System.SysUtils,

  Vcl.Controls,
  Vcl.Dialogs,
  Vcl.Forms,
  Vcl.StdCtrls,

  SniffProcessor;

type
  TFrameUniversalFixer = class(TFrame)
    memoFix: TMemo;
    chkSaveLog: TCheckBox;
    edLog: TEdit;
    btnBrowse: TButton;
    chkOpenLog: TCheckBox;
    procedure btnBrowseClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

  TProcUniversalFixer = class(TProcBase)
  private
    Frame: TFrameUniversalFixer;
    LogFile: TStringList;
    Sync: TLightweightMREW;
  public
    constructor Create(aManager: TProcManager); override;
    destructor Destroy; override;
    function GetFrame(aOwner: TComponent): TFrame; override;
    procedure OnShow; override;
    procedure OnHide; override;
    procedure OnStart; override;
    procedure OnStop; override;

    function ProcessFile(aFile: TProcFileObject): TBytes; override;
  end;

implementation

{$R *.dfm}

uses
  System.Math,
  System.IOUtils,

  Winapi.ShellAPI,
  Winapi.Windows,

  wbDataFormat,
  wbDataFormatNif;

constructor TProcUniversalFixer.Create(aManager: TProcManager);
begin
  inherited;

  fTitle := 'Universal fixer';
  fSupportedGames := [gtTES3, gtTES4, gtFO3, gtFNV, gtTES5, gtSSE, gtFO4];
  fExtensions := ['nif'];

  LogFile := TStringList.Create;
end;

destructor TProcUniversalFixer.Destroy;
begin
  LogFile.Free;

  inherited;
end;

function TProcUniversalFixer.GetFrame(aOwner: TComponent): TFrame;
begin
  Frame := TFrameUniversalFixer.Create(aOwner);
  Result := Frame;
end;

procedure TFrameUniversalFixer.btnBrowseClick(Sender: TObject);
begin
  var dlg := TFileSaveDialog.Create(Self);
  try
    if dlg.Execute then
      edLog.Text := dlg.FileName;
  finally
    dlg.Free;
  end;
end;

procedure TProcUniversalFixer.OnShow;
begin
  with Frame.memoFix.Lines do begin
    BeginUpdate;
    Clear;
    Add('- Update invalid string indices');
    Add('- Remove empty and invalid links from link arrays (children, extradatas, properties, etc.)');
    Add('- Remove absolute path and double slashes from assets');
    Add('- Remove useless redundant blocks including empty geometry shapes');
    //Add('- Add Hidden flag to EditorMarker blocks in Skyrim meshes');
    Add('- Update BSXFlags, add if missing when needed');
    Add('- Update shaders types and flags');
    Add('- Enforce hardcoded block names like BSX for BSXFlags, assign name for unnamed NiMaterialProperty');
    Add('- Remove controlled blocks in NiControllerSequence pointing to invalid target, sort them by Target node index');
    Add('- Update Extra Targets in NiMultiTargetTransformController');
    Add('- Update NiDefaultAVObjectPalette');
    Add('- Set the Target field in NiCollisionObject descendants and bhkCompressedMeshShape to the parent node');
    Add('- Update collision rigid body settings depending on Havok layer');
    Add('- Update Havok Filters in bhkListShape');
    Add('- Update Consistency Flags value in shapes: CT_MUTABLE for geometries that use NiGeomMorpherController or NiUVController and CT_STATIC for the rest. CT_VOLATILE isn''t used by Bethesda');
    Add('- [SSE] Add Particle Data to mesh emitters if missing');
    EndUpdate;
  end;

  Frame.chkSaveLog.Checked := StorageGetBool('bSaveLog', Frame.chkSaveLog.Checked);
  Frame.chkOpenLog.Checked := StorageGetBool('bOpenLog', Frame.chkOpenLog.Checked);
  Frame.edLog.Text := StorageGetString('sLogFile', Frame.edLog.Text);
end;

procedure TProcUniversalFixer.OnHide;
begin
  StorageSetBool('bSaveLog', Frame.chkSaveLog.Checked);
  StorageSetBool('bOpenLog', Frame.chkOpenLog.Checked);
  StorageSetString('sLogFile', Frame.edLog.Text);
end;

procedure TProcUniversalFixer.OnStart;
begin
  if Frame.chkSaveLog.Checked then begin
    if Frame.edLog.Text = '' then
      raise Exception.Create('Select log file name');

    var dir := ExtractFilePath(Frame.edLog.Text);
    if (dir <> '') and not DirectoryExists(dir) then
      raise Exception.Create('Log file folder doesn''t exist: ' + dir);
  end;

  LogFile.Clear;
end;

procedure TProcUniversalFixer.OnStop;
begin
  if not Frame.chkSaveLog.Checked then
    Exit;

  LogFile.SaveToFile(Frame.edLog.Text);

  if Frame.chkOpenLog.Checked then begin
    var f := Frame.edLog.Text;
    ShellExecute(HInstance, 'open', PChar(f), nil, nil, SW_NORMAL);
  end;
end;


//===========================================================================
function FixStringIndices(const nif: TwbNifFile; const Log: TStrings): Boolean;
begin
  Result := False;

  if nif.NifVersion < nfFO3 then
    Exit;

  var n: Integer := nif.Header.Elements['Num Strings'].NativeValue;

  for var i := 0 to Pred(nif.BlocksCount) do begin
    var block: TwbNifBlock := nif.Blocks[i];
    for var j := 0 to Pred(block.StringsCount) do
      if block.Strings[j].NativeValue >= n then begin
        Log.Add(#9 + block.Strings[j].Path + ': Invalid string index ' + IntToStr(block.Strings[j].NativeValue) + ' set to -1 (None)');
        block.Strings[j].NativeValue := -1;
        Result := True;
      end;
  end;
end;

//===========================================================================
function FixArrayLinks(const nif: TwbNifFile; const Log: TStrings): Boolean;
begin
  Result := False;

  for var links in nif.GetLinkArrays do begin
    // skip fixed length arrays
    if links.Def.Size > 0 then
      Continue;

    for var i := Pred(links.Count) downto 0 do begin
      var n := links[i].NativeValue;
      if n < 0 then begin
        Log.Add(#9 + links[i].Path + ': Removed a null link');
        links.Delete(i);
        Result := True;
      end
      else if n >= nif.BlocksCount then begin
        Log.Add(#9 + links[i].Path + ': Removed a broken link');
        links.Delete(i);
        Result := True;
      end
      else
        for var j := 0 to i - 1 do
          if links[j].NativeValue = n then begin
            Log.Add(#9 + links[i].Path + ': Removed a repeated link');
            links.Delete(i);
            Result := True;
            Break;
          end;
    end;
  end;
end;

//===========================================================================
function FixAbsolutePaths(const nif: TwbNifFile; const Log: TStrings): Boolean;
const
  SubFolders: array [0..8] of string = (
    '\meshes\', '\textures\', '\materials\',
     '/meshes/', '/textures/', '/materials/',
     '\data\', '/data/', '\data files\');
begin
  Result := False;

  for var el in Nif.GetAssets do begin
    var assetname := el.EditValue;
    var newname := assetname;

    var delim := '';

    // beth slop
    if Pos(#8'NOR', newname) <> 0 then
      newname := '';

    // remove invalid chars
    for var i := High(newname) downto Low(newname) do
      if CharInSet(newname[i], [
        #0, #1, #2, #3, #4, #5, #6, #7, #8, #9, #10, #11, #12, #13, #14, #15, #16,
        #17, #18, #19, #20, #21, #22, #23, #24, #25, #26, #27, #28, #29, #30, #31
      ]) then
        Delete(newname, i, 1);

    // detecting used delimiter
    // edge case when path contains both slashes \ and /, don't even ask why...
    if (Pos('\', newname) <> 0) and (Pos('/', newname) <> 0) then begin
      delim := '\';
      newname := StringReplace(newname, '/', delim, [rfReplaceAll]);
    end else
      if Pos('/', newname) <> 0 then delim := '/' else delim := '\';

    // fix double slashes
    newname := StringReplace(newname, delim + delim, delim, [rfReplaceAll]);

    // fix absolute paths
    if TPath.IsPathRooted(newname) then begin
      // try to remove path up to the asset subfolder
      var bFixed := False;
      for var subfolder in SubFolders do begin
        var p := Pos(subfolder, LowerCase(newname));
        if p = 0 then Continue;

        newname := Copy(newname, p + 1{Length(subfolder)}, Length(newname));
        bFixed := True;
        Break;
      end;

      // couldn't fix, issue warning
      if not bFixed then begin
        Log.Add(#9 + el.Path + ': Couldn''t fix absolute path "' + assetname + '"');
        Continue;
      end;
    end

    // dds textures must start with 'textures' subfolder or 'data\textures'
    else if (nif.NifVersion > nfTES3)
      and newname.EndsWith('.dds', True)
      and not (newname.StartsWith('textures' + delim, True) or newname.StartsWith('data' + delim + 'textures' + delim, True))
    then
      newname := 'textures' + delim + newname;

    if assetname <> newname then begin
      Log.Add(#9 + el.Path + ': Path changed from "' + assetname + '" to "' + newname + '"');
      el.EditValue := newname;
      Result := True;
    end;
  end;
end;

//===========================================================================
function FixEditorMarker(const nif: TwbNifFile; const Log: TStrings): Boolean;
begin
  Result := False;

  if nif.NifVersion < nfFO3 then
    Exit;

  for var i: Integer := 0 to Pred(nif.BlocksCount) do begin
    var block := nif.Blocks[i];
    if block.IsEditorMarker and Assigned(block.Elements['Flags']) then
      if (nif.NifVersion in [nfTES5, nfSSE]) and not block.Hidden then begin
        block.NativeValues['Flags'] := block.NativeValues['Flags'] or 1;
        Log.Add(#9 + block.Name + ': Added Hidden flag to EditorMarker');
        Result := True;
      end else
      if (nif.NifVersion in [nfFO3]) and block.Hidden then begin
        block.NativeValues['Flags'] := block.NativeValues['Flags'] and not 1;
        Log.Add(#9 + block.Name + ': Removed Hidden flag from EditorMarker');
        Result := True;
      end
  end;
end;

//===========================================================================
function FixBSXFlags(const nif: TwbNifFile; const Log: TStrings): Boolean;
begin
  Result := False;

  if nif.NifVersion < nfFO3 then
    Exit;

  if nif.BlocksCount = 0 then
    Exit;

  var flags := nif.DetectBSXFlags;

  var bsx := nif.BlockByType('BSXFlags');
  if not Assigned(bsx) then begin
    // if BSXFlags is missing and no flags needed, just do nothing
    if flags = 0 then Exit;
    bsx := nif.RootNode.AddExtraData('BSXFlags');
    if not Assigned(bsx) then Exit;
    bsx.EditValues['Name'] := 'BSX';
    Log.Add(#9 + bsx.Name + ': Added missing BSXFlags');
    Result := True;
  end else begin
    if flags = 0 then begin
      Log.Add(#9 + bsx.Name + ': Removed emtpy BSXFlags');
      bsx.RemoveBranch(True);
      Result := True;
    end;
  end;

  var oldflags := bsx.NativeValues['Flags'];
  // use existing Complex and Dynamic flags in FO4 meshes, can't detect those
  if nif.NifVersion >= nfFO4 then begin
    if oldflags and (1 shl 3) <> 0 then flags := flags or (1 shl 3);
    if oldflags and (1 shl 6) <> 0 then flags := flags or (1 shl 6);
  end;
  // Articulated affects grabbing only and is unknown when to set or not, so just copy it
  if oldflags and (1 shl 7) <> 0 then flags := flags or (1 shl 7);

  if oldflags <> flags then begin
    bsx.NativeValues['Flags'] := flags;
    Log.Add(#9 + bsx.Name + ': Flags set to "' + bsx.EditValues['Flags'] + '"');
    Result := True;
  end;
end;

//===========================================================================
function FixHardcodedNames(const nif: TwbNifFile; const Log: TStrings): Boolean;
type
  TBlockName = record BlockType, Name: string end;
const
  cNames: array [0..14] of TBlockName = (
    (BlockType: 'BSBehaviorGraphExtraData';         Name: 'BGED'),
    (BlockType: 'BSBoneLODExtraData';               Name: 'BSBoneLOD'),
    (BlockType: 'BSBound';                          Name: 'BBX'),
    (BlockType: 'BSClothExtraData';                 Name: 'CED'),
    (BlockType: 'BSConnectPoint::Children';         Name: 'CPT'),
    (BlockType: 'BSConnectPoint::Parents';          Name: 'CPA'),
    (BlockType: 'BSDecalPlacementVectorExtraData';  Name: 'DVPG'),
    (BlockType: 'BSDistantObjectLargeRefExtraData'; Name: 'DOLRED'),
    (BlockType: 'BSEyeCenterExtraData';             Name: 'ECED'),
    (BlockType: 'BSFurnitureMarker';                Name: 'FRN'),
    (BlockType: 'BSFurnitureMarkerNode';            Name: 'FRN'),
    (BlockType: 'BSInvMarker';                      Name: 'INV'),
    (BlockType: 'BSPositionData';                   Name: 'BSPosData'),
    (BlockType: 'BSWArray';                         Name: 'BSW'),
    (BlockType: 'BSXFlags';                         Name: 'BSX')
  );
begin
  Result := False;
  for var i := 0 to Pred(nif.BlocksCount) do begin
    var block := nif.Blocks[i];

    if not Assigned(block.Elements['Name']) then
      Continue;

    var name := block.EditValues['Name'];

    for var j: Integer := Low(cNames) to High(cNames) do
      if block.BlockType = cNames[j].BlockType then begin
        if name <> cNames[j].Name then begin
          block.EditValues['Name'] := cNames[j].Name;
          Log.Add(#9 + block.Name + ': Renamed from "' + name + '" to "' + cNames[j].Name + '"');
          Result := True;
        end;
        Break;
      end;

    if (nif.NifVersion = nfTES4) and block.IsNiObject('NiTriBasedGeom') then begin
      var material := block.PropertyByType('NiMaterialProperty');
      // only rendered shapes require named material (have NiTexturingProperty)
      if Assigned(material) and (material.EditValues['Name'] = '') and Assigned(block.PropertyByType('NiTexturingProperty')) then begin
        name := nif.GetUniqueName('Material');
        material.EditValues['Name'] := name;
        Log.Add(#9 + material.Name + ': Renamed to "' + name + '"');
        Result := True;
      end;
    end;

  end;
end;

//===========================================================================
function SortByUserData(Item1, Item2: Pointer): Integer;
begin
  var idx1 := TdfElement(Item1).UserData;
  var idx2 := TdfElement(Item2).UserData;
  if idx1 < idx2 then Result := -1 else
  if idx1 > idx2 then Result := 1 else
    Result := 0;
end;

function FixAnim(const nif: TwbNifFile; const Log: TStrings): Boolean;

  function GetControlledBlockTarget(b: TdfElement): TwbNifBlock;
  begin
    Result := nil;
    if nif.NifVersion >= nfFO3 then begin
      if b.EditValues['Node Name'] <> '' then
        Result := nif.BlockByName(b.EditValues['Node Name']);
    end
    // Oblivion meshes store Node Name in string palette
    else if Assigned(b.Elements['String Palette']) then begin
      var p := TwbNifBlock(b.Elements['String Palette'].LinksTo);
      if Assigned(p) then begin
        var nn := p.GetStringPaletteString(b.NativeValues['Node Name Offset']);
        if nn <> '' then
          Result := nif.BlockByName(nn);
      end;
    end;
  end;

begin
  Result := False;

  // Target in transform controller of shapes
  for var b in nif.BlocksByType('NiObjectNET', True) do begin
    var controller := TwbNifBlock(b.Elements['Controller'].LinksTo);
    if not Assigned(controller) then
      Continue;

    repeat
      if not controller.IsNiObject('NiTimeController') then
        Break;

      if controller.Elements['Target'].LinksTo = nil then begin
        controller.NativeValues['Target'] := b.Index;
        Log.Add(#9 + controller.Name + ': Empty Target set to ' + b.Name);
        Result := True;
      end;

      // continue down the chain of Next Controller
      controller := TwbNifBlock(controller.Elements['Next Controller'].LinksTo);
    until not Assigned(controller);
  end;

  // controller sequences fixes
  var manager := nif.BlockByType('NiControllerManager');
  if not Assigned(manager) then
    Exit;

  var seqs := manager.Elements['Controller Sequences'];
  if not Assigned(seqs) then
    Exit;

  // old and new lists of extra targets
  var slNew := TStringList.Create;
  var slOld := TStringList.Create;
  try

    // going over sequences
    for var i := 0 to Pred(seqs.Count) do begin
      var seq := TwbNifBlock(seqs[i].LinksTo);
      if not Assigned(seq) then
        Continue;

      var TargetElement := Manager.Elements['Target'].LinksTo;
      var TargetName := TargetElement.NativeValues['Name'];
      if seq.NativeValues['Accum Root Name'] <> TargetName then
      begin
        seq.NativeValues['Accum Root Name'] := TargetName;
        Log.Add(#9 + seq.Name + ': Set Accum Root to ' + TargetElement.Name);
        Result := True;
      end;

      // going over contolled blocks (in reverse, we are going to delete some)
      var blocks := seq.Elements['Controlled Blocks'];
      for var j := Pred(blocks.Count) downto 0 do begin
        var target := GetControlledBlockTarget(blocks[j]);

        // storing target node index for sorting
        if Assigned(target) and target.IsNiObject('NiAVObject') {and not target.Hidden} then begin
          blocks[j].UserData := target.Index;
          Continue;
        end;

        // execution goes here to remove block if target node is missing or hidden
        // removing linked interpolator
        var interpolator := TwbNifBlock(blocks[j].Elements['Interpolator'].LinksTo);
        if Assigned(interpolator) then begin
          blocks[j].NativeValues['Interpolator'] := -1;
          interpolator.RemoveBranch(False);
        end;

        // removing linked controller
        var controller := TwbNifBlock(blocks[j].Elements['Controller'].LinksTo);
        if Assigned(controller) then begin
          blocks[j].NativeValues['Controller'] := -1;
          controller.RemoveBranch(False);
        end;

        Log.Add(#9 + seq.Name + ': Removed Controlled block #' + IntToStr(j) + ' because Target is missing or not a visible NiAVObject');
        blocks.Delete(j);
        Result := True;
      end;

      seq.NativeValues['Num Controlled Blocks'] := blocks.Count;

      // sorting controlled blocks by target block index
      if blocks.Sort(SortByUserData) then begin
        Log.Add(#9 + seq.Name + ': Sorted Controlled Blocks by Target node index');
        Result := True;
      end;

      // going over blocks again to build the list of target nodes after possible deletions
      for var j := 0 to Pred(blocks.Count) do begin
        var target := GetControlledBlockTarget(blocks[j]);
        // adding to the list of targets to later update NiMultiTargetTransformController
        if slNew.IndexOf(target.Name + target.EditValues['Name']) = -1 then
          slNew.AddObject(target.Name + target.EditValues['Name'], target);
      end;
    end;

    // update object palette
    var palette := nif.BlockByType('NiDefaultAVObjectPalette');
    if Assigned(palette) then begin
      // current list
      var objs := palette.Elements['Objects'];
      for var i := 0 to Pred(objs.Count) do begin
        var obj := TwbNifBlock(objs[i].Elements['AV Object'].LinksTo);
        if Assigned(obj) then
          slOld.AddObject(obj.Name + obj.EditValues['Name'], obj);
      end;
      // update if different
      if (objs.Count <> slNew.Count) or (slOld.Text <> slNew.Text) then begin
        objs.Count := slNew.Count;
        for var i := 0 to Pred(slNew.Count) do begin
          var obj := TwbNifBlock(slNew.Objects[i]);
          objs[i].EditValues['Name'] := obj.EditValues['Name'];
          objs[i].NativeValues['AV Object'] := obj.Index;
        end;
        Log.Add(#9 + palette.Name + ': Updated AV Objects');
        Result := True;
      end;
    end;

    // update extra targets
    var multitarget := TwbNifBlock(manager.Elements['Next Controller'].LinksTo);
    if not Assigned(multitarget) then
      Exit;

    var extratargets := multitarget.Elements['Extra Targets'];
    if not Assigned(extratargets) then
      Exit;

    // current list of targets
    slOld.Clear;
    for var i := 0 to Pred(extratargets.Count) do begin
      var target := TwbNifBlock(extratargets[i].LinksTo);
      if Assigned(target) then
        slOld.Add(target.Name + target.EditValues['Name']);
    end;

    // update extra targets if different
    if (extratargets.Count <> slNew.Count) or (slOld.Text <> slNew.Text) then begin
      extratargets.Count := slNew.Count;
      for var i := 0 to Pred(slNew.Count) do begin
        extratargets[i].NativeValue := TwbNifBlock(slNew.Objects[i]).Index;
        extratargets[i].UserData := extratargets[i].NativeValue;
      end;
      extratargets.Sort(SortByUserData);
      Log.Add(#9 + multitarget.Name + ': Updated Extra Targets');
      Result := True;
    end;

  finally
    slOld.Free;
    slNew.Free;
  end;
end;

//===========================================================================
{function CompareBlockIndex(List: TStringList; Index1, Index2: Integer): Integer;
begin
  var idx1 := TwbNifBlock(List.Objects[Index1]).Index;
  var idx2 := TwbNifBlock(List.Objects[Index2]).Index;
  if idx1 < idx2 then Result := -1 else
  if idx1 > idx2 then Result := 1 else
    Result := 0;
end;

function FixObjectPalette(const nif: TwbNifFile; const Log: TStrings): Boolean;
begin
  Result := False;

  var palette := nif.BlockByType('NiDefaultAVObjectPalette');
  if not Assigned(palette) then
    Exit;

  var scene := TwbNifBlock(palette.Elements['Scene'].LinksTo);
  if not Assigned(scene) then
    Exit;

  var lstOld := TStringList.Create;
  var lstNew := TStringList.Create;
  try
    // list of objects except the Scene
    for var i := 0 to Pred(nif.BlocksCount) do begin
      var block := nif.Blocks[i];
      if (block <> scene) and ( block.IsNiObject('NiNode', False) or block.IsNiObject('NiGeometry') or block.IsNiObject('BSTriShape') ) then
        lstNew.AddObject(block.Name, block);
    end;

    // current list
    var objs := palette.Elements['Objects'];
    for var i := 0 to Pred(objs.Count) do begin
      var obj := TwbNifBlock(objs[i].Elements['AV Object'].LinksTo);
      if Assigned(obj) and not obj.Hidden then
        lstOld.AddObject(obj.Name, obj);
    end;

    lstNew.CustomSort(CompareBlockIndex);
    lstOld.CustomSort(CompareBlockIndex);
    if lstNew.Text = lstOld.Text then
      Exit;

    objs.Count := lstNew.Count;
    for var i := 0 to Pred(lstNew.Count) do begin
      var obj := TwbNifBlock(lstNew.Objects[i]);
      objs[i].EditValues['Name'] := obj.EditValues['Name'];
      objs[i].NativeValues['AV Object'] := obj.Index;
    end;

   Log.Add(#9 + palette.Name + ': Updated AV Objects');
   Result := True;

  finally
    lstOld.Free;
    lstNew.Free;
  end;
end;
}

//===========================================================================
function FixCollision(const nif: TwbNifFile; const Log: TStrings): Boolean;
var
  Target, Parent: TwbNifBlock;

  function UpdateElement(aBlock: TwbNifBlock; const aPath, aValue: string; aOkValues: string = ''): Boolean;
  begin
    Result := False;
    var el := aBlock.Elements[aPath];
    if not Assigned(el) then
      Exit;

    if aOkValues = '' then aOkValues := aValue else aOkValues := aOkValues + ',' + aValue;
    if Pos(el.EditValue, aOkValues) = 0 then begin
      Log.Add(#9 + aBlock.Name + ': ' + aPath + ' changed from ' + el.EditValue + ' to ' + aValue);
      el.EditValue := aValue;
      Result := True;
    end;
  end;

  function BadTensor(t: Single): Boolean;
  begin
    Result := IsNaN(t) or SameValue(t, 0.0) or (t < 0.0);
  end;

begin
  Result := False;

  if nif.NifVersion < nfTES4 then
    Exit;

  // Set proper collision Target
  for Parent in nif.BlocksByType('NiAVObject', True) do begin
    var col := TwbNifBlock(Parent.Elements['Collision Object'].LinksTo);
    if not Assigned(col) then
      Continue;

    Target := TwbNifBlock(col.Elements['Target'].LinksTo);

    if Target <> Parent then begin
      col.NativeValues['Target'] := Parent.Index;
      Log.Add(#9 + col.Name + ': Target set to ' + Parent.Name);
      Result := True;
    end;

    // Target in bhkCompressedMeshShape
    if nif.NifVersion in [nfTES4, nfSSE] then begin
      var Body := TwbNifBlock(col.Elements['Body'].LinksTo);
      if not Assigned(Body) or not Body.IsNiObject('bhkWorldObject') then
        Continue;

      var Shape := TwbNifBlock(Body.Elements['Shape'].LinksTo);
      if not Assigned(Shape) or not Shape.IsNiObject('bhkMoppBvTreeShape') then
        Continue;

      var MeshShape := TwbNifBlock(Shape.Elements['Shape'].LinksTo);
      if not Assigned(MeshShape) or not MeshShape.IsNiObject('bhkCompressedMeshShape') then
        Continue;

      Target := TwbNifBlock(MeshShape.Elements['Target'].LinksTo);

      if Target <> Parent then begin
        MeshShape.NativeValues['Target'] := Parent.Index;
        Log.Add(#9 + MeshShape.Name + ': Target set to ' + Parent.Name);
        Result := True;
      end;
    end;
  end;

  for var Collision in nif.BlocksByType('bhkCollisionObject', False) do
  begin
    if nif.NifVersion in [nfTES5, nfSSE, nfFO4] then
      if Collision.NativeValues['Flags\SYNC_ON_UPDATE'] = False then
      begin
        Collision.NativeValues['Flags\SYNC_ON_UPDATE'] := True;
        Log.Add(#9 + Collision.Name + ': Added Sync_On_Update flag');
        Result := True;
      end;

    var Rigid := Collision.ElementByName('Body').LinksTo;
    if not Assigned(Rigid) then
      Exit;

    if Integer(Rigid.NativeValues['Havok Filter\Layer']) in [2, 28] then begin
      if Collision.NativeValues['Flags\SET_LOCAL'] = False then
      begin
        Collision.NativeValues['Flags\SET_LOCAL'] := True;
        Log.Add(#9 + Collision.Name + ': Added Set_Local flag');
        Result := True;
      end;
    end
    else
    if Collision.NativeValues['Flags\SET_LOCAL'] = True then
    begin
      Collision.NativeValues['Flags\SET_LOCAL'] := False;
      Log.Add(#9 + Collision.Name + ': Removed Set_Local flag');
      Result := True;
    end;
  end;

  // collision settings
  if nif.NifVersion in [nfFO3, nfTES5, nfSSE] then
  for var rigid in nif.BlocksByType('bhkRigidBody', True) do begin
    var layer: Integer := rigid.NativeValues['Havok Filter\Layer'];
    var S := rigid.EditValues['Havok Filter\Layer'];

    Result := UpdateElement(rigid, 'Havok Filter Copy\Layer', S, S) or Result;

    // static, tree and noncollidable layer
    if layer in  [1, 9, 15] then begin
      Result := UpdateElement(rigid, 'Motion System', 'MO_SYS_FIXED') or Result;
      Result := UpdateElement(rigid, 'Motion Quality', 'MO_QUAL_FIXED') or Result;
      Result := UpdateElement(rigid, 'Deactivator Type', 'DEACTIVATOR_NEVER') or Result;
      Result := UpdateElement(rigid, 'Enable Deactivation', 'no') or Result;
      Result := UpdateElement(rigid, 'Solver Deactivation', 'SOLVER_DEACTIVATION_OFF') or Result;
      if not SameValue(rigid.NativeValues['Mass'], 0.0) then begin
        rigid.NativeValues['Mass'] := 0.0;
        Log.Add(#9 + rigid.Name + ': Changed Mass to 0.0 because of ' + S + ' collision layer');
        Result := True;
      end;
      if not (
        SameValue(rigid.NativeValues['Inertia Tensor\m11'], 0.0) and
        SameValue(rigid.NativeValues['Inertia Tensor\m22'], 0.0) and
        SameValue(rigid.NativeValues['Inertia Tensor\m33'], 0.0)
      ) then begin
        rigid.NativeValues['Inertia Tensor\m11'] := 0.0;
        rigid.NativeValues['Inertia Tensor\m22'] := 0.0;
        rigid.NativeValues['Inertia Tensor\m33'] := 0.0;
        Log.Add(#9 + rigid.Name + ': Changed Inertia Tensor to (0.0, 0.0, 0.0) because of ' + S + ' collision layer');
        Result := True;
      end;
    end

    // animstatic layer
    else if (nif.NifVersion >= nfTES5) and (layer = 2) and (rigid.EditValues['Motion System'] <> 'MO_SYS_KEYFRAMED') then begin
      Result := UpdateElement(rigid, 'Motion System', 'MO_SYS_BOX_INERTIA') or Result;
      Result := UpdateElement(rigid, 'Motion Quality', 'MO_QUAL_FIXED') or Result;
      Result := UpdateElement(rigid, 'Deactivator Type', 'DEACTIVATOR_NEVER') or Result;
      Result := UpdateElement(rigid, 'Enable Deactivation', 'no') or Result;
      Result := UpdateElement(rigid, 'Solver Deactivation', 'SOLVER_DEACTIVATION_OFF') or Result;
      if not SameValue(rigid.NativeValues['Mass'], 0.0) then begin
        rigid.NativeValues['Mass'] := 0.0;
        Log.Add(#9 + rigid.Name + ': Changed Mass to 0.0 because of ' + S + ' collision layer');
        Result := True;
      end;
      if not (
        SameValue(rigid.NativeValues['Inertia Tensor\m11'], 0.0) and
        SameValue(rigid.NativeValues['Inertia Tensor\m22'], 0.0) and
        SameValue(rigid.NativeValues['Inertia Tensor\m33'], 0.0)
      ) then begin
        rigid.NativeValues['Inertia Tensor\m11'] := 0.0;
        rigid.NativeValues['Inertia Tensor\m22'] := 0.0;
        rigid.NativeValues['Inertia Tensor\m33'] := 0.0;
        Log.Add(#9 + rigid.Name + ': Changed Inertia Tensor to (0.0, 0.0, 0.0) because of ' + S + ' collision layer');
        Result := True;
      end;
    end

    // clutter, props, or weapon layer
    else if layer in [4, 5, 10] then begin
      if nif.NifVersion >= nfTES5 then begin
        Result := UpdateElement(rigid, 'Motion System', 'MO_SYS_SPHERE_STABILIZED', 'MO_SYS_SPHERE_INERTIA') or Result;
        Result := UpdateElement(rigid, 'Motion Quality', 'MO_QUAL_MOVING') or Result;
      end
      else begin
        Result := UpdateElement(rigid, 'Motion System', 'MO_SYS_BOX_INERTIA', 'MO_SYS_SPHERE_INERTIA') or Result;
        Result := UpdateElement(rigid, 'Motion Quality', 'MO_QUAL_DEBRIS', 'MO_QUAL_MOVING') or Result;
      end;
      Result := UpdateElement(rigid, 'Deactivator Type', 'DEACTIVATOR_SPATIAL') or Result;
      Result := UpdateElement(rigid, 'Enable Deactivation', 'yes') or Result;

      Result := UpdateElement(rigid,
        'Solver Deactivation',
        'SOLVER_DEACTIVATION_LOW',
        'SOLVER_DEACTIVATION_MEDIUM, SOLVER_DEACTIVATION_HIGH, SOLVER_DEACTIVATION_MAX'
      ) or Result;

      if SameValue(rigid.NativeValues['Mass'], 0.0) then begin
        rigid.NativeValues['Mass'] := 1.0;
        Log.Add(#9 + rigid.Name + ': Changed Mass to 1.0 because of ' + S + ' collision layer and Mass was 0.0');
        Result := True;
      end;
      if BadTensor(rigid.NativeValues['Inertia Tensor\m11']) or
         BadTensor(rigid.NativeValues['Inertia Tensor\m22']) or
         BadTensor(rigid.NativeValues['Inertia Tensor\m33'])
      then begin
        rigid.NativeValues['Inertia Tensor\m11'] := 1.0;
        rigid.NativeValues['Inertia Tensor\m22'] := 1.0;
        rigid.NativeValues['Inertia Tensor\m33'] := 1.0;
        Log.Add(#9 + rigid.Name + ': Changed Inertia Tensor to (1.0, 1.0, 1.0) because some values were zero or invalid');
        Result := True;
      end;
    end;

    var el := rigid.Elements['Time Factor'];
    if Assigned(el) and SameValue(el.NativeValue, 0.0) then begin
      el.NativeValue := 1.0;
      Log.Add(#9 + rigid.Name + ': Time Factor changed from 0.0 to 1.0');
      Result := True;
    end;

    el := rigid.Elements['Gravity Factor'];
    if Assigned(el) and SameValue(el.NativeValue, 0.0) then begin
      el.NativeValue := 1.0;
      Log.Add(#9 + rigid.Name + ': Gravity Factor changed from 0.0 to 1.0');
      Result := True;
    end;

    // update layers in bhkListShape
    var lShape := TwbNifBlock(rigid.Elements['Shape'].LinksTo);
    if not Assigned(lShape) then
      Continue;

    var lBlockType := lShape.BlockType;
    var lUpdated := False;

    if lBlockType = 'bhkListShape' then begin
      var lSubShapes := lShape.Elements['Sub Shapes'];
      var lFilters := lShape.Elements['Filters'];
      lFilters.Count := lSubShapes.Count;

      for var I := Pred(lSubShapes.Count) downto 0 do begin
        var subshape := TwbNifBlock(lSubshapes[I].LinksTo);

        if not Assigned(subshape) then begin
          lSubShapes.Delete(I);
          lFilters.Delete(I);
          lUpdated := True;
          Continue;
        end;

        if lFilters[I].NativeValues['Layer'] <> layer then begin
          lFilters[I].NativeValues['Layer'] := layer;
          lUpdated := True;
        end;
      end;

      if lUpdated then begin
        Log.Add(#9 + lShape.Name + ': Updated Filters to match the rigid body layer');
        Result := True;
      end;
    end
    else
    if lBlockType = 'bhkMoppBvTreeShape' then
    begin
      var lSubShape := TwbNifBlock(lShape.Elements['Shape'].LinksTo);
      if not Assigned(lSubShape) then
        Continue;

      if lSubShape.BlockType <> 'bhkCompressedMeshShape' then
        Continue;

      var lData := TwbNifBlock(lSubShape.Elements['Data'].LinksTo);
      if not Assigned(lData) then
        Continue;

      var lChunkMaterials := lData.Elements['Chunk Materials'];
      if not Assigned(lChunkMaterials) then
        Continue;

      var lChunkMaterialsCount := lChunkMaterials.Count;

      if lChunkMaterialsCount = 0 then
        Continue;

      for var lIdx := 0 to Pred(lChunkMaterialsCount) do
        with lChunkMaterials[lIdx] do
          if NativeValues['Havok Filter\Layer'] <> Layer then
          begin
            NativeValues['Havok Filter\Layer'] := Layer;
            lUpdated := True;
          end;

      if lUpdated then begin
        Log.Add(#9 + lData.Name + ': Updated Filters to match the rigid body layer');
        Result := True;
      end;
    end;
  end;
end;

//===========================================================================
function FixParticles(const nif: TwbNifFile; const Log: TStrings): Boolean;
begin
  Result := False;

  if nif.NifVersion = nfSSE then
    for var block in nif.BlocksByType('NiPSysMeshEmitter', True) do begin
      var meshes := block.Elements['Emitter Meshes'];
      for var i := 0 to Pred(meshes.Count) do begin
        var shape := TwbNifBlock(meshes[i].LinksTo);
        if not Assigned(shape) or (shape.BlockType <> 'BSTriShape') then Continue;

        if shape.NativeValues['Particle Data Size'] <> 0 then
          Continue;

        // to enable particle data, will be updated with the correct value on save automatically
        shape.NativeValues['Particle Data Size'] := 1;

        var vertices := shape.Elements['Vertex Data'];
        if not Assigned(vertices) or (vertices.Count = 0) then Continue;

        var pvertices := shape.Elements['Particle Vertices'];
        var pnormals := shape.Elements['Particle Normals'];
        pvertices.Count := vertices.Count;
        pnormals.Count := vertices.Count;

        for var j := 0 to Pred(vertices.Count) do begin
          pvertices[j].EditValue := vertices[j].EditValues['Vertex'];
          pnormals[j].EditValue := vertices[j].EditValues['Normal'];
        end;

        shape.Elements['Particle Triangles'].Assign(shape.Elements['Triangles']);

        Log.Add(#9 + shape.Name + ': Added missing Particle Data for mesh emitter used by ' + block.Name);
        Result := True;
      end;
    end;
end;

//===========================================================================
function FixConsistencyFlags(const nif: TwbNifFile; const Log: TStrings): Boolean;
var
  f: string;
begin
  Result := False;

  if not (nif.NifVersion in [nfTES4, nfFO3, nfTES5]) then
    Exit;

  for var shape in nif.BlocksByType('NiGeometry', True) do begin
    var data := shape.Elements['Data'].LinksTo;
    if not Assigned(data) then
      Continue;

    if not Assigned(data.Elements['Consistency Flags']) then
      Continue;

    var controller := shape.GetController;
    if shape.IsNiObject('NiParticles', True) or
       ( Assigned(controller) and (controller.IsNiObject('NiGeomMorpherController', True) or controller.IsNiObject('NiUVController', True)) )
    then
      f := 'CT_MUTABLE'
    else
      f := 'CT_STATIC';

    if data.EditValues['Consistency Flags'] <> f then begin
      Log.Add(#9 + data.Name + ': Consistency Flags changed from ' + data.EditValues['Consistency Flags'] + ' to ' + f);
      data.EditValues['Consistency Flags'] := f;
      Result := True;
    end;
  end;
end;

//===========================================================================
function FixRedundantBlocks(const nif: TwbNifFile; const Log: TStrings): Boolean;
begin
  Result := False;

  // empty shapes
  for var i := Pred(nif.BlocksCount) downto 0 do begin
    // we could have removed several blocks on the first iteration, so check just in case
    if i > nif.BlocksCount then
      Continue;

    var shape := nif.Blocks[i];
    var verts := 0;

    if shape.IsNiObject('BSTriShape') then begin
      if shape.Elements['Skin'].LinksTo <> nil then
        Continue;

      verts := shape.NativeValues['Num Vertices']
    end

    else if shape.IsNiObject('NiTriBasedGeom') then begin
      if shape.Elements['Skin Instance'].LinksTo <> nil then
        Continue;

      var shapedata := shape.Elements['Data'].LinksTo;
      if Assigned(shapedata) then
        verts := shapedata.NativeValues['Num Vertices'];
    end

    else
      Continue;

    if verts <> 0 then
      Continue;

    if Length(shape.ExtraDatasByType('NiExtraData', True)) <> 0 then
      Continue;

    Log.Add(#9 + shape.Name + ': Removed empty geometry shape');
    shape.RemoveBranch(True);
    Result := True;
  end;

  // NiStringExtraData "UPB"
  // FO3 and later games check UPB only in one condition: node named Backpack has UPB
  // with a name of a block that should parent said Backpack to attach it
  for var b in nif.BlocksByType('NiStringExtraData') do begin
    if b.EditValues['Name'] <> 'UPB' then Continue;

    var bBackpack := False;
    for var ref in b.ReferencedBy do begin
      var parent := nifblk(ref);
      if Assigned(parent) and (parent.EditValues['Name'] = 'Backpack') then begin
        bBackpack := True;
        Break;
      end;
    end;

    if not bBackpack then begin
      Log.Add(#9 + b.Name + ': Removed unused "UPB" extra data');
      b.RemoveBranch(True);
      Result := True;
    end;
  end;

  // useless NiSpecularProperty
  if nif.NifVersion >= nfTES4 then
    for var spec in nif.BlocksByType('NiSpecularProperty') do begin
      Log.Add(#9 + spec.Name + ': Removed because redundant and does nothing');
      spec.RemoveBranch(True);
      Result := True;
    end;

  // useless NiVertexColorProperty
  {
  if nif.NifVersion = nfTES4 then
    for var shape in nif.BlocksByType('NiTriBasedGeom', True) do begin
      var prop := shape.PropertyByType('NiVertexColorProperty');
      if not Assigned(prop) then
        Continue;

      if (prop.EditValues['Vertex Mode'] = 'VERT_MODE_SRC_AMB_DIF') and
         (prop.EditValues['Light Mode'] = 'LIGHT_MODE_EMI_AMB_DIF') and
         (Integer(prop.NativeValues['Flags']) in [0, 40])
      then begin
        Log.Add(#9 + prop.Name + ': Removed because redundant and does nothing');
        prop.RemoveBranch(True);
        Result := True;
      end;
    end;
  }
end;

//===========================================================================
function FixShaderProperty(const nif: TwbNifFile; const Log: TStrings): Boolean;
var
  shape, shader, texset: TwbNifBlock;
begin
  Result := False;

  if not (nif.NifVersion in [nfTES4, nfFO3, nfTES5, nfSSE, nfFO4]) then
    Exit;

  var bFaceGen := Assigned(nif.BlockByName('BSFaceGenNiNodeSkinned', 'NiNode'));

  for var i := 0 to Pred(nif.BlocksCount) do begin
    shape := nif.Blocks[i];
    if not (shape.IsNiObject('BSTriShape') or shape.IsNiObject('NiGeometry')) then
      Continue;

    shader := shape.PropertyByType('BSShaderProperty', True);
    if not Assigned(shader) then
      Continue;

    texset := nil; // suppress compiler warning
    if Assigned(shader.Elements['Texture Set']) then
      texset := TwbNifBlock(shader.Elements['Texture Set'].LinksTo);

    // Skinned flag
    if shape.GetSkin <> nil then begin
      if not shader.NativeValues['Shader Flags 1\Skinned'] then begin
        shader.NativeValues['Shader Flags 1\Skinned'] := True;
        Log.Add(#9 + shader.Name + ': Added Skinned flag');
        Result := True;
      end;
    end else
      if shader.NativeValues['Shader Flags 1\Skinned'] then begin
        shader.NativeValues['Shader Flags 1\Skinned'] := False;
        Log.Add(#9 + shader.Name + ': Removed Skinned flag');
        Result := True;
      end;

    // Vertex Colors flag
    var bHasVertexColors := False;
    if shape.IsNiObject('NiGeometry') then begin
      var shapedata: TwbNifBlock := TwbNifBlock(shape.Elements['Data'].LinksTo);
      if Assigned(shapedata) then
        bHasVertexColors := shapedata.NativeValues['Has Vertex Colors'];
    end else
      bHasVertexColors := shape.NativeValues['VertexDesc\VF\VF_COLORS'];

    // set at runtime in FO3/FNV, idk about other games
    if nif.NifVersion <> nfFO3 then begin
      if bHasVertexColors and not shader.NativeValues['Shader Flags 2\Vertex_Colors'] then begin
        shader.NativeValues['Shader Flags 2\Vertex_Colors'] := True;
        Log.Add(#9 + shader.Name + ': Added Vertex_Colors flag because vertex colors are present');
        Result := True;
      end;

      if not bHasVertexColors and shader.NativeValues['Shader Flags 2\Vertex_Colors'] then begin
        shader.NativeValues['Shader Flags 2\Vertex_Colors'] := False;
        Log.Add(#9 + shader.Name + ': Removed Vertex_Colors flag because vertex colors are missing');
        Result := True;
      end;
    end;

    if not bHasVertexColors and shader.NativeValues['Shader Flags 1\Vertex_Alpha'] then begin
      shader.NativeValues['Shader Flags 1\Vertex_Alpha'] := False;
      Log.Add(#9 + shader.Name + ': Removed Vertex_Alpha flag because vertex colors are missing');
      Result := True;
    end;

    if nif.NifVersion = nfTES4 then begin
      // Nothing for TES4 yet :(
    end;

    if nif.NifVersion = nfFO3 then begin
      // Nothing for FO3 yet :(
    end;

    // shader type and flags for Skyrim and later games
    if nif.NifVersion in [nfTES5, nfSSE] then begin

      // Dynamic_Decal flag
      if Shader.NativeValues['Shader Flags 1\Dynamic_Decal'] then begin
        if not Shader.NativeValues['Shader Flags 1\Decal'] then begin
          Shader.NativeValues['Shader Flags 1\Decal'] := True;
          Log.Add(#9 + Shader.Name + ': Added Decal flag because Dynamic_Decal flag is used');
          Result := True;
        end;

        if not Shader.NativeValues['Shader Flags 2\Assume_Shadowmask'] then begin
          Shader.NativeValues['Shader Flags 2\Assume_Shadowmask'] := True;
          Log.Add(#9 + Shader.Name + ': Added Assume_Shadowmask flag because Dynamic_Decal flag is used');
          Result := True;
        end;
      end;

      if Shader.BlockType = 'BSEffectShaderProperty' then begin
        //Nothing for BSEffectShaders yet. :(
      end;

      if Shader.BlockType = 'BSLightingShaderProperty' then begin
        if not Assigned(texset) then
          Continue;

        var ShaderType := shader.EditValues['Shader Type'];
        var bTexEmissive := texset.EditValues['Textures\[2]'] <> '';
        var bTexParallax := texset.EditValues['Textures\[3]'] <> '';
        var bTexEnvMapped := (texset.EditValues['Textures\[4]'] <> '') or (texset.EditValues['Textures\[5]'] <> '');
        var bTexSubSurface := texset.EditValues['Textures\[6]'] <> '';

        // decide on shader when multiple features
        var NewShaderType := '';

        // perfect matches first: type + texture + flags
        if (ShaderType = 'Facegen') and bTexEmissive and bTexParallax and bTexSubSurface and Shader.NativeValues['Shader Flags 1\Facegen'] then
          NewShaderType := 'Facegen' else
        if (ShaderType = 'MultiLayer Parallax') and bTexEnvMapped and bTexSubSurface and Shader.NativeValues['Shader Flags 2\Multi_Layer_Parallax'] then
          NewShaderType := 'MultiLayer Parallax' else
        if (ShaderType = 'Environment Map') and bTexEnvMapped and shader.NativeValues['Shader Flags 1\Environment_Mapping'] then
          NewShaderType := 'Environment Map' else
        if (ShaderType = 'Eye Envmap') and bTexEnvMapped and shader.NativeValues['Shader Flags 1\Eye_Environment_Mapping'] then
          NewShaderType := 'Eye Envmap' else
        if (ShaderType = 'Glow Shader') and bTexEmissive and shader.NativeValues['Shader Flags 2\Glow_Map'] then
          NewShaderType := 'Glow Shader' else
        if (ShaderType = 'Skin Tint') and bTexEmissive and shader.NativeValues['Shader Flags 1\Skin_Tint'] then
          NewShaderType := 'Skin Tint' else
        if (ShaderType = 'Parallax') and bTexParallax and shader.NativeValues['Shader Flags 1\Parallax'] then
          NewShaderType := 'Parallax' else

        // less perfect matches: type + texture
        if (ShaderType = 'Facegen') and bTexEmissive and bTexParallax and bTexSubSurface then
          NewShaderType := 'Facegen' else
        if (ShaderType = 'MultiLayer Parallax') and bTexEnvMapped and bTexSubSurface then
          NewShaderType := 'MultiLayer Parallax' else
        if (ShaderType = 'Environment Map') and bTexEnvMapped then
          NewShaderType := 'Environment Map' else
        if (ShaderType = 'Eye Envmap') and bTexEnvMapped then
          NewShaderType := 'Eye Envmap' else
        if (ShaderType = 'Glow Shader') and bTexEmissive  then
          NewShaderType := 'Glow Shader' else
        if (ShaderType = 'Skin Tint') and bTexEmissive then
          NewShaderType := 'Skin Tint' else
        if (ShaderType = 'Parallax') and bTexParallax then
          NewShaderType := 'Parallax' else

        // even less perfect matches: texture + flags
        if bTexEmissive and bTexParallax and bTexSubSurface and Shader.NativeValues['Shader Flags 1\Facegen'] then
          NewShaderType := 'Facegen' else
        if bTexEnvMapped and bTexSubSurface and Shader.NativeValues['Shader Flags 2\Multi_Layer_Parallax'] then
          NewShaderType := 'MultiLayer Parallax' else
        if bTexEnvMapped and shader.NativeValues['Shader Flags 1\Environment_Mapping'] then
          NewShaderType := 'Environment Map' else
        if bTexEnvMapped and shader.NativeValues['Shader Flags 1\Eye_Environment_Mapping'] then
          NewShaderType := 'Eye Envmap' else
        if bTexEmissive and shader.NativeValues['Shader Flags 2\Glow_Map'] then
          NewShaderType := 'Glow Shader' else
        if bTexEmissive and shader.NativeValues['Shader Flags 1\Skin_Tint'] then
          NewShaderType := 'Skin Tint' else
        if bTexParallax and shader.NativeValues['Shader Flags 1\Parallax'] then
          NewShaderType := 'Parallax';

        // empty NewShaderType means we couldn't decide
        if (NewShaderType <> '') and (ShaderType <> NewShaderType) then begin
          shader.EditValues['Shader Type'] := NewShaderType;
          Log.Add(#9 + shader.Name + ': Changed Shader Type from ' + ShaderType + ' to ' + NewShaderType + ' based on assigned textures and flags');
          Result := True;
        end;

        ShaderType := Shader.EditValues['Shader Type'];

        if ShaderType = 'Environment Map' then begin
          // add Environment_Mapping flag when shader is Environment Map
          if not shader.NativeValues['Shader Flags 1\Environment_Mapping'] then begin
            shader.NativeValues['Shader Flags 1\Environment_Mapping'] := True;
            Log.Add(#9 + shader.Name + ': Added Environment_Mapping flag because Shader Type is Environment Map');
            Result := True;
          end;
        end else
          // remove Environment_Mapping flag when shader is not Environment Map
          if shader.NativeValues['Shader Flags 1\Environment_Mapping'] then begin
            shader.NativeValues['Shader Flags 1\Environment_Mapping'] := False;
            Log.Add(#9 + shader.Name + ': Removed Environment_Mapping flag because Shader Type is not Environment Map');
            Result := True;
          end;

        if ShaderType = 'Glow Shader' then begin
          // add Glow_Map flag when shader is Glow Shader
          if not shader.NativeValues['Shader Flags 2\Glow_Map'] then begin
            shader.NativeValues['Shader Flags 2\Glow_Map'] := True;
            Log.Add(#9 + shader.Name + ': Added Glow_Map flag because Shader Type is Glow Shader');
            Result := True;
          end;
          // add Own_Emit flag when shader is Glow Shader
          if not shader.NativeValues['Shader Flags 1\Own_Emit'] then begin
            shader.NativeValues['Shader Flags 1\Own_Emit'] := True;
            Log.Add(#9 + shader.Name + ': Added Own_Emit flag because Shader Type is Glow Shader');
            Result := True;
          end;
        end else begin
          // Remove Glow Map flag if shader is not Glow Shader
          if shader.NativeValues['Shader Flags 2\Glow_Map'] then begin
            shader.NativeValues['Shader Flags 2\Glow_Map'] := False;
            Log.Add(#9 + shader.Name + ': Removed Glow_Map flag because Shader Type is not Glow Shader');
            Result := True;
          end;
          // Remove Own_Emit if not Glow Shader and Emissive Color is blank
          // Because Beth doesn't respect their own code's standards...
          if (Shader.NativeValues['Shader Flags 1\Own_Emit']) and (Shader.EditValues['Emissive Color'] = '#000000') then begin
            Shader.NativeValues['Shader Flags 1\Own_Emit'] := False;
            Log.Add(#9 + Shader.Name + ': Removed Own_Emit flag because Emissive Color is Blank');
            Result := True;
          end;
          // External_Emittance doesn't work without glow
          if shader.NativeValues['Shader Flags 1\External_Emittance'] then begin
            shader.NativeValues['Shader Flags 1\External_Emittance'] := False;
            Log.Add(#9 + shader.Name + ': Removed External_Emittance flag because Shader Type is not Glow Shader');
            Result := True;
          end;
        end;

        if ShaderType = 'Parallax' then begin
          // add Parallax flag when shader is Parallax
          if not shader.NativeValues['Shader Flags 1\Parallax'] then begin
            shader.NativeValues['Shader Flags 1\Parallax'] := True;
            Log.Add(#9 + shader.Name + ': Added Parallax flag because Shader Type is Parallax');
            Result := True;
          end;
        end else
          // remove Parallax flag when shader is not Parallax
          if shader.NativeValues['Shader Flags 1\Parallax'] then begin
            shader.NativeValues['Shader Flags 1\Parallax'] := False;
            Log.Add(#9 + shader.Name + ': Removed Parallax flag because Shader Type is not Parallax');
            Result := True;
          end;

        if ShaderType = 'Facegen' then begin
          // add Facegen flag when shader is Facegen
          if not Shader.NativeValues['Shader Flags 1\Facegen'] then begin
            Shader.NativeValues['Shader Flags 1\Facegen'] := True;
            Log.Add(#9 + Shader.Name + ': Added Facegen flag because Shader Type is Facegen');
            Result := True;
          end;
          // add Soft_Lighting flag when shader is Facegen
          if not (Shader.NativeValues['Shader Flags 2\Soft_Lighting']) then begin
            Shader.NativeValues['Shader Flags 2\Soft_Lighting'] := True;
            Log.Add(#9 + Shader.Name + ': Added Soft_Lighting flag because Shader Type is Facegen');
            Result := True;
          end;
          // Anisotropic_Lighting is incompatible with Facegen shader
          if Shader.NativeValues['Shader Flags 2\Anisotropic_Lighting'] then begin
            Shader.NativeValues['Shader Flags 2\Anisotropic_Lighting'] := False;
            Log.Add(#9 + Shader.Name + ': Removed Anisotropic_Lighting flag because Shader Type is Facegen');
            Result := True;
          end;
        end else
          // Remove Facegen flag when shader is not Facegen
          if Shader.NativeValues['Shader Flags 1\Facegen'] then begin
            Shader.NativeValues['Shader Flags 1\Facegen'] := False;
            Log.Add(#9 + Shader.Name + ': Removed Facegen flag because Shader Type is not Facegen');
            Result := True;
          end;

        if ShaderType = 'Skin Tint' then begin
          // add Skin_Tint flag when shader is Skin Tint
          if not shader.NativeValues['Shader Flags 1\Skin_Tint'] then begin
            shader.NativeValues['Shader Flags 1\Skin_Tint'] := True;
            Log.Add(#9 + shader.Name + ': Added Skin_Tint flag because Shader Type is Skin Tint');
            Result := True;
          end;
          // add Soft_Lighting flag when shader is Skin Tint
          if not shader.NativeValues['Shader Flags 2\Soft_Lighting'] then begin
            shader.NativeValues['Shader Flags 2\Soft_Lighting'] := True;
            Log.Add(#9 + shader.Name + ': Added Soft_Lighting flag because Shader Type is Skin Tint');
            Result := True;
          end;
        end else
          // remove Skin_Tint flag when shader is not Skin Tint
          if shader.NativeValues['Shader Flags 1\Skin_Tint'] then begin
            shader.NativeValues['Shader Flags 1\Skin_Tint'] := False;
            Log.Add(#9 + shader.Name + ': Removed Skin_Tint flag because Shader Type is not Skin Tint');
            Result := True;
          end;

        if ShaderType = 'Hair Tint' then begin
          // add Hair_Tint flag when shader is Hair Tint
          if not Shader.NativeValues['Shader Flags 1\Hair_Tint'] then begin
            Shader.NativeValues['Shader Flags 1\Hair_Tint'] := True;
            Log.Add(#9 + Shader.Name + ': Added Hair_Tint flag because Shader Type is Hair Tint');
            Result := True;
          end;
        end else
          // remove Hair_Tint flag when shader is not Hair Tint
          if Shader.NativeValues['Shader Flags 1\Hair_Tint'] then begin
            Shader.NativeValues['Shader Flags 1\Hair_Tint'] := False;
            Log.Add(#9 + Shader.Name + ': Removed Hair_Tint flag because Shader Type is not Hair Tint');
            Result := True;
          end;

        if ShaderType = 'MultiLayer Parallax' then begin
          // add Multi_Layer_Parallax flag when shader is MultiLayer Parallax
          if not shader.NativeValues['Shader Flags 2\Multi_Layer_Parallax'] then begin
            shader.NativeValues['Shader Flags 2\Multi_Layer_Parallax'] := True;
            Log.add(#9 + shader.Name + ': Added Multi_Layer_Parallax flag because Shader Type is MultiLayer Parallax');
            Result := True;
          end;
        end else
          // remove Multi_Layer_Parallax flag when shader is not MultiLayer Parallax
          if shader.NativeValues['Shader Flags 2\Multi_Layer_Parallax'] then begin
            shader.NativeValues['Shader Flags 2\Multi_Layer_Parallax'] := False;
            Log.Add(#9 + shader.Name + ': Removed Multi_Layer_Parallax flag because Shader Type is not MultiLayer Parallax');
            Result := True;
          end;

        if ShaderType = 'Eye Envmap' then begin
          // add Eye_Environment_Mapping flag when shader is Eye Envmap
          if not shader.NativeValues['Shader Flags 1\Eye_Environment_Mapping'] then begin
            shader.NativeValues['Shader Flags 1\Eye_Environment_Mapping'] := True;
            Log.Add(#9 + shader.Name + ': Added Eye_Environment_Mapping flag because Shader Type is Eye EnvMap');
            Result := True;
          end;
        end else
          // remove Eye_Environment_Mapping flag when shader is not Eye Envmap
          if shader.NativeValues['Shader Flags 1\Eye_Environment_Mapping'] then begin
            shader.NativeValues['Shader Flags 1\Eye_Environment_Mapping'] := False;
            Log.Add(#9 + shader.Name + ': Removed Eye_Environment_Mapping flag because Shader Type is not Eye Envmap');
            Result := True;
          end;

        // Character Lighting flag
        if bFacegen then begin
          if not Shader.NativeValues['Shader Flags 2\Character_Lighting'] then begin
            Shader.NativeValues['Shader Flags 2\Character_Lighting'] := True;
            Log.Add(#9 + Shader.Name + ': Added Character_Lighting flag because ' + Nif.Name + ' is a Facegen nif');
            Result := True;
          end;
        end else begin
          if Shader.NativeValues['Shader Flags 2\Character_Lighting'] then begin
            Shader.NativeValues['Shader Flags 2\Character_Lighting'] := False;
            Log.Add(#9 + Shader.Name + ': Removed Character_Lighting flag because ' + Nif.Name + ' is not a Facegen nif');
            Result := True;
          end;
        end;

        // EnvMap_Light_Fade flag
        if (ShaderType = 'Environment Map') or (ShaderType = 'MultiLayer Parallax') or (ShaderType = 'Eye Envmap') then begin
          if not Shader.NativeValues['Shader Flags 2\EnvMap_Light_Fade'] then begin
            Shader.NativeValues['Shader Flags 2\EnvMap_Light_Fade'] := True;
            Log.Add(#9 + Shader.Name + ': Added EnvMap_Light_Fade flag because Shader Type is Environment/MultiLayer Parallax');
            Result := True;
          end;
        end else
          if Shader.NativeValues['Shader Flags 2\EnvMap_Light_Fade'] then begin
            Shader.NativeValues['Shader Flags 2\EnvMap_Light_Fade'] := False;
            Log.Add(#9 + Shader.Name + ': Removed EnvMap_Light_Fade flag because Shader Type is not Environment/MultiLayer Parallax');
            Result := True;
          end;

        // Specular Flag
        if (Shader.NativeValues['Shader Flags 1\Specular']) and (Shader.EditValues['Specular Color'] = '#000000') then begin
          Shader.NativeValues['Shader Flags 1\Specular'] := False;
          Log.Add(#9 + Shader.Name + ': Removed Specular flag because Specular Color is Blank');
          Result := True;
        end;

        // Tree_Anim flag
        if Shader.NativeValues['Shader Flags 2\Tree_Anim'] then begin
          if (nif.RootNode.BlockType <> 'BSLeafAnimNode') and (nif.RootNode.BlockType <> 'BSTreeNode') then begin
            Shader.NativeValues['Shader Flags 2\Tree_Anim'] := False;
            if Shader.NativeValues['Shader Flags 1\Vertex_Alpha'] then
              Shader.NativeValues['Shader Flags 1\Vertex_Alpha'] := False;
            Log.Add(#9 + Shader.Name + ': Removed Tree_Anim flag because root node is not BSLeafAnimNode or BSTreeNode');
            Result := True;
          end;

          if (ShaderType <> 'Default') and (ShaderType <> 'Tree Anim') then begin
            Shader.NativeValues['Shader Flags 2\Tree_Anim'] := False;
            if Shader.NativeValues['Shader Flags 1\Vertex_Alpha'] then
              Shader.NativeValues['Shader Flags 1\Vertex_Alpha'] := False;
            Log.Add(#9 + Shader.Name + ': Removed Tree_Anim flag because of wrong Shader Type');
            Result := True;
          end;
        end;

        if Shader.NativeValues['Shader Flags 2\Tree_Anim'] then begin
          if bHasVertexColors then begin
            if not Shader.NativeValues['Shader Flags 1\Vertex_Alpha'] then begin
              Shader.NativeValues['Shader Flags 1\Vertex_Alpha'] := True;
              Log.Add(#9 + Shader.Name + ': Added Vertex_Alpha flag because Tree_Anim flag is set');
              Result := True;
            end;
          end else begin
            Shader.NativeValues['Shader Flags 2\Tree_Anim'] := False;
            Log.Add(#9 + Shader.Name + ': Removed Tree_Anim flag because vertex colors are missing');
            Result := True;
          end;
        end;

        if Shader.NativeValues['Glossiness'] = 0 then begin
          Shader.NativeValues['Glossiness'] := 1;
          Log.Add(#9 + Shader.Name + ': Set Glossiness to 1, because 0 causes lighting issues');
          Result := True;
        end;
      end;
    end;

    if nif.NifVersion = nfFO4 then begin
      // external material file is used, shader settings are unused
      if shader.EditValues['Name'] <> '' then
        Continue;
    end;
  end;
end;


function TProcUniversalFixer.ProcessFile(aFile: TProcFileObject): TBytes;
var
  nif: TwbNifFile;
  Log: TStringList;
  bChanged: Boolean;
begin
  Log := TStringList.Create;
  nif := TwbNifFile.Create;
  nif.Options := [nfoCollapseLinkArrays, nfoRemoveUnusedStrings];
  try
    nif.LoadFromData(aFile.GetData);

    bChanged := False;
    bChanged := FixStringIndices(nif, Log) or bChanged;
    bChanged := FixArrayLinks(nif, Log) or bChanged;
    // remove empty geometry after fixing array links so it won't report empty links leaved by us
    // removed later by nfoCollapseLinkArrays on save
    bChanged := FixRedundantBlocks(nif, Log) or bChanged;
    bChanged := FixAbsolutePaths(nif, Log) or bChanged;
    // hiding markers before anims because they check hidden flag
    //bChanged := FixEditorMarker(nif, Log) or bChanged;
    // shaders before BSXFlags because External_Emittance flag depends on shaders
    bChanged := FixShaderProperty(nif, Log) or bChanged;
    bChanged := FixBSXFlags(nif, Log) or bChanged;
    bChanged := FixHardcodedNames(nif, Log) or bChanged;
    bChanged := FixAnim(nif, Log) or bChanged;
    //bChanged := FixObjectPalette(nif, Log) or bChanged;
    bChanged := FixCollision(nif, Log) or bChanged;
    bChanged := FixParticles(nif, Log) or bChanged;
    bChanged := FixConsistencyFlags(nif, Log) or bChanged;

    if bChanged then begin
      nif.SaveToData(Result);

      Sync.BeginWrite;
      try
        LogFile.Add(aFile.FileName);
        LogFile.AddStrings(Log);
        LogFile.Add('');
      finally
        Sync.EndWrite;
      end;

    end;

  finally
    nif.Free;
    Log.Free;
  end;
end;

end.

{******************************************************************************

  This Source Code Form is subject to the terms of the Mozilla Public License,
  v. 2.0. If a copy of the MPL was not distributed with this file, You can obtain
  one at https://mozilla.org/MPL/2.0/.

*******************************************************************************}

unit ProcCheckForErrors;

interface

uses
  System.Classes,
  System.SysUtils,

  Vcl.ComCtrls,
  Vcl.Controls,
  Vcl.Forms,
  Vcl.Menus,
  Vcl.StdCtrls,

  SniffProcessor;

type
  TFrameCheckForErrors = class(TFrame)
    StaticText1: TStaticText;
    txtComment: TStaticText;
    lvChecks: TListView;
    menuChecks: TPopupMenu;
    mniCheckAll: TMenuItem;
    mniUncheckAll: TMenuItem;
    procedure lvChecksSelectItem(Sender: TObject; Item: TListItem;
      Selected: Boolean);
    procedure mniCheckAllClick(Sender: TObject);
  end;

  TCheckProcedure = procedure(aFile: TProcFileObject; aObj: Pointer; Log: TStrings);
  TExtensions = array of string;

  TCheck = record
    Name: string;
    Group: string;
    Extensions: TExtensions;
    Comment: string;
    Proc: TCheckProcedure;
    Active: Boolean;
    function DoesExtension(const aExtension: string): Boolean;
  end;
  PCheck = ^TCheck;

  TProcCheckForErrors = class(TProcBase)
  private
    Frame: TFrameCheckForErrors;
    Checks: array of TCheck;
    fLoadNIF: Boolean;
    fLoadDDS: Boolean;
  public
    constructor Create(aManager: TProcManager); override;
    function GetFrame(aOwner: TComponent): TFrame; override;
    procedure OnShow; override;
    procedure OnHide; override;
    procedure OnStart; override;
    procedure AddCheck(
      const aName, aGroup: string;
      const aExtensions: TExtensions;
      const aComment: string;
      aProc: TCheckProcedure;
      aActive: Boolean = True
    );

    function ProcessFile(aFile: TProcFileObject): TBytes; override;
  end;


implementation

{$R *.dfm}

uses
  System.IOUtils,
  System.Math,

  wbDataFormat,
  wbDataFormatNif,
  wbDDS,
  wbNifMath;

//==============================================================================
procedure CheckStringIndex(aFile: TProcFileObject; aObj: Pointer; Log: TStrings);
begin
  var nif: TwbNifFile := aObj;

  if not (nif.NifVersion in [nfFO3, nfTES5, nfSSE, nfFO4]) then
    Exit;

  var n: Integer := nif.Header.Elements['Num Strings'].NativeValue;

  for var i := 0 to Pred(nif.BlocksCount) do begin
    var block := nif.Blocks[i];
    for var j := 0 to Pred(block.StringsCount) do
      if block.Strings[j].NativeValue >= n then
        Log.Add(#9 + block.Strings[j].Path + ': Invalid string index');
  end;

end;

//==============================================================================
procedure CheckBlocksOrder(aFile: TProcFileObject; aObj: Pointer; Log: TStrings);

  procedure RecursiveIndexCheck(const aParent: TwbNifBlock);
  begin
    for var i := 0 to Pred(aParent.RefsCount) do begin
      var ref := aParent.Refs[i];
      // Ref only
      if ref.Ptr then Continue;

      var child := TwbNifBlock(ref.LinksTo);
      if not Assigned(child) then Continue;

      if child.UserData = 1 then Continue;

      // skip constraints
      if child.IsNiObject('bhkConstraint') or child.IsNiObject('bhkBallSocketConstraintChain') then
        Continue;

      // bhkAction references rigid body and must be loaded after it
      if child.IsNiObject('bhkAction') then begin
        if child.Index < aParent.Index then
          Log.Add(#9 + child.Name + ': Must have greater index than its parent ' + aParent.Name);
      end else

      // ref objects are the opposite - must be loaded before each other
      if child.IsNiObject('bhkRefObject') then begin
        if child.Index > aParent.Index then
          Log.Add(#9 + child.Name + ': Must have lesser index than its parent ' + aParent.Name);
      end;

      child.UserData := 1; // mark as touched to avoid endless loop in case if circular links
      RecursiveIndexCheck(child);
      child.UserData := 0;
    end;
  end;

begin
  var nif: TwbNifFile := aObj;

  if not (nif.NifVersion in [nfTES4, nfFO3, nfTES5, nfSSE]) then
    Exit;

  for var b in nif.BlocksByType('bhkCollisionObject') do
    RecursiveIndexCheck(b);
end;


//==============================================================================
procedure CheckUnusedBlocks(aFile: TProcFileObject; aObj: Pointer; Log: TStrings);

  procedure CountBlocksUsage(aBlock: TwbNifBlock; var aUsage: array of Integer);
  begin
    if not Assigned(aBlock) then
      Exit;

    Inc(aUsage[aBlock.Index]);

    // scan our refs only once
    if aUsage[aBlock.Index] = 1 then
      for var i := 0 to Pred(aBlock.RefsCount) do
        CountBlocksUsage(TwbNifBlock(aBlock.Refs[i].LinksTo), aUsage);
  end;

begin
  var nif: TwbNifFile := aObj;

  var roots := nif.RootNodes;

  if Length(roots) = 0 then
    Log.Add(#9 + nif.Footer.Name + ': No root node');

  if Length(roots) > 1 then
    Log.Add(#9 + nif.Footer.Name + ': Multiple root nodes');

  var BlocksUsage: array of Integer;
  SetLength(BlocksUsage, nif.BlocksCount);
  for var root in roots do
    CountBlocksUsage(root, BlocksUsage);

  for var i := Low(BlocksUsage) to High(BlocksUsage) do
    if BlocksUsage[i] = 0 then
      Log.Add(#9 + nif.Blocks[i].Name + ': Unused block not referenced from the root scenegparh');
end;


//==============================================================================
procedure CheckInvalidRepeatedChildrenNames(aFile: TProcFileObject; aObj: Pointer; Log: TStrings);
begin
  var nif: TwbNifFile := aObj;

  if not (nif.NifVersion in [nfFO3, nfTES5, nfSSE, nfFO4]) then
    Exit;

  var slNames := TStringList.Create;
  slNames.CaseSensitive := True;
  try
    for var b in nif.BlocksByType('NiObjectNET', True) do begin
      if (b.BlockType = 'BSValueNode') or b.IsEditorMarker then
        Continue;

      var n := b.EditValues['Name'];
      if (n = '') or (n = 'InvMarker') or (n = 'FurnitureMarker') then
        Continue;

      // material file in shader's name of FO4 meshes
      if (nif.NifVersion >= nfFO4) and b.IsNiObject('BSShaderProperty') then
        Continue;

      var idx := slNames.IndexOf(n);
      if idx <> - 1 then
        Log.Add(Format(#9 + b.Name + ': The same name "%s" is also used by %s', [n, TwbNifBlock(slNames.Objects[idx]).Name]))
      else
        slNames.AddObject(n, b);
    end;

    {for var block in nif.BlocksByType('NiNode', True) do begin
      var children := block.Elements['Children'];
      if not Assigned(children) then
        Continue;

      for var j: Integer := 0 to Pred(children.Count) do begin
        var b := TwbNifBlock(children[j].LinksTo);
        if not Assigned(b) then
          Continue;

        //if b.BlockType = 'BSValueNode' then
        //  Continue;

        var n := b.EditValues['Name'];
        if (n = '') or (n = 'InvMarker') or (n.StartsWith('EditorMarker', True)) then
          Continue;

        if slNames.IndexOf(n) <> - 1 then
          Log.Add(Format(#9 + block.Name + ': Name "%s" is reused in block linked by %s', [n, children[j].Path]))
        else
          slNames.Add(n);
      end;

      slNames.Clear;
    end;}
  finally
    slNames.Free;
  end;
end;


//==============================================================================
procedure CheckInvalidArrayLinks(aFile: TProcFileObject; aObj: Pointer; Log: TStrings);
var
  idx: array of Integer;
begin
  var nif: TwbNifFile := aObj;

  for var links in nif.GetLinkArrays do begin
    SetLength(idx, links.Count);
    for var i := 0 to Pred(links.Count) do begin
      var n := links[i].NativeValue;
      idx[i] := n;

      if n < 0 then
        Log.Add(#9 + links[i].Path + ' is a null link')

      else if n >= nif.BlocksCount then
        Log.Add(#9 + links[i].Path + ' is a broken link')

      else
        for var j := 0 to i - 1 do
          if idx[j] = n then begin
            Log.Add(#9 + links[i].Path + ' is a repeated link');
            Break;
          end;
    end;
  end;
end;

//==============================================================================
procedure CheckWrongLinkTypes(aFile: TProcFileObject; aObj: Pointer; Log: TStrings);
begin
  var nif: TwbNifFile := aObj;

  for var i := 0 to Pred(nif.BlocksCount) do
    for var j := 0 to Pred(nif.Blocks[i].RefsCount) do begin
      var ref := nif.Blocks[i].Refs[j];
      var b := TwbNifBlock(ref.LinksTo);
      if Assigned(b) and not b.IsNiObject(ref.Template) then
        Log.Add(#9 + ref.Path + ' links to ' + b.Name + ', expected ' + ref.Template);
    end;
end;

//==============================================================================
procedure CheckHardcodedBlockNames(aFile: TProcFileObject; aObj: Pointer; Log: TStrings);
type
  TBlockName = record BlockType, Name: string; end;
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
  var nif: TwbNifFile := aObj;

  if not (nif.NifVersion in [nfTES3, nfTES4, nfFO3, nfTES5, nfSSE, nfFO4]) then
    Exit;

  for var i := 0 to Pred(nif.BlocksCount) do begin
    var block := nif.Blocks[i];
    if not Assigned(block.Elements['Name']) then
      Continue;

    var name := block.EditValues['Name'];

    for var j := Low(cNames) to High(cNames) do
      if block.BlockType = cNames[j].BlockType then begin
        if name <> cNames[j].Name then
          Log.Add(#9 + block.Name + ': Must be named ' + cNames[j].Name);
        Break;
      end;

    if block.BlockType = 'BSValueNode' then begin
      var propername := 'AddOnNode' + block.EditValues['Value'];
      if not name.StartsWith(propername) then
         Log.Add(#9 + block.Name + ': Name must start with "' + propername + '"');
    end;

    if (nif.NifVersion > nfTES3) and (name = 'Weapon') and block.IsNiObject('NiAVObject') and not Assigned(nif.BlockByType('BSBound')) then
       Log.Add(#9 + block.Name + ': "Weapon" name is hardcoded and can be used in skeleton nifs only');

    if (nif.NifVersion = nfTES4) and block.IsNiObject('NiTriBasedGeom') then begin
      var material := block.PropertyByType('NiMaterialProperty');
      // only rendered shapes require named material (have NiTexturingProperty)
      if Assigned(material) and (material.EditValues['Name'] = '') and Assigned(block.PropertyByType('NiTexturingProperty')) then
        Log.Add(#9 + material.Name + ': Has no name which is required for NiMaterialProperty');
    end;

  end;
end;

//==============================================================================
procedure CheckCollision(aFile: TProcFileObject; aObj: Pointer; Log: TStrings);

  function BadTensor(t: Single): Boolean;
  begin
    Result := IsNaN(t) or SameValue(t, 0.0) or (t < 0.0);
  end;

  procedure GetColObjects(node: TwbNifBlock; sl: TStringList);
  begin
    if not Assigned(node) then Exit;
    var col := node.GetCollision;
    if Assigned(col) then sl.AddObject(col.Name, col);
    for var n in node.ChildrenByType('NiNode', True) do
      GetColObjects(n, sl);
  end;

begin
  var nif: TwbNifFile := aObj;

  if not (nif.NifVersion in [nfTES4, nfFO3, nfTES5, nfSSE]) then
    Exit;

  var bAnimated := Assigned(nif.BlockByType('NiControllerManager'));

  for var block in nif.BlocksByType('bhkRigidBody', True) do begin
    var shape := TwbNifBlock(block.Elements['Shape'].LinksTo);
    if not Assigned(shape) then
      Continue;

    //var layer: Integer := block.NativeValues['Havok Filter\Layer'];
    var ms := block.EditValues['Motion System'];
    var mq := block.EditValues['Motion Quality'];
    var mass: Single := block.NativeValues['Mass'];
    var bDynamic := block.IsDynamicRigidBody;

    if (ms = 'MO_SYS_FIXED') and (mq <> 'MO_QUAL_FIXED') then
      Log.Add(#9 + block.Name + ': Motion System is MO_SYS_FIXED but Motion Quality is not MO_QUAL_FIXED');

    if (nif.NifVersion < nfTES5) then begin
      if (ms <> 'MO_SYS_FIXED') and (mq = 'MO_QUAL_FIXED') then
        Log.Add(#9 + block.Name + ': Motion System is not MO_SYS_FIXED but Motion Quality is MO_QUAL_FIXED');

      if ms.EndsWith('STABILIZED') then
        Log.Add(#9 + block.Name + ': ' + ms + ' Motion System is not supported pre Skyrim');
    end;

    // MOPP should not be used in statics and animations
    if (bDynamic or (ms = 'MO_SYS_KEYFRAMED')) and (shape.BlockType = 'bhkMoppBvTreeShape') then
      Log.Add(#9 + block.Name + ': MOPP shape is used with dynamic or keyframed motion system instead of simple shape(s)');

    if not bDynamic and (block.NativeValues['Body Flags'] > 0) then
       Log.Add(#9 + block.Name + ': Body Flags (used for wind simulation) set on static collision, causes performance issues');

    //if (ms = 'MO_SYS_INVALID') and (mq <> 'MO_QUAL_INVALID') then
    //  Log.Add(#9 + block.Name + ': Motion System is MO_SYS_INVALID but Motion Quality is not MO_QUAL_INVALID');

    //if (ms = 'MO_SYS_KEYFRAMED') and (mq <> 'MO_QUAL_KEYFRAMED') then
    //  Log.Add(#9 + block.Name + ': Motion System is MO_SYS_KEYFRAMED but Motion Quality is not MO_QUAL_KEYFRAMED');

    //if (layer = 2) and (ms <> 'MO_SYS_KEYFRAMED') then
    //  Log.Add(#9 + block.Name + ': Uses animstatic layer but Motion System is not MO_SYS_KEYFRAMED');

    var minpen: Single;
    if nif.NifVersion < nfTES5 then minpen := 0.01 else minpen := 0.002;
    var pen: Single := block.NativeValues['Penetration Depth'];
    if (pen > 0.0) and (pen < minpen) then
      Log.Add(#9 + block.Name + ': Penetration Depth < ' + dfFloatToStr(minpen) + ' causes Havok issues due to precision loss');

    // skip animated meshes, they are treated as having "infinite" mass in the engine
    if bDynamic and not bAnimated then begin
      if SameValue(mass, 0.0) then
        Log.Add(#9 + block.Name + ': Zero moveable collision mass');

      if (mass > 0.0) and (mass < 0.95) then
        Log.Add(#9 + block.Name + ': Moveable mass < 1.0 causes physics issues due to precision loss');

      if mass > 0.0 then
        if BadTensor(block.NativeValues['Inertia Tensor\m11']) or
           BadTensor(block.NativeValues['Inertia Tensor\m22']) or
           BadTensor(block.NativeValues['Inertia Tensor\m33'])
        then
          Log.Add(#9 + block.Name + ': Moveable mass is not zero but Inertia Tensor matrix is zero or invalid');

      if block.NativeValues['Max Angular Velocity'] < 1.0 then
        Log.Add(#9 + block.Name + ': Max Angular Velocity < 1.0 causes sinking through the terrain');

      if (nif.NifVersion >= nfTES5) and (block.EditValues['Enable Deactivation'] = 'no') then
        Log.Add(#9 + block.Name + ': Enable Deactivation=no causes performance issues on dynamic bodies');

      if (nif.NifVersion < nfTES5) and (block.EditValues['Deactivator Type'] = 'DEACTIVATOR_NEVER') then
        Log.Add(#9 + block.Name + ': DEACTIVATOR_NEVER causes performance issues on dynamic bodies');

      if block.EditValues['Solver Deactivation'] = 'SOLVER_DEACTIVATION_OFF' then
        Log.Add(#9 + block.Name + ': SOLVER_DEACTIVATION_OFF causes performance issues on dynamic bodies');
    end;

  end;

  for var block in nif.BlocksByType('bhkConstraint', True) do begin
    var s := 'Ragdoll';
    if block.BlockType = 'bhkMalleableConstraint' then s := 'Hinge\' + s else
    if block.BlockType = 'bhkBreakableConstraint' then s := 'Constraint Data\' + s;
    var el := block.Elements[s + '\Cone Max Angle'];
    if Assigned(el) then
      if SameValue(el.NativeValue, 0.0) then
        Log.Add(#9 + el.Path + ': 0.0 value causes jittering');
  end;

  var cols := TStringList.Create;
  try
    // list of animated collision objects
    cols.Sorted := True;
    cols.Duplicates := dupIgnore;
    // collision of nodes (and their children) targeted by controlled blocks
    for var block in nif.BlocksByType('NiControllerSequence', True) do
      for var b in block.Elements['Controlled Blocks'] do
        if GetControlledBlockName(b, 'Controller Type') = 'NiTransformController' then begin
          var nodename := GetControlledBlockName(b, 'Node Name');
          if nodename = '' then Continue;
          var interp := TwbNifBlock(b.Elements['Interpolator'].LinksTo);
          if not Assigned(interp) or (interp.BlockType <> 'NiTransformInterpolator') then Continue;
          if interp.Elements['Data'].LinksTo = nil then Continue;
          GetColObjects(nif.BlockByName(nodename), cols);
        end;

    // also nodes with NiTransformController
    for var block in nif.BlocksByType('NiNode', True) do begin
      var col := block.GetCollision;
      if not Assigned(col) then Continue;
      var contr := block.GetController('NiTransformController', True);
      if not Assigned(contr) then Continue;
      var interp := TwbNifBlock(contr.Elements['Interpolator'].LinksTo);
      if not Assigned(interp) or (interp.BlockType <> 'NiTransformInterpolator') then Continue;
      if interp.Elements['Data'].LinksTo = nil then Continue;
      GetColObjects(block, cols);
    end;

    for var col in nif.BlocksByType('bhkCollisionObject', True) do begin
      var rigid := TwbNifBlock(col.Elements['Body'].LinksTo);
      if Assigned(rigid) and (Integer(rigid.NativeValues['Havok Filter\Layer']) in [2, 28]) and (cols.IndexOfObject(col) = -1) then
        Log.Add(#9 + col.Name + ': Animated layer is used on non animated collision');
    end;

    for var i := 0 to Pred(cols.Count) do begin
      var col := TwbNifBlock(cols.Objects[i]);
      if col.BlockType <> 'bhkCollisionObject' then Continue;
      var rigid := TwbNifBlock(col.Elements['Body'].LinksTo);
      if not Assigned(rigid) then Continue;

      if not (Integer(rigid.NativeValues['Havok Filter\Layer']) in [2, 4, 5, 6, {10,} 14, 15, 16, 28]) then
        Log.Add(#9 + rigid.Name + ': Animated collision must use Animated layer');

      // SET_LOCAL is set at runtime in previous games
      if nif.NifVersion in [nfTES5, nfSSE] then
        if (Integer(rigid.NativeValues['Havok Filter\Layer']) in [2, 28]) and not col.NativeValues['Flags\SET_LOCAL'] then
          Log.Add(#9 + col.Name + ': Animated layer collision is missing SET_LOCAL flag');

      if nif.NifVersion in [nfTES4, nfFO3] then
        if not col.NativeValues['Flags\USE_VEL'] and (rigid.EditValues['Motion System'] = 'MO_SYS_KEYFRAMED') then
          Log.Add(#9 + col.Name + ': Transformed keyframed animated collision is missing USE_VEL flag');
    end;
  finally
    cols.Free;
  end;
end;

//==============================================================================
procedure CheckCollisionMOPP(aFile: TProcFileObject; aObj: Pointer; Log: TStrings);
begin
  var nif: TwbNifFile := aObj;

  if not (nif.NifVersion in [nfTES4, nfFO3, nfTES5, nfSSE]) then
    Exit;

  if not Assigned(nif.BlockByType('bhkMoppBvTreeShape')) then
    Exit;

  // MOPP collision complexity check
  var tris := 0; var coltris := 0;
  var verts := 0; var colverts := 0;
  for var i := 0 to Pred(nif.BlocksCount) do begin
    var block := nif.Blocks[i];

    if block.BlockType = 'bhkNiTriStripsShape' then begin
      for var data in block.Elements['Strips Data'] do begin
        var shape := TwbNifBlock(data.LinksTo);
        if not Assigned(shape) then Continue;
        if shape.BlockType = 'NiTriStripsData' then
          Inc(coltris, Integer(shape.NativeValues['Num Triangles']));
      end;
    end

    else if block.BlockType = 'hkPackedNiTriStripsData' then
       Inc(coltris, block.Elements['Triangles'].Count)

    else if block.BlockType = 'bhkCompressedMeshShapeData' then begin
      Inc(coltris, block.Elements['Big Tris'].Count);
      Inc(colverts, block.Elements['Big Verts'].Count);
      for var chunk in block.Elements['Chunks'] do begin
        var stripslen := 0;
        for var strip in chunk.Elements['Strip Lengths'] do begin
          var s: Integer := strip.NativeValue;
          Inc(coltris, s - 2);
          Inc(stripslen, s);
        end;
        Inc(coltris, (chunk.Elements['Indices'].Count - stripslen) div 3);
        Inc(colverts, (chunk.Elements['Vertices'].Count) div 3);
      end;
    end

    else if block.IsNiObject('NiTriBasedGeom') then begin
      var data := TwbNifBlock(block.Elements['Data'].LinksTo);
      if not Assigned(data) then Continue;
      if data.IsNiObject('NiTriBasedGeomData') then begin
        Inc(tris, Integer(data.NativeValues['Num Triangles']));
        Inc(verts, Integer(data.NativeValues['Num Vertices']));
      end;
    end

    else if block.IsNiObject('BSTriShape') then begin
      Inc(tris, Integer(block.NativeValues['Num Triangles']));
      Inc(verts, Integer(block.NativeValues['Num Vertices']));
    end;
  end;

  if (tris > 1000) and (coltris > 1000) then begin
    var ratio := Round(coltris / tris * 100);
    if ratio > 50 then
      Log.Add(#9 + Format('MOPP collision tris to geometry tris ratio is %d%% (%d/%d), poorly optimized collision', [ratio, coltris, tris]));
  end;

  if (Verts > 1000) and (colverts > 1000) then begin
    var ratio := Round(colverts / verts * 100);
    if ratio > 50 then
      Log.Add(#9 + Format('MOPP collision verts to geometry verts ratio is %d%% (%d/%d), poorly optimized collision', [ratio, colverts, verts]));
  end;
end;

//==============================================================================
{procedure CheckSubShapesCollisionOrder(aFile: TProcFileObject; aObj: Pointer; Log: TStrings);
var
  j, prevmat, mat: Integer;
begin
  var nif: TwbNifFile := aObj;

  if not (nif.NifVersion in [nfTES4, nfFO3]) then
    Exit;

  for var block in nif.BlocksByType('hkPackedNiTriStripsData') do begin
    var subshapes := block.Elements['Sub Shapes'];
    if not Assigned(subshapes) then
      Continue;

    prevmat := -1;
    for j := 0 to Pred(subshapes.Count) do begin
      mat := subshapes[j].NativeValues['Material'];
      if mat < prevmat then begin
        Log.Add(#9 + block.Name + ': Invalid subshapes material order (has to be ascending)');
        Break;
      end;
      prevmat := mat;
    end;
  end;

end;
}
//==============================================================================
procedure CheckSkinningIssues(aFile: TProcFileObject; aObj: Pointer; Log: TStrings);

  function GetSkinPartition(shape: TwbNifBlock): TwbNifBlock;
  begin
    Result := shape.GetSkin;
    if not Assigned(Result) then Exit;
    Result := TwbNifBlock(Result.Elements['Skin Partition'].LinksTo);
  end;

begin
  var nif: TwbNifFile := aObj;

  if (nif.NifVersion in [nfFO3, nfTES5, nfSSE]) and (nif.RootNode.BlockType = 'NiNode') then
    for var skin in nif.BlocksByType('NiSkinInstance', True) do begin

      if skin.BlockType <> 'BSDismemberSkinInstance' then begin
        Log.Add(#9 + skin.Name + ': Must be BSDismemberSkinInstance');
        Continue;
      end;

      var skeleton := TwbNifBlock(skin.Elements['Skeleton root'].LinksTo);
      if not Assigned(skeleton) or (skeleton.Index <> 0) then
        Log.Add(#9 + skin.Name + ': Invalid Skeleton Root');

      var parts := skin.Elements['Partitions'];
      with TStringList.Create do try
        for var i := 0 to Pred(parts.Count) do begin
          var num := Integer(parts[i].NativeValues['Body Part']);
          var p := parts[i].EditValues['Body Part'];
          if (nif.NifVersion in [nfTES5, nfSSE]) and ( (num < 30) or (num > 62) ) then
            Log.Add(#9 + parts[i].Path + ': Invalid body part ' + p);

          if IndexOf(p) <> -1 then
            Log.Add(#9 + parts[i].Path + ': Repeated body part ' + p)
          else
            Add(p);
        end;
      finally
        Free;
      end;

      var SkinPartition := Skin.Elements['Skin Partition'].LinksTo;
      if Assigned(SkinPartition) and (parts.Count < SkinPartition.NativeValues['Num Partitions']) then
        Log.Add(#9 + skin.Name + ': Has lower Num Partitions than in ' + TwbNifBlock(SkinPartition).Name);
    end;

  if nif.NifVersion in [nfTES5, nfSSE, nfFO4] then
    for var shape in nif.BlocksByType('BSDynamicTriShape', True) do
      if shape.GetSkin = nil then
        Log.Add(#9 + shape.Name + ': Missing skin instance (acceptable only in headparts and facegen)');

  if (nif.NifVersion in [nfTES5, nfSSE]) and nif.FileName.EndsWith('_0.nif', True) and Assigned(nif.BlockByType('NiSkinInstance', True)) then repeat
    var f := aFile.FileName.Replace('_0.nif', '_1.nif', [rfIgnoreCase]);
    var nif1 := TwbNifFile.Create;
    try
      // silently ignore loading issues if any
      try
        if Assigned(aFile.FileEntry) then begin
          if not aFile.FileEntry.Archive.FileExists(f) then Break;
          nif1.LoadFromData(aFile.FileEntry.Archive.Unpack(f));
        end
        else begin
          if not FileExists(f) then Break;
          nif1.LoadFromFile(f);
        end;
      except Break; end;

      var r0 := nif.RootNode;
      var r1 := nif1.RootNode;
      if not Assigned(r0) or not Assigned(r1) then
        Break;

      var m0 := r0.ChildrenByType('NiNode');
      var m1 := r1.ChildrenByType('NiNode');
      if Length(m0) <> Length(m1) then begin
        Log.Add(#9 + nif.RootNode.Name + ': Bone counts between morph models don''t match in _0.nif and _1.nif');
        Break;
      end;

      var sl0 := TStringList.Create; var sl1 := TStringList.Create;
      try
        for var n in m0 do sl0.Add(n.EditValues['Name']);
        for var n in m1 do sl1.Add(n.EditValues['Name']);
        sl0.Sort; sl1.Sort;
        if sl0.Text <> sl1.Text then
          Log.Add(#9 + nif.RootNode.Name + ': Bones between morph models don''t match in _0.nif and _1.nif');
      finally
        sl0.Free; sl1.Free;
      end;

      m0 := r0.ChildrenByType('BSTriShape');
      m1 := r1.ChildrenByType('BSTriShape');
      if Length(m0) = 0 then m0 := r0.ChildrenByType('NiTriBasedGeom');
      if Length(m1) = 0 then m1 := r1.ChildrenByType('NiTriBasedGeom');
      if Length(m0) <> Length(m1) then begin
        Log.Add(#9 + nif.RootNode.Name + ': Shape counts between morph models don''t match in _0.nif and _1.nif');
        Break;
      end;

      for var i := Low(m0) to High(m0) do begin
        var b0 := m0[i];
        var b1 := m1[i];
        if b0.EditValues['Name'] <> b1.EditValues['Name'] then begin
          Log.Add(#9 + b0.Name + ': Shapes names between morph models don''t match in _0.nif and _1.nif');
          Continue;
        end;
        var p0 := GetSkinPartition(b0);
        var p1 := GetSkinPartition(b1);
        if not Assigned(p0) or not Assigned(p1) then
          Continue;
        if p0.NativeValues['Num Partitions'] <> p1.NativeValues['Num Partitions'] then begin
          Log.Add(#9 + p0.Name + ': Skin partition counts between morph models don''t match in _0.nif and _1.nif');
          Continue;
        end;
        for var j := 0 to Pred(p0.Elements['Partitions'].Count) do begin
          var part0 := p0.Elements['Partitions'][j];
          var part1 := p1.Elements['Partitions'][j];
          if part0.NativeValues['Num Vertices'] <> part1.NativeValues['Num Vertices'] then begin
            Log.Add(#9 + part0.Path + ': Model vertex counts between morph models don''t match in _0.nif and _1.nif');
            Continue;
          end;
        end;
      end;
    finally
      nif1.Free;
    end;
  until True;

end;

//==============================================================================
procedure CheckParticleSystem(aFile: TProcFileObject; aObj: Pointer; Log: TStrings);
const
  cEmitterLifeSpanMargin = 12;
var
  modifier: TwbNifBlock;
begin
  var nif: TwbNifFile := aObj;

  // unnamed modifier
  for var block in nif.BlocksByType('NiPSysModifier', True) do
    if block.EditValues['Name'] = '' then
      Log.Add(#9 + block.Name + ': Name is not set');

  // invalid modifier in controller
  for var block in nif.BlocksByType('NiPSysModifierCtlr', True) do begin
    var modname := block.EditValues['Modifier Name'];
    if modname <> '' then
      modifier := nif.BlockByName(modname)
    else
      modifier := nil;

    if not Assigned(modifier) or not modifier.IsNiObject('NiPSysModifier', True)  then
      Log.Add(#9 + block.Name + ': Modifier Name "' + modname + '" points to invalid block');
  end;

  // too long particles lifetime
  for var block in nif.BlocksByType('NiPSysEmitter', True) do begin
    var lifespan := block.NativeValues['Life Span'];
    if lifespan > cEmitterLifeSpanMargin then
      Log.Add(#9 + block.Name + ': Life Span of ' + IntToStr(lifespan) + ' might negatively affect performance');
  end;

  // orphan "-Emitter" nodes
  for var block in nif.BlocksByType('NiAVObject', True) do begin
    var name := block.EditValues['Name'];
    if not name.EndsWith('-Emitter', True) then
      Continue;

    // referenced by NiPSysEmitter
    var bFound := False;
    for var ref in block.ReferencedBy do begin
      var refblock := ref;
      while not (refblock is TwbNifBlock) do refblock := refblock.Parent;
      if TwbNifBlock(refblock).IsNiObject('NiPSysEmitter') then begin
        bFound := True;
        Break;
      end;
    end;

    // or same named NiParticleSystem is present
    bFound := bFound or Assigned(nif.BlockByName(Copy(name, 1, Length(name) - 8), 'NiParticleSystem'));

    if not bFound then
      Log.Add(#9 + block.Name + ': "' + name + '" is an emitter but missing the same named NiParticleSystem and not a target of any NiPSysEmitter');
  end;

  // Num Subtexture Offsets
  var num := 16;
  if Nif.NifVersion >= nfTES5 then num := 256;
  for var Block in Nif.BlocksByType('NiParticlesData', True) do
    if Block.NativeValues['Num Subtexture Offsets'] > num then
      Log.Add(#9 + Block.Name + ': Num Subtexture Offsets cannot be higher than ' + IntToStr(num));

  // mesh emitters
  if nif.NifVersion >= nfSSE then
  for var block in nif.BlocksByType('NiPSysMeshEmitter', True) do begin
    var meshes := block.Elements['Emitter Meshes'];
    for var i := 0 to Pred(meshes.Count) do begin
      var mesh := TwbNifBlock(meshes[i].LinksTo);
      if not Assigned(mesh) or (mesh.BlockType <> 'BSTriShape') then Continue;

      if (mesh.NativeValues['Particle Data Size'] = 0) and not Assigned(mesh.ExtraDataByType('BSPositionData')) then
        Log.Add(#9 + mesh.Name + ': Has no Particle Data or BSPositionData but used as mesh emitter in ' + block.Name);

      //if block.EditValues['Emission Type'] <> 'EMIT_FROM_VERTICES' then
      //  Log.Add(#9 + block.Name + ': Emission Type must be EMIT_FROM_VERTICES for shape emitters');

      //if (block.EditValues['Initial Velocity Type'] = 'VELOCITY_USE_NORMALS') and not mesh.NativeValues['VertexDesc\VF\VF_NORMAL'] then
      //  Log.Add(#9 + block.Name + ': Initial Velocity Type VELOCITY_USE_NORMALS requires normals in ' + mesh.Name);
    end;
  end;



  //for var block in nif.BlocksByType('NiNode', True) do
  //  if block.EditValues['Name'].EndsWith('Emitter', True) and (Length(block.ChildrenByType('NiParticleSystem', True)) = 0) then
  //    Log.Add(#9 + block.Name + ': "' + block.EditValues['Name'] + '" is an emitter but doesn''t have NiParticleSystem in children');
end;

//==============================================================================
procedure CheckTargetField(aFile: TProcFileObject; aObj: Pointer; Log: TStrings);
var
  nif: TwbNifFile;
  Target, Parent: TwbNifBlock;

  function GetCollisionParentNode(aBlock: TwbNifBlock): TwbNifBlock;
  begin
    for Result in nif.BlocksByType('NiAVObject', True) do begin
      var col := TwbNifBlock(Result.Elements['Collision Object'].LinksTo);
      if col = aBlock then
        Exit;
    end;
    Result := nil;
  end;

begin
  nif := aObj;

  // check collision target
  for var col in nif.BlocksByType('bhkNiCollisionObject', True) do begin
    var Body := TwbNifBlock(col.Elements['Body'].LinksTo);
    if not Assigned(Body) then
      Log.Add(#9 + col.Name + ': Missing collision Body');

    Target := TwbNifBlock(col.Elements['Target'].LinksTo);

    if nif.NifVersion >= nfTES5 then
      if Assigned(Target) and (Target.EditValues['Name'] = '') then
        Log.Add(#9 + col.Name + ': The used Target node must have a name');

    Parent := GetCollisionParentNode(col);
    if not Assigned(Parent) then
      Continue;

    if Target <> Parent then
      Log.Add(#9 + col.Name + ': Invalid Target field');

    // additional Target in bhkCompressedMeshShape
    if not Assigned(Body) or not Body.IsNiObject('bhkWorldObject') then
      Continue;

    var Shape := TwbNifBlock(Body.Elements['Shape'].LinksTo);
    if not Assigned(Shape) then begin
      if Body.BlockType <> 'bhkAabbPhantom' then
        Log.Add(#9 + Body.Name + ': Missing rigid body shape');
      Continue;
    end;

    if not Shape.IsNiObject('bhkMoppBvTreeShape') then
      Continue;

    var MeshShape := TwbNifBlock(Shape.Elements['Shape'].LinksTo);
    if not Assigned(MeshShape) or not MeshShape.IsNiObject('bhkCompressedMeshShape') then
      Continue;

    Target := TwbNifBlock(MeshShape.Elements['Target'].LinksTo);

    if Assigned(Target) and (Target.EditValues['Name'] = '') then
      Log.Add(#9 + MeshShape.Name + ': The used Target node must have a name');

    // can also target the root node
    if (Target <> Parent) and (Target <> nif.RootNode) then
      Log.Add(#9 + MeshShape.Name + ': Invalid Target field');
  end;


  // check controller target
  for var block in nif.BlocksByType('NiObjectNET', True) do begin
    var controller := TwbNifBlock(block.Elements['Controller'].LinksTo);
    if not Assigned(controller) then
      Continue;

    repeat
      if not controller.IsNiObject('NiTimeController') then begin
        Log.Add(#9 + block.Name + ': uses controller ' + controller.Name + ' which is not a descendant of NiTimeController');
        Break;
      end;

      Target := TwbNifBlock(controller.Elements['Target'].LinksTo);
      if not Assigned(Target) then
        Log.Add(#9 + controller.Name + ': Invalid Target field')
      else if block <> Target then
        Log.Add(#9 + controller.Name + ': Used by ' + block.Name + ' but targets ' + Target.Name);

      // continue down the chain of Next Controller
      controller := TwbNifBlock(controller.Elements['Next Controller'].LinksTo);
    until not Assigned(controller);
  end;


  // check node names in anims
  for var manager in nif.BlocksByType('NiControllerManager') do
    for var seq in manager.Elements['Controller Sequences'] do begin
      var sequence := TwbNifBlock(seq.LinksTo);
      if not Assigned(sequence) then
        Continue;

      if Assigned(sequence.Elements['Manager']) and (sequence.Elements['Manager'].LinksTo <> manager) then
        Log.Add(#9 + sequence.Name + ': Invalid Manager field, must be ' + manager.Name);

      if Assigned(sequence.Elements['Accum Root Name']) then begin
        var rootname := sequence.EditValues['Accum Root Name'];
        if (rootname = '') or not Assigned(nif.BlockByName(rootname, 'NiAVObject')) then
          Log.Add(#9 + sequence.Name + ': Invalid Accum Root Name "' + rootname  + '", must be existing NiAVObject');
      end;

      // check controlled block target
      for var block in sequence.Elements['Controlled Blocks'] do begin
        var tname := GetControlledBlockName(block, 'Node Name');
        var t: TwbNifBlock := nil;
        if tname <> '' then
          t := nif.BlockByName(tname, 'NiAVObject');

        if not Assigned(t) then begin
          Log.Add(#9 + block.Path + ': Invalid Node Name "' + tname + '", must be existing NiAVObject');
          Continue;
        end;

        if t.Hidden then
          Log.Add(#9 + block.Path + ': Target node "' + tname + '" is hidden');

        var proptype := GetControlledBlockName(block, 'Property Type');
        if (proptype <> '') and not Assigned(t.PropertyByType(proptype)) then
          Log.Add(#9 + block.Path + ': Property ' + proptype  + ' not found for Target "' + tname + '"');
      end;
    end;

end;

//==============================================================================
procedure CheckAnimStopTime(aFile: TProcFileObject; aObj: Pointer; Log: TStrings);

  procedure CheckKeys(data: TwbNifBlock; keys: TdfElement; const aStopTime: string);
  begin
    if not Assigned(keys) or (keys.Count = 0) then
      Exit;

    var t := keys[Pred(keys.Count)].EditValues['Time'];
    //Log.Add(keys.Path + #9 + t);
    if t <> aStopTime then
      Log.Add(#9 + data.Name + ': Time ' + t + ' of the last key in ' + keys.Path + ' doesn''t match Stop Time ' + aStopTime);
  end;

begin
  var nif: TwbNifFile := aObj;

  for var block in nif.BlocksByType('NiControllerSequence') do begin

    var StopTime := block.EditValues['Stop Time'];

    // check in interpolators
    var entries := block.Elements['Controlled Blocks'];
    for var i := 0 to Pred(entries.Count) do begin
      var interpolator := TwbNifBlock(entries[i].Elements['Interpolator'].LinksTo);
      if not Assigned(interpolator) then
        Continue;

      if interpolator.Elements['Data'] = nil then
        Continue;

      var data := TwbNifBlock(interpolator.Elements['Data'].LinksTo);
      if not Assigned(data) then
        Continue;

      CheckKeys(data, data.Elements['Data\Keys'], StopTime);
      CheckKeys(data, data.Elements['Translations\Keys'], StopTime);
      CheckKeys(data, data.Elements['Scales\Keys'], StopTime);
      CheckKeys(data, data.Elements['Quaternion Keys'], StopTime);
      CheckKeys(data, data.Elements['XYZ Rotations\[0]\Keys'], StopTime);
      CheckKeys(data, data.Elements['XYZ Rotations\[1]\Keys'], StopTime);
      CheckKeys(data, data.Elements['XYZ Rotations\[2]\Keys'], StopTime);
    end;


    // check in NiTextKeysExtraDaya
    var xdata := TwbNifBlock(block.Elements['Text Keys'].LinksTo);
    if not Assigned(xdata) then
      Continue;

    var keys := xdata.Elements['Text Keys'];
    if not Assigned(keys) then
      Continue;

    for var j := Pred(keys.Count) downto 0 do begin
      var key := keys[j];
      if key.EditValues['Value'] <> 'end' then
        Continue;

      if key.EditValues['Float'] <> StopTime then
        Log.Add(#9 + xdata.Name + ': The value of "end" key ' + key.EditValues['Float'] + ' doesn''t match Stop Time ' + StopTime);

      Break;
    end;

  end;
end;

//==============================================================================
procedure CheckBSXFlags(aFile: TProcFileObject; aObj: Pointer; Log: TStrings);
const
  cFlags: array [0..9] of string = (
    'Animated', 'Havok', 'Ragdoll', 'Complex',
    'Addon', 'Editor Marker', 'Dynamic',
    '', '', 'External Emit'
  );
  cWhy: array [0..9] of string = (
    'Controller or AddOn', 'Collision', 'Constraint', 'multiple Dynamic rigid bodies',
    'BSValueNode/AttachLight/FlameNode', 'EditorMarker', 'Dynamic rigid body',
    '', '', 'Emitting shader'
  );
var
  flags, newflags: Cardinal;
  bsxname: string;

  procedure CheckFlag(aBit: Cardinal; const aName, aReason: string);
  begin
    var mask: Cardinal := 1 shl aBit;

    if (newflags and mask <> 0) and (flags and mask = 0) then
      Log.Add(Format(#9'%s: Has %s but bit %d (%s) is not set', [bsxname, aReason, aBit, aName]));

    if (newflags and mask = 0) and (flags and mask <> 0) then
      Log.Add(Format(#9'%s: No %s but bit %d (%s) is set', [bsxname, aReason, aBit, aName]));
  end;

begin
  var nif: TwbNifFile := aObj;

  if nif.NifVersion < nfFO3 then
    Exit;

  var bsx := nif.BlockByType('BSXFlags');
  if Assigned(bsx) then begin
    flags := bsx.NativeValues['Flags'];
    bsxname := bsx.Name;
  end
  else begin
    flags := 0;
    bsxname := 'Missing BSXFlags';
  end;

  newflags := nif.DetectBSXFlags;

  for var i := Low(cFlags) to High(cFlags) do begin
    if cFlags[i] = '' then Continue;
    // don't report Complex and Dynamic flags in FO4 meshes, dynamic body detection doesn't work there
    if (nif.NifVersion >= nfFO4) and (i in [3, 6]) then Continue;

    var mask: Cardinal := 1 shl i;
    if (newflags and mask <> 0) and (flags and mask = 0) then
      Log.Add(Format(#9'%s: Has %s but bit %d (%s) is not set', [bsxname, cWhy[i], i, cFlags[i]]));
    if (newflags and mask = 0) and (flags and mask <> 0) then
      Log.Add(Format(#9'%s: No %s but bit %d (%s) is set', [bsxname, cWhy[i], i, cFlags[i]]));
  end;

  if Assigned(bsx) then
    if (newFlags = 0) then
      Log.Add(#9 + bsx.Name + ': BSXFlags is present but not needed');
end;

//==============================================================================
procedure CheckConsistencyFlags(aFile: TProcFileObject; aObj: Pointer; Log: TStrings);
var
  f, f2: string;
begin
  var nif: TwbNifFile := aObj;

  if not (nif.NifVersion in [nfTES4, nfFO3, nfTES5]) then
    Exit;

  // static - vertex buffer is uploaded to the GPU only once, only data marked with keep flags is kept
  // mutable - vertex buffer can be re-uploaded to the GPU multiple times (as long as something is marked as dirty)
  // volatile - vertex buffer is re-uploaded to the GPU every time it's being rendered. Applied if geometry is skinned, but doesn't support HW skinning

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

    {
    // The Gamebryo way
    if Assigned(shape.Elements['Skin Instance']) and (shape.Elements['Skin Instance'].LinksTo <> nil) then
      f := 'CT_VOLATILE'
    else if shape.Elements['Controller'].LinksTo <> nil then
      f := 'CT_MUTABLE'
    else
      f := 'CT_STATIC';
    }
    f2 := data.EditValues['Consistency Flags'];
    if f2 <> f then
      Log.Add(#9 + data.Name + ': Invalid Consistency Flags value ' + f2 + ', should be ' + f + ' (doesn''t matter for LODs)');
  end;

end;

//==============================================================================
procedure CheckTextureSetSlots(aFile: TProcFileObject; aObj: Pointer; Log: TStrings);
begin
  var nif: TwbNifFile := aObj;

  for var shader in nif.BlocksByType('BSShaderProperty', True) do begin
    var texsetlink := shader.Elements['Texture Set'];
    if not Assigned(texsetlink) then
      Continue;

    var texset := TwbNifBlock(texsetlink.LinksTo);
    if not Assigned(texset) then
      Continue;

    var textures: TdfElement := texset.Elements['Textures'];
    if not Assigned(textures) then
      Continue;

    for var i := 0 to Pred(textures.Count) do
      if not TPath.HasValidPathChars(textures[i].EditValue, False) then
        Log.Add(#9 + textures[i].Path + ': Invalid characters in ' + textures[i].EditValue)
      else if TPath.IsPathRooted(textures[i].EditValue) then
        Log.Add(#9 + textures[i].Path + ': Absolute path ' + textures[i].EditValue);

    if nif.NifVersion = nfFO3 then begin
      if (textures[4].EditValue <> '') and not (
         shader.NativeValues['Shader Flags 1\Environment_Mapping'] or
         shader.NativeValues['Shader Flags 1\Eye_Environment_Mapping'] or
         shader.NativeValues['Shader Flags 1\Window_Environment_Mapping']
      ) then
        Log.Add(#9 + shader.Name + ': Has assigned envmap texture in ' + texset.Name + ' but missing envmap flag');
    end;

    if nif.NifVersion in [nfTES5, nfSSE] then begin
      var ShaderType := Shader.EditValues['Shader Type'];
      if (Textures.Count > 2) and (Textures[2].EditValue <> '') then
        if  (ShaderType <> 'Glow Shader') and
            (ShaderType <> 'Facegen') and
            (ShaderType <> 'Skin Tint') and
        not (Shader.NativeValues['Shader Flags 2\Soft_Lighting']) and
        not (Shader.NativeValues['Shader Flags 2\Rim_Lighting'])
        then
          Log.Add(#9 + texset.Name + ': Has texture assigned in slot 2, but is not used');

      if (Textures.Count > 3) and (Textures[3].EditValue <> '') then
        if (ShaderType <> 'Parallax') and
           (ShaderType <> 'Facegen')
        then
          Log.Add(#9 + texset.Name + ': Has texture assigned in slot 3, but is not used');

      if (Textures.Count > 4) and (Textures[4].EditValue <> '') then
        if (ShaderType <> 'Environment Map') and
           (ShaderType <> 'MultiLayer Parallax') and
           (ShaderType <> 'Eye Envmap')
        then
          Log.Add(#9 + texset.Name + ': Has texture assigned in slot 4, but is not used');

      if (Textures.Count > 5) and (Textures[5].EditValue <> '') then
        if (ShaderType <> 'Environment Map') and
           (ShaderType <> 'MultiLayer Parallax') and
           (ShaderType <> 'Eye Envmap') and
           (ShaderType <> 'PBR')
        then
          Log.Add(#9 + texset.Name + ': Has texture assigned in slot 5, but is not used');

      if (Textures.Count > 6) and (Textures[6].EditValue <> '') then
        if (ShaderType <> 'Facegen') and
           (ShaderType <> 'MultiLayer Parallax') and
           (
             (ShaderType <> 'PBR') or
             (
               (not Shader.NativeValues['PBR Material Data\Feature Flags\Two Layer']) and
               (not Shader.NativeValues['PBR Material Data\Feature Flags\Fuzz'])
             )
           )
        then
          Log.Add(#9 + texset.Name + ': Has texture assigned in slot 6, but is not used');

      if (Textures.Count > 7) and (Textures[7].EditValue <> '') then
        if (not Shader.NativeValues['Shader Flags 2\Back_Lighting']) and
           (not Shader.NativeValues['Shader Flags 1\Model_Space_Normals']) and
           (
             (ShaderType <> 'PBR') or
             (
               (not Shader.NativeValues['PBR Material Data\Feature Flags\Two Layer']) and
               (not Shader.NativeValues['PBR Material Data\Feature Flags\Subsurface'])
             )
           )
        then
          Log.Add(#9 + texset.Name + ': Has texture assigned in slot 7, but is not used');
    end;
  end;
end;

//==============================================================================
procedure CheckNiAlphaProperty(aFile: TProcFileObject; aObj: Pointer; Log: TStrings);
const
  SRC_ALPHA = 6;
  INV_SRC_ALPHA = 7;
  DEST_ALPHA = 8;
  INV_DEST_ALPHA = 9;
  SRC_ALPHA_SATURATE = 10;
  AlphaModes = [SRC_ALPHA, INV_SRC_ALPHA, DEST_ALPHA, INV_DEST_ALPHA, SRC_ALPHA_SATURATE];
  {<option value="0" name="ONE" />
  <option value="1" name="ZERO" />
  <option value="2" name="SRC_COLOR" />
  <option value="3" name="INV_SRC_COLOR" />
  <option value="4" name="DEST_COLOR" />
  <option value="5" name="INV_DEST_COLOR" />
  <option value="6" name="SRC_ALPHA" />
  <option value="7" name="INV_SRC_ALPHA" />
  <option value="8" name="DEST_ALPHA" />
  <option value="9" name="INV_DEST_ALPHA" />
  <option value="10" name="SRC_ALPHA_SATURATE" />}
begin
  var nif: TwbNifFile := aObj;

  for var i := 0 to Pred(nif.BlocksCount) do begin
    var shape := nif.Blocks[i];
    if not (shape.IsNiObject('BSTriShape') or shape.IsNiObject('NiGeometry')) then
      Continue;

    var prop := shape.PropertyByType('NiAlphaProperty');
    if not Assigned(prop) then
      Continue;

    if Assigned(shape.PropertyByType('BSShaderNoLightingProperty')) then
      Continue;

    var flags: Cardinal := prop.NativeValues['Flags'];
    var alpha_blend := flags and 1 = 1;

    var shader := shape.PropertyByType('BSShaderProperty', True);
    if Assigned(shader) and (nif.NifVersion < nfFO4) then
      if alpha_blend and not shader.NativeValues['Shader Flags 2\Assume_Shadowmask'] then
        Log.Add(#9 + prop.Name + ': Blend alpha forces the object to be in single-pass mode, and can cause lighting issues if multiple lights are illuminating the object');

    //var src_blend_mode := flags shr 1 and $f;
    //var dst_blend_mode := flags shr 5 and $f;

    //if alpha_blend and not ( (src_blend_mode in AlphaModes) and (dst_blend_mode in AlphaModes) ) then
    //  Log.Add(#9 + prop.Name + ': Alpha Blending is enabled but blending modes are not alpha ones');
  end;
end;

//==============================================================================
procedure CheckShaderTypeFlags(aFile: TProcFileObject; aObj: Pointer; Log: TStrings);
var
  i: Integer;
  bExternalEmitShader: Boolean;
  EmitShader: string;
begin
  var nif: TwbNifFile := aObj;

  if not (nif.NifVersion in [nfFO3, nfTES5, nfSSE, nfFO4]) then
    Exit;

  bExternalEmitShader := False;
  var bFaceGen := Assigned(nif.BlockByName('BSFaceGenNiNodeSkinned', 'NiNode'));

  for i := 0 to Pred(nif.BlocksCount) do begin
    var shape := nif.Blocks[i];
    if not (shape.IsNiObject('BSTriShape') or shape.IsNiObject('NiGeometry')) then
      Continue;

    var bHasVertexColors := False;
    if shape.IsNiObject('NiGeometry') then begin
      var shapedata := TwbNifBlock(shape.Elements['Data'].LinksTo);
      if Assigned(shapedata) then
        bHasVertexColors := shapedata.NativeValues['Has Vertex Colors'];
    end else
      bHasVertexColors := shape.NativeValues['VertexDesc\VF\VF_COLORS'];

    var shader: TwbNifBlock := shape.PropertyByType('BSShaderProperty', True);
    if not Assigned(shader) then begin
      // editor markers don't need shader
      if shape.IsEditorMarker then
        Continue;

      // shapes without tangents are not rendered
      if shape.IsNiObject('BSTriShape') and not shape.NativeValues['VertexDesc\VF\VF_TANGENT'] then
        Continue;

      // mesh emitters don't need shader
      var bEmitter := False;
      for var ref in shape.ReferencedBy do begin
        var refblock := ref;
        while not (refblock is TwbNifBlock) do refblock := refblock.Parent;
        if TwbNifBlock(refblock).IsNiObject('NiPSysEmitter') then begin
          bEmitter := True;
          Break;
        end;
      end;

      if not bEmitter then
        Log.Add(#9 + shape.Name + ': Missing shader property');

      Continue;
    end;

    var texset: TwbNifBlock := nil;
    if Assigned(shader.Elements['Texture Set']) then
      texset := TwbNifBlock(shader.Elements['Texture Set'].LinksTo);

    if not bExternalEmitShader and shader.NativeValues['Shader Flags 1\External_Emittance'] then begin
      bExternalEmitShader := True;
      EmitShader := shader.Name;
    end;

    // Fallout 3, New Vegas
    if nif.NifVersion = nfFO3 then begin
      if (shader.EditValues['Shader Type'] = 'SHADER_SKIN') xor shader.NativeValues['Shader Flags 1\FaceGen'] then
        Log.Add(#9 + shader.Name + ': SHADER_SKIN shader type and FaceGen shader flag must be set together');

      if (shader.EditValues['Shader Type'] = 'SHADER_NOLIGHTING') and (shader.BlockType = 'BSShaderPPLightingProperty') then
        Log.Add(#9 + shader.Name + ': Invalid shader type SHADER_NOLIGHTING for BSShaderPPLightingProperty');
    end;

    // Skyrim
    if nif.NifVersion in [nfTES5, nfSSE] then begin

      // Tangents are required on BSTriShapes
      if Shape.IsNiObject('BSTriShape') then
        if not (Shader.NativeValues['Shader Flags 1\Model_Space_Normals'] or Shape.NativeValues['VertexDesc\VF\VF_TANGENT']) then
          Log.Add(#9 + shape.Name + ': Has no tangentspace and is not using modelspace normals and will not render');


      // Dynamic_Decal flag
      if Shader.NativeValues['Shader Flags 1\Dynamic_Decal'] then begin
        if not Shader.NativeValues['Shader Flags 1\Decal'] then
          Log.Add(#9 + Shader.Name + ': Dynamic_Decal flag is used, but Decal flag is not set');

        if not Shader.NativeValues['Shader Flags 2\Assume_Shadowmask'] then
          Log.Add(#9 + Shader.Name + ': Dynamic_Decal flag is used, but Assume_Shadowmask flag is not set');
      end;


      if Shader.BlockType = 'BSEffectShaderProperty' then begin
        // grayscale flags + texture
        if (shader.NativeValues['Shader Flags 1\Grayscale_To_PaletteColor'] or shader.NativeValues['Shader Flags 1\Grayscale_To_PaletteAlpha']) and
           (shader.EditValues['Grayscale Texture'] = '')
        then
          Log.Add(#9 + shader.Name + ': Grayscale Texture must be set for Grayscale_To_PaletteColor or Grayscale_To_PaletteAlpha flags');
      end;


      if Shader.BlockType = 'BSLightingShaderProperty' then begin
        if not Assigned(texset) then begin
          Log.Add(#9 + Shader.Name + ': Missing BSShaderTextureSet');
          Continue;
        end;

        var ShaderType := Shader.EditValues['Shader Type'];

        // Diffuse Texture
        if texset.EditValues['Textures\[0]'] = '' then
          Log.Add(#9 + texset.Name + ': Diffuse Texture [Slot 0] must be set for all Shaders');

        // Normal Texture
        if texset.EditValues['Textures\[1]'] = '' then
          Log.Add(#9 + texset.Name + ': Normal Texture [Slot 1] must be set for all Shaders');

        // Vertex colors and alpha
        if bHasVertexColors and not shader.NativeValues['Shader Flags 2\Vertex_Colors'] then
          Log.Add(#9 + shape.Name + ': Has vertex colors but missing Vertex_Colors shader flag in ' + shader.Name);

        if not bHasVertexColors and shader.NativeValues['Shader Flags 2\Vertex_Colors'] then
          Log.Add(#9 + shape.Name + ': Has no vertex colors but Vertex_Colors shader flag is set in ' + shader.Name);

        if not bHasVertexColors and Shader.NativeValues['Shader Flags 1\Vertex_Alpha'] then
          Log.Add(#9 + shape.Name + ': Has no vertex colors but Vertex_Alpha shader flag is set in ' + shader.Name);

        // envmap shader + flags + textures
        if ShaderType = 'Environment Map' then begin
          if not shader.NativeValues['Shader Flags 1\Environment_Mapping'] then
            Log.Add(#9 + shader.Name + ': Environment Map shader type is used but missing Environment_Mapping shader flag');

          if texset.EditValues['Textures\[4]'] = '' then
            Log.Add(#9 + texset.Name + ': Environment Texture [Slot 4] must be set for Environment shader');

          if texset.EditValues['Textures\[5]'] = '' then
            Log.Add(#9 + texset.Name + ': Environment Mask Texture [Slot 5] must be set for Environment shader');
        end else if Shader.NativeValues['Shader Flags 1\Environment_Mapping'] then
          Log.Add(#9 + shader.Name + ': Environment_Mapping shader flag is set but shader type is not Environment Map');

        // glow shader + flags + texture
        if ShaderType = 'Glow Shader' then begin
          if not shader.NativeValues['Shader Flags 2\Glow_Map'] then
            Log.Add(#9 + shader.Name + ': Glow Shader type is used but missing Glow_Map shader flag');

          if not Shader.NativeValues['Shader Flags 1\Own_Emit'] then
            Log.Add(#9 + Shader.Name + ': Glow Shader type is used but missing Own_Emit shader flag');

          if Shader.EditValues['Emissive Color'] = '#000000' then
            Log.Add(#9 + Shader.Name + ': Glow Shader type is used but Emissive Color is blank');

          if texset.EditValues['Textures\[2]'] = '' then
            Log.Add(#9 + texset.Name + ': Glow Texture [Slot 2] must be set for Glow shader');
        end else if Shader.NativeValues['Shader Flags 2\Glow_Map'] then
          Log.Add(#9 + shader.Name + ': Glow_Map shader flag is set but shader type is not Glow Shader');

        // parallax shader + flag + colors + texture
        if ShaderType = 'Parallax' then begin
          if not shader.NativeValues['Shader Flags 1\Parallax'] then
            Log.Add(#9 + shader.Name + ': Parallax shader type is used but missing Parallax shader flag');

          if not bHasVertexColors then
            Log.Add(#9 + shader.Name + ': Parallax shader type is used but missing Vertex Colors on shape');

          if Shader.NativeValues['Shader Flags 2\Multi_Layer_Parallax'] then
            Log.Add(#9 + Shader.Name + ': Multi_Layer_Parallax shader flag can''t be used with Parallax shader type');

          if texset.EditValues['Textures\[3]'] = '' then
            Log.Add(#9 + texset.Name + ': Parallax Texture [Slot 3] must be set for Parallax shader');
        end else if Shader.NativeValues['Shader Flags 1\Parallax'] then
          Log.Add(#9 + shader.Name + ': Parallax shader flag is set but shader type is not Parallax');

        // facegen shader + flags + textures
        if ShaderType = 'Facegen' then begin
          if not Shader.NativeValues['Shader Flags 1\Facegen'] then
            Log.Add(#9 + Shader.Name + ': Facegen shader type is used but missing Facegen shader flag');

          if not Shader.NativeValues['Shader Flags 2\Soft_Lighting'] then
            Log.Add(#9 + Shader.Name + ': Facegen shader type is used but missing Soft_Lighting shader flag');

          if Shader.NativeValues['Shader Flags 2\Anisotropic_Lighting'] then
            Log.Add(#9 + Shader.Name + ': Anisotropic_Lighting shader flag cannot be used with Facegen Shader Type');

          if texset.EditValues['Textures\[2]'] = '' then
            Log.Add(#9 + texset.Name + ': Skin Tint Texture [Slot 2] must be set for Facegen shader');

          if texset.EditValues['Textures\[3]'] = '' then
            Log.Add(#9 + texset.Name + ': Facegen Detail Texture [Slot 3] must be set for Facegen shader');

          if texset.EditValues['Textures\[6]'] = '' then
            Log.Add(#9 + texset.Name + ': Facegen Tint Texture [Slot 6] must be set for Facegen shader');
        end else if Shader.NativeValues['Shader Flags 1\Facegen'] then
          Log.Add(#9 + Shader.Name + ': Facegen shader flag is set but shader type is not Facegen');

        // skin tint shader + flags + textures
        if ShaderType = 'Skin Tint' then begin
          if not Shader.NativeValues['Shader Flags 1\Skin_Tint'] then
            Log.Add(#9 + Shader.Name + ': Skin Tint shader type is used but missing Skin_Tint shader flag');

          if not Shader.NativeValues['Shader Flags 2\Soft_Lighting'] then
            Log.Add(#9 + Shader.Name + ': Skin Tint shader type is used but missing Soft_Lighting shader flag');

          if texset.EditValues['Textures\[2]'] = '' then
            Log.Add(#9 + texset.Name + ': Skin Tint Texture [Slot 2] must be set for Skin Tint shader');
        end else if Shader.NativeValues['Shader Flags 1\Skin_Tint'] then
          Log.Add(#9 + Shader.Name + ': Skin_Tint shader flag is set but shader type is not Skin Tint');

        // hair tint shader
        if ShaderType = 'Hair Tint' then begin
          if not Shader.NativeValues['Shader Flags 1\Hair_Tint'] then
            Log.Add(#9 + Shader.Name + ': Hair Tint shader type is used but missing Hair_Tint shader flag');
        end else if Shader.NativeValues['Shader Flags 1\Hair_Tint'] then
          Log.Add(#9 + Shader.Name + ': Hair_Tint shader flag is set but shader type is not Hair Tint');

        if ShaderType = 'Parallax Occ' then
        begin
          if not Shader.NativeValues['Shader Flags 1\Parallax_Occlusion'] then

        end;

        // multi layer parallax shader
        if ShaderType = 'MultiLayer Parallax' then begin
          if not shader.NativeValues['Shader Flags 2\Multi_Layer_Parallax'] then
            Log.Add(#9 + shader.Name + ': MultiLayer Parallax shader type is used but missing Multi Layer Parallax shader flag');

          if Shader.NativeValues['Shader Flags 1\Parallax'] then
            Log.Add(#9 + Shader.Name + ': Parallax shader flag can''t be used with MultiLayer Parallax shader type');

          if texset.EditValues['Textures\[4]'] = '' then
            Log.Add(#9 + texset.Name + ': Environment Texture [Slot 4] must be set for MultiLayer Parallax shader');

          if texset.EditValues['Textures\[5]'] = '' then
            Log.Add(#9 + texset.Name + ': Environment Mask Texture [Slot 5] must be set for MultiLayer Parallax shader');

          if texset.EditValues['Textures\[6]'] = '' then
            Log.Add(#9 + texset.Name + ': Inner Layer Texture [Slot 6] must be set for MultiLayer Parallax shader');
        end else if Shader.NativeValues['Shader Flags 2\Multi_Layer_Parallax'] then
          Log.Add(#9 + Shader.Name + ': Multi_Layer_Parallax shader flag is set but shader type is not MultiLayer Parallax');

        // eye envmap shader + flag
        if ShaderType = 'Eye Envmap' then begin
          if not shader.NativeValues['Shader Flags 1\Eye_Environment_Mapping'] then
            Log.Add(#9 + shader.Name + ': Eye Envmap shader type is used but missing Eye_Environment_Mapping shader flag');

          if texset.EditValues['Textures\[4]'] = '' then
            Log.Add(#9 + texset.Name + ': Environment Texture [Slot 4] must be set for Eye Envmap shader');

          if texset.EditValues['Textures\[5]'] = '' then
            Log.Add(#9 + texset.Name + ': Environment Mask Texture [Slot 5] must be set for Eye Envmap shader');
        end else if Shader.NativeValues['Shader Flags 1\Eye_Environment_Mapping'] then
          Log.Add(#9 + shader.Name + ': Eye_Environment_Mapping shader flag is set but shader type is not Eye Envmap');

        if (ShaderType = 'LOD Landscape') or (ShaderType = 'LOD Landscape Noise') then
        begin
          if not Shader.NativeValues['Shader Flags 2\LOD_Landscape'] then
            Log.Add(#9 + Shader.Name + ': LOD Landscape shader type is used but missing LOD_Landscape shader flag');
        end
        else
          if Shader.NativeValues['Shader Flags 2\LOD_Landscape'] then
            Log.Add(#9 + Shader.Name + ': LOD_Landscape shader flag is set but shader type is not LOD Landscape');

        if (ShaderType = 'LOD Objects') or (ShaderType = 'LOD Objects HD') then
        begin
          if not Shader.NativeValues['Shader Flags 2\LOD_Objects'] then
            Log.Add(#9 + Shader.Name + ': LOD Objects shader type is used but missing LOD_Objects shader flag');
        end
        else
          if Shader.NativeValues['Shader Flags 2\LOD_Objects'] then
            Log.Add(#9 + Shader.Name + ': LOD_Objects shader flag is set but shader type is not LOD Object');

        if ShaderType = 'PBR' then begin
          if texset.EditValues['Textures\[5]'] = '' then
            Log.Add(#9 + texset.Name + ': RMAOS Texture [Slot 5] must be set for PBR shader');

          if Shader.NativeValues['PBR Material Data\Feature Flags\Two Layer'] then
          begin
            if Shader.NativeValues['PBR Material Data\Feature Flags\Fuzz'] then
              Log.Add(#9 + Shader.Name + ': PBR Features Two Layer and Fuzz can not be used together');

            if Shader.NativeValues['PBR Material Data\Feature Flags\Subsurface'] then
              Log.Add(#9 + Shader.Name + ': PBR Features Two Layer and Subsurface can not be used together');

            if texset.EditValues['Textures\[6]'] = '' then
              Log.Add(#9 + texset.Name + ': PBR Two Layer Normal texture [Slot 6] must be set for PBR Two Layer feature');

            if texset.EditValues['Textures\[7]'] = '' then
              Log.Add(#9 + texset.Name + ': PBR Two Layer Diffuse texture [slot 7] must be set for PBR Two Layer feature');
          end;

          if Shader.NativeValues['PBR Material Data\Feature Flags\Fuzz'] then
            if texset.EditValues['Textures\[6]'] = '' then
              Log.Add(#9 + texset.Name + ': PBR Fuzz Texture [Slot 6] must be set for PBR Fuzz feature');

          if Shader.NativeValues['PBR Material Data\Feature Flags\Subsurface'] then
            if texset.EditValues['Textures\[7]'] = '' then
              Log.Add(#9 + texset.Name + ': PBR Subsurface texture [Slot 7] must be set for PBR Subsurface feature');
        end;

        // Back_Lighting flag
        if Shader.NativeValues['Shader Flags 2\Back_Lighting'] then
          if texset.EditValues['Textures\[7]'] = '' then
            Log.Add(#9 + texset.Name + ': Back Lighting Texture [Slot 7] must be set with Back lighting flag');

        // Character_Lighting flag
        if bFacegen then begin
          if not Shader.NativeValues['Shader Flags 2\Character_Lighting'] then
            Log.Add(#9 + Shader.Name + ': file is a Facegen nif but Character_Lighting flag is not set');
        end else begin
          if Shader.NativeValues['Shader Flags 2\Character_Lighting'] then
            Log.Add(#9 + Shader.Name + ': file is not a Facegen nif but Character_Lighting flag is set');
        end;

        // EnvMap_Light_Fade flag
        if (ShaderType = 'Environment Map') or (ShaderType = 'MultiLayer Parallax') or (ShaderType = 'Eye Envmap') then begin
          if not Shader.NativeValues['Shader Flags 2\EnvMap_Light_Fade'] then
            Log.Add(#9 + Shader.Name + ': Shader Type is Environment/MultiLayer Parallax, but missing EnvMap_Light_Fade flag');
        end else begin
          // benign error
          //if Shader.NativeValues['Shader Flags 2\EnvMap_Light_Fade'] then
          //  Log.Add(#9 + Shader.Name + ': EnvMap_Light_Fade flag is set, but Shader Type is not Environment/MultiLayer_Parallax');
        end;

        // Rim Lighting flag
        if Shader.NativeValues['Shader Flags 2\Rim_Lighting'] then
          if texset.EditValues['Textures\[2]'] = '' then
            Log.Add(#9 + texset.Name + ': Rim Lighting Texture [Slot 2] must be set with Rim_Lighting flag');

        // Soft_Lighting flag
        if Shader.NativeValues['Shader Flags 2\Soft_Lighting'] then
          if ((ShaderType <> 'Skin Tint') and (ShaderType <> 'Facegen')) then
            if texset.EditValues['Textures\[2]'] = '' then
              Log.Add(#9 + texset.Name + ': Soft Lighting Texture [Slot 2] must be set with Soft_lighting flag');

        // Rim and Soft lighting flags
        if Shader.NativeValues['Shader Flags 2\Rim_Lighting'] and shader.NativeValues['Shader Flags 2\Soft_Lighting'] then
          Log.Add(#9 + shader.Name + ': Rim and Soft lighting can not be used together');

        // specular flag
        if Shader.NativeValues['Shader Flags 1\Specular'] then begin
          if Shader.EditValues['Specular Color'] = '#000000' then
            Log.Add(#9 + Shader.Name + ': Specular flag is set, but Specular Color is blank');

          // model_space_normals flag
          if Shader.NativeValues['Shader Flags 1\Model_Space_Normals'] then begin
            if texset.EditValues['Textures\[7]'] = '' then
              Log.Add(#9 + texset.Name + ': Specular Texture [Slot 7] must be set for Model_Space_Normals + Specular flags');

            if Shader.NativeValues['Shader Flags 2\Back_Lighting'] then
              Log.Add(#9 + Shader.Name + ': Back_Lighting flag can''t be used with Model_Space_Normals and Specular flags');
          end;
        end;

        // tree_anim flag
        if Shader.NativeValues['Shader Flags 2\Tree_Anim'] then begin
          var RootBlock := Nif.RootNode.BlockType;
          if (RootBlock <> 'BSLeafAnimNode') and (RootBlock <> 'BSTreeNode') then
            Log.Add(#9 + shader.Name + ': Tree_Anim flag is set but the root node is not BSLeafAnimNode or BSTreeNode');

          if Shader.NativeValues['Shader Flags 2\Glow_Map'] then
            Log.Add(#9 + shader.Name + ': Tree_Anim and Glow_Map flags don''t work together in game and crash CK');

          if not Shader.NativeValues['Shader Flags 2\Vertex_Colors'] then
            Log.Add(#9 + shader.Name + ': Tree_Anim shader flag requires Vertex_Colors shader flag');

          if not Shader.NativeValues['Shader Flags 1\Vertex_Alpha'] then
            Log.Add(#9 + Shader.Name + ': Tree_Anim shader flag requires Vertex_Alpha shader flag');
        end;

        // Glossiness
        var glossiness := shader.Elements['Glossiness'];
        if Assigned(glossiness) and SameValue(glossiness.NativeValue, 0.0) then
          Log.Add(#9 + shader.Name + ': Zero Glossiness causes lighting issues');
      end;

    end;

    // Fallout 4
    if nif.NifVersion = nfFO4 then begin
      // external material file is used, shader settings are unused
      if shader.EditValues['Name'] <> '' then
        Continue;
    end;
  end;

  // handled in BSXFlags check
  var bsx := nif.BlockByName('BSX');
  //if not Assigned(bsx) and bExternalEmitShader then
  //  Log.Add(#9 + EmitShader + ': External_Emit shader flag is set but BSXFlags block is missing with the same flag');

  if Assigned(bsx) then begin
    //if (bsx.NativeValues['Flags'] and (1 shl 9) <> 0) and not bExternalEmitShader then
    //  Log.Add(#9 + bsx.Name + ': External_Emit shader flag is set but no shaders found with the same flag');

    // print this to pinpoint which shader is emitter
    if (bsx.NativeValues['Flags'] and (1 shl 9) = 0) and bExternalEmitShader then
      Log.Add(#9 + EmitShader + ': External_Emit shader flag is set but the same flag is not set in ' + bsx.Name);
  end;

end;

//==============================================================================
procedure CheckGeometry(aFile: TProcFileObject; aObj: Pointer; Log: TStrings);

  procedure CheckTris(tris: TdfElement; numverts: Integer; const aTriElement: string = '');
  begin
    if not Assigned(tris) then
      Exit;

    var usedverts: array of Byte;
    SetLength(usedverts, numverts);

    var bReported := False;
    for var i := 0 to Pred(tris.Count) do begin
      var trielem := tris[i];
      if aTriElement <> '' then
        trielem := trielem.Elements[aTriElement];
      var tri := PNiTriangle(TdfValue(trielem).DataStart);
      if not bReported and ( (tri[0] >= numverts) or (tri[1] >= numverts) or (tri[2] >= numverts) ) then begin
        Log.Add(#9 + tris[i].Path + ': ' + Format('Triangle (%d, %d, %d) exceeds the number of vertices %d', [tri[0], tri[1], tri[2], numverts]));
        // reporting one tri is enough, there could be a lot in broken meshes
        bReported := True;
      end;
      if tri[0] < numverts then usedverts[tri[0]] := 1;
      if tri[1] < numverts then usedverts[tri[1]] := 1;
      if tri[2] < numverts then usedverts[tri[2]] := 1;
    end;

    var numusedverts := 0;
    for var v in usedverts do Inc(numusedverts, v);
    if numverts <> numusedverts then
      Log.Add(#9 + tris.Parent.Name + ': ' + Format('Unused vertices (Num Vertices: %d, Used vertices: %d)', [numverts, numusedverts]));
  end;

  procedure CheckStrips(strips: TdfElement; numverts: Integer);
  begin
    if not Assigned(strips) then
      Exit;

    var usedverts: array of Byte;
    SetLength(usedverts, numverts);

    var bReported := False;
    for var i := 0 to Pred(strips.Count) do begin
      var strip := strips[i];
      for var j := 0 to Pred(strip.Count) do begin
        var p: Integer := strip[j].NativeValue;
        if not bReported and (p >= numverts) then begin
          Log.Add(#9 + strip.Path + ': ' + Format('Strip point %d exceeds the number of vertices %d', [p, numverts]));
          bReported := True;
        end;
        if p < numverts then usedverts[p] := 1;
      end;
    end;

    var numusedverts := 0;
    for var v in usedverts do Inc(numusedverts, v);
    if numverts <> numusedverts then
      Log.Add(#9 + strips.Parent.Name + ': ' + Format('Unused vertices (Num Vertices: %d, Used Vertices: %d)', [numverts, numusedverts]));
  end;

begin
  var nif: TwbNifFile := aObj;

  for var i := 0 to Pred(nif.BlocksCount) do begin
    var block: TwbNifBlock := nif.Blocks[i];

    if block.BlockType = 'BSTriShape' then begin
      CheckTris(block.Elements['Triangles'], block.NativeValues['Num Vertices']);

    // detecting duplicate vertices
    if not Assigned(block.Elements['Vertex Data']) then
      Continue;

    var numverts: Integer := block.NativeValues['Num Vertices'];
    if numverts > 0 then begin
      var verts: TBytes;
      SetLength(verts, block.Elements['Vertex Data'][0].DataSize * numverts);
      block.Elements['Vertex Data'].Serialize(@verts[0], @verts[Pred(Length(verts))]);
      var dups: array of Boolean;
      SetLength(dups, numverts);
      var vsize := Length(verts) div numverts;
      var numdups := 0;
      for var v1 := 0 to numverts - 2 do
        if not dups[v1] then
        for var v2 := v1 + 1 to numverts - 1 do
          if not dups[v2] and CompareMem(@verts[v1 * vsize], @verts[v2 * vsize], vsize) then begin
            Inc(numdups);
            dups[v2] := True;
          end;

      if numdups > 0 then
        Log.Add(#9 + block.Name + ': ' + Format('Duplicate vertices (Num Vertices: %d, Dup Vertices: %d)', [numverts, numdups]));
    end;
  end

    else if block.BlockType = 'NiTriShapeData' then
      CheckTris(block.Elements['Triangles'], block.NativeValues['Num Vertices'])

    else if block.BlockType = 'NiTriStripsData' then begin
      CheckStrips(block.Elements['Strips'], block.NativeValues['Num Vertices']);
      var snum: Integer := block.NativeValues['Num Strips'];
      if snum > 1 then
        Log.Add(#9 + block.Name + ': ' + Format('Num Strips = %d, should always be 1 to reduce the number of draw calls', [snum]));
    end

    else if block.BlockType = 'hkPackedNiTriStripsData' then
      CheckTris(block.Elements['Triangles'], block.NativeValues['Num Vertices'], 'Triangle')

    else if block.BlockType = 'NiSkinPartition' then begin
      var parts := block.Elements['Partitions'];
      for var j := 0 to Pred(parts.Count) do begin
        var snum: Integer := parts[j].NativeValues['Num Strips'];
        if snum > 1 then
          Log.Add(#9 + parts[j].Path + ': ' + Format('Num Strips = %d, should always be 1 to reduce the number of draw calls', [snum]));
      end;
    end;

  end;
end;

//==============================================================================
procedure CheckVertexColors(aFile: TProcFileObject; aObj: Pointer; Log: TStrings);
type
  TFloat4 = array [0..3] of Single;
  PFloat4 = ^TFloat4;
  TByte4 = array [0..3] of Byte;
  PByte4 = ^TByte4;
const
  fSingle1 = $3F800000;
  fColor4White: TFloat4 = (fSingle1, fSingle1, fSingle1, fSingle1);
  bColor4White: Cardinal = $FFFFFFFF;
var
  bAllWhite, bAlpha, bHDR: Boolean;
  shapename: string;
begin
  var nif: TwbNifFile := aObj;

  for var i := 0 to Pred(nif.BlocksCount) do begin
    var shape := nif.Blocks[i];
    if not (shape.IsNiObject('BSTriShape') or shape.IsNiObject('NiTriBasedGeom')) then
      Continue;

    bAllWhite := True;
    bHDR := False;
    bAlpha := False;

    if shape.IsNiObject('NiTriBasedGeom') then begin
      var shapedata := TwbNifBlock(shape.Elements['Data'].LinksTo);
      if not Assigned(shapedata) then
        Continue;

      if shapedata.NativeValues['Has Vertex Colors'] = 0 then
        Continue;

      var colors := shapedata.Elements['Vertex Colors'];
      if not Assigned(colors) or (colors.Count = 0) then
        Continue;

      for var j := 0 to Pred(colors.Count) do begin
        var c: PFloat4 := Pointer(TdfValue(colors[j]).DataStart);
        if CompareMem(c, @fColor4White[0], SizeOf(fColor4White)) then
          Continue;

        bAllWhite := False;
        if not bAlpha and (c[3] < 1.0) then
          bAlpha := True;

        if not bHDR then
          if (c[0] < 0.0) or (c[0] > 1.0) or (c[1] < 0.0) or (c[1] > 1.0) or (c[2] < 0.0) or (c[2] > 1.0) or (c[3] < 0.0) or (c[3] > 1.0) then begin
            Log.Add(#9 + shapedata.Name + ': HDR vertex color at index ' + IntToStr(j));
            bHDR := True;
          end;

        // found everything we wanted
        if not bAllWhite and bAlpha and bHDR then Break;
      end;
      shapename := shapedata.Name;
    end

    else begin
      if not shape.NativeValues['VertexDesc\VF\VF_COLORS'] then
        Continue;

      var vertices := shape.Elements['Vertex Data'];
      if not Assigned(vertices) or (vertices.Count = 0) then
        Continue;

      for var j := 0 to Pred(vertices.Count) do begin
        var c: PByte4 := Pointer(TdfValue(vertices[j].Elements['Vertex Colors']).DataStart);
        if PCardinal(c)^ = bColor4White then
          Continue;

        bAllWhite := False;
        if not bAlpha and (c[3] < 255) then
          bAlpha := True;

        // found everything we wanted
        if not bAllWhite and bAlpha then Break;
      end;
      shapename := shape.Name;
    end;

    var shader := shape.PropertyByType('BSShaderProperty', True);

    if bAllWhite then
      // skip cases where Vertex Colors are required
      if not ( Assigned(shader) and ( Boolean(shader.NativeValues['Shader Flags 2\Tree_Anim']) or (shader.EditValues['Shader Type'] = 'Parallax') ) ) then
        Log.Add(#9 + shapename + ': All white #FFFFFFFF vertex colors');

    if bAlpha and Assigned(shader) and (nif.NifVersion in [nfFO3, nfTES5, nfSSE]) then
      if Assigned(shape.PropertyByType('NiAlphaProperty')) and not shader.NativeValues['Shader Flags 1\Vertex_Alpha'] then
        Log.Add(#9 + shapename + ': Has alpha < 1.0 in vertex colors and attached NiAlphaProperty but missing Vertex_Alpha flag in ' + shader.Name);
  end;

end;

//==============================================================================
procedure CheckMiscellaneous(aFile: TProcFileObject; aObj: Pointer; Log: TStrings);
begin
  var nif: TwbNifFile := aObj;

  // root node validity
  var r := nif.RootNode;
  if Assigned(r) then begin
    if r.Index <> 0 then
      Log.Add(#9 + r.Name + ': Root node must be at index 0');

    if not (r.IsNiObject('NiAVObject', True) or r.IsNiObject('NiSequence', True) or (r.BlockType = 'NiSequenceStreamHelper')) then
      Log.Add(#9 + r.Name + ': Root node is not a NiAVObject/NiSequence or their descendant');
  end
  else
    Log.Add(#9 + nif.Footer.Name + ': No defined root node');

  // invalid vertices number in Oblivion's tangents and binormals extradata
  if nif.NifVersion = nfTES4 then
    for var shape in nif.BlocksByType('NiTriBasedGeom', True) do begin
      var tan := shape.ExtraDataByName(sTES4TangentsExtraDataName);
      if not Assigned(tan) then
        Continue;

      var shapedata := TwbNifBlock(shape.Elements['Data'].LinksTo);
      if not Assigned(shapedata) then
        Continue;

      // 3 floats tangent + 3 floats binormal per vertex
      var v := tan.Elements['Data'].DataSize div 24;
      if (v <> 0) and (v <> shapedata.NativeValues['Num Vertices']) then
        Log.Add(#9 + tan.Name + ': Tangents and binormals size doesn''t match vertices count in ' + shapedata.Name);
    end;

  // non-primitive subshapes in bhkListShape
  if nif.NifVersion >= nfTES5 then
    for var list in nif.BlocksByType('bhkListShape') do begin
      var shapes := list.Elements['Sub Shapes'];
      for var i := 0 to Pred(shapes.Count) do begin
        var shape := TwbNifBlock(shapes[i].LinksTo);
        if Assigned(shape) and not ( shape.IsNiObject('bhkConvexShape') or (nif.NifVersion < nfTES5) and shape.IsNiObject('bhkTransformShape') ) then
          // using similar error message from CK log
          Log.Add(#9 + list.Name + ': Uses invalid child container subshape ' + shape.Name);
      end;
    end;

  // TriShapes in Facegen .nifs must be of type BSDynamicTriShape
  var bFaceGen := Assigned(nif.BlockByName('BSFaceGenNiNodeSkinned', 'NiNode'));
  if (nif.NifVersion = nfSSE) and bFaceGen then
    for var shape in nif.BlocksByType('BSTriShape') do
      Log.Add(#9 + shape.Name + ': Shapes must be of type BSDynamicTriShape in Facegen nifs');

  // NiSpecularProperty in TES4 and later games
  if nif.NifVersion >= nfTES4 then
    for var spec in nif.BlocksByType('NiSpecularProperty') do
      Log.Add(#9 + spec.Name + ': Not supported, does nothing');

  //Effect/LightingShaderProperties can't have the other type of Controllers attached, causes crashes
  for var Shader in nif.BlocksByType('BSEffectShaderProperty') do begin
    var Controller := Shader.GetController;
    if Assigned(Controller) and Controller.BlockType.StartsWith('BSLighting') then
      Log.Add(#9 + Shader.Name + ': Attached controller ' + Controller.BlockType + ' is invalid for this shader property');
  end;

  for var Shader in nif.BlocksByType('BSLightingShaderProperty') do begin
    var Controller := Shader.GetController;
    if Assigned(Controller) and Controller.BlockType.StartsWith('BSEffect') then
      Log.Add(#9 + Shader.Name + ': Attached controller ' + Controller.BlockType + ' is invalid for this shader property');
  end;
end;


//==============================================================================
procedure CheckOptional(aFile: TProcFileObject; aObj: Pointer; Log: TStrings);
begin
  var nif: TwbNifFile := aObj;

  for var shader in nif.BlocksByType('BSShaderProperty', True) do begin
    if shader.NativeValues['Shader Flags 1'] = 0 then
      Log.Add(#9 + shader.Name + ': Empty shader flags');

    if shader.BlockType = 'BSShaderPPLightingProperty' then begin
      if shader.NativeValues['Shader Flags 1\Environment_Mapping'] and not shader.NativeValues['Shader Flags 2\Envmap_Light_Fade'] then
        Log.Add(#9 + shader.Name + ': Environment_Mapping flag is set but no Envmap_Light_Fade flag');

      var texset := TwbNifBlock(shader.Elements['Texture Set'].LinksTo);
      if not Assigned(texset) then
        Continue;

      var textures := texset.Elements['Textures'];
      if not Assigned(textures) then
        Continue;

      if textures.Count > 5 then begin
        if ( (textures[4].EditValue = '')  and (textures[5].EditValue <> '') ) or
           ( (textures[4].EditValue <> '') and (textures[5].EditValue = '') )
        then
          Log.Add(#9 + texset.Name + ': 6th texture (counting from 1) should be used if 5th is set in FO3/FNV meshes otherwise the game uses the gloss map from the normal map');
      end;
    end;

  end;
end;

//==============================================================================
procedure CheckUVs(aFile: TProcFileObject; aObj: Pointer; Log: TStrings);
var
  shader: TwbNifBlock;
  mode: TdfElement;
begin
  var nif: TwbNifFile := aObj;

  for var i := 0 to Pred(nif.BlocksCount) do begin
    var b := nif.Blocks[i];

    if not (b.IsNiObject('NiTriBasedGeom') or b.IsNiObject('BSTriShape')) then
      Continue;

    if nif.NifVersion > nfTES4 then begin
      shader := b.PropertyByType('BSShaderProperty', True);
      if not Assigned(shader) or (shader.BlockType = 'BSEffectShaderProperty') then
        Continue;

      if (nif.NifVersion >= nfFO4) and (shader.EditValues['Name'] <> '')  then
        Continue;

      mode := shader.Elements['Texture Clamp Mode'];
    end

    else begin
      shader := b.PropertyByType('NiTexturingProperty');
      if not Assigned(shader) then
        Continue;

      mode := shader.Elements['Base Texture\Clamp Mode'];
    end;

    if not Assigned(mode) then
      Continue;

    var m := mode.EditValue;
    if m = 'WRAP_S_WRAP_T' then
      Continue;

    if b.IsNiObject('NiTriBasedGeom') then begin
      b := TwbNifBlock(b.Elements['Data'].LinksTo);
      if not Assigned(b) then
        Continue;
    end;

    var uvs := b.GetTexCoord;
    if Length(uvs) = 0 then
      Continue;

    for var uv in uvs do
      if ( (uv.x < -0.001) or (uv.x > 1.001) ) and ( (m = 'CLAMP_S_CLAMP_T') or (m = 'CLAMP_S_WRAP_T') ) or
         ( (uv.y < -0.001) or (uv.y > 1.001) ) and ( (m = 'CLAMP_S_CLAMP_T') or (m = 'WRAP_S_CLAMP_T') )
      then begin
        Log.Add(#9 + b.Name + ': Has UVs outside of 0..1 range but uses CLAMP mode in ' + shader.Name);
        Break;
      end;
  end;

end;

//==============================================================================
procedure CheckStripsDegenerate(aFile: TProcFileObject; aObj: Pointer; Log: TStrings);

  function CheckStrips(const Strips: TdfElement): Boolean;
  begin
    Result := False;

    if not Assigned(Strips) then
      Exit;

    for var j := 0 to Pred(Strips.Count) do begin
      var Strip := strips[j];
      var v: Integer := 0;

      for var k := 1 to Pred(Strip.Count) do begin
        if Strip[k-1].NativeValue = strip[k].NativeValue then begin
          Inc(v);
          if v = 3 then begin
            Result := True;
            Exit;
          end;
        end else
          v := 0;
      end;
    end;
  end;

begin
  var nif: TwbNifFile := aObj;

  for var i := 0 to Pred(nif.BlocksCount) do begin
    var block := nif.Blocks[i];

    if block.BlockType = 'NiTriStripsData' then begin
      if CheckStrips(block.Elements['Strips']) then
        Log.Add(#9 + block.Name + ': Repeated degenerate tris in strip');
    end

    else if block.BlockType = 'NiSkinPartition' then begin
      var parts := block.Elements['Partitions'];

      if not Assigned(parts) then
        Continue;

      for var j := 0 to Pred(parts.Count) do begin
        var part := parts[j];
        if CheckStrips(part.Elements['Strips']) then begin
          Log.Add(#9 + block.Name + ': Repeated degenerate tris in strip');
          Break;
        end;
      end;

    end;

  end;
end;

//==============================================================================
procedure CheckDDS(aFile: TProcFileObject; aObj: Pointer; Log: TStrings);
begin
  var dds: PDDSHeader := aObj;

  if not IsPowerOf2(dds.dwWidth) or not IsPowerOf2(dds.dwHeight) then
    Log.Add(Format(#9'Texture size %dx%d is not power of 2', [dds.dwWidth, dds.dwHeight]));

  if TwbDDS.GetDXGI(dds) = DXGI_FORMAT_UNKNOWN then begin
    var d3d := TwbDDS.GetD3DFMT(dds);
    if d3d in TwbDDS.D3D_NODXGI then
      Log.Add(#9 + TwbDDS.GetD3DFMTFormatName(d3d) + ' format is unsupported by DirectX 10+ (Skyrim SE, Fallout 4, etc.)');
  end;
end;

//==============================================================================
procedure CheckSSENifFormat(aFile: TProcFileObject; aObj: Pointer; Log: TStrings);
begin
  var nif: TwbNifFile := aObj;

  for var i: Integer := 0 to Pred(nif.BlocksCount) do begin
    var block: TwbNifBlock := nif.Blocks[i];

    if block.BlockType = 'NiTriStrips' then
      Log.Add(#9 + block.Name + ': NiTriStrips block crashes Skyrim SE')

    else if block.BlockType = 'bhkMultiSphereShape' then
      Log.Add(#9 + block.Name + ': bhkMultiSphereShape block crashes Skyrim SE')

    else if block.BlockType = 'NiSkinPartition' then begin
      var Parts := block.Elements['Partitions'];
      if Assigned(Parts) then
        for var p := 0 to Pred(Parts.Count) do
          if Parts[p].NativeValues['Num Strips'] <> 0 then begin
            Log.Add(#9 + block.Name + ': NiSkinPartition block with triangle strips crashes Skyrim SE');
            Break;
          end;
    end;

  end;
end;

//==============================================================================
procedure CheckSSEDdsFormat(aFile: TProcFileObject; aObj: Pointer; Log: TStrings);
begin
  var dds: PDDSHeader := aObj;

  if (dds.ddspf.dwFlags and DDPF_RGB <> 0) and (
    (dds.ddspf.dwRBitMask <> $00FF0000) or
    (dds.ddspf.dwGBitMask <> $0000FF00) or
    (dds.ddspf.dwBBitMask <> $000000FF)
  ) then
    Log.Add(Format(#9'Texture format is not supported by Skyrim SE on Windows 7', [dds.dwWidth, dds.dwHeight]));
end;

//==============================================================================
function TCheck.DoesExtension(const aExtension: string): Boolean;
begin
  for var s in Extensions do
    if SameText(s, aExtension) then
      Exit(True);
  Result := False;
end;

//==============================================================================
constructor TProcCheckForErrors.Create(aManager: TProcManager);
begin
  inherited;

  fTitle := 'Check for errors';
  fSupportedGames := [gtTES4, gtFO3, gtFNV, gtTES5, gtSSE, gtFO4];
  fExtensions := ['nif', 'kf', 'dds'];
  fNoOutput := True;

  AddCheck('Invalid string index', 'Meshes', ['.nif', '.kf'],
    'String index used in blocks for meshes with strings table (Fallout 3 and later games) is out of range, always crashes the game',
    CheckStringIndex);

  AddCheck('Invalid blocks order', 'Meshes', ['.nif', '.kf'],
    'Wrong order of bhkCollisionObject children when child has larger index than its parent, always crashes the game',
    CheckBlocksOrder);

  AddCheck('Unused blocks', 'Meshes', ['.nif'],
    'Multiple root nodes or blocks not referenced from the root scenegraph, could crash the game',
    CheckUnusedBlocks);

  AddCheck('Repeated NiNode childen names', 'Meshes', ['.nif'],
    'Invalid names or the same named blocks (or the same block) is used several times in NiNode children, might cause issues or even crash the game depending on usage context',
    CheckInvalidRepeatedChildrenNames);

  AddCheck('Wrong link types', 'Meshes', ['.nif'],
    'References to blocks of wrong type. Always crashes the game',
    CheckWrongLinkTypes);

  AddCheck('Invalid array links', 'Meshes', ['.nif'],
    'Links in arrays (children, extradatas, properties, etc.) are either empty, point to nonexisting blocks or repeated. Could crash the game',
    CheckInvalidArrayLinks);

  AddCheck('Invalid geometry', 'Meshes', ['.nif'],
    'Triangles or strips reference invalid vertices. Unused vertices in geometry. Duplicate vertices in BSTriShape. Multiple strips in NiTriStripsData.',
    CheckGeometry);

  AddCheck('Hardcoded block names', 'Meshes', ['.nif'],
    'Some blocks must have specific name to work properly (BSX for BSXFlags, INV for BsInvMarker, etc.), "Weapon" nodes in non-skeletons, [TES4] unnamed NiMaterialProperty',
    CheckHardcodedBlockNames);

  AddCheck('Collision Havok issues', 'Meshes', ['.nif'],
    'Moveable collision has zero mass or uses inertia system without inertia tensor matrix set (will break the physics not only for that object, but other objects using totally different meshes as well), Havok layer and motion settings',
    CheckCollision);

  AddCheck('Collision MOPP issues', 'Meshes', ['.nif'],
    'Badly optimized MOPP collision using high poly shapes',
    CheckCollisionMOPP);

  AddCheck('Check BSXFlags', 'Meshes', ['.nif'],
    'Check for invalid BSXFlags: Animated, Havok, Ragdoll, Complex, Addon, Editor Marker and Dynamic. Emittance flag is checked by "Invalid shader types and flags". Complex and Articulated affect grabbing behaviour only',
    CheckBSXFlags);

  AddCheck('Check consistency flags', 'Meshes', ['.nif'],
    'Check for invalid consistency flags value. CT_MUTABLE when shape is controlled by NiGeomMorpherController or NiUVController, CT_STATIC for the rest. CT_VOLATILE isn''t used. Affects performance',
    CheckConsistencyFlags);

  AddCheck('Check texture set slots', 'Meshes', ['.nif'],
    'Check for absolute paths and invalid combinations of textures in BSShaderTextureSet',
    CheckTextureSetSlots);

  AddCheck('Check NiAlphaProperty', 'Meshes', ['.nif'],
    'Check for enabled Blending in NiAlphaProperty except NoLighting shader',
    CheckNiAlphaProperty, False);

  AddCheck('Invalid shader types and flags', 'Meshes', ['.nif'],
    'Check for invalid combinations of shader type and shader flags: environment mapping, eye envmapping, glow, external emittance, glow + treeanim. etc. Could crash the game',
    CheckShaderTypeFlags);

  AddCheck('Particle system checks', 'Meshes', ['.nif'],
    'Check for the invalid Modifier Name in descendants of NiPSysModifierCtlr, too long Life Span in NiPSysEmitter, Emitter nodes without NiParticleSystem, mesh emitters without Particle Data. Could crash the game',
    CheckParticleSystem);

  AddCheck('Invalid Target field', 'Meshes', ['.nif'],
    'Check for the invalid Target field in NiCollisionObject, bhkCompressedMeshShape, NiTimeController. Check for invalid node names in NiControllerSequence',
    CheckTargetField);

  AddCheck('Animation stop time', 'Meshes', ['.nif', '.kf'],
    'Check for the incorrect End key not matching the animation Stop time. Could cause animation issues',
    CheckAnimStopTime);

  AddCheck('Skinning issues', 'Meshes', ['.nif'],
    'BSDismemberSkinInstance and Body Parts checks, missing Skin in BSDynamicTriShape, [TES5/SSE] disrepancies between _0 and _1 morph models',
    CheckSkinningIssues);

  // false check, just keeping the code
  {AddCheck('Invalid subshapes material order', 'Meshes', ['.nif'],
    'Sub Shapes material in hkPackedNiTriStripsData must be in ascending order, otherwise the first one will be used for all shapes in game',
    CheckSubShapesCollisionOrder);}

  AddCheck('Miscellaneous checks', 'Meshes', ['.nif', '.kf'],
    'Root node is a NiNode/NiSequence descendant and the first block, Invalid subshapes in bhkListShape, [TES4] Tangents size not matching the vertices count, Unsupported NiSpecularPropertry in post Oblivion meshes',
    CheckMiscellaneous);

  AddCheck('Check vertex colors', 'Meshes', ['.nif'],
    'Check for alpha < 1.0 but missing Vertex_Alpha shader flag, possibly redundant all white vertex colors except for leaf animations and parallax, HDR vertex colors (outside of 0..1 range) which sometimes are not intended and lead to rendering issues',
    CheckVertexColors);

  AddCheck('Clamped tiling UVs', 'Meshes', ['.nif'],
    'Check for tiling UVs outside of 0..1 range in CLAMP mode. Causes texture stretching',
    CheckUVs, False);

  AddCheck('Optional checks', 'Meshes', ['.nif'],
    'Potential false positives, could be done on purpose: Empty shader flags, Envmap + Light_fade flags and 5th + 6th slots in textureset for BSShaderPPLightingProperty',
    CheckOptional, False);

  AddCheck('Repeated denegerate tris in strips', 'Meshes', ['.nif'],
    'Check for strips with repeated degenerate triangles',
    CheckStripsDegenerate, False);

  AddCheck('Invalid texture size or format', 'Textures', ['.dds'],
    'Texture size is not power of 2 or unsupported DXGI format, likely to crash the game',
    CheckDDS);

  AddCheck('Unsupported mesh formats', 'Skyrim SE', ['.nif'],
    'Unsupported nif blocks which crash Skyrim SE: NiTriStrips, stripified NiSkipPartition and bhkMultiSphereShape',
    CheckSSENifFormat, False);

  AddCheck('Unsupported texture formats', 'Skyrim SE', ['.dds'],
    'Uncompressed formats which crash Skyrim SE in Windows 7: R5G6B5, A1R5G5B5, A4R4G4B4 and other reduced bits formats',
    CheckSSEDdsFormat, False);
end;


function TProcCheckForErrors.GetFrame(aOwner: TComponent): TFrame;
begin
  Frame := TFrameCheckForErrors.Create(aOwner);
  Result := Frame;
end;

procedure TProcCheckForErrors.AddCheck(
  const aName, aGroup: string;
  const aExtensions: TExtensions;
  const aComment: string;
  aProc: TCheckProcedure;
  aActive: Boolean = True
);
begin
  SetLength(Checks, Succ(length(Checks)));
  with Checks[Pred(Length(Checks))] do begin
    Name := aName;
    Group := aGroup;
    Extensions := aExtensions;
    Comment := aComment;
    Proc := aProc;
    Active := aActive;
  end;
end;

procedure TFrameCheckForErrors.lvChecksSelectItem(Sender: TObject;
  Item: TListItem; Selected: Boolean);
begin
  if not Assigned(Item) then
    Exit;

  if Item.Data <> nil then
    txtComment.Caption := PCheck(Item.Data).Comment;
end;

procedure TFrameCheckForErrors.mniCheckAllClick(Sender: TObject);
begin
  var chk: Boolean := TMenuItem(Sender).Tag = 1;
  for var Check in lvChecks.Items do begin
    Check.Checked := chk;
    PCheck(Check.Data).Active := chk;
  end;
  lvChecks.Refresh;
end;

procedure TProcCheckForErrors.OnShow;
var
  header: string;
begin
  with Frame.lvChecks.Groups.Add do begin Header := 'Meshes'; State := [lgsNormal, lgsCollapsible]; end;
  with Frame.lvChecks.Groups.Add do begin Header := 'Textures'; State := [lgsNormal, lgsCollapsible]; end;
  with Frame.lvChecks.Groups.Add do begin Header := 'Skyrim SE'; State := [lgsNormal, lgsCollapsible]; end;

  for var i: Integer := Low(Checks) to High(Checks) do begin
    header := Checks[i].Group;

    with Frame.lvChecks.Items.Add do begin
      Caption := Checks[i].Name;
      Data := @Checks[i];
      Checked := StorageGetBool(Caption, Checks[i].Active);
      for var j: Integer := 0 to Pred(Frame.lvChecks.Groups.Count) do
        if Frame.lvChecks.Groups[j].Header = header then
          GroupID := Frame.lvChecks.Groups[j].GroupID;
    end;
  end;

  if Frame.lvChecks.ItemIndex = -1 then
    Frame.lvChecks.ItemIndex := 0;

  Frame.lvChecks.Selected.MakeVisible(False);
end;

procedure TProcCheckForErrors.OnHide;
begin
  for var i: Integer := 0 to Pred(Frame.lvChecks.Items.Count) do
    StorageSetBool(Frame.lvChecks.Items[i].Caption, Frame.lvChecks.Items[i].Checked);
end;

procedure TProcCheckForErrors.OnStart;
begin
  fLoadNif := False;
  fLoadDDS := False;
  for var i: Integer := 0 to Pred(Frame.lvChecks.Items.Count) do
    with Frame.lvChecks.Items[i] do begin
      PCheck(Data).Active := Checked;
      fLoadNIF := fLoadNIF or (Checked and ( PCheck(Data).DoesExtension('.nif') or PCheck(Data).DoesExtension('.kf') ) );
      fLoadDDS := fLoadDDS or (Checked and PCheck(Data).DoesExtension('.dds'));
    end;
end;

function TProcCheckForErrors.ProcessFile(aFile: TProcFileObject): TBytes;
var
  nif: TwbNifFile;
  Log: TStringList;
  ext: string;
  buf: TBytes;
  obj: Pointer;
begin
  nif := nil;

  Log := TStringList.Create;
  if fLoadNif then nif := TwbNifFile.Create;
  try
    ext := ExtractFileExt(aFile.FileName);
    obj := nil;

    if fLoadDDS and SameText(ext, '.dds') then begin
      buf := aFile.GetData;
      if not TwbDDS.IsDDS(buf, Length(buf)) then
        Log.Add(#9'Not a valid DDS file')
      else
        obj := buf;
    end

    else if fLoadNif and not SameText(ext, '.dds') then begin
      nif.LoadFromData(aFile.GetData);
      obj := nif;
    end;

    if Assigned(Obj) then
      for var i: Integer := Low(Checks) to High(Checks) do
        if Checks[i].Active and Checks[i].DoesExtension(ext) then
          Checks[i].Proc(aFile, obj, Log);

    if Log.Count > 0 then begin
      Log.Insert(0, aFile.FileName);
      Log.Add('');
      fManager.AddMessages(Log);
    end;

  finally
    nif.Free;
    Log.Free;
  end;

end;

end.

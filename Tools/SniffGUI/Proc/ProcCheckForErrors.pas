{******************************************************************************

  This Source Code Form is subject to the terms of the Mozilla Public License,
  v. 2.0. If a copy of the MPL was not distributed with this file, You can obtain
  one at https://mozilla.org/MPL/2.0/.

*******************************************************************************}

unit ProcCheckForErrors;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes,
  Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, SniffProcessor,
  Vcl.StdCtrls, Vcl.ComCtrls, Vcl.Menus;

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
  private
    { Private declarations }
  public
    { Public declarations }
  end;

  TCheckProcedure = procedure(aObj: Pointer; Log: TStrings);
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

    function ProcessFile(const aInputDirectory, aOutputDirectory: string; var aFileName: string): TBytes; override;
  end;


implementation

{$R *.dfm}

uses
  Math,
  wbDataFormat,
  wbDataFormatNif,
  wbBSArchive;


//==============================================================================
procedure CheckStringIndex(aObj: Pointer; Log: TStrings);
begin
  var nif: TwbNifFile := aObj;

  if not (nif.NifVersion in [nfFO3, nfTES5, nfSSE, nfFO4]) then
    Exit;

  var n: Integer := nif.Header.Elements['Num Strings'].NativeValue;

  for var i: Integer := 0 to Pred(nif.BlocksCount) do begin
    var block: TwbNifBlock := nif.Blocks[i];
    for var j: Integer := 0 to Pred(block.StringsCount) do
      if block.Strings[j].NativeValue >= n then
        Log.Add(#9 + block.Name + ': Invalid string index in ' + block.Strings[j].Path);
  end;

end;

//==============================================================================
procedure CheckRepeatedChildrenNames(aObj: Pointer; Log: TStrings);
begin
  var nif: TwbNifFile := aObj;

  if not (nif.NifVersion in [nfFO3, nfTES5, nfSSE, nfFO4]) then
    Exit;

  var slNames := TStringList.Create;
  try
    for var i: Integer := 0 to Pred(nif.BlocksCount) do begin
      var block := nif.Blocks[i];

      if not block.IsNiObject('NiNode') then
        Continue;

      var children := block.Elements['Children'];
      if not Assigned(children) then
        Continue;

      for var j: Integer := 0 to Pred(children.Count) do begin
        var b := TwbNifBlock(children[j].LinksTo);
        if not Assigned(b) then
          Continue;

        var n := b.EditValues['Name'];
        if (n = '') or (n = 'InvMarker') or (n = 'EditorMarker') then
          Continue;

        if slNames.IndexOf(n) <> - 1 then
          Log.Add(Format(#9 + block.Name + ': Name "%s" is reused in block linked by %s', [n, children[j].Path]))
        else
          slNames.Add(n);
      end;

      slNames.Clear;
    end;
  finally
    slNames.Free;
  end;
end;

//==============================================================================
procedure CheckHardcodedBlockNames(aObj: Pointer; Log: TStrings);
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
  var nif: TwbNifFile := aObj;

  if not (nif.NifVersion in [nfTES3, nfTES4, nfFO3, nfTES5, nfSSE, nfFO4]) then
    Exit;

  for var i: Integer := 0 to Pred(nif.BlocksCount) do begin
    var block := nif.Blocks[i];

    for var j: Integer := Low(cNames) to High(cNames) do
      if block.BlockType = cNames[j].BlockType then begin
        if block.EditValues['Name'] <> cNames[j].Name then
          Log.Add(#9 + block.Name + ': must be named ' + cNames[j].Name);
        Break;
      end;
  end;
end;

//==============================================================================
procedure CheckBSXHavokFlagButNoCollision(aObj: Pointer; Log: TStrings);
begin
  var nif: TwbNifFile := aObj;

  if not (nif.NifVersion in [nfFO3, nfTES5, nfSSE]) then
    Exit;

  var bsx: TwbNifBlock := nif.BlockByName('BSX');
  if not Assigned(bsx) then
    Exit;

  if not bsx.NativeValues['Flags\Havok'] then
    Exit;

  if not Assigned(nif.BlockByType('bhkCollisionObject', True)) and
     not Assigned(nif.BlockByType('bhkRigidBody', True))
  then
    Log.Add(#9 + bsx.Name + ': BSX has Havok flag but no bhkCollisionObject or bhkRigidBody blocks');
end;

//==============================================================================
procedure CheckHavokMassInertia(aObj: Pointer; Log: TStrings);
begin
  var nif: TwbNifFile := aObj;

  if not (nif.NifVersion in [nfFO3, nfTES5, nfSSE]) then
    Exit;

  for var i : Integer := 0 to Pred(nif.BlocksCount) do begin
    var block := nif.Blocks[i];

    if not block.IsNiObject('bhkRigidBody', True) then
      Continue;

    var ms := block.EditValues['Motion System'];

    if not (
      (ms = 'MO_SYS_FIXED') or
      (ms = 'MO_SYS_INVALID') or
      (ms = 'MO_SYS_SPHERE_STABILIZED') or
      (ms = 'MO_SYS_BOX_STABILIZED')
    ) and
      SameValue(block.NativeValues['Mass'], 0.0)
    then
      Log.Add(#9 + block.Name + ': Zero moveable collision mass');

    if ms = 'MO_SYS_SPHERE_INERTIA' then
      if SameValue(block.NativeValues['Inertia Tensor\m11'], 0.0) or
         SameValue(block.NativeValues['Inertia Tensor\m22'], 0.0) or
         SameValue(block.NativeValues['Inertia Tensor\m33'], 0.0)
      then
        Log.Add(#9 + block.Name + ': Uses MO_SYS_SPHERE_INERTIA system but Inertia Tensor matrix is not set)');
  end;
end;

//==============================================================================
procedure CheckSubShapesCollisionOrder(aObj: Pointer; Log: TStrings);
var
  i, j, prevmat, mat: Integer;
begin
  var nif: TwbNifFile := aObj;

  if not (nif.NifVersion in [nfFO3]) then
    Exit;

  for i := 0 to Pred(nif.BlocksCount) do begin
    var block: TwbNifBlock := nif.Blocks[i];
    if block.BlockType <> 'hkPackedNiTriStripsData' then
      Continue;

    var subshapes: TdfElement := block.Elements['Sub Shapes'];
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

//==============================================================================
procedure CheckNiPSysModifierName(aObj: Pointer; Log: TStrings);
var
  i: Integer;
  modifier: TwbNifBlock;
begin
  var nif: TwbNifFile := aObj;

  for i := 0 to Pred(nif.BlocksCount) do begin
    var block: TwbNifBlock := nif.Blocks[i];
    if not block.IsNiObject('NiPSysModifierCtlr', True) then
      Continue;

    var modname: string := block.EditValues['Modifier Name'];
    if modname <> '' then
      modifier := nif.BlockByName(modname)
    else
      modifier := nil;

    if not Assigned(modifier) or not modifier.IsNiObject('NiPSysModifier', True)  then
      Log.Add(#9 + block.Name + ': Modifier Name "' + modname + '" points to invalid block');
  end;

end;

//==============================================================================
procedure CheckNiTimeControllerTarget(aObj: Pointer; Log: TStrings);
var
  i: Integer;
begin
  var nif: TwbNifFile := aObj;

  for i := 0 to Pred(nif.BlocksCount) do begin
    var block: TwbNifBlock := nif.Blocks[i];
    if not block.IsNiObject('NiTimeController', True) then
      Continue;

    var target: TdfElement := block.Elements['Target'];
    if not Assigned(target) then
      Continue;

    if target.LinksTo = nil then
      Log.Add(#9 + block.Name + ': Invalid Target field');
  end;

end;

//==============================================================================
procedure CheckShaderTypeFlags(aObj: Pointer; Log: TStrings);
var
  i: Integer;
  bExternalEmitShader: Boolean;
  EmitShader: string;
begin
  var nif: TwbNifFile := aObj;

  if not (nif.NifVersion in [nfFO3, nfTES5, nfSSE, nfFO4]) then
    Exit;

  bExternalEmitShader := False;

  for i := 0 to Pred(nif.BlocksCount) do begin
    var shape: TwbNifBlock := nif.Blocks[i];
    if not (shape.IsNiObject('BSTriShape') or shape.IsNiObject('NiGeometry')) then
      Continue;

    {
    if not Assigned(shape.Elements['Shader Property']) then
      Continue;

    var shader: TwbNifBlock := TwbNifBlock(shape.Elements['Shader Property'].LinksTo);
    }
    var shader: TwbNifBlock := shape.PropertyByType('BSShaderProperty', True);
    if not Assigned(shader) then
      Continue;

    if not bExternalEmitShader and shader.NativeValues['Shader Flags 1\External_Emittance'] then begin
      bExternalEmitShader := True;
      EmitShader := shader.Name;
    end;

    if (nif.NifVersion >= nfTES5) and Assigned(shader.Elements['Shader Type']) then begin

      if (shader.EditValues['Shader Type'] = 'Environment Map') and
         not shader.NativeValues['Shader Flags 1\Environment_Mapping']
      then
        Log.Add(#9 + shader.Name + ': Environment Map shader type is used but missing Environment_Mapping shader flag');

      if (shader.EditValues['Shader Type'] <> 'Environment Map') and
         shader.NativeValues['Shader Flags 1\Environment_Mapping']
      then
        Log.Add(#9 + shader.Name + ': Environment_Mapping shader flag is set but shader type is not Environment Map');

      if (shader.EditValues['Shader Type'] = 'Eye Envmap') and
         not shader.NativeValues['Shader Flags 1\Eye_Environment_Mapping']
      then
        Log.Add(#9 + shader.Name + ': Eye Envmap shader type is used but missing Eye_Environment_Mapping shader flag');

      if (shader.EditValues['Shader Type'] <> 'Eye Envmap') and
         shader.NativeValues['Shader Flags 1\Eye_Environment_Mapping']
      then
        Log.Add(#9 + shader.Name + ': Eye_Environment_Mapping shader flag is set but shader type is not Eye Envmap');
    end;

    if (nif.NifVersion >= nfTES5) then
      if shape.IsNiObject('NiGeometry') then begin
        var shapedata: TwbNifBlock := TwbNifBlock(shape.Elements['Data'].LinksTo);
        if Assigned(shapedata) then begin
          if (shapedata.NativeValues['Has Vertex Colors'] <> 0) and not shader.NativeValues['Shader Flags 2\Vertex_Colors'] then
            Log.Add(#9 + shapedata.Name + ': Has Vertex Colors is true but missing Vertex Colors shader flag in ' + shader.Name);

          if (shapedata.NativeValues['Has Vertex Colors'] = 0) and shader.NativeValues['Shader Flags 2\Vertex_Colors'] then
            Log.Add(#9 + shapedata.Name + ': Has Vertex Colors is false but Vertex Colors shader flag is set in ' + shader.Name);
        end;
      end
      else begin
        if shape.NativeValues['VertexDesc\VF\VF_COLORS'] and not shader.NativeValues['Shader Flags 2\Vertex_Colors'] then
          Log.Add(#9 + shape.Name + ': contains vertex colors but missing Vertex Colors shader flag in ' + shader.Name);

        if not shape.NativeValues['VertexDesc\VF\VF_COLORS'] and shader.NativeValues['Shader Flags 2\Vertex_Colors'] then
          Log.Add(#9 + shape.Name + ': doesn''t contain vertex colors but Vertex Colors shader flag is set in ' + shader.Name);
      end;

  end;

  var bsx: TwbNifBlock := nif.BlockByName('BSX');
  if not Assigned(bsx) and bExternalEmitShader then
    Log.Add(#9 + EmitShader + ': External_Emit shader flag is set but BSXFlags block is missing with the same flag');

  if Assigned(bsx) then begin
    if (bsx.NativeValues['Flags'] and (1 shl 9) <> 0) and not bExternalEmitShader then
      Log.Add(#9 + bsx.Name + ': External_Emit flag is set but no shaders found with the same flag');

    if (bsx.NativeValues['Flags'] and (1 shl 9) = 0) and bExternalEmitShader then
      Log.Add(#9 + EmitShader + ': External_Emit shader flag is set but the same flag is not set in ' + bsx.Name);
  end;

end;

//==============================================================================
procedure CheckAllWhiteVertexColors(aObj: Pointer; Log: TStrings);
const
  fSingle1 = $3F800000;
  fColor4White: array [0..3] of Cardinal = (fSingle1, fSingle1, fSingle1, fSingle1);
var
  i, j: Integer;
begin
  var nif: TwbNifFile := aObj;

  for i := 0 to Pred(nif.BlocksCount) do begin
    var shape: TwbNifBlock := nif.Blocks[i];
    if not (shape.IsNiObject('BSTriShape') or shape.IsNiObject('NiTriBasedGeom')) then
      Continue;

    // skip leaf animation where vertex colors are required even if all white
    if Assigned(shape.Elements['Shader Property']) then begin
      var shader: TwbNifBlock := TwbNifBlock(shape.Elements['Shader Property'].LinksTo);
      if Assigned(shader) then
        if shader.NativeValues['Shader Flags 2\Tree_Anim'] then
          Continue;
    end;

    if shape.IsNiObject('NiTriBasedGeom') then begin
      var shapedata: TwbNifBlock := TwbNifBlock(shape.Elements['Data'].LinksTo);
      if not Assigned(shapedata) then
        Continue;

      if shapedata.NativeValues['Has Vertex Colors'] = 0 then
        Continue;

      var colors: TdfElement := shapedata.Elements['Vertex Colors'];
      var bAllWhite: Boolean := True;
      for j := 0 to Pred(colors.Count) do
        if not CompareMem(TdfValue(colors[j]).DataStart, @fColor4White[0], SizeOf(fColor4White)) then begin
          bAllWhite := False;
          Break;
        end;
      if bAllWhite then
        Log.Add(#9 + shapedata.Name + ': all white #FFFFFFFF vertex colors');
    end

    else begin
      if not shape.NativeValues['VertexDesc\VF\VF_COLORS'] then
        Continue;

      var vertices: TdfElement := shape.Elements['Vertex Data'];
      if not Assigned(Vertices) then
        Continue;

      var bAllWhite: Boolean := True;
      for j := 0 to Pred(vertices.Count) do
        if PCardinal(TdfValue(vertices[j][8]).DataStart)^ <> $FFFFFFFF then begin
          bAllWhite := False;
          Break;
        end;
      if bAllWhite then
        Log.Add(#9 + shape.Name + ': all white #FFFFFFFF vertex colors');
    end;

  end;

end;

//==============================================================================
procedure CheckHDRVertexColors(aObj: Pointer; Log: TStrings);
const
  sRGB: string = 'RGB';
var
  i, j, k: Integer;
  c: Single;
  bHDR: Boolean;
begin
  var nif: TwbNifFile := aObj;

  for i := 0 to Pred(nif.BlocksCount) do begin
    var shapedata: TwbNifBlock := nif.Blocks[i];
    if not shapedata.IsNiObject('NiTriBasedGeomData') then
      Continue;

    if shapedata.NativeValues['Has Vertex Colors'] = 0 then
      Continue;

    bHDR := False;
    var colors: TdfElement := shapedata.Elements['Vertex Colors'];
    for j := 0 to Pred(colors.Count) do begin

      for k := 1 to Length(sRGB) do begin
        c := colors[j].NativeValues[sRGB[k]];
        if (c < 0.0) or (c > 1.0) then begin
          bHDR := True;
          Break;
        end;
      end;

      if bHDR then begin
        Log.Add(#9 + shapedata.Name + ': HDR vertex color at index ' + IntToStr(j));
        Break;
      end;

    end;

  end;

end;
//==============================================================================
procedure CheckDdsSize(aObj: Pointer; Log: TStrings);

  function IsPowerOf2(x: Cardinal): Boolean;
  begin
    Result := (x <> 0) and (x <> 1) and ( (x and (x - 1)) = 0 );
  end;


begin
  var dds: PDDSHeader := aObj;

  if not IsPowerOf2(dds.dwWidth) or not IsPowerOf2(dds.dwHeight) then
    Log.Add(Format(#9' Texture size %dx%d is not power of 2', [dds.dwWidth, dds.dwHeight]));
end;

//==============================================================================
procedure CheckSSENifFormat(aObj: Pointer; Log: TStrings);
begin
  var nif: TwbNifFile := aObj;

  for var i: Integer := 0 to Pred(nif.BlocksCount) do begin
    var block: TwbNifBlock := nif.Blocks[i];

    if block.BlockType = 'NiTriStrips' then
      Log.Add(#9 + block.Name + ': NiTriStrips block crashes Skyrim SE')

    else if block.BlockType = 'bhkMultiSphereShape' then
      Log.Add(#9 + block.Name + ': bhkMultiSphereShape block crashes Skyrim SE')

    else if block.BlockType = 'NiSkinPartition' then begin
      var Parts: TdfElement := block.Elements['Partitions'];
      if Assigned(Parts) then
        for var p: Integer := 0 to Pred(Parts.Count) do
          if Parts[p].NativeValues['Num Strips'] <> 0 then begin
            Log.Add(#9 + block.Name + ': NiSkinPartition block with triangle strips crashes Skyrim SE');
            Break;
          end;
    end;

  end;
end;

//==============================================================================
procedure CheckSSEDdsFormat(aObj: Pointer; Log: TStrings);
begin
  var dds: PDDSHeader := aObj;

  if (dds.ddspf.dwFlags and DDPF_RGB <> 0) and (
    (dds.ddspf.dwRBitMask <> $00FF0000) or
    (dds.ddspf.dwGBitMask <> $0000FF00) or
    (dds.ddspf.dwBBitMask <> $000000FF)
  ) then
    Log.Add(Format(#9' Texture format is not supported by Skyrim SE in Windows 7', [dds.dwWidth, dds.dwHeight]));
end;

//==============================================================================
function TCheck.DoesExtension(const aExtension: string): Boolean;
begin
  for var s: string in Extensions do
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

  AddCheck('Repeated NiNode childen names', 'Meshes', ['.nif'],
   'The same named blocks (or the same block) is used several times in NiNode children, might cause issues or even crash the game depending on usage context',
   CheckRepeatedChildrenNames);

  AddCheck('Hardcoded block names', 'Meshes', ['.nif'],
   'Some blocks must have specific name to work properly like BSX for BSXFlags, INV for BsInvMarker, etc.',
   CheckHardcodedBlockNames);

  AddCheck('Present collision but no Havok flag', 'Meshes', ['.nif'],
   'BSXFlags with Bit 1: Havok set but mesh doesn''t have bhkCollisionObjects or any bhkRigidBodies blocks at all',
   CheckBSXHavokFlagButNoCollision);

  AddCheck('Zero mass or inertia in collision', 'Meshes', ['.nif'],
   'Moveable collision has zero mass or uses inertia system without inertia tensor matrix set (will break the physics not only for that object, but other objects using totally different meshes as well)',
   CheckHavokMassInertia);

  AddCheck('Invalid subshapes material order', 'Meshes', ['.nif'],
   'Sub Shapes material in hkPackedNiTriStripsData must be in ascending order, otherwise the first one will be used for all shapes in game',
   CheckSubShapesCollisionOrder);

  AddCheck('Invalid shader types and flags', 'Meshes', ['.nif'],
   'Check for invalid combinations of shader type and shader flags: environment mapping, eye envmapping, external emittance',
   CheckShaderTypeFlags);

  AddCheck('Invalid Modifier Name in NiPSysModifierCtlr', 'Meshes', ['.nif'],
   'Check for the invalid Modifier Name field in descendants of NiPSysModifierCtlr',
   CheckNiPSysModifierName);

  AddCheck('Empty Target in NiTimeController', 'Meshes', ['.nif'],
   'Check for the empty Target field in descendants of NiTimeController',
   CheckNiTimeControllerTarget);

  AddCheck('Redundant white vertex colors', 'Meshes', ['.nif'],
   'Check for possibly redundant all white vertex colors except for leaf animations where they are required',
   CheckAllWhiteVertexColors);

  AddCheck('HDR vertex colors', 'Meshes', ['.nif'],
   'Check for HDR vertex colors (outside of 0..1 range) which sometimes are not intended and lead to rendering issues in Oblivion, Fallout 3, New Vegas and Skyrim LE',
   CheckHDRVertexColors, False);

  AddCheck('Invalid texture size', 'Textures', ['.dds'],
   'Texture size is not power of 2, always crashes the game',
   CheckDdsSize);

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

function TProcCheckForErrors.ProcessFile(const aInputDirectory, aOutputDirectory: string; var aFileName: string): TBytes;
var
  nif: TwbNifFile;
  dds: TDDSHeader;
  Log: TStringList;
  ext: string;
  obj: Pointer;
begin
  nif := nil;

  Log := TStringList.Create;
  if fLoadNif then nif := TwbNifFile.Create;
  try
    ext := ExtractFileExt(aFileName);
    obj := nil;

    if SameText(ext, '.nif') or SameText(ext, '.kf') then begin
      if fLoadNif then nif.LoadFromFile(aInputDirectory + aFileName);
      obj := nif;
    end else

    if SameText(ext, '.dds') and fLoadDDS then begin
      with TFileStream.Create(aInputDirectory + aFileName, fmOpenRead + fmShareDenyNone) do try
        if ( Read(dds, SizeOf(dds)) <> SizeOf(dds) ) or (dds.Magic <> 'DDS ') then
          Log.Add(#9' Not a valid DDS file')
        else
          obj := @dds;
      finally
        Free;
      end;
    end;

    if obj <> nil then
      for var i: Integer := Low(Checks) to High(Checks) do
        if Checks[i].Active and Checks[i].DoesExtension(ext) then
          Checks[i].Proc(obj, Log);

    if Log.Count > 0 then begin
      fManager.AddMessage(aFileName);
      Log.Add('');
      fManager.AddMessages(Log);
    end;

  finally
    if Assigned(nif) then nif.Free;
    Log.Free;
  end;

end;

end.

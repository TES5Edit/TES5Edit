{******************************************************************************

  This Source Code Form is subject to the terms of the Mozilla Public License,
  v. 2.0. If a copy of the MPL was not distributed with this file, You can obtain
  one at https://mozilla.org/MPL/2.0/.

*******************************************************************************}

unit ProcInertiaUpdate;

interface

uses
  System.Classes,
  System.SysUtils,

  Vcl.Controls,
  Vcl.ExtCtrls,
  Vcl.Forms,
  Vcl.Grids,
  Vcl.Mask,
  Vcl.StdCtrls,
  Vcl.ValEdit,

  SniffProcessor;

type
  TFrameInertiaUpdate = class(TFrame)
    StaticText1: TStaticText;
    chkCenter: TCheckBox;
    edMult: TValueListEditor;
    Label1: TLabel;
    chkPenetration: TCheckBox;
    chkInertia: TCheckBox;
    edDepthMult: TLabeledEdit;
    chkPenetrationStatics: TCheckBox;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

  TProcInertiaUpdate = class(TProcBase)
  private
    Frame: TFrameInertiaUpdate;
    fInertia: Boolean;
    fCenter: Boolean;
    fPenetration: Boolean;
    fPenetrationStatics: Boolean;
    fDepthMult: Single;
    fMult: array of record Part: Integer; Mult: Single; end;
  public
    constructor Create(aManager: TProcManager); override;
    function GetFrame(aOwner: TComponent): TFrame; override;
    procedure OnShow; override;
    procedure OnHide; override;
    procedure OnStart; override;

    function ProcessFile(aFile: TProcFileObject): TBytes; override;
  end;


implementation

{$R *.dfm}

uses
  System.Math,

  wbDataFormat,
  wbDataFormatNif,
  wbNifMath;

constructor TProcInertiaUpdate.Create(aManager: TProcManager);
begin
  inherited;

  fTitle := 'Update Havok inertia';
  fSupportedGames := [gtTES4, gtFO3, gtFNV, gtTES5, gtSSE];
  fExtensions := ['nif'];
end;

function TProcInertiaUpdate.GetFrame(aOwner: TComponent): TFrame;
begin
  Frame := TFrameInertiaUpdate.Create(aOwner);
  Result := Frame;
end;

procedure TProcInertiaUpdate.OnShow;
begin
  Frame.chkInertia.Checked := StorageGetBool('bInertiaUpdate', Frame.chkInertia.Checked);
  Frame.chkCenter.Checked := StorageGetBool('bCenterUpdate', Frame.chkCenter.Checked);
  Frame.chkPenetration.Checked := StorageGetBool('bPenetrationUpdate', Frame.chkPenetration.Checked);
  Frame.chkPenetrationStatics.Checked := StorageGetBool('bPenetrationStaticsUpdate', Frame.chkPenetrationStatics.Checked);
  Frame.edDepthMult.Text := StorageGetString('sDepthMult', Frame.edDepthMult.Text);
  Frame.edMult.Strings.CommaText := StorageGetString('sMult', Frame.edMult.Strings.CommaText);
end;

procedure TProcInertiaUpdate.OnHide;
begin
  StorageSetBool('bInertiaUpdate', Frame.chkInertia.Checked);
  StorageSetBool('bCenterUpdate', Frame.chkCenter.Checked);
  StorageSetBool('bPenetrationUpdate', Frame.chkPenetration.Checked);
  StorageSetBool('bPenetrationStaticsUpdate', Frame.chkPenetrationStatics.Checked);
  StorageSetString('sDepthMult', Frame.edDepthMult.Text);
  StorageSetString('sMult', Frame.edMult.Strings.CommaText);
end;

procedure TProcInertiaUpdate.OnStart;
var
  key, value: string;
  i, k: Integer;
  v: Extended;
begin
  fInertia := Frame.chkInertia.Checked;
  fCenter := Frame.chkCenter.Checked;
  fPenetration := Frame.chkPenetration.Checked;
  fPenetrationStatics := Frame.chkPenetrationStatics.Checked;
  if not (fInertia or fCenter or fPenetration) then
    raise Exception.Create('No update options selected');

  fDepthMult := StrToFloatDef(Frame.edDepthMult.Text, 0.2);
  if SameValue(fDepthMult, 0) then fDepthMult := 0.2;

  SetLength(fMult, 0);
  for i := 0 to Pred(Frame.edMult.Strings.Count) do begin
    key := Frame.edMult.Strings.KeyNames[i];
    value := Frame.edMult.Strings.ValueFromIndex[i];
    if Pos(' ', key) <> 0 then
      key := Copy(key, 1, Pos(' ', key) - 1);

    k := StrToIntDef(key, -1);
    if k = -1 then Continue;

    v := StrToFloatDef(value, -1);
    if v < 0 then Continue;

    SetLength(fMult, Succ(Length(fMult)));
    with fMult[Pred(Length(fMult))] do begin
      Part := k;
      Mult := v;
    end;
  end;

end;

function TProcInertiaUpdate.ProcessFile(aFile: TProcFileObject): TBytes;
var
  nif: TwbNifFile;
  bodypart: Integer;
  Inertia, Center, Depth: TdfElement;
  mult, m, x, y, z, r, lx, ly, lz, m11, m22, m33: Single;
  tx, ty, tz: Single;
  v1, v2, c: TVector3;
  rmin: Double;
  bDynamic, bChanged: Boolean;

  function SetInertia(Inertia: TdfElement; m11, m22, m33: Single): Boolean;
  begin
    Result := False;

    if not bDynamic or not Assigned(Inertia) then
      Exit;

    Result :=
      not SameValue(Inertia.NativeValues['m11'], m11) or
      not SameValue(Inertia.NativeValues['m22'], m22) or
      not SameValue(Inertia.NativeValues['m33'], m33);

    if Result then begin
      Inertia.NativeValues['m11'] := m11;
      Inertia.NativeValues['m22'] := m22;
      Inertia.NativeValues['m33'] := m33;
    end;
  end;

  function SetCenter(Center: TdfElement; x, y, z: Single): Boolean;
  begin
    Result := False;

    if not bDynamic or not Assigned(Center) then
      Exit;

    Result :=
      not SameValue(Center.NativeValues['X'], x) or
      not SameValue(Center.NativeValues['Y'], y) or
      not SameValue(Center.NativeValues['Z'], z);

    if Result then begin
      Center.NativeValues['X'] := x;
      Center.NativeValues['Y'] := y;
      Center.NativeValues['Z'] := z;
    end;
  end;

  function SetPenetration(Depth: TdfElement; d: Single): Boolean;
  begin
    Result := False;

    if (not bDynamic and not fPenetrationStatics) or not Assigned(Depth) then
      Exit;

    if SameValue(d, 0) then d := 0.04;
    Result := not SameValue(Depth.NativeValue, d);

    if Result then
      Depth.NativeValue := d;
  end;

begin
  bChanged := False;
  nif := TwbNifFile.Create;
  try
    nif.LoadFromData(aFile.GetData);

    for var rigid in nif.BlocksByType('bhkRigidBody', True) do begin
      var shape := TwbNifBlock(rigid.Elements['Shape'].LinksTo);
      if not Assigned(shape) then
        Continue;

      bDynamic := rigid.IsDynamicRigidBody;

      // intermediate transform shapes
      tx := 0; ty := 0; tz := 0;
      while shape.IsNiObject('bhkTransformShape') do begin
        tx := tx + shape.NativeValues['Transform\m14'];
        ty := ty + shape.NativeValues['Transform\m24'];
        tz := tz + shape.NativeValues['Transform\m34'];
        shape := TwbNifBlock(shape.Elements['Shape'].LinksTo);
        if not Assigned(shape) then
          Break;
      end;

      if not Assigned(shape) then
        Continue;

      Inertia := rigid.Elements['Inertia Tensor'];
      Center := rigid.Elements['Center'];
      Depth := rigid.Elements['Penetration Depth'];
      m := rigid.NativeValues['Mass'];
      bodypart := rigid.NativeValues['Havok Filter\Flags and Part Number'];
      mult := 1;
      for var j: Integer := Low(fMult) to High(fMult) do
        if fMult[j].Part = bodypart then begin
          mult := fMult[j].Mult;
          Break;
        end;

      var minpen: Single;
      if nif.NifVersion < nfTES5 then minpen := 0.01 else minpen := 0.002;

      // box
      if shape.BlockType = 'bhkBoxShape' then begin
        x := shape.NativeValues['Dimensions\X'];
        y := shape.NativeValues['Dimensions\Y'];
        z := shape.NativeValues['Dimensions\Z'];
        m11 := m * (y*y + z*z) / 12;
        m22 := m * (x*x + z*z) / 12;
        m33 := m * (x*x + y*y) / 12;
        m11 := m11 * mult; m22 := m22 * mult; m33 := m33 * mult;
        if fInertia then
          bChanged := SetInertia(Inertia, m11, m22, m33) or bChanged;
        if fCenter then
          bChanged := SetCenter(Center, tx, ty, tz) or bChanged;
        if fPenetration then
          bChanged := SetPenetration(Depth, Max(MinValue([x, y, z]) * fDepthMult, minpen)) or bChanged;
      end

      // sphere
      else if shape.BlockType = 'bhkSphereShape' then begin
        r := shape.NativeValues['Radius'];
        m11 := 2 * m * r*r / 5;
        m11 := m11 * mult;
        if fInertia then
          bChanged := SetInertia(Inertia, m11, m11, m11) or bChanged;
        if fCenter then
          bChanged := SetCenter(Center, tx, ty, tz) or bChanged;
        if fPenetration then
          bChanged := SetPenetration(Depth, Max(2*r * fDepthMult, minpen)) or bChanged;
      end

      // capsule
      else if shape.BlockType = 'bhkCapsuleShape' then begin
        r := shape.NativeValues['Radius'];
        lx := Abs(shape.NativeValues['First Point\X'] - shape.NativeValues['Second Point\X']);
        ly := Abs(shape.NativeValues['First Point\Y'] - shape.NativeValues['Second Point\Y']);
        lz := Abs(shape.NativeValues['First Point\Z'] - shape.NativeValues['Second Point\Z']);
        if (lx >= ly) and (lx >= lz) then begin
          m11 := m * r*r / 2;
          m22 := m * r*r / 4 + m * sqr(lx + 2*r) / 12;
          m33 := m22;
        end
        else if (ly >= lx) and (ly >= lz) then begin
          m11 := m * r*r / 4 + m * sqr(ly + 2*r) / 12;
          m22 := m * r*r / 2;
          m33 := m11;
        end
        else begin
          m11 := m * r*r / 4 + m * sqr(lz + 2*r) / 12;
          m22 := m11;
          m33 := m * r*r / 2;
        end;
        m11 := m11 * mult; m22 := m22 * mult; m33 := m33 * mult;
        if fInertia then
          bChanged := SetInertia(Inertia, m11, m22, m33) or bChanged;
        if fCenter then begin
          x := (shape.NativeValues['First Point\X'] + shape.NativeValues['Second Point\X']) / 2;
          y := (shape.NativeValues['First Point\Y'] + shape.NativeValues['Second Point\Y']) / 2;
          z := (shape.NativeValues['First Point\Z'] + shape.NativeValues['Second Point\Z']) / 2;
          bChanged := SetCenter(Center, x + tx, y + ty, z + tz) or bChanged;
        end;
        if fPenetration then
          bChanged := SetPenetration(Depth, {MinValue([2*r, Abs(lx), Abs(ly), Abs(lz)])} Max(2*r * fDepthMult, minpen)) or bChanged;
      end

      // convex or MOPP shape
      else if (shape.BlockType = 'bhkConvexVerticesShape') or (shape.BlockType = 'bhkMoppBvTreeShape') then begin
        var dm := fDepthMult;
        var verts: TVector3Array;

        if shape.BlockType = 'bhkConvexVerticesShape' then
          verts := shape.GetVertices

        else if shape.BlockType = 'bhkMoppBvTreeShape' then begin
          shape := TwbNifBlock(shape.Elements['Shape'].LinksTo);
          if not Assigned(shape) then Continue;
          if shape.Elements['Data'] = nil then Continue;
          shape := TwbNifBlock(shape.Elements['Data'].LinksTo);
          if not Assigned(shape) then Continue;

          if shape.BlockType = 'hkPackedNiTriStripsData' then begin
            verts := shape.GetVertices;
            // strips data vertices are in game units, need to convert to Havok
            dm := dm / HK2GU[nif.NifVersion];
          end

          else if shape.BlockType = 'bhkCompressedMeshShapeData' then begin
            var bigverts := shape.Elements['Big Verts'];
            for var i := 0 to Pred(bigverts.Count) do begin
              var v: TVector3;
              v.x := bigverts[i].NativeValues['X'];
              v.y := bigverts[i].NativeValues['Y'];
              v.z := bigverts[i].NativeValues['Z'];
              verts := verts + [v];
            end;

            var transforms := shape.Elements['Chunk Transforms'];
            var chunks := shape.Elements['Chunks'];
            for var i := 0 to Pred(chunks.Count) do begin
              var el := chunks[i].Elements['Vertices'];
              if el.Count < 3 then Continue;

              var t: TTransform;
              var tindex: ShortInt := chunks[i].NativeValues['Transform Index'];
              if tindex <> -1 then begin
                var chunkt := transforms[tindex];
                t.Translation.x := chunkt.NativeValues['Translation\X'] + chunks[i].NativeValues['Offset\X'];
                t.Translation.y := chunkt.NativeValues['Translation\Y'] + chunks[i].NativeValues['Offset\Y'];
                t.Translation.z := chunkt.NativeValues['Translation\Z'] + chunks[i].NativeValues['Offset\Z'];
                t.Rotation.x := chunkt.NativeValues['Rotation\X'];
                t.Rotation.y := chunkt.NativeValues['Rotation\Y'];
                t.Rotation.z := chunkt.NativeValues['Rotation\Z'];
                t.Rotation.w := chunkt.NativeValues['Rotation\W'];
                t.Scale := 1.0;
              end;

              for var j := 0 to Pred(el.Count div 3) do begin
                var v: TVector3;
                v.x := el[3*j    ].NativeValue;
                v.y := el[3*j + 1].NativeValue;
                v.z := el[3*j + 2].NativeValue;
                v := v / 1000.0;
                if tindex <> -1 then v := v * t;
                verts := verts + [v];
              end;
            end;
          end;

        end;

        if Length(verts) = 0 then
          Continue;

        // treating as a box for inertia
        CalculateMinMax(verts, v1, v2);
        x := v2.x - v1.x;
        y := v2.y - v1.y;
        z := v2.z - v1.z;
        m11 := m * (y*y + z*z) / 12;
        m22 := m * (x*x + z*z) / 12;
        m33 := m * (x*x + y*y) / 12;
        m11 := m11 * mult; m22 := m22 * mult; m33 := m33 * mult;
        CalculateCenterRadius(verts, c, rmin, True, False);
        if fInertia then
          bChanged := SetInertia(Inertia, m11, m22, m33) or bChanged;
        if fCenter then
          bChanged := SetCenter(Center, tx + c.x, ty + c.y, tz + c.z) or bChanged;
        if fPenetration then
          bChanged := SetPenetration(Depth, Max(2*rmin * dm, minpen)) or bChanged;
      end;
    end;

    if bChanged then
      nif.SaveToData(Result);

  finally
    nif.Free;
  end;

end;



end.

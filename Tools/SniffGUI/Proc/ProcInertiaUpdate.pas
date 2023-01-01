{******************************************************************************

  This Source Code Form is subject to the terms of the Mozilla Public License,
  v. 2.0. If a copy of the MPL was not distributed with this file, You can obtain
  one at https://mozilla.org/MPL/2.0/.

*******************************************************************************}

unit ProcInertiaUpdate;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes,
  Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, SniffProcessor,
  Vcl.StdCtrls, Vcl.Grids, Vcl.ValEdit;

type
  TFrameInertiaUpdate = class(TFrame)
    StaticText1: TStaticText;
    chkCenterUpdate: TCheckBox;
    edMult: TValueListEditor;
    Label1: TLabel;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

  TProcInertiaUpdate = class(TProcBase)
  private
    Frame: TFrameInertiaUpdate;
    fCenterUpdate: Boolean;
    fMult: array of record Part: Integer; Mult: Single; end;
  public
    constructor Create(aManager: TProcManager); override;
    function GetFrame(aOwner: TComponent): TFrame; override;
    procedure OnShow; override;
    procedure OnHide; override;
    procedure OnStart; override;

    function ProcessFile(const aInputDirectory, aOutputDirectory: string; var aFileName: string): TBytes; override;
  end;


implementation

{$R *.dfm}

uses
  wbDataFormat,
  wbDataFormatNif,
  Math;

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
  Frame.chkCenterUpdate.Checked := StorageGetBool('bCenterUpdate', Frame.chkCenterUpdate.Checked);
  Frame.edMult.Strings.CommaText := StorageGetString('sMult', Frame.edMult.Strings.CommaText);
end;

procedure TProcInertiaUpdate.OnHide;
begin
  StorageSetBool('bCenterUpdate', Frame.chkCenterUpdate.Checked);
  StorageSetString('sMult', Frame.edMult.Strings.CommaText);
end;

procedure TProcInertiaUpdate.OnStart;
var
  key, value: string;
  i, k: Integer;
  v: Extended;
begin
  fCenterUpdate := Frame.chkCenterUpdate.Checked;

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

function TProcInertiaUpdate.ProcessFile(const aInputDirectory, aOutputDirectory: string; var aFileName: string): TBytes;

  function SetInertia(Inertia: TdfElement; m11, m22, m33: Single): Boolean;
  begin
    Result := False;

    if not Assigned(Inertia) then
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

    if not Assigned(Center) then
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

var
  nif: TwbNifFile;
  i, bodypart: Integer;
  rigid, shape: TwbNifBlock;
  Inertia, Center: TdfElement;
  mult, m, x, y, z, r, lx, ly, lz, m11, m22, m33: Single;
  bChanged: Boolean;
begin
  bChanged := False;
  nif := TwbNifFile.Create;
  try
    nif.LoadFromFile(aInputDirectory + aFileName);

    for i := 0 to Pred(nif.BlocksCount) do begin
      rigid := nif.Blocks[i];

      if (rigid.BlockType <> 'bhkRigidBody') and (rigid.BlockType <> 'bhkRigidBodyT') then
        Continue;

      shape := TwbNifBlock(rigid.Elements['Shape'].LinksTo);
      if not Assigned(shape) then
        Continue;

      Inertia := rigid.Elements['Inertia Tensor'];
      Center := rigid.Elements['Center'];
      m := rigid.NativeValues['Mass'];
      bodypart := rigid.NativeValues['Havok Filter\Flags and Part Number'];
      mult := 1;
      for var j: Integer := Low(fMult) to High(fMult) do
        if fMult[j].Part = bodypart then begin
          mult := fMult[j].Mult;
          Break;
        end;

      // box
      if shape.BlockType = 'bhkBoxShape' then begin
        x := shape.NativeValues['Dimensions\X'];
        y := shape.NativeValues['Dimensions\Y'];
        z := shape.NativeValues['Dimensions\Z'];
        m11 := m * (y*y + z*z) / 12;
        m22 := m * (x*x + z*z) / 12;
        m33 := m * (x*x + y*y) / 12;
        m11 := m11 * mult; m22 := m22 * mult; m33 := m33 * mult;
        bChanged := SetInertia(Inertia, m11, m22, m33) or bChanged;
        if fCenterUpdate then
          bChanged:= SetCenter(Center, 0, 0, 0) or bChanged;
      end

      // sphere
      else if shape.BlockType = 'bhkSphereShape' then begin
        r := shape.NativeValues['Radius'];
        m11 := 2 * m * r*r / 5;
        m11 := m11 * mult;
        bChanged := SetInertia(Inertia, m11, m11, m11) or bChanged;
        if fCenterUpdate then
          bChanged:= SetCenter(Center, 0, 0, 0) or bChanged;
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
        bChanged := SetInertia(Inertia, m11, m22, m33) or bChanged;
        x := (shape.NativeValues['First Point\X'] + shape.NativeValues['Second Point\X']) / 2;
        y := (shape.NativeValues['First Point\Y'] + shape.NativeValues['Second Point\Y']) / 2;
        z := (shape.NativeValues['First Point\Z'] + shape.NativeValues['Second Point\Z']) / 2;
        if fCenterUpdate then
          bChanged:= SetCenter(Center, x, y, z) or bChanged;
      end;
    end;

    if bChanged then
      nif.SaveToData(Result);

  finally
    nif.Free;
  end;

end;



end.

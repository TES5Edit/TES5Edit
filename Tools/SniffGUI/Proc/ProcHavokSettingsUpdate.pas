{******************************************************************************

  This Source Code Form is subject to the terms of the Mozilla Public License,
  v. 2.0. If a copy of the MPL was not distributed with this file, You can obtain
  one at https://mozilla.org/MPL/2.0/.

*******************************************************************************}

unit ProcHavokSettingsUpdate;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes,
  Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, SniffProcessor, Vcl.Grids,
  Vcl.ValEdit, Vcl.StdCtrls;

type
  TFrameHavokSettings = class(TFrame)
    StaticText1: TStaticText;
    edSettings: TValueListEditor;
    procedure edSettingsGetPickList(Sender: TObject; const KeyName: string;
      Values: TStrings);
  private
    { Private declarations }
  public
    { Public declarations }
    Proc: TProcBase;
  end;

  TProcHavokSettingsUpdate = class(TProcBase)
  private
    Frame: TFrameHavokSettings;
    fMaterial: string;
    fRadius: string;
    fLayer: string;
    fMass: string;
    fLinearDamping: string;
    fAngularDamping: string;
    fMaxLinearVelocity: string;
    fMaxAngularVelocity: string;
    fFriction: string;
    fRestitution: string;
    fMotionSystem: string;
    fDeactivatorType: string;
    fSolverDeactivation: string;
    fMotionQuality: string;

  public
    slMaterial: TStringList;
    slLayer: TStringList;
    slMotionSystem: TStringList;
    slDeactivatorType: TStringList;
    slSolverDeactivation: TStringList;
    slMotionQuality: TStringList;

    constructor Create(aManager: TProcManager); override;
    destructor Destroy; override;
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
  wbDataFormatNifTypes;

constructor TProcHavokSettingsUpdate.Create(aManager: TProcManager);
var
  i: Integer;
begin
  inherited;

  fTitle := 'Update Havok settings';
  fSupportedGames := [gtTES4, gtFO3, gtFNV, gtTES5, gtSSE];
  fExtensions := ['nif'];

  slMaterial := TStringList.Create;
  with TdfEnumDef(wbOblivionHavokMaterial('', '', [])) do try
    for i := 0 to Pred(ValuesMapCount) do
      slMaterial.Add(Values[i]);
  finally
    Free;
  end;
  with TdfEnumDef(wbFallout3HavokMaterial('', '', [])) do try
    for i := 0 to Pred(ValuesMapCount) do
      slMaterial.Add(Values[i]);
  finally
    Free;
  end;
  with TdfEnumDef(wbSkyrimHavokMaterial('', '', [])) do try
    for i := 0 to Pred(ValuesMapCount) do
      slMaterial.Add(Values[i]);
  finally
    Free;
  end;
  slMaterial.Sort;
  slMaterial.Insert(0, '');

  slLayer := TStringList.Create;
  with TdfEnumDef(wbOblivionLayer('', '', [])) do try
    for i := 0 to Pred(ValuesMapCount) do
      slLayer.Add(Values[i]);
  finally
    Free;
  end;
  with TdfEnumDef(wbFallout3Layer('', '', [])) do try
    for i := 0 to Pred(ValuesMapCount) do
      slLayer.Add(Values[i]);
  finally
    Free;
  end;
  with TdfEnumDef(wbSkyrimLayer('', '', [])) do try
    for i := 0 to Pred(ValuesMapCount) do
      slLayer.Add(Values[i]);
  finally
    Free;
  end;
  slLayer.Sort;
  slLayer.Insert(0, '');

  slMotionSystem := TStringList.Create;
  slMotionSystem.Add('');
  with TdfEnumDef(wbhkMotionType('', '', [])) do try
    for i := 0 to Pred(ValuesMapCount) do
      slMotionSystem.Add(Values[i]);
  finally
    Free;
  end;

  slDeactivatorType := TStringList.Create;
  slDeactivatorType.Add('');
  with TdfEnumDef(wbhkDeactivatorType('', '', [])) do try
    for i := 0 to Pred(ValuesMapCount) do
      slDeactivatorType.Add(Values[i]);
  finally
    Free;
  end;

  slSolverDeactivation := TStringList.Create;
  slSolverDeactivation.Add('');
  with TdfEnumDef(wbhkSolverDeactivation('', '', [])) do try
    for i := 0 to Pred(ValuesMapCount) do
      slSolverDeactivation.Add(Values[i]);
  finally
    Free;
  end;

  slMotionQuality := TStringList.Create;
  slMotionQuality.Add('');
  with TdfEnumDef(wbhkQualityType('', '', [])) do try
    for i := 0 to Pred(ValuesMapCount) do
      slMotionQuality.Add(Values[i]);
  finally
    Free;
  end;

end;

destructor TProcHavokSettingsUpdate.Destroy;
begin
  slMaterial.Free;
  slLayer.Free;
  slMotionSystem.Free;
  slDeactivatorType.Free;
  slSolverDeactivation.Free;
  slMotionQuality.Free;
end;

function TProcHavokSettingsUpdate.GetFrame(aOwner: TComponent): TFrame;
begin
  Frame := TFrameHavokSettings.Create(aOwner);
  Frame.Proc := Self;
  Result := Frame;
end;

procedure TProcHavokSettingsUpdate.OnShow;
begin
  Frame.edSettings.Values['Material'] := StorageGetString('sMaterial', '');
  Frame.edSettings.Values['Radius'] := StorageGetString('sRadius', '');
  Frame.edSettings.Values['Layer'] := StorageGetString('sLayer', '');
  Frame.edSettings.Values['Mass'] := StorageGetString('sMass', '');
  Frame.edSettings.Values['Linear Damping'] := StorageGetString('sLinearDamping', '');
  Frame.edSettings.Values['Angular Damping'] := StorageGetString('sAngularDamping', '');
  Frame.edSettings.Values['Max Linear Velocity'] := StorageGetString('sMaxLinearVelocity', '');
  Frame.edSettings.Values['Max Angular Velocity'] := StorageGetString('sMaxAngularVelocity', '');
  Frame.edSettings.Values['Friction'] := StorageGetString('sFriction', '');
  Frame.edSettings.Values['Restitution'] := StorageGetString('sRestitution', '');
  Frame.edSettings.Values['Motion System'] := StorageGetString('sMotionSystem', '');
  Frame.edSettings.Values['Deactivator Type'] := StorageGetString('sDeactivatorType', '');
  Frame.edSettings.Values['Solver Deactivation'] := StorageGetString('sSolverDeactivation', '');
  Frame.edSettings.Values['Motion Quality'] := StorageGetString('sMotionQuality', '');
end;

procedure TProcHavokSettingsUpdate.OnHide;
begin
  StorageSetString('sMaterial', Frame.edSettings.Values['Material']);
  StorageSetString('sRadius', Frame.edSettings.Values['Radius']);
  StorageSetString('sLayer', Frame.edSettings.Values['Layer']);
  StorageSetString('sMass', Frame.edSettings.Values['Mass']);
  StorageSetString('sLinearDamping', Frame.edSettings.Values['Linear Damping']);
  StorageSetString('sAngularDamping', Frame.edSettings.Values['Angular Damping']);
  StorageSetString('sMaxLinearVelocity', Frame.edSettings.Values['Max Linear Velocity']);
  StorageSetString('sMaxAngularVelocity', Frame.edSettings.Values['Max Angular Velocity']);
  StorageSetString('sFriction', Frame.edSettings.Values['Friction']);
  StorageSetString('sRestitution', Frame.edSettings.Values['Restitution']);
  StorageSetString('sMotionSystem', Frame.edSettings.Values['Motion System']);
  StorageSetString('sDeactivatorType', Frame.edSettings.Values['Deactivator Type']);
  StorageSetString('sSolverDeactivation', Frame.edSettings.Values['Solver Deactivation']);
  StorageSetString('sMotionQuality', Frame.edSettings.Values['Motion Quality']);
end;

procedure TProcHavokSettingsUpdate.OnStart;

  function GetFloat(const aKey: string): string;
  begin
    Result := Trim(Frame.edSettings.Values[aKey]);
    if Result <> '' then try
      Result := dfFloatToStr(StrToFloat(Result));
    except
      raise Exception.Create(aKey + ' is not a float value');
    end;
  end;

begin
  fMaterial := Frame.edSettings.Values['Material'];
  fRadius := GetFloat('Radius');
  fLayer := Frame.edSettings.Values['Layer'];
  fMass := GetFloat('Mass');
  fLinearDamping := GetFloat('Linear Damping');
  fAngularDamping := GetFloat('Angular Damping');
  fMaxLinearVelocity := GetFloat('Max Linear Velocity');
  fMaxAngularVelocity := GetFloat('Max Angular Velocity');
  fFriction := GetFloat('Friction');
  fRestitution := GetFloat('Restitution');
  fMotionSystem := Frame.edSettings.Values['Motion System'];
  fDeactivatorType := Frame.edSettings.Values['Deactivator Type'];
  fSolverDeactivation := Frame.edSettings.Values['Solver Deactivation'];
  fMotionQuality := Frame.edSettings.Values['Motion Quality'];
end;

function TProcHavokSettingsUpdate.ProcessFile(const aInputDirectory, aOutputDirectory: string; var aFileName: string): TBytes;

  procedure UpdateField(const el: TdfElement; const aValue: string; var aChanged: Boolean);
  begin
    if not Assigned(el) or (aValue = '') then
      Exit;

    if el.EditValue <> aValue then begin
      el.EditValue := aValue;
      aChanged := True;
    end;
  end;

var
  nif: TwbNifFile;
  i: Integer;
  block: TwbNifBlock;
  bChanged: Boolean;
begin
  bChanged := False;
  nif := TwbNifFile.Create;
  try
    nif.LoadFromFile(aInputDirectory + aFileName);

    for i := 0 to Pred(nif.BlocksCount) do begin
      block := nif.Blocks[i];

      if block.IsNiObject('bhkShape', True) then begin
        UpdateField(block.Elements['Material'], fMaterial, bChanged);
        UpdateField(block.Elements['Radius'], fRadius, bChanged);
      end

      else if block.IsNiObject('bhkRigidBody', True) then begin
        UpdateField(block.Elements['Havok Filter\Layer'], fLayer, bChanged);
        UpdateField(block.Elements['Mass'], fMass, bChanged);

        if bChanged and (block.NativeValues['Mass'] = 0) then
          for var k: integer := 0 to 11 do
            block.NativeValues['Inertia Tensor\[' + IntToStr(k) + ']'] := 0;

        UpdateField(block.Elements['Linear Damping'], fLinearDamping, bChanged);
        UpdateField(block.Elements['Angular Damping'], fAngularDamping, bChanged);
        UpdateField(block.Elements['Max Linear Velocity'], fMaxLinearVelocity, bChanged);
        UpdateField(block.Elements['Max Angular Velocity'], fMaxAngularVelocity, bChanged);
        UpdateField(block.Elements['Friction'], fFriction, bChanged);
        UpdateField(block.Elements['Restitution'], fRestitution, bChanged);
        UpdateField(block.Elements['Motion System'], fMotionSystem, bChanged);
        UpdateField(block.Elements['Deactivator Type'], fDeactivatorType, bChanged);
        UpdateField(block.Elements['Solver Deactivation'], fSolverDeactivation, bChanged);
        UpdateField(block.Elements['Motion Quality'], fMotionQuality, bChanged);
      end;

    end;

    if bChanged then
      nif.SaveToData(Result);

  finally
    nif.Free;
  end;

end;

procedure TFrameHavokSettings.edSettingsGetPickList(Sender: TObject;
  const KeyName: string; Values: TStrings);
begin
  if KeyName = 'Material' then
    Values.Assign(TProcHavokSettingsUpdate(Proc).slMaterial)

  else if KeyName = 'Layer' then
    Values.Assign(TProcHavokSettingsUpdate(Proc).slLayer)

  else if KeyName = 'Motion System' then
    Values.Assign(TProcHavokSettingsUpdate(Proc).slMotionSystem)

  else if KeyName = 'Deactivator Type' then
    Values.Assign(TProcHavokSettingsUpdate(Proc).slDeactivatorType)

  else if KeyName = 'Solver Deactivation' then
    Values.Assign(TProcHavokSettingsUpdate(Proc).slSolverDeactivation)

  else if KeyName = 'Motion Quality' then
    Values.Assign(TProcHavokSettingsUpdate(Proc).slMotionQuality);
end;



end.

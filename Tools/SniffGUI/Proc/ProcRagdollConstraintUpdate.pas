{******************************************************************************

  This Source Code Form is subject to the terms of the Mozilla Public License,
  v. 2.0. If a copy of the MPL was not distributed with this file, You can obtain
  one at https://mozilla.org/MPL/2.0/.

*******************************************************************************}

unit ProcRagdollConstraintUpdate;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes,
  Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, SniffProcessor,
  Vcl.StdCtrls;

type
  TFrameRagdollConstraintUpdate = class(TFrame)
    StaticText1: TStaticText;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

  TProcRagdollConstraintUpdate = class(TProcBase)
  private
    Frame: TFrameRagdollConstraintUpdate;
  public
    constructor Create(aManager: TProcManager); override;
    function GetFrame(aOwner: TComponent): TFrame; override;

    function ProcessFile(const aInputDirectory, aOutputDirectory: string; var aFileName: string): TBytes; override;
  end;


implementation

{$R *.dfm}

uses
  wbDataFormat,
  wbDataFormatNif,
  Math;

constructor TProcRagdollConstraintUpdate.Create(aManager: TProcManager);
begin
  inherited;

  fTitle := 'Update ragdoll constraint';
  fSupportedGames := [gtFO3, gtFNV, gtTES5, gtSSE];
  fExtensions := ['nif'];
end;

function TProcRagdollConstraintUpdate.GetFrame(aOwner: TComponent): TFrame;
begin
  Frame := TFrameRagdollConstraintUpdate.Create(aOwner);
  Result := Frame;
end;

function TProcRagdollConstraintUpdate.ProcessFile(const aInputDirectory, aOutputDirectory: string; var aFileName: string): TBytes;

  function CalcUpdate(Twist, Plane, Motor: TdfElement): Boolean;
  var
    x, y, z: Single;
  begin
    Result := False;

    if not Assigned(Twist) or not Assigned(Plane) or not Assigned(Motor) then
      Exit;

    x := Twist.NativeValues['Y'] * Plane.NativeValues['Z'] - Twist.NativeValues['Z'] * Plane.NativeValues['Y'];
    y := Twist.NativeValues['Z'] * Plane.NativeValues['X'] - Twist.NativeValues['X'] * Plane.NativeValues['Z'];
    z := Twist.NativeValues['X'] * Plane.NativeValues['Y'] - Twist.NativeValues['Y'] * Plane.NativeValues['X'];

    Result :=
      not SameValue(Motor.NativeValues['X'], x) or
      not SameValue(Motor.NativeValues['Y'], y) or
      not SameValue(Motor.NativeValues['Z'], z);

    if Result then begin
      Motor.NativeValues['X'] := x;
      Motor.NativeValues['Y'] := y;
      Motor.NativeValues['Z'] := z;
    end;
  end;

var
  nif: TwbNifFile;
  i: Integer;
  Constraint: TwbNifBlock;
  bChanged: Boolean;
begin
  bChanged := False;
  nif := TwbNifFile.Create;
  try
    nif.LoadFromFile(aInputDirectory + aFileName);

    for i := 0 to Pred(nif.BlocksCount) do begin
      Constraint := nif.Blocks[i];

      if Constraint.BlockType <> 'bhkRagdollConstraint' then
        Continue;

      bChanged := CalcUpdate(
        Constraint.Elements['Ragdoll\Twist A'],
        Constraint.Elements['Ragdoll\Plane A'],
        Constraint.Elements['Ragdoll\Motor A']
      ) or bChanged;

      bChanged := CalcUpdate(
        Constraint.Elements['Ragdoll\Twist B'],
        Constraint.Elements['Ragdoll\Plane B'],
        Constraint.Elements['Ragdoll\Motor B']
      ) or bChanged;

    end;

    if bChanged then
      nif.SaveToData(Result);

  finally
    nif.Free;
  end;

end;


end.

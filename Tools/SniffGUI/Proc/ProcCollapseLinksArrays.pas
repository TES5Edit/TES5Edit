{******************************************************************************

  This Source Code Form is subject to the terms of the Mozilla Public License,
  v. 2.0. If a copy of the MPL was not distributed with this file, You can obtain
  one at https://mozilla.org/MPL/2.0/.

*******************************************************************************}

unit ProcCollapseLinksArrays;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes,
  Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, SniffProcessor,
  Vcl.StdCtrls;

type
  TFrameCollapseLinksArrays = class(TFrame)
    StaticText1: TStaticText;
    chkReport: TCheckBox;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

  TProcCollapseLinksArrays = class(TProcBase)
  private
    Frame: TFrameCollapseLinksArrays;
    fReportOnly: Boolean;
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
  wbDataFormatNif;

constructor TProcCollapseLinksArrays.Create(aManager: TProcManager);
begin
  inherited;

  fTitle := 'Collapse link arrays';
  fSupportedGames := [gtTES3, gtTES4, gtFO3, gtFNV, gtTES5, gtSSE, gtFO4];
  fExtensions := ['nif'];
end;

function TProcCollapseLinksArrays.GetFrame(aOwner: TComponent): TFrame;
begin
  Frame := TFrameCollapseLinksArrays.Create(aOwner);
  Result := Frame;
end;

procedure TProcCollapseLinksArrays.OnShow;
begin
  Frame.chkReport.Checked := StorageGetBool('bReportOnly', Frame.chkReport.Checked);
end;

procedure TProcCollapseLinksArrays.OnHide;
begin
  StorageSetBool('bReportOnly', Frame.chkReport.Checked);
end;

procedure TProcCollapseLinksArrays.OnStart;
begin
  fReportOnly := Frame.chkREport.Checked;
end;

function TProcCollapseLinksArrays.ProcessFile(const aInputDirectory, aOutputDirectory: string; var aFileName: string): TBytes;
var
  Log: TStringList;
  nif: TwbNifFile;
  Block: TwbNifBlock;
  el: TdfElement;
  bChanged: Boolean;
  i: Integer;

  procedure ProcessArray(ar: TdfElement; var aChanged: Boolean);
  var
    idx: array of Integer;
    j, k, n: Integer;
  begin
    if not Assigned(ar) then
      Exit;

    SetLength(idx, ar.Count);

    for j := 0 to Pred(ar.Count) do begin
      n := ar[j].NativeValue;
      idx[j] := n;

      if n < 0 then begin
        Log.Add(#9 + ar[j].Path + ' is a null link');
        aChanged := True;
      end
      else if n >= nif.BlocksCount then
        Log.Add(#9 + ar[j].Path + ' is a broken link')
      else
        for k := 0 to j - 1 do
          if idx[k] = n then begin
            Log.Add(#9 + ar[j].Path + ' is a repeated link');
            Break;
          end;
    end;
  end;

begin
  Log := TStringList.Create;
  nif := TwbNifFile.Create;
  nif.Options := [nfoCollapseLinkArrays];
  bChanged := False;

  try
    nif.LoadFromFile(aInputDirectory + aFileName);

    ProcessArray(nif.Footer.Elements['Roots'], bChanged);

    for i := 0 to Pred(nif.BlocksCount) do begin
      block := nif.Blocks[i];

      if block.IsNiObject('NiObjectNET', True) then
        ProcessArray(block.Elements['Extra Data List'], bChanged);

      if block.IsNiObject('NiAVObject', True) then
        ProcessArray(block.Elements['Properties'], bChanged);

      if block.IsNiObject('NiAVObject', True) then
        ProcessArray(block.Elements['Properties'], bChanged);

      if block.IsNiObject('NiNode', True) then begin
        ProcessArray(block.Elements['Children'], bChanged);
        ProcessArray(block.Elements['Effects'], bChanged);
      end;

      if block.IsNiObject('BSTreeNode', True) then begin
        ProcessArray(block.Elements['Bones 1'], bChanged);
        ProcessArray(block.Elements['Bones'], bChanged);
      end;

      if block.IsNiObject('BSAnimNotes', True) then
        ProcessArray(block.Elements['Anim Notes'], bChanged);

      if block.IsNiObject('NiSkinInstance', True) then
        ProcessArray(block.Elements['Bones'], bChanged);

      if block.IsNiObject('bhkRigidBody', True) then
        ProcessArray(block.Elements['Constraints'], bChanged);

      if block.IsNiObject('bhkConstraint', True) then
        ProcessArray(block.Elements['Entities'], bChanged);

      if block.IsNiObject('bhkBallSocketConstraintChain', True) then
        ProcessArray(block.Elements['Entities A'], bChanged);

      if block.IsNiObject('bhkConvexListShape', True) then
        ProcessArray(block.Elements['Sub Shapes'], bChanged);

      if block.IsNiObject('bhkListShape', True) then
        ProcessArray(block.Elements['Sub Shapes'], bChanged);

      if block.IsNiObject('bhkMeshShape', True) then
        ProcessArray(block.Elements['Strips Data'], bChanged);

      if block.IsNiObject('bhkNiTriStripsShape', True) then
        ProcessArray(block.Elements['Strips Data'], bChanged);

      if block.IsNiObject('bhkRagdollTemplate', True) then
        ProcessArray(block.Elements['Bones'], bChanged);

      if block.IsNiObject('NiDynamicEffect', True) then
        ProcessArray(block.Elements['Affected Nodes'], bChanged);

      if block.IsNiObject('NiBoneLODController', True) then begin
        el := block.Elements['Node Groups'];
        if Assigned(el) then
          for var j: Integer := 0 to Pred(el.Count) do
            ProcessArray(el[j], bChanged);

        el := block.Elements['Shade Groups 2'];
        if Assigned(el) then
          for var j: Integer := 0 to Pred(el.Count) do
            ProcessArray(el[j], bChanged);
      end;

      if block.IsNiObject('NiFlipController', True) then
        ProcessArray(block.Elements['Sources'], bChanged);

      if block.IsNiObject('NiControllerManager', True) then
        ProcessArray(block.Elements['Controller Sequences'], bChanged);

      if block.IsNiObject('NiControllerSequence', True) then
        ProcessArray(block.Elements['Anim Notes Array'], bChanged);

      if block.IsNiObject('NiParticleSystem', True) then
        ProcessArray(block.Elements['Modifiers'], bChanged);

      if block.IsNiObject('NiParticleMeshModifier', True) then
        ProcessArray(block.Elements['Particle Meshes'], bChanged);

      if block.IsNiObject('NiPSysMeshUpdateModifier', True) then
        ProcessArray(block.Elements['Meshes'], bChanged);

      if block.IsNiObject('BSPSysHavokUpdateModifier', True) then
        ProcessArray(block.Elements['Nodes'], bChanged);

      if block.IsNiObject('NiPSysMeshEmitter', True) then
        ProcessArray(block.Elements['Emitter Meshes'], bChanged);

      if block.IsNiObject('BSMasterParticleSystem', True) then
        ProcessArray(block.Elements['Particle Systems'], bChanged);

      if block.IsNiObject('BSSkin::Instance', True) then
        ProcessArray(block.Elements['Bones'], bChanged);

    end;

    // save the file if changed and not in report only mode
    if bChanged and not fReportOnly then
      nif.SaveToData(Result);

    if Log.Count <> 0 then begin
      fManager.AddMessage(#13#10 + aFileName);
      fManager.AddMessages(Log);
    end;

  finally
    Log.Free;
    nif.Free;
  end;
end;


end.

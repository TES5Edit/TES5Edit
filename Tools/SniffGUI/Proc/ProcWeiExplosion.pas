{******************************************************************************

  This Source Code Form is subject to the terms of the Mozilla Public License,
  v. 2.0. If a copy of the MPL was not distributed with this file, You can obtain
  one at https://mozilla.org/MPL/2.0/.

*******************************************************************************}

unit ProcWeiExplosion;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes,
  Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, SniffProcessor,
  Vcl.StdCtrls;

type
  TFrameWeiExplosion = class(TFrame)
    StaticText1: TStaticText;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

  TProcWeiExplosion = class(TProcBase)
  private
    Frame: TFrameWeiExplosion;
  public
    constructor Create(aManager: TProcManager); override;
    function GetFrame(aOwner: TComponent): TFrame; override;

    function ProcessFile(const aInputDirectory, aOutputDirectory: string; var aFileName: string): TBytes; override;
  end;

implementation

{$R *.dfm}

uses
  wbDataFormat,
  wbDataFormatNif;

constructor TProcWeiExplosion.Create(aManager: TProcManager);
begin
  inherited;

  fTitle := 'Weijiesen''s blow up thing';
  fSupportedGames := [gtFO3, gtFNV];
  fExtensions := ['nif'];
end;

function TProcWeiExplosion.GetFrame(aOwner: TComponent): TFrame;
begin
  Frame := TFrameWeiExplosion.Create(aOwner);
  Result := Frame;
end;

function TProcWeiExplosion.ProcessFile(const aInputDirectory, aOutputDirectory: string; var aFileName: string): TBytes;
const
  sNonAccum = 'NonAccum';
var
  nif: TwbNifFile;
  b, Root, NonAccum, Controller, Palette, Sequence: TwbNifBlock;
  RootChildren, NonAccumChildren, entries, entry: TdfElement;
  i, j: integer;
  bFound: Boolean;
begin
  nif := TwbNifFile.Create;
  try
    nif.LoadFromFile(aInputDirectory + aFileName);

    // empty nif
    if nif.BlocksCount = 0 then
      Exit;

    // search for key nodes
    NonAccum := nil;
    for i := 0 to Pred(nif.BlocksCount) do
      if (nif.Blocks[i].BlockType = 'NiNode') and nif.Blocks[i].EditValues['Name'].EndsWith(sNonAccum) then begin
        NonAccum := nif.Blocks[i];
        Break;
      end;

    if not Assigned(NonAccum) then begin
      fManager.AddMessage(#9+ aFileName +': NonAccum node is missng');
      Exit;
    end;

    Controller := nif.BlockByType('NiMultiTargetTransformController');
    if not Assigned(Controller) then begin
      fManager.AddMessage(#9+ aFileName +': NiMultiTargetTransformController is missng');
      Exit;
    end;

    Palette := nif.BlockByType('NiDefaultAVObjectPalette');
    if not Assigned(Palette) then begin
      fManager.AddMessage(#9+ aFileName +': NiDefaultAVObjectPalette is missing');
      Exit;
    end;

    Sequence := nif.BlockByType('NiControllerSequence');
    if not Assigned(Sequence) then begin
      fManager.AddMessage(#9+ aFileName +': NiControllerSequence is missing');
      Exit;
    end;

    Root := nif.Blocks[0];
    RootChildren := Root.Elements['Children'];

    // root children have acceptable NiNodes
    bFound := False;
    for i := 0 to Pred(RootChildren.Count) do begin
      b := TwbNifBlock(RootChildren[i].LinksTo);
      if Assigned(b) and (b <> NonAccum) and (b.BlockType = 'NiNode') then begin
        bFound := True;
        Break;
      end;
    end;

    if not bFound then begin
      fManager.AddMessage(#9+ aFileName +': No acceptable NiNodes to process');
      Exit;
    end;

    NonAccumChildren := NonAccum.Elements['Children'];
    NonAccumChildren.Count := 0;

    // add root NiNodes to children of NonAccum
    for i := 0 to Pred(RootChildren.Count) do begin
      b := TwbNifBlock(RootChildren[i].LinksTo);
      if not Assigned(b) then
        Continue;

      if (b = NonAccum) or (b.BlockType <> 'NiNode') then
        Continue;

      NonAccumChildren.Add.NativeValue := b.Index;
    end;

    // remove NonAccum children from root children
    for i := 0 to Pred(NonAccumChildren.Count) do
      for j := Pred(RootChildren.Count) downto 0 do
        if RootChildren[j].NativeValue = NonAccumChildren[i].NativeValue then
          RootChildren[j].Remove;

    // add NonAccum children to Extra Targets of controller
    entries := Controller.Elements['Extra Targets'];
    entries.Count := 0;
    for i := 0 to Pred(NonAccumChildren.Count) do
      entries.Add.NativeValue := NonAccumChildren[i].NativeValue;

    // add NonAccum children to object palette
    entries := Palette.Elements['Objects'];
    entries.Count := 0;
    for i := 0 to Pred(NonAccumChildren.Count) do begin
      entry := entries.Add;
      entry.EditValues['Name'] := NonAccumChildren[i].LinksTo.EditValues['Name'];
      entry.NativeValues['AV Object'] := NonAccumChildren[i].NativeValue;
    end;

    // add NonAccum children to controlled blocks in sequence
    entries := Sequence.Elements['Controlled Blocks'];
    entries.Count := 0;
    for i := 0 to Pred(NonAccumChildren.Count) do begin
      entry := entries.Add;
      b := TwbNifBlock(NonAccumChildren[i].LinksTo);
      entry.EditValues['Node Name'] := b.EditValues['Name'];
      entry.NativeValues['Controller'] := Controller.Index;
      entry.NativeValues['Interpolator'] := b.Elements['Controller'].LinksTo.NativeValues['Interpolator'];
    end;

    // remove NiTransformController from NonAccum children
    for i := 0 to Pred(NonAccumChildren.Count) do
      nif.Delete(NonAccumChildren[i].LinksTo.NativeValues['Controller']);

    nif.SaveToData(Result);

  finally
    nif.Free;
  end;

end;

end.

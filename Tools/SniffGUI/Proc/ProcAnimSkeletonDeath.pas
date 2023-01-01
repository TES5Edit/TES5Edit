{******************************************************************************

  This Source Code Form is subject to the terms of the Mozilla Public License,
  v. 2.0. If a copy of the MPL was not distributed with this file, You can obtain
  one at https://mozilla.org/MPL/2.0/.

*******************************************************************************}

unit ProcAnimSkeletonDeath;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes,
  Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, SniffProcessor,
  Vcl.StdCtrls, Vcl.ExtCtrls;

type
  TFrameAnimSkeletonDeath = class(TFrame)
    StaticText1: TStaticText;
    edNames: TLabeledEdit;
    chkExactMatch: TCheckBox;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

  TProcAnimSkeletonDeath = class(TProcBase)
  private
    Frame: TFrameAnimSkeletonDeath;
    fNames: array of string;
    fExactMatch: Boolean;
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
  StrUtils,
  wbDataFormat,
  wbDataFormatNif;

constructor TProcAnimSkeletonDeath.Create(aManager: TProcManager);
begin
  inherited;

  fTitle := 'Add blocks from skeleton';
  fSupportedGames := [gtTES4, gtFO3, gtFNV];
  fExtensions := ['kf'];
end;

function TProcAnimSkeletonDeath.GetFrame(aOwner: TComponent): TFrame;
begin
  Frame := TFrameAnimSkeletonDeath.Create(aOwner);
  Result := Frame;
end;

procedure TProcAnimSkeletonDeath.OnShow;
begin
  Frame.edNames.Text := StorageGetString('sNames', Frame.edNames.Text);
  Frame.chkExactMatch.Checked := StorageGetBool('bExactMatch', Frame.chkExactMatch.Checked);
end;

procedure TProcAnimSkeletonDeath.OnHide;
begin
  StorageSetString('sNames', Frame.edNames.Text);
  StorageSetBool('bExactMatch', Frame.chkExactMatch.Checked);
end;

procedure TProcAnimSkeletonDeath.OnStart;
begin
  with TStringList.Create do try
    Delimiter := ',';
    StrictDelimiter := True;
    DelimitedText := Frame.edNames.Text;
    SetLength(fNames, Count);
    for var i: Integer := 0 to Pred(Count) do
      fNames[i] := Trim(Strings[i]);
  finally
    Free;
  end;

  fExactMatch := Frame.chkExactMatch.Checked;
end;

function TProcAnimSkeletonDeath.ProcessFile(const aInputDirectory, aOutputDirectory: string; var aFileName: string): TBytes;
var
  nif, skeleton: TwbNifFile;
  entries, entry: TdfElement;
  bone, interpolator: TwbNifBlock;
  skeletonfile, name: string;
  bFound, bMatched, bChanged: Boolean;
begin
  bChanged := False;

  if not SameText(ExtractFileName(aFileName), 'death.kf') then
    Exit;

  skeletonfile := ExtractFilePath(aFileName) + 'skeleton.nif';
  if not FileExists(aInputDirectory + skeletonfile) then
    Exit;

  nif := TwbNifFile.Create;
  skeleton := TwbNifFile.Create;
  try
    nif.LoadFromFile(aInputDirectory + aFileName);

    if nif.BlocksCount = 0 then
      Exit;

    entries := nif.Blocks[0].Elements['Controlled Blocks'];

    if not Assigned(entries)then
      Exit;

    skeleton.LoadFromFile(aInputDirectory + skeletonfile);

    // going over NiNode bones in skeleton
    for bone in skeleton.BlocksByType('NiNode') do begin

      // skip unnamed nodes
      name := bone.EditValues['Name'];
      if name = '' then
        Continue;

      // skip bones with collision
      if bone.Elements['Collision Object'].LinksTo <> nil then
        Continue;

      // skip bones with given names
      bMatched := False;
      for var s: String in fNames do
        if ( fExactMatch and SameText(name, s) ) or ( not fExactMatch and ContainsText(name, s) ) then
          bMatched := True;

      if bMatched then
        Continue;

      // check if controlled block already exists for this bone
      bFound := False;
      for var i: Integer := 0 to Pred(entries.Count) do
        if entries[i].EditValues['Node Name'] = name then begin
          bFound := True;
          Break;
        end;

      if bFound then
        Continue;

      // adding a new controlled block
      entry := entries.Add;
      entry.EditValues['Node Name'] := name;
      entry.NativeValues['Priority'] := 99;
      entry.EditValues['Controller Type'] := 'NiTransformController';

      // interpolator with the same transform as on a bone
      interpolator := nif.AddBlock('NiTransformInterpolator');
      interpolator.Elements['Transform'].Assign(bone.Elements['Transform']);
      entry.NativeValues['Interpolator'] := interpolator.Index;

      bChanged := True;
    end;

    if bChanged then
      nif.Blocks[0].NativeValues['Num Controlled Blocks'] := entries.Count;

    if bChanged then
      nif.SaveToData(Result);

  finally
    nif.Free;
    skeleton.Free;
  end;

end;


end.

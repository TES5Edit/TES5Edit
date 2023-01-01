{******************************************************************************

  This Source Code Form is subject to the terms of the Mozilla Public License,
  v. 2.0. If a copy of the MPL was not distributed with this file, You can obtain
  one at https://mozilla.org/MPL/2.0/.

*******************************************************************************}

unit ProcAddHeadtrackingAnim;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes,
  Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, SniffProcessor,
  Vcl.StdCtrls, Vcl.ExtCtrls;

type
  TFrameAddHeadtrackingAnim = class(TFrame)
    StaticText1: TStaticText;
    chkCycleClampOnly: TCheckBox;
    edKeyValue14: TLabeledEdit;
    edKeyTime2: TLabeledEdit;
    edKeyValue23: TLabeledEdit;
    edKeyTime3: TLabeledEdit;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

  TProcAddHeadtrackingAnim = class(TProcBase)
  private
    Frame: TFrameAddHeadtrackingAnim;
    fCycleClampOnly: boolean;
    fKeyValue14: double;
    fKeyValue23: double;
    fKeyTime2: integer;
    fKeyTime3: integer;
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

constructor TProcAddHeadtrackingAnim.Create(aManager: TProcManager);
begin
  inherited;

  fTitle := 'Add headtracking anim';
  fSupportedGames := [gtFO3, gtFNV];
  fExtensions := ['kf'];
end;

function TProcAddHeadtrackingAnim.GetFrame(aOwner: TComponent): TFrame;
begin
  Frame := TFrameAddHeadtrackingAnim.Create(aOwner);
  Result := Frame;
end;

procedure TProcAddHeadtrackingAnim.OnShow;
begin
  Frame.chkCycleClampOnly.Checked := StorageGetBool('bCycleClampOnly', Frame.chkCycleClampOnly.Checked);
  Frame.edKeyValue14.Text := StorageGetString('sKeyValue14', Frame.edKeyValue14.Text);
  Frame.edKeyValue23.Text := StorageGetString('sKeyValue23', Frame.edKeyValue23.Text);
  Frame.edKeyTime2.Text := StorageGetString('sKeyTime2', Frame.edKeyTime2.Text);
  Frame.edKeyTime3.Text := StorageGetString('sKeyTime3', Frame.edKeyTime3.Text);
end;

procedure TProcAddHeadtrackingAnim.OnHide;
begin
  StorageSetBool('bCycleClampOnly', Frame.chkCycleClampOnly.Checked);
  StorageSetString('sKeyValue14', Frame.edKeyValue14.Text);
  StorageSetString('sKeyValue23', Frame.edKeyValue23.Text);
  StorageSetString('sKeyTime2', Frame.edKeyTime2.Text);
  StorageSetString('sKeyTime3', Frame.edKeyTime3.Text);
end;

procedure TProcAddHeadtrackingAnim.OnStart;
begin
  fCycleClampOnly := Frame.chkCycleClampOnly.Checked;
  fKeyValue14 := dfStrToFloat(Frame.edKeyValue14.Text);
  fKeyValue23 := dfStrToFloat(Frame.edKeyValue23.Text);
  fKeyTime2 := StrToInt(Frame.edKeyTime2.Text);
  fKeyTime3 := StrToInt(Frame.edKeyTime3.Text);
end;

function TProcAddHeadtrackingAnim.ProcessFile(const aInputDirectory, aOutputDirectory: string; var aFileName: string): TBytes;

  function RoundTime(aLen: double; aPercent: integer; aRoundTo: double = 1/30): double;
  begin
    Result := Round(aLen * (aPercent / 100) / aRoundTo) * aRoundTo;
  end;

const
  sBip01Head = 'Bip01 Head';
var
  nif: TwbNifFile;
  seq, interpolator, idata: TwbNifBlock;
  entries, entry: TdfElement;
  i, p: Integer;
  len: double;
  bHasHead: Boolean;
begin
  nif := TwbNifFile.Create;
  try
    nif.LoadFromFile(aInputDirectory + aFileName);

    if nif.BlocksCount = 0 then
      Exit;

    seq := nif.Blocks[0];
    if seq.BlockType <> 'NiControllerSequence' then
      Exit;

    if fCycleClampOnly and (seq.EditValues['Cycle Type'] <> 'CYCLE_CLAMP') then
      Exit;

    entries := seq.Elements['Controlled Blocks'];
    if not Assigned(entries)then
      Exit;

    bHasHead := False; p := 0;
    // checking for Bip01 Head blocks
    for i := 0 to Pred(entries.Count) do begin
      entry := entries[i];
      if entry.EditValues['Node Name'] = sBip01Head then begin
        // such controller already present, skip this mesh
        if entry.EditValues['Controller Type'] = 'NiFloatExtraDataController' then
          Exit;

        p := entry.NativeValues['Priority'];
        bHasHead := True;
      end;
    end;

    // no head blocks found, skip this mesh
    if not bHasHead then
      Exit;

    // adding new controlled block
    entry := entries.Add;
    seq.NativeValues['Num Controlled Blocks'] := entries.Count;
    entry.EditValues['Node Name'] := sBip01Head;
    entry.NativeValues['Priority'] := p;
    entry.EditValues['Controller Type'] := 'NiFloatExtraDataController';
    entry.EditValues['Controller ID'] := 'HeadTrack';

    // adding new interpolator
    interpolator := nif.AddBlock('NiFloatInterpolator');
    entry.NativeValues['Interpolator'] := interpolator.Index;

    // adding extra data
    idata := nif.AddBlock('NiFloatData');
    interpolator.NativeValues['Data'] := idata.Index;
    entries := idata.Elements['Data\Keys'];
    entries.Count := 4;
    idata.NativeValues['Data\Num Keys'] := entries.Count;
    idata.EditValues['Data\Interpolation'] := 'LINEAR_KEY';

    len := seq.NativeValues['Stop Time']{ - seq.NativeValues['Start Time']}; // assuming always 0

    entries[0].NativeValues['Time'] := 0;
    entries[0].NativeValues['Value'] := fKeyValue14;

    entries[1].NativeValues['Time'] := RoundTime(len, fKeyTime2);
    entries[1].NativeValues['Value'] := fKeyValue23;

    entries[2].NativeValues['Time'] := RoundTime(len, fKeyTime3);
    entries[2].NativeValues['Value'] := fKeyValue23;

    entries[3].NativeValues['Time'] := len;
    entries[3].NativeValues['Value'] := fKeyValue14;

    nif.SaveToData(Result);

  finally
    nif.Free;
  end;

end;


end.

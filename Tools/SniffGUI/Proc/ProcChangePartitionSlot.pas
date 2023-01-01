{******************************************************************************

  This Source Code Form is subject to the terms of the Mozilla Public License,
  v. 2.0. If a copy of the MPL was not distributed with this file, You can obtain
  one at https://mozilla.org/MPL/2.0/.

*******************************************************************************}

unit ProcChangePartitionSlot;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes,
  Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, SniffProcessor,
  Vcl.StdCtrls, Vcl.ExtCtrls;

type
  TFrameChangePartitionSlot = class(TFrame)
    StaticText1: TStaticText;
    edSlotOld: TLabeledEdit;
    edSlotNew: TLabeledEdit;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

  TProcChangePartitionSlot = class(TProcBase)
  private
    Frame: TFrameChangePartitionSlot;
    SlotOld: integer;
    SlotNew: integer;
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

constructor TProcChangePartitionSlot.Create(aManager: TProcManager);
begin
  inherited;

  fTitle := 'Change partition slot';
  fSupportedGames := [gtTES5, gtSSE];
  fExtensions := ['nif'];
end;

function TProcChangePartitionSlot.GetFrame(aOwner: TComponent): TFrame;
begin
  Frame := TFrameChangePartitionSlot.Create(aOwner);
  Result := Frame;
end;

procedure TProcChangePartitionSlot.OnShow;
begin
  Frame.edSlotOld.Text := StorageGetString('sSlotOld', Frame.edSlotOld.Text);
  Frame.edSlotNew.Text := StorageGetString('sSlotNew', Frame.edSlotNew.Text);
end;

procedure TProcChangePartitionSlot.OnHide;
begin
  StorageSetString('sSlotOld', Frame.edSlotOld.Text);
  StorageSetString('sSlotNew', Frame.edSlotNew.Text);
end;

procedure TProcChangePartitionSlot.OnStart;
begin
  try
    SlotOld := StrToInt(Frame.edSlotOld.Text);
    if (SlotOld < Low(Word)) or (SlotOld > High(Word)) then
      raise Exception.Create('');
  except
    raise Exception.Create('Invalid old slot value');
  end;

  try
    SlotNew := StrToInt(Frame.edSlotNew.Text);
    if (SlotNew < Low(Word)) or (SlotNew > High(Word)) then
      raise Exception.Create('');
  except
    raise Exception.Create('Invalid new slot value');
  end;

end;

function TProcChangePartitionSlot.ProcessFile(const aInputDirectory, aOutputDirectory: string; var aFileName: string): TBytes;
var
  nif: TwbNifFile;
  block: TwbNifBlock;
  entries, entry: TdfElement;
  bChanged: Boolean;
begin
  bChanged := False;
  nif := TwbNifFile.Create;
  try
    nif.LoadFromFile(aInputDirectory + aFileName);

    for var i: Integer := 0 to Pred(nif.BlocksCount) do begin
      block := nif.Blocks[i];

      if block.BlockType <> 'BSDismemberSkinInstance' then
        Continue;

      entries := block.Elements['Partitions'];
      if not Assigned(entries) then
        Continue;

      for var j: Integer := 0 to Pred(entries.Count) do begin
        entry := entries[j];
        if entry.NativeValues['Body Part'] = SlotOld then begin
          entry.NativeValues['Body Part'] := SlotNew;
          bChanged := True;
        end;
      end;

    end;

    if bChanged then
      nif.SaveToData(Result);

  finally
    nif.Free;
  end;

end;

end.

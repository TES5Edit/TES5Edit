{******************************************************************************

  This Source Code Form is subject to the terms of the Mozilla Public License,
  v. 2.0. If a copy of the MPL was not distributed with this file, You can obtain
  one at https://mozilla.org/MPL/2.0/.

*******************************************************************************}

unit ProcUniversalTweaker;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes,
  Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, SniffProcessor,
  Vcl.StdCtrls, Vcl.ExtCtrls;

type
  TFrameUniversalTweaker = class(TFrame)
    StaticText1: TStaticText;
    edBlocks: TLabeledEdit;
    edPath: TLabeledEdit;
    edValue: TLabeledEdit;
    Label1: TLabel;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

  TProcUniversalTweaker = class(TProcBase)
  private
    Frame: TFrameUniversalTweaker;
    fBlocks: array of string;
    fPath: string;
    fValue: string;
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

constructor TProcUniversalTweaker.Create(aManager: TProcManager);
begin
  inherited;

  fTitle := 'Universal tweaker';
  fSupportedGames := [gtTES3, gtTES4, gtFO3, gtFNV, gtTES5, gtSSE, gtFO4];
  fExtensions := ['nif', 'kf'];
end;

function TProcUniversalTweaker.GetFrame(aOwner: TComponent): TFrame;
begin
  Frame := TFrameUniversalTweaker.Create(aOwner);
  Result := Frame;
end;

procedure TProcUniversalTweaker.OnShow;
begin
  Frame.edBlocks.Text := StorageGetString('sBlocks', Frame.edBlocks.Text);
  Frame.edPath.Text := StorageGetString('sPath', Frame.edPath.Text);
  Frame.edValue.Text := StorageGetString('sValue', Frame.edValue.Text);
end;

procedure TProcUniversalTweaker.OnHide;
begin
  StorageSetString('sBlocks', Frame.edBlocks.Text);
  StorageSetString('sPath', Frame.edPath.Text);
  StorageSetString('sValue', Frame.edValue.Text);
end;

procedure TProcUniversalTweaker.OnStart;
begin
  with TStringList.Create do try
    Delimiter := ',';
    StrictDelimiter := True;
    DelimitedText := Frame.edBlocks.Text;
    SetLength(fBlocks, Count);
    for var i: Integer := 0 to Pred(Count) do
      fBlocks[i] := Trim(Strings[i]);
  finally
    Free;
  end;

  if Length(fBlocks) = 0 then
    raise Exception.Create('Need at least one block type to process');

  fPath := Frame.edPath.Text;
  if fPath = '' then
    raise Exception.Create('Path can not be empty');

  fValue := Frame.edValue.Text;
end;

function TProcUniversalTweaker.ProcessFile(const aInputDirectory, aOutputDirectory: string; var aFileName: string): TBytes;
var
  nif: TwbNifFile;
  i: Integer;
  block: TwbNifBlock;
  bChanged, bMatched: Boolean;
  oldvalue: string;
begin
  bChanged := False;
  nif := TwbNifFile.Create;
  try
    nif.LoadFromFile(aInputDirectory + aFileName);

    // processing specific block by path
    if (Length(fBlocks) = 1) and (Pos('\', fBlocks[0]) <> 0) then begin
      block := nif.BlockByPath(fBlocks[0]);
      if not Assigned(block) then
        Exit;

      oldvalue := block.EditValues[fPath];

      block.EditValues[fPath] := fValue;

      if oldvalue <> block.EditValues[fPath] then
        bChanged := True;

    end else

    // processing blocks by type
    for i := 0 to Pred(nif.BlocksCount) do begin
      block := nif.Blocks[i];

      bMatched:= False;
      for var s: string in fBlocks do
        if SameText(block.BlockType, s) then
          bMatched := True;

      if not bMatched then
        Continue;

      oldvalue := block.EditValues[fPath];

      block.EditValues[fPath] := fValue;

      if oldvalue <> block.EditValues[fPath] then
        bChanged := True;

    end;

    if bChanged then
      nif.SaveToData(Result);

  finally
    nif.Free;
  end;

end;




end.

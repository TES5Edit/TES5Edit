{******************************************************************************

  This Source Code Form is subject to the terms of the Mozilla Public License,
  v. 2.0. If a copy of the MPL was not distributed with this file, You can obtain
  one at https://mozilla.org/MPL/2.0/.

*******************************************************************************}

unit ProcRemoveControlledBlocks;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes,
  Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, SniffProcessor,
  Vcl.StdCtrls, Vcl.ExtCtrls;

type
  TFrameRemoveControlledBlocks = class(TFrame)
    StaticText1: TStaticText;
    edNames: TLabeledEdit;
    chkNotMatching: TCheckBox;
    chkExactMatch: TCheckBox;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

  TProcRemoveControlledBlocks = class(TProcBase)
  private
    Frame: TFrameRemoveControlledBlocks;
    fNames: array of string;
    fExactMatch: Boolean;
    fNotMatching: Boolean;
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

constructor TProcRemoveControlledBlocks.Create(aManager: TProcManager);
begin
  inherited;

  fTitle := 'Remove controlled blocks';
  fSupportedGames := [gtTES4, gtFO3, gtFNV];
  fExtensions := ['kf'];
end;

function TProcRemoveControlledBlocks.GetFrame(aOwner: TComponent): TFrame;
begin
  Frame := TFrameRemoveControlledBlocks.Create(aOwner);
  Result := Frame;
end;

procedure TProcRemoveControlledBlocks.OnShow;
begin
  Frame.edNames.Text := StorageGetString('sNames', Frame.edNames.Text);
  Frame.chkExactMatch.Checked := StorageGetBool('bExactMatch', Frame.chkExactMatch.Checked);
  Frame.chkNotMatching.Checked := StorageGetBool('bNotMatching', Frame.chkNotMatching.Checked);
end;

procedure TProcRemoveControlledBlocks.OnHide;
begin
  StorageSetString('sNames', Frame.edNames.Text);
  StorageSetBool('bExactMatch', Frame.chkExactMatch.Checked);
  StorageSetBool('bNotMatching', Frame.chkNotMatching.Checked);
end;

procedure TProcRemoveControlledBlocks.OnStart;
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

  if Length(fNames) = 0 then
    raise Exception.Create('Names field can not be empty');

  fExactMatch := Frame.chkExactMatch.Checked;
  fNotMatching := Frame.chkNotMatching.Checked;
end;

function TProcRemoveControlledBlocks.ProcessFile(const aInputDirectory, aOutputDirectory: string; var aFileName: string): TBytes;
var
  nif: TwbNifFile;
  entries, entry: TdfElement;
  Interpolator, Controller: TwbNifBlock;
  i: Integer;
  name: string;
  bMatched, bChanged: Boolean;

  {function Exists(var blocks: TwbNifBlocks; block: TwbNifBlock): Boolean;
  begin
    Result := False;
    for var b: TwbNifBlock in blocks do
      if b = block then begin
        Result := True;
        Break;
      end;
  end;

  // list of blocks which reference aBlock
  function ReferencedBy(aBlock: TwbNifBlock): TwbNifBlocks;
  var
    i, j: Integer;
    b: TwbNifBLock;
  begin
    for i := 0 to Pred(nif.BlocksCount) do begin
      b := nif.Blocks[i];
      // skip checking for self referencing
      if b = aBlock then
        Continue;

      for j := 0 to Pred(b.RefsCount) do
        if (TwbNifBlock(b.Refs[j].LinksTo) = aBlock) and not Exists(Result, b) then
          Result := Result + [b];
    end;
  end;}

begin
  bChanged := False;
  nif := TwbNifFile.Create;
  try
    nif.LoadFromFile(aInputDirectory + aFileName);

    if nif.BlocksCount = 0 then
      Exit;

    entries := nif.Blocks[0].Elements['Controlled Blocks'];

    if not Assigned(entries)then
      Exit;

    for i := Pred(entries.Count) downto 0 do begin
      entry := entries[i];

      bMatched := False;
      name := entry.EditValues['Node Name'];
      for var s: String in fNames do
        if ( fExactMatch and SameText(name, s) ) or ( not fExactMatch and ContainsText(name, s) ) then
          bMatched := True;

      bMatched := bMatched xor fNotMatching;

      if bMatched then begin

        Interpolator := TwbNifBlock(entry.Elements['Interpolator'].LinksTo);
        Controller := TwbNifBlock(entry.Elements['Controller'].LinksTo);

        // removing controlled block
        entry.Remove;

        // removing linked blocks branches
        if Assigned(Interpolator) then Interpolator.RemoveBranch;
        if Assigned(Controller) then Controller.RemoveBranch;

        bChanged := True;
      end;

    end;

    if bChanged then
      nif.Blocks[0].NativeValues['Num Controlled Blocks'] := entries.Count;

    if bChanged then
      nif.SaveToData(Result);

  finally
    nif.Free;
  end;

end;



end.

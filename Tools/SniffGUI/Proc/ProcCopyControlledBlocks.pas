{******************************************************************************

  This Source Code Form is subject to the terms of the Mozilla Public License,
  v. 2.0. If a copy of the MPL was not distributed with this file, You can obtain
  one at https://mozilla.org/MPL/2.0/.

*******************************************************************************}

unit ProcCopyControlledBlocks;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes,
  Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, SniffProcessor,
  Vcl.StdCtrls, Vcl.ExtCtrls;

type
  TFrameCopyControlledBlocks = class(TFrame)
    StaticText1: TStaticText;
    edSourceDirectory: TLabeledEdit;
    btnBrowse: TButton;
    procedure btnBrowseClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

  TProcCopyControlledBlocks = class(TProcBase)
  private
    Frame: TFrameCopyControlledBlocks;
    fSourceDirectory: string;
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

procedure TFrameCopyControlledBlocks.btnBrowseClick(Sender: TObject);
var
  path: string;
begin
  path := edSourceDirectory.Text;

  if path = '' then
    path := ExtractFilePath(Application.ExeName);

  if SelectFolder(path) then
    edSourceDirectory.Text := Path;
end;

constructor TProcCopyControlledBlocks.Create(aManager: TProcManager);
begin
  inherited;

  fTitle := 'Copy anim controlled blocks';
  fSupportedGames := [gtTES4, gtFO3, gtFNV];
  fExtensions := ['kf'];
end;

function TProcCopyControlledBlocks.GetFrame(aOwner: TComponent): TFrame;
begin
  Frame := TFrameCopyControlledBlocks.Create(aOwner);
  Result := Frame;
end;

procedure TProcCopyControlledBlocks.OnShow;
begin
  Frame.edSourceDirectory.Text := StorageGetString('sSourceDirectory', Frame.edSourceDirectory.Text);
end;

procedure TProcCopyControlledBlocks.OnHide;
begin
  StorageSetString('sSourceDirectory', Frame.edSourceDirectory.Text);
end;

procedure TProcCopyControlledBlocks.OnStart;
begin
  fSourceDirectory := Frame.edSourceDirectory.Text;

  if (fSourceDirectory = '') or not DirectoryExists(fSourceDirectory) then
    raise Exception.Create('Source directory not found');

  fSourceDirectory := IncludeTrailingPathDelimiter(fSourceDirectory);
end;

function TProcCopyControlledBlocks.ProcessFile(const aInputDirectory, aOutputDirectory: string; var aFileName: string): TBytes;
var
  Nif, SrcNif: TwbNifFile;
  SrcBlocks, DstBlocks: TdfElement;
  CopiedBlocks, DstList: TStringList;
  entry, newentry: TdfElement;
  Interpolator, NewInterpolator: TwbNifBlock;
  i: Integer;
  bChanged: Boolean;

  function ControlledBlockToken(entry: TdfElement): string;
  begin
    // unique token string for controlled block
    Result := entry.EditValues['Node Name'] + ' ' + entry.EditValues['Controller Type'];
  end;

  function CopyInterpolator(Block: TwbNifBlock; Nif: TwbNifFile): TwbNifBlock;
  var
    RefBlock, NewRefBlock: TwbNifBLock;
    i, idx: Integer;
  begin
    // copy Interpolator itself first
    // don't need to check for already copied ones because controlled blocks can't use the same interpolators
    // they are always new
    Result := Nif.AddBlock(Block.BlockType);
    Result.Assign(Block);

    // copying referenced blocks (interpolator data) if any
    for i := 0 to Pred(Block.Count) do begin
      RefBlock := TwbNifBlock(Block[i].LinksTo);
      if not Assigned(RefBlock) then
        Continue;

      // check if we already copied that block because interpolator data can be reused by interpolators
      idx := CopiedBlocks.IndexOf(IntToStr(RefBlock.Index));
      if idx = -1 then begin
        // if not, then copy
        NewRefBlock := Nif.AddBlock(RefBlock.BlockType);
        NewRefBlock.Assign(RefBlock);
        CopiedBlocks.AddObject(IntToStr(RefBlock.Index), NewRefBlock);
      end
      else begin
        // else get the already copied block
        NewRefBlock := TwbNifBlock(CopiedBlocks.Objects[idx]);
      end;

      // linking to the copied block
      Result[i].NativeValue := NewRefBlock.Index;
    end;
  end;

begin
  if not FileExists(fSourceDirectory + aFileName) then
    Exit;

  bChanged := False;

  CopiedBlocks := TStringList.Create;
  DstList := TStringList.Create;
  Nif := TwbNifFile.Create;
  SrcNif := TwbNifFile.Create;
  try
    Nif.LoadFromFile(aInputDirectory + aFileName);
    SrcNif.LoadFromFile(fSourceDirectory + aFileName);

    if (SrcNif.BlocksCount = 0) or (Nif.BlocksCount = 0) then
      Exit;

    SrcBlocks := SrcNif.Blocks[0].Elements['Controlled Blocks'];
    DstBlocks := Nif.Blocks[0].Elements['Controlled Blocks'];

    if not Assigned(SrcBlocks) or not Assigned(DstBlocks) then
      Exit;

    // building a list of controlled blocks in destination nif
    for i := 0 to Pred(DstBlocks.Count) do
      DstList.Add(ControlledBlockToken(DstBlocks[i]));

    DstList.Sorted := True;

    // copying controlled blocks from the source nif
    for i := 0 to Pred(SrcBlocks.Count) do begin
      entry := SrcBlocks[i];
      // skip if block with the same token exists in the destination nif
      if DstList.IndexOf(ControlledBlockToken(entry)) <> -1 then
        Continue;

      // copy controlled block
      newentry := DstBlocks.Add;
      newentry.Assign(entry);
      DstBlocks.NativeValues['..\Num Controlled Blocks'] := DstBlocks.NativeValues['..\Num Controlled Blocks'] + 1;

      // copy interpolator if any
      Interpolator := TwbNifBlock(entry.Elements['Interpolator'].LinksTo);
      if Assigned(Interpolator) then begin
        NewInterpolator := CopyInterpolator(Interpolator, Nif);
        newentry.NativeValues['Interpolator'] := NewInterpolator.Index;
      end;

      bChanged := True;
    end;

    if bChanged then
      Nif.SaveToData(Result);

  finally
    CopiedBlocks.Free;
    DstList.Free;
    Nif.Free;
    SrcNif.Free;
  end;

end;


end.

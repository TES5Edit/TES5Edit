{******************************************************************************

  This Source Code Form is subject to the terms of the Mozilla Public License,
  v. 2.0. If a copy of the MPL was not distributed with this file, You can obtain
  one at https://mozilla.org/MPL/2.0/.

*******************************************************************************}

unit ProcCopyGeometryBlocks;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes,
  Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, SniffProcessor,
  Vcl.StdCtrls, Vcl.ExtCtrls;

type
  TFrameCopyGeometryBlocks = class(TFrame)
    StaticText1: TStaticText;
    edSourceDirectory: TLabeledEdit;
    btnBrowse: TButton;
    procedure btnBrowseClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

  TProcCopyGeometryBlocks = class(TProcBase)
  private
    Frame: TFrameCopyGeometryBlocks;
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

procedure TFrameCopyGeometryBlocks.btnBrowseClick(Sender: TObject);
var
  path: string;
begin
  path := edSourceDirectory.Text;

  if path = '' then
    path := ExtractFilePath(Application.ExeName);

  if SelectFolder(path) then
    edSourceDirectory.Text := Path;
end;

constructor TProcCopyGeometryBlocks.Create(aManager: TProcManager);
begin
  inherited;

  fTitle := 'Copy geometry blocks';
  fSupportedGames := [gtTES3, gtTES4, gtFO3, gtFNV, gtTES5, gtSSE, gtFO4];
  fExtensions := ['nif'];
end;

function TProcCopyGeometryBlocks.GetFrame(aOwner: TComponent): TFrame;
begin
  Frame := TFrameCopyGeometryBlocks.Create(aOwner);
  Result := Frame;
end;

procedure TProcCopyGeometryBlocks.OnShow;
begin
  Frame.edSourceDirectory.Text := StorageGetString('sSourceDirectory', Frame.edSourceDirectory.Text);
end;

procedure TProcCopyGeometryBlocks.OnHide;
begin
  StorageSetString('sSourceDirectory', Frame.edSourceDirectory.Text);
end;

procedure TProcCopyGeometryBlocks.OnStart;
begin
  fSourceDirectory := Frame.edSourceDirectory.Text;

  if (fSourceDirectory = '') or not DirectoryExists(fSourceDirectory) then
    raise Exception.Create('Source directory not found');

  fSourceDirectory := IncludeTrailingPathDelimiter(fSourceDirectory);
end;

function TProcCopyGeometryBlocks.ProcessFile(const aInputDirectory, aOutputDirectory: string; var aFileName: string): TBytes;
var
  Nif, SrcNif: TwbNifFile;
  i, j: Integer;
  Block, SrcBlock: TwbNifBlock;
  bChanged: Boolean;
  links, extras: array of Integer;
begin
  if not FileExists(fSourceDirectory + aFileName) then
    Exit;

  Nif := TwbNifFile.Create;
  SrcNif := TwbNifFile.Create;
  bChanged := False;

  try
    Nif.LoadFromFile(aInputDirectory + aFileName);
    SrcNif.LoadFromFile(fSourceDirectory + aFileName);

    for i := 0 to Pred(Nif.BlocksCount) do begin
      Block := Nif.Blocks[i];

      if Block.IsNiObject('NiTriBasedGeom') then begin
        // find the same block to copy from
        SrcBlock := SrcNif.BlockByName(Block.EditValues['Name']);
        if not Assigned(SrcBlock) then
          Continue;

        if Block.BlockType <> SrcBlock.BlockType then
          Continue;

        // get the Data
        Block := TwbNifBlock(Block.Elements['Data'].LinksTo);
        SrcBlock := TwbNifBlock(SrcBlock.Elements['Data'].LinksTo);

        if not Assigned(Block) or not Assigned(SrcBlock) then
          Continue;

        SetLength(links, 1);
        links[0] := Block.NativeValues['Additional Data'];
        Block.Assign(SrcBlock);
        Block.NativeValues['Additional Data'] := links[0];

        bChanged := True;
      end

      else if Block.IsNiObject('BSTriShape') then begin
        SrcBlock := SrcNif.BlockByName(Block.EditValues['Name']);
        if not Assigned(SrcBlock) then
          Continue;

        if Block.BlockType <> SrcBlock.BlockType then
          Continue;

        SetLength(links, 5);
        links[0] := Block.NativeValues['Controller'];
        links[1] := Block.NativeValues['Collision Object'];
        links[2] := Block.NativeValues['Skin'];
        links[3] := Block.NativeValues['Shader Property'];
        links[4] := Block.NativeValues['Alpha Property'];
        SetLength(extras, Block.Elements['Extra Data List'].Count);
        for j := Low(extras) to High(extras) do
          extras[j] := Block.Elements['Extra Data List'][j].NativeValue;

        Block.Assign(SrcBlock);

        Block.NativeValues['Controller'] := links[0];
        Block.NativeValues['Collision Object'] := links[1];
        Block.NativeValues['Skin'] := links[2];
        Block.NativeValues['Shader Property'] := links[3];
        Block.NativeValues['Alpha Property'] := links[4];
        Block.Elements['Extra Data List'].Count := Length(extras);
        for j := Low(extras) to High(extras) do
          Block.Elements['Extra Data List'][j].NativeValue := extras[j];

        bChanged := True;
      end;

    end;

    if bChanged then
      Nif.SaveToData(Result);

  finally
    Nif.Free;
    SrcNif.Free;
  end;

end;


end.

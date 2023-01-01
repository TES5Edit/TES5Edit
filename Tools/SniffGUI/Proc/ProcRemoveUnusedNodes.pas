{******************************************************************************

  This Source Code Form is subject to the terms of the Mozilla Public License,
  v. 2.0. If a copy of the MPL was not distributed with this file, You can obtain
  one at https://mozilla.org/MPL/2.0/.

*******************************************************************************}

unit ProcRemoveUnusedNodes;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes,
  Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, SniffProcessor,
  Vcl.StdCtrls;

type
  TFrameRemoveUnusedNodes = class(TFrame)
    StaticText1: TStaticText;
    chkSingleRoot: TCheckBox;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

  TProcRemoveUnusedNodes = class(TProcBase)
  private
    Frame: TFrameRemoveUnusedNodes;
    fSingleRoot: Boolean;
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

constructor TProcRemoveUnusedNodes.Create(aManager: TProcManager);
begin
  inherited;

  fTitle := 'Remove unused nodes';
  fSupportedGames := [gtTES3, gtTES4, gtFO3, gtFNV, gtTES5, gtSSE, gtFO4];
  fExtensions := ['nif', 'kf', 'kfm'];
end;

function TProcRemoveUnusedNodes.GetFrame(aOwner: TComponent): TFrame;
begin
  Frame := TFrameRemoveUnusedNodes.Create(aOwner);
  Result := Frame;
end;

procedure TProcRemoveUnusedNodes.OnShow;
begin
  Frame.chkSingleRoot.Checked := StorageGetBool('bSingleRoot', Frame.chkSingleRoot.Checked);
end;

procedure TProcRemoveUnusedNodes.OnHide;
begin
  StorageSetBool('bSingleRoot', Frame.chkSingleRoot.Checked);
end;

procedure TProcRemoveUnusedNodes.OnStart;
begin
  fSingleRoot := Frame.chkSingleRoot.Checked;
end;

function TProcRemoveUnusedNodes.ProcessFile(const aInputDirectory, aOutputDirectory: string; var aFileName: string): TBytes;

  procedure CountBlocksUsage(aBlock: TwbNifBlock; var aUsage: array of Integer);
  begin
    if not Assigned(aBlock) then
      Exit;

    //if aBlock.Index = 10 then
    //  fManager.AddMessage('10 is HERE!');

    Inc(aUsage[aBlock.Index]);

    // scan our refs only once
    if aUsage[aBlock.Index] = 1 then
      for var i: Integer := 0 to Pred(aBlock.RefsCount) do begin
        CountBlocksUsage(TwbNifBlock(aBlock.Refs[i].LinksTo), aUsage);
        //if aBlock.Refs[i].LinksTo <> nil then
        //  fManager.AddMessage(IntToStr(TwbNifBlock(aBlock.Refs[i].LinksTo).Index) + ' used by ' + IntToStr(aBlock.Index));
      end;
  end;

var
  nif: TwbNifFile;
  roots: TdfElement;
  BlocksUsage: array of Integer;
  bModified: Boolean;
begin
  nif := TwbNifFile.Create;
  try
    nif.LoadFromFile(aInputDirectory + aFileName);

    if nif.BlocksCount = 0 then
      Exit;

    if fSingleRoot then begin
      roots := nif.Footer.Elements['Roots'];
      if Assigned(roots) and (roots.Count > 1) then
        roots.Count := 1;
    end;

    SetLength(BlocksUsage, nif.BlocksCount);

    // root nodes are linked from the NiFooter
    for var i: Integer := 0 to Pred(nif.Footer.RefsCount) do
      CountBlocksUsage(TwbNifBlock(nif.Footer.Refs[i].LinksTo), BlocksUsage);

    bModified := False;
    for var i: Integer := High(BlocksUsage) downto Low(BlocksUsage) do
      if BlocksUsage[i] = 0 then begin
        nif.Delete(i);
        bModified := True;
      end;

    if bModified then
      nif.SaveToData(Result);

  finally
    nif.Free;
  end;

end;



end.

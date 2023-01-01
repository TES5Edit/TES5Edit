{******************************************************************************

  This Source Code Form is subject to the terms of the Mozilla Public License,
  v. 2.0. If a copy of the MPL was not distributed with this file, You can obtain
  one at https://mozilla.org/MPL/2.0/.

*******************************************************************************}

unit ProcAttachParent;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes,
  Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ExtCtrls,
  SniffProcessor;

type
  TFrameAttachParent = class(TFrame)
    StaticText1: TStaticText;
    edFindNodeName: TLabeledEdit;
    edAttachNodeName: TLabeledEdit;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

  TProcAttachParent = class(TProcBase)
  private
    Frame: TFrameAttachParent;
    fFindNodeName: string;
    fAttachNodeName: string;
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

constructor TProcAttachParent.Create(aManager: TProcManager);
begin
  inherited;

  fTitle := 'Attach parent NiNode';
  fSupportedGames := [gtTES3, gtTES4, gtFO3, gtFNV, gtTES5, gtSSE, gtFO4];
  fExtensions := ['nif'];
end;

function TProcAttachParent.GetFrame(aOwner: TComponent): TFrame;
begin
  Frame := TFrameAttachParent.Create(aOwner);
  Result := Frame;
end;

procedure TProcAttachParent.OnShow;
begin
  Frame.edFindNodeName.Text := StorageGetString('sFindNodeName', Frame.edFindNodeName.Text);
  Frame.edAttachNodeName.Text := StorageGetString('sAttachNodeName', Frame.edAttachNodeName.Text);
end;

procedure TProcAttachParent.OnHide;
begin
  StorageSetString('sFindNodeName', Frame.edFindNodeName.Text);
  StorageSetString('sAttachNodeName', Frame.edAttachNodeName.Text);
end;

procedure TProcAttachParent.OnStart;
begin
  fFindNodeName := Frame.edFindNodeName.Text;
  fAttachNodeName := Frame.edAttachNodeName.Text;

  if fFindNodeName = '' then
    raise Exception.Create('Name to find can not be empty');
end;

function TProcAttachParent.ProcessFile(const aInputDirectory, aOutputDirectory: string; var aFileName: string): TBytes;
var
  nif: TwbNifFile;
  children: TdfElement;
  i: Integer;
  node, child, parent: TwbNifBlock;
  nodes: TwbNifBlocks;
  bChanged: Boolean;
begin
  bChanged := False;
  nif := TwbNifFile.Create;
  try
    nif.LoadFromFile(aInputDirectory + aFileName);

    if nif.BlocksCount = 0 then
      Exit;

    // parent node already exists
    if Assigned(nif.BlockByName(fAttachNodeName)) then
      Exit;

    // node to find doesn't exist
    if not Assigned(nif.BlockByName(fFindNodeName)) then
      Exit;

    // search children of all NiNodes
    nodes := nif.BlocksByType('NiNode', True);
    for node in nodes do begin
      children := node.Elements['Children'];
      if not Assigned(children) then
        Continue;

      for i := 0 to Pred(children.Count) do begin
        child := TwbNifBlock(children[i].LinksTo);
        if not Assigned(child) then
          Continue;

        if child.EditValues['Name'] <> fFindNodeName then
          Continue;

        parent := nif.InsertBlock(child.Index, 'NiNode');
        parent.EditValues['Name'] := fAttachNodeName;
        parent.Elements['Children'].Add.NativeValue := child.Index;
        children[i].NativeValue := parent.Index;

        bChanged := True;
        Break;
      end;

      if bChanged then
        Break;
    end;

    if bChanged then
      nif.SaveToData(Result);

  finally
    nif.Free;
  end;

end;


end.

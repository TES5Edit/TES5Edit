{******************************************************************************

  This Source Code Form is subject to the terms of the Mozilla Public License,
  v. 2.0. If a copy of the MPL was not distributed with this file, You can obtain
  one at https://mozilla.org/MPL/2.0/.

*******************************************************************************}

unit ProcGroupShapes;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes,
  Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, SniffProcessor,
  Vcl.StdCtrls;

type
  TFrameGroupShapes = class(TFrame)
    StaticText1: TStaticText;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

  TProcGroupShapes = class(TProcBase)
  private
    Frame: TFrameGroupShapes;
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

constructor TProcGroupShapes.Create(aManager: TProcManager);
begin
  inherited;

  fTitle := 'Group shapes';
  fSupportedGames := [gtTES3, gtTES4, gtFO3, gtFNV, gtTES5, gtSSE, gtFO4];
  fExtensions := ['nif'];
end;

function TProcGroupShapes.GetFrame(aOwner: TComponent): TFrame;
begin
  Frame := TFrameGroupShapes.Create(aOwner);
  Result := Frame;
end;

function TProcGroupShapes.ProcessFile(const aInputDirectory, aOutputDirectory: string; var aFileName: string): TBytes;

  function GetUsedTexture(aShape: TwbNifBlock): string;
  var
    el, props: TdfElement;
    shader, prop, texset: TwbNifBlock;
    i: Integer;
  begin
    el := aShape.Elements['Shader Property'];
    if Assigned(el) then begin
      shader := TwbNifBlock(el.LinksTo);
      if not Assigned(shader) then
        Exit;

      texset := TwbNifBlock(shader.Elements['Texture Set'].LinksTo);
      if not Assigned(texset) then
        Exit;

      el := texset.Elements['Textures\[0]'];
      if Assigned(el) then
        Result := el.EditValue;
    end

    else begin
      props := aShape.Elements['Properties'];
      for i := 0 to Pred(props.Count) do begin
        prop := TwbNifBlock(props[i].LinksTo);

        if prop.BlockType = 'NiTexturingProperty' then begin
          el := prop.Elements['Base Texture\Source'];
          if not Assigned(el) then
            Exit;

          prop := TwbNifBlock(el.LinksTo);
          if not Assigned(prop) then
            Continue;

          Result := prop.EditValues['File Name'];
          Exit;
        end

        else if prop.BlockType = 'BSShaderPPLightingProperty' then begin
          el := prop.Elements['Texture Set'];
          if not Assigned(el) then
            Continue;

          texset := TwbNifBlock(el.LinksTo);
          if not Assigned(texset) then
            Continue;

          el := texset.Elements['Textures\[0]'];
          if Assigned(el) then
            Result := el.EditValue;

          Exit;
        end;

      end;
    end;

  end;

var
  nif: TwbNifFile;
  children: TdfElement;
  i, j, idx: Integer;
  node, child: TwbNifBlock;
  token: string;
  tokens: array of record
    token: string;
    shapes: array of TwbNifBlock;
  end;
  bChanged: Boolean;
begin
  bChanged := False;
  nif := TwbNifFile.Create;
  try
    nif.LoadFromFile(aInputDirectory + aFileName);

    if nif.BlocksCount = 0 then
      Exit;

    children := nif.Blocks[0].Elements['Children'];
    if not Assigned(children) then
      Exit;

    // iterate over children of root node
    for i := 0 to Pred(children.Count) do begin
      child := TwbNifBlock(children[i].LinksTo);
      if not Assigned(child) then
        Continue;

      if not (child.IsNiObject('NiTriBasedGeom') or child.IsNiObject('BSTriShape')) then
        Continue;

      token := GetUsedTexture(child);
      if token = '' then
        Continue;

      token := wbNormalizeResourceName(token, resTexture);

      // check if we already have such token
      idx := -1;
      for j := Low(tokens) to High(tokens) do
        if tokens[j].token = token then begin
          idx := j;
          Break;
        end;

      // adding new token
      if idx = -1 then begin
        idx := Length(tokens);
        SetLength(tokens, idx + 1);
        tokens[idx].token := token;
      end;

      // adding shape under token
      with tokens[idx] do begin
        SetLength(shapes, Length(shapes) + 1);
        shapes[Pred(Length(shapes))] := child;
      end;
    end;

    // iterate over collected tokens
    for i := Low(tokens) to High(tokens) do with tokens[i] do begin
      if Length(shapes) < 2 then
        Continue;

      // create NiNode at the index of the first shape
      node := nif.InsertBlock(shapes[0].Index, 'NiNode');
      node.EditValues['Name'] := ChangeFileExt(ExtractFileName(token), '');

      // add shapes as it's children
      for j := Low(shapes) to High(shapes) do begin
        node.Elements['Children'].Add.NativeValue := shapes[j].Index;

        // find link to the current shape in root's children
        for idx := 0 to Pred(children.Count) do
          if TwbNifBlock(children[idx].LinksTo) = shapes[j] then begin
            // if it is the first shape, then relink to the created NiNode
            if j = Low(shapes) then
              children[idx].NativeValue := node.Index
            // otherwise delete the link
            else
              children.Delete(idx);

            Break;
          end;

      end;

      bChanged := True;
    end;

    if bChanged then
      nif.SaveToData(Result);

  finally
    nif.Free;
  end;

end;


end.

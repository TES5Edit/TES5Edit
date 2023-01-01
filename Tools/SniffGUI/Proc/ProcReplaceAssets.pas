{******************************************************************************

  This Source Code Form is subject to the terms of the Mozilla Public License,
  v. 2.0. If a copy of the MPL was not distributed with this file, You can obtain
  one at https://mozilla.org/MPL/2.0/.

*******************************************************************************}

unit ProcReplaceAssets;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes,
  Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, SniffProcessor,
  Vcl.StdCtrls;

type
  TFrameReplaceAssets = class(TFrame)
    StaticText1: TStaticText;
    memoPairs: TMemo;
    Label1: TLabel;
    chkFixAbsolute: TCheckBox;
    chkReport: TCheckBox;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

  TProcReplaceAssets = class(TProcBase)
  private
    Frame: TFrameReplaceAssets;
    fFixAbsolute: Boolean;
    fReportOnly: Boolean;
    fSearch, fReplace: array of string;
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
  wbDataFormatNif,
  wbDataFormatMaterial;

constructor TProcReplaceAssets.Create(aManager: TProcManager);
begin
  inherited;

  fTitle := 'Search and replace assets';
  fSupportedGames := [gtTES3, gtTES4, gtFO3, gtFNV, gtTES5, gtSSE, gtFO4];
  fExtensions := ['nif', 'bgsm', 'bgem'];
end;

function TProcReplaceAssets.GetFrame(aOwner: TComponent): TFrame;
begin
  Frame := TFrameReplaceAssets.Create(aOwner);
  Result := Frame;
end;

procedure TProcReplaceAssets.OnShow;
begin
  Frame.chkFixAbsolute.Checked := StorageGetBool('bFixAbsolute', Frame.chkFixAbsolute.Checked);
  Frame.chkReport.Checked := StorageGetBool('bReportOnly', Frame.chkReport.Checked);
  Frame.memoPairs.Lines.CommaText := StorageGetString('sReplacements', Frame.memoPairs.Lines.CommaText);
end;

procedure TProcReplaceAssets.OnHide;
begin
  StorageSetBool('bFixAbsolute', Frame.chkFixAbsolute.Checked);
  StorageSetBool('bReportOnly', Frame.chkReport.Checked);
  StorageSetString('sReplacements', Frame.memoPairs.Lines.CommaText);
end;

procedure TProcReplaceAssets.OnStart;
var
  s, r: string;
begin
  fFixAbsolute := Frame.chkFixAbsolute.Checked;
  fReportOnly := Frame.chkREport.Checked;
  fNoOutput := fReportOnly;

  SetLength(fSearch, 0);
  SetLength(fReplace, 0);

  with Frame do
  for var i: integer := 0 to memoPairs.Lines.Count div 2 do begin
    s := memoPairs.Lines[i * 2];
    r := memoPairs.Lines[i * 2 + 1];
    // skip if both odd and even lines are empty
    if (s <> '') or (r <> '') then begin
      fSearch := fSearch + [s];
      fReplace := fReplace + [r];
    end;
  end;

end;

function TProcReplaceAssets.ProcessFile(const aInputDirectory, aOutputDirectory: string; var aFileName: string): TBytes;
var
  i, j, k, p: integer;
  Elements: TList;
  el: TdfElement;
  Log: TStringList;
  Nif: TwbNifFile;
  Block: TwbNifBlock;
  BGSM: TwbBGSMFile;
  BGEM: TwbBGEMFile;
  ext, s, s2: string;
  bChanged: Boolean;
begin
  Elements := TList.Create;
  Log := TStringList.Create;
  bChanged := False;
  Nif := nil; BGSM := nil; BGEM := nil; // suppress compiler warning

  ext := ExtractFileExt(aFileName);

  // collecting elements with assets
  try

    // *.NIF file
    if SameText(ext, '.nif') then begin
      Nif := TwbNifFile.Create;
      Nif.LoadFromFile(aInputDirectory + aFileName);

      // iterate over all blocks in a nif file and locate elements holding textures
      for i := 0 to Pred(Nif.BlocksCount) do begin
        Block := Nif.Blocks[i];

        if Block.BlockType = 'BSShaderTextureSet' then begin
          el := Block.Elements['Textures'];
          for j := 0 to Pred(el.Count) do
            Elements.Add(el[j]);
        end

        // BGSM/BGEM file in the Name field of FO4 meshes
        else if (Nif.NifVersion = nfFO4) and (Block.BlockType = 'BSLightingShaderProperty') then
          Elements.Add(Block.Elements['Name'])

        else if Block.BlockType = 'BSEffectShaderProperty' then begin
          Elements.Add(Block.Elements['Source Texture']);
          Elements.Add(Block.Elements['Grayscale Texture']);
          Elements.Add(Block.Elements['Env Map Texture']);
          Elements.Add(Block.Elements['Normal Texture']);
          Elements.Add(Block.Elements['Env Mask Texture']);
          // BGSM/BGEM file in the Name field of FO4 meshes
          if Nif.NifVersion = nfFO4 then
            Elements.Add(Block.Elements['Name']);
        end

        else if (Block.BlockType = 'BSShaderNoLightingProperty') or
                (Block.BlockType = 'TallGrassShaderProperty') or
                (Block.BlockType = 'TileShaderProperty') or
                Block.IsNiObject('NiTexture', True)
        then
          Elements.Add(Block.Elements['File Name'])

        else if Block.BlockType = 'BSSkyShaderProperty' then
          Elements.Add(Block.Elements['Source Texture'])

        else if Block.BlockType = 'BSBehaviorGraphExtraData' then
          Elements.Add(Block.Elements['Behavior Graph File'])

        else if Block.BlockType = 'BSSubIndexTriShape' then
          Elements.Add(Block.Elements['Segment Data\SSF File']);

      end;
    end

    // *.BGSM file
    else if SameText(ext, '.bgsm') then begin
      BGSM := TwbBGSMFile.Create;
      BGSM.LoadFromFile(aInputDirectory + aFileName);
      el := BGSM.Elements['Textures'];
      for j := 0 to Pred(el.Count) do
        Elements.Add(el[j]);
    end

    // *.BGEM file
    else if SameText(ext, '.bgem') then begin
      BGEM := TwbBGEMFile.Create;
      BGEM.LoadFromFile(aInputDirectory + aFileName);
      el := BGEM.Elements['Textures'];
      for j := 0 to Pred(el.Count) do
        Elements.Add(el[j]);
    end;

    // skip to the next file if nothing was found
    if Elements.Count = 0 then
      Exit;

    // do text replacement in collected elements
    el := nil; // suppress compiler warning
    for j := 0 to Pred(Elements.Count) do begin
      if not Assigned(Elements[j]) then
        Continue
      else
        el := TdfElement(Elements[j]);

      // getting file name stored in element
      s := el.EditValue;
      // skip to the next element if empty
      if s = '' then Continue;

      // perform replacements, trim whitespaces just in case
      s2 := Trim(s);
      for k := Low(fSearch) to High(fSearch) do begin
        if fSearch[k] <> '' then
          // replace if text to find is not empty
          s2 := StringReplace(s2, fSearch[k], fReplace[k], [rfIgnoreCase, rfReplaceAll])
        else
          // prepend if empty
          s2 := fReplace[k] + s2;
      end;

      if fFixAbsolute then
        // detect an absolute path
        if (Length(s2) > 2) and (s2[2] = ':') then begin
          // remove path up to Data including it
          p := Pos('\data\', LowerCase(s2));
          if p <> 0 then
            s2 := Copy(s2, p + 6, Length(s2));
          // remove path up to Data Files including it for Morrowind
          if p = 0 then begin
            p := Pos('\data files\', LowerCase(s2));
            if p <> 0 then
              s2 := Copy(s, p + 12, Length(s2));
          end;
        end;

      // if element's value has changed
      if s <> s2 then begin
        // store it
        el.EditValue := s2;

        // report
        if not bChanged then
          Log.Add(#13#10 + aFileName);

        Log.Add(#9 + el.Path + #13#10#9#9'"' + s + '"'#13#10#9#9'"' + el.EditValue + '"');

        // mark file to be saved
        bChanged := True;
      end;

    end;

    // save the file if changed and not in report only mode
    if bChanged and not fReportOnly then
      el.Root.SaveToData(Result);

    fManager.AddMessages(Log);

  finally
    Elements.Free;
    Log.Free;
    if Assigned(Nif) then Nif.Free;
    if Assigned(BGSM) then BGSM.Free;
    if Assigned(BGEM) then BGEM.Free;
  end;

end;

end.

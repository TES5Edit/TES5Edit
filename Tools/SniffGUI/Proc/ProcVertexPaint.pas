{******************************************************************************

  This Source Code Form is subject to the terms of the Mozilla Public License,
  v. 2.0. If a copy of the MPL was not distributed with this file, You can obtain
  one at https://mozilla.org/MPL/2.0/.

*******************************************************************************}

unit ProcVertexPaint;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes,
  Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, SniffProcessor,
  Vcl.StdCtrls, Vcl.ExtCtrls;

type
  TFrameVertexPaint = class(TFrame)
    StaticText1: TStaticText;
    rbSetColors: TRadioButton;
    rbRemoveColors: TRadioButton;
    chkAllWhite: TCheckBox;
    Label1: TLabel;
    edColor: TEdit;
    btnColorSelect: TButton;
    chkAddIfMissing: TCheckBox;
    rbAdjustColors: TRadioButton;
    cbAdjustMod: TComboBox;
    edAdjustH: TLabeledEdit;
    edAdjustS: TLabeledEdit;
    edAdjustL: TLabeledEdit;
    edAdjustA: TLabeledEdit;
    rbReplaceColor: TRadioButton;
    lblColor2: TLabel;
    edColor2: TEdit;
    btnColor2Select: TButton;
    lblHelper: TLabel;
    procedure btnColorSelectClick(Sender: TObject);
    procedure rbSetColorsClick(Sender: TObject);
    procedure lblHelperClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

  TProcVertexPaint = class(TProcBase)
  private
    Frame: TFrameVertexPaint;
    fMode: Integer;
    fColor: Cardinal;
    fColor2: Cardinal;
    fAllWhite: Boolean;
    fAddIfMissing: Boolean;
    fAdjustMod: Integer;
    fAdjustH: double;
    fAdjustS: double;
    fAdjustL: double;
    fAdjustA: double;
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
  Math,
  wbDataFormat,
  wbDataFormatNif,
  frmVertexPaintHelper;

constructor TProcVertexPaint.Create(aManager: TProcManager);
begin
  inherited;

  fTitle := 'Vertex color painting';
  fSupportedGames := [gtTES3, gtTES4, gtFO3, gtFNV, gtTES5{, gtSSE, gtFO4}];
  fExtensions := ['nif'];
end;

function TProcVertexPaint.GetFrame(aOwner: TComponent): TFrame;
begin
  Frame := TFrameVertexPaint.Create(aOwner);
  Result := Frame;
end;

procedure TFrameVertexPaint.btnColorSelectClick(Sender: TObject);
var
  ed: TEdit;
  c, r, g, b, a: Cardinal;
begin
  if Sender = btnColorSelect then
    ed := edColor
  else
    ed := edColor2;

  with TColorDialog.Create(Self) do try
    Options := [cdFullOpen, cdAnyColor];
    c := StrToIntDef('$' + ed.Text, 0);
    r := (c shr 24) and $FF;
    g := (c shr 16) and $FF;
    b := (c shr 8) and $FF;
    a := c and $FF;
    Color := r + (g shl 8) + (b shl 16);
    if Execute then begin
      c := Color;
      r := c and $FF;
      g := (c shr 8) and $FF;
      b := (c shr 16) and $FF;
      ed.Text := UpperCase(IntToHex((r shl 24) + (g shl 16) + (b shl 8) + a, 8));
    end;
  finally
    Free;
  end;
end;

procedure TFrameVertexPaint.lblHelperClick(Sender: TObject);
begin
  with TFormVertexPaintHelper.Create(Self) do try
    ShowModal;
  finally
    Free;
  end;
end;

procedure TFrameVertexPaint.rbSetColorsClick(Sender: TObject);
begin
  lblColor2.Visible := rbReplaceColor.Checked;
  edColor2.Visible := rbReplaceColor.Checked;
  btnColor2Select.Visible := rbReplaceColor.Checked;
end;

procedure TProcVertexPaint.OnShow;
begin
  fMode := StorageGetInteger('iMode', 0);
  Frame.rbSetColors.Checked := fMode = 0;
  Frame.rbAdjustColors.Checked := fMode = 1;
  Frame.rbRemoveColors.Checked := fMode = 2;
  Frame.rbReplaceColor.Checked := fMode = 3;
  Frame.rbSetColorsClick(nil);
  Frame.edColor.Text := StorageGetString('sColor', Frame.edColor.Text);
  Frame.edColor2.Text := StorageGetString('sColor2', Frame.edColor2.Text);
  Frame.chkAddIfMissing.Checked := StorageGetBool('bAddIfMissing', Frame.chkAddIfMissing.Checked);
  Frame.chkAllWhite.Checked := StorageGetBool('bAllWhite', Frame.chkAllWhite.Checked);
  try
    Frame.cbAdjustMod.ItemIndex := StorageGetInteger('iAdjustMod', Frame.cbAdjustMod.ItemIndex);
  except
    Frame.cbAdjustMod.ItemIndex := 0;
  end;
  Frame.edAdjustH.Text := StorageGetString('sAdjustH', Frame.edAdjustH.Text);
  Frame.edAdjustS.Text := StorageGetString('sAdjustS', Frame.edAdjustS.Text);
  Frame.edAdjustL.Text := StorageGetString('sAdjustL', Frame.edAdjustL.Text);
  Frame.edAdjustA.Text := StorageGetString('sAdjustA', Frame.edAdjustA.Text);
end;

procedure TProcVertexPaint.OnHide;
begin
  if Frame.rbSetColors.Checked then fMode := 0 else
  if Frame.rbAdjustColors.Checked then fMode := 1 else
  if Frame.rbRemoveColors.Checked then fMode := 2 else
    fMode := 3;
  StorageSetInteger('iMode', fMode);
  StorageSetString('sColor', Frame.edColor.Text);
  StorageSetString('sColor2', Frame.edColor2.Text);
  StorageSetBool('bAllWhite', Frame.chkAllWhite.Checked);
  StorageSetBool('bAddIfMissing', Frame.chkAddIfMissing.Checked);
  StorageSetInteger('iAdjustMod', Frame.cbAdjustMod.ItemIndex);
  StorageSetString('sAdjustH', Frame.edAdjustH.Text);
  StorageSetString('sAdjustS', Frame.edAdjustS.Text);
  StorageSetString('sAdjustL', Frame.edAdjustL.Text);
  StorageSetString('sAdjustA', Frame.edAdjustA.Text);
end;

procedure TProcVertexPaint.OnStart;
begin
  if Frame.rbSetColors.Checked then fMode := 0 else
  if Frame.rbAdjustColors.Checked then fMode := 1 else
  if Frame.rbRemoveColors.Checked then fMode := 2 else
    fMode := 3;
  fAllWhite := Frame.chkAllWhite.Checked;
  fAddIfMissing := Frame.chkAddIfMissing.Checked;
  fAdjustMod := Frame.cbAdjustMod.ItemIndex;

  if fMode in [0, 2, 3] then try
    fColor := StrToInt('$' + Frame.edColor.Text);
  except
    raise Exception.Create('Color is not a valid hex number');
  end;

  if fMode = 3 then try
    fColor2 := StrToInt('$' + Frame.edColor2.Text);
  except
    raise Exception.Create('Replacement color is not a valid hex number');
  end;

  if fMode = 1 then begin
    try
      fAdjustH := StrToFloat(Frame.edAdjustH.Text);
    except
      raise Exception.Create('Adjust H is not a float value');
    end;

    try
      fAdjustS := StrToFloat(Frame.edAdjustS.Text);
    except
      raise Exception.Create('Adjust S is not a float value');
    end;

    try
      fAdjustL := StrToFloat(Frame.edAdjustL.Text);
    except
      raise Exception.Create('Adjust L is not a float value');
    end;

    try
      fAdjustA := StrToFloat(Frame.edAdjustA.Text);
    except
      raise Exception.Create('Adjust A is not a float value');
    end;
  end;
end;

function TProcVertexPaint.ProcessFile(const aInputDirectory, aOutputDirectory: string; var aFileName: string): TBytes;

  procedure rgb2hsl(red, green, blue: Byte; var h, s, l: Double);
  var
    r, g, b, cmax, cmin, d, dd: double;
  begin
    cmin := Min(red, Min(green, blue)) / 255;
    cmax := Max(red, Max(green, blue)) / 255;
    r := red / 255;
    g := green / 255;
    b := blue / 255;
    h := (cmax + cmin) / 2;
    s := (cmax + cmin) / 2;
    l := (cmax + cmin) / 2;
    if cmax = cmin then begin
      h := 0;
      s := 0;
    end
    else begin
      d := cmax - cmin;
      if l > 0.5 then s := d / (2 - cmax - cmin) else s := d / (cmax + cmin);
      if g < b then dd := 6 else dd := 0;
      if cmax = r then
        h := (g - b) / d + dd
      else if cmax = g then
        h := (b - r) / d + 2
      else if cmax = b then
        h := (r - g) / d + 4;
      h := h / 6;
    end;
  end;

  function hue2rgb(p, q, t: Double): Double;
  begin
    if t < 0 then t := t + 1;
    if t > 1 then t := t - 1;
    if t < 1 / 6 then
      Result := p + (q - p) * 6 * t
    else if t < 1 / 2 then
      Result := q
    else if t < 2 / 3 then
      Result := p + (q - p) * (2/3 - t) * 6
    else
      Result := p;
  end;

  procedure hsl2rgb(h, s, l: Double; var red, green, blue: Byte);
  var
    r, g, b, p, q: double;
  begin
    if s = 0 then begin
      r := l;
      g := l;
      b := l;
    end
    else begin
      if l < 0.5 then q := l * (1 + s) else q := l + s - l * s;
      p := 2 * l - q;
      r := hue2rgb(p, q, h + 1/3);
      g := hue2rgb(p, q, h);
      b := hue2rgb(p, q, h - 1/3);
    end;
    red := Round(r * 255);
    green := Round(g * 255);
    blue := Round(b * 255);
  end;

  function FloatColorToByte(aValue: Single): Byte;
  var
    c: Integer;
  begin
    c := Round(aValue * 255);
    if c > 255 then c := 255 else
      if c < 0 then c := 0;
    Result := c;
  end;

var
  nif: TwbNifFile;
  block: TwbNifBlock;
  entries, entry: TdfElement;
  bChanged, bWhite: Boolean;
  i, j: Integer;
  r, g, b: Byte;
  h, s, l, a: Double;
  c, c2: string;
begin
  c := '#' + IntToHex(fColor, 8);
  c2 := '#' + IntToHex(fColor2, 8);

  bChanged := False;
  nif := TwbNifFile.Create;
  try
    nif.LoadFromFile(aInputDirectory + aFileName);

    for i := 0 to Pred(nif.BlocksCount) do begin
      block := nif.Blocks[i];

      if block.IsNiobject('NiTriBasedGeomData') then begin

        // set vertex colors
        if fMode = 0 then begin
          if fAddIfMissing and (block.NativeValues['Has Vertex Colors'] = 0) then begin
            block.NativeValues['Has Vertex Colors'] := 1;

            bChanged := True;
          end;

          entries := block.Elements['Vertex Colors'];
          if not Assigned(entries) then
            Continue;

          if (entries.Count = 0) and Assigned(block.Elements['Vertices']) then
            entries.Count := block.Elements['Vertices'].Count;

          for j := 0 to Pred(entries.Count) do
            if entries[j].EditValue <> c then begin
              entries[j].EditValue := c;
              bChanged := True;
            end;
        end

        // adjust vertex colors
        else if fMode = 1 then begin
          entries := block.Elements['Vertex Colors'];
          if not Assigned(entries) then
            Continue;

          for j := 0 to Pred(entries.Count) do begin
            entry := entries[j];
            r := FloatColorToByte(entry.NativeValues['R']);
            g := FloatColorToByte(entry.NativeValues['G']);
            b := FloatColorToByte(entry.NativeValues['B']);
            a := entry.NativeValues['A'];

            rgb2hsl(r, g, b, h, s, l);

            if fAdjustMod = 0 then begin
              h := h * fAdjustH;
              s := s * fAdjustS;
              l := l * fAdjustL;
              a := a * fAdjustA;
            end
            else begin
              h := h + fAdjustH;
              s := s + fAdjustS;
              l := l + fAdjustL;
              a := a + fAdjustA;
            end;
            if h < 0 then h := 0 else if h > 1 then h := 1;
            if s < 0 then s := 0 else if s > 1 then s := 1;
            if l < 0 then l := 0 else if l > 1 then l := 1;
            if a < 0 then a := 0 else if a > 1 then a := 1;

            hsl2rgb(h, s, l, r, g, b);

            entry.NativeValues['R'] := r / 255;
            entry.NativeValues['G'] := g / 255;
            entry.NativeValues['B'] := b / 255;
            entry.NativeValues['A'] := a;

            bChanged := True;
          end;

        end

        // remove vertex colors
        else if fMode = 2 then begin
          entries := block.Elements['Vertex Colors'];
          if not Assigned(entries) then
            Continue;

          bWhite := True;
          // check existing colors if we want to remove the white ones only
          if fAllWhite then begin
            for j := 0 to Pred(entries.Count) do
              if entries[j].EditValue <> c then begin
                bWhite := False;
                Break;
              end;
          end;

          if bWhite then begin
            block.NativeValues['Has Vertex Colors'] := 0;
            bChanged := True;
          end;

        end

        // replace vertex color
        else if fMode = 3 then begin
          entries := block.Elements['Vertex Colors'];
          if not Assigned(entries) then
            Continue;

          for j := 0 to Pred(entries.Count) do
            if entries[j].EditValue = c then begin
              entries[j].EditValue := c2;
              bChanged := True;
            end;

        end;

      end
      {
      else if block.IsNiObject('BSTriShape') then begin
         // to do ...
      end;
      }
    end;


    if bChanged then
      nif.SaveToData(Result);

  finally
    nif.Free;
  end;

end;


end.

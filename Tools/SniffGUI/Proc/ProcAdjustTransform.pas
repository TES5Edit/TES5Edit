{******************************************************************************

  This Source Code Form is subject to the terms of the Mozilla Public License,
  v. 2.0. If a copy of the MPL was not distributed with this file, You can obtain
  one at https://mozilla.org/MPL/2.0/.

*******************************************************************************}

unit ProcAdjustTransform;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes,
  Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, SniffProcessor,
  Vcl.StdCtrls, Vcl.ExtCtrls;

type
  TFrameAdjustTransform = class(TFrame)
    StaticText1: TStaticText;
    edNames: TLabeledEdit;
    chkExactMatch: TCheckBox;
    edPosX: TLabeledEdit;
    Label1: TLabel;
    edPosY: TLabeledEdit;
    edPosZ: TLabeledEdit;
    edRotY: TLabeledEdit;
    Label2: TLabel;
    edRotP: TLabeledEdit;
    edRotR: TLabeledEdit;
    edScale: TLabeledEdit;
    rbAdd: TRadioButton;
    rbMult: TRadioButton;
    rbSet: TRadioButton;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

  TProcAdjustTransform = class(TProcBase)
  private
    Frame: TFrameAdjustTransform;
    fNames: array of string;
    fExactMatch: Boolean;
    fMode: Integer;
    fPosX, fPosY, fPosZ: string;
    fRotY, fRotP, fRotR: string;
    fScale: string;
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

constructor TProcAdjustTransform.Create(aManager: TProcManager);
begin
  inherited;

  fTitle := 'Adjust transformation';
  fSupportedGames := [gtTES3, gtTES4, gtFO3, gtFNV, gtTES5, gtSSE, gtFO4];
  fExtensions := ['nif', 'kf'];
end;

function TProcAdjustTransform.GetFrame(aOwner: TComponent): TFrame;
begin
  Frame := TFrameAdjustTransform.Create(aOwner);
  Result := Frame;
end;

procedure TProcAdjustTransform.OnShow;
var
  m: Integer;
begin
  Frame.edNames.Text := StorageGetString('sNames', Frame.edNames.Text);
  Frame.chkExactMatch.Checked := StorageGetBool('bExactMatch', Frame.chkExactMatch.Checked);
  m := StorageGetInteger('iMode', 1);
  if m = 2 then Frame.rbMult.Checked := True
    else if m = 3 then Frame.rbSet.Checked := True
      else Frame.rbAdd.Checked := True;
  Frame.edPosX.Text := StorageGetString('sPosX', Frame.edPosX.Text);
  Frame.edPosY.Text := StorageGetString('sPosY', Frame.edPosY.Text);
  Frame.edPosZ.Text := StorageGetString('sPosZ', Frame.edPosZ.Text);
  Frame.edRotY.Text := StorageGetString('sRotY', Frame.edRotY.Text);
  Frame.edRotP.Text := StorageGetString('sRotP', Frame.edRotP.Text);
  Frame.edRotR.Text := StorageGetString('sRotR', Frame.edRotR.Text);
  Frame.edScale.Text := StorageGetString('sScale', Frame.edScale.Text);
end;

procedure TProcAdjustTransform.OnHide;
var
  m: Integer;
begin
  StorageSetString('sNames', Frame.edNames.Text);
  StorageSetBool('bExactMatch', Frame.chkExactMatch.Checked);
  if Frame.rbMult.Checked then m := 2
    else if Frame.rbSet.Checked then m := 3
      else m := 1;
  StorageSetInteger('iMode', m);
  StorageSetString('sPosX', Frame.edPosX.Text);
  StorageSetString('sPosY', Frame.edPosY.Text);
  StorageSetString('sPosZ', Frame.edPosZ.Text);
  StorageSetString('sRotY', Frame.edRotY.Text);
  StorageSetString('sRotP', Frame.edRotP.Text);
  StorageSetString('sRotR', Frame.edRotR.Text);
  StorageSetString('sScale', Frame.edScale.Text);
end;

procedure TProcAdjustTransform.OnStart;

  function GetVerifyFloat(const s: string): string;
  begin
    Result := Trim(s);
    if Result <> '' then
      dfStrToFloat(Result);
  end;

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

  fExactMatch := Frame.chkExactMatch.Checked;
  if Frame.rbMult.Checked then fMode := 2
    else if Frame.rbSet.Checked then fMode := 3
      else fMode := 1;
  fPosX := GetVerifyFloat(Frame.edPosX.Text);
  fPosY := GetVerifyFloat(Frame.edPosY.Text);
  fPosZ := GetVerifyFloat(Frame.edPosZ.Text);
  fRotY := GetVerifyFloat(Frame.edRotY.Text);
  fRotP := GetVerifyFloat(Frame.edRotP.Text);
  fRotR := GetVerifyFloat(Frame.edRotR.Text);
  fScale := GetVerifyFloat(Frame.edScale.Text);

  if (fPosX = '') and (fPosY = '') and (fPosZ = '') and
     (fRotY = '') and (fRotP = '') and (fRotR = '') and
     (fScale = '') then
    raise Exception.Create('No adjustment values set');
end;

function TProcAdjustTransform.ProcessFile(const aInputDirectory, aOutputDirectory: string; var aFileName: string): TBytes;


  function AdjustFloat(val: Extended; m: Integer; const v: string): Extended;
  begin
    Result := val;
    if v = '' then
      Exit;

    if m = 1 then Result := Result + dfStrToFloat(v)
      else if m = 2 then Result := Result * dfStrToFloat(v)
        else Result := dfStrToFloat(v);
  end;

  function AdjustValue(el: TdfElement; const path: string; m: Integer; const v: string): Boolean;
  var
    s: string;
  begin
    Result := False;

    if v = '' then
      Exit;

    s := el.EditValues[path];
    if s = '' then
      Exit;

    el.NativeValues[path] := AdjustFloat(el.NativeValues[path], m, v);
    Result := s <> el.EditValues[path];
  end;

  function Transform(t: TdfElement): Boolean;
  var
    s: string;
    y, p, r: Extended;
  begin
    Result := False;
    if not Assigned(t) then
      Exit;

    Result := AdjustValue(t, 'Translation\X', fMode, fPosX) or Result;
    Result := AdjustValue(t, 'Translation\Y', fMode, fPosY) or Result;
    Result := AdjustValue(t, 'Translation\Z', fMode, fPosZ) or Result;
    Result := AdjustValue(t, 'Scale', fMode, fScale) or Result;

    if (fRotY <> '') or (fRotP <> '') or (fRotR <> '') then begin
      s := t.EditValues['Rotation'];
      with TStringList.Create do try
        Delimiter := ' ';
        StrictDelimiter := True;
        DelimitedText := s;
        y := AdjustFloat(dfStrToFloat(Strings[0]), fMode, fRotY);
        p := AdjustFloat(dfStrToFloat(Strings[1]), fMode, fRotP);
        r := AdjustFloat(dfStrToFloat(Strings[2]), fMode, fRotR);
        Strings[0] := dfFloatToStr(y);
        Strings[1] := dfFloatToStr(p);
        Strings[2] := dfFloatToStr(r);
        t.EditValues['Rotation'] := DelimitedText;
      finally
        Free;
      end;
      Result := (s <> t.EditValues['Rotation']) or Result;
    end;
  end;

var
  nif: TwbNifFile;
  block: TdfElement;
  name: string;
  bChanged: Boolean;
begin
  bChanged := False;
  nif := TwbNifFile.Create;
  try
    nif.LoadFromFile(aInputDirectory + aFileName);

    for var i: Integer := 0 to Pred(nif.BlocksCount) do begin
      block := nif.Blocks[i];

      // root block if no names
      if Length(fNames) = 0 then begin
        bChanged := Transform(block.Elements['Transform']);
        Break;
      end;

      name := block.EditValues['Name'];
      for var s: String in fNames do
        if ( fExactMatch and SameText(name, s) ) or ( not fExactMatch and ContainsText(name, s) ) then begin
          bChanged := Transform(block.Elements['Transform']) or bChanged;
          Break;
        end;
    end;

    if bChanged then
      nif.SaveToData(Result);

  finally
    nif.Free;
  end;

end;

end.

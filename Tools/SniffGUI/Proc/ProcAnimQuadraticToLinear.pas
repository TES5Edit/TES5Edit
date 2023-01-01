{******************************************************************************

  This Source Code Form is subject to the terms of the Mozilla Public License,
  v. 2.0. If a copy of the MPL was not distributed with this file, You can obtain
  one at https://mozilla.org/MPL/2.0/.

*******************************************************************************}

unit ProcAnimQuadraticToLinear;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes,
  Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, SniffProcessor,
  Vcl.StdCtrls, Vcl.ExtCtrls;

type
  TFrameAnimQuadraticToLinear = class(TFrame)
    StaticText1: TStaticText;
    edNames: TLabeledEdit;
    chkNotMatching: TCheckBox;
    chkExactMatch: TCheckBox;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

  TProcAnimQuadraticToLinear = class(TProcBase)
  private
    Frame: TFrameAnimQuadraticToLinear;
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

constructor TProcAnimQuadraticToLinear.Create(aManager: TProcManager);
begin
  inherited;

  fTitle := 'Quadratic to linear anim';
  fSupportedGames := [gtTES4, gtFO3, gtFNV];
  fExtensions := ['kf'];
end;

function TProcAnimQuadraticToLinear.GetFrame(aOwner: TComponent): TFrame;
begin
  Frame := TFrameAnimQuadraticToLinear.Create(aOwner);
  Result := Frame;
end;

procedure TProcAnimQuadraticToLinear.OnShow;
begin
  Frame.edNames.Text := StorageGetString('sNames', Frame.edNames.Text);
  Frame.chkExactMatch.Checked := StorageGetBool('bExactMatch', Frame.chkExactMatch.Checked);
  Frame.chkNotMatching.Checked := StorageGetBool('bNotMatching', Frame.chkNotMatching.Checked);
end;

procedure TProcAnimQuadraticToLinear.OnHide;
begin
  StorageSetString('sNames', Frame.edNames.Text);
  StorageSetBool('bExactMatch', Frame.chkExactMatch.Checked);
  StorageSetBool('bNotMatching', Frame.chkNotMatching.Checked);
end;

procedure TProcAnimQuadraticToLinear.OnStart;
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

function TProcAnimQuadraticToLinear.ProcessFile(const aInputDirectory, aOutputDirectory: string; var aFileName: string): TBytes;
var
  nif: TwbNifFile;
  Interpolator: TwbNifBlock;
  entries, entry, datalink, transformdata, interpolation, rots: TdfElement;
  name: string;
  bMatched, bChanged: Boolean;
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

    for var i: Integer := Pred(entries.Count) downto 0 do begin
      entry := entries[i];

      bMatched := False;
      name := entry.EditValues['Node Name'];
      for var s: String in fNames do
        if ( fExactMatch and SameText(name, s) ) or ( not fExactMatch and ContainsText(name, s) ) then
          bMatched := True;

      bMatched := bMatched xor fNotMatching;

      if not bMatched then
        Continue;

      Interpolator := TwbNifBlock(entry.Elements['Interpolator'].LinksTo);
      if not Assigned(Interpolator) then
        Continue;

      datalink := Interpolator.Elements['Data'];
      if not Assigned(datalink) then
        Continue;

      transformdata := TwbNifBlock(datalink.LinksTo);
      if not Assigned(transformdata) then
        Continue;

      interpolation := transformdata.Elements['Translations\Interpolation'];
      if Assigned(interpolation) and (interpolation.EditValue = 'QUADRATIC_KEY') then begin
        interpolation.EditValue := 'LINEAR_KEY';
        bChanged := True;
      end;

      rots := transformdata.Elements['XYZ Rotations'];
      if Assigned(rots) then
        for var j: Integer := 0 to Pred(rots.Count) do begin
          interpolation := rots[j].Elements['Interpolation'];
          if Assigned(interpolation) and (interpolation.EditValue = 'QUADRATIC_KEY') then begin
            interpolation.EditValue := 'LINEAR_KEY';
            bChanged := True;
          end;
        end;

    end;

    if bChanged then
      nif.SaveToData(Result);

  finally
    nif.Free;
  end;

end;



end.

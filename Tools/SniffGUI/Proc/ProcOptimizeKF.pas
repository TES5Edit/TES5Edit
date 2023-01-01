{******************************************************************************

  This Source Code Form is subject to the terms of the Mozilla Public License,
  v. 2.0. If a copy of the MPL was not distributed with this file, You can obtain
  one at https://mozilla.org/MPL/2.0/.

*******************************************************************************}

unit ProcOptimizeKF;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes,
  Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, SniffProcessor,
  Vcl.StdCtrls;

type
  TFrameOptimizeKF = class(TFrame)
    StaticText1: TStaticText;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

  TProcOptimizeKF = class(TProcBase)
  private
    Frame: TFrameOptimizeKF;
  public
    constructor Create(aManager: TProcManager); override;
    function GetFrame(aOwner: TComponent): TFrame; override;

    function ProcessFile(const aInputDirectory, aOutputDirectory: string; var aFileName: string): TBytes; override;
  end;


implementation

{$R *.dfm}

uses
  StrUtils,
  wbDataFormat,
  wbDataFormatNif;

constructor TProcOptimizeKF.Create(aManager: TProcManager);
begin
  inherited;

  fTitle := 'Optimize KF animations';
  fSupportedGames := [gtTES4, gtFO3, gtFNV];
  fExtensions := ['kf'];
end;

function TProcOptimizeKF.GetFrame(aOwner: TComponent): TFrame;
begin
  Frame := TFrameOptimizeKF.Create(aOwner);
  Result := Frame;
end;

function TProcOptimizeKF.ProcessFile(const aInputDirectory, aOutputDirectory: string; var aFileName: string): TBytes;

  function KeyValue(aKey: TdfElement): string;
  begin
    Result := aKey.EditValues['Value'];

    if Assigned(aKey.Elements['Forward']) then
      Result := ' ' + aKey.EditValues['Forward'] + ' ' + aKey.EditValues['Backward'];

    if Assigned(aKey.Elements['TBC']) then
      Result := ' ' + aKey.EditValues['TBC\T'] + ' ' + aKey.EditValues['TBC\B'] + ' ' + aKey.EditValues['TBC\C'];

    Result := StringReplace(Result, dfFloatToStr(-0.0), dfFloatToStr(0.0), [rfReplaceAll]);
  end;

  function Optimize(aKeys: TdfElement; const aKeysCount: string = ''): Boolean;
  var
    current, prev, next: string;
    j: Integer;
  begin
    Result := False;

    if not Assigned(aKeys) then
      Exit;

    if aKeys.Count < 3 then
      Exit;

    next := KeyValue(aKeys[aKeys.Count - 1]);
    current := KeyValue(aKeys[aKeys.Count - 2]);

    for j := aKeys.Count - 2 downto 1 do begin
      prev := KeyValue(aKeys[j - 1]);

      if (current = prev) and (current = next) then begin
        aKeys.Delete(j);
        Result := True;
      end;

      next := current;
      current := prev;
    end;

    if Result and (aKeysCount <> '') then
      aKeys.NativeValues[aKeysCount] := aKeys.Count;
  end;

var
  nif: TwbNifFile;
  block: TwbNifBlock;
  datalink, entries: TdfElement;
  bChanged: Boolean;
begin
  bChanged := False;
  nif := TwbNifFile.Create;
  try
    nif.LoadFromFile(aInputDirectory + aFileName);

    for var i: Integer := 0 to Pred(nif.BlocksCount) do begin
      block := nif.Blocks[i];
      //fManager.AddMessage('Processing block ' + block.Name);

      if not block.IsNiObject('NiKeyBasedInterpolator', True) then
        Continue;

      datalink := block.Elements['Data'];
      if not Assigned(datalink) then
        Continue;

      block := TwbNifBlock(datalink.LinksTo);

      if not Assigned(block) then
        Continue;

      entries := block.Elements['Quaternion Keys'];
      if Assigned(entries) and Optimize(entries, '..\Num Rotation Keys') then
        bChanged := True;

      entries := block.Elements['Translations\Keys'];
      if Assigned(entries) and Optimize(entries, '..\Num Keys') then
        bChanged := True;

      entries := block.Elements['Scales\Keys'];
      if Assigned(entries) and Optimize(entries, '..\Num Keys') then
        bChanged := True;

      entries := block.Elements['XYZ Rotations'];
      if Assigned(entries) then
        for var j: Integer := 0 to Pred(entries.Count) do
          if Optimize(entries[j].Elements['Keys'], '..\Num Keys') then
            bChanged := True;
    end;

    if bChanged then
      nif.SaveToData(Result);

  finally
    nif.Free;
  end;

end;



end.

{******************************************************************************

  This Source Code Form is subject to the terms of the Mozilla Public License,
  v. 2.0. If a copy of the MPL was not distributed with this file, You can obtain
  one at https://mozilla.org/MPL/2.0/.

*******************************************************************************}

unit ProcFixExportedKFAnim;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes,
  Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, SniffProcessor,
  Vcl.StdCtrls;

type
  TFrameFixExportedKFAnim = class(TFrame)
    StaticText1: TStaticText;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

  TProcFixExportedKFAnim = class(TProcBase)
  private
    Frame: TFrameFixExportedKFAnim;
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

constructor TProcFixExportedKFAnim.Create(aManager: TProcManager);
begin
  inherited;

  fTitle := 'Fix 3DS exported KF';
  fSupportedGames := [gtTES4, gtFO3, gtFNV];
  fExtensions := ['kf'];
end;

function TProcFixExportedKFAnim.GetFrame(aOwner: TComponent): TFrame;
begin
  Frame := TFrameFixExportedKFAnim.Create(aOwner);
  Result := Frame;
end;

function TProcFixExportedKFAnim.ProcessFile(const aInputDirectory, aOutputDirectory: string; var aFileName: string): TBytes;
var
  nif: TwbNifFile;
  entries, entry: TdfElement;
  ExtraData: TwbNifBlock;
  i: Integer;
  keyvalue: string;
  bChanged: Boolean;
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

    for i := 0 to Pred(entries.Count) do begin
      entry := entries[i];

      if entry.EditValues['Controller Type'] = '' then begin
        entry.EditValues['Controller Type'] := 'NiTransformController';
        bChanged := True;
      end;

    end;

    ExtraData := nif.BlockByType('NiTextKeyExtraData');

    if Assigned(ExtraData) then begin
      entries := ExtraData.Elements['Text Keys'];
      if Assigned(entries) then
        for i := 0 to Pred(entries.Count) do begin
          entry := entries[i];
          keyvalue := entry.EditValues['Value'];
          if (Length(keyvalue) > 5) and keyvalue.StartsWith('start') then begin
            entry.EditValues['Value'] := 'start';
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

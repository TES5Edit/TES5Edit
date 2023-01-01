{******************************************************************************

  This Source Code Form is subject to the terms of the Mozilla Public License,
  v. 2.0. If a copy of the MPL was not distributed with this file, You can obtain
  one at https://mozilla.org/MPL/2.0/.

*******************************************************************************}

unit ProcFindSeveralStrips;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes,
  Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, SniffProcessor,
  Vcl.StdCtrls, Vcl.ExtCtrls;

type
  TFrameFindSeveralStrips = class(TFrame)
    StaticText1: TStaticText;
    edStripsNum: TLabeledEdit;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

  TProcFindSeveralStrips = class(TProcBase)
  private
    Frame: TFrameFindSeveralStrips;
    fStripsNum: Integer;
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

constructor TProcFindSeveralStrips.Create(aManager: TProcManager);
begin
  inherited;

  fTitle := 'Find several strips';
  fSupportedGames := [gtTES3, gtTES4, gtFO3, gtFNV, gtTES5];
  fExtensions := ['nif'];
  fNoOutput := True;
end;

function TProcFindSeveralStrips.GetFrame(aOwner: TComponent): TFrame;
begin
  Frame := TFrameFindSeveralStrips.Create(aOwner);
  Result := Frame;
end;

procedure TProcFindSeveralStrips.OnShow;
begin
  Frame.edStripsNum.Text := StorageGetString('sStripsNum', Frame.edStripsNum.Text);
end;

procedure TProcFindSeveralStrips.OnHide;
begin
  StorageSetString('sStripsNum', Frame.edStripsNum.Text);
end;

procedure TProcFindSeveralStrips.OnStart;
begin
  try
    fStripsNum := StrToInt(Frame.edStripsNum.Text);
  except
    raise Exception.Create('Strips Num is not an integer value');
  end;
end;

function TProcFindSeveralStrips.ProcessFile(const aInputDirectory, aOutputDirectory: string; var aFileName: string): TBytes;
var
  nif: TwbNifFile;
  Log: TStringList;
  i, j: Integer;
  block: TwbNifBlock;
begin
  Log := TStringList.Create;
  nif := TwbNifFile.Create;
  try
    nif.LoadFromFile(aInputDirectory + aFileName);

    for i := 0 to Pred(nif.BlocksCount) do begin
      block := nif.Blocks[i];

      if block.BlockType <> 'NiTriStripsData' then
        Continue;

      j := block.NativeValues['Num Strips'];
      if j > fStripsNum then
        Log.Add(#9 + IntToStr(j) + ' strips in ' + Block.Name);

    end;

    if Log.Count > 0 then begin
      fManager.AddMessage(aFileName);
      Log.Add('');
      fManager.AddMessages(Log);
    end;

  finally
    nif.Free;
    Log.Free;
  end;

end;



end.

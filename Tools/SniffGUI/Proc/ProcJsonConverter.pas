{******************************************************************************

  This Source Code Form is subject to the terms of the Mozilla Public License,
  v. 2.0. If a copy of the MPL was not distributed with this file, You can obtain
  one at https://mozilla.org/MPL/2.0/.

*******************************************************************************}

unit ProcJsonConverter;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes,
  Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, SniffProcessor,
  Vcl.StdCtrls, Vcl.ExtCtrls;

type
  TFrameJsonConverter = class(TFrame)
    StaticText1: TStaticText;
    rbToJson: TRadioButton;
    rbFromJson: TRadioButton;
    edExtension: TLabeledEdit;
    procedure rbToJsonClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

  TProcJsonConverter = class(TProcBase)
  private
    Frame: TFrameJsonConverter;
    fToJson: Boolean;
    fExtension: string;
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

procedure TFrameJsonConverter.rbToJsonClick(Sender: TObject);
begin
  edExtension.Enabled := rbFromJson.Checked;
end;

constructor TProcJsonConverter.Create(aManager: TProcManager);
begin
  inherited;

  fTitle := 'Convert to and from JSON';
  fSupportedGames := [gtTES3, gtTES4, gtFO3, gtFNV, gtTES5, gtSSE, gtFO4];
  fExtensions := ['nif', 'kf', 'json'];
end;

function TProcJsonConverter.GetFrame(aOwner: TComponent): TFrame;
begin
  Frame := TFrameJsonConverter.Create(aOwner);
  Result := Frame;
end;

procedure TProcJsonConverter.OnShow;
begin
  Frame.rbToJson.Checked := StorageGetBool('bToJson', Frame.rbToJson.Checked);
  Frame.rbFromJson.Checked := not Frame.rbToJson.Checked;
  Frame.edExtension.Text := StorageGetString('sExtension', Frame.edExtension.Text);
  Frame.rbToJsonClick(nil);
end;

procedure TProcJsonConverter.OnHide;
begin
  StorageSetBool('bToJson', Frame.rbToJson.Checked);
  StorageSetString('sExtension', Frame.edExtension.Text);
end;

procedure TProcJsonConverter.OnStart;
begin
  fToJson := Frame.rbToJson.Checked;
  fExtension := Frame.edExtension.Text;

  if not fToJson and (fExtension = '') then
    raise Exception.Create('Default extension can not be empty');
end;

function TProcJsonConverter.ProcessFile(const aInputDirectory, aOutputDirectory: string; var aFileName: string): TBytes;
var
  nif: TwbNifFile;
begin
  nif := TwbNifFile.Create;
  try

    if fToJson then begin
      if SameText(ExtractFileExt(aFileName), '.json') then
        Exit;

      nif.LoadFromFile(aInputDirectory + aFileName);

      var ss: TStringStream;
      ss := TStringStream.Create;
      try
        ss.WriteString(nif.ToJSON(False));
        SetLength(Result, ss.Size);
        ss.Position := 0;
        ss.Read(Result[0], Length(Result));
      finally
        ss.Free;
      end;

      aFileName := aFileName + '.json';
    end

    else begin
      if not SameText(ExtractFileExt(aFileName), '.json') then
        Exit;

      nif.LoadFromJSONFile(aInputDirectory + aFileName);
      nif.SaveToData(Result);

      aFileName := ChangeFileExt(aFileName, '');
      if ExtractFileExt(aFileName) = '' then
        aFileName := aFileName + '.' + fExtension;
    end;

  finally
    nif.Free;
  end;

end;

end.

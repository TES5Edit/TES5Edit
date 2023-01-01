{******************************************************************************

  This Source Code Form is subject to the terms of the Mozilla Public License,
  v. 2.0. If a copy of the MPL was not distributed with this file, You can obtain
  one at https://mozilla.org/MPL/2.0/.

*******************************************************************************}

unit ProcShaderFlagsUpdate;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes,
  Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, SniffProcessor,
  Vcl.StdCtrls, Vcl.CheckLst;

type
  TFrameShaderFlagsUpdate = class(TFrame)
    StaticText1: TStaticText;
    clbFlags1: TCheckListBox;
    cmbGame: TComboBox;
    clbFlags2: TCheckListBox;
    rbAdd: TRadioButton;
    rbSet: TRadioButton;
    rbRemove: TRadioButton;
    procedure cmbGameSelect(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    Proc: TProcBase;
    function CheckListBoxToInt32(const aBox: TCheckListBox): Cardinal;
    procedure Int32ToCheckListBox(const aBox: TCheckListBox; aInt: Cardinal);
  end;

  TProcShaderFlagsUpdate = class(TProcBase)
  private
    Frame: TFrameShaderFlagsUpdate;
    fMode: Integer;
    fFlags: Cardinal;
    fFlags2: Cardinal;
  public
    slFO3Flags: TStringList;
    slFO3Flags2: TStringList;
    slTES5Flags: TStringList;
    slTES5Flags2: TStringList;
    slFO4Flags: TStringList;
    slFO4Flags2: TStringList;

    constructor Create(aManager: TProcManager); override;
    destructor Destroy; override;
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
  wbDataFormatNifTypes;

constructor TProcShaderFlagsUpdate.Create(aManager: TProcManager);
var
  i: Integer;
begin
  inherited;

  fTitle := 'Update shader flags';
  fSupportedGames := [gtFO3, gtFNV, gtTES5, gtSSE, gtFO4];
  fExtensions := ['nif'];

  slFO3Flags := TStringList.Create;
  with TdfFlagsDef(wbBSShaderFlags('', '', [])) do try
    for i := 0 to Pred(ValuesMapCount) do
      slFO3Flags.Add(Values[i]);
  finally
    Free;
  end;

  slFO3Flags2 := TStringList.Create;
  with TdfFlagsDef(wbBSShaderFlags2('', '', [])) do try
    for i := 0 to Pred(ValuesMapCount) do
      slFO3Flags2.Add(Values[i]);
  finally
    Free;
  end;

  slTES5Flags := TStringList.Create;
  with TdfFlagsDef(wbSkyrimShaderPropertyFlags1('', '', [])) do try
    for i := 0 to Pred(ValuesMapCount) do
      slTES5Flags.Add(Values[i]);
  finally
    Free;
  end;

  slTES5Flags2 := TStringList.Create;
  with TdfFlagsDef(wbSkyrimShaderPropertyFlags2('', '', [])) do try
    for i := 0 to Pred(ValuesMapCount) do
      slTES5Flags2.Add(Values[i]);
  finally
    Free;
  end;

  slFO4Flags := TStringList.Create;
  with TdfFlagsDef(wbFallout4ShaderPropertyFlags1('', '', [])) do try
    for i := 0 to Pred(ValuesMapCount) do
      slFO4Flags.Add(Values[i]);
  finally
    Free;
  end;

  slFO4Flags2 := TStringList.Create;
  with TdfFlagsDef(wbFallout4ShaderPropertyFlags2('', '', [])) do try
    for i := 0 to Pred(ValuesMapCount) do
      slFO4Flags2.Add(Values[i]);
  finally
    Free;
  end;
end;

destructor TProcShaderFlagsUpdate.Destroy;
begin
  slFO3Flags.Free;
  slFO3Flags2.Free;
  slTES5Flags.Free;
  slTES5Flags2.Free;
  slFO4Flags.Free;
  slFO4Flags2.Free;
end;

function TProcShaderFlagsUpdate.GetFrame(aOwner: TComponent): TFrame;
begin
  Frame := TFrameShaderFlagsUpdate.Create(aOwner);
  Frame.Proc := Self;
  Result := Frame;
end;

procedure TProcShaderFlagsUpdate.OnShow;
begin
  try Frame.cmbGame.ItemIndex := StorageGetInteger('iGame', 0); except Frame.cmbGame.ItemIndex := 0; end;
  Frame.cmbGameSelect(nil);

  fMode := StorageGetInteger('iMode', 0);
  Frame.rbAdd.Checked := (fMode = Frame.rbAdd.Tag) or (fMode < 0) or (fMode > 2);
  Frame.rbSet.Checked := fMode = Frame.rbSet.Tag;
  Frame.rbRemove.Checked := fMode = Frame.rbRemove.Tag;

  Frame.Int32ToCheckListBox(Frame.clbFlags1, StorageGetInteger('iFlags', 0));
  Frame.Int32ToCheckListBox(Frame.clbFlags2, StorageGetInteger('iFlags2', 0));
end;

procedure TProcShaderFlagsUpdate.OnHide;
begin
  StorageSetInteger('iGame', Frame.cmbGame.ItemIndex);

  if Frame.rbAdd.Checked then fMode := Frame.rbAdd.Tag;
  if Frame.rbSet.Checked then fMode := Frame.rbSet.Tag;
  if Frame.rbRemove.Checked then fMode := Frame.rbRemove.Tag;
  StorageSetInteger('iMode', fMode);

  StorageSetInteger('iFlags', Frame.CheckListBoxToInt32(Frame.clbFlags1));
  StorageSetInteger('iFlags2', Frame.CheckListBoxToInt32(Frame.clbFlags2));
end;

procedure TProcShaderFlagsUpdate.OnStart;
begin
  fFlags := Frame.CheckListBoxToInt32(Frame.clbFlags1);
  fFlags2 := Frame.CheckListBoxToInt32(Frame.clbFlags2);

  if (fFlags = 0) and (fFlags2 = 0) then
    raise Exception.Create('No flags selected');

  if Frame.rbAdd.Checked then fMode := Frame.rbAdd.Tag;
  if Frame.rbSet.Checked then fMode := Frame.rbSet.Tag;
  if Frame.rbRemove.Checked then fMode := Frame.rbRemove.Tag;
end;

function TFrameShaderFlagsUpdate.CheckListBoxToInt32(const aBox: TCheckListBox): Cardinal;
begin
  Result := 0;
  for var i: Integer := 0 to 31 do
    if (i < aBox.Items.Count) and aBox.Checked[i] then
      Result := Result or (1 shl i);
end;

procedure TFrameShaderFlagsUpdate.Int32ToCheckListBox(const aBox: TCheckListBox; aInt: Cardinal);
begin
  for var i: Integer := 0 to Pred(aBox.Items.Count) do
    aBox.Checked[i] := aInt and (1 shl i) <> 0;
end;

procedure TFrameShaderFlagsUpdate.cmbGameSelect(Sender: TObject);
var
  f1, f2: Cardinal;
begin
  f1 := CheckListBoxToInt32(clbFlags1);
  f2 := CheckListBoxToInt32(clbFlags2);

  with TProcShaderFlagsUpdate(Proc) do
  if cmbGame.ItemIndex = 0 then begin
    clbFlags1.Items.Assign(slFO3Flags);
    clbFlags2.Items.Assign(slFO3Flags2);
  end
  else if cmbGame.ItemIndex = 1 then begin
    clbFlags1.Items.Assign(slTES5Flags);
    clbFlags2.Items.Assign(slTES5Flags2);
  end
  else if cmbGame.ItemIndex = 2 then begin
    clbFlags1.Items.Assign(slFO4Flags);
    clbFlags2.Items.Assign(slFO4Flags2);
  end;

  Int32ToCheckListBox(clbFlags1, f1);
  Int32ToCheckListBox(clbFlags2, f2);
end;

function TProcShaderFlagsUpdate.ProcessFile(const aInputDirectory, aOutputDirectory: string; var aFileName: string): TBytes;
var
  nif: TwbNifFile;
  i: Integer;
  shader: TwbNifBlock;
  bChanged: Boolean;

  procedure UpdateFlags(el: TdfElement; aFlags: Cardinal);
  var
    f: Cardinal;
  begin
    if not Assigned(el) then
      Exit;

    f := el.NativeValue;
    if fMode = 0 then f := f or aFlags else
    if fMode = 1 then f := aFlags else
    if fMode = 2 then f := f and not aFlags;

    if el.NativeValue <> f then begin
      el.NativeValue := f;
      bChanged := True;
    end;
  end;

begin
  bChanged := False;
  nif := TwbNifFile.Create;
  try
    nif.LoadFromFile(aInputDirectory + aFileName);

    for i := 0 to Pred(nif.BlocksCount) do begin
      shader := nif.Blocks[i];

      if (shader.BlockType <> 'BSShaderPPLightingProperty') and
         (shader.BlockType <> 'BSLightingShaderProperty')
      then
        Continue;

      //UpdateFlags(shader.Elements['Shader Flags'], fFlags);
      UpdateFlags(shader.Elements['Shader Flags 1'], fFlags);
      UpdateFlags(shader.Elements['Shader Flags 2'], fFlags2);
    end;

    if bChanged then
      nif.SaveToData(Result);

  finally
    nif.Free;
  end;

end;

end.

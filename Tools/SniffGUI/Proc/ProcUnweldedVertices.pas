{******************************************************************************

  This Source Code Form is subject to the terms of the Mozilla Public License,
  v. 2.0. If a copy of the MPL was not distributed with this file, You can obtain
  one at https://mozilla.org/MPL/2.0/.

*******************************************************************************}

unit ProcUnweldedVertices;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes,
  Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, SniffProcessor,
  Vcl.StdCtrls, Vcl.ExtCtrls;

type
  TFrameUnweldedVertices = class(TFrame)
    StaticText1: TStaticText;
    edDistance: TLabeledEdit;
    chkSkipSame: TCheckBox;
    chkReportVertices: TCheckBox;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

  TVertex = packed record X, Y, Z: Single end;
  TVertices = array of TVertex;
  PVertex = ^TVertex;

  TProcUnweldedVertices = class(TProcBase)
  private
    Frame: TFrameUnweldedVertices;
    fInvDistance: Single;
    fSkipSame: Boolean;
    fReportVertices: Boolean;

    function UnweldedVerticesCount(const aVertices: TVertices; Log: TStrings): Integer;
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

constructor TProcUnweldedVertices.Create(aManager: TProcManager);
begin
  inherited;

  fTitle := 'Find unwelded vertices';
  fSupportedGames := [gtTES3, gtTES4, gtFO3, gtFNV, gtTES5, gtSSE, gtFO4];
  fExtensions := ['nif'];
  fNoOutput := True;
end;

function TProcUnweldedVertices.GetFrame(aOwner: TComponent): TFrame;
begin
  Frame := TFrameUnweldedVertices.Create(aOwner);
  Result := Frame;
end;

procedure TProcUnweldedVertices.OnShow;
begin
  Frame.edDistance.Text := StorageGetString('sDistance', Frame.edDistance.Text);
  Frame.chkSkipSame.Checked := StorageGetBool('bSkipSame', Frame.chkSkipSame.Checked);
  Frame.chkReportVertices.Checked := StorageGetBool('bReportVertices', Frame.chkReportVertices.Checked);
end;

procedure TProcUnweldedVertices.OnHide;
begin
  StorageSetString('sDistance', Frame.edDistance.Text);
  StorageSetBool('bSkipSame', Frame.chkSkipSame.Checked);
  StorageSetBool('bReportVertices', Frame.chkReportVertices.Checked);
end;

procedure TProcUnweldedVertices.OnStart;
begin
  fSkipSame := Frame.chkSkipSame.Checked;
  fReportVertices := Frame.chkReportVertices.Checked;

  try
    fInvDistance := 1 / StrToFloat(Frame.edDistance.Text);
  except
    raise Exception.Create('Distance is not a float value or zero');
  end;
end;

function TProcUnweldedVertices.UnweldedVerticesCount(const aVertices: TVertices; Log: TStrings): Integer;

  function FastInvSqrt(const Value: Single): Single; inline;
  var
    IntCst: Cardinal absolute Result;
  begin
    Result := Value;
    IntCst := ($BE6EB50C - IntCst) shr 1;
    Result := 0.5 * Result * (3 - Value * Result * Result);
  end;

  function InvDistance(const v1, v2: PVertex): Single; inline;
  begin
    Result := FastInvSqrt(
      (v2.X - v1.X) * (v2.X - v1.X) +
      (v2.Y - v1.Y) * (v2.Y - v1.Y) +
      (v2.Z - v1.Z) * (v2.Z - v1.Z)
    )
  end;

var
  i, j: Integer;
  bSame: Boolean;
begin
  Result := 0;
  for i := Low(aVertices) to Pred(High(aVertices)) do
    for j := Succ(i) to High(aVertices) do begin
      bSame := CompareMem(@aVertices[i], @aVertices[j], SizeOf(TVertex));
      if fSkipSame and bSame then
        Continue;

      if bSame or (InvDistance(@aVertices[i], @aVertices[j]) >= fInvDistance) then begin

        if fReportVertices then
          Log.Add(Format(#9'[%d] (%s, %s, %s) <-> [%d] (%s, %s, %s)', [
            i,
            dfFloatToStr(aVertices[i].X),
            dfFloatToStr(aVertices[i].Y),
            dfFloatToStr(aVertices[i].Z),
            j,
            dfFloatToStr(aVertices[j].X),
            dfFloatToStr(aVertices[j].Y),
            dfFloatToStr(aVertices[j].Z)
          ]));

        Inc(Result);
      end;

    end;
end;

function TProcUnweldedVertices.ProcessFile(const aInputDirectory, aOutputDirectory: string; var aFileName: string): TBytes;
var
  nif: TwbNifFile;
  Log: TStringList;
  i, j: Integer;
  block: TwbNifBlock;
  entries, entry: TdfElement;
  verts: TVertices;
  data: TBytes;
begin
  Log := TStringList.Create;
  nif := TwbNifFile.Create;
  try
    nif.LoadFromFile(aInputDirectory + aFileName);

    for i := 0 to Pred(nif.BlocksCount) do begin
      block := nif.Blocks[i];

      if block.IsNiObject('NiTriBasedGeomData') then begin
        entries := block.Elements['Vertices'];
        if not Assigned(entries) then
          Continue;

        SetLength(verts, entries.Count);
        entries.SaveToData(data);
        System.Move(data[0], verts[0], Length(data));
      end

      else if block.IsNiObject('BSTriShape') then begin
        entries := block.Elements['Vertex Data'];
        if not Assigned(entries) then
          entries := block.Elements['Vertices'];

        if not Assigned(entries) then
          Continue;

        SetLength(verts, entries.Count);
        for j := Low(verts) to High(verts) do begin
          entry := entries[j].Elements['Vertex'];
          if not Assigned(entry) then
            Break;
          verts[j].X := entry.NativeValues['X'];
          verts[j].Y := entry.NativeValues['Y'];
          verts[j].Z := entry.NativeValues['Z'];
        end;

      end else
        Continue;

      {SetLength(verts, 2);
      with verts[0] do begin X := 1; Y:= 1; Z := 1; end;
      with verts[1] do begin X := 1.1; Y:= 1.1; Z := 1.1; end;}

      j := UnweldedVerticesCount(verts, Log);
      if j > 0 then begin
        Log.Add(#9 + IntToStr(j) + ' unwelded vertices [' + IntToStr(Round(j/Length(verts)*100)) + '%] in ' + Block.Name);
        if fReportVertices then
          Log.Add('');
      end;

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

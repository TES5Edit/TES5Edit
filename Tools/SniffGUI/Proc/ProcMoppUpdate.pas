{******************************************************************************

  This Source Code Form is subject to the terms of the Mozilla Public License,
  v. 2.0. If a copy of the MPL was not distributed with this file, You can obtain
  one at https://mozilla.org/MPL/2.0/.

*******************************************************************************}

unit ProcMoppUpdate;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes,
  Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, SniffProcessor, wbNifMath,
  System.SyncObjs, Vcl.StdCtrls;

type
  TFrameMoppUpdate = class(TFrame)
    StaticText1: TStaticText;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

  TTriangleInt16 = array [0..2] of Word;
  PTriangleInt16 = ^TTriangleInt16;

  TGenerateMoppCodeWithSubshapesProc = function(
    nShapes: Integer;
    shapes: Pointer;
    nVerts: Integer;
    verts: PSingleVector3;
    nTris: Integer;
    tris: PTriangleInt16
  ): Integer; stdcall;
  TRetrieveMoppCodeProc = function(nBuffer: Integer; buffer: Pointer): Integer; stdcall;
  TRetrieveMoppScaleProc = function(value: PSingle): Integer; stdcall;
  TRetrieveMoppOriginProc = function(value: PSingleVector3): Integer; stdcall;

  TProcMoppUpdate = class(TProcBase)
  private
    Frame: TFrameMoppUpdate;
    DLLHandle: THandle;
    fMoppCS: TCriticalSection;

    GenerateMoppCodeWithSubshapes: TGenerateMoppCodeWithSubshapesProc;
    RetrieveMoppCode: TRetrieveMoppCodeProc;
    RetrieveMoppScale: TRetrieveMoppScaleProc;
    RetrieveMoppOrigin: TRetrieveMoppOriginProc;

    procedure LoadMoppDll;
    procedure UnLoadMoppDll;

    function CalculateMoppCode(
      const SubShapesVerts: array of Integer;
      const Verts: array of TSingleVector3;
      const Tris: array of TTriangleInt16;
      var Origin: TSingleVector3;
      var Scale: Single
    ): TBytes;

  public
    constructor Create(aManager: TProcManager); override;
    destructor Destroy; override;
    function GetFrame(aOwner: TComponent): TFrame; override;
    procedure OnStart; override;

    function ProcessFile(const aInputDirectory, aOutputDirectory: string; var aFileName: string): TBytes; override;
  end;


implementation

{$R *.dfm}

uses
  wbDataFormat,
  wbDataFormatNif;

constructor TProcMoppUpdate.Create(aManager: TProcManager);
begin
  inherited;

  fTitle := 'Update MOPP code';
  fSupportedGames := [gtFO3, gtFNV];
  fExtensions := ['nif'];
  fThreads := 1; // NifMopp.dll is not thread safe

  fMoppCS := TCriticalSection.Create;
end;

destructor TProcMoppUpdate.Destroy;
begin
  UnLoadMoppDll;
  fMoppCS.Free;
end;

function TProcMoppUpdate.GetFrame(aOwner: TComponent): TFrame;
begin
  Frame := TFrameMoppUpdate.Create(aOwner);
  Result := Frame;
end;

procedure TProcMoppUpdate.OnStart;
begin
  // reload DLL otherwise it stops working on consequent runs
  UnLoadMoppDll;
  LoadMoppDll;
end;

procedure TProcMoppUpdate.LoadMoppDll;
var
  oldmode: Integer;
begin
  if DLLHandle <> 0 then
    Exit;

  oldmode := SetErrorMode($8001);
  DLLHandle:= LoadLibrary(PChar(ExtractFilePath(Application.ExeName) + 'NifMopp.dll'));
  SetErrorMode(oldmode);

  if DLLHandle <> 0 then begin
    @GenerateMoppCodeWithSubshapes := GetProcAddress(DLLHandle, PChar('GenerateMoppCodeWithSubshapes'));
    @RetrieveMoppCode := GetProcAddress(DLLHandle, PChar('RetrieveMoppCode'));
    @RetrieveMoppScale := GetProcAddress(DLLHandle, PChar('RetrieveMoppScale'));
    @RetrieveMoppOrigin := GetProcAddress(DLLHandle, PChar('RetrieveMoppOrigin'));
  end;

  if (@GenerateMoppCodeWithSubshapes = nil) or
     (@RetrieveMoppCode = nil) or
     (@RetrieveMoppScale = nil) or
     (@RetrieveMoppOrigin = nil)
  then begin
    UnLoadMoppDll;
    raise Exception.Create('Unable to load NifMopp.dll');
  end;

end;

procedure TProcMoppUpdate.UnLoadMoppDll;
begin
  if DLLHandle = 0 then
    Exit;

  FreeLibrary(DLLHandle);
  DLLHandle := 0;
  @GenerateMoppCodeWithSubshapes := nil;
  @RetrieveMoppCode := nil;
  @RetrieveMoppScale := nil;
  @RetrieveMoppOrigin := nil;
end;


function TProcMoppUpdate.CalculateMoppCode(
  const SubShapesVerts: array of Integer;
  const Verts: array of TSingleVector3;
  const Tris: array of TTriangleInt16;
  var Origin: TSingleVector3;
  var Scale: Single
): TBytes;
var
  len: Integer;
  ps, pv, pt: Pointer;
begin
  // ensure memory alignment of passed pointers to DLL
  ps := GetMemory(Length(SubShapesVerts) * SizeOf(Integer));
  pv := GetMemory(Length(Verts) * SizeOf(TSingleVector3));
  pt := GetMemory(Length(Tris) * SizeOf(TTriangleInt16));
  System.Move(SubShapesVerts[0], ps^, Length(SubShapesVerts) * SizeOf(Integer));
  System.Move(Verts[0], pv^, Length(Verts) * SizeOf(TSingleVector3));
  System.Move(Tris[0], pt^, Length(Tris) * SizeOf(TTriangleInt16));

  fMoppCS.Enter;
  try

    len := GenerateMoppCodeWithSubshapes(Length(SubShapesVerts), ps, Length(Verts), pv, Length(Tris), pt);
    {
    len := GenerateMoppCodeWithSubshapes(
      Length(SubShapesVerts),
      @SubShapesVerts[0],
      Length(Verts),
      @Verts[0],
      Length(Tris),
      @Tris[0]
    );
    }

    if len > 0 then begin
      SetLength(Result, len);
      if RetrieveMoppCode(len, @Result[0]) <> 0 then begin
        RetrieveMoppScale(@Scale);
        RetrieveMoppOrigin(@Origin);

      end else
        SetLength(Result, 0);
    end;

  finally
    fMoppCS.Leave;

    FreeMemory(ps);
    FreeMemory(pv);
    FreeMemory(pt);
  end;
end;

function TProcMoppUpdate.ProcessFile(const aInputDirectory, aOutputDirectory: string; var aFileName: string): TBytes;
var
  nif: TwbNifFile;
  i, j: Integer;
  MoppShape, StripsShape, StripsData: TwbNifBlock;
  elSubShapes, elVertices, elTriangles, elTriangle: TdfElement;
  SubShapesVerts: array of Integer;
  Vertices: array of TSingleVector3;
  Triangles: array of TTriangleInt16;
  Scale: Single;
  Origin: TSingleVector3;
  data: TBytes;
  bChanged: Boolean;
begin
  bChanged := False;
  nif := TwbNifFile.Create;
  try
    nif.LoadFromFile(aInputDirectory + aFileName);

    for i := 0 to Pred(nif.BlocksCount) do begin

      MoppShape := nif.Blocks[i];
      if MoppShape.BlockType <> 'bhkMoppBvTreeShape' then
        Continue;

      StripsShape := TwbNifBlock(MoppShape.Elements['Shape'].LinksTo);
      if not Assigned(StripsShape) or (StripsShape.BlockType <> 'bhkPackedNiTriStripsShape') then
        Continue;

      StripsData := TwbNifBlock(StripsShape.Elements['Data'].LinksTo);
      if not Assigned(StripsData) or (StripsData.BlockType <> 'hkPackedNiTriStripsData') then
        Continue;

      // Sub Shapes can be in different places depending on the nif format
      elSubShapes := StripsShape.Elements['Sub Shapes'];
      if not Assigned(elSubShapes) then
        elSubShapes := StripsData.Elements['Sub Shapes'];

      if not Assigned(elSubShapes) then
        Continue;

      // collecting sub shapes vertices numbers
      SetLength(SubShapesVerts, elSubShapes.Count);
      for j := 0 to Pred(elSubShapes.Count) do
        SubShapesVerts[j] := elSubShapes[j].NativeValues['Num Vertices'];

      // collecting vertices
      elVertices := StripsData.Elements['Vertices'];
      SetLength(Vertices, elVertices.Count);
      // vertices array variable and vertices in nif have the same data type (3 float values), so we can copy them all as bytes
      elVertices.SaveToData(data);
      System.Move(data[0], Vertices[0], Length(data));;

      // collecting triangles
      elTriangles := StripsData.Elements['Triangles'];
      SetLength(Triangles, elTriangles.Count);
      for j := 0 to Pred(elTriangles.Count) do begin
        elTriangle := elTriangles[j].Elements['Triangle'];
        // copy each triangle as bytes (3 int16 values)
        elTriangle.SaveToData(data);
        System.Move(data[0], Triangles[j], Length(data));;
      end;

      SetLength(data, 0);
      data := CalculateMoppCode(SubShapesVerts, Vertices, Triangles, Origin, Scale);
      if Length(data) = 0 then
        raise Exception.Create('MOPP generator returned 0 bytes');

      //fManager.AddMessage(aFileName + '  ' + IntToStr(Length(data)));

      MoppShape.NativeValues['MOPP Data'] := data;
      MoppShape.NativeValues['Scale'] := Scale;
      MoppShape.Elements['Origin'].NativeValues['X'] := Origin.x;
      MoppShape.Elements['Origin'].NativeValues['Y'] := Origin.y;
      MoppShape.Elements['Origin'].NativeValues['Z'] := Origin.z;

      bChanged := True;
    end;

    if bChanged then
      nif.SaveToData(Result);

  finally
    nif.Free;
  end;

end;


end.

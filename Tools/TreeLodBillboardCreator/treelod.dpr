{*******************************************************************************

     The contents of this file are subject to the Mozilla Public License
     Version 1.1 (the "License"); you may not use this file except in
     compliance with the License. You may obtain a copy of the License at
     http://www.mozilla.org/MPL/

     Software distributed under the License is distributed on an "AS IS"
     basis, WITHOUT WARRANTY OF ANY KIND, either express or implied. See the
     License for the specific language governing rights and limitations
     under the License.

*******************************************************************************}

program treelod;

{$APPTYPE CONSOLE}

uses
  SysUtils,
  Classes,
  Windows,
  //PsApi,
  Math,
  Graphics,
  RegularExpressions,
  ImagingTypes,
  ImagingFormats,
  ImagingCanvases,
  ImagingComponents,
  Imaging;

var
  ImgFileName: string;
  Img: TImageData;
  i, Size, ForceWidth: Integer;
  Border: Integer;
  BorderPct, Contrast, Brightness: Single;
  bMipMap, bAim: Boolean;
  MaskDiff: Integer;
  s: string;
  ImgFormat: TImageFormat;

function wbFindCmdLineParam(const aSwitch: string; out aValue: string): Boolean;
var
  i : Integer;
  s : string;
begin
  Result := False;
  aValue := '';
  for i := 1 to ParamCount do begin
    s := ParamStr(i);
    if (SwitchChars = []) or CharInSet(s[1], SwitchChars) then
      if AnsiCompareText(Copy(s, 2, Length(aSwitch)), aSwitch) = 0 then begin
        if (length(s)>(length(aSwitch)+2)) and (s[Length(aSwitch) + 2] = ':') then begin
          aValue := Copy(s, Length(aSwitch) + 3, MaxInt);
          Result := True;
        end;
        Exit;
      end;
  end;
end;

function GetFileNameFromTitle(s: string): string;
var
  m: TMatchCollection;
begin
  Result := '';

  // Preview File: "tes4\trees\TreeSugarMapleFreeSU.nif" - 1192 triangles
  m := TRegEx.Matches(s, '"([\w\\]+\.nif)');
  if m.Count > 0 then begin
    Result := ExtractFileName(m[0].Groups[1].Value);
    Exit;
  end;

  // Preview File: wrtempletree01.nif - NifSkope 2.0.0 Pre-Alpha
  m := TRegEx.Matches(s, '(.*\.nif) - NifSkope');
  if m.Count > 0 then begin
    Result := ExtractFileName(m[0].Groups[1].Value);
    Exit;
  end;

  // Preview Object: 'TreeAspen02' (0006C9D5) - 768 triangles
  m := TRegEx.Matches(s, '''([\w]+)'' \(([0-9ABCDEF]{8})\)');
  if m.Count > 0 then begin
    Result := Format('%s_00%s.dds', [m[0].Groups[1].Value, Copy(m[0].Groups[2].Value, 3, 6)]);
    Exit;
  end;

  Result := 'Preview.dds';
end;

function GetScreenShot(const aWndHandle: THandle): TBitmap;
var
  wWindow: HDC;
  cRect : TRect;
  p: TPoint;
  wDesktop : THandle;
begin
  Result := TBitmap.Create;
  try
    wDesktop := GetDesktopWindow;
    wWindow := GetDC(wDesktop);
    try
      Result.PixelFormat := pf32bit;
      GetClientRect(aWndHandle, cRect);
      p.X := cRect.Left;
      p.Y := cRect.Top;
      ClientToScreen(aWndHandle, p);
      Result.Width := cRect.Right - cRect.Left;
      Result.Height := cRect.Bottom - cRect.Top;
      BitBlt(Result.Canvas.Handle, 0, 0, Result.Width, Result.Height, wWindow, p.X, p.Y, SRCCOPY);
      //BitBlt(Result.Canvas.Handle, 0, 0, Result.Width, Result.Height, wWindow, 0, 0, SRCCOPY);
      Result.Modified := True;
    finally
      ReleaseDC(wDesktop, wWindow);
    end;
  except
    Result.Free;
    Result := nil;
  end;
end;

{
// doesn't work in WOW64
function GetProcessName(Handle: hWnd): string;
var
  PID, hProcess: DWORD;
  iLen: Integer;
  sTemp: string;
begin
  SetLength(sTemp, MAX_PATH);
  Result := '';
  GetWindowThreadProcessId(Handle, PID);
  hProcess := OpenProcess(PROCESS_QUERY_INFORMATION or PROCESS_VM_READ, False, PID);
  if hProcess <> 0 then try
    iLen := GetModuleFileNameEx(hProcess, 0, PChar(sTemp), MAX_PATH);
    Result := Copy(sTemp, 1, iLen);
  finally
    CloseHandle(hProcess);
  end;
end;
}

function GetProcessName(Handle: hWnd): UnicodeString;
const
  PROCESS_QUERY_LIMITED_INFORMATION = $00001000; //Vista and above
type
  TQueryFullProcessImageNameW = function(AProcess: THANDLE; AFlags: DWORD;
    AFileName: PWideChar; var ASize: DWORD): BOOL; stdcall;
var
  AProcessID: DWORD;
  HProcess: THandle;
  Lib: HMODULE;
  QueryFullProcessImageNameW: TQueryFullProcessImageNameW;
  S: DWORD;
begin
  GetWindowThreadProcessId(Handle, AProcessID);
  Lib := GetModuleHandle('kernel32.dll');
  if Lib = 0 then RaiseLastOSError;
  @QueryFullProcessImageNameW := GetProcAddress(Lib, 'QueryFullProcessImageNameW');
  if not Assigned(QueryFullProcessImageNameW) then RaiseLastOSError;
  HProcess := OpenProcess(PROCESS_QUERY_LIMITED_INFORMATION, False, AProcessID);
  if HProcess = 0 then RaiseLastOSError;
  try
    S := MAX_PATH;
    SetLength(Result, S + 1);
    while not QueryFullProcessImageNameW(HProcess, 0, PWideChar(Result), S) and (GetLastError = ERROR_INSUFFICIENT_BUFFER) do
      begin
        S := S * 2;
        SetLength(Result, S + 1);
      end;
    SetLength(Result, S);
    Inc(S);
    if not QueryFullProcessImageNameW(HProcess, 0, PWideChar(Result), S) then
      RaiseLastOSError;
  finally
    CloseHandle(HProcess);
  end;
end;


var
  FoundChildHandle: hWnd;

function NifSkopeChildProc(WndCtrl: HWND; lParam: Longint): BOOL; stdcall;
var
  i: integer;
  sTemp: string;
begin
  SetLength(sTemp, MAX_PATH);
  i := GetClassName(WndCtrl, PChar(sTemp), MAX_PATH);
  if Copy(sTemp, 1, i) = 'Qt5QWindowOwnDCIcon' then begin
    FoundChildHandle := WndCtrl;
    Result := False;
  end else
    Result := True;
end;

function FindPreviewWindow(var Parent: hWnd; var Title: string): hWnd;
var
  Handle, hImg: hWnd;
  iLen: Integer;
  sTemp, sTitle: string;
  TheText: array[0..255] of char;
begin
  Result := 0;
  SetLength(sTemp, MAX_PATH);

  // Find Creation Kit Preview
  Handle := FindWindow(nil, nil);
  while Handle <> 0 do begin
    iLen := GetWindowText(Handle, PChar(sTemp), MAX_PATH);
    sTitle := Copy(sTemp, 1, iLen);
    if (Pos('Preview', sTitle) > 0) and (Pos('creationkit.exe', LowerCase(GetProcessName(Handle))) > 0) then begin
      hImg := FindWindowEx(Handle, 0, nil, PChar('IMAGE'));
      if hImg <> 0 then begin
        Result := hImg;
        Parent := Handle;
        Title := sTitle;
        Exit;
      end;
    end;
    Handle := GetWindow(handle, GW_HWNDNEXT);
  end;

  // Find Construction Set Render
  Handle := FindWindow(nil, nil);
  while Handle <> 0 do begin
    iLen := GetClassName(Handle, PChar(sTemp), MAX_PATH);
    sTitle := Copy(sTemp, 1, iLen);
    if (Pos('MonitorClass', sTitle) > 0) and (Pos('tesconstructionset.exe', LowerCase(GetProcessName(Handle))) > 0) then begin
      Result := Handle;
      Parent := Handle;
      Title := '';
      Exit;
    end;
    Handle := GetWindow(handle, GW_HWNDNEXT);
  end;

  // Find NifSkope render
  Handle := FindWindow(nil, nil);
  while Handle <> 0 do begin
    iLen := GetClassName(Handle, PChar(sTemp), MAX_PATH);
    sTitle := Copy(sTemp, 1, iLen);
    if (Pos('Qt5QWindowIcon', sTitle) > 0) and (Pos('nifs', LowerCase(GetProcessName(Handle))) > 0) then begin
      FoundChildHandle := 0;
      EnumChildWindows(Handle, @NifSkopeChildProc, 0);
      hImg := FoundChildHandle;
      if hImg <> 0 then begin
        Result := hImg;
        Parent := Handle;
        GetWindowText(Handle, TheText, 255);
        Title := StrPas(TheText);
        Exit;
      end;
    end;
    Handle := GetWindow(handle, GW_HWNDNEXT);
  end;
end;

function GetPreviewImage(var aImg: TImageData): string;
var
  Handle, Parent: hWnd;
  Title: string;
  bmp: TBitmap;
begin
  Result := '';
  Handle := FindPreviewWindow(Parent, Title);
  if Handle = 0 then
    Exit;

  WriteLn('Running CK/CS/NifSkope found, after pressing ENTER it''ll become active to grab the image.');
  WriteLn('Press ENTER to continue...');
  ReadLn;
  SetForegroundWindow(Parent);
  Sleep(500);
  bmp := GetScreenShot(Handle);
  if Assigned(bmp) then try
    ConvertBitmapToData(bmp, aImg);
    Result := GetFileNameFromTitle(Title);
  finally
    bmp.Free;
  end;
end;

function SameMaskColor(c1, c2: TColor32Rec): Boolean;
begin
  Result :=
    (Abs(Integer(c1.R) - Integer(c2.R)) <= MaskDiff) and
    (Abs(Integer(c1.G) - Integer(c2.G)) <= MaskDiff) and
    (Abs(Integer(c1.B) - Integer(c2.B)) <= MaskDiff);
end;

function ddsProcess(var aImage: TImageData; OutFileName: string): Boolean;
var
  tempimg: TImageData;
  MipmapImg: TDynImageDataArray;
  Canvas: TImagingCanvas;
  i, j, x, y, x1, x2, y1, y2, w, h: Integer;
  edge: Boolean;
  scale: Double;
  MaskColor: Cardinal;
  c1, c2: TColor32Rec;
  Info: TImageFormatInfo;
begin
  if aImage.Format <> ifA8R8G8B8 then
    if not ConvertImage(aImage, ifA8R8G8B8) then
      raise Exception.Create('Error when converting to A8R8G8B8');

  Result := True;
  x1 := 0; x2 := 0; y1 := 0; y2 := 0;

  Canvas := TImagingCanvas.CreateForData(@aImage);
  try
    // contrast and brightness
    if not (SameValue(Contrast, 0.0) and SameValue(Brightness, 0.0)) then
      Canvas.ModifyContrastBrightness(Contrast, Brightness);

    // detect edges of image using top left pixel color as background
    MaskColor := Canvas.Pixels32[0, 0];

    // X1
    edge := False;
    for i := 0 to aImage.Width - 1 do begin
      for j := 0 to aImage.Height - 1 do
        if Canvas.Pixels32[i, j] <> MaskColor then begin
          edge := True;
          Break;
        end;
      if edge then begin
        x1 := Max(i, 0);
        Break;
      end;
    end;
    if not edge then begin
      Result := False;
      Exit;
    end;

    // X2
    edge := False;
    for i := aImage.Width - 1 downto 0 do begin
      for j := 0 to aImage.Height - 1 do
        if Canvas.Pixels32[i, j] <> MaskColor then begin
          edge := True;
          Break;
        end;
      if edge then begin
        x2 := Min(i, aImage.Width);
        Break;
      end;
    end;
    if not edge then begin
      Result := False;
      Exit;
    end;

    // Y1
    edge := False;
    for j := 0 to aImage.Height - 1 do begin
      for i := 0 to aImage.Width - 1 do
        if Canvas.Pixels32[i, j] <> MaskColor then begin
          edge := True;
          Break;
        end;
      if edge then begin
        y1 := Max(j, 0);
        Break;
      end;
    end;
    if not edge then begin
      Result := False;
      Exit;
    end;

    // Y2
    edge := False;
    for j := aImage.Height - 1 downto 0 do begin
      for i := 0 to aImage.Width - 1 do
        if Canvas.Pixels32[i, j] <> MaskColor then begin
          edge := True;
          Break;
        end;
      if edge then begin
        y2 := Min(j, aImage.Height);
        Break;
      end;
    end;
    if not edge then begin
      Result := False;
      Exit;
    end;
  finally
    Canvas.Free;
  end;

  // adjust with border size
  if BorderPct <> 0 then begin
    // in percents
    Border := Round((y2 - y1) * BorderPct / 100);
    scale := Size / (y2 - y1);
    if scale <> 0 then Border := Round(Border / scale);
    y1 := y1 - Border;
    y2 := y2 + Border;
    Border := Round((x2 - x1) * BorderPct / 100);
    if scale <> 0 then Border := Round(Border / scale);
    x1 := x1 - Border;
    x2 := x2 + Border;
  end
  else begin
    // in pixels
    y1 := y1 - Border;
    y2 := y2 + Border;
    x1 := x1 - Border;
    x2 := x2 + Border;
  end;

  // width and height of billboard
  if Size > 0 then begin
    scale := Size / (y2 - y1);
    w := Round((x2 - x1) * scale);
    h := Size;
  end
  else begin
    w := x2 - x1;
    h := y2 - y1;
  end;
  // make sure that width is power of 2 for mipmaps
  if (Size > 0) and bMipMap then begin
    i := 1;
    while i < w do i := i shl 1;
    j := Size;
  end
  else begin
    i := w;
    j := h;
  end;

  if ForceWidth <> 0 then
    i := ForceWidth;

  NewImage(i, j, aImage.Format, tempimg);
  try
    // create alpha mask
    c1 := GetPixel32(aImage, 0, 0);
    for x := 0 to aImage.Width - 1 do
      for y := 0 to aImage.Height - 1 do begin
        c2 := GetPixel32(aImage, x, y);
        if SameMaskColor(c1, c2) then
          c2.A := 0
        else
          c2.A := 255;
        SetPixel32(aImage, x, y, c2);
      end;

    // center by X, stick to bottom by Y
    if h = (y2 - y1) then
      CopyRect(aImage, x1, y1, tempimg.Width, tempimg.Height, tempimg, (i - w) div 2, j - h)
    else
      StretchRect(
        aImage, x1, y1, x2 - x1, y2 - y1,
        tempimg, (i - w) div 2, j - h, w, h,
        rfLanczos
      );

    // draw aiming middle line
    if bAim then begin
      for i := 0 to tempimg.Height - 1 do begin
        c1 := GetPixel32(tempimg, tempimg.Width div 2, i);
        c1.R := 255; c1.A := 255;
        SetPixel32(tempimg, tempimg.Width div 2, i, c1);
      end;
    end;

    // create alpha mask
    {c1 := GetPixel32(tempimg, 0, 0);
    for i := 0 to tempimg.Width - 1 do
      for j := 0 to tempimg.Height - 1 do begin
        c2 := GetPixel32(tempimg, i, j);
        if SameMaskColor(c1, c2) then
          c2.A := 0
        else
          c2.A := 255;
        SetPixel32(tempimg, i, j, c2);
      end;}

    GetImageFormatInfo(ImgFormat, Info);

    if not ConvertImage(tempimg, ImgFormat) then
      raise Exception.Create('Unable to compress billboard to ' +  Info.Name);
    WriteLn(Format('Saving billboard to %s using format %s', [OutFileName, Info.Name]));

    if bMipMap then begin
      SetOption(ImagingMipMapFilter, Ord(sfLanczos));
      if not GenerateMipMaps(tempimg, 0, MipmapImg) then
        raise Exception.Create('Can''t generate mipmaps');
      try
        SaveMultiImageToFile(OutFileName, MipmapImg);
      finally
        FreeImagesInArray(MipmapImg);
      end;
    end else
      SaveImageToFile(OutFileName, tempimg);
  finally
    FreeImage(tempimg);
  end;
end;

// this ought to be a function in imaging
function StrToImageFormat(const aName: string): TImageFormat;
begin
  if SameText(aName, '8888') then Result := ifA8R8G8B8 else
  if SameText(aName, 'DXT1') then Result := ifDXT1 else
  if SameText(aName, 'DXT3') then Result := ifDXT3 else
  if SameText(aName, 'DXT5') then Result := ifDXT5 else
  Result := ifDXT3;
end;

begin
  FormatSettings.DecimalSeparator := '.';

  try
    ImgFileName := ParamStr(1);
    // no image file, grab from CK/CS
    if (ImgFileName = '') or (CharInSet(ImgFileName[1], SwitchChars)) then begin
      ImgFileName := GetPreviewImage(Img);
      if Img.Format <> ifA8R8G8B8 then begin
        WriteLn('Tree LOD billboard tool for xLODGen');
        WriteLn('Usage: treelod.exe [imagefile] [options]');
        WriteLn('If [imagefile] (dds, tga, bmp, png) is not specified then grab image from CK or CS preview window');
        WriteLn('Available options:');
        WriteLn('  -aim                 Draw a vertical red line at the middle of image');
        WriteLn('                       to "aim" for symmetry');
        WriteLn('  -mipmap              Save with mipmaps, round billboard size to power of 2');
        WriteLn('  -border:[pixels]     Leave empty border around billboard, default 2 pixels');
        WriteLn('  -height:[pixels]     Height of billboard');
        WriteLn('  -maskdiff:[n]        Alpha layer detection deviance of RGB values');
        WriteLn('                       default is 0 for exact matching');
        WriteLn('  -format:[txt]        Image format [DXT1|DXT3|DXT5|8888]');
        WriteLn('  -contrast:[float]    Adjust contrast of billboard');
        WriteLn('  -brightness:[float]  Adjust brightness of billboard');
        WriteLn('                       color = color * (1 + contrast/100) + brightness/100');
        WriteLn;
        raise Exception.Create('Unable to grab preview image, official editor (or NifSkope) is not running?');
      end;
    end
    // load from file
    else begin
      if not FileExists(ImgFileName) then
        raise Exception.Create('Input file not found');
      if not LoadImageFromFile(ImgFileName, Img) then
        raise Exception.Create(Format('Can not load image %s', [ImgFileName]));
    end;

    bMipMap := FindCmdLineSwitch('mipmap');
    bAim := FindCmdLineSwitch('aim');
    wbFindCmdLineParam('height', s);
    Size := StrToIntDef(s, 0);
    // make sure that Size (height) is power of 2 for mipmaps
    if (Size > 0) and bMipMap then begin
      i := 1;
      while i < Size do i := i shl 1;
      Size := i;
    end;

    wbFindCmdLineParam('width', s);
    ForceWidth := StrToIntDef(s, 0);

    wbFindCmdLineParam('border', s);
    if (s <> '') and (s[Length(s)] = '%') then
      BorderPct := StrToFloatDef(Copy(s, 1, Length(s) - 1), 0.0)
    else
      Border := StrToIntDef(s, 2);

    wbFindCmdLineParam('maskdiff', s);
    MaskDiff := StrToIntDef(s, 0);
    wbFindCmdLineParam('contrast', s);
    s := StringReplace(s, ',', ',', []);
    Contrast := StrToFloatDef(s, 0.0);
    wbFindCmdLineParam('brightness', s);
    s := StringReplace(s, ',', ',', []);
    Brightness := StrToFloatDef(s, 0.0);

    wbFindCmdLineParam('format', s);
    ImgFormat := StrToImageFormat(s);

    try
      ddsProcess(Img, ChangeFileExt(ImgFileName, '.dds'));
      WriteLn('Done.');
    finally
      FreeImage(Img);
    end;
  except
    on E: Exception do
      Writeln('Error: ' + E.Message);
  end;
  //ReadLn;
end.

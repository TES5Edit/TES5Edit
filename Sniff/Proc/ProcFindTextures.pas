unit ProcFindTextures;

interface

uses
  System.Classes,
  System.SysUtils,

  Vcl.ComCtrls,
  Vcl.Controls,
  Vcl.ExtCtrls,
  Vcl.Forms,
  Vcl.Grids,
  Vcl.Mask,
  Vcl.Menus,
  Vcl.StdCtrls,
  Vcl.ValEdit,

  wbDDS,

  SniffProcessor;

type
  TFrameFindTextures = class(TFrame)
    StaticText1: TStaticText;
    lvFormat: TListView;
    edFormatFilter: TLabeledEdit;
    edProp: TValueListEditor;
    chkReportOnly: TCheckBox;
    menuFormats: TPopupMenu;
    mniCheckAll: TMenuItem;
    mniUncheckAll: TMenuItem;
    chkHeaderDump: TCheckBox;
    procedure lvFormatItemChecked(Sender: TObject; Item: TListItem);
    procedure edFormatFilterChange(Sender: TObject);
    procedure mniCheckAllClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    CheckedFormats: TDXGIs;
    procedure ShowFormats;
    procedure Init;
  end;

  TProcFindTextures = class(TProcBase)
  private
    Frame: TFrameFindTextures;
    fReportOnly: Boolean;
    fHeaderDump: Boolean;
    fFormats: TDXGIs;
    fResolution: Integer;
    fBitsPerPixel: Integer;
    fCompressed: string;
    fMipMaps: string;
    fHasAlpha: string;
    fCubeMap: string;
    fDX10: string;
    fXBOX: string;
  public
    constructor Create(aManager: TProcManager); override;
    function GetFrame(aOwner: TComponent): TFrame; override;
    procedure OnShow; override;
    procedure OnHide; override;
    procedure OnStart; override;

    function ProcessFile(aFile: TProcFileObject): TBytes; override;
  end;


implementation

{$R *.dfm}

uses
  System.Math,
  System.StrUtils,

  wbBSArchive,
  wbDataFormat,
  wbDataFormatMisc;

procedure TFrameFindTextures.edFormatFilterChange(Sender: TObject);
begin
  ShowFormats;
end;

procedure TFrameFindTextures.lvFormatItemChecked(Sender: TObject;
  Item: TListItem);
begin
  if Item.Checked then
    Include(CheckedFormats, TDXGI(Item.Data))
  else
    Exclude(CheckedFormats, TDXGI(Item.Data));
end;

procedure TFrameFindTextures.mniCheckAllClick(Sender: TObject);
begin
  var chk: Boolean := TMenuItem(Sender).Tag = 1;
  for var f in lvFormat.Items do begin
    f.Checked := chk;
    if chk then
      Include(CheckedFormats, TDXGI(f.Data))
    else
      Exclude(CheckedFormats, TDXGI(f.Data));
  end;
  lvFormat.Refresh;
end;

procedure TFrameFindTextures.ShowFormats;
begin
  var f := UpperCase(Trim(edFormatFilter.Text));
  lvFormat.Items.BeginUpdate;
  with TStringList.Create do try
    for var dxgi := Low(TDXGI) to High(TDXGI) do begin
      var fname := TwbDDS.GetDXGIFormatName(dxgi);
      case dxgi of
        DXGI_FORMAT_BC1_UNORM: fname := fname + ' [DXT1]';
        DXGI_FORMAT_BC2_UNORM: fname := fname + ' [DXT3]';
        DXGI_FORMAT_BC3_UNORM: fname := fname + ' [DXT5]';
      end;
      if (f = '') or (Pos(f, fname) <> 0) then
        AddObject(fname, Pointer(dxgi));
    end;
    Sort;
    lvFormat.Clear;
    for var i := 0 to Pred(Count) do
      with lvFormat.Items.Add do begin
        Caption := Strings[i];
        Data := Objects[i];
        Checked := TDXGI(Objects[i]) in CheckedFormats;
      end;
  finally
    Free;
    lvFormat.Items.EndUpdate;
  end;
end;

procedure TFrameFindTextures.Init;

  procedure AddProperty(const aName: string; const aPickList: TArray<string>);
  begin
    edProp.InsertRow(aName, '', True);
    with edProp.ItemProps[aName] do begin
      EditStyle := esPickList;
      ReadOnly := True;
      for var s in aPickList do
        PickList.Add(s);
    end;
  end;

begin
  ShowFormats;
  AddProperty('Resolution', ['', 'Not power of 2', '< 128', '< 256', '< 512', '< 1024', '< 2048', '< 4096', '>= 128', '>= 256', '>= 512', '>= 1024', '>= 2048', '>= 4096']);
  AddProperty('MipMaps', ['', 'Yes', 'No']);
  AddProperty('Has Alpha', ['', 'Yes', 'No']);
  AddProperty('CubeMap', ['', 'Yes', 'No']);
  AddProperty('BitsPerPixel', ['', '1', '4', '8', '12', '16', '24', '32', '64', '96', '128']);
  AddProperty('Block Compressed', ['', 'Yes', 'No']);
  AddProperty('DX10+ Supported', ['', 'Yes', 'No']);
  AddProperty('XBOX Texture', ['', 'Yes', 'No']);
end;

constructor TProcFindTextures.Create(aManager: TProcManager);
begin
  inherited;

  fTitle := 'Find textures';
  fSupportedGames := [gtTES3, gtTES4, gtFO3, gtFNV, gtTES5, gtSSE, gtFO4];
  fExtensions := ['dds'];
end;

function TProcFindTextures.GetFrame(aOwner: TComponent): TFrame;
begin
  Frame := TFrameFindTextures.Create(aOwner);
  Result := Frame;
end;

procedure TProcFindTextures.OnShow;
begin
  Frame.chkReportOnly.Checked := StorageGetBool('bReportOnly', Frame.chkReportOnly.Checked);
  Frame.chkHeaderDump.Checked := StorageGetBool('bHeaderDump', Frame.chkHeaderDump.Checked);
  Frame.edFormatFilter.Text := StorageGetString('sFormatFilter', Frame.edFormatFilter.Text);
  var s := StorageGetString('sFormats', '');
  try
    for var f in s.Split([',']) do
      Include(Frame.CheckedFormats, TDXGI(StrToInt(f)));
  except end;
  Frame.Init;
  with Frame.edProp.Strings do
    for var i := 0 to Pred(Count) do
      Frame.edProp.Values[Names[i]] := StorageGetString('s' + Names[i], '');
end;

procedure TProcFindTextures.OnHide;
begin
  StorageSetBool('bReportOnly', Frame.chkReportOnly.Checked);
  StorageSetBool('bHeaderDump', Frame.chkHeaderDump.Checked);
  StorageSetString('sFormatFilter', Frame.edFormatFilter.Text);
  var s := '';
  for var f in Frame.CheckedFormats do begin
    if s <> '' then s := s + ',';
    s := s + IntToStr(Integer(f));
  end;
  StorageSetString('sFormats', s);
  with Frame.edProp.Strings do
    for var i := 0 to Pred(Count) do
      StorageSetString('s' + Names[i], Values[Names[i]]);
end;

procedure TProcFindTextures.OnStart;
begin
  fReportOnly := Frame.chkReportOnly.Checked;
  fHeaderDump := Frame.chkHeaderDump.Checked;
  fFormats := Frame.CheckedFormats;
  // create definition, not safe when multithreaded
  if fReportOnly and fHeaderDump then TwbDDSFile.Create.Free;

  var s := Frame.edProp.Values['Resolution'];
  if s <> '' then begin
    if s = 'Not power of 2' then fResolution := 1
    else begin
      if s[1] = '<' then fResolution := -1 else fResolution := 1;
      s := Copy(s, Pos(' ', s) + 1, Length(s));
      fResolution := fResolution * StrToIntDef(s, 0);
    end;
  end else
    fResolution := 0;

  fMipMaps := Frame.edProp.Values['MipMaps'];
  fCompressed := Frame.edProp.Values['Block Compressed'];
  fHasAlpha := Frame.edProp.Values['Has Alpha'];
  fCubeMap := Frame.edProp.Values['CubeMap'];
  fBitsPerPixel := StrToIntDef(Frame.edProp.Values['BitsPerPixel'], 0);
  fDX10 := Frame.edProp.Values['DX10+ Supported'];
  fXBOX := Frame.edProp.Values['XBOX Texture'];
end;

function TProcFindTextures.ProcessFile(aFile: TProcFileObject): TBytes;

  function CheckBool(const aValue: string; aBool: Boolean): Boolean;
  begin
    Result := (aValue = '') or
      ( (aValue = 'Yes') and aBool ) or
      ( (aValue = 'No') and not aBool );
  end;

var
  bsa: TwbBSArchive;
  Log: TStringList;
  BA2DDS: Boolean;
  buf: TBytes;
  len: Integer;
  dds: PDDSHeader;
  fs: TFileStream;
  prop: record
    DXGIFormat: TDXGI;
    FormatName: string;
    Width: Integer;
    Height: Integer;
    Resolution: Integer;
    Size: Integer;
    BitsPerPixel: Integer;
    MipMaps: Boolean;
    Compressed: Boolean;
    Alpha: Boolean;
    CubeMap: Boolean;
    XBOX: Boolean;
  end;
begin
  Log := nil; fs := nil; len := 0;
  if Assigned(aFile.FileEntry) then
    bsa := aFile.FileEntry.Archive
  else
    bsa := nil;

  BA2DDS := Assigned(bsa) and TwbBSArchive.IsDDSArchive(bsa.ArchiveType);

  try

  // BA2 DDS texture, get all props from the archive entry
  if BA2DDS then begin
    prop.DXGIFormat := TDXGI(aFile.FileEntry.DDS.DXGIFormat);
    prop.FormatName := aFile.FileEntry.DXGIFormatName;
    prop.Width := aFile.FileEntry.DDS.Width;
    prop.Height := aFile.FileEntry.DDS.Height;
    prop.Size := SizeOf(TDDSHeader);
    for var c in aFile.FileEntry.TexChunks do Inc(prop.Size, c.Size);
    prop.BitsPerPixel := TwbDDS.GetBitsPerPixel(prop.DXGIFormat);
    prop.MipMaps := aFile.FileEntry.DDS.NumMips > 1;
    prop.CubeMap := aFile.FileEntry.IsCubeMap;
  end
  else begin
    // texture in ordinary archive, unpack entirely
    if Assigned(bsa) then begin
      buf := aFile.GetData;
      len := Length(buf);
    end
    // texture in loose file, read dds header only
    else begin
      fs := TFileStream.Create(fManager.InputDirectory + aFile.FileName, fmOpenRead + fmShareDenyNone);
      SetLength(buf, TwbDDS.MaxHeaderSize);
      len := fs.Read(buf, Length(buf));
    end;

    dds := Pointer(buf);
    if not TwbDDS.IsDDS(dds, len) then
      raise Exception.Create('Not a valid DDS file');

    prop.DXGIFormat := TwbDDS.GetDXGI(dds);
    prop.FormatName := TwbDDS.GetDXGIFormatName(prop.DXGIFormat);
    prop.Width := dds.dwWidth;
    prop.Height := dds.dwHeight;
    if Assigned(bsa) then prop.Size := len else prop.Size := fs.Size;
    prop.BitsPerPixel := TwbDDS.GetBitsPerPixel(prop.DXGIFormat);
    prop.MipMaps := dds.dwMipMapCount > 1;
    prop.CubeMap := TwbDDS.IsCubeMap(dds);
    prop.XBOX := TwbDDS.IsXBOX(dds);
    // no valid DXGI type, try D3DFMT
    if prop.DXGIFormat = DXGI_FORMAT_UNKNOWN then begin
      prop.FormatName := TwbDDS.GetD3DFMTFormatName(TwbDDS.GetD3DFMT(dds));
      prop.BitsPerPixel := dds.ddspf.dwRGBBitCount;
    end;
  end;

  prop.Resolution := Max(prop.Width, prop.Height);
  prop.Compressed := TwbDDS.IsCompressed(prop.DXGIFormat);
  prop.Alpha := TwbDDS.HasAlpha(prop.DXGIFormat);

  if not (
    ( (fFormats = []) or (prop.DXGIFormat in fFormats) ) and
    ( (fResolution = 0) or
      ( (fResolution = 1) and (not IsPowerOf2(prop.Width) or not IsPowerOf2(prop.Height)) ) or
      ( (fResolution > 1) and (prop.Resolution >= fResolution) ) or
      ( (fResolution < 0) and (prop.Resolution < -fResolution) )
    ) and
    ( (fBitsPerPixel = 0) or (prop.BitsPerPixel = fBitsPerPixel) ) and
    CheckBool(fMipMaps, prop.MipMaps) and
    CheckBool(fCompressed, prop.Compressed) and
    CheckBool(fHasAlpha, prop.Alpha) and
    CheckBool(fCubeMap, prop.CubeMap) and
    CheckBool(fDX10, prop.DXGIFormat <> DXGI_FORMAT_UNKNOWN) and
    CheckBool(fXBOX, prop.XBOX)
  ) then
    Exit;

  if fReportOnly then begin
    Log := TStringList.Create;
    Log.Add(aFile.FileName);
    Log.Add(Format(#9'Width: %04d  Height: %04d  Size: %s    %d Bit  %s  %s%s%s%s', [
      prop.Width,
      prop.Height,
      FormatSize(prop.Size),
      prop.BitsPerPixel,
      prop.FormatName,
      IfThen(prop.MipMaps, '  MipMaps', ''),
      IfThen(prop.Alpha, '  Alpha', ''),
      IfThen(prop.CubeMap, '  CubeMap', ''),
      IfThen(prop.XBOX, '  XBOX', '')
    ]));
    if fHeaderDump and not BA2DDS then with TwbDDSFile.Create do try
      UnSerialize(Pointer(buf), @buf[len], len);
      var js := '';
      // omit Magic field
      for var i := 1 to Pred(Count) do if Items[i].Enabled then
        // omit HEADER structs, just the fields
        for var el in Items[i] do
          js := js + el.ToJson(False) + #13;
      for var s in js.Split([#10, #13]) do
        if not ((Trim(s) = '') or (s = '{') or (s = '}') or s.Contains('dwSize') or s.Contains('dwCaps3') or s.Contains('dwCaps4') or s.Contains('Reserved')) then
          Log.Add(s);
    finally
      Free;
    end;
    Log.Add('');
    fManager.AddMessages(Log);
  end
  else begin
    if BA2DDS then
      buf := aFile.GetData
    else if Assigned(fs) then begin
      SetLength(buf, prop.Size);
      fs.Position := 0;
      fs.Read(buf, Length(buf));
    end;
    Result := buf;
  end;

  finally
    if Assigned(fs) then fs.Free;
    if Assigned(Log) then Log.Free;
  end;

end;


end.

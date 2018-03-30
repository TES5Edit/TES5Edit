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

program bsarch;

{$APPTYPE CONSOLE}

uses
  Classes,
  Types,
  SysUtils,
  IOUtils,
  wbBSArchive in 'wbBSArchive.pas',
  wbStreams in '..\..\wbStreams.pas';

const
  sVersion = '0.4';
  IMAGE_FILE_LARGE_ADDRESS_AWARE = $0020;

{$SetPEFlags IMAGE_FILE_LARGE_ADDRESS_AWARE}


//======================================================================
function wbFindCmdLineParam(const aSwitch     : string;
                            const aChars      : TSysCharSet;
                                  aIgnoreCase : Boolean;
                              out aValue      : string)
                                              : Boolean; overload;
var
  i : Integer;
  s : string;
begin
  Result := False;
  aValue := '';
  for i := 1 to ParamCount do begin
    s := ParamStr(i);
    if (aChars = []) or CharInSet(s[1], aChars) then
      if aIgnoreCase then begin
        if AnsiCompareText(Copy(s, 2, Length(aSwitch)), aSwitch) = 0 then begin
          if (length(s)>(length(aSwitch)+2)) and (s[Length(aSwitch) + 2] = ':') then begin
            aValue := Copy(s, Length(aSwitch) + 3, MaxInt);
            Result := True;
          end;
          Exit;
        end;
      end else
        if AnsiCompareStr(Copy(s, 2, Length(aSwitch)), aSwitch) = 0 then begin
          if s[Length(aSwitch) + 2] = ':' then begin
            aValue := Copy(s, Length(aSwitch) + 3, MaxInt);
            Result := True;
          end;
          Exit;
        end;
  end;
end;

//======================================================================
function wbFindCmdLineParam(const aSwitch : string;
                              out aValue  : string)
                                          : Boolean; overload;
begin
  Result := wbFindCmdLineParam(aSwitch, SwitchChars, True, aValue);
end;

//======================================================================
function HexToInt(s: string): Cardinal;
begin
  if SameText(Copy(s, 1, 2), '0x') then
    Delete(s, 1, 2);
  Result := StrToInt('$' + s);
end;


function IfThen(aCondition: Boolean; const aValue1, aValue2: string): string; inline;
begin
  if aCondition then Result := aValue1 else Result := aValue2;
end;

//======================================================================
// Info

var
  bExtendedDump: Boolean;

function IterShowFileInfo(bsa: TwbBSArchive; const aFileName: string;
  aFileRecord: Pointer; aFolderRecord: Pointer): Boolean;
var
  FileTES3: PwbBSFileTES3;
  FileTES4: PwbBSFileTES4;
  FileFO4: PwbBSFileFO4;
  s, z: string;
  i: integer;
begin
  Result := False;

  WriteLn(aFileName);

  if not bExtendedDump then
    Exit;

  case bsa.ArchiveType of

    baTES3: begin
      FileTES3 := aFileRecord;
      s := Format('  Hash1: %s  Hash2: %s  Size: %d', [
        IntToHex(FileTES3.Hash and $FFFFFFFF, 8),
        IntToHex(FileTES3.Hash shr 32, 8),
        FileTES3.Size
      ]);
      WriteLn(s);
    end;

    baTES4, baFO3, baSSE: begin
      FileTES4 := aFileRecord;
      if FileTES4.Compressed(bsa) then
        z := 'Packed' else z := '';
      s := Format('  DirHash: %s  NameHash: %s  %sSize: %d', [
        IntToHex(PwbBSFolderTES4(aFolderRecord).Hash, 8),
        IntToHex(FileTES4.Hash, 16),
        z,
        FileTES4.RawSize
      ]);
      if bsa.ArchiveType = baSSE then
        s := s + Format(#13#10'  DirUnknown: 0x%s', [IntToHex(PwbBSFolderTES4(aFolderRecord).Unk32, 8)]);
      WriteLn(s);
    end;

    baFO4, baFO4dds: begin
      FileFO4 := aFileRecord;
      s := Format('  DirHash: %s  NameHash: %s  Ext: %s', [
        IntToHex(FileFO4.DirHash, 8),
        IntToHex(FileFO4.NameHash, 8),
        string(FileFO4.Ext)
      ]);
      if bsa.ArchiveType = baFO4 then
        s := s + Format('  Unknown: 0x%s'#13#10'  Size: %d  PackedSize: %d', [
          IntToHex(FileFO4.Unknown, 8),
          FileFO4.Size,
          FileFO4.PackedSize
        ])
      else if bsa.ArchiveType = baFO4dds then begin
        s := s + Format(#13#10'  Width: %04d  Height: %04d  CubeMap: %s  Format: %s', [
          FileFO4.Width,
          FileFO4.Height,
          IfThen(FileFO4.CubeMaps and 1 <> 0, 'Yes', 'No'),
          FileFO4.DXGIFormatName
        ]);
        for i := Low(FileFO4.TexChunks) to High(FileFO4.TexChunks) do
          s := s + Format(#13#10'    MipMaps %.2d-%.2d  Size: %8d  PackedSize: %8d', [
            FileFO4.TexChunks[i].StartMip,
            FileFO4.TexChunks[i].EndMip,
            FileFO4.TexChunks[i].Size,
            FileFO4.TexChunks[i].PackedSize
          ]);
      end;
      WriteLn(s);
    end;

  end;

  WriteLn;
end;

procedure DoShowArchiveInfo(bsa: TwbBSArchive); overload;
const
  FlagNames: array [0..31] of string = (
    'NamedDir', 'NamedFiles', 'Compressed', 'RetainDir',
    'RetainName', 'RetainFOff', 'XBox360', 'StartupStr',
    'EmbedName', 'XMem', '', '',
    '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', ''
  );
  FileFlagNames: array [0..31] of string = (
    'NIF', 'DDS', 'XML', 'WAV',
    'MP3', 'TXT', 'SPT', 'FNT',
    'MISC', '', '', '',
    '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', ''
  );
var
  i: integer;
  s, s2: string;
begin
  // header
  WriteLn(Format('%014s: %s', ['Archive Name', bsa.FileName]));
  WriteLn(Format('%014s: %s', ['Format', bsa.FormatName]));
  if bsa.ArchiveType <> baTES3 then
    WriteLn(Format('%014s: 0x%s', ['Version', IntToHex(bsa.Version, 2)]));
  WriteLn(Format('%014s: %d', ['Files', bsa.FileCount]));
  // flags
  if bsa.ArchiveType in [baTES4, baFO3, baSSE] then begin
    WriteLn(Format('%014s: 0x%s%014s: 0x%s', [
      'Archive Flags', IntToHex(bsa.ArchiveFlags, 8),
      'File Flags', IntToHex(bsa.FileFlags, 8)
    ]));
    for i := 0 to 10 do begin
      if (bsa.ArchiveFlags shr i) and 1 = 1 then s := '*' else s := ' ';
      if FlagNames[i] <> '' then
        s := s + FlagNames[i]
      else
        s := s + 'Bit ' + IntToStr(i);
      s := Format('%17s%s', [' ', s]);

      if (bsa.FileFlags shr i) and 1 = 1 then s2 := '*' else s2 := ' ';
      if FileFlagNames[i] <> '' then
        s2 := s2 + FileFlagNames[i]
      else
        s2 := s2 + 'Bit ' + IntToStr(i);
      WriteLn(Format('%s%s%s', [s, StringOfChar(' ', 43 - Length(s)), s2]));
    end;
  end;
  // optional list or dump
  if FindCmdLineSwitch('list') or FindCmdLineSwitch('dump') then begin
    bExtendedDump := FindCmdLineSwitch('dump');
    WriteLn;
    bsa.IterateFiles(@IterShowFileInfo);
  end;
end;

//======================================================================
procedure DoShowArchiveInfo(const aArchiveName: string); overload;
var
  bsa: TwbBSArchive;
begin
  bsa := TwbBSArchive.Create;
  try
    try
      bsa.LoadFromFile(aArchiveName);
    except
      on E: Exception do begin
        WriteLn('Error: ' + E.Message);
        Exit;
      end;
    end;
    DoShowArchiveInfo(bsa);
  finally
    bsa.Free;
  end;
end;

//======================================================================
// Packing

var
  DDSRoot: string;

procedure GetDDSFileInfo(aArchive: TwbBSArchive; const aFileName: string;
  var aInfo: TDDSInfo);
var
  DDSHeader: TDDSHeader;
begin
  with TFileStream.Create(DDSRoot + aFileName, fmOpenRead + fmShareDenyNone) do try
    if (Read(DDSHeader, SizeOf(DDSHeader)) <> SizeOf(DDSHeader)) or (DDSHeader.Magic <> 'DDS ') then
      raise Exception.Create('Not a valid DDS file: ' + DDSRoot + aFileName);

    aInfo.Width := DDSHeader.dwWidth;
    aInfo.Height := DDSHeader.dwHeight;
    aInfo.MipMaps := DDSHeader.dwMipMapCount;
  finally
    Free;
  end;
end;

procedure DoPack(const aFolderName, aArchiveName: string);
var
  root, s, ext, mask: string;
  i: integer;
  atype: TBSArchiveType;
  sl: TStringList;
  bsa: TwbBSArchive;
begin
  root := IncludeTrailingPathDelimiter(aFolderName);

  if FindCmdLineSwitch('tes3') then atype := baTES3 else
  if FindCmdLineSwitch('tes4') then atype := baTES4 else
  if FindCmdLineSwitch('fo3')  then atype := baFO3 else
  if FindCmdLineSwitch('fnv')  then atype := baFO3 else
  if FindCmdLineSwitch('tes5') then atype := baFO3 else
  if FindCmdLineSwitch('sse')  then atype := baSSE else
  if FindCmdLineSwitch('fo4')  then atype := baFO4 else
  if FindCmdLineSwitch('fo4dds') then atype := baFO4dds
  else
    raise Exception.Create('Archive type is not provided for packing!');

  sl := TStringList.Create;
  bsa := TwbBSArchive.Create;
  try
    if FindCmdLineSwitch('z', s) then
      bsa.Compress := True;

    if atype = baFO4dds then begin
      mask := '*.dds';
      bsa.DDSInfoProc := GetDDSFileInfo;
      DDSRoot := root;
    end else
      mask := '*.*';

    WriteLn('Packing directory: ' + root + mask);

    for s in TDirectory.GetFiles(root, mask, TSearchOption.soAllDirectories) do begin
      // skip files in the root folder
      if SameText(root, ExtractFilePath(s)) then
        Continue;

      // always skipped files
      ext := LowerCase(ExtractFileExt(s));
      if (ext = '') or (ext = '.exe') or (ext = '.bsa') or (ext = '.ba2') or (ext = '.db') then
        Continue;

      sl.Add(Copy(s, Succ(Length(root)), Length(s)));
    end;

    if sl.Count = 0 then
      raise Exception.Create('No valid files found for packing');

    try
      bsa.CreateArchive(aArchiveName, atype, sl);
    except
      on E: Exception do
        raise Exception.Create('Archive creation error: ' + E.Message);
    end;

    // custom archive flags
    if wbFindCmdLineParam('af', s) and (s <> '') then
      bsa.ArchiveFlags := HexToInt(s);

    // custom file flags
    if wbFindCmdLineParam('ff', s) and (s <> '') then
      bsa.FileFlags := HexToInt(s);

    WriteLn;
    DoShowArchiveInfo(bsa);
    WriteLn;

    for i := 0 to Pred(sl.Count) do begin
      try
        bsa.AddFile(root, root + sl[i]);
      except
        on E: Exception do
          raise Exception.Create('File packing error "' + root + sl[i] + '": ' + E.Message);
      end;
      if (i mod 10 = 0) or (i = Pred(sl.Count)) then
        Write(#13'[' + IntToStr(Round((i+1)/sl.Count*100)) + '%]');
    end;

    try
      bsa.Save;
    except
      on E: Exception do
        raise Exception.Create('Archive saving error: ' + E.Message);
    end;

    WriteLn;
    WriteLn('Done.');
  finally
    bsa.Free;
    sl.Free;
  end;
end;

//======================================================================
// Unpacking

var
  UnpackDir: string; // store root folder for unpacking

function IterUnpackFile(bsa: TwbBSArchive; const aFileName: string;
  aFileRecord: Pointer; aFolderRecord: Pointer): Boolean;
var
  dir, fname: string;
  FileData: TBytes;
begin
  // fo4 archives can contain backslashes
  fname := StringReplace(aFileName, '/', '\', [rfReplaceAll]);

  dir := UnpackDir + ExtractFilePath(fname);
  if not DirectoryExists(dir) then
    if not ForceDirectories(dir) then
      raise Exception.Create('Can not create destination folder: ' + dir);

  try
    FileData := bsa.ExtractFileData(aFileRecord);
  except
    on E: Exception do
      raise Exception.Create('Unpacking error "' + fname + '": ' + E.Message);
  end;

  with TFileStream.Create(UnpackDir + fname, fmCreate) do try
    Write(FileData[0], Length(FileData));
  finally
    Free;
  end;

  WriteLn(fname);
  Result := False;
end;

procedure DoUnpack(const aArchiveName, aFolderName: string);
var
  bsa: TwbBSArchive;
begin
  UnpackDir := IncludeTrailingPathDelimiter(aFolderName);
  if not DirectoryExists(UnpackDir) then
    raise Exception.Create('Folder does not exist: ' + UnpackDir);

  WriteLn('Unpacking archive: "' + aArchiveName + '" into "' + UnpackDir + '"');
  WriteLn;

  bsa := TwbBSArchive.Create;
  try
    bsa.LoadFromFile(aArchiveName);
    bsa.IterateFiles(@IterUnpackFile);
    WriteLn('');
    WriteLn('Done.');
  finally
    bsa.Free;
  end;
end;

//======================================================================
procedure Main;
begin
  WriteLn('');
  WriteLn('BSArch v' + sVersion + ' by zilav');
  WriteLn('Packer and unpacker for Bethesda Game Studios archive files');
  WriteLn;

  if (ParamCount >= 3) and SameText(ParamStr(1), 'pack') then
    DoPack(ParamStr(2), ParamStr(3))

  else if (ParamCount >= 2) and SameText(ParamStr(1), 'unpack') then begin
    if ParamCount >= 3 then
      DoUnpack(ParamStr(2), ParamStr(3))
    else
      DoUnpack(ParamStr(2), ExtractFilePath(ParamStr(2)));
  end

  else if (ParamCount >= 1) and not CharInSet(ParamStr(1)[1], SwitchChars) then
    DoShowArchiveInfo(ParamStr(1))

  else begin
    WriteLn('ARCHIVE INFO');
    WriteLn('  bsarch.exe <archive> [parameters]');
    WriteLn('  <archive> - archive file name to view');
    WriteLn('  additional parametes: -list to show files list or -dump for extended dump');
    WriteLn('');
    WriteLn('UNPACKING ARCHIVES');
    WriteLn('  bsarch.exe unpack <archive> <folder>');
    WriteLn('  <archive> - archive file name to unpack');
    WriteLn('  <folder>  - path to the existing destination folder to unpack into');
    WriteLn('              When not set unpack into the folder where archive is located');
    WriteLn('');
    WriteLn('CREATING ARCHIVES');
    WriteLn('  bsarch.exe pack <folder> <archive> [parameters]');
    WriteLn('  <folder>  - path to the source folder with files to pack');
    WriteLn('  <archive> - archive file name to create');
    WriteLn('  Parameters:');
    WriteLn('  -tes3       Morrowind archive format');
    WriteLn('  -tes4       Oblivion archive format');
    WriteLn('  -fo3        Fallout 3 archive format');
    WriteLn('  -fnv        Fallout: New Vegas archive format');
    WriteLn('  -tes5       Skyrim LE archive format (fo3/fnv/tes5 are technically the same)');
    WriteLn('  -sse        Skyrim Special Edition archive format');
    WriteLn('  -fo4        Fallout 4 General archive format');
    WriteLn('  -fo4dds     Fallout 4 DDS archive format (streamed DDS textures mipmaps)');
    WriteLn('  -af:value   Override archive flags with a hex value');
    WriteLn('              Oblivion, Fallout 3/NV and Skyrim LE archives only');
    WriteLn('  -ff:value   Override files flags with a hex value');
    WriteLn('              Oblivion, Fallout 3/NV and Skyrim LE archives only');
    WriteLn('  -z          Compress archive. This will also force "Compressed" flag');
    WriteLn('              in archive flags even if they are overridden with -af');
    WriteLn('              parameter custom value. Keep in mind that sounds and voices');
    WriteLn('              don''t work in compressed archives in all Bethesda games!');
    WriteLn('              Even if your archive contains a single sound/voice file');
    WriteLn('              out of thousands, it must be uncompressed.');
    WriteLn('');
    WriteLn('EXAMPLES');
    WriteLn('    If <folder> or <archive> include spaces then embed them in quotes');
    WriteLn('');
    WriteLn('  * Show archive info including hex flags values to be used with -af and -ff');
    WriteLn('      bsarch d:\somepath\somefile.bsa');
    WriteLn('  * Dump extended files information from archive');
    WriteLn('      bsarch "d:\game\mod - main.bsa" -dump');
    WriteLn('  * Unpack archive into the same folder where archive is located');
    WriteLn('      bsarch unpack d:\mymod\new.bsa');
    WriteLn('  * Unpack archive into the specified folder');
    WriteLn('      bsarch unpack d:\mymod\new.bsa "d:\unpacked archive\data"');
    WriteLn('  * Create Skyrim Special Edition compressed archive');
    WriteLn('      bsarch pack "d:\my mod\data" "d:\my mod\data\new.bsa" -sse -z');
    WriteLn('  * Create Fallout New Vegas uncompressed archive with custom flags');
    WriteLn('      bsarch pack "d:\my mod\data" "d:\my mod\new.bsa" -fnv -af:0x83 -ff:0x113');
    WriteLn('  * Create Fallout 4 uncompressed textures archive');
    WriteLn('      bsarch pack "d:\my mod\data" "d:\my mod\new.ba2" -fo4dds');

  end;
end;

{
function IterFilesTES3(bsa: TwbBSArchive; const aFileName: string;
  aFileRecord: Pointer; aFolderRecord: Pointer): Boolean;
var
  filerec: PwbBSFileTES3;
begin
  filerec := aFileRecord;
  //sl.AddObject(filerec.Name, TObject(filerec.Offset));
  Result := False;
end;

function IterFilesTES4(bsa: TwbBSArchive; const aFileName: string;
  aFileRecord: Pointer; aFolderRecord: Pointer): Boolean;
var
  filerec: PwbBSFileTES4;
  h: UInt64;
begin
  filerec := aFileRecord;
  h := CreateHashTES4(filerec.Name);
  if h <> filerec.Hash then
    WriteLn( IntToHex(filerec.Hash, 16), #9, IntToHex(h, 16), #9, filerec.Name);

  Result := False;
end;

function IterFilesFO4(bsa: TwbBSArchive; const aFileName: string;
  aFileRecord: Pointer; aFolderRecord: Pointer): Boolean;
var
  filerec: PwbBSFileFO4;
  d, fname, f, e: string;
  h: Cardinal;
begin
  filerec := aFileRecord;
  SplitDirName(filerec.Name, d, fname);
  SplitNameExt(fname, f, e);

  h := CreateHashFO4(d);
  if h <> filerec.DirHash then
    WriteLn( IntToHex(filerec.DirHash, 8), #9, IntToHex(h, 8), #9, d);

  h := CreateHashFO4(f);
  if h <> filerec.NameHash then
    WriteLn( IntToHex(filerec.NameHash, 8), #9, IntToHex(h, 8), #9, f);

  Result := False;
end;

function IterDumpFileFO4(bsa: TwbBSArchive; const aFileName: string;
  aFileRecord: Pointer; aFolderRecord: Pointer): Boolean;
var
  filerec: PwbBSFileFO4;
begin
  filerec := aFileRecord;
  WriteLn(filerec.Name);
  WriteLn(Format('Width: %d, Height: %d, DXGI: %d', [filerec.Width, filerec.Height, filerec.DXGIFormat]));
  WriteLn;
  Result := False;
end;


procedure test_hashes;
var
  bsa: TwbBSArchive;
begin
  bsa := TwbBSArchive.Create;
  bsa.LoadFromFile('d:\games\Morrowind\Data Files\Tribunal.bsa');
  //bsa.IterateFiles(@IterFilesTES3);

  //bsa.LoadFromFile(ExtractFilePath(ParamStr(0)) + '0x69_ASCII.bsa');
  //bsa.LoadFromFile('d:\games\oblivion\data\Oblivion - Sounds.bsa');
  //bsa.IterateFiles(@IterFilesTES4);

  //bsa.LoadFromFile(ExtractFilePath(ParamStr(0)) + 'GNRL_ASCII.ba2');
  //bsa.LoadFromFile('d:\games\fallout4\data\DLCNukaWorld - Main.ba2');
  //bsa.IterateFiles(@IterFilesFO4);

  //bsa.LoadFromFile('d:\games\fallout4\data\HuntingShotgun - Textures.ba2');
  //bsa.IterateFiles(@IterDumpFileFO4);

  bsa.Free;
  //WriteLn('Done.');
end;

procedure test_reading;
var
  ba: TwbBSArchive;
  //fname: string;
begin
  ba := TwbBSArchive.Create;
  //ba.LoadFromFile('d:\games\skyrim\data\skyrim - textures.bsa');
  //fname := 'textures\clutter\food\grilledleek01.dds';

  //ba.LoadFromFile('e:\games\Steam\steamapps\common\Skyrim Special Edition\Data\ccqdrsse001-survivalmode.bsa');
  //ba.LoadFromFile('d:\games\oblivion\data\Alluring Wine Bottles.bsa');
  //ba.LoadFromFile('d:\games\oblivion\data\Alluring Wine Bottles.bsa');

  // textures\weapons\huntingshotgun\sight_d.dds
  //ba.LoadFromFile('d:\games\fallout4\data\Fallout4 - Meshes.ba2');

  ba.LoadFromFile('d:\games\Morrowind\Data Files\Tribunal.bsa');

  //ba.ExtractFile(fname, ExtractFilePath(ParamStr(0)) + ExtractFileName(fname));
  ba.Free;
end;

procedure test_creating;
var
  ba: TwbBSArchive;
  sl: TStringList;
  root, s: string;
  i: integer;
begin
  sl := TStringList.Create;
  ba := TwbBSArchive.Create;
  //ba.Compress := True;

  root := 'e:\3';
  root := IncludeTrailingPathDelimiter(root);
  for s in TDirectory.GetFiles(root, '*.*', TSearchOption.soAllDirectories) do
    // skip files in the root folder
    if not SameText(root, ExtractFilePath(s)) then
      sl.Add(Copy(s, Succ(Length(root)), Length(s)));

  //ba.CreateArchive('e:\1\a.bsa', baFO3, sl);
  ba.CreateArchive('e:\3\a.bsa', baTES3, sl);
  //ba.ArchiveFlags := 0;

  for i := 0 to sl.Count - 1 do
    ba.AddFile(root, root + sl[i]);

  ba.Save;

  ba.Free;
  sl.Free;
end;
}

begin
  try
    //ReportMemoryLeaksOnShutDown := True;

    //test_reading;
    //test_creating;
    //test_hashes;
    Main;
  except
    on E: Exception do begin
      Writeln(E.ClassName, ': ', E.Message);
      System.ExitCode := 1;
    end;
  end;
  //ReadLn;
end.

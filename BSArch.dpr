{******************************************************************************

  This Source Code Form is subject to the terms of the Mozilla Public License,
  v. 2.0. If a copy of the MPL was not distributed with this file, You can obtain
  one at https://mozilla.org/MPL/2.0/.

*******************************************************************************}

{$I baDefines.inc}

{$IFDEF EXCEPTION_LOGGING_ENABLED}
// JCL_DEBUG_EXPERT_GENERATEJDBG OFF
// JCL_DEBUG_EXPERT_INSERTJDBG ON
// JCL_DEBUG_EXPERT_DELETEMAPFILE ON
{$ENDIF}

program BSArch;

{$APPTYPE CONSOLE}

uses
  MSHeap,
  {$IFDEF EXCEPTION_LOGGING_ENABLED}
  nxExceptionHook,
  {$ENDIF }
  System.Diagnostics,
  System.Math,
  System.SyncObjs,
  System.SysUtils,
  System.Threading,

  wbBSArchive in 'Core\wbBSArchive.pas',
  wbCommandLine in 'Core\wbCommandLine.pas',
  wbCompression in 'Core\wbCompression.pas',
  wbDDS in 'Core\wbDDS.pas',
  wbHash in 'Core\wbHash.pas',
  wbStreams in 'Core\wbStreams.pas';

const
  IMAGE_FILE_LARGE_ADDRESS_AWARE = $0020;

{$SetPEFlags IMAGE_FILE_LARGE_ADDRESS_AWARE}

type
  EInvalidArguments = class(Exception);

var
  Sync: TLightweightMREW;
  Processed: Integer = 0;
  ProcessedError: string;

//======================================================================
function HexToInt(s: string): Cardinal;
begin
  if SameText(Copy(s, 1, 2), '0x') then
    Delete(s, 1, 2);
  Result := StrToInt('$' + s);
end;

//======================================================================
function IfThen(aCondition: Boolean; const aValue1, aValue2: string): string; inline;
begin
  if aCondition then Result := aValue1 else Result := aValue2;
end;

//======================================================================
procedure ShowProgress(Count: Integer);
begin
  var step := Count div 100;
  if step < 10 then step := 10;

  Sync.BeginWrite;
  try
    Inc(Processed);
    if (Processed mod step = 0) or (Processed = Pred(Count)) then
      Write(#13 + Round(Succ(Processed)/Count*100).ToString + '%');
  finally
    Sync.EndWrite;
  end;
end;

//======================================================================
procedure SetError(const aText: string);
begin
  Sync.BeginWrite;
  try
    if ProcessedError = '' then
      ProcessedError := aText;
  finally
    Sync.EndWrite;
  end;
end;

//======================================================================
procedure DoInfo;
var
  bsa: TwbBSArchive;
begin
  bsa := TwbBSArchive.Create;
  try
  try
    bsa.LoadFromFile(ParamStr(1));
    WriteLn(bsa.Info);
    for var w in bsa.Warnings do
      WriteLn(#9'Warning: ', w);

    if not (FindCmdLineSwitch('list') or FindCmdLineSwitch('dump')) then
      Exit;

    WriteLn;
    var bDump := FindCmdLineSwitch('dump');
    for var f in bsa do begin
      WriteLn(f.Name);
      if bDump then begin
        WriteLn(f.Info);
        WriteLn;
      end;
    end;
  except
    on E: Exception do
      WriteLn('Error: ' + E.Message);
  end;
  finally
    bsa.Free;
  end;
end;

//======================================================================
procedure DoPack;
const
  GB = 1024 * 1024 * 1024;
var
  bsa: TwbMultiSourcePacker;
  atype: TwbBSArchiveType;
  s: string;
begin
  s := ParamStr(2);
  if (s = '') or CharInSet(s[1], SwitchChars) then
    raise EInvalidArguments.Create('No source files/folders/archives provided for packing');

  s := ParamStr(3);
  if (s = '') or CharInSet(s[1], SwitchChars) then
    raise EInvalidArguments.Create('No archive name provided for packing');

  if FindCmdLineSwitch('tes3')   then atype := baTES3 else
  if FindCmdLineSwitch('tes4')   then atype := baTES4 else
  if FindCmdLineSwitch('fo3')    then atype := baFO3 else
  if FindCmdLineSwitch('fnv')    then atype := baFO3 else
  if FindCmdLineSwitch('tes5')   then atype := baFO3 else
  if FindCmdLineSwitch('sse')    then atype := baSSE else
  if FindCmdLineSwitch('fo4')    then atype := baFO4 else
  if FindCmdLineSwitch('fo4dds') then atype := baFO4dds else
  if FindCmdLineSwitch('sf1')    then atype := baSF else
  if FindCmdLineSwitch('sf1dds') then atype := baSFdds else
    raise EInvalidArguments.Create('No archive type (game) provided for packing');

  bsa := TwbMultiSourcePacker.Create;
  try
    if (atype <> baTES3) and wbFindCmdLineParam('z', s) then begin
      if s <> '' then begin
        var ct := TwbCompression.TypeByName(s);
        if ct = ctNone then
          raise EInvalidArguments.Create('Unknown compression type ' + s);
        if not bsa.SupportsCompression(atype, ct) then
          raise EInvalidArguments.Create(bsa.FormatName(atype) + ' archives don''t support ' + s + ' compression');
        bsa.CompressionType := ct;
      end else
        bsa.CompressionType := bsa.DefaultCompression(atype);

      bsa.Compress := True;
    end;

    if wbFindCmdLineParam('split', s) and (s <> '') then begin
      var split := StrToIntDef(s, 0);
      if split > 8 then split := 8;
      bsa.SplitSize := Int64(split) * GB;
    end else
      if atype < baFO4 then bsa.SplitSize := bsa.BSA_MAX_OFFSET;

    if wbFindCmdLineParam('f', s) and (s <> '') then
      bsa.Filters := s.Split([',']);

    bsa.ShareData := not (wbFindCmdLineParam('share', s) and SameText(s, 'no'));
    bsa.MultiThreaded := not (wbFindCmdLineParam('mt', s) and SameText(s, 'no'));

    if wbFindCmdLineParam('af', s) and (s <> '') then
      bsa.ArchiveFlags := HexToInt(s);
    if wbFindCmdLineParam('ff', s) and (s <> '') then
      bsa.FileFlags := HexToInt(s);

    WriteLn(Format('Packing %s archive: Split: %s,  Compress: %s,  Share: %s', [
      bsa.FormatName(atype),
      IfThen(bsa.SplitSize <> 0, FormatSize(bsa.SplitSize), 'No'),
      IfThen(bsa.Compress, TwbCompression.cCompressionTypeName[bsa.CompressionType], 'No'),
      IfThen(bsa.ShareData, 'Yes', 'No')
    ]));

    for var f in ParamStr(2).Split(['+'], '"') do begin
      Write('Adding source: ' + f);
      var i := bsa.AddSource(f);
      WriteLn('  ' + i.ToString + ' file(s)');
    end;

    if bsa.SourceFilesCount = 0 then
      raise EInvalidArguments.Create('No valid source file(s) found.');

    bsa.CreateArchive(ParamStr(3), atype);

    WriteLn(Format('%sthreaded packing: %s file(s)...', [
      IfThen(bsa.MultiThreaded, 'Multi', 'Single'),
      bsa.SourceFilesCount.ToString
    ]));

    var sw := TStopwatch.StartNew;
    if bsa.MultiThreaded then
      TParallel.&For(0, Pred(bsa.ProcessCount),
        procedure(i: Integer; LoopState: TParallel.TLoopState)
        begin
          try
            bsa.Process;
            ShowProgress(bsa.ProcessCount);
          except
            on E: Exception do begin
              SetError(E.Message);
              LoopState.Stop;
            end;
          end;
        end
      )
    else
      for var i := 0 to Pred(bsa.ProcessCount) do try
        bsa.Process;
        ShowProgress(bsa.ProcessCount);
      except
        on E: Exception do begin
          SetError(E.Message);
          Break;
        end;
      end;

    if ProcessedError <> '' then begin
      WriteLn;
      WriteLn(ProcessedError);
      System.ExitCode := 1;
      Exit;
    end;

    try
      bsa.Save;
    except
      on E: Exception do
        raise Exception.Create('Archive saving error: ' + E.Message);
    end;
    sw.Stop;

    WriteLn;
    WriteLn('Done in ', sw.Elapsed.ToString, '.');
    WriteLn;
    WriteLn('Created archives:');
    for var b in bsa.Archives do begin
      Write(Format('%s   %s  %d files', [b.FileName, FormatSize(b.ArchiveSize), b.Count]));
      if b.ArchiveSharedFiles <> 0 then
        Write(Format('  %d shared saving %s', [b.ArchiveSharedFiles, FormatSize(b.ArchiveSharedSize)]));
      WriteLn;
      for var w in b.Warnings do
        WriteLn(#9'Warning: ', w);
    end;

    WriteLn;
  finally
    bsa.Free;
  end;
end;

//======================================================================
procedure DoUnpack;
var
  bsa: TwbBSArchive;
  s, bsaname, folder: string;
begin
  s := ParamStr(2);
  if (s = '') or CharInSet(s[1], SwitchChars) then
    raise EInvalidArguments.Create('No archive file provided for unpacking')
  else
    bsaname := s;

  s := ParamStr(3);
  if (s = '') or CharInSet(s[1], SwitchChars) then
    folder := ExtractFilePath(bsaname)
  else begin
    folder := IncludeTrailingPathDelimiter(s);
    if not DirectoryExists(folder) then
      raise EInvalidArguments.Create('Folder does not exist: ' + folder);
  end;

  bsa := TwbBSArchive.Create;
  try
    bsa.LoadFromFile(bsaname);
    bsa.MultiThreaded := not (wbFindCmdLineParam('mt', s) and SameText(s, 'no'));

    var sw := TStopwatch.StartNew;
    WriteLn(Format('Unpacking archive "%s" into "%s"', [bsaname, folder]));
    WriteLn(Format('%sthreaded unpacking: %s file(s)...', [
      IfThen(bsa.MultiThreaded, 'Multi', 'Single'),
      bsa.Count.ToString
    ]));

    // create folders
    for var f in bsa do begin
      var dir := folder + ExtractFilePath(f.Name);
      if not DirectoryExists(dir) then
        if not ForceDirectories(dir) then
          raise Exception.Create('Can''t create destination folder: ' + dir);
    end;

    if bsa.MultiThreaded then
      TParallel.For(0, Pred(bsa.Count),
        procedure(i: Integer; LoopState: TParallel.TLoopState)
        begin
          try
            bsa.Unpack(bsa[i].Name, folder + bsa[i].Name);
            ShowProgress(bsa.Count);
          except
            on E: Exception do begin
              SetError(Format('Error processing "%s": %s', [bsa[i].Name, E.Message]));
              LoopState.Stop;
            end;
          end;
        end
      )
    else
      for var i := 0 to Pred(bsa.Count) do try
        bsa.Unpack(bsa[i].Name, folder + bsa[i].Name);
        ShowProgress(bsa.Count);
      except
        on E: Exception do begin
          SetError(Format('Error processing "%s": %s', [bsa[i].Name, E.Message]));
          Break;
        end;
      end;

    sw.Stop;
    WriteLn;
    if ProcessedError <> '' then begin
      WriteLn(ProcessedError);
      System.ExitCode := 1;
    end else
      WriteLn('Done in ', sw.Elapsed.ToString, '.');
  finally
    bsa.Free;
  end;
end;

//======================================================================
procedure Main;
begin
  {$IFDEF EXCEPTION_LOGGING_ENABLED}
  nxEHAppVersion := 'BSArch v' + cBSArchVersion;
  {$ENDIF}
  WriteLn('');
  WriteLn('BSArch v' + cBSArchVersion{$IFDEF WIN64} + ' x64'{$ENDIF WIN64} + ' by zilav, ElminsterAU, Sheson');
  WriteLn('''
  Packer and unpacker for Bethesda Game Studios archive files

  The Source Code Form is subject to the terms of the Mozilla Public License, v2.0.
  If a copy of the MPL was not distributed with this file, You can obtain one at
  https://mozilla.org/MPL/2.0/
  The Source Code Form is available at https://github.com/TES5Edit/TES5Edit

  ''');

  // at least one parameter and it's not a switch
  if (ParamCount >= 1) and not CharInSet(ParamStr(1)[1], SwitchChars) then begin
    if SameText(ParamStr(1), 'pack') then DoPack else
    if SameText(ParamStr(1), 'unpack') then DoUnpack else
    if FileExists(ParamStr(1)) then DoInfo else
      raise EInvalidArguments.Create('The first parameter must be "pack", "unpack" or existing archive file');

    Exit;
  end;

  WriteLn('''
  PACK ARCHIVE
    BSArch.exe pack <source1+source2+...> <archive> [parameters]
    <sources>    Path to the source folder, file or archive with file(s) to pack
                 Multiple sources can be provided using + without spaces
                 Files from later source win on matched file names
    <archive>    Archive file name to create
    -tes3        Morrowind archive format
    -tes4        Oblivion archive format
    -fo3         Fallout 3 archive format
    -fnv         Fallout: New Vegas archive format
    -tes5        Skyrim LE archive format (fo3/fnv/tes5 are the same)
    -sse         Skyrim SE/AE archive format
    -fo4         Fallout 4 General archive format
    -fo4dds      Fallout 4 DDS archive format (streamed DDS textures mipmaps)
                 Always compress using -z parameter, game crashes otherwise
    -sf1         Starfield General archive format
    -sf1dds      Starfield DDS archive format (streamed DDS textures mipmaps)
    -split:N     Split archives by N GB, 0 disables splitting
                 Don't use values larger than available free memory
                 When not set BSA archives are split by 2 GB, BA2 aren't split
                 Games before Fallout 4 have hardcoded 2 GB limit!
    -z:type      Compress files in archive using provided compression type:
                 zlib, lz4 or lz4f
                 When type is omitted use default compression for the game
                 Strings and audio files (except .fuz) are not compressed
    -f:filters   Pack files only matching provided mask(s) separated by comma
    -share:yes|no Identical files will share the same data in archive to preserve space
                 "no" to disable sharing, default: yes
    -mt:yes|no   Use available CPU cores for faster multithreaded processing
                 "no" to disable multithreading, default: yes
    -af:value    Override archive flags with a hex value
                 Oblivion, Fallout 3/NV and Skyrim archives only
    -ff:value    Override file flags with a hex value
                 Oblivion, Fallout 3/NV and Skyrim archives only

  UNPACK ARCHIVE
    BSArch.exe unpack <archive> [folder] [parameters]
    <archive>    Archive file name to unpack
    [folder]     Path to the existing destination folder to unpack into
                 When not set unpack into the folder where archive is located
    -mt:yes|no   Use available CPU cores for faster multithreaded processing
                 "no" to disable multithreading, default: yes

  ARCHIVE INFO
    BSArch.exe <archive> [parameters]
    <archive>    Archive file name
    -list        Show files list
    -dump        Extended dump

  EXAMPLES
    If <folder> or <archive> include spaces then embed them in quotes

    * Create Skyrim SE/AE compressed archive with meshes only, split by 2 GB
        BSArch pack "d:\Skyrim AE\data" "d:\Skyrim AE\data\new.bsa" -sse -z -f:*.nif,*.hkx
    * Create Fallout NV uncompressed archive from multiple folders using custom flags, split by 2 GB
        BSArch pack "c:\FNV files\meshes"+d:\new\textures "d:\somewhere\mod.bsa" -fnv -af:0x83 -ff:0x113
    * Merge archives and overwrite with files from folder, compress with lz4, split by 4 GB
        BSArch pack "d:\mod\main.ba2"+"d:\mod\update.ba2"+"d:\mod\data" "d:\mod\new.ba2" -sf1 -z:lz4 -split:4
    * Decompress archive (repack without compression)
        BSArch pack "e:\Oblivion\Data\Textures - Compressed.bsa" "e:\Oblivion\Data\Textures.bsa" -tes4
    * Unpack archive into the same folder where archive is located
        BSArch unpack d:\mymod\new.bsa
    * Unpack archive into the specified folder
        BSArch unpack d:\mymod\new.bsa "d:\unpacked archive\data"
    * Show archive info including hex flags values to be used with -af and -ff
        BSArch d:\somepath\somefile.bsa
    * Dump extended files information from archive
        BSArch "d:\game\mod - main.bsa" -dump
  ''');

end;

{
procedure test_hashes;
var
  bsa: TwbBSArchive;
begin
  bsa := TwbBSArchive.Create;
  //bsa.LoadFromFile('d:\games\Morrowind\Data Files\Tribunal.bsa');
  //bsa.LoadFromFile('d:\games\oblivion\data\Oblivion - Sounds.bsa');
  //bsa.LoadFromFile('d:\Projects\TES5Edit\Tools\BSArchive\Knights.bsa');
  //bsa.LoadFromFile('d:\1\nord.bsa');
  //bsa.LoadFromFile('d:\1\test.ba2');
  //bsa.LoadFromFile('d:\Games\steamapps\common\Skyrim Special Edition\Data\Skyrim - Voices_en0.bsa');
  bsa.LoadFromFile('d:\Games\steamapps\common\Fallout 4\Data\Fallout4 - Voices.ba2');
  //bsa.LoadFromFile('d:\Games\steamapps\common\Fallout 4\Data\DLCRobot - Textures.ba2');
  //bsa.LoadFromFile('d:\Projects\TES5Edit\Tools\BSArchive\0x68_ASCII.bsa');
  //bsa.LoadFromFile('d:\Projects\TES5Edit\Tools\BSArchive\0x69_ASCII.bsa');
  //bsa.LoadFromFile('d:\Projects\TES5Edit\Tools\BSArchive\GNRL_ASCII.ba2');

  for var f in bsa do
    case bsa.ArchiveType of

      baTES3: begin
        var hash := TwbHash.TES3(f.Name);
        if hash <> f.NameHash64 then begin
          WriteLn(f.Name);
          WriteLn(f.NameHash64.ToHexString);
          WriteLn(hash.ToHexString);
          //Exit;
        end;
      end;

      baTES4: begin
        var dirhash := TwbHash.TES4(ExcludeTrailingPathDelimiter(ExtractFilePath(f.Name)));
        var namehash := TwbHash.TES4(ExtractFileName(f.Name), True);
        if (dirhash <> f.DirHash64) or (namehash <> f.NameHash64) then begin
          WriteLn(f.Name);
          WriteLn(f.DirHash64.ToHexString, ' ', f.NameHash64.ToHexString);
          WriteLn(dirhash.ToHexString, ' ', namehash.ToHexString);
          //Exit;
        end;
      end;

      baFO3, baSSE: begin
        var dirhash := TwbHash.TES5(ExcludeTrailingPathDelimiter(ExtractFilePath(f.Name)));
        var namehash := TwbHash.TES5(ExtractFileName(f.Name), True);
        if (dirhash <> f.DirHash64) or (namehash <> f.NameHash64) then begin
          WriteLn(f.Name);
          WriteLn(f.DirHash64.ToHexString, ' ', f.NameHash64.ToHexString);
          WriteLn(dirhash.ToHexString, ' ', namehash.ToHexString);
          //Exit;
        end;
      end;

      baFO4, baFO4dds, baSF, baSFdds: begin
        var dirhash := TwbHash.FO4(ExcludeTrailingPathDelimiter(ExtractFilePath(f.Name)));
        var namehash := TwbHash.FO4(ChangeFileExt(ExtractFileName(f.Name), ''));
        if (dirhash <> f.DirHash32) or (namehash <> f.NameHash32) then begin
          WriteLn(f.Name);
          WriteLn(f.DirHash32.ToHexString, ' ', f.NameHash32.ToHexString);
          WriteLn(dirhash.ToHexString, ' ', namehash.ToHexString);
          Exit;
        end;
      end;

    end;

  bsa.Free;
  WriteLn('Done.');
end;
}
{
procedure test_reading;
var
  bsa: TwbBSArchive;
begin
  bsa := TwbBSArchive.Create;
  //bsa.LoadFromFile('d:\downloads\ccgcafo4007-factionws07hrflames - textures.ba2');
  //bsa.LoadFromFile('d:\Projects\TES5Edit\Tools\BSArchive\Knights.bsa');
  bsa.LoadFromFile('d:\Games\steamapps\common\Skyrim Special Edition\Data\Skyrim - Textures0.bsa');
  bsa.Unpack('textures\actors\alduin\alduin.dds', 'd:\1\alduin.dds');

  //for var f in bsa do
  //  WriteLn(f.Name);
  bsa.Free;
end;
}
{
procedure test_creating;
var
  ba: TwbBSArchive;
  sl: TStringList;
  root, s: string;
  i: integer;
begin
  sl := TStringList.Create;
  ba := TwbBSArchive.Create;
  ba.ShareData := True;
  root := 'd:\1\data';
  root := IncludeTrailingPathDelimiter(root);
  for s in TDirectory.GetFiles(root, '*.dds', TSearchOption.soAllDirectories) do
    if not SameText(root, ExtractFilePath(s)) then
      sl.Add(Copy(s, Succ(Length(root)), Length(s)));
  ba.CreateArchive('d:\2\a.bsa', baFO4dds, sl, [True, True, True]);
  for i := 0 to sl.Count - 1 do
    ba.Pack(sl[i], TFile.ReadAllBytes(root + sl[i]));

  try
    ba.Save;
    WriteLn('Done.');
  finally
    ba.Free;
    sl.Free;
  end;
end;
}
{
procedure test_packer;
var
  bsa: TwbMultiSourcePacker;
  i: Integer;
begin
  bsa := TwbMultiSourcePacker.Create;
  bsa.SplitSize := 600 * 1024;
  //bsa.Compress := True;
  bsa.ShareData := True;
  bsa.MultiThreaded := True;
  bsa.AddSourceFolder('d:\1\data\textures');

  bsa.CreateArchive('d:\1\a.bsa', baFO4dds);

  try
    var sw := TStopwatch.StartNew;

    if bsa.Multithreaded then
      TParallel.&For(0, Pred(bsa.ProcessCount),
        procedure(i: Integer)
        begin
          bsa.Process;
        end
      )
    else
      for i := 0 to Pred(bsa.ProcessCount) do
        bsa.Process;

    bsa.Save;
    WriteLn('Created archives:');
    for var b in bsa.Archives do begin
      Write(Format('%s   %s  %d files', [b.FileName, FormatSize(b.ArchiveSize), b.Count]));
      if b.ArchiveSharedFiles <> 0 then
        Write(Format('  %d shared saving %s', [b.ArchiveSharedFiles, FormatSize(b.ArchiveSharedSize)]));
      WriteLn;
      for var w in b.Warnings do
        WriteLn(#9'Warning: ', w);
    end;

    sw.Stop;
    WriteLn('Done in ', sw.Elapsed.ToString, '.');

  finally
    bsa.Free;
  end;
end;
}

begin
  try
    //ReportMemoryLeaksOnShutDown := True;

    //test_reading;
    //test_creating;
    //test_hashes;
    //test_packer;
    Main;
  except
    on E: Exception do begin
      Writeln(E.ClassName, ': ', E.ToString);
      System.ExitCode := 1;
    end;
  end;
  if DebugHook <> 0 then ReadLn;
end.

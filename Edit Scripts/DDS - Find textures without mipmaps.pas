{
  Search Data folder for loose textures without mipmaps
}
unit DDSFindTexturesNoMipMaps;

procedure ScanTextures(aFolder: string);
var
  TDirectory: TDirectory; // to access member functions
  files: TStringDynArray;
  dds: TwbDDSFile;
  s: string;
  i: integer;
begin
  aFolder := IncludeTrailingBackslash(aFolder);
  AddMessage('Scanning "' + aFolder + '", please wait...');
  files := TDirectory.GetFiles(aFolder, '*.dds', soAllDirectories);
  
  dds := TwbDDSFile.Create;
  try
    for i := 0 to Pred(Length(files)) do begin
      s := files[i];
      s := Copy(s, Length(aFolder) + 1, Length(s));
      
      try
        dds.LoadFromFile(aFolder + s);
        if dds.EditValues['Magic'] <> 'DDS ' then
          raise Exception.Create('Not a valid DDS file');
      except
        on E: Exception do begin
          AddMessage('Error reading: ' + s + ' <' + E.Message + '>');
        end;
      end;
      
      if dds.NativeValues['HEADER\dwMipMapCount'] = 0 then
        AddMessage('No mipmaps: ' + s);
    end;
  finally
    dds.Free;
  end;
end;

function Initialize: Integer;
begin
  ScanTextures(wbDataPath + 'Textures');
  Result := 1;
end;

end.

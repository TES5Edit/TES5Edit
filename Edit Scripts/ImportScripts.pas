{
  Import the text of scripts in selected records.
}
unit UserScript;

var
  slScripts, sl: TStringList;
  basePath, extension: string;
  debug: boolean;
    
function Initialize: integer;
var
  i: TIniFile;
begin
  slScripts := TStringList.Create;
  sl := TStringList.Create;
  i := TIniFile.Create(wbSettingsFileName);
  basePath := i.ReadString('ExportScripts', 'BasePath', wbTempPath);
  if Pos('\\?\', basePath)=0 then basePath := '\\?\'+basePath;  // allows program to handle very long file names
  extension := i.ReadString('ExportScripts', 'Extension', '.geck');
  debug := false {true};
end;

function Process(e: IInterface): integer;
var
  s, c, x: string;
  t: IInterface;
  i: integer;
begin
  
  if Signature(e) = 'SCTX' then begin
    x := PathName(e);
    x := FullPathToFilename(x);
    c := basePath + x + extension;
    x := ExtractFilePath(c);
    c := ExtractFileName(c);
    if debug then AddMessage('Processing: '+c+' at '+x);
    
    ForceDirectories(x);
    if DirectoryExists(x) then begin
      x := x+c;
      s := GetEditValue(e);
      slScripts.Text := s;
      if FileExists(x) then begin
        if debug then AddMessage(x+' exists');
        sl.Clear;
        sl.LoadFromFile(x);
        if sl.Text <> slScripts.Text then begin
          if debug then AddMessage(x+' modified');
          SetEditValue(e, sl.Text);
        end;
      end;
    end;
  end;
  
  for i := 0 to ElementCount(e) - 1 do
    Process(ElementByIndex(e, i));
end;

function finalize: integer;
begin
  sl.Free;
  slScripts.Free;
end;

end.

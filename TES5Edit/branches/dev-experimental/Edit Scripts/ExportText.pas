{
  Export all the text in selected records.
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
  basePath := i.ReadString('ExportText', 'BasePath', wbTempPath);
  extension := i.ReadString('ExportText', 'Extension', '.geck');
	debug := false;
end;

function Process(e: IInterface): integer;
var
  s, c, x: string;
  t: IInterface;
  i: integer;
begin
  
  if ((DefType(e) = dtString) or (DefType(e) = dtLString) or (DefType(e) = dtLenString)) then begin
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
				if debug then AddMessage(x+' existe');
				sl.Clear;
				sl.LoadFromFile(x);
				if sl.Text <> slScripts.Text then
					slScripts.SaveToFile(x);
			end else
				slScripts.SaveToFile(x);
		end else
			if debug then AddMessage('Directory not created : '+x);
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

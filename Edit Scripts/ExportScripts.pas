{
  Export the text of scripts in selected records.
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
  basePath := wbTempPath;
  i := TIniFile.Create(wbSettingsFileName);
  basePath := i.ReadString('ExportScripts', 'BasePath', basePath);
  extension := i.ReadString('ExportScripts', 'Extension', '.geck');
	debug := false {true};
end;

var
  n, p : string;

function Process(e: IInterface): integer;
var
  s, c, x: string;
  t: IInterface;
  i: integer;
begin
  if ElementType(e) = etMainRecord then begin
		n := '[' + IntToHex(FormID(e), 8) + '] ' + EditorID(e);
		p := basePath + '\' + Name(GetFile(e));
  end;
  
  if Signature(e) = 'SCTX' then begin
    x := PathName(e);
		x := FullPathToFilename(x);
    c := basePath + { p + '\' + n +} x + extension;
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
			AddMessage('Directory not created : '+x);
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

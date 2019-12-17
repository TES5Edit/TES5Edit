{
  Save the source of script into Data\Scripts\*.txt file
  For Oblivion, Fallout 3 and New Vegas
  
  Hotkey: Ctrl+Q
  Mode: Silent
}
unit SaveScriptSource;

function Process(e: IInterface): integer;
var
  s: string;
  sl: TStringList;
begin
  if Signature(e) <> 'SCPT' then
    Exit;
  
  s := DataPath + 'Scripts\';
  if not DirectoryExists(s) then
    if not ForceDirectories(s) then begin
      AddMessage('Can not create output folder ' + s);
      Result := 1;
      Exit;
    end;
  
  s := s + EditorID(e) + '.txt';
  AddMessage('Saving ' + Name(e) + ' script to ' + s);
  sl := TStringList.Create;
  sl.Text := GetElementEditValues(e, 'SCTX');
  sl.SaveToFile(s);
  sl.Free;
end;

end.

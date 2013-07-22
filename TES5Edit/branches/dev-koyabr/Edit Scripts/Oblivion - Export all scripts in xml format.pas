{
  Export SCPT records to XML file (for Oblivion, Fallout 3 and New Vegas)
}
unit UserScript;

var
  sl: TStringList;

function Initialize: integer;
begin
  sl := TStringList.Create;
  sl.Add('<?xml version="1.0" encoding="Windows-1252"?>');
  sl.Add('<scripts>');
  AddMessage('Building scripts list, please wait');
end;

function Process(e: IInterface): integer;
begin
  if Signature(e) <> 'SCPT' then Exit;
  sl.Add(Format('<script formid="%s" edid="%s" plugin="%s"><source><![CDATA[%s]]></source></script>', [
    IntToHex(GetLoadOrderFormID(e), 8),
    GetElementEditValues(e, 'EDID'),
    GetFileName(GetFile(e)),
    GetElementEditValues(e, 'SCTX')
  ]));
end;

function Finalize: integer;
var
  dlgSave: TSaveDialog;
begin
  sl.Add('</scripts>');
  dlgSave := TSaveDialog.Create(nil);
  dlgSave.Options := dlgSave.Options + [ofOverwritePrompt];
  dlgSave.Filter := 'XML files (*.xml)|*.xml';
  dlgSave.InitialDir := DataPath;
  dlgSave.FileName := 'scripts.xml';
  if dlgSave.Execute then begin
    AddMessage('Saving ' + dlgSave.FileName);
    sl.SaveToFile(dlgSave.FileName);
  end;
  dlgSave.Free;
  sl.Free;
end;

end.

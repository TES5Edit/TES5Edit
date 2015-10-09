{
  Copy file FormID to clipboard (to be used with GetFormFromFile() papyrus function for example)
  Hotkey: Ctrl+I
  Mode: Silent
}
unit CopyFormIDtoClipboard;

function Process(e: IInterface): Integer;
var
  frm: TForm;
  ed: TEdit;
begin
  frm := TForm.Create(nil);
  ed := TEdit.Create(frm);
  try
    ed.Parent := frm;
    ed.Text := IntToHex(FixedFormID(e), 8);
    ed.SelectAll;
    ed.CopyToClipboard;
  finally
    frm.Free;
  end;
  Result := 1;
end;

end.
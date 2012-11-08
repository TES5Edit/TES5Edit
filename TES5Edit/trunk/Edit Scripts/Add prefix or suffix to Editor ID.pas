(*
  This script will prepend or append supplied value to the EditorID field
  of every selected record.
*)
unit UserScript;

var
  DoPrepend: boolean;
  s: string;
  
function Initialize: integer;
var
  i: integer;
begin
  Result := 0;
  // ask for prefix or suffix mode
  i := MessageDlg('Prepend [YES] or append [NO] to Editor ID?', mtConfirmation, [mbYes, mbNo, mbCancel], 0);
  if i = mrYes then DoPrepend := true else
    if i = mrNo then DoPrepend := false else begin
      Result := 1;
      Exit;
    end;
  // ask for string
  if not InputQuery('Enter', 'Prefix/suffix', s) then begin
    Result := 2;
    Exit;
  end;
  // empty string - do nothing
  if s = '' then
    Result := 3;
end;

function Process(e: IInterface): integer;
var
  EditorID: IInterface;
begin
  Result := 0;
  //AddMessage('Processing: ' + GetName(e));
  EditorID := ElementByName(e, 'EDID - Editor ID');
  if EditorID <> nil then begin
    if DoPrepend then
      SetEditValue(EditorID, s + GetEditValue(EditorID))
    else
      SetEditValue(EditorID, GetEditValue(EditorID) + s);
  end;
end;

end.
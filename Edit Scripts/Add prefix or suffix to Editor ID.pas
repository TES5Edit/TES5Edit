{
  This script will prepend or append supplied value to the EditorID field
  of every selected record.
  
  Doesn't modify records that already have the same prefix/suffix.
}
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
  elEditorID: IInterface;
begin
  elEditorID := ElementBySignature(e, 'EDID');
  
  if Assigned(elEditorID) then
    if DoPrepend then begin
      if not StartsText(s, GetEditValue(elEditorID)) then
        SetEditValue(elEditorID, s + GetEditValue(elEditorID));
    end 
    else begin
      if not EndsText(s, GetEditValue(elEditorID)) then
        SetEditValue(elEditorID, GetEditValue(elEditorID) + s);
    end;
end;

end.

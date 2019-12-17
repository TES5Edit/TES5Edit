{
  Find and update records with Form Version less than FV_Check.
  FV_Set is a new value to set.
  Can be used for any game, but has a meaning only for Skyrim currently.
}
unit UserScript;

const
  FV_Check = 40;
  FV_Set = 43;

function Process(Rec: IInterface): integer;
var
  fv: integer;
begin
  Result := 0;
  
  fv := GetFormVersion(Rec);
  
  if fv >= FV_Check then begin
    AddMessage(Format('Found form version %d on %s', [fv, Name(Rec)]));
    SetFormVersion(Rec, FV_Set);
  end;
  
end;

end.

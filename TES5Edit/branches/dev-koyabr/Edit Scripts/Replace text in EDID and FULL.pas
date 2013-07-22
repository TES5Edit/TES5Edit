{
  Replace StrSearch with StrReplace in EDID and FULL subrecords
}
unit UserScript;

const
  StrSearch = 'Elven';
  StrReplace = 'Orcish';

var
  ReplaceCount: integer;

function Initialize: integer;
begin
  ReplaceCount := 0;
end;

procedure SearchAndReplace(e: IInterface; s1, s2: string);
var
  s: string;
begin
  if not Assigned(e) then Exit;

  // remove rfIgnoreCase to be case sensitive
  s := StringReplace(GetEditValue(e), s1, s2, [rfReplaceAll, rfIgnoreCase]);

  if not SameText(s, GetEditValue(e)) then begin
    Inc(ReplaceCount);
    AddMessage('Replacing in ' + FullPath(e));
    SetEditValue(e, s);
  end;

end;

function Process(e: IInterface): integer;
begin
  SearchAndReplace(ElementBySignature(e, 'EDID'), StrSearch, StrReplace);
  SearchAndReplace(ElementBySignature(e, 'FULL'), StrSearch, StrReplace);
end;

function Finalize: integer;
begin
  AddMessage(Format('Replaced %d occurences.', [ReplaceCount]));
end;

end.

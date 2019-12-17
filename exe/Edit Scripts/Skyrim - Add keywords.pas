{
  This script will add keywords to the keywords list of selected weapons.
  Almost no practical use, just a demo.
}
unit UserScript;

var
  slKeywords: TStringList;

function Initialize: integer;
begin
  // keywords to add
  slKeywords := TStringList.Create;
  slKeywords.Add('0001E719'); // WeapMaterialSteel
  slKeywords.Add('0008F958'); // VendorItemWeapon
  // instead can also load keywords from a text file (one keyword per line)
  // ProgramPath - path were xEdit exe file is
  // DataPath    - path to game's Data folder
  // slKeywords.LoadFromFile(ProgramPath + 'keywords.txt');
end;
    
function Process(e: IInterface): integer;
var
  kwda, k: IInterface;
  i, j: integer;
  exists: boolean;
begin
  Result := 0;

  // apply only to weapons
  if Signature(e) <> 'WEAP' then
    Exit;

  // get existing keywords list or add a new
  kwda := ElementBySignature(e, 'KWDA');
  if not Assigned(kwda) then
    kwda := Add(e, 'KWDA', True);
    
  // no keywords subrecord (it must exist) - terminate script
  if not Assigned(kwda) then begin
    AddMessage('No keywords subrecord in ' + Name(e));
    Result := 1;
    Exit;
  end;

  // iterate through additional keywords
  for i := 0 to slKeywords.Count - 1 do begin
  
    // check if our keyword already exists
    exists := false;
    for j := 0 to ElementCount(kwda) - 1 do
      if IntToHex(GetNativeValue(ElementByIndex(kwda, j)), 8) = slKeywords[i] then begin
        exists := true;
        Break;
      end;
    
    // skip the rest of code in loop if keyword exists
    if exists then Continue;
    
    // CK likes to save empty KWDA with only a single NULL form, use it if so
    if (ElementCount(kwda) = 1) and (GetNativeValue(ElementByIndex(kwda, 0)) = 0) then
      SetEditValue(ElementByIndex(kwda, 0), slKeywords[i])
    else begin
      // add a new keyword at the end of list
      // container, index, element, aOnlySK
      k := ElementAssign(kwda, HighInteger, nil, False);
      if not Assigned(k) then begin
        AddMessage('Can''t add keyword to ' + Name(e));
        Exit;
      end;
      SetEditValue(k, slKeywords[i]);
    end;
  
  end;
  
  // update KSIZ keywords count
  if not ElementExists(e, 'KSIZ') then
    Add(e, 'KSIZ', True);
  SetElementNativeValues(e, 'KSIZ', ElementCount(kwda));
  
  AddMessage('Processed: ' + Name(e));

end;

function Finalize: integer;
begin
  slKeywords.Free;
end;

end.

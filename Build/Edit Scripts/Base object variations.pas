{
  Make variations for references from the single base object.
  For example there is a STAT record MyRock01 that has 100 references in worldspace.
  You want to create 10 variations of rock and evenly redistribute references between them,
  and later retexture rocks, change models, etc (landspace design).
  Apply this script to MyRock01 record, enter 10 variations.
  MyRock01 will be renamed to MyRock01a and new variations created MyRock01b, MyRock01c, etc each having
  it's part of random references of original MyRock01.
}

unit BaseObjectVariations;

var
  slRefs: TStringList;
  
//============================================================================
function Process(e: IInterface): integer;
var
  s: string;
  lst: TList;
  r, ref: IInterface;
  varnum, i, j: integer;
begin
  if not InputQuery('Enter', 'Variations number (min is 2)', s) then 
    Exit;

  varnum := StrToIntDef(s, 0);
  if varnum < 2 then begin
    AddMessage('Invalid variations number.');
    Result := 1;
    Exit;
  end;
  
  slRefs := TStringList.Create;
  for i := 0 to ReferencedByCount(e) - 1 do begin
    ref := ReferencedByIndex(e, i);
    if Signature(ref) = 'REFR' then
      slRefs.AddObject('1', ref);
  end;
  
  if slRefs.Count < varnum then begin
    AddMessage('The number of variations is greater than the number of REFR references (' + StrToInt(slRefs.Count) + '), please use lower value');
    Finalize;
    Result := 1;
    Exit;
  end;
  
  // generate linear list of variations
  lst := TList.Create;
  for i := 0 to Pred(slRefs.Count) do
    lst.Add(i mod varnum + 1);
  // redistribute variations randomly
  Randomize;
  for i := 0 to Pred(slRefs.Count) do begin
    j := Random(lst.Count);
    slRefs[i] := IntToStr(lst[j]);
    lst.Delete(j);
  end;
  lst.Free;

  // create and assign variations
  for i := 2 to varnum do begin
    r := wbCopyElementToFile(e, GetFile(e), True, True);
    if not Assigned(r) then begin
      AddMessage('Fatal: can not make a copy from ' + Name(e) + '. Plugin is read only.');
      Finalize;
      Result := 1;
      Exit;
    end;
    SetElementEditValues(r, 'EDID', EditorID(r) + chr(96 + i));
    s := IntToStr(i);
    for j := 0 to Pred(slRefs.Count) do
      if s = slRefs[j] then
        SetElementEditValues(ObjectToElement(slRefs.Objects[j]), 'NAME', Name(r));
  end;
  // rename base object as a first variation
  SetElementEditValues(e, 'EDID', EditorID(e) + 'a');
  
  Finalize;
  Result := 1;
end;

//============================================================================
function Finalize: integer;
begin
  slRefs.Free;
end;

end.

{
    Clean triangle Edge Links in navmeshes after Finalize,
    before Apply Filter to Clean.
    (apply to plugin, not master)
}
unit NavMeshCleanEdgeLinks;

var
  arEdge: array [0..2] of string;

//===========================================================================
function Initialize: integer;
begin
  if wbSimpleRecords then begin
    MessageDlg('Simple records must be unchecked in xEdit options', mtInformation, [mbOk], 0);
    Result := 1;
    Exit;
  end;
  arEdge[0] := 'Edge 0-1';
  arEdge[1] := 'Edge 1-2';
  arEdge[2] := 'Edge 2-0';
end;


//===========================================================================
// search EdgeLinks table for equivalent Mesh and Triangle
function FindEdgeLink(EdgeLinks: IInterface; elM: string; elT: integer): integer;
var
  EdgeLink: IInterface;
  k: integer;
begin
  for k := Pred(ElementCount(EdgeLinks)) downto 0 do begin
    EdgeLink := ElementByIndex(EdgeLinks, k);
    if elT = GetElementNativeValues(EdgeLink, 'Triangle') then begin
      //AddMessage(Format('%d = %d', [elT, GetElementNativeValues(EdgeLink, 'Triangle')]));
      //AddMessage(elM);
      //AddMessage(GetElementEditValues(EdgeLink, 'Navmesh'));
      if CompareStr(elM, GetElementEditValues(EdgeLink, 'Navmesh')) = 0 then begin
        //AddMessage(Format('found %d', [k]));
        Result := k;
        Exit;
      end;
    end;
  end;

  Result := -1;
end;


//===========================================================================
// search Triangle for EdgeLink
function FindEdgeLinkIndex(Triangle: IInterface; elN: integer): integer;
var
  flags, j: integer;
begin
  flags := GetElementNativeValues(Triangle, 'Flags');
  for j := 0 to 2 do begin
    // triangle has EdgeLinks?
    if flags and (1 shl j) > 0 then begin
      if elN = GetElementNativeValues(Triangle, arEdge[j]) then begin
        Result := j;
        Exit;
      end;
    end;
  end;

  Result := -1;
end;


//===========================================================================
// search Triangles table for EdgeLink
function FindTriangleByEdgeLinkIndex(Triangles: IInterface; elN: integer): integer;
var
  i: integer;
begin
  // iterate through triangles in reverse
  for i := Pred(ElementCount(Triangles)) downto 0 do begin
    if FindEdgeLinkIndex(ElementByIndex(Triangles, i), elN) >= 0 then begin
      Result := i;
      Exit;
    end;
  end;

  Result := -1;
end;


//===========================================================================
// swap equivalent Mesh and Triangle
procedure SwapEdgeLink(swapLink, haveLink: IInterface);
var
  swapPath, havePath: IInterface;
  saveValue: integer;
  saveString: String;
begin
  havePath := ElementByPath(haveLink, 'Triangle');
  saveValue := GetNativeValue(havePath);
  swapPath := ElementByPath(swapLink, 'Triangle');
  SetNativeValue(havePath, GetNativeValue(swapPath));
  SetNativeValue(swapPath, saveValue);

  havePath := ElementByPath(haveLink, 'Navmesh');
  saveString := GetEditValue(havePath);
  swapPath := ElementByPath(swapLink, 'Navmesh');
  SetEditValue(havePath, GetEditValue(swapPath));
  SetEditValue(swapPath, saveString);

  havePath := ElementByPath(haveLink, 'Unknown');
  saveString := GetEditValue(havePath);
  swapPath := ElementByPath(swapLink, 'Unknown');
  SetEditValue(havePath, GetEditValue(swapPath));
  SetEditValue(swapPath, saveString);
end;


//===========================================================================
// find old edge link in triangles and swap with new
// Result: True on failure!
//
function SwapEdgeLinkValues(newTs, newLinks: IInterface; oldLinkIndex, newLimit, newLinkIndex, edgeIndex, newT: integer): integer;
var
  haveT, haveLink: IInterface;
  flags, j, i: integer;
begin
  haveLink := ElementByIndex(newLinks, newLinkIndex);

  // iterate through triangles in reverse
  for i := newLimit downto 0 do begin
    haveT := ElementByIndex(newTs, i);
    flags := GetElementNativeValues(haveT, 'Flags');
    for j := 0 to 2 do begin
      // triangle has EdgeLinks?
      if flags and (1 shl j) > 0 then begin
        if oldLinkIndex = GetElementNativeValues(haveT, arEdge[j]) then begin
          //AddMessage(Format('Swap %s %s value %d with %d', [Name(haveT), arEdge[j], oldLinkIndex, newLinkIndex]));
          SetElementNativeValues(ElementByIndex(newTs, newT), arEdge[edgeIndex], oldLinkIndex);
          SetElementNativeValues(haveT, arEdge[j], newLinkIndex);
          SwapEdgeLink(ElementByIndex(newLinks, oldLinkIndex), haveLink);
          Result := i;
          Exit;
        end;
      end;
    end;
  end;

  AddMessage(Format('ERROR: swap %s link %d not found!', [arEdge[edgeIndex], oldLinkIndex]));
  Result := -1;
end;


//===========================================================================
function Process(e: IInterface): integer;
var
  saveString: String;
  ore, mos, haveLink: IInterface;
  oldTs, oldT, oldLinks: IInterface;
  newTs, newT, newLinks: IInterface;
  oldLinkLimit, oldLinkIndex, oldLinkCount, oldLimit, oldFlags, oldFails: integer;
  newLinkLimit, newLinkIndex, newLinkCount, newLimit, newFlags, newFails: integer;
  saveValue, orc, j, i, hadTriangle, hadEdge, failures, b: integer;

begin
  if Signature(e) <> 'NAVM' then begin
    //AddMessage(Format('Not NAVM %s', [Name(e)]));
    Exit;
  end;
{
  for i := 0 to Pred(OverrideCount(MasterOrSelf(e))) do
    AddMessage(GetFileName(OverrideByIndex(MasterOrSelf(e), i)));
  Exit;
}
  mos := MasterOrSelf(e);
  orc := OverrideCount(mos);
  if orc < 1 then begin
    //AddMessage(Format('Override Count %d for %s', [orc, Name(e)]));
    Exit;
  end
  else if orc < 2 then
    ore := mos
  else
    ore := OverrideByIndex(mos, Pred(Pred(orc)));
  //AddMessage('Master/Override ' + GetFileName(ore) + ' for ' + Name(e));

  if Signature(ore) <> 'NAVM' then begin
    AddMessage(Format('Not NAVM: %s', [Name(ore)]));
    Exit;
  end;

  oldTs := ElementByPath(ore, 'NVNM\Triangles');
  oldLimit := Pred(ElementCount(oldTs));

  oldLinks := ElementByPath(ore, 'NVNM\Edge Links');
  oldLinkCount := ElementCount(oldLinks);
  oldLinkLimit := Pred(oldLinkCount);

  newTs := ElementByPath(e, 'NVNM\Triangles');
  newLimit := Pred(ElementCount(newTs));

  newLinks := ElementByPath(e, 'NVNM\Edge Links');
  newLinkCount := ElementCount(newLinks);
  newLinkLimit := Pred(newLinkCount);

  // iterate through triangles
  for i := 0 to newLimit do begin
    failures := 0;

    if i <= oldLimit then begin
      oldT := ElementByIndex(oldTs, i);
      oldFlags := GetElementNativeValues(oldT, 'Flags');
    end;
    newT := ElementByIndex(newTs, i);
    newFlags := GetElementNativeValues(newT, 'Flags');

    for j := 0 to 2 do begin
      b := 1 shl j;
      oldFails := 0;
      if i > oldLimit then
        oldLinkIndex := -1
      else if oldFlags and b = 0 then 
        oldLinkIndex := -1
      else begin
        oldLinkIndex := GetElementNativeValues(oldT, arEdge[j]);
        //AddMessage(Format('%s %s value %d:', [Name(oldT), arEdge[j], oldLinkIndex]));
        if oldLinkIndex < 0 then begin
          AddMessage(Format('ERROR: old %s link (%d < 0)!', [arEdge[j], oldLinkIndex]));
          Inc(oldFails);
          end
        else if oldLinkIndex > oldLinkLimit then begin
          AddMessage(Format('ERROR: old %s link (%d > %d)!', [arEdge[j], oldLinkIndex, oldLinkLimit]));
          oldLinkIndex := -1;
          Inc(oldFails);
        end
        else if oldLinkIndex > newLinkLimit then begin
          // new table has fewer links (unusual condition)
          AddMessage(Format('Had old %s link %d > new limit %d', [arEdge[j], oldLinkIndex, newLinkLimit]));
          oldLinkIndex := -1;
          Inc(oldFails);
        end;
      end;
      failures := failures + oldFails;

      newFails := 0;
      if newFlags and b > 0 then begin
        newLinkIndex := GetElementNativeValues(newT, arEdge[j]);
        //AddMessage(Format('%s %s value %d:', [Name(newT), arEdge[j], newLinkIndex]));
        if newLinkIndex < 0 then begin
          AddMessage(Format('ERROR: new %s link (%d < 0)!', [arEdge[j], newLinkIndex]));
          Inc(newFails);
        end
        else if newLinkIndex > newLinkLimit then begin
          AddMessage(Format('ERROR: new %s link (%d > %d)!', [arEdge[j], newLinkIndex, newLinkLimit]));
          Inc(newFails);
        end
        else if oldLinkIndex = newLinkIndex then
          // nothing to do! (very common)
        else if oldLinkIndex >= 0 then begin
          // try to swap! (less common)
          if SwapEdgeLinkValues(newTs, newLinks, oldLinkIndex, newLimit, newLinkIndex, j, i) < 0 then
            Inc(newFails);
        end
        else begin
          // search old Edge Links for possible match...
          haveLink := ElementByIndex(newLinks, newLinkIndex);
          saveString := GetElementEditValues(haveLink, 'Navmesh');
          saveValue := GetElementNativeValues(haveLink, 'Triangle');
          oldLinkIndex := FindEdgeLink(oldLinks, saveString, saveValue);
          if oldLinkIndex < 0 then begin
            // new link added (debugging, nothing to be done)
            //AddMessage(Format('No match for triangle %d in %s', [saveValue, saveString]));
            //Inc(newFails);
          end
          else if oldLinkIndex > newLinkLimit then begin
            // new table has fewer links (unusual condition)
            hadTriangle := FindTriangleByEdgeLinkIndex(oldTs, oldLinkIndex);
            if (hadTriangle <> i) and (hadTriangle >= 0) and (hadTriangle <= newLimit) then begin
              AddMessage(Format('%s needs repair?', [Name(newT)]));
              hadEdge := FindEdgeLinkIndex(ElementByIndex(oldTs, hadTriangle), oldLinkIndex);
              AddMessage(Format('Triangle #%d %s was found!', [hadTriangle, arEdge[hadEdge]]));
            end;
            AddMessage(Format('Was old matching link %d > new limit %d', [oldLinkIndex, newLinkLimit]));
            AddMessage(Format('Have match (%d) for triangle %d in %s', [oldLinkIndex, saveValue, saveString]));
            Inc(newFails);
          end
          else if (newFlags and (7 - b)) > 0 then begin
            // multiple edges (requires repair)
            AddMessage(Format('%s needs repaired edges!', [Name(newT)]));
            AddMessage(Format('Have match (%d) for triangle %d in %s', [oldLinkIndex, saveValue, saveString]));
            // cannot swap, unknown edge to use!
            Inc(newFails);
          end
          else begin
            // singular changes (can swap awaiting repair)
            hadTriangle := FindTriangleByEdgeLinkIndex(oldTs, oldLinkIndex);
            if (hadTriangle <> i) and (hadTriangle >= 0) and (hadTriangle <= newLimit) then begin
              AddMessage(Format('%s needs repair?', [Name(newT)]));
              hadEdge := FindEdgeLinkIndex(ElementByIndex(oldTs, hadTriangle), oldLinkIndex);
              AddMessage(Format('Triangle #%d %s was found!', [hadTriangle, arEdge[hadEdge]]));
            end;
            AddMessage(Format('Have match (%d) for triangle %d in %s', [oldLinkIndex, saveValue, saveString]));
            if oldLinkIndex <> newLinkIndex then
              SwapEdgeLinkValues(newTs, newLinks, oldLinkIndex, newLimit, newLinkIndex, j, i);
            Inc(newFails);
          end;
        end;
        if newFails > 0 then begin
          AddMessage(Format('via new %s link %d', [arEdge[j], newLinkIndex]));
          failures := failures + newFails;
        end;
      end
      else if oldLinkIndex >= 0 then begin
        haveLink := ElementByIndex(oldLinks, oldLinkIndex);
        saveString := GetElementEditValues(haveLink, 'Navmesh');
        saveValue := GetElementNativeValues(haveLink, 'Triangle');
        AddMessage(Format('Want match for triangle %d in %s', [saveValue, saveString]));
        AddMessage(Format('via old %s link %d', [arEdge[j], oldLinkIndex]));
        Inc(failures);
      end;
    end;

    if failures > 0 then begin
      AddMessage(Format('^^^ Check triangle %d in %s', [i, Name(e)]));
      AddMessage('');
      //Exit;
    end;
  end;
end;

end.

{
    Check triangle Edges in navmeshes for irregularities.
}
unit NavMeshCheckEdges;

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
// check that tri1 in navmesh Triangles array points to tri2 in same array
function CheckEdge(tris: IInterface; tri1, tri2: integer): Boolean;
var
  tri: IInterface;
  TriLimit, j, flags, EdgeValue: integer;
begin
  TriLimit := Pred(ElementCount(tris));
  tri := ElementByIndex(tris, tri1);
  flags := GetElementNativeValues(tri, 'Flags');

  for j := 0 to 2 do
    if flags and (1 shl j) = 0 then begin
      EdgeValue := GetElementNativeValues(tri, arEdge[j]);
      if EdgeValue < 0 then
        // no known edge
      else if EdgeValue > TriLimit then
        AddMessage(Format('Bad %s value (%d > %d)!', [arEdge[j], EdgeValue, TriLimit]))
      else if EdgeValue = tri2 then begin
        Result := True;
        Exit;
      end;
    end;

  AddMessage('No match!');
end;


//===========================================================================
// check that tri1 in navmesh navm1 points to tri2 in navmesh navm2
function CheckEdgeLink(navm1, navm2: IInterface; tri1, tri2: integer): Boolean;
var
  tris, tri, EdgeLinks, EdgeLink: IInterface;
  TriLimit, j, flags, EdgeValue, EdgeLinkLimit: integer;
begin
  if Signature(navm1) <> 'NAVM' then begin
    AddMessage('Not NAVM!');
    AddMessage(Format('Referenced triangle %d in %s', [tri1, Name(navm1)]));
    Exit;
  end;
  tris := ElementByPath(navm1, 'NVNM\Triangles');
  TriLimit := Pred(ElementCount(tris));
  if tri1 > TriLimit then begin
    AddMessage(Format('Referenced triangle (%d > %d) in %s', [tri1, TriLimit, Name(navm1)]));
    Exit;
  end;
  tri := ElementByIndex(tris, tri1);
  flags := GetElementNativeValues(tri, 'Flags');
  if flags and 7 = 0 then begin
    AddMessage('No Edge Links');
    AddMessage(Format('Referenced triangle %d in %s', [tri1, Name(navm1)]));
    Exit;
  end;

  EdgeLinks := ElementByPath(navm1, 'NVNM\Edge Links');
  EdgeLinkLimit := Pred(ElementCount(EdgeLinks));
  for j := 0 to 2 do
    if flags and (1 shl j) > 0 then begin
      EdgeValue := GetElementNativeValues(tri, arEdge[j]);
      if EdgeValue < 0 then
        AddMessage(Format('Bad %s link (%d < 0)!', [arEdge[j], EdgeValue]))
      else if EdgeValue > EdgeLinkLimit then begin
        AddMessage(Format('Bad %s link (%d > %d)!', [arEdge[j], EdgeValue, EdgeLinkLimit]));
        AddMessage(Format('Referenced triangle %d in %s', [tri1, Name(navm1)]));
      end
      else begin
        EdgeLink := ElementByIndex(EdgeLinks, EdgeValue);
        if (FormID(LinksTo(ElementByName(EdgeLink, 'Mesh'))) = FormID(navm2)) and (GetElementNativeValues(EdgeLink, 'Triangle') = tri2) then begin
          Result := True;
          Exit;
        end;
      end;
    end;

  AddMessage('No match!');
  AddMessage(Format('Referenced triangle %d in %s', [tri1, Name(navm1)]));
end;


//===========================================================================
function Process(pe: IInterface): integer;
var
  tris, tri, EdgeLinks, EdgeLink, e: IInterface;
  warnings, TriLimit, skips, j, i, flags: integer;
  EdgeValue, EdgeLinkLimit, EdgeLinkFound, EdgeLinkCount: integer;
begin
  if Signature(pe) <> 'NAVM' then
    Exit;

  e := WinningOverride(pe);
  tris := ElementByPath(e, 'NVNM\Triangles');
  TriLimit := Pred(ElementCount(tris));
  EdgeLinks := ElementByPath(e, 'NVNM\Edge Links');
  EdgeLinkCount := ElementCount(EdgeLinks);
  EdgeLinkLimit := Pred(EdgeLinkCount);
  EdgeLinkFound := 0;

  // iterate through triangles
  for i := 0 to TriLimit do begin
    skips := 0;
    warnings := 0;
    tri := ElementByIndex(tris, i);
    flags := GetElementNativeValues(tri, 'Flags');
    for j := 0 to 2 do begin
      EdgeValue := GetElementNativeValues(tri, arEdge[j]);
      // triangle has EdgeLinks?
      if flags and (1 shl j) > 0 then begin
        // AddMessage(Format('test %s value %d', [arEdge[j], EdgeValue]));
        if EdgeValue < 0 then begin
          AddMessage(Format('Bad %s link (%d < 0)!', [arEdge[j], EdgeValue]))
          Inc(warnings);
          end
        else if EdgeValue > EdgeLinkLimit then begin
          AddMessage(Format('Bad %s link (%d > %d)!', [arEdge[j], EdgeValue, EdgeLinkLimit]))
          Inc(warnings);
        end
        else begin
          Inc(EdgeLinkFound);
          EdgeLink := ElementByIndex(EdgeLinks, EdgeValue);
          if not CheckEdgeLink(WinningOverride(LinksTo(ElementByName(EdgeLink, 'Mesh'))), e, GetElementNativeValues(EdgeLink, 'Triangle'), i) then begin
            AddMessage(Format('via %s link %d', [arEdge[j], EdgeValue]));
            Inc(warnings);
          end;
        end;
      end
      else begin
        // AddMessage(Format('test %s internal', [arEdge[j]]));
        if EdgeValue < 0 then
            Inc(skips)
        else if EdgeValue > TriLimit then begin
          AddMessage(Format('Bad %s value (%d > %d)!', [arEdge[j], EdgeValue, TriLimit]));
          Inc(warnings);
        end
        else if not CheckEdge(tris, EdgeValue, i) then begin
          AddMessage(Format('Referenced triangle %d', [EdgeValue]));
          Inc(warnings);
        end;
      end;
    end;

    if warnings > 0 then
      AddMessage(Format('^^^ ERROR Triangle %d in %s', [i, Name(e)]))
    else if skips = 3 then
      AddMessage(Format('*** Island Triangle %d in %s', [i, Name(e)]))
    else if flags and 2048 = 0 then
      AddMessage(Format('*** Not Found Triangle %d in %s', [i, Name(e)]));
  end;
    
  if (EdgeLinkFound > 0) and (EdgeLinkFound > EdgeLinkCount) then begin
    AddMessage(Format('Too many Edges Linked (%d > %d) in %s', [EdgeLinkFound, EdgeLinkCount, Name(e)]));
    //Result := 1;
    //Exit;
  end;
end;

end.
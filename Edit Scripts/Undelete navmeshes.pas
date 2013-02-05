{
  WORK IN PROGRESS! DO NOT USE ON REAL PLUGINS!
  Only for Fallout 3 and New Vegas.
  Script tries to undelete and disable navmeshes since they can't be
  handled like other UDR references.

  We need a very clever modder to finish it.
}
unit UserScript;

var
  UndeletedCount: integer;
  
function Process(e: IInterface): integer;
var
  vertices, v, f, entry: IInterface;
  navi, nvmis, nvmi: IInterface;
  i: integer;
begin
  Result := 0;
  
  if not (GetIsEditable(e) and GetIsDeleted(e)) then
    Exit;
  
  if Signature(e) <> 'NAVM' then
    Exit;
  
  AddMessage('Undeleting: ' + Name(e));
  
  // Find NVMI entry in NAVI for undeleted mesh
  f := GetFile(e);
  if not Assigned(f) then
    Exit;
    
  navi := GroupBySignature(f, 'NAVI');
  if not Assigned(navi) then begin
    AddMessage('No NAVI group found');
    Exit;
  end;
  
  // NAVI group always has only 1 record
  if ElementCount(navi) = 1 then begin
    navi := ElementByIndex(navi, 0);
    // get master NAVI record because NAVI record in plugin doesn't have NVMI for deleted navmesh
    navi := Master(navi);
  end else begin
    AddMessage('NAVI group must have 1 record');
    Exit;
  end;

  if not Assigned(navi) then begin
    AddMessage('No master NAVI record found');
    Exit;
  end;

  nvmis := ElementByName(navi, 'Navigation Map Infos');
  if not Assigned(nvmis) then
    Exit;
    
  for i := 0 to ElementCount(nvmis) - 1 do begin
    entry := ElementByIndex(nvmis, i);
    if GetElementNativeValues(entry, 'Navigation Mesh') = FormID(e) then begin
      nvmi := entry;
      Break;
    end;
  end;
  
  if Assigned(nvmi) then begin
    AddMessage('Found NVMI subrecord in NAVI');
  end;
  
  // now we need to do something here with NAVI...
  // and probably NVPP for Skyrim etc.
  
  // uncomment if you don't want to undelete navmesh
  Exit;

  // Navmesh undelete and disable
  SetIsDeleted(e, True);
  SetIsDeleted(e, False);
  SetIsInitiallyDisabled(e, True);
  // place navmesh below the ground (change Z on all vertices)
  // currently only for Skyrim
  if wbGameMode = gmTES5 then begin
    vertices := ElementByPath(e, 'NVNM - Geometry\Vertices');
    for i := 0 to ElementCount(vertices) - 1 do
      SetElementNativeValues(ElementByIndex(vertices, v), 'Z', -30000);
  end;
 
  Inc(UndeletedCount);
end;

function Finalize: integer;
begin
  AddMessage('Undeleted navmeshes: ' + IntToStr(UndeletedCount));
end;

end.
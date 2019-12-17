{
  Build a list of interior cells in csv format
}
unit SkyrimListInteriorCells;

var
  CountRef, CountRefPersistent, CountRefDeleted, CountRefDisabled: integer;
  CountNAVM, CountSpawn, CountLight, CountSound: integer;
  CountFurniture, CountContainer: integer;
  slCells: TStringList;
  slSpawns: TStringList;

procedure ClearCellData;
begin
  CountRef := 0;
  CountRefPersistent := 0; 
  CountRefDeleted := 0;
  CountRefDisabled := 0;
  CountNAVM := 0;
  CountSpawn := 0;
  slSpawns.Clear;
  CountLight := 0;
  CountSound := 0;
  CountFurniture := 0;
  CountContainer := 0;
end;
  
function Initialize: integer;
begin
  slCells := TStringList.Create;
  slCells.Add('FormID;Block;Sub-Block;EditorID;Name;Ownership;Location;LightingTemplate;ImageSpace;AcousticSpace;Music;Navmeshes;References;Persistent;Deleted;Disabled;Spawns;SpawnsList;Lights;Sounds;Furnitures;Containers');
  slSpawns := TStringList.Create; slSpawns.Sorted := True; slSpawns.Duplicates := dupIgnore;

  ClearCellData;
end;

function Process(e: IInterface): integer;
var
  sig, sigbase, s: string;
  block, subblock: integer;
  r: IInterface;
begin
  sig := Signature(e);
  
  if (sig = 'REFR')
  or (sig = 'ACHR')
  or (sig = 'PARW')
  or (sig = 'PBAR')
  or (sig = 'PBEA')
  or (sig = 'PCON')
  or (sig = 'PFLA')
  or (sig = 'PHZD')
  or (sig = 'PMIS') then begin
    Inc(CountRef);
    if GetIsPersistent(e) then Inc(CountRefPersistent);
    if GetIsDeleted(e) then Inc(CountRefDeleted);
    if GetIsinitiallyDisabled(e) then Inc(CountRefDisabled);
    r := BaseRecord(e);
    sigbase := Signature(r);
    if sig = 'ACHR' then begin
      Inc(CountSpawn);
      slSpawns.Add(EditorID(r));
    end;
    if sigbase = 'LIGH' then Inc(CountLight)
    else if sigbase = 'SOUN' then Inc(CountSound)
    else if sigbase = 'FURN' then Inc(CountFurniture)
    else if sigbase = 'CONT' then Inc(CountContainer);
  end
  else if sig = 'NAVM' then begin
    if not GetIsDeleted(e) then Inc(CountNAVM);
  end
  else if sig = 'CELL' then begin
    // only for interior cells
    if GetElementNativeValues(e, 'DATA') and 1 > 0 then begin
      s := IntToStr(FormID(e) and $FFFFFF);
      block := StrToInt(s[length(s)]);
      subblock := StrToInt(s[length(s)-1]);
      slCells.Add(Format('%s;%d;%d;%s;%s;%s;%s;%s;%s;%s;%s;%d;%d;%d;%d;%d;%d;%s;%d;%d;%d;%d', [
        '[' + IntToHex(FormID(e), 8) + ']',  // add [] to prevent Excel from treating FormID as a number
        block,
        subblock,
        EditorID(e),
        GetElementEditValues(e, 'FULL'),
        EditorID(LinksTo(ElementByPath(e, 'Ownership\XOWN'))),
        EditorID(LinksTo(ElementBySignature(e, 'XLCN'))),
        EditorID(LinksTo(ElementBySignature(e, 'LTMP'))),
        EditorID(LinksTo(ElementBySignature(e, 'XCIM'))),
        EditorID(LinksTo(ElementBySignature(e, 'XCAS'))),
        EditorID(LinksTo(ElementBySignature(e, 'XCMO'))),
        CountNAVM,
        CountRef,
        CountRefPersistent,
        CountRefDeleted,
        CountRefDisabled,
        CountSpawn,
        slSpawns.CommaText,
        CountLight,
        CountSound,
        CountFurniture,
        CountContainer
      ]));
    end;
    ClearCellData;
  end;
end;

function Finalize: integer;
var
  fname: string;
begin
  if slCells.Count > 1 then begin
    fname := ScriptsPath + 'Cells.csv';
    AddMessage('Saving report to ' + fname);
    slCells.SaveToFile(fname);
  end else
    AddMessage('No cells found in selection.');

  slSpawns.Free;
  slCells.Free;
end;

end.

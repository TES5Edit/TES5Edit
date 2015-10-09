{
  Copy CELL records from selected plugin(s) to a new file to preserve their settings.
  Can be used for lighting overhauls. Select lighting plugins with Ctrl+Click in TES5Edit
  and apply this script. Created new patch file must be loaded last and recreated every
  time you uninstall/reorder/update master plugins.
}
unit UserScript;

var
  newfile: IInterface;
  cells: TStringList;
  recs: array [0..50000] of IInterface;

function Initialize: integer;
begin
  cells := TStringList.Create;
  AddMessage('Building cells list, please wait...');
end;
  
function Process(e: IInterface): integer;
var
  idx: integer;
  s: string;
begin
  if Signature(e) <> 'CELL' then
    Exit;

  // only interior cells
  if GetElementNativeValues(e, 'DATA') and 1 = 0 then
    Exit;
  
  s := IntToHex(FormID(e), 8);
  idx := cells.IndexOf(s);
  if idx = -1 then begin
    recs[cells.Count] := e;
    cells.Add(s);
  end else
    recs[idx] := e;
end;

function Finalize: integer;
var
  i: integer;
  r: IInterface;
begin
  if cells.Count <> 0 then begin
    // create a new patch file
    newfile := AddNewFile;
    if not Assigned(newfile) then begin
      AddMessage('Patch file creation canceled');
      Result := 1;
      Exit;
    end;
    for i := 0 to cells.Count - 1 do begin
      r := recs[i];
      // add current plugin as a master
      AddRequiredElementMasters(GetFile(r), newfile, False);
      // copy CELL record to patch, parameters: record, file, AsNew, DeepCopy
      wbCopyElementToFile(r, newfile, False, True);
    end;
    AddMessage(Format('Patch file created with %d cell records.', [cells.Count]));
  end else
    AddMessage('No cell records found to copy.');
  cells.Free;
end;

end.
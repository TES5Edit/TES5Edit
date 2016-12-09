{
  List used entry points from perk records
  Handly when you want to create a new perk in xEdit and need an example on how to use a particular entry point
}
unit ListPerkEntryPoints;

var
  sl: TStringList;

function Initialize: integer;
begin
  sl := TStringList.Create;
end;

function Process(e: IInterface): integer;
var
  effects, effect: IInterface;
  i: integer;
  entry: string;
begin
  if Signature(e) <> 'PERK' then
    Exit;
  
  effects := ElementByName(e, 'Effects');
  for i := 0 to Pred(ElementCount(effects)) do begin
    effect := ElementByIndex(effects, i);
    if GetElementEditValues(effect, 'PRKE\Type') <> 'Entry Point' then
      Continue;
    entry := GetElementEditValues(effect, 'DATA\Entry Point\Entry Point');
    sl.Values[entry] := sl.Values[entry] + #13#10 + Name(e);
  end;
end;

function Finalize: integer;
var
  i, j: integer;
  lst: TStringList;
begin
  if sl.Count <> 0 then begin
    sl.Sort;
    lst := TStringList.Create;
    lst.Sorted := True;
    lst.Duplicates := dupIgnore;
    for i := 0 to Pred(sl.Count) do begin
      AddMessage(sl.Names[i]);
      lst.Text := sl.ValueFromIndex[i];
      for j := 0 to Pred(lst.Count) do
        if lst[j] <> '' then
          AddMessage('        ' + lst[j]);
    end;
    lst.Free;
  end;
  
  sl.Free;
end;


end.

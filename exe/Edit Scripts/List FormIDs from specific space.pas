{
  List [FormIDCount] allocated FormIDs starting from [FormIDStart]
}
unit UserScript;

const
  FormIDStart = $00000000; // starting formid
  FormIDCount = $800;        // formids to list

function Process(e: IInterface): integer;
var
  p, r: IInterface;
  i: integer;
begin
  p := GetFile(e);
  for i := FormIDStart to FormIDStart + FormIDCount - 1 do begin
    r := RecordByFormID(p, i, True);
    AddMessage(IntToHex(i, 8) + ' - ' + Name(r));
  end;
  Result := 1;
end;

end.

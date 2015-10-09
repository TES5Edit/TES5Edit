{
  Report records that have internal FormID index greater than the number of plugin's masters.
}
unit ReportUnclampedFormIDs;

function Process(e: IInterface): Integer;
var
  idx: integer;
begin
  idx := GetElementNativeValues(e, 'Record Header\FormID') shr 24;
  if idx > MasterCount(GetFile(e)) then
    AddMessage(Format('[%s] Unclamped FormID index of %s for %s', [GetFileName(e), IntToHex(idx, 2), Name(e)]));
end;

end.
{
  Replace one type of map marker with the other one
}
unit ReplaceMapMarker;

const
  // map marker types as seen in xEdit
  sMapReplaceWhat = 'Farm';
  sMapReplaceWith = 'Fort';

function Process(e: IInterface): Integer;
begin
  // map markers are references
  if Signature(e) <> 'REFR' then
    Exit;
  
  // references of hardcoded MapMarker [STAT:00000010] object
  if GetElementNativeValues(e, 'NAME') <> $00000010 then
    Exit;
  
  if GetElementEditValues(e, 'Map Marker\TNAM\Type') = sMapReplaceWhat then begin
    AddMessage('Replacing marker ' + Name(e));
    SetElementEditValues(e, 'Map Marker\TNAM\Type', sMapReplaceWith);
  end;
end;

end.
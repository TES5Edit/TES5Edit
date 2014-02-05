{
  Bookmark 4 Set
  Hotkey: Ctrl+4
  Mode: Silent
}
unit Bookmark4;

uses
  Bookmark;

function Process(e: IInterface): Integer;
begin
  BookmarkSet(e, 4);
  Result := 1;
end;

end.
{
  Bookmark 2 Set
  Hotkey: Ctrl+2
  Mode: Silent
}
unit Bookmark2;

uses
  Bookmark;

function Process(e: IInterface): Integer;
begin
  BookmarkSet(e, 2);
  Result := 1;
end;

end.
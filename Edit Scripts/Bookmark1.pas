{
  Bookmark 1 Set
  Hotkey: Ctrl+1
  Mode: Silent
}
unit Bookmark1;

uses
  Bookmark;

function Process(e: IInterface): Integer;
begin
  BookmarkSet(e, 1);
  Result := 1;
end;

end.
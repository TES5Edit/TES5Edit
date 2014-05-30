{
  Bookmark 3 Set
  Hotkey: Ctrl+3
  Mode: Silent
}
unit Bookmark3;

uses
  Bookmark;

function Process(e: IInterface): Integer;
begin
  BookmarkSet(e, 3);
  Result := 1;
end;

end.
{
  Bookmark 5 Set
  Hotkey: Ctrl+5
  Mode: Silent
}
unit Bookmark5;

uses
  Bookmark;

function Process(e: IInterface): Integer;
begin
  BookmarkSet(e, 5);
  Result := 1;
end;

end.
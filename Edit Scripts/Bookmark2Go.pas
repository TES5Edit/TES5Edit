{
  Bookmark 2 Go
  Hotkey: Alt+2
  Mode: Silent
}
unit Bookmark2Go;

uses
  Bookmark;

function Initialize: Integer;
begin
  BookmarkGo(2);
  Result := 1;
end;

end.
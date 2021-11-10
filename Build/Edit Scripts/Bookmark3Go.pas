{
  Bookmark 3 Go
  Hotkey: Alt+3
  Mode: Silent
}
unit Bookmark3Go;

uses
  Bookmark;

function Initialize: Integer;
begin
  BookmarkGo(3);
  Result := 1;
end;

end.
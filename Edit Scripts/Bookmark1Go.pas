{
  Bookmark 1 Go
  Hotkey: Alt+1
  Mode: Silent
}
unit Bookmark1Go;

uses
  Bookmark;

function Initialize: Integer;
begin
  BookmarkGo(1);
  Result := 1;
end;

end.
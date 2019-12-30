{
  Bookmark 2 Set
  Hotkey: Ctrl+2
  Mode: Silent
}
unit Bookmark1;

uses
  Bookmark;

var
  MarkRecord: IInterface;

function Process(e: IInterface): Integer;
begin
  MarkRecord := e;
end;

function Finalize: Integer;
begin
  BookmarkSet(MarkRecord, 2);
end;

end.
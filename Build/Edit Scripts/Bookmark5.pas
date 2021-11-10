{
  Bookmark 5 Set
  Hotkey: Ctrl+5
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
  BookmarkSet(MarkRecord, 5);
end;

end.
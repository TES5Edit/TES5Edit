{
  Bookmark 4 Set
  Hotkey: Ctrl+4
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
  BookmarkSet(MarkRecord, 4);
end;

end.
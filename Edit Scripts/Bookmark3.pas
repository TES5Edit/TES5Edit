{
  Bookmark 3 Set
  Hotkey: Ctrl+3
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
  BookmarkSet(MarkRecord, 3);
end;

end.
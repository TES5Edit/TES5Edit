{
  Bookmark 1 Set
  Hotkey: Ctrl+1
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
  BookmarkSet(MarkRecord, 1);
end;

end.
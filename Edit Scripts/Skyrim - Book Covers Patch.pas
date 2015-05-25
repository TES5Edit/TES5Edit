{
  Book Covers Skyrim dynamic compatibility patcher.
}
unit BookCoversSkyrimPatcher;

const
  sBCPluginNames = 'Book Covers Skyrim.esp,Book Covers Dawnguard.esp,Book Covers Hearthfire.esp,Book Covers Dragonborn.esp';

var
  slBooks: TStringList;
  pluginPatch: IInterface;

//=========================================================================================
// patching a book record
function PatchBook(Book: IInterface): Boolean;
var
  BookOvr, BookPatch: IInterface;
begin
  // create a new patch plugin if needed
  if not Assigned(pluginPatch) then
    pluginPatch := AddNewFile;

  if not Assigned(pluginPatch) then
    Exit;

  // getting the last override
  BookOvr := WinningOverride(Book);

  // create override for a book
  AddRequiredElementMasters(Book, pluginPatch, False);
  AddRequiredElementMasters(BookOvr, pluginPatch, False);
  BookPatch := wbCopyElementToFile(BookOvr, pluginPatch, False, True);
  if not Assigned(BookPatch) then
    Exit;
  // copy settings from Book Covers Skyrim
  ElementAssign(ElementByPath(BookPatch, 'OBND'), LowInteger, ElementByPath(Book, 'OBND'), False);
  ElementAssign(ElementByPath(BookPatch, 'Model'), LowInteger, ElementByPath(Book, 'Model'), False);
  SetElementEditValues(BookPatch, 'INAM', GetElementEditValues(Book, 'INAM'));
  SetElementEditValues(BookPatch, 'DATA\Type', GetElementEditValues(Book, 'DATA\Type'));

  Result := True;
end;
  
//=========================================================================================
function Initialize: integer;
var
  slBCMods: TStringList;
  i, j: integer;
  f, g, book, bookovr: IInterface;
  frm: TForm;
  clb: TCheckListBox;
begin
  Result := 1;

  slBooks := TStringList.Create;

  slBCMods := TStringList.Create;
  slBCMods.Delimiter := ',';
  slBCMods.StrictDelimiter := True;
  slBCMods.DelimitedText := LowerCase(sBCPluginNames);

  // getting a list of books that need to be patched
  for i := 1 to Pred(FileCount) do begin
    f := FileByIndex(i);
    if slBCMods.IndexOf(LowerCase(GetFileName(f))) = -1 then
      Continue;
    g := GroupBySignature(f, 'BOOK');
    for j := 0 to Pred(ElementCount(g)) do begin
      book := ElementByIndex(g, j);
      bookovr := WinningOverride(book);
      // if BOOK record from Book Covers is not the last override, then add to list
      if not Equals(book, bookovr) then
        slBooks.AddObject(Format('%s  - Conflicts with %s', [GetElementEditValues(book, 'FULL'), Name(GetFile(bookovr))]), book);
    end;
  end;
  slBCMods.Free;

  if not Assigned(g) then begin
    MessageDlg('Read Books Skyrim mod(s) are not loaded', mtInformation, [mbOk], 0);
    slBooks.Free;
    Exit;
  end;
  
  if slBooks.Count = 0 then begin
    MessageDlg('Read Books Skyrim mod(s) don''t conflict with other loaded mods, nothing to patch', mtInformation, [mbOk], 0);
    slBooks.Free;
    Exit;
  end;
  
  slBooks.Sort;
  
  frm := frmFileSelect;
  frm.Width := 700;
  try
    frm.Caption := 'Books to patch';
    clb := TCheckListBox(frm.FindComponent('CheckListBox1'));
    clb.Items.Assign(slBooks);
    for i := 0 to Pred(clb.Items.Count) do
      clb.Checked[i] := True;
    if frm.ShowModal <> mrOk then
      Exit;
    for i := 0 to Pred(clb.Items.Count) do
      if clb.Checked[i] then
        if not PatchBook(ObjectToElement(clb.Items.Objects[i])) then
          Exit;
  finally
    frm.Free;
    slBooks.Free;
    SortMasters(pluginPatch);
  end;

  if Assigned(pluginPatch) then begin
    SortMasters(pluginPatch);
    CleanMasters(pluginPatch);
    MessageDlg('Patch file created. Don''t forget to rebuild the patch if you uninstalled or changed load order of patched plugins.', mtInformation, [mbOk], 0);
  end
end;

end.

{
  Bookmarking functions.
  Display a list of bookmarks if called directly.
  Mode: Silent
}
unit Bookmark;

// set Bookmark for a record
procedure BookmarkSet(e: IInterface; aBookmark: integer);
var
  ini: TMemIniFile;
begin
  AddMessage(Format('Setting Bookmark %d to %s, use Alt+%d to go back', [aBookmark, Name(e), aBookmark]));
  ini := TMemIniFile.Create(ScriptsPath + 'Bookmark.ini');
  ini.WriteString(wbGameName, 'Bookmark' + IntToStr(aBookmark), GetFileName(e) + ':' + IntToHex(FixedFormID(e), 8));
  ini.UpdateFile;
  ini.Free;
end;

// go back to a Bookmark
procedure BookmarkGo(aBookmark: integer);
var
  ini: TMemIniFile;
  f, rec: IInterface;
  s, filename: string;
  p, i: integer;
begin
  ini := TMemIniFile.Create(ScriptsPath + 'Bookmark.ini');
  s := ini.ReadString(wbGameName, 'Bookmark' + IntToStr(aBookmark), '');
  ini.Free;
  if s = '' then Exit;
  p := Pos(':', s);
  if p = 0 then Exit;
  filename := Copy(s, 1, Pred(p));
  for i := 0 to Pred(FileCount) do begin
    f := FileByIndex(i);
    if SameText(GetFileName(f), filename) then begin
      rec := RecordByFormID(f, StrToInt('$' + Copy(s, Succ(p), 8)), True);
      if Assigned(rec) then
        JumpTo(rec, False);
      Exit;
    end;
  end;
end;

// show a list of bookmarks
function Finalize: Integer;
var
  ini: TMemIniFile;
  i: integer;
  marks, s: string;
begin
  ini := TMemIniFile.Create(ScriptsPath + 'Bookmark.ini');
  for i := 0 to 9 do begin
    s := ini.ReadString(wbGameName, 'Bookmark' + IntToStr(i), '');
    if s <> '' then marks := marks + Format('Alt+%d  %s'#10, [i, s]);
  end;
  ini.Free;
  if marks = '' then marks := 'No bookmarks';
  MessageDlg(marks, mtInformation, [mbOk], 0);
end;

end.
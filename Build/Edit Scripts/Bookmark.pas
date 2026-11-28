{
  Bookmarking functions.
  Display a list of bookmarks if called directly.
  Mode: Silent
}
unit Bookmark;

// on Morrowind, the text that identifies a record together with its signature (a response belongs to its topic)
function BookmarkTES3Key(e: IInterface): string;
begin
  Result := EditorID(e);
  if Signature(e) = 'INFO' then
    Result := EditorID(ChildrenOf(GetContainer(e))) + #9 + Result;
end;

// set Bookmark for a record
procedure BookmarkSet(e: IInterface; aBookmark: integer);
var
  ini: TMemIniFile;
begin
  if not Assigned(e) then Exit;
  AddMessage(Format('Setting Bookmark %d to %s, use Alt+%d to go back', [aBookmark, Name(e), aBookmark]));
  ini := TMemIniFile.Create(ScriptsPath + 'Bookmark.ini');
  // a Morrowind record's number depends on the load order, so its signature and key are stored to check it
  if wbGameMode = gmTES3 then
    ini.WriteString(wbGameName, 'Bookmark' + IntToStr(aBookmark), GetFileName(e) + ':' + IntToHex(FixedFormID(e), 8) + ':' + Signature(e) + ':' + BookmarkTES3Key(e) + ':')
  else
    ini.WriteString(wbGameName, 'Bookmark' + IntToStr(aBookmark), GetFileName(e) + ':' + IntToHex(FixedFormID(e), 8));
  ini.UpdateFile;
  ini.Free;
end;

// on Morrowind, the record the stored number names if its file, signature and key still match; else, for a kind found by its name alone, the record of that name
function BookmarkTES3Record(f, rec: IInterface; s, filename: string): IInterface;
var
  sig, key: string;
begin
  Result := nil;
  if (Length(s) < 15) or (Copy(s, 9, 1) <> ':') or (Copy(s, 14, 1) <> ':') or (Copy(s, Length(s), 1) <> ':') then Exit;
  sig := Copy(s, 10, 4);
  key := Copy(s, 15, Length(s) - 15);
  if Assigned(rec) then
    if SameText(GetFileName(rec), filename) and SameText(Signature(rec), sig) and SameText(BookmarkTES3Key(rec), key) then begin
      Result := rec;
      Exit;
    end;
  if (key <> '') and (Pos(sig, 'CELL INFO LAND PGRD REFR TES3') = 0) then
    Result := MainRecordByEditorID(GroupBySignature(f, sig), key);
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
  s := Copy(s, Succ(p), Length(s));
  for i := 0 to Pred(FileCount) do begin
    f := FileByIndex(i);
    if SameText(GetFileName(f), filename) then begin
      rec := RecordByFormID(f, StrToInt('$' + Copy(s, 1, 8)), True);
      if wbGameMode = gmTES3 then begin
        rec := BookmarkTES3Record(f, rec, s, filename);
        if not Assigned(rec) then begin
          MessageDlg(Format('Bookmark %d no longer finds its record in %s; set it again.', [aBookmark, filename]), mtInformation, [mbOk], 0);
          Exit;
        end;
      end;
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

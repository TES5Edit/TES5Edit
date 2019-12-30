{
  Read Books Aloud dynamic patcher.
  
  Hotkey: Ctrl+Shift+B
}
unit ReadBooksAloud;

const
  sRBAFileName = 'ReadBooksAloud.esm';

var
  pluginRBA, pluginPatch: IInterface;
  tplBook, tplSound, tplSoundMarker: IInterface;
  bPatchAll, bSkipBooksWithNoAudio: boolean;
  slBooks: TStringList;

//=========================================================================================
// patching a book record
function PatchBook(Book: IInterface): boolean;
var
  recSNDR, recSOUN, recBOOK, props, prop: IInterface;
  s: string;
begin
  Result := True;

  // skip already patched books
  s := EditorID(Book);
  if slBooks.IndexOf(s) <> -1 then
    Exit;
  slBooks.Add(s);

  // skip book that doesn't have an audio file 
  s := 'Sound\FX\AudioBooks\' + ChangeFileExt(GetFileName(MasterOrSelf(Book)), '') + '\' + EditorID(Book) + '_01.xwm';
  if bSkipBooksWithNoAudio then
    if not ResourceExists(s) then
      Exit;
  
  // getting the last override
  Book := WinningOverride(Book);

  // create a new patch plugin if needed
  if not Assigned(pluginPatch) then
    pluginPatch := AddNewFile;
  if not Assigned(pluginPatch) then begin
    Result := False;
    Exit;
  end;

  // create a sound descriptor from template
  AddRequiredElementMasters(tplSound, pluginPatch, False);
  recSNDR := wbCopyElementToFile(tplSound, pluginPatch, True, True);
  if not Assigned(recSNDR) then begin
    AddMessage('Unable to copy template as a new record into patch file: ' + Name(tplSound));
    Result := False;
    Exit;
  end;
  SetElementEditValues(recSNDR, 'EDID', '_SD_' + EditorID(Book) + '_01');
  SetElementEditValues(recSNDR, 'Sounds\Sound Files\ANAM - File Name', s);
  
  // create a sound marker from template
  AddRequiredElementMasters(tplSoundMarker, pluginPatch, False);
  recSOUN := wbCopyElementToFile(tplSoundMarker, pluginPatch, True, True);
  if not Assigned(recSOUN) then begin
    AddMessage('Unable to copy template as a new record into patch file: ' + Name(tplSoundMarker));
    Result := False;
    Exit;
  end;
  SetElementEditValues(recSOUN, 'EDID', '_SM_' + EditorID(Book) + '_01');
  SetElementEditValues(recSOUN, 'SDSC', Name(recSNDR));

  // scipt books with scripts already attached
  if ElementExists(Book, 'VMAD') then begin
    AddMessage('Skipping because scripts already attached: ' + Name(Book));
    Exit;
  end;
  
  // create override for book
  AddRequiredElementMasters(Book, pluginPatch, False);
  recBOOK := wbCopyElementToFile(Book, pluginPatch, False, True);
  if not Assigned(recBOOK) then begin
    AddMessage('Unable to copy book record as override into patch file: ' + Name(Book));
    Result := False;
    Exit;
  end;
  Add(recBOOK, 'VMAD', True);
  ElementAssign(ElementByPath(recBOOK, 'VMAD'), LowInteger, ElementByPath(tplBook, 'VMAD'), False);
  props := ElementByPath(recBOOK, 'VMAD\Data\Scripts\Script\Properties');
  prop := ElementByIndex(props, 0);
  SetElementEditValues(prop, 'String', GetElementEditValues(recBOOK, 'FULL'));
  prop := ElementByIndex(props, 2);
  SetElementEditValues(prop, 'Value\Object Union\Object v2\FormID', Name(recSOUN));
end;
  
//=========================================================================================
function Initialize: integer;
var
  i, j: integer;
  f, g: IInterface;
begin
  for i := 0 to Pred(FileCount) do
    if SameText(GetFileName(FileByIndex(i)), sRBAFileName) then
      pluginRBA := FileByIndex(i);
  
  if not Assigned(pluginRBA) then begin
    MessageDlg('Read Books Aloud plugin is not loaded: ' + sRBAFileName, mtError, [mbOk], 0);
    Result := 1;
  end;
  
  tplBook := MainRecordByEditorID(GroupBySignature(pluginRBA, 'BOOK'), 'RBABookTemplate');
  if not Assigned(tplBook) then begin
    MessageDlg('Unable to locate book template record in ' + sRBAFileName  + ', please reinstall.', mtError, [mbOk], 0);
    Result := 1;
  end;

  tplSound := MainRecordByEditorID(GroupBySignature(pluginRBA, 'SNDR'), 'RBASoundTemplate');
  if not Assigned(tplSound) then begin
    MessageDlg('Unable to locate sound template record in ' + sRBAFileName  + ', please reinstall.', mtError, [mbOk], 0);
    Result := 1;
  end;

  tplSoundMarker := RecordByFormID(FileByIndex(0), $00000E06, False); // AMBRumbleShakeGreybeards [SOUN:00000E06]
  
  i := MessageDlg('Do you want to patch all loaded plugins [YES] or only selected record [NO]', mtConfirmation, [mbYes, mbNo, mbCancel], 0);
  if i = mrYes then bPatchAll := True else
    if i = mrNo then bPatchAll := False else begin
      Result := 1;
      Exit;
    end;
  i := MessageDlg('Skip books that don''t have an audio file in data folder?', mtConfirmation, [mbYes, mbNo], 0);
  if i = mrYes then bSkipBooksWithNoAudio := True else
    if i = mrNo then bSkipBooksWithNoAudio := False else begin
      Result := 1;
      Exit;
    end;

  slBooks := TStringList.Create;

  if not bPatchAll then
    Exit;
  
  for i := 0 to Pred(FileCount) do begin
    f := FileByIndex(i);
    if SameText(GetFileName(f), sRBAFileName) then
      Continue;
    g := GroupBySignature(f, 'BOOK');
    for j := 0 to Pred(ElementCount(g)) do
      if not PatchBook(ElementByIndex(g, j)) then begin
         Result := 1;
         Exit;
      end;
  end;
  
  Result := 1;
end;

//=========================================================================================
function Process(e: IInterface): integer;
begin
  if Signature(e) = 'BOOK' then
    if not PatchBook(e) then begin
      Result := 1;
      Exit;
    end;
end;

//=========================================================================================
function Finalize: integer;
begin
  if Assigned(pluginPatch) then begin
    SortMasters(pluginPatch);
    MessageDlg('Patch file created. Don''t forget to rebuild the patch if you uninstall or change load order of patched plugins.', mtInformation, [mbOk], 0);
  end
  else
    AddMessage('Sorry, nothing to patch.');

  slBooks.Free;
end;

end.

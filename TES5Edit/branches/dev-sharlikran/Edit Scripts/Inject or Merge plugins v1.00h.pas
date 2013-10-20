{
  Inject or Merge Plugins Script v1.00h
  Created by matortheeternal, modified by hlp
  http://skyrim.nexusmods.com/mod/37981
  
  This script will allow you to merge any number of loaded ESP files into a
  single merged file.  This is achieved by the method detailed in this thread
  on Nexus Mods: 
  
  http://forums.nexusmods.com/index.php?/topic/904953-how-to-merge-multiple-mods-with-multiple-master-files
  
  You can also inject those plugin into an existing master to create compilation of resource.
  
  You can set user variables at line 71 to customize how the script runs.
  
  Enjoy! :)
  -Mator
}
unit InjectOrMerge;

uses 
	'Apply filter for cleaning';

var
  fileprompt, manymessages, moremessages, mergemasters , mergereferences: boolean;
  trackingAllEditorID: boolean;
  slMerge, slMasters: TStringList;
  NewFormID: Cardinal;

// Called before processing
// You can remove it if script doesn't require initialization code
function Initialize: integer;
var
  i, 
  j, 
  k            : Integer;
  l			   : Integer;
  Source       : Integer;
  Target       : Integer;
  BaseFile     : Integer;	// Skips the .exe pseudo master in indexes
  Loop		   : Integer;
  RC		   : Int64;
  TargetFormID : Cardinal;
  f, 
  e, 
  mgf, 
  group, 
  masters      : IInterface;
  r			   : IInterface;
  h			   : IInterface;
  merge, 
  s            : string;
  
  OldFormID    : Cardinal;
  self, 
  Done         : boolean;
  DoUpward     : boolean;
  DoDownward   : boolean;
  Records	   : array [0..$FFFFFF] of IInterface;

  EditorIDPrefixRemove : string;
  EditorIDPrefix       : string;
  EditorIDSuffix       : string;
  
begin
	// set user variables
	// --------------------------------------------------------------------------

	// disable this to automatically merge all loaded files
	fileprompt := true;
	// disable this to print less messages to the message log
	manymessages := true;
	moremessages := true;
	// set this to true to allow the merging of master files (USE AT YOUR OWN RISK!).
	mergemasters := true and fileprompt;
	// set this to false to disallow the merging of references.
	mergereferences := False;
	
	// --------------------------------------------------------------------------
	// end user variables

	// welcome messages
	AddMessage(#13#10#13#10#13#10);
	AddMessage('-----------------------------------------------------------------------------');
	AddMessage('Merge plugins v1.00h: Merges esp files.  Won''t work with scripts!');
	AddMessage('-----------------------------------------------------------------------------');
	// end welcome messages

	// stringlist creation
	slMerge := TStringList.Create;
	slMasters := TStringList.Create;
	slMasters.Sorted := True;
	slMasters.Duplicates := dupIgnore;
	// done creating stringlists/

	// Is Edit tracking all EditorID or only MGEF and globals ?
	trackingAllEditorID := wbTrackAllEditorID;
	if not trackingAllEditorID then begin
		AddMessage(#13#10+'Consider tracking all EditorID in Settings to avoid duplicating EditorID during merge');
	end;
	
	// select/automatically recognize plugins for merging
	BaseFile := 1;
	for i := 0 to FileCount - 1 do begin
		f := FileByIndex(i);
		s := GetFileName(f);
		AddMessage('File "'+s+'"');
		if Pos('.esm', s) > 0 then slMasters.Add(s);
		if Pos('.exe', s) > 0 then BaseFile := i+1;
		// skip masters which shouldn't be merged under any conditions
		if Pos('.exe', s) > 0 then Continue;
		if SameText(s, 'Oblivion.esm') or SameText(s, 'Fallout3.esm') or SameText(s, 'FalloutNV.esm') 
		or SameText(s, 'DeadMoney.esm') or SameText(s, 'HonestHearts.esm')
		or SameText(s, 'OldWorldBlues.esm') or SameText(s, 'LonesomeRoad.esm')
		or SameText(s, 'GunRunnersArsenal.esm') or SameText(s, 'Anchorage.esm')
		or SameText(s, 'ThePitt.esm') or SameText(s, 'BrokenSteel.esm') 
		or SameText(s, 'PointLookout.esm') or SameText(s, 'Zeta.esm')
		or SameText(s, 'TaleOfTwoWastelands.esm')
		or SameText(s, 'Skyrim.esm') or SameText(s, 'Update.esm')
		or SameText(s, 'Dawnguard.esm') or SameText(s, 'Dragonborn.esm') then Continue;
		if not mergemasters and Pos('.esm', s) > 0 then Continue;
		if fileprompt then begin
			merge := MessageDlg('Merge "'+s+'"?', mtConfirmation, [mbYes, mbNo], 0);
			if SameText(merge, '6') then begin
				slMerge.Add(IntToStr(i));
				AddMessage('Merging '+s);
				slMasters.Add(s);
			end;
		end;
		if not fileprompt then begin
			slMerge.Add(IntToStr(i));
			AddMessage('Merging '+s);
			slMasters.Add(s);
		end;
	end;
	
	// terminate script if mergelist is empty
	if slMerge.Count = 0 then begin
		AddMessage(#13#10+'No files selected for merging!  Terminating script.');
		exit;
	end;

	// create or identify merge file
	Done := False;
	mgf := nil;
	AddMessage(#13#10+'Preparing merged file...');
	repeat
		s := InputBox('Use existing file?', 'If you already have a plugin which you would like to serve as your merged file please specify its name or its load order number below, otherwize leave this field blank.', '');
		if s = '' then begin
			MessageDlg('Enter the name you wish to use for your merged file in the next window or press cancel to terminate the script.', mtConfirmation, [mbOk], 0);
			mgf := AddNewFile;
			Done := True;
		end;
		for i := 0 to FileCount - 1 do begin
			f := FileByIndex(i);
			if SameText(Lowercase(GetLoadOrder(f)), Lowercase(s)) or SameText(Lowercase(GetFileName(f)), Lowercase(s)) then begin
				Done := True;
				mgf := FileByIndex(i);
				Break;
			end;
		end;
		if not Done and not SameText(s, '') then AddMessage('The file ' + s + ' was not found.' + #13#10);
	until Done;

	// merge file confirmation or termination
	if not Assigned(mgf) then begin
		AddMessage('    No merge file assigned.  Terminating script.' + #13#10);
		exit;
	end;
	
	Target := GetLoadOrder(mgf);
	DoUpward := False;
	DoDownward := False;
	for i := 0 to slMerge.Count - 1 do begin
		Source := GetLoadOrder(FileByIndex(StrToInt(slMerge[i])));
		if  Source > Target then 
			DoUpward := True
		else if Source = Target then begin
			AddMessage('    You can''t merge a file into itself.  Terminating script.');
			Exit;
		end;
	end;
	if not DoUpward then DoDownward := True;
	AddMessage('    Script is using ' + GetfileName(mgf) + ' as the merge file.');

	EditorIDPrefixRemove := InputBox('EditorID Prefix to Remove', 'Please enter the prefix that should be removed from the EditorIDs if present', '');
	EditorIDPrefix       := InputBox('EditorID Prefix', 'Please enter the prefix that should be added to EditorIDs', '');
	EditorIDSuffix       := InputBox('EditorID Suffix', 'Please enter the suffix that should be added to EditorIDs', '');

	if DoUpward then begin	// Some plugins lie about their Next Object ID
		r := nil;
		h := nil;
		TargetFormID := 0;
		for j := 0 to RecordCount(mgf) - 1 do begin
			e := RecordByIndex(mgf, j);
			if Signature(e)='TES4' then Continue;
			if FormID(e)>TargetFormID then
				TargetFormID := FormID(e);
		end;
		TargetFormID := TargetFormID mod $1000000;
		
		r := ElementByIndex(mgf, 0);
		if Assigned(r) then
			h := ElementBySignature(r, 'HEDR');
		if Assigned(h) then begin
			if StrToInt(GetElementNativeValues(h, 'Next Object ID')) <= TargetFormID then
				SetElementNativeValues(h, 'Next Object ID', IntToStr(Succ(TargetFormID)));
		end;
	end;

	// renumber forms in files to be merged
	if DoDownward then
		s := MessageDlg('Have you already renumbered FormIDs?', mtConfirmation, [mbYes, mbNo], 0);
	if DoUpward or SameText(s, '7') then begin
		AddMessage(#13#10+'Renumbering required FormIDs before merging...');
		NewFormID := 0;
		for i := 0 to slMerge.Count - 1 do begin
			Source := StrToInt(slMerge[i]);
			f := FileByIndex(Source);
			if (DoUpward and (Source>Target)) then
				AddMasterIfMissing(f, GetFileName(mgf));
			if (DoDownward and (Source<Target)) then
				AddMasterIfMissing(mgf, GetFileName(f));
			
			if (DoDownward and (Source<Target)) or (DoUpward and (Source>Target)) then begin
				AddMessage('    Processing records in file '+GetFileName(f));
				if NewFormID > 0 then
					if (DoUpward and (Source>Target)) then 
						if (NewFormID div $1000000) <> GetLoadOrder(mgf) then // Last FormID was not from master
							NewFormID := 0
						else
							NewFormID := StrToInt64('$' + IntToHex64(GetLoadOrder(mgf), 2) + Copy(IntToHex64(NewFormID, 8), 3, 6))
					else
						if (NewFormID div $1000000) = GetLoadOrder(mgf) then // Last FomrID was from master
							NewFormID := 0
						else
							NewFormID := StrToInt64('$' + IntToHex64(GetLoadOrder(f), 2) + Copy(IntToHex64(NewFormID, 8), 3, 6));

				if (DoDownward and (Source<Target)) then begin	// Some plugins lie about their Next Object ID
					r := nil;
					h := nil;
					TargetFormID := 0;
					for j := 0 to RecordCount(f) - 1 do begin
						e := RecordByIndex(f, j);
						if Signature(e)='TES4' then Continue;
						if FormID(e)>TargetFormID then
							TargetFormID := FormID(e);
					end;
					TargetFormID := TargetFormID mod $1000000;
					
					r := ElementByIndex(f, 0);
					if Assigned(r) then
						h := ElementBySignature(r, 'HEDR');
					if Assigned(h) then begin
						s := GetElementNativeValues(h, 'Next Object ID');
						if StrToInt(s) <= TargetFormID then
							SetElementNativeValues(h, 'Next Object ID', IntToStr(Succ(TargetFormID)));
					end;
				end;

				RC := RecordCount(f) - 1;
				for j := 0 to RC do
					Records[j] := RecordByIndex(f, j);
					
				for j := 0 to RC do begin
					e := Records[j];
					if moremessages then 
						AddMessage(Format('---%s: ''%s'' [%s] on "%s"', [Signature(e), EditorID(e), IntToHex64(FormID(e), 8), Name(e)]));
					if (Signature(e)='TES4') then Continue;
					if not mergereferences and ((Signature(e)='REFR') or (Signature(e)='ACHR')
						or (Signature(e)='ACRE') or (Signature(e)='PGRE') or (Signature(e)='NAVM') or (Signature(e)='NAVI')
						or (Signature(e)='CELL') or (Signature(e)='WRLD')) then Continue;
						  
					// skip override records (have to test with intervening mods)
					self := Equals(MasterOrSelf(e), e);
					if not self then begin
						if moremessages then 
							AddMessage(Format('        Skiping FormID [%s] on %s', [IntToHex64(FormID(e), 8), Name(e)]));
						Continue;
					end;
					if moremessages then 
						AddMessage(Format('        Trying FormID [%s] on %s', [IntToHex64(FormID(e), 8), Name(e)]));
					  
					OldFormID := GetLoadOrderFormID(e);

					if trackingAllEditorID then begin
						s := EditorID(e);
						if (s<>'') and ((EditorIDPrefix <> '') or (EditorIDSuffix <> '') or (EditorIDPrefixRemove<>'')) then begin
							if SameText(Copy(s, 1, Length(EditorIDPrefixRemove)), EditorIDPrefixRemove) then
								s := Copy(s, Succ(Length(EditorIDPrefixRemove)), Length(s));
							if s <> '' then begin
								s := EditorIDPrefix + s + EditorIDSuffix;
								SetEditorID(e, s);
							end else
								s := EditorID(e);
						end;
						r := RecordByEditorID(mgf, s);
					end else begin
						r := nil;
					end;
					if Assigned(r) then begin // We will update not create
						TargetFormID := FormID(r);
						if manymessages then 
							AddMessage(Format('        Updating EditorID %s from [%s] to [%s] on %s', [EditorID(r), IntToHex64(OldFormID, 8), IntToHex64(TargetFormID, 8), Name(e)]));
					end else begin
						s := '200000';
						
						// set up form id junk
						if NewFormID = 0 then begin
							// Lets find Next Object ID
							r := nil;
							h := nil;
							if (DoUpward and (Source>Target)) then
								r := ElementByIndex(mgf, 0)
							else
								r := ElementByIndex(f, 0);
							if Assigned(r) then
								h := ElementBySignature(r, 'HEDR');
							if Assigned(h) then begin
								s := IntToHex64(StrToInt(GetElementNativeValues(h, 'Next Object ID')), 6);
							end;

							Repeat
								s := InputBox('Start from...', 'Please enter a new start FormID in hex.  e.g. 200000.  Specify only the last 6 digits.', s);
								if Length(s) > 0 then
									if (Length(s) < 4) or (Length(s) > 6) then
										AddMessage('    Invalid entry.  Please try again.')
									else
										if (DoUpward and (Source>Target)) then 
											NewFormID := StrToInt64('$' + IntToHex64(GetLoadOrder(mgf), 2) + s)
										else
											NewFormID := StrToInt64('$' + IntToHex64(GetLoadOrder(f), 2) + s);
							until (Length(s) = 0) or (NewFormID > 0);
						end;
						if Length(s) = 0 then // Exit in the repeat until block seems unreliable
							Exit;
							
						// exit if formids are identical, nothing to change
						if NewFormID = OldFormID then Continue;

						TargetFormID := NewFormID;
					
						if manymessages then 
							AddMessage(Format('        Changing FormID ''%s'' from [%s] to [%s] on %s', [EditorID(e), IntToHex64(OldFormID, 8), IntToHex64(TargetFormID, 8), Name(e)]));
						  
					end;

					// first change formid of references
					while (ReferencedByCount(e) > 0) do
						CompareExchangeFormID(ReferencedByIndex(e, 0), OldFormID, TargetFormID);

					// change formid of record
					SetLoadOrderFormID(e, TargetFormID);
					  
					if TargetFormID = NewFormID then begin
						// increment formid
						Inc(NewFormID);

						// Memorize highest FormID
						SetElementNativeValues(h, 'Next Object ID', IntToStr(NewFormID mod $1000000));
					end else
						// Update main Record
						if Assigned(r) then begin
							if moremessages then
								AddMessage(Format('        Setting data for FormID ''%s'' [%s] as %s', [EditorID(r), IntToHex64(TargetFormID, 8), Name(r)]));
							ElementAssign(r, LowInteger, e, False);
						end;
					  
				end;
			end;
		end;
	end;

	if DoDownward then begin
		// add masters
		AddMessage('    Adding masters to merge file...');
		for i := 0 to slMasters.Count - 1 do begin
			if not SameText(Lowercase(slMasters[i]), Lowercase(GetFileName(mgf))) then
				AddMasterIfMissing(mgf, slMasters[i]);
		end;
	end;

	// the merging process
	AddMessage(#13#10+'Beginning merging process...');
	for i := slMerge.Count - 1 downto 0 do begin
		Source := StrToInt(slMerge[i]);
		f := FileByIndex(Source);
		AddMessage('    Copying records from '+GetFileName(f));
		for j := 0 to ElementCount(f) - 1 do begin
			e := ElementByIndex(f, j);
			if Signature(e) = 'TES4' then Continue;
			if not mergereferences and (SameText(Name(e), 'GRUP Top "CELL"') 
			or SameText(Name(e), 'GRUP Top "WRLD"')
			or SameText(Name(e), 'GRUP Top "NAVI"')) then
				Continue;
			if manymessages then
				AddMessage('        Copying '+Name(e));
			if (EditorIDPrefix <> '') or (EditorIDSuffix <> '') or (EditorIDPrefixRemove<>'') then
				wbCopyElementToFileWithPrefix(e, mgf, False, True, EditorIDPrefixRemove, EditorIDPrefix, EditorIDSuffix)
			else
				wbCopyElementToFile(e, mgf, False, True);
		end;
		// removing masters
		CleanMasters(f);
		// fix order of remaining masters
		SortMasters(f);
	end;

	if mergereferences then begin
		s := MessageDlg('Cancel changes to plugins?', mtConfirmation, [mbYes, mbNo], 0);
		if SameText(s, '6') then
			for i := 0 to slMerge.Count - 1 do begin
				Source := StrToInt(slMerge[i]);
				f := FileByIndex(Source);
				ClearElementState(f, esUnsaved);
			end 
		else
			userscript.Initialize;
	end else
		userscript.Initialize;
	
// inform user they need to renumber form IDs as the last step.
	AddMessage(#13#10);
	AddMessage('-----------------------------------------------------------------------');
	AddMessage('Your merged file has been created.');

	Result := -1;
end;

end.

{
  Exports the list of ARMO records.
}

unit ListARMO;

var
  slARMO: TStringList;
  slARMObipedFlags : TStringList;
  slFLST: TStringList;
  slFLSTforms : TStringList;

function Initialize: integer;
var
  s, b: String;
  i : Integer;
begin
  slARMO := TStringList.Create;
  s := 'FileName;FormID;EditorID;FullName;ObjectEffect;BipedFlags;BipedList;RepairList;AR;DT;Health;Value;MaleMesh;FemaleMesh';
  slARMO.Add(s);
  slARMObipedFlags := TStringList.Create;
  s := 'FileName;FormID;BipedFlagsIndex;BipedFlagsValue';
  slARMObipedFlags.Add(s);
  slFLST := TStringList.Create;
  s := 'FileName;FormID;EditorID;';
  slFLST.Add(s);
  slFLSTforms := TStringList.Create;
  s := 'FileName;FormID;FormIndex;Form;';
  slFLSTforms.Add(s);
end;

function Process(e: IInterface): integer;
var
  s, k, b: String;
  i, r : Integer;
  bf, v: Int64;
  a, m: IInterface;
begin
  if Signature(e) = 'ARMO' then begin
    k := GetFileName(GetFile(e))+';'+IntToHex(FormID(e), 8)+';';
    s := k+EditorID(e)+';';
    if ElementExists(e, 'FULL') then s := s+GetEditValue(ElementBySignature(e,'FULL')); s := s+';';
    if ElementExists(e, 'EITM') then i := GetNativeValue(ElementBySignature(e,'EITM')) else i := 0; s := s+IntToHex(i, 8)+';';
    bf := GetNativeValue(ElementByPath(e,'BMDT - Biped Data\Biped Flags'));
    s := s+IntToStr(bf)+';';
    if ElementExists(e, 'BIPL') then i := GetNativeValue(ElementBySignature(e,'BIPL')) else i := 0; s := s+IntToHex(i, 8)+';';
    if ElementExists(e, 'REPL') then i := GetNativeValue(ElementBySignature(e,'REPL')) else i := 0; s := s+IntToHex(i, 8)+';';
    v := GetNativeValue(ElementByPath(e,'DNAM - \AR'));					s := s+IntToStr(v)+';';
    v := GetNativeValue(ElementByPath(e,'DNAM - \DT'));					s := s+IntToStr(v)+';';
    v := GetNativeValue(ElementByPath(e,'DATA - Data\Health'));	s := s+IntToStr(v)+';';
    v := GetNativeValue(ElementByPath(e,'DATA - Data\Value'));	s := s+IntToStr(v)+';';
    s := s+GetEditValue(ElementByPath(e,'Male biped model\MODL - Model Filename'))+';';
    s := s+GetEditValue(ElementByPath(e,'Female biped model\MOD3 - Model Filename'))+';';
	
    slARMO.AddObject(s, TObject(e));

    for i := 0 to 31 do begin
      b := InttoStr((bf shr i) and 1); 
      s := k+IntToStr(i)+';'+b+';';
      slARMObipedFlags.Add(s);
    end;
  end;
  if Signature(e) = 'FLST' then begin
    k := GetFileName(GetFile(e))+';'+IntToHex(FormID(e), 8)+';';
    s := k+EditorID(e)+';';
    slFLST.AddObject(s, TObject(e));
    a := ElementByIndex(e, 2);
    if Assigned(a) then
      for i := 0 to ElementCount(a)-1 do begin
        m := ElementByIndex(a, i);
        r := GetNativeValue(m);
        s := IntToHex(r, 8);
        s := k + IntToStr(i)+';'+s+';';
        slFLSTforms.Add(s);
      end;
  end;
end;

function Finalize: integer;
var
  dlgSave: TSaveDialog;
begin
  if (slARMO.Count > 1) or (slFLST.Count > 1) then begin
    dlgSave := TSaveDialog.Create(nil);
    dlgSave.Options := dlgSave.Options + [ofOverwritePrompt];
    dlgSave.Filter := 'CSV files (*.csv)|*.csv';
    dlgSave.InitialDir := DataPath;
    dlgSave.FileName := 'ARMO Objects.csv';
    if dlgSave.Execute then begin
      AddMessage('Saving ' + dlgSave.FileName);
      if (slARMO.Count > 1) then begin
				slARMO.SaveToFile(dlgSave.FileName);
				slARMObipedFlags.SaveToFile(ChangeFileExt(dlgSave.FileName, '-BF.csv'));
				slFLST.SaveToFile(ChangeFileExt(dlgSave.FileName, '-FL.csv'));
			end else
			  slFLST.SaveToFile(dlgSave.FileName);
      if (slFLST.Count > 1) then
				slFLSTforms.SaveToFile(ChangeFileExt(dlgSave.FileName, '-LF.csv'));
    end;
    dlgSave.Free;
  end;
  slARMO.Free;
  slARMObipedFlags.Free;
  slFLST.Free;
  slFLSTforms.Free;
end;

end.

{
  Reports undefined, NONE and invalid script properties in selected records.
  Requires script source files to report undefined properties.
}
unit UserScript;

var
  slProps: TStringList;
  regexp: TPerlRegEx;
  LastRec: IInterface;
  LastScript, LastProperty: string;

//======================================================================
function Initialize: integer;
begin
  slProps := TStringList.Create;
  regexp := TPerlRegEx.Create;
  regexp.Options := [preCaseLess, preMultiLine, preSingleLine];
  regexp.RegEx := '^[\w\[\]]+\sproperty\s(\w+)(.*?)$';
  regexp.Study;
  LastScript: = '';
  LastProperty := '';
end;

//======================================================================
procedure ReadScriptProperties(aScriptName: string);
var
  s: string;
begin
  try
    slProps.Clear;
    slProps.LoadFromFile(DataPath + 'Scripts\Source\' + aScriptName + '.psc');
  except end;

  if slProps.Count = 0 then begin
    //AddMessage('Error reading script source for ' + aScriptName);
    Exit;
  end;
    
  regexp.Subject := slProps.Text;
  slProps.Clear;
  while regexp.MatchAgain do begin
    s := Trim(regexp.Groups[2]);
    if s = '' then Continue; // property has set an get functions
    if s[1] = '=' then Continue; // property has value
    slProps.Add(regexp.Groups[1]);
  end;
end;

//======================================================================
procedure ReportMissingProps(rec: IInterface);
var
  i: integer;
begin
  //if LastScript = '' then Exit;
  for i := 0 to slProps.Count - 1 do
    AddMessage(Format('%s \ %s \ %s property IS UNDEFINED', [Name(rec), LastScript, slProps[i]]));
  slProps.Clear;
end;

//======================================================================
procedure ScanVMAD(e: IInterface);
var
  ElemName: string;
  i: integer;
begin
  ElemName := Name(e);
  
  // new script entry
  if ElemName = 'ScriptName' then begin
    // report missing props for previous script
    ReportMissingProps(LastRec);
    LastScript := GetEditValue(e);
    ReadScriptProperties(LastScript);
  end else

  // new property entry
  if ElemName = 'propertyName' then begin
    LastProperty := GetEditValue(e);
    // property exists, delete from list
    i := slProps.IndexOf(LastProperty);
    if i <> -1 then slProps.Delete(i);
  end else

  // new object property value entry
  if ElemName = 'FormID' then begin
    if GetNativeValue(e) = 0 then
      AddMessage(Format('%s \ %s \ %s property IS NONE', [Name(LastRec), LastScript, LastProperty]))
    else if not Assigned(LinksTo(e)) then
      AddMessage(Format('%s \ %s \ %s property IS INVALID', [Name(LastRec), LastScript, LastProperty]));
  end else
  
  // skip fragments, they contain scripts without properties
  if Pos('Fragments', ElemName) > 0 then
    Exit;
  
  for i := 0 to ElementCount(e) - 1 do
    ScanVMAD(ElementByIndex(e, i));
end;

//======================================================================
function Process(e: IInterface): integer;
begin
  // process VMAD subrecord only
  if ElementType(e) = etMainRecord then
    if ElementExists(e, 'VMAD') then begin
      LastRec := e;
      ScanVMAD(ElementBySignature(e, 'VMAD'));
      ReportMissingProps(e);
    end;
end;

//======================================================================
function Finalize: integer;
begin
  slProps.Free;
  regexp.Free;
end;

end.

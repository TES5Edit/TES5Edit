{
  Purpose: To quickly set the ESL flag on selected files that support it.
            Must be used with -PseudoESL.
    Usage:  Start xEdit with the -PseudoESL command line argument. Select the plugins
            you wish to check and flag for ESL. Click OK. Once loaded select the
            files and apply this script. It will skip any files xEdit deems unsafe
            to flag as ESL. Once done close xEdit and save plugins.
  Games: Fallout 4 / Skyrim Special Edition
  Author: Jonathan Ostrus
}
unit userscript;

// Set ExtraSpammy true if you want to be told about skipped files
const ExtraSpammy = false;

var SkipProcess : boolean;

function Initialize: integer;
begin
  Result := 0;
  
  // check for PseudoESL mode
  if not wbIsPseudoESLMode then begin
    AddMessage('xEdit must be started with the -PseudoESL argument in order to use this script.');
    SkipProcess := true;
    Result := 1;
    exit;
  end;
  
  // process only file elements
  try 
    ScriptProcessElements := [etFile];
  except on Exception do
    SkipProcess := true;
    Result := 2;
  end;
end;

// called for every record selected in xEdit
function Process(f: IInterface): integer;
var fs : string;
begin
  Result := 0;
  
  // Safety check. This should never happen.
  // But quick ditch if there was a problem.
  if SkipProcess then begin
    Result := 1001;
    exit;
  end;

  if (ElementType(f) = etMainRecord) then 
    exit;

  fs := GetFileName(f);

  if not CanBeESL(f) then begin
    if ExtraSpammy then
      AddMessage('warn - ' + fs + ' cannot be flagged as ESL.');
    exit;
  end;
    
  if IsEditable(f) then begin
    SetIsESL(f, true);
    AddMessage(fs + ' is now processed.');
  end
  else
    if ExtraSpammy then
      AddMessage(fs + ' can be flagged ESL but is currently not editable.');
end;

end.

{
  Replace substring in model file names of records that have models.
  If model already contains sReplaceWith part, it will be skipped.
}
unit ReplaceLtex;

const
  sReplaceWhat = '\dungeons\'; // replace what substring
  sReplaceWith = '\dwemer\'; // replace with substring
  sModelElements = 'Model\MODL,Male world model\MOD2,Female world model\MOD3,Female world model\MOD4,Male 1st Person\MOD4,Female 1st Person\MOD5';

var
  slModel: TStringList;
 
function Initialize: integer;
begin
  slModel := TStringList.Create;
  slModel.Delimiter := ',';
  slModel.StrictDelimiter := True;
  slModel.DelimitedText := sModelElements;
end;  

function Process(e: IInterface): integer;
var
  i: integer;
begin
  for i := 0 to slModel.Count - 1 do
    // skip models that already contain sReplaceWith, comment this line out to replace everywhere
    if Pos(sReplaceWith, GetElementEditValues(e, slModel[i])) = 0 then
      SetElementEditValues(e, slModel[i], StringReplace(GetElementEditValues(e, slModel[i]), sReplaceWhat, sReplaceWith, [rfIgnoreCase]));
end;

function Finalize: integer;
begin
  slModel.Free;
end;  

end.

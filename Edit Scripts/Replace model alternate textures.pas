{
  Find and replace texture sets in models alternate textures
}
unit userscript;

var
  slOld, slNew: TStringList;

function Initialize: integer;
begin
  slOld := TStringList.Create;
  slNew := TStringList.Create;
  // define a replacement pairs - old TXST and new TXST (as much as you need)
  slOld.Add('0TextureSetGLRock03 [TXST:0200089C]'); slNew.Add('0TextureSetAICoastalRock01 [TXST:020008DC]');
  // slOld.Add(''); slNew.Add('');
end;

function Process(e: IInterface): integer;
var
  mods, t: IInterface;
  i, idx: integer;
begin
  mods := ElementByPath(e, 'Model\MODS');
  if not Assigned(mods) then Exit;
  for i := 0 to ElementCount(mods) - 1 do begin
    t := ElementByIndex(mods, i);
    idx := slOld.IndexOf(GetElementEditValues(t, 'New Texture'));
    if idx <> -1 then
      SetElementEditValues(t, 'New Texture', slNew[idx]);
  end;
end;

function Finalize: integer;
begin
  slOld.Free;
  slNew.Free;
end;

end.


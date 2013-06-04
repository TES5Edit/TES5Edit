{
  替换 EDID 和 FULL 中的字符，将 StrSearch 替换为 StrReplace 。
}
unit UserScript;

const
  StrSearch = 'Elven';
  StrReplace = 'Orcish';

var
  ReplaceCount: integer;

function Initialize: integer;
begin
  ReplaceCount := 0;
end;

procedure SearchAndReplace(e: IInterface; s1, s2: string);
var
  s: string;
begin
  if not Assigned(e) then Exit;

  // remove rfIgnoreCase to be case sensitive
  s := StringReplace(GetEditValue(e), s1, s2, [rfReplaceAll, rfIgnoreCase]);

  if not SameText(s, GetEditValue(e)) then begin
    Inc(ReplaceCount);
    AddMessage('正在 ' + FullPath(e) +' 替换。');
    SetEditValue(e, s);
  end;

end;

function Process(e: IInterface): integer;
begin
  SearchAndReplace(ElementBySignature(e, 'EDID'), StrSearch, StrReplace);
  SearchAndReplace(ElementBySignature(e, 'FULL'), StrSearch, StrReplace);
end;

function Finalize: integer;
begin
  AddMessage(Format('已替换 %d 项。', [ReplaceCount]));
end;

end.

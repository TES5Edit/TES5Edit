{
  功能与内置的"检查错误"是一样的
}
unit userscript;

function CheckForErrors(aIndent: Integer; aElement: IInterface): Boolean;
var
  Error : string;
  i     : Integer;
begin
  Error := Check(aElement);
  Result := Error <> '';
  if Result then begin
    Error := Check(aElement);
    AddMessage(StringOfChar(' ', aIndent * 2) + Name(aElement) + ' -> ' + Error);
  end else
    AddMessage('');

  for i := ElementCount(aElement) - 1 downto 0 do
    Result := CheckForErrors(aIndent + 1, ElementByIndex(aElement, i)) or Result;

  if Result and (Error = '') then
    AddMessage(StringOfChar(' ', aIndent * 2) + '以上错误位于：' + Name(aElement));
end;

function Process(e: IInterface): integer;
begin
  CheckForErrors(0, e);
end;

end.
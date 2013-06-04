{
  输出表单序号为 0 的记录。
  用来查找已损坏的插件。
}
unit UserScript;

function Process(e: IInterface): integer;
begin
  
  // file header has formid of 0, skip it
  if Signature(e) = 'TES4' then
    Exit;
  
  if FormID(e) and $00FFFFFF = 0 then
    AddMessage(FullPath(e));
 
end;

end.

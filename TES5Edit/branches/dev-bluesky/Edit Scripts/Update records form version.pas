{
  查找并更新少于 FV_Check 定义的表单版本的记录。
  FV_Set 是要设置的新数值。
  可以在任意游戏中使用，但当前仅对 Skyrim 有意义。
}
unit UserScript;

const
  FV_Check = 40;
  FV_Set = 43;

function Process(Rec: IInterface): integer;
var
  fv: integer;
begin
  Result := 0;
  
  fv := GetFormVersion(Rec);
  
  if fv >= FV_Check then begin
    AddMessage(Format('找到表单版本 %d 出现在 %s', [fv, Name(Rec)]));
    SetFormVersion(Rec, FV_Set);
  end;
  
end;

end.

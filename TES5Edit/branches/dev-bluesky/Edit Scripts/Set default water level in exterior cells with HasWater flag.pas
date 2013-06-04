{
  设置‘默认’水源等级 (表示游戏将使用来源于世界空间 WRLD 记录的水源等级)
  到存在“存在水源”标志的场景记录。
}
unit userscript;

function Process(e: IInterface): integer;
begin
  if Signature(e) <> 'CELL' then
    Exit;
  
  // $01 IsInterior + $02 HasWater = $03
  if GetElementNativeValues(e, 'DATA') and $03 = 2 then
    SetElementEditValues(e, 'XCLW', '默认') ;
end;

end.
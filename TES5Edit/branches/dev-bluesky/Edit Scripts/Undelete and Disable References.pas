{
  修复 UDR 衍生，基本上是从 xEdit 内部代码直接移植过来。
  不需要请求清理筛选。
}
unit UserScript;

var
  UndeletedCount, NAVMCount: integer;
  
function Process(e: IInterface): integer;
var
  Sig: string;
  xesp: IInterface;
begin
  Result := 0;
  
  if not (IsEditable(e) and GetIsDeleted(e)) then
    Exit;
  
  Sig := Signature(e);

  if 
    (Sig <> 'REFR') and
    (Sig <> 'PGRE') and
    (Sig <> 'PMIS') and
    (Sig <> 'ACHR') and
    (Sig <> 'ACRE') and
    (Sig <> 'NAVM') and
    (Sig <> 'PARW') and // Skyrim
    (Sig <> 'PBAR') and // Skyrim
    (Sig <> 'PBEA') and // Skyrim
    (Sig <> 'PCON') and // Skyrim
    (Sig <> 'PFLA') and // Skyrim
    (Sig <> 'PHZD')     // Skyrim
  then
    Exit;

  // don't process navmeshes but count deleted ones
  if Sig = 'NAVM' then begin
    Inc(NAVMCount);
    Exit;
  end;
  
  AddMessage('撤销删除：' + Name(e));
  
  // undelete
  SetIsDeleted(e, True);
  SetIsDeleted(e, False);

  // set persistence flag depending on game
  if (wbGameMode = gmFO3) or (wbGameMode = gmFNV) or (wbGameMode = gmTES5) and ((Sig = 'ACHR') or (Sig = 'ACRE')) then
    SetIsPersistent(e, True)
  else if wbGameMode = gmTES4 then
    SetIsPersistent(e, False);
    
  // place it below the ground
  if not GetIsPersistent(e) then
    SetElementNativeValues(e, 'DATA\方位\Z', -30000);

  RemoveElement(e, '启用根源');
  RemoveElement(e, 'XTEL');
  // ... remove anything else here
  
  // set to disabled
  SetIsInitiallyDisabled(e, True);
  
  // add enabled opposite of player (true - silent)
  xesp := Add(e, 'XESP', True);
  if Assigned(xesp) then begin
    SetElementNativeValues(xesp, '衍生', $14); // Player ref
    SetElementNativeValues(xesp, '标志', 1);  // opposite of parent flag
  end;

  Inc(UndeletedCount);
end;

function Finalize: integer;
begin
  AddMessage('已修复记录：' + IntToStr(UndeletedCount));
  if NAVMCount > 0 then
    AddMessage(Format('<警告：插件存在 %d 个被删除的 NavMeshes ，这是无法撤销删除的>', [NAVMCount]));
end;

end.
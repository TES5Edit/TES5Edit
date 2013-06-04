{
  制作中！请勿在实际插件中使用！
  仅供 Fallout 3 和 New Vegas。
  修复 navmeshes 的 UDR 数据，因为 navmeshes 的 UDR 处理方式与其他记录不同。

  需要一个更聪明的 modder 来完成此工作。
}
unit UserScript;

var
  UndeletedCount: integer;
  
function Process(e: IInterface): integer;
var
  vertices, v, f, entry: IInterface;
  navi, nvmis, nvmi: IInterface;
  i: integer;
begin
  Result := 0;
  
  if not (GetIsEditable(e) and GetIsDeleted(e)) then
    Exit;
  
  if Signature(e) <> 'NAVM' then
    Exit;
  
  AddMessage('正在修复：' + Name(e));
  
  // Find NVMI entry in NAVI for undeleted mesh
  f := GetFile(e);
  if not Assigned(f) then
    Exit;
    
  navi := GroupBySignature(f, 'NAVI');
  if not Assigned(navi) then begin
    AddMessage('未找到 NAVI 群组');
    Exit;
  end;
  
  // NAVI group always has only 1 record
  if ElementCount(navi) = 1 then begin
    navi := ElementByIndex(navi, 0);
    // get master NAVI record because NAVI record in plugin doesn't have NVMI for deleted navmesh
    navi := Master(navi);
  end else begin
    AddMessage('NAVI 群组必须有 1 记录');
    Exit;
  end;

  if not Assigned(navi) then begin
    AddMessage('未找到 master NAVI 记录');
    Exit;
  end;

  nvmis := ElementByName(navi, '导航地图信息');
  if not Assigned(nvmis) then
    Exit;
    
  for i := 0 to ElementCount(nvmis) - 1 do begin
    entry := ElementByIndex(nvmis, i);
    if GetElementNativeValues(entry, '导航模型') = FormID(e) then begin
      nvmi := entry;
      Break;
    end;
  end;
  
  if Assigned(nvmi) then begin
    AddMessage('在 NAVI 中找到 NVMI 子记录');
  end;
  
  // now we need to do something here with NAVI...
  // and probably NVPP for Skyrim etc.
  
  // uncomment if you don't want to undelete navmesh
  Exit;

  // Navmesh undelete and disable
  SetIsDeleted(e, True);
  SetIsDeleted(e, False);
  SetIsInitiallyDisabled(e, True);
  // place navmesh below the ground (change Z on all vertices)
  // currently only for Skyrim
  if wbGameMode = gmTES5 then begin
    vertices := ElementByPath(e, 'NVNM - 几何学\顶点');
    for i := 0 to ElementCount(vertices) - 1 do
      SetElementNativeValues(ElementByIndex(vertices, v), 'Z', -30000);
  end;
 
  Inc(UndeletedCount);
end;

function Finalize: integer;
begin
  AddMessage('已修复 navmeshes ：' + IntToStr(UndeletedCount));
end;

end.
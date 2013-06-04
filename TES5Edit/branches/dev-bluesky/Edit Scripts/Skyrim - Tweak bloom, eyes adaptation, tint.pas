{
  “图像空间”深度复制为覆盖到新插件，然后运行此插件。
  效果如以下两个插件：
    Skyrim SDR  http://skyrim.nexusmods.com/mods/7081
    No Tint     http://skyrim.nexusmods.com/mods/648
  
  警告：汇报显示 Skyrim SDR 会揉乱/破坏夜视，所以如果发生的话，您可能需要保持 Bloom 或者眼睛适应不修改。具体内容需要进一步调查。
}
unit UserScript;

const
  BloomMult = 0;          // Bloom multiplier
  AdaptSpeed = 90;        // Adaptation speed
  AdaptStrengthMult = 1;  // Adaptation strength multiplier
  TintMult = 0.45;        // Tint multiplier
  TintMin  = 0.1;         // Min tint amount
  
var
  fBloom, fAdapt, fTint: boolean;
  
function Initialize: integer;
begin
  Result := 0;
  fBloom := (MessageDlg('调整 Bloom ？', mtConfirmation, [mbYes, mbNo], 0) = mrYes);
  fAdapt := (MessageDlg('调整眼睛适应？', mtConfirmation, [mbYes, mbNo], 0) = mrYes);
  fTint := (MessageDlg('调整色调？', mtConfirmation, [mbYes, mbNo], 0) = mrYes);
end;

function Process(e: IInterface): integer;
var
  v: single;
begin
  Result := 0;
  
  if Signature(e) <> 'IMGS' then
    Exit;
  
  AddMessage('正在处理：' + Name(e));
  
  if fBloom then
    SetElementNativeValues(e, 'HNAM - HDR\Bloom 模糊半径', GetElementNativeValues(e, 'HNAM - HDR\Bloom 模糊半径') * BloomMult);
  
  if fAdapt then begin
    SetElementNativeValues(e, 'HNAM - HDR\眼睛适应速度', AdaptSpeed);
    SetElementNativeValues(e, 'HNAM - HDR\眼睛适应强度', GetElementNativeValues(e, 'HNAM - HDR\眼睛适应强度') * AdaptStrengthMult);
  end;
    
  if fTint and ElementExists(e, 'TNAM') then begin
    v := GetElementNativeValues(e, 'TNAM - 色调\数量');
    // don't alter/reduce tint less than TintMin
    if v > TintMin then begin
      v := v*TintMult;
      if v < TintMin then v := TintMin else
        if v > 1 then v := 1;
      SetElementNativeValues(e, 'TNAM - 色调\数量', v);
    end;
  end;

end;

end.
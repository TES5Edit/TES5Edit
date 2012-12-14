{
  Copy with override "Image Space" group from your plugins to a new one,
  then apply this script.
  Makes the similar effect as those two mods:
    Skyrim SDR  http://skyrim.nexusmods.com/mods/7081
    No Tint     http://skyrim.nexusmods.com/mods/648
  
  Warning: Skyrim SDR reported to screw night vision, so you might want to
  leave Bloom or Adaptation unchanged if that happens. Needs confirmation.
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
  fBloom := (MessageDlg('Tweak Bloom?', mtConfirmation, [mbYes, mbNo], 0) = mrYes);
  fAdapt := (MessageDlg('Tweak Eyes Adaptation?', mtConfirmation, [mbYes, mbNo], 0) = mrYes);
  fTint := (MessageDlg('Tweak Tint?', mtConfirmation, [mbYes, mbNo], 0) = mrYes);
end;

function Process(e: IInterface): integer;
var
  v: single;
begin
  Result := 0;
  
  if Signature(e) <> 'IMGS' then
    Exit;
  
  AddMessage('Processing: ' + Name(e));
  
  if fBloom then
    SetElementNativeValues(e, 'HNAM - HDR\Bloom Blur Radius', GetElementNativeValues(e, 'HNAM - HDR\Bloom Blur Radius') * BloomMult);
  
  if fAdapt then begin
    SetElementNativeValues(e, 'HNAM - HDR\Eye Adapt Speed', AdaptSpeed);
    SetElementNativeValues(e, 'HNAM - HDR\Eye Adapt Strength', GetElementNativeValues(e, 'HNAM - HDR\Eye Adapt Strength') * AdaptStrengthMult);
  end;
    
  if fTint and ElementExists(e, 'TNAM') then begin
    v := GetElementNativeValues(e, 'TNAM - Tint\Amount');
    // don't alter/reduce tint less than TintMin
    if v > TintMin then begin
      v := v*TintMult;
      if v < TintMin then v := TintMin else
        if v > 1 then v := 1;
      SetElementNativeValues(e, 'TNAM - Tint\Amount', v);
    end;
  end;

end;

end.
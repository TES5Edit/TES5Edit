(*
  Copy with override "Image Space" group from your plugins to a new one,
  then apply this script.
  Makes the same effect as those two mods:
    Skyrim SDR http://skyrim.nexusmods.com/mods/7081
    No Tint http://skyrim.nexusmods.com/mods/648
  No FPS hit unlike ENB.
  
  Warning: Skyrim SDR reported to screw night vision, so you might want to
  leave Bloom or Adaptation unchanged if that happens. Needs confirmation.
  
  Tweak TintMult and TintMin to your liking.
*)
unit UserScript;

const
  TintMult = 0.35; // Multiplier
  TintMin  = 0.1;  // Min value
  
var
  NoBloom, NoEye, NoTint: boolean;
  
function Initialize: integer;
begin
  Result := 0;
  NoBloom := (MessageDlg('Disable Bloom?', mtConfirmation, [mbYes, mbNo], 0) = mrYes);
  NoEye := (MessageDlg('Disable Eyes Adaptation?', mtConfirmation, [mbYes, mbNo], 0) = mrYes);
  NoTint := (MessageDlg('Reduce Tint?', mtConfirmation, [mbYes, mbNo], 0) = mrYes);
end;

function Process(e: IInterface): integer;
var
  v: IInterface;
  tint: single;
begin
  Result := 0;
  
  if GetSignature(e) <> 'IMGS' then
    Exit;
  
  AddMessage('Processing: ' + GetName(e));
  
  v := ElementByPath(e, 'HNAM - HDR\Bloom Blur Radius');
  if (v <> nil) and NoBloom then
    SetEditValue(v, '0');
  
  v := ElementByPath(e, 'HNAM - HDR\Eye Adapt Speed');
  if (v <> nil) and NoEye then
    SetEditValue(v, '0');
    
  v := ElementByPath(e, 'HNAM - HDR\Eye Adapt Strength');
  if (v <> nil) and NoEye then
    SetEditValue(v, '0');

  v := ElementByPath(e, 'TNAM - Tint\Amount');
  if (v <> nil) and NoTint then begin
    tint := GetNativeValue(v);
    // don't alter/reduce tint less than TintMin
    if tint > TintMin then begin
      tint := tint*TintMult;
      if tint < TintMin then tint := 0.1 else
        if tint > 1 then tint := 1;
      SetNativeValue(v, tint);
    end;
  end;

end;

end.
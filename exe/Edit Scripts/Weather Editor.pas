{
  Weather Editor v0.2
  Supports Oblivion, Skyrim, Fallout 3, Fallout New Vegas, Fallout 4

  Hotkey: Ctrl+W
}

unit WeatherEditor;

const
  sCloudTexturesLocation = 'textures\sky\';
  iColorEditorWidth = 170;
  iColorEditorHeight = 50;

var
  Weather: IInterface;
  sCloudLayerSignatures, sColorTimes: string;
  slCloudTextures, slCloudSignatures, slColorTimes: TStringList;
  lstCED, lstCEDElement: TList; // list of Color Editors and respective elements
  frm: TForm;
  pgcWeather: TPageControl;
  tsClouds, tsWeatherColors, tsLightingColors, tsTools: TTabSheet;
  lbCloudLayers: TCheckListBox;
  pnlCloud, pnlCloudEdit: TPanel;
  cmbCloudTexture: TComboBox;
  btnShowCloudTexture, btnApplyCloud, btnApplyWeatherColors, btnApplyLightingColors: TButton;
  btnCopyClouds, btnCopyWeatherColors, btnCopyLightingColors: TButton;
  edCloudXSpeed, edCloudYSpeed, edCloudAlpha1, edCloudAlpha2, edCloudAlpha3, edCloudAlpha4, edCloudAlpha5, edCloudAlpha6, edCloudAlpha7, edCloudAlpha8: TLabeledEdit;
  imgCloud: TImage;
  CountCloudLayers: integer; // a total number of supported cloud layers
  CountTimes: integer; // a total number of times (sunrise, day, sunset, night)
  CountWeatherColors: integer; // a total number of weather colors
  CountLightingColors: integer; // a total number of lighting colors


//============================================================================
// weather records format for Skyrim, SSE and Fallout 4
function IsFormat3: Boolean;
begin
  Result := (wbGameMode = gmTES5) or (wbGameMode = gmTES5VR) or (wbGameMode = gmSSE) or (wbGameMode = gmFO4) or (wbGameMode = gmFO4VR);
end;
  
//============================================================================
function CheckEditable(e: IInterface): Boolean;
begin
  Result := IsEditable(e);
  if not Result then
    MessageDlg(Format('%s \ %s is not editable', [GetFileName(e), Name(e)]), mtError, [mbOk], 0);
end;

//============================================================================
// copy element elName from RecSrc record to RecDst record
procedure CopyElement(RecSrc, RecDst: IInterface; elName: string);
var
  el: IInterface;
begin
  el := ElementByPath(recsrc, elName);
  if not Assigned(el) then begin
    RemoveElement(recdst, elName);
    Exit;
  end;
  if not ElementExists(recdst, elName) then
    Add(recdst, elName, True);
  ElementAssign(ElementByPath(recdst, elName), LowInteger, el, False);
end;

//============================================================================
// record selector
function SelectRecord(aSignatures: string; aWithOverrides: Boolean): IInterface;
var
  sl, slRec: TStringList;
  i, j, k: integer;
  f, g, r: IInterface;
  clb: TCheckListBox;
  frm: TForm;
begin
  sl := TStringList.Create;
  sl.Delimiter := ',';
  sl.StrictDelimiter := True;
  sl.DelimitedText := aSignatures;
  slRec := TStringList.Create;
  
  for i := 0 to Pred(FileCount) do begin
    f := FileByIndex(i);
    for j := 0 to Pred(sl.Count) do begin
      g := GroupBySignature(f, sl[j]);
      for k := 0 to Pred(ElementCount(g)) do begin
        r := ElementByIndex(g, k);
        if aWithOverrides then
          slRec.AddObject(GetFileName(r) + ' \ '+ Name(r), r)
        else
          if IsMaster(r) then begin
            r := WinningOverride(r);
            slRec.AddObject(Name(r), r);
          end;
      end;
    end;
  end;
  
  frm := frmFileSelect;
  frm.Width := 600;
  try
    frm.Caption := 'Select a record';
    clb := TCheckListBox(frm.FindComponent('CheckListBox1'));
    clb.Items.Assign(slRec);
    if frm.ShowModal <> mrOk then Exit;
    for i := 0 to Pred(clb.Items.Count) do
      if clb.Checked[i] then begin
        Result := ObjectToElement(clb.Items.Objects[i]);
        Exit;
      end;
  finally
    frm.Free;
    sl.Free;
    slRec.Free;
  end;
end;

//============================================================================
// convert a color element in plugin to TColor
function ColorElementToColor(elColor: IInterface): LongWord;
begin
  Result := Result or GetElementNativeValues(elColor, 'Blue') shl 16;
  Result := Result or GetElementNativeValues(elColor, 'Green') shl 8;
  Result := Result or GetElementNativeValues(elColor, 'Red');
end;

//============================================================================
// load colors from weather record into color editors with index idxFrom..idxTo
procedure ColorEditorReadColor(idxFrom, idxTo: integer);
var
  i: integer;
begin
  for i := idxFrom to idxTo do
    TPanel(lstCED[i]).Color := ColorElementToColor(ObjectToElement(lstCEDElement[i]));
end;

//============================================================================
// save colors to weather record for color editors with index idxFrom..idxTo
procedure ColorEditorWriteColor(idxFrom, idxTo: integer);
var
  i: integer;
  c: LongWord;
  e: IInterface;
begin
  for i := idxFrom to idxTo do begin
    c := TPanel(lstCED[i]).Color;
    e := ObjectToElement(lstCEDElement[i]);
    SetElementNativeValues(e, 'Red', c and $FF);
    SetElementNativeValues(e, 'Green', (c shr 8) and $FF);
    SetElementNativeValues(e, 'Blue', (c shr 16) and $FF);
  end;
end;

//============================================================================
// color editor click event, show color dialog
procedure ColorEditorClick(Sender: TObject);
var
  pnl: TPanel;
  dlgColor: TColorDialog;
  i, j: integer;
begin
  pnl := TPanel(Sender);
  dlgColor := TColorDialog.Create(frm);
  dlgColor.Options := [cdFullOpen, cdAnyColor];
  dlgColor.Color := pnl.Color;
  // add quartet colors as custom ones
  j := Round((pnl.Tag div CountTimes) * CountTimes);
  for i := 0 to Pred(CountTimes) do
    dlgColor.CustomColors.Add(Format('Color%s=%s', [Chr(65+i), IntToHex(TPanel(lstCED[j+i]).Color, 6)]));
  if dlgColor.Execute then
    pnl.Color := dlgColor.Color;
  dlgColor.Free;
end;

//===========================================================================
// on key down event handler for form
procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  if Key = VK_ESCAPE then
    TForm(Sender).ModalResult := mrOk;
end;

//============================================================================
// save settings for weather colors
procedure btnApplyWeatherColorsClick(Sender: TObject);
begin
  if not CheckEditable(Weather) then
    Exit;

  ColorEditorWriteColor(CountTimes, CountTimes + Pred(CountWeatherColors));
end;

//============================================================================
// save settings for lighting colors
procedure btnApplyLightingColorsClick(Sender: TObject);
begin
  if not CheckEditable(Weather) then
    Exit;

  ColorEditorWriteColor(CountTimes + CountWeatherColors, CountTimes + CountWeatherColors + Pred(CountLightingColors));
end;

//============================================================================
// view current cloud layer texture, can be used when texture name is edited by user
procedure btnShowCloudTextureClick(Sender: TObject);
var
  CloudTexture: string;
begin
  CloudTexture := 'textures\' + LowerCase(cmbCloudTexture.Text);
  if not ResourceExists(CloudTexture) then begin
    AddMessage(CloudTexture + ' does not exist.');
    Exit;
  end;
  wbDDSResourceToBitmap(CloudTexture, imgCloud.Picture.Bitmap);
end;

//============================================================================
// save settings for a cloud layer
procedure btnApplyCloudClick(Sender: TObject);
var
  Layer, i: integer;
begin
  if not CheckEditable(Weather) then
    Exit;

  Layer := lbCloudLayers.ItemIndex;
  SetElementEditValues(Weather, slCloudSignatures[Layer], cmbCloudTexture.Text);

  if IsFormat3 then begin
    SetElementEditValues(Weather, Format('Cloud Speed\QNAM - X Speed\Layer #%d', [Layer]), edCloudXSpeed.Text);
    SetElementEditValues(Weather, Format('Cloud Speed\RNAM - Y Speed\Layer #%d', [Layer]), edCloudYSpeed.Text);
    SetElementEditValues(Weather, Format('JNAM\Layer #%d\Sunrise', [Layer]), edCloudAlpha1.Text);
    SetElementEditValues(Weather, Format('JNAM\Layer #%d\Day', [Layer]), edCloudAlpha2.Text);
    SetElementEditValues(Weather, Format('JNAM\Layer #%d\Sunset', [Layer]), edCloudAlpha3.Text);
    SetElementEditValues(Weather, Format('JNAM\Layer #%d\Night', [Layer]), edCloudAlpha4.Text);
    if (wbGameMode = gmFO4) or (wbGameMode = gmFO4VR) then begin
      SetEditValue(ElementByIndex(ElementByPath(Weather, Format('JNAM\Layer #%d', [Layer])), 4), edCloudAlpha5.Text);
      SetEditValue(ElementByIndex(ElementByPath(Weather, Format('JNAM\Layer #%d', [Layer])), 5), edCloudAlpha6.Text);
      SetEditValue(ElementByIndex(ElementByPath(Weather, Format('JNAM\Layer #%d', [Layer])), 6), edCloudAlpha7.Text);
      SetEditValue(ElementByIndex(ElementByPath(Weather, Format('JNAM\Layer #%d', [Layer])), 7), edCloudAlpha8.Text);
    end;
  end
  else if (wbGameMode = gmFO3) or (wbGameMode = gmFNV) then
    SetEditValue(ElementByIndex(ElementByPath(Weather, 'ONAM'), Layer), edCloudXSpeed.Text)
  else if wbGameMode = gmTES4 then
    SetEditValue(ElementByIndex(ElementByPath(Weather, 'DATA'), Layer + 1), edCloudXSpeed.Text);

  ColorEditorWriteColor(0, Pred(CountTimes));
end;

//============================================================================
// User clicks on a cloud layer, load cloud layer data and show cloud texture
procedure lbCloudLayersClick(Sender: TObject);
var
  Layer, i: integer;
  CloudTexture: string;
  elColors: IInterface;
begin
  Layer := lbCloudLayers.ItemIndex;
  
  // show cloud texture
  CloudTexture := LowerCase(GetElementEditValues(Weather, slCloudSignatures[Layer]));
  if SameText(Copy(CloudTexture, 1, 9), 'textures\') then
    Delete(CloudTexture, 1, 9);
  cmbCloudTexture.Text := CloudTexture;
  if CloudTexture <> '' then
    btnShowCloudTexture.Click
  else
    imgCloud.Picture := nil;

  // fill layer parameters
  if IsFormat3 then begin
    edCloudXSpeed.Text := GetElementEditValues(Weather, Format('Cloud Speed\QNAM - X Speed\Layer #%d', [Layer]));
    edCloudYSpeed.Text := GetElementEditValues(Weather, Format('Cloud Speed\RNAM - Y Speed\Layer #%d', [Layer]));
    edCloudAlpha1.Text := GetElementEditValues(Weather, Format('JNAM\Layer #%d\Sunrise', [Layer]));
    edCloudAlpha2.Text := GetElementEditValues(Weather, Format('JNAM\Layer #%d\Day', [Layer]));
    edCloudAlpha3.Text := GetElementEditValues(Weather, Format('JNAM\Layer #%d\Sunset', [Layer]));
    edCloudAlpha4.Text := GetElementEditValues(Weather, Format('JNAM\Layer #%d\Night', [Layer]));
    if (wbGameMode = gmFO4) or (wbGameMode = gmFO4VR) then begin
      edCloudAlpha5.Text := GetEditValue(ElementByIndex(ElementByPath(Weather, Format('JNAM\Layer #%d', [Layer])), 4));
      edCloudAlpha6.Text := GetEditValue(ElementByIndex(ElementByPath(Weather, Format('JNAM\Layer #%d', [Layer])), 5));
      edCloudAlpha7.Text := GetEditValue(ElementByIndex(ElementByPath(Weather, Format('JNAM\Layer #%d', [Layer])), 6));
      edCloudAlpha8.Text := GetEditValue(ElementByIndex(ElementByPath(Weather, Format('JNAM\Layer #%d', [Layer])), 7));
    end;
  end
  else if (wbGameMode = gmFO3) or (wbGameMode = gmFNV) then
    edCloudXSpeed.Text := GetEditValue(ElementByIndex(ElementByPath(Weather, 'ONAM'), Layer))
  else if wbGameMode = gmTES4 then
    edCloudXSpeed.Text := GetEditValue(ElementByIndex(ElementByPath(Weather, 'DATA'), Layer + 1));

  // fill layer colors
  if IsFormat3 then
    //elColors := ElementByName(ElementByIndex(ElementByPath(Weather, 'PNAM'), Layer), 'Colors')
    elColors := ElementByIndex(ElementByPath(Weather, 'PNAM'), Layer)
  else if (wbGameMode = gmFO3) or (wbGameMode = gmFNV) then
    elColors := ElementByIndex(ElementByPath(Weather, 'PNAM'), Layer)
  else if wbGameMode = gmTES4 then begin
    if Layer = 0 then
      elColors := ElementByIndex(ElementByPath(Weather, 'NAM0'), 2)
    else if Layer = 1 then
      elColors := ElementByIndex(ElementByPath(Weather, 'NAM0'), 9);
  end;
  
  for i := 0 to Pred(CountTimes) do
    lstCEDElement[i] := ElementByIndex(elColors, i);
  ColorEditorReadColor(0, Pred(CountTimes));
end;

//============================================================================
// User clicks on a cloud layer check box, enable or disable cloud layer
procedure lbCloudLayersClickCheck(Sender: TObject);
var
  Layer, i: integer;
  DisabledClouds: LongWord;
begin
  Layer := lbCloudLayers.ItemIndex;

  // can't disable cloud layers in games before Skyrim
  if (wbGameMode = gmTES4) or (wbGameMode = gmFO3) or (wbGameMode = gmFNV) then begin
    lbCloudLayers.Checked[Layer] := True;
    MessageDlg(Format('Can not disable cloud layer in %s', [wbGameName]), mtError, [mbOk], 0);
    Exit;
  end;

  if not CheckEditable(Weather) then begin
    // can't edit layer, restore layer's check state back
    lbCloudLayers.Checked[Layer] := not lbCloudLayers.Checked[Layer];
    Exit;
  end;
  
  // enable layer
  if lbCloudLayers.Checked[Layer] then begin
    Add(Weather, slCloudSignatures[Layer], True);
    DisabledClouds := GetElementNativeValues(Weather, 'NAM1');
    DisabledClouds := DisabledClouds and (not (1 shl Layer));
    SetElementNativeValues(Weather, 'NAM1', DisabledClouds);
  end
  // disable layer
  else begin
    // since disabling removes cloud texture subrecord which means a data loss, ask user first
    i := MessageDlg(Format('Do you really want to disable cloud layer %d?', [Layer]), mtConfirmation, [mbYes, mbNo], 0);
    if i = mrYes then begin
      RemoveElement(Weather, slCloudSignatures[Layer]);
      DisabledClouds := GetElementNativeValues(Weather, 'NAM1');
      DisabledClouds := DisabledClouds or (1 shl Layer);
      SetElementNativeValues(Weather, 'NAM1', DisabledClouds);
      // reload cloud layer data since texture is removed
      lbCloudLayersClick(nil);
    end else
      lbCloudLayers.Checked[Layer] := not lbCloudLayers.Checked[Layer];
  end;
end;

//============================================================================
// copy clouds from another weather
procedure btnCopyCloudsClick(Sender: TObject);
var
  i: integer;
  WeatherFrom: IInterface;
begin
  if not CheckEditable(Weather) then
    Exit;

  WeatherFrom := SelectRecord('WTHR', True);
  if not Assigned(WeatherFrom) or Equals(Weather, WeatherFrom) then
    Exit;
  
  // copy clouds textures
  for i := 0 to Pred(slCloudSignatures.Count) do
    CopyElement(WeatherFrom, Weather, slCloudSignatures[i]);
  
  // copy clouds speed, alpha, colors
  if IsFormat3 then begin
    CopyElement(WeatherFrom, Weather, 'NAM1');
    CopyElement(WeatherFrom, Weather, 'Cloud Speed');
    CopyElement(WeatherFrom, Weather, 'JNAM');
    CopyElement(WeatherFrom, Weather, 'PNAM');
    CopyElement(WeatherFrom, Weather, 'Sky Statics');
  end
  else if (wbGameMode = gmFO3) or (wbGameMode = gmFNV) then begin
    CopyElement(WeatherFrom, Weather, 'ONAM');
    CopyElement(WeatherFrom, Weather, 'PNAM');
  end else if wbGameMode = gmTES4 then begin
    ElementAssign(ElementByIndex(ElementByPath(Weather, 'NAM0'), 2), LowInteger, ElementByIndex(ElementByPath(WeatherFrom, 'NAM0'), 2), False);
    ElementAssign(ElementByIndex(ElementByPath(Weather, 'NAM0'), 9), LowInteger, ElementByIndex(ElementByPath(WeatherFrom, 'NAM0'), 9), False);
    SetElementEditValues(Weather, 'DATA\Cloud Speed (Lower)', GetElementEditValues(WeatherFrom, 'DATA\Cloud Speed (Lower)'));
    SetElementEditValues(Weather, 'DATA\Cloud Speed (Upper)', GetElementEditValues(WeatherFrom, 'DATA\Cloud Speed (Upper)'));
  end;

  // I'm too lazy to reload new data, just restart the script
  MessageDlg('Please restart Weather Editor to see changes', mtInformation, [mbOk], 0);
  frm.Close;
end;

//============================================================================
// copy weather colors from another weather
procedure btnCopyWeatherColorsClick(Sender: TObject);
var
  WeatherFrom: IInterface;
begin
  if not CheckEditable(Weather) then
    Exit;

  WeatherFrom := SelectRecord('WTHR', True);
  if not Assigned(WeatherFrom) or Equals(Weather, WeatherFrom) then
    Exit;
  
  CopyElement(WeatherFrom, Weather, 'NAM0');

  MessageDlg('Please restart Weather Editor to see changes', mtInformation, [mbOk], 0);
  frm.Close;
end;

//============================================================================
// copy Directional Ambient Lighting Colors from another weather
procedure btnCopyLightingColorsClick(Sender: TObject);
var
  WeatherFrom: IInterface;
begin
  if not CheckEditable(Weather) then
    Exit;

  WeatherFrom := SelectRecord('WTHR', True);
  if not Assigned(WeatherFrom) or Equals(Weather, WeatherFrom) then
    Exit;
  
  CopyElement(WeatherFrom, Weather, 'Directional Ambient Lighting Colors');

  MessageDlg('Please restart Weather Editor to see changes', mtInformation, [mbOk], 0);
  frm.Close;
end;

//============================================================================
// Label control helper
function CreateLabel(Parent: TControl; Left, Top: Integer; LabelText: string): TLabel;
begin
  Result := TLabel.Create(frm);
  Result.Parent := Parent;
  Result.Left := Left;
  Result.Top := Top;
  Result.Caption := LabelText;
end;

//============================================================================
// Color editor control helper (based on TPanel)
function CreateColorEditor(Parent: TControl; Left, Top: Integer; elColor: IInterface): TPanel;
begin
  Result := TPanel.Create(frm);
  Result.Parent := Parent;
  Result.Left := Left;
  Result.Top := Top;
  Result.Width := iColorEditorWidth;
  Result.Height := iColorEditorHeight;
  Result.BevelOuter := bvNone;
  Result.Cursor := -21; //crHandPoint;
  // list of color elements in plugin
  lstCEDElement.Add(elColor);
  Result.Tag := Pred(lstCEDElement.Count);
  Result.ParentBackground := False;
  Result.Color := ColorElementToColor(elColor);
  Result.StyleElements := [];
  Result.OnClick := ColorEditorClick;
  // list of color editors, indexes are the same for editors and elements
  lstCED.Add(Result);
end;

//============================================================================
procedure EditorUI;
var
  i, j: integer;
  s: string;
  DisabledClouds: LongWord;
  lbl: TLabel;
  sbx: TScrollBox;
  e1, e2: IInterface;
begin
  frm := TForm.Create(nil);
  try
    frm.Caption := Format('%s \ %s - %s Weather Editor', [GetFileName(Weather), Name(Weather), wbGameName]);
    frm.Width := 860 + (CountTimes-4) * iColorEditorWidth;
    frm.Height := 800;
    frm.Position := poScreenCenter;
    frm.Color := clWindow;
    frm.KeyPreview := True;
    frm.OnKeyDown := FormKeyDown;
    
    pgcWeather := TPageControl.Create(frm);
    pgcWeather.Parent := frm;
    pgcWeather.Align := alClient;

    // CLOUDS TABSHEET
    tsClouds := TTabSheet.Create(pgcWeather);
    tsClouds.PageControl := pgcWeather;
    tsClouds.Caption := 'Clouds';

    lbCloudLayers := TCheckListBox.Create(frm);
    lbCloudLayers.Parent := tsClouds;
    lbCloudLayers.Align := alLeft;
    lbCloudLayers.Width := 100;
    lbCloudLayers.OnClick := lbCloudLayersClick;
    lbCloudLayers.OnClickCheck := lbCloudLayersClickCheck;
    DisabledClouds := GetElementNativeValues(Weather, 'NAM1');
    for i := 0 to Pred(CountCloudLayers) do begin
      // Oblivion has only 2 predefined cloud names
      if wbGameMode = gmTES4 then begin
        if i = 0 then s := 'Lower'
          else if i = 1 then s := 'Upper';
      end else
        s := Format('Layer %d', [i]);
      lbCloudLayers.Items.Add(s);
      if DisabledClouds and (1 shl i) = 0 then
        lbCloudLayers.Checked[i] := True;
    end;

    pnlCloud := TPanel.Create(frm);
    pnlCloud.Parent := tsClouds;
    pnlCloud.Align := alClient;
    pnlCloud.BevelOuter := bvNone;
    
    pnlCloudEdit := TPanel.Create(frm);
    pnlCloudEdit.Parent := pnlCloud;
    pnlCloudEdit.Align := alTop;
    pnlCloudEdit.BevelOuter := bvNone;
    pnlCloudEdit.Height := 230;
    
    imgCloud := TImage.Create(frm);
    imgCloud.Parent := pnlCloud;
    imgCloud.Align := alClient;
    imgCloud.Proportional := True;
    imgCloud.Center := True;
    
    CreateLabel(pnlCloudEdit, 12, 12, 'Texture');
    cmbCloudTexture := TComboBox.Create(frm);
    cmbCloudTexture.Parent := pnlCloudEdit;
    cmbCloudTexture.Top := 8;
    cmbCloudTexture.Left := 70;
    cmbCloudTexture.Width := 500;
    cmbCloudTexture.DropDownCount := 30;
    cmbCloudTexture.Items.Assign(slCloudTextures);
    cmbCloudTexture.OnSelect := btnShowCloudTextureClick; // show texture when selecting from drop down list

    btnShowCloudTexture := TButton.Create(frm);
    btnShowCloudTexture.Parent := pnlCloudEdit;
    btnShowCloudTexture.Left := cmbCloudTexture.Left + cmbCloudTexture.Width + 12;
    btnShowCloudTexture.Top := cmbCloudTexture.Top - 2;
    btnShowCloudTexture.Width := 100;
    btnShowCloudTexture.Caption := 'Show Texture';
    btnShowCloudTexture.OnClick := btnShowCloudTextureClick;
    
    edCloudXSpeed := TLabeledEdit.Create(frm);
    edCloudXSpeed.Parent := pnlCloudEdit;
    edCloudXSpeed.LabelPosition := lpLeft;
    edCloudXSpeed.EditLabel.Caption := 'X Speed';
    edCloudXSpeed.Left := 70; edCloudXSpeed.Top := 40; edCloudXSpeed.Width := 70;

    // only one speed value per cloud layer and no alpha in games before Skyrim
    if (wbGameMode = gmTES4) or (wbGameMode = gmFO3) or (wbGameMode = gmFNV) then
      edCloudXSpeed.EditLabel.Caption := 'Speed'
    else begin
      edCloudYSpeed := TLabeledEdit.Create(frm);
      edCloudYSpeed.Parent := pnlCloudEdit;
      edCloudYSpeed.LabelPosition := lpLeft;
      edCloudYSpeed.EditLabel.Caption := 'Y Speed';
      edCloudYSpeed.Left := 200; edCloudYSpeed.Top := 40; edCloudYSpeed.Width := 70;

      edCloudAlpha1 := TLabeledEdit.Create(frm); edCloudAlpha1.Parent := pnlCloudEdit;
      edCloudAlpha1.LabelPosition := lpLeft; edCloudAlpha1.EditLabel.Caption := 'Alpha';
      edCloudAlpha1.Left := 62 + 0*iColorEditorWidth; edCloudAlpha1.Top := 155; edCloudAlpha1.Width := iColorEditorWidth - 50;
      edCloudAlpha2 := TLabeledEdit.Create(frm); edCloudAlpha2.Parent := pnlCloudEdit;
      edCloudAlpha2.LabelPosition := lpLeft; edCloudAlpha2.EditLabel.Caption := 'Alpha';
      edCloudAlpha2.Left := 62 + 1*iColorEditorWidth; edCloudAlpha2.Top := 155; edCloudAlpha2.Width := iColorEditorWidth - 50;
      edCloudAlpha3 := TLabeledEdit.Create(frm); edCloudAlpha3.Parent := pnlCloudEdit;
      edCloudAlpha3.LabelPosition := lpLeft; edCloudAlpha3.EditLabel.Caption := 'Alpha';
      edCloudAlpha3.Left := 62 + 2*iColorEditorWidth; edCloudAlpha3.Top := 155; edCloudAlpha3.Width := iColorEditorWidth - 50;
      edCloudAlpha4 := TLabeledEdit.Create(frm); edCloudAlpha4.Parent := pnlCloudEdit;
      edCloudAlpha4.LabelPosition := lpLeft; edCloudAlpha4.EditLabel.Caption := 'Alpha';
      edCloudAlpha4.Left := 62 + 3*iColorEditorWidth; edCloudAlpha4.Top := 155; edCloudAlpha4.Width := iColorEditorWidth - 50;
      if (wbGameMode = gmFO4) or (wbGameMode = gmFO4VR) then begin
        edCloudAlpha5 := TLabeledEdit.Create(frm); edCloudAlpha5.Parent := pnlCloudEdit;
        edCloudAlpha5.LabelPosition := lpLeft; edCloudAlpha5.EditLabel.Caption := 'Alpha';
        edCloudAlpha5.Left := 62 + 4*iColorEditorWidth; edCloudAlpha5.Top := 155; edCloudAlpha5.Width := iColorEditorWidth - 50;
        edCloudAlpha6 := TLabeledEdit.Create(frm); edCloudAlpha6.Parent := pnlCloudEdit;
        edCloudAlpha6.LabelPosition := lpLeft; edCloudAlpha6.EditLabel.Caption := 'Alpha';
        edCloudAlpha6.Left := 62 + 5*iColorEditorWidth; edCloudAlpha6.Top := 155; edCloudAlpha6.Width := iColorEditorWidth - 50;
        edCloudAlpha7 := TLabeledEdit.Create(frm); edCloudAlpha7.Parent := pnlCloudEdit;
        edCloudAlpha7.LabelPosition := lpLeft; edCloudAlpha7.EditLabel.Caption := 'Alpha';
        edCloudAlpha7.Left := 62 + 6*iColorEditorWidth; edCloudAlpha7.Top := 155; edCloudAlpha7.Width := iColorEditorWidth - 50;
        edCloudAlpha8 := TLabeledEdit.Create(frm); edCloudAlpha8.Parent := pnlCloudEdit;
        edCloudAlpha8.LabelPosition := lpLeft; edCloudAlpha8.EditLabel.Caption := 'Alpha';
        edCloudAlpha8.Left := 62 + 7*iColorEditorWidth; edCloudAlpha8.Top := 155; edCloudAlpha8.Width := iColorEditorWidth - 50;
      end;
    end;

    for i := 0 to Pred(CountTimes) do begin
      lbl := CreateLabel(pnlCloudEdit, 12 + i*iColorEditorWidth, 80, slColorTimes[i]);
      lbl.AutoSize := False;
      lbl.Width := iColorEditorWidth;
      lbl.Alignment := taCenter;
      CreateColorEditor(pnlCloudEdit, 12 + i*iColorEditorWidth, 100, nil);
    end;

    btnApplyCloud := TButton.Create(frm);
    btnApplyCloud.Parent := pnlCloudEdit;
    btnApplyCloud.Left := btnShowCloudTexture.Left;
    btnApplyCloud.Top := 190;
    btnApplyCloud.Width := 100;
    btnApplyCloud.Caption := 'Apply Changes';
    btnApplyCloud.OnClick := btnApplyCloudClick;

    // default selected layer
    lbCloudLayers.ItemIndex := 0;
    lbCloudLayersClick(nil);

    // WEATHER COLORS TABSHEET
    tsWeatherColors := TTabSheet.Create(pgcWeather);
    tsWeatherColors.PageControl := pgcWeather;
    tsWeatherColors.Caption := 'Weather Colors';
    
    sbx := TScrollBox.Create(frm);
    sbx.Parent := tsWeatherColors;
    sbx.Align := alClient;
    sbx.BorderStyle := bsNone;
    sbx.HorzScrollBar.Tracking := True;
    sbx.VertScrollBar.Tracking := True;

    e1 := ElementByPath(Weather, 'NAM0');
    for i := 0 to Pred(ElementCount(e1)) do begin
      // skip cloud colors that are stored together with weather colors in Oblivion
      if (wbGameMode = gmTES4) and ((i = 2) or (i = 9)) then
        Continue;
      e2 := ElementByIndex(e1, i);
      for j := 0 to Pred(CountTimes) do begin
        if i = 0 then begin
          lbl := CreateLabel(sbx, 120 + j*iColorEditorWidth, 8, slColorTimes[j]);
          lbl.AutoSize := False;
          lbl.Width := iColorEditorWidth;
          lbl.Alignment := taCenter;
        end;
        if j = 0 then begin
          lbl := CreateLabel(sbx, 12, 28 + Succ(i)*iColorEditorHeight - iColorEditorHeight div 2 - 5, Name(e2));
          lbl.AutoSize := False;
          lbl.Width := 100;
          lbl.Alignment := taRightJustify;
        end;
        CreateColorEditor(sbx, 120 + j*iColorEditorWidth, 28 + i*iColorEditorHeight, ElementByIndex(e2, j));
        Inc(CountWeatherColors);
      end;
    end;

    btnApplyWeatherColors := TButton.Create(frm);
    btnApplyWeatherColors.Parent := sbx;
    btnApplyWeatherColors.Width := 100;
    btnApplyWeatherColors.Left := 120 + CountTimes*iColorEditorWidth - btnApplyWeatherColors.Width;
    btnApplyWeatherColors.Top := 40 + Succ(i)*iColorEditorHeight;
    btnApplyWeatherColors.Caption := 'Apply Changes';
    btnApplyWeatherColors.OnClick := btnApplyWeatherColorsClick;

    // LIGHTING COLORS TABSHEET
    if IsFormat3 then begin
      tsLightingColors := TTabSheet.Create(pgcWeather);
      tsLightingColors.PageControl := pgcWeather;
      tsLightingColors.Caption := 'Directional Ambient Lighting Colors';
      
      sbx := TScrollBox.Create(frm);
      sbx.Parent := tsLightingColors;
      sbx.Align := alClient;
      sbx.BorderStyle := bsNone;
      sbx.HorzScrollBar.Tracking := True;
      sbx.VertScrollBar.Tracking := True;

      e1 := ElementByName(Weather, 'Directional Ambient Lighting Colors');
      for i := 0 to Pred(CountTimes) do begin
        e2 := ElementByPath(ElementByIndex(e1, i), 'Directional');
        for j := 0 to Pred(ElementCount(e2)) do begin
          if j = 0 then begin
            lbl := CreateLabel(sbx, 120 + i*iColorEditorWidth, 8, slColorTimes[i]);
            lbl.AutoSize := False;
            lbl.Width := iColorEditorWidth;
            lbl.Alignment := taCenter;
          end;
          if i = 0 then begin
            lbl := CreateLabel(sbx, 12, 28 + Succ(j)*iColorEditorHeight - iColorEditorHeight div 2 - 5, Name(ElementByIndex(e2, j)));
            lbl.AutoSize := False;
            lbl.Width := 100;
            lbl.Alignment := taRightJustify;
          end;
          CreateColorEditor(sbx, 120 + i*iColorEditorWidth, 28 + j*iColorEditorHeight, ElementByIndex(e2, j));
          Inc(CountLightingColors);
        end;
      end;

      btnApplyLightingColors := TButton.Create(frm);
      btnApplyLightingColors.Parent := sbx;
      btnApplyLightingColors.Width := 100;
      btnApplyLightingColors.Left := 120 + CountTimes*iColorEditorWidth - btnApplyLightingColors.Width;
      btnApplyLightingColors.Top := 40 + Succ(j)*iColorEditorHeight;
      btnApplyLightingColors.Caption := 'Apply Changes';
      btnApplyLightingColors.OnClick := btnApplyLightingColorsClick;
    end;

    // TOOLS TABSHEET
    tsTools := TTabSheet.Create(pgcWeather);
    tsTools.PageControl := pgcWeather;
    tsTools.Caption := 'Tools';

    btnCopyClouds := TButton.Create(frm);
    btnCopyClouds.Parent := tsTools;
    btnCopyClouds.Left := 16; btnCopyClouds.Top := 16; btnCopyClouds.Width := 200;
    btnCopyClouds.Caption := 'Copy clouds from';
    btnCopyClouds.OnClick := btnCopyCloudsClick;

    btnCopyWeatherColors := TButton.Create(frm);
    btnCopyWeatherColors.Parent := tsTools;
    btnCopyWeatherColors.Left := 16; btnCopyWeatherColors.Top := 46; btnCopyWeatherColors.Width := 200;
    btnCopyWeatherColors.Caption := 'Copy weather colors from';
    btnCopyWeatherColors.OnClick := btnCopyWeatherColorsClick;

    if IsFormat3 then begin
      btnCopyLightingColors := TButton.Create(frm);
      btnCopyLightingColors.Parent := tsTools;
      btnCopyLightingColors.Left := 16; btnCopyLightingColors.Top := 76; btnCopyLightingColors.Width := 200;
      btnCopyLightingColors.Caption := 'Copy lighting colors from';
      btnCopyLightingColors.OnClick := btnCopyLightingColorsClick;
    end;
    

    frm.ShowModal;
  finally
    frm.Free;
  end;
end;

//============================================================================
// Weather Editor
procedure DoWeatherEditor(e: IInterface);
var
  slContainers, slAssets, slFiltered: TStringList;
  i: integer;
begin
  Weather := e;
  slCloudTextures := TwbFastStringList.Create;
  slCloudTextures.Sorted := True;
  slCloudTextures.Duplicates := dupIgnore;
  slCloudSignatures := TStringList.Create;
  slCloudSignatures.Delimiter := ',';
  slCloudSignatures.DelimitedText := sCloudLayerSignatures;
  CountCloudLayers := slCloudSignatures.Count;
  slColorTimes := TStringList.Create;
  slColorTimes.Delimiter := ',';
  slColorTimes.DelimitedText := sColorTimes;
  CountTimes := slColorTimes.Count;
  lstCED := TList.Create;
  lstCEDElement := TList.Create;

  // list of available cloud textures
  slContainers := TStringList.Create;
  slAssets := TwbFastStringList.Create;
  try
    ResourceContainerList(slContainers);
    for i := 0 to Pred(slContainers.Count) do
      ResourceList(slContainers[i], slAssets);
    slAssets.Sort;
    wbRemoveDuplicateStrings(slAssets);
    wbFilterStrings(slAssets, slCloudTextures, sCloudTexturesLocation);
  finally
    slAssets.Free;
    slContainers.Free;
  end;
  // delete "textures\" part
  slCloudTextures.Sorted := False;
  for i := 0 to Pred(slCloudTextures.Count) do
    slCloudTextures[i] := Copy(slCloudTextures[i], 10, Length(slCloudTextures[i]));
  slCloudTextures.Sorted := True;
  
  EditorUI;

  slCloudTextures.Free;
  slCloudSignatures.Free;
  slColorTimes.Free;
  lstCED.Free;
  lstCEDElement.Free;
end;

//============================================================================
function Initialize: integer;
begin
  // game specific settings
  if IsFormat3 then begin
    sCloudLayerSignatures := '00TX,10TX,20TX,30TX,40TX,50TX,60TX,70TX,80TX,90TX,:0TX,;0TX,<0TX,=0TX,>0TX,?0TX,@0TX,A0TX,B0TX,C0TX,D0TX,E0TX,F0TX,G0TX,H0TX,I0TX,J0TX,K0TX,L0TX';
  end
  else if (wbGameMode = gmFO3) or (wbGameMode = gmFNV) then begin
    sCloudLayerSignatures := 'DNAM,CNAM,ANAM,BNAM';
  end
  else if wbGameMode = gmTES4 then begin
    sCloudLayerSignatures := 'CNAM,DNAM';
  end
  else begin
    MessageDlg(Format('Weather Editor for %s is not supported', [wbGameName]), mtInformation, [mbOk], 0);
    Result := 1;
    Exit;
  end;
  // time spans for colors
  if (wbGameMode = gmFO4) or (wbGameMode = gmFO4VR) then
    sColorTimes := 'Sunrise,Day,Sunset,Night,EarlySunrise,LateSunrise,EarlySunset,LateSunset'
  else
    sColorTimes := 'Sunrise,Day,Sunset,Night';
end;

//============================================================================
function Process(e: IInterface): integer;
begin
  if Signature(e) <> 'WTHR' then
    MessageDlg(Format('The selected record %s is not a weather', [Name(e)]), mtInformation, [mbOk], 0)
  else
    DoWeatherEditor(e);

  Result := 1;
end;


end.
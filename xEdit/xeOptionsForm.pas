{******************************************************************************

  This Source Code Form is subject to the terms of the Mozilla Public License, 
  v. 2.0. If a copy of the MPL was not distributed with this file, You can obtain 
  one at https://mozilla.org/MPL/2.0/.

*******************************************************************************}

unit xeOptionsForm;

{$I xeDefines.inc}

interface

uses
  System.Classes,

  Vcl.Controls,
  Vcl.Forms,
  Vcl.ComCtrls,
  Vcl.ExtCtrls,
  Vcl.Samples.Spin,
  Vcl.StdCtrls,
  Vcl.Styles.Preview,
  Vcl.Themes,

  VirtualTrees,

  wbInterface;

type
  TfrmOptions = class(TForm)
    pcOptions: TPageControl;
    tsCleaning: TTabSheet;
    btnOK: TButton;
    btnCancel: TButton;
    cbUDRSetXESP: TCheckBox;
    cbUDRSetScale: TCheckBox;
    cbUDRSetZ: TCheckBox;
    edUDRSetScaleValue: TEdit;
    edUDRSetZValue: TEdit;
    cbUDRSetMSTT: TCheckBox;
    edUDRSetMSTTValue: TEdit;
    Label1: TLabel;
    tsGeneral: TTabSheet;
    cbHideUnused: TCheckBox;
    cbHideIgnored: TCheckBox;
    cbHideNeverShow: TCheckBox;
    cbLoadBSAs: TCheckBox;
    cbSortFLST: TCheckBox;
    tsUISettings: TTabSheet;
    clbConflictThis: TColorBox;
    Label3: TLabel;
    cbConflictThis: TComboBox;
    Label4: TLabel;
    cbConflictAll: TComboBox;
    clbConflictAll: TColorBox;
    cbSimpleRecords: TCheckBox;
    cbShowUnsavedHint: TCheckBox;
    cbTrackAllEditorID: TCheckBox;
    cbSortINFO: TCheckBox;
    cbShowFlagEnumValue: TCheckBox;
    pnlFontRecords: TPanel;
    pnlFontMessages: TPanel;
    pnlFontViewer: TPanel;
    cbActorTemplateHide: TCheckBox;
    cbClampFormID: TCheckBox;
    cbShowGroupRecordCount: TCheckBox;
    Label5: TLabel;
    edColumnWidth: TEdit;
    edRowHeight: TEdit;
    Label6: TLabel;
    cbShowTip: TCheckBox;
    sedAutoCompareSelectedLimit: TSpinEdit;
    Label7: TLabel;
    Label8: TLabel;
    cbShowFileFlags: TCheckBox;
    cbAlignArrayElements: TCheckBox;
    Label9: TLabel;
    sedNavChangeDelay: TSpinEdit;
    Label10: TLabel;
    cbRequireCtrlForDblClick: TCheckBox;
    cbFocusAddedElement: TCheckBox;
    tbsUITheme: TTabSheet;
    pnlThemeTop: TPanel;
    rbThemeSystem: TRadioButton;
    cbThemeSystem: TComboBox;
    rbThemeLight: TRadioButton;
    cbThemeLight: TComboBox;
    rbThemeDark: TRadioButton;
    cbThemeDark: TComboBox;
    pnlThemePreview: TPanel;
    cbPatron: TCheckBox;
    cbNoGitHubCheck: TCheckBox;
    cbNoNexusModsCheck: TCheckBox;
    cbResetModifiedOnSave: TCheckBox;
    cbAlwaysSaveOnam: TCheckBox;
    tsExperts: TTabSheet;
    cbFillPNAM: TCheckBox;
    cbManualCleaningHide: TCheckBox;
    cbManualCleaningAllow: TCheckBox;
    cbShrinkButtons: TCheckBox;
    cbCollapseBenignArray: TCheckBox;
    tsViewSettings: TTabSheet;
    lblFieldsToCollapse: TLabel;
    cbDecodeTexture: TCheckBox;
    cbConvertIntFormID: TCheckBox;
    cbWriteOffsetData: TCheckBox;
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure FormCreate(Sender: TObject);
    procedure cbConflictThisChange(Sender: TObject);
    procedure clbConflictThisChange(Sender: TObject);
    procedure cbConflictAllChange(Sender: TObject);
    procedure clbConflictAllChange(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure pnlFontRecordsClick(Sender: TObject);
    procedure rbThemeClick(Sender: TObject);
    procedure cbThemeSystemSelect(Sender: TObject);
  private
    vspThemePreview: TVisualStylePreview;
    vstCollapse: TVirtualStringTree;
    procedure UpdateThemePreview;
    procedure CreateCollapseTree;
    procedure vstCollapseGetText(Sender: TBaseVirtualTree; Node: PVirtualNode; Column: TColumnIndex; TextType: TVSTTextType; var CellText: string);
    function GetCollapseOptions: TwbCollapseOptions;
    procedure SetCollapseOptions(const aValue: TwbCollapseOptions);
  public
    { Public declarations }
    _Files: PwbFiles ;
    function GetSelectedTheme: string;
    property CollapseOptions: TwbCollapseOptions
      read GetCollapseOptions
      write SetCollapseOptions;
  end;

implementation

{$R *.dfm}

uses
  System.Generics.Collections,
  System.TypInfo,

  Vcl.Dialogs,
  Vcl.Styles.Utils.SystemMenu,

  Winapi.Windows,

  xeMainForm;

type
  PCollapseNodeData = ^TCollapseNodeData;
  TCollapseNodeData = record
    Option : TwbCollapseOption;
  end;

var
  wbColorConflictAllDefault: TConflictAllColors;
  wbColorConflictThisDefault: TConflictThisColors;

procedure TfrmOptions.cbConflictAllChange(Sender: TObject);
begin
  clbConflictAll.Selected := wbColorConflictAll[TConflictAll(cbConflictAll.Items.Objects[cbConflictAll.ItemIndex])];
end;

procedure TfrmOptions.cbConflictThisChange(Sender: TObject);
begin
  clbConflictThis.Selected := wbColorConflictThis[TConflictThis(cbConflictThis.Items.Objects[cbConflictThis.ItemIndex])];
end;

procedure TfrmOptions.cbThemeSystemSelect(Sender: TObject);
begin
  UpdateThemePreview;
end;

procedure TfrmOptions.clbConflictAllChange(Sender: TObject);
begin
  wbColorConflictAll[TConflictAll(cbConflictAll.Items.Objects[cbConflictAll.ItemIndex])] := clbConflictAll.Selected;
end;

procedure TfrmOptions.clbConflictThisChange(Sender: TObject);
begin
  wbColorConflictThis[TConflictThis(cbConflictThis.Items.Objects[cbConflictThis.ItemIndex])] := clbConflictThis.Selected;
end;

procedure TfrmOptions.CreateCollapseTree;

  procedure AddChildren(aParentNode: PVirtualNode; aParent: TwbCollapseOption);
  begin
    for var lOption := Low(TwbCollapseOption) to High(TwbCollapseOption) do
      if (lOption <> clpRoot) and (wbCollapseOptionInfos[lOption].Parent = aParent) then begin
        var lNode := vstCollapse.AddChild(aParentNode);
        var lData: PCollapseNodeData := vstCollapse.GetNodeData(lNode);
        lData.Option := lOption;
        if cofHeader in wbCollapseOptionInfos[lOption].Flags then begin
          vstCollapse.CheckType[lNode] := ctTriStateCheckBox;
          AddChildren(lNode, lOption);
        end else
          vstCollapse.CheckType[lNode] := ctCheckBox;
      end;
  end;

begin
  vstCollapse := TVirtualStringTree.Create(Self);
  vstCollapse.Name := 'vstCollapse';
  vstCollapse.Parent := tsViewSettings;
  vstCollapse.SetBounds(16, 39, 420, 296);
  vstCollapse.TabOrder := 0;
  vstCollapse.NodeDataSize := SizeOf(TCollapseNodeData);
  vstCollapse.TreeOptions.MiscOptions := vstCollapse.TreeOptions.MiscOptions + [toCheckSupport];
  vstCollapse.TreeOptions.AutoOptions := vstCollapse.TreeOptions.AutoOptions + [toAutoTristateTracking];
  vstCollapse.TreeOptions.SelectionOptions := vstCollapse.TreeOptions.SelectionOptions + [toFullRowSelect];
  vstCollapse.OnGetText := vstCollapseGetText;

  vstCollapse.BeginUpdate;
  try
    AddChildren(nil, clpRoot);
    vstCollapse.FullExpand;
  finally
    vstCollapse.EndUpdate;
  end;
end;

procedure TfrmOptions.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  if ModalResult <> mrOk then begin
    wbColorConflictAll := wbColorConflictAllDefault;
    wbColorConflictThis := wbColorConflictThisDefault;
  end;
end;

procedure TfrmOptions.FormCreate(Sender: TObject);
var
  ct: TConflictThis;
  ca: TConflictAll;
  s : string;
  LStyleNames: TArray<string>;
  Style : TCustomStyleServices;
  cb: TComboBox;
  rb: TRadioButton;
begin
  CreateCollapseTree;
  xeApplyFontAndScale(Self);

  if wbThemesSupported then begin
    with TVclStylesSystemMenu.Create(Self) do begin
      ShowNativeStyle := True;
      MenuCaption := 'Theme';
    end;

   vspThemePreview := TVisualStylePreview.Create(Self);
   with vspThemePreview do begin
     PreviewType := ptTabs;
     Parent:= pnlThemePreview;
     Align := alClient;
   end;

    LStyleNames:=TStyleManager.StyleNames;
    TArray.Sort<String>(LStyleNames);

    for s in LStyleNames do begin
      Style := TStyleManager.Style[s];
      if not Assigned(Style) then
        Continue;

      if Style.IsSystemStyle then begin
        cb := cbThemeSystem;
        rb := rbThemeSystem;
      end else if IsDarkStyle(Style) then begin
        cb := cbThemeDark;
        rb := rbThemeDark;
      end else begin
        cb := cbThemeLight;
        rb := rbThemeLight;
      end;

      cb.Items.Add(s);
      if TStyleManager.ActiveStyle = Style then begin
        rb.Checked := True;
        cb.ItemIndex := Pred(cb.Items.Count);
        vspThemePreview.Style := Style;
        vspThemePreview.Caption := s;
      end;
    end;

    rbThemeSystem.Enabled := cbThemeSystem.Items.Count > 0;
    rbThemeLight.Enabled := cbThemeLight.Items.Count > 0;
    rbThemeDark.Enabled := cbThemeDark.Items.Count > 0;

    cbThemeSystem.Enabled := rbThemeSystem.Checked;
    cbThemeLight.Enabled := rbThemeLight.Checked;
    cbThemeDark.Enabled := rbThemeDark.Checked;

    if rbThemeSystem.Enabled and (cbThemeSystem.ItemIndex < 0) then
      cbThemeSystem.ItemIndex := 0;
    if rbThemeLight.Enabled and (cbThemeLight.ItemIndex < 0) then
      cbThemeLight.ItemIndex := 0;
    if rbThemeDark.Enabled and (cbThemeDark.ItemIndex < 0) then begin
      cbThemeDark.ItemIndex := cbThemeDark.Items.IndexOf('Carbon');
      if cbThemeDark.ItemIndex < 0 then
        cbThemeDark.ItemIndex := 0;
    end;

    UpdateThemePreview;
  end else
    tbsUITheme.TabVisible := False;

  for ct := ctNotDefined to High(TConflictThis) do
    cbConflictThis.Items.AddObject(Copy(GetEnumName(TypeInfo(TConflictThis), Integer(ct)), 3, 100), Pointer(ct));
  cbConflictThis.ItemIndex := 0;
  cbConflictThisChange(nil);

  for ca := caNoConflict to High(TConflictAll) do
    cbConflictAll.Items.AddObject(Copy(GetEnumName(TypeInfo(TConflictAll), Integer(ca)), 3, 100), Pointer(ca));
  cbConflictAll.ItemIndex := 0;
  cbConflictAllChange(nil);

  wbColorConflictAllDefault := wbColorConflictAll;
  wbColorConflictThisDefault := wbColorConflictThis;

  pcOptions.ActivePageIndex := 0;

  tsExperts.TabVisible := wbIKnowWhatImDoing;
end;

procedure TfrmOptions.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key = VK_ESCAPE then
    ModalResult := mrCancel;
end;

function TfrmOptions.GetCollapseOptions: TwbCollapseOptions;
var
  lNode : PVirtualNode;
  lData : PCollapseNodeData;
begin
  Result := [];
  lNode := vstCollapse.GetFirst;
  while Assigned(lNode) do begin
    lData := vstCollapse.GetNodeData(lNode);
    if not (cofHeader in wbCollapseOptionInfos[lData.Option].Flags) and (vstCollapse.CheckState[lNode] in [csCheckedNormal, csCheckedPressed]) then
      Include(Result, lData.Option);
    lNode := vstCollapse.GetNext(lNode);
  end;
end;

function TfrmOptions.GetSelectedTheme: string;
begin
  if rbThemeSystem.Checked then
    Result := cbThemeSystem.Text
  else if rbThemeLight.Checked then
    Result := cbThemeLight.Text
  else if rbThemeDark.Checked then
    Result := cbThemeDark.Text
  else
    Result := '';
end;

procedure TfrmOptions.pnlFontRecordsClick(Sender: TObject);
begin
  with TFontDialog.Create(Self) do try
    Font := TPanel(Sender).Font;
    if Execute then
      TPanel(Sender).Font := Font;
  finally
    Free;
  end;
end;

procedure TfrmOptions.rbThemeClick(Sender: TObject);
begin
  cbThemeSystem.Enabled := rbThemeSystem.Checked;
  cbThemeLight.Enabled := rbThemeLight.Checked;
  cbThemeDark.Enabled := rbThemeDark.Checked;
  UpdateThemePreview;
end;

procedure TfrmOptions.SetCollapseOptions(const aValue: TwbCollapseOptions);
var
  lNode : PVirtualNode;
  lData : PCollapseNodeData;
begin
  vstCollapse.BeginUpdate;
  try
    lNode := vstCollapse.GetFirst;
    while Assigned(lNode) do begin
      lData := vstCollapse.GetNodeData(lNode);
      if not (cofHeader in wbCollapseOptionInfos[lData.Option].Flags) then
        if lData.Option in aValue then
          vstCollapse.CheckState[lNode] := csCheckedNormal
        else
          vstCollapse.CheckState[lNode] := csUncheckedNormal;
      lNode := vstCollapse.GetNext(lNode);
    end;
  finally
    vstCollapse.EndUpdate;
  end;
end;

procedure TfrmOptions.UpdateThemePreview;
var
  Style : TCustomStyleServices;
begin
  if not Assigned(vspThemePreview) then
    Exit;

  Style := TStyleManager.Style[GetSelectedTheme];

  if Assigned(Style) and not Style.IsSystemStyle then begin
    vspThemePreview.Caption := Style.Name;
    vspThemePreview.Style := Style;
    pnlThemePreview.Visible := True;
    vspThemePreview.Repaint;
  end else
    pnlThemePreview.Visible := False;
end;

procedure TfrmOptions.vstCollapseGetText(Sender: TBaseVirtualTree; Node: PVirtualNode; Column: TColumnIndex; TextType: TVSTTextType; var CellText: string);
var
  lData : PCollapseNodeData;
begin
  lData := Sender.GetNodeData(Node);
  CellText := wbCollapseOptionInfos[lData.Option].Caption;
end;

end.

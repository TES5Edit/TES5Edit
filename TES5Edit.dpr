{******************************************************************************

  This Source Code Form is subject to the terms of the Mozilla Public License, 
  v. 2.0. If a copy of the MPL was not distributed with this file, You can obtain 
  one at https://mozilla.org/MPL/2.0/.

*******************************************************************************}

// JCL_DEBUG_EXPERT_INSERTJDBG ON
// JCL_DEBUG_EXPERT_GENERATEJDBG OFF
// JCL_DEBUG_EXPERT_DELETEMAPFILE ON

program TES5Edit;

uses
  Forms,
  Dialogs,
  SysUtils,
  Colors,
  VirtualTrees,
  VTEditors,
  VirtualEditTree,
  {$IFNDEF LiteVersion}
  cxVTEditors,
  {$ENDIF}
  Vcl.Themes,
  Vcl.Styles,
  Vcl.Styles.Hooks,
  Vcl.Styles.Utils.Menus,
  Vcl.Styles.Utils.Forms,
  Vcl.Styles.Utils.StdCtrls,
  Vcl.Styles.Utils.ComCtrls,
  Vcl.Styles.Utils.ScreenTips,
  Vcl.Styles.Utils.SysControls,
  Vcl.Styles.Utils.SysStyleHook,
  wbInit in 'wbInit.pas',
  wbBSA in 'wbBSA.pas',
  wbHelpers in 'wbHelpers.pas',
  wbScriptAdapter in 'wbScriptAdapter.pas',
  wbInterface in 'wbInterface.pas',
  wbImplementation in 'wbImplementation.pas',
  wbScriptAdapterMisc in 'wbScriptAdapterMisc.pas',
  wbScriptAdapterDF in 'wbScriptAdapterDF.pas',
  wbNifScanner in 'wbNifScanner.pas',
  wbStreams in 'wbStreams.pas',
  wbSort in 'wbSort.pas',
  wbLOD in 'wbLOD.pas',
  wbLocalization in 'wbLocalization.pas',
  frmViewMain in 'frmViewMain.pas' {frmMain},
  FilterOptionsFrm in 'FilterOptionsFrm.pas' {frmFilterOptions},
  FileSelectFrm in 'FileSelectFrm.pas' {frmFileSelect},
  ViewElementsFrm in 'ViewElementsFrm.pas' {frmViewElements},
  EditWarningFrm in 'EditWarningFrm.pas' {frmEditWarning},
  frmWaitForm in 'frmWaitForm.pas' {frmWait},
  frmLocalizationForm in 'frmLocalizationForm.pas' {frmLocalization},
  frmLocalizePluginForm in 'frmLocalizePluginForm.pas' {frmLocalizePlugin},
  frmScriptForm in 'frmScriptForm.pas' {frmScript},
  frmOptionsForm in 'frmOptionsForm.pas' {frmOptions},
  frmLogAnalyzerForm in 'frmLogAnalyzerForm.pas' {frmLogAnalyzer},
  frmLODGenForm in 'frmLODGenForm.pas',
  frmTipForm in 'frmTipForm.pas',
  frmModuleSelectForm in 'frmModuleSelectForm.pas',
  frmModGroupSelectForm in 'frmModGroupSelectForm.pas',
  frmModGroupEditForm in 'frmModGroupEditForm.pas',
  wbDefinitionsCommon in 'wbDefinitionsCommon.pas',
  wbDefinitionsFNV in 'wbDefinitionsFNV.pas',
  wbDefinitionsFNVSaves in 'wbDefinitionsFNVSaves.pas',
  wbDefinitionsFO3 in 'wbDefinitionsFO3.pas',
  wbDefinitionsFO3Saves in 'wbDefinitionsFO3Saves.pas',
  wbDefinitionsFO4 in 'wbDefinitionsFO4.pas',
  wbDefinitionsFO4Saves in 'wbDefinitionsFO4Saves.pas',
  wbDefinitionsFO76 in 'wbDefinitionsFO76.pas',
  wbDefinitionsTES3 in 'wbDefinitionsTES3.pas',
  wbDefinitionsTES4 in 'wbDefinitionsTES4.pas',
  wbDefinitionsTES4Saves in 'wbDefinitionsTES4Saves.pas',
  wbDefinitionsTES5 in 'wbDefinitionsTES5.pas',
  wbDefinitionsTES5Saves in 'wbDefinitionsTES5Saves.pas',
  wbSaveInterface in 'wbSaveInterface.pas',
  wbDataFormat in 'wbDataFormat.pas',
  wbDataFormatMisc in 'wbDataFormatMisc.pas',
  wbDataFormatMaterial in 'wbDataFormatMaterial.pas',
  wbDataFormatNif in 'wbDataFormatNif.pas',
  wbDataFormatNifTypes in 'wbDataFormatNifTypes.pas',
  wbNifMath in 'wbNifMath.pas',
  wbHalfFloat in 'wbHalfFloat.pas',
  wbModGroups in 'wbModGroups.pas',
  wbBetterStringList in 'wbBetterStringList.pas',
  frmLegendForm in 'frmLegendForm.pas' {frmLegend},
  frmWorldspaceCellDetailsForm in 'frmWorldspaceCellDetailsForm.pas' {frmWorldspaceCellDetails},
  frmRichEditForm in 'frmRichEditForm.pas' {frmRichEdit},
  frmDeveloperMessageForm in 'frmDeveloperMessageForm.pas' {frmDeveloperMessage},
  wbHardcoded in 'wbHardcoded.pas' {wbHardcodedContainer: TDataModule};

{$R *.res}
{$MAXSTACKSIZE 2097152}

const
  IMAGE_FILE_LARGE_ADDRESS_AWARE = $0020;

{$SetPEFlags IMAGE_FILE_LARGE_ADDRESS_AWARE}

begin
  UseLatestCommonDialogs := True;
  SysUtils.FormatSettings.DecimalSeparator := '.';

  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.UpdateFormatSettings := False;
  Application.HintHidePause := 10000;

  wbInitStyles;

  if not wbDoInit then
    Exit;

  Application.Title := wbApplicationTitle;
  try
    Application.CreateForm(TfrmMain, frmMain);
    Application.Run;
  finally
    DoRename;
  end;
end.

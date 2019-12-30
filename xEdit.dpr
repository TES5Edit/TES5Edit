{******************************************************************************

  This Source Code Form is subject to the terms of the Mozilla Public License, 
  v. 2.0. If a copy of the MPL was not distributed with this file, You can obtain 
  one at https://mozilla.org/MPL/2.0/.

*******************************************************************************}

{$IFDEF DEBUG}
// JCL_DEBUG_EXPERT_GENERATEJDBG OFF
// JCL_DEBUG_EXPERT_INSERTJDBG ON
// JCL_DEBUG_EXPERT_DELETEMAPFILE ON
{$ENDIF}

program xEdit;

{$I xeDefines.inc}

uses
  Forms,
  Dialogs,
  SysUtils,
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
  xeInit in 'xEdit\xeInit.pas',
  wbBetterStringList in 'Core\wbBetterStringList.pas',
  wbBSA in 'Core\wbBSA.pas',
  wbDataFormat in 'Core\wbDataFormat.pas',
  wbDataFormatMaterial in 'Core\wbDataFormatMaterial.pas',
  wbDataFormatMisc in 'Core\wbDataFormatMisc.pas',
  wbDataFormatNif in 'Core\wbDataFormatNif.pas',
  wbDataFormatNifTypes in 'Core\wbDataFormatNifTypes.pas',
  wbDefinitionsCommon in 'Core\wbDefinitionsCommon.pas',
  wbDefinitionsFNV in 'Core\wbDefinitionsFNV.pas',
  wbDefinitionsFNVSaves in 'Core\wbDefinitionsFNVSaves.pas',
  wbDefinitionsFO3 in 'Core\wbDefinitionsFO3.pas',
  wbDefinitionsFO3Saves in 'Core\wbDefinitionsFO3Saves.pas',
  wbDefinitionsFO4 in 'Core\wbDefinitionsFO4.pas',
  wbDefinitionsFO4Saves in 'Core\wbDefinitionsFO4Saves.pas',
  wbDefinitionsFO76 in 'Core\wbDefinitionsFO76.pas',
  wbDefinitionsTES3 in 'Core\wbDefinitionsTES3.pas',
  wbDefinitionsTES4 in 'Core\wbDefinitionsTES4.pas',
  wbDefinitionsTES4Saves in 'Core\wbDefinitionsTES4Saves.pas',
  wbDefinitionsTES5 in 'Core\wbDefinitionsTES5.pas',
  wbDefinitionsTES5Saves in 'Core\wbDefinitionsTES5Saves.pas',
  wbHalfFloat in 'Core\wbHalfFloat.pas',
  wbHardcoded in 'Core\wbHardcoded.pas' {wbHardcodedContainer: TDataModule},
  wbHelpers in 'Core\wbHelpers.pas',
  wbImplementation in 'Core\wbImplementation.pas',
  wbInterface in 'Core\wbInterface.pas',
  wbLocalization in 'Core\wbLocalization.pas',
  wbLOD in 'Core\wbLOD.pas',
  wbModGroups in 'Core\wbModGroups.pas',
  wbNifMath in 'Core\wbNifMath.pas',
  wbNifScanner in 'Core\wbNifScanner.pas',
  wbSaveInterface in 'Core\wbSaveInterface.pas',
  wbSort in 'Core\wbSort.pas',
  wbStreams in 'Core\wbStreams.pas',
  xeDeveloperMessageForm in 'xEdit\xeDeveloperMessageForm.pas' {frmDeveloperMessage},
  xeEditWarningForm in 'xEdit\xeEditWarningForm.pas' {frmEditWarning},
  xeFileSelectForm in 'xEdit\xeFileSelectForm.pas' {frmFileSelect},
  xeFilterOptionsForm in 'xEdit\xeFilterOptionsForm.pas' {frmFilterOptions},
  xeLegendForm in 'xEdit\xeLegendForm.pas' {frmLegend},
  xeLocalizationForm in 'xEdit\xeLocalizationForm.pas' {frmLocalization},
  xeLocalizePluginForm in 'xEdit\xeLocalizePluginForm.pas' {frmLocalizePlugin},
  xeLODGenForm in 'xEdit\xeLODGenForm.pas', {frmLODGen}
  xeLogAnalyzerForm in 'xEdit\xeLogAnalyzerForm.pas' {frmLogAnalyzer},
  xeMainForm in 'xEdit\xeMainForm.pas' {frmMain},
  xeModGroupEditForm in 'xEdit\xeModGroupEditForm.pas', {frmModGroupEdit}
  xeModGroupSelectForm in 'xEdit\xeModGroupSelectForm.pas', {frmModGroupSelect}
  xeModuleSelectForm in 'xEdit\xeModuleSelectForm.pas', {frmModuleSelect}
  xeOptionsForm in 'xEdit\xeOptionsForm.pas' {frmOptions},
  xeRichEditForm in 'xEdit\xeRichEditForm.pas' {frmRichEdit},
  xeScriptAdapter in 'xEdit\xeScriptAdapter.pas',
  xeScriptAdapterDF in 'xEdit\xeScriptAdapterDF.pas',
  xeScriptAdapterMisc in 'xEdit\xeScriptAdapterMisc.pas',
  xeScriptForm in 'xEdit\xeScriptForm.pas' {frmScript},
  xeTipForm in 'xEdit\xeTipForm.pas', {frmTip}
  xeViewElementsForm in 'xEdit\xeViewElementsForm.pas' {frmViewElements},
  xeWaitForm in 'xEdit\xeWaitForm.pas' {frmWait},
  xeWorldspaceCellDetailsForm in 'xEdit\xeWorldspaceCellDetailsForm.pas' {frmWorldspaceCellDetails};

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

{******************************************************************************


  This Source Code Form is subject to the terms of the Mozilla Public License,
  v. 2.0. If a copy of the MPL was not distributed with this file, You can obtain
  one at https://mozilla.org/MPL/2.0/.

*******************************************************************************}

{$I xeDefines.inc}

{$IFDEF EXCEPTION_LOGGING_ENABLED}
// JCL_DEBUG_EXPERT_GENERATEJDBG OFF
// JCL_DEBUG_EXPERT_INSERTJDBG ON
// JCL_DEBUG_EXPERT_DELETEMAPFILE ON
{$ENDIF}

program xEdit;

{$RTTI EXPLICIT METHODS([vcPrivate, vcProtected, vcPublic, vcPublished]) PROPERTIES([vcPrivate, vcProtected, vcPublic, vcPublished]) FIELDS([vcPrivate, vcProtected, vcPublic, vcPublished])}

uses
  {$IFDEF EXCEPTION_LOGGING_ENABLED}
  nxExceptionHook,
  {$ENDIF }
  System.SysUtils,

  VirtualEditTree,
  VirtualTrees,
  VTEditors,

  {$IFNDEF LiteVersion}
  cxVTEditors,
  {$ENDIF}

  Vcl.Dialogs,
  Vcl.Forms,
  Vcl.Themes,
  Vcl.Styles,
  Vcl.Styles.Hooks,
  Vcl.Styles.Utils.Menus,
  Vcl.Styles.Utils.Forms,
  Vcl.Styles.Utils.StdCtrls,
  Vcl.Styles.Utils.ScreenTips,

  Winapi.Windows,

  wbBetterStringList in 'Core\wbBetterStringList.pas',
  wbBSA in 'Core\wbBSA.pas',
  wbCommandLine in 'Core\wbCommandLine.pas',
  wbConflict in 'Core\wbConflict.pas',
  wbDataFormat in 'Core\wbDataFormat.pas',
  wbDataFormatMaterial in 'Core\wbDataFormatMaterial.pas',
  wbDataFormatMisc in 'Core\wbDataFormatMisc.pas',
  wbDataFormatNif in 'Core\wbDataFormatNif.pas',
  wbDataFormatNifTypes in 'Core\wbDataFormatNifTypes.pas',
  wbDataFormatWwise in 'Core\wbDataFormatWwise.pas',
  wbDefinitionsCommon in 'Core\wbDefinitionsCommon.pas',
  wbDefinitionsFNV in 'Core\wbDefinitionsFNV.pas',
  wbDefinitionsFNVSaves in 'Core\wbDefinitionsFNVSaves.pas',
  wbDefinitionsFO3 in 'Core\wbDefinitionsFO3.pas',
  wbDefinitionsFO3Saves in 'Core\wbDefinitionsFO3Saves.pas',
  wbDefinitionsFO4 in 'Core\wbDefinitionsFO4.pas',
  wbDefinitionsFO4Saves in 'Core\wbDefinitionsFO4Saves.pas',
  wbDefinitionsFO76 in 'Core\wbDefinitionsFO76.pas',
  wbDefinitionsReflection in 'Core\wbDefinitionsReflection.pas',
  wbDefinitionsSF1 in 'Core\wbDefinitionsSF1.pas',
  wbDefinitionsSignatures in 'Core\wbDefinitionsSignatures.pas',
  wbDefinitionsTES3 in 'Core\wbDefinitionsTES3.pas',
  wbDefinitionsTES4 in 'Core\wbDefinitionsTES4.pas',
  wbDefinitionsTES4Saves in 'Core\wbDefinitionsTES4Saves.pas',
  wbDefinitionsTES5 in 'Core\wbDefinitionsTES5.pas',
  wbDefinitionsTES5Saves in 'Core\wbDefinitionsTES5Saves.pas',
  wbDiff in 'Core\wbDiff.pas',
  wbHash in 'Core\wbHash.pas',
  wbHalfFloat in 'Core\wbHalfFloat.pas',
  wbHardcoded in 'Core\wbHardcoded.pas' {wbHardcodedContainer: TDataModule},
  wbHelpers in 'Core\wbHelpers.pas',
  wbImplementation in 'Core\wbImplementation.pas',
  wbInterface in 'Core\wbInterface.pas',
  wbLoadOrder in 'Core\wbLoadOrder.pas',
  wbLocalization in 'Core\wbLocalization.pas',
  wbLOD in 'Core\wbLOD.pas',
  wbModGroups in 'Core\wbModGroups.pas',
  wbNifMath in 'Core\wbNifMath.pas',
  wbNifScanner in 'Core\wbNifScanner.pas',
  wbSaveInterface in 'Core\wbSaveInterface.pas',
  wbSort in 'Core\wbSort.pas',
  wbStreams in 'Core\wbStreams.pas',

  xeInit in 'xEdit\xeInit.pas',
  xeDeveloperMessageForm in 'xEdit\xeDeveloperMessageForm.pas' {frmDeveloperMessage},
  xeEditWarningForm in 'xEdit\xeEditWarningForm.pas' {frmEditWarning},
  xeFileSelectForm in 'xEdit\xeFileSelectForm.pas' {frmFileSelect},
  xeFilterOptionsForm in 'xEdit\xeFilterOptionsForm.pas' {frmFilterOptions},
  xejviScriptAdapter in 'xEdit\JvI\xejviScriptAdapter.pas',
  xejviScriptAdapterContainer in 'xEdit\JvI\xejviScriptAdapterContainer.pas',
  xejviScriptAdapterDF in 'xEdit\JvI\xejviScriptAdapterDF.pas',
  xejviScriptAdapterElement in 'xEdit\JvI\xejviScriptAdapterElement.pas',
  xejviScriptAdapterFile in 'xEdit\JvI\xejviScriptAdapterFile.pas',
  xejviScriptAdapterHost in 'xEdit\JvI\xejviScriptAdapterHost.pas',
  xejviScriptAdapterMisc in 'xEdit\JvI\xejviScriptAdapterMisc.pas',
  xejviScriptAdapterMiscJson in 'xEdit\JvI\xejviScriptAdapterMiscJson.pas',
  xejviScriptAdapterMiscRegEx in 'xEdit\JvI\xejviScriptAdapterMiscRegEx.pas',
  xejviScriptAdapterMiscVcl in 'xEdit\JvI\xejviScriptAdapterMiscVcl.pas',
  xejviScriptAdapterRecord in 'xEdit\JvI\xejviScriptAdapterRecord.pas',
  xejviScriptAdapterResource in 'xEdit\JvI\xejviScriptAdapterResource.pas',
  xejviScriptHost in 'xEdit\JvI\xejviScriptHost.pas',
  xeLegendForm in 'xEdit\xeLegendForm.pas' {frmLegend},
  xeLocalizationForm in 'xEdit\xeLocalizationForm.pas' {frmLocalization},
  xeLocalizePluginForm in 'xEdit\xeLocalizePluginForm.pas' {frmLocalizePlugin},
  xeLODGenForm in 'xEdit\xeLODGenForm.pas',
  xeLogAnalyzerForm in 'xEdit\xeLogAnalyzerForm.pas' {frmLogAnalyzer},
  xeMainForm in 'xEdit\xeMainForm.pas' {frmMain},
  xeModGroupEditForm in 'xEdit\xeModGroupEditForm.pas',
  xeModGroupSelectForm in 'xEdit\xeModGroupSelectForm.pas',
  xeModuleSelectForm in 'xEdit\xeModuleSelectForm.pas',
  xeOptionsForm in 'xEdit\xeOptionsForm.pas' {frmOptions},
  xeRichEditForm in 'xEdit\xeRichEditForm.pas' {frmRichEdit},
  xeScriptForm in 'xEdit\xeScriptForm.pas' {frmScript},
  xeTipForm in 'xEdit\xeTipForm.pas',
  xeViewElementsForm in 'xEdit\xeViewElementsForm.pas' {frmViewElements},
  xeWaitForm in 'xEdit\xeWaitForm.pas' {frmWait},
  xeWorldspaceCellDetailsForm in 'xEdit\xeWorldspaceCellDetailsForm.pas' {frmWorldspaceCellDetails},
  xeGameSelectForm in 'xEdit\xeGameSelectForm.pas' {frmGameSelect};

{$R *.res}
{$MAXSTACKSIZE 2097152}

const
  IMAGE_FILE_LARGE_ADDRESS_AWARE = $0020;

{$SetPEFlags IMAGE_FILE_LARGE_ADDRESS_AWARE}

begin
  UseLatestCommonDialogs := True;
  FormatSettings.DecimalSeparator := '.';

  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.UpdateFormatSettings := False;
  Application.HintHidePause := 10000;

  xeInitStyles;

  if not xeDoInit then
    Exit;

  if xeIconResource <> '' then begin
    var lIconHandle := LoadIcon(HInstance, PChar(xeIconResource));
    if lIconHandle <> 0 then
      Application.Icon.Handle := lIconHandle;
  end;

  {$IFDEF EXCEPTION_LOGGING_ENABLED}
  nxEHAppVersion := wbApplicationTitle;
  {$ENDIF}
  Application.Title := wbApplicationTitle;
  try
    Application.CreateForm(TfrmMain, frmMain);
  Application.Run;
  finally
    DoRename;
  end;
end.
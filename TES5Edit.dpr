{*******************************************************************************

     The contents of this file are subject to the Mozilla Public License
     Version 1.1 (the "License"); you may not use this file except in
     compliance with the License. You may obtain a copy of the License at
     http://www.mozilla.org/MPL/

     Software distributed under the License is distributed on an "AS IS"
     basis, WITHOUT WARRANTY OF ANY KIND, either express or implied. See the
     License for the specific language governing rights and limitations
     under the License.

*******************************************************************************}

// JCL_DEBUG_EXPERT_INSERTJDBG ON
// JCL_DEBUG_EXPERT_GENERATEJDBG ON
// JCL_DEBUG_EXPERT_DELETEMAPFILE ON
program TES5Edit;

uses
  madExcept,
  Forms,
  Dialogs,
  SysUtils,
  Colors,
  VirtualTrees in 'VirtualTrees.pas',
  VTEditors in 'VTEditors.pas',
  VirtualEditTree in 'VirtualEditTree.pas',
{$IFNDEF LiteVersion}
  cxVTEditors,
{$ENDIF}
  wbInit in 'wbInit.pas',
  wbBSA in 'wbBSA.pas',
  wbHelpers in 'wbHelpers.pas',
  wbScriptAdapter in 'wbScriptAdapter.pas',
  wbInterface in 'wbInterface.pas',
  wbImplementation in 'wbImplementation.pas',
  wbScriptAdapterMisc in 'wbScriptAdapterMisc.pas',
  wbNifScanner in 'wbNifScanner.pas',
  wbStreams in 'wbStreams.pas',
  wbSort in 'wbSort.pas',
  wbLOD in 'wbLOD.pas',
  wbLocalization in 'wbLocalization.pas',
  frmViewMain in 'frmViewMain.pas',
  FilterOptionsFrm in 'FilterOptionsFrm.pas',
  FileSelectFrm in 'FileSelectFrm.pas',
  ViewElementsFrm in 'ViewElementsFrm.pas',
  EditWarningFrm in 'EditWarningFrm.pas',
  frmWaitForm in 'frmWaitForm.pas',
  frmLocalizationForm in 'frmLocalizationForm.pas',
  frmLocalizePluginForm in 'frmLocalizePluginForm.pas',
  frmScriptForm in 'frmScriptForm.pas',
  frmOptionsForm in 'frmOptionsForm.pas',
  frmLogAnalyzerForm in 'frmLogAnalyzerForm.pas',
  frmLODGenForm in 'frmLODGenForm.pas',
  wbDefinitionsFNV in 'wbDefinitionsFNV.pas',
  wbDefinitionsFNVSaves in 'wbDefinitionsFNVSaves.pas',
  wbDefinitionsFO3 in 'wbDefinitionsFO3.pas',
  wbDefinitionsFO3Saves in 'wbDefinitionsFO3Saves.pas',
  wbDefinitionsFO4 in 'wbDefinitionsFO4.pas',
  wbDefinitionsFO4Saves in 'wbDefinitionsFO4Saves.pas',
  wbDefinitionsTES3 in 'wbDefinitionsTES3.pas',
  wbDefinitionsTES4 in 'wbDefinitionsTES4.pas',
  wbDefinitionsTES4Saves in 'wbDefinitionsTES4Saves.pas',
  wbDefinitionsTES5 in 'wbDefinitionsTES5.pas',
  wbDefinitionsTES5Saves in 'wbDefinitionsTES5Saves.pas',
  wbSaveInterface in 'wbSaveInterface.pas',
  Zlibex in 'Zlibex.pas';

{$R *.res}
{$MAXSTACKSIZE 2097152}

const
  IMAGE_FILE_LARGE_ADDRESS_AWARE = $0020;

{$SetPEFlags IMAGE_FILE_LARGE_ADDRESS_AWARE}

begin
  SysUtils.FormatSettings.DecimalSeparator := '.';
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.UpdateFormatSettings := False;
  Application.HintHidePause := 10000;
  Application.Title := wbApplicationTitle;
  Application.CreateForm(TfrmMain, frmMain);
  Application.Run;
  DoRename;
end.

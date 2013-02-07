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
  wbDefinitionsFO3 in 'wbDefinitionsFO3.pas',
  wbDefinitionsFNV in 'wbDefinitionsFNV.pas',
  wbDefinitionsTES3 in 'wbDefinitionsTES3.pas',
  wbDefinitionsTES4 in 'wbDefinitionsTES4.pas',
  wbDefinitionsTES5 in 'wbDefinitionsTES5.pas',
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
  wbScriptAdapterMisc in 'wbScriptAdapterMisc.pas';

{$R *.res}

const
  IMAGE_FILE_LARGE_ADDRESS_AWARE = $0020;

{$SetPEFlags IMAGE_FILE_LARGE_ADDRESS_AWARE}

begin
  SysUtils.FormatSettings.DecimalSeparator := '.';
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.Title := wbApplicationTitle;
  Application.CreateForm(TfrmMain, frmMain);
  Application.Run;
  DoRename;
end.

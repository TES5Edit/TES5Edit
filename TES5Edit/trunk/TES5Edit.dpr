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
  nxReplacementMemoryManager,
  wbInit,
  nxExceptionHook,
  Forms,
  Dialogs,
  SysUtils,
  wbInterface,
  wbImplementation,
  wbDefinitionsTES4,
  wbDefinitionsFO3,
  wbDefinitionsFNV,
  frmViewMain in 'frmViewMain.pas' {frmMain},
  FilterOptionsFrm in 'FilterOptionsFrm.pas' {frmFilterOptions},
  FileSelectFrm in 'FileSelectFrm.pas' {frmFileSelect},
  ViewElementsFrm in 'ViewElementsFrm.pas' {frmViewElements},
  EditWarningFrm in 'EditWarningFrm.pas' {frmEditWarning},
  wbBSA in 'wbBSA.pas',
  wbScript in 'wbScript.pas',
  wbHelpers in 'wbHelpers.pas',
  frmWaitForm in 'frmWaitForm.pas' {frmWait};

{$R *.res}

const
  IMAGE_FILE_LARGE_ADDRESS_AWARE = $0020;

{$SetPEFlags IMAGE_FILE_LARGE_ADDRESS_AWARE}

begin
  SysUtils.DecimalSeparator := '.';
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.Title := wbApplicationTitle;
  Application.CreateForm(TfrmMain, frmMain);
  Application.Run;
  DoRename;
end.

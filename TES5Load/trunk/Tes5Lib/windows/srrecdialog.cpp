/*===========================================================================
 *
 * File:	Obrecdialog.CPP
 * Author:	Dave Humphrey (uesp@sympatico.ca)
 * Created On:	May 11, 2006
 *
 * Description
 *
 *=========================================================================*/

	/* Include Files */
#include "stdafx.h"
#include "obrecdialog.h"


/*===========================================================================
 *
 * Begin Message Map
 *
 *=========================================================================*/
BEGIN_MESSAGE_MAP(CObRecordDialog, CDialog)
	//{{AFX_MSG_MAP(CObRecordDialog)
	//}}AFX_MSG_MAP
END_MESSAGE_MAP()
/*===========================================================================
 *		End of Message Map
 *=========================================================================*/


/*===========================================================================
 *
 * Class CObRecordDialog Constructor
 *
 *=========================================================================*/
CObRecordDialog::CObRecordDialog (const int ID, CWnd* pParent) : CDialog(ID, pParent) {
 }
/*===========================================================================
 *		End of Class CObRecordDialog Constructor
 *=========================================================================*/


/*===========================================================================
 *
 * Class CObRecordDialog Method - void ClearControlData (void);
 *
 *=========================================================================*/
void CObRecordDialog::ClearControlData (void) {
  SetTitle(NULL);
 }
/*===========================================================================
 *		End of Class Method CObRecordDialog::ClearControlData()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CObRecordDialog Event - BOOL OnInitDialog ();
 *
 *=========================================================================*/
BOOL CObRecordDialog::OnInitDialog() {
  CDialog::OnInitDialog();
 
  SetControlData();	
  return (TRUE);
 }
/*===========================================================================
 *		End of Class Event CObRecordDialog::OnInitDialog()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CObRecordDialog Method - void SetControlData (void);
 *
 *=========================================================================*/
void CObRecordDialog::SetControlData (void) { 
  CSString Buffer;
  bool     Result;

	/* Ignore invalid records */
  if (GetRecord() == NULL) {
    ClearControlData();
    return;
   }

  Result = GetRecord()->GetField(Buffer, OB_FIELD_EDITORID);

  if (Result)
    SetTitle(Buffer);
  else
    SetTitle("");

  SetUIFields();
 }
/*===========================================================================
 *		End of Class Method CObRecordDialog::SetControlData()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CObRecordDialog Method - void SetTitle (pEditorID);
 *
 *=========================================================================*/
void CObRecordDialog::SetTitle (const SSCHAR* pEditorID) {
  CString Buffer;

  Buffer.Format("%s -- %s", GetTitlePrefix(), pEditorID == NULL ? "" : pEditorID);
  SetWindowText(Buffer);
 }
/*===========================================================================
 *		End of Class Method CObRecordDialog::SetTitle()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CObRecordDialog Method - void SetUIFields (void);
 *
 *=========================================================================*/
void CObRecordDialog::SetUIFields (void) {
  obuirecfields_t* pFields;
  CButton*	   pButton;
  CSString	   Buffer;
  CWnd*		   pWnd;
  dword		   Index;
  bool		   Result;

  pFields = GetUIFields();
  if (pFields == NULL) return;

  for (Index = 0; pFields[Index].FieldID != OB_FORMID_NULL; ++Index) {
    pWnd = GetDlgItem(pFields[Index].ControlID);
    if (pWnd == NULL) continue;

    Result = GetRecord()->GetField(Buffer, pFields[Index].FieldID);
    if (!Result) continue;

    if (pWnd->IsKindOf(RUNTIME_CLASS(CEdit))) {
      pWnd->SetWindowText(Buffer);
     }
    else if (pWnd->IsKindOf(RUNTIME_CLASS(CButton))) {
      pButton = (CButton *) pWnd;
      pButton->SetCheck(tolower(Buffer[0]) == 't');
     }
   }

 }
/*===========================================================================
 *		End of Class Method CObRecordDialog::SetUIFields()
 *=========================================================================*/


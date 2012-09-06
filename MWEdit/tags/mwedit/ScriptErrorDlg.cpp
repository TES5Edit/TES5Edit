/*===========================================================================
 *
 * File:	Scripterrordlg.CPP
 * Author:	Dave Humphrey (uesp@m0use.net)
 * Created On:	September 6, 2003
 *
 * Description
 *
 *=========================================================================*/

	/* Include Files */
#include "stdafx.h"
#include "MWEdit.h"
#include "ScriptErrorDlg.h"
#include "EsmScriptDefs.h"
#include "EsmScrFuncData.h"


/*===========================================================================
 *
 * Begin Local Definitions
 *
 *=========================================================================*/
#ifdef _DEBUG
  #define new DEBUG_NEW
  #undef THIS_FILE
  static char THIS_FILE[] = __FILE__;
#endif

  DEFINE_FILE("ScriptErrorDlg.cpp");
/*===========================================================================
 *		End of Local Definitions
 *=========================================================================*/


/*===========================================================================
 *
 * Begin CScriptErrorDlg Message Map
 *
 *=========================================================================*/
BEGIN_MESSAGE_MAP(CScriptErrorDlg, CDialog)
  //{{AFX_MSG_MAP(CScriptErrorDlg)
  ON_BN_CLICKED(IDC_FUNC_BUTTON, OnFuncButton)
  ON_BN_CLICKED(IDC_FUNC_GOTO, OnFuncGoto)
  //}}AFX_MSG_MAP
END_MESSAGE_MAP()
/*===========================================================================
 *		End of CScriptErrorDlg Message Map
 *=========================================================================*/


/*===========================================================================
 *
 * Class CScriptErrorDlg Constructor
 *
 *=========================================================================*/
CScriptErrorDlg::CScriptErrorDlg(CWnd* pParent) : CDialog(CScriptErrorDlg::IDD, pParent) {
  //{{AFX_DATA_INIT(CScriptErrorDlg)
  //}}AFX_DATA_INIT
  m_pError = NULL;
 }
/*===========================================================================
 *		End of Class CScriptErrorDlg Constructor
 *=========================================================================*/


/*===========================================================================
 *
 * Class CScriptErrorDlg Method - void ClearControlData (void);
 *
 * Clears the contents of the controls.
 *
 *=========================================================================*/
void CScriptErrorDlg::ClearControlData (void) {
  m_MsgText.SetWindowText(_T(""));
  m_CodeText.SetWindowText(_T(""));
  m_LocationText.SetWindowText(_T(""));
  m_MsgTypeText.SetWindowText(_T(""));
  m_TokenText.SetWindowText(_T(""));

  ClearFunctionData();
 }
/*===========================================================================
 *		End of Class Method CScriptErrorDlg::ClearControlData()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CScriptErrorDlg Method - void ClearFunctionData (void);
 *
 * Clears the contents of the function controls.
 *
 *=========================================================================*/
void CScriptErrorDlg::ClearFunctionData (void) {
  m_FuncDescText.SetWindowText(_T(""));
  m_FuncFormText.SetWindowText(_T(""));
  m_FuncArgText.SetWindowText(_T(""));
  m_FunctionText.SetWindowText(_T(""));
  m_FuncButton.SetWindowText(_T(""));
 }
/*===========================================================================
 *		End of Class Method CScriptErrorDlg::ClearFunctionData()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CScriptErrorDlg Method - void DoDataExchange (pDX);
 *
 *=========================================================================*/
void CScriptErrorDlg::DoDataExchange(CDataExchange* pDX) {
  CDialog::DoDataExchange(pDX);

  //{{AFX_DATA_MAP(CScriptErrorDlg)
  DDX_Control(pDX, IDC_FUNC_GOTO, m_GotoButton);
  DDX_Control(pDX, IDC_FUNC_BUTTON, m_FuncButton);
  DDX_Control(pDX, IDC_FUNCDESC_TEXT, m_FuncDescText);
  DDX_Control(pDX, IDC_FUNCFORM_TEXT, m_FuncFormText);
  DDX_Control(pDX, IDC_FUNCARG_TEXT, m_FuncArgText);
  DDX_Control(pDX, IDC_FUNCTION_TEXT, m_FunctionText);
  DDX_Control(pDX, IDC_MESSAGE_TEXT, m_MsgText);
  DDX_Control(pDX, IDC_TOKEN_TEXT, m_TokenText);
  DDX_Control(pDX, IDC_LOCATION_TEXT, m_LocationText);
  DDX_Control(pDX, IDC_CODE_TEXT, m_CodeText);
  DDX_Control(pDX, IDC_TYPE_TEXT, m_MsgTypeText);
  //}}AFX_DATA_MAP
 }
/*===========================================================================
 *		End of Class Method CScriptErrorDlg::DoDataExchange()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CScriptErrorDlg Method - void EnableControls (Enable);
 *
 * Enables/disables the form controls.
 *
 *=========================================================================*/
void CScriptErrorDlg::EnableControls (const bool Enable) {
  m_MsgText.EnableWindow(Enable);
  m_CodeText.EnableWindow(Enable);
  m_LocationText.EnableWindow(Enable);
  m_MsgTypeText.EnableWindow(Enable);
  m_TokenText.EnableWindow(Enable);

  EnableFuncCtrls(Enable);
 }
/*===========================================================================
 *		End of Class Method CScriptErrorDlg::EnableControls()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CScriptErrorDlg Method - void EnableFuncCtrls (Enable);
 *
 * Enable/disable the function controls.
 *
 *=========================================================================*/
void CScriptErrorDlg::EnableFuncCtrls (const bool Enable) {
  m_FuncDescText.EnableWindow(Enable);
  m_FuncFormText.EnableWindow(Enable);
  m_FuncArgText.EnableWindow(Enable);
  m_FunctionText.EnableWindow(Enable);
  m_FuncButton.EnableWindow(Enable);
 }
/*===========================================================================
 *		End of Class Method CScriptErrorDlg::EnableFuncCtrls()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CScriptErrorDlg Event - void OnFuncButton ();
 *
 *=========================================================================*/
void CScriptErrorDlg::OnFuncButton() {
  EndDialog(SCRERRDLG_RESULT_MOREHELP);
 }
/*===========================================================================
 *		End of Class Event CScriptErrorDlg::OnFuncButton()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CScriptErrorDlg Event - void OnFuncGoto ();
 *
 *=========================================================================*/
void CScriptErrorDlg::OnFuncGoto() {
  EndDialog(SCRERRDLG_RESULT_GOTO);
 }
/*===========================================================================
 *		End of Class Event CScriptErrorDlg::OnFuncGoto()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CScriptErrorDlg Event - BOOL OnInitDialog ();
 *
 *=========================================================================*/
BOOL CScriptErrorDlg::OnInitDialog() {
  CDialog::OnInitDialog();

  SetControlData();	
  return (TRUE);
 }
/*===========================================================================
 *		End of Class Event CScriptErrorDlg::OnInitDialog()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CScriptErrorDlg Method - void SetControlData (void);
 *
 * Sets the control data from the current error object.
 *
 *=========================================================================*/
void CScriptErrorDlg::SetControlData (void) {
  CString Buffer;

	/* Clear/disable the controls if error object is invalid */
  if (m_pError == NULL) {
    ClearControlData();
    EnableControls(false);
    return;
   }
  else {
    EnableControls(true);
   }

	/* Message controls */
  m_MsgText.SetWindowText(m_pError->GetMessage());
  m_MsgTypeText.SetWindowText(m_pError->GetTypeString());

	/* Error code number */
  Buffer.Format(_T("0x%04X"), m_pError->GetErrorCode());
  m_CodeText.SetWindowText(Buffer);

	/* Location text */
  Buffer.Format(_T("Line %d, Char %d"), m_pError->GetLine(), m_pError->GetCharacter());
  m_LocationText.SetWindowText(Buffer);

	/* Token information */
  Buffer.Format(_T("%s (%s)"), m_pError->GetToken(), GetESMTokenName(m_pError->GetTokenID()));
  m_TokenText.SetWindowText(Buffer);

	/* Set or clear function information as required */
  if (m_pError->GetFunction() == NULL) {
    ClearFunctionData();
    EnableFuncCtrls(false);
   }
  else {
    SetFunctionData();
   }
     
 }
/*===========================================================================
 *		End of Class Method CScriptErrorDlg::SetControlData()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CScriptErrorDlg Method - void SetFunctionData (void);
 *
 *=========================================================================*/
void CScriptErrorDlg::SetFunctionData (void) {
  //DEFINE_FUNCTION("CScriptErrorDlg::SetFunctionData()");
  CString		Buffer;
  esmscrfuncinfo_t*	pFunction = m_pError->GetFunction();
  CEsmScrFuncData*	pFuncData;

	/* Attempt to find the function data record */
  pFuncData = ((CMWEditApp *)AfxGetApp())->GetFunctionArray()->FindFunction(pFunction->Name);

	/* Function name */
  m_FunctionText.SetWindowText(pFunction->Name);

	/* Function argument information */
  if (pFuncData != NULL)
    Buffer.Format(_T("Arg #%d: %s"), m_pError->GetFuncArgIndex()+1, pFuncData->GetParamDesc(m_pError->GetFuncArgIndex()));
  else
    Buffer.Format(_T("Arg #%d: %s"), m_pError->GetFuncArgIndex()+1, m_pError->GetFuncArgString());

  m_FuncArgText.SetWindowText(Buffer);

	/* Function format description */
  if (pFuncData != NULL)
    m_FuncFormText.SetWindowText(pFuncData->GetFuncForm());
  else
    m_FuncFormText.SetWindowText(_T("Unknown"));

	/* Function description */
  if (pFuncData != NULL)
    m_FuncDescText.SetWindowText(pFuncData->GetDescription());
  else
    m_FuncDescText.SetWindowText(_T("Not Available"));
  
 }
/*===========================================================================
 *		End of Class Method CScriptErrorDlg::SetFunctionData()
 *=========================================================================*/

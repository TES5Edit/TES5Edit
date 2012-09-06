/*===========================================================================
 *
 * File:	Esminfodlg.CPP
 * Author:	Dave Humphrey (uesp@m0use.net)
 * Created On:	February 22, 2003
 *
 * Description
 *
 *=========================================================================*/

	/* Include Files */
#include "stdafx.h"
#include "MWEdit.h"
#include "EsmInfoDlg.h"
#include "MWEditDoc.h"
#include "EsmUtils.h"
#include "windows/WinUtil.h"


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

  DEFINE_FILE("EsmInfoDlg.cpp");
/*===========================================================================
 *		End of Local Definitions
 *=========================================================================*/


/*===========================================================================
 *
 * Begin CEsmInfoDlg Message Map
 *
 *=========================================================================*/
BEGIN_MESSAGE_MAP(CEsmInfoDlg, CDialog)
  //{{AFX_MSG_MAP(CEsmInfoDlg)
  ON_CBN_SELCHANGE(IDC_IDLIST, OnSelchangeIdlist)
  ON_CBN_SELCHANGE(IDC_TYPELIST1, OnSelchangeTypelist1)
  ON_CBN_SELCHANGE(IDC_TYPELIST2, OnSelchangeTypelist2)
  ON_CBN_SELCHANGE(IDC_TYPELIST3, OnSelchangeTypelist3)
  ON_CBN_SELCHANGE(IDC_TYPELIST4, OnSelchangeTypelist4)
  ON_CBN_SELCHANGE(IDC_TYPELIST5, OnSelchangeTypelist5)
  ON_CBN_SELCHANGE(IDC_TYPELIST6, OnSelchangeTypelist6)
  ON_BN_CLICKED(IDC_SOUNDBUTTON, OnSoundbutton)
  //}}AFX_MSG_MAP
END_MESSAGE_MAP()
/*===========================================================================
 *		End of CEsmInfoDlg Message Map
 *=========================================================================*/


/*===========================================================================
 *
 * Class CEsmInfoDlg Constructor
 *
 *=========================================================================*/
CEsmInfoDlg::CEsmInfoDlg(CWnd* pParent) : CDialog(CEsmInfoDlg::IDD, pParent) {
  //{{AFX_DATA_INIT(CEsmInfoDlg)
  //}}AFX_DATA_INIT
  m_pInfo = NULL;
  m_IsNew = false;
  m_pDocument = NULL;
  m_AlreadyIsNew = false;
 }
/*===========================================================================
 *		End of Class CEsmInfoDlg Constructor
 *=========================================================================*/


/*===========================================================================
 *
 * Class CEsmInfoDlg Method - void DoDataExchange (pDX);
 *
 *=========================================================================*/
void CEsmInfoDlg::DoDataExchange(CDataExchange* pDX) {
  CDialog::DoDataExchange(pDX);

  //{{AFX_DATA_MAP(CEsmInfoDlg)
  DDX_Control(pDX, IDC_SOUNDBUTTON, m_SoundButton);
  DDX_Control(pDX, IDC_SOUNDLABEL, m_SoundLabel);
  DDX_Control(pDX, IDC_RESULTTEXT, m_ResultText);
  DDX_Control(pDX, IDC_PCRANKLIST, m_PCRankList);
  DDX_Control(pDX, IDC_PCFACTIONLIST, m_PCFactionList);
  DDX_Control(pDX, IDC_CELLLIST, m_CellList);
  DDX_Control(pDX, IDC_RANKLIST, m_RankList);
  DDX_Control(pDX, IDC_FACTIONLIST, m_FactionList);
  DDX_Control(pDX, IDC_CLASSLIST, m_ClassList);
  DDX_Control(pDX, IDC_RACELIST, m_RaceList);
  DDX_Control(pDX, IDC_IDLIST, m_IDList);
  DDX_Control(pDX, IDC_DISPOSITIONTEXT, m_DispText);
  DDX_Control(pDX, IDC_GENDERLIST, m_GenderList);
  DDX_Control(pDX, IDC_NAMETEXT, m_NameText);
  DDX_Control(pDX, IDC_IDTEXT, m_IDText);
  //}}AFX_DATA_MAP

  DDX_Control(pDX, IDC_VALUETEXT1, m_ValueText[0]);
  DDX_Control(pDX, IDC_VALUETEXT2, m_ValueText[1]);
  DDX_Control(pDX, IDC_VALUETEXT3, m_ValueText[2]);
  DDX_Control(pDX, IDC_VALUETEXT4, m_ValueText[3]);
  DDX_Control(pDX, IDC_VALUETEXT5, m_ValueText[4]);
  DDX_Control(pDX, IDC_VALUETEXT6, m_ValueText[5]); 
  DDX_Control(pDX, IDC_COMPARELIST1, m_CompareList[0]);
  DDX_Control(pDX, IDC_COMPARELIST2, m_CompareList[1]);
  DDX_Control(pDX, IDC_COMPARELIST3, m_CompareList[2]);
  DDX_Control(pDX, IDC_COMPARELIST4, m_CompareList[3]);
  DDX_Control(pDX, IDC_COMPARELIST5, m_CompareList[4]);
  DDX_Control(pDX, IDC_COMPARELIST6, m_CompareList[5]);
  DDX_Control(pDX, IDC_VARFUNCLIST1, m_FuncVarList[0]);
  DDX_Control(pDX, IDC_VARFUNCLIST2, m_FuncVarList[1]);
  DDX_Control(pDX, IDC_VARFUNCLIST3, m_FuncVarList[2]);
  DDX_Control(pDX, IDC_VARFUNCLIST4, m_FuncVarList[3]);
  DDX_Control(pDX, IDC_VARFUNCLIST5, m_FuncVarList[4]);
  DDX_Control(pDX, IDC_VARFUNCLIST6, m_FuncVarList[5]);
  DDX_Control(pDX, IDC_TYPELIST1, m_TypeList[0]);
  DDX_Control(pDX, IDC_TYPELIST2, m_TypeList[1]);
  DDX_Control(pDX, IDC_TYPELIST3, m_TypeList[2]);
  DDX_Control(pDX, IDC_TYPELIST4, m_TypeList[3]);
  DDX_Control(pDX, IDC_TYPELIST5, m_TypeList[4]);
  DDX_Control(pDX, IDC_TYPELIST6, m_TypeList[5]);
 }
/*===========================================================================
 *		End of Class Method CEsmInfoDlg::DoDataExchange()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CEsmInfoDlg Method - bool DoModal (pInfo, IsNew, pDocument);
 *
 * Description
 *
 *=========================================================================*/
bool CEsmInfoDlg::DoModal (CEsmInfo* pInfo, const bool IsNew, CMWEditDoc* pDocument) {
  int Result;

	/* Initialize the class members */  
  m_pInfo = pInfo;
  m_IsNew = false;
  m_AlreadyIsNew = IsNew;
  m_pDocument = pDocument;
  if (pInfo == NULL || pDocument == NULL) return (false);

	/* Display the modal window */
  Result = CDialog::DoModal();
  if (Result != IDOK) return (false);
  return (true);
 }
/*===========================================================================
 *		End of Class Method CEsmInfoDlg::DoModal()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CEsmInfoDlg Method - void GetControlData (void);
 *
 *=========================================================================*/
void CEsmInfoDlg::GetControlData (void) {
  DEFINE_FUNCTION("CEsmInfoDlg::GetControlData()");
  CString	Buffer;
  CEsmInfo*	pNewInfo;
  infodata_t*	pInfoData = m_pInfo->GetInfoData();
  int		Index;
  int		FuncIndex = 0;

  	/* Create a new object if required */
  if (!m_AlreadyIsNew) {
    CreatePointer(pNewInfo, CEsmInfo);
    pNewInfo->Copy(m_pInfo);
    pNewInfo->SetDialParent(m_pInfo->GetDialParent());
    m_pInfo = pNewInfo;
    m_pInfo->SetFile(m_pDocument->GetActivePlugin());
    m_IsNew = true;
   }  

	/* Get the main text */
  m_NameText.GetWindowText(Buffer);
  m_pInfo->SetResponse(Buffer);

	/* Result text, if any */
  m_ResultText.GetWindowText(Buffer);
  TrimStringSpace(Buffer);
  m_pInfo->SetResult(Buffer.IsEmpty() ? NULL : (const TCHAR *)Buffer);

	/* Disposition */
  m_DispText.GetWindowText(Buffer);
  pInfoData->Disposition = atoi(Buffer);
  if (pInfoData->Disposition < 0)   pInfoData->Disposition = 0;
  if (pInfoData->Disposition > 100) pInfoData->Disposition = 100;

	/* Gender */
  Index = m_GenderList.GetCurSel();
  pInfoData->Gender = (byte) ((Index < 0) ? 0 : m_GenderList.GetItemData(Index));
  
	/* Ranks */
  Index = m_RankList.GetCurSel();
  pInfoData->Rank = (byte) ((Index < 0) ? -1 : m_RankList.GetItemData(Index));
  Index = m_PCRankList.GetCurSel();
  pInfoData->PCRank = (byte) ((Index < 0) ? -1 : m_PCRankList.GetItemData(Index));
  
	/* Sound button if required */
  if (m_pInfo->GetDialParent() != NULL && m_pInfo->GetDialParent()->GetDialogTypeID() == MWESM_DIALTYPE_VOICE) {
    m_SoundButton.GetWindowText(Buffer);
    m_pInfo->SetSound(Buffer);
   }

	/* ID, race, class, etc... */
  m_IDList.GetWindowText(Buffer);
  m_pInfo->SetActor(Buffer.IsEmpty() ? NULL : (const TCHAR *)Buffer);
  m_RaceList.GetWindowText(Buffer);
  m_pInfo->SetRace(Buffer.IsEmpty() ? NULL : (const TCHAR *)Buffer);
  m_ClassList.GetWindowText(Buffer);
  m_pInfo->SetClass(Buffer.IsEmpty() ? NULL : (const TCHAR *)Buffer);
  m_CellList.GetWindowText(Buffer);
  m_pInfo->SetCell(Buffer.IsEmpty() ? NULL : (const TCHAR *)Buffer);
  m_FactionList.GetWindowText(Buffer);
  m_pInfo->SetFaction(Buffer.IsEmpty() ? NULL : (const TCHAR *)Buffer);
  m_PCFactionList.GetWindowText(Buffer);
  m_pInfo->SetPCFaction(Buffer.IsEmpty() ? NULL : (const TCHAR *)Buffer);

	/* Function data */
  m_pInfo->DeleteSubRecords(MWESM_SUBREC_SCVR);
  m_pInfo->DeleteSubRecords(MWESM_SUBREC_INTV);
  m_pInfo->DeleteSubRecords(MWESM_SUBREC_FLTV);

  for (Index = 0; Index < MWESM_INFO_MAXFUNCS; Index++) {
    GetFuncData(Index, FuncIndex);
   }

 }
/*===========================================================================
 *		End of Class Method CEsmInfoDlg::GetControlData()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CEsmInfoDlg Method - void GetFuncData (Index, const int FuncIndex);
 *
 *=========================================================================*/
void CEsmInfoDlg::GetFuncData (const int Index, int& FuncIndex) {
  infofuncdata_t* pData;
  CEsmSubSCVR*	  pFuncData;
  CEsmSubFloat*   pValueData;
  CString	  Buffer;
  int		  ListIndex;
  int		  NewType;

  ListIndex = m_TypeList[Index].GetCurSel();
  if (Index < 0) return;
  NewType = m_TypeList[Index].GetItemData(ListIndex);
  if (NewType == MWESM_SCVRFUNC_NONE) return;

  pFuncData = (CEsmSubSCVR *) m_pInfo->AllocateSubRecord(MWESM_SUBREC_SCVR);
  pFuncData->CreateNew();
  pData = pFuncData->GetInfoFuncData();

	/* Basic function data */
  ListIndex = m_CompareList[Index].GetCurSel();
  pData->CompareOp = (byte) ((ListIndex < 0) ? MWESM_SCVROP_EQUALS : m_CompareList[Index].GetItemData(ListIndex));
  ListIndex = m_TypeList[Index].GetCurSel();
  pData->Type = (byte) ((ListIndex < 0) ? MWESM_SCVRFUNC_NONE : m_TypeList[Index].GetItemData(ListIndex));
  pData->Index = MWESM_SCVR_INDEX0 + FuncIndex;
  FuncIndex++;
  m_FuncVarList[Index].GetWindowText(Buffer);

  switch (NewType) {
    case MWESM_SCVRFUNC_FUNCTION:
        ListIndex = m_FuncVarList[Index].GetCurSel();
	pData->Function = (short) ((ListIndex < 0) ? MWESM_SCVRFUNCCODE_VARIABLE : m_FuncVarList[Index].GetItemData(ListIndex));
    	break;
    case MWESM_SCVRFUNC_GLOBAL:
	pData->Function = MWESM_SCVRFUNC_GLOBAL;
	TSTRNCPY(pData->Name, Buffer, MWESM_ID_MAXSIZE);
    	break;
    case MWESM_SCVRFUNC_LOCAL:
	pData->Function = MWESM_SCVRFUNC_LOCAL;
	TSTRNCPY(pData->Name, Buffer, MWESM_ID_MAXSIZE);
	break;
    case MWESM_SCVRFUNC_NOTLOCAL:
	pData->Function = MWESM_SCVRFUNC_NOTLOCAL;
	TSTRNCPY(pData->Name, Buffer, MWESM_ID_MAXSIZE);
    	break;
    case MWESM_SCVRFUNC_JOURNAL:
	pData->Function = MWESM_SCVRFUNC_JOURNAL;
	TSTRNCPY(pData->Name, Buffer, MWESM_ID_MAXSIZE);
    	break;
    case MWESM_SCVRFUNC_ITEM:
	pData->Function = MWESM_SCVRFUNC_ITEM;
	TSTRNCPY(pData->Name, Buffer, MWESM_ID_MAXSIZE);
    	break;
    case MWESM_SCVRFUNC_DEAD:
	pData->Function = MWESM_SCVRFUNC_DEAD;
	TSTRNCPY(pData->Name, Buffer, MWESM_ID_MAXSIZE);
	break;
    case MWESM_SCVRFUNC_NOTID:
	pData->Function = MWESM_SCVRFUNC_NOTID;
	TSTRNCPY(pData->Name, Buffer, MWESM_ID_MAXSIZE);
    	break;
    case MWESM_SCVRFUNC_NOTFACTION:
	pData->Function = MWESM_SCVRFUNC_NOTFACTION;
	TSTRNCPY(pData->Name, Buffer, MWESM_ID_MAXSIZE);
    	break;
    case MWESM_SCVRFUNC_NOTCLASS:
	pData->Function = MWESM_SCVRFUNC_NOTCLASS;
	TSTRNCPY(pData->Name, Buffer, MWESM_ID_MAXSIZE);
    	break;
    case MWESM_SCVRFUNC_NOTRACE:
	pData->Function = MWESM_SCVRFUNC_NOTRACE;
	TSTRNCPY(pData->Name, Buffer, MWESM_ID_MAXSIZE);
    	break;
    case MWESM_SCVRFUNC_NOTCELL:
	pData->Function = MWESM_SCVRFUNC_NOTCELL;
	TSTRNCPY(pData->Name, Buffer, MWESM_ID_MAXSIZE);
    	break;
   }
  
  m_ValueText[Index].GetWindowText(Buffer);
  pValueData = (CEsmSubFloat *) m_pInfo->AllocateSubRecord(MWESM_SUBREC_FLTV);	/* Use floats all the time by default */
  pValueData->CreateNew();
  pValueData->SetValue((float)atof(Buffer));
 }
/*===========================================================================
 *		End of Class Method CEsmInfoDlg::GetFuncData()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CEsmInfoDlg Event - void OnCancel ();
 *
 *=========================================================================*/
void CEsmInfoDlg::OnCancel() {
  CDialog::OnCancel();
 }
/*===========================================================================
 *		End of Class Event CEsmInfoDlg::OnCancel()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CEsmInfoDlg Event - BOOL OnInitDialog ();
 *
 *=========================================================================*/
BOOL CEsmInfoDlg::OnInitDialog() {
  int ArrayIndex;

  CDialog::OnInitDialog();

	/* Initilaize the text controls */
  m_NameText.SetLimitText(512);
  m_ResultText.SetLimitText(1024);
  m_ValueText[0].SetLimitText(12);
  m_ValueText[1].SetLimitText(12);
  m_ValueText[2].SetLimitText(12);
  m_ValueText[3].SetLimitText(12);
  m_ValueText[4].SetLimitText(12);
  m_ValueText[5].SetLimitText(12);
  m_DispText.SetLimitText(8);

	/* Enable/disable the sound button */
  if (m_pInfo->GetDialParent() != NULL && m_pInfo->GetDialParent()->GetDialogTypeID() != MWESM_DIALTYPE_VOICE) {
    m_SoundLabel.ShowWindow(SW_HIDE);
    m_SoundButton.ShowWindow(SW_HIDE);
   }

	/* Initialize the various lists */
  FillEsmNpcCombo(m_IDList, true);
  FillEsmGenderCombo(m_GenderList, true);
  FillEsmRaceCombo(m_RaceList, true);
  FillEsmClassCombo(m_ClassList, true);
  FillEsmFactionCombo(m_FactionList, true);
  FillEsmFactionCombo(m_PCFactionList, true);
  FillEsmRankCombo(m_PCRankList, true);
  FillEsmRankCombo(m_RankList, true);
  FillEsmCellCombo(m_CellList, true);

  for (ArrayIndex = 0; ArrayIndex < MWESM_INFO_MAXFUNCS; ArrayIndex ++) {
    FillEsmInfoFuncTypeCombo(m_TypeList[ArrayIndex]);
    FillEsmInfoCompareOpCombo(m_CompareList[ArrayIndex]);
   }

  SetControlData();	
  return (TRUE);
 }
/*===========================================================================
 *		End of Class Event CEsmInfoDlg::OnInitDialog()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CEsmInfoDlg Event - void OnOK ();
 *
 *=========================================================================*/
void CEsmInfoDlg::OnOK() {
  GetControlData();
  CDialog::OnOK();
 }
/*===========================================================================
 *		End of Class Event CEsmInfoDlg::OnOK()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CEsmInfoDlg Event - void OnSelChangeTypeList (Index);
 *
 *=========================================================================*/
void CEsmInfoDlg::OnSelChangeTypeList (const int Index) {
  int ListIndex;
  int NewType = MWESM_SCVRFUNC_NONE;

	/* Get the new type */
  ListIndex = m_TypeList[Index].GetCurSel();
  if (ListIndex >= 0) NewType = m_TypeList[Index].GetItemData(ListIndex);
  
  	/* function/var list */
  switch (NewType) {
    case MWESM_SCVRFUNC_NONE:
        m_FuncVarList[Index].ResetContent();
	m_FuncVarList[Index].EnableWindow(FALSE);
	m_CompareList[Index].EnableWindow(FALSE);
        m_ValueText[Index].EnableWindow(FALSE);
	return;
    case MWESM_SCVRFUNC_FUNCTION:
        FillEsmFunctionCombo(m_FuncVarList[Index]);
	break;
    case MWESM_SCVRFUNC_GLOBAL:
        FillEsmGlobalCombo(m_FuncVarList[Index]);
    	break;
    case MWESM_SCVRFUNC_LOCAL:
    case MWESM_SCVRFUNC_NOTLOCAL:
        FillEsmLocalCombo(m_FuncVarList[Index]);
    	break;
    case MWESM_SCVRFUNC_JOURNAL:
        FillEsmJournalCombo(m_FuncVarList[Index]);
    	break;
    case MWESM_SCVRFUNC_ITEM:
        FillEsmItemCombo(m_FuncVarList[Index]);
    	break;
    case MWESM_SCVRFUNC_DEAD:
    case MWESM_SCVRFUNC_NOTID:
        FillEsmNpcCombo(m_FuncVarList[Index]);
    	break;
    case MWESM_SCVRFUNC_NOTFACTION:
        FillEsmFactionCombo(m_FuncVarList[Index]);
    	break;
    case MWESM_SCVRFUNC_NOTCLASS:
        FillEsmClassCombo(m_FuncVarList[Index]);
    	break;
    case MWESM_SCVRFUNC_NOTRACE:
        FillEsmRaceCombo(m_FuncVarList[Index]);
    	break;
    case MWESM_SCVRFUNC_NOTCELL:
        FillEsmCellCombo(m_FuncVarList[Index]);
    	break;
   }
  
  m_FuncVarList[Index].EnableWindow(TRUE);
  m_CompareList[Index].EnableWindow(TRUE);
  m_ValueText[Index].EnableWindow(TRUE);

  if (m_CompareList[Index].GetCurSel() < 0) m_CompareList[Index].SetCurSel(0);
  if (m_FuncVarList[Index].GetCurSel() < 0) m_FuncVarList[Index].SetCurSel(0);
 }
/*===========================================================================
 *		End of Class Event CEsmInfoDlg::OnSelChangeTypeList()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CEsmInfoDlg Event - void OnSoundbutton ();
 *
 *=========================================================================*/
void CEsmInfoDlg::OnSoundbutton() {
  CString Buffer;
  bool    Result;

  m_SoundButton.GetWindowText(Buffer);
  Result = SelectEsmSound(Buffer, _T("Select Voice File"), this);
  if (Result) m_SoundButton.SetWindowText(Buffer);
 }
/*===========================================================================
 *		End of Class Event CEsmInfoDlg::OnSoundbutton()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CEsmInfoDlg Method - void SetControlData (void);
 *
 *=========================================================================*/
void CEsmInfoDlg::SetControlData (void) {
  CString	  Buffer;
  CEsmSubSCVR*    pFuncData;
  infodata_t*	  pInfoData = m_pInfo->GetInfoData();
  int		  ArrayIndex;
  int		  Index;

	/* Set the info ID and dialog title */
  m_IDText.SetWindowText(m_pInfo->GetID());
  Buffer.Format(_T("%s -- Dialogue Info"), m_pDocument->GetTitle());
  SetWindowText(Buffer);

	/* Name/result text */
  m_NameText.SetWindowText(m_pInfo->GetResponse());
  m_ResultText.SetWindowText(m_pInfo->GetResult());

	/* Disposition */
  Buffer.Format(_T("%d"), m_pInfo->GetDisposition());
  m_DispText.SetWindowText(Buffer);

	/* Lists */
  FindComboListItem(m_GenderList, pInfoData->Gender, true);
  m_IDList.SelectString(-1, m_pInfo->GetActor());
  m_CellList.SelectString(-1, m_pInfo->GetCell());
  m_RaceList.SelectString(-1, m_pInfo->GetRace());
  m_ClassList.SelectString(-1, m_pInfo->GetClass());
  m_FactionList.SelectString(-1, m_pInfo->GetFaction());
  m_PCFactionList.SelectString(-1, m_pInfo->GetPCFaction());
  FindComboListItem(m_RankList, pInfoData->Rank, true);
  FindComboListItem(m_PCRankList, pInfoData->PCRank, true);

  if (m_pInfo->GetActor() != NULL && m_pInfo->GetActor()[0] != NULL_CHAR) {
    m_CellList.EnableWindow(FALSE);
    m_RaceList.EnableWindow(FALSE);
    m_RankList.EnableWindow(FALSE);
    m_ClassList.EnableWindow(FALSE);
    m_FactionList.EnableWindow(FALSE);
    m_GenderList.EnableWindow(FALSE);
   }

  pFuncData = (CEsmSubSCVR *) m_pInfo->FindFirst(MWESM_SUBREC_SCVR, ArrayIndex);

	/* Function data */
  for (Index = 0; Index < MWESM_INFO_MAXFUNCS; Index++) {
    SetFuncData(Index, pFuncData, m_pInfo->GetSubRecord(ArrayIndex+1));
    pFuncData = (CEsmSubSCVR *) m_pInfo->FindNext(MWESM_SUBREC_SCVR, ArrayIndex);
   }

	/* Sound button if required */
  if (m_pInfo->GetDialParent() != NULL && m_pInfo->GetDialParent()->GetDialogTypeID() == MWESM_DIALTYPE_VOICE) {
    m_SoundButton.SetWindowText(m_pInfo->GetSound());
   }
  else {
    m_SoundButton.SetWindowText(_T(""));
   }

 }
/*===========================================================================
 *		End of Class Method CEsmInfoDlg::SetControlData()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CEsmInfoDlg Method - void SetFuncData (Index, pFuncData, pValue);
 *
 *=========================================================================*/
void CEsmInfoDlg::SetFuncData (const int Index, CEsmSubSCVR* pFuncData, CEsmSubRecord* pValue) {
  infofuncdata_t* pData;
  CString	  Buffer;

  if (pFuncData != NULL) pData = pFuncData->GetInfoFuncData();

  if (pFuncData == NULL || pData->Type == MWESM_SCVRFUNC_NONE) {
    m_TypeList[Index].SelectString(-1, _T(""));
    m_FuncVarList[Index].SetCurSel(-1);
    m_FuncVarList[Index].EnableWindow(FALSE);
    m_CompareList[Index].EnableWindow(FALSE);
    m_ValueText[Index].EnableWindow(FALSE);
    return;
   }
 
  pData = pFuncData->GetInfoFuncData();
  FindComboListItem(m_TypeList[Index], pData->Type, true);
  FindComboListItem(m_CompareList[Index], pData->CompareOp, true);
  OnSelChangeTypeList(Index);

  if (pData->Type == MWESM_SCVRFUNC_FUNCTION) {
    m_FuncVarList[Index].SelectString(-1, GetESMInfoFunction(pData->Function));
   }
  else {
    m_FuncVarList[Index].SelectString(-1, pData->Name);
   }

	/* Value */
  if (pValue != NULL && pValue->IsType(MWESM_SUBREC_INTV)) {
    Buffer.Format(_T("%ld"), ((CEsmSubLong *)pValue)->GetValue());
    m_ValueText[Index].SetWindowText(Buffer);
   }
  else if (pValue != NULL && pValue->IsType(MWESM_SUBREC_FLTV)) {
    Buffer.Format(_T("%g"), ((CEsmSubFloat *)pValue)->GetValue());
    m_ValueText[Index].SetWindowText(Buffer);
   }
  else {
    m_ValueText[Index].SetWindowText(_T(""));
   }
  
 }
/*===========================================================================
 *		End of Class Method CEsmInfoDlg::SetFuncData()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CEsmInfoDlg Event - void OnSelchangeIdlist ();
 *
 *=========================================================================*/
void CEsmInfoDlg::OnSelchangeIdlist() {
  CString Buffer;

  m_IDList.GetWindowText(Buffer);

  if (!Buffer.IsEmpty()) {
    m_RaceList.EnableWindow(FALSE);
    m_ClassList.EnableWindow(FALSE);
    m_FactionList.EnableWindow(FALSE);
    m_RankList.EnableWindow(FALSE);
    m_GenderList.EnableWindow(FALSE);
   }
  else { 
    m_RaceList.EnableWindow(TRUE);
    m_ClassList.EnableWindow(TRUE);
    m_FactionList.EnableWindow(TRUE);
    m_RankList.EnableWindow(TRUE);
    m_GenderList.EnableWindow(TRUE);
   }

 }
/*===========================================================================
 *		End of Class Event CEsmInfoDlg::OnSelchangeIdlist()
 *=========================================================================*/


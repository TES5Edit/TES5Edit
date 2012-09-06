/*===========================================================================
 *
 * File:	Esmregiondlg.CPP
 * Author:	Dave Humphrey (uesp@m0use.net)
 * Created On:	February 20, 2003
 *
 * Description
 *
 *=========================================================================*/

	/* Include Files */
#include "stdafx.h"
#include "MWEdit.h"
#include "EsmRegionDlg.h"


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

  DEFINE_FILE("EsmRegionDlg.cpp");
  IMPLEMENT_DYNCREATE(CEsmRegionDlg, CEsmRecDialog);
/*===========================================================================
 *		End of Local Definitions
 *=========================================================================*/


/*===========================================================================
 *
 * Begin Spell Column Data
 *
 *=========================================================================*/
static esmcoldata_t l_SoundColData[] = {
	{  _T("Chance"),	ESM_FIELD_CUSTOM,	LVCFMT_CENTER,	ESMLIST_WIDTH_CHANCE,	ESMLIST_SUBITEM_CHANCE,	NULL }, 
	{  _T("Priority"),	ESM_FIELD_CUSTOM,	LVCFMT_CENTER,	ESMLIST_WIDTH_PRIORITY,	ESMLIST_SUBITEM_PRIORITY }, 
	{  _T("ID"),		ESM_FIELD_ID,		LVCFMT_LEFT,	ESMLIST_WIDTH_ID,	ESMLIST_SUBITEM_ID }, 
	{  _T("Mod"),		ESM_FIELD_CHANGED,	LVCFMT_CENTER,	ESMLIST_WIDTH_CHANGED,	ESMLIST_SUBITEM_CHANGED }, 
	{  _T("Name"),		ESM_FIELD_NAME,		LVCFMT_LEFT,	ESMLIST_WIDTH_NAME,	ESMLIST_SUBITEM_NAME }, 
	{ NULL, 0, 0, 0 }	/* Must be last record */
 };
/*===========================================================================
 *		End of Spell Column Data
 *=========================================================================*/


/*===========================================================================
 *
 * Begin CEsmRegionDlg Message Map
 *
 *=========================================================================*/
BEGIN_MESSAGE_MAP(CEsmRegionDlg, CEsmRecDialog)
  //{{AFX_MSG_MAP(CEsmRegionDlg)
  ON_MESSAGE(ESMLIST_NOTIFY_ONDROP, OnRecordDrop)
  ON_MESSAGE(ESMLIST_NOTIFY_ONKEY, OnRecordKey)
  ON_BN_CLICKED(IDC_COLORBUTTON, OnColorbutton)
  ON_EN_CHANGE(IDC_REDTEXT, OnChangeColor)
  ON_EN_CHANGE(IDC_GREENTEXT, OnChangeColor)
  ON_EN_CHANGE(IDC_BLUETEXT, OnChangeColor)
  ON_NOTIFY(LVN_ENDLABELEDIT, IDC_SOUNDLIST, OnEndlabeleditItemlist)
  //}}AFX_MSG_MAP
END_MESSAGE_MAP()
/*===========================================================================
 *		End of CEsmRegionDlg Message Map
 *=========================================================================*/


/*===========================================================================
 *
 * Class CEsmRegionDlg Constructor
 *
 *=========================================================================*/
CEsmRegionDlg::CEsmRegionDlg() : CEsmRecDialog(CEsmRegionDlg::IDD) {
  //{{AFX_DATA_INIT(CEsmRegionDlg)
  //}}AFX_DATA_INIT
  m_pRegion = NULL;
 }
/*===========================================================================
 *		End of Class CEsmRegionDlg Constructor
 *=========================================================================*/


/*===========================================================================
 *
 * Class CEsmRegionDlg Method - void DoDataExchange (pDX);
 *
 *=========================================================================*/
void CEsmRegionDlg::DoDataExchange(CDataExchange* pDX) {
  CFormView::DoDataExchange(pDX);

  //{{AFX_DATA_MAP(CEsmRegionDlg)
  DDX_Control(pDX, IDC_COLORBOX, m_ColorBox);
  DDX_Control(pDX, IDC_BSPIN, m_BSpin);
  DDX_Control(pDX, IDC_GSPIN, m_GSpin);
  DDX_Control(pDX, IDC_RSPIN, m_RSpin);
  DDX_Control(pDX, IDC_BLUETEXT, m_BlueText);
  DDX_Control(pDX, IDC_GREENTEXT, m_GreenText);
  DDX_Control(pDX, IDC_REDTEXT, m_RedText);
  DDX_Control(pDX, IDC_BLIGHTTEXT, m_BlightText);
  DDX_Control(pDX, IDC_ASHTEXT, m_AshText);
  DDX_Control(pDX, IDC_THUNDERTEXT, m_ThunderText);
  DDX_Control(pDX, IDC_RAINTEXT, m_RainText);
  DDX_Control(pDX, IDC_OVERCASTTEXT, m_OvercastText);
  DDX_Control(pDX, IDC_FOGGYTEXT, m_FoggyText);
  DDX_Control(pDX, IDC_CLOUDYTEXT, m_CloudyText);
  DDX_Control(pDX, IDC_HEIGHTTEXT5, m_ClearText);
  DDX_Control(pDX, IDC_CREATURELIST, m_CreatureList);
  DDX_Control(pDX, IDC_NAMETEXT, m_NameText);
  DDX_Control(pDX, IDC_SOUNDLIST, m_SoundList);
  DDX_Control(pDX, IDC_IDTEXT, m_IDText);
  //}}AFX_DATA_MAP
 }
/*===========================================================================
 *		End of Class Method CEsmRegionDlg::DoDataExchange()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CEsmRegionDlg Method - void GetControlData (void);
 *
 *=========================================================================*/
void CEsmRegionDlg::GetControlData (void) {
  DEFINE_FUNCTION("CEsmRegionDlg::GetControlData()");
  CEsmSubSNAM*   pSoundRec;
  weatherdata_t* pWeatherData;
  CString	 Buffer;  
  int		 Index;
  int		 Red;
  int		 Green;
  int		 Blue;
  
	/* Update the armor pointer and data */
  m_pRegion = (CEsmRegion *) GetRecInfo()->pRecord;
  ASSERT(m_pRegion != NULL);
  pWeatherData = m_pRegion->GetWeatherData();
  if (pWeatherData == NULL) return;
  
	/* Item ID, if changed */
  if (m_IDText.GetModify()) {
    m_IDText.GetWindowText(Buffer);
    m_pRegion->SetID(TrimStringSpace(Buffer));
   }

	/* Item name */
  m_NameText.GetWindowText(Buffer);
  m_pRegion->SetName(TrimStringSpace(Buffer));

	/* Creature name */
  m_CreatureList.GetWindowText(Buffer);
  m_pRegion->SetCreature(Buffer);

	/* Weather data */
  m_ClearText.GetWindowText(Buffer);
  pWeatherData->Clear = (atoi(Buffer) & 0xFF);
  m_CloudyText.GetWindowText(Buffer);
  pWeatherData->Cloudy = (atoi(Buffer) & 0xFF);
  m_FoggyText.GetWindowText(Buffer);
  pWeatherData->Foggy = (atoi(Buffer) & 0xFF);
  m_OvercastText.GetWindowText(Buffer);
  pWeatherData->Overcast = (atoi(Buffer) & 0xFF);
  m_AshText.GetWindowText(Buffer);
  pWeatherData->Ash = (atoi(Buffer) & 0xFF);
  m_BlightText.GetWindowText(Buffer);
  pWeatherData->Blight = (atoi(Buffer) & 0xFF);
  m_RainText.GetWindowText(Buffer);
  pWeatherData->Rain = (atoi(Buffer) & 0xFF);
  m_ThunderText.GetWindowText(Buffer);
  pWeatherData->Thunder = (atoi(Buffer) & 0xFF);

 	/* Color */
  m_RedText.GetWindowText(Buffer);
  Red = atoi(Buffer);
  m_GreenText.GetWindowText(Buffer);
  Green = atoi(Buffer);
  m_BlueText.GetWindowText(Buffer);
  Blue = atoi(Buffer);
  m_pRegion->SetColor(RGB(Red, Green, Blue));
  
	/* Sounds */
  m_pRegion->DeleteSubRecords(MWESM_SUBREC_SNAM);

  for (Index = 0; Index < m_SoundList.GetItemCount(); Index++) {
    pSoundRec = (CEsmSubSNAM *) m_pRegion->AllocateSubRecord(MWESM_SUBREC_SNAM);
    pSoundRec->CreateNew();

    Buffer = m_SoundList.GetItemText(Index, 2);
    pSoundRec->SetName(Buffer);

    Buffer = m_SoundList.GetItemText(Index, 0);
    pSoundRec->SetChance(atoi(Buffer));
   }

 }
/*===========================================================================
 *		End of Class Method CEsmRegionDlg::GetControlData()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CEsmRegionDlg Method - bool IsModified (void);
 *
 *=========================================================================*/
bool CEsmRegionDlg::IsModified (void) {
  if (m_Modified) return (true);

	/* Check edit controls for changes */
  if (m_IDText.GetModify())     m_Modified = true;
  if (m_NameText.GetModify())   m_Modified = true;
  if (m_RedText.GetModify())    m_Modified = true;
  if (m_BlueText.GetModify())   m_Modified = true;
  if (m_GreenText.GetModify())  m_Modified = true;
  
  return (m_Modified);
 }
/*===========================================================================
 *		End of Class Method CEsmRegionDlg::IsModified()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CEsmRegionDlg Event - void OnChangeColor ();
 *
 *=========================================================================*/
void CEsmRegionDlg::OnChangeColor() {
  CString Buffer;
  int     Red;
  int     Green;
  int     Blue;

  if (!::IsWindow(m_RedText.m_hWnd)) return;

  m_RedText.GetWindowText(Buffer);
  Red   = atoi(Buffer);
  if (Red < 0)   Red = 0;
  if (Red > 255) Red = 255;
  m_GreenText.GetWindowText(Buffer);
  Green = atoi(Buffer);
  if (Green < 0)   Green = 0;
  if (Green > 255) Green = 255;
  m_BlueText.GetWindowText(Buffer);
  Blue  = atoi(Buffer);
  if (Blue < 0)   Blue = 0;
  if (Blue > 255) Blue = 255;

  m_ColorBox.SetColor(Red, Green, Blue);
  m_ColorBox.RedrawWindow();
 }
/*===========================================================================
 *		End of Class Event CEsmRegionDlg::OnChangeColor()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CEsmRegionDlg Event - void OnColorbutton ();
 *
 *=========================================================================*/
void CEsmRegionDlg::OnColorbutton() {
  int		Result;
  CString	Buffer;
  int		Red;
  int		Green;
  int		Blue;

  m_RedText.GetWindowText(Buffer);
  Red   = atoi(Buffer);
  if (Red < 0)   Red = 0;
  if (Red > 255) Red = 255;
  m_GreenText.GetWindowText(Buffer);
  Green = atoi(Buffer);
  if (Green < 0)   Green = 0;
  if (Green > 255) Green = 255;
  m_BlueText.GetWindowText(Buffer);
  Blue  = atoi(Buffer);
  if (Blue < 0)   Blue = 0;
  if (Blue > 255) Blue = 255;

	/* Initialize and display the dialog */
  CColorDialog  ColorDlg(RGB(Red, Green, Blue), CC_ANYCOLOR | CC_FULLOPEN, this);
  Result = ColorDlg.DoModal();
  if (Result != IDOK) return;

  Red   = GetRValue(ColorDlg.GetColor());
  Green = GetGValue(ColorDlg.GetColor());
  Blue  = GetBValue(ColorDlg.GetColor());
  Buffer.Format(_T("%d"), Red);
  m_RedText.SetWindowText(Buffer);
  Buffer.Format(_T("%d"), Green);
  m_GreenText.SetWindowText(Buffer);
  Buffer.Format(_T("%d"), Blue);
  m_BlueText.SetWindowText(Buffer);

  m_ColorBox.SetColor(Red, Green, Blue);
 }
/*===========================================================================
 *		End of Class Event CEsmRegionDlg::OnColorbutton()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CEsmRegionDlg Event - void OnEndlabeleditItemlist (pNMHDR, pResult);
 *
 *=========================================================================*/
void CEsmRegionDlg::OnEndlabeleditItemlist (NMHDR* pNMHDR, LRESULT* pResult) {
  LV_DISPINFO*	pDispInfo = (LV_DISPINFO*)pNMHDR;
  CString	Buffer;
  int		Count;

  if (pDispInfo->item.pszText != NULL) {
    Count = atoi(pDispInfo->item.pszText);
    if (Count < 0)   Count = 0;
    if (Count > 100) Count = 100;
    Buffer.Format(_T("%d"), Count);
    m_SoundList.SetItemText(pDispInfo->item.iItem, 0, Buffer);
   }

  *pResult = 0;
 }
/*===========================================================================
 *		End of Class Event CEsmRegionDlg::OnEndlabeleditItemlist()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CEsmRegionDlg Event - void OnInitialUpdate ();
 *
 *=========================================================================*/
void CEsmRegionDlg::OnInitialUpdate() {
  CEsmRecDialog::OnInitialUpdate();
  UpdateTitle(NULL);

	/* Initialize the armor record */
  ASSERT(GetRecInfo() != NULL);
  m_pRegion = (CEsmRegion *) GetRecInfo()->pRecord;

	/* Sound List */
  m_SoundList.OnInitCtrl();
  m_SoundList.SetDlgHandler(m_pParent);
  m_SoundList.SetEnableDrag(true);
  m_SoundList.SetAcceptDrag(true);
  m_SoundList.SetWantKeys(true);
  m_SoundList.InitObjectList(&l_SoundColData[0]);

	/* Initialize the text controls */
  m_IDText.SetLimitText(MWESM_ID_MAXSIZE);
  m_NameText.SetLimitText(MWESM_ID_MAXSIZE);
  m_ThunderText.SetLimitText(8);
  m_RainText.SetLimitText(8);
  m_BlightText.SetLimitText(4);
  m_AshText.SetLimitText(4);
  m_OvercastText.SetLimitText(4);
  m_FoggyText.SetLimitText(4);
  m_ClearText.SetLimitText(4);
  m_CloudyText.SetLimitText(4);
  m_RedText.SetLimitText(4);
  m_BlueText.SetLimitText(4);
  m_GreenText.SetLimitText(4);
  m_RSpin.SetRange32(0, 255);
  m_GSpin.SetRange32(0, 255);
  m_BSpin.SetRange32(0, 255);
   
	/* Fill creature list */
  FillEsmCreatureCombo(m_CreatureList, true, true);

	/* Update the UI data */
  SetControlData();
 }
/*===========================================================================
 *		End of Class Event CEsmRegionDlg::OnInitialUpdate()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CEsmRegionDlg Event - LRESULT OnRecordDrop (lParam, wParam);
 *
 *=========================================================================*/
LRESULT CEsmRegionDlg::OnRecordDrop (LPARAM lParam, LPARAM wParam) {
  CString	Buffer;
  CMWEditDoc*   pSourceDoc = (CMWEditDoc *) lParam;
  esmrecinfo_t* pRecInfo = (esmrecinfo_t *) wParam;
  int		ListIndex;

	/* Ensure we only drag from the current document */
  if (pSourceDoc != GetDocument()) return (0);
  
	/* Can only drag sounds onto the list */
  if (!pRecInfo->pRecord->IsType(MWESM_REC_SOUN)) return (0);
  ListIndex = m_SoundList.FindRecord(pRecInfo);

	/* Add a new sound to the list */
  if (ListIndex < 0) {
    ListIndex = m_SoundList.AddItem(pRecInfo);
    m_SoundList.SetItemText(ListIndex, 0, _T("5"));
    Buffer.Format(_T("%d"), m_SoundList.GetItemCount());
    m_SoundList.SetItemText(ListIndex, 1, Buffer);
   }

  return (0);
 }
/*===========================================================================
 *		End of Class Event CEsmRegionDlg::OnRecordDrop()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CEsmRegionDlg Event - LRESULT OnRecordKey (lParam, wParam);
 *
 *=========================================================================*/
LRESULT CEsmRegionDlg::OnRecordKey (LPARAM lParam, LPARAM wParam) {
  int ListIndex;
  
	/* Delete all currently selected items */  
  if (lParam == VK_DELETE || lParam == VK_BACK) {
    ListIndex = m_SoundList.GetNextItem(-1, LVNI_SELECTED);

    while (ListIndex >= 0) {
      m_SoundList.DeleteItem(ListIndex);
      ListIndex = m_SoundList.GetNextItem(-1, LVNI_SELECTED);
     }
  
		/* Redo the list priorities */
    for (ListIndex = 0; ListIndex < m_SoundList.GetItemCount(); ListIndex++) {
      
     }

    return (1);
   }
  else if (lParam == VK_SUBTRACT || lParam == VK_ADD) {
    CString Buffer;
    int     Count;
    int     AddCount;
    AddCount = (lParam == VK_ADD) ? 1 : -1;
    ListIndex = m_SoundList.GetNextItem(-1, LVNI_SELECTED);

    while (ListIndex >= 0) {
      Buffer = m_SoundList.GetItemText(ListIndex, 0);
      Count = atoi(Buffer);
      Count += AddCount;
      if (Count < 0)   Count = 0;
      if (Count > 100) Count = 100;
      Buffer.Format(_T("%d"), Count);
      m_SoundList.SetItemText(ListIndex, 0, Buffer);
      ListIndex = m_SoundList.GetNextItem(ListIndex, LVNI_SELECTED);
     }
  
    return (1);
   }

  return (0);
 }
/*===========================================================================
 *		End of Class Event CEsmRegionDlg::OnRecordKey()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CEsmRegionDlg Event - int OnUpdateItem (pRecInfo);
 *
 *=========================================================================*/
int CEsmRegionDlg::OnUpdateItem (esmrecinfo_t* pRecInfo) {

  	/* Refill the script list if required */
  if (pRecInfo->pRecord->IsType(MWESM_REC_SOUN)) {
    m_SoundList.UpdateItem(pRecInfo);
   }
  else if (pRecInfo->pRecord->IsType(MWESM_REC_CREA) || pRecInfo->pRecord->IsType(MWESM_REC_LEVC)) {
    esmrecinfo_t* pRecInfo = NULL;
    int	  	  Index;

    Index = m_CreatureList.GetCurSel();
    if (Index >= 0) pRecInfo = (esmrecinfo_t *) m_CreatureList.GetItemData(Index);
    FillEsmCreatureCombo(m_CreatureList, true, true);
    FindComboListItem(m_CreatureList, (DWORD) pRecInfo, true);
   }

  return (0);
 }
/*===========================================================================
 *		End of Class Event CEsmRegionDlg::OnUpdateItem()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CEsmRegionDlg Method - void SetControlData (void);
 *
 *=========================================================================*/
void CEsmRegionDlg::SetControlData (void) {
  CEsmSubSNAM*   pSoundRec;
  esmrecinfo_t*  pRecInfo;
  CString	 Buffer;
  weatherdata_t* pWeatherData;
  int		 Index;
  int		 ArrayIndex;
  int		 ListIndex;
  int		 Color;

	/* Ignore if the current item is not valid */
  if (m_pRegion == NULL) return;
  pWeatherData = m_pRegion->GetWeatherData();
  if (pWeatherData == NULL) return;

	/* Item ID, update title as well */
  m_IDText.SetWindowText(m_pRegion->GetID());
  UpdateTitle(m_pRegion->GetID());
  m_IDText.SetModify(FALSE);

	/* Item name */
  m_NameText.SetWindowText(m_pRegion->GetName());
  m_NameText.SetModify(FALSE);

	/* Lists */
  m_CreatureList.SelectString(-1, m_pRegion->GetCreature());
  
	/* Colors */
  Color = m_pRegion->GetColor();
  Buffer.Format(_T("%d"), GetRValue(Color));
  m_RedText.SetWindowText(Buffer);
  Buffer.Format(_T("%d"), GetGValue(Color));
  m_GreenText.SetWindowText(Buffer);
  Buffer.Format(_T("%d"), GetBValue(Color));
  m_BlueText.SetWindowText(Buffer);

	/* Weather */
  Buffer.Format(_T("%d"), (int) pWeatherData->Ash);
  m_AshText.SetWindowText(Buffer);
  Buffer.Format(_T("%d"), (int) pWeatherData->Thunder);
  m_ThunderText.SetWindowText(Buffer);
  Buffer.Format(_T("%d"), (int) pWeatherData->Rain);
  m_RainText.SetWindowText(Buffer);
  Buffer.Format(_T("%d"), (int) pWeatherData->Blight);
  m_BlightText.SetWindowText(Buffer);
  Buffer.Format(_T("%d"), (int) pWeatherData->Clear);
  m_ClearText.SetWindowText(Buffer);
  Buffer.Format(_T("%d"), (int) pWeatherData->Cloudy);
  m_CloudyText.SetWindowText(Buffer);
  Buffer.Format(_T("%d"), (int) pWeatherData->Overcast);
  m_OvercastText.SetWindowText(Buffer);
  Buffer.Format(_T("%d"), (int) pWeatherData->Foggy);
  m_FoggyText.SetWindowText(Buffer);
  
	/* Sounds */
  pSoundRec = (CEsmSubSNAM *) m_pRegion->FindFirst(MWESM_SUBREC_SNAM, ArrayIndex);
  Index = 1;

  while (pSoundRec != NULL) {
    pRecInfo = GetDocument()->FindRecord(pSoundRec->GetName());

    if (pRecInfo != NULL) {
      ListIndex = m_SoundList.AddItem(pRecInfo);
      Buffer.Format(_T("%d"), pSoundRec->GetChance());
      m_SoundList.SetItemText(ListIndex, 0, Buffer);
      Buffer.Format(_T("%d"), Index);
      m_SoundList.SetItemText(ListIndex, 1, Buffer);
      Index++;
     }

    pSoundRec = (CEsmSubSNAM *) m_pRegion->FindNext(MWESM_SUBREC_SNAM, ArrayIndex);
   }
  
 }
/*===========================================================================
 *		End of Class Method CEsmRegionDlg::SetControlData()
 *=========================================================================*/

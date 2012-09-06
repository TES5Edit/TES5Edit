/*===========================================================================
 *
 * File:	Outputview.CPP
 * Author:	Dave Humphrey (uesp@m0use.net)
 * Created On:	May 22, 2003
 *
 * Description
 *
 *=========================================================================*/

	/* Include Files */
#include "stdafx.h"
#include "MWRandItem.h"
#include "OutputView.h"
#include "MWRandItemDlg.h"


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

  DEFINE_FILE("OutputView.cpp");
  IMPLEMENT_DYNCREATE(COutputView, CPropertyPage);
/*===========================================================================
 *		End of Local Definitions
 *=========================================================================*/


/*===========================================================================
 *
 * Begin Item List Display Data Array
 *
 *=========================================================================*/
static esmcoldata_t l_ItemColData[] = {
	{  _T("ID"),		ESM_FIELD_ID,		LVCFMT_LEFT,	ESMLIST_WIDTH_ID,	ESMLIST_SUBITEM_ID, NULL }, 
	{  _T("Type"),		ESM_FIELD_ITEMTYPE,	LVCFMT_LEFT,	ESMLIST_WIDTH_ITEMTYPE,	ESMLIST_SUBITEM_ITEMTYPE }, 
	{  _T("Name"),		ESM_FIELD_NAME,		LVCFMT_LEFT,	ESMLIST_WIDTH_NAME,	ESMLIST_SUBITEM_NAME }, 
	{  _T("SubType"),	ESM_FIELD_TYPE,		LVCFMT_CENTER,	ESMLIST_WIDTH_TYPE,	ESMLIST_SUBITEM_TYPE }, 
	{  _T("Level"),		ESM_FIELD_USERDATA,	LVCFMT_CENTER,	ESMLIST_WIDTH_USERDATA,	ESMLIST_SUBITEM_USERDATA }, 
	{  _T("Weight"),	ESM_FIELD_WEIGHT,	LVCFMT_CENTER,	ESMLIST_WIDTH_WEIGHT,	ESMLIST_SUBITEM_WEIGHT },
	{  _T("Health"),	ESM_FIELD_HEALTH,	LVCFMT_CENTER,	ESMLIST_WIDTH_HEALTH,	ESMLIST_SUBITEM_HEALTH },
	{  _T("Value"),		ESM_FIELD_VALUE,	LVCFMT_CENTER,	ESMLIST_WIDTH_VALUE,	ESMLIST_SUBITEM_VALUE },
	{  _T("Enchantment"),	ESM_FIELD_ENCHANT,	LVCFMT_CENTER,	ESMLIST_WIDTH_ENCHANT,	ESMLIST_SUBITEM_ENCHANT },
	{  _T("Enchant Pts"),	ESM_FIELD_ENCHANTPTS,	LVCFMT_CENTER,	ESMLIST_WIDTH_ENCHANTPTS,ESMLIST_SUBITEM_ENCHANTPTS },
	{  _T("Speed"),		ESM_FIELD_SPEED,	LVCFMT_CENTER,	ESMLIST_WIDTH_SPEED,	ESMLIST_SUBITEM_SPEED }, 
	{  _T("Reach"),		ESM_FIELD_REACH,	LVCFMT_CENTER,	ESMLIST_WIDTH_REACH,	ESMLIST_SUBITEM_REACH }, 
	{  _T("Chop Min"),	ESM_FIELD_CHOPMIN,	LVCFMT_CENTER,	ESMLIST_WIDTH_CHOPMIN,	ESMLIST_SUBITEM_CHOPMIN },
	{  _T("Chop Max"),	ESM_FIELD_CHOPMAX,	LVCFMT_CENTER,	ESMLIST_WIDTH_CHOPMAX,	ESMLIST_SUBITEM_CHOPMAX },
	{  _T("Slash Min"),	ESM_FIELD_SLASHMIN,	LVCFMT_CENTER,	ESMLIST_WIDTH_SLASHMIN,	ESMLIST_SUBITEM_SLASHMIN },
	{  _T("Slash Max"),	ESM_FIELD_SLASHMAX,	LVCFMT_CENTER,	ESMLIST_WIDTH_SLASHMAX,	ESMLIST_SUBITEM_SLASHMAX },
	{  _T("Thrust Min"),	ESM_FIELD_THRUSTMIN,	LVCFMT_CENTER,	ESMLIST_WIDTH_THRUSTMIN,ESMLIST_SUBITEM_THRUSTMIN },
	{  _T("Thrust Max"),	ESM_FIELD_THRUSTMAX,	LVCFMT_CENTER,	ESMLIST_WIDTH_THRUSTMAX,ESMLIST_SUBITEM_THRUSTMAX },
	{  _T("Ignore Resist"),	ESM_FIELD_IGNORERESIST,	LVCFMT_CENTER,	ESMLIST_WIDTH_IGNORERESIST,ESMLIST_SUBITEM_IGNORERESIST }, 
	{  _T("Inventory"),	ESM_FIELD_ICON,		LVCFMT_LEFT,	ESMLIST_WIDTH_INVENTORY,ESMLIST_SUBITEM_INVENTORY }, 
	{  _T("Model"),		ESM_FIELD_MODEL,	LVCFMT_LEFT,	ESMLIST_WIDTH_MODEL,	ESMLIST_SUBITEM_MODEL }, 
	{ NULL, 0, 0, 0 }	/* Must be last record */
 };
/*===========================================================================
 *		End of Item List Display Data Array
 *=========================================================================*/


/*===========================================================================
 *
 * Begin COutputView Message Map
 *
 *=========================================================================*/
BEGIN_MESSAGE_MAP(COutputView, CPropertyPage)
  //{{AFX_MSG_MAP(COutputView)
  ON_WM_SIZE()
  //}}AFX_MSG_MAP
END_MESSAGE_MAP()
/*===========================================================================
 *		End of COutputView Message Map
 *=========================================================================*/


/*===========================================================================
 *
 * Class COutputView Constructor
 *
 *=========================================================================*/
COutputView::COutputView() : CPropertyPage(COutputView::IDD) {
  //{{AFX_DATA_INIT(COutputView)
  //}}AFX_DATA_INIT
  m_pParentDlg = NULL;
 }
/*===========================================================================
 *		End of Class COutputView Constructor
 *=========================================================================*/


/*===========================================================================
 *
 * Class COutputView Destructor
 *
 *=========================================================================*/
COutputView::~COutputView() {
 }
/*===========================================================================
 *		End of Class COutputView Destructor
 *=========================================================================*/


/*===========================================================================
 *
 * Class COutputView Method - void DoDataExchange (pDX);
 *
 *=========================================================================*/
void COutputView::DoDataExchange(CDataExchange* pDX) {
  CPropertyPage::DoDataExchange(pDX);
  //{{AFX_DATA_MAP(COutputView)
  DDX_Control(pDX, IDC_ITEM_LIST, m_ItemList);
  //}}AFX_DATA_MAP
 }
/*===========================================================================
 *		End of Class Method COutputView::DoDataExchange()
 *=========================================================================*/


/*===========================================================================
 *
 * Class COutputView Event - BOOL OnInitDialog ();
 *
 *=========================================================================*/
BOOL COutputView::OnInitDialog() {
  CPropertyPage::OnInitDialog();

	/* Initialize the list control */
  m_ItemList.OnInitCtrl();
  m_ItemList.InitObjectList(l_ItemColData);
  m_ItemList.SetWantKeys(false);
  m_ItemList.SetAcceptDrag(false);
  m_ItemList.SetEnableDrag(false);
	
  return (TRUE);
 }
/*===========================================================================
 *		End of Class Event COutputView::OnInitDialog()
 *=========================================================================*/


/*===========================================================================
 *
 * Class COutputView Event - void OnSize (nType, cx, cy);
 *
 *=========================================================================*/
void COutputView::OnSize(UINT nType, int cx, int cy) {
  int ListWidth;
  int ListHeight;

	/* Resize the form */
  CPropertyPage::OnSize(nType, cx, cy);

	/* Adjust the size of the list if required */
  if (nType != SW_MINIMIZE && IsWindow(m_ItemList.m_hWnd)) {
    ListWidth  = cx - OUTPUTVIEW_LIST_XOFFSET;
    ListHeight = cy - OUTPUTVIEW_LIST_YOFFSET;
    if (ListWidth  < OUTPUTVIEW_LIST_MINWIDTH)  ListWidth  = OUTPUTVIEW_LIST_MINWIDTH;
    if (ListHeight < OUTPUTVIEW_LIST_MINHEIGHT) ListHeight = OUTPUTVIEW_LIST_MINHEIGHT;

    m_ItemList.SetWindowPos(NULL, 0, 0, ListWidth, ListHeight, SWP_NOMOVE | SWP_NOZORDER);
   }

 }
/*===========================================================================
 *		End of Class Event COutputView::OnSize()
 *=========================================================================*/

 
/*===========================================================================
 *
 * Class COutputView Method - void UpdateList (void);
 *
 * Updates the item list from the ESM file records.
 *
 *=========================================================================*/
void COutputView::UpdateList (void) {
  esmrecinfo_t* pRecInfo;
  int		Index;

	/* Ignore if invalid object state */
  if (m_pParentDlg == NULL) return;
  m_ItemList.DeleteAllItems();

	/* Output all valid records in file */
  for (Index = 0; Index < m_pParentDlg->GetRecInfo()->GetNumElements(); Index++) {
    pRecInfo = m_pParentDlg->GetRecInfo()->GetAt(Index);
    if (pRecInfo->pRecord->IsType(MWESM_REC_TES3)) continue;
    m_ItemList.AddItem(pRecInfo);
   }

 }
/*===========================================================================
 *		End of Class Method COutputView::UpdateList()
 *=========================================================================*/
  
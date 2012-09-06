// EnchantView.cpp : implementation file
//

#include "stdafx.h"
#include "MWRandItem.h"
#include "EnchantView.h"

#ifdef _DEBUG
#define new DEBUG_NEW
#undef THIS_FILE
static char THIS_FILE[] = __FILE__;
#endif

/////////////////////////////////////////////////////////////////////////////
// CEnchantView property page

IMPLEMENT_DYNCREATE(CEnchantView, CPropertyPage)

CEnchantView::CEnchantView() : CPropertyPage(CEnchantView::IDD)
{
	//{{AFX_DATA_INIT(CEnchantView)
		// NOTE: the ClassWizard will add member initialization here
	//}}AFX_DATA_INIT
	m_pParentDlg = NULL;
}

CEnchantView::~CEnchantView()
{
}

void CEnchantView::DoDataExchange(CDataExchange* pDX)
{
	CPropertyPage::DoDataExchange(pDX);
	//{{AFX_DATA_MAP(CEnchantView)
		// NOTE: the ClassWizard will add DDX and DDV calls here
	//}}AFX_DATA_MAP
}


BEGIN_MESSAGE_MAP(CEnchantView, CPropertyPage)
	//{{AFX_MSG_MAP(CEnchantView)
		// NOTE: the ClassWizard will add message map macros here
	//}}AFX_MSG_MAP
END_MESSAGE_MAP()

/////////////////////////////////////////////////////////////////////////////
// CEnchantView message handlers

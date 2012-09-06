// CreaturePage2.cpp : implementation file
//

#include "stdafx.h"
#include "MWEdit.h"
#include "CreaturePage2.h"

#ifdef _DEBUG
#define new DEBUG_NEW
#undef THIS_FILE
static char THIS_FILE[] = __FILE__;
#endif

DEFINE_FILE("CreaturePage2.cpp");
/////////////////////////////////////////////////////////////////////////////
// CCreaturePage2 property page

IMPLEMENT_DYNCREATE(CCreaturePage2, CPropertyPage)

CCreaturePage2::CCreaturePage2() : CPropertyPage(CCreaturePage2::IDD)
{
	//{{AFX_DATA_INIT(CCreaturePage2)
		// NOTE: the ClassWizard will add member initialization here
	//}}AFX_DATA_INIT
}

CCreaturePage2::~CCreaturePage2()
{
}

void CCreaturePage2::DoDataExchange(CDataExchange* pDX)
{
	CPropertyPage::DoDataExchange(pDX);
	//{{AFX_DATA_MAP(CCreaturePage2)
		// NOTE: the ClassWizard will add DDX and DDV calls here
	//}}AFX_DATA_MAP
}


BEGIN_MESSAGE_MAP(CCreaturePage2, CPropertyPage)
	//{{AFX_MSG_MAP(CCreaturePage2)
		// NOTE: the ClassWizard will add message map macros here
	//}}AFX_MSG_MAP
END_MESSAGE_MAP()

/////////////////////////////////////////////////////////////////////////////
// CCreaturePage2 message handlers

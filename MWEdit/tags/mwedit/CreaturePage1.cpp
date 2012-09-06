// CreaturePage1.cpp : implementation file
//

#include "stdafx.h"
#include "MWEdit.h"
#include "CreaturePage1.h"

#ifdef _DEBUG
#define new DEBUG_NEW
#undef THIS_FILE
static char THIS_FILE[] = __FILE__;
#endif

DEFINE_FILE("CreaturePage1.cpp");

/////////////////////////////////////////////////////////////////////////////
// CCreaturePage1 property page

IMPLEMENT_DYNCREATE(CCreaturePage1, CPropertyPage)

CCreaturePage1::CCreaturePage1() : CPropertyPage(CCreaturePage1::IDD)
{
	//{{AFX_DATA_INIT(CCreaturePage1)
		// NOTE: the ClassWizard will add member initialization here
	//}}AFX_DATA_INIT
}

CCreaturePage1::~CCreaturePage1()
{
}

void CCreaturePage1::DoDataExchange(CDataExchange* pDX)
{
	CPropertyPage::DoDataExchange(pDX);
	//{{AFX_DATA_MAP(CCreaturePage1)
		// NOTE: the ClassWizard will add DDX and DDV calls here
	//}}AFX_DATA_MAP
}


BEGIN_MESSAGE_MAP(CCreaturePage1, CPropertyPage)
	//{{AFX_MSG_MAP(CCreaturePage1)
		// NOTE: the ClassWizard will add message map macros here
	//}}AFX_MSG_MAP
END_MESSAGE_MAP()

/////////////////////////////////////////////////////////////////////////////
// CCreaturePage1 message handlers

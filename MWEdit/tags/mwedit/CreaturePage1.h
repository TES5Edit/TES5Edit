#if !defined(AFX_CREATUREPAGE1_H__F7B7A9FE_9FF3_42A8_B7EC_CE28412815ED__INCLUDED_)
#define AFX_CREATUREPAGE1_H__F7B7A9FE_9FF3_42A8_B7EC_CE28412815ED__INCLUDED_

#if _MSC_VER > 1000
#pragma once
#endif // _MSC_VER > 1000
// CreaturePage1.h : header file
//

/////////////////////////////////////////////////////////////////////////////
// CCreaturePage1 dialog

class CCreaturePage1 : public CPropertyPage
{
	DECLARE_DYNCREATE(CCreaturePage1)

// Construction
public:
	CCreaturePage1();
	~CCreaturePage1();

// Dialog Data
	//{{AFX_DATA(CCreaturePage1)
	enum { IDD = IDD_CREATURE1_VIEW };
		// NOTE - ClassWizard will add data members here.
		//    DO NOT EDIT what you see in these blocks of generated code !
	//}}AFX_DATA


// Overrides
	// ClassWizard generate virtual function overrides
	//{{AFX_VIRTUAL(CCreaturePage1)
	protected:
	virtual void DoDataExchange(CDataExchange* pDX);    // DDX/DDV support
	//}}AFX_VIRTUAL

// Implementation
protected:
	// Generated message map functions
	//{{AFX_MSG(CCreaturePage1)
		// NOTE: the ClassWizard will add member functions here
	//}}AFX_MSG
	DECLARE_MESSAGE_MAP()

};

//{{AFX_INSERT_LOCATION}}
// Microsoft Visual C++ will insert additional declarations immediately before the previous line.

#endif // !defined(AFX_CREATUREPAGE1_H__F7B7A9FE_9FF3_42A8_B7EC_CE28412815ED__INCLUDED_)

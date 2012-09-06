#if !defined(AFX_CREATUREPAGE2_H__42E40900_2288_4B4B_9455_B50910970AD6__INCLUDED_)
#define AFX_CREATUREPAGE2_H__42E40900_2288_4B4B_9455_B50910970AD6__INCLUDED_

#if _MSC_VER > 1000
#pragma once
#endif // _MSC_VER > 1000
// CreaturePage2.h : header file
//

/////////////////////////////////////////////////////////////////////////////
// CCreaturePage2 dialog

class CCreaturePage2 : public CPropertyPage
{
	DECLARE_DYNCREATE(CCreaturePage2)

// Construction
public:
	CCreaturePage2();
	~CCreaturePage2();

// Dialog Data
	//{{AFX_DATA(CCreaturePage2)
	enum { IDD = IDD_CREATURE2_VIEW };
		// NOTE - ClassWizard will add data members here.
		//    DO NOT EDIT what you see in these blocks of generated code !
	//}}AFX_DATA


// Overrides
	// ClassWizard generate virtual function overrides
	//{{AFX_VIRTUAL(CCreaturePage2)
	protected:
	virtual void DoDataExchange(CDataExchange* pDX);    // DDX/DDV support
	//}}AFX_VIRTUAL

// Implementation
protected:
	// Generated message map functions
	//{{AFX_MSG(CCreaturePage2)
		// NOTE: the ClassWizard will add member functions here
	//}}AFX_MSG
	DECLARE_MESSAGE_MAP()

};

//{{AFX_INSERT_LOCATION}}
// Microsoft Visual C++ will insert additional declarations immediately before the previous line.

#endif // !defined(AFX_CREATUREPAGE2_H__42E40900_2288_4B4B_9455_B50910970AD6__INCLUDED_)

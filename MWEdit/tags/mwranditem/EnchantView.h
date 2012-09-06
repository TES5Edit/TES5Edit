#if !defined(AFX_ENCHANTVIEW_H__D5F72642_F566_49C6_B80C_529196B977F3__INCLUDED_)
#define AFX_ENCHANTVIEW_H__D5F72642_F566_49C6_B80C_529196B977F3__INCLUDED_

#if _MSC_VER > 1000
#pragma once
#endif // _MSC_VER > 1000
// EnchantView.h : header file
//

/////////////////////////////////////////////////////////////////////////////
// CEnchantView dialog

class CMWRandItemDlg;

class CEnchantView : public CPropertyPage
{
	DECLARE_DYNCREATE(CEnchantView)

  CMWRandItemDlg*	m_pParentDlg;

// Construction
public:
	CEnchantView();
	~CEnchantView();

	/* Set class members */
  void SetParentDlg (CMWRandItemDlg* pParent) { m_pParentDlg = pParent; }

// Dialog Data
	//{{AFX_DATA(CEnchantView)
	enum { IDD = IDD_ENCHANT_VIEW };
		// NOTE - ClassWizard will add data members here.
		//    DO NOT EDIT what you see in these blocks of generated code !
	//}}AFX_DATA


// Overrides
	// ClassWizard generate virtual function overrides
	//{{AFX_VIRTUAL(CEnchantView)
	protected:
	virtual void DoDataExchange(CDataExchange* pDX);    // DDX/DDV support
	//}}AFX_VIRTUAL

// Implementation
protected:
	// Generated message map functions
	//{{AFX_MSG(CEnchantView)
		// NOTE: the ClassWizard will add member functions here
	//}}AFX_MSG
	DECLARE_MESSAGE_MAP()

};

//{{AFX_INSERT_LOCATION}}
// Microsoft Visual C++ will insert additional declarations immediately before the previous line.

#endif // !defined(AFX_ENCHANTVIEW_H__D5F72642_F566_49C6_B80C_529196B977F3__INCLUDED_)

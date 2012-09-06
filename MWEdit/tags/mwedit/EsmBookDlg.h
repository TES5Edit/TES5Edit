/*===========================================================================
 *
 * File:	Esmbookdlg.H
 * Author:	Dave Humphrey (uesp@m0use.net)
 * Created On:	February 14, 2003
 *
 * Description
 *
 *=========================================================================*/
#ifndef __ESMBOOKDLG_H
#define __ESMBOOKDLG_H


/*===========================================================================
 *
 * Begin Required Includes
 *
 *=========================================================================*/
  #include "EsmRecDialog.h"
  #include "Resource.h"
/*===========================================================================
 *		End of Required Includes
 *=========================================================================*/


/*===========================================================================
 *
 * Begin Class CEsmBookDlg Definition
 *
 *=========================================================================*/
class CEsmBookDlg : public CEsmRecDialog {
  DECLARE_DYNCREATE(CEsmBookDlg);

  /*---------- Begin Protected Class Members ------------------------*/
protected:
  CEsmBook*	m_pBook;


  /*---------- Begin Protected Class Methods ------------------------*/
protected:

	/* Update item data */
  virtual int OnUpdateItem (esmrecinfo_t* pRecInfo);


  /*---------- Begin Public Class Methods ---------------------------*/
public:

	/* Construction */
  CEsmBookDlg();

	/* Get class members */
  virtual bool IsModified (void);
  
  	/* Set or update the record data */
  virtual void GetControlData (void);
  virtual void SetControlData (void);
	
	/* Dialog Data */
  //{{AFX_DATA(CEsmBookDlg)
  enum { IDD = IDD_BOOK_DLG };
  CButton	m_PersistCheck;
  CButton	m_BlockedCheck;
  CButton	m_ScrollCheck;
  CEdit		m_EnchantText;
  CEdit		m_BookText;
  CComboBox	m_EnchantList;
  CComboBox	m_SkillList;
  CEdit		m_ValueText;
  CEdit		m_WeightText;
  CEdit		m_NameText;
  //}}AFX_DATA

	/* ClassWizard generated virtual function overrides */
  //{{AFX_VIRTUAL(CEsmBookDlg)
protected:
  virtual void OnInitialUpdate();
  virtual void DoDataExchange(CDataExchange* pDX);
  //}}AFX_VIRTUAL

protected:

	/* Generated message map functions */
  //{{AFX_MSG(CEsmBookDlg)
	afx_msg void OnEnchantedit();
	//}}AFX_MSG
  
  DECLARE_MESSAGE_MAP();

 };
/*===========================================================================
 *		End of Class CEsmBookDlg Definition
 *=========================================================================*/


//{{AFX_INSERT_LOCATION}}
//}}AFX_INSERT_LOCATION


#endif
/*===========================================================================
 *		End of File Esmbookdlg.H
 *=========================================================================*/

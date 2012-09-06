/*===========================================================================
 *
 * File:	Esmmiscdlg.H
 * Author:	Dave Humphrey (uesp@m0use.net)
 * Created On:	February 16, 2003
 *
 * Description
 *
 *=========================================================================*/
#ifndef __ESMMISCDLG_H
#define __ESMMISCDLG_H


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
 * Begin Class CEsmMiscDlg Definition
 *
 *=========================================================================*/
class CEsmMiscDlg : public CEsmRecDialog {
  DECLARE_DYNCREATE(CEsmMiscDlg);

  /*---------- Begin Protected Class Members ------------------------*/
protected:
  CEsmMisc*	m_pMisc;


  /*---------- Begin Protected Class Methods ------------------------*/
protected:

	/* Update item data */
  virtual int OnUpdateItem (esmrecinfo_t* pRecInfo);


  /*---------- Begin Public Class Methods ---------------------------*/
public:

	/* Construction */
  CEsmMiscDlg();

	/* Get class members */
  virtual bool IsModified (void);
  
  	/* Set or update the record data */
  virtual void GetControlData (void);
  virtual void SetControlData (void);
	
	/* Dialog Data */
  //{{AFX_DATA(CEsmMiscDlg)
  enum { IDD = IDD_MISC_DLG };
  CButton	m_PersistCheck;
  CButton	m_BlockedCheck;
  CEdit		m_ValueText;
  CEdit		m_WeightText;
  CEdit		m_NameText;
  //}}AFX_DATA

	/* ClassWizard generated virtual function overrides */
  //{{AFX_VIRTUAL(CEsmMiscDlg)
protected:
  virtual void OnInitialUpdate();
  virtual void DoDataExchange(CDataExchange* pDX);
  //}}AFX_VIRTUAL

protected:

	/* Generated message map functions */
  //{{AFX_MSG(CEsmMiscDlg)
  //}}AFX_MSG
  
  DECLARE_MESSAGE_MAP();

 };
/*===========================================================================
 *		End of Class CEsmMiscDlg Definition
 *=========================================================================*/


//{{AFX_INSERT_LOCATION}}
//}}AFX_INSERT_LOCATION


#endif
/*===========================================================================
 *		End of File Esmmiscdlg.H
 *=========================================================================*/

/*===========================================================================
 *
 * File:	Esmstaticdlg.H
 * Author:	Dave Humphrey (uesp@m0use.net)
 * Created On:	February 16, 2003
 *
 * Description
 *
 *=========================================================================*/
#ifndef __ESMSTATICDLG_H
#define __ESMSTATICDLG_H


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
 * Begin Class CEsmStaticDlg Definition
 *
 *=========================================================================*/
class CEsmStaticDlg : public CEsmRecDialog {
  DECLARE_DYNCREATE(CEsmStaticDlg);

  /*---------- Begin Protected Class Members ------------------------*/
protected:
  CEsmStatic*	m_pStatic;


  /*---------- Begin Protected Class Methods ------------------------*/
protected:

	/* Update item data */
  virtual int OnUpdateItem (esmrecinfo_t* pRecInfo);


  /*---------- Begin Public Class Methods ---------------------------*/
public:

	/* Construction */
  CEsmStaticDlg();

  	/* Get class members */
  virtual bool IsModified (void);
	
  	/* Set or update the record data */
  virtual void GetControlData (void);
  virtual void SetControlData (void);

	/* Dialog Data */
  //{{AFX_DATA(CEsmStaticDlg)
  enum { IDD = IDD_STATIC_DLG };
  CButton	m_PersistCheck;
  CButton	m_BlockedCheck;
  //}}AFX_DATA

	/* ClassWizard generated virtual function overrides */
  //{{AFX_VIRTUAL(CEsmStaticDlg)
protected:
  virtual void OnInitialUpdate();
  virtual void DoDataExchange(CDataExchange* pDX);
  //}}AFX_VIRTUAL

protected:

	/* Generated message map functions */
  //{{AFX_MSG(CEsmStaticDlg)
  //}}AFX_MSG
 
  DECLARE_MESSAGE_MAP();

 };
/*===========================================================================
 *		End of Class CEsmStaticDlg Definition
 *=========================================================================*/


//{{AFX_INSERT_LOCATION}}
//}}AFX_INSERT_LOCATION


#endif
/*===========================================================================
 *		End of File Esmstaticdlg.H
 *=========================================================================*/

/*===========================================================================
 *
 * File:	Esmbirthsigndlg.H
 * Author:	Dave Humphrey (uesp@m0use.net)
 * Created On:	February 19, 2003
 *
 * Description
 *
 *=========================================================================*/
#ifndef __ESMBIRTHSIGNDLG_H
#define __ESMBIRTHSIGNDLG_H


/*===========================================================================
 *
 * Begin Required Includes
 *
 *=========================================================================*/
  #include "EsmRecDialog.h"
  #include "Resource.h"
  #include "EsmListCtrl.h"
/*===========================================================================
 *		End of Required Includes
 *=========================================================================*/


/*===========================================================================
 *
 * Begin Definitions
 *
 *=========================================================================*/

/*===========================================================================
 *		End of Definitions
 *=========================================================================*/


/*===========================================================================
 *
 * Begin Class CEsmBirthSignDlg Definition
 *
 *=========================================================================*/
class CEsmBirthSignDlg : public CEsmRecDialog {
  DECLARE_DYNCREATE(CEsmBirthSignDlg);

  /*---------- Begin Protected Class Members ------------------------*/
protected:
  CEsmBirthSign*	m_pBirthSign;


  /*---------- Begin Protected Class Methods ------------------------*/
protected:

  	/* Update item data */
  virtual int OnUpdateItem (esmrecinfo_t* pRecInfo);


  /*---------- Begin Public Class Methods ---------------------------*/
public:

	/* Construction */
  CEsmBirthSignDlg();

  	/* Get class members */
  virtual bool IsModified (void);
	
  	/* Set or update the record data */
  virtual void GetControlData (void);
  virtual void SetControlData (void);

	/* Dialog Data */
  //{{AFX_DATA(CEsmBirthSignDlg)
  enum { IDD = IDD_BIRTHSIGN_DLG };
  CEdit		m_DescText;
  CEsmListCtrl	m_SpellList;
  CButton	m_TextureButton;
  CEdit		m_NameText;
  //}}AFX_DATA

	/* ClassWizard generated virtual function overrides */
  //{{AFX_VIRTUAL(CEsmBirthSignDlg)
protected:
  virtual void OnInitialUpdate();
  virtual void DoDataExchange(CDataExchange* pDX);
  //}}AFX_VIRTUAL

protected:

	/* Generated message map functions */
  //{{AFX_MSG(CEsmBirthSignDlg)
  afx_msg LRESULT OnRecordDrop (LPARAM lParam, LPARAM wParam);
  afx_msg LRESULT OnRecordKey  (LPARAM lParam, LPARAM wParam);
  afx_msg void OnTexturebutton();
  //}}AFX_MSG
 
  DECLARE_MESSAGE_MAP();

 };
/*===========================================================================
 *		End of Class CEsmBirthSignDlg Definition
 *=========================================================================*/


//{{AFX_INSERT_LOCATION}}
//}}AFX_INSERT_LOCATION


#endif
/*===========================================================================
 *		End of File Esmbirthsigndlg.H
 *=========================================================================*/

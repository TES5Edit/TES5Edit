/*===========================================================================
 *
 * File:	Esmsettingdlg.H
 * Author:	Dave Humphrey (uesp@m0use.net)
 * Created On:	February 17, 2003
 *
 * Description
 *
 *=========================================================================*/
#ifndef __ESMSETTINGDLG_H
#define __ESMSETTINGDLG_H


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
 * Begin Class CEsmSettingDlg Definition
 *
 *=========================================================================*/
class CEsmSettingDlg : public CEsmRecDialog {
  DECLARE_DYNCREATE(CEsmSettingDlg);

  /*---------- Begin Protected Class Members ------------------------*/
protected:
  CEsmGameSetting*	m_pSetting;


  /*---------- Begin Protected Class Methods ------------------------*/
protected:


  /*---------- Begin Public Class Methods ---------------------------*/
public:

	/* Construction */
  CEsmSettingDlg();

	/* Get class members */
  virtual bool IsModified (void);
  
  	/* Set or update the record data */
  virtual void GetControlData (void);
  virtual void SetControlData (void);
	
	/* Dialog Data */
  //{{AFX_DATA(CEsmSettingDlg)
  enum { IDD = IDD_SETTING_DLG };
  CEdit		m_ValueText;
  CStatic	m_TypeLabel;
  //}}AFX_DATA
  
	/* ClassWizard generated virtual function overrides */
  //{{AFX_VIRTUAL(CEsmSettingDlg)
protected:
  virtual void OnInitialUpdate();
  virtual void DoDataExchange(CDataExchange* pDX);
  //}}AFX_VIRTUAL

protected:

	/* Generated message map functions */
  //{{AFX_MSG(CEsmSettingDlg)
  //}}AFX_MSG

  DECLARE_MESSAGE_MAP();

 };
/*===========================================================================
 *		End of Class CEsmSettingDlg Definition
 *=========================================================================*/


//{{AFX_INSERT_LOCATION}}
//}}AFX_INSERT_LOCATION


#endif
/*===========================================================================
 *		End of File Esmsettingdlg.H
 *=========================================================================*/

/*===========================================================================
 *
 * File:	Esmlightdlg.H
 * Author:	Dave Humphrey (uesp@m0use.net)
 * Created On:	February 16, 2003
 *
 * Description
 *
 *=========================================================================*/
#ifndef __ESMLIGHTDLG_H
#define __ESMLIGHTDLG_H


/*===========================================================================
 *
 * Begin Required Includes
 *
 *=========================================================================*/
  #include "EsmRecDialog.h"
  #include "Resource.h"
  #include "ColorStatic1.h"
/*===========================================================================
 *		End of Required Includes
 *=========================================================================*/


/*===========================================================================
 *
 * Begin Class CEsmLightDlg Definition
 *
 *=========================================================================*/
class CEsmLightDlg : public CEsmRecDialog {
  DECLARE_DYNCREATE(CEsmLightDlg);

  /*---------- Begin Protected Class Members ------------------------*/
protected:
  CEsmLight*	m_pLight;


  /*---------- Begin Protected Class Methods ------------------------*/
protected:

	/* Update item data */
  virtual int OnUpdateItem (esmrecinfo_t* pRecInfo);


  /*---------- Begin Public Class Methods ---------------------------*/
public:

	/* Construction */
  CEsmLightDlg();

	/* Get class members */
  virtual bool IsModified (void);
  
  	/* Set or update the record data */
  virtual void GetControlData (void);
  virtual void SetControlData (void);
	
	/* Dialog Data */
  //{{AFX_DATA(CEsmLightDlg)
  enum { IDD = IDD_LIGHT_DLG };
  CSpinButtonCtrl	m_RedSpin;
  CSpinButtonCtrl	m_GreenSpin;
  CSpinButtonCtrl	m_BlueSpin;
  CColorStatic	m_ColorBox;
  CButton	m_PersistCheck;
  CButton	m_BlockedCheck;
  CButton	m_CanCarryCheck;
  CButton	m_OffCheck;
  CButton	m_FireCheck;
  CButton	m_DynamicCheck;
  CButton	m_NegativeCheck;
  CEdit		m_ValueText;
  CEdit		m_WeightText;
  CComboBox	m_FlickerList;
  CComboBox	m_SoundList;
  CEdit		m_NameText;
  CEdit		m_RadiusText;
  CEdit		m_TimeText;
  CEdit		m_RedText;
  CEdit		m_GreenText;
  CEdit		m_BlueText;
	//}}AFX_DATA

	/* ClassWizard generated virtual function overrides */
  //{{AFX_VIRTUAL(CEsmLightDlg)
protected:
  virtual void OnInitialUpdate();
  virtual void DoDataExchange(CDataExchange* pDX);
  //}}AFX_VIRTUAL

protected:

	/* Generated message map functions */
  //{{AFX_MSG(CEsmLightDlg)
  afx_msg void OnChangeColor();
  afx_msg void OnColorbutton();
  afx_msg void OnCancarrycheck();
  afx_msg void OnSoundPlay();
  //}}AFX_MSG
  
  DECLARE_MESSAGE_MAP();

 };
/*===========================================================================
 *		End of Class CEsmLightDlg Definition
 *=========================================================================*/


//{{AFX_INSERT_LOCATION}}
//}}AFX_INSERT_LOCATION


#endif
/*===========================================================================
 *		End of File Esmlightdlg.H
 *=========================================================================*/

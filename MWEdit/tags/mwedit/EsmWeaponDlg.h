/*===========================================================================
 *
 * File:	Esmweapondlg.H
 * Author:	Dave Humphrey (uesp@m0use.net)
 * Created On:	February 16, 2003
 *
 * Description
 *
 *=========================================================================*/
#ifndef __ESMWEAPONDLG_H
#define __ESMWEAPONDLG_H


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
 * Begin Class CEsmWeaponDlg Definition
 *
 *=========================================================================*/
class CEsmWeaponDlg : public CEsmRecDialog {
  DECLARE_DYNCREATE(CEsmWeaponDlg);

  /*---------- Begin Protected Class Members ------------------------*/
protected:
  CEsmWeapon*	m_pWeapon;


  /*---------- Begin Protected Class Methods ------------------------*/
protected:

  	/* Update item data */
  virtual int OnUpdateItem (esmrecinfo_t* pRecInfo);


  /*---------- Begin Public Class Methods ---------------------------*/
public:

	/* Construction */
  CEsmWeaponDlg();

	/* Get class members */
  virtual bool IsModified (void);
  
  	/* Set or update the record data */
  virtual void GetControlData (void);
  virtual void SetControlData (void);
	
	/* Dialog Data */
  //{{AFX_DATA(CEsmWeaponDlg)
	enum { IDD = IDD_WEAPON_DLG };
	CButton	m_ScriptButton;
  CButton	m_PersistCheck;
  CButton	m_BlockedCheck;
  CButton	m_IgnoreResistCheck;
  CEdit		m_EnchantText;
  CComboBox	m_EnchantList;
  CEdit		m_ValueText;
  CEdit		m_HealthText;
  CEdit		m_SpeedText;
  CEdit		m_ChopMinText;
  CEdit		m_ChopMaxText;
  CEdit		m_SlashMinText;
  CEdit		m_SlashMaxText;
  CEdit		m_ThrustMinText;
  CEdit		m_ThrustMaxText;
  CEdit		m_ReachText;
  CEdit		m_WeightText;
  CComboBox	m_TypeList;
  CEdit		m_NameText;
	//}}AFX_DATA

	/* ClassWizard generated virtual function overrides */
  //{{AFX_VIRTUAL(CEsmWeaponDlg)
protected:
  virtual void OnInitialUpdate();
  virtual void DoDataExchange(CDataExchange* pDX);
  //}}AFX_VIRTUAL

protected:

	/* Generated message map functions */
  //{{AFX_MSG(CEsmWeaponDlg)
	afx_msg void OnEnchantedit();
	afx_msg void OnSelchangeTypelist();
	//}}AFX_MSG
  void OnSelchangeWeaponList() { m_Modified = true; }

  DECLARE_MESSAGE_MAP();

 };
/*===========================================================================
 *		End of Class CEsmWeaponDlg Definition
 *=========================================================================*/


//{{AFX_INSERT_LOCATION}}
//}}AFX_INSERT_LOCATION


#endif
/*===========================================================================
 *		End of File Esmweapondlg.H
 *=========================================================================*/

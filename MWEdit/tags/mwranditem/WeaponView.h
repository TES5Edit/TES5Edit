/*=========================
==================================================
 *
 * File:	Weaponview.H
 * Author:	Dave Humphrey (uesp@m0use.net)
 * Created On:	May 22, 2003
 *
 * Description
 *
 *=========================================================================*/
#ifndef __WEAPONVIEW_H
#define __WEAPONVIEW_H


/*===========================================================================
 *
 * Begin Required Includes
 *
 *=========================================================================*/
  #include "MWRandCom.h"
/*===========================================================================
 *		End of Required Includes
 *=========================================================================*/


/*===========================================================================
 *
 * Begin Class CWeaponView Definition
 *
 *=========================================================================*/
class CMWRandItemDlg;

class CWeaponView : public CPropertyPage {
  DECLARE_DYNCREATE(CWeaponView);

  /*---------- Begin Protected Class Members -------------------------*/
protected:
  CMWRandItemDlg*	m_pParentDlg;
  mwri_weapondata_t	m_WeaponData;		/* Weapon creation data */
  CEsmLevelItem*	m_pLevelItem;

  CString		m_ListID;


  /*---------- Begin Protected Class Methods -------------------------*/
protected:

	/* Creates a single, random weapon */
  void CreateWeapon (void);

	/* Get/set control data */
  void GetControlData (void);
  void SetControlData (void);


  /*---------- Begin Public Class Members ----------------------------*/
public:

	/* Construction */
  CWeaponView();
  ~CWeaponView();

	/* Set class members */
  void SetParentDlg (CMWRandItemDlg* pParent) { m_pParentDlg = pParent; }

	/* Dialog Data */
  //{{AFX_DATA(CWeaponView)
  enum { IDD = IDD_WEAPON_VIEW };
  CEdit		m_IDPrefix;
  CButton	m_UseNumberID;
  CEdit		m_ChanceNone;
  CEdit		m_LevelListID;
  CButton	m_CreateList;
  CEdit		m_WeightFactor;
  CEdit		m_EnchantFactor;
  CEdit		m_ReachFactor;
  CEdit		m_SpeedFactor;
  CEdit		m_HealthFactor;
  CEdit		m_DamageFactor;
  CEdit		m_IgnoreChance;
  CEdit		m_EnchantChance;
  CEdit		m_Number;
  CEdit		m_Reach2;
  CEdit		m_Reach1;
  CEdit		m_Speed2;
  CEdit		m_Speed1;
  CEdit		m_Condition2;
  CEdit		m_Condition1;
  CEdit		m_Weight2;
  CEdit		m_Weight1;
  CEdit		m_ThrustMax2;
  CEdit		m_ThrustMax1;
  CEdit		m_SlashMax2;
  CEdit		m_SlashMax1;
  CEdit		m_ChopMax2;
  CEdit		m_ChopMax1;
  CEdit		m_ThrustMin2;
  CEdit		m_ThrustMin1;
  CEdit		m_SlashMin2;
  CEdit		m_SlashMin1;
  CEdit		m_ChopMin2;
  CEdit		m_ChopMin1;
	//}}AFX_DATA

	/* ClassWizard generate virtual function overrides */
  //{{AFX_VIRTUAL(CWeaponView)
protected:
  virtual void DoDataExchange(CDataExchange* pDX);
  //}}AFX_VIRTUAL

protected:

	/* Generated message map functions */
  //{{AFX_MSG(CWeaponView)
  afx_msg void OnCreateButton();
	virtual BOOL OnInitDialog();
	afx_msg void OnUsenumberid();
	afx_msg void OnLevellist();
	//}}AFX_MSG

  DECLARE_MESSAGE_MAP();

 };
/*===========================================================================
 *		End of Class CWeaponView Definition
 *=========================================================================*/


//{{AFX_INSERT_LOCATION}}
//}}AFX_INSERT_LOCATION


#endif
/*===========================================================================
 *		End of File Weaponview.H
 *=========================================================================*/

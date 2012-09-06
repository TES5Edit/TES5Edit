/*===========================================================================
 *
 * File:	Esmcreaturepage1.H
 * Author:	Dave Humphrey (uesp@m0use.net)
 * Created On:	March 1, 2003
 *
 * Description
 *
 *=========================================================================*/
#ifndef __ESMCREATUREPAGE1_H
#define __ESMCREATUREPAGE1_H


/*===========================================================================
 *
 * Begin Required Includes
 *
 *=========================================================================*/
  #include "EsmListCtrl.h"
/*===========================================================================
 *		End of Required Includes
 *=========================================================================*/


/*===========================================================================
 *
 * Begin Type Definitions
 *
 *=========================================================================*/
  class CEsmDlgHandler;

	/* Skill data */
/*===========================================================================
 *		End of Type Definitions
 *=========================================================================*/


/*===========================================================================
 *
 * Begin Class CEsmCreaturePage1 Definition
 *
 *=========================================================================*/
class CEsmCreaturePage1 : public CPropertyPage {
  DECLARE_DYNCREATE(CEsmCreaturePage1);

  /*---------- Begin Protected Class Methods ----------------------*/
protected:
  esmrecinfo_t*		m_pRecInfo;
  CEsmDlgHandler*	m_pDlgHandler;
  int			m_SkillValues[MWESM_MAX_SKILLS];

  int			m_SortCol;
  int			m_SortReverse;


  /*---------- Begin Public Class Methods -------------------------*/
public:

	/* Construction */
  CEsmCreaturePage1();
  ~CEsmCreaturePage1();

	/* Get class members */
  CMWEditDoc* GetDocument (void);

	/* Get the current autocalc status */
  bool IsAutoCalc (void);

    	/* Set class members */
  void SetRecInfo    (esmrecinfo_t*   pRecInfo) { m_pRecInfo    = pRecInfo; }
  void SetDlgHandler (CEsmDlgHandler*  pParent) { m_pDlgHandler = pParent; }

	/* Get/set control data */
  void GetControlData (void);
  void SetControlData (void);

	/* Used for the skill list sorting */
  int SortCallback (LPARAM lParam1, LPARAM lParam2);

  	/* Update record data */
  int OnUpdateItem (esmrecinfo_t* pRecInfo);

	/* Update the enabled/disabled controls */
  void UpdateAutoCalc (void);

	/* Dialog Data */
  //{{AFX_DATA(CEsmCreaturePage1)
	enum { IDD = IDD_CREATURE_VIEW1 };
	CComboBox	m_ScriptList;
  CEdit		m_AttMax3Text;
  CEdit		m_AttMin3Text;
  CEdit		m_AttMax2Text;
  CEdit		m_AttMin2Text;
  CEdit		m_AttMax1Text;
  CEdit		m_AttMin1Text;
  CButton	m_BlockedCheck;
  CButton	m_PersistCheck;
  CButton	m_WeapShieldCheck;
  CButton	m_RespawnCheck;
  CButton	m_EssentialCheck;
  CButton	m_NoneCheck;
  CButton	m_BipedCheck;
  CButton	m_SwimsCheck;
  CButton	m_WalksCheck;
  CButton	m_FliesCheck;
  CButton	m_AnimButton;
  CComboBox	m_BloodList;
  CComboBox	m_SoundList;
  CEdit		m_SoulText;
  CEdit		m_FatigueText;
  CEdit		m_MagicText;
  CEdit		m_HealthText;
  CEdit		m_LucText;
  CEdit		m_PerText;
  CEdit		m_EndText;
  CEdit		m_SpdText;
  CEdit		m_AgiText;
  CEdit		m_WilText;
  CEdit		m_IntText;
  CEdit		m_StrText;
  CEdit		m_StealthText;
  CEdit		m_MagicSkillText;
  CEdit		m_CombatText;
  CEdit		m_LevelText;
  CComboBox	m_TypeList;
  CEdit		m_NameText;
	//}}AFX_DATA

	/* ClassWizard generate virtual function overrides */
  //{{AFX_VIRTUAL(CEsmCreaturePage1)
protected:
  virtual void DoDataExchange(CDataExchange* pDX);
  //}}AFX_VIRTUAL

protected:

	/* Generated message map functions */
  //{{AFX_MSG(CEsmCreaturePage1)
  virtual BOOL OnInitDialog();
  afx_msg void OnAnimationbutton();
  afx_msg void OnScriptEdit ();
  //}}AFX_MSG

  DECLARE_MESSAGE_MAP();

 };
/*===========================================================================
 *		End of Class CEsmCreaturePage1 Definition
 *=========================================================================*/


//{{AFX_INSERT_LOCATION}}
//}}AFX_INSERT_LOCATION


#endif
/*===========================================================================
 *		End of File Esmcreaturepage1.H
 *=========================================================================*/

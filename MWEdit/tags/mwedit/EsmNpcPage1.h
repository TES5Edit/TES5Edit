/*===========================================================================
 *
 * File:	Esmnpcpage1.H
 * Author:	Dave Humphrey (uesp@m0use.net)
 * Created On:	February 25, 2003
 *
 * Description
 *
 *=========================================================================*/
#ifndef __ESMNPCPAGE1_H
#define __ESMNPCPAGE1_H


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
 * Begin Class CEsmNpcPage1 Definition
 *
 *=========================================================================*/
class CEsmNpcPage1 : public CPropertyPage {
  DECLARE_DYNCREATE(CEsmNpcPage1);

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
  CEsmNpcPage1();
  ~CEsmNpcPage1();

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
  //{{AFX_DATA(CEsmNpcPage1)
  enum { IDD = IDD_NPC_VIEW1 };
  CButton	m_BlockedCheck;
  CButton	m_PersistCheck;
  CButton	m_AutoCalcCheck;
  CButton	m_RespawnCheck;
  CButton	m_EssentialCheck;
  CButton	m_FemaleCheck;
  CButton	m_AnimButton;
  CComboBox	m_BloodList;
  CComboBox	m_HairList;
  CComboBox	m_HeadList;
  CEdit		m_RepText;
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
  CEdit		m_DispText;
  CEdit		m_LevelText;
  CComboBox	m_RankList;
  CComboBox	m_FactionList;
  CComboBox	m_ClassList;
  CComboBox	m_RaceList;
  CComboBox	m_ScriptList;
  CEdit		m_NameText;
  CEsmListCtrl	m_SkillList;
  //}}AFX_DATA

	/* ClassWizard generate virtual function overrides */
  //{{AFX_VIRTUAL(CEsmNpcPage1)
protected:
  virtual void DoDataExchange(CDataExchange* pDX);
  //}}AFX_VIRTUAL

protected:

	/* Generated message map functions */
  //{{AFX_MSG(CEsmNpcPage1)
  afx_msg LRESULT OnRecordKey  (LPARAM lParam, LPARAM wParam);
  afx_msg LRESULT OnRecordSort (LPARAM lParam, LPARAM wParam);
  virtual BOOL OnInitDialog();
  afx_msg void OnEndlabeleditItemlist(NMHDR* pNMHDR, LRESULT* pResult);
  afx_msg void OnAnimationbutton();
  afx_msg void OnAutocalccheck();
  afx_msg void OnScriptEdit ();
  afx_msg void OnFemalecheck();
  afx_msg void OnSelchangeRacelist();
  //}}AFX_MSG

  DECLARE_MESSAGE_MAP();

 };
/*===========================================================================
 *		End of Class CEsmNpcPage1 Definition
 *=========================================================================*/


//{{AFX_INSERT_LOCATION}}
//}}AFX_INSERT_LOCATION


#endif
/*===========================================================================
 *		End of File Esmnpcpage1.H
 *=========================================================================*/

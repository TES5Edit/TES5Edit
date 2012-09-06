/*===========================================================================
 *
 * File:	Esmracedlg.H
 * Author:	Dave Humphrey (uesp@m0use.net)
 * Created On:	February 18, 2003
 *
 * Description
 *
 *=========================================================================*/
#ifndef __ESMRACEDLG_H
#define __ESMRACEDLG_H


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
 * Begin Class CEsmRaceDlg Definition
 *
 *=========================================================================*/
class CEsmRaceDlg : public CEsmRecDialog {
  DECLARE_DYNCREATE(CEsmRaceDlg);

  /*---------- Begin Protected Class Members ------------------------*/
protected:
  CEsmRace*	m_pRace;


  /*---------- Begin Protected Class Methods ------------------------*/
protected:

  	/* Update item data */
  virtual int OnUpdateItem (esmrecinfo_t* pRecInfo);

	/* Update the male/female attribute total controls */
  void UpdateAttribTotals (void);


  /*---------- Begin Public Class Methods ---------------------------*/
public:

	/* Construction */
  CEsmRaceDlg();

  	/* Get class members */
  virtual bool IsModified (void);
	
  	/* Set or update the record data */
  virtual void GetControlData (void);
  virtual void SetControlData (void);

	/* Dialog Data */
  //{{AFX_DATA(CEsmRaceDlg)
  enum { IDD = IDD_RACE_DLG };
  CStatic	m_FemaleTotal;
  CStatic	m_MaleTotal;
  CEdit		m_DescText;
  CEsmListCtrl	m_SpellList;
  CEdit		m_BonusText7;
  CEdit		m_BonusText6;
  CEdit		m_BonusText5;
  CEdit		m_BonusText4;
  CEdit		m_BonusText3;
  CEdit		m_BonusText2;
  CEdit		m_BonusText1;
  CComboBox	m_SkillList7;
  CComboBox	m_SkillList6;
  CComboBox	m_SkillList5;
  CComboBox	m_SkillList4;
  CComboBox	m_SkillList3;
  CComboBox	m_SkillList2;
  CComboBox	m_SkillList1;
  CButton	m_BeastCheck;
  CButton	m_PlayableCheck;
  CEdit		m_WeightText2;
  CEdit		m_WeightText1;
  CEdit		m_HeightText2;
  CEdit		m_HeightText1;
  CEdit		m_LucText2;
  CEdit		m_LucText1;
  CEdit		m_PerText2;
  CEdit		m_PerText1;
  CEdit		m_EndText2;
  CEdit		m_EndText1;
  CEdit		m_SpdText2;
  CEdit		m_SpdText1;
  CEdit		m_AgiText2;
  CEdit		m_AgiText1;
  CEdit		m_WilText2;
  CEdit		m_WilText1;
  CEdit		m_IntText2;
  CEdit		m_IntText1;
  CEdit		m_StrText2;
  CEdit		m_StrText1;
  CEdit		m_NameText;
  //}}AFX_DATA

	/* ClassWizard generated virtual function overrides */
  //{{AFX_VIRTUAL(CEsmRaceDlg)
protected:
  virtual void OnInitialUpdate();
  virtual void DoDataExchange(CDataExchange* pDX);
  //}}AFX_VIRTUAL

protected:

	/* Generated message map functions */
  //{{AFX_MSG(CEsmRaceDlg)
  afx_msg void OnChangeAttribText();
  afx_msg void OnSelchangeSkilllist1();
  afx_msg void OnSelchangeSkilllist2();
  afx_msg void OnSelchangeSkilllist3();
  afx_msg void OnSelchangeSkilllist4();
  afx_msg void OnSelchangeSkilllist5();
  afx_msg void OnSelchangeSkilllist6();
  afx_msg void OnSelchangeSkilllist7();
  afx_msg LRESULT OnRecordDrop (LPARAM lParam, LPARAM wParam);
  afx_msg LRESULT OnRecordKey  (LPARAM lParam, LPARAM wParam);
  //}}AFX_MSG
 
  DECLARE_MESSAGE_MAP();

 };
/*===========================================================================
 *		End of Class CEsmRaceDlg Definition
 *=========================================================================*/


//{{AFX_INSERT_LOCATION}}
//}}AFX_INSERT_LOCATION


#endif
/*===========================================================================
 *		End of File Esmracedlg.H
 *=========================================================================*/

/*===========================================================================
 *
 * File:	Esmalchemydlg.H
 * Author:	Dave Humphrey (uesp@m0use.net)
 * Created On:	February 10, 2003
 *
 * Description
 *
 *=========================================================================*/
#ifndef __ESMALCHEMYDLG_H
#define __ESMALCHEMYDLG_H



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
 * Begin Class CEsmAlchemyDlg Definition
 *
 *=========================================================================*/
class CEsmAlchemyDlg : public CEsmRecDialog {
  DECLARE_DYNCREATE(CEsmAlchemyDlg);

  /*---------- Begin Protected Class Members ------------------------*/
protected:
  CEsmAlchemy*	m_pAlchemy;
  esmrecinfo_t*	m_pEffectInfo[MWESM_ALCHEMY_NUMENCHANTS];


  /*---------- Begin Protected Class Methods ------------------------*/
protected:

	/* Helper set/get methods */
  void GetEffectData (void);
  void GetEffectData (const int EffectIndex);
  void SetEffectData (void);
  void SetEffectData (const int EffectIndex, CEsmSubENAM* pEffectRecord);

  void OnSelChangeEffectList (const int Index);
  void OnSelChangeSkillList (const int Index);

  	/* Update item data */
  virtual int OnUpdateItem (esmrecinfo_t* pRecInfo);

  void UpdateSpellCost (const int Index);
  void UpdateTotalSpellCost (void);


  /*---------- Begin Public Class Methods ---------------------------*/
public:

	/* Construction */
  CEsmAlchemyDlg();

	/* Get class members */
  virtual bool IsModified (void);
  
  	/* Set or update the record data */
  virtual void GetControlData (void);
  virtual void SetControlData (void);
	
	/* Dialog Data */
  //{{AFX_DATA(CEsmAlchemyDlg)
  enum { IDD = IDD_ALCHEMY_DLG };
  CButton	m_AutoCalcCheck;
  CButton	m_PersistCheck;
  CButton	m_BlockedCheck;
  CEdit		m_ValueText;
  CEdit		m_WeightText;
  CEdit		m_NameText;
  //}}AFX_DATA
  CComboBox	m_EffectList[MWESM_ALCHEMY_NUMENCHANTS];
  CComboBox	m_SkillList[MWESM_ALCHEMY_NUMENCHANTS];
  CEdit		m_CostText[MWESM_ALCHEMY_NUMENCHANTS];
  CEdit		m_DurationText[MWESM_ALCHEMY_NUMENCHANTS];
  CEdit		m_MagnitudeText[MWESM_ALCHEMY_NUMENCHANTS];
  CEdit		m_TotalCostText[MWESM_ALCHEMY_NUMENCHANTS];

	/* ClassWizard generated virtual function overrides */
  //{{AFX_VIRTUAL(CEsmAlchemyDlg)
protected:
  virtual void OnInitialUpdate();
  virtual void DoDataExchange(CDataExchange* pDX);
  //}}AFX_VIRTUAL

protected:

	/* Generated message map functions */
  //{{AFX_MSG(CEsmAlchemyDlg)
  afx_msg void OnAutocalccheck();
  //}}AFX_MSG
  afx_msg void OnChangeDurationtext1()  { UpdateSpellCost (0); }
  afx_msg void OnChangeDurationtext2()  { UpdateSpellCost (1); }
  afx_msg void OnChangeDurationtext3()  { UpdateSpellCost (2); }
  afx_msg void OnChangeDurationtext4()  { UpdateSpellCost (3); }
  afx_msg void OnChangeDurationtext5()  { UpdateSpellCost (4); }
  afx_msg void OnChangeDurationtext6()  { UpdateSpellCost (5); }
  afx_msg void OnChangeDurationtext7()  { UpdateSpellCost (6); }
  afx_msg void OnChangeDurationtext8()  { UpdateSpellCost (7); }
  afx_msg void OnSelchangeEffectlist1() { OnSelChangeEffectList(0); }
  afx_msg void OnSelchangeEffectlist2() { OnSelChangeEffectList(1); }
  afx_msg void OnSelchangeEffectlist3() { OnSelChangeEffectList(2); }
  afx_msg void OnSelchangeEffectlist4() { OnSelChangeEffectList(3); }
  afx_msg void OnSelchangeEffectlist5() { OnSelChangeEffectList(4); }
  afx_msg void OnSelchangeEffectlist6() { OnSelChangeEffectList(5); }
  afx_msg void OnSelchangeEffectlist7() { OnSelChangeEffectList(6); }
  afx_msg void OnSelchangeEffectlist8() { OnSelChangeEffectList(7); }
  afx_msg void OnSelchangeSkilllist1()  { OnSelChangeSkillList(0); }
  afx_msg void OnSelchangeSkilllist2()  { OnSelChangeSkillList(1); }
  afx_msg void OnSelchangeSkilllist3()  { OnSelChangeSkillList(2); }
  afx_msg void OnSelchangeSkilllist4()  { OnSelChangeSkillList(3); }
  afx_msg void OnSelchangeSkilllist5()  { OnSelChangeSkillList(4); }
  afx_msg void OnSelchangeSkilllist6()  { OnSelChangeSkillList(5); }
  afx_msg void OnSelchangeSkilllist7()  { OnSelChangeSkillList(6); }
  afx_msg void OnSelchangeSkilllist8()  { OnSelChangeSkillList(7); }
 
  DECLARE_MESSAGE_MAP();

 };
/*===========================================================================
 *		End of Class CEsmAlchemyDlg Definition
 *=========================================================================*/



#endif
/*===========================================================================
 *		End of File Esmalchemydlg.H
 *=========================================================================*/

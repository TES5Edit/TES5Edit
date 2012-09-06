/*===========================================================================
 *
 * File:	Esmingrediantdlg.H
 * Author:	Dave Humphrey (uesp@m0use.net)
 * Created On:	February 15, 2003
 *
 * Description
 *
 *=========================================================================*/
#ifndef __ESMINGREDIANTDLG_H
#define __ESMINGREDIANTDLG_H


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
 * Begin Class CEsmIngrediantDlg Definition
 *
 *=========================================================================*/
class CEsmIngrediantDlg : public CEsmRecDialog {
  DECLARE_DYNCREATE(CEsmIngrediantDlg);

  /*---------- Begin Protected Class Members ------------------------*/
protected:
  CEsmIngrediant*	m_pIngrediant;
  esmrecinfo_t*		m_pEffectInfo[MWESM_INGRE_NUMENCHANTS];


  /*---------- Begin Protected Class Methods ------------------------*/
protected:

	/* Helper set/get methods */
  void GetEffectData (void);
  void GetEffectData (const int ListIndex, const int EffectIndex);
  void SetEffectData (void);
  void SetEffectData (const int EffectIndex);

  void OnSelChangeEffectList (const int Index);
  void OnSelChangeSkillList (const int Index);

  	/* Update item data */
  virtual int OnUpdateItem (esmrecinfo_t* pRecInfo);


  /*---------- Begin Public Class Methods ---------------------------*/
public:

	/* Construction */
  CEsmIngrediantDlg();

	/* Get class members */
  virtual bool IsModified (void);
  
  	/* Set or update the record data */
  virtual void GetControlData (void);
  virtual void SetControlData (void);
	
	/* Dialog Data */
  //{{AFX_DATA(CEsmIngrediantDlg)
  enum { IDD = IDD_INGREDIANT_DLG };
  CButton	m_PersistCheck;
  CButton	m_BlockedCheck;
  CEdit		m_ValueText;
  CEdit		m_WeightText;
  CEdit		m_NameText;
  //}}AFX_DATA
  CComboBox	m_EffectList[MWESM_INGRE_NUMENCHANTS];
  CComboBox	m_SkillList[MWESM_INGRE_NUMENCHANTS];
  
	/* ClassWizard generated virtual function overrides */
  //{{AFX_VIRTUAL(CEsmIngrediantDlg)
protected:
  virtual void OnInitialUpdate();
  virtual void DoDataExchange(CDataExchange* pDX);
  //}}AFX_VIRTUAL

protected:

	/* Generated message map functions */
  //{{AFX_MSG(CEsmIngrediantDlg)
  //}}AFX_MSG
  afx_msg void OnSelchangeEffectlist1() { OnSelChangeEffectList(0); }
  afx_msg void OnSelchangeEffectlist2() { OnSelChangeEffectList(1); }
  afx_msg void OnSelchangeEffectlist3() { OnSelChangeEffectList(2); }
  afx_msg void OnSelchangeEffectlist4() { OnSelChangeEffectList(3); }
  afx_msg void OnSelchangeSkilllist1()  { OnSelChangeSkillList(0); }
  afx_msg void OnSelchangeSkilllist2()  { OnSelChangeSkillList(1); }
  afx_msg void OnSelchangeSkilllist3()  { OnSelChangeSkillList(2); }
  afx_msg void OnSelchangeSkilllist4()  { OnSelChangeSkillList(3); }
  
  DECLARE_MESSAGE_MAP();

 };
/*===========================================================================
 *		End of Class CEsmIngrediantDlg Definition
 *=========================================================================*/


//{{AFX_INSERT_LOCATION}}
//}}AFX_INSERT_LOCATION


#endif
/*===========================================================================
 *		End of File Esmingrediantdlg.H
 *=========================================================================*/

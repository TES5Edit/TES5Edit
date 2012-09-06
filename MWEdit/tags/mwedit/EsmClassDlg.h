/*===========================================================================
 *
 * File:	Esmclassdlg.H
 * Author:	Dave Humphrey (uesp@m0use.net)
 * Created On:	February 17, 2003
 *
 * Description
 *
 *=========================================================================*/
#ifndef __ESMCLASSDLG_H


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
 * Begin Class CEsmClassDlg Definition
 *
 *=========================================================================*/
class CEsmClassDlg : public CEsmRecDialog {
  DECLARE_DYNCREATE(CEsmClassDlg);

  /*---------- Begin Protected Class Members ------------------------*/
protected:
  CEsmClass*	m_pClass;


  /*---------- Begin Protected Class Methods ------------------------*/
protected:

	/* Update modified items during edit */
  virtual int OnUpdateItem (esmrecinfo_t* pRecInfo);


  /*---------- Begin Public Class Methods ---------------------------*/
public:

	/* Construction */
  CEsmClassDlg();

  	/* Get class members */
  virtual bool IsModified (void);
	
  	/* Set or update the record data */
  virtual void GetControlData (void);
  virtual void SetControlData (void);

	/* Dialog Data */
  //{{AFX_DATA(CEsmClassDlg)
  enum { IDD = IDD_CLASS_DLG };
  CComboBox	m_MinorList5;
  CComboBox	m_MinorList4;
  CComboBox	m_MinorList3;
  CComboBox	m_MinorList2;
  CComboBox	m_MinorList1;
  CComboBox	m_MajorList5;
  CComboBox	m_MajorList4;
  CComboBox	m_MajorList3;
  CComboBox	m_MajorList2;
  CComboBox	m_MajorList1;
  CButton	m_PlayableCheck;
  CButton	m_RepairItemsCheck;
  CButton	m_TrainCheck;
  CButton	m_SpellmakingCheck;
  CButton	m_EnchantCheck;
  CButton	m_WeaponCheck;
  CButton	m_SpellCheck;
  CButton	m_MagicItemCheck;
  CButton	m_RepairCheck;
  CButton	m_PotionCheck;
  CButton	m_ProbeCheck;
  CButton	m_MiscCheck;
  CButton	m_PickCheck;
  CButton	m_LightCheck;
  CButton	m_IngrediantCheck;
  CButton	m_ClothingCheck;
  CButton	m_BookCheck;
  CButton	m_ArmorCheck;
  CButton	m_ApparatusCheck;
  CEdit		m_DescText;
  CComboBox	m_SpecialList;
  CComboBox	m_AttributeList2;
  CComboBox	m_AttributeList1;
  CEdit		m_NameText;
  //}}AFX_DATA

	/* ClassWizard generated virtual function overrides */
  //{{AFX_VIRTUAL(CEsmClassDlg)
protected:
  virtual void OnInitialUpdate();
  virtual void DoDataExchange(CDataExchange* pDX);
  //}}AFX_VIRTUAL

protected:

	/* Generated message map functions */
  //{{AFX_MSG(CEsmClassDlg)
  //}}AFX_MSG
  void OnSelChangeSkillList (CComboBox* pComboBox);
  afx_msg void OnSelchangeMajorlist1() { OnSelChangeSkillList(&m_MajorList1); }
  afx_msg void OnSelchangeMajorlist2() { OnSelChangeSkillList(&m_MajorList2); }
  afx_msg void OnSelchangeMajorlist3() { OnSelChangeSkillList(&m_MajorList3); }
  afx_msg void OnSelchangeMajorlist4() { OnSelChangeSkillList(&m_MajorList4); }
  afx_msg void OnSelchangeMajorlist5() { OnSelChangeSkillList(&m_MajorList5); }
  afx_msg void OnSelchangeMinorlist1() { OnSelChangeSkillList(&m_MinorList1); }
  afx_msg void OnSelchangeMinorlist2() { OnSelChangeSkillList(&m_MinorList2); }
  afx_msg void OnSelchangeMinorlist3() { OnSelChangeSkillList(&m_MinorList3); }
  afx_msg void OnSelchangeMinorlist4() { OnSelChangeSkillList(&m_MinorList4); }
  afx_msg void OnSelchangeMinorlist5() { OnSelChangeSkillList(&m_MinorList5); }
 
  DECLARE_MESSAGE_MAP();

 };
/*===========================================================================
 *		End of Class CEsmClassDlg Definition
 *=========================================================================*/


//{{AFX_INSERT_LOCATION}}
//}}AFX_INSERT_LOCATION


#endif
/*===========================================================================
 *		End of File Esmclassdlg.H
 *=========================================================================*/

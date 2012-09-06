/*===========================================================================
 *
 * File:	Esmarmordlg.H
 * Author:	Dave Humphrey (uesp@m0use.net)
 * Created On:	February 8, 2003
 *
 * Description
 *
 *=========================================================================*/
#ifndef __ESMARMORDLG_H
#define __ESMARMORDLG_H


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
 * Begin Class CEsmArmorDlg Definition
 *
 *=========================================================================*/
class CEsmArmorDlg : public CEsmRecDialog {
  DECLARE_DYNCREATE(CEsmArmorDlg);

  /*---------- Begin Protected Class Members ------------------------*/
protected:
  CEsmArmor*	m_pArmor;


  /*---------- Begin Protected Class Methods ------------------------*/
protected:

	/* Handles selchange events in all the biped lists */
  void OnSelChangeBipedList (const int Index);

  	/* Update item data */
  virtual int OnUpdateItem (esmrecinfo_t* pRecInfo);

	/* Sets the values for a biped object */
  void SetBipedObject (const int Index);

	/* Helper get/set methods */
  void GetBipedData (void);
  void SetBipedData (void);
  void SetBipedData (const int BipedIndex, CEsmSubByte* pIndexRecord, const int RecordIndex);


  /*---------- Begin Public Class Methods ---------------------------*/
public:

	/* Construction */
  CEsmArmorDlg();

	/* Get class members */
  virtual bool IsModified (void);
  
  	/* Set or update the record data */
  virtual void GetControlData (void);
  virtual void SetControlData (void);
	
	/* Dialog Data */
  //{{AFX_DATA(CEsmArmorDlg)
  enum { IDD = IDD_ARMOR_DLG1 };
  CButton	m_PersistCheck;
  CButton	m_BlockedCheck;
  CEdit		m_EnchantText;
  CComboBox	m_EnchantList;
  CEdit		m_ValueText;
  CEdit		m_HealthText;
  CEdit		m_RatingText;
  CEdit		m_WeightText;
  CComboBox	m_TypeList;
  CEdit		m_NameText;
  //}}AFX_DATA
  CComboBox	m_MArmorList[MWESM_ARMOR_MAXBODYPARTS];
  CComboBox	m_FArmorList[MWESM_ARMOR_MAXBODYPARTS];
  CComboBox	m_BipedList[MWESM_ARMOR_MAXBODYPARTS];

	/* ClassWizard generated virtual function overrides */
  //{{AFX_VIRTUAL(CEsmArmorDlg)
protected:
  virtual void OnInitialUpdate();
  virtual void DoDataExchange(CDataExchange* pDX);
  //}}AFX_VIRTUAL

protected:

	/* Generated message map functions */
  //{{AFX_MSG(CEsmArmorDlg)
	afx_msg void OnEnchantedit();
	//}}AFX_MSG
  void OnSelchangeBipedlist1() { OnSelChangeBipedList(0); }
  void OnSelchangeBipedlist2() { OnSelChangeBipedList(1); }
  void OnSelchangeBipedlist3() { OnSelChangeBipedList(2); }
  void OnSelchangeBipedlist4() { OnSelChangeBipedList(3); }
  void OnSelchangeBipedlist5() { OnSelChangeBipedList(4); }
  void OnSelchangeBipedlist6() { OnSelChangeBipedList(5); }
  void OnSelchangeBipedlist7() { OnSelChangeBipedList(6); }
  void OnSelchangeArmorList() { m_Modified = true; }

  DECLARE_MESSAGE_MAP();

 };
/*===========================================================================
 *		End of Class CEsmArmorDlg Definition
 *=========================================================================*/


//{{AFX_INSERT_LOCATION}}
//}}AFX_INSERT_LOCATION


#endif
/*===========================================================================
 *		End of File Esmarmordlg.H
 *=========================================================================*/

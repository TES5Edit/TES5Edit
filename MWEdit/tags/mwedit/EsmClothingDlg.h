/*===========================================================================
 *
 * File:	Esmclothingdlg.H
 * Author:	Dave Humphrey (uesp@m0use.net)
 * Created On:	February 14, 2003
 *
 * Description
 *
 *=========================================================================*/
#ifndef __ESMCLOTHINGDLG_H
#define __ESMCLOTHINGDLG_H

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
 * Begin Class CEsmClothingDlg Definition
 *
 *=========================================================================*/
class CEsmClothingDlg : public CEsmRecDialog {
  DECLARE_DYNCREATE(CEsmClothingDlg);

  /*---------- Begin Protected Class Members ------------------------*/
protected:
  CEsmClothing*	m_pClothing;


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
  CEsmClothingDlg();

	/* Get class members */
  virtual bool IsModified (void);
  
  	/* Set or update the record data */
  virtual void GetControlData (void);
  virtual void SetControlData (void);
	
	/* Dialog Data */
  //{{AFX_DATA(CEsmClothingDlg)
  enum { IDD = IDD_CLOTHING_DLG };
  CButton	m_PersistCheck;
  CButton	m_BlockedCheck;
  CEdit		m_EnchantText;
  CComboBox	m_EnchantList;
  CEdit		m_ValueText;
  CEdit		m_WeightText;
  CComboBox	m_TypeList;
  CEdit		m_NameText;
  //}}AFX_DATA
  CComboBox	m_MClothList[MWESM_CLOTH_MAXBODYPARTS];
  CComboBox	m_FClothList[MWESM_CLOTH_MAXBODYPARTS];
  CComboBox	m_BipedList[MWESM_CLOTH_MAXBODYPARTS];

	/* ClassWizard generated virtual function overrides */
  //{{AFX_VIRTUAL(CEsmClothingDlg)
protected:
  virtual void OnInitialUpdate();
  virtual void DoDataExchange(CDataExchange* pDX);
  //}}AFX_VIRTUAL

protected:

	/* Generated message map functions */
  //{{AFX_MSG(CEsmClothingDlg)
	afx_msg void OnEnchantedit();
	//}}AFX_MSG
  void OnSelchangeBipedlist1() { OnSelChangeBipedList(0); }
  void OnSelchangeBipedlist2() { OnSelChangeBipedList(1); }
  void OnSelchangeBipedlist3() { OnSelChangeBipedList(2); }
  void OnSelchangeBipedlist4() { OnSelChangeBipedList(3); }
  void OnSelchangeBipedlist5() { OnSelChangeBipedList(4); }
  void OnSelchangeBipedlist6() { OnSelChangeBipedList(5); }
  void OnSelchangeBipedlist7() { OnSelChangeBipedList(6); }
  void OnSelchangeClothList() { m_Modified = true; }

  DECLARE_MESSAGE_MAP();

 };
/*===========================================================================
 *		End of Class CEsmClothingDlg Definition
 *=========================================================================*/


//{{AFX_INSERT_LOCATION}}
//}}AFX_INSERT_LOCATION


#endif
/*===========================================================================
 *		End of File Esmclothingdlg.H
 *=========================================================================*/

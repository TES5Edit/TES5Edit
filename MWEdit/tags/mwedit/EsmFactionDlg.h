/*===========================================================================
 *
 * File:	Esmfactiondlg.H
 * Author:	Dave Humphrey (uesp@m0use.net)
 * Created On:	February 18, 2003
 *
 * Description
 *
 *=========================================================================*/
#ifndef __ESMFACTIONDLG_H
#define __ESMFACTIONDLG_H


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
 * Begin Definitions
 *
 *=========================================================================*/

	/* Rank list definitions */
  #define MWESM_RANKLIST_INDEX		0
  #define MWESM_RANKLIST_NAME		1
  #define MWESM_RANKLIST_ATTRIB1	2
  #define MWESM_RANKLIST_ATTRIB2	3
  #define MWESM_RANKLIST_SKILL1		4
  #define MWESM_RANKLIST_SKILL2		5
  #define MWESM_RANKLIST_FACTREP	6

	/* Reaction list definitions */
  #define MWESM_REACLIST_NAME	0
  #define MWESM_REACLIST_VALUE	1

/*===========================================================================
 *		End of Definitions
 *=========================================================================*/


/*===========================================================================
 *
 * Begin Class CEsmFactionDlg Definition
 *
 *=========================================================================*/
class CEsmFactionDlg : public CEsmRecDialog {
  DECLARE_DYNCREATE(CEsmFactionDlg);

  /*---------- Begin Protected Class Members ------------------------*/
protected:
  CEsmFaction*	m_pFaction;
  int		m_CurrentRank;
  int		m_CurrentReaction;


  /*---------- Begin Protected Class Methods ------------------------*/
protected:

	/* Update the rank list data controls */
  void GetRankData (void);
  void SetRankData (const int Rank);
  void GetReactionData (void);
  void SetReactionData (const int Rank);

  	/* Update item data */
  virtual int OnUpdateItem (esmrecinfo_t* pRecInfo);


  /*---------- Begin Public Class Methods ---------------------------*/
public:

	/* Construction */
  CEsmFactionDlg();

  	/* Get class members */
  virtual bool IsModified (void);
	
  	/* Set or update the record data */
  virtual void GetControlData (void);
  virtual void SetControlData (void);

	/* Dialog Data */
  //{{AFX_DATA(CEsmFactionDlg)
  enum { IDD = IDD_FACTION_DLG };
  CEdit		m_AdjustText;
  CEdit		m_FactRepText;
  CListCtrl	m_ReactionList;
  CComboBox	m_FactionList;
  CEdit		m_SkillText2;
  CEdit		m_SkillText1;
  CEdit		m_AttributeText2;
  CEdit		m_AttributeText1;
  CEdit		m_RankNameText;
  CComboBox	m_AttributeList2;
  CComboBox	m_AttributeList1;
  CComboBox	m_SkillList6;
  CComboBox	m_SkillList5;
  CComboBox	m_SkillList4;
  CComboBox	m_SkillList3;
  CComboBox	m_SkillList2;
  CComboBox	m_SkillList1;
  CListCtrl	m_RankList;
  CButton	m_HiddenCheck;
  CEdit		m_NameText;
  //}}AFX_DATA

	/* ClassWizard generated virtual function overrides */
  //{{AFX_VIRTUAL(CEsmFactionDlg)
protected:
  virtual void OnInitialUpdate();
  virtual void DoDataExchange(CDataExchange* pDX);
  //}}AFX_VIRTUAL

protected:

	/* Generated message map functions */
  //{{AFX_MSG(CEsmFactionDlg)
	afx_msg void OnItemchangingRanklist(NMHDR* pNMHDR, LRESULT* pResult);
	afx_msg void OnItemchangingReactionlist(NMHDR* pNMHDR, LRESULT* pResult);
	afx_msg void OnNewreaction();
	afx_msg void OnDelreaction();
	//}}AFX_MSG
 
  DECLARE_MESSAGE_MAP();

 };
/*===========================================================================
 *		End of Class CEsmFactionDlg Definition
 *=========================================================================*/


//{{AFX_INSERT_LOCATION}}
//}}AFX_INSERT_LOCATION


#endif
/*===========================================================================
 *		End of File Esmfactiondlg.H
 *=========================================================================*/


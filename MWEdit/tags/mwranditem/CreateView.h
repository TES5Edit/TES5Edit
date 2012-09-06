/*===========================================================================
 *
 * File:	Createview.H
 * Author:	Dave Humphrey (uesp@m0use.net)
 * Created On:	May 24, 2003
 *
 * Description
 *
 *=========================================================================*/
#ifndef __CREATEVIEW_H
#define __CREATEVIEW_H


/*===========================================================================
 *
 * Begin Required Includes
 *
 *=========================================================================*/
  #include "MWRandItemGen.h"
/*===========================================================================
 *		End of Required Includes
 *=========================================================================*/


/*===========================================================================
 *
 * Begin Definitions
 *
 *=========================================================================*/

	/* User defined events */
  #define MWRI_EVENT_NEWITEMS (WM_USER+1)

/*===========================================================================
 *		End of Definitions
 *=========================================================================*/


/*===========================================================================
 *
 * Begin Class CCreateView Definition
 *
 *=========================================================================*/
class CMWRandItemDlg;

class CCreateView : public CPropertyPage {
  DECLARE_DYNCREATE(CCreateView);

  /*---------- Protected Class Methods ----------------------------*/
protected:
  mwrig_options_t* m_pOptions;		/* Reference to options object */
  CMwRandItemGen*  m_pRandItemGen;
  CMWRandItemDlg*  m_pParentDlg;
  double	   m_CreateTime;

  /*---------- Public Class Methods -------------------------------*/
public:
  CCreateView();
  ~CCreateView();

	/* Fill the ID type combo list */
  void CreateIDTypeList (void);

	/* Get/update control data */
  void GetControlData (void);
  void SetControlData (void);

	/* Get class members */
  double GetCreateTime (void) { return (m_CreateTime); }

	/* Set class members */
  void SetOptions     (mwrig_options_t* pOptions) { m_pOptions = pOptions; }
  void SetRandItemGen (CMwRandItemGen*  pItemGen) { m_pRandItemGen = pItemGen; }
  void SetParentDlg   (CMWRandItemDlg* pParent)   { m_pParentDlg = pParent; }


  //{{AFX_DATA(CCreateView)
	enum { IDD = IDD_CREATE_VIEW };
	CButton	m_MiscCheck;
  CEdit		m_UnScriptName;
  CEdit		m_InScriptName;
  CButton	m_UseScriptName;
  CEdit		m_PHListID;
  CButton	m_MakePHList;
  CComboBox	m_IdTypeList;
  CButton	m_OutputScriptRec;
  CButton	m_OutputScript;
  CButton	m_UseListID;
  CEdit		m_ChanceNone;
  CButton	m_RemoveDuplicates;
  CEdit		m_CurseChance;
  CEdit		m_UniqueChance;
  CEdit		m_SuffixChance;
  CEdit		m_PrefixChance;
  CEdit		m_IDPrefix;
  CEdit		m_ListID;
  CButton	m_CreateListCheck;
  CButton	m_ClothingCheck;
  CButton	m_ArmorCheck;
  CButton	m_WeaponCheck;
  CEdit		m_BellValue;
  CButton	m_BellCheck;
  CEdit		m_LevelTo;
  CEdit		m_LevelFrom;
  CEdit		m_ItemNumber;
	//}}AFX_DATA

	/* ClassWizard generate virtual function overrides */
  //{{AFX_VIRTUAL(CCreateView)
  protected:
  virtual void DoDataExchange(CDataExchange* pDX); 
  //}}AFX_VIRTUAL

protected:

	/* Generated message map functions */
  //{{AFX_MSG(CCreateView)
  afx_msg void OnCreateButton();
  virtual BOOL OnInitDialog();
  afx_msg void OnCreatelistcheck();
  afx_msg void OnBellcheck();
  afx_msg void OnUselistid();
  //}}AFX_MSG
	 
  DECLARE_MESSAGE_MAP();

 };
/*===========================================================================
 *		End of Class CCreateView Definition
 *=========================================================================*/


//{{AFX_INSERT_LOCATION}}
//}}AFX_INSERT_LOCATION


#endif
/*===========================================================================
 *		End of File Createview.H
 *=========================================================================*/

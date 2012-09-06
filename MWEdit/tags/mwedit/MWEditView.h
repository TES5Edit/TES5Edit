/*===========================================================================
 *
 * File:	MWEditView.H
 * Author:	Dave Humphrey (uesp@m0use.net)
 * Created On:	Monday, 03 February, 2003
 *
 * Interface of the CMWEditView class.
 *
 *=========================================================================*/
#ifndef __MWEditView_H
#define __MWEditView_H


/*===========================================================================
 *
 * Begin Required Includes
 *
 *=========================================================================*/
  #include "EsmListCtrl.h"
  #include "EsmDlgArray.h"
/*===========================================================================
 *		End of Required Includes
 *=========================================================================*/


/*===========================================================================
 *
 * Begin Definitions
 *
 *=========================================================================*/

	/* Object tab data */
  #define OBJECT_TAB_ACTIVATOR	 1
  #define OBJECT_TAB_ALCHEMY	 2
  #define OBJECT_TAB_APPARATUS	 3
  #define OBJECT_TAB_ARMOR  	 4
  #define OBJECT_TAB_BODYPART	 5
  #define OBJECT_TAB_BOOK	 6
  #define OBJECT_TAB_CLOTHING	 7
  #define OBJECT_TAB_CONTAINER	 8
  #define OBJECT_TAB_CREATURE	 9
  #define OBJECT_TAB_DOOR	 10
  #define OBJECT_TAB_ENCHANT	 11
  #define OBJECT_TAB_INGREDIANT	 12
  #define OBJECT_TAB_LEVELCREA	 13
  #define OBJECT_TAB_LEVELITEM	 14
  #define OBJECT_TAB_LIGHT	 15
  #define OBJECT_TAB_LOCKPICK	 16
  #define OBJECT_TAB_MISC	 17
  #define OBJECT_TAB_NPC	 18
  #define OBJECT_TAB_PROBE	 19
  #define OBJECT_TAB_REPAIR	 20
  #define OBJECT_TAB_SPELL	 21
  #define OBJECT_TAB_STATIC	 22
  #define OBJECT_TAB_WEAPON	 23
  #define OBJECT_TAB_GLOBAL	 24
  #define OBJECT_TAB_SOUND	 25
  #define OBJECT_TAB_MAGICEFFECT 26
  #define OBJECT_TAB_DIALOG	 27
  #define OBJECT_TAB_GAMESETTING 28
  #define OBJECT_TAB_CLASS	 29
  #define OBJECT_TAB_FACTION     30
  #define OBJECT_TAB_RACE	 31
  #define OBJECT_TAB_SKILL	 32
  #define OBJECT_TAB_SCRIPT	 33
  #define OBJECT_TAB_BIRTHSIGN   34
  #define OBJECT_TAB_SOUNDGEN	 35
  #define OBJECT_TAB_REGION	 36
  #define OBJECT_TAB_CELL	 37
  #define OBJECT_TAB_JOURNAL	 38
  #define OBJECT_TAB_GREETING	 39
  #define OBJECT_TAB_VOICE	 40
  #define OBJECT_TAB_PERSUASION  41
  #define OBJECT_TAB_STARTSCRIPT 42

	/* Used when resizing */
  #define OBJECTTAB_WIDTH_OFFSET  10
  #define TYPELIST_WIDTH	  80
  #define OBJECTTAB_HEIGHT_OFFSET 10
  #define OBJECTTAB_MIN_WIDTH	  100
  #define OBJECTTAB_MIN_HEIGHT	  100

/*===========================================================================
 *		End of Definitions
 *=========================================================================*/


/*===========================================================================
 *
 * Begin Type Definitions
 *
 *=========================================================================*/

	/* Fill list function type */
  class CMWEditView;
  typedef void (CMWEditView::*FILLVIEW_VIEWFUNC) (esmcoldata_t* pColData);

	/* Holds information for the tab control manipulation and display */
  typedef struct {
	int		  TabType;	/* The tab id */
	const TCHAR*	  Title;	/* Tab title text */
	const TCHAR*	  ItemType;	/* Type of item displayed in tab */
	esmcoldata_t*	  pColData;	/* Reference to the column data info */
	int		  DefaultSort;	/* Field id for the initial sort */
	FILLVIEW_VIEWFUNC FillFunc;
    } esmtabinfo_t;

/*===========================================================================
 *		End of Type Definitions
 *=========================================================================*/


/*===========================================================================
 *
 * Begin Class CMWEditView Definition
 *
 *=========================================================================*/
class CMWEditView : public CFormView {

  /*---------- Begin Protected Class Members ----------------------*/
protected:
  int		 m_CurrentType;
  const TCHAR*	 m_pCurrentType;

  CEsmDlgHandler m_EsmDlgHandler;


  //{{AFX_DATA(CMWEditView)
  enum { IDD = IDD_MWEDIT_FORM };
  CListBox	m_TypeList;
  CEsmListCtrl	m_ObjectList;
  //}}AFX_DATA


  /*---------- Begin Protected Class Methods ----------------------*/
protected: 

	/* Create from serialization only */
  CMWEditView();
  DECLARE_DYNCREATE(CMWEditView);

	/* Export records to text files */
  void ExportScripts (void);

	/* Find the tab informtion for a specific record type */
  int FindTabInfo (const TCHAR* pType);

	/* Fill the object list using the given item and display configuration */
  void FillList         (const TCHAR* pItemType, esmcoldata_t* pColData);
  void FillDialogueList (esmcoldata_t* pColData, const int DialType);
  
	/* Initialize the view components */
  void InitTypeList (void);

	/* Stores the current list config data */
  void UpdateCurrentListData (void);


  /*---------- Begin Public Class Methods --------------------------*/
public:

	/* Class destructor */
  virtual ~CMWEditView();

  int EsmCallback (const int Event, const TCHAR* pMessage);

	/* Fill dialogue lists */
  void FillTopicList      (esmcoldata_t* pColData) { FillDialogueList(pColData, MWESM_DIALTYPE_TOPIC); }
  void FillJournalList    (esmcoldata_t* pColData) { FillDialogueList(pColData, MWESM_DIALTYPE_JOURNAL); }
  void FillVoiceList      (esmcoldata_t* pColData) { FillDialogueList(pColData, MWESM_DIALTYPE_VOICE); }
  void FillGreetingList   (esmcoldata_t* pColData) { FillDialogueList(pColData, MWESM_DIALTYPE_GREETING); }
  void FillPersuasionList (esmcoldata_t* pColData) { FillDialogueList(pColData, MWESM_DIALTYPE_PERSUASION); }

	/* Checks the current type of the main view */
  bool IsCurrentType (const TCHAR* pType);

	/* Update a particular item */
  int OnUpdateItem    (esmrecinfo_t* pRecInfo);
  int OnUpdateAddItem (esmrecinfo_t* pRecInfo);
  int OnSelectItem    (esmrecinfo_t* pRecInfo);

	/* Updates the current list data */
  void UpdateList (void);

	/* Diagnostics */
#ifdef _DEBUG
  virtual void AssertValid() const;
  virtual void Dump(CDumpContext& dc) const;
#endif

  CMWEditDoc* GetDocument();

	/* ClassWizard generated virtual function overrides */
  //{{AFX_VIRTUAL(CMWEditView)
public:
  virtual BOOL PreCreateWindow(CREATESTRUCT& cs);
protected:
  virtual void DoDataExchange(CDataExchange* pDX);
  virtual void OnInitialUpdate();
  virtual void OnUpdate(CView* pSender, LPARAM lHint, CObject* pHint);
  virtual void PreSubclassWindow();
  //}}AFX_VIRTUAL

	/* Generated message map functions */
protected:
  //{{AFX_MSG(CMWEditView)
  afx_msg void OnSize(UINT nType, int cx, int cy);
  afx_msg void OnColumnclickObjectlist(NMHDR* pNMHDR, LRESULT* pResult);
  afx_msg void OnViewViewactive();
  afx_msg void OnUpdateViewViewactive(CCmdUI* pCmdUI);
  afx_msg void OnDestroy();
  afx_msg void OnEditAddnew();
  afx_msg void OnContextMenu(CWnd* pWnd, CPoint point);
  afx_msg void OnEdititem();
  afx_msg void OnClose();
  afx_msg void OnSelchangeTypelist();
  afx_msg void OnEditDelete();
  afx_msg void OnEditClean();
  afx_msg void OnUpdateEditAddnew(CCmdUI* pCmdUI);
  afx_msg void OnUpdateEditEdititem(CCmdUI* pCmdUI);
  afx_msg void OnUpdateEditDelete(CCmdUI* pCmdUI);
  afx_msg void OnUpdateEditClean(CCmdUI* pCmdUI);
  afx_msg void OnEditOutputrecinfo();
  afx_msg void OnEditTestfind();
  afx_msg void OnEditPlugininfo();
  afx_msg void OnEditFindtext();
  afx_msg LRESULT OnRecordKey (WPARAM lParam, LPARAM wParam);
  afx_msg LRESULT OnRecordDrop (WPARAM lParam, LPARAM wParam);
  afx_msg void OnEditCreatecopy();
  afx_msg void OnUpdateEditCreatecopy(CCmdUI* pCmdUI);
  afx_msg void OnEditRename();
  afx_msg void OnUpdateEditRename(CCmdUI* pCmdUI);
  afx_msg void OnImportScript();
  afx_msg void OnExportRecords();
  afx_msg void OnTestGettype();
  afx_msg void OnEditInfo();
  afx_msg void OnUpdateEditInfo(CCmdUI* pCmdUI);
  afx_msg void OnEditScripttemplate();
  afx_msg void OnFileImportCsvrecords();
  afx_msg void OnUpdateFileImportCsvrecords(CCmdUI* pCmdUI);
  afx_msg void OnFileExportCsv();
  afx_msg void OnUpdateFileExportCsv(CCmdUI* pCmdUI);
  afx_msg void OnUpdateFileExportSpellmerchants(CCmdUI* pCmdUI);
  afx_msg void OnFileExportSpellmerchants();
  afx_msg void OnTestComparescripts();
  afx_msg void OnEditCompileactivescripts();
	afx_msg void OnEditMakeactive();
	//}}AFX_MSG

  DECLARE_MESSAGE_MAP();

 };
/*===========================================================================
 *		End of Class CMWEditView Definition
 *=========================================================================*/


/*===========================================================================
 *
 * Begin Inline Class Methods
 *
 *=========================================================================*/
#ifndef _DEBUG
  inline CMWEditDoc* CMWEditView::GetDocument() {
    return (CMWEditDoc*)m_pDocument; }
#endif
/*===========================================================================
 *		End of Inline Class Methods
 *=========================================================================*/


//{{AFX_INSERT_LOCATION}}
//}}AFX_INSERT_LOCATION


#endif
/*===========================================================================
 *		End of File View.H
 *=========================================================================*/




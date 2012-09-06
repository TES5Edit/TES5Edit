/*===========================================================================
 *
 * File:	Esmdialogdlg.H
 * Author:	Dave Humphrey (uesp@m0use.net)
 * Created On:	February 16, 2003
 *
 * Description
 *
 *=========================================================================*/
#ifndef __ESMDIALOGDLG_H
#define __ESMDIALOGDLG_H


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

	/* Used for resizing the window and controls */
  #define MWESM_DLGFORM_MINWIDTH     400
  #define MWESM_DLGFORM_MINHEIGHT    120
  #define MWESM_DLGFORM_HEIGHTMARGIN 80
  #define MWESM_DLGFORM_WIDTHMARGIN  20
  #define MWESM_DLGFORM_BUTTONWIDTH  60

	/* Identifies the type of new info records */
  #define MWESM_DLGFORM_CLEANED		2
  #define MWESM_DLGFORM_OLDINFO		3
  #define MWESM_DLGFORM_ACTIVEINFO	4
  #define MWESM_DLGFORM_NEWINFO		5

/*===========================================================================
 *		End of Definitions
 *=========================================================================*/


/*===========================================================================
 *
 * Begin Type Definitions
 *
 *=========================================================================*/

	/* Holds information on modified info records */
  typedef struct {
	esmrecinfo_t*	pNewRecInfo;
	esmrecinfo_t*	pRecInfo;
   } esminfodata_t;

  typedef TPtrArray<esminfodata_t> CEsmInfoDataArray;     

/*===========================================================================
 *		End of Type Definitions
 *=========================================================================*/


/*===========================================================================
 *
 * Begin Class CEsmDialogDlg Definition
 *
 *=========================================================================*/
class CEsmDialogDlg : public CEsmRecDialog {
  DECLARE_DYNCREATE(CEsmDialogDlg);

  /*---------- Begin Protected Class Members ------------------------*/
protected:
  CEsmDialogue*		m_pDialog;	/* Current dialog record we are editting */
  CEsmInfoDataArray	m_NewInfos;	/* List of new and modified info records */
  CEsmInfo*		m_pStartInfo;	/* Head of the info linked list */
  esmrecinfo_t*		m_pNpcFilter;	/* Current NPC that we are filtering for */


  /*---------- Begin Protected Class Methods ------------------------*/
protected:

	/* Clear the new info array */
  void ClearNewInfos (void);

	/* Copy all INFOs into the record */
  void CopyAllInfos (const bool Rename = false);

	/* Checks if the info record can be cleaned or not */
  bool CanCleanInfo (esmrecinfo_t* pRecInfo);

	/* Ensure that the given list index has a new/modified info */
  esmrecinfo_t* CreateNewInfo (const int ListIndex);
  esmrecinfo_t* CreateNewInfo (esmrecinfo_t* pRecInfo, const bool MustBeNew = false);

	/* Attempt to find a new INFO record in the array */
  esminfodata_t* FindNewInfo (const TCHAR* pID);
  esminfodata_t* FindNewInfo (esmrecinfo_t* pRecInfo);
  esmrecinfo_t*  GetRecInfo  (const TCHAR* pID, const TCHAR* pDialogID = NULL);

	/* Helper get/set methods */
  void FillInfoList   (void);
  void UpdateInfoList (const bool FirstUpdate = false);
  bool CheckInfoLinks (esmrecinfo_t* pStartInfoRec, const bool FirstUpdate, CEsmNpc* pFilterNpc);
 
	/* Update item data */
  virtual int OnUpdateItem (esmrecinfo_t* pRecInfo);

	/* Removes the given info from the linked info list */
  void RemoveInfo (esmrecinfo_t* pRecInfo);


  /*---------- Begin Public Class Methods ---------------------------*/
public:

	/* Construction */
  CEsmDialogDlg();
  virtual ~CEsmDialogDlg();

  	/* Get class members */
  virtual bool IsModified (void);
	
  	/* Set or update the record data */
  virtual void GetControlData (void);
  virtual void SetControlData (void);

	/* Dialog Data */
  //{{AFX_DATA(CEsmDialogDlg)
  enum { IDD = IDD_DIALOGUE_DLG };
  CButton	m_CancelButton;
  CButton	m_SaveButton;
  CComboBox	m_FilterList;
  CEsmListCtrl	m_InfoList;
  //}}AFX_DATA

	/* ClassWizard generated virtual function overrides */
  //{{AFX_VIRTUAL(CEsmDialogDlg)
protected:
  virtual void OnInitialUpdate();
  virtual void DoDataExchange(CDataExchange* pDX);
  //}}AFX_VIRTUAL

protected:

	/* Generated message map functions */
  //{{AFX_MSG(CEsmDialogDlg)
  afx_msg LRESULT OnRecordDrop (LPARAM lParam, LPARAM wParam);
  afx_msg LRESULT OnRecordKey  (LPARAM lParam, LPARAM wParam);
  afx_msg LRESULT OnEditRecord (LPARAM lParam, LPARAM wParam);
  afx_msg LRESULT OnEditInfoRecord (LPARAM lParam, LPARAM wParam);
  afx_msg void OnMoveupbutton();
  afx_msg void OnMovedownbutton();
  afx_msg void OnContextMenu(CWnd* pWnd, CPoint point);
  afx_msg void OnEditAddnew();
  afx_msg void OnEditEdititem();
  afx_msg void OnSelchangeFilterlist();
  afx_msg void OnEditCreatecopy();
  afx_msg void OnSize(UINT nType, int cx, int cy);
	afx_msg void OnEditDelete();
	afx_msg void OnEditClean();
	//}}AFX_MSG
 
  DECLARE_MESSAGE_MAP();

 };
/*===========================================================================
 *		End of Class CEsmDialogDlg Definition
 *=========================================================================*/


//{{AFX_INSERT_LOCATION}}
//}}AFX_INSERT_LOCATION


#endif
/*===========================================================================
 *		End of File Esmdialogdlg.H
 *=========================================================================*/

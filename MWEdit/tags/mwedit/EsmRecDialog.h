/*===========================================================================
 *
 * File:	Esmrecdialog.H
 * Author:	Dave Humphrey (uesp@m0use.net)
 * Created On:	February 8, 2003
 *
 * Description
 *
 *=========================================================================*/
#ifndef __ESMRECDIALOG_H
#define __ESMRECDIALOG_H


/*===========================================================================
 *
 * Begin Required Includes
 *
 *=========================================================================*/
  #include "EsmFile.h"
  #include "EsmUtils.h"
  #include "windows/WinUtil.h"
  #include "MWEditDoc.h"
  #include "EsmIconFrame.h"
/*===========================================================================
 *		End of Required Includes
 *=========================================================================*/


/*===========================================================================
 *
 * Begin Definitions
 *
 *=========================================================================*/

	/* Custom messaages */
  #define ESMDLG_MSG_ONINFOEDIT		0x8301

/*===========================================================================
 *		End of Definitions
 *=========================================================================*/


/*===========================================================================
 *
 * Begin Type Definitions
 *
 *=========================================================================*/

	/* Forward class definition */
  class CEsmDlgHandler;
  class CMWEditDoc;
  class CMWEditApp;

/*===========================================================================
 *		End of Type Definitions
 *=========================================================================*/


/*===========================================================================
 *
 * Begin Class CEsmRecDialog Definition
 *
 *=========================================================================*/
class CEsmRecDialog : public CFormView {
  DECLARE_DYNCREATE(CEsmRecDialog);

  /*---------- Begin Protected Class Members -----------------------*/
protected:
  esmreceditinfo_t m_RecEditInfo;	/* Information about the record being editted */
  CEsmDlgHandler*  m_pParent;
  int		   m_DialogID;
  const TCHAR*     m_pTitle;		/* Title prefix (ex: 'Armor') */
  bool		   m_Modified;

  HACCEL	   m_hAccelator;

  CEdit		   m_IDText;		/* Control for the object ID, if any */
  bool		   m_HasIDText;
  CButton	   m_IconButton;
  CButton	   m_ModelButton;
  CComboBox	   m_ScriptList;
  CEsmIconFrame	   m_IconPicture;


  /*---------- Begin Protected Class Methods -----------------------*/
protected:

	/* Checks the ID text of the dialog to see if it has changed */
  virtual void CheckIDText (void);

	/* virtual update methods */
  virtual int OnUpdateRecord	(void) { return (0); }
  virtual int OnUpdateItem	(esmrecinfo_t* pRecInfo) { return (0); }
  virtual int OnUpdateAddItem	(esmrecinfo_t* pRecInfo) { return (OnUpdateItem(pRecInfo)); }

  
  /*---------- Begin Public Class Methods --------------------------*/
public:

	/* Construction */
  CEsmRecDialog (const int IDD = 0);
  virtual ~CEsmRecDialog (void);

	/* Get class members */
  esmrecinfo_t*   GetRecInfo   (void) { return (m_RecEditInfo.pRecInfo); }
  virtual bool    IsModified   (void) { return (m_Modified); }
  bool		  IsRecord     (esmrecinfo_t* pRecInfo);
  CEsmDlgHandler* GetParentDlg (void) { return (m_pParent); }

	/* Retrieve the parent document object */
  CMWEditDoc* GetDocument (void);
  CMWEditApp* GetApp      (void) { return ((CMWEditApp *)AfxGetApp()); }

	/* Set or update the record data */
  virtual void GetControlData (void) { ; }
  virtual void SetControlData (void) { ; }

	/* Record events */
  virtual int OnPostSaveRecord (void);
  virtual int OnPreSaveRecord  (void);

	/* Set class members */
  void SetModified (const bool Flag = true)   { m_Modified = Flag; }
  void SetRecInfo  (esmrecinfo_t*   pRecInfo) { m_RecEditInfo.pRecInfo = pRecInfo; }
  void SetIsNew    (const bool      IsNew)    { m_RecEditInfo.IsNew    = IsNew; m_RecEditInfo.HasAdded = false; }
  void SetParent   (CEsmDlgHandler* pParent)  { m_pParent  = pParent; }
  void SetTitle    (const TCHAR*    pString)  { m_pTitle   = pString; } 
  
	/* Update the window's title */
  void UpdateTitle (const TCHAR* pItemID);

	/* Dialog Data */
  //{{AFX_DATA(CEsmRecDialog)
  //}}AFX_DATA

	/* ClassWizard generated virtual function overrides */
  //{{AFX_VIRTUAL(CEsmRecDialog)
public:
  virtual BOOL PreTranslateMessage(MSG* pMsg);
protected:
  virtual void OnInitialUpdate();
  virtual void DoDataExchange(CDataExchange* pDX);
  virtual void OnUpdate(CView* pSender, LPARAM lHint, CObject* pHint);
  //}}AFX_VIRTUAL

protected:

 	/* Generated message map functions */
  //{{AFX_MSG(CEsmRecDialog)
  afx_msg void OnDestroy();
  afx_msg void OnCancel();
  afx_msg void OnIconbutton();
  afx_msg void OnModelbutton();
  afx_msg void OnSave();
  afx_msg void OnEditCopy();
  afx_msg void OnEditCut();
  afx_msg void OnEditPaste();
  afx_msg void OnScriptEdit();
  //}}AFX_MSG

  DECLARE_MESSAGE_MAP();

 };
/*===========================================================================
 *		End of Class CEsmRecDialog Definition
 *=========================================================================*/




//{{AFX_INSERT_LOCATION}}
//}}AFX_INSERT_LOCATION


#endif
/*===========================================================================
 *		End of File Esmrecdialog.H
 *=========================================================================*/

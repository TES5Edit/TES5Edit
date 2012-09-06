/*===========================================================================
 *
 * File:	Esmdlgarray.H
 * Author:	Dave Humphrey (uesp@m0use.net)
 * Created On:	February 8, 2003
 *
 * Handles a general array of ESM record dialogs.
 *
 *=========================================================================*/
#ifndef __ESMDLGARRAY_H
#define __ESMDLGARRAY_H


/*===========================================================================
 *
 * Begin Required Includes
 *
 *=========================================================================*/
  #include "EsmRecDialog.h"
  #include "MainFrm.h"
/*===========================================================================
 *		End of Required Includes
 *=========================================================================*/


/*===========================================================================
 *
 * Begin Type Definitions
 *
 *=========================================================================*/

	/* Array of dialog pointers */
  typedef TPtrArray<CFrameWnd> CEsmFrameArray;

	/* Type for dialog static creation methods */
  typedef CEsmRecDialog* (*ESMRECDLG_CREATEFUNC) (void);

	/* Function typedef for custom dialog creation */
  class CEsmDlgHandler;
  typedef CFrameWnd* (CEsmDlgHandler::*DLGCREATE_FUNC) (esmrecinfo_t* pRecInfo);

	/* Used to create the various dialogs */
  struct esmdlgcreateinfo_t {
	const TCHAR*		Type;
	const TCHAR*		pTitle;
	int			ResourceID;
	CRuntimeClass*		pViewClass;
	CRuntimeClass*		pFrameClass;
	DLGCREATE_FUNC		CreateFunc;
   };

	/* Class forward definitions */
  class CEsmScriptCompareDlg;

/*===========================================================================
 *		End of Type Definitions
 *=========================================================================*/


/*===========================================================================
 *
 * Begin Class CEsmDlgHandler Definition
 *
 * Description
 *
 *=========================================================================*/
class CEsmDlgHandler {

  /*---------- Begin Private Class Members ----------------------*/
protected:
  CEsmFrameArray  m_Frames;		/* Array of ESM frame windows */
  CMWEditDoc*	  m_pDocument;		/* Current document */
  CMainFrame*	  m_pMainFrame;

  CFrameWnd*	  m_pFindDlg;		/* Find dialog parent frame */
  CFrameWnd*	  m_pUsesDlg;
  CFrameWnd*	  m_pScrTempDlg;
  CFrameWnd*	  m_pScriptCompareDlg;


  /*---------- Begin Protected Class Methods --------------------*/
protected:

	/* Create a new dialog based on the input type */
  CFrameWnd* CreateESMDialog (esmrecinfo_t* pRecInfo, const bool IsNew);
  CFrameWnd* CreateESMDialog (esmdlgcreateinfo_t& CreateInfo);


  /*---------- Begin Public Class Methods -----------------------*/
public:

	/* Class Constructors/Destructors */
  CEsmDlgHandler();
  virtual ~CEsmDlgHandler() { Destroy(); }
  virtual void Destroy (void);

	/* Delete all the dialogs current in the array */
  void ClearDlgArray (void);

	/* Create a copy of a record */
  CEsmRecord* CreateCopy (CEsmRecord* pRecord);

	/* Custom dialog creation methods */
  CFrameWnd* CreateDialogueDlg (esmrecinfo_t* pRecInfo);  

	/* Attempt to open a new edit window */
  bool EditRecord (esmrecinfo_t* pRecInfo, const bool IsNew = false);

	/* Find an existing dialog */
  CFrameWnd* FindDialog (esmrecinfo_t* pRecInfo);

	/* Get the current active filename */
  const TCHAR* GetDocFilename (void);
  CMWEditDoc*  GetDocument    (void) { return (m_pDocument); }
  CEsmFile*    GetActiveFile  (void);
  CMainFrame*  GetMainFrame   (void) { return (m_pMainFrame); }

	/* Try and find a magic effect record */
  esmrecinfo_t* GetEffectRecord (const int EffectID);

  	/* Checks the validity of a new ID */
  bool IsValidID    (const TCHAR* pID);
  bool IsExistingID (const TCHAR* pID);

  	/* Notifies when the find dialog is closed */
  void OnCloseFindDlg	       (void) { m_pFindDlg = NULL; }
  void OnCloseUsesDlg	       (void) { m_pUsesDlg = NULL; }
  void OnCloseScrTempDlg       (void) { m_pScrTempDlg = NULL; }
  void OnCloseScriptCompareDlg (void) { m_pScriptCompareDlg = NULL; }

	/* Indicates that changes are about to be written to the given object */
  int OnPreSaveRecord  (esmreceditinfo_t* pRecEditInfo);
  int OnPostSaveRecord (esmreceditinfo_t* pRecEditInfo);

	/* Request to create a new item of the given type */
  CEsmRecord* OnAddNew (const TCHAR* pType);
  CEsmRecord* OnAddNewDialog (const int DialType);

	/* Display other dialog types */
  void OpenFindDlg	    (void);
  void OpenUsesDlg   	    (esmrecinfo_t* pRecInfo);
  CEsmScriptCompareDlg* OpenScriptCompareDlg (void);
  void OpenScrTempDlg	    (void);

  	/* Removes a frame from the array */
  void RemoveFrame (CFrameWnd* pFrame);

	/* Set class members */
  void SetDocument  (CMWEditDoc* pDoc)	     { m_pDocument  = pDoc; }
  void SetMainFrame (CMainFrame* pMainFrame) { m_pMainFrame = pMainFrame; }

 };
/*===========================================================================
 *		End of Class CEsmDlgHandler Definition
 *=========================================================================*/


#endif
/*===========================================================================
 *		End of File Esmdlgarray.H
 *=========================================================================*/

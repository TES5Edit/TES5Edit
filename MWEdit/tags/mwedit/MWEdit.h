/*===========================================================================
 *
 * File:	MWEdit.H
 * Author:	Dave Humphrey (uesp@m0use.net)
 * Created On:	Monday, 03 February, 2003
 *
 * Main header file for the MWEDIT application.
 *
 *=========================================================================*/
#ifndef __MWEDIT_H
#define __MWEDIT_H


/*===========================================================================
 *
 * Begin Required Include Files
 *
 *=========================================================================*/
#ifndef __AFXWIN_H__
  #error include 'stdafx.h' before including this file for PCH
#endif

  #include "resource.h"
  #include "EsmFile.h"
  #include "EsmLoadDlg.h"
  #include "EsmFuncHelpView.h"
  #include "EsmOptions.h"
  #include "EsmRegDefs.h"
  #include "mwcustomfunc.h"
/*===========================================================================
 *		End of Required Include Files
 *=========================================================================*/


/*===========================================================================
 *
 * Begin Definitions
 *
 *=========================================================================*/
	
	/* Default web sites */
  #define MWEDIT_WEBPAGE_UESPTES3MOD    _T("http://www.uesp.net/wiki/Tes3Mod:Modding")
  #define MWEDIT_WEBPAGE_FEATURE	_T("http://sourceforge.net/tracker/?func=add&group_id=90473&atid=593760")
  #define MWEDIT_WEBPAGE_BUG		_T("http://sourceforge.net/tracker/?func=add&group_id=90473&atid=593757")
  #define MWEDIT_WEBPAGE_PROJECT	_T("http://sourceforge.net/projects/mwedit/")
  #define MWEDIT_FILE_ITEMHELP		_T("TESCSItemIndex.chm")
  #define MWEDIT_FILE_ITEMHELPTITLE	_T("The Elder Scrolls Construction Set Item Index")
  #define MWEDIT_EMAIL_DEVELOPER	_T("mailto:uesp@sympatico.ca")

  #define MWEDIT_DEFAULT_CUSTOMFUNCS	_T("customfunctions.dat")
  
/*===========================================================================
 *		End of Definitions
 *=========================================================================*/


/*===========================================================================
 *
 * Begin Class CMWEditApp Definition
 *
 *=========================================================================*/
class CMWEditApp : public CWinApp {

  /*---------- Begin Protected Class Members -----------------------*/
protected:
public:
  CBitmap		m_IconBitmap[64];

  CStringList		m_Plugins;		/* Used during plugin loading */
  CStringList		m_Masters;
  CString		m_ActivePlugin;

  CEsmFileArray		m_EsmMasters;		/* Current master files */

  HWND			m_hFuncHelpView;	/* Function help window view */
  CFrameWnd*		m_pFuncHelpView;
  CEsmScrFuncArray	m_FunctionArray;	/* Function help definitions */

  CEsmOptions		m_Options;		/* User options */
  long			m_NonameCount;


  /*--------- Begin Public Class Methods ---------------------------*/
public:

	/* Class Constructor */
  CMWEditApp();
  virtual ~CMWEditApp();

	/* Saves a new find history string to the registry */
  bool AddFindHistory (const TCHAR* pString);

	/* Delete all current master files */
  void ClearFileArray (void);

	/* Sees if the find string already exists in the find history */
  int FindFindHistory (const TCHAR* pString);

	/* Find an existing master file */
  CEsmFile* FindMaster (const TCHAR *pFilename);

	/* Get class members */
  CEsmFileArray*    GetMasters       (void) { return (&m_EsmMasters); }
  CEsmScrFuncArray* GetFunctionArray (void) { return (&m_FunctionArray); }
  CEsmOptions*	    GetOptions       (void) { return (&m_Options); }

	/* Loads the given master ESM file */
  CEsmFile* LoadMaster (const TCHAR *pFilename, CEsmLoadDlg* pLoadDlg);

	/* Display the function help window */
  void OpenFuncHelpView (const TCHAR* pFunction = NULL);

	/* Read a specific find history entry from the registry */
  bool ReadFindHistory (CString& Buffer, const int FindIndex);


	/* ClassWizard generated virtual function overrides */
public:
  //{{AFX_VIRTUAL(CMWEditApp)
public:
  virtual BOOL InitInstance();
  virtual CDocument* OpenDocumentFile(LPCTSTR lpszFileName);
  //}}AFX_VIRTUAL


public:
  //{{AFX_MSG(CMWEditApp)
  afx_msg void OnAppAbout();
  afx_msg void OnFileOpen();
  //}}AFX_MSG

  DECLARE_MESSAGE_MAP()
 };
/*===========================================================================
 *		End of Class CMWEditApp Definition
 *=========================================================================*/




//{{AFX_INSERT_LOCATION}}
// Microsoft Visual C++ will insert additional declarations immediately before the previous line.
//}}AFX_INSERT_LOCATION

#endif
/*===========================================================================
 *		End of File Root.H
 *=========================================================================*/

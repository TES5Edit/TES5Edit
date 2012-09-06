/*===========================================================================
 *
 * File:	NifTexture.H
 * Author:	Dave Humphrey (uesp@m0use.net)
 * Created On:	Saturday, 28 December, 2002
 *
 * Main header file for the NIFTEXTURE application.
 *
 *=========================================================================*/
#ifndef __NIFTEXTURE_H
#define __NIFTEXTURE_H


/*===========================================================================
 *
 * Begin Required Include Files
 *
 *=========================================================================*/
#ifndef __AFXWIN_H__
  #error include 'stdafx.h' before including this file for PCH
#endif

  #include "resource.h"
/*===========================================================================
 *		End of Required Include Files
 *=========================================================================*/


/*===========================================================================
 *
 * Begin Class CNifTextureApp Definition
 *
 *=========================================================================*/
class CNifTextureApp : public CWinApp {

  /*---------- Begin Protected Class Members -----------------------*/
protected:



  /*--------- Begin Public Class Methods ---------------------------*/
public:

	/* Class Constructor */
  CNifTextureApp();

	/* Get/set app browse path from registry */
  void     SetBrowsePath (const TCHAR* pPath);
  CString  GetBrowsePath (void);


	/* ClassWizard generated virtual function overrides */
//{{AFX_VIRTUAL(CNifTextureApp)
public:
  virtual BOOL InitInstance();
  //}}AFX_VIRTUAL


  //{{AFX_MSG(CNifTextureApp)
public:
  afx_msg void OnAppAbout();
  //}}AFX_MSG

  DECLARE_MESSAGE_MAP()
 };
/*===========================================================================
 *		End of Class CNifTextureApp Definition
 *=========================================================================*/




//{{AFX_INSERT_LOCATION}}
// Microsoft Visual C++ will insert additional declarations immediately before the previous line.
//}}AFX_INSERT_LOCATION

#endif
/*===========================================================================
 *		End of File Root.H
 *=========================================================================*/

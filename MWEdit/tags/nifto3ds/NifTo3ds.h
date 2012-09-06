/*===========================================================================
 *
 * File:	NifTo3ds.H
 * Author:	Dave Humphrey (uesp@m0use.net)
 * Created On:	Saturday, 06 December, 2003
 *
 * Main header file for the NIFTO3DS application
 *
 *=========================================================================*/
#ifndef __NIFTO3DS_H
#define __NIFTO3DS_H


/*===========================================================================
 *
 * Begin Required Includes
 *
 *=========================================================================*/
#ifndef __AFXWIN_H__
  #error include 'stdafx.h' before including this file for PCH
#endif

  #include "resource.h"
/*===========================================================================
 *		End of Required Includes
 *=========================================================================*/


/*===========================================================================
 *
 * Class CNifTo3dsApp Definition
 *
 *=========================================================================*/
class CNifTo3dsApp : public CWinApp {
public:

	/* Constructor */
  CNifTo3dsApp();

	/* ClassWizard generated virtual function overrides */
  //{{AFX_VIRTUAL(CNifTo3dsApp)
public:
  virtual BOOL InitInstance();
  //}}AFX_VIRTUAL

  //{{AFX_MSG(CNifTo3dsApp)
  //}}AFX_MSG

  DECLARE_MESSAGE_MAP()
 };
/*===========================================================================
 *		End of Class CNifTo3dsApp Definition
 *=========================================================================*/


//{{AFX_INSERT_LOCATION}}
//}}AFX_INSERT_LOCATION Microsoft Visual C++ will insert additional declarations immediately before the previous line.


#endif
/*===========================================================================
 *		End of File Dlgroot.H
 *=========================================================================*/

/*===========================================================================
 *
 * File:	MWRandItem.H
 * Author:	Dave Humphrey (uesp@m0use.net)
 * Created On:	Thursday, 22 May, 2003
 *
 * Main header file for the MWRANDITEM application
 *
 *=========================================================================*/
#ifndef __MWRANDITEM_H
#define __MWRANDITEM_H


/*===========================================================================
 *
 * Begin Required Includes
 *
 *=========================================================================*/
  #include "resource.h"
/*===========================================================================
 *		End of Required Includes
 *=========================================================================*/


/*===========================================================================
 *
 * Class CMWRandItemApp Definition
 *
 *=========================================================================*/
class CMWRandItemApp : public CWinApp {
public:

	/* Constructor */
  CMWRandItemApp();

	/* ClassWizard generated virtual function overrides */
  //{{AFX_VIRTUAL(CMWRandItemApp)
public:
  virtual BOOL InitInstance();
  //}}AFX_VIRTUAL

  //{{AFX_MSG(CMWRandItemApp)
  //}}AFX_MSG

  DECLARE_MESSAGE_MAP()
 };
/*===========================================================================
 *		End of Class CMWRandItemApp Definition
 *=========================================================================*/


//{{AFX_INSERT_LOCATION}}
//}}AFX_INSERT_LOCATION Microsoft Visual C++ will insert additional declarations immediately before the previous line.


#endif
/*===========================================================================
 *		End of File Dlgroot.H
 *=========================================================================*/

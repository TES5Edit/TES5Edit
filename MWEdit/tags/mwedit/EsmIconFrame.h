/*===========================================================================
 *
 * File:	Esmiconframe.H
 * Author:	Dave Humphrey (uesp@m0use.net)
 * Created On:	Thursday, February 13, 2003
 *
 * Description
 *
 *=========================================================================*/
#ifndef __ESMICONFRAME_H
#define __ESMICONFRAME_H


/*===========================================================================
 *
 * Begin Required Includes
 *
 *=========================================================================*/
  #include "dl_err.h"
/*===========================================================================
 *		End of Required Includes
 *=========================================================================*/


/*===========================================================================
 *
 * Begin Definitions
 *
 *=========================================================================*/

	/* Default icon width/height */
  #define MWESM_ICON_DEFAULTWIDTH  32
  #define MWESM_ICON_DEFAULTHEIGHT 32

/*===========================================================================
 *		End of Definitions
 *=========================================================================*/


/*===========================================================================
 *
 * Begin Class CEsmIcon Frame Definition
 *
 *=========================================================================*/
class CEsmIconFrame : public CStatic {

  /*---------- Begin Protected Class Members ---------------------*/
protected:
  CBitmap	m_Bitmap;		/* The bitmap image to draw */
  bool		m_IsInitialized;


  /*---------- Begin Protected Class Methods ---------------------*/
protected:



  /*---------- Begin Public Class Methods ------------------------*/
public:

	/* Construction/Destruction */
  CEsmIconFrame();
  virtual ~CEsmIconFrame();

	/* Called after the frame window is created */
  void OnInitialUpdate (void);

	/* Set class members */
  void SetIconBitmap (CBitmap* pBitmap);
  void SetEsmIcon    (const TCHAR* pFilename, const bool RelativePath = true);

	/* ClassWizard generated virtual function overrides */
  //{{AFX_VIRTUAL(CEsmIconFrame)
  //}}AFX_VIRTUAL

	/* Generated message map functions */
protected:
  //{{AFX_MSG(CEsmIconFrame)
  afx_msg void OnPaint();
  //}}AFX_MSG

  DECLARE_MESSAGE_MAP();

};
/*===========================================================================
 *		End of Class CEsmIcon Frame Definition
 *=========================================================================*/


//{{AFX_INSERT_LOCATION}}
//}}AFX_INSERT_LOCATION


#endif
/*===========================================================================
 *		End of File Esmiconframe.H
 *=========================================================================*/

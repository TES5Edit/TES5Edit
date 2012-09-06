/*===========================================================================
 *
 * File:	SplitterWnd.H
 * Author:	Dave Humphrey (uesp@sympatico.ca)
 * Created On:	April 27, 2006
 *
 * Description
 *
 *=========================================================================*/
#ifndef __SPLITTERWND_H
#define __SPLITTERWND_H


/*===========================================================================
 *
 * Begin Required Includes
 *
 *=========================================================================*/
  
/*===========================================================================
 *		End of Required Includes
 *=========================================================================*/


/*===========================================================================
 *
 * Begin Class CMwSplitterWnd Definition
 *
 *=========================================================================*/
class CMwSplitterWnd : public CSplitterWnd {

  /*---------- Begin Protected Class Members ----------------------*/
protected:
  

  /*---------- Begin Protected Class Methods ----------------------*/
protected:


  /*---------- Begin Public Class Methods -------------------------*/
public:

	/* Construction/Destructor */
  CMwSplitterWnd();
  virtual ~CMwSplitterWnd();

	/* Overloaded to change layout order */
  virtual void RecalcLayout();  

	/* ClassWizard generated virtual function overrides */
  //{{AFX_VIRTUAL(CMwSplitterWnd)
  //}}AFX_VIRTUAL

protected:

	/* Generated message map functions */
  //{{AFX_MSG(CMwSplitterWnd)
  //}}AFX_MSG

  DECLARE_MESSAGE_MAP()

};
/*===========================================================================
 *		End of Class CMwSplitterWnd Definition
 *=========================================================================*/


//{{AFX_INSERT_LOCATION}}
//}}AFX_INSERT_LOCATION


#endif
/*===========================================================================
 *		End of File SplitterWnd.H
 *=========================================================================*/

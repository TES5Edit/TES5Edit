/*===========================================================================
 *
 * File:	Esmscrtemppage2.H
 * Author:	Dave Humphrey (uesp@m0use.net)
 * Created On:	October 8, 2003
 *
 * Description
 *
 *=========================================================================*/
#ifndef __ESMSCRTEMPPAGE2_H
#define __ESMSCRTEMPPAGE2_H


/*===========================================================================
 *
 * Begin Required Includes
 *
 *=========================================================================*/
  #include "dl_err.h"
  #include "EsmDlgArray.h"
/*===========================================================================
 *		End of Required Includes
 *=========================================================================*/


/*===========================================================================
 *
 * Begin Class CEsmScrTempPage2 Definition
 *
 *=========================================================================*/
class CEsmScrTempView;

class CEsmScrTempPage2 : public CPropertyPage {
  DECLARE_DYNCREATE(CEsmScrTempPage2);

  /*---------- Begin Protected Class Members ---------------------------*/
protected:
  CEsmDlgHandler*	m_pDlgHandler;		/* Parent dialog handler */
  CEsmScrTempView*	m_pParentView;


  /*---------- Begin Protected Class Methods ---------------------------*/
protected:


  /*---------- Begin Public Class Methods ------------------------------*/
public:

	/* Constructor and Destructor */
  CEsmScrTempPage2();
  ~CEsmScrTempPage2();

	/* Set class members */
  void SetDlgHandler (CEsmDlgHandler* pHandler) { m_pDlgHandler = pHandler; }
  void SetParentView (CEsmScrTempView* pView)    { m_pParentView = pView; }

	/* Update the page controls */
  void UpdatePage (void);
  void UpdateText (void);

	/* Dialog Data */
  //{{AFX_DATA(CEsmScrTempPage2)
  enum { IDD = IDD_SCRTEMP_PAGE2 };
  CEdit		m_TemplateText;
  //}}AFX_DATA

	/* ClassWizard generate virtual function overrides */
  //{{AFX_VIRTUAL(CEsmScrTempPage2)
protected:
  virtual void DoDataExchange(CDataExchange* pDX);
  //}}AFX_VIRTUAL

protected:

	/* Generated message map functions */
  //{{AFX_MSG(CEsmScrTempPage2)
  //}}AFX_MSG

  DECLARE_MESSAGE_MAP();

 };
/*===========================================================================
 *		End of Class CEsmScrTempPage2 Definition
 *=========================================================================*/


//{{AFX_INSERT_LOCATION}}
//}}AFX_INSERT_LOCATION


#endif
/*===========================================================================
 *		End of File Esmscrtemppage2.H
 *=========================================================================*/

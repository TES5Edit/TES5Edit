/*===========================================================================
 *
 * File:	Esmscrtemppage1.H
 * Author:	Dave Humphrey (uesp@m0use.net)
 * Created On:	October 8, 2003
 *
 * Description
 *
 *=========================================================================*/
#ifndef __ESMSCRTEMPPAGE1_H
#define __ESMSCRTEMPPAGE1_H


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
 * Begin Definitions
 *
 *=========================================================================*/

	/* String sizes */
  #define ESMSCRTEMP_SCRIPTNAMESIZE 24

/*===========================================================================
 *		End of Definitions
 *=========================================================================*/


/*===========================================================================
 *
 * Begin Class CEsmScrTempPage1 Definition
 *
 *=========================================================================*/
class CEsmScrTempView;

class CEsmScrTempPage1 : public CPropertyPage {
  DECLARE_DYNCREATE(CEsmScrTempPage1);

  /*---------- Begin Public Class Members ----------------------------*/
protected:
  CEsmDlgHandler*	m_pDlgHandler;		/* Parent dialog handler */
  CEsmScrTempView*	m_pParentView;


  /*---------- Begin Public Class Methods ----------------------------*/
protected:


  /*---------- Begin Public Class Methods ----------------------------*/
public:

	/* Constructor/destructor */
  CEsmScrTempPage1();
  ~CEsmScrTempPage1();

	/* Update the template variable list */
  void FillTempVarList (void);

	/* Save the control data */
  void GetControlData (void);

	  /* Set class members */
  void SetDlgHandler (CEsmDlgHandler*  pHandler) { m_pDlgHandler = pHandler; }
  void SetParentView (CEsmScrTempView* pView)    { m_pParentView = pView; }

	/* Update the page controls */
  void UpdatePage (void);


	/* Dialog Data */
  //{{AFX_DATA(CEsmScrTempPage1)
	enum { IDD = IDD_SCRTEMP_PAGE1 };
	CEdit	m_ScriptName;
	CButton	m_AutoScriptName;
  CButton	m_OnlyCompleteRows;
  CButton	m_KeepQuotes;
  CEdit		m_CsvFile;
  CEdit		m_TemplateFile;
  CListBox	m_TemplateList;
	//}}AFX_DATA

	/* ClassWizard generate virtual function overrides */
  //{{AFX_VIRTUAL(CEsmScrTempPage1)
protected:
  virtual void DoDataExchange(CDataExchange* pDX);
  //}}AFX_VIRTUAL

protected:

	/* Generated message map functions */
  //{{AFX_MSG(CEsmScrTempPage1)
  afx_msg void OnLoadscrtemp();
  afx_msg void OnUpdatetext();
  afx_msg void OnLoadcsv();
  afx_msg void OnReloadscrtemp();
  afx_msg void OnReloadcsvfile();
  afx_msg void OnAutoscriptname();
  virtual BOOL OnInitDialog();
  afx_msg void OnCheckTemplate();
  afx_msg void OnCreateTemplate();
  //}}AFX_MSG

  DECLARE_MESSAGE_MAP();

 };
/*===========================================================================
 *		End of Class CEsmScrTempPage1 Definition
 *=========================================================================*/


//{{AFX_INSERT_LOCATION}}
//}}AFX_INSERT_LOCATION


#endif
/*===========================================================================
 *		End of File Esmscrtemppage1.H
 *=========================================================================*/

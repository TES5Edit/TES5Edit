/*===========================================================================
 *
 * File:	EsmScrTempPage3.H
 * Author:	Dave Humphrey (uesp@m0use.net)
 * Created On:	October 8, 2003
 *
 * Description
 *
 *=========================================================================*/
#ifndef __ESMSCRTEMPPAGE3_H
#define __ESMSCRTEMPPAGE3_H


/*===========================================================================
 *
 * Begin Required Includes
 *
 *=========================================================================*/
  #include "dl_err.h"
  #include "EsmDlgArray.h"
  #include "file/CsvFile.h"
/*===========================================================================
 *		End of Required Includes
 *=========================================================================*/


/*===========================================================================
 *
 * Begin Definitions
 *
 *=========================================================================*/

	/* Default list column width */
  #define ESMSCRTEMP_CSVLIST_COLWIDTH	80

/*===========================================================================
 *		End of Definitions
 *=========================================================================*/


/*===========================================================================
 *
 * Begin Class CEsmScrTempPage3 Definition
 *
 *=========================================================================*/
class CEsmScrTempView;

class CEsmScrTempPage3 : public CPropertyPage {
  DECLARE_DYNCREATE(CEsmScrTempPage3);

  /*---------- Begin Protected Class Members ---------------------------*/
protected:
  CEsmDlgHandler*	m_pDlgHandler;		/* Parent dialog handler */
  CEsmScrTempView*	m_pParentView;
  int			m_NumColumns;


  /*---------- Begin Protected Class Methods ---------------------------*/
protected:

	/* Add columns to the list control */
  bool AddCsvColumns (CCsvFile* pCsvFile);

	/* Deletes all items and columns in the csv list */
  void ClearCsvList (void);


  /*---------- Begin Public Class Methods ------------------------------*/
public:

	/* Constructor and Destructor */
  CEsmScrTempPage3();
  ~CEsmScrTempPage3();

	/* Fills the CSV list with its contents */
  bool FillCsvList (CCsvFile* pCsvFile);

	/* Set class members */
  void SetDlgHandler (CEsmDlgHandler* pHandler) { m_pDlgHandler = pHandler; }
  void SetParentView (CEsmScrTempView* pView)    { m_pParentView = pView; }

	/* Update the page controls */
  void UpdatePage (void);

	/* Dialog Data */
  //{{AFX_DATA(CEsmScrTempPage3)
  enum { IDD = IDD_SCRTEMP_PAGE3 };
  CListCtrl	m_CsvList;
  //}}AFX_DATA

	/* ClassWizard generate virtual function overrides */
  //{{AFX_VIRTUAL(CEsmScrTempPage3)
protected:
  virtual void DoDataExchange(CDataExchange* pDX);
  //}}AFX_VIRTUAL

protected:

	/* Generated message map functions */
  //{{AFX_MSG(CEsmScrTempPage3)
	virtual BOOL OnInitDialog();
	//}}AFX_MSG

  DECLARE_MESSAGE_MAP();

 };
/*===========================================================================
 *		End of Class CEsmScrTempPage3 Definition
 *=========================================================================*/


//{{AFX_INSERT_LOCATION}}
//}}AFX_INSERT_LOCATION


#endif
/*===========================================================================
 *		End of File EsmScrTempPage3.H
 *=========================================================================*/

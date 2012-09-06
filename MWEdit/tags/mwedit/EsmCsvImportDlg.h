/*===========================================================================
 *
 * File:	Esmcsvimportdlg.H
 * Author:	Dave Humphrey (uesp@m0use.net)
 * Created On:	October 13, 2003
 *
 * Description
 *
 *=========================================================================*/
#ifndef __ESMCSVIMPORTDLG_H
#define __ESMCSVIMPORTDLG_H


/*===========================================================================
 *
 * Begin Required Includes
 *
 *=========================================================================*/
  #include "EsmCsvDefs.h"
/*===========================================================================
 *		End of Required Includes
 *=========================================================================*/


/*===========================================================================
 *
 * Begin Definitions
 *
 *=========================================================================*/

	/* List definitions */
  #define ESMCSVIMP_LIST_COLWIDTH 80

	/* Csv file definitions */
  #define ESMCSVIMP_CSV_EXT		_T("csv")
  #define ESMCSVIMP_CSV_FILTER		_T("CSV Files (*.csv)|*.csv|Text Files (*.txt)|*.txt|All Files (*.*)|*.*||")
  
/*===========================================================================
 *		End of Definitions
 *=========================================================================*/


/*===========================================================================
 *
 * Begin Class CEsmCsvImportDlg Definition
 *
 *=========================================================================*/
class CMWEditDoc;

class CEsmCsvImportDlg : public CDialog {


  /*---------- Begin Protected Class Members ------------------*/
protected:
  CCsvFile	m_CsvFile;		/* Csv file object */
  CMWEditDoc*   m_pDocument;		/* Reference to parent document */
  int		m_CreatedRecords;

  int		m_IDColIndex;		/* Special column indices */
  int		m_TypeColIndex;


  /*---------- Begin Protected Class Methods ------------------*/
protected:

   

  /*---------- Begin Public Class Methods ---------------------*/
public:

        /* Protected constructor used by dynamic creation */
  CEsmCsvImportDlg(CWnd* pParent);
  virtual ~CEsmCsvImportDlg();

	/* Checks the validity of the current data */
  bool CheckData (void);
  bool CheckRow  (const int RowIndex);

	/* Helper methods to create new records */
  bool CreateRecords (void);
  bool CreateRecord  (CCsvRow* pRow);

	/* Update the list control */
  void ClearCsvList (void);
  void FillCsvList  (void);

	/* Look for special column names */
  bool FindColumns (void);

	/* Prompts user and loads CSV file if required */
  bool LoadCsvFile (void);

	/* Set control data */
  void SetControlData (void);
  void SetDocument    (CMWEditDoc* pDoc) { m_pDocument = pDoc; }


  //{{AFX_DATA(CEsmCsvImportDlg)
  enum { IDD = IDD_IMPORTCSV_DLG };
  CListCtrl	m_CsvList;
  CEdit		m_CsvFilename;
  //}}AFX_DATA

public:

	/* ClassWizard generated virtual function overrides */
  //{{AFX_VIRTUAL(CEsmCsvImportDlg)
protected:
  virtual void DoDataExchange(CDataExchange* pDX);
  //}}AFX_VIRTUAL

protected:

	/* Generated message map functions */
  //{{AFX_MSG(CEsmCsvImportDlg)
  afx_msg void OnLoadcsvbutton();
  afx_msg void OnCreatebutton();
	virtual BOOL OnInitDialog();
	//}}AFX_MSG

  DECLARE_MESSAGE_MAP();

 };
/*===========================================================================
 *		End of Class CEsmCsvImportDlg Definition
 *=========================================================================*/


//{{AFX_INSERT_LOCATION}}
//}}AFX_INSERT_LOCATION


#endif
/*===========================================================================
 *		End of File Esmcsvimportdlg.H
 *=========================================================================*/

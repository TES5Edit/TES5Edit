/*===========================================================================
 *
 * File:	Nifcopydlg.H
 * Author:	Dave Humphrey (uesp@m0use.net)
 * Created On:	October 19, 2003
 *
 * Description
 *
 *=========================================================================*/
#ifndef __NIFCOPYDLG_H
#define __NIFCOPYDLG_H


/*===========================================================================
 *
 * Begin Required Includes
 *
 *=========================================================================*/
  #include "csvfile.h"
  #include "Niffile.h"
  #include "ptrarray.h"
  #include "NifSourceTexture.h"
  #include "NifMaterialProperty.h"
/*===========================================================================
 *		End of Required Includes
 *=========================================================================*/


/*===========================================================================
 *
 * Begin Definitions
 *
 *=========================================================================*/

	/* File filters and extensions */
  #define NIFCOPY_NIF_EXT	_T("nif")
  #define NIFCOPY_CSV_EXT	_T("csv")
  #define NIFCOPY_NIF_FILTER	_T("NIF Files (*.nif)|*.nif|All Files (*.*)|*.*||")
  #define NIFCOPY_CSV_FILTER	_T("CSV Files (*.csv)|*.csv|Text Files (*.txt)|*.txt|All Files (*.*)|*.*||")

	/* List options */
  #define NIFCOPY_LIST_INDEXWIDTH	25
  #define NIFCOPY_LIST_COLWIDTH		100

	/* Csv file columns */
  #define NIFCOPY_CSV_FILENAME	_T("Filename")

/*===========================================================================
 *		End of Definitions
 *=========================================================================*/


/*===========================================================================
 *
 * Begin Type Definitions
 *
 *=========================================================================*/

	/* Holds information on a single source texture record */
  class CNifCopyInfo {
    public:
	CNifMaterialProperty*   pMaterialProperty;	
	CNifSourceTexture*	pSourceTexture;		/* Source texture record */
	CSString		OrigTexture;		/* Original texture name */		
	int			CsvColIndex;		/* Index in the CSV file */
   };

	/* Pointer array of info records */
  typedef TPtrArray<CNifCopyInfo> CNifCopyInfoArray;
   	 
/*===========================================================================
 *		End of Type Definitions
 *=========================================================================*/


/*===========================================================================
 *
 * Begin Class CNifCopyDlg Definition
 *
 *=========================================================================*/
class CNifCopyDlg : public CDialog {

  /*---------- Begin Protected Class Members -------------------------*/
protected:
  CCsvFile		m_CsvFile;		/* Csv input file data */
  CNifFile		m_NifFile;		/* Nif input/output file data */
  CString		m_InputCsv;		/* Csv input filename */
  CString		m_InputNif;		/* Nif input filename */

  bool			m_OverWriteFiles;	/* Options */

  CNifCopyInfoArray	m_CopyInfos;		/* Array of copy info records */
  int			m_FilenameColIndex;

  int			m_CreatedFiles;
	

  /*---------- Begin Protected Class Methods -------------------------*/
protected:
  
	/* Attempt to add a new copy info record */
  CNifCopyInfo* AddCopyInfo (void);

	/* Check the validity of the current data */
  bool CheckData       (void);
  bool CheckCsvColumns (void);

	/* Delete all allocated copy info records */
  void ClearCopyInfos  (void);

	/* Create the copy info records */
  bool CreateCopyInfos (void);

	/* Update the contents of the csv list */
  void ClearCsvList     (void);
  void CreateCsvColumns (void);
  void FillCsvList      (void);

	/* Create the nif files */
  bool CreateFiles    (void);
  bool CreateFile     (CCsvRow* pRow);
  void ResetInputNif  (void);
  bool UpdateTextures (CCsvRow* pRow);

	/* Update the contents of the texture list */
  void FillTextureList  (void);
  

  /*---------- Begin Public Class Methods ----------------------------*/
public:

	/* Construction */
  CNifCopyDlg(CWnd* pParent = NULL);
  ~CNifCopyDlg();

	/* Set/get the control data */
  void GetControlData (void);
  void SetControlData (void);

	/* Dialog Data */
  //{{AFX_DATA(CNifCopyDlg)
  enum { IDD = IDD_NIFCOPY_DLG };
  CListBox	m_TextureList;
  CListCtrl	m_CsvList;
  CButton	m_OverwriteCheck;
  CEdit		m_CsvFilename;
  CEdit		m_NifFilename;
  //}}AFX_DATA

	/* ClassWizard generated virtual function overrides */
  //{{AFX_VIRTUAL(CNifCopyDlg)
protected:
  virtual void DoDataExchange(CDataExchange* pDX);
  //}}AFX_VIRTUAL

protected:

	/* Generated message map functions */
  //{{AFX_MSG(CNifCopyDlg)
  afx_msg void OnNifloadButton();
  afx_msg void OnCsvloadButton();
  afx_msg void OnNifcopyCreate();
  afx_msg void OnNifcopyCheck();
  virtual BOOL OnInitDialog();
  //}}AFX_MSG

  DECLARE_MESSAGE_MAP();

 };
/*===========================================================================
 *		End of Class CNifCopyDlg Definition
 *=========================================================================*/


//{{AFX_INSERT_LOCATION}}
//}}AFX_INSERT_LOCATION


#endif
/*===========================================================================
 *		End of File Nifcopydlg.H
 *=========================================================================*/


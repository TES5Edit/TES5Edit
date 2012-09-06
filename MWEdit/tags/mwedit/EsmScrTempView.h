/*===========================================================================
 *
 * File:	Esmscrtempview.H
 * Author:	Dave Humphrey (uesp@m0use.net)
 * Created On:	October 8, 2003
 *
 * Description
 *
 *=========================================================================*/
#ifndef __ESMSCRTEMPVIEW_H
#define __ESMSCRTEMPVIEW_H


/*===========================================================================
 *
 * Begin Required Includes
 *
 *=========================================================================*/
  #include "dl_err.h"
  #include "windows/TabCtrlSheet.h"
  #include "EsmScrTempPage1.h"
  #include "EsmScrTempPage2.h"
  #include "EsmScrTempPage3.h"
  #include "ScriptTemplate.h"
  #include "file/CsvFile.h"
/*===========================================================================
 *		End of Required Includes
 *=========================================================================*/


/*===========================================================================
 *
 * Begin Definitions
 *
 *=========================================================================*/

	/* Csv file definitions */
  #define ESMSCRTEMP_CSV_EXT		_T("csv")
  #define ESMSCRTEMP_CSV_FILTER		_T("CSV Files (*.csv)|*.csv|Text Files (*.txt)|*.txt|All Files (*.*)|*.*||")
  

/*===========================================================================
 *		End of Definitions
 *=========================================================================*/


/*===========================================================================
 *
 * Begin Type Definitions
 *
 *=========================================================================*/

	/* Template options */
  typedef struct {
	bool	OnlyCompleteRows;	/* Ignore any incomplete row */
	bool	KeepQuotes;		/* Keep quotes in CSV files */
	bool	AutoScriptName;		/* Auto name scripts */
	TCHAR	ScriptName[ESMSCRTEMP_SCRIPTNAMESIZE+1];

	void SetScriptName (const TCHAR* pString) { strnncpy(ScriptName, pString, ESMSCRTEMP_SCRIPTNAMESIZE); }
   } esmscrtempoptions_t;

/*===========================================================================
 *		End of Type Definitions
 *=========================================================================*/


/*===========================================================================
 *
 * Begin Class CEsmScrTempView Definition
 *
 *=========================================================================*/
class CEsmScrTempView;
class CMWEditDoc;

class CEsmScrTempView : public CFormView {

  /*---------- Begin Protected Class Members -------------------------*/
protected:
  CEsmDlgHandler*	m_pDlgHandler;		/* Parent dialog handler */
  CMWEditDoc*		m_pDocument;		/* Parent document */

  CEsmScriptTemplate	m_ScriptTemplate;	/* Handles the template files */
  CCsvFile		m_CsvFile;		/* Csv file for the variable list */
  esmscrtempoptions_t	m_Options;

  CEsmScrTempPage1	m_Page1;		/* Tab control pages */
  CEsmScrTempPage2	m_Page2;
  CEsmScrTempPage3	m_Page3;

  int			m_CreatedScripts;	/* Used during script creation */
  CString		m_NewScriptText;

  HACCEL		m_hAccelerator;


  /*---------- Begin Protected Class Methods -------------------------*/
protected:

	/* Class Constructor */
  CEsmScrTempView();
  DECLARE_DYNCREATE(CEsmScrTempView);


public:
  //{{AFX_DATA(CEsmScrTempView)
  enum { IDD = IDD_SCRTEMPLATE_DLG };
  CTabCtrlSheet	m_TabControl;
  //}}AFX_DATA


  /*---------- Begin Public Class Methods ---------------------------*/
public:

	/* Checks the current template options to see if they are valid */
  bool CheckTemplate     (void);
  bool CheckTemplateFile (void);
  bool CheckCsvFile      (void);

	/* Creates the required scripts */
  bool CreateScripts   (void);
  bool CreateScript    (CCsvRow* pRow);
  bool ParseScriptText (CCsvRow* pRow, const TCHAR* pScriptName);
  
	/* Get class members */
  CEsmScriptTemplate*	GetScriptTemplate (void) { return (&m_ScriptTemplate); }
  CCsvFile*		GetCsvFile	  (void) { return (&m_CsvFile); }
  esmscrtempoptions_t*  GetOptions	  (void) { return (&m_Options); }

	/* Check if we have files */
  bool HasCsvFile      (void);
  bool HasTemplateFile (void);

	/* Update the class members from the controls */
  void GetControlData (void);

	/* Get or create the script name */
  const TCHAR* MakeScriptName (CCsvRow* pRow);

	/* Events */
  void OnLoadTemplate   (void);
  void OnUpdateText     (void);
  void OnReloadCsvFile  (void);
  void OnReloadScrTemp  (void);
  void OnCreateTemplate (void);
  void OnCheckTemplate  (void);

	/* Set class members */
  void SetDlgHandler (CEsmDlgHandler* pHandler) { m_pDlgHandler = pHandler; }
  void SetDocument   (CMWEditDoc*     pDoc)     { m_pDocument   = pDoc; }

	/* Updates the csv column indices for the template variables */
  bool UpdateColIndices (void);

	/* ClassWizard generated virtual function overrides */
  //{{AFX_VIRTUAL(CEsmScrTempView)
public:
  virtual void OnInitialUpdate();
  virtual BOOL PreTranslateMessage(MSG* pMsg);
protected:
  virtual void DoDataExchange(CDataExchange* pDX);
  //}}AFX_VIRTUAL

protected:
  virtual ~CEsmScrTempView();

#ifdef _DEBUG
  virtual void AssertValid() const;
  virtual void Dump(CDumpContext& dc) const;
#endif

	/* Generated message map functions */
public:
  //{{AFX_MSG(CEsmScrTempView)
  afx_msg void OnDestroy();
  afx_msg void OnScrtempLoadcsv();
  afx_msg void OnEditCopy();
  afx_msg void OnEditCut();
  afx_msg void OnEditPaste();
  //}}AFX_MSG

  DECLARE_MESSAGE_MAP();

 };
/*===========================================================================
 *		End of Class CEsmScrTempView Definition
 *=========================================================================*/


//{{AFX_INSERT_LOCATION}}
//}}AFX_INSERT_LOCATION


#endif
/*===========================================================================
 *		End of File Esmscrtempview.H
 *=========================================================================*/


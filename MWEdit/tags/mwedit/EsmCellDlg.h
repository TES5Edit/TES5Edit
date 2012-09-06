/*===========================================================================
 *
 * File:	Esmcelldlg.H
 * Author:	Dave Humphrey (uesp@m0use.net)
 * Created On:	February 21, 2003
 *
 * Description
 *
 *=========================================================================*/
#ifndef __ESMCELLDLG_H
#define __ESMCELLDLG_H


/*===========================================================================
 *
 * Begin Required Includes
 *
 *=========================================================================*/
  #include "EsmRecDialog.h"
  #include "Resource.h"
  #include "EsmIntCellPage.h"
  #include "EsmExtCellPage.h"
  #include "EsmRefCellPage.h"
  #include "windows/TabCtrlSheet.h"
/*===========================================================================
 *		End of Required Includes
 *=========================================================================*/


/*===========================================================================
 *
 * Begin Class CEsmCellDlg Definition
 *
 *=========================================================================*/
class CEsmCellDlg : public CEsmRecDialog {
  DECLARE_DYNCREATE(CEsmCellDlg);

  /*---------- Begin Protected Class Members ------------------------*/
protected:
  CEsmIntCellPage	m_IntCellPage;		/* Tab control pages */
  CEsmExtCellPage	m_ExtCellPage;
  CEsmRefCellPage	m_RefCellPage;

  CEsmCell*		m_pCell;


  /*---------- Begin Protected Class Methods ------------------------*/
protected:

	/* Update modified items during edit */
  virtual int OnUpdateItem (esmrecinfo_t* pRecInfo);


  /*---------- Begin Public Class Methods ---------------------------*/
public:

	/* Construction */
  CEsmCellDlg();

  	/* Get class members */
  virtual bool IsModified (void);
	
  	/* Set or update the record data */
  virtual void GetControlData (void);
  virtual void SetControlData (void);

	/* Dialog Data */
  //{{AFX_DATA(CEsmCellDlg)
	enum { IDD = IDD_CELL_DLG };
	CEdit	m_GridText;
  CTabCtrlSheet	m_TabControl;
	//}}AFX_DATA

	/* ClassWizard generated virtual function overrides */
  //{{AFX_VIRTUAL(CEsmCellDlg)
protected:
  virtual void OnInitialUpdate();
  virtual void DoDataExchange(CDataExchange* pDX);
  //}}AFX_VIRTUAL

protected:

	/* Generated message map functions */
  //{{AFX_MSG(CEsmCellDlg)
  //}}AFX_MSG
 
  DECLARE_MESSAGE_MAP();

 };
/*===========================================================================
 *		End of Class CEsmCellDlg Definition
 *=========================================================================*/


//{{AFX_INSERT_LOCATION}}
//}}AFX_INSERT_LOCATION


#endif
/*===========================================================================
 *		End of File Esmcelldlg.H
 *=========================================================================*/

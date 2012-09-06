/*===========================================================================
 *
 * File:	Esmcellrefdlg.H
 * Author:	Dave Humphrey (uesp@m0use.net)
 * Created On:	February 22, 2003
 *
 * Description
 *
 *=========================================================================*/
#ifndef __ESMCELLREFDLG_H
#define __ESMCELLREFDLG_H


/*===========================================================================
 *
 * Begin Required Includes
 *
 *=========================================================================*/
  #include "EsmSubCellRef.h"
  #include "EsmCell.h"
  #include "contain/ptrarray.h"
/*===========================================================================
 *		End of Required Includes
 *=========================================================================*/


/*===========================================================================
 *
 * Begin Type Definitions
 *
 *=========================================================================*/
/*===========================================================================
 *		End of Type Definitions
 *=========================================================================*/


/*===========================================================================
 *
 * Begin Class CEsmCellRefDlg Definition
 *
 *=========================================================================*/
class CEsmCellRefDlg : public CDialog {

  /*---------- Protected Class Members ----------------------------*/
protected:
  CEsmSubCellRef*	m_pCellRef;	/* The cell reference we are editting */
  CEsmCell*		m_pCell;
  bool			m_HasNewCellRef;
  bool			m_IsAlreadyNew;


  /*---------- Public Class Methods -------------------------------*/
public:

	/* Construction */
  CEsmCellRefDlg(CWnd* pParent = NULL); 

	/* Main access method */
  bool DoModal (CEsmSubCellRef* pCellRef, const bool IsNew, CEsmCell* pCell);

	/* Get class members */
  bool		  HasNewCellRef (void) { return (m_HasNewCellRef); }
  CEsmSubCellRef* GetCellRef    (void) { return (m_pCellRef); }

	/* Set/get control data */
  void GetControlData (void);
  void SetControlData (void);

	/* Dialog Data */
  //{{AFX_DATA(CEsmCellRefDlg)
  enum { IDD = IDD_CELLREF_DLG };
  CEdit		m_ScaleText;
  CEdit		m_ZRotText;
  CEdit		m_YRotText;
  CEdit		m_XRotText;
  CEdit		m_ZPosText;
  CEdit		m_YPosText;
  CEdit		m_XPosText;
  //}}AFX_DATA

	/* ClassWizard generated virtual function overrides */
  //{{AFX_VIRTUAL(CEsmCellRefDlg)
protected:
  virtual void DoDataExchange(CDataExchange* pDX);
  //}}AFX_VIRTUAL

// Implementation
protected:

	/* Generated message map functions */
  //{{AFX_MSG(CEsmCellRefDlg)
  virtual void OnOK();
  virtual void OnCancel();
	virtual BOOL OnInitDialog();
	//}}AFX_MSG

  DECLARE_MESSAGE_MAP();

};
/*===========================================================================
 *		End of Class CEsmCellRefDlg Definition
 *=========================================================================*/


//{{AFX_INSERT_LOCATION}}
//}}AFX_INSERT_LOCATION


#endif
/*===========================================================================
 *		End of File Esmcellrefdlg.H
 *=========================================================================*/

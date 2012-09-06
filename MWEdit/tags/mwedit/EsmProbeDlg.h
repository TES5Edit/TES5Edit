/*===========================================================================
 *
 * File:	Esmprobedlg.H
 * Author:	Dave Humphrey (uesp@m0use.net)
 * Created On:	February 16, 2003
 *
 * Description
 *
 *=========================================================================*/
#ifndef __ESMPROBEDLG_H
#define __ESMPROBEDLG_H


/*===========================================================================
 *
 * Begin Required Includes
 *
 *=========================================================================*/
  #include "EsmRecDialog.h"
  #include "Resource.h"
/*===========================================================================
 *		End of Required Includes
 *=========================================================================*/


/*===========================================================================
 *
 * Begin Class CEsmProbeDlg Definition
 *
 *=========================================================================*/
class CEsmProbeDlg : public CEsmRecDialog {
  DECLARE_DYNCREATE(CEsmProbeDlg);

  /*---------- Begin Protected Class Members ------------------------*/
protected:
  CEsmProbe*	m_pProbe;


  /*---------- Begin Protected Class Methods ------------------------*/
protected:

	/* Update item data */
  virtual int OnUpdateItem (esmrecinfo_t* pRecInfo);


  /*---------- Begin Public Class Methods ---------------------------*/
public:

	/* Construction */
  CEsmProbeDlg();

	/* Get class members */
  virtual bool IsModified (void);
  
  	/* Set or update the record data */
  virtual void GetControlData (void);
  virtual void SetControlData (void);
	
	/* Dialog Data */
  //{{AFX_DATA(CEsmProbeDlg)
  enum { IDD = IDD_PROBE_DLG };
  CButton	m_PersistCheck;
  CButton	m_BlockedCheck;
  CEdit		m_ValueText;
  CEdit		m_QualityText;
  CEdit		m_WeightText;
  CEdit		m_UsesText;
  CEdit		m_NameText;
  //}}AFX_DATA

	/* ClassWizard generated virtual function overrides */
  //{{AFX_VIRTUAL(CEsmProbeDlg)
protected:
  virtual void OnInitialUpdate();
  virtual void DoDataExchange(CDataExchange* pDX);
  //}}AFX_VIRTUAL

protected:

	/* Generated message map functions */
  //{{AFX_MSG(CEsmProbeDlg)
  //}}AFX_MSG
  
  DECLARE_MESSAGE_MAP();

 };
/*===========================================================================
 *		End of Class CEsmProbeDlg Definition
 *=========================================================================*/


//{{AFX_INSERT_LOCATION}}
//}}AFX_INSERT_LOCATION


#endif
/*===========================================================================
 *		End of File Esmprobedlg.H
 *=========================================================================*/

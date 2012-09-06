/*===========================================================================
 *
 * File:	Esmapparatusdlg.H
 * Author:	Dave Humphrey (uesp@m0use.net)
 * Created On:	February 10, 2003
 *
 * Description
 *
 *=========================================================================*/
#ifndef __ESMAPPARATUSDLG_H
#define __ESMAPPARATUSDLG_H


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
 * Begin Class CEsmApparatusDlg Definition
 *
 *=========================================================================*/
class CEsmApparatusDlg : public CEsmRecDialog {
  DECLARE_DYNCREATE(CEsmApparatusDlg);

  /*---------- Begin Protected Class Members ------------------------*/
protected:
  CEsmApparatus*	m_pApparatus;


  /*---------- Begin Protected Class Methods ------------------------*/
protected:

	/* Update item data */
  virtual int OnUpdateItem (esmrecinfo_t* pRecInfo);


  /*---------- Begin Public Class Methods ---------------------------*/
public:

	/* Construction */
  CEsmApparatusDlg();

	/* Get class members */
  virtual bool IsModified (void);
  
  	/* Set or update the record data */
  virtual void GetControlData (void);
  virtual void SetControlData (void);
	
	/* Dialog Data */
  //{{AFX_DATA(CEsmApparatusDlg)
  enum { IDD = IDD_APPARATUS_DLG };
  CButton	m_PersistCheck;
  CButton	m_BlockedCheck;
  CEdit		m_ValueText;
  CEdit		m_QualityText;
  CEdit		m_WeightText;
  CComboBox	m_TypeList;
  CEdit		m_NameText;
  //}}AFX_DATA

	/* ClassWizard generated virtual function overrides */
  //{{AFX_VIRTUAL(CEsmApparatusDlg)
protected:
  virtual void OnInitialUpdate();
  virtual void DoDataExchange(CDataExchange* pDX);
  //}}AFX_VIRTUAL

protected:

	/* Generated message map functions */
  //{{AFX_MSG(CEsmApparatusDlg)
  //}}AFX_MSG
  
  DECLARE_MESSAGE_MAP();

 };
/*===========================================================================
 *		End of Class CEsmApparatusDlg Definition
 *=========================================================================*/


//{{AFX_INSERT_LOCATION}}
//}}AFX_INSERT_LOCATION


#endif
/*===========================================================================
 *		End of File Esmapparatusdlg.H
 *=========================================================================*/

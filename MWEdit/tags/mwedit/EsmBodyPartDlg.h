/*===========================================================================
 *
 * File:	Esmbodypartdlg.H
 * Author:	Dave Humphrey (uesp@m0use.net)
 * Created On:	February 12, 2003
 *
 * Description
 *
 *=========================================================================*/
#ifndef __ESMBODYPARTDLG_H
#define __ESMBODYPARTDLG_H


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
 * Begin Class CEsmBodyPartDlg Definition
 *
 *=========================================================================*/
class CEsmBodyPartDlg : public CEsmRecDialog {
  DECLARE_DYNCREATE(CEsmBodyPartDlg);

  /*---------- Begin Protected Class Members ------------------------*/
protected:
  CEsmBodyPart*		m_pBodyPart;

  /*---------- Begin Protected Class Methods ------------------------*/
protected:


  /*---------- Begin Public Class Methods ---------------------------*/
public:

	/* Construction */
  CEsmBodyPartDlg();

	/* Get class members */
  virtual bool IsModified (void);
  
  	/* Set or update the record data */
  virtual void GetControlData (void);
  virtual void SetControlData (void);
	
	/* Dialog Data */
  //{{AFX_DATA(CEsmBodyPartDlg)
  enum { IDD = IDD_BODYPART_DLG };
  CButton	m_VampireCheck;
  CButton	m_FemaleCheck;
  CButton	m_PlayableCheck;
  CComboBox	m_RaceList;
  CComboBox	m_PartTypeList;
  CComboBox	m_PartList;
  CButton	m_BlockedCheck;
	//}}AFX_DATA

	/* ClassWizard generated virtual function overrides */
  //{{AFX_VIRTUAL(CEsmBodyPartDlg)
protected:
  virtual void OnInitialUpdate();
  virtual void DoDataExchange(CDataExchange* pDX);
  //}}AFX_VIRTUAL

protected:

	/* Generated message map functions */
  //{{AFX_MSG(CEsmBodyPartDlg)
	afx_msg void OnSelchangeParttypelist();
	afx_msg void OnSelchangeList();
	afx_msg void OnVampirecheck();
	//}}AFX_MSG
 
  DECLARE_MESSAGE_MAP();

 };
/*===========================================================================
 *		End of Class CEsmBodyPartDlg Definition
 *=========================================================================*/


#endif
/*===========================================================================
 *		End of File Esmbodypartdlg.H
 *=========================================================================*/

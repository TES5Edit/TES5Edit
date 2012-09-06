/*===========================================================================
 *
 * File:	Esmskilldlg.H
 * Author:	Dave Humphrey (uesp@m0use.net)
 * Created On:	February 18, 2003
 *
 * Description
 *
 *=========================================================================*/
#ifndef __ESMSKILLDLG_H
#define __ESMSKILLDLG_H


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
 * Begin Class CEsmSkillDlg Definition
 *
 *=========================================================================*/
class CEsmSkillDlg : public CEsmRecDialog {
  DECLARE_DYNCREATE(CEsmSkillDlg);

  /*---------- Begin Protected Class Members ------------------------*/
protected:
  CEsmSkill*	m_pSkill;


  /*---------- Begin Protected Class Methods ------------------------*/
protected:



  /*---------- Begin Public Class Methods ---------------------------*/
public:

	/* Construction */
  CEsmSkillDlg();

  	/* Get class members */
  virtual bool IsModified (void);
	
  	/* Set or update the record data */
  virtual void GetControlData (void);
  virtual void SetControlData (void);

	/* Dialog Data */
  //{{AFX_DATA(CEsmSkillDlg)
	enum { IDD = IDD_SKILL_DLG };
	CEdit	m_ValueText4;
	CEdit	m_ValueText3;
	CEdit	m_ValueText2;
	CEdit	m_ActionText4;
	CEdit	m_ActionText3;
	CEdit	m_ActionText2;
	CEdit	m_ValueText1;
	CEdit	m_ActionText1;
	CEdit	m_DescText;
	CComboBox	m_SpecialList;
	CComboBox	m_AttributeList;
	CEdit	m_NameText;
	//}}AFX_DATA

	/* ClassWizard generated virtual function overrides */
  //{{AFX_VIRTUAL(CEsmSkillDlg)
protected:
  virtual void OnInitialUpdate();
  virtual void DoDataExchange(CDataExchange* pDX);
  //}}AFX_VIRTUAL

protected:

	/* Generated message map functions */
  //{{AFX_MSG(CEsmSkillDlg)
  //}}AFX_MSG

  DECLARE_MESSAGE_MAP();

 };
/*===========================================================================
 *		End of Class CEsmSkillDlg Definition
 *=========================================================================*/


//{{AFX_INSERT_LOCATION}}
//}}AFX_INSERT_LOCATION


#endif
/*===========================================================================
 *		End of File Esmskilldlg.H
 *=========================================================================*/

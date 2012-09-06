/*===========================================================================
 *
 * File:	Esmsoundgendlg.H
 * Author:	Dave Humphrey (uesp@m0use.net)
 * Created On:	February 19, 2003
 *
 * Description
 *
 *=========================================================================*/
#ifndef __ESMSOUNDGENDLG_H
#define __ESMSOUNDGENDLG_H


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
 * Begin Class CEsmSoundGenDlg Definition
 *
 *=========================================================================*/
class CEsmSoundGenDlg : public CEsmRecDialog {
  DECLARE_DYNCREATE(CEsmSoundGenDlg);

  /*---------- Begin Protected Class Members ------------------------*/
protected:
  CEsmSoundGen*	m_pSoundGen;


  /*---------- Begin Protected Class Methods ------------------------*/
protected:

	/* Update item data */
  virtual int OnUpdateItem (esmrecinfo_t* pRecInfo);

	/* Create the sound gen ID based on the current control data */
  void UpdateID (void);


  /*---------- Begin Public Class Methods ---------------------------*/
public:

	/* Construction */
  CEsmSoundGenDlg();

  	/* Get class members */
  virtual bool IsModified (void);
	
  	/* Set or update the record data */
  virtual void GetControlData (void);
  virtual void SetControlData (void);

	/* Dialog Data */
  //{{AFX_DATA(CEsmSoundGenDlg)
  enum { IDD = IDD_SOUNDGEN_DLG };
  CComboBox	m_TypeList;
  CComboBox	m_SoundList;
  CComboBox	m_CreatureList;
  //}}AFX_DATA

	/* ClassWizard generated virtual function overrides */
  //{{AFX_VIRTUAL(CEsmSoundGenDlg)
protected:
  virtual void OnInitialUpdate();
  virtual void DoDataExchange(CDataExchange* pDX);
  //}}AFX_VIRTUAL

protected:

	/* Generated message map functions */
  //{{AFX_MSG(CEsmSoundGenDlg)
  afx_msg void OnPlaysound();
  afx_msg void OnSelchangeList();
  //}}AFX_MSG
 
  DECLARE_MESSAGE_MAP();

 };
/*===========================================================================
 *		End of Class CEsmSoundGenDlg Definition
 *=========================================================================*/


//{{AFX_INSERT_LOCATION}}
//}}AFX_INSERT_LOCATION


#endif
/*===========================================================================
 *		End of File Esmsoundgendlg.H
 *=========================================================================*/

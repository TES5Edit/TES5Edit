/*===========================================================================
 *
 * File:	Esmsounddlg.H
 * Author:	Dave Humphrey (uesp@m0use.net)
 * Created On:	February 16, 2003
 *
 * Description
 *
 *=========================================================================*/
#ifndef __ESMSOUNDDLG_H
#define __ESMSOUNDDLG_H


/*===========================================================================
 *
 * Begin Required Includes
 *
 *=========================================================================*/
  #include "EsmRecDialog.h"
  #include "Resource.h"
  #include "EsmListCtrl.h"
/*===========================================================================
 *		End of Required Includes
 *=========================================================================*/


/*===========================================================================
 *
 * Begin Class CEsmSoundDlg Definition
 *
 *=========================================================================*/
class CEsmSoundDlg : public CEsmRecDialog {
  DECLARE_DYNCREATE(CEsmSoundDlg);

  /*---------- Begin Protected Class Members ------------------------*/
protected:
  CEsmSound*	m_pSound;


  /*---------- Begin Protected Class Methods ------------------------*/
protected:

	/* Update item data */
  virtual int OnUpdateItem (esmrecinfo_t* pRecInfo);


  /*---------- Begin Public Class Methods ---------------------------*/
public:

	/* Construction */
  CEsmSoundDlg();

  	/* Get class members */
  virtual bool IsModified (void);
	
  	/* Set or update the record data */
  virtual void GetControlData (void);
  virtual void SetControlData (void);

	/* Dialog Data */
  //{{AFX_DATA(CEsmSoundDlg)
  enum { IDD = IDD_SOUND_DLG };
  CButton	m_SoundButton;
  CEdit		m_MinRangeText;
  CEdit		m_MaxRangeText;
  CEdit		m_VolumeText;
  //}}AFX_DATA

	/* ClassWizard generated virtual function overrides */
  //{{AFX_VIRTUAL(CEsmSoundDlg)
protected:
  virtual void OnInitialUpdate();
  virtual void DoDataExchange(CDataExchange* pDX);
  //}}AFX_VIRTUAL

protected:

	/* Generated message map functions */
  //{{AFX_MSG(CEsmSoundDlg)
  afx_msg void OnSoundbutton();
  afx_msg void OnPlaysound();
  //}}AFX_MSG
 
  DECLARE_MESSAGE_MAP();

 };
/*===========================================================================
 *		End of Class CEsmSoundDlg Definition
 *=========================================================================*/


//{{AFX_INSERT_LOCATION}}
//}}AFX_INSERT_LOCATION


#endif
/*===========================================================================
 *		End of File Esmsounddlg.H
 *=========================================================================*/

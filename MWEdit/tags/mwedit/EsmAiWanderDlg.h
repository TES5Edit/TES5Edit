/*===========================================================================
 *
 * File:	Esmaiwanderdlg.H
 * Author:	Dave Humphrey (uesp@m0use.net)
 * Created On:	February 24, 2003
 *
 * Description
 *
 *=========================================================================*/
#ifndef __ESMAIWANDERDLG_H
#define __ESMAIWANDERDLG_H


/*===========================================================================
 *
 * Begin Required Includes
 *
 *=========================================================================*/
  #include "EsmSubAI_W.h"
/*===========================================================================
 *		End of Required Includes
 *=========================================================================*/


/*===========================================================================
 *
 * Begin Class CEsmAiWanderDlg
 *
 *=========================================================================*/
class CEsmAiWanderDlg : public CDialog {

  /*---------- Begin Protected Class Members -------------------------*/
protected:
  CEsmSubAI_W*	m_pSubRecord;


  /*---------- Begin Public Class Method -----------------------------*/
public:

	/* Construction */
  CEsmAiWanderDlg(CWnd* pParent = NULL);

	/* Main access method */
  bool DoModal (CEsmSubAI_W* pSubRecord);

	/* Dialog Data */
  //{{AFX_DATA(CEsmAiWanderDlg)
  enum { IDD = IDD_AIWANDER_DLG };
  CEdit	m_TimeText;
  CEdit	m_DistanceText;
  CEdit	m_DurationText;
  //}}AFX_DATA
  CEdit	m_IdleText[MWESM_AIW_NUMIDLES];

	/* ClassWizard generated virtual function overrides */
  //{{AFX_VIRTUAL(CEsmAiWanderDlg)
protected:
  virtual void DoDataExchange(CDataExchange* pDX);
  //}}AFX_VIRTUAL

protected:

	/* Generated message map functions */
  //{{AFX_MSG(CEsmAiWanderDlg)
  virtual BOOL OnInitDialog();
  virtual void OnOK();
  //}}AFX_MSG

  DECLARE_MESSAGE_MAP();

 };
/*===========================================================================
 *		End of Class CEsmAiWanderDlg
 *=========================================================================*/


//{{AFX_INSERT_LOCATION}}
//}}AFX_INSERT_LOCATION



#endif
/*===========================================================================
 *		End of File Esmaiwanderdlg.H
 *=========================================================================*/

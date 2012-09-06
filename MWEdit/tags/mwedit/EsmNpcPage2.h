/*===========================================================================
 *
 * File:	Esmnpcpage2.H
 * Author:	Dave Humphrey (uesp@m0use.net)
 * Created On:	February 23, 2003
 *
 * Description
 *
 *=========================================================================*/
#ifndef __ESMNPCPAGE2_H
#define __ESMNPCPAGE2_H


/*===========================================================================
 *
 * Begin Required Includes
 *
 *=========================================================================*/
  #include "EsmListCtrl.h"
/*===========================================================================
 *		End of Required Includes
 *=========================================================================*/


/*===========================================================================
 *
 * Begin Type Definitions
 *
 *=========================================================================*/
  class CEsmDlgHandler;
/*===========================================================================
 *		End of Type Definitions
 *=========================================================================*/


/*===========================================================================
 *
 * Begin Class CEsmNpcPage2 Definition
 *
 *=========================================================================*/
class CEsmNpcPage2 : public CPropertyPage {
  DECLARE_DYNCREATE(CEsmNpcPage2);

  /*---------- Begin Protected Class Methods ----------------------*/
protected:
  esmrecinfo_t*		m_pRecInfo;
  CEsmDlgHandler*	m_pDlgHandler;


  /*---------- Begin Public Class Methods -------------------------*/
public:

	/* Construction */
  CEsmNpcPage2();
  ~CEsmNpcPage2();

	/* Get class members */
  CMWEditDoc* GetDocument (void);

  	/* Update item data */
  virtual int OnUpdateItem (esmrecinfo_t* pRecInfo);

  	/* Set class members */
  void SetRecInfo    (esmrecinfo_t* pRecInfo)   { m_pRecInfo = pRecInfo; }
  void SetDlgHandler (CEsmDlgHandler*  pParent) { m_pDlgHandler = pParent; }

	/* Get/set control data */
  void GetControlData (void);
  void SetControlData (void);


	/* Dialog Data */
  //{{AFX_DATA(CEsmNpcPage2)
  enum { IDD = IDD_NPC_VIEW2 };
  CEsmListCtrl	m_SpellList;
  //}}AFX_DATA

	/* ClassWizard generate virtual function overrides */
  //{{AFX_VIRTUAL(CEsmNpcPage2)
protected:
  virtual void DoDataExchange(CDataExchange* pDX);
  //}}AFX_VIRTUAL

protected:

	/* Generated message map functions */
  //{{AFX_MSG(CEsmNpcPage2)
  afx_msg LRESULT OnRecordDrop (LPARAM lParam, LPARAM wParam);
  afx_msg LRESULT OnRecordKey  (LPARAM lParam, LPARAM wParam);
  virtual BOOL OnInitDialog();
  //}}AFX_MSG

  DECLARE_MESSAGE_MAP();

 };
/*===========================================================================
 *		End of Class CEsmNpcPage2 Definition
 *=========================================================================*/


//{{AFX_INSERT_LOCATION}}
//}}AFX_INSERT_LOCATION


#endif
/*===========================================================================
 *		End of File Esmnpcpage2.H
 *=========================================================================*/

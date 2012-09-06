/*===========================================================================
 *
 * File:	Esmintcellpage.H
 * Author:	Dave Humphrey (uesp@m0use.net)
 * Created On:	February 25, 2003
 *
 * Description
 *
 *=========================================================================*/
#ifndef __ESMINTCELLPAGE_H
#define __ESMINTCELLPAGE_H


/*===========================================================================
 *
 * Begin Required Includes
 *
 *=========================================================================*/
  #include "ColorStatic1.h"
  #include "EsmFile.h"
/*===========================================================================
 *		End of Required Includes
 *=========================================================================*/


/*===========================================================================
 *
 * Begin Type Definitions
 *
 *=========================================================================*/
  class CEsmRecDialog;
  class CMWEditDoc;

/*===========================================================================
 *		End of Type Definitions
 *=========================================================================*/


/*===========================================================================
 *
 * Begin Class CEsmIntCellPage Definition
 *
 *=========================================================================*/
class CEsmIntCellPage : public CPropertyPage {
  DECLARE_DYNCREATE(CEsmIntCellPage);

  /*---------- Begin Protected Class Methods ----------------------*/
protected:
  esmrecinfo_t*		m_pRecInfo;
  CEsmRecDialog*	m_pDlgParent;


  /*---------- Begin Public Class Methods -------------------------*/
public:

	/* Construction */
  CEsmIntCellPage();
  ~CEsmIntCellPage();

	/* Get class members */
  CMWEditDoc* GetDocument (void);

    	/* Set class members */
  void SetRecInfo    (esmrecinfo_t*   pRecInfo) { m_pRecInfo    = pRecInfo; }
  void SetEsmRecParent (CEsmRecDialog*   pDialog) { m_pDlgParent  = pDialog; }

	/* Get/set control data */
  void GetControlData (void);
  void SetControlData (void);

  	/* Update record data */
  int OnUpdateItem (esmrecinfo_t* pRecInfo);


	/* Dialog Data */
  //{{AFX_DATA(CEsmIntCellPage)
  enum { IDD = IDD_INTCELL_PAGE };
  CColorStatic	m_ColorBoxF;
  CSpinButtonCtrl	m_BSpinF;
  CSpinButtonCtrl	m_GSpinF;
  CSpinButtonCtrl	m_RSpinF;
  CEdit		m_DensityText;
  CEdit		m_BlueTextF;
  CEdit		m_GreenTextF;
  CEdit		m_RedTextF;
  CSpinButtonCtrl	m_BSpinS;
  CSpinButtonCtrl	m_GSpinS;
  CSpinButtonCtrl	m_RSpinS;
  CColorStatic	m_ColorBoxS;
  CEdit		m_BlueTextS;
  CEdit		m_GreenTextS;
  CEdit		m_RedTextS;
  CSpinButtonCtrl	m_BSpinA;
  CSpinButtonCtrl	m_GSpinA;
  CSpinButtonCtrl	m_RSpinA;
  CColorStatic	m_ColorBoxA;
  CEdit		m_WaterText;
  CComboBox	m_RegionList;
  CButton	m_ExteriorCheck;
  CButton	m_SleepCheck;
  CButton	m_WaterCheck;
  CEdit		m_BlueTextA;
  CEdit		m_GreenTextA;
  CEdit		m_RedTextA;
  //}}AFX_DATA

	/* ClassWizard generate virtual function overrides */
  //{{AFX_VIRTUAL(CEsmIntCellPage)
protected:
  virtual void DoDataExchange(CDataExchange* pDX);
  //}}AFX_VIRTUAL

protected:

	/* Generated message map functions */
  //{{AFX_MSG(CEsmIntCellPage)
  virtual BOOL OnInitDialog();
  afx_msg void OnColorbuttona();
  afx_msg void OnColorbuttons();
  afx_msg void OnColorbuttonf();
  afx_msg void OnChangeColorA();
  afx_msg void OnChangeColorS();
  afx_msg void OnChangeColorF();
  afx_msg void OnWatercheck();
  afx_msg void OnExteriorcheck();
  //}}AFX_MSG

  DECLARE_MESSAGE_MAP();

 };
/*===========================================================================
 *		End of Class CEsmIntCellPage Definition
 *=========================================================================*/


//{{AFX_INSERT_LOCATION}}
//}}AFX_INSERT_LOCATION


#endif
/*===========================================================================
 *		End of File Esmintcellpage.H
 *=========================================================================*/

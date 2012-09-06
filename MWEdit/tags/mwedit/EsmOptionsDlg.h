/*===========================================================================
 *
 * File:	Esmoptionsdlg.H
 * Author:	Dave Humphrey (uesp@m0use.net)
 * Created On:	September 6, 2003
 *
 * Description
 *
 *=========================================================================*/
#ifndef __ESMOPTIONSDLG_H
#define __ESMOPTIONSDLG_H


/*===========================================================================
 *
 * Begin Required Includes
 *
 *=========================================================================*/
  #include "EsmOptions.h"
  #include "ColorStatic1.h"
/*===========================================================================
 *		End of Required Includes
 *=========================================================================*/


/*===========================================================================
 *
 * Begin Class CEsmOptionsDlg Definition
 *
 *=========================================================================*/
class CEsmOptionsDlg : public CDialog {

  /*---------- Begin Protected Class Members -------------------------*/
protected:
  CEsmOptions*		m_pOrigOptions;		/* Reference to the original options object */
  CEsmScriptOptions	m_ScriptOptions;	/* Temporary script options */
  int			m_CurrentFormat;	/* Currently displayed format for editting */

  CFont			m_SampleFont;		/* Sample font object for output */


  /*---------- Begin Protected Class Methods -------------------------*/
protected:

	/* Fill the various lists with contents */
  void FillWarnLevelList (void);
  void FillFormatList    (void);
  void FillFontSizeList  (void);
  void FillFontNameList  (void);


  /*---------- Begin Public Class Methods ----------------------------*/
public:
	
	/* Construction */
  CEsmOptionsDlg(CWnd* pParent = NULL);

	/* Save the control data to the options object */
  void GetControlData (void);
  void GetFormatData  (void);
  void GetFontData (CFont* pFont);

	/* Set the control data from the options object */
  void SetControlData (void);
  void SetFormatData  (const int Index);
  void SetFontData    (void);

	/* Set class members */
  void SetOptions (CEsmOptions* pOptions) { m_pOrigOptions = pOptions; }

	/* Update the sample font display in the textbox */
  void UpdateSampleFontText (void);

	/* Dialog Data */
  //{{AFX_DATA(CEsmOptionsDlg)
	enum { IDD = IDD_OPTIONS_DLG };
	CButton	m_AllowTribunal;
	CButton	m_AllowBloodmoon;
	CButton	m_IndentCommentsMore;
  CEdit		m_IndentSpacesText;
  CButton	m_IndentSpace;
  CButton	m_IndentTab;
  CButton	m_InitialIndentLevel;
  CButton	m_StrictIDs;
  CButton	m_UseExtraFile;
  CEdit		m_ExtraFile;
  CButton	m_NoScriptPrompt;
  CButton	m_AllowExtFuncs;
  CButton	m_BackupSaves;
  CEdit		m_GamePath;
  CButton	m_NoToolTipCheck;
  CEdit		m_AuthorText;
  CColorStatic	m_BGColor;
  CColorStatic	m_FormatColor;
  CEdit		m_SampleText;
  CButton	m_FontItalicCheck;
  CButton	m_FontBoldCheck;
  CComboBox	m_FontFaceList;
  CComboBox	m_FontSizeList;
  CListBox	m_FormatList;
  CButton	m_NoFormatCheck;
  CComboBox	m_WarnLevelList;
	//}}AFX_DATA

	/* ClassWizard generated virtual function overrides */
  //{{AFX_VIRTUAL(CEsmOptionsDlg)
protected:
  virtual void DoDataExchange(CDataExchange* pDX);
  //}}AFX_VIRTUAL

protected:

	/* Generated message map functions */
  //{{AFX_MSG(CEsmOptionsDlg)
  virtual BOOL OnInitDialog();
  virtual void OnOK();
  virtual void OnCancel();
  afx_msg void OnSelchangeFontfaceList();
  afx_msg void OnSelchangeFontsizeList();
  afx_msg void OnFontboldCheck();
  afx_msg void OnFontitalicCheck();
  afx_msg void OnFormatcolor();
  afx_msg void OnSelchangeFormatList();
  afx_msg void OnBgcolor();
  afx_msg void OnBlueformatButton();
  afx_msg void OnWhiteformatButton();
	afx_msg void OnBrowsegamepath();
	afx_msg void OnBrowseextrafile();
	//}}AFX_MSG

  DECLARE_MESSAGE_MAP();

 };
/*===========================================================================
 *		End of Class CEsmOptionsDlg Definition
 *=========================================================================*/


//{{AFX_INSERT_LOCATION}}
//}}AFX_INSERT_LOCATION


#endif
/*===========================================================================
 *		End of File Esmoptionsdlg.H
 *=========================================================================*/

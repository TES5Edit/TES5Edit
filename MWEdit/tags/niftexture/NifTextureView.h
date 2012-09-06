/*===========================================================================
 *
 * File:	NifTextureView.H
 * Author:	Dave Humphrey (uesp@m0use.net)
 * Created On:	Saturday, 28 December, 2002
 *
 * Interface of the CNifTextureView class.
 *
 *=========================================================================*/
#ifndef __NifTextureView_H
#define __NifTextureView_H


/*===========================================================================
 *
 * Begin Required Include Files
 *
 *=========================================================================*/
  #include "ColorStatic.h"
/*===========================================================================
 *		End of Required Include Files
 *=========================================================================*/


/*===========================================================================
 *
 * Begin Definitions
 *
 *=========================================================================*/
/*===========================================================================
 *		End of Definitions
 *=========================================================================*/


/*===========================================================================
 *
 * Begin Class CNifTextureView Definition
 *
 *=========================================================================*/
class CNifTextureView : public CFormView {

  /*---------- Begin Protected Class Members ----------------------*/
protected:
  int	m_CurrentListIndex;
  int   m_CurrentMaterialIndex;

  /*---------- Begin Public Class Members --------------------------*/
public:
  //{{AFX_DATA(CNifTextureView)
  enum { IDD = IDD_NIFTEXTURE_FORM };
  CColorStatic	m_SpecularColor;
  CColorStatic	m_DiffuseColor;
  CColorStatic	m_AmbientColor;
  CButton	m_MaterialBox;
  CListBox	m_MaterialList;
  CButton	m_BrowseButton;
  CEdit		m_FilenameText;
  CListBox	m_TextureList;
  //}}AFX_DATA


  /*---------- Begin Protected Class Methods ----------------------*/
protected: 

	/* Create from serialization only */
  CNifTextureView();
  DECLARE_DYNCREATE(CNifTextureView)

	/* Create the material/texture list from the current file */
  void CreateMaterialList (void);
  void CreateTextureList  (void);

	/* Set/get control data */ 
  void GetMaterialData (void);
  void SetMaterialData (void);
  void GetTextureData  (void);
  void SetTextureData  (void);

  
  /*---------- Begin Public Class Methods --------------------------*/
public:

	/* Class destructor */
  virtual ~CNifTextureView();



	/* Diagnostics */
#ifdef _DEBUG
  virtual void AssertValid() const;
  virtual void Dump(CDumpContext& dc) const;
#endif

  CNifTextureDoc* GetDocument();
  CNifTextureApp* GetApp() { return (CNifTextureApp *) AfxGetApp(); }

	/* ClassWizard generated virtual function overrides */
  //{{AFX_VIRTUAL(CNifTextureView)
public:
  virtual BOOL PreCreateWindow(CREATESTRUCT& cs);
protected:
  virtual void DoDataExchange(CDataExchange* pDX);
  virtual void OnInitialUpdate();
  virtual void OnUpdate(CView* pSender, LPARAM lHint, CObject* pHint);
  //}}AFX_VIRTUAL

	/* Generated message map functions */
protected:
  //{{AFX_MSG(CNifTextureView)
  afx_msg void OnBrowseButton();
  afx_msg void OnSelchangeTextureList();
	afx_msg void OnAmibientcolorbox();
	afx_msg void OnDiffusecolorbox();
	afx_msg void OnSpecularcolorbox();
	afx_msg void OnSelchangeMaterialList();
	afx_msg void OnAutotint();
	//}}AFX_MSG
  
  DECLARE_MESSAGE_MAP();

 };
/*===========================================================================
 *		End of Class CNifTextureView Definition
 *=========================================================================*/


/*===========================================================================
 *
 * Begin Inline Class Methods
 *
 *=========================================================================*/
#ifndef _DEBUG
  inline CNifTextureDoc* CNifTextureView::GetDocument() {
    return (CNifTextureDoc*)m_pDocument; }
#endif
/*===========================================================================
 *		End of Inline Class Methods
 *=========================================================================*/


//{{AFX_INSERT_LOCATION}}
// Microsoft Visual C++ will insert additional declarations immediately before the previous line.
//}}AFX_INSERT_LOCATION


#endif
/*===========================================================================
 *		End of File View.H
 *=========================================================================*/

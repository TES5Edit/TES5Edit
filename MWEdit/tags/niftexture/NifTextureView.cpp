/*===========================================================================
 *
 * File:	NifTextureView.CPP
 * Author:	Dave Humphrey (uesp@m0use.net)
 * Created On:	Saturday, 28 December, 2002
 *
 * Implementation of the CNifTextureView class.
 *
 *=========================================================================*/

	/* Include Files */
#include "stdafx.h"
#include "NifTexture.h"
#include "NifTextureDoc.h"
#include "NifTextureView.h"
#include "NifSourceTexture.h"
#include "NifMaterialProperty.h"

	/* Debug definitions */
#ifdef _DEBUG
  #define new DEBUG_NEW
  #undef THIS_FILE
  static char THIS_FILE[] = __FILE__;
#endif


/*===========================================================================
 *
 * Begin Local Definitions
 *
 *=========================================================================*/
  IMPLEMENT_DYNCREATE(CNifTextureView, CFormView)
/*===========================================================================
 *		End of Local Definitions
 *=========================================================================*/


/*===========================================================================
 *
 * Begin Class CNifTextureView Message Map
 *
 *=========================================================================*/
BEGIN_MESSAGE_MAP(CNifTextureView, CFormView)
  //{{AFX_MSG_MAP(CNifTextureView)
  ON_BN_CLICKED(IDC_BROWSE_BUTTON, OnBrowseButton)
  ON_LBN_SELCHANGE(IDC_TEXTURE_LIST, OnSelchangeTextureList)
  ON_BN_CLICKED(IDC_AMIBIENTCOLORBOX, OnAmibientcolorbox)
  ON_BN_CLICKED(IDC_DIFFUSECOLORBOX, OnDiffusecolorbox)
  ON_BN_CLICKED(IDC_SPECULARCOLORBOX, OnSpecularcolorbox)
  ON_LBN_SELCHANGE(IDC_MATERIAL_LIST, OnSelchangeMaterialList)
  ON_BN_CLICKED(IDC_AUTOTINT, OnAutotint)
  //}}AFX_MSG_MAP
END_MESSAGE_MAP()
/*===========================================================================
 *		End of Class CNifTextureView Message Map
 *=========================================================================*/


/*===========================================================================
 *
 * Class CNifTextureView Constructor
 *
 *=========================================================================*/
CNifTextureView::CNifTextureView() : CFormView(CNifTextureView::IDD) {
  //{{AFX_DATA_INIT(CNifTextureView)
  //}}AFX_DATA_INIT
  m_CurrentListIndex     = -1;
  m_CurrentMaterialIndex = -1;
 }
/*===========================================================================
 *		End of Class CNifTextureView Constructor
 *=========================================================================*/


/*===========================================================================
 *
 * Class CNifTextureView Destructor
 *
 *=========================================================================*/
CNifTextureView::~CNifTextureView() {
 }
/*===========================================================================
 *		End of Class CNifTextureView Destructor
 *=========================================================================*/


/*===========================================================================
 *
 * Class CNifTextureView Method - void CreateMaterialList (void);
 *
 * Fills the list with all the texture names from the current NIF file.
 *
 *=========================================================================*/
void CNifTextureView::CreateMaterialList (void) {
  CNifFile*		pNifFile = GetDocument()->GetNifFile();
  POSITION		FindPos;
  CNifBaseRecord*	pRecord;
  CNifMaterialProperty*	pMaterial;
  int			ListIndex;
  int			OldListIndex;
  int			Count;

	/* Clear the current list */
  OldListIndex = m_MaterialList.GetCurSel();
  m_MaterialList.ResetContent();

  pRecord = pNifFile->FindFirstRecord(FindPos, "NiMaterialProperty");
  Count   = 0;

	/* Enumerate through all texture records in NIF file */
  while (pRecord != NULL) {
    pMaterial = (CNifMaterialProperty *) pRecord;
    Count++;

    ListIndex = m_MaterialList.AddString(pMaterial->GetRecordName());
    if (ListIndex != LB_ERR) m_MaterialList.SetItemDataPtr(ListIndex, pRecord);
 
    pRecord = pNifFile->FindNextRecord(FindPos, "NiMaterialProperty");
   }
 
	/* Select the old item, if any */
  if (OldListIndex >= 0)
    m_CurrentMaterialIndex = OldListIndex;
  else if (m_TextureList.GetCount() > 0)
    m_CurrentMaterialIndex = 0;
  else 
    m_CurrentMaterialIndex = -1;

  m_MaterialList.SetCurSel(m_CurrentMaterialIndex);
  SetMaterialData();
 }
/*===========================================================================
 *		End of Class Method CNifTextureView::CreateMaterialList()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CNifTextureView Method - void CreateTextureList (void);
 *
 * Fills the list with all the texture names from the current NIF file.
 *
 *=========================================================================*/
void CNifTextureView::CreateTextureList (void) {
  CNifFile*		pNifFile = GetDocument()->GetNifFile();
  POSITION		FindPos;
  CNifBaseRecord*	pRecord;
  CNifSourceTexture*	pSourceTexture;
  int			ListIndex;
  int			OldListIndex;

	/* Clear the current list */
  OldListIndex = m_TextureList.GetCurSel();
  m_TextureList.ResetContent();

  pRecord = pNifFile->FindFirstRecord(FindPos, "NiSourceTexture");

	/* Enumerate through all texture records in NIF file */
  while (pRecord != NULL) {
    pSourceTexture = (CNifSourceTexture *) pRecord;
    ListIndex = m_TextureList.AddString(pSourceTexture->GetTextureName());
    if (ListIndex != LB_ERR) m_TextureList.SetItemDataPtr(ListIndex, pRecord);
 
    pRecord = pNifFile->FindNextRecord(FindPos, "NiSourceTexture");
   }
 
	/* Select the old item, if any */
  if (OldListIndex >= 0)
    m_CurrentListIndex = OldListIndex;
  else if (m_TextureList.GetCount() > 0)
    m_CurrentListIndex = 0;
  else 
    m_CurrentListIndex = -1;

  m_TextureList.SetCurSel(m_CurrentListIndex);
  SetTextureData();
 }
/*===========================================================================
 *		End of Class Method CNifTextureView::CreateTextureList()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CNifTextureView Method - void DoDataExchange (pDX);
 *
 *=========================================================================*/
void CNifTextureView::DoDataExchange(CDataExchange* pDX) {
  CFormView::DoDataExchange(pDX);

  //{{AFX_DATA_MAP(CNifTextureView)
  DDX_Control(pDX, IDC_SPECULARCOLORBOX, m_SpecularColor);
  DDX_Control(pDX, IDC_DIFFUSECOLORBOX, m_DiffuseColor);
  DDX_Control(pDX, IDC_AMIBIENTCOLORBOX, m_AmbientColor);
  DDX_Control(pDX, IDC_MATERIAL_BOX, m_MaterialBox);
  DDX_Control(pDX, IDC_MATERIAL_LIST, m_MaterialList);
  DDX_Control(pDX, IDC_BROWSE_BUTTON, m_BrowseButton);
  DDX_Control(pDX, IDC_TEXTURE_EDIT, m_FilenameText);
  DDX_Control(pDX, IDC_TEXTURE_LIST, m_TextureList);
  //}}AFX_DATA_MAP
 }
/*===========================================================================
 *		End of Class Method CNifTextureView::DoDataExchange()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CNifTextureView Method - void GetMaterialData (void);
 *
 * Gets the data from the material controls.
 *
 *=========================================================================*/
void CNifTextureView::GetMaterialData (void) {
  //DEFINE_FUNCTION("CNifTextureView::GetMaterialData()");
  CNifMaterialProperty* pMaterial;

  	/* Ignore if the current list item is not valid */
  if (m_CurrentMaterialIndex < 0) return;

  	/* Get the current source texture and ensure it is valid */
  pMaterial = (CNifMaterialProperty *) m_MaterialList.GetItemDataPtr(m_CurrentMaterialIndex);
  ASSERT(pMaterial != NULL);

	/* Update the material colors if required */
  if (m_AmbientColor.IsModified()) {
    pMaterial->SetAmbientColor(m_AmbientColor.GetColor());
    m_AmbientColor.SetModified(false);
    GetDocument()->SetModifiedFlag(TRUE);
   }

  if (m_DiffuseColor.IsModified()) {
    pMaterial->SetDiffuseColor(m_DiffuseColor.GetColor());
    m_DiffuseColor.SetModified(false);
    GetDocument()->SetModifiedFlag(TRUE);
   }

  if (m_SpecularColor.IsModified()) {
    pMaterial->SetSpecularColor(m_SpecularColor.GetColor());
    m_SpecularColor.SetModified(false);
    GetDocument()->SetModifiedFlag(TRUE);
   }

 }
/*===========================================================================
 *		End of Class Method CNifTextureView::GetMaterialData()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CNifTextureView Method - void GetTextureData (void);
 *
 * Gets the data from the texture controls and stores it in the NifFile structure.
 *
 *=========================================================================*/
void CNifTextureView::GetTextureData (void) {
  CNifSourceTexture* pSourceTexture;
  CString	     Buffer;

	/* Ignore if the current list item is not valid */
  if (m_CurrentListIndex < 0) return;

  	/* Get the current source texture and ensure it is valid */
  pSourceTexture = (CNifSourceTexture *) m_TextureList.GetItemDataPtr(m_CurrentListIndex);
  ASSERT(pSourceTexture != NULL);

	/* Only save the texture name if it was changed */
  if (m_FilenameText.GetModify()) {
    m_FilenameText.GetWindowText(Buffer);
    Buffer.TrimLeft(" ");
    Buffer.TrimRight(" ");
 
    pSourceTexture->SetTextureName(Buffer);
    GetDocument()->SetModifiedFlag(TRUE);

		/* Update the texture list */
    CreateTextureList();
   }

 }
/*===========================================================================
 *		End of Class Method CNifTextureView::GetTextureData()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CNifTextureView Method - BOOL PreCreateWindow (cs);
 *
 *=========================================================================*/
BOOL CNifTextureView::PreCreateWindow (CREATESTRUCT& cs) {
  return CFormView::PreCreateWindow(cs);
 }
/*===========================================================================
 *		End of Class Method CNifTextureView::PreCreateWindow()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CNifTextureView Event - void OnAmibientcolorbox ();
 *
 *=========================================================================*/
void CNifTextureView::OnAmibientcolorbox() {
  CColorDialog  ColorDlg(m_AmbientColor.GetColor(), CC_FULLOPEN | CC_ANYCOLOR, this);
  int		Result;

	/* Display the modal dialog */
  Result = ColorDlg.DoModal();
  if (Result != IDOK) return;

	/* Update the color box */
  m_AmbientColor.SetColor(ColorDlg.GetColor());
  m_AmbientColor.SetModified(true);
  m_AmbientColor.RedrawWindow();
 }
/*===========================================================================
 *		End of Class Event CNifTextureView::OnAmibientcolorbox()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CNifTextureView Event - void OnAutotint ();
 *
 *=========================================================================*/
void CNifTextureView::OnAutotint() {
  CNifMaterialProperty*	pMaterial;
  
	/* Update the current material data */
  GetMaterialData();

	/* Get the current material record and ensure it is valid */
  if (m_CurrentMaterialIndex < 0) return;
  pMaterial = (CNifMaterialProperty *) m_MaterialList.GetItemDataPtr(m_CurrentMaterialIndex);
  if (pMaterial == NULL) return;
  
	/* Set the material's ideal tints */
  pMaterial->AutoTint();
  GetDocument()->SetModifiedFlag(TRUE);
 
	/* Update the material display */
  SetMaterialData();
 }
/*===========================================================================
 *		End of Class Event CNifTextureView::OnAutotint()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CNifTextureView Event - void OnInitialUpdate ();
 *
 *=========================================================================*/
void CNifTextureView::OnInitialUpdate() {
  CFormView::OnInitialUpdate();
  ResizeParentToFit();

  CreateTextureList();
  CreateMaterialList();
 }
/*===========================================================================
 *		End of Class Event CNifTextureView::OnInitialUpdate()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CNifTextureView Event - void OnBrowseButton ();
 *
 *=========================================================================*/
void CNifTextureView::OnBrowseButton() {
  CString     Buffer;
  TCHAR	      Path[_MAX_PATH+1];
  int	      Result;

  m_FilenameText.GetWindowText(Buffer);
  Buffer = GetApp()->GetBrowsePath() + Buffer;

		/* Initialize the open dialog */
  CFileDialog OpenFile(TRUE, "tga", Buffer, OFN_HIDEREADONLY | OFN_PATHMUSTEXIST,
			"All Textures (*.tga; *.bmp; *.dds)|*.tga; *.bmp; *.dds|All Files (*.*)|*.*||", this); 

	/* Display the modal dialogue */
  Result = OpenFile.DoModal();
  if (Result != IDOK) return;
  
  m_FilenameText.SetWindowText(OpenFile.GetFileName());
  m_FilenameText.SetModify(TRUE);
  
  GetTextureData();
  CreateTextureList();

  Buffer = OpenFile.GetPathName();
  ExtractPath(Path, Buffer, _MAX_PATH);
  GetApp()->SetBrowsePath(Path);
 }
/*===========================================================================
 *		End of Class Event CNifTextureView::OnBrowseButton()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CNifTextureView Event - void OnDiffusecolorbox ();
 *
 *=========================================================================*/
void CNifTextureView::OnDiffusecolorbox() {
  CColorDialog  ColorDlg(m_DiffuseColor.GetColor(), CC_FULLOPEN | CC_ANYCOLOR, this);
  int		Result;

	/* Display the modal dialog */
  Result = ColorDlg.DoModal();
  if (Result != IDOK) return;

	/* Update the color box */
  m_DiffuseColor.SetColor(ColorDlg.GetColor());
  m_DiffuseColor.SetModified(true);
  m_DiffuseColor.RedrawWindow();
 }
/*===========================================================================
 *		End of Class Event CNifTextureView::OnDiffusecolorbox()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CNifTextureView Event - void OnSelchangeMaterialList ();
 *
 *=========================================================================*/
void CNifTextureView::OnSelchangeMaterialList() {

	/* Update the current material data */
  GetMaterialData();

	/* Get the new list index */
  m_CurrentMaterialIndex = m_MaterialList.GetCurSel();

	/* Display the new material information */
  SetMaterialData();
 }
/*===========================================================================
 *		End of Class Event CNifTextureView::OnSelchangeMaterialList()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CNifTextureView Event - void OnSelchangeTextureList ();
 *
 *=========================================================================*/
void CNifTextureView::OnSelchangeTextureList() {
  
	/* Update the current texture data */
  GetTextureData();

	/* Get the new list index */
  m_CurrentListIndex = m_TextureList.GetCurSel();

	/* Display the new texture information */
  SetTextureData();
 }
/*===========================================================================
 *		End of Class Event CNifTextureView::OnSelchangeTextureList()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CNifTextureView Event - void OnSpecularcolorbox ();
 *
 *=========================================================================*/
void CNifTextureView::OnSpecularcolorbox() {
  CColorDialog  ColorDlg(m_SpecularColor.GetColor(), CC_FULLOPEN | CC_ANYCOLOR, this);
  int		Result;

	/* Display the modal dialog */
  Result = ColorDlg.DoModal();
  if (Result != IDOK) return;

	/* Update the color box */
  m_SpecularColor.SetColor(ColorDlg.GetColor());
  m_SpecularColor.SetModified(true);
  m_SpecularColor.RedrawWindow();
 }
/*===========================================================================
 *		End of Class Event CNifTextureView::OnSpecularcolorbox()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CNifTextureView Event - void OnUpdate (pSender, lHint, pHint);
 *
 *=========================================================================*/
void CNifTextureView::OnUpdate (CView* pSender, LPARAM lHint, CObject* pHint) {

  if (lHint == NIFTEXTDOC_VIEWHINT_UPDATE) {
    GetTextureData();
    GetMaterialData();
   }
  else {
    CFormView::OnUpdate(pSender, lHint, pHint);
   }

 }
/*===========================================================================
 *		End of Class Event CNifTextureView::OnUpdate()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CNifTextureView Method - void SetMaterialData (void);
 *
 * Sets the current material control data.
 *
 *=========================================================================*/
void CNifTextureView::SetMaterialData (void) {
  //DEFINE_FUNCTION("CNifTextureView::SetMaterialData()");
  CNifMaterialProperty* pMaterial;

	/* Check for an invalid list item */
  if (m_CurrentMaterialIndex < 0) {
    //m_MaterialBox.SetWindowText(_T(""));
    m_AmbientColor.EnableWindow(FALSE);
    m_DiffuseColor.EnableWindow(FALSE);
    m_SpecularColor.EnableWindow(FALSE);
    return;
   }

	/* Get the current material record and ensure it is valid */
  pMaterial = (CNifMaterialProperty *) m_MaterialList.GetItemDataPtr(m_CurrentMaterialIndex);
  ASSERT(pMaterial != NULL);
  //m_MaterialBox.SetWindowText(pMaterial->GetRecordName());

	/* Set the box colors */
  m_AmbientColor.SetColor(pMaterial->GetAmbientColor());
  m_DiffuseColor.SetColor(pMaterial->GetDiffuseColor());
  m_SpecularColor.SetColor(pMaterial->GetSpecularColor());

	/* Update the display */
  m_AmbientColor.RedrawWindow();
  m_DiffuseColor.RedrawWindow();
  m_SpecularColor.RedrawWindow();

	/* Clear the color box modified flags */
  m_AmbientColor.SetModified(false);
  m_DiffuseColor.SetModified(false);
  m_SpecularColor.SetModified(false);
 }
/*===========================================================================
 *		End of Class Method CNifTextureView::SetMaterialData()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CNifTextureView Method - void SetTextureData (void);
 *
 * Sets the texture data based on the currently displayed texture.
 *
 *=========================================================================*/
void CNifTextureView::SetTextureData (void) { 
  CNifSourceTexture* pSourceTexture;

	/* Check for an invalid list item */
  if (m_CurrentListIndex < 0) {
    m_FilenameText.SetWindowText(_T(""));
    m_BrowseButton.EnableWindow(FALSE);
    m_FilenameText.EnableWindow(FALSE);
    return;
   }

	/* Get the current source texture and ensure it is valid */
  pSourceTexture = (CNifSourceTexture *) m_TextureList.GetItemDataPtr(m_CurrentListIndex);
  ASSERT(pSourceTexture != NULL);

  m_BrowseButton.EnableWindow(TRUE);
  m_FilenameText.EnableWindow(TRUE);
  m_FilenameText.SetWindowText(pSourceTexture->GetTextureName());    
 }
/*===========================================================================
 *		End of Class Method CNifTextureView::SetTextureData()
 *=========================================================================*/


/*===========================================================================
 *
 * Begin Class Diagnostics
 *
 *=========================================================================*/
#ifdef _DEBUG
void CNifTextureView::AssertValid() const {
  CFormView::AssertValid();
 }

void CNifTextureView::Dump(CDumpContext& dc) const  {
  CFormView::Dump(dc);
 }

CNifTextureDoc* CNifTextureView::GetDocument() {
  ASSERT(m_pDocument->IsKindOf(RUNTIME_CLASS(CNifTextureDoc)));
  return (CNifTextureDoc*)m_pDocument;
 }
#endif
/*===========================================================================
 *		End of Class Diagnostics
 *=========================================================================*/


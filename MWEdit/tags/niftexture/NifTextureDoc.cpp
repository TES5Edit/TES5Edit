/*===========================================================================
 *
 * File:	NifTextureDoc.CPP
 * Author:	Dave Humphrey (uesp@m0use.net)
 * Created On:	Saturday, 28 December, 2002
 *
 * Implementation of the CNifTextureDoc document class.
 *
 *=========================================================================*/

	/* Include Files */
#include "stdafx.h"
#include "NifTexture.h"
#include "NifTextureDoc.h"


/*===========================================================================
 *
 * Begin Location Definitions
 *
 *=========================================================================*/

	/* Debug definitions */
#ifdef _DEBUG
  #define new DEBUG_NEW
  #undef THIS_FILE
  static char THIS_FILE[] = __FILE__;
#endif

  IMPLEMENT_DYNCREATE(CNifTextureDoc, CDocument)

/*===========================================================================
 *		End of Location Definitions
 *=========================================================================*/


/*===========================================================================
 *
 * Begin Class CNifTextureDoc Message Map
 *
 *=========================================================================*/
BEGIN_MESSAGE_MAP(CNifTextureDoc, CDocument)
  //{{AFX_MSG_MAP(CNifTextureDoc)
  ON_COMMAND(ID_FILE_CLOSE, OnFileClose)
  //}}AFX_MSG_MAP
END_MESSAGE_MAP()
/*===========================================================================
 *		End of Class CNifTextureDoc Message Map
 *=========================================================================*/


/*===========================================================================
 *
 * Class CNifTextureDoc Dispatch Map
 *
 *=========================================================================*/


/*===========================================================================
 *
 * Class CNifTextureDoc Constructor
 *
 *=========================================================================*/
CNifTextureDoc::CNifTextureDoc() {
 }
/*===========================================================================
 *		End of Class CNifTextureDoc Constructor
 *=========================================================================*/


/*===========================================================================
 *
 * Class CNifTextureDoc Destructor
 *
 *=========================================================================*/
CNifTextureDoc::~CNifTextureDoc() {
 }
/*===========================================================================
 *		End of Class CNifTextureDoc Destructor
 *=========================================================================*/


/*===========================================================================
 *
 * Class CNifTextureDoc Method - void DeleteContents ();
 *
 *=========================================================================*/
void CNifTextureDoc::DeleteContents() {
  m_NifFile.Destroy();
  CDocument::DeleteContents();
 }
/*===========================================================================
 *		End of Class Method CNifTextureDoc::DeleteContents()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CNifTextureDoc Event - void OnFileClose ();
 *
 *=========================================================================*/
void CNifTextureDoc::OnFileClose() {
  CDocument::OnFileClose();	
 }
/*===========================================================================
 *		End of Class Event CNifTextureDoc::OnFileClose()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CNifTextureDoc Event - BOOL OnNewDocument ();
 *
 *=========================================================================*/
BOOL CNifTextureDoc::OnNewDocument() {
  
	/* We cannot create an empty/new document in this application */
  return (FALSE);
 }
/*===========================================================================
 *		End of Class Event CNifTextureDoc::OnNewDocument()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CNifTextureDoc Event - BOOL OnOpenDocument (lpszPathName);
 *
 *=========================================================================*/
BOOL CNifTextureDoc::OnOpenDocument(LPCTSTR lpszPathName) { 
  bool Result;

  DeleteContents();
  SetModifiedFlag();

	/* Input the NIF file */
  Result = m_NifFile.Read(lpszPathName);
  
  if (!Result) {
    ErrorHandler.Notify("NIF Load Error");
    return (FALSE);
   }

  SetModifiedFlag(FALSE);
  return (TRUE);
 }
/*===========================================================================
 *		End of Class Event CNifTextureDoc::OnOpenDocument()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CNifTextureDoc Event - BOOL OnSaveDocument (lpszPathName);
 *
 *=========================================================================*/
BOOL CNifTextureDoc::OnSaveDocument(LPCTSTR lpszPathName) {
  bool Result;

	/* Ensure all views update the document data */
  UpdateAllViews(NULL, NIFTEXTDOC_VIEWHINT_UPDATE, NULL);

	/* Input the NIF file */
  Result = m_NifFile.Write(lpszPathName);

  if (!Result) {
    ErrorHandler.Notify("NIF Save Error");
    return (FALSE);
   }

  SetModifiedFlag(FALSE);
  return (TRUE); 
 }
/*===========================================================================
 *		End of Class Event CNifTextureDoc::OnSaveDocument()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CNifTextureDoc Method - void Serialize (Ar);
 *
 * Not used.
 *
 *=========================================================================*/
void CNifTextureDoc::Serialize(CArchive& Ar) {
  ASSERT(false);
 }
/*===========================================================================
 *		End of Class Method CNifTextureDoc::Serialize()
 *=========================================================================*/


#ifdef _DEBUG
/*===========================================================================
 *
 * Class CNifTextureDoc Diagnostics
 * 
 *=========================================================================*/
void CNifTextureDoc::AssertValid() const {
  CDocument::AssertValid();
 }

void CNifTextureDoc::Dump(CDumpContext& dc) const {
  CDocument::Dump(dc);
 }
/*===========================================================================
 *		End of Class CNifTextureDoc Diagnostics
 *=========================================================================*/
#endif


/*===========================================================================
 *
 * Class CNifTextureDoc Method - BOOL SaveModified ();
 *
 * Description
 *
 *=========================================================================*/
BOOL CNifTextureDoc::SaveModified() {

  	/* Ensure all views update the document data */
  UpdateAllViews(NULL, NIFTEXTDOC_VIEWHINT_UPDATE, NULL);
	
  return CDocument::SaveModified();
 }
/*===========================================================================
 *		End of Class Method CNifTextureDoc::SaveModified()
 *=========================================================================*/

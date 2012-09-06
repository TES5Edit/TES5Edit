/*===========================================================================
 *
 * File:	NifTextureDoc.H
 * Author:	Dave Humphrey (uesp@m0use.net)
 * Created On:	Saturday, 28 December, 2002
 *
 * Definition of the CNifTextureDoc document class.
 *
 *=========================================================================*/
#ifndef __NifTextureDoc_H
#define __NifTextureDoc_H


/*===========================================================================
 *
 * Begin Required Includes
 *
 *=========================================================================*/
  #include "NifFile.h"
/*===========================================================================
 *		End of Required Includes
 *=========================================================================*/


/*===========================================================================
 *
 * Begin Definitions
 *
 *=========================================================================*/
  #define NIFTEXTDOC_VIEWHINT_UPDATE 1
/*===========================================================================
 *		End of Definitions
 *=========================================================================*/



	/* Forward declarations */


/*===========================================================================
 *
 * Class CNifTextureDoc Definition
 * 
 *=========================================================================*/
class CNifTextureDoc : public CDocument {

  /*---------- Begin Protected Class Members --------------------------*/
protected:
  CNifFile	m_NifFile;


  /*---------- Begin Protected Class Methods --------------------------*/
protected:
	
	/* Create from serialization only */
  CNifTextureDoc();
  DECLARE_DYNCREATE(CNifTextureDoc)



  /*---------- Begin Public Class Methods -----------------------------*/
public:

	/* Destructor */
  virtual ~CNifTextureDoc();

	/* Return class members */
  CNifFile* GetNifFile (void) { return (&m_NifFile); }

	/* Diagnostics */
#ifdef _DEBUG
  virtual void AssertValid() const;
  virtual void Dump(CDumpContext& dc) const;
#endif


	/* ClassWizard generated virtual function overrides */
  //{{AFX_VIRTUAL(CNifTextureDoc)
	public:
  virtual BOOL OnNewDocument();
  virtual void Serialize(CArchive& ar);
  virtual BOOL OnOpenDocument(LPCTSTR lpszPathName);
  virtual void DeleteContents();
  virtual BOOL OnSaveDocument(LPCTSTR lpszPathName);
	protected:
	virtual BOOL SaveModified();
	//}}AFX_VIRTUAL


	/* Generated message map functions */
protected:
  //{{AFX_MSG(CNifTextureDoc)
  afx_msg void OnFileClose();
  //}}AFX_MSG

  DECLARE_MESSAGE_MAP()

 };
/*===========================================================================
 *		End of Class CNifTextureDoc Definition
 *=========================================================================*/


//{{AFX_INSERT_LOCATION}}
//}}AFX_INSERT_LOCATION Microsoft Visual C++ will insert additional declarations immediately before the previous line.


#endif
/*===========================================================================
 *		End of File NifTextureDoc.H
 *=========================================================================*/
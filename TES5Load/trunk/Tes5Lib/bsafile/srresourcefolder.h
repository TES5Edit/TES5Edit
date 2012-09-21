/*===========================================================================
 *
 * File:		Srresourcefolder.H
 * Author:		Dave Humphrey (dave@uesp.net)
 * Created On:	26 November 2011
 *
 * Defines the CSrResourceFolder class for handling a folder of resources.
 *
 *=========================================================================*/
#ifndef __SRRESOURCEFOLDER_H
#define __SRRESOURCEFOLDER_H


/*===========================================================================
 *
 * Begin Required Includes
 *
 *=========================================================================*/
  #include "srresourcebase.h"
  #include "srresourcefile.h"
  #include "srresourcescript.h"
  #include "srresourcecompiledscript.h"
  #include "srbsafile.h"
  #include "../common/dl_map.h"
/*===========================================================================
 *		End of Required Includes
 *=========================================================================*/


/*===========================================================================
 *
 * Begin Type Definitions
 *
 *=========================================================================*/

	/* Forward class definitions */
  class CSrResourceHandler;

  	/* File/folder map */
  typedef TGenRefPtrMap<CSString, CSrResourceBase, const char*> CSrResourceMap;

/*===========================================================================
 *		End of Type Definitions
 *=========================================================================*/


/*===========================================================================
 *
 * Begin Class CSrResourceFolder Definition
 *
 *=========================================================================*/
class CSrResourceFolder : public CSrResourceBase 
{

  /*---------- Begin Protected Class Members --------------------*/
protected:
  CSrResourceMap		m_Resources;

  CSrResourceFolder*	m_pParent;
  CSrResourceHandler*	m_pParentHandler;
  

  /*---------- Begin Protected Class Methods --------------------*/
protected:


  /*---------- Begin Public Class Methods -----------------------*/
public:

	/* Class Constructors/Destructors */
  CSrResourceFolder();
  virtual ~CSrResourceFolder() { Destroy(); }
  virtual void Destroy (void);

	/* Find a subfolder in the current path */
  CSrResourceFolder* FindSubFolder (const char* pPath);
  CSrResourceFile*   FindFile      (const char* pFilename);
  CSrResourceFile*   FindFullFile  (const char* pFilename);
  CSrResourceBase*   FindFullName  (const char* pFilename);

	/* Access or create a new sub-folder or file */
  CSrResourceFolder* GetFolderCreate (const char* pPath);
  CSrResourceFile*   GetFileCreate   (const char* pFilename);

	/* Get class members */
  //CSrResourceArray&   GetResources     (void) { return (m_Resources); }
  CSrResourceMap&     GetResources     (void) { return (m_Resources); }
  dword               GetNumResources  (void) { return (m_Resources.GetSize()); }
  CSrResourceFolder*  GetParent        (void) { return (m_pParent); }
  CSrResourceHandler* GetParentHandler (void) { return (m_pParentHandler); }
  const char*         GetBasePath      (void);

	/* Get the full filename of the resource */
  const char* GetFullName (void);

	/* Abstract methods */
  virtual bool IsFolder (void) const { return (true); }

	/* Set class members */
  void SetParent        (CSrResourceFolder*  pParent) { m_pParent        = pParent; }
  void SetParentHandler (CSrResourceHandler* pParent) { m_pParentHandler = pParent; }



};
/*===========================================================================
 *		End of Class CSrResourceFolder Definition
 *=========================================================================*/


#endif
/*===========================================================================
 *		End of File Srresourcefolder.H
 *=========================================================================*/

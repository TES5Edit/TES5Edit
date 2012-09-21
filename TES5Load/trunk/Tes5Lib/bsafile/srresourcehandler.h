/*===========================================================================
 *
 * File:		Srresourcehandler.H
 * Author:		Dave Humphrey (dave@uesp.net)
 * Created On:	26 November 2011
 *
 * Description
 *
 *=========================================================================*/
#ifndef __SRRESOURCEHANDLER_H
#define __SRRESOURCEHANDLER_H


/*===========================================================================
 *
 * Begin Required Includes
 *
 *=========================================================================*/
  #include "srresourcefolder.h"
  #include "srresourcefile.h"
/*===========================================================================
 *		End of Required Includes
 *=========================================================================*/


/*===========================================================================
 *
 * Begin Class CSrResourceHandler Definition
 *
 *=========================================================================*/
class CSrResourceHandler {

  /*---------- Begin Protected Class Members --------------------*/
protected:
  CSrResourceFolder	m_RootFolder;

  CSString		m_BasePath;
  

  /*---------- Begin Protected Class Methods --------------------*/
protected:

  bool AddBsaFileRecord (CSrBsaFileRecord* pRecord);


  /*---------- Begin Public Class Methods -----------------------*/
public:

	/* Class Constructors/Destructors */
  CSrResourceHandler();
  virtual ~CSrResourceHandler() { Destroy(); }
  virtual void Destroy (void);

	/* Add the contents of the given BSA file */
  bool AddBsaFile (CSrBsaFile* pBsaFile);

	/* Add contents of a path and all contained subpaths */
  bool AddPathContents    (const char* pRootPath, const bool IncludeRootFiles = true);
  bool AddPathContents    (CSrResourceFolder* pFolder, const char* pPath, const bool IncludeFiles);

	/* Find the file with the given path */
  CSrResourceFile* FindFile (const char* pFilename);
  CSrResourceBase* FindName (const char* pFilename);

  CSrScriptFile* FindScriptFile (const char* pFilename);

  CSrResourceFolder* GetScriptsFolder (void);

	/* Get class members */
  CSrResourceFolder& GetRootFolder (void) { return m_RootFolder; }
  const char*        GetBasePath   (void) { return m_BasePath; }

	/* Set class members */
  void SetBasePath      (const char* pString) { m_BasePath      = pString; }
  
};
/*===========================================================================
 *		End of Class CSrResourceHandler Definition
 *=========================================================================*/


#endif
/*===========================================================================
 *		End of File Srresourcehandler.H
 *=========================================================================*/

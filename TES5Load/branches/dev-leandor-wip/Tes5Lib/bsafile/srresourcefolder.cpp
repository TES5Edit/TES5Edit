/*===========================================================================
 *
 * File:		Srresourcefolder.CPP
 * Author:		Dave Humphrey (dave@uesp.net)
 * Created On:	26 November 2011
 *
 * Description
 *
 *=========================================================================*/

	/* Include Files */
#include "srresourcefolder.h"
#include "srresourcehandler.h"


/*===========================================================================
 *
 * Class CSrResourceFolder Constructor
 *
 *=========================================================================*/
CSrResourceFolder::CSrResourceFolder() 
{
	m_pParent        = NULL;
	m_pParentHandler = NULL;

	m_Resources.InitHashTable(1203);
}
/*===========================================================================
 *		End of Class CSrResourceFolder Constructor
 *=========================================================================*/


/*===========================================================================
 *
 * Class CSrResourceFolder Method - void Destroy (void);
 *
 *=========================================================================*/
void CSrResourceFolder::Destroy (void) 
{
  m_Resources.Destroy();
  
  m_pParent        = NULL;
  m_pParentHandler = NULL; 

  CSrResourceBase::Destroy();
}
/*===========================================================================
 *		End of Class Method CSrResourceFolder::Destroy()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CSrResourceFolder Method - CSrResourceFile* FindFile (pFilename);
 *
 *=========================================================================*/
CSrResourceFile* CSrResourceFolder::FindFile (const char* pFilename) 
{
  CSrResourceBase*   pBase;

  pBase = m_Resources.Lookup(pFilename);
  if (pBase == NULL) return (NULL);

  if (!pBase->IsFolder()) return (CSrResourceFile *) pBase;
  return (NULL);
}
/*===========================================================================
 *		End of Class Method CSrResourceFolder::FindFile()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CSrResourceFolder Method - CSrResourceFile* FindFullFile (pFilename);
 *
 *=========================================================================*/
CSrResourceFile* CSrResourceFolder::FindFullFile (const char* pFilename) {
  CSrResourceBase* pBase;
  CSString         Buffer(pFilename);
  int              Index;

  Index = Buffer.FindChar('\\');

	/* Find a file if no more path left */
  if (Index < 0) {
    pBase = FindFile(Buffer);
    if (pBase == NULL || pBase->IsFolder()) return (NULL);
    return (CSrResourceFile *) pBase;
  }

  CSString SubPath(Buffer);
  SubPath.Truncate(Index);
  Buffer.Delete(0, Index + 1);

  pBase = FindSubFolder(SubPath);
  if (pBase == NULL || !pBase->IsFolder()) return (NULL);
    
  return ((CSrResourceFolder *) pBase)->FindFullFile(Buffer);
}
/*===========================================================================
 *		End of Class Method CSrResourceFolder::FindFullFile()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CSrResourceFolder Method - CSrResourceFile* FindFullName (pFilename);
 *
 *=========================================================================*/
CSrResourceBase* CSrResourceFolder::FindFullName (const char* pFilename) {
  CSrResourceBase* pBase;
  CSString         Buffer(pFilename);
  int              Index;

  Index = Buffer.FindChar('\\');

	/* Find a file if no more path left */
  if (Index < 0) {
    pBase = FindFile(Buffer);
    return pBase;
  }

  CSString SubPath(Buffer);
  SubPath.Truncate(Index);
  Buffer.Delete(0, Index + 1);

  pBase = FindSubFolder(SubPath);
  if (pBase == NULL) return (NULL);
   
  if (Buffer.IsEmpty()) return (pBase);
  return ((CSrResourceFolder *) pBase)->FindFullName(Buffer);
}
/*===========================================================================
 *		End of Class Method CSrResourceFolder::FindFullName()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CSrResourceFolder Method - CSrResourceFolder* FindSubFolder (pPath);
 *
 *=========================================================================*/
CSrResourceFolder* CSrResourceFolder::FindSubFolder (const char* pPath) {
  CSrResourceBase*   pBase;
      
  pBase = m_Resources.Lookup(pPath);
  if (pBase == NULL) return (NULL);

  if (pBase->IsFolder()) return (CSrResourceFolder *) pBase;
  return (NULL);
}
/*===========================================================================
 *		End of Class Method CSrResourceFolder::FindSubFolder()
 *=========================================================================*/


/*===========================================================================
 *
 * Class char* CSrResourceFolder Method - const GetBasePath (void);
 *
 *=========================================================================*/
const char* CSrResourceFolder::GetBasePath (void) { 
   return (m_pParentHandler ? m_pParentHandler->GetBasePath() : "");
}
/*===========================================================================
 *		End of Class Method char* CSrResourceFolder::GetBasePath()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CSrResourceFolder Method - CSrResourceFile* GetFileCreate (pFilename);
 *
 *=========================================================================*/
CSrResourceFile* CSrResourceFolder::GetFileCreate (const char* pFilename) {
  CSrResourceFile* pFile;

	/* Ignore invalid or empty path strings */
  if (pFilename == NULL || *pFilename == NULL_CHAR) {
    AddSrGeneralError("Invalid or empty resource filename string!");
    return (NULL);
  }

	/* Find an existing folder */
  pFile = FindFile(pFilename);
  if (pFile != NULL) return (pFile);

		/* Create a source or compiled script file object if required */
  if (SrCheckExtension(pFilename, "psc"))
  {
	    CSrResourceScript* pScriptFile = CSrResourceBase::CSrResourceScriptAllocator.CreateObject();
		m_Resources.SetAt(pFilename, pScriptFile);

		pScriptFile->SetParent(this);
		pScriptFile->SetName(pFilename);
  
		return pScriptFile;
  }
  else if (SrCheckExtension(pFilename, "pex"))
  {
	    CSrResourceCompiledScript* pScript = CSrResourceBase::CSrResourceCompiledScriptAllocator.CreateObject();
		m_Resources.SetAt(pFilename, pScript);

		pScript->SetParent(this);
		pScript->SetName(pFilename);
		pScript->InitScriptInfo();
  
		return pScript;
  }

	/* Create a new one */
  pFile = CSrResourceBase::CSrResourceFileAllocator.CreateObject();
  m_Resources.SetAt(pFilename, pFile);

  pFile->SetParent(this);
  pFile->SetName(pFilename);
  
  return (pFile);
}
/*===========================================================================
 *		End of Class Method CSrResourceFolder::GetFileCreate()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CSrResourceFolder Method - CSrResourceFolder* GetFolderCreate (pPath);
 *
 *=========================================================================*/
CSrResourceFolder* CSrResourceFolder::GetFolderCreate (const char* pPath) {
  CSrResourceFolder* pFolder;

	/* Ignore invalid or empty path strings */
  if (pPath == NULL || *pPath == NULL_CHAR) {
    AddSrGeneralError("Invalid or empty resource path string!");
    return (NULL);
  }

	/* Find an existing folder */
  pFolder = FindSubFolder(pPath);
  if (pFolder != NULL) return (pFolder);

	/* Create a new one */
  pFolder = CSrResourceBase::CSrResourceFolderAllocator.CreateObject();
  m_Resources.SetAt(pPath, pFolder);

  pFolder->SetParentHandler(m_pParentHandler);
  pFolder->SetParent(this);
  pFolder->SetName(pPath);

  return (pFolder);
}
/*===========================================================================
 *		End of Class Method CSrResourceFolder::GetFolderCreate()
 *=========================================================================*/


/*===========================================================================
 *
 * Class char* CSrResourceFolder Method - const GetFullName (void);
 *
 *=========================================================================*/
const char* CSrResourceFolder::GetFullName (void) {
  static CSString s_Buffer;

  if (m_pParent != NULL) {
    s_Buffer = m_pParent->GetFullName();
  }
  else {
    s_Buffer.Empty();
  }
  
  if (!m_Name.IsEmpty()) {
    s_Buffer += GetName();
    s_Buffer += "\\";
  }

  return (s_Buffer);
}
/*===========================================================================
 *		End of Class Method char* CSrResourceFolder::GetFullName()
 *=========================================================================*/

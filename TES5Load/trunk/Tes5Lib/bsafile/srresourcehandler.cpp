/*===========================================================================
 *
 * File:		Srresourcehandler.CPP
 * Author:		Dave Humphrey (dave@uesp.net)
 * Created On:	26 November 2011
 *
 * Description
 *
 *=========================================================================*/

	/* Include Files */
#include "srresourcehandler.h"
#include "windows.h"


/*===========================================================================
 *
 * Class CSrResourceHandler Constructor
 *
 *=========================================================================*/
CSrResourceHandler::CSrResourceHandler() 
{
  m_RootFolder.SetParentHandler(this);
}
/*===========================================================================
 *		End of Class CSrResourceHandler Constructor
 *=========================================================================*/


/*===========================================================================
 *
 * Class CSrResourceHandler Method - void Destroy (void);
 *
 *=========================================================================*/
void CSrResourceHandler::Destroy (void) 
{
  m_RootFolder.Destroy();
  m_RootFolder.SetParentHandler(this);
}
/*===========================================================================
 *		End of Class Method CSrResourceHandler::Destroy()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CSrResourceHandler Method - bool AddBsaFileRecord (pRecord);
 *
 *=========================================================================*/
bool CSrResourceHandler::AddBsaFileRecord (CSrBsaFileRecord* pRecord) {
  CSrResourceFolder* pFolder = &m_RootFolder;
  CSrResourceFolder* pNextFolder;
  CSrResourceFile*   pFile;
  char               PathBuffer[256];
  char*		     pParse;

	/* Parse out the full path */
  strnncpy(PathBuffer, pRecord->GetFullPath(), 250);
  pParse = strtok(PathBuffer, "\\");

  while (pParse != NULL) {
    pNextFolder = pFolder->GetFolderCreate(pParse);
    if (pNextFolder == NULL) return (false);

    pParse  = strtok(NULL, "\\");
    pFolder = pNextFolder;
  }

	/* Add the resource to the folder */
  pFile = pFolder->GetFileCreate(pRecord->GetFilename());
  if (pFile == NULL) return (false);

  pFile->AddInstance(pRecord);

  return (true);
}
/*===========================================================================
 *		End of Class Method CSrResourceHandler::AddBsaFileRecord()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CSrResourceHandler Method - bool AddPathContents (pRootPath, IncludeRootFiles);
 *
 *=========================================================================*/
bool CSrResourceHandler::AddPathContents (const char* pRootPath, const bool IncludeRootFiles) {
  return AddPathContents(&m_RootFolder, pRootPath, IncludeRootFiles);
}
/*===========================================================================
 *		End of Class Method CSrResourceHandler::AddPathContents()
 *=========================================================================*/


typedef CSrPtrArray<WIN32_FIND_DATA> CFindDataArray;
/*===========================================================================
 *
 * Class CSrResourceHandler Method - bool AddPathContents (pFolder, pRootPath, IncludeRootFiles);
 *
 *=========================================================================*/
bool CSrResourceHandler::AddPathContents (CSrResourceFolder* pFolder, const char* pPath, const bool IncludeRootFiles) 
{
  WIN32_FIND_DATA		FindData;
  WIN32_FIND_DATA*		pNewPath;
  CFindDataArray		FindPaths;
  CSrResourceFolder*	pNewFolder;
  CSrResourceFile*		pFile;
  CSrResourceInstance*	pInstance;
  CSString				FindSpec(pPath);
  HANDLE				hFind;
  BOOL					FindResult;
  dword					Index;
  bool					ReturnResult = true;

  TerminatePath(FindSpec);
  FindSpec += "*.*";

	/* Add all matching files and find all sub-paths */
  hFind = FindFirstFile(FindSpec, &FindData);
  if (hFind == INVALID_HANDLE_VALUE) return (true);

  do {
    if ((FindData.dwFileAttributes & FILE_ATTRIBUTE_DIRECTORY) != 0) {
		if (strcmp(FindData.cFileName, ".") == 0 || strcmp(FindData.cFileName, "..") == 0)
		{
			FindResult = FindNextFile(hFind, &FindData);
			continue;
		}

      pNewPath = new WIN32_FIND_DATA;
      FindPaths.Add(pNewPath);
      *pNewPath = FindData;
    }
    else if (IncludeRootFiles) {
      pFile = pFolder->GetFileCreate(FindData.cFileName);

		/* TODO: Set filesize/time here from find data */
      if (pFile != NULL) {
        pInstance = pFile->AddInstance(FindData.cFileName);

	if (pInstance != NULL) {
	  pInstance->SetFiletime(FindData.ftLastWriteTime.dwLowDateTime, FindData.ftLastWriteTime.dwHighDateTime);
	  pInstance->SetFilesize(FindData.nFileSizeLow, FindData.nFileSizeHigh);
	}
      }
      else
        ReturnResult = false;
    }

    FindResult = FindNextFile(hFind, &FindData);
  } while (FindResult);

  FindClose(hFind);

	/* Recursively iterate through all found sub-paths */
  for (Index = 0; Index < FindPaths.GetSize(); ++Index) {
    pNewPath = FindPaths.GetAt(Index);
    if (strcmp(pNewPath->cFileName, ".") == 0) continue;
    if (strcmp(pNewPath->cFileName, "..") == 0) continue;

    pNewFolder = pFolder->GetFolderCreate(pNewPath->cFileName);

    if (pNewFolder != NULL) {
      FindSpec  = pPath;
      FindSpec += pNewPath->cFileName;
      FindSpec += "\\";
      ReturnResult &= AddPathContents(pNewFolder, FindSpec, true);
    }
    else {
      ReturnResult = false;
    }
  }

  FindPaths.Destroy();
  return (ReturnResult);
}
/*===========================================================================
 *		End of Class Method CSrResourceHandler::AddPathContents()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CSrResourceHandler Method - bool AddBsaFile (pBsaFile);
 *
 *=========================================================================*/
bool CSrResourceHandler::AddBsaFile (CSrBsaFile* pBsaFile) {
  CSrBsaFileRecord* pRecord;
  BSAPOSITION       FilePos;

	/* Ignore invalid input */
  if (pBsaFile == NULL) return (false);

	/* Add all files in the BSA archive */
  pRecord = pBsaFile->GetFirstFile(FilePos);

  while (pRecord != NULL) {
    AddBsaFileRecord(pRecord);
    pRecord = pBsaFile->GetNextFile(FilePos);
  }

  return (true);
}
/*===========================================================================
 *		End of Class Method CSrResourceHandler::AddBsaFile()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CSrResourceHandler Method - CSrResourceFile* FindFile (pFilename);
 *
 *=========================================================================*/
CSrResourceFile* CSrResourceHandler::FindFile (const char* pFilename) 
{
	return m_RootFolder.FindFullFile(pFilename);
}
/*===========================================================================
 *		End of Class Method CSrResourceHandler::FindFile()
 *=========================================================================*/


CSrScriptFile* CSrResourceHandler::FindScriptFile (const char* pFilename)
{
	CSrResourceFile* pFile = m_RootFolder.FindFullFile(pFilename);
	if (pFile == NULL) return NULL;
	return pFile->GetScriptFile();
}


/*===========================================================================
 *
 * Class CSrResourceHandler Method - CSrResourceBase* FindName (pFilename);
 *
 *=========================================================================*/
CSrResourceBase* CSrResourceHandler::FindName (const char* pFilename) 
{
	return m_RootFolder.FindFullName(pFilename);
}
/*===========================================================================
 *		End of Class Method CSrResourceHandler::FindName()
 *=========================================================================*/



CSrResourceFolder* CSrResourceHandler::GetScriptsFolder (void)
{
	CSrResourceBase* pBasePath = FindName("scripts\\source\\");
	if (pBasePath == NULL || !pBasePath->IsFolder()) return NULL;

	return (CSrResourceFolder *) pBasePath;
}
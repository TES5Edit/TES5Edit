/*===========================================================================
 *
 * File:		Srresourcefile.CPP
 * Author:		Dave Humphrey (dave@uesp.net)
 * Created On:	26 November 2011
 *
 * Description
 *
 *=========================================================================*/

	/* Include Files */
#include "srresourcefile.h"
#include "srresourcefolder.h"


TSrBlockAllocator<CSrResourceFolder>			CSrResourceBase::CSrResourceFolderAllocator;
TSrBlockAllocator<CSrResourceFile>				CSrResourceBase::CSrResourceFileAllocator;
TSrBlockAllocator<CSrResourceScript>			CSrResourceBase::CSrResourceScriptAllocator;
TSrBlockAllocator<CSrResourceCompiledScript>	CSrResourceBase::CSrResourceCompiledScriptAllocator;
TSrBlockAllocator<CSrResourceInstance>			CSrResourceBase::CSrResourceInstanceAllocator;


/*===========================================================================
 *
 * Class CSrResourceFile Constructor
 *
 *=========================================================================*/
CSrResourceFile::CSrResourceFile() 
{
  m_pParent      = NULL;
  m_ResourceType = SR_RESOURCETYPE_UNKNOWN;
}
/*===========================================================================
 *		End of Class CSrResourceFile Constructor
 *=========================================================================*/


/*===========================================================================
 *
 * Class CSrResourceFile Method - void Destroy (void);
 *
 *=========================================================================*/
void CSrResourceFile::Destroy (void) 
{
  m_Instances.Destroy();

  m_pParent      = NULL;
  m_ResourceType = SR_RESOURCETYPE_UNKNOWN;

  CSrResourceBase::Destroy();
}
/*===========================================================================
 *		End of Class Method CSrResourceFile::Destroy()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CSrResourceFile Method - CSrResourceInstance* AddInstance (pRecord);
 *
 *=========================================================================*/
CSrResourceInstance* CSrResourceFile::AddInstance (CSrBsaFileRecord* pRecord) 
{
	CSrResourceInstance* pInstance;

	pInstance = CSrResourceBase::CSrResourceInstanceAllocator.CreateObject();
	m_Instances.Add(pInstance);

	pInstance->SetParent(this);
	pInstance->SetBsaRecord(pRecord);

	if (m_Instances.GetSize() == 1) m_ResourceType = pInstance->GetResourceType();
	pInstance->UpdateFileInfo();
	return (pInstance);
}
/*===========================================================================
 *		End of Class Method CSrResourceFile::AddInstance()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CSrResourceFile Method - CSrResourceInstance* AddInstance (pFilename);
 *
 *=========================================================================*/
CSrResourceInstance* CSrResourceFile::AddInstance (const char* pFilename) 
{
	CSrResourceInstance* pInstance;

	pInstance = CSrResourceBase::CSrResourceInstanceAllocator.CreateObject();
	m_Instances.Add(pInstance);

	pInstance->SetParent(this);
	pInstance->SetFilename(pFilename);

	if (m_Instances.GetSize() == 1) m_ResourceType = pInstance->GetResourceType();
	pInstance->UpdateFileInfo();
	return (pInstance);
}
/*===========================================================================
 *		End of Class Method CSrResourceFile::AddInstance()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CSrResourceFile Method - const char* GetBasePath (void);
 *
 *=========================================================================*/
const char* CSrResourceFile::GetBasePath (void) { 
   return (m_pParent ? m_pParent->GetBasePath() : ""); 
}
/*===========================================================================
 *		End of Class Method CSrResourceFile::GetBasePath()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CSrResourceFile Method - int64 GetFilesize (void);
 *
 *=========================================================================*/
int64 CSrResourceFile::GetFilesize (void) {
  CSrResourceInstance* pInstance = GetMainInstance();
  if (pInstance == NULL) return (-1);
  return pInstance->GetFilesize();
}
/*===========================================================================
 *		End of Class Method CSrResourceFile::GetFilesize()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CSrResourceFile Method - uint64 GetFiletime (void);
 *
 *=========================================================================*/
dword64 CSrResourceFile::GetFiletime (void) {
  CSrResourceInstance* pInstance = GetMainInstance();
  if (pInstance == NULL) return (0);
  return pInstance->GetFiletime();
}
/*===========================================================================
 *		End of Class Method CSrResourceFile::GetFiletime()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CSrResourceFile Method - const char* GetFullName (void);
 *
 *=========================================================================*/
const char* CSrResourceFile::GetFullName (void) {
  static CSString s_Buffer;

  if (m_pParent == NULL) return GetName();

  s_Buffer  = m_pParent->GetFullName();
  //s_Buffer += "\\";
  s_Buffer += GetName();

  return (s_Buffer);
}
/*===========================================================================
 *		End of Class Method CSrResourceFile::GetFullName()
 *=========================================================================*/


/*===========================================================================
 *
 * Class char* CSrResourceFile Method - const GetCSName (void);
 *
 * Removes the first path from the full path.
 *
 *=========================================================================*/
const char* CSrResourceFile::GetCSName (void) {
  static CSString s_Buffer;
  int             Index;

  s_Buffer = GetFullName();

  Index = s_Buffer.FindChar('\\');
  if (Index >= 0) s_Buffer.Delete(0, Index + 1);

  return (s_Buffer);
}
/*===========================================================================
 *		End of Class Method char* CSrResourceFile::GetCSName()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CSrResourceFile Method - bool IsInPath (pPath);
 *
 *=========================================================================*/
bool CSrResourceFile::IsInPath (const char* pPath) { 
  const char* pFull = GetFullName();
  return (strnicmp(pFull, pPath, strlen(pPath)) == 0); 
}
/*===========================================================================
 *		End of Class Method CSrResourceFile::IsInPath()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CSrResourceFile Method - void SetMainInstances (pInstance);
 *
 *=========================================================================*/
void CSrResourceFile::SetMainInstances (CSrResourceInstance* pInstance) {
  CSrResourceInstance*	pMainInstance;
  int			Index;

	/* Ignore if invalid or only one instance */
  if (pInstance == NULL || GetNumInstances() <= 1) return;

	/* Find the instance */
  Index = m_Instances.Find(pInstance);
  if (Index <= 0) return;

  pMainInstance = m_Instances.GetAt(0);
  if (pMainInstance == NULL) return;

	/* TODO: Swap instances */
  //m_Instances.SetAt(0, pInstance);
  //m_Instances.SetAt(Index, pMainInstance);
}
/*===========================================================================
 *		End of Class Method CSrResourceFile::SetMainInstances()
 *=========================================================================*/



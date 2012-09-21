/*===========================================================================
 *
 * File:		SrEspFile.CPP
 * Author:		Dave Humphrey (dave@uesp.net)
 * Created On:	26 November 2011
 *
 * Defines the CSrEspFile for loading, handling, and saving ESP plugin files.
 * Note that ESM files are considered to be a special case of ESP files so
 * is derived from this class. 
 *
 *=========================================================================*/

	/* Include Files */
#include "srespfile.h"
#include "srrecordhandler.h"
#include "../common/srtime.h"
#include <direct.h>
#include "../common/srutils.h"


/*===========================================================================
 *
 * Class CSrEspFile Constructor
 *
 *=========================================================================*/
CSrEspFile::CSrEspFile (void)
{
  m_pParent = NULL;
  m_pHeader = NULL;

  m_IsActive   = false;
  m_ModIndex   = 0;
  m_CacheFlags = 0;
  m_NextStringID = 1;

  m_Records.SetParent(NULL);
  m_Records.SetParentGroup(NULL);
  m_Records.GetHeader().GroupType = SR_GROUP_NONE;
}
/*===========================================================================
 *		End of Class CSrEspFile Constructor
 *=========================================================================*/


/*===========================================================================
 *
 * Class CSrEspFile Destructor
 *
 *=========================================================================*/
CSrEspFile::~CSrEspFile ()
{
  Destroy();
}
/*===========================================================================
 *		End of Class CSrEspFile Destructor
 *=========================================================================*/


/*===========================================================================
 *
 * Class CSrEspFile Method - void Destroy (void);
 *
 * Delete object contents.
 *
 *=========================================================================*/
void CSrEspFile::Destroy (void)
{
  m_pHeader    = NULL;
  m_IsActive   = false;

  m_Filename.Empty();
  m_ShortFilename.Empty();

  m_File.Close();

  m_Records.Destroy();
  m_Records.GetHeader().GroupType = SR_GROUP_NONE;
}
/*===========================================================================
 *		End of Class Method CSrEspFile::Destroy()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CSrEspFile Method - bool AddRecord (pNewRecord);
 *
 * Adds a record/group to the file determining where in the group
 * heirarchy to add it. Returns false on any error.
 *
 *=========================================================================*/
bool CSrEspFile::AddRecord (CSrRecord* pNewRecord)
{
  CSrBaseRecord* pRecord;
  dword		 Index;
  bool		 Result;

	/* Special case for a TES4 record */
  if (pNewRecord->GetRecordType() == SR_NAME_TES4) {
    m_Records.GetRecords().Add(pNewRecord);
    pNewRecord->SetParentGroup(NULL);
    return (true);
  }

  for (Index = 0; Index < m_Records.GetNumRecords(); ++Index) {
    pRecord = m_Records.GetRecord(Index);

    Result = pRecord->AddChildRecord(pNewRecord);

    if (Result) {
      ModRecordCount(1);
      return (true);
    }
  }

	/* If we reached here we didn't find any place to add the record */
  Result = CreateTopLevelGroup(pNewRecord);

	/* Couldn't add a new group to contain record either */
  if (!Result)
  {
    AddSrGeneralError("Failed to find the correct insert location for record 0x%X!", pNewRecord->GetFormID());
    m_Records.GetRecords().Add(pNewRecord);
    pNewRecord->SetParentGroup(NULL);
    ModRecordCount(1);
    return (false);
  }

  return (true);
}
/*===========================================================================
 *		End of Class Method CSrEspFile::AddRecord()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CSrEspFile Method - CSrRecord* CreateNewRecord (Type);
 *
 * Creates and adds a new record to the file as given by the input
 * record type. The new record is returned.
 *
 *=========================================================================*/
CSrRecord* CSrEspFile::CreateNewRecord (const srrectype_t Type) {
  CSrRecord* pRecord;
  bool	     Result;
  
  pRecord = CreateSrRecord(Type);
  pRecord->InitializeNew();
  pRecord->SetParent(this);

  Result = AddRecord(pRecord);
  if (!Result) return (NULL);
  
	/* Set the header record reference */
  if (pRecord->GetRecordType() == SR_NAME_TES4) 
  {
    m_pHeader = SrCastClass(CSrTes4Record, pRecord);
  }
   	/* Update the overall record count */
  else if (m_pHeader != NULL) 
  {
    m_pHeader->ModRecordCount(1);
  }

  return (pRecord);
}
/*===========================================================================
 *		End of Class Method CSrEspFile::CreateNewRecord()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CSrEspFile Method - bool CreateTopLevelGroup (pNewRecord);
 *
 * Creates a top level group for the given record and adds the record
 * to the group. Returns false if the group could not be created or
 * the record not added.
 *
 *=========================================================================*/
bool CSrEspFile::CreateTopLevelGroup (CSrBaseRecord* pNewRecord) {
  CSrTypeGroup* pGroup;
  bool          Result;

  if (pNewRecord == NULL) return (false);
  pGroup = CreateTopLevelGroup(pNewRecord->GetRecordType());
  if (pGroup == NULL) return (false);

  Result = pGroup->AddChildRecord(pNewRecord);
  if (Result) ModRecordCount(1);
  return (Result);
}
/*===========================================================================
 *		End of Class Method CSrEspFile::CreateTopLevelGroup()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CSrEspFile Method - int FindTopGroupInsertPos (Type);
 *
 *=========================================================================*/
CSrBaseRecord* CSrEspFile::FindTopGroupInsertPos (const srrectype_t Type) {
  CSrBaseRecord* pBase;
  CSrBaseRecord* pLastInsert = NULL;
  CSrTypeGroup*  pTypeGroup;
  dword		 Index;
  dword		 TypeIndex = 0;
  
  for (Index = 0; Index < m_Records.GetNumRecords(); ++Index) {
    pBase = m_Records.GetRecord(Index);

    if (pBase->IsRecord()) {
      if (Index == 0) pLastInsert = pBase;
      continue;
    }

    pTypeGroup = SrCastClass(CSrTypeGroup, pBase);
    if (pTypeGroup == NULL) continue;

    for (; s_TopLevelTypeOrder[TypeIndex] != NULL; ++TypeIndex) {
      if (Type == *s_TopLevelTypeOrder[TypeIndex]) return (pLastInsert);
      if (pTypeGroup->GetContainsType() == *s_TopLevelTypeOrder[TypeIndex]) break;
    }

    pLastInsert = pTypeGroup;
  }

  return (pLastInsert);
}
/*===========================================================================
 *		End of Class Method CSrEspFile::FindTopGroupInsertPos()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CSrEspFile Method - CSrTypeGroup* CreateTopLevelGroup (Type);
 *
 * Create and return a top level type group for the given type. Returns 
 * NULL on any error.
 *
 *=========================================================================*/
CSrTypeGroup* CSrEspFile::CreateTopLevelGroup (const srrectype_t Type) {
  CSrTypeGroup*  pGroup;
  CSrBaseRecord* pNewRecord;
  CSrBaseRecord* pInsert;

	/* See if the given record is a valid top level group type */
  if (!IsSrTopLevelGroup(Type)) return (NULL);
  
	/* Create new group */
  pNewRecord = CreateSrGroup(SR_GROUP_TYPE);
  if (pNewRecord == NULL) return (NULL);

	/* Add group to records */
  pInsert = FindTopGroupInsertPos(Type);
  m_Records.GetRecords().InsertAfter(pNewRecord, pInsert);
  if (m_pHeader != NULL) m_pHeader->ModRecordCount(1);

	/* Initialize new group */
  pGroup = SrCastClass(CSrTypeGroup, pNewRecord);
  if (pGroup == NULL) return (NULL);
  pGroup->SetContainsType(Type);

  return (pGroup);
 }
/*===========================================================================
 *		End of Class Method CSrEspFile::CreateTopLevelGroup()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CSrEspFile Method - bool DeleteRecord (pRecord);
 *
 * Attempts to delete a record from the file.
 *
 *=========================================================================*/
bool CSrEspFile::DeleteRecord (CSrRecord* pRecord) {
  bool Result;

  if (pRecord == NULL) return (false);

  Result = m_Records.GetRecords().Delete(pRecord);
  if (Result && m_pHeader != NULL) m_pHeader->ModRecordCount(-1);

  return (Result);
 }
/*===========================================================================
 *		End of Class Method CSrEspFile::DeleteRecord()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CSrEspFile Method - dword Find (FindData, pCallback);
 *
 *=========================================================================*/
dword CSrEspFile::Find (srfinddata_t& FindData, CSrCallback* pCallback) {
  CSrBaseRecord* pBaseRecord;
  CSrRecord*     pRecord;
  CSrTypeGroup*	 pGroup;
  dword          FindCount = 0;
  dword          Index;
  dword          Count;
  bool		 FindText = (FindData.Flags & SR_FIND_COMPARETEXT) != 0;
  bool		 IsExcluded;
  bool		 Result;
  int            iResult;

  if (pCallback != NULL) {
    pCallback->SetTotalRecords(m_Records.GetNumRecords());
    pCallback->SetTotalRecords1(0);
    pCallback->Reset();
  }

  ++FindData.FileCount;
  
  for (Index = 0; Index < m_Records.GetNumRecords(); ++Index) {
    pBaseRecord = m_Records.GetRecord(Index);
    pRecord     = SrCastClass(CSrRecord, pBaseRecord);

    if (pRecord) {
      IsExcluded = SrContainsRecordType(pRecord->GetRecordType(), FindData.pExcludeRecords);
    }
    else {
      pGroup = SrCastClass(CSrTypeGroup, pBaseRecord);
      if (pGroup != NULL) IsExcluded = SrContainsRecordType(pGroup->GetContainsType(), FindData.pExcludeRecords);
    }
    
    if (pRecord == NULL || !IsExcluded) {
      if (FindText)
        Result = pBaseRecord->SearchText(Count, FindData);
      else
        Result = pBaseRecord->Search(Count, FindData);

      FindCount += Count;
      if (!Result) return (FindCount);
    
      if (pCallback != NULL) {
        iResult = pCallback->UpdateCallback(Index);
        if (iResult < 0) return (FindCount);
      }
    }
  }

  return (FindCount);
 }
/*===========================================================================
 *		End of Class Method CSrEspFile::Find()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CSrEspFile Method - CSString* FindLocalString (ID);
 *
 *=========================================================================*/
CSString* CSrEspFile::FindLocalString (const srlstringid_t ID)
{
	return m_StringMap.Lookup(ID);
	//return m_StringMap[ID];
}
/*===========================================================================
 *		End of Class Method CSrEspFile::FindLocalString()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CSrEspFile Method - CSrTypeGroup* GetTypeGroup (Type);
 *
 *=========================================================================*/
CSrTypeGroup* CSrEspFile::GetTypeGroup (const srrectype_t Type) {
  CSrBaseRecord* pRecord;
  CSrGroup*	 pGroup;
  CSrTypeGroup*	 pTypeGroup;
  dword		 Index;

	/* Search all top level groups for a match */
  for (Index = 0; Index < m_Records.GetNumRecords(); ++Index) {
    pRecord = m_Records.GetRecords().GetAt(Index);

    if (!pRecord->IsGroup()) continue;
    pGroup = SrCastClass(CSrGroup, pRecord);
    if (pGroup == NULL) continue;
    if (pGroup->GetType() != SR_GROUP_TYPE) continue;
    pTypeGroup = SrCastClass(CSrTypeGroup, pGroup);
    if (pTypeGroup == NULL) continue;

    if (Type == pTypeGroup->GetContainsType()) return (pTypeGroup);
   }

  return (NULL);
 }
/*===========================================================================
 *		End of Class Method CSrEspFile::GetTypeGroup()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CSrEspFile Method - void InitializeNew (void);
 *
 * Initialies a new file with any required records/groups. Any existing
 * content is destroyed.
 *
 *=========================================================================*/
void CSrEspFile::InitializeNew (void) {
  
	/* Clear the current data */
  Destroy();
  m_Records.SetParent(this);

	/* Add the TES4 record */
  CreateNewRecord(SR_NAME_TES4);
  assert(m_pHeader != NULL);
  
  SetFilename("noname.esp");
}
/*===========================================================================
 *		End of Class Method CSrEspFile::InitializeNew()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CSrEspFile Method - bool LoadStringFile (StringFile, pFilename, pCallback);
 *
 *=========================================================================*/
bool CSrEspFile::LoadStringFile (CSrStringFile& StringFile, const SSCHAR* pFilename, CSrCallback* pCallback)
{
	bool Result;

	StringFile.Destroy();

		/* A non-existant string file is not an error */
	if (!FileExists(pFilename)) return true;

	SystemLog.Printf("Loading strings file '%s'...", pFilename);

	if (pCallback) 
	{
		pCallback->SetLabel("Loading strings file '%s'...", pFilename);
		pCallback->ForceCallback(0);
	}

	Result = StringFile.Load(pFilename);
	return Result;
}
/*===========================================================================
 *		End of Class Method CSrEspFile::LoadStringFile()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CSrEspFile Method - bool LoadStringFiles (pCallback);
 *
 *=========================================================================*/
bool CSrEspFile::LoadStringFiles (CSrCallback* pCallback) 
{
	bool Result;

	Result  = LoadStringFile(m_LStringFile,  CreateSrStringFilename(m_Filename, "STRINGS"),   pCallback);
	Result &= LoadStringFile(m_DLStringFile, CreateSrStringFilename(m_Filename, "DLSTRINGS"), pCallback);
	Result &= LoadStringFile(m_ILStringFile, CreateSrStringFilename(m_Filename, "ILSTRINGS"), pCallback);
  
	return Result;
}
/*===========================================================================
 *		End of Class Method CSrEspFile::LoadStringFiles()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CSrEspFile Method - bool Load (pFilename, pCallback);
 *
 * Description
 *
 *=========================================================================*/
bool CSrEspFile::Load (const SSCHAR* pFilename, CSrCallback* pCallback) {
  srtimer_t Timer;  
  bool      Result;

		/* Clear the current object contents */
  Destroy();
  SetFilename(pFilename);
  m_Records.SetParent(this);
  
  SrStartTimer(Timer);

		/* Attempt to load any string files associated with the file */
  Result = LoadStringFiles(pCallback);
  MakeStringMap(pCallback);

  Result = CSrRecord::InitIOBuffers();
  if (!Result) return (false);

  Result = m_File.Open(pFilename, "rb");
  if (!Result) return (false);

  if (pCallback) pCallback->SetLabel("Loading '%s'...", pFilename);

  Result = Read(pCallback);

  SystemLog.Printf("End read position for file '%s' is 0x%08X.", pFilename, m_File.Tell64());
  m_File.Close();

  if (IsLocalStrings())
  {
	  LoadLocalStrings(pCallback);
  }    

  CSrRecord::DestroyIOBuffers();

  SrEndTimer(Timer, "\tLoaded file in");

  return (Result);
}
/*===========================================================================
 *		End of Class Method CSrEspFile::Load()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CSrEspFile Method - void MakeStringMap (pCallback);
 *
 *=========================================================================*/
void CSrEspFile::MakeStringMap (CSrCallback* pCallback)
{
	m_StringMap.Destroy();
	m_StringMap.InitHashTable(100000);

	if (pCallback)
	{
		pCallback->SetLabel("Making local string map...");
		pCallback->ForceCallback(0);
	}

	MakeStringMap(m_ILStringFile, pCallback);
	MakeStringMap(m_DLStringFile, pCallback);
	MakeStringMap(m_LStringFile, pCallback);
}
/*===========================================================================
 *		End of Class Method CSrEspFile::MakeStringMap()
 *=========================================================================*/


void CSrEspFile::MakeStringMap (CSrStringFile& StringFile, CSrCallback* pCallback)
{

	for (dword j = 0; j < StringFile.GetStrings().GetSize(); ++j)
	{
		srstringrecord_h& StringRecord = StringFile.GetStrings()[j];

		CSString* pString = m_StringMap.Lookup(StringRecord.ID);
		if (pString != NULL) SystemLog.Printf("\tWARNING: String Map Collision for ID 0x%08X!", StringRecord.ID);
			
		m_StringMap.SetAt(StringRecord.ID, &StringRecord.String);
	}

}


/*===========================================================================
 *
 * Class CSrEspFile Method - void LoadLocalStrings (pCallback);
 *
 *=========================================================================*/
void CSrEspFile::LoadLocalStrings (CSrCallback* pCallback)
{
	m_Records.LoadLocalStrings(pCallback);
}
/*===========================================================================
 *		End of Class Method CSrEspFile::LoadLocalStrings()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CSrEspFile Method - bool Read (pCallback);
 *
 * Read data from the current position in the opened file. Returns
 * false on any error.
 *
 *=========================================================================*/
bool CSrEspFile::Read (CSrCallback* pCallback)
{
  CSrBaseRecord*	pBaseRecord;
  srbaseheader_t	Header;
  int64				FileSize;
  int 				CurrentOffset;
  bool				Result;
  int				iResult;

  Result  = m_File.GetFileSize64(FileSize);
  Result |= m_File.Tell(CurrentOffset);
  if (!Result) return (false);

	/* Perform the initial callback if required */
  if (pCallback != NULL) 
  {
    pCallback->SetTotalRecords(FileSize);

    iResult = pCallback->ForceCallback(CurrentOffset);
    if (iResult < 0) return (false);
  } 

	/* Read until the end of the file if reached */
  while (CurrentOffset < FileSize) 
  {

		/* Input the record header */
    Result = ReadSrBaseHeader(m_File, Header);
    if (!Result) return (false); 

    //SystemLog.Printf ("0x%08lX: %4.4s (%d bytes left)", CurrentOffset, Header.RecordType.Name, FileSize - CurrentOffset);

		/* Create record/group based on input header */
    pBaseRecord = CreateSrRecordGroup(Header);
    assert(pBaseRecord != NULL);
    m_Records.GetRecords().Add(pBaseRecord);
    pBaseRecord->SetParent(this);

    if (pBaseRecord->GetRecordType() == SR_NAME_TES4) 
	{
      m_pHeader = SrCastClass(CSrTes4Record, pBaseRecord);
    }

    if ((m_CacheFlags & SR_CACHE_DEFERLOAD) != 0 && (Header.Type == SR_NAME_LAND || Header.Type == SR_NAME_NAVM || Header.Type == SR_NAME_GRUP)) 
	{
      pBaseRecord->SetCacheFlags(m_CacheFlags);
    }

		/* Read the rest of the record/group */
    Result = pBaseRecord->ReadData(m_File, pCallback);
    if (!Result) return (false);

		/* Update current file position */
    Result = m_File.Tell(CurrentOffset);
    if (!Result) return (false);

		/* Update the callback if required */
    if (pCallback != NULL) 
	{
      iResult = pCallback->UpdateCallback(CurrentOffset);
      if (iResult < 0) return (false);
    }
  }
  
  return (true);
}
/*===========================================================================
 *		End of Class Method CSrEspFile::Read()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CSrEspFile Method - bool Save (pFilename, pCallback);
 *
 * Saves the mod data to the given file (overwritten if it exists). Returns
 * false on any error.
 *
 *=========================================================================*/
bool CSrEspFile::Save (const SSCHAR* pFilename, CSrCallback* pCallback) 
{
  srtimer_t Timer;  
  srtimer_t Timer1;
  bool      Result;

  SrStartTimer(Timer);

  UpdateFormCount();
  
  Result = CSrRecord::InitIOBuffers();
  if (!Result) return (false);

  SrStartTimer(Timer1);
  UpdateLoadLocalString();
  UpdateStringMap();
  SrEndTimer(Timer1, "\tUpdated local strings in");

  SrStartTimer(Timer1);
  Result = SaveLocalStrings(pFilename);
  if (!Result) return (false);
  SrEndTimer(Timer1, "\tSaved local strings in");

  SetFilename(pFilename);
  
  Result = m_File.Open(pFilename, "wb");
  if (!Result) return (false);

  Result = Write(pCallback);
  m_File.Close();

  CSrRecord::DestroyIOBuffers();

  SrEndTimer(Timer, "\tSaved file in");
  return (Result);
}
/*===========================================================================
 *		End of Class Method CSrEspFile::Save()
 *=========================================================================*/


bool CSrEspFile::SaveLocalStrings(const char* pFilename)
{
	bool Result;

	if (m_pHeader == NULL) return true;
	if (!m_pHeader->IsLocalStrings()) return true;
	
	CSString Pathname = CreateSrStringPathname(pFilename);
	int iResult = _mkdir(Pathname);
	if (iResult == -1 && errno != EEXIST) return  AddSrGeneralError("Failed to create the string path '%s'!", Pathname.c_str());

	Result = m_ILStringFile.Save(CreateSrStringFilename(pFilename, "ilstrings"), "ilstrings");
	if (!Result) return AddSrGeneralError("Failed to save the ILSTRING file for '%s'!", pFilename);

	Result = m_DLStringFile.Save(CreateSrStringFilename(pFilename, "dlstrings"), "dlstrings");
	if (!Result) return AddSrGeneralError("Failed to save the DLSTRING file for '%s'!", pFilename);

	Result = m_LStringFile.Save(CreateSrStringFilename(pFilename, "strings"), "strings");
	if (!Result) return AddSrGeneralError("Failed to save the STRING file for '%s'!", pFilename);

	return true;
}



/*===========================================================================
 *
 * Class CSrEspFile Method - bool Write (pCallback);
 *
 * Write the file data to the current opened file. Returns false on any error.
 *
 *=========================================================================*/
bool CSrEspFile::Write (CSrCallback* pCallback) {
  bool Result;

  Result = m_Records.Write(m_File, pCallback);
  return (Result);
}
/*===========================================================================
 *		End of Class Method CSrEspFile::Write()
 *=========================================================================*/


void CSrEspFile::UpdateLoadLocalString (void)
{
	m_Records.UpdateLoadLocalString(IsLoadLocalString());
}


void CSrEspFile::UpdateStringMap (CSrRecord* pRecord)
{
	if (pRecord == NULL) return;

		//TODO: Make sure the following outputs the strings to the correct file
	if (pRecord->GetRecordType() == SR_NAME_QUST)
	{
		for (dword i = 0; i < pRecord->GetNumSubrecords(); ++i)
		{
			CSrSubrecord* pSubrecord = pRecord->GetSubrecord(i);

			if (pSubrecord->GetRecordType() == SR_NAME_CNAM)
				pSubrecord->UpdateLocalStrings(m_DLStringFile, m_NextStringID);
			else
				pSubrecord->UpdateLocalStrings(m_LStringFile, m_NextStringID);
		}
	}
	else if (pRecord->GetRecordType() == SR_NAME_BOOK)
	{
		for (dword i = 0; i < pRecord->GetNumSubrecords(); ++i)
		{
			CSrSubrecord* pSubrecord = pRecord->GetSubrecord(i);

			if (pSubrecord->GetRecordType() == SR_NAME_DESC)
				pSubrecord->UpdateLocalStrings(m_DLStringFile, m_NextStringID);
			else
				pSubrecord->UpdateLocalStrings(m_LStringFile, m_NextStringID);
		}
	}
	else if (pRecord->GetRecordType() == SR_NAME_INFO)
	{
		for (dword i = 0; i < pRecord->GetNumSubrecords(); ++i)
		{
			CSrSubrecord* pSubrecord = pRecord->GetSubrecord(i);

				//TODO: Figure out what lstring to save to ILSTRING file
			pSubrecord->UpdateLocalStrings(m_LStringFile, m_NextStringID);
		}
	}
	else
	{
		for (dword i = 0; i < pRecord->GetNumSubrecords(); ++i)
		{
			CSrSubrecord* pSubrecord = pRecord->GetSubrecord(i);
			pSubrecord->UpdateLocalStrings(m_LStringFile, m_NextStringID);
		}
	}
}


void CSrEspFile::UpdateStringMap (CSrGroup* pGroup)
{
	if (pGroup == NULL) return;

	for (dword i = 0; i < pGroup->GetNumRecords(); ++i)
	{
		CSrBaseRecord* pBaseRecord = pGroup->GetRecord(i);

		if (pBaseRecord->IsGroup())
		{
			CSrGroup* pGroup = SrCastClass(CSrGroup, pBaseRecord);
			UpdateStringMap(pGroup);
		}
		else
		{
			CSrRecord* pRecord = SrCastClass(CSrRecord, pBaseRecord);
			UpdateStringMap(pRecord);
		}
	}

}


void CSrEspFile::UpdateStringMap (void)
{
	m_StringMap.Destroy();
	m_ILStringFile.Destroy();
	m_DLStringFile.Destroy();
	m_LStringFile.Destroy();

	m_NextStringID = 1;

	UpdateStringMap(&m_Records);	
}


dword CSrEspFile::UpdateFormCount (CSrGroup* pGroup)
{
	CSrBaseRecord* pBaseRecord;
	CSrGroup*      pSubGroup;
	dword          Count = 0;

		/* Special case for type groups */
	if (pGroup->GetType() == SR_GROUP_TYPE)
	{
		return pGroup->GetNumRecords();
	}

	for (dword i = 0; i < pGroup->GetNumRecords(); ++i)
	{
		pBaseRecord = pGroup->GetRecord(i);

		if (pBaseRecord->IsGroup())
		{
			pSubGroup = SrCastClass(CSrGroup, pBaseRecord);
			++Count;
			if (pSubGroup != NULL) Count += UpdateFormCount(pSubGroup);
		}
		else
		{
			++Count;
		}
	}

	return Count;
}


dword CSrEspFile::UpdateFormCount (void)
{
	dword Count = UpdateFormCount(&m_Records);

		/* Remove the TES4 record from the count */
	if (Count > 0) --Count;

	if (m_pHeader) m_pHeader->SetRecordCount(Count);
	return Count;
}
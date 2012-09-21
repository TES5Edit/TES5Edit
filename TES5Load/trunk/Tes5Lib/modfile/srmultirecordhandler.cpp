/*===========================================================================
 *
 * File:		SrMultiRecordhandler.CPP
 * Author:		Dave Humphrey (dave@uesp.net)
 * Created On:	26 November 2011
 *
 * Steps for loading multiple files
 *	- Get list of masters (only masters allowed)
 *	- Get active file (if any)
 *	- Determine load order of master
 *	- Load masters one by one
 *	- Load active file (if any)
 *
 *	- Index first master
 *	- Index subsequent masters, looking for
 *		- Editorid duplicates (must change ID or ignore)

 *		- Formid duplicates (must change ID or ignore)
 *		- Modified records (replace index)
 *			- Create list of duplicates
 *			- Add duplicates with new IDs after each file
 *	- Index active file, same as masters
 *	- Create master record tree
 *
 *
 *=========================================================================*/

	/* Include Files */
#include "srmultirecordhandler.h"
#include "../common/srtime.h"
#include "srimport.h"


/*===========================================================================
 *
 * Begin Local Definitions
 *
 *=========================================================================*/

	/* One global copy of Oblivion.esm */
  CSrEspFile CSrMultiRecordHandler::m_SkyrimMaster;

	/* Static options for the handler */
  srmultirecoptions_t CSrMultiRecordHandler::m_Options;	

/*===========================================================================
 *		End of Local Definitions
 *=========================================================================*/


/*===========================================================================
 *
 * Class CSrMultiRecordHandler Constructor
 *
 *=========================================================================*/
CSrMultiRecordHandler::CSrMultiRecordHandler (const dword HashMapSize)
{
  m_NextFreeFormID   = SRESPFILE_FIRST_FORMID;
  m_NextFreeEditorID = SRESPFILE_FIRST_EDITORID;

  m_FormIdMap.InitHashTable(HashMapSize);
  m_EditorIdMap.InitHashTable(HashMapSize);

  m_ActiveFile.SetParent(this);

	/* Initialize the special player reference */
  m_PlayerRef.Initialize(SR_NAME_REFR);
  m_PlayerRef.InitializeNew();
  m_PlayerRef.SetFormID(SR_PLAYERREF_FORMID);
  m_PlayerRef.SetEditorID("PlayerRef");
  //m_PlayerRef.SetBaseFormID(SR_PLAYER_FORMID); //TODO: When implemented
  m_PlayerRef.SetParent(this);
  m_PlayerRef.SetQuestItem(true);

}
/*===========================================================================
 *		End of Class CSrMultiRecordHandler Constructor
 *=========================================================================*/


/*===========================================================================
 *
 * Class CSrMultiRecordHandler Method - void Destroy (void);
 *
 *=========================================================================*/
void CSrMultiRecordHandler::Destroy (void) {
  m_NextFreeFormID   = SRESPFILE_FIRST_FORMID;
  m_NextFreeEditorID = SRESPFILE_FIRST_EDITORID;

	/* Remove the Skyrim master file from the array if required */
  if (m_MasterFiles.GetAt(0) == &m_SkyrimMaster) 
  {
    m_MasterFiles.SetAt(0, NULL);
  }

  m_EventHandler.Destroy();
  m_UndoItems.Destroy();
  m_NewRecords.Destroy();
  m_TopFileGroup.Destroy();
  m_NewGroups.Destroy();
  m_FormIdMap.Destroy();
  m_EditorIdMap.Destroy();
  m_ActiveFile.Destroy();
  m_MasterFiles.Destroy();

  m_DuplicateFormIDs.Destroy();
  m_DuplicateEditorIDs.Destroy();

  m_GroupAllocator.Destroy();
  m_TypeGroupAllocator.Destroy();
  m_FormIDGroupAllocator.Destroy();
  m_BlockGroupAllocator.Destroy();
  m_GridGroupAllocator.Destroy();

}
/*===========================================================================
 *		End of Class Method CSrMultiRecordHandler::Destroy()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CSrMultiRecordHandler Method - CSrEspFile* AddMaster (void);
 *
 * Create and return a new master file. The new file is not initialized.
 *
 *=========================================================================*/
CSrEspFile* CSrMultiRecordHandler::AddMaster (void) {
  CSrEspFile* pNewFile;

  pNewFile = new CSrEspFile;
  if (pNewFile == NULL) return (NULL);

  m_MasterFiles.Add(pNewFile);
  pNewFile->SetParent(this);
  return (pNewFile);
}
/*===========================================================================
 *		End of Class Method CSrMultiRecordHandler::AddMaster()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CSrMultiRecordHandler Method - dword ChangeFormIDIndex (NewID, OldID, StartMasterIndex);
 *
 *=========================================================================*/
dword CSrMultiRecordHandler::ChangeFormIDIndex (const srformid_t NewID, const srformid_t OldID, const dword StartMasterIndex) 
{
	dword Index;
	dword Count = 0;

	for (Index = StartMasterIndex; Index < m_MasterFiles.GetSize(); ++Index) 
	{
		Count += m_MasterFiles[Index]->ChangeFormID(NewID, OldID);
	}

	if (StartMasterIndex <= m_MasterFiles.GetSize()) 
	{
		Count += m_ActiveFile.ChangeFormID(NewID, OldID);
	}

	return (Count);
}
/*===========================================================================
 *		End of Class Method CSrMultiRecordHandler::ChangeFormIDIndex()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CSrMultiRecordHandler Method - dword ChangeEditorIDIndex (pNewID, pOldID, StartModIndex);
 *
 *=========================================================================*/
dword CSrMultiRecordHandler::ChangeEditorIDIndex (const SSCHAR* pNewID, const SSCHAR* pOldID, const dword StartModIndex) 
{
	dword Index;
	dword Count = 0;

	for (Index = StartModIndex; Index < m_MasterFiles.GetSize(); ++Index) 
	{
		Count += m_MasterFiles[Index]->ChangeEditorID(pNewID, pOldID);
	}

	if (StartModIndex <= m_MasterFiles.GetSize()) 
	{
		Count += m_ActiveFile.ChangeEditorID(pNewID, pOldID);
	}

	return (Count);
}
/*===========================================================================
 *		End of Class Method CSrMultiRecordHandler::ChangeEditorIDIndex()
 *=========================================================================*/


bool CSrMultiRecordHandler::ChangeRecordFormID (CSrRecord* pRecord, const srformid_t NewFormID)
{
	srformid_t OldFormID;

	if (pRecord == NULL) return false;
	OldFormID = pRecord->GetFormID();
	
	if (FindFormID(NewFormID) != NULL)
	{
		AddSrGeneralError("Cannot change the formid of 0x%08X to 0x%08X as it already exists!", OldFormID, NewFormID);
		return false;
	}

	m_EventHandler.SendPreUpdateEvent(pRecord);
	CreateUndoUpdate(pRecord);
	
	CSrRecord* pNewRecord = MakeRecordActivePriv(pRecord, true);
	if (pNewRecord == NULL) return false;

	RemoveFromIndex(pNewRecord);
	pNewRecord->SetFormID(NewFormID);
	IndexRecord(pNewRecord);

	m_EventHandler.SendUpdateEvent(pNewRecord, pRecord);
	
	for (dword i = 0; i < m_MasterFiles.GetSize(); ++i) 
	{
		ChangeFormID(m_MasterFiles[i]->GetTopGroup(), NewFormID, OldFormID);
	}

	ChangeFormID(m_ActiveFile.GetTopGroup(), NewFormID, OldFormID);
	return true;
}


bool CSrMultiRecordHandler::ChangeModIndex (CSrRecord* pRecord, const byte ModIndex)
{
	byte       CurModIndex;
	srformid_t NewFormID;
	srformid_t OldFormID;

	if (pRecord == NULL) return false;

	CurModIndex = pRecord->GetFormID() >> 24;
	if (CurModIndex == ModIndex) return true;

	OldFormID = pRecord->GetFormID();
	NewFormID = (OldFormID & 0x00ffffff) | (ModIndex << 24);

	if (FindFormID(NewFormID) != NULL)
	{
		AddSrGeneralError("Cannot change the formid of 0x%08X to 0x%08X as it already exists!", OldFormID, NewFormID);
		return false;
	}

	m_EventHandler.SendPreUpdateEvent(pRecord);
	CreateUndoUpdate(pRecord);
	
	CSrRecord* pNewRecord = MakeRecordActivePriv(pRecord, true);
	if (pNewRecord == NULL) return false;

	RemoveFromIndex(pNewRecord);
	pNewRecord->SetFormID(NewFormID);
	IndexRecord(pNewRecord);

	m_EventHandler.SendUpdateEvent(pNewRecord, pRecord);
	
	for (dword i = 0; i < m_MasterFiles.GetSize(); ++i) 
	{
		ChangeFormID(m_MasterFiles[i]->GetTopGroup(), NewFormID, OldFormID);
	}

	ChangeFormID(m_ActiveFile.GetTopGroup(), NewFormID, OldFormID);
	return true;
}


bool CSrMultiRecordHandler::AssignNewFormID (CSrRecord* pRecord, const byte ModIndex)
{
	byte       CurModIndex;
	srformid_t NewFormID;
	srformid_t OldFormID;

	if (pRecord == NULL) return false;

	CurModIndex = pRecord->GetFormID() >> 24;
	if (CurModIndex == ModIndex) return true;

	OldFormID = pRecord->GetFormID();
	NewFormID = GetFreeFormID(ModIndex);
	if (NewFormID == OldFormID) return false;
		
	m_EventHandler.SendPreUpdateEvent(pRecord);
	CreateUndoUpdate(pRecord);
	
	CSrRecord* pNewRecord = MakeRecordActivePriv(pRecord, true);
	if (pNewRecord == NULL) return false;

	RemoveFromIndex(pNewRecord);
	pNewRecord->SetFormID(NewFormID);
	IndexRecord(pNewRecord);

	m_EventHandler.SendUpdateEvent(pNewRecord, pRecord);
	
	for (dword i = 0; i < m_MasterFiles.GetSize(); ++i) 
	{
		ChangeFormID(m_MasterFiles[i]->GetTopGroup(), NewFormID, OldFormID);
	}

	ChangeFormID(m_ActiveFile.GetTopGroup(), NewFormID, OldFormID);
	return true;
}


dword CSrMultiRecordHandler::ChangeFormID (CSrGroup* pGroup, const srformid_t NewID, const srformid_t OldID)
{
	dword Count;

	if (pGroup == NULL) return 0;

	for (dword i = 0; i < pGroup->GetNumRecords(); ++i)
	{
		CSrBaseRecord* pBaseRecord = pGroup->GetRecord(i);
		CSrGroup*      pSubGroup   = SrCastClass(CSrGroup, pBaseRecord);
		CSrRecord*     pRecord     = SrCastClass(CSrRecord, pBaseRecord);

		if (pSubGroup != NULL)
		{
			Count += ChangeFormID(pSubGroup, NewID, OldID);
		}
		else if (pRecord != NULL)
		{
			Count += ChangeFormID(pRecord, NewID, OldID);
		}

	}

	return Count;
}


dword CSrMultiRecordHandler::ChangeFormID (CSrRecord* pRecord, const srformid_t NewID, const srformid_t OldID)
{
	dword Count = 0;

	if (pRecord == NULL) return 0;
	if (pRecord->CountUses(OldID) == 0) return 0;

	m_EventHandler.SendPreUpdateEvent(pRecord);
	CreateUndoUpdate(pRecord);
	
	CSrRecord* pNewRecord = MakeRecordActivePriv(pRecord, true);
	if (pNewRecord == NULL) return false;
		
	Count = pNewRecord->ChangeFormID(NewID, OldID);
	m_EventHandler.SendUpdateEvent(pNewRecord, pRecord);		

	return Count;
}


/*===========================================================================
 *
 * Class CSrMultiRecordHandler Method - bool CheckDuplicateFormId (pRecord);
 *
 * Checks if the given record's formid is a duplicate according to the
 * current content and handles it accordingly if it is. Returns true
 * if it is a duplicate.
 *
 *=========================================================================*/
bool CSrMultiRecordHandler::CheckDuplicateFormId (CSrRecord* pRecord) {
  CSrRecord*   pRecord2;
  bool         Result;

	/* Ensure valid input */
  if (pRecord == NULL) return (false);

	/* Find an existing formid */
  Result = m_FormIdMap.Lookup(pRecord->GetFormID(), pRecord2);
  if (!Result) return (false);

	/* See the records are the same type */
  if (pRecord2->GetRecordType() == pRecord->GetRecordType()) {
    return (false);
  }

  SystemLog.Printf("Found duplicate formid 0x%X!", pRecord->GetFormID());
  return (true);
}
/*===========================================================================
 *		End of Class Method CSrMultiRecordHandler::CheckDuplicateFormId()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CSrMultiRecordHandler Method - bool CheckDuplicateEditorId (pRecord);
 *
 * Checks if the given record's editorid is a duplicate according to
 * the current content. Returns true if it is a duplicate.
 *
 *=========================================================================*/
bool CSrMultiRecordHandler::CheckDuplicateEditorId (CSrIdRecord* pRecord) {
  CSrIdRecord*  pIdRecord2;
  bool		Result;

  	/* Ensure valid input */
  if (pRecord == NULL) return (false);

	/* Find an existing formid */
  Result = m_EditorIdMap.Lookup(pRecord->GetEditorID(), pIdRecord2);
  if (!Result) return (false);
  
	/* See the records have the same formid */
  if (pIdRecord2->GetFormID() == pRecord->GetFormID()) {
    return (false);
  }

  SystemLog.Printf("Found duplicate editorid '%s'!", pRecord->GetEditorID());
  return (true);
}
/*===========================================================================
 *		End of Class Method CSrMultiRecordHandler::CheckDuplicateEditorId()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CSrMultiRecordHandler Method - CSrRecord* CleanRecord (pRecord);
 *
 * Removes the given record from the active file returning the next
 * instance of the record if it exists, or NULL. Returns the given
 * record if it is not active.
 *
 *=========================================================================*/
CSrRecord* CSrMultiRecordHandler::CleanRecord (CSrRecord* pRecord) {
  CSrRecord*   pPrevRecord;
  CSrUndoItem* pUndoItem;

	/* Ignore invalid input */
  if (pRecord == NULL) return (NULL);

	/* Ignore if not active */
  if (!pRecord->IsActive()) return (pRecord);

	/* Update all listeners */
  m_EventHandler.SendPreUpdateEvent(pRecord);

	/* Create the undo item */
  pUndoItem = CreateUndoClean(pRecord);

	/* Find any previous version of the record */
  pPrevRecord = FindNonActiveRecord(pRecord);

	/* Update the overall record tree */
  UpdateRecordTree(pPrevRecord, pRecord);

	/* Update the index */
  RemoveFromIndex(pRecord);
  if (pPrevRecord != NULL) IndexRecord(pPrevRecord);

	/* Update all listeners */
  m_EventHandler.SendCleanEvent(pPrevRecord, pRecord);

	/* Delete the record from the active file */
  m_ActiveFile.DeleteRecord(pRecord);
  return (pPrevRecord);
}
/*===========================================================================
 *		End of Class Method CSrMultiRecordHandler::CleanRecord()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CSrMultiRecordHandler Method - dword CountAllRecords (void);
 *
 * Count and return the records in all current files.
 *
 *=========================================================================*/
dword CSrMultiRecordHandler::CountAllRecords (void) {
  dword Count = 0;
  dword Index;

  for (Index = 0; Index < m_MasterFiles.GetSize(); ++Index) {
    Count += m_MasterFiles[Index]->GetRecordCount();
  }

  Count += m_ActiveFile.GetRecordCount();
  return (Count);
}
/*===========================================================================
 *		End of Class Method CSrMultiRecordHandler::CountAllRecords()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CSrMultiRecordHandler Method - bool CreateFormidFixup (FixupArray, pFile, ModIndex);
 *
 *=========================================================================*/
bool CSrMultiRecordHandler::CreateFormidFixup (CSrFormidFixupArray& FixupArray, CSrEspFile* pFile, const byte ModIndex) {
  CSrTes4Record*      pHeader = pFile->GetHeader();
  CSrSubrecord*       pSubrecord;
  const SSCHAR*	      pMasterString;
  bool		      Result = true;
  int		      Position;
  int		      FileModIndex = 0;
  int		      ResultModIndex;

  if (pHeader == NULL) return (false);
  SystemLog.Printf("===== Performing modindex fixups on file '%s', with current modindex %d...", pFile->GetShortFilename(), (dword) ModIndex);

	/* Loop through all master subrecords in header */
  pSubrecord = pHeader->FindFirstSubrecord(SR_NAME_MAST, Position);

  while (pSubrecord != NULL) {
    pMasterString  = (const SSCHAR *) pSubrecord->GetData();
    ResultModIndex = FindModIndex(pMasterString);

    if (ResultModIndex >= 0) {
      FixupArray.Add((byte) ResultModIndex);
      SystemLog.Printf("\tMaster modindex fixup %d to %d in file '%s'.", FileModIndex, ResultModIndex, pMasterString);
    }
    else {
      AddSrGeneralError("Missing master file '%s' with current modindex %d!", pMasterString, FileModIndex);
      FixupArray.Add(FileModIndex);
      //Result = false;
    }

    pSubrecord = pHeader->FindNextSubrecord(SR_NAME_MAST, Position);
    ++FileModIndex;
  }

	/* Special case for first master with no fixups */
  if (ModIndex == 0 && FileModIndex == 0) {
    SystemLog.Printf("\tNo master dependancies to fix!");
    return (true);
  }
  
	/* Don't change the active file modindex if we don't need to */
  if (FileModIndex >= ModIndex) {
    FixupArray.Add(FileModIndex);
    SystemLog.Printf("\tCurrent modindex fixup %d to %d.", FileModIndex, FileModIndex);
    pFile->SetModIndex(FileModIndex);
    ++FileModIndex;
  }
	/* Add the current file fixup */
  else {
    FixupArray.Add(ModIndex);
    SystemLog.Printf("\tCurrent modindex fixup %d to %d.", FileModIndex, ModIndex);
    pFile->SetModIndex(ModIndex);
    ++FileModIndex;
  }
  
  
  return (Result);
}
/*===========================================================================
 *		End of Class Method CSrMultiRecordHandler::CreateFormidFixup()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CSrMultiRecordHandler Method - CSrBaseRecord* CreateNewRecord (Type);
 *
 * Creates and adds a new record to the active file as given by the input
 * record type. The new record is returned.
 *
 *=========================================================================*/
CSrRecord* CSrMultiRecordHandler::CreateNewRecord (const srrectype_t Type) {
  return m_ActiveFile.CreateNewRecord(Type);
 }
/*===========================================================================
 *		End of Class Method CSrMultiRecordHandler::CreateNewRecord()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CSrMultiRecordHandler Method - CSrIdRecord* CreateIDRecordFromCsvRow (CsvInfo, Row, pOldRecord);
 *
 * Creates a new record, or reuses an existing record, for the given
 * CSV row. Returns NULL on any error.
 *
 *=========================================================================*/
CSrIdRecord* CSrMultiRecordHandler::CreateIDRecordFromCsvRow (srcsvinfo_t& CsvInfo, CCsvRow& Row, CSrIdRecord*& pOldRecord) {
  CSString*      pEditorID;
  CSString*      pRecordName;
  CSrIdRecord*   pIdRecord;
  CSrBaseRecord* pBaseRecord;
  CSrIdRecord*   pNewRecord;
  bool		 Result;
  
	/* Get the required column data */
  pEditorID   = Row.GetAt(CsvInfo.pEditorID->ColIndex);
  pRecordName = Row.GetAt(CsvInfo.pRecordName->ColIndex);
  pOldRecord  = NULL;

  if (pEditorID   == NULL) {
    AddSrGeneralError("Missing 'EditorID' field in row %d of CSV file!", CsvInfo.CurrentLine);
    return (NULL);
  }

  if (pRecordName == NULL) {
    AddSrGeneralError("Missing 'RecordName' field in row %d of CSV file!", CsvInfo.CurrentLine);
    return (NULL);
  }

	/* Prepare the strings */
  pEditorID->Unescape();
  pRecordName->Unescape();
  SrPrepareEditorID(*pEditorID);

  	/* Does the record already exist? */
  pIdRecord = FindEditorID(pEditorID->c_str());

  if (pIdRecord != NULL) {

		/* Ensure the record types match */
    if (pIdRecord->GetRecordType() != pRecordName->c_str()) {
      AddSrGeneralError("Existing record '%s' type (%4.4s) does not match desired type %s!", pEditorID->c_str(), pIdRecord->GetRecordType().Name, pRecordName->c_str());
      return (NULL);
    }

		/* Update any listeners */
    m_EventHandler.SendPreUpdateEvent(pIdRecord);
    pOldRecord = pIdRecord;

		/* Ensure an active record */
    pBaseRecord = MakeRecordActivePriv(pIdRecord, false);
    if (pBaseRecord == NULL) return (NULL);
    pNewRecord = SrCastClass(CSrIdRecord, pBaseRecord);
    if (pNewRecord == NULL) return (NULL);

		/* Update the record indices */
    RemoveFromIndex(pIdRecord);
    pNewRecord->SetEditorID(pEditorID->c_str());
    IndexRecord(pNewRecord);
  }
	/* Must create a new record */
  else {

		/* Ensure it is a known record name */
    if (FindSrRecCreate(pRecordName->c_str()) == NULL) {
      AddSrGeneralError("Unknown record type '%s' found in row %d!", pRecordName->c_str(), CsvInfo.CurrentLine);
      return (NULL);
    }
     
    pBaseRecord = CreateSrRecord(pRecordName->c_str());
    if (pBaseRecord == NULL) return (NULL);
    pNewRecord = SrCastClass(CSrIdRecord, pBaseRecord);

    if (pNewRecord == NULL) {
      delete pBaseRecord;
      return (NULL);
    }

	  	/* Move the record into the active file and record tree */
    Result = MoveNewRecord(pNewRecord);
    if (!Result) return (false);

		/* Select unused formID */
    pNewRecord->SetFormID(GetActiveFreeFormID());
    pNewRecord->SetEditorID(pEditorID->c_str());

    IndexRecord(pNewRecord);
  }

  return (pNewRecord);
}
/*===========================================================================
 *		End of Class Method CSrMultiRecordHandler::CreateIDRecordFromCsvRow()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CSrMultiRecordHandler Method - bool CreateRecordTree (pCallback);
 *
 * Creates the full record tree for all current files.
 *
 *=========================================================================*/
bool CSrMultiRecordHandler::CreateRecordTree (CSrCallback* pCallback) {
  bool  Result;
  dword Index;

	/* Set the initialize array size */
  m_NewGroups.SetAllocatedSize(SRE_DEFAULT_NEWGROUP_SIZE);

  if (pCallback != NULL) {
    dword Count = m_FormIdMap.GetRecordCount();
    pCallback->SetTotalRecords(Count);
    pCallback->SetCallbackInterval(Count/100);
    pCallback->Reset();
    pCallback->ForceCallback(0);
  }

	/* Add records from all master files */
  for (Index = 0; Index < m_MasterFiles.GetSize(); ++Index) {
    Result = CreateRecordTree(m_MasterFiles.GetAt(Index), pCallback);
    if (!Result) return (false);
  }

	/* Add in records from the active file */
  Result = CreateRecordTree(&m_ActiveFile, pCallback);

  SystemLog.Printf("New groups size = %u", m_NewGroups.GetSize());
  return (Result);
}
/*===========================================================================
 *		End of Class Method CSrMultiRecordHandler::CreateRecordTree()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CSrMultiRecordHandler Method - bool CreateRecordTree (pFile, pCallback);
 *
 * Fills in the overall record tree for the given file.
 *
 *=========================================================================*/
bool CSrMultiRecordHandler::CreateRecordTree (CSrEspFile* pFile, CSrCallback* pCallback) {

  if (pCallback != NULL) {
    pCallback->SetLabel("Creating record tree for file '%s'...", pFile->GetShortFilename());
    //pCallback->Reset();
    //pCallback->ForceCallback(0);
    //pCallback->SetCallbackInterval(1);
  }

  return CreateRecordTree(&m_TopFileGroup, &pFile->GetRecords(), pCallback);
}
/*===========================================================================
 *		End of Class Method CSrMultiRecordHandler::CreateRecordTree()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CSrMultiRecordHandler Method - bool CreateRecordTree (pDestGroup, pSourceGroup, pCallback);
 *
 *=========================================================================*/
bool CSrMultiRecordHandler::CreateRecordTree (CSrGroup* pDestGroup, CSrGroup* pSourceGroup, CSrCallback* pCallback) {
  CSrBaseRecord* pBaseRecord;
  CSrRecord*     pRecord;
  CSrGroup*      pGroup;
  CSrGroup*      pNextGroup;
  dword		 Index;
  bool           Result;
  bool		 FirstFile = (pDestGroup->GetNumRecords() == 0);

  for (Index = 0; Index < pSourceGroup->GetNumRecords(); ++Index) {
    pBaseRecord = pSourceGroup->GetRecord(Index);
    pRecord = SrCastRecord(pBaseRecord);

    if (pRecord != NULL) {
      Result = CreateTreeAddRecord(pDestGroup, pRecord, FirstFile);
      if (!Result) return (false);

      if (pCallback != NULL) {
        int iResult = pCallback->UpdateCallback(pCallback->GetProcessRecords() + 1);
        if (iResult < 0) return (false);
      }
    }
    else {
      pGroup = SrCastGroup(pBaseRecord);
      if (pGroup == NULL) continue;

      pNextGroup = CreateTreeFindGroup(pDestGroup, pGroup, FirstFile);

      if (pNextGroup != NULL) {
        Result = CreateRecordTree(pNextGroup, pGroup, pCallback);
	if (!Result) return (false);
      }
    }

  }

  return (true);
}
/*===========================================================================
 *		End of Class Method CSrMultiRecordHandler::CreateRecordTree()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CSrMultiRecordHandler Method - bool CreateTreeAddRecord (pDestGroup, pNewRecord, FirstFile);
 *
 *=========================================================================*/
bool CSrMultiRecordHandler::CreateTreeAddRecord (CSrGroup* pDestGroup, CSrRecord* pNewRecord, const bool FirstFile) {

	/* Special case for a first file */
  if (FirstFile) {
    pDestGroup->GetRecords().Add(pNewRecord);
    return (true);
  }

  return pDestGroup->AddExistingRecord(pNewRecord);
}
/*===========================================================================
 *		End of Class Method CSrMultiRecordHandler::CreateTreeAddRecord()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CSrMultiRecordHandler Method - CSrGroup* CreateTreeFindGroup (pDestGroup, pNewGroup, FirstFile);
 *
 *=========================================================================*/
CSrGroup* CSrMultiRecordHandler::CreateTreeFindGroup (CSrGroup* pDestGroup, CSrGroup* pNewGroup, const bool FirstFile) {
  CSrGroup* pGroup;

	/* Find an existing group */
  if (!FirstFile) {
    //SystemLog.Printf("test");
    pGroup = pDestGroup->FindSubGroup(pNewGroup);
    if (pGroup != NULL) return (pGroup);
  }
	
	/* Create a new group */
  pGroup = pDestGroup->CreateSubGroup(pNewGroup);

/*
  pGroup = m_GroupAllocator.CreateObject();
  pDestGroup->GetRecords().Add(pGroup);
  pGroup->GetHeader().Data.ParentFormID = pNewGroup->GetHeader().Data.ParentFormID;

  pGroup->GetRecords().SetAllocatedSize((int)((pNewGroup->GetNumRecords() + 40))); //*/

  m_NewGroups.Add(pGroup);
  return (pGroup);

#if FALSE
  CSrBaseRecord* pBaseRecord;
  CSrGroup*      pGroup;
  dword          Index;
  static dword Count = 0;
  static double TimeSum = 0;
  static double TimeSum1 = 0;
  static double TimeSum2 = 0;
  static double TimeSum3 = 0;

	/* Don't search when the first file is added */
  if (!FirstFile) {
    for (Index = 0; Index < pDestGroup->GetNumRecords(); ++Index) {
      pBaseRecord = pDestGroup->GetRecord(Index);
      pGroup      = ObCastGroup(pBaseRecord);
      if (pGroup == NULL) continue;

      if (pGroup->Compare(pNewGroup)) return (pGroup);
    }
  }

  srtimer_t Timer;
  SrStartTimer(Timer);
/*
  switch (pNewGroup->GetType()) {
    case SR_GROUP_TYPE:
	pGroup = m_TypeGroupAllocator.CreateObject();
	break;
    case SR_GROUP_WORLDCHILD:
    case SR_GROUP_CELLCHILD:
    case SR_GROUP_TOPICCHILD:
    case SR_GROUP_CELLPERSIST:
    case SR_GROUP_CELLTEMP:
    case SR_GROUP_CELLDISTANT:
    	pGroup = m_FormIDGroupAllocator.CreateObject();
	break;
    case SR_GROUP_INTCELL:	
    case SR_GROUP_INTSUBCELL:
	pGroup = m_BlockGroupAllocator.CreateObject();
	break;
    case SR_GROUP_EXTCELL:
    case SR_GROUP_EXTSUBCELL:
	pGroup = m_GridGroupAllocator.CreateObject();
	break;
    default:
        pGroup = m_GroupAllocator.CreateObject();
    	break;
  } //*/
  //pGroup = m_GroupAllocator.CreateObject();

  pGroup = CreateObRefGroup(pNewGroup->GetType());
  m_NewGroups.Add(pGroup);

  TimeSum += SrEndTimer(Timer);
  SrStartTimer(Timer);

  pDestGroup->GetRecords().Add(pGroup);

  TimeSum1 += SrEndTimer(Timer);
  SrStartTimer(Timer);

  pGroup->GetHeader().Data.ParentFormID = pNewGroup->GetHeader().Data.ParentFormID;

  TimeSum2 += SrEndTimer(Timer);
  SrStartTimer(Timer);
  
  //pGroup->GetRecords().SetAllocatedSize((int)((pNewGroup->GetNumRecords() + 4)));

  TimeSum3 += SrEndTimer(Timer);
  //SrStartTimer(Timer);

  
  ++Count;

  if ((Count % 10000) == 0) {
    SystemLog.Printf("CreateTreeFindGroup(): New count = %u, Time = %f s, Time = %f s, Time = %f s, Time = %f s", Count, TimeSum, TimeSum1, TimeSum2, TimeSum3);
  }

  return (pGroup);
#endif
}
/*===========================================================================
 *		End of Class Method CSrMultiRecordHandler::CreateTreeFindGroup()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CSrMultiRecordHandler Method - bool DeleteRecord (pRecord);
 *
 *=========================================================================*/
bool CSrMultiRecordHandler::DeleteRecord (CSrRecord* pRecord) {
  CSrIdRecord* pIdRecord;
  bool         Result;

  if (pRecord == NULL) return (false);

	/* Delete record from the index maps */
  m_FormIdMap.Delete(pRecord);

  pIdRecord = SrCastClass(CSrIdRecord, pRecord);
  if (pIdRecord != NULL) m_EditorIdMap.Delete(pIdRecord);

  Result = m_ActiveFile.DeleteRecord(pRecord);

  return (Result);
}
/*===========================================================================
 *		End of Class Method CSrMultiRecordHandler::DeleteRecord()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CSrMultiRecordHandler Method - bool DeleteMaster (CSrEspFile* pMaster);
 *
 * Attempt to delete the given master. Also removes all records from
 * the master if found. Returns false if the given master is not valid.
 *
 *=========================================================================*/
bool CSrMultiRecordHandler::DeleteMaster (CSrEspFile* pMaster) {
  int Index;
  
	/* Ensure the master file exists in the master array */
  Index = m_MasterFiles.Find(pMaster);
  if (Index < 0) return (false);

  return (true);
}
/*===========================================================================
 *		End of Class Method CSrMultiRecordHandler::DeleteMaster()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CSrMultiRecordHandler Method - dword Search (FindData, pCallback);
 *
 *=========================================================================*/
dword CSrMultiRecordHandler::Search (srfinddata_t& FindData, CSrCallback* pCallback) {
  CSrBaseRecord* pBaseRecord;
  CSrRecord*     pRecord;
  CSrTypeGroup*	 pGroup;
  dword          FindCount = 0;
  dword          Index;
  dword			 Count;
  bool			 IsExcluded;
  bool			 FindText = (FindData.Flags & SR_FIND_COMPARETEXT) != 0;
  bool			 Result;
  int            iResult;

  if (pCallback != NULL) {
    pCallback->SetTotalRecords(CountAllRecords());
    pCallback->SetCallbackInterval(pCallback->GetTotalRecords()/1000);
    pCallback->Reset();
  }

  ++FindData.FileCount;

		/* Special case */
  if ((FindData.Flags & SR_FIND_FORMID) != 0)
  {
	  srformid_t FormID = *(srformid_t *) FindData.pData;
	  pRecord = FindFormID(FormID);
	  if (pRecord == NULL) return 0;
	  if ((FindData.Flags & SR_FIND_ADDRECORDS) != 0 && FindData.pFindRecords != NULL) FindData.pFindRecords->Add(pRecord);
	  return 1;
  }
  
  for (Index = 0; Index < m_TopFileGroup.GetNumRecords(); ++Index) 
  {
    pBaseRecord = m_TopFileGroup.GetRecord(Index);
    pRecord     = SrCastClass(CSrRecord, pBaseRecord);

    if (pRecord) {
      if ((FindData.Flags & SR_FIND_NOHEADER) != 0 && pRecord->GetRecordType() == SR_NAME_TES4)
        IsExcluded = true;
      else
        IsExcluded = SrContainsRecordType(pRecord->GetRecordType(), FindData.pExcludeRecords);
    }
    else {
      pGroup = SrCastClass(CSrTypeGroup, pBaseRecord);
      if (pGroup != NULL) IsExcluded = SrContainsRecordType(pGroup->GetContainsType(), FindData.pExcludeRecords);
    }
    
    if (pRecord == NULL || !IsExcluded) {
      if (FindText)
        Result = pBaseRecord->SearchText(Count, FindData, pCallback);
      else
        Result = pBaseRecord->Search(Count, FindData, pCallback);

      FindCount += Count;
      if (!Result) return (FindCount);
    }

    if (pCallback != NULL) {
      iResult = pCallback->UpdateCallback(pCallback->GetProcessRecords() + 1);
      if (iResult < 0) return (FindCount);
    }
  }

  return (FindCount);
 }
/*===========================================================================
 *		End of Class Method CSrMultiRecordHandler::Search()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CSrMultiRecordHandler Method - CSrRecord* FindFormID (FormID);
 *
 *=========================================================================*/
CSrRecord* CSrMultiRecordHandler::FindFormID (const srformid_t FormID) {
  CSrRecord* pRecord;
  bool	     Result;

	/* Ignore invalid input */
  if (FormID == SR_FORMID_NULL) return (NULL);

  Result = m_FormIdMap.Lookup(FormID, pRecord);
  if (!Result) return (NULL);
  return (pRecord);
}
/*===========================================================================
 *		End of Class Method CSrMultiRecordHandler::FindFormID()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CSrMultiRecordHandler Method - CSrIdRecord* FindEditorID (pString);
 *
 *=========================================================================*/
CSrIdRecord* CSrMultiRecordHandler::FindEditorID (const SSCHAR* pString) {
  CSrIdRecord* pRecord;
  bool	       Result;

	/* Ignore invalid input */
  if (pString == NULL) return (NULL);

  Result = m_EditorIdMap.Lookup(pString, pRecord);
  if (!Result) return (NULL);
  return (pRecord);
}
/*===========================================================================
 *		End of Class Method CSrMultiRecordHandler::FindEditorID()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CSrMultiRecordHandler Method - CSString FindLocalString (ID);
 *
 *=========================================================================*/
CSString* CSrMultiRecordHandler::FindLocalString (const srlstringid_t ID)
{
	CSString* pString = m_ActiveFile.FindLocalString(ID);
	if (pString) return pString;

	for (dword i = 0; i < m_MasterFiles.GetSize(); ++i)
	{
		pString = m_MasterFiles.GetAt(i)->FindLocalString(ID);
		if (pString) return pString;
	}
	
	return NULL;
}
/*===========================================================================
 *		End of Class Method CSrMultiRecordHandler::FindLocalString()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CSrMultiRecordHandler Method - int FindModIndex (pFilename);
 *
 * Attempt to find and return the current mod index of the given filename
 * (no path). Returns -1 if not found.
 *
 *=========================================================================*/
int CSrMultiRecordHandler::FindModIndex (const SSCHAR* pFilename) {
  CSString Buffer;
  dword    Index;

  for (Index = 0; Index < m_MasterFiles.GetSize(); ++Index) {
    Buffer = m_MasterFiles[Index]->GetFilename();
    Buffer.ReverseTruncateAtR(":\\/");

    if (Buffer.IsEmpty()) continue;
    if (Buffer.CompareNoCase(pFilename) == 0) return (Index);
  }

  Buffer = m_ActiveFile.GetFilename();
  Buffer.ReverseTruncateAtR(":\\/");
  if (Buffer.IsEmpty()) return (-1);
  if (Buffer.CompareNoCase(pFilename) == 0) return (Index);

  return (-1);
}
/*===========================================================================
 *		End of Class Method CSrMultiRecordHandler::FindModIndex()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CSrMultiRecordHandler Method - CSrRecord* FindNonActiveRecord (pRecord);
 *
 * Finds the instance of given record not in the active file. Returns
 * NULL if no match was found.
 *
 *=========================================================================*/
CSrRecord* CSrMultiRecordHandler::FindNonActiveRecord (CSrRecord* pRecord) {
  CSrEspFile*    pFile;
  CSrRecord*     pOldRecord;
  CSrBaseRecord* pBaseRecord;
  int            Index;

	/* Search all master files in reverse order */
  for (Index = m_MasterFiles.GetSize() - 1; Index >= 0; --Index) {
    pFile = m_MasterFiles.GetAt(Index);

    pBaseRecord = pFile->GetRecords().FindFormID(pRecord->GetFormID());
    if (pBaseRecord == NULL) continue;

    pOldRecord = SrCastRecord(pBaseRecord);
    if (pOldRecord != NULL) return (pOldRecord);
  }

  return (NULL);
}
/*===========================================================================
 *		End of Class Method CSrMultiRecordHandler::FindNonActiveRecord()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CSrMultiRecordHandler Method - bool FixupFormids (void);
 *
 * Fixes the formids of all mods.
 *
 *=========================================================================*/
bool CSrMultiRecordHandler::FixupFormids (void) {
  CSString Buffer;
  dword	   ModIndex;
  bool     Result = true;

  for (ModIndex = 0; ModIndex < m_MasterFiles.GetSize(); ++ModIndex) {
    Result &= FixupFormids(m_MasterFiles[ModIndex], ModIndex);   
  }

	/* Fixup the active file */
  Result &= FixupFormids(&m_ActiveFile, ModIndex);
  //m_ActiveFile.SetModIndex(ModIndex);
  return (Result);
}
/*===========================================================================
 *		End of Class Method CSrMultiRecordHandler::FixupFormids()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CSrMultiRecordHandler Method - bool FixupFormids (pFile, ModIndex);
 *
 *=========================================================================*/
bool CSrMultiRecordHandler::FixupFormids (CSrEspFile* pFile, const byte ModIndex) {
  CSrFormidFixupArray   FixupArray;
  bool			Result;

	/* Create the fixup array */
  Result = CreateFormidFixup(FixupArray, pFile, ModIndex);
  if (!Result) return (false);

	/* Ignore if nothing needs to change */
  Result = HasFixupChanged(FixupArray);

  if (!Result) {
    SystemLog.Printf("\tNo modindex fixups needed in file %s!", pFile->GetShortFilename());
    return (true);
  }

	/* Perform the fixup */
  Result = pFile->FixupFormids(FixupArray);
  return (Result);
}
/*===========================================================================
 *		End of Class Method CSrMultiRecordHandler::FixupFormids()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CSrMultiRecordHandler Method - bool GetEditorID (Buffer, FormID);
 *
 *=========================================================================*/
bool CSrMultiRecordHandler::GetEditorID (CSString& Buffer, const srformid_t FormID) {
  CSrRecord*   pRecord;
  CSrIdRecord* pIdRecord;
  
  Buffer.Empty();
  if (FormID == SR_FORMID_NULL) return (true);

  pRecord = FindFormID(FormID);
  if (pRecord == NULL) return (false);

  pIdRecord = SrCastClass(CSrIdRecord, pRecord);

  if (pIdRecord == NULL) { 
    CSrSubrecord* pSubrecord = pRecord->FindSubrecord(SR_NAME_EDID);
    if (pSubrecord == NULL) return (false);
    Buffer = (char *) pSubrecord->GetData();
  }
  else {
    Buffer = pIdRecord->GetEditorID();
  }

  return (true);
}
/*===========================================================================
 *		End of Class Method CSrMultiRecordHandler::GetEditorID()
 *=========================================================================*/


/*===========================================================================
 *
 * Class SSCHAR* CSrMultiRecordHandler Method - const GetEditorID (FormID);
 *
 *=========================================================================*/
const SSCHAR* CSrMultiRecordHandler::GetEditorID (const srformid_t FormID) {
  CSrRecord*   pRecord;
  CSrIdRecord* pIdRecord;
    
  if (FormID == SR_FORMID_NULL) return (NULL);

  pRecord = FindFormID(FormID);

  if (pRecord == NULL) 
  {
	  SystemLog.Printf("Unknown formid 0x%08X!", FormID);
	  return (NULL);
  }

  pIdRecord = SrCastClass(CSrIdRecord, pRecord);
  if (pIdRecord != NULL) return pIdRecord->GetEditorID();

  CSrSubrecord* pSubrecord = pRecord->FindSubrecord(SR_NAME_EDID);

  if (pSubrecord == NULL)
  {
	  SystemLog.Printf("Unknown formid 0x%08X!", FormID);
	  return (NULL);
  }

  return (const char *) pSubrecord->GetData();
}
/*===========================================================================
 *		End of Class Method SSCHAR* CSrMultiRecordHandler::GetEditorID()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CSrMultiRecordHandler Method - const SSCHAR* GetFreeEditorID (void);
 *
 *=========================================================================*/
const SSCHAR* CSrMultiRecordHandler::GetFreeEditorID (void) {
  static CSString s_Buffer;
  dword NumOverFlows = 0;
  
  do {
    s_Buffer.Format("sreditid%08X", m_NextFreeEditorID);
    ++m_NextFreeEditorID;

		/* Check for an overflow */
    if (m_NextFreeEditorID > SRESPFILE_LAST_EDITORID) {
      ++NumOverFlows;
      m_NextFreeEditorID = SRESPFILE_FIRST_EDITORID;

		/* Prevent an infinite loop in the worst case */
      if (NumOverFlows > 1) {
        m_NextFreeEditorID = 0;
		AddSrGeneralError("GetFreeEditorID(): All form IDs are in use!");
		break;
      }
    }

  } while (FindEditorID(s_Buffer) != NULL);

  return (s_Buffer);
}
/*===========================================================================
 *		End of Class Method CSrMultiRecordHandler::GetFreeEditorID()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CSrMultiRecordHandler Method - srformid_t GetFreeFormID (ModIndex);
 *
 * Returns the next available form ID not currently in use by the mod.
 *
 *=========================================================================*/
srformid_t CSrMultiRecordHandler::GetFreeFormID (const byte ModIndex) {
  dword      NumOverFlows = 0;
  srformid_t FormID;

  do {
    FormID = SR_MAKEFORMID(m_NextFreeFormID, ModIndex);
    ++m_NextFreeFormID;

		/* Check for an overflow */
    if (m_NextFreeFormID > MAX_SRFORMID) {
      ++NumOverFlows;
      m_NextFreeFormID = SRESPFILE_FIRST_FORMID;

		/* Prevent an infinite loop in the worst case */
      if (NumOverFlows > 1) {
        m_NextFreeFormID = 0;
		AddSrGeneralError("GetFreeFormID(): All form IDs are in use!");
		break;
      }
    }

  } while (FindFormID(FormID) != NULL);

  if (m_ActiveFile.GetHeader() != NULL) {
	  m_ActiveFile.GetHeader()->SetNextObjectId(FormID & 0x00ffffff);
  }

  return (FormID);
}
/*===========================================================================
 *		End of Class Method CSrMultiRecordHandler::GetFreeFormID()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CSrMultiRecordHandler Method - bool HandleDuplicateFormIDs (void);
 *
 *=========================================================================*/
bool CSrMultiRecordHandler::HandleDuplicateFormIDs (void) {
  srdupformidinfo_t* pDupFormID;
  srformid_t	     OldFormID;
  srformid_t	     NewFormID;
  dword		     Index;
  //dword		     Count;

  for (Index = 0; Index < m_DuplicateFormIDs.GetSize(); ++Index) {
    pDupFormID = m_DuplicateFormIDs.GetAt(Index);

    OldFormID  = pDupFormID->pRecord->GetFormID();
    NewFormID  = GetFreeFormID(pDupFormID->ModIndex);
    if (NewFormID == SR_FORMID_NULL) return (false);

    //Count = ChangeFormIDIndex(NewFormID, OldFormID, pDupFormID->ModIndex);
    //SystemLog.Printf("Changed %d occurences of the formid 0x%X to 0x%X!", Count, OldFormID, NewFormID);

    pDupFormID->pRecord->ChangeFormID(NewFormID, OldFormID);
    AddSrGeneralError("Duplicate formid 0x%X changed to 0x%X! Any dependant records were NOT updated!", OldFormID, NewFormID);
  }

  return (true);
}
/*===========================================================================
 *		End of Class Method CSrMultiRecordHandler::HandleDuplicateFormIDs()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CSrMultiRecordHandler Method - bool HandleDuplicateEditorIDs (void);
 *
 *=========================================================================*/
bool CSrMultiRecordHandler::HandleDuplicateEditorIDs (void) {
  srdupeditoridinfo_t*  pDupEditorID;
  CSString				OldEditorID;
  CSString				NewEditorID;
  dword					Index;
  //dword				Count;

  for (Index = 0; Index < m_DuplicateEditorIDs.GetSize(); ++Index) {
    pDupEditorID = m_DuplicateEditorIDs.GetAt(Index);

    OldEditorID  = pDupEditorID->pRecord->GetEditorID();
    NewEditorID  = GetFreeEditorID();
    if (NewEditorID.IsEmpty()) return (false);
    
    //Count = ChangeEditorIDIndex(NewEditorID, OldEditorID, pDupEditorID->ModIndex);
    //SystemLog.Printf("Changed %d occurences of the editorid %s to %s!", Count, OldEditorID.c_str(), NewEditorID.c_str());

    pDupEditorID->pRecord->ChangeEditorID(NewEditorID, OldEditorID);
    AddSrGeneralError("Duplicate editor '%s' changed to '%s'! Any dependant records were NOT updated!", OldEditorID.c_str(), NewEditorID.c_str());
  }

  return (true);
}
/*===========================================================================
 *		End of Class Method CSrMultiRecordHandler::HandleDuplicateEditorIDs()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CSrMultiRecordHandler Method - bool HasFixupChanged (FixupArray);
 *
 * Returns true if the given formid fixup array contains any changes to the
 * modindex.
 *
 *=========================================================================*/
bool CSrMultiRecordHandler::HasFixupChanged (CSrFormidFixupArray& FixupArray) {
  dword Index;

  for (Index = 0; Index < FixupArray.GetSize(); ++Index) {
    if (FixupArray[Index] != (byte) Index) return (true);
  }

  return (false);
}
/*===========================================================================
 *		End of Class Method CSrMultiRecordHandler::HasFixupChanged()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CSrMultiRecordHandler Method - bool ImportCsvRow (CsvInfo, Row);
 *
 * Attempts to import the given row from a CSV as a new record or modify
 * an existing record.  Returns true if the import was successful.
 * Assumes the the input CSV is valid and contains the necessary information
 * for importing.
 *
 *=========================================================================*/
bool CSrMultiRecordHandler::ImportCsvRow (srcsvinfo_t& CsvInfo, CCsvRow& Row) {
  CSrIdRecord* pNewRecord;
  CSrIdRecord* pOldRecord;

	/* Create or reuse an existing record */
  pNewRecord = CreateIDRecordFromCsvRow(CsvInfo, Row, pOldRecord);
  if (pNewRecord == NULL) return (false);

	/* Set the record values */
  pNewRecord->ImportCsvRow(CsvInfo, Row);

	/* Update any listeners */
  if (pOldRecord == NULL) {
    m_EventHandler.SendAddEvent(pNewRecord, NULL);
  }
  else {
    m_EventHandler.SendUpdateEvent(pNewRecord, pOldRecord);
  }

  return (true);
}
/*===========================================================================
 *		End of Class Method CSrMultiRecordHandler::ImportCsvRow()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CSrMultiRecordHandler Method - bool ImportCsv (NewRecords, CsvFile);
 *
 * Attempt to import records from the given CSV file. Returns false
 * on any error. Returns the number of new records created in the
 * given parameter.
 *
 *=========================================================================*/
bool CSrMultiRecordHandler::ImportCsv (dword& NewRecords, CCsvFile& CsvFile) {
  srcsvinfo_t    CsvInfo;
  CCsvRow*       pRow;
  dword          Index;
  bool           Result;

	/* Check if there's anything to import */
  NewRecords = 0;
  if (CsvFile.GetNumRows() <= 1) return (true);

  Result = SrPrepareImportCsvInfo(CsvInfo, CsvFile);
  if (!Result) return (false);
  
	/* Attempt to import all rows */
  for (Index = 1; Index < CsvFile.GetNumRows(); ++Index) {
    pRow = CsvFile.GetRow(Index);
    if (pRow == NULL) continue;

    CsvInfo.CurrentLine = Index;

    Result = ImportCsvRow(CsvInfo, *pRow);
    if (Result) ++NewRecords;
  }

  return (true);
}
/*===========================================================================
 *		End of Class Method CSrMultiRecordHandler::ImportCsv()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CSrMultiRecordHandler Method - bool IndexDuplicates (void);
 *
 * Indexes any records with a duplicate formid/editorid after being
 * handler.
 *
 *=========================================================================*/
bool CSrMultiRecordHandler::IndexDuplicates (void) {
  srdupeditoridinfo_t*  pDupEditorID;
  srdupformidinfo_t*    pDupFormID;
  dword					Index;

  for (Index = 0; Index < m_DuplicateFormIDs.GetSize(); ++Index) {
    pDupFormID = m_DuplicateFormIDs.GetAt(Index);
    IndexRecord(pDupFormID->pRecord);
  }

  for (Index = 0; Index < m_DuplicateEditorIDs.GetSize(); ++Index) {
    pDupEditorID = m_DuplicateEditorIDs.GetAt(Index);
    IndexRecord(pDupEditorID->pRecord);
  }

  m_DuplicateFormIDs.Destroy();
  m_DuplicateEditorIDs.Destroy();
  return (true);
}
/*===========================================================================
 *		End of Class Method CSrMultiRecordHandler::IndexDuplicates()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CSrMultiRecordHandler Method - void IndexRecord (pRecord);
 *
 * Indexes the record with no duplicate checks.
 *
 *=========================================================================*/
void CSrMultiRecordHandler::IndexRecord (CSrRecord* pRecord) {
  CSrIdRecord* pIdRecord;
  
  if (pRecord != NULL) {
    m_FormIdMap.SetAt(pRecord);

    pIdRecord = SrCastClass(CSrIdRecord, pRecord);
    if (pIdRecord != NULL) m_EditorIdMap.SetAt(pIdRecord);
  }

}
/*===========================================================================
 *		End of Class Method CSrMultiRecordHandler::IndexRecord()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CSrMultiRecordHandler Method - bool IndexCheckRecord (pRecord, ModIndex);
 *
 * Indexes the record with duplicate checks.
 *
 *=========================================================================*/
bool CSrMultiRecordHandler::IndexCheckRecord (CSrRecord* pRecord, const dword ModIndex) 
{
  srdupformidinfo_t*	pFormIDInfo;
  srdupeditoridinfo_t*	pEditorIDInfo;
  CSrIdRecord*			pIdRecord;
  bool					Result;

	/* Ignore invalid input */
  if (pRecord == NULL) return (false);

  Result = CheckDuplicateFormId(pRecord);

  if (Result) 
  {
    pFormIDInfo = new srdupformidinfo_t;
    m_DuplicateFormIDs.Add(pFormIDInfo);
    pFormIDInfo->pRecord  = pRecord;
    pFormIDInfo->ModIndex = ModIndex;
  }
  else 
  {
    m_FormIdMap.SetAt(pRecord);
  }

	/* Find an existing editorid */
  pIdRecord = SrCastClass(CSrIdRecord, pRecord);

  if (pIdRecord != NULL) 
  {
    Result = CheckDuplicateEditorId(pIdRecord);

    if (Result) 
	{
      pEditorIDInfo = new srdupeditoridinfo_t;
      m_DuplicateEditorIDs.Add(pEditorIDInfo);
      pEditorIDInfo->pRecord  = pIdRecord;
      pEditorIDInfo->ModIndex = ModIndex;
    }
    else 
	{
      m_EditorIdMap.SetAt(pIdRecord);
    }
  }  

  return (true);
}
/*===========================================================================
 *		End of Class Method CSrMultiRecordHandler::IndexCheckRecord()
 *=========================================================================*/


/*===========================================================================
 *
 * Function - int l_IndexFileCallback (pRecord, UserData, pUserPtr);
 *
 * Callback used by the IndexFile() method.
 *
 *=========================================================================*/
int l_IndexFileCallback (CSrRecord* pRecord, const dword UserData, void* pUserPtr) {
  srindexinfo_t* pInfo = (srindexinfo_t *) pUserPtr;
  int		 Result;

  if (pInfo == NULL) return (0);

  ++pInfo->RecordCount;

  if (pInfo->pCallback != NULL) {
    Result = pInfo->pCallback->UpdateCallback(pInfo->RecordCount);
    if (Result < 0) return (Result);
  }

  if (pInfo->FirstFile) 
    pInfo->pHandler->IndexCheckRecord(pRecord, pInfo->ModIndex);
  else
    pInfo->pHandler->IndexRecord(pRecord);

  return (0);
}
/*===========================================================================
 *		End of Function l_IndexFileCallback()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CSrMultiRecordHandler Method - bool IndexFile (pFile, FirstFile, ModIndex, pCallback);
 *
 * Index all records in the given file. Also checks for, and handles, 
 * duplicate IDs if not the FirstFile.
 *
 *=========================================================================*/
bool CSrMultiRecordHandler::IndexFile (CSrEspFile* pFile, const bool FirstFile, const dword ModIndex, CSrCallback* pCallback) {
  srindexinfo_t IndexInfo;
  int			Result;

  IndexInfo.FirstFile   = FirstFile;
  IndexInfo.pHandler    = this;
  IndexInfo.ModIndex    = ModIndex;
  IndexInfo.pCallback   = pCallback;
  IndexInfo.RecordCount = 0;

  Result = pFile->ForEachRecord(l_IndexFileCallback, 0, &IndexInfo);
  if (Result < 0) return (false);

  return (true);
}
/*===========================================================================
 *		End of Class Method CSrMultiRecordHandler::IndexFile()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CSrMultiRecordHandler Method - bool IndexRecords (pCallback);
 *
 *=========================================================================*/
bool CSrMultiRecordHandler::IndexRecords (CSrCallback* pCallback) {
  dword MapSize;
  dword Index;
  bool  Result;

	/* Clear the current maps */
  m_FormIdMap.Destroy();
  m_EditorIdMap.Destroy();
  
  if (pCallback != NULL) {
    dword Count = CountAllRecords();
    pCallback->Reset();
    pCallback->SetLabel("Indexing records...");
    pCallback->SetTotalRecords(Count);
    pCallback->SetCallbackInterval(Count/100);
    pCallback->ForceCallback(0);
  }

	/* Get an estimated size for the maps */
  MapSize = (dword) ((CountAllRecords() + 1031) * 1.21);
  //MapSize /= 10;
  m_FormIdMap.InitHashTable(MapSize);
  m_EditorIdMap.InitHashTable(MapSize);

	/* Add special pseudo-records */
  m_FormIdMap.SetAt(&m_PlayerRef);
  m_EditorIdMap.SetAt(&m_PlayerRef);

	/* Index all masters */
  for (Index = 0; Index < m_MasterFiles.GetSize(); ++Index) {
    Result = IndexFile(m_MasterFiles.GetAt(Index), Index == 0, Index, pCallback);
    if (!Result) return (false);
  }

	/* Index the active file */
  IndexFile(&m_ActiveFile, Index == 0, Index, pCallback);

	/* Handle any duplicates */
  HandleDuplicateFormIDs();
  HandleDuplicateEditorIDs();
  IndexDuplicates();

  return (true);
}
/*===========================================================================
 *		End of Class Method CSrMultiRecordHandler::IndexRecords()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CSrMultiRecordHandler Method - bool LoadMasterFile (pFilename, ModIndex, pCallback);
 *
 * Attempts to load a new master file. Performs no other initialization.
 *
 *=========================================================================*/
bool CSrMultiRecordHandler::LoadMasterFile (const SSCHAR* pFilename, const dword ModIndex, CSrCallback* pCallback) {
  CSString    Buffer;
  CSrEspFile* pFile;
  bool        Result;

	/* Extract just the filename from the input full filename */
  Buffer = pFilename;
  Buffer.ReverseTruncateAtR("\\:/");

	/* Special case for caching Skyrim.esm */
  if (ModIndex == 0 && Buffer.CompareNoCase(SR_GAME_MASTER) == 0) {
    m_MasterFiles.Add(&m_SkyrimMaster);
    m_SkyrimMaster.SetModIndex(0);
    m_SkyrimMaster.SetParent(this);

    if (GetOptions().EnableCaching) {
      m_SkyrimMaster.SetCacheFlags(SR_CACHE_DEFERLOAD);
    }

		/* Load the master if required */
    if (m_SkyrimMaster.GetHeader() == NULL) {
      Result = m_SkyrimMaster.Load(pFilename, pCallback);

      if (!Result) {
        m_SkyrimMaster.Destroy();
        return (false);
      }
    }

    return (true);
  }

	/* Load a regular master file */
  pFile = AddMaster();
  if (pFile == NULL) return (false);
  //pFile->SetModIndex(ModIndex);

  Result = pFile->Load(pFilename, pCallback);

  if (!Result) {
    m_MasterFiles.Delete(pFile); 
    return (false);
  }

  return (true);
}
/*===========================================================================
 *		End of Class Method CSrMultiRecordHandler::LoadMasterFile()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CSrMultiRecordHandler Method - bool Load (LoadInfo, pCallback);
 *
 * Loads a new set of masters and active plugin according to the input
 * information. Returns false on any error.
 *
 *=========================================================================*/
bool CSrMultiRecordHandler::Load (srfileloadinfo_t& LoadInfo, CSrCallback* pCallback) {
  srtimer_t   Timer;
  srtimer_t   AllTimer;
  dword       Index;
  bool        Result;

	/* Clear the current information */
  Destroy();
  SrStartTimer(AllTimer);

	/* Load all masters, if any */
  for (Index = 0; Index < LoadInfo.m_MasterFilenames.GetSize(); ++Index) {
    Result = LoadMasterFile(*LoadInfo.m_MasterFilenames[Index], Index, pCallback);
    if (!Result) return (false);
  }

	/* Load the active plugin, if any */
  if (!LoadInfo.m_ActiveFilename.IsEmpty()) {
    m_ActiveFile.SetParent(this);

    Result = m_ActiveFile.Load(LoadInfo.m_ActiveFilename, pCallback);

    m_ActiveFile.SetActive(true);
    if (!Result) return (false);
  }
  else {
    m_ActiveFile.InitializeNew();
    m_ActiveFile.SetParent(this);
    m_ActiveFile.SetActive(true);
    SetActiveMasters();
  }

  SrStartTimer(Timer);

	/* Fixup the modindex of all formids */
  Result = FixupFormids();
  if (!Result) return (false);

  SrEndTimer(Timer, "Fixed up formids in ");
  SrStartTimer(Timer);

	/* Index all records */
  Result = IndexRecords(pCallback);
  if (!Result) return (false);

  SrEndTimer(Timer, "Indexed all records in ");
  SrStartTimer(Timer);

	/* Create the overall record tree */
  Result = CreateRecordTree(pCallback);
  if (!Result) return (false);

  SrEndTimer(Timer, "Created primary record/group tree in ");
  SrEndTimer(AllTimer, "Loaded and initialized all files in ");
  return (true);
}
/*===========================================================================
 *		End of Class Method CSrMultiRecordHandler::Load()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CSrMultiRecordHandler Method - bool MoveNewRecord (pRecord);
 *
 * Moves a new, unattached record, to the active file and record tree.
 *
 *=========================================================================*/
bool CSrMultiRecordHandler::MoveNewRecord (CSrRecord* pRecord) {
  CSrRefGroupArray	GroupArray;
  CSrGroup*			pMatchGroup;
  CSrGroup*			pCurrentGroup;
  CSrGroup*			pGroup;
  int  				Index;
  bool				Result;

	/* Attempt to move the given record in to the active file 
	   TODO: Won't work for all record types */
  Result = m_ActiveFile.AddRecord(pRecord);

  if (!Result) {
    SystemLog.Printf("Error adding record 0x%X to active file!", pRecord->GetFormID());
  }

  pRecord->SetParent(&m_ActiveFile);

  	/* Get the group heirarchy of the existing record */
  pGroup = pRecord->GetParentGroup();

  while (pGroup != NULL) {
    GroupArray.Add(pGroup);
    pGroup = pGroup->GetParentGroup();
  }

	/* Recreate the group heirarchy in the top level tree */
  pCurrentGroup = &m_TopFileGroup;

  for (Index = GroupArray.GetSize() -  1; Index >= 0; --Index) {
    pMatchGroup = GroupArray[Index];

    pGroup = pCurrentGroup->FindSubGroup(pMatchGroup);
    if (pGroup == NULL) pGroup = pCurrentGroup->CreateSubGroup(pMatchGroup);

    if (pGroup == NULL) {
      AddSrGeneralError("Failed to recreate group heirarchy in overall group for new active record 0x%X!", pRecord->GetFormID());
      return (true); /* Must return true at this point */
    }

    pCurrentGroup = pGroup;
  }

	/* Add the record to the last created group */	
  pCurrentGroup->AddRecord(pRecord);

  return (true);
}
/*===========================================================================
 *		End of Class Method CSrMultiRecordHandler::MoveNewRecord()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CSrMultiRecordHandler Method - CSrRecord* MakeRecordActivePriv (pRecord, IndexRecord);
 *
 * Ensures the given record exists in the active file. If it already
 * does it is merely returned. It not, a copy of it is created in the 
 * active file and the index updated if needed.
 *
 * This is a protected class member. MakeRecordActive() is the public
 * accessible method.
 *
 *=========================================================================*/
CSrRecord* CSrMultiRecordHandler::MakeRecordActivePriv (CSrRecord* pRecord, const bool IndexRecord) 
{
  CSrRecord*		pNewRecord;
  CSrRefGroupArray	GroupArray;
  CSrGroup*			pMatchGroup;
  CSrGroup*			pGroup;
  CSrGroup*			pCurrentGroup;
  CSrGroup*			pOverallGroup;
  CSrGroup*			pGroup1;
  int				Index;

	/* Ignore if already active */
  if (pRecord->IsActive()) return (pRecord);

	/* Create a copy of the given record */
  pNewRecord = CreateSrRecord(pRecord->GetRecordType());
  pNewRecord->Copy(pRecord);
  pNewRecord->SetParent(&m_ActiveFile);
  pNewRecord->SetParentGroup(NULL);

	/* Get the group heirarchy of the existing record */
  pGroup = pRecord->GetParentGroup();

  while (pGroup != NULL) {
    GroupArray.Add(pGroup);
    pGroup = pGroup->GetParentGroup();
  }

	/* Recreate the group heirarchy in the active file and top level tree */
  pCurrentGroup = &m_ActiveFile.GetRecords();
  pOverallGroup = &m_TopFileGroup;

  for (Index = GroupArray.GetSize() -  1; Index >= 0; --Index) {
    pMatchGroup = GroupArray[Index];

    pGroup = pCurrentGroup->FindSubGroup(pMatchGroup);
    if (pGroup == NULL) pGroup = pCurrentGroup->CreateSubGroup(pMatchGroup);

    if (pGroup == NULL) {
      AddSrGeneralError("Failed to recreate group heirarchy in active file for new active record 0x%X!", pNewRecord->GetFormID());
      delete pNewRecord;
      return (NULL);
    }

    if (pOverallGroup != NULL) {
      pGroup1 = pOverallGroup->FindSubGroup(pMatchGroup);
      if (pGroup1 == NULL) pGroup1 = pOverallGroup->CreateSubGroup(pMatchGroup);

      if (pGroup1 == NULL) {
        SystemLog.Printf("Failed to recreate group heirarchy in overall record tree for new active record 0x%X!",  pNewRecord->GetFormID());
      }
    }

    pCurrentGroup = pGroup;
    pOverallGroup = pGroup1;
  }

	/* Add the record to the last created group */	
  pCurrentGroup->GetRecords().Add(pNewRecord);
  pNewRecord->SetParentGroup(pCurrentGroup);

	/* Update the overall record tree if valid */
  if (pOverallGroup != NULL) {
    pOverallGroup->AddExistingRecord(pNewRecord);
  }
  
  m_ActiveFile.ModRecordCount(1);

	/* Update the index if needed */
  if (IndexRecord) {
    RemoveFromIndex(pRecord);
    this->IndexRecord(pNewRecord);
  }

  return (pNewRecord);
}
/*===========================================================================
 *		End of Class Method CSrMultiRecordHandler::MakeRecordActivePriv()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CSrMultiRecordHandler Method - bool NewFile (void);
 *
 *=========================================================================*/
bool CSrMultiRecordHandler::NewFile (void) {
  Destroy();

  m_ActiveFile.InitializeNew();
  m_ActiveFile.SetActive(true);
  m_ActiveFile.AddMaster(SR_GAME_MASTER, 0);
  m_ActiveFile.SetModIndex(1);

  return (true);
}
/*===========================================================================
 *		End of Class Method CSrMultiRecordHandler::NewFile()
 *========================================================================*/


/*===========================================================================
 *
 * Class CSrMultiRecordHandler Method - bool DeleteNewRecord (pRecord);
 *
 * Deletes the given new record.
 *
 *=========================================================================*/
bool CSrMultiRecordHandler::DeleteNewRecord (CSrRecord* pRecord) {
  return m_NewRecords.Delete(pRecord);
}
/*===========================================================================
 *		End of Class Method CSrMultiRecordHandler::DeleteNewRecord()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CSrMultiRecordHandler Method - bool RemoveNewRecord (pRecord);
 *
 * Deletes the given new record.
 *
 *=========================================================================*/
bool CSrMultiRecordHandler::RemoveNewRecord (CSrRecord* pRecord) {
  return (m_NewRecords.Remove(pRecord) != NULL);
}
/*===========================================================================
 *		End of Class Method CSrMultiRecordHandler::RemoveNewRecord()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CSrMultiRecordHandler Method - CSrRecord* PrepareNewRecord (RecordType);
 *
 * Prepares a new record for editing. Does not add the record to the
 * active file or the record tree. Returns NULL on any error.
 *
 *=========================================================================*/
CSrRecord* CSrMultiRecordHandler::PrepareNewRecord (const srrectype_t RecordType) {
  CSrRecord* pRecord;

  pRecord = CreateSrRecord(RecordType);
  if (pRecord == NULL) return (NULL);

  m_NewRecords.Add(pRecord);

  pRecord->InitializeNew();
  pRecord->SetFormID(GetActiveFreeFormID());
  pRecord->SetParent(&m_ActiveFile);

  return (pRecord);
}
/*===========================================================================
 *		End of Class Method CSrMultiRecordHandler::PrepareNewRecord()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CSrMultiRecordHandler Event - int OnCancelEditRecord (EditInfo);
 *
 *=========================================================================*/
int CSrMultiRecordHandler::OnCancelEditRecord (sreditrecinfo_t& EditInfo) {

	/* Delete a new record that was cancelled */
  if (EditInfo.IsNew && !EditInfo.IsHandled) {
    DeleteNewRecord(EditInfo.pOldRecord);
    EditInfo.pOldRecord = NULL;
  }

  return (SR_RESULT_OK);
}
/*===========================================================================
 *		End of Class Event CSrMultiRecordHandler::OnCancelEditRecord()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CSrMultiRecordHandler Event - int OnPreSaveCheckEditorID (EditInfo);
 *
 *=========================================================================*/
int CSrMultiRecordHandler::OnPreSaveCheckEditorID (sreditrecinfo_t& EditInfo) {
  CSrIdRecord* pIdRecord;
  bool         Result;

	/* Prepare the editor ID string */
  Result = SrPrepareEditorID(EditInfo.NewEditorID);

  if (EditInfo.NewEditorID.IsEmpty()) {
    AddSrGeneralError("Blank editor IDs are not allowed!");
    return (SR_RESULT_ERROR);
  }
  else if (!Result) {
    AddSrGeneralError("The editor ID '%s' is not valid!", EditInfo.NewEditorID.c_str());
    return (SR_RESULT_ERROR);
  }

	/* Has the editor ID changed for an existing record? */
  if (EditInfo.pOldRecord != NULL && !EditInfo.IsNew) {
    pIdRecord = SrCastClass(CSrIdRecord, EditInfo.pOldRecord);
    Result    = pIdRecord->IsEditorID(EditInfo.NewEditorID);
    EditInfo.HasUpdatedID = !Result;
  }

	/* Check for duplicate IDs */
  if ((EditInfo.HasUpdatedID || EditInfo.IsNew) && !EditInfo.IsHandled) {
    pIdRecord = FindEditorID(EditInfo.NewEditorID);

    if (pIdRecord != NULL && pIdRecord != EditInfo.pOldRecord) {
      AddSrGeneralError("The editor ID '%s' is already in use!", EditInfo.NewEditorID.c_str());
      return (SR_RESULT_ERROR);
    }

		/* Prompt to rename or copy if required */
    if (EditInfo.HasUpdatedID && !EditInfo.IsNew && !EditInfo.IsHandled) return (SR_RESULT_PROMPTRENAMECOPY);
  }

  return (SR_RESULT_OK);
}
/*===========================================================================
 *		End of Class Event CSrMultiRecordHandler::OnPreSaveCheckEditorID()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CSrMultiRecordHandler Event - int OnPreSaveRecord (EditInfo);
 *
 *=========================================================================*/
int CSrMultiRecordHandler::OnPreSaveRecord (sreditrecinfo_t& EditInfo) {
  bool Result;

	/* Ensure the new record is active */
  if (EditInfo.pNewRecord == NULL) {
    Result = UpdateNewEditRecord(EditInfo);
    if (!Result) return (SR_RESULT_ERROR);
  }

	/* Create the undo action for the update */
  if (EditInfo.IsNew || EditInfo.IsCopy) {
    CreateUndoAdd(EditInfo);
  }
  else {
    CreateUndoUpdate(EditInfo);
  }

  return (SR_RESULT_OK);
}
/*===========================================================================
 *		End of Class Event CSrMultiRecordHandler::OnPreSaveRecord()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CSrMultiRecordHandler Event - int OnPostSaveRecord (EditInfo);
 *
 *=========================================================================*/
int CSrMultiRecordHandler::OnPostSaveRecord (sreditrecinfo_t& EditInfo) 
{

		/* Update any indices if required */
	if (EditInfo.NeedsIndex) {
		if (!EditInfo.IsCopy) RemoveFromIndex(EditInfo.pOldRecord);
		IndexRecord(EditInfo.pNewRecord);
	}

		/* Call update listeners */
	if (EditInfo.IsNew || EditInfo.IsCopy) 
	{
		m_EventHandler.SendAddEvent(EditInfo.pNewRecord, EditInfo.pOldRecord);
	}
	else 
	{
		m_EventHandler.SendUpdateEvent(EditInfo.pNewRecord, EditInfo.pOldRecord);
	}

	return (SR_RESULT_OK);
}
/*===========================================================================
 *		End of Class Event CSrMultiRecordHandler::OnPostSaveRecord()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CSrMultiRecordHandler Method - bool RemoveFromIndex (pRecord);
 *
 * Removes the given record from all indexes.
 *
 *=========================================================================*/
bool CSrMultiRecordHandler::RemoveFromIndex (CSrRecord* pRecord) {
  CSrIdRecord* pIdRecord;

  if (pRecord == NULL) return (true);
  pIdRecord = SrCastClass(CSrIdRecord, pRecord);

  m_FormIdMap.Delete(pRecord);
  if (pIdRecord != NULL) m_EditorIdMap.Delete(pIdRecord);

  return (true);
}
/*===========================================================================
 *		End of Class Method CSrMultiRecordHandler::RemoveFromIndex()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CSrMultiRecordHandler Method - bool RenameIDRecord(pRecord, pNewEditorID);
 *
 * Renames the editorid for the given ID record. Public method that calls
 * the necessary listeneres and creates an undo item. Returns false on
 * any error.
 *
 * Assumes a valid editorid input.
 *
 *=========================================================================*/
bool CSrMultiRecordHandler::RenameIDRecord (CSrIdRecord* pRecord, const SSCHAR* pNewEditorID) {
  CSrIdRecord* pNewRecord;
  
	/* Ignore invalid input */
  if (pRecord == NULL || pNewEditorID == NULL) return (false);

	/* Preupdate the listeners */
  m_EventHandler.SendPreUpdateEvent(pRecord, 0);

	/* Rename the record */
  pNewRecord = RenameIDRecordPriv(pRecord, pNewEditorID, true);
  if (pNewRecord == NULL) return (false);

  	/* Update listeners */
  m_EventHandler.SendUpdateEvent(pNewRecord, pRecord);
  return (true);
}
/*===========================================================================
 *		End of Class Method CSrMultiRecordHandler::RenameIDRecord()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CSrMultiRecordHandler Method - CSrIdRecord* RenameIDRecordPriv (pRecord, pNewEditorID, CreateUndo);
 *
 * Renames the editorid for the given record. Assumes a valid editorid input.
 * Protected class method.
 *
 *=========================================================================*/
CSrIdRecord* CSrMultiRecordHandler::RenameIDRecordPriv (CSrIdRecord* pRecord, const SSCHAR* pNewEditorID, const bool CreateUndo) {
  CSrRecord*      pNewRecord;
  CSrIdRecord*    pNewIdRecord;
  sreditrecinfo_t EditInfo;

  	/* Remove the record from the current index */
  RemoveFromIndex(pRecord);

	/* Ensure the given record exists the active file */
  pNewRecord = MakeRecordActivePriv(pRecord, false);
  if (pNewRecord == NULL) return (NULL);
  pNewIdRecord = SrCastClass(CSrIdRecord, pNewRecord);
  
  	/* Create the undo item */
  if (CreateUndo) {
    EditInfo.pNewRecord   = pNewRecord;
    EditInfo.pOldRecord   = pRecord;
    EditInfo.NewEditorID  = pNewEditorID;
    EditInfo.HasUpdatedID = true;
    EditInfo.IsRenamed    = true;
    CreateUndoUpdate(EditInfo);
  }

	/* Update the record and re-index */
  if (pNewIdRecord != NULL) pNewIdRecord->SetEditorID(pNewEditorID);
  IndexRecord(pNewRecord);

  return (pNewIdRecord);
}
/*===========================================================================
 *		End of Class Method CSrMultiRecordHandler::RenameIDRecordPriv()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CSrMultiRecordHandler Method - bool SetActiveMasters (void);
 *
 * Sets the masters of the active file according to the current list.
 *
 *=========================================================================*/
bool CSrMultiRecordHandler::SetActiveMasters (void) {
  CSrTes4Record* pHeader;
  CSString	 Buffer;
  dword		 Index;

  pHeader = m_ActiveFile.GetHeader();
  if (pHeader == NULL) return (false);
  pHeader->DeleteMasters();

	/* Add all masters in their current order */
  for (Index = 0; Index < m_MasterFiles.GetSize(); ++Index) {
    Buffer = m_MasterFiles[Index]->GetFilename();
    Buffer.ReverseTruncateAtR(":\\/");
    pHeader->AddMaster(Buffer, 0);
  }

  return (true);
}
/*===========================================================================
 *		End of Class Method CSrMultiRecordHandler::SetActiveMasters()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CSrMultiRecordHandler Method - CSrRecord* ToggleQuestFlag (pRecord);
 *
 * Toggles the quest flag on the given record. Returns the updated record
 * or NULL on any error.
 *
 *=========================================================================*/
CSrRecord* CSrMultiRecordHandler::ToggleQuestFlag (CSrRecord* pRecord) {
  CSrRecord* pNewRecord;

	/* Create the undo event */
  CreateUndoUpdate(pRecord);

  	/* Update listeners */
  m_EventHandler.SendPreUpdateEvent(pRecord);

	/* Ensure the record is in the active file */
  pNewRecord = MakeRecordActivePriv(pRecord, true);
  if (pNewRecord == NULL) return (NULL);

	/* Toggle the flag */
  pNewRecord->SetQuestItem(!pNewRecord->IsQuestItem());

	/* Update listeners */
  m_EventHandler.SendUpdateEvent(pNewRecord, pRecord);
  return (pNewRecord);
}
/*===========================================================================
 *		End of Class Method CSrMultiRecordHandler::ToggleQuestFlag()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CSrMultiRecordHandler Method - CSrRecord* ToggleDeleteFlag (pRecord);
 *
 * Toggles the deleted flag on the given record. Returns the updated record
 * or NULL on any error.
 *
 *=========================================================================*/
CSrRecord* CSrMultiRecordHandler::ToggleDeleteFlag (CSrRecord* pRecord) {
  CSrRecord* pNewRecord;

	/* Create the undo event */
  CreateUndoUpdate(pRecord);

	/* Update listeners */
  m_EventHandler.SendPreUpdateEvent(pRecord);

	/* Ensure the record is in the active file */
  pNewRecord = MakeRecordActivePriv(pRecord, true);
  if (pNewRecord == NULL) return (NULL);

	/* Toggle the flag */
  pNewRecord->SetDeleted(!pNewRecord->IsDeleted());

	/* Update listeners */
  m_EventHandler.SendUpdateEvent(pNewRecord, pRecord);
  return (pRecord);
}
/*===========================================================================
 *		End of Class Method CSrMultiRecordHandler::ToggleDeleteFlag()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CSrMultiRecordHandler Method - CSrRecord* ToggleIgnoreFlag (pRecord);
 *
 * Toggles the ignored flag on the given record. Returns the updated record
 * or NULL on any error.
 *
 *=========================================================================*/
CSrRecord* CSrMultiRecordHandler::ToggleIgnoreFlag (CSrRecord* pRecord) {
  CSrRecord* pNewRecord;

	/* Create the undo event */
  CreateUndoUpdate(pRecord);

	/* Update listeners */
  m_EventHandler.SendPreUpdateEvent(pRecord);

	/* Ensure the record is in the active file */
  pNewRecord = MakeRecordActivePriv(pRecord, true);
  if (pNewRecord == NULL) return (NULL);

	/* Toggle the flag */
  pNewRecord->SetIgnored(!pNewRecord->IsIgnored());

	/* Update listeners */
  m_EventHandler.SendUpdateEvent(pNewRecord, pRecord);
  return (pRecord);
}
/*===========================================================================
 *		End of Class Method CSrMultiRecordHandler::ToggleIgnoreFlag()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CSrMultiRecordHandler Method - bool UpdateRecordTree (pNewRecord, pOldRecord);
 *
 * Updates the overall record tree item for the given record. If the new
 * record is NULL the record is removed from the tree.
 *
 *=========================================================================*/
bool CSrMultiRecordHandler::UpdateRecordTree (CSrRecord* pNewRecord, CSrRecord* pOldRecord) {
  CSrRefGroupArray GroupArray;
  CSrGroup*        pCurrentGroup;
  CSrGroup*        pMatchGroup;
  CSrGroup*        pGroup;
  int              Index;
  bool		   Result;

	/* Ignore invalid input */
  if (pOldRecord == NULL) return (false);

	/* Get the group heirarchy of the old record */
  pGroup = pOldRecord->GetParentGroup();

  while (pGroup != NULL) {
    GroupArray.Add(pGroup);
    pGroup = pGroup->GetParentGroup();
  }

	/* Find the record in the overall record tree */
  pCurrentGroup = &m_TopFileGroup;

  for (Index = GroupArray.GetSize() -  1; Index >= 0; --Index) {
    pMatchGroup = GroupArray[Index];

    pGroup = pCurrentGroup->FindSubGroup(pMatchGroup);
    if (pGroup == NULL) pGroup = pCurrentGroup->CreateSubGroup(pMatchGroup);

    if (pGroup == NULL) {
      return AddSrGeneralError("Failed to update group heirarchy for record 0x%X!", pOldRecord->GetFormID());
    }

    pCurrentGroup = pGroup;
  }

	/* Remove the old record from the group */
  Result = pCurrentGroup->DeleteRecord(pOldRecord);
  if (!Result) AddSrGeneralError("Failed to delete the old version of record 0x%X!", pOldRecord->GetFormID());
  
	/* Add the new record if it exists */
  if (pNewRecord != NULL) pCurrentGroup->AddRecord(pNewRecord);
  return (true);
}
/*===========================================================================
 *		End of Class Method CSrMultiRecordHandler::UpdateRecordTree()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CSrMultiRecordHandler Method - bool UpdateNewEditRecord (EditRecInfo);
 *
 * Creates or updates the new record in the given edit structure depending
 * on how the record is being updated. Returns false on any error.
 *
 *=========================================================================*/
bool CSrMultiRecordHandler::UpdateNewEditRecord (sreditrecinfo_t& EditRecInfo) {
  bool Result;

	/* Ignore if the record has already been handled */
  if (EditRecInfo.IsHandled) return (true);

	/* Create a new record */
  if (EditRecInfo.IsNew) {

    	 	/* Move new record into the active file and tree */
    Result = MoveNewRecord(EditRecInfo.pOldRecord);
    if (!Result) return (false);

    m_NewRecords.Remove(EditRecInfo.pOldRecord);
    EditRecInfo.pNewRecord   = EditRecInfo.pOldRecord;
    EditRecInfo.IsNew        = true;
    EditRecInfo.HasUpdatedID = true;
    EditRecInfo.IsHandled    = true;
    EditRecInfo.NeedsIndex   = true;
  }
  else if (EditRecInfo.IsCopy) {
    EditRecInfo.pNewRecord = CreateSrRecord(EditRecInfo.pOldRecord->GetRecordType());
    m_NewRecords.Add(EditRecInfo.pNewRecord);

    EditRecInfo.pNewRecord->Copy(EditRecInfo.pOldRecord);
    EditRecInfo.pNewRecord->SetFormID(GetActiveFreeFormID());

    Result = MoveNewRecord(EditRecInfo.pNewRecord);

    if (!Result) {
      EditRecInfo.pNewRecord = NULL;
      m_NewRecords.Delete(EditRecInfo.pNewRecord);
      return (false);
    }

    m_NewRecords.Remove(EditRecInfo.pNewRecord);
    EditRecInfo.IsHandled  = true;
    EditRecInfo.NeedsIndex = true;
  }
	/* Ensure the record is active */
  else {
    EditRecInfo.pNewRecord = MakeRecordActivePriv(EditRecInfo.pOldRecord, false);
    if (EditRecInfo.pNewRecord == NULL) return (false);

    if (EditRecInfo.pNewRecord != EditRecInfo.pOldRecord) EditRecInfo.NeedsIndex = true;
    if (EditRecInfo.HasUpdatedID) EditRecInfo.NeedsIndex = true;
    EditRecInfo.IsHandled = true;
  }

  return (true);
}
/*===========================================================================
 *		End of Class Method CSrMultiRecordHandler::UpdateNewEditRecord()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CSrMultiRecordHandler Method - CSrUndoItem* CreateUndoClean (pRecord);
 *
 *=========================================================================*/
CSrUndoItem* CSrMultiRecordHandler::CreateUndoClean (CSrRecord* pRecord) {
  CSrUndoItem* pUndoItem;

	/* Ignore invalid input or if not undoing */
  if (pRecord == NULL || !m_Options.Undo.EnableUndo) return (NULL);

	/* Create a new undo object */
  pUndoItem = new CSrUndoItem;
  m_UndoItems.Add(pUndoItem);

	/* Initialize the undo object */
  pUndoItem->SetActionType(SR_UNDOTYPE_CLEANRECORD);
  pUndoItem->CopyRecord(pRecord);

  TrimUndoItems();
  return (pUndoItem);
}
/*===========================================================================
 *		End of Class Method CSrMultiRecordHandler::CreateUndoClean()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CSrMultiRecordHandler Method - CSrUndoItem* CreateUndoAdd (EditInfo);
 *
 *=========================================================================*/
CSrUndoItem* CSrMultiRecordHandler::CreateUndoAdd (sreditrecinfo_t& EditInfo) {
  CSrUndoItem* pUndoItem;

	/* Ignore invalid input or if not undoing */
  if (EditInfo.pNewRecord == NULL || !m_Options.Undo.EnableUndo) return (NULL);

	/* Create a new undo object */
  pUndoItem = new CSrUndoItem;
  m_UndoItems.Add(pUndoItem);

	/* Initialize the undo object */
  pUndoItem->SetActionType(SR_UNDOTYPE_ADDRECORD);
  pUndoItem->CopyRecord(EditInfo.pNewRecord);
  pUndoItem->SetNewEditorID(EditInfo.NewEditorID);

  TrimUndoItems();
  return (pUndoItem);
}
/*===========================================================================
 *		End of Class Method CSrMultiRecordHandler::CreateUndoAdd()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CSrMultiRecordHandler Method - CSrUndoItem* CreateUndoAdd (pRecord, pNewEditorID);
 *
 *=========================================================================*/
CSrUndoItem* CSrMultiRecordHandler::CreateUndoAdd (CSrRecord* pRecord, const char* pNewEditorID) {
  CSrUndoItem* pUndoItem;

	/* Ignore invalid input or if not undoing */
  if (pRecord == NULL || pNewEditorID == NULL || !m_Options.Undo.EnableUndo) return (NULL);

	/* Create a new undo object */
  pUndoItem = new CSrUndoItem;
  m_UndoItems.Add(pUndoItem);

	/* Initialize the undo object */
  pUndoItem->SetActionType(SR_UNDOTYPE_ADDRECORD);
  pUndoItem->CopyRecord(pRecord);
  pUndoItem->SetNewEditorID(pNewEditorID);

  TrimUndoItems();
  return (pUndoItem);
}
/*===========================================================================
 *		End of Class Method CSrMultiRecordHandler::CreateUndoAdd()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CSrMultiRecordHandler Method - CSrUndoItem* CreateUndoUpdate (pRecord);
 *
 *=========================================================================*/
CSrUndoItem* CSrMultiRecordHandler::CreateUndoUpdate (CSrRecord* pRecord) {
  CSrUndoItem* pUndoItem;

	/* Ignore invalid input or if not undoing */
  if (pRecord == NULL || !m_Options.Undo.EnableUndo) return (NULL);

	/* Create a new undo object */
  pUndoItem = new CSrUndoItem;
  m_UndoItems.Add(pUndoItem);

	/* Initialize the undo object */
  pUndoItem->SetActionType(SR_UNDOTYPE_UPDATERECORD);
  pUndoItem->CopyRecord(pRecord);

  TrimUndoItems();
  return (pUndoItem);
}
/*===========================================================================
 *		End of Class Method CSrMultiRecordHandler::CreateUndoUpdate()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CSrMultiRecordHandler Method - CSrUndoItem* CreateUndoUpdate (EditRecInfo);
 *
 *=========================================================================*/
CSrUndoItem* CSrMultiRecordHandler::CreateUndoUpdate (sreditrecinfo_t& EditRecInfo) {
  CSrUndoItem* pUndoItem;

	/* Ignore invalid input or if not undoing */
  if (!m_Options.Undo.EnableUndo) return (NULL);

  	/* Create a new undo object */
  pUndoItem = new CSrUndoItem;
  m_UndoItems.Add(pUndoItem);

	/* Initialize the undo object */
  pUndoItem->CreateUndoInfo(EditRecInfo);
  pUndoItem->SetActionType(SR_UNDOTYPE_UPDATERECORD);

  TrimUndoItems();
  return (pUndoItem);
}
/*===========================================================================
 *		End of Class Method CSrMultiRecordHandler::CreateUndoUpdate()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CSrMultiRecordHandler Method - bool PerformUndo (void);
 *
 * Performs the last undo item if any. Returns true if the undo was
 * performed successfully.
 *
 *=========================================================================*/
bool CSrMultiRecordHandler::PerformUndo (void) {
  CSrUndoItem*  pUndoItem;
  bool		Result;

	/* Ignore if nothing to undo */
  if (m_UndoItems.GetSize() == 0) return (false);

  pUndoItem = m_UndoItems.Remove(m_UndoItems.GetSize() - 1);

  Result = PerformUndo(pUndoItem);

  delete pUndoItem;
  return (Result);
}
/*===========================================================================
 *		End of Class Method CSrMultiRecordHandler::PerformUndo()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CSrMultiRecordHandler Method - bool PerformUndo (pUndoItem);
 *
 * Performs the given undo action and returns true if successful.
 *
 *=========================================================================*/
bool CSrMultiRecordHandler::PerformUndo (CSrUndoItem* pUndoItem) {

	/* Ignore invalid input */
  if (pUndoItem == NULL) return (false);

  switch (pUndoItem->GetActionType()) {
    case SR_UNDOTYPE_ADDRECORD:    return PerformAddUndo(pUndoItem);
    case SR_UNDOTYPE_CLEANRECORD:  return PerformCleanUndo(pUndoItem);
    case SR_UNDOTYPE_UPDATERECORD: return PerformUpdateUndo(pUndoItem);
  }

  return (false);
}
/*===========================================================================
 *		End of Class Method CSrMultiRecordHandler::PerformUndo()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CSrMultiRecordHandler Method - bool PerformAddUndo (pUndoItem);
 *
 * Attempts to perform the given add undo item, returning true on success.
 *
 *=========================================================================*/
bool CSrMultiRecordHandler::PerformAddUndo (CSrUndoItem* pUndoItem) {
  CSrRecord* pRecord;

	/* Ignore invalid input */
  if (pUndoItem == NULL) return (false);

  if (pUndoItem->GetRecord() != NULL) {
    pRecord = FindFormID(pUndoItem->GetRecord()->GetFormID());

    if (pRecord == NULL) {
      AddSrGeneralError("Failed to find the record 0x%X for the undo add command!", pUndoItem->GetRecord()->GetFormID());
      return (false);
    }

		/* Update listeners */
    m_EventHandler.SendPreUpdateEvent(pRecord);

    RemoveFromIndex(pRecord);
    UpdateRecordTree(NULL, pRecord);

		/* Update listeners */
    m_EventHandler.SendCleanEvent(NULL, pRecord);

    m_ActiveFile.DeleteRecord(pRecord);
  }

  return (true);
}
/*===========================================================================
 *		End of Class Method CSrMultiRecordHandler::PerformAddUndo()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CSrMultiRecordHandler Method - bool PerformCleanUndo (pUndoItem);
 *
 * Attempts to perform the given clean undo item, returning true on success.
 *
 *=========================================================================*/
bool CSrMultiRecordHandler::PerformCleanUndo (CSrUndoItem* pUndoItem) {
  CSrRecord* pRecord;
  CSrRecord* pNewRecord;
  bool       Result;

	/* Ignore invalid input */
  if (pUndoItem == NULL) return (false);
  if (pUndoItem->GetRecord() == NULL) return (false);

	/* Find an existing version of the record */
  pRecord = FindFormID(pUndoItem->GetRecord()->GetFormID()); 

	/* Add a new record */
  if (pRecord == NULL) {
    pRecord = pUndoItem->GetRecord();

    Result = MoveNewRecord(pRecord);
    if (!Result) return (false);

    IndexRecord(pRecord);
    pUndoItem->SetRecord(NULL);

    		/* Update listeners */
    m_EventHandler.SendAddEvent(pRecord, NULL);
    return (true);
  }

	/* Update all listeners */
  m_EventHandler.SendPreUpdateEvent(pRecord);

	/* Update an existing record */
  RemoveFromIndex(pRecord);

  pNewRecord = MakeRecordActivePriv(pRecord, false);
  pNewRecord->Destroy();
  pNewRecord->Copy(pUndoItem->GetRecord());

  IndexRecord(pNewRecord);

	/* Update listeners */
  m_EventHandler.SendUpdateEvent(pNewRecord, pRecord);
  return (true);
}
/*===========================================================================
 *		End of Class Method CSrMultiRecordHandler::PerformCleanUndo()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CSrMultiRecordHandler Method - bool PerformUpdateUndo (pUndoItem);
 *
 * Attempts to perform the given update undo item, returning true on success.
 *
 *=========================================================================*/
bool CSrMultiRecordHandler::PerformUpdateUndo (CSrUndoItem* pUndoItem) {
  CSrRecord* pRecord;
  CSrRecord* pOldRecord;

	/* Ignore invalid input */
  if (pUndoItem == NULL) return (false);
  
	/* Delete a record copy (must be a new record) */
  if (pUndoItem->IsCopy()) {
    pRecord = FindFormID(pUndoItem->GetNewFormID());
    if (pRecord == NULL) return AddSrGeneralError("Cannot find copied record 0x%X to undo!", pUndoItem->GetNewFormID());

		/* Update listeners */
    m_EventHandler.SendPreUpdateEvent(pRecord);
    
    RemoveFromIndex(pRecord);
    UpdateRecordTree(NULL, pRecord);

		/* Update listeners */
    m_EventHandler.SendCleanEvent(NULL, pRecord);

    m_ActiveFile.DeleteRecord(pRecord);
    return (true);
  }

	/* Ensure a valid record to undo */
  if (pUndoItem->GetRecord() == NULL) return (false);
  pRecord = FindFormID(pUndoItem->GetRecord()->GetFormID());

  if (pRecord == NULL) {
    AddSrGeneralError("Cannot find updated record 0x%X to undo!", pUndoItem->GetRecord()->GetFormID());
    return (false);
  }

	/* Undo from active to active */
  if (pUndoItem->GetRecord()->IsActive()) {

    		/* Update listeners */
    m_EventHandler.SendPreUpdateEvent(pRecord);

    RemoveFromIndex(pRecord);
    pRecord->Copy(pUndoItem->GetRecord());
    IndexRecord(pRecord);

	/* Update listeners */
    m_EventHandler.SendUpdateEvent(pRecord, pRecord);
    return (true);
  }
  
	/* Update from active to non-active */
  m_EventHandler.SendPreUpdateEvent(pRecord);

  pOldRecord = FindNonActiveRecord(pRecord);
  RemoveFromIndex(pRecord);
  UpdateRecordTree(pOldRecord, pRecord);
  if (pOldRecord != NULL) IndexRecord(pOldRecord);

  	/* Update listeners */
  m_EventHandler.SendUpdateEvent(pOldRecord, pRecord);

  m_ActiveFile.DeleteRecord(pRecord);
  return (true);
}
/*===========================================================================
 *		End of Class Method CSrMultiRecordHandler::PerformUpdateUndo()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CSrMultiRecordHandler Method - bool PerformUndoTo (pUndoItem);
 *
 *=========================================================================*/
bool CSrMultiRecordHandler::PerformUndoTo (CSrUndoItem* pUndoItem) {
  CSrUndoItem* pItem;
  int	       Index;
  int          ItemIndex;
  
	/* Find the item in the list */
  ItemIndex = m_UndoItems.Find(pUndoItem);
  if (ItemIndex < 0) return (false);

  for (Index = (int) m_UndoItems.GetSize() - 1; Index >= ItemIndex; --Index) {
    pItem = m_UndoItems.Remove(Index);

    PerformUndo(pItem);

    delete pItem;
  }

  return (true);
}
/*===========================================================================
 *		End of Class Method CSrMultiRecordHandler::PerformUndoTo()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CSrMultiRecordHandler Method - void TrimUndoItems (void);
 *
 * Removes any undo items over the undo limit.
 *
 *=========================================================================*/
void CSrMultiRecordHandler::TrimUndoItems (void) {

	/* Special case for a very low limit */
  if (GetOptions().Undo.UndoLimit <= 2 && m_UndoItems.GetSize() <= 2) return;
  if (m_UndoItems.GetSize() < GetOptions().Undo.UndoLimit) return;

	/* Just remove the first item in the list */
  m_UndoItems.Delete((dword)0);
  
}
/*===========================================================================
 *		End of Class Method CSrMultiRecordHandler::TrimUndoItems()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CSrMultiRecordHandler Method - bool MakeRecordActive (pRecord);
 *
 * Moves the given record to the active file if required. Listeners
 * are updated as needed. False is returned on any error.
 *
 *=========================================================================*/
bool CSrMultiRecordHandler::MakeRecordActive (CSrRecord* pRecord) 
{
  CSrRecord* pNewRecord;

	/* Ignore invalid input */
  if (pRecord == NULL) return (false);

	/* Ignore a record that is already active */
  if (pRecord->IsActive()) return (true);

	/* Update listeneres */
  m_EventHandler.SendPreUpdateEvent(pRecord);

	/* Create undo item */
  CreateUndoUpdate(pRecord);

	/* Perform the move */
  pNewRecord = MakeRecordActivePriv(pRecord, true);
  if (pNewRecord == NULL) return (false);

	/* Update listeners */
  m_EventHandler.SendUpdateEvent(pNewRecord, pRecord);
  return (true);
}
/*===========================================================================
 *		End of Class Method CSrMultiRecordHandler::MakeRecordActive()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CSrMultiRecordHandler Method - bool IsValidNewEditorID (pEditorID);
 *
 * Returns true if the given editorid is valid and not currently in use.
 *
 *=========================================================================*/
bool CSrMultiRecordHandler::IsValidNewEditorID (const char* pEditorID) {
  CSrIdRecord* pRecord;

	/* Ensure a non-empty string */
  if (pEditorID == NULL || *pEditorID == NULL_CHAR) {
    return AddSrGeneralError("Null or empty editorids are not allowed!");
  }

	/* Find an existing record */
  pRecord = FindEditorID(pEditorID);

  if (pRecord != NULL) {
    return AddSrGeneralError("The editorid '%s' is already in use (record 0x%08X, type %4.4s)!", pEditorID, pRecord->GetFormID(), pRecord->GetRecordType().Name);
  }
  
  return (true);
}
/*===========================================================================
 *		End of Class Method CSrMultiRecordHandler::IsValidNewEditorID()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CSrMultiRecordHandler Method - bool CreateIDRecordCopy (pRecord, pEditorID);
 *
 * Creates a new copy of the given record. Assumes the input editorid is
 * valid.
 *
 *=========================================================================*/
bool CSrMultiRecordHandler::CreateIDRecordCopy (CSrIdRecord* pRecord, const char* pEditorID) {
  CSrRecord*	pNewRecord;
  CSrIdRecord*	pNewIdRecord;
  bool			Result;

	/* Ensure valid input */
  if (pRecord == NULL || pEditorID == NULL) return (false);

	/* Create the new record */
  pNewRecord = CreateSrRecord(pRecord->GetRecordType());
  if (pNewRecord == NULL) return (false);
  pNewIdRecord = SrCastClass(CSrIdRecord, pNewRecord);

  	/* Create the copy */
  pNewRecord->Copy(pRecord);
  
	/* Move the record into the active file and record tree */
  Result = MoveNewRecord(pNewRecord);
  if (!Result) return (false);

	/* Update the new record IDs */
  pNewRecord->SetFormID(GetActiveFreeFormID());

  if (pNewIdRecord != NULL) {
    pNewIdRecord->SetEditorID(pEditorID);
  }

  IndexRecord(pNewRecord);

  CreateUndoAdd(pNewRecord, pEditorID);
  m_EventHandler.SendAddEvent(pNewRecord, NULL, 0);

  return (true);
}
/*===========================================================================
 *		End of Class Method CSrMultiRecordHandler::CreateIDRecordCopy()
 *=========================================================================*/




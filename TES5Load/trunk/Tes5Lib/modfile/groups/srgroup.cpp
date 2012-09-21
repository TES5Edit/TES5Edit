/*===========================================================================
 *
 * File:		Srgroup.CPP
 * Author:		Dave Humphrey (dave@uesp.net)
 * Created On:	26 November 2011
 *
 * Description
 *
 *=========================================================================*/

	/* Include Files */
#include "srgroup.h"
#include "../records/srrecord.h"
#include "../srrecordhandler.h"
#include "srtypegroup.h"


/*===========================================================================
 *
 * Class CSrGroup Constructor
 *
 *=========================================================================*/
CSrGroup::CSrGroup (const bool UseRef) 
{
  //SystemLog.Printf("pRecords = %p", m_pRecords);
  m_IsReferenced = UseRef;

  if (UseRef)
    m_pRecords = new CSrRefBaseRecordCont;
  else
    m_pRecords = new CSrBaseRecordCont;

  if (m_pRecords == NULL) throw "Invalid Record Array";

  memset(&m_Header, 0, sizeof(m_Header));
  m_Header.RecordType = SR_NAME_GRUP;
}
/*===========================================================================
 *		End of Class CSrGroup Constructor
 *=========================================================================*/


/*===========================================================================
 *
 * Class CSrGroup Destructor
 *
 *=========================================================================*/
CSrGroup::~CSrGroup () 
{

  if (m_pRecords != NULL) {
    m_pRecords->Destroy();
    delete m_pRecords;
    m_pRecords = NULL;
  }

}
/*===========================================================================
 *		End of Class CSrGroup Destructor
 *=========================================================================*/


/*===========================================================================
 *
 * Class CSrGroup Method - void Destroy (void);
 *
 * Delete object contents.
 *
 *=========================================================================*/
void CSrGroup::Destroy (void) {

  memset(&m_Header, 0, sizeof(m_Header));
  m_pRecords->Destroy();

}
/*===========================================================================
 *		End of Class Method CSrGroup::Destroy()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CSrGroup Method - bool AddExistingRecord (pNewRecord);
 *
 * Adds a record to the group that may already exist in the group. If it
 * does already exist the existing record is updated and the previous record
 * deleted if required. If not, a new record is added to the end of the group.
 *
 *=========================================================================*/
bool CSrGroup::AddExistingRecord (CSrRecord* pNewRecord) {
  CSrBaseRecord* pBaseRecord;
  CSrRecord*     pRecord;
  dword          Index;

	/* Ignore invalid input */
  if (pNewRecord == NULL) return (false);

	/* Look for a matching existing record in the group by formid */
  for (Index = 0; Index < m_pRecords->GetSize(); ++Index) {
    pBaseRecord = m_pRecords->GetAt(Index);
    pRecord     = SrCastRecord(pBaseRecord);
    if (pRecord == NULL) continue;

    if (pRecord->GetFormID() == pNewRecord->GetFormID()) {

		/* Delete the existing record if needed */
      if (!m_IsReferenced) {
        delete pRecord;
      }

      m_pRecords->SetAt(Index, pNewRecord);
      return (true);
    }
  }

	/* Add a new record */
  m_pRecords->Add(pNewRecord);
  return (true);
}
/*===========================================================================
 *		End of Class Method CSrGroup::AddExistingRecord()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CSrGroup Method - dword ChangeFormID (NewID, OldID);
 *
 *=========================================================================*/
dword CSrGroup::ChangeFormID (const srformid_t NewID, const srformid_t OldID) {
  CSrBaseRecord* pBaseRecord;
  dword          Index;
  dword          Count = 0;

  for (Index = 0; Index < m_pRecords->GetSize(); ++Index) {
    pBaseRecord = m_pRecords->GetAt(Index);
    Count += pBaseRecord->ChangeFormID(NewID, OldID);
  }

  return (Count);
}
/*===========================================================================
 *		End of Class Method CSrGroup::ChangeFormID()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CSrGroup Method - dword ChangeEditorID (pNewID, pOldID);
 *
 *=========================================================================*/
dword CSrGroup::ChangeEditorID (const SSCHAR* pNewID, const SSCHAR* pOldID) {
  CSrBaseRecord* pBaseRecord;
  dword          Index;
  dword          Count = 0;

  for (Index = 0; Index < m_pRecords->GetSize(); ++Index) {
    pBaseRecord = m_pRecords->GetAt(Index);
    Count += pBaseRecord->ChangeEditorID(pNewID, pOldID);
  }

  return (Count);
}
/*===========================================================================
 *		End of Class Method CSrGroup::ChangeEditorID()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CSrGroup Method - bool Compare (pGroup);
 *
 *=========================================================================*/
bool CSrGroup::Compare (CSrGroup* pGroup) {

  if (pGroup == NULL) return (false);
  if (m_Header.GroupType != pGroup->GetType()) return (false);

	/* Just compare the raw 4 bytes of data */
  if (m_Header.Data.ParentFormID != pGroup->GetHeader().Data.ParentFormID) return (false);

  return (true);
}
/*===========================================================================
 *		End of Class Method CSrGroup::Compare()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CSrGroup Method - CSrGroup* CreateSubGroup (pMatchGroup);
 *
 * Creates and returns a new subgroup that matches the input group.
 *
 *=========================================================================*/
CSrGroup* CSrGroup::CreateSubGroup (CSrGroup* pMatchGroup) {
  CSrGroup* pGroup;

	/* Ignore invalid input */
  if (pMatchGroup == NULL) return (NULL);

	/* Create a new subgroup */
  if (m_IsReferenced)
    pGroup = CreateSrRefGroup(pMatchGroup->GetType());
  else
    pGroup = CreateSrGroup(pMatchGroup->GetType());

  m_pRecords->Add(pGroup);

	/* Copy the group type specific header data */
  pGroup->GetHeader().Data.ParentFormID = pMatchGroup->GetHeader().Data.ParentFormID;

  return (pGroup);
}
/*===========================================================================
 *		End of Class Method CSrGroup::CreateSubGroup()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CSrGroup Method - dword Search (FindCount, FindData, pCallback);
 *
 *=========================================================================*/
bool CSrGroup::Search (dword& FindCount, srfinddata_t& FindData, CSrCallback* pCallback) {
  CSrBaseRecord* pBaseRecord;
  CSrRecord*     pRecord;
  dword		 Count;
  dword		 Index;
  bool		 IsExcluded;
  bool		 Result;
  int		 iResult;

  FindCount = 0;
  ++FindData.GroupCount;

	/* Look in the group header if required */
  if ((FindData.Flags & SR_FIND_GROUPHEADER) != 0) {
    Count      = SrFindData((const byte *) &m_Header, sizeof(m_Header), FindData);
    if (Count && (FindData.Flags & SR_FIND_OUTPUTLOG) != 0) SystemLog.Printf("\tFound match in group header!");
    FindCount += Count;
  }
  
  for (Index = 0; Index < m_pRecords->GetSize(); ++Index) {
    pBaseRecord = m_pRecords->GetAt(Index);
    pRecord     = SrCastClass(CSrRecord, pBaseRecord);

    if (pRecord) IsExcluded = SrContainsRecordType(pRecord->GetRecordType(), FindData.pExcludeRecords);

    if (pRecord == NULL || !IsExcluded) {
       Result = pBaseRecord->Search(Count, FindData, pCallback);
       FindCount += Count;
       if (!Result) return (false);
    }

    if (pCallback != NULL) {
      iResult = pCallback->UpdateCallback(pCallback->GetProcessRecords() + 1);
      if (iResult < 0) return (false);
    }
  }

  return (true);
 }
/*===========================================================================
 *		End of Class Method CSrGroup::Search()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CSrGroup Method - bool SearchText (FindCount, FindData, pCallback);
 *
 *=========================================================================*/
bool CSrGroup::SearchText (dword& FindCount, srfinddata_t& FindData, CSrCallback* pCallback) {
  CSrBaseRecord* pBaseRecord;
  CSrRecord*     pRecord;
  dword		 Count;
  dword		 Index;
  bool		 IsExcluded;
  bool		 Result;
  int		 iResult;

  FindCount = 0;
  ++FindData.GroupCount;

	/* Look in the group header if required */
  if ((FindData.Flags & SR_FIND_GROUPHEADER) != 0) {
    Count      = SrFindTextData((const byte *) &m_Header, sizeof(m_Header), FindData);
    if (Count && (FindData.Flags & SR_FIND_OUTPUTLOG) != 0) SystemLog.Printf("\tFound match in group header!");
    FindCount += Count;
  }
  
  for (Index = 0; Index < m_pRecords->GetSize(); ++Index) {
    pBaseRecord = m_pRecords->GetAt(Index);
    pRecord     = SrCastClass(CSrRecord, pBaseRecord);

    if (pRecord) IsExcluded = SrContainsRecordType(pRecord->GetRecordType(), FindData.pExcludeRecords);

    if (pRecord == NULL || !IsExcluded) {
       Result = pBaseRecord->SearchText(Count, FindData, pCallback);
       FindCount += Count;
       if (!Result) return (false);
    }

    if (pCallback != NULL) {
      iResult = pCallback->UpdateCallback(pCallback->GetProcessRecords() + 1);
      if (iResult < 0) return (false);
    }
  }

  return (true);
 }
/*===========================================================================
 *		End of Class Method CSrGroup::SearchText()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CSrGroup Method - CSrBaseRecord* FindFormID (FormID);
 *
 * Find a child record based on its form ID. Returns NULL if not found.
 *
 *=========================================================================*/
CSrBaseRecord* CSrGroup::FindFormID (const srformid_t FormID) {
  CSrBaseRecord* pRecord;
  dword		 Index;

	/* Ignore invalid input */
  if (FormID == SR_FORMID_NULL) return (NULL);

  for (Index = 0; Index < m_pRecords->GetSize(); ++Index) {
    //SystemLog.Printf("      Record: %d = 0x%08lX (0x%08lX)", Index, m_Records[Index]->GetFormID(), FormID);

    pRecord = m_pRecords->GetAt(Index)->FindFormID(FormID);
    if (pRecord != NULL) return (pRecord);
   }

  return (NULL);
 }
/*===========================================================================
 *		End of Class Method CSrGroup::FindFormID()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CSrGroup Method - CSrGroup* FindNextGroup (FormID, GroupPos);
 *
 *=========================================================================*/
CSrGroup* CSrGroup::FindNextGroup (const srformid_t FormID, int& GroupPos) {
  CSrGroup* pGroup;

  for (++GroupPos; GroupPos < (int) m_pRecords->GetSize(); ++GroupPos) {
    pGroup = SrCastClass(CSrGroup, m_pRecords->GetAt(GroupPos));
    if (pGroup == NULL) continue;

    switch (pGroup->GetType()) {
	case SR_GROUP_WORLDCHILD:
	case SR_GROUP_CELLCHILD:
	case SR_GROUP_TOPICCHILD:
	case SR_GROUP_CELLPERSIST:
	case SR_GROUP_CELLTEMP:
	case SR_GROUP_CELLDISTANT:
		if (FormID == SR_FORMID_NULL) return (pGroup);
		if (pGroup->GetHeader().Data.ParentFormID == FormID) return (pGroup);
		break;
    }
  }

  return (NULL);
}
/*===========================================================================
 *		End of Class Method CSrGroup::FindNextGroup()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CSrGroup Method - CSrGroup* FindSubGroup (pMatchGroup);
 *
 * Find a subgroup in the current group that matches the given input. 
 * Returns NULL if not found.
 *
 *=========================================================================*/
CSrGroup* CSrGroup::FindSubGroup (CSrGroup* pMatchGroup) {
  CSrBaseRecord* pBaseRecord;
  CSrGroup*      pGroup;
  dword          Index;

  	/* Ignore invalid input */
  if (pMatchGroup == NULL) return (NULL);

	/* Check all existing subgroups */
  for (Index = 0; Index < m_pRecords->GetSize(); ++Index) {
    pBaseRecord = m_pRecords->GetAt(Index);
    pGroup      = SrCastGroup(pBaseRecord);
    if (pGroup == NULL) continue;

    if (pGroup->Compare(pMatchGroup)) return (pGroup);
  }

	/* No match found */
  return (NULL);
}
/*===========================================================================
 *		End of Class Method CSrGroup::FindSubGroup()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CSrGroup Method - bool FixupFormids (FixupArray);
 *
 *=========================================================================*/
bool CSrGroup::FixupFormids (CSrFormidFixupArray& FixupArray) {
  dword Index;
  bool  Result = true;

  for (Index = 0; Index < m_pRecords->GetSize(); ++Index) {
    Result &= m_pRecords->GetAt(Index)->FixupFormids(FixupArray);
  }
  
  return (Result);
}
/*===========================================================================
 *		End of Class Method CSrGroup::FixupFormids()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CSrGroup Method - int ForEachBaseRecord (Callback, UserData, pUserPtr);
 *
 * Iterates through all base records in the file and calls the given 
 * callback function for each one. 
 *
 *=========================================================================*/
int CSrGroup::ForEachBaseRecord (SRBASERECORDCALLBACK Callback, const dword UserData, void* pUserPtr) {
  CSrBaseRecord* pBaseRecord;
  CSrGroup*		 pGroup;
  dword          Index;
  int            Result;

	/* Ensure valid input */
  if (Callback == NULL) return (0);

  for (Index = 0; Index < m_pRecords->GetSize(); ++Index) {
    pBaseRecord = m_pRecords->GetAt(Index);

    Result = Callback(pBaseRecord, UserData, pUserPtr);
    if (Result < 0) return (Result);

		/* Call each record in the group record */
    pGroup = SrCastClass(CSrGroup, pBaseRecord);

    if (pGroup != NULL) {
      Result = pGroup->ForEachBaseRecord(Callback, UserData, pUserPtr);
      if (Result < 0) return (Result);
    }
  }  

  return (0);
}
/*===========================================================================
 *		End of Class Method CSrGroup::ForEachBaseRecord()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CSrGroup Method - int ForEachRecord (Callback, UserData, pUserPtr);
 *
 * Iterates through all records in the file and calls the given 
 * callback function for each one. 
 *
 *=========================================================================*/
int CSrGroup::ForEachRecord (SRRECORDCALLBACK Callback, const dword UserData, void* pUserPtr) {
  CSrBaseRecord* pBaseRecord;
  CSrRecord*     pRecord;
  CSrGroup*		 pGroup;
  dword          Index;
  int            Result;

	/* Ensure valid input */
  if (Callback == NULL) return (0);

  for (Index = 0; Index < m_pRecords->GetSize(); ++Index) {
    pBaseRecord = m_pRecords->GetAt(Index);
    pRecord     = SrCastClass(CSrRecord, pBaseRecord);

    if (pRecord != NULL) {
      Result = Callback(pRecord, UserData, pUserPtr);
      if (Result < 0) return (Result);
    }
    else {

		/* Call each record in the group record */
      pGroup = SrCastClass(CSrGroup, pBaseRecord);

      if (pGroup != NULL) {
        Result = pGroup->ForEachRecord(Callback, UserData, pUserPtr);
        if (Result < 0) return (Result);
      }
    }

  }  

  return (0);
}
/*===========================================================================
 *		End of Class Method CSrGroup::ForEachRecord()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CSrGroup Method - CSrTypeGroup* GetTypeGroup (Type);
 *
 *=========================================================================*/
CSrTypeGroup* CSrGroup::GetTypeGroup (const srrectype_t Type) {
  CSrBaseRecord* pRecord;
  CSrGroup*		pGroup;
  CSrTypeGroup*	 pTypeGroup;
  dword		 Index;

	/* Search all top level groups for a match */
  for (Index = 0; Index < m_pRecords->GetSize(); ++Index) {
    pRecord = m_pRecords->GetAt(Index);

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
 *		End of Class Method CSrGroup::GetTypeGroup()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CSrGroup Method - void LoadLocalStrings (pCallback);
 *
 *=========================================================================*/
void CSrGroup::LoadLocalStrings (CSrCallback* pCallback)
{
	static int s_Level = 0;
	CSrBaseRecord* pBaseRecord;

	++s_Level;

	if (pCallback && s_Level == 1)
	{
		pCallback->SetLabel("Setting Local Strings...");
		pCallback->SetTotalRecords(m_pRecords->GetSize());
		pCallback->UpdateCallback(0);
	}

	for (dword i = 0; i < m_pRecords->GetSize(); ++i) 
	{
		pBaseRecord = m_pRecords->GetAt(i);
		pBaseRecord->LoadLocalStrings(pCallback);
		if (pCallback && s_Level == 1) pCallback->ForceCallback(i);
	}

	--s_Level;
}
/*===========================================================================
 *		End of Class Method CSrGroup::LoadLocalStrings()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CSrGroup Method - bool ReadData (File, pCallback);
 *
 * Reads in group data from the current location in the given file. Returns
 * false on any error.
 *
 *=========================================================================*/
bool CSrGroup::ReadData (CSrFile& File, CSrCallback* pCallback) {
  srbaseheader_t    Header;
  CSrBaseRecord*    pBaseRecord;
  bool		    Result;
  int		    CurrentOffset;
  int		    EndOffset;
  int		    iResult;

	/* Get the start of the data */
  Result = File.Tell(CurrentOffset);
  if (!Result) return (false);
  EndOffset = CurrentOffset + m_Header.Size - SR_BASEHEADER_SIZE;

	/* Read until the end of the data is reached */
  while (CurrentOffset < EndOffset) {
  
		/* Input the record header */
    Result = ReadSrBaseHeader(File, Header);
    if (!Result) return (false); 

    //SystemLog.Printf ("0x%08lX: Group %4.4s (%d bytes left)", CurrentOffset, Header.Type.Name, EndOffset - CurrentOffset);

		/* Create record/group based on input header */
    pBaseRecord = CreateSrRecordGroup(Header);
    assert(pBaseRecord != NULL);
    m_pRecords->Add(pBaseRecord);
    pBaseRecord->SetParent(m_pParent);
    pBaseRecord->SetParentGroup(this);

    if ((m_CacheFlags & SR_CACHE_DEFERLOAD) != 0 && (Header.Type == SR_NAME_LAND || Header.Type == SR_NAME_NAVM)) {
      pBaseRecord->SetCacheFlags(m_CacheFlags);

      Result = File.SeekCur(Header.Size);
      if (!Result) return (false);
    }//|| Header.Type == SR_NAME_PGRD || Header.Type == SR_NAME_REFR
    else if ((m_CacheFlags & SR_CACHE_DEFERLOAD) != 0 && Header.Type == SR_NAME_GRUP) {
      pBaseRecord->SetCacheFlags(m_CacheFlags);

      Result = pBaseRecord->ReadData(File, pCallback);
      if (!Result) return (false);
    }
    else {
      Result = pBaseRecord->ReadData(File, pCallback);
      if (!Result) return (false);
    }

    Result = File.Tell(CurrentOffset);
    if (!Result) return (false);

    if (pCallback != NULL) {
      iResult = pCallback->UpdateCallback(CurrentOffset);
      if (iResult < 0) return (false);
    }

  }

  return (true);
}
/*===========================================================================
 *		End of Class Method CSrGroup::ReadData()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CSrGroup Method - bool Write (File, pCallback);
 *
 * Writes group data to the current location in the given file. Returns
 * false on any error.
 *
 *=========================================================================*/
bool CSrGroup::Write (CSrFile& File, CSrCallback* pCallback) {
  CSrBaseRecord* pRecord;
  dword		 Index;
  bool		 Result;
  int		 StartOffset;
  int		 iResult;

  if (pCallback != NULL) {
    pCallback->SetTotalRecords1(m_pRecords->GetSize());
  } 

	/* Save the start position of the group */
  Result = File.Tell(StartOffset);
  if (!Result) return (false); 

	/* Output the group header (group size may be incorrect) */
  Result = File.Write(&m_Header, SR_BASEHEADER_SIZE);
  if (!Result) return (false); 

	/* Output all group content */
  for (Index = 0; Index < m_pRecords->GetSize(); ++Index) {
    pRecord = m_pRecords->GetAt(Index);
    assert(pRecord != NULL);
    
    Result = pRecord->Write(File);
    if (!Result) return (false); 

    if (pCallback != NULL) {
      iResult = pCallback->UpdateCallback1(Index);
      if (iResult < 0) return (false);
    }
  }

	/* Update the gorup size */
  return WriteGroupSize(File, StartOffset);
}
/*===========================================================================
 *		End of Class Method CSrGroup::Write()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CSrGroup Method - bool WriteGroupSize (File, Offset);
 *
 * Protected class method that updates the size of the group being output
 * assuming that the current location in the file is at the end of the
 * group. Returns false on any error. The input offset marks the start of
 * the group in the file 
 *
 *=========================================================================*/
bool CSrGroup::WriteGroupSize (CSrFile& File, const dword Offset) {
  bool  Result;
  int   CurrentOffset;
  dword GroupSize;

	/* Save the current file position */
  Result = File.Tell(CurrentOffset);
  if (!Result) return (false);

	/* Compute size of group data */
  assert(CurrentOffset >= (int)Offset);
  GroupSize = CurrentOffset - Offset;

	/* Move to the group size position */
  Result = File.Seek(Offset + 4);
  if (!Result) return (false);

	/* Output the new group size */
  Result = File.WriteDWord(GroupSize);
  if (!Result) return (false);

	/* Return to end of output file */
  Result = File.Seek(CurrentOffset);
  return (Result);
 }
/*===========================================================================
 *		End of Class Method CSrGroup::WriteRecordSize()
 *=========================================================================*/


void CSrGroup::UpdateLoadLocalString (const bool LoadLocal)
{
	if (m_pRecords == NULL) return;

	for (dword i = 0; i < m_pRecords->GetSize(); ++i)
	{
		CSrBaseRecord* pBaseRecord = m_pRecords->GetAt(i);

		if (pBaseRecord->IsGroup())
		{
			CSrGroup* pGroup = SrCastClass(CSrGroup, pBaseRecord);
			if (pGroup) pGroup->UpdateLoadLocalString(LoadLocal);
		}
		else
		{
			CSrRecord* pRecord = SrCastClass(CSrRecord, pBaseRecord);
			if (pRecord) pRecord->UpdateLoadLocalString(LoadLocal);
		}
	}

}
/*===========================================================================
 *
 * File:	Obbaserecord.CPP
 * Author:	Dave Humphrey (dave@uesp.net)
 * Created On:	April 6, 2006
 *
 * Description
 *
 *=========================================================================*/

	/* Include Files */
#include "ctype.h"
#include "srrecord.h"
#include "../../common/zlib/zlib.h"
#include "../subrecords/srformidsubrecord.h"
#include "../subrecords/srlstringsubrecord.h"
#include "../subrecords/srgmstdatasubrecord.h"
#include "../subrecords/srepfdsubrecord.h"
#include "../subrecords/srarraysubrecord.h"
#include "../srrecordhandler.h"


/*===========================================================================
 *
 * Begin Local Definitions
 *
 *=========================================================================*/

	/* Static buffers used when loading and saving */
  CSrMemFile	CSrRecord::s_MemFile;
  byte*			CSrRecord::s_pTempBuffer    = NULL;
  dword			CSrRecord::s_TempBufferSize = 0;

  #define SRRECORD_DEBUG_OUTPUT 0

  DEFINE_SRALLOCATOR(CSrRecord)

/*===========================================================================
 *		End of Local Definitions
 *=========================================================================*/


/*===========================================================================
 *
 * Begin Subrecord Creation Array
 *
 *=========================================================================*/
const srsubreccreate_t   CSrRecord::s_SubrecCreate = {
	NULL, CSrRecord::s_SubrecEntries
 };

const srsubrecentries_t  CSrRecord::s_SubrecEntries[] = {
	{ NULL,		 NULL }	/* Must be last record */
 };
/*===========================================================================
 *		End of Subrecord Creation Array
 *=========================================================================*/


/*===========================================================================
 *
 * Begin CSrRecord Field Map
 *
 *=========================================================================*/
BEGIN_SRFIELDBASEMAP(CSrRecord)
	ADD_SRFIELDALL("FormID",      SR_FIELD_FORMID,		  0, CSrRecord, FieldFormID)
	ADD_SRFIELDALL("RecordType",  SR_FIELD_RECORDTYPE,	  0, CSrRecord, FieldName)
	ADD_SRFIELDALL("Flags",       SR_FIELD_FLAGS,		  0, CSrRecord, FieldRecordFlags)
	ADD_SRFIELDALL("Quest",	      SR_FIELD_QUESTITEM,	  0, CSrRecord, FieldQuestItem)
	ADD_SRFIELDALL("Dangerous",   SR_FIELD_DANGEROUS,	  0, CSrRecord, FieldDangerous)
	ADD_SRFIELDALL("Ignored",     SR_FIELD_IGNORED,		  0, CSrRecord, FieldIgnored)
	ADD_SRFIELDALL("Deleted",     SR_FIELD_DELETED,		  0, CSrRecord, FieldDeleted)
END_SRFIELDMAP()
/*===========================================================================
 *		End of CSrRecord Field Map
 *=========================================================================*/


/*===========================================================================
 *
 * Class CSrRecord Constructor
 *
 *=========================================================================*/
CSrRecord::CSrRecord () 
{
  memset(&m_Header, 0, sizeof(m_Header));
  m_UserData   = 0;
}
/*===========================================================================
 *		End of Class CSrRecord Constructor
 *=========================================================================*/


/*===========================================================================
 *
 * Class CSrRecord Destructor
 *
 *=========================================================================*/
CSrRecord::~CSrRecord () 
{
} 
/*===========================================================================
 *		End of Class CSrRecord Destructor
 *=========================================================================*/


/*===========================================================================
 *
 * Class CSrRecord Method - void Destroy (void);
 *
 * Clear content data.
 *
 *=========================================================================*/
void CSrRecord::Destroy (void) 
{
  
  m_Subrecords.Destroy();
  
  m_Header.Flags1 = 0;
  m_Header.Flags2 = 0;
  m_Header.FormID = 0;
  m_Header.Size   = 0;

  CSrBaseRecord::Destroy();
}
/*===========================================================================
 *		End of Class Method CSrRecord::Destroy()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CEsmRecord Method - CSrRecord* AddNewSubrecord (Type);
 *
 * Allocates and adds a subrecord based on the input name. Creates a 
 * default CSrSubrecord object if the type is not known.
 *
 *=========================================================================*/
CSrSubrecord* CSrRecord::AddNewSubrecord (const srrectype_t Type) 
{
  srsubrecheader_t Header;
  
  Header.Type = Type;
  Header.Size = 0;

  return AddNewSubrecord(Header);
}
/*===========================================================================
 *		End of Class Method CSrRecord::AddNewSubrecord()
 *=========================================================================*/


CSrSubrecord* CSrRecord::AddInitNewSubrecord (const srrectype_t Type)
{
	CSrSubrecord* pSubrecord = AddNewSubrecord(Type);
	if (pSubrecord != NULL) pSubrecord->InitializeNew();
	return pSubrecord;
}


/*===========================================================================
 *
 * Class CEsmRecord Method - CSrRecord* AddNewSubrecord (Header);
 *
 * Allocates and adds a subrecord based on the input header. Creates a 
 * default CSrSubrecord object if the type is not known.
 *
 *=========================================================================*/
CSrSubrecord* CSrRecord::AddNewSubrecord (const srsubrecheader_t Header) 
{
	CSrSubrecord* pSubrecord;
	
		/* Allocate the correct type of subrecord */
	pSubrecord = CreateSubrecord(Header);
	  
		/* Add the subrecord to the record's collection */
	m_Subrecords.Add(pSubrecord);

		/* Propagate the local string setting */
	pSubrecord->SetLoadLocalString(m_pParent ? m_pParent->IsLoadLocalString() : false);
	
		/* Call the record add event */
	OnAddSubrecord(pSubrecord);
	
	return (pSubrecord);
}
/*===========================================================================
 *		End of Class Method CSrRecord::AddNewSubrecord()
 *=========================================================================*/


CSrSubrecord* CSrRecord::AddNewSubrecordAfter (const srsubrecheader_t Header, const srrectype_t AddAfter)
{
	CSrSubrecord* pSubrecord;
	int           Position = -1;

	pSubrecord = CreateSubrecord(Header);
	
	for (dword i = 0; i < m_Subrecords.GetSize(); ++i)
	{
		if (m_Subrecords[i]->GetRecordType() == AddAfter)
		{
			Position = i;
			break;
		}
	}	

	if (Position < 0)
		m_Subrecords.Add(pSubrecord);
	else
		m_Subrecords.InsertAfter(Position, pSubrecord);

	pSubrecord->SetLoadLocalString(m_pParent ? m_pParent->IsLoadLocalString() : false);
	OnAddSubrecord(pSubrecord);
	
	return (pSubrecord);
}


CSrSubrecord* CSrRecord::AddNewSubrecordAfter (const srrectype_t Type, const srrectype_t AddAfter)
{
	srsubrecheader_t Header;
  
	Header.Type = Type;
	Header.Size = 0;

	return AddNewSubrecordAfter(Header, AddAfter);
}


CSrSubrecord* CSrRecord::AddInitNewSubrecordAfter (const srrectype_t Type, const srrectype_t AddAfter)
{
	CSrSubrecord* pSubrecord = AddNewSubrecordAfter(Type, AddAfter);
	if (pSubrecord != NULL) pSubrecord->InitializeNew();
	return pSubrecord;
}


/*===========================================================================
 *
 * Class CSrRecord Method - dword ChangeFormidSubrecords (Type, NewID, OldID);
 *
 * Changes any occurence of the old formid for the new formid in all
 * formid subrecords of the given type.
 *
 *=========================================================================*/
dword CSrRecord::ChangeFormidSubrecords (const srrectype_t Type, const srformid_t NewID, const srformid_t OldID) 
{
  CSrSubrecord*			pSubrecord;
  CSrFormidSubrecord*	pFormid;
  dword					Count = 0;
  dword					Index;

  for (Index = 0; Index < m_Subrecords.GetSize(); ++Index) {
    pSubrecord = m_Subrecords.GetAt(Index);
    if (pSubrecord->GetRecordType() != Type) continue;

    pFormid = SrCastClass(CSrFormidSubrecord, pSubrecord);
    if (pFormid == NULL) continue;

    if (pFormid->GetValue() == NewID) {
      ++Count;
      pFormid->SetValue(NewID);
      pFormid->SetOrigValue(NewID);
    }
  }

  return (Count);
}
/*===========================================================================
 *		End of Class Method CSrRecord::ChangeFormidSubrecords()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CSrRecord Method - dword ChangeFormidSubrecords (Type, NewID, OldID);
 *
 * Changes any occurence of the old formid for the new formid in all
 * subrecords.
 *
 *=========================================================================*/
dword CSrRecord::ChangeFormidSubrecords (const srformid_t NewID, const srformid_t OldID) {
  dword	Count = 0;
  dword	Index;

  for (Index = 0; Index < m_Subrecords.GetSize(); ++Index) {
    Count += m_Subrecords.GetAt(Index)->ChangeFormID(NewID, OldID);
  }

  return (Count);
}
/*===========================================================================
 *		End of Class Method CSrRecord::ChangeFormidSubrecords()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CSrRecord Method - dword ChangeFormid (NewID, OldID);
 *
 * Changes any occurence of the given Old formid in the record to the
 * new formid.
 *
 *=========================================================================*/
dword CSrRecord::ChangeFormID (const srformid_t NewID, const srformid_t OldID) {
  dword Count = 0;

  if (m_Header.FormID == OldID) {
    m_Header.FormID = NewID;
    Count = 1;
  }

  return Count + ChangeFormidSubrecords(NewID, OldID);
}
/*===========================================================================
 *		End of Class Method CSrRecord::ChangeFormID()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CSrRecord Method - dword ChangeEditorID (pNewID, pOldID);
 *
 * Changes any occurence of the given Old editorid in the record to the
 * new editorid.
 *
 *=========================================================================*/
dword CSrRecord::ChangeEditorID (const SSCHAR* pNewID, const SSCHAR* pOldID) {
  return (0);
}
/*===========================================================================
 *		End of Class Method CSrRecord::ChangeEditorID()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CSrRecord Method - bool Copy (pRecord);
 *
 * Copy the contents of the given record.
 *
 *=========================================================================*/
bool CSrRecord::Copy (CSrRecord* pRecord) 
{
  CSrSubrecord* pSubrecord;
  CSrSubrecord* pNewSubrecord;
  dword         Index;

	/* Clear the current record contents */
  Destroy();

	/* Ignore invalid input */
  if (pRecord == NULL) return (false);

  m_pParent      = pRecord->GetParent();
  m_pParentGroup = pRecord->GetParentGroup();
  m_UserData     = pRecord->GetUserData();

	/* Copy the record header, except for the record type and size */
  m_Header.Flags1  = pRecord->GetHeader().Flags1;
  m_Header.Flags2  = pRecord->GetHeader().Flags2;
  m_Header.FormID  = pRecord->GetHeader().FormID;
  m_Header.Unknown = pRecord->GetHeader().Unknown;
  m_Header.Version = pRecord->GetHeader().Version;

	/* Copy all subrecords */
  for (Index = 0; Index < pRecord->GetNumSubrecords(); ++Index) 
  {
    pSubrecord = pRecord->GetSubrecord(Index);

	pNewSubrecord = pSubrecord->CreateCopy();
	m_Subrecords.Add(pNewSubrecord);
	OnAddSubrecord(pNewSubrecord);

	//pNewSubrecord = AddNewSubrecord(pSubrecord->GetRecordType());
	//if (pNewSubrecord == NULL) continue;
	//pNewSubrecord->Copy(pSubrecord);
  }

  return (true);
}
/*===========================================================================
 *		End of Class Method CSrRecord::Copy()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CSrRecord Method - int CompareFields (FieldID, pRecord);
 *
 * Attempts to compare the given field values of the current and the given
 * record. Returns 0 on any error.
 *
 *=========================================================================*/
int CSrRecord::CompareFields (const srrecfieldid_t FieldID, CSrRecord* pRecord) {
  const srrecfield_t* pField;

  if (pRecord == NULL) return (0);

  pField = FindField(FieldID);
  if (pField == NULL || pField->CompareMethod == NULL) return (0);

  return (this->*pField->CompareMethod)(pRecord, 0);
 }
/*===========================================================================
 *		End of Class Method CSrRecord::GetField()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CSrRecord Method - int CountSubrecords (Type);
 *
 *=========================================================================*/
int CSrRecord::CountSubrecords (const srrectype_t Type)
{
	int Count = 0;

	for (dword i = 0; i < m_Subrecords.GetSize(); ++i)
	{
		if (m_Subrecords[i]->GetRecordType() == Type) ++Count;
	}

	return Count;
}
/*===========================================================================
 *		End of Class Method CSrRecord::CountSubrecords()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CSrRecord Method - dword CountUses (FormID);
 *
 *=========================================================================*/
dword CSrRecord::CountUses (const srformid_t FormID) {
  CSrSubrecord* pSubrecord;
  dword         Count = 0;
  dword         Index;

	/* Ignore if this record is the given form (??) */
  if (GetFormID() == FormID) return (0);

  for (Index = 0; Index < m_Subrecords.GetSize(); ++Index) {
    pSubrecord = m_Subrecords.GetAt(Index);
    Count += pSubrecord->CountUses(FormID);
  }

  return (Count);
}
/*===========================================================================
 *		End of Class Method CSrRecord::CountUses()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CSrRecord Method - CSrSubrecord* CreateSubrecord (Header);
 *
 * Allocates and returns a new child subrecord of the given Header. The
 * subrecord is not added to the record.
 *
 *=========================================================================*/
CSrSubrecord* CSrRecord::CreateSubrecord (const srsubrecheader_t Header) {
  CSrSubrecord*	pSubrecord;
  
	/* Create and initialize the new record */
  pSubrecord = FindSubrecCreate(Header.Type)();
  pSubrecord->Initialize(Header);

  return (pSubrecord);
 }
/*===========================================================================
 *		End of Class Method CSrRecord::CreateSubrecord()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CSrRecord Method - CSrSubrecord* CreateSubrecord (Type);
 *
 *=========================================================================*/
CSrSubrecord* CSrRecord::CreateSubrecord (const srrectype_t Type) {
  CSrSubrecord*	pSubrecord;
  
	/* Create and initialize the new record */
  pSubrecord = FindSubrecCreate(Type)();
  pSubrecord->Initialize(Type, 0);

  return (pSubrecord);
 }
/*===========================================================================
 *		End of Class Method CSrRecord::CreateSubrecord()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CSrRecord Method - int DeleteSubrecords (Type);
 *
 * Deletes all subrecords of the given type. Returns the number deleted.
 *
 *=========================================================================*/
int CSrRecord::DeleteSubrecords (const srrectype_t Type) {
  CSrSubrecord* pSubrecord;
  int		Count = 0;
  int		Index;

  for (Index = m_Subrecords.GetSize() - 1; Index >= 0; --Index) {
    pSubrecord = m_Subrecords[Index];

    if (pSubrecord->GetRecordType() == Type) {
      OnDeleteSubrecord(pSubrecord);
      m_Subrecords.Delete(Index);
      ++Count;
    }
  }

  return (Count);
}
/*===========================================================================
 *		End of Class Method CSrRecord::DeleteSubrecords()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CSrRecord Method - void DestroyIOBuffers (void);
 *
 * Static class method to delete the current temporary input/output buffers.
 *
 *=========================================================================*/
void CSrRecord::DestroyIOBuffers (void) {

	/* Ignore if not initialized */
  if (s_pTempBuffer != NULL) {
    delete[] s_pTempBuffer;
    s_pTempBuffer    = NULL;
    s_TempBufferSize = 0;
   }

  if (s_MemFile.IsOpen()) {
    s_MemFile.Close();
   }
 }
/*===========================================================================
 *		End of Class Method CSrRecord::DestroyIOBuffers()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CSrRecord Method - bool ExportCsv (CsvInfo);
 *
 * Exports the record to a single row in the given CSV information.
 * Returns false on any error.
 *
 *=========================================================================*/
bool CSrRecord::ExportCsv (srcsvinfo_t& CsvInfo) {
  srcsvcolinfo_t* pColInfo;
  CSString*       pString;
  CCsvRow*        pRow;
  dword           Index;

  pRow = CsvInfo.pCsvFile->AddRow();
  assert(pRow != NULL);

  for (Index = 0; Index < CsvInfo.ColInfos.GetSize(); ++Index) {
    pColInfo = CsvInfo.ColInfos[Index];

    pString = new CSString;
    pRow->Add(pString);

    if (!pColInfo->Process) continue;

    GetField(*pString, pColInfo->FieldID);
    pString->Escape();
  }

  return (true);
}
/*===========================================================================
 *		End of Class Method CSrRecord::ExportCsv()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CSrRecord Method - bool Search (FindCount, FindData, pCallback);
 *
 *=========================================================================*/
bool CSrRecord::Search (dword& FindCount, srfinddata_t& FindData, CSrCallback* pCallback) {
  dword Count;
  dword Index;

  FindCount = 0;
  ++FindData.RecordCount;

	/* Look in the record header */
  if ((FindData.Flags & SR_FIND_RECORDHEADER) != 0) {
    Count      = SrFindData((const byte*)&m_Header, sizeof(m_Header), FindData);
    FindCount += Count;

    if (Count > 0 && (FindData.Flags & SR_FIND_OUTPUTLOG) != 0) SystemLog.Printf("'%4.4s' -- 0x%08X: Found %u match(s) in record header", GetRecordType().Name, GetFormID(), Count); 
  }

	/* Look in all subrecords */
  for (Index = 0; Index < m_Subrecords.GetSize(); ++Index) {
    Count      = m_Subrecords[Index]->Search(FindData);
    FindCount += Count;

    if (Count > 0) {
      ++FindData.FoundSubrecords;
      if ((FindData.Flags & SR_FIND_OUTPUTLOG) != 0) SystemLog.Printf("'%4.4s' -- 0x%08X: Found %u match(s) in subrecord '%4.4s'",  GetRecordType().Name, GetFormID(), Count, m_Subrecords[Index]->GetRecordType().Name); 
      if ((FindData.Flags & SR_FIND_FINDALL) == 0) break;
    }
  }

  if (FindCount > 0) {
    if ((FindData.Flags & SR_FIND_ADDRECORDS) != 0 && FindData.pFindRecords != NULL) FindData.pFindRecords->Add(this);
    ++FindData.FoundRecords;
  }

  return (true);
}
/*===========================================================================
 *		End of Class Method CSrRecord::Search()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CSrRecord Method - bool SearchText (FindCount, FindData, pCallback);
 *
 *=========================================================================*/
bool CSrRecord::SearchText (dword& FindCount, srfinddata_t& FindData, CSrCallback* pCallback) {
  dword Count;
  dword Index;

  FindCount = 0;
  ++FindData.RecordCount;

	/* Look in the record header */
  if ((FindData.Flags & SR_FIND_RECORDHEADER) != 0) {
    Count      = SrFindTextData((const byte*)&m_Header, sizeof(m_Header), FindData);
    FindCount += Count;

    if (Count > 0 && (FindData.Flags & SR_FIND_OUTPUTLOG) != 0) SystemLog.Printf("'%4.4s' -- 0x%08X: Found %u match(s) in record header", GetRecordType().Name, GetFormID(), Count); 
  }

	/* Look in all subrecords */
  for (Index = 0; Index < m_Subrecords.GetSize(); ++Index) {
    Count      = m_Subrecords[Index]->SearchText(FindData);
    FindCount += Count;

    if (Count > 0) {
      ++FindData.FoundSubrecords;
      if ((FindData.Flags & SR_FIND_OUTPUTLOG) != 0) SystemLog.Printf("'%4.4s' -- 0x%08X: Found %u match(s) in subrecord '%4.4s'",  GetRecordType().Name, GetFormID(), Count, m_Subrecords[Index]->GetRecordType().Name); 
      if ((FindData.Flags & SR_FIND_FINDALL) == 0) break;
    }
  }

  if (FindCount > 0) {
    if ((FindData.Flags & SR_FIND_ADDRECORDS) != 0 && FindData.pFindRecords != NULL) FindData.pFindRecords->Add(this);
    ++FindData.FoundRecords;
  }

  return (true);
}
/*===========================================================================
 *		End of Class Method CSrRecord::SearchText()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CSrRecord Method - CSrSubrecord* FindNextSubrecord (Type, Position);
 *
 *=========================================================================*/
CSrSubrecord* CSrRecord::FindNextSubrecord  (const srrectype_t Type, int& Position) {
  CSrSubrecord* pSubrecord;
  dword         Index;

  ++Position;
  if (Position < 0) return (NULL);

  for (Index = (dword) Position; Index < m_Subrecords.GetSize(); ++Index) {
    pSubrecord = m_Subrecords[Index];
    if (pSubrecord->GetRecordType() == Type) return (pSubrecord);

    ++Position;
  }

  return (NULL);
}
/*===========================================================================
 *		End of Class Method CSrRecord::FindNextSubrecord()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CSrRecord Method - SRSUBREC_CREATEFUNC FindSubrecCreate (Type);
 *
 * Protected class method to find the creation method in this classes
 * or its base classes subrecord creation data. Returns the base class
 * CSrSubrecord method by default (does not return NULL). 
 *
 *=========================================================================*/
SRSUBREC_CREATEFUNC CSrRecord::FindSubrecCreate (const srrectype_t Type) {
  const srsubreccreate_t* pCreate;
  int			          Index;

	/* Loop through this class followed by all base classes */
  for (pCreate = GetSubrecCreate(); pCreate != NULL; pCreate = pCreate->pBaseCreate) {
    assert(pCreate != pCreate->pBaseCreate);

    for (Index = 0; pCreate->pEntries[Index].CreateMethod != NULL; ++Index) {
      if (*pCreate->pEntries[Index].pName == Type) return (pCreate->pEntries[Index].CreateMethod); 
     }
   }

	/* No match found, return default creation method */
  return (CSrDataSubrecord::Create);
 }
/*===========================================================================
 *		End of Class Method CSrRecord::FindSubrecCreate()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CSrRecord Method - CSrSubrecord* FindSubrecord (Type);
 *
 * Finds the fist subrecord matching the given type.
 *
 *=========================================================================*/
CSrSubrecord* CSrRecord::FindSubrecord (const srrectype_t Type) {
  CSrSubrecord* pSubrecord;
  dword		Index;

	/* Find the subrecord */
  for (Index = 0; Index < m_Subrecords.GetSize(); ++Index) {
    pSubrecord = m_Subrecords[Index];
    if (pSubrecord->GetRecordType() == Type) return (pSubrecord);
   }
  
	/* Not found */
  return (NULL);
 }
/*===========================================================================
 *		End of Class Method CSrRecord::FindSubrecord()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CSrRecord Method - bool FixupFormids (FixupArray);
 *
 *=========================================================================*/
inline bool CSrRecord::FixupFormids (CSrFormidFixupArray& FixupArray) {
  return SrFixupFormid(m_Header.FormID, m_Header.FormID, FixupArray) && FixupFormidSubrecords(FixupArray);
}
/*===========================================================================
 *		End of Class Method CSrRecord::FixupFormids()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CSrRecord Method - bool FixupFormidSubrecords (Type, FixupArray);
 *
 * Fixes the formid of all formid type subrecords of the given type
 * in the record.
 *
 *=========================================================================*/
bool CSrRecord::FixupFormidSubrecords (const srrectype_t Type, CSrFormidFixupArray& FixupArray) {
  CSrSubrecord*			pSubrecord;
  CSrFormidSubrecord*	pFormid;
  bool			Result = true;
  dword			Index;

  for (Index = 0; Index < m_Subrecords.GetSize(); ++Index) {
    pSubrecord = m_Subrecords.GetAt(Index);
    if (pSubrecord->GetRecordType() != Type) continue;

    pFormid = SrCastClass(CSrFormidSubrecord, pSubrecord);
    if (pFormid == NULL) continue;

    Result &= SrFixupFormid(*(srformid_t *)pFormid->GetData(), pFormid->GetOrigValue(), FixupArray);
  }

  return (Result);
}
/*===========================================================================
 *		End of Class Method CSrRecord::FixupFormidSubrecords()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CSrRecord Method - bool FixupFormidSubrecords (FixupArray);
 *
 * Fixes the formid of all all subrecords in the record.
 *
 *=========================================================================*/
bool CSrRecord::FixupFormidSubrecords (CSrFormidFixupArray& FixupArray) {
  bool	Result = true;
  dword	Index;

  for (Index = 0; Index < m_Subrecords.GetSize(); ++Index) {
    Result &= m_Subrecords.GetAt(Index)->FixupFormID(FixupArray);
  }

  return (Result);
}
/*===========================================================================
 *		End of Class Method CSrRecord::FixupFormidSubrecords()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CSrRecord Method - bool GetField (Buffer, FieldID);
 *
 * Attempts to get a string representation of the given record field.
 * Returns false if the field was not found.
 *
 *=========================================================================*/
bool CSrRecord::GetField (CSString& Buffer, const srrecfieldid_t FieldID) {
  const srrecfield_t* pField;

  Buffer.Empty();
  pField = FindField(FieldID);

  if (pField == NULL || pField->GetMethod == NULL) return (false);
  return (this->*pField->GetMethod)(Buffer, 0);
 }
/*===========================================================================
 *		End of Class Method CSrRecord::GetField()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CSrRecord Method - CSrSubrecord* GetSubrecord (pSubrecord, Offset, Type);
 *
 * Accesses a subrecord relative to another subrecord within the record.
 *
 * Verifies:
 *		- The input subrecord exists in the record
 *		- The offset to the next subrecord is valid
 *		- The offset subrecord is the correct type.
 *
 * If any of these steps fail NULL is returned. The offset subrecord is
 * returned on success.
 *
 *=========================================================================*/
CSrSubrecord* CSrRecord::GetSubrecord (CSrSubrecord* pSubrecord, const int Offset, const srrectype_t Type) {
  CSrSubrecord* pDestSubrecord;
  int		Index;

	/* Find the subrecord */
  Index = m_Subrecords.Find(pSubrecord);

  if (Index < 0) {
    AddSrUserError(SRERR_USER_SUBRECNOTFOUND);
    return (NULL);
   }

	/* Ensure the offset subrecord exists */
  pDestSubrecord = m_Subrecords.GetAt(Index + Offset);

  if (pDestSubrecord == NULL) {
    //AddSrUserError(SRERR_USER_SUBRECNOTFOUND, "Subrecord index %d ([%d]+%d) is not valid!", Index + Offset, Index, Offset);
    return (NULL);
   }

	/* Ensure the subrecord is the correct type */
  if (pDestSubrecord->GetRecordType() != Type) {
    //AddSrUserError(SRERR_USER_SUBRECNOTFOUND, "The requested subrecord (%4.4s) is not the correct type (%4.4s)!", pDestSubrecord->GetRecordType().Name, Type.Name);
    return (NULL);
   }

  return (pDestSubrecord);
 }
/*===========================================================================
 *		End of Class Method CSrRecord::GetSubrecord()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CSrRecord Method - dword GetSubrecordSize (void);
 *
 * Protected class method that returns the size, in bytes, needed to output
 * all subrecords.
 *
 *=========================================================================*/
dword CSrRecord::GetSubrecordSize (void) {
  dword Size = 0;
  dword Index;

  for (Index = 0; Index < m_Subrecords.GetSize(); ++Index) {
    Size += m_Subrecords[Index]->GetOutputSize();
   }

  return (Size);
 }
/*===========================================================================
 *		End of Class Method CSrRecord::GetSubrecordSize()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CSrRecord Method - bool IsFormType (Type);
 *
 * SR_FUNCPARAM_ACTORVALUE
 * SR_FUNCPARAM_ANIMATIONGROUP
 * SR_FUNCPARAM_TESOBJECT
 * SR_FUNCPARAM_QUESTSTAGE
 * SR_FUNCPARAM_FORMTYPE
 *
 *=========================================================================*/
bool CSrRecord::IsFormType (const int Type) {

	/* Test against known simple types */
  switch (Type) {
    
  }

	/* Default */
  return (false);
}
/*===========================================================================
 *		End of Class Method CSrRecord::IsFormType()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CSrRecord Method - bool ImportCsvRow (CsvInfo, Row);
 *
 * Sets the record values from the gievn csv row. 
 *
 *=========================================================================*/
bool CSrRecord::ImportCsvRow (srcsvinfo_t& CsvInfo, CCsvRow& Row) {
  srcsvcolinfo_t* pColInfo;
  CSString*       pString;
  dword           Index;
  bool		  Result;

	/* Import all columns in the given CSV row */
  for (Index = 0; Index < CsvInfo.ColInfos.GetSize(); ++Index) {
    pColInfo = CsvInfo.ColInfos[Index];
    if (pColInfo == NULL)   continue;
    if (!pColInfo->Process) continue;
    if (pColInfo->pField == NULL) pColInfo->pField = FindField(pColInfo->FieldID);

    pString = Row[pColInfo->ColIndex];
    if (pString == NULL) continue;

		/* Prepare the string as required */
    pString->Unescape();

    if (pColInfo->pField != NULL && pColInfo->pField->IsAlNum()) {
      pString->RemoveCharsToMatch(isalnum);
    }

		/* Never import the record FormID */
	if (pColInfo->FieldID == SR_FIELD_FORMID) continue;

    Result = SetField(pColInfo->FieldID, pString->c_str());
    if (!Result) AddSrGeneralError("Error setting field %s value '%s', row %d, column %d!", pColInfo->pValue->c_str(), pString->c_str(), CsvInfo.CurrentLine, pColInfo->ColIndex);
  }

  return (true);
}
/*===========================================================================
 *		End of Class Method CSrRecord::ImportCsvRow()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CSrRecord Method - bool InitializeFieldMap (s_FieldIDMap);
 *
 * Initializes the class's field map into the given map container.
 *
 *=========================================================================*/
bool CSrRecord::InitializeFieldMap (CSrRecFieldIDMap& s_FieldIDMap) {
  const srrecfield_t*     pField;
  const srrecfieldmap_t*  pFieldMap;
  const srrecfieldmap_t*  pStartMap = GetFieldMap();
  dword		          Index;

	/* Loop through this class followed by all base classes */
  for (pFieldMap = pStartMap; pFieldMap != NULL; pFieldMap = pFieldMap->pBaseFieldMap) {
    assert(pFieldMap != pFieldMap->pBaseFieldMap);

    for (Index = 0; pFieldMap->pField[Index].GetMethod != NULL; ++Index) {
      pField = &pFieldMap->pField[Index];
      s_FieldIDMap.SetAt(pField->FieldID, (srrecfield_t *) pField);
    }
  }

  return (true);
}
/*===========================================================================
 *		End of Class Method CSrRecord::InitializeFieldMap()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CSrRecord Method - void InitializeNew (void);
 *
 * Initializes a new record ensuring any required sub-records are
 * defined and properly initialized. 
 *
 *=========================================================================*/
void CSrRecord::InitializeNew (void) 
{
	m_Header.Flags1 = 0;
	m_Header.Flags2 = 0;
	m_Header.FormID = 0;
	m_Header.Version = SR_RECORD_DEFAULTVERSION;
}
/*===========================================================================
 *		End of Class Method CSrRecord::InitializeNew()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CSrRecord Method - bool InitIOBuffers (void);
 *
 * Static class method to initialize the current temporary input/output 
 * buffers.
 *
 *=========================================================================*/
bool CSrRecord::InitIOBuffers (void) {

	/* Ignore if already initialized */
  if (s_pTempBuffer == NULL) {
    s_pTempBuffer    = new byte[SR_ZLIB_BUFFERSIZE + 4];
    s_TempBufferSize = SR_ZLIB_BUFFERSIZE;
  }

  if (!s_MemFile.IsOpen()) {
    return s_MemFile.Open(SR_ZLIB_BUFFERSIZE+ 4);
  }

  return (true);
}
/*===========================================================================
 *		End of Class Method CSrRecord::InitIOBuffers()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CSrRecord Method - void LoadLocalStrings (pCallback);
 *
 *=========================================================================*/
void CSrRecord::LoadLocalStrings (CSrCallback* pCallback)
{
	CSrSubrecord* pSubrecord;

	for (dword i = 0; i < m_Subrecords.GetSize(); ++i) 
	{
		pSubrecord = m_Subrecords.GetAt(i);
		pSubrecord->LoadLocalStrings(m_pParent);
	}

}
/*===========================================================================
 *		End of Class Method CSrRecord::LoadLocalStrings()
 *=========================================================================*/


void CSrRecord::MoveToEnd (const srrectype_t Name)
{
	dword StopIndex = m_Subrecords.GetSize();

	for (dword i = 0; i < StopIndex; ++i)
	{
		CSrSubrecord* pSubrecord = m_Subrecords.GetAt(i);
		if (pSubrecord == NULL) continue;
		if (pSubrecord->GetRecordType() != Name) continue;

		m_Subrecords.MoveToEnd(i);
		--StopIndex;
	}

}

   
/*===========================================================================
 *
 * Class CSrRecord Event - void OnAddSubrecord (pSubRecord);
 *
 *=========================================================================*/
void CSrRecord::OnAddSubrecord (CSrSubrecord* pSubrecord) 
{
}
/*===========================================================================
 *		End of Class Event CSrRecord::OnAddSubrecord()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CSrRecord Event - void OnDeleteSubrecord (pSubrecord);
 *
 *=========================================================================*/
void CSrRecord::OnDeleteSubrecord (CSrSubrecord* pSubrecord) {
}
/*===========================================================================
 *		End of Class Event CSrRecord::OnDeleteSubrecord()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CSrRecord Method - bool ReadSubRecords (File);
 *
 * Reads all the subrecords starting from the current location in the 
 * given File. Returns false on any error.
 *
 *=========================================================================*/
bool CSrRecord::ReadSubRecords (CSrFile& File) 
{
  srsubrecheader_t  Header;
  CSrSubrecord*     pSubrecord;
  CSrSubrecord*     pLastRecord = NULL;
  bool				Result;
  int				CurrentOffset;
  int				EndOffset;
  bool				LastRecordSpecial = false;

	/* Get the start of the subrecord data */
  Result = File.Tell(CurrentOffset);
  if (!Result) return (false);
  EndOffset = CurrentOffset + m_Header.Size;    
  
	/* Read until the end of the subrecord data is reached */
  while (CurrentOffset < EndOffset) 
  {

    Result = ReadSrSubRecordHeader(File, Header);
    if (!Result) return (false);

#if SRRECORD_DEBUG_OUTPUT
    SystemLog.Printf ("0x%08lX: SubRecord %4.4s (%d bytes left)", CurrentOffset, Header.Type.Name, EndOffset - CurrentOffset);
#endif
    pSubrecord = AddNewSubrecord(Header);

		/* Special case */
    if (LastRecordSpecial) 
	{
      pSubrecord->SetSpecialSize(*(dword *)pLastRecord->GetData());
    }
	
		/* Don't read subrecord data if cached */
    if ((m_CacheFlags & SR_CACHE_DEFERLOAD) != 0 && Header.Type != SR_NAME_EDID && Header.Type != SR_NAME_FULL && Header.Type != SR_NAME_DATA && Header.Type != SR_NAME_XXXX) 
	{
      if (LastRecordSpecial)
        Result = File.SeekCur(*(dword *)pLastRecord->GetData());
      else
        Result = File.SeekCur(Header.Size);

      if (!Result) return (false);
    }
    else 
	{
      Result = pSubrecord->Read(File);
      if (!Result) return (false);
    }

    Result = File.Tell(CurrentOffset);
    if (!Result) return (false);

    if (Header.Type == SR_NAME_XXXX) 
	{
       LastRecordSpecial = true;
    }
    else 
	{
       LastRecordSpecial = false;
    }

    pLastRecord = pSubrecord;
  }
    
  return (true);
}
/*===========================================================================
 *		End of Class Method CSrRecord::ReadSubRecords()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CSrRecord Method - bool ReadCompressedData (File);
 *
 * Reads a compressed data record. Returns false on any error.
 *
 *=========================================================================*/
bool CSrRecord::ReadCompressedData (CSrFile& File) {
  dword		DeflatedSize;
  z_stream	Stream;
  dword		OldSize;
  bool		Result;
  int		zResult;

  	/* Initialize the temporary input buffer */
  if (s_TempBufferSize <= m_Header.Size) {
    delete[] s_pTempBuffer;
    s_TempBufferSize = m_Header.Size + 100;
    s_pTempBuffer = new byte[s_TempBufferSize + 4];
   }

	/* Read the compressed data */
  Result = File.Read(s_pTempBuffer, m_Header.Size);
  if (!Result) return (false);

  	/* Create the temporary buffer to hold the uncompressed data */
  DeflatedSize = *(long *)(byte *)s_pTempBuffer;

  	/* Initialize the temporary output memory file */
  if (s_MemFile.GetBufferSize() <= DeflatedSize) {
    s_MemFile.Close();
    Result = s_MemFile.Open(DeflatedSize + 100);
    if (!Result) return (false);
   }
  else {
    s_MemFile.Seek(0);
   }
  
	/* Initialize the zLib stream */
  Stream.zalloc   = Z_NULL;
  Stream.zfree    = Z_NULL;
  Stream.opaque   = Z_NULL;
  Stream.avail_in = 0;
  Stream.next_in  = Z_NULL;

  zResult = inflateInit(&Stream);
  if (zResult != Z_OK) return AddSrZLibError(zResult, Stream.msg);
  
	/* Uncompress the data in the temp buffer into the memory file */
  Stream.next_in   = s_pTempBuffer + 4;
  Stream.avail_in  = m_Header.Size - 4;
  Stream.avail_out = DeflatedSize;
  Stream.next_out  = s_MemFile.GetBuffer();

  zResult = inflate(&Stream, Z_NO_FLUSH);
   
  if (zResult < 0) {
    AddSrZLibError(zResult, Stream.msg);
    inflateEnd(&Stream);
    return (false);
   }

  inflateEnd(&Stream);

	/* Parse the uncompressed data into subrecords */
  OldSize       = m_Header.Size;
  m_Header.Size = DeflatedSize;

  Result = ReadSubRecords(s_MemFile);
  m_Header.Size = OldSize;

/*	//Debug/Test Stuff
  static dword BytesCompress = 0;
  static dword BytesDecompress = 0;
  static dword Count = 0;
  ++Count;
  BytesCompress   += m_Header.Size;
  BytesDecompress += BufferSize;
  SystemLog.Printf("%d) Bytes: %u to %u (%g%%), Total %lu to %lu (%g%%)", Count, m_Header.Size, BufferSize,  (float)m_Header.Size*100.0f/(float)BufferSize, BytesCompress, BytesDecompress, (float)BytesCompress*100.0f/(float)BytesDecompress); //*/

  return (Result);
 }
/*===========================================================================
 *		End of Class Method CSrRecord::ReadCompressedData()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CSrRecord Method - bool ReadData (File);
 *
 * Reads a record determining if it has subrecords or raw data.
 * Returns false on any error.
 *
 *=========================================================================*/
bool CSrRecord::ReadData (CSrFile& File) {
  
#if SRRECORD_DEBUG_OUTPUT
  SystemLog.Printf("\t%4.4s, 0x%08lX", m_Header.RecordType.Name, File.Tell());
#endif

	/* Special compressed records */
  if (IsCompressed()) return ReadCompressedData(File);
    
	/* Default record type */
  return ReadSubRecords(File);
 }
/*===========================================================================
 *		End of Class Method CSrRecord::ReadData()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CSrRecord Method - bool SetField (FieldID, pString);
 *
 * Attempts to set the given field from a string. Returns false on any
 * error, such as if the field was not found or for an invalid input.
 *
 *=========================================================================*/
bool CSrRecord::SetField (const srrecfieldid_t FieldID, const SSCHAR* pString) 
{
  const srrecfieldmap_t* pMap;
  dword					 Index;

	/* Look for fields in class and all base classes */
  for (pMap = GetFieldMap(); pMap != NULL; pMap = pMap->pBaseFieldMap) {
    assert(pMap != pMap->pBaseFieldMap);

    for (Index = 0; pMap->pField[Index].GetMethod != NULL; ++Index) {

      if (pMap->pField[Index].FieldID == FieldID) {
        if (pMap->pField[Index].SetMethod == NULL) {
	  AddSrGeneralError("Cannot set the field '%s' (%d)!", GetSrFieldString(FieldID), FieldID);
	  return (false);
	}

        return (this->*pMap->pField[Index].SetMethod)(pString, 0);
      }
    }
  }

  AddSrGeneralError("No set method was found for the field '%s' (%d)!", GetSrFieldString(FieldID), FieldID);
  return (false);
}
/*===========================================================================
 *		End of Class Method CSrRecord::SetField()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CSrRecord Method - bool Write (File);
 *
 * Write the record starting from the current location in the given File.
 * Returns false on any error.
 *
 *=========================================================================*/
bool CSrRecord::Write (CSrFile& File) {
  int	StartOffset;
  bool  Result;
  
	/* Output the record header */
  Result = File.Write(&m_Header, SR_BASEHEADER_SIZE);
  if (!Result) return (false);

	/* Output compressed record data */
  if (IsCompressed()) return WriteCompressedData(File);

	/* Save the start location of the record data */
  Result = File.Tell(StartOffset);
  if (!Result) return (false);

	/* Default record type */
  Result = WriteSubRecords(File);
  if (!Result) return (false);

    	/* Update the record size */
  Result = WriteRecordSize(File, StartOffset);
  return (Result);
 }
/*===========================================================================
 *		End of Class Method CSrRecord::Write()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CSrRecord Method - bool WriteCompressedData (File);
 *
 * Write a compressed data record. Returns false on any error.
 *
 *=========================================================================*/
bool CSrRecord::WriteCompressedData (CSrFile& File) {
  int        StartOffset;
  dword      DeflatedSize = GetSubrecordSize();
  bool       Result;

	/* Initialize the temporary output memory file */
  if (s_MemFile.GetBufferSize() <= DeflatedSize) {
    s_MemFile.Close();
    Result = s_MemFile.Open(DeflatedSize + 100);
    if (!Result) return (false);
   }
  else {
    s_MemFile.Seek(0);
   }
  
	/* Output the raw sub-record data to the temporary buffer */
  Result = WriteSubRecords(s_MemFile);
  if (!Result) return (false);

	/* Save the start location of the record data */
  Result = File.Tell(StartOffset);
  if (!Result) return (false);

	/* Compress data and output to file */
  Result = WriteDeflate(File, s_MemFile);
  if (!Result) return (false);
	
	/* Update the record size */
  Result = WriteRecordSize(File, StartOffset);
  return (Result);
 }
/*===========================================================================
 *		End of Class Method CSrRecord::WriteCompressedData()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CSrRecord Method - bool WriteDeflate (File, RecordData);
 *
 * Protected class method that compresses the record data in the supplied
 * RecordData memory file and outputs the compressed data to the given
 * output file. Returns false on any error.
 *
 *=========================================================================*/
bool CSrRecord::WriteDeflate (CSrFile& File, CSrMemFile& RecordData)
{
  byte       TempBuffer[SR_ZLIBCOMPRESS_BUFFER + 4];
  z_stream   Stream;
  int	     Result;

	/* Output deflated buffer size */
  Result = File.WriteDWord(RecordData.Tell());
  if (!Result) return (false);

	/* Initialize the zLib stream */
  Stream.zalloc   = Z_NULL;
  Stream.zfree    = Z_NULL;
  Stream.opaque   = Z_NULL;
  Stream.avail_in = 0;
  Stream.next_in  = Z_NULL;

  Result = deflateInit(&Stream, SR_ZLIB_DEFLATELEVEL);
  if (Result = Z_OK) return AddSrZLibError(Result, Stream.msg);

  Stream.next_in  = RecordData.GetBuffer();
  Stream.avail_in = RecordData.Tell();
  
	/* Compress entire data buffer and output to file */
  do {
    Stream.avail_out = SR_ZLIBCOMPRESS_BUFFER;
    Stream.next_out  = TempBuffer;

		/* Compress record data to temporary buffer */
    Result = deflate(&Stream, Z_FINISH);
   
    if (Result < 0) {
      AddSrZLibError(Result, Stream.msg);
      deflateEnd(&Stream);
      return (false);
     }

		/* Output compressed data */
    Result = File.Write(TempBuffer, SR_ZLIBCOMPRESS_BUFFER - Stream.avail_out);

    if (!Result) {
      deflateEnd(&Stream);
      return (false);
     }

  } while (Stream.avail_out == 0);

  deflateEnd(&Stream);
  return (true);
}
/*===========================================================================
 *		End of Class Method CSrRecord::WriteDeflate()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CSrRecord Method - bool WriteRecordSize (File, Offset);
 *
 * Protected class method that updates the size of the record being output
 * assuming that the current location in the file is at the end of the
 * record. Returns false on any error. The input offset marks the start of
 * the record data in the file 
 *
 *=========================================================================*/
bool CSrRecord::WriteRecordSize (CSrFile& File, const int Offset) {
  bool  Result;
  int   CurrentOffset;
  dword RecordSize;

	/* Save the current file position */
  Result = File.Tell(CurrentOffset);
  if (!Result) return (false);

	/* Compute size of record data */
  assert(CurrentOffset >= Offset);
  RecordSize = CurrentOffset - Offset;

	/* Move to the record size position */
  Result = File.Seek(Offset - SR_BASEHEADER_SIZE + 4);
  if (!Result) return (false);

	/* Output the new record size */
  Result = File.WriteDWord(RecordSize);
  if (!Result) return (false);

	/* Return to end of output file */
  Result = File.Seek(CurrentOffset);
  return (Result);
 }
/*===========================================================================
 *		End of Class Method CSrRecord::WriteRecordSize()
 *=========================================================================*/

 
/*===========================================================================
 *
 * Class CSrRecord Method - bool WriteSubRecords (File);
 *
 * Writes all the subrecords to the current location in the 
 * given File. Returns false on any error.
 *
 *=========================================================================*/
bool CSrRecord::WriteSubRecords (CSrFile& File) {
  CSrSubrecord* pSubrecord;
  dword		Index;
  bool		Result;

	/* Output all subrecords */
  for (Index = 0; Index < m_Subrecords.GetSize(); ++Index) {
    pSubrecord = m_Subrecords[Index];
    assert(pSubrecord != NULL);

    Result = pSubrecord->Write(File);
    if (!Result) return (false);
   }

  return (true);
 }
/*===========================================================================
 *		End of Class Method CSrRecord::WriteSubRecords()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CSrRecord Method - srrecfield_t* FindSrFieldEntry (FieldID);
 *
 * Find a field entry in the given field maps by its ID.
 *
 *=========================================================================*/
const srrecfield_t* FindSrFieldEntry (const srrecfieldmap_t* pStartFieldMap, const srrecfieldid_t FieldID) {
  const srrecfieldmap_t*  pFieldMap;
  dword			          Index;

  if (pStartFieldMap == NULL) return (NULL);

	/* Loop through this class followed by all base classes */
  for (pFieldMap = pStartFieldMap; pFieldMap != NULL; pFieldMap = pFieldMap->pBaseFieldMap) {
    assert(pFieldMap != pFieldMap->pBaseFieldMap);

    for (Index = 0; pFieldMap->pField[Index].GetMethod != NULL; ++Index) {
      if (pFieldMap->pField[Index].FieldID == FieldID) return (&pFieldMap->pField[Index]);
     }
   }

	/* No match */
  return (NULL);
 }
/*===========================================================================
 *		End of Class Method CSrRecord::FindField()
 *=========================================================================*/


/*===========================================================================
 *
 * Begin CSrRecord Get Field Methods
 *
 *=========================================================================*/
DEFINE_SRGETFIELD(CSrRecord::GetFieldFormID,    String.Format("0x%08X", GetFormID()))
DEFINE_SRGETFIELD(CSrRecord::GetFieldName,      String.Format("%4.4s", GetRecordType().Name))
DEFINE_SRGETFIELD(CSrRecord::GetFieldUserData,  String.Format("%d", GetUserData()))
DEFINE_SRGETFIELD(CSrRecord::GetFieldIgnored,   String.Format("%s", BooleanToString(IsIgnored()) ))
DEFINE_SRGETFIELD(CSrRecord::GetFieldQuestItem, String.Format("%s", BooleanToString(IsQuestItem()) ))
DEFINE_SRGETFIELD(CSrRecord::GetFieldDeleted,   String.Format("%s", BooleanToString(IsDeleted()) ))
DEFINE_SRGETFIELD(CSrRecord::GetFieldDangerous, String.Format("%s", BooleanToString(IsDangerous()) ))

BEGIN_SRGETFIELD(CSrRecord::GetFieldRecordFlags) 
	String.Format("%s%s%s%s", IsActive() ? "*" : "", IsIgnored() ? "I" : "", IsDeleted() ? "D" : "", IsQuestItem() ? "Q" : "", IsDangerous() ? "!" : "");
END_SRGETFIELD()
/*===========================================================================
 *		End of CSrRecord Get Field Methods
 *=========================================================================*/


/*===========================================================================
 *
 * Begin CSrRecord Compare Field Methods
 *
 *=========================================================================*/
DEFINE_SRCOMPFIELDINT(CSrRecord, CompareFieldFormID, GetFormID)
DEFINE_SRCOMPFIELDSTRING(CSrRecord, CompareFieldName, GetRecordType)
DEFINE_SRCOMPFIELDINT(CSrRecord, CompareFieldUserData, GetUserData)
DEFINE_SRCOMPFIELDINT(CSrRecord, CompareFieldQuestItem, IsQuestItem)
DEFINE_SRCOMPFIELDINT(CSrRecord, CompareFieldDangerous, IsDangerous)
DEFINE_SRCOMPFIELDINT(CSrRecord, CompareFieldIgnored, IsIgnored)
DEFINE_SRCOMPFIELDINT(CSrRecord, CompareFieldDeleted, IsDeleted)

BEGIN_SRCOMPFIELD(CSrRecord::CompareFieldRecordFlags)
	if (pRecord == NULL) return 1;

	int IsActive1 = IsActive();
	int IsActive2 = pRecord->IsActive();

	if (IsActive1 == IsActive2)
	{
		if (GetFlags() == pRecord->GetFlags()) return 0;
		if (GetFlags() <  pRecord->GetFlags()) return -1;
		return 1;
	}
	else if (IsActive1 < IsActive2)
		return -1;
	else
		return 1;

END_SRCOMPFIELD()
/*===========================================================================
 *		End of CSrRecord Compare Field Methods
 *=========================================================================*/


/*===========================================================================
 *
 * Begin CSrRecord Set Field Methods
 *
 *=========================================================================*/
BEGIN_SRSETFIELD(CSrRecord::SetFieldFormID)
  AddSrGeneralError("Cannot set the formID of a record from its SetField method!");
  return (false);
END_SRSETFIELD()


BEGIN_SRSETFIELD(CSrRecord::SetFieldName)
  AddSrGeneralError("Cannot set the record type of a record from its SetField method!");
  return (false);
END_SRSETFIELD()


BEGIN_SRSETFIELD(CSrRecord::SetFieldUserData)
  return SrFieldConvertLong(pString, m_UserData);
END_SRSETFIELD()


BEGIN_SRSETFIELD(CSrRecord::SetFieldQuestItem)
  bool Result;
  bool Value;

  Result = SrFieldConvertBoolean(pString, Value);
  if (Result) SetQuestItem(Value);
  return (Result);
END_SRSETFIELD()


BEGIN_SRSETFIELD(CSrRecord::SetFieldDangerous)
  bool Result;
  bool Value;

  Result = SrFieldConvertBoolean(pString, Value);
  if (Result) SetDangerous(Value);
  return (Result);
END_SRSETFIELD()


BEGIN_SRSETFIELD(CSrRecord::SetFieldIgnored)
  bool Result;
  bool Value;

  Result = SrFieldConvertBoolean(pString, Value);
  if (Result) SetIgnored(Value);
  return (Result);
END_SRSETFIELD()


BEGIN_SRSETFIELD(CSrRecord::SetFieldDeleted)
  bool Result;
  bool Value;

  Result = SrFieldConvertBoolean(pString, Value);
  if (Result) SetDeleted(Value);
  return (Result);
END_SRSETFIELD()


BEGIN_SRSETFIELD(CSrRecord::SetFieldRecordFlags) 
  const SSCHAR* pParse = pString;

	/* Clear known flags */
  SetDeleted(false);
  SetQuestItem(false);
  SetDangerous(false);

	/* Parse flags from input string */
  while (*pParse != NULL_CHAR) {
    switch (toupper(*pParse)) {
      case 'D':
        SetDeleted(true);
      	break;
      case 'Q':
        SetQuestItem(true);
	break;
      case '!':
        SetDangerous(true);
	break;
      case 'I':
        SetIgnored(true);
	break;
    }

    ++pParse;
  }

END_SRSETFIELD()
/*===========================================================================
 *		End of CSrRecord Set Field Methods
 *=========================================================================*/


const char* CSrRecord::GetEditorIDHelper (CSrFormidSubrecord* pSubrecord)
{
	if (m_pParent  == NULL) return NULL;
	if (pSubrecord == NULL) return NULL;
	return m_pParent->GetEditorID(pSubrecord->GetValue());
}


const char* CSrRecord::GetEditorIDHelper (const srformid_t FormID)
{
	if (m_pParent  == NULL) return NULL;
	if (FormID     ==    0) return NULL;
	return m_pParent->GetEditorID(FormID);
}


void CSrRecord::SetSubrecordFormID (CSrFormidSubrecord* pSubrecord, const srformid_t FormID, const srrectype_t Type)
{

	if (pSubrecord == NULL)
	{
		CSrSubrecord* pNewSubrecord = AddNewSubrecord(Type);
		pSubrecord = SrCastClassNull(CSrFormidSubrecord, pNewSubrecord);
		if (pSubrecord == NULL) return;
		pSubrecord->InitializeNew();
	}

	pSubrecord->SetValue(FormID);
}


void CSrRecord::SetSubrecordFormID (CSrFormidSubrecord* pSubrecord, const char* pEditorID, const srrectype_t Type)
{
	if (m_pParent == NULL) return;
	CSrRecord* pRecord = m_pParent->FindEditorID(pEditorID);

	if (pRecord != NULL) 
		SetSubrecordFormID(pSubrecord, pRecord->GetFormID(), Type);
	else
		SetSubrecordFormID(pSubrecord, SR_FORMID_NULL, Type);
}


void CSrRecord::SetSubrecordFormID (srformid_t& ResultFormID, const char* pEditorID)
{
	if (m_pParent == NULL) return;
	CSrRecord* pRecord = m_pParent->FindEditorID(pEditorID);

	if (pRecord != NULL) 
		ResultFormID = pRecord->GetFormID();
	else
		ResultFormID = SR_FORMID_NULL;
}


void CSrRecord::UpdateLoadLocalString (const bool LoadLocal)
{

	for (dword i = 0; i < m_Subrecords.GetSize(); ++i)
	{
		m_Subrecords[i]->SetLoadLocalString(LoadLocal);
	}
}
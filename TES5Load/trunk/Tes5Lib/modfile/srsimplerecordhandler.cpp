/*===========================================================================
 *
 * File:		Srsimplerecordhandler.CPP
 * Author:		Dave Humphrey (dave@uesp.net)
 * Created On:	26 November 2011
 *
 * Description
 *
 *=========================================================================*/

	/* Include Files */
#include "srsimplerecordhandler.h"


/*===========================================================================
 *
 * Class CSrSimpleRecordHandler Constructor
 *
 *=========================================================================*/
CSrSimpleRecordHandler::CSrSimpleRecordHandler (const dword HashMapSize) 
{
  m_NextFreeFormID   = SRESPFILE_FIRST_FORMID;
  m_NextFreeEditorID = SRESPFILE_FIRST_EDITORID;

  m_FormIdMap.InitHashTable(HashMapSize);
  m_EditorIdMap.InitHashTable(HashMapSize);

  	/* Initialize the special player reference */
  m_PlayerRef.Initialize(SR_NAME_REFR);
  m_PlayerRef.InitializeNew();
  m_PlayerRef.SetFormID(SR_PLAYERREF_FORMID);
  m_PlayerRef.SetEditorID("PlayerRef");
  //m_PlayerRef.SetBaseFormID(SR_PLAYER_FORMID); //TODO: When implemented
  m_PlayerRef.SetParent(this);
  m_PlayerRef.SetQuestItem(true);

  m_EspFile.SetParent(this);
}
/*===========================================================================
 *		End of Class CSrSimpleRecordHandler Constructor
 *=========================================================================*/


/*===========================================================================
 *
 * Class CSrSimpleRecordHandler Method - void Destroy (void);
 *
 *=========================================================================*/
void CSrSimpleRecordHandler::Destroy (void) 
{
  m_NextFreeFormID   = SRESPFILE_FIRST_FORMID;
  m_NextFreeEditorID = SRESPFILE_FIRST_EDITORID;

  m_FormIdMap.Destroy();
  m_EditorIdMap.Destroy();
  m_EspFile.Destroy();
 }
/*===========================================================================
 *		End of Class Method CSrSimpleRecordHandler::Destroy()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CSrSimpleRecordHandler Method - CSrRecord* CreateNewRecord (Type);
 *
 * Creates and adds a new record to the file as given by the input
 * record type. The new record is returned.
 *
 *=========================================================================*/
CSrRecord* CSrSimpleRecordHandler::CreateNewRecord (const srrectype_t Type) 
{
  return m_EspFile.CreateNewRecord(Type);
}
/*===========================================================================
 *		End of Class Method CSrSimpleRecordHandler::CreateNewRecord()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CSrSimpleRecordHandler Method - bool DeleteRecord (pRecord);
 *
 *=========================================================================*/
bool CSrSimpleRecordHandler::DeleteRecord (CSrRecord* pRecord) 
{
  CSrIdRecord* pIdRecord;

  if (pRecord == NULL) return (false);

	/* Delete record from the index maps */
  m_FormIdMap.Delete(pRecord);

  pIdRecord = SrCastClass(CSrIdRecord, pRecord);
  if (pIdRecord != NULL) m_EditorIdMap.Delete(pIdRecord);

  return m_EspFile.DeleteRecord(pRecord);
}
/*===========================================================================
 *		End of Class Method CSrSimpleRecordHandler::DeleteRecord()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CSrSimpleRecordHandler Method - CSrRecord* FindFormID (FormID);
 *
 *=========================================================================*/
CSrRecord* CSrSimpleRecordHandler::FindFormID (const srformid_t FormID) 
{
  CSrRecord* pRecord;
  bool	     Result;

	/* Ignore invalid input */
  if (FormID == SR_FORMID_NULL) return (NULL);

  Result = m_FormIdMap.Lookup(FormID, pRecord);
  if (!Result) return (NULL);
  return (pRecord);
}
/*===========================================================================
 *		End of Class Method CSrSimpleRecordHandler::FindFormID()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CSrSimpleRecordHandler Method - CSrIdRecord* FindEditorID (pString);
 *
 *=========================================================================*/
CSrIdRecord* CSrSimpleRecordHandler::FindEditorID (const SSCHAR* pString)
{
  CSrIdRecord* pRecord;
  bool	       Result;

	/* Ignore invalid input */
  if (pString == NULL) return (NULL);

  Result = m_EditorIdMap.Lookup(pString, pRecord);
  if (!Result) return (NULL);
  return (pRecord);
}
/*===========================================================================
 *		End of Class Method CSrSimpleRecordHandler::FindEditorID()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CSrSimpleRecordHandler Method - bool GetEditorID (Buffer, FormID);
 *
 *=========================================================================*/
bool CSrSimpleRecordHandler::GetEditorID (CSString& Buffer, const srformid_t FormID)
{
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
 *		End of Class Method CSrSimpleRecordHandler::GetEditorID()
 *=========================================================================*/


/*===========================================================================
 *
 * Class SSCHAR* CSrSimpleRecordHandler Method - const GetEditorID (FormID);
 *
 *=========================================================================*/
const SSCHAR* CSrSimpleRecordHandler::GetEditorID (const srformid_t FormID) 
{
  CSrRecord*   pRecord;
  CSrIdRecord* pIdRecord;
    
  if (FormID == SR_FORMID_NULL) return (NULL);

  pRecord = FindFormID(FormID);
  if (pRecord == NULL) return (NULL);

  pIdRecord = SrCastClass(CSrIdRecord, pRecord);
  if (pIdRecord != NULL) return pIdRecord->GetEditorID();

  CSrSubrecord* pSubrecord = pRecord->FindSubrecord(SR_NAME_EDID);
  if (pSubrecord == NULL) return (NULL);
  return (const char *) pSubrecord->GetData();
}
/*===========================================================================
 *		End of Class Method SSCHAR* CSrSimpleRecordHandler::GetEditorID()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CSrSimpleRecordHandler Method - const SSCHAR* GetFreeEditorID (void);
 *
 *=========================================================================*/
const SSCHAR* CSrSimpleRecordHandler::GetFreeEditorID (void)
{
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
 *		End of Class Method CSrSimpleRecordHandler::GetFreeEditorID()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CSrSimpleRecordHandler Method - srformid_t GetFreeFormID (ModIndex);
 *
 * Returns the next available form ID not currently in use by the mod.
 *
 *=========================================================================*/
srformid_t CSrSimpleRecordHandler::GetFreeFormID (const byte ModIndex)
{
  dword       NumOverFlows = 0;
  srformid_t  NewID;

  do {
    NewID = (m_NextFreeFormID & 0x00ffffff) | (ModIndex << 24);
    ++m_NextFreeFormID;

		/* Check for an overflow */
    if (m_NextFreeFormID > MAX_SRFORMID) {
      ++NumOverFlows;
      m_NextFreeFormID = SRESPFILE_FIRST_FORMID;

		/* Prevent an infinite loop in the worst case */
      if (NumOverFlows > 1) {
        m_NextFreeFormID = 0;
		AddSrGeneralError("GetFreeFormID(): All form IDs are in use!");
		return (SR_FORMID_NULL);
      }
    }

  } while (FindFormID(NewID) != NULL);

  return (NewID);
}
/*===========================================================================
 *		End of Class Method CSrSimpleRecordHandler::GetFreeFormID()
 *=========================================================================*/

 
/*===========================================================================
 *
 * Class CSrSimpleRecordHandler Method - void IndexRecord (pRecord);
 *
 *=========================================================================*/
void CSrSimpleRecordHandler::IndexRecord (CSrRecord* pRecord)
{
  CSrIdRecord* pIdRecord;
  
  if (pRecord != NULL)
  {
    m_FormIdMap.SetAt(pRecord);

    pIdRecord = SrCastClass(CSrIdRecord, pRecord);
    if (pIdRecord != NULL) m_EditorIdMap.SetAt(pIdRecord);
  }

}
/*===========================================================================
 *		End of Class Method CSrSimpleRecordHandler::IndexRecord()
 *=========================================================================*/


/*===========================================================================
 *
 * Function - int l_IndexCallback (pRecord, UserData, pUserPtr);
 *
 * Callback used by the IndexRecords() method.
 *
 *=========================================================================*/
int l_IndexCallback (CSrRecord* pRecord, const dword UserData, void* pUserPtr)
{
  CSrSimpleRecordHandler* pHandler = (CSrSimpleRecordHandler *) pUserPtr;

  if (pHandler != NULL) pHandler->IndexRecord(pRecord);
  return (0);
}
/*===========================================================================
 *		End of Function l_IndexCallback()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CSrSimpleRecordHandler Method - bool IndexRecords (pCallback);
 *
 * Index all records in the file.
 *
 *=========================================================================*/
bool CSrSimpleRecordHandler::IndexRecords (CSrCallback* pCallback)
{
  dword MapSize;

	/* Clear the current indices */
  m_FormIdMap.Destroy();
  m_EditorIdMap.Destroy();

	/* Set the hash map size */
  MapSize = (dword) ((m_EspFile.GetRecordCount() + 1031) * 1.21);
  m_FormIdMap.InitHashTable(MapSize);
  m_EditorIdMap.InitHashTable(MapSize);

  	/* Add special pseudo-records */
  m_FormIdMap.SetAt(&m_PlayerRef);
  m_EditorIdMap.SetAt(&m_PlayerRef);
  
	/* Index all records in the file */
  m_EspFile.ForEachRecord(l_IndexCallback, 0, this);

  return (true);
}
/*===========================================================================
 *		End of Class Method CSrSimpleRecordHandler::IndexRecords()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CSrSimpleRecordHandler Method - bool Load (pFilename, pCallback);
 *
 *=========================================================================*/
bool CSrSimpleRecordHandler::Load (const SSCHAR* pFilename, CSrCallback* pCallback)
{
  bool Result;

	/* Clear the current information */
  Destroy();

	/* Attempt to load the single file */
  Result = m_EspFile.Load(pFilename, pCallback);
  if (!Result) return (false);

	/* Index all records */
  IndexRecords(NULL);
  return (true);
}
/*===========================================================================
 *		End of Class Method CSrSimpleRecordHandler::Load()
 *=========================================================================*/

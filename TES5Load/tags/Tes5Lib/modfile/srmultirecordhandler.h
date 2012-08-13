/*===========================================================================
 *
 * File:		SrMultirecordhandler.H
 * Author:		Dave Humphrey (dave@uesp.net)
 * Created On:	26 November 2011
 *
 * Handles a multiple ESM/ESM files.
 *
 *=========================================================================*/
#ifndef __SRMULTIRECORDHANDLER_H
#define __SRMULTIRECORDHANDLER_H


/*===========================================================================
 *
 * Begin Required Includes
 *
 *=========================================================================*/
  #include "srrecordhandler.h"
  #include "srespfile.h"
  #include "../common/srarray.h"
  #include "../common/srblockallocator.h"
  #include "sreventhandler.h"
  #include "srundoitem.h"
/*===========================================================================
 *		End of Required Includes
 *=========================================================================*/


/*===========================================================================
 *
 * Begin Definitions
 *
 *=========================================================================*/

	/* Return values for duplicate checking */
  #define SRE_DUPLICATE_FALSE	0
  #define SRE_DUPLICATE_TRUE	1
  #define SRE_DUPLICATE_ERROR	-1

	/* Default size of the new groups array */
  #define SRE_DEFAULT_NEWGROUP_SIZE 150000
  
/*===========================================================================
 *		End of Definitions
 *=========================================================================*/


/*===========================================================================
 *
 * Begin Type Definitions
 *
 *=========================================================================*/

	/* Forward class definitions */
  class CSrMultiRecordHandler;

	/* Used to load an active plugin and multiple masters */
  struct srfileloadinfo_t 
  {
	CSStringArray	m_MasterFilenames;
	CSString		m_ActiveFilename;
  };

	/* Used when indexing records */
  struct srindexinfo_t 
  {
    CSrMultiRecordHandler*	pHandler;
    bool					FirstFile;
    dword					ModIndex;
    CSrCallback*			pCallback;
    dword					RecordCount;
  };

	/* Used to handle duplicate IDs */
  struct srdupformidinfo_t 
  {
	CSrRecord*	pRecord;
	dword		ModIndex;
  };

  struct srdupeditoridinfo_t 
  {
	CSrIdRecord*	pRecord;
	dword		ModIndex;
  };

  typedef CSrPtrArray<srdupformidinfo_t>   CSrDupFormIdArray;
  typedef CSrPtrArray<srdupeditoridinfo_t> CSrDupEditorIdArray;

	/* Test block allocators */
  typedef TSrBlockAllocator<CSrRefGroup>       CSrRefGroupAllocator;
  typedef TSrBlockAllocator<CSrRefTypeGroup>   CSrRefTypeGroupAllocator;
  typedef TSrBlockAllocator<CSrRefFormIDGroup> CSrRefFormIDGroupAllocator;
  typedef TSrBlockAllocator<CSrRefBlockGroup>  CSrRefBlockGroupAllocator;
  typedef TSrBlockAllocator<CSrRefGridGroup>   CSrRefGridGroupAllocator;

	/* Record handler options */
  struct srmultirecoptions_t 
  {
	srundooptions_t Undo;
		
	bool		EnableCaching;


	srmultirecoptions_t() 
	{
		EnableCaching      = true;
	}
};

/*===========================================================================
 *		End of Type Definitions
 *=========================================================================*/


/*===========================================================================
 *
 * Begin Class CSrMultiRecordHandler Definition
 *
 * Description
 *
 *=========================================================================*/
class CSrMultiRecordHandler : public CSrRecordHandler {
  friend int l_IndexFileCallback (CSrRecord* pRecord, const dword UserData, void* pUserPtr);

  /*---------- Begin Protected Class Members --------------------*/
protected:
  CEspFileArray					m_MasterFiles;			/* Master dependancies */
  CSrEspFile					m_ActiveFile;			/* The active file */

  CSrRefFileGroup				m_TopFileGroup;			/* Head of overall record tree */
  CSrGroupArray					m_NewGroups;

  CSrRecordArray				m_NewRecords;			/* Temporary array for new records before saving */

  CSrFullFormIdRecordMap		m_FormIdMap;			/* Fast lookup maps */
  CSrEditorIdRecordMap			m_EditorIdMap;

  dword							m_NextFreeFormID;		/* Used to find a free ID */
  dword							m_NextFreeEditorID;

  CSrDupFormIdArray				m_DuplicateFormIDs;		/* Used during loading */
  CSrDupEditorIdArray			m_DuplicateEditorIDs;

  CSrEventHandler				m_EventHandler;

  CSrUndoItemArray				m_UndoItems;			/* Records undo actions */
  
  CSrRefGroupAllocator			m_GroupAllocator;		/* Test block allocators */
  CSrRefTypeGroupAllocator		m_TypeGroupAllocator;
  CSrRefFormIDGroupAllocator	m_FormIDGroupAllocator;
  CSrRefBlockGroupAllocator		m_BlockGroupAllocator;
  CSrRefGridGroupAllocator		m_GridGroupAllocator;

  static srmultirecoptions_t	m_Options;				/* Handler options */

  CSrRefrRecord					m_PlayerRef;			/* Special pseudo-records */


public:
  static CSrEspFile	 m_SkyrimMaster;	/* One global copy of Oblivion.esm */


  /*---------- Begin Protected Class Methods --------------------*/
protected:

	/* Attempt to create a new master file */
  CSrEspFile* AddMaster (void);

  	/* Check and handle duplicate IDs */
  bool CheckDuplicateFormId   (CSrRecord*   pRecord);
  bool CheckDuplicateEditorId (CSrIdRecord* pRecord);

  	/* Create a new record of the given type to the file */
  CSrRecord* CreateNewRecord (const srrectype_t Type);

	/* Create the top level record tree */
  bool      CreateRecordTree    (CSrCallback* pCallback);
  bool      CreateRecordTree    (CSrEspFile* pFile, CSrCallback* pCallback);
  bool      CreateRecordTree    (CSrGroup* pDestGroup, CSrGroup* pSourceGroup, CSrCallback* pCallback);
  bool      CreateTreeAddRecord (CSrGroup* pDestGroup, CSrRecord* pRecord, const bool FirstFile);
  CSrGroup* CreateTreeFindGroup (CSrGroup* pDestGroup, CSrGroup*  pGroup,  const bool FirstFile);

  	/* Csv import/export helper routines */
  CSrIdRecord* CreateIDRecordFromCsvRow (srcsvinfo_t& CsvInfo, CCsvRow& Row, CSrIdRecord*& pOldRecord);
  
  	/* Deletes the specified record */
  virtual bool DeleteRecord    (CSrRecord* pRecord);
  virtual bool DeleteNewRecord (CSrRecord* pRecord);
  virtual bool RemoveNewRecord (CSrRecord* pRecord);

	/* Fixup the formids of all mods currently loaded */
  bool CreateFormidFixup (CSrFormidFixupArray& FixupArray, CSrEspFile* pFile, const byte ModIndex);
  bool FixupFormids      (void);
  bool FixupFormids      (CSrEspFile* pFile, const byte ModIndex);
  bool HasFixupChanged   (CSrFormidFixupArray& FixupArray);

	/* Find a version of the given record in a master file */
  CSrRecord* FindNonActiveRecord (CSrRecord* pRecord);

  virtual CSString* FindLocalString (const srlstringid_t ID);

	/* Handle any duplicates found during an indexing */
  bool HandleDuplicateFormIDs   (void);
  bool HandleDuplicateEditorIDs (void);

	/* Index records in a file */
  virtual bool IndexFile       (CSrEspFile* pFile, const bool FirstFile, const dword ModIndex, CSrCallback* pCallback);
          bool IndexDuplicates (void);

	  	/* Adds the given record to the record indexes */
  virtual void IndexRecord      (CSrRecord* pRecord);
  virtual bool IndexRecords     (CSrCallback* pCallback);
  virtual bool IndexCheckRecord (CSrRecord* pRecord, const dword ModIndex);

	/* Helper input/output methods */
  bool LoadMasterFile (const SSCHAR* pFilename, const dword ModIndex, CSrCallback* pCallback);

  	/* Moves the given new record into the active file and record tree */
  bool MoveNewRecord (CSrRecord* pRecord);

	/* Remove a record from any indexes */
  bool RemoveFromIndex (CSrRecord* pRecord);

  	/* Rename the editorid of a record */
  CSrIdRecord* RenameIDRecordPriv (CSrIdRecord* pRecord, const SSCHAR* pNewEditorID, const bool CreateUndo = false);

  	/* Updates the masters of the active file */
  bool SetActiveMasters (void);

	/* Remove undo items over the limit */
  void TrimUndoItems (void);

	/* Updates the overall record tree for the given record */
  bool UpdateRecordTree (CSrRecord* pNewRecord, CSrRecord* pOldRecord); 

	/* Helper record update method */
  bool UpdateNewEditRecord (sreditrecinfo_t& EditRecInfo);


  /*---------- Begin Public Class Methods -----------------------*/
public:

	/* Class Constructors/Destructors */
  CSrMultiRecordHandler (const dword HashMapSize = SRESPFILE_DEFAULT_MAPSIZE);
  virtual ~CSrMultiRecordHandler() { Destroy(); }
  virtual void Destroy (void);

  	/* Change one ID for another */
  virtual dword ChangeFormID        (const srformid_t NewID, const srformid_t OldID) { return ChangeFormIDIndex(NewID, OldID, 0); }
  virtual dword ChangeEditorID      (const SSCHAR*   pNewID, const SSCHAR*   pOldID) { return ChangeEditorIDIndex(pNewID, pOldID, 0); }
  virtual dword ChangeFormIDIndex   (const srformid_t NewID, const srformid_t OldID, const dword StartModIndex);
  virtual dword ChangeEditorIDIndex (const SSCHAR*   pNewID, const SSCHAR*   pOldID, const dword StartModIndex);

  bool ChangeRecordFormID (CSrRecord* pRecord, const srformid_t NewID);

  dword ChangeFormID    (CSrRecord* pRecord, const srformid_t NewID, const srformid_t OldID);
  dword ChangeFormID    (CSrGroup* pGroup, const srformid_t NewID, const srformid_t OldID);
  bool  ChangeModIndex  (CSrRecord* pRecord, const byte ModIndex);
  bool  AssignNewFormID (CSrRecord* pRecord, const byte ModIndex);

	/* Removes the given record from the active file */
  CSrRecord* CleanRecord (CSrRecord* pRecord);

  	/* Count records in current files */
  dword CountAllRecords (void);

	/* Creates a new copy of the given record */
  bool CreateIDRecordCopy (CSrIdRecord* pRecord, const char* pEditorID);
  
  	/* Create new undo actions */
  CSrUndoItem* CreateUndoClean  (CSrRecord* pRecord);
  CSrUndoItem* CreateUndoAdd    (sreditrecinfo_t& EditInfo);
  CSrUndoItem* CreateUndoAdd    (CSrRecord* pRecord, const char* pNewEditorID);
  CSrUndoItem* CreateUndoUpdate (CSrRecord* pRecord);
  CSrUndoItem* CreateUndoUpdate (sreditrecinfo_t& EditRecInfo);

	/* Deletes the specified master file */
  bool DeleteMaster (CSrEspFile* pMaster);

	/* Find data operations */
  virtual dword Search (srfinddata_t& FindData, CSrCallback* pCallback);

  	/* Find records */
  virtual CSrRecord*   FindFormID   (const srformid_t FormID);
  virtual CSrIdRecord* FindEditorID (const SSCHAR*    pString);

	/* Find the mod index of the given file */
  int FindModIndex (const SSCHAR* pFilename);

	/* Access the static options member */
  static srmultirecoptions_t& GetOptions (void) { return (m_Options); }

	/* Access the event handler member */
  CSrEventHandler& GetEventHandler (void) { return (m_EventHandler); }

	/* Get the editorID from a formID */
  virtual bool          GetEditorID (CSString& Buffer, const srformid_t FormID);
  virtual const SSCHAR* GetEditorID (const srformid_t FormID);

  	/* Iterate through records/groups */
  virtual CSrRecord* GetFirstRecord (SRMAPPOS& RecordPos) { return m_FormIdMap.GetFirstRecord(RecordPos); }
  virtual CSrRecord* GetNextRecord  (SRMAPPOS& RecordPos) { return m_FormIdMap.GetNextRecord(RecordPos); }
  virtual dword      GetNumRecords  (void)                { return m_FormIdMap.GetRecordCount(); }
  virtual CSrGroup*  GetTopGroup    (void)                { return (&m_TopFileGroup); }

	/* Access a top level type group */
  virtual CSrTypeGroup* GetTypeGroup (const srrectype_t Type) { return m_TopFileGroup.GetTypeGroup(Type); }

	/* Get the next available formID that is not currently in use */
  virtual srformid_t    GetFreeFormID       (const byte ModIndex = 0);
  virtual srformid_t    GetActiveFreeFormID (void) { return GetFreeFormID(m_ActiveFile.GetModIndex()); }
  virtual const SSCHAR* GetFreeEditorID     (void);

	/* Get class members */
  dword          GetNumMaster       (void) { return (m_MasterFiles.GetSize()); }
  CEspFileArray& GetMasterFiles     (void) { return (m_MasterFiles); }
  CSrEspFile&    GetActiveFile      (void) { return (m_ActiveFile); }
  CSrRefrRecord* GetPlayerReference (void) { return (&m_PlayerRef); }

    	/* Get undo information */
  dword             GetNumUndoItems (void) { return (m_UndoItems.GetSize() > 0); }
  CSrUndoItem*      GetTopUndoItem  (void) { return (m_UndoItems.GetSize() == 0 ? NULL : m_UndoItems.GetAt(m_UndoItems.GetSize() - 1)); }
  CSrUndoItemArray& GetUndoItems    (void) { return (m_UndoItems); }

	/* Check a new editorid for validity */
  bool IsValidNewEditorID (const char* pEditorID);

	/* Import routines */
  bool ImportCsvRow (srcsvinfo_t& CsvInfo, CCsvRow& Row);
  bool ImportCsv    (dword& NewRecords, CCsvFile& CsvFile);

	/* Is the parent the active file or not */
  virtual bool IsActive (void) const { return (false); }

  	/* Load masters and active plugins */
  bool Load (srfileloadinfo_t& LoadInfo, CSrCallback* pCallback = NULL);

    	/* Move the given record to the active file */
  bool       MakeRecordActive     (CSrRecord* pRecord);
  CSrRecord* MakeRecordActivePriv (CSrRecord* pRecord, const bool Index);

	/* Prepare for a new file */
  bool NewFile (void);

	/* Events that occurs before/after a record is updated */
  virtual int OnPreSaveCheckEditorID (sreditrecinfo_t& EditRecInfo);
  virtual int OnPreSaveRecord        (sreditrecinfo_t& EditRecInfo);
  virtual int OnPostSaveRecord       (sreditrecinfo_t& EditRecInfo);
  virtual int OnCancelEditRecord     (sreditrecinfo_t& EditRecInfo);

	/* Prepares a new record for editing */
  CSrRecord* PrepareNewRecord (const srrectype_t RecordType);

	/* Rename a record's editorid */
  bool RenameIDRecord (CSrIdRecord* pRecord, const SSCHAR* pNewEditorID);

	/* Perform an undo */
  bool PerformUndo       (void);
  bool PerformUndo       (CSrUndoItem* pUndoItem);
  bool PerformAddUndo    (CSrUndoItem* pUndoItem);
  bool PerformCleanUndo  (CSrUndoItem* pUndoItem);
  bool PerformUpdateUndo (CSrUndoItem* pUndoItem);
  bool PerformUndoTo     (CSrUndoItem* pUndoItem);

	/* Save the active file */
  bool Save (const SSCHAR* pFilename, CSrCallback* pCallback = NULL) { return m_ActiveFile.Save(pFilename, pCallback); }

	/* Toggle record flags */
  CSrRecord* ToggleIgnoreFlag (CSrRecord* pRecord);
  CSrRecord* ToggleDeleteFlag (CSrRecord* pRecord);
  CSrRecord* ToggleQuestFlag  (CSrRecord* pRecord);

};
/*===========================================================================
 *		End of Class CSrMultiRecordHandler Definition
 *=========================================================================*/


#endif
/*===========================================================================
 *		End of File SrMultiRecordhandler.H
 *=========================================================================*/

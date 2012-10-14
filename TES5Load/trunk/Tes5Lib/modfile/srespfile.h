/*===========================================================================
 *
 * File:		Srespfile.H
 * Author:		Dave Humphrey (dave@uesp.net)
 * Created On:	26 November 2011
 *
 * Defines the CSrEspFile class for handling ESP files. The ESM file class
 * is derived from this.
 *
 *=========================================================================*/
#ifndef __OBESPFILE_H
#define __OBESPFILE_H


/*===========================================================================
 *
 * Begin Required Includes
 *
 *=========================================================================*/
	#include "records/srbasereccont.h"
	#include "records/srreccont.h"
	#include "records/srrecordmap.h"

	#include "groups/srgroup.h"
	#include "groups/srtypegroup.h"
	#include "groups/srformidgroup.h"
	#include "groups/srblockgroup.h"
	#include "groups/srgridgroup.h"
  
	#include "records/srrecord.h"
  
	#include "records/SrAactrecord.h"
	#include "records/SrAchrrecord.h"
	#include "records/SrActirecord.h"
	#include "records/SrAddnrecord.h"
	#include "records/SrAlchrecord.h"
	#include "records/SrAmmorecord.h"
	#include "records/SrAniorecord.h"
	#include "records/SrApparecord.h"
	#include "records/SrArmarecord.h"
	#include "records/SrArmorecord.h"
	#include "records/SrArtorecord.h"
	#include "records/SrAspcrecord.h"
	#include "records/SrAstprecord.h"
	#include "records/SrAvifrecord.h"
	#include "records/SrBookrecord.h"
	#include "records/SrBptdrecord.h"
	#include "records/SrCamsrecord.h"
	#include "records/SrCellrecord.h"
	#include "records/SrClasrecord.h"
	#include "records/SrClfmrecord.h"
	#include "records/SrClmtrecord.h"
	#include "records/SrCobjrecord.h"
	#include "records/SrCollrecord.h"
	#include "records/SrContrecord.h"
	#include "records/SrCpthrecord.h"
	#include "records/SrCstyrecord.h"
	#include "records/SrDebrrecord.h"
	#include "records/SrDialrecord.h"
	#include "records/SrDlbrrecord.h"
	#include "records/SrDlvwrecord.h"
	#include "records/SrDobjrecord.h"
	#include "records/SrDoorrecord.h"
	#include "records/SrDualrecord.h"
	#include "records/SrEcznrecord.h"
	#include "records/SrEfshrecord.h"
	#include "records/SrEnchrecord.h"
	#include "records/SrEquprecord.h"
	#include "records/SrExplrecord.h"
	#include "records/SrEyesrecord.h"
	#include "records/SrFactrecord.h"
	#include "records/SrFlorrecord.h"
	#include "records/SrFlstrecord.h"
	#include "records/SrFstprecord.h"
	#include "records/SrFstsrecord.h"
	#include "records/SrFurnrecord.h"
	#include "records/SrGlobrecord.h"
	#include "records/SrGmstrecord.h"
	#include "records/SrGrasrecord.h"
	#include "records/SrHazdrecord.h"
	#include "records/SrHdptrecord.h"
	#include "records/SrIdlerecord.h"
	#include "records/SrIdlmrecord.h"
	#include "records/SrImadrecord.h"
	#include "records/SrImgsrecord.h"
	#include "records/SrInforecord.h"
	#include "records/SrIngrrecord.h"
	#include "records/SrIpctrecord.h"
	#include "records/SrIpdsrecord.h"
	#include "records/SrKeymrecord.h"
	#include "records/SrKywdrecord.h"
	#include "records/SrLandrecord.h"
	#include "records/SrLcrtrecord.h"
	#include "records/SrLctnrecord.h"
	#include "records/SrLgtmrecord.h"
	#include "records/SrLighrecord.h"
	#include "records/SrLscrrecord.h"
	#include "records/SrLtexrecord.h"
	#include "records/SrLvlirecord.h"
	#include "records/SrLvlnrecord.h"
	#include "records/SrLvsprecord.h"
	#include "records/SrMatorecord.h"
	#include "records/SrMattrecord.h"
	#include "records/SrMesgrecord.h"
	#include "records/SrMgefrecord.h"
	#include "records/SrMiscrecord.h"
	#include "records/SrMovtrecord.h"
	#include "records/SrMsttrecord.h"
	#include "records/SrMuscrecord.h"
	#include "records/SrMustrecord.h"
	#include "records/SrNavirecord.h"
	#include "records/SrNavmrecord.h"
	#include "records/SrNpc_record.h"
	#include "records/SrOtftrecord.h"
	#include "records/SrPackrecord.h"
	#include "records/SrPerkrecord.h"
	#include "records/SrPgrerecord.h"
	#include "records/SrPhzdrecord.h"
	#include "records/SrProjrecord.h"
	#include "records/SrQustrecord.h"
	#include "records/SrRacerecord.h"
	#include "records/SrRefrrecord.h"
	#include "records/SrRegnrecord.h"
	#include "records/SrRelarecord.h"
	#include "records/SrRevbrecord.h"
	#include "records/SrRfctrecord.h"
	#include "records/SrScenrecord.h"
	#include "records/SrScrlrecord.h"
	#include "records/SrShourecord.h"
	#include "records/SrSlgmrecord.h"
	#include "records/SrSmbnrecord.h"
	#include "records/SrSmenrecord.h"
	#include "records/SrSmqnrecord.h"
	#include "records/SrSnctrecord.h"
	#include "records/SrSndrrecord.h"
	#include "records/SrSopmrecord.h"
	#include "records/SrSounrecord.h"
	#include "records/SrSpelrecord.h"
	#include "records/SrSpgdrecord.h"
	#include "records/SrStatrecord.h"
	#include "records/SrTactrecord.h"
	#include "records/SrTes4record.h"
	#include "records/SrTreerecord.h"
	#include "records/SrTxstrecord.h"
	#include "records/SrVtyprecord.h"
	#include "records/SrWatrrecord.h"
	#include "records/SrWeaprecord.h"
	#include "records/SrWooprecord.h"
	#include "records/SrWrldrecord.h"
	#include "records/SrWthrrecord.h"

	#include "groups/srfilegroup.h"

	#include "srrecordhandler.h"

	#include "../strings/srstringfile.h"

/*===========================================================================
 *		End of Required Includes
 *=========================================================================*/


/*===========================================================================
 *
 * Begin Definitions
 *
 *=========================================================================*/

	/* First automatic form ID used */
  #define SRESPFILE_FIRST_FORMID   0x1000
  #define SRESPFILE_FIRST_EDITORID 1
  #define SRESPFILE_LAST_EDITORID  900000000

	/* Default size of record maps */
  #define SRESPFILE_DEFAULT_MAPSIZE 1300001

/*===========================================================================
 *		End of Definitions
 *=========================================================================*/


/*===========================================================================
 *
 * Begin Class CSrEspFile Definition
 *
 * Handles a single ESP plugin file for Skyrim. An ESP is simply defined 
 * to be a collection of records and groups.
 *
 *=========================================================================*/
class CSrEspFile : public CSrRecordHandler {

  /*---------- Begin Private Class Members ----------------------*/
private:
  CSrFile			m_File;			/* File object used for I/O operations */
  CSString			m_Filename;		/* Filename as last loaded/saved */
  CSString			m_ShortFilename;

  CSrStringFile		 m_ILStringFile;
  CSrStringFile		 m_DLStringFile;
  CSrStringFile		 m_LStringFile;

  CSrStringFileMap	 m_StringMap;
  srlstringid_t		 m_NextStringID;

  byte				m_ModIndex;
  bool				m_IsActive;
  dword				m_CacheFlags;

  CSrFileGroup		m_Records;  		/* Collection of groups and records */
 
  CSrTes4Record*	m_pHeader;			/* Reference to the file header */

  CSrRecordHandler*	m_pParent;			/* Parent record handler */


  /*---------- Begin Protected Class Methods --------------------*/
protected:

    	/* Create a top level group record */
  bool          CreateTopLevelGroup (CSrBaseRecord* pNewRecord);
  CSrTypeGroup* CreateTopLevelGroup (const srrectype_t Type);

	/* Find a position to insert a top level group at */
  CSrBaseRecord* FindTopGroupInsertPos (const srrectype_t Type);

	/* Input/output helper methods */
  virtual bool Read  (CSrCallback* pCallback = NULL);
  virtual bool Write (CSrCallback* pCallback = NULL);

  virtual bool LoadStringFiles (CSrCallback* pCallback);
  virtual void MakeStringMap (CSrCallback* pCallback);
  virtual void MakeStringMap (CSrStringFile& StringFile, CSrCallback* pCallback);
  virtual bool LoadStringFile (CSrStringFile& StringFile, const SSCHAR* pFilename, CSrCallback* pCallback);
  virtual void LoadLocalStrings (CSrCallback* pCallback);

  bool SaveLocalStrings(const char* pFilename);

  void UpdateStringMap (CSrGroup* pGroup);
  void UpdateStringMap (CSrRecord* pRecord);

  dword UpdateFormCount (CSrGroup* pGroup);
  dword UpdateFormCount (void);


  /*---------- Begin Public Class Methods -----------------------*/
public:

	/* Class Constructors/Destructors */
  CSrEspFile();
  virtual ~CSrEspFile();
  virtual void Destroy (void);

	/* Add the given record to the file */
  virtual bool AddRecord (CSrRecord* pRecord);

	/* Add a master file definition */
  virtual void AddMaster (const SSCHAR* pMaster, const int64 FileSize) { if (m_pHeader != NULL) m_pHeader->AddMaster(pMaster, FileSize); }

	/* Change one ID for another */
  virtual dword ChangeFormID   (const srformid_t NewID, const srformid_t OldID) { return m_Records.ChangeFormID(NewID, OldID); }
  virtual dword ChangeEditorID (const SSCHAR*   pNewID, const SSCHAR*   pOldID) { return m_Records.ChangeEditorID(pNewID, pOldID); }
  
  	/* Create a new record of the given type to the file */
  virtual CSrRecord* CreateNewRecord (const srrectype_t Type); 

	/* Deletes the specified record */
  virtual bool DeleteRecord (CSrRecord* pRecord);

  	/* Find information in the record */
  virtual dword Find (srfinddata_t& FindData, CSrCallback* pCallback);

  CSString* FindLocalString (const srlstringid_t ID);

	/* Fixup the formids of all records in file */
  virtual bool FixupFormids (CSrFormidFixupArray& FixupArray) { return m_Records.FixupFormids(FixupArray); }

	/* Record interation methods */
  virtual int ForEachBaseRecord (SRBASERECORDCALLBACK Callback, const dword UserData, void* pUserPtr) { return m_Records.ForEachBaseRecord(Callback, UserData, pUserPtr); }
  virtual int ForEachRecord     (SRRECORDCALLBACK     Callback, const dword UserData, void* pUserPtr) { return m_Records.ForEachRecord(Callback, UserData, pUserPtr); }

	/* Access the top level groups/records */
  CSrBaseRecord* GetTopLevelRecord     (const dword Index) { return m_Records.GetRecord(Index); }
  dword          GetNumTopLevelRecords (void)              { return m_Records.GetNumRecords(); }

	/* Access groups */
  CSrTypeGroup* GetTypeGroup (const srrectype_t Type);

	/* Get class methods */
  CSrTes4Record*    GetHeader         (void) { return (m_pHeader); }
  const SSCHAR*     GetFilename       (void) { return (m_Filename); }
  const SSCHAR*     GetShortFilename  (void) { return (m_ShortFilename); }
  CSrRecordHandler* GetParent         (void) { return (m_pParent); }
  int			    GetRecordCount    (void) { return (m_pHeader ? m_pHeader->GetRecordCount() : 0); }
  byte				GetModIndex       (void) { return (m_ModIndex); }
  CSrFileGroup&     GetRecords        (void) { return (m_Records); }
  virtual CSrGroup* GetTopGroup       (void) { return (&m_Records); }
  dword				GetCacheFlags     (void) { return (m_CacheFlags); }
  bool				IsLocalStrings    (void) const { return m_pHeader == NULL ? false : m_pHeader->IsLocalStrings(); }
  const char*       GetModAuthor      (void) { return m_pHeader ? m_pHeader->GetAuthor() : "" ; }
  const char*		GetModDescription (void) { return m_pHeader ? m_pHeader->GetSummary() : "" ; }

    	/* Initialize a new file */
  void InitializeNew (void);

  virtual bool IsLoadLocalString (void) const { return IsLocalStrings(); }

	/* Main input/output methods */
  virtual bool Load (const SSCHAR* pFilename, CSrCallback* pCallback = NULL);
  virtual bool Save (const SSCHAR* pFilename, CSrCallback* pCallback = NULL);
  
	/* Set class members */
  void SetParent   (CSrRecordHandler* pParent) { m_pParent  = pParent; }
  void SetFilename (const SSCHAR*     pString) { m_Filename = pString;  m_ShortFilename = m_Filename;  m_ShortFilename.ReverseTruncateAtR("\\:/"); }
  void SetModIndex (const byte        Value)   { m_ModIndex = Value; }
  
  	/* CSrRecordHandler virtual methds, just pass onto parent handler */
  virtual CSrRecord* 	 FindFormID			(const srformid_t FormID)			{ return (m_pParent ? m_pParent->FindFormID(FormID) : NULL); }
  virtual CSrIdRecord*	 FindEditorID	    (const SSCHAR*    pString)			{ return (m_pParent ? m_pParent->FindEditorID(pString) : NULL); }
  virtual bool           GetEditorID	    (CSString& Buffer, const srformid_t FormID)	 { return (m_pParent ? m_pParent->GetEditorID(Buffer, FormID) : NULL); }
  virtual const SSCHAR*  GetEditorID	    (const srformid_t FormID)			{ return (m_pParent ? m_pParent->GetEditorID(FormID) : NULL); }
  virtual CSrRecord*	 GetFirstRecord     (SRMAPPOS& RecordPos)				{ return (m_pParent ? m_pParent->GetFirstRecord(RecordPos) : NULL); }
  virtual CSrRecord*	 GetNextRecord      (SRMAPPOS& RecordPos)				{ return (m_pParent ? m_pParent->GetNextRecord(RecordPos) : NULL); }
  virtual dword			 GetNumRecords      (void)								{ return (m_pParent ? m_pParent->GetNumRecords() : 0); }
  virtual srformid_t     GetFreeFormID      (const byte ModIndex = 0)			{ return (m_pParent ? m_pParent->GetFreeFormID(ModIndex) : 0); }
  virtual const SSCHAR*  GetFreeEditorID    (void)								{ return (m_pParent ? m_pParent->GetFreeEditorID() : ""); }
  virtual bool           IsActive           (void) const                        { return (m_IsActive); }
  virtual CSrRefrRecord* GetPlayerReference (void)                              { return (m_pParent ? m_pParent->GetPlayerReference() : NULL); }

		/* Set class members */
  void SetActive      (const bool  Value) { m_IsActive = Value; }
  void ModRecordCount (const int   Delta) { if (m_pHeader) m_pHeader->ModRecordCount(Delta); }
  void SetCacheFlags  (const dword Flags) { m_CacheFlags = Flags; }
  void SetLoadLocal   (const bool Value)  { if (m_pHeader) m_pHeader->SetLocalStrings(Value); }

  void SetModAuthor      (const char* pString) { if (m_pHeader) m_pHeader->SetAuthor(pString); }
  void SetModDescription (const char* pString) { if (m_pHeader) m_pHeader->SetSummary(pString); }

  void UpdateLoadLocalString (void);

  void UpdateStringMap (void);

};
/*===========================================================================
 *		End of Class CSrEspFile Definition
 *=========================================================================*/


/*===========================================================================
 *
 * Begin Type Definitions
 *
 *=========================================================================*/
  typedef CSrPtrArray<CSrEspFile>    CEspFileArray;
  typedef CSrRefPtrArray<CSrEspFile> CEspFileRefArray;

/*===========================================================================
 *		End of Type Definitions
 *=========================================================================*/


/*===========================================================================
 *
 * Begin Function Prototypes
 *
 *=========================================================================*/
  srreccreate_t* FindSrRecCreate (const srrectype_t Type);
  srreccreate_t* FindSrRecCreate (const SSCHAR*     pName);

  bool IsSrTopLevelGroup (const srrectype_t Type);
  
  extern const srrectype_t* s_TopLevelTypeOrder[];
  extern const srrectype_t* s_TopLevelTypes[];

/*===========================================================================
 *		End of Function Prototypes
 *=========================================================================*/
  

#endif
/*===========================================================================
 *		End of File SrEspfile.H
 *=========================================================================*/

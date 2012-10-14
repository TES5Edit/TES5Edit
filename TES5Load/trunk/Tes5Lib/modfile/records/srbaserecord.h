/*===========================================================================
 *
 * File:		Srbaserecord.H
 * Author:		Dave Humphrey (dave@uesp.net)
 * Created On:	26 November 2011
 *
 * Defines the CSrBaseRecord class from which all record and group classes
 * will be derived from.
 *
 *=========================================================================*/
#ifndef __SRBASERECORD_H
#define __SRBASERECORD_H


/*===========================================================================
 *
 * Begin Required Includes
 *
 *=========================================================================*/
  #include "../srmoddefs.h"
/*===========================================================================
 *		End of Required Includes
 *=========================================================================*/


/*===========================================================================
 *
 * Begin Definitions
 *
 *=========================================================================*/

	/* Group and record header size in bytes */
  #define SR_BASEHEADER_SIZE	24

/*===========================================================================
 *		End of Definitions
 *=========================================================================*/


/*===========================================================================
 *
 * Begin Type Definitions
 *
 *=========================================================================*/
#pragma pack(push, 1)

	/* Generic header for groups and records */
  struct srbaseheader_t 
  {
	srrectype_t	Type;		/* Record or group name field */
	dword		Size;		/* Record/group size */
	dword		Data1;		/* General data */
	int			GroupType;	/* Gives the basic group type */
	dword		Data2;		/* General data */
	word		Version;
	word		Unknown;
  };

#pragma pack(pop)

	/* Forward class definitions */
  class CSrRecordHandler;
  class CSrGroup;
  class CSrRecord;
  class CSrBaseRecord;

	/* Used for load/save callbacks */
  struct srespfilecallback_t 
  {
	float   Progress;
	int64   ProcessRecords;
	int64   TotalRecords;
	int		CallbackInterval;
	dword   UserData;
	void*   pUserPtr;
  };

	/* Array of record pointers */
  typedef CSrPtrArray<CSrBaseRecord>    CSrBaseRecordArray;
  typedef CSrRefPtrArray<CSrBaseRecord> CSrRefBaseRecordArray;

	/* Callback function type */
  typedef int (*FNSRESPFILECALLBACK) (srespfilecallback_t* pData);

	/* Record callbacks */
  typedef int (*SRBASERECORDCALLBACK) (CSrBaseRecord* pBaseRecord, const dword UserData, void* pUserPtr);
  typedef int (*SRRECORDCALLBACK)     (CSrRecord*     pRecord,     const dword UserData, void* pUserPtr);
  
/*===========================================================================
 *		End of Type Definitions
 *=========================================================================*/


/*===========================================================================
 *
 * Begin Abstract Class CSrBaseRecord Definition
 *
 * The base record/group class of a ESP/ESM file. All record and group
 * classes will be derived from this. 
 *
 *=========================================================================*/
class CSrBaseRecord {
  DECLARE_SRBASE(CSrBaseRecord)

  /*---------- Begin Protected Class Members --------------------*/
protected:
  CSrRecordHandler*	m_pParent;
  CSrGroup*			m_pParentGroup;

  word				m_CacheFlags;


  /*---------- Begin Protected Class Methods --------------------*/
protected:


  /*---------- Begin Public Class Methods -----------------------*/
public:

	/* Class Constructors/Destructors */
  CSrBaseRecord();
  virtual ~CSrBaseRecord();
  virtual void Destroy (void);

	/* Try to add a child record if valid */
  virtual bool AddChildRecord (CSrBaseRecord* pNewRecord) = 0;

  	/*  Change one ID for another */
  virtual dword ChangeFormID   (const srformid_t NewID, const srformid_t OldID) = 0;
  virtual dword ChangeEditorID (const SSCHAR*   pNewID, const SSCHAR*   pOldID) = 0;

	/* Try to delete a child record if valid */
  virtual bool DeleteChildRecord (CSrBaseRecord* pRecord) = 0;

	/* Find binary data in the record */
  virtual bool Search     (dword& FindCount, srfinddata_t& FindData, CSrCallback* pCallback = NULL) = 0;
  virtual bool SearchText (dword& FindCount, srfinddata_t& FindData, CSrCallback* pCallback = NULL) = 0;

	/* Find child records */
  virtual CSrBaseRecord* FindFormID (const srformid_t FormID) = 0;

	/* Fixup the modindex of formids */
  virtual bool FixupFormids (CSrFormidFixupArray& FixupArray) = 0;

	/* Get class members */
  virtual const srrectype_t GetRecordType  (void) const = 0;
  virtual       srformid_t  GetFormID      (void) const { return (SR_FORMID_NULL); }
  CSrRecordHandler*         GetParent      (void)       { return (m_pParent); }
  CSrGroup*                 GetParentGroup (void)       { return (m_pParentGroup); }
  word						GetCacheFlags  (void)       { return (m_CacheFlags); }
	
	/* Initialize the record with the given data */
  virtual void Initialize (const srbaseheader_t Header) = 0;

  	/* Initialize a new record */
  virtual void InitializeNew (void) = 0;

  	/* Object classifiers */
  virtual bool IsRecord (void) const { return (false); }
  virtual bool IsGroup  (void) const { return (false); }
  virtual bool IsActive (void) const;

  virtual void LoadLocalStrings (CSrCallback* pCallback) = 0;

	/* Input/output record/group data from file */
  virtual bool ReadData (CSrFile& File) = 0;
  virtual bool Write    (CSrFile& File) = 0;

	/* Input/output with callback, default is to ignore callback */
  virtual bool ReadData      (CSrFile& File, CSrCallback* pCallback) { return ReadData(File); }
  virtual bool Write         (CSrFile& File, CSrCallback* pCallback) { return Write(File); }

	/* Set class members */
  void SetParent      (CSrRecordHandler* pHandler) { m_pParent      = pHandler; }
  void SetParentGroup (CSrGroup*         pGroup)   { m_pParentGroup = pGroup; }
  void SetCacheFlags  (const dword       Flags)    { m_CacheFlags   = Flags; }

};
/*===========================================================================
 *		End of Class CSrBaseRecord Definition
 *=========================================================================*/


/*===========================================================================
 *
 * Begin Function Definitions
 *
 *=========================================================================*/

  bool ReadSrBaseHeader (CSrFile& File, srbaseheader_t& Header);

	/* Record and group creation functions */
  CSrRecord*     CreateSrRecord      (const srbaseheader_t Header);
  CSrRecord*     CreateSrRecord      (const srrectype_t    Type);
  CSrGroup*      CreateSrGroup       (const srbaseheader_t Header);
  CSrGroup*      CreateSrGroup       (const int Type);
  CSrGroup*      CreateSrRefGroup    (const int Type);
  CSrBaseRecord* CreateSrRecordGroup (const srbaseheader_t Header);

/*===========================================================================
 *		End of Function Definitions
 *=========================================================================*/

	
#endif
/*===========================================================================
 *		End of File Srbaserecord.H
 *=========================================================================*/

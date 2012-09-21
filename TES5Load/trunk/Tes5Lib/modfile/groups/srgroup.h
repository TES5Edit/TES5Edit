/*===========================================================================
 *
 * File:		Srgroup.H
 * Author:		Dave Humphrey (dave@uesp.net)
 * Created On:	26 November 2011
 *
 * Defines the CSrGroup class from which all other group classes will
 * be derived from.
 *
 *=========================================================================*/
#ifndef __SRGROUP_H
#define __SRGROUP_H


/*===========================================================================
 *
 * Begin Required Includes
 *
 *=========================================================================*/
  #include "../../common/srerrorhandler.h"
  #include "../subrecords/srsubrecord.h"
  #include "../records/srbaserecord.h"
  #include "../records/srbasereccont.h"
/*===========================================================================
 *		End of Required Includes
 *=========================================================================*/


/*===========================================================================
 *
 * Begin Definitions 
 *
 *=========================================================================*/

	/* Group types */
  #define SR_GROUP_NONE			-1		/* Custom type, not official used */
  #define SR_GROUP_TYPE			0
  #define SR_GROUP_WORLDCHILD	1
  #define SR_GROUP_INTCELL		2
  #define SR_GROUP_INTSUBCELL	3
  #define SR_GROUP_EXTCELL		4
  #define SR_GROUP_EXTSUBCELL	5
  #define SR_GROUP_CELLCHILD	6
  #define SR_GROUP_TOPICCHILD	7
  #define SR_GROUP_CELLPERSIST	8
  #define SR_GROUP_CELLTEMP		9
  #define SR_GROUP_CELLDISTANT	10

/*===========================================================================
 *		End of Definitions 
 *=========================================================================*/


/*===========================================================================
 *
 * Begin Type Definitions
 *
 *=========================================================================*/
#pragma pack(push, 1)

	/* Group header data that depends on the group type */
  union srgrupheaderdata_t 
  {
	char	ContainsType[SR_RECTYPE_SIZE];
	int		Block;

	struct {
		short XGrid;
		short YGrid;
	};

	dword ParentFormID;
  };

	/* Group header type */
  struct srgrupheader_t 
  {
	srrectype_t			RecordType;		/* Must be 'GRUP' */
	dword				Size;
	srgrupheaderdata_t	Data;
	int					GroupType;
	dword				Stamp;
	word				Version;
	word				Unknown;

		/* Copy operators */
	const srgrupheader_t& operator= (const srbaseheader_t Header) { *this = *(srgrupheader_t *) &Header; return (*this); }
  };

#pragma pack(pop)

	/* Pointer to a class method to create a record object */
  class CSrGroup;
  class CSrTypeGroup;
  typedef CSrGroup* (*SRGROUP_CREATEFUNC) (void);

	/* Structure to hold creation information on groups */
  struct srgroupcreate_t 
  {
	int					GroupType;		/* Group type */
	SRGROUP_CREATEFUNC	CreateMethod;	/* The creation function or static method */
  };

	/* Arrays of groups */
  typedef CSrPtrArray<CSrGroup>    CSrGroupArray;
  typedef CSrRefPtrArray<CSrGroup> CSrRefGroupArray;

/*===========================================================================
 *		End of Type Definitions
 *=========================================================================*/


/*===========================================================================
 *
 * Begin Class CSrGroup Definition
 *
 * Description
 *
 *=========================================================================*/
class CSrGroup : public CSrBaseRecord {
  DECLARE_SRCLASS(CSrGroup, CSrBaseRecord)

  /*---------- Begin Protected Class Members --------------------*/
protected:
  srgrupheader_t	 m_Header;

  CSrBaseRecordContBase* m_pRecords;		/* Child records and groups */
  bool					 m_IsReferenced;


  /*---------- Begin Protected Class Methods --------------------*/
protected:

	/* Helper input/output methods */
  bool WriteGroupSize (CSrFile& File, const dword Offset);

  
  /*---------- Begin Public Class Methods -----------------------*/
public:

	/* Class Constructors/Destructors */
  CSrGroup(const bool UseRef = false);
  virtual ~CSrGroup();
  virtual void Destroy (void);

	/* Attempt to add a child record (undefined for a base group) */
  virtual bool AddChildRecord (CSrBaseRecord* ) { return (false); }

	/* Add a record that may already exist in the group */
  bool AddExistingRecord (CSrRecord* pNewRecord);

	/* Simply adds the given record */
  void AddRecord (CSrRecord* pRecord) { m_pRecords->Add((CSrBaseRecord *) pRecord); }
   
	/* Change one ID for another */
  virtual dword ChangeFormID   (const srformid_t NewID, const srformid_t OldID);
  virtual dword ChangeEditorID (const SSCHAR*   pNewID, const SSCHAR*   pOldID);

	/* Compares a group to see if it is the same type */
  virtual bool Compare (CSrGroup* pGroup);

  	/* Return a new instance of the class */
  static CSrGroup* Create (void) { return new CSrGroup; }

	/* Creates a new matching subgroup */
  CSrGroup* CreateSubGroup (CSrGroup* pMatchGroup);

  	/* Delete a child record */
  virtual bool DeleteChildRecord (CSrBaseRecord* pRecord) { return m_pRecords->Delete(pRecord); }

  	/* Simply deletes the given record */
  bool DeleteRecord (CSrRecord* pRecord) { return m_pRecords->Delete((CSrBaseRecord *) pRecord); }
     
	/* Find information in the record */
  virtual bool Search     (dword& FindCount, srfinddata_t& FindData, CSrCallback* pCallback = NULL);
  virtual bool SearchText (dword& FindCount, srfinddata_t& FindData, CSrCallback* pCallback = NULL);

  	/* Find a child record based on its formID */
  CSrBaseRecord* FindFormID (const srformid_t FormID);

	/* Find child groups based on type and content */
  CSrGroup* FindFirstGroup (const srformid_t FormID, int& GroupPos) { GroupPos = -1; return FindNextGroup(FormID, GroupPos); }
  CSrGroup* FindNextGroup  (const srformid_t FormID, int& GroupPos);

	/* Find a matching subgroup */
  CSrGroup* FindSubGroup (CSrGroup* pMatchGroup);

  	/* Fixup the modindex of formids */
  virtual bool FixupFormids (CSrFormidFixupArray& FixupArray);

  	/* Record interation methods */
  int ForEachBaseRecord (SRBASERECORDCALLBACK Callback, const dword UserData, void* pUserPtr);
  int ForEachRecord     (SRRECORDCALLBACK     Callback, const dword UserData, void* pUserPtr);

	/* Get class members */
  const srrectype_t      GetRecordType (void) const { return (m_Header.RecordType); }
  int			         GetType       (void) const { return (m_Header.GroupType); }
  dword				     GetStamp      (void) const { return (m_Header.Stamp); }
  bool                   IsGroup       (void) const { return (true); }
  srgrupheader_t&        GetHeader     (void)       { return (m_Header); }
  dword				 	 GetNumRecords (void)              { return (m_pRecords->GetSize()); }
  CSrBaseRecord*         GetRecord     (const dword Index) { return (m_pRecords->GetAt(Index)); }
  CSrBaseRecordContBase& GetRecords    (void)       { return (*m_pRecords); }

  	/* Access groups */
  CSrTypeGroup* GetTypeGroup (const srrectype_t Type);
    	
  	/* Initialize the record with the given header */
  virtual void Initialize (const srbaseheader_t Header) { m_Header = Header; }
  virtual void Initialize (const int            Type)   { m_Header.RecordType = SR_NAME_GRUP; m_Header.GroupType = Type; m_Header.Size = 0; m_Header.Stamp = 0; m_Header.Data.ParentFormID = 0; }

  	/* Initialize a new file */
  virtual void InitializeNew (void) { }

  virtual void LoadLocalStrings (CSrCallback* pCallback);

	/* Read in group data */
  virtual bool ReadData (CSrFile& File) { return ReadData(File, NULL); }
  virtual bool ReadData (CSrFile& File, CSrCallback* pCallback);

  	/* Output the group to a file */
  virtual bool Write (CSrFile& File) { return Write(File, NULL); }
  virtual bool Write (CSrFile& File, CSrCallback* pCallback);

  virtual void UpdateLoadLocalString (const bool LoadLocal);

};
/*===========================================================================
 *		End of Class CSrGroup Definition
 *=========================================================================*/


/*===========================================================================
 *
 * Begin Class CSrRefGroup Definition
 *
 *=========================================================================*/
class CSrRefGroup : public CSrGroup {

public:

  CSrRefGroup() : CSrGroup(true) { }

  	/* Return a new class instance */
  static CSrGroup* Create (void) { return (new CSrRefGroup); }

};
/*===========================================================================
 *		End of Class CSrRefGroup Definition
 *=========================================================================*/


#endif
/*===========================================================================
 *		End of File Srgroup.H
 *=========================================================================*/

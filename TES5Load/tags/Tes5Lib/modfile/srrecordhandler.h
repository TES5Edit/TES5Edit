/*===========================================================================
 *
 * File:		Srrecordhandler.H
 * Author:		Dave Humphrey (dave@uesp.net)
 * Created On:	26 November 2011
 *
 * Abstract base class for handling a set of records.
 *
 *=========================================================================*/
#ifndef __SRRECORDHANDLER_H
#define __SRRECORDHANDLER_H


/*===========================================================================
 *
 * Begin Required Includes
 *
 *=========================================================================*/
  #include "records/sridrecord.h"
  #include "records/srkywdrecord.h"
  #include "records/srrefrrecord.h"
  #include "groups/srtypegroup.h"
  #include "records/srrecordmap.h"
/*===========================================================================
 *		End of Required Includes
 *=========================================================================*/


/*===========================================================================
 *
 * Begin Definitions
 *
 *=========================================================================*/

	/* Return values from OnPre/OnPostSave events */
  #define SR_RESULT_USERABORT		-101
  #define SR_RESULT_ERROR		-1
  #define SR_RESULT_OK			0
  #define SR_RESULT_WARNING		1
  #define SR_RESULT_PROMPTRENAMECOPY	1000

/*===========================================================================
 *		End of Definitions
 *=========================================================================*/


/*===========================================================================
 *
 * Begin Type Definitions
 *
 *=========================================================================*/

	/* Used to edit and update edited records */
  struct sreditrecinfo_t 
  {
	CSrRecord*	pOldRecord;		/* Initial version of the record */
	CSrRecord*	pNewRecord;		/* Updated version of the record */
	CSrRecord*	pRecordCopy;		/* Copy of the old record if available (for undo) */

	CSString	NewEditorID;		/* New editorid if changed */
	bool		HasUpdatedID;

	bool		IsNew;			/* Indicates a newly created record */
	bool		IsRenamed;		/* A record with a changed editorid that has been renamed */
	bool		IsCopy;			/* A record with a changed editorid that has been copied */

	bool		IsHandled;
	bool		NeedsIndex;

	sreditrecinfo_t() {
		pOldRecord  = NULL;
		pNewRecord  = NULL;
		pRecordCopy = NULL;

		HasUpdatedID = false;
		IsNew	     = false;
		IsRenamed    = false;
		IsCopy	     = false;
		IsHandled    = false;
		NeedsIndex   = false;
	}
  };

/*===========================================================================
 *		End of Type Definitions
 *=========================================================================*/


/*===========================================================================
 *
 * Begin Class CSrRecordHandler Definition
 *
 * Description
 *
 *=========================================================================*/
class CSrRecordHandler {

  /*---------- Begin Protected Class Members --------------------*/
protected:


  /*---------- Begin Protected Class Methods --------------------*/
protected:


  /*---------- Begin Public Class Methods -----------------------*/
public:

	/* Class Constructors/Destructors */
  //virtual void Destroy (void) = 0;

  	/* Change one ID for another */
  //virtual dword ChangeFormID   (const srformid_t NewID, const srformid_t OldID) = 0;
  //virtual dword ChangeEditorID (const SSCHAR*   pNewID, const SSCHAR*   pOldID) = 0;

  	/* Create a new record of the given type to the file */
  //virtual CSrRecord* CreateNewRecord (const srrectype_t Type) = 0;

  	/* Deletes the specified record */
  //virtual bool DeleteRecord (CSrRecord* pRecord) = 0;

  	/* Find data operations */
  //virtual dword Find (srfinddata_t& FindData, CSrCallback* pCallback) = 0;

  	/* Find records */
  virtual CSrRecord*   FindFormID   (const srformid_t FormID)  = 0;
  virtual CSrIdRecord* FindEditorID (const SSCHAR*    pString) = 0;

  virtual CSrRecord* FindGeneralID (const SSCHAR* pString)
  {
	  CSString TmpName(pString);
	  TmpName.Trim();

	  CSrRecord* pRecord = FindEditorID(TmpName);
	  if (pRecord != NULL) return pRecord;

	  dword Value = strtoul(TmpName, NULL, 0);
	  if (Value == 0) return NULL;
	  return FindFormID((srformid_t) Value);
  }

  virtual srformid_t FindGeneralFormID (const SSCHAR* pString, const bool Validate = false)
  {
	  CSString TmpName(pString);
	  TmpName.Trim();

	  CSrRecord* pRecord = FindEditorID(TmpName);
	  if (pRecord != NULL) return pRecord->GetFormID();

	  dword Value = strtoul(TmpName, NULL, 0);
	  if (Validate && FindFormID((srformid_t) Value) == NULL) return SR_FORMID_NULL;
	  return Value;
  }

  virtual CSrKywdRecord* FindKeyword (CSrFormidArray& FormIDs, const SSCHAR* pPrefix) 
  {
	if (pPrefix == NULL) return NULL;

	CSrRecord* pRecord;
	CSrKywdRecord* pKeyword;
	size_t PrefixLength = strlen(pPrefix);

	for (dword i = 0; i < FormIDs.GetSize(); ++i)
	{
		pRecord = FindFormID(FormIDs[i]);
		pKeyword = SrCastClassNull(CSrKywdRecord, pRecord);
		if (pKeyword == NULL) continue;

		if (strnicmp(pKeyword->GetEditorID(), pPrefix, PrefixLength) == 0) return pKeyword;
	}

	return NULL;
  }

	virtual CSString* FindLocalString (const srlstringid_t ID) = 0;

	const char* GetEditorID (CSrFormidSubrecord* pSubrecord)
	{
		if (pSubrecord == NULL) return NULL;
		return GetEditorID(pSubrecord->GetValue());
	}

	/* Get the editorID from a formID */
  virtual bool          GetEditorID (CSString& Buffer, const srformid_t FormID) = 0;
  virtual const SSCHAR* GetEditorID (const srformid_t FormID) = 0;

	/* Iterate through records/groups */
  virtual CSrRecord* GetFirstRecord (SRMAPPOS& RecordPos) = 0;
  virtual CSrRecord* GetNextRecord  (SRMAPPOS& RecordPos) = 0;
  virtual dword      GetNumRecords  (void) = 0;
  virtual CSrGroup*  GetTopGroup    (void) = 0;
  virtual CSrRecordHandler* GetParent (void) { return NULL; }

  	/* Returns the next form ID not currently used by the file */
  virtual srformid_t    GetFreeFormID   (const byte ModIndex = 0) = 0;
  virtual const SSCHAR* GetFreeEditorID (void) = 0;

	/* Access the special player reference */
  virtual CSrRefrRecord* GetPlayerReference (void) = 0;

	/* Is the parent the active file or not */
  virtual bool IsActive (void) const = 0;

  virtual bool IsLoadLocalString (void) const { return false; }

  	/* Events that occurs before/after a record is updated */
  virtual int OnPreSaveRecord    (sreditrecinfo_t& EditInfo) { return (SR_RESULT_OK); }
  virtual int OnPostSaveRecord   (sreditrecinfo_t& EditInfo) { return (SR_RESULT_OK); }
  virtual int OnCancelEditRecord (sreditrecinfo_t& EditInfo) { return (SR_RESULT_OK); }

  	/* Creates any required indexes */
  //virtual void IndexRecord  (CSrRecord*     pRecord) = 0;
  //virtual bool IndexRecords (CSrCallback* pCallback) = 0;

};
/*===========================================================================
 *		End of Class CSrRecordHandler Definition
 *=========================================================================*/


#endif
/*===========================================================================
 *		End of File Srrecordhandler.H
 *=========================================================================*/

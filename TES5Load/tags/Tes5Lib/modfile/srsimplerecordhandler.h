/*===========================================================================
 *
 * File:		Srsimplerecordhandler.H
 * Author:		Dave Humphrey (dave@uesp.net)
 * Created On:	26 November 2011
 *
 * Handles a single file of records.
 *
 *=========================================================================*/
#ifndef __SRSIMPLERECORDHANDLER_H
#define __SRSIMPLERECORDHANDLER_H


/*===========================================================================
 *
 * Begin Required Includes
 *
 *=========================================================================*/
  #include "srrecordhandler.h"
  #include "srespfile.h"
  #include "../common/srarray.h"
/*===========================================================================
 *		End of Required Includes
 *=========================================================================*/


/*===========================================================================
 *
 * Begin Class CSrSimpleRecordHandler Definition
 *
 * Description
 *
 *=========================================================================*/
class CSrSimpleRecordHandler : public CSrRecordHandler 
{

  /*---------- Begin Protected Class Members --------------------*/
protected:
  CSrEspFile			 m_EspFile;		/* The single file */

  CSrFullFormIdRecordMap m_FormIdMap;		/* Fast lookup maps */
  CSrEditorIdRecordMap	 m_EditorIdMap;

  dword					m_NextFreeFormID;	/* Used to find a free ID */
  dword					m_NextFreeEditorID;

  CSrRefrRecord			m_PlayerRef;		/* Special pseudo-records */


  /*---------- Begin Protected Class Methods --------------------*/
protected:


  /*---------- Begin Public Class Methods -----------------------*/
public:

	/* Class Constructors/Destructors */
  CSrSimpleRecordHandler (const dword HashMapSize = SRESPFILE_DEFAULT_MAPSIZE);
  virtual ~CSrSimpleRecordHandler() { Destroy(); }
  virtual void Destroy (void);

  	/* Change one ID for another */
  virtual dword ChangeFormID   (const srformid_t NewID, const srformid_t OldID) { return m_EspFile.ChangeFormID(NewID, OldID); }
  virtual dword ChangeEditorID (const SSCHAR*   pNewID, const SSCHAR*   pOldID) { return m_EspFile.ChangeEditorID(pNewID, pOldID); }

  	/* Create a new record of the given type to the file */
  CSrRecord* CreateNewRecord (const srrectype_t Type);

  	/* Deletes the specified record */
  virtual bool DeleteRecord (CSrRecord* pRecord);

  	/* Find data operations */
  virtual dword Find (srfinddata_t& FindData, CSrCallback* pCallback) { return m_EspFile.Find(FindData, pCallback); }

  	/* Find records */
  virtual CSrRecord*   FindFormID   (const srformid_t FormID);
  virtual CSrIdRecord* FindEditorID (const SSCHAR*    pString);

  virtual CSString* FindLocalString (const srlstringid_t ID) { return m_EspFile.FindLocalString(ID); }

	/* Get the editorID from a formID */
  virtual bool          GetEditorID (CSString& Buffer, const srformid_t FormID);
  virtual const SSCHAR* GetEditorID (const srformid_t FormID);

  	/* Iterate through records/groups */
  virtual CSrRecord* GetFirstRecord (SRMAPPOS& RecordPos) { return m_FormIdMap.GetFirstRecord(RecordPos); }
  virtual CSrRecord* GetNextRecord  (SRMAPPOS& RecordPos) { return m_FormIdMap.GetNextRecord(RecordPos); }
  virtual dword      GetNumRecords  (void)                { return m_FormIdMap.GetRecordCount(); }
  virtual CSrGroup*  GetTopGroup    (void)				  { return &m_EspFile.GetRecords(); }

	/* Get the next available formID that is not currently in use */
  virtual srformid_t    GetFreeFormID   (const byte ModIndex = 0);
  virtual const SSCHAR* GetFreeEditorID (void);

	/* Get class members */
  CSrEspFile&    GetEspFile         (void) { return (m_EspFile); }
  CSrRefrRecord* GetPlayerReference (void) { return (&m_PlayerRef); }

	/* Adds the given record to the record indexes */
  virtual void IndexRecord  (CSrRecord*     pRecord);
  virtual bool IndexRecords (CSrCallback* pCallback);

	/* Is the parent the active file or not */
  virtual bool IsActive (void) const { return (true); }

	/* Load the given file */
  bool Load (const SSCHAR* pFilename, CSrCallback* pCallback = NULL);

};
/*===========================================================================
 *		End of Class CSrSimpleRecordHandler Definition
 *=========================================================================*/


#endif
/*===========================================================================
 *		End of File Srsimplerecordhandler.H
 *=========================================================================*/

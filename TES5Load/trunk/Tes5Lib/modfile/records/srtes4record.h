/*===========================================================================
 *
 * File:		Srtes4record.H
 * Author:		Dave Humphrey (dave@uesp.net)
 * Created On:	26 November 2911
 *
 * Defines the CSrTes4Record containing the header data for an ESM/ESP file.
 *
 *=========================================================================*/
#ifndef __SRTES4RECORD_H
#define __SRTES4RECORD_H


/*===========================================================================
 *
 * Begin Required Includes
 *
 *=========================================================================*/
  #include "srrecord.h"
  #include "../subrecords/srhedrsubrecord.h"
  #include "../subrecords/srstringsubrecord.h"
  #include "../subrecords/srint64subrecord.h"
/*===========================================================================
 *		End of Required Includes
 *=========================================================================*/


/*===========================================================================
 *
 * Begin Type Definitions
 *
 *=========================================================================*/
/*===========================================================================
 *		End of Type Definitions
 *=========================================================================*/


/*===========================================================================
 *
 * Begin Class CSrTes4Record Definition
 *
 * Description
 *
 *=========================================================================*/
class CSrTes4Record : public CSrRecord 
{
  DECLARE_SRSUBRECCREATE()
  DECLARE_SRFIELDMAP()
  DECLARE_SRCLASS(CSrTes4Record, CSrRecord)

  /*---------- Begin Private Class Members ----------------------*/
private:
  CSrHedrSubrecord*		m_pHeader;
  CSrStringSubrecord*	m_pCreatedBy;
  CSrStringSubrecord*	m_pSummary;


  /*---------- Begin Protected Class Methods --------------------*/
protected:


  /*---------- Begin Public Class Methods -----------------------*/
public:

	/* Class Constructors/Destructors */
  CSrTes4Record();
  //virtual ~CSrTes4Record() { Destroy(); }
  virtual void Destroy (void);

	/* Add a master file */
  void AddMaster (const SSCHAR* pMaster, const int64 FileSize);

	/* Return a new instance of the class */
  static CSrRecord* Create (void) { return new CSrTes4Record; }

	/* Delete all master definitions in the file */
  void DeleteMasters (void);

	/* Get class data */
  const SSCHAR* GetAuthor		(void) { return (m_pCreatedBy ? m_pCreatedBy->GetString().c_str()   : ""); }
  const SSCHAR* GetSummary		(void) { return (m_pSummary   ? m_pSummary->GetString().c_str()     : ""); }
  int			GetRecordCount		(void) { return (m_pHeader    ? m_pHeader->GetRecordCount()			: 0); }
  float			GetVersion			(void) { return (m_pHeader    ? m_pHeader->GetVersion()				: 0.0f); }
  dword			GetNextObjectId		(void) { return (m_pHeader    ? m_pHeader->GetNextObjectId()		: 0); }

	/* Initialize a new record */
  void InitializeNew (void);

	/* Called to alert record of a new subrecord being added */
  virtual void OnAddSubrecord    (CSrSubrecord* pSubrecord);
  virtual void OnDeleteSubrecord (CSrSubrecord* pSubrecord);

	/* Modify the record count value */
  void ModRecordCount (const int Value) { if (m_pHeader != NULL) m_pHeader->ModRecordCount(Value); }

	/* Set class members */
  void SetVersion      (const float  Value) { if (m_pHeader) m_pHeader->SetVersion(Value); }
  void SetNextObjectId (const dword  Value) { if (m_pHeader) m_pHeader->SetNextObjectId(Value); }
  void SetRecordCount  (const int    Value) { if (m_pHeader) m_pHeader->SetRecordCount(Value); }

  void SetAuthor  (const SSCHAR* pString);
  void SetSummary (const SSCHAR* pString);

	/* Begin field method definitions */
  DECLARE_SRGETFIELD(GetFieldSummary)
  DECLARE_SRGETFIELD(GetFieldAuthor)
  DECLARE_SRGETFIELD(GetFieldVersion)
  DECLARE_SRGETFIELD(GetFieldRecordCount)
  DECLARE_SRGETFIELD(GetFieldNextObjectId)

  DECLARE_SRCOMPFIELD(CompareFieldSummary)
  DECLARE_SRCOMPFIELD(CompareFieldAuthor)
  DECLARE_SRCOMPFIELD(CompareFieldVersion)
  DECLARE_SRCOMPFIELD(CompareFieldRecordCount)
  DECLARE_SRCOMPFIELD(CompareFieldNextObjectId)

  DECLARE_SRSETFIELD(SetFieldSummary)
  DECLARE_SRSETFIELD(SetFieldAuthor)
};
/*===========================================================================
 *		End of Class CSrTes4Record Definition
 *=========================================================================*/


#endif
/*===========================================================================
 *		End of File Srtes4record.H
 *=========================================================================*/

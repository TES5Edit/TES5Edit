/*===========================================================================
 *
 * File:		Srtes4record.CPP
 * Author:		Dave Humphrey (dave@uesp.net)
 * Created On:	26 November 2011
 *
 * Description
 *
 *=========================================================================*/

	/* Include Files */
#include "srtes4record.h"


/*===========================================================================
 *
 * Begin Subrecord Creation Array
 *
 *=========================================================================*/
BEGIN_SRSUBRECCREATE(CSrTes4Record, CSrRecord)
	DEFINE_SRSUBRECCREATE(SR_NAME_HEDR, CSrHedrSubrecord::Create)
	DEFINE_SRSUBRECCREATE(SR_NAME_CNAM, CSrStringSubrecord::Create)
	DEFINE_SRSUBRECCREATE(SR_NAME_SNAM, CSrStringSubrecord::Create)
	DEFINE_SRSUBRECCREATE(SR_NAME_MAST, CSrStringSubrecord::Create)
	DEFINE_SRSUBRECCREATE(SR_NAME_DATA, CSrInt64Subrecord::Create)
	DEFINE_SRSUBRECCREATE(SR_NAME_INTV, CSrDwordSubrecord::Create)
END_SRSUBRECCREATE()
/*===========================================================================
 *		End of Subrecord Creation Array
 *=========================================================================*/


/*===========================================================================
 *
 * Begin CSrRecord Field Map
 *
 *=========================================================================*/
BEGIN_SRFIELDMAP(CSrTes4Record, CSrRecord)
	ADD_SRFIELDMAP("Summary",  SR_FIELD_SUMMARY,		0,			&CSrTes4Record::GetFieldSummary,		&CSrTes4Record::SetFieldSummary,&CSrTes4Record::CompareFieldSummary)
	ADD_SRFIELDMAP("Author",   SR_FIELD_AUTHOR,			0,			&CSrTes4Record::GetFieldAuthor,			&CSrTes4Record::SetFieldAuthor,	&CSrTes4Record::CompareFieldAuthor)
	ADD_SRFIELDMAP("Version",  SR_FIELD_VERSION,		SRRF_NOCSV, &CSrTes4Record::GetFieldVersion,		NULL,							&CSrTes4Record::CompareFieldVersion)
	ADD_SRFIELDMAP("Records",  SR_FIELD_RECORDCOUNT,	SRRF_NOCSV, &CSrTes4Record::GetFieldRecordCount,	NULL,							&CSrTes4Record::CompareFieldRecordCount)
	ADD_SRFIELDMAP("FileType", SR_FIELD_NEXTOBJECTID,   SRRF_NOCSV, &CSrTes4Record::GetFieldNextObjectId,	NULL,							&CSrTes4Record::CompareFieldNextObjectId)
END_SRFIELDMAP()
/*===========================================================================
 *		End of CSrRecord Field Map
 *=========================================================================*/


/*===========================================================================
 *
 * Class CSrTes4Record Constructor
 *
 *=========================================================================*/
CSrTes4Record::CSrTes4Record ()
{
  m_pHeader    = NULL;
  m_pCreatedBy = NULL;
  m_pSummary   = NULL;
}
/*===========================================================================
 *		End of Class CSrTes4Record Constructor
 *=========================================================================*/


/*===========================================================================
 *
 * Class CSrTes4Record Method - void Destroy (void);
 *
 *=========================================================================*/
void CSrTes4Record::Destroy (void)
{
  m_pHeader    = NULL;
  m_pCreatedBy = NULL;
  m_pSummary   = NULL;

  CSrRecord::Destroy();
}
/*===========================================================================
 *		End of Class Method CSrTes4Record::Destroy()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CSrTes4Record Method - void AddMaster (pMaster, Size);
 *
 *=========================================================================*/
void CSrTes4Record::AddMaster (const SSCHAR* pMaster, const int64 Size)
{
  CSrSubrecord*        pSubrecord;
  CSrStringSubrecord*  pMast;
  CSrInt64Subrecord*   pData;

	/* Set the master filename */
  pSubrecord = AddNewSubrecord(SR_NAME_MAST);
  pSubrecord->InitializeNew();

  pMast = SrCastClass(CSrStringSubrecord, pSubrecord);
  if (pMast != NULL) pMast->SetString(pMaster);

	/* Add the master data subrecord */
  pSubrecord = AddNewSubrecord(SR_NAME_DATA);
  pSubrecord->InitializeNew();

  pData = SrCastClass(CSrInt64Subrecord, pSubrecord);
  if (pData != NULL) pData->SetValue(Size);
  
 }
/*===========================================================================
 *		End of Class Method CSrTes4Record::AddMaster()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CSrTes4Record Method - void DeleteMasters (void);
 *
 * Deletes all masters from the header.
 *
 *=========================================================================*/
void CSrTes4Record::DeleteMasters (void)
{
  DeleteSubrecords(SR_NAME_MAST);
  DeleteSubrecords(SR_NAME_DATA);
}
/*===========================================================================
 *		End of Class Method CSrTes4Record::DeleteMasters()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CSrTes4Record Method - void InitializeNew (void);
 *
 *=========================================================================*/
void CSrTes4Record::InitializeNew (void)
{
  CSrRecord::InitializeNew();
  
  m_Header.Version = 40;
  m_Header.Flags2  = 1;

  AddNewSubrecord(SR_NAME_HEDR);
  if (m_pHeader != NULL) m_pHeader->InitializeNew();

  AddNewSubrecord(SR_NAME_CNAM);

  if (m_pCreatedBy != NULL)
  {
    m_pCreatedBy->InitializeNew();
    m_pCreatedBy->SetString("Unknown");
  }

}
/*===========================================================================
 *		End of Class Method CSrTes4Record::InitializeNew()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CSrTes4Record Event - void OnAddSubrecord (pSubrecord);
 *
 *=========================================================================*/
void CSrTes4Record::OnAddSubrecord (CSrSubrecord* pSubrecord) 
{

  if (pSubrecord->GetRecordType() == SR_NAME_HEDR)
    m_pHeader = SrCastClass(CSrHedrSubrecord, pSubrecord);
  else if (pSubrecord->GetRecordType() == SR_NAME_CNAM)
    m_pCreatedBy = SrCastClass(CSrStringSubrecord, pSubrecord);
  else if (pSubrecord->GetRecordType() == SR_NAME_SNAM)
    m_pSummary = SrCastClass(CSrStringSubrecord, pSubrecord);
  else
    CSrRecord::OnAddSubrecord(pSubrecord);

 }
/*===========================================================================
 *		End of Class Event CSrTes4Record::OnAddSubrecord()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CSrTes4Record Event - void OnDeleteSubrecord (pSubrecord);
 *
 *=========================================================================*/
void CSrTes4Record::OnDeleteSubrecord (CSrSubrecord* pSubrecord) {

  if (m_pHeader == pSubrecord)
    m_pHeader = NULL;
  else if (m_pCreatedBy == pSubrecord)
    m_pCreatedBy = NULL;
  else if (m_pSummary == pSubrecord)
    m_pSummary = NULL;
  else
    CSrRecord::OnDeleteSubrecord(pSubrecord);

}
/*===========================================================================
 *		End of Class Event CSrTes4Record::OnDeleteSubrecord()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CSrTes4Record Method - void SetAuthor (pString);
 *
 *=========================================================================*/
void CSrTes4Record::SetAuthor (const SSCHAR* pString)
{ 

  if (m_pCreatedBy == NULL)
  {
    AddNewSubrecord(SR_NAME_CNAM);
    if (m_pCreatedBy == NULL) return;
    m_pCreatedBy->InitializeNew();
  } 

  m_pCreatedBy->SetString(pString); 
}
/*===========================================================================
 *		End of Class Method CSrTes4Record::SetAuthor()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CSrTes4Record Method - void SetSummary (pString);
 *
 *=========================================================================*/
void CSrTes4Record::SetSummary (const SSCHAR* pString)
{

  if (m_pSummary == NULL)
  {
    AddNewSubrecord(SR_NAME_SNAM);
    if (m_pSummary == NULL) return;
    m_pSummary->InitializeNew();
  } 

  m_pSummary->SetString(pString); 
}
/*===========================================================================
 *		End of Class Method CSrTes4Record::SetSummary()
 *=========================================================================*/


/*===========================================================================
 *
 * Begin CSrTes4Record Get Field Methods
 *
 *=========================================================================*/
DEFINE_SRGETFIELD(CSrTes4Record::GetFieldSummary,     String.Format("%s",     GetSummary()))
DEFINE_SRGETFIELD(CSrTes4Record::GetFieldAuthor,      String.Format("%s",     GetAuthor()))
DEFINE_SRGETFIELD(CSrTes4Record::GetFieldVersion,     String.Format("%.1f",   GetVersion()))
DEFINE_SRGETFIELD(CSrTes4Record::GetFieldRecordCount, String.Format("%d",     GetRecordCount()))
DEFINE_SRGETFIELD(CSrTes4Record::GetFieldNextObjectId,    String.Format("0x%08X", GetNextObjectId()))
/*===========================================================================
 *		End of CSrTes4Record Get Field Methods
 *=========================================================================*/


/*===========================================================================
 *
 * Begin CSrTes4Record Compare Field Methods
 *
 *=========================================================================*/
DEFINE_SRCOMPFIELDSTRING(CSrTes4Record, CompareFieldSummary, GetSummary)
DEFINE_SRCOMPFIELDSTRING(CSrTes4Record, CompareFieldAuthor, GetAuthor)
DEFINE_SRCOMPFIELDFLOAT(CSrTes4Record, CompareFieldVersion, GetVersion, 100.0f)
DEFINE_SRCOMPFIELDSTRING(CSrTes4Record, CompareFieldRecordCount, GetRecordCount)
DEFINE_SRCOMPFIELDSTRING(CSrTes4Record, CompareFieldNextObjectId, GetNextObjectId)
/*===========================================================================
 *		End of CSrTes4Record Compare Field Methods
 *=========================================================================*/


/*===========================================================================
 *
 * Begin CSrTes4Record Set Field Methods
 *
 *=========================================================================*/
BEGIN_SRSETFIELD(CSrTes4Record::SetFieldSummary)
  SetSummary(pString);
END_SRSETFIELD()


BEGIN_SRSETFIELD(CSrTes4Record::SetFieldAuthor)
  SetAuthor(pString);
END_SRSETFIELD()
/*===========================================================================
 *		End of CSrTes4Record Set Field Methods
 *=========================================================================*/


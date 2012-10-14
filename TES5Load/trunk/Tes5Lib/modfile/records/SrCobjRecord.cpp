/*===========================================================================
 *
 * File:		SrCobjRecord.CPP
 * Author:		Dave Humphrey (dave@uesp.net)
 * Created On:	5 December 2011
 *
 * Description
 *
 *=========================================================================*/

	/* Include Files */
#include "srcobjrecord.h"
#include "../srrecordhandler.h"


/*===========================================================================
 *
 * Begin Subrecord Creation Array
 *
 *=========================================================================*/
BEGIN_SRSUBRECCREATE(CSrCobjRecord, CSrIdRecord)
	DEFINE_SRSUBRECCREATE(SR_NAME_BNAM, CSrFormidSubrecord::Create)
	DEFINE_SRSUBRECCREATE(SR_NAME_CNTO, CSrCntoSubrecord::Create)
	DEFINE_SRSUBRECCREATE(SR_NAME_COCT, CSrDwordSubrecord::Create)
	DEFINE_SRSUBRECCREATE(SR_NAME_CTDA, CSrCtdaSubrecord::Create)
	DEFINE_SRSUBRECCREATE(SR_NAME_CIS1, CSrStringSubrecord::Create)
	DEFINE_SRSUBRECCREATE(SR_NAME_CIS2, CSrStringSubrecord::Create)
	DEFINE_SRSUBRECCREATE(SR_NAME_CNAM, CSrFormidSubrecord::Create)
	DEFINE_SRSUBRECCREATE(SR_NAME_NAM1, CSrWordSubrecord::Create)
	DEFINE_SRSUBRECCREATE(SR_NAME_COED, CSrCoedSubrecord::Create)
END_SRSUBRECCREATE()
/*===========================================================================
 *		End of Subrecord Creation Array
 *=========================================================================*/


/*===========================================================================
 *
 * Begin CSrRecord Field Map
 *
 *=========================================================================*/
BEGIN_SRFIELDMAP(CSrCobjRecord, CSrIdRecord)
	ADD_SRFIELDALL("ComponentCount",	SR_FIELD_COMPONENTCOUNT,	0, CSrCobjRecord, FieldComponentCount)
	ADD_SRFIELDALL("ConditionCount",	SR_FIELD_CONDITIONCOUNT,	0, CSrCobjRecord, FieldConditionCount)
	ADD_SRFIELDALL("ResultCount",		SR_FIELD_RESULTCOUNT,		0, CSrCobjRecord, FieldResultCount)
	ADD_SRFIELDALL("Station",			SR_FIELD_STATION,			0, CSrCobjRecord, FieldStation)
	ADD_SRFIELDALL("ResultItem",		SR_FIELD_RESULTITEM,		0, CSrCobjRecord, FieldResultItem)
END_SRFIELDMAP()
/*===========================================================================
 *		End of CObRecord Field Map
 *=========================================================================*/


/*===========================================================================
 *
 * Class CSrCobjRecord Constructor
 *
 *=========================================================================*/
CSrCobjRecord::CSrCobjRecord () :
	m_pStation(NULL), m_pComponentCount(NULL), m_pItemResult(NULL), m_pResultQnt(NULL)
{	
}
/*===========================================================================
 *		End of Class CSrCobjRecord Constructor
 *=========================================================================*/


/*===========================================================================
 *
 * Class CSrCobjRecord Method - void Destroy (void);
 *
 *=========================================================================*/
void CSrCobjRecord::Destroy (void) 
{
	m_pStation			= NULL;
	m_pComponentCount	= NULL;
	m_pItemResult		= NULL;
	m_pResultQnt		= NULL;

	CSrIdRecord::Destroy();
}
/*===========================================================================
 *		End of Class Method CSrCobjRecord::Destroy()
 *=========================================================================*/


const char* CSrCobjRecord::GetResultItem     (void) { return m_pParent ? m_pParent->GetEditorID(GetResultItemID()) : NULL; }
const char* CSrCobjRecord::GetStation        (void) { return m_pParent ? m_pParent->GetEditorID(GetStationID())    : NULL; }


/*===========================================================================
 *
 * Class CSrCobjRecord Method - void InitializeNew (void);
 *
 *=========================================================================*/
void CSrCobjRecord::InitializeNew (void) 
{
	CSrIdRecord::InitializeNew();

	AddNewSubrecord(SR_NAME_COCT);
	if (m_pComponentCount != NULL) m_pComponentCount->InitializeNew();

	AddNewSubrecord(SR_NAME_CNAM);
	if (m_pItemResult != NULL) m_pItemResult->InitializeNew();

	AddNewSubrecord(SR_NAME_NAM1);
	if (m_pResultQnt != NULL) m_pResultQnt->InitializeNew();

	AddNewSubrecord(SR_NAME_BNAM);
	if (m_pStation != NULL) m_pStation->InitializeNew();

}
/*===========================================================================
 *		End of Class Method CSrCobjRecord::InitializeNew()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CSrCobjRecord Event - void OnAddSubrecord (pSubrecord);
 *
 *=========================================================================*/
void CSrCobjRecord::OnAddSubrecord (CSrSubrecord* pSubrecord) 
{

	if (pSubrecord->GetRecordType() == SR_NAME_BNAM)
	{
		m_pStation = SrCastClass(CSrFormidSubrecord, pSubrecord);
	}
	else if (pSubrecord->GetRecordType() == SR_NAME_COCT)
	{
		m_pComponentCount = SrCastClass(CSrDwordSubrecord, pSubrecord);
	}
	else if (pSubrecord->GetRecordType() == SR_NAME_CNAM)
	{
		m_pItemResult = SrCastClass(CSrFormidSubrecord, pSubrecord);
	}
	else if (pSubrecord->GetRecordType() == SR_NAME_NAM1)
	{
		m_pResultQnt = SrCastClass(CSrWordSubrecord, pSubrecord);
	}
	else
	{
		CSrIdRecord::OnAddSubrecord(pSubrecord);
	}

}
/*===========================================================================
 *		End of Class Event CSrCobjRecord::OnAddSubRecord()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CSrCobjRecord Event - void OnDeleteSubrecord (pSubrecord);
 *
 *=========================================================================*/
void CSrCobjRecord::OnDeleteSubrecord (CSrSubrecord* pSubrecord) 
{

	if (m_pResultQnt == pSubrecord)
		m_pResultQnt = NULL;
	else if (m_pItemResult == pSubrecord)
		m_pItemResult = NULL;
	else if (m_pComponentCount == pSubrecord)
		m_pComponentCount = NULL;
	else if (m_pStation == pSubrecord)
		m_pStation = NULL;
	else
		CSrIdRecord::OnDeleteSubrecord(pSubrecord);

}
/*===========================================================================
 *		End of Class Event CSrCobjRecord::OnDeleteSubrecord()
 *=========================================================================*/


void CSrCobjRecord::UpdateComponentCount (void)
{
	if (m_pComponentCount == NULL)
	{
		AddNewSubrecord(SR_NAME_COCT);
		if (m_pComponentCount == NULL) return;
		m_pComponentCount->InitializeNew();
	}

	m_pComponentCount->SetValue(CountSubrecords(SR_NAME_CNTO));
}


/*===========================================================================
 *
 * Begin CSrCobjRecord Get Field Methods
 *
 *=========================================================================*/
DEFINE_SRGETFIELD(CSrCobjRecord::GetFieldComponentCount,	String.Format("%u", GetComponentCount()))
DEFINE_SRGETFIELD(CSrCobjRecord::GetFieldResultCount,		String.Format("%u",(dword)GetResultCount()))
DEFINE_SRGETFIELD(CSrCobjRecord::GetFieldResultItem,		String = GetResultItem())
DEFINE_SRGETFIELD(CSrCobjRecord::GetFieldStation,			String = GetStation())
/*===========================================================================
 *		End of CSrCobjRecord Get Field Methods
 *=========================================================================*/


/*===========================================================================
 *
 * Begin CSrCobjRecord Compare Field Methods
 *
 *=========================================================================*/
DEFINE_SRCOMPFIELDDWORD(CSrCobjRecord,  CompareFieldComponentCount,		GetComponentCount)
DEFINE_SRCOMPFIELDDWORD(CSrCobjRecord,  CompareFieldResultCount,		GetResultCount)
DEFINE_SRCOMPFIELDSTRING(CSrCobjRecord, CompareFieldResultItem,			GetResultItem)
DEFINE_SRCOMPFIELDSTRING(CSrCobjRecord, CompareFieldStation,			GetStation)
/*===========================================================================
 *		End of CSrCobjRecord Compare Field Methods
 *=========================================================================*/


/*===========================================================================
 *
 * Begin CSrCobjRecord Set Field Methods
 *
 *=========================================================================*/
BEGIN_SRSETFIELD(CSrCobjRecord::SetFieldComponentCount)
	AddSrGeneralError("Cannot set the recipe component count directly!");
END_SRSETFIELD()


BEGIN_SRSETFIELD(CSrCobjRecord::SetFieldResultCount)
	word Value;

	if (!SrFieldConvertWord(pString, Value)) return (false);
	SetResultCount(Value);
END_SRSETFIELD()


BEGIN_SRSETFIELD(CSrCobjRecord::SetFieldResultItem)
	if (m_pParent == NULL) return false;

	CSrIdRecord* pRecord = m_pParent->FindEditorID(pString);
	if (pRecord == NULL) return false;

	SetResultItemID(pRecord->GetFormID());
END_SRSETFIELD()


BEGIN_SRSETFIELD(CSrCobjRecord::SetFieldStation)
	if (m_pParent == NULL) return false;

	CSrIdRecord* pRecord = m_pParent->FindEditorID(pString);
	if (pRecord == NULL) return false;

	SetStationID(pRecord->GetFormID());
END_SRSETFIELD()
/*===========================================================================
 *		End of CSrCobjRecord Set Field Methods
 *=========================================================================*/

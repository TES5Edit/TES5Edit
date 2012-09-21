/*===========================================================================
 *
 * File:		SrGlobRecord.CPP
 * Author:		Dave Humphrey (dave@uesp.net)
 * Created On:	5 December 2011
 *
 * Description
 *
 *=========================================================================*/

	/* Include Files */
#include "srGlobrecord.h"


/*===========================================================================
 *
 * Begin Subrecord Creation Array
 *
 *=========================================================================*/
BEGIN_SRSUBRECCREATE(CSrGlobRecord, CSrIdRecord)
	DEFINE_SRSUBRECCREATE(SR_NAME_FLTV, CSrFloatSubrecord::Create)
	DEFINE_SRSUBRECCREATE(SR_NAME_FNAM, CSrByteSubrecord::Create)
END_SRSUBRECCREATE()
/*===========================================================================
 *		End of Subrecord Creation Array
 *=========================================================================*/


/*===========================================================================
 *
 * Begin CSrRecord Field Map
 *
 *=========================================================================*/
BEGIN_SRFIELDMAP(CSrGlobRecord, CSrIdRecord)
	ADD_SRFIELDALL("Value",			SR_FIELD_VALUE,		0, CSrGlobRecord, FieldValue)
	ADD_SRFIELDALL("Type",			SR_FIELD_TYPE,		0, CSrGlobRecord, FieldType)
END_SRFIELDMAP()
/*===========================================================================
 *		End of CObRecord Field Map
 *=========================================================================*/


/*===========================================================================
 *
 * Class CSrGlobRecord Constructor
 *
 *=========================================================================*/
CSrGlobRecord::CSrGlobRecord () 
{
	m_pValue = NULL;
	m_pType  = NULL;
}
/*===========================================================================
 *		End of Class CSrGlobRecord Constructor
 *=========================================================================*/


/*===========================================================================
 *
 * Class CSrGlobRecord Method - void Destroy (void);
 *
 *=========================================================================*/
void CSrGlobRecord::Destroy (void) 
{
	m_pValue = NULL;
	m_pType  = NULL;
	CSrIdRecord::Destroy();
}
/*===========================================================================
 *		End of Class Method CSrGlobRecord::Destroy()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CSrGlobRecord Method - void InitializeNew (void);
 *
 *=========================================================================*/
void CSrGlobRecord::InitializeNew (void) 
{
	CSrIdRecord::InitializeNew();
		
	AddNewSubrecord(SR_NAME_FLTV);
	if (m_pValue != NULL) m_pValue->InitializeNew();

	AddNewSubrecord(SR_NAME_FNAM);

	if (m_pType != NULL) 
	{
		m_pType->InitializeNew();
		m_pType->SetValue('f');
	}
	
}
/*===========================================================================
 *		End of Class Method CSrGlobRecord::InitializeNew()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CSrGlobRecord Event - void OnAddSubrecord (pSubrecord);
 *
 *=========================================================================*/
void CSrGlobRecord::OnAddSubrecord (CSrSubrecord* pSubrecord) {

	if (pSubrecord->GetRecordType() == SR_NAME_FLTV)
	{
		m_pValue = SrCastClass(CSrFloatSubrecord, pSubrecord);
	}
	else if (pSubrecord->GetRecordType() == SR_NAME_FNAM)
	{
		m_pType = SrCastClass(CSrByteSubrecord, pSubrecord);
	}
	else
	{
		CSrIdRecord::OnAddSubrecord(pSubrecord);
	}

}
/*===========================================================================
 *		End of Class Event CSrGlobRecord::OnAddSubRecord()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CSrGlobRecord Event - void OnDeleteSubrecord (pSubrecord);
 *
 *=========================================================================*/
void CSrGlobRecord::OnDeleteSubrecord (CSrSubrecord* pSubrecord) {

	if (m_pValue == pSubrecord)
		m_pValue = NULL;
	else if (m_pType == pSubrecord)
		m_pType = NULL;
	else
		CSrIdRecord::OnDeleteSubrecord(pSubrecord);

}
/*===========================================================================
 *		End of Class Event CSrGlobRecord::OnDeleteSubrecord()
 *=========================================================================*/


void CSrGlobRecord::SetGlobalValue (const float Value)
{
	if (m_pValue == NULL)
	{
		AddNewSubrecord(SR_NAME_FLTV);
		if (m_pValue == NULL) return;
	}

	m_pValue->SetValue(Value);
}


void CSrGlobRecord::SetGlobalType (const byte  Value)
{
	if (m_pType == NULL)
	{
		AddNewSubrecord(SR_NAME_FNAM);
		if (m_pType == NULL) return;
	}

	switch (tolower(Value))
	{
	case 'l':
		m_pType->SetValue('l');
		break;
	case 's':
		m_pType->SetValue('s');
		break;
	case 'f':
		m_pType->SetValue('f');
		break;
	}
}


/*===========================================================================
 *
 * Begin CSrGlobRecord Get Field Methods
 *
 *=========================================================================*/
DEFINE_SRGETFIELD(CSrGlobRecord::GetFieldValue,		String.Format("%g", GetGlobalValue()))
BEGIN_SRGETFIELD(CSrGlobRecord::GetFieldType)

	switch (GetGlobalType())
	{
	case 'l':
		String = "long";
		break;
	case 's':
		String = "short";
		break;
	case 'f':
		String = "float";
		break;
	default:
		String = "unknown";
		break;

	}

END_SRGETFIELD()
/*===========================================================================
 *		End of CSrGlobRecord Get Field Methods
 *=========================================================================*/


/*===========================================================================
 *
 * Begin CSrGlobRecord Compare Field Methods
 *
 *=========================================================================*/
DEFINE_SRCOMPFIELDFLOAT(CSrGlobRecord,  CompareFieldValue,		GetGlobalValue, 1.0)
DEFINE_SRCOMPFIELDDWORD(CSrGlobRecord,  CompareFieldType,		GetGlobalType)
/*===========================================================================
 *		End of CSrGlobRecord Compare Field Methods
 *=========================================================================*/


/*===========================================================================
 *
 * Begin CSrGlobRecord Set Field Methods
 *
 *=========================================================================*/
BEGIN_SRSETFIELD(CSrGlobRecord::SetFieldValue)
  float Value;

  if (!SrFieldConvertFloat(pString, Value)) return (false);
  SetGlobalValue(Value);
END_SRSETFIELD()


BEGIN_SRSETFIELD(CSrGlobRecord::SetFieldType)
  SetGlobalType(pString[0]);
END_SRSETFIELD()
	/*===========================================================================
 *		End of CSrGlobRecord Set Field Methods
 *=========================================================================*/

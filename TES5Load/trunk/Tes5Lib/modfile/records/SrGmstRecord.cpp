/*===========================================================================
 *
 * File:		SrGmstRecord.CPP
 * Author:		Dave Humphrey (dave@uesp.net)
 * Created On:	5 December 2011
 *
 * Description
 *
 *=========================================================================*/

	/* Include Files */
#include "srGmstrecord.h"


/*===========================================================================
 *
 * Begin Subrecord Creation Array
 *
 *=========================================================================*/
BEGIN_SRSUBRECCREATE(CSrGmstRecord, CSrIdRecord)
	DEFINE_SRSUBRECCREATE(SR_NAME_DATA, CSrGmstDataSubrecord::Create)
END_SRSUBRECCREATE()
/*===========================================================================
 *		End of Subrecord Creation Array
 *=========================================================================*/


/*===========================================================================
 *
 * Begin CSrRecord Field Map
 *
 *=========================================================================*/
BEGIN_SRFIELDMAP(CSrGmstRecord, CSrIdRecord)
	ADD_SRFIELDALL("Value",		SR_FIELD_VALUE,		0, CSrGmstRecord, FieldValue)
	ADD_SRFIELDALL("Type",		SR_FIELD_TYPE,		0, CSrGmstRecord, FieldType)
END_SRFIELDMAP()
/*===========================================================================
 *		End of CObRecord Field Map
 *=========================================================================*/


/*===========================================================================
 *
 * Class CSrGmstRecord Constructor
 *
 *=========================================================================*/
CSrGmstRecord::CSrGmstRecord () 
{
	m_pGlobalData = NULL;
}
/*===========================================================================
 *		End of Class CSrGmstRecord Constructor
 *=========================================================================*/


/*===========================================================================
 *
 * Class CSrGmstRecord Method - void Destroy (void);
 *
 *=========================================================================*/
void CSrGmstRecord::Destroy (void) 
{
	CSrIdRecord::Destroy();
}
/*===========================================================================
 *		End of Class Method CSrGmstRecord::Destroy()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CSrGmstRecord Method - void InitializeNew (void);
 *
 *=========================================================================*/
void CSrGmstRecord::InitializeNew (void) 
{
	CSrIdRecord::InitializeNew();

	AddNewSubrecord(SR_NAME_DATA);

	if (m_pGlobalData != NULL) 
	{
		m_pGlobalData->InitializeNew();
		m_pGlobalData->SetInteger(0);
		UpdateGlobalType();
	}
}
/*===========================================================================
 *		End of Class Method CSrGmstRecord::InitializeNew()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CSrGmstRecord Event - void OnAddSubrecord (pSubrecord);
 *
 *=========================================================================*/
void CSrGmstRecord::OnAddSubrecord (CSrSubrecord* pSubrecord) {

	if (pSubrecord->GetRecordType() == SR_NAME_DATA)
	{
		m_pGlobalData = SrCastClass(CSrGmstDataSubrecord, pSubrecord);
		if (m_pEditorID != NULL) UpdateGlobalType();
	}
	else
	{
		CSrIdRecord::OnAddSubrecord(pSubrecord);
	}

}
/*===========================================================================
 *		End of Class Event CSrGmstRecord::OnAddSubRecord()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CSrGmstRecord Event - void OnDeleteSubrecord (pSubrecord);
 *
 *=========================================================================*/
void CSrGmstRecord::OnDeleteSubrecord (CSrSubrecord* pSubrecord) {

	if (m_pGlobalData == pSubrecord)
		m_pGlobalData = NULL;
	else
		CSrIdRecord::OnDeleteSubrecord(pSubrecord);

}
/*===========================================================================
 *		End of Class Event CSrGmstRecord::OnDeleteSubrecord()
 *=========================================================================*/


void CSrGmstRecord::UpdateGlobalType (void)
{
	if (m_pEditorID == NULL) return;

	if (m_pGlobalData == NULL)
	{
		AddInitNewSubrecord(SR_NAME_DATA);
		if (m_pGlobalData == NULL) return;
	}

	switch (m_pEditorID->GetString()[0])
	{
	case 'b':
	case 'B':
		m_pGlobalData->SetGlobalType(SR_GMSTDATA_TYPEBOOL);
		break;
	case 'i':
	case 'I':
		m_pGlobalData->SetGlobalType(SR_GMSTDATA_TYPEINT);
		break;
	case 's':
	case 'S':
		m_pGlobalData->SetGlobalType(SR_GMSTDATA_TYPESTRING);
		break;
	case 'f':
	case 'F':
		m_pGlobalData->SetGlobalType(SR_GMSTDATA_TYPEFLOAT);
		break;
	default:
		AddSrGeneralError("Unknown Global type editorid '%s'!", m_pEditorID->GetString().c_str());
		break;			
	}
}


/*===========================================================================
 *
 * Begin CSrGmstRecord Get Field Methods
 *
 *=========================================================================*/
BEGIN_SRGETFIELD(CSrGmstRecord::GetFieldValue)

	String.Empty();
	if (m_pGlobalData == NULL) return true;

	switch (m_pGlobalData->GetGlobalType())
	{
	case SR_GMSTDATA_TYPEFLOAT:
		String.Format("%g", m_pGlobalData->GetFloat());
		break;
	case SR_GMSTDATA_TYPEINT:
	case SR_GMSTDATA_TYPEBOOL:
		String.Format("%d", m_pGlobalData->GetInteger());
		break;
	case SR_GMSTDATA_TYPESTRING:
		String = m_pGlobalData->GetString();
		break;
	}
	
END_SRGETFIELD()


BEGIN_SRGETFIELD(CSrGmstRecord::GetFieldType)

	String.Empty();
	if (m_pGlobalData == NULL) return true;

	switch (m_pGlobalData->GetGlobalType())
	{
	case SR_GMSTDATA_TYPEFLOAT:
		String = "float";
		break;
	case SR_GMSTDATA_TYPEINT:
		String = "integer";
		break;
	case SR_GMSTDATA_TYPESTRING:
		String = "string";
		break;
	case SR_GMSTDATA_TYPEBOOL:
		String = "boolean";
		break;
	}
	
END_SRGETFIELD()
/*===========================================================================
 *		End of CSrGmstRecord Get Field Methods
 *=========================================================================*/


/*===========================================================================
 *
 * Begin CSrGmstRecord Compare Field Methods
 *
 *=========================================================================*/
BEGIN_SRCOMPFIELD(CSrGmstRecord::CompareFieldValue)
	CSrGmstRecord* pGmst = SrCastClassNull(CSrGmstRecord, pRecord);

	if (pGmst == NULL) return 0;

	CSString String;
	CSString String1;
	if (!GetFieldValue(String)) return 0;
	if (!pGmst->GetFieldValue(String1)) return 0;

	return String.Compare(String1);
END_SRCOMPFIELD()


DEFINE_SRCOMPFIELDINT(CSrGmstRecord, CompareFieldType, GetGlobalType)
/*===========================================================================
 *		End of CSrGmstRecord Compare Field Methods
 *=========================================================================*/


/*===========================================================================
 *
 * Begin CSrGmstRecord Set Field Methods
 *
 *=========================================================================*/
BEGIN_SRSETFIELD(CSrGmstRecord::SetFieldValue)

	if (m_pGlobalData == NULL)
	{
		AddNewSubrecord(SR_NAME_DATA);
		if (m_pGlobalData == NULL) return false;
		m_pGlobalData->InitializeNew();
	}

	UpdateGlobalType();

	switch (m_pGlobalData->GetGlobalType())
	{
	case SR_GMSTDATA_TYPEFLOAT:
		m_pGlobalData->SetFloat((float) atof(pString));
		m_pGlobalData->SetString(pString);
		break;
	case SR_GMSTDATA_TYPEINT:
	case SR_GMSTDATA_TYPEBOOL:
		m_pGlobalData->SetInteger((int) strtol(pString, NULL, 0));
		m_pGlobalData->SetString(pString);
		break;
	case SR_GMSTDATA_TYPESTRING:
		m_pGlobalData->SetString(pString);
		break;
	}

END_SRSETFIELD()


BEGIN_SRSETFIELD(CSrGmstRecord::SetFieldType)
	//AddSrGeneralError("Cannot directly set the type of a GMST record!");
END_SRSETFIELD()
/*===========================================================================
 *		End of CSrGmstRecord Set Field Methods
 *=========================================================================*/

/*===========================================================================
 *
 * File:		SrScriptRecord.CPP
 * Author:		Dave Humphrey (dave@uesp.net)
 * Created On:	10 February 2012
 *
 * Description
 *
 *=========================================================================*/

	/* Include Files */
#include "srscriptrecord.h"


/*===========================================================================
 *
 * Begin Subrecord Creation Array
 *
 *=========================================================================*/
BEGIN_SRSUBRECCREATE(CSrScriptRecord, CSrRecord)
END_SRSUBRECCREATE()
/*===========================================================================
 *		End of Subrecord Creation Array
 *=========================================================================*/


/*===========================================================================
 *
 * Begin CSrRecord Field Map
 *
 *=========================================================================*/
BEGIN_SRFIELDMAP(CSrScriptRecord, CSrRecord)
	ADD_SRFIELDALL("EditorID",		SR_FIELD_EDITORID,		0, CSrScriptRecord, FieldEditorID)
	ADD_SRFIELDALL("FormID",		SR_FIELD_FORMID,		0, CSrScriptRecord, FieldFormID)
	ADD_SRFIELDALL("RecordType",	SR_FIELD_RECORDTYPE,	0, CSrScriptRecord, FieldRecordType)
END_SRFIELDMAP()
/*===========================================================================
 *		End of CObRecord Field Map
 *=========================================================================*/


/*===========================================================================
 *
 * Class CSrScriptRecord Constructor
 *
 *=========================================================================*/
CSrScriptRecord::CSrScriptRecord () 
{
	m_Header.RecordType = "SCRI";
}
/*===========================================================================
 *		End of Class CSrScriptRecord Constructor
 *=========================================================================*/


/*===========================================================================
 *
 * Class CSrScriptRecord Method - void Destroy (void);
 *
 *=========================================================================*/
void CSrScriptRecord::Destroy (void) 
{
	CSrRecord::Destroy();
}
/*===========================================================================
 *		End of Class Method CSrScriptRecord::Destroy()
 *=========================================================================*/


bool CSrScriptRecord::GetFieldEditorID (CSString& String, long Reserved)
{
	String = m_ScriptName;
	return true;
}


bool CSrScriptRecord::GetFieldFormID (CSString& String, long Reserved)
{
	String = "";
	return true;
}


bool CSrScriptRecord::GetFieldRecordType (CSString& String, long Reserved)
{
	String = "Script";
	return true;
}


int CSrScriptRecord::CompareFieldEditorID (CSrRecord* pRecord, long Reserved)
{
	if (pRecord == NULL) return 0;

	CSString Buffer;
	if (!pRecord->GetField(Buffer, SR_FIELD_EDITORID)) return 0;

	return m_ScriptName.CompareNoCase(Buffer);
}


int CSrScriptRecord::CompareFieldFormID (CSrRecord* pRecord, long Reserved)
{
	return 0;
}


int CSrScriptRecord::CompareFieldRecordType (CSrRecord* pRecord, long Reserved)
{
	if (pRecord == NULL) return 0;
	return strnicmp("Script", pRecord->GetRecordType().Name, 4);
}


bool CSrScriptRecord::SetFieldEditorID (const SSCHAR* pString, long Reserved)
{
	return true;
}


bool CSrScriptRecord::SetFieldFormID (const SSCHAR* pString, long Reserved)
{
	return true;
}


bool CSrScriptRecord::SetFieldRecordType (const SSCHAR* pString, long Reserved)
{
	return true;
}
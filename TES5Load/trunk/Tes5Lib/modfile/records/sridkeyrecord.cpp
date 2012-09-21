/*===========================================================================
 *
 * File:		Sridkeyrecord.CPP
 * Author:		Dave Humphrey (dave@uesp.net)
 * Created On:	5 December 2011
 *
 * Description
 *
 *=========================================================================*/

	/* Include Files */
#include "sridkeyrecord.h"
#include "../srrecordhandler.h"


/*===========================================================================
 *
 * Begin Subrecord Creation Array
 *
 *=========================================================================*/
BEGIN_SRSUBRECCREATE(CSrIdKeyRecord, CSrIdRecord)
	DEFINE_SRSUBRECCREATE(SR_NAME_KSIZ, CSrDwordSubrecord::Create)
	DEFINE_SRSUBRECCREATE(SR_NAME_KWDA, CSrFormidArraySubrecord::Create)
END_SRSUBRECCREATE()
/*===========================================================================
 *		End of Subrecord Creation Array
 *=========================================================================*/


/*===========================================================================
 *
 * Begin CSrIdRecord Field Map
 *
 *=========================================================================*/
BEGIN_SRFIELDMAP(CSrIdKeyRecord, CSrIdRecord)
	ADD_SRFIELDALL("KeywordCount",	SR_FIELD_KEYWORDCOUNT,	SRRF_NOCSV,				 CSrIdKeyRecord, FieldKeywordCount)
	ADD_SRFIELDALL("Keywords",		SR_FIELD_KEYWORDS,		SR_RECFIELD_FLAG_NOLIST, CSrIdKeyRecord, FieldKeywords)	
END_SRFIELDMAP()
/*===========================================================================
 *		End of CSrIdRecord Field Map
 *=========================================================================*/


/*===========================================================================
 *
 * Class CSrIdKeyRecord Constructor
 *
 *=========================================================================*/
CSrIdKeyRecord::CSrIdKeyRecord () :
	m_HasKeywords(true)
{
  m_pKeywordCount = NULL;
  m_pKeywords     = NULL;
}
/*===========================================================================
 *		End of Class CSrIdKeyRecord Constructor
 *=========================================================================*/


/*===========================================================================
 *
 * Class CSrIdKeyRecord Method - void Destroy (void);
 *
 *=========================================================================*/
void CSrIdKeyRecord::Destroy (void) 
{
	m_pKeywordCount = NULL;
	m_pKeywords     = NULL;
  
	CSrIdRecord::Destroy();
}
/*===========================================================================
 *		End of Class Method CSrIdKeyRecord::Destroy()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CSrIdKeyRecord Method - CSString GetKeywords (void);
 *
 *=========================================================================*/
CSString CSrIdKeyRecord::GetKeywords (void)
{
	CSString Buffer;

	if (m_pParent == NULL || m_pKeywords == NULL) return Buffer;

	for (dword i = 0; i < m_pKeywords->GetFormIDArray().GetSize(); ++i)
	{
		if (i > 0) Buffer += SR_KEYWORD_SEPCHAR;
		Buffer += m_pParent->GetEditorID(m_pKeywords->GetFormIDArray()[i]);
	}
	
	return Buffer;
}
/*===========================================================================
 *		End of Class Method CSrIdKeyRecord::GetKeywords()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CSrIdKeyRecord Method - void InitializeNew (void);
 *
 *=========================================================================*/
void CSrIdKeyRecord::InitializeNew (void) 
{
  CSrIdRecord::InitializeNew();

  AddNewSubrecord(SR_NAME_KSIZ);
  if (m_pKeywordCount != NULL) m_pKeywordCount->InitializeNew();

  AddNewSubrecord(SR_NAME_KWDA);
  if (m_pKeywords != NULL) m_pKeywords->InitializeNew();   
}
/*===========================================================================
 *		End of Class Method CSrIdKeyRecord::InitializeNew()
 *=========================================================================*/

  
/*===========================================================================
 *
 * Class CSrIdKeyRecord Event - void OnAddSubrecord (pSubRecord);
 *
 *=========================================================================*/
void CSrIdKeyRecord::OnAddSubrecord (CSrSubrecord* pSubrecord) {

  if (pSubrecord->GetRecordType() == SR_NAME_KSIZ) 
  {
    m_pKeywordCount = SrCastClass(CSrDwordSubrecord, pSubrecord);
    //TEST_INTVALUE1(m_pKeywordCount->GetRecordSize(), 4, SR_NAME_KSIZ);
  }
  else if (pSubrecord->GetRecordType() == SR_NAME_KWDA) 
  {
    m_pKeywords = SrCastClass(CSrFormidArraySubrecord, pSubrecord);
  }  
  else
  {
    CSrIdRecord::OnAddSubrecord(pSubrecord);
  }
  
 }
/*===========================================================================
 *		End of Class Event CSrIdKeyRecord::OnAddSubrecord()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CSrIdKeyRecord Event - void OnDeleteSubrecord (pSubrecord);
 *
 *=========================================================================*/
void CSrIdKeyRecord::OnDeleteSubrecord (CSrSubrecord* pSubrecord) {

  if (m_pKeywordCount == pSubrecord)
    m_pKeywordCount = NULL;
  else if (m_pKeywords == pSubrecord)
    m_pKeywords = NULL;  
  else
    CSrIdRecord::OnDeleteSubrecord(pSubrecord);

}
/*===========================================================================
 *		End of Class Event CSrIdKeyRecord::OnDeleteSubrecord()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CSrIdKeyRecord Method - void SetKeywords (Buffer);
 *
 *=========================================================================*/
void CSrIdKeyRecord::SetKeywords (const CSString Buffer)
{
	CSStringArray Strings;
	CSrRecord*    pRecord;

	if (m_pParent == NULL) return;
	SplitString(Strings, Buffer, ',');
		
	if (m_pKeywords == NULL) 
	{
		AddNewSubrecord(SR_NAME_KWDA);
		if (m_pKeywords == NULL) return;
		m_pKeywords->InitializeNew();
	}

	m_pKeywords->GetFormIDArray().Empty();

	for (dword i = 0; i < Strings.GetSize(); ++i)
	{
		pRecord = m_pParent->FindEditorID(Strings[i]->c_str());
		if (pRecord == NULL) continue;
		m_pKeywords->GetFormIDArray().Add(pRecord->GetFormID());
	}	

	SetKeywordCount(m_pKeywords->GetFormIDArray().GetSize());
}
/*===========================================================================
 *		End of Class Method CSrIdKeyRecord::SetKeywords()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CSrIdKeyRecord Method - void SetKeywords (FormIDs);
 *
 *=========================================================================*/
void CSrIdKeyRecord::SetKeywords (CSrFormidArray& FormIDs)
{
	if (FormIDs.GetSize() == 0)
	{	
		DeleteSubrecords(SR_NAME_KWDA);
		m_pKeywords = NULL;
	}
	else if (m_pKeywords == NULL)
	{
		AddNewSubrecord(SR_NAME_KWDA);
		if (m_pKeywords == NULL) return;
		m_pKeywords->InitializeNew();
	}

	SetKeywordCount(FormIDs.GetSize());
	m_pKeywords->GetFormIDArray() = FormIDs;
}
/*===========================================================================
 *		End of Class Method CSrIdKeyRecord::SetKeywords()
 *=========================================================================*/


void CSrIdKeyRecord::SetKeywordCount (const dword Count)
{
	if (m_pKeywordCount == NULL)
	{
		AddNewSubrecord(SR_NAME_KSIZ);
		if (m_pKeywordCount == NULL) return;
		m_pKeywordCount->InitializeNew();
	}

	m_pKeywordCount->SetValue(Count);
}


/*===========================================================================
 *
 * Begin CSrIdKeyRecord Get Field Methods
 *
 *=========================================================================*/
DEFINE_SRGETFIELD(CSrIdKeyRecord::GetFieldKeywordCount, String.Format("%u", GetKeywordCount()))
DEFINE_SRGETFIELD(CSrIdKeyRecord::GetFieldKeywords,     String = GetKeywords())
/*===========================================================================
 *		End of CSrIdKeyRecord Get Field Methods
 *=========================================================================*/


/*===========================================================================
 *
 * Begin CSrIdKeyRecord Compare Field Methods
 *
 *=========================================================================*/
DEFINE_SRCOMPFIELDDWORD(CSrIdKeyRecord,  CompareFieldKeywordCount, GetKeywordCount)
DEFINE_SRCOMPFIELDDWORD(CSrIdKeyRecord,  CompareFieldKeywords,     GetKeywordCount) //TODO
/*===========================================================================
 *		End of CSrIdKeyRecord Compare Field Methods
 *=========================================================================*/


/*===========================================================================
 *
 * Begin CSrIdKeyRecord Set Field Methods
 *
 *=========================================================================*/
BEGIN_SRSETFIELD(CSrIdKeyRecord::SetFieldKeywordCount)
	AddSrGeneralError("Cannot set the keyword count of a record directly!");
END_SRSETFIELD()


BEGIN_SRSETFIELD(CSrIdKeyRecord::SetFieldKeywords)
	SetKeywords(pString);
END_SRSETFIELD()

/*===========================================================================
 *		End of CSrIdKeyRecord Set Field Methods
 *=========================================================================*/

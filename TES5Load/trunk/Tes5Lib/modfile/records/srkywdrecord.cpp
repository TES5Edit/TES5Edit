/*===========================================================================
 *
 * File:		SrKywdRecord.CPP
 * Author:		Dave Humphrey (dave@uesp.net)
 * Created On:	26 November 2011
 *
 * Description
 *
 *=========================================================================*/

	/* Include Files */
#include "srkywdrecord.h"


/*===========================================================================
 *
 * Begin Subrecord Creation Array
 *
 *=========================================================================*/
BEGIN_SRSUBRECCREATE(CSrKywdRecord, CSrIdRecord)
	DEFINE_SRSUBRECCREATE(SR_NAME_CNAM, CSrDwordSubrecord::Create)
END_SRSUBRECCREATE()
/*===========================================================================
 *		End of Subrecord Creation Array
 *=========================================================================*/


/*===========================================================================
 *
 * Begin CSrRecord Field Map
 *
 *=========================================================================*/
BEGIN_SRFIELDMAP(CSrKywdRecord, CSrIdRecord)
	ADD_SRFIELDALL("CNAME",  SR_FIELD_CNAM,	0, CSrKywdRecord, FieldCNAM)
END_SRFIELDMAP()
/*===========================================================================
 *		End of CObRecord Field Map
 *=========================================================================*/


/*===========================================================================
 *
 * Class CSrKywdRecord Constructor
 *
 *=========================================================================*/
CSrKywdRecord::CSrKywdRecord () 
{
  m_pCName = NULL;
}
/*===========================================================================
 *		End of Class CSrKywdRecord Constructor
 *=========================================================================*/


/*===========================================================================
 *
 * Class CSrKywdRecord Method - void Destroy (void);
 *
 *=========================================================================*/
void CSrKywdRecord::Destroy (void) 
{
  m_pCName = NULL;

  CSrIdRecord::Destroy();
}
/*===========================================================================
 *		End of Class Method CSrKywdRecord::Destroy()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CSrKywdRecord Method - void InitializeNew (void);
 *
 *=========================================================================*/
void CSrKywdRecord::InitializeNew (void) 
{

	/* Call the base class method first */
  CSrIdRecord::InitializeNew();

  AddNewSubrecord(SR_NAME_CNAM);
  if (m_pCName != NULL) m_pCName->InitializeNew();

}
/*===========================================================================
 *		End of Class Method CSrKywdRecord::InitializeNew()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CSrKywdRecord Event - void OnAddSubrecord (pSubrecord);
 *
 *=========================================================================*/
void CSrKywdRecord::OnAddSubrecord (CSrSubrecord* pSubrecord) {

  if (pSubrecord->GetRecordType() == SR_NAME_CNAM) {
    m_pCName = SrCastClass(CSrDwordSubrecord, pSubrecord);
    TEST_INTVALUE1(m_pCName->GetRecordSize(), 4, SR_NAME_CNAM);
   }
  else
    CSrIdRecord::OnAddSubrecord(pSubrecord);

}
/*===========================================================================
 *		End of Class Event CSrKywdRecord::OnAddSubRecord()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CSrKywdRecord Event - void OnDeleteSubrecord (pSubrecord);
 *
 *=========================================================================*/
void CSrKywdRecord::OnDeleteSubrecord (CSrSubrecord* pSubrecord) {

  if (m_pCName == pSubrecord)
    m_pCName = NULL;
  else
    CSrIdRecord::OnDeleteSubrecord(pSubrecord);

}
/*===========================================================================
 *		End of Class Event CSrKywdRecord::OnDeleteSubrecord()
 *=========================================================================*/


/*===========================================================================
 *
 * Begin CSrKywdRecord Get Field Methods
 *
 *=========================================================================*/
BEGIN_SRGETFIELD(CSrKywdRecord::GetFieldCNAM)

	if (m_pCName == NULL)
	{
		String.Empty();
	}
	else 
	{
		String.Format("%u", GetCNAM());
	}

END_SRGETFIELD()
/*===========================================================================
 *		End of CSrKywdRecord Get Field Methods
 *=========================================================================*/


/*===========================================================================
 *
 * Begin CSrKywdRecord Compare Field Methods
 *
 *=========================================================================*/
BEGIN_SRCOMPFIELD(CSrKywdRecord::CompareFieldCNAM)
	CSrKywdRecord* pKeyword1 = SrCastClassNull(CSrKywdRecord, pRecord);
	if (pKeyword1 == NULL) return 0;

	dword CNAM1 = GetCNAM();
	dword CNAM2 = pKeyword1->GetCNAM();

	if (m_pCName == NULL) CNAM1 = -1;
	if (pKeyword1->m_pCName == NULL) CNAM2 = -1;

	return (int) ((int64) CNAM1 - (int64) CNAM2);
END_SRCOMPFIELD()
/*===========================================================================
 *		End of CSrKywdRecord Compare Field Methods
 *=========================================================================*/


/*===========================================================================
 *
 * Begin CSrKywdRecord Set Field Methods
 *
 *=========================================================================*/
BEGIN_SRSETFIELD(CSrKywdRecord::SetFieldCNAM)
  dword Value;

  if (pString == NULL || *pString == 0)
  {
	DeleteSubrecords(SR_NAME_CNAM);
	m_pCName = NULL;
  }
  else
  {
	if (!SrFieldConvertDword(pString, Value)) return (false);
	SetCNAM(Value);
  }

END_SRSETFIELD()
/*===========================================================================
 *		End of CSrKywdRecord Set Field Methods
 *=========================================================================*/


/*===========================================================================
 *
 * Class CSrKywdRecord Method - void SetCNAM (Value);
 *
 *=========================================================================*/
void CSrKywdRecord::SetCNAM (const dword Value) 
{
	if (m_pCName == NULL) 
	{
		AddNewSubrecord(SR_NAME_CNAM);
		if (m_pCName == NULL) return;
		m_pCName->InitializeNew();
	}
		
	m_pCName->SetValue(Value); 
}
/*===========================================================================
 *		End of Class Event CSrKywdRecord::SetCNAM()
 *=========================================================================*/

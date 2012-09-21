/*===========================================================================
 *
 * File:		Sritem2record.CPP
 * Author:		Dave Humphrey (dave@uesp.net)
 * Created On:	26 November 2011
 *
 * Defines the CSrItem2Record class for records with:
 *
 *	EAMT - Enchantment pts
 *	EITM - Enchantment formid
 *
 * In addition to all standard CSrItem1Record subrecords.
 *
 *=========================================================================*/

	/* Include Files */
#include "sritem2record.h"
#include "../srrecordhandler.h"


/*===========================================================================
 *
 * Begin Subrecord Creation Array
 *
 *=========================================================================*/
BEGIN_SRSUBRECCREATE(CSrItem2Record, CSrItem1Record)
	DEFINE_SRSUBRECCREATE(SR_NAME_EITM, CSrFormidSubrecord::Create)
	DEFINE_SRSUBRECCREATE(SR_NAME_EAMT, CSrWordSubrecord::Create)
END_SRSUBRECCREATE()
/*===========================================================================
 *		End of Subrecord Creation Array
 *=========================================================================*/


/*===========================================================================
 *
 * Begin CObRecord Field Map
 *
 *=========================================================================*/
BEGIN_SRFIELDMAP(CSrItem2Record, CSrItem1Record)
	ADD_SRFIELDALL("Enchant Pts", SR_FIELD_ENCHANTPOINTS,	       0, CSrItem2Record, FieldEnchantPoints)
	ADD_SRFIELDALL("Enchantment", SR_FIELD_ENCHANTMENT,            0, CSrItem2Record, FieldEnchantment)
	ADD_SRFIELDALL("EnchantID",   SR_FIELD_ENCHANTMENTID, SRRF_NOCSV, CSrItem2Record, FieldEnchantmentID)
END_SRFIELDMAP()
/*===========================================================================
 *		End of CObRecord Field Map
 *=========================================================================*/


/*===========================================================================
 *
 * Class CSrItem2Record Constructor
 *
 *=========================================================================*/
CSrItem2Record::CSrItem2Record () 
{
  m_pEnchantment   = NULL;
  m_pEnchantPoints = NULL;
}
/*===========================================================================
 *		End of Class CSrItem2Record Constructor
 *=========================================================================*/


/*===========================================================================
 *
 * Class CSrItem2Record Method - void Destroy (void);
 *
 *=========================================================================*/
void CSrItem2Record::Destroy (void) 
{
  m_pEnchantment   = NULL;
  m_pEnchantPoints = NULL;

  m_CachedEnchantID.Empty();

  CSrItem1Record::Destroy();
}
/*===========================================================================
 *		End of Class Method CSrItem2Record::Destroy()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CSrItem2Record Method - const SSCHAR* GetEnchantEditorID (void);
 *
 * TODO:
 *
 *=========================================================================*/
const SSCHAR* CSrItem2Record::GetEnchantEditorID (void) 
{
  if (!m_CachedEnchantID.IsEmpty()) return m_CachedEnchantID;
  return m_CachedEnchantID;
}
/*===========================================================================
 *		End of Class Method SSCHAR* CSrItem2Record::GetEnchantEditorID()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CSrItem2Record Method - void InitializeNew (void);
 *
 *=========================================================================*/
void CSrItem2Record::InitializeNew (void) 
{

	/* Call the base class method first */
  CSrItem1Record::InitializeNew();

}
/*===========================================================================
 *		End of Class Method CSrItem2Record::InitializeNew()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CSrItem2Record Event - void OnAddSubrecord (pSubrecord);
 *
 *=========================================================================*/
void CSrItem2Record::OnAddSubrecord (CSrSubrecord* pSubrecord)
{

  if (pSubrecord->GetRecordType() == SR_NAME_EITM)
    m_pEnchantment = SrCastClass(CSrFormidSubrecord, pSubrecord);
  else if (pSubrecord->GetRecordType() == SR_NAME_EAMT)
    m_pEnchantPoints = SrCastClass(CSrWordSubrecord, pSubrecord);
  else
    CSrItem1Record::OnAddSubrecord(pSubrecord);

 }
/*===========================================================================
 *		End of Class Event CSrItem2Record::OnAddSubRecord()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CSrItem2Record Event - void OnDeleteSubrecord (pSubrecord);
 *
 *=========================================================================*/
void CSrItem2Record::OnDeleteSubrecord (CSrSubrecord* pSubrecord)
{

  if (m_pEnchantment == pSubrecord)
    m_pEnchantment = NULL;
  else if (m_pEnchantPoints == pSubrecord)
    m_pEnchantPoints = NULL;
  else
    CSrItem1Record::OnDeleteSubrecord(pSubrecord);

}
/*===========================================================================
 *		End of Class Event CSrItem2Record::OnDeleteSubrecord()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CSrItem2Record Method - void SetEnchantment (FormID);
 *
 *=========================================================================*/
void CSrItem2Record::SetEnchantment (const srformid_t FormID)
{

  if (FormID == SR_FORMID_NULL && m_pEnchantment != NULL) 
  {
    DeleteSubrecords(SR_NAME_EITM);
    m_pEnchantment = NULL;
    return;
  }

  if (m_pEnchantment == NULL) 
  {
     AddNewSubrecord(SR_NAME_EITM);
     if (m_pEnchantment == NULL) return;
     m_pEnchantment->InitializeNew();
  }

  m_pEnchantment->SetValue(FormID);
} 
/*===========================================================================
 *		End of Class Method CSrItem2Record::SetEnchantment()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CSrItem2Record Method - void SetEnchantPoints (Points);
 *
 *=========================================================================*/
void CSrItem2Record::SetEnchantPoints (const word Points) 
{
  
  if (m_pEnchantPoints == NULL) 
  {
     AddNewSubrecord(SR_NAME_EAMT);
     if (m_pEnchantPoints == NULL) return;
     m_pEnchantPoints->InitializeNew();
  }

  m_pEnchantPoints->SetValue(Points);
} 
/*===========================================================================
 *		End of Class Method CSrItem2Record::SetEnchantPoints()
 *=========================================================================*/


/*===========================================================================
 *
 * Begin CSrItem2Record Get Field Methods
 *
 *=========================================================================*/
BEGIN_SRGETFIELD(CSrItem2Record::GetFieldEnchantment)
	if (m_pParent != NULL) return m_pParent->GetEditorID(String, GetEnchantment());
	String.Format("0x%08X", GetEnchantment());
END_SRGETFIELD()

DEFINE_SRGETFIELD(CSrItem2Record::GetFieldEnchantmentID, GetEnchantment() ? String.Format("0x%08X", GetEnchantment()) : String.Empty() )

BEGIN_SRGETFIELD(CSrItem2Record::GetFieldEnchantPoints)

	if (m_pEnchantPoints == NULL)
	{
		String.Empty();
	}
	else
	{
		String.Format("%u", (dword) GetEnchantPoints());
	}

END_SRGETFIELD()
/*===========================================================================
 *		End of CSrItem2Record Get Field Methods
 *=========================================================================*/


/*===========================================================================
 *
 * Begin CSrItem2Record Compare Field Methods
 *
 *=========================================================================*/
DEFINE_SRCOMPFIELDEDITORID(CSrItem2Record, CompareFieldEnchantment, GetEnchantment)
DEFINE_SRCOMPFIELDDWORD(CSrItem2Record, CompareFieldEnchantmentID, GetEnchantment)
DEFINE_SRCOMPFIELDDWORD(CSrItem2Record, CompareFieldEnchantPoints, GetEnchantPoints)
/*===========================================================================
 *		End of CSrItem2Record Compare Field Methods
 *=========================================================================*/


/*===========================================================================
 *
 * Begin CSrItem2Record Set Field Methods
 *
 *=========================================================================*/
BEGIN_SRSETFIELD(CSrItem2Record::SetFieldEnchantment)
  CSrIdRecord* pIdRecord = NULL;

  if (m_pParent != NULL) 
  {
   
    if (pString == NULL || *pString == NULL_CHAR) 
	{
      SetEnchantment(SR_FORMID_NULL);
      return (true);
    }

    pIdRecord = m_pParent->FindEditorID(pString);
    if (pIdRecord == NULL) return AddSrGeneralError("The enchantment '%s' does not exist!", pString);
    if (pIdRecord->GetRecordType() != SR_NAME_ENCH) return AddSrGeneralError("The record '%s' is not an enchantment (%4.4s)!", pString, pIdRecord->GetRecordType().Name);

    SetEnchantment(pIdRecord->GetFormID());
  }
  else
  {
    return AddSrGeneralError("Unable to find the formID for the enchantment '%s'!", pString);
  }

END_SRSETFIELD()


BEGIN_SRSETFIELD(CSrItem2Record::SetFieldEnchantPoints)
	CSString Buffer(pString);
	Buffer.Trim();
	

	if (Buffer.IsEmpty())
	{
		DeleteSubrecords(SR_NAME_EAMT);
		m_pEnchantPoints = NULL;
	}
	else
	{
		word Value;
		if (!SrFieldConvertWord(pString, Value)) return (false);
		SetEnchantPoints(Value);
	}

END_SRSETFIELD()


BEGIN_SRSETFIELD(CSrItem2Record::SetFieldEnchantmentID)
	srformid_t FormID;
	if (!SrFieldConvertDword(pString, FormID)) return (false);
	SetEnchantment(FormID);
END_SRSETFIELD()
/*===========================================================================
 *		End of CSrItem2Record Field Methods
 *=========================================================================*/

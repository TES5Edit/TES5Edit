/*===========================================================================
 *
 * File:		Srweaprecord.CPP
 * Author:		Dave Humphrey (dave@uesp.net)
 * Created On:	26 November 2011
 *
 * Description
 *
 *=========================================================================*/

	/* Include Files */
#include "srweaprecord.h"
#include "../srrecordhandler.h"


srcrdtdata_t     CSrWeapRecord::s_NullCrdtData;
srweapdata_t     CSrWeapRecord::s_NullWeapData;
srweapdnamdata_t CSrWeapRecord::s_NullDnamData;


/*===========================================================================
 *
 * Begin Subrecord Creation Array
 *
 *=========================================================================*/
BEGIN_SRSUBRECCREATE(CSrWeapRecord, CSrItem2Record)
	DEFINE_SRSUBRECCREATE(SR_NAME_DATA, CSrWeapDataSubrecord::Create)
	DEFINE_SRSUBRECCREATE(SR_NAME_VNAM, CSrDwordSubrecord::Create)
	DEFINE_SRSUBRECCREATE(SR_NAME_ETYP, CSrFormidSubrecord::Create)
	DEFINE_SRSUBRECCREATE(SR_NAME_CNAM, CSrFormidSubrecord::Create)
	DEFINE_SRSUBRECCREATE(SR_NAME_BIDS, CSrFormidSubrecord::Create)
	DEFINE_SRSUBRECCREATE(SR_NAME_BAMT, CSrFormidSubrecord::Create)
	DEFINE_SRSUBRECCREATE(SR_NAME_DNAM, CSrWeapDnamSubrecord::Create)
	DEFINE_SRSUBRECCREATE(SR_NAME_NAM8, CSrFormidSubrecord::Create)
	DEFINE_SRSUBRECCREATE(SR_NAME_NAM9, CSrFormidSubrecord::Create)
	DEFINE_SRSUBRECCREATE(SR_NAME_NNAM, CSrStringSubrecord::Create)
	DEFINE_SRSUBRECCREATE(SR_NAME_SNAM, CSrFormidSubrecord::Create)
	DEFINE_SRSUBRECCREATE(SR_NAME_TNAM, CSrFormidSubrecord::Create)
	DEFINE_SRSUBRECCREATE(SR_NAME_UNAM, CSrFormidSubrecord::Create)
	DEFINE_SRSUBRECCREATE(SR_NAME_WNAM, CSrFormidSubrecord::Create)
	DEFINE_SRSUBRECCREATE(SR_NAME_VMAD, CSrVmadSubrecord::Create)
	DEFINE_SRSUBRECCREATE(SR_NAME_DESC, CSrLStringSubrecord::Create)
	DEFINE_SRSUBRECCREATE(SR_NAME_CRDT, CSrCrdtSubrecord::Create)
END_SRSUBRECCREATE()
/*===========================================================================
 *		End of Subrecord Creation Array
 *=========================================================================*/


/*===========================================================================
 *
 * Begin CSrRecord Field Map
 *
 *=========================================================================*/
BEGIN_SRFIELDMAP(CSrWeapRecord, CSrItem2Record)
	ADD_SRFIELDALL("Weight",		SR_FIELD_WEIGHT,		0, CSrWeapRecord, FieldWeight)
	ADD_SRFIELDALL("Value",			SR_FIELD_VALUE,			0, CSrWeapRecord, FieldValue)
	ADD_SRFIELDALL("Damage",		SR_FIELD_DAMAGE,		0, CSrWeapRecord, FieldDamage)
	ADD_SRFIELDALL("Type",			SR_FIELD_TYPE,			0, CSrWeapRecord, FieldType)
	ADD_SRFIELDALL("MaterialObject",SR_FIELD_MATERIALOBJECT,0, CSrWeapRecord, FieldMaterialObject)
	ADD_SRFIELDALL("Material",		SR_FIELD_MATERIAL,		0, CSrWeapRecord, FieldMaterial)
	ADD_SRFIELDALL("VNAM",			SR_FIELD_VNAM,			0, CSrWeapRecord, FieldVNAM)
	ADD_SRFIELDALL("Description",	SR_FIELD_DESCRIPTION,	0, CSrWeapRecord, FieldDescription)
	ADD_SRFIELDALL("EquipSlot",		SR_FIELD_EQUIPSLOT,		0, CSrWeapRecord, FieldEquipSlot)
	ADD_SRFIELDALL("BaseWeapon",	SR_FIELD_BASEWEAPON,	0, CSrWeapRecord, FieldBaseWeapon)
	ADD_SRFIELDALL("ImpactSet",		SR_FIELD_IMPACTSET,		0, CSrWeapRecord, FieldImpactSet)
	ADD_SRFIELDALL("FireSound",		SR_FIELD_FIRESOUND,		0, CSrWeapRecord, FieldFireSound)
	ADD_SRFIELDALL("BoundSound",	SR_FIELD_BOUNDSOUND,	0, CSrWeapRecord, FieldBoundSound)
	ADD_SRFIELDALL("SheathSound",	SR_FIELD_SHEATHSOUND,	0, CSrWeapRecord, FieldSheathSound)
	ADD_SRFIELDALL("DrawSound",		SR_FIELD_DRAWSOUND,		0, CSrWeapRecord, FieldDrawSound)
	ADD_SRFIELDALL("SwingSound",	SR_FIELD_SWINGSOUND,	0, CSrWeapRecord, FieldSwingSound)
	ADD_SRFIELDALL("Static",		SR_FIELD_STATIC,		0, CSrWeapRecord, FieldStatic)
	ADD_SRFIELDALL("NName",			SR_FIELD_NNAM,			0, CSrWeapRecord, FieldNName)
	ADD_SRFIELDALL("Unknown1",		SR_FIELD_UNKNOWN1,		0, CSrWeapRecord, FieldUnknown1)
	ADD_SRFIELDALL("Unknown2",		SR_FIELD_UNKNOWN2,		0, CSrWeapRecord, FieldUnknown2)
	ADD_SRFIELDALL("Unknown3",		SR_FIELD_UNKNOWN3,		0, CSrWeapRecord, FieldUnknown3)
	ADD_SRFIELDALL("Speed",			SR_FIELD_UNKNOWN5,		0, CSrWeapRecord, FieldUnknown5)
	ADD_SRFIELDALL("Range",			SR_FIELD_UNKNOWN6,		0, CSrWeapRecord, FieldUnknown6)
	ADD_SRFIELDALL("Unknown7",		SR_FIELD_UNKNOWN7,		0, CSrWeapRecord, FieldUnknown7)
	ADD_SRFIELDALL("Unknown8",		SR_FIELD_UNKNOWN8,		0, CSrWeapRecord, FieldUnknown8)
	ADD_SRFIELDALL("Unknown9",		SR_FIELD_UNKNOWN9,		0, CSrWeapRecord, FieldUnknown9)
	ADD_SRFIELDALL("Unknown10",		SR_FIELD_UNKNOWN10,		0, CSrWeapRecord, FieldUnknown10)
	ADD_SRFIELDALL("Unknown11",		SR_FIELD_UNKNOWN11,		0, CSrWeapRecord, FieldUnknown11)
	ADD_SRFIELDALL("Unknown12",		SR_FIELD_UNKNOWN12,		0, CSrWeapRecord, FieldUnknown12)
	ADD_SRFIELDALL("Unknown13",		SR_FIELD_UNKNOWN13,		0, CSrWeapRecord, FieldUnknown13)
	ADD_SRFIELDALL("Unknown14",		SR_FIELD_UNKNOWN14,		0, CSrWeapRecord, FieldUnknown14)
	ADD_SRFIELDALL("Unknown15",		SR_FIELD_UNKNOWN15,		0, CSrWeapRecord, FieldUnknown15)
	ADD_SRFIELDALL("Unknown16",		SR_FIELD_UNKNOWN16,		0, CSrWeapRecord, FieldUnknown16)
	ADD_SRFIELDALL("UnknownFormID",	SR_FIELD_UNKNOWN17,		0, CSrWeapRecord, FieldUnknown17)
	ADD_SRFIELDALL("UnknownFlag1",	SR_FIELD_UNKNOWNFLAG1,	0, CSrWeapRecord, FieldUnknownFlag1)
END_SRFIELDMAP()
/*===========================================================================
 *		End of CObRecord Field Map
 *=========================================================================*/


/*===========================================================================
 *
 * Class CSrWeapRecord Constructor
 *
 *=========================================================================*/
CSrWeapRecord::CSrWeapRecord () 
{
	m_pDescription  = NULL;
	m_pEquipSlot	= NULL;
	m_pWeaponData   = NULL;
	m_pVNAM         = NULL;
	m_pSheathSound = NULL;
	m_pDrawSound = NULL;
	m_pFireSound = NULL;
	m_pSwingSound = NULL;
	m_pBoundSound = NULL;
	m_pStatic = NULL;
	m_pImpactSet = NULL;
	m_pMaterial = NULL;
	m_pBaseWeapon = NULL;
	m_pCrdtData = NULL;

	m_pDName = NULL;
	m_pNName = NULL;
}
/*===========================================================================
 *		End of Class CSrWeapRecord Constructor
 *=========================================================================*/


/*===========================================================================
 *
 * Class CSrWeapRecord Method - void Destroy (void);
 *
 *=========================================================================*/
void CSrWeapRecord::Destroy (void) 
{
	m_pDescription  = NULL;
	m_pEquipSlot	= NULL;
	m_pWeaponData   = NULL;
	m_pVNAM         = NULL;
	m_pImpactSet = NULL;
	m_pMaterial = NULL;
	m_pBaseWeapon = NULL;
	m_pDName = NULL;
	m_pSheathSound = NULL;
	m_pDrawSound = NULL;
	m_pNName = NULL;
	m_pFireSound = NULL;
	m_pSwingSound = NULL;
	m_pBoundSound = NULL;
	m_pStatic = NULL;
    m_pCrdtData = NULL;

	CSrItem2Record::Destroy();
}
/*===========================================================================
 *		End of Class Method CSrWeapRecord::Destroy()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CSrWeapRecord Method - void InitializeNew (void);
 *
 *=========================================================================*/
void CSrWeapRecord::InitializeNew (void) 
{

	/* Call the base class method first */
  CSrItem2Record::InitializeNew();

  AddNewSubrecord(SR_NAME_VNAM);
  if (m_pVNAM != NULL) m_pVNAM->InitializeNew();   

  AddNewSubrecord(SR_NAME_DATA);
  if (m_pWeaponData != NULL) m_pWeaponData->InitializeNew();

  AddNewSubrecord(SR_NAME_ETYP);
  if (m_pEquipSlot != NULL) m_pEquipSlot->InitializeNew();

  AddNewSubrecord(SR_NAME_DNAM);
  if (m_pDName != NULL) m_pDName->InitializeNew();

  AddNewSubrecord(SR_NAME_CRDT);
  if (m_pCrdtData != NULL) m_pCrdtData->InitializeNew();
    
}
/*===========================================================================
 *		End of Class Method CSrWeapRecord::InitializeNew()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CSrWeapRecord Event - void OnAddSubrecord (pSubrecord);
 *
 *=========================================================================*/
void CSrWeapRecord::OnAddSubrecord (CSrSubrecord* pSubrecord) {

  if (pSubrecord->GetRecordType() == SR_NAME_DATA) 
  {
    m_pWeaponData = SrCastClass(CSrWeapDataSubrecord, pSubrecord);
  }
  else if (pSubrecord->GetRecordType() == SR_NAME_VNAM) 
  {
    m_pVNAM = SrCastClass(CSrDwordSubrecord, pSubrecord);
  }
  else if (pSubrecord->GetRecordType() == SR_NAME_SNAM) 
  {
    m_pFireSound = SrCastClass(CSrFormidSubrecord, pSubrecord);
  }
  else if (pSubrecord->GetRecordType() == SR_NAME_NNAM) 
  {
    m_pNName = SrCastClass(CSrStringSubrecord, pSubrecord);
  }
  else if (pSubrecord->GetRecordType() == SR_NAME_DESC) 
  {
    m_pDescription = SrCastClass(CSrLStringSubrecord, pSubrecord);
  }
  else if (pSubrecord->GetRecordType() == SR_NAME_UNAM) 
  {
    m_pBoundSound = SrCastClass(CSrFormidSubrecord, pSubrecord);
  }
  else if (pSubrecord->GetRecordType() == SR_NAME_DNAM) 
  {
    m_pDName = SrCastClass(CSrWeapDnamSubrecord, pSubrecord);
  }
  else if (pSubrecord->GetRecordType() == SR_NAME_NAM8) 
  {
    m_pSheathSound = SrCastClass(CSrFormidSubrecord, pSubrecord);
  }
  else if (pSubrecord->GetRecordType() == SR_NAME_NAM9) 
  {
    m_pDrawSound = SrCastClass(CSrFormidSubrecord, pSubrecord);
  }
  else if (pSubrecord->GetRecordType() == SR_NAME_TNAM) 
  {
    m_pSwingSound = SrCastClass(CSrFormidSubrecord, pSubrecord);
  }
  else if (pSubrecord->GetRecordType() == SR_NAME_WNAM) 
  {
    m_pStatic = SrCastClass(CSrFormidSubrecord, pSubrecord);
  }
  else if (pSubrecord->GetRecordType() == SR_NAME_ETYP) 
  {
    m_pEquipSlot = SrCastClass(CSrFormidSubrecord, pSubrecord);
  }
  else if (pSubrecord->GetRecordType() == SR_NAME_CNAM) 
  {
    m_pBaseWeapon = SrCastClass(CSrFormidSubrecord, pSubrecord);
  }
  else if (pSubrecord->GetRecordType() == SR_NAME_BIDS) 
  {
    m_pImpactSet = SrCastClass(CSrFormidSubrecord, pSubrecord);
  }
  else if (pSubrecord->GetRecordType() == SR_NAME_BAMT) 
  {
    m_pMaterial = SrCastClass(CSrFormidSubrecord, pSubrecord);
  }
  else if (pSubrecord->GetRecordType() == SR_NAME_CRDT) 
  {
    m_pCrdtData = SrCastClass(CSrCrdtSubrecord, pSubrecord);
  }
  else
    CSrItem2Record::OnAddSubrecord(pSubrecord);

 }
/*===========================================================================
 *		End of Class Event CSrWeapRecord::OnAddSubRecord()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CSrWeapRecord Event - void OnDeleteSubrecord (pSubrecord);
 *
 *=========================================================================*/
void CSrWeapRecord::OnDeleteSubrecord (CSrSubrecord* pSubrecord) 
{

  if (m_pWeaponData == pSubrecord)
    m_pWeaponData = NULL;
  else if (m_pVNAM == pSubrecord)
    m_pVNAM = NULL;
  else if (m_pNName == pSubrecord)
    m_pNName = NULL;
  else if (m_pDescription == pSubrecord)
    m_pDescription = NULL;
  else if (m_pSheathSound == pSubrecord)
    m_pSheathSound = NULL;
  else if (m_pDrawSound == pSubrecord)
    m_pDrawSound = NULL;
  else if (m_pBaseWeapon == pSubrecord)
    m_pBaseWeapon = NULL;
  else if (m_pImpactSet == pSubrecord)
    m_pImpactSet = NULL;
  else if (m_pMaterial == pSubrecord)
    m_pMaterial = NULL;
  else if (m_pDName == pSubrecord)
    m_pDName = NULL;
  else if (m_pStatic == pSubrecord)
    m_pStatic = NULL;
  else if (m_pBoundSound == pSubrecord)
    m_pBoundSound = NULL;
  else if (m_pFireSound == pSubrecord)
    m_pFireSound = NULL;
  else if (m_pSwingSound == pSubrecord)
    m_pSwingSound = NULL;
  else if (m_pEquipSlot == pSubrecord)
    m_pEquipSlot = NULL;
  else if (m_pCrdtData == pSubrecord)
    m_pCrdtData = NULL;
  else
    CSrItem2Record::OnDeleteSubrecord(pSubrecord);

}
/*===========================================================================
 *		End of Class Event CSrWeapRecord::OnDeleteSubrecord()
 *=========================================================================*/


void CSrWeapRecord::SetEquipSlotID (const srformid_t FormID)
{
	if (m_pEquipSlot == NULL)
	{
		AddNewSubrecord(SR_NAME_ETYP);
		if (m_pEquipSlot == NULL) return;
		m_pEquipSlot->InitializeNew();
	}

	m_pEquipSlot->SetValue(FormID);

}


void CSrWeapRecord::SetEquipSlot (const char* pEditorID)
{
	if (pEditorID == NULL || *pEditorID == 0)
	{
		SetEquipSlotID(0);
	}
	else if (m_pParent)
	{
		CSrIdRecord* pRecord = m_pParent->FindEditorID(pEditorID);

		if (pRecord == NULL)
			SetEquipSlotID(0);
		else
			SetEquipSlotID(pRecord->GetFormID());
	}
}


const SSCHAR* CSrWeapRecord::GetEquipSlot (void) 
{ 
	return m_pEquipSlot && m_pParent ? m_pParent->GetEditorID(m_pEquipSlot->GetValue()) : ""; 
}


/*===========================================================================
 *
 * Begin CSrWeapRecord Get Field Methods
 *
 *=========================================================================*/
DEFINE_SRGETFIELD(CSrWeapRecord::GetFieldWeight,       String.Format(SR_FORMATSTR_WEIGHT, GetWeaponData().Weight))
DEFINE_SRGETFIELD(CSrWeapRecord::GetFieldValue,        String.Format("%u", GetWeaponData().Value))
DEFINE_SRGETFIELD(CSrWeapRecord::GetFieldDamage,       String.Format("%d", (int)GetWeaponData().Damage))
DEFINE_SRGETFIELD(CSrWeapRecord::GetFieldVNAM,         String.Format("%u", GetVNAM()))
DEFINE_SRGETFIELD(CSrWeapRecord::GetFieldEquipSlot,    String = GetEquipSlot())
/*===========================================================================
 *		End of CSrWeapRecord Get Field Methods
 *=========================================================================*/


/*===========================================================================
 *
 * Begin CSrWeapRecord Compare Field Methods
 *
 *=========================================================================*/
DEFINE_SRCOMPFIELDFLOAT1(CSrWeapRecord, CompareFieldWeight,		  GetWeaponData().Weight, 100.0f)
DEFINE_SRCOMPFIELDDWORD1(CSrWeapRecord, CompareFieldValue,		  GetWeaponData().Value)
DEFINE_SRCOMPFIELDDWORD(CSrWeapRecord,  CompareFieldVNAM,		  GetVNAM)
DEFINE_SRCOMPFIELDDWORD1(CSrWeapRecord, CompareFieldDamage,		  GetWeaponData().Damage)
DEFINE_SRCOMPFIELDSTRING(CSrWeapRecord, CompareFieldEquipSlot,	  GetEquipSlot)
/*===========================================================================
 *		End of CSrWeapRecord Compare Field Methods
 *=========================================================================*/


/*===========================================================================
 *
 * Begin CSrWeapRecord Set Field Methods
 *
 *=========================================================================*/
BEGIN_SRSETFIELD(CSrWeapRecord::SetFieldWeight)
  float Value;

  if (!SrFieldConvertFloat(pString, Value)) return (false);
  GetWeaponData().Weight = Value;
END_SRSETFIELD()


BEGIN_SRSETFIELD(CSrWeapRecord::SetFieldValue)
  dword Value;

  if (!SrFieldConvertDword(pString, Value)) return (false);
  GetWeaponData().Value = Value;
END_SRSETFIELD()


BEGIN_SRSETFIELD(CSrWeapRecord::SetFieldVNAM)
  dword Value;

  if (!SrFieldConvertDword(pString, Value)) return (false);
  SetVNAM(Value);
END_SRSETFIELD()
	

BEGIN_SRSETFIELD(CSrWeapRecord::SetFieldDamage)
  word Value;

  if (!SrFieldConvertWord(pString, Value)) return (false);
  GetWeaponData().Damage = Value;
END_SRSETFIELD()
	

BEGIN_SRSETFIELD(CSrWeapRecord::SetFieldEquipSlot)
	SetEquipSlot(pString);
END_SRSETFIELD()
/*===========================================================================
 *		End of CSrWeapRecord Set Field Methods
 *=========================================================================*/


const SSCHAR* CSrWeapRecord::GetWeaponMaterial (void)
{
	CSrKywdRecord* pKeyword;

	if (m_pParent == NULL || m_pKeywords == NULL) return "Unknown";

	pKeyword = m_pParent->FindKeyword(m_pKeywords->GetFormIDArray(), "WeapMaterial");
	if (pKeyword == NULL) return "";
	return pKeyword->GetEditorID() + 12;
}



void CSrWeapRecord::SetWeaponMaterial (const char* pEditorID)
{
	if (m_pParent == NULL) return;
	CSrIdRecord* pRecord = m_pParent->FindEditorID(pEditorID);
	
	if (pRecord == NULL)
		SetWeaponMaterial(SR_FORMID_NULL);
	else
		SetWeaponMaterial(pRecord->GetFormID());
}


void CSrWeapRecord::SetWeaponMaterial (const srformid_t FormID)
{
	CSrRecord* pRecord;
	CSrIdRecord* pIdRecord;
	const SSCHAR* pEditorID;
	
	if (m_pParent == NULL || m_pKeywords == NULL) return;
	
		/* Delete all existing weapon material keywords */
	for (int i = (int) m_pKeywords->GetFormIDArray().GetSize() - 1; i >= 0 ; --i)
	{
		pRecord = m_pParent->FindFormID(m_pKeywords->GetFormIDArray()[i]);
		pIdRecord = SrCastClassNull(CSrIdRecord, pRecord);
		if (pIdRecord == NULL) continue;
		if (pIdRecord->GetRecordType() != SR_NAME_KYWD) continue;
		
		pEditorID = pIdRecord->GetEditorID();
		if (pEditorID == NULL) continue;
		
		if (strnicmp(pEditorID, "WeapMaterial", 12) != 0) continue;
		m_pKeywords->GetFormIDArray().Delete(i);
	}
	
		/* Add the new keyword material type */
	m_pKeywords->GetFormIDArray().Add(FormID);
	
	if (m_pKeywordCount != NULL) m_pKeywordCount->SetValue(m_pKeywords->GetFormIDArray().GetSize());
}


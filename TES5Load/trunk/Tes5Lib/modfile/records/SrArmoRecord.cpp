/*===========================================================================
 *
 * File:		SrArmoRecord.CPP
 * Author:		Dave Humphrey (dave@uesp.net)
 * Created On:	5 December 2011
 *
 * Description
 *
 *=========================================================================*/

	/* Include Files */
#include "srArmorecord.h"


srarmordata_t CSrArmoRecord::s_NullArmorData;
srbodtdata_t  CSrArmoRecord::s_NullBodtData;


/*===========================================================================
 *
 * Begin Subrecord Creation Array
 *
 *=========================================================================*/
BEGIN_SRSUBRECCREATE(CSrArmoRecord, CSrIdKeyRecord)
	DEFINE_SRSUBRECCREATE(SR_NAME_DATA, CSrArmoDataSubrecord::Create)
	DEFINE_SRSUBRECCREATE(SR_NAME_FULL, CSrLStringSubrecord::Create)
	DEFINE_SRSUBRECCREATE(SR_NAME_DESC, CSrLStringSubrecord::Create)
	DEFINE_SRSUBRECCREATE(SR_NAME_BIDS, CSrFormidSubrecord::Create)
	DEFINE_SRSUBRECCREATE(SR_NAME_BODT, CSrBodtSubrecord::Create)
	DEFINE_SRSUBRECCREATE(SR_NAME_DNAM, CSrDwordSubrecord::Create)
	DEFINE_SRSUBRECCREATE(SR_NAME_EITM, CSrFormidSubrecord::Create)
	DEFINE_SRSUBRECCREATE(SR_NAME_ETYP, CSrFormidSubrecord::Create)
	DEFINE_SRSUBRECCREATE(SR_NAME_BAMT, CSrFormidSubrecord::Create)
	DEFINE_SRSUBRECCREATE(SR_NAME_YNAM, CSrFormidSubrecord::Create)
	DEFINE_SRSUBRECCREATE(SR_NAME_ZNAM, CSrFormidSubrecord::Create)
	DEFINE_SRSUBRECCREATE(SR_NAME_TNAM, CSrFormidSubrecord::Create)
	DEFINE_SRSUBRECCREATE(SR_NAME_RNAM, CSrFormidSubrecord::Create)
	DEFINE_SRSUBRECCREATE(SR_NAME_MODL, CSrFormidSubrecord::Create)
	DEFINE_SRSUBRECCREATE(SR_NAME_MO4T, CSrDataSubrecord::Create)
	DEFINE_SRSUBRECCREATE(SR_NAME_MO2S, CSrDataSubrecord::Create)
	DEFINE_SRSUBRECCREATE(SR_NAME_MO4S, CSrDataSubrecord::Create)
	DEFINE_SRSUBRECCREATE(SR_NAME_MOD4, CSrDataSubrecord::Create)
	DEFINE_SRSUBRECCREATE(SR_NAME_MOD2, CSrDataSubrecord::Create)
	DEFINE_SRSUBRECCREATE(SR_NAME_MO2T, CSrDataSubrecord::Create)
	DEFINE_SRSUBRECCREATE(SR_NAME_VMAD, CSrVmadSubrecord::Create)
END_SRSUBRECCREATE()
/*===========================================================================
 *		End of Subrecord Creation Array
 *=========================================================================*/


/*===========================================================================
 *
 * Begin CSrRecord Field Map
 *
 *=========================================================================*/
BEGIN_SRFIELDMAP(CSrArmoRecord, CSrIdKeyRecord)
	ADD_SRFIELDALL("ItemName",		SR_FIELD_ITEMNAME,		0, CSrArmoRecord, FieldItemName)
	ADD_SRFIELDALL("Description",	SR_FIELD_DESCRIPTION,	0, CSrArmoRecord, FieldDescription)
	ADD_SRFIELDALL("Rating",		SR_FIELD_RATING,		0, CSrArmoRecord, FieldRating)
	ADD_SRFIELDALL("Value",			SR_FIELD_VALUE,			0, CSrArmoRecord, FieldValue)
	ADD_SRFIELDALL("Type",			SR_FIELD_TYPE,			0, CSrArmoRecord, FieldType)
	ADD_SRFIELDALL("Weight",		SR_FIELD_WEIGHT,		0, CSrArmoRecord, FieldWeight)
	ADD_SRFIELDALL("EquipmentSlot",	SR_FIELD_EQUIPSLOT,		0, CSrArmoRecord, FieldEquipmentSlot)
	ADD_SRFIELDALL("Enchantment",	SR_FIELD_ENCHANTMENT,	0, CSrArmoRecord, FieldEnchantment)
	ADD_SRFIELDALL("Playable",		SR_FIELD_PLAYABLE,		0, CSrArmoRecord, FieldPlayable)
	ADD_SRFIELDALL("BodyParts",		SR_FIELD_BODYPARTS,		0, CSrArmoRecord, FieldBodyParts)
	ADD_SRFIELDALL("PickupSound",	SR_FIELD_PICKUPSOUND,	0, CSrArmoRecord, FieldPickupSound)
	ADD_SRFIELDALL("DropSound",		SR_FIELD_DROPSOUND,		0, CSrArmoRecord, FieldDropSound)
	ADD_SRFIELDALL("Race",			SR_FIELD_RACE,			0, CSrArmoRecord, FieldRace)
	ADD_SRFIELDALL("Template",		SR_FIELD_TEMPLATE,		0, CSrArmoRecord, FieldTemplate)
	ADD_SRFIELDALL("Material",		SR_FIELD_MATERIAL,		0, CSrArmoRecord, FieldMaterial)
	ADD_SRFIELDALL("ImpactData",	SR_FIELD_IMPACTDATA,	0, CSrArmoRecord, FieldImpactData)
	ADD_SRFIELDALL("ScriptCount",	SR_FIELD_SCRIPTCOUNT,	0, CSrArmoRecord, FieldScriptCount)
END_SRFIELDMAP()
/*===========================================================================
 *		End of CObRecord Field Map
 *=========================================================================*/


/*===========================================================================
 *
 * Class CSrArmoRecord Constructor
 *
 *=========================================================================*/
CSrArmoRecord::CSrArmoRecord () 
{
	m_pScriptData = NULL;
	m_pItemName = NULL;
	m_pDescription = NULL;
	m_pImpactData = NULL;	
	m_pBodyData = NULL;
	m_pArmorData = NULL;
	m_pArmorRating = NULL;
	m_pEnchantment = NULL;
	m_pEquipmentSlot = NULL;
	m_pMaterial = NULL;	
	m_pPickupSound = NULL;
	m_pDropSound = NULL;
	m_pRace = NULL;
	m_pTemplate = NULL;
	m_pMo2sData = NULL;
	m_pMo4sData = NULL;
	m_pMod2Data = NULL;
	m_pMo2tData = NULL;
	m_pMo4tData = NULL;
	m_pMod4Data = NULL;	
	m_pVmadData = NULL;
}
/*===========================================================================
 *		End of Class CSrArmoRecord Constructor
 *=========================================================================*/


/*===========================================================================
 *
 * Class CSrArmoRecord Method - void Destroy (void);
 *
 *=========================================================================*/
void CSrArmoRecord::Destroy (void) 
{
	m_pScriptData = NULL;
	m_pItemName = NULL;
	m_pDescription = NULL;
	m_pImpactData = NULL;	
	m_pBodyData = NULL;
	m_pArmorData = NULL;
	m_pArmorRating = NULL;
	m_pEnchantment = NULL;
	m_pEquipmentSlot = NULL;
	m_pMaterial = NULL;	
	m_pPickupSound = NULL;
	m_pDropSound = NULL;
	m_pRace = NULL;
	m_pTemplate = NULL;
	m_pMo2sData = NULL;
	m_pMo4sData = NULL;
	m_pMod2Data = NULL;
	m_pMo2tData = NULL;
	m_pMo4tData = NULL;
	m_pMod4Data = NULL;	
	m_pVmadData = NULL;
	CSrIdKeyRecord::Destroy();
}
/*===========================================================================
 *		End of Class Method CSrArmoRecord::Destroy()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CSrArmoRecord Method - void InitializeNew (void);
 *
 *=========================================================================*/
void CSrArmoRecord::InitializeNew (void) 
{
	CSrIdKeyRecord::InitializeNew();

	AddNewSubrecord(SR_NAME_FULL);
	if (m_pItemName != NULL) m_pItemName->InitializeNew();

	AddNewSubrecord(SR_NAME_DESC);
	if (m_pDescription != NULL) m_pDescription->InitializeNew();

	AddNewSubrecord(SR_NAME_DATA);
	if (m_pArmorData != NULL) m_pArmorData->InitializeNew();

	AddNewSubrecord(SR_NAME_DNAM);
	if (m_pArmorRating != NULL) m_pArmorRating->InitializeNew();

	AddNewSubrecord(SR_NAME_BODT);
	if (m_pBodyData != NULL) m_pBodyData->InitializeNew();

}
/*===========================================================================
 *		End of Class Method CSrArmoRecord::InitializeNew()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CSrArmoRecord Event - void OnAddSubrecord (pSubrecord);
 *
 *=========================================================================*/
void CSrArmoRecord::OnAddSubrecord (CSrSubrecord* pSubrecord) {

	if (pSubrecord->GetRecordType() == SR_NAME_MOD4)
	{
		m_pMod4Data = SrCastClass(CSrDataSubrecord, pSubrecord);
	}
	else if (pSubrecord->GetRecordType() == SR_NAME_FULL)
	{
		m_pItemName = SrCastClass(CSrLStringSubrecord, pSubrecord);
	}
	else if (pSubrecord->GetRecordType() == SR_NAME_VMAD)
	{
		m_pScriptData = SrCastClass(CSrVmadSubrecord, pSubrecord);
	}
	else if (pSubrecord->GetRecordType() == SR_NAME_TNAM)
	{
		m_pTemplate = SrCastClass(CSrFormidSubrecord, pSubrecord);
	}
	else if (pSubrecord->GetRecordType() == SR_NAME_MO4T)
	{
		m_pMo4tData = SrCastClass(CSrDataSubrecord, pSubrecord);
	}
	else if (pSubrecord->GetRecordType() == SR_NAME_BIDS)
	{
		m_pImpactData = SrCastClass(CSrFormidSubrecord, pSubrecord);
	}
	else if (pSubrecord->GetRecordType() == SR_NAME_MOD2)
	{
		m_pMod2Data = SrCastClass(CSrDataSubrecord, pSubrecord);
	}
	else if (pSubrecord->GetRecordType() == SR_NAME_MO2T)
	{
		m_pMo2tData = SrCastClass(CSrDataSubrecord, pSubrecord);
	}
	else if (pSubrecord->GetRecordType() == SR_NAME_YNAM)
	{
		m_pPickupSound = SrCastClass(CSrFormidSubrecord, pSubrecord);
	}
	else if (pSubrecord->GetRecordType() == SR_NAME_BODT)
	{
		m_pBodyData = SrCastClass(CSrBodtSubrecord, pSubrecord);
	}
	else if (pSubrecord->GetRecordType() == SR_NAME_ZNAM)
	{
		m_pDropSound = SrCastClass(CSrFormidSubrecord, pSubrecord);
	}
	else if (pSubrecord->GetRecordType() == SR_NAME_RNAM)
	{
		m_pRace = SrCastClass(CSrFormidSubrecord, pSubrecord);
	}
	else if (pSubrecord->GetRecordType() == SR_NAME_DESC)
	{
		m_pDescription = SrCastClass(CSrLStringSubrecord, pSubrecord);
	}
	else if (pSubrecord->GetRecordType() == SR_NAME_DATA)
	{
		m_pArmorData = SrCastClass(CSrArmoDataSubrecord, pSubrecord);
	}
	else if (pSubrecord->GetRecordType() == SR_NAME_DNAM)
	{
		m_pArmorRating = SrCastClass(CSrDwordSubrecord, pSubrecord);
	}
	else if (pSubrecord->GetRecordType() == SR_NAME_EITM)
	{
		m_pEnchantment = SrCastClass(CSrFormidSubrecord, pSubrecord);
	}
	else if (pSubrecord->GetRecordType() == SR_NAME_ETYP)
	{
		m_pEquipmentSlot = SrCastClass(CSrFormidSubrecord, pSubrecord);
	}
	else if (pSubrecord->GetRecordType() == SR_NAME_BAMT)
	{
		m_pMaterial = SrCastClass(CSrFormidSubrecord, pSubrecord);
	}
	else if (pSubrecord->GetRecordType() == SR_NAME_MO2S)
	{
		m_pMo2sData = SrCastClass(CSrDataSubrecord, pSubrecord);
	}
	else if (pSubrecord->GetRecordType() == SR_NAME_MO4S)
	{
		m_pMo4sData = SrCastClass(CSrDataSubrecord, pSubrecord);
	}
	else if (pSubrecord->GetRecordType() == SR_NAME_VMAD)
	{
		m_pVmadData = SrCastClass(CSrDataSubrecord, pSubrecord);
	}
	else
	{
		CSrIdKeyRecord::OnAddSubrecord(pSubrecord);
	}

}
/*===========================================================================
 *		End of Class Event CSrArmoRecord::OnAddSubRecord()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CSrArmoRecord Event - void OnDeleteSubrecord (pSubrecord);
 *
 *=========================================================================*/
void CSrArmoRecord::OnDeleteSubrecord (CSrSubrecord* pSubrecord) {

	if (m_pMod4Data == pSubrecord)
		m_pMod4Data = NULL;
	else if (m_pItemName == pSubrecord)
		m_pItemName = NULL;
	else if (m_pTemplate == pSubrecord)
		m_pTemplate = NULL;
	else if (m_pMo4tData == pSubrecord)
		m_pMo4tData = NULL;
	else if (m_pImpactData == pSubrecord)
		m_pImpactData = NULL;
	else if (m_pMod2Data == pSubrecord)
		m_pMod2Data = NULL;
	else if (m_pMo2tData == pSubrecord)
		m_pMo2tData = NULL;
	else if (m_pPickupSound == pSubrecord)
		m_pPickupSound = NULL;
	else if (m_pBodyData == pSubrecord)
		m_pBodyData = NULL;
	else if (m_pDropSound == pSubrecord)
		m_pDropSound = NULL;
	else if (m_pRace == pSubrecord)
		m_pRace = NULL;
	else if (m_pDescription == pSubrecord)
		m_pDescription = NULL;
	else if (m_pArmorData == pSubrecord)
		m_pArmorData = NULL;
	else if (m_pScriptData == pSubrecord)
		m_pScriptData = NULL;
	else if (m_pArmorRating == pSubrecord)
		m_pArmorRating = NULL;
	else if (m_pEnchantment == pSubrecord)
		m_pEnchantment = NULL;
	else if (m_pEquipmentSlot == pSubrecord)
		m_pEquipmentSlot = NULL;
	else if (m_pMaterial == pSubrecord)
		m_pMaterial = NULL;
	else if (m_pMo2sData == pSubrecord)
		m_pMo2sData = NULL;
	else if (m_pMo4sData == pSubrecord)
		m_pMo4sData = NULL;
	else if (m_pVmadData == pSubrecord)
		m_pVmadData = NULL;
	else
		CSrIdKeyRecord::OnDeleteSubrecord(pSubrecord);

}
/*===========================================================================
 *		End of Class Event CSrArmoRecord::OnDeleteSubrecord()
 *=========================================================================*/


void CSrArmoRecord::SetArmorRating (const dword Value)
{
	if (m_pArmorRating == NULL)
	{
		AddNewSubrecord(SR_NAME_DNAM);
		if (m_pArmorRating == NULL) return;
		m_pArmorRating->InitializeNew();
	}

	m_pArmorRating->SetValue(Value);
}

/*
void CSrArmoRecord::SetBAMT (const dword Value)
{
	if (m_pMaterial == NULL)
	{
		AddNewSubrecord(SR_NAME_BAMT);
		if (m_pMaterial == NULL) return;
		m_pMaterial->InitializeNew();
	}

	m_pMaterial->SetValue(Value);
}


void CSrArmoRecord::SetBIDS (const dword Value)
{
	if (m_pImpactData == NULL)
	{
		AddNewSubrecord(SR_NAME_BIDS);
		if (m_pImpactData == NULL) return;
		m_pImpactData->InitializeNew();
	}

	m_pImpactData->SetValue(Value);
}
//*/

/*===========================================================================
 *
 * Begin CSrArmoRecord Get Field Methods
 *
 *=========================================================================*/
/*===========================================================================
 *		End of CSrArmoRecord Get Field Methods
 *=========================================================================*/


/*===========================================================================
 *
 * Begin CSrArmoRecord Compare Field Methods
 *
 *=========================================================================*/
/*===========================================================================
 *		End of CSrArmoRecord Compare Field Methods
 *=========================================================================*/


/*===========================================================================
 *
 * Begin CSrArmoRecord Set Field Methods
 *
 *=========================================================================*/
/*===========================================================================
 *		End of CSrArmoRecord Set Field Methods
 *=========================================================================*/

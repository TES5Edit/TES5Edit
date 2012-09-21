/*===========================================================================
 *
 * File:		SrSpelRecord.CPP
 * Author:		Dave Humphrey (dave@uesp.net)
 * Created On:	5 December 2011
 *
 * Description
 *
 *=========================================================================*/

	/* Include Files */
#include "srSpelrecord.h"
#include "../srrecordhandler.h"


srspitdata_t	CSrSpelRecord::s_NullSpellData = { 0 };


/*===========================================================================
 *
 * Begin Subrecord Creation Array
 *
 *=========================================================================*/
BEGIN_SRSUBRECCREATE(CSrSpelRecord, CSrIdRecord)
	DEFINE_SRSUBRECCREATE(SR_NAME_EFID, CSrFormidSubrecord::Create)
	DEFINE_SRSUBRECCREATE(SR_NAME_EFIT, CSrEfitSubrecord::Create)
	DEFINE_SRSUBRECCREATE(SR_NAME_ETYP, CSrFormidSubrecord::Create)
	DEFINE_SRSUBRECCREATE(SR_NAME_FULL, CSrLStringSubrecord::Create)
	DEFINE_SRSUBRECCREATE(SR_NAME_DESC, CSrLStringSubrecord::Create)
	DEFINE_SRSUBRECCREATE(SR_NAME_SPIT, CSrSpitSubrecord::Create)	
	DEFINE_SRSUBRECCREATE(SR_NAME_MDOB, CSrFormidSubrecord::Create)
	DEFINE_SRSUBRECCREATE(SR_NAME_OBND, CSrBoundsSubrecord::Create)
	DEFINE_SRSUBRECCREATE(SR_NAME_CTDA, CSrCtdaSubrecord::Create)
	DEFINE_SRSUBRECCREATE(SR_NAME_CIS1, CSrStringSubrecord::Create)
	DEFINE_SRSUBRECCREATE(SR_NAME_CIS2, CSrStringSubrecord::Create)
END_SRSUBRECCREATE()
/*===========================================================================
 *		End of Subrecord Creation Array
 *=========================================================================*/


/*===========================================================================
 *
 * Begin CSrIdRecord Field Map
 *
 *=========================================================================*/
BEGIN_SRFIELDMAP(CSrSpelRecord, CSrIdRecord)
	ADD_SRFIELDALL("ItemName",			SR_FIELD_ITEMNAME,			0, CSrSpelRecord, FieldItemName)
	ADD_SRFIELDALL("Description",		SR_FIELD_DESCRIPTION,		0, CSrSpelRecord, FieldDescription)
	ADD_SRFIELDALL("EffectCount",		SR_FIELD_EFFECTCOUNT,		0, CSrSpelRecord, FieldEffectCount)
	ADD_SRFIELDALL("Perk",				SR_FIELD_PERK,				0, CSrSpelRecord, FieldPerk)
	ADD_SRFIELDALL("EquipSlot",			SR_FIELD_EQUIPSLOT,			0, CSrSpelRecord, FieldEquipSlot)
	ADD_SRFIELDALL("SpellFlags",		SR_FIELD_SPELLFLAGS,		0, CSrSpelRecord, FieldSpellFlags)
	ADD_SRFIELDALL("SpellType",			SR_FIELD_SPELLTYPE,			0, CSrSpelRecord, FieldSpellType)
	ADD_SRFIELDALL("CastType",			SR_FIELD_CASTTYPE,			0, CSrSpelRecord, FieldCastType)
	ADD_SRFIELDALL("DeliveryType",		SR_FIELD_DELIVERYTYPE,		0, CSrSpelRecord, FieldDeliveryType)
	ADD_SRFIELDALL("ChargeTime",		SR_FIELD_CHARGETIME,		0, CSrSpelRecord, FieldChargeTime)
	ADD_SRFIELDALL("Range",				SR_FIELD_RANGE,				0, CSrSpelRecord, FieldRange)
	ADD_SRFIELDALL("CastDuration",		SR_FIELD_CASTTIME,			0, CSrSpelRecord, FieldCastDuration)
	ADD_SRFIELDALL("AutoCalc",			SR_FIELD_AUTOCALC,			0, CSrSpelRecord, FieldAutoCalc)
	ADD_SRFIELDALL("AreaIgnoresLOS",	SR_FIELD_AREAIGNORESLOS,	0, CSrSpelRecord, FieldAreaIgnoresLOS)
	ADD_SRFIELDALL("PCStartSpell",		SR_FIELD_PCSTARTSPELL,		0, CSrSpelRecord, FieldPCStartSpell)
	ADD_SRFIELDALL("NoAbsorbReflect",	SR_FIELD_NOABSORBREFLECT,	0, CSrSpelRecord, FieldNoAbsorbReflect)
	ADD_SRFIELDALL("IgnoreResist",		SR_FIELD_IGNORERESIST,		0, CSrSpelRecord, FieldIgnoreResist)
	ADD_SRFIELDALL("NoDualCastMods",	SR_FIELD_NODUALCASTMODS,	0, CSrSpelRecord, FieldNoDualCastMods)
	ADD_SRFIELDALL("BaseCost",			SR_FIELD_BASECOST,			0, CSrSpelRecord, FieldBaseCost)
	ADD_SRFIELDALL("InventoryModel",	SR_FIELD_INVENTORYMODEL,	0, CSrSpelRecord, FieldInventoryModel)
END_SRFIELDMAP()
/*===========================================================================
 *		End of CObRecord Field Map
 *=========================================================================*/


/*===========================================================================
 *
 * Class CSrSpelRecord Constructor
 *
 *=========================================================================*/
CSrSpelRecord::CSrSpelRecord () 
{
	m_pInventoryModel = NULL;
	m_pItemName = NULL;
	m_pDescription = NULL;
	m_pBoundsData = NULL;
	m_pSpellData = NULL;
	m_pEquipSlot = NULL;
}
/*===========================================================================
 *		End of Class CSrSpelRecord Constructor
 *=========================================================================*/


/*===========================================================================
 *
 * Class CSrSpelRecord Method - void Destroy (void);
 *
 *=========================================================================*/
void CSrSpelRecord::Destroy (void) 
{
	m_pInventoryModel = NULL;
	m_pItemName = NULL;
	m_pDescription = NULL;
	m_pBoundsData = NULL;
	m_pSpellData = NULL;
	m_pEquipSlot = NULL;

	CSrIdRecord::Destroy();
}
/*===========================================================================
 *		End of Class Method CSrSpelRecord::Destroy()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CSrSpelRecord Method - void InitializeNew (void);
 *
 *=========================================================================*/
void CSrSpelRecord::InitializeNew (void) 
{
	CSrIdRecord::InitializeNew();

	AddNewSubrecord(SR_NAME_FULL);
	if (m_pItemName != NULL) m_pItemName->InitializeNew();

	AddNewSubrecord(SR_NAME_ETYP);
	if (m_pEquipSlot != NULL) m_pEquipSlot->InitializeNew();

	AddNewSubrecord(SR_NAME_DESC);
	if (m_pDescription != NULL) m_pDescription->InitializeNew();

	AddNewSubrecord(SR_NAME_SPIT);
	if (m_pSpellData != NULL) m_pSpellData->InitializeNew();
}
/*===========================================================================
 *		End of Class Method CSrSpelRecord::InitializeNew()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CSrSpelRecord Event - void OnAddSubrecord (pSubrecord);
 *
 *=========================================================================*/
void CSrSpelRecord::OnAddSubrecord (CSrSubrecord* pSubrecord) {

	if (pSubrecord->GetRecordType() == SR_NAME_ETYP)
	{
		m_pEquipSlot = SrCastClass(CSrFormidSubrecord, pSubrecord);
	}
	else if (pSubrecord->GetRecordType() == SR_NAME_MDOB)
	{
		m_pInventoryModel = SrCastClass(CSrFormidSubrecord, pSubrecord);
	}
	else if (pSubrecord->GetRecordType() == SR_NAME_OBND)
	{
		m_pBoundsData = SrCastClass(CSrBoundsSubrecord, pSubrecord);
	}
	else if (pSubrecord->GetRecordType() == SR_NAME_FULL)
	{
		m_pItemName = SrCastClass(CSrLStringSubrecord, pSubrecord);
	}
	else if (pSubrecord->GetRecordType() == SR_NAME_DESC)
	{
		m_pDescription = SrCastClass(CSrLStringSubrecord, pSubrecord);
	}
	else if (pSubrecord->GetRecordType() == SR_NAME_SPIT)
	{
		m_pSpellData = SrCastClass(CSrSpitSubrecord, pSubrecord);
	}
	else
	{
		CSrIdRecord::OnAddSubrecord(pSubrecord);
	}

}
/*===========================================================================
 *		End of Class Event CSrSpelRecord::OnAddSubRecord()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CSrSpelRecord Event - void OnDeleteSubrecord (pSubrecord);
 *
 *=========================================================================*/
void CSrSpelRecord::OnDeleteSubrecord (CSrSubrecord* pSubrecord) {

	if (m_pEquipSlot == pSubrecord)
		m_pEquipSlot = NULL;
	else if (m_pInventoryModel == pSubrecord)
		m_pInventoryModel = NULL;
	else if (m_pBoundsData == pSubrecord)
		m_pBoundsData = NULL;
	else if (m_pItemName == pSubrecord)
		m_pItemName = NULL;
	else if (m_pDescription == pSubrecord)
		m_pDescription = NULL;
	else if (m_pSpellData == pSubrecord)
		m_pSpellData = NULL;
	else
		CSrIdRecord::OnDeleteSubrecord(pSubrecord);

}
/*===========================================================================
 *		End of Class Event CSrSpelRecord::OnDeleteSubrecord()
 *=========================================================================*/

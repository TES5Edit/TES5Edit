/*===========================================================================
 *
 * File:		SrScrlRecord.CPP
 * Author:		Dave Humphrey (dave@uesp.net)
 * Created On:	5 December 2011
 *
 * Description
 *
 *=========================================================================*/

	/* Include Files */
#include "srScrlrecord.h"
#include "../srrecordhandler.h"


srscrldata_t     CSrScrlRecord::s_NullScrollData;
srscrlspitdata_t CSrScrlRecord::s_NullSpitData;


/*===========================================================================
 *
 * Begin Subrecord Creation Array
 *
 *=========================================================================*/
BEGIN_SRSUBRECCREATE(CSrScrlRecord, CSrItem1Record)
	DEFINE_SRSUBRECCREATE(SR_NAME_ETYP, CSrFormidSubrecord::Create)
	DEFINE_SRSUBRECCREATE(SR_NAME_EFID, CSrFormidSubrecord::Create)
	DEFINE_SRSUBRECCREATE(SR_NAME_DESC, CSrLStringSubrecord::Create)
	DEFINE_SRSUBRECCREATE(SR_NAME_MDOB, CSrFormidSubrecord::Create)
	DEFINE_SRSUBRECCREATE(SR_NAME_DATA, CSrScrlDataSubrecord::Create)
	DEFINE_SRSUBRECCREATE(SR_NAME_SPIT, CSrScrlSpitSubrecord::Create)
	DEFINE_SRSUBRECCREATE(SR_NAME_EFIT, CSrEfitSubrecord::Create)
	DEFINE_SRSUBRECCREATE(SR_NAME_CTDA, CSrCtdaSubrecord::Create)
	DEFINE_SRSUBRECCREATE(SR_NAME_CIS1, CSrStringSubrecord::Create)
	DEFINE_SRSUBRECCREATE(SR_NAME_CIS2, CSrStringSubrecord::Create)
END_SRSUBRECCREATE()
/*===========================================================================
 *		End of Subrecord Creation Array
 *=========================================================================*/


/*===========================================================================
 *
 * Begin CSrItem1Record Field Map
 *
 *=========================================================================*/
BEGIN_SRFIELDMAP(CSrScrlRecord, CSrItem1Record)
	ADD_SRFIELDALL("ItemName",				SR_FIELD_ITEMNAME,				0, CSrScrlRecord, FieldItemName)
	ADD_SRFIELDALL("Description",			SR_FIELD_DESCRIPTION,			0, CSrScrlRecord, FieldDescription)
	ADD_SRFIELDALL("EffectCount",			SR_FIELD_EFFECTCOUNT,			0, CSrScrlRecord, FieldEffectCount)
	ADD_SRFIELDALL("EquipSlot",				SR_FIELD_EQUIPSLOT,				0, CSrScrlRecord, FieldEquipSlot)
	ADD_SRFIELDALL("InventoryModel",		SR_FIELD_INVENTORYMODEL,		0, CSrScrlRecord, FieldInventoryModel)
	ADD_SRFIELDALL("Weight",				SR_FIELD_WEIGHT,				0, CSrScrlRecord, FieldWeight)
	ADD_SRFIELDALL("Value",					SR_FIELD_VALUE,					0, CSrScrlRecord, FieldValue)
	ADD_SRFIELDALL("Range",					SR_FIELD_RANGE,					0, CSrScrlRecord, FieldRange)
	ADD_SRFIELDALL("CastDuration",			SR_FIELD_CASTTIME,				0, CSrScrlRecord, FieldCastDuration)
	ADD_SRFIELDALL("ChargeTime",			SR_FIELD_CHARGETIME,			0, CSrScrlRecord, FieldChargeTime)
	ADD_SRFIELDALL("DeliveryType",			SR_FIELD_DELIVERYTYPE,			0, CSrScrlRecord, FieldDeliveryType)
	ADD_SRFIELDALL("CastType",				SR_FIELD_CASTTYPE,				0, CSrScrlRecord, FieldCastType)
	ADD_SRFIELDALL("BaseCost",				SR_FIELD_BASECOST,				0, CSrScrlRecord, FieldBaseCost)
	ADD_SRFIELDALL("AutoCalc",				SR_FIELD_AUTOCALC,				0, CSrScrlRecord, FieldAutoCalc)
	ADD_SRFIELDALL("AreaIgnoresLOS",		SR_FIELD_AREAIGNORESLOS,		0, CSrScrlRecord, FieldAreaIgnoresLOS)
	ADD_SRFIELDALL("NoAbsorbReflect",		SR_FIELD_NOABSORBREFLECT,		0, CSrScrlRecord, FieldNoAbsorbReflect)
	ADD_SRFIELDALL("ScriptAlwaysApplies",	SR_FIELD_SCRIPTALWAYSAPPLIES,	0, CSrScrlRecord, FieldScriptAlwaysApplies)
	ADD_SRFIELDALL("ForceExplode",			SR_FIELD_FORCEEXPLODE,			0, CSrScrlRecord, FieldForceExplode)
END_SRFIELDMAP()
/*===========================================================================
 *		End of CObRecord Field Map
 *=========================================================================*/


/*===========================================================================
 *
 * Class CSrScrlRecord Constructor
 *
 *=========================================================================*/
CSrScrlRecord::CSrScrlRecord () 
{
	m_pEquipSlot = NULL;
	m_pDescription = NULL;
	m_pScrlData = NULL;
	m_pSpitData = NULL;
	m_pInventoryModel = NULL;
}
/*===========================================================================
 *		End of Class CSrScrlRecord Constructor
 *=========================================================================*/


/*===========================================================================
 *
 * Class CSrScrlRecord Method - void Destroy (void);
 *
 *=========================================================================*/
void CSrScrlRecord::Destroy (void) 
{
	m_pEquipSlot = NULL;
	m_pDescription = NULL;
	m_pScrlData = NULL;
	m_pSpitData = NULL;
	m_pInventoryModel = NULL;

	CSrItem1Record::Destroy();
}
/*===========================================================================
 *		End of Class Method CSrScrlRecord::Destroy()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CSrScrlRecord Method - void InitializeNew (void);
 *
 *=========================================================================*/
void CSrScrlRecord::InitializeNew (void) 
{
	CSrItem1Record::InitializeNew();

	AddNewSubrecord(SR_NAME_DATA);
	if (m_pScrlData != NULL) m_pScrlData->InitializeNew();

	AddNewSubrecord(SR_NAME_SPIT);
	if (m_pSpitData != NULL) m_pSpitData->InitializeNew();

	AddNewSubrecord(SR_NAME_DESC);
	if (m_pDescription != NULL) m_pDescription->InitializeNew();

	AddNewSubrecord(SR_NAME_ETYP);
	if (m_pEquipSlot != NULL) m_pEquipSlot->InitializeNew();

}
/*===========================================================================
 *		End of Class Method CSrScrlRecord::InitializeNew()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CSrScrlRecord Event - void OnAddSubrecord (pSubrecord);
 *
 *=========================================================================*/
void CSrScrlRecord::OnAddSubrecord (CSrSubrecord* pSubrecord) {

	if (pSubrecord->GetRecordType() == SR_NAME_ETYP)
	{
		m_pEquipSlot = SrCastClass(CSrFormidSubrecord, pSubrecord);
	}
	else if (pSubrecord->GetRecordType() == SR_NAME_MDOB)
	{
		m_pInventoryModel = SrCastClass(CSrFormidSubrecord, pSubrecord);
	}
	else if (pSubrecord->GetRecordType() == SR_NAME_DESC)
	{
		m_pDescription = SrCastClass(CSrLStringSubrecord, pSubrecord);
	}
	else if (pSubrecord->GetRecordType() == SR_NAME_DATA)
	{
		m_pScrlData = SrCastClass(CSrScrlDataSubrecord, pSubrecord);
	}
	else if (pSubrecord->GetRecordType() == SR_NAME_SPIT)
	{
		m_pSpitData = SrCastClass(CSrScrlSpitSubrecord, pSubrecord);
	}
	else
	{
		CSrItem1Record::OnAddSubrecord(pSubrecord);
	}

}
/*===========================================================================
 *		End of Class Event CSrScrlRecord::OnAddSubRecord()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CSrScrlRecord Event - void OnDeleteSubrecord (pSubrecord);
 *
 *=========================================================================*/
void CSrScrlRecord::OnDeleteSubrecord (CSrSubrecord* pSubrecord) {

	if (m_pEquipSlot == pSubrecord)
		m_pEquipSlot = NULL;
	else if (m_pInventoryModel == pSubrecord)
		m_pInventoryModel = NULL;
	else if (m_pDescription == pSubrecord)
		m_pDescription = NULL;
	else if (m_pScrlData == pSubrecord)
		m_pScrlData = NULL;
	else if (m_pSpitData == pSubrecord)
		m_pSpitData = NULL;
	else
		CSrItem1Record::OnDeleteSubrecord(pSubrecord);

}
/*===========================================================================
 *		End of Class Event CSrScrlRecord::OnDeleteSubrecord()
 *=========================================================================*/

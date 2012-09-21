/*===========================================================================
 *
 * File:		SrEnchRecord.CPP
 * Author:		Dave Humphrey (dave@uesp.net)
 * Created On:	5 December 2011
 *
 * Description
 *

	Y = pow(X,1.100793579) * 0.3939184269
	Y = cost
	X = BaseCost * Magnitude * Duration * Area (?)

 *=========================================================================*/

	/* Include Files */
#include "srEnchrecord.h"
#include "../srrecordhandler.h"


srenitdata_t CSrEnchRecord::s_NullEffectData = { 0 };


/*===========================================================================
 *
 * Begin Subrecord Creation Array
 *
 *=========================================================================*/
BEGIN_SRSUBRECCREATE(CSrEnchRecord, CSrIdRecord)
	DEFINE_SRSUBRECCREATE(SR_NAME_EFID, CSrFormidSubrecord::Create)
	DEFINE_SRSUBRECCREATE(SR_NAME_CIS1, CSrStringSubrecord::Create)
	DEFINE_SRSUBRECCREATE(SR_NAME_CIS2, CSrStringSubrecord::Create)
	DEFINE_SRSUBRECCREATE(SR_NAME_FULL, CSrLStringSubrecord::Create)
	DEFINE_SRSUBRECCREATE(SR_NAME_CTDA, CSrCtdaSubrecord::Create)
	DEFINE_SRSUBRECCREATE(SR_NAME_EFIT, CSrEfitSubrecord::Create)
	DEFINE_SRSUBRECCREATE(SR_NAME_ENIT, CSrEnitSubrecord::Create)
END_SRSUBRECCREATE()
/*===========================================================================
 *		End of Subrecord Creation Array
 *=========================================================================*/


/*===========================================================================
 *
 * Begin CSrRecord Field Map
 *
 *=========================================================================*/
BEGIN_SRFIELDMAP(CSrEnchRecord, CSrIdRecord)
	ADD_SRFIELDALL("ItemName",			SR_FIELD_ITEMNAME,			0, CSrEnchRecord, FieldItemName)
	ADD_SRFIELDALL("ConditionCount",	SR_FIELD_CONDITIONCOUNT,	0, CSrEnchRecord, FieldConditionCount)
	ADD_SRFIELDALL("EffectCount",		SR_FIELD_EFFECTCOUNT,		0, CSrEnchRecord, FieldEffectCount)
	ADD_SRFIELDALL("BaseEnchant",		SR_FIELD_BASEENCHANT,		0, CSrEnchRecord, FieldBaseEnchant)
	ADD_SRFIELDALL("ItemTypes",			SR_FIELD_ITEMTYPES,			0, CSrEnchRecord, FieldItemTypes)
	ADD_SRFIELDALL("EnchantCost",		SR_FIELD_ENCHANTCOST,		0, CSrEnchRecord, FieldEnchantCost)
	ADD_SRFIELDALL("ChargeAmount",		SR_FIELD_CHARGE,			0, CSrEnchRecord, FieldChargeAmount)
	ADD_SRFIELDALL("ChargeTime",		SR_FIELD_CHARGETIME,		0, CSrEnchRecord, FieldChargeTime)
	ADD_SRFIELDALL("MagicFlags",		SR_FIELD_MAGICFLAGS,		0, CSrEnchRecord, FieldMagicFlags)
	ADD_SRFIELDALL("AutoCalc",			SR_FIELD_AUTOCALC,			0, CSrEnchRecord, FieldAutoCalc)
	ADD_SRFIELDALL("ExtendDuration",	SR_FIELD_EXTENDDURATION,	0, CSrEnchRecord, FieldExtendDuration)
	ADD_SRFIELDALL("CastType",			SR_FIELD_CASTTYPE,			0, CSrEnchRecord, FieldCastType)
	ADD_SRFIELDALL("TargetType",		SR_FIELD_DELIVERYTYPE,		0, CSrEnchRecord, FieldDeliveryType)
	ADD_SRFIELDALL("EnchantType",		SR_FIELD_ENCHANTTYPE,		0, CSrEnchRecord, FieldEnchantType)
END_SRFIELDMAP()
/*===========================================================================
 *		End of CObRecord Field Map
 *=========================================================================*/


/*===========================================================================
 *
 * Class CSrEnchRecord Constructor
 *
 *=========================================================================*/
CSrEnchRecord::CSrEnchRecord () 
{
	m_pItemName = NULL;
	m_pEffectData = NULL;
}
/*===========================================================================
 *		End of Class CSrEnchRecord Constructor
 *=========================================================================*/


/*===========================================================================
 *
 * Class CSrEnchRecord Method - void Destroy (void);
 *
 *=========================================================================*/
void CSrEnchRecord::Destroy (void) 
{
	m_pItemName = NULL;
	m_pEffectData = NULL;

	CSrIdRecord::Destroy();
}
/*===========================================================================
 *		End of Class Method CSrEnchRecord::Destroy()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CSrEnchRecord Method - void InitializeNew (void);
 *
 *=========================================================================*/
void CSrEnchRecord::InitializeNew (void) 
{
	CSrIdRecord::InitializeNew();

	AddNewSubrecord(SR_NAME_FULL);
	if (m_pItemName != NULL) m_pItemName->InitializeNew();

	AddNewSubrecord(SR_NAME_ENIT);
	if (m_pEffectData != NULL) m_pEffectData->InitializeNew();

}
/*===========================================================================
 *		End of Class Method CSrEnchRecord::InitializeNew()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CSrEnchRecord Event - void OnAddSubrecord (pSubrecord);
 *
 *=========================================================================*/
void CSrEnchRecord::OnAddSubrecord (CSrSubrecord* pSubrecord) 
{

	if (pSubrecord->GetRecordType() == SR_NAME_FULL)
	{
		m_pItemName = SrCastClass(CSrLStringSubrecord, pSubrecord);
	}
	else if (pSubrecord->GetRecordType() == SR_NAME_ENIT)
	{
		m_pEffectData = SrCastClass(CSrEnitSubrecord, pSubrecord);
	}
	else
	{
		CSrIdRecord::OnAddSubrecord(pSubrecord);
	}

}
/*===========================================================================
 *		End of Class Event CSrEnchRecord::OnAddSubRecord()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CSrEnchRecord Event - void OnDeleteSubrecord (pSubrecord);
 *
 *=========================================================================*/
void CSrEnchRecord::OnDeleteSubrecord (CSrSubrecord* pSubrecord) 
{

	if (m_pItemName == pSubrecord)
		m_pItemName = NULL;
	else if (m_pEffectData == pSubrecord)
		m_pEffectData = NULL;
	else
		CSrIdRecord::OnDeleteSubrecord(pSubrecord);

}
/*===========================================================================
 *		End of Class Event CSrEnchRecord::OnDeleteSubrecord()
 *=========================================================================*/

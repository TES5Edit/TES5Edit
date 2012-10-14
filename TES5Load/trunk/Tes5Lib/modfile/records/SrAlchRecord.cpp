/*===========================================================================
 *
 * File:		SrAlchRecord.CPP
 * Author:		Dave Humphrey (dave@uesp.net)
 * Created On:	5 December 2011
 *
 * Description
 *
 *=========================================================================*/

	/* Include Files */
#include "srAlchrecord.h"
#include "../srrecordhandler.h"


sralchdata_t     CSrAlchRecord::s_NullAlchData;
srenitalchdata_t CSrAlchRecord::s_NullAlchEnitData;


/*===========================================================================
 *
 * Begin Subrecord Creation Array
 *
 *=========================================================================*/
BEGIN_SRSUBRECCREATE(CSrAlchRecord, CSrItem1Record)
	DEFINE_SRSUBRECCREATE(SR_NAME_EFID, CSrFormidSubrecord::Create)
	DEFINE_SRSUBRECCREATE(SR_NAME_MODT, CSrDataSubrecord::Create)
	DEFINE_SRSUBRECCREATE(SR_NAME_MICO, CSrStringSubrecord::Create)
	DEFINE_SRSUBRECCREATE(SR_NAME_ENIT, CSrEnitAlchSubrecord::Create)
	DEFINE_SRSUBRECCREATE(SR_NAME_EFIT, CSrEfitSubrecord::Create)
	DEFINE_SRSUBRECCREATE(SR_NAME_DATA, CSrAlchDataSubrecord::Create)
	DEFINE_SRSUBRECCREATE(SR_NAME_CTDA, CSrCtdaSubrecord::Create)
	DEFINE_SRSUBRECCREATE(SR_NAME_YNAM, CSrFormidSubrecord::Create)
	DEFINE_SRSUBRECCREATE(SR_NAME_ZNAM, CSrFormidSubrecord::Create)
	DEFINE_SRSUBRECCREATE(SR_NAME_MODS, CSrDataSubrecord::Create)
	DEFINE_SRSUBRECCREATE(SR_NAME_CIS1, CSrStringSubrecord::Create)
	DEFINE_SRSUBRECCREATE(SR_NAME_CIS2, CSrStringSubrecord::Create)
	DEFINE_SRSUBRECCREATE(SR_NAME_ETYP, CSrFormidSubrecord::Create)
END_SRSUBRECCREATE()
/*===========================================================================
 *		End of Subrecord Creation Array
 *=========================================================================*/


/*===========================================================================
 *
 * Begin CSrRecord Field Map
 *
 *=========================================================================*/
BEGIN_SRFIELDMAP(CSrAlchRecord, CSrItem1Record)
	ADD_SRFIELDALL("Weight",			SR_FIELD_WEIGHT,			0, CSrAlchRecord, FieldWeight)
	ADD_SRFIELDALL("Value",				SR_FIELD_VALUE,				0, CSrAlchRecord, FieldValue)
	ADD_SRFIELDALL("MagicFlags",		SR_FIELD_MAGICFLAGS,		0, CSrAlchRecord, FieldMagicFlags)
	ADD_SRFIELDALL("PickupSound",		SR_FIELD_PICKUPSOUND,		0, CSrAlchRecord, FieldPickupSound)
	ADD_SRFIELDALL("DropSound",			SR_FIELD_DROPSOUND,			0, CSrAlchRecord, FieldDropSound)
	ADD_SRFIELDALL("UseSound",			SR_FIELD_USESOUND,			0, CSrAlchRecord, FieldUseSound)
	ADD_SRFIELDALL("EffectCount",		SR_FIELD_EFFECTCOUNT,		0, CSrAlchRecord, FieldEffectCount)
	ADD_SRFIELDALL("EquipType",			SR_FIELD_EQUIPSLOT,			0, CSrAlchRecord, FieldEquipType)
	ADD_SRFIELDALL("Addiction",			SR_FIELD_ADDICTION,			0, CSrAlchRecord, FieldAddiction)
	ADD_SRFIELDALL("AddictionChance",	SR_FIELD_ADDICTIONCHANCE,	0, CSrAlchRecord, FieldAddictionChance)
	ADD_SRFIELDALL("Poison",			SR_FIELD_POISON,			0, CSrAlchRecord, FieldPoison)
	ADD_SRFIELDALL("Medicine",			SR_FIELD_MEDICINE,			0, CSrAlchRecord, FieldMedicine)
	ADD_SRFIELDALL("Food",				SR_FIELD_FOOD,				0, CSrAlchRecord, FieldFood)
	ADD_SRFIELDALL("AutoCalc",			SR_FIELD_AUTOCALC,			0, CSrAlchRecord, FieldAutoCalc)
	ADD_SRFIELDALL("MessageIcon",		SR_FIELD_MESSAGEICON,		0, CSrAlchRecord, FieldMessageIcon)
END_SRFIELDMAP()
/*===========================================================================
 *		End of CObRecord Field Map
 *=========================================================================*/


/*===========================================================================
 *
 * Class CSrAlchRecord Constructor
 *
 *=========================================================================*/
CSrAlchRecord::CSrAlchRecord () 
{
	m_pMessageIcon = NULL;
	m_pEnitData = NULL;
	m_pAlchData = NULL;
	m_pPickupSound = NULL;
	m_pDropSound = NULL;
	m_pEquipType = NULL;
}
/*===========================================================================
 *		End of Class CSrAlchRecord Constructor
 *=========================================================================*/


/*===========================================================================
 *
 * Class CSrAlchRecord Method - void Destroy (void);
 *
 *=========================================================================*/
void CSrAlchRecord::Destroy (void) 
{
	m_pMessageIcon = NULL;
	m_pEnitData = NULL;
	m_pAlchData = NULL;
	m_pPickupSound = NULL;
	m_pDropSound = NULL;
	m_pEquipType = NULL;

	CSrItem1Record::Destroy();
}
/*===========================================================================
 *		End of Class Method CSrAlchRecord::Destroy()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CSrAlchRecord Method - void InitializeNew (void);
 *
 *=========================================================================*/
void CSrAlchRecord::InitializeNew (void) 
{
	CSrItem1Record::InitializeNew();

	AddNewSubrecord(SR_NAME_DATA);
	if (m_pAlchData != NULL) m_pAlchData->InitializeNew();

	AddNewSubrecord(SR_NAME_ENIT);
	if (m_pEnitData != NULL) m_pEnitData->InitializeNew();
}
/*===========================================================================
 *		End of Class Method CSrAlchRecord::InitializeNew()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CSrAlchRecord Event - void OnAddSubrecord (pSubrecord);
 *
 *=========================================================================*/
void CSrAlchRecord::OnAddSubrecord (CSrSubrecord* pSubrecord) {

	if (pSubrecord->GetRecordType() == SR_NAME_MICO)
	{
		m_pMessageIcon = SrCastClass(CSrStringSubrecord, pSubrecord);
	}
	else if (pSubrecord->GetRecordType() == SR_NAME_ETYP)
	{
		m_pEquipType = SrCastClass(CSrFormidSubrecord, pSubrecord);
	}
	else if (pSubrecord->GetRecordType() == SR_NAME_ENIT)
	{
		m_pEnitData = SrCastClass(CSrEnitAlchSubrecord, pSubrecord);
	}
	else if (pSubrecord->GetRecordType() == SR_NAME_DATA)
	{
		m_pAlchData = SrCastClass(CSrAlchDataSubrecord, pSubrecord);
	}
	else if (pSubrecord->GetRecordType() == SR_NAME_YNAM)
	{
		m_pPickupSound = SrCastClass(CSrFormidSubrecord, pSubrecord);
	}
	else if (pSubrecord->GetRecordType() == SR_NAME_ZNAM)
	{
		m_pDropSound = SrCastClass(CSrFormidSubrecord, pSubrecord);
	}
	else
	{
		CSrItem1Record::OnAddSubrecord(pSubrecord);
	}

}
/*===========================================================================
 *		End of Class Event CSrAlchRecord::OnAddSubRecord()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CSrAlchRecord Event - void OnDeleteSubrecord (pSubrecord);
 *
 *=========================================================================*/
void CSrAlchRecord::OnDeleteSubrecord (CSrSubrecord* pSubrecord) {

	if (m_pMessageIcon == pSubrecord)
		m_pMessageIcon = NULL;
	else if (m_pEnitData == pSubrecord)
		m_pEnitData = NULL;
	else if (m_pEquipType == pSubrecord)
		m_pEquipType = NULL;
	else if (m_pAlchData == pSubrecord)
		m_pAlchData = NULL;
	else if (m_pPickupSound == pSubrecord)
		m_pPickupSound = NULL;
	else if (m_pDropSound == pSubrecord)
		m_pDropSound = NULL;
	else
		CSrItem1Record::OnDeleteSubrecord(pSubrecord);

}
/*===========================================================================
 *		End of Class Event CSrAlchRecord::OnDeleteSubrecord()
 *=========================================================================*/


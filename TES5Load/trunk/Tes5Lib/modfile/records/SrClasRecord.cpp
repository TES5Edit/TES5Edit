/*===========================================================================
 *
 * File:		SrClasRecord.CPP
 * Author:		Dave Humphrey (dave@uesp.net)
 * Created On:	5 December 2011
 *
 * Description
 *
 *=========================================================================*/

	/* Include Files */
#include "srClasrecord.h"


srclasdata_t CSrClasRecord::s_NullClassData;


/*===========================================================================
 *
 * Begin Subrecord Creation Array
 *
 *=========================================================================*/
BEGIN_SRSUBRECCREATE(CSrClasRecord, CSrIdRecord)
	DEFINE_SRSUBRECCREATE(SR_NAME_DESC, CSrLStringSubrecord::Create)
	DEFINE_SRSUBRECCREATE(SR_NAME_FULL, CSrLStringSubrecord::Create)
	DEFINE_SRSUBRECCREATE(SR_NAME_DATA, CSrClasDataSubrecord::Create)
END_SRSUBRECCREATE()
/*===========================================================================
 *		End of Subrecord Creation Array
 *=========================================================================*/


/*===========================================================================
 *
 * Begin CSrRecord Field Map
 *
 *=========================================================================*/
BEGIN_SRFIELDMAP(CSrClasRecord, CSrIdRecord)
	ADD_SRFIELDALL("ItemName",		SR_FIELD_ITEMNAME,		0, CSrClasRecord, FieldItemName)
	ADD_SRFIELDALL("Description",	SR_FIELD_DESCRIPTION,	0, CSrClasRecord, FieldDescription)
	ADD_SRFIELDALL("Unknown1",		SR_FIELD_UNKNOWN1,		0, CSrClasRecord, FieldUnknown1)
	ADD_SRFIELDALL("Unknown2",		SR_FIELD_UNKNOWN2,		0, CSrClasRecord, FieldUnknown2)
	ADD_SRFIELDALL("TrainerSkill",	SR_FIELD_TRAINERSKILL,	0, CSrClasRecord, FieldTrainerSkill)
	ADD_SRFIELDALL("TrainerLevel",	SR_FIELD_TRAINERLEVEL,	0, CSrClasRecord, FieldTrainerLevel)
	ADD_SRFIELDALL("Unknown3",		SR_FIELD_UNKNOWN3,		0, CSrClasRecord, FieldUnknown3)
	ADD_SRFIELDALL("Unknown4",		SR_FIELD_UNKNOWN4,		0, CSrClasRecord, FieldUnknown4)
	ADD_SRFIELDALL("Unknown5",		SR_FIELD_UNKNOWN5,		0, CSrClasRecord, FieldUnknown5)
	ADD_SRFIELDALL("Unknown6",		SR_FIELD_UNKNOWN6,		0, CSrClasRecord, FieldUnknown6)
	ADD_SRFIELDALL("Unknown7",		SR_FIELD_UNKNOWN7,		0, CSrClasRecord, FieldUnknown7)
	ADD_SRFIELDALL("Unknown8",		SR_FIELD_UNKNOWN8,		0, CSrClasRecord, FieldUnknown8)
	ADD_SRFIELDALL("OneHand",		SR_FIELD_ONEHAND,		0, CSrClasRecord, FieldOneHand)
	ADD_SRFIELDALL("TwoHand",		SR_FIELD_TWOHAND,		0, CSrClasRecord, FieldTwoHand)
	ADD_SRFIELDALL("Marksman",		SR_FIELD_MARKSMAN,		0, CSrClasRecord, FieldMarksman)
	ADD_SRFIELDALL("Block",			SR_FIELD_BLOCK,			0, CSrClasRecord, FieldBlock)
	ADD_SRFIELDALL("Smithing",		SR_FIELD_SMITHING,		0, CSrClasRecord, FieldSmithing)
	ADD_SRFIELDALL("HeavyArmor",	SR_FIELD_HEAVYARMOR,	0, CSrClasRecord, FieldHeavyArmor)
	ADD_SRFIELDALL("LightArmor",	SR_FIELD_LIGHTARMOR,	0, CSrClasRecord, FieldLightArmor)
	ADD_SRFIELDALL("Pickpocket",	SR_FIELD_PICKPOCKET,	0, CSrClasRecord, FieldPickpocket)
	ADD_SRFIELDALL("Lockpicking",	SR_FIELD_LOCKPICKING,	0, CSrClasRecord, FieldLockpicking)
	ADD_SRFIELDALL("Sneak",			SR_FIELD_SNEAK,			0, CSrClasRecord, FieldSneak)
	ADD_SRFIELDALL("Alchemy",		SR_FIELD_ALCHEMY,		0, CSrClasRecord, FieldAlchemy)
	ADD_SRFIELDALL("Speechcraft",	SR_FIELD_SPEECHCRAFT,	0, CSrClasRecord, FieldSpeechcraft)
	ADD_SRFIELDALL("Alteration",	SR_FIELD_ALTERATION,	0, CSrClasRecord, FieldAlteration)
	ADD_SRFIELDALL("Conjuration",	SR_FIELD_CONJURATION,	0, CSrClasRecord, FieldConjuration)
	ADD_SRFIELDALL("Destruction",	SR_FIELD_DESTRUCTION,	0, CSrClasRecord, FieldDestruction)
	ADD_SRFIELDALL("Illusion",		SR_FIELD_ILLUSION,		0, CSrClasRecord, FieldIllusion)
	ADD_SRFIELDALL("Restoration",	SR_FIELD_RESTORATION,	0, CSrClasRecord, FieldRestoration)
	ADD_SRFIELDALL("Enchanting",	SR_FIELD_ENCHANTING,	0, CSrClasRecord, FieldEnchanting)
END_SRFIELDMAP()
/*===========================================================================
 *		End of CObRecord Field Map
 *=========================================================================*/


/*===========================================================================
 *
 * Class CSrClasRecord Constructor
 *
 *=========================================================================*/
CSrClasRecord::CSrClasRecord () 
{
	m_pDescription = NULL;
	m_pItemName = NULL;
	m_pClassData = NULL;
}
/*===========================================================================
 *		End of Class CSrClasRecord Constructor
 *=========================================================================*/


/*===========================================================================
 *
 * Class CSrClasRecord Method - void Destroy (void);
 *
 *=========================================================================*/
void CSrClasRecord::Destroy (void) 
{
	m_pDescription = NULL;
	m_pItemName = NULL;
	m_pClassData = NULL;

	CSrIdRecord::Destroy();
}
/*===========================================================================
 *		End of Class Method CSrClasRecord::Destroy()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CSrClasRecord Method - void InitializeNew (void);
 *
 *=========================================================================*/
void CSrClasRecord::InitializeNew (void) 
{
	CSrIdRecord::InitializeNew();

	AddNewSubrecord(SR_NAME_FULL);
	if (m_pItemName != NULL) m_pItemName->InitializeNew();

	AddNewSubrecord(SR_NAME_DESC);
	if (m_pDescription != NULL) m_pDescription->InitializeNew();

	AddNewSubrecord(SR_NAME_DATA);
	if (m_pClassData != NULL) m_pClassData->InitializeNew();
}
/*===========================================================================
 *		End of Class Method CSrClasRecord::InitializeNew()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CSrClasRecord Event - void OnAddSubrecord (pSubrecord);
 *
 *=========================================================================*/
void CSrClasRecord::OnAddSubrecord (CSrSubrecord* pSubrecord) {

	if (pSubrecord->GetRecordType() == SR_NAME_DESC)
	{
		m_pDescription = SrCastClass(CSrLStringSubrecord, pSubrecord);
	}
	else if (pSubrecord->GetRecordType() == SR_NAME_FULL)
	{
		m_pItemName = SrCastClass(CSrLStringSubrecord, pSubrecord);
	}
	else if (pSubrecord->GetRecordType() == SR_NAME_DATA)
	{
		m_pClassData = SrCastClass(CSrClasDataSubrecord, pSubrecord);
	}
	else
	{
		CSrIdRecord::OnAddSubrecord(pSubrecord);
	}

}
/*===========================================================================
 *		End of Class Event CSrClasRecord::OnAddSubRecord()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CSrClasRecord Event - void OnDeleteSubrecord (pSubrecord);
 *
 *=========================================================================*/
void CSrClasRecord::OnDeleteSubrecord (CSrSubrecord* pSubrecord) {

	if (m_pDescription == pSubrecord)
		m_pDescription = NULL;
	else if (m_pItemName == pSubrecord)
		m_pItemName = NULL;
	else if (m_pClassData == pSubrecord)
		m_pClassData = NULL;
	else
		CSrIdRecord::OnDeleteSubrecord(pSubrecord);

}
/*===========================================================================
 *		End of Class Event CSrClasRecord::OnDeleteSubrecord()
 *=========================================================================*/


/*===========================================================================
 *
 * Begin CSrClasRecord Get Field Methods
 *
 *=========================================================================*/
/*===========================================================================
 *		End of CSrClasRecord Get Field Methods
 *=========================================================================*/


/*===========================================================================
 *
 * Begin CSrClasRecord Compare Field Methods
 *
 *=========================================================================*/
/*===========================================================================
 *		End of CSrClasRecord Compare Field Methods
 *=========================================================================*/


/*===========================================================================
 *
 * Begin CSrClasRecord Set Field Methods
 *
 *=========================================================================*/
/*===========================================================================
 *		End of CSrClasRecord Set Field Methods
 *=========================================================================*/

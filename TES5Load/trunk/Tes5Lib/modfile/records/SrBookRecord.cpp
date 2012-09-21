/*===========================================================================
 *
 * File:		SrBookRecord.CPP
 * Author:		Dave Humphrey (dave@uesp.net)
 * Created On:	5 December 2011
 *
 * Description
 *
 *=========================================================================*/

	/* Include Files */
#include "srBookrecord.h"
#include "../srrecordhandler.h"


srbookdata_t CSrBookRecord::s_NullBookData;


/*===========================================================================
 *
 * Begin Subrecord Creation Array
 *
 *=========================================================================*/
BEGIN_SRSUBRECCREATE(CSrBookRecord, CSrItem1Record)
	DEFINE_SRSUBRECCREATE(SR_NAME_DESC, CSrLStringSubrecord::Create)
	DEFINE_SRSUBRECCREATE(SR_NAME_MODT, CSrDataSubrecord::Create)
	DEFINE_SRSUBRECCREATE(SR_NAME_DATA, CSrBookDataSubrecord::Create)
	DEFINE_SRSUBRECCREATE(SR_NAME_INAM, CSrFormidSubrecord::Create)
	DEFINE_SRSUBRECCREATE(SR_NAME_CNAM, CSrLStringSubrecord::Create)
	DEFINE_SRSUBRECCREATE(SR_NAME_YNAM, CSrFormidSubrecord::Create)
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
BEGIN_SRFIELDMAP(CSrBookRecord, CSrItem1Record)
	ADD_SRFIELDALL("Value",			SR_FIELD_VALUE,			0, CSrBookRecord, FieldValue)
	ADD_SRFIELDALL("Weight",		SR_FIELD_WEIGHT,		0, CSrBookRecord, FieldWeight)
	ADD_SRFIELDALL("Description",	SR_FIELD_DESCRIPTION,	0, CSrBookRecord, FieldDescription)	
	ADD_SRFIELDALL("PickupSound",	SR_FIELD_PICKUPSOUND,	0, CSrBookRecord, FieldPickupSound)
	ADD_SRFIELDALL("CNam",			SR_FIELD_CNAM,			0, CSrBookRecord, FieldCNam)
	ADD_SRFIELDALL("Static",		SR_FIELD_STATIC,		0, CSrBookRecord, FieldStatic)
	ADD_SRFIELDALL("SpellTome",		SR_FIELD_SPELLTOME,		0, CSrBookRecord, FieldSpellTome)
	ADD_SRFIELDALL("SkillBook",		SR_FIELD_SKILLBOOK,		0, CSrBookRecord, FieldSkillBook)
	ADD_SRFIELDALL("Skill",			SR_FIELD_SKILL,			0, CSrBookRecord, FieldSkill)
	ADD_SRFIELDALL("Scroll",		SR_FIELD_SCROLL,		0, CSrBookRecord, FieldScroll)
	ADD_SRFIELDALL("Spell",			SR_FIELD_SPELL,			0, CSrBookRecord, FieldSpell)
END_SRFIELDMAP()
/*===========================================================================
 *		End of CObRecord Field Map
 *=========================================================================*/


/*===========================================================================
 *
 * Class CSrBookRecord Constructor
 *
 *=========================================================================*/
CSrBookRecord::CSrBookRecord () 
{
	m_pBoundsData = NULL;
	m_pDescription = NULL;
	m_pModtData = NULL;
	m_pBookData = NULL;
	m_pStatic = NULL;
	m_pCnamData = NULL;
	m_pPickupSound = NULL;
	m_pVmadData = NULL;
}
/*===========================================================================
 *		End of Class CSrBookRecord Constructor
 *=========================================================================*/


/*===========================================================================
 *
 * Class CSrBookRecord Method - void Destroy (void);
 *
 *=========================================================================*/
void CSrBookRecord::Destroy (void) 
{
	m_pBoundsData = NULL;
	m_pDescription = NULL;
	m_pModtData = NULL;
	m_pBookData = NULL;
	m_pStatic = NULL;
	m_pCnamData = NULL;
	m_pPickupSound = NULL;
	m_pVmadData = NULL;

	CSrItem1Record::Destroy();
}
/*===========================================================================
 *		End of Class Method CSrBookRecord::Destroy()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CSrBookRecord Method - void InitializeNew (void);
 *
 *=========================================================================*/
void CSrBookRecord::InitializeNew (void) 
{
	CSrItem1Record::InitializeNew();

	AddNewSubrecord(SR_NAME_DESC);
	if (m_pDescription != NULL) m_pDescription->InitializeNew();

	AddNewSubrecord(SR_NAME_DATA);
	if (m_pBookData != NULL) m_pBookData->InitializeNew();

}
/*===========================================================================
 *		End of Class Method CSrBookRecord::InitializeNew()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CSrBookRecord Event - void OnAddSubrecord (pSubrecord);
 *
 *=========================================================================*/
void CSrBookRecord::OnAddSubrecord (CSrSubrecord* pSubrecord) {

	if (pSubrecord->GetRecordType() == SR_NAME_OBND)
	{
		m_pBoundsData = SrCastClass(CSrDataSubrecord, pSubrecord);
	}
	else if (pSubrecord->GetRecordType() == SR_NAME_DESC)
	{
		m_pDescription = SrCastClass(CSrLStringSubrecord, pSubrecord);
	}
	else if (pSubrecord->GetRecordType() == SR_NAME_MODT)
	{
		m_pModtData = SrCastClass(CSrDataSubrecord, pSubrecord);
	}
	else if (pSubrecord->GetRecordType() == SR_NAME_DATA)
	{
		m_pBookData = SrCastClass(CSrBookDataSubrecord, pSubrecord);
	}
	else if (pSubrecord->GetRecordType() == SR_NAME_INAM)
	{
		m_pStatic = SrCastClass(CSrFormidSubrecord, pSubrecord);
	}
	else if (pSubrecord->GetRecordType() == SR_NAME_CNAM)
	{
		m_pCnamData = SrCastClass(CSrLStringSubrecord, pSubrecord);
	}
	else if (pSubrecord->GetRecordType() == SR_NAME_YNAM)
	{
		m_pPickupSound = SrCastClass(CSrFormidSubrecord, pSubrecord);
	}
	else if (pSubrecord->GetRecordType() == SR_NAME_VMAD)
	{
		m_pVmadData = SrCastClass(CSrVmadSubrecord, pSubrecord);
	}
	else
	{
		CSrItem1Record::OnAddSubrecord(pSubrecord);
	}

}
/*===========================================================================
 *		End of Class Event CSrBookRecord::OnAddSubRecord()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CSrBookRecord Event - void OnDeleteSubrecord (pSubrecord);
 *
 *=========================================================================*/
void CSrBookRecord::OnDeleteSubrecord (CSrSubrecord* pSubrecord) {

	if (m_pBoundsData == pSubrecord)
		m_pBoundsData = NULL;
	else if (m_pDescription == pSubrecord)
		m_pDescription = NULL;
	else if (m_pModtData == pSubrecord)
		m_pModtData = NULL;
	else if (m_pBookData == pSubrecord)
		m_pBookData = NULL;
	else if (m_pStatic == pSubrecord)
		m_pStatic = NULL;
	else if (m_pCnamData == pSubrecord)
		m_pCnamData = NULL;
	else if (m_pPickupSound == pSubrecord)
		m_pPickupSound = NULL;
	else if (m_pVmadData == pSubrecord)
		m_pVmadData = NULL;
	else
		CSrItem1Record::OnDeleteSubrecord(pSubrecord);

}
/*===========================================================================
 *		End of Class Event CSrBookRecord::OnDeleteSubrecord()
 *=========================================================================*/


void CSrBookRecord::SetBookSpell (const char* pString)
{
	if (!IsBookSpellTome()) return;

	if (m_pParent == NULL) return;
	CSrRecord* pRecord = m_pParent->FindEditorID(pString);

	if (pRecord == NULL)
		GetBookData().SkillID = 0;
	else
		GetBookData().SkillID = pRecord->GetFormID();

}

/*===========================================================================
 *
 * Begin CSrBookRecord Get Field Methods
 *
 *=========================================================================*/
/*===========================================================================
 *		End of CSrBookRecord Get Field Methods
 *=========================================================================*/


/*===========================================================================
 *
 * Begin CSrBookRecord Compare Field Methods
 *
 *=========================================================================*/
/*===========================================================================
 *		End of CSrBookRecord Compare Field Methods
 *=========================================================================*/


/*===========================================================================
 *
 * Begin CSrBookRecord Set Field Methods
 *
 *=========================================================================*/
/*===========================================================================
 *		End of CSrBookRecord Set Field Methods
 *=========================================================================*/

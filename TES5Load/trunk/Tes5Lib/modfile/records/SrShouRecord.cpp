/*===========================================================================
 *
 * File:		SrShouRecord.CPP
 * Author:		Dave Humphrey (dave@uesp.net)
 * Created On:	5 December 2011
 *
 * Description
 *
 *=========================================================================*/

	/* Include Files */
#include "srShourecord.h"


srshousnamdata_t CSrShouRecord::s_NullShoutData;


/*===========================================================================
 *
 * Begin Subrecord Creation Array
 *
 *=========================================================================*/
BEGIN_SRSUBRECCREATE(CSrShouRecord, CSrIdRecord)
	DEFINE_SRSUBRECCREATE(SR_NAME_SNAM, CSrShouSnamSubrecord::Create)
	DEFINE_SRSUBRECCREATE(SR_NAME_DESC, CSrLStringSubrecord::Create)
	DEFINE_SRSUBRECCREATE(SR_NAME_FULL, CSrLStringSubrecord::Create)
	DEFINE_SRSUBRECCREATE(SR_NAME_MDOB, CSrFormidSubrecord::Create)
END_SRSUBRECCREATE()
/*===========================================================================
 *		End of Subrecord Creation Array
 *=========================================================================*/


/*===========================================================================
 *
 * Begin CSrIdRecord Field Map
 *
 *=========================================================================*/
BEGIN_SRFIELDMAP(CSrShouRecord, CSrIdRecord)
	ADD_SRFIELDALL("Spell1",		SR_FIELD_SPELL1,		0, CSrShouRecord, FieldSpell1)
	ADD_SRFIELDALL("Spell2",		SR_FIELD_SPELL2,		0, CSrShouRecord, FieldSpell2)
	ADD_SRFIELDALL("Spell3",		SR_FIELD_SPELL3,		0, CSrShouRecord, FieldSpell3)
	ADD_SRFIELDALL("PowerWord1",	SR_FIELD_POWERWORD1,	0, CSrShouRecord, FieldPowerWord1)
	ADD_SRFIELDALL("PowerWord2",	SR_FIELD_POWERWORD2,	0, CSrShouRecord, FieldPowerWord2)
	ADD_SRFIELDALL("PowerWord3",	SR_FIELD_POWERWORD3,	0, CSrShouRecord, FieldPowerWord3)
	ADD_SRFIELDALL("Recharge1",		SR_FIELD_RECHARGE1,		0, CSrShouRecord, FieldRecharge1)
	ADD_SRFIELDALL("Recharge2",		SR_FIELD_RECHARGE2,		0, CSrShouRecord, FieldRecharge2)
	ADD_SRFIELDALL("Recharge3",		SR_FIELD_RECHARGE3,		0, CSrShouRecord, FieldRecharge3)
	ADD_SRFIELDALL("ItemName",		SR_FIELD_ITEMNAME,		0, CSrShouRecord, FieldItemName)
	ADD_SRFIELDALL("Description",	SR_FIELD_DESCRIPTION,	0, CSrShouRecord, FieldDescription)
	ADD_SRFIELDALL("Static",		SR_FIELD_STATIC,		0, CSrShouRecord, FieldStatic)
END_SRFIELDMAP()
/*===========================================================================
 *		End of CObRecord Field Map
 *=========================================================================*/


/*===========================================================================
 *
 * Class CSrShouRecord Constructor
 *
 *=========================================================================*/
CSrShouRecord::CSrShouRecord () 
{
	m_pShoutData1 = NULL;
	m_pShoutData2 = NULL;
	m_pShoutData3 = NULL;
	m_pDescription = NULL;
	m_pItemName = NULL;
	m_pStatic = NULL;
}
/*===========================================================================
 *		End of Class CSrShouRecord Constructor
 *=========================================================================*/


/*===========================================================================
 *
 * Class CSrShouRecord Method - void Destroy (void);
 *
 *=========================================================================*/
void CSrShouRecord::Destroy (void) 
{
	m_pShoutData1 = NULL;
	m_pShoutData2 = NULL;
	m_pShoutData3 = NULL;
	m_pDescription = NULL;
	m_pItemName = NULL;
	m_pStatic = NULL;

	CSrIdRecord::Destroy();
}
/*===========================================================================
 *		End of Class Method CSrShouRecord::Destroy()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CSrShouRecord Method - void InitializeNew (void);
 *
 *=========================================================================*/
void CSrShouRecord::InitializeNew (void) 
{
	CSrIdRecord::InitializeNew();

	AddNewSubrecord(SR_NAME_SNAM);
	AddNewSubrecord(SR_NAME_SNAM);
	AddNewSubrecord(SR_NAME_SNAM);

	if (m_pShoutData1 != NULL) m_pShoutData1->InitializeNew();
	if (m_pShoutData2 != NULL) m_pShoutData2->InitializeNew();
	if (m_pShoutData3 != NULL) m_pShoutData3->InitializeNew();
}
/*===========================================================================
 *		End of Class Method CSrShouRecord::InitializeNew()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CSrShouRecord Event - void OnAddSubrecord (pSubrecord);
 *
 *=========================================================================*/
void CSrShouRecord::OnAddSubrecord (CSrSubrecord* pSubrecord) {

	if (pSubrecord->GetRecordType() == SR_NAME_DESC)
	{
		m_pDescription = SrCastClass(CSrLStringSubrecord, pSubrecord);
	}
	else if (pSubrecord->GetRecordType() == SR_NAME_FULL)
	{
		m_pItemName = SrCastClass(CSrLStringSubrecord, pSubrecord);
	}
	else if (pSubrecord->GetRecordType() == SR_NAME_MDOB)
	{
		m_pStatic = SrCastClass(CSrFormidSubrecord, pSubrecord);
	}
	else if (pSubrecord->GetRecordType() == SR_NAME_SNAM)
	{
		if (m_pShoutData1 == NULL)
			m_pShoutData1 = SrCastClass(CSrShouSnamSubrecord, pSubrecord);
		else if (m_pShoutData2 == NULL)
			m_pShoutData2 = SrCastClass(CSrShouSnamSubrecord, pSubrecord);
		else if (m_pShoutData3 == NULL)
			m_pShoutData3 = SrCastClass(CSrShouSnamSubrecord, pSubrecord);
	}
	else
	{
		CSrIdRecord::OnAddSubrecord(pSubrecord);
	}

}
/*===========================================================================
 *		End of Class Event CSrShouRecord::OnAddSubRecord()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CSrShouRecord Event - void OnDeleteSubrecord (pSubrecord);
 *
 *=========================================================================*/
void CSrShouRecord::OnDeleteSubrecord (CSrSubrecord* pSubrecord) {

	if (m_pDescription == pSubrecord)
		m_pDescription = NULL;
	else if (m_pItemName == pSubrecord)
		m_pItemName = NULL;
	else if (m_pStatic == pSubrecord)
		m_pStatic = NULL;
	else if (m_pShoutData1 == pSubrecord)
		m_pShoutData1 = NULL;
	else if (m_pShoutData2 == pSubrecord)
		m_pShoutData2 = NULL;
	else if (m_pShoutData3 == pSubrecord)
		m_pShoutData3 = NULL;
	else
		CSrIdRecord::OnDeleteSubrecord(pSubrecord);

}
/*===========================================================================
 *		End of Class Event CSrShouRecord::OnDeleteSubrecord()
 *=========================================================================*/


void CSrShouRecord::ForceValidSnamCount (void)
{
	dword Count = CountSubrecords(SR_NAME_SNAM);

	if (Count == 3) return;

	if (Count > 3)
	{
		int Position;
		CSrSubrecord* pSubrecord = FindFirstSubrecord(SR_NAME_SNAM, Position);
		int Count = 0;

		while (pSubrecord)
		{
			++Count;
			pSubrecord = FindNextSubrecord(SR_NAME_SNAM, Position);
			--Position;
			m_Subrecords.Delete(Position);
		}
	}
	else if (Count < 3)
	{
		for (dword i = Count; i < 3; ++i)
		{
			AddNewSubrecord(SR_NAME_SNAM);
		}
	}
}


/*===========================================================================
 *
 * Begin CSrShouRecord Get Field Methods
 *
 *=========================================================================*/
/*===========================================================================
 *		End of CSrShouRecord Get Field Methods
 *=========================================================================*/


/*===========================================================================
 *
 * Begin CSrShouRecord Compare Field Methods
 *
 *=========================================================================*/
/*===========================================================================
 *		End of CSrShouRecord Compare Field Methods
 *=========================================================================*/


/*===========================================================================
 *
 * Begin CSrShouRecord Set Field Methods
 *
 *=========================================================================*/
/*===========================================================================
 *		End of CSrShouRecord Set Field Methods
 *=========================================================================*/

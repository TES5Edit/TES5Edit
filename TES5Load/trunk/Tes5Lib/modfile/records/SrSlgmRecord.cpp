/*===========================================================================
 *
 * File:		SrSlgmRecord.CPP
 * Author:		Dave Humphrey (dave@uesp.net)
 * Created On:	5 December 2011
 *
 * Description
 *
 *=========================================================================*/

	/* Include Files */
#include "srslgmrecord.h"


srslgmdata_t CSrSlgmRecord::s_NullSlgmData;


/*===========================================================================
 *
 * Begin Subrecord Creation Array
 *
 *=========================================================================*/
BEGIN_SRSUBRECCREATE(CSrSlgmRecord, CSrItem1Record)
	DEFINE_SRSUBRECCREATE(SR_NAME_SOUL, CSrByteSubrecord::Create)
	DEFINE_SRSUBRECCREATE(SR_NAME_MODT, CSrDataSubrecord::Create)
	DEFINE_SRSUBRECCREATE(SR_NAME_DATA, CSrSlgmDataSubrecord::Create)
	DEFINE_SRSUBRECCREATE(SR_NAME_SLCP, CSrByteSubrecord::Create)
	DEFINE_SRSUBRECCREATE(SR_NAME_NAM0, CSrFormidSubrecord::Create)
END_SRSUBRECCREATE()
/*===========================================================================
 *		End of Subrecord Creation Array
 *=========================================================================*/


/*===========================================================================
 *
 * Begin CSrItem1Record Field Map
 *
 *=========================================================================*/
BEGIN_SRFIELDMAP(CSrSlgmRecord, CSrItem1Record)
	ADD_SRFIELDALL("Value",			SR_FIELD_VALUE,				0, CSrSlgmRecord, FieldValue)
	ADD_SRFIELDALL("Weight",		SR_FIELD_WEIGHT,			0, CSrSlgmRecord, FieldWeight)
	ADD_SRFIELDALL("Capacity",		SR_FIELD_CAPACITY,			0, CSrSlgmRecord, FieldCapacity)
	ADD_SRFIELDALL("FilledGem",		SR_FIELD_FILLEDGEM,			0, CSrSlgmRecord, FieldFilledGem)
	ADD_SRFIELDALL("CurrentSoul",	SR_FIELD_CURRENTSOUL,		0, CSrSlgmRecord, FieldCurrentSoul)	
END_SRFIELDMAP()
/*===========================================================================
 *		End of CObRecord Field Map
 *=========================================================================*/


/*===========================================================================
 *
 * Class CSrSlgmRecord Constructor
 *
 *=========================================================================*/
CSrSlgmRecord::CSrSlgmRecord () 
{
	m_pCurrentSoul = NULL;
	m_pSlgmData = NULL;
	m_pCapacity = NULL;
	m_pFilledGem = NULL;
}
/*===========================================================================
 *		End of Class CSrSlgmRecord Constructor
 *=========================================================================*/


/*===========================================================================
 *
 * Class CSrSlgmRecord Method - void Destroy (void);
 *
 *=========================================================================*/
void CSrSlgmRecord::Destroy (void) 
{
	m_pCurrentSoul = NULL;
	m_pSlgmData = NULL;
	m_pCapacity = NULL;
	m_pFilledGem = NULL;

	CSrItem1Record::Destroy();
}
/*===========================================================================
 *		End of Class Method CSrSlgmRecord::Destroy()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CSrSlgmRecord Method - void InitializeNew (void);
 *
 *=========================================================================*/
void CSrSlgmRecord::InitializeNew (void) 
{
	CSrItem1Record::InitializeNew();

	AddNewSubrecord(SR_NAME_DATA);
	if (m_pSlgmData != NULL) m_pSlgmData->InitializeNew();

	AddNewSubrecord(SR_NAME_SOUL);
	if (m_pCurrentSoul != NULL) m_pCurrentSoul->InitializeNew();

	AddNewSubrecord(SR_NAME_SLCP);
	if (m_pCapacity != NULL) m_pCapacity->InitializeNew();

	AddNewSubrecord(SR_NAME_NAM0);
	if (m_pFilledGem != NULL) m_pFilledGem->InitializeNew();

}
/*===========================================================================
 *		End of Class Method CSrSlgmRecord::InitializeNew()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CSrSlgmRecord Event - void OnAddSubrecord (pSubrecord);
 *
 *=========================================================================*/
void CSrSlgmRecord::OnAddSubrecord (CSrSubrecord* pSubrecord) {

	if (pSubrecord->GetRecordType() == SR_NAME_SOUL)
	{
		m_pCurrentSoul = SrCastClass(CSrByteSubrecord, pSubrecord);
	}
	else if (pSubrecord->GetRecordType() == SR_NAME_DATA)
	{
		m_pSlgmData = SrCastClass(CSrSlgmDataSubrecord, pSubrecord);
	}
	else if (pSubrecord->GetRecordType() == SR_NAME_SLCP)
	{
		m_pCapacity = SrCastClass(CSrByteSubrecord, pSubrecord);
	}
	else if (pSubrecord->GetRecordType() == SR_NAME_NAM0)
	{
		m_pFilledGem = SrCastClass(CSrFormidSubrecord, pSubrecord);
	}
	else
	{
		CSrItem1Record::OnAddSubrecord(pSubrecord);
	}

}
/*===========================================================================
 *		End of Class Event CSrSlgmRecord::OnAddSubRecord()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CSrSlgmRecord Event - void OnDeleteSubrecord (pSubrecord);
 *
 *=========================================================================*/
void CSrSlgmRecord::OnDeleteSubrecord (CSrSubrecord* pSubrecord) {

	if (m_pCurrentSoul == pSubrecord)
		m_pCurrentSoul = NULL;
	else if (m_pSlgmData == pSubrecord)
		m_pSlgmData = NULL;
	else if (m_pCapacity == pSubrecord)
		m_pCapacity = NULL;
	else if (m_pFilledGem == pSubrecord)
		m_pFilledGem = NULL;
	else
		CSrItem1Record::OnDeleteSubrecord(pSubrecord);

}
/*===========================================================================
 *		End of Class Event CSrSlgmRecord::OnDeleteSubrecord()
 *=========================================================================*/


/*===========================================================================
 *
 * Begin CSrSlgmRecord Get Field Methods
 *
 *=========================================================================*/
/*===========================================================================
 *		End of CSrSlgmRecord Get Field Methods
 *=========================================================================*/


/*===========================================================================
 *
 * Begin CSrSlgmRecord Compare Field Methods
 *
 *=========================================================================*/
/*===========================================================================
 *		End of CSrSlgmRecord Compare Field Methods
 *=========================================================================*/


/*===========================================================================
 *
 * Begin CSrSlgmRecord Set Field Methods
 *
 *=========================================================================*/
/*===========================================================================
 *		End of CSrSlgmRecord Set Field Methods
 *=========================================================================*/

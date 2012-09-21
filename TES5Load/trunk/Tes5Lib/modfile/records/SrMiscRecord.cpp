/*===========================================================================
 *
 * File:		SrMiscRecord.CPP
 * Author:		Dave Humphrey (dave@uesp.net)
 * Created On:	5 December 2011
 *
 * Description
 *
 *=========================================================================*/

	/* Include Files */
#include "srMiscrecord.h"


srmiscdata_t CSrMiscRecord::s_NullMiscData;


/*===========================================================================
 *
 * Begin Subrecord Creation Array
 *
 *=========================================================================*/
BEGIN_SRSUBRECCREATE(CSrMiscRecord, CSrItem1Record)
	DEFINE_SRSUBRECCREATE(SR_NAME_VMAD, CSrVmadSubrecord::Create)
	DEFINE_SRSUBRECCREATE(SR_NAME_MODT, CSrDataSubrecord::Create)
	DEFINE_SRSUBRECCREATE(SR_NAME_DATA, CSrMiscDataSubrecord::Create)
	DEFINE_SRSUBRECCREATE(SR_NAME_MODS, CSrDataSubrecord::Create)
	DEFINE_SRSUBRECCREATE(SR_NAME_YNAM, CSrFormidSubrecord::Create)
	DEFINE_SRSUBRECCREATE(SR_NAME_ZNAM, CSrFormidSubrecord::Create)
END_SRSUBRECCREATE()
/*===========================================================================
 *		End of Subrecord Creation Array
 *=========================================================================*/


/*===========================================================================
 *
 * Begin CSrRecord Field Map
 *
 *=========================================================================*/
BEGIN_SRFIELDMAP(CSrMiscRecord, CSrItem1Record)
	ADD_SRFIELDALL("Value",			SR_FIELD_VALUE,			0, CSrMiscRecord, FieldValue)
	ADD_SRFIELDALL("Weight",		SR_FIELD_WEIGHT,		0, CSrMiscRecord, FieldWeight)
	ADD_SRFIELDALL("PickupSound",	SR_FIELD_PICKUPSOUND,	0, CSrMiscRecord, FieldPickupSound)
	ADD_SRFIELDALL("DropSound",		SR_FIELD_DROPSOUND,		0, CSrMiscRecord, FieldDropSound)
END_SRFIELDMAP()
/*===========================================================================
 *		End of CObRecord Field Map
 *=========================================================================*/


/*===========================================================================
 *
 * Class CSrMiscRecord Constructor
 *
 *=========================================================================*/
CSrMiscRecord::CSrMiscRecord () 
{
	m_pObndData = NULL;
	m_pVmadData = NULL;
	m_pModtData = NULL;
	m_pMiscData = NULL;
	m_pModsData = NULL;
	m_pPickupSound = NULL;
	m_pDropSound = NULL;
}
/*===========================================================================
 *		End of Class CSrMiscRecord Constructor
 *=========================================================================*/


/*===========================================================================
 *
 * Class CSrMiscRecord Method - void Destroy (void);
 *
 *=========================================================================*/
void CSrMiscRecord::Destroy (void) 
{
	m_pObndData = NULL;
	m_pVmadData = NULL;
	m_pModtData = NULL;
	m_pMiscData = NULL;
	m_pModsData = NULL;
	m_pPickupSound = NULL;
	m_pDropSound = NULL;

	CSrItem1Record::Destroy();
}
/*===========================================================================
 *		End of Class Method CSrMiscRecord::Destroy()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CSrMiscRecord Method - void InitializeNew (void);
 *
 *=========================================================================*/
void CSrMiscRecord::InitializeNew (void) 
{
	CSrItem1Record::InitializeNew();

	AddNewSubrecord(SR_NAME_DATA);
	if (m_pMiscData != NULL) m_pMiscData->InitializeNew();
}
/*===========================================================================
 *		End of Class Method CSrMiscRecord::InitializeNew()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CSrMiscRecord Event - void OnAddSubrecord (pSubrecord);
 *
 *=========================================================================*/
void CSrMiscRecord::OnAddSubrecord (CSrSubrecord* pSubrecord) {

	if (pSubrecord->GetRecordType() == SR_NAME_VMAD)
	{
		m_pVmadData = SrCastClass(CSrVmadSubrecord, pSubrecord);
	}
	else if (pSubrecord->GetRecordType() == SR_NAME_MODT)
	{
		m_pModtData = SrCastClass(CSrDataSubrecord, pSubrecord);
	}
	else if (pSubrecord->GetRecordType() == SR_NAME_DATA)
	{
		m_pMiscData = SrCastClass(CSrMiscDataSubrecord, pSubrecord);
	}
	else if (pSubrecord->GetRecordType() == SR_NAME_MODS)
	{
		m_pModsData = SrCastClass(CSrDataSubrecord, pSubrecord);
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
 *		End of Class Event CSrMiscRecord::OnAddSubRecord()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CSrMiscRecord Event - void OnDeleteSubrecord (pSubrecord);
 *
 *=========================================================================*/
void CSrMiscRecord::OnDeleteSubrecord (CSrSubrecord* pSubrecord) {

	if (m_pVmadData == pSubrecord)
		m_pVmadData = NULL;
	else if (m_pModtData == pSubrecord)
		m_pModtData = NULL;
	else if (m_pMiscData == pSubrecord)
		m_pMiscData = NULL;
	else if (m_pModsData == pSubrecord)
		m_pModsData = NULL;
	else if (m_pPickupSound == pSubrecord)
		m_pPickupSound = NULL;
	else if (m_pDropSound == pSubrecord)
		m_pDropSound = NULL;
	else
		CSrItem1Record::OnDeleteSubrecord(pSubrecord);

}
/*===========================================================================
 *		End of Class Event CSrMiscRecord::OnDeleteSubrecord()
 *=========================================================================*/


/*===========================================================================
 *
 * Begin CSrMiscRecord Get Field Methods
 *
 *=========================================================================*/
/*===========================================================================
 *		End of CSrMiscRecord Get Field Methods
 *=========================================================================*/


/*===========================================================================
 *
 * Begin CSrMiscRecord Compare Field Methods
 *
 *=========================================================================*/
/*===========================================================================
 *		End of CSrMiscRecord Compare Field Methods
 *=========================================================================*/


/*===========================================================================
 *
 * Begin CSrMiscRecord Set Field Methods
 *
 *=========================================================================*/
/*===========================================================================
 *		End of CSrMiscRecord Set Field Methods
 *=========================================================================*/

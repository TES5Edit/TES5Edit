/*===========================================================================
 *
 * File:		SrActiRecord.CPP
 * Author:		Dave Humphrey (dave@uesp.net)
 * Created On:	5 December 2011
 *
 * Description
 *
 *=========================================================================*/

	/* Include Files */
#include "srActirecord.h"


sractidestdata_t CSrActiRecord::s_NullDestData;


/*===========================================================================
 *
 * Begin Subrecord Creation Array
 *
 *=========================================================================*/
BEGIN_SRSUBRECCREATE(CSrActiRecord, CSrIdRecord)
	DEFINE_SRSUBRECCREATE(SR_NAME_FNAM, CSrDataSubrecord::Create)
	DEFINE_SRSUBRECCREATE(SR_NAME_MODL, CSrStringSubrecord::Create)
	DEFINE_SRSUBRECCREATE(SR_NAME_FULL, CSrLStringSubrecord::Create)
	DEFINE_SRSUBRECCREATE(SR_NAME_DMDS, CSrDataSubrecord::Create)
	DEFINE_SRSUBRECCREATE(SR_NAME_PNAM, CSrDwordSubrecord::Create)
	DEFINE_SRSUBRECCREATE(SR_NAME_KNAM, CSrFormidSubrecord::Create)
	DEFINE_SRSUBRECCREATE(SR_NAME_DEST, CSrActiDestSubrecord::Create)
	DEFINE_SRSUBRECCREATE(SR_NAME_VMAD, CSrVmadSubrecord::Create)
	DEFINE_SRSUBRECCREATE(SR_NAME_MODT, CSrDataSubrecord::Create)
	DEFINE_SRSUBRECCREATE(SR_NAME_MODS, CSrDataSubrecord::Create)
	DEFINE_SRSUBRECCREATE(SR_NAME_DSTD, CSrDataSubrecord::Create)
	DEFINE_SRSUBRECCREATE(SR_NAME_DMDL, CSrStringSubrecord::Create)
	DEFINE_SRSUBRECCREATE(SR_NAME_DMDT, CSrDataSubrecord::Create)
	DEFINE_SRSUBRECCREATE(SR_NAME_DSTF, CSrDataSubrecord::Create)
	DEFINE_SRSUBRECCREATE(SR_NAME_RNAM, CSrLStringSubrecord::Create)
	DEFINE_SRSUBRECCREATE(SR_NAME_VNAM, CSrFormidSubrecord::Create)
	DEFINE_SRSUBRECCREATE(SR_NAME_WNAM, CSrFormidSubrecord::Create)
	DEFINE_SRSUBRECCREATE(SR_NAME_SNAM, CSrFormidSubrecord::Create)
END_SRSUBRECCREATE()
/*===========================================================================
 *		End of Subrecord Creation Array
 *=========================================================================*/


/*===========================================================================
 *
 * Begin CSrRecord Field Map
 *
 *=========================================================================*/
BEGIN_SRFIELDMAP(CSrActiRecord, CSrIdRecord)
	ADD_SRFIELDALL("ItemName",		SR_FIELD_ITEMNAME,		0, CSrActiRecord, FieldItemName)
	ADD_SRFIELDALL("Model",			SR_FIELD_MODEL,			0, CSrActiRecord, FieldModel)
	ADD_SRFIELDALL("DestroyModel",	SR_FIELD_DESTROYMODEL,	0, CSrActiRecord, FieldDestroyModel)
	ADD_SRFIELDALL("Unknown1",		SR_FIELD_UNKNOWN1,		0, CSrActiRecord, FieldUnknown1)
	ADD_SRFIELDALL("Unknown2",		SR_FIELD_UNKNOWN2,		0, CSrActiRecord, FieldUnknown2)
	ADD_SRFIELDALL("Unknown3",		SR_FIELD_UNKNOWN3,		0, CSrActiRecord, FieldUnknown3)
	ADD_SRFIELDALL("Unknown4",		SR_FIELD_UNKNOWN4,		0, CSrActiRecord, FieldUnknown4)
	ADD_SRFIELDALL("AmbientSound",	SR_FIELD_AMBIENTSOUND,	0, CSrActiRecord, FieldAmbientSound)
	ADD_SRFIELDALL("UseSound",		SR_FIELD_USESOUND,		0, CSrActiRecord, FieldUseSound)
	ADD_SRFIELDALL("Water",			SR_FIELD_WATER,			0, CSrActiRecord, FieldWater)
	ADD_SRFIELDALL("Verb",			SR_FIELD_VERB,			0, CSrActiRecord, FieldVerb)
	ADD_SRFIELDALL("Keyword",		SR_FIELD_KEYWORD,		0, CSrActiRecord, FieldKeyword)
END_SRFIELDMAP()
/*===========================================================================
 *		End of CObRecord Field Map
 *=========================================================================*/


/*===========================================================================
 *
 * Class CSrActiRecord Constructor
 *
 *=========================================================================*/
CSrActiRecord::CSrActiRecord () 
{
	m_pModel = NULL;
	m_pItemName = NULL;
	m_pDestroyedModel = NULL;
	m_pDestructionData = NULL;
	m_pAmbientSound = NULL;
	m_pWater = NULL;
	m_pUseSound = NULL;
	m_pPnamData = NULL;
	m_pVerb = NULL;
	m_pKeyword = NULL;
}
/*===========================================================================
 *		End of Class CSrActiRecord Constructor
 *=========================================================================*/


/*===========================================================================
 *
 * Class CSrActiRecord Method - void Destroy (void);
 *
 *=========================================================================*/
void CSrActiRecord::Destroy (void) 
{
	m_pModel = NULL;
	m_pWater = NULL;
	m_pItemName = NULL;
	m_pDestroyedModel = NULL;
	m_pDestructionData = NULL;
	m_pAmbientSound = NULL;
	m_pUseSound = NULL;
	m_pPnamData = NULL;
	m_pVerb = NULL;
	m_pKeyword = NULL;

	CSrIdRecord::Destroy();
}
/*===========================================================================
 *		End of Class Method CSrActiRecord::Destroy()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CSrActiRecord Method - void InitializeNew (void);
 *
 *=========================================================================*/
void CSrActiRecord::InitializeNew (void) 
{
	CSrIdRecord::InitializeNew();

	AddNewSubrecord(SR_NAME_FULL);
	if (m_pItemName != NULL) m_pItemName->InitializeNew();

	AddNewSubrecord(SR_NAME_DEST);
	if (m_pDestructionData != NULL) m_pDestructionData->InitializeNew();
}
/*===========================================================================
 *		End of Class Method CSrActiRecord::InitializeNew()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CSrActiRecord Event - void OnAddSubrecord (pSubrecord);
 *
 *=========================================================================*/
void CSrActiRecord::OnAddSubrecord (CSrSubrecord* pSubrecord) {

	if (pSubrecord->GetRecordType() == SR_NAME_FNAM)
	{
		m_pFnamData = SrCastClass(CSrDataSubrecord, pSubrecord);
	}
	else if (pSubrecord->GetRecordType() == SR_NAME_DMDS)
	{
		m_pDmdsData = SrCastClass(CSrDataSubrecord, pSubrecord);
	}
	else if (pSubrecord->GetRecordType() == SR_NAME_MODL)
	{
		m_pModel = SrCastClass(CSrStringSubrecord, pSubrecord);
	}
	else if (pSubrecord->GetRecordType() == SR_NAME_FULL)
	{
		m_pItemName = SrCastClass(CSrLStringSubrecord, pSubrecord);
	}
	else if (pSubrecord->GetRecordType() == SR_NAME_PNAM)
	{
		m_pPnamData = SrCastClass(CSrDwordSubrecord, pSubrecord);
	}
	else if (pSubrecord->GetRecordType() == SR_NAME_KNAM)
	{
		m_pKeyword = SrCastClass(CSrFormidSubrecord, pSubrecord);
	}
	else if (pSubrecord->GetRecordType() == SR_NAME_DEST)
	{
		m_pDestructionData = SrCastClass(CSrActiDestSubrecord, pSubrecord);
	}
	else if (pSubrecord->GetRecordType() == SR_NAME_VMAD)
	{
		m_pVmadData = SrCastClass(CSrVmadSubrecord, pSubrecord);
	}
	else if (pSubrecord->GetRecordType() == SR_NAME_MODT)
	{
		m_pModtData = SrCastClass(CSrDataSubrecord, pSubrecord);
	}
	else if (pSubrecord->GetRecordType() == SR_NAME_MODS)
	{
		m_pModsData = SrCastClass(CSrDataSubrecord, pSubrecord);
	}
	else if (pSubrecord->GetRecordType() == SR_NAME_DSTD)
	{
		m_pDstdData = SrCastClass(CSrDataSubrecord, pSubrecord);
	}
	else if (pSubrecord->GetRecordType() == SR_NAME_DMDL)
	{
		m_pDestroyedModel = SrCastClass(CSrStringSubrecord, pSubrecord);
	}
	else if (pSubrecord->GetRecordType() == SR_NAME_DMDT)
	{
		m_pDmdtData = SrCastClass(CSrDataSubrecord, pSubrecord);
	}
	else if (pSubrecord->GetRecordType() == SR_NAME_DSTF)
	{
		m_pDstfData = SrCastClass(CSrDataSubrecord, pSubrecord);
	}
	else if (pSubrecord->GetRecordType() == SR_NAME_RNAM)
	{
		m_pVerb = SrCastClass(CSrLStringSubrecord, pSubrecord);
	}
	else if (pSubrecord->GetRecordType() == SR_NAME_VNAM)
	{
		m_pUseSound = SrCastClass(CSrFormidSubrecord, pSubrecord);
	}
	else if (pSubrecord->GetRecordType() == SR_NAME_WNAM)
	{
		m_pWater = SrCastClass(CSrFormidSubrecord, pSubrecord);
	}
	else if (pSubrecord->GetRecordType() == SR_NAME_SNAM)
	{
		m_pAmbientSound = SrCastClass(CSrFormidSubrecord, pSubrecord);
	}
	else
	{
		CSrIdRecord::OnAddSubrecord(pSubrecord);
	}

}
/*===========================================================================
 *		End of Class Event CSrActiRecord::OnAddSubRecord()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CSrActiRecord Event - void OnDeleteSubrecord (pSubrecord);
 *
 *=========================================================================*/
void CSrActiRecord::OnDeleteSubrecord (CSrSubrecord* pSubrecord) {

	if (m_pFnamData == pSubrecord)
		m_pFnamData = NULL;
	else if (m_pDmdsData == pSubrecord)
		m_pDmdsData = NULL;
	else if (m_pModel == pSubrecord)
		m_pModel = NULL;
	else if (m_pItemName == pSubrecord)
		m_pItemName = NULL;
	else if (m_pPnamData == pSubrecord)
		m_pPnamData = NULL;
	else if (m_pKeyword == pSubrecord)
		m_pKeyword = NULL;
	else if (m_pDestructionData == pSubrecord)
		m_pDestructionData = NULL;
	else if (m_pVmadData == pSubrecord)
		m_pVmadData = NULL;
	else if (m_pModtData == pSubrecord)
		m_pModtData = NULL;
	else if (m_pModsData == pSubrecord)
		m_pModsData = NULL;
	else if (m_pDstdData == pSubrecord)
		m_pDstdData = NULL;
	else if (m_pDestroyedModel == pSubrecord)
		m_pDestroyedModel = NULL;
	else if (m_pDmdtData == pSubrecord)
		m_pDmdtData = NULL;
	else if (m_pDstfData == pSubrecord)
		m_pDstfData = NULL;
	else if (m_pVerb == pSubrecord)
		m_pVerb = NULL;
	else if (m_pUseSound == pSubrecord)
		m_pUseSound = NULL;
	else if (m_pWater == pSubrecord)
		m_pWater = NULL;
	else if (m_pAmbientSound == pSubrecord)
		m_pAmbientSound = NULL;
	else
		CSrIdRecord::OnDeleteSubrecord(pSubrecord);

}
/*===========================================================================
 *		End of Class Event CSrActiRecord::OnDeleteSubrecord()
 *=========================================================================*/


/*===========================================================================
 *
 * Begin CSrActiRecord Get Field Methods
 *
 *=========================================================================*/
/*===========================================================================
 *		End of CSrActiRecord Get Field Methods
 *=========================================================================*/


/*===========================================================================
 *
 * Begin CSrActiRecord Compare Field Methods
 *
 *=========================================================================*/
/*===========================================================================
 *		End of CSrActiRecord Compare Field Methods
 *=========================================================================*/


/*===========================================================================
 *
 * Begin CSrActiRecord Set Field Methods
 *
 *=========================================================================*/
/*===========================================================================
 *		End of CSrActiRecord Set Field Methods
 *=========================================================================*/

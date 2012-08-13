/*===========================================================================
 *
 * File:		SrStatRecord.CPP
 * Author:		Dave Humphrey (dave@uesp.net)
 * Created On:	5 December 2011
 *
 * Description
 *
 *=========================================================================*/

	/* Include Files */
#include "srStatrecord.h"
#include "../srrecordhandler.h"


srdnamdata_t CSrStatRecord::s_NullDnamData;


/*===========================================================================
 *
 * Begin Subrecord Creation Array
 *
 *=========================================================================*/
BEGIN_SRSUBRECCREATE(CSrStatRecord, CSrIdRecord)
	DEFINE_SRSUBRECCREATE(SR_NAME_MODL, CSrStringSubrecord::Create)
	DEFINE_SRSUBRECCREATE(SR_NAME_DNAM, CSrDnamSubrecord::Create)
	DEFINE_SRSUBRECCREATE(SR_NAME_MODT, CSrDataSubrecord::Create)
	DEFINE_SRSUBRECCREATE(SR_NAME_MNAM, CSrDataSubrecord::Create)
	DEFINE_SRSUBRECCREATE(SR_NAME_MODS, CSrDataSubrecord::Create)
END_SRSUBRECCREATE()
/*===========================================================================
 *		End of Subrecord Creation Array
 *=========================================================================*/


/*===========================================================================
 *
 * Begin CSrIdRecord Field Map
 *
 *=========================================================================*/
BEGIN_SRFIELDMAP(CSrStatRecord, CSrIdRecord)
	ADD_SRFIELDALL("Model",			SR_FIELD_MODEL,		0, CSrStatRecord, FieldModel)
	ADD_SRFIELDALL("Scale",			SR_FIELD_SCALE,		0, CSrStatRecord, FieldScale)
	ADD_SRFIELDALL("Material",		SR_FIELD_MATERIAL,	0, CSrStatRecord, FieldMaterial)
END_SRFIELDMAP()
/*===========================================================================
 *		End of CObRecord Field Map
 *=========================================================================*/


/*===========================================================================
 *
 * Class CSrStatRecord Constructor
 *
 *=========================================================================*/
CSrStatRecord::CSrStatRecord () 
{
	m_pModlData = NULL;
	m_pDnamData = NULL;
	m_pModtData = NULL;
	m_pMnamData = NULL;
	m_pModsData = NULL;
}
/*===========================================================================
 *		End of Class CSrStatRecord Constructor
 *=========================================================================*/


/*===========================================================================
 *
 * Class CSrStatRecord Method - void Destroy (void);
 *
 *=========================================================================*/
void CSrStatRecord::Destroy (void) 
{
	m_pModlData = NULL;
	m_pDnamData = NULL;
	m_pModtData = NULL;
	m_pMnamData = NULL;
	m_pModsData = NULL;

	CSrIdRecord::Destroy();
}
/*===========================================================================
 *		End of Class Method CSrStatRecord::Destroy()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CSrStatRecord Method - void InitializeNew (void);
 *
 *=========================================================================*/
void CSrStatRecord::InitializeNew (void) 
{
	CSrIdRecord::InitializeNew();

	AddNewSubrecord(SR_NAME_MODL);
	if (m_pModlData != NULL) m_pModlData->InitializeNew();

	AddNewSubrecord(SR_NAME_OBND);
	if (m_pBounds != NULL) m_pBounds->InitializeNew();

	AddNewSubrecord(SR_NAME_DNAM);
	if (m_pDnamData != NULL) m_pDnamData->InitializeNew();

}
/*===========================================================================
 *		End of Class Method CSrStatRecord::InitializeNew()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CSrStatRecord Event - void OnAddSubrecord (pSubrecord);
 *
 *=========================================================================*/
void CSrStatRecord::OnAddSubrecord (CSrSubrecord* pSubrecord) {

	if (pSubrecord->GetRecordType() == SR_NAME_MODL)
	{
		m_pModlData = SrCastClass(CSrStringSubrecord, pSubrecord);
	}
	else if (pSubrecord->GetRecordType() == SR_NAME_DNAM)
	{
		m_pDnamData = SrCastClass(CSrDnamSubrecord, pSubrecord);
	}
	else if (pSubrecord->GetRecordType() == SR_NAME_MODT)
	{
		m_pModtData = SrCastClass(CSrDataSubrecord, pSubrecord);
	}
	else if (pSubrecord->GetRecordType() == SR_NAME_MNAM)
	{
		m_pMnamData = SrCastClass(CSrDataSubrecord, pSubrecord);
	}
	else if (pSubrecord->GetRecordType() == SR_NAME_MODS)
	{
		m_pModsData = SrCastClass(CSrDataSubrecord, pSubrecord);
	}
	else
	{
		CSrIdRecord::OnAddSubrecord(pSubrecord);
	}

}
/*===========================================================================
 *		End of Class Event CSrStatRecord::OnAddSubRecord()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CSrStatRecord Event - void OnDeleteSubrecord (pSubrecord);
 *
 *=========================================================================*/
void CSrStatRecord::OnDeleteSubrecord (CSrSubrecord* pSubrecord) {

	if (m_pModlData == pSubrecord)
		m_pModlData = NULL;
	else if (m_pDnamData == pSubrecord)
		m_pDnamData = NULL;
	else if (m_pModtData == pSubrecord)
		m_pModtData = NULL;
	else if (m_pMnamData == pSubrecord)
		m_pMnamData = NULL;
	else if (m_pModsData == pSubrecord)
		m_pModsData = NULL;
	else
		CSrIdRecord::OnDeleteSubrecord(pSubrecord);

}
/*===========================================================================
 *		End of Class Event CSrStatRecord::OnDeleteSubrecord()
 *=========================================================================*/


void CSrStatRecord::SetMaterial (const char* pString)
{
	if (m_pParent == NULL) return;

	if (m_pDnamData == NULL)
	{
		AddNewSubrecord(SR_NAME_DNAM);
		if (m_pDnamData == NULL) return;
		m_pDnamData->InitializeNew();
	}

	CSrRecord* pRecord = m_pParent->FindEditorID(pString);

	if (pRecord == NULL)
		m_pDnamData->GetDnamData().MaterialID = 0;
	else
		m_pDnamData->GetDnamData().MaterialID = pRecord->GetFormID();
}


/*===========================================================================
 *
 * Begin CSrStatRecord Get Field Methods
 *
 *=========================================================================*/
/*===========================================================================
 *		End of CSrStatRecord Get Field Methods
 *=========================================================================*/


/*===========================================================================
 *
 * Begin CSrStatRecord Compare Field Methods
 *
 *=========================================================================*/
/*===========================================================================
 *		End of CSrStatRecord Compare Field Methods
 *=========================================================================*/


/*===========================================================================
 *
 * Begin CSrStatRecord Set Field Methods
 *
 *=========================================================================*/
/*===========================================================================
 *		End of CSrStatRecord Set Field Methods
 *=========================================================================*/

/*===========================================================================
 *
 * File:		SrSnctRecord.CPP
 * Author:		Dave Humphrey (dave@uesp.net)
 * Created On:	5 December 2011
 *
 * Description
 *
 *=========================================================================*/

	/* Include Files */
#include "srsnctrecord.h"


/*===========================================================================
 *
 * Begin Subrecord Creation Array
 *
 *=========================================================================*/
BEGIN_SRSUBRECCREATE(CSrSnctRecord, CSrIdRecord)
	DEFINE_SRSUBRECCREATE(SR_NAME_VNAM, CSrWordSubrecord::Create)
	DEFINE_SRSUBRECCREATE(SR_NAME_FNAM, CSrDwordSubrecord::Create)
	DEFINE_SRSUBRECCREATE(SR_NAME_FULL, CSrLStringSubrecord::Create)
	DEFINE_SRSUBRECCREATE(SR_NAME_PNAM, CSrFormidSubrecord::Create)
	DEFINE_SRSUBRECCREATE(SR_NAME_UNAM, CSrWordSubrecord::Create)
END_SRSUBRECCREATE()
/*===========================================================================
 *		End of Subrecord Creation Array
 *=========================================================================*/


/*===========================================================================
 *
 * Begin CSrIdRecord Field Map
 *
 *=========================================================================*/
BEGIN_SRFIELDMAP(CSrSnctRecord, CSrIdRecord)
	ADD_SRFIELDALL("ItemName",		SR_FIELD_ITEMNAME,		0, CSrSnctRecord, FieldItemName)
	ADD_SRFIELDALL("Parent",		SR_FIELD_PARENT,		0, CSrSnctRecord, FieldParentCategory)
	ADD_SRFIELDALL("SoundFlags",	SR_FIELD_SOUNDFLAGS,	0, CSrSnctRecord, FieldSoundFlags)
	ADD_SRFIELDALL("Unknown1",		SR_FIELD_UNKNOWN1,		0, CSrSnctRecord, FieldVName)
	ADD_SRFIELDALL("Unknown2",		SR_FIELD_UNKNOWN2,		0, CSrSnctRecord, FieldUName)
END_SRFIELDMAP()
/*===========================================================================
 *		End of CObRecord Field Map
 *=========================================================================*/


/*===========================================================================
 *
 * Class CSrSnctRecord Constructor
 *
 *=========================================================================*/
CSrSnctRecord::CSrSnctRecord () 
{
	m_pFlags = NULL;
	m_pItemName = NULL;
	m_pParentCategory = NULL;
	m_pVnamData = NULL;
	m_pUnamData = NULL;
}
/*===========================================================================
 *		End of Class CSrSnctRecord Constructor
 *=========================================================================*/


/*===========================================================================
 *
 * Class CSrSnctRecord Method - void Destroy (void);
 *
 *=========================================================================*/
void CSrSnctRecord::Destroy (void) 
{
	m_pFlags = NULL;
	m_pItemName = NULL;
	m_pParentCategory = NULL;
	m_pVnamData = NULL;
	m_pUnamData = NULL;

	CSrIdRecord::Destroy();
}
/*===========================================================================
 *		End of Class Method CSrSnctRecord::Destroy()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CSrSnctRecord Method - void InitializeNew (void);
 *
 *=========================================================================*/
void CSrSnctRecord::InitializeNew (void) 
{
	CSrIdRecord::InitializeNew();


	AddNewSubrecord(SR_NAME_FULL);
	if (m_pItemName != NULL) m_pItemName->InitializeNew();

	AddNewSubrecord(SR_NAME_FNAM);
	if (m_pFlags != NULL) m_pFlags->InitializeNew();

	AddNewSubrecord(SR_NAME_VNAM);
	if (m_pVnamData != NULL) m_pVnamData->InitializeNew();

}
/*===========================================================================
 *		End of Class Method CSrSnctRecord::InitializeNew()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CSrSnctRecord Event - void OnAddSubrecord (pSubrecord);
 *
 *=========================================================================*/
void CSrSnctRecord::OnAddSubrecord (CSrSubrecord* pSubrecord) {

	if (pSubrecord->GetRecordType() == SR_NAME_VNAM)
	{
		m_pVnamData = SrCastClass(CSrWordSubrecord, pSubrecord);
	}
	else if (pSubrecord->GetRecordType() == SR_NAME_FNAM)
	{
		m_pFlags = SrCastClass(CSrDwordSubrecord, pSubrecord);
	}
	else if (pSubrecord->GetRecordType() == SR_NAME_FULL)
	{
		m_pItemName = SrCastClass(CSrLStringSubrecord, pSubrecord);
	}
	else if (pSubrecord->GetRecordType() == SR_NAME_PNAM)
	{
		m_pParentCategory = SrCastClass(CSrFormidSubrecord, pSubrecord);
	}
	else if (pSubrecord->GetRecordType() == SR_NAME_UNAM)
	{
		m_pUnamData = SrCastClass(CSrWordSubrecord, pSubrecord);
	}
	else
	{
		CSrIdRecord::OnAddSubrecord(pSubrecord);
	}

}
/*===========================================================================
 *		End of Class Event CSrSnctRecord::OnAddSubRecord()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CSrSnctRecord Event - void OnDeleteSubrecord (pSubrecord);
 *
 *=========================================================================*/
void CSrSnctRecord::OnDeleteSubrecord (CSrSubrecord* pSubrecord) {

	if (m_pVnamData == pSubrecord)
		m_pVnamData = NULL;
	else if (m_pItemName == pSubrecord)
		m_pItemName = NULL;
	else if (m_pFlags == pSubrecord)
		m_pFlags = NULL;
	else if (m_pParentCategory == pSubrecord)
		m_pParentCategory = NULL;
	else if (m_pUnamData == pSubrecord)
		m_pUnamData = NULL;
	else
		CSrIdRecord::OnDeleteSubrecord(pSubrecord);

}
/*===========================================================================
 *		End of Class Event CSrSnctRecord::OnDeleteSubrecord()
 *=========================================================================*/


/*===========================================================================
 *
 * Begin CSrSnctRecord Get Field Methods
 *
 *=========================================================================*/
/*===========================================================================
 *		End of CSrSnctRecord Get Field Methods
 *=========================================================================*/


/*===========================================================================
 *
 * Begin CSrSnctRecord Compare Field Methods
 *
 *=========================================================================*/
/*===========================================================================
 *		End of CSrSnctRecord Compare Field Methods
 *=========================================================================*/


/*===========================================================================
 *
 * Begin CSrSnctRecord Set Field Methods
 *
 *=========================================================================*/
/*===========================================================================
 *		End of CSrSnctRecord Set Field Methods
 *=========================================================================*/

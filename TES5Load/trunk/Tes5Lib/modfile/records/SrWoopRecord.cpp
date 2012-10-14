/*===========================================================================
 *
 * File:		SrWoopRecord.CPP
 * Author:		Dave Humphrey (dave@uesp.net)
 * Created On:	5 December 2011
 *
 * Description
 *
 *=========================================================================*/

	/* Include Files */
#include "srWooprecord.h"


/*===========================================================================
 *
 * Begin Subrecord Creation Array
 *
 *=========================================================================*/
BEGIN_SRSUBRECCREATE(CSrWoopRecord, CSrIdRecord)
	DEFINE_SRSUBRECCREATE(SR_NAME_TNAM, CSrLStringSubrecord::Create)
	DEFINE_SRSUBRECCREATE(SR_NAME_FULL, CSrLStringSubrecord::Create)
END_SRSUBRECCREATE()
/*===========================================================================
 *		End of Subrecord Creation Array
 *=========================================================================*/


/*===========================================================================
 *
 * Begin CSrIdRecord Field Map
 *
 *=========================================================================*/
BEGIN_SRFIELDMAP(CSrWoopRecord, CSrIdRecord)
	ADD_SRFIELDALL("ItemName",		SR_FIELD_ITEMNAME,		0, CSrWoopRecord, FieldItemName)
	ADD_SRFIELDALL("Translation",	SR_FIELD_TRANSLATION,	0, CSrWoopRecord, FieldTranslation)
END_SRFIELDMAP()
/*===========================================================================
 *		End of CObRecord Field Map
 *=========================================================================*/


/*===========================================================================
 *
 * Class CSrWoopRecord Constructor
 *
 *=========================================================================*/
CSrWoopRecord::CSrWoopRecord () 
{
	m_pTranslation = NULL;
	m_pItemName = NULL;
}
/*===========================================================================
 *		End of Class CSrWoopRecord Constructor
 *=========================================================================*/


/*===========================================================================
 *
 * Class CSrWoopRecord Method - void Destroy (void);
 *
 *=========================================================================*/
void CSrWoopRecord::Destroy (void) 
{
	m_pTranslation = NULL;
	m_pItemName = NULL;

	CSrIdRecord::Destroy();
}
/*===========================================================================
 *		End of Class Method CSrWoopRecord::Destroy()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CSrWoopRecord Method - void InitializeNew (void);
 *
 *=========================================================================*/
void CSrWoopRecord::InitializeNew (void) 
{
	CSrIdRecord::InitializeNew();

	AddNewSubrecord(SR_NAME_FULL);
	if (m_pItemName != NULL) m_pItemName->InitializeNew();

	AddNewSubrecord(SR_NAME_TNAM);
	if (m_pTranslation != NULL) m_pTranslation->InitializeNew();
}
/*===========================================================================
 *		End of Class Method CSrWoopRecord::InitializeNew()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CSrWoopRecord Event - void OnAddSubrecord (pSubrecord);
 *
 *=========================================================================*/
void CSrWoopRecord::OnAddSubrecord (CSrSubrecord* pSubrecord) {

	if (pSubrecord->GetRecordType() == SR_NAME_TNAM)
	{
		m_pTranslation = SrCastClass(CSrLStringSubrecord, pSubrecord);
	}
	else if (pSubrecord->GetRecordType() == SR_NAME_FULL)
	{
		m_pItemName = SrCastClass(CSrLStringSubrecord, pSubrecord);
	}
	else
	{
		CSrIdRecord::OnAddSubrecord(pSubrecord);
	}

}
/*===========================================================================
 *		End of Class Event CSrWoopRecord::OnAddSubRecord()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CSrWoopRecord Event - void OnDeleteSubrecord (pSubrecord);
 *
 *=========================================================================*/
void CSrWoopRecord::OnDeleteSubrecord (CSrSubrecord* pSubrecord) {

	if (m_pTranslation == pSubrecord)
		m_pTranslation = NULL;
	else if (m_pItemName == pSubrecord)
		m_pItemName = NULL;
	else
		CSrIdRecord::OnDeleteSubrecord(pSubrecord);

}
/*===========================================================================
 *		End of Class Event CSrWoopRecord::OnDeleteSubrecord()
 *=========================================================================*/


/*===========================================================================
 *
 * Begin CSrWoopRecord Get Field Methods
 *
 *=========================================================================*/
/*===========================================================================
 *		End of CSrWoopRecord Get Field Methods
 *=========================================================================*/


/*===========================================================================
 *
 * Begin CSrWoopRecord Compare Field Methods
 *
 *=========================================================================*/
/*===========================================================================
 *		End of CSrWoopRecord Compare Field Methods
 *=========================================================================*/


/*===========================================================================
 *
 * Begin CSrWoopRecord Set Field Methods
 *
 *=========================================================================*/
/*===========================================================================
 *		End of CSrWoopRecord Set Field Methods
 *=========================================================================*/

/*===========================================================================
 *
 * File:		SrWatrRecord.CPP
 * Author:		Dave Humphrey (dave@uesp.net)
 * Created On:	5 December 2011
 *
 * Description
 *
 *=========================================================================*/

	/* Include Files */
#include "srWatrrecord.h"


/*===========================================================================
 *
 * Begin Subrecord Creation Array
 *
 *=========================================================================*/
BEGIN_SRSUBRECCREATE(CSrWatrRecord, CSrIdRecord)
	DEFINE_SRSUBRECCREATE(SR_NAME_FNAM, CSrDataSubrecord::Create)
	DEFINE_SRSUBRECCREATE(SR_NAME_NNAM, CSrDataSubrecord::Create)
	DEFINE_SRSUBRECCREATE(SR_NAME_DATA, CSrDataSubrecord::Create)
	DEFINE_SRSUBRECCREATE(SR_NAME_ANAM, CSrDataSubrecord::Create)
	DEFINE_SRSUBRECCREATE(SR_NAME_TNAM, CSrDataSubrecord::Create)
	DEFINE_SRSUBRECCREATE(SR_NAME_NAM1, CSrDataSubrecord::Create)
	DEFINE_SRSUBRECCREATE(SR_NAME_DNAM, CSrDataSubrecord::Create)
	DEFINE_SRSUBRECCREATE(SR_NAME_NAM0, CSrDataSubrecord::Create)
	DEFINE_SRSUBRECCREATE(SR_NAME_GNAM, CSrDataSubrecord::Create)
	DEFINE_SRSUBRECCREATE(SR_NAME_MNAM, CSrDataSubrecord::Create)
	DEFINE_SRSUBRECCREATE(SR_NAME_SNAM, CSrDataSubrecord::Create)
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
BEGIN_SRFIELDMAP(CSrWatrRecord, CSrIdRecord)
	ADD_SRFIELDALL("ItemName",		SR_FIELD_ITEMNAME,	0, CSrWatrRecord, FieldItemName)
END_SRFIELDMAP()
/*===========================================================================
 *		End of CObRecord Field Map
 *=========================================================================*/


/*===========================================================================
 *
 * Class CSrWatrRecord Constructor
 *
 *=========================================================================*/
CSrWatrRecord::CSrWatrRecord () 
{
	m_pItemName = NULL;
}
/*===========================================================================
 *		End of Class CSrWatrRecord Constructor
 *=========================================================================*/


/*===========================================================================
 *
 * Class CSrWatrRecord Method - void Destroy (void);
 *
 *=========================================================================*/
void CSrWatrRecord::Destroy (void) 
{
	m_pItemName = NULL;
	CSrIdRecord::Destroy();
}
/*===========================================================================
 *		End of Class Method CSrWatrRecord::Destroy()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CSrWatrRecord Method - void InitializeNew (void);
 *
 *=========================================================================*/
void CSrWatrRecord::InitializeNew (void) 
{
	CSrIdRecord::InitializeNew();

	AddNewSubrecord(SR_NAME_NULL);
	if (m_pItemName != NULL) m_pItemName->InitializeNew();

}
/*===========================================================================
 *		End of Class Method CSrWatrRecord::InitializeNew()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CSrWatrRecord Event - void OnAddSubrecord (pSubrecord);
 *
 *=========================================================================*/
void CSrWatrRecord::OnAddSubrecord (CSrSubrecord* pSubrecord) {

	if (pSubrecord->GetRecordType() == SR_NAME_FNAM)
	{
		m_pFnamData = SrCastClass(CSrDataSubrecord, pSubrecord);
	}
	else if (pSubrecord->GetRecordType() == SR_NAME_NNAM)
	{
		m_pNnamData = SrCastClass(CSrDataSubrecord, pSubrecord);
	}
	else if (pSubrecord->GetRecordType() == SR_NAME_DATA)
	{
		m_pDataData = SrCastClass(CSrDataSubrecord, pSubrecord);
	}
	else if (pSubrecord->GetRecordType() == SR_NAME_ANAM)
	{
		m_pAnamData = SrCastClass(CSrDataSubrecord, pSubrecord);
	}
	else if (pSubrecord->GetRecordType() == SR_NAME_TNAM)
	{
		m_pTnamData = SrCastClass(CSrDataSubrecord, pSubrecord);
	}
	else if (pSubrecord->GetRecordType() == SR_NAME_NAM1)
	{
		m_pNam1Data = SrCastClass(CSrDataSubrecord, pSubrecord);
	}
	else if (pSubrecord->GetRecordType() == SR_NAME_DNAM)
	{
		m_pDnamData = SrCastClass(CSrDataSubrecord, pSubrecord);
	}
	else if (pSubrecord->GetRecordType() == SR_NAME_NAM0)
	{
		m_pNam0Data = SrCastClass(CSrDataSubrecord, pSubrecord);
	}
	else if (pSubrecord->GetRecordType() == SR_NAME_GNAM)
	{
		m_pGnamData = SrCastClass(CSrDataSubrecord, pSubrecord);
	}
	else if (pSubrecord->GetRecordType() == SR_NAME_MNAM)
	{
		m_pMnamData = SrCastClass(CSrDataSubrecord, pSubrecord);
	}
	else if (pSubrecord->GetRecordType() == SR_NAME_SNAM)
	{
		m_pSnamData = SrCastClass(CSrDataSubrecord, pSubrecord);
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
 *		End of Class Event CSrWatrRecord::OnAddSubRecord()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CSrWatrRecord Event - void OnDeleteSubrecord (pSubrecord);
 *
 *=========================================================================*/
void CSrWatrRecord::OnDeleteSubrecord (CSrSubrecord* pSubrecord) {

	if (m_pFnamData == pSubrecord)
		m_pFnamData = NULL;
	else if (m_pNnamData == pSubrecord)
		m_pNnamData = NULL;
	else if (m_pDataData == pSubrecord)
		m_pDataData = NULL;
	else if (m_pAnamData == pSubrecord)
		m_pAnamData = NULL;
	else if (m_pTnamData == pSubrecord)
		m_pTnamData = NULL;
	else if (m_pNam1Data == pSubrecord)
		m_pNam1Data = NULL;
	else if (m_pDnamData == pSubrecord)
		m_pDnamData = NULL;
	else if (m_pNam0Data == pSubrecord)
		m_pNam0Data = NULL;
	else if (m_pGnamData == pSubrecord)
		m_pGnamData = NULL;
	else if (m_pMnamData == pSubrecord)
		m_pMnamData = NULL;
	else if (m_pSnamData == pSubrecord)
		m_pSnamData = NULL;
	else if (m_pItemName == pSubrecord)
		m_pItemName = NULL;
	else
		CSrIdRecord::OnDeleteSubrecord(pSubrecord);

}
/*===========================================================================
 *		End of Class Event CSrWatrRecord::OnDeleteSubrecord()
 *=========================================================================*/


/*===========================================================================
 *
 * Begin CSrWatrRecord Get Field Methods
 *
 *=========================================================================*/
/*===========================================================================
 *		End of CSrWatrRecord Get Field Methods
 *=========================================================================*/


/*===========================================================================
 *
 * Begin CSrWatrRecord Compare Field Methods
 *
 *=========================================================================*/
/*===========================================================================
 *		End of CSrWatrRecord Compare Field Methods
 *=========================================================================*/


/*===========================================================================
 *
 * Begin CSrWatrRecord Set Field Methods
 *
 *=========================================================================*/
/*===========================================================================
 *		End of CSrWatrRecord Set Field Methods
 *=========================================================================*/

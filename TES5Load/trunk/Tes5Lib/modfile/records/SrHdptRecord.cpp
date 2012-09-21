/*===========================================================================
 *
 * File:		SrHdptRecord.CPP
 * Author:		Dave Humphrey (dave@uesp.net)
 * Created On:	5 December 2011
 *
 * Description
 *
 *=========================================================================*/

	/* Include Files */
#include "srHdptrecord.h"


/*===========================================================================
 *
 * Begin Subrecord Creation Array
 *
 *=========================================================================*/
BEGIN_SRSUBRECCREATE(CSrHdptRecord, CSrIdRecord)
	DEFINE_SRSUBRECCREATE(SR_NAME_MODL, CSrDataSubrecord::Create)
	DEFINE_SRSUBRECCREATE(SR_NAME_FULL, CSrDataSubrecord::Create)
	DEFINE_SRSUBRECCREATE(SR_NAME_TNAM, CSrDataSubrecord::Create)
	DEFINE_SRSUBRECCREATE(SR_NAME_NAM1, CSrDataSubrecord::Create)
	DEFINE_SRSUBRECCREATE(SR_NAME_MODT, CSrDataSubrecord::Create)
	DEFINE_SRSUBRECCREATE(SR_NAME_DATA, CSrDataSubrecord::Create)
	DEFINE_SRSUBRECCREATE(SR_NAME_PNAM, CSrDataSubrecord::Create)
	DEFINE_SRSUBRECCREATE(SR_NAME_RNAM, CSrDataSubrecord::Create)
	DEFINE_SRSUBRECCREATE(SR_NAME_NAM0, CSrDataSubrecord::Create)
	DEFINE_SRSUBRECCREATE(SR_NAME_HNAM, CSrDataSubrecord::Create)
END_SRSUBRECCREATE()
/*===========================================================================
 *		End of Subrecord Creation Array
 *=========================================================================*/


/*===========================================================================
 *
 * Begin CSrIdRecord Field Map
 *
 *=========================================================================*/
BEGIN_SRFIELDMAP(CSrHdptRecord, CSrIdRecord)
END_SRFIELDMAP()
/*===========================================================================
 *		End of CObRecord Field Map
 *=========================================================================*/


/*===========================================================================
 *
 * Class CSrHdptRecord Constructor
 *
 *=========================================================================*/
CSrHdptRecord::CSrHdptRecord () 
{
}
/*===========================================================================
 *		End of Class CSrHdptRecord Constructor
 *=========================================================================*/


/*===========================================================================
 *
 * Class CSrHdptRecord Method - void Destroy (void);
 *
 *=========================================================================*/
void CSrHdptRecord::Destroy (void) 
{
	CSrIdRecord::Destroy();
}
/*===========================================================================
 *		End of Class Method CSrHdptRecord::Destroy()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CSrHdptRecord Method - void InitializeNew (void);
 *
 *=========================================================================*/
void CSrHdptRecord::InitializeNew (void) 
{
	CSrIdRecord::InitializeNew();
}
/*===========================================================================
 *		End of Class Method CSrHdptRecord::InitializeNew()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CSrHdptRecord Event - void OnAddSubrecord (pSubrecord);
 *
 *=========================================================================*/
void CSrHdptRecord::OnAddSubrecord (CSrSubrecord* pSubrecord) {

	if (pSubrecord->GetRecordType() == SR_NAME_MODL)
	{
		m_pModlData = SrCastClass(CSrDataSubrecord, pSubrecord);
	}
	else if (pSubrecord->GetRecordType() == SR_NAME_FULL)
	{
		m_pFullData = SrCastClass(CSrDataSubrecord, pSubrecord);
	}
	else if (pSubrecord->GetRecordType() == SR_NAME_TNAM)
	{
		m_pTnamData = SrCastClass(CSrDataSubrecord, pSubrecord);
	}
	else if (pSubrecord->GetRecordType() == SR_NAME_NAM1)
	{
		m_pNam1Data = SrCastClass(CSrDataSubrecord, pSubrecord);
	}
	else if (pSubrecord->GetRecordType() == SR_NAME_MODT)
	{
		m_pModtData = SrCastClass(CSrDataSubrecord, pSubrecord);
	}
	else if (pSubrecord->GetRecordType() == SR_NAME_DATA)
	{
		m_pDataData = SrCastClass(CSrDataSubrecord, pSubrecord);
	}
	else if (pSubrecord->GetRecordType() == SR_NAME_PNAM)
	{
		m_pPnamData = SrCastClass(CSrDataSubrecord, pSubrecord);
	}
	else if (pSubrecord->GetRecordType() == SR_NAME_RNAM)
	{
		m_pRnamData = SrCastClass(CSrDataSubrecord, pSubrecord);
	}
	else if (pSubrecord->GetRecordType() == SR_NAME_NAM0)
	{
		m_pNam0Data = SrCastClass(CSrDataSubrecord, pSubrecord);
	}
	else if (pSubrecord->GetRecordType() == SR_NAME_HNAM)
	{
		m_pHnamData = SrCastClass(CSrDataSubrecord, pSubrecord);
	}
	else
	{
		CSrIdRecord::OnAddSubrecord(pSubrecord);
	}

}
/*===========================================================================
 *		End of Class Event CSrHdptRecord::OnAddSubRecord()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CSrHdptRecord Event - void OnDeleteSubrecord (pSubrecord);
 *
 *=========================================================================*/
void CSrHdptRecord::OnDeleteSubrecord (CSrSubrecord* pSubrecord) {

	if (m_pModlData == pSubrecord)
		m_pModlData = NULL;
	else if (m_pFullData == pSubrecord)
		m_pFullData = NULL;
	else if (m_pTnamData == pSubrecord)
		m_pTnamData = NULL;
	else if (m_pNam1Data == pSubrecord)
		m_pNam1Data = NULL;
	else if (m_pModtData == pSubrecord)
		m_pModtData = NULL;
	else if (m_pDataData == pSubrecord)
		m_pDataData = NULL;
	else if (m_pPnamData == pSubrecord)
		m_pPnamData = NULL;
	else if (m_pRnamData == pSubrecord)
		m_pRnamData = NULL;
	else if (m_pNam0Data == pSubrecord)
		m_pNam0Data = NULL;
	else if (m_pHnamData == pSubrecord)
		m_pHnamData = NULL;
	else
		CSrIdRecord::OnDeleteSubrecord(pSubrecord);

}
/*===========================================================================
 *		End of Class Event CSrHdptRecord::OnDeleteSubrecord()
 *=========================================================================*/


/*===========================================================================
 *
 * Begin CSrHdptRecord Get Field Methods
 *
 *=========================================================================*/
/*===========================================================================
 *		End of CSrHdptRecord Get Field Methods
 *=========================================================================*/


/*===========================================================================
 *
 * Begin CSrHdptRecord Compare Field Methods
 *
 *=========================================================================*/
/*===========================================================================
 *		End of CSrHdptRecord Compare Field Methods
 *=========================================================================*/


/*===========================================================================
 *
 * Begin CSrHdptRecord Set Field Methods
 *
 *=========================================================================*/
/*===========================================================================
 *		End of CSrHdptRecord Set Field Methods
 *=========================================================================*/

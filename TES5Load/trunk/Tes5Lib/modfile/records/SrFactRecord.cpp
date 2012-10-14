/*===========================================================================
 *
 * File:		SrFactRecord.CPP
 * Author:		Dave Humphrey (dave@uesp.net)
 * Created On:	5 December 2011
 *
 * Description
 *
 *=========================================================================*/

	/* Include Files */
#include "srFactrecord.h"


/*===========================================================================
 *
 * Begin Subrecord Creation Array
 *
 *=========================================================================*/
BEGIN_SRSUBRECCREATE(CSrFactRecord, CSrIdRecord)
	DEFINE_SRSUBRECCREATE(SR_NAME_FNAM, CSrDataSubrecord::Create)
	DEFINE_SRSUBRECCREATE(SR_NAME_VENC, CSrDataSubrecord::Create)
	DEFINE_SRSUBRECCREATE(SR_NAME_JOUT, CSrDataSubrecord::Create)
	DEFINE_SRSUBRECCREATE(SR_NAME_XNAM, CSrDataSubrecord::Create)
	DEFINE_SRSUBRECCREATE(SR_NAME_DATA, CSrDataSubrecord::Create)
	DEFINE_SRSUBRECCREATE(SR_NAME_VENV, CSrDataSubrecord::Create)
	DEFINE_SRSUBRECCREATE(SR_NAME_CRVA, CSrDataSubrecord::Create)
	DEFINE_SRSUBRECCREATE(SR_NAME_WAIT, CSrDataSubrecord::Create)
	DEFINE_SRSUBRECCREATE(SR_NAME_PLVD, CSrDataSubrecord::Create)
	DEFINE_SRSUBRECCREATE(SR_NAME_FULL, CSrDataSubrecord::Create)
	DEFINE_SRSUBRECCREATE(SR_NAME_VEND, CSrDataSubrecord::Create)
	DEFINE_SRSUBRECCREATE(SR_NAME_STOL, CSrDataSubrecord::Create)
	DEFINE_SRSUBRECCREATE(SR_NAME_PLCN, CSrDataSubrecord::Create)
	DEFINE_SRSUBRECCREATE(SR_NAME_CRGR, CSrDataSubrecord::Create)
	DEFINE_SRSUBRECCREATE(SR_NAME_RNAM, CSrDataSubrecord::Create)
	DEFINE_SRSUBRECCREATE(SR_NAME_MNAM, CSrDataSubrecord::Create)
	DEFINE_SRSUBRECCREATE(SR_NAME_JAIL, CSrDataSubrecord::Create)
	DEFINE_SRSUBRECCREATE(SR_NAME_CITC, CSrDataSubrecord::Create)
	DEFINE_SRSUBRECCREATE(SR_NAME_CTDA, CSrDataSubrecord::Create)
	DEFINE_SRSUBRECCREATE(SR_NAME_CIS1, CSrStringSubrecord::Create)
	DEFINE_SRSUBRECCREATE(SR_NAME_CIS2, CSrStringSubrecord::Create)
END_SRSUBRECCREATE()
/*===========================================================================
 *		End of Subrecord Creation Array
 *=========================================================================*/


/*===========================================================================
 *
 * Begin CSrRecord Field Map
 *
 *=========================================================================*/
BEGIN_SRFIELDMAP(CSrFactRecord, CSrIdRecord)
END_SRFIELDMAP()
/*===========================================================================
 *		End of CObRecord Field Map
 *=========================================================================*/


/*===========================================================================
 *
 * Class CSrFactRecord Constructor
 *
 *=========================================================================*/
CSrFactRecord::CSrFactRecord () 
{
}
/*===========================================================================
 *		End of Class CSrFactRecord Constructor
 *=========================================================================*/


/*===========================================================================
 *
 * Class CSrFactRecord Method - void Destroy (void);
 *
 *=========================================================================*/
void CSrFactRecord::Destroy (void) 
{
	CSrIdRecord::Destroy();
}
/*===========================================================================
 *		End of Class Method CSrFactRecord::Destroy()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CSrFactRecord Method - void InitializeNew (void);
 *
 *=========================================================================*/
void CSrFactRecord::InitializeNew (void) 
{
	CSrIdRecord::InitializeNew();
}
/*===========================================================================
 *		End of Class Method CSrFactRecord::InitializeNew()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CSrFactRecord Event - void OnAddSubrecord (pSubrecord);
 *
 *=========================================================================*/
void CSrFactRecord::OnAddSubrecord (CSrSubrecord* pSubrecord) {

	if (pSubrecord->GetRecordType() == SR_NAME_FNAM)
	{
		m_pFnamData = SrCastClass(CSrDataSubrecord, pSubrecord);
	}
	else if (pSubrecord->GetRecordType() == SR_NAME_VENC)
	{
		m_pVencData = SrCastClass(CSrDataSubrecord, pSubrecord);
	}
	else if (pSubrecord->GetRecordType() == SR_NAME_JOUT)
	{
		m_pJoutData = SrCastClass(CSrDataSubrecord, pSubrecord);
	}
	else if (pSubrecord->GetRecordType() == SR_NAME_XNAM)
	{
		m_pXnamData = SrCastClass(CSrDataSubrecord, pSubrecord);
	}
	else if (pSubrecord->GetRecordType() == SR_NAME_DATA)
	{
		m_pDataData = SrCastClass(CSrDataSubrecord, pSubrecord);
	}
	else if (pSubrecord->GetRecordType() == SR_NAME_VENV)
	{
		m_pVenvData = SrCastClass(CSrDataSubrecord, pSubrecord);
	}
	else if (pSubrecord->GetRecordType() == SR_NAME_CRVA)
	{
		m_pCrvaData = SrCastClass(CSrDataSubrecord, pSubrecord);
	}
	else if (pSubrecord->GetRecordType() == SR_NAME_WAIT)
	{
		m_pWaitData = SrCastClass(CSrDataSubrecord, pSubrecord);
	}
	else if (pSubrecord->GetRecordType() == SR_NAME_PLVD)
	{
		m_pPlvdData = SrCastClass(CSrDataSubrecord, pSubrecord);
	}
	else if (pSubrecord->GetRecordType() == SR_NAME_FULL)
	{
		m_pFullData = SrCastClass(CSrDataSubrecord, pSubrecord);
	}
	else if (pSubrecord->GetRecordType() == SR_NAME_VEND)
	{
		m_pVendData = SrCastClass(CSrDataSubrecord, pSubrecord);
	}
	else if (pSubrecord->GetRecordType() == SR_NAME_STOL)
	{
		m_pStolData = SrCastClass(CSrDataSubrecord, pSubrecord);
	}
	else if (pSubrecord->GetRecordType() == SR_NAME_PLCN)
	{
		m_pPlcnData = SrCastClass(CSrDataSubrecord, pSubrecord);
	}
	else if (pSubrecord->GetRecordType() == SR_NAME_CRGR)
	{
		m_pCrgrData = SrCastClass(CSrDataSubrecord, pSubrecord);
	}
	else if (pSubrecord->GetRecordType() == SR_NAME_RNAM)
	{
		m_pRnamData = SrCastClass(CSrDataSubrecord, pSubrecord);
	}
	else if (pSubrecord->GetRecordType() == SR_NAME_MNAM)
	{
		m_pMnamData = SrCastClass(CSrDataSubrecord, pSubrecord);
	}
	else if (pSubrecord->GetRecordType() == SR_NAME_JAIL)
	{
		m_pJailData = SrCastClass(CSrDataSubrecord, pSubrecord);
	}
	else if (pSubrecord->GetRecordType() == SR_NAME_CITC)
	{
		m_pCitcData = SrCastClass(CSrDataSubrecord, pSubrecord);
	}
	else if (pSubrecord->GetRecordType() == SR_NAME_CTDA)
	{
		m_pCtdaData = SrCastClass(CSrDataSubrecord, pSubrecord);
	}
	else if (pSubrecord->GetRecordType() == SR_NAME_CIS2)
	{
		m_pCis2Data = SrCastClass(CSrDataSubrecord, pSubrecord);
	}
	else
	{
		CSrIdRecord::OnAddSubrecord(pSubrecord);
	}

}
/*===========================================================================
 *		End of Class Event CSrFactRecord::OnAddSubRecord()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CSrFactRecord Event - void OnDeleteSubrecord (pSubrecord);
 *
 *=========================================================================*/
void CSrFactRecord::OnDeleteSubrecord (CSrSubrecord* pSubrecord) {

	if (m_pFnamData == pSubrecord)
		m_pFnamData = NULL;
	else if (m_pVencData == pSubrecord)
		m_pVencData = NULL;
	else if (m_pJoutData == pSubrecord)
		m_pJoutData = NULL;
	else if (m_pXnamData == pSubrecord)
		m_pXnamData = NULL;
	else if (m_pDataData == pSubrecord)
		m_pDataData = NULL;
	else if (m_pVenvData == pSubrecord)
		m_pVenvData = NULL;
	else if (m_pCrvaData == pSubrecord)
		m_pCrvaData = NULL;
	else if (m_pWaitData == pSubrecord)
		m_pWaitData = NULL;
	else if (m_pPlvdData == pSubrecord)
		m_pPlvdData = NULL;
	else if (m_pFullData == pSubrecord)
		m_pFullData = NULL;
	else if (m_pVendData == pSubrecord)
		m_pVendData = NULL;
	else if (m_pStolData == pSubrecord)
		m_pStolData = NULL;
	else if (m_pPlcnData == pSubrecord)
		m_pPlcnData = NULL;
	else if (m_pCrgrData == pSubrecord)
		m_pCrgrData = NULL;
	else if (m_pRnamData == pSubrecord)
		m_pRnamData = NULL;
	else if (m_pMnamData == pSubrecord)
		m_pMnamData = NULL;
	else if (m_pJailData == pSubrecord)
		m_pJailData = NULL;
	else if (m_pCitcData == pSubrecord)
		m_pCitcData = NULL;
	else if (m_pCtdaData == pSubrecord)
		m_pCtdaData = NULL;
	else if (m_pCis2Data == pSubrecord)
		m_pCis2Data = NULL;
	else
		CSrIdRecord::OnDeleteSubrecord(pSubrecord);

}
/*===========================================================================
 *		End of Class Event CSrFactRecord::OnDeleteSubrecord()
 *=========================================================================*/


/*===========================================================================
 *
 * Begin CSrFactRecord Get Field Methods
 *
 *=========================================================================*/
/*===========================================================================
 *		End of CSrFactRecord Get Field Methods
 *=========================================================================*/


/*===========================================================================
 *
 * Begin CSrFactRecord Compare Field Methods
 *
 *=========================================================================*/
/*===========================================================================
 *		End of CSrFactRecord Compare Field Methods
 *=========================================================================*/


/*===========================================================================
 *
 * Begin CSrFactRecord Set Field Methods
 *
 *=========================================================================*/
/*===========================================================================
 *		End of CSrFactRecord Set Field Methods
 *=========================================================================*/

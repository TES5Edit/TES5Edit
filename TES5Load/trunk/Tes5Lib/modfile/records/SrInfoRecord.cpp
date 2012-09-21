/*===========================================================================
 *
 * File:		SrInfoRecord.CPP
 * Author:		Dave Humphrey (dave@uesp.net)
 * Created On:	5 December 2011
 *
 * Description
 *
 *=========================================================================*/

	/* Include Files */
#include "srInforecord.h"


/*===========================================================================
 *
 * Begin Subrecord Creation Array
 *
 *=========================================================================*/
BEGIN_SRSUBRECCREATE(CSrInfoRecord, CSrIdRecord)
	DEFINE_SRSUBRECCREATE(SR_NAME_NAM3, CSrDataSubrecord::Create)
	DEFINE_SRSUBRECCREATE(SR_NAME_ENAM, CSrDataSubrecord::Create)
	DEFINE_SRSUBRECCREATE(SR_NAME_SNAM, CSrDataSubrecord::Create)
	DEFINE_SRSUBRECCREATE(SR_NAME_TRDT, CSrDataSubrecord::Create)
	DEFINE_SRSUBRECCREATE(SR_NAME_VMAD, CSrDataSubrecord::Create)
	DEFINE_SRSUBRECCREATE(SR_NAME_CNAM, CSrDataSubrecord::Create)
	DEFINE_SRSUBRECCREATE(SR_NAME_NAM1, CSrDataSubrecord::Create)
	DEFINE_SRSUBRECCREATE(SR_NAME_NAM2, CSrDataSubrecord::Create)
	DEFINE_SRSUBRECCREATE(SR_NAME_CTDA, CSrDataSubrecord::Create)
	DEFINE_SRSUBRECCREATE(SR_NAME_CIS1, CSrStringSubrecord::Create)
	DEFINE_SRSUBRECCREATE(SR_NAME_CIS2, CSrStringSubrecord::Create)
	DEFINE_SRSUBRECCREATE(SR_NAME_DNAM, CSrDataSubrecord::Create)
	DEFINE_SRSUBRECCREATE(SR_NAME_ONAM, CSrDataSubrecord::Create)
	DEFINE_SRSUBRECCREATE(SR_NAME_DATA, CSrDataSubrecord::Create)
	DEFINE_SRSUBRECCREATE(SR_NAME_SCHR, CSrDataSubrecord::Create)
	DEFINE_SRSUBRECCREATE(SR_NAME_QNAM, CSrDataSubrecord::Create)
	DEFINE_SRSUBRECCREATE(SR_NAME_NEXT, CSrDataSubrecord::Create)
	DEFINE_SRSUBRECCREATE(SR_NAME_RNAM, CSrDataSubrecord::Create)
	DEFINE_SRSUBRECCREATE(SR_NAME_TCLT, CSrDataSubrecord::Create)
	DEFINE_SRSUBRECCREATE(SR_NAME_TWAT, CSrDataSubrecord::Create)
	DEFINE_SRSUBRECCREATE(SR_NAME_ANAM, CSrDataSubrecord::Create)
	DEFINE_SRSUBRECCREATE(SR_NAME_LNAM, CSrDataSubrecord::Create)
END_SRSUBRECCREATE()
/*===========================================================================
 *		End of Subrecord Creation Array
 *=========================================================================*/


/*===========================================================================
 *
 * Begin CSrIdRecord Field Map
 *
 *=========================================================================*/
BEGIN_SRFIELDMAP(CSrInfoRecord, CSrIdRecord)
END_SRFIELDMAP()
/*===========================================================================
 *		End of CObRecord Field Map
 *=========================================================================*/


/*===========================================================================
 *
 * Class CSrInfoRecord Constructor
 *
 *=========================================================================*/
CSrInfoRecord::CSrInfoRecord () 
{
}
/*===========================================================================
 *		End of Class CSrInfoRecord Constructor
 *=========================================================================*/


/*===========================================================================
 *
 * Class CSrInfoRecord Method - void Destroy (void);
 *
 *=========================================================================*/
void CSrInfoRecord::Destroy (void) 
{
	CSrIdRecord::Destroy();
}
/*===========================================================================
 *		End of Class Method CSrInfoRecord::Destroy()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CSrInfoRecord Method - void InitializeNew (void);
 *
 *=========================================================================*/
void CSrInfoRecord::InitializeNew (void) 
{
	CSrIdRecord::InitializeNew();
}
/*===========================================================================
 *		End of Class Method CSrInfoRecord::InitializeNew()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CSrInfoRecord Event - void OnAddSubrecord (pSubrecord);
 *
 *=========================================================================*/
void CSrInfoRecord::OnAddSubrecord (CSrSubrecord* pSubrecord) {

	if (pSubrecord->GetRecordType() == SR_NAME_NAM3)
	{
		m_pNam3Data = SrCastClass(CSrDataSubrecord, pSubrecord);
	}
	else if (pSubrecord->GetRecordType() == SR_NAME_ENAM)
	{
		m_pEnamData = SrCastClass(CSrDataSubrecord, pSubrecord);
	}
	else if (pSubrecord->GetRecordType() == SR_NAME_SNAM)
	{
		m_pSnamData = SrCastClass(CSrDataSubrecord, pSubrecord);
	}
	else if (pSubrecord->GetRecordType() == SR_NAME_TRDT)
	{
		m_pTrdtData = SrCastClass(CSrDataSubrecord, pSubrecord);
	}
	else if (pSubrecord->GetRecordType() == SR_NAME_CIS2)
	{
		m_pCis2Data = SrCastClass(CSrDataSubrecord, pSubrecord);
	}
	else if (pSubrecord->GetRecordType() == SR_NAME_VMAD)
	{
		m_pVmadData = SrCastClass(CSrDataSubrecord, pSubrecord);
	}
	else if (pSubrecord->GetRecordType() == SR_NAME_CNAM)
	{
		m_pCnamData = SrCastClass(CSrDataSubrecord, pSubrecord);
	}
	else if (pSubrecord->GetRecordType() == SR_NAME_NAM1)
	{
		m_pNam1Data = SrCastClass(CSrDataSubrecord, pSubrecord);
	}
	else if (pSubrecord->GetRecordType() == SR_NAME_NAM2)
	{
		m_pNam2Data = SrCastClass(CSrDataSubrecord, pSubrecord);
	}
	else if (pSubrecord->GetRecordType() == SR_NAME_CTDA)
	{
		m_pCtdaData = SrCastClass(CSrDataSubrecord, pSubrecord);
	}
	else if (pSubrecord->GetRecordType() == SR_NAME_DNAM)
	{
		m_pDnamData = SrCastClass(CSrDataSubrecord, pSubrecord);
	}
	else if (pSubrecord->GetRecordType() == SR_NAME_ONAM)
	{
		m_pOnamData = SrCastClass(CSrDataSubrecord, pSubrecord);
	}
	else if (pSubrecord->GetRecordType() == SR_NAME_DATA)
	{
		m_pDataData = SrCastClass(CSrDataSubrecord, pSubrecord);
	}
	else if (pSubrecord->GetRecordType() == SR_NAME_SCHR)
	{
		m_pSchrData = SrCastClass(CSrDataSubrecord, pSubrecord);
	}
	else if (pSubrecord->GetRecordType() == SR_NAME_QNAM)
	{
		m_pQnamData = SrCastClass(CSrDataSubrecord, pSubrecord);
	}
	else if (pSubrecord->GetRecordType() == SR_NAME_NEXT)
	{
		m_pNextData = SrCastClass(CSrDataSubrecord, pSubrecord);
	}
	else if (pSubrecord->GetRecordType() == SR_NAME_RNAM)
	{
		m_pRnamData = SrCastClass(CSrDataSubrecord, pSubrecord);
	}
	else if (pSubrecord->GetRecordType() == SR_NAME_TCLT)
	{
		m_pTcltData = SrCastClass(CSrDataSubrecord, pSubrecord);
	}
	else if (pSubrecord->GetRecordType() == SR_NAME_TWAT)
	{
		m_pTwatData = SrCastClass(CSrDataSubrecord, pSubrecord);
	}
	else if (pSubrecord->GetRecordType() == SR_NAME_ANAM)
	{
		m_pAnamData = SrCastClass(CSrDataSubrecord, pSubrecord);
	}
	else if (pSubrecord->GetRecordType() == SR_NAME_LNAM)
	{
		m_pLnamData = SrCastClass(CSrDataSubrecord, pSubrecord);
	}
	else
	{
		CSrIdRecord::OnAddSubrecord(pSubrecord);
	}

}
/*===========================================================================
 *		End of Class Event CSrInfoRecord::OnAddSubRecord()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CSrInfoRecord Event - void OnDeleteSubrecord (pSubrecord);
 *
 *=========================================================================*/
void CSrInfoRecord::OnDeleteSubrecord (CSrSubrecord* pSubrecord) {

	if (m_pNam3Data == pSubrecord)
		m_pNam3Data = NULL;
	else if (m_pEnamData == pSubrecord)
		m_pEnamData = NULL;
	else if (m_pSnamData == pSubrecord)
		m_pSnamData = NULL;
	else if (m_pTrdtData == pSubrecord)
		m_pTrdtData = NULL;
	else if (m_pCis2Data == pSubrecord)
		m_pCis2Data = NULL;
	else if (m_pVmadData == pSubrecord)
		m_pVmadData = NULL;
	else if (m_pCnamData == pSubrecord)
		m_pCnamData = NULL;
	else if (m_pNam1Data == pSubrecord)
		m_pNam1Data = NULL;
	else if (m_pNam2Data == pSubrecord)
		m_pNam2Data = NULL;
	else if (m_pCtdaData == pSubrecord)
		m_pCtdaData = NULL;
	else if (m_pDnamData == pSubrecord)
		m_pDnamData = NULL;
	else if (m_pOnamData == pSubrecord)
		m_pOnamData = NULL;
	else if (m_pDataData == pSubrecord)
		m_pDataData = NULL;
	else if (m_pSchrData == pSubrecord)
		m_pSchrData = NULL;
	else if (m_pQnamData == pSubrecord)
		m_pQnamData = NULL;
	else if (m_pNextData == pSubrecord)
		m_pNextData = NULL;
	else if (m_pRnamData == pSubrecord)
		m_pRnamData = NULL;
	else if (m_pTcltData == pSubrecord)
		m_pTcltData = NULL;
	else if (m_pTwatData == pSubrecord)
		m_pTwatData = NULL;
	else if (m_pAnamData == pSubrecord)
		m_pAnamData = NULL;
	else if (m_pLnamData == pSubrecord)
		m_pLnamData = NULL;
	else
		CSrIdRecord::OnDeleteSubrecord(pSubrecord);

}
/*===========================================================================
 *		End of Class Event CSrInfoRecord::OnDeleteSubrecord()
 *=========================================================================*/


/*===========================================================================
 *
 * Begin CSrInfoRecord Get Field Methods
 *
 *=========================================================================*/
/*===========================================================================
 *		End of CSrInfoRecord Get Field Methods
 *=========================================================================*/


/*===========================================================================
 *
 * Begin CSrInfoRecord Compare Field Methods
 *
 *=========================================================================*/
/*===========================================================================
 *		End of CSrInfoRecord Compare Field Methods
 *=========================================================================*/


/*===========================================================================
 *
 * Begin CSrInfoRecord Set Field Methods
 *
 *=========================================================================*/
/*===========================================================================
 *		End of CSrInfoRecord Set Field Methods
 *=========================================================================*/

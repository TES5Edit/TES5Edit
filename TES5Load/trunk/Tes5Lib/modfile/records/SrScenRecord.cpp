/*===========================================================================
 *
 * File:		SrScenRecord.CPP
 * Author:		Dave Humphrey (dave@uesp.net)
 * Created On:	5 December 2011
 *
 * Description
 *
 *=========================================================================*/

	/* Include Files */
#include "srScenrecord.h"


/*===========================================================================
 *
 * Begin Subrecord Creation Array
 *
 *=========================================================================*/
BEGIN_SRSUBRECCREATE(CSrScenRecord, CSrIdRecord)
	DEFINE_SRSUBRECCREATE(SR_NAME_FNAM, CSrDataSubrecord::Create)
	DEFINE_SRSUBRECCREATE(SR_NAME_NEXT, CSrDataSubrecord::Create)
	DEFINE_SRSUBRECCREATE(SR_NAME_VMAD, CSrDataSubrecord::Create)
	DEFINE_SRSUBRECCREATE(SR_NAME_HNAM, CSrDataSubrecord::Create)
	DEFINE_SRSUBRECCREATE(SR_NAME_DMAX, CSrDataSubrecord::Create)
	DEFINE_SRSUBRECCREATE(SR_NAME_WNAM, CSrDataSubrecord::Create)
	DEFINE_SRSUBRECCREATE(SR_NAME_NAM0, CSrDataSubrecord::Create)
	DEFINE_SRSUBRECCREATE(SR_NAME_ALID, CSrDataSubrecord::Create)
	DEFINE_SRSUBRECCREATE(SR_NAME_SCTX, CSrDataSubrecord::Create)
	DEFINE_SRSUBRECCREATE(SR_NAME_LNAM, CSrDataSubrecord::Create)
	DEFINE_SRSUBRECCREATE(SR_NAME_DNAM, CSrDataSubrecord::Create)
	DEFINE_SRSUBRECCREATE(SR_NAME_ANAM, CSrDataSubrecord::Create)
	DEFINE_SRSUBRECCREATE(SR_NAME_HTID, CSrDataSubrecord::Create)
	DEFINE_SRSUBRECCREATE(SR_NAME_INAM, CSrDataSubrecord::Create)
	DEFINE_SRSUBRECCREATE(SR_NAME_SNAM, CSrDataSubrecord::Create)
	DEFINE_SRSUBRECCREATE(SR_NAME_ENAM, CSrDataSubrecord::Create)
	DEFINE_SRSUBRECCREATE(SR_NAME_SCDA, CSrDataSubrecord::Create)
	DEFINE_SRSUBRECCREATE(SR_NAME_DATA, CSrDataSubrecord::Create)
	DEFINE_SRSUBRECCREATE(SR_NAME_DMIN, CSrDataSubrecord::Create)
	DEFINE_SRSUBRECCREATE(SR_NAME_DEMO, CSrDataSubrecord::Create)
	DEFINE_SRSUBRECCREATE(SR_NAME_DEVA, CSrDataSubrecord::Create)
	DEFINE_SRSUBRECCREATE(SR_NAME_PNAM, CSrDataSubrecord::Create)
	DEFINE_SRSUBRECCREATE(SR_NAME_VNAM, CSrDataSubrecord::Create)
	DEFINE_SRSUBRECCREATE(SR_NAME_CTDA, CSrDataSubrecord::Create)
	DEFINE_SRSUBRECCREATE(SR_NAME_CIS1, CSrStringSubrecord::Create)
	DEFINE_SRSUBRECCREATE(SR_NAME_CIS2, CSrStringSubrecord::Create)
	DEFINE_SRSUBRECCREATE(SR_NAME_SCHR, CSrDataSubrecord::Create)
	DEFINE_SRSUBRECCREATE(SR_NAME_QNAM, CSrDataSubrecord::Create)
	DEFINE_SRSUBRECCREATE(SR_NAME_SCRO, CSrDataSubrecord::Create)
END_SRSUBRECCREATE()
/*===========================================================================
 *		End of Subrecord Creation Array
 *=========================================================================*/


/*===========================================================================
 *
 * Begin CSrIdRecord Field Map
 *
 *=========================================================================*/
BEGIN_SRFIELDMAP(CSrScenRecord, CSrIdRecord)
END_SRFIELDMAP()
/*===========================================================================
 *		End of CObRecord Field Map
 *=========================================================================*/


/*===========================================================================
 *
 * Class CSrScenRecord Constructor
 *
 *=========================================================================*/
CSrScenRecord::CSrScenRecord () 
{
}
/*===========================================================================
 *		End of Class CSrScenRecord Constructor
 *=========================================================================*/


/*===========================================================================
 *
 * Class CSrScenRecord Method - void Destroy (void);
 *
 *=========================================================================*/
void CSrScenRecord::Destroy (void) 
{
	CSrIdRecord::Destroy();
}
/*===========================================================================
 *		End of Class Method CSrScenRecord::Destroy()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CSrScenRecord Method - void InitializeNew (void);
 *
 *=========================================================================*/
void CSrScenRecord::InitializeNew (void) 
{

	/* Call the base class method first */
	CSrIdRecord::InitializeNew();


}
/*===========================================================================
 *		End of Class Method CSrScenRecord::InitializeNew()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CSrScenRecord Event - void OnAddSubrecord (pSubrecord);
 *
 *=========================================================================*/
void CSrScenRecord::OnAddSubrecord (CSrSubrecord* pSubrecord) {

	if (pSubrecord->GetRecordType() == SR_NAME_FNAM)
	{
		m_pFnamData = SrCastClass(CSrDataSubrecord, pSubrecord);
	}
	else if (pSubrecord->GetRecordType() == SR_NAME_NEXT)
	{
		m_pNextData = SrCastClass(CSrDataSubrecord, pSubrecord);
	}
	else if (pSubrecord->GetRecordType() == SR_NAME_VMAD)
	{
		m_pVmadData = SrCastClass(CSrDataSubrecord, pSubrecord);
	}
	else if (pSubrecord->GetRecordType() == SR_NAME_HNAM)
	{
		m_pHnamData = SrCastClass(CSrDataSubrecord, pSubrecord);
	}
	else if (pSubrecord->GetRecordType() == SR_NAME_DMAX)
	{
		m_pDmaxData = SrCastClass(CSrDataSubrecord, pSubrecord);
	}
	else if (pSubrecord->GetRecordType() == SR_NAME_WNAM)
	{
		m_pWnamData = SrCastClass(CSrDataSubrecord, pSubrecord);
	}
	else if (pSubrecord->GetRecordType() == SR_NAME_NAM0)
	{
		m_pNam0Data = SrCastClass(CSrDataSubrecord, pSubrecord);
	}
	else if (pSubrecord->GetRecordType() == SR_NAME_ALID)
	{
		m_pAlidData = SrCastClass(CSrDataSubrecord, pSubrecord);
	}
	else if (pSubrecord->GetRecordType() == SR_NAME_SCTX)
	{
		m_pSctxData = SrCastClass(CSrDataSubrecord, pSubrecord);
	}
	else if (pSubrecord->GetRecordType() == SR_NAME_LNAM)
	{
		m_pLnamData = SrCastClass(CSrDataSubrecord, pSubrecord);
	}
	else if (pSubrecord->GetRecordType() == SR_NAME_DNAM)
	{
		m_pDnamData = SrCastClass(CSrDataSubrecord, pSubrecord);
	}
	else if (pSubrecord->GetRecordType() == SR_NAME_ANAM)
	{
		m_pAnamData = SrCastClass(CSrDataSubrecord, pSubrecord);
	}
	else if (pSubrecord->GetRecordType() == SR_NAME_HTID)
	{
		m_pHtidData = SrCastClass(CSrDataSubrecord, pSubrecord);
	}
	else if (pSubrecord->GetRecordType() == SR_NAME_INAM)
	{
		m_pInamData = SrCastClass(CSrDataSubrecord, pSubrecord);
	}
	else if (pSubrecord->GetRecordType() == SR_NAME_CIS2)
	{
		m_pCis2Data = SrCastClass(CSrDataSubrecord, pSubrecord);
	}
	else if (pSubrecord->GetRecordType() == SR_NAME_SNAM)
	{
		m_pSnamData = SrCastClass(CSrDataSubrecord, pSubrecord);
	}
	else if (pSubrecord->GetRecordType() == SR_NAME_ENAM)
	{
		m_pEnamData = SrCastClass(CSrDataSubrecord, pSubrecord);
	}
	else if (pSubrecord->GetRecordType() == SR_NAME_SCDA)
	{
		m_pScdaData = SrCastClass(CSrDataSubrecord, pSubrecord);
	}
	else if (pSubrecord->GetRecordType() == SR_NAME_DATA)
	{
		m_pDataData = SrCastClass(CSrDataSubrecord, pSubrecord);
	}
	else if (pSubrecord->GetRecordType() == SR_NAME_DMIN)
	{
		m_pDminData = SrCastClass(CSrDataSubrecord, pSubrecord);
	}
	else if (pSubrecord->GetRecordType() == SR_NAME_DEMO)
	{
		m_pDemoData = SrCastClass(CSrDataSubrecord, pSubrecord);
	}
	else if (pSubrecord->GetRecordType() == SR_NAME_DEVA)
	{
		m_pDevaData = SrCastClass(CSrDataSubrecord, pSubrecord);
	}
	else if (pSubrecord->GetRecordType() == SR_NAME_PNAM)
	{
		m_pPnamData = SrCastClass(CSrDataSubrecord, pSubrecord);
	}
	else if (pSubrecord->GetRecordType() == SR_NAME_VNAM)
	{
		m_pVnamData = SrCastClass(CSrDataSubrecord, pSubrecord);
	}
	else if (pSubrecord->GetRecordType() == SR_NAME_CTDA)
	{
		m_pCtdaData = SrCastClass(CSrDataSubrecord, pSubrecord);
	}
	else if (pSubrecord->GetRecordType() == SR_NAME_SCHR)
	{
		m_pSchrData = SrCastClass(CSrDataSubrecord, pSubrecord);
	}
	else if (pSubrecord->GetRecordType() == SR_NAME_QNAM)
	{
		m_pQnamData = SrCastClass(CSrDataSubrecord, pSubrecord);
	}
	else if (pSubrecord->GetRecordType() == SR_NAME_SCRO)
	{
		m_pScroData = SrCastClass(CSrDataSubrecord, pSubrecord);
	}
	else
	{
		CSrIdRecord::OnAddSubrecord(pSubrecord);
	}

}
/*===========================================================================
 *		End of Class Event CSrScenRecord::OnAddSubRecord()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CSrScenRecord Event - void OnDeleteSubrecord (pSubrecord);
 *
 *=========================================================================*/
void CSrScenRecord::OnDeleteSubrecord (CSrSubrecord* pSubrecord) {

	if (m_pFnamData == pSubrecord)
		m_pFnamData = NULL;
	else if (m_pNextData == pSubrecord)
		m_pNextData = NULL;
	else if (m_pVmadData == pSubrecord)
		m_pVmadData = NULL;
	else if (m_pHnamData == pSubrecord)
		m_pHnamData = NULL;
	else if (m_pDmaxData == pSubrecord)
		m_pDmaxData = NULL;
	else if (m_pWnamData == pSubrecord)
		m_pWnamData = NULL;
	else if (m_pNam0Data == pSubrecord)
		m_pNam0Data = NULL;
	else if (m_pAlidData == pSubrecord)
		m_pAlidData = NULL;
	else if (m_pSctxData == pSubrecord)
		m_pSctxData = NULL;
	else if (m_pLnamData == pSubrecord)
		m_pLnamData = NULL;
	else if (m_pDnamData == pSubrecord)
		m_pDnamData = NULL;
	else if (m_pAnamData == pSubrecord)
		m_pAnamData = NULL;
	else if (m_pHtidData == pSubrecord)
		m_pHtidData = NULL;
	else if (m_pInamData == pSubrecord)
		m_pInamData = NULL;
	else if (m_pCis2Data == pSubrecord)
		m_pCis2Data = NULL;
	else if (m_pSnamData == pSubrecord)
		m_pSnamData = NULL;
	else if (m_pEnamData == pSubrecord)
		m_pEnamData = NULL;
	else if (m_pScdaData == pSubrecord)
		m_pScdaData = NULL;
	else if (m_pDataData == pSubrecord)
		m_pDataData = NULL;
	else if (m_pDminData == pSubrecord)
		m_pDminData = NULL;
	else if (m_pDemoData == pSubrecord)
		m_pDemoData = NULL;
	else if (m_pDevaData == pSubrecord)
		m_pDevaData = NULL;
	else if (m_pPnamData == pSubrecord)
		m_pPnamData = NULL;
	else if (m_pVnamData == pSubrecord)
		m_pVnamData = NULL;
	else if (m_pCtdaData == pSubrecord)
		m_pCtdaData = NULL;
	else if (m_pSchrData == pSubrecord)
		m_pSchrData = NULL;
	else if (m_pQnamData == pSubrecord)
		m_pQnamData = NULL;
	else if (m_pScroData == pSubrecord)
		m_pScroData = NULL;

	else
		CSrIdRecord::OnDeleteSubrecord(pSubrecord);

}
/*===========================================================================
 *		End of Class Event CSrScenRecord::OnDeleteSubrecord()
 *=========================================================================*/


/*===========================================================================
 *
 * Begin CSrScenRecord Get Field Methods
 *
 *=========================================================================*/
/*===========================================================================
 *		End of CSrScenRecord Get Field Methods
 *=========================================================================*/


/*===========================================================================
 *
 * Begin CSrScenRecord Compare Field Methods
 *
 *=========================================================================*/
/*===========================================================================
 *		End of CSrScenRecord Compare Field Methods
 *=========================================================================*/


/*===========================================================================
 *
 * Begin CSrScenRecord Set Field Methods
 *
 *=========================================================================*/
/*===========================================================================
 *		End of CSrScenRecord Set Field Methods
 *=========================================================================*/

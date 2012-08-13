/*===========================================================================
 *
 * File:		SrPackRecord.CPP
 * Author:		Dave Humphrey (dave@uesp.net)
 * Created On:	5 December 2011
 *
 * Description
 *
 *=========================================================================*/

	/* Include Files */
#include "srPackrecord.h"


/*===========================================================================
 *
 * Begin Subrecord Creation Array
 *
 *=========================================================================*/
BEGIN_SRSUBRECCREATE(CSrPackRecord, CSrIdRecord)
	DEFINE_SRSUBRECCREATE(SR_NAME_FNAM, CSrDataSubrecord::Create)
	DEFINE_SRSUBRECCREATE(SR_NAME_POBA, CSrDataSubrecord::Create)
	DEFINE_SRSUBRECCREATE(SR_NAME_PKDT, CSrDataSubrecord::Create)
	DEFINE_SRSUBRECCREATE(SR_NAME_PSDT, CSrDataSubrecord::Create)
	DEFINE_SRSUBRECCREATE(SR_NAME_PLDT, CSrDataSubrecord::Create)
	DEFINE_SRSUBRECCREATE(SR_NAME_ANAM, CSrDataSubrecord::Create)
	DEFINE_SRSUBRECCREATE(SR_NAME_CTDA, CSrDataSubrecord::Create)
	DEFINE_SRSUBRECCREATE(SR_NAME_CIS1, CSrStringSubrecord::Create)
	DEFINE_SRSUBRECCREATE(SR_NAME_CIS2, CSrStringSubrecord::Create)
	DEFINE_SRSUBRECCREATE(SR_NAME_TNAM, CSrDataSubrecord::Create)
	DEFINE_SRSUBRECCREATE(SR_NAME_PKCU, CSrDataSubrecord::Create)
	DEFINE_SRSUBRECCREATE(SR_NAME_CNAM, CSrDataSubrecord::Create)
	DEFINE_SRSUBRECCREATE(SR_NAME_UNAM, CSrDataSubrecord::Create)
	DEFINE_SRSUBRECCREATE(SR_NAME_XNAM, CSrDataSubrecord::Create)
	DEFINE_SRSUBRECCREATE(SR_NAME_INAM, CSrDataSubrecord::Create)
	DEFINE_SRSUBRECCREATE(SR_NAME_PDTO, CSrDataSubrecord::Create)
	DEFINE_SRSUBRECCREATE(SR_NAME_POEA, CSrDataSubrecord::Create)
	DEFINE_SRSUBRECCREATE(SR_NAME_PTDA, CSrDataSubrecord::Create)
	DEFINE_SRSUBRECCREATE(SR_NAME_POCA, CSrDataSubrecord::Create)
	DEFINE_SRSUBRECCREATE(SR_NAME_QNAM, CSrDataSubrecord::Create)
	DEFINE_SRSUBRECCREATE(SR_NAME_PFO2, CSrDataSubrecord::Create)
	DEFINE_SRSUBRECCREATE(SR_NAME_CITC, CSrDataSubrecord::Create)
	DEFINE_SRSUBRECCREATE(SR_NAME_PRCB, CSrDataSubrecord::Create)
	DEFINE_SRSUBRECCREATE(SR_NAME_TPIC, CSrDataSubrecord::Create)
	DEFINE_SRSUBRECCREATE(SR_NAME_PNAM, CSrDataSubrecord::Create)
	DEFINE_SRSUBRECCREATE(SR_NAME_PKC2, CSrDataSubrecord::Create)
	DEFINE_SRSUBRECCREATE(SR_NAME_IDLF, CSrDataSubrecord::Create)
	DEFINE_SRSUBRECCREATE(SR_NAME_BNAM, CSrDataSubrecord::Create)
	DEFINE_SRSUBRECCREATE(SR_NAME_IDLA, CSrDataSubrecord::Create)
	DEFINE_SRSUBRECCREATE(SR_NAME_VMAD, CSrDataSubrecord::Create)
	DEFINE_SRSUBRECCREATE(SR_NAME_IDLC, CSrDataSubrecord::Create)
	DEFINE_SRSUBRECCREATE(SR_NAME_IDLT, CSrDataSubrecord::Create)
	DEFINE_SRSUBRECCREATE(SR_NAME_SCHR, CSrDataSubrecord::Create)
	DEFINE_SRSUBRECCREATE(SR_NAME_SCTX, CSrDataSubrecord::Create)
	DEFINE_SRSUBRECCREATE(SR_NAME_PFOR, CSrDataSubrecord::Create)
	DEFINE_SRSUBRECCREATE(SR_NAME_SCDA, CSrDataSubrecord::Create)
END_SRSUBRECCREATE()
/*===========================================================================
 *		End of Subrecord Creation Array
 *=========================================================================*/


/*===========================================================================
 *
 * Begin CSrIdRecord Field Map
 *
 *=========================================================================*/
BEGIN_SRFIELDMAP(CSrPackRecord, CSrIdRecord)
END_SRFIELDMAP()
/*===========================================================================
 *		End of CObRecord Field Map
 *=========================================================================*/


/*===========================================================================
 *
 * Class CSrPackRecord Constructor
 *
 *=========================================================================*/
CSrPackRecord::CSrPackRecord () 
{
}
/*===========================================================================
 *		End of Class CSrPackRecord Constructor
 *=========================================================================*/


/*===========================================================================
 *
 * Class CSrPackRecord Method - void Destroy (void);
 *
 *=========================================================================*/
void CSrPackRecord::Destroy (void) 
{
	CSrIdRecord::Destroy();
}
/*===========================================================================
 *		End of Class Method CSrPackRecord::Destroy()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CSrPackRecord Method - void InitializeNew (void);
 *
 *=========================================================================*/
void CSrPackRecord::InitializeNew (void) 
{

	/* Call the base class method first */
	CSrIdRecord::InitializeNew();


}
/*===========================================================================
 *		End of Class Method CSrPackRecord::InitializeNew()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CSrPackRecord Event - void OnAddSubrecord (pSubrecord);
 *
 *=========================================================================*/
void CSrPackRecord::OnAddSubrecord (CSrSubrecord* pSubrecord) {

	if (pSubrecord->GetRecordType() == SR_NAME_FNAM)
	{
		m_pFnamData = SrCastClass(CSrDataSubrecord, pSubrecord);
	}
	else if (pSubrecord->GetRecordType() == SR_NAME_POBA)
	{
		m_pPobaData = SrCastClass(CSrDataSubrecord, pSubrecord);
	}
	else if (pSubrecord->GetRecordType() == SR_NAME_PKDT)
	{
		m_pPkdtData = SrCastClass(CSrDataSubrecord, pSubrecord);
	}
	else if (pSubrecord->GetRecordType() == SR_NAME_PSDT)
	{
		m_pPsdtData = SrCastClass(CSrDataSubrecord, pSubrecord);
	}
	else if (pSubrecord->GetRecordType() == SR_NAME_PLDT)
	{
		m_pPldtData = SrCastClass(CSrDataSubrecord, pSubrecord);
	}
	else if (pSubrecord->GetRecordType() == SR_NAME_ANAM)
	{
		m_pAnamData = SrCastClass(CSrDataSubrecord, pSubrecord);
	}
	else if (pSubrecord->GetRecordType() == SR_NAME_CTDA)
	{
		m_pCtdaData = SrCastClass(CSrDataSubrecord, pSubrecord);
	}
	else if (pSubrecord->GetRecordType() == SR_NAME_TNAM)
	{
		m_pTnamData = SrCastClass(CSrDataSubrecord, pSubrecord);
	}
	else if (pSubrecord->GetRecordType() == SR_NAME_PKCU)
	{
		m_pPkcuData = SrCastClass(CSrDataSubrecord, pSubrecord);
	}
	else if (pSubrecord->GetRecordType() == SR_NAME_CNAM)
	{
		m_pCnamData = SrCastClass(CSrDataSubrecord, pSubrecord);
	}
	else if (pSubrecord->GetRecordType() == SR_NAME_UNAM)
	{
		m_pUnamData = SrCastClass(CSrDataSubrecord, pSubrecord);
	}
	else if (pSubrecord->GetRecordType() == SR_NAME_XNAM)
	{
		m_pXnamData = SrCastClass(CSrDataSubrecord, pSubrecord);
	}
	else if (pSubrecord->GetRecordType() == SR_NAME_INAM)
	{
		m_pInamData = SrCastClass(CSrDataSubrecord, pSubrecord);
	}
	else if (pSubrecord->GetRecordType() == SR_NAME_PDTO)
	{
		m_pPdtoData = SrCastClass(CSrDataSubrecord, pSubrecord);
	}
	else if (pSubrecord->GetRecordType() == SR_NAME_POEA)
	{
		m_pPoeaData = SrCastClass(CSrDataSubrecord, pSubrecord);
	}
	else if (pSubrecord->GetRecordType() == SR_NAME_PTDA)
	{
		m_pPtdaData = SrCastClass(CSrDataSubrecord, pSubrecord);
	}
	else if (pSubrecord->GetRecordType() == SR_NAME_POCA)
	{
		m_pPocaData = SrCastClass(CSrDataSubrecord, pSubrecord);
	}
	else if (pSubrecord->GetRecordType() == SR_NAME_QNAM)
	{
		m_pQnamData = SrCastClass(CSrDataSubrecord, pSubrecord);
	}
	else if (pSubrecord->GetRecordType() == SR_NAME_CIS2)
	{
		m_pCis2Data = SrCastClass(CSrDataSubrecord, pSubrecord);
	}
	else if (pSubrecord->GetRecordType() == SR_NAME_PFO2)
	{
		m_pPfo2Data = SrCastClass(CSrDataSubrecord, pSubrecord);
	}
	else if (pSubrecord->GetRecordType() == SR_NAME_CITC)
	{
		m_pCitcData = SrCastClass(CSrDataSubrecord, pSubrecord);
	}
	else if (pSubrecord->GetRecordType() == SR_NAME_PRCB)
	{
		m_pPrcbData = SrCastClass(CSrDataSubrecord, pSubrecord);
	}
	else if (pSubrecord->GetRecordType() == SR_NAME_TPIC)
	{
		m_pTpicData = SrCastClass(CSrDataSubrecord, pSubrecord);
	}
	else if (pSubrecord->GetRecordType() == SR_NAME_PNAM)
	{
		m_pPnamData = SrCastClass(CSrDataSubrecord, pSubrecord);
	}
	else if (pSubrecord->GetRecordType() == SR_NAME_PKC2)
	{
		m_pPkc2Data = SrCastClass(CSrDataSubrecord, pSubrecord);
	}
	else if (pSubrecord->GetRecordType() == SR_NAME_IDLF)
	{
		m_pIdlfData = SrCastClass(CSrDataSubrecord, pSubrecord);
	}
	else if (pSubrecord->GetRecordType() == SR_NAME_BNAM)
	{
		m_pBnamData = SrCastClass(CSrDataSubrecord, pSubrecord);
	}
	else if (pSubrecord->GetRecordType() == SR_NAME_IDLA)
	{
		m_pIdlaData = SrCastClass(CSrDataSubrecord, pSubrecord);
	}
	else if (pSubrecord->GetRecordType() == SR_NAME_VMAD)
	{
		m_pVmadData = SrCastClass(CSrDataSubrecord, pSubrecord);
	}
	else if (pSubrecord->GetRecordType() == SR_NAME_IDLC)
	{
		m_pIdlcData = SrCastClass(CSrDataSubrecord, pSubrecord);
	}
	else if (pSubrecord->GetRecordType() == SR_NAME_IDLT)
	{
		m_pIdltData = SrCastClass(CSrDataSubrecord, pSubrecord);
	}
	else if (pSubrecord->GetRecordType() == SR_NAME_CIS1)
	{
		m_pCis1Data = SrCastClass(CSrDataSubrecord, pSubrecord);
	}
	else if (pSubrecord->GetRecordType() == SR_NAME_SCHR)
	{
		m_pSchrData = SrCastClass(CSrDataSubrecord, pSubrecord);
	}
	else if (pSubrecord->GetRecordType() == SR_NAME_SCTX)
	{
		m_pSctxData = SrCastClass(CSrDataSubrecord, pSubrecord);
	}
	else if (pSubrecord->GetRecordType() == SR_NAME_PFOR)
	{
		m_pPforData = SrCastClass(CSrDataSubrecord, pSubrecord);
	}
	else if (pSubrecord->GetRecordType() == SR_NAME_SCDA)
	{
		m_pScdaData = SrCastClass(CSrDataSubrecord, pSubrecord);
	}

	else
	{
	CSrIdRecord::OnAddSubrecord(pSubrecord);
	}

}
/*===========================================================================
 *		End of Class Event CSrPackRecord::OnAddSubRecord()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CSrPackRecord Event - void OnDeleteSubrecord (pSubrecord);
 *
 *=========================================================================*/
void CSrPackRecord::OnDeleteSubrecord (CSrSubrecord* pSubrecord) {

	if (m_pFnamData == pSubrecord)
		m_pFnamData = NULL;

	else if (m_pPobaData == pSubrecord)
		m_pPobaData = NULL;
	else if (m_pPkdtData == pSubrecord)
		m_pPkdtData = NULL;
	else if (m_pPsdtData == pSubrecord)
		m_pPsdtData = NULL;
	else if (m_pPldtData == pSubrecord)
		m_pPldtData = NULL;
	else if (m_pAnamData == pSubrecord)
		m_pAnamData = NULL;
	else if (m_pCtdaData == pSubrecord)
		m_pCtdaData = NULL;
	else if (m_pTnamData == pSubrecord)
		m_pTnamData = NULL;
	else if (m_pPkcuData == pSubrecord)
		m_pPkcuData = NULL;
	else if (m_pCnamData == pSubrecord)
		m_pCnamData = NULL;
	else if (m_pUnamData == pSubrecord)
		m_pUnamData = NULL;
	else if (m_pXnamData == pSubrecord)
		m_pXnamData = NULL;
	else if (m_pInamData == pSubrecord)
		m_pInamData = NULL;
	else if (m_pPdtoData == pSubrecord)
		m_pPdtoData = NULL;
	else if (m_pPoeaData == pSubrecord)
		m_pPoeaData = NULL;
	else if (m_pPtdaData == pSubrecord)
		m_pPtdaData = NULL;
	else if (m_pPocaData == pSubrecord)
		m_pPocaData = NULL;
	else if (m_pQnamData == pSubrecord)
		m_pQnamData = NULL;
	else if (m_pCis2Data == pSubrecord)
		m_pCis2Data = NULL;
	else if (m_pPfo2Data == pSubrecord)
		m_pPfo2Data = NULL;
	else if (m_pCitcData == pSubrecord)
		m_pCitcData = NULL;
	else if (m_pPrcbData == pSubrecord)
		m_pPrcbData = NULL;
	else if (m_pTpicData == pSubrecord)
		m_pTpicData = NULL;
	else if (m_pPnamData == pSubrecord)
		m_pPnamData = NULL;
	else if (m_pPkc2Data == pSubrecord)
		m_pPkc2Data = NULL;
	else if (m_pIdlfData == pSubrecord)
		m_pIdlfData = NULL;
	else if (m_pBnamData == pSubrecord)
		m_pBnamData = NULL;
	else if (m_pIdlaData == pSubrecord)
		m_pIdlaData = NULL;
	else if (m_pVmadData == pSubrecord)
		m_pVmadData = NULL;
	else if (m_pIdlcData == pSubrecord)
		m_pIdlcData = NULL;
	else if (m_pIdltData == pSubrecord)
		m_pIdltData = NULL;
	else if (m_pCis1Data == pSubrecord)
		m_pCis1Data = NULL;
	else if (m_pSchrData == pSubrecord)
		m_pSchrData = NULL;
	else if (m_pSctxData == pSubrecord)
		m_pSctxData = NULL;
	else if (m_pPforData == pSubrecord)
		m_pPforData = NULL;
	else if (m_pScdaData == pSubrecord)
		m_pScdaData = NULL;

	else
		CSrIdRecord::OnDeleteSubrecord(pSubrecord);

}
/*===========================================================================
 *		End of Class Event CSrPackRecord::OnDeleteSubrecord()
 *=========================================================================*/


/*===========================================================================
 *
 * Begin CSrPackRecord Get Field Methods
 *
 *=========================================================================*/
/*===========================================================================
 *		End of CSrPackRecord Get Field Methods
 *=========================================================================*/


/*===========================================================================
 *
 * Begin CSrPackRecord Compare Field Methods
 *
 *=========================================================================*/
/*===========================================================================
 *		End of CSrPackRecord Compare Field Methods
 *=========================================================================*/


/*===========================================================================
 *
 * Begin CSrPackRecord Set Field Methods
 *
 *=========================================================================*/
/*===========================================================================
 *		End of CSrPackRecord Set Field Methods
 *=========================================================================*/

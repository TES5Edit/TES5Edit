/*===========================================================================
 *
 * File:		SrRefrRecord.CPP
 * Author:		Dave Humphrey (dave@uesp.net)
 * Created On:	5 December 2011
 *
 * Description
 *
 *=========================================================================*/

	/* Include Files */
#include "srRefrrecord.h"


/*===========================================================================
 *
 * Begin Subrecord Creation Array
 *
 *=========================================================================*/
BEGIN_SRSUBRECCREATE(CSrRefrRecord, CSrIdRecord)
	DEFINE_SRSUBRECCREATE(SR_NAME_FNAM, CSrDataSubrecord::Create)
	DEFINE_SRSUBRECCREATE(SR_NAME_XSCL, CSrDataSubrecord::Create)
	DEFINE_SRSUBRECCREATE(SR_NAME_XCZA, CSrDataSubrecord::Create)
	DEFINE_SRSUBRECCREATE(SR_NAME_XRGD, CSrDataSubrecord::Create)
	DEFINE_SRSUBRECCREATE(SR_NAME_NAME, CSrDataSubrecord::Create)
	DEFINE_SRSUBRECCREATE(SR_NAME_XTEL, CSrDataSubrecord::Create)
	DEFINE_SRSUBRECCREATE(SR_NAME_XRMR, CSrDataSubrecord::Create)
	DEFINE_SRSUBRECCREATE(SR_NAME_DATA, CSrDataSubrecord::Create)
	DEFINE_SRSUBRECCREATE(SR_NAME_VMAD, CSrDataSubrecord::Create)
	DEFINE_SRSUBRECCREATE(SR_NAME_XLRM, CSrDataSubrecord::Create)
	DEFINE_SRSUBRECCREATE(SR_NAME_XPRM, CSrDataSubrecord::Create)
	DEFINE_SRSUBRECCREATE(SR_NAME_XNDP, CSrDataSubrecord::Create)
	DEFINE_SRSUBRECCREATE(SR_NAME_XCVL, CSrDataSubrecord::Create)
	DEFINE_SRSUBRECCREATE(SR_NAME_XMBO, CSrDataSubrecord::Create)
	DEFINE_SRSUBRECCREATE(SR_NAME_XHTW, CSrDataSubrecord::Create)
	DEFINE_SRSUBRECCREATE(SR_NAME_XLTW, CSrDataSubrecord::Create)
	DEFINE_SRSUBRECCREATE(SR_NAME_XPRD, CSrDataSubrecord::Create)
	DEFINE_SRSUBRECCREATE(SR_NAME_XLRT, CSrDataSubrecord::Create)
	DEFINE_SRSUBRECCREATE(SR_NAME_XLIB, CSrDataSubrecord::Create)
	DEFINE_SRSUBRECCREATE(SR_NAME_XPPA, CSrDataSubrecord::Create)
	DEFINE_SRSUBRECCREATE(SR_NAME_INAM, CSrDataSubrecord::Create)
	DEFINE_SRSUBRECCREATE(SR_NAME_XAPR, CSrDataSubrecord::Create)
	DEFINE_SRSUBRECCREATE(SR_NAME_XACT, CSrDataSubrecord::Create)
	DEFINE_SRSUBRECCREATE(SR_NAME_PDTO, CSrDataSubrecord::Create)
	DEFINE_SRSUBRECCREATE(SR_NAME_XSPC, CSrDataSubrecord::Create)
	DEFINE_SRSUBRECCREATE(SR_NAME_XLOC, CSrDataSubrecord::Create)
	DEFINE_SRSUBRECCREATE(SR_NAME_XEMI, CSrDataSubrecord::Create)
	DEFINE_SRSUBRECCREATE(SR_NAME_XESP, CSrDataSubrecord::Create)
	DEFINE_SRSUBRECCREATE(SR_NAME_XFVC, CSrDataSubrecord::Create)
	DEFINE_SRSUBRECCREATE(SR_NAME_XAPD, CSrDataSubrecord::Create)
	DEFINE_SRSUBRECCREATE(SR_NAME_XPOD, CSrDataSubrecord::Create)
	DEFINE_SRSUBRECCREATE(SR_NAME_XLKR, CSrDataSubrecord::Create)
	DEFINE_SRSUBRECCREATE(SR_NAME_XRDS, CSrDataSubrecord::Create)
	DEFINE_SRSUBRECCREATE(SR_NAME_XLIG, CSrDataSubrecord::Create)
	DEFINE_SRSUBRECCREATE(SR_NAME_XALP, CSrDataSubrecord::Create)
	DEFINE_SRSUBRECCREATE(SR_NAME_XOWN, CSrDataSubrecord::Create)
	DEFINE_SRSUBRECCREATE(SR_NAME_XEZN, CSrDataSubrecord::Create)
	DEFINE_SRSUBRECCREATE(SR_NAME_XMBR, CSrDataSubrecord::Create)
	DEFINE_SRSUBRECCREATE(SR_NAME_XTRI, CSrDataSubrecord::Create)
	DEFINE_SRSUBRECCREATE(SR_NAME_ONAM, CSrDataSubrecord::Create)
	DEFINE_SRSUBRECCREATE(SR_NAME_XTNM, CSrDataSubrecord::Create)
	DEFINE_SRSUBRECCREATE(SR_NAME_XRNK, CSrDataSubrecord::Create)
	DEFINE_SRSUBRECCREATE(SR_NAME_XLCM, CSrDataSubrecord::Create)
	DEFINE_SRSUBRECCREATE(SR_NAME_XCZC, CSrDataSubrecord::Create)
	DEFINE_SRSUBRECCREATE(SR_NAME_SCTX, CSrDataSubrecord::Create)
	DEFINE_SRSUBRECCREATE(SR_NAME_LNAM, CSrDataSubrecord::Create)
	DEFINE_SRSUBRECCREATE(SR_NAME_XCNT, CSrDataSubrecord::Create)
	DEFINE_SRSUBRECCREATE(SR_NAME_XWCU, CSrDataSubrecord::Create)
	DEFINE_SRSUBRECCREATE(SR_NAME_XPWR, CSrDataSubrecord::Create)
	DEFINE_SRSUBRECCREATE(SR_NAME_XIS2, CSrDataSubrecord::Create)
	DEFINE_SRSUBRECCREATE(SR_NAME_XOCP, CSrDataSubrecord::Create)
	DEFINE_SRSUBRECCREATE(SR_NAME_XMBP, CSrDataSubrecord::Create)
	DEFINE_SRSUBRECCREATE(SR_NAME_XRGB, CSrDataSubrecord::Create)
	DEFINE_SRSUBRECCREATE(SR_NAME_XLCN, CSrDataSubrecord::Create)
	DEFINE_SRSUBRECCREATE(SR_NAME_FULL, CSrDataSubrecord::Create)
	DEFINE_SRSUBRECCREATE(SR_NAME_XWCN, CSrDataSubrecord::Create)
	DEFINE_SRSUBRECCREATE(SR_NAME_SCHR, CSrDataSubrecord::Create)
	DEFINE_SRSUBRECCREATE(SR_NAME_XMRK, CSrDataSubrecord::Create)
	DEFINE_SRSUBRECCREATE(SR_NAME_TNAM, CSrDataSubrecord::Create)
END_SRSUBRECCREATE()
/*===========================================================================
 *		End of Subrecord Creation Array
 *=========================================================================*/


/*===========================================================================
 *
 * Begin CSrRecord Field Map
 *
 *=========================================================================*/
BEGIN_SRFIELDMAP(CSrRefrRecord, CSrIdRecord)
END_SRFIELDMAP()
/*===========================================================================
 *		End of CObRecord Field Map
 *=========================================================================*/


/*===========================================================================
 *
 * Class CSrRefrRecord Constructor
 *
 *=========================================================================*/
CSrRefrRecord::CSrRefrRecord () 
{
}
/*===========================================================================
 *		End of Class CSrRefrRecord Constructor
 *=========================================================================*/


/*===========================================================================
 *
 * Class CSrRefrRecord Method - void Destroy (void);
 *
 *=========================================================================*/
void CSrRefrRecord::Destroy (void) 
{
	CSrIdRecord::Destroy();
}
/*===========================================================================
 *		End of Class Method CSrRefrRecord::Destroy()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CSrRefrRecord Method - void InitializeNew (void);
 *
 *=========================================================================*/
void CSrRefrRecord::InitializeNew (void) 
{
	CSrIdRecord::InitializeNew();
}
/*===========================================================================
 *		End of Class Method CSrRefrRecord::InitializeNew()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CSrRefrRecord Event - void OnAddSubrecord (pSubrecord);
 *
 *=========================================================================*/
void CSrRefrRecord::OnAddSubrecord (CSrSubrecord* pSubrecord) {

	if (pSubrecord->GetRecordType() == SR_NAME_FNAM)
	{
		m_pFnamData = SrCastClass(CSrDataSubrecord, pSubrecord);
	}
	else if (pSubrecord->GetRecordType() == SR_NAME_XSCL)
	{
		m_pXsclData = SrCastClass(CSrDataSubrecord, pSubrecord);
	}
	else if (pSubrecord->GetRecordType() == SR_NAME_XCZA)
	{
		m_pXczaData = SrCastClass(CSrDataSubrecord, pSubrecord);
	}
	else if (pSubrecord->GetRecordType() == SR_NAME_XRGD)
	{
		m_pXrgdData = SrCastClass(CSrDataSubrecord, pSubrecord);
	}
	else if (pSubrecord->GetRecordType() == SR_NAME_NAME)
	{
		m_pNameData = SrCastClass(CSrDataSubrecord, pSubrecord);
	}
	else if (pSubrecord->GetRecordType() == SR_NAME_XTEL)
	{
		m_pXtelData = SrCastClass(CSrDataSubrecord, pSubrecord);
	}
	else if (pSubrecord->GetRecordType() == SR_NAME_XRMR)
	{
		m_pXrmrData = SrCastClass(CSrDataSubrecord, pSubrecord);
	}
	else if (pSubrecord->GetRecordType() == SR_NAME_DATA)
	{
		m_pDataData = SrCastClass(CSrDataSubrecord, pSubrecord);
	}
	else if (pSubrecord->GetRecordType() == SR_NAME_VMAD)
	{
		m_pVmadData = SrCastClass(CSrDataSubrecord, pSubrecord);
	}
	else if (pSubrecord->GetRecordType() == SR_NAME_XLRM)
	{
		m_pXlrmData = SrCastClass(CSrDataSubrecord, pSubrecord);
	}
	else if (pSubrecord->GetRecordType() == SR_NAME_XPRM)
	{
		m_pXprmData = SrCastClass(CSrDataSubrecord, pSubrecord);
	}
	else if (pSubrecord->GetRecordType() == SR_NAME_XNDP)
	{
		m_pXndpData = SrCastClass(CSrDataSubrecord, pSubrecord);
	}
	else if (pSubrecord->GetRecordType() == SR_NAME_XCVL)
	{
		m_pXcvlData = SrCastClass(CSrDataSubrecord, pSubrecord);
	}
	else if (pSubrecord->GetRecordType() == SR_NAME_XMBO)
	{
		m_pXmboData = SrCastClass(CSrDataSubrecord, pSubrecord);
	}
	else if (pSubrecord->GetRecordType() == SR_NAME_XHTW)
	{
		m_pXhtwData = SrCastClass(CSrDataSubrecord, pSubrecord);
	}
	else if (pSubrecord->GetRecordType() == SR_NAME_XLTW)
	{
		m_pXltwData = SrCastClass(CSrDataSubrecord, pSubrecord);
	}
	else if (pSubrecord->GetRecordType() == SR_NAME_XPRD)
	{
		m_pXprdData = SrCastClass(CSrDataSubrecord, pSubrecord);
	}
	else if (pSubrecord->GetRecordType() == SR_NAME_XLRT)
	{
		m_pXlrtData = SrCastClass(CSrDataSubrecord, pSubrecord);
	}
	else if (pSubrecord->GetRecordType() == SR_NAME_XLIB)
	{
		m_pXlibData = SrCastClass(CSrDataSubrecord, pSubrecord);
	}
	else if (pSubrecord->GetRecordType() == SR_NAME_XPPA)
	{
		m_pXppaData = SrCastClass(CSrDataSubrecord, pSubrecord);
	}
	else if (pSubrecord->GetRecordType() == SR_NAME_INAM)
	{
		m_pInamData = SrCastClass(CSrDataSubrecord, pSubrecord);
	}
	else if (pSubrecord->GetRecordType() == SR_NAME_XAPR)
	{
		m_pXaprData = SrCastClass(CSrDataSubrecord, pSubrecord);
	}
	else if (pSubrecord->GetRecordType() == SR_NAME_XACT)
	{
		m_pXactData = SrCastClass(CSrDataSubrecord, pSubrecord);
	}
	else if (pSubrecord->GetRecordType() == SR_NAME_PDTO)
	{
		m_pPdtoData = SrCastClass(CSrDataSubrecord, pSubrecord);
	}
	else if (pSubrecord->GetRecordType() == SR_NAME_XSPC)
	{
		m_pXspcData = SrCastClass(CSrDataSubrecord, pSubrecord);
	}
	else if (pSubrecord->GetRecordType() == SR_NAME_XLOC)
	{
		m_pXlocData = SrCastClass(CSrDataSubrecord, pSubrecord);
	}
	else if (pSubrecord->GetRecordType() == SR_NAME_XEMI)
	{
		m_pXemiData = SrCastClass(CSrDataSubrecord, pSubrecord);
	}
	else if (pSubrecord->GetRecordType() == SR_NAME_XESP)
	{
		m_pXespData = SrCastClass(CSrDataSubrecord, pSubrecord);
	}
	else if (pSubrecord->GetRecordType() == SR_NAME_XFVC)
	{
		m_pXfvcData = SrCastClass(CSrDataSubrecord, pSubrecord);
	}
	else if (pSubrecord->GetRecordType() == SR_NAME_XAPD)
	{
		m_pXapdData = SrCastClass(CSrDataSubrecord, pSubrecord);
	}
	else if (pSubrecord->GetRecordType() == SR_NAME_XPOD)
	{
		m_pXpodData = SrCastClass(CSrDataSubrecord, pSubrecord);
	}
	else if (pSubrecord->GetRecordType() == SR_NAME_XLKR)
	{
		m_pXlkrData = SrCastClass(CSrDataSubrecord, pSubrecord);
	}
	else if (pSubrecord->GetRecordType() == SR_NAME_XRDS)
	{
		m_pXrdsData = SrCastClass(CSrDataSubrecord, pSubrecord);
	}
	else if (pSubrecord->GetRecordType() == SR_NAME_XLIG)
	{
		m_pXligData = SrCastClass(CSrDataSubrecord, pSubrecord);
	}
	else if (pSubrecord->GetRecordType() == SR_NAME_XALP)
	{
		m_pXalpData = SrCastClass(CSrDataSubrecord, pSubrecord);
	}
	else if (pSubrecord->GetRecordType() == SR_NAME_XOWN)
	{
		m_pXownData = SrCastClass(CSrDataSubrecord, pSubrecord);
	}
	else if (pSubrecord->GetRecordType() == SR_NAME_XEZN)
	{
		m_pXeznData = SrCastClass(CSrDataSubrecord, pSubrecord);
	}
	else if (pSubrecord->GetRecordType() == SR_NAME_XMBR)
	{
		m_pXmbrData = SrCastClass(CSrDataSubrecord, pSubrecord);
	}
	else if (pSubrecord->GetRecordType() == SR_NAME_XTRI)
	{
		m_pXtriData = SrCastClass(CSrDataSubrecord, pSubrecord);
	}
	else if (pSubrecord->GetRecordType() == SR_NAME_ONAM)
	{
		m_pOnamData = SrCastClass(CSrDataSubrecord, pSubrecord);
	}
	else if (pSubrecord->GetRecordType() == SR_NAME_XTNM)
	{
		m_pXtnmData = SrCastClass(CSrDataSubrecord, pSubrecord);
	}
	else if (pSubrecord->GetRecordType() == SR_NAME_XRNK)
	{
		m_pXrnkData = SrCastClass(CSrDataSubrecord, pSubrecord);
	}
	else if (pSubrecord->GetRecordType() == SR_NAME_XLCM)
	{
		m_pXlcmData = SrCastClass(CSrDataSubrecord, pSubrecord);
	}
	else if (pSubrecord->GetRecordType() == SR_NAME_XCZC)
	{
		m_pXczcData = SrCastClass(CSrDataSubrecord, pSubrecord);
	}
	else if (pSubrecord->GetRecordType() == SR_NAME_SCTX)
	{
		m_pSctxData = SrCastClass(CSrDataSubrecord, pSubrecord);
	}
	else if (pSubrecord->GetRecordType() == SR_NAME_LNAM)
	{
		m_pLnamData = SrCastClass(CSrDataSubrecord, pSubrecord);
	}
	else if (pSubrecord->GetRecordType() == SR_NAME_XCNT)
	{
		m_pXcntData = SrCastClass(CSrDataSubrecord, pSubrecord);
	}
	else if (pSubrecord->GetRecordType() == SR_NAME_XWCU)
	{
		m_pXwcuData = SrCastClass(CSrDataSubrecord, pSubrecord);
	}
	else if (pSubrecord->GetRecordType() == SR_NAME_XPWR)
	{
		m_pXpwrData = SrCastClass(CSrDataSubrecord, pSubrecord);
	}
	else if (pSubrecord->GetRecordType() == SR_NAME_XIS2)
	{
		m_pXis2Data = SrCastClass(CSrDataSubrecord, pSubrecord);
	}
	else if (pSubrecord->GetRecordType() == SR_NAME_XOCP)
	{
		m_pXocpData = SrCastClass(CSrDataSubrecord, pSubrecord);
	}
	else if (pSubrecord->GetRecordType() == SR_NAME_XMBP)
	{
		m_pXmbpData = SrCastClass(CSrDataSubrecord, pSubrecord);
	}
	else if (pSubrecord->GetRecordType() == SR_NAME_XRGB)
	{
		m_pXrgbData = SrCastClass(CSrDataSubrecord, pSubrecord);
	}
	else if (pSubrecord->GetRecordType() == SR_NAME_XLCN)
	{
		m_pXlcnData = SrCastClass(CSrDataSubrecord, pSubrecord);
	}
	else if (pSubrecord->GetRecordType() == SR_NAME_FULL)
	{
		m_pFullData = SrCastClass(CSrDataSubrecord, pSubrecord);
	}
	else if (pSubrecord->GetRecordType() == SR_NAME_XWCN)
	{
		m_pXwcnData = SrCastClass(CSrDataSubrecord, pSubrecord);
	}
	else if (pSubrecord->GetRecordType() == SR_NAME_SCHR)
	{
		m_pSchrData = SrCastClass(CSrDataSubrecord, pSubrecord);
	}
	else if (pSubrecord->GetRecordType() == SR_NAME_XMRK)
	{
		m_pXmrkData = SrCastClass(CSrDataSubrecord, pSubrecord);
	}
	else if (pSubrecord->GetRecordType() == SR_NAME_TNAM)
	{
		m_pTnamData = SrCastClass(CSrDataSubrecord, pSubrecord);
	}
	else
	{
		CSrIdRecord::OnAddSubrecord(pSubrecord);
	}

}
/*===========================================================================
 *		End of Class Event CSrRefrRecord::OnAddSubRecord()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CSrRefrRecord Event - void OnDeleteSubrecord (pSubrecord);
 *
 *=========================================================================*/
void CSrRefrRecord::OnDeleteSubrecord (CSrSubrecord* pSubrecord) {

	if (m_pFnamData == pSubrecord)
		m_pFnamData = NULL;
	else if (m_pXsclData == pSubrecord)
		m_pXsclData = NULL;
	else if (m_pXczaData == pSubrecord)
		m_pXczaData = NULL;
	else if (m_pXrgdData == pSubrecord)
		m_pXrgdData = NULL;
	else if (m_pNameData == pSubrecord)
		m_pNameData = NULL;
	else if (m_pXtelData == pSubrecord)
		m_pXtelData = NULL;
	else if (m_pXrmrData == pSubrecord)
		m_pXrmrData = NULL;
	else if (m_pDataData == pSubrecord)
		m_pDataData = NULL;
	else if (m_pVmadData == pSubrecord)
		m_pVmadData = NULL;
	else if (m_pXlrmData == pSubrecord)
		m_pXlrmData = NULL;
	else if (m_pXprmData == pSubrecord)
		m_pXprmData = NULL;
	else if (m_pXndpData == pSubrecord)
		m_pXndpData = NULL;
	else if (m_pXcvlData == pSubrecord)
		m_pXcvlData = NULL;
	else if (m_pXmboData == pSubrecord)
		m_pXmboData = NULL;
	else if (m_pXhtwData == pSubrecord)
		m_pXhtwData = NULL;
	else if (m_pXltwData == pSubrecord)
		m_pXltwData = NULL;
	else if (m_pXprdData == pSubrecord)
		m_pXprdData = NULL;
	else if (m_pXlrtData == pSubrecord)
		m_pXlrtData = NULL;
	else if (m_pXlibData == pSubrecord)
		m_pXlibData = NULL;
	else if (m_pXppaData == pSubrecord)
		m_pXppaData = NULL;
	else if (m_pInamData == pSubrecord)
		m_pInamData = NULL;
	else if (m_pXaprData == pSubrecord)
		m_pXaprData = NULL;
	else if (m_pXactData == pSubrecord)
		m_pXactData = NULL;
	else if (m_pPdtoData == pSubrecord)
		m_pPdtoData = NULL;
	else if (m_pXspcData == pSubrecord)
		m_pXspcData = NULL;
	else if (m_pXlocData == pSubrecord)
		m_pXlocData = NULL;
	else if (m_pXemiData == pSubrecord)
		m_pXemiData = NULL;
	else if (m_pXespData == pSubrecord)
		m_pXespData = NULL;
	else if (m_pXfvcData == pSubrecord)
		m_pXfvcData = NULL;
	else if (m_pXapdData == pSubrecord)
		m_pXapdData = NULL;
	else if (m_pXpodData == pSubrecord)
		m_pXpodData = NULL;
	else if (m_pXlkrData == pSubrecord)
		m_pXlkrData = NULL;
	else if (m_pXrdsData == pSubrecord)
		m_pXrdsData = NULL;
	else if (m_pXligData == pSubrecord)
		m_pXligData = NULL;
	else if (m_pXalpData == pSubrecord)
		m_pXalpData = NULL;
	else if (m_pXownData == pSubrecord)
		m_pXownData = NULL;
	else if (m_pXeznData == pSubrecord)
		m_pXeznData = NULL;
	else if (m_pXmbrData == pSubrecord)
		m_pXmbrData = NULL;
	else if (m_pXtriData == pSubrecord)
		m_pXtriData = NULL;
	else if (m_pOnamData == pSubrecord)
		m_pOnamData = NULL;
	else if (m_pXtnmData == pSubrecord)
		m_pXtnmData = NULL;
	else if (m_pXrnkData == pSubrecord)
		m_pXrnkData = NULL;
	else if (m_pXlcmData == pSubrecord)
		m_pXlcmData = NULL;
	else if (m_pXczcData == pSubrecord)
		m_pXczcData = NULL;
	else if (m_pSctxData == pSubrecord)
		m_pSctxData = NULL;
	else if (m_pLnamData == pSubrecord)
		m_pLnamData = NULL;
	else if (m_pXcntData == pSubrecord)
		m_pXcntData = NULL;
	else if (m_pXwcuData == pSubrecord)
		m_pXwcuData = NULL;
	else if (m_pXpwrData == pSubrecord)
		m_pXpwrData = NULL;
	else if (m_pXis2Data == pSubrecord)
		m_pXis2Data = NULL;
	else if (m_pXocpData == pSubrecord)
		m_pXocpData = NULL;
	else if (m_pXmbpData == pSubrecord)
		m_pXmbpData = NULL;
	else if (m_pXrgbData == pSubrecord)
		m_pXrgbData = NULL;
	else if (m_pXlcnData == pSubrecord)
		m_pXlcnData = NULL;
	else if (m_pFullData == pSubrecord)
		m_pFullData = NULL;
	else if (m_pXwcnData == pSubrecord)
		m_pXwcnData = NULL;
	else if (m_pSchrData == pSubrecord)
		m_pSchrData = NULL;
	else if (m_pXmrkData == pSubrecord)
		m_pXmrkData = NULL;
	else if (m_pTnamData == pSubrecord)
		m_pTnamData = NULL;
	else
		CSrIdRecord::OnDeleteSubrecord(pSubrecord);

}
/*===========================================================================
 *		End of Class Event CSrRefrRecord::OnDeleteSubrecord()
 *=========================================================================*/


/*===========================================================================
 *
 * Begin CSrRefrRecord Get Field Methods
 *
 *=========================================================================*/
/*===========================================================================
 *		End of CSrRefrRecord Get Field Methods
 *=========================================================================*/


/*===========================================================================
 *
 * Begin CSrRefrRecord Compare Field Methods
 *
 *=========================================================================*/
/*===========================================================================
 *		End of CSrRefrRecord Compare Field Methods
 *=========================================================================*/


/*===========================================================================
 *
 * Begin CSrRefrRecord Set Field Methods
 *
 *=========================================================================*/
/*===========================================================================
 *		End of CSrRefrRecord Set Field Methods
 *=========================================================================*/

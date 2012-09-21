/*===========================================================================
 *
 * File:		SrNpc_Record.CPP
 * Author:		Dave Humphrey (dave@uesp.net)
 * Created On:	5 December 2011
 *
 * Description
 *
 *=========================================================================*/

	/* Include Files */
#include "srNpc_record.h"


/*===========================================================================
 *
 * Begin Subrecord Creation Array
 *
 *=========================================================================*/
BEGIN_SRSUBRECCREATE(CSrNpc_Record, CSrIdRecord)
	DEFINE_SRSUBRECCREATE(SR_NAME_TINC, CSrDataSubrecord::Create)
	DEFINE_SRSUBRECCREATE(SR_NAME_SPLO, CSrDataSubrecord::Create)
	DEFINE_SRSUBRECCREATE(SR_NAME_CSDI, CSrDataSubrecord::Create)
	DEFINE_SRSUBRECCREATE(SR_NAME_CNAM, CSrDataSubrecord::Create)
	DEFINE_SRSUBRECCREATE(SR_NAME_DEST, CSrDataSubrecord::Create)
	DEFINE_SRSUBRECCREATE(SR_NAME_SPOR, CSrDataSubrecord::Create)
	DEFINE_SRSUBRECCREATE(SR_NAME_ATKR, CSrDataSubrecord::Create)
	DEFINE_SRSUBRECCREATE(SR_NAME_VMAD, CSrDataSubrecord::Create)
	DEFINE_SRSUBRECCREATE(SR_NAME_ACBS, CSrDataSubrecord::Create)
	DEFINE_SRSUBRECCREATE(SR_NAME_TPLT, CSrDataSubrecord::Create)
	DEFINE_SRSUBRECCREATE(SR_NAME_SPCT, CSrDataSubrecord::Create)
	DEFINE_SRSUBRECCREATE(SR_NAME_RNAM, CSrDataSubrecord::Create)
	DEFINE_SRSUBRECCREATE(SR_NAME_AIDT, CSrDataSubrecord::Create)
	DEFINE_SRSUBRECCREATE(SR_NAME_SOFT, CSrDataSubrecord::Create)
	DEFINE_SRSUBRECCREATE(SR_NAME_DATA, CSrDataSubrecord::Create)
	DEFINE_SRSUBRECCREATE(SR_NAME_DNAM, CSrDataSubrecord::Create)
	DEFINE_SRSUBRECCREATE(SR_NAME_NAM5, CSrDataSubrecord::Create)
	DEFINE_SRSUBRECCREATE(SR_NAME_KSIZ, CSrDataSubrecord::Create)
	DEFINE_SRSUBRECCREATE(SR_NAME_NAM6, CSrDataSubrecord::Create)
	DEFINE_SRSUBRECCREATE(SR_NAME_TIAS, CSrDataSubrecord::Create)
	DEFINE_SRSUBRECCREATE(SR_NAME_NAM7, CSrDataSubrecord::Create)
	DEFINE_SRSUBRECCREATE(SR_NAME_NAM8, CSrDataSubrecord::Create)
	DEFINE_SRSUBRECCREATE(SR_NAME_PKID, CSrDataSubrecord::Create)
	DEFINE_SRSUBRECCREATE(SR_NAME_QNAM, CSrDataSubrecord::Create)
	DEFINE_SRSUBRECCREATE(SR_NAME_SNAM, CSrDataSubrecord::Create)
	DEFINE_SRSUBRECCREATE(SR_NAME_INAM, CSrDataSubrecord::Create)
	DEFINE_SRSUBRECCREATE(SR_NAME_VTCK, CSrDataSubrecord::Create)
	DEFINE_SRSUBRECCREATE(SR_NAME_NAMA, CSrDataSubrecord::Create)
	DEFINE_SRSUBRECCREATE(SR_NAME_WNAM, CSrDataSubrecord::Create)
	DEFINE_SRSUBRECCREATE(SR_NAME_DOFT, CSrDataSubrecord::Create)
	DEFINE_SRSUBRECCREATE(SR_NAME_ZNAM, CSrDataSubrecord::Create)
	DEFINE_SRSUBRECCREATE(SR_NAME_DPLT, CSrDataSubrecord::Create)
	DEFINE_SRSUBRECCREATE(SR_NAME_KWDA, CSrDataSubrecord::Create)
	DEFINE_SRSUBRECCREATE(SR_NAME_CSCR, CSrDataSubrecord::Create)
	DEFINE_SRSUBRECCREATE(SR_NAME_CSDT, CSrDataSubrecord::Create)
	DEFINE_SRSUBRECCREATE(SR_NAME_COCT, CSrDataSubrecord::Create)
	DEFINE_SRSUBRECCREATE(SR_NAME_TINI, CSrDataSubrecord::Create)
	DEFINE_SRSUBRECCREATE(SR_NAME_PRKR, CSrDataSubrecord::Create)
	DEFINE_SRSUBRECCREATE(SR_NAME_CNTO, CSrDataSubrecord::Create)
	DEFINE_SRSUBRECCREATE(SR_NAME_PRKZ, CSrDataSubrecord::Create)
	DEFINE_SRSUBRECCREATE(SR_NAME_PNAM, CSrDataSubrecord::Create)
	DEFINE_SRSUBRECCREATE(SR_NAME_ANAM, CSrDataSubrecord::Create)
	DEFINE_SRSUBRECCREATE(SR_NAME_HCLF, CSrDataSubrecord::Create)
	DEFINE_SRSUBRECCREATE(SR_NAME_FTST, CSrDataSubrecord::Create)
	DEFINE_SRSUBRECCREATE(SR_NAME_NAM9, CSrDataSubrecord::Create)
	DEFINE_SRSUBRECCREATE(SR_NAME_TINV, CSrDataSubrecord::Create)
	DEFINE_SRSUBRECCREATE(SR_NAME_FULL, CSrDataSubrecord::Create)
	DEFINE_SRSUBRECCREATE(SR_NAME_CSDC, CSrDataSubrecord::Create)
	DEFINE_SRSUBRECCREATE(SR_NAME_ECOR, CSrDataSubrecord::Create)
	DEFINE_SRSUBRECCREATE(SR_NAME_CRIF, CSrDataSubrecord::Create)
	DEFINE_SRSUBRECCREATE(SR_NAME_SHRT, CSrDataSubrecord::Create)
	DEFINE_SRSUBRECCREATE(SR_NAME_DSTF, CSrDataSubrecord::Create)
	DEFINE_SRSUBRECCREATE(SR_NAME_ATKD, CSrDataSubrecord::Create)
	DEFINE_SRSUBRECCREATE(SR_NAME_ATKE, CSrDataSubrecord::Create)
	DEFINE_SRSUBRECCREATE(SR_NAME_DSTD, CSrDataSubrecord::Create)
	DEFINE_SRSUBRECCREATE(SR_NAME_GNAM, CSrDataSubrecord::Create)
END_SRSUBRECCREATE()
/*===========================================================================
 *		End of Subrecord Creation Array
 *=========================================================================*/


/*===========================================================================
 *
 * Begin CSrRecord Field Map
 *
 *=========================================================================*/
BEGIN_SRFIELDMAP(CSrNpc_Record, CSrIdRecord)
END_SRFIELDMAP()
/*===========================================================================
 *		End of CObRecord Field Map
 *=========================================================================*/


/*===========================================================================
 *
 * Class CSrNpc_Record Constructor
 *
 *=========================================================================*/
CSrNpc_Record::CSrNpc_Record () 
{
}
/*===========================================================================
 *		End of Class CSrNpc_Record Constructor
 *=========================================================================*/


/*===========================================================================
 *
 * Class CSrNpc_Record Method - void Destroy (void);
 *
 *=========================================================================*/
void CSrNpc_Record::Destroy (void) 
{
	CSrIdRecord::Destroy();
}
/*===========================================================================
 *		End of Class Method CSrNpc_Record::Destroy()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CSrNpc_Record Method - void InitializeNew (void);
 *
 *=========================================================================*/
void CSrNpc_Record::InitializeNew (void) 
{
	CSrIdRecord::InitializeNew();
}
/*===========================================================================
 *		End of Class Method CSrNpc_Record::InitializeNew()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CSrNpc_Record Event - void OnAddSubrecord (pSubrecord);
 *
 *=========================================================================*/
void CSrNpc_Record::OnAddSubrecord (CSrSubrecord* pSubrecord) {

	if (pSubrecord->GetRecordType() == SR_NAME_TINC)
	{
		m_pTincData = SrCastClass(CSrDataSubrecord, pSubrecord);
	}
	else if (pSubrecord->GetRecordType() == SR_NAME_SPLO)
	{
		m_pSploData = SrCastClass(CSrDataSubrecord, pSubrecord);
	}
	else if (pSubrecord->GetRecordType() == SR_NAME_CSDI)
	{
		m_pCsdiData = SrCastClass(CSrDataSubrecord, pSubrecord);
	}
	else if (pSubrecord->GetRecordType() == SR_NAME_CNAM)
	{
		m_pCnamData = SrCastClass(CSrDataSubrecord, pSubrecord);
	}
	else if (pSubrecord->GetRecordType() == SR_NAME_DEST)
	{
		m_pDestData = SrCastClass(CSrDataSubrecord, pSubrecord);
	}
	else if (pSubrecord->GetRecordType() == SR_NAME_SPOR)
	{
		m_pSporData = SrCastClass(CSrDataSubrecord, pSubrecord);
	}
	else if (pSubrecord->GetRecordType() == SR_NAME_ATKR)
	{
		m_pAtkrData = SrCastClass(CSrDataSubrecord, pSubrecord);
	}
	else if (pSubrecord->GetRecordType() == SR_NAME_VMAD)
	{
		m_pVmadData = SrCastClass(CSrDataSubrecord, pSubrecord);
	}
	else if (pSubrecord->GetRecordType() == SR_NAME_ACBS)
	{
		m_pAcbsData = SrCastClass(CSrDataSubrecord, pSubrecord);
	}
	else if (pSubrecord->GetRecordType() == SR_NAME_TPLT)
	{
		m_pTpltData = SrCastClass(CSrDataSubrecord, pSubrecord);
	}
	else if (pSubrecord->GetRecordType() == SR_NAME_SPCT)
	{
		m_pSpctData = SrCastClass(CSrDataSubrecord, pSubrecord);
	}
	else if (pSubrecord->GetRecordType() == SR_NAME_RNAM)
	{
		m_pRnamData = SrCastClass(CSrDataSubrecord, pSubrecord);
	}
	else if (pSubrecord->GetRecordType() == SR_NAME_AIDT)
	{
		m_pAidtData = SrCastClass(CSrDataSubrecord, pSubrecord);
	}
	else if (pSubrecord->GetRecordType() == SR_NAME_SOFT)
	{
		m_pSoftData = SrCastClass(CSrDataSubrecord, pSubrecord);
	}
	else if (pSubrecord->GetRecordType() == SR_NAME_DATA)
	{
		m_pDataData = SrCastClass(CSrDataSubrecord, pSubrecord);
	}
	else if (pSubrecord->GetRecordType() == SR_NAME_DNAM)
	{
		m_pDnamData = SrCastClass(CSrDataSubrecord, pSubrecord);
	}
	else if (pSubrecord->GetRecordType() == SR_NAME_NAM5)
	{
		m_pNam5Data = SrCastClass(CSrDataSubrecord, pSubrecord);
	}
	else if (pSubrecord->GetRecordType() == SR_NAME_KSIZ)
	{
		m_pKsizData = SrCastClass(CSrDataSubrecord, pSubrecord);
	}
	else if (pSubrecord->GetRecordType() == SR_NAME_NAM6)
	{
		m_pNam6Data = SrCastClass(CSrDataSubrecord, pSubrecord);
	}
	else if (pSubrecord->GetRecordType() == SR_NAME_TIAS)
	{
		m_pTiasData = SrCastClass(CSrDataSubrecord, pSubrecord);
	}
	else if (pSubrecord->GetRecordType() == SR_NAME_NAM7)
	{
		m_pNam7Data = SrCastClass(CSrDataSubrecord, pSubrecord);
	}
	else if (pSubrecord->GetRecordType() == SR_NAME_NAM8)
	{
		m_pNam8Data = SrCastClass(CSrDataSubrecord, pSubrecord);
	}
	else if (pSubrecord->GetRecordType() == SR_NAME_PKID)
	{
		m_pPkidData = SrCastClass(CSrDataSubrecord, pSubrecord);
	}
	else if (pSubrecord->GetRecordType() == SR_NAME_QNAM)
	{
		m_pQnamData = SrCastClass(CSrDataSubrecord, pSubrecord);
	}
	else if (pSubrecord->GetRecordType() == SR_NAME_SNAM)
	{
		m_pSnamData = SrCastClass(CSrDataSubrecord, pSubrecord);
	}
	else if (pSubrecord->GetRecordType() == SR_NAME_INAM)
	{
		m_pInamData = SrCastClass(CSrDataSubrecord, pSubrecord);
	}
	else if (pSubrecord->GetRecordType() == SR_NAME_VTCK)
	{
		m_pVtckData = SrCastClass(CSrDataSubrecord, pSubrecord);
	}
	else if (pSubrecord->GetRecordType() == SR_NAME_NAMA)
	{
		m_pNamaData = SrCastClass(CSrDataSubrecord, pSubrecord);
	}
	else if (pSubrecord->GetRecordType() == SR_NAME_WNAM)
	{
		m_pWnamData = SrCastClass(CSrDataSubrecord, pSubrecord);
	}
	else if (pSubrecord->GetRecordType() == SR_NAME_DOFT)
	{
		m_pDoftData = SrCastClass(CSrDataSubrecord, pSubrecord);
	}
	else if (pSubrecord->GetRecordType() == SR_NAME_ZNAM)
	{
		m_pZnamData = SrCastClass(CSrDataSubrecord, pSubrecord);
	}
	else if (pSubrecord->GetRecordType() == SR_NAME_DPLT)
	{
		m_pDpltData = SrCastClass(CSrDataSubrecord, pSubrecord);
	}
	else if (pSubrecord->GetRecordType() == SR_NAME_KWDA)
	{
		m_pKwdaData = SrCastClass(CSrDataSubrecord, pSubrecord);
	}
	else if (pSubrecord->GetRecordType() == SR_NAME_CSCR)
	{
		m_pCscrData = SrCastClass(CSrDataSubrecord, pSubrecord);
	}
	else if (pSubrecord->GetRecordType() == SR_NAME_CSDT)
	{
		m_pCsdtData = SrCastClass(CSrDataSubrecord, pSubrecord);
	}
	else if (pSubrecord->GetRecordType() == SR_NAME_COCT)
	{
		m_pCoctData = SrCastClass(CSrDataSubrecord, pSubrecord);
	}
	else if (pSubrecord->GetRecordType() == SR_NAME_TINI)
	{
		m_pTiniData = SrCastClass(CSrDataSubrecord, pSubrecord);
	}
	else if (pSubrecord->GetRecordType() == SR_NAME_PRKR)
	{
		m_pPrkrData = SrCastClass(CSrDataSubrecord, pSubrecord);
	}
	else if (pSubrecord->GetRecordType() == SR_NAME_CNTO)
	{
		m_pCntoData = SrCastClass(CSrDataSubrecord, pSubrecord);
	}
	else if (pSubrecord->GetRecordType() == SR_NAME_PRKZ)
	{
		m_pPrkzData = SrCastClass(CSrDataSubrecord, pSubrecord);
	}
	else if (pSubrecord->GetRecordType() == SR_NAME_PNAM)
	{
		m_pPnamData = SrCastClass(CSrDataSubrecord, pSubrecord);
	}
	else if (pSubrecord->GetRecordType() == SR_NAME_ANAM)
	{
		m_pAnamData = SrCastClass(CSrDataSubrecord, pSubrecord);
	}
	else if (pSubrecord->GetRecordType() == SR_NAME_HCLF)
	{
		m_pHclfData = SrCastClass(CSrDataSubrecord, pSubrecord);
	}
	else if (pSubrecord->GetRecordType() == SR_NAME_FTST)
	{
		m_pFtstData = SrCastClass(CSrDataSubrecord, pSubrecord);
	}
	else if (pSubrecord->GetRecordType() == SR_NAME_NAM9)
	{
		m_pNam9Data = SrCastClass(CSrDataSubrecord, pSubrecord);
	}
	else if (pSubrecord->GetRecordType() == SR_NAME_TINV)
	{
		m_pTinvData = SrCastClass(CSrDataSubrecord, pSubrecord);
	}
	else if (pSubrecord->GetRecordType() == SR_NAME_FULL)
	{
		m_pFullData = SrCastClass(CSrDataSubrecord, pSubrecord);
	}
	else if (pSubrecord->GetRecordType() == SR_NAME_CSDC)
	{
		m_pCsdcData = SrCastClass(CSrDataSubrecord, pSubrecord);
	}
	else if (pSubrecord->GetRecordType() == SR_NAME_ECOR)
	{
		m_pEcorData = SrCastClass(CSrDataSubrecord, pSubrecord);
	}
	else if (pSubrecord->GetRecordType() == SR_NAME_CRIF)
	{
		m_pCrifData = SrCastClass(CSrDataSubrecord, pSubrecord);
	}
	else if (pSubrecord->GetRecordType() == SR_NAME_SHRT)
	{
		m_pShrtData = SrCastClass(CSrDataSubrecord, pSubrecord);
	}
	else if (pSubrecord->GetRecordType() == SR_NAME_DSTF)
	{
		m_pDstfData = SrCastClass(CSrDataSubrecord, pSubrecord);
	}
	else if (pSubrecord->GetRecordType() == SR_NAME_ATKD)
	{
		m_pAtkdData = SrCastClass(CSrDataSubrecord, pSubrecord);
	}
	else if (pSubrecord->GetRecordType() == SR_NAME_ATKE)
	{
		m_pAtkeData = SrCastClass(CSrDataSubrecord, pSubrecord);
	}
	else if (pSubrecord->GetRecordType() == SR_NAME_DSTD)
	{
		m_pDstdData = SrCastClass(CSrDataSubrecord, pSubrecord);
	}
	else if (pSubrecord->GetRecordType() == SR_NAME_GNAM)
	{
		m_pGnamData = SrCastClass(CSrDataSubrecord, pSubrecord);
	}
	else
	{
		CSrIdRecord::OnAddSubrecord(pSubrecord);
	}

}
/*===========================================================================
 *		End of Class Event CSrNpc_Record::OnAddSubRecord()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CSrNpc_Record Event - void OnDeleteSubrecord (pSubrecord);
 *
 *=========================================================================*/
void CSrNpc_Record::OnDeleteSubrecord (CSrSubrecord* pSubrecord) {

	if (m_pTincData == pSubrecord)
		m_pTincData = NULL;
	else if (m_pSploData == pSubrecord)
		m_pSploData = NULL;
	else if (m_pCsdiData == pSubrecord)
		m_pCsdiData = NULL;
	else if (m_pCnamData == pSubrecord)
		m_pCnamData = NULL;
	else if (m_pDestData == pSubrecord)
		m_pDestData = NULL;
	else if (m_pSporData == pSubrecord)
		m_pSporData = NULL;
	else if (m_pAtkrData == pSubrecord)
		m_pAtkrData = NULL;
	else if (m_pVmadData == pSubrecord)
		m_pVmadData = NULL;
	else if (m_pAcbsData == pSubrecord)
		m_pAcbsData = NULL;
	else if (m_pTpltData == pSubrecord)
		m_pTpltData = NULL;
	else if (m_pSpctData == pSubrecord)
		m_pSpctData = NULL;
	else if (m_pRnamData == pSubrecord)
		m_pRnamData = NULL;
	else if (m_pAidtData == pSubrecord)
		m_pAidtData = NULL;
	else if (m_pSoftData == pSubrecord)
		m_pSoftData = NULL;
	else if (m_pDataData == pSubrecord)
		m_pDataData = NULL;
	else if (m_pDnamData == pSubrecord)
		m_pDnamData = NULL;
	else if (m_pNam5Data == pSubrecord)
		m_pNam5Data = NULL;
	else if (m_pKsizData == pSubrecord)
		m_pKsizData = NULL;
	else if (m_pNam6Data == pSubrecord)
		m_pNam6Data = NULL;
	else if (m_pTiasData == pSubrecord)
		m_pTiasData = NULL;
	else if (m_pNam7Data == pSubrecord)
		m_pNam7Data = NULL;
	else if (m_pNam8Data == pSubrecord)
		m_pNam8Data = NULL;
	else if (m_pPkidData == pSubrecord)
		m_pPkidData = NULL;
	else if (m_pQnamData == pSubrecord)
		m_pQnamData = NULL;
	else if (m_pSnamData == pSubrecord)
		m_pSnamData = NULL;
	else if (m_pInamData == pSubrecord)
		m_pInamData = NULL;
	else if (m_pVtckData == pSubrecord)
		m_pVtckData = NULL;
	else if (m_pNamaData == pSubrecord)
		m_pNamaData = NULL;
	else if (m_pWnamData == pSubrecord)
		m_pWnamData = NULL;
	else if (m_pDoftData == pSubrecord)
		m_pDoftData = NULL;
	else if (m_pZnamData == pSubrecord)
		m_pZnamData = NULL;
	else if (m_pDpltData == pSubrecord)
		m_pDpltData = NULL;
	else if (m_pKwdaData == pSubrecord)
		m_pKwdaData = NULL;
	else if (m_pCscrData == pSubrecord)
		m_pCscrData = NULL;
	else if (m_pCsdtData == pSubrecord)
		m_pCsdtData = NULL;
	else if (m_pCoctData == pSubrecord)
		m_pCoctData = NULL;
	else if (m_pTiniData == pSubrecord)
		m_pTiniData = NULL;
	else if (m_pPrkrData == pSubrecord)
		m_pPrkrData = NULL;
	else if (m_pCntoData == pSubrecord)
		m_pCntoData = NULL;
	else if (m_pPrkzData == pSubrecord)
		m_pPrkzData = NULL;
	else if (m_pPnamData == pSubrecord)
		m_pPnamData = NULL;
	else if (m_pAnamData == pSubrecord)
		m_pAnamData = NULL;
	else if (m_pHclfData == pSubrecord)
		m_pHclfData = NULL;
	else if (m_pFtstData == pSubrecord)
		m_pFtstData = NULL;
	else if (m_pNam9Data == pSubrecord)
		m_pNam9Data = NULL;
	else if (m_pTinvData == pSubrecord)
		m_pTinvData = NULL;
	else if (m_pFullData == pSubrecord)
		m_pFullData = NULL;
	else if (m_pCsdcData == pSubrecord)
		m_pCsdcData = NULL;
	else if (m_pEcorData == pSubrecord)
		m_pEcorData = NULL;
	else if (m_pCrifData == pSubrecord)
		m_pCrifData = NULL;
	else if (m_pShrtData == pSubrecord)
		m_pShrtData = NULL;
	else if (m_pDstfData == pSubrecord)
		m_pDstfData = NULL;
	else if (m_pAtkdData == pSubrecord)
		m_pAtkdData = NULL;
	else if (m_pAtkeData == pSubrecord)
		m_pAtkeData = NULL;
	else if (m_pDstdData == pSubrecord)
		m_pDstdData = NULL;
	else if (m_pGnamData == pSubrecord)
		m_pGnamData = NULL;
	else
		CSrIdRecord::OnDeleteSubrecord(pSubrecord);

}
/*===========================================================================
 *		End of Class Event CSrNpc_Record::OnDeleteSubrecord()
 *=========================================================================*/


/*===========================================================================
 *
 * Begin CSrNpc_Record Get Field Methods
 *
 *=========================================================================*/
/*===========================================================================
 *		End of CSrNpc_Record Get Field Methods
 *=========================================================================*/


/*===========================================================================
 *
 * Begin CSrNpc_Record Compare Field Methods
 *
 *=========================================================================*/
/*===========================================================================
 *		End of CSrNpc_Record Compare Field Methods
 *=========================================================================*/


/*===========================================================================
 *
 * Begin CSrNpc_Record Set Field Methods
 *
 *=========================================================================*/
/*===========================================================================
 *		End of CSrNpc_Record Set Field Methods
 *=========================================================================*/

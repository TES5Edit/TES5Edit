/*===========================================================================
 *
 * File:		SrQustRecord.CPP
 * Author:		Dave Humphrey (dave@uesp.net)
 * Created On:	5 December 2011
 *
 * Description
 *
 *=========================================================================*/

	/* Include Files */
#include "srQustrecord.h"


/*===========================================================================
 *
 * Begin Subrecord Creation Array
 *
 *=========================================================================*/
BEGIN_SRSUBRECCREATE(CSrQustRecord, CSrIdRecord)
	DEFINE_SRSUBRECCREATE(SR_NAME_FNAM, CSrDataSubrecord::Create)
	DEFINE_SRSUBRECCREATE(SR_NAME_ALNT, CSrDataSubrecord::Create)
	DEFINE_SRSUBRECCREATE(SR_NAME_INDX, CSrDataSubrecord::Create)
	DEFINE_SRSUBRECCREATE(SR_NAME_NEXT, CSrDataSubrecord::Create)
	DEFINE_SRSUBRECCREATE(SR_NAME_FLTR, CSrDataSubrecord::Create)
	DEFINE_SRSUBRECCREATE(SR_NAME_SPOR, CSrDataSubrecord::Create)
	DEFINE_SRSUBRECCREATE(SR_NAME_VMAD, CSrDataSubrecord::Create)
	DEFINE_SRSUBRECCREATE(SR_NAME_KNAM, CSrDataSubrecord::Create)
	DEFINE_SRSUBRECCREATE(SR_NAME_FULL, CSrDataSubrecord::Create)
	DEFINE_SRSUBRECCREATE(SR_NAME_DNAM, CSrDataSubrecord::Create)
	DEFINE_SRSUBRECCREATE(SR_NAME_ALFL, CSrDataSubrecord::Create)
	DEFINE_SRSUBRECCREATE(SR_NAME_ANAM, CSrDataSubrecord::Create)
	DEFINE_SRSUBRECCREATE(SR_NAME_CTDA, CSrDataSubrecord::Create)
	DEFINE_SRSUBRECCREATE(SR_NAME_CIS1, CSrStringSubrecord::Create)
	DEFINE_SRSUBRECCREATE(SR_NAME_CIS2, CSrStringSubrecord::Create)
	DEFINE_SRSUBRECCREATE(SR_NAME_ENAM, CSrDataSubrecord::Create)
	DEFINE_SRSUBRECCREATE(SR_NAME_QSDT, CSrDataSubrecord::Create)
	DEFINE_SRSUBRECCREATE(SR_NAME_ALST, CSrDataSubrecord::Create)
	DEFINE_SRSUBRECCREATE(SR_NAME_COCT, CSrDataSubrecord::Create)
	DEFINE_SRSUBRECCREATE(SR_NAME_QOBJ, CSrDataSubrecord::Create)
	DEFINE_SRSUBRECCREATE(SR_NAME_ALPC, CSrDataSubrecord::Create)
	DEFINE_SRSUBRECCREATE(SR_NAME_ALID, CSrDataSubrecord::Create)
	DEFINE_SRSUBRECCREATE(SR_NAME_ALFE, CSrDataSubrecord::Create)
	DEFINE_SRSUBRECCREATE(SR_NAME_ALED, CSrDataSubrecord::Create)
	DEFINE_SRSUBRECCREATE(SR_NAME_ALFD, CSrDataSubrecord::Create)
	DEFINE_SRSUBRECCREATE(SR_NAME_VTCK, CSrDataSubrecord::Create)
	DEFINE_SRSUBRECCREATE(SR_NAME_ALCA, CSrDataSubrecord::Create)
	DEFINE_SRSUBRECCREATE(SR_NAME_ALLS, CSrDataSubrecord::Create)
	DEFINE_SRSUBRECCREATE(SR_NAME_ALUA, CSrDataSubrecord::Create)
	DEFINE_SRSUBRECCREATE(SR_NAME_ALSP, CSrDataSubrecord::Create)
	DEFINE_SRSUBRECCREATE(SR_NAME_ALFR, CSrDataSubrecord::Create)
	DEFINE_SRSUBRECCREATE(SR_NAME_ALCO, CSrDataSubrecord::Create)
	DEFINE_SRSUBRECCREATE(SR_NAME_CIS2, CSrDataSubrecord::Create)
	DEFINE_SRSUBRECCREATE(SR_NAME_ALCL, CSrDataSubrecord::Create)
	DEFINE_SRSUBRECCREATE(SR_NAME_NNAM, CSrDataSubrecord::Create)
	DEFINE_SRSUBRECCREATE(SR_NAME_SCHR, CSrDataSubrecord::Create)
	DEFINE_SRSUBRECCREATE(SR_NAME_QSTA, CSrDataSubrecord::Create)
	DEFINE_SRSUBRECCREATE(SR_NAME_ALEA, CSrDataSubrecord::Create)
	DEFINE_SRSUBRECCREATE(SR_NAME_ALFA, CSrDataSubrecord::Create)
	DEFINE_SRSUBRECCREATE(SR_NAME_KWDA, CSrDataSubrecord::Create)
	DEFINE_SRSUBRECCREATE(SR_NAME_ALRT, CSrDataSubrecord::Create)
	DEFINE_SRSUBRECCREATE(SR_NAME_KSIZ, CSrDataSubrecord::Create)
	DEFINE_SRSUBRECCREATE(SR_NAME_ALFI, CSrDataSubrecord::Create)
	DEFINE_SRSUBRECCREATE(SR_NAME_NAM0, CSrDataSubrecord::Create)
	DEFINE_SRSUBRECCREATE(SR_NAME_ALFC, CSrDataSubrecord::Create)
	DEFINE_SRSUBRECCREATE(SR_NAME_CNTO, CSrDataSubrecord::Create)
	DEFINE_SRSUBRECCREATE(SR_NAME_ALNA, CSrDataSubrecord::Create)
	DEFINE_SRSUBRECCREATE(SR_NAME_QNAM, CSrDataSubrecord::Create)
	DEFINE_SRSUBRECCREATE(SR_NAME_QTGL, CSrDataSubrecord::Create)
	DEFINE_SRSUBRECCREATE(SR_NAME_ECOR, CSrDataSubrecord::Create)
	DEFINE_SRSUBRECCREATE(SR_NAME_ALEQ, CSrDataSubrecord::Create)
	DEFINE_SRSUBRECCREATE(SR_NAME_ALDN, CSrDataSubrecord::Create)
	DEFINE_SRSUBRECCREATE(SR_NAME_CNAM, CSrDataSubrecord::Create)
	DEFINE_SRSUBRECCREATE(SR_NAME_SCTX, CSrDataSubrecord::Create)
END_SRSUBRECCREATE()
/*===========================================================================
 *		End of Subrecord Creation Array
 *=========================================================================*/


/*===========================================================================
 *
 * Begin CSrIdRecord Field Map
 *
 *=========================================================================*/
BEGIN_SRFIELDMAP(CSrQustRecord, CSrIdRecord)
END_SRFIELDMAP()
/*===========================================================================
 *		End of CObRecord Field Map
 *=========================================================================*/


/*===========================================================================
 *
 * Class CSrQustRecord Constructor
 *
 *=========================================================================*/
CSrQustRecord::CSrQustRecord () 
{
}
/*===========================================================================
 *		End of Class CSrQustRecord Constructor
 *=========================================================================*/


/*===========================================================================
 *
 * Class CSrQustRecord Method - void Destroy (void);
 *
 *=========================================================================*/
void CSrQustRecord::Destroy (void) 
{
	CSrIdRecord::Destroy();
}
/*===========================================================================
 *		End of Class Method CSrQustRecord::Destroy()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CSrQustRecord Method - void InitializeNew (void);
 *
 *=========================================================================*/
void CSrQustRecord::InitializeNew (void) 
{

	/* Call the base class method first */
	CSrIdRecord::InitializeNew();


}
/*===========================================================================
 *		End of Class Method CSrQustRecord::InitializeNew()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CSrQustRecord Event - void OnAddSubrecord (pSubrecord);
 *
 *=========================================================================*/
void CSrQustRecord::OnAddSubrecord (CSrSubrecord* pSubrecord) {

	if (pSubrecord->GetRecordType() == SR_NAME_FNAM)
	{
		m_pFnamData = SrCastClass(CSrDataSubrecord, pSubrecord);
	}
	else if (pSubrecord->GetRecordType() == SR_NAME_ALNT)
	{
		m_pAlntData = SrCastClass(CSrDataSubrecord, pSubrecord);
	}
	else if (pSubrecord->GetRecordType() == SR_NAME_INDX)
	{
		m_pIndxData = SrCastClass(CSrDataSubrecord, pSubrecord);
	}
	else if (pSubrecord->GetRecordType() == SR_NAME_NEXT)
	{
		m_pNextData = SrCastClass(CSrDataSubrecord, pSubrecord);
	}
	else if (pSubrecord->GetRecordType() == SR_NAME_FLTR)
	{
		m_pFltrData = SrCastClass(CSrDataSubrecord, pSubrecord);
	}
	else if (pSubrecord->GetRecordType() == SR_NAME_SPOR)
	{
		m_pSporData = SrCastClass(CSrDataSubrecord, pSubrecord);
	}
	else if (pSubrecord->GetRecordType() == SR_NAME_VMAD)
	{
		m_pVmadData = SrCastClass(CSrDataSubrecord, pSubrecord);
	}
	else if (pSubrecord->GetRecordType() == SR_NAME_KNAM)
	{
		m_pKnamData = SrCastClass(CSrDataSubrecord, pSubrecord);
	}
	else if (pSubrecord->GetRecordType() == SR_NAME_FULL)
	{
		m_pFullData = SrCastClass(CSrDataSubrecord, pSubrecord);
	}
	else if (pSubrecord->GetRecordType() == SR_NAME_DNAM)
	{
		m_pDnamData = SrCastClass(CSrDataSubrecord, pSubrecord);
	}
	else if (pSubrecord->GetRecordType() == SR_NAME_ALFL)
	{
		m_pAlflData = SrCastClass(CSrDataSubrecord, pSubrecord);
	}
	else if (pSubrecord->GetRecordType() == SR_NAME_ANAM)
	{
		m_pAnamData = SrCastClass(CSrDataSubrecord, pSubrecord);
	}
	else if (pSubrecord->GetRecordType() == SR_NAME_CTDA)
	{
		m_pCtdaData = SrCastClass(CSrDataSubrecord, pSubrecord);
	}
	else if (pSubrecord->GetRecordType() == SR_NAME_ENAM)
	{
		m_pEnamData = SrCastClass(CSrDataSubrecord, pSubrecord);
	}
	else if (pSubrecord->GetRecordType() == SR_NAME_QSDT)
	{
		m_pQsdtData = SrCastClass(CSrDataSubrecord, pSubrecord);
	}
	else if (pSubrecord->GetRecordType() == SR_NAME_ALST)
	{
		m_pAlstData = SrCastClass(CSrDataSubrecord, pSubrecord);
	}
	else if (pSubrecord->GetRecordType() == SR_NAME_COCT)
	{
		m_pCoctData = SrCastClass(CSrDataSubrecord, pSubrecord);
	}
	else if (pSubrecord->GetRecordType() == SR_NAME_QOBJ)
	{
		m_pQobjData = SrCastClass(CSrDataSubrecord, pSubrecord);
	}
	else if (pSubrecord->GetRecordType() == SR_NAME_ALPC)
	{
		m_pAlpcData = SrCastClass(CSrDataSubrecord, pSubrecord);
	}
	else if (pSubrecord->GetRecordType() == SR_NAME_ALID)
	{
		m_pAlidData = SrCastClass(CSrDataSubrecord, pSubrecord);
	}
	else if (pSubrecord->GetRecordType() == SR_NAME_ALFE)
	{
		m_pAlfeData = SrCastClass(CSrDataSubrecord, pSubrecord);
	}
	else if (pSubrecord->GetRecordType() == SR_NAME_ALED)
	{
		m_pAledData = SrCastClass(CSrDataSubrecord, pSubrecord);
	}
	else if (pSubrecord->GetRecordType() == SR_NAME_ALFD)
	{
		m_pAlfdData = SrCastClass(CSrDataSubrecord, pSubrecord);
	}
	else if (pSubrecord->GetRecordType() == SR_NAME_VTCK)
	{
		m_pVtckData = SrCastClass(CSrDataSubrecord, pSubrecord);
	}
	else if (pSubrecord->GetRecordType() == SR_NAME_ALCA)
	{
		m_pAlcaData = SrCastClass(CSrDataSubrecord, pSubrecord);
	}
	else if (pSubrecord->GetRecordType() == SR_NAME_ALLS)
	{
		m_pAllsData = SrCastClass(CSrDataSubrecord, pSubrecord);
	}
	else if (pSubrecord->GetRecordType() == SR_NAME_ALUA)
	{
		m_pAluaData = SrCastClass(CSrDataSubrecord, pSubrecord);
	}
	else if (pSubrecord->GetRecordType() == SR_NAME_ALSP)
	{
		m_pAlspData = SrCastClass(CSrDataSubrecord, pSubrecord);
	}
	else if (pSubrecord->GetRecordType() == SR_NAME_ALFR)
	{
		m_pAlfrData = SrCastClass(CSrDataSubrecord, pSubrecord);
	}
	else if (pSubrecord->GetRecordType() == SR_NAME_ALCO)
	{
		m_pAlcoData = SrCastClass(CSrDataSubrecord, pSubrecord);
	}
	else if (pSubrecord->GetRecordType() == SR_NAME_CIS2)
	{
		m_pCis2Data = SrCastClass(CSrDataSubrecord, pSubrecord);
	}
	else if (pSubrecord->GetRecordType() == SR_NAME_ALCL)
	{
		m_pAlclData = SrCastClass(CSrDataSubrecord, pSubrecord);
	}
	else if (pSubrecord->GetRecordType() == SR_NAME_NNAM)
	{
		m_pNnamData = SrCastClass(CSrDataSubrecord, pSubrecord);
	}
	else if (pSubrecord->GetRecordType() == SR_NAME_SCHR)
	{
		m_pSchrData = SrCastClass(CSrDataSubrecord, pSubrecord);
	}
	else if (pSubrecord->GetRecordType() == SR_NAME_QSTA)
	{
		m_pQstaData = SrCastClass(CSrDataSubrecord, pSubrecord);
	}
	else if (pSubrecord->GetRecordType() == SR_NAME_ALEA)
	{
		m_pAleaData = SrCastClass(CSrDataSubrecord, pSubrecord);
	}
	else if (pSubrecord->GetRecordType() == SR_NAME_ALFA)
	{
		m_pAlfaData = SrCastClass(CSrDataSubrecord, pSubrecord);
	}
	else if (pSubrecord->GetRecordType() == SR_NAME_KWDA)
	{
		m_pKwdaData = SrCastClass(CSrDataSubrecord, pSubrecord);
	}
	else if (pSubrecord->GetRecordType() == SR_NAME_ALRT)
	{
		m_pAlrtData = SrCastClass(CSrDataSubrecord, pSubrecord);
	}
	else if (pSubrecord->GetRecordType() == SR_NAME_KSIZ)
	{
		m_pKsizData = SrCastClass(CSrDataSubrecord, pSubrecord);
	}
	else if (pSubrecord->GetRecordType() == SR_NAME_ALFI)
	{
		m_pAlfiData = SrCastClass(CSrDataSubrecord, pSubrecord);
	}
	else if (pSubrecord->GetRecordType() == SR_NAME_NAM0)
	{
		m_pNam0Data = SrCastClass(CSrDataSubrecord, pSubrecord);
	}
	else if (pSubrecord->GetRecordType() == SR_NAME_ALFC)
	{
		m_pAlfcData = SrCastClass(CSrDataSubrecord, pSubrecord);
	}
	else if (pSubrecord->GetRecordType() == SR_NAME_CNTO)
	{
		m_pCntoData = SrCastClass(CSrDataSubrecord, pSubrecord);
	}
	else if (pSubrecord->GetRecordType() == SR_NAME_ALNA)
	{
		m_pAlnaData = SrCastClass(CSrDataSubrecord, pSubrecord);
	}
	else if (pSubrecord->GetRecordType() == SR_NAME_QNAM)
	{
		m_pQnamData = SrCastClass(CSrDataSubrecord, pSubrecord);
	}
	else if (pSubrecord->GetRecordType() == SR_NAME_QTGL)
	{
		m_pQtglData = SrCastClass(CSrDataSubrecord, pSubrecord);
	}
	else if (pSubrecord->GetRecordType() == SR_NAME_ECOR)
	{
		m_pEcorData = SrCastClass(CSrDataSubrecord, pSubrecord);
	}
	else if (pSubrecord->GetRecordType() == SR_NAME_ALEQ)
	{
		m_pAleqData = SrCastClass(CSrDataSubrecord, pSubrecord);
	}
	else if (pSubrecord->GetRecordType() == SR_NAME_ALDN)
	{
		m_pAldnData = SrCastClass(CSrDataSubrecord, pSubrecord);
	}
	else if (pSubrecord->GetRecordType() == SR_NAME_CNAM)
	{
		m_pCnamData = SrCastClass(CSrDataSubrecord, pSubrecord);
	}
	else if (pSubrecord->GetRecordType() == SR_NAME_SCTX)
	{
		m_pSctxData = SrCastClass(CSrDataSubrecord, pSubrecord);
	}

	else
	{
	CSrIdRecord::OnAddSubrecord(pSubrecord);
	}

}
/*===========================================================================
 *		End of Class Event CSrQustRecord::OnAddSubRecord()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CSrQustRecord Event - void OnDeleteSubrecord (pSubrecord);
 *
 *=========================================================================*/
void CSrQustRecord::OnDeleteSubrecord (CSrSubrecord* pSubrecord) {

	if (m_pFnamData == pSubrecord)
		m_pFnamData = NULL;

	else if (m_pAlntData == pSubrecord)
		m_pAlntData = NULL;
	else if (m_pIndxData == pSubrecord)
		m_pIndxData = NULL;
	else if (m_pNextData == pSubrecord)
		m_pNextData = NULL;
	else if (m_pFltrData == pSubrecord)
		m_pFltrData = NULL;
	else if (m_pSporData == pSubrecord)
		m_pSporData = NULL;
	else if (m_pVmadData == pSubrecord)
		m_pVmadData = NULL;
	else if (m_pKnamData == pSubrecord)
		m_pKnamData = NULL;
	else if (m_pFullData == pSubrecord)
		m_pFullData = NULL;
	else if (m_pDnamData == pSubrecord)
		m_pDnamData = NULL;
	else if (m_pAlflData == pSubrecord)
		m_pAlflData = NULL;
	else if (m_pAnamData == pSubrecord)
		m_pAnamData = NULL;
	else if (m_pCtdaData == pSubrecord)
		m_pCtdaData = NULL;
	else if (m_pEnamData == pSubrecord)
		m_pEnamData = NULL;
	else if (m_pQsdtData == pSubrecord)
		m_pQsdtData = NULL;
	else if (m_pAlstData == pSubrecord)
		m_pAlstData = NULL;
	else if (m_pCoctData == pSubrecord)
		m_pCoctData = NULL;
	else if (m_pQobjData == pSubrecord)
		m_pQobjData = NULL;
	else if (m_pAlpcData == pSubrecord)
		m_pAlpcData = NULL;
	else if (m_pAlidData == pSubrecord)
		m_pAlidData = NULL;
	else if (m_pAlfeData == pSubrecord)
		m_pAlfeData = NULL;
	else if (m_pAledData == pSubrecord)
		m_pAledData = NULL;
	else if (m_pAlfdData == pSubrecord)
		m_pAlfdData = NULL;
	else if (m_pVtckData == pSubrecord)
		m_pVtckData = NULL;
	else if (m_pAlcaData == pSubrecord)
		m_pAlcaData = NULL;
	else if (m_pAllsData == pSubrecord)
		m_pAllsData = NULL;
	else if (m_pAluaData == pSubrecord)
		m_pAluaData = NULL;
	else if (m_pAlspData == pSubrecord)
		m_pAlspData = NULL;
	else if (m_pAlfrData == pSubrecord)
		m_pAlfrData = NULL;
	else if (m_pAlcoData == pSubrecord)
		m_pAlcoData = NULL;
	else if (m_pCis2Data == pSubrecord)
		m_pCis2Data = NULL;
	else if (m_pAlclData == pSubrecord)
		m_pAlclData = NULL;
	else if (m_pNnamData == pSubrecord)
		m_pNnamData = NULL;
	else if (m_pSchrData == pSubrecord)
		m_pSchrData = NULL;
	else if (m_pQstaData == pSubrecord)
		m_pQstaData = NULL;
	else if (m_pAleaData == pSubrecord)
		m_pAleaData = NULL;
	else if (m_pAlfaData == pSubrecord)
		m_pAlfaData = NULL;
	else if (m_pKwdaData == pSubrecord)
		m_pKwdaData = NULL;
	else if (m_pAlrtData == pSubrecord)
		m_pAlrtData = NULL;
	else if (m_pKsizData == pSubrecord)
		m_pKsizData = NULL;
	else if (m_pAlfiData == pSubrecord)
		m_pAlfiData = NULL;
	else if (m_pNam0Data == pSubrecord)
		m_pNam0Data = NULL;
	else if (m_pAlfcData == pSubrecord)
		m_pAlfcData = NULL;
	else if (m_pCntoData == pSubrecord)
		m_pCntoData = NULL;
	else if (m_pAlnaData == pSubrecord)
		m_pAlnaData = NULL;
	else if (m_pQnamData == pSubrecord)
		m_pQnamData = NULL;
	else if (m_pQtglData == pSubrecord)
		m_pQtglData = NULL;
	else if (m_pEcorData == pSubrecord)
		m_pEcorData = NULL;
	else if (m_pAleqData == pSubrecord)
		m_pAleqData = NULL;
	else if (m_pAldnData == pSubrecord)
		m_pAldnData = NULL;
	else if (m_pCnamData == pSubrecord)
		m_pCnamData = NULL;
	else if (m_pSctxData == pSubrecord)
		m_pSctxData = NULL;

	else
		CSrIdRecord::OnDeleteSubrecord(pSubrecord);

}
/*===========================================================================
 *		End of Class Event CSrQustRecord::OnDeleteSubrecord()
 *=========================================================================*/


/*===========================================================================
 *
 * Begin CSrQustRecord Get Field Methods
 *
 *=========================================================================*/
/*===========================================================================
 *		End of CSrQustRecord Get Field Methods
 *=========================================================================*/


/*===========================================================================
 *
 * Begin CSrQustRecord Compare Field Methods
 *
 *=========================================================================*/
/*===========================================================================
 *		End of CSrQustRecord Compare Field Methods
 *=========================================================================*/


/*===========================================================================
 *
 * Begin CSrQustRecord Set Field Methods
 *
 *=========================================================================*/
/*===========================================================================
 *		End of CSrQustRecord Set Field Methods
 *=========================================================================*/

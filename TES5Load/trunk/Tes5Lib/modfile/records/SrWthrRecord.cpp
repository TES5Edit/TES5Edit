/*===========================================================================
 *
 * File:		SrWthrRecord.CPP
 * Author:		Dave Humphrey (dave@uesp.net)
 * Created On:	5 December 2011
 *
 * Description
 *
 *=========================================================================*/

	/* Include Files */
#include "srWthrrecord.h"


/*===========================================================================
 *
 * Begin Subrecord Creation Array
 *
 *=========================================================================*/
BEGIN_SRSUBRECCREATE(CSrWthrRecord, CSrIdRecord)
	//Deleted
	DEFINE_SRSUBRECCREATE(SR_NAME_FNAM, CSrDataSubrecord::Create)
	DEFINE_SRSUBRECCREATE(SR_NAME_RNAM, CSrDataSubrecord::Create)
	DEFINE_SRSUBRECCREATE(SR_NAME_00TX, CSrDataSubrecord::Create)
	DEFINE_SRSUBRECCREATE(SR_NAME_SNAM, CSrDataSubrecord::Create)
	DEFINE_SRSUBRECCREATE(SR_NAME_10TX, CSrDataSubrecord::Create)
	DEFINE_SRSUBRECCREATE(SR_NAME_TNAM, CSrDataSubrecord::Create)
	DEFINE_SRSUBRECCREATE(SR_NAME_NAM1, CSrDataSubrecord::Create)
	DEFINE_SRSUBRECCREATE(SR_NAME_20TX, CSrDataSubrecord::Create)
	DEFINE_SRSUBRECCREATE(SR_NAME_IMSP, CSrDataSubrecord::Create)
	DEFINE_SRSUBRECCREATE(SR_NAME_30TX, CSrDataSubrecord::Create)
	//Deleted
	//Deleted
	//Deleted
	DEFINE_SRSUBRECCREATE(SR_NAME_C0TX, CSrDataSubrecord::Create)
	DEFINE_SRSUBRECCREATE(SR_NAME_D0TX, CSrDataSubrecord::Create)
	DEFINE_SRSUBRECCREATE(SR_NAME_L0TX, CSrDataSubrecord::Create)
	DEFINE_SRSUBRECCREATE(SR_NAME_MODT, CSrDataSubrecord::Create)
	DEFINE_SRSUBRECCREATE(SR_NAME_LNAM, CSrDataSubrecord::Create)
	DEFINE_SRSUBRECCREATE(SR_NAME_MNAM, CSrDataSubrecord::Create)
	DEFINE_SRSUBRECCREATE(SR_NAME_NNAM, CSrDataSubrecord::Create)
	DEFINE_SRSUBRECCREATE(SR_NAME_QNAM, CSrDataSubrecord::Create)
	DEFINE_SRSUBRECCREATE(SR_NAME_PNAM, CSrDataSubrecord::Create)
	DEFINE_SRSUBRECCREATE(SR_NAME_JNAM, CSrDataSubrecord::Create)
	DEFINE_SRSUBRECCREATE(SR_NAME_ONAM, CSrDataSubrecord::Create)
	DEFINE_SRSUBRECCREATE(SR_NAME_NAM0, CSrDataSubrecord::Create)
	DEFINE_SRSUBRECCREATE(SR_NAME_G0TX, CSrDataSubrecord::Create)
	DEFINE_SRSUBRECCREATE(SR_NAME_DATA, CSrDataSubrecord::Create)
	DEFINE_SRSUBRECCREATE(SR_NAME_50TX, CSrDataSubrecord::Create)
	DEFINE_SRSUBRECCREATE(SR_NAME_DALC, CSrDataSubrecord::Create)
	DEFINE_SRSUBRECCREATE(SR_NAME_MODL, CSrDataSubrecord::Create)
	DEFINE_SRSUBRECCREATE(SR_NAME_80TX, CSrDataSubrecord::Create)
	DEFINE_SRSUBRECCREATE(SR_NAME_90TX, CSrDataSubrecord::Create)
	//Deleted
	//Deleted
	DEFINE_SRSUBRECCREATE(SR_NAME_A0TX, CSrDataSubrecord::Create)
	DEFINE_SRSUBRECCREATE(SR_NAME_H0TX, CSrDataSubrecord::Create)
	DEFINE_SRSUBRECCREATE(SR_NAME_K0TX, CSrDataSubrecord::Create)
	//Deleted
	DEFINE_SRSUBRECCREATE(SR_NAME_E0TX, CSrDataSubrecord::Create)
	DEFINE_SRSUBRECCREATE(SR_NAME_F0TX, CSrDataSubrecord::Create)
	DEFINE_SRSUBRECCREATE(SR_NAME_40TX, CSrDataSubrecord::Create)
	DEFINE_SRSUBRECCREATE(SR_NAME_60TX, CSrDataSubrecord::Create)
	DEFINE_SRSUBRECCREATE(SR_NAME_NAM2, CSrDataSubrecord::Create)
	DEFINE_SRSUBRECCREATE(SR_NAME_70TX, CSrDataSubrecord::Create)
	DEFINE_SRSUBRECCREATE(SR_NAME_B0TX, CSrDataSubrecord::Create)
	DEFINE_SRSUBRECCREATE(SR_NAME_I0TX, CSrDataSubrecord::Create)
	DEFINE_SRSUBRECCREATE(SR_NAME_J0TX, CSrDataSubrecord::Create)
	DEFINE_SRSUBRECCREATE(SR_NAME_NAM3, CSrDataSubrecord::Create)
	DEFINE_SRSUBRECCREATE(SR_NAME_DNAM, CSrDataSubrecord::Create)
	DEFINE_SRSUBRECCREATE(SR_NAME_CNAM, CSrDataSubrecord::Create)
	DEFINE_SRSUBRECCREATE(SR_NAME_ANAM, CSrDataSubrecord::Create)
	DEFINE_SRSUBRECCREATE(SR_NAME_BNAM, CSrDataSubrecord::Create)
END_SRSUBRECCREATE()
/*===========================================================================
 *		End of Subrecord Creation Array
 *=========================================================================*/


/*===========================================================================
 *
 * Begin CSrIdRecord Field Map
 *
 *=========================================================================*/
BEGIN_SRFIELDMAP(CSrWthrRecord, CSrIdRecord)
END_SRFIELDMAP()
/*===========================================================================
 *		End of CObRecord Field Map
 *=========================================================================*/


/*===========================================================================
 *
 * Class CSrWthrRecord Constructor
 *
 *=========================================================================*/
CSrWthrRecord::CSrWthrRecord () 
{
}
/*===========================================================================
 *		End of Class CSrWthrRecord Constructor
 *=========================================================================*/


/*===========================================================================
 *
 * Class CSrWthrRecord Method - void Destroy (void);
 *
 *=========================================================================*/
void CSrWthrRecord::Destroy (void) 
{
	CSrIdRecord::Destroy();
}
/*===========================================================================
 *		End of Class Method CSrWthrRecord::Destroy()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CSrWthrRecord Method - void InitializeNew (void);
 *
 *=========================================================================*/
void CSrWthrRecord::InitializeNew (void) 
{

	/* Call the base class method first */
	CSrIdRecord::InitializeNew();


}
/*===========================================================================
 *		End of Class Method CSrWthrRecord::InitializeNew()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CSrWthrRecord Event - void OnAddSubrecord (pSubrecord);
 *
 *=========================================================================*/
void CSrWthrRecord::OnAddSubrecord (CSrSubrecord* pSubrecord) {

	if (pSubrecord->GetRecordType() == SR_NAME_FNAM)
	{
		m_pFnamData = SrCastClass(CSrDataSubrecord, pSubrecord);
	}
	else if (pSubrecord->GetRecordType() == SR_NAME_RNAM)
	{
		m_pRnamData = SrCastClass(CSrDataSubrecord, pSubrecord);
	}
	else if (pSubrecord->GetRecordType() == SR_NAME_00TX)
	{
		m_p00txData = SrCastClass(CSrDataSubrecord, pSubrecord);
	}
	else if (pSubrecord->GetRecordType() == SR_NAME_SNAM)
	{
		m_pSnamData = SrCastClass(CSrDataSubrecord, pSubrecord);
	}
	else if (pSubrecord->GetRecordType() == SR_NAME_10TX)
	{
		m_p10txData = SrCastClass(CSrDataSubrecord, pSubrecord);
	}
	else if (pSubrecord->GetRecordType() == SR_NAME_TNAM)
	{
		m_pTnamData = SrCastClass(CSrDataSubrecord, pSubrecord);
	}
	else if (pSubrecord->GetRecordType() == SR_NAME_NAM1)
	{
		m_pNam1Data = SrCastClass(CSrDataSubrecord, pSubrecord);
	}
	else if (pSubrecord->GetRecordType() == SR_NAME_20TX)
	{
		m_p20txData = SrCastClass(CSrDataSubrecord, pSubrecord);
	}
	else if (pSubrecord->GetRecordType() == SR_NAME_IMSP)
	{
		m_pImspData = SrCastClass(CSrDataSubrecord, pSubrecord);
	}
	else if (pSubrecord->GetRecordType() == SR_NAME_30TX)
	{
		m_p30txData = SrCastClass(CSrDataSubrecord, pSubrecord);
	}
	else if (pSubrecord->GetRecordType() == SR_NAME_C0TX)
	{
		m_pC0txData = SrCastClass(CSrDataSubrecord, pSubrecord);
	}
	else if (pSubrecord->GetRecordType() == SR_NAME_D0TX)
	{
		m_pD0txData = SrCastClass(CSrDataSubrecord, pSubrecord);
	}
	else if (pSubrecord->GetRecordType() == SR_NAME_L0TX)
	{
		m_pL0txData = SrCastClass(CSrDataSubrecord, pSubrecord);
	}
	else if (pSubrecord->GetRecordType() == SR_NAME_MODT)
	{
		m_pModtData = SrCastClass(CSrDataSubrecord, pSubrecord);
	}
	else if (pSubrecord->GetRecordType() == SR_NAME_LNAM)
	{
		m_pLnamData = SrCastClass(CSrDataSubrecord, pSubrecord);
	}
	else if (pSubrecord->GetRecordType() == SR_NAME_MNAM)
	{
		m_pMnamData = SrCastClass(CSrDataSubrecord, pSubrecord);
	}
	else if (pSubrecord->GetRecordType() == SR_NAME_NNAM)
	{
		m_pNnamData = SrCastClass(CSrDataSubrecord, pSubrecord);
	}
	else if (pSubrecord->GetRecordType() == SR_NAME_QNAM)
	{
		m_pQnamData = SrCastClass(CSrDataSubrecord, pSubrecord);
	}
	else if (pSubrecord->GetRecordType() == SR_NAME_PNAM)
	{
		m_pPnamData = SrCastClass(CSrDataSubrecord, pSubrecord);
	}
	else if (pSubrecord->GetRecordType() == SR_NAME_JNAM)
	{
		m_pJnamData = SrCastClass(CSrDataSubrecord, pSubrecord);
	}
	else if (pSubrecord->GetRecordType() == SR_NAME_ONAM)
	{
		m_pOnamData = SrCastClass(CSrDataSubrecord, pSubrecord);
	}
	else if (pSubrecord->GetRecordType() == SR_NAME_NAM0)
	{
		m_pNam0Data = SrCastClass(CSrDataSubrecord, pSubrecord);
	}
	else if (pSubrecord->GetRecordType() == SR_NAME_G0TX)
	{
		m_pG0txData = SrCastClass(CSrDataSubrecord, pSubrecord);
	}
	else if (pSubrecord->GetRecordType() == SR_NAME_DATA)
	{
		m_pDataData = SrCastClass(CSrDataSubrecord, pSubrecord);
	}
	else if (pSubrecord->GetRecordType() == SR_NAME_50TX)
	{
		m_p50txData = SrCastClass(CSrDataSubrecord, pSubrecord);
	}
	else if (pSubrecord->GetRecordType() == SR_NAME_DALC)
	{
		m_pDalcData = SrCastClass(CSrDataSubrecord, pSubrecord);
	}
	else if (pSubrecord->GetRecordType() == SR_NAME_MODL)
	{
		m_pModlData = SrCastClass(CSrDataSubrecord, pSubrecord);
	}
	else if (pSubrecord->GetRecordType() == SR_NAME_80TX)
	{
		m_p80txData = SrCastClass(CSrDataSubrecord, pSubrecord);
	}
	else if (pSubrecord->GetRecordType() == SR_NAME_90TX)
	{
		m_p90txData = SrCastClass(CSrDataSubrecord, pSubrecord);
	}
	else if (pSubrecord->GetRecordType() == SR_NAME_A0TX)
	{
		m_pA0txData = SrCastClass(CSrDataSubrecord, pSubrecord);
	}
	else if (pSubrecord->GetRecordType() == SR_NAME_H0TX)
	{
		m_pH0txData = SrCastClass(CSrDataSubrecord, pSubrecord);
	}
	else if (pSubrecord->GetRecordType() == SR_NAME_K0TX)
	{
		m_pK0txData = SrCastClass(CSrDataSubrecord, pSubrecord);
	}
	else if (pSubrecord->GetRecordType() == SR_NAME_E0TX)
	{
		m_pE0txData = SrCastClass(CSrDataSubrecord, pSubrecord);
	}
	else if (pSubrecord->GetRecordType() == SR_NAME_F0TX)
	{
		m_pF0txData = SrCastClass(CSrDataSubrecord, pSubrecord);
	}
	else if (pSubrecord->GetRecordType() == SR_NAME_40TX)
	{
		m_p40txData = SrCastClass(CSrDataSubrecord, pSubrecord);
	}
	else if (pSubrecord->GetRecordType() == SR_NAME_60TX)
	{
		m_p60txData = SrCastClass(CSrDataSubrecord, pSubrecord);
	}
	else if (pSubrecord->GetRecordType() == SR_NAME_NAM2)
	{
		m_pNam2Data = SrCastClass(CSrDataSubrecord, pSubrecord);
	}
	else if (pSubrecord->GetRecordType() == SR_NAME_70TX)
	{
		m_p70txData = SrCastClass(CSrDataSubrecord, pSubrecord);
	}
	else if (pSubrecord->GetRecordType() == SR_NAME_B0TX)
	{
		m_pB0txData = SrCastClass(CSrDataSubrecord, pSubrecord);
	}
	else if (pSubrecord->GetRecordType() == SR_NAME_I0TX)
	{
		m_pI0txData = SrCastClass(CSrDataSubrecord, pSubrecord);
	}
	else if (pSubrecord->GetRecordType() == SR_NAME_J0TX)
	{
		m_pJ0txData = SrCastClass(CSrDataSubrecord, pSubrecord);
	}
	else if (pSubrecord->GetRecordType() == SR_NAME_NAM3)
	{
		m_pNam3Data = SrCastClass(CSrDataSubrecord, pSubrecord);
	}
	else if (pSubrecord->GetRecordType() == SR_NAME_DNAM)
	{
		m_pDnamData = SrCastClass(CSrDataSubrecord, pSubrecord);
	}
	else if (pSubrecord->GetRecordType() == SR_NAME_CNAM)
	{
		m_pCnamData = SrCastClass(CSrDataSubrecord, pSubrecord);
	}
	else if (pSubrecord->GetRecordType() == SR_NAME_ANAM)
	{
		m_pAnamData = SrCastClass(CSrDataSubrecord, pSubrecord);
	}
	else if (pSubrecord->GetRecordType() == SR_NAME_BNAM)
	{
		m_pBnamData = SrCastClass(CSrDataSubrecord, pSubrecord);
	}
	else
	{
	CSrIdRecord::OnAddSubrecord(pSubrecord);
	}

}
/*===========================================================================
 *		End of Class Event CSrWthrRecord::OnAddSubRecord()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CSrWthrRecord Event - void OnDeleteSubrecord (pSubrecord);
 *
 *=========================================================================*/
void CSrWthrRecord::OnDeleteSubrecord (CSrSubrecord* pSubrecord) {

	if (m_pFnamData == pSubrecord)
		m_pFnamData = NULL;
	else if (m_pRnamData == pSubrecord)
		m_pRnamData = NULL;
	else if (m_p00txData == pSubrecord)
		m_p00txData = NULL;
	else if (m_pSnamData == pSubrecord)
		m_pSnamData = NULL;
	else if (m_p10txData == pSubrecord)
		m_p10txData = NULL;
	else if (m_pTnamData == pSubrecord)
		m_pTnamData = NULL;
	else if (m_pNam1Data == pSubrecord)
		m_pNam1Data = NULL;
	else if (m_p20txData == pSubrecord)
		m_p20txData = NULL;
	else if (m_pImspData == pSubrecord)
		m_pImspData = NULL;
	else if (m_p30txData == pSubrecord)
		m_p30txData = NULL;
	else if (m_pC0txData == pSubrecord)
		m_pC0txData = NULL;
	else if (m_pD0txData == pSubrecord)
		m_pD0txData = NULL;
	else if (m_pL0txData == pSubrecord)
		m_pL0txData = NULL;
	else if (m_pModtData == pSubrecord)
		m_pModtData = NULL;
	else if (m_pLnamData == pSubrecord)
		m_pLnamData = NULL;
	else if (m_pMnamData == pSubrecord)
		m_pMnamData = NULL;
	else if (m_pNnamData == pSubrecord)
		m_pNnamData = NULL;
	else if (m_pQnamData == pSubrecord)
		m_pQnamData = NULL;
	else if (m_pPnamData == pSubrecord)
		m_pPnamData = NULL;
	else if (m_pJnamData == pSubrecord)
		m_pJnamData = NULL;
	else if (m_pOnamData == pSubrecord)
		m_pOnamData = NULL;
	else if (m_pNam0Data == pSubrecord)
		m_pNam0Data = NULL;
	else if (m_pG0txData == pSubrecord)
		m_pG0txData = NULL;
	else if (m_pDataData == pSubrecord)
		m_pDataData = NULL;
	else if (m_p50txData == pSubrecord)
		m_p50txData = NULL;
	else if (m_pDalcData == pSubrecord)
		m_pDalcData = NULL;
	else if (m_pModlData == pSubrecord)
		m_pModlData = NULL;
	else if (m_p80txData == pSubrecord)
		m_p80txData = NULL;
	else if (m_p90txData == pSubrecord)
		m_p90txData = NULL;
	else if (m_pA0txData == pSubrecord)
		m_pA0txData = NULL;
	else if (m_pH0txData == pSubrecord)
		m_pH0txData = NULL;
	else if (m_pK0txData == pSubrecord)
		m_pK0txData = NULL;
	else if (m_pE0txData == pSubrecord)
		m_pE0txData = NULL;
	else if (m_pF0txData == pSubrecord)
		m_pF0txData = NULL;
	else if (m_p40txData == pSubrecord)
		m_p40txData = NULL;
	else if (m_p60txData == pSubrecord)
		m_p60txData = NULL;
	else if (m_pNam2Data == pSubrecord)
		m_pNam2Data = NULL;
	else if (m_p70txData == pSubrecord)
		m_p70txData = NULL;
	else if (m_pB0txData == pSubrecord)
		m_pB0txData = NULL;
	else if (m_pI0txData == pSubrecord)
		m_pI0txData = NULL;
	else if (m_pJ0txData == pSubrecord)
		m_pJ0txData = NULL;
	else if (m_pNam3Data == pSubrecord)
		m_pNam3Data = NULL;
	else if (m_pDnamData == pSubrecord)
		m_pDnamData = NULL;
	else if (m_pCnamData == pSubrecord)
		m_pCnamData = NULL;
	else if (m_pAnamData == pSubrecord)
		m_pAnamData = NULL;
	else if (m_pBnamData == pSubrecord)
		m_pBnamData = NULL;
	else
		CSrIdRecord::OnDeleteSubrecord(pSubrecord);

}
/*===========================================================================
 *		End of Class Event CSrWthrRecord::OnDeleteSubrecord()
 *=========================================================================*/


/*===========================================================================
 *
 * Begin CSrWthrRecord Get Field Methods
 *
 *=========================================================================*/
/*===========================================================================
 *		End of CSrWthrRecord Get Field Methods
 *=========================================================================*/


/*===========================================================================
 *
 * Begin CSrWthrRecord Compare Field Methods
 *
 *=========================================================================*/
/*===========================================================================
 *		End of CSrWthrRecord Compare Field Methods
 *=========================================================================*/


/*===========================================================================
 *
 * Begin CSrWthrRecord Set Field Methods
 *
 *=========================================================================*/
/*===========================================================================
 *		End of CSrWthrRecord Set Field Methods
 *=========================================================================*/

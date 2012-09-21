/*===========================================================================
 *
 * File:		SrImadRecord.CPP
 * Author:		Dave Humphrey (dave@uesp.net)
 * Created On:	5 December 2011
 *
 * Description
 *
 *=========================================================================*/

	/* Include Files */
#include "srImadrecord.h"


/*===========================================================================
 *
 * Begin Subrecord Creation Array
 *
 *=========================================================================*/
BEGIN_SRSUBRECCREATE(CSrImadRecord, CSrIdRecord)
	DEFINE_SRSUBRECCREATE(SR_NAME_VNAM, CSrDataSubrecord::Create)
	DEFINE_SRSUBRECCREATE(SR_NAME_NAM1, CSrDataSubrecord::Create)
	DEFINE_SRSUBRECCREATE(SR_NAME_TNAM, CSrDataSubrecord::Create)
	DEFINE_SRSUBRECCREATE(SR_NAME_DNAM, CSrDataSubrecord::Create)
	DEFINE_SRSUBRECCREATE(SR_NAME_RNAM, CSrDataSubrecord::Create)
	DEFINE_SRSUBRECCREATE(SR_NAME_BNAM, CSrDataSubrecord::Create)
	DEFINE_SRSUBRECCREATE(SR_NAME_UNAM, CSrDataSubrecord::Create)
	DEFINE_SRSUBRECCREATE(SR_NAME_PIAD, CSrDataSubrecord::Create)
	DEFINE_SRSUBRECCREATE(SR_NAME_IAD, CSrDataSubrecord::Create)
	DEFINE_SRSUBRECCREATE(SR_NAME_NAM3, CSrDataSubrecord::Create)
	DEFINE_SRSUBRECCREATE(SR_NAME_SNAM, CSrDataSubrecord::Create)
	DEFINE_SRSUBRECCREATE(SR_NAME_YNAM, CSrDataSubrecord::Create)
	DEFINE_SRSUBRECCREATE(SR_NAME_NAM2, CSrDataSubrecord::Create)
	DEFINE_SRSUBRECCREATE(SR_NAME_WNAM, CSrDataSubrecord::Create)
	DEFINE_SRSUBRECCREATE(SR_NAME_XNAM, CSrDataSubrecord::Create)
	DEFINE_SRSUBRECCREATE(SR_NAME_NAM4, CSrDataSubrecord::Create)
	//Deleted
	//Deleted
	DEFINE_SRSUBRECCREATE(SR_NAME_AIAD, CSrDataSubrecord::Create)
	//Deleted
	DEFINE_SRSUBRECCREATE(SR_NAME_BIAD, CSrDataSubrecord::Create)
	//Deleted
	DEFINE_SRSUBRECCREATE(SR_NAME_CIAD, CSrDataSubrecord::Create)
	//Deleted
	DEFINE_SRSUBRECCREATE(SR_NAME_DIAD, CSrDataSubrecord::Create)
	//Deleted
	DEFINE_SRSUBRECCREATE(SR_NAME_EIAD, CSrDataSubrecord::Create)
	//Deleted
	DEFINE_SRSUBRECCREATE(SR_NAME_FIAD, CSrDataSubrecord::Create)
	//Deleted
	DEFINE_SRSUBRECCREATE(SR_NAME_GIAD, CSrDataSubrecord::Create)
	//Deleted
	DEFINE_SRSUBRECCREATE(SR_NAME_HIAD, CSrDataSubrecord::Create)
	//Deleted
	DEFINE_SRSUBRECCREATE(SR_NAME_IIAD, CSrDataSubrecord::Create)
	//Deleted
	DEFINE_SRSUBRECCREATE(SR_NAME_JIAD, CSrDataSubrecord::Create)
	//Deleted
	DEFINE_SRSUBRECCREATE(SR_NAME_KIAD, CSrDataSubrecord::Create)
	//Deleted
	DEFINE_SRSUBRECCREATE(SR_NAME_LIAD, CSrDataSubrecord::Create)
	//Deleted
	DEFINE_SRSUBRECCREATE(SR_NAME_MIAD, CSrDataSubrecord::Create)
	//Deleted
	DEFINE_SRSUBRECCREATE(SR_NAME_NIAD, CSrDataSubrecord::Create)
	//Deleted
	DEFINE_SRSUBRECCREATE(SR_NAME_OIAD, CSrDataSubrecord::Create)
	//Deleted
	DEFINE_SRSUBRECCREATE(SR_NAME_QIAD, CSrDataSubrecord::Create)
	//Deleted
	DEFINE_SRSUBRECCREATE(SR_NAME_RIAD, CSrDataSubrecord::Create)
	//Deleted
	DEFINE_SRSUBRECCREATE(SR_NAME_SIAD, CSrDataSubrecord::Create)
	//Deleted
	DEFINE_SRSUBRECCREATE(SR_NAME_TIAD, CSrDataSubrecord::Create)
	//Deleted
END_SRSUBRECCREATE()
/*===========================================================================
 *		End of Subrecord Creation Array
 *=========================================================================*/


/*===========================================================================
 *
 * Begin CSrIdRecord Field Map
 *
 *=========================================================================*/
BEGIN_SRFIELDMAP(CSrImadRecord, CSrIdRecord)
END_SRFIELDMAP()
/*===========================================================================
 *		End of CObRecord Field Map
 *=========================================================================*/


/*===========================================================================
 *
 * Class CSrImadRecord Constructor
 *
 *=========================================================================*/
CSrImadRecord::CSrImadRecord () 
{
}
/*===========================================================================
 *		End of Class CSrImadRecord Constructor
 *=========================================================================*/


/*===========================================================================
 *
 * Class CSrImadRecord Method - void Destroy (void);
 *
 *=========================================================================*/
void CSrImadRecord::Destroy (void) 
{
	CSrIdRecord::Destroy();
}
/*===========================================================================
 *		End of Class Method CSrImadRecord::Destroy()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CSrImadRecord Method - void InitializeNew (void);
 *
 *=========================================================================*/
void CSrImadRecord::InitializeNew (void) 
{
	CSrIdRecord::InitializeNew();
}
/*===========================================================================
 *		End of Class Method CSrImadRecord::InitializeNew()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CSrImadRecord Event - void OnAddSubrecord (pSubrecord);
 *
 *=========================================================================*/
void CSrImadRecord::OnAddSubrecord (CSrSubrecord* pSubrecord) {

	if (pSubrecord->GetRecordType() == SR_NAME_VNAM)
	{
		m_pVnamData = SrCastClass(CSrDataSubrecord, pSubrecord);
	}
	else if (pSubrecord->GetRecordType() == SR_NAME_NAM1)
	{
		m_pNam1Data = SrCastClass(CSrDataSubrecord, pSubrecord);
	}
	else if (pSubrecord->GetRecordType() == SR_NAME_TNAM)
	{
		m_pTnamData = SrCastClass(CSrDataSubrecord, pSubrecord);
	}
	else if (pSubrecord->GetRecordType() == SR_NAME_DNAM)
	{
		m_pDnamData = SrCastClass(CSrDataSubrecord, pSubrecord);
	}
	else if (pSubrecord->GetRecordType() == SR_NAME_RNAM)
	{
		m_pRnamData = SrCastClass(CSrDataSubrecord, pSubrecord);
	}
	else if (pSubrecord->GetRecordType() == SR_NAME_BNAM)
	{
		m_pBnamData = SrCastClass(CSrDataSubrecord, pSubrecord);
	}
	else if (pSubrecord->GetRecordType() == SR_NAME_UNAM)
	{
		m_pUnamData = SrCastClass(CSrDataSubrecord, pSubrecord);
	}
	else if (pSubrecord->GetRecordType() == SR_NAME_PIAD)
	{
		m_pPiadData = SrCastClass(CSrDataSubrecord, pSubrecord);
	}
	else if (pSubrecord->GetRecordType() == SR_NAME_NAM3)
	{
		m_pNam3Data = SrCastClass(CSrDataSubrecord, pSubrecord);
	}
	else if (pSubrecord->GetRecordType() == SR_NAME_SNAM)
	{
		m_pSnamData = SrCastClass(CSrDataSubrecord, pSubrecord);
	}
	else if (pSubrecord->GetRecordType() == SR_NAME_YNAM)
	{
		m_pYnamData = SrCastClass(CSrDataSubrecord, pSubrecord);
	}
	else if (pSubrecord->GetRecordType() == SR_NAME_NAM2)
	{
		m_pNam2Data = SrCastClass(CSrDataSubrecord, pSubrecord);
	}
	else if (pSubrecord->GetRecordType() == SR_NAME_WNAM)
	{
		m_pWnamData = SrCastClass(CSrDataSubrecord, pSubrecord);
	}
	else if (pSubrecord->GetRecordType() == SR_NAME_XNAM)
	{
		m_pXnamData = SrCastClass(CSrDataSubrecord, pSubrecord);
	}
	else if (pSubrecord->GetRecordType() == SR_NAME_NAM4)
	{
		m_pNam4Data = SrCastClass(CSrDataSubrecord, pSubrecord);
	}
	else if (pSubrecord->GetRecordType() == SR_NAME_AIAD)
	{
		m_pAiadData = SrCastClass(CSrDataSubrecord, pSubrecord);
	}
	else if (pSubrecord->GetRecordType() == SR_NAME_BIAD)
	{
		m_pBiadData = SrCastClass(CSrDataSubrecord, pSubrecord);
	}
	else if (pSubrecord->GetRecordType() == SR_NAME_CIAD)
	{
		m_pCiadData = SrCastClass(CSrDataSubrecord, pSubrecord);
	}
	else if (pSubrecord->GetRecordType() == SR_NAME_DIAD)
	{
		m_pDiadData = SrCastClass(CSrDataSubrecord, pSubrecord);
	}
	else if (pSubrecord->GetRecordType() == SR_NAME_EIAD)
	{
		m_pEiadData = SrCastClass(CSrDataSubrecord, pSubrecord);
	}
	else if (pSubrecord->GetRecordType() == SR_NAME_FIAD)
	{
		m_pFiadData = SrCastClass(CSrDataSubrecord, pSubrecord);
	}
	else if (pSubrecord->GetRecordType() == SR_NAME_GIAD)
	{
		m_pGiadData = SrCastClass(CSrDataSubrecord, pSubrecord);
	}
	else if (pSubrecord->GetRecordType() == SR_NAME_HIAD)
	{
		m_pHiadData = SrCastClass(CSrDataSubrecord, pSubrecord);
	}
	else if (pSubrecord->GetRecordType() == SR_NAME_IIAD)
	{
		m_pIiadData = SrCastClass(CSrDataSubrecord, pSubrecord);
	}
	else if (pSubrecord->GetRecordType() == SR_NAME_JIAD)
	{
		m_pJiadData = SrCastClass(CSrDataSubrecord, pSubrecord);
	}
	else if (pSubrecord->GetRecordType() == SR_NAME_KIAD)
	{
		m_pKiadData = SrCastClass(CSrDataSubrecord, pSubrecord);
	}
	else if (pSubrecord->GetRecordType() == SR_NAME_LIAD)
	{
		m_pLiadData = SrCastClass(CSrDataSubrecord, pSubrecord);
	}
	else if (pSubrecord->GetRecordType() == SR_NAME_MIAD)
	{
		m_pMiadData = SrCastClass(CSrDataSubrecord, pSubrecord);
	}
	else if (pSubrecord->GetRecordType() == SR_NAME_NIAD)
	{
		m_pNiadData = SrCastClass(CSrDataSubrecord, pSubrecord);
	}
	else if (pSubrecord->GetRecordType() == SR_NAME_OIAD)
	{
		m_pOiadData = SrCastClass(CSrDataSubrecord, pSubrecord);
	}
	else if (pSubrecord->GetRecordType() == SR_NAME_QIAD)
	{
		m_pQiadData = SrCastClass(CSrDataSubrecord, pSubrecord);
	}
	else if (pSubrecord->GetRecordType() == SR_NAME_RIAD)
	{
		m_pRiadData = SrCastClass(CSrDataSubrecord, pSubrecord);
	}
	else if (pSubrecord->GetRecordType() == SR_NAME_SIAD)
	{
		m_pSiadData = SrCastClass(CSrDataSubrecord, pSubrecord);
	}
	else if (pSubrecord->GetRecordType() == SR_NAME_TIAD)
	{
		m_pTiadData = SrCastClass(CSrDataSubrecord, pSubrecord);
	}
	else
	{
		CSrIdRecord::OnAddSubrecord(pSubrecord);
	}

}
/*===========================================================================
 *		End of Class Event CSrImadRecord::OnAddSubRecord()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CSrImadRecord Event - void OnDeleteSubrecord (pSubrecord);
 *
 *=========================================================================*/
void CSrImadRecord::OnDeleteSubrecord (CSrSubrecord* pSubrecord) {

	if (m_pVnamData == pSubrecord)
		m_pVnamData = NULL;
	else if (m_pNam1Data == pSubrecord)
		m_pNam1Data = NULL;
	else if (m_pTnamData == pSubrecord)
		m_pTnamData = NULL;
	else if (m_pDnamData == pSubrecord)
		m_pDnamData = NULL;
	else if (m_pRnamData == pSubrecord)
		m_pRnamData = NULL;
	else if (m_pBnamData == pSubrecord)
		m_pBnamData = NULL;
	else if (m_pUnamData == pSubrecord)
		m_pUnamData = NULL;
	else if (m_pPiadData == pSubrecord)
		m_pPiadData = NULL;
	else if (m_pNam3Data == pSubrecord)
		m_pNam3Data = NULL;
	else if (m_pSnamData == pSubrecord)
		m_pSnamData = NULL;
	else if (m_pYnamData == pSubrecord)
		m_pYnamData = NULL;
	else if (m_pNam2Data == pSubrecord)
		m_pNam2Data = NULL;
	else if (m_pWnamData == pSubrecord)
		m_pWnamData = NULL;
	else if (m_pXnamData == pSubrecord)
		m_pXnamData = NULL;
	else if (m_pNam4Data == pSubrecord)
		m_pNam4Data = NULL;
	else if (m_pAiadData == pSubrecord)
		m_pAiadData = NULL;
	else if (m_pBiadData == pSubrecord)
		m_pBiadData = NULL;
	else if (m_pCiadData == pSubrecord)
		m_pCiadData = NULL;
	else if (m_pDiadData == pSubrecord)
		m_pDiadData = NULL;
	else if (m_pEiadData == pSubrecord)
		m_pEiadData = NULL;
	else if (m_pFiadData == pSubrecord)
		m_pFiadData = NULL;
	else if (m_pGiadData == pSubrecord)
		m_pGiadData = NULL;
	else if (m_pHiadData == pSubrecord)
		m_pHiadData = NULL;
	else if (m_pIiadData == pSubrecord)
		m_pIiadData = NULL;
	else if (m_pJiadData == pSubrecord)
		m_pJiadData = NULL;
	else if (m_pKiadData == pSubrecord)
		m_pKiadData = NULL;
	else if (m_pLiadData == pSubrecord)
		m_pLiadData = NULL;
	else if (m_pMiadData == pSubrecord)
		m_pMiadData = NULL;
	else if (m_pNiadData == pSubrecord)
		m_pNiadData = NULL;
	else if (m_pOiadData == pSubrecord)
		m_pOiadData = NULL;
	else if (m_pQiadData == pSubrecord)
		m_pQiadData = NULL;
	else if (m_pRiadData == pSubrecord)
		m_pRiadData = NULL;
	else if (m_pSiadData == pSubrecord)
		m_pSiadData = NULL;
	else if (m_pTiadData == pSubrecord)
		m_pTiadData = NULL;
	else
		CSrIdRecord::OnDeleteSubrecord(pSubrecord);

}
/*===========================================================================
 *		End of Class Event CSrImadRecord::OnDeleteSubrecord()
 *=========================================================================*/


/*===========================================================================
 *
 * Begin CSrImadRecord Get Field Methods
 *
 *=========================================================================*/
/*===========================================================================
 *		End of CSrImadRecord Get Field Methods
 *=========================================================================*/


/*===========================================================================
 *
 * Begin CSrImadRecord Compare Field Methods
 *
 *=========================================================================*/
/*===========================================================================
 *		End of CSrImadRecord Compare Field Methods
 *=========================================================================*/


/*===========================================================================
 *
 * Begin CSrImadRecord Set Field Methods
 *
 *=========================================================================*/
/*===========================================================================
 *		End of CSrImadRecord Set Field Methods
 *=========================================================================*/

/*===========================================================================
 *
 * File:		SrWrldRecord.CPP
 * Author:		Dave Humphrey (dave@uesp.net)
 * Created On:	5 December 2011
 *
 * Description
 *
 *=========================================================================*/

	/* Include Files */
#include "srWrldrecord.h"


/*===========================================================================
 *
 * Begin Subrecord Creation Array
 *
 *=========================================================================*/
BEGIN_SRSUBRECCREATE(CSrWrldRecord, CSrIdRecord)
	DEFINE_SRSUBRECCREATE(SR_NAME_OFST, CSrDataSubrecord::Create)
	DEFINE_SRSUBRECCREATE(SR_NAME_NAM4, CSrDataSubrecord::Create)
	DEFINE_SRSUBRECCREATE(SR_NAME_RNAM, CSrDataSubrecord::Create)
	DEFINE_SRSUBRECCREATE(SR_NAME_CNAM, CSrDataSubrecord::Create)
	DEFINE_SRSUBRECCREATE(SR_NAME_XLCN, CSrDataSubrecord::Create)
	DEFINE_SRSUBRECCREATE(SR_NAME_FULL, CSrDataSubrecord::Create)
	DEFINE_SRSUBRECCREATE(SR_NAME_NAM2, CSrDataSubrecord::Create)
	DEFINE_SRSUBRECCREATE(SR_NAME_MNAM, CSrDataSubrecord::Create)
	DEFINE_SRSUBRECCREATE(SR_NAME_NAM3, CSrDataSubrecord::Create)
	DEFINE_SRSUBRECCREATE(SR_NAME_WCTR, CSrDataSubrecord::Create)
	DEFINE_SRSUBRECCREATE(SR_NAME_DNAM, CSrDataSubrecord::Create)
	DEFINE_SRSUBRECCREATE(SR_NAME_NAM0, CSrDataSubrecord::Create)
	DEFINE_SRSUBRECCREATE(SR_NAME_ONAM, CSrDataSubrecord::Create)
	DEFINE_SRSUBRECCREATE(SR_NAME_WNAM, CSrDataSubrecord::Create)
	DEFINE_SRSUBRECCREATE(SR_NAME_NAMA, CSrDataSubrecord::Create)
	DEFINE_SRSUBRECCREATE(SR_NAME_DATA, CSrDataSubrecord::Create)
	DEFINE_SRSUBRECCREATE(SR_NAME_NAM9, CSrDataSubrecord::Create)
	DEFINE_SRSUBRECCREATE(SR_NAME_ZNAM, CSrDataSubrecord::Create)
	DEFINE_SRSUBRECCREATE(SR_NAME_TNAM, CSrDataSubrecord::Create)
	DEFINE_SRSUBRECCREATE(SR_NAME_UNAM, CSrDataSubrecord::Create)
	DEFINE_SRSUBRECCREATE(SR_NAME_PNAM, CSrDataSubrecord::Create)
	DEFINE_SRSUBRECCREATE(SR_NAME_MHDT, CSrDataSubrecord::Create)
	DEFINE_SRSUBRECCREATE(SR_NAME_XXXX, CSrDataSubrecord::Create)
	DEFINE_SRSUBRECCREATE(SR_NAME_LTMP, CSrDataSubrecord::Create)
	DEFINE_SRSUBRECCREATE(SR_NAME_XEZN, CSrDataSubrecord::Create)

END_SRSUBRECCREATE()
/*===========================================================================
 *		End of Subrecord Creation Array
 *=========================================================================*/


/*===========================================================================
 *
 * Begin CSrIdRecord Field Map
 *
 *=========================================================================*/
BEGIN_SRFIELDMAP(CSrWrldRecord, CSrIdRecord)
END_SRFIELDMAP()
/*===========================================================================
 *		End of CObRecord Field Map
 *=========================================================================*/


/*===========================================================================
 *
 * Class CSrWrldRecord Constructor
 *
 *=========================================================================*/
CSrWrldRecord::CSrWrldRecord () 
{
}
/*===========================================================================
 *		End of Class CSrWrldRecord Constructor
 *=========================================================================*/


/*===========================================================================
 *
 * Class CSrWrldRecord Method - void Destroy (void);
 *
 *=========================================================================*/
void CSrWrldRecord::Destroy (void) 
{
	CSrIdRecord::Destroy();
}
/*===========================================================================
 *		End of Class Method CSrWrldRecord::Destroy()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CSrWrldRecord Method - void InitializeNew (void);
 *
 *=========================================================================*/
void CSrWrldRecord::InitializeNew (void) 
{

	/* Call the base class method first */
	CSrIdRecord::InitializeNew();


}
/*===========================================================================
 *		End of Class Method CSrWrldRecord::InitializeNew()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CSrWrldRecord Event - void OnAddSubrecord (pSubrecord);
 *
 *=========================================================================*/
void CSrWrldRecord::OnAddSubrecord (CSrSubrecord* pSubrecord) {

	if (pSubrecord->GetRecordType() == SR_NAME_OFST)
	{
		m_pOfstData = SrCastClass(CSrDataSubrecord, pSubrecord);
	}
	else if (pSubrecord->GetRecordType() == SR_NAME_NAM4)
	{
		m_pNam4Data = SrCastClass(CSrDataSubrecord, pSubrecord);
	}
	else if (pSubrecord->GetRecordType() == SR_NAME_RNAM)
	{
		m_pRnamData = SrCastClass(CSrDataSubrecord, pSubrecord);
	}
	else if (pSubrecord->GetRecordType() == SR_NAME_CNAM)
	{
		m_pCnamData = SrCastClass(CSrDataSubrecord, pSubrecord);
	}
	else if (pSubrecord->GetRecordType() == SR_NAME_XLCN)
	{
		m_pXlcnData = SrCastClass(CSrDataSubrecord, pSubrecord);
	}
	else if (pSubrecord->GetRecordType() == SR_NAME_FULL)
	{
		m_pFullData = SrCastClass(CSrDataSubrecord, pSubrecord);
	}
	else if (pSubrecord->GetRecordType() == SR_NAME_NAM2)
	{
		m_pNam2Data = SrCastClass(CSrDataSubrecord, pSubrecord);
	}
	else if (pSubrecord->GetRecordType() == SR_NAME_MNAM)
	{
		m_pMnamData = SrCastClass(CSrDataSubrecord, pSubrecord);
	}
	else if (pSubrecord->GetRecordType() == SR_NAME_NAM3)
	{
		m_pNam3Data = SrCastClass(CSrDataSubrecord, pSubrecord);
	}
	else if (pSubrecord->GetRecordType() == SR_NAME_WCTR)
	{
		m_pWctrData = SrCastClass(CSrDataSubrecord, pSubrecord);
	}
	else if (pSubrecord->GetRecordType() == SR_NAME_DNAM)
	{
		m_pDnamData = SrCastClass(CSrDataSubrecord, pSubrecord);
	}
	else if (pSubrecord->GetRecordType() == SR_NAME_NAM0)
	{
		m_pNam0Data = SrCastClass(CSrDataSubrecord, pSubrecord);
	}
	else if (pSubrecord->GetRecordType() == SR_NAME_ONAM)
	{
		m_pOnamData = SrCastClass(CSrDataSubrecord, pSubrecord);
	}
	else if (pSubrecord->GetRecordType() == SR_NAME_WNAM)
	{
		m_pWnamData = SrCastClass(CSrDataSubrecord, pSubrecord);
	}
	else if (pSubrecord->GetRecordType() == SR_NAME_NAMA)
	{
		m_pNamaData = SrCastClass(CSrDataSubrecord, pSubrecord);
	}
	else if (pSubrecord->GetRecordType() == SR_NAME_DATA)
	{
		m_pDataData = SrCastClass(CSrDataSubrecord, pSubrecord);
	}
	else if (pSubrecord->GetRecordType() == SR_NAME_NAM9)
	{
		m_pNam9Data = SrCastClass(CSrDataSubrecord, pSubrecord);
	}
	else if (pSubrecord->GetRecordType() == SR_NAME_ZNAM)
	{
		m_pZnamData = SrCastClass(CSrDataSubrecord, pSubrecord);
	}
	else if (pSubrecord->GetRecordType() == SR_NAME_TNAM)
	{
		m_pTnamData = SrCastClass(CSrDataSubrecord, pSubrecord);
	}
	else if (pSubrecord->GetRecordType() == SR_NAME_UNAM)
	{
		m_pUnamData = SrCastClass(CSrDataSubrecord, pSubrecord);
	}
	else if (pSubrecord->GetRecordType() == SR_NAME_PNAM)
	{
		m_pPnamData = SrCastClass(CSrDataSubrecord, pSubrecord);
	}
	else if (pSubrecord->GetRecordType() == SR_NAME_MHDT)
	{
		m_pMhdtData = SrCastClass(CSrDataSubrecord, pSubrecord);
	}
	else if (pSubrecord->GetRecordType() == SR_NAME_XXXX)
	{
		m_pXxxxData = SrCastClass(CSrDataSubrecord, pSubrecord);
	}
	else if (pSubrecord->GetRecordType() == SR_NAME_LTMP)
	{
		m_pLtmpData = SrCastClass(CSrDataSubrecord, pSubrecord);
	}
	else if (pSubrecord->GetRecordType() == SR_NAME_XEZN)
	{
		m_pXeznData = SrCastClass(CSrDataSubrecord, pSubrecord);
	}

	else
	{
	CSrIdRecord::OnAddSubrecord(pSubrecord);
	}

}
/*===========================================================================
 *		End of Class Event CSrWrldRecord::OnAddSubRecord()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CSrWrldRecord Event - void OnDeleteSubrecord (pSubrecord);
 *
 *=========================================================================*/
void CSrWrldRecord::OnDeleteSubrecord (CSrSubrecord* pSubrecord) {

	if (m_pOfstData == pSubrecord)
		m_pOfstData = NULL;
	else if (m_pNam4Data == pSubrecord)
		m_pNam4Data = NULL;
	else if (m_pRnamData == pSubrecord)
		m_pRnamData = NULL;
	else if (m_pCnamData == pSubrecord)
		m_pCnamData = NULL;
	else if (m_pXlcnData == pSubrecord)
		m_pXlcnData = NULL;
	else if (m_pFullData == pSubrecord)
		m_pFullData = NULL;
	else if (m_pNam2Data == pSubrecord)
		m_pNam2Data = NULL;
	else if (m_pMnamData == pSubrecord)
		m_pMnamData = NULL;
	else if (m_pNam3Data == pSubrecord)
		m_pNam3Data = NULL;
	else if (m_pWctrData == pSubrecord)
		m_pWctrData = NULL;
	else if (m_pDnamData == pSubrecord)
		m_pDnamData = NULL;
	else if (m_pNam0Data == pSubrecord)
		m_pNam0Data = NULL;
	else if (m_pOnamData == pSubrecord)
		m_pOnamData = NULL;
	else if (m_pWnamData == pSubrecord)
		m_pWnamData = NULL;
	else if (m_pNamaData == pSubrecord)
		m_pNamaData = NULL;
	else if (m_pDataData == pSubrecord)
		m_pDataData = NULL;
	else if (m_pNam9Data == pSubrecord)
		m_pNam9Data = NULL;
	else if (m_pZnamData == pSubrecord)
		m_pZnamData = NULL;
	else if (m_pTnamData == pSubrecord)
		m_pTnamData = NULL;
	else if (m_pUnamData == pSubrecord)
		m_pUnamData = NULL;
	else if (m_pPnamData == pSubrecord)
		m_pPnamData = NULL;
	else if (m_pMhdtData == pSubrecord)
		m_pMhdtData = NULL;
	else if (m_pXxxxData == pSubrecord)
		m_pXxxxData = NULL;
	else if (m_pLtmpData == pSubrecord)
		m_pLtmpData = NULL;
	else if (m_pXeznData == pSubrecord)
		m_pXeznData = NULL;

	else
		CSrIdRecord::OnDeleteSubrecord(pSubrecord);

}
/*===========================================================================
 *		End of Class Event CSrWrldRecord::OnDeleteSubrecord()
 *=========================================================================*/


/*===========================================================================
 *
 * Begin CSrWrldRecord Get Field Methods
 *
 *=========================================================================*/
/*===========================================================================
 *		End of CSrWrldRecord Get Field Methods
 *=========================================================================*/


/*===========================================================================
 *
 * Begin CSrWrldRecord Compare Field Methods
 *
 *=========================================================================*/
/*===========================================================================
 *		End of CSrWrldRecord Compare Field Methods
 *=========================================================================*/


/*===========================================================================
 *
 * Begin CSrWrldRecord Set Field Methods
 *
 *=========================================================================*/
/*===========================================================================
 *		End of CSrWrldRecord Set Field Methods
 *=========================================================================*/

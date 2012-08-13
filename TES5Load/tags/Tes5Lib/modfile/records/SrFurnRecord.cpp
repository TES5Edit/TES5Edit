/*===========================================================================
 *
 * File:		SrFurnRecord.CPP
 * Author:		Dave Humphrey (dave@uesp.net)
 * Created On:	5 December 2011
 *
 * Description
 *
 *=========================================================================*/

	/* Include Files */
#include "srFurnrecord.h"


/*===========================================================================
 *
 * Begin Subrecord Creation Array
 *
 *=========================================================================*/
BEGIN_SRSUBRECCREATE(CSrFurnRecord, CSrItem1Record)
	DEFINE_SRSUBRECCREATE(SR_NAME_FNMK, CSrDataSubrecord::Create)
	DEFINE_SRSUBRECCREATE(SR_NAME_FNAM, CSrDataSubrecord::Create)
	DEFINE_SRSUBRECCREATE(SR_NAME_KNAM, CSrDataSubrecord::Create)
	DEFINE_SRSUBRECCREATE(SR_NAME_MODT, CSrDataSubrecord::Create)
	DEFINE_SRSUBRECCREATE(SR_NAME_PNAM, CSrDataSubrecord::Create)
	DEFINE_SRSUBRECCREATE(SR_NAME_MNAM, CSrDataSubrecord::Create)
	DEFINE_SRSUBRECCREATE(SR_NAME_WBDT, CSrDataSubrecord::Create)
	DEFINE_SRSUBRECCREATE(SR_NAME_FNPR, CSrDataSubrecord::Create)
	DEFINE_SRSUBRECCREATE(SR_NAME_ENAM, CSrDataSubrecord::Create)
	DEFINE_SRSUBRECCREATE(SR_NAME_NAM0, CSrDataSubrecord::Create)
	DEFINE_SRSUBRECCREATE(SR_NAME_NAM1, CSrDataSubrecord::Create)
	DEFINE_SRSUBRECCREATE(SR_NAME_DEST, CSrDataSubrecord::Create)
	DEFINE_SRSUBRECCREATE(SR_NAME_VMAD, CSrVmadSubrecord::Create)
	DEFINE_SRSUBRECCREATE(SR_NAME_XMRK, CSrDataSubrecord::Create)
	DEFINE_SRSUBRECCREATE(SR_NAME_MODS, CSrDataSubrecord::Create)
	DEFINE_SRSUBRECCREATE(SR_NAME_DSTD, CSrDataSubrecord::Create)
	DEFINE_SRSUBRECCREATE(SR_NAME_DSTF, CSrDataSubrecord::Create)
END_SRSUBRECCREATE()
/*===========================================================================
 *		End of Subrecord Creation Array
 *=========================================================================*/


/*===========================================================================
 *
 * Begin CSrRecord Field Map
 *
 *=========================================================================*/
BEGIN_SRFIELDMAP(CSrFurnRecord, CSrItem1Record)
END_SRFIELDMAP()
/*===========================================================================
 *		End of CObRecord Field Map
 *=========================================================================*/


/*===========================================================================
 *
 * Class CSrFurnRecord Constructor
 *
 *=========================================================================*/
CSrFurnRecord::CSrFurnRecord () 
{
}
/*===========================================================================
 *		End of Class CSrFurnRecord Constructor
 *=========================================================================*/


/*===========================================================================
 *
 * Class CSrFurnRecord Method - void Destroy (void);
 *
 *=========================================================================*/
void CSrFurnRecord::Destroy (void) 
{
	CSrItem1Record::Destroy();
}
/*===========================================================================
 *		End of Class Method CSrFurnRecord::Destroy()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CSrFurnRecord Method - void InitializeNew (void);
 *
 *=========================================================================*/
void CSrFurnRecord::InitializeNew (void) 
{
	CSrItem1Record::InitializeNew();
}
/*===========================================================================
 *		End of Class Method CSrFurnRecord::InitializeNew()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CSrFurnRecord Event - void OnAddSubrecord (pSubrecord);
 *
 *=========================================================================*/
void CSrFurnRecord::OnAddSubrecord (CSrSubrecord* pSubrecord) {

	if (pSubrecord->GetRecordType() == SR_NAME_FNMK)
	{
		m_pFnmkData = SrCastClass(CSrDataSubrecord, pSubrecord);
	}
	else if (pSubrecord->GetRecordType() == SR_NAME_FNAM)
	{
		m_pFnamData = SrCastClass(CSrDataSubrecord, pSubrecord);
	}
	else if (pSubrecord->GetRecordType() == SR_NAME_KNAM)
	{
		m_pKnamData = SrCastClass(CSrDataSubrecord, pSubrecord);
	}
	else if (pSubrecord->GetRecordType() == SR_NAME_MODT)
	{
		m_pModtData = SrCastClass(CSrDataSubrecord, pSubrecord);
	}
	else if (pSubrecord->GetRecordType() == SR_NAME_PNAM)
	{
		m_pPnamData = SrCastClass(CSrDataSubrecord, pSubrecord);
	}
	else if (pSubrecord->GetRecordType() == SR_NAME_MNAM)
	{
		m_pMnamData = SrCastClass(CSrDataSubrecord, pSubrecord);
	}
	else if (pSubrecord->GetRecordType() == SR_NAME_WBDT)
	{
		m_pWbdtData = SrCastClass(CSrDataSubrecord, pSubrecord);
	}
	else if (pSubrecord->GetRecordType() == SR_NAME_FNPR)
	{
		m_pFnprData = SrCastClass(CSrDataSubrecord, pSubrecord);
	}
	else if (pSubrecord->GetRecordType() == SR_NAME_ENAM)
	{
		m_pEnamData = SrCastClass(CSrDataSubrecord, pSubrecord);
	}
	else if (pSubrecord->GetRecordType() == SR_NAME_NAM0)
	{
		m_pNam0Data = SrCastClass(CSrDataSubrecord, pSubrecord);
	}
	else if (pSubrecord->GetRecordType() == SR_NAME_DEST)
	{
		m_pDestData = SrCastClass(CSrDataSubrecord, pSubrecord);
	}
	else if (pSubrecord->GetRecordType() == SR_NAME_VMAD)
	{
		m_pVmadData = SrCastClass(CSrVmadSubrecord, pSubrecord);
	}
	else if (pSubrecord->GetRecordType() == SR_NAME_XMRK)
	{
		m_pXmrkData = SrCastClass(CSrDataSubrecord, pSubrecord);
	}
	else if (pSubrecord->GetRecordType() == SR_NAME_MODS)
	{
		m_pModsData = SrCastClass(CSrDataSubrecord, pSubrecord);
	}
	else if (pSubrecord->GetRecordType() == SR_NAME_DSTD)
	{
		m_pDstdData = SrCastClass(CSrDataSubrecord, pSubrecord);
	}
	else if (pSubrecord->GetRecordType() == SR_NAME_DSTF)
	{
		m_pDstfData = SrCastClass(CSrDataSubrecord, pSubrecord);
	}
	else
	{
		CSrItem1Record::OnAddSubrecord(pSubrecord);
	}

}
/*===========================================================================
 *		End of Class Event CSrFurnRecord::OnAddSubRecord()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CSrFurnRecord Event - void OnDeleteSubrecord (pSubrecord);
 *
 *=========================================================================*/
void CSrFurnRecord::OnDeleteSubrecord (CSrSubrecord* pSubrecord) {

	if (m_pFnmkData == pSubrecord)
		m_pFnmkData = NULL;
	else if (m_pFnamData == pSubrecord)
		m_pFnamData = NULL;
	else if (m_pKnamData == pSubrecord)
		m_pKnamData = NULL;
	else if (m_pModtData == pSubrecord)
		m_pModtData = NULL;
	else if (m_pPnamData == pSubrecord)
		m_pPnamData = NULL;
	else if (m_pMnamData == pSubrecord)
		m_pMnamData = NULL;
	else if (m_pWbdtData == pSubrecord)
		m_pWbdtData = NULL;
	else if (m_pFnprData == pSubrecord)
		m_pFnprData = NULL;
	else if (m_pEnamData == pSubrecord)
		m_pEnamData = NULL;
	else if (m_pNam0Data == pSubrecord)
		m_pNam0Data = NULL;
	else if (m_pDestData == pSubrecord)
		m_pDestData = NULL;
	else if (m_pVmadData == pSubrecord)
		m_pVmadData = NULL;
	else if (m_pXmrkData == pSubrecord)
		m_pXmrkData = NULL;
	else if (m_pModsData == pSubrecord)
		m_pModsData = NULL;
	else if (m_pDstdData == pSubrecord)
		m_pDstdData = NULL;
	else if (m_pDstfData == pSubrecord)
		m_pDstfData = NULL;
	else
		CSrItem1Record::OnDeleteSubrecord(pSubrecord);

}
/*===========================================================================
 *		End of Class Event CSrFurnRecord::OnDeleteSubrecord()
 *=========================================================================*/


/*===========================================================================
 *
 * Begin CSrFurnRecord Get Field Methods
 *
 *=========================================================================*/
/*===========================================================================
 *		End of CSrFurnRecord Get Field Methods
 *=========================================================================*/


/*===========================================================================
 *
 * Begin CSrFurnRecord Compare Field Methods
 *
 *=========================================================================*/
/*===========================================================================
 *		End of CSrFurnRecord Compare Field Methods
 *=========================================================================*/


/*===========================================================================
 *
 * Begin CSrFurnRecord Set Field Methods
 *
 *=========================================================================*/
/*===========================================================================
 *		End of CSrFurnRecord Set Field Methods
 *=========================================================================*/

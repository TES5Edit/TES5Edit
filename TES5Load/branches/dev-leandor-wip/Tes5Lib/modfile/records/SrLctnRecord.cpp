/*===========================================================================
 *
 * File:		SrLctnRecord.CPP
 * Author:		Dave Humphrey (dave@uesp.net)
 * Created On:	5 December 2011
 *
 * Description
 *
 *=========================================================================*/

	/* Include Files */
#include "srLctnrecord.h"


/*===========================================================================
 *
 * Begin Subrecord Creation Array
 *
 *=========================================================================*/
BEGIN_SRSUBRECCREATE(CSrLctnRecord, CSrItem1Record)
	DEFINE_SRSUBRECCREATE(SR_NAME_FNAM, CSrDataSubrecord::Create)
	DEFINE_SRSUBRECCREATE(SR_NAME_RNAM, CSrDataSubrecord::Create)
	DEFINE_SRSUBRECCREATE(SR_NAME_LCSR, CSrDataSubrecord::Create)
	DEFINE_SRSUBRECCREATE(SR_NAME_LCEC, CSrDataSubrecord::Create)
	DEFINE_SRSUBRECCREATE(SR_NAME_CNAM, CSrDataSubrecord::Create)
	DEFINE_SRSUBRECCREATE(SR_NAME_LCPR, CSrDataSubrecord::Create)
	DEFINE_SRSUBRECCREATE(SR_NAME_PNAM, CSrDataSubrecord::Create)
	DEFINE_SRSUBRECCREATE(SR_NAME_LCID, CSrDataSubrecord::Create)
	DEFINE_SRSUBRECCREATE(SR_NAME_MNAM, CSrDataSubrecord::Create)
	DEFINE_SRSUBRECCREATE(SR_NAME_NAM1, CSrDataSubrecord::Create)
	DEFINE_SRSUBRECCREATE(SR_NAME_LCEP, CSrDataSubrecord::Create)
	DEFINE_SRSUBRECCREATE(SR_NAME_LCUN, CSrDataSubrecord::Create)
	DEFINE_SRSUBRECCREATE(SR_NAME_NAM0, CSrDataSubrecord::Create)
END_SRSUBRECCREATE()
/*===========================================================================
 *		End of Subrecord Creation Array
 *=========================================================================*/


/*===========================================================================
 *
 * Begin CSrItem1Record Field Map
 *
 *=========================================================================*/
BEGIN_SRFIELDMAP(CSrLctnRecord, CSrItem1Record)
END_SRFIELDMAP()
/*===========================================================================
 *		End of CObRecord Field Map
 *=========================================================================*/


/*===========================================================================
 *
 * Class CSrLctnRecord Constructor
 *
 *=========================================================================*/
CSrLctnRecord::CSrLctnRecord () 
{
}
/*===========================================================================
 *		End of Class CSrLctnRecord Constructor
 *=========================================================================*/


/*===========================================================================
 *
 * Class CSrLctnRecord Method - void Destroy (void);
 *
 *=========================================================================*/
void CSrLctnRecord::Destroy (void) 
{
	CSrItem1Record::Destroy();
}
/*===========================================================================
 *		End of Class Method CSrLctnRecord::Destroy()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CSrLctnRecord Method - void InitializeNew (void);
 *
 *=========================================================================*/
void CSrLctnRecord::InitializeNew (void) 
{
	CSrItem1Record::InitializeNew();
}
/*===========================================================================
 *		End of Class Method CSrLctnRecord::InitializeNew()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CSrLctnRecord Event - void OnAddSubrecord (pSubrecord);
 *
 *=========================================================================*/
void CSrLctnRecord::OnAddSubrecord (CSrSubrecord* pSubrecord) {

	if (pSubrecord->GetRecordType() == SR_NAME_FNAM)
	{
		m_pFnamData = SrCastClass(CSrDataSubrecord, pSubrecord);
	}
	else if (pSubrecord->GetRecordType() == SR_NAME_RNAM)
	{
		m_pRnamData = SrCastClass(CSrDataSubrecord, pSubrecord);
	}
	else if (pSubrecord->GetRecordType() == SR_NAME_LCSR)
	{
		m_pLcsrData = SrCastClass(CSrDataSubrecord, pSubrecord);
	}
	else if (pSubrecord->GetRecordType() == SR_NAME_LCEC)
	{
		m_pLcecData = SrCastClass(CSrDataSubrecord, pSubrecord);
	}
	else if (pSubrecord->GetRecordType() == SR_NAME_CNAM)
	{
		m_pCnamData = SrCastClass(CSrDataSubrecord, pSubrecord);
	}
	else if (pSubrecord->GetRecordType() == SR_NAME_LCPR)
	{
		m_pLcprData = SrCastClass(CSrDataSubrecord, pSubrecord);
	}
	else if (pSubrecord->GetRecordType() == SR_NAME_PNAM)
	{
		m_pPnamData = SrCastClass(CSrDataSubrecord, pSubrecord);
	}
	else if (pSubrecord->GetRecordType() == SR_NAME_LCID)
	{
		m_pLcidData = SrCastClass(CSrDataSubrecord, pSubrecord);
	}
	else if (pSubrecord->GetRecordType() == SR_NAME_MNAM)
	{
		m_pMnamData = SrCastClass(CSrDataSubrecord, pSubrecord);
	}
	else if (pSubrecord->GetRecordType() == SR_NAME_NAM1)
	{
		m_pNam1Data = SrCastClass(CSrDataSubrecord, pSubrecord);
	}
	else if (pSubrecord->GetRecordType() == SR_NAME_LCEP)
	{
		m_pLcepData = SrCastClass(CSrDataSubrecord, pSubrecord);
	}
	else if (pSubrecord->GetRecordType() == SR_NAME_LCUN)
	{
		m_pLcunData = SrCastClass(CSrDataSubrecord, pSubrecord);
	}
	else if (pSubrecord->GetRecordType() == SR_NAME_NAM0)
	{
		m_pNam0Data = SrCastClass(CSrDataSubrecord, pSubrecord);
	}
	else
	{
		CSrItem1Record::OnAddSubrecord(pSubrecord);
	}

}
/*===========================================================================
 *		End of Class Event CSrLctnRecord::OnAddSubRecord()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CSrLctnRecord Event - void OnDeleteSubrecord (pSubrecord);
 *
 *=========================================================================*/
void CSrLctnRecord::OnDeleteSubrecord (CSrSubrecord* pSubrecord) {

	if (m_pFnamData == pSubrecord)
		m_pFnamData = NULL;
	else if (m_pRnamData == pSubrecord)
		m_pRnamData = NULL;
	else if (m_pLcsrData == pSubrecord)
		m_pLcsrData = NULL;
	else if (m_pLcecData == pSubrecord)
		m_pLcecData = NULL;
	else if (m_pCnamData == pSubrecord)
		m_pCnamData = NULL;
	else if (m_pLcprData == pSubrecord)
		m_pLcprData = NULL;
	else if (m_pPnamData == pSubrecord)
		m_pPnamData = NULL;
	else if (m_pLcidData == pSubrecord)
		m_pLcidData = NULL;
	else if (m_pMnamData == pSubrecord)
		m_pMnamData = NULL;
	else if (m_pNam1Data == pSubrecord)
		m_pNam1Data = NULL;
	else if (m_pLcepData == pSubrecord)
		m_pLcepData = NULL;
	else if (m_pLcunData == pSubrecord)
		m_pLcunData = NULL;
	else if (m_pNam0Data == pSubrecord)
		m_pNam0Data = NULL;
	else
		CSrItem1Record::OnDeleteSubrecord(pSubrecord);

}
/*===========================================================================
 *		End of Class Event CSrLctnRecord::OnDeleteSubrecord()
 *=========================================================================*/


/*===========================================================================
 *
 * Begin CSrLctnRecord Get Field Methods
 *
 *=========================================================================*/
/*===========================================================================
 *		End of CSrLctnRecord Get Field Methods
 *=========================================================================*/


/*===========================================================================
 *
 * Begin CSrLctnRecord Compare Field Methods
 *
 *=========================================================================*/
/*===========================================================================
 *		End of CSrLctnRecord Compare Field Methods
 *=========================================================================*/


/*===========================================================================
 *
 * Begin CSrLctnRecord Set Field Methods
 *
 *=========================================================================*/
/*===========================================================================
 *		End of CSrLctnRecord Set Field Methods
 *=========================================================================*/

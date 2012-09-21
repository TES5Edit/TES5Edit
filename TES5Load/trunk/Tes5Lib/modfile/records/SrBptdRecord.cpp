/*===========================================================================
 *
 * File:		SrBptdRecord.CPP
 * Author:		Dave Humphrey (dave@uesp.net)
 * Created On:	5 December 2011
 *
 * Description
 *
 *=========================================================================*/

	/* Include Files */
#include "srBptdrecord.h"


/*===========================================================================
 *
 * Begin Subrecord Creation Array
 *
 *=========================================================================*/
BEGIN_SRSUBRECCREATE(CSrBptdRecord, CSrIdRecord)
	DEFINE_SRSUBRECCREATE(SR_NAME_MODL, CSrDataSubrecord::Create)
	DEFINE_SRSUBRECCREATE(SR_NAME_NAM1, CSrDataSubrecord::Create)
	DEFINE_SRSUBRECCREATE(SR_NAME_BPNT, CSrDataSubrecord::Create)
	DEFINE_SRSUBRECCREATE(SR_NAME_BPTN, CSrDataSubrecord::Create)
	DEFINE_SRSUBRECCREATE(SR_NAME_MODT, CSrDataSubrecord::Create)
	DEFINE_SRSUBRECCREATE(SR_NAME_BPNI, CSrDataSubrecord::Create)
	DEFINE_SRSUBRECCREATE(SR_NAME_BPNN, CSrDataSubrecord::Create)
	DEFINE_SRSUBRECCREATE(SR_NAME_BPND, CSrDataSubrecord::Create)
	DEFINE_SRSUBRECCREATE(SR_NAME_NAM4, CSrDataSubrecord::Create)
	DEFINE_SRSUBRECCREATE(SR_NAME_NAM5, CSrDataSubrecord::Create)
END_SRSUBRECCREATE()
/*===========================================================================
 *		End of Subrecord Creation Array
 *=========================================================================*/


/*===========================================================================
 *
 * Begin CSrRecord Field Map
 *
 *=========================================================================*/
BEGIN_SRFIELDMAP(CSrBptdRecord, CSrIdRecord)
END_SRFIELDMAP()
/*===========================================================================
 *		End of CObRecord Field Map
 *=========================================================================*/


/*===========================================================================
 *
 * Class CSrBptdRecord Constructor
 *
 *=========================================================================*/
CSrBptdRecord::CSrBptdRecord () 
{
}
/*===========================================================================
 *		End of Class CSrBptdRecord Constructor
 *=========================================================================*/


/*===========================================================================
 *
 * Class CSrBptdRecord Method - void Destroy (void);
 *
 *=========================================================================*/
void CSrBptdRecord::Destroy (void) 
{
	CSrIdRecord::Destroy();
}
/*===========================================================================
 *		End of Class Method CSrBptdRecord::Destroy()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CSrBptdRecord Method - void InitializeNew (void);
 *
 *=========================================================================*/
void CSrBptdRecord::InitializeNew (void) 
{
	CSrIdRecord::InitializeNew();
}
/*===========================================================================
 *		End of Class Method CSrBptdRecord::InitializeNew()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CSrBptdRecord Event - void OnAddSubrecord (pSubrecord);
 *
 *=========================================================================*/
void CSrBptdRecord::OnAddSubrecord (CSrSubrecord* pSubrecord) {

	if (pSubrecord->GetRecordType() == SR_NAME_MODL)
	{
		m_pModlData = SrCastClass(CSrDataSubrecord, pSubrecord);
	}
	else if (pSubrecord->GetRecordType() == SR_NAME_NAM1)
	{
		m_pNam1Data = SrCastClass(CSrDataSubrecord, pSubrecord);
	}
	else if (pSubrecord->GetRecordType() == SR_NAME_BPNT)
	{
		m_pBpntData = SrCastClass(CSrDataSubrecord, pSubrecord);
	}
	else if (pSubrecord->GetRecordType() == SR_NAME_BPTN)
	{
		m_pBptnData = SrCastClass(CSrDataSubrecord, pSubrecord);
	}
	else if (pSubrecord->GetRecordType() == SR_NAME_MODT)
	{
		m_pModtData = SrCastClass(CSrDataSubrecord, pSubrecord);
	}
	else if (pSubrecord->GetRecordType() == SR_NAME_BPNI)
	{
		m_pBpniData = SrCastClass(CSrDataSubrecord, pSubrecord);
	}
	else if (pSubrecord->GetRecordType() == SR_NAME_BPNN)
	{
		m_pBpnnData = SrCastClass(CSrDataSubrecord, pSubrecord);
	}
	else if (pSubrecord->GetRecordType() == SR_NAME_BPND)
	{
		m_pBpndData = SrCastClass(CSrDataSubrecord, pSubrecord);
	}
	else if (pSubrecord->GetRecordType() == SR_NAME_NAM4)
	{
		m_pNam4Data = SrCastClass(CSrDataSubrecord, pSubrecord);
	}
	else if (pSubrecord->GetRecordType() == SR_NAME_NAM5)
	{
		m_pNam5Data = SrCastClass(CSrDataSubrecord, pSubrecord);
	}
	else
	{
		CSrIdRecord::OnAddSubrecord(pSubrecord);
	}

}
/*===========================================================================
 *		End of Class Event CSrBptdRecord::OnAddSubRecord()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CSrBptdRecord Event - void OnDeleteSubrecord (pSubrecord);
 *
 *=========================================================================*/
void CSrBptdRecord::OnDeleteSubrecord (CSrSubrecord* pSubrecord) {

	if (m_pModlData == pSubrecord)
		m_pModlData = NULL;
	else if (m_pNam1Data == pSubrecord)
		m_pNam1Data = NULL;
	else if (m_pBpntData == pSubrecord)
		m_pBpntData = NULL;
	else if (m_pBptnData == pSubrecord)
		m_pBptnData = NULL;
	else if (m_pModtData == pSubrecord)
		m_pModtData = NULL;
	else if (m_pBpniData == pSubrecord)
		m_pBpniData = NULL;
	else if (m_pBpnnData == pSubrecord)
		m_pBpnnData = NULL;
	else if (m_pBpndData == pSubrecord)
		m_pBpndData = NULL;
	else if (m_pNam4Data == pSubrecord)
		m_pNam4Data = NULL;
	else if (m_pNam5Data == pSubrecord)
		m_pNam5Data = NULL;
	else
		CSrIdRecord::OnDeleteSubrecord(pSubrecord);

}
/*===========================================================================
 *		End of Class Event CSrBptdRecord::OnDeleteSubrecord()
 *=========================================================================*/


/*===========================================================================
 *
 * Begin CSrBptdRecord Get Field Methods
 *
 *=========================================================================*/
/*===========================================================================
 *		End of CSrBptdRecord Get Field Methods
 *=========================================================================*/


/*===========================================================================
 *
 * Begin CSrBptdRecord Compare Field Methods
 *
 *=========================================================================*/
/*===========================================================================
 *		End of CSrBptdRecord Compare Field Methods
 *=========================================================================*/


/*===========================================================================
 *
 * Begin CSrBptdRecord Set Field Methods
 *
 *=========================================================================*/
/*===========================================================================
 *		End of CSrBptdRecord Set Field Methods
 *=========================================================================*/

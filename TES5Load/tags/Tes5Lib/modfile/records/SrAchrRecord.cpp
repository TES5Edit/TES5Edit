/*===========================================================================
 *
 * File:		SrAchrRecord.CPP
 * Author:		Dave Humphrey (dave@uesp.net)
 * Created On:	5 December 2011
 *
 * Description
 *
 *=========================================================================*/

	/* Include Files */
#include "srAchrrecord.h"


/*===========================================================================
 *
 * Begin Subrecord Creation Array
 *
 *=========================================================================*/
BEGIN_SRSUBRECCREATE(CSrAchrRecord, CSrIdRecord)
	DEFINE_SRSUBRECCREATE(SR_NAME_NAME, CSrDataSubrecord::Create)
	DEFINE_SRSUBRECCREATE(SR_NAME_XRGD, CSrDataSubrecord::Create)
	DEFINE_SRSUBRECCREATE(SR_NAME_XLKR, CSrDataSubrecord::Create)
	DEFINE_SRSUBRECCREATE(SR_NAME_XLCM, CSrDataSubrecord::Create)
	DEFINE_SRSUBRECCREATE(SR_NAME_VMAD, CSrDataSubrecord::Create)
	DEFINE_SRSUBRECCREATE(SR_NAME_XLCN, CSrDataSubrecord::Create)
	DEFINE_SRSUBRECCREATE(SR_NAME_DATA, CSrDataSubrecord::Create)
	DEFINE_SRSUBRECCREATE(SR_NAME_XPPA, CSrDataSubrecord::Create)
	DEFINE_SRSUBRECCREATE(SR_NAME_XLRT, CSrDataSubrecord::Create)
	DEFINE_SRSUBRECCREATE(SR_NAME_XESP, CSrDataSubrecord::Create)
	DEFINE_SRSUBRECCREATE(SR_NAME_XAPD, CSrDataSubrecord::Create)
	DEFINE_SRSUBRECCREATE(SR_NAME_PDTO, CSrDataSubrecord::Create)
	DEFINE_SRSUBRECCREATE(SR_NAME_XAPR, CSrDataSubrecord::Create)
	DEFINE_SRSUBRECCREATE(SR_NAME_XRGB, CSrDataSubrecord::Create)
	DEFINE_SRSUBRECCREATE(SR_NAME_XSCL, CSrDataSubrecord::Create)
	DEFINE_SRSUBRECCREATE(SR_NAME_XOWN, CSrDataSubrecord::Create)
	DEFINE_SRSUBRECCREATE(SR_NAME_XEZN, CSrDataSubrecord::Create)
	DEFINE_SRSUBRECCREATE(SR_NAME_XPRD, CSrDataSubrecord::Create)
	DEFINE_SRSUBRECCREATE(SR_NAME_INAM, CSrDataSubrecord::Create)
	DEFINE_SRSUBRECCREATE(SR_NAME_XHOR, CSrDataSubrecord::Create)
	DEFINE_SRSUBRECCREATE(SR_NAME_XIS2, CSrDataSubrecord::Create)
END_SRSUBRECCREATE()
/*===========================================================================
 *		End of Subrecord Creation Array
 *=========================================================================*/


/*===========================================================================
 *
 * Begin CSrRecord Field Map
 *
 *=========================================================================*/
BEGIN_SRFIELDMAP(CSrAchrRecord, CSrIdRecord)
END_SRFIELDMAP()
/*===========================================================================
 *		End of CObRecord Field Map
 *=========================================================================*/


/*===========================================================================
 *
 * Class CSrAchrRecord Constructor
 *
 *=========================================================================*/
CSrAchrRecord::CSrAchrRecord () 
{
}
/*===========================================================================
 *		End of Class CSrAchrRecord Constructor
 *=========================================================================*/


/*===========================================================================
 *
 * Class CSrAchrRecord Method - void Destroy (void);
 *
 *=========================================================================*/
void CSrAchrRecord::Destroy (void) 
{
	CSrIdRecord::Destroy();
}
/*===========================================================================
 *		End of Class Method CSrAchrRecord::Destroy()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CSrAchrRecord Method - void InitializeNew (void);
 *
 *=========================================================================*/
void CSrAchrRecord::InitializeNew (void) 
{
	CSrIdRecord::InitializeNew();
}
/*===========================================================================
 *		End of Class Method CSrAchrRecord::InitializeNew()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CSrAchrRecord Event - void OnAddSubrecord (pSubrecord);
 *
 *=========================================================================*/
void CSrAchrRecord::OnAddSubrecord (CSrSubrecord* pSubrecord) {

	if (pSubrecord->GetRecordType() == SR_NAME_NAME)
	{
		m_pNameData = SrCastClass(CSrDataSubrecord, pSubrecord);
	}
	else if (pSubrecord->GetRecordType() == SR_NAME_XRGD)
	{
		m_pXrgdData = SrCastClass(CSrDataSubrecord, pSubrecord);
	}
	else if (pSubrecord->GetRecordType() == SR_NAME_XLKR)
	{
		m_pXlkrData = SrCastClass(CSrDataSubrecord, pSubrecord);
	}
	else if (pSubrecord->GetRecordType() == SR_NAME_XLCM)
	{
		m_pXlcmData = SrCastClass(CSrDataSubrecord, pSubrecord);
	}
	else if (pSubrecord->GetRecordType() == SR_NAME_VMAD)
	{
		m_pVmadData = SrCastClass(CSrDataSubrecord, pSubrecord);
	}
	else if (pSubrecord->GetRecordType() == SR_NAME_XLCN)
	{
		m_pXlcnData = SrCastClass(CSrDataSubrecord, pSubrecord);
	}
	else if (pSubrecord->GetRecordType() == SR_NAME_DATA)
	{
		m_pDataData = SrCastClass(CSrDataSubrecord, pSubrecord);
	}
	else if (pSubrecord->GetRecordType() == SR_NAME_XPPA)
	{
		m_pXppaData = SrCastClass(CSrDataSubrecord, pSubrecord);
	}
	else if (pSubrecord->GetRecordType() == SR_NAME_XLRT)
	{
		m_pXlrtData = SrCastClass(CSrDataSubrecord, pSubrecord);
	}
	else if (pSubrecord->GetRecordType() == SR_NAME_XESP)
	{
		m_pXespData = SrCastClass(CSrDataSubrecord, pSubrecord);
	}
	else if (pSubrecord->GetRecordType() == SR_NAME_XAPD)
	{
		m_pXapdData = SrCastClass(CSrDataSubrecord, pSubrecord);
	}
	else if (pSubrecord->GetRecordType() == SR_NAME_PDTO)
	{
		m_pPdtoData = SrCastClass(CSrDataSubrecord, pSubrecord);
	}
	else if (pSubrecord->GetRecordType() == SR_NAME_XAPR)
	{
		m_pXaprData = SrCastClass(CSrDataSubrecord, pSubrecord);
	}
	else if (pSubrecord->GetRecordType() == SR_NAME_XRGB)
	{
		m_pXrgbData = SrCastClass(CSrDataSubrecord, pSubrecord);
	}
	else if (pSubrecord->GetRecordType() == SR_NAME_XSCL)
	{
		m_pXsclData = SrCastClass(CSrDataSubrecord, pSubrecord);
	}
	else if (pSubrecord->GetRecordType() == SR_NAME_XOWN)
	{
		m_pXownData = SrCastClass(CSrDataSubrecord, pSubrecord);
	}
	else if (pSubrecord->GetRecordType() == SR_NAME_XEZN)
	{
		m_pXeznData = SrCastClass(CSrDataSubrecord, pSubrecord);
	}
	else if (pSubrecord->GetRecordType() == SR_NAME_XPRD)
	{
		m_pXprdData = SrCastClass(CSrDataSubrecord, pSubrecord);
	}
	else if (pSubrecord->GetRecordType() == SR_NAME_INAM)
	{
		m_pInamData = SrCastClass(CSrDataSubrecord, pSubrecord);
	}
	else if (pSubrecord->GetRecordType() == SR_NAME_XHOR)
	{
		m_pXhorData = SrCastClass(CSrDataSubrecord, pSubrecord);
	}
	else if (pSubrecord->GetRecordType() == SR_NAME_XIS2)
	{
		m_pXis2Data = SrCastClass(CSrDataSubrecord, pSubrecord);
	}
	else
	{
	CSrIdRecord::OnAddSubrecord(pSubrecord);
	}

}
/*===========================================================================
 *		End of Class Event CSrAchrRecord::OnAddSubRecord()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CSrAchrRecord Event - void OnDeleteSubrecord (pSubrecord);
 *
 *=========================================================================*/
void CSrAchrRecord::OnDeleteSubrecord (CSrSubrecord* pSubrecord) {

	if (m_pNameData == pSubrecord)
		m_pNameData = NULL;
	else if (m_pXrgdData == pSubrecord)
		m_pXrgdData = NULL;
	else if (m_pXlkrData == pSubrecord)
		m_pXlkrData = NULL;
	else if (m_pXlcmData == pSubrecord)
		m_pXlcmData = NULL;
	else if (m_pVmadData == pSubrecord)
		m_pVmadData = NULL;
	else if (m_pXlcnData == pSubrecord)
		m_pXlcnData = NULL;
	else if (m_pDataData == pSubrecord)
		m_pDataData = NULL;
	else if (m_pXppaData == pSubrecord)
		m_pXppaData = NULL;
	else if (m_pXlrtData == pSubrecord)
		m_pXlrtData = NULL;
	else if (m_pXespData == pSubrecord)
		m_pXespData = NULL;
	else if (m_pXapdData == pSubrecord)
		m_pXapdData = NULL;
	else if (m_pPdtoData == pSubrecord)
		m_pPdtoData = NULL;
	else if (m_pXaprData == pSubrecord)
		m_pXaprData = NULL;
	else if (m_pXrgbData == pSubrecord)
		m_pXrgbData = NULL;
	else if (m_pXsclData == pSubrecord)
		m_pXsclData = NULL;
	else if (m_pXownData == pSubrecord)
		m_pXownData = NULL;
	else if (m_pXeznData == pSubrecord)
		m_pXeznData = NULL;
	else if (m_pXprdData == pSubrecord)
		m_pXprdData = NULL;
	else if (m_pInamData == pSubrecord)
		m_pInamData = NULL;
	else if (m_pXhorData == pSubrecord)
		m_pXhorData = NULL;
	else if (m_pXis2Data == pSubrecord)
		m_pXis2Data = NULL;
	else
		CSrIdRecord::OnDeleteSubrecord(pSubrecord);

}
/*===========================================================================
 *		End of Class Event CSrAchrRecord::OnDeleteSubrecord()
 *=========================================================================*/


/*===========================================================================
 *
 * Begin CSrAchrRecord Get Field Methods
 *
 *=========================================================================*/
/*===========================================================================
 *		End of CSrAchrRecord Get Field Methods
 *=========================================================================*/


/*===========================================================================
 *
 * Begin CSrAchrRecord Compare Field Methods
 *
 *=========================================================================*/
/*===========================================================================
 *		End of CSrAchrRecord Compare Field Methods
 *=========================================================================*/


/*===========================================================================
 *
 * Begin CSrAchrRecord Set Field Methods
 *
 *=========================================================================*/
/*===========================================================================
 *		End of CSrAchrRecord Set Field Methods
 *=========================================================================*/

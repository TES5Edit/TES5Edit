/*===========================================================================
 *
 * File:		SrDialRecord.CPP
 * Author:		Dave Humphrey (dave@uesp.net)
 * Created On:	5 December 2011
 *
 * Description
 *
 *=========================================================================*/

	/* Include Files */
#include "srDialrecord.h"


/*===========================================================================
 *
 * Begin Subrecord Creation Array
 *
 *=========================================================================*/
BEGIN_SRSUBRECCREATE(CSrDialRecord, CSrIdRecord)
	DEFINE_SRSUBRECCREATE(SR_NAME_PNAM, CSrDataSubrecord::Create)
	DEFINE_SRSUBRECCREATE(SR_NAME_DATA, CSrDataSubrecord::Create)
	DEFINE_SRSUBRECCREATE(SR_NAME_QNAM, CSrDataSubrecord::Create)
	DEFINE_SRSUBRECCREATE(SR_NAME_FULL, CSrDataSubrecord::Create)
	DEFINE_SRSUBRECCREATE(SR_NAME_SNAM, CSrDataSubrecord::Create)
	DEFINE_SRSUBRECCREATE(SR_NAME_BNAM, CSrDataSubrecord::Create)
	DEFINE_SRSUBRECCREATE(SR_NAME_TIFC, CSrDataSubrecord::Create)
END_SRSUBRECCREATE()
/*===========================================================================
 *		End of Subrecord Creation Array
 *=========================================================================*/


/*===========================================================================
 *
 * Begin CSrRecord Field Map
 *
 *=========================================================================*/
BEGIN_SRFIELDMAP(CSrDialRecord, CSrIdRecord)
END_SRFIELDMAP()
/*===========================================================================
 *		End of CObRecord Field Map
 *=========================================================================*/


/*===========================================================================
 *
 * Class CSrDialRecord Constructor
 *
 *=========================================================================*/
CSrDialRecord::CSrDialRecord () 
{
}
/*===========================================================================
 *		End of Class CSrDialRecord Constructor
 *=========================================================================*/


/*===========================================================================
 *
 * Class CSrDialRecord Method - void Destroy (void);
 *
 *=========================================================================*/
void CSrDialRecord::Destroy (void) 
{
	CSrIdRecord::Destroy();
}
/*===========================================================================
 *		End of Class Method CSrDialRecord::Destroy()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CSrDialRecord Method - void InitializeNew (void);
 *
 *=========================================================================*/
void CSrDialRecord::InitializeNew (void) 
{
	CSrIdRecord::InitializeNew();
}
/*===========================================================================
 *		End of Class Method CSrDialRecord::InitializeNew()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CSrDialRecord Event - void OnAddSubrecord (pSubrecord);
 *
 *=========================================================================*/
void CSrDialRecord::OnAddSubrecord (CSrSubrecord* pSubrecord) {

	if (pSubrecord->GetRecordType() == SR_NAME_PNAM)
	{
		m_pPnamData = SrCastClass(CSrDataSubrecord, pSubrecord);
	}
	else if (pSubrecord->GetRecordType() == SR_NAME_DATA)
	{
		m_pDataData = SrCastClass(CSrDataSubrecord, pSubrecord);
	}
	else if (pSubrecord->GetRecordType() == SR_NAME_QNAM)
	{
		m_pQnamData = SrCastClass(CSrDataSubrecord, pSubrecord);
	}
	else if (pSubrecord->GetRecordType() == SR_NAME_FULL)
	{
		m_pFullData = SrCastClass(CSrDataSubrecord, pSubrecord);
	}
	else if (pSubrecord->GetRecordType() == SR_NAME_SNAM)
	{
		m_pSnamData = SrCastClass(CSrDataSubrecord, pSubrecord);
	}
	else if (pSubrecord->GetRecordType() == SR_NAME_BNAM)
	{
		m_pBnamData = SrCastClass(CSrDataSubrecord, pSubrecord);
	}
	else if (pSubrecord->GetRecordType() == SR_NAME_TIFC)
	{
		m_pTifcData = SrCastClass(CSrDataSubrecord, pSubrecord);
	}
	else
	{
		CSrIdRecord::OnAddSubrecord(pSubrecord);
	}

}
/*===========================================================================
 *		End of Class Event CSrDialRecord::OnAddSubRecord()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CSrDialRecord Event - void OnDeleteSubrecord (pSubrecord);
 *
 *=========================================================================*/
void CSrDialRecord::OnDeleteSubrecord (CSrSubrecord* pSubrecord) {

	if (m_pPnamData == pSubrecord)
		m_pPnamData = NULL;
	else if (m_pDataData == pSubrecord)
		m_pDataData = NULL;
	else if (m_pQnamData == pSubrecord)
		m_pQnamData = NULL;
	else if (m_pFullData == pSubrecord)
		m_pFullData = NULL;
	else if (m_pSnamData == pSubrecord)
		m_pSnamData = NULL;
	else if (m_pBnamData == pSubrecord)
		m_pBnamData = NULL;
	else if (m_pTifcData == pSubrecord)
		m_pTifcData = NULL;
	else
		CSrIdRecord::OnDeleteSubrecord(pSubrecord);

}
/*===========================================================================
 *		End of Class Event CSrDialRecord::OnDeleteSubrecord()
 *=========================================================================*/


/*===========================================================================
 *
 * Begin CSrDialRecord Get Field Methods
 *
 *=========================================================================*/
/*===========================================================================
 *		End of CSrDialRecord Get Field Methods
 *=========================================================================*/


/*===========================================================================
 *
 * Begin CSrDialRecord Compare Field Methods
 *
 *=========================================================================*/
/*===========================================================================
 *		End of CSrDialRecord Compare Field Methods
 *=========================================================================*/


/*===========================================================================
 *
 * Begin CSrDialRecord Set Field Methods
 *
 *=========================================================================*/
/*===========================================================================
 *		End of CSrDialRecord Set Field Methods
 *=========================================================================*/

/*===========================================================================
 *
 * File:		SrCpthRecord.CPP
 * Author:		Dave Humphrey (dave@uesp.net)
 * Created On:	5 December 2011
 *
 * Description
 *
 *=========================================================================*/

	/* Include Files */
#include "srCpthrecord.h"


/*===========================================================================
 *
 * Begin Subrecord Creation Array
 *
 *=========================================================================*/
BEGIN_SRSUBRECCREATE(CSrCpthRecord, CSrIdRecord)
	DEFINE_SRSUBRECCREATE(SR_NAME_DATA, CSrDataSubrecord::Create)
	DEFINE_SRSUBRECCREATE(SR_NAME_ANAM, CSrDataSubrecord::Create)
	DEFINE_SRSUBRECCREATE(SR_NAME_CTDA, CSrDataSubrecord::Create)
	DEFINE_SRSUBRECCREATE(SR_NAME_CIS1, CSrStringSubrecord::Create)
	DEFINE_SRSUBRECCREATE(SR_NAME_CIS2, CSrStringSubrecord::Create)
	DEFINE_SRSUBRECCREATE(SR_NAME_SNAM, CSrDataSubrecord::Create)
END_SRSUBRECCREATE()
/*===========================================================================
 *		End of Subrecord Creation Array
 *=========================================================================*/


/*===========================================================================
 *
 * Begin CSrRecord Field Map
 *
 *=========================================================================*/
BEGIN_SRFIELDMAP(CSrCpthRecord, CSrIdRecord)
END_SRFIELDMAP()
/*===========================================================================
 *		End of CObRecord Field Map
 *=========================================================================*/


/*===========================================================================
 *
 * Class CSrCpthRecord Constructor
 *
 *=========================================================================*/
CSrCpthRecord::CSrCpthRecord () 
{
}
/*===========================================================================
 *		End of Class CSrCpthRecord Constructor
 *=========================================================================*/


/*===========================================================================
 *
 * Class CSrCpthRecord Method - void Destroy (void);
 *
 *=========================================================================*/
void CSrCpthRecord::Destroy (void) 
{
	CSrIdRecord::Destroy();
}
/*===========================================================================
 *		End of Class Method CSrCpthRecord::Destroy()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CSrCpthRecord Method - void InitializeNew (void);
 *
 *=========================================================================*/
void CSrCpthRecord::InitializeNew (void) 
{
	CSrIdRecord::InitializeNew();
}
/*===========================================================================
 *		End of Class Method CSrCpthRecord::InitializeNew()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CSrCpthRecord Event - void OnAddSubrecord (pSubrecord);
 *
 *=========================================================================*/
void CSrCpthRecord::OnAddSubrecord (CSrSubrecord* pSubrecord) {

	if (pSubrecord->GetRecordType() == SR_NAME_CIS1)
	{
		m_pCis1Data = SrCastClass(CSrDataSubrecord, pSubrecord);
	}
	else if (pSubrecord->GetRecordType() == SR_NAME_DATA)
	{
		m_pDataData = SrCastClass(CSrDataSubrecord, pSubrecord);
	}
	else if (pSubrecord->GetRecordType() == SR_NAME_ANAM)
	{
		m_pAnamData = SrCastClass(CSrDataSubrecord, pSubrecord);
	}
	else if (pSubrecord->GetRecordType() == SR_NAME_CTDA)
	{
		m_pCtdaData = SrCastClass(CSrDataSubrecord, pSubrecord);
	}
	else if (pSubrecord->GetRecordType() == SR_NAME_SNAM)
	{
		m_pSnamData = SrCastClass(CSrDataSubrecord, pSubrecord);
	}
	else
	{
		CSrIdRecord::OnAddSubrecord(pSubrecord);
	}

}
/*===========================================================================
 *		End of Class Event CSrCpthRecord::OnAddSubRecord()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CSrCpthRecord Event - void OnDeleteSubrecord (pSubrecord);
 *
 *=========================================================================*/
void CSrCpthRecord::OnDeleteSubrecord (CSrSubrecord* pSubrecord) {

	if (m_pCis1Data == pSubrecord)
		m_pCis1Data = NULL;
	else if (m_pDataData == pSubrecord)
		m_pDataData = NULL;
	else if (m_pAnamData == pSubrecord)
		m_pAnamData = NULL;
	else if (m_pCtdaData == pSubrecord)
		m_pCtdaData = NULL;
	else if (m_pSnamData == pSubrecord)
		m_pSnamData = NULL;
	else
		CSrIdRecord::OnDeleteSubrecord(pSubrecord);

}
/*===========================================================================
 *		End of Class Event CSrCpthRecord::OnDeleteSubrecord()
 *=========================================================================*/


/*===========================================================================
 *
 * Begin CSrCpthRecord Get Field Methods
 *
 *=========================================================================*/
/*===========================================================================
 *		End of CSrCpthRecord Get Field Methods
 *=========================================================================*/


/*===========================================================================
 *
 * Begin CSrCpthRecord Compare Field Methods
 *
 *=========================================================================*/
/*===========================================================================
 *		End of CSrCpthRecord Compare Field Methods
 *=========================================================================*/


/*===========================================================================
 *
 * Begin CSrCpthRecord Set Field Methods
 *
 *=========================================================================*/
/*===========================================================================
 *		End of CSrCpthRecord Set Field Methods
 *=========================================================================*/

/*===========================================================================
 *
 * File:		SrSmbnRecord.CPP
 * Author:		Dave Humphrey (dave@uesp.net)
 * Created On:	5 December 2011
 *
 * Description
 *
 *=========================================================================*/

	/* Include Files */
#include "srSmbnrecord.h"


/*===========================================================================
 *
 * Begin Subrecord Creation Array
 *
 *=========================================================================*/
BEGIN_SRSUBRECCREATE(CSrSmbnRecord, CSrIdRecord)
	DEFINE_SRSUBRECCREATE(SR_NAME_XNAM, CSrDataSubrecord::Create)
	DEFINE_SRSUBRECCREATE(SR_NAME_PNAM, CSrDataSubrecord::Create)
	DEFINE_SRSUBRECCREATE(SR_NAME_SNAM, CSrDataSubrecord::Create)
	DEFINE_SRSUBRECCREATE(SR_NAME_CITC, CSrDataSubrecord::Create)
	DEFINE_SRSUBRECCREATE(SR_NAME_CTDA, CSrDataSubrecord::Create)
	DEFINE_SRSUBRECCREATE(SR_NAME_CIS1, CSrStringSubrecord::Create)
	DEFINE_SRSUBRECCREATE(SR_NAME_CIS2, CSrStringSubrecord::Create)
	DEFINE_SRSUBRECCREATE(SR_NAME_DNAM, CSrDataSubrecord::Create)
END_SRSUBRECCREATE()
/*===========================================================================
 *		End of Subrecord Creation Array
 *=========================================================================*/


/*===========================================================================
 *
 * Begin CSrIdRecord Field Map
 *
 *=========================================================================*/
BEGIN_SRFIELDMAP(CSrSmbnRecord, CSrIdRecord)
END_SRFIELDMAP()
/*===========================================================================
 *		End of CObRecord Field Map
 *=========================================================================*/


/*===========================================================================
 *
 * Class CSrSmbnRecord Constructor
 *
 *=========================================================================*/
CSrSmbnRecord::CSrSmbnRecord () 
{
}
/*===========================================================================
 *		End of Class CSrSmbnRecord Constructor
 *=========================================================================*/


/*===========================================================================
 *
 * Class CSrSmbnRecord Method - void Destroy (void);
 *
 *=========================================================================*/
void CSrSmbnRecord::Destroy (void) 
{
	CSrIdRecord::Destroy();
}
/*===========================================================================
 *		End of Class Method CSrSmbnRecord::Destroy()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CSrSmbnRecord Method - void InitializeNew (void);
 *
 *=========================================================================*/
void CSrSmbnRecord::InitializeNew (void) 
{

	/* Call the base class method first */
	CSrIdRecord::InitializeNew();


}
/*===========================================================================
 *		End of Class Method CSrSmbnRecord::InitializeNew()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CSrSmbnRecord Event - void OnAddSubrecord (pSubrecord);
 *
 *=========================================================================*/
void CSrSmbnRecord::OnAddSubrecord (CSrSubrecord* pSubrecord) {

	if (pSubrecord->GetRecordType() == SR_NAME_XNAM)
	{
		m_pXnamData = SrCastClass(CSrDataSubrecord, pSubrecord);
	}
	else if (pSubrecord->GetRecordType() == SR_NAME_PNAM)
	{
		m_pPnamData = SrCastClass(CSrDataSubrecord, pSubrecord);
	}
	else if (pSubrecord->GetRecordType() == SR_NAME_CIS2)
	{
		m_pCis2Data = SrCastClass(CSrDataSubrecord, pSubrecord);
	}
	else if (pSubrecord->GetRecordType() == SR_NAME_SNAM)
	{
		m_pSnamData = SrCastClass(CSrDataSubrecord, pSubrecord);
	}
	else if (pSubrecord->GetRecordType() == SR_NAME_CITC)
	{
		m_pCitcData = SrCastClass(CSrDataSubrecord, pSubrecord);
	}
	else if (pSubrecord->GetRecordType() == SR_NAME_CTDA)
	{
		m_pCtdaData = SrCastClass(CSrDataSubrecord, pSubrecord);
	}
	else if (pSubrecord->GetRecordType() == SR_NAME_DNAM)
	{
		m_pDnamData = SrCastClass(CSrDataSubrecord, pSubrecord);
	}
	else
	{
		CSrIdRecord::OnAddSubrecord(pSubrecord);
	}

}
/*===========================================================================
 *		End of Class Event CSrSmbnRecord::OnAddSubRecord()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CSrSmbnRecord Event - void OnDeleteSubrecord (pSubrecord);
 *
 *=========================================================================*/
void CSrSmbnRecord::OnDeleteSubrecord (CSrSubrecord* pSubrecord) {

	if (m_pXnamData == pSubrecord)
		m_pXnamData = NULL;
	else if (m_pPnamData == pSubrecord)
		m_pPnamData = NULL;
	else if (m_pCis2Data == pSubrecord)
		m_pCis2Data = NULL;
	else if (m_pSnamData == pSubrecord)
		m_pSnamData = NULL;
	else if (m_pCitcData == pSubrecord)
		m_pCitcData = NULL;
	else if (m_pCtdaData == pSubrecord)
		m_pCtdaData = NULL;
	else if (m_pDnamData == pSubrecord)
		m_pDnamData = NULL;
	else
		CSrIdRecord::OnDeleteSubrecord(pSubrecord);

}
/*===========================================================================
 *		End of Class Event CSrSmbnRecord::OnDeleteSubrecord()
 *=========================================================================*/


/*===========================================================================
 *
 * Begin CSrSmbnRecord Get Field Methods
 *
 *=========================================================================*/
/*===========================================================================
 *		End of CSrSmbnRecord Get Field Methods
 *=========================================================================*/


/*===========================================================================
 *
 * Begin CSrSmbnRecord Compare Field Methods
 *
 *=========================================================================*/
/*===========================================================================
 *		End of CSrSmbnRecord Compare Field Methods
 *=========================================================================*/


/*===========================================================================
 *
 * Begin CSrSmbnRecord Set Field Methods
 *
 *=========================================================================*/
/*===========================================================================
 *		End of CSrSmbnRecord Set Field Methods
 *=========================================================================*/

/*===========================================================================
 *
 * File:		SrMesgRecord.CPP
 * Author:		Dave Humphrey (dave@uesp.net)
 * Created On:	5 December 2011
 *
 * Description
 *
 *=========================================================================*/

	/* Include Files */
#include "srMesgrecord.h"


/*===========================================================================
 *
 * Begin Subrecord Creation Array
 *
 *=========================================================================*/
BEGIN_SRSUBRECCREATE(CSrMesgRecord, CSrIdRecord)
	DEFINE_SRSUBRECCREATE(SR_NAME_ITXT, CSrDataSubrecord::Create)
	DEFINE_SRSUBRECCREATE(SR_NAME_FULL, CSrDataSubrecord::Create)
	DEFINE_SRSUBRECCREATE(SR_NAME_DESC, CSrDataSubrecord::Create)
	DEFINE_SRSUBRECCREATE(SR_NAME_CTDA, CSrDataSubrecord::Create)
	DEFINE_SRSUBRECCREATE(SR_NAME_CIS1, CSrStringSubrecord::Create)
	DEFINE_SRSUBRECCREATE(SR_NAME_CIS2, CSrStringSubrecord::Create)
	DEFINE_SRSUBRECCREATE(SR_NAME_QNAM, CSrDataSubrecord::Create)
	DEFINE_SRSUBRECCREATE(SR_NAME_INAM, CSrDataSubrecord::Create)
	DEFINE_SRSUBRECCREATE(SR_NAME_TNAM, CSrDataSubrecord::Create)
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
BEGIN_SRFIELDMAP(CSrMesgRecord, CSrIdRecord)
END_SRFIELDMAP()
/*===========================================================================
 *		End of CObRecord Field Map
 *=========================================================================*/


/*===========================================================================
 *
 * Class CSrMesgRecord Constructor
 *
 *=========================================================================*/
CSrMesgRecord::CSrMesgRecord () 
{
}
/*===========================================================================
 *		End of Class CSrMesgRecord Constructor
 *=========================================================================*/


/*===========================================================================
 *
 * Class CSrMesgRecord Method - void Destroy (void);
 *
 *=========================================================================*/
void CSrMesgRecord::Destroy (void) 
{
	CSrIdRecord::Destroy();
}
/*===========================================================================
 *		End of Class Method CSrMesgRecord::Destroy()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CSrMesgRecord Method - void InitializeNew (void);
 *
 *=========================================================================*/
void CSrMesgRecord::InitializeNew (void) 
{

	/* Call the base class method first */
	CSrIdRecord::InitializeNew();


}
/*===========================================================================
 *		End of Class Method CSrMesgRecord::InitializeNew()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CSrMesgRecord Event - void OnAddSubrecord (pSubrecord);
 *
 *=========================================================================*/
void CSrMesgRecord::OnAddSubrecord (CSrSubrecord* pSubrecord) {

	if (pSubrecord->GetRecordType() == SR_NAME_ITXT)
	{
		m_pItxtData = SrCastClass(CSrDataSubrecord, pSubrecord);
	}
	else if (pSubrecord->GetRecordType() == SR_NAME_FULL)
	{
		m_pFullData = SrCastClass(CSrDataSubrecord, pSubrecord);
	}
	else if (pSubrecord->GetRecordType() == SR_NAME_DESC)
	{
		m_pDescData = SrCastClass(CSrDataSubrecord, pSubrecord);
	}
	else if (pSubrecord->GetRecordType() == SR_NAME_CTDA)
	{
		m_pCtdaData = SrCastClass(CSrDataSubrecord, pSubrecord);
	}
	else if (pSubrecord->GetRecordType() == SR_NAME_QNAM)
	{
		m_pQnamData = SrCastClass(CSrDataSubrecord, pSubrecord);
	}
	else if (pSubrecord->GetRecordType() == SR_NAME_INAM)
	{
		m_pInamData = SrCastClass(CSrDataSubrecord, pSubrecord);
	}
	else if (pSubrecord->GetRecordType() == SR_NAME_TNAM)
	{
		m_pTnamData = SrCastClass(CSrDataSubrecord, pSubrecord);
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
 *		End of Class Event CSrMesgRecord::OnAddSubRecord()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CSrMesgRecord Event - void OnDeleteSubrecord (pSubrecord);
 *
 *=========================================================================*/
void CSrMesgRecord::OnDeleteSubrecord (CSrSubrecord* pSubrecord) {

	if (m_pItxtData == pSubrecord)
		m_pItxtData = NULL;

	else if (m_pFullData == pSubrecord)
		m_pFullData = NULL;
	else if (m_pDescData == pSubrecord)
		m_pDescData = NULL;
	else if (m_pCtdaData == pSubrecord)
		m_pCtdaData = NULL;
	else if (m_pQnamData == pSubrecord)
		m_pQnamData = NULL;
	else if (m_pInamData == pSubrecord)
		m_pInamData = NULL;
	else if (m_pTnamData == pSubrecord)
		m_pTnamData = NULL;
	else if (m_pDnamData == pSubrecord)
		m_pDnamData = NULL;

	else
		CSrIdRecord::OnDeleteSubrecord(pSubrecord);

}
/*===========================================================================
 *		End of Class Event CSrMesgRecord::OnDeleteSubrecord()
 *=========================================================================*/


/*===========================================================================
 *
 * Begin CSrMesgRecord Get Field Methods
 *
 *=========================================================================*/
/*===========================================================================
 *		End of CSrMesgRecord Get Field Methods
 *=========================================================================*/


/*===========================================================================
 *
 * Begin CSrMesgRecord Compare Field Methods
 *
 *=========================================================================*/
/*===========================================================================
 *		End of CSrMesgRecord Compare Field Methods
 *=========================================================================*/


/*===========================================================================
 *
 * Begin CSrMesgRecord Set Field Methods
 *
 *=========================================================================*/
/*===========================================================================
 *		End of CSrMesgRecord Set Field Methods
 *=========================================================================*/

/*===========================================================================
 *
 * File:		SrSmenRecord.CPP
 * Author:		Dave Humphrey (dave@uesp.net)
 * Created On:	5 December 2011
 *
 * Description
 *
 *=========================================================================*/

	/* Include Files */
#include "srSmenrecord.h"


/*===========================================================================
 *
 * Begin Subrecord Creation Array
 *
 *=========================================================================*/
BEGIN_SRSUBRECCREATE(CSrSmenRecord, CSrIdRecord)
	DEFINE_SRSUBRECCREATE(SR_NAME_XNAM, CSrDataSubrecord::Create)
	DEFINE_SRSUBRECCREATE(SR_NAME_PNAM, CSrDataSubrecord::Create)
	DEFINE_SRSUBRECCREATE(SR_NAME_SNAM, CSrDataSubrecord::Create)
	DEFINE_SRSUBRECCREATE(SR_NAME_CITC, CSrDataSubrecord::Create)
	DEFINE_SRSUBRECCREATE(SR_NAME_DNAM, CSrDataSubrecord::Create)
	DEFINE_SRSUBRECCREATE(SR_NAME_ENAM, CSrDataSubrecord::Create)

END_SRSUBRECCREATE()
/*===========================================================================
 *		End of Subrecord Creation Array
 *=========================================================================*/


/*===========================================================================
 *
 * Begin CSrIdRecord Field Map
 *
 *=========================================================================*/
BEGIN_SRFIELDMAP(CSrSmenRecord, CSrIdRecord)
END_SRFIELDMAP()
/*===========================================================================
 *		End of CObRecord Field Map
 *=========================================================================*/


/*===========================================================================
 *
 * Class CSrSmenRecord Constructor
 *
 *=========================================================================*/
CSrSmenRecord::CSrSmenRecord () 
{
}
/*===========================================================================
 *		End of Class CSrSmenRecord Constructor
 *=========================================================================*/


/*===========================================================================
 *
 * Class CSrSmenRecord Method - void Destroy (void);
 *
 *=========================================================================*/
void CSrSmenRecord::Destroy (void) 
{
	CSrIdRecord::Destroy();
}
/*===========================================================================
 *		End of Class Method CSrSmenRecord::Destroy()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CSrSmenRecord Method - void InitializeNew (void);
 *
 *=========================================================================*/
void CSrSmenRecord::InitializeNew (void) 
{

	/* Call the base class method first */
	CSrIdRecord::InitializeNew();


}
/*===========================================================================
 *		End of Class Method CSrSmenRecord::InitializeNew()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CSrSmenRecord Event - void OnAddSubrecord (pSubrecord);
 *
 *=========================================================================*/
void CSrSmenRecord::OnAddSubrecord (CSrSubrecord* pSubrecord) {

	if (pSubrecord->GetRecordType() == SR_NAME_XNAM)
	{
		m_pXnamData = SrCastClass(CSrDataSubrecord, pSubrecord);
	}
	else if (pSubrecord->GetRecordType() == SR_NAME_PNAM)
	{
		m_pPnamData = SrCastClass(CSrDataSubrecord, pSubrecord);
	}
	else if (pSubrecord->GetRecordType() == SR_NAME_SNAM)
	{
		m_pSnamData = SrCastClass(CSrDataSubrecord, pSubrecord);
	}
	else if (pSubrecord->GetRecordType() == SR_NAME_CITC)
	{
		m_pCitcData = SrCastClass(CSrDataSubrecord, pSubrecord);
	}
	else if (pSubrecord->GetRecordType() == SR_NAME_DNAM)
	{
		m_pDnamData = SrCastClass(CSrDataSubrecord, pSubrecord);
	}
	else if (pSubrecord->GetRecordType() == SR_NAME_ENAM)
	{
		m_pEnamData = SrCastClass(CSrDataSubrecord, pSubrecord);
	}

	else
	{
	CSrIdRecord::OnAddSubrecord(pSubrecord);
	}

}
/*===========================================================================
 *		End of Class Event CSrSmenRecord::OnAddSubRecord()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CSrSmenRecord Event - void OnDeleteSubrecord (pSubrecord);
 *
 *=========================================================================*/
void CSrSmenRecord::OnDeleteSubrecord (CSrSubrecord* pSubrecord) {

	if (m_pXnamData == pSubrecord)
		m_pXnamData = NULL;
	else if (m_pPnamData == pSubrecord)
		m_pPnamData = NULL;
	else if (m_pSnamData == pSubrecord)
		m_pSnamData = NULL;
	else if (m_pCitcData == pSubrecord)
		m_pCitcData = NULL;
	else if (m_pDnamData == pSubrecord)
		m_pDnamData = NULL;
	else if (m_pEnamData == pSubrecord)
		m_pEnamData = NULL;


	else
		CSrIdRecord::OnDeleteSubrecord(pSubrecord);

}
/*===========================================================================
 *		End of Class Event CSrSmenRecord::OnDeleteSubrecord()
 *=========================================================================*/


/*===========================================================================
 *
 * Begin CSrSmenRecord Get Field Methods
 *
 *=========================================================================*/
/*===========================================================================
 *		End of CSrSmenRecord Get Field Methods
 *=========================================================================*/


/*===========================================================================
 *
 * Begin CSrSmenRecord Compare Field Methods
 *
 *=========================================================================*/
/*===========================================================================
 *		End of CSrSmenRecord Compare Field Methods
 *=========================================================================*/


/*===========================================================================
 *
 * Begin CSrSmenRecord Set Field Methods
 *
 *=========================================================================*/
/*===========================================================================
 *		End of CSrSmenRecord Set Field Methods
 *=========================================================================*/

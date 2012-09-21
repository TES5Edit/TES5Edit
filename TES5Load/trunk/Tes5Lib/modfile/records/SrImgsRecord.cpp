/*===========================================================================
 *
 * File:		SrImgsRecord.CPP
 * Author:		Dave Humphrey (dave@uesp.net)
 * Created On:	5 December 2011
 *
 * Description
 *
 *=========================================================================*/

	/* Include Files */
#include "srImgsrecord.h"


/*===========================================================================
 *
 * Begin Subrecord Creation Array
 *
 *=========================================================================*/
BEGIN_SRSUBRECCREATE(CSrImgsRecord, CSrIdRecord)
	DEFINE_SRSUBRECCREATE(SR_NAME_HNAM, CSrDataSubrecord::Create)
	DEFINE_SRSUBRECCREATE(SR_NAME_CNAM, CSrDataSubrecord::Create)
	DEFINE_SRSUBRECCREATE(SR_NAME_DNAM, CSrDataSubrecord::Create)
	DEFINE_SRSUBRECCREATE(SR_NAME_TNAM, CSrDataSubrecord::Create)
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
BEGIN_SRFIELDMAP(CSrImgsRecord, CSrIdRecord)
END_SRFIELDMAP()
/*===========================================================================
 *		End of CObRecord Field Map
 *=========================================================================*/


/*===========================================================================
 *
 * Class CSrImgsRecord Constructor
 *
 *=========================================================================*/
CSrImgsRecord::CSrImgsRecord () 
{
}
/*===========================================================================
 *		End of Class CSrImgsRecord Constructor
 *=========================================================================*/


/*===========================================================================
 *
 * Class CSrImgsRecord Method - void Destroy (void);
 *
 *=========================================================================*/
void CSrImgsRecord::Destroy (void) 
{
	CSrIdRecord::Destroy();
}
/*===========================================================================
 *		End of Class Method CSrImgsRecord::Destroy()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CSrImgsRecord Method - void InitializeNew (void);
 *
 *=========================================================================*/
void CSrImgsRecord::InitializeNew (void) 
{
	CSrIdRecord::InitializeNew();
}
/*===========================================================================
 *		End of Class Method CSrImgsRecord::InitializeNew()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CSrImgsRecord Event - void OnAddSubrecord (pSubrecord);
 *
 *=========================================================================*/
void CSrImgsRecord::OnAddSubrecord (CSrSubrecord* pSubrecord) {

	if (pSubrecord->GetRecordType() == SR_NAME_HNAM)
	{
		m_pHnamData = SrCastClass(CSrDataSubrecord, pSubrecord);
	}
	else if (pSubrecord->GetRecordType() == SR_NAME_CNAM)
	{
		m_pCnamData = SrCastClass(CSrDataSubrecord, pSubrecord);
	}
	else if (pSubrecord->GetRecordType() == SR_NAME_DNAM)
	{
		m_pDnamData = SrCastClass(CSrDataSubrecord, pSubrecord);
	}
	else if (pSubrecord->GetRecordType() == SR_NAME_TNAM)
	{
		m_pTnamData = SrCastClass(CSrDataSubrecord, pSubrecord);
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
 *		End of Class Event CSrImgsRecord::OnAddSubRecord()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CSrImgsRecord Event - void OnDeleteSubrecord (pSubrecord);
 *
 *=========================================================================*/
void CSrImgsRecord::OnDeleteSubrecord (CSrSubrecord* pSubrecord) {

	if (m_pHnamData == pSubrecord)
		m_pHnamData = NULL;
	else if (m_pCnamData == pSubrecord)
		m_pCnamData = NULL;
	else if (m_pDnamData == pSubrecord)
		m_pDnamData = NULL;
	else if (m_pTnamData == pSubrecord)
		m_pTnamData = NULL;
	else if (m_pEnamData == pSubrecord)
		m_pEnamData = NULL;
	else
		CSrIdRecord::OnDeleteSubrecord(pSubrecord);

}
/*===========================================================================
 *		End of Class Event CSrImgsRecord::OnDeleteSubrecord()
 *=========================================================================*/


/*===========================================================================
 *
 * Begin CSrImgsRecord Get Field Methods
 *
 *=========================================================================*/
/*===========================================================================
 *		End of CSrImgsRecord Get Field Methods
 *=========================================================================*/


/*===========================================================================
 *
 * Begin CSrImgsRecord Compare Field Methods
 *
 *=========================================================================*/
/*===========================================================================
 *		End of CSrImgsRecord Compare Field Methods
 *=========================================================================*/


/*===========================================================================
 *
 * Begin CSrImgsRecord Set Field Methods
 *
 *=========================================================================*/
/*===========================================================================
 *		End of CSrImgsRecord Set Field Methods
 *=========================================================================*/

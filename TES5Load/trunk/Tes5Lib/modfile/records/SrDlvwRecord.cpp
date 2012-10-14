/*===========================================================================
 *
 * File:		SrDlvwRecord.CPP
 * Author:		Dave Humphrey (dave@uesp.net)
 * Created On:	5 December 2011
 *
 * Description
 *
 *=========================================================================*/

	/* Include Files */
#include "srDlvwrecord.h"


/*===========================================================================
 *
 * Begin Subrecord Creation Array
 *
 *=========================================================================*/
BEGIN_SRSUBRECCREATE(CSrDlvwRecord, CSrIdRecord)
	DEFINE_SRSUBRECCREATE(SR_NAME_QNAM, CSrDataSubrecord::Create)
	DEFINE_SRSUBRECCREATE(SR_NAME_BNAM, CSrDataSubrecord::Create)
	DEFINE_SRSUBRECCREATE(SR_NAME_ENAM, CSrDataSubrecord::Create)
	DEFINE_SRSUBRECCREATE(SR_NAME_TNAM, CSrDataSubrecord::Create)
	DEFINE_SRSUBRECCREATE(SR_NAME_DNAM, CSrDataSubrecord::Create)
END_SRSUBRECCREATE()
/*===========================================================================
 *		End of Subrecord Creation Array
 *=========================================================================*/


/*===========================================================================
 *
 * Begin CSrRecord Field Map
 *
 *=========================================================================*/
BEGIN_SRFIELDMAP(CSrDlvwRecord, CSrIdRecord)
END_SRFIELDMAP()
/*===========================================================================
 *		End of CObRecord Field Map
 *=========================================================================*/


/*===========================================================================
 *
 * Class CSrDlvwRecord Constructor
 *
 *=========================================================================*/
CSrDlvwRecord::CSrDlvwRecord () 
{
}
/*===========================================================================
 *		End of Class CSrDlvwRecord Constructor
 *=========================================================================*/


/*===========================================================================
 *
 * Class CSrDlvwRecord Method - void Destroy (void);
 *
 *=========================================================================*/
void CSrDlvwRecord::Destroy (void) 
{
	CSrIdRecord::Destroy();
}
/*===========================================================================
 *		End of Class Method CSrDlvwRecord::Destroy()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CSrDlvwRecord Method - void InitializeNew (void);
 *
 *=========================================================================*/
void CSrDlvwRecord::InitializeNew (void) 
{
	CSrIdRecord::InitializeNew();
}
/*===========================================================================
 *		End of Class Method CSrDlvwRecord::InitializeNew()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CSrDlvwRecord Event - void OnAddSubrecord (pSubrecord);
 *
 *=========================================================================*/
void CSrDlvwRecord::OnAddSubrecord (CSrSubrecord* pSubrecord) {

	if (pSubrecord->GetRecordType() == SR_NAME_QNAM)
	{
		m_pQnamData = SrCastClass(CSrDataSubrecord, pSubrecord);
	}
	else if (pSubrecord->GetRecordType() == SR_NAME_BNAM)
	{
		m_pBnamData = SrCastClass(CSrDataSubrecord, pSubrecord);
	}
	else if (pSubrecord->GetRecordType() == SR_NAME_ENAM)
	{
		m_pEnamData = SrCastClass(CSrDataSubrecord, pSubrecord);
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
 *		End of Class Event CSrDlvwRecord::OnAddSubRecord()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CSrDlvwRecord Event - void OnDeleteSubrecord (pSubrecord);
 *
 *=========================================================================*/
void CSrDlvwRecord::OnDeleteSubrecord (CSrSubrecord* pSubrecord) {

	if (m_pQnamData == pSubrecord)
		m_pQnamData = NULL;
	else if (m_pBnamData == pSubrecord)
		m_pBnamData = NULL;
	else if (m_pEnamData == pSubrecord)
		m_pEnamData = NULL;
	else if (m_pTnamData == pSubrecord)
		m_pTnamData = NULL;
	else if (m_pDnamData == pSubrecord)
		m_pDnamData = NULL;
	else
		CSrIdRecord::OnDeleteSubrecord(pSubrecord);

}
/*===========================================================================
 *		End of Class Event CSrDlvwRecord::OnDeleteSubrecord()
 *=========================================================================*/


/*===========================================================================
 *
 * Begin CSrDlvwRecord Get Field Methods
 *
 *=========================================================================*/
/*===========================================================================
 *		End of CSrDlvwRecord Get Field Methods
 *=========================================================================*/


/*===========================================================================
 *
 * Begin CSrDlvwRecord Compare Field Methods
 *
 *=========================================================================*/
/*===========================================================================
 *		End of CSrDlvwRecord Compare Field Methods
 *=========================================================================*/


/*===========================================================================
 *
 * Begin CSrDlvwRecord Set Field Methods
 *
 *=========================================================================*/
/*===========================================================================
 *		End of CSrDlvwRecord Set Field Methods
 *=========================================================================*/

/*===========================================================================
 *
 * File:		SrDlbrRecord.CPP
 * Author:		Dave Humphrey (dave@uesp.net)
 * Created On:	5 December 2011
 *
 * Description
 *
 *=========================================================================*/

	/* Include Files */
#include "srDlbrrecord.h"


/*===========================================================================
 *
 * Begin Subrecord Creation Array
 *
 *=========================================================================*/
BEGIN_SRSUBRECCREATE(CSrDlbrRecord, CSrIdRecord)
	DEFINE_SRSUBRECCREATE(SR_NAME_QNAM, CSrDataSubrecord::Create)
	DEFINE_SRSUBRECCREATE(SR_NAME_DNAM, CSrDataSubrecord::Create)
	DEFINE_SRSUBRECCREATE(SR_NAME_TNAM, CSrDataSubrecord::Create)
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
BEGIN_SRFIELDMAP(CSrDlbrRecord, CSrIdRecord)
END_SRFIELDMAP()
/*===========================================================================
 *		End of CObRecord Field Map
 *=========================================================================*/


/*===========================================================================
 *
 * Class CSrDlbrRecord Constructor
 *
 *=========================================================================*/
CSrDlbrRecord::CSrDlbrRecord () 
{
}
/*===========================================================================
 *		End of Class CSrDlbrRecord Constructor
 *=========================================================================*/


/*===========================================================================
 *
 * Class CSrDlbrRecord Method - void Destroy (void);
 *
 *=========================================================================*/
void CSrDlbrRecord::Destroy (void) 
{
	CSrIdRecord::Destroy();
}
/*===========================================================================
 *		End of Class Method CSrDlbrRecord::Destroy()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CSrDlbrRecord Method - void InitializeNew (void);
 *
 *=========================================================================*/
void CSrDlbrRecord::InitializeNew (void) 
{
	CSrIdRecord::InitializeNew();
}
/*===========================================================================
 *		End of Class Method CSrDlbrRecord::InitializeNew()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CSrDlbrRecord Event - void OnAddSubrecord (pSubrecord);
 *
 *=========================================================================*/
void CSrDlbrRecord::OnAddSubrecord (CSrSubrecord* pSubrecord) {

	if (pSubrecord->GetRecordType() == SR_NAME_QNAM)
	{
		m_pQnamData = SrCastClass(CSrDataSubrecord, pSubrecord);
	}
	else if (pSubrecord->GetRecordType() == SR_NAME_DNAM)
	{
		m_pDnamData = SrCastClass(CSrDataSubrecord, pSubrecord);
	}
	else if (pSubrecord->GetRecordType() == SR_NAME_TNAM)
	{
		m_pTnamData = SrCastClass(CSrDataSubrecord, pSubrecord);
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
 *		End of Class Event CSrDlbrRecord::OnAddSubRecord()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CSrDlbrRecord Event - void OnDeleteSubrecord (pSubrecord);
 *
 *=========================================================================*/
void CSrDlbrRecord::OnDeleteSubrecord (CSrSubrecord* pSubrecord) {

	if (m_pQnamData == pSubrecord)
		m_pQnamData = NULL;
	else if (m_pDnamData == pSubrecord)
		m_pDnamData = NULL;
	else if (m_pTnamData == pSubrecord)
		m_pTnamData = NULL;
	else if (m_pSnamData == pSubrecord)
		m_pSnamData = NULL;
	else
		CSrIdRecord::OnDeleteSubrecord(pSubrecord);

}
/*===========================================================================
 *		End of Class Event CSrDlbrRecord::OnDeleteSubrecord()
 *=========================================================================*/


/*===========================================================================
 *
 * Begin CSrDlbrRecord Get Field Methods
 *
 *=========================================================================*/
/*===========================================================================
 *		End of CSrDlbrRecord Get Field Methods
 *=========================================================================*/


/*===========================================================================
 *
 * Begin CSrDlbrRecord Compare Field Methods
 *
 *=========================================================================*/
/*===========================================================================
 *		End of CSrDlbrRecord Compare Field Methods
 *=========================================================================*/


/*===========================================================================
 *
 * Begin CSrDlbrRecord Set Field Methods
 *
 *=========================================================================*/
/*===========================================================================
 *		End of CSrDlbrRecord Set Field Methods
 *=========================================================================*/

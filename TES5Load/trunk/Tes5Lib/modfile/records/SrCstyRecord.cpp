/*===========================================================================
 *
 * File:		SrCstyRecord.CPP
 * Author:		Dave Humphrey (dave@uesp.net)
 * Created On:	5 December 2011
 *
 * Description
 *
 *=========================================================================*/

	/* Include Files */
#include "srCstyrecord.h"


/*===========================================================================
 *
 * Begin Subrecord Creation Array
 *
 *=========================================================================*/
BEGIN_SRSUBRECCREATE(CSrCstyRecord, CSrIdRecord)
	DEFINE_SRSUBRECCREATE(SR_NAME_CSGD, CSrDataSubrecord::Create)
	DEFINE_SRSUBRECCREATE(SR_NAME_CSME, CSrDataSubrecord::Create)
	DEFINE_SRSUBRECCREATE(SR_NAME_DATA, CSrDataSubrecord::Create)
	DEFINE_SRSUBRECCREATE(SR_NAME_CSCR, CSrDataSubrecord::Create)
	DEFINE_SRSUBRECCREATE(SR_NAME_CSLR, CSrDataSubrecord::Create)
	DEFINE_SRSUBRECCREATE(SR_NAME_CSFL, CSrDataSubrecord::Create)
	DEFINE_SRSUBRECCREATE(SR_NAME_CSMD, CSrDataSubrecord::Create)
END_SRSUBRECCREATE()
/*===========================================================================
 *		End of Subrecord Creation Array
 *=========================================================================*/


/*===========================================================================
 *
 * Begin CSrRecord Field Map
 *
 *=========================================================================*/
BEGIN_SRFIELDMAP(CSrCstyRecord, CSrIdRecord)
END_SRFIELDMAP()
/*===========================================================================
 *		End of CObRecord Field Map
 *=========================================================================*/


/*===========================================================================
 *
 * Class CSrCstyRecord Constructor
 *
 *=========================================================================*/
CSrCstyRecord::CSrCstyRecord () 
{
}
/*===========================================================================
 *		End of Class CSrCstyRecord Constructor
 *=========================================================================*/


/*===========================================================================
 *
 * Class CSrCstyRecord Method - void Destroy (void);
 *
 *=========================================================================*/
void CSrCstyRecord::Destroy (void) 
{
	CSrIdRecord::Destroy();
}
/*===========================================================================
 *		End of Class Method CSrCstyRecord::Destroy()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CSrCstyRecord Method - void InitializeNew (void);
 *
 *=========================================================================*/
void CSrCstyRecord::InitializeNew (void) 
{
	CSrIdRecord::InitializeNew();
}
/*===========================================================================
 *		End of Class Method CSrCstyRecord::InitializeNew()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CSrCstyRecord Event - void OnAddSubrecord (pSubrecord);
 *
 *=========================================================================*/
void CSrCstyRecord::OnAddSubrecord (CSrSubrecord* pSubrecord) {

	if (pSubrecord->GetRecordType() == SR_NAME_CSGD)
	{
		m_pCsgdData = SrCastClass(CSrDataSubrecord, pSubrecord);
	}
	else if (pSubrecord->GetRecordType() == SR_NAME_CSME)
	{
		m_pCsmeData = SrCastClass(CSrDataSubrecord, pSubrecord);
	}
	else if (pSubrecord->GetRecordType() == SR_NAME_DATA)
	{
		m_pDataData = SrCastClass(CSrDataSubrecord, pSubrecord);
	}
	else if (pSubrecord->GetRecordType() == SR_NAME_CSCR)
	{
		m_pCscrData = SrCastClass(CSrDataSubrecord, pSubrecord);
	}
	else if (pSubrecord->GetRecordType() == SR_NAME_CSLR)
	{
		m_pCslrData = SrCastClass(CSrDataSubrecord, pSubrecord);
	}
	else if (pSubrecord->GetRecordType() == SR_NAME_CSFL)
	{
		m_pCsflData = SrCastClass(CSrDataSubrecord, pSubrecord);
	}
	else if (pSubrecord->GetRecordType() == SR_NAME_CSMD)
	{
		m_pCsmdData = SrCastClass(CSrDataSubrecord, pSubrecord);
	}
	else
	{
		CSrIdRecord::OnAddSubrecord(pSubrecord);
	}

}
/*===========================================================================
 *		End of Class Event CSrCstyRecord::OnAddSubRecord()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CSrCstyRecord Event - void OnDeleteSubrecord (pSubrecord);
 *
 *=========================================================================*/
void CSrCstyRecord::OnDeleteSubrecord (CSrSubrecord* pSubrecord) {

	if (m_pCsgdData == pSubrecord)
		m_pCsgdData = NULL;
	else if (m_pCsmeData == pSubrecord)
		m_pCsmeData = NULL;
	else if (m_pDataData == pSubrecord)
		m_pDataData = NULL;
	else if (m_pCscrData == pSubrecord)
		m_pCscrData = NULL;
	else if (m_pCslrData == pSubrecord)
		m_pCslrData = NULL;
	else if (m_pCsflData == pSubrecord)
		m_pCsflData = NULL;
	else if (m_pCsmdData == pSubrecord)
		m_pCsmdData = NULL;
	else
		CSrIdRecord::OnDeleteSubrecord(pSubrecord);

}
/*===========================================================================
 *		End of Class Event CSrCstyRecord::OnDeleteSubrecord()
 *=========================================================================*/


/*===========================================================================
 *
 * Begin CSrCstyRecord Get Field Methods
 *
 *=========================================================================*/
/*===========================================================================
 *		End of CSrCstyRecord Get Field Methods
 *=========================================================================*/


/*===========================================================================
 *
 * Begin CSrCstyRecord Compare Field Methods
 *
 *=========================================================================*/
/*===========================================================================
 *		End of CSrCstyRecord Compare Field Methods
 *=========================================================================*/


/*===========================================================================
 *
 * Begin CSrCstyRecord Set Field Methods
 *
 *=========================================================================*/
/*===========================================================================
 *		End of CSrCstyRecord Set Field Methods
 *=========================================================================*/

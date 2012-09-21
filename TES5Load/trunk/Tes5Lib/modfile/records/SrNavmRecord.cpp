/*===========================================================================
 *
 * File:		SrNavmRecord.CPP
 * Author:		Dave Humphrey (dave@uesp.net)
 * Created On:	5 December 2011
 *
 * Description
 *
 *=========================================================================*/

	/* Include Files */
#include "srNavmrecord.h"


/*===========================================================================
 *
 * Begin Subrecord Creation Array
 *
 *=========================================================================*/
BEGIN_SRSUBRECCREATE(CSrNavmRecord, CSrRecord)
	DEFINE_SRSUBRECCREATE(SR_NAME_ONAM, CSrDataSubrecord::Create)
	DEFINE_SRSUBRECCREATE(SR_NAME_XXXX, CSrDataSubrecord::Create)
	DEFINE_SRSUBRECCREATE(SR_NAME_NVNM, CSrDataSubrecord::Create)
	DEFINE_SRSUBRECCREATE(SR_NAME_NNAM, CSrDataSubrecord::Create)
	DEFINE_SRSUBRECCREATE(SR_NAME_PNAM, CSrDataSubrecord::Create)

END_SRSUBRECCREATE()
/*===========================================================================
 *		End of Subrecord Creation Array
 *=========================================================================*/


/*===========================================================================
 *
 * Begin CSrRecord Field Map
 *
 *=========================================================================*/
BEGIN_SRFIELDMAP(CSrNavmRecord, CSrRecord)
END_SRFIELDMAP()
/*===========================================================================
 *		End of CObRecord Field Map
 *=========================================================================*/


/*===========================================================================
 *
 * Class CSrNavmRecord Constructor
 *
 *=========================================================================*/
CSrNavmRecord::CSrNavmRecord () 
{
}
/*===========================================================================
 *		End of Class CSrNavmRecord Constructor
 *=========================================================================*/


/*===========================================================================
 *
 * Class CSrNavmRecord Method - void Destroy (void);
 *
 *=========================================================================*/
void CSrNavmRecord::Destroy (void) 
{
	CSrRecord::Destroy();
}
/*===========================================================================
 *		End of Class Method CSrNavmRecord::Destroy()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CSrNavmRecord Method - void InitializeNew (void);
 *
 *=========================================================================*/
void CSrNavmRecord::InitializeNew (void) 
{

	/* Call the base class method first */
	CSrRecord::InitializeNew();


}
/*===========================================================================
 *		End of Class Method CSrNavmRecord::InitializeNew()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CSrNavmRecord Event - void OnAddSubrecord (pSubrecord);
 *
 *=========================================================================*/
void CSrNavmRecord::OnAddSubrecord (CSrSubrecord* pSubrecord) {

	if (pSubrecord->GetRecordType() == SR_NAME_ONAM)
	{
		m_pOnamData = SrCastClass(CSrDataSubrecord, pSubrecord);
	}
	else if (pSubrecord->GetRecordType() == SR_NAME_XXXX)
	{
		m_pXxxxData = SrCastClass(CSrDataSubrecord, pSubrecord);
	}
	else if (pSubrecord->GetRecordType() == SR_NAME_NVNM)
	{
		m_pNvnmData = SrCastClass(CSrDataSubrecord, pSubrecord);
	}
	else if (pSubrecord->GetRecordType() == SR_NAME_NNAM)
	{
		m_pNnamData = SrCastClass(CSrDataSubrecord, pSubrecord);
	}
	else if (pSubrecord->GetRecordType() == SR_NAME_PNAM)
	{
		m_pPnamData = SrCastClass(CSrDataSubrecord, pSubrecord);
	}

	else
	{
	CSrRecord::OnAddSubrecord(pSubrecord);
	}

}
/*===========================================================================
 *		End of Class Event CSrNavmRecord::OnAddSubRecord()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CSrNavmRecord Event - void OnDeleteSubrecord (pSubrecord);
 *
 *=========================================================================*/
void CSrNavmRecord::OnDeleteSubrecord (CSrSubrecord* pSubrecord) {

	if (m_pOnamData == pSubrecord)
		m_pOnamData = NULL;
	else if (m_pXxxxData == pSubrecord)
		m_pXxxxData = NULL;
	else if (m_pNvnmData == pSubrecord)
		m_pNvnmData = NULL;
	else if (m_pNnamData == pSubrecord)
		m_pNnamData = NULL;
	else if (m_pPnamData == pSubrecord)
		m_pPnamData = NULL;

	else
		CSrRecord::OnDeleteSubrecord(pSubrecord);

}
/*===========================================================================
 *		End of Class Event CSrNavmRecord::OnDeleteSubrecord()
 *=========================================================================*/


/*===========================================================================
 *
 * Begin CSrNavmRecord Get Field Methods
 *
 *=========================================================================*/
/*===========================================================================
 *		End of CSrNavmRecord Get Field Methods
 *=========================================================================*/


/*===========================================================================
 *
 * Begin CSrNavmRecord Compare Field Methods
 *
 *=========================================================================*/
/*===========================================================================
 *		End of CSrNavmRecord Compare Field Methods
 *=========================================================================*/


/*===========================================================================
 *
 * Begin CSrNavmRecord Set Field Methods
 *
 *=========================================================================*/
/*===========================================================================
 *		End of CSrNavmRecord Set Field Methods
 *=========================================================================*/

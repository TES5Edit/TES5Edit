/*===========================================================================
 *
 * File:		SrLtexRecord.CPP
 * Author:		Dave Humphrey (dave@uesp.net)
 * Created On:	5 December 2011
 *
 * Description
 *
 *=========================================================================*/

	/* Include Files */
#include "srLtexrecord.h"


/*===========================================================================
 *
 * Begin Subrecord Creation Array
 *
 *=========================================================================*/
BEGIN_SRSUBRECCREATE(CSrLtexRecord, CSrIdRecord)
	DEFINE_SRSUBRECCREATE(SR_NAME_TNAM, CSrDataSubrecord::Create)
	DEFINE_SRSUBRECCREATE(SR_NAME_MNAM, CSrDataSubrecord::Create)
	DEFINE_SRSUBRECCREATE(SR_NAME_HNAM, CSrDataSubrecord::Create)
	DEFINE_SRSUBRECCREATE(SR_NAME_SNAM, CSrDataSubrecord::Create)
	DEFINE_SRSUBRECCREATE(SR_NAME_GNAM, CSrDataSubrecord::Create)
END_SRSUBRECCREATE()
/*===========================================================================
 *		End of Subrecord Creation Array
 *=========================================================================*/


/*===========================================================================
 *
 * Begin CSrIdRecord Field Map
 *
 *=========================================================================*/
BEGIN_SRFIELDMAP(CSrLtexRecord, CSrIdRecord)
END_SRFIELDMAP()
/*===========================================================================
 *		End of CObRecord Field Map
 *=========================================================================*/


/*===========================================================================
 *
 * Class CSrLtexRecord Constructor
 *
 *=========================================================================*/
CSrLtexRecord::CSrLtexRecord () 
{
}
/*===========================================================================
 *		End of Class CSrLtexRecord Constructor
 *=========================================================================*/


/*===========================================================================
 *
 * Class CSrLtexRecord Method - void Destroy (void);
 *
 *=========================================================================*/
void CSrLtexRecord::Destroy (void) 
{
	CSrIdRecord::Destroy();
}
/*===========================================================================
 *		End of Class Method CSrLtexRecord::Destroy()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CSrLtexRecord Method - void InitializeNew (void);
 *
 *=========================================================================*/
void CSrLtexRecord::InitializeNew (void) 
{
	CSrIdRecord::InitializeNew();
}
/*===========================================================================
 *		End of Class Method CSrLtexRecord::InitializeNew()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CSrLtexRecord Event - void OnAddSubrecord (pSubrecord);
 *
 *=========================================================================*/
void CSrLtexRecord::OnAddSubrecord (CSrSubrecord* pSubrecord) {

	if (pSubrecord->GetRecordType() == SR_NAME_TNAM)
	{
		m_pTnamData = SrCastClass(CSrDataSubrecord, pSubrecord);
	}
	else if (pSubrecord->GetRecordType() == SR_NAME_MNAM)
	{
		m_pMnamData = SrCastClass(CSrDataSubrecord, pSubrecord);
	}
	else if (pSubrecord->GetRecordType() == SR_NAME_HNAM)
	{
		m_pHnamData = SrCastClass(CSrDataSubrecord, pSubrecord);
	}
	else if (pSubrecord->GetRecordType() == SR_NAME_SNAM)
	{
		m_pSnamData = SrCastClass(CSrDataSubrecord, pSubrecord);
	}
	else if (pSubrecord->GetRecordType() == SR_NAME_GNAM)
	{
		m_pGnamData = SrCastClass(CSrDataSubrecord, pSubrecord);
	}
	else
	{
		CSrIdRecord::OnAddSubrecord(pSubrecord);
	}

}
/*===========================================================================
 *		End of Class Event CSrLtexRecord::OnAddSubRecord()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CSrLtexRecord Event - void OnDeleteSubrecord (pSubrecord);
 *
 *=========================================================================*/
void CSrLtexRecord::OnDeleteSubrecord (CSrSubrecord* pSubrecord) {

	if (m_pTnamData == pSubrecord)
		m_pTnamData = NULL;
	else if (m_pMnamData == pSubrecord)
		m_pMnamData = NULL;
	else if (m_pHnamData == pSubrecord)
		m_pHnamData = NULL;
	else if (m_pSnamData == pSubrecord)
		m_pSnamData = NULL;
	else if (m_pGnamData == pSubrecord)
		m_pGnamData = NULL;
	else
		CSrIdRecord::OnDeleteSubrecord(pSubrecord);

}
/*===========================================================================
 *		End of Class Event CSrLtexRecord::OnDeleteSubrecord()
 *=========================================================================*/


/*===========================================================================
 *
 * Begin CSrLtexRecord Get Field Methods
 *
 *=========================================================================*/
/*===========================================================================
 *		End of CSrLtexRecord Get Field Methods
 *=========================================================================*/


/*===========================================================================
 *
 * Begin CSrLtexRecord Compare Field Methods
 *
 *=========================================================================*/
/*===========================================================================
 *		End of CSrLtexRecord Compare Field Methods
 *=========================================================================*/


/*===========================================================================
 *
 * Begin CSrLtexRecord Set Field Methods
 *
 *=========================================================================*/
/*===========================================================================
 *		End of CSrLtexRecord Set Field Methods
 *=========================================================================*/

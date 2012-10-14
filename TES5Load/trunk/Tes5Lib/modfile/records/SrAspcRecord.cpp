/*===========================================================================
 *
 * File:		SrAspcRecord.CPP
 * Author:		Dave Humphrey (dave@uesp.net)
 * Created On:	5 December 2011
 *
 * Description
 *
 *=========================================================================*/

	/* Include Files */
#include "srAspcrecord.h"


/*===========================================================================
 *
 * Begin Subrecord Creation Array
 *
 *=========================================================================*/
BEGIN_SRSUBRECCREATE(CSrAspcRecord, CSrIdRecord)
	DEFINE_SRSUBRECCREATE(SR_NAME_RDAT, CSrDataSubrecord::Create)
	DEFINE_SRSUBRECCREATE(SR_NAME_BNAM, CSrDataSubrecord::Create)
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
BEGIN_SRFIELDMAP(CSrAspcRecord, CSrIdRecord)
END_SRFIELDMAP()
/*===========================================================================
 *		End of CObRecord Field Map
 *=========================================================================*/


/*===========================================================================
 *
 * Class CSrAspcRecord Constructor
 *
 *=========================================================================*/
CSrAspcRecord::CSrAspcRecord () 
{
}
/*===========================================================================
 *		End of Class CSrAspcRecord Constructor
 *=========================================================================*/


/*===========================================================================
 *
 * Class CSrAspcRecord Method - void Destroy (void);
 *
 *=========================================================================*/
void CSrAspcRecord::Destroy (void) 
{
	CSrIdRecord::Destroy();
}
/*===========================================================================
 *		End of Class Method CSrAspcRecord::Destroy()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CSrAspcRecord Method - void InitializeNew (void);
 *
 *=========================================================================*/
void CSrAspcRecord::InitializeNew (void) 
{
	CSrIdRecord::InitializeNew();
}
/*===========================================================================
 *		End of Class Method CSrAspcRecord::InitializeNew()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CSrAspcRecord Event - void OnAddSubrecord (pSubrecord);
 *
 *=========================================================================*/
void CSrAspcRecord::OnAddSubrecord (CSrSubrecord* pSubrecord) {

	if (pSubrecord->GetRecordType() == SR_NAME_RDAT)
	{
		m_pRdatData = SrCastClass(CSrDataSubrecord, pSubrecord);
	}
	else if (pSubrecord->GetRecordType() == SR_NAME_BNAM)
	{
		m_pBnamData = SrCastClass(CSrDataSubrecord, pSubrecord);
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
 *		End of Class Event CSrAspcRecord::OnAddSubRecord()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CSrAspcRecord Event - void OnDeleteSubrecord (pSubrecord);
 *
 *=========================================================================*/
void CSrAspcRecord::OnDeleteSubrecord (CSrSubrecord* pSubrecord) {

	if (m_pRdatData == pSubrecord)
		m_pRdatData = NULL;
	else if (m_pBnamData == pSubrecord)
		m_pBnamData = NULL;
	else if (m_pSnamData == pSubrecord)
		m_pSnamData = NULL;
	else
		CSrIdRecord::OnDeleteSubrecord(pSubrecord);

}
/*===========================================================================
 *		End of Class Event CSrAspcRecord::OnDeleteSubrecord()
 *=========================================================================*/


/*===========================================================================
 *
 * Begin CSrAspcRecord Get Field Methods
 *
 *=========================================================================*/
/*===========================================================================
 *		End of CSrAspcRecord Get Field Methods
 *=========================================================================*/


/*===========================================================================
 *
 * Begin CSrAspcRecord Compare Field Methods
 *
 *=========================================================================*/
/*===========================================================================
 *		End of CSrAspcRecord Compare Field Methods
 *=========================================================================*/


/*===========================================================================
 *
 * Begin CSrAspcRecord Set Field Methods
 *
 *=========================================================================*/
/*===========================================================================
 *		End of CSrAspcRecord Set Field Methods
 *=========================================================================*/

/*===========================================================================
 *
 * File:		SrCollRecord.CPP
 * Author:		Dave Humphrey (dave@uesp.net)
 * Created On:	5 December 2011
 *
 * Description
 *
 *=========================================================================*/

	/* Include Files */
#include "srCollrecord.h"


/*===========================================================================
 *
 * Begin Subrecord Creation Array
 *
 *=========================================================================*/
BEGIN_SRSUBRECCREATE(CSrCollRecord, CSrIdRecord)
	DEFINE_SRSUBRECCREATE(SR_NAME_FNAM, CSrDataSubrecord::Create)
	DEFINE_SRSUBRECCREATE(SR_NAME_CNAM, CSrDataSubrecord::Create)
	DEFINE_SRSUBRECCREATE(SR_NAME_DESC, CSrDataSubrecord::Create)
	DEFINE_SRSUBRECCREATE(SR_NAME_BNAM, CSrDataSubrecord::Create)
	DEFINE_SRSUBRECCREATE(SR_NAME_GNAM, CSrDataSubrecord::Create)
	DEFINE_SRSUBRECCREATE(SR_NAME_MNAM, CSrDataSubrecord::Create)
	DEFINE_SRSUBRECCREATE(SR_NAME_INTV, CSrDataSubrecord::Create)
END_SRSUBRECCREATE()
/*===========================================================================
 *		End of Subrecord Creation Array
 *=========================================================================*/


/*===========================================================================
 *
 * Begin CSrRecord Field Map
 *
 *=========================================================================*/
BEGIN_SRFIELDMAP(CSrCollRecord, CSrIdRecord)
END_SRFIELDMAP()
/*===========================================================================
 *		End of CObRecord Field Map
 *=========================================================================*/


/*===========================================================================
 *
 * Class CSrCollRecord Constructor
 *
 *=========================================================================*/
CSrCollRecord::CSrCollRecord () 
{
}
/*===========================================================================
 *		End of Class CSrCollRecord Constructor
 *=========================================================================*/


/*===========================================================================
 *
 * Class CSrCollRecord Method - void Destroy (void);
 *
 *=========================================================================*/
void CSrCollRecord::Destroy (void) 
{
	CSrIdRecord::Destroy();
}
/*===========================================================================
 *		End of Class Method CSrCollRecord::Destroy()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CSrCollRecord Method - void InitializeNew (void);
 *
 *=========================================================================*/
void CSrCollRecord::InitializeNew (void) 
{
	CSrIdRecord::InitializeNew();
}
/*===========================================================================
 *		End of Class Method CSrCollRecord::InitializeNew()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CSrCollRecord Event - void OnAddSubrecord (pSubrecord);
 *
 *=========================================================================*/
void CSrCollRecord::OnAddSubrecord (CSrSubrecord* pSubrecord) {

	if (pSubrecord->GetRecordType() == SR_NAME_FNAM)
	{
		m_pFnamData = SrCastClass(CSrDataSubrecord, pSubrecord);
	}
	else if (pSubrecord->GetRecordType() == SR_NAME_CNAM)
	{
		m_pCnamData = SrCastClass(CSrDataSubrecord, pSubrecord);
	}
	else if (pSubrecord->GetRecordType() == SR_NAME_DESC)
	{
		m_pDescData = SrCastClass(CSrDataSubrecord, pSubrecord);
	}
	else if (pSubrecord->GetRecordType() == SR_NAME_BNAM)
	{
		m_pBnamData = SrCastClass(CSrDataSubrecord, pSubrecord);
	}
	else if (pSubrecord->GetRecordType() == SR_NAME_GNAM)
	{
		m_pGnamData = SrCastClass(CSrDataSubrecord, pSubrecord);
	}
	else if (pSubrecord->GetRecordType() == SR_NAME_MNAM)
	{
		m_pMnamData = SrCastClass(CSrDataSubrecord, pSubrecord);
	}
	else if (pSubrecord->GetRecordType() == SR_NAME_INTV)
	{
		m_pIntvData = SrCastClass(CSrDataSubrecord, pSubrecord);
	}
	else
	{
		CSrIdRecord::OnAddSubrecord(pSubrecord);
	}

}
/*===========================================================================
 *		End of Class Event CSrCollRecord::OnAddSubRecord()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CSrCollRecord Event - void OnDeleteSubrecord (pSubrecord);
 *
 *=========================================================================*/
void CSrCollRecord::OnDeleteSubrecord (CSrSubrecord* pSubrecord) {

	if (m_pFnamData == pSubrecord)
		m_pFnamData = NULL;
	else if (m_pCnamData == pSubrecord)
		m_pCnamData = NULL;
	else if (m_pDescData == pSubrecord)
		m_pDescData = NULL;
	else if (m_pBnamData == pSubrecord)
		m_pBnamData = NULL;
	else if (m_pGnamData == pSubrecord)
		m_pGnamData = NULL;
	else if (m_pMnamData == pSubrecord)
		m_pMnamData = NULL;
	else if (m_pIntvData == pSubrecord)
		m_pIntvData = NULL;
	else
		CSrIdRecord::OnDeleteSubrecord(pSubrecord);

}
/*===========================================================================
 *		End of Class Event CSrCollRecord::OnDeleteSubrecord()
 *=========================================================================*/


/*===========================================================================
 *
 * Begin CSrCollRecord Get Field Methods
 *
 *=========================================================================*/
/*===========================================================================
 *		End of CSrCollRecord Get Field Methods
 *=========================================================================*/


/*===========================================================================
 *
 * Begin CSrCollRecord Compare Field Methods
 *
 *=========================================================================*/
/*===========================================================================
 *		End of CSrCollRecord Compare Field Methods
 *=========================================================================*/


/*===========================================================================
 *
 * Begin CSrCollRecord Set Field Methods
 *
 *=========================================================================*/
/*===========================================================================
 *		End of CSrCollRecord Set Field Methods
 *=========================================================================*/

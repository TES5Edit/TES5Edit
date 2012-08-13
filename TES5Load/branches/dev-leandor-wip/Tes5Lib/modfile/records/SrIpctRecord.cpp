/*===========================================================================
 *
 * File:		SrIpctRecord.CPP
 * Author:		Dave Humphrey (dave@uesp.net)
 * Created On:	5 December 2011
 *
 * Description
 *
 *=========================================================================*/

	/* Include Files */
#include "srIpctrecord.h"


/*===========================================================================
 *
 * Begin Subrecord Creation Array
 *
 *=========================================================================*/
BEGIN_SRSUBRECCREATE(CSrIpctRecord, CSrIdRecord)
	DEFINE_SRSUBRECCREATE(SR_NAME_MODL, CSrDataSubrecord::Create)
	DEFINE_SRSUBRECCREATE(SR_NAME_NAM2, CSrDataSubrecord::Create)
	DEFINE_SRSUBRECCREATE(SR_NAME_DATA, CSrDataSubrecord::Create)
	DEFINE_SRSUBRECCREATE(SR_NAME_SNAM, CSrDataSubrecord::Create)
	DEFINE_SRSUBRECCREATE(SR_NAME_DODT, CSrDataSubrecord::Create)
	DEFINE_SRSUBRECCREATE(SR_NAME_DNAM, CSrDataSubrecord::Create)
	DEFINE_SRSUBRECCREATE(SR_NAME_NAM1, CSrDataSubrecord::Create)
	DEFINE_SRSUBRECCREATE(SR_NAME_MODT, CSrDataSubrecord::Create)
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
BEGIN_SRFIELDMAP(CSrIpctRecord, CSrIdRecord)
END_SRFIELDMAP()
/*===========================================================================
 *		End of CObRecord Field Map
 *=========================================================================*/


/*===========================================================================
 *
 * Class CSrIpctRecord Constructor
 *
 *=========================================================================*/
CSrIpctRecord::CSrIpctRecord () 
{
}
/*===========================================================================
 *		End of Class CSrIpctRecord Constructor
 *=========================================================================*/


/*===========================================================================
 *
 * Class CSrIpctRecord Method - void Destroy (void);
 *
 *=========================================================================*/
void CSrIpctRecord::Destroy (void) 
{
	CSrIdRecord::Destroy();
}
/*===========================================================================
 *		End of Class Method CSrIpctRecord::Destroy()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CSrIpctRecord Method - void InitializeNew (void);
 *
 *=========================================================================*/
void CSrIpctRecord::InitializeNew (void) 
{
	CSrIdRecord::InitializeNew();
}
/*===========================================================================
 *		End of Class Method CSrIpctRecord::InitializeNew()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CSrIpctRecord Event - void OnAddSubrecord (pSubrecord);
 *
 *=========================================================================*/
void CSrIpctRecord::OnAddSubrecord (CSrSubrecord* pSubrecord) {

	if (pSubrecord->GetRecordType() == SR_NAME_MODL)
	{
		m_pModlData = SrCastClass(CSrDataSubrecord, pSubrecord);
	}
	else if (pSubrecord->GetRecordType() == SR_NAME_NAM2)
	{
		m_pNam2Data = SrCastClass(CSrDataSubrecord, pSubrecord);
	}
	else if (pSubrecord->GetRecordType() == SR_NAME_DATA)
	{
		m_pDataData = SrCastClass(CSrDataSubrecord, pSubrecord);
	}
	else if (pSubrecord->GetRecordType() == SR_NAME_SNAM)
	{
		m_pSnamData = SrCastClass(CSrDataSubrecord, pSubrecord);
	}
	else if (pSubrecord->GetRecordType() == SR_NAME_DODT)
	{
		m_pDodtData = SrCastClass(CSrDataSubrecord, pSubrecord);
	}
	else if (pSubrecord->GetRecordType() == SR_NAME_DNAM)
	{
		m_pDnamData = SrCastClass(CSrDataSubrecord, pSubrecord);
	}
	else if (pSubrecord->GetRecordType() == SR_NAME_NAM1)
	{
		m_pNam1Data = SrCastClass(CSrDataSubrecord, pSubrecord);
	}
	else if (pSubrecord->GetRecordType() == SR_NAME_MODT)
	{
		m_pModtData = SrCastClass(CSrDataSubrecord, pSubrecord);
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
 *		End of Class Event CSrIpctRecord::OnAddSubRecord()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CSrIpctRecord Event - void OnDeleteSubrecord (pSubrecord);
 *
 *=========================================================================*/
void CSrIpctRecord::OnDeleteSubrecord (CSrSubrecord* pSubrecord) {

	if (m_pModlData == pSubrecord)
		m_pModlData = NULL;
	else if (m_pNam2Data == pSubrecord)
		m_pNam2Data = NULL;
	else if (m_pDataData == pSubrecord)
		m_pDataData = NULL;
	else if (m_pSnamData == pSubrecord)
		m_pSnamData = NULL;
	else if (m_pDodtData == pSubrecord)
		m_pDodtData = NULL;
	else if (m_pDnamData == pSubrecord)
		m_pDnamData = NULL;
	else if (m_pNam1Data == pSubrecord)
		m_pNam1Data = NULL;
	else if (m_pModtData == pSubrecord)
		m_pModtData = NULL;
	else if (m_pEnamData == pSubrecord)
		m_pEnamData = NULL;
	else
		CSrIdRecord::OnDeleteSubrecord(pSubrecord);

}
/*===========================================================================
 *		End of Class Event CSrIpctRecord::OnDeleteSubrecord()
 *=========================================================================*/


/*===========================================================================
 *
 * Begin CSrIpctRecord Get Field Methods
 *
 *=========================================================================*/
/*===========================================================================
 *		End of CSrIpctRecord Get Field Methods
 *=========================================================================*/


/*===========================================================================
 *
 * Begin CSrIpctRecord Compare Field Methods
 *
 *=========================================================================*/
/*===========================================================================
 *		End of CSrIpctRecord Compare Field Methods
 *=========================================================================*/


/*===========================================================================
 *
 * Begin CSrIpctRecord Set Field Methods
 *
 *=========================================================================*/
/*===========================================================================
 *		End of CSrIpctRecord Set Field Methods
 *=========================================================================*/

/*===========================================================================
 *
 * File:		SrClmtRecord.CPP
 * Author:		Dave Humphrey (dave@uesp.net)
 * Created On:	5 December 2011
 *
 * Description
 *
 *=========================================================================*/

	/* Include Files */
#include "srClmtrecord.h"


/*===========================================================================
 *
 * Begin Subrecord Creation Array
 *
 *=========================================================================*/
BEGIN_SRSUBRECCREATE(CSrClmtRecord, CSrIdRecord)
	DEFINE_SRSUBRECCREATE(SR_NAME_MODL, CSrDataSubrecord::Create)
	DEFINE_SRSUBRECCREATE(SR_NAME_FNAM, CSrDataSubrecord::Create)
	DEFINE_SRSUBRECCREATE(SR_NAME_WLST, CSrDataSubrecord::Create)
	DEFINE_SRSUBRECCREATE(SR_NAME_GNAM, CSrDataSubrecord::Create)
	DEFINE_SRSUBRECCREATE(SR_NAME_TNAM, CSrDataSubrecord::Create)
	DEFINE_SRSUBRECCREATE(SR_NAME_MODT, CSrDataSubrecord::Create)
END_SRSUBRECCREATE()
/*===========================================================================
 *		End of Subrecord Creation Array
 *=========================================================================*/


/*===========================================================================
 *
 * Begin CSrRecord Field Map
 *
 *=========================================================================*/
BEGIN_SRFIELDMAP(CSrClmtRecord, CSrIdRecord)
END_SRFIELDMAP()
/*===========================================================================
 *		End of CObRecord Field Map
 *=========================================================================*/


/*===========================================================================
 *
 * Class CSrClmtRecord Constructor
 *
 *=========================================================================*/
CSrClmtRecord::CSrClmtRecord () 
{
}
/*===========================================================================
 *		End of Class CSrClmtRecord Constructor
 *=========================================================================*/


/*===========================================================================
 *
 * Class CSrClmtRecord Method - void Destroy (void);
 *
 *=========================================================================*/
void CSrClmtRecord::Destroy (void) 
{
	CSrIdRecord::Destroy();
}
/*===========================================================================
 *		End of Class Method CSrClmtRecord::Destroy()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CSrClmtRecord Method - void InitializeNew (void);
 *
 *=========================================================================*/
void CSrClmtRecord::InitializeNew (void) 
{
	CSrIdRecord::InitializeNew();
}
/*===========================================================================
 *		End of Class Method CSrClmtRecord::InitializeNew()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CSrClmtRecord Event - void OnAddSubrecord (pSubrecord);
 *
 *=========================================================================*/
void CSrClmtRecord::OnAddSubrecord (CSrSubrecord* pSubrecord) {

	if (pSubrecord->GetRecordType() == SR_NAME_MODL)
	{
		m_pModlData = SrCastClass(CSrDataSubrecord, pSubrecord);
	}
	else if (pSubrecord->GetRecordType() == SR_NAME_FNAM)
	{
		m_pFnamData = SrCastClass(CSrDataSubrecord, pSubrecord);
	}
	else if (pSubrecord->GetRecordType() == SR_NAME_WLST)
	{
		m_pWlstData = SrCastClass(CSrDataSubrecord, pSubrecord);
	}
	else if (pSubrecord->GetRecordType() == SR_NAME_GNAM)
	{
		m_pGnamData = SrCastClass(CSrDataSubrecord, pSubrecord);
	}
	else if (pSubrecord->GetRecordType() == SR_NAME_TNAM)
	{
		m_pTnamData = SrCastClass(CSrDataSubrecord, pSubrecord);
	}
	else if (pSubrecord->GetRecordType() == SR_NAME_MODT)
	{
		m_pModtData = SrCastClass(CSrDataSubrecord, pSubrecord);
	}
	else
	{
		CSrIdRecord::OnAddSubrecord(pSubrecord);
	}

}
/*===========================================================================
 *		End of Class Event CSrClmtRecord::OnAddSubRecord()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CSrClmtRecord Event - void OnDeleteSubrecord (pSubrecord);
 *
 *=========================================================================*/
void CSrClmtRecord::OnDeleteSubrecord (CSrSubrecord* pSubrecord) {

	if (m_pModlData == pSubrecord)
		m_pModlData = NULL;
	else if (m_pFnamData == pSubrecord)
		m_pFnamData = NULL;
	else if (m_pWlstData == pSubrecord)
		m_pWlstData = NULL;
	else if (m_pGnamData == pSubrecord)
		m_pGnamData = NULL;
	else if (m_pTnamData == pSubrecord)
		m_pTnamData = NULL;
	else if (m_pModtData == pSubrecord)
		m_pModtData = NULL;
	else
		CSrIdRecord::OnDeleteSubrecord(pSubrecord);

}
/*===========================================================================
 *		End of Class Event CSrClmtRecord::OnDeleteSubrecord()
 *=========================================================================*/


/*===========================================================================
 *
 * Begin CSrClmtRecord Get Field Methods
 *
 *=========================================================================*/
/*===========================================================================
 *		End of CSrClmtRecord Get Field Methods
 *=========================================================================*/


/*===========================================================================
 *
 * Begin CSrClmtRecord Compare Field Methods
 *
 *=========================================================================*/
/*===========================================================================
 *		End of CSrClmtRecord Compare Field Methods
 *=========================================================================*/


/*===========================================================================
 *
 * Begin CSrClmtRecord Set Field Methods
 *
 *=========================================================================*/
/*===========================================================================
 *		End of CSrClmtRecord Set Field Methods
 *=========================================================================*/

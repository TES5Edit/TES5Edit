/*===========================================================================
 *
 * File:		SrExplRecord.CPP
 * Author:		Dave Humphrey (dave@uesp.net)
 * Created On:	5 December 2011
 *
 * Description
 *
 *=========================================================================*/

	/* Include Files */
#include "srExplrecord.h"


/*===========================================================================
 *
 * Begin Subrecord Creation Array
 *
 *=========================================================================*/
BEGIN_SRSUBRECCREATE(CSrExplRecord, CSrIdRecord)
	DEFINE_SRSUBRECCREATE(SR_NAME_MODL, CSrDataSubrecord::Create)
	DEFINE_SRSUBRECCREATE(SR_NAME_MODT, CSrDataSubrecord::Create)
	DEFINE_SRSUBRECCREATE(SR_NAME_DATA, CSrDataSubrecord::Create)
	DEFINE_SRSUBRECCREATE(SR_NAME_MNAM, CSrDataSubrecord::Create)
	DEFINE_SRSUBRECCREATE(SR_NAME_FULL, CSrDataSubrecord::Create)
	DEFINE_SRSUBRECCREATE(SR_NAME_EITM, CSrDataSubrecord::Create)
END_SRSUBRECCREATE()
/*===========================================================================
 *		End of Subrecord Creation Array
 *=========================================================================*/


/*===========================================================================
 *
 * Begin CSrRecord Field Map
 *
 *=========================================================================*/
BEGIN_SRFIELDMAP(CSrExplRecord, CSrIdRecord)
END_SRFIELDMAP()
/*===========================================================================
 *		End of CObRecord Field Map
 *=========================================================================*/


/*===========================================================================
 *
 * Class CSrExplRecord Constructor
 *
 *=========================================================================*/
CSrExplRecord::CSrExplRecord () 
{
}
/*===========================================================================
 *		End of Class CSrExplRecord Constructor
 *=========================================================================*/


/*===========================================================================
 *
 * Class CSrExplRecord Method - void Destroy (void);
 *
 *=========================================================================*/
void CSrExplRecord::Destroy (void) 
{
	CSrIdRecord::Destroy();
}
/*===========================================================================
 *		End of Class Method CSrExplRecord::Destroy()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CSrExplRecord Method - void InitializeNew (void);
 *
 *=========================================================================*/
void CSrExplRecord::InitializeNew (void) 
{
	CSrIdRecord::InitializeNew();
}
/*===========================================================================
 *		End of Class Method CSrExplRecord::InitializeNew()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CSrExplRecord Event - void OnAddSubrecord (pSubrecord);
 *
 *=========================================================================*/
void CSrExplRecord::OnAddSubrecord (CSrSubrecord* pSubrecord) {

	if (pSubrecord->GetRecordType() == SR_NAME_MODL)
	{
		m_pModlData = SrCastClass(CSrDataSubrecord, pSubrecord);
	}
	else if (pSubrecord->GetRecordType() == SR_NAME_MODT)
	{
		m_pModtData = SrCastClass(CSrDataSubrecord, pSubrecord);
	}
	else if (pSubrecord->GetRecordType() == SR_NAME_DATA)
	{
		m_pDataData = SrCastClass(CSrDataSubrecord, pSubrecord);
	}
	else if (pSubrecord->GetRecordType() == SR_NAME_MNAM)
	{
		m_pMnamData = SrCastClass(CSrDataSubrecord, pSubrecord);
	}
	else if (pSubrecord->GetRecordType() == SR_NAME_FULL)
	{
		m_pFullData = SrCastClass(CSrDataSubrecord, pSubrecord);
	}
	else if (pSubrecord->GetRecordType() == SR_NAME_EITM)
	{
		m_pEitmData = SrCastClass(CSrDataSubrecord, pSubrecord);
	}
	else
	{
		CSrIdRecord::OnAddSubrecord(pSubrecord);
	}

}
/*===========================================================================
 *		End of Class Event CSrExplRecord::OnAddSubRecord()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CSrExplRecord Event - void OnDeleteSubrecord (pSubrecord);
 *
 *=========================================================================*/
void CSrExplRecord::OnDeleteSubrecord (CSrSubrecord* pSubrecord) {

	if (m_pModlData == pSubrecord)
		m_pModlData = NULL;
	else if (m_pModtData == pSubrecord)
		m_pModtData = NULL;
	else if (m_pDataData == pSubrecord)
		m_pDataData = NULL;
	else if (m_pMnamData == pSubrecord)
		m_pMnamData = NULL;
	else if (m_pFullData == pSubrecord)
		m_pFullData = NULL;
	else if (m_pEitmData == pSubrecord)
		m_pEitmData = NULL;
	else
		CSrIdRecord::OnDeleteSubrecord(pSubrecord);

}
/*===========================================================================
 *		End of Class Event CSrExplRecord::OnDeleteSubrecord()
 *=========================================================================*/


/*===========================================================================
 *
 * Begin CSrExplRecord Get Field Methods
 *
 *=========================================================================*/
/*===========================================================================
 *		End of CSrExplRecord Get Field Methods
 *=========================================================================*/


/*===========================================================================
 *
 * Begin CSrExplRecord Compare Field Methods
 *
 *=========================================================================*/
/*===========================================================================
 *		End of CSrExplRecord Compare Field Methods
 *=========================================================================*/


/*===========================================================================
 *
 * Begin CSrExplRecord Set Field Methods
 *
 *=========================================================================*/
/*===========================================================================
 *		End of CSrExplRecord Set Field Methods
 *=========================================================================*/

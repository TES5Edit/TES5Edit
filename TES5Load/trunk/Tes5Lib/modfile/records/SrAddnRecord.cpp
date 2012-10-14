/*===========================================================================
 *
 * File:		SrAddnRecord.CPP
 * Author:		Dave Humphrey (dave@uesp.net)
 * Created On:	5 December 2011
 *
 * Description
 *
 *=========================================================================*/

	/* Include Files */
#include "srAddnrecord.h"


/*===========================================================================
 *
 * Begin Subrecord Creation Array
 *
 *=========================================================================*/
BEGIN_SRSUBRECCREATE(CSrAddnRecord, CSrIdRecord)
	DEFINE_SRSUBRECCREATE(SR_NAME_MODL, CSrDataSubrecord::Create)
	DEFINE_SRSUBRECCREATE(SR_NAME_DNAM, CSrDataSubrecord::Create)
	DEFINE_SRSUBRECCREATE(SR_NAME_MODT, CSrDataSubrecord::Create)
	DEFINE_SRSUBRECCREATE(SR_NAME_DATA, CSrDataSubrecord::Create)
END_SRSUBRECCREATE()
/*===========================================================================
 *		End of Subrecord Creation Array
 *=========================================================================*/


/*===========================================================================
 *
 * Begin CSrRecord Field Map
 *
 *=========================================================================*/
BEGIN_SRFIELDMAP(CSrAddnRecord, CSrIdRecord)
END_SRFIELDMAP()
/*===========================================================================
 *		End of CObRecord Field Map
 *=========================================================================*/


/*===========================================================================
 *
 * Class CSrAddnRecord Constructor
 *
 *=========================================================================*/
CSrAddnRecord::CSrAddnRecord () 
{
}
/*===========================================================================
 *		End of Class CSrAddnRecord Constructor
 *=========================================================================*/


/*===========================================================================
 *
 * Class CSrAddnRecord Method - void Destroy (void);
 *
 *=========================================================================*/
void CSrAddnRecord::Destroy (void) 
{
	CSrIdRecord::Destroy();
}
/*===========================================================================
 *		End of Class Method CSrAddnRecord::Destroy()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CSrAddnRecord Method - void InitializeNew (void);
 *
 *=========================================================================*/
void CSrAddnRecord::InitializeNew (void) 
{
	CSrIdRecord::InitializeNew();
}
/*===========================================================================
 *		End of Class Method CSrAddnRecord::InitializeNew()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CSrAddnRecord Event - void OnAddSubrecord (pSubrecord);
 *
 *=========================================================================*/
void CSrAddnRecord::OnAddSubrecord (CSrSubrecord* pSubrecord) {

	if (pSubrecord->GetRecordType() == SR_NAME_MODL)
	{
		m_pModlData = SrCastClass(CSrDataSubrecord, pSubrecord);
	}
	else if (pSubrecord->GetRecordType() == SR_NAME_DNAM)
	{
		m_pDnamData = SrCastClass(CSrDataSubrecord, pSubrecord);
	}
	else if (pSubrecord->GetRecordType() == SR_NAME_MODT)
	{
		m_pModtData = SrCastClass(CSrDataSubrecord, pSubrecord);
	}
	else if (pSubrecord->GetRecordType() == SR_NAME_DATA)
	{
		m_pDataData = SrCastClass(CSrDataSubrecord, pSubrecord);
	}
	else
	{
		CSrIdRecord::OnAddSubrecord(pSubrecord);
	}

}
/*===========================================================================
 *		End of Class Event CSrAddnRecord::OnAddSubRecord()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CSrAddnRecord Event - void OnDeleteSubrecord (pSubrecord);
 *
 *=========================================================================*/
void CSrAddnRecord::OnDeleteSubrecord (CSrSubrecord* pSubrecord) {

	if (m_pModlData == pSubrecord)
		m_pModlData = NULL;
	else if (m_pDnamData == pSubrecord)
		m_pDnamData = NULL;
	else if (m_pModtData == pSubrecord)
		m_pModtData = NULL;
	else if (m_pDataData == pSubrecord)
		m_pDataData = NULL;
	else
		CSrIdRecord::OnDeleteSubrecord(pSubrecord);

}
/*===========================================================================
 *		End of Class Event CSrAddnRecord::OnDeleteSubrecord()
 *=========================================================================*/


/*===========================================================================
 *
 * Begin CSrAddnRecord Get Field Methods
 *
 *=========================================================================*/
/*===========================================================================
 *		End of CSrAddnRecord Get Field Methods
 *=========================================================================*/


/*===========================================================================
 *
 * Begin CSrAddnRecord Compare Field Methods
 *
 *=========================================================================*/
/*===========================================================================
 *		End of CSrAddnRecord Compare Field Methods
 *=========================================================================*/


/*===========================================================================
 *
 * Begin CSrAddnRecord Set Field Methods
 *
 *=========================================================================*/
/*===========================================================================
 *		End of CSrAddnRecord Set Field Methods
 *=========================================================================*/

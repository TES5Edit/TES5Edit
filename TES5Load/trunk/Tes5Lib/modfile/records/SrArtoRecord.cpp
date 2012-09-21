/*===========================================================================
 *
 * File:		SrArtoRecord.CPP
 * Author:		Dave Humphrey (dave@uesp.net)
 * Created On:	5 December 2011
 *
 * Description
 *
 *=========================================================================*/

	/* Include Files */
#include "srArtorecord.h"


/*===========================================================================
 *
 * Begin Subrecord Creation Array
 *
 *=========================================================================*/
BEGIN_SRSUBRECCREATE(CSrArtoRecord, CSrIdRecord)
	DEFINE_SRSUBRECCREATE(SR_NAME_MODL, CSrDataSubrecord::Create)
	DEFINE_SRSUBRECCREATE(SR_NAME_DNAM, CSrDataSubrecord::Create)
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
BEGIN_SRFIELDMAP(CSrArtoRecord, CSrIdRecord)
END_SRFIELDMAP()
/*===========================================================================
 *		End of CObRecord Field Map
 *=========================================================================*/


/*===========================================================================
 *
 * Class CSrArtoRecord Constructor
 *
 *=========================================================================*/
CSrArtoRecord::CSrArtoRecord () 
{
}
/*===========================================================================
 *		End of Class CSrArtoRecord Constructor
 *=========================================================================*/


/*===========================================================================
 *
 * Class CSrArtoRecord Method - void Destroy (void);
 *
 *=========================================================================*/
void CSrArtoRecord::Destroy (void) 
{
	CSrIdRecord::Destroy();
}
/*===========================================================================
 *		End of Class Method CSrArtoRecord::Destroy()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CSrArtoRecord Method - void InitializeNew (void);
 *
 *=========================================================================*/
void CSrArtoRecord::InitializeNew (void) 
{
	CSrIdRecord::InitializeNew();
}
/*===========================================================================
 *		End of Class Method CSrArtoRecord::InitializeNew()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CSrArtoRecord Event - void OnAddSubrecord (pSubrecord);
 *
 *=========================================================================*/
void CSrArtoRecord::OnAddSubrecord (CSrSubrecord* pSubrecord) {

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
	else
	{
		CSrIdRecord::OnAddSubrecord(pSubrecord);
	}

}
/*===========================================================================
 *		End of Class Event CSrArtoRecord::OnAddSubRecord()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CSrArtoRecord Event - void OnDeleteSubrecord (pSubrecord);
 *
 *=========================================================================*/
void CSrArtoRecord::OnDeleteSubrecord (CSrSubrecord* pSubrecord) {

	if (m_pModlData == pSubrecord)
		m_pModlData = NULL;
	else if (m_pDnamData == pSubrecord)
		m_pDnamData = NULL;
	else if (m_pModtData == pSubrecord)
		m_pModtData = NULL;
	else
		CSrIdRecord::OnDeleteSubrecord(pSubrecord);

}
/*===========================================================================
 *		End of Class Event CSrArtoRecord::OnDeleteSubrecord()
 *=========================================================================*/


/*===========================================================================
 *
 * Begin CSrArtoRecord Get Field Methods
 *
 *=========================================================================*/
/*===========================================================================
 *		End of CSrArtoRecord Get Field Methods
 *=========================================================================*/


/*===========================================================================
 *
 * Begin CSrArtoRecord Compare Field Methods
 *
 *=========================================================================*/
/*===========================================================================
 *		End of CSrArtoRecord Compare Field Methods
 *=========================================================================*/


/*===========================================================================
 *
 * Begin CSrArtoRecord Set Field Methods
 *
 *=========================================================================*/
/*===========================================================================
 *		End of CSrArtoRecord Set Field Methods
 *=========================================================================*/

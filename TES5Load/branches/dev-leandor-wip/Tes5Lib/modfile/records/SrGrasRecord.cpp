/*===========================================================================
 *
 * File:		SrGrasRecord.CPP
 * Author:		Dave Humphrey (dave@uesp.net)
 * Created On:	5 December 2011
 *
 * Description
 *
 *=========================================================================*/

	/* Include Files */
#include "srGrasrecord.h"


/*===========================================================================
 *
 * Begin Subrecord Creation Array
 *
 *=========================================================================*/
BEGIN_SRSUBRECCREATE(CSrGrasRecord, CSrIdRecord)
	DEFINE_SRSUBRECCREATE(SR_NAME_MODL, CSrDataSubrecord::Create)
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
BEGIN_SRFIELDMAP(CSrGrasRecord, CSrIdRecord)
END_SRFIELDMAP()
/*===========================================================================
 *		End of CObRecord Field Map
 *=========================================================================*/


/*===========================================================================
 *
 * Class CSrGrasRecord Constructor
 *
 *=========================================================================*/
CSrGrasRecord::CSrGrasRecord () 
{
}
/*===========================================================================
 *		End of Class CSrGrasRecord Constructor
 *=========================================================================*/


/*===========================================================================
 *
 * Class CSrGrasRecord Method - void Destroy (void);
 *
 *=========================================================================*/
void CSrGrasRecord::Destroy (void) 
{
	CSrIdRecord::Destroy();
}
/*===========================================================================
 *		End of Class Method CSrGrasRecord::Destroy()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CSrGrasRecord Method - void InitializeNew (void);
 *
 *=========================================================================*/
void CSrGrasRecord::InitializeNew (void) 
{
	CSrIdRecord::InitializeNew();
}
/*===========================================================================
 *		End of Class Method CSrGrasRecord::InitializeNew()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CSrGrasRecord Event - void OnAddSubrecord (pSubrecord);
 *
 *=========================================================================*/
void CSrGrasRecord::OnAddSubrecord (CSrSubrecord* pSubrecord) {

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
	else
	{
		CSrIdRecord::OnAddSubrecord(pSubrecord);
	}

}
/*===========================================================================
 *		End of Class Event CSrGrasRecord::OnAddSubRecord()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CSrGrasRecord Event - void OnDeleteSubrecord (pSubrecord);
 *
 *=========================================================================*/
void CSrGrasRecord::OnDeleteSubrecord (CSrSubrecord* pSubrecord) {

	if (m_pModlData == pSubrecord)
		m_pModlData = NULL;
	else if (m_pModtData == pSubrecord)
		m_pModtData = NULL;
	else if (m_pDataData == pSubrecord)
		m_pDataData = NULL;
	else
		CSrIdRecord::OnDeleteSubrecord(pSubrecord);

}
/*===========================================================================
 *		End of Class Event CSrGrasRecord::OnDeleteSubrecord()
 *=========================================================================*/


/*===========================================================================
 *
 * Begin CSrGrasRecord Get Field Methods
 *
 *=========================================================================*/
/*===========================================================================
 *		End of CSrGrasRecord Get Field Methods
 *=========================================================================*/


/*===========================================================================
 *
 * Begin CSrGrasRecord Compare Field Methods
 *
 *=========================================================================*/
/*===========================================================================
 *		End of CSrGrasRecord Compare Field Methods
 *=========================================================================*/


/*===========================================================================
 *
 * Begin CSrGrasRecord Set Field Methods
 *
 *=========================================================================*/
/*===========================================================================
 *		End of CSrGrasRecord Set Field Methods
 *=========================================================================*/

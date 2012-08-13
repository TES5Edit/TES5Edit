/*===========================================================================
 *
 * File:		SrAnioRecord.CPP
 * Author:		Dave Humphrey (dave@uesp.net)
 * Created On:	5 December 2011
 *
 * Description
 *
 *=========================================================================*/

	/* Include Files */
#include "srAniorecord.h"


/*===========================================================================
 *
 * Begin Subrecord Creation Array
 *
 *=========================================================================*/
BEGIN_SRSUBRECCREATE(CSrAnioRecord, CSrIdRecord)
	DEFINE_SRSUBRECCREATE(SR_NAME_MODL, CSrDataSubrecord::Create)
	DEFINE_SRSUBRECCREATE(SR_NAME_MODT, CSrDataSubrecord::Create)
	DEFINE_SRSUBRECCREATE(SR_NAME_BNAM, CSrDataSubrecord::Create)
END_SRSUBRECCREATE()
/*===========================================================================
 *		End of Subrecord Creation Array
 *=========================================================================*/


/*===========================================================================
 *
 * Begin CSrRecord Field Map
 *
 *=========================================================================*/
BEGIN_SRFIELDMAP(CSrAnioRecord, CSrIdRecord)
END_SRFIELDMAP()
/*===========================================================================
 *		End of CObRecord Field Map
 *=========================================================================*/


/*===========================================================================
 *
 * Class CSrAnioRecord Constructor
 *
 *=========================================================================*/
CSrAnioRecord::CSrAnioRecord () 
{
}
/*===========================================================================
 *		End of Class CSrAnioRecord Constructor
 *=========================================================================*/


/*===========================================================================
 *
 * Class CSrAnioRecord Method - void Destroy (void);
 *
 *=========================================================================*/
void CSrAnioRecord::Destroy (void) 
{
	CSrIdRecord::Destroy();
}
/*===========================================================================
 *		End of Class Method CSrAnioRecord::Destroy()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CSrAnioRecord Method - void InitializeNew (void);
 *
 *=========================================================================*/
void CSrAnioRecord::InitializeNew (void) 
{
	CSrIdRecord::InitializeNew();
}
/*===========================================================================
 *		End of Class Method CSrAnioRecord::InitializeNew()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CSrAnioRecord Event - void OnAddSubrecord (pSubrecord);
 *
 *=========================================================================*/
void CSrAnioRecord::OnAddSubrecord (CSrSubrecord* pSubrecord) {

	if (pSubrecord->GetRecordType() == SR_NAME_MODL)
	{
		m_pModlData = SrCastClass(CSrDataSubrecord, pSubrecord);
	}
	else if (pSubrecord->GetRecordType() == SR_NAME_MODT)
	{
		m_pModtData = SrCastClass(CSrDataSubrecord, pSubrecord);
	}
	else if (pSubrecord->GetRecordType() == SR_NAME_BNAM)
	{
		m_pBnamData = SrCastClass(CSrDataSubrecord, pSubrecord);
	}
	else
	{
		CSrIdRecord::OnAddSubrecord(pSubrecord);
	}

}
/*===========================================================================
 *		End of Class Event CSrAnioRecord::OnAddSubRecord()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CSrAnioRecord Event - void OnDeleteSubrecord (pSubrecord);
 *
 *=========================================================================*/
void CSrAnioRecord::OnDeleteSubrecord (CSrSubrecord* pSubrecord) {

	if (m_pModlData == pSubrecord)
		m_pModlData = NULL;
	else if (m_pModtData == pSubrecord)
		m_pModtData = NULL;
	else if (m_pBnamData == pSubrecord)
		m_pBnamData = NULL;
	else
		CSrIdRecord::OnDeleteSubrecord(pSubrecord);

}
/*===========================================================================
 *		End of Class Event CSrAnioRecord::OnDeleteSubrecord()
 *=========================================================================*/


/*===========================================================================
 *
 * Begin CSrAnioRecord Get Field Methods
 *
 *=========================================================================*/
/*===========================================================================
 *		End of CSrAnioRecord Get Field Methods
 *=========================================================================*/


/*===========================================================================
 *
 * Begin CSrAnioRecord Compare Field Methods
 *
 *=========================================================================*/
/*===========================================================================
 *		End of CSrAnioRecord Compare Field Methods
 *=========================================================================*/


/*===========================================================================
 *
 * Begin CSrAnioRecord Set Field Methods
 *
 *=========================================================================*/
/*===========================================================================
 *		End of CSrAnioRecord Set Field Methods
 *=========================================================================*/

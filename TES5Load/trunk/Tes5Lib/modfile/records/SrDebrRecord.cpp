/*===========================================================================
 *
 * File:		SrDebrRecord.CPP
 * Author:		Dave Humphrey (dave@uesp.net)
 * Created On:	5 December 2011
 *
 * Description
 *
 *=========================================================================*/

	/* Include Files */
#include "srDebrrecord.h"


/*===========================================================================
 *
 * Begin Subrecord Creation Array
 *
 *=========================================================================*/
BEGIN_SRSUBRECCREATE(CSrDebrRecord, CSrIdRecord)
	DEFINE_SRSUBRECCREATE(SR_NAME_DATA, CSrDataSubrecord::Create)
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
BEGIN_SRFIELDMAP(CSrDebrRecord, CSrIdRecord)
END_SRFIELDMAP()
/*===========================================================================
 *		End of CObRecord Field Map
 *=========================================================================*/


/*===========================================================================
 *
 * Class CSrDebrRecord Constructor
 *
 *=========================================================================*/
CSrDebrRecord::CSrDebrRecord () 
{
}
/*===========================================================================
 *		End of Class CSrDebrRecord Constructor
 *=========================================================================*/


/*===========================================================================
 *
 * Class CSrDebrRecord Method - void Destroy (void);
 *
 *=========================================================================*/
void CSrDebrRecord::Destroy (void) 
{
	CSrIdRecord::Destroy();
}
/*===========================================================================
 *		End of Class Method CSrDebrRecord::Destroy()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CSrDebrRecord Method - void InitializeNew (void);
 *
 *=========================================================================*/
void CSrDebrRecord::InitializeNew (void) 
{
	CSrIdRecord::InitializeNew();
}
/*===========================================================================
 *		End of Class Method CSrDebrRecord::InitializeNew()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CSrDebrRecord Event - void OnAddSubrecord (pSubrecord);
 *
 *=========================================================================*/
void CSrDebrRecord::OnAddSubrecord (CSrSubrecord* pSubrecord) {

	if (pSubrecord->GetRecordType() == SR_NAME_DATA)
	{
		m_pDataData = SrCastClass(CSrDataSubrecord, pSubrecord);
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
 *		End of Class Event CSrDebrRecord::OnAddSubRecord()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CSrDebrRecord Event - void OnDeleteSubrecord (pSubrecord);
 *
 *=========================================================================*/
void CSrDebrRecord::OnDeleteSubrecord (CSrSubrecord* pSubrecord) {

	if (m_pDataData == pSubrecord)
		m_pDataData = NULL;
	else if (m_pModtData == pSubrecord)
		m_pModtData = NULL;
	else
		CSrIdRecord::OnDeleteSubrecord(pSubrecord);

}
/*===========================================================================
 *		End of Class Event CSrDebrRecord::OnDeleteSubrecord()
 *=========================================================================*/


/*===========================================================================
 *
 * Begin CSrDebrRecord Get Field Methods
 *
 *=========================================================================*/
/*===========================================================================
 *		End of CSrDebrRecord Get Field Methods
 *=========================================================================*/


/*===========================================================================
 *
 * Begin CSrDebrRecord Compare Field Methods
 *
 *=========================================================================*/
/*===========================================================================
 *		End of CSrDebrRecord Compare Field Methods
 *=========================================================================*/


/*===========================================================================
 *
 * Begin CSrDebrRecord Set Field Methods
 *
 *=========================================================================*/
/*===========================================================================
 *		End of CSrDebrRecord Set Field Methods
 *=========================================================================*/

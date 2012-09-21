/*===========================================================================
 *
 * File:		SrEqupRecord.CPP
 * Author:		Dave Humphrey (dave@uesp.net)
 * Created On:	5 December 2011
 *
 * Description
 *
 *=========================================================================*/

	/* Include Files */
#include "srEquprecord.h"


/*===========================================================================
 *
 * Begin Subrecord Creation Array
 *
 *=========================================================================*/
BEGIN_SRSUBRECCREATE(CSrEqupRecord, CSrIdRecord)
	DEFINE_SRSUBRECCREATE(SR_NAME_DATA, CSrDataSubrecord::Create)
	DEFINE_SRSUBRECCREATE(SR_NAME_PNAM, CSrDataSubrecord::Create)
END_SRSUBRECCREATE()
/*===========================================================================
 *		End of Subrecord Creation Array
 *=========================================================================*/


/*===========================================================================
 *
 * Begin CSrRecord Field Map
 *
 *=========================================================================*/
BEGIN_SRFIELDMAP(CSrEqupRecord, CSrIdRecord)
END_SRFIELDMAP()
/*===========================================================================
 *		End of CObRecord Field Map
 *=========================================================================*/


/*===========================================================================
 *
 * Class CSrEqupRecord Constructor
 *
 *=========================================================================*/
CSrEqupRecord::CSrEqupRecord () 
{
}
/*===========================================================================
 *		End of Class CSrEqupRecord Constructor
 *=========================================================================*/


/*===========================================================================
 *
 * Class CSrEqupRecord Method - void Destroy (void);
 *
 *=========================================================================*/
void CSrEqupRecord::Destroy (void) 
{
	CSrIdRecord::Destroy();
}
/*===========================================================================
 *		End of Class Method CSrEqupRecord::Destroy()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CSrEqupRecord Method - void InitializeNew (void);
 *
 *=========================================================================*/
void CSrEqupRecord::InitializeNew (void) 
{
	CSrIdRecord::InitializeNew();
}
/*===========================================================================
 *		End of Class Method CSrEqupRecord::InitializeNew()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CSrEqupRecord Event - void OnAddSubrecord (pSubrecord);
 *
 *=========================================================================*/
void CSrEqupRecord::OnAddSubrecord (CSrSubrecord* pSubrecord) {

	if (pSubrecord->GetRecordType() == SR_NAME_DATA)
	{
		m_pDataData = SrCastClass(CSrDataSubrecord, pSubrecord);
	}
	else if (pSubrecord->GetRecordType() == SR_NAME_PNAM)
	{
		m_pPnamData = SrCastClass(CSrDataSubrecord, pSubrecord);
	}
	else
	{
		CSrIdRecord::OnAddSubrecord(pSubrecord);
	}

}
/*===========================================================================
 *		End of Class Event CSrEqupRecord::OnAddSubRecord()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CSrEqupRecord Event - void OnDeleteSubrecord (pSubrecord);
 *
 *=========================================================================*/
void CSrEqupRecord::OnDeleteSubrecord (CSrSubrecord* pSubrecord) {

	if (m_pDataData == pSubrecord)
		m_pDataData = NULL;
	else if (m_pPnamData == pSubrecord)
		m_pPnamData = NULL;
	else
		CSrIdRecord::OnDeleteSubrecord(pSubrecord);

}
/*===========================================================================
 *		End of Class Event CSrEqupRecord::OnDeleteSubrecord()
 *=========================================================================*/


/*===========================================================================
 *
 * Begin CSrEqupRecord Get Field Methods
 *
 *=========================================================================*/
/*===========================================================================
 *		End of CSrEqupRecord Get Field Methods
 *=========================================================================*/


/*===========================================================================
 *
 * Begin CSrEqupRecord Compare Field Methods
 *
 *=========================================================================*/
/*===========================================================================
 *		End of CSrEqupRecord Compare Field Methods
 *=========================================================================*/


/*===========================================================================
 *
 * Begin CSrEqupRecord Set Field Methods
 *
 *=========================================================================*/
/*===========================================================================
 *		End of CSrEqupRecord Set Field Methods
 *=========================================================================*/

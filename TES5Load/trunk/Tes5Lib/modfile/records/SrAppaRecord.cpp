/*===========================================================================
 *
 * File:		SrAppaRecord.CPP
 * Author:		Dave Humphrey (dave@uesp.net)
 * Created On:	5 December 2011
 *
 * Description
 *
 *=========================================================================*/

	/* Include Files */
#include "srApparecord.h"


/*===========================================================================
 *
 * Begin Subrecord Creation Array
 *
 *=========================================================================*/
BEGIN_SRSUBRECCREATE(CSrAppaRecord, CSrItem1Record)
	DEFINE_SRSUBRECCREATE(SR_NAME_DESC, CSrDataSubrecord::Create)
	DEFINE_SRSUBRECCREATE(SR_NAME_QUAL, CSrDataSubrecord::Create)
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
BEGIN_SRFIELDMAP(CSrAppaRecord, CSrItem1Record)
END_SRFIELDMAP()
/*===========================================================================
 *		End of CObRecord Field Map
 *=========================================================================*/


/*===========================================================================
 *
 * Class CSrAppaRecord Constructor
 *
 *=========================================================================*/
CSrAppaRecord::CSrAppaRecord () 
{
}
/*===========================================================================
 *		End of Class CSrAppaRecord Constructor
 *=========================================================================*/


/*===========================================================================
 *
 * Class CSrAppaRecord Method - void Destroy (void);
 *
 *=========================================================================*/
void CSrAppaRecord::Destroy (void) 
{
	CSrItem1Record::Destroy();
}
/*===========================================================================
 *		End of Class Method CSrAppaRecord::Destroy()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CSrAppaRecord Method - void InitializeNew (void);
 *
 *=========================================================================*/
void CSrAppaRecord::InitializeNew (void) 
{
	CSrItem1Record::InitializeNew();
}
/*===========================================================================
 *		End of Class Method CSrAppaRecord::InitializeNew()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CSrAppaRecord Event - void OnAddSubrecord (pSubrecord);
 *
 *=========================================================================*/
void CSrAppaRecord::OnAddSubrecord (CSrSubrecord* pSubrecord) {

	 if (pSubrecord->GetRecordType() == SR_NAME_DESC)
	{
		m_pDescData = SrCastClass(CSrDataSubrecord, pSubrecord);
	}
	else if (pSubrecord->GetRecordType() == SR_NAME_QUAL)
	{
		m_pQualData = SrCastClass(CSrDataSubrecord, pSubrecord);
	}
	else if (pSubrecord->GetRecordType() == SR_NAME_DATA)
	{
		m_pDataData = SrCastClass(CSrDataSubrecord, pSubrecord);
	}
	else
	{
		CSrItem1Record::OnAddSubrecord(pSubrecord);
	}

}
/*===========================================================================
 *		End of Class Event CSrAppaRecord::OnAddSubRecord()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CSrAppaRecord Event - void OnDeleteSubrecord (pSubrecord);
 *
 *=========================================================================*/
void CSrAppaRecord::OnDeleteSubrecord (CSrSubrecord* pSubrecord) {

	if (m_pDescData == pSubrecord)
		m_pDescData = NULL;
	else if (m_pQualData == pSubrecord)
		m_pQualData = NULL;
	else if (m_pDataData == pSubrecord)
		m_pDataData = NULL;
	else
		CSrItem1Record::OnDeleteSubrecord(pSubrecord);

}
/*===========================================================================
 *		End of Class Event CSrAppaRecord::OnDeleteSubrecord()
 *=========================================================================*/


/*===========================================================================
 *
 * Begin CSrAppaRecord Get Field Methods
 *
 *=========================================================================*/
/*===========================================================================
 *		End of CSrAppaRecord Get Field Methods
 *=========================================================================*/


/*===========================================================================
 *
 * Begin CSrAppaRecord Compare Field Methods
 *
 *=========================================================================*/
/*===========================================================================
 *		End of CSrAppaRecord Compare Field Methods
 *=========================================================================*/


/*===========================================================================
 *
 * Begin CSrAppaRecord Set Field Methods
 *
 *=========================================================================*/
/*===========================================================================
 *		End of CSrAppaRecord Set Field Methods
 *=========================================================================*/

/*===========================================================================
 *
 * File:		SrFstsRecord.CPP
 * Author:		Dave Humphrey (dave@uesp.net)
 * Created On:	5 December 2011
 *
 * Description
 *
 *=========================================================================*/

	/* Include Files */
#include "srFstsrecord.h"


/*===========================================================================
 *
 * Begin Subrecord Creation Array
 *
 *=========================================================================*/
BEGIN_SRSUBRECCREATE(CSrFstsRecord, CSrIdRecord)
	DEFINE_SRSUBRECCREATE(SR_NAME_XCNT, CSrDataSubrecord::Create)
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
BEGIN_SRFIELDMAP(CSrFstsRecord, CSrIdRecord)
END_SRFIELDMAP()
/*===========================================================================
 *		End of CObRecord Field Map
 *=========================================================================*/


/*===========================================================================
 *
 * Class CSrFstsRecord Constructor
 *
 *=========================================================================*/
CSrFstsRecord::CSrFstsRecord () 
{
}
/*===========================================================================
 *		End of Class CSrFstsRecord Constructor
 *=========================================================================*/


/*===========================================================================
 *
 * Class CSrFstsRecord Method - void Destroy (void);
 *
 *=========================================================================*/
void CSrFstsRecord::Destroy (void) 
{
	CSrIdRecord::Destroy();
}
/*===========================================================================
 *		End of Class Method CSrFstsRecord::Destroy()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CSrFstsRecord Method - void InitializeNew (void);
 *
 *=========================================================================*/
void CSrFstsRecord::InitializeNew (void) 
{
	CSrIdRecord::InitializeNew();
}
/*===========================================================================
 *		End of Class Method CSrFstsRecord::InitializeNew()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CSrFstsRecord Event - void OnAddSubrecord (pSubrecord);
 *
 *=========================================================================*/
void CSrFstsRecord::OnAddSubrecord (CSrSubrecord* pSubrecord) {

	if (pSubrecord->GetRecordType() == SR_NAME_XCNT)
	{
		m_pXcntData = SrCastClass(CSrDataSubrecord, pSubrecord);
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
 *		End of Class Event CSrFstsRecord::OnAddSubRecord()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CSrFstsRecord Event - void OnDeleteSubrecord (pSubrecord);
 *
 *=========================================================================*/
void CSrFstsRecord::OnDeleteSubrecord (CSrSubrecord* pSubrecord) {

	if (m_pXcntData == pSubrecord)
		m_pXcntData = NULL;
	else if (m_pDataData == pSubrecord)
		m_pDataData = NULL;
	else
		CSrIdRecord::OnDeleteSubrecord(pSubrecord);

}
/*===========================================================================
 *		End of Class Event CSrFstsRecord::OnDeleteSubrecord()
 *=========================================================================*/


/*===========================================================================
 *
 * Begin CSrFstsRecord Get Field Methods
 *
 *=========================================================================*/
/*===========================================================================
 *		End of CSrFstsRecord Get Field Methods
 *=========================================================================*/


/*===========================================================================
 *
 * Begin CSrFstsRecord Compare Field Methods
 *
 *=========================================================================*/
/*===========================================================================
 *		End of CSrFstsRecord Compare Field Methods
 *=========================================================================*/


/*===========================================================================
 *
 * Begin CSrFstsRecord Set Field Methods
 *
 *=========================================================================*/
/*===========================================================================
 *		End of CSrFstsRecord Set Field Methods
 *=========================================================================*/

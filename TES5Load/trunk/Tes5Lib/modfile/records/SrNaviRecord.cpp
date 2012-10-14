/*===========================================================================
 *
 * File:		SrNaviRecord.CPP
 * Author:		Dave Humphrey (dave@uesp.net)
 * Created On:	5 December 2011
 *
 * Description
 *
 *=========================================================================*/

	/* Include Files */
#include "srNavirecord.h"


/*===========================================================================
 *
 * Begin Subrecord Creation Array
 *
 *=========================================================================*/
BEGIN_SRSUBRECCREATE(CSrNaviRecord, CSrRecord)
	DEFINE_SRSUBRECCREATE(SR_NAME_NVER, CSrDataSubrecord::Create)
	DEFINE_SRSUBRECCREATE(SR_NAME_NVMI, CSrDataSubrecord::Create)
	DEFINE_SRSUBRECCREATE(SR_NAME_NVPP, CSrDataSubrecord::Create)

END_SRSUBRECCREATE()
/*===========================================================================
 *		End of Subrecord Creation Array
 *=========================================================================*/


/*===========================================================================
 *
 * Begin CSrRecord Field Map
 *
 *=========================================================================*/
BEGIN_SRFIELDMAP(CSrNaviRecord, CSrRecord)
END_SRFIELDMAP()
/*===========================================================================
 *		End of CObRecord Field Map
 *=========================================================================*/


/*===========================================================================
 *
 * Class CSrNaviRecord Constructor
 *
 *=========================================================================*/
CSrNaviRecord::CSrNaviRecord () 
{
}
/*===========================================================================
 *		End of Class CSrNaviRecord Constructor
 *=========================================================================*/


/*===========================================================================
 *
 * Class CSrNaviRecord Method - void Destroy (void);
 *
 *=========================================================================*/
void CSrNaviRecord::Destroy (void) 
{
	CSrRecord::Destroy();
}
/*===========================================================================
 *		End of Class Method CSrNaviRecord::Destroy()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CSrNaviRecord Method - void InitializeNew (void);
 *
 *=========================================================================*/
void CSrNaviRecord::InitializeNew (void) 
{

	/* Call the base class method first */
	CSrRecord::InitializeNew();


}
/*===========================================================================
 *		End of Class Method CSrNaviRecord::InitializeNew()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CSrNaviRecord Event - void OnAddSubrecord (pSubrecord);
 *
 *=========================================================================*/
void CSrNaviRecord::OnAddSubrecord (CSrSubrecord* pSubrecord) {

	if (pSubrecord->GetRecordType() == SR_NAME_NVER)
	{
		m_pNverData = SrCastClass(CSrDataSubrecord, pSubrecord);
	}
	else if (pSubrecord->GetRecordType() == SR_NAME_NVMI)
	{
		m_pNvmiData = SrCastClass(CSrDataSubrecord, pSubrecord);
	}
	else if (pSubrecord->GetRecordType() == SR_NAME_NVPP)
	{
		m_pNvppData = SrCastClass(CSrDataSubrecord, pSubrecord);
	}

	else
	{
	CSrRecord::OnAddSubrecord(pSubrecord);
	}

}
/*===========================================================================
 *		End of Class Event CSrNaviRecord::OnAddSubRecord()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CSrNaviRecord Event - void OnDeleteSubrecord (pSubrecord);
 *
 *=========================================================================*/
void CSrNaviRecord::OnDeleteSubrecord (CSrSubrecord* pSubrecord) {

	if (m_pNverData == pSubrecord)
		m_pNverData = NULL;
	else if (m_pNvmiData == pSubrecord)
		m_pNvmiData = NULL;
	else if (m_pNvppData == pSubrecord)
		m_pNvppData = NULL;

	else
		CSrRecord::OnDeleteSubrecord(pSubrecord);

}
/*===========================================================================
 *		End of Class Event CSrNaviRecord::OnDeleteSubrecord()
 *=========================================================================*/


/*===========================================================================
 *
 * Begin CSrNaviRecord Get Field Methods
 *
 *=========================================================================*/
/*===========================================================================
 *		End of CSrNaviRecord Get Field Methods
 *=========================================================================*/


/*===========================================================================
 *
 * Begin CSrNaviRecord Compare Field Methods
 *
 *=========================================================================*/
/*===========================================================================
 *		End of CSrNaviRecord Compare Field Methods
 *=========================================================================*/


/*===========================================================================
 *
 * Begin CSrNaviRecord Set Field Methods
 *
 *=========================================================================*/
/*===========================================================================
 *		End of CSrNaviRecord Set Field Methods
 *=========================================================================*/

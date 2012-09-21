/*===========================================================================
 *
 * File:		SrLgtmRecord.CPP
 * Author:		Dave Humphrey (dave@uesp.net)
 * Created On:	5 December 2011
 *
 * Description
 *
 *=========================================================================*/

	/* Include Files */
#include "srLgtmrecord.h"


/*===========================================================================
 *
 * Begin Subrecord Creation Array
 *
 *=========================================================================*/
BEGIN_SRSUBRECCREATE(CSrLgtmRecord, CSrIdRecord)
	DEFINE_SRSUBRECCREATE(SR_NAME_DATA, CSrDataSubrecord::Create)
	DEFINE_SRSUBRECCREATE(SR_NAME_DALC, CSrDataSubrecord::Create)
END_SRSUBRECCREATE()
/*===========================================================================
 *		End of Subrecord Creation Array
 *=========================================================================*/


/*===========================================================================
 *
 * Begin CSrIdRecord Field Map
 *
 *=========================================================================*/
BEGIN_SRFIELDMAP(CSrLgtmRecord, CSrIdRecord)
END_SRFIELDMAP()
/*===========================================================================
 *		End of CObRecord Field Map
 *=========================================================================*/


/*===========================================================================
 *
 * Class CSrLgtmRecord Constructor
 *
 *=========================================================================*/
CSrLgtmRecord::CSrLgtmRecord () 
{
}
/*===========================================================================
 *		End of Class CSrLgtmRecord Constructor
 *=========================================================================*/


/*===========================================================================
 *
 * Class CSrLgtmRecord Method - void Destroy (void);
 *
 *=========================================================================*/
void CSrLgtmRecord::Destroy (void) 
{
	CSrIdRecord::Destroy();
}
/*===========================================================================
 *		End of Class Method CSrLgtmRecord::Destroy()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CSrLgtmRecord Method - void InitializeNew (void);
 *
 *=========================================================================*/
void CSrLgtmRecord::InitializeNew (void) 
{
	CSrIdRecord::InitializeNew();
}
/*===========================================================================
 *		End of Class Method CSrLgtmRecord::InitializeNew()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CSrLgtmRecord Event - void OnAddSubrecord (pSubrecord);
 *
 *=========================================================================*/
void CSrLgtmRecord::OnAddSubrecord (CSrSubrecord* pSubrecord) {

	if (pSubrecord->GetRecordType() == SR_NAME_DATA)
	{
		m_pDataData = SrCastClass(CSrDataSubrecord, pSubrecord);
	}
	else if (pSubrecord->GetRecordType() == SR_NAME_DALC)
	{
		m_pDalcData = SrCastClass(CSrDataSubrecord, pSubrecord);
	}
	else
	{
		CSrIdRecord::OnAddSubrecord(pSubrecord);
	}

}
/*===========================================================================
 *		End of Class Event CSrLgtmRecord::OnAddSubRecord()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CSrLgtmRecord Event - void OnDeleteSubrecord (pSubrecord);
 *
 *=========================================================================*/
void CSrLgtmRecord::OnDeleteSubrecord (CSrSubrecord* pSubrecord) {

	if (m_pDataData == pSubrecord)
		m_pDataData = NULL;
	else if (m_pDalcData == pSubrecord)
		m_pDalcData = NULL;
	else
		CSrIdRecord::OnDeleteSubrecord(pSubrecord);

}
/*===========================================================================
 *		End of Class Event CSrLgtmRecord::OnDeleteSubrecord()
 *=========================================================================*/


/*===========================================================================
 *
 * Begin CSrLgtmRecord Get Field Methods
 *
 *=========================================================================*/
/*===========================================================================
 *		End of CSrLgtmRecord Get Field Methods
 *=========================================================================*/


/*===========================================================================
 *
 * Begin CSrLgtmRecord Compare Field Methods
 *
 *=========================================================================*/
/*===========================================================================
 *		End of CSrLgtmRecord Compare Field Methods
 *=========================================================================*/


/*===========================================================================
 *
 * Begin CSrLgtmRecord Set Field Methods
 *
 *=========================================================================*/
/*===========================================================================
 *		End of CSrLgtmRecord Set Field Methods
 *=========================================================================*/

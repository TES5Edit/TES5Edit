/*===========================================================================
 *
 * File:		SrFstpRecord.CPP
 * Author:		Dave Humphrey (dave@uesp.net)
 * Created On:	5 December 2011
 *
 * Description
 *
 *=========================================================================*/

	/* Include Files */
#include "srFstprecord.h"


/*===========================================================================
 *
 * Begin Subrecord Creation Array
 *
 *=========================================================================*/
BEGIN_SRSUBRECCREATE(CSrFstpRecord, CSrIdRecord)
	DEFINE_SRSUBRECCREATE(SR_NAME_ANAM, CSrDataSubrecord::Create)
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
BEGIN_SRFIELDMAP(CSrFstpRecord, CSrIdRecord)
END_SRFIELDMAP()
/*===========================================================================
 *		End of CObRecord Field Map
 *=========================================================================*/


/*===========================================================================
 *
 * Class CSrFstpRecord Constructor
 *
 *=========================================================================*/
CSrFstpRecord::CSrFstpRecord () 
{
}
/*===========================================================================
 *		End of Class CSrFstpRecord Constructor
 *=========================================================================*/


/*===========================================================================
 *
 * Class CSrFstpRecord Method - void Destroy (void);
 *
 *=========================================================================*/
void CSrFstpRecord::Destroy (void) 
{
	CSrIdRecord::Destroy();
}
/*===========================================================================
 *		End of Class Method CSrFstpRecord::Destroy()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CSrFstpRecord Method - void InitializeNew (void);
 *
 *=========================================================================*/
void CSrFstpRecord::InitializeNew (void) 
{
	CSrIdRecord::InitializeNew();
}
/*===========================================================================
 *		End of Class Method CSrFstpRecord::InitializeNew()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CSrFstpRecord Event - void OnAddSubrecord (pSubrecord);
 *
 *=========================================================================*/
void CSrFstpRecord::OnAddSubrecord (CSrSubrecord* pSubrecord) {

	if (pSubrecord->GetRecordType() == SR_NAME_ANAM)
	{
		m_pAnamData = SrCastClass(CSrDataSubrecord, pSubrecord);
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
 *		End of Class Event CSrFstpRecord::OnAddSubRecord()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CSrFstpRecord Event - void OnDeleteSubrecord (pSubrecord);
 *
 *=========================================================================*/
void CSrFstpRecord::OnDeleteSubrecord (CSrSubrecord* pSubrecord) {

	if (m_pAnamData == pSubrecord)
		m_pAnamData = NULL;
	else if (m_pDataData == pSubrecord)
		m_pDataData = NULL;
	else
		CSrIdRecord::OnDeleteSubrecord(pSubrecord);

}
/*===========================================================================
 *		End of Class Event CSrFstpRecord::OnDeleteSubrecord()
 *=========================================================================*/


/*===========================================================================
 *
 * Begin CSrFstpRecord Get Field Methods
 *
 *=========================================================================*/
/*===========================================================================
 *		End of CSrFstpRecord Get Field Methods
 *=========================================================================*/


/*===========================================================================
 *
 * Begin CSrFstpRecord Compare Field Methods
 *
 *=========================================================================*/
/*===========================================================================
 *		End of CSrFstpRecord Compare Field Methods
 *=========================================================================*/


/*===========================================================================
 *
 * Begin CSrFstpRecord Set Field Methods
 *
 *=========================================================================*/
/*===========================================================================
 *		End of CSrFstpRecord Set Field Methods
 *=========================================================================*/

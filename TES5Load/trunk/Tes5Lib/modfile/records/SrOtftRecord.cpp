/*===========================================================================
 *
 * File:		SrOtftRecord.CPP
 * Author:		Dave Humphrey (dave@uesp.net)
 * Created On:	5 December 2011
 *
 * Description
 *
 *=========================================================================*/

	/* Include Files */
#include "srotftrecord.h"


/*===========================================================================
 *
 * Begin Subrecord Creation Array
 *
 *=========================================================================*/
BEGIN_SRSUBRECCREATE(CSrOtftRecord, CSrIdRecord)
	DEFINE_SRSUBRECCREATE(SR_NAME_INAM, CSrFormidArraySubrecord::Create)
END_SRSUBRECCREATE()
/*===========================================================================
 *		End of Subrecord Creation Array
 *=========================================================================*/


/*===========================================================================
 *
 * Begin CSrIdRecord Field Map
 *
 *=========================================================================*/
BEGIN_SRFIELDMAP(CSrOtftRecord, CSrIdRecord)
	ADD_SRFIELDALL("ItemCount",		SR_FIELD_ITEMCOUNT,		0, CSrOtftRecord, FieldItemCount)
END_SRFIELDMAP()
/*===========================================================================
 *		End of CObRecord Field Map
 *=========================================================================*/


/*===========================================================================
 *
 * Class CSrOtftRecord Constructor
 *
 *=========================================================================*/
CSrOtftRecord::CSrOtftRecord () 
{
	m_pItems = NULL;
}
/*===========================================================================
 *		End of Class CSrOtftRecord Constructor
 *=========================================================================*/


/*===========================================================================
 *
 * Class CSrOtftRecord Method - void Destroy (void);
 *
 *=========================================================================*/
void CSrOtftRecord::Destroy (void) 
{
	m_pItems = NULL;

	CSrIdRecord::Destroy();
}
/*===========================================================================
 *		End of Class Method CSrOtftRecord::Destroy()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CSrOtftRecord Method - void InitializeNew (void);
 *
 *=========================================================================*/
void CSrOtftRecord::InitializeNew (void) 
{
	CSrIdRecord::InitializeNew();

	AddNewSubrecord(SR_NAME_INAM);
	if (m_pItems != NULL) m_pItems->InitializeNew();

}
/*===========================================================================
 *		End of Class Method CSrOtftRecord::InitializeNew()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CSrOtftRecord Event - void OnAddSubrecord (pSubrecord);
 *
 *=========================================================================*/
void CSrOtftRecord::OnAddSubrecord (CSrSubrecord* pSubrecord) {

	if (pSubrecord->GetRecordType() == SR_NAME_INAM)
	{
		m_pItems = SrCastClass(CSrFormidArraySubrecord, pSubrecord);
	}
	else
	{
		CSrIdRecord::OnAddSubrecord(pSubrecord);
	}

}
/*===========================================================================
 *		End of Class Event CSrOtftRecord::OnAddSubRecord()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CSrOtftRecord Event - void OnDeleteSubrecord (pSubrecord);
 *
 *=========================================================================*/
void CSrOtftRecord::OnDeleteSubrecord (CSrSubrecord* pSubrecord) {

	if (m_pItems == pSubrecord)
		m_pItems = NULL;
	else
		CSrIdRecord::OnDeleteSubrecord(pSubrecord);

}
/*===========================================================================
 *		End of Class Event CSrOtftRecord::OnDeleteSubrecord()
 *=========================================================================*/


/*===========================================================================
 *
 * Begin CSrOtftRecord Get Field Methods
 *
 *=========================================================================*/
/*===========================================================================
 *		End of CSrOtftRecord Get Field Methods
 *=========================================================================*/


/*===========================================================================
 *
 * Begin CSrOtftRecord Compare Field Methods
 *
 *=========================================================================*/
/*===========================================================================
 *		End of CSrOtftRecord Compare Field Methods
 *=========================================================================*/


/*===========================================================================
 *
 * Begin CSrOtftRecord Set Field Methods
 *
 *=========================================================================*/
/*===========================================================================
 *		End of CSrOtftRecord Set Field Methods
 *=========================================================================*/

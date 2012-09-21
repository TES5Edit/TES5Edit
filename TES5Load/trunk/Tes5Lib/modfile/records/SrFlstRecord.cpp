/*===========================================================================
 *
 * File:		SrFlstRecord.CPP
 * Author:		Dave Humphrey (dave@uesp.net)
 * Created On:	5 December 2011
 *
 * Description
 *
 *=========================================================================*/

	/* Include Files */
#include "srFlstrecord.h"


/*===========================================================================
 *
 * Begin Subrecord Creation Array
 *
 *=========================================================================*/
BEGIN_SRSUBRECCREATE(CSrFlstRecord, CSrIdRecord)
	DEFINE_SRSUBRECCREATE(SR_NAME_LNAM, CSrFormidSubrecord::Create)
END_SRSUBRECCREATE()
/*===========================================================================
 *		End of Subrecord Creation Array
 *=========================================================================*/


/*===========================================================================
 *
 * Begin CSrRecord Field Map
 *
 *=========================================================================*/
BEGIN_SRFIELDMAP(CSrFlstRecord, CSrIdRecord)
	ADD_SRFIELDALL("ItemCount",		SR_FIELD_ITEMCOUNT,	0,	CSrFlstRecord, FieldItemCount)
END_SRFIELDMAP()
/*===========================================================================
 *		End of CObRecord Field Map
 *=========================================================================*/


/*===========================================================================
 *
 * Class CSrFlstRecord Constructor
 *
 *=========================================================================*/
CSrFlstRecord::CSrFlstRecord () 
{
}
/*===========================================================================
 *		End of Class CSrFlstRecord Constructor
 *=========================================================================*/


/*===========================================================================
 *
 * Class CSrFlstRecord Method - void Destroy (void);
 *
 *=========================================================================*/
void CSrFlstRecord::Destroy (void) 
{
	CSrIdRecord::Destroy();
}
/*===========================================================================
 *		End of Class Method CSrFlstRecord::Destroy()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CSrFlstRecord Method - void InitializeNew (void);
 *
 *=========================================================================*/
void CSrFlstRecord::InitializeNew (void) 
{
	CSrIdRecord::InitializeNew();
}
/*===========================================================================
 *		End of Class Method CSrFlstRecord::InitializeNew()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CSrFlstRecord Event - void OnAddSubrecord (pSubrecord);
 *
 *=========================================================================*/
void CSrFlstRecord::OnAddSubrecord (CSrSubrecord* pSubrecord) 
{
	CSrIdRecord::OnAddSubrecord(pSubrecord);
}
/*===========================================================================
 *		End of Class Event CSrFlstRecord::OnAddSubRecord()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CSrFlstRecord Event - void OnDeleteSubrecord (pSubrecord);
 *
 *=========================================================================*/
void CSrFlstRecord::OnDeleteSubrecord (CSrSubrecord* pSubrecord) 
{
	CSrIdRecord::OnDeleteSubrecord(pSubrecord);
}
/*===========================================================================
 *		End of Class Event CSrFlstRecord::OnDeleteSubrecord()
 *=========================================================================*/


void CSrFlstRecord::AddItem (const srformid_t FormID)
{
	CSrSubrecord* pSubrecord = AddNewSubrecord(SR_NAME_LNAM);
	CSrFormidSubrecord* pFormID = SrCastClassNull(CSrFormidSubrecord, pSubrecord);

	if (pFormID != NULL) 
	{
		pFormID->InitializeNew();
		pFormID->SetValue(FormID);
	}
}


/*===========================================================================
 *
 * Begin CSrFlstRecord Get Field Methods
 *
 *=========================================================================*/
/*===========================================================================
 *		End of CSrFlstRecord Get Field Methods
 *=========================================================================*/


/*===========================================================================
 *
 * Begin CSrFlstRecord Compare Field Methods
 *
 *=========================================================================*/
/*===========================================================================
 *		End of CSrFlstRecord Compare Field Methods
 *=========================================================================*/


/*===========================================================================
 *
 * Begin CSrFlstRecord Set Field Methods
 *
 *=========================================================================*/
/*===========================================================================
 *		End of CSrFlstRecord Set Field Methods
 *=========================================================================*/

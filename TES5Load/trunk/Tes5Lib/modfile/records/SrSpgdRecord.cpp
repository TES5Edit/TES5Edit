/*===========================================================================
 *
 * File:		SrSpgdRecord.CPP
 * Author:		Dave Humphrey (dave@uesp.net)
 * Created On:	5 December 2011
 *
 * Description
 *
 *=========================================================================*/

	/* Include Files */
#include "srSpgdrecord.h"


/*===========================================================================
 *
 * Begin Subrecord Creation Array
 *
 *=========================================================================*/
BEGIN_SRSUBRECCREATE(CSrSpgdRecord, CSrIdRecord)
	DEFINE_SRSUBRECCREATE(SR_NAME_ICON, CSrDataSubrecord::Create)
	DEFINE_SRSUBRECCREATE(SR_NAME_DATA, CSrDataSubrecord::Create)

END_SRSUBRECCREATE()
/*===========================================================================
 *		End of Subrecord Creation Array
 *=========================================================================*/


/*===========================================================================
 *
 * Begin CSrIdRecord Field Map
 *
 *=========================================================================*/
BEGIN_SRFIELDMAP(CSrSpgdRecord, CSrIdRecord)
END_SRFIELDMAP()
/*===========================================================================
 *		End of CObRecord Field Map
 *=========================================================================*/


/*===========================================================================
 *
 * Class CSrSpgdRecord Constructor
 *
 *=========================================================================*/
CSrSpgdRecord::CSrSpgdRecord () 
{
}
/*===========================================================================
 *		End of Class CSrSpgdRecord Constructor
 *=========================================================================*/


/*===========================================================================
 *
 * Class CSrSpgdRecord Method - void Destroy (void);
 *
 *=========================================================================*/
void CSrSpgdRecord::Destroy (void) 
{
	CSrIdRecord::Destroy();
}
/*===========================================================================
 *		End of Class Method CSrSpgdRecord::Destroy()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CSrSpgdRecord Method - void InitializeNew (void);
 *
 *=========================================================================*/
void CSrSpgdRecord::InitializeNew (void) 
{

	/* Call the base class method first */
	CSrIdRecord::InitializeNew();


}
/*===========================================================================
 *		End of Class Method CSrSpgdRecord::InitializeNew()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CSrSpgdRecord Event - void OnAddSubrecord (pSubrecord);
 *
 *=========================================================================*/
void CSrSpgdRecord::OnAddSubrecord (CSrSubrecord* pSubrecord) {

	if (pSubrecord->GetRecordType() == SR_NAME_ICON)
	{
		m_pIconData = SrCastClass(CSrDataSubrecord, pSubrecord);
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
 *		End of Class Event CSrSpgdRecord::OnAddSubRecord()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CSrSpgdRecord Event - void OnDeleteSubrecord (pSubrecord);
 *
 *=========================================================================*/
void CSrSpgdRecord::OnDeleteSubrecord (CSrSubrecord* pSubrecord) {

	if (m_pIconData == pSubrecord)
		m_pIconData = NULL;

	else if (m_pDataData == pSubrecord)
		m_pDataData = NULL;

	else
		CSrIdRecord::OnDeleteSubrecord(pSubrecord);

}
/*===========================================================================
 *		End of Class Event CSrSpgdRecord::OnDeleteSubrecord()
 *=========================================================================*/


/*===========================================================================
 *
 * Begin CSrSpgdRecord Get Field Methods
 *
 *=========================================================================*/
/*===========================================================================
 *		End of CSrSpgdRecord Get Field Methods
 *=========================================================================*/


/*===========================================================================
 *
 * Begin CSrSpgdRecord Compare Field Methods
 *
 *=========================================================================*/
/*===========================================================================
 *		End of CSrSpgdRecord Compare Field Methods
 *=========================================================================*/


/*===========================================================================
 *
 * Begin CSrSpgdRecord Set Field Methods
 *
 *=========================================================================*/
/*===========================================================================
 *		End of CSrSpgdRecord Set Field Methods
 *=========================================================================*/

/*===========================================================================
 *
 * File:		SrPgreRecord.CPP
 * Author:		Dave Humphrey (dave@uesp.net)
 * Created On:	5 December 2011
 *
 * Description
 *
 *=========================================================================*/

	/* Include Files */
#include "srPgrerecord.h"


/*===========================================================================
 *
 * Begin Subrecord Creation Array
 *
 *=========================================================================*/
BEGIN_SRSUBRECCREATE(CSrPgreRecord, CSrRecord)
	DEFINE_SRSUBRECCREATE(SR_NAME_XSCL, CSrDataSubrecord::Create)
	DEFINE_SRSUBRECCREATE(SR_NAME_NAME, CSrDataSubrecord::Create)
	DEFINE_SRSUBRECCREATE(SR_NAME_XESP, CSrDataSubrecord::Create)
	DEFINE_SRSUBRECCREATE(SR_NAME_XOWN, CSrDataSubrecord::Create)
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
BEGIN_SRFIELDMAP(CSrPgreRecord, CSrRecord)
END_SRFIELDMAP()
/*===========================================================================
 *		End of CObRecord Field Map
 *=========================================================================*/


/*===========================================================================
 *
 * Class CSrPgreRecord Constructor
 *
 *=========================================================================*/
CSrPgreRecord::CSrPgreRecord () 
{
}
/*===========================================================================
 *		End of Class CSrPgreRecord Constructor
 *=========================================================================*/


/*===========================================================================
 *
 * Class CSrPgreRecord Method - void Destroy (void);
 *
 *=========================================================================*/
void CSrPgreRecord::Destroy (void) 
{
	CSrRecord::Destroy();
}
/*===========================================================================
 *		End of Class Method CSrPgreRecord::Destroy()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CSrPgreRecord Method - void InitializeNew (void);
 *
 *=========================================================================*/
void CSrPgreRecord::InitializeNew (void) 
{

	/* Call the base class method first */
	CSrRecord::InitializeNew();


}
/*===========================================================================
 *		End of Class Method CSrPgreRecord::InitializeNew()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CSrPgreRecord Event - void OnAddSubrecord (pSubrecord);
 *
 *=========================================================================*/
void CSrPgreRecord::OnAddSubrecord (CSrSubrecord* pSubrecord) {

	if (pSubrecord->GetRecordType() == SR_NAME_XSCL)
	{
		m_pXsclData = SrCastClass(CSrDataSubrecord, pSubrecord);
	}
	else if (pSubrecord->GetRecordType() == SR_NAME_NAME)
	{
		m_pNameData = SrCastClass(CSrDataSubrecord, pSubrecord);
	}
	else if (pSubrecord->GetRecordType() == SR_NAME_XESP)
	{
		m_pXespData = SrCastClass(CSrDataSubrecord, pSubrecord);
	}
	else if (pSubrecord->GetRecordType() == SR_NAME_XOWN)
	{
		m_pXownData = SrCastClass(CSrDataSubrecord, pSubrecord);
	}
	else if (pSubrecord->GetRecordType() == SR_NAME_DATA)
	{
		m_pDataData = SrCastClass(CSrDataSubrecord, pSubrecord);
	}

	else
	{
	CSrRecord::OnAddSubrecord(pSubrecord);
	}

}
/*===========================================================================
 *		End of Class Event CSrPgreRecord::OnAddSubRecord()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CSrPgreRecord Event - void OnDeleteSubrecord (pSubrecord);
 *
 *=========================================================================*/
void CSrPgreRecord::OnDeleteSubrecord (CSrSubrecord* pSubrecord) {

	if (m_pXsclData == pSubrecord)
		m_pXsclData = NULL;
	else if (m_pNameData == pSubrecord)
		m_pNameData = NULL;
	else if (m_pXespData == pSubrecord)
		m_pXespData = NULL;
	else if (m_pXownData == pSubrecord)
		m_pXownData = NULL;
	else if (m_pDataData == pSubrecord)
		m_pDataData = NULL;

	else
		CSrRecord::OnDeleteSubrecord(pSubrecord);

}
/*===========================================================================
 *		End of Class Event CSrPgreRecord::OnDeleteSubrecord()
 *=========================================================================*/


/*===========================================================================
 *
 * Begin CSrPgreRecord Get Field Methods
 *
 *=========================================================================*/
/*===========================================================================
 *		End of CSrPgreRecord Get Field Methods
 *=========================================================================*/


/*===========================================================================
 *
 * Begin CSrPgreRecord Compare Field Methods
 *
 *=========================================================================*/
/*===========================================================================
 *		End of CSrPgreRecord Compare Field Methods
 *=========================================================================*/


/*===========================================================================
 *
 * Begin CSrPgreRecord Set Field Methods
 *
 *=========================================================================*/
/*===========================================================================
 *		End of CSrPgreRecord Set Field Methods
 *=========================================================================*/

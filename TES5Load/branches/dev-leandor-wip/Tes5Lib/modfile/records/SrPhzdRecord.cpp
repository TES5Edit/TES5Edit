/*===========================================================================
 *
 * File:		SrPhzdRecord.CPP
 * Author:		Dave Humphrey (dave@uesp.net)
 * Created On:	5 December 2011
 *
 * Description
 *
 *=========================================================================*/

	/* Include Files */
#include "srPhzdrecord.h"


/*===========================================================================
 *
 * Begin Subrecord Creation Array
 *
 *=========================================================================*/
BEGIN_SRSUBRECCREATE(CSrPhzdRecord, CSrRecord)
	DEFINE_SRSUBRECCREATE(SR_NAME_XSCL, CSrDataSubrecord::Create)
	DEFINE_SRSUBRECCREATE(SR_NAME_NAME, CSrDataSubrecord::Create)
	DEFINE_SRSUBRECCREATE(SR_NAME_XESP, CSrDataSubrecord::Create)
	DEFINE_SRSUBRECCREATE(SR_NAME_DATA, CSrDataSubrecord::Create)
	DEFINE_SRSUBRECCREATE(SR_NAME_VMAD, CSrDataSubrecord::Create)

END_SRSUBRECCREATE()
/*===========================================================================
 *		End of Subrecord Creation Array
 *=========================================================================*/


/*===========================================================================
 *
 * Begin CSrRecord Field Map
 *
 *=========================================================================*/
BEGIN_SRFIELDMAP(CSrPhzdRecord, CSrRecord)
END_SRFIELDMAP()
/*===========================================================================
 *		End of CObRecord Field Map
 *=========================================================================*/


/*===========================================================================
 *
 * Class CSrPhzdRecord Constructor
 *
 *=========================================================================*/
CSrPhzdRecord::CSrPhzdRecord () 
{
}
/*===========================================================================
 *		End of Class CSrPhzdRecord Constructor
 *=========================================================================*/


/*===========================================================================
 *
 * Class CSrPhzdRecord Method - void Destroy (void);
 *
 *=========================================================================*/
void CSrPhzdRecord::Destroy (void) 
{
	CSrRecord::Destroy();
}
/*===========================================================================
 *		End of Class Method CSrPhzdRecord::Destroy()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CSrPhzdRecord Method - void InitializeNew (void);
 *
 *=========================================================================*/
void CSrPhzdRecord::InitializeNew (void) 
{

	/* Call the base class method first */
	CSrRecord::InitializeNew();


}
/*===========================================================================
 *		End of Class Method CSrPhzdRecord::InitializeNew()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CSrPhzdRecord Event - void OnAddSubrecord (pSubrecord);
 *
 *=========================================================================*/
void CSrPhzdRecord::OnAddSubrecord (CSrSubrecord* pSubrecord) {

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
	else if (pSubrecord->GetRecordType() == SR_NAME_DATA)
	{
		m_pDataData = SrCastClass(CSrDataSubrecord, pSubrecord);
	}
	else if (pSubrecord->GetRecordType() == SR_NAME_VMAD)
	{
		m_pVmadData = SrCastClass(CSrDataSubrecord, pSubrecord);
	}

	else
	{
	CSrRecord::OnAddSubrecord(pSubrecord);
	}

}
/*===========================================================================
 *		End of Class Event CSrPhzdRecord::OnAddSubRecord()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CSrPhzdRecord Event - void OnDeleteSubrecord (pSubrecord);
 *
 *=========================================================================*/
void CSrPhzdRecord::OnDeleteSubrecord (CSrSubrecord* pSubrecord) {

	if (m_pXsclData == pSubrecord)
		m_pXsclData = NULL;
	else if (m_pNameData == pSubrecord)
		m_pNameData = NULL;
	else if (m_pXespData == pSubrecord)
		m_pXespData = NULL;
	else if (m_pDataData == pSubrecord)
		m_pDataData = NULL;
	else if (m_pVmadData == pSubrecord)
		m_pVmadData = NULL;

	else
		CSrRecord::OnDeleteSubrecord(pSubrecord);

}
/*===========================================================================
 *		End of Class Event CSrPhzdRecord::OnDeleteSubrecord()
 *=========================================================================*/


/*===========================================================================
 *
 * Begin CSrPhzdRecord Get Field Methods
 *
 *=========================================================================*/
/*===========================================================================
 *		End of CSrPhzdRecord Get Field Methods
 *=========================================================================*/


/*===========================================================================
 *
 * Begin CSrPhzdRecord Compare Field Methods
 *
 *=========================================================================*/
/*===========================================================================
 *		End of CSrPhzdRecord Compare Field Methods
 *=========================================================================*/


/*===========================================================================
 *
 * Begin CSrPhzdRecord Set Field Methods
 *
 *=========================================================================*/
/*===========================================================================
 *		End of CSrPhzdRecord Set Field Methods
 *=========================================================================*/

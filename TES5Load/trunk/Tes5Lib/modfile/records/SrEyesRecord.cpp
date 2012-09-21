/*===========================================================================
 *
 * File:		SrEyesRecord.CPP
 * Author:		Dave Humphrey (dave@uesp.net)
 * Created On:	5 December 2011
 *
 * Description
 *
 *=========================================================================*/

	/* Include Files */
#include "srEyesrecord.h"


/*===========================================================================
 *
 * Begin Subrecord Creation Array
 *
 *=========================================================================*/
BEGIN_SRSUBRECCREATE(CSrEyesRecord, CSrIdRecord)
	DEFINE_SRSUBRECCREATE(SR_NAME_ICON, CSrDataSubrecord::Create)
	DEFINE_SRSUBRECCREATE(SR_NAME_FULL, CSrDataSubrecord::Create)
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
BEGIN_SRFIELDMAP(CSrEyesRecord, CSrIdRecord)
END_SRFIELDMAP()
/*===========================================================================
 *		End of CObRecord Field Map
 *=========================================================================*/


/*===========================================================================
 *
 * Class CSrEyesRecord Constructor
 *
 *=========================================================================*/
CSrEyesRecord::CSrEyesRecord () 
{
}
/*===========================================================================
 *		End of Class CSrEyesRecord Constructor
 *=========================================================================*/


/*===========================================================================
 *
 * Class CSrEyesRecord Method - void Destroy (void);
 *
 *=========================================================================*/
void CSrEyesRecord::Destroy (void) 
{
	CSrIdRecord::Destroy();
}
/*===========================================================================
 *		End of Class Method CSrEyesRecord::Destroy()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CSrEyesRecord Method - void InitializeNew (void);
 *
 *=========================================================================*/
void CSrEyesRecord::InitializeNew (void) 
{
	CSrIdRecord::InitializeNew();
}
/*===========================================================================
 *		End of Class Method CSrEyesRecord::InitializeNew()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CSrEyesRecord Event - void OnAddSubrecord (pSubrecord);
 *
 *=========================================================================*/
void CSrEyesRecord::OnAddSubrecord (CSrSubrecord* pSubrecord) {

	if (pSubrecord->GetRecordType() == SR_NAME_ICON)
	{
		m_pIconData = SrCastClass(CSrDataSubrecord, pSubrecord);
	}
	else if (pSubrecord->GetRecordType() == SR_NAME_FULL)
	{
		m_pFullData = SrCastClass(CSrDataSubrecord, pSubrecord);
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
 *		End of Class Event CSrEyesRecord::OnAddSubRecord()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CSrEyesRecord Event - void OnDeleteSubrecord (pSubrecord);
 *
 *=========================================================================*/
void CSrEyesRecord::OnDeleteSubrecord (CSrSubrecord* pSubrecord) {

	if (m_pIconData == pSubrecord)
		m_pIconData = NULL;
	else if (m_pFullData == pSubrecord)
		m_pFullData = NULL;
	else if (m_pDataData == pSubrecord)
		m_pDataData = NULL;
	else
		CSrIdRecord::OnDeleteSubrecord(pSubrecord);

}
/*===========================================================================
 *		End of Class Event CSrEyesRecord::OnDeleteSubrecord()
 *=========================================================================*/


/*===========================================================================
 *
 * Begin CSrEyesRecord Get Field Methods
 *
 *=========================================================================*/
/*===========================================================================
 *		End of CSrEyesRecord Get Field Methods
 *=========================================================================*/


/*===========================================================================
 *
 * Begin CSrEyesRecord Compare Field Methods
 *
 *=========================================================================*/
/*===========================================================================
 *		End of CSrEyesRecord Compare Field Methods
 *=========================================================================*/


/*===========================================================================
 *
 * Begin CSrEyesRecord Set Field Methods
 *
 *=========================================================================*/
/*===========================================================================
 *		End of CSrEyesRecord Set Field Methods
 *=========================================================================*/

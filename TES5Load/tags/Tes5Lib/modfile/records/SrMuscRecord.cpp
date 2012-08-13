/*===========================================================================
 *
 * File:		SrMuscRecord.CPP
 * Author:		Dave Humphrey (dave@uesp.net)
 * Created On:	5 December 2011
 *
 * Description
 *
 *=========================================================================*/

	/* Include Files */
#include "srMuscrecord.h"


/*===========================================================================
 *
 * Begin Subrecord Creation Array
 *
 *=========================================================================*/
BEGIN_SRSUBRECCREATE(CSrMuscRecord, CSrIdRecord)
	DEFINE_SRSUBRECCREATE(SR_NAME_FNAM, CSrDataSubrecord::Create)
	DEFINE_SRSUBRECCREATE(SR_NAME_PNAM, CSrDataSubrecord::Create)
	DEFINE_SRSUBRECCREATE(SR_NAME_WNAM, CSrDataSubrecord::Create)
	DEFINE_SRSUBRECCREATE(SR_NAME_TNAM, CSrDataSubrecord::Create)

END_SRSUBRECCREATE()
/*===========================================================================
 *		End of Subrecord Creation Array
 *=========================================================================*/


/*===========================================================================
 *
 * Begin CSrIdRecord Field Map
 *
 *=========================================================================*/
BEGIN_SRFIELDMAP(CSrMuscRecord, CSrIdRecord)
END_SRFIELDMAP()
/*===========================================================================
 *		End of CObRecord Field Map
 *=========================================================================*/


/*===========================================================================
 *
 * Class CSrMuscRecord Constructor
 *
 *=========================================================================*/
CSrMuscRecord::CSrMuscRecord () 
{
}
/*===========================================================================
 *		End of Class CSrMuscRecord Constructor
 *=========================================================================*/


/*===========================================================================
 *
 * Class CSrMuscRecord Method - void Destroy (void);
 *
 *=========================================================================*/
void CSrMuscRecord::Destroy (void) 
{
	CSrIdRecord::Destroy();
}
/*===========================================================================
 *		End of Class Method CSrMuscRecord::Destroy()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CSrMuscRecord Method - void InitializeNew (void);
 *
 *=========================================================================*/
void CSrMuscRecord::InitializeNew (void) 
{

	/* Call the base class method first */
	CSrIdRecord::InitializeNew();


}
/*===========================================================================
 *		End of Class Method CSrMuscRecord::InitializeNew()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CSrMuscRecord Event - void OnAddSubrecord (pSubrecord);
 *
 *=========================================================================*/
void CSrMuscRecord::OnAddSubrecord (CSrSubrecord* pSubrecord) {

	if (pSubrecord->GetRecordType() == SR_NAME_FNAM)
	{
		m_pFnamData = SrCastClass(CSrDataSubrecord, pSubrecord);
	}
	else if (pSubrecord->GetRecordType() == SR_NAME_PNAM)
	{
		m_pPnamData = SrCastClass(CSrDataSubrecord, pSubrecord);
	}
	else if (pSubrecord->GetRecordType() == SR_NAME_WNAM)
	{
		m_pWnamData = SrCastClass(CSrDataSubrecord, pSubrecord);
	}
	else if (pSubrecord->GetRecordType() == SR_NAME_TNAM)
	{
		m_pTnamData = SrCastClass(CSrDataSubrecord, pSubrecord);
	}

	else
	{
	CSrIdRecord::OnAddSubrecord(pSubrecord);
	}

}
/*===========================================================================
 *		End of Class Event CSrMuscRecord::OnAddSubRecord()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CSrMuscRecord Event - void OnDeleteSubrecord (pSubrecord);
 *
 *=========================================================================*/
void CSrMuscRecord::OnDeleteSubrecord (CSrSubrecord* pSubrecord) {

	if (m_pFnamData == pSubrecord)
		m_pFnamData = NULL;

	else if (m_pPnamData == pSubrecord)
		m_pPnamData = NULL;
	else if (m_pWnamData == pSubrecord)
		m_pWnamData = NULL;
	else if (m_pTnamData == pSubrecord)
		m_pTnamData = NULL;

	else
		CSrIdRecord::OnDeleteSubrecord(pSubrecord);

}
/*===========================================================================
 *		End of Class Event CSrMuscRecord::OnDeleteSubrecord()
 *=========================================================================*/


/*===========================================================================
 *
 * Begin CSrMuscRecord Get Field Methods
 *
 *=========================================================================*/
/*===========================================================================
 *		End of CSrMuscRecord Get Field Methods
 *=========================================================================*/


/*===========================================================================
 *
 * Begin CSrMuscRecord Compare Field Methods
 *
 *=========================================================================*/
/*===========================================================================
 *		End of CSrMuscRecord Compare Field Methods
 *=========================================================================*/


/*===========================================================================
 *
 * Begin CSrMuscRecord Set Field Methods
 *
 *=========================================================================*/
/*===========================================================================
 *		End of CSrMuscRecord Set Field Methods
 *=========================================================================*/

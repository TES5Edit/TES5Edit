/*===========================================================================
 *
 * File:		SrIdlmRecord.CPP
 * Author:		Dave Humphrey (dave@uesp.net)
 * Created On:	5 December 2011
 *
 * Description
 *
 *=========================================================================*/

	/* Include Files */
#include "srIdlmrecord.h"


/*===========================================================================
 *
 * Begin Subrecord Creation Array
 *
 *=========================================================================*/
BEGIN_SRSUBRECCREATE(CSrIdlmRecord, CSrIdRecord)
	DEFINE_SRSUBRECCREATE(SR_NAME_IDLF, CSrDataSubrecord::Create)
	DEFINE_SRSUBRECCREATE(SR_NAME_IDLT, CSrDataSubrecord::Create)
	DEFINE_SRSUBRECCREATE(SR_NAME_IDLC, CSrDataSubrecord::Create)
	DEFINE_SRSUBRECCREATE(SR_NAME_IDLA, CSrDataSubrecord::Create)
END_SRSUBRECCREATE()
/*===========================================================================
 *		End of Subrecord Creation Array
 *=========================================================================*/


/*===========================================================================
 *
 * Begin CSrIdRecord Field Map
 *
 *=========================================================================*/
BEGIN_SRFIELDMAP(CSrIdlmRecord, CSrIdRecord)
END_SRFIELDMAP()
/*===========================================================================
 *		End of CObRecord Field Map
 *=========================================================================*/


/*===========================================================================
 *
 * Class CSrIdlmRecord Constructor
 *
 *=========================================================================*/
CSrIdlmRecord::CSrIdlmRecord () 
{
}
/*===========================================================================
 *		End of Class CSrIdlmRecord Constructor
 *=========================================================================*/


/*===========================================================================
 *
 * Class CSrIdlmRecord Method - void Destroy (void);
 *
 *=========================================================================*/
void CSrIdlmRecord::Destroy (void) 
{
	CSrIdRecord::Destroy();
}
/*===========================================================================
 *		End of Class Method CSrIdlmRecord::Destroy()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CSrIdlmRecord Method - void InitializeNew (void);
 *
 *=========================================================================*/
void CSrIdlmRecord::InitializeNew (void) 
{
	CSrIdRecord::InitializeNew();
}
/*===========================================================================
 *		End of Class Method CSrIdlmRecord::InitializeNew()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CSrIdlmRecord Event - void OnAddSubrecord (pSubrecord);
 *
 *=========================================================================*/
void CSrIdlmRecord::OnAddSubrecord (CSrSubrecord* pSubrecord) {

	if (pSubrecord->GetRecordType() == SR_NAME_IDLF)
	{
		m_pIdlfData = SrCastClass(CSrDataSubrecord, pSubrecord);
	}
	else if (pSubrecord->GetRecordType() == SR_NAME_IDLT)
	{
		m_pIdltData = SrCastClass(CSrDataSubrecord, pSubrecord);
	}
	else if (pSubrecord->GetRecordType() == SR_NAME_IDLC)
	{
		m_pIdlcData = SrCastClass(CSrDataSubrecord, pSubrecord);
	}
	else if (pSubrecord->GetRecordType() == SR_NAME_IDLA)
	{
		m_pIdlaData = SrCastClass(CSrDataSubrecord, pSubrecord);
	}
	else
	{
		CSrIdRecord::OnAddSubrecord(pSubrecord);
	}

}
/*===========================================================================
 *		End of Class Event CSrIdlmRecord::OnAddSubRecord()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CSrIdlmRecord Event - void OnDeleteSubrecord (pSubrecord);
 *
 *=========================================================================*/
void CSrIdlmRecord::OnDeleteSubrecord (CSrSubrecord* pSubrecord) {

	if (m_pIdlfData == pSubrecord)
		m_pIdlfData = NULL;
	else if (m_pIdltData == pSubrecord)
		m_pIdltData = NULL;
	else if (m_pIdlcData == pSubrecord)
		m_pIdlcData = NULL;
	else if (m_pIdlaData == pSubrecord)
		m_pIdlaData = NULL;
	else
		CSrIdRecord::OnDeleteSubrecord(pSubrecord);

}
/*===========================================================================
 *		End of Class Event CSrIdlmRecord::OnDeleteSubrecord()
 *=========================================================================*/


/*===========================================================================
 *
 * Begin CSrIdlmRecord Get Field Methods
 *
 *=========================================================================*/
/*===========================================================================
 *		End of CSrIdlmRecord Get Field Methods
 *=========================================================================*/


/*===========================================================================
 *
 * Begin CSrIdlmRecord Compare Field Methods
 *
 *=========================================================================*/
/*===========================================================================
 *		End of CSrIdlmRecord Compare Field Methods
 *=========================================================================*/


/*===========================================================================
 *
 * Begin CSrIdlmRecord Set Field Methods
 *
 *=========================================================================*/
/*===========================================================================
 *		End of CSrIdlmRecord Set Field Methods
 *=========================================================================*/

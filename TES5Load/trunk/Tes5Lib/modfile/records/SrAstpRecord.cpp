/*===========================================================================
 *
 * File:		SrAstpRecord.CPP
 * Author:		Dave Humphrey (dave@uesp.net)
 * Created On:	5 December 2011
 *
 * Description
 *
 *=========================================================================*/

	/* Include Files */
#include "srAstprecord.h"


/*===========================================================================
 *
 * Begin Subrecord Creation Array
 *
 *=========================================================================*/
BEGIN_SRSUBRECCREATE(CSrAstpRecord, CSrIdRecord)
	DEFINE_SRSUBRECCREATE(SR_NAME_FPRT, CSrDataSubrecord::Create)
	DEFINE_SRSUBRECCREATE(SR_NAME_MPRT, CSrDataSubrecord::Create)
	DEFINE_SRSUBRECCREATE(SR_NAME_MCHT, CSrDataSubrecord::Create)
	DEFINE_SRSUBRECCREATE(SR_NAME_FCHT, CSrDataSubrecord::Create)
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
BEGIN_SRFIELDMAP(CSrAstpRecord, CSrIdRecord)
END_SRFIELDMAP()
/*===========================================================================
 *		End of CObRecord Field Map
 *=========================================================================*/


/*===========================================================================
 *
 * Class CSrAstpRecord Constructor
 *
 *=========================================================================*/
CSrAstpRecord::CSrAstpRecord () 
{
}
/*===========================================================================
 *		End of Class CSrAstpRecord Constructor
 *=========================================================================*/


/*===========================================================================
 *
 * Class CSrAstpRecord Method - void Destroy (void);
 *
 *=========================================================================*/
void CSrAstpRecord::Destroy (void) 
{
	CSrIdRecord::Destroy();
}
/*===========================================================================
 *		End of Class Method CSrAstpRecord::Destroy()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CSrAstpRecord Method - void InitializeNew (void);
 *
 *=========================================================================*/
void CSrAstpRecord::InitializeNew (void) 
{
	CSrIdRecord::InitializeNew();
}
/*===========================================================================
 *		End of Class Method CSrAstpRecord::InitializeNew()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CSrAstpRecord Event - void OnAddSubrecord (pSubrecord);
 *
 *=========================================================================*/
void CSrAstpRecord::OnAddSubrecord (CSrSubrecord* pSubrecord) {

	if (pSubrecord->GetRecordType() == SR_NAME_FPRT)
	{
		m_pFprtData = SrCastClass(CSrDataSubrecord, pSubrecord);
	}
	else if (pSubrecord->GetRecordType() == SR_NAME_MPRT)
	{
		m_pMprtData = SrCastClass(CSrDataSubrecord, pSubrecord);
	}
	else if (pSubrecord->GetRecordType() == SR_NAME_MCHT)
	{
		m_pMchtData = SrCastClass(CSrDataSubrecord, pSubrecord);
	}
	else if (pSubrecord->GetRecordType() == SR_NAME_FCHT)
	{
		m_pFchtData = SrCastClass(CSrDataSubrecord, pSubrecord);
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
 *		End of Class Event CSrAstpRecord::OnAddSubRecord()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CSrAstpRecord Event - void OnDeleteSubrecord (pSubrecord);
 *
 *=========================================================================*/
void CSrAstpRecord::OnDeleteSubrecord (CSrSubrecord* pSubrecord) {

	if (m_pFprtData == pSubrecord)
		m_pFprtData = NULL;
	else if (m_pMprtData == pSubrecord)
		m_pMprtData = NULL;
	else if (m_pMchtData == pSubrecord)
		m_pMchtData = NULL;
	else if (m_pFchtData == pSubrecord)
		m_pFchtData = NULL;
	else if (m_pDataData == pSubrecord)
		m_pDataData = NULL;
	else
		CSrIdRecord::OnDeleteSubrecord(pSubrecord);

}
/*===========================================================================
 *		End of Class Event CSrAstpRecord::OnDeleteSubrecord()
 *=========================================================================*/


/*===========================================================================
 *
 * Begin CSrAstpRecord Get Field Methods
 *
 *=========================================================================*/
/*===========================================================================
 *		End of CSrAstpRecord Get Field Methods
 *=========================================================================*/


/*===========================================================================
 *
 * Begin CSrAstpRecord Compare Field Methods
 *
 *=========================================================================*/
/*===========================================================================
 *		End of CSrAstpRecord Compare Field Methods
 *=========================================================================*/


/*===========================================================================
 *
 * Begin CSrAstpRecord Set Field Methods
 *
 *=========================================================================*/
/*===========================================================================
 *		End of CSrAstpRecord Set Field Methods
 *=========================================================================*/

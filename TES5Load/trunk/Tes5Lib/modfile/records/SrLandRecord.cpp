/*===========================================================================
 *
 * File:		SrLandRecord.CPP
 * Author:		Dave Humphrey (dave@uesp.net)
 * Created On:	5 December 2011
 *
 * Description
 *
 *=========================================================================*/

	/* Include Files */
#include "srLandrecord.h"


/*===========================================================================
 *
 * Begin Subrecord Creation Array
 *
 *=========================================================================*/
BEGIN_SRSUBRECCREATE(CSrLandRecord, CSrRecord)
	DEFINE_SRSUBRECCREATE(SR_NAME_DATA, CSrDataSubrecord::Create)
	DEFINE_SRSUBRECCREATE(SR_NAME_VTXT, CSrDataSubrecord::Create)
	DEFINE_SRSUBRECCREATE(SR_NAME_VHGT, CSrDataSubrecord::Create)
	DEFINE_SRSUBRECCREATE(SR_NAME_VNML, CSrDataSubrecord::Create)
	DEFINE_SRSUBRECCREATE(SR_NAME_BTXT, CSrDataSubrecord::Create)
	DEFINE_SRSUBRECCREATE(SR_NAME_VCLR, CSrDataSubrecord::Create)
	DEFINE_SRSUBRECCREATE(SR_NAME_ATXT, CSrDataSubrecord::Create)

END_SRSUBRECCREATE()
/*===========================================================================
 *		End of Subrecord Creation Array
 *=========================================================================*/


/*===========================================================================
 *
 * Begin CSrRecord Field Map
 *
 *=========================================================================*/
BEGIN_SRFIELDMAP(CSrLandRecord, CSrRecord)
END_SRFIELDMAP()
/*===========================================================================
 *		End of CObRecord Field Map
 *=========================================================================*/


/*===========================================================================
 *
 * Class CSrLandRecord Constructor
 *
 *=========================================================================*/
CSrLandRecord::CSrLandRecord () 
{
}
/*===========================================================================
 *		End of Class CSrLandRecord Constructor
 *=========================================================================*/


/*===========================================================================
 *
 * Class CSrLandRecord Method - void Destroy (void);
 *
 *=========================================================================*/
void CSrLandRecord::Destroy (void) 
{
	CSrRecord::Destroy();
}
/*===========================================================================
 *		End of Class Method CSrLandRecord::Destroy()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CSrLandRecord Method - void InitializeNew (void);
 *
 *=========================================================================*/
void CSrLandRecord::InitializeNew (void) 
{

	/* Call the base class method first */
	CSrRecord::InitializeNew();


}
/*===========================================================================
 *		End of Class Method CSrLandRecord::InitializeNew()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CSrLandRecord Event - void OnAddSubrecord (pSubrecord);
 *
 *=========================================================================*/
void CSrLandRecord::OnAddSubrecord (CSrSubrecord* pSubrecord) {

	if (pSubrecord->GetRecordType() == SR_NAME_DATA)
	{
		m_pDataData = SrCastClass(CSrDataSubrecord, pSubrecord);
	}
	else if (pSubrecord->GetRecordType() == SR_NAME_VTXT)
	{
		m_pVtxtData = SrCastClass(CSrDataSubrecord, pSubrecord);
	}
	else if (pSubrecord->GetRecordType() == SR_NAME_VHGT)
	{
		m_pVhgtData = SrCastClass(CSrDataSubrecord, pSubrecord);
	}
	else if (pSubrecord->GetRecordType() == SR_NAME_VNML)
	{
		m_pVnmlData = SrCastClass(CSrDataSubrecord, pSubrecord);
	}
	else if (pSubrecord->GetRecordType() == SR_NAME_BTXT)
	{
		m_pBtxtData = SrCastClass(CSrDataSubrecord, pSubrecord);
	}
	else if (pSubrecord->GetRecordType() == SR_NAME_VCLR)
	{
		m_pVclrData = SrCastClass(CSrDataSubrecord, pSubrecord);
	}
	else if (pSubrecord->GetRecordType() == SR_NAME_ATXT)
	{
		m_pAtxtData = SrCastClass(CSrDataSubrecord, pSubrecord);
	}

	else
	{
	CSrRecord::OnAddSubrecord(pSubrecord);
	}

}
/*===========================================================================
 *		End of Class Event CSrLandRecord::OnAddSubRecord()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CSrLandRecord Event - void OnDeleteSubrecord (pSubrecord);
 *
 *=========================================================================*/
void CSrLandRecord::OnDeleteSubrecord (CSrSubrecord* pSubrecord) {

	if (m_pDataData == pSubrecord)
		m_pDataData = NULL;
	else if (m_pVtxtData == pSubrecord)
		m_pVtxtData = NULL;
	else if (m_pVhgtData == pSubrecord)
		m_pVhgtData = NULL;
	else if (m_pVnmlData == pSubrecord)
		m_pVnmlData = NULL;
	else if (m_pBtxtData == pSubrecord)
		m_pBtxtData = NULL;
	else if (m_pVclrData == pSubrecord)
		m_pVclrData = NULL;
	else if (m_pAtxtData == pSubrecord)
		m_pAtxtData = NULL;

	else
		CSrRecord::OnDeleteSubrecord(pSubrecord);

}
/*===========================================================================
 *		End of Class Event CSrLandRecord::OnDeleteSubrecord()
 *=========================================================================*/


/*===========================================================================
 *
 * Begin CSrLandRecord Get Field Methods
 *
 *=========================================================================*/
/*===========================================================================
 *		End of CSrLandRecord Get Field Methods
 *=========================================================================*/


/*===========================================================================
 *
 * Begin CSrLandRecord Compare Field Methods
 *
 *=========================================================================*/
/*===========================================================================
 *		End of CSrLandRecord Compare Field Methods
 *=========================================================================*/


/*===========================================================================
 *
 * Begin CSrLandRecord Set Field Methods
 *
 *=========================================================================*/
/*===========================================================================
 *		End of CSrLandRecord Set Field Methods
 *=========================================================================*/

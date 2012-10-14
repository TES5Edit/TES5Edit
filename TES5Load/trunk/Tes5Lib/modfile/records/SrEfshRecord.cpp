/*===========================================================================
 *
 * File:		SrEfshRecord.CPP
 * Author:		Dave Humphrey (dave@uesp.net)
 * Created On:	5 December 2011
 *
 * Description
 *
 *=========================================================================*/

	/* Include Files */
#include "srEfshrecord.h"


/*===========================================================================
 *
 * Begin Subrecord Creation Array
 *
 *=========================================================================*/
BEGIN_SRSUBRECCREATE(CSrEfshRecord, CSrIdRecord)
	DEFINE_SRSUBRECCREATE(SR_NAME_ICON, CSrDataSubrecord::Create)
	DEFINE_SRSUBRECCREATE(SR_NAME_ICO2, CSrDataSubrecord::Create)
	DEFINE_SRSUBRECCREATE(SR_NAME_NAM7, CSrDataSubrecord::Create)
	DEFINE_SRSUBRECCREATE(SR_NAME_NAM8, CSrDataSubrecord::Create)
	DEFINE_SRSUBRECCREATE(SR_NAME_NAM9, CSrDataSubrecord::Create)
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
BEGIN_SRFIELDMAP(CSrEfshRecord, CSrIdRecord)
END_SRFIELDMAP()
/*===========================================================================
 *		End of CObRecord Field Map
 *=========================================================================*/


/*===========================================================================
 *
 * Class CSrEfshRecord Constructor
 *
 *=========================================================================*/
CSrEfshRecord::CSrEfshRecord () 
{
}
/*===========================================================================
 *		End of Class CSrEfshRecord Constructor
 *=========================================================================*/


/*===========================================================================
 *
 * Class CSrEfshRecord Method - void Destroy (void);
 *
 *=========================================================================*/
void CSrEfshRecord::Destroy (void) 
{
	CSrIdRecord::Destroy();
}
/*===========================================================================
 *		End of Class Method CSrEfshRecord::Destroy()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CSrEfshRecord Method - void InitializeNew (void);
 *
 *=========================================================================*/
void CSrEfshRecord::InitializeNew (void) 
{
	CSrIdRecord::InitializeNew();
}
/*===========================================================================
 *		End of Class Method CSrEfshRecord::InitializeNew()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CSrEfshRecord Event - void OnAddSubrecord (pSubrecord);
 *
 *=========================================================================*/
void CSrEfshRecord::OnAddSubrecord (CSrSubrecord* pSubrecord) {

	if (pSubrecord->GetRecordType() == SR_NAME_ICON)
	{
		m_pIconData = SrCastClass(CSrDataSubrecord, pSubrecord);
	}
	else if (pSubrecord->GetRecordType() == SR_NAME_ICO2)
	{
		m_pIco2Data = SrCastClass(CSrDataSubrecord, pSubrecord);
	}
	else if (pSubrecord->GetRecordType() == SR_NAME_NAM7)
	{
		m_pNam7Data = SrCastClass(CSrDataSubrecord, pSubrecord);
	}
	else if (pSubrecord->GetRecordType() == SR_NAME_NAM8)
	{
		m_pNam8Data = SrCastClass(CSrDataSubrecord, pSubrecord);
	}
	else if (pSubrecord->GetRecordType() == SR_NAME_NAM9)
	{
		m_pNam9Data = SrCastClass(CSrDataSubrecord, pSubrecord);
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
 *		End of Class Event CSrEfshRecord::OnAddSubRecord()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CSrEfshRecord Event - void OnDeleteSubrecord (pSubrecord);
 *
 *=========================================================================*/
void CSrEfshRecord::OnDeleteSubrecord (CSrSubrecord* pSubrecord) {

	if (m_pIconData == pSubrecord)
		m_pIconData = NULL;
	else if (m_pIco2Data == pSubrecord)
		m_pIco2Data = NULL;
	else if (m_pNam7Data == pSubrecord)
		m_pNam7Data = NULL;
	else if (m_pNam8Data == pSubrecord)
		m_pNam8Data = NULL;
	else if (m_pNam9Data == pSubrecord)
		m_pNam9Data = NULL;
	else if (m_pDataData == pSubrecord)
		m_pDataData = NULL;
	else
		CSrIdRecord::OnDeleteSubrecord(pSubrecord);

}
/*===========================================================================
 *		End of Class Event CSrEfshRecord::OnDeleteSubrecord()
 *=========================================================================*/


/*===========================================================================
 *
 * Begin CSrEfshRecord Get Field Methods
 *
 *=========================================================================*/
/*===========================================================================
 *		End of CSrEfshRecord Get Field Methods
 *=========================================================================*/


/*===========================================================================
 *
 * Begin CSrEfshRecord Compare Field Methods
 *
 *=========================================================================*/
/*===========================================================================
 *		End of CSrEfshRecord Compare Field Methods
 *=========================================================================*/


/*===========================================================================
 *
 * Begin CSrEfshRecord Set Field Methods
 *
 *=========================================================================*/
/*===========================================================================
 *		End of CSrEfshRecord Set Field Methods
 *=========================================================================*/

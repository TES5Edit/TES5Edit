/*===========================================================================
 *
 * File:		SrRegnRecord.CPP
 * Author:		Dave Humphrey (dave@uesp.net)
 * Created On:	5 December 2011
 *
 * Description
 *
 *=========================================================================*/

	/* Include Files */
#include "srRegnrecord.h"


/*===========================================================================
 *
 * Begin Subrecord Creation Array
 *
 *=========================================================================*/
BEGIN_SRSUBRECCREATE(CSrRegnRecord, CSrIdRecord)
	DEFINE_SRSUBRECCREATE(SR_NAME_ICON, CSrDataSubrecord::Create)
	DEFINE_SRSUBRECCREATE(SR_NAME_RCLR, CSrDataSubrecord::Create)
	DEFINE_SRSUBRECCREATE(SR_NAME_RDWT, CSrDataSubrecord::Create)
	DEFINE_SRSUBRECCREATE(SR_NAME_WNAM, CSrDataSubrecord::Create)
	DEFINE_SRSUBRECCREATE(SR_NAME_RPLI, CSrDataSubrecord::Create)
	DEFINE_SRSUBRECCREATE(SR_NAME_RDAT, CSrDataSubrecord::Create)
	DEFINE_SRSUBRECCREATE(SR_NAME_RPLD, CSrDataSubrecord::Create)
	DEFINE_SRSUBRECCREATE(SR_NAME_RDSA, CSrDataSubrecord::Create)
	DEFINE_SRSUBRECCREATE(SR_NAME_RDMO, CSrDataSubrecord::Create)
	DEFINE_SRSUBRECCREATE(SR_NAME_RDOT, CSrDataSubrecord::Create)
	DEFINE_SRSUBRECCREATE(SR_NAME_RDMP, CSrDataSubrecord::Create)

END_SRSUBRECCREATE()
/*===========================================================================
 *		End of Subrecord Creation Array
 *=========================================================================*/


/*===========================================================================
 *
 * Begin CSrIdRecord Field Map
 *
 *=========================================================================*/
BEGIN_SRFIELDMAP(CSrRegnRecord, CSrIdRecord)
END_SRFIELDMAP()
/*===========================================================================
 *		End of CObRecord Field Map
 *=========================================================================*/


/*===========================================================================
 *
 * Class CSrRegnRecord Constructor
 *
 *=========================================================================*/
CSrRegnRecord::CSrRegnRecord () 
{
}
/*===========================================================================
 *		End of Class CSrRegnRecord Constructor
 *=========================================================================*/


/*===========================================================================
 *
 * Class CSrRegnRecord Method - void Destroy (void);
 *
 *=========================================================================*/
void CSrRegnRecord::Destroy (void) 
{
	CSrIdRecord::Destroy();
}
/*===========================================================================
 *		End of Class Method CSrRegnRecord::Destroy()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CSrRegnRecord Method - void InitializeNew (void);
 *
 *=========================================================================*/
void CSrRegnRecord::InitializeNew (void) 
{

	/* Call the base class method first */
	CSrIdRecord::InitializeNew();


}
/*===========================================================================
 *		End of Class Method CSrRegnRecord::InitializeNew()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CSrRegnRecord Event - void OnAddSubrecord (pSubrecord);
 *
 *=========================================================================*/
void CSrRegnRecord::OnAddSubrecord (CSrSubrecord* pSubrecord) {

	if (pSubrecord->GetRecordType() == SR_NAME_ICON)
	{
		m_pIconData = SrCastClass(CSrDataSubrecord, pSubrecord);
	}
	else if (pSubrecord->GetRecordType() == SR_NAME_RCLR)
	{
		m_pRclrData = SrCastClass(CSrDataSubrecord, pSubrecord);
	}
	else if (pSubrecord->GetRecordType() == SR_NAME_RDWT)
	{
		m_pRdwtData = SrCastClass(CSrDataSubrecord, pSubrecord);
	}
	else if (pSubrecord->GetRecordType() == SR_NAME_WNAM)
	{
		m_pWnamData = SrCastClass(CSrDataSubrecord, pSubrecord);
	}
	else if (pSubrecord->GetRecordType() == SR_NAME_RPLI)
	{
		m_pRpliData = SrCastClass(CSrDataSubrecord, pSubrecord);
	}
	else if (pSubrecord->GetRecordType() == SR_NAME_RDAT)
	{
		m_pRdatData = SrCastClass(CSrDataSubrecord, pSubrecord);
	}
	else if (pSubrecord->GetRecordType() == SR_NAME_RPLD)
	{
		m_pRpldData = SrCastClass(CSrDataSubrecord, pSubrecord);
	}
	else if (pSubrecord->GetRecordType() == SR_NAME_RDSA)
	{
		m_pRdsaData = SrCastClass(CSrDataSubrecord, pSubrecord);
	}
	else if (pSubrecord->GetRecordType() == SR_NAME_RDMO)
	{
		m_pRdmoData = SrCastClass(CSrDataSubrecord, pSubrecord);
	}
	else if (pSubrecord->GetRecordType() == SR_NAME_RDOT)
	{
		m_pRdotData = SrCastClass(CSrDataSubrecord, pSubrecord);
	}
	else if (pSubrecord->GetRecordType() == SR_NAME_RDMP)
	{
		m_pRdmpData = SrCastClass(CSrDataSubrecord, pSubrecord);
	}

	else
	{
	CSrIdRecord::OnAddSubrecord(pSubrecord);
	}

}
/*===========================================================================
 *		End of Class Event CSrRegnRecord::OnAddSubRecord()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CSrRegnRecord Event - void OnDeleteSubrecord (pSubrecord);
 *
 *=========================================================================*/
void CSrRegnRecord::OnDeleteSubrecord (CSrSubrecord* pSubrecord) {

	if (m_pIconData == pSubrecord)
		m_pIconData = NULL;

	else if (m_pRclrData == pSubrecord)
		m_pRclrData = NULL;
	else if (m_pRdwtData == pSubrecord)
		m_pRdwtData = NULL;
	else if (m_pWnamData == pSubrecord)
		m_pWnamData = NULL;
	else if (m_pRpliData == pSubrecord)
		m_pRpliData = NULL;
	else if (m_pRdatData == pSubrecord)
		m_pRdatData = NULL;
	else if (m_pRpldData == pSubrecord)
		m_pRpldData = NULL;
	else if (m_pRdsaData == pSubrecord)
		m_pRdsaData = NULL;
	else if (m_pRdmoData == pSubrecord)
		m_pRdmoData = NULL;
	else if (m_pRdotData == pSubrecord)
		m_pRdotData = NULL;
	else if (m_pRdmpData == pSubrecord)
		m_pRdmpData = NULL;

	else
		CSrIdRecord::OnDeleteSubrecord(pSubrecord);

}
/*===========================================================================
 *		End of Class Event CSrRegnRecord::OnDeleteSubrecord()
 *=========================================================================*/


/*===========================================================================
 *
 * Begin CSrRegnRecord Get Field Methods
 *
 *=========================================================================*/
/*===========================================================================
 *		End of CSrRegnRecord Get Field Methods
 *=========================================================================*/


/*===========================================================================
 *
 * Begin CSrRegnRecord Compare Field Methods
 *
 *=========================================================================*/
/*===========================================================================
 *		End of CSrRegnRecord Compare Field Methods
 *=========================================================================*/


/*===========================================================================
 *
 * Begin CSrRegnRecord Set Field Methods
 *
 *=========================================================================*/
/*===========================================================================
 *		End of CSrRegnRecord Set Field Methods
 *=========================================================================*/

/*===========================================================================
 *
 * File:		SrCellRecord.CPP
 * Author:		Dave Humphrey (dave@uesp.net)
 * Created On:	5 December 2011
 *
 * Description
 *
 *=========================================================================*/

	/* Include Files */
#include "srCellrecord.h"


/*===========================================================================
 *
 * Begin Subrecord Creation Array
 *
 *=========================================================================*/
BEGIN_SRSUBRECCREATE(CSrCellRecord, CSrIdRecord)
	DEFINE_SRSUBRECCREATE(SR_NAME_XCMO, CSrDataSubrecord::Create)
	DEFINE_SRSUBRECCREATE(SR_NAME_XWCN, CSrDataSubrecord::Create)
	DEFINE_SRSUBRECCREATE(SR_NAME_FULL, CSrDataSubrecord::Create)
	DEFINE_SRSUBRECCREATE(SR_NAME_XCIM, CSrDataSubrecord::Create)
	DEFINE_SRSUBRECCREATE(SR_NAME_XLCN, CSrDataSubrecord::Create)
	DEFINE_SRSUBRECCREATE(SR_NAME_TVDT, CSrDataSubrecord::Create)
	DEFINE_SRSUBRECCREATE(SR_NAME_LTMP, CSrDataSubrecord::Create)
	DEFINE_SRSUBRECCREATE(SR_NAME_XCLW, CSrDataSubrecord::Create)
	DEFINE_SRSUBRECCREATE(SR_NAME_XCLR, CSrDataSubrecord::Create)
	DEFINE_SRSUBRECCREATE(SR_NAME_DATA, CSrDataSubrecord::Create)
	DEFINE_SRSUBRECCREATE(SR_NAME_XWEM, CSrDataSubrecord::Create)
	DEFINE_SRSUBRECCREATE(SR_NAME_XILL, CSrDataSubrecord::Create)
	DEFINE_SRSUBRECCREATE(SR_NAME_XCLL, CSrDataSubrecord::Create)
	DEFINE_SRSUBRECCREATE(SR_NAME_XEZN, CSrDataSubrecord::Create)
	DEFINE_SRSUBRECCREATE(SR_NAME_XCAS, CSrDataSubrecord::Create)
	DEFINE_SRSUBRECCREATE(SR_NAME_XCCM, CSrDataSubrecord::Create)
	DEFINE_SRSUBRECCREATE(SR_NAME_XOWN, CSrDataSubrecord::Create)
	DEFINE_SRSUBRECCREATE(SR_NAME_XCWT, CSrDataSubrecord::Create)
	DEFINE_SRSUBRECCREATE(SR_NAME_MHDT, CSrDataSubrecord::Create)
	DEFINE_SRSUBRECCREATE(SR_NAME_LNAM, CSrDataSubrecord::Create)
	DEFINE_SRSUBRECCREATE(SR_NAME_XNAM, CSrDataSubrecord::Create)
	DEFINE_SRSUBRECCREATE(SR_NAME_XCLC, CSrDataSubrecord::Create)
	DEFINE_SRSUBRECCREATE(SR_NAME_XWCU, CSrDataSubrecord::Create)
	DEFINE_SRSUBRECCREATE(SR_NAME_XWCS, CSrDataSubrecord::Create)
END_SRSUBRECCREATE()
/*===========================================================================
 *		End of Subrecord Creation Array
 *=========================================================================*/


/*===========================================================================
 *
 * Begin CSrRecord Field Map
 *
 *=========================================================================*/
BEGIN_SRFIELDMAP(CSrCellRecord, CSrIdRecord)
END_SRFIELDMAP()
/*===========================================================================
 *		End of CObRecord Field Map
 *=========================================================================*/


/*===========================================================================
 *
 * Class CSrCellRecord Constructor
 *
 *=========================================================================*/
CSrCellRecord::CSrCellRecord () 
{
}
/*===========================================================================
 *		End of Class CSrCellRecord Constructor
 *=========================================================================*/


/*===========================================================================
 *
 * Class CSrCellRecord Method - void Destroy (void);
 *
 *=========================================================================*/
void CSrCellRecord::Destroy (void) 
{
	CSrIdRecord::Destroy();
}
/*===========================================================================
 *		End of Class Method CSrCellRecord::Destroy()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CSrCellRecord Method - void InitializeNew (void);
 *
 *=========================================================================*/
void CSrCellRecord::InitializeNew (void) 
{
	CSrIdRecord::InitializeNew();
}
/*===========================================================================
 *		End of Class Method CSrCellRecord::InitializeNew()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CSrCellRecord Event - void OnAddSubrecord (pSubrecord);
 *
 *=========================================================================*/
void CSrCellRecord::OnAddSubrecord (CSrSubrecord* pSubrecord) {

	if (pSubrecord->GetRecordType() == SR_NAME_XCMO)
	{
		m_pXcmoData = SrCastClass(CSrDataSubrecord, pSubrecord);
	}
	else if (pSubrecord->GetRecordType() == SR_NAME_XWCN)
	{
		m_pXwcnData = SrCastClass(CSrDataSubrecord, pSubrecord);
	}
	else if (pSubrecord->GetRecordType() == SR_NAME_FULL)
	{
		m_pFullData = SrCastClass(CSrDataSubrecord, pSubrecord);
	}
	else if (pSubrecord->GetRecordType() == SR_NAME_XCIM)
	{
		m_pXcimData = SrCastClass(CSrDataSubrecord, pSubrecord);
	}
	else if (pSubrecord->GetRecordType() == SR_NAME_XLCN)
	{
		m_pXlcnData = SrCastClass(CSrDataSubrecord, pSubrecord);
	}
	else if (pSubrecord->GetRecordType() == SR_NAME_TVDT)
	{
		m_pTvdtData = SrCastClass(CSrDataSubrecord, pSubrecord);
	}
	else if (pSubrecord->GetRecordType() == SR_NAME_LTMP)
	{
		m_pLtmpData = SrCastClass(CSrDataSubrecord, pSubrecord);
	}
	else if (pSubrecord->GetRecordType() == SR_NAME_XCLW)
	{
		m_pXclwData = SrCastClass(CSrDataSubrecord, pSubrecord);
	}
	else if (pSubrecord->GetRecordType() == SR_NAME_XCLR)
	{
		m_pXclrData = SrCastClass(CSrDataSubrecord, pSubrecord);
	}
	else if (pSubrecord->GetRecordType() == SR_NAME_DATA)
	{
		m_pDataData = SrCastClass(CSrDataSubrecord, pSubrecord);
	}
	else if (pSubrecord->GetRecordType() == SR_NAME_XWEM)
	{
		m_pXwemData = SrCastClass(CSrDataSubrecord, pSubrecord);
	}
	else if (pSubrecord->GetRecordType() == SR_NAME_XILL)
	{
		m_pXillData = SrCastClass(CSrDataSubrecord, pSubrecord);
	}
	else if (pSubrecord->GetRecordType() == SR_NAME_XCLL)
	{
		m_pXcllData = SrCastClass(CSrDataSubrecord, pSubrecord);
	}
	else if (pSubrecord->GetRecordType() == SR_NAME_XEZN)
	{
		m_pXeznData = SrCastClass(CSrDataSubrecord, pSubrecord);
	}
	else if (pSubrecord->GetRecordType() == SR_NAME_XCAS)
	{
		m_pXcasData = SrCastClass(CSrDataSubrecord, pSubrecord);
	}
	else if (pSubrecord->GetRecordType() == SR_NAME_XCCM)
	{
		m_pXccmData = SrCastClass(CSrDataSubrecord, pSubrecord);
	}
	else if (pSubrecord->GetRecordType() == SR_NAME_XOWN)
	{
		m_pXownData = SrCastClass(CSrDataSubrecord, pSubrecord);
	}
	else if (pSubrecord->GetRecordType() == SR_NAME_XCWT)
	{
		m_pXcwtData = SrCastClass(CSrDataSubrecord, pSubrecord);
	}
	else if (pSubrecord->GetRecordType() == SR_NAME_MHDT)
	{
		m_pMhdtData = SrCastClass(CSrDataSubrecord, pSubrecord);
	}
	else if (pSubrecord->GetRecordType() == SR_NAME_LNAM)
	{
		m_pLnamData = SrCastClass(CSrDataSubrecord, pSubrecord);
	}
	else if (pSubrecord->GetRecordType() == SR_NAME_XNAM)
	{
		m_pXnamData = SrCastClass(CSrDataSubrecord, pSubrecord);
	}
	else if (pSubrecord->GetRecordType() == SR_NAME_XCLC)
	{
		m_pXclcData = SrCastClass(CSrDataSubrecord, pSubrecord);
	}
	else if (pSubrecord->GetRecordType() == SR_NAME_XWCU)
	{
		m_pXwcuData = SrCastClass(CSrDataSubrecord, pSubrecord);
	}
	else if (pSubrecord->GetRecordType() == SR_NAME_XWCS)
	{
		m_pXwcsData = SrCastClass(CSrDataSubrecord, pSubrecord);
	}
	else
	{
		CSrIdRecord::OnAddSubrecord(pSubrecord);
	}

}
/*===========================================================================
 *		End of Class Event CSrCellRecord::OnAddSubRecord()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CSrCellRecord Event - void OnDeleteSubrecord (pSubrecord);
 *
 *=========================================================================*/
void CSrCellRecord::OnDeleteSubrecord (CSrSubrecord* pSubrecord) {

	if (m_pXcmoData == pSubrecord)
		m_pXcmoData = NULL;
	else if (m_pXwcnData == pSubrecord)
		m_pXwcnData = NULL;
	else if (m_pFullData == pSubrecord)
		m_pFullData = NULL;
	else if (m_pXcimData == pSubrecord)
		m_pXcimData = NULL;
	else if (m_pXlcnData == pSubrecord)
		m_pXlcnData = NULL;
	else if (m_pTvdtData == pSubrecord)
		m_pTvdtData = NULL;
	else if (m_pLtmpData == pSubrecord)
		m_pLtmpData = NULL;
	else if (m_pXclwData == pSubrecord)
		m_pXclwData = NULL;
	else if (m_pXclrData == pSubrecord)
		m_pXclrData = NULL;
	else if (m_pDataData == pSubrecord)
		m_pDataData = NULL;
	else if (m_pXwemData == pSubrecord)
		m_pXwemData = NULL;
	else if (m_pXillData == pSubrecord)
		m_pXillData = NULL;
	else if (m_pXcllData == pSubrecord)
		m_pXcllData = NULL;
	else if (m_pXeznData == pSubrecord)
		m_pXeznData = NULL;
	else if (m_pXcasData == pSubrecord)
		m_pXcasData = NULL;
	else if (m_pXccmData == pSubrecord)
		m_pXccmData = NULL;
	else if (m_pXownData == pSubrecord)
		m_pXownData = NULL;
	else if (m_pXcwtData == pSubrecord)
		m_pXcwtData = NULL;
	else if (m_pMhdtData == pSubrecord)
		m_pMhdtData = NULL;
	else if (m_pLnamData == pSubrecord)
		m_pLnamData = NULL;
	else if (m_pXnamData == pSubrecord)
		m_pXnamData = NULL;
	else if (m_pXclcData == pSubrecord)
		m_pXclcData = NULL;
	else if (m_pXwcuData == pSubrecord)
		m_pXwcuData = NULL;
	else if (m_pXwcsData == pSubrecord)
		m_pXwcsData = NULL;
	else
		CSrIdRecord::OnDeleteSubrecord(pSubrecord);

}
/*===========================================================================
 *		End of Class Event CSrCellRecord::OnDeleteSubrecord()
 *=========================================================================*/


/*===========================================================================
 *
 * Begin CSrCellRecord Get Field Methods
 *
 *=========================================================================*/
/*===========================================================================
 *		End of CSrCellRecord Get Field Methods
 *=========================================================================*/


/*===========================================================================
 *
 * Begin CSrCellRecord Compare Field Methods
 *
 *=========================================================================*/
/*===========================================================================
 *		End of CSrCellRecord Compare Field Methods
 *=========================================================================*/


/*===========================================================================
 *
 * Begin CSrCellRecord Set Field Methods
 *
 *=========================================================================*/
/*===========================================================================
 *		End of CSrCellRecord Set Field Methods
 *=========================================================================*/

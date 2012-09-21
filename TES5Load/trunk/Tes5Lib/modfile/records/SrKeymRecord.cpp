/*===========================================================================
 *
 * File:		SrKeymRecord.CPP
 * Author:		Dave Humphrey (dave@uesp.net)
 * Created On:	5 December 2011
 *
 * Description
 *
 *=========================================================================*/

	/* Include Files */
#include "srKeymrecord.h"


/*===========================================================================
 *
 * Begin Subrecord Creation Array
 *
 *=========================================================================*/
BEGIN_SRSUBRECCREATE(CSrKeymRecord, CSrItem1Record)
	DEFINE_SRSUBRECCREATE(SR_NAME_MODT, CSrDataSubrecord::Create)
	DEFINE_SRSUBRECCREATE(SR_NAME_YNAM, CSrDataSubrecord::Create)
	DEFINE_SRSUBRECCREATE(SR_NAME_ZNAM, CSrDataSubrecord::Create)
	DEFINE_SRSUBRECCREATE(SR_NAME_DATA, CSrDataSubrecord::Create)
	DEFINE_SRSUBRECCREATE(SR_NAME_VMAD, CSrDataSubrecord::Create)
END_SRSUBRECCREATE()
/*===========================================================================
 *		End of Subrecord Creation Array
 *=========================================================================*/


/*===========================================================================
 *
 * Begin CSrItem1Record Field Map
 *
 *=========================================================================*/
BEGIN_SRFIELDMAP(CSrKeymRecord, CSrItem1Record)
END_SRFIELDMAP()
/*===========================================================================
 *		End of CObRecord Field Map
 *=========================================================================*/


/*===========================================================================
 *
 * Class CSrKeymRecord Constructor
 *
 *=========================================================================*/
CSrKeymRecord::CSrKeymRecord () 
{
}
/*===========================================================================
 *		End of Class CSrKeymRecord Constructor
 *=========================================================================*/


/*===========================================================================
 *
 * Class CSrKeymRecord Method - void Destroy (void);
 *
 *=========================================================================*/
void CSrKeymRecord::Destroy (void) 
{
	CSrItem1Record::Destroy();
}
/*===========================================================================
 *		End of Class Method CSrKeymRecord::Destroy()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CSrKeymRecord Method - void InitializeNew (void);
 *
 *=========================================================================*/
void CSrKeymRecord::InitializeNew (void) 
{
	CSrItem1Record::InitializeNew();
}
/*===========================================================================
 *		End of Class Method CSrKeymRecord::InitializeNew()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CSrKeymRecord Event - void OnAddSubrecord (pSubrecord);
 *
 *=========================================================================*/
void CSrKeymRecord::OnAddSubrecord (CSrSubrecord* pSubrecord) {

	if (pSubrecord->GetRecordType() == SR_NAME_MODT)
	{
		m_pModtData = SrCastClass(CSrDataSubrecord, pSubrecord);
	}
	else if (pSubrecord->GetRecordType() == SR_NAME_YNAM)
	{
		m_pYnamData = SrCastClass(CSrDataSubrecord, pSubrecord);
	}
	else if (pSubrecord->GetRecordType() == SR_NAME_ZNAM)
	{
		m_pZnamData = SrCastClass(CSrDataSubrecord, pSubrecord);
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
		CSrItem1Record::OnAddSubrecord(pSubrecord);
	}

}
/*===========================================================================
 *		End of Class Event CSrKeymRecord::OnAddSubRecord()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CSrKeymRecord Event - void OnDeleteSubrecord (pSubrecord);
 *
 *=========================================================================*/
void CSrKeymRecord::OnDeleteSubrecord (CSrSubrecord* pSubrecord) {

	if (m_pModtData == pSubrecord)
		m_pModtData = NULL;
	else if (m_pYnamData == pSubrecord)
		m_pYnamData = NULL;
	else if (m_pZnamData == pSubrecord)
		m_pZnamData = NULL;
	else if (m_pDataData == pSubrecord)
		m_pDataData = NULL;
	else if (m_pVmadData == pSubrecord)
		m_pVmadData = NULL;
	else
		CSrItem1Record::OnDeleteSubrecord(pSubrecord);

}
/*===========================================================================
 *		End of Class Event CSrKeymRecord::OnDeleteSubrecord()
 *=========================================================================*/


/*===========================================================================
 *
 * Begin CSrKeymRecord Get Field Methods
 *
 *=========================================================================*/
/*===========================================================================
 *		End of CSrKeymRecord Get Field Methods
 *=========================================================================*/


/*===========================================================================
 *
 * Begin CSrKeymRecord Compare Field Methods
 *
 *=========================================================================*/
/*===========================================================================
 *		End of CSrKeymRecord Compare Field Methods
 *=========================================================================*/


/*===========================================================================
 *
 * Begin CSrKeymRecord Set Field Methods
 *
 *=========================================================================*/
/*===========================================================================
 *		End of CSrKeymRecord Set Field Methods
 *=========================================================================*/

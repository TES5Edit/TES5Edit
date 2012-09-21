/*===========================================================================
 *
 * File:		SrMatoRecord.CPP
 * Author:		Dave Humphrey (dave@uesp.net)
 * Created On:	5 December 2011
 *
 * Description
 *
 *=========================================================================*/

	/* Include Files */
#include "srMatorecord.h"


/*===========================================================================
 *
 * Begin Subrecord Creation Array
 *
 *=========================================================================*/
BEGIN_SRSUBRECCREATE(CSrMatoRecord, CSrIdRecord)
	DEFINE_SRSUBRECCREATE(SR_NAME_MODL, CSrStringSubrecord::Create)
	DEFINE_SRSUBRECCREATE(SR_NAME_DATA, CSrDataSubrecord::Create)
	DEFINE_SRSUBRECCREATE(SR_NAME_DNAM, CSrDataSubrecord::Create)
END_SRSUBRECCREATE()
/*===========================================================================
 *		End of Subrecord Creation Array
 *=========================================================================*/


/*===========================================================================
 *
 * Begin CSrIdRecord Field Map
 *
 *=========================================================================*/
BEGIN_SRFIELDMAP(CSrMatoRecord, CSrIdRecord)
	ADD_SRFIELDALL("Model",  SR_FIELD_MODEL,	0, CSrMatoRecord, FieldModel)
END_SRFIELDMAP()
/*===========================================================================
 *		End of CObRecord Field Map
 *=========================================================================*/


/*===========================================================================
 *
 * Class CSrMatoRecord Constructor
 *
 *=========================================================================*/
CSrMatoRecord::CSrMatoRecord () 
{
	m_pModlData = NULL;
	m_pDataData = NULL;
	m_pDnamData = NULL;
}
/*===========================================================================
 *		End of Class CSrMatoRecord Constructor
 *=========================================================================*/


/*===========================================================================
 *
 * Class CSrMatoRecord Method - void Destroy (void);
 *
 *=========================================================================*/
void CSrMatoRecord::Destroy (void) 
{
	m_pModlData = NULL;
	m_pDataData = NULL;
	m_pDnamData = NULL;

	CSrIdRecord::Destroy();
}
/*===========================================================================
 *		End of Class Method CSrMatoRecord::Destroy()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CSrMatoRecord Method - void InitializeNew (void);
 *
 *=========================================================================*/
void CSrMatoRecord::InitializeNew (void) 
{
	CSrIdRecord::InitializeNew();


}
/*===========================================================================
 *		End of Class Method CSrMatoRecord::InitializeNew()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CSrMatoRecord Event - void OnAddSubrecord (pSubrecord);
 *
 *=========================================================================*/
void CSrMatoRecord::OnAddSubrecord (CSrSubrecord* pSubrecord) {

	if (pSubrecord->GetRecordType() == SR_NAME_MODL)
	{
		m_pModlData = SrCastClass(CSrStringSubrecord, pSubrecord);
	}	
	else if (pSubrecord->GetRecordType() == SR_NAME_DATA)
	{
		m_pDataData = SrCastClass(CSrDataSubrecord, pSubrecord);
	}
	else if (pSubrecord->GetRecordType() == SR_NAME_DNAM)
	{
		m_pDnamData = SrCastClass(CSrDataSubrecord, pSubrecord);
	}
	else
	{
		CSrIdRecord::OnAddSubrecord(pSubrecord);
	}

}
/*===========================================================================
 *		End of Class Event CSrMatoRecord::OnAddSubRecord()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CSrMatoRecord Event - void OnDeleteSubrecord (pSubrecord);
 *
 *=========================================================================*/
void CSrMatoRecord::OnDeleteSubrecord (CSrSubrecord* pSubrecord) {

	if (m_pModlData == pSubrecord)
		m_pModlData = NULL;
	else if (m_pDataData == pSubrecord)
		m_pDataData = NULL;
	else if (m_pDnamData == pSubrecord)
		m_pDnamData = NULL;
	else
		CSrIdRecord::OnDeleteSubrecord(pSubrecord);

}
/*===========================================================================
 *		End of Class Event CSrMatoRecord::OnDeleteSubrecord()
 *=========================================================================*/


/*===========================================================================
 *
 * Begin CSrMatoRecord Get Field Methods
 *
 *=========================================================================*/
/*===========================================================================
 *		End of CSrMatoRecord Get Field Methods
 *=========================================================================*/


/*===========================================================================
 *
 * Begin CSrMatoRecord Compare Field Methods
 *
 *=========================================================================*/
/*===========================================================================
 *		End of CSrMatoRecord Compare Field Methods
 *=========================================================================*/


/*===========================================================================
 *
 * Begin CSrMatoRecord Set Field Methods
 *
 *=========================================================================*/
/*===========================================================================
 *		End of CSrMatoRecord Set Field Methods
 *=========================================================================*/

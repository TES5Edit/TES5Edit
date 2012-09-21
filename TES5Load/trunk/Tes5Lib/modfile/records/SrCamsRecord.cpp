/*===========================================================================
 *
 * File:		SrCamsRecord.CPP
 * Author:		Dave Humphrey (dave@uesp.net)
 * Created On:	5 December 2011
 *
 * Description
 *
 *=========================================================================*/

	/* Include Files */
#include "srCamsrecord.h"


srcamsdata_t CSrCamsRecord::s_NullCamsData;


/*===========================================================================
 *
 * Begin Subrecord Creation Array
 *
 *=========================================================================*/
BEGIN_SRSUBRECCREATE(CSrCamsRecord, CSrIdRecord)
	DEFINE_SRSUBRECCREATE(SR_NAME_MODL, CSrStringSubrecord::Create)
	DEFINE_SRSUBRECCREATE(SR_NAME_MODT, CSrDataSubrecord::Create)
	DEFINE_SRSUBRECCREATE(SR_NAME_DATA, CSrCamsDataSubrecord::Create)
	DEFINE_SRSUBRECCREATE(SR_NAME_MNAM, CSrFormidSubrecord::Create)
END_SRSUBRECCREATE()
/*===========================================================================
 *		End of Subrecord Creation Array
 *=========================================================================*/


/*===========================================================================
 *
 * Begin CSrRecord Field Map
 *
 *=========================================================================*/
BEGIN_SRFIELDMAP(CSrCamsRecord, CSrIdRecord)
	ADD_SRFIELDALL("Model",			SR_FIELD_MODEL,			0, CSrCamsRecord, FieldModel)
	ADD_SRFIELDALL("ImageSpace",	SR_FIELD_IMAGESPACE,	0, CSrCamsRecord, FieldImageSpace)
	ADD_SRFIELDALL("Unknown1",		SR_FIELD_UNKNOWN1,		0, CSrCamsRecord, FieldUnknown1)
	ADD_SRFIELDALL("Unknown2",		SR_FIELD_UNKNOWN2,		0, CSrCamsRecord, FieldUnknown2)
	ADD_SRFIELDALL("Unknown3",		SR_FIELD_UNKNOWN3,		0, CSrCamsRecord, FieldUnknown3)
	ADD_SRFIELDALL("Unknown4",		SR_FIELD_UNKNOWN4,		0, CSrCamsRecord, FieldUnknown4)
	ADD_SRFIELDALL("X1",			SR_FIELD_X1,			0, CSrCamsRecord, FieldX1)
	ADD_SRFIELDALL("Y1",			SR_FIELD_Y1,			0, CSrCamsRecord, FieldY1)
	ADD_SRFIELDALL("Z1",			SR_FIELD_Z1,			0, CSrCamsRecord, FieldZ1)
	ADD_SRFIELDALL("X2",			SR_FIELD_X2,			0, CSrCamsRecord, FieldX2)
	ADD_SRFIELDALL("Y2",			SR_FIELD_Y2,			0, CSrCamsRecord, FieldY2)
	ADD_SRFIELDALL("Z2",			SR_FIELD_Z2,			0, CSrCamsRecord, FieldZ2)
END_SRFIELDMAP()
/*===========================================================================
 *		End of CObRecord Field Map
 *=========================================================================*/


/*===========================================================================
 *
 * Class CSrCamsRecord Constructor
 *
 *=========================================================================*/
CSrCamsRecord::CSrCamsRecord () 
{
	m_pModel = NULL;
	m_pModtData = NULL;
	m_pCamsData = NULL;
	m_pImageSpace = NULL;
}
/*===========================================================================
 *		End of Class CSrCamsRecord Constructor
 *=========================================================================*/


/*===========================================================================
 *
 * Class CSrCamsRecord Method - void Destroy (void);
 *
 *=========================================================================*/
void CSrCamsRecord::Destroy (void) 
{
	m_pModel = NULL;
	m_pModtData = NULL;
	m_pCamsData = NULL;
	m_pImageSpace = NULL;

	CSrIdRecord::Destroy();
}
/*===========================================================================
 *		End of Class Method CSrCamsRecord::Destroy()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CSrCamsRecord Method - void InitializeNew (void);
 *
 *=========================================================================*/
void CSrCamsRecord::InitializeNew (void) 
{
	CSrIdRecord::InitializeNew();

	AddNewSubrecord(SR_NAME_DATA);
	if (m_pCamsData != NULL) m_pCamsData->InitializeNew();

}
/*===========================================================================
 *		End of Class Method CSrCamsRecord::InitializeNew()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CSrCamsRecord Event - void OnAddSubrecord (pSubrecord);
 *
 *=========================================================================*/
void CSrCamsRecord::OnAddSubrecord (CSrSubrecord* pSubrecord) {

	if (pSubrecord->GetRecordType() == SR_NAME_MODL)
	{
		m_pModel = SrCastClass(CSrStringSubrecord, pSubrecord);
	}
	else if (pSubrecord->GetRecordType() == SR_NAME_MODT)
	{
		m_pModtData = SrCastClass(CSrDataSubrecord, pSubrecord);
	}
	else if (pSubrecord->GetRecordType() == SR_NAME_DATA)
	{
		m_pCamsData = SrCastClass(CSrCamsDataSubrecord, pSubrecord);
	}
	else if (pSubrecord->GetRecordType() == SR_NAME_MNAM)
	{
		m_pImageSpace = SrCastClass(CSrFormidSubrecord, pSubrecord);
	}
	else
	{
		CSrIdRecord::OnAddSubrecord(pSubrecord);
	}

}
/*===========================================================================
 *		End of Class Event CSrCamsRecord::OnAddSubRecord()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CSrCamsRecord Event - void OnDeleteSubrecord (pSubrecord);
 *
 *=========================================================================*/
void CSrCamsRecord::OnDeleteSubrecord (CSrSubrecord* pSubrecord) {

	if (m_pModel == pSubrecord)
		m_pModel = NULL;
	else if (m_pModtData == pSubrecord)
		m_pModtData = NULL;
	else if (m_pCamsData == pSubrecord)
		m_pCamsData = NULL;
	else if (m_pImageSpace == pSubrecord)
		m_pImageSpace = NULL;
	else
		CSrIdRecord::OnDeleteSubrecord(pSubrecord);

}
/*===========================================================================
 *		End of Class Event CSrCamsRecord::OnDeleteSubrecord()
 *=========================================================================*/


/*===========================================================================
 *
 * Begin CSrCamsRecord Get Field Methods
 *
 *=========================================================================*/
/*===========================================================================
 *		End of CSrCamsRecord Get Field Methods
 *=========================================================================*/


/*===========================================================================
 *
 * Begin CSrCamsRecord Compare Field Methods
 *
 *=========================================================================*/
/*===========================================================================
 *		End of CSrCamsRecord Compare Field Methods
 *=========================================================================*/


/*===========================================================================
 *
 * Begin CSrCamsRecord Set Field Methods
 *
 *=========================================================================*/
/*===========================================================================
 *		End of CSrCamsRecord Set Field Methods
 *=========================================================================*/

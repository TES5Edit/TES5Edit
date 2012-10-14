/*===========================================================================
 *
 * File:		SrClfmRecord.CPP
 * Author:		Dave Humphrey (dave@uesp.net)
 * Created On:	5 December 2011
 *
 * Description
 *
 *=========================================================================*/

	/* Include Files */
#include "srClfmrecord.h"


srrgba_t	CSrClfmRecord::s_NullColor;


/*===========================================================================
 *
 * Begin Subrecord Creation Array
 *
 *=========================================================================*/
BEGIN_SRSUBRECCREATE(CSrClfmRecord, CSrIdRecord)
	DEFINE_SRSUBRECCREATE(SR_NAME_FNAM, CSrDwordSubrecord::Create)
	DEFINE_SRSUBRECCREATE(SR_NAME_CNAM, CSrDwordSubrecord::Create)
	DEFINE_SRSUBRECCREATE(SR_NAME_FULL, CSrLStringSubrecord::Create)
END_SRSUBRECCREATE()
/*===========================================================================
 *		End of Subrecord Creation Array
 *=========================================================================*/


/*===========================================================================
 *
 * Begin CSrRecord Field Map
 *
 *=========================================================================*/
BEGIN_SRFIELDMAP(CSrClfmRecord, CSrIdRecord)
	ADD_SRFIELDALL("ItemName",		SR_FIELD_ITEMNAME,			0, CSrClfmRecord, FieldItemName)
	ADD_SRFIELDALL("FName",			SR_FIELD_UNKNOWN1,			0, CSrClfmRecord, FieldUnknown1)
	ADD_SRFIELDALL("Red",			SR_FIELD_REDCOLOR,			0, CSrClfmRecord, FieldRedColor)
	ADD_SRFIELDALL("Green",			SR_FIELD_GREENCOLOR,		0, CSrClfmRecord, FieldGreenColor)
	ADD_SRFIELDALL("Blue",			SR_FIELD_BLUECOLOR,			0, CSrClfmRecord, FieldBlueColor)		
END_SRFIELDMAP()
/*===========================================================================
 *		End of CObRecord Field Map
 *=========================================================================*/


/*===========================================================================
 *
 * Class CSrClfmRecord Constructor
 *
 *=========================================================================*/
CSrClfmRecord::CSrClfmRecord () 
{
	m_pFnamData = NULL;
	m_pColor = NULL;
	m_pItemName = NULL;
}
/*===========================================================================
 *		End of Class CSrClfmRecord Constructor
 *=========================================================================*/


/*===========================================================================
 *
 * Class CSrClfmRecord Method - void Destroy (void);
 *
 *=========================================================================*/
void CSrClfmRecord::Destroy (void) 
{
	m_pFnamData = NULL;
	m_pColor = NULL;
	m_pItemName = NULL;

	CSrIdRecord::Destroy();
}
/*===========================================================================
 *		End of Class Method CSrClfmRecord::Destroy()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CSrClfmRecord Method - void InitializeNew (void);
 *
 *=========================================================================*/
void CSrClfmRecord::InitializeNew (void) 
{
	CSrIdRecord::InitializeNew();

	AddNewSubrecord(SR_NAME_FULL);
	if (m_pItemName != NULL) m_pItemName->InitializeNew();

	AddNewSubrecord(SR_NAME_CNAM);
	if (m_pColor != NULL) m_pColor->InitializeNew();

	AddNewSubrecord(SR_NAME_FNAM);

	if (m_pFnamData != NULL) 
	{
		m_pFnamData->InitializeNew();
		m_pFnamData->SetValue(1);
	}

}
/*===========================================================================
 *		End of Class Method CSrClfmRecord::InitializeNew()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CSrClfmRecord Event - void OnAddSubrecord (pSubrecord);
 *
 *=========================================================================*/
void CSrClfmRecord::OnAddSubrecord (CSrSubrecord* pSubrecord) {

	if (pSubrecord->GetRecordType() == SR_NAME_FNAM)
	{
		m_pFnamData = SrCastClass(CSrDwordSubrecord, pSubrecord);
	}
	else if (pSubrecord->GetRecordType() == SR_NAME_CNAM)
	{
		m_pColor = SrCastClass(CSrDwordSubrecord, pSubrecord);
	}
	else if (pSubrecord->GetRecordType() == SR_NAME_FULL)
	{
		m_pItemName = SrCastClass(CSrLStringSubrecord, pSubrecord);
	}
	else
	{
		CSrIdRecord::OnAddSubrecord(pSubrecord);
	}

}
/*===========================================================================
 *		End of Class Event CSrClfmRecord::OnAddSubRecord()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CSrClfmRecord Event - void OnDeleteSubrecord (pSubrecord);
 *
 *=========================================================================*/
void CSrClfmRecord::OnDeleteSubrecord (CSrSubrecord* pSubrecord) {

	if (m_pFnamData == pSubrecord)
		m_pFnamData = NULL;
	else if (m_pItemName == pSubrecord)
		m_pItemName = NULL;
	else if (m_pColor == pSubrecord)
		m_pColor = NULL;
	else
		CSrIdRecord::OnDeleteSubrecord(pSubrecord);

}
/*===========================================================================
 *		End of Class Event CSrClfmRecord::OnDeleteSubrecord()
 *=========================================================================*/


/*===========================================================================
 *
 * Begin CSrClfmRecord Get Field Methods
 *
 *=========================================================================*/
/*===========================================================================
 *		End of CSrClfmRecord Get Field Methods
 *=========================================================================*/


/*===========================================================================
 *
 * Begin CSrClfmRecord Compare Field Methods
 *
 *=========================================================================*/
/*===========================================================================
 *		End of CSrClfmRecord Compare Field Methods
 *=========================================================================*/


/*===========================================================================
 *
 * Begin CSrClfmRecord Set Field Methods
 *
 *=========================================================================*/
/*===========================================================================
 *		End of CSrClfmRecord Set Field Methods
 *=========================================================================*/

/*===========================================================================
 *
 * File:		SrSounRecord.CPP
 * Author:		Dave Humphrey (dave@uesp.net)
 * Created On:	5 December 2011
 *
 * Description
 *
 *=========================================================================*/

	/* Include Files */
#include "srSounrecord.h"


srsndddata_t CSrSounRecord::s_NullSnddData;


/*===========================================================================
 *
 * Begin Subrecord Creation Array
 *
 *=========================================================================*/
BEGIN_SRSUBRECCREATE(CSrSounRecord, CSrIdRecord)
	DEFINE_SRSUBRECCREATE(SR_NAME_FNAM, CSrStringSubrecord::Create)
	DEFINE_SRSUBRECCREATE(SR_NAME_SDSC, CSrFormidSubrecord::Create)
	DEFINE_SRSUBRECCREATE(SR_NAME_SNDD, CSrSnddDataSubrecord::Create)
END_SRSUBRECCREATE()
/*===========================================================================
 *		End of Subrecord Creation Array
 *=========================================================================*/


/*===========================================================================
 *
 * Begin CSrIdRecord Field Map
 *
 *=========================================================================*/
BEGIN_SRFIELDMAP(CSrSounRecord, CSrIdRecord)
	ADD_SRFIELDALL("SoundFile",			SR_FIELD_SOUNDFILE,			0, CSrSounRecord, FieldSoundFile)
	ADD_SRFIELDALL("SoundRef",			SR_FIELD_SOUNDREF,			0, CSrSounRecord, FieldSoundRef)
	ADD_SRFIELDALL("Unknown1",			SR_FIELD_UNKNOWN1,			0, CSrSounRecord, FieldUnknown1)
	ADD_SRFIELDALL("Unknown2",			SR_FIELD_UNKNOWN2,			0, CSrSounRecord, FieldUnknown2)
	ADD_SRFIELDALL("Unknown3",			SR_FIELD_UNKNOWN3,			0, CSrSounRecord, FieldUnknown3)
	ADD_SRFIELDALL("Unknown4",			SR_FIELD_UNKNOWN4,			0, CSrSounRecord, FieldUnknown4)
	ADD_SRFIELDALL("Unknown5",			SR_FIELD_UNKNOWN5,			0, CSrSounRecord, FieldUnknown5)
	ADD_SRFIELDALL("Unknown6",			SR_FIELD_UNKNOWN6,			0, CSrSounRecord, FieldUnknown6)
	ADD_SRFIELDALL("Unknown7",			SR_FIELD_UNKNOWN7,			0, CSrSounRecord, FieldUnknown7)
	ADD_SRFIELDALL("Unknown8",			SR_FIELD_UNKNOWN8,			0, CSrSounRecord, FieldUnknown8)
	ADD_SRFIELDALL("Unknown9",			SR_FIELD_UNKNOWN9,			0, CSrSounRecord, FieldUnknown9)
	ADD_SRFIELDALL("Unknown10",			SR_FIELD_UNKNOWN10,			0, CSrSounRecord, FieldUnknown10)
	ADD_SRFIELDALL("Unknown11",			SR_FIELD_UNKNOWN11,			0, CSrSounRecord, FieldUnknown11)
	ADD_SRFIELDALL("Unknown21",			SR_FIELD_UNKNOWN12,			0, CSrSounRecord, FieldUnknown12)
END_SRFIELDMAP()
/*===========================================================================
 *		End of CObRecord Field Map
 *=========================================================================*/


/*===========================================================================
 *
 * Class CSrSounRecord Constructor
 *
 *=========================================================================*/
CSrSounRecord::CSrSounRecord () 
{
	m_pSoundFile = NULL;
	m_pSoundRef = NULL;
	m_pSoundData = NULL;
}
/*===========================================================================
 *		End of Class CSrSounRecord Constructor
 *=========================================================================*/


/*===========================================================================
 *
 * Class CSrSounRecord Method - void Destroy (void);
 *
 *=========================================================================*/
void CSrSounRecord::Destroy (void) 
{
	m_pSoundFile = NULL;
	m_pSoundRef = NULL;
	m_pSoundData = NULL;

	CSrIdRecord::Destroy();
}
/*===========================================================================
 *		End of Class Method CSrSounRecord::Destroy()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CSrSounRecord Method - void InitializeNew (void);
 *
 *=========================================================================*/
void CSrSounRecord::InitializeNew (void) 
{
	CSrIdRecord::InitializeNew();

	AddNewSubrecord(SR_NAME_SNDD);
	if (m_pSoundData != NULL) m_pSoundData->InitializeNew();

	AddNewSubrecord(SR_NAME_FNAM);
	if (m_pSoundFile != NULL) m_pSoundFile->InitializeNew();
}
/*===========================================================================
 *		End of Class Method CSrSounRecord::InitializeNew()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CSrSounRecord Event - void OnAddSubrecord (pSubrecord);
 *
 *=========================================================================*/
void CSrSounRecord::OnAddSubrecord (CSrSubrecord* pSubrecord) {

	if (pSubrecord->GetRecordType() == SR_NAME_FNAM)
	{
		m_pSoundFile = SrCastClass(CSrStringSubrecord, pSubrecord);
	}
	else if (pSubrecord->GetRecordType() == SR_NAME_SDSC)
	{
		m_pSoundRef = SrCastClass(CSrFormidSubrecord, pSubrecord);
	}
	else if (pSubrecord->GetRecordType() == SR_NAME_SNDD)
	{
		m_pSoundData = SrCastClass(CSrSnddDataSubrecord, pSubrecord);
	}
	else
	{
		CSrIdRecord::OnAddSubrecord(pSubrecord);
	}

}
/*===========================================================================
 *		End of Class Event CSrSounRecord::OnAddSubRecord()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CSrSounRecord Event - void OnDeleteSubrecord (pSubrecord);
 *
 *=========================================================================*/
void CSrSounRecord::OnDeleteSubrecord (CSrSubrecord* pSubrecord) {

	if (m_pSoundFile == pSubrecord)
		m_pSoundFile = NULL;
	else if (m_pSoundRef == pSubrecord)
		m_pSoundRef = NULL;
	else if (m_pSoundData == pSubrecord)
		m_pSoundData = NULL;
	else
		CSrIdRecord::OnDeleteSubrecord(pSubrecord);

}
/*===========================================================================
 *		End of Class Event CSrSounRecord::OnDeleteSubrecord()
 *=========================================================================*/


/*===========================================================================
 *
 * Begin CSrSounRecord Get Field Methods
 *
 *=========================================================================*/
/*===========================================================================
 *		End of CSrSounRecord Get Field Methods
 *=========================================================================*/


/*===========================================================================
 *
 * Begin CSrSounRecord Compare Field Methods
 *
 *=========================================================================*/
/*===========================================================================
 *		End of CSrSounRecord Compare Field Methods
 *=========================================================================*/


/*===========================================================================
 *
 * Begin CSrSounRecord Set Field Methods
 *
 *=========================================================================*/
/*===========================================================================
 *		End of CSrSounRecord Set Field Methods
 *=========================================================================*/

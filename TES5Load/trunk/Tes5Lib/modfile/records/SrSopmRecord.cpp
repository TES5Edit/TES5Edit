/*===========================================================================
 *
 * File:		SrSopmRecord.CPP
 * Author:		Dave Humphrey (dave@uesp.net)
 * Created On:	5 December 2011
 *
 * Description
 *
 *=========================================================================*/

	/* Include Files */
#include "srSopmrecord.h"


/*===========================================================================
 *
 * Begin Subrecord Creation Array
 *
 *=========================================================================*/
BEGIN_SRSUBRECCREATE(CSrSopmRecord, CSrIdRecord)
	DEFINE_SRSUBRECCREATE(SR_NAME_FNAM, CSrDwordSubrecord::Create)
	DEFINE_SRSUBRECCREATE(SR_NAME_NAM1, CSrDwordSubrecord::Create)
	DEFINE_SRSUBRECCREATE(SR_NAME_MNAM, CSrDwordSubrecord::Create)
	DEFINE_SRSUBRECCREATE(SR_NAME_ANAM, CSrSopmAnamSubrecord::Create)
	DEFINE_SRSUBRECCREATE(SR_NAME_ONAM, CSrSopmOnamSubrecord::Create)
	DEFINE_SRSUBRECCREATE(SR_NAME_SNAM, CSrSopmSnamSubrecord::Create)
	DEFINE_SRSUBRECCREATE(SR_NAME_CNAM, CSrDwordSubrecord::Create)
END_SRSUBRECCREATE()
/*===========================================================================
 *		End of Subrecord Creation Array
 *=========================================================================*/


/*===========================================================================
 *
 * Begin CSrIdRecord Field Map
 *
 *=========================================================================*/
BEGIN_SRFIELDMAP(CSrSopmRecord, CSrIdRecord)
	ADD_SRFIELDALL("Unknown1",			SR_FIELD_UNKNOWN1,			0, CSrSopmRecord, FieldUnknown1)
	ADD_SRFIELDALL("Unknown2",			SR_FIELD_UNKNOWN2,			0, CSrSopmRecord, FieldUnknown2)
	ADD_SRFIELDALL("Unknown3",			SR_FIELD_UNKNOWN3,			0, CSrSopmRecord, FieldUnknown3)
	ADD_SRFIELDALL("SoundFlags",		SR_FIELD_SOUNDFLAGS,		0, CSrSopmRecord, FieldSoundFlags)
END_SRFIELDMAP()
/*===========================================================================
 *		End of CObRecord Field Map
 *=========================================================================*/


/*===========================================================================
 *
 * Class CSrSopmRecord Constructor
 *
 *=========================================================================*/
CSrSopmRecord::CSrSopmRecord () 
{
	m_pFlags = NULL;
	m_pNam1Data = NULL;
	m_pMnamData = NULL;
	m_pAnamData = NULL;
	m_pOnamData = NULL;
	m_pSnamData = NULL;
	m_pCnamData = NULL;
}
/*===========================================================================
 *		End of Class CSrSopmRecord Constructor
 *=========================================================================*/


/*===========================================================================
 *
 * Class CSrSopmRecord Method - void Destroy (void);
 *
 *=========================================================================*/
void CSrSopmRecord::Destroy (void) 
{
	m_pFlags = NULL;
	m_pNam1Data = NULL;
	m_pMnamData = NULL;
	m_pAnamData = NULL;
	m_pOnamData = NULL;
	m_pSnamData = NULL;
	m_pCnamData = NULL;

	CSrIdRecord::Destroy();
}
/*===========================================================================
 *		End of Class Method CSrSopmRecord::Destroy()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CSrSopmRecord Method - void InitializeNew (void);
 *
 *=========================================================================*/
void CSrSopmRecord::InitializeNew (void) 
{
	CSrIdRecord::InitializeNew();

	AddNewSubrecord(SR_NAME_MNAM);
	if (m_pMnamData != NULL) m_pMnamData->InitializeNew();

}
/*===========================================================================
 *		End of Class Method CSrSopmRecord::InitializeNew()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CSrSopmRecord Event - void OnAddSubrecord (pSubrecord);
 *
 *=========================================================================*/
void CSrSopmRecord::OnAddSubrecord (CSrSubrecord* pSubrecord) {

	if (pSubrecord->GetRecordType() == SR_NAME_FNAM)
	{
		m_pFlags = SrCastClass(CSrDwordSubrecord, pSubrecord);
	}
	else if (pSubrecord->GetRecordType() == SR_NAME_NAM1)
	{
		m_pNam1Data = SrCastClass(CSrDwordSubrecord, pSubrecord);
	}
	else if (pSubrecord->GetRecordType() == SR_NAME_MNAM)
	{
		m_pMnamData = SrCastClass(CSrDwordSubrecord, pSubrecord);
	}
	else if (pSubrecord->GetRecordType() == SR_NAME_ANAM)
	{
		m_pAnamData = SrCastClass(CSrSopmAnamSubrecord, pSubrecord);
	}
	else if (pSubrecord->GetRecordType() == SR_NAME_ONAM)
	{
		m_pOnamData = SrCastClass(CSrSopmOnamSubrecord, pSubrecord);
	}
	else if (pSubrecord->GetRecordType() == SR_NAME_SNAM)
	{
		m_pSnamData = SrCastClass(CSrSopmSnamSubrecord, pSubrecord);
	}
	else if (pSubrecord->GetRecordType() == SR_NAME_CNAM)
	{
		m_pCnamData = SrCastClass(CSrDwordSubrecord, pSubrecord);
	}
	else
	{
		CSrIdRecord::OnAddSubrecord(pSubrecord);
	}

}
/*===========================================================================
 *		End of Class Event CSrSopmRecord::OnAddSubRecord()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CSrSopmRecord Event - void OnDeleteSubrecord (pSubrecord);
 *
 *=========================================================================*/
void CSrSopmRecord::OnDeleteSubrecord (CSrSubrecord* pSubrecord) {

	if (m_pFlags == pSubrecord)
		m_pFlags = NULL;
	else if (m_pNam1Data == pSubrecord)
		m_pNam1Data = NULL;
	else if (m_pMnamData == pSubrecord)
		m_pMnamData = NULL;
	else if (m_pAnamData == pSubrecord)
		m_pAnamData = NULL;
	else if (m_pOnamData == pSubrecord)
		m_pOnamData = NULL;
	else if (m_pSnamData == pSubrecord)
		m_pSnamData = NULL;
	else if (m_pCnamData == pSubrecord)
		m_pCnamData = NULL;
	else
		CSrIdRecord::OnDeleteSubrecord(pSubrecord);

}
/*===========================================================================
 *		End of Class Event CSrSopmRecord::OnDeleteSubrecord()
 *=========================================================================*/


int CSrSopmRecord::GetContentType (void)
{
	if (m_pFlags != NULL) return SR_SOPMCONTENTTYPE_FNAM;

	if (m_pAnamData != NULL)
	{
		if (m_pOnamData != NULL) return SR_SOPMCONTENTTYPE_ANAMONAM;
		return SR_SOPMCONTENTTYPE_ANAM;
	}

	if (m_pOnamData != NULL) return SR_SOPMCONTENTTYPE_ONAM;
	return SR_SOPMCONTENTTYPE_UNKNOWN;
}


void CSrSopmRecord::SetContentType (const int Type)
{
	switch (Type)
	{
		case SR_SOPMCONTENTTYPE_UNKNOWN:
			break;
		case SR_SOPMCONTENTTYPE_FNAM:		
			if (m_pFlags    == NULL) { AddNewSubrecord(SR_NAME_FNAM); if (m_pFlags)    { m_pFlags->InitializeNew(); m_pFlags->SetValue(1); } }
			if (m_pCnamData == NULL) { AddNewSubrecord(SR_NAME_CNAM); if (m_pCnamData) { m_pCnamData->InitializeNew(); m_pCnamData->SetValue(2); } }
			if (m_pSnamData == NULL) { AddNewSubrecord(SR_NAME_SNAM); if (m_pSnamData) m_pSnamData->InitializeNew(); }
			if (m_pAnamData == NULL) { AddNewSubrecord(SR_NAME_ANAM); if (m_pAnamData) m_pAnamData->InitializeNew(); }
			DeleteSubrecords(SR_NAME_NAM1);
			DeleteSubrecords(SR_NAME_ONAM);
			m_pNam1Data = NULL;
			m_pOnamData = NULL;
			if (m_pMnamData) m_pMnamData->FlipFlag(0x01, false);
			break;
		case SR_SOPMCONTENTTYPE_ANAM:		
			if (m_pAnamData == NULL) { AddNewSubrecord(SR_NAME_ANAM); if (m_pAnamData) m_pAnamData->InitializeNew(); }
			if (m_pNam1Data == NULL) { AddNewSubrecord(SR_NAME_NAM1); if (m_pNam1Data) m_pNam1Data->InitializeNew(); }
			DeleteSubrecords(SR_NAME_FNAM);
			DeleteSubrecords(SR_NAME_CNAM);
			DeleteSubrecords(SR_NAME_SNAM);
			DeleteSubrecords(SR_NAME_ONAM);
			m_pFlags = NULL;
			m_pCnamData = NULL;
			m_pSnamData = NULL;
			m_pOnamData = NULL;
			if (m_pMnamData) m_pMnamData->FlipFlag(0x01, false);
			if (m_pNam1Data) m_pNam1Data->FlipFlag(0x01, true);
			break;
		case SR_SOPMCONTENTTYPE_ONAM:	
			if (m_pOnamData == NULL) { AddNewSubrecord(SR_NAME_ONAM); if (m_pOnamData) m_pOnamData->InitializeNew(); }
			if (m_pNam1Data == NULL) { AddNewSubrecord(SR_NAME_NAM1); if (m_pNam1Data) m_pNam1Data->InitializeNew(); }
			DeleteSubrecords(SR_NAME_FNAM);
			DeleteSubrecords(SR_NAME_CNAM);
			DeleteSubrecords(SR_NAME_ANAM);
			DeleteSubrecords(SR_NAME_SNAM);
			m_pFlags = NULL;
			m_pCnamData = NULL;
			m_pSnamData = NULL;
			m_pAnamData = NULL;
			if (m_pMnamData) m_pMnamData->FlipFlag(0x01, true);
			if (m_pNam1Data) m_pNam1Data->FlipFlag(0x01, false);
			break;
		case SR_SOPMCONTENTTYPE_ANAMONAM:
			if (m_pAnamData == NULL) { AddNewSubrecord(SR_NAME_ANAM); if (m_pAnamData) m_pAnamData->InitializeNew(); }
			if (m_pOnamData == NULL) { AddNewSubrecord(SR_NAME_ONAM); if (m_pOnamData) m_pOnamData->InitializeNew(); }
			if (m_pNam1Data == NULL) { AddNewSubrecord(SR_NAME_NAM1); if (m_pNam1Data) m_pNam1Data->InitializeNew(); }
			DeleteSubrecords(SR_NAME_FNAM);
			DeleteSubrecords(SR_NAME_CNAM);
			DeleteSubrecords(SR_NAME_SNAM);
			m_pFlags = NULL;
			m_pCnamData = NULL;
			m_pSnamData = NULL;
			if (m_pMnamData) m_pMnamData->FlipFlag(0x01, true);
			if (m_pNam1Data) m_pNam1Data->FlipFlag(0x01, true);
			break;
	}
	
}


/*===========================================================================
 *
 * Begin CSrSopmRecord Get Field Methods
 *
 *=========================================================================*/
/*===========================================================================
 *		End of CSrSopmRecord Get Field Methods
 *=========================================================================*/


/*===========================================================================
 *
 * Begin CSrSopmRecord Compare Field Methods
 *
 *=========================================================================*/
/*===========================================================================
 *		End of CSrSopmRecord Compare Field Methods
 *=========================================================================*/


/*===========================================================================
 *
 * Begin CSrSopmRecord Set Field Methods
 *
 *=========================================================================*/
/*===========================================================================
 *		End of CSrSopmRecord Set Field Methods
 *=========================================================================*/

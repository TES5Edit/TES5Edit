/*===========================================================================
 *
 * File:		SrAvifRecord.CPP
 * Author:		Dave Humphrey (dave@uesp.net)
 * Created On:	5 December 2011
 *
 * Description
 *
 *=========================================================================*/

	/* Include Files */
#include "srAvifrecord.h"


sravskdata_t CSrAvifRecord::s_NullAvskData;


/*===========================================================================
 *
 * Begin Subrecord Creation Array
 *
 *=========================================================================*/
BEGIN_SRSUBRECCREATE(CSrAvifRecord, CSrIdRecord)
	DEFINE_SRSUBRECCREATE(SR_NAME_AVSK, CSrAvskSubrecord::Create)
	DEFINE_SRSUBRECCREATE(SR_NAME_FNAM, CSrDwordSubrecord::Create)
	DEFINE_SRSUBRECCREATE(SR_NAME_FULL, CSrLStringSubrecord::Create)
	DEFINE_SRSUBRECCREATE(SR_NAME_CNAM, CSrDwordSubrecord::Create)
	DEFINE_SRSUBRECCREATE(SR_NAME_DESC, CSrLStringSubrecord::Create)
	DEFINE_SRSUBRECCREATE(SR_NAME_XNAM, CSrDwordSubrecord::Create)
	DEFINE_SRSUBRECCREATE(SR_NAME_PNAM, CSrFormidSubrecord::Create)
	DEFINE_SRSUBRECCREATE(SR_NAME_YNAM, CSrDwordSubrecord::Create)
	DEFINE_SRSUBRECCREATE(SR_NAME_HNAM, CSrFloatSubrecord::Create)
	DEFINE_SRSUBRECCREATE(SR_NAME_VNAM, CSrFloatSubrecord::Create)
	DEFINE_SRSUBRECCREATE(SR_NAME_SNAM, CSrFormidSubrecord::Create)
	DEFINE_SRSUBRECCREATE(SR_NAME_INAM, CSrDwordSubrecord::Create)
	DEFINE_SRSUBRECCREATE(SR_NAME_ANAM, CSrStringSubrecord::Create)
END_SRSUBRECCREATE()
/*===========================================================================
 *		End of Subrecord Creation Array
 *=========================================================================*/


/*===========================================================================
 *
 * Begin CSrRecord Field Map
 *
 *=========================================================================*/
BEGIN_SRFIELDMAP(CSrAvifRecord, CSrIdRecord)
	ADD_SRFIELDALL("ItemName",		SR_FIELD_ITEMNAME,		0, CSrAvifRecord, FieldItemName)
	ADD_SRFIELDALL("Description",	SR_FIELD_DESCRIPTION,	0, CSrAvifRecord, FieldDescription)
	ADD_SRFIELDALL("Unknown1",		SR_FIELD_UNKNOWN1,		0, CSrAvifRecord, FieldUnknown1)
	ADD_SRFIELDALL("Unknown2",		SR_FIELD_UNKNOWN2,		0, CSrAvifRecord, FieldUnknown2)
	ADD_SRFIELDALL("Unknown3",		SR_FIELD_UNKNOWN3,		0, CSrAvifRecord, FieldUnknown3)
	ADD_SRFIELDALL("Unknown4",		SR_FIELD_UNKNOWN4,		0, CSrAvifRecord, FieldUnknown4)
	ADD_SRFIELDALL("Sections",		SR_FIELD_SECTIONCOUNT,	0, CSrAvifRecord, FieldSections)
	ADD_SRFIELDALL("CName",			SR_FIELD_CNAME,			0, CSrAvifRecord, FieldCName)
	ADD_SRFIELDALL("AName",			SR_FIELD_ANAME,			0, CSrAvifRecord, FieldAName)
END_SRFIELDMAP()
/*===========================================================================
 *		End of CObRecord Field Map
 *=========================================================================*/


/*===========================================================================
 *
 * Class CSrAvifRecord Constructor
 *
 *=========================================================================*/
CSrAvifRecord::CSrAvifRecord () 
{
	m_pItemName = NULL;
	m_pCnamData = NULL;
	m_pDescription = NULL;
	m_pAvData = NULL;
	m_pAnamData = NULL;
}
/*===========================================================================
 *		End of Class CSrAvifRecord Constructor
 *=========================================================================*/


/*===========================================================================
 *
 * Class CSrAvifRecord Method - void Destroy (void);
 *
 *=========================================================================*/
void CSrAvifRecord::Destroy (void) 
{
	m_pItemName = NULL;
	m_pCnamData = NULL;
	m_pDescription = NULL;
	m_pAvData = NULL;
	m_pAnamData = NULL;

	CSrIdRecord::Destroy();
}
/*===========================================================================
 *		End of Class Method CSrAvifRecord::Destroy()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CSrAvifRecord Method - void InitializeNew (void);
 *
 *=========================================================================*/
void CSrAvifRecord::InitializeNew (void) 
{
	CSrIdRecord::InitializeNew();

	AddInitNewSubrecord(SR_NAME_DESC);
	AddInitNewSubrecord(SR_NAME_CNAM);
}
/*===========================================================================
 *		End of Class Method CSrAvifRecord::InitializeNew()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CSrAvifRecord Event - void OnAddSubrecord (pSubrecord);
 *
 *=========================================================================*/
void CSrAvifRecord::OnAddSubrecord (CSrSubrecord* pSubrecord) {

	if (pSubrecord->GetRecordType() == SR_NAME_AVSK)
	{
		m_pAvData = SrCastClass(CSrAvskSubrecord, pSubrecord);
	}
	else if (pSubrecord->GetRecordType() == SR_NAME_FULL)
	{
		m_pItemName = SrCastClass(CSrLStringSubrecord, pSubrecord);
	}
	else if (pSubrecord->GetRecordType() == SR_NAME_CNAM && m_pCnamData == NULL)
	{
		m_pCnamData = SrCastClass(CSrDwordSubrecord, pSubrecord);
	}
	else if (pSubrecord->GetRecordType() == SR_NAME_DESC)
	{
		m_pDescription = SrCastClass(CSrLStringSubrecord, pSubrecord);
	}
	else if (pSubrecord->GetRecordType() == SR_NAME_ANAM)
	{
		m_pAnamData = SrCastClass(CSrStringSubrecord, pSubrecord);
	}
	else
	{
		CSrIdRecord::OnAddSubrecord(pSubrecord);
	}

}
/*===========================================================================
 *		End of Class Event CSrAvifRecord::OnAddSubRecord()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CSrAvifRecord Event - void OnDeleteSubrecord (pSubrecord);
 *
 *=========================================================================*/
void CSrAvifRecord::OnDeleteSubrecord (CSrSubrecord* pSubrecord) {

	if (m_pAvData == pSubrecord)
		m_pAvData = NULL;
	else if (m_pCnamData == pSubrecord)
		m_pCnamData = NULL;
	else if (m_pItemName == pSubrecord)
		m_pItemName = NULL;
	else if (m_pDescription == pSubrecord)
		m_pDescription = NULL;
	else if (m_pAnamData == pSubrecord)
		m_pAnamData = NULL;
	else
		CSrIdRecord::OnDeleteSubrecord(pSubrecord);

}
/*===========================================================================
 *		End of Class Event CSrAvifRecord::OnDeleteSubrecord()
 *=========================================================================*/


void CSrAvifRecord::SetAName (const char* pString)
{

	if (pString == NULL || *pString == '\0')
	{
		DeleteSubrecords(SR_NAME_ANAM);
		m_pAnamData = NULL;
		return;
	}

	if (m_pAnamData == NULL)
	{
		AddInitNewSubrecordAfter(SR_NAME_ANAM, SR_NAME_DESC);
		if (m_pAnamData == NULL) return;
	}

	m_pAnamData->SetString(pString);
}


void CSrAvifRecord::CreateSectionInfo (CSrAvifSectionArray& InfoArray)
{ 
	int				 Position;
	CSrSubrecord*	 pSubrecord = FindFirstSubrecord(SR_NAME_PNAM, Position);
	sravifsection_t* pCurrentSection = NULL;

	InfoArray.Destroy();
	if (pSubrecord == NULL) return;

	for (dword i = Position; i < m_Subrecords.GetSize(); ++i)
	{
		pSubrecord = m_Subrecords[i];

		if (pSubrecord->GetRecordType() == SR_NAME_PNAM)
		{
			pCurrentSection = InfoArray.AddNew();
			pCurrentSection->PName.CopyFull(pSubrecord);
		}

		if (pCurrentSection == NULL)
		{
			SystemLog.Printf("Warning: Invalid AVIF section format at subrecord[%d] %4.4s!", i+1, pSubrecord->GetRecordType().Name);
			continue;
		}

		if (pSubrecord->GetRecordType() == SR_NAME_FNAM)
		{
			pCurrentSection->FName.CopyFull(pSubrecord);
		}
		else if (pSubrecord->GetRecordType() == SR_NAME_XNAM)
		{
			pCurrentSection->XName.CopyFull(pSubrecord);
		}
		else if (pSubrecord->GetRecordType() == SR_NAME_YNAM)
		{
			pCurrentSection->YName.CopyFull(pSubrecord);
		}
		else if (pSubrecord->GetRecordType() == SR_NAME_HNAM)
		{
			pCurrentSection->HName.CopyFull(pSubrecord);
		}
		else if (pSubrecord->GetRecordType() == SR_NAME_VNAM)
		{
			pCurrentSection->VName.CopyFull(pSubrecord);
		}
		else if (pSubrecord->GetRecordType() == SR_NAME_SNAM)
		{
			pCurrentSection->SName.CopyFull(pSubrecord);
		}
		else if (pSubrecord->GetRecordType() == SR_NAME_CNAM)
		{
			pCurrentSection->CNames.AddNew()->CopyFull(pSubrecord);
		}
		else if (pSubrecord->GetRecordType() == SR_NAME_INAM)
		{
			pCurrentSection->IName.CopyFull(pSubrecord);
			pCurrentSection->CheckNew();
			pCurrentSection = NULL;
		}
	}

}


void CSrAvifRecord::CreateFromSectionInfo (CSrAvifSectionArray& InfoArray)
{
	CSrDwordSubrecord* pCNameCopy = NULL;

		/* Save the first CNAM if required */
	for (dword i = 0; i < m_Subrecords.GetSize(); ++i)
	{
		if (m_Subrecords[i]->GetRecordType() == SR_NAME_PNAM) break;

		if (m_Subrecords[i]->GetRecordType() == SR_NAME_CNAM) 
		{
			pCNameCopy = new CSrDwordSubrecord;
			pCNameCopy->CopyFull(m_Subrecords[i]);
			break;
		}
	}

	DeleteSubrecords(SR_NAME_PNAM);	DeleteSubrecords(SR_NAME_FNAM);	DeleteSubrecords(SR_NAME_XNAM);
	DeleteSubrecords(SR_NAME_YNAM);	DeleteSubrecords(SR_NAME_HNAM);	DeleteSubrecords(SR_NAME_VNAM);
	DeleteSubrecords(SR_NAME_SNAM);	DeleteSubrecords(SR_NAME_CNAM);	DeleteSubrecords(SR_NAME_INAM);

		/* Re-add the saved CNAM if needed */
	if (pCNameCopy != NULL)
	{
		AddNewSubrecordAfter(SR_NAME_CNAM, SR_NAME_DESC)->CopyFull(pCNameCopy);
		delete pCNameCopy;
		pCNameCopy = NULL;
	}

	for (dword i = 0; i < InfoArray.GetSize(); ++i)
	{
		sravifsection_t& Section = *InfoArray[i];

		AddNewSubrecord(SR_NAME_PNAM)->Copy(&Section.PName);
		AddNewSubrecord(SR_NAME_FNAM)->Copy(&Section.FName);
		AddNewSubrecord(SR_NAME_XNAM)->Copy(&Section.XName);
		AddNewSubrecord(SR_NAME_YNAM)->Copy(&Section.YName);
		AddNewSubrecord(SR_NAME_HNAM)->Copy(&Section.HName);
		AddNewSubrecord(SR_NAME_VNAM)->Copy(&Section.VName);
		AddNewSubrecord(SR_NAME_SNAM)->Copy(&Section.SName);

		for (dword j = 0; j < Section.CNames.GetSize(); ++j)
		{
			AddNewSubrecord(SR_NAME_CNAM)->Copy(Section.CNames[j]);
		}

		AddNewSubrecord(SR_NAME_INAM)->Copy(&Section.IName);
	}

}
/*===========================================================================
 *
 * File:		SrPerkRecord.CPP
 * Author:		Dave Humphrey (dave@uesp.net)
 * Created On:	5 December 2011
 *
 * Description
 *
 *=========================================================================*/

	/* Include Files */
#include "srPerkrecord.h"


srperkdata_t CSrPerkRecord::s_NullPerkData = { 0, 0, 0 };


/*===========================================================================
 *
 * Begin Subrecord Creation Array
 *
 *=========================================================================*/
BEGIN_SRSUBRECCREATE(CSrPerkRecord, CSrIdRecord)
	DEFINE_SRSUBRECCREATE(SR_NAME_DESC, CSrLStringSubrecord::Create)
	DEFINE_SRSUBRECCREATE(SR_NAME_VMAD, CSrVmadSubrecord::Create)	
	DEFINE_SRSUBRECCREATE(SR_NAME_FULL, CSrLStringSubrecord::Create)
	DEFINE_SRSUBRECCREATE(SR_NAME_DATA, CSrPerkDataSubrecord::Create)	
	DEFINE_SRSUBRECCREATE(SR_NAME_CTDA, CSrCtdaSubrecord::Create)
	DEFINE_SRSUBRECCREATE(SR_NAME_CIS1, CSrStringSubrecord::Create)
	DEFINE_SRSUBRECCREATE(SR_NAME_CIS2, CSrStringSubrecord::Create)
	DEFINE_SRSUBRECCREATE(SR_NAME_NNAM, CSrFormidSubrecord::Create)
	DEFINE_SRSUBRECCREATE(SR_NAME_PRKC, CSrByteSubrecord::Create)
	DEFINE_SRSUBRECCREATE(SR_NAME_PRKE, CSrPrkeSubrecord::Create)
	DEFINE_SRSUBRECCREATE(SR_NAME_PRKF, CSrDataSubrecord::Create)	
	DEFINE_SRSUBRECCREATE(SR_NAME_EPFT, CSrByteSubrecord::Create)
	DEFINE_SRSUBRECCREATE(SR_NAME_EPFD, CSrEpfdSubrecord::Create)
	DEFINE_SRSUBRECCREATE(SR_NAME_EPF2, CSrLStringSubrecord::Create)
	DEFINE_SRSUBRECCREATE(SR_NAME_EPF3, CSrDwordSubrecord::Create)
END_SRSUBRECCREATE()
/*===========================================================================
 *		End of Subrecord Creation Array
 *=========================================================================*/


/*===========================================================================
 *
 * Begin CSrIdRecord Field Map
 *
 *=========================================================================*/
BEGIN_SRFIELDMAP(CSrPerkRecord, CSrIdRecord)
	ADD_SRFIELDALL("ItemName",			SR_FIELD_ITEMNAME,			0, CSrPerkRecord, FieldItemName)
	ADD_SRFIELDALL("Description",		SR_FIELD_DESCRIPTION,		0, CSrPerkRecord, FieldDescription)
	ADD_SRFIELDALL("NextPerk",			SR_FIELD_NEXTPERK,			0, CSrPerkRecord, FieldNextPerk)
	ADD_SRFIELDALL("Unknown1",			SR_FIELD_UNKNOWN1,			0, CSrPerkRecord, FieldUnknown1)
	ADD_SRFIELDALL("Unknown2",			SR_FIELD_UNKNOWN2,			0, CSrPerkRecord, FieldUnknown2)
	ADD_SRFIELDALL("Unknown3",			SR_FIELD_UNKNOWN3,			0, CSrPerkRecord, FieldUnknown3)
	ADD_SRFIELDALL("PerkSections",		SR_FIELD_PERKSECTIONS,		0, CSrPerkRecord, FieldPerkSections)
	ADD_SRFIELDALL("ConditionCount",	SR_FIELD_CONDITIONCOUNT,	0, CSrPerkRecord, FieldConditionCount)
END_SRFIELDMAP()
/*===========================================================================
 *		End of CObRecord Field Map
 *=========================================================================*/


/*===========================================================================
 *
 * Class CSrPerkRecord Constructor
 *
 *=========================================================================*/
CSrPerkRecord::CSrPerkRecord () 
{
	m_pCurrentSection = NULL;
	m_pCurrentSubSection = NULL;
	m_pItemName = NULL;
	m_pDescription = NULL;
	m_pPerkData = NULL;
	m_pNextPerk = NULL;
	m_pLastEPFT = NULL;
}
/*===========================================================================
 *		End of Class CSrPerkRecord Constructor
 *=========================================================================*/


/*===========================================================================
 *
 * Class CSrPerkRecord Method - void Destroy (void);
 *
 *=========================================================================*/
void CSrPerkRecord::Destroy (void) 
{
	m_pLastEPFT = NULL;
	m_pCurrentSection = NULL;
	m_pCurrentSubSection = NULL;
	m_pItemName = NULL;
	m_pDescription = NULL;
	m_pPerkData = NULL;
	m_pNextPerk = NULL;

	CSrIdRecord::Destroy();
}
/*===========================================================================
 *		End of Class Method CSrPerkRecord::Destroy()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CSrPerkRecord Method - void InitializeNew (void);
 *
 *=========================================================================*/
void CSrPerkRecord::InitializeNew (void) 
{
	CSrIdRecord::InitializeNew();
	m_pCurrentSection = NULL;

	AddNewSubrecord(SR_NAME_FULL);
	if (m_pItemName != NULL) m_pItemName->InitializeNew();

	AddNewSubrecord(SR_NAME_DESC);
	if (m_pDescription != NULL) m_pDescription->InitializeNew();

	srsubrecheader_t Header = { SR_NAME_DATA, 5 };
	AddNewSubrecord(Header);
	if (m_pPerkData != NULL) m_pPerkData->InitializeNew();
}
/*===========================================================================
 *		End of Class Method CSrPerkRecord::InitializeNew()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CSrPerkRecord Event - void OnAddSubrecord (pSubrecord);
 *
 *=========================================================================*/
void CSrPerkRecord::OnAddSubrecord (CSrSubrecord* pSubrecord) {

	if (pSubrecord->GetRecordType() == SR_NAME_DESC)
	{
		m_pDescription = SrCastClass(CSrLStringSubrecord, pSubrecord);
		m_pCurrentSection = NULL;
	}
	else if (pSubrecord->GetRecordType() == SR_NAME_FULL)
	{
		m_pItemName = SrCastClass(CSrLStringSubrecord, pSubrecord);
		m_pCurrentSection = NULL;
	}
	else if (pSubrecord->GetRecordType() == SR_NAME_DATA)
	{
		if (m_pPerkData == NULL) 
		{
			m_pCurrentSection = NULL;
			m_pPerkData = SrCastClass(CSrPerkDataSubrecord, pSubrecord);
		}
		else if (m_pCurrentSection)
		{
			m_Subrecords.Remove(pSubrecord);
			m_pCurrentSection->Add(pSubrecord);
		}
	}
	else if (pSubrecord->GetRecordType() == SR_NAME_NNAM)
	{
		m_pNextPerk = SrCastClass(CSrFormidSubrecord, pSubrecord);
		m_pCurrentSection = NULL;
	}
	else if (pSubrecord->GetRecordType() == SR_NAME_PRKE)
	{
		m_pLastEPFT = NULL;
	}
	else if (pSubrecord->GetRecordType() == SR_NAME_PRKF)
	{
		m_pLastEPFT = NULL;
	}
	else if (pSubrecord->GetRecordType() == SR_NAME_EPFT)
	{
		m_pLastEPFT = SrCastClass(CSrByteSubrecord, pSubrecord);
	}
	else if (pSubrecord->GetRecordType() == SR_NAME_EPFD)
	{
		CSrEpfdSubrecord* pEpfd = SrCastClass(CSrEpfdSubrecord, pSubrecord);
		if (m_pLastEPFT && pEpfd) pEpfd->SetDataType(m_pLastEPFT->GetValue());

		m_pLastEPFT = NULL;
	}
	else
	{
		CSrIdRecord::OnAddSubrecord(pSubrecord);
	}

}
/*===========================================================================
 *		End of Class Event CSrPerkRecord::OnAddSubRecord()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CSrPerkRecord Event - void OnDeleteSubrecord (pSubrecord);
 *
 *=========================================================================*/
void CSrPerkRecord::OnDeleteSubrecord (CSrSubrecord* pSubrecord) 
{

	if (m_pDescription == pSubrecord)
		m_pDescription = NULL;
	else if (m_pItemName == pSubrecord)
		m_pItemName = NULL;
	else if (m_pPerkData == pSubrecord)
		m_pPerkData = NULL;
	else if (m_pNextPerk == pSubrecord)
		m_pNextPerk = NULL;
	else
		CSrIdRecord::OnDeleteSubrecord(pSubrecord);

}
/*===========================================================================
 *		End of Class Event CSrPerkRecord::OnDeleteSubrecord()
 *=========================================================================*/


dword CSrPerkRecord::GetBaseConditionCount (void)
{
	dword Count = 0;

	for (dword i = 0; i < m_Subrecords.GetSize(); ++i)
	{
		if (m_Subrecords[i]->GetRecordType() == SR_NAME_PRKE) break;
		if (m_Subrecords[i]->GetRecordType() == SR_NAME_CTDA) ++Count;
	}

	return Count;
}


bool CSrPerkRecord::CreateFromInfo (CSrPerkSectionArray& PerkInfoArray)
{
	return true;
}


bool CSrPerkRecord::CreateInfo (CSrPerkSectionArray& PerkInfoArray)
{
	bool Result = true;

	PerkInfoArray.Destroy();

	for (dword i = 0; i < m_Subrecords.GetSize(); ++i)
	{
		if (m_Subrecords[i]->GetRecordType() == SR_NAME_PRKE)
		{
			Result &= CreateInfo(*PerkInfoArray.AddNew(), i);
		}
	}

	return Result;
}


bool CSrPerkRecord::CreateInfo (srperksectioninfo_t& PerkInfo, const dword Index)
{
	CSrPrkeSubrecord*    pSrcPrke;
	CSrSubrecord*        pSubrecord;
	CSrByteSubrecord*	 pCurrentPrkc = NULL;
	srconditioninfo_t*   pCurrentCondInfo = NULL;

	pSrcPrke = SrCastClassNull(CSrPrkeSubrecord, GetSubrecord(Index));
	if (pSrcPrke == NULL) return false;

	PerkInfo.Prke.Copy(pSrcPrke);

	for (dword i = Index + 1; i < GetNumSubrecords(); ++i)
	{
		 pSubrecord = GetSubrecord(i);

		 if (pSubrecord->GetRecordType() == SR_NAME_DATA)
		 {
			 PerkInfo.Data.Copy(pSubrecord);
		 }
		 else if (pSubrecord->GetRecordType() == SR_NAME_PRKC)
		 {
			 pCurrentPrkc = SrCastClass(CSrByteSubrecord, pSubrecord);
			 pCurrentCondInfo = NULL;
		 }
		 else if (pSubrecord->GetRecordType() == SR_NAME_CTDA && pCurrentPrkc != NULL)
		 {
			pCurrentCondInfo = PerkInfo.Conditions.AddNew();
			pCurrentCondInfo->Condition.Copy(pSubrecord);
			pCurrentCondInfo->Condition.SetPrkc(pCurrentPrkc->GetValue());
		 }
		 else if (pSubrecord->GetRecordType() == SR_NAME_CIS1 && pCurrentCondInfo != NULL)
		 {
			 pCurrentCondInfo->CopyParam1(pSubrecord);
		 }
		 else if (pSubrecord->GetRecordType() == SR_NAME_CIS2 && pCurrentCondInfo != NULL)
		 {
			 pCurrentCondInfo->CopyParam2(pSubrecord);
		 }
		 else if (pSubrecord->GetRecordType() == SR_NAME_EPFT)
		 {
			 pCurrentPrkc     = NULL;
			 pCurrentCondInfo = NULL;

			 CSrSubrecord* pTmp = pSubrecord->CreateCopy();
			 PerkInfo.pEpft = SrCastClass(CSrByteSubrecord, pTmp);
			 if (PerkInfo.pEpft == NULL) delete pTmp;
		 }
		 else if (pSubrecord->GetRecordType() == SR_NAME_EPF2)
		 {
			 pCurrentPrkc     = NULL;
			 pCurrentCondInfo = NULL;

			 CSrSubrecord* pTmp = pSubrecord->CreateCopy();
			 PerkInfo.pEpf2 = SrCastClass(CSrLStringSubrecord, pTmp);
			 if (PerkInfo.pEpf2 == NULL) delete pTmp;
		 }
		 else if (pSubrecord->GetRecordType() == SR_NAME_EPF3)
		 {
			 pCurrentPrkc     = NULL;
			 pCurrentCondInfo = NULL;

			 CSrSubrecord* pTmp = pSubrecord->CreateCopy();
			 PerkInfo.pEpf3 = SrCastClass(CSrDwordSubrecord, pTmp);
			 if (PerkInfo.pEpf3 == NULL) delete pTmp;
		 }
		 else if (pSubrecord->GetRecordType() == SR_NAME_EPFD)
		 {
			 pCurrentPrkc     = NULL;
			 pCurrentCondInfo = NULL;

			 CSrSubrecord* pTmp = pSubrecord->CreateCopy();
			 PerkInfo.pEpfd = SrCastClass(CSrEpfdSubrecord, pTmp);
			 if (PerkInfo.pEpfd == NULL) delete pTmp;
		 }
		 else if (pSubrecord->GetRecordType() == SR_NAME_PRKF)
		 {
			 pCurrentPrkc     = NULL;
			 pCurrentCondInfo = NULL;

			 PerkInfo.Prkf.Copy(pSubrecord);
			 break;
		 }
	}		

	return true;
}
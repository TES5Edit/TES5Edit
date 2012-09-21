/*===========================================================================
 *
 * File:		SrContRecord.CPP
 * Author:		Dave Humphrey (dave@uesp.net)
 * Created On:	5 December 2011
 *
 * Description
 *
 *=========================================================================*/

	/* Include Files */
#include "srContrecord.h"


srcontdata_t		CSrContRecord::s_NullContData;


/*===========================================================================
 *
 * Begin Subrecord Creation Array
 *
 *=========================================================================*/
BEGIN_SRSUBRECCREATE(CSrContRecord, CSrIdRecord)
	DEFINE_SRSUBRECCREATE(SR_NAME_MODL, CSrStringSubrecord::Create)
	DEFINE_SRSUBRECCREATE(SR_NAME_SNAM, CSrFormidSubrecord::Create)
	DEFINE_SRSUBRECCREATE(SR_NAME_FULL, CSrLStringSubrecord::Create)
	DEFINE_SRSUBRECCREATE(SR_NAME_MODT, CSrDataSubrecord::Create)
	DEFINE_SRSUBRECCREATE(SR_NAME_CNTO, CSrCntoSubrecord::Create)
	DEFINE_SRSUBRECCREATE(SR_NAME_COCT, CSrDwordSubrecord::Create)
	DEFINE_SRSUBRECCREATE(SR_NAME_DATA, CSrContDataSubrecord::Create)
	DEFINE_SRSUBRECCREATE(SR_NAME_QNAM, CSrFormidSubrecord::Create)
	DEFINE_SRSUBRECCREATE(SR_NAME_COED, CSrCoedSubrecord::Create)
	DEFINE_SRSUBRECCREATE(SR_NAME_MODS, CSrDataSubrecord::Create)
	DEFINE_SRSUBRECCREATE(SR_NAME_VMAD, CSrVmadSubrecord::Create)
END_SRSUBRECCREATE()
/*===========================================================================
 *		End of Subrecord Creation Array
 *=========================================================================*/


/*===========================================================================
 *
 * Begin CSrRecord Field Map
 *
 *=========================================================================*/
BEGIN_SRFIELDMAP(CSrContRecord, CSrIdRecord)
	ADD_SRFIELDALL("Model",			SR_FIELD_MODEL,			0, CSrContRecord, FieldModel)
	ADD_SRFIELDALL("ItemName",		SR_FIELD_ITEMNAME,		0, CSrContRecord, FieldItemName)
	ADD_SRFIELDALL("ItemCount",		SR_FIELD_ITEMCOUNT,		0, CSrContRecord, FieldItemCount)
	ADD_SRFIELDALL("Type",			SR_FIELD_TYPE,			0, CSrContRecord, FieldType)
	ADD_SRFIELDALL("OpenSound",		SR_FIELD_OPENSOUND,		0, CSrContRecord, FieldOpenSound)
	ADD_SRFIELDALL("CloseSound",	SR_FIELD_CLOSESOUND,	0, CSrContRecord, FieldCloseSound)
END_SRFIELDMAP()
/*===========================================================================
 *		End of CObRecord Field Map
 *=========================================================================*/


/*===========================================================================
 *
 * Class CSrContRecord Constructor
 *
 *=========================================================================*/
CSrContRecord::CSrContRecord () 
{
	m_pModel = NULL;
	m_pObndData = NULL;
	m_pOpenSound = NULL;
	m_pItemName = NULL;
	m_pModtData = NULL;
	m_pItemCount = NULL;
	m_pContData = NULL;
	m_pCloseSound = NULL;
	m_pCoedData = NULL;
	m_pModsData = NULL;
	m_pVmadData = NULL;
}
/*===========================================================================
 *		End of Class CSrContRecord Constructor
 *=========================================================================*/


/*===========================================================================
 *
 * Class CSrContRecord Method - void Destroy (void);
 *
 *=========================================================================*/
void CSrContRecord::Destroy (void) 
{
	m_pModel = NULL;
	m_pObndData = NULL;
	m_pOpenSound = NULL;
	m_pItemName = NULL;
	m_pModtData = NULL;
	m_pItemCount = NULL;
	m_pContData = NULL;
	m_pCloseSound = NULL;
	m_pCoedData = NULL;
	m_pModsData = NULL;
	m_pVmadData = NULL;

	CSrIdRecord::Destroy();
}
/*===========================================================================
 *		End of Class Method CSrContRecord::Destroy()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CSrContRecord Method - void InitializeNew (void);
 *
 *=========================================================================*/
void CSrContRecord::InitializeNew (void) 
{
	CSrIdRecord::InitializeNew();

	AddNewSubrecord(SR_NAME_FULL);
	if (m_pItemName != NULL) m_pItemName->InitializeNew();

	AddNewSubrecord(SR_NAME_DATA);
	if (m_pContData != NULL) m_pContData->InitializeNew();

	AddNewSubrecord(SR_NAME_MODL);
	if (m_pModel!= NULL) m_pModel->InitializeNew();

	AddNewSubrecord(SR_NAME_COCT);
	if (m_pItemCount != NULL) m_pItemCount->InitializeNew();
}
/*===========================================================================
 *		End of Class Method CSrContRecord::InitializeNew()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CSrContRecord Event - void OnAddSubrecord (pSubrecord);
 *
 *=========================================================================*/
void CSrContRecord::OnAddSubrecord (CSrSubrecord* pSubrecord) {

	if (pSubrecord->GetRecordType() == SR_NAME_MODL)
	{
		m_pModel = SrCastClass(CSrStringSubrecord, pSubrecord);
	}
	else if (pSubrecord->GetRecordType() == SR_NAME_SNAM)
	{
		m_pOpenSound = SrCastClass(CSrFormidSubrecord, pSubrecord);
	}
	else if (pSubrecord->GetRecordType() == SR_NAME_FULL)
	{
		m_pItemName = SrCastClass(CSrLStringSubrecord, pSubrecord);
	}
	else if (pSubrecord->GetRecordType() == SR_NAME_MODT)
	{
		m_pModtData = SrCastClass(CSrDataSubrecord, pSubrecord);
	}
	else if (pSubrecord->GetRecordType() == SR_NAME_COCT)
	{
		m_pItemCount = SrCastClass(CSrDwordSubrecord, pSubrecord);
	}
	else if (pSubrecord->GetRecordType() == SR_NAME_DATA)
	{
		m_pContData = SrCastClass(CSrContDataSubrecord, pSubrecord);
	}
	else if (pSubrecord->GetRecordType() == SR_NAME_QNAM)
	{
		m_pCloseSound = SrCastClass(CSrFormidSubrecord, pSubrecord);
	}
	else if (pSubrecord->GetRecordType() == SR_NAME_COED)
	{
		m_pCoedData = SrCastClass(CSrDataSubrecord, pSubrecord);
	}
	else if (pSubrecord->GetRecordType() == SR_NAME_MODS)
	{
		m_pModsData = SrCastClass(CSrDataSubrecord, pSubrecord);
	}
	else if (pSubrecord->GetRecordType() == SR_NAME_VMAD)
	{
		m_pVmadData = SrCastClass(CSrVmadSubrecord, pSubrecord);
	}
	else
	{
		CSrIdRecord::OnAddSubrecord(pSubrecord);
	}

}
/*===========================================================================
 *		End of Class Event CSrContRecord::OnAddSubRecord()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CSrContRecord Event - void OnDeleteSubrecord (pSubrecord);
 *
 *=========================================================================*/
void CSrContRecord::OnDeleteSubrecord (CSrSubrecord* pSubrecord) {

	if (m_pModel == pSubrecord)
		m_pModel = NULL;
	else if (m_pOpenSound == pSubrecord)
		m_pOpenSound = NULL;
	else if (m_pItemName == pSubrecord)
		m_pItemName = NULL;
	else if (m_pModtData == pSubrecord)
		m_pModtData = NULL;
	else if (m_pItemCount == pSubrecord)
		m_pItemCount = NULL;
	else if (m_pContData == pSubrecord)
		m_pContData = NULL;
	else if (m_pCloseSound == pSubrecord)
		m_pCloseSound = NULL;
	else if (m_pCoedData == pSubrecord)
		m_pCoedData = NULL;
	else if (m_pModsData == pSubrecord)
		m_pModsData = NULL;
	else if (m_pVmadData == pSubrecord)
		m_pVmadData = NULL;
	else
		CSrIdRecord::OnDeleteSubrecord(pSubrecord);

}
/*===========================================================================
 *		End of Class Event CSrContRecord::OnDeleteSubrecord()
 *=========================================================================*/


CSrCntoSubrecord* CSrContRecord::AddItem (const srformid_t FormID, const dword Count)
{
	if (GetItemCount() > SR_CNTO_MAXCOUNT) return NULL;

	CSrSubrecord* pSubrecord = AddNewSubrecord(SR_NAME_CNTO);
	CSrCntoSubrecord* pNewCnto = SrCastClassNull(CSrCntoSubrecord, pSubrecord);
	if (pNewCnto == NULL) return NULL;
	pNewCnto->InitializeNew();

	pNewCnto->SetCount(Count);
	pNewCnto->SetFormID(FormID);

	SetItemCount(GetItemCount() + 1);
	return pNewCnto;
}


bool CSrContRecord::DeleteItem (CSrCntoSubrecord* pItem)
{
	if (pItem == NULL) return false;
	bool Result = m_Subrecords.Delete(pItem);

	if (Result) 
	{
		if (GetItemCount() > 0) 
			SetItemCount(GetItemCount() - 1);
		else
			UpdateItemCount();
	}

	return true;
}


CSrCntoSubrecord* CSrContRecord::GetFirstItem (int& Position)
{
	Position = -1;
	return GetNextItem(Position);	
}


CSrCntoSubrecord* CSrContRecord::GetNextItem (int& Position)
{
	++Position;

	for (; Position < (int)m_Subrecords.GetSize(); ++Position)
	{
		CSrSubrecord* pSubrecord = m_Subrecords[Position];
		if (pSubrecord == NULL) continue;
		if (pSubrecord->GetRecordType() != SR_NAME_CNTO) continue;
		CSrCntoSubrecord* pCnto = SrCastClass(CSrCntoSubrecord, pSubrecord);
		if (pCnto != NULL) return pCnto;
	}

	return NULL;
}


void CSrContRecord::SetItemCount (const dword Value)
{

	if (m_pItemCount == NULL)
	{
		AddNewSubrecord(SR_NAME_COCT);
		if (m_pItemCount == NULL) return;
		m_pItemCount->InitializeNew();
	}

	if (Value > SR_CNTO_MAXCOUNT) return;
	m_pItemCount->SetValue((byte) Value);
}


void CSrContRecord::UpdateItemCount (void)
{
	dword Count = CountSubrecords(SR_NAME_CNTO);

	if (Count > SR_CNTO_MAXCOUNT)
	{
		SystemLog.Printf("WARNING: Exceeded maximum of %d CNTO subrecords!", SR_CNTO_MAXCOUNT);
		int Counter = 0;
		
		for (dword i = 0; i < m_Subrecords.GetSize(); ++i)
		{
			if (m_Subrecords[i]->GetRecordType() != SR_NAME_LVLO) continue;
			++Counter;

			if (Counter > SR_CNTO_MAXCOUNT) 
			{
				m_Subrecords.Delete(i);
				if (m_Subrecords[i] != NULL && m_Subrecords[i]->GetRecordType() == SR_NAME_COED) m_Subrecords.Delete(i);
				--i;
			}
		}

		SetItemCount(SR_CNTO_MAXCOUNT);
	}

	SetItemCount(Count);
}


/*===========================================================================
 *
 * Begin CSrContRecord Get Field Methods
 *
 *=========================================================================*/
/*===========================================================================
 *		End of CSrContRecord Get Field Methods
 *=========================================================================*/


/*===========================================================================
 *
 * Begin CSrContRecord Compare Field Methods
 *
 *=========================================================================*/
/*===========================================================================
 *		End of CSrContRecord Compare Field Methods
 *=========================================================================*/


/*===========================================================================
 *
 * Begin CSrContRecord Set Field Methods
 *
 *=========================================================================*/
/*===========================================================================
 *		End of CSrContRecord Set Field Methods
 *=========================================================================*/



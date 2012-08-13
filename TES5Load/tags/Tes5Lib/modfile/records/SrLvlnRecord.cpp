/*===========================================================================
 *
 * File:		SrLvlnRecord.CPP
 * Author:		Dave Humphrey (dave@uesp.net)
 * Created On:	17 December 2011
 *
 * Description
 *
 *=========================================================================*/

	/* Include Files */
#include "srlvlnrecord.h"


/*===========================================================================
 *
 * Begin Subrecord Creation Array
 *
 *=========================================================================*/
BEGIN_SRSUBRECCREATE(CSrLvlnRecord, CSrIdRecord)
	DEFINE_SRSUBRECCREATE(SR_NAME_MODL, CSrStringSubrecord::Create)
	DEFINE_SRSUBRECCREATE(SR_NAME_MODT, CSrDataSubrecord::Create)
	DEFINE_SRSUBRECCREATE(SR_NAME_LVLD, CSrByteSubrecord::Create)
	DEFINE_SRSUBRECCREATE(SR_NAME_LVLF, CSrLvlfSubrecord::Create)
	DEFINE_SRSUBRECCREATE(SR_NAME_LLCT, CSrByteSubrecord::Create)
	DEFINE_SRSUBRECCREATE(SR_NAME_LVLO, CSrLvloSubrecord::Create)
	DEFINE_SRSUBRECCREATE(SR_NAME_COED, CSrCoedSubrecord::Create)
END_SRSUBRECCREATE()
/*===========================================================================
 *		End of Subrecord Creation Array
 *=========================================================================*/


/*===========================================================================
 *
 * Begin CSrIdRecord Field Map
 *
 *=========================================================================*/
BEGIN_SRFIELDMAP(CSrLvlnRecord, CSrIdRecord)
	ADD_SRFIELDALL("ChanceNone",		SR_FIELD_CHANCENONE,		0, CSrLvlnRecord, FieldChanceNone)
	ADD_SRFIELDALL("CalculateEach",		SR_FIELD_CALCULATEEACH,		0, CSrLvlnRecord, FieldCalculateEach)
	ADD_SRFIELDALL("CalculateAll",		SR_FIELD_CALCULATEALL,		0, CSrLvlnRecord, FieldCalculateAll)
	ADD_SRFIELDALL("UseAll",			SR_FIELD_USEALL,			0, CSrLvlnRecord, FieldUseAll)
	ADD_SRFIELDALL("ItemCount",			SR_FIELD_ITEMCOUNT,			0, CSrLvlnRecord, FieldItemCount)
	ADD_SRFIELDALL("Model",				SR_FIELD_MODEL,				0, CSrLvlnRecord, FieldModel)
END_SRFIELDMAP()
/*===========================================================================
 *		End of CObRecord Field Map
 *=========================================================================*/


/*===========================================================================
 *
 * Class CSrLvlnRecord Constructor
 *
 *=========================================================================*/
CSrLvlnRecord::CSrLvlnRecord () 
{
	m_pModel = NULL;
	m_pObndData = NULL;
	m_pChanceNone = NULL;
	m_pFlags = NULL;
	m_pListCount = NULL;
	m_pGlobal = NULL;
}
/*===========================================================================
 *		End of Class CSrLvlnRecord Constructor
 *=========================================================================*/


/*===========================================================================
 *
 * Class CSrLvlnRecord Method - void Destroy (void);
 *
 *=========================================================================*/
void CSrLvlnRecord::Destroy (void) 
{
	m_pModel = NULL;
	m_pObndData = NULL;
	m_pChanceNone = NULL;
	m_pFlags = NULL;
	m_pListCount = NULL;
	m_pGlobal = NULL;

	CSrIdRecord::Destroy();
}
/*===========================================================================
 *		End of Class Method CSrLvlnRecord::Destroy()
 *=========================================================================*/


CSrLvloSubrecord* CSrLvlnRecord::AddItem (const srformid_t FormID, const dword Level, const dword Count)
{
	if (GetListCount() > SR_LVLO_MAXCOUNT) return NULL;

	CSrSubrecord* pSubrecord = AddNewSubrecord(SR_NAME_LVLO);
	CSrLvloSubrecord* pNewLvlo = SrCastClassNull(CSrLvloSubrecord, pSubrecord);
	if (pNewLvlo == NULL) return NULL;
	pNewLvlo->InitializeNew();

	pNewLvlo->GetListData().Count  = Count;
	pNewLvlo->GetListData().Level  = Level;
	pNewLvlo->GetListData().FormID = FormID;

	SetListCount(GetListCount() + 1);
	return pNewLvlo;
}


bool CSrLvlnRecord::DeleteItem (CSrLvloSubrecord* pItem)
{
	if (pItem == NULL) return false;
	bool Result = m_Subrecords.Delete(pItem);

	if (Result) 
	{
		if (GetListCount() > 0) 
			SetListCount(GetListCount() - 1);
		else
			UpdateListCount();
	}

	return true;
}


CSrLvloSubrecord* CSrLvlnRecord::GetFirstItem (int& Position)
{
	Position = -1;
	return GetNextItem(Position);	
}


CSrLvloSubrecord* CSrLvlnRecord::GetNextItem (int& Position)
{
	++Position;

	for (; Position < (int)m_Subrecords.GetSize(); ++Position)
	{
		CSrSubrecord* pSubrecord = m_Subrecords[Position];
		if (pSubrecord == NULL) continue;
		if (pSubrecord->GetRecordType() != SR_NAME_LVLO) continue;
		CSrLvloSubrecord* pLvlo = SrCastClass(CSrLvloSubrecord, pSubrecord);
		if (pLvlo != NULL) return pLvlo;
	}

	return NULL;
}


/*===========================================================================
 *
 * Class CSrLvlnRecord Method - void InitializeNew (void);
 *
 *=========================================================================*/
void CSrLvlnRecord::InitializeNew (void) 
{
	CSrIdRecord::InitializeNew();

	AddNewSubrecord(SR_NAME_LVLD);
	if (m_pChanceNone != NULL) m_pChanceNone->InitializeNew();

	AddNewSubrecord(SR_NAME_LVLF);
	if (m_pFlags != NULL) m_pFlags->InitializeNew();

	AddNewSubrecord(SR_NAME_LLCT);
	if (m_pListCount != NULL) m_pListCount->InitializeNew();
}
/*===========================================================================
 *		End of Class Method CSrLvlnRecord::InitializeNew()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CSrLvlnRecord Event - void OnAddSubrecord (pSubrecord);
 *
 *=========================================================================*/
void CSrLvlnRecord::OnAddSubrecord (CSrSubrecord* pSubrecord) {

	if (pSubrecord->GetRecordType() == SR_NAME_MODL)
	{
		m_pModel = SrCastClass(CSrStringSubrecord, pSubrecord);
	}
	else if (pSubrecord->GetRecordType() == SR_NAME_LVLD)
	{
		m_pChanceNone = SrCastClass(CSrByteSubrecord, pSubrecord);
	}
	else if (pSubrecord->GetRecordType() == SR_NAME_LVLF)
	{
		m_pFlags = SrCastClass(CSrLvlfSubrecord, pSubrecord);
	}
	else if (pSubrecord->GetRecordType() == SR_NAME_LLCT)
	{
		m_pListCount = SrCastClass(CSrByteSubrecord, pSubrecord);
	}
	else if (pSubrecord->GetRecordType() == SR_NAME_LVLG)
	{
		m_pGlobal = SrCastClass(CSrFormidSubrecord, pSubrecord);
	}
	else
	{
		CSrIdRecord::OnAddSubrecord(pSubrecord);
	}

}
/*===========================================================================
 *		End of Class Event CSrLvlnRecord::OnAddSubRecord()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CSrLvlnRecord Event - void OnDeleteSubrecord (pSubrecord);
 *
 *=========================================================================*/
void CSrLvlnRecord::OnDeleteSubrecord (CSrSubrecord* pSubrecord) {

	if (m_pModel == pSubrecord)
		m_pModel = NULL;
	else if (m_pChanceNone == pSubrecord)
		m_pChanceNone = NULL;
	else if (m_pFlags == pSubrecord)
		m_pFlags = NULL;
	else if (m_pListCount == pSubrecord)
		m_pListCount = NULL;
	else if (m_pGlobal == pSubrecord)
		m_pGlobal = NULL;
	else
		CSrIdRecord::OnDeleteSubrecord(pSubrecord);

}
/*===========================================================================
 *		End of Class Event CSrLvlnRecord::OnDeleteSubrecord()
 *=========================================================================*/


void CSrLvlnRecord::SetListCount (const dword Value)
{

	if (m_pListCount == NULL)
	{
		AddNewSubrecord(SR_NAME_LLCT);
		if (m_pListCount == NULL) return;
		m_pListCount->InitializeNew();
	}

	if (Value > SR_LVLO_MAXCOUNT) return;
	m_pListCount->SetValue((byte) Value);
}


void CSrLvlnRecord::SetChanceNone (const byte Value)
{
	if (m_pChanceNone == NULL)
	{
		AddNewSubrecord(SR_NAME_LVLD);
		if (m_pChanceNone == NULL) return;
		m_pChanceNone->InitializeNew();
	}

	m_pChanceNone->SetValue(Value);
}


void CSrLvlnRecord::UpdateListCount (void)
{
	dword Count = CountSubrecords(SR_NAME_LVLO);

	if (Count > SR_LVLO_MAXCOUNT)
	{
		SystemLog.Printf("WARNING: Exceeded maximum of %d LVLO subrecords!", SR_LVLO_MAXCOUNT);
		int Counter = 0;
		
		for (dword i = 0; i < m_Subrecords.GetSize(); ++i)
		{
			if (m_Subrecords[i]->GetRecordType() != SR_NAME_LVLO) continue;
			++Counter;

			if (Counter > SR_LVLO_MAXCOUNT) 
			{
				m_Subrecords.Delete(i);
				if (m_Subrecords[i] != NULL && m_Subrecords[i]->GetRecordType() == SR_NAME_COED) m_Subrecords.Delete(i);
				--i;
			}
		}

		SetListCount(SR_LVLO_MAXCOUNT);
	}

	SetListCount(Count);
}


/*===========================================================================
 *
 * Begin CSrLvlnRecord Get Field Methods
 *
 *=========================================================================*/
/*===========================================================================
 *		End of CSrLvlnRecord Get Field Methods
 *=========================================================================*/


/*===========================================================================
 *
 * Begin CSrLvlnRecord Compare Field Methods
 *
 *=========================================================================*/
/*===========================================================================
 *		End of CSrLvlnRecord Compare Field Methods
 *=========================================================================*/


/*===========================================================================
 *
 * Begin CSrLvlnRecord Set Field Methods
 *
 *=========================================================================*/
/*===========================================================================
 *		End of CSrLvlnRecord Set Field Methods
 *=========================================================================*/


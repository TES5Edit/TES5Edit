/*===========================================================================
 *
 * File:		SrLvliRecord.CPP
 * Author:		Dave Humphrey (dave@uesp.net)
 * Created On:	5 December 2011
 *
 * Description
 *
 *=========================================================================*/

	/* Include Files */
#include "srLvlirecord.h"


/*===========================================================================
 *
 * Begin Subrecord Creation Array
 *
 *=========================================================================*/
BEGIN_SRSUBRECCREATE(CSrLvliRecord, CSrIdRecord)
	DEFINE_SRSUBRECCREATE(SR_NAME_LVLD, CSrByteSubrecord::Create)
	DEFINE_SRSUBRECCREATE(SR_NAME_LVLF, CSrLvlfSubrecord::Create)
	DEFINE_SRSUBRECCREATE(SR_NAME_LLCT, CSrByteSubrecord::Create)
	DEFINE_SRSUBRECCREATE(SR_NAME_LVLO, CSrLvloSubrecord::Create)
	DEFINE_SRSUBRECCREATE(SR_NAME_LVLG, CSrFormidSubrecord::Create)
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
BEGIN_SRFIELDMAP(CSrLvliRecord, CSrIdRecord)
	ADD_SRFIELDALL("ChanceNone",		SR_FIELD_CHANCENONE,		0, CSrLvliRecord, FieldChanceNone)
	ADD_SRFIELDALL("CalculateEach",		SR_FIELD_CALCULATEEACH,		0, CSrLvliRecord, FieldCalculateEach)
	ADD_SRFIELDALL("CalculateAll",		SR_FIELD_CALCULATEALL,		0, CSrLvliRecord, FieldCalculateAll)
	ADD_SRFIELDALL("UseAll",			SR_FIELD_USEALL,			0, CSrLvliRecord, FieldUseAll)
	ADD_SRFIELDALL("ItemCount",			SR_FIELD_ITEMCOUNT,			0, CSrLvliRecord, FieldItemCount)
	ADD_SRFIELDALL("Global",			SR_FIELD_GLOBAL,			0, CSrLvliRecord, FieldGlobal)
END_SRFIELDMAP()
/*===========================================================================
 *		End of CObRecord Field Map
 *=========================================================================*/


/*===========================================================================
 *
 * Class CSrLvliRecord Constructor
 *
 *=========================================================================*/
CSrLvliRecord::CSrLvliRecord () 
{
	m_pObndData = NULL;
	m_pChanceNone = NULL;
	m_pFlags = NULL;
	m_pListCount = NULL;
	m_pGlobal = NULL;
}
/*===========================================================================
 *		End of Class CSrLvliRecord Constructor
 *=========================================================================*/


/*===========================================================================
 *
 * Class CSrLvliRecord Method - void Destroy (void);
 *
 *=========================================================================*/
void CSrLvliRecord::Destroy (void) 
{
	m_pObndData = NULL;
	m_pChanceNone = NULL;
	m_pFlags = NULL;
	m_pListCount = NULL;
	m_pGlobal = NULL;

	CSrIdRecord::Destroy();
}
/*===========================================================================
 *		End of Class Method CSrLvliRecord::Destroy()
 *=========================================================================*/


CSrLvloSubrecord* CSrLvliRecord::AddItem (const srformid_t FormID, const dword Level, const dword Count)
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


bool CSrLvliRecord::DeleteItem (CSrLvloSubrecord* pItem)
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


CSrLvloSubrecord* CSrLvliRecord::GetFirstItem (int& Position)
{
	Position = -1;
	return GetNextItem(Position);	
}


CSrLvloSubrecord* CSrLvliRecord::GetNextItem (int& Position)
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
 * Class CSrLvliRecord Method - void InitializeNew (void);
 *
 *=========================================================================*/
void CSrLvliRecord::InitializeNew (void) 
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
 *		End of Class Method CSrLvliRecord::InitializeNew()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CSrLvliRecord Event - void OnAddSubrecord (pSubrecord);
 *
 *=========================================================================*/
void CSrLvliRecord::OnAddSubrecord (CSrSubrecord* pSubrecord) {

	if (pSubrecord->GetRecordType() == SR_NAME_LVLD)
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
 *		End of Class Event CSrLvliRecord::OnAddSubRecord()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CSrLvliRecord Event - void OnDeleteSubrecord (pSubrecord);
 *
 *=========================================================================*/
void CSrLvliRecord::OnDeleteSubrecord (CSrSubrecord* pSubrecord) {

	if (m_pChanceNone == pSubrecord)
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
 *		End of Class Event CSrLvliRecord::OnDeleteSubrecord()
 *=========================================================================*/


void CSrLvliRecord::SetListCount (const dword Value)
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


void CSrLvliRecord::SetChanceNone (const byte Value)
{
	if (m_pChanceNone == NULL)
	{
		AddNewSubrecord(SR_NAME_LVLD);
		if (m_pChanceNone == NULL) return;
		m_pChanceNone->InitializeNew();
	}

	m_pChanceNone->SetValue(Value);
}


void CSrLvliRecord::UpdateListCount (void)
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
 * Begin CSrLvliRecord Get Field Methods
 *
 *=========================================================================*/
/*===========================================================================
 *		End of CSrLvliRecord Get Field Methods
 *=========================================================================*/


/*===========================================================================
 *
 * Begin CSrLvliRecord Compare Field Methods
 *
 *=========================================================================*/
/*===========================================================================
 *		End of CSrLvliRecord Compare Field Methods
 *=========================================================================*/


/*===========================================================================
 *
 * Begin CSrLvliRecord Set Field Methods
 *
 *=========================================================================*/
/*===========================================================================
 *		End of CSrLvliRecord Set Field Methods
 *=========================================================================*/

/*===========================================================================
 *
 * File:		Srarraysubrecord.CPP
 * Author:		Dave Humphrey (dave@uesp.net)
 * Created On:	2 January 2012
 *
 * Description
 *
 *=========================================================================*/

	/* Include Files */
#include "srarraysubrecord.h"
#include "../records/srrecord.h"


CSrArraySubrecord::CSrArraySubrecord()
{
	m_RecordType = SR_NAME_NULL;
	m_pRawData = NULL;
	m_RawDataSize = 0;
}


void CSrArraySubrecord::Destroy (void) 
{ 
	m_Subrecords.Destroy();

	delete m_pRawData;
	m_pRawData = NULL;
	m_RawDataSize = 0;

	CSrSubrecord::Destroy(); 
}


bool CSrArraySubrecord::Copy (CSrSubrecord* pSource) 
{
	Destroy();

	CSrArraySubrecord* pSrcArray = SrCastClassNull(CSrArraySubrecord, pSource);
	if (pSrcArray == NULL) return false;

	m_RecordType = pSrcArray->m_RecordType;
	m_RecordSize = pSrcArray->m_RecordSize;;

	for (dword i = 0; i < pSrcArray->m_Subrecords.GetSize(); ++i)
	{
		CSrSubrecord* pSrc = pSrcArray->m_Subrecords[i];
		if (pSrc == NULL) continue;

		CSrSubrecord* pNew = pSrc->CreateCopy();
		m_Subrecords.Add(pNew);		
	}

	return true;
}


dword CSrArraySubrecord::CountUses (const srformid_t FormID) 
{
	dword Count = 0;

	for (dword i = 0; i < m_Subrecords.GetSize(); ++i)
	{
		Count += m_Subrecords[i]->CountUses(FormID);
	}

	return Count; 

}


/*===========================================================================
 *
 * Class CSrArraySubrecord Method - dword ChangeFormID (NewID, OldID);
 *
 *=========================================================================*/
dword CSrArraySubrecord::ChangeFormID (const srformid_t NewID, const srformid_t OldID) 
{
	dword Count = 0;

	for (dword i = 0; i < m_Subrecords.GetSize(); ++i)
	{
		Count += m_Subrecords[i]->ChangeFormID(NewID, OldID);
	}

	return Count; 
}
/*===========================================================================
 *		End of Class Method CSrArraySubrecord::ChangeFormID()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CSrArraySubrecord Method - bool FixupFormID (FixupArray);
 *
 *=========================================================================*/
bool CSrArraySubrecord::FixupFormID (CSrFormidFixupArray& FixupArray) 
{
	bool Result = true;

	for (dword i = 0; i < m_Subrecords.GetSize(); ++i)
	{
		Result &= m_Subrecords[i]->FixupFormID(FixupArray);
	}
  
	return Result;
}
/*===========================================================================
 *		End of Class Method CSrArraySubrecord::FixupFormID()
 *=========================================================================*/


byte* CSrArraySubrecord::GetData (void)
{
	delete m_pRawData;
	m_pRawData = NULL;
	m_RawDataSize = GetRecordSize();
	
	return NULL;
}


dword CSrArraySubrecord::GetRecordSize (void) const
{
	return 0;
}


void CSrArraySubrecord::InitializeNew (void)
{
	
	Destroy();
}


bool CSrArraySubrecord::ReadData (CSrFile& File) 
{ 
	return AddSrGeneralError("%08X: Cannot read an array of subrecords!", File.Tell());
}


bool CSrArraySubrecord::Write (CSrFile& File) 
{ 

	for (dword i = 0; i < m_Subrecords.GetSize(); ++i)
	{
		if (!m_Subrecords[i]->Write(File)) return false;
	}

	return true;
}


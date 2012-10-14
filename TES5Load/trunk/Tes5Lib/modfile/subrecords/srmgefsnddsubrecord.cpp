/*===========================================================================
 *
 * File:		SrMgefSnddSubrecord.CPP
 * Author:		Dave Humphrey (dave@uesp.net)
 * Created On:	20 December 2011
 *
 *=========================================================================*/

	/* Include Files */
#include "srmgefsnddsubrecord.h"


srmgefsndddata_t CSrMgefSnddSubrecord::s_NullSnddData;


/*===========================================================================
 *
 * Class CSrMgefSnddSubrecord Constructor
 *
 *=========================================================================*/
CSrMgefSnddSubrecord::CSrMgefSnddSubrecord () 
{
}
/*===========================================================================
 *		End of Class CSrMgefSnddSubrecord Constructor
 *=========================================================================*/


/*===========================================================================
 *
 * Class CSrMgefSnddSubrecord Method - void Destroy (void);
 *
 *=========================================================================*/
void CSrMgefSnddSubrecord::Destroy (void) 
{
  m_Values.Destroy();

  CSrSubrecord::Destroy();
}
/*===========================================================================
 *		End of Class Method CSrMgefSnddSubrecord::Destroy()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CSrMgefSnddSubrecord Method - dword ChangeFormID (NewID, OldID);
 *
 *=========================================================================*/
dword CSrMgefSnddSubrecord::ChangeFormID (const srformid_t NewID, const srformid_t OldID) 
{
  dword Index;
  dword Count = 0;

  for (Index = 0; Index < m_Values.GetSize(); ++Index) {

    if (m_Values[Index].SoundID == OldID) {
      m_Values[Index].SoundID = NewID;
      ++Count;
    }
  }

  return (Count);
}
/*===========================================================================
 *		End of Class Method CSrMgefSnddSubrecord::ChangeFormID()
 *=========================================================================*/


dword CSrMgefSnddSubrecord::CountUses (const srformid_t FormID)
{
	int Count = 0;

	for (dword i = 0; i < m_Values.GetSize(); ++i) 
	{
		if (m_Values[i].SoundID == FormID) ++Count;
	}

	return Count;
}



/*===========================================================================
 *
 * Class CSrMgefSnddSubrecord Method - bool Copy (pSubrecord);
 *
 *=========================================================================*/
bool CSrMgefSnddSubrecord::Copy (CSrSubrecord* pSubrecord) 
{
	CSrMgefSnddSubrecord* pSubrecord1 = SrCastClassNull(CSrMgefSnddSubrecord, pSubrecord);
	dword			        Index;
  
	m_Values.Destroy();
	if (pSubrecord1 == NULL) return (true);

	for (Index = 0; Index < pSubrecord1->GetSnddArray().GetSize(); ++Index) 
	{
		m_Values.Add(pSubrecord1->GetSnddArray()[Index]);
	}

	m_RecordSize = pSubrecord->GetRecordSize();
  
	return (true);
}
/*===========================================================================
 *		End of Class Method CSrMgefSnddSubrecord::Copy()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CSrMgefSnddSubrecord Method - bool FixupFormID (FixupArray);
 *
 *=========================================================================*/
bool CSrMgefSnddSubrecord::FixupFormID (CSrFormidFixupArray& FixupArray) 
{
	dword Index;
	bool  Result = true;

	for (Index = 0; Index < m_Values.GetSize(); ++Index) 
	{
		Result &= SrFixupFormid(m_Values[Index].SoundID, m_Values[Index].SoundID, FixupArray);
	}

	return (Result);
}
/*===========================================================================
 *		End of Class Method CSrMgefSnddSubrecord::FixupFormID()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CSrMgefSnddSubrecord Method - bool ReadData (File);
 *
 *=========================================================================*/
bool CSrMgefSnddSubrecord::ReadData (CSrFile& File) 
{
  srmgefsndddata_t Data;
  dword      NumRecords = m_RecordSize / SR_MGEFSNDD_RECORDSIZE;
  dword      ExtraBytes = m_RecordSize % SR_MGEFSNDD_RECORDSIZE;
  dword      Index;
  bool       Result;

	/* Preallocate the string to the desired size */
  m_Values.Destroy();
  m_Values.SetSize(NumRecords);
  if (m_RecordSize == 0) return (true);

	/* Read in the string data */ 
  for (Index = 0; Index < NumRecords; ++Index) 
  {
    Result = File.Read((void *)&Data, SR_MGEFSNDD_RECORDSIZE);
    if (!Result) return (false);

    m_Values[Index] = Data;
  }

	/* Check for extra bytes */
  if (ExtraBytes != 0) 
  {
    SystemLog.Printf("Extra %u bytes found in Formid array subrecord!", ExtraBytes);
    Result = File.Read((void *)&Data, ExtraBytes);
    if (!Result) return (false);
  } 

  return (true);
}
/*===========================================================================
 *		End of Class Method CSrMgefSnddSubrecord::ReadData()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CSrMgefSnddSubrecord Method - bool WriteData (File);
 *
 *=========================================================================*/
bool CSrMgefSnddSubrecord::WriteData (CSrFile& File) { 
  dword Index;
  bool  Result;

  	/* Read in the string data */ 
  for (Index = 0; Index < m_Values.GetSize(); ++Index) 
  {
    Result = File.Write(&m_Values[Index], SR_MGEFSNDD_RECORDSIZE);
    if (!Result) return (false);
  }

  return (true);
 }
/*===========================================================================
 *		End of Class Method CSrMgefSnddSubrecord::WriteData()
 *=========================================================================*/


void CSrMgefSnddSubrecord::SetValue (const dword Index, const dword Type, const srformid_t FormID)
{
	if (m_Values.GetSize() < Index) return;
	m_Values[Index].Type    = Type;
	m_Values[Index].SoundID = FormID;
}
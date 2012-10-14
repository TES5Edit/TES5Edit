/*===========================================================================
 *
 * File:		SrFormidArraysubrecord.CPP
 * Author:		Dave Humphrey (dave@uesp.net)
 * Created On:	27 November 2011
 *
 * Description
 *
 *=========================================================================*/

	/* Include Files */
#include "srformidarraysubrecord.h"


/*===========================================================================
 *
 * Class CSrFormidArraySubrecord Constructor
 *
 *=========================================================================*/
CSrFormidArraySubrecord::CSrFormidArraySubrecord () 
{
}
/*===========================================================================
 *		End of Class CSrFormidArraySubrecord Constructor
 *=========================================================================*/


/*===========================================================================
 *
 * Class CSrFormidArraySubrecord Method - void Destroy (void);
 *
 *=========================================================================*/
void CSrFormidArraySubrecord::Destroy (void) 
{
  m_Values.Destroy();

  CSrSubrecord::Destroy();
}
/*===========================================================================
 *		End of Class Method CSrFormidArraySubrecord::Destroy()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CSrFormidArraySubrecord Method - dword ChangeFormID (NewID, OldID);
 *
 *=========================================================================*/
dword CSrFormidArraySubrecord::ChangeFormID (const srformid_t NewID, const srformid_t OldID) {
  dword Index;
  dword Count = 0;

  for (Index = 0; Index < m_Values.GetSize(); ++Index) {

    if (m_Values[Index] == OldID) {
      m_Values[Index] = NewID;
      ++Count;
    }
  }

  return (Count);
}
/*===========================================================================
 *		End of Class Method CSrFormidArraySubrecord::ChangeFormID()
 *=========================================================================*/


dword CSrFormidArraySubrecord::CountUses (const srformid_t FormID)
{
	int Count = 0;

	for (dword i = 0; i < m_Values.GetSize(); ++i) 
	{
		if (m_Values[i] == FormID) ++Count;
	}

	return Count;
}



/*===========================================================================
 *
 * Class CSrFormidArraySubrecord Method - bool Copy (pSubrecord);
 *
 *=========================================================================*/
bool CSrFormidArraySubrecord::Copy (CSrSubrecord* pSubrecord) {
  CSrFormidArraySubrecord* pSubrecord1 = SrCastClassNull(CSrFormidArraySubrecord, pSubrecord);
  dword			   Index;
  
  m_Values.Destroy();
  if (pSubrecord1 == NULL) return (true);

  for (Index = 0; Index < pSubrecord1->GetFormIDArray().GetSize(); ++Index) {
    m_Values.Add(pSubrecord1->GetFormIDArray()[Index]);
  }

  m_RecordSize = pSubrecord->GetRecordSize();
  
  return (true);
}
/*===========================================================================
 *		End of Class Method CSrFormidArraySubrecord::Copy()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CSrFormidArraySubrecord Method - bool FixupFormID (FixupArray);
 *
 *=========================================================================*/
bool CSrFormidArraySubrecord::FixupFormID (CSrFormidFixupArray& FixupArray) {
  dword Index;
  bool  Result = true;

  for (Index = 0; Index < m_Values.GetSize(); ++Index) 
  {
    Result &= SrFixupFormid(m_Values[Index], m_Values[Index], FixupArray);
  }

  return (Result);
}
/*===========================================================================
 *		End of Class Method CSrFormidArraySubrecord::FixupFormID()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CSrFormidArraySubrecord Method - bool ReadData (File);
 *
 *=========================================================================*/
bool CSrFormidArraySubrecord::ReadData (CSrFile& File) 
{
  srformid_t FormID;
  dword      NumRecords = m_RecordSize / sizeof(srformid_t);
  dword      ExtraBytes = m_RecordSize % sizeof(srformid_t);
  dword      Index;
  bool       Result;

	/* Preallocate the string to the desired size */
  m_Values.Destroy();
  m_Values.SetSize(NumRecords);
  if (m_RecordSize == 0) return (true);

	/* Read in the string data */ 
  for (Index = 0; Index < NumRecords; ++Index) 
  {
    Result = File.Read((void *)&FormID, sizeof(srformid_t));
    if (!Result) return (false);

    m_Values[Index] = FormID;
  }

	/* Check for extra bytes */
  if (ExtraBytes != 0) 
  {
    SystemLog.Printf("Extra %u bytes found in Formid array subrecord!", ExtraBytes);
    Result = File.Read((void *)&FormID, ExtraBytes);
    if (!Result) return (false);
  } 

  return (true);
}
/*===========================================================================
 *		End of Class Method CSrFormidArraySubrecord::ReadData()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CSrFormidArraySubrecord Method - bool WriteData (File);
 *
 *=========================================================================*/
bool CSrFormidArraySubrecord::WriteData (CSrFile& File) { 
  dword Index;
  bool  Result;

  	/* Read in the string data */ 
  for (Index = 0; Index < m_Values.GetSize(); ++Index) 
  {
    Result = File.Write(&m_Values[Index], sizeof(srformid_t));
    if (!Result) return (false);
  }

  return (true);
 }
/*===========================================================================
 *		End of Class Method CSrFormidArraySubrecord::WriteData()
 *=========================================================================*/

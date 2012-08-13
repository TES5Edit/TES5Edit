/*===========================================================================
 *
 * File:		SrGmstDatasubrecord.CPP
 * Author:		Dave Humphrey (dave@uesp.net)
 * Created On:	7 December 2011
 *
 * Description
 *
 *=========================================================================*/

	/* Include Files */
#include "srgmstdatasubrecord.h"
#include "../srrecordhandler.h"
#include "strings/srstringfile.h"


/*===========================================================================
 *
 * Class CSrGmstDataSubrecord Constructor
 *
 *=========================================================================*/
CSrGmstDataSubrecord::CSrGmstDataSubrecord () :
	m_Flags(SR_GMSTDATA_TYPEINT), m_RawData(0)
{
}
/*===========================================================================
 *		End of Class CSrGmstDataSubrecord Constructor
 *=========================================================================*/


/*===========================================================================
 *
 * Class CSrGmstDataSubrecord Method - void Destroy (void);
 *
 *=========================================================================*/
void CSrGmstDataSubrecord::Destroy (void) 
{
  m_Flags = SR_GMSTDATA_TYPEINT;
  m_RawData = 0;
  m_String.Empty();

  CSrSubrecord::Destroy();
}
/*===========================================================================
 *		End of Class Method CSrGmstDataSubrecord::Destroy()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CSrGmstDataSubrecord Method - void LoadLocalStrings (pHandler);
 *
 *=========================================================================*/
void CSrGmstDataSubrecord::LoadLocalStrings (CSrRecordHandler* pHandler)
{
	if (!IsGlobalString()) return;

	if (m_RawData == 0)
	{
		SetIsStringLoaded(true);
		m_String.Empty();
		return;
	}

	CSString* pString = pHandler->FindLocalString(m_RawData);

	if (pString != NULL) 
	{
		//SystemLog.Printf("Found string '%s' for ID %d", *pString, m_RawData);
		m_String = *pString;
		SetIsStringLoaded(true);
	}
	else
	{
		SystemLog.Printf("Failed to find localized string id %d!", m_RawData);
	}

}
/*===========================================================================
 *		End of Class Method CSrGmstDataSubrecord::LoadLocalStrings()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CSrGmstDataSubrecord Method - bool ReadData (File);
 *
 *=========================================================================*/
bool CSrGmstDataSubrecord::ReadData (CSrFile& File) 
{ 
  bool Result;

  if (!IsGlobalString())
  {
	  if (m_RecordSize != 4) return AddSrGeneralError("Invalid GMST subrecord size of %d found (expecting a 4 byte DWORD)!", m_RecordSize);
	  Result = File.ReadDWord(m_RawData);	  
  }
  else if (IsLoadLocal())
  {
	  if (m_RecordSize != 4) return AddSrGeneralError("Invalid GMST subrecord size of %d found (expecting a 4 byte LSTRING)!", m_RecordSize);
	  Result = File.ReadDWord(m_RawData);
	  SetIsStringLoaded(false);
  }
  else
  {
	m_String.Empty();
	m_String.SetSize(m_RecordSize);
	if (m_RecordSize == 0) return (true);
	
			/* Read in the string data */ 
	Result = File.Read((void *)(const SSCHAR *)m_String, m_RecordSize);

			/* Ensure the string/record is the correct size by checking that is nul terminated */
	if (m_String.GetAt(m_RecordSize - 1) == NULL_CHAR) m_String.Truncate(m_RecordSize - 1);
	SetIsStringLoaded(true);
  }

  return (Result);
}
/*===========================================================================
 *		End of Class Method CSrGmstDataSubrecord::ReadData()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CSrGmstDataSubrecord Method - bool WriteData (File);
 *
 *=========================================================================*/
bool CSrGmstDataSubrecord::WriteData (CSrFile& File) 
{ 

	if (!IsGlobalString())
	{
		return File.WriteDWord(m_RawData);
	}
	else if (IsLoadLocal())
	{
		return File.WriteDWord(m_RawData);
	}
	else
	{
		return File.Write((const SSCHAR *)m_String, m_String.GetLength() + 1); 
	}

}
/*===========================================================================
 *		End of Class Method CSrGmstDataSubrecord::WriteData()
 *=========================================================================*/


void CSrGmstDataSubrecord::UpdateLocalStrings(CSrStringFile& StringFile, srlstringid_t& NextStringID)
{
	if (!IsGlobalString()) return;

	if (m_String.IsEmpty())
	{
		m_RawData = 0;
		return;
	}

	m_RawData = NextStringID++;
	StringFile.Add(m_RawData, m_String);
}
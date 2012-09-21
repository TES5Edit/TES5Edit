/*===========================================================================
 *
 * File:		SrLstringsubrecord.CPP
 * Author:		Dave Humphrey (dave@uesp.net)
 * Created On:	27 November 2011
 *
 * Description
 *
 *=========================================================================*/

	/* Include Files */
#include "srlstringsubrecord.h"
#include <unordered_map>
#include "../srrecordhandler.h"
#include "../../strings/srstringfile.h"


/*===========================================================================
 *
 * Class CSrLStringSubrecord Constructor
 *
 *=========================================================================*/
CSrLStringSubrecord::CSrLStringSubrecord () :
	m_Flags(0), m_StringID(SR_NULL_STRINGID)
{

}
/*===========================================================================
 *		End of Class CSrLStringSubrecord Constructor
 *=========================================================================*/


/*===========================================================================
 *
 * Class CSrLStringSubrecord Method - void Destroy (void);
 *
 *=========================================================================*/
void CSrLStringSubrecord::Destroy (void) 
{
  m_Flags = 0;
  m_StringID = SR_NULL_STRINGID;
  m_String.Empty();

  CSrSubrecord::Destroy();
}
/*===========================================================================
 *		End of Class Method CSrLStringSubrecord::Destroy()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CSrLStringSubrecord Method - void LoadLocalStrings (pHandler);
 *
 *=========================================================================*/
void CSrLStringSubrecord::LoadLocalStrings (CSrRecordHandler* pHandler)
{
	if (m_StringID == 0)
	{
		SetIsStringLoaded(true);
		m_String.Empty();
		return;
	}

	CSString* pString = pHandler->FindLocalString(m_StringID);

	if (pString != NULL) 
	{
		//SystemLog.Printf("Found string '%s' for ID %d", *pString, m_StringID);
		m_String = *pString;
		SetIsStringLoaded(true);
	}
	else
	{
		SystemLog.Printf("Failed to find localized string id %d!", m_StringID);
	}
}
/*===========================================================================
 *		End of Class Method CSrLStringSubrecord::LoadLocalStrings()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CSrLStringSubrecord Method - bool ReadData (File);
 *
 *=========================================================================*/
bool CSrLStringSubrecord::ReadData (CSrFile& File) 
{ 
  bool Result;

  if (IsLoadLocal())
  {
	  Result = File.ReadDWord(m_StringID);
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
 *		End of Class Method CSrLStringSubrecord::ReadData()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CSrLStringSubrecord Method - bool WriteData (File);
 *
 *=========================================================================*/
bool CSrLStringSubrecord::WriteData (CSrFile& File) 
{ 
	if (IsLoadLocal())
	{
		return File.WriteDWord(m_StringID);
	}
	else
	{
		return File.Write((const SSCHAR *)m_String, m_String.GetLength() + 1); 
	}
}
/*===========================================================================
 *		End of Class Method CSrLStringSubrecord::WriteData()
 *=========================================================================*/


void CSrLStringSubrecord::UpdateLocalStrings(CSrStringFile& StringFile, srlstringid_t& NextStringID)
{

	if (m_String.IsEmpty())
	{
		m_StringID = 0;
		return;
	}

	m_StringID = NextStringID++;
	StringFile.Add(m_StringID, m_String);
}
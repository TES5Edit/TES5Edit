/*===========================================================================
 *
 * File:		Srstringsubrecord.CPP
 * Author:		Dave Humphrey (dave@uesp.net)
 * Created On:	26 November 2011
 *
 * Description
 *
 *=========================================================================*/

	/* Include Files */
#include "srstringsubrecord.h"


/*===========================================================================
 *
 * Class CSrStringSubrecord Constructor
 *
 *=========================================================================*/
CSrStringSubrecord::CSrStringSubrecord () 
{
}
/*===========================================================================
 *		End of Class CSrStringSubrecord Constructor
 *=========================================================================*/


/*===========================================================================
 *
 * Class CSrStringSubrecord Method - void Destroy (void);
 *
 *=========================================================================*/
void CSrStringSubrecord::Destroy (void) 
{
  m_String.Empty();
  CSrSubrecord::Destroy();
}
/*===========================================================================
 *		End of Class Method CSrStringSubrecord::Destroy()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CSrStringSubrecord Method - bool ReadData (File);
 *
 *=========================================================================*/
bool CSrStringSubrecord::ReadData (CSrFile& File) 
{ 
  bool Result;

	/* Preallocate the string to the desired size */
  m_String.Empty();
  m_String.SetSize(m_RecordSize + 2);
  m_String.SetSize(m_RecordSize);
  if (m_RecordSize == 0) return (true);

	/* Read in the string data */ 
  Result = File.Read((void *)(const SSCHAR *)m_String, m_RecordSize);

	/* Ensure the string/record is the correct size by checking that is nul terminated */
  if (m_String.GetAt(m_RecordSize - 1) == NULL_CHAR) m_String.Truncate(m_RecordSize - 1);

  return (Result);
 }
/*===========================================================================
 *		End of Class Method CSrStringSubrecord::ReadData()
 *=========================================================================*/

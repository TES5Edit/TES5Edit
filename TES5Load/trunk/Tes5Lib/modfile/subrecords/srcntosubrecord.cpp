/*===========================================================================
 *
 * File:		SrCntosubrecord.CPP
 * Author:		Dave Humphrey (dave@uesp.net)
 * Created On:	2 December 2011
 *
 * Description
 *
 *=========================================================================*/

	/* Include Files */
#include "srcntosubrecord.h"


/*===========================================================================
 *
 * Class CSrCntoSubrecord Method - dword ChangeFormID (NewID, OldID);
 *
 *=========================================================================*/
dword CSrCntoSubrecord::ChangeFormID (const srformid_t NewID, const srformid_t OldID) 
{
  dword Count = 0;

  if (m_FormID == OldID) 
  {
    m_FormID = NewID;
   ++Count;
  }

  return (Count); 
}
/*===========================================================================
 *		End of Class Method CSrCntoSubrecord::ChangeFormID()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CSrCntoSubrecord Method - bool FixupFormID (FixupArray);
 *
 *=========================================================================*/
bool CSrCntoSubrecord::FixupFormID (CSrFormidFixupArray& FixupArray) 
{
  return SrFixupFormid(m_FormID, m_FormID, FixupArray);
}
/*===========================================================================
 *		End of Class Method CSrCntoSubrecord::FixupFormID()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CSrCntoSubrecord Method - int CompareFields (Result, FieldID, pSubrecord);
 *
 *=========================================================================*/
bool CSrCntoSubrecord::CompareFields (int& Result, const int FieldID, CSrSubrecord* pSubrecord) 
{
  CSrCntoSubrecord* pCond1 = SrCastClass(CSrCntoSubrecord, pSubrecord);

  if (pCond1 != NULL) 
  {

    switch (FieldID) 
	{
	case SR_FIELD_COMPFORMID:
	case SR_FIELD_COMPONENT:
		Result = m_FormID - pCond1->m_FormID;
		return true;
    case SR_FIELD_COMPCOUNT:
		Result = m_Count - pCond1->m_Count;
		return (true);
    }

  }

  return CSrSubrecord::CompareFields(Result, FieldID, pSubrecord);
}
/*===========================================================================
 *		End of Class Method CSrCntoSubrecord::CompareFields()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CSrCntoSubrecord Method - bool GetField (Buffer, FieldID);
 *
 *=========================================================================*/
bool CSrCntoSubrecord::GetField (CSString& Buffer, const int FieldID) 
{
  
  switch (FieldID) 
  {
	case SR_FIELD_COMPFORMID:
		if (m_FormID > 0) Buffer.Format("0x%08X", m_FormID);
		return (true);
    //case SR_FIELD_COMPONENT:
		//return true;
    case SR_FIELD_COMPCOUNT:
		Buffer.Format("%d", m_Count);
		return (true);
   }

  return CSrSubrecord::GetField(Buffer, FieldID);
}
/*===========================================================================
 *		End of Class Method CSrCntoSubrecord::GetField()
 *=========================================================================*/

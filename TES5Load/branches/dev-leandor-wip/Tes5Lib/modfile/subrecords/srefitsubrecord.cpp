/*===========================================================================
 *
 * File:		Srefitsubrecord.CPP
 * Author:		Dave Humphrey (dave@uesp.net)
 * Created On:	12 December 2011
 *
 * Description
 *
 *=========================================================================*/

	/* Include Files */
#include "srefitsubrecord.h"


/*===========================================================================
 *
 * Class CSrEfitSubrecord Constructor
 *
 *=========================================================================*/
CSrEfitSubrecord::CSrEfitSubrecord () 
{
}
/*===========================================================================
 *		End of Class CSrEfitSubrecord Constructor
 *=========================================================================*/


/*===========================================================================
 *
 * Class CSrEfitSubrecord Method - void Destroy (void);
 *
 *=========================================================================*/
void CSrEfitSubrecord::Destroy (void) 
{
	CSrSubrecord::Destroy();
}
/*===========================================================================
 *		End of Class Method CSrEfitSubrecord::Destroy()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CSrEfitSubrecord Method - void InitializeNew (void);
 *
 *=========================================================================*/
void CSrEfitSubrecord::InitializeNew (void) 
{
  CSrSubrecord::InitializeNew();

  m_Data.Magnitude  = 0;
  m_Data.Area       = 0;
  m_Data.Duration   = 0;

  m_RecordSize = SREFIT_SUBRECORD_SIZE;
}
/*===========================================================================
 *		End of Class Method CSrEfitSubrecord::InitializeNew()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CSrEfitSubrecord Method - int CompareFields (Result, FieldID, pSubrecord);
 *
 *=========================================================================*/
bool CSrEfitSubrecord::CompareFields (int& Result, const int FieldID, CSrSubrecord* pSubrecord) 
{
  CSrEfitSubrecord* pCond1 = SrCastClass(CSrEfitSubrecord, pSubrecord);

  if (pCond1 != NULL) 
  {

    switch (FieldID) 
	{
	case SR_FIELD_MAGNITUDE:
		Result = (int) ((m_Data.Magnitude - pCond1->m_Data.Magnitude)*100.0f);
		return true;
    case SR_FIELD_AREA:
		Result = m_Data.Area - pCond1->m_Data.Area;
		return (true);
    case SR_FIELD_DURATION:
		Result = m_Data.Duration - pCond1->m_Data.Duration;
		return (true);
    }

  }

	/* No match */
  return CSrSubrecord::CompareFields(Result, FieldID, pSubrecord);
}
/*===========================================================================
 *		End of Class Method CSrEfitSubrecord::CompareFields()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CSrEfitSubrecord Method - bool GetField (Buffer, FieldID);
 *
 *=========================================================================*/
bool CSrEfitSubrecord::GetField (CSString& Buffer, const int FieldID) 
{
    
  switch (FieldID) 
  {
    case SR_FIELD_MAGNITUDE:
		Buffer.Format("%g", m_Data.Magnitude);
		return (true);
    case SR_FIELD_AREA:
		Buffer.Format("%u", m_Data.Area);
		return (true);
    case SR_FIELD_DURATION:
		Buffer.Format("%u", m_Data.Duration);
		return (true);
   }

  return CSrSubrecord::GetField(Buffer, FieldID);
}
/*===========================================================================
 *		End of Class Method CSrEfitSubrecord::GetField()
 *=========================================================================*/

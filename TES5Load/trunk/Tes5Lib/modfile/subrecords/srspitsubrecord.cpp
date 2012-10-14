/*===========================================================================
 *
 * File:		Srspitsubrecord.CPP
 * Author:		Dave Humphrey (dave@uesp.net)
 * Created On:	12 December 2011
 *
 * Description
 *
 *=========================================================================*/

	/* Include Files */
#include "srspitsubrecord.h"


/*===========================================================================
 *
 * Class CSrSpitSubrecord Constructor
 *
 *=========================================================================*/
CSrSpitSubrecord::CSrSpitSubrecord () 
{
}
/*===========================================================================
 *		End of Class CSrSpitSubrecord Constructor
 *=========================================================================*/


/*===========================================================================
 *
 * Class CSrSpitSubrecord Method - void Destroy (void);
 *
 *=========================================================================*/
void CSrSpitSubrecord::Destroy (void) 
{
	CSrSubrecord::Destroy();
}
/*===========================================================================
 *		End of Class Method CSrSpitSubrecord::Destroy()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CSrSpitSubrecord Method - void InitializeNew (void);
 *
 *=========================================================================*/
void CSrSpitSubrecord::InitializeNew (void) 
{
	CSrSubrecord::InitializeNew();

	memset(&m_Data, 0, sizeof(m_Data));

	m_RecordSize = SRSPIT_SUBRECORD_SIZE;
}
/*===========================================================================
 *		End of Class Method CSrSpitSubrecord::InitializeNew()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CSrSpitSubrecord Method - int CompareFields (Result, FieldID, pSubrecord);
 *
 *=========================================================================*/
bool CSrSpitSubrecord::CompareFields (int& Result, const int FieldID, CSrSubrecord* pSubrecord) 
{
	CSrSpitSubrecord* pSpellData = SrCastClass(CSrSpitSubrecord, pSubrecord);

	if (pSpellData != NULL) 
	{
	  
		switch (FieldID) 
		{
		  case SR_FIELD_PERK:
		    Result = (int)m_Data.PerkID - (int)pSpellData->m_Data.PerkID;
			return (true);
		  case SR_FIELD_SPELLFLAGS:
		    Result = (int)m_Data.Flags - (int)pSpellData->m_Data.Flags;
			return (true);
		  case SR_FIELD_CASTTIME:
		    Result = (int)m_Data.ChargeTime - (int)pSpellData->m_Data.ChargeTime;
			return (true);
		  case SR_FIELD_DELIVERYTYPE:
		    Result = (int)m_Data.TargetType - (int)pSpellData->m_Data.TargetType;
			return (true);
		  case SR_FIELD_CASTTYPE:
		    Result = (int)m_Data.CastType - (int)pSpellData->m_Data.CastType;
			return (true);
		  case SR_FIELD_COST:
			  Result = (int)m_Data.BaseCost - (int)pSpellData->m_Data.BaseCost;
			return (true);
		  case SR_FIELD_AUTOCALC:
		    Result = (int)IsAutoCalc() - (int)pSpellData->IsAutoCalc();
			return (true);
		  case SR_FIELD_SPELLTYPE:
			Result = (int)m_Data.SpellType - (int)pSpellData->m_Data.SpellType;
			return (true);
		}
	}

	return CSrSubrecord::CompareFields(Result, FieldID, pSubrecord);
}
/*===========================================================================
 *		End of Class Method CSrSpitSubrecord::CompareFields()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CSrSpitSubrecord Method - bool GetField (Buffer, FieldID);
 *
 *=========================================================================*/
bool CSrSpitSubrecord::GetField (CSString& Buffer, const int FieldID) 
{
  
	switch (FieldID) 
	{
	  case SR_FIELD_PERK:
	      Buffer.Format("%u", m_Data.PerkID);
		return (true);
	  case SR_FIELD_CASTTYPE:
	      Buffer.Format("%u", m_Data.CastType);
		return (true);
	  case SR_FIELD_CASTTIME:
	      Buffer.Format("%u", m_Data.ChargeTime);
		return (true);
	  case SR_FIELD_DELIVERYTYPE:
	      Buffer.Format("%u", m_Data.TargetType);
		return (true);
	  case SR_FIELD_SPELLFLAGS:
	      Buffer.Format("%u", m_Data.Flags);
		return (true);
	  case SR_FIELD_COST:
	      Buffer.Format("%u", m_Data.BaseCost);
		return (true);
	  case SR_FIELD_AUTOCALC:
	      Buffer.Format("%s", BooleanToString(IsAutoCalc()));
		return (true);
	  case SR_FIELD_SPELLTYPE:
	      Buffer.Format("%d", m_Data.SpellType);
		return (true);
	}

	return CSrSubrecord::GetField(Buffer, FieldID);
}
/*===========================================================================
 *		End of Class Method CSrSpitSubrecord::GetField()
 *=========================================================================*/
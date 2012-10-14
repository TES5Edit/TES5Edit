/*===========================================================================
 *
 * File:		SrScrlSpitsubrecord.H
 * Author:		Dave Humphrey (dave@uesp.net)
 * Created On:	13 February 2012
 *
 * Description
 *
 *=========================================================================*/
#ifndef __SRSCRLSPITSUBRECORD_H
#define __SRSCRLSPITSUBRECORD_H


/*===========================================================================
 *
 * Begin Required Includes
 *
 *=========================================================================*/
	#include "srsubrecord.h"
/*===========================================================================
 *		End of Required Includes
 *=========================================================================*/


/*===========================================================================
 *
 * Begin Definitions
 *
 *=========================================================================*/

	#define SRSCRLSPIT_SUBRECORD_SIZE	36

	#define SRSCRLSPIT_FLAG_MANUALCALC			0x00000001
	#define SRSCRLSPIT_FLAG_AREAIGNORESLOS		0x00080000
	#define SRSCRLSPIT_FLAG_SCRIPTALWAYSAPPLIES	0x00100000
	#define SRSCRLSPIT_FLAG_NOABSORBREFLECT		0x00200000
	#define SRSCRLSPIT_FLAG_FORCEEXPLODE		0x00400000

/*===========================================================================
 *		End of Definitions
 *=========================================================================*/


/*===========================================================================
 *
 * Begin Type Definitions
 *
 *=========================================================================*/
#pragma pack(push, 1)

	struct srscrlspitdata_t 
	{
		dword		BaseCost;
		dword		Flags;
		int			NullData1;
		float		ChargeTime;
		int			CastType;
		int			TargetType;
		dword		NullData3;
		float		Range;
		dword		CastDuration;
	};

#pragma pack(pop)
/*===========================================================================
 *		End of Type Definitions
 *=========================================================================*/


/*===========================================================================
 *
 * Begin Class CSrScrlSpitSubrecord Definition
 *
 * Description
 *
 *=========================================================================*/
class CSrScrlSpitSubrecord : public CSrSubrecord 
{
	DECLARE_SRCLASS(CSrScrlSpitSubrecord, CSrSubrecord)

  /*---------- Begin Protected Class Members --------------------*/
protected:
	srscrlspitdata_t	m_Data;


  /*---------- Begin Protected Class Methods --------------------*/
protected:

		/* Input/output the subrecord data */
	virtual bool ReadData  (CSrFile& File) { SR_VERIFY_SUBRECORDSIZE(SRSCRLSPIT_SUBRECORD_SIZE) return File.Read(&m_Data,  m_RecordSize); }
	virtual bool WriteData (CSrFile& File) { SR_VERIFY_SUBRECORDSIZE(SRSCRLSPIT_SUBRECORD_SIZE) return File.Write(&m_Data, m_RecordSize); }


  /*---------- Begin Public Class Methods -----------------------*/
public:

		/* Class Constructors/Destructors */
	CSrScrlSpitSubrecord() { }
	virtual void Destroy (void) { }

		/* Compare two subrecord fields */
	virtual bool CompareFields (int& Result, const int FieldID, CSrSubrecord* pSubrecord)
	{
		CSrScrlSpitSubrecord* pScrollData = SrCastClass(CSrScrlSpitSubrecord, pSubrecord);
		if (pScrollData == NULL) return false;	
	  
		switch (FieldID) 
		{
		  case SR_FIELD_SPELLFLAGS:
		    Result = (int)m_Data.Flags - (int)pScrollData->m_Data.Flags;
			return (true);
		  case SR_FIELD_CASTTIME:
		    Result = (int)m_Data.ChargeTime - (int)pScrollData->m_Data.ChargeTime;
			return (true);
		  case SR_FIELD_DELIVERYTYPE:
		    Result = (int)m_Data.TargetType - (int)pScrollData->m_Data.TargetType;
			return (true);
		  case SR_FIELD_COST:
			  Result = (int)m_Data.BaseCost - (int)pScrollData->m_Data.BaseCost;
			return (true);
		  case SR_FIELD_AUTOCALC:
		    Result = (int)IsAutoCalc() - (int)pScrollData->IsAutoCalc();
			return (true);
		}

		return CSrSubrecord::CompareFields(Result, FieldID, pSubrecord);
	}
	

  		/* Copy the content from an existing subrecord */
	virtual bool Copy (CSrSubrecord* pSubrecord) 
	{
		CSrScrlSpitSubrecord* pSubrecord1 = SrCastClassNull(CSrScrlSpitSubrecord, pSubrecord);
		m_RecordSize = SRSCRLSPIT_SUBRECORD_SIZE;

		if (pSubrecord1 != NULL) 
			m_Data = pSubrecord1->m_Data;
		else 
			memset(&m_Data, 0, sizeof(m_Data));

		return (true);
	}

  		/* Create a class instance */
	static  CSrSubrecord* Create  (void) { return new CSrScrlSpitSubrecord; }
	virtual CSrSubrecord* CreateV (void) { return new CSrScrlSpitSubrecord; }

		/* Get class members */
	srscrlspitdata_t& GetScrollData	(void) { return (m_Data); }
	virtual byte* GetData			(void) { return (byte *)(&m_Data); }

	bool IsAutoCalc				(void) { return !CheckFlagBits(m_Data.Flags, SRSCRLSPIT_FLAG_MANUALCALC); }
	bool IsAreaIgnoresLOS		(void) { return  CheckFlagBits(m_Data.Flags, SRSCRLSPIT_FLAG_AREAIGNORESLOS); }
	bool IsNoAbsorbReflect		(void) { return  CheckFlagBits(m_Data.Flags, SRSCRLSPIT_FLAG_NOABSORBREFLECT); }		
	bool IsScriptAlwaysApplies	(void) { return  CheckFlagBits(m_Data.Flags, SRSCRLSPIT_FLAG_SCRIPTALWAYSAPPLIES); }
	bool IsForceExplode    		(void) { return  CheckFlagBits(m_Data.Flags, SRSCRLSPIT_FLAG_FORCEEXPLODE); }

  		/* Get a string representation of a subrecord field */
	bool GetField (CSString& Buffer, const int FieldID)
	{
		switch (FieldID) 
		{
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
		}

		return CSrSubrecord::GetField(Buffer, FieldID);
	}
  	
		/* Initialize a new record */
	void InitializeNew (void)
	{
		CSrSubrecord::InitializeNew();

		memset(&m_Data, 0, sizeof(m_Data));

		m_RecordSize = SRSCRLSPIT_SUBRECORD_SIZE;
		m_Data.CastType = 3;
	}

		/* Set class members */
	void SetAutoCalc            (const bool  Flag)  { FlipFlagBits(m_Data.Flags, SRSCRLSPIT_FLAG_MANUALCALC, !Flag); }
	void SetAreaIgnoresLOS      (const bool  Flag)  { FlipFlagBits(m_Data.Flags, SRSCRLSPIT_FLAG_AREAIGNORESLOS, Flag); }
	void SetNoAbsorbReflect     (const bool  Flag)  { FlipFlagBits(m_Data.Flags, SRSCRLSPIT_FLAG_NOABSORBREFLECT, Flag); }
	void SetScriptAlwaysApplies (const bool  Flag)  { FlipFlagBits(m_Data.Flags, SRSCRLSPIT_FLAG_SCRIPTALWAYSAPPLIES, Flag); }
	void SetForceExplode        (const bool  Flag)  { FlipFlagBits(m_Data.Flags, SRSCRLSPIT_FLAG_FORCEEXPLODE, Flag); }		 		

};
/*===========================================================================
 *		End of Class CSrScrlSpitSubrecord Definition
 *=========================================================================*/


#endif
/*===========================================================================
 *		End of File SrScrlSpitSubrecord.H
 *=========================================================================*/

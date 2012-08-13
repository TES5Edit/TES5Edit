/*===========================================================================
 *
 * File:		Srenitsubrecord.H
 * Author:		Dave Humphrey (dave@uesp.net)
 * Created On:	12 December 2011
 *
 * Description
 *
 *=========================================================================*/
#ifndef __SRENITSUBRECORD_H
#define __SRENITSUBRECORD_H


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

		/* Standard ENIT subrecord size in bytes */
	#define SRENIT_SUBRECORD_SIZE	36

		/* Enchantment flags */
	#define SR_ENCHFLAG_MANUALCALC	   0x00000001
	#define SR_ENCHFLAG_EXTENDDURATION 0x00000004

/*===========================================================================
 *		End of Definitions
 *=========================================================================*/


/*===========================================================================
 *
 * Begin Type Definitions
 *
 *=========================================================================*/
#pragma pack(push, 1)

struct srenitdata_t 
{
	dword		ChargeAmount;
	dword		Flags;
	int			CastType;
	dword		EnchantCost;
	int			DeliveryType;
	int			EnchantType;
	float		ChargeTime;
	srformid_t	BaseEnchantID;
	srformid_t	ItemTypesID;
};

#pragma pack(pop)
/*===========================================================================
 *		End of Type Definitions
 *=========================================================================*/


/*===========================================================================
 *
 * Begin Class CSrEnitSubrecord Definition
 *
 * Description
 *
 *=========================================================================*/
class CSrEnitSubrecord : public CSrSubrecord 
{
	DECLARE_SRCLASS(CSrEnitSubrecord, CSrSubrecord)

  /*---------- Begin Protected Class Members --------------------*/
protected:
	srenitdata_t	m_Data;


  /*---------- Begin Protected Class Methods --------------------*/
protected:

		/* Input/output the subrecord data */
	virtual bool ReadData  (CSrFile& File) { m_Data.ItemTypesID = 0; SR_VERIFY_SUBRECORDSIZE_MAX(SRENIT_SUBRECORD_SIZE) return File.Read(&m_Data,  m_RecordSize); }
	virtual bool WriteData (CSrFile& File) { SR_VERIFY_SUBRECORDSIZE_MAX(SRENIT_SUBRECORD_SIZE) return File.Write(&m_Data, m_RecordSize); }


  /*---------- Begin Public Class Methods -----------------------*/
public:

		/* Class Constructors/Destructors */
	CSrEnitSubrecord();
	virtual void Destroy (void);

  			/* Change any matching formid in the subrecord */
	virtual dword ChangeFormID (const srformid_t NewID, const srformid_t OldID) 
	{
		if (m_Data.BaseEnchantID == OldID) 
		{
			m_Data.BaseEnchantID = NewID;
			return (1);
		}

		if (m_Data.ItemTypesID == OldID) 
		{
			m_Data.ItemTypesID = NewID;
			return (1);
		}

		return (0); 
	}

  
	virtual dword CountUses (const srformid_t FormID) 
	{
		return (FormID == m_Data.ItemTypesID) + (FormID == m_Data.BaseEnchantID);
	}

		/* Fixup the modindex of formids */
	virtual bool FixupFormID (CSrFormidFixupArray& FixupArray) 
	{
		bool Result = SrFixupFormid(m_Data.BaseEnchantID, m_Data.BaseEnchantID, FixupArray);
		Result &= SrFixupFormid(m_Data.ItemTypesID, m_Data.ItemTypesID, FixupArray);
		return Result;
	}

		/* Compare two subrecord fields */
	virtual bool CompareFields (int& Result, const int FieldID, CSrSubrecord* pSubrecord);

  		/* Copy the content from an existing subrecord */
	virtual bool Copy (CSrSubrecord* pSubrecord) 
	{
		CSrEnitSubrecord* pSubrecord1 = SrCastClassNull(CSrEnitSubrecord, pSubrecord);
		m_RecordSize = SRENIT_SUBRECORD_SIZE;

		if (pSubrecord1 != NULL) 
			m_Data = pSubrecord1->GetEnchantData();
		else 
			memset(&m_Data, 0, sizeof(m_Data));

		return (true);
	}

  		/* Create a class instance */
	static  CSrSubrecord* Create  (void) { return (new CSrEnitSubrecord); }
	virtual CSrSubrecord* CreateV (void) { return new CSrEnitSubrecord; }

		/* Get class members */
	srenitdata_t& GetEnchantData	(void) { return (m_Data); }
	virtual byte* GetData			(void) { return (byte *)(&m_Data); }
	bool          IsAutoCalc		(void) { return !CheckFlagBits(m_Data.Flags, SR_ENCHFLAG_MANUALCALC); }
	bool          IsExtendDuration	(void) { return CheckFlagBits(m_Data.Flags, SR_ENCHFLAG_EXTENDDURATION); }

  		/* Get a string representation of a subrecord field */
	bool GetField (CSString& Buffer, const int FieldID);
  	
		/* Initialize a new record */
	void InitializeNew (void);

		/* Set class members */
	void SetAutoCalc       (const bool  Flag)  { FlipFlagBits(m_Data.Flags, SR_ENCHFLAG_MANUALCALC, !Flag); }
	void SetExtendDuration (const bool  Flag)  { FlipFlagBits(m_Data.Flags, SR_ENCHFLAG_EXTENDDURATION, Flag); }

};
/*===========================================================================
 *		End of Class CSrEnitSubrecord Definition
 *=========================================================================*/


/*===========================================================================
 *
 * Class CSrEnitSubrecord Method - int CompareFields (Result, FieldID, pSubrecord);
 *
 *=========================================================================*/
inline bool CSrEnitSubrecord::CompareFields (int& Result, const int FieldID, CSrSubrecord* pSubrecord) 
{
  CSrEnitSubrecord* pEnit = SrCastClass(CSrEnitSubrecord, pSubrecord);

  if (pEnit != NULL) {

    switch (FieldID) {
      case SR_FIELD_CHARGE:
		  Result = (int)m_Data.ChargeAmount - (int)pEnit->m_Data.ChargeAmount;
		return (true);
      case SR_FIELD_COST:
		  Result = (int)m_Data.EnchantCost - (int)m_Data.EnchantCost;
		return (true);
      case SR_FIELD_AUTOCALC:
        Result = (int)IsAutoCalc() - (int)pEnit->IsAutoCalc();
		return (true);
      case SR_FIELD_DELIVERYTYPE:
		Result = (int)m_Data.DeliveryType - (int)pEnit->m_Data.DeliveryType;
		return (true);
	  case SR_FIELD_CASTTYPE:
		Result = (int)m_Data.CastType - (int)pEnit->m_Data.CastType;
		return (true);
     }

   }

	/* Check subrecord */
  return CSrSubrecord::CompareFields(Result, FieldID, pSubrecord);
 }
/*===========================================================================
 *		End of Class Method CSrEnitSubrecord::CompareFields()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CSrEnitSubrecord Method - bool GetField (Buffer, FieldID);
 *
 *=========================================================================*/
inline bool CSrEnitSubrecord::GetField (CSString& Buffer, const int FieldID) {
  
  switch (FieldID) {
    case SR_FIELD_CHARGE:
        Buffer.Format("%u", m_Data.ChargeAmount);
		return (true);
    case SR_FIELD_COST:
		Buffer.Format("%u", m_Data.EnchantCost);
		return (true);
    case SR_FIELD_AUTOCALC:
        Buffer.Format("%s", BooleanToString(IsAutoCalc()));
		return (true);
    case SR_FIELD_CASTTYPE:
		Buffer.Format("%d", m_Data.CastType);
		return (true);
	case SR_FIELD_DELIVERYTYPE:
		Buffer.Format("%d", m_Data.DeliveryType);
		return (true);
   }

  return CSrSubrecord::GetField(Buffer, FieldID);
 }
/*===========================================================================
 *		End of Class Method CSrEnitSubrecord::GetField()
 *=========================================================================*/


#endif
/*===========================================================================
 *		End of File Srenitsubrecord.H
 *=========================================================================*/

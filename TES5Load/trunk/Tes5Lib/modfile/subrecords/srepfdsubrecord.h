/*===========================================================================
 *
 * File:		SrEpfdSubrecord.H
 * Author:		Dave Humphrey (dave@uesp.net)
 * Created On:	3 January 2012
 *
 * Description
 *
 *=========================================================================*/
#ifndef __SREPFDSUBRECORD_H
#define __SREPFDSUBRECORD_H


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

		/* Fixed subrecord sizes */
	#define SR_EPFD01_SUBRECORD_SIZE	4
	#define SR_EPFD02_SUBRECORD_SIZE	8
    #define SR_EPFD03_SUBRECORD_SIZE	4
	#define SR_EPFD04_SUBRECORD_SIZE	4
	#define SR_EPFD05_SUBRECORD_SIZE	4
		/* Types 06/07 are variable sized */
	#define SR_EPFDFLOAT_SUBRECORD_SIZE      SR_EPFD01_SUBRECORD_SIZE
	#define SR_EPFDACTORVALUE_SUBRECORD_SIZE SR_EPFD02_SUBRECORD_SIZE
	#define SR_EPFDOTHER_SUBRECORD_SIZE      SR_EPFD04_SUBRECORD_SIZE
	#define SR_EPFDFORMID_SUBRECORD_SIZE     SR_EPFD05_SUBRECORD_SIZE

		/* EPFD data types. This should be the same value as in the prior EPFT byte subrecord */
	#define SP_EPFDTYPE_UNKNOWN		0
	#define SP_EPFDTYPE_ONEFLOAT	1
	#define SP_EPFDTYPE_TWOFLOATS	2
	#define SP_EPFDTYPE_LEVELLIST	3
	#define SP_EPFDTYPE_ACTIVATE	4
	#define SP_EPFDTYPE_SPELL		5
	#define SP_EPFDTYPE_ZSTRING		6
	#define SP_EPFDTYPE_LSTRING		7

		/* Effect function types */
	#define SRPERK_EFFECT_FUNCTION_SETVALUE				0x01
	#define SRPERK_EFFECT_FUNCTION_ADDVALUE				0x02
	#define SRPERK_EFFECT_FUNCTION_MULTVALUE			0x03
	#define SRPERK_EFFECT_FUNCTION_ADDRANGEVALUE		0x04
	#define SRPERK_EFFECT_FUNCTION_AVADDMULTVALUE		0x05
	#define SRPERK_EFFECT_FUNCTION_ABSVALUE				0x06
	#define SRPERK_EFFECT_FUNCTION_NEGABSVALUE			0x07
	#define SRPERK_EFFECT_FUNCTION_ADDLEVELLIST			0x08
	#define SRPERK_EFFECT_FUNCTION_ACTIVATE				0x09
	#define SRPERK_EFFECT_FUNCTION_ADDSPELL				0x0A
	#define SRPERK_EFFECT_FUNCTION_SETGMST				0x0B
	#define SRPERK_EFFECT_FUNCTION_AVMULTVALUE			0x0C
	#define SRPERK_EFFECT_FUNCTION_AVMULTMULTVALUE		0x0D
	#define SRPERK_EFFECT_FUNCTION_AVADDMULTMULTVALUE	0x0E
	#define SRPERK_EFFECT_FUNCTION_SETTEXT				0x0F
    #define SRPERK_EFFECT_FUNCTION_MAX					0x0F

    #define SRPERK_EFFECT_TYPE_MAX	0x5A

		/* Flags for defining valid functions in the perk effect info structure */
	#define SRPERK_EFFECT_FUNCFLAG_SETVALUE				0x0002  // 0x01
	#define SRPERK_EFFECT_FUNCFLAG_ADDVALUE				0x0004  // 0x02
	#define SRPERK_EFFECT_FUNCFLAG_MULTVALUE			0x0008  // 0x03
	#define SRPERK_EFFECT_FUNCFLAG_RANGEVALUE			0x0010  // 0x04
	#define SRPERK_EFFECT_FUNCFLAG_AVADDMULTVALUE		0x0020  // 0x05
	#define SRPERK_EFFECT_FUNCFLAG_ABSVALUE				0x0040  // 0x06
	#define SRPERK_EFFECT_FUNCFLAG_NEGABSVALUE			0x0080  // 0x07
	#define SRPERK_EFFECT_FUNCFLAG_ADDLEVELLIST			0x0100  // 0x08
	#define SRPERK_EFFECT_FUNCFLAG_ACTIVATE				0x0200  // 0x09
	#define SRPERK_EFFECT_FUNCFLAG_ADDSPELL				0x0400  // 0x0A
	#define SRPERK_EFFECT_FUNCFLAG_SETGMST				0x0800  // 0x0B
	#define SRPERK_EFFECT_FUNCFLAG_AVMULTVALUE			0x1000  // 0x0C
	#define SRPERK_EFFECT_FUNCFLAG_AVMULTMULTVALUE		0x2000  // 0x0D
	#define SRPERK_EFFECT_FUNCFLAG_AVADDMULTMULTVALUE	0x4000  // 0x0E
	#define SRPERK_EFFECT_FUNCFLAG_SETTEXT				0x8000  // 0x0F
	#define SRPERK_EFFECT_FUNCFLAG_ALLVALUES			0x70FF
	
		/* Condition tab types for perk entries */
	#define SRPERK_EFFECT_CONDNONE				0
	#define SRPERK_EFFECT_CONDOWNER				1
	#define SRPERK_EFFECT_CONDTARGET			2
	#define SRPERK_EFFECT_CONDATTACKER			3
	#define SRPERK_EFFECT_CONDATTACKERWEAPON	4
	#define SRPERK_EFFECT_CONDSPELL				5
	#define SRPERK_EFFECT_CONDWEAPON			6
	#define SRPERK_EFFECT_CONDITEM				7
	#define SRPERK_EFFECT_CONDENCHANTMENT		8
	#define SRPERK_EFFECT_CONDLOCKEDREF			9
	#define SRPERK_EFFECT_CONDMAX				9

	#define SRPERK_EFFECT_MAXCONDTYPES		3

/*===========================================================================
 *		End of Definitions
 *=========================================================================*/


/*===========================================================================
 *
 * Begin Type Definitions
 *
 *=========================================================================*/
#pragma pack(push, 1)

	struct srepfddata01_t 
	{
		float	Value;
	};

	struct srepfddata02_t 
	{
		float	Value1;
		float	Value2;
	};

	struct srepfddata03_t 
	{
		srformid_t	FormID;
	};

	struct srepfddata04_t 
	{
		srformid_t	FormID;
	};

	struct srepfddata05_t 
	{
		srformid_t FormID;
	};

#pragma pack(pop)

	struct srepfddata06_t 
	{
		CSString	String;
	};

	struct srepfddata07_t 
	{
		int			StringID;
		CSString	String;
		bool		IsLoaded;
		bool		IsLocalString;

		srepfddata07_t() : StringID(-1), IsLoaded(false), IsLocalString(false)
		{
		}
	};

		/* Holds information on the perk effect types */
	struct srperkeffectinfo_t
	{
		byte	EffectType;
		byte	ConditionTypeCounts;
		word	FunctionFlags;	
		byte	ConditionTypes[SRPERK_EFFECT_MAXCONDTYPES];
	
		bool IsFunctionFlag (const word Flag) const
		{
			return (FunctionFlags & Flag) != 0;
		}
	
		bool IsFunctionType (const word Type) const
		{
			return ((dword)FunctionFlags & ((dword)1 << (dword)Type)) != 0;
		}
	
		byte GetConditionType (const dword Index) const
		{
			if (Index >= SRPERK_EFFECT_MAXCONDTYPES) return SRPERK_EFFECT_CONDNONE;
			return ConditionTypes[Index];
		}
	
	};

		/* Holds static information about the Perk function types */
	struct srperkfuncinfo_t
	{
		byte	FunctionType;
		byte	EPFTType;
	};

/*===========================================================================
 *		End of Type Definitions
 *=========================================================================*/


/*===========================================================================
 *
 * Begin Class CSrEpfdSubrecord Definition
 *
 * Description
 *
 *=========================================================================*/
class CSrEpfdSubrecord : public CSrSubrecord {
	DECLARE_SRCLASS(CSrEpfdSubrecord, CSrSubrecord)

  /*---------- Begin Protected Class Members --------------------*/
protected:
	srepfddata01_t	m_Data01;
	srepfddata02_t	m_Data02;
	srepfddata03_t  m_Data03;
	srepfddata04_t	m_Data04;
	srepfddata05_t	m_Data05;
	srepfddata06_t	m_Data06;
	srepfddata07_t	m_Data07;

	byte			m_DataType;


  /*---------- Begin Protected Class Methods --------------------*/
protected:

	virtual bool ReadData  (CSrFile& File);
	virtual bool WriteData (CSrFile& File);


  /*---------- Begin Public Class Methods -----------------------*/
public:

	CSrEpfdSubrecord();
	virtual void Destroy (void);

	virtual bool Copy (CSrSubrecord* pSubrecord);

	virtual dword ChangeFormID (const srformid_t NewID, const srformid_t OldID);
	virtual dword CountUses (const srformid_t FormID);
  	virtual bool FixupFormID (CSrFormidFixupArray& FixupArray);
	
	static  CSrSubrecord* Create  (void) { return new CSrEpfdSubrecord; }
	virtual CSrSubrecord* CreateV (void) { return new CSrEpfdSubrecord; }

	srepfddata01_t&  GetEpfdData01 (void) { return m_Data01; }
	srepfddata02_t&  GetEpfdData02 (void) { return m_Data02; }
	srepfddata03_t&  GetEpfdData03 (void) { return m_Data03; }
	srepfddata04_t&  GetEpfdData04 (void) { return m_Data04; }
	srepfddata05_t&  GetEpfdData05 (void) { return m_Data05; }
	srepfddata06_t&  GetEpfdData06 (void) { return m_Data06; }
	srepfddata07_t&  GetEpfdData07 (void) { return m_Data07; }

	byte GetDataType (void) { return m_DataType; }

	virtual byte*  GetData       (void);
	virtual dword  GetRecordSize (void) const;
  
	void InitializeNew (void);

	void LoadLocalStrings (CSrRecordHandler* pHandler);

	void SetDataType        (const byte Value) { m_DataType = Value; }
	void SetLoadLocalString (const bool Value) { m_Data07.IsLocalString = Value; }

	virtual void UpdateLocalStrings(CSrStringFile& StringFile, srlstringid_t& NextStringID);
  
};
/*===========================================================================
 *		End of Class CSrEpfdSubrecord Definition
 *=========================================================================*/


const srperkeffectinfo_t GetSrPerkEffectInfo   (const dword EffectType);
const srperkfuncinfo_t   GetSrPerkFunctionInfo (const dword FuncType);


#endif
/*===========================================================================
 *		End of File SrEpfdSubrecord.H
 *=========================================================================*/

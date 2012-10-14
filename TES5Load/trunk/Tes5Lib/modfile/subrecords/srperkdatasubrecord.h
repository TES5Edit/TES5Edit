/*===========================================================================
 *
 * File:		SrPerkDataSubrecord.H
 * Author:		Dave Humphrey (dave@uesp.net)
 * Created On:	2 January 2012
 *
 * Description
 *
 *=========================================================================*/
#ifndef __SRPERKDATASUBRECORD_H
#define __SRPERKDATASUBRECORD_H


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

	#define SR_PERKDATA_SUBRECORD_SIZE		5
	#define SR_PERKDATA00_SUBRECORD_SIZE	8
	#define SR_PERKDATA01_SUBRECORD_SIZE	4
	#define SR_PERKDATA02_SUBRECORD_SIZE	3

/*===========================================================================
 *		End of Definitions
 *=========================================================================*/


/*===========================================================================
 *
 * Begin Type Definitions
 *
 *=========================================================================*/
#pragma pack(push, 1)

	enum srperkdatatype_t
	{
		SR_PERKDATA_TYPE00   = 0x00,
		SR_PERKDATA_TYPE01	 = 0x01,
		SR_PERKDATA_TYPE02	 = 0x02,		
		SR_PERKDATA_TYPEBASE = 0xFF
	};

		/* Main PERK data structure */
	struct srperkdata_t 
	{
		word	NullData;
		byte    Unknown1;
		byte    Unknown2;
		byte    Unknown3;
	};

		/* Section Type 0000 PERK data structure */
	struct srperkdata00_t 
	{
		srformid_t	QuestID;
		dword		Stage;
	};

		/* Section Type 0001 PERK data structure */
	struct srperkdata01_t 
	{
		srformid_t	RecordID;		
	};

		/* Section Type 0002 PERK data structure */
	struct srperkdata02_t 
	{
		byte	EffectType;
		byte	FunctionType;
		byte	CondTypeCount;
	};

#pragma pack(pop)
/*===========================================================================
 *		End of Type Definitions
 *=========================================================================*/


/*===========================================================================
 *
 * Begin Class CSrPerkDataSubrecord Definition
 *
 * Description
 *
 *=========================================================================*/
class CSrPerkDataSubrecord : public CSrSubrecord {
	DECLARE_SRCLASS(CSrPerkDataSubrecord, CSrSubrecord)

  /*---------- Begin Protected Class Members --------------------*/
protected:
	srperkdata_t		m_Data;

	srperkdata00_t		m_Data00;
	srperkdata01_t		m_Data01;
	srperkdata02_t		m_Data02;
	
	srperkdatatype_t	m_DataType;


  /*---------- Begin Protected Class Methods --------------------*/
protected:

	virtual bool ReadData  (CSrFile& File);
	virtual bool WriteData (CSrFile& File);
	

  /*---------- Begin Public Class Methods -----------------------*/
public:

		/* Class Constructors/Destructors */
	CSrPerkDataSubrecord() : m_DataType(SR_PERKDATA_TYPEBASE) { }
	virtual void Destroy (void) { CSrSubrecord::Destroy(); }
	
	virtual bool Copy (CSrSubrecord* pSubrecord);
	
	virtual dword ChangeFormID (const srformid_t NewID, const srformid_t OldID);
	virtual dword CountUses (const srformid_t FormID);
  	virtual bool FixupFormID (CSrFormidFixupArray& FixupArray);

		/* Create a class instance */
	static CSrSubrecord* Create (void) { return (new CSrPerkDataSubrecord); }
	virtual CSrSubrecord* CreateV (void) { return new CSrPerkDataSubrecord; }
	
		/* Get class members */
	srperkdatatype_t GetPerkDataType (void) { return m_DataType; }
	srperkdata_t&    GetPerkData     (void) { return m_Data; }
	srperkdata00_t&  GetPerkData00   (void) { return m_Data00; }
	srperkdata01_t&  GetPerkData01   (void) { return m_Data01; }
	srperkdata02_t&  GetPerkData02   (void) { return m_Data02; }

	virtual byte* GetData (void);
	virtual dword GetRecordSize (void) const;
	
	void InitializeNew (void);

	void SetDataType (const srperkdatatype_t Type) { m_DataType = Type; }
	
};
/*===========================================================================
 *		End of Class CSrPerkDataSubrecord Definition
 *=========================================================================*/


#endif
/*===========================================================================
 *		End of File SrPerkDataSubrecord.H
 *=========================================================================*/

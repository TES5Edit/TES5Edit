/*===========================================================================
 *
 * File:		SrClasrecord.H
 * Author:		Dave Humphrey (dave@uesp.net)
 * Created On:	5 December 2011
 *
 * Defines the CSrClasRecord class.
 *
 *=========================================================================*/
#ifndef __SRCLASRECORD_H
#define __SRCLASRECORD_H


/*===========================================================================
 *
 * Begin Required Includes
 *
 *=========================================================================*/
	#include "sridrecord.h"
	#include "../subrecords/srlstringsubrecord.h"
	#include "../subrecords/srclasdatasubrecord.h"
/*===========================================================================
 *		End of Required Includes
 *=========================================================================*/


/*===========================================================================
 *
 * Begin Class CSrClasRecord Definition
 *
 *=========================================================================*/
class CSrClasRecord : public CSrIdRecord 
{
	DECLARE_SRSUBRECCREATE()
	DECLARE_SRFIELDMAP()
	DECLARE_SRCLASS(CSrClasRecord, CSrIdRecord)

  /*---------- Begin Protected Class Members --------------------*/
protected:
	CSrLStringSubrecord*		m_pDescription;
	CSrLStringSubrecord*		m_pItemName;
	CSrClasDataSubrecord*		m_pClassData;

	static srclasdata_t s_NullClassData;


  /*---------- Begin Protected Class Methods --------------------*/
protected:


  /*---------- Begin Public Class Methods -----------------------*/
public:

		/* Class Constructors/Destructors */
	CSrClasRecord();
	virtual void Destroy (void);

    	/* Return a new instance of the class */
	static CSrRecord* Create (void) { return new CSrClasRecord; }

		/* Get class members */
	srclasdata_t& GetClassData  (void) { return m_pClassData ? m_pClassData->GetClassData() : s_NullClassData; }
	const char* GetTrainerSkill (void) { return GetSrSkillTypeString(GetClassData().TrainerSkill + SR_SKILL_ONEHAND); }

		/* Initialize a new record */
	void InitializeNew (void);

		/* Called to alert record of a new subrecord being added */
	virtual void OnAddSubrecord    (CSrSubrecord* pSubrecord);
	virtual void OnDeleteSubrecord (CSrSubrecord* pSubrecord);

		/* Set class members */
	void SetTrainerSkill (const char* pString) { int Value(SR_SKILL_ONEHAND); GetSrSkillTypeValue(Value, pString); GetClassData().TrainerSkill = Value - SR_SKILL_ONEHAND; }

		/* Begin field method definitions */
	DECLARE_SRFIELD_DESCRIPTION(CSrClasRecord, SR_NAME_DESC)
	DECLARE_SRFIELD_ITEMNAME(CSrClasRecord)

	DECLARE_SRFIELD_WORDFLAG1(CSrClasRecord,  Unknown1,  GetClassData().Unknown1,  GetClassData().Unknown1)
	DECLARE_SRFIELD_SHORT1(CSrClasRecord, Unknown2,  GetClassData().Unknown2,  GetClassData().Unknown2)
	DECLARE_SRFIELD_METHOD(CSrClasRecord,  TrainerSkill,  GetTrainerSkill, SetTrainerSkill)
	DECLARE_SRFIELD_BYTE1(CSrClasRecord,  TrainerLevel,  GetClassData().TrainerLevel,  GetClassData().TrainerLevel)
	DECLARE_SRFIELD_FLOAT1(CSrClasRecord, Unknown3, GetClassData().Unknown3,  GetClassData().Unknown3)
	DECLARE_SRFIELD_DWORD1(CSrClasRecord, Unknown4, GetClassData().Unknown4,  GetClassData().Unknown4)
	DECLARE_SRFIELD_BYTE1(CSrClasRecord,  Unknown5, GetClassData().Unknown5,  GetClassData().Unknown5)
	DECLARE_SRFIELD_BYTE1(CSrClasRecord,  Unknown6, GetClassData().Unknown6,  GetClassData().Unknown6)
	DECLARE_SRFIELD_BYTE1(CSrClasRecord,  Unknown7, GetClassData().Unknown7,  GetClassData().Unknown7)
	DECLARE_SRFIELD_BYTE1(CSrClasRecord,  Unknown8, GetClassData().Unknown8, GetClassData().Unknown8)

	DECLARE_SRFIELD_BYTE1(CSrClasRecord, OneHand,		GetClassData().Skills[0],   GetClassData().Skills[0])
	DECLARE_SRFIELD_BYTE1(CSrClasRecord, TwoHand,		GetClassData().Skills[1],   GetClassData().Skills[1])
	DECLARE_SRFIELD_BYTE1(CSrClasRecord, Marksman,		GetClassData().Skills[2],   GetClassData().Skills[2])
	DECLARE_SRFIELD_BYTE1(CSrClasRecord, Block,			GetClassData().Skills[3],   GetClassData().Skills[3])
	DECLARE_SRFIELD_BYTE1(CSrClasRecord, Smithing,		GetClassData().Skills[4],   GetClassData().Skills[4])
	DECLARE_SRFIELD_BYTE1(CSrClasRecord, HeavyArmor,	GetClassData().Skills[5],   GetClassData().Skills[5])
	DECLARE_SRFIELD_BYTE1(CSrClasRecord, LightArmor,	GetClassData().Skills[6],   GetClassData().Skills[6])
	DECLARE_SRFIELD_BYTE1(CSrClasRecord, Pickpocket,	GetClassData().Skills[7],   GetClassData().Skills[7])
	DECLARE_SRFIELD_BYTE1(CSrClasRecord, Lockpicking,	GetClassData().Skills[8],   GetClassData().Skills[8])
	DECLARE_SRFIELD_BYTE1(CSrClasRecord, Sneak,			GetClassData().Skills[9],   GetClassData().Skills[9])
	DECLARE_SRFIELD_BYTE1(CSrClasRecord, Alchemy,		GetClassData().Skills[10],  GetClassData().Skills[10])
	DECLARE_SRFIELD_BYTE1(CSrClasRecord, Speechcraft,	GetClassData().Skills[11],  GetClassData().Skills[11])
	DECLARE_SRFIELD_BYTE1(CSrClasRecord, Alteration,	GetClassData().Skills[12],  GetClassData().Skills[12])
	DECLARE_SRFIELD_BYTE1(CSrClasRecord, Conjuration,	GetClassData().Skills[13],  GetClassData().Skills[13])
	DECLARE_SRFIELD_BYTE1(CSrClasRecord, Destruction,	GetClassData().Skills[14],  GetClassData().Skills[14])
	DECLARE_SRFIELD_BYTE1(CSrClasRecord, Illusion,		GetClassData().Skills[15],  GetClassData().Skills[15])
	DECLARE_SRFIELD_BYTE1(CSrClasRecord, Restoration,	GetClassData().Skills[16],  GetClassData().Skills[16])
	DECLARE_SRFIELD_BYTE1(CSrClasRecord, Enchanting,	GetClassData().Skills[17],  GetClassData().Skills[17])	

};
/*===========================================================================
 *		End of Class CSrClasRecord Definition
 *=========================================================================*/


#endif
/*===========================================================================
 *		End of File SrClasRecord.H
 *=========================================================================*/

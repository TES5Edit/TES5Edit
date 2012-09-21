/*===========================================================================
 *
 * File:		SrArmarecord.H
 * Author:		Dave Humphrey (dave@uesp.net)
 * Created On:	5 December 2011
 *
 * Defines the CSrArmaRecord class.
 *
 *=========================================================================*/
#ifndef __SRARMARECORD_H
#define __SRARMARECORD_H


/*===========================================================================
 *
 * Begin Required Includes
 *
 *=========================================================================*/
	#include "sridrecord.h"
	#include "../subrecords/srbodtsubrecord.h"
	#include "../subrecords/srarmadnamsubrecord.h"
/*===========================================================================
 *		End of Required Includes
 *=========================================================================*/


/*===========================================================================
 *
 * Begin Class CSrArmaRecord Definition
 *
 *=========================================================================*/
class CSrArmaRecord : public CSrIdRecord 
{
  DECLARE_SRSUBRECCREATE()
  DECLARE_SRFIELDMAP()
  DECLARE_SRCLASS(CSrArmaRecord, CSrIdRecord)

  /*---------- Begin Protected Class Members --------------------*/
protected:
	
	CSrBodtSubrecord*		m_pBodtData;
	CSrStringSubrecord*		m_pModel2;
	CSrStringSubrecord*		m_pModel3;
	CSrStringSubrecord*		m_pModel4;
	CSrStringSubrecord*		m_pModel5;
	CSrFormidSubrecord*		m_pRace;
	CSrFormidSubrecord*		m_pMaleTexture;
	CSrFormidSubrecord*		m_pFemaleTexture;
	CSrFormidSubrecord*		m_pMale1stTexture;
	CSrFormidSubrecord*		m_pFemale1stTexture;
	CSrFormidSubrecord*		m_pFootsteps;
	CSrArmaDnamSubrecord*	m_pDnamData;
	CSString				m_BodyPartsString;

	static srarmadnamdata_t s_NullDnamData;
	static srbodtdata_t     s_NullBodtData;
	

  /*---------- Begin Protected Class Methods --------------------*/
protected:


  /*---------- Begin Public Class Methods -----------------------*/
public:

		/* Class Constructors/Destructors */
	CSrArmaRecord();
	virtual void Destroy (void);

		/* Return a new instance of the class */
	static CSrRecord* Create (void) { return new CSrArmaRecord; }

		/* Get class members */
	srarmadnamdata_t& GetDnamData (void) { return m_pDnamData ? m_pDnamData->GetDnamData() : s_NullDnamData; } 
	srbodtdata_t&     GetBodtData (void) { return m_pBodtData ? m_pBodtData->GetBodtData() : s_NullBodtData; }

	bool          IsPlayable (void) { return !CheckFlagBits(GetBodtData().Flags, SR_BODT_FLAG_NONPLAYABLE); }  
	const char* GetBodyParts (void) { m_BodyPartsString = GetSrBodyPartFlagString(GetBodtData().BodyParts); return m_BodyPartsString.c_str(); }
	const char* GetArmorType (void) { return GetSrArmorTypeString(GetBodtData().ArmorType); }
	dword       GetRaceCount (void) { return CountSubrecords(SR_NAME_MODL); }

		/* Initialize a new record */
	void InitializeNew (void);

		/* Called to alert record of a new subrecord being added */
	virtual void OnAddSubrecord    (CSrSubrecord* pSubrecord);
	virtual void OnDeleteSubrecord (CSrSubrecord* pSubrecord);

		/* Set Class Methods */
	void SetIsPlayable  (const bool Flag)     { FlipFlagBits(GetBodtData().Flags, SR_BODT_FLAG_NONPLAYABLE, !Flag); }
	void SetBodyParts   (const char* pString) { GetSrBodyPartFlagValue(GetBodtData().BodyParts, pString); }
	void SetArmorType   (const char* pString) { GetSrArmorTypeValue(GetBodtData().ArmorType, pString); }
	
		/* Begin field method definitions */
	DECLARE_SRFIELD_METHOD(CSrArmaRecord, Type, GetArmorType, SetArmorType)
	DECLARE_SRFIELD_BOOL(CSrArmaRecord, Playable, IsPlayable, SetIsPlayable)
	DECLARE_SRFIELD_METHOD(CSrArmaRecord, BodyParts, GetBodyParts, SetBodyParts)

	DECLARE_SRFIELD_EDITORID1(CSrArmaRecord, Race, SR_NAME_RNAM)
	DECLARE_SRFIELD_EDITORID1(CSrArmaRecord, Footsteps, SR_NAME_SNDD)
	DECLARE_SRFIELD_EDITORID1(CSrArmaRecord, MaleTexture, SR_NAME_NAM0)
	DECLARE_SRFIELD_EDITORID1(CSrArmaRecord, FemaleTexture, SR_NAME_NAM1)
	DECLARE_SRFIELD_EDITORID1(CSrArmaRecord, Male1stTexture, SR_NAME_NAM2)
	DECLARE_SRFIELD_EDITORID1(CSrArmaRecord, Female1stTexture, SR_NAME_NAM3)

	DECLARE_SRFIELD_DWORDFLAG1(CSrArmaRecord, Unknown1, GetDnamData().Unknown1, GetDnamData().Unknown1)
	DECLARE_SRFIELD_DWORDFLAG1(CSrArmaRecord, Unknown2, GetDnamData().Unknown2, GetDnamData().Unknown2)
	DECLARE_SRFIELD_FLOAT1(CSrArmaRecord, Unknown3, GetDnamData().Unknown3, GetDnamData().Unknown3)
	DECLARE_SRFIELD_DWORD1(CSrArmaRecord, RaceCount, GetRaceCount(), dword Tmp)

	DECLARE_SRFIELD_STRING(CSrArmaRecord, m_pModel2, MaleModel, SR_NAME_MOD2)
	DECLARE_SRFIELD_STRING(CSrArmaRecord, m_pModel3, FemaleModel, SR_NAME_MOD3)	
	DECLARE_SRFIELD_STRING(CSrArmaRecord, m_pModel4, Male1stModel, SR_NAME_MOD4)
	DECLARE_SRFIELD_STRING(CSrArmaRecord, m_pModel5, Female1stModel, SR_NAME_MOD5)

};
/*===========================================================================
 *		End of Class CSrArmaRecord Definition
 *=========================================================================*/


#endif
/*===========================================================================
 *		End of File SrArmaRecord.H
 *=========================================================================*/

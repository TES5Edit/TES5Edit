/*===========================================================================
 *
 * File:		SrBookrecord.H
 * Author:		Dave Humphrey (dave@uesp.net)
 * Created On:	5 December 2011
 *
 * Defines the CSrBookRecord class.
 *
 *=========================================================================*/
#ifndef __SRBOOKRECORD_H
#define __SRBOOKRECORD_H


/*===========================================================================
 *
 * Begin Required Includes
 *
 *=========================================================================*/
	#include "sritem1record.h"
	#include "../subrecords/srbookdatasubrecord.h"
	#include "../subrecords/srlstringsubrecord.h"
	#include "../subrecords/srvmadsubrecord.h"
/*===========================================================================
 *		End of Required Includes
 *=========================================================================*/


/*===========================================================================
 *
 * Begin Class CSrBookRecord Definition
 *
 *=========================================================================*/
class CSrBookRecord : public CSrItem1Record 
{
  DECLARE_SRSUBRECCREATE()
  DECLARE_SRFIELDMAP()
  DECLARE_SRCLASS(CSrBookRecord, CSrItem1Record)

  /*---------- Begin Protected Class Members --------------------*/
protected:
	CSrSubrecord*			m_pBoundsData;
	CSrLStringSubrecord*	m_pDescription;
	CSrSubrecord*			m_pModtData;
	CSrBookDataSubrecord*	m_pBookData;
	CSrFormidSubrecord*		m_pStatic;
	CSrLStringSubrecord*	m_pCnamData;
	CSrFormidSubrecord*		m_pPickupSound;
	CSrVmadSubrecord*		m_pVmadData;

	static srbookdata_t s_NullBookData;


  /*---------- Begin Protected Class Methods --------------------*/
protected:


  /*---------- Begin Public Class Methods -----------------------*/
public:

		/* Class Constructors/Destructors */
	CSrBookRecord();
	virtual void Destroy (void);

			/* Return a new instance of the class */
	static CSrRecord* Create (void) { return new CSrBookRecord; }

		/* Get class members */
	srbookdata_t& GetBookData (void) { return m_pBookData ? m_pBookData->GetBookData() : s_NullBookData; }  
	bool IsBookSkill     (void) { return CheckFlagBits(GetBookData().Flags, SR_BOOKFLAG_SKILL); }
	bool IsBookSpellTome (void) { return CheckFlagBits(GetBookData().Flags, SR_BOOKFLAG_SPELLTOME); }
	bool IsBookScroll    (void) { return CheckFlagBits(GetBookData().Flags, SR_BOOKFLAG_SCROLL); }
	const char* GetBookSkill (void) { return IsBookSkill() ? GetSrSkillTypeString(GetBookData().SkillID) : NULL; }
	const char* GetBookSpell (void) { return IsBookSpellTome() ? CSrRecord::GetEditorIDHelper(GetBookData().SkillID) : NULL; }

		/* Initialize a new record */
	void InitializeNew (void);

		/* Called to alert record of a new subrecord being added */
	virtual void OnAddSubrecord    (CSrSubrecord* pSubrecord);
	virtual void OnDeleteSubrecord (CSrSubrecord* pSubrecord);

	void SetBookSkill     (const bool Flag) { FlipFlagBits(GetBookData().Flags, SR_BOOKFLAG_SKILL, Flag); }
	void SetBookSpellTome (const bool Flag) { FlipFlagBits(GetBookData().Flags, SR_BOOKFLAG_SPELLTOME, Flag); }
	void SetBookScroll    (const bool Flag) { FlipFlagBits(GetBookData().Flags, SR_BOOKFLAG_SCROLL, Flag); }
	void SetBookSkill	  (const char* pString) { if (IsBookSkill()) GetSrSkillTypeValue(GetBookData().SkillID, pString); }
	void SetBookSpell	  (const char* pString);
	

	DECLARE_SRFIELD_DESCRIPTION(CSrBookRecord, SR_NAME_DESC)
	DECLARE_SRFIELD_DWORD1(CSrBookRecord, Value, GetBookData().Value, GetBookData().Value)
	DECLARE_SRFIELD_FLOAT1(CSrBookRecord, Weight, GetBookData().Weight, GetBookData().Weight)
	DECLARE_SRFIELD_BOOL(CSrBookRecord, SpellTome, IsBookSpellTome, SetBookSpellTome)
	DECLARE_SRFIELD_BOOL(CSrBookRecord, Scroll, IsBookScroll, SetBookScroll)
	DECLARE_SRFIELD_BOOL(CSrBookRecord, SkillBook, IsBookSkill, SetBookSkill)
	DECLARE_SRFIELD_STRING(CSrBookRecord, m_pCnamData, CNam, SR_NAME_CNAM)
	DECLARE_SRFIELD_METHOD(CSrBookRecord, Skill, GetBookSkill, SetBookSkill)
		
	DECLARE_SRFIELD_EDITORID(CSrBookRecord, Spell, GetBookSpell, SetBookSpell)

	DECLARE_SRFIELD_EDITORID(CSrBookRecord, PickupSound, GetPickupSound, SetPickupSound)
	DECLARE_SRMETHOD_FORMID(PickupSound, m_pPickupSound, SR_NAME_YNAM)

	DECLARE_SRFIELD_EDITORID(CSrBookRecord, Static,  GetStatic,  SetStatic)
	DECLARE_SRMETHOD_FORMID(Static, m_pStatic, SR_NAME_INAM)

};
/*===========================================================================
 *		End of Class CSrBookRecord Definition
 *=========================================================================*/


#endif
/*===========================================================================
 *		End of File SrBookRecord.H
 *=========================================================================*/

/*===========================================================================
 *
 * File:		SrShourecord.H
 * Author:		Dave Humphrey (dave@uesp.net)
 * Created On:	5 December 2011
 *
 * Defines the CSrShouRecord class.
 *
 *=========================================================================*/
#ifndef __SRSHOURECORD_H
#define __SRSHOURECORD_H


/*===========================================================================
 *
 * Begin Required Includes
 *
 *=========================================================================*/
	#include "sridrecord.h"
	#include "../subrecords/srlstringsubrecord.h"
	#include "../subrecords/srformidsubrecord.h"
	#include "../subrecords/srshousnamsubrecord.h"
/*===========================================================================
 *		End of Required Includes
 *=========================================================================*/


/*===========================================================================
 *
 * Begin Class CSrShouRecord Definition
 *
 *=========================================================================*/
class CSrShouRecord : public CSrIdRecord 
{
	DECLARE_SRSUBRECCREATE()
	DECLARE_SRFIELDMAP()
	DECLARE_SRCLASS(CSrShouRecord, CSrIdRecord)

  /*---------- Begin Protected Class Members --------------------*/
protected:
	CSrShouSnamSubrecord*	m_pShoutData1;
	CSrShouSnamSubrecord*	m_pShoutData2;
	CSrShouSnamSubrecord*	m_pShoutData3;
	CSrLStringSubrecord*	m_pDescription;
	CSrLStringSubrecord*	m_pItemName;
	CSrFormidSubrecord*		m_pStatic;

	static srshousnamdata_t s_NullShoutData;


  /*---------- Begin Protected Class Methods --------------------*/
protected:


  /*---------- Begin Public Class Methods -----------------------*/
public:

		/* Class Constructors/Destructors */
	CSrShouRecord();
	virtual void Destroy (void);

    	/* Return a new instance of the class */
	static CSrRecord* Create (void) { return new CSrShouRecord; }

		/* Get class members */
	srshousnamdata_t& GetShoutData (const int Index) 
	{ 
		if (Index == 0 && m_pShoutData1 != NULL) return m_pShoutData1->GetShoutData();
		if (Index == 1 && m_pShoutData2 != NULL) return m_pShoutData2->GetShoutData();
		if (Index == 2 && m_pShoutData3 != NULL) return m_pShoutData3->GetShoutData();
		return s_NullShoutData;
	}  

		/* Initialize a new record */
	void InitializeNew (void);

		/* Called to alert record of a new subrecord being added */
	virtual void OnAddSubrecord    (CSrSubrecord* pSubrecord);
	virtual void OnDeleteSubrecord (CSrSubrecord* pSubrecord);

	void ForceValidSnamCount (void);
	
		/* Begin field method definitions */
	DECLARE_SRFIELD_DESCRIPTION(CSrShouRecord, SR_NAME_DESC)
	DECLARE_SRFIELD_ITEMNAME(CSrShouRecord)
	DECLARE_SRFIELD_EDITORID1(CSrShouRecord, Static, SR_NAME_MDOB)

	DECLARE_SRFIELD_FLOAT1(CSrShouRecord, Recharge1, GetShoutData(0).RechargeTime, GetShoutData(0).RechargeTime)
	DECLARE_SRFIELD_FLOAT1(CSrShouRecord, Recharge2, GetShoutData(1).RechargeTime, GetShoutData(1).RechargeTime)
	DECLARE_SRFIELD_FLOAT1(CSrShouRecord, Recharge3, GetShoutData(2).RechargeTime, GetShoutData(2).RechargeTime)

	DECLARE_SRMETHOD_FORMID1(PowerWord1, GetShoutData(0).WordofPowerID)
	DECLARE_SRMETHOD_FORMID1(PowerWord2, GetShoutData(1).WordofPowerID)
	DECLARE_SRMETHOD_FORMID1(PowerWord3, GetShoutData(2).WordofPowerID)

	DECLARE_SRMETHOD_FORMID1(Spell1, GetShoutData(0).SpellID)
	DECLARE_SRMETHOD_FORMID1(Spell2, GetShoutData(1).SpellID)
	DECLARE_SRMETHOD_FORMID1(Spell3, GetShoutData(2).SpellID)

	DECLARE_SRFIELD_EDITORID(CSrShouRecord, PowerWord1, GetPowerWord1, SetPowerWord1)
	DECLARE_SRFIELD_EDITORID(CSrShouRecord, PowerWord2, GetPowerWord2, SetPowerWord2)
	DECLARE_SRFIELD_EDITORID(CSrShouRecord, PowerWord3, GetPowerWord3, SetPowerWord3)

	DECLARE_SRFIELD_EDITORID(CSrShouRecord, Spell1, GetSpell1, SetSpell1)
	DECLARE_SRFIELD_EDITORID(CSrShouRecord, Spell2, GetSpell2, SetSpell2)
	DECLARE_SRFIELD_EDITORID(CSrShouRecord, Spell3, GetSpell3, SetSpell3)



};
/*===========================================================================
 *		End of Class CSrShouRecord Definition
 *=========================================================================*/


#endif
/*===========================================================================
 *		End of File SrShouRecord.H
 *=========================================================================*/

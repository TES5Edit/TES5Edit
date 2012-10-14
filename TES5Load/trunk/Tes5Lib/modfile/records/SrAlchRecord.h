/*===========================================================================
 *
 * File:		SrAlchrecord.H
 * Author:		Dave Humphrey (dave@uesp.net)
 * Created On:	5 December 2011
 *
 * Defines the CSrAlchRecord class.
 *
 *=========================================================================*/
#ifndef __SRALCHRECORD_H
#define __SRALCHRECORD_H


/*===========================================================================
 *
 * Begin Required Includes
 *
 *=========================================================================*/
	#include "sritem1record.h"
	#include "../subrecords/srenitalchsubrecord.h"
	#include "../subrecords/srefitsubrecord.h"
	#include "../subrecords/sralchdatasubrecord.h"
	#include "../subrecords/srctdasubrecord.h"
/*===========================================================================
 *		End of Required Includes
 *=========================================================================*/


/*===========================================================================
 *
 * Begin Class CSrAlchRecord Definition
 *
 *=========================================================================*/
class CSrAlchRecord : public CSrItem1Record 
{
	DECLARE_SRSUBRECCREATE()
	DECLARE_SRFIELDMAP()
	DECLARE_SRCLASS(CSrAlchRecord, CSrItem1Record)

  /*---------- Begin Protected Class Members --------------------*/
protected:
	CSrStringSubrecord*		m_pMessageIcon;
	CSrEnitAlchSubrecord*	m_pEnitData;
	CSrAlchDataSubrecord*	m_pAlchData;
	CSrFormidSubrecord*		m_pPickupSound;
	CSrFormidSubrecord*		m_pDropSound;
	CSrFormidSubrecord*		m_pEquipType;

	static sralchdata_t     s_NullAlchData;
	static srenitalchdata_t s_NullAlchEnitData;


  /*---------- Begin Protected Class Methods --------------------*/
protected:


  /*---------- Begin Public Class Methods -----------------------*/
public:

		/* Class Constructors/Destructors */
	CSrAlchRecord();
	virtual void Destroy (void);

    	/* Return a new instance of the class */
	static CSrRecord* Create (void) { return new CSrAlchRecord; }

		/* Get class members */
	sralchdata_t&     GetAlchData (void) { return m_pAlchData ? m_pAlchData->GetAlchData() : s_NullAlchData; }
	srenitalchdata_t& GetEnitData (void) { return m_pEnitData ? m_pEnitData->GetAlchData() : s_NullAlchEnitData; }
	bool			  IsAutoCalc  (void) { return m_pEnitData ? m_pEnitData->IsAutoCalc() : false; }
	bool			  IsFood      (void) { return m_pEnitData ? m_pEnitData->IsFood()     : false; }
	bool			  IsMedicine  (void) { return m_pEnitData ? m_pEnitData->IsMedicine() : false; }
	bool			  IsPoison    (void) { return m_pEnitData ? m_pEnitData->IsPoison()   : false; }

	dword GetEffectCount (void) { return CountSubrecords(SR_NAME_EFID); }  

		/* Initialize a new record */
	void InitializeNew (void);

		/* Called to alert record of a new subrecord being added */
	virtual void OnAddSubrecord    (CSrSubrecord* pSubrecord);
	virtual void OnDeleteSubrecord (CSrSubrecord* pSubrecord);

		/* Set class members */
	void SetAutoCalc (const bool Flag) { if (m_pEnitData) m_pEnitData->SetAutoCalc(Flag); }
	void SetMedicine (const bool Flag) { if (m_pEnitData) m_pEnitData->SetMedicine(Flag); }
	void SetFood     (const bool Flag) { if (m_pEnitData) m_pEnitData->SetFood(Flag); }
	void SetPoison   (const bool Flag) { if (m_pEnitData) m_pEnitData->SetPoison(Flag); }

	DECLARE_SRFIELD_EDITORID2(CSrAlchRecord, Addiction, GetEnitData().AddictionID)
	DECLARE_SRFIELD_EDITORID2(CSrAlchRecord, UseSound, GetEnitData().UseSoundID)
	DECLARE_SRFIELD_EDITORID1(CSrAlchRecord, DropSound, SR_NAME_ZNAM)
	DECLARE_SRFIELD_EDITORID1(CSrAlchRecord, EquipType, SR_NAME_ETYP)
	DECLARE_SRFIELD_EDITORID1(CSrAlchRecord, PickupSound, SR_NAME_YNAM)

	DECLARE_SRFIELD_STRING(CSrAlchRecord, m_pMessageIcon, MessageIcon, SR_NAME_MICO)

	DECLARE_SRFIELD_DWORDFLAG1(CSrAlchRecord, MagicFlags, GetEnitData().Flags, GetEnitData().Flags)
	DECLARE_SRFIELD_DWORD1(CSrAlchRecord, Value, GetEnitData().Value, GetEnitData().Value)
	DECLARE_SRFIELD_DWORD1(CSrAlchRecord, AddictionChance, GetEnitData().AddictionChance, GetEnitData().AddictionChance)
	DECLARE_SRFIELD_FLOAT1(CSrAlchRecord, Weight, GetAlchData().Weight, GetAlchData().Weight)

	DECLARE_SRFIELD_BOOL(CSrAlchRecord, AutoCalc, IsAutoCalc, SetAutoCalc)
	DECLARE_SRFIELD_BOOL(CSrAlchRecord, Food,     IsFood,     SetFood)
	DECLARE_SRFIELD_BOOL(CSrAlchRecord, Medicine, IsMedicine, SetMedicine)
	DECLARE_SRFIELD_BOOL(CSrAlchRecord, Poison,   IsPoison,   SetPoison)

	DECLARE_SRFIELD_DWORD1(CSrAlchRecord, EffectCount, GetEffectCount(), dword Tmp);

};
/*===========================================================================
 *		End of Class CSrAlchRecord Definition
 *=========================================================================*/


#endif
/*===========================================================================
 *		End of File SrAlchRecord.H
 *=========================================================================*/



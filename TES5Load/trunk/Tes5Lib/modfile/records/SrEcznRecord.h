/*===========================================================================
 *
 * File:		SrEcznrecord.H
 * Author:		Dave Humphrey (dave@uesp.net)
 * Created On:	5 December 2011
 *
 * Defines the CSrEcznRecord class.
 *
 *=========================================================================*/
#ifndef __SRECZNRECORD_H
#define __SRECZNRECORD_H


/*===========================================================================
 *
 * Begin Required Includes
 *
 *=========================================================================*/
	#include "sridrecord.h"
	#include "../subrecords/sreczndatasubrecord.h"
/*===========================================================================
 *		End of Required Includes
 *=========================================================================*/


/*===========================================================================
 *
 * Begin Class CSrEcznRecord Definition
 *
 *=========================================================================*/
class CSrEcznRecord : public CSrIdRecord 
{
	DECLARE_SRSUBRECCREATE()
	DECLARE_SRFIELDMAP()
	DECLARE_SRCLASS(CSrEcznRecord, CSrIdRecord)

  /*---------- Begin Protected Class Members --------------------*/
protected:
	CSrEcznDataSubrecord*		m_pEncounterData;

	static sreczndata_t s_NullEncounterData;


  /*---------- Begin Protected Class Methods --------------------*/
protected:


  /*---------- Begin Public Class Methods -----------------------*/
public:

		/* Class Constructors/Destructors */
	CSrEcznRecord();
	virtual void Destroy (void);

    	/* Return a new instance of the class */
	static CSrRecord* Create (void) { return new CSrEcznRecord; }

		/* Get class members */
	sreczndata_t& GetEncounterData (void) { return m_pEncounterData ? m_pEncounterData->GetEncounterData() : s_NullEncounterData; }
	bool		  GetZoneReset     (void) { return CheckFlagBits(GetEncounterData().Flags, SR_ENCOUNTERFLAG_RESET); }
	bool		  GetZoneUnknown1  (void) { return CheckFlagBits(GetEncounterData().Flags, SR_ENCOUNTERFLAG_UNKNOWN1); }
	bool		  GetZoneUnknown2  (void) { return CheckFlagBits(GetEncounterData().Flags, SR_ENCOUNTERFLAG_UNKNOWN2); }

		/* Initialize a new record */
	void InitializeNew (void);

		/* Called to alert record of a new subrecord being added */
	virtual void OnAddSubrecord    (CSrSubrecord* pSubrecord);
	virtual void OnDeleteSubrecord (CSrSubrecord* pSubrecord);

	void SetZoneReset     (const bool Flag) { FlipFlagBits(GetEncounterData().Flags, SR_ENCOUNTERFLAG_RESET, Flag); }
	void SetZoneUnknown1  (const bool Flag) { FlipFlagBits(GetEncounterData().Flags, SR_ENCOUNTERFLAG_UNKNOWN1, Flag); }
	void SetZoneUnknown2  (const bool Flag) { FlipFlagBits(GetEncounterData().Flags, SR_ENCOUNTERFLAG_UNKNOWN2, Flag); }

		/* Begin field method definitions */
	DECLARE_SRFIELD_EDITORID(CSrEcznRecord, Faction, GetFaction, SetFaction)
	DECLARE_SRMETHOD_FORMID1(Faction, GetEncounterData().FactionID)

	DECLARE_SRFIELD_EDITORID(CSrEcznRecord, Location, GetLocation, SetLocation)
	DECLARE_SRMETHOD_FORMID1(Location, GetEncounterData().LocationID)

	DECLARE_SRFIELD_BYTE1(CSrEcznRecord, Rank, GetEncounterData().Rank, GetEncounterData().Rank)
	DECLARE_SRFIELD_BYTE1(CSrEcznRecord, MinLevel, GetEncounterData().MinLevel, GetEncounterData().MinLevel)
	DECLARE_SRFIELD_BYTE1(CSrEcznRecord, Unknown3, GetEncounterData().Unknown, GetEncounterData().Unknown)

	DECLARE_SRFIELD_BOOL(CSrEcznRecord, Reset, GetZoneReset, SetZoneReset)
	DECLARE_SRFIELD_BOOL(CSrEcznRecord, Unknown1, GetZoneUnknown1, SetZoneUnknown1)
	DECLARE_SRFIELD_BOOL(CSrEcznRecord, Unknown2, GetZoneUnknown2, SetZoneUnknown2)

};
/*===========================================================================
 *		End of Class CSrEcznRecord Definition
 *=========================================================================*/


#endif
/*===========================================================================
 *		End of File SrEcznRecord.H
 *=========================================================================*/

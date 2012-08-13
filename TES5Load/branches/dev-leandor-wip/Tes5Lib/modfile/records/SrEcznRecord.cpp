/*===========================================================================
 *
 * File:		SrEcznRecord.CPP
 * Author:		Dave Humphrey (dave@uesp.net)
 * Created On:	5 December 2011
 *
 * Description
 *
 *=========================================================================*/

	/* Include Files */
#include "srEcznrecord.h"


sreczndata_t CSrEcznRecord::s_NullEncounterData;


/*===========================================================================
 *
 * Begin Subrecord Creation Array
 *
 *=========================================================================*/
BEGIN_SRSUBRECCREATE(CSrEcznRecord, CSrIdRecord)
	DEFINE_SRSUBRECCREATE(SR_NAME_DATA, CSrEcznDataSubrecord::Create)
END_SRSUBRECCREATE()
/*===========================================================================
 *		End of Subrecord Creation Array
 *=========================================================================*/


/*===========================================================================
 *
 * Begin CSrRecord Field Map
 *
 *=========================================================================*/
BEGIN_SRFIELDMAP(CSrEcznRecord, CSrIdRecord)
	ADD_SRFIELDALL("Faction",		SR_FIELD_FACTION,	0, CSrEcznRecord, FieldFaction)
	ADD_SRFIELDALL("Location",		SR_FIELD_LOCATION,	0, CSrEcznRecord, FieldLocation)
	ADD_SRFIELDALL("Rank",			SR_FIELD_RANK,		0, CSrEcznRecord, FieldRank)
	ADD_SRFIELDALL("MinLevel",		SR_FIELD_MINLEVEL,	0, CSrEcznRecord, FieldMinLevel)
	ADD_SRFIELDALL("Reset",			SR_FIELD_RESET,		0, CSrEcznRecord, FieldReset)
	ADD_SRFIELDALL("Unknown1",		SR_FIELD_UNKNOWN1,	0, CSrEcznRecord, FieldUnknown1)
	ADD_SRFIELDALL("Unknown2",		SR_FIELD_UNKNOWN2,	0, CSrEcznRecord, FieldUnknown2)
	ADD_SRFIELDALL("Unknown3",		SR_FIELD_UNKNOWN3,	0, CSrEcznRecord, FieldUnknown3)
END_SRFIELDMAP()
/*===========================================================================
 *		End of CObRecord Field Map
 *=========================================================================*/


/*===========================================================================
 *
 * Class CSrEcznRecord Constructor
 *
 *=========================================================================*/
CSrEcznRecord::CSrEcznRecord () 
{
	m_pEncounterData = NULL;
}
/*===========================================================================
 *		End of Class CSrEcznRecord Constructor
 *=========================================================================*/


/*===========================================================================
 *
 * Class CSrEcznRecord Method - void Destroy (void);
 *
 *=========================================================================*/
void CSrEcznRecord::Destroy (void) 
{
	m_pEncounterData = NULL;

	CSrIdRecord::Destroy();
}
/*===========================================================================
 *		End of Class Method CSrEcznRecord::Destroy()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CSrEcznRecord Method - void InitializeNew (void);
 *
 *=========================================================================*/
void CSrEcznRecord::InitializeNew (void) 
{
	CSrIdRecord::InitializeNew();

	AddNewSubrecord(SR_NAME_DATA);
	if (m_pEncounterData != NULL) m_pEncounterData->InitializeNew();
}
/*===========================================================================
 *		End of Class Method CSrEcznRecord::InitializeNew()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CSrEcznRecord Event - void OnAddSubrecord (pSubrecord);
 *
 *=========================================================================*/
void CSrEcznRecord::OnAddSubrecord (CSrSubrecord* pSubrecord) {

	if (pSubrecord->GetRecordType() == SR_NAME_DATA)
	{
		m_pEncounterData = SrCastClass(CSrEcznDataSubrecord, pSubrecord);
	}
	else
	{
		CSrIdRecord::OnAddSubrecord(pSubrecord);
	}

}
/*===========================================================================
 *		End of Class Event CSrEcznRecord::OnAddSubRecord()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CSrEcznRecord Event - void OnDeleteSubrecord (pSubrecord);
 *
 *=========================================================================*/
void CSrEcznRecord::OnDeleteSubrecord (CSrSubrecord* pSubrecord) {

	if (m_pEncounterData == pSubrecord)
		m_pEncounterData = NULL;
	else
		CSrIdRecord::OnDeleteSubrecord(pSubrecord);

}
/*===========================================================================
 *		End of Class Event CSrEcznRecord::OnDeleteSubrecord()
 *=========================================================================*/


/*===========================================================================
 *
 * Begin CSrEcznRecord Get Field Methods
 *
 *=========================================================================*/
/*===========================================================================
 *		End of CSrEcznRecord Get Field Methods
 *=========================================================================*/


/*===========================================================================
 *
 * Begin CSrEcznRecord Compare Field Methods
 *
 *=========================================================================*/
/*===========================================================================
 *		End of CSrEcznRecord Compare Field Methods
 *=========================================================================*/


/*===========================================================================
 *
 * Begin CSrEcznRecord Set Field Methods
 *
 *=========================================================================*/
/*===========================================================================
 *		End of CSrEcznRecord Set Field Methods
 *=========================================================================*/

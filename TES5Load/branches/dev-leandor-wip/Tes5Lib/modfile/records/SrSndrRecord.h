/*===========================================================================
 *
 * File:		SrSndrrecord.H
 * Author:		Dave Humphrey (dave@uesp.net)
 * Created On:	5 December 2011
 *
 * Defines the CSrSndrRecord class.
 *
 *=========================================================================*/
#ifndef __SRSNDRRECORD_H
#define __SRSNDRRECORD_H


/*===========================================================================
 *
 * Begin Required Includes
 *
 *=========================================================================*/
	#include "sridrecord.h"
	#include "../subrecords/srsndrbnamsubrecord.h"
	#include "../subrecords/srctdasubrecord.h"
/*===========================================================================
 *		End of Required Includes
 *=========================================================================*/


/*===========================================================================
 *
 * Begin Class CSrSndrRecord Definition
 *
 *=========================================================================*/
class CSrSndrRecord : public CSrIdRecord 
{
	DECLARE_SRSUBRECCREATE()
	DECLARE_SRFIELDMAP()
	DECLARE_SRCLASS(CSrSndrRecord, CSrIdRecord)

  /*---------- Begin Protected Class Members --------------------*/
protected:
  	CSrDwordSubrecord*		m_pFnamData;
	CSrFormidSubrecord*		m_pSound;
	CSrDwordSubrecord*		m_pCnamData;
	CSrFormidSubrecord*		m_pOutputMarker;
	CSrFormidSubrecord*		m_pCategory;
	CSrDwordSubrecord*		m_pFlags;
	CSrSndrBnamSubrecord*	m_pSndrData;

	static srsndrbnamdata_t s_NullBnamData;


  /*---------- Begin Protected Class Methods --------------------*/
protected:


  /*---------- Begin Public Class Methods -----------------------*/
public:

		/* Class Constructors/Destructors */
	CSrSndrRecord();
	virtual void Destroy (void);

	CSrStringSubrecord* AddSoundFile (const char* pFilename);

    	/* Return a new instance of the class */
	static CSrRecord* Create (void) { return new CSrSndrRecord; }

		/* Get class members */
	dword GetSoundFileCount (void) { return CountSubrecords(SR_NAME_ANAM); }
	dword GetConditionCount (void) { return CountSubrecords(SR_NAME_CTDA); }

	srsndrbnamdata_t& GetBnamData (void) { return m_pSndrData ? m_pSndrData->GetSndrData() : s_NullBnamData; }

		/* Initialize a new record */
	void InitializeNew (void);

		/* Called to alert record of a new subrecord being added */
	virtual void OnAddSubrecord    (CSrSubrecord* pSubrecord);
	virtual void OnDeleteSubrecord (CSrSubrecord* pSubrecord);


		/* Begin field method definitions */
	DECLARE_SRFIELD_EDITORID1(CSrSndrRecord, Sound, SR_NAME_SNAM)
	DECLARE_SRFIELD_EDITORID1(CSrSndrRecord, OutputMarker, SR_NAME_ONAM)
	DECLARE_SRFIELD_EDITORID1(CSrSndrRecord, Category, SR_NAME_GNAM)

	DECLARE_SRFIELD_DWORD1(CSrSndrRecord, SoundFileCount, GetSoundFileCount(), dword Tmp)
	DECLARE_SRFIELD_DWORD1(CSrSndrRecord, ConditionCount, GetConditionCount(), dword Tmp)

	DECLARE_SRFIELD_WORD1(CSrSndrRecord, Unknown1, GetBnamData().Unknown1, GetBnamData().Unknown1)
	DECLARE_SRFIELD_WORD1(CSrSndrRecord, Unknown2, GetBnamData().Unknown2, GetBnamData().Unknown2)
	DECLARE_SRFIELD_WORD1(CSrSndrRecord, Unknown3, GetBnamData().Unknown3, GetBnamData().Unknown3)

	DECLARE_SRFIELD_METHODDWORDF(CSrSndrRecord, m_pCnamData, CName, SR_NAME_CNAM, "0x%08X")
	DECLARE_SRFIELD_METHODDWORD(CSrSndrRecord, m_pFnamData, FName, SR_NAME_FNAM)
	DECLARE_SRFIELD_METHODDWORDF(CSrSndrRecord, m_pFlags, SoundFlags, SR_NAME_LNAM, "0x%08X")

};
/*===========================================================================
 *		End of Class CSrSndrRecord Definition
 *=========================================================================*/


#endif
/*===========================================================================
 *		End of File SrSndrRecord.H
 *=========================================================================*/

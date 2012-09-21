/*===========================================================================
 *
 * File:		SrSounrecord.H
 * Author:		Dave Humphrey (dave@uesp.net)
 * Created On:	5 December 2011
 *
 * Defines the CSrSounRecord class.
 *
 *=========================================================================*/
#ifndef __SRSOUNRECORD_H
#define __SRSOUNRECORD_H


/*===========================================================================
 *
 * Begin Required Includes
 *
 *=========================================================================*/
	#include "sridrecord.h"
	#include "../subrecords/srsndddatasubrecord.h"
/*===========================================================================
 *		End of Required Includes
 *=========================================================================*/


/*===========================================================================
 *
 * Begin Class CSrSounRecord Definition
 *
 *=========================================================================*/
class CSrSounRecord : public CSrIdRecord 
{
	DECLARE_SRSUBRECCREATE()
	DECLARE_SRFIELDMAP()
	DECLARE_SRCLASS(CSrSounRecord, CSrIdRecord)

  /*---------- Begin Protected Class Members --------------------*/
protected:
  	CSrStringSubrecord*		m_pSoundFile;
	CSrFormidSubrecord*		m_pSoundRef;
	CSrSnddDataSubrecord*	m_pSoundData;

	static srsndddata_t s_NullSnddData;


  /*---------- Begin Protected Class Methods --------------------*/
protected:


  /*---------- Begin Public Class Methods -----------------------*/
public:

		/* Class Constructors/Destructors */
	CSrSounRecord();
	virtual void Destroy (void);

    	/* Return a new instance of the class */
	static CSrRecord* Create (void) { return new CSrSounRecord; }

		/* Get class members */
	srsndddata_t& GetSoundData (void) { return m_pSoundData ? m_pSoundData->GetSnddData() : s_NullSnddData; }

		/* Initialize a new record */
	void InitializeNew (void);

		/* Called to alert record of a new subrecord being added */
	virtual void OnAddSubrecord    (CSrSubrecord* pSubrecord);
	virtual void OnDeleteSubrecord (CSrSubrecord* pSubrecord);


		/* Begin field method definitions */
	DECLARE_SRFIELD_EDITORID1(CSrSounRecord, SoundRef, SR_NAME_SDSC)
	DECLARE_SRFIELD_STRING(CSrSounRecord, m_pSoundFile, SoundFile, SR_NAME_FNAM)

	DECLARE_SRFIELD_DWORDFLAG1(CSrSounRecord, Unknown1, GetSoundData().Unknown1, GetSoundData().Unknown1)
	DECLARE_SRFIELD_DWORD1(CSrSounRecord, Unknown2, GetSoundData().Unknown2, GetSoundData().Unknown2)
	DECLARE_SRFIELD_DWORD1(CSrSounRecord, Unknown3, GetSoundData().Unknown3, GetSoundData().Unknown3)
	DECLARE_SRFIELD_WORD1(CSrSounRecord, Unknown4, GetSoundData().Unknown4, GetSoundData().Unknown4)
	DECLARE_SRFIELD_WORD1(CSrSounRecord, Unknown5, GetSoundData().Unknown5, GetSoundData().Unknown5)
	DECLARE_SRFIELD_WORD1(CSrSounRecord, Unknown6, GetSoundData().Unknown6, GetSoundData().Unknown6)
	DECLARE_SRFIELD_WORD1(CSrSounRecord, Unknown7, GetSoundData().Unknown7, GetSoundData().Unknown7)
	DECLARE_SRFIELD_WORD1(CSrSounRecord, Unknown8, GetSoundData().Unknown8, GetSoundData().Unknown8)
	DECLARE_SRFIELD_WORD1(CSrSounRecord, Unknown9, GetSoundData().Unknown9, GetSoundData().Unknown9)
	DECLARE_SRFIELD_DWORD1(CSrSounRecord, Unknown10, GetSoundData().Unknown10, GetSoundData().Unknown10)
	DECLARE_SRFIELD_DWORD1(CSrSounRecord, Unknown11, GetSoundData().Unknown11, GetSoundData().Unknown11)
	DECLARE_SRFIELD_DWORD1(CSrSounRecord, Unknown12, GetSoundData().Unknown12, GetSoundData().Unknown12)

};
/*===========================================================================
 *		End of Class CSrSounRecord Definition
 *=========================================================================*/


#endif
/*===========================================================================
 *		End of File SrSounRecord.H
 *=========================================================================*/

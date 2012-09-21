/*===========================================================================
 *
 * File:		SrSlgmrecord.H
 * Author:		Dave Humphrey (dave@uesp.net)
 * Created On:	5 December 2011
 *
 * Defines the CSrSlgmRecord class.
 *
 *=========================================================================*/
#ifndef __SRSLGMRECORD_H
#define __SRSLGMRECORD_H


/*===========================================================================
 *
 * Begin Required Includes
 *
 *=========================================================================*/
	#include "sritem1record.h"
	#include "../subrecords/srbytesubrecord.h"
	#include "../subrecords/srslgmdatasubrecord.h"
/*===========================================================================
 *		End of Required Includes
 *=========================================================================*/


/*===========================================================================
 *
 * Begin Class CSrSlgmRecord Definition
 *
 *=========================================================================*/
class CSrSlgmRecord : public CSrItem1Record 
{
	DECLARE_SRSUBRECCREATE()
	DECLARE_SRFIELDMAP()
	DECLARE_SRCLASS(CSrSlgmRecord, CSrItem1Record)

  /*---------- Begin Protected Class Members --------------------*/
protected:
	CSrByteSubrecord*		m_pCurrentSoul;
	CSrSlgmDataSubrecord*	m_pSlgmData;
	CSrByteSubrecord*		m_pCapacity;
	CSrFormidSubrecord*		m_pFilledGem;

	static srslgmdata_t s_NullSlgmData;


  /*---------- Begin Protected Class Methods --------------------*/
protected:


  /*---------- Begin Public Class Methods -----------------------*/
public:

		/* Class Constructors/Destructors */
	CSrSlgmRecord();
	virtual void Destroy (void);

    	/* Return a new instance of the class */
	static CSrRecord* Create (void) { return new CSrSlgmRecord; }

		/* Get class members */
	srslgmdata_t& GetSlgmData (void) { return m_pSlgmData ? m_pSlgmData->GetSlgmData() : s_NullSlgmData; }  
	const char* GetCapacity    (void) { return GetSrSoulGemTypeString(GetCapacityRaw()); }
	const char* GetCurrentSoul (void) { return GetSrSoulGemTypeString(GetCurrentSoulRaw()); }

		/* Initialize a new record */
	void InitializeNew (void);

		/* Called to alert record of a new subrecord being added */
	virtual void OnAddSubrecord    (CSrSubrecord* pSubrecord);
	virtual void OnDeleteSubrecord (CSrSubrecord* pSubrecord);

		/* Set class members */
	void SetCapacity    (const char* pString) { int Value(0); if (GetSrSoulGemTypeValue(Value, pString)) SetCapacityRaw((byte) Value); }
	void SetCurrentSoul (const char* pString) { int Value(0); if (GetSrSoulGemTypeValue(Value, pString)) SetCurrentSoulRaw((byte) Value); }


		/* Begin field method definitions */
	DECLARE_SRFIELD_DWORD1(CSrSlgmRecord, Value, GetSlgmData().Value, GetSlgmData().Value)
	DECLARE_SRFIELD_FLOAT1(CSrSlgmRecord, Weight, GetSlgmData().Weight, GetSlgmData().Weight)
	DECLARE_SRFIELD_METHOD(CSrSlgmRecord, Capacity, GetCapacity, SetCapacity)
	DECLARE_SRFIELD_METHOD(CSrSlgmRecord, CurrentSoul, GetCurrentSoul, SetCurrentSoul)

	DECLARE_SRFIELD_METHODDBYTE(CSrSlgmRecord, m_pCapacity, CapacityRaw, SR_NAME_SLCP)
	DECLARE_SRFIELD_METHODDBYTE(CSrSlgmRecord, m_pCurrentSoul, CurrentSoulRaw, SR_NAME_SOUL)

	DECLARE_SRFIELD_EDITORID1(CSrSlgmRecord, FilledGem, SR_NAME_NAM0)

};
/*===========================================================================
 *		End of Class CSrSlgmRecord Definition
 *=========================================================================*/


#endif
/*===========================================================================
 *		End of File SrSlgmRecord.H
 *=========================================================================*/

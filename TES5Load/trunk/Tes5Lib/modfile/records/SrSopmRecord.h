/*===========================================================================
 *
 * File:		SrSopmrecord.H
 * Author:		Dave Humphrey (dave@uesp.net)
 * Created On:	5 December 2011
 *
 * Defines the CSrSopmRecord class.
 *
 *=========================================================================*/
#ifndef __SRSOPMRECORD_H
#define __SRSOPMRECORD_H


/*===========================================================================
 *
 * Begin Required Includes
 *
 *=========================================================================*/
	#include "sridrecord.h"
	#include "../subrecords/srsopmanamsubrecord.h"
	#include "../subrecords/srsopmsnamsubrecord.h"
	#include "../subrecords/srsopmonamsubrecord.h"
/*===========================================================================
 *		End of Required Includes
 *=========================================================================*/


/*===========================================================================
 *
 * Begin Class CSrSopmRecord Definition
 *
 *=========================================================================*/
class CSrSopmRecord : public CSrIdRecord 
{
	DECLARE_SRSUBRECCREATE()
	DECLARE_SRFIELDMAP()
	DECLARE_SRCLASS(CSrSopmRecord, CSrIdRecord)

  /*---------- Begin Protected Class Members --------------------*/
protected:
  	CSrDwordSubrecord*		m_pFlags;
	CSrDwordSubrecord*		m_pNam1Data;
	CSrDwordSubrecord*		m_pMnamData;
	CSrSopmAnamSubrecord*	m_pAnamData;
	CSrSopmOnamSubrecord*	m_pOnamData;
	CSrSopmSnamSubrecord*	m_pSnamData;
	CSrDwordSubrecord*		m_pCnamData;


  /*---------- Begin Protected Class Methods --------------------*/
protected:


  /*---------- Begin Public Class Methods -----------------------*/
public:

		/* Class Constructors/Destructors */
	CSrSopmRecord();
	virtual void Destroy (void);

    	/* Return a new instance of the class */
	static CSrRecord* Create (void) { return new CSrSopmRecord; }

		/* Get class members */
	int GetContentType (void);

	srsopmanamdata_t* GetAnamData (void) { return m_pAnamData ? &m_pAnamData->GetSopmData() : NULL; }
	srsopmonamdata_t* GetOnamData (void) { return m_pOnamData ? &m_pOnamData->GetSopmData() : NULL; }
	srsopmsnamdata_t* GetSnamData (void) { return m_pSnamData ? &m_pSnamData->GetSopmData() : NULL; }  

		/* Initialize a new record */
	void InitializeNew (void);

		/* Called to alert record of a new subrecord being added */
	virtual void OnAddSubrecord    (CSrSubrecord* pSubrecord);
	virtual void OnDeleteSubrecord (CSrSubrecord* pSubrecord);

	void SetContentType (const int Type);

	void SetAnamData (const srsopmanamdata_t Data) { if (m_pAnamData) m_pAnamData->GetSopmData() = Data; }
	void SetOnamData (const srsopmonamdata_t Data) { if (m_pOnamData) m_pOnamData->GetSopmData() = Data; }
	void SetSnamData (const srsopmsnamdata_t Data) { if (m_pSnamData) m_pSnamData->GetSopmData() = Data; }  

		/* Begin field method definitions */
	DECLARE_SRFIELD_METHODDWORDF(CSrSopmRecord, m_pFlags, SoundFlags, SR_NAME_FNAM, "0x%08X")
	DECLARE_SRFIELD_METHODDWORDF(CSrSopmRecord, m_pNam1Data, Unknown1, SR_NAME_NAM1, "0x%08X")
	DECLARE_SRFIELD_METHODDWORD(CSrSopmRecord, m_pMnamData, Unknown2, SR_NAME_MNAM)
	DECLARE_SRFIELD_METHODDWORD(CSrSopmRecord, m_pCnamData, Unknown3, SR_NAME_CNAM)

};
/*===========================================================================
 *		End of Class CSrSopmRecord Definition
 *=========================================================================*/


#endif
/*===========================================================================
 *		End of File SrSopmRecord.H
 *=========================================================================*/

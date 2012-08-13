/*===========================================================================
 *
 * File:		SrActirecord.H
 * Author:		Dave Humphrey (dave@uesp.net)
 * Created On:	5 December 2011
 *
 * Defines the CSrActiRecord class.
 *
 *=========================================================================*/
#ifndef __SRACTIRECORD_H
#define __SRACTIRECORD_H


/*===========================================================================
 *
 * Begin Required Includes
 *
 *=========================================================================*/
	#include "sritem1record.h"
	#include "../subrecords/sractidestsubrecord.h"
	#include "../subrecords/srvmadsubrecord.h"
/*===========================================================================
 *		End of Required Includes
 *=========================================================================*/


/*===========================================================================
 *
 * Begin Class CSrActiRecord Definition
 *
 *=========================================================================*/
class CSrActiRecord : public CSrIdRecord 
{
  DECLARE_SRSUBRECCREATE()
  DECLARE_SRFIELDMAP()
  DECLARE_SRCLASS(CSrActiRecord, CSrIdRecord)

  /*---------- Begin Protected Class Members --------------------*/
protected:
	CSrStringSubrecord*		m_pModel;
	CSrLStringSubrecord*	m_pItemName;
	CSrSubrecord*			m_pFnamData;
	CSrSubrecord*			m_pDmdsData;
	CSrSubrecord*			m_pObndData;
	CSrDwordSubrecord*		m_pPnamData;
	CSrFormidSubrecord*		m_pKeyword;
	CSrActiDestSubrecord*	m_pDestructionData;
	CSrVmadSubrecord*			m_pVmadData;
	CSrSubrecord*			m_pModtData;
	CSrSubrecord*			m_pModsData;
	CSrSubrecord*			m_pDstdData;
	CSrStringSubrecord*		m_pDestroyedModel;
	CSrSubrecord*			m_pDmdtData;
	CSrSubrecord*			m_pDstfData;
	CSrLStringSubrecord*	m_pVerb;
	CSrFormidSubrecord*		m_pUseSound;
	CSrFormidSubrecord*		m_pWater;
	CSrFormidSubrecord*		m_pAmbientSound;


	static sractidestdata_t s_NullDestData;


  /*---------- Begin Protected Class Methods --------------------*/
protected:


  /*---------- Begin Public Class Methods -----------------------*/
public:

		/* Class Constructors/Destructors */
	CSrActiRecord();
	virtual void Destroy (void);

    	/* Return a new instance of the class */
	static CSrRecord* Create (void) { return new CSrActiRecord; }

		/* Get class members */
	sractidestdata_t& GetDestData (void) { return m_pDestructionData ? m_pDestructionData->GetDestData() : s_NullDestData; }
  

		/* Initialize a new record */
	void InitializeNew (void);

		/* Called to alert record of a new subrecord being added */
	virtual void OnAddSubrecord    (CSrSubrecord* pSubrecord);
	virtual void OnDeleteSubrecord (CSrSubrecord* pSubrecord);


		/* Begin field method definitions */
	DECLARE_SRFIELD_MODEL(CSrActiRecord, SR_NAME_MODL)
	DECLARE_SRFIELD_FULLNAME(CSrActiRecord)
	DECLARE_SRFIELD_STRING(CSrActiRecord, m_pDestroyedModel, DestroyModel, SR_NAME_DMDL)
	DECLARE_SRFIELD_STRING(CSrActiRecord, m_pVerb, Verb, SR_NAME_RNAM)
		
	DECLARE_SRFIELD_DWORD1(CSrActiRecord, Unknown1, GetDestData().Unknown1, GetDestData().Unknown1)
	DECLARE_SRFIELD_WORD1(CSrActiRecord, Unknown2, GetDestData().Unknown2, GetDestData().Unknown2)
	DECLARE_SRFIELD_WORD1(CSrActiRecord, Unknown3, GetDestData().Unknown3, GetDestData().Unknown3)
	DECLARE_SRFIELD_METHODDWORDF(CSrActiRecord, m_pPnamData, Unknown4, SR_NAME_PNAM, "0x%08X")

	DECLARE_SRFIELD_EDITORID1(CSrActiRecord, AmbientSound, SR_NAME_SNAM)
	DECLARE_SRFIELD_EDITORID1(CSrActiRecord, UseSound, SR_NAME_VNAM)
	DECLARE_SRFIELD_EDITORID1(CSrActiRecord, Water, SR_NAME_WNAM)
	DECLARE_SRFIELD_EDITORID1(CSrActiRecord, Keyword, SR_NAME_KNAM)
};
/*===========================================================================
 *		End of Class CSrActiRecord Definition
 *=========================================================================*/


#endif
/*===========================================================================
 *		End of File SrActiRecord.H
 *=========================================================================*/

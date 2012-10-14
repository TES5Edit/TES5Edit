/*===========================================================================
 *
 * File:		SrMiscrecord.H
 * Author:		Dave Humphrey (dave@uesp.net)
 * Created On:	5 December 2011
 *
 * Defines the CSrMiscRecord class.
 *
 *=========================================================================*/
#ifndef __SRMISCRECORD_H
#define __SRMISCRECORD_H


/*===========================================================================
 *
 * Begin Required Includes
 *
 *=========================================================================*/
	#include "sritem1record.h"
	#include "../subrecords/srmiscdatasubrecord.h"
	#include "../subrecords/srvmadsubrecord.h"
/*===========================================================================
 *		End of Required Includes
 *=========================================================================*/


/*===========================================================================
 *
 * Begin Class CSrMiscRecord Definition
 *
 *=========================================================================*/
class CSrMiscRecord : public CSrItem1Record 
{
  DECLARE_SRSUBRECCREATE()
  DECLARE_SRFIELDMAP()
  DECLARE_SRCLASS(CSrMiscRecord, CSrItem1Record)

  /*---------- Begin Protected Class Members --------------------*/
protected:
	CSrSubrecord*			m_pObndData;
	CSrVmadSubrecord*			m_pVmadData;
	CSrSubrecord*			m_pModtData;
	CSrMiscDataSubrecord*	m_pMiscData;
	CSrSubrecord*			m_pModsData;
	CSrFormidSubrecord*		m_pPickupSound;
	CSrFormidSubrecord*		m_pDropSound;

	static srmiscdata_t     s_NullMiscData;


  /*---------- Begin Protected Class Methods --------------------*/
protected:


  /*---------- Begin Public Class Methods -----------------------*/
public:

		/* Class Constructors/Destructors */
	CSrMiscRecord();
	virtual void Destroy (void);

    	/* Return a new instance of the class */
	static CSrRecord* Create (void) { return new CSrMiscRecord; }

		/* Get class members */
	srmiscdata_t& GetMiscData (void) { return m_pMiscData ? m_pMiscData->GetMiscData() : s_NullMiscData; }  

		/* Initialize a new record */
	void InitializeNew (void);

		/* Called to alert record of a new subrecord being added */
	virtual void OnAddSubrecord    (CSrSubrecord* pSubrecord);
	virtual void OnDeleteSubrecord (CSrSubrecord* pSubrecord);


		/* Begin field method definitions */
	DECLARE_SRFIELD_FLOAT1(CSrMiscRecord, Weight, GetMiscData().Weight, GetMiscData().Weight)
	DECLARE_SRFIELD_DWORD1(CSrMiscRecord, Value, GetMiscData().Value, GetMiscData().Value)

	DECLARE_SRFIELD_EDITORID(CSrMiscRecord, PickupSound, GetPickupSound, SetPickupSound)
	DECLARE_SRMETHOD_FORMID(PickupSound, m_pPickupSound, SR_NAME_YNAM)

	DECLARE_SRFIELD_EDITORID(CSrMiscRecord, DropSound, GetDropSound, SetDropSound)
	DECLARE_SRMETHOD_FORMID(DropSound, m_pDropSound, SR_NAME_ZNAM)

};
/*===========================================================================
 *		End of Class CSrMiscRecord Definition
 *=========================================================================*/


#endif
/*===========================================================================
 *		End of File SrMiscRecord.H
 *=========================================================================*/

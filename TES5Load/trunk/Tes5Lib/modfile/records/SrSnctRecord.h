/*===========================================================================
 *
 * File:		SrSnctrecord.H
 * Author:		Dave Humphrey (dave@uesp.net)
 * Created On:	5 December 2011
 *
 * Defines the CSrSnctRecord class.
 *
 *=========================================================================*/
#ifndef __SRSNCTRECORD_H
#define __SRSNCTRECORD_H


/*===========================================================================
 *
 * Begin Required Includes
 *
 *=========================================================================*/
	#include "sridrecord.h"
	#include "../subrecords/srlstringsubrecord.h"
/*===========================================================================
 *		End of Required Includes
 *=========================================================================*/


/*===========================================================================
 *
 * Begin Class CSrSnctRecord Definition
 *
 *=========================================================================*/
class CSrSnctRecord : public CSrIdRecord 
{
	DECLARE_SRSUBRECCREATE()
	DECLARE_SRFIELDMAP()
	DECLARE_SRCLASS(CSrSnctRecord, CSrIdRecord)

  /*---------- Begin Protected Class Members --------------------*/
protected:  	
	CSrDwordSubrecord*		m_pFlags;
	CSrLStringSubrecord*	m_pItemName;
	CSrFormidSubrecord*		m_pParentCategory;
	CSrWordSubrecord*		m_pVnamData;
	CSrWordSubrecord*		m_pUnamData;


  /*---------- Begin Protected Class Methods --------------------*/
protected:


  /*---------- Begin Public Class Methods -----------------------*/
public:

		/* Class Constructors/Destructors */
	CSrSnctRecord();
	virtual void Destroy (void);

    	/* Return a new instance of the class */
	static CSrRecord* Create (void) { return new CSrSnctRecord; }

		/* Get class members */
  

		/* Initialize a new record */
	void InitializeNew (void);

		/* Called to alert record of a new subrecord being added */
	virtual void OnAddSubrecord    (CSrSubrecord* pSubrecord);
	virtual void OnDeleteSubrecord (CSrSubrecord* pSubrecord);


		/* Begin field method definitions */
	DECLARE_SRFIELD_ITEMNAME(CSrSnctRecord)
	DECLARE_SRFIELD_EDITORID1(CSrSnctRecord, ParentCategory, SR_NAME_PNAM)
	DECLARE_SRFIELD_METHODWORD(CSrSnctRecord, m_pUnamData, UName, SR_NAME_UNAM)
	DECLARE_SRFIELD_METHODWORD(CSrSnctRecord, m_pVnamData, VName, SR_NAME_VNAM)
	DECLARE_SRFIELD_METHODDWORDF(CSrSnctRecord, m_pFlags, SoundFlags, SR_NAME_FNAM, "0x%08X")

};
/*===========================================================================
 *		End of Class CSrSnctRecord Definition
 *=========================================================================*/


#endif
/*===========================================================================
 *		End of File SrSnctRecord.H
 *=========================================================================*/

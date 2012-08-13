/*===========================================================================
 *
 * File:		SrWooprecord.H
 * Author:		Dave Humphrey (dave@uesp.net)
 * Created On:	5 December 2011
 *
 * Defines the CSrWoopRecord class.
 *
 *=========================================================================*/
#ifndef __SRWOOPRECORD_H
#define __SRWOOPRECORD_H


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
 * Begin Class CSrWoopRecord Definition
 *
 *=========================================================================*/
class CSrWoopRecord : public CSrIdRecord 
{
	DECLARE_SRSUBRECCREATE()
	DECLARE_SRFIELDMAP()
	DECLARE_SRCLASS(CSrWoopRecord, CSrIdRecord)

  /*---------- Begin Protected Class Members --------------------*/
protected:
	CSrLStringSubrecord*	m_pTranslation;
	CSrLStringSubrecord*	m_pItemName;


  /*---------- Begin Protected Class Methods --------------------*/
protected:


  /*---------- Begin Public Class Methods -----------------------*/
public:

		/* Class Constructors/Destructors */
	CSrWoopRecord();
	virtual void Destroy (void);

    	/* Return a new instance of the class */
	static CSrRecord* Create (void) { return new CSrWoopRecord; }

		/* Get class members */
  

		/* Initialize a new record */
	void InitializeNew (void);

		/* Called to alert record of a new subrecord being added */
	virtual void OnAddSubrecord    (CSrSubrecord* pSubrecord);
	virtual void OnDeleteSubrecord (CSrSubrecord* pSubrecord);


		/* Begin field method definitions */
	DECLARE_SRFIELD_ITEMNAME(CSrWoopRecord)
	DECLARE_SRFIELD_STRING(CSrWoopRecord, m_pTranslation, Translation, SR_NAME_TNAM)

};
/*===========================================================================
 *		End of Class CSrWoopRecord Definition
 *=========================================================================*/


#endif
/*===========================================================================
 *		End of File SrWoopRecord.H
 *=========================================================================*/

/*===========================================================================
 *
 * File:		SrOtftrecord.H
 * Author:		Dave Humphrey (dave@uesp.net)
 * Created On:	5 December 2011
 *
 * Defines the CSrOtftRecord class.
 *
 *=========================================================================*/
#ifndef __SROTFTRECORD_H
#define __SROTFTRECORD_H


/*===========================================================================
 *
 * Begin Required Includes
 *
 *=========================================================================*/
	#include "sridrecord.h"
	#include "../subrecords/srformidarraysubrecord.h"
/*===========================================================================
 *		End of Required Includes
 *=========================================================================*/


/*===========================================================================
 *
 * Begin Class CSrOtftRecord Definition
 *
 *=========================================================================*/
class CSrOtftRecord : public CSrIdRecord 
{
	DECLARE_SRSUBRECCREATE()
	DECLARE_SRFIELDMAP()
	DECLARE_SRCLASS(CSrOtftRecord, CSrIdRecord)

  /*---------- Begin Protected Class Members --------------------*/
protected:
  	CSrFormidArraySubrecord*		m_pItems;


  /*---------- Begin Protected Class Methods --------------------*/
protected:


  /*---------- Begin Public Class Methods -----------------------*/
public:

		/* Class Constructors/Destructors */
	CSrOtftRecord();
	virtual void Destroy (void);

    	/* Return a new instance of the class */
	static CSrRecord* Create (void) { return new CSrOtftRecord; }

		/* Get class members */
	dword GetItemCount (void) { return m_pItems ? m_pItems->GetFormIDArray().GetSize() : 0; }
	CSrFormidArray* GetItemArray (void) { return m_pItems ? &m_pItems->GetFormIDArray() : NULL; }

		/* Initialize a new record */
	void InitializeNew (void);

		/* Called to alert record of a new subrecord being added */
	virtual void OnAddSubrecord    (CSrSubrecord* pSubrecord);
	virtual void OnDeleteSubrecord (CSrSubrecord* pSubrecord);


		/* Begin field method definitions */
	DECLARE_SRFIELD_DWORD1(CSrOtftRecord, ItemCount, GetItemCount(), dword Tmp)

};
/*===========================================================================
 *		End of Class CSrOtftRecord Definition
 *=========================================================================*/


#endif
/*===========================================================================
 *		End of File SrOtftRecord.H
 *=========================================================================*/

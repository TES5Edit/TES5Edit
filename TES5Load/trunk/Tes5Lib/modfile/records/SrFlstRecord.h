/*===========================================================================
 *
 * File:		SrFlstrecord.H
 * Author:		Dave Humphrey (dave@uesp.net)
 * Created On:	5 December 2011
 *
 * Defines the CSrFlstRecord class.
 *
 *=========================================================================*/
#ifndef __SRFLSTRECORD_H
#define __SRFLSTRECORD_H


/*===========================================================================
 *
 * Begin Required Includes
 *
 *=========================================================================*/
	#include "sridrecord.h"
/*===========================================================================
 *		End of Required Includes
 *=========================================================================*/


/*===========================================================================
 *
 * Begin Class CSrFlstRecord Definition
 *
 *=========================================================================*/
class CSrFlstRecord : public CSrIdRecord 
{
	DECLARE_SRSUBRECCREATE()
	DECLARE_SRFIELDMAP()
	DECLARE_SRCLASS(CSrFlstRecord, CSrIdRecord)

  /*---------- Begin Protected Class Members --------------------*/
protected:

  /*---------- Begin Protected Class Methods --------------------*/
protected:


  /*---------- Begin Public Class Methods -----------------------*/
public:

		/* Class Constructors/Destructors */
	CSrFlstRecord();
	virtual void Destroy (void);

	void AddItem (const srformid_t FormID);

    	/* Return a new instance of the class */
	static CSrRecord* Create (void) { return new CSrFlstRecord; }

		/* Get class members */
	dword GetItemCount (void) { return CountSubrecords(SR_NAME_LNAM); }
  

		/* Initialize a new record */
	void InitializeNew (void);

		/* Called to alert record of a new subrecord being added */
	virtual void OnAddSubrecord    (CSrSubrecord* pSubrecord);
	virtual void OnDeleteSubrecord (CSrSubrecord* pSubrecord);


		/* Begin field method definitions */
	DECLARE_SRFIELD_DWORD1(CSrFlstRecord, ItemCount, GetItemCount(), dword Tmp)

};
/*===========================================================================
 *		End of Class CSrFlstRecord Definition
 *=========================================================================*/


#endif
/*===========================================================================
 *		End of File SrFlstRecord.H
 *=========================================================================*/

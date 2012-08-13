/*===========================================================================
 *
 * File:		SrSpgdrecord.H
 * Author:		Dave Humphrey (dave@uesp.net)
 * Created On:	5 December 2011
 *
 * Defines the CSrSpgdRecord class.
 *
 *=========================================================================*/
#ifndef __SRSPGDRECORD_H
#define __SRSPGDRECORD_H


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
 * Begin Class CSrSpgdRecord Definition
 *
 *=========================================================================*/
class CSrSpgdRecord : public CSrIdRecord 
{
  DECLARE_SRSUBRECCREATE()
  DECLARE_SRFIELDMAP()
  DECLARE_SRCLASS(CSrSpgdRecord, CSrIdRecord)

  /*---------- Begin Protected Class Members --------------------*/
protected:
  	CSrSubrecord*		m_pIconData;
	CSrSubrecord*		m_pDataData;


  /*---------- Begin Protected Class Methods --------------------*/
protected:


  /*---------- Begin Public Class Methods -----------------------*/
public:

	/* Class Constructors/Destructors */
  CSrSpgdRecord();
  virtual void Destroy (void);

    	/* Return a new instance of the class */
  static CSrRecord* Create (void) { return new CSrSpgdRecord; }

	/* Get class members */
  

	/* Initialize a new record */
  void InitializeNew (void);

	/* Called to alert record of a new subrecord being added */
  virtual void OnAddSubrecord    (CSrSubrecord* pSubrecord);
  virtual void OnDeleteSubrecord (CSrSubrecord* pSubrecord);


  /* Begin field method definitions */


};
/*===========================================================================
 *		End of Class CSrSpgdRecord Definition
 *=========================================================================*/


#endif
/*===========================================================================
 *		End of File SrSpgdRecord.H
 *=========================================================================*/

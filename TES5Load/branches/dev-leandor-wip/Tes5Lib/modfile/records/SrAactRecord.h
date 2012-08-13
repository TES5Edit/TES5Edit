/*===========================================================================
 *
 * File:		SrAactrecord.H
 * Author:		Dave Humphrey (dave@uesp.net)
 * Created On:	5 December 2011
 *
 * Defines the CSrAactRecord class.
 *
 *=========================================================================*/
#ifndef __SRAACTRECORD_H
#define __SRAACTRECORD_H


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
 * Begin Class CSrAactRecord Definition
 *
 *=========================================================================*/
class CSrAactRecord : public CSrIdRecord 
{
  DECLARE_SRSUBRECCREATE()
  DECLARE_SRFIELDMAP()
  DECLARE_SRCLASS(CSrAactRecord, CSrIdRecord)
  DECLARE_SRALLOCATOR(CSrAactRecord, CSrRecord)

  /*---------- Begin Protected Class Members --------------------*/
protected:
  	

  /*---------- Begin Protected Class Methods --------------------*/
protected:


  /*---------- Begin Public Class Methods -----------------------*/
public:

	/* Class Constructors/Destructors */
  CSrAactRecord();
  virtual void Destroy (void);

    	/* Return a new instance of the class */
  //static CSrRecord* Create (void) { return new CSrAactRecord; }

	/* Get class members */
  

	/* Initialize a new record */
  void InitializeNew (void);

	/* Called to alert record of a new subrecord being added */
  virtual void OnAddSubrecord    (CSrSubrecord* pSubrecord);
  virtual void OnDeleteSubrecord (CSrSubrecord* pSubrecord);


  /* Begin field method definitions */


};
/*===========================================================================
 *		End of Class CSrAactRecord Definition
 *=========================================================================*/


#endif
/*===========================================================================
 *		End of File SrAactRecord.H
 *=========================================================================*/

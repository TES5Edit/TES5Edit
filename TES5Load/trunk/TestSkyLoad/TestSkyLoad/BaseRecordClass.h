/*===========================================================================
 *
 * File:		Sr%Type%record.H
 * Author:		Dave Humphrey (dave@uesp.net)
 * Created On:	5 December 2011
 *
 * Defines the CSr%Type%Record class.
 *
 *=========================================================================*/
#ifndef __SR%TYPE%RECORD_H
#define __SR%TYPE%RECORD_H


/*===========================================================================
 *
 * Begin Required Includes
 *
 *=========================================================================*/
  #include "srrecord.h"
/*===========================================================================
 *		End of Required Includes
 *=========================================================================*/


/*===========================================================================
 *
 * Begin Class CSr%Type%Record Definition
 *
 *=========================================================================*/
class CSr%Type%Record : public CSrRecord 
{
  DECLARE_SRSUBRECCREATE()
  DECLARE_SRFIELDMAP()
  DECLARE_SRCLASS(CSr%Type%Record, CSrRecord)

  /*---------- Begin Protected Class Members --------------------*/
protected:
  %SubRecordDefs%


  /*---------- Begin Protected Class Methods --------------------*/
protected:


  /*---------- Begin Public Class Methods -----------------------*/
public:

	/* Class Constructors/Destructors */
  CSr%Type%Record();
  virtual void Destroy (void);

    	/* Return a new instance of the class */
  static CSrRecord* Create (void) { return new CSr%Type%Record; }

	/* Get class members */
  

	/* Initialize a new record */
  void InitializeNew (void);

	/* Called to alert record of a new subrecord being added */
  virtual void OnAddSubrecord    (CSrSubrecord* pSubrecord);
  virtual void OnDeleteSubrecord (CSrSubrecord* pSubrecord);


  /* Begin field method definitions */


};
/*===========================================================================
 *		End of Class CSr%Type%Record Definition
 *=========================================================================*/


#endif
/*===========================================================================
 *		End of File Sr%Type%Record.H
 *=========================================================================*/

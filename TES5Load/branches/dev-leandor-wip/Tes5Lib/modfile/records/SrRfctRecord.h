/*===========================================================================
 *
 * File:		SrRfctrecord.H
 * Author:		Dave Humphrey (dave@uesp.net)
 * Created On:	5 December 2011
 *
 * Defines the CSrRfctRecord class.
 *
 *=========================================================================*/
#ifndef __SRRFCTRECORD_H
#define __SRRFCTRECORD_H


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
 * Begin Class CSrRfctRecord Definition
 *
 *=========================================================================*/
class CSrRfctRecord : public CSrIdRecord 
{
  DECLARE_SRSUBRECCREATE()
  DECLARE_SRFIELDMAP()
  DECLARE_SRCLASS(CSrRfctRecord, CSrIdRecord)

  /*---------- Begin Protected Class Members --------------------*/
protected:
	CSrSubrecord*		m_pDataData;


  /*---------- Begin Protected Class Methods --------------------*/
protected:


  /*---------- Begin Public Class Methods -----------------------*/
public:

	/* Class Constructors/Destructors */
  CSrRfctRecord();
  virtual void Destroy (void);

    	/* Return a new instance of the class */
  static CSrRecord* Create (void) { return new CSrRfctRecord; }

	/* Get class members */
  

	/* Initialize a new record */
  void InitializeNew (void);

	/* Called to alert record of a new subrecord being added */
  virtual void OnAddSubrecord    (CSrSubrecord* pSubrecord);
  virtual void OnDeleteSubrecord (CSrSubrecord* pSubrecord);


  /* Begin field method definitions */


};
/*===========================================================================
 *		End of Class CSrRfctRecord Definition
 *=========================================================================*/


#endif
/*===========================================================================
 *		End of File SrRfctRecord.H
 *=========================================================================*/

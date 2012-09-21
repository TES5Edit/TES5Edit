/*===========================================================================
 *
 * File:		SrPgrerecord.H
 * Author:		Dave Humphrey (dave@uesp.net)
 * Created On:	5 December 2011
 *
 * Defines the CSrPgreRecord class.
 *
 *=========================================================================*/
#ifndef __SRPGRERECORD_H
#define __SRPGRERECORD_H


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
 * Begin Class CSrPgreRecord Definition
 *
 *=========================================================================*/
class CSrPgreRecord : public CSrRecord 
{
  DECLARE_SRSUBRECCREATE()
  DECLARE_SRFIELDMAP()
  DECLARE_SRCLASS(CSrPgreRecord, CSrRecord)

  /*---------- Begin Protected Class Members --------------------*/
protected:
  	CSrSubrecord*		m_pXsclData;
	CSrSubrecord*		m_pNameData;
	CSrSubrecord*		m_pXespData;
	CSrSubrecord*		m_pXownData;
	CSrSubrecord*		m_pDataData;



  /*---------- Begin Protected Class Methods --------------------*/
protected:


  /*---------- Begin Public Class Methods -----------------------*/
public:

	/* Class Constructors/Destructors */
  CSrPgreRecord();
  virtual void Destroy (void);

    	/* Return a new instance of the class */
  static CSrRecord* Create (void) { return new CSrPgreRecord; }

	/* Get class members */
  

	/* Initialize a new record */
  void InitializeNew (void);

	/* Called to alert record of a new subrecord being added */
  virtual void OnAddSubrecord    (CSrSubrecord* pSubrecord);
  virtual void OnDeleteSubrecord (CSrSubrecord* pSubrecord);


  /* Begin field method definitions */


};
/*===========================================================================
 *		End of Class CSrPgreRecord Definition
 *=========================================================================*/


#endif
/*===========================================================================
 *		End of File SrPgreRecord.H
 *=========================================================================*/

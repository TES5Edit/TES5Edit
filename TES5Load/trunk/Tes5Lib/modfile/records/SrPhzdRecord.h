/*===========================================================================
 *
 * File:		SrPhzdrecord.H
 * Author:		Dave Humphrey (dave@uesp.net)
 * Created On:	5 December 2011
 *
 * Defines the CSrPhzdRecord class.
 *
 *=========================================================================*/
#ifndef __SRPHZDRECORD_H
#define __SRPHZDRECORD_H


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
 * Begin Class CSrPhzdRecord Definition
 *
 *=========================================================================*/
class CSrPhzdRecord : public CSrRecord 
{
  DECLARE_SRSUBRECCREATE()
  DECLARE_SRFIELDMAP()
  DECLARE_SRCLASS(CSrPhzdRecord, CSrRecord)

  /*---------- Begin Protected Class Members --------------------*/
protected:
  	CSrSubrecord*		m_pXsclData;
	CSrSubrecord*		m_pNameData;
	CSrSubrecord*		m_pXespData;
	CSrSubrecord*		m_pDataData;
	CSrSubrecord*		m_pVmadData;



  /*---------- Begin Protected Class Methods --------------------*/
protected:


  /*---------- Begin Public Class Methods -----------------------*/
public:

	/* Class Constructors/Destructors */
  CSrPhzdRecord();
  virtual void Destroy (void);

    	/* Return a new instance of the class */
  static CSrRecord* Create (void) { return new CSrPhzdRecord; }

	/* Get class members */
  

	/* Initialize a new record */
  void InitializeNew (void);

	/* Called to alert record of a new subrecord being added */
  virtual void OnAddSubrecord    (CSrSubrecord* pSubrecord);
  virtual void OnDeleteSubrecord (CSrSubrecord* pSubrecord);


  /* Begin field method definitions */


};
/*===========================================================================
 *		End of Class CSrPhzdRecord Definition
 *=========================================================================*/


#endif
/*===========================================================================
 *		End of File SrPhzdRecord.H
 *=========================================================================*/

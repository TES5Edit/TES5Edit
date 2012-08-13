/*===========================================================================
 *
 * File:		SrImgsrecord.H
 * Author:		Dave Humphrey (dave@uesp.net)
 * Created On:	5 December 2011
 *
 * Defines the CSrImgsRecord class.
 *
 *=========================================================================*/
#ifndef __SRIMGSRECORD_H
#define __SRIMGSRECORD_H


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
 * Begin Class CSrImgsRecord Definition
 *
 *=========================================================================*/
class CSrImgsRecord : public CSrIdRecord 
{
  DECLARE_SRSUBRECCREATE()
  DECLARE_SRFIELDMAP()
  DECLARE_SRCLASS(CSrImgsRecord, CSrIdRecord)

  /*---------- Begin Protected Class Members --------------------*/
protected:
	CSrSubrecord*		m_pHnamData;
	CSrSubrecord*		m_pCnamData;
	CSrSubrecord*		m_pDnamData;
	CSrSubrecord*		m_pTnamData;
	CSrSubrecord*		m_pEnamData;


  /*---------- Begin Protected Class Methods --------------------*/
protected:


  /*---------- Begin Public Class Methods -----------------------*/
public:

	/* Class Constructors/Destructors */
  CSrImgsRecord();
  virtual void Destroy (void);

    	/* Return a new instance of the class */
  static CSrRecord* Create (void) { return new CSrImgsRecord; }

	/* Get class members */
  

	/* Initialize a new record */
  void InitializeNew (void);

	/* Called to alert record of a new subrecord being added */
  virtual void OnAddSubrecord    (CSrSubrecord* pSubrecord);
  virtual void OnDeleteSubrecord (CSrSubrecord* pSubrecord);


  /* Begin field method definitions */


};
/*===========================================================================
 *		End of Class CSrImgsRecord Definition
 *=========================================================================*/


#endif
/*===========================================================================
 *		End of File SrImgsRecord.H
 *=========================================================================*/

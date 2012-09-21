/*===========================================================================
 *
 * File:		SrDlvwrecord.H
 * Author:		Dave Humphrey (dave@uesp.net)
 * Created On:	5 December 2011
 *
 * Defines the CSrDlvwRecord class.
 *
 *=========================================================================*/
#ifndef __SRDLVWRECORD_H
#define __SRDLVWRECORD_H


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
 * Begin Class CSrDlvwRecord Definition
 *
 *=========================================================================*/
class CSrDlvwRecord : public CSrIdRecord 
{
  DECLARE_SRSUBRECCREATE()
  DECLARE_SRFIELDMAP()
  DECLARE_SRCLASS(CSrDlvwRecord, CSrIdRecord)

  /*---------- Begin Protected Class Members --------------------*/
protected:
	CSrSubrecord*		m_pQnamData;
	CSrSubrecord*		m_pBnamData;
	CSrSubrecord*		m_pEnamData;
	CSrSubrecord*		m_pTnamData;
	CSrSubrecord*		m_pDnamData;


  /*---------- Begin Protected Class Methods --------------------*/
protected:


  /*---------- Begin Public Class Methods -----------------------*/
public:

	/* Class Constructors/Destructors */
  CSrDlvwRecord();
  virtual void Destroy (void);

    	/* Return a new instance of the class */
  static CSrRecord* Create (void) { return new CSrDlvwRecord; }

	/* Get class members */
  

	/* Initialize a new record */
  void InitializeNew (void);

	/* Called to alert record of a new subrecord being added */
  virtual void OnAddSubrecord    (CSrSubrecord* pSubrecord);
  virtual void OnDeleteSubrecord (CSrSubrecord* pSubrecord);


  /* Begin field method definitions */


};
/*===========================================================================
 *		End of Class CSrDlvwRecord Definition
 *=========================================================================*/


#endif
/*===========================================================================
 *		End of File SrDlvwRecord.H
 *=========================================================================*/

/*===========================================================================
 *
 * File:		SrIdlerecord.H
 * Author:		Dave Humphrey (dave@uesp.net)
 * Created On:	5 December 2011
 *
 * Defines the CSrIdleRecord class.
 *
 *=========================================================================*/
#ifndef __SRIDLERECORD_H
#define __SRIDLERECORD_H


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
 * Begin Class CSrIdleRecord Definition
 *
 *=========================================================================*/
class CSrIdleRecord : public CSrIdRecord 
{
  DECLARE_SRSUBRECCREATE()
  DECLARE_SRFIELDMAP()
  DECLARE_SRCLASS(CSrIdleRecord, CSrIdRecord)

  /*---------- Begin Protected Class Members --------------------*/
protected:
  	CSrSubrecord*		m_pCis1Data;
	CSrSubrecord*		m_pDataData;
	CSrSubrecord*		m_pAnamData;
	CSrSubrecord*		m_pCtdaData;
	CSrSubrecord*		m_pDnamData;
	CSrSubrecord*		m_pEnamData;


  /*---------- Begin Protected Class Methods --------------------*/
protected:


  /*---------- Begin Public Class Methods -----------------------*/
public:

	/* Class Constructors/Destructors */
  CSrIdleRecord();
  virtual void Destroy (void);

    	/* Return a new instance of the class */
  static CSrRecord* Create (void) { return new CSrIdleRecord; }

	/* Get class members */
  

	/* Initialize a new record */
  void InitializeNew (void);

	/* Called to alert record of a new subrecord being added */
  virtual void OnAddSubrecord    (CSrSubrecord* pSubrecord);
  virtual void OnDeleteSubrecord (CSrSubrecord* pSubrecord);


  /* Begin field method definitions */


};
/*===========================================================================
 *		End of Class CSrIdleRecord Definition
 *=========================================================================*/


#endif
/*===========================================================================
 *		End of File SrIdleRecord.H
 *=========================================================================*/

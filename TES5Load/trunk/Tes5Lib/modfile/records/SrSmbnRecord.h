/*===========================================================================
 *
 * File:		SrSmbnrecord.H
 * Author:		Dave Humphrey (dave@uesp.net)
 * Created On:	5 December 2011
 *
 * Defines the CSrSmbnRecord class.
 *
 *=========================================================================*/
#ifndef __SRSMBNRECORD_H
#define __SRSMBNRECORD_H


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
 * Begin Class CSrSmbnRecord Definition
 *
 *=========================================================================*/
class CSrSmbnRecord : public CSrIdRecord 
{
  DECLARE_SRSUBRECCREATE()
  DECLARE_SRFIELDMAP()
  DECLARE_SRCLASS(CSrSmbnRecord, CSrIdRecord)

  /*---------- Begin Protected Class Members --------------------*/
protected:
	CSrSubrecord*		m_pXnamData;
	CSrSubrecord*		m_pPnamData;
	CSrSubrecord*		m_pCis2Data;
	CSrSubrecord*		m_pSnamData;
	CSrSubrecord*		m_pCitcData;
	CSrSubrecord*		m_pCtdaData;
	CSrSubrecord*		m_pDnamData;


  /*---------- Begin Protected Class Methods --------------------*/
protected:


  /*---------- Begin Public Class Methods -----------------------*/
public:

	/* Class Constructors/Destructors */
  CSrSmbnRecord();
  virtual void Destroy (void);

    	/* Return a new instance of the class */
  static CSrRecord* Create (void) { return new CSrSmbnRecord; }

	/* Get class members */
  

	/* Initialize a new record */
  void InitializeNew (void);

	/* Called to alert record of a new subrecord being added */
  virtual void OnAddSubrecord    (CSrSubrecord* pSubrecord);
  virtual void OnDeleteSubrecord (CSrSubrecord* pSubrecord);


  /* Begin field method definitions */


};
/*===========================================================================
 *		End of Class CSrSmbnRecord Definition
 *=========================================================================*/


#endif
/*===========================================================================
 *		End of File SrSmbnRecord.H
 *=========================================================================*/

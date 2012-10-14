/*===========================================================================
 *
 * File:		SrSmenrecord.H
 * Author:		Dave Humphrey (dave@uesp.net)
 * Created On:	5 December 2011
 *
 * Defines the CSrSmenRecord class.
 *
 *=========================================================================*/
#ifndef __SRSMENRECORD_H
#define __SRSMENRECORD_H


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
 * Begin Class CSrSmenRecord Definition
 *
 *=========================================================================*/
class CSrSmenRecord : public CSrIdRecord 
{
  DECLARE_SRSUBRECCREATE()
  DECLARE_SRFIELDMAP()
  DECLARE_SRCLASS(CSrSmenRecord, CSrIdRecord)

  /*---------- Begin Protected Class Members --------------------*/
protected:
  	CSrSubrecord*		m_pXnamData;
	CSrSubrecord*		m_pPnamData;
	CSrSubrecord*		m_pSnamData;
	CSrSubrecord*		m_pCitcData;
	CSrSubrecord*		m_pDnamData;
	CSrSubrecord*		m_pEnamData;


  /*---------- Begin Protected Class Methods --------------------*/
protected:


  /*---------- Begin Public Class Methods -----------------------*/
public:

	/* Class Constructors/Destructors */
  CSrSmenRecord();
  virtual void Destroy (void);

    	/* Return a new instance of the class */
  static CSrRecord* Create (void) { return new CSrSmenRecord; }

	/* Get class members */
  

	/* Initialize a new record */
  void InitializeNew (void);

	/* Called to alert record of a new subrecord being added */
  virtual void OnAddSubrecord    (CSrSubrecord* pSubrecord);
  virtual void OnDeleteSubrecord (CSrSubrecord* pSubrecord);


  /* Begin field method definitions */


};
/*===========================================================================
 *		End of Class CSrSmenRecord Definition
 *=========================================================================*/


#endif
/*===========================================================================
 *		End of File SrSmenRecord.H
 *=========================================================================*/

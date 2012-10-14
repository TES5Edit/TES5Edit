/*===========================================================================
 *
 * File:		SrLscrrecord.H
 * Author:		Dave Humphrey (dave@uesp.net)
 * Created On:	5 December 2011
 *
 * Defines the CSrLscrRecord class.
 *
 *=========================================================================*/
#ifndef __SRLSCRRECORD_H
#define __SRLSCRRECORD_H


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
 * Begin Class CSrLscrRecord Definition
 *
 *=========================================================================*/
class CSrLscrRecord : public CSrIdRecord 
{
  DECLARE_SRSUBRECCREATE()
  DECLARE_SRFIELDMAP()
  DECLARE_SRCLASS(CSrLscrRecord, CSrIdRecord)

  /*---------- Begin Protected Class Members --------------------*/
protected:
  	CSrSubrecord*		m_pNnamData;
	CSrSubrecord*		m_pCis2Data;
	CSrSubrecord*		m_pSnamData;
	CSrSubrecord*		m_pDescData;
	CSrSubrecord*		m_pCtdaData;
	CSrSubrecord*		m_pRnamData;
	CSrSubrecord*		m_pOnamData;
	CSrSubrecord*		m_pXnamData;
	CSrSubrecord*		m_pMod2Data;


  /*---------- Begin Protected Class Methods --------------------*/
protected:


  /*---------- Begin Public Class Methods -----------------------*/
public:

	/* Class Constructors/Destructors */
  CSrLscrRecord();
  virtual void Destroy (void);

    	/* Return a new instance of the class */
  static CSrRecord* Create (void) { return new CSrLscrRecord; }

	/* Get class members */
  

	/* Initialize a new record */
  void InitializeNew (void);

	/* Called to alert record of a new subrecord being added */
  virtual void OnAddSubrecord    (CSrSubrecord* pSubrecord);
  virtual void OnDeleteSubrecord (CSrSubrecord* pSubrecord);


  /* Begin field method definitions */


};
/*===========================================================================
 *		End of Class CSrLscrRecord Definition
 *=========================================================================*/


#endif
/*===========================================================================
 *		End of File SrLscrRecord.H
 *=========================================================================*/

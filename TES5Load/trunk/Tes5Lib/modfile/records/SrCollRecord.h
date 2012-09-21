/*===========================================================================
 *
 * File:		SrCollrecord.H
 * Author:		Dave Humphrey (dave@uesp.net)
 * Created On:	5 December 2011
 *
 * Defines the CSrCollRecord class.
 *
 *=========================================================================*/
#ifndef __SRCOLLRECORD_H
#define __SRCOLLRECORD_H


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
 * Begin Class CSrCollRecord Definition
 *
 *=========================================================================*/
class CSrCollRecord : public CSrIdRecord 
{
  DECLARE_SRSUBRECCREATE()
  DECLARE_SRFIELDMAP()
  DECLARE_SRCLASS(CSrCollRecord, CSrIdRecord)

  /*---------- Begin Protected Class Members --------------------*/
protected:
  	CSrSubrecord*		m_pFnamData;
	CSrSubrecord*		m_pCnamData;
	CSrSubrecord*		m_pDescData;
	CSrSubrecord*		m_pBnamData;
	CSrSubrecord*		m_pGnamData;
	CSrSubrecord*		m_pMnamData;
	CSrSubrecord*		m_pIntvData;


  /*---------- Begin Protected Class Methods --------------------*/
protected:


  /*---------- Begin Public Class Methods -----------------------*/
public:

	/* Class Constructors/Destructors */
  CSrCollRecord();
  virtual void Destroy (void);

    	/* Return a new instance of the class */
  static CSrRecord* Create (void) { return new CSrCollRecord; }

	/* Get class members */
  

	/* Initialize a new record */
  void InitializeNew (void);

	/* Called to alert record of a new subrecord being added */
  virtual void OnAddSubrecord    (CSrSubrecord* pSubrecord);
  virtual void OnDeleteSubrecord (CSrSubrecord* pSubrecord);


  /* Begin field method definitions */


};
/*===========================================================================
 *		End of Class CSrCollRecord Definition
 *=========================================================================*/


#endif
/*===========================================================================
 *		End of File SrCollRecord.H
 *=========================================================================*/

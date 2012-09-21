/*===========================================================================
 *
 * File:		SrDialrecord.H
 * Author:		Dave Humphrey (dave@uesp.net)
 * Created On:	5 December 2011
 *
 * Defines the CSrDialRecord class.
 *
 *=========================================================================*/
#ifndef __SRDIALRECORD_H
#define __SRDIALRECORD_H


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
 * Begin Class CSrDialRecord Definition
 *
 *=========================================================================*/
class CSrDialRecord : public CSrIdRecord 
{
  DECLARE_SRSUBRECCREATE()
  DECLARE_SRFIELDMAP()
  DECLARE_SRCLASS(CSrDialRecord, CSrIdRecord)

  /*---------- Begin Protected Class Members --------------------*/
protected:
  	CSrSubrecord*		m_pPnamData;
	CSrSubrecord*		m_pDataData;
	CSrSubrecord*		m_pQnamData;
	CSrSubrecord*		m_pFullData;
	CSrSubrecord*		m_pSnamData;
	CSrSubrecord*		m_pBnamData;
	CSrSubrecord*		m_pTifcData;


  /*---------- Begin Protected Class Methods --------------------*/
protected:


  /*---------- Begin Public Class Methods -----------------------*/
public:

	/* Class Constructors/Destructors */
  CSrDialRecord();
  virtual void Destroy (void);

    	/* Return a new instance of the class */
  static CSrRecord* Create (void) { return new CSrDialRecord; }

	/* Get class members */
  

	/* Initialize a new record */
  void InitializeNew (void);

	/* Called to alert record of a new subrecord being added */
  virtual void OnAddSubrecord    (CSrSubrecord* pSubrecord);
  virtual void OnDeleteSubrecord (CSrSubrecord* pSubrecord);


  /* Begin field method definitions */


};
/*===========================================================================
 *		End of Class CSrDialRecord Definition
 *=========================================================================*/


#endif
/*===========================================================================
 *		End of File SrDialRecord.H
 *=========================================================================*/

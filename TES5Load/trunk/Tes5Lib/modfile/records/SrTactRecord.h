/*===========================================================================
 *
 * File:		SrTactrecord.H
 * Author:		Dave Humphrey (dave@uesp.net)
 * Created On:	5 December 2011
 *
 * Defines the CSrTactRecord class.
 *
 *=========================================================================*/
#ifndef __SRTACTRECORD_H
#define __SRTACTRECORD_H


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
 * Begin Class CSrTactRecord Definition
 *
 *=========================================================================*/
class CSrTactRecord : public CSrIdRecord 
{
  DECLARE_SRSUBRECCREATE()
  DECLARE_SRFIELDMAP()
  DECLARE_SRCLASS(CSrTactRecord, CSrIdRecord)

  /*---------- Begin Protected Class Members --------------------*/
protected:
  	CSrSubrecord*		m_pVnamData;
	CSrSubrecord*		m_pFnamData;
	CSrSubrecord*		m_pModlData;
	CSrSubrecord*		m_pFullData;
	CSrSubrecord*		m_pModtData;
	CSrSubrecord*		m_pPnamData;


  /*---------- Begin Protected Class Methods --------------------*/
protected:


  /*---------- Begin Public Class Methods -----------------------*/
public:

	/* Class Constructors/Destructors */
  CSrTactRecord();
  virtual void Destroy (void);

    	/* Return a new instance of the class */
  static CSrRecord* Create (void) { return new CSrTactRecord; }

	/* Get class members */
  

	/* Initialize a new record */
  void InitializeNew (void);

	/* Called to alert record of a new subrecord being added */
  virtual void OnAddSubrecord    (CSrSubrecord* pSubrecord);
  virtual void OnDeleteSubrecord (CSrSubrecord* pSubrecord);


  /* Begin field method definitions */


};
/*===========================================================================
 *		End of Class CSrTactRecord Definition
 *=========================================================================*/


#endif
/*===========================================================================
 *		End of File SrTactRecord.H
 *=========================================================================*/

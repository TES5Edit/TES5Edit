/*===========================================================================
 *
 * File:		SrHdptrecord.H
 * Author:		Dave Humphrey (dave@uesp.net)
 * Created On:	5 December 2011
 *
 * Defines the CSrHdptRecord class.
 *
 *=========================================================================*/
#ifndef __SRHDPTRECORD_H
#define __SRHDPTRECORD_H


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
 * Begin Class CSrHdptRecord Definition
 *
 *=========================================================================*/
class CSrHdptRecord : public CSrIdRecord 
{
  DECLARE_SRSUBRECCREATE()
  DECLARE_SRFIELDMAP()
  DECLARE_SRCLASS(CSrHdptRecord, CSrIdRecord)

  /*---------- Begin Protected Class Members --------------------*/
protected:
  	CSrSubrecord*		m_pModlData;
	CSrSubrecord*		m_pFullData;
	CSrSubrecord*		m_pTnamData;
	CSrSubrecord*		m_pNam1Data;
	CSrSubrecord*		m_pModtData;
	CSrSubrecord*		m_pDataData;
	CSrSubrecord*		m_pPnamData;
	CSrSubrecord*		m_pRnamData;
	CSrSubrecord*		m_pNam0Data;
	CSrSubrecord*		m_pHnamData;


  /*---------- Begin Protected Class Methods --------------------*/
protected:


  /*---------- Begin Public Class Methods -----------------------*/
public:

	/* Class Constructors/Destructors */
  CSrHdptRecord();
  virtual void Destroy (void);

    	/* Return a new instance of the class */
  static CSrRecord* Create (void) { return new CSrHdptRecord; }

	/* Get class members */
  

	/* Initialize a new record */
  void InitializeNew (void);

	/* Called to alert record of a new subrecord being added */
  virtual void OnAddSubrecord    (CSrSubrecord* pSubrecord);
  virtual void OnDeleteSubrecord (CSrSubrecord* pSubrecord);


  /* Begin field method definitions */


};
/*===========================================================================
 *		End of Class CSrHdptRecord Definition
 *=========================================================================*/


#endif
/*===========================================================================
 *		End of File SrHdptRecord.H
 *=========================================================================*/

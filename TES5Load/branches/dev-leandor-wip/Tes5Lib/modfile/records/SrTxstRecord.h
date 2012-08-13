/*===========================================================================
 *
 * File:		SrTxstrecord.H
 * Author:		Dave Humphrey (dave@uesp.net)
 * Created On:	5 December 2011
 *
 * Defines the CSrTxstRecord class.
 *
 *=========================================================================*/
#ifndef __SRTXSTRECORD_H
#define __SRTXSTRECORD_H


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
 * Begin Class CSrTxstRecord Definition
 *
 *=========================================================================*/
class CSrTxstRecord : public CSrIdRecord 
{
  DECLARE_SRSUBRECCREATE()
  DECLARE_SRFIELDMAP()
  DECLARE_SRCLASS(CSrTxstRecord, CSrIdRecord)

  /*---------- Begin Protected Class Members --------------------*/
protected:
	CSrSubrecord*		m_pTx05Data;
	CSrSubrecord*		m_pDnamData;
	CSrSubrecord*		m_pTx00Data;
	CSrSubrecord*		m_pTx01Data;
	CSrSubrecord*		m_pDodtData;
	CSrSubrecord*		m_pTx03Data;
	CSrSubrecord*		m_pTx07Data;
	CSrSubrecord*		m_pTx02Data;
	CSrSubrecord*		m_pTx04Data;


  /*---------- Begin Protected Class Methods --------------------*/
protected:


  /*---------- Begin Public Class Methods -----------------------*/
public:

	/* Class Constructors/Destructors */
  CSrTxstRecord();
  virtual void Destroy (void);

    	/* Return a new instance of the class */
  static CSrRecord* Create (void) { return new CSrTxstRecord; }

	/* Get class members */
  

	/* Initialize a new record */
  void InitializeNew (void);

	/* Called to alert record of a new subrecord being added */
  virtual void OnAddSubrecord    (CSrSubrecord* pSubrecord);
  virtual void OnDeleteSubrecord (CSrSubrecord* pSubrecord);


  /* Begin field method definitions */


};
/*===========================================================================
 *		End of Class CSrTxstRecord Definition
 *=========================================================================*/


#endif
/*===========================================================================
 *		End of File SrTxstRecord.H
 *=========================================================================*/

/*===========================================================================
 *
 * File:		SrWthrrecord.H
 * Author:		Dave Humphrey (dave@uesp.net)
 * Created On:	5 December 2011
 *
 * Defines the CSrWthrRecord class.
 *
 *=========================================================================*/
#ifndef __SRWTHRRECORD_H
#define __SRWTHRRECORD_H


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
 * Begin Class CSrWthrRecord Definition
 *
 *=========================================================================*/
class CSrWthrRecord : public CSrIdRecord 
{
  DECLARE_SRSUBRECCREATE()
  DECLARE_SRFIELDMAP()
  DECLARE_SRCLASS(CSrWthrRecord, CSrIdRecord)

  /*---------- Begin Protected Class Members --------------------*/
protected:
	CSrSubrecord*		m_pFnamData;
	CSrSubrecord*		m_pRnamData;
	CSrSubrecord*		m_p00txData;
	CSrSubrecord*		m_pSnamData;
	CSrSubrecord*		m_p10txData;
	CSrSubrecord*		m_pTnamData;
	CSrSubrecord*		m_pNam1Data;
	CSrSubrecord*		m_p20txData;
	CSrSubrecord*		m_pImspData;
	CSrSubrecord*		m_p30txData;
	CSrSubrecord*		m_pC0txData;
	CSrSubrecord*		m_pD0txData;
	CSrSubrecord*		m_pL0txData;
	CSrSubrecord*		m_pModtData;
	CSrSubrecord*		m_pLnamData;
	CSrSubrecord*		m_pMnamData;
	CSrSubrecord*		m_pNnamData;
	CSrSubrecord*		m_pQnamData;
	CSrSubrecord*		m_pPnamData;
	CSrSubrecord*		m_pJnamData;
	CSrSubrecord*		m_pOnamData;
	CSrSubrecord*		m_pNam0Data;
	CSrSubrecord*		m_pG0txData;
	CSrSubrecord*		m_pDataData;
	CSrSubrecord*		m_p50txData;
	CSrSubrecord*		m_pDalcData;
	CSrSubrecord*		m_pModlData;
	CSrSubrecord*		m_p80txData;
	CSrSubrecord*		m_p90txData;
	CSrSubrecord*		m_pA0txData;
	CSrSubrecord*		m_pH0txData;
	CSrSubrecord*		m_pK0txData;
	CSrSubrecord*		m_pE0txData;
	CSrSubrecord*		m_pF0txData;
	CSrSubrecord*		m_p40txData;
	CSrSubrecord*		m_p60txData;
	CSrSubrecord*		m_pNam2Data;
	CSrSubrecord*		m_p70txData;
	CSrSubrecord*		m_pB0txData;
	CSrSubrecord*		m_pI0txData;
	CSrSubrecord*		m_pJ0txData;
	CSrSubrecord*		m_pNam3Data;
	CSrSubrecord*		m_pDnamData;
	CSrSubrecord*		m_pCnamData;
	CSrSubrecord*		m_pAnamData;
	CSrSubrecord*		m_pBnamData;


  /*---------- Begin Protected Class Methods --------------------*/
protected:


  /*---------- Begin Public Class Methods -----------------------*/
public:

	/* Class Constructors/Destructors */
  CSrWthrRecord();
  virtual void Destroy (void);

    	/* Return a new instance of the class */
  static CSrRecord* Create (void) { return new CSrWthrRecord; }

	/* Get class members */
  

	/* Initialize a new record */
  void InitializeNew (void);

	/* Called to alert record of a new subrecord being added */
  virtual void OnAddSubrecord    (CSrSubrecord* pSubrecord);
  virtual void OnDeleteSubrecord (CSrSubrecord* pSubrecord);


  /* Begin field method definitions */


};
/*===========================================================================
 *		End of Class CSrWthrRecord Definition
 *=========================================================================*/


#endif
/*===========================================================================
 *		End of File SrWthrRecord.H
 *=========================================================================*/

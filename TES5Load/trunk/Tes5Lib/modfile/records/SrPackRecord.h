/*===========================================================================
 *
 * File:		SrPackrecord.H
 * Author:		Dave Humphrey (dave@uesp.net)
 * Created On:	5 December 2011
 *
 * Defines the CSrPackRecord class.
 *
 *=========================================================================*/
#ifndef __SRPACKRECORD_H
#define __SRPACKRECORD_H


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
 * Begin Class CSrPackRecord Definition
 *
 *=========================================================================*/
class CSrPackRecord : public CSrIdRecord 
{
  DECLARE_SRSUBRECCREATE()
  DECLARE_SRFIELDMAP()
  DECLARE_SRCLASS(CSrPackRecord, CSrIdRecord)

  /*---------- Begin Protected Class Members --------------------*/
protected:
  	CSrSubrecord*		m_pFnamData;
	CSrSubrecord*		m_pPobaData;
	CSrSubrecord*		m_pPkdtData;
	CSrSubrecord*		m_pPsdtData;
	CSrSubrecord*		m_pPldtData;
	CSrSubrecord*		m_pAnamData;
	CSrSubrecord*		m_pCtdaData;
	CSrSubrecord*		m_pTnamData;
	CSrSubrecord*		m_pPkcuData;
	CSrSubrecord*		m_pCnamData;
	CSrSubrecord*		m_pUnamData;
	CSrSubrecord*		m_pXnamData;
	CSrSubrecord*		m_pInamData;
	CSrSubrecord*		m_pPdtoData;
	CSrSubrecord*		m_pPoeaData;
	CSrSubrecord*		m_pPtdaData;
	CSrSubrecord*		m_pPocaData;
	CSrSubrecord*		m_pQnamData;
	CSrSubrecord*		m_pCis2Data;
	CSrSubrecord*		m_pPfo2Data;
	CSrSubrecord*		m_pCitcData;
	CSrSubrecord*		m_pPrcbData;
	CSrSubrecord*		m_pTpicData;
	CSrSubrecord*		m_pPnamData;
	CSrSubrecord*		m_pPkc2Data;
	CSrSubrecord*		m_pIdlfData;
	CSrSubrecord*		m_pBnamData;
	CSrSubrecord*		m_pIdlaData;
	CSrSubrecord*		m_pVmadData;
	CSrSubrecord*		m_pIdlcData;
	CSrSubrecord*		m_pIdltData;
	CSrSubrecord*		m_pCis1Data;
	CSrSubrecord*		m_pSchrData;
	CSrSubrecord*		m_pSctxData;
	CSrSubrecord*		m_pPforData;
	CSrSubrecord*		m_pScdaData;



  /*---------- Begin Protected Class Methods --------------------*/
protected:


  /*---------- Begin Public Class Methods -----------------------*/
public:

	/* Class Constructors/Destructors */
  CSrPackRecord();
  virtual void Destroy (void);

    	/* Return a new instance of the class */
  static CSrRecord* Create (void) { return new CSrPackRecord; }

	/* Get class members */
  

	/* Initialize a new record */
  void InitializeNew (void);

	/* Called to alert record of a new subrecord being added */
  virtual void OnAddSubrecord    (CSrSubrecord* pSubrecord);
  virtual void OnDeleteSubrecord (CSrSubrecord* pSubrecord);


  /* Begin field method definitions */


};
/*===========================================================================
 *		End of Class CSrPackRecord Definition
 *=========================================================================*/


#endif
/*===========================================================================
 *		End of File SrPackRecord.H
 *=========================================================================*/

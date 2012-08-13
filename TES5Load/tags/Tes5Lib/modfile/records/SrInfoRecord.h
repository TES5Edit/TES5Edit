/*===========================================================================
 *
 * File:		SrInforecord.H
 * Author:		Dave Humphrey (dave@uesp.net)
 * Created On:	5 December 2011
 *
 * Defines the CSrInfoRecord class.
 *
 *=========================================================================*/
#ifndef __SRINFORECORD_H
#define __SRINFORECORD_H


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
 * Begin Class CSrInfoRecord Definition
 *
 *=========================================================================*/
class CSrInfoRecord : public CSrIdRecord 
{
  DECLARE_SRSUBRECCREATE()
  DECLARE_SRFIELDMAP()
  DECLARE_SRCLASS(CSrInfoRecord, CSrIdRecord)

  /*---------- Begin Protected Class Members --------------------*/
protected:
  	CSrSubrecord*		m_pNam3Data;
	CSrSubrecord*		m_pEnamData;
	CSrSubrecord*		m_pSnamData;
	CSrSubrecord*		m_pTrdtData;
	CSrSubrecord*		m_pCis2Data;
	CSrSubrecord*		m_pVmadData;
	CSrSubrecord*		m_pCnamData;
	CSrSubrecord*		m_pNam1Data;
	CSrSubrecord*		m_pNam2Data;
	CSrSubrecord*		m_pCtdaData;
	CSrSubrecord*		m_pDnamData;
	CSrSubrecord*		m_pOnamData;
	CSrSubrecord*		m_pDataData;
	CSrSubrecord*		m_pSchrData;
	CSrSubrecord*		m_pQnamData;
	CSrSubrecord*		m_pNextData;
	CSrSubrecord*		m_pRnamData;
	CSrSubrecord*		m_pTcltData;
	CSrSubrecord*		m_pTwatData;
	CSrSubrecord*		m_pAnamData;
	CSrSubrecord*		m_pLnamData;


  /*---------- Begin Protected Class Methods --------------------*/
protected:


  /*---------- Begin Public Class Methods -----------------------*/
public:

	/* Class Constructors/Destructors */
  CSrInfoRecord();
  virtual void Destroy (void);

    	/* Return a new instance of the class */
  static CSrRecord* Create (void) { return new CSrInfoRecord; }

	/* Get class members */
  

	/* Initialize a new record */
  void InitializeNew (void);

	/* Called to alert record of a new subrecord being added */
  virtual void OnAddSubrecord    (CSrSubrecord* pSubrecord);
  virtual void OnDeleteSubrecord (CSrSubrecord* pSubrecord);


  /* Begin field method definitions */


};
/*===========================================================================
 *		End of Class CSrInfoRecord Definition
 *=========================================================================*/


#endif
/*===========================================================================
 *		End of File SrInfoRecord.H
 *=========================================================================*/

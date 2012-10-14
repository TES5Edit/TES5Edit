/*===========================================================================
 *
 * File:		SrScenrecord.H
 * Author:		Dave Humphrey (dave@uesp.net)
 * Created On:	5 December 2011
 *
 * Defines the CSrScenRecord class.
 *
 *=========================================================================*/
#ifndef __SRSCENRECORD_H
#define __SRSCENRECORD_H


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
 * Begin Class CSrScenRecord Definition
 *
 *=========================================================================*/
class CSrScenRecord : public CSrIdRecord 
{
  DECLARE_SRSUBRECCREATE()
  DECLARE_SRFIELDMAP()
  DECLARE_SRCLASS(CSrScenRecord, CSrIdRecord)

  /*---------- Begin Protected Class Members --------------------*/
protected:
	CSrSubrecord*		m_pFnamData;
	CSrSubrecord*		m_pNextData;
	CSrSubrecord*		m_pVmadData;
	CSrSubrecord*		m_pHnamData;
	CSrSubrecord*		m_pDmaxData;
	CSrSubrecord*		m_pWnamData;
	CSrSubrecord*		m_pNam0Data;
	CSrSubrecord*		m_pAlidData;
	CSrSubrecord*		m_pSctxData;
	CSrSubrecord*		m_pLnamData;
	CSrSubrecord*		m_pDnamData;
	CSrSubrecord*		m_pAnamData;
	CSrSubrecord*		m_pHtidData;
	CSrSubrecord*		m_pInamData;
	CSrSubrecord*		m_pCis2Data;
	CSrSubrecord*		m_pSnamData;
	CSrSubrecord*		m_pEnamData;
	CSrSubrecord*		m_pScdaData;
	CSrSubrecord*		m_pDataData;
	CSrSubrecord*		m_pDminData;
	CSrSubrecord*		m_pDemoData;
	CSrSubrecord*		m_pDevaData;
	CSrSubrecord*		m_pPnamData;
	CSrSubrecord*		m_pVnamData;
	CSrSubrecord*		m_pCtdaData;
	CSrSubrecord*		m_pSchrData;
	CSrSubrecord*		m_pQnamData;
	CSrSubrecord*		m_pScroData;



  /*---------- Begin Protected Class Methods --------------------*/
protected:


  /*---------- Begin Public Class Methods -----------------------*/
public:

	/* Class Constructors/Destructors */
  CSrScenRecord();
  virtual void Destroy (void);

    	/* Return a new instance of the class */
  static CSrRecord* Create (void) { return new CSrScenRecord; }

	/* Get class members */
  

	/* Initialize a new record */
  void InitializeNew (void);

	/* Called to alert record of a new subrecord being added */
  virtual void OnAddSubrecord    (CSrSubrecord* pSubrecord);
  virtual void OnDeleteSubrecord (CSrSubrecord* pSubrecord);


  /* Begin field method definitions */


};
/*===========================================================================
 *		End of Class CSrScenRecord Definition
 *=========================================================================*/


#endif
/*===========================================================================
 *		End of File SrScenRecord.H
 *=========================================================================*/

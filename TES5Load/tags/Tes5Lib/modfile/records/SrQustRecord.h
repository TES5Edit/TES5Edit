/*===========================================================================
 *
 * File:		SrQustrecord.H
 * Author:		Dave Humphrey (dave@uesp.net)
 * Created On:	5 December 2011
 *
 * Defines the CSrQustRecord class.
 *
 *=========================================================================*/
#ifndef __SRQUSTRECORD_H
#define __SRQUSTRECORD_H


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
 * Begin Class CSrQustRecord Definition
 *
 *=========================================================================*/
class CSrQustRecord : public CSrIdRecord 
{
  DECLARE_SRSUBRECCREATE()
  DECLARE_SRFIELDMAP()
  DECLARE_SRCLASS(CSrQustRecord, CSrIdRecord)

  /*---------- Begin Protected Class Members --------------------*/
protected:
  	CSrSubrecord*		m_pFnamData;
	CSrSubrecord*		m_pAlntData;
	CSrSubrecord*		m_pIndxData;
	CSrSubrecord*		m_pNextData;
	CSrSubrecord*		m_pFltrData;
	CSrSubrecord*		m_pSporData;
	CSrSubrecord*		m_pVmadData;
	CSrSubrecord*		m_pKnamData;
	CSrSubrecord*		m_pFullData;
	CSrSubrecord*		m_pDnamData;
	CSrSubrecord*		m_pAlflData;
	CSrSubrecord*		m_pAnamData;
	CSrSubrecord*		m_pCtdaData;
	CSrSubrecord*		m_pEnamData;
	CSrSubrecord*		m_pQsdtData;
	CSrSubrecord*		m_pAlstData;
	CSrSubrecord*		m_pCoctData;
	CSrSubrecord*		m_pQobjData;
	CSrSubrecord*		m_pAlpcData;
	CSrSubrecord*		m_pAlidData;
	CSrSubrecord*		m_pAlfeData;
	CSrSubrecord*		m_pAledData;
	CSrSubrecord*		m_pAlfdData;
	CSrSubrecord*		m_pVtckData;
	CSrSubrecord*		m_pAlcaData;
	CSrSubrecord*		m_pAllsData;
	CSrSubrecord*		m_pAluaData;
	CSrSubrecord*		m_pAlspData;
	CSrSubrecord*		m_pAlfrData;
	CSrSubrecord*		m_pAlcoData;
	CSrSubrecord*		m_pCis2Data;
	CSrSubrecord*		m_pAlclData;
	CSrSubrecord*		m_pNnamData;
	CSrSubrecord*		m_pSchrData;
	CSrSubrecord*		m_pQstaData;
	CSrSubrecord*		m_pAleaData;
	CSrSubrecord*		m_pAlfaData;
	CSrSubrecord*		m_pKwdaData;
	CSrSubrecord*		m_pAlrtData;
	CSrSubrecord*		m_pKsizData;
	CSrSubrecord*		m_pAlfiData;
	CSrSubrecord*		m_pNam0Data;
	CSrSubrecord*		m_pAlfcData;
	CSrSubrecord*		m_pCntoData;
	CSrSubrecord*		m_pAlnaData;
	CSrSubrecord*		m_pQnamData;
	CSrSubrecord*		m_pQtglData;
	CSrSubrecord*		m_pEcorData;
	CSrSubrecord*		m_pAleqData;
	CSrSubrecord*		m_pAldnData;
	CSrSubrecord*		m_pCnamData;
	CSrSubrecord*		m_pSctxData;



  /*---------- Begin Protected Class Methods --------------------*/
protected:


  /*---------- Begin Public Class Methods -----------------------*/
public:

	/* Class Constructors/Destructors */
  CSrQustRecord();
  virtual void Destroy (void);

    	/* Return a new instance of the class */
  static CSrRecord* Create (void) { return new CSrQustRecord; }

	/* Get class members */
  

	/* Initialize a new record */
  void InitializeNew (void);

	/* Called to alert record of a new subrecord being added */
  virtual void OnAddSubrecord    (CSrSubrecord* pSubrecord);
  virtual void OnDeleteSubrecord (CSrSubrecord* pSubrecord);


  /* Begin field method definitions */


};
/*===========================================================================
 *		End of Class CSrQustRecord Definition
 *=========================================================================*/


#endif
/*===========================================================================
 *		End of File SrQustRecord.H
 *=========================================================================*/

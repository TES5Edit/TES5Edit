/*===========================================================================
 *
 * File:		SrFactrecord.H
 * Author:		Dave Humphrey (dave@uesp.net)
 * Created On:	5 December 2011
 *
 * Defines the CSrFactRecord class.
 *
 *=========================================================================*/
#ifndef __SRFACTRECORD_H
#define __SRFACTRECORD_H


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
 * Begin Class CSrFactRecord Definition
 *
 *=========================================================================*/
class CSrFactRecord : public CSrIdRecord 
{
  DECLARE_SRSUBRECCREATE()
  DECLARE_SRFIELDMAP()
  DECLARE_SRCLASS(CSrFactRecord, CSrIdRecord)

  /*---------- Begin Protected Class Members --------------------*/
protected:
  	CSrSubrecord*		m_pFnamData;
	CSrSubrecord*		m_pVencData;
	CSrSubrecord*		m_pJoutData;
	CSrSubrecord*		m_pXnamData;
	CSrSubrecord*		m_pDataData;
	CSrSubrecord*		m_pVenvData;
	CSrSubrecord*		m_pCrvaData;
	CSrSubrecord*		m_pWaitData;
	CSrSubrecord*		m_pPlvdData;
	CSrSubrecord*		m_pFullData;
	CSrSubrecord*		m_pVendData;
	CSrSubrecord*		m_pStolData;
	CSrSubrecord*		m_pPlcnData;
	CSrSubrecord*		m_pCrgrData;
	CSrSubrecord*		m_pRnamData;
	CSrSubrecord*		m_pMnamData;
	CSrSubrecord*		m_pJailData;
	CSrSubrecord*		m_pCitcData;
	CSrSubrecord*		m_pCtdaData;
	CSrSubrecord*		m_pCis2Data;


  /*---------- Begin Protected Class Methods --------------------*/
protected:


  /*---------- Begin Public Class Methods -----------------------*/
public:

	/* Class Constructors/Destructors */
  CSrFactRecord();
  virtual void Destroy (void);

    	/* Return a new instance of the class */
  static CSrRecord* Create (void) { return new CSrFactRecord; }

	/* Get class members */
  

	/* Initialize a new record */
  void InitializeNew (void);

	/* Called to alert record of a new subrecord being added */
  virtual void OnAddSubrecord    (CSrSubrecord* pSubrecord);
  virtual void OnDeleteSubrecord (CSrSubrecord* pSubrecord);


  /* Begin field method definitions */


};
/*===========================================================================
 *		End of Class CSrFactRecord Definition
 *=========================================================================*/


#endif
/*===========================================================================
 *		End of File SrFactRecord.H
 *=========================================================================*/

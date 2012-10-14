/*===========================================================================
 *
 * File:		SrRefrrecord.H
 * Author:		Dave Humphrey (dave@uesp.net)
 * Created On:	5 December 2011
 *
 * Defines the CSrRefrRecord class.
 *
 *=========================================================================*/
#ifndef __SRREFRRECORD_H
#define __SRREFRRECORD_H


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
 * Begin Class CSrRefrRecord Definition
 *
 *=========================================================================*/
class CSrRefrRecord : public CSrIdRecord 
{
  DECLARE_SRSUBRECCREATE()
  DECLARE_SRFIELDMAP()
  DECLARE_SRCLASS(CSrRefrRecord, CSrIdRecord)

  /*---------- Begin Protected Class Members --------------------*/
protected:
  	CSrSubrecord*		m_pFnamData;
	CSrSubrecord*		m_pXsclData;
	CSrSubrecord*		m_pXczaData;
	CSrSubrecord*		m_pXrgdData;
	CSrSubrecord*		m_pNameData;
	CSrSubrecord*		m_pXtelData;
	CSrSubrecord*		m_pXrmrData;
	CSrSubrecord*		m_pDataData;
	CSrSubrecord*		m_pVmadData;
	CSrSubrecord*		m_pXlrmData;
	CSrSubrecord*		m_pXprmData;
	CSrSubrecord*		m_pXndpData;
	CSrSubrecord*		m_pXcvlData;
	CSrSubrecord*		m_pXmboData;
	CSrSubrecord*		m_pXhtwData;
	CSrSubrecord*		m_pXltwData;
	CSrSubrecord*		m_pXprdData;
	CSrSubrecord*		m_pXlrtData;
	CSrSubrecord*		m_pXlibData;
	CSrSubrecord*		m_pXppaData;
	CSrSubrecord*		m_pInamData;
	CSrSubrecord*		m_pXaprData;
	CSrSubrecord*		m_pXactData;
	CSrSubrecord*		m_pPdtoData;
	CSrSubrecord*		m_pXspcData;
	CSrSubrecord*		m_pXlocData;
	CSrSubrecord*		m_pXemiData;
	CSrSubrecord*		m_pXespData;
	CSrSubrecord*		m_pXfvcData;
	CSrSubrecord*		m_pXapdData;
	CSrSubrecord*		m_pXpodData;
	CSrSubrecord*		m_pXlkrData;
	CSrSubrecord*		m_pXrdsData;
	CSrSubrecord*		m_pXligData;
	CSrSubrecord*		m_pXalpData;
	CSrSubrecord*		m_pXownData;
	CSrSubrecord*		m_pXeznData;
	CSrSubrecord*		m_pXmbrData;
	CSrSubrecord*		m_pXtriData;
	CSrSubrecord*		m_pOnamData;
	CSrSubrecord*		m_pXtnmData;
	CSrSubrecord*		m_pXrnkData;
	CSrSubrecord*		m_pXlcmData;
	CSrSubrecord*		m_pXczcData;
	CSrSubrecord*		m_pSctxData;
	CSrSubrecord*		m_pLnamData;
	CSrSubrecord*		m_pXcntData;
	CSrSubrecord*		m_pXwcuData;
	CSrSubrecord*		m_pXpwrData;
	CSrSubrecord*		m_pXis2Data;
	CSrSubrecord*		m_pXocpData;
	CSrSubrecord*		m_pXmbpData;
	CSrSubrecord*		m_pXrgbData;
	CSrSubrecord*		m_pXlcnData;
	CSrSubrecord*		m_pFullData;
	CSrSubrecord*		m_pXwcnData;
	CSrSubrecord*		m_pSchrData;
	CSrSubrecord*		m_pXmrkData;
	CSrSubrecord*		m_pTnamData;



  /*---------- Begin Protected Class Methods --------------------*/
protected:


  /*---------- Begin Public Class Methods -----------------------*/
public:

	/* Class Constructors/Destructors */
  CSrRefrRecord();
  virtual void Destroy (void);

    	/* Return a new instance of the class */
  static CSrRecord* Create (void) { return new CSrRefrRecord; }

	/* Get class members */
  

	/* Initialize a new record */
  void InitializeNew (void);

	/* Called to alert record of a new subrecord being added */
  virtual void OnAddSubrecord    (CSrSubrecord* pSubrecord);
  virtual void OnDeleteSubrecord (CSrSubrecord* pSubrecord);


  /* Begin field method definitions */


};
/*===========================================================================
 *		End of Class CSrRefrRecord Definition
 *=========================================================================*/


#endif
/*===========================================================================
 *		End of File SrRefrRecord.H
 *=========================================================================*/

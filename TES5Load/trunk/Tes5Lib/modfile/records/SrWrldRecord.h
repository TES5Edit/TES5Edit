/*===========================================================================
 *
 * File:		SrWrldrecord.H
 * Author:		Dave Humphrey (dave@uesp.net)
 * Created On:	5 December 2011
 *
 * Defines the CSrWrldRecord class.
 *
 *=========================================================================*/
#ifndef __SRWRLDRECORD_H
#define __SRWRLDRECORD_H


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
 * Begin Class CSrWrldRecord Definition
 *
 *=========================================================================*/
class CSrWrldRecord : public CSrIdRecord 
{
  DECLARE_SRSUBRECCREATE()
  DECLARE_SRFIELDMAP()
  DECLARE_SRCLASS(CSrWrldRecord, CSrIdRecord)

  /*---------- Begin Protected Class Members --------------------*/
protected:
  	CSrSubrecord*		m_pOfstData;
	CSrSubrecord*		m_pNam4Data;
	CSrSubrecord*		m_pRnamData;
	CSrSubrecord*		m_pCnamData;
	CSrSubrecord*		m_pXlcnData;
	CSrSubrecord*		m_pFullData;
	CSrSubrecord*		m_pNam2Data;
	CSrSubrecord*		m_pMnamData;
	CSrSubrecord*		m_pNam3Data;
	CSrSubrecord*		m_pWctrData;
	CSrSubrecord*		m_pDnamData;
	CSrSubrecord*		m_pNam0Data;
	CSrSubrecord*		m_pOnamData;
	CSrSubrecord*		m_pWnamData;
	CSrSubrecord*		m_pNamaData;
	CSrSubrecord*		m_pDataData;
	CSrSubrecord*		m_pNam9Data;
	CSrSubrecord*		m_pZnamData;
	CSrSubrecord*		m_pTnamData;
	CSrSubrecord*		m_pUnamData;
	CSrSubrecord*		m_pPnamData;
	CSrSubrecord*		m_pMhdtData;
	CSrSubrecord*		m_pXxxxData;
	CSrSubrecord*		m_pLtmpData;
	CSrSubrecord*		m_pXeznData;


  /*---------- Begin Protected Class Methods --------------------*/
protected:


  /*---------- Begin Public Class Methods -----------------------*/
public:

	/* Class Constructors/Destructors */
  CSrWrldRecord();
  virtual void Destroy (void);

    	/* Return a new instance of the class */
  static CSrRecord* Create (void) { return new CSrWrldRecord; }

	/* Get class members */
  

	/* Initialize a new record */
  void InitializeNew (void);

	/* Called to alert record of a new subrecord being added */
  virtual void OnAddSubrecord    (CSrSubrecord* pSubrecord);
  virtual void OnDeleteSubrecord (CSrSubrecord* pSubrecord);


  /* Begin field method definitions */


};
/*===========================================================================
 *		End of Class CSrWrldRecord Definition
 *=========================================================================*/


#endif
/*===========================================================================
 *		End of File SrWrldRecord.H
 *=========================================================================*/

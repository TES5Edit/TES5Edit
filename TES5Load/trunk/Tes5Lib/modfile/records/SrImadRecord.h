/*===========================================================================
 *
 * File:		SrImadrecord.H
 * Author:		Dave Humphrey (dave@uesp.net)
 * Created On:	5 December 2011
 *
 * Defines the CSrImadRecord class.
 *
 *=========================================================================*/
#ifndef __SRIMADRECORD_H
#define __SRIMADRECORD_H


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
 * Begin Class CSrImadRecord Definition
 *
 *=========================================================================*/
class CSrImadRecord : public CSrIdRecord 
{
  DECLARE_SRSUBRECCREATE()
  DECLARE_SRFIELDMAP()
  DECLARE_SRCLASS(CSrImadRecord, CSrIdRecord)

  /*---------- Begin Protected Class Members --------------------*/
protected:
  	CSrSubrecord*		m_pVnamData;
	CSrSubrecord*		m_pNam1Data;
	CSrSubrecord*		m_pTnamData;
	CSrSubrecord*		m_pDnamData;
	CSrSubrecord*		m_pRnamData;
	CSrSubrecord*		m_pBnamData;
	CSrSubrecord*		m_pUnamData;
	CSrSubrecord*		m_pPiadData;
		//Deleted
	CSrSubrecord*		m_pNam3Data;
	CSrSubrecord*		m_pSnamData;
	CSrSubrecord*		m_pYnamData;
	CSrSubrecord*		m_pNam2Data;
	CSrSubrecord*		m_pWnamData;
	CSrSubrecord*		m_pXnamData;
	CSrSubrecord*		m_pNam4Data;
	//Deleted
	CSrSubrecord*		m_pData;
	CSrSubrecord*		m_pAiadData;
	//Deleted
	CSrSubrecord*		m_pBiadData;
	//Deleted
	CSrSubrecord*		m_pCiadData;
	//Deleted
	CSrSubrecord*		m_pDiadData;
	//Deleted
	CSrSubrecord*		m_pEiadData;
	//Deleted
	CSrSubrecord*		m_pFiadData;
	//Deleted
	CSrSubrecord*		m_pGiadData;
	//Deleted
	CSrSubrecord*		m_pHiadData;
	//Deleted
	CSrSubrecord*		m_pIiadData;
	//Deleted
	CSrSubrecord*		m_pJiadData;
	//Deleted
	CSrSubrecord*		m_pKiadData;
	//Deleted
	CSrSubrecord*		m_pLiadData;
	//Deleted
	CSrSubrecord*		m_pMiadData;
	//Deleted
	CSrSubrecord*		m_pNiadData;
	//Deleted
	CSrSubrecord*		m_pOiadData;
	//Deleted
	CSrSubrecord*		m_pQiadData;
	//Deleted
	CSrSubrecord*		m_pRiadData;
	//Deleted
	CSrSubrecord*		m_pSiadData;
	//Deleted
	CSrSubrecord*		m_pTiadData;
	//Deleted



  /*---------- Begin Protected Class Methods --------------------*/
protected:


  /*---------- Begin Public Class Methods -----------------------*/
public:

	/* Class Constructors/Destructors */
  CSrImadRecord();
  virtual void Destroy (void);

    	/* Return a new instance of the class */
  static CSrRecord* Create (void) { return new CSrImadRecord; }

	/* Get class members */
  

	/* Initialize a new record */
  void InitializeNew (void);

	/* Called to alert record of a new subrecord being added */
  virtual void OnAddSubrecord    (CSrSubrecord* pSubrecord);
  virtual void OnDeleteSubrecord (CSrSubrecord* pSubrecord);


  /* Begin field method definitions */


};
/*===========================================================================
 *		End of Class CSrImadRecord Definition
 *=========================================================================*/


#endif
/*===========================================================================
 *		End of File SrImadRecord.H
 *=========================================================================*/

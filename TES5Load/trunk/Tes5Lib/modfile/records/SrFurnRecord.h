/*===========================================================================
 *
 * File:		SrFurnrecord.H
 * Author:		Dave Humphrey (dave@uesp.net)
 * Created On:	5 December 2011
 *
 * Defines the CSrFurnRecord class.
 *
 *=========================================================================*/
#ifndef __SRFURNRECORD_H
#define __SRFURNRECORD_H


/*===========================================================================
 *
 * Begin Required Includes
 *
 *=========================================================================*/
	#include "sritem1record.h"
	#include "../subrecords/srvmadsubrecord.h"
/*===========================================================================
 *		End of Required Includes
 *=========================================================================*/


/*===========================================================================
 *
 * Begin Class CSrFurnRecord Definition
 *
 *=========================================================================*/
class CSrFurnRecord : public CSrItem1Record 
{
  DECLARE_SRSUBRECCREATE()
  DECLARE_SRFIELDMAP()
  DECLARE_SRCLASS(CSrFurnRecord, CSrItem1Record)

  /*---------- Begin Protected Class Members --------------------*/
protected:
  	CSrSubrecord*		m_pFnmkData;
	CSrSubrecord*		m_pFnamData;
	CSrSubrecord*		m_pKnamData;
	CSrSubrecord*		m_pModtData;
	CSrSubrecord*		m_pPnamData;
	CSrSubrecord*		m_pMnamData;
	CSrSubrecord*		m_pWbdtData;
	CSrSubrecord*		m_pFnprData;
	CSrSubrecord*		m_pEnamData;
	CSrSubrecord*		m_pNam0Data;
	CSrSubrecord*		m_pDestData;
	CSrVmadSubrecord*	m_pVmadData;
	CSrSubrecord*		m_pXmrkData;
	CSrSubrecord*		m_pModsData;
	CSrSubrecord*		m_pDstdData;
	CSrSubrecord*		m_pDstfData;


  /*---------- Begin Protected Class Methods --------------------*/
protected:


  /*---------- Begin Public Class Methods -----------------------*/
public:

	/* Class Constructors/Destructors */
  CSrFurnRecord();
  virtual void Destroy (void);

    	/* Return a new instance of the class */
  static CSrRecord* Create (void) { return new CSrFurnRecord; }

	/* Get class members */
  

	/* Initialize a new record */
  void InitializeNew (void);

	/* Called to alert record of a new subrecord being added */
  virtual void OnAddSubrecord    (CSrSubrecord* pSubrecord);
  virtual void OnDeleteSubrecord (CSrSubrecord* pSubrecord);


  /* Begin field method definitions */


};
/*===========================================================================
 *		End of Class CSrFurnRecord Definition
 *=========================================================================*/


#endif
/*===========================================================================
 *		End of File SrFurnRecord.H
 *=========================================================================*/

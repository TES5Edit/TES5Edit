/*===========================================================================
 *
 * File:		SrLctnrecord.H
 * Author:		Dave Humphrey (dave@uesp.net)
 * Created On:	5 December 2011
 *
 * Defines the CSrLctnRecord class.
 *
 *=========================================================================*/
#ifndef __SRLCTNRECORD_H
#define __SRLCTNRECORD_H


/*===========================================================================
 *
 * Begin Required Includes
 *
 *=========================================================================*/
  #include "sritem1record.h"
/*===========================================================================
 *		End of Required Includes
 *=========================================================================*/


/*===========================================================================
 *
 * Begin Class CSrLctnRecord Definition
 *
 *=========================================================================*/
class CSrLctnRecord : public CSrItem1Record 
{
  DECLARE_SRSUBRECCREATE()
  DECLARE_SRFIELDMAP()
  DECLARE_SRCLASS(CSrLctnRecord, CSrItem1Record)

  /*---------- Begin Protected Class Members --------------------*/
protected:
  	CSrSubrecord*		m_pFnamData;
	CSrSubrecord*		m_pRnamData;
	CSrSubrecord*		m_pLcsrData;
	CSrSubrecord*		m_pLcecData;
	CSrSubrecord*		m_pCnamData;
	CSrSubrecord*		m_pLcprData;
	CSrSubrecord*		m_pPnamData;
	CSrSubrecord*		m_pLcidData;
	CSrSubrecord*		m_pMnamData;
	CSrSubrecord*		m_pNam1Data;
	CSrSubrecord*		m_pLcepData;
	CSrSubrecord*		m_pLcunData;
	CSrSubrecord*		m_pNam0Data;


  /*---------- Begin Protected Class Methods --------------------*/
protected:


  /*---------- Begin Public Class Methods -----------------------*/
public:

	/* Class Constructors/Destructors */
  CSrLctnRecord();
  virtual void Destroy (void);

    	/* Return a new instance of the class */
  static CSrRecord* Create (void) { return new CSrLctnRecord; }

	/* Get class members */
  

	/* Initialize a new record */
  void InitializeNew (void);

	/* Called to alert record of a new subrecord being added */
  virtual void OnAddSubrecord    (CSrSubrecord* pSubrecord);
  virtual void OnDeleteSubrecord (CSrSubrecord* pSubrecord);


  /* Begin field method definitions */


};
/*===========================================================================
 *		End of Class CSrLctnRecord Definition
 *=========================================================================*/


#endif
/*===========================================================================
 *		End of File SrLctnRecord.H
 *=========================================================================*/

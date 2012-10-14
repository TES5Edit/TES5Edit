/*===========================================================================
 *
 * File:		SrBptdrecord.H
 * Author:		Dave Humphrey (dave@uesp.net)
 * Created On:	5 December 2011
 *
 * Defines the CSrBptdRecord class.
 *
 *=========================================================================*/
#ifndef __SRBPTDRECORD_H
#define __SRBPTDRECORD_H


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
 * Begin Class CSrBptdRecord Definition
 *
 *=========================================================================*/
class CSrBptdRecord : public CSrIdRecord 
{
  DECLARE_SRSUBRECCREATE()
  DECLARE_SRFIELDMAP()
  DECLARE_SRCLASS(CSrBptdRecord, CSrIdRecord)

  /*---------- Begin Protected Class Members --------------------*/
protected:
  	CSrSubrecord*		m_pModlData;
	CSrSubrecord*		m_pNam1Data;
	CSrSubrecord*		m_pBpntData;
	CSrSubrecord*		m_pBptnData;
	CSrSubrecord*		m_pModtData;
	CSrSubrecord*		m_pBpniData;
	CSrSubrecord*		m_pBpnnData;
	CSrSubrecord*		m_pBpndData;
	CSrSubrecord*		m_pNam4Data;
	CSrSubrecord*		m_pNam5Data;


  /*---------- Begin Protected Class Methods --------------------*/
protected:


  /*---------- Begin Public Class Methods -----------------------*/
public:

	/* Class Constructors/Destructors */
  CSrBptdRecord();
  virtual void Destroy (void);

    	/* Return a new instance of the class */
  static CSrRecord* Create (void) { return new CSrBptdRecord; }

	/* Get class members */
  

	/* Initialize a new record */
  void InitializeNew (void);

	/* Called to alert record of a new subrecord being added */
  virtual void OnAddSubrecord    (CSrSubrecord* pSubrecord);
  virtual void OnDeleteSubrecord (CSrSubrecord* pSubrecord);


  /* Begin field method definitions */


};
/*===========================================================================
 *		End of Class CSrBptdRecord Definition
 *=========================================================================*/


#endif
/*===========================================================================
 *		End of File SrBptdRecord.H
 *=========================================================================*/

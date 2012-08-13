/*===========================================================================
 *
 * File:		SrLandrecord.H
 * Author:		Dave Humphrey (dave@uesp.net)
 * Created On:	5 December 2011
 *
 * Defines the CSrLandRecord class.
 *
 *=========================================================================*/
#ifndef __SRLANDRECORD_H
#define __SRLANDRECORD_H


/*===========================================================================
 *
 * Begin Required Includes
 *
 *=========================================================================*/
  #include "srrecord.h"
/*===========================================================================
 *		End of Required Includes
 *=========================================================================*/


/*===========================================================================
 *
 * Begin Class CSrLandRecord Definition
 *
 *=========================================================================*/
class CSrLandRecord : public CSrRecord 
{
  DECLARE_SRSUBRECCREATE()
  DECLARE_SRFIELDMAP()
  DECLARE_SRCLASS(CSrLandRecord, CSrRecord)

  /*---------- Begin Protected Class Members --------------------*/
protected:
  	CSrSubrecord*		m_pDataData;
	CSrSubrecord*		m_pVtxtData;
	CSrSubrecord*		m_pVhgtData;
	CSrSubrecord*		m_pVnmlData;
	CSrSubrecord*		m_pBtxtData;
	CSrSubrecord*		m_pVclrData;
	CSrSubrecord*		m_pAtxtData;



  /*---------- Begin Protected Class Methods --------------------*/
protected:


  /*---------- Begin Public Class Methods -----------------------*/
public:

	/* Class Constructors/Destructors */
  CSrLandRecord();
  virtual void Destroy (void);

    	/* Return a new instance of the class */
  static CSrRecord* Create (void) { return new CSrLandRecord; }

	/* Get class members */
  

	/* Initialize a new record */
  void InitializeNew (void);

	/* Called to alert record of a new subrecord being added */
  virtual void OnAddSubrecord    (CSrSubrecord* pSubrecord);
  virtual void OnDeleteSubrecord (CSrSubrecord* pSubrecord);


  /* Begin field method definitions */


};
/*===========================================================================
 *		End of Class CSrLandRecord Definition
 *=========================================================================*/


#endif
/*===========================================================================
 *		End of File SrLandRecord.H
 *=========================================================================*/

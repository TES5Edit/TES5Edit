/*===========================================================================
 *
 * File:		SrDoorrecord.H
 * Author:		Dave Humphrey (dave@uesp.net)
 * Created On:	5 December 2011
 *
 * Defines the CSrDoorRecord class.
 *
 *=========================================================================*/
#ifndef __SRDOORRECORD_H
#define __SRDOORRECORD_H


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
 * Begin Class CSrDoorRecord Definition
 *
 *=========================================================================*/
class CSrDoorRecord : public CSrIdRecord 
{
  DECLARE_SRSUBRECCREATE()
  DECLARE_SRFIELDMAP()
  DECLARE_SRCLASS(CSrDoorRecord, CSrIdRecord)

  /*---------- Begin Protected Class Members --------------------*/
protected:
  	CSrSubrecord*		m_pModlData;
	CSrSubrecord*		m_pFnamData;
	CSrSubrecord*		m_pVmadData;
	CSrSubrecord*		m_pSnamData;
	CSrSubrecord*		m_pFullData;
	CSrSubrecord*		m_pModtData;
	CSrSubrecord*		m_pAnamData;
	CSrSubrecord*		m_pModsData;


  /*---------- Begin Protected Class Methods --------------------*/
protected:


  /*---------- Begin Public Class Methods -----------------------*/
public:

	/* Class Constructors/Destructors */
  CSrDoorRecord();
  virtual void Destroy (void);

    	/* Return a new instance of the class */
  static CSrRecord* Create (void) { return new CSrDoorRecord; }

	/* Get class members */
  

	/* Initialize a new record */
  void InitializeNew (void);

	/* Called to alert record of a new subrecord being added */
  virtual void OnAddSubrecord    (CSrSubrecord* pSubrecord);
  virtual void OnDeleteSubrecord (CSrSubrecord* pSubrecord);


  /* Begin field method definitions */


};
/*===========================================================================
 *		End of Class CSrDoorRecord Definition
 *=========================================================================*/


#endif
/*===========================================================================
 *		End of File SrDoorRecord.H
 *=========================================================================*/

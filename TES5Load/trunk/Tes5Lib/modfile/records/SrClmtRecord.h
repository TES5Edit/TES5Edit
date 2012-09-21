/*===========================================================================
 *
 * File:		SrClmtrecord.H
 * Author:		Dave Humphrey (dave@uesp.net)
 * Created On:	5 December 2011
 *
 * Defines the CSrClmtRecord class.
 *
 *=========================================================================*/
#ifndef __SRCLMTRECORD_H
#define __SRCLMTRECORD_H


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
 * Begin Class CSrClmtRecord Definition
 *
 *=========================================================================*/
class CSrClmtRecord : public CSrIdRecord 
{
  DECLARE_SRSUBRECCREATE()
  DECLARE_SRFIELDMAP()
  DECLARE_SRCLASS(CSrClmtRecord, CSrIdRecord)

  /*---------- Begin Protected Class Members --------------------*/
protected:
  	CSrSubrecord*		m_pModlData;
	CSrSubrecord*		m_pFnamData;
	CSrSubrecord*		m_pWlstData;
	CSrSubrecord*		m_pGnamData;
	CSrSubrecord*		m_pTnamData;
	CSrSubrecord*		m_pModtData;


  /*---------- Begin Protected Class Methods --------------------*/
protected:


  /*---------- Begin Public Class Methods -----------------------*/
public:

	/* Class Constructors/Destructors */
  CSrClmtRecord();
  virtual void Destroy (void);

    	/* Return a new instance of the class */
  static CSrRecord* Create (void) { return new CSrClmtRecord; }

	/* Get class members */
  

	/* Initialize a new record */
  void InitializeNew (void);

	/* Called to alert record of a new subrecord being added */
  virtual void OnAddSubrecord    (CSrSubrecord* pSubrecord);
  virtual void OnDeleteSubrecord (CSrSubrecord* pSubrecord);


  /* Begin field method definitions */


};
/*===========================================================================
 *		End of Class CSrClmtRecord Definition
 *=========================================================================*/


#endif
/*===========================================================================
 *		End of File SrClmtRecord.H
 *=========================================================================*/

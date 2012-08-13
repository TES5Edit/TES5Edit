/*===========================================================================
 *
 * File:		SrIdlmrecord.H
 * Author:		Dave Humphrey (dave@uesp.net)
 * Created On:	5 December 2011
 *
 * Defines the CSrIdlmRecord class.
 *
 *=========================================================================*/
#ifndef __SRIDLMRECORD_H
#define __SRIDLMRECORD_H


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
 * Begin Class CSrIdlmRecord Definition
 *
 *=========================================================================*/
class CSrIdlmRecord : public CSrIdRecord 
{
  DECLARE_SRSUBRECCREATE()
  DECLARE_SRFIELDMAP()
  DECLARE_SRCLASS(CSrIdlmRecord, CSrIdRecord)

  /*---------- Begin Protected Class Members --------------------*/
protected:
	CSrSubrecord*		m_pIdlfData;
	CSrSubrecord*		m_pIdltData;
	CSrSubrecord*		m_pIdlcData;
	CSrSubrecord*		m_pIdlaData;


  /*---------- Begin Protected Class Methods --------------------*/
protected:


  /*---------- Begin Public Class Methods -----------------------*/
public:

	/* Class Constructors/Destructors */
  CSrIdlmRecord();
  virtual void Destroy (void);

    	/* Return a new instance of the class */
  static CSrRecord* Create (void) { return new CSrIdlmRecord; }

	/* Get class members */
  

	/* Initialize a new record */
  void InitializeNew (void);

	/* Called to alert record of a new subrecord being added */
  virtual void OnAddSubrecord    (CSrSubrecord* pSubrecord);
  virtual void OnDeleteSubrecord (CSrSubrecord* pSubrecord);


  /* Begin field method definitions */


};
/*===========================================================================
 *		End of Class CSrIdlmRecord Definition
 *=========================================================================*/


#endif
/*===========================================================================
 *		End of File SrIdlmRecord.H
 *=========================================================================*/

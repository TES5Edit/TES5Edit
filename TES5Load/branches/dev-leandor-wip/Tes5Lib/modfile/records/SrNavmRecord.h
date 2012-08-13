/*===========================================================================
 *
 * File:		SrNavmrecord.H
 * Author:		Dave Humphrey (dave@uesp.net)
 * Created On:	5 December 2011
 *
 * Defines the CSrNavmRecord class.
 *
 *=========================================================================*/
#ifndef __SRNAVMRECORD_H
#define __SRNAVMRECORD_H


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
 * Begin Class CSrNavmRecord Definition
 *
 *=========================================================================*/
class CSrNavmRecord : public CSrRecord 
{
  DECLARE_SRSUBRECCREATE()
  DECLARE_SRFIELDMAP()
  DECLARE_SRCLASS(CSrNavmRecord, CSrRecord)

  /*---------- Begin Protected Class Members --------------------*/
protected:
  	CSrSubrecord*		m_pOnamData;
	CSrSubrecord*		m_pXxxxData;
	CSrSubrecord*		m_pNvnmData;
	CSrSubrecord*		m_pNnamData;
	CSrSubrecord*		m_pPnamData;



  /*---------- Begin Protected Class Methods --------------------*/
protected:


  /*---------- Begin Public Class Methods -----------------------*/
public:

	/* Class Constructors/Destructors */
  CSrNavmRecord();
  virtual void Destroy (void);

    	/* Return a new instance of the class */
  static CSrRecord* Create (void) { return new CSrNavmRecord; }

	/* Get class members */
  

	/* Initialize a new record */
  void InitializeNew (void);

	/* Called to alert record of a new subrecord being added */
  virtual void OnAddSubrecord    (CSrSubrecord* pSubrecord);
  virtual void OnDeleteSubrecord (CSrSubrecord* pSubrecord);


  /* Begin field method definitions */


};
/*===========================================================================
 *		End of Class CSrNavmRecord Definition
 *=========================================================================*/


#endif
/*===========================================================================
 *		End of File SrNavmRecord.H
 *=========================================================================*/

/*===========================================================================
 *
 * File:		SrCstyrecord.H
 * Author:		Dave Humphrey (dave@uesp.net)
 * Created On:	5 December 2011
 *
 * Defines the CSrCstyRecord class.
 *
 *=========================================================================*/
#ifndef __SRCSTYRECORD_H
#define __SRCSTYRECORD_H


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
 * Begin Class CSrCstyRecord Definition
 *
 *=========================================================================*/
class CSrCstyRecord : public CSrIdRecord 
{
  DECLARE_SRSUBRECCREATE()
  DECLARE_SRFIELDMAP()
  DECLARE_SRCLASS(CSrCstyRecord, CSrIdRecord)

  /*---------- Begin Protected Class Members --------------------*/
protected:
	CSrSubrecord*		m_pCsgdData;
	CSrSubrecord*		m_pCsmeData;
	CSrSubrecord*		m_pDataData;
	CSrSubrecord*		m_pCscrData;
	CSrSubrecord*		m_pCslrData;
	CSrSubrecord*		m_pCsflData;
	CSrSubrecord*		m_pCsmdData;


  /*---------- Begin Protected Class Methods --------------------*/
protected:


  /*---------- Begin Public Class Methods -----------------------*/
public:

	/* Class Constructors/Destructors */
  CSrCstyRecord();
  virtual void Destroy (void);

    	/* Return a new instance of the class */
  static CSrRecord* Create (void) { return new CSrCstyRecord; }

	/* Get class members */
  

	/* Initialize a new record */
  void InitializeNew (void);

	/* Called to alert record of a new subrecord being added */
  virtual void OnAddSubrecord    (CSrSubrecord* pSubrecord);
  virtual void OnDeleteSubrecord (CSrSubrecord* pSubrecord);


  /* Begin field method definitions */


};
/*===========================================================================
 *		End of Class CSrCstyRecord Definition
 *=========================================================================*/


#endif
/*===========================================================================
 *		End of File SrCstyRecord.H
 *=========================================================================*/

/*===========================================================================
 *
 * File:		SrMesgrecord.H
 * Author:		Dave Humphrey (dave@uesp.net)
 * Created On:	5 December 2011
 *
 * Defines the CSrMesgRecord class.
 *
 *=========================================================================*/
#ifndef __SRMESGRECORD_H
#define __SRMESGRECORD_H


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
 * Begin Class CSrMesgRecord Definition
 *
 *=========================================================================*/
class CSrMesgRecord : public CSrIdRecord 
{
  DECLARE_SRSUBRECCREATE()
  DECLARE_SRFIELDMAP()
  DECLARE_SRCLASS(CSrMesgRecord, CSrIdRecord)

  /*---------- Begin Protected Class Members --------------------*/
protected:
  	CSrSubrecord*		m_pItxtData;
	CSrSubrecord*		m_pFullData;
	CSrSubrecord*		m_pDescData;
	CSrSubrecord*		m_pCtdaData;
	CSrSubrecord*		m_pQnamData;
	CSrSubrecord*		m_pInamData;
	CSrSubrecord*		m_pTnamData;
	CSrSubrecord*		m_pDnamData;


  /*---------- Begin Protected Class Methods --------------------*/
protected:


  /*---------- Begin Public Class Methods -----------------------*/
public:

	/* Class Constructors/Destructors */
  CSrMesgRecord();
  virtual void Destroy (void);

    	/* Return a new instance of the class */
  static CSrRecord* Create (void) { return new CSrMesgRecord; }

	/* Get class members */
  

	/* Initialize a new record */
  void InitializeNew (void);

	/* Called to alert record of a new subrecord being added */
  virtual void OnAddSubrecord    (CSrSubrecord* pSubrecord);
  virtual void OnDeleteSubrecord (CSrSubrecord* pSubrecord);


  /* Begin field method definitions */


};
/*===========================================================================
 *		End of Class CSrMesgRecord Definition
 *=========================================================================*/


#endif
/*===========================================================================
 *		End of File SrMesgRecord.H
 *=========================================================================*/

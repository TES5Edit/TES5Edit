/*===========================================================================
 *
 * File:		SrExplrecord.H
 * Author:		Dave Humphrey (dave@uesp.net)
 * Created On:	5 December 2011
 *
 * Defines the CSrExplRecord class.
 *
 *=========================================================================*/
#ifndef __SREXPLRECORD_H
#define __SREXPLRECORD_H


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
 * Begin Class CSrExplRecord Definition
 *
 *=========================================================================*/
class CSrExplRecord : public CSrIdRecord 
{
  DECLARE_SRSUBRECCREATE()
  DECLARE_SRFIELDMAP()
  DECLARE_SRCLASS(CSrExplRecord, CSrIdRecord)

  /*---------- Begin Protected Class Members --------------------*/
protected:
  	CSrSubrecord*		m_pModlData;
	CSrSubrecord*		m_pModtData;
	CSrSubrecord*		m_pDataData;
	CSrSubrecord*		m_pMnamData;
	CSrSubrecord*		m_pFullData;
	CSrSubrecord*		m_pEitmData;


  /*---------- Begin Protected Class Methods --------------------*/
protected:


  /*---------- Begin Public Class Methods -----------------------*/
public:

	/* Class Constructors/Destructors */
  CSrExplRecord();
  virtual void Destroy (void);

    	/* Return a new instance of the class */
  static CSrRecord* Create (void) { return new CSrExplRecord; }

	/* Get class members */
  

	/* Initialize a new record */
  void InitializeNew (void);

	/* Called to alert record of a new subrecord being added */
  virtual void OnAddSubrecord    (CSrSubrecord* pSubrecord);
  virtual void OnDeleteSubrecord (CSrSubrecord* pSubrecord);


  /* Begin field method definitions */


};
/*===========================================================================
 *		End of Class CSrExplRecord Definition
 *=========================================================================*/


#endif
/*===========================================================================
 *		End of File SrExplRecord.H
 *=========================================================================*/

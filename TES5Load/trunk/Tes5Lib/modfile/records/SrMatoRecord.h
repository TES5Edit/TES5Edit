/*===========================================================================
 *
 * File:		SrMatorecord.H
 * Author:		Dave Humphrey (dave@uesp.net)
 * Created On:	5 December 2011
 *
 * Defines the CSrMatoRecord class.
 *
 *=========================================================================*/
#ifndef __SRMATORECORD_H
#define __SRMATORECORD_H


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
 * Begin Class CSrMatoRecord Definition
 *
 *=========================================================================*/
class CSrMatoRecord : public CSrIdRecord 
{
  DECLARE_SRSUBRECCREATE()
  DECLARE_SRFIELDMAP()
  DECLARE_SRCLASS(CSrMatoRecord, CSrIdRecord)

  /*---------- Begin Protected Class Members --------------------*/
protected:
  	CSrStringSubrecord*	m_pModlData;
	CSrSubrecord*		m_pDataData;
	CSrSubrecord*		m_pDnamData;


  /*---------- Begin Protected Class Methods --------------------*/
protected:


  /*---------- Begin Public Class Methods -----------------------*/
public:

	/* Class Constructors/Destructors */
  CSrMatoRecord();
  virtual void Destroy (void);

    	/* Return a new instance of the class */
  static CSrRecord* Create (void) { return new CSrMatoRecord; }

	/* Get class members */
  

	/* Initialize a new record */
  void InitializeNew (void);

	/* Called to alert record of a new subrecord being added */
  virtual void OnAddSubrecord    (CSrSubrecord* pSubrecord);
  virtual void OnDeleteSubrecord (CSrSubrecord* pSubrecord);


		/* Begin field method definitions */
	DECLARE_SRFIELD_STRING(CSrMatoRecord, m_pModlData, Model, SR_NAME_MODL)

};
/*===========================================================================
 *		End of Class CSrMatoRecord Definition
 *=========================================================================*/


#endif
/*===========================================================================
 *		End of File SrMatoRecord.H
 *=========================================================================*/

/*===========================================================================
 *
 * File:		SrKywdrecord.H
 * Author:		Dave Humphrey (dave@uesp.net)
 * Created On:	26 November 2011
 *
 * Defines the CSrKywdRecord class for keyword records.
 *
 *=========================================================================*/
#ifndef __SRKYWDRECORD_H
#define __SRKYWDRECORD_H


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
 * Begin Class CSrKywdRecord Definition
 *
 * Holds weapon data.
 *
 *=========================================================================*/
class CSrKywdRecord : public CSrIdRecord 
{
  DECLARE_SRSUBRECCREATE()
  DECLARE_SRFIELDMAP()
  DECLARE_SRCLASS(CSrKywdRecord, CSrIdRecord)

  /*---------- Begin Protected Class Members --------------------*/
protected:
  CSrDwordSubrecord*	m_pCName;


  /*---------- Begin Protected Class Methods --------------------*/
protected:


  /*---------- Begin Public Class Methods -----------------------*/
public:

	/* Class Constructors/Destructors */
  CSrKywdRecord();
  //virtual ~CSrKywdRecord() { Destroy(); }
  virtual void Destroy (void);

    	/* Return a new instance of the class */
  static CSrRecord* Create (void) { return new CSrKywdRecord; }

	/* Get class members */
  dword         GetCNAM      (void) { return (m_pCName ?  m_pCName->GetValue()      : 0); }

	/* Initialize a new record */
  void InitializeNew (void);

	/* Called to alert record of a new subrecord being added */
  virtual void OnAddSubrecord    (CSrSubrecord* pSubrecord);
  virtual void OnDeleteSubrecord (CSrSubrecord* pSubrecord);

  	/* Set class members */
  void SetCNAM (const dword Value);

  /* Begin field method definitions */
  DECLARE_SRFIELD(FieldCNAM)

};
/*===========================================================================
 *		End of Class CSrKywdRecord Definition
 *=========================================================================*/


/*===========================================================================
 *
 * Begin Function Definitions
 *
 *=========================================================================*/
/*===========================================================================
 *		End of Function Definitions
 *=========================================================================*/


#endif
/*===========================================================================
 *		End of File SrKywdRecord.H
 *=========================================================================*/

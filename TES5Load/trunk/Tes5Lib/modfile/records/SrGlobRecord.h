/*===========================================================================
 *
 * File:		SrGlobrecord.H
 * Author:		Dave Humphrey (dave@uesp.net)
 * Created On:	5 December 2011
 *
 * Defines the CSrGlobRecord class.
 *
 *=========================================================================*/
#ifndef __SRGLOBRECORD_H
#define __SRGLOBRECORD_H


/*===========================================================================
 *
 * Begin Required Includes
 *
 *=========================================================================*/
	#include "sridrecord.h"
	#include "../subrecords/srfloatsubrecord.h"
	#include "../subrecords/srbytesubrecord.h"
/*===========================================================================
 *		End of Required Includes
 *=========================================================================*/


/*===========================================================================
 *
 * Begin Class CSrGlobRecord Definition
 *
 *=========================================================================*/
class CSrGlobRecord : public CSrIdRecord 
{
  DECLARE_SRSUBRECCREATE()
  DECLARE_SRFIELDMAP()
  DECLARE_SRCLASS(CSrGlobRecord, CSrIdRecord)

  /*---------- Begin Protected Class Members --------------------*/
protected:
  	CSrFloatSubrecord*		m_pValue;
	CSrByteSubrecord*		m_pType;


  /*---------- Begin Protected Class Methods --------------------*/
protected:


  /*---------- Begin Public Class Methods -----------------------*/
public:

		/* Class Constructors/Destructors */
  CSrGlobRecord();
  virtual void Destroy (void);

    	/* Return a new instance of the class */
  static CSrRecord* Create (void) { return new CSrGlobRecord; }

		/* Get class members */
  float GetGlobalValue (void) const { return m_pValue ? m_pValue->GetValue() : 0.0f; }
  byte  GetGlobalType  (void) const { return m_pType  ? m_pType->GetValue()  : 'f'; }  

		/* Initialize a new record */
  void InitializeNew (void);

		/* Called to alert record of a new subrecord being added */
  virtual void OnAddSubrecord    (CSrSubrecord* pSubrecord);
  virtual void OnDeleteSubrecord (CSrSubrecord* pSubrecord);

		/* Set class members */
  void SetGlobalValue (const float Value);
  void SetGlobalType  (const byte  Value);

		/* Begin field method definitions */
  DECLARE_SRFIELD(FieldValue)
  DECLARE_SRFIELD(FieldType)

};
/*===========================================================================
 *		End of Class CSrGlobRecord Definition
 *=========================================================================*/


#endif
/*===========================================================================
 *		End of File SrGlobRecord.H
 *=========================================================================*/

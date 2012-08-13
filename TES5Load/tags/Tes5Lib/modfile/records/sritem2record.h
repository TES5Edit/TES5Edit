/*===========================================================================
 *
 * File:		Sritem2record.H
 * Author:		Dave Humphrey (dave@uesp.net)
 * Created On:	26 November 2011
 *
 * Defines the CSrItem2Record class for records with:
 *
 *	ANAM - Enchantment pts
 *	EITM - Enchantment formid
 *
 * In addition to all standard CSrItem1Record subrecords.
 *
 *=========================================================================*/
#ifndef __OBITEM2RECORD_H
#define __OBITEM2RECORD_H


/*===========================================================================
 *
 * Begin Required Includes
 *
 *=========================================================================*/
  #include "sritem1record.h"
  #include "../subrecords/srdwordsubrecord.h"
  #include "../subrecords/srwordsubrecord.h"
/*===========================================================================
 *		End of Required Includes
 *=========================================================================*/


/*===========================================================================
 *
 * Begin Class CSrItem2Record Definition
 *
 *=========================================================================*/
class CSrItem2Record : public CSrItem1Record {
  DECLARE_SRSUBRECCREATE()
  DECLARE_SRFIELDMAP()
  DECLARE_SRCLASS(CSrItem2Record, CSrItem1Record)

  /*---------- Begin Protected Class Members --------------------*/
protected:
  CSrFormidSubrecord*	m_pEnchantment;
  CSrWordSubrecord*		m_pEnchantPoints;

  CSString				m_CachedEnchantID;


  /*---------- Begin Protected Class Methods --------------------*/
protected:


  /*---------- Begin Public Class Methods -----------------------*/
public:

	/* Class Constructors/Destructors */
  CSrItem2Record();
  //virtual ~CSrItem2Record() { Destroy(); }
  virtual void Destroy (void);

  	/* Return a new instance of the class */
  static CSrRecord* Create (void) { return new CSrItem2Record; }

	/* Get class members */
  srformid_t    GetEnchantment     (void) { return (m_pEnchantment   ? m_pEnchantment->GetValue()   : SR_FORMID_NULL); }
  word          GetEnchantPoints   (void) { return (m_pEnchantPoints ? m_pEnchantPoints->GetValue() : 0); }
  const SSCHAR* GetEnchantEditorID (void);
  
	/* Initialize a new record */
  void InitializeNew (void);

	/* Called to alert record of a new subrecord being added */
  virtual void OnAddSubrecord    (CSrSubrecord* pSubrecord);
  virtual void OnDeleteSubrecord (CSrSubrecord* pSubrecord);

	/* Set class members */
  void SetEnchantment   (const srformid_t FormID);
  void SetEnchantPoints (const word       Points);
  
  	/* Field get methods */
  DECLARE_SRFIELD(FieldEnchantment)
  DECLARE_SRFIELD(FieldEnchantPoints)
  DECLARE_SRFIELD(FieldEnchantmentID)
};
/*===========================================================================
 *		End of Class CSrItem2Record Definition
 *=========================================================================*/


#endif
/*===========================================================================
 *		End of File Sritem2record.H
 *=========================================================================*/

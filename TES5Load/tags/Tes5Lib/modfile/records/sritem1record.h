/*===========================================================================
 *
 * File:		Sritem1record.H
 * Author:		Dave Humphrey (dave@uesp.net)
 * Created On:	26 November 2011
 *
 * Defines the CSrItem1Record class for records with:
 *
 *	FULL - Item Name
 *	MODL - Model filename
 *	ICON - ICON filename
 *
 *=========================================================================*/
#ifndef __SRITEM1RECORD_H
#define __SRITEM1RECORD_H


/*===========================================================================
 *
 * Begin Required Includes
 *
 *=========================================================================*/
  #include "sridkeyrecord.h"
  #include "../subrecords/srdwordsubrecord.h"
  #include "../subrecords/srformidsubrecord.h"
  #include "../subrecords/srlstringsubrecord.h"
/*===========================================================================
 *		End of Required Includes
 *=========================================================================*/


/*===========================================================================
 *
 * Begin Type Definitions
 *
 *=========================================================================*/

/*===========================================================================
 *		End of Type Definitions
 *=========================================================================*/


/*===========================================================================
 *
 * Begin Class CSrItem1Record Definition
 *
 * Holds enchantment data.
 *
 *=========================================================================*/
class CSrItem1Record : public CSrIdKeyRecord 
{
  DECLARE_SRSUBRECCREATE()
  DECLARE_SRFIELDMAP()
  DECLARE_SRCLASS(CSrItem1Record, CSrIdKeyRecord)
  
  /*---------- Begin Protected Class Members --------------------*/
protected:
  CSrLStringSubrecord*	m_pItemName;
  CSrModlSubrecord*		m_pModel;
  CSrIconSubrecord*		m_pIcon;


  /*---------- Begin Protected Class Methods --------------------*/
protected:


  /*---------- Begin Public Class Methods -----------------------*/
public:

	/* Class Constructors/Destructors */
  CSrItem1Record();
  virtual void Destroy (void);

  	/* Return a new instance of the class */
  static CSrRecord* Create (void) { return new CSrItem1Record; }

	/* Get class members */
  const SSCHAR* GetItemName (void) { return (m_pItemName ? m_pItemName->GetString().c_str() : ""); }
  const SSCHAR* GetModel    (void) { return (m_pModel    ? m_pModel->GetString().c_str()    : ""); }
  const SSCHAR* GetIcon     (void) { return (m_pIcon     ? m_pIcon->GetString().c_str()     : ""); }

	/* Used to determine if the record type has a FULL item name field */
  virtual bool HasFullItemName (void) { return (true); }

	/* Initialize a new record */
  void InitializeNew (void);

	/* Called to alert record of a new subrecord being added */
  virtual void OnAddSubrecord    (CSrSubrecord* pSubrecord);
  virtual void OnDeleteSubrecord (CSrSubrecord* pSubrecord);

	/* Set class members */
  void SetItemName (const SSCHAR* pString);
  void SetModel    (const SSCHAR* pString);
  void SetIcon     (const SSCHAR* pString);

	/* Begin field method definitions */
  DECLARE_SRFIELD(FieldItemName)
  DECLARE_SRFIELD(FieldModel)
  DECLARE_SRFIELD(FieldIcon)

};
/*===========================================================================
 *		End of Class CSrItem1Record Definition
 *=========================================================================*/



#endif
/*===========================================================================
 *		End of File Sritem1record.H
 *=========================================================================*/

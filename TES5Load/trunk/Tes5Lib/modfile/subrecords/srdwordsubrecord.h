/*===========================================================================
 *
 * File:		Srdwordsubrec.H
 * Author:		Dave Humphrey (dave@uesp.net)
 * Created On:	26 November 2011
 *
 * Defines the CSrDwordSubrecord used for storing a 32-bit dword.
 *
 *=========================================================================*/
#ifndef __SRDWORDSUBRECORD_H
#define __SRDWORDSUBRECORD_H


/*===========================================================================
 *
 * Begin Reqiured Includes
 *
 *=========================================================================*/
  #include "srsubrecord.h"
/*===========================================================================
 *		End of Reqiured Includes
 *=========================================================================*/


/*===========================================================================
 *
 * Begin Class CSrDwordSubrecord Definition
 *
 *=========================================================================*/
class CSrDwordSubrecord : public CSrSubrecord 
{
  DECLARE_SRCLASS(CSrDwordSubrecord, CSrSubrecord)

  /*---------- Begin Protected Class Members --------------------*/
protected:
  dword	m_Value;


  /*---------- Begin Protected Class Methods --------------------*/
protected:

	/* Input/output the subrecord data */
  virtual bool ReadData  (CSrFile& File) { SR_VERIFY_SUBRECORDSIZE_MAX(4) return File.Read(&m_Value, m_RecordSize); }
  virtual bool WriteData (CSrFile& File) { SR_VERIFY_SUBRECORDSIZE_MAX(4) return File.Write(&m_Value, 4); }


  /*---------- Begin Public Class Methods -----------------------*/
public:

	/* Class Constructors/Destructors */
  CSrDwordSubrecord() : m_Value(0) { m_RecordSize = 4; }
  virtual void Destroy (void) { m_Value = 0; CSrSubrecord::Destroy(); m_RecordSize = 4;  }

	/* Copy the content from an existing subrecord */
  virtual bool Copy (CSrSubrecord* pSubrecord) {
	CSrDwordSubrecord* pSubrecord1 = SrCastClassNull(CSrDwordSubrecord, pSubrecord);
	m_RecordSize = 4;

	if (pSubrecord1 != NULL) {
	  m_Value = pSubrecord1->GetValue();
	}
	else {
	  memset(&m_Value, 0, sizeof(m_Value));
	}
	return (true);
  }

	/* Create a class instance */
  static CSrSubrecord* Create (void) { return (new CSrDwordSubrecord); }
  virtual CSrSubrecord* CreateV (void) { return new CSrDwordSubrecord; }

  dword GetRecordSize (void) const { return 4 ; }

	/* Initialize a new record */
  virtual void InitializeNew (void) { CSrSubrecord::InitializeNew();  m_Value = 0; m_RecordSize = 4; }

	/* Bit flag operations */
  bool  CheckFlag (const dword Mask)                  { return CheckFlagBits(m_Value, Mask); }
  void  ClearFlag (const dword Mask)		      { m_Value &= ~Mask; }
  dword FlipFlag  (const dword Mask, const bool Flag) { FlipFlagBits(m_Value, Mask, Flag); return (m_Value); } 
  void  SetFlag   (const dword Mask)		      { m_Value |= Mask; }

	/* Get class members */
  dword         GetValue    (void) { return (m_Value); }
  dword*        GetValuePtr (void) { return (&m_Value); }
  dword&        GetValueRef (void) { return (m_Value); }
  virtual byte*	GetData     (void) { return (byte *)(&m_Value); }

  	/* Set class methods */
  void SetValue (const dword Value) { m_Value = Value; }
 
};
/*===========================================================================
 *		End of Class CSrDwordSubrecord Definition
 *=========================================================================*/


	typedef CSrDwordSubrecord CSrFullSubrecord;	/* Item name */

#endif
/*===========================================================================
 *		End of File Srwordsubrec.H
 *=========================================================================*/

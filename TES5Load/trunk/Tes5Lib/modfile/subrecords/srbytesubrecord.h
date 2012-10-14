/*===========================================================================
 *
 * File:		Srbytesubrecord.H
 * Author:		Dave Humphrey (dave@uesp.net)
 * Created On:	6 December 2011
 *
 * Defines the CSrByteSubrecord used for storing a 8-bit byte.
 *
 *=========================================================================*/
#ifndef __SRBYTESUBRECORD_H
#define __SRBYTESUBRECORD_H


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
 * Begin Class CSrByteSubrecord Definition
 *
 *=========================================================================*/
class CSrByteSubrecord : public CSrSubrecord {
  DECLARE_SRCLASS(CSrByteSubrecord, CSrSubrecord)

  /*---------- Begin Private Class Members ----------------------*/
private:
  byte	m_Value;


  /*---------- Begin Protected Class Methods --------------------*/
protected:

	/* Input/output the subrecord data */
  virtual bool ReadData  (CSrFile& File) { SR_VERIFY_SUBRECORDSIZE(1) return File.Read(&m_Value, 1); }
  virtual bool WriteData (CSrFile& File) { SR_VERIFY_SUBRECORDSIZE(1) return File.Write(&m_Value, 1); }


  /*---------- Begin Public Class Methods -----------------------*/
public:

	/* Class Constructors/Destructors */
  CSrByteSubrecord() { m_Value = 0; }
  virtual void Destroy (void) { m_Value = 0; CSrSubrecord::Destroy(); }

	/* Copy the content from an existing subrecord */
  virtual bool Copy (CSrSubrecord* pSubrecord) {
	CSrByteSubrecord* pSubrecord1 = SrCastClassNull(CSrByteSubrecord, pSubrecord);
	m_RecordSize = 1;

	if (pSubrecord1 != NULL) {
	  m_Value = pSubrecord1->GetValue();
	}
	else {
	  memset(&m_Value, 0, sizeof(m_Value));
	}
	return (true);
  }

	/* Create a class instance */
  static CSrSubrecord* Create (void) { return (new CSrByteSubrecord); }
  virtual CSrSubrecord* CreateV (void) { return new CSrByteSubrecord; }

  	/* Bit flag operations */
  bool CheckFlag (const byte Mask)                  { return CheckFlagBits(m_Value, Mask); }
  word FlipFlag  (const byte Mask, const bool Flag) { FlipFlagBits(m_Value, Mask, Flag); return (m_Value); } 

	/* Get class members */
  byte          GetValue    (void) { return (m_Value); }
  byte*         GetValuePtr (void) { return (&m_Value); }
  byte&         GetValueRef (void) { return (m_Value); }
  virtual byte*	GetData     (void) { return (byte *)(&m_Value); }
  
	/* Initialize a new record */
  virtual void InitializeNew (void) { CSrSubrecord::InitializeNew();  m_Value = 0; m_RecordSize = sizeof(byte); }

  	/* Set class methods */
  void SetValue (const byte Value) { m_Value = Value; }
 
 };
/*===========================================================================
 *		End of Class CSrByteSubrecord Definition
 *=========================================================================*/


#endif
/*===========================================================================
 *		End of File Srbytesubrecord.H
 *=========================================================================*/

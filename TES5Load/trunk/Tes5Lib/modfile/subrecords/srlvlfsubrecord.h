/*===========================================================================
 *
 * File:		SrLvlfSubrecord.H
 * Author:		Dave Humphrey (dave@uesp.net)
 * Created On:	17 December 2011
 *
 * Defines the CSrLvlfSubrecord used for storing a 8-bit flag in LVLI/LVLN/LVSP.
 *
 *=========================================================================*/
#ifndef __SRLVLFSUBRECORD_H
#define __SRLVLFSUBRECORD_H


/*===========================================================================
 *
 * Begin Reqiured Includes
 *
 *=========================================================================*/
	#include "srsubrecord.h"
/*===========================================================================
 *		End of Reqiured Includes
 *=========================================================================*/


	#define SR_LVLIFLAG_CALCULATEEACH	0x01
	#define SR_LVLIFLAG_CALCULATEALL	0x02
	#define SR_LVLIFLAG_USEALL			0x04

	#define SR_LVLO_MAXCOUNT			255


/*===========================================================================
 *
 * Begin Class CSrLvlfSubrecord Definition
 *
 *=========================================================================*/
class CSrLvlfSubrecord : public CSrSubrecord {
  DECLARE_SRCLASS(CSrLvlfSubrecord, CSrSubrecord)

  /*---------- Begin Private Class Members ----------------------*/
private:
  byte	m_Value;


  /*---------- Begin Protected Class Methods --------------------*/
protected:

	/* Input/output the subrecord data */
  virtual bool ReadData  (CSrFile& File) { if (m_RecordSize != 1) return false; return File.Read(&m_Value, 1); }
  virtual bool WriteData (CSrFile& File) { if (m_RecordSize != 1) return false; return File.Write(&m_Value, 1); }


  /*---------- Begin Public Class Methods -----------------------*/
public:

	/* Class Constructors/Destructors */
  CSrLvlfSubrecord() { m_Value = 0; }
  virtual void Destroy (void) { m_Value = 0; CSrSubrecord::Destroy(); }

	/* Copy the content from an existing subrecord */
  virtual bool Copy (CSrSubrecord* pSubrecord) {
	CSrLvlfSubrecord* pSubrecord1 = SrCastClassNull(CSrLvlfSubrecord, pSubrecord);
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
  static CSrSubrecord* Create (void) { return (new CSrLvlfSubrecord); }
  virtual CSrSubrecord* CreateV (void) { return (new CSrLvlfSubrecord); }

  	/* Bit flag operations */
  //bool CheckFlag (const byte Mask)                  { return CheckFlagBits(m_Value, Mask); }
  //word FlipFlag  (const byte Mask, const bool Flag) { FlipFlagBits(m_Value, Mask, Flag); return (m_Value); } 

	/* Get class members */
  byte          GetValue    (void) { return (m_Value); }
  byte*         GetValuePtr (void) { return (&m_Value); }
  byte&         GetValueRef (void) { return (m_Value); }
  virtual byte*	GetData     (void) { return (byte *)(&m_Value); }

	bool  IsCalculateEach (void) { return CheckFlagBits(m_Value, SR_LVLIFLAG_CALCULATEEACH); }
	bool  IsCalculateAll  (void) { return CheckFlagBits(m_Value, SR_LVLIFLAG_CALCULATEALL); }
	bool  IsUseAll        (void) { return CheckFlagBits(m_Value, SR_LVLIFLAG_USEALL); }  
  
	/* Initialize a new record */
  virtual void InitializeNew (void) { CSrSubrecord::InitializeNew();  m_Value = 0; m_RecordSize = sizeof(byte); }

  	/* Set class methods */
  void SetValue (const byte Value) { m_Value = Value; }
  void SetCalculateEach (const bool Flag) { FlipFlagBits(m_Value, SR_LVLIFLAG_CALCULATEEACH, Flag); }
  void SetCalculateAll  (const bool Flag) { FlipFlagBits(m_Value, SR_LVLIFLAG_CALCULATEALL, Flag); }
  void SetUseAll        (const bool Flag) { FlipFlagBits(m_Value, SR_LVLIFLAG_USEALL, Flag); }
 
};
/*===========================================================================
 *		End of Class CSrLvlfSubrecord Definition
 *=========================================================================*/


#endif
/*===========================================================================
 *		End of File SrLvlfSubrecord.H
 *=========================================================================*/

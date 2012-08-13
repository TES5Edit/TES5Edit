/*===========================================================================
 *
 * File:		SrLongsubrecord.H
 * Author:		Dave Humphrey (dave@uesp.net)
 * Created On:	26 November 2011
 *
 * Defines the CSrLongSubrecord used for storing a 32-bit signed integer.
 *
 *=========================================================================*/
#ifndef __SRLONGSUBRECORD_H
#define __SRLONGSUBRECORD_H


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
 * Begin Class CSrLongSubrecord Definition
 *
 *=========================================================================*/
class CSrLongSubrecord : public CSrSubrecord 
{
  DECLARE_SRCLASS(CSrLongSubrecord, CSrSubrecord)

  /*---------- Begin Protected Class Members --------------------*/
protected:
  long	m_Value;


  /*---------- Begin Protected Class Methods --------------------*/
protected:

	/* Input/output the subrecord data */
  virtual bool ReadData  (CSrFile& File) {  SR_VERIFY_SUBRECORDSIZE(4) return File.Read(&m_Value, 4); }
  virtual bool WriteData (CSrFile& File) {  SR_VERIFY_SUBRECORDSIZE(4) return File.Write(&m_Value, 4); }


  /*---------- Begin Public Class Methods -----------------------*/
public:

	/* Class Constructors/Destructors */
  CSrLongSubrecord() : m_Value(0) { }
  //virtual ~CSrLongSubrecord() { Destroy(); }
  virtual void Destroy (void) { m_Value = 0; CSrSubrecord::Destroy(); }

 	/* Copy the content from an existing subrecord */
  virtual bool Copy (CSrSubrecord* pSubrecord) {
	CSrLongSubrecord* pSubrecord1 = SrCastClassNull(CSrLongSubrecord, pSubrecord);
	m_RecordSize = sizeof(long);

	if (pSubrecord1 != NULL) {
	  m_Value = pSubrecord1->GetValue();
	}
	else {
	  memset(&m_Value, 0, sizeof(m_Value));
	}
	return (true);
  }

	/* Create a class instance */
  static CSrSubrecord* Create (void) { return (new CSrLongSubrecord); }
  virtual CSrSubrecord* CreateV (void) { return new CSrLongSubrecord; }

	/* Initialize a new record */
  virtual void InitializeNew (void) { CSrSubrecord::InitializeNew();  m_Value = 0; m_RecordSize = sizeof(dword); }

	/* Bit flag operations */
  bool  CheckFlag (const dword Mask)                  { return CheckFlagBits(m_Value, Mask); }
  void  ClearFlag (const dword Mask)			      { m_Value &= ~Mask; }
  long  FlipFlag  (const dword Mask, const bool Flag) { FlipFlagBits(*(dword *)&m_Value, Mask, Flag); return (m_Value); } 
  void  SetFlag   (const dword Mask)			      { m_Value |= Mask; }

	/* Get class members */
  long          GetValue    (void) { return (m_Value); }
  long*         GetValuePtr (void) { return (&m_Value); }
  long&         GetValueRef (void) { return (m_Value); }
  virtual byte*	GetData     (void) { return (byte *)(&m_Value); }

  	/* Set class methods */
  void SetValue (const long Value) { m_Value = Value; }
 
 };
/*===========================================================================
 *		End of Class CSrLongSubrecord Definition
 *=========================================================================*/


#endif
/*===========================================================================
 *		End of File SrLongSubrecord.H
 *=========================================================================*/

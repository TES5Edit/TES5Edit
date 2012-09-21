/*===========================================================================
 *
 * File:		Srwordsubrec.H
 * Author:		Dave Humphrey (dave@uesp.net)
 * Created On:	26 November 2011
 *
 * Defines the CSrWordSubrecord used for storing a 16-bit word.
 *
 *=========================================================================*/
#ifndef __SRWORDSUBREC_H
#define __SRWORDSUBREC_H


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
 * Begin Class CSrWordSubrecord Definition
 *
 *=========================================================================*/
class CSrWordSubrecord : public CSrSubrecord {
  DECLARE_SRCLASS(CSrWordSubrecord, CSrSubrecord)

  /*---------- Begin Private Class Members ----------------------*/
private:
  word	m_Value;


  /*---------- Begin Protected Class Methods --------------------*/
protected:

	/* Input/output the subrecord data */
  virtual bool ReadData  (CSrFile& File) 
  { 
	  if (m_RecordSize == 4)
	  {
		  m_RecordSize = 2;
		  bool Result = File.Read(&m_Value, 2); 
		  word tmp;
		  Result &= File.Read(&tmp, 2);
		  return Result;
	  }
	  else
	  {
		SR_VERIFY_SUBRECORDSIZE(2) 
		return File.Read(&m_Value, 2); 
	  }
  }

  virtual bool WriteData (CSrFile& File) { SR_VERIFY_SUBRECORDSIZE(2) return File.Write(&m_Value, 2); }


  /*---------- Begin Public Class Methods -----------------------*/
public:

	/* Class Constructors/Destructors */
  CSrWordSubrecord() : m_Value(0) { }
  //virtual ~CSrWordSubrecord() { Destroy(); }
  virtual void Destroy (void) { m_Value = 0; CSrSubrecord::Destroy(); }

 	/* Copy the content from an existing subrecord */
  virtual bool Copy (CSrSubrecord* pSubrecord) {
	CSrWordSubrecord* pSubrecord1 = SrCastClassNull(CSrWordSubrecord, pSubrecord);
	m_RecordSize = sizeof(word);

	if (pSubrecord1 != NULL) {
	  m_Value = pSubrecord1->GetValue();
	}
	else {
	  memset(&m_Value, 0, sizeof(m_Value));
	}
	return (true);
  }

	/* Create a class instance */
  static CSrSubrecord* Create (void) { return (new CSrWordSubrecord); }
  virtual CSrSubrecord* CreateV (void) { return new CSrWordSubrecord; }

  	/* Bit flag operations */
  bool CheckFlag (const word Mask) { return CheckFlagBits(m_Value, Mask); }
  word FlipFlag  (const word Mask, const bool Flag) { FlipFlagBits(m_Value, Mask, Flag); return (m_Value); } 

	/* Get class members */
  word          GetValue    (void) { return (m_Value); }
  word*         GetValuePtr (void) { return (&m_Value); }
  word&         GetValueRef (void) { return (m_Value); }
  virtual byte*	GetData     (void) { return (byte *)(&m_Value); }

	/* Initialize a new record */
  virtual void InitializeNew (void) { CSrSubrecord::InitializeNew();  m_Value = 0; m_RecordSize = sizeof(word); }

  	/* Set class methods */
  void SetValue (const word Value) { m_Value = Value; }
 
};
/*===========================================================================
 *		End of Class CSrWordSubrecord Definition
 *=========================================================================*/


#endif
/*===========================================================================
 *		End of File Srwordsubrec.H
 *=========================================================================*/

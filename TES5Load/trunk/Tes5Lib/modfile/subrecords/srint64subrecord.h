/*===========================================================================
 *
 * File:		Sbint64ubrec.H
 * Author:		Dave Humphrey (dave@uesp.net)
 * Created On:	26 November 2011
 *
 * Defines the CSrInt64Subrecord used for storing a 64-bit integer.
 *
 *=========================================================================*/
#ifndef __OBINT64SUBREC_H
#define __OBIN64SUBREC_H


/*===========================================================================
 *
 * Begin Required Includes
 *
 *=========================================================================*/
  #include "srsubrecord.h"
/*===========================================================================
 *		End of Required Includes
 *=========================================================================*/


/*===========================================================================
 *
 * Begin Class CSrInt64Subrecord Definition
 *
 *=========================================================================*/
class CSrInt64Subrecord : public CSrSubrecord {
  DECLARE_SRCLASS(CSrInt64Subrecord, CSrSubrecord)

  /*---------- Begin Protected Class Members --------------------*/
protected:
  int64	m_Value;


  /*---------- Begin Protected Class Methods --------------------*/
protected:

	/* Input/output the subrecord data */
  virtual bool ReadData  (CSrFile& File) { SR_VERIFY_SUBRECORDSIZE(8)  return File.Read(&m_Value, 8); }
  virtual bool WriteData (CSrFile& File) { SR_VERIFY_SUBRECORDSIZE(8)  return File.Write(&m_Value, 8); }


  /*---------- Begin Public Class Methods -----------------------*/
public:

	/* Class Constructors/Destructors */
  CSrInt64Subrecord() { m_Value = 0; }
  //virtual ~CSrInt64Subrecord() { Destroy(); }
  virtual void Destroy (void) { m_Value = 0; CSrSubrecord::Destroy(); }

 	/* Copy the content from an existing subrecord */
  virtual bool Copy (CSrSubrecord* pSubrecord) {
	CSrInt64Subrecord* pSubrecord1 = SrCastClassNull(CSrInt64Subrecord, pSubrecord);
	m_RecordSize = sizeof(int64);

	if (pSubrecord1 != NULL) {
	  m_Value = pSubrecord1->GetValue();
	}
	else {
	  memset(&m_Value, 0, sizeof(m_Value));
	}
	return (true);
  }

	/* Create a class instance */
  static CSrSubrecord* Create (void) { return (new CSrInt64Subrecord); }
  virtual CSrSubrecord* CreateV (void) { return new CSrInt64Subrecord; }

	/* Get class members */
  int64         GetValue    (void) { return (m_Value); }
  int64*        GetValuePtr (void) { return (&m_Value); }
  int64&        GetValueRef (void) { return (m_Value); }
  virtual byte*	GetData     (void) { return (byte *)(&m_Value); }
  
	/* Initialize a new record */
  virtual void InitializeNew (void) { CSrSubrecord::InitializeNew();  m_Value = 0; m_RecordSize = sizeof(int64); }

  	/* Set class methods */
  void SetValue (const int64 Value) { m_Value = Value; }
 
 };
/*===========================================================================
 *		End of Class CSrInt64Subrecord Definition
 *=========================================================================*/


#endif
/*===========================================================================
 *		End of File Srint64subrec.H
 *=========================================================================*/

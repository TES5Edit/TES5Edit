/*===========================================================================
 *
 * File:		Srformidsubrecord.H
 * Author:		Dave Humphrey (dave@uesp.net)
 * Created On:	26 November 2011
 *
 * Defines the CSrFormidSubrecord used for storing a 32-bit formid.
 *
 *=========================================================================*/
#ifndef __SRFORMIDSUBREC_H
#define __SRFORMIDSUBREC_H


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
 * Begin Class CSrFormidSubrecord Definition
 *
 *=========================================================================*/
class CSrFormidSubrecord : public CSrSubrecord {
  DECLARE_SRCLASS(CSrFormidSubrecord, CSrSubrecord)

  /*---------- Begin Protected Class Members --------------------*/
protected:
  srformid_t	m_Value;
  srformid_t	m_OrigValue;


  /*---------- Begin Protected Class Methods --------------------*/
protected:

	/* Input/output the subrecord data */
  virtual bool ReadData  (CSrFile& File) { 
	SR_VERIFY_SUBRECORDSIZE(4)
	bool Result = File.Read(&m_Value, sizeof(dword)); 
	m_OrigValue = m_Value; 
	return (Result);
  }

  virtual bool WriteData (CSrFile& File) { SR_VERIFY_SUBRECORDSIZE(4) return File.Write(&m_Value, sizeof(dword)); }


  /*---------- Begin Public Class Methods -----------------------*/
public:

	/* Class Constructors/Destructors */
  CSrFormidSubrecord() :
		m_Value(0), m_OrigValue(0)
  { 
  }

  virtual void Destroy (void) { 
	m_Value     = 0; 
	m_OrigValue = 0; 
	CSrSubrecord::Destroy();
  }

  	/* Change any matching formid in the subrecord */
  virtual dword ChangeFormID (const srformid_t NewID, const srformid_t OldID) { 
	if (m_Value == OldID) {
	  m_Value     = NewID;
	  m_OrigValue = NewID;
	  return (1);
	}
	return (0); 
  }

  virtual dword CountUses (const srformid_t FormID) 
  {
	  return (FormID == m_Value);
  }

  	/* Copy the content from an existing subrecord */
  virtual bool Copy (CSrSubrecord* pSubrecord) {
	CSrFormidSubrecord* pSubrecord1 = SrCastClassNull(CSrFormidSubrecord, pSubrecord);
	m_RecordSize = sizeof(dword);

	if (pSubrecord1 != NULL) {
	  m_Value = pSubrecord1->GetValue();
	}
	else {
	  memset(&m_Value, 0, sizeof(m_Value));
	}
	return (true);
  }

	/* Create a class instance */
  static CSrSubrecord* Create (void) { return (new CSrFormidSubrecord); }
  virtual CSrSubrecord* CreateV (void) { return new CSrFormidSubrecord; }

  	/* Fixup the modindex of formids */
  virtual bool FixupFormID (CSrFormidFixupArray& FixupArray) {
	return SrFixupFormid(m_Value, m_OrigValue, FixupArray);
  }

	/* Initialize a new record */
  virtual void InitializeNew (void) { 
	CSrSubrecord::InitializeNew();  
	m_Value      = 0; 
	m_OrigValue  = 0; 
	m_RecordSize = sizeof(dword); 
  }

	/* Get class members */
  srformid_t    GetValue     (void) { return (m_Value); }
  srformid_t    GetOrigValue (void) { return (m_Value); }
  virtual byte*	GetData      (void) { return (byte *)(&m_Value); }

  	/* Set class methods */
  void SetValue     (const srformid_t Value) { m_Value     = Value; }
  void SetOrigValue (const srformid_t Value) { m_OrigValue = Value; }
 
};
/*===========================================================================
 *		End of Class CSrFormidSubrecord Definition
 *=========================================================================*/


#endif
/*===========================================================================
 *		End of File SrFormidsubrec.H
 *=========================================================================*/

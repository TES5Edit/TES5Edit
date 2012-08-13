/*===========================================================================
 *
 * File:		Srstringsubrecord.H
 * Author:		Dave Humphrey (dave@uesp.net)
 * Created On:	26 November 2011
 *
 * Defines the CSrStringSubrecord used for storing a variable length
 * string.
 *
 *=========================================================================*/
#ifndef __SRSTRINGSUBRECORD_H
#define __SRSTRINGSUBRECORD_H


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
 * Begin Class CSrStringSubrecord Definition
 *
 * Defines a simple variable length string data subrecord.
 *
 *=========================================================================*/
class CSrStringSubrecord : public CSrSubrecord {
  DECLARE_SRCLASS(CSrStringSubrecord, CSrSubrecord)

  /*---------- Begin Protected Class Members --------------------*/
protected:
  CSString	m_String;


  /*---------- Begin Protected Class Methods --------------------*/
protected:

	/* Input/output the subrecord data */
  virtual bool ReadData  (CSrFile& File);
  virtual bool WriteData (CSrFile& File) { return File.Write((const SSCHAR *)m_String, m_String.GetLength() + 1); }


  /*---------- Begin Public Class Methods -----------------------*/
public:

	/* Class Constructors/Destructors */
  CSrStringSubrecord();
  //virtual ~CSrStringSubrecord() { Destroy(); }
  virtual void Destroy (void);

  	/* Compare two subrecord fields */
  virtual bool CompareFields (int& Result, const int FieldID, CSrSubrecord* pSubrecord);

	/* Copy the content from an existing subrecord */
  virtual bool Copy (CSrSubrecord* pSubrecord) {
	CSrStringSubrecord* pSubrecord1 = SrCastClassNull(CSrStringSubrecord, pSubrecord);
	
	if (pSubrecord1 != NULL) {
	  m_String     = pSubrecord1->GetString();
	  m_RecordSize = GetRecordSize();
	}
	else {
	  m_RecordSize = 0;
	}
	return (true);
  }

	/* Create a class instance */
  static CSrSubrecord* Create (void) { return (new CSrStringSubrecord); }
  virtual CSrSubrecord* CreateV (void) { return new CSrStringSubrecord; }

	/* Get class members */
  CSString&     GetString     (void)       { return (m_String); }
  virtual byte*	GetData       (void)       { return (byte *)(const SSCHAR *)(m_String); }
  virtual dword	GetRecordSize (void) const { return (m_String.GetLength() + 1); }

	/* Get a string representation of a subrecord field */
  virtual bool GetField (CSString& Buffer, const int FieldID);

  	/* Set class methods */
  void SetString (const SSCHAR* pString) { m_String = pString; }

  
};

	/* Known subrecord types that are always strings */
  typedef CSrStringSubrecord CSrModlSubrecord;	/* Model filename */
  typedef CSrStringSubrecord CSrIconSubrecord;	/* Icon filename */

/*===========================================================================
 *		End of Class CSrStringSubrecord Definition
 *=========================================================================*/


/*===========================================================================
 *
 * Class CSrStringSubrecord Method - int CompareFields (Result, FieldID, pSubrecord);
 *
 *=========================================================================*/
inline bool CSrStringSubrecord::CompareFields (int& Result, const int FieldID, CSrSubrecord* pSubrecord) {
  CSrStringSubrecord* pString = SrCastClass(CSrStringSubrecord, pSubrecord);

  switch (FieldID) {
    case SR_FIELD_EFFECTNAME:
    case SR_FIELD_ITEMNAME:
		Result = (pString != NULL) ? stricmp(GetString().c_str(), pString->GetString().c_str()) : 1;
		return (true);
   }

	/* No match */
  return CSrSubrecord::CompareFields(Result, FieldID, pSubrecord);
 }
/*===========================================================================
 *		End of Class Method CSrStringSubrecord::CompareFields()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CSrStringSubrecord Method - bool GetField (Buffer, FieldID);
 *
 *=========================================================================*/
inline bool CSrStringSubrecord::GetField (CSString& Buffer, const int FieldID) {
  
  switch (FieldID) {
    case SR_FIELD_EFFECTNAME:
    case SR_FIELD_ITEMNAME:
        Buffer = GetString();
		return (true);
   }

  return CSrSubrecord::GetField(Buffer, FieldID);
 }
/*===========================================================================
 *		End of Class Method CSrStringSubrecord::GetField()
 *=========================================================================*/


#endif
/*===========================================================================
 *		End of File Srstringsubrec.H
 *=========================================================================*/

/*===========================================================================
 *
 * File:		SrLstringsubrecord.H
 * Author:		Dave Humphrey (dave@uesp.net)
 * Created On:	26 November 2011
 *
 * Defines the CSrLStringSubrecord used for storing a variable length
 * string.
 *
 *=========================================================================*/
#ifndef __SRLSTRINGSUBRECORD_H
#define __SRLSTRINGSUBRECORD_H


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
 * Begin Definitions
 *
 *=========================================================================*/
	#define SR_LSTRING_FLAG_ISLOADED  0x01
    #define SR_LSTRING_FLAG_LOADLOCAL 0x02
/*===========================================================================
 *		End of Definitions
 *=========================================================================*/


/*===========================================================================
 *
 * Begin Class CSrLStringSubrecord Definition
 *
 * Defines a simple variable length string data subrecord.
 *
 *=========================================================================*/
class CSrLStringSubrecord : public CSrSubrecord {
  DECLARE_SRCLASS(CSrLStringSubrecord, CSrSubrecord)

  /*---------- Begin Protected Class Members --------------------*/
protected:
  CSString			m_String;
  srlstringid_t		m_StringID;
  byte				m_Flags;


  /*---------- Begin Protected Class Methods --------------------*/
protected:

	/* Input/output the subrecord data */
  virtual bool ReadData  (CSrFile& File);
  virtual bool WriteData (CSrFile& File);


  /*---------- Begin Public Class Methods -----------------------*/
public:

	/* Class Constructors/Destructors */
  CSrLStringSubrecord();
  //virtual ~CSrLStringSubrecord() { Destroy(); }
  virtual void Destroy (void);

  	/* Compare two subrecord fields */
  virtual bool CompareFields (int& Result, const int FieldID, CSrSubrecord* pSubrecord);

	/* Copy the content from an existing subrecord */
  virtual bool Copy (CSrSubrecord* pSubrecord) {
	CSrLStringSubrecord* pSubrecord1 = SrCastClassNull(CSrLStringSubrecord, pSubrecord);
	
	if (pSubrecord1 != NULL) 
	{
	  m_String     = pSubrecord1->GetString();
	  m_RecordSize = GetRecordSize();
	  m_StringID   = pSubrecord1->m_StringID;
	  m_Flags      = pSubrecord1->m_Flags & ~SR_LSTRING_FLAG_LOADLOCAL;
	}
	else 
	{
	  m_RecordSize = 0;
	}

	return (true);
  }

	/* Create a class instance */
  static CSrSubrecord* Create (void) { return (new CSrLStringSubrecord); }
  virtual CSrSubrecord* CreateV (void) { return new CSrLStringSubrecord; }

	/* Get class members */
  CSString&     GetString     (void)       { return (m_String); }
  virtual byte*	GetData       (void)       { return (byte *)(const SSCHAR *)(m_String); }

  virtual dword	GetRecordSize (void) const 
  { 
	  if (IsLoadLocal())
	  {
		  if (IsStringLoaded()) return m_String.GetLength() + 1;
		  return 4;
	  }

	  return m_String.GetLength() + 1; 
  }

  bool IsLoadLocal    (void) const { return ::CheckFlagBits(m_Flags, SR_LSTRING_FLAG_LOADLOCAL); }
  bool IsStringLoaded (void) const { return ::CheckFlagBits(m_Flags, SR_LSTRING_FLAG_ISLOADED); }

	/* Get a string representation of a subrecord field */
  virtual bool GetField (CSString& Buffer, const int FieldID);

  void LoadLocalStrings (CSrRecordHandler* pHandler);

  	/* Set class methods */
  void SetString (const SSCHAR* pString) { m_String = pString; }

  void SetLoadLocalString (const bool Flag) { ::FlipFlagBits(m_Flags, SR_LSTRING_FLAG_LOADLOCAL, Flag); }
  void SetIsStringLoaded  (const bool Flag) { ::FlipFlagBits(m_Flags, SR_LSTRING_FLAG_ISLOADED,  Flag); }

  void UpdateLocalStrings(CSrStringFile& StringFile, srlstringid_t& NextStringID);
  
};
/*===========================================================================
 *		End of Class CSrStringSubrecord Definition
 *=========================================================================*/


/*===========================================================================
 *
 * Class CSrLStringSubrecord Method - int CompareFields (Result, FieldID, pSubrecord);
 *
 *=========================================================================*/
inline bool CSrLStringSubrecord::CompareFields (int& Result, const int FieldID, CSrSubrecord* pSubrecord) {
  CSrLStringSubrecord* pString = SrCastClass(CSrLStringSubrecord, pSubrecord);

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
 *		End of Class Method CSrLStringSubrecord::CompareFields()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CSrLStringSubrecord Method - bool GetField (Buffer, FieldID);
 *
 *=========================================================================*/
inline bool CSrLStringSubrecord::GetField (CSString& Buffer, const int FieldID) {
  
  switch (FieldID) {
    case SR_FIELD_EFFECTNAME:
    case SR_FIELD_ITEMNAME:
        Buffer = GetString();
		return (true);
   }

  return CSrSubrecord::GetField(Buffer, FieldID);
 }
/*===========================================================================
 *		End of Class Method CSrLStringSubrecord::GetField()
 *=========================================================================*/


#endif
/*===========================================================================
 *		End of File SrLstringsubrec.H
 *=========================================================================*/

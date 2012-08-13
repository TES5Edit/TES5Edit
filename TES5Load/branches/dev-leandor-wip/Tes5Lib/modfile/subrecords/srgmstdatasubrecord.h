/*===========================================================================
 *
 * File:		SrGmstDataSubrecord.H
 * Author:		Dave Humphrey (dave@uesp.net)
 * Created On:	7 December 2011
 *
 * Defines the CSrGmstDataSubrecord used for storing a variable length
 * string.
 *
 *=========================================================================*/
#ifndef __SRGMSTDATASUBRECORD_H
#define __SRGMSTDATASUBRECORD_H


/*===========================================================================
 *
 * Begin Required Includes
 *
 *=========================================================================*/
	#include "srsubrecord.h"
	#include "srlstringsubrecord.h"
/*===========================================================================
 *		End of Required Includes
 *=========================================================================*/


/*===========================================================================
 *
 * Begin Definitions
 *
 *=========================================================================*/
	#define SR_GMSTDATA_TYPEINT		0x10
	#define SR_GMSTDATA_TYPEFLOAT	0x20
    #define SR_GMSTDATA_TYPESTRING	0x30
	#define SR_GMSTDATA_TYPEBOOL	0x40
	#define SR_GMSTDATA_TYPEMASK	0xf0
/*===========================================================================
 *		End of Definitions
 *=========================================================================*/


/*===========================================================================
 *
 * Begin Class CSrGmstDataSubrecord Definition
 *
 *=========================================================================*/
class CSrGmstDataSubrecord : public CSrSubrecord {
  DECLARE_SRCLASS(CSrGmstDataSubrecord, CSrSubrecord)

  /*---------- Begin Protected Class Members --------------------*/
protected:
  dword				m_RawData;
  CSString			m_String;
  byte				m_Flags;


  /*---------- Begin Protected Class Methods --------------------*/
protected:

		/* Input/output the subrecord data */
  virtual bool ReadData  (CSrFile& File);
  virtual bool WriteData (CSrFile& File);


  /*---------- Begin Public Class Methods -----------------------*/
public:

		/* Class Constructors/Destructors */
  CSrGmstDataSubrecord();
  virtual void Destroy (void);
  
		/* Copy the content from an existing subrecord */
  virtual bool Copy (CSrSubrecord* pSubrecord) {
	CSrGmstDataSubrecord* pSubrecord1 = SrCastClassNull(CSrGmstDataSubrecord, pSubrecord);
	
	if (pSubrecord1 != NULL) 
	{
	  m_String     = pSubrecord1->GetString();
	  m_RecordSize = GetRecordSize();
	  m_RawData    = pSubrecord1->m_RawData;
	  m_Flags      = pSubrecord1->m_Flags & ~SR_LSTRING_FLAG_LOADLOCAL;
	}
	else 
	{
	  m_RecordSize = 0;
	}

	return (true);
  }

		/* Create a class instance */
  static CSrSubrecord* Create (void) { return (new CSrGmstDataSubrecord); }
  virtual CSrSubrecord* CreateV (void) { return new CSrGmstDataSubrecord; }

		/* Get class members */
  int           GetInteger     (void)       { return *(int *)&m_RawData; }
  float         GetFloat       (void)       { return *(float *)&m_RawData; }
  CSString&     GetString      (void)       { return (m_String); }
  virtual byte*	GetData        (void)       { return (byte *)(const SSCHAR *)(m_String); }
  dword         GetGlobalType  (void) const { return (m_Flags & SR_GMSTDATA_TYPEMASK); }
  bool			IsGlobalInt    (void) const { return GetGlobalType() == SR_GMSTDATA_TYPEINT; }
  bool			IsGlobalBool   (void) const { return GetGlobalType() == SR_GMSTDATA_TYPEBOOL; }
  bool			IsGlobalString (void) const { return GetGlobalType() == SR_GMSTDATA_TYPESTRING; }
  bool			IsGlobalFloat  (void) const { return GetGlobalType() == SR_GMSTDATA_TYPEFLOAT; }

  virtual dword	GetRecordSize  (void) const 
  { 
	  if (!IsGlobalString()) return 4;
	  if (IsLoadLocal()) return 4;
	  return m_String.GetLength() + 1; 
  }

  bool IsLoadLocal    (void) const { return ::CheckFlagBits(m_Flags, SR_LSTRING_FLAG_LOADLOCAL); }
  bool IsStringLoaded (void) const { return ::CheckFlagBits(m_Flags, SR_LSTRING_FLAG_ISLOADED); }

  void LoadLocalStrings (CSrRecordHandler* pHandler);

	  	/* Set class methods */
  void SetString  (const SSCHAR* pString) { m_String = pString; }
  void SetInteger (const int       Value) { *(int *)&m_RawData  = Value; }
  void SetFloat   (const float     Value) { *(float *)&m_RawData = Value; }

  void SetLoadLocalString (const bool Flag) { ::FlipFlagBits(m_Flags, SR_LSTRING_FLAG_LOADLOCAL, Flag); }
  void SetIsStringLoaded  (const bool Flag) { ::FlipFlagBits(m_Flags, SR_LSTRING_FLAG_ISLOADED,  Flag); }
  void SetGlobalType      (const byte Type) { m_Flags =(m_Flags & ~SR_GMSTDATA_TYPEMASK) | (Type & SR_GMSTDATA_TYPEMASK); }

  virtual void UpdateLocalStrings(CSrStringFile& StringFile, srlstringid_t& NextStringID);

};
/*===========================================================================
 *		End of Class CSrGmstDataSubrecord Definition
 *=========================================================================*/


#endif
/*===========================================================================
 *		End of File SrGmstDataSubrecord.H
 *=========================================================================*/

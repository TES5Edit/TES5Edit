/*===========================================================================
 *
 * File:	Textutils.CPP
 * Author:	Dave Humphrey (dave@uesp.net)
 * Created On:	April 12, 2006
 *
 * Description
 *
 *=========================================================================*/

	/* Include Files */
#include "textutils.h"
#include "ctype.h"


/*===========================================================================
 *
 * Class CSrStringValueMap Method - bool Initialize (void);
 *
 *=========================================================================*/
bool CSrStringValueMap::Initialize (void) {
  const SSCHAR* pString;
  dword         Index;
  const int*    pValue;

	/* Ignore if the current content is not valid */
  m_StringMap.Destroy();
  m_ValueMap.Destroy();
  if (m_pStringValues == NULL) return (false);

  m_StringMap.InitHashTable(257);
  m_ValueMap.InitHashTable(257);

	/* Create both maps of string/value pairs */
  for (Index = 0; m_pStringValues[Index].pString != NULL; ++Index) {
    pString = m_ValueMap.Lookup(m_pStringValues[Index].Value);

    if (pString == NULL) {
      m_ValueMap.SetAt (m_pStringValues[Index].Value, (SSCHAR *) m_pStringValues[Index].pString);
    }

    pValue = m_StringMap.Lookup(m_pStringValues[Index].pString);

    if (pValue == NULL) {
      
	  m_StringMap.SetAt(m_pStringValues[Index].pString, (int *) &m_pStringValues[Index].Value);
    }
  }

  return (true);
}
/*===========================================================================
 *		End of Class Method CSrStringValueMap::Initialize()
 *=========================================================================*/


/*===========================================================================
 *
 * Function - const SSCHAR* FindTextVariable (pString, ReplaceInfo);
 *
 * Find a variable in an array of replacement information. Returns the
 * matching record value (case insensitive) on success or NULL if not found.
 *
 *=========================================================================*/
const SSCHAR* FindTextVariable (const SSCHAR* pString, const textreplace_t ReplaceInfo[]) {
  int Index;

  for (Index = 0; ReplaceInfo[Index].pVariable != NULL; ++Index) {
    if (stricmp(ReplaceInfo[Index].pVariable, pString) == 0) return (ReplaceInfo[Index].pValue);
   }

  return (NULL);
 }
/*===========================================================================
 *		End of Function textreplace_t* FindTextVariable()
 *=========================================================================*/


/*===========================================================================
 *
 * Function - int FindStringValue (pString, StringInfo[]);
 *
 * Searches the given string-value array for the matching string (case 
 * insensitive). On success it returns the value associated with that
 * string. If the string is not found the last record value is returned.
 *
 *=========================================================================*/
int FindStringValue (const SSCHAR* pString, const stringvalue_t StringInfo[]) {
  int Result;

  FindStringValue(Result, pString, StringInfo);
  return (Result);
 }
/*===========================================================================
 *		End of Function stringvalue_t* FindStringValue()
 *=========================================================================*/


 /*===========================================================================
 *
 * Function - bool FindStringValue (OutputValue, pString, StringInfo[]);
 *
 * Searches the given string-value array for the matching string (case 
 * insensitive). On success it returns true and set the given value to that
 * associated with the string. If the string is not found false is returned
 * and the OutputValue set to the last record value.
 *
 *=========================================================================*/
bool FindStringValue (int& OutputValue, const SSCHAR* pString, const stringvalue_t StringInfo[]) {
  int Index;

  for (Index = 0; StringInfo[Index].pString != NULL; ++Index) {

		/* Special case for NULL input */
    if (pString == NULL) {
      if (StringInfo[Index].pString == NULL) {
        OutputValue = StringInfo[Index].Value;
	return (true);
       }
     }
    else if (stricmp(StringInfo[Index].pString, pString) == 0) {
      OutputValue = StringInfo[Index].Value;
      return (true);
     }
   }

  OutputValue = StringInfo[Index].Value;
  return (false);
 }
/*===========================================================================
 *		End of Function stringvalue_t* FindStringValue()
 *=========================================================================*/


/*===========================================================================
 *
 * Function - const SSCHAR* FindStringValue (Value, StringInfo[]);
 *
 * Searches the given string-value array for a matching value. On success
 * the associated string is returned. On failure NULL is returned.
 *
 *=========================================================================*/
const SSCHAR* FindStringValue (const int Value, const stringvalue_t StringInfo[]) {
  int Index;

  for (Index = 0; StringInfo[Index].pString != NULL; ++Index) {
    if (StringInfo[Index].Value == Value) return (StringInfo[Index].pString);
   }

  return (NULL);
 }


bool FindStringValue (const SSCHAR** ppString, const int Value, const stringvalue_t StringInfo[]) {
  int Index;

  for (Index = 0; StringInfo[Index].pString != NULL; ++Index) {

    if (StringInfo[Index].Value == Value) {
      *ppString = StringInfo[Index].pString;
      return (true);
     }
   }

  return (false);
 }
/*===========================================================================
 *		End of Function stringvalue_t* FindStringValue()
 *=========================================================================*/


/*===========================================================================
 *
 * Function - bool ReplaceTextVariables (DestString, SrcString, ReplaceInfo);
 *
 * Replaces variables in the source string with values as defined in the
 * pReplaceInfo array, outputting the new result to the destination string.
 * Returns false on any error. Text variables are defined as strings surrounded
 * by the % character on a single line.
 *
 *	ex:	set %Variable01% to 25.0 * %Reference02%->GetAV Strength
 *
 * Variable names must be composed of alpha-numeric characters or underscore.
 * Variables found in the source that are not contained in the replacement
 * array are left as is in the destination string.
 *
 *=========================================================================*/
bool ReplaceTextVariables (CSString& DestString, const CSString& SrcString, 
			   const textreplace_t ReplaceInfo[]) {
  const SSCHAR*	pSrcString = SrcString;
  const SSCHAR*	pValue;
  int		Index;
  bool		InString   = false;
  bool		InVariable = false;
  CSString	Variable;

	/* Preallocate the destination string (guess a length) */
  DestString.Empty();
  DestString.SetSizeEmpty((int)(SrcString.GetLength() * 1.1) + 8);

	/* Parse the entire input string */
  for (Index = 0; Index < SrcString.GetLength(); ++Index) {

    switch (pSrcString[Index]) {
      case '%':		/* Start or end of a variable definition */

        if (InVariable) {
	  InVariable   = false;
	  pValue = FindTextVariable(Variable, ReplaceInfo);

	  if (pValue == NULL) {
	    DestString += '%';
	    DestString += Variable;
	    DestString += '%';
	   }
          else {
	    DestString += pValue;
	   }
         }
	else {
	  InVariable = true;
	  Variable.Empty();
	 }

	break;
      case '"':		/* Start or end of a string */
        
	if (InVariable) {
	  DestString += '%';
	  DestString += Variable;
	  InVariable  = false;
         }

        InString    = !InString;
	DestString += pSrcString[Index];
	break;
      case '\n':	/* End of line */
      case '\r':
        InString = false;
	
	if (InVariable) {
	  DestString += '%';
	  DestString += Variable;
	  InVariable  = false;
         }

	DestString += pSrcString[Index];
	break;
      default:

        if (InVariable) {
	  if (isalnum(pSrcString[Index]) || pSrcString[Index] == '_') {
	    Variable += pSrcString[Index];
	   }
          else {
	    DestString += '%';
	    DestString += Variable;
	    DestString += pSrcString[Index];
	    InVariable  = false;
	   }
	  
	 }
	else {
	  DestString += pSrcString[Index];
         }

        break;
     }
   }

  return (true);
 }
/*===========================================================================
 *		End of Function ReplaceTextVariables()
 *=========================================================================*/


/*===========================================================================
 *
 * Function - char ConvertToHexChar (Value);
 *
 * Converts a value (0-15) into the appropriate hexadecimal character 
 * (0-9, A-F). Returns 0 on any invalid input.
 *
 *=========================================================================*/
char ConvertToHexChar (const dword Value) {
  static char s_RevValues[16] = { '0', '1', '2', '3', '4', '5', '6', '7', '8', '9', 'A', 'B', 'C', 'D', 'E', 'F' };

  if (Value >= 16) return (0);
  return s_RevValues[Value];
}
/*===========================================================================
 *		End of Function ConvertToHexChar()
 *=========================================================================*/


/*===========================================================================
 *
 * Function - const char* ConvertByteToHexChar (Value);
 *
 * Converts the given byte value into a hexadecimal string.
 *
 *=========================================================================*/
const char* ConvertByteToHexChar (const byte Value) {
  static char s_Buffer[4] = { 0 };

  s_Buffer[0] = ConvertToHexChar(Value >> 4);
  s_Buffer[1] = ConvertToHexChar(Value & 0x0f);

  return s_Buffer;
}
/*===========================================================================
 *		End of Function char* ConvertByteToHexChar()
 *=========================================================================*/


/*===========================================================================
 *
 * Function - byte ConvertFromHexByte (pHexByte);
 *
 * Converts a two-digit hexadecimal string into a byte value. Returns 0
 * on any error.
 *
 *=========================================================================*/
byte ConvertFromHexByte (const char* pHexByte) {
  if (pHexByte == NULL) return (0);
  return (byte) (ConvertFromHexChar(pHexByte[0]) << 4) + ConvertFromHexChar(pHexByte[1]);
}
/*===========================================================================
 *		End of Function ConvertFromHexByte()
 *=========================================================================*/


/*===========================================================================
 *
 * Function - dword ConvertFromHexChar (HexChar);
 *
 * Converts a hexadecimal character (0-9, A-F, a-f) to a value (0-15). 
 * Returns 0 on any invalid character. 
 *
 *=========================================================================*/
dword ConvertFromHexChar (const char HexChar) {
  static byte s_Values[256] = {
	0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
	0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
	0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
	0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 0, 0, 0, 0, 0, 0,
	0,10,11,12,13,14,15, 0, 0, 0, 0, 0, 0, 0, 0, 0,
	0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
	0,10,11,12,13,14,15, 0, 0, 0, 0, 0, 0, 0, 0, 0,
	0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
	0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
	0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
	0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
	0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
	0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
	0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
	0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
	0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
  };

  return s_Values[(byte)HexChar];
}
/*===========================================================================
 *		End of Function ConvertFromHexChar()
 *=========================================================================*/


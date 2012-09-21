/*===========================================================================
 *
 * File:	Textutils.H
 * Author:	Dave Humphrey (dave@uesp.net)
 * Created On:	April 12, 2006
 *
 * Description
 *
 *=========================================================================*/
#ifndef __TEXTUTILS_H
#define __TEXTUTILS_H


/*===========================================================================
 *
 * Begin Required Includes
 *
 *=========================================================================*/
  #include "srerrorhandler.h"
  #include "dl_map.h"
  #include "srlogfile.h"
/*===========================================================================
 *		End of Required Includes
 *=========================================================================*/


/*===========================================================================
 *
 * Begin Definitions
 *
 *=========================================================================*/

	/* Shortcuts to help define a static text replacement array */
  #define BEGIN_TEXTREPLACE(Name) const textreplace_t Name[] = {
  #define ADD_TEXTREPLACE(Variable, Value) { Variable, Value }, 
  #define END_TEXTREPLACE() { 0, NULL } };

	/* Shortcuts to help define a static string-value array */
#define BEGIN_STRINGVALUE(Name) extern const stringvalue_t Name[]; CSrStringValueMap Name##Map(Name, #Name); const stringvalue_t Name[] = {
  #define ADD_STRINGVALUE(Value, String) { Value, String }, 
  #define END_STRINGVALUE() { 0, NULL } };

	/* Whether to use the advanced map class in some places */
  #define SR_USESTRINGVALUEMAP 1

/*===========================================================================
 *		End of Definitions
 *=========================================================================*/


/*===========================================================================
 *
 * Begin Type Definitions
 *
 *=========================================================================*/

	/* Structure used when replacing variables in a text string */
  struct textreplace_t {
	const SSCHAR* pVariable;	/* These are references to strings */
	const SSCHAR* pValue;
   };

	/* Holds information on simple string-value association */
  struct stringvalue_t {
  	int	      Value;
	const SSCHAR* pString;
   };

  typedef TGenRefPtrMap<const SSCHAR*, int,    const SSCHAR*> CSrStringMap;
  typedef TGenRefPtrMap<int,           SSCHAR, int>           CSrValueMap;

/*===========================================================================
 *		End of Type Definitions
 *=========================================================================*/


/*===========================================================================
 *
 * Begin Class CSrStringValueMap Definition
 *
 * Simple map for looking up string/value pairs.
 *
 *=========================================================================*/
class CSrStringValueMap {

  /*---------- Begin Private Class Members ----------------------*/
private:
  CSrStringMap         m_StringMap;
  CSrValueMap          m_ValueMap;
  CSString			   m_Name;

  const stringvalue_t* m_pStringValues;


  /*---------- Begin Protected Class Methods --------------------*/
protected:

	/* Initialize the maps from the current value array */
  bool Initialize (void);


  /*---------- Begin Public Class Methods -----------------------*/
public:

	/* Class Constructors/Destructors */
  CSrStringValueMap(const stringvalue_t* pValues, const char* pName = "") : m_pStringValues(pValues), m_Name(pName)
  {
	Initialize();
  }



  ~CSrStringValueMap() { Destroy(); }

  void Destroy (void) {
	m_StringMap.Destroy();
	m_ValueMap.Destroy();
	m_pStringValues = NULL;
  }

  const SSCHAR* FindValue  (const int     Value)    { 
	  const SSCHAR* pString = m_ValueMap.Lookup(Value); 
	  if (pString) return pString;
	   SystemLog.Printf("Map '%s': Unknown key value %d found!", m_Name.c_str(), Value);
	   return NULL;
  }

  int FindString (const SSCHAR* pString)  { 
    const int* pResult = m_StringMap.Lookup(pString); 
    if (pResult != NULL) return (*pResult); 
    return (0);
  }

  int FindString (const SSCHAR* pString, const int Default)  { 
    const int* pResult = m_StringMap.Lookup(pString); 
    if (pResult != NULL) return (*pResult); 
    return (Default);
  }

  bool FindString (int& Value, const SSCHAR* pString)  { 
    const int* pResult = m_StringMap.Lookup(pString); 
    if (pResult == NULL) return (false); 
    Value = *pResult;
    return (true);
  }
};
/*===========================================================================
 *		End of Class CSrStringValueMap Definition
 *=========================================================================*/


/*===========================================================================
 *
 * Begin Function Definitions
 *
 *=========================================================================*/

  const SSCHAR* FindTextVariable (const SSCHAR* pString, const textreplace_t ReplaceInfo[]);
  
  const SSCHAR* FindStringValue  (const int Value,       const stringvalue_t StringInfo[]);
  int           FindStringValue  (const SSCHAR* pString, const stringvalue_t StringInfo[]);

  bool          FindStringValue  (int& OutputValue, const SSCHAR* pString, const stringvalue_t StringInfo[]);
  bool          FindStringValue  (const SSCHAR** ppString, const int Value, const stringvalue_t StringInfo[]);

  bool ReplaceTextVariables (CSString& DestString, const CSString& SrcString, const textreplace_t ReplaceInfo[]);

	/* Hexadecimal conversion functions */
  char        ConvertToHexChar     (const dword Value);
  const char* ConvertByteToHexChar (const byte  Value);
  byte        ConvertFromHexByte   (const char* pHexByte);
  dword       ConvertFromHexChar   (const char HexChar);

/*===========================================================================
 *		End of Function Definitions
 *=========================================================================*/


#endif
/*===========================================================================
 *		End of File Textutils.H
 *=========================================================================*/

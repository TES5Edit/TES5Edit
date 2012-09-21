/*===========================================================================
 *
 * File:	Srconfigfile.H
 * Author:	Dave Humphrey (dave@uesp.net)
 * Created On:	25 November 2011
 *
 * Defines the CSrConfigFile class for handling general text config files.
 *
 *=========================================================================*/
#ifndef __SRCONFIGFILE_H
#define __SRCONFIGFILE_H


/*===========================================================================
 *
 * Begin Required Includes
 *
 *=========================================================================*/
  #include "srconfigentry.h"
/*===========================================================================
 *		End of Required Includes
 *=========================================================================*/


/*===========================================================================
 *
 * Begin Class CSrConfigFile Definition
 *
 * Used to managed the contents of a general config text file.
 *
 *=========================================================================*/
class CSrConfigFile {

  /*---------- Begin Protected Class Members --------------------*/
protected:
  CSrConfigEntryArray	m_Records;	/* Config file content by line */

  srcfgoptions_t	m_Options;


  /*---------- Begin Protected Class Methods --------------------*/
protected:


  /*---------- Begin Public Class Methods -----------------------*/
public:

	/* Class Constructors/Destructors */
  CSrConfigFile();
  virtual ~CSrConfigFile() { Destroy(); }
  virtual void Destroy (void);

	/* Delete an entry */
  bool Delete (const char* pVariable);

	/* Get class members */
  srcfgoptions_t& GetOptions (void) { return (m_Options); }

	/* Gets values */
  const char* Get      (const char* pVariable);
  const char* Get      (const char* pVariable, const char* pDefault);
  bool        HasEntry (const char* pVariable) { return FindEntry(pVariable) != NULL; }

	/* Get typed values */
  bool GetInteger (int&      Value, const char* pVariable, const int   Default = 0);
  bool GetDword   (dword&    Value, const char* pVariable, const dword Default = 0);
  bool GetFloat   (float&    Value, const char* pVariable, const float Default = 0);
  bool GetBoolean (bool&     Value, const char* pVariable, const bool  Default = false);
  bool GetString  (CSString& Value, const char* pVariable, const char* Default = "");

	/* Find a matching entry */
  CSrConfigEntry* FindEntry (const char* pVariable);

  bool FindFirst (CSString& Value, const char* pVariable, int& Position, const char* Default = "");
  bool FindNext  (CSString& Value, const char* pVariable, int& Position, const char* Default = "");

	/* Load/save a config file */
  bool Load (const char* pFilename);
  bool Save (const char* pFilename);

	/* Sets the value of the given variable */
  void SetValue       (const char* pVariable, const char* pValue);
  void SetValueFormat (const char* pVariable, const char* pValue, ...);

	/* Set typed values */
  void SetValueInteger (const char* pVariable, const int   Value) { SetValueFormat(pVariable, "%d", Value); }
  void SetValueDword   (const char* pVariable, const dword Value) { SetValueFormat(pVariable, "%u", Value); }
  void SetValueFloat   (const char* pVariable, const float Value) { SetValueFormat(pVariable, "%f", Value); }
  void SetValueBoolean (const char* pVariable, const bool  Value) { SetValueFormat(pVariable, "%s", BooleanToString(Value)); }

	/* Read or write values */
  bool UpdateInteger (const bool Set, const char* pVariable, int&      Value) { if (Set) { SetValueInteger(pVariable, Value); return (true); } return GetInteger(Value, pVariable, Value); }
  bool UpdateDword   (const bool Set, const char* pVariable, dword&    Value) { if (Set) { SetValueDword  (pVariable, Value); return (true); } return GetDword  (Value, pVariable, Value); }
  bool UpdateFloat   (const bool Set, const char* pVariable, float&    Value) { if (Set) { SetValueFloat  (pVariable, Value); return (true); } return GetFloat  (Value, pVariable, Value); }
  bool UpdateBoolean (const bool Set, const char* pVariable, bool&     Value) { if (Set) { SetValueBoolean(pVariable, Value); return (true); } return GetBoolean(Value, pVariable, Value); }
  bool UpdateString  (const bool Set, const char* pVariable, CSString& Value) { if (Set) { SetValue       (pVariable, Value); return (true); } return GetString (Value, pVariable, Value); }

  bool UpdateDword   (const bool Set, const char* pVariable, unsigned long& Value) { if (Set) { SetValueDword(pVariable, *(dword *)&Value); return (true); } return GetDword(*(dword *)&Value, pVariable, Value); }

};
/*===========================================================================
 *		End of Class CSrConfigFile Definition
 *=========================================================================*/


#endif
/*===========================================================================
 *		End of File Srconfigfile.H
 *=========================================================================*/

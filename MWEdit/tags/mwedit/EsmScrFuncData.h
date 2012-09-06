/*===========================================================================
 *
 * File:	Esmscrfuncdata.H
 * Author:	Dave Humphrey (uesp@m0use.net)
 * Created On:	September 1, 2003
 *
 * Description
 *
 *=========================================================================*/
#ifndef __ESMSCRFUNCDATA_H
#define __ESMSCRFUNCDATA_H


/*===========================================================================
 *
 * Begin Required Includes
 *
 *=========================================================================*/
  #include "dl_err.h"
  #include "string/sstring.h"
  #include "EsmScriptDefs.h"
  #include "file/GenFile.h"
/*===========================================================================
 *		End of Required Includes
 *=========================================================================*/


/*===========================================================================
 *
 * Begin Definitions
 *
 *=========================================================================*/

	/* Max string lengths */
  #define ESM_SFDATA_NAMESIZE	31
  #define ESM_SFDATA_LINELENGTH 255

/*===========================================================================
 *		End of Definitions
 *=========================================================================*/


/*===========================================================================
 *
 * Begin Class CEsmScrFuncData Definition
 *
 * Holds a single function definition for the Morrowind script compiler.
 *
 *=========================================================================*/
class CEsmScrFuncData {

  /*---------- Begin Private Class Members ----------------------*/
private:
  TCHAR		m_Function[ESM_SFDATA_NAMESIZE+1];	/* Function name */

  TCHAR		m_WikiLink[ESM_SFDATA_NAMESIZE+1];	/* Optional link to alternate wiki page */

  TCHAR		m_ReturnDesc[ESM_SFDATA_LINELENGTH+1];	/* Return description */
  long		m_ReturnFlags;				/* Return flags */

  long		m_ParamFlags[MWESM_SCRIPT_MAXARGS];	/* Parameter flags and descriptions */
  CSString	m_ParamDesc[MWESM_SCRIPT_MAXARGS];	
  int		m_NumParams;

  CSString	m_Description;				/* Function description */
  long		m_OpCode;				/* Opcode data */
  long		m_Flags;				/* Function options */


  /*---------- Begin Protected Class Methods --------------------*/
protected:


  /*---------- Begin Public Class Methods -----------------------*/
public:

	/* Class Constructors/Destructors */
  CEsmScrFuncData();
  virtual ~CEsmScrFuncData() { Destroy(); }
  virtual void Destroy (void);

	/* Generates a parameter string for the given parameter */
  const TCHAR* CreateParamString (const int Index) const;
  const TCHAR* GetParamDetail    (const int Index) const;
  const TCHAR* GetFlagString     (void) const;

	/* Get class members */
  long		GetFlags	(void) const { return (m_Flags); }
  long		GetOpCode	(void) const { return (m_OpCode); }
  const TCHAR*	GetDescription	(void) const { return (m_Description); }
  int		GetNumParams	(void) const { return (m_NumParams); }
  long		GetReturnFlags	(void) const { return (m_ReturnFlags); }
  const TCHAR*	GetReturnDesc	(void) const { return (m_ReturnDesc); }
  const TCHAR*	GetFunction	(void) const { return (m_Function); }
  const TCHAR*  GetFuncForm	(void) const;
  const TCHAR*  GetExFuncForm	(const int ParamIndex = -1, const int LineLength = -1) const;
  const TCHAR*  GetWikiLink     (void) const { if (m_WikiLink[0] == NULL_CHAR) return m_Function; return m_WikiLink; }

	/* Get parameter members */
  const TCHAR*	GetParamDesc	(const int Index) const { return (IsValidIndex(Index) ? m_ParamDesc[Index]  : _T("")); }
  long		GetParamFlags	(const int Index) const { return (IsValidIndex(Index) ? m_ParamFlags[Index] : 0); }
  const TCHAR*  GetReturnString (void) const;

	/* Checks for a mathcing function name, case insensitive */
  bool IsName (const TCHAR* pName) const { return (TSTRICMP(m_Function, pName) == 0); }

	/* Check parameter index */
  bool IsValidIndex (const int Index) const { return (Index >= 0 && Index < m_NumParams); }

	/* Input a function data section from the given file */
  bool ReadData (CGenFile& File);

	/* Set class members */
  void SetDescription (const TCHAR* pString)	{ m_Description = pString; }
  void SetFlags	      (const long   Flags)	{ m_Flags = Flags; }
  void SetOpCode      (const long   OpCode)	{ m_OpCode = OpCode; }
  void SetReturnFlags (const long   Flags)	{ m_ReturnFlags = Flags; }
  void SetReturnDesc  (const TCHAR* pString)	{ strnncpy(m_ReturnDesc, pString, ESM_SFDATA_LINELENGTH); }
  void SetReturnValue (TCHAR* pValue);
  void SetFunction    (const TCHAR* pString)	{ strnncpy(m_Function, pString, ESM_SFDATA_NAMESIZE); }
  void SetWikiLink    (const TCHAR* pString)	{ strnncpy(m_WikiLink, pString, ESM_SFDATA_NAMESIZE); }

	/* Set parameter members */
  void SetParamFlags  (const int Index, const long   Flags)   { if (IsValidIndex(Index)) m_ParamFlags[Index] = Flags; }
  void SetParamDesc   (const int Index, const TCHAR* pString) { if (IsValidIndex(Index)) m_ParamDesc[Index] = pString; }
  void SetParamValue  (const int Index, TCHAR* pValue);

	/* Set a class member based on the input stirngs */
  bool SetValue (const TCHAR* pVariable, TCHAR* pValue);

 };
/*===========================================================================
 *		End of Class CEsmScrFuncData Definition
 *=========================================================================*/




#endif
/*===========================================================================
 *		End of File Esmscrfuncdata.H
 *=========================================================================*/

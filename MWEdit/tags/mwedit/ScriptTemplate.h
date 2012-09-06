/*===========================================================================
 *
 * File:	Scripttemplate.H
 * Author:	Dave Humphrey (uesp@m0use.net)
 * Created On:	October 8, 2003
 *
 * Defines the CEsmScriptTemplate class.
 *
 *=========================================================================*/
#ifndef __SCRIPTTEMPLATE_H
#define __SCRIPTTEMPLATE_H


/*===========================================================================
 *
 * Begin Required Includes
 *
 *=========================================================================*/
  #include "dl_err.h"
  #include "EsmScript.h"
  #include "contain/PtrArray.h"
  #include "file/csvfile.h"
/*===========================================================================
 *		End of Required Includes
 *=========================================================================*/


/*===========================================================================
 *
 * Begin Definitions
 *
 *=========================================================================*/

	/* Maximum size of template files */
  #define ESM_SCRTEMP_MAXTEMPSIZE	ESM_SCRIPT_MAXTEXT	

	/* Maximum size of template variables */
  #define ESM_SCRTEMP_MAXVARSIZE	31

	/* Template characters */
  #define ESM_SCRTEMP_TEMPCHAR1		'['
  #define ESM_SCRTEMP_TEMPCHAR2		']'

	/* File parameters */
  #define ESM_SCRTEMP_FILEEXT		_T("txt")
  #define ESM_SCRTEMP_FILEFILTER	_T("Text Files (*.txt)|*.txt|All Files (*.*)|*.*||")

	/* Special variable names */
  #define ESMSCRTEMP_CSV_SCRIPTNAME	_T("ScriptName")

/*===========================================================================
 *		End of Definitions
 *=========================================================================*/


/*===========================================================================
 *
 * Begin Type Definitions
 *
 *=========================================================================*/

	/* Holds information on a single template variable */
  typedef struct {
	TCHAR	Name[ESM_SCRTEMP_MAXVARSIZE+1];
	int	Uses;
	int	CsvColIndex;

	bool IsName  (const TCHAR* pString) { return (StringCompare(Name, pString, false) == 0); }
	void SetName (const TCHAR* pString) { strnncpy(Name, pString, ESM_SCRTEMP_MAXVARSIZE); }
   } esmscrtempvar_t;

  typedef TPtrArray<esmscrtempvar_t> CEsmScrTempVarArray;
  
/*===========================================================================
 *		End of Type Definitions
 *=========================================================================*/


/*===========================================================================
 *
 * Begin Class CEsmScriptTemplate Definition
 *
 * Handles the loading and parsing of script template files.
 *
 *=========================================================================*/
class CEsmScriptTemplate {

  /*---------- Begin Private Class Members ----------------------*/
private:
  CSString		m_TemplateText;		/* The template text buffer */
  CSString		m_Filename;
  CEsmScrTempVarArray	m_TemplateVars;

  CSString		m_ScriptName;		/* Used for conversion */
  

  /*---------- Begin Protected Class Methods --------------------*/
protected:

	/* Parses and adds a template variable */
  bool AddTemplateVariable (const TCHAR* pVariable, const int Length);


  /*---------- Begin Public Class Methods -----------------------*/
public:

	/* Class Constructors/Destructors */
  CEsmScriptTemplate();
  virtual ~CEsmScriptTemplate() { Destroy(); }
  virtual void Destroy (void);

  	/* Parses and adds a template variable */
  bool AddTemplateVar (const TCHAR* pVariable);

	/* Delete any defined template variables */
  void ClearTemplateVars (void);

	/* Converts a script template text buffer */
  bool ConvertText (TCHAR* pOutBuffer, const int BufferSize, CCsvRow* pRow);

	/* Attempt to find a template variable */
  esmscrtempvar_t* FindTemplateVar (const TCHAR* pVariable);

	/* Find a variable value from a csv row */
  CSString* GetCsvString (const TCHAR* pVarName, CCsvRow* pRow);
  
	/* Get class members */
  const TCHAR*	GetTemplateText (void) const { return (m_TemplateText); }
  const TCHAR*	GetFilename     (void) const { return (m_Filename); }
  int		GetTemplateSize (void) const { return (m_TemplateText.GetLength()); }
  int		GetNumTempVars  (void) const { return (m_TemplateVars.GetNumElements()); }

	/* Access a template variable */
  esmscrtempvar_t* GetTemplateVar     (const int Index) { return (m_TemplateVars.GetAt(Index)); }
  
	/* Attempt to load a script template file */
  bool Load (const TCHAR* pFilename);

	/* Parse the template text */
  bool ParseText (void);

	/* Set class members */
  void SetText       (const TCHAR* pString) { m_TemplateText = pString; }
  void SetScriptName (const TCHAR* pString) { m_ScriptName = pString; }


 };
/*===========================================================================
 *		End of Class CEsmScriptTemplate Definition
 *=========================================================================*/


#endif
/*===========================================================================
 *		End of File Scripttemplate.H
 *=========================================================================*/


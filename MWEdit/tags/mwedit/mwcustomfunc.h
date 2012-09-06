/*===========================================================================
 *
 * File:	Mwcustomfunc.H
 * Author:	Dave Humphrey (uesp@m0use.net)
 * Created On:	August 21, 2006
 *
 * Description
 *
 *=========================================================================*/
#ifndef __MWCUSTOMFUNC_H
#define __MWCUSTOMFUNC_H


/*===========================================================================
 *
 * Begin Required Includes
 *
 *=========================================================================*/
  #include "file/genfile.h"
  #include "string/sstring.h"
  #include "contain/dl_map.h"
  #include "Esmscriptdefs.h"
/*===========================================================================
 *		End of Required Includes
 *=========================================================================*/


/*===========================================================================
 *
 * Begin Class CMwCustomFunction Definition
 *
 * Description
 *
 *=========================================================================*/
class CMwCustomFunction {

  /*---------- Begin Private Class Members ----------------------*/
private:
  esmscrfuncinfo_t m_Data;	/* Function data */
  dword		   m_LineCount;


  /*---------- Begin Protected Class Methods --------------------*/
protected:

  bool ParseFuncOptions    (dword& Options, const char* pValue);
  bool ParseFuncArgOptions (dword& Options, const char* pValue);
  bool ParseReturnOptions  (dword& Options, const char* pValue);


  /*---------- Begin Public Class Methods -----------------------*/
public:

	/* Class Constructors/Destructors */
  CMwCustomFunction();
  //virtual ~CMwCustomFunction() { Destroy(); }
  //virtual void Destroy (void);

	/* Get class members */
  esmscrfuncinfo_t& GetData (void) { return (m_Data); }
  const char*       GetName (void) { return (m_Data.Name); }

	/* Read in function parameters from a file */
  bool Read (CGenFile& File, dword& LineCount);

	/* Sets a parameter based on the string inputs */
  bool SetParameter (const char* pVariable, const char* pValue);

	/* Set class members */
  void SetName          (const char* pValue) { strnncpy(m_Data.Name, pValue, MWESM_SCRIPT_FUNCNAMESIZE); } 
  void SetOpCode        (const short Value)  { m_Data.OpCode = Value; }
  void SetOptions       (const dword Value)  { m_Data.Flags  = Value; }
  void SetReturnOptions (const dword Value)  { m_Data.Return = Value; }
  void SetArgOptions    (const dword Index, const dword Value) { if (Index <= MWESM_SCRIPT_MAXARGS) m_Data.Var[Index] = Value; }

 };
/*===========================================================================
 *		End of Class CMwCustomFunction Definition
 *=========================================================================*/


/*===========================================================================
 *
 * Begin Type Definitions
 *
 *=========================================================================*/

	/* Map of custom functions */
  typedef TGenMap<CSString, CMwCustomFunction*, const char*> CMwCustomFunctions;

/*===========================================================================
 *		End of Type Definitions
 *=========================================================================*/


/*===========================================================================
 *
 * Begin Functions
 *
 *=========================================================================*/

	/* Input functions from a file */
   bool ReadMwCustomFunctions (CMwCustomFunctions& Functions, const char* pFilename);

/*===========================================================================
 *		End of Functions
 *=========================================================================*/


/*===========================================================================
 *
 * Begin External Definitions
 *
 *=========================================================================*/

	/* Global custom function map */
  extern CMwCustomFunctions g_CustomFunctions;

/*===========================================================================
 *		End of External Definitions
 *=========================================================================*/


#endif
/*===========================================================================
 *		End of File Mwcustomfunc.H
 *=========================================================================*/

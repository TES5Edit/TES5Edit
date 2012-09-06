/*===========================================================================
 *
 * File:	Esmscripterror.H
 * Author:	Dave Humphrey (uesp@m0use.net)
 * Created On:	September 3, 2003
 *
 * Description
 *
 *=========================================================================*/
#ifndef __ESMSCRIPTERROR_H
#define __ESMSCRIPTERROR_H


/*===========================================================================
 *
 * Begin Required Includes
 *
 *=========================================================================*/
  #include "dl_err.h"
  #include "EsmScriptDefs.h"
  #include "string/sstring.h"
  #include "contain/ptrarray.h"
/*===========================================================================
 *		End of Required Includes
 *=========================================================================*/


/*===========================================================================
 *
 * Begin Definitions
 *
 *=========================================================================*/

	/* Error/warning types */

  #define ESMSCR_ERROR_TOOMANYARGS	-1008
  #define ESMSCR_ERROR_BADFUNCARG	-1007
  #define ESMSCR_ERROR_MISC		-1006
  #define ESMSCR_ERROR_MULTREF		-1005
  #define ESMSCR_ERROR_BADNUMBER	-1004
  #define ESMSCR_ERROR_BADTOKEN		-1003
  #define ESMSCR_ERROR_BADID		-1002
  #define ESMSCR_ERROR_BADLOCAL		-1001
  #define ESMSCR_WARNING_NOCOMMA	1001
  #define ESMSCR_WARNING_BADFUNCARG	1002
  #define ESMSCR_WARNING_BADFUNCVAR	1003 
  #define ESMSCR_WARNING_NOSPACE	1004
  #define ESMSCR_WARNING_IDCONFLICT	1005
  #define ESMSCR_WARNING_BADVARSTART	1006
  #define ESMSCR_WARNING_BADFUNCTION	1007
  #define ESMSCR_WARNING_EXTFUNC	1008
  #define ESMSCR_WARNING_EXPANSIONFUNC	1009
  #define ESMSCR_WARNING_LOCALVAR34	1010
  #define ESMSCR_WARNING_DIALOGFUNC	1011

	/* Message types */
  #define ESMSCR_MESSAGE_WARNING 0
  #define ESMSCR_MESSAGE_ERROR	 1


/*===========================================================================
 *		End of Definitions
 *=========================================================================*/


/*===========================================================================
 *
 * Begin Class CEsmScriptError Definition
 *
 * Holds the information on a single script error or warning message
 * encountered during compiling.
 *
 *=========================================================================*/
class CEsmScriptError {

  /*---------- Begin Private Class Members ----------------------*/
private:
  CSString	m_Message;		/* Error message */
  int		m_Code;			/* Error code */
  int		m_Type;			/* Is this a warning or error */

  int		m_Line;			/* Location of error */
  int		m_Character;

  int		m_TokenID;		/* Token where error occurred */
  CSString	m_Token;
  
  esmscrfuncinfo_t*	m_pFunction;	/* Function information if available */
  int			m_NumFuncArgs;
  int			m_FuncArgIndex;


  /*---------- Begin Protected Class Methods --------------------*/
protected:


  /*---------- Begin Public Class Methods -----------------------*/
public:

	/* Class Constructors/Destructors */
  CEsmScriptError();
  virtual ~CEsmScriptError() { Destroy(); }
  virtual void Destroy (void);

	/* Get class members */
  const TCHAR*	GetMessage	(void) const { return (m_Message); }
  const TCHAR*  GetToken	(void) const { return (m_Token); }
  const TCHAR*  GetTypeString	(void) const { return (IsError() ? _T("Error") : _T("Warning")); }
  const TCHAR*  GetFuncArgString(void) const;
  int		GetTokenID	(void) const { return (m_TokenID); }
  int		GetNumFuncArgs	(void) const { return (m_NumFuncArgs); }
  int		GetFuncArgIndex	(void) const { return (m_FuncArgIndex); }
  int		GetErrorCode	(void) const { return (m_Code); }
  int		GetLine		(void) const { return (m_Line); }
  int		GetCharacter	(void) const { return (m_Character); }
  bool		IsError		(void) const { return (m_Type == ESMSCR_MESSAGE_ERROR); }
  bool		IsWarning	(void) const { return (m_Type == ESMSCR_MESSAGE_WARNING); }
  esmscrfuncinfo_t* GetFunction (void)       { return (m_pFunction); }
  
	/* Set class members */
  void SetMessage	(const TCHAR* pString)	{ m_Message = pString; }
  void SetToken		(const TCHAR* pString)	{ m_Token = pString; }
  void SetTokenID	(const int TokenID)	{ m_TokenID = TokenID; }
  void SetNumFuncArgs   (const int Value)	{ m_NumFuncArgs = Value; }
  void SetFuncArgIndex  (const int Index)	{ m_FuncArgIndex = Index; }
  void SetCode		(const int Code)	{ m_Code = Code; }
  void SetLine		(const int Line)	{ m_Line = Line; }
  void SetCharacter	(const int Char)	{ m_Character = Char; }
  void SetType		(const int Type)	{ m_Type = Type; }
  void SetTypeError	(void)			{ m_Type = ESMSCR_MESSAGE_ERROR; }
  void SetTypeWarning	(void)			{ m_Type = ESMSCR_MESSAGE_WARNING; }
  void SetFunction (esmscrfuncinfo_t* pFunction) { m_pFunction = pFunction; }

 };

	/* Array of script error pointers */
  typedef TPtrArray<CEsmScriptError> CEsmScriptErrArray;

/*===========================================================================
 *		End of Class CEsmScriptError Definition
 *=========================================================================*/


#endif
/*===========================================================================
 *		End of File Esmscripterror.H
 *=========================================================================*/

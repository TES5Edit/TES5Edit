/*===========================================================================
 *
 * File:	Esmscriptcompile.H
 * Author:	Dave Humphrey (uesp@m0use.net)
 * Created On:	Friday, February 14, 2003
 *
 * Description
 *
 *=========================================================================*/
#ifndef __ESMSCRIPTCOMPILE_H
#define __ESMSCRIPTCOMPILE_H


/*===========================================================================
 *
 * Begin Required Includes
 *
 *=========================================================================*/
  #include "EsmScriptDefs.h"
  #include "EsmScriptError.h"
  #include "string/SString.h"
  #include "contain/PtrArray.h"
  #include "contain/GenStack.h"
  #include "mwcustomfunc.h"
  #include "esmfile.h"

#ifdef MWEDIT_SCRIPT_MWSE
  #include <queue>
  #include <stack>
#endif
/*===========================================================================
 *		End of Required Includes
 *=========================================================================*/


/*===========================================================================
 *
 * Begin Definitions
 *
 *=========================================================================*/

	/* Token flags */
  #define ESTF_ONE	1
  #define ESTF_MANY	2
  #define ESTF_OPT	4
  #define ESTF_STOP	8

	/* Used to detect the special 34th local variable bug */
  #define ESMSCR_SPECIALLOCALVAR_INDEX	33

	/* Return codes */
  #define ESMSCR_RESULT_OK	 0
  #define ESMSCR_RESULT_ERROR	-1
  #define ESMSCR_RESULT_WARNING  1
  #define ESMSCR_RESULT_BLOCKEND 2
  #define ESMSCR_RESULT_TABLEEND 3
  #define ESMSCR_RESULT_NOTOKEN  4

	/* Special function opcodes */
  #define ESMSCR_FUNCOPCODE_MESSAGEBOX 0x1000

	/* Flags for custom character types */
  #define ESMSCR_CHARTYPE_SPACE		1
  #define ESMSCR_CHARTYPE_PUNCT		2
  #define ESMSCR_CHARTYPE_DIGIT		4
  #define ESMSCR_CHARTYPE_SYMBOLF	8
  #define ESMSCR_CHARTYPE_SYMBOL	16

	/* Special characters */
  #define ESMSCR_CHAR_EOL	'\r'
  #define ESMSCR_CHAR_COMMENT	';'
  #define ESMSCR_CHAR_STRING	'"'

	/* Max defined variable length */
  #define ESMSCR_VAR_MAXLENGTH 32

	/* Maximum compiled script data length */
  #define ESMSCR_DATA_SIZE 65535

	/* Number of local variables allowed (game limited?) */
  #define ESMSCR_MAX_LOCALVARS 255

	/* Variable types */
  #define ESMSCR_VAR_UNKNOWN -1
  #define ESMSCR_VAR_SHORT    0
  #define ESMSCR_VAR_LONG     1
  #define ESMSCR_VAR_FLOAT    2

	/* Compiler message levels */
  #define ESMSCR_MSGLEVEL_ERROR		-1
  #define ESMSCR_MSGLEVEL_NONE		0
  #define ESMSCR_MSGLEVEL_WARNING	 1

  #define ESMSCR_MAX_FUNCARGS MWESM_SCRIPT_MAXARGS

	/* Return values for checking function arguments */
  #define ESMSC_FUNCARG_OK	 0
  #define ESMSC_FUNCARG_ERROR	 -1
  #define ESMSC_FUNCARG_ENDTABLE -2
  
	/* Number of message IDs */
  #define ESMSCR_MAX_MESSAGES 64

	/* Max token string length for stack */
  #define ESMSCR_STACK_MAXTOKENSIZE	63

/*===========================================================================
 *		End of Definitions
 *=========================================================================*/


/*===========================================================================
 *
 * Begin Type Definitions
 *
 *=========================================================================*/

	/* Class forward definition */
  class CEsmScriptCompile;
  class CMWEditDoc;

	/* Custom block parsing function type */
  typedef int (CEsmScriptCompile::*ESMSCRBLOCK_FUNC) (void);

	/* Token parsing table structure */
  typedef struct espt_TAG {
	int		 TokenID;
	int 		 Flags;
	espt_TAG*	 pParseTable;
	ESMSCRBLOCK_FUNC ParseFunc;
	ESMSCRBLOCK_FUNC OutputFunc;
   } esmscrparsetable_t;

	/* Holds defined type information */
  typedef struct {
	TCHAR	Name[ESMSCR_VAR_MAXLENGTH+1];
	int	Type;

	void SetName (const TCHAR* pString) { strnncpy(Name, pString, ESMSCR_VAR_MAXLENGTH); }
   } esmscrtypeinfo_t;

	/* Holds message level values */
  struct emscrmsglevel_t {
	int MessageID;
	int Level;
   };

	/* Used for the expression stack */
  struct esmscrstack_t {
	int	TokenID;
	TCHAR	Token[ESMSCR_STACK_MAXTOKENSIZE+1];
   };

	/* Used for IF statement blocks and the if statement stack */
  struct esmscrifblock_t {
	int	IfStartPos;
	int	StartStatementCount;
   };


/*===========================================================================
 *		End of Type Definitions
 *=========================================================================*/


/*===========================================================================
 *
 * Begin Class CEsmScriptCompile Definition
 *
 * Description
 *
 *=========================================================================*/
class CEsmScriptCompile {

  /*---------- Begin Protected Class Members --------------------*/
protected:
  CMWEditDoc*		m_pDocument;		/* Parent document */

  static CEsmFile	  m_ExtraFile;		/* Used to find 'extra' records */
  static CEsmRecordRefMap m_ExtraRecords;
	
  TCHAR*		m_pScriptText;		/* Raw script text buffer */
  byte*			m_pOutBuffer;		/* Compiled script output buffer */
  CSString		m_ScriptName;		/* Script ID */

  TCHAR*		m_pParse;		/* Current parsing buffer position */

  CSString		m_Token;		/* Current token parsing information */
  CSString		m_LastToken;
  int			m_TokenID;
  int			m_CurrentLine;
  int			m_CurrentCharPos;
  int			m_StartCharPos;
  int			m_StartLine;
  bool			m_TokenParsed;
  bool			m_LineHasRef;
  CSString		m_LineRefToken;
  int			m_LineRefID;
  bool			m_LastTokenNegative;
  bool			m_LastSetNegative;

  esmscrfuncinfo_t*	m_pCurrentFunc;		/* Used when parsing a function statement block */
  int			m_NumFuncArgs;
  int			m_LastFuncArg;
  int			m_FuncArgIndex;

  CSString		m_ErrorMessage;		/* Holds the last compiler error message */
  bool			m_HasErrorMsg;
  int			m_NumErrors;
  int			m_NumWarnings;

  CEsmScriptErrArray	m_ErrorArray;		/* Array of script errors from last compile */

  int*			m_pCharTypes;		/* Pointer to a character type array */

	/* Holds the script local variable definitions */
  esmscrtypeinfo_t	m_ShortVars[ESMSCR_MAX_LOCALVARS];
  esmscrtypeinfo_t	m_LongVars[ESMSCR_MAX_LOCALVARS];
  esmscrtypeinfo_t	m_FloatVars[ESMSCR_MAX_LOCALVARS];
  int			m_NumShortVars;
  int			m_NumLongVars;
  int			m_NumFloatVars;

	/* Compile warning/error options */
  emscrmsglevel_t	m_MsgLevels[ESMSCR_MAX_MESSAGES];
  int			m_NumMsgLevels;

#ifdef MWEDIT_SCRIPT_MWSE

  CSString		m_refObject;

	/* Extended function param stack */
  std::stack<esmscrstack_t*>	m_ArgXStack;
  
  	/* Extended function result queue */
  std::queue<esmscrstack_t*>	m_LetQueue;
  
  /* Extended function if stack */
  std::stack<esmscrifblock_t*>	m_XIfStack;

#endif

	/* Expression stack */
  CGenStack		m_ExprStack;
  int			m_NumOutputExpr;

  char*			m_pLocalVarData;	/* Holds the local variable block data */
  int			m_LocalVarDataSize;

  char			m_ScriptData[ESMSCR_DATA_SIZE];
  int			m_ScriptDataSize;
  int			m_LastLineDataPos;
  int			m_LastIfPos;
  int			m_LastSetPos;
  int			m_NumSetExpr;
  bool			m_IsEmptyIf;
  bool			m_LastSetSymbol;
  bool			m_IsSetExpr;
  bool			m_OutputFuncIDRef;
  int			m_LastMsgBoxBut;
  int			m_LastMsgBoxArgs;
  int			m_NumMsgButtons;
  int			m_NumMsgArgs;
  int			m_ManyArgPos;
  bool			m_LastFuncArgSymbol;
  int			m_FuncOptCount;
  int			m_FuncOptPos;
  int			m_StatementCount;

  CGenStack		m_IfStatementStack;	/* Tracks statement count for if statements */


  /*---------- Begin Protected Class Methods --------------------*/
protected:

	/* Add a local variable to the defined array */
  bool AddLocalVar (const TCHAR* pName, const int Type);

	/* Add compiled script data */
  bool AddScriptData (const void* pData, const int Size);
  bool InsertScriptDataRef (const TCHAR* pData, int Size);

	/* Adds an if statement block data to the stack */
  bool AddIfBlock (const int StatementCount, const int ScriptPos);

	/* Add error or warning messages */
  void AddError   (const TCHAR* pString, ...);
  void AddWarning (const TCHAR* pString, ...);
  bool AddMessage (const int MessageID, const TCHAR* pString, ...);

	/* Ensure that the current token is the given type */
  int AssertToken (const int Token);
  int AssertToken (const int Token1, const int Token2);

	/* Checks to see if given function argument ID is valid */
  bool CheckFuncID  (const long ArgFlags, const TCHAR* pID, const bool Optional);
  bool CheckFuncID1 (const long ArgFlags, const TCHAR* pID, const bool Optional);

	/* Checks if the current function parameter/argument is valid */
  int CheckFuncArg (void);

	/* Delete any objects that remain in the expression stack */
  void ClearExprStack        (void);
  void ClearIfStatementStack (void);

	/* Find a record in the parent document or extra file */
  CEsmRecord* FindRecord          (const char* pID);
  CEsmRecord* FindRecord          (const char* pID, const char* pType);
  CEsmRecord* FindRecordCarryable (const char* pID);

	/* Find various symbols */
  bool        FindLocalVar      (const TCHAR* pName);
  int         FindLocalVarIndex (const TCHAR* pName, char& Type);
  int         GetGlobalType     (const TCHAR* pName);
  CEsmGlobal* GetGlobal         (const TCHAR* pName);
  bool        IsSymbolID        (CSString& Token);
  short       GetAnimGroupID    (const TCHAR* pString);

	/* Converts a function argument ID type flags to a string */
  const TCHAR* GetFuncArgIDType  (const long FuncArgs);
  const TCHAR* GetFuncArgRefType (const long FuncArgs);

	/* Generates the script local variable data block */
  void MakeScriptVarData (void);
  int  ComputeLocalVarDataSize (void);

	/* Get the top if statement block from the stack */
  esmscrifblock_t* PopIfBlock (void);


  /*---------- Begin Public Class Methods -----------------------*/
public:

	/* Class Constructors/Destructors */
  CEsmScriptCompile();
  virtual ~CEsmScriptCompile() { Destroy(); }
  virtual void Destroy (void);

	/* Delete all the current compiler errors */
  void ClearErrors (void);

	/* Main access method */
  int Compile (void);

	/* Find the message level corresponding to the given message ID */
  int FindMsgLevel (const int MessageID);

	/* Get class members */
  char* GetLocalVarData      (void) { return (m_pLocalVarData); }
  char* GetScriptData        (void) { return (m_ScriptData); }
  const TCHAR* GetScriptName (void) { return (m_ScriptName); }
  int   GetScriptDataSize    (void) { return (m_ScriptDataSize); }
  int   GetLocalVarDataSize  (void) { return (m_LocalVarDataSize); }
  int   GetNumShortLocals    (void) { return (m_NumShortVars); }
  int   GetNumLongLocals     (void) { return (m_NumLongVars); }
  int   GetNumFloatLocals    (void) { return (m_NumFloatVars); }
  int   GetNumErrors	     (void) { return (m_NumErrors); }
  int   GetNumWarnings	     (void) { return (m_NumWarnings); }
  bool  HasScriptName	     (void) { return (!m_ScriptName.IsEmpty()); }

	/* Access the extra file member */
  static CEsmFile& GetExtraFile (void) { return (m_ExtraFile); }

  CEsmScriptErrArray* GetErrorArray   (void) { return (&m_ErrorArray); }
  esmscrfuncinfo_t*   GetCurrentFunc  (void) { return (m_pCurrentFunc); }
  int		      GetNumFuncArgs  (void) { return (m_NumFuncArgs); }
  int		      GetLastFuncArg  (void) { return (m_LastFuncArg); }
  int		      GetFuncArgIndex (void) { return (m_FuncArgIndex); }

  CSString* GetToken		(void) { return (&m_Token); }
  int       GetTokenID		(void) { return (m_TokenID); }
  int	    GetCurrentChar	(void) { return (m_CurrentCharPos); }
  int	    GetCurrentLine	(void) { return (m_CurrentLine); }

	/* Initialize the extra record map */
  static void InitializeExtraRecords (void);

	/* Parse table callback functions */
  int ParseNewLocalVar   (void);
  int ParseFuncRef       (void);
  int ParseVarRef        (void);
  int ParseIfVarRef      (void);
  int ParseVarRef1       (const bool InIf);
  int ParseStringID      (void);
  int ParseStringIDSet   (void);
  int ParseStringIDIf    (void);
  int ParseStringIDPush  (void);
  int ParsePushStringID  (void);
  int ParseLineStringID  (void) { m_StatementCount++; return (ParseStringID()); }
  int ParseFunctionLine  (void) { m_StatementCount++; return (ESMSCR_RESULT_OK); }
  int ParseSymbolID      (void);
  int ParsePushSymbolID  (void);
  int ParseLineSymbolID  (void) { m_StatementCount++; return (ParseSymbolID()); }
  int ParseFuncArg       (void);
  int ParseCheckFuncArg  (void);
  int ParseChoiceFunction (void);
  int ParseFunction      (void);
  int ParseFuncArg1      (void);
  int ParseFuncComma     (void);
  int ParseFuncEnd       (void);
  int ParseRExprStart    (void);
  int ParseIfRExprStart  (void);
  int ParsePushToken     (void);
  int ParseFuncAddOp     (void);
  int ParseSetFirstAddOp (void);

  	/* Character type functions */
  bool IsParseDigit      (void) { return ((m_pCharTypes[(*m_pParse) & 0xFF] & ESMSCR_CHARTYPE_DIGIT)   != 0); }
  bool IsParseOperator   (void) { return ((m_pCharTypes[(*m_pParse) & 0xFF] & ESMSCR_CHARTYPE_PUNCT)   != 0); }
  bool IsParseSymbol     (void) { return ((m_pCharTypes[(*m_pParse) & 0xFF] & ESMSCR_CHARTYPE_SYMBOL)  != 0); }
  bool IsParseSymbolF    (void) { return ((m_pCharTypes[(*m_pParse) & 0xFF] & ESMSCR_CHARTYPE_SYMBOLF) != 0); }
  bool IsParseComment    (void) { return (*m_pParse == ESMSCR_CHAR_COMMENT); }
  bool IsParseStringChar (void) { return (*m_pParse == ESMSCR_CHAR_STRING); }
  bool IsParseWhiteSpace (void) { return (m_pCharTypes[(*m_pParse) & 0xFF] & ESMSCR_CHARTYPE_SPACE != 0); }

	/* Get/skip the base token types */
  int  GetNextToken		(void);
  int  GetNumberToken		(void);
  int  GetOperatorToken		(void);
  int  GetStringToken		(void);
  int  GetSymbolToken		(void);
  void SkipTokenComment		(void);
  void SkipTokenWhiteSpace	(void);

	/* Output table callback methods */
  int OutputToken    (const short Value);
  int OutputOneExpr  (void);
  int OutputEnd      (void) { m_StatementCount++; return OutputToken(0x0101); }
  int OutputEndWhile (void);
  int OutputIf       (void);
  int OutputElseIf   (void);
  int OutputElse     (void);
  int OutputEndIf    (void);
  int OutputWhile    (void);
  int OutputWhileFinish (void);
  int OutputReturn   (void) { m_StatementCount++; return OutputToken(0x0124); }
  int OutputSet      (void);
  int OutputObjRef   (void) { return OutputToken(0x010c); }
  int OutputIfLocal  (void);
  int OutputIfGlobal (void);
  int OutputIfRelOp  (void);
  int OutputIfRAddOp  (void);
  int OutputIfRNumber (void);
  int OutputIfRLocal  (void);
  int OutputIfRGlobal (void);
  int OutputIfEmpty   (void);
  int OutputIfFinish  (void);
  int OutputIfFunction (void);
  int OutputSetLocal  (void);
  int OutputSetGlobal (void);
  int OutputSetEnd    (void);
  int OutputExprStack (void);
  int OutputIfLeftExprStack (void);
  int OutputIfRightExprStack (void);
  int OutputFunction  (void);
  int OutputLineFunction (void);
  int OutputFuncArgXYZ    (void);
  int OutputFuncArgNum    (void);
  int OutputFuncArgGlobal (void);
  int OutputFuncArgLocal  (void);
  int OutputFuncArgStrSym (void);
  int OutputFuncArgSym    (void);
  int OutputFuncArgString (void);
  int OutputFuncArgReset  (void);
  int OutputFuncEnd       (void);
  int OutputScriptName (void) { m_ScriptName = m_Token; return (0); }

  int OutputFuncArgAnim  (const short AnimID) { return AddScriptData(&AnimID, 2); }
  int OutputEffect	 (const int EffectID);

    	
#ifdef MWEDIT_SCRIPT_MWSE

  int ParseFuncArgX (void);

	/* Fake output functions, the tokens are stored in a stack to be output in the correct order */
  int PushFuncXArgLocal  (void);
  int PushFuncXArgNum    (void);
  int PushFuncXArgString (void);
  int PushLetLocal       (void);
  int PushFuncOp         (void);

  	/* Output extended function params from the stack */
  int   OutputFuncOp		  (void);
  int   OutputStoredFuncOp	  (void);
  int   WriteFuncOp		  (const TCHAR* ident);
  int   OutputFuncXArgLocal	  (const TCHAR* name);
  int   OutputFuncXArgNum	  (int type, const TCHAR* token);
  char* OutputFuncXArgStringCat   (char* buf, const void* newdata, int newdatalen);
  int   OutputFuncXArgString      (const TCHAR* token);
  int   OutputFuncXBlock          (void);
  int   OutputLetEnd              (void);
  int   PushFuncXArg              (int type, const TCHAR* token);

   	/* Output extended if commands */
  int OutputXIf     (void);
  int OutputXElse   (void);
  int OutputXElseIf (void);
  int OutputXEndIf  (void);
#endif
  
  	/* Output extended while commands */
  int OutputXWhile    (void);
  int OutputXEndWhile (void);

  	/* Parse the given table */
  int ParseTable     (esmscrparsetable_t* pTable);
  int ParseTableMany (esmscrparsetable_t& TableEntry);
  int ParseTableOne  (esmscrparsetable_t& TableEntry);

	/* Set various message levels */
  void SetDefaultMsgLevels (void);
  void SetWeakMsgLevels    (void);
  void SetStrongMsgLevels  (void);

	/* Set the script text to be compiled */
  void SetScriptText (const TCHAR* pString, const int Size);

	/* Set class members */
  void SetDocument (CMWEditDoc* pDoc) { m_pDocument = pDoc; }
  void SetMsgLevel (const int Type);

	/* Updates the statement count from the previous if block */
  int UpdateLastIfBlock (void);

 };
/*===========================================================================
 *		End of Class CEsmScriptCompile Definition
 *=========================================================================*/


#endif
/*===========================================================================
 *		End of File Esmscriptcompile.H
 *=========================================================================*/

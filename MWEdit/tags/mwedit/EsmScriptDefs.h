/*===========================================================================
 *
 * File:	Esmscriptdefs.H
 * Author:	Dave Humphrey (uesp@m0use.net)
 * Created On:	Wednesday, February 12, 2003
 *
 * Description
 *
 *=========================================================================*/
#ifndef __ESMSCRIPTDEFS_H
#define __ESMSCRIPTDEFS_H


#define MWEDIT_SCRIPT_MWSE

/*===========================================================================
 *
 * Begin Required Includes
 *
 *=========================================================================*/
  #include "dl_err.h"
/*===========================================================================
 *		End of Required Includes
 *=========================================================================*/


/*===========================================================================
 *
 * Begin Definitions
 *
 *=========================================================================*/
	
	/* Number of script word types */
  #define MWESM_SCRIPT_NUMRESERVED	16
  #define MWESM_SCRIPT_NUMFUNCTIONS	444

	/* Arbitrary number of arguments allowed */
  #define MWESM_SCRIPT_MAXARGS 13

  	/* Arbitrary function name size */
  #define MWESM_SCRIPT_FUNCNAMESIZE	31

	/* Number of buttons/arguments allowed in the MessageBox function */
  #define MWESM_SCRIPT_MAXMSGBUTTONS	9
  #define MWESM_SCRIPT_MAXMSGARGS	9

	/* Maximum size of if expressions/statement counts */
  #define MWESM_SCRIPT_MAXIFSTATEMENTS	255
  #define MWESM_SCRIPT_MAXIFEXPRESSIONS	255
  
	/* Script token definitions */
  #define ESMSCR_BEGINBLOCK		-2
  #define ESMSCR_ENDTABLE		-1
  #define ESMSCR_TOKEN_UNKNOWN		0
  #define ESMSCR_TOKEN_INTEGER		1
  #define ESMSCR_TOKEN_FLOAT		2
  #define ESMSCR_TOKEN_STRING		3
  #define ESMSCR_TOKEN_SYMBOL		4
  #define ESMSCR_TOKEN_OPERATOR		5
  #define ESMSCR_TOKEN_EOL		6
  #define ESMSCR_TOKEN_EOS		7
  #define ESMSCR_TOKEN_BEGIN		8
  #define ESMSCR_TOKEN_END		9
  #define ESMSCR_TOKEN_TYPEOP		10
  #define ESMSCR_TOKEN_SET		11
  #define ESMSCR_TOKEN_TO		12
  #define ESMSCR_TOKEN_OPENBRAC		13
  #define ESMSCR_TOKEN_CLOSEBRAC	14
  #define ESMSCR_TOKEN_ADDOP		15
  #define ESMSCR_TOKEN_MULOP		16
  #define ESMSCR_TOKEN_RELOP		17
  #define ESMSCR_TOKEN_IF		18
  #define ESMSCR_TOKEN_ELSEIF		19
  #define ESMSCR_TOKEN_ELSE		20
  #define ESMSCR_TOKEN_ENDIF		21
  #define ESMSCR_TOKEN_WHILE		22
  #define ESMSCR_TOKEN_ENDWHILE		23
  #define ESMSCR_TOKEN_RETURN		24
  #define ESMSCR_TOKEN_GET		25
  #define ESMSCR_TOKEN_NUMBER		26
  #define ESMSCR_TOKEN_COMMA		27
  #define ESMSCR_TOKEN_FUNCOP		28
  #define ESMSCR_TOKEN_VAROP		29
  #define ESMSCR_TOKEN_XYZ		30
  #define ESMSCR_TOKEN_LOCALVAR		31
  #define ESMSCR_TOKEN_GLOBALVAR	32
  #define ESMSCR_TOKEN_FUNCTION		33
  #define ESMSCR_TOKEN_SYMBOLID		34
  #define ESMSCR_TOKEN_RESET		35

#ifdef MWEDIT_SCRIPT_MWSE
  #define ESMSCR_TOKEN_FUNCTIONX	36
  #define ESMSCR_TOKEN_SETX		37
  #define ESMSCR_TOKEN_IFX		38
  #define ESMSCR_TOKEN_WHILEX		39
  #define ESMSCR_FUNC_LOCALVAR		0x00010000
#endif

	/* Function flags */
  #define ESMSCR_FUNC_SHORTVAR	  0x00000001
  #define ESMSCR_FUNC_ALLOWGLOBAL 0x00000002
  #define ESMSCR_FUNC_EXTRASHORT  0x00000004
  #define ESMSCR_FUNC_NOOPTOUT    0x00000008
  #define ESMSCR_FUNC_BLOODMOON	  0x00000400
  #define ESMSCR_FUNC_TRIBUNAL	  0x00000800
  #define ESMSCR_FUNC_DIALOGUE    0x00001000
  #define ESMSCR_FUNC_BAD	  0x00002000
  #define ESMSCR_FUNC_VAR	  0x00004000

#ifdef MWEDIT_SCRIPT_MWSE
  #define ESMSCR_FUNC_MWSE	  0x00008000
  #define ESMSCR_FUNC_MWE	  0x00010000
#endif
  
	/* Function argument flags */
  #define ESMSCR_FUNC_BYTE	 0x00000001
  #define ESMSCR_FUNC_SHORT	 0x00000002
  #define ESMSCR_FUNC_LONG	 0x00000004
  #define ESMSCR_FUNC_FLOAT	 0x00000008
  #define ESMSCR_FUNC_NUMBER	 0x0000000F
  #define ESMSCR_FUNC_STRING	 0x00000010
  #define ESMSCR_FUNC_ID	 0x00000020
  #define ESMSCR_FUNC_XYZ	 0x00000040
  #define ESMSCR_FUNC_EFFECT	 0x00000080
  #define ESMSCR_FUNC_RESET	 0x00000100
  #define ESMSCR_FUNC_ANIM	 0x00000200
  #define ESMSCR_FUNC_OPTSTART	 0x00000400
  #define ESMSCR_FUNC_OPTIONAL	 0x00000800
  #define ESMSCR_FUNC_NOTREQ	 0x00001000
  #define ESMSCR_FUNC_CELLSTR	 0x00002000
  #define ESMSCR_FUNC_SHORTSTR	 0x00004000
  #define ESMSCR_FUNC_MANY	 0x00008000
  #define ESMSCR_FUNC_VARMASK    0x000003FF

  #define ESMSCR_FUNC_SCRIPTID   0x00010000
  #define ESMSCR_FUNC_SOUNDID    0x00020000
  #define ESMSCR_FUNC_RACEID     0x00040000
  #define ESMSCR_FUNC_JOURNALID  0x00080000
  #define ESMSCR_FUNC_FACTIONID  0x00100000
  #define ESMSCR_FUNC_ITEMID	 0x00200000
  #define ESMSCR_FUNC_REGIONID	 0x00400000
  #define ESMSCR_FUNC_TOPICID    0x00800000
  #define ESMSCR_FUNC_CELLID     0x01000000
  #define ESMSCR_FUNC_EFFECTID   0x02000000
  #define ESMSCR_FUNC_LEVELCID   0x04000000
  #define ESMSCR_FUNC_LEVELIID   0x08000000
  #define ESMSCR_FUNC_SOULGEMID  0x10000000
  #define ESMSCR_FUNC_CREATUREID 0x20000000
  #define ESMSCR_FUNC_SPELLID	 0x40000000
  #define ESMSCR_FUNC_NPCID      0x80000000
  #define ESMSCR_FUNC_IDMASK	 0xFFFF0000

  #define ESMSCR_FUNC_NOOUTPUT   0x100000000

	/* Custom event message IDs */
  #define MSG_SCRIPTFRM_CLEARERROR  (WM_USER + 1071)
  #define MSG_SCRIPTFRM_UPDATEERROR (WM_USER + 1072)
  #define MSG_SCRIPTFRM_GOTOLINE    (WM_USER + 1073)
  #define MSG_SCRIPTFRM_VIEWERROR   (WM_USER + 1074)

/*===========================================================================
 *		End of Definitions
 *=========================================================================*/


/*===========================================================================
 *
 * Begin MWSE OpCodes
 *
 *=========================================================================*/
#ifdef MWEDIT_SCRIPT_MWSE

  #define MWESM_OPCODE_COPYFROMSTACK		0x3807
  #define MWESM_OPCODE_JUMP			0x3809
  #define MWESM_OPCODE_JUMPSHORT		0x380a
  #define MWESM_OPCODE_JUMPSHORTZERO		0x380c
  #define MWESM_OPCODE_JUMPSHORTNOTZERO		0x380e
  #define MWESM_OPCODE_JUMPSHORTNOTNEGATIVE	0x3817
  #define MWESM_OPCODE_JUMPSHORTNEGATIVE	0x3819
  #define MWESM_OPCODE_SUB			0x3821
  #define MWESM_OPCODE_MUL			0x3822
  #define MWESM_OPCODE_FSUB			0x382b
  #define MWESM_OPCODE_FMUL			0x382c
  #define MWESM_OPCODE_POP			0x380f
  #define MWESM_OPCODE_PUSH			0x3811
  #define MWESM_OPCODE_PUSHB			0x3812
  #define MWESM_OPCODE_PUSHS			0x3813	
  #define MWESM_OPCODE_GETLOCAL			0x3c00
  #define MWESM_OPCODE_SETLOCAL			0x3c02
  #define MWESM_OPCODE_SETREF			0x3c18

  #define MWESM_OPCODE_SUB			0x3821

#endif
/*===========================================================================
 *		End of MWSE OpCodes
 *=========================================================================*/


/*===========================================================================
 *
 * Begin Type Definitions
 *
 *=========================================================================*/

	/* Holds information about a script function */
  typedef struct {
	TCHAR	Name[MWESM_SCRIPT_FUNCNAMESIZE+1];	/* Function name (not case sensitive) */
	short   OpCode;					/* Output function code */
	dword   Flags;					/* Basic flags */
	dword	Return;					/* Return variable type */
	__int64 Var[MWESM_SCRIPT_MAXARGS];		/* Variable types/flags */
   } esmscrfuncinfo_t;

/*===========================================================================
 *		End of Type Definitions
 *=========================================================================*/


/*===========================================================================
 *
 * Begin Function Definitions
 *
 *=========================================================================*/
  bool IsESMScriptReserved  (const TCHAR* pString);
  bool IsESMScriptReserved1 (const TCHAR* pString);
  int  GetESMScriptResToken (const TCHAR* pString);

  bool IsESMScriptFunction       (const TCHAR* pString);
  bool IsESMScriptFunction1      (const TCHAR* pString);
  bool IsESMScriptCustomFunction (const TCHAR* pString);

  esmscrfuncinfo_t* GetESMScriptFuncInfo       (const TCHAR* pString);
  esmscrfuncinfo_t* GetESMScriptCustomFuncInfo (const TCHAR* pString);

  bool IsESMScriptOperator (const TCHAR* pString);
  bool IsESMScriptOperator (const TCHAR Char);
  int  GetESMScriptOpToken (const TCHAR* pString);

  const TCHAR* GetESMTokenName (const int Token);

  bool OutputFunctionDat (const TCHAR* pFilename);
  
/*===========================================================================
 *		End of Function Definitions
 *=========================================================================*/


/*===========================================================================
 *
 * Begin External Definitions
 *
 *=========================================================================*/
  extern esmscrfuncinfo_t  g_ScriptFunctions[];
  extern esmscrfuncinfo_t* g_ScriptFuncAlpha[];
/*===========================================================================
 *		End of External Definitions
 *=========================================================================*/


#endif
/*===========================================================================
 *		End of File Esmscriptdefs.H
 *=========================================================================*/

 O/*===========================================================================
 *
 * File:	Esmscriptcompile.CPP
 * Author:	Dave Humphrey (uesp@m0use.net)
 * Created On:	Friday, February 14, 2003
 *
 * Description
 *
 * 7 September 2003
 *	- Added the CheckFuncID1() which uses the expected ID type to
 *	  help properly check for a valid record.
 *
 * 15 September 2003
 *	- OutputFuncArgGlobal() ensures output globals are at least 4
 *	  bytes in size ('\0' padded).
 *
 * 29-30 September 2003
 *	- The "symbol.local" format only supported on the left side of
 *	  set statements now as they should be.
 *	- Fixed the if/while statement outputs.
 *
 * 5 October 2003
 *	- OutputIfGlobal() and OutputIfRGlobal() now outputs the minimum
 *	  bytes of a global name properly.
 *
 *=========================================================================*/

	/* Include Files */
#include <stdafx.h>
#include "esmscriptcompile.h"
#include "ctype.h"
#include "EsmGlobal.h"
#include "MwEditDoc.h"
//#include "EsmOptions.h"
#include "EsmGlobOptions.h"


/*===========================================================================
 *
 * Begin Local Definitions
 *
 *=========================================================================*/
  DEFINE_FILE("EsmScriptCompile.cpp");

	/* Static class members */
  CEsmFile	   CEsmScriptCompile::m_ExtraFile;
  CEsmRecordRefMap CEsmScriptCompile::m_ExtraRecords;

/*===========================================================================
 *		End of Local Definitions
 *=========================================================================*/


/*===========================================================================
 *
 * Begin Parsing Tables
 *
 *=========================================================================*/

	/* Forward definitions to help the table order */
extern esmscrparsetable_t l_StatementBlock[];
extern esmscrparsetable_t l_RightExprBlock1[];
extern esmscrparsetable_t l_IfRightExprBlock1[];
extern esmscrparsetable_t l_ElseBlock[];

esmscrparsetable_t l_AddNumberBlock[] = { 
	{ ESMSCR_TOKEN_NUMBER,	ESTF_ONE,	NULL,		NULL },
	{ ESMSCR_ENDTABLE,	0,		NULL,		NULL }	
 };

esmscrparsetable_t l_AddArgNumberBlock[] = { 
	{ ESMSCR_TOKEN_NUMBER,	ESTF_ONE,	NULL,		CEsmScriptCompile::ParseFuncArg1,	CEsmScriptCompile::OutputFuncArgNum },
	{ ESMSCR_ENDTABLE,	0,		NULL,		NULL }	
 };

esmscrparsetable_t l_FuncArgBlock[] = {
	{ ESMSCR_TOKEN_COMMA,		ESTF_MANY,				NULL,		CEsmScriptCompile::ParseFuncComma },
	{ ESMSCR_TOKEN_XYZ,		ESTF_ONE | ESTF_OPT | ESTF_STOP,	NULL,		CEsmScriptCompile::ParseFuncArg1,	CEsmScriptCompile::OutputFuncArgXYZ },
	{ ESMSCR_TOKEN_RESET,		ESTF_ONE | ESTF_OPT | ESTF_STOP,	NULL,		CEsmScriptCompile::ParseFuncArg1,	CEsmScriptCompile::OutputFuncArgReset },
	{ ESMSCR_TOKEN_LOCALVAR,	ESTF_ONE | ESTF_OPT | ESTF_STOP,	NULL,		CEsmScriptCompile::ParseFuncArg1,	CEsmScriptCompile::OutputFuncArgLocal },
	{ ESMSCR_TOKEN_GLOBALVAR,	ESTF_ONE | ESTF_OPT | ESTF_STOP,	NULL,		CEsmScriptCompile::ParseFuncArg1,	CEsmScriptCompile::OutputFuncArgGlobal },
	{ ESMSCR_TOKEN_NUMBER,		ESTF_ONE | ESTF_OPT | ESTF_STOP,	NULL,		CEsmScriptCompile::ParseFuncArg1,	CEsmScriptCompile::OutputFuncArgNum },
	{ ESMSCR_TOKEN_STRING,		ESTF_ONE | ESTF_OPT | ESTF_STOP,	NULL,		CEsmScriptCompile::ParseFuncArg1,	NULL },
	{ ESMSCR_TOKEN_SYMBOL,		ESTF_ONE | ESTF_OPT | ESTF_STOP,	NULL,		CEsmScriptCompile::ParseFuncArg1,	NULL },
	{ ESMSCR_TOKEN_ADDOP,		ESTF_ONE | ESTF_OPT | ESTF_STOP,	l_AddArgNumberBlock, CEsmScriptCompile::ParseFuncAddOp },
	//{ ESMSCR_TOKEN_NUMBER,		ESTF_ONE | ESTF_OPT | ESTF_STOP,	NULL,		CEsmScriptCompile::ParseFuncArg1 },
	{ ESMSCR_ENDTABLE,		ESTF_STOP | ESTF_OPT,			NULL,		CEsmScriptCompile::ParseFuncEnd }	
};

#ifdef MWEDIT_SCRIPT_MWSE
esmscrparsetable_t l_FuncXArgBlock[] = {
	{ ESMSCR_TOKEN_COMMA,		ESTF_MANY,				NULL,		CEsmScriptCompile::ParseFuncComma },
	{ ESMSCR_TOKEN_LOCALVAR,	ESTF_ONE | ESTF_OPT | ESTF_STOP,	NULL,		CEsmScriptCompile::ParseFuncArgX,	CEsmScriptCompile::PushFuncXArgLocal },
	{ ESMSCR_TOKEN_NUMBER,		ESTF_ONE | ESTF_OPT | ESTF_STOP,	NULL,		CEsmScriptCompile::ParseFuncArgX,	CEsmScriptCompile::PushFuncXArgNum },
	{ ESMSCR_TOKEN_STRING,		ESTF_ONE | ESTF_OPT | ESTF_STOP,	NULL,		CEsmScriptCompile::ParseFuncArgX,	CEsmScriptCompile::PushFuncXArgString },
	{ ESMSCR_ENDTABLE,		ESTF_STOP | ESTF_OPT,			NULL,		CEsmScriptCompile::ParseFuncEnd,	CEsmScriptCompile::OutputFuncXBlock }	
};

esmscrparsetable_t l_FunctionXBlock[] = {
	{ ESMSCR_BEGINBLOCK,	ESTF_MANY,	l_FuncXArgBlock,	NULL },
	{ ESMSCR_ENDTABLE,		0,	NULL,			NULL }	
};

esmscrparsetable_t l_FuncXLineBlock[] = {
	{ ESMSCR_BEGINBLOCK,	ESTF_ONE,	l_FunctionXBlock,	NULL },
	{ ESMSCR_TOKEN_EOL,	ESTF_ONE,	NULL,			NULL },
	{ ESMSCR_ENDTABLE,	0,		NULL,			NULL }	
};

esmscrparsetable_t  l_LetVarBlock[] = {
	{ ESMSCR_TOKEN_COMMA,		ESTF_MANY,				NULL,		NULL },
	{ ESMSCR_TOKEN_LOCALVAR,	ESTF_ONE | ESTF_STOP | ESTF_OPT,	NULL,		NULL,	CEsmScriptCompile::PushLetLocal },
	{ ESMSCR_ENDTABLE,		ESTF_STOP | ESTF_OPT,			NULL,		NULL }	
 };

esmscrparsetable_t  l_LetObjRefFuncBlock[] = {
	{ ESMSCR_TOKEN_FUNCOP,		ESTF_ONE,	NULL, NULL, CEsmScriptCompile::PushFuncOp },
	{ ESMSCR_ENDTABLE,		0,		NULL, NULL }	
 };

esmscrparsetable_t  l_LetBlock[] = {
	{ ESMSCR_BEGINBLOCK,		ESTF_MANY,		l_LetVarBlock,		NULL },
	{ ESMSCR_TOKEN_TO,		ESTF_ONE,		NULL,			NULL },
	{ ESMSCR_TOKEN_LOCALVAR,	ESTF_ONE | ESTF_OPT,	l_LetObjRefFuncBlock,	NULL },
	{ ESMSCR_TOKEN_FUNCTIONX,	ESTF_ONE,		l_FunctionXBlock,	NULL },
	{ ESMSCR_ENDTABLE,		0,			NULL,			NULL,	CEsmScriptCompile::OutputLetEnd }	
};

esmscrparsetable_t  l_XElseIfBlock[] = {
	{	ESMSCR_TOKEN_OPENBRAC,	ESTF_ONE,		NULL,			NULL	},
	{	ESMSCR_TOKEN_LOCALVAR,	ESTF_ONE,		NULL,			NULL,	CEsmScriptCompile::OutputXElseIf },
	{	ESMSCR_TOKEN_CLOSEBRAC,	ESTF_ONE,		NULL,			NULL	},
	{	ESMSCR_TOKEN_EOL,	ESTF_ONE,		NULL,			NULL	},
	{	ESMSCR_BEGINBLOCK,	ESTF_MANY,		l_StatementBlock,	NULL	},
	{	ESMSCR_ENDTABLE,	0,			NULL,			NULL	}	
 };

esmscrparsetable_t l_XIfBlock[] = {
	{	ESMSCR_TOKEN_OPENBRAC,	ESTF_ONE,		NULL,			NULL	},
	{	ESMSCR_TOKEN_LOCALVAR,	ESTF_ONE,		NULL,			NULL,	CEsmScriptCompile::OutputXIf	},
	{	ESMSCR_TOKEN_CLOSEBRAC,	ESTF_ONE,		NULL,			NULL	},
	{	ESMSCR_TOKEN_EOL,	ESTF_ONE,		NULL,		 	NULL	},
	{	ESMSCR_BEGINBLOCK,	ESTF_MANY,		l_StatementBlock,	NULL	},
//	{	ESMSCR_TOKEN_ELSEIF,	ESTF_MANY,		l_XElseIfBlock,		NULL	},
	{	ESMSCR_TOKEN_ELSE,	ESTF_ONE|ESTF_OPT,	l_ElseBlock,		NULL,	CEsmScriptCompile::OutputXElse },
	{	ESMSCR_TOKEN_ENDIF,	ESTF_ONE,		NULL,			NULL, 	CEsmScriptCompile::OutputXEndIf },
	{	ESMSCR_TOKEN_EOL,	ESTF_ONE,		NULL,			NULL	},
	{	ESMSCR_ENDTABLE,	0,			NULL,			NULL	}	
};

esmscrparsetable_t  l_XWhileBlock[] = {
	{	ESMSCR_TOKEN_OPENBRAC,	ESTF_ONE,	NULL,			NULL	},
	{	ESMSCR_TOKEN_LOCALVAR,	ESTF_ONE,	NULL,			NULL,	CEsmScriptCompile::OutputXWhile	},
	{	ESMSCR_TOKEN_CLOSEBRAC,	ESTF_ONE,	NULL,			NULL	},
	{	ESMSCR_TOKEN_EOL,	ESTF_ONE,	NULL,			NULL	},
	{	ESMSCR_BEGINBLOCK,	ESTF_MANY,	l_StatementBlock,	NULL	},
	{	ESMSCR_TOKEN_ENDWHILE,	ESTF_ONE,	NULL,			NULL,	CEsmScriptCompile::OutputXEndWhile },
	{	ESMSCR_TOKEN_EOL,	ESTF_ONE,	NULL,			NULL },
	{	ESMSCR_ENDTABLE,	0,		NULL,			NULL }	
 };

#endif

esmscrparsetable_t l_FunctionBlock[] = {
	{ ESMSCR_BEGINBLOCK,	ESTF_MANY,	l_FuncArgBlock,		CEsmScriptCompile::ParseCheckFuncArg, NULL },
	{ ESMSCR_ENDTABLE,	0,		NULL,			NULL }	
};

esmscrparsetable_t l_FuncLineBlock[] = {
	{ ESMSCR_BEGINBLOCK,	ESTF_ONE,	l_FunctionBlock,	CEsmScriptCompile::ParseFunction, NULL },
	{ ESMSCR_TOKEN_EOL,	ESTF_ONE,	NULL,			NULL },
	{ ESMSCR_ENDTABLE,	0,		NULL,			NULL }	
};

esmscrparsetable_t  l_ElseBlock[] = {
	{ ESMSCR_TOKEN_EOL,	ESTF_ONE,	NULL,			NULL },
	{ ESMSCR_BEGINBLOCK,	ESTF_MANY,	l_StatementBlock,	NULL },
	{ ESMSCR_ENDTABLE,	0,		NULL,			NULL }	
 };

esmscrparsetable_t  l_LeftVarBlock[] = {
	{ ESMSCR_TOKEN_LOCALVAR,	ESTF_ONE | ESTF_STOP | ESTF_OPT, NULL,	NULL },
	{ ESMSCR_TOKEN_GLOBALVAR,	ESTF_ONE | ESTF_STOP | ESTF_OPT, NULL,	NULL },
	{ ESMSCR_TOKEN_SYMBOL,		ESTF_ONE | ESTF_STOP | ESTF_OPT, NULL,	NULL },
	{ ESMSCR_ENDTABLE,		ESTF_STOP,			 NULL,	NULL }	
 };

esmscrparsetable_t  l_LeftFuncBlock[] = {
	{ ESMSCR_TOKEN_FUNCTION,	ESTF_ONE,	l_FunctionBlock,	CEsmScriptCompile::ParsePushToken },
	{ ESMSCR_ENDTABLE,		0,		NULL,			NULL }	
 };

esmscrparsetable_t  l_LeftIDBlock[] = {
	{ ESMSCR_TOKEN_VAROP,	ESTF_ONE | ESTF_STOP | ESTF_OPT, NULL,	CEsmScriptCompile::ParseVarRef },
#ifdef MWEDIT_SCRIPT_MWSE
	{ ESMSCR_TOKEN_FUNCOP,	ESTF_ONE | ESTF_STOP | ESTF_OPT, NULL,	CEsmScriptCompile::ParseFuncRef, CEsmScriptCompile::OutputFuncOp },
#else
	{ ESMSCR_TOKEN_FUNCOP,	ESTF_ONE | ESTF_STOP | ESTF_OPT, NULL,	CEsmScriptCompile::ParseFuncRef /*, CEsmScriptCompile::OutputObjRef */ },
#endif
	{ ESMSCR_ENDTABLE,	ESTF_STOP,			 NULL,	NULL }
 };

esmscrparsetable_t  l_IfLeftIDBlock[] = {
	{ ESMSCR_TOKEN_VAROP,	ESTF_ONE | ESTF_STOP | ESTF_OPT, NULL,	CEsmScriptCompile::ParseIfVarRef },
#ifdef MWEDIT_SCRIPT_MWSE
	{ ESMSCR_TOKEN_FUNCOP,	ESTF_ONE | ESTF_STOP | ESTF_OPT, l_LeftFuncBlock,	NULL, CEsmScriptCompile::OutputFuncOp },
#else
	{ ESMSCR_TOKEN_FUNCOP,	ESTF_ONE | ESTF_STOP | ESTF_OPT, l_LeftFuncBlock,	NULL },
#endif

	{ ESMSCR_ENDTABLE,	ESTF_STOP,			 NULL,			NULL }	
 };

esmscrparsetable_t  l_LeftVarIDBlock[] = {
	{ ESMSCR_TOKEN_VAROP,	ESTF_ONE | ESTF_STOP | ESTF_OPT, NULL,	CEsmScriptCompile::ParseVarRef },
	{ ESMSCR_ENDTABLE,	ESTF_STOP,			 NULL,	NULL }	
};

esmscrparsetable_t  l_RightIDBlock[] = {
#ifdef MWEDIT_SCRIPT_MWSE
	{ ESMSCR_TOKEN_FUNCOP,	ESTF_ONE | ESTF_STOP | ESTF_OPT, l_LeftFuncBlock,	NULL, CEsmScriptCompile::OutputFuncOp },
#else
	{ ESMSCR_TOKEN_FUNCOP,	ESTF_ONE | ESTF_STOP | ESTF_OPT, l_LeftFuncBlock,	NULL },
#endif

	{ ESMSCR_ENDTABLE,	ESTF_STOP,			 NULL,			NULL }	
 };

esmscrparsetable_t  l_SetVarBlock[] = {
	{ ESMSCR_TOKEN_LOCALVAR,	ESTF_ONE | ESTF_STOP | ESTF_OPT,	NULL,			NULL,	CEsmScriptCompile::OutputSetLocal },
	{ ESMSCR_TOKEN_GLOBALVAR,	ESTF_ONE | ESTF_STOP | ESTF_OPT,	NULL,			NULL,	CEsmScriptCompile::OutputSetGlobal },
	{ ESMSCR_TOKEN_SYMBOL,		ESTF_ONE | ESTF_STOP | ESTF_OPT,	l_LeftVarIDBlock,	CEsmScriptCompile::ParseSymbolID },
	{ ESMSCR_TOKEN_STRING,		ESTF_ONE | ESTF_STOP | ESTF_OPT,	l_LeftVarIDBlock,	CEsmScriptCompile::ParseStringIDSet },
	{ ESMSCR_ENDTABLE,		ESTF_STOP,				NULL,			NULL }	
 };

esmscrparsetable_t  l_LeftExprBlock[] = {
	{ ESMSCR_TOKEN_LOCALVAR,	ESTF_ONE | ESTF_STOP | ESTF_OPT,	NULL,			NULL,	CEsmScriptCompile::OutputIfLocal },
	{ ESMSCR_TOKEN_GLOBALVAR,	ESTF_ONE | ESTF_STOP | ESTF_OPT,	NULL,			NULL,	CEsmScriptCompile::OutputIfGlobal },
	{ ESMSCR_TOKEN_SYMBOL,		ESTF_ONE | ESTF_STOP | ESTF_OPT,	l_LeftIDBlock,		CEsmScriptCompile::ParseSymbolID },
	{ ESMSCR_TOKEN_STRING,		ESTF_ONE | ESTF_STOP | ESTF_OPT,	l_LeftIDBlock,		CEsmScriptCompile::ParseStringIDIf },
	{ ESMSCR_TOKEN_FUNCTION,	ESTF_ONE | ESTF_STOP | ESTF_OPT,	l_FunctionBlock,	NULL,	CEsmScriptCompile::OutputIfFunction },
	{ ESMSCR_ENDTABLE,		ESTF_STOP,				NULL,			NULL }
 };

esmscrparsetable_t  l_RFactorBrac[] = {
	{ ESMSCR_BEGINBLOCK,		ESTF_ONE,	l_RightExprBlock1,	NULL },
	{ ESMSCR_TOKEN_CLOSEBRAC,	ESTF_ONE,	NULL,			CEsmScriptCompile::ParsePushToken },
	{ ESMSCR_ENDTABLE,		0,		NULL,			NULL }	
 };

esmscrparsetable_t  l_IfRFactorBrac[] = {
	{ ESMSCR_BEGINBLOCK,		ESTF_ONE,	l_IfRightExprBlock1,	NULL },
	{ ESMSCR_TOKEN_CLOSEBRAC,	ESTF_ONE,	NULL,			CEsmScriptCompile::ParsePushToken },
	{ ESMSCR_ENDTABLE,		0,		NULL,			NULL }	
 };

esmscrparsetable_t  l_RFactorBlock[] = {
	{ ESMSCR_TOKEN_OPENBRAC,	ESTF_ONE|ESTF_OPT|ESTF_STOP,	l_RFactorBrac,	CEsmScriptCompile::ParsePushToken },
	{ ESMSCR_TOKEN_NUMBER,		ESTF_ONE|ESTF_OPT|ESTF_STOP,	NULL,		CEsmScriptCompile::ParsePushToken },
	{ ESMSCR_TOKEN_LOCALVAR,	ESTF_ONE|ESTF_OPT|ESTF_STOP,	NULL,		CEsmScriptCompile::ParsePushToken },
	{ ESMSCR_TOKEN_GLOBALVAR,	ESTF_ONE|ESTF_OPT|ESTF_STOP,	NULL,		CEsmScriptCompile::ParsePushToken },
	{ ESMSCR_TOKEN_FUNCTION,	ESTF_ONE|ESTF_OPT|ESTF_STOP,	l_FunctionBlock,CEsmScriptCompile::ParsePushToken },
	{ ESMSCR_TOKEN_SYMBOL,		ESTF_ONE|ESTF_OPT|ESTF_STOP,	l_RightIDBlock,	CEsmScriptCompile::ParseSymbolID },
	{ ESMSCR_TOKEN_STRING,		ESTF_ONE|ESTF_OPT|ESTF_STOP,	l_RightIDBlock,	CEsmScriptCompile::ParseStringIDPush },
	{ ESMSCR_ENDTABLE,		ESTF_STOP,			NULL,		NULL }	
 };

esmscrparsetable_t  l_IfRFactorBlock[] = {
	{ ESMSCR_TOKEN_OPENBRAC,	ESTF_ONE|ESTF_OPT|ESTF_STOP,	l_IfRFactorBrac,CEsmScriptCompile::ParsePushToken },
	{ ESMSCR_TOKEN_NUMBER,		ESTF_ONE|ESTF_OPT|ESTF_STOP,	NULL,		CEsmScriptCompile::ParsePushToken },
	{ ESMSCR_TOKEN_LOCALVAR,	ESTF_ONE|ESTF_OPT|ESTF_STOP,	NULL,		CEsmScriptCompile::ParsePushToken },
	{ ESMSCR_TOKEN_GLOBALVAR,	ESTF_ONE|ESTF_OPT|ESTF_STOP,	NULL,		CEsmScriptCompile::ParsePushToken },
	{ ESMSCR_TOKEN_FUNCTION,	ESTF_ONE|ESTF_OPT|ESTF_STOP,	l_FunctionBlock,CEsmScriptCompile::ParsePushToken },
	{ ESMSCR_TOKEN_SYMBOL,		ESTF_ONE|ESTF_OPT|ESTF_STOP,	l_IfLeftIDBlock,CEsmScriptCompile::ParseSymbolID },
	{ ESMSCR_TOKEN_STRING,		ESTF_ONE|ESTF_OPT|ESTF_STOP,	l_IfLeftIDBlock,CEsmScriptCompile::ParseStringIDPush },
	{ ESMSCR_ENDTABLE,		ESTF_STOP,			NULL,		NULL }	
 };


esmscrparsetable_t  l_RFirstFactorBlock[] = {
	{ ESMSCR_TOKEN_ADDOP,	ESTF_ONE | ESTF_OPT,	NULL,		CEsmScriptCompile::ParseSetFirstAddOp },
	{ ESMSCR_BEGINBLOCK,	ESTF_ONE,		l_RFactorBlock,	NULL },
	{ ESMSCR_ENDTABLE,	0,			NULL,		NULL }	
 };

esmscrparsetable_t  l_IfRFirstFactorBlock[] = {
	{ ESMSCR_TOKEN_ADDOP,	ESTF_ONE | ESTF_OPT,	NULL,		CEsmScriptCompile::ParseSetFirstAddOp },
	{ ESMSCR_BEGINBLOCK,	ESTF_ONE,		l_IfRFactorBlock,	NULL },
	{ ESMSCR_ENDTABLE,	0,			NULL,		NULL }	
 };

esmscrparsetable_t  l_RMultOpBlock[] = {
	{ ESMSCR_BEGINBLOCK,	ESTF_ONE,		l_RFirstFactorBlock,	NULL },
	{ ESMSCR_ENDTABLE,	0,			NULL,		NULL }	
 };

esmscrparsetable_t  l_RTermBlock[] = {
	{ ESMSCR_BEGINBLOCK,	ESTF_ONE,		l_RFactorBlock,	NULL },
	{ ESMSCR_TOKEN_MULOP,	ESTF_MANY | ESTF_OPT,	l_RMultOpBlock,	CEsmScriptCompile::ParsePushToken,	CEsmScriptCompile::OutputOneExpr },
	{ ESMSCR_ENDTABLE,	0,			NULL,		NULL }	
 };

esmscrparsetable_t  l_IfRMultOpBlock[] = {
	{ ESMSCR_BEGINBLOCK,	ESTF_ONE,		l_IfRFirstFactorBlock,	NULL },
	{ ESMSCR_ENDTABLE,	0,			NULL,		NULL }	
 };

esmscrparsetable_t  l_IfRTermBlock[] = {
	{ ESMSCR_BEGINBLOCK,	ESTF_ONE,		l_IfRFactorBlock,	NULL },
	{ ESMSCR_TOKEN_MULOP,	ESTF_MANY | ESTF_OPT,	l_IfRMultOpBlock,	CEsmScriptCompile::ParsePushToken,	CEsmScriptCompile::OutputOneExpr },
	{ ESMSCR_ENDTABLE,	0,			NULL,		NULL }	
 };


esmscrparsetable_t  l_RFirstTermBlock[] = {
	{ ESMSCR_BEGINBLOCK,	ESTF_ONE,		l_RFirstFactorBlock,	NULL },
	{ ESMSCR_TOKEN_MULOP,	ESTF_MANY | ESTF_OPT,	l_RMultOpBlock,		CEsmScriptCompile::ParsePushToken,	CEsmScriptCompile::OutputOneExpr },
	{ ESMSCR_ENDTABLE,	0,			NULL,			NULL }	
 };

esmscrparsetable_t  l_RAddOpBlock[] = {
	{ ESMSCR_BEGINBLOCK,	ESTF_ONE,		l_RTermBlock,	NULL },
	{ ESMSCR_ENDTABLE,	0,			NULL,		NULL }	
 };

esmscrparsetable_t  l_IfRFirstTermBlock[] = {
	{ ESMSCR_BEGINBLOCK,	ESTF_ONE,		l_IfRFirstFactorBlock,	NULL },
	{ ESMSCR_TOKEN_MULOP,	ESTF_MANY | ESTF_OPT,	l_IfRMultOpBlock,	CEsmScriptCompile::ParsePushToken,	CEsmScriptCompile::OutputOneExpr },
	{ ESMSCR_ENDTABLE,	0,			NULL,			NULL }	
 };

esmscrparsetable_t  l_IfRAddOpBlock[] = {
	{ ESMSCR_BEGINBLOCK,	ESTF_ONE,		l_IfRTermBlock,	NULL },
	{ ESMSCR_ENDTABLE,	0,			NULL,		NULL }	
 };

esmscrparsetable_t  l_RightExprBlock1[] = {
	{ ESMSCR_BEGINBLOCK,	ESTF_ONE,		l_RFirstTermBlock,	NULL },
	{ ESMSCR_TOKEN_ADDOP,	ESTF_MANY | ESTF_OPT,	l_RAddOpBlock,		CEsmScriptCompile::ParsePushToken,	CEsmScriptCompile::OutputOneExpr },
	{ ESMSCR_ENDTABLE,	0,			NULL,			NULL }	
 };



esmscrparsetable_t  l_IfRightExprBlock1[] = {
	{ ESMSCR_BEGINBLOCK,	ESTF_ONE,		l_IfRFirstTermBlock,	NULL },
	{ ESMSCR_TOKEN_ADDOP,	ESTF_MANY | ESTF_OPT,	l_IfRAddOpBlock,	CEsmScriptCompile::ParsePushToken,	CEsmScriptCompile::OutputOneExpr },
	{ ESMSCR_ENDTABLE,	0,			NULL,			NULL }	
 };


esmscrparsetable_t  l_RightExprBlock[] = {
	{ ESMSCR_BEGINBLOCK,	ESTF_ONE,		l_RFirstTermBlock,	NULL },
	{ ESMSCR_TOKEN_ADDOP,	ESTF_MANY | ESTF_OPT,	l_RAddOpBlock,		CEsmScriptCompile::ParsePushToken,	CEsmScriptCompile::OutputOneExpr },
	{ ESMSCR_ENDTABLE,	0,			NULL,			NULL,	CEsmScriptCompile::OutputExprStack }	
 };

esmscrparsetable_t  l_IfLeftExprBlock[] = {
	{ ESMSCR_BEGINBLOCK,	ESTF_ONE,		l_IfRFirstTermBlock,	NULL },
	{ ESMSCR_TOKEN_ADDOP,	ESTF_MANY | ESTF_OPT,	l_IfRAddOpBlock,	CEsmScriptCompile::ParsePushToken,	CEsmScriptCompile::OutputOneExpr },
	{ ESMSCR_ENDTABLE,	0,			NULL,			NULL,	CEsmScriptCompile::OutputIfLeftExprStack }	
 };

esmscrparsetable_t  l_IfRightExprBlock[] = {
	{ ESMSCR_BEGINBLOCK,	ESTF_ONE,		l_IfRFirstTermBlock,	NULL },
	{ ESMSCR_TOKEN_ADDOP,	ESTF_MANY | ESTF_OPT,	l_IfRAddOpBlock,	CEsmScriptCompile::ParsePushToken,	CEsmScriptCompile::OutputOneExpr },
	{ ESMSCR_ENDTABLE,	0,			NULL,			NULL,	CEsmScriptCompile::OutputIfRightExprStack }	
 };


esmscrparsetable_t  l_SetBlock[] = {
	{ ESMSCR_BEGINBLOCK,	ESTF_ONE,	l_SetVarBlock,		NULL },
	{ ESMSCR_TOKEN_TO,	ESTF_ONE,	NULL,			NULL },
	{ ESMSCR_BEGINBLOCK,	ESTF_ONE,	l_RightExprBlock,	CEsmScriptCompile::ParseRExprStart },
	{ ESMSCR_TOKEN_EOL,	ESTF_ONE,	NULL,			NULL,	CEsmScriptCompile::OutputSetEnd },
	{ ESMSCR_ENDTABLE,	0,		NULL,			NULL }	
 };

esmscrparsetable_t l_IfRNumBlock[] = {
	{ ESMSCR_TOKEN_NUMBER,		ESTF_ONE,	NULL,		NULL,	CEsmScriptCompile::OutputIfRNumber },
	{ ESMSCR_ENDTABLE,		0,		NULL,		NULL }	
 };

esmscrparsetable_t l_IfRightBlock[] = {
	{ ESMSCR_TOKEN_ADDOP,		ESTF_ONE | ESTF_STOP | ESTF_OPT,	l_IfRNumBlock,	 NULL,	CEsmScriptCompile::OutputIfRAddOp },
	{ ESMSCR_TOKEN_NUMBER,		ESTF_ONE | ESTF_STOP | ESTF_OPT,	NULL,		 NULL,	CEsmScriptCompile::OutputIfRNumber },
	{ ESMSCR_TOKEN_LOCALVAR,	ESTF_ONE | ESTF_OPT | ESTF_STOP,	NULL,		 NULL,	CEsmScriptCompile::OutputIfRLocal },
	{ ESMSCR_TOKEN_GLOBALVAR,	ESTF_ONE | ESTF_OPT | ESTF_STOP,	NULL,		 NULL,	CEsmScriptCompile::OutputIfRGlobal },
	{ ESMSCR_ENDTABLE,		0,					NULL,		 NULL }	
 };

esmscrparsetable_t  l_ElseIfBlock[] = {
	{ ESMSCR_TOKEN_OPENBRAC,	ESTF_ONE,		NULL,			NULL },
		{ ESMSCR_BEGINBLOCK,		ESTF_ONE,		l_IfLeftExprBlock,	CEsmScriptCompile::ParseIfRExprStart },
		{ ESMSCR_TOKEN_RELOP,		ESTF_ONE | ESTF_OPT,	l_IfRightExprBlock,	CEsmScriptCompile::ParseIfRExprStart,	CEsmScriptCompile::OutputIfRelOp },
	//{ ESMSCR_BEGINBLOCK,		ESTF_ONE,		l_LeftExprBlock,	NULL },
	//{ ESMSCR_TOKEN_RELOP,		ESTF_ONE | ESTF_OPT,	l_IfRightBlock,		NULL,	CEsmScriptCompile::OutputIfRelOp },
	//{ ESMSCR_BEGINBLOCK,		ESTF_ONE,		l_IfRightBlock,		NULL },
	{ ESMSCR_TOKEN_CLOSEBRAC,	ESTF_ONE,		NULL,			NULL,	CEsmScriptCompile::OutputIfFinish },
	{ ESMSCR_TOKEN_EOL,		ESTF_ONE,		NULL,			NULL },
	{ ESMSCR_BEGINBLOCK,		ESTF_MANY,		l_StatementBlock,	NULL },
	{ ESMSCR_ENDTABLE,		0,			NULL,			NULL }	
 };

esmscrparsetable_t  l_IfBlock[] = {
	{ ESMSCR_TOKEN_OPENBRAC,	ESTF_ONE,		NULL,		 NULL },
		{ ESMSCR_BEGINBLOCK,		ESTF_ONE,		l_IfLeftExprBlock,	CEsmScriptCompile::ParseIfRExprStart },
		{ ESMSCR_TOKEN_RELOP,		ESTF_ONE | ESTF_OPT,	l_IfRightExprBlock,	CEsmScriptCompile::ParseIfRExprStart,	CEsmScriptCompile::OutputIfRelOp },
	//{ ESMSCR_BEGINBLOCK,		ESTF_ONE,		l_LeftExprBlock, NULL },
	//{ ESMSCR_TOKEN_RELOP,		ESTF_ONE | ESTF_OPT,	l_IfRightBlock,	 NULL,	CEsmScriptCompile::OutputIfRelOp },
	{ ESMSCR_TOKEN_CLOSEBRAC,	ESTF_ONE,		NULL,		 NULL,	CEsmScriptCompile::OutputIfFinish },
	{ ESMSCR_TOKEN_EOL,		ESTF_ONE,		NULL,		 NULL },
	{ ESMSCR_BEGINBLOCK,		ESTF_MANY,		l_StatementBlock,NULL },
	{ ESMSCR_TOKEN_ELSEIF,		ESTF_MANY,		l_ElseIfBlock,	 NULL,	CEsmScriptCompile::OutputElseIf },
	{ ESMSCR_TOKEN_ELSE,		ESTF_ONE | ESTF_OPT,	l_ElseBlock,	 NULL,	CEsmScriptCompile::OutputElse },
	{ ESMSCR_TOKEN_ENDIF,		ESTF_ONE,		NULL,		 NULL, 	CEsmScriptCompile::OutputEndIf },
	{ ESMSCR_TOKEN_EOL,		ESTF_ONE,		NULL,		 NULL },
	{ ESMSCR_ENDTABLE,		0,			NULL,		 NULL }	
 };

esmscrparsetable_t  l_WhileBlock[] = {
	{ ESMSCR_TOKEN_OPENBRAC,	ESTF_ONE,		NULL,		 NULL },
		{ ESMSCR_BEGINBLOCK,		ESTF_ONE,		l_IfLeftExprBlock,	CEsmScriptCompile::ParseIfRExprStart },
		{ ESMSCR_TOKEN_RELOP,		ESTF_ONE | ESTF_OPT,	l_IfRightExprBlock,	CEsmScriptCompile::ParseIfRExprStart,	CEsmScriptCompile::OutputIfRelOp },
	//{ ESMSCR_BEGINBLOCK,		ESTF_ONE,		l_LeftExprBlock, NULL },
	//{ ESMSCR_TOKEN_RELOP,		ESTF_ONE | ESTF_OPT,	l_IfRightBlock,	 NULL,	CEsmScriptCompile::OutputIfRelOp },
	{ ESMSCR_TOKEN_CLOSEBRAC,	ESTF_ONE,		NULL,		 NULL,	CEsmScriptCompile::OutputWhileFinish },
	{ ESMSCR_TOKEN_EOL,		ESTF_ONE,		NULL,		 NULL },
	{ ESMSCR_BEGINBLOCK,		ESTF_MANY,		l_StatementBlock,NULL },
	{ ESMSCR_TOKEN_ENDWHILE,	ESTF_ONE,		NULL,		 NULL,	CEsmScriptCompile::OutputEndWhile },
	{ ESMSCR_TOKEN_EOL,		ESTF_ONE,		NULL,		 NULL },
	{ ESMSCR_ENDTABLE,		0,			NULL,		 NULL }	
 };

esmscrparsetable_t  l_ReturnBlock[] = {
	{ ESMSCR_TOKEN_EOL,	ESTF_ONE,	NULL,		NULL },
	{ ESMSCR_ENDTABLE,	0,		NULL,		NULL }	
 };

#ifdef MWEDIT_SCRIPT_MWSE

esmscrparsetable_t  l_ObjRefFuncBlock[] = {
	{ ESMSCR_TOKEN_FUNCOP,		ESTF_ONE,			 NULL,			NULL, CEsmScriptCompile::PushFuncOp },
	{ ESMSCR_TOKEN_FUNCTION,	ESTF_ONE | ESTF_STOP | ESTF_OPT, l_FunctionBlock,	NULL, CEsmScriptCompile::OutputFunction },
	{ ESMSCR_TOKEN_FUNCTIONX,	ESTF_ONE | ESTF_STOP | ESTF_OPT, l_FunctionXBlock,	NULL },
	{ ESMSCR_TOKEN_EOL,		ESTF_ONE,			 NULL,			NULL },
	{ ESMSCR_ENDTABLE,		0,				 NULL,			NULL }	
 };

#else

esmscrparsetable_t  l_SymFuncBlock[] = {
	{ ESMSCR_TOKEN_FUNCOP,		ESTF_ONE,	NULL,		NULL },
	{ ESMSCR_TOKEN_FUNCTION,	ESTF_ONE,	l_FunctionBlock,NULL,	CEsmScriptCompile::OutputFunction },
	{ ESMSCR_TOKEN_EOL,		ESTF_ONE,	NULL,		NULL },
	{ ESMSCR_ENDTABLE,		0,		NULL,		NULL }	
 };
#endif


#ifdef MWEDIT_SCRIPT_MWSE

esmscrparsetable_t  l_StatementBlock[] = {
	{ ESMSCR_TOKEN_TYPEOP,	  ESTF_ONE | ESTF_STOP | ESTF_OPT,	NULL,			CEsmScriptCompile::ParseNewLocalVar },
	{ ESMSCR_TOKEN_SET,	  ESTF_ONE | ESTF_STOP | ESTF_OPT,	l_SetBlock,		NULL,		CEsmScriptCompile::OutputSet },
	{ ESMSCR_TOKEN_SETX,	  ESTF_ONE | ESTF_STOP | ESTF_OPT,	l_LetBlock,		NULL,		NULL },
	{ ESMSCR_TOKEN_IF,	  ESTF_ONE | ESTF_STOP | ESTF_OPT,	l_IfBlock,		NULL,		CEsmScriptCompile::OutputIf },
	{ ESMSCR_TOKEN_IFX,	  ESTF_ONE | ESTF_STOP | ESTF_OPT,	l_XIfBlock,		NULL,		NULL },
	{ ESMSCR_TOKEN_WHILE,	  ESTF_ONE | ESTF_STOP | ESTF_OPT,	l_WhileBlock,		NULL,		CEsmScriptCompile::OutputWhile },
	{ ESMSCR_TOKEN_WHILEX,	  ESTF_ONE | ESTF_STOP | ESTF_OPT,	l_XWhileBlock,		NULL },
	{ ESMSCR_TOKEN_RETURN,	  ESTF_ONE | ESTF_STOP | ESTF_OPT,	l_ReturnBlock,		NULL,		CEsmScriptCompile::OutputReturn },
	{ ESMSCR_TOKEN_SYMBOL,	  ESTF_ONE | ESTF_STOP | ESTF_OPT,	l_ObjRefFuncBlock,	CEsmScriptCompile::ParseLineSymbolID },
	{ ESMSCR_TOKEN_STRING,	  ESTF_ONE | ESTF_STOP | ESTF_OPT,	l_ObjRefFuncBlock,	CEsmScriptCompile::ParseLineStringID },
	{ ESMSCR_TOKEN_LOCALVAR,  ESTF_ONE | ESTF_STOP | ESTF_OPT,	l_ObjRefFuncBlock,	NULL },
	{ ESMSCR_TOKEN_FUNCTION,  ESTF_ONE | ESTF_STOP | ESTF_OPT,	l_FuncLineBlock,	NULL,			CEsmScriptCompile::OutputLineFunction },
	{ ESMSCR_TOKEN_FUNCTIONX, ESTF_ONE | ESTF_STOP | ESTF_OPT,	l_FuncXLineBlock,	CEsmScriptCompile::ParseFunctionLine,		NULL},
	{ ESMSCR_TOKEN_EOL,	  ESTF_ONE | ESTF_STOP | ESTF_OPT,	NULL,			NULL },
	{ ESMSCR_ENDTABLE,	  ESTF_STOP | ESTF_OPT,			NULL,			NULL }
};
#else

esmscrparsetable_t  l_StatementBlock[] = {
	{ ESMSCR_TOKEN_TYPEOP,	ESTF_ONE | ESTF_STOP | ESTF_OPT,	NULL,			CEsmScriptCompile::ParseNewLocalVar },
	{ ESMSCR_TOKEN_SET,	ESTF_ONE | ESTF_STOP | ESTF_OPT,	l_SetBlock,		NULL,	CEsmScriptCompile::OutputSet },
	{ ESMSCR_TOKEN_IF,	ESTF_ONE | ESTF_STOP | ESTF_OPT,	l_IfBlock,		NULL,	CEsmScriptCompile::OutputIf },
	{ ESMSCR_TOKEN_WHILE,	ESTF_ONE | ESTF_STOP | ESTF_OPT,	l_WhileBlock,		NULL,	CEsmScriptCompile::OutputWhile },
	{ ESMSCR_TOKEN_RETURN,	ESTF_ONE | ESTF_STOP | ESTF_OPT,	l_ReturnBlock,		NULL,	CEsmScriptCompile::OutputReturn },
	{ ESMSCR_TOKEN_SYMBOL,	ESTF_ONE | ESTF_STOP | ESTF_OPT,	l_SymFuncBlock,		CEsmScriptCompile::ParseLineSymbolID },
	{ ESMSCR_TOKEN_STRING,	ESTF_ONE | ESTF_STOP | ESTF_OPT,	l_SymFuncBlock,		CEsmScriptCompile::ParseLineStringID },
	{ ESMSCR_TOKEN_FUNCTION,ESTF_ONE | ESTF_STOP | ESTF_OPT,	l_FuncLineBlock,	NULL,	CEsmScriptCompile::OutputLineFunction },
	{ ESMSCR_TOKEN_EOL,	ESTF_ONE | ESTF_STOP | ESTF_OPT,	NULL,			NULL },
	{ ESMSCR_ENDTABLE,	ESTF_STOP | ESTF_OPT,			NULL,			NULL }
};
#endif

esmscrparsetable_t  l_ScriptBlock[] = {
	{ ESMSCR_TOKEN_SYMBOL,	ESTF_ONE,	NULL,		NULL,	CEsmScriptCompile::OutputScriptName },
	{ ESMSCR_TOKEN_EOL,	ESTF_ONE,	NULL,		NULL },
	{ ESMSCR_BEGINBLOCK,	ESTF_MANY,	l_StatementBlock, NULL },
	{ ESMSCR_TOKEN_END,	ESTF_ONE,	NULL,		NULL,	CEsmScriptCompile::OutputEnd },
	{ ESMSCR_ENDTABLE,	0,		NULL,		NULL }
};

esmscrparsetable_t  l_MainBlock[] = {
	{ ESMSCR_TOKEN_EOL,	ESTF_MANY,	NULL,		NULL },
	{ ESMSCR_TOKEN_BEGIN,	ESTF_ONE,	NULL,		NULL },
	{ ESMSCR_BEGINBLOCK,	ESTF_ONE,	l_ScriptBlock,	NULL },
	{ ESMSCR_ENDTABLE,	0,		NULL,		NULL }
};
/*===========================================================================
 *		End of Parsing Tables
 *=========================================================================*/


/*===========================================================================
 *
 * Begin Custom Script Character Type Array
 *
 *=========================================================================*/
  #define ESCT_SPACE ESMSCR_CHARTYPE_SPACE
  #define ESCT_DIGIT ESMSCR_CHARTYPE_DIGIT | ESMSCR_CHARTYPE_SYMBOL
  #define ESCT_PUNCT ESMSCR_CHARTYPE_PUNCT
  #define ESCT_SYMF  ESMSCR_CHARTYPE_SYMBOLF | ESMSCR_CHARTYPE_SYMBOL
  #define ESCT_SYM   ESMSCR_CHARTYPE_SYMBOL

int l_EsmScrCharTypes[257] = {
	0, 0, 0, 0, 0, 0, 0, 0, 0, ESCT_SPACE,
	ESCT_SPACE,	/* 0A (LF)  */
	ESCT_SPACE, ESCT_SPACE,
	0,		/* 0D (CR)  */
	0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 
	ESCT_SPACE,     /* 20 SPACE */
	ESCT_PUNCT,     /* 21 !     */
	0,		/* 22 "     */
	0,		/* 23 #     */
	0,		/* 24 $     */
	0,		/* 25 %     */
	0,		/* 26 &     */
	ESCT_PUNCT,     /* 27 '     */
	ESCT_PUNCT,     /* 28 (     */
	ESCT_PUNCT,     /* 29 )     */
	ESCT_PUNCT,     /* 2A *     */
	ESCT_PUNCT,     /* 2B +     */
	ESCT_PUNCT,     /* 2C ,     */
	ESCT_PUNCT,     /* 2D -     */
	ESCT_PUNCT,     /* 2E .     */
	ESCT_PUNCT,     /* 2F /     */
	ESCT_DIGIT,	/* 30 0     */
	ESCT_DIGIT, ESCT_DIGIT, ESCT_DIGIT, ESCT_DIGIT,	ESCT_DIGIT, ESCT_DIGIT, ESCT_DIGIT, ESCT_DIGIT,	ESCT_DIGIT, 
	0,		/* 3A :     */
	0,		/* 3B ;     */
	ESCT_PUNCT,     /* 3C <     */
	ESCT_PUNCT,     /* 3D =     */
	ESCT_PUNCT,     /* 3E >     */
	0,		/* 3F ?     */
	0,		/* 40 @     */
	ESCT_SYMF,	/* 41 A     */
	ESCT_SYMF, ESCT_SYMF, ESCT_SYMF, ESCT_SYMF, ESCT_SYMF, ESCT_SYMF,
	ESCT_SYMF, ESCT_SYMF, ESCT_SYMF, ESCT_SYMF, ESCT_SYMF, ESCT_SYMF, ESCT_SYMF, ESCT_SYMF,
	ESCT_SYMF, ESCT_SYMF, ESCT_SYMF, ESCT_SYMF, ESCT_SYMF, ESCT_SYMF, ESCT_SYMF, ESCT_SYMF,
	ESCT_SYMF, ESCT_SYMF, ESCT_SYMF, 
	0,		/* 5B [     */
	0,		/* 5C \     */
	0,		/* 5D ]     */
	0,		/* 5E ^     */
	ESCT_SYMF,	/* 5F _     */
	0,		/* 60 `     */
	ESCT_SYMF, /* 61 a     */
	ESCT_SYMF, ESCT_SYMF, ESCT_SYMF, ESCT_SYMF, ESCT_SYMF, ESCT_SYMF, ESCT_SYMF, ESCT_SYMF, 
	ESCT_SYMF, ESCT_SYMF, ESCT_SYMF, ESCT_SYMF, ESCT_SYMF, ESCT_SYMF, ESCT_SYMF, ESCT_SYMF, 
	ESCT_SYMF, ESCT_SYMF, ESCT_SYMF, ESCT_SYMF, ESCT_SYMF, ESCT_SYMF, ESCT_SYMF, ESCT_SYMF, ESCT_SYMF, 
	0,		/* 7B {     */
	0,		/* 7C |     */
	0,		/* 7D }     */
	0,		/* 7E ~     */
	0,		/* 7F (DEL) */
	0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
	0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
	0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
	0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
	0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
	0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
	0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
	0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
   };
/*===========================================================================
 *		End of Custom Script Character Type Array
 *=========================================================================*/


/*===========================================================================
 *
 * Class CEsmScriptCompile Constructor
 *
 *=========================================================================*/
CEsmScriptCompile::CEsmScriptCompile () : m_Token(100), m_ErrorArray(0) {
  //DEFINE_FUNCTION("CEsmScriptCompile::CEsmScriptCompile()");
  m_pCharTypes = l_EsmScrCharTypes;

  m_pScriptText = NULL;
  m_pOutBuffer  = NULL;
  m_pParse      = NULL;
  m_pDocument   = NULL;

  m_TokenID	   = ESMSCR_TOKEN_UNKNOWN;
  m_CurrentLine    = 0;
  m_CurrentCharPos = 0;
  m_StartCharPos   = 0;
  m_StartLine      = 0;
  m_NumShortVars   = 0;
  m_NumLongVars    = 0;
  m_NumFloatVars   = 0;
  m_NumErrors	   = 0;
  m_NumWarnings    = 0;
  m_TokenParsed    = false;
  m_pCurrentFunc   = NULL;

  m_HasErrorMsg       = false;
  m_LastTokenNegative = false;
  m_OutputFuncIDRef   = false;
  m_LastFuncArgSymbol = false;
  m_LastSetSymbol     = false;

  m_pLocalVarData    = NULL;
  m_LocalVarDataSize = 0;

  m_ScriptDataSize   = 0;
  m_LastLineDataPos  = 0;
  m_StatementCount   = 0;

  m_LastIfPos = -1;

  m_NumMsgLevels = 0;
  SetDefaultMsgLevels();
  m_FuncOptCount = 0;
 }
/*===========================================================================
 *		End of Class CEsmScriptCompile Constructor
 *=========================================================================*/


/*===========================================================================
 *
 * Class CEsmScriptCompile Method - void Destroy (void);
 *
 *=========================================================================*/
void CEsmScriptCompile::Destroy () {
  DEFINE_FUNCTION("CEsmScriptCompile::Destroy()");

	/* Delete any allocated buffers */
  DestroyArrayPointer(m_pScriptText);
  DestroyArrayPointer(m_pOutBuffer);
  DestroyArrayPointer(m_pLocalVarData);

  ClearErrors();
  m_ErrorMessage.Empty();
  m_HasErrorMsg = false;
  m_LastTokenNegative = false;

  m_pParse	   = NULL;

  m_Token	   = "";
  m_TokenID	   = ESMSCR_TOKEN_UNKNOWN;
  m_CurrentLine    = 0;
  m_CurrentCharPos = 0;
  m_StartCharPos   = 0;
  m_StartLine      = 0;
  m_NumShortVars   = 0;
  m_NumLongVars    = 0;
  m_NumFloatVars   = 0;
  m_NumErrors	   = 0;
  m_NumWarnings    = 0;
  m_TokenParsed    = false;
  m_LineHasRef     = false;
  m_pCurrentFunc   = NULL;
  m_LocalVarDataSize = 0;
  m_ScriptDataSize   = 0;
  m_LastLineDataPos  = 0;
  m_StatementCount   = 0;

	/* Clear the expression stack */
  ClearExprStack();
  ClearIfStatementStack();
 }
/*===========================================================================
 *		End of Class Method CEsmScriptCompile::Destroy();
 *=========================================================================*/


/*===========================================================================
 *
 * Class CEsmScriptCompile Method - bool AddIfBlock (StatementCount, ScriptPos);
 *
 * Adds a new if statement block to the if statement stack using the given
 * initial statement count and script position. Returns false on any error.
 *
 *=========================================================================*/
bool CEsmScriptCompile::AddIfBlock (const int StatementCount, const int ScriptPos) {
  DEFINE_FUNCTION("CEsmScriptCompile::AddIfBlock()");
  esmscrifblock_t* pNewBlock;

	/* Allocate and intialize the new if statement block */
  CreatePointer(pNewBlock, esmscrifblock_t);
  pNewBlock->IfStartPos		 = ScriptPos;
  pNewBlock->StartStatementCount = StatementCount;

	/* Update the if statement stack */
  m_IfStatementStack.Push((void *) pNewBlock);
  return (true);
 }
/*===========================================================================
 *		End of Class Method CEsmScriptCompile::AddIfBlock()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CEsmScriptCompile Method - bool AddLocalVar (pName, Type);
 *
 * Attempts to add the given local variable to the script. Returns false
 * on any error (too many local vars, already defined).
 *
 *=========================================================================*/
bool CEsmScriptCompile::AddLocalVar (const TCHAR* pName, const int Type) {

	/* Check the variable name length */
  if (TSTRLEN(pName) > ESMSCR_VAR_MAXLENGTH) {
    AddMessage(ESMSCR_ERROR_BADLOCAL, "Local variable name exceeds the maximum length of %d (%s)!", ESMSCR_VAR_MAXLENGTH, pName);
    return (false);
   }

  if (Type == ESMSCR_VAR_SHORT) {
    if (m_NumShortVars >= ESMSCR_MAX_LOCALVARS) {
      AddMessage(ESMSCR_ERROR_BADLOCAL, "Exceeded the maximum number of local short variables (%d)!", ESMSCR_MAX_LOCALVARS);
      return (false);
     }

		/* Add the variable */
    m_ShortVars[m_NumShortVars].SetName(pName);
    m_ShortVars[m_NumShortVars].Type = Type;
    m_NumShortVars++;
   }
  else if (Type == ESMSCR_VAR_LONG) {
    if (m_NumLongVars >= ESMSCR_MAX_LOCALVARS) {
      AddMessage(ESMSCR_ERROR_BADLOCAL, "Exceeded the maximum number of local long variables (%d)!", ESMSCR_MAX_LOCALVARS);
      return (false);
     }

		/* Add the variable */
    m_LongVars[m_NumLongVars].SetName(pName);
    m_LongVars[m_NumLongVars].Type = Type;
    m_NumLongVars++;
   }
  else if (Type == ESMSCR_VAR_FLOAT) {
    if (m_NumFloatVars >= ESMSCR_MAX_LOCALVARS) {
      AddMessage(ESMSCR_ERROR_BADLOCAL, "Exceeded the maximum number of local float variables (%d)!", ESMSCR_MAX_LOCALVARS);
      return (false);
     }

		/* Add the variable */
    m_FloatVars[m_NumFloatVars].SetName(pName);
    m_FloatVars[m_NumFloatVars].Type = Type;
    m_NumFloatVars++;
   }

  return (true);
 }
/*===========================================================================
 *		End of Class Method CEsmScriptCompile::AddLocalVar()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CEsmScriptCompile Method - void AddError (pString, ...);
 *
 * Adds a script error to the internal message list.
 *
 *=========================================================================*/
void CEsmScriptCompile::AddError (const TCHAR* pString, ...) {
  TCHAR UserMsg[256];
  TCHAR ErrorString[512];
  va_list Args;

	/* Create the input message */
  va_start(Args, pString);
  vsnprintf(UserMsg, 255, pString, Args);
  va_end(Args);

	/* Create the expanded error message */
  snprintf (ErrorString, 511, _T("Error: Line %d (%d): %s"), m_CurrentLine+1, m_CurrentCharPos+1, UserMsg);

	/* Save the message */
  ErrorHandler.AddError(ERR_BADINPUT, ErrorString);
  m_ErrorMessage = ErrorString;
  m_HasErrorMsg  = true;
  m_NumErrors++;
 }
/*===========================================================================
 *		End of Class Method CEsmScriptCompile::AddError()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CEsmScriptCompile Method - bool AddScriptData (pData, Size);
 *
 *=========================================================================*/
bool CEsmScriptCompile::AddScriptData (const void* pData, const int Size) {

	/* Check for buffer overflows */
  if (m_ScriptDataSize + Size >= ESMSCR_DATA_SIZE) {
    AddError("Maximum compiled script size %d exceeded!", ESMSCR_DATA_SIZE);
    return (false);
   }

  memcpy(m_ScriptData + m_ScriptDataSize, pData, Size);

	/* Modify the last line data pos to adjust for data output after 
	 * the EOL has been found */
  if (m_LastLineDataPos == m_ScriptDataSize) m_LastLineDataPos += Size;

  m_ScriptDataSize += Size;
  return (true);
 }
/*===========================================================================
 *		End of Class Method CEsmScriptCompile::AddScriptData()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CEsmScriptCompile Method - void AddWarning (pString, ...);
 *
 * Adds a script warning to the internal message list.
 *
 *=========================================================================*/
void CEsmScriptCompile::AddWarning (const TCHAR* pString, ...) {
  TCHAR		   UserMsg[256];
  TCHAR		   ErrorString[512];
  va_list	   Args;

	/* Create the input message */
  va_start(Args, pString);
  vsnprintf(UserMsg, 255, pString, Args);
  va_end(Args);

	/* Create the expanded error message */
  snprintf (ErrorString, 511, _T("Warning: Line %d (%d): %s"), m_CurrentLine+1, m_CurrentCharPos+1, UserMsg);

	/* Save the message */
  ErrorHandler.AddError(ERR_BADINPUT, ErrorString);
  m_ErrorMessage = ErrorString;
  m_HasErrorMsg  = true;
  m_NumWarnings++;
 }
/*===========================================================================
 *		End of Class Method CEsmScriptCompile::AddWarning()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CEsmScriptCompile Method - bool AddMessage (MessageID, pString, ...);
 *
 * Adds a warning/error compiler message.  The error level is determined from
 * the current setting of the message.  Returns false if the message is
 * an error that requires the compile to abort.
 *
 *=========================================================================*/
bool CEsmScriptCompile::AddMessage (const int MessageID, const TCHAR* pString, ...) {
  DEFINE_FUNCTION("CEsmScriptCompile::AddMessage()");
  CEsmScriptError* pError;
  TCHAR		   UserMsg[256];
  va_list	   Args;
  bool		   ReturnValue = true;
  int		   MsgLevel;
  int		   MsgType;

	/* Create the user message */
  va_start(Args, pString);
  vsnprintf(UserMsg, 255, pString, Args);
  va_end(Args);

	/* Find the current message level for the message */
  MsgLevel = FindMsgLevel(MessageID);

	/* Determine the action to take */
  switch (MsgLevel) {
    case ESMSCR_MSGLEVEL_NONE:
	return (true);
    case ESMSCR_MSGLEVEL_WARNING: 
	AddWarning(UserMsg);
	MsgType = ESMSCR_MESSAGE_WARNING;
	break;
    case ESMSCR_MSGLEVEL_ERROR:		
	AddError(UserMsg);
	ReturnValue = false;
	MsgType = ESMSCR_MESSAGE_ERROR;
	break;
  };


	/* Allocate the new warning object */
  CreatePointer(pError, CEsmScriptError);
  m_ErrorArray.Add(pError);

	/* Initialize the error record */
  pError->SetCode(MessageID);
  pError->SetLine(m_CurrentLine + 1);
  pError->SetType(MsgType);
  pError->SetCharacter(m_CurrentCharPos + 1);
  pError->SetMessage(UserMsg);
  pError->SetToken(m_Token);
  pError->SetTokenID(m_TokenID);

  if (m_pCurrentFunc != NULL) {
    pError->SetFunction(m_pCurrentFunc);
    pError->SetNumFuncArgs(m_NumFuncArgs);
    pError->SetFuncArgIndex(m_FuncArgIndex);
   }

  return (ReturnValue);  
 }
/*===========================================================================
 *		End of Class Method CEsmScriptCompile::AddMessage()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CEsmScriptCompile Method - int AssertToken (Token);
 *
 * Checks to ensure that the current token is the given type.  Adds a
 * standard error message and returns ESMSCR_RESULT_ERROR if it is not.
 *
 *=========================================================================*/
int CEsmScriptCompile::AssertToken (const int Token) {

  if (m_TokenID != Token) {
    AddMessage(ESMSCR_ERROR_BADTOKEN, _T("Syntax Error: Expected '%s' but found '%s' (%s)!"), GetESMTokenName(Token), GetESMTokenName(m_TokenID), m_Token);
    return (ESMSCR_RESULT_ERROR);
   }

  return (ESMSCR_RESULT_OK);
 }

int CEsmScriptCompile::AssertToken (const int Token1, const int Token2) {

  if (m_TokenID != Token1 && m_TokenID != Token2) {
    AddMessage(ESMSCR_ERROR_BADTOKEN, _T("Syntax Error: Expected '%s' or '%s' but found '%s' (%s)!"), GetESMTokenName(Token1), 
			GetESMTokenName(Token2), GetESMTokenName(m_TokenID), m_Token);
    return (ESMSCR_RESULT_ERROR);
   }

  return (ESMSCR_RESULT_OK);
 }
/*===========================================================================
 *		End of Class Method CEsmScriptCompile::AssertToken()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CEsmScriptCompile Method - bool CheckFuncID (ArgFlags, pID);
 *
 *=========================================================================*/
bool CEsmScriptCompile::CheckFuncID (const long ArgFlags, const TCHAR* pID, const bool Optional) {
  CEsmRecord*   pRecord;
  int		Result;
  
	/* Try and find the ID record */
  pRecord = FindRecord(pID);
 
  if (pRecord == NULL) {

		/* Don't enforce rigid checks for cell IDs */
    if ((ArgFlags & ESMSCR_FUNC_CELLID)	!= 0) return (true);

		/* Is the argument optional or not? */
    if (!Optional) {
      Result = AddMessage(ESMSCR_ERROR_BADID, _T("The object ID '%s' is not valid!"), m_Token);
      if (!Result) return (false);
     }

    return (false);
   }

	/* Is the ID the correct type */
  if ((ArgFlags & ESMSCR_FUNC_IDMASK)     == 0) return (true);
  if ((ArgFlags & ESMSCR_FUNC_EFFECTID)   != 0 && pRecord->IsType(MWESM_REC_MGEF)) return (true);
  if ((ArgFlags & ESMSCR_FUNC_LEVELCID)   != 0 && pRecord->IsType(MWESM_REC_LEVC)) return (true);
  if ((ArgFlags & ESMSCR_FUNC_LEVELIID)   != 0 && pRecord->IsType(MWESM_REC_LEVI)) return (true);
  if ((ArgFlags & ESMSCR_FUNC_CREATUREID) != 0 && pRecord->IsType(MWESM_REC_CREA)) return (true);
  if ((ArgFlags & ESMSCR_FUNC_NPCID)	  != 0 && pRecord->IsType(MWESM_REC_NPC_)) return (true);
  if ((ArgFlags & ESMSCR_FUNC_SPELLID)	  != 0 && pRecord->IsType(MWESM_REC_SPEL)) return (true);
  if ((ArgFlags & ESMSCR_FUNC_TOPICID)	  != 0 && pRecord->IsType(MWESM_REC_DIAL)) return (true);
  if ((ArgFlags & ESMSCR_FUNC_REGIONID)	  != 0 && pRecord->IsType(MWESM_REC_REGN)) return (true);
  if ((ArgFlags & ESMSCR_FUNC_ITEMID)	  != 0 && IsESMRecordCarryable(pRecord->GetType())) return (true);
  if ((ArgFlags & ESMSCR_FUNC_FACTIONID)  != 0 && pRecord->IsType(MWESM_REC_FACT)) return (true);
  if ((ArgFlags & ESMSCR_FUNC_RACEID)     != 0 && pRecord->IsType(MWESM_REC_RACE)) return (true);
  if ((ArgFlags & ESMSCR_FUNC_SOUNDID)    != 0 && pRecord->IsType(MWESM_REC_SOUN)) return (true);
  if ((ArgFlags & ESMSCR_FUNC_SCRIPTID)	  != 0 && pRecord->IsType(MWESM_REC_SCPT)) return (true);

  if ((ArgFlags & ESMSCR_FUNC_CELLID)	  != 0) {
    if ((ArgFlags & ESMSCR_FUNC_CELLSTR) != 0) return (true);
    if (pRecord->IsType(MWESM_REC_CELL)) return (true);
   }
  
  if ((ArgFlags & ESMSCR_FUNC_JOURNALID)  != 0 && pRecord->IsType(MWESM_REC_DIAL)) {
    CEsmDialogue* pDialog = (CEsmDialogue *) pRecord;
    if (pDialog->GetDialogTypeID() == MWESM_DIALTYPE_JOURNAL) return (true);
   }
  
  if ((ArgFlags & ESMSCR_FUNC_SOULGEMID) != 0 && pRecord->IsType(MWESM_REC_MISC)) {
    if (pID[0] == '"' && TSTRNICMP(pID+1, "misc_soulgem_", 13) == 0)
      return (true);
    else if (TSTRNICMP(pID, "misc_soulgem_", 13) == 0) 
      return (true);
   }

  if (!Optional) {
    Result = AddMessage(ESMSCR_ERROR_BADID, _T("ID '%s' is not a %s type!"), pID, GetFuncArgIDType(ArgFlags));
    if (!Result) return (false);
   }

  return (false);
 }
/*===========================================================================
 *		End of Class Method CEsmScriptCompile::CheckFuncID()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CEsmScriptCompile Method - CEsmRecord* FindRecord (pID);
 *
 *=========================================================================*/
CEsmRecord* CEsmScriptCompile::FindRecord (const char* pID) {
  esmrecinfo_t* pRecInfo;

  pRecInfo = m_pDocument->FindRecord(pID);
  if (pRecInfo != NULL) return (pRecInfo->pRecord);

  if (::GetEsmOptUseExtraFile()) {
    CEsmRecord* pRecord;
    m_ExtraRecords.Lookup(pID, pRecord);
    return (pRecord);
  }

  return (NULL);
}
/*===========================================================================
 *		End of Class Method CEsmScriptCompile::FindRecord()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CEsmScriptCompile Method - CEsmRecord* FindRecord (pID, pType);
 *
 *=========================================================================*/
CEsmRecord* CEsmScriptCompile::FindRecord (const char* pID, const char* pType) {
  esmrecinfo_t* pRecInfo;
  CEsmRecord*   pRecord;
  bool          Result;

	/* Try a fast lookup first */
  pRecInfo = m_pDocument->FindRecord(pID);
  if (pRecInfo != NULL && pRecInfo->pRecord->IsType(pType)) return (pRecInfo->pRecord);

	/* Do a slow lookup */
  pRecInfo = m_pDocument->FindRecord(pID, pType);
  if (pRecInfo != NULL) return (pRecInfo->pRecord);
  
	/* Check the extra file last */
  if (::GetEsmOptUseExtraFile()) {
    Result = m_ExtraRecords.Lookup(pID, pRecord);
    if (Result && pRecord != NULL && pRecord->IsType(pType)) return (pRecord);
  }

	/* No match */
  return (NULL);
}
/*===========================================================================
 *		End of Class Method CEsmScriptCompile::FindRecord()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CEsmScriptCompile Method - CEsmRecord* FindRecordCarryable (pID);
 *
 *=========================================================================*/
CEsmRecord* CEsmScriptCompile::FindRecordCarryable (const char* pID) {
  esmrecinfo_t* pRecInfo;
  CEsmRecord*   pRecord;
  bool          Result;

	/* Try a fast lookup first */
  pRecInfo = m_pDocument->FindRecord(pID);
  if (pRecInfo != NULL && IsESMRecordCarryable(pRecInfo->pRecord->GetType())) return (pRecInfo->pRecord);

	/* Do a slow lookup */
  pRecInfo = m_pDocument->FindRecordCarryable(pID);
  if (pRecInfo != NULL) return (pRecInfo->pRecord);
  
	/* Check the extra file last */
  if (::GetEsmOptUseExtraFile()) {
    Result = m_ExtraRecords.Lookup(pID, pRecord);
    if (Result && pRecord != NULL && IsESMRecordCarryable(pRecord->GetType())) return (pRecord);
  }

	/* No match */
  return (NULL);
}
/*===========================================================================
 *		End of Class Method CEsmScriptCompile::FindRecordCarryable()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CEsmScriptCompile Method - bool CheckFuncID1 (ArgFlags, pID);
 *
 *=========================================================================*/
bool CEsmScriptCompile::CheckFuncID1 (const long ArgFlags, const TCHAR* pID, const bool Optional) {
  static TCHAR  s_IDBuffer[256];
  CEsmRecord*   pRecord;
  int		Result;
  int		Length;

	/* Remove any quotes from the input ID */
  if (pID[0] == '"') {
    strnncpy(s_IDBuffer, pID + 1, 255);
    Length = TSTRLEN(s_IDBuffer);
    if (Length > 0 && s_IDBuffer[Length-1] == '"') s_IDBuffer[Length-1] = NULL_CHAR;
   }
  else {
    strnncpy(s_IDBuffer, pID, 255);
   }

	/* Check an effect ID */
  if ((ArgFlags & ESMSCR_FUNC_EFFECTID)   != 0) {
    pRecord = FindRecord(s_IDBuffer, MWESM_REC_MGEF);
    if (pRecord != NULL) return (true);
   }

	/* Check a leveled creature ID */
  if ((ArgFlags & ESMSCR_FUNC_LEVELCID)   != 0) {
    pRecord = FindRecord(s_IDBuffer, MWESM_REC_LEVC);
    if (pRecord != NULL) return (true);
   }

	/* Check a leveled item ID */
  if ((ArgFlags & ESMSCR_FUNC_LEVELIID)   != 0) {
    pRecord = FindRecord(s_IDBuffer, MWESM_REC_LEVI);
    if (pRecord != NULL) return (true);
   }

	/* Check a creature ID */
  if ((ArgFlags & ESMSCR_FUNC_CREATUREID)   != 0) {
    pRecord = FindRecord(s_IDBuffer, MWESM_REC_CREA);
    if (pRecord != NULL) return (true);
   }

	/* Check a npc ID */
  if ((ArgFlags & ESMSCR_FUNC_NPCID)   != 0) {
    pRecord = FindRecord(s_IDBuffer, MWESM_REC_NPC_);
    if (pRecord != NULL) return (true);
   }  

	/* Check a spell ID */
  if ((ArgFlags & ESMSCR_FUNC_SPELLID)   != 0) {
    pRecord = FindRecord(s_IDBuffer, MWESM_REC_SPEL);
    if (pRecord != NULL) return (true);
   }  

	/* Check a topic ID */
  if ((ArgFlags & ESMSCR_FUNC_TOPICID)   != 0) {
    pRecord = FindRecord(s_IDBuffer, MWESM_REC_DIAL);
    if (pRecord != NULL) return (true);
   }  

	/* Check a region ID */
  if ((ArgFlags & ESMSCR_FUNC_REGIONID)   != 0) {
    pRecord = FindRecord(s_IDBuffer, MWESM_REC_REGN);
    if (pRecord != NULL) return (true);
   }  

	/* Check a item ID */
  if ((ArgFlags & ESMSCR_FUNC_ITEMID)   != 0) {
    pRecord = FindRecordCarryable(s_IDBuffer);
    if (pRecord != NULL) return (true);
   }  

	/* Check a faction ID */
  if ((ArgFlags & ESMSCR_FUNC_FACTIONID)   != 0) {
    pRecord = FindRecord(s_IDBuffer, MWESM_REC_FACT);
    if (pRecord != NULL) return (true);
   }  

	/* Check a race ID */
  if ((ArgFlags & ESMSCR_FUNC_RACEID)   != 0) {
    pRecord = FindRecord(s_IDBuffer, MWESM_REC_RACE);
    if (pRecord != NULL) return (true);
   }  

	/* Check a sound ID */
  if ((ArgFlags & ESMSCR_FUNC_SOUNDID)   != 0) {
    pRecord = FindRecord(s_IDBuffer, MWESM_REC_SOUN);
    if (pRecord != NULL) return (true);
   }  

	/* Check a script ID */
  if ((ArgFlags & ESMSCR_FUNC_SCRIPTID)   != 0) {
    pRecord = FindRecord(s_IDBuffer, MWESM_REC_SCPT);
    if (pRecord != NULL) return (true);
   }  

	/* Check the cell ID */
  if ((ArgFlags & ESMSCR_FUNC_CELLID)	  != 0) {
    if ((ArgFlags & ESMSCR_FUNC_CELLSTR) != 0) return (true);
    pRecord = FindRecord(s_IDBuffer, MWESM_REC_CELL);
    if (pRecord != NULL) return (true);
   }

	/* Check a journal ID type */  
  if ((ArgFlags & ESMSCR_FUNC_JOURNALID) != 0) {
    pRecord = FindRecord(s_IDBuffer, MWESM_REC_DIAL);

    if (pRecord != NULL) {
      CEsmDialogue* pDialog = (CEsmDialogue *) pRecord;
      //SystemLog.Printf("%s->GetDialogTypeID() = %d", pDialog->GetID(), pDialog->GetDialogTypeID());
      if (pDialog->GetDialogTypeID() == MWESM_DIALTYPE_JOURNAL) return (true);
     }
   }
  
	/* Check a soulgem ID */
  if ((ArgFlags & ESMSCR_FUNC_SOULGEMID) != 0) {
    pRecord = FindRecord(s_IDBuffer, MWESM_REC_MISC);
    
    if (pRecord != NULL) {
      if (TSTRNICMP(s_IDBuffer, "misc_soulgem_", 13) == 0) return (true);
     }
   }

	/* Default case of no specific ID */
  pRecord = FindRecord(s_IDBuffer);

  if ((ArgFlags & ESMSCR_FUNC_IDMASK)   == 0) { 
    if (pRecord != NULL) return (true);
   }

	/* Don't enforce rigid checks for cell IDs */
  //if ((ArgFlags & ESMSCR_FUNC_CELLID) != 0) return (true);

	/* Is the argument optional or not? */
  if (pRecord == NULL) {
    if (!Optional) {
      Result = AddMessage(ESMSCR_ERROR_BADID, _T("The object ID '%s' is not valid!"), s_IDBuffer);
      if (!Result) return (false);
     }
   }

	/* Record was found but not the correct type */
  if (!Optional) {
    Result = AddMessage(ESMSCR_ERROR_BADID, _T("ID '%s' is not a %s type!"), s_IDBuffer, GetFuncArgIDType(ArgFlags));
    if (!Result) return (false);
   }

  return (false);
 }
/*===========================================================================
 *		End of Class Method CEsmScriptCompile::CheckFuncID1()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CEsmScriptCompile Method - void ClearErrors (void);
 *
 * Clears the current list of compile errors.
 *
 *=========================================================================*/
void CEsmScriptCompile::ClearErrors (void) {
  DEFINE_FUNCTION("CEsmScriptCompile::ClearErrors()");
  CEsmScriptError* pError;
  int		   Index;

  for (Index = 0; Index < m_ErrorArray.GetNumElements(); Index++) {
    pError = m_ErrorArray.GetAt(Index);
    DestroyPointer(pError);
   }

  m_ErrorArray.RemoveAll();
 }
/*===========================================================================
 *		End of Class Method CEsmScriptCompile::ClearErrors()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CEsmScriptCompile Method - void ClearExprStack (void);
 *
 *=========================================================================*/
void CEsmScriptCompile::ClearExprStack (void) {
  DEFINE_FUNCTION("CEsmScriptCompile::ClearExprStack()");
  esmscrstack_t* pStack;

  while (m_ExprStack.GetSize() > 0) {  
    pStack = (esmscrstack_t *) m_ExprStack.Pop();
    //SystemLog.Printf ("Stack: %s", pStack->Token);
    DestroyPointer(pStack);
   }

 }
/*===========================================================================
 *		End of Class Method CEsmScriptCompile::ClearExprStack()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CEsmScriptCompile Method - void ClearIfStatementStack (void);
 *
 *=========================================================================*/
void CEsmScriptCompile::ClearIfStatementStack (void) {
  DEFINE_FUNCTION("CEsmScriptCompile::ClearIfStatementStack()");
  esmscrifblock_t* pStack;

  while (m_IfStatementStack.GetSize() > 0) {  
    pStack = (esmscrifblock_t *) m_IfStatementStack.Pop();
    DestroyPointer(pStack);
   }

 }
/*===========================================================================
 *		End of Class Method CEsmScriptCompile::ClearIfStatementStack()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CEsmScriptCompile Method - int ComputeLocalVarDataSize (void);
 *
 * Computes the size required to store all the currently defined local
 * variable names.
 *
 *=========================================================================*/
int CEsmScriptCompile::ComputeLocalVarDataSize (void) {
  int Size = 0;
  int Index;

  for (Index = 0; Index < m_NumShortVars; Index++) {
    Size += TSTRLEN(m_ShortVars[Index].Name) + 1;
   }

  for (Index = 0; Index < m_NumLongVars; Index++) {
    Size += TSTRLEN(m_LongVars[Index].Name) + 1;
   }

  for (Index = 0; Index < m_NumFloatVars; Index++) {
    Size += TSTRLEN(m_FloatVars[Index].Name) + 1;
   }

  return (Size);
 }
/*===========================================================================
 *		End of Class Method CEsmScriptCompile::ComputeLocalVarDataSize()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CEsmScriptCompile Method - int Compile (void);
 *
 * Description
 *
 *=========================================================================*/
int CEsmScriptCompile::Compile (void) {
  int Result;

	/* Ignore if the document object hasn't been set */
  if (m_pDocument == NULL){
    ErrorHandler.AddError(ERR_BADINPUT, _T("Compiler document object has not been set!"));
    return (-1);
   }

	/* Reset the parsing variables */
  m_pParse	      = m_pScriptText;
  m_TokenParsed       = true;
  m_LineHasRef        = false;
  m_LastTokenNegative = false;
  m_Token	      = "";
  m_LastToken         = "";
  m_ScriptName	      = "";
  m_TokenID	      = ESMSCR_TOKEN_UNKNOWN;
  m_CurrentLine       = 0;
  m_CurrentCharPos    = 0;
  m_StartCharPos      = 0;
  m_StartLine         = 0;
  m_NumShortVars      = 0;
  m_NumLongVars       = 0;
  m_NumFloatVars      = 0;
  m_ScriptDataSize    = 0;
  m_LastLineDataPos   = 0;
  m_StatementCount    = 0;
  ClearErrors();
  ClearExprStack();
  ClearIfStatementStack();

	/* Start compiling with the root block table */
  Result = ParseTable(l_MainBlock);

	/* Post cleanup */
  ClearExprStack();
  ClearIfStatementStack();

	/* Update the local var data */
  MakeScriptVarData();

  return (Result);
 }
/*===========================================================================
 *		End of Class Method CEsmScriptCompile::Compile()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CEsmScriptCompile Method - bool FindLocalVar (pName);
 *
 * Searches for the given local variable in the array (not case sensitive).
 * Returns the false if it is not found.
 *
 *=========================================================================*/
bool CEsmScriptCompile::FindLocalVar (const TCHAR* pName) {
  int Index;

  for (Index = 0; Index < m_NumShortVars; Index++) {
    if (TSTRICMP(pName, m_ShortVars[Index].Name) == 0) return (true);
   }

  for (Index = 0; Index < m_NumLongVars; Index++) {
    if (TSTRICMP(pName, m_LongVars[Index].Name) == 0) return (true);
   }

  for (Index = 0; Index < m_NumFloatVars; Index++) {
    if (TSTRICMP(pName, m_FloatVars[Index].Name) == 0) return (true);
   }
  
  return (false);
 }
/*===========================================================================
 *		End of Class Method CEsmScriptCompile::FindLocalVar()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CEsmScriptCompile Method - int FindLocalVarIndex (pName, Type);
 *
 * Searches for the given local variable in the array (not case sensitive).
 * Returns the array index (1-based) or -1 if it is not found.
 *
 *=========================================================================*/
int CEsmScriptCompile::FindLocalVarIndex (const TCHAR* pName, char& Type) {
  int  Index;


  for (Index = 0; Index < m_NumShortVars; Index++) {
    if (TSTRICMP(pName, m_ShortVars[Index].Name) == 0) {
      Type = 's';

      if (Index == ESMSCR_SPECIALLOCALVAR_INDEX) {
        AddMessage(ESMSCR_WARNING_LOCALVAR34, _T("Use of 34th local short variable '%s' may result in errors and is not recommended!"), pName);
      }
      return (Index + 1);
     }
   }

  for (Index = 0; Index < m_NumLongVars; Index++) {
    if (TSTRICMP(pName, m_LongVars[Index].Name) == 0) {
      Type = 'l';

      if (Index == ESMSCR_SPECIALLOCALVAR_INDEX) {
        AddMessage(ESMSCR_WARNING_LOCALVAR34, _T("Use of 34th local long variable '%s' may result in errors and is not recommended!"), pName);
      }

      return (Index + 1);
     }
   }

  for (Index = 0; Index < m_NumFloatVars; Index++) {
    if (TSTRICMP(pName, m_FloatVars[Index].Name) == 0) {
      Type = 'f';

      if (Index == ESMSCR_SPECIALLOCALVAR_INDEX) {
        AddMessage(ESMSCR_WARNING_LOCALVAR34, _T("Use of 34th local float variable '%s' may result in errors and is not recommended!"), pName);
      }

      return (Index + 1);
     }
   }
  
  return (-1);
 }
/*===========================================================================
 *		End of Class Method CEsmScriptCompile::FindLocalVarIndex()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CEsmScriptCompile Method - int FindMsgLevel (MessageID);
 *
 *=========================================================================*/
int CEsmScriptCompile::FindMsgLevel (const int MessageID) {
  int Index;

  for (Index = 0; Index < m_NumMsgLevels; Index++) {
    if (m_MsgLevels[Index].MessageID == MessageID) return (m_MsgLevels[Index].Level);
   }

	/* Return the default level if not found */
  return (ESMSCR_MSGLEVEL_WARNING);
 }
/*===========================================================================
 *		End of Class Method CEsmScriptCompile::FindMsgLevel()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CEsmScriptCompile Method - const TCHAR* GetFuncArgIDType (ArgFlags);
 *
 *=========================================================================*/
const TCHAR* CEsmScriptCompile::GetFuncArgIDType (const long ArgFlags) {

  if ((ArgFlags & ESMSCR_FUNC_IDMASK) == 0) return _T("None");

  if ((ArgFlags & ESMSCR_FUNC_NPCID) != 0) {
    if ((ArgFlags & ESMSCR_FUNC_CREATUREID) != 0) return _T("NPC/Creature");
    return _T("NPC");
   }

  if ((ArgFlags & ESMSCR_FUNC_CELLID)	  != 0) return _T("Cell");
  if ((ArgFlags & ESMSCR_FUNC_EFFECTID)   != 0) return _T("Effect");
  if ((ArgFlags & ESMSCR_FUNC_LEVELCID)   != 0) return _T("Level Creature");
  if ((ArgFlags & ESMSCR_FUNC_LEVELIID)   != 0) return _T("Level Item");
  if ((ArgFlags & ESMSCR_FUNC_CREATUREID) != 0) return _T("Creature");
  if ((ArgFlags & ESMSCR_FUNC_SPELLID)	  != 0) return _T("Spell");
  if ((ArgFlags & ESMSCR_FUNC_SOULGEMID)  != 0) return _T("Soulgem");
  if ((ArgFlags & ESMSCR_FUNC_TOPICID)	  != 0) return _T("Topic");
  if ((ArgFlags & ESMSCR_FUNC_REGIONID)   != 0) return _T("Region");
  if ((ArgFlags & ESMSCR_FUNC_ITEMID)	  != 0) return _T("Carryable");
  if ((ArgFlags & ESMSCR_FUNC_FACTIONID)  != 0) return _T("Faction");
  if ((ArgFlags & ESMSCR_FUNC_JOURNALID)  != 0) return _T("Journal");
  if ((ArgFlags & ESMSCR_FUNC_RACEID)     != 0) return _T("Race");
  if ((ArgFlags & ESMSCR_FUNC_SOUNDID)    != 0) return _T("Sound");
  if ((ArgFlags & ESMSCR_FUNC_SCRIPTID)   != 0) return _T("Script");
    
  return _T("Unknown");
 }
/*===========================================================================
 *		End of Class Method CHAR* CEsmScriptCompile::GetFuncArgIDType()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CEsmScriptCompile Method - const TCHAR* GetFuncArgRefType (ArgFlags);
 *
 * Returns the 2-byte output script data for the current function argument
 * symbol type (ex: ' r' or ' o' etc...).
 *
 *=========================================================================*/
const TCHAR* CEsmScriptCompile::GetFuncArgRefType (const long ArgFlags) {

	/* Special case for the GetDetected function */
  if (m_pCurrentFunc != NULL && m_pCurrentFunc->OpCode == 0x114e) return _T(" r");

  if ((ArgFlags & ESMSCR_FUNC_CELLID)	  != 0) return _T(" c");
  if ((ArgFlags & ESMSCR_FUNC_FACTIONID)  != 0) return _T(" t");
  if ((ArgFlags & ESMSCR_FUNC_JOURNALID)  != 0) return _T(" d");
  if ((ArgFlags & ESMSCR_FUNC_RACEID)     != 0) return _T(" a");
  if ((ArgFlags & ESMSCR_FUNC_SOUNDID)    != 0) return _T(" b");
  if ((ArgFlags & ESMSCR_FUNC_ITEMID)	  != 0) return _T(" o");
  if ((ArgFlags & ESMSCR_FUNC_SPELLID)	  != 0) return _T(" o");
  if ((ArgFlags & ESMSCR_FUNC_CREATUREID) != 0) return _T(" o");
  if ((ArgFlags & ESMSCR_FUNC_NPCID)      != 0) return _T(" o");
  if ((ArgFlags & ESMSCR_FUNC_SCRIPTID)   != 0) return _T(" m"); 
  return _T(" r");
 }
/*===========================================================================
 *		End of Class Method TCHAR* CEsmScriptCompile::GetFuncArgRefType()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CEsmScriptCompile Method - CEsmGlobal* GetGlobal (pName);
 *
 *=========================================================================*/
CEsmGlobal* CEsmScriptCompile::GetGlobal (const TCHAR* pName) {
  CEsmGlobal* pGlobal;

	/* Attempt to find the global variable */
  pGlobal = m_pDocument->GetGlobal(pName);
  if (pGlobal != NULL) return (pGlobal);

  if (::GetEsmOptUseExtraFile()) {
    CEsmRecord* pRecord;

    bool Result = m_ExtraRecords.Lookup(pName, pRecord);
    if (!Result) return (NULL);

    if (pRecord->IsType(MWESM_REC_GLOB)) return (CEsmGlobal *) pRecord;
  }

  return (NULL);
}
/*===========================================================================
 *		End of Class Method CEsmScriptCompile::GetGlobal()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CEsmScriptCompile Method - int GetGlobalType (pName);
 *
 *=========================================================================*/
int CEsmScriptCompile::GetGlobalType (const TCHAR* pName) {
  //if (TSTRICMP(pName, "GameHour") == 0) return (ESMSCR_VAR_FLOAT);
  //if (TSTRICMP(pName, "Day") == 0) return (ESMSCR_VAR_SHORT);
  //if (TSTRICMP(pName, "PlayerGold") == 0) return (ESMSCR_VAR_LONG);
  CEsmGlobal* pGlobal;
  
	/* Attempt to find the global variable */
  pGlobal = GetGlobal(pName);
  if (pGlobal == NULL) return (ESMSCR_VAR_UNKNOWN);

  switch (pGlobal->GetType()) {
    case MWESM_GLOBAL_SHORT: return (ESMSCR_VAR_SHORT);
    case MWESM_GLOBAL_LONG:  return (ESMSCR_VAR_LONG);
    case MWESM_GLOBAL_FLOAT: return (ESMSCR_VAR_FLOAT);
   }

  return (ESMSCR_VAR_UNKNOWN);
 }
/*===========================================================================
 *		End of Class Method CEsmScriptCompile::GetGlobalType()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CEsmScriptCompile Method - int GetNextToken (void);
 *
 * Parses out the next token from the current parsing position.
 *
 *=========================================================================*/
int CEsmScriptCompile::GetNextToken (void) {
  //DEFINE_FUNCTION("CEsmScriptCompile::GetNextToken()");
  m_LastToken = m_Token;

	/* Skip any space/comments before the token */
  if (IsParseWhiteSpace()) SkipTokenWhiteSpace();
  if (IsParseComment())    SkipTokenComment();

	/* Initialize the new token parameters */
  m_StartCharPos = m_CurrentCharPos;
  m_StartLine    = m_CurrentLine;
  m_TokenParsed  = false;

	/* Determine the basic token type from the first character */
  if (*m_pParse == ESMSCR_CHAR_EOL) {
    m_TokenID = ESMSCR_TOKEN_EOL;
    m_Token = "";
    m_CurrentCharPos = 0;
    m_CurrentLine++;
    m_pParse++;
    m_LineHasRef = false;
    m_LastLineDataPos = m_ScriptDataSize;
   }
  else if (*m_pParse == NULL_CHAR) {
    m_TokenID = ESMSCR_TOKEN_EOS;
    m_Token = "";
   }
  else if (IsParseStringChar()) {
    return GetStringToken();
   }
  else if (IsParseSymbolF()) {
    return GetSymbolToken();
   }
  else if (IsParseDigit()) {
    return GetNumberToken();
   }
  else if (IsParseOperator()) {
    return GetOperatorToken();
   }
  else {
     AddMessage(ESMSCR_ERROR_BADTOKEN, "Unknown token type character '%c' found!", *m_pParse);
     return (ESMSCR_RESULT_ERROR);
   }

  return (ESMSCR_RESULT_OK);
 }
/*===========================================================================
 *		End of Class Method CEsmScriptCompile::GetNextToken()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CEsmScriptCompile Method - int GetNumberToken (void);
 *
 * Parses out an operator token from the current parsing position.  Returns
 * ESMSCR_RESULT_OK on success.
 *
 * Parses any valid integer or simple floating point number (no exponent
 * format supported).  Stops parsing at the first non-digit.  Does not
 * range check the number at all.
 *
 *=========================================================================*/
int CEsmScriptCompile::GetNumberToken (void) {
  TCHAR* pStart   = m_pParse;
  int    StartPos = m_CurrentCharPos;
  bool	 Result;
  
  do {
    m_CurrentCharPos++;
    m_pParse++;
  } while (!isspace(*m_pParse) && !ispunct(*m_pParse));

	/* Check for floats */
  if (*m_pParse == '.') {

    do {
      m_CurrentCharPos++;
      m_pParse++;
     } while (!isspace(*m_pParse) && !ispunct(*m_pParse));

     m_TokenID = ESMSCR_TOKEN_FLOAT;
   }
  else {
    m_TokenID = ESMSCR_TOKEN_INTEGER;
   }

  m_TokenID = ESMSCR_TOKEN_NUMBER;	/* Simplifies the parse tables */
  m_Token.Copy(pStart, m_pParse - pStart);

	/* Ensure a valid number */
  if (!IsStringFloat(m_Token)) {
    Result = AddMessage(ESMSCR_ERROR_BADNUMBER, _T("Invalid number string '%s' found!"), m_Token);
    if (!Result) return (ESMSCR_RESULT_ERROR);
   }

  return (ESMSCR_RESULT_OK);
 }
/*===========================================================================
 *		End of Class Method CEsmScriptCompile::GetNumberToken()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CEsmScriptCompile Method - int GetOperatorToken (void);
 *
 * Parses out an operator token from the current parsing position.  Returns
 * ESMSCR_RESULT_OK on success.
 *
 * Only parses valid ESM script operators.
 *
 *=========================================================================*/
int CEsmScriptCompile::GetOperatorToken (void) {
  TCHAR*	pStart    = m_pParse;
  int		StartPos  = m_CurrentCharPos;
  TCHAR		TempOp[4] = "\0\0\0";
  bool		Result;

	/* Check for a 2-byte operator first */
  TempOp[0] = m_pParse[0];
  TempOp[1] = m_pParse[1];
  m_TokenID = GetESMScriptOpToken(TempOp);

  if (m_TokenID != ESMSCR_TOKEN_UNKNOWN) {
    m_pParse += 2;
    m_CurrentCharPos += 2;
    m_Token.Copy(pStart, 2);
   }
	/* Only a 1-byte operator */
  else {
    TempOp[1] = NULL_CHAR;
    m_TokenID = GetESMScriptOpToken(TempOp);
    m_Token.Copy(pStart, 1);
    m_pParse++;
    m_CurrentCharPos++;
   }

	/* Check for special operators/conditions */
  if (m_TokenID == ESMSCR_TOKEN_VAROP || m_TokenID == ESMSCR_TOKEN_FUNCOP) {

		/* Line can only have one object reference */
    if (m_LineHasRef) {
      AddMessage(ESMSCR_ERROR_MULTREF, _T("Multiple object references found on line!"));
      return (ESMSCR_RESULT_ERROR);
     }

    m_LineHasRef   = true;
    m_LineRefToken = m_LastToken;
    //m_LineRefID    = m_TokenID;

#if !defined(MWEDIT_SCRIPT_MWSE)
    if (m_TokenID == ESMSCR_TOKEN_FUNCOP) {
      InsertScriptDataRef((const TCHAR *)m_LastToken, m_LastToken.GetLength());
     }
    else {
	/* Varops output in the ParseVarRef() */
     }
#endif

   }
	/* Check for whitespace surrounding brackets */
  else if (m_TokenID == ESMSCR_TOKEN_OPENBRAC || m_TokenID == ESMSCR_TOKEN_CLOSEBRAC) {
    if (!isspace(m_pParse[-2]) || !isspace(m_pParse[0])) {
      AddMessage(ESMSCR_WARNING_NOSPACE, _T("Open/closing bracket missing space characters on one/both sides!"));
     }
   }
	/* Check for whitespace surround relational operators */
  else if (m_TokenID == ESMSCR_TOKEN_RELOP) {
    if (m_Token.GetLength() == 1) {
      if (!isspace(m_pParse[-2]) || !isspace(m_pParse[0])) {
        Result = AddMessage(ESMSCR_WARNING_NOSPACE, _T("Comparison operator missing space characters on one/both sides!"));
	if (!Result) return (ESMSCR_RESULT_ERROR);
       }
     }
    else if (m_Token.GetLength() == 2) {
      if (!isspace(m_pParse[-3]) || !isspace(m_pParse[0])) {
        Result = AddMessage(ESMSCR_WARNING_NOSPACE, _T("Comparison operator missing space characters on one/both sides!"));
	if (!Result) return (ESMSCR_RESULT_ERROR);
       }
     }
   }

  return (ESMSCR_RESULT_OK);
 }
/*===========================================================================
 *		End of Class Method CEsmScriptCompile::GetOperatorToken()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CEsmScriptCompile Method - int GetStringToken (void);
 *
 * Parses a string token starting at the opening " character. Returns
 * ESMSCR_RESULT_OK on success.
 *
 *=========================================================================*/
int CEsmScriptCompile::GetStringToken (void) {
  TCHAR* pStart    = m_pParse;
  int    StartPos  = m_CurrentCharPos;

  do {
    m_CurrentCharPos++;
    m_pParse++;
   } while (*m_pParse != '"' && *m_pParse != NULL_CHAR && *m_pParse != ESMSCR_CHAR_EOL);

	/* Check for an unclosed string */
  if (*m_pParse != '"') {
    AddMessage(ESMSCR_ERROR_BADTOKEN, "Bad String, no terminating \" found on line for string starting at position %d!", StartPos);
    return (ESMSCR_RESULT_ERROR);
   }

	/* Skip the " character */
  m_pParse++;
  m_CurrentCharPos++;

	/* Copy the string token */
  m_Token.Copy(pStart, m_pParse - pStart);
  m_TokenID = ESMSCR_TOKEN_STRING;

	/* check for a string'ed symbol */
  //if (IsSymbolID(m_Token)) m_TokenID = EMSCR_TOKEN_SYMBOL;

  return (ESMSCR_RESULT_OK);
 }
/*===========================================================================
 *		End of Class Method CEsmScriptCompile::GetStringToken()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CEsmScriptCompile Method - int GetSymbolToken (void);
 *
 * Parses out a symbol token from the current parsing position.  Returns
 * ESMSCR_RESULT_OK on success.
 *
 * A symbol can be any variable or reserved word.  The reserved word
 * list is checked and the token type updated as required.
 *
 *=========================================================================*/
int CEsmScriptCompile::GetSymbolToken (void) {
  TCHAR*		pStart = m_pParse;
  CEsmGlobal*		pGlobal;
  esmscrfuncinfo_t*	pFunc;
  int			Result;
  bool			fResult;

  do {
    m_CurrentCharPos++;
    m_pParse++;
  } while (IsParseSymbol());
	
	/* Copy the token name */
  m_Token.Copy(pStart, m_pParse - pStart);
  m_TokenID = ESMSCR_TOKEN_SYMBOL;

	/* Check if the token is a reserved word */
  Result = GetESMScriptResToken(m_Token);

  if (Result != ESMSCR_TOKEN_UNKNOWN) {
    m_TokenID = Result;
    return (ESMSCR_RESULT_OK);
   }

	/* Check if the token is a local variable */
  fResult = FindLocalVar(m_Token);

  if (fResult) {
    m_TokenID = ESMSCR_TOKEN_LOCALVAR;
    return (ESMSCR_RESULT_OK);
   }

	/* Check for a global variable */
  pGlobal = GetGlobal(m_Token);

  if (pGlobal != NULL) {
    m_Token = pGlobal->GetID();	/* Use the correct case for the ID */
    m_TokenID = ESMSCR_TOKEN_GLOBALVAR;
    return (ESMSCR_RESULT_OK);
   }

   	/* Check for a function */
  pFunc = GetESMScriptFuncInfo(m_Token);

  if (pFunc != NULL) {

    if (m_pCurrentFunc != NULL) {
      AddMessage(ESMSCR_ERROR_BADTOKEN, _T("Cannot call the function '%s' from within another function!"), m_Token);
      return (ESMSCR_RESULT_ERROR);
    }

    m_pCurrentFunc = pFunc;
    m_NumFuncArgs  = 0;
    m_LastFuncArg  = 0;
    m_FuncArgIndex = 0;
    m_NumMsgButtons = 0;
    m_NumMsgArgs = 0;
    m_ManyArgPos = 0;
    m_TokenID = ESMSCR_TOKEN_FUNCTION;

		/* Check for Bloodmoon/Tribunal */
    if ((pFunc->Flags & ESMSCR_FUNC_BLOODMOON) != 0 && !GetEsmOptAllowBloodmoon()) {
      fResult = AddMessage(ESMSCR_WARNING_EXPANSIONFUNC, _T("The Bloodmoon function '%s' may not be supported!"), m_Token);
      if (!fResult) return (ESMSCR_RESULT_ERROR);
    }

    if ((pFunc->Flags & ESMSCR_FUNC_TRIBUNAL) != 0 && !GetEsmOptAllowTribunal()) {
      fResult = AddMessage(ESMSCR_WARNING_EXPANSIONFUNC, _T("The Tribunal function '%s' may not be supported!"), m_Token);
      if (!fResult) return (ESMSCR_RESULT_ERROR);
    }

    return (ESMSCR_RESULT_OK);
   }

	/* Check for a custom function */
  pFunc = GetESMScriptCustomFuncInfo(m_Token);

  if (pFunc != NULL) {
    m_pCurrentFunc  = pFunc;
    m_NumFuncArgs   = 0;
    m_LastFuncArg   = 0;
    m_FuncArgIndex  = 0;
    m_NumMsgButtons = 0;
    m_NumMsgArgs    = 0;
    m_ManyArgPos    = 0;
    m_TokenID = ESMSCR_TOKEN_FUNCTIONX;

    if (!GetEsmOptAllowExtFuncs()) {
      fResult = AddMessage(ESMSCR_WARNING_EXTFUNC, _T("Extended function '%s' may not be supported!"), m_Token);
      if (!fResult) return (ESMSCR_RESULT_ERROR);
    }

    return (ESMSCR_RESULT_OK);
  }
	
	/* Check for an object ID - for speed/convience, this is done later on in the 
	 * parsing routine when we expect to find an object symbol */
/*  Result = this->IsSymbolID(m_Token);

  if (Result) {
    m_TokenID = ESMSCR_TOKEN_SYMBOLID;
    if (m_Token[0] == '_') AddMessage(_T("Object IDs that begin with an '_' should be enclosed in \"quotes\" (%s)."), m_Token);
    return (ESMSCR_RESULT_OK);
   } */
 
  return (ESMSCR_RESULT_OK);
 }
/*===========================================================================
 *		End of Class Method CEsmScriptCompile::GetSymbolToken()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CEsmScriptCompile Method - bool InsertScriptDataRef (pData, Size);
 *
 * Inserts an object reference at the beginning of the current output
 * line.
 *
 *=========================================================================*/
bool CEsmScriptCompile::InsertScriptDataRef (const TCHAR* pData, int Size) {
  short OpCode;

  	/* Check for buffer overflows */
  if (m_ScriptDataSize + Size >= ESMSCR_DATA_SIZE) {
    AddError("Maximum compiled script size %d exceeded!", ESMSCR_DATA_SIZE);
    return (false);
   }

	/* Shift existing line output data */
  if (m_ScriptDataSize >= m_LastLineDataPos) {
    memmove(m_ScriptData + m_LastLineDataPos + Size + 3, m_ScriptData + m_LastLineDataPos, m_ScriptDataSize - m_LastLineDataPos);
   }

	/* Insert the object reference data */
  OpCode = 0x010C;
  memcpy(m_ScriptData + m_LastLineDataPos, &OpCode, 2);

  if (pData[0] == '"') {
    Size -= 2;
    m_ScriptData[m_LastLineDataPos+2] = (byte)Size;
    memcpy(m_ScriptData + m_LastLineDataPos + 3, pData + 1, (byte)Size);
   }
  else {
    m_ScriptData[m_LastLineDataPos+2] = (byte)Size;
    memcpy(m_ScriptData + m_LastLineDataPos + 3, pData, (byte)Size);
   }

	/* Adjust the set position if required */
  if (m_LastSetPos >= m_LastLineDataPos) m_LastSetPos += Size + 3;
  if (m_LastIfPos  >= m_LastLineDataPos) m_LastIfPos += Size + 3;
  m_ScriptDataSize += Size + 3;

  return (true);
 }
/*===========================================================================
 *		End of Class Method CEsmScriptCompile::InsertScriptDataRef()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CEsmScriptCompile Method - bool IsSymbolID (Token);
 *
 *=========================================================================*/
bool CEsmScriptCompile::IsSymbolID (CSString& Token) {
  CEsmRecord*    pRecord;
  TCHAR         TempName[128];
  const TCHAR*  pTempName;
  int           Length;

	/* Remove optional quotes */
  if (Token.GetAt(0) == '"') {
    strnncpy(TempName, ((const TCHAR *)Token) + 1, 127);
    Length = TSTRLEN(TempName);
    if (Length > 0 && TempName[Length-1] == '"') TempName[Length-1] = NULL_CHAR;
    pTempName = TempName;
   }
  else {
    pTempName = Token;
  }

  pRecord = FindRecord(pTempName);

  if (pRecord != NULL) {
    Token = pRecord->GetID();	/* Preserve ID case */
    return (true);
  }

  return (false);
 }
/*===========================================================================
 *		End of Class Method CEsmScriptCompile::IsSymbolID()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CEsmScriptCompile Method - void MakeScriptVarData (void);
 *
 * Creates the script local variable data block from the current compiled
 * script information.
 *
 *=========================================================================*/
void CEsmScriptCompile::MakeScriptVarData (void) {
  DEFINE_FUNCTION("CEsmScriptCompile::MakeScriptVarData()");
  int   Index;
  char* pData;

	/* Delete the current local variable data */
  DestroyArrayPointer(m_pLocalVarData);

	/* Compute the size of the current local variables */
  m_LocalVarDataSize = ComputeLocalVarDataSize();
  if (m_LocalVarDataSize == 0) return;

	/* Create the new data block for the local variables */
  CreateArrayPointer(m_pLocalVarData, char, m_LocalVarDataSize);
  pData = m_pLocalVarData;

	/* Add all the short locals */
  for (Index = 0; Index < m_NumShortVars; Index++) {
    strcpy(pData, m_ShortVars[Index].Name);
    pData += strlen(m_ShortVars[Index].Name) + 1;
   }

	/* Add all the long locals */
  for (Index = 0; Index < m_NumLongVars; Index++) {
    strcpy(pData, m_LongVars[Index].Name);
    pData += strlen(m_LongVars[Index].Name) + 1;
   }

	/* Add all the float locals */
  for (Index = 0; Index < m_NumFloatVars; Index++) {
    strcpy(pData, m_FloatVars[Index].Name);
    pData += strlen(m_FloatVars[Index].Name) + 1;
   }

 }
/*===========================================================================
 *		End of Class Method CEsmScriptCompile::MakeScriptVarData()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CEsmScriptCompile Method - int OutputToken (Value);
 *
 * Outputs the given 2-byte token value to the script data stream.
 *
 *=========================================================================*/
int CEsmScriptCompile::OutputToken (const short Value) {
  AddScriptData(&Value, sizeof(short));
  return (0);
 }
/*===========================================================================
 *		End of Class Method CEsmScriptCompile::OutputToken()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CEsmScriptCompile Method - short GetAnimGroupID (pString);
 *
 *=========================================================================*/
short CEsmScriptCompile::GetAnimGroupID (const TCHAR* pString) {
  if (GetEsmOptAllowTribunal()) return GetESMAnimGroupID(pString);
  return GetESMAnimGroupOldID(pString);
}
/*===========================================================================
 *		End of Class Method CEsmScriptCompile::GetAnimGroupID()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CEsmScriptCompile Method - int CheckFuncArg (void);
 *
 * Checks the current token against the current function argument and determines
 * whether it is valid or not. Return values are:
 *
 *	ESMSC_FUNCARG_ERROR	- Argument type does not match or other error
 *	ESMSC_FUNCARG_OK	- Successful check
 *
 * Protected class method.
 *
 *=========================================================================*/
int CEsmScriptCompile::CheckFuncArg (void) {
  bool     Result;
  int      iResult;
  __int64  FuncFlags;
  bool     NoMessage;
  bool	   IsOptional;

	/* Ensure a valid function and argument index */
  if (m_pCurrentFunc == NULL || m_FuncArgIndex >= ESMSCR_MAX_FUNCARGS) {
    Result = AddMessage(ESMSCR_ERROR_TOOMANYARGS, _T("Exceeded the maximum of %d function arguments!"), ESMSCR_MAX_FUNCARGS);
    return (ESMSC_FUNCARG_ERROR);
   }

	/* Get the flags from the current function argument */
  FuncFlags  = m_pCurrentFunc->Var[m_FuncArgIndex];
  NoMessage  = (FuncFlags & ESMSCR_FUNC_MANY) != 0;
  IsOptional = (FuncFlags & ESMSCR_FUNC_OPTIONAL) != 0;

	/* See if the function accepts any argument at this position */
  if ((FuncFlags & ESMSCR_FUNC_VARMASK) == 0) {
    Result = AddMessage(ESMSCR_ERROR_BADFUNCARG, _T("Function does not accept argument #%d!"), m_NumFuncArgs);
    if (!Result) return (ESMSC_FUNCARG_ERROR);
    return (ESMSC_FUNCARG_OK);
   }

	/* Special case required for some functions */
  if ((FuncFlags & ESMSCR_FUNC_OPTSTART) != 0) {
    m_FuncOptPos   = m_ScriptDataSize;
    m_FuncOptCount = m_NumFuncArgs;
    AddScriptData("\0\0", 2);
   }

	/* Check the type of the current token */
  switch (m_TokenID) {
    case ESMSCR_TOKEN_RESET:
          if ((FuncFlags & ESMSCR_FUNC_RESET) == 0) {
	    if (NoMessage) return (ESMSC_FUNCARG_ERROR);
	    if (IsOptional) return (ESMSC_FUNCARG_ENDTABLE);
	    Result = AddMessage(ESMSCR_WARNING_BADFUNCARG, _T("Function does not accept 'reset' for argument #%d!"), m_NumFuncArgs);
	    if (!Result) return (ESMSC_FUNCARG_ERROR);
	   }
	  break;
    case ESMSCR_TOKEN_NUMBER:
	  if ((FuncFlags & ESMSCR_FUNC_EFFECT) != 0) {
	    iResult = atoi(m_Token);

	    if (iResult < 0 || iResult >= MWESM_EFFECT_MAX) {
	      if (NoMessage) return (ESMSC_FUNCARG_ERROR);
	      if (IsOptional) return (ESMSC_FUNCARG_ENDTABLE);
	      Result = AddMessage(ESMSCR_ERROR_BADFUNCARG, _T("Invalid magic effect id '%s'!"), m_Token);
	      if (!Result) return (ESMSC_FUNCARG_ERROR);
	     }
            else {
	      OutputEffect(iResult);
	      m_LastFuncArgSymbol = false;
	      m_LastSetSymbol     = false;
	     }
	   }
          else if ((FuncFlags & ESMSCR_FUNC_RESET) != 0) {
	   }
          else if ((FuncFlags & ESMSCR_FUNC_NUMBER) == 0) {
	    if (NoMessage) return (ESMSC_FUNCARG_ERROR);
	    if (IsOptional) return (ESMSC_FUNCARG_ENDTABLE);
	    Result = AddMessage(ESMSCR_ERROR_BADFUNCARG, _T("Function does not accept a number for argument #%d!"), m_NumFuncArgs);
	    if (!Result) return (ESMSC_FUNCARG_ERROR);
	   }
			/* Special case for messagebox function */
	  else if (m_pCurrentFunc->OpCode == ESMSCR_FUNCOPCODE_MESSAGEBOX && m_ManyArgPos == 0) {
	    Result = AddMessage(ESMSCR_ERROR_BADFUNCARG, _T("MessageBox function does not accept a number variable!"));
	    if (!Result) return (ESMSC_FUNCARG_ERROR);
	   }
	  break;
    case ESMSCR_TOKEN_STRING:
	  if ((FuncFlags & ESMSCR_FUNC_ID) != 0) {
	    Result = CheckFuncID1(FuncFlags, m_Token, false);
	    if (!Result) return (ESMSC_FUNCARG_ERROR);
            OutputFuncArgStrSym();
	   }
          else if ((FuncFlags & ESMSCR_FUNC_ANIM) != 0) {
	    TCHAR TempBuffer[MWESM_ID_MAXSIZE2];
	    strnncpy(TempBuffer, m_Token, MWESM_ID_MAXSIZE2 - 1);
	    
	    short AnimID = GetAnimGroupID(UnquoteString(TempBuffer));

	    if (AnimID < 0) {
	      if (NoMessage) return (ESMSC_FUNCARG_ERROR);
	      if (IsOptional) return (ESMSC_FUNCARG_ENDTABLE);
	      Result = AddMessage(ESMSCR_ERROR_BADFUNCARG, _T("The '%s' is not a valid animation group!"), TempBuffer);
	      if (!Result) return (ESMSC_FUNCARG_ERROR);
	     }

	    OutputFuncArgAnim(AnimID);
	   }
  	  else if ((FuncFlags & ESMSCR_FUNC_STRING) == 0) {
	    if (NoMessage) return (ESMSC_FUNCARG_ERROR);
	    if (IsOptional) return (ESMSC_FUNCARG_ENDTABLE);
	    Result = AddMessage(ESMSCR_ERROR_BADFUNCARG, _T("Function does not accept a string for argument #%d!"), m_NumFuncArgs);
	    if (!Result) return (ESMSC_FUNCARG_ERROR);
	   }
          else {
	    OutputFuncArgString();
	   }

	  break;
    case ESMSCR_TOKEN_XYZ:
          if ((FuncFlags & ESMSCR_FUNC_XYZ) == 0) {
	    if (NoMessage) return (ESMSC_FUNCARG_ERROR);
	    if (IsOptional) return (ESMSC_FUNCARG_ENDTABLE);
	    Result = AddMessage(ESMSCR_ERROR_BADFUNCARG, _T("Function does not accept an X/Y/Z symbol for argument #%d!"), m_NumFuncArgs);
	    if (!Result) return (ESMSC_FUNCARG_ERROR);
	   }
	  break;
    case ESMSCR_TOKEN_SYMBOL:
	  if ((FuncFlags & ESMSCR_FUNC_EFFECT) != 0) {
	    iResult = FindESMEffectID(m_Token);

	    if (iResult < 0) {
	      if (NoMessage) return (ESMSC_FUNCARG_ERROR);
	      if (IsOptional) return (ESMSC_FUNCARG_ENDTABLE);
	      Result = AddMessage(ESMSCR_ERROR_BADFUNCARG, _T("Invalid magic effect id '%s'!"), m_Token);
	      if (!Result) return (ESMSC_FUNCARG_ERROR);
	     }
            else {
	      OutputEffect(iResult);
	      m_LastFuncArgSymbol = false;
	      m_LastSetSymbol     = true;
	     }
	   }
	  else if ((FuncFlags & ESMSCR_FUNC_ANIM) != 0) {
	    short AnimID = GetAnimGroupID(m_Token);

	    if (AnimID < 0) {
	      if (NoMessage) return (ESMSC_FUNCARG_ERROR);
	      if (IsOptional) return (ESMSC_FUNCARG_ENDTABLE);
	      Result = AddMessage(ESMSCR_ERROR_BADFUNCARG, _T("The symbol '%s' is not a valid animation group!"), m_Token);
	      if (!Result) return (ESMSC_FUNCARG_ERROR);
	     }

	    OutputFuncArgAnim(AnimID);
	   }
          else if ((FuncFlags & ESMSCR_FUNC_RESET) != 0) {
	    if (m_Token.CompareNoCase("reset") == 0) {
	      OutputFuncArgReset();
            }
	    else {
	      Result = AddMessage(ESMSCR_ERROR_BADFUNCARG, _T("The '%s' is not a valid reset parameter!"), m_Token);
	      if (!Result) return (ESMSC_FUNCARG_ERROR);
	    }
	  }
          else if ((FuncFlags & ESMSCR_FUNC_ID) == 0) {
	    if (NoMessage) return (ESMSC_FUNCARG_ERROR);
	    if (IsOptional) return (ESMSC_FUNCARG_ENDTABLE);
	    Result = AddMessage(ESMSCR_ERROR_BADFUNCARG, _T("Function does not accept a symbol for argument #%d!"), m_NumFuncArgs);
	    if (!Result) return (ESMSC_FUNCARG_ERROR);
	   }
          else {
	    Result = CheckFuncID1(FuncFlags, m_Token, false);
	    if (!Result) return (ESMSC_FUNCARG_ERROR);
            OutputFuncArgSym();
	   }
	  break;
    case ESMSCR_TOKEN_GLOBALVAR:
	  if ((m_pCurrentFunc->Flags & ESMSCR_FUNC_ALLOWGLOBAL) == 0) {
	    if (NoMessage) return (ESMSC_FUNCARG_ERROR);
	    if (IsOptional) return (ESMSC_FUNCARG_ENDTABLE);
	    Result = AddMessage(ESMSCR_WARNING_BADFUNCVAR, _T("Function does not accept global variables!"));
	    if (!Result) return (ESMSC_FUNCARG_ERROR);
	   }
	   /* Fall through */
    case ESMSCR_TOKEN_LOCALVAR:
          if ((FuncFlags & ESMSCR_FUNC_RESET) != 0) {
	    if (m_Token.CompareNoCase("reset") == 0) {
	      OutputFuncArgReset();
	    }
	    else {
	      Result = AddMessage(ESMSCR_WARNING_BADFUNCVAR, _T("Function does not accept variable (%s) for a reset parameter!"), m_Token);
	      if (!Result) return (ESMSC_FUNCARG_ERROR);
            }
	  }
          else if ((m_pCurrentFunc->Flags & ESMSCR_FUNC_VAR) == 0) {
	    if (NoMessage) return (ESMSC_FUNCARG_ERROR);
	    if (IsOptional) return (ESMSC_FUNCARG_ENDTABLE);
	    Result = AddMessage(ESMSCR_WARNING_BADFUNCVAR, _T("Function does not accept variable input!"));
	    if (!Result) return (ESMSC_FUNCARG_ERROR);
	   }  
          else if ((FuncFlags & ESMSCR_FUNC_NUMBER) == 0) {
	    if (NoMessage) return (ESMSC_FUNCARG_ERROR);
	    if (IsOptional) return (ESMSC_FUNCARG_ENDTABLE);
	    Result = AddMessage(ESMSCR_ERROR_BADFUNCARG, _T("Function does not accept a number for argument #%d!"), m_NumFuncArgs);
	    if (!Result) return (ESMSC_FUNCARG_ERROR);
	   } 
	  break;
    default:
          if (NoMessage) return (ESMSC_FUNCARG_ERROR);
	  if (IsOptional) return (ESMSC_FUNCARG_ENDTABLE);
          Result = AddMessage(ESMSCR_ERROR_BADFUNCARG, _T("Unknown function argument #%d '%s'(%s) found !"), m_NumFuncArgs, m_Token, GetESMTokenName(m_TokenID));
	  if (!Result) return (ESMSC_FUNCARG_ERROR);
          break;
   } /* End of switch */

  return (ESMSC_FUNCARG_OK);
 }
/*===========================================================================
 *		End of Class Method CEsmScriptCompile::CheckFuncArg()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CEsmScriptCompile Method - int ParseFuncArg1 (void);
 *
 * Improved alternate to ParseFuncArg()
 *
 *=========================================================================*/
int CEsmScriptCompile::ParseFuncArg1 (void) {
  int  Result;
  bool CheckMsgArgs = false;

  m_TokenParsed = true;

	/* Missing commas between last argument */
  if (m_LastFuncArg == m_NumFuncArgs) {
    m_NumFuncArgs++;
    Result = AddMessage(ESMSCR_WARNING_NOCOMMA, _T("Missing ',' between arguments %d and %d!"), m_NumFuncArgs-1, m_NumFuncArgs);
    if (!Result) return (ESMSCR_RESULT_ERROR);
   }
 
	/* See if the current parameter is valid */
  Result = CheckFuncArg();
  if (m_pCurrentFunc == NULL || m_FuncArgIndex >= ESMSCR_MAX_FUNCARGS) return (ESMSC_FUNCARG_ERROR);

	/* Special case for messagebox function */
  if ((m_pCurrentFunc->Var[m_FuncArgIndex] & ESMSCR_FUNC_MANY) != 0) {

    if (Result == ESMSC_FUNCARG_ERROR) {
      m_ManyArgPos++;
      m_FuncArgIndex++;

      if (m_pCurrentFunc->OpCode == ESMSCR_FUNCOPCODE_MESSAGEBOX) {
        CheckMsgArgs = true;

        if (m_ManyArgPos == 0)
          m_NumMsgArgs++;
        else if (m_ManyArgPos == 1)
	  m_NumMsgButtons++;
       }

      Result = CheckFuncArg();

      if (Result == ESMSC_FUNCARG_ERROR) {
        Result = AddMessage(ESMSCR_ERROR_BADFUNCARG, _T("Unknown or invalid function argument #%d '%s'(%s) found !"), m_NumFuncArgs, m_Token, GetESMTokenName(m_TokenID));
        return (ESMSCR_RESULT_ERROR);
       }
     }
    else if (m_pCurrentFunc->OpCode == ESMSCR_FUNCOPCODE_MESSAGEBOX) {
      CheckMsgArgs = true;

      if (m_ManyArgPos == 0) 
        m_NumMsgArgs++;
      else if (m_ManyArgPos == 1)
	m_NumMsgButtons++;
     }

	/* Check message box arguments if required */
    if (CheckMsgArgs) {

    		/* Ensure we don't exceed the maximum allowed arguments */
      if (m_ManyArgPos == 0 && m_NumMsgArgs > MWESM_SCRIPT_MAXMSGARGS) {
        Result = AddMessage(ESMSCR_ERROR_BADFUNCARG, _T("Exceeded the maximum of %d MessageBox variables!"), MWESM_SCRIPT_MAXMSGARGS);
        if (!Result) return (ESMSCR_RESULT_ERROR);
       }

		/* Ensure we don't exceed the maximum allowed buttons */
      if (m_ManyArgPos ==1 && m_NumMsgButtons > MWESM_SCRIPT_MAXMSGBUTTONS) {
        Result = AddMessage(ESMSCR_ERROR_BADFUNCARG, _T("Exceeded the maximum of %d MessageBox buttons!"), MWESM_SCRIPT_MAXMSGBUTTONS);
        if (!Result) return (ESMSCR_RESULT_ERROR);
       }
     }

    m_LastFuncArg = m_NumFuncArgs;
    return (ESMSCR_RESULT_OK);
   }
  else if (Result == ESMSC_FUNCARG_ERROR) {
    return (ESMSCR_RESULT_ERROR);
   }
  else if (Result == ESMSC_FUNCARG_ENDTABLE) {
    //return (ESMSCR_RESULT_ERROR);
    return (ESMSCR_RESULT_TABLEEND);
  }

	/* Move counters to the next function argument */
  m_LastFuncArg = m_NumFuncArgs;
  m_FuncArgIndex++;

  return (ESMSCR_RESULT_OK);
 }
/*===========================================================================
 *		End of Class Method CEsmScriptCompile::ParseFuncArg1()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CEsmScriptCompile Method - int ParseFunction (void);
 *
 *=========================================================================*/
int CEsmScriptCompile::ParseFunction (void) {
  if (m_pCurrentFunc->OpCode == 0x10C9) return ParseChoiceFunction();
  return (ESMSCR_RESULT_OK);
}
/*===========================================================================
 *		End of Class Method CEsmScriptCompile::ParseFunction()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CEsmScriptCompile Method - int ParseChoiceFunction (void);
 *
 *=========================================================================*/
int CEsmScriptCompile::ParseChoiceFunction (void) {
  int  Result;
  int  SizeOffset;
  int  OutputSize = 0;
  int  ArgCount = 0;
  bool Parsing = true;
    
  //AddScriptData("\0c9\010", 2);
  SizeOffset = m_ScriptDataSize;
  AddScriptData("\0\0", 2);

  do {
    if (m_TokenParsed) {
      Result = GetNextToken();
      if (Result != ESMSCR_RESULT_OK) return (Result);
    }

    switch (m_TokenID) {
      case ESMSCR_TOKEN_EOL:
        Parsing = false;
	m_TokenParsed = true;
	break;
      case ESMSCR_TOKEN_COMMA:
        m_TokenParsed = true;
	break;

      case ESMSCR_TOKEN_NUMBER:
      
        if (strchr(m_Token, '.') != NULL) {
	  Result = AddMessage(ESMSCR_ERROR_BADNUMBER, "Invalid float number '%s' in Choice function call!", m_Token);
	  if (Result < 0) return (Result);
	}

      case ESMSCR_TOKEN_STRING:
        m_TokenParsed = true;
        OutputSize += m_Token.GetLength();

	if (ArgCount > 0) {
	  ++OutputSize;
	  AddScriptData(" ", 1);
        }

	++ArgCount;
	AddScriptData((const char*)m_Token, m_Token.GetLength());
	break;
      default:
	Result = AddMessage(ESMSCR_ERROR_BADFUNCARG, "Invalid argument '%s' in Choice function call!", m_Token);
	if (Result < 0) return (Result);
        m_TokenParsed = true;
	break;	 
    }
    

  } while (Parsing);

  if (OutputSize > 65535) {
    AddMessage(ESMSCR_ERROR_TOOMANYARGS, "Arguments in Choice function exceed maximum length of 65535 bytes!");
    return (ESMSCR_RESULT_ERROR);
  }

	/* Update the output bytes */
  memcpy(m_ScriptData + SizeOffset, &OutputSize, 2);
  return (ESMSCR_RESULT_TABLEEND);
}
/*===========================================================================
 *		End of Class Method CEsmScriptCompile::ParseChoiceFunction()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CEsmScriptCompile Method - int ParseCheckFuncArg (void);
 *
 *=========================================================================*/
int CEsmScriptCompile::ParseCheckFuncArg (void) {
  bool    Result;
  int     ParseResult;
  __int64 FuncFlags;

  if (m_pCurrentFunc == NULL) return (ESMSCR_RESULT_OK);
  if (m_NumFuncArgs > ESMSCR_MAX_FUNCARGS || m_FuncArgIndex > ESMSCR_MAX_FUNCARGS) return (ESMSCR_RESULT_OK);

  FuncFlags = m_pCurrentFunc->Var[m_FuncArgIndex];

  if (FuncFlags == 0) {

    if (m_TokenID == ESMSCR_TOKEN_COMMA) {
      Result = AddMessage(ESMSCR_WARNING_BADFUNCARG, _T("Function does not accept argument #%d!"), m_FuncArgIndex + 1);
      if (!Result) return (ESMSCR_RESULT_ERROR);
    }

    ParseResult = ParseFuncEnd();
    if (ParseResult < 0) return (ParseResult);
    return (ESMSCR_RESULT_TABLEEND);
  }

  return (ESMSCR_RESULT_OK);
}
/*===========================================================================
 *		End of Class Method CEsmScriptCompile::ParseCheckFuncArg()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CEsmScriptCompile Method - int ParseFuncArg (void);
 *
 *=========================================================================*/
int CEsmScriptCompile::ParseFuncArg (void) {
  bool    KeepParsing;
  bool    Result;
  bool    OptError = false;
  int     iResult;
  __int64 FuncFlags;

	/* Shouldn't happen, but just in case */
  m_TokenParsed = true;
  if (m_pCurrentFunc == NULL) return (ESMSCR_RESULT_OK);

	/* Missing commas between parameters */
  if (m_LastFuncArg == m_NumFuncArgs) {
    m_NumFuncArgs++;
    Result = AddMessage(ESMSCR_WARNING_NOCOMMA, _T("Missing ',' between arguments %d and %d!"), m_NumFuncArgs-1, m_NumFuncArgs);
    if (!Result) return (ESMSCR_RESULT_ERROR);
   }

  if (m_NumFuncArgs > ESMSCR_MAX_FUNCARGS || m_FuncArgIndex > ESMSCR_MAX_FUNCARGS) {
    Result = AddMessage(ESMSCR_ERROR_MISC, _T("Exceeded the maximum of %d function arguments!"), ESMSCR_MAX_FUNCARGS);
    return (ESMSCR_RESULT_ERROR);
   }
  
	/* While loop is used to skip any optional arguments */
  while (m_FuncArgIndex < ESMSCR_MAX_FUNCARGS) {
    FuncFlags = m_pCurrentFunc->Var[m_FuncArgIndex];

    if ((FuncFlags & ESMSCR_FUNC_OPTSTART) != 0) {
      m_FuncOptPos   = m_ScriptDataSize;
      m_FuncOptCount = m_NumFuncArgs;
      AddScriptData("\0\0", 2);
     }

  	/* Check the current argument against the function info */
    if (m_NumFuncArgs > ESMSCR_MAX_FUNCARGS) {
      break;
     }
    else if ((FuncFlags & ESMSCR_FUNC_VARMASK) == 0) {
      if (!OptError) {
        Result = AddMessage(ESMSCR_WARNING_BADFUNCARG, _T("Function does not accept argument #%d!"), m_NumFuncArgs);
        if (!Result) return (ESMSCR_RESULT_ERROR);
       }
      OptError = true;
      break;
     }
    else if ((FuncFlags & ESMSCR_FUNC_OPTIONAL) != 0) {
      KeepParsing = false;

      switch (m_TokenID) {
        case ESMSCR_TOKEN_RESET:
          if ((FuncFlags & ESMSCR_FUNC_RESET)  == 0) KeepParsing = true;
	  break;
        case ESMSCR_TOKEN_NUMBER:
          if ((FuncFlags & ESMSCR_FUNC_NUMBER) == 0) KeepParsing = true;
	  break;
        case ESMSCR_TOKEN_STRING:
	  if ((FuncFlags & ESMSCR_FUNC_ID) != 0) {
	    Result = CheckFuncID1(FuncFlags, m_Token, true);
	    if (!Result) return (ESMSCR_RESULT_ERROR);
	    OutputFuncArgStrSym();
	   }
  	  else if ((FuncFlags & ESMSCR_FUNC_STRING) != 0) {
	    OutputFuncArgString();
	   }
	  else if ((FuncFlags & ESMSCR_FUNC_STRING) == 0) {
	    KeepParsing = true;
	   }
	  break;
        case ESMSCR_TOKEN_XYZ:
          if ((FuncFlags & ESMSCR_FUNC_XYZ) == 0) KeepParsing = true;
	  break;
        case ESMSCR_TOKEN_SYMBOL:
	  if ((FuncFlags & ESMSCR_FUNC_EFFECT) != 0) {
	   }
          else if ((FuncFlags & ESMSCR_FUNC_ID) == 0) 
	    KeepParsing = true;
          else {
	    Result = CheckFuncID1(FuncFlags, m_Token, true);
	    if (!Result) return (ESMSCR_RESULT_ERROR);
	    OutputFuncArgSym();
	   }
	  break;
        case ESMSCR_TOKEN_LOCALVAR:
        case ESMSCR_TOKEN_GLOBALVAR:
          if ((m_pCurrentFunc->Flags & ESMSCR_FUNC_VAR) == 0) {
	    if (!OptError) {
	      Result = AddMessage(ESMSCR_WARNING_BADFUNCVAR, _T("Function does not accept variable input!"));
	      if (!Result) return (ESMSCR_RESULT_ERROR);
	     }
	    KeepParsing = true;
	    OptError = true;
	   }  
          else if ((FuncFlags & ESMSCR_FUNC_NUMBER) == 0) {
	    KeepParsing = true;
	   } 
	  break;
        default:
	  if (!OptError) {
            Result = AddMessage(ESMSCR_ERROR_BADFUNCARG, _T("Unknown function argument #%d '%s'(%s) found !"), m_NumFuncArgs, m_Token, GetESMTokenName(m_TokenID));
	    if (!Result) return (ESMSCR_RESULT_ERROR);
	   }
	  OptError = true;
          break;
       } /* End of switch */
      
      if (!KeepParsing) break;
      m_NumFuncArgs++;
      if ((FuncFlags & ESMSCR_FUNC_MANY) == 0) m_FuncArgIndex++;
     }
    else { 
      switch (m_TokenID) {
        case ESMSCR_TOKEN_RESET:
          if ((FuncFlags & ESMSCR_FUNC_RESET) == 0) {
	    Result = AddMessage(ESMSCR_ERROR_BADFUNCARG, _T("Function does not accept 'reset' for argument #%d!"), m_NumFuncArgs);
	    if (!Result) return (ESMSCR_RESULT_ERROR);
	   }
	  break;
        case ESMSCR_TOKEN_NUMBER:
	  if ((FuncFlags & ESMSCR_FUNC_EFFECT) != 0) {
	    iResult = atoi(m_Token);

	    if (iResult < 0 || iResult >= MWESM_EFFECT_MAX) {
	      Result = AddMessage(ESMSCR_ERROR_BADFUNCARG, _T("Invalid magic effect id '%s'!"), m_Token);
	      if (!Result) return (ESMSCR_RESULT_ERROR);
	     }
            else {
	      OutputEffect(iResult);
	      m_LastFuncArgSymbol = false;
	      m_LastSetSymbol     = false;
	     }
	   }
          else if ((FuncFlags & ESMSCR_FUNC_NUMBER) == 0) {
	    Result = AddMessage(ESMSCR_ERROR_BADFUNCARG, _T("Function does not accept a number for argument #%d!"), m_NumFuncArgs);
	    if (!Result) return (ESMSCR_RESULT_ERROR);
	   }
	  break;
        case ESMSCR_TOKEN_STRING:
	  if ((FuncFlags & ESMSCR_FUNC_ID) != 0) {
	    Result = CheckFuncID1(FuncFlags, m_Token, false);
	    if (!Result) return (ESMSCR_RESULT_ERROR);
            OutputFuncArgStrSym();
	   }
  	  else if ((FuncFlags & ESMSCR_FUNC_STRING) == 0) {
	    Result = AddMessage(ESMSCR_ERROR_BADFUNCARG, _T("Function does not accept a string for argument #%d!"), m_NumFuncArgs);
	    if (!Result) return (ESMSCR_RESULT_ERROR);
	   }
          else {
	    OutputFuncArgString();
	   }

	  break;
        case ESMSCR_TOKEN_XYZ:
          if ((FuncFlags & ESMSCR_FUNC_XYZ) == 0) {
	    Result = AddMessage(ESMSCR_ERROR_BADFUNCARG, _T("Function does not accept an X/Y/Z symbol for argument #%d!"), m_NumFuncArgs);
	    if (!Result) return (ESMSCR_RESULT_ERROR);
	   }
	  break;
        case ESMSCR_TOKEN_SYMBOL:
	  if ((FuncFlags & ESMSCR_FUNC_EFFECT) != 0) {
	    iResult = FindESMEffectID(m_Token);

	    if (iResult < 0) {
	      Result = AddMessage(ESMSCR_ERROR_BADFUNCARG, _T("Invalid magic effect id '%s'!"), m_Token);
	      if (!Result) return (ESMSCR_RESULT_ERROR);
	     }
            else {
	      OutputEffect(iResult);
	      m_LastFuncArgSymbol = false;
	      m_LastSetSymbol     = true;
	     }
	   }
	  else if ((FuncFlags & ESMSCR_FUNC_ANIM) != 0) {
	    short AnimID = GetAnimGroupID(m_Token);

	    if (AnimID < 0) {
	      Result = AddMessage(ESMSCR_ERROR_BADFUNCARG, _T("The '%s' is not a valid animation group!"), m_Token);
	      return (ESMSCR_RESULT_ERROR);
	     }

	    OutputFuncArgAnim(AnimID);
	   }
          else if ((FuncFlags & ESMSCR_FUNC_ID) == 0) {
	    Result = AddMessage(ESMSCR_ERROR_BADFUNCARG, _T("Function does not accept a symbol for argument #%d!"), m_NumFuncArgs);
	    if (!Result) return (ESMSCR_RESULT_ERROR);
	   }
          else {
	    Result = CheckFuncID1(FuncFlags, m_Token, false);
	    if (!Result) return (ESMSCR_RESULT_ERROR);
            OutputFuncArgSym();
	   }
	  break;
        case ESMSCR_TOKEN_GLOBALVAR:
	  if ((m_pCurrentFunc->Flags & ESMSCR_FUNC_ALLOWGLOBAL) == 0) {
	    Result = AddMessage(ESMSCR_WARNING_BADFUNCVAR, _T("Function does not accept global variables!"));
	    if (!Result) return (ESMSCR_RESULT_ERROR);
	   }
	   /* Fall through */
        case ESMSCR_TOKEN_LOCALVAR:
          if ((m_pCurrentFunc->Flags & ESMSCR_FUNC_VAR) == 0) {
	    Result = AddMessage(ESMSCR_WARNING_BADFUNCVAR, _T("Function does not accept variable input!"));
	    if (!Result) return (ESMSCR_RESULT_ERROR);
	   }  
          else if ((FuncFlags & ESMSCR_FUNC_NUMBER) == 0) {
	    Result = AddMessage(ESMSCR_ERROR_BADFUNCARG, _T("Function does not accept a number for argument #%d!"), m_NumFuncArgs);
	    if (!Result) return (ESMSCR_RESULT_ERROR);
	   } 
	  break;
        default:
          Result = AddMessage(ESMSCR_ERROR_BADFUNCARG, _T("Unknown function argument #%d '%s'(%s) found !"), m_NumFuncArgs, m_Token, GetESMTokenName(m_TokenID));
	  if (!Result) return (ESMSCR_RESULT_ERROR);
          break;
       } /* End of switch */
      break;
     } /* End of else */

   } /* End of while */
  
  m_LastFuncArg = m_NumFuncArgs;
  return (ESMSCR_RESULT_OK);  
 }
/*===========================================================================
 *		End of Class Method CEsmScriptCompile::ParseFuncArg()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CEsmScriptCompile Method - int ParseFuncComma (void);
 *
 *=========================================================================*/
int CEsmScriptCompile::ParseFuncComma (void) {
  bool Result;

	/* Check for an optional function argument */
  if (m_LastFuncArg != m_NumFuncArgs) {
    if (m_FuncArgIndex < ESMSCR_MAX_FUNCARGS && (m_pCurrentFunc->Var[m_FuncArgIndex] & ESMSCR_FUNC_OPTIONAL) == 0) {
      Result = AddMessage(ESMSCR_WARNING_BADFUNCARG, _T("Function argument #%d is not optional!"), m_FuncArgIndex+1);  
      if (!Result) return (ESMSCR_RESULT_ERROR);
     }

    if (m_FuncArgIndex < ESMSCR_MAX_FUNCARGS && (m_pCurrentFunc->Var[m_FuncArgIndex] & ESMSCR_FUNC_MANY) == 0) {
      m_FuncArgIndex++;
     }

    m_LastFuncArg++;
   }

  m_NumFuncArgs++;
  return (ESMSCR_RESULT_OK);
 }
/*===========================================================================
 *		End of Class Method CEsmScriptCompile::ParseFuncComma()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CEsmScriptCompile Method - int ParseFuncEnd (void);
 *
 *=========================================================================*/
int CEsmScriptCompile::ParseFuncEnd (void) {
  int Index;
  bool Result;

  if (m_pCurrentFunc == NULL) return (ESMSCR_RESULT_OK); 
  if (m_NumFuncArgs == 0) m_NumFuncArgs = 1;

	/* Check for a bad function */
  if ((m_pCurrentFunc->Flags & ESMSCR_FUNC_BAD) != 0) {
    Result = AddMessage(ESMSCR_WARNING_BADFUNCTION,  _T("The function '%s' is known to not work in Morrowind!"), m_pCurrentFunc->Name);

    if (!Result) {
      m_pCurrentFunc = NULL;
      return (ESMSCR_RESULT_ERROR);
    }
   }

	/* Check for a function only valid in dialogue */
  if ((m_pCurrentFunc->Flags & ESMSCR_FUNC_DIALOGUE) != 0) {
    Result = AddMessage(ESMSCR_WARNING_DIALOGFUNC,  _T("The function '%s' only works in dialogue results!"), m_pCurrentFunc->Name);

    if (!Result) {
      m_pCurrentFunc = NULL;
      return (ESMSCR_RESULT_ERROR);
    }
   }

	/* Check for missing parameters */
  for (Index = m_FuncArgIndex; Index < ESMSCR_MAX_FUNCARGS; Index++) {
    if ((m_pCurrentFunc->Var[Index] & ESMSCR_FUNC_VARMASK) == 0) break;
    
    if ((m_pCurrentFunc->Var[Index] & ESMSCR_FUNC_OPTIONAL) == 0 && (m_pCurrentFunc->Var[Index] & ESMSCR_FUNC_NOTREQ) == 0) {
      Result = AddMessage(ESMSCR_ERROR_BADFUNCARG, _T("Missing required argument(s) for function call!"));

      if (!Result) {
        m_pCurrentFunc = NULL;
        return (ESMSCR_RESULT_ERROR);
      }

      m_LastFuncArgSymbol = false;
      //m_LastSetSymbol     = false;
      break;
     }
    else if ((m_pCurrentFunc->Var[Index] & ESMSCR_FUNC_RESET) != 0) {

		/* Special case for AiWander */
      if (m_pCurrentFunc->OpCode == 0x10F9 && m_FuncArgIndex > 3)
        AddScriptData("\1", 1);
      else
        AddScriptData("\0", 1);

      m_LastFuncArgSymbol = false;
      //m_LastSetSymbol     = false;
     }
    else if ((m_pCurrentFunc->Var[Index] & ESMSCR_FUNC_BYTE) != 0) {
      AddScriptData("\0", 1);
      m_LastFuncArgSymbol = false;
      //m_LastSetSymbol     = false;
     }
    else if ((m_pCurrentFunc->Var[Index] & ESMSCR_FUNC_ID) != 0) {
      if ((m_pCurrentFunc->Flags & ESMSCR_FUNC_NOOPTOUT) == 0) AddScriptData("\0", 1);
      m_LastFuncArgSymbol = false;
      //m_LastSetSymbol     = false;
     }
    else {
      m_LastFuncArgSymbol = false;
      //m_LastSetSymbol     = false;
     }

    if ((m_pCurrentFunc->Var[Index] & ESMSCR_FUNC_OPTSTART) != 0) {
      AddScriptData("\0\0", 2);
     }
   }

  if (m_FuncOptCount > 0 && m_FuncOptPos > 0) {
    short Count = m_NumFuncArgs - m_FuncOptCount;
    *(short *)(m_ScriptData+m_FuncOptPos) = Count;
   }
  
  OutputFuncEnd();

  m_pCurrentFunc = NULL;
  return (ESMSCR_RESULT_OK);
 }
/*===========================================================================
 *		End of Class Method CEsmScriptCompile::ParseFuncEnd()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CEsmScriptCompile Method - int ParseNewLocalVar (void);
 *
 * Attempts to add a new local var.  Returns ESMSCR_RESULT_OK on success.
 * Current token should be the type operator.
 *
 *=========================================================================*/
int CEsmScriptCompile::ParseNewLocalVar (void) {
  int NewType;
  int Result;

	/* Determine the new type */
  if (m_Token.CompareNoCase(_T("short")) == 0)
    NewType = ESMSCR_VAR_SHORT;
  else if (m_Token.CompareNoCase(_T("long")) == 0)
    NewType = ESMSCR_VAR_LONG;
  else if (m_Token.CompareNoCase(_T("float")) == 0)
    NewType = ESMSCR_VAR_FLOAT;
  else {
    AddMessage(ESMSCR_ERROR_BADTOKEN, _T("Unknown type operator '%s'!"), m_Token);
    return (ESMSCR_RESULT_ERROR);
   }
	
	/* Get the new symbol */
  Result = GetNextToken();
  if (Result != ESMSCR_RESULT_OK) return (Result);

	/* Assert the correct type */
  switch (m_TokenID) {
    case ESMSCR_TOKEN_SYMBOL:

			/* Removed as it serves no purpose */
	//if (IsSymbolID(m_Token)) {
	  //Result = AddMessage(ESMSCR_WARNING_IDCONFLICT, _T("Local variable '%s' conflicts an object ID."), m_Token);
	  //if (!Result) return (ESMSCR_RESULT_ERROR);
	 ///}
	break;
    case ESMSCR_TOKEN_GLOBALVAR:
	Result = AddMessage(ESMSCR_WARNING_IDCONFLICT, _T("Local variable '%s' conflicts with a global variable."), m_Token);
	if (!Result) return (ESMSCR_RESULT_ERROR);
	break;
    case ESMSCR_TOKEN_LOCALVAR:
	AddMessage(ESMSCR_ERROR_BADLOCAL, _T("Local variable '%s' has already been defined!"), m_Token);
	return (ESMSCR_RESULT_ERROR);
    default:
	AddMessage(ESMSCR_ERROR_BADLOCAL, _T("Invalid local variable name '%s'!"), m_Token);
	return (ESMSCR_RESULT_ERROR);
   };


  		/* Check for special warning conditions */
  if (m_Token[0] == '_') {
    Result = AddMessage(ESMSCR_WARNING_BADVARSTART, _T("Local/Global variables should not start with an '_' (%s)."), m_Token);
    if (!Result) return (ESMSCR_RESULT_ERROR);
   }

	/* Attempt to create a new local */
  Result = AddLocalVar(m_Token, NewType);
  if (!Result) return (ESMSCR_RESULT_ERROR);

	/* Ensure we end the line correctly */
  Result = GetNextToken();
  if (Result != ESMSCR_RESULT_OK) return (Result);
  Result = AssertToken(ESMSCR_TOKEN_EOL);
  if (Result != ESMSCR_RESULT_OK) return (Result);

  m_TokenParsed = true;
  m_StatementCount++;
  return (ESMSCR_RESULT_OK);
 }
/*===========================================================================
 *		End of Class Method CEsmScriptCompile::ParseNewLocalVar()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CEsmScriptCompile Method - int ParsePushToken (void);
 *
 *=========================================================================*/
int CEsmScriptCompile::ParsePushToken (void) {
  DEFINE_FUNCTION("CEsmScriptCompile::ParsePushToken()");
  esmscrstack_t* pNewStack = (esmscrstack_t *) m_ExprStack.Peek();
  int		 TopTokenID = ESMSCR_TOKEN_UNKNOWN;
  bool		 PushToken = false;

  if (pNewStack != NULL) TopTokenID = pNewStack->TokenID;
  m_NumSetExpr++;

  if (m_LastSetNegative && m_TokenID != ESMSCR_TOKEN_NUMBER) AddScriptData(" -1", 3);

	/* Determine action by the current token type */
  switch (m_TokenID) {
    case ESMSCR_TOKEN_OPENBRAC:	
        PushToken = true;

	if (m_LastSetNegative) {
	  m_LastSetNegative = false;
	  CreatePointer(pNewStack, esmscrstack_t);
          pNewStack->TokenID = ESMSCR_TOKEN_MULOP;
          strnncpy(pNewStack->Token, "*", ESMSCR_STACK_MAXTOKENSIZE);
          m_ExprStack.Push(pNewStack);
	  m_LastSetSymbol = false;
	}

	break;
    case ESMSCR_TOKEN_CLOSEBRAC:
        pNewStack = (esmscrstack_t *) m_ExprStack.Pop();

	while (pNewStack != NULL) {
	  if (pNewStack->TokenID == ESMSCR_TOKEN_OPENBRAC) break;
	  AddScriptData(" ", 1);
          AddScriptData(pNewStack->Token, strlen(pNewStack->Token));
	  DestroyPointer(pNewStack);
	  pNewStack = (esmscrstack_t *) m_ExprStack.Pop();
	 }

        DestroyPointer(pNewStack); 
	break;
    case ESMSCR_TOKEN_ADDOP:
        m_LastSetSymbol = false;
	m_IsEmptyIf     = false;

        if (TopTokenID == ESMSCR_TOKEN_ADDOP || TopTokenID == ESMSCR_TOKEN_MULOP) {
	  	  
	  while (pNewStack != NULL && (pNewStack->TokenID == ESMSCR_TOKEN_ADDOP || pNewStack->TokenID == ESMSCR_TOKEN_MULOP)) {
	    AddScriptData(" ", 1);
            AddScriptData(pNewStack->Token, strlen(pNewStack->Token));

	    m_ExprStack.Pop();
	    DestroyPointer(pNewStack);
 	    pNewStack = (esmscrstack_t *) m_ExprStack.Peek();
	   }

	  PushToken = true;
	 }
	else {
	  PushToken = true;
	 }
	break;
    case ESMSCR_TOKEN_MULOP:
        m_LastSetSymbol = false;
	m_IsEmptyIf     = false;

        if (TopTokenID == ESMSCR_TOKEN_MULOP) {
	  //AddScriptData(" ", 1);
	  //AddScriptData(m_Token, m_Token.GetLength());

	  while (pNewStack != NULL && pNewStack->TokenID == ESMSCR_TOKEN_MULOP) {
	    AddScriptData(" ", 1);
            AddScriptData(pNewStack->Token, strlen(pNewStack->Token));

	    m_ExprStack.Pop();
	    DestroyPointer(pNewStack);
 	    pNewStack = (esmscrstack_t *) m_ExprStack.Peek();
	   }

          PushToken = true;
	 }
	else {
	  PushToken = true;
	 }
	break;
    case ESMSCR_TOKEN_NUMBER:
        AddScriptData(" ", 1);

        if (m_LastSetNegative) {
	  AddScriptData("-", 1);
	  m_LastSetNegative = false;
	}
               
        AddScriptData(m_Token, m_Token.GetLength());

	m_LastSetSymbol = false;
	m_IsEmptyIf     = false;
  	break;
    case ESMSCR_TOKEN_LOCALVAR: {
	char  LocalType;
	short LocalIndex;
	LocalIndex = FindLocalVarIndex(m_Token, LocalType);

	AddScriptData(" ", 1);
	AddScriptData(&LocalType, 1);
	AddScriptData(&LocalIndex, 2);
	break;
     }
    case ESMSCR_TOKEN_GLOBALVAR: {
        char GlobalSize;
	AddScriptData(" G", 2);
	GlobalSize = (char) m_Token.GetLength();

		/* Ensure a minimum size of 4 bytes are output */
	if (GlobalSize < 4) {
	  GlobalSize = 4;
	  AddScriptData(&GlobalSize, 1);
	  AddScriptData(m_Token, (int)m_Token.GetLength());
	  AddScriptData("\0\0\0\0\0", 4 - m_Token.GetLength());
	 }
        else {
	  AddScriptData(&GlobalSize, 1);
	  AddScriptData(m_Token, GlobalSize);
	 }

	break;
     }
    case ESMSCR_TOKEN_FUNCTION:
        AddScriptData(" X", 2);
	ASSERT(m_pCurrentFunc != NULL);
	AddScriptData(&(m_pCurrentFunc->OpCode), 2);
	m_LastFuncArgSymbol = false;

	if (m_LastSetNegative) {
	  m_LastSetNegative = false;
	  CreatePointer(pNewStack, esmscrstack_t);
          pNewStack->TokenID = ESMSCR_TOKEN_MULOP;
          strnncpy(pNewStack->Token, "*", ESMSCR_STACK_MAXTOKENSIZE);
          m_ExprStack.Push(pNewStack);
	  m_LastSetSymbol = false;
	}

	//m_LastSetSymbol     = true;
	break;
    default:
        AddScriptData(" ", 1);
        AddScriptData(m_Token, m_Token.GetLength());
	//m_LastSetSymbol = false;
	break;
   }

  if (m_LastSetNegative) {
    m_LastSetNegative = false;
    AddScriptData(" *", 2);
    m_LastSetSymbol = false;
  }

  if (PushToken) {
    CreatePointer(pNewStack, esmscrstack_t);
    pNewStack->TokenID = m_TokenID;
    strnncpy(pNewStack->Token, m_Token, ESMSCR_STACK_MAXTOKENSIZE);
    m_ExprStack.Push(pNewStack);
   }

  //AddScriptData(" ", 1);
  //AddScriptData(m_Token, m_Token.GetLength());

  m_TokenParsed = true;
  return (ESMSCR_RESULT_OK);
 }
/*===========================================================================
 *		End of Class Method CEsmScriptCompile::ParsePushToken()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CEsmScriptCompile Method - int ParseIfRExprStart (void);
 *
 *=========================================================================*/
int CEsmScriptCompile::ParseIfRExprStart (void) {
  m_LastSetSymbol = true;
  m_LastSetPos = m_ScriptDataSize - 1;

  ParseRExprStart();

  return (ESMSCR_RESULT_OK);
}
/*===========================================================================
 *		End of Class Method CEsmScriptCompile::ParseIfRExprStart()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CEsmScriptCompile Method - int ParseRExprStart (void);
 *
 *=========================================================================*/
int CEsmScriptCompile::ParseRExprStart (void) {
  ClearExprStack();
  
  m_NumOutputExpr = 0;
  return (ESMSCR_RESULT_OK);
 }
/*===========================================================================
 *		End of Class Method CEsmScriptCompile::ParseRExprStart()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CEsmScriptCompile Method - int ParseStringID (void);
 *
 *=========================================================================*/
int CEsmScriptCompile::ParseStringID (void) {
  CSString TempToken(((const TCHAR *)m_Token)+1, m_Token.GetLength()-2);
  bool	   Result;

	/* Ensure the string is a valid ID */
  Result = IsSymbolID(TempToken);
  m_TokenParsed = true;

  if (!Result) {
    Result = AddMessage(ESMSCR_ERROR_BADID, _T("Unknown object ID %s found!"), m_Token);
    if (!Result) return (ESMSCR_RESULT_ERROR);
   }
	
  return (ESMSCR_RESULT_OK);
 }


int CEsmScriptCompile::ParseStringIDSet (void) {
  CSString    TempToken(((const TCHAR *)m_Token)+1, m_Token.GetLength()-2);
  CEsmGlobal* pGlobal;

	/* Check for a global variable first */
  pGlobal = GetGlobal(TempToken);

  if (pGlobal != NULL) {
    m_Token   = TempToken;
    m_TokenID = ESMSCR_TOKEN_GLOBALVAR;
    OutputSetGlobal();
    return (ESMSCR_RESULT_TABLEEND);
  }

  return ParseStringID();
}


int CEsmScriptCompile::ParseStringIDIf (void) {
  CSString    TempToken(((const TCHAR *)m_Token)+1, m_Token.GetLength()-2);
  CEsmGlobal* pGlobal;

	/* Check for a global variable first */
  pGlobal = GetGlobal(TempToken);

  if (pGlobal != NULL) {
    m_Token   = TempToken;
    m_TokenID = ESMSCR_TOKEN_GLOBALVAR;
    OutputIfGlobal();
    return (ESMSCR_RESULT_TABLEEND);
  }

  return ParseStringID();
}

int CEsmScriptCompile::ParseStringIDPush (void) {
  CSString    TempToken(((const TCHAR *)m_Token)+1, m_Token.GetLength()-2);
  CEsmGlobal* pGlobal;

	/* Check for a global variable first */
  pGlobal = GetGlobal(TempToken);

  if (pGlobal != NULL) {
    m_Token   = TempToken;
    m_TokenID = ESMSCR_TOKEN_GLOBALVAR;
    ParsePushToken();
    return (ESMSCR_RESULT_TABLEEND);
  }

  return ParseStringID();
}
/*===========================================================================
 *		End of Class Method CEsmScriptCompile::ParseStringID()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CEsmScriptCompile Method - int ParsePushStringID (void);
 *
 *=========================================================================*/
int CEsmScriptCompile::ParsePushStringID (void) {
  int Result;
  
  Result = ParseStringID();
  if (Result < ESMSCR_RESULT_OK) return (Result);

  AddScriptData(" ", 1);

  return (Result);
 }
/*===========================================================================
 *		End of Class Method CEsmScriptCompile::ParsePushStringID()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CEsmScriptCompile Method - int ParseSymbolID (void);
 *
 *=========================================================================*/
int CEsmScriptCompile::ParseSymbolID (void) {
  bool Result;

  	/* Ensure the token is a valid ID */
  Result = IsSymbolID(m_Token);
  
  if (!Result) {
    Result = AddMessage(ESMSCR_ERROR_BADID, _T("Unknown object ID '%s' found!"), m_Token);
    if (!Result) return (ESMSCR_RESULT_ERROR);
   }
	
  m_TokenParsed = true;
  return (ESMSCR_RESULT_OK);
 }
/*===========================================================================
 *		End of Class Method ParseSymbolID::ParseSymbolID()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CEsmScriptCompile Method - int ParsePushSymbolID (void);
 *
 *=========================================================================*/
int CEsmScriptCompile::ParsePushSymbolID (void) {
  int Result;
  
  Result = ParseSymbolID();
  if (Result < ESMSCR_RESULT_OK) return (Result);

  AddScriptData(" ", 1);

  return (Result);
 }
/*===========================================================================
 *		End of Class Method ParseSymbolID::ParsePushSymbolID()
 *=========================================================================*/



/*===========================================================================
 *
 * Class CEsmScriptCompile Method - int ParseTable (pTable);
 *
 * Description
 *	{ ESMSCR_TOKEN_EOL,	ESTF_MANY,	NULL,		NULL },
	{ ESMSCR_TOKEN_BEGIN,	ESTF_ONE,	NULL,		NULL },
	{ ESMSCR_BEGINBLOCK,	ESTF_ONE,	l_ScriptBlock,	NULL },
 *
 *=========================================================================*/
int CEsmScriptCompile::ParseTable (esmscrparsetable_t* pTable) {
  int Index;
  int Result;

	/* Parse the entire table */
  for (Index = 0; pTable[Index].TokenID != ESMSCR_ENDTABLE; Index++) {

		/* Parse (0 to N) of the given simple token */
    if ((pTable[Index].Flags & ESTF_MANY) != 0) {
      Result = ParseTableMany(pTable[Index]);
      if (Result != ESMSCR_RESULT_OK) return (Result);
     }
		/* Parse exactly 1 of the given simple token */
    else if ((pTable[Index].Flags & ESTF_ONE) != 0) {
      Result = ParseTableOne(pTable[Index]);
      if (Result == ESMSCR_RESULT_TABLEEND) return (ESMSCR_RESULT_OK);
      if (Result == ESMSCR_RESULT_BLOCKEND) return (ESMSCR_RESULT_OK);
      if (Result != ESMSCR_RESULT_OK) return (Result);
     }

   }

	/* Output special end data if required */
  if (pTable[Index].OutputFunc != NULL) {
    (this->*pTable[Index].OutputFunc)();
   }

	/* End of special table */
  if ((pTable[Index].Flags & ESTF_STOP) != 0) {

    if (pTable[Index].ParseFunc != NULL) {
      Result = (this->*(pTable[Index].ParseFunc))();
      if (Result != ESMSCR_RESULT_OK) return (Result);
     }

    if ((pTable[Index].Flags & ESTF_OPT) != 0) return (ESMSCR_RESULT_BLOCKEND);
    AddMessage(ESMSCR_ERROR_BADTOKEN, "Unknown token '%s'(%s) found!", m_Token, GetESMTokenName(m_TokenID));
    return (ESMSCR_RESULT_ERROR);
   }
   
  return (ESMSCR_RESULT_OK);
 }
/*===========================================================================
 *		End of Class Method CEsmScriptCompile::ParseTable()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CEsmScriptCompile Method - int ParseTableMany (TableEntry);
 *
 * Description
 *
 *=========================================================================*/
int CEsmScriptCompile::ParseTableMany (esmscrparsetable_t& TableEntry) {
  int Result = ESMSCR_RESULT_OK;

	/* Keep parsing tokens until we stop finding the given type */
  while (Result == ESMSCR_RESULT_OK) {
    Result = ParseTableOne(TableEntry);
  /*
    if (m_TokenParsed) {
      Result = GetNextToken();
      if (Result != ESMSCR_RESULT_OK) return (Result);
     }

    if (TableEntry.TokenID == ESMSCR_BEGINBLOCK) {
      if (TableEntry.ParseFunc != NULL) Result = (this->*TableEntry.ParseFunc)();
      if (TableEntry.pParseTable != NULL && Result == ESMSCR_RESULT_OK) Result = ParseTable(TableEntry.pParseTable);
      if (Result != ESMSCR_RESULT_OK) break;
     }
    else if (m_TokenID == TableEntry.TokenID) {
      m_TokenParsed = true;
      if (TableEntry.ParseFunc   != NULL) Result = (this->*TableEntry.ParseFunc)();
      if (TableEntry.pParseTable != NULL && Result == ESMSCR_RESULT_OK) Result = ParseTable(TableEntry.pParseTable);
      if (Result != ESMSCR_RESULT_OK) break;
     }
    else {
      return (ESMSCR_RESULT_OK);
     }
    */
   }

  if (Result == ESMSCR_RESULT_BLOCKEND) return (ESMSCR_RESULT_OK);
  return (Result);
 }
/*===========================================================================
 *		End of Class Method CEsmScriptCompile::ParseTableMany()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CEsmScriptCompile Method - int ParseTableOne (TableEntry);
 *
 * Description
 *
 *=========================================================================*/
int CEsmScriptCompile::ParseTableOne (esmscrparsetable_t& TableEntry) {
  int Result = ESMSCR_RESULT_OK;
  bool Output = true;

       	/* Parse out the next token from the script if required  */
  if (m_TokenParsed) {
    Result = GetNextToken();
    if (Result != ESMSCR_RESULT_OK) return (Result);
   }

	/* Chain to another table or parse function if required */
  if (TableEntry.TokenID == ESMSCR_BEGINBLOCK) {
    if (TableEntry.ParseFunc   != NULL) Result = (this->*TableEntry.ParseFunc)();
    if (TableEntry.pParseTable != NULL && Result == ESMSCR_RESULT_OK) Result = ParseTable(TableEntry.pParseTable);
    if (Result == ESMSCR_RESULT_OK       && (TableEntry.Flags & ESTF_STOP) != 0) Result = ESMSCR_RESULT_TABLEEND;
    if (Result == ESMSCR_RESULT_TABLEEND && (TableEntry.Flags & ESTF_STOP) != 0) Result = ESMSCR_RESULT_TABLEEND;
   }
  else if (TableEntry.TokenID == m_TokenID) {
    m_TokenParsed = true;

    if (TableEntry.OutputFunc != NULL) {
      (this->*TableEntry.OutputFunc)();
     }

    if (TableEntry.ParseFunc   != NULL) Result = (this->*TableEntry.ParseFunc)();
    if (TableEntry.pParseTable != NULL && Result == ESMSCR_RESULT_OK) Result = ParseTable(TableEntry.pParseTable);
    if (Result == ESMSCR_RESULT_OK       && (TableEntry.Flags & ESTF_STOP) != 0) Result = ESMSCR_RESULT_TABLEEND;
    if (Result == ESMSCR_RESULT_TABLEEND && (TableEntry.Flags & ESTF_STOP) != 0) Result = ESMSCR_RESULT_TABLEEND;
    Output = false;
   }
  else if ((TableEntry.Flags & ESTF_MANY) != 0) {
    Result = ESMSCR_RESULT_BLOCKEND;
   }
	/* No token match, but it's optional */
  else if ((TableEntry.Flags & ESTF_OPT) != 0) {
    if (m_TokenID != TableEntry.TokenID) Output = false;
    Result = ESMSCR_RESULT_OK;
   }
  	/* No token match, record error */
  else {
    Result = AssertToken(TableEntry.TokenID);
    if (Result == ESMSCR_RESULT_OK) Output = false;
   }

	/* Call the output function if present */
  if (Output && Result == ESMSCR_RESULT_OK && TableEntry.OutputFunc != NULL) {
    (this->*TableEntry.OutputFunc)();
   }

  return (Result);
 }
/*===========================================================================
 *		End of Class Method CEsmScriptCompile::ParseTableOne()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CEsmScriptCompile Method - int ParseFuncRef (void);
 *
 *=========================================================================*/
int CEsmScriptCompile::ParseFuncRef (void) {
  m_TokenParsed = true;
  return ParseTable(l_LeftFuncBlock);
 }
/*===========================================================================
 *		End of Class Method CEsmScriptCompile::ParseFuncRef()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CEsmScriptCompile Method - int ParseVarRef1 (InIf);
 *
 *=========================================================================*/
int CEsmScriptCompile::ParseVarRef1 (const bool InIf) {
  CEsmRecord*   pRecord;
  int		Result;
  CEsmScript*   pScript;
  CEsmSubNameFix* pSubScript;
  CSString      m_VarToken = m_LastToken;
  int		ArrayIndex;
  short		VarIndex;
  char		VarType;
  byte		StrLength;

	/* Remove optional quotes from the last token */
  if (m_VarToken[0] == '"') {
    m_VarToken.Copy(((const TCHAR *)m_LastToken) + 1, m_LastToken.GetLength() - 2);
   }

	/* Get the next token after the '.' operator */  
  Result = GetNextToken();
  if (Result != ESMSCR_RESULT_OK) return (Result);

	/* Ensure a valid token type */
  switch (m_TokenID) {
    case ESMSCR_TOKEN_SYMBOL:
    case ESMSCR_TOKEN_LOCALVAR:
    case ESMSCR_TOKEN_GLOBALVAR:
    case ESMSCR_TOKEN_FUNCTION:
	break;
    default:
	AddMessage(ESMSCR_ERROR_BADTOKEN, _T("Expecting an object variable name but found '%s'!"), GetESMTokenName(m_TokenID));
	return (ESMSCR_RESULT_ERROR);
   }

	/* Get the object reference for the variable */
  pRecord = FindRecord(m_VarToken);

  if (pRecord == NULL) {
    AddMessage(ESMSCR_ERROR_BADID, _T("Unknown object id '%s' found!"), m_VarToken);
    return (ESMSCR_RESULT_ERROR);
   }

  if (InIf) {
    if (m_LastSetNegative) AddScriptData(" -1", 3);
    AddScriptData(" ", 1);
  }

	/* Is the record a script or another object */
  if (!pRecord->IsType(MWESM_REC_SCPT)) {

  		/* Attempt to retrieve the object's script */
    pSubScript = (CEsmSubNameFix *) pRecord->FindFirst(MWESM_SUBREC_SCRI, ArrayIndex);

    if (pSubScript == NULL) {
      AddMessage(ESMSCR_ERROR_BADID, _T("Object '%s' has no script assigned!"), m_VarToken);
      return (ESMSCR_RESULT_ERROR);
     }

    pRecord = FindRecord(pSubScript->GetName());

    if (pRecord == NULL) {
      AddMessage(ESMSCR_ERROR_BADID, _T("Invalid script name '%s' found!"), pSubScript->GetName());
      return (ESMSCR_RESULT_ERROR);
     }

    AddScriptData("r", 1);
   }
  else {
    AddScriptData("m", 1);
   }

	/* Output the script/object name */
  StrLength = (byte) m_VarToken.GetLength();
 
  if (m_VarToken[0] == '"') {
    StrLength -= 2;
    AddScriptData(&StrLength, 1);
    AddScriptData(((const TCHAR *)m_VarToken) + 1, StrLength);
   }
  else {
    AddScriptData(&StrLength, 1);
    AddScriptData(m_VarToken, StrLength);
   }
  
	/* Attempt to find the local variable */
  pScript = (CEsmScript *) pRecord;
  VarIndex = pScript->FindLocalVar(m_Token, VarType);

  if (VarIndex <= 0) {
    AddMessage(ESMSCR_ERROR_BADID, _T("Object '%s' has no local variable '%s'!"), m_VarToken, m_Token);
    return (ESMSCR_RESULT_ERROR);
   }

	/* Output the local var reference */
/*  if (m_IsSetExpr) {
    AddScriptData(&VarType, 1);
    AddScriptData(&VarIndex, 2);
    AddScriptData("\0", 1);
    m_LastSetPos = m_ScriptDataSize - 1;
   } 
  else { /* If/while expression */ /*
    AddScriptData(" ", 1);
    AddScriptData(&VarType, 1);
    AddScriptData(&VarIndex, 2);
   } //*/

  AddScriptData(&VarType, 1);
  AddScriptData(&VarIndex, 2);

	/* Only supported in set statements */
  if (InIf) {
    if (m_LastSetNegative) {
      AddScriptData(" *", 2);
      m_LastSetNegative = false;
    }

    //m_LastIfPos = m_ScriptDataSize - 1;
    m_LastSetPos = m_ScriptDataSize - 1;
  }
  else {
    AddScriptData("\0", 1);
    m_LastSetPos = m_ScriptDataSize - 1;
  }

  m_TokenParsed = true;
  return (ESMSCR_RESULT_OK);
 }

int CEsmScriptCompile::ParseVarRef   (void) { return ParseVarRef1(false); }
int CEsmScriptCompile::ParseIfVarRef (void) { return ParseVarRef1(true); }
/*===========================================================================
 *		End of Class Method CEsmScriptCompile::ParseVarRef1()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CEsmScriptCompile Method - void SetScriptText (pString, Size);
 *
 * Sets the script text to be compiled.
 *
 *=========================================================================*/
void CEsmScriptCompile::SetScriptText (const TCHAR* pString, const int Size) {
  DEFINE_FUNCTION("CEsmScriptCompile::SetScriptText()");

	/* Delete the current text, if any */
  DestroyArrayPointer(m_pScriptText);

	/* Create and copy the script text */
  CreateArrayPointer(m_pScriptText, TCHAR, Size+64);
  memcpy(m_pScriptText, pString, Size*sizeof(TCHAR));

	/* Ensure it is NULL terminated */
  m_pScriptText[Size] = NULL_CHAR;
  m_pParse         = m_pScriptText;
  m_CurrentLine    = 0;
  m_CurrentCharPos = 0;
  m_TokenParsed    = true;
  m_LineHasRef	   = false;
 }
/*===========================================================================
 *		End of Class Method CEsmScriptCompile::SetScriptText()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CEsmScriptCompile Method - void SkipTokenComment (void);
 *
 * Skips a script comment starting at the initial ';' character and
 * stopping at the first CR.
 *
 *=========================================================================*/
void CEsmScriptCompile::SkipTokenComment (void) {

   do {
    m_CurrentCharPos++;
    m_pParse++;
   } while (*m_pParse != ESMSCR_CHAR_EOL && *m_pParse != NULL_CHAR);

 }
/*===========================================================================
 *		End of Class Method CEsmScriptCompile::SkipTokenComment()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CEsmScriptCompile Method - void SkipTokenWhiteSpace (void);
 *
 * Skips any whitespace starting at the current parsing position.  Upon
 * return the current position will be at the first non-white space character.
 * 
 *	WhiteSpace == ' ' '\r' '\t'  
 *
 * Assumes that the current parse character is on a whitespace character.
 *
 *=========================================================================*/
void CEsmScriptCompile::SkipTokenWhiteSpace (void) {

   do {
    m_CurrentCharPos++;
    m_pParse++;
   } while (IsParseWhiteSpace());

 }
/*===========================================================================
 *		End of Class Method CEsmScriptCompile::SkipTokenWhiteSpace()
 *=========================================================================*/


/*===========================================================================
 *
 * Begin Default Message Level Initialization Methods
 *
 *=========================================================================*/
void CEsmScriptCompile::SetDefaultMsgLevels (void) {
  m_MsgLevels[0].MessageID = ESMSCR_ERROR_BADID;
  m_MsgLevels[0].Level	= ESMSCR_MSGLEVEL_ERROR;
  m_MsgLevels[1].MessageID = ESMSCR_WARNING_NOCOMMA;
  m_MsgLevels[1].Level	= ESMSCR_MSGLEVEL_NONE;
  m_MsgLevels[2].MessageID = ESMSCR_WARNING_BADFUNCARG;
  m_MsgLevels[2].Level	= ESMSCR_MSGLEVEL_WARNING;
  m_MsgLevels[3].MessageID = ESMSCR_WARNING_BADFUNCVAR;
  m_MsgLevels[3].Level	= ESMSCR_MSGLEVEL_WARNING;
  m_MsgLevels[3].MessageID = ESMSCR_WARNING_BADFUNCVAR;
  m_MsgLevels[3].Level	= ESMSCR_MSGLEVEL_WARNING;
  m_MsgLevels[4].MessageID = ESMSCR_ERROR_BADLOCAL;
  m_MsgLevels[4].Level	= ESMSCR_MSGLEVEL_ERROR;
  m_MsgLevels[5].MessageID = ESMSCR_ERROR_BADTOKEN;
  m_MsgLevels[5].Level	= ESMSCR_MSGLEVEL_ERROR;
  m_MsgLevels[6].MessageID = ESMSCR_ERROR_BADNUMBER;
  m_MsgLevels[6].Level	= ESMSCR_MSGLEVEL_ERROR;
  m_MsgLevels[7].MessageID = ESMSCR_ERROR_MULTREF;
  m_MsgLevels[7].Level	= ESMSCR_MSGLEVEL_ERROR;
  m_MsgLevels[8].MessageID = ESMSCR_WARNING_NOSPACE;
  m_MsgLevels[8].Level	= ESMSCR_MSGLEVEL_NONE;
  m_MsgLevels[9].MessageID = ESMSCR_WARNING_IDCONFLICT;
  m_MsgLevels[9].Level	= ESMSCR_MSGLEVEL_WARNING;
  m_MsgLevels[10].MessageID = ESMSCR_WARNING_BADVARSTART;
  m_MsgLevels[10].Level	= ESMSCR_MSGLEVEL_NONE;
  m_MsgLevels[11].MessageID = ESMSCR_WARNING_BADFUNCTION;
  m_MsgLevels[11].Level	= ESMSCR_MSGLEVEL_WARNING;
  m_MsgLevels[12].MessageID = ESMSCR_ERROR_BADFUNCARG;
  m_MsgLevels[12].Level	= ESMSCR_MSGLEVEL_ERROR;
  m_MsgLevels[13].MessageID = ESMSCR_WARNING_EXTFUNC;
  m_MsgLevels[13].Level	= ESMSCR_MSGLEVEL_WARNING;
  m_MsgLevels[14].MessageID = ESMSCR_ERROR_TOOMANYARGS;
  m_MsgLevels[14].Level	= ESMSCR_MSGLEVEL_ERROR;
  m_MsgLevels[15].MessageID = ESMSCR_WARNING_EXPANSIONFUNC;
  m_MsgLevels[15].Level	= ESMSCR_MSGLEVEL_ERROR;
  m_MsgLevels[16].MessageID = ESMSCR_WARNING_LOCALVAR34;
  m_MsgLevels[16].Level	= ESMSCR_MSGLEVEL_WARNING;  
  m_MsgLevels[17].MessageID = ESMSCR_WARNING_DIALOGFUNC;
  m_MsgLevels[17].Level	= ESMSCR_MSGLEVEL_NONE;  
      
  m_NumMsgLevels = 18;
 }


void CEsmScriptCompile::SetWeakMsgLevels (void) {
  m_MsgLevels[0].MessageID = ESMSCR_ERROR_BADID;
  m_MsgLevels[0].Level	= ESMSCR_MSGLEVEL_WARNING;
  m_MsgLevels[1].MessageID = ESMSCR_WARNING_NOCOMMA;
  m_MsgLevels[1].Level	= ESMSCR_MSGLEVEL_NONE;
  m_MsgLevels[2].MessageID = ESMSCR_WARNING_BADFUNCARG;
  m_MsgLevels[2].Level	= ESMSCR_MSGLEVEL_NONE;
  m_MsgLevels[3].MessageID = ESMSCR_WARNING_BADFUNCVAR;
  m_MsgLevels[3].Level	= ESMSCR_MSGLEVEL_NONE;
  m_MsgLevels[4].MessageID = ESMSCR_ERROR_BADLOCAL;
  m_MsgLevels[4].Level	= ESMSCR_MSGLEVEL_ERROR;
  m_MsgLevels[5].MessageID = ESMSCR_ERROR_BADTOKEN;
  m_MsgLevels[5].Level	= ESMSCR_MSGLEVEL_ERROR;
  m_MsgLevels[6].MessageID = ESMSCR_ERROR_BADNUMBER;
  m_MsgLevels[6].Level	= ESMSCR_MSGLEVEL_WARNING;
  m_MsgLevels[7].MessageID = ESMSCR_ERROR_MULTREF;
  m_MsgLevels[7].Level	= ESMSCR_MSGLEVEL_WARNING;
  m_MsgLevels[8].MessageID = ESMSCR_WARNING_NOSPACE;
  m_MsgLevels[8].Level	= ESMSCR_MSGLEVEL_NONE;
  m_MsgLevels[9].MessageID = ESMSCR_WARNING_IDCONFLICT;
  m_MsgLevels[9].Level	= ESMSCR_MSGLEVEL_NONE;
  m_MsgLevels[10].MessageID = ESMSCR_WARNING_BADVARSTART;
  m_MsgLevels[10].Level	= ESMSCR_MSGLEVEL_NONE;
  m_MsgLevels[11].MessageID = ESMSCR_WARNING_BADFUNCTION;
  m_MsgLevels[11].Level	= ESMSCR_MSGLEVEL_NONE;
  m_MsgLevels[12].MessageID = ESMSCR_ERROR_BADFUNCARG;
  m_MsgLevels[12].Level	= ESMSCR_MSGLEVEL_WARNING;
  m_MsgLevels[13].MessageID = ESMSCR_WARNING_EXTFUNC;
  m_MsgLevels[13].Level	= ESMSCR_MSGLEVEL_WARNING;
  m_MsgLevels[14].MessageID = ESMSCR_ERROR_TOOMANYARGS;
  m_MsgLevels[14].Level	= ESMSCR_MSGLEVEL_ERROR;
  m_MsgLevels[15].MessageID = ESMSCR_WARNING_EXPANSIONFUNC;
  m_MsgLevels[15].Level	= ESMSCR_MSGLEVEL_WARNING;
  m_MsgLevels[16].MessageID = ESMSCR_WARNING_LOCALVAR34;
  m_MsgLevels[16].Level	= ESMSCR_MSGLEVEL_NONE;
  m_MsgLevels[17].MessageID = ESMSCR_WARNING_DIALOGFUNC;
  m_MsgLevels[17].Level	= ESMSCR_MSGLEVEL_NONE;  

  m_NumMsgLevels = 18;
 }


void CEsmScriptCompile::SetStrongMsgLevels (void) {
  m_MsgLevels[0].MessageID = ESMSCR_ERROR_BADID;
  m_MsgLevels[0].Level	= ESMSCR_MSGLEVEL_ERROR;
  m_MsgLevels[1].MessageID = ESMSCR_WARNING_NOCOMMA;
  m_MsgLevels[1].Level	= ESMSCR_MSGLEVEL_NONE;
  m_MsgLevels[2].MessageID = ESMSCR_WARNING_BADFUNCARG;
  m_MsgLevels[2].Level	= ESMSCR_MSGLEVEL_WARNING;
  m_MsgLevels[3].MessageID = ESMSCR_WARNING_BADFUNCVAR;
  m_MsgLevels[3].Level	= ESMSCR_MSGLEVEL_WARNING;
  m_MsgLevels[4].MessageID = ESMSCR_ERROR_BADLOCAL;
  m_MsgLevels[4].Level	= ESMSCR_MSGLEVEL_ERROR;
  m_MsgLevels[5].MessageID = ESMSCR_ERROR_BADTOKEN;
  m_MsgLevels[5].Level	= ESMSCR_MSGLEVEL_ERROR;
  m_MsgLevels[6].MessageID = ESMSCR_ERROR_BADNUMBER;
  m_MsgLevels[6].Level	= ESMSCR_MSGLEVEL_ERROR;
  m_MsgLevels[7].MessageID = ESMSCR_ERROR_MULTREF;
  m_MsgLevels[7].Level	= ESMSCR_MSGLEVEL_ERROR;
  m_MsgLevels[8].MessageID = ESMSCR_WARNING_NOSPACE;
  m_MsgLevels[8].Level	= ESMSCR_MSGLEVEL_WARNING;
  m_MsgLevels[9].MessageID = ESMSCR_WARNING_IDCONFLICT;
  m_MsgLevels[9].Level	= ESMSCR_MSGLEVEL_WARNING;
  m_MsgLevels[10].MessageID = ESMSCR_WARNING_BADVARSTART;
  m_MsgLevels[10].Level	= ESMSCR_MSGLEVEL_WARNING;
  m_MsgLevels[11].MessageID = ESMSCR_WARNING_BADFUNCTION;
  m_MsgLevels[11].Level	= ESMSCR_MSGLEVEL_ERROR;
  m_MsgLevels[12].MessageID = ESMSCR_ERROR_BADFUNCARG;
  m_MsgLevels[12].Level	= ESMSCR_MSGLEVEL_ERROR;
  m_MsgLevels[13].MessageID = ESMSCR_WARNING_EXTFUNC;
  m_MsgLevels[13].Level	= ESMSCR_MSGLEVEL_ERROR;
  m_MsgLevels[14].MessageID = ESMSCR_ERROR_TOOMANYARGS;
  m_MsgLevels[14].Level	= ESMSCR_MSGLEVEL_ERROR;
  m_MsgLevels[15].MessageID = ESMSCR_WARNING_EXPANSIONFUNC;
  m_MsgLevels[15].Level	= ESMSCR_MSGLEVEL_ERROR;
  m_MsgLevels[16].MessageID = ESMSCR_WARNING_LOCALVAR34;
  m_MsgLevels[16].Level	= ESMSCR_MSGLEVEL_WARNING;
  m_MsgLevels[17].MessageID = ESMSCR_WARNING_DIALOGFUNC;
  m_MsgLevels[17].Level	= ESMSCR_MSGLEVEL_WARNING;  

  m_NumMsgLevels = 18;
 }
/*===========================================================================
 *		End of Default Message Level Initialization Methods
 *=========================================================================*/


/*===========================================================================
 *
 * Class CEsmScriptCompile Method - int OutputOneExpr (void);
 *
 *=========================================================================*/
int CEsmScriptCompile::OutputOneExpr (void) {
  DEFINE_FUNCTION("CEsmScriptCompile::OutputOneExpr()");
  esmscrstack_t* pStack1;
  esmscrstack_t* pStack2;
  bool		 DoExtra = false;

  return (0);
  
  pStack1 = (esmscrstack_t *) m_ExprStack.Pop();
  if (pStack1 == NULL) return (0);

  if (pStack1->TokenID != ESMSCR_TOKEN_ADDOP && pStack1->TokenID != ESMSCR_TOKEN_MULOP) {
    /*
    Length = strlen(pStack1->Token);
    memcpy(m_ScriptData + m_ScriptDataSize, " ", 1);
    memcpy(m_ScriptData + m_ScriptDataSize + 1, pStack1->Token, Length);
    m_ScriptDataSize += 1 + Length; //*/

    SystemLog.Printf ("\t\tExp:'%s'", pStack1->Token);
    DestroyPointer(pStack1);

    pStack1 = (esmscrstack_t *) m_ExprStack.Pop();
    if (pStack1 == NULL) return (0);
   }
  
  pStack2 = (esmscrstack_t *) m_ExprStack.Pop();
 
  if (pStack2 != NULL) SystemLog.Printf ("\t\tExp:'%s'", pStack2->Token);
  SystemLog.Printf ("\t\tExp:'%s'", pStack1->Token);
  SystemLog.Printf ("\t");
  
  /*
  Length = strlen(pStack2->Token);
  memcpy(m_ScriptData + m_ScriptDataSize, " ", 1);
  memcpy(m_ScriptData + m_ScriptDataSize + 1, pStack2->Token, Length);
  m_ScriptDataSize += 1 + Length;

  Length = strlen(pStack1->Token);
  memcpy(m_ScriptData + m_ScriptDataSize, " ", 1);
  memcpy(m_ScriptData + m_ScriptDataSize + 1, pStack1->Token, Length);
  m_ScriptDataSize += 1 + Length; //*/

  DestroyPointer(pStack2);
  DestroyPointer(pStack1);

  m_NumOutputExpr++;
  return (0);
 }
/*===========================================================================
 *		End of Class Method CEsmScriptCompile::OutputOneExpr()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CEsmScriptCompile Method - int OutputIf (void);
 *
 *=========================================================================*/
int CEsmScriptCompile::OutputIf (void) { 
  //DEFINE_FUNCTION("CEsmScriptCompile::OutputIf()");
  int LinePos = m_ScriptDataSize;
  
	/* Output the initial if token */
  OutputToken(0x0106);
  m_StatementCount++;

	/* Output the intial exmpty statement count and expression length */
  OutputToken(0x0000);

	/* Initialize the required if related variables */
  m_LastIfPos = m_ScriptDataSize - 1;
  m_IsEmptyIf = true;
  m_OutputFuncIDRef = true;
  m_LastLineDataPos = LinePos;
  m_LastSetNegative = false;
  m_LastFuncArgSymbol = false;
  m_LastSetSymbol     = false;

  return (0);
 }
/*===========================================================================
 *		End of Class Method CEsmScriptCompile::OutputIf()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CEsmScriptCompile Method - int OutputIfGlobal (void);
 *
 *=========================================================================*/
int CEsmScriptCompile::OutputIfGlobal (void) {
  byte GlobalSize;

  AddScriptData(" G", 2);
  GlobalSize = m_Token.GetLength();

  	/* Ensure a minimum size of 4 bytes are output */
  if (GlobalSize < 4) {
    GlobalSize = 4;
    AddScriptData(&GlobalSize, 1);
    AddScriptData(m_Token, (int)m_Token.GetLength());
    AddScriptData("\0\0\0\0\0", 4 - m_Token.GetLength());
   }
  else {
    AddScriptData(&GlobalSize, 1);
    AddScriptData(m_Token, GlobalSize);
   }

  return (0);
 }
/*===========================================================================
 *		End of Class Method CEsmScriptCompile::OutputIfGlobal()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CEsmScriptCompile Method - int OutputIfLocal (void);
 *
 *=========================================================================*/
int CEsmScriptCompile::OutputIfLocal (void) {
  int  LocalIndex;
  char LocalType;

  LocalIndex = FindLocalVarIndex(m_Token, LocalType);

  OutputToken(0x20 + (LocalType << 8));
  OutputToken(LocalIndex);

  return (0);
 }
/*===========================================================================
 *		End of Class Method CEsmScriptCompile::OutputIfLocal()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CEsmScriptCompile Method - int OutputIfRelOp (void);
 *
 *=========================================================================*/
int CEsmScriptCompile::OutputIfRelOp (void) {
  char Buffer[16];
  int  Length;
  bool Result;

  //Length = snprintf (Buffer, 15, _T(" %s "), m_Token);
  Length = snprintf (Buffer, 15, _T(" %s"), m_Token);

  if (Length > 0) {
    Result = AddScriptData(Buffer, Length);
    if (!Result) return (-1);
   }

  m_IsEmptyIf = false;
  return (0);
 }
/*===========================================================================
 *		End of Class Method CEsmScriptCompile::OutputIfRelOp()
 *=========================================================================*/


/*===========================================================================
 *
 * Begin Output Right If Blocks
 *
 *=========================================================================*/
int CEsmScriptCompile::OutputIfRAddOp (void) {
  bool Result;

  Result = AddScriptData(m_Token, m_Token.GetLength());
  if (!Result) return (-1);

  return (0);
 }

int CEsmScriptCompile::OutputIfRNumber (void) {
  bool Result;

  Result = AddScriptData(m_Token, m_Token.GetLength());
  if (!Result) return (-1);
  return (0);
 }

int CEsmScriptCompile::OutputIfRLocal (void) {
  int  LocalIndex;
  char LocalType;

  //Result = AddScriptData(m_Token, m_Token.GetLength());
  //if (!Result) return (-1);
  
  LocalIndex = FindLocalVarIndex(m_Token, LocalType);
  AddScriptData(&LocalType, 1);
  OutputToken(LocalIndex);
  LocalType = 0;
  AddScriptData("\0", 1);

  return (0);
 }
 
int CEsmScriptCompile::OutputIfRGlobal (void) {
  char GlobalSize = m_Token.GetLength();

  //Result = AddScriptData(m_Token, m_Token.GetLength());
  //if (!Result) return (-1);

  AddScriptData("G", 1);

  		/* Ensure a minimum size of 4 bytes are output */
  if (GlobalSize < 4) {
    GlobalSize = 4;
    AddScriptData(&GlobalSize, 1);
    AddScriptData(m_Token, (int)m_Token.GetLength());
    AddScriptData("\0\0\0\0\0", 4 - m_Token.GetLength());
   }
  else {
    AddScriptData(&GlobalSize, 1);
    AddScriptData(m_Token, GlobalSize);
   }

  AddScriptData("\0", 1);
  return (0);
 }

int CEsmScriptCompile::OutputIfEmpty (void) {
  bool Result;

  Result = AddScriptData("\0", 1);
  if (!Result) return (-1);

  return (0);
 }
/*===========================================================================
 *		End of Output Right If Blocks
 *=========================================================================*/


/*===========================================================================
 *
 * Class CEsmScriptCompile Method - int OutputIfFinish (void);
 *
 *=========================================================================*/
int CEsmScriptCompile::OutputIfFinish (void) {
  int Size;
  if (m_LastIfPos < 0) return (-1);

  Size = m_ScriptDataSize - m_LastIfPos - 1;

	/* Ensure a valid IF expression size */
  if (Size > MWESM_SCRIPT_MAXIFEXPRESSIONS) {
    AddError(_T("Compiled IF expression length exceeds %d bytes!"), MWESM_SCRIPT_MAXIFEXPRESSIONS);
    return (-1);
   }
  else if (m_IsEmptyIf) {
    AddScriptData("\0", 1);
    Size++;
   }
	/* Set the IF expression size */
  m_ScriptData[m_LastIfPos] = (byte) Size;

  	/* Add an if block to the if statement stack */
  AddIfBlock(m_StatementCount, m_LastIfPos - 1);
  
	/* Reset variables */
  m_LastIfPos = -1;
  m_OutputFuncIDRef = false;
  return (0);
 }
/*===========================================================================
 *		End of Class Method CEsmScriptCompile::OutputIfFinish()
 *=========================================================================*/


/*===========================================================================
 *
 * Begin Output Set Blocks
 *
 *=========================================================================*/
int CEsmScriptCompile::OutputSet (void) {
  int LinePos;
  int Result;

  LinePos             = m_ScriptDataSize;
  m_NumSetExpr        = 0;
  m_LastSetSymbol     = true;
  m_LastFuncArgSymbol = false;
  m_OutputFuncIDRef   = true;
  m_LastSetNegative   = false;

  Result = OutputToken(0x0105);

  m_LastLineDataPos = LinePos;
  m_StatementCount++;
  return (Result);
 }


int CEsmScriptCompile::OutputSetLocal (void) {
  int  LocalIndex;
  char LocalType;

  LocalIndex = FindLocalVarIndex(m_Token, LocalType);
  AddScriptData(&LocalType, 1);
  OutputToken(LocalIndex);
  LocalType = 0;
  AddScriptData(&LocalType, 1);
  m_LastSetPos = m_ScriptDataSize - 1;
  //m_LastSetSymbol = true;

  return (0);
 }

int CEsmScriptCompile::OutputSetGlobal (void) {
  char GlobalSize = m_Token.GetLength();
  
  AddScriptData("G", 1);

	/* Ensure the minimum output size is 4 bytes */
  if (GlobalSize < 4) {
    GlobalSize = 4;
    AddScriptData(&GlobalSize, 1);
    AddScriptData(m_Token, (int) m_Token.GetLength());
    AddScriptData("\0\0\0\0\0", 4 - m_Token.GetLength());
   }
  else {
    AddScriptData(&GlobalSize, 1);
    AddScriptData(m_Token, (int) GlobalSize);
   }

	/* Extra padding null character? */
  AddScriptData("\0", 1);

  m_LastSetPos = m_ScriptDataSize - 1;
  //m_LastSetSymbol = true;
  return (0);
 }

int CEsmScriptCompile::OutputSetEnd (void) {
  int Size;

  if (m_LastSetPos < 0) return (-1);
  Size = m_ScriptDataSize - m_LastSetPos - 1;

  if (Size > 255) {
    AddError(_T("Compiled SET expression length exceeds 255 bytes!"));
    return (ESMSCR_RESULT_ERROR);
   }
  
  if (m_LastSetSymbol && !m_LastFuncArgSymbol) {
    AddScriptData("\0", 1);
    Size++;
    //m_LastLineDataPos++;
   }

  m_ScriptData[m_LastSetPos] = (byte)Size;
  m_OutputFuncIDRef = false;
  return (0);
 }
/*===========================================================================
 *		End of Output Set Blocks
 *=========================================================================*/


/*===========================================================================
 *
 * Class CEsmScriptCompile Method - int ParseFuncAddOp (void);
 *
 *=========================================================================*/
int CEsmScriptCompile::ParseFuncAddOp (void) {
  m_LastTokenNegative = false;
  if (m_Token == "-") m_LastTokenNegative = true;
  return (0);
 }
/*===========================================================================
 *		End of Class Method CEsmScriptCompile::ParseFuncAddOp()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CEsmScriptCompile Method - int ParseSetFirstAddOp (void);
 *
 *=========================================================================*/
int CEsmScriptCompile::ParseSetFirstAddOp (void) {

  m_LastSetNegative = false;
  if (m_Token == "-") m_LastSetNegative = true;

  return (0);
 }
/*===========================================================================
 *		End of Class Method CEsmScriptCompile::ParseSetFirstAddOp()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CEsmScriptCompile Method - int OutputElseIf (void);
 *
 *=========================================================================*/
int CEsmScriptCompile::OutputElseIf (void) {
  DEFINE_FUNCTION("CEsmScriptCompile::OutputElseIf()");
  int Result;
  int LinePos = m_ScriptDataSize;
  
	/* Update the previous IF/ELSEIF block statement count */
  Result = UpdateLastIfBlock();
  if (Result == ESMSCR_RESULT_ERROR) return (ESMSCR_RESULT_ERROR);

  	/* Output the initial if token */
  OutputToken(0x0108);
  m_StatementCount++;

	/* Output the intial exmpty statement count and expression length */
  OutputToken(0x0000);

	/* Initialize the required if related variables */
  m_LastIfPos = m_ScriptDataSize - 1;
  m_IsEmptyIf = true;
  m_OutputFuncIDRef = true;
  m_LastLineDataPos = LinePos;

  return (0);
 }
/*===========================================================================
 *		End of Class Method CEsmScriptCompile::OutputElseIf()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CEsmScriptCompile Method - int OutputElse (void);
 *
 *=========================================================================*/
int CEsmScriptCompile::OutputElse (void) { 
  DEFINE_FUNCTION("CEsmScriptCompile::OutputElse()");
  int Result;
  int LinePos = m_ScriptDataSize;
  
	/* Update the previous IF/ELSEIF block statement count */
  Result = UpdateLastIfBlock();
  if (Result == ESMSCR_RESULT_ERROR) return (ESMSCR_RESULT_ERROR);

  	/* Output the initial if token */
  OutputToken(0x0107);
  m_StatementCount++;

	/* Add an if block to the if statement stack */
  AddIfBlock(m_StatementCount, m_ScriptDataSize);

	/* Output the intial empty statement count */
  AddScriptData(_T("\00"), 1);

	/* Initialize the required if related variables */
  m_LastLineDataPos = LinePos;

  return (0);
 }
/*===========================================================================
 *		End of Class Method CEsmScriptCompile::OutputElse()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CEsmScriptCompile Method - int OutputEndIf (void);
 *
 *=========================================================================*/
int CEsmScriptCompile::OutputEndIf (void) { 
  int Result;
  
  	/* Update the previous IF/ELSEIF/ELSE block statement count */
  Result = UpdateLastIfBlock();
  if (Result == ESMSCR_RESULT_ERROR) return (ESMSCR_RESULT_ERROR);

  m_StatementCount++; 
  return OutputToken(0x0109); 
 }
/*===========================================================================
 *		End of Class Method CEsmScriptCompile::OutputEndIf()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CEsmScriptCompile Method - int OutputIfLeftExprStack (void);
 *
 *=========================================================================*/
int CEsmScriptCompile::OutputIfLeftExprStack (void) {
  return OutputExprStack();
}
/*===========================================================================
 *		End of Class Method CEsmScriptCompile::OutputIfLeftExprStack()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CEsmScriptCompile Method - int OutputIfRightExprStack (void);
 *
 *=========================================================================*/
int CEsmScriptCompile::OutputIfRightExprStack (void) {
  DEFINE_FUNCTION("CEsmScriptCompile::OutputIfExprStack()");
  int Result;
  int Size;
  
  Result = OutputExprStack();
   
  if (m_LastSetPos >= 0) {
    Size = m_ScriptDataSize - m_LastSetPos - 1;

    if (Size > 255) {
      AddError(_T("Compiled IF expression length exceeds 255 bytes!"));
      return (ESMSCR_RESULT_ERROR);
     }
  }
  
  if (m_LastSetSymbol && !m_LastFuncArgSymbol) {
    AddScriptData("\0", 1);
  }

  return (Result);
}
/*===========================================================================
 *		End of Class Method CEsmScriptCompile::OutputIfRightExprStack()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CEsmScriptCompile Method - int OutputExprStack (void);
 *
 *=========================================================================*/
int CEsmScriptCompile::OutputExprStack (void) {
  DEFINE_FUNCTION("CEsmScriptCompile::OutputExprStack()");
  esmscrstack_t* pNewStack;
  bool		 Done = false;

  pNewStack = (esmscrstack_t *) m_ExprStack.Pop();

  while (pNewStack != NULL && !Done) {

    if (pNewStack->TokenID != ESMSCR_TOKEN_OPENBRAC && pNewStack->TokenID != ESMSCR_TOKEN_CLOSEBRAC) {
      AddScriptData(" ", 1);
      AddScriptData(pNewStack->Token, strlen(pNewStack->Token));
     }
    else {
      Done = true;
     }

    DestroyPointer(pNewStack);
    if (!Done) pNewStack = (esmscrstack_t *) m_ExprStack.Pop();
   }

  return (0);
 }
/*===========================================================================
 *		End of Class Method CEsmScriptCompile::OutputExprStack()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CEsmScriptCompile Method - int OutputFunction (void);
 *
 *=========================================================================*/
int CEsmScriptCompile::OutputIfFunction (void) {
  //DEFINE_FUNCTION("CEsmScriptCompile::OutputIfFunction()");

  AddScriptData(" ", 1);
  AddScriptData("X", 1);
  return OutputFunction();
 }


int CEsmScriptCompile::OutputLineFunction (void) {
  //DEFINE_FUNCTION("CEsmScriptCompile::OutputLineFunction()");
  m_StatementCount++;
  return OutputFunction();
 }


int CEsmScriptCompile::OutputFunction (void) {
  DEFINE_FUNCTION("CEsmScriptCompile::OutputFunction()");

  ASSERT(m_pCurrentFunc != NULL);

#ifdef MWEDIT_SCRIPT_MWSE
  OutputStoredFuncOp();
#endif

  AddScriptData(&(m_pCurrentFunc->OpCode), 2);

  m_LastMsgBoxArgs = -1;
  m_LastMsgBoxBut  = -1;
  m_NumMsgArgs     = 0;
  m_NumMsgButtons  = 0;
  m_FuncOptCount   = 0;
  m_LastFuncArgSymbol = false;
  return (0);
 }
/*===========================================================================
 *		End of Class Method CEsmScriptCompile::OutputFunction()
 *=========================================================================*/


/*===========================================================================
 *
 * Begin Output Function Arguments
 *
 *=========================================================================*/
int CEsmScriptCompile::OutputFuncArgReset (void) {

/*  if (m_pCurrentFunc == NULL || (m_pCurrentFunc->Var[m_NumFuncArgs-1] & ESMSCR_FUNC_RESET1) == 0) 
    AddScriptData("\5", 1);
  else //*/
    AddScriptData("\5", 1);

  return (0);
 }

int CEsmScriptCompile::OutputFuncArgXYZ (void) {
  char Byte = toupper(m_Token[0]);
  AddScriptData(&Byte, 1);
  return (0);
 }

int CEsmScriptCompile::OutputFuncArgNum (void) {
  float   fValue = (float) atof(m_Token);
  long    lValue = (long)  atol(m_Token);
  short   sValue = (short) atoi(m_Token);
  char    bValue = (char)  sValue;
  __int64 FuncArgFlag;

  if (m_LastTokenNegative) {
    fValue = -fValue;
    lValue = -lValue;
    sValue = -sValue;
    bValue = -bValue;
    m_LastTokenNegative = false;
   }

  if (m_NumFuncArgs <= 0) {
    m_NumFuncArgs = 1;
    m_LastFuncArg = 0;
   }

  FuncArgFlag = m_pCurrentFunc->Var[m_FuncArgIndex];

  if (m_pCurrentFunc == NULL) {
    AddScriptData(&fValue, 4);
   }
  else if ((FuncArgFlag & ESMSCR_FUNC_NOOUTPUT) != 0) {
    ++m_FuncOptCount; /* Reduce the optional argument count which is output by one */
  }
  else if ((FuncArgFlag & ESMSCR_FUNC_FLOAT) != 0) {
    AddScriptData(&fValue, 4);
   }
  else if ((FuncArgFlag & ESMSCR_FUNC_LONG) != 0) {
    AddScriptData(&lValue, 4);
   }
  else if ((FuncArgFlag & ESMSCR_FUNC_SHORT) != 0) {
    AddScriptData(&sValue, 2);
   }
  else if ((FuncArgFlag & ESMSCR_FUNC_RESET) != 0) {
    AddScriptData("\1", 1);
   }
  else if ((FuncArgFlag & ESMSCR_FUNC_BYTE) != 0) {
    AddScriptData(&bValue, 1);
   }
  
	/* Check for the message box function */
  //if (m_pCurrentFunc->OpCode == 0x1000) m_NumMsgArgs++;
  m_LastFuncArgSymbol = false;
  return (0);
 }

int CEsmScriptCompile::OutputFuncArgGlobal (void) {
  char GlobalSize = m_Token.GetLength();

  if (m_FuncArgIndex >= 0 && m_FuncArgIndex < MWESM_SCRIPT_MAXARGS) {
    if ((m_pCurrentFunc->Var[m_FuncArgIndex] & ESMSCR_FUNC_RESET) != 0) return (0);
  }

  if ((m_pCurrentFunc->Flags & ESMSCR_FUNC_SHORTVAR) == 0) AddScriptData(" ", 1);
  AddScriptData("G", 1);

	/* Ensure at least 4 bytes are output */
  if (GlobalSize < 4) {
    GlobalSize = 4;
    AddScriptData(&GlobalSize, 1);
    AddScriptData(m_Token, (int)m_Token.GetLength());
    AddScriptData("\0\0\0\0\0", 4 - m_Token.GetLength());
   }
  else {
    AddScriptData(&GlobalSize, 1);
    AddScriptData(m_Token, (int)GlobalSize);
   }

  m_LastFuncArgSymbol = true;

  if (m_pCurrentFunc->OpCode != ESMSCR_FUNCOPCODE_MESSAGEBOX) {
    AddScriptData("\0", 1);	/* Only at end??? */
  }

  //if (m_pCurrentFunc->OpCode == 0x1000) m_NumMsgArgs++;
  return (0);
 }

int CEsmScriptCompile::OutputFuncArgLocal (void) { 
  short   FuncIndex;
  char    FuncType;
  
  if (m_FuncArgIndex >= 0 && m_FuncArgIndex < MWESM_SCRIPT_MAXARGS) {
    if ((m_pCurrentFunc->Var[m_FuncArgIndex] & ESMSCR_FUNC_RESET) != 0) return (0);
  }

  FuncIndex = FindLocalVarIndex(m_Token, FuncType);
  if ((m_pCurrentFunc->Flags & ESMSCR_FUNC_SHORTVAR) == 0) AddScriptData(" ", 1);
  AddScriptData(&FuncType, 1);
  AddScriptData(&FuncIndex, 2);
  m_LastFuncArgSymbol = true;

  if (m_pCurrentFunc->OpCode != ESMSCR_FUNCOPCODE_MESSAGEBOX) {
    AddScriptData("\0", 1);	/* Only at end??? */
  }

  //if (m_pCurrentFunc->OpCode == 0x1000) m_NumMsgArgs++;
  return (0);
 }

int CEsmScriptCompile::OutputFuncArgStrSym (void) {
  char StringLen = m_Token.GetLength() - 2;

  if (m_OutputFuncIDRef) AddScriptData(GetFuncArgRefType(m_pCurrentFunc->Var[m_FuncArgIndex]), 2);
  AddScriptData(&StringLen, 1);
  AddScriptData(((const TCHAR *)m_Token) + 1, (int)StringLen);
  m_LastFuncArgSymbol = false;
  return (0);
 }

int CEsmScriptCompile::OutputFuncArgSym (void) {
  char StringLen = m_Token.GetLength();

  if (m_OutputFuncIDRef) AddScriptData(GetFuncArgRefType(m_pCurrentFunc->Var[m_FuncArgIndex]), 2);
  AddScriptData(&StringLen, 1);
  AddScriptData(m_Token, (int)StringLen);
  m_LastFuncArgSymbol = false;
  return (0);
 }

int CEsmScriptCompile::OutputFuncArgString (void) {
  short StringLen = m_Token.GetLength() - 2;

	/* Special case function */
  if (m_pCurrentFunc->OpCode == 0x1000) {

    if (m_NumFuncArgs == 1) {
      AddScriptData(&StringLen, 2);
      AddScriptData(((const TCHAR *)m_Token) + 1, StringLen);
      AddScriptData("\0", 1);	/* Arg count */
      m_LastMsgBoxArgs = m_ScriptDataSize - 1;
      m_LastMsgBoxBut  = -1;
     }
    else {
      if (m_LastMsgBoxBut < 0) {
        AddScriptData("\0", 1);	/* Button count */
        m_LastMsgBoxBut = m_ScriptDataSize - 1;
       }

      //m_NumMsgButtons++;
      byte StrLength = StringLen + 1;
      AddScriptData(&StrLength, 1);
      AddScriptData(((const TCHAR *)m_Token) + 1, StrLength-1);
      AddScriptData("\0", 1);
     }
   }
  else if ((m_pCurrentFunc->Flags & ESMSCR_FUNC_SHORTVAR) == 0 && (m_pCurrentFunc->Var[m_FuncArgIndex] & ESMSCR_FUNC_SHORTSTR) == 0) {
    AddScriptData(&StringLen, 2);
    AddScriptData(((const TCHAR *)m_Token) + 1, StringLen);
   }
  else {
    byte bStringLen = (byte) StringLen;
    AddScriptData(&bStringLen, 1);
    AddScriptData(((const TCHAR *)m_Token) + 1, bStringLen);
   }

  return (0);
 }

int CEsmScriptCompile::OutputFuncEnd (void) {

	/* Output extra unknown short at end */
  if ((m_pCurrentFunc->Flags & ESMSCR_FUNC_EXTRASHORT) != 0) {
    short Value = -1;
    AddScriptData(&Value, 2);
   }

	/* Update the number of arguments/buttons */
  if (m_pCurrentFunc->OpCode == 0x1000)  {

    if (m_LastMsgBoxArgs < 0) {
      AddScriptData("\0\0", 2);
     }
    else if (m_LastMsgBoxBut < 0) {
      m_ScriptData[m_LastMsgBoxArgs] = (byte) m_NumMsgArgs;
      AddScriptData("\0", 1);
     }
    else {
      m_ScriptData[m_LastMsgBoxArgs] = (byte) m_NumMsgArgs;
      m_ScriptData[m_LastMsgBoxBut]  = (byte) m_NumMsgButtons;
     }
   }
  else if (m_LastFuncArgSymbol) {
  //&& (m_pCurrentFunc->Flags & ESMSCR_FUNC_SHORTVAR) == 0) {
    //AddScriptData("\0", 1);	/* Only at end in some cases? */
   }

  return (0);
 }

int CEsmScriptCompile::OutputEffect (const int EffectID) { 
  if ((m_pCurrentFunc->Flags & ESMSCR_FUNC_SHORTVAR) == 1) return AddScriptData(&EffectID, 1); 
  return AddScriptData(&EffectID, 2);
 }
/*===========================================================================
 *		End of Output Function Arguments
 *=========================================================================*/


/*===========================================================================
 *
 * Class CEsmScriptCompile Method - int OutputWhile (void);
 *
 *=========================================================================*/
int CEsmScriptCompile::OutputWhile (void) { 
  int LinePos = m_ScriptDataSize;
  
	/* Output the initial if token */
  OutputToken(0x010A);
  m_StatementCount++;

	/* Output the intial exmpty statement count and expression length */
  OutputToken(0x0000);

	/* Initialize the required if related variables */
  m_LastIfPos = m_ScriptDataSize - 1;
  m_IsEmptyIf = true;
  m_OutputFuncIDRef = true;
  m_LastLineDataPos = LinePos;
  m_LastSetNegative = false;

  return (ESMSCR_RESULT_OK);
 }
/*===========================================================================
 *		End of Class Method CEsmScriptCompile::OutputWhile()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CEsmScriptCompile Method - int OutputWhileFinish (void);
 *
 *=========================================================================*/
int CEsmScriptCompile::OutputWhileFinish (void) {
  int Size;
  if (m_LastIfPos < 0) return (-1);

  Size = m_ScriptDataSize - m_LastIfPos - 1;

	/* Ensure a valid WHILE expression size */
  if (Size > 255) {
    AddError(_T("Compiled WHILE expression length exceeds 255 bytes!"));
    return (-1);
   }
  else if (m_IsEmptyIf) {
    AddScriptData("\0", 1);
    Size++;
   }
	/* Set the IF expression size */
  m_ScriptData[m_LastIfPos] = (byte) Size;

  	/* Add an if block to the if statement stack */
  AddIfBlock(m_StatementCount, m_LastIfPos - 1);
  
	/* Reset variables */
  m_LastIfPos = -1;
  m_OutputFuncIDRef = false;

  return (0);
 }
/*===========================================================================
 *		End of Class Method CEsmScriptCompile::OutputWhileFinish()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CEsmScriptCompile Method - int OutputEndWhile (void);
 *
 *=========================================================================*/
int CEsmScriptCompile::OutputEndWhile (void) { 
  int Result;
  
  	/* Update the previous WHILE block statement count */
  Result = UpdateLastIfBlock();
  if (Result == ESMSCR_RESULT_ERROR) return (ESMSCR_RESULT_ERROR);

  m_StatementCount++; 
  return OutputToken(0x010B); 
 }
/*===========================================================================
 *		End of Class Method CEsmScriptCompile::OutputEndWhile()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CEsmScriptCompile Method - esmscrifblock_t* PopIfBlock (void);
 *
 * Pops the top if statement block from the stack. Returns NULL if no
 * block is available. The popped object is automatically copied into a 
 * local static (which is returned) and then freed.
 *
 *=========================================================================*/
esmscrifblock_t* CEsmScriptCompile::PopIfBlock (void) {
  static esmscrifblock_t s_IfBlock;
  esmscrifblock_t*	 pIfBlock;

	/* Pop the top object and ensure it is valid */
  pIfBlock = (esmscrifblock_t *) m_IfStatementStack.Pop();
  if (pIfBlock == NULL) return (NULL);

	/* Copy if block and delete the allocated object */
  s_IfBlock = *pIfBlock;
  DestroyPointer(pIfBlock);
 
  return (&s_IfBlock);
 }
/*===========================================================================
 *		End of Class Method CEsmScriptCompile::PopIfBlock()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CEsmScriptCompile Method - void SetMsgLevel (Type);
 *
 * Sets the compiler error/message level according to the input type.
 *
 *=========================================================================*/
void CEsmScriptCompile::SetMsgLevel (const int Type) {

  switch (Type) {
    case ESMSCR_COMPILEMSG_WEAK:
	SetWeakMsgLevels();
	break;
    case ESMSCR_COMPILEMSG_STRONG:
	SetStrongMsgLevels();
	break;
    default:
    case ESMSCR_COMPILEMSG_DEFAULT:
	SetDefaultMsgLevels();
	break;
   }
 }
/*===========================================================================
 *		End of Class Method CEsmScriptCompile::SetMsgLevel()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CEsmScriptCompile Method - int UpdateLastIfBlock (void);
 *
 * Updates the statement count of the last IF block, if any. Returns
 * ESMSCR_MESSAGE_ERROR on any error.
 *
 *=========================================================================*/
int CEsmScriptCompile::UpdateLastIfBlock (void) {
  esmscrifblock_t* pIfBlock;
  int		   NumStatements;

	/* Attempt to get the last if block information and ensure it is valid */
  pIfBlock = PopIfBlock();
  if (pIfBlock == NULL) return (ESMSCR_RESULT_OK);

	/* Update the statement count and ensure it is valid */
  NumStatements = m_StatementCount - pIfBlock->StartStatementCount;

  if (NumStatements > MWESM_SCRIPT_MAXIFSTATEMENTS) {
    AddError(_T("Exceeded the maximum of %d statements within an IF block!"), MWESM_SCRIPT_MAXIFSTATEMENTS);
    return (ESMSCR_RESULT_ERROR);
   }

	/* Update the if statement count */
  m_ScriptData[pIfBlock->IfStartPos] = (byte) NumStatements;
  return (ESMSCR_RESULT_OK);
 }
/*===========================================================================
 *		End of Class Method CEsmScriptCompile::UpdateLastIfBlock()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CEsmScriptCompile Method - void InitializeExtraRecords (void);
 *
 * Static class method to initialize the extra record map based on the
 * current extra file contents.
 *
 *=========================================================================*/
void CEsmScriptCompile::InitializeExtraRecords (void) {
  CEsmRecord*  pRecord;
  const TCHAR* pID;
  int          Index;

  m_ExtraRecords.RemoveAll();

  for (Index = 0; Index < m_ExtraFile.GetNumRecords(); ++Index) {
    pRecord = m_ExtraFile.GetRecord(Index);
    if (pRecord == NULL) continue;

    pID = pRecord->GetID();
    if (pID == NULL || pID[0] == NULL_CHAR) continue;

    m_ExtraRecords.SetAt(pID, pRecord);
  }

}
/*===========================================================================
 *		End of Class Method CEsmScriptCompile::InitializeExtraRecords()
 *=========================================================================*/

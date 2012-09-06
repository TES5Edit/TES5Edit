/*===========================================================================
 *
 * File:	Esmscriptcompileex.CPP
 * Author:	Dave Humphrey (uesp@sympatico.ca)
 * Created On:	August 21, 2006
 *
 * Functions related to extended script compiler for MWSE and other
 * non-standard script extenions.
 *
 *=========================================================================*/

	/* Include Files */
#include <stdafx.h>
#include "esmscriptcompile.h"
#include "ctype.h"
#include "EsmGlobal.h"
#include "MwEditDoc.h"
#include "EsmGlobOptions.h"


/*===========================================================================
 *
 * Begin Local Definitions
 *
 *=========================================================================*/
  DEFINE_FILE("EsmScriptCompileEx.cpp");
/*===========================================================================
 *		End of Local Definitions
 *=========================================================================*/


#ifdef MWEDIT_SCRIPT_MWSE

/*===========================================================================
 *
 * Class CEsmScriptCompile Method - int ParseFuncArgX (void);
 *
 * Alternate to ParseFuncArg() for Extended Functions - parse only, does not output anything
 *
 *=========================================================================*/
int CEsmScriptCompile::ParseFuncArgX (void) {
  int  Result= ESMSC_FUNCARG_OK;
  bool CheckMsgArgs = false;

  m_TokenParsed = true;

	/* Missing commas between last argument */
  if (m_LastFuncArg == m_NumFuncArgs) {
    m_NumFuncArgs++;
    Result = AddMessage(ESMSCR_WARNING_NOCOMMA, _T("Missing ',' between arguments %d and %d!"), m_NumFuncArgs-1, m_NumFuncArgs);
    if (!Result) return (ESMSCR_RESULT_ERROR);
   }
 
  if (m_pCurrentFunc == NULL || m_FuncArgIndex >= ESMSCR_MAX_FUNCARGS)
  	return (ESMSC_FUNCARG_ERROR);

	/* Move counters to the next function argument */
  m_LastFuncArg = m_NumFuncArgs;
  m_FuncArgIndex++;

  return (ESMSCR_RESULT_OK);
 }
/*===========================================================================
 *		End of Class Method CEsmScriptCompile::ParseFuncArgX()
 *=========================================================================*/


int CEsmScriptCompile::PushFuncOp (void) {
  DEFINE_FUNCTION("CEsmScriptCompile::PushFuncOp()");

  m_refObject= m_LastToken;
  return 0;
}


int CEsmScriptCompile::OutputFuncOp (void) {
  DEFINE_FUNCTION("CEsmScriptCompile::OutputFuncOp()");

  WriteFuncOp((const TCHAR *)m_LastToken);
  return 0;
}


int CEsmScriptCompile::OutputStoredFuncOp (void) {
  DEFINE_FUNCTION("CEsmScriptCompile::OutputFuncOp()");

  if(!m_refObject.IsEmpty())
	WriteFuncOp((const TCHAR *)m_refObject);
  m_refObject= "";
  return 0;
}


int CEsmScriptCompile::WriteFuncOp (const TCHAR* ident) {
  DEFINE_FUNCTION("CEsmScriptCompile::OutputFuncOp()");
  char LocalType;
  int LocalIndex= FindLocalVarIndex(ident, LocalType);

  if(LocalIndex>=0)
  {
	  struct { short pushb; short type; short pushs; short index; short getlocal; short setref;}
		setrefcmd= {MWESM_OPCODE_PUSHS,LocalIndex-1,MWESM_OPCODE_PUSHS,LocalType,MWESM_OPCODE_GETLOCAL,MWESM_OPCODE_SETREF };
	  AddScriptData(&setrefcmd,sizeof(setrefcmd));
  }
  else
	InsertScriptDataRef(ident, _tcslen(ident));

  return 0;
}


/*===========================================================================
 *
 * Begin Output Let Blocks
 *
 *=========================================================================*/
int CEsmScriptCompile::PushLetLocal (void) {
	DEFINE_FUNCTION("CEsmScriptCompile::PushLetLocal()");
	esmscrstack_t* param= 0;
	CreatePointer(param, esmscrstack_t);
	param->TokenID= ESMSCR_FUNC_LOCALVAR;
	strnncpy(param->Token, (const TCHAR*)m_Token, sizeof(param->Token)/sizeof(param->Token[0])-1);
	m_LetQueue.push(param);
	return 0;
  }

int CEsmScriptCompile::OutputLetEnd (void) {
	int  LocalIndex;
	char LocalType;

	while(!m_LetQueue.empty())
	{
		esmscrstack_t* param= m_LetQueue.front();
		
		const TCHAR* token= param->Token;
		LocalIndex = FindLocalVarIndex(token, LocalType);
		struct { short pushb; short index; short pushs; short type; short setlocal; }
			getlocalcmd= {MWESM_OPCODE_PUSHS,LocalIndex-1,MWESM_OPCODE_PUSHS,LocalType,MWESM_OPCODE_SETLOCAL };
		AddScriptData(&getlocalcmd,sizeof(getlocalcmd));
		m_LetQueue.pop();
		DestroyPointer(param);
	}
	
	return 0;
}
/*===========================================================================
 *		End of Output Let Blocks
 *=========================================================================*/

/*===========================================================================
 *
 * Begin Output XIf Blocks
 *
 *=========================================================================*/
int CEsmScriptCompile::OutputXIf(void) {
	DEFINE_FUNCTION("CEsmScriptCompile::OutputXIf()");
	esmscrifblock_t* pos= 0;
	CreatePointer(pos, esmscrifblock_t);
	pos->IfStartPos= m_ScriptDataSize+16;
	m_XIfStack.push(pos);

	char LocalType;
	int  LocalIndex= FindLocalVarIndex((const TCHAR*)m_Token, LocalType);
	struct { short pushb; short type; short pushs; short index;
		short getlocal; short pops; short size; short jz; short pos; }
		testcmd= {MWESM_OPCODE_PUSHS,LocalIndex-1,MWESM_OPCODE_PUSHS,LocalType,
			MWESM_OPCODE_GETLOCAL,MWESM_OPCODE_POP,4,MWESM_OPCODE_JUMPSHORTZERO,0 };
	AddScriptData(&testcmd,sizeof(testcmd));

	return 0;
}

int CEsmScriptCompile::OutputXElse(void) {
	if(m_XIfStack.size()>0)
	{
		struct { short jmp; short pos; } elsecmd= {MWESM_OPCODE_JUMPSHORT,0};
		esmscrifblock_t* pos= m_XIfStack.top();
		*(short*)(&m_ScriptData[pos->IfStartPos])= m_ScriptDataSize+4;
		pos->IfStartPos= m_ScriptDataSize+2;
		AddScriptData(&elsecmd,sizeof(elsecmd));
	}
	
	return 0;
}

int CEsmScriptCompile::OutputXElseIf(void) {
	OutputXElse();
	return OutputXIf();
}

int CEsmScriptCompile::OutputXEndIf(void) {
	if(m_XIfStack.size()>0)
	{
		esmscrifblock_t* pos= m_XIfStack.top();
		m_XIfStack.pop();
		*(short*)(&m_ScriptData[pos->IfStartPos])= m_ScriptDataSize;
		DestroyPointer(pos);
	}

	return 0;
}
/*===========================================================================
 *		End of Output XIf Blocks
 *=========================================================================*/


/*===========================================================================
 *
 * Begin Output SE Function Arguments
 *
 *=========================================================================*/

int CEsmScriptCompile::PushFuncXArgLocal()
{
	return PushFuncXArg(ESMSCR_FUNC_LOCALVAR,(const TCHAR*)m_Token);
}

int CEsmScriptCompile::OutputFuncXArgLocal(const TCHAR* name)
{
  short LocalIndex;
  char  LocalType;

  LocalIndex = FindLocalVarIndex(name, LocalType);
  struct { short pushb; short type; short pushs; short index; short getlocal; }
	pushlocalcmd= {MWESM_OPCODE_PUSHS,LocalIndex-1,MWESM_OPCODE_PUSHS,LocalType,MWESM_OPCODE_GETLOCAL };

  AddScriptData(&pushlocalcmd, sizeof(pushlocalcmd));
  m_LastFuncArgSymbol = true;
  
  return 0;
}

int CEsmScriptCompile::PushFuncXArgNum(void)
{
  int FuncArgFlag = m_pCurrentFunc->Var[m_FuncArgIndex];

  if ((FuncArgFlag & ESMSCR_FUNC_FLOAT) != 0) {
    FuncArgFlag= ESMSCR_FUNC_FLOAT;
   }
  else if ((FuncArgFlag & ESMSCR_FUNC_LONG) != 0
  	|| (FuncArgFlag & ESMSCR_FUNC_SHORT) !=0) {
    FuncArgFlag= ESMSCR_FUNC_LONG;
   }

  if (m_LastTokenNegative) {
    m_Token= "-" + m_Token;
    m_LastTokenNegative = false;
   }

  if (m_NumFuncArgs <= 0) {
    m_NumFuncArgs = 1;
    m_LastFuncArg = 0;
   }
  
  PushFuncXArg(FuncArgFlag, (const TCHAR*)m_Token);
  m_LastFuncArgSymbol = false;
  
  return 0;
}

int CEsmScriptCompile::OutputFuncXArgNum(int type, const TCHAR* token)
{
#pragma pack(1)
  struct { short pushcode; union { float fval; long lval; } value; } pushcmd;
#pragma pack()
  pushcmd.pushcode= MWESM_OPCODE_PUSH;
  
  if(type & ESMSCR_FUNC_FLOAT)
  	pushcmd.value.fval= (float) atof(token);
  else
  	pushcmd.value.lval= atol(token);
  
  AddScriptData(&pushcmd,sizeof(pushcmd));
  return 0;
}

int CEsmScriptCompile::PushFuncXArgString(void)
{
	CString left= m_Token.Left(m_Token.GetLength()-1);
	CString right= left.Right(left.GetLength()-1);
	return PushFuncXArg(ESMSCR_FUNC_STRING,(const TCHAR*)right);
}

char* CEsmScriptCompile::OutputFuncXArgStringCat(char* buf, const void* newdata, int newdatalen)
{
	memcpy(buf, newdata, newdatalen);
	return buf+newdatalen;
}

int CEsmScriptCompile::OutputFuncXArgString(const TCHAR* token)
{
	short opcode= MWESM_OPCODE_PUSHS;
	char StringLen = strlen(token);
	char BStringLen= StringLen%2?StringLen:StringLen+1;
	short script_pos= m_ScriptDataSize + 8;
	char* pushstring= new char[BStringLen + 10];
	
	char* current= OutputFuncXArgStringCat(pushstring,&opcode,sizeof(opcode));
	current= OutputFuncXArgStringCat(current,&script_pos,sizeof(script_pos));
	
	opcode= MWESM_OPCODE_JUMPSHORT;
	current= OutputFuncXArgStringCat(current,&opcode,sizeof(opcode));
	script_pos+= BStringLen+1;
	current= OutputFuncXArgStringCat(current,&script_pos,sizeof(script_pos));
	
	current= OutputFuncXArgStringCat(current,&StringLen,sizeof(StringLen));
	current= OutputFuncXArgStringCat(current,token,StringLen);
	if(BStringLen>StringLen) //TODO: use a messagebox so fixupscript still works
	{
		char padding= 0;
		current= OutputFuncXArgStringCat(current,&padding,sizeof(padding));
	}
	AddScriptData(pushstring,current-pushstring);
	
	delete []pushstring;
	return 0;
}

int CEsmScriptCompile::PushFuncXArg(int type, const TCHAR* token)
{
	DEFINE_FUNCTION("CEsmScriptCompile::PushFuncXArg()");
	esmscrstack_t* param= 0;
	CreatePointer(param, esmscrstack_t);
	param->TokenID= type;
	strnncpy(param->Token, token, sizeof(param->Token)/sizeof(param->Token[0])-1);
	m_ArgXStack.push(param);
	return 0;
}

int CEsmScriptCompile::OutputFuncXBlock(void)
{
	DEFINE_FUNCTION("CEsmScriptCompile::OutputFuncXBlock()");
	esmscrstack_t* param= 0;
	while(m_ArgXStack.size())
	{
		param= m_ArgXStack.top();
		m_ArgXStack.pop();
		int type= param->TokenID;
		const TCHAR* token= param->Token;
		switch(type)
		{
			case ESMSCR_FUNC_LOCALVAR: OutputFuncXArgLocal(token); break;
			case ESMSCR_FUNC_FLOAT:
			case ESMSCR_FUNC_LONG:
			case ESMSCR_FUNC_SHORT: OutputFuncXArgNum(type,token); break;
			case ESMSCR_FUNC_STRING: OutputFuncXArgString(token); break;
		}
		DestroyPointer(param);
	}

	ASSERT(m_pCurrentFunc != NULL);
	//TODO: check for object-> and replicate that code here or call setref if var->
	OutputStoredFuncOp();
	AddScriptData(&(m_pCurrentFunc->OpCode), 2);

	m_LastMsgBoxArgs = -1;
	m_LastMsgBoxBut  = -1;
	m_NumMsgArgs     = 0;
	m_NumMsgButtons  = 0;
	m_FuncOptCount   = 0;
	m_LastFuncArgSymbol = false;
	
	return 0;
}

/*===========================================================================
 *		End of Output SE Function Arguments
 *=========================================================================*/


/*===========================================================================
 *
 * Begin Output XIf Blocks
 *
 *=========================================================================*/
int CEsmScriptCompile::OutputXWhile(void) {
	DEFINE_FUNCTION("CEsmScriptCompile::OutputXWhile()");
	esmscrifblock_t* pos= 0;
	CreatePointer(pos, esmscrifblock_t);
	pos->IfStartPos= m_ScriptDataSize;
	m_XIfStack.push(pos);

	char LocalType;
	int  LocalIndex= FindLocalVarIndex((const TCHAR*)m_Token, LocalType);
	struct { short pushb; short type; short pushs; short index;
		short getlocal; short pops; short size; short jz; short pos; }
		testcmd= {MWESM_OPCODE_PUSHS,LocalIndex-1,MWESM_OPCODE_PUSHS,LocalType,
			MWESM_OPCODE_GETLOCAL,MWESM_OPCODE_POP,4,MWESM_OPCODE_JUMPSHORTZERO,0 };
	AddScriptData(&testcmd,sizeof(testcmd));

	return 0;
}

int CEsmScriptCompile::OutputXEndWhile(void) {
	if(m_XIfStack.size()>0)
	{
		esmscrifblock_t* pos= m_XIfStack.top();
		m_XIfStack.pop();
		struct { short jmp; short pos; } endwhilecmd= {MWESM_OPCODE_JUMPSHORT,pos->IfStartPos};
		AddScriptData(&endwhilecmd,sizeof(endwhilecmd));
		*(short*)(&m_ScriptData[pos->IfStartPos+16])= m_ScriptDataSize;
		DestroyPointer(pos);
	}
	
	return 0;
}

/*===========================================================================
 *		End of Output XWhile Blocks
 *=========================================================================*/

#endif /* MWEDIT_SCRIPT_MWSE */
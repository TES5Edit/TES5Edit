#ifndef __SRSCRIPTTOKENS_H
#define __SRSCRIPTTOKENS_H


#include "../modfile/srmoddefs.h"
#include <vector>


enum srtoken_t
{
	SR_TOKEN_UNKNOWN,
	SR_TOKEN_OPERATOR,
	SR_TOKEN_KEYWORD,
	SR_TOKEN_IDENTIFIER,
	SR_TOKEN_DOCUMENTATION,
	SR_TOKEN_STRING,
	SR_TOKEN_INTEGER,
	SR_TOKEN_FLOAT,
	SR_TOKEN_EOL,
	SR_TOKEN_END
};


struct srscripttoken_t
{
	CSString	Token;
	srtoken_t	Type;
};


typedef CSrPtrArray<srscripttoken_t> CSrScriptTokenArray;


#endif
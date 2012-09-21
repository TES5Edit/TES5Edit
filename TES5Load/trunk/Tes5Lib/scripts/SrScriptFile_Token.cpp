#include "SrScriptFile.h"

/*
<property> ::= <type> 'Property' <identifier> <flags>
                 <function>
                 [<function>]
               'endProperty'

<auto property> ::= <type> 'Property' <identifier> ['=' <constant>] 'Auto' <flags>

flags ::= hidden conditional
*/


void CSrScriptFile::DumpTokens (void)
{
	SystemLog.Printf("Dumping tokens for script '%s'...", m_ScriptName.c_str());

	for (dword i = 0; i < m_Tokens.GetSize(); ++i)
	{
		SystemLog.Printf("%d) Type=%d, String='%s'", i+1, m_Tokens[i]->Type, m_Tokens[i]->Token.c_str());
	}
}


bool CSrScriptFile::Tokenize (void)
{
	static const int CSP = 1;
	static const int CNM = 2;
	static const int CAL = 3;
	static const int COP = 4;
	static const int CDO = 5;
	static const int CCM = 6;
	static const int CST = 7;
	static const int CEN = 8;
	static const int CLN = 9;
	static const int CCN = 10;

	static const int s_CharTypes[256] = 
	{
	  CEN,  0,  0,  0,  0,  0,  0,  0,  0,CSP,CLN,  0,  0,CLN,  0,  0,
	    0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,
	  CSP,COP,CST,  0,  0,COP,COP,  0,COP,COP,COP,COP,COP,COP,COP,COP,		
 	  CNM,CNM,CNM,CNM,CNM,CNM,CNM,CNM,CNM,CNM,  0,CCM,COP,COP,COP,  0,
		0,CAL,CAL,CAL,CAL,CAL,CAL,CAL,CAL,CAL,CAL,CAL,CAL,CAL,CAL,CAL,
      CAL,CAL,CAL,CAL,CAL,CAL,CAL,CAL,CAL,CAL,CAL,COP,CCN,COP,  0,CAL,
		0,CAL,CAL,CAL,CAL,CAL,CAL,CAL,CAL,CAL,CAL,CAL,CAL,CAL,CAL,CAL,
	  CAL,CAL,CAL,CAL,CAL,CAL,CAL,CAL,CAL,CAL,CAL,CDO,COP,  0,  0,  0,
	    0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,
	    0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,
		0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,
		0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,
		0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,
		0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,
		0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,
		0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0
	};

	const char* pParse;
	bool        Result;

	m_Tokens.Destroy();

	srtimer_t TokenTimer;
	SrStartTimer(TokenTimer);

	pParse = m_ScriptText.c_str();

	while (*pParse)
	{
		while (s_CharTypes[*pParse] == CSP) ++pParse;

		switch (s_CharTypes[*pParse])
		{
		case CCN:
			++pParse;
			while (s_CharTypes[*pParse] == CSP) ++pParse;
			while (s_CharTypes[*pParse] == CLN) ++pParse;
			while (s_CharTypes[*pParse] == CSP) ++pParse;
			break;
		case CLN:
			Result = TokenEOL(pParse);
			if (!Result) return false;
			break;
			break;
		case CNM:
			Result = TokenNumber(pParse);
			if (!Result) return false;
			break;
		case CAL:
			Result = TokenAlpha(pParse);
			if (!Result) return false;
			break;
		case CDO:
			Result = TokenDocument(pParse);
			if (!Result) return false;
			break;
		case CCM:
			Result = TokenComment(pParse);
			if (!Result) return false;
			break;
		case COP:
			Result = TokenOperator(pParse);
			if (!Result) return false;
			break;
		case CST:
			Result = TokenString(pParse);
			if (!Result) return false;
			break;
		default:
			AddSrGeneralError("Found unknown character '%c'(0x%02X) in script!", *pParse, *pParse);
			return false;
		}

	}

	srscripttoken_t* pToken = m_Tokens.AddNew();
	pToken->Type = SR_TOKEN_END;

	SrEndTimer(TokenTimer, "Script Tokenized in ");

	//DumpTokens();
	return true;
}


bool CSrScriptFile::TokenEOL (const char*& pParse)
{
	if (*pParse == '\r') ++pParse;
	if (*pParse == '\n') ++pParse;

	srscripttoken_t* pToken = m_Tokens.AddNew();
	pToken->Type = SR_TOKEN_EOL;
	return true;
}


bool CSrScriptFile::TokenOperator (const char*& pParse)
{
	const char*      pStartToken = pParse;
	srscripttoken_t* pToken;

	switch (*pParse)
	{
	case '|':
	case '&':
		if (pParse[1] != pParse[0]) return AddSrGeneralError("Invalid script operator '%c' found!", *pParse);
		
		pParse += 2;
		pToken = m_Tokens.AddNew();
		pToken->Token.Copy(pStartToken, 2);
		pToken->Type = SR_TOKEN_OPERATOR;
		return true;

	case '(':
	case ')':
	case '!':
	case '.':
    case ',':
	case '[':
	case ']':
		++pParse;
		pToken = m_Tokens.AddNew();
		pToken->Token.Copy(pStartToken, 1);
		pToken->Type = SR_TOKEN_OPERATOR;
		return true;
	case '%':
	case '/':
	case '*':
	case '+':
	case '-':
	case '<':
	case '>':
	case '=':
		if (pParse[1] == '=')
		{
			pParse += 2;
			pToken = m_Tokens.AddNew();
			pToken->Token.Copy(pStartToken, 2);
			pToken->Type = SR_TOKEN_OPERATOR;
		}
		else
		{
			++pParse;
			pToken = m_Tokens.AddNew();
			pToken->Token.Copy(pStartToken, 1);
			pToken->Type = SR_TOKEN_OPERATOR;
		}

		return true;
	}

	AddSrGeneralError("Unknown script token character '%c'(0x%02X)!", *pParse, *pParse);
	return false;
}


bool CSrScriptFile::TokenString (const char*& pParse)
{
	const char* pStartToken = pParse + 1;

	++pParse;

	while (*pParse)
	{
		if (*pParse == '"')
		{
			srscripttoken_t* pToken = m_Tokens.AddNew();
			pToken->Token.Copy(pStartToken, pParse - pStartToken - 1);
			pToken->Type = SR_TOKEN_STRING;
			++pParse;
			return true;
		}

		++pParse;
	}

	AddSrGeneralError("Unterminated string in script!");
	return false;
}


bool CSrScriptFile::TokenAlpha (const char*& pParse)
{
	const char*      pStartToken = pParse;
	srscripttoken_t* pToken;

	while (*pParse)
	{
		if (!iscsym(*pParse)) break;
		++pParse;
	}

	pToken = m_Tokens.AddNew();
	pToken->Token.Copy(pStartToken, pParse - pStartToken);
	pToken->Type = SR_TOKEN_IDENTIFIER;
	
	return true;
}


bool CSrScriptFile::TokenNumber (const char*& pParse)
{
	const char*      pStartToken = pParse;
	srscripttoken_t* pToken;

	++pParse;

	while (*pParse)
	{
		if (*pParse == '.') goto TOKENNUMBER_PARSEDECIMAL;
		if (*pParse == 'x') goto TOKENNUMBER_PARSEHEX;
		if (*pParse == 'X') goto TOKENNUMBER_PARSEHEX;
		if (!isdigit(*pParse)) break;
		++pParse;
	}

	pToken = m_Tokens.AddNew();
	pToken->Token.Copy(pStartToken, pParse - pStartToken - 1);
	pToken->Type = SR_TOKEN_INTEGER;

	return true;

TOKENNUMBER_PARSEHEX:

	while (*pParse)
	{
		if (!isdigit(*pParse)) break;
		++pParse;
	}

	pToken = m_Tokens.AddNew();
	pToken->Token.Copy(pStartToken, pParse - pStartToken - 1);
	pToken->Type = SR_TOKEN_INTEGER;

	return true;

TOKENNUMBER_PARSEDECIMAL:
	++pParse;

	while (*pParse)
	{
		if (*pParse == 'e') goto TOKENNUMBER_PARSEEXPONENT;
		if (*pParse == 'E') goto TOKENNUMBER_PARSEEXPONENT;
		if (!isdigit(*pParse)) break;
		++pParse;
	}

	goto TOKENNUMBER_SAVEFLOAT;

TOKENNUMBER_PARSEEXPONENT:
	++pParse;

	if (*pParse == '-') pParse++;
	else if (*pParse == '+') pParse++;

	while (*pParse)
	{
		if (!isdigit(*pParse)) break;
		++pParse;
	}

TOKENNUMBER_SAVEFLOAT:
	pToken = m_Tokens.AddNew();
	pToken->Token.Copy(pStartToken, pParse - pStartToken - 1);
	pToken->Type = SR_TOKEN_FLOAT;

	return true;
}


bool CSrScriptFile::TokenDocument (const char*& pParse)
{
	const char* pStartToken = ++pParse;

	while (*pParse)
	{
		if (*pParse == '}')
		{
			srscripttoken_t* pToken = m_Tokens.AddNew();
			pToken->Token.Copy(pStartToken, pParse - pStartToken - 1);
			pToken->Type = SR_TOKEN_DOCUMENTATION;
			++pParse;
			return true;
		}

		++pParse;
	}

	AddSrGeneralError("Unterminated document section in script!");
	return false;
}


bool CSrScriptFile::TokenComment (const char*& pParse)
{
	const char* pStartToken = pParse;

	++pParse;
	
	if (*pParse == '/') 
	{
		++pParse;

		while (*pParse != 0)
		{
			if (pParse[0] == '/' && pParse[1] == ';')
			{
				pParse += 2;
				return true;
			}

			++pParse;
		}

		AddSrGeneralError("Unterminated multi-line comment in script!");
		return false;
	}
	else
	{
		while (*pParse != 0)
		{
			if (*pParse == '\n' || *pParse == '\r')
			{
				++pParse;
				return true;
			}

			++pParse;
		}

	}

	return true;
}



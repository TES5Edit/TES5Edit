/*===========================================================================
 *
 * File:	SString.CPP
 * Author:	Dave Humphrey (dave@uesp.net)
 * Created On:	Tuesday, May 08, 2001
 *
 * Contains the implementation for the simple string class CSString.
 *
 * TODO: Will fail with strings longer than 2**31 bytes long (VC8).
 *
 *=========================================================================*/

	/* Include Files */
#include <ctype.h>
#include <limits.h>
#include "sstring.h"
#include "stdio.h"


/*===========================================================================
 *
 * Begin Local Variable Definitions
 *
 *=========================================================================*/

	/* Defines an empty string */
  static int			s_SSData[]     = { 0, 0, 0 };
  static CSStringData*	s_pSDataNull   = (CSStringData *) &s_SSData;

  long g_StringAllocations = 0;

  
  int GuessFormatLength (const SSCHAR* pString, va_list Args);
    
/*===========================================================================
 *		End of Local Variable Definitions
 *=========================================================================*/


/*===========================================================================
 *
 * Class CSString Constructor - CSString ();
 *
 *=========================================================================*/
CSString::CSString () {
  //DEFINE_FUNCTION("CSString::CSString()");
  Init();
 }
/*===========================================================================
 *		End of Class CSString Constructor
 *=========================================================================*/


/*===========================================================================
 *
 * Class CSString Constructor - CSString (pSrcString);
 *
 * Uses the given character buffer to initialize the string.  Handles the
 * NULL input string case.
 *
 *=========================================================================*/
CSString::CSString (const SSCHAR* pSrcString) {
  //DEFINE_FUNCTION("CSString::CSString(SSCHAR*)");
  Init();

  if (pSrcString != NULL) {
    int Length = (int) strlen(pSrcString);
    AllocString(Length);
    memcpy(m_pString, pSrcString, sizeof(SSCHAR)*(Length+1));
   }

 }
/*===========================================================================
 *		End of Class CSString Constructor
 *=========================================================================*/


/*===========================================================================
 *
 * Class CSString Constructor - CSString (pSrcString, SrcLength);
 *
 * Uses the given character buffer to initialize the string, up to the
 * given length.  Handles the NULL input string case.
 *
 *=========================================================================*/
CSString::CSString (const SSCHAR* pSrcString, const int SrcLength) {
  //DEFINE_FUNCTION("CSString::CSString(SSCHAR*, int)");
  Init();

  	/* Check for the NULL case */
  if (pSrcString == NULL && SrcLength > 0) {
    AllocString(SrcLength);
    m_pString[0] = NULL_CHAR;
    GetData()->Length = 0;
   }
	/* Create a normally sized string */
  else {
    int InputLength = (int) strlen(pSrcString);

    AllocString(SrcLength);

    if (InputLength < SrcLength) GetData()->Length = InputLength;
    memcpy(m_pString, pSrcString, GetLength()*sizeof(SSCHAR));
   }

 }
/*===========================================================================
 *		End of Class CSString Constructor
 *=========================================================================*/


/*===========================================================================
 *
 * Class CSString Constructor - CSString (SrcString);
 *
 * Uses the given CSString object to initialize the string.
 *
 *=========================================================================*/
CSString::CSString (const CSString& SrcString) {
  //DEFINE_FUNCTION("CSString::CSString(CSString&)");
  Init();

	/* Copy the source string */
  AllocString(SrcString.GetLength());
  memcpy(m_pString, (const SSCHAR*) SrcString, (SrcString.GetLength()+1)*sizeof(SSCHAR));
 }
/*===========================================================================
 *		End of Class CSString Constructor
 *=========================================================================*/


/*===========================================================================
 *
 * Class CSString Constructor - CSString (StringSize);
 *
 * Creates an empty string with the given number of bytes.  String is 
 * initially composed of all space characters.
 *
 *=========================================================================*/
CSString::CSString (const int StringSize) {
  //DEFINE_FUNCTION("CSString::CSString(int)");
  Init();

	/* Copy the source string */
  if (StringSize > 0) {
    AllocString(StringSize);
    memset(m_pString, (SSCHAR)' ', StringSize*sizeof(SSCHAR));
   }

 }
/*===========================================================================
 *		End of Class CSString Constructor
 *=========================================================================*/


/*===========================================================================
 *
 * Class CSString Constructor - CSString (Char, Count);
 *
 * Creates a multiple character string.  ASSERTs on invalid input.
 *
 *=========================================================================*/
CSString::CSString (const SSCHAR Char, const int Count) {
  //DEFINE_FUNCTION("CSString::CSString(SSCHAR, int)");
  Init();
	
	/* Allocate and create the string */
  if (Count > 0) {
    AllocString((int)Count);
    memset(m_pString, (int)Char, Count*sizeof(SSCHAR));
   }

 }
/*===========================================================================
 *		End of Class Method CSString& CSString::operator=()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CSString Destructor
 *
 *=========================================================================*/
CSString::~CSString () {
  FreeData();
 }
/*===========================================================================
 *		End of Class CSString Destructor
 *=========================================================================*/


/*===========================================================================
 *
 * Class CSString Method - void Destroy (void);
 *
 *=========================================================================*/
void CSString::Destroy (void) {
  Empty();
 }  
/*===========================================================================
 *		End of Class Method CSString::Destroy()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CSString Method - void AllocString (StringSize);
 *
 * Protected class method which allocates a new string buffer for the 
 * given size.
 *
 *=========================================================================*/
void CSString::AllocString (const int StringSize) {
  CSStringData* pData;
  int		nAllocLength;

	/* Check for integer wrap arounds */
  assert(StringSize < INT_MAX - SSTRING_ALLOC_EXTRA - 1);

	/* Use a NULL string? */
  if (StringSize == 0) {
    Init();
   }
	/* Do we need to allocate a new buffer */
  else {
    nAllocLength = StringSize + SSTRING_ALLOC_EXTRA;
    pData = (CSStringData *) new byte[sizeof(CSStringData) + (nAllocLength+1)*sizeof(SSCHAR)];
	++g_StringAllocations;

    pData->Length = StringSize;
    pData->AllocLength = nAllocLength;
    pData->GetData()[nAllocLength] = '\0';
    pData->GetData()[StringSize] = '\0';
    m_pString = pData->GetData();
   }
   
	/* Ensure valid output */
  assert(m_pString != NULL);
  assert(GetLength() <= GetData()->AllocLength);
 }
/*===========================================================================
 *		End of Class Method CSString::AllocString()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CSString Method - void AllocCopy (StringSize);
 *
 * Protected class method which allocates a copy of the the current 
 * string buffer with the given size, if the new size doesn't fit in the
 * currently allocated buffer.  Thus, all that possibly changes is
 * the allocated string length.
 *
 *=========================================================================*/
void CSString::AllocCopy (const int StringSize) {
  CSStringData* pData;
  int		nAllocLength;

	/* Check for integer wrap arounds */
  assert(StringSize < (int)(INT_MAX - SSTRING_ALLOC_EXTRA - 1));

	/* Do we need to allocate a new buffer */
  nAllocLength = StringSize + SSTRING_ALLOC_EXTRA;
  pData = (CSStringData *) new byte[sizeof(CSStringData) + (nAllocLength+1)*sizeof(SSCHAR)];
  ++g_StringAllocations;

  pData->Length      = StringSize;
  pData->AllocLength = nAllocLength;
    
		/* Copy the old buffer to the new */
  assert(GetData()->Length < nAllocLength);
  memcpy(pData->GetData(), m_pString, (GetData()->Length+1)*sizeof(SSCHAR));

  pData->GetData()[nAllocLength] = '\0';
  m_pString = pData->GetData();
  m_pString[StringSize] = '\0';
  
	/* Ensure valid output */
  assert(m_pString != NULL);
  assert(GetLength() <= GetData()->AllocLength);
 }
/*===========================================================================
 *		End of Class Method CSString::AllocCopy()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CSString Method - void ConcatStrings (String1Size, pString1, 
 *					       String2Size, pString2);
 *
 * Protected class method used by the friend operator+() functions.
 * Creates a concatenation of pString1+pString2.  Handles NULL and
 * zero length strings.
 *
 *=========================================================================*/
void CSString::ConcatStrings (const int String1Size, const SSCHAR* pString1,
			      const int String2Size, const SSCHAR* pString2) {
  int NewSize;

	/* Ensure the strings can combine to produce a valid size */
  assert(String1Size < (int)(INT_MAX - String2Size));
  NewSize = String1Size + String2Size;

	/* Create a buffer larger enough to hold the new string */
  AllocString(NewSize);

	/* Create the new string */
  if (pString1 != NULL && String1Size != 0) memmove(m_pString, pString1, String1Size*sizeof(SSCHAR));
  if (pString2 != NULL && String2Size != 0) memmove(m_pString + String1Size, pString2, String2Size*sizeof(SSCHAR));
  m_pString[NewSize] = NULL_CHAR;
 }
/*===========================================================================
 *		End of Class Method CSString::ConcatStrings()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CSString Method - int CountChar (Char);
 *
 * Counts and returns the occurence of the given character in the string.
 *
 *=========================================================================*/
int CSString::CountChar (const SSCHAR Char) {
  int Index;
  int Count = 0;

  for (Index = 0; Index < GetLength(); ++Index) {
    if (m_pString[Index] == Char) ++Count;
  }

  return (Count);
}
/*===========================================================================
 *		End of Class Method CSString::CountChar()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CSString Method - void Delete (StartIndex, Length);
 *
 *=========================================================================*/
void CSString::Delete (const int StartIndex, const int Length) {
  int CutLength;
  int CopyLength;
  int NewLength;

	/* Ignore invalid input */
  if (StartIndex <  0) return;
  if (Length     == 0) return;
  if (StartIndex > GetLength()) return;

  CutLength = Length;
  if (CutLength < 0) CutLength = GetLength() - StartIndex;
  if (StartIndex + CutLength >= GetLength()) CutLength = GetLength() - StartIndex;

	/* Cut the string data */
  CopyLength = GetLength() - (StartIndex + CutLength);
  if (CopyLength > 0) memmove(m_pString + StartIndex, m_pString + StartIndex + CutLength, CopyLength);

  NewLength = GetLength() - CutLength;
  m_pString[NewLength] = NULL_CHAR;
  GetData()->Length    = NewLength;
}
/*===========================================================================
 *		End of Class Method CSString::Delete()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CSString Method - void Empty (void);
 *
 * Deletes the current string contents, reallocating an empty string.
 *
 *=========================================================================*/
void CSString::Empty (void) {

  FreeData();

	/* Ensure success */
  assert(GetLength() == 0);
  assert(m_pString[0] == NULL_CHAR);
 }
/*===========================================================================
 *		End of Class Method CSString::Empty()
 *=========================================================================*/


bool CSString::EndsWith (const char* pString)
{
	if (pString == NULL) return false;

	int Length = strlen(pString);
	if (Length == 0) return false;
	if (Length > GetLength()) return false;

	return strcmp(m_pString + GetLength() - Length, pString) == 0;
}


bool CSString::EndsWithI (const char* pString)
{
	if (pString == NULL) return false;

	int Length = strlen(pString);
	if (Length == 0) return false;
	if (Length > GetLength()) return false;

	return stricmp(m_pString + GetLength() - Length, pString) == 0;
}


bool CSString::StartsWith (const char* pString)
{
	if (pString == NULL) return false;

	int Length = strlen(pString);
	if (Length == 0) return false;
	if (Length > GetLength()) return false;
	
	return strncmp(m_pString, pString, Length) == 0;
}


bool CSString::StartsWithI (const char* pString)
{
	if (pString == NULL) return false;

	int Length = strlen(pString);
	if (Length == 0) return false;
	if (Length > GetLength()) return false;
	
	return strnicmp(m_pString, pString, Length) == 0;
}


/*===========================================================================
 *
 * Class CSString Method - void Escape (void);
 *
 * Encodes any special characters in the string using the format %##.
 *
 *=========================================================================*/
void CSString::Escape (void) {
  static char s_HexBytes[] = "0123456789ABCDEF";
  CSStringData* pOldData   = GetData();
  SSCHAR*       pOldString = m_pString;
  int		OldIndex;
  int		NewIndex;
  int	        OldLength  = GetLength();

	/* Ignore an empty string */
  if (OldLength == 0 || pOldString == NULL) return;

	/* Create new string copy */
  AllocCopy ((int)(OldLength*1.05) + 8);
  OldIndex = 0;
  NewIndex = 0;

  while (OldIndex < OldLength) {

		/* Reallocate output buffer if needed */
    if (NewIndex+4 >= GetData()->AllocLength) {
      CSStringData* pCurData = GetData();

      GetData()->Length = NewIndex;
      m_pString[NewIndex] = NULL_CHAR;
      AllocCopy((int)(NewIndex * 1.05) + 8);

      if (pCurData != s_pSDataNull) delete [] (byte *) pCurData;
    }

    switch (pOldString[OldIndex]) {
      case ' ':
      case '\n':
      case '\r':
      case '%':
      case '"':
      case '\'':
      case 0:
        m_pString[NewIndex + 0] = '%';
	m_pString[NewIndex + 1] = s_HexBytes[(pOldString[OldIndex]) >> 4 & 0x0F];
	m_pString[NewIndex + 2] = s_HexBytes[pOldString[OldIndex] & 0x0F];
        NewIndex += 3;
	break;
      default:
        m_pString[NewIndex] = pOldString[OldIndex];
	++NewIndex;
	break;
    }

    ++OldIndex; 
  }

  m_pString[NewIndex] = NULL_CHAR;
  GetData()->Length   = NewIndex;

	/* Free the old string data if needed */
  if (pOldData != s_pSDataNull) delete [] (byte *) pOldData;
}
/*===========================================================================
 *		End of Class Method CSString::Escape()
 *=========================================================================*/


/*===========================================================================
 *
 * Class int CSString Method - inline FindI (pString);
 *
 * Description
 *
 *=========================================================================*/
int CSString::FindI (const SSCHAR* pString) {
  if (pString == NULL || *pString == NULL_CHAR) return (-1);
  SSCHAR* pFind = stristr(m_pString, pString);
  if (pFind == NULL) return (-1);
  return (int) (pFind - m_pString);
 }
/*===========================================================================
 *		End of Class Method int CSString::FindI()
 *=========================================================================*/


int CSString::FindR (const SSCHAR* pString) 
{
	if (pString == NULL || *pString == NULL_CHAR) return -1;
	int Length = strlen(pString);
	int Index = GetLength() - Length - 1;

	while (Index >= 0)
	{
		if (m_pString[Index] == pString[0])
		{
			int j = 0;

			for (j = 1; j < Length; ++j)
			{
				if (m_pString[Index+j] != pString[j]) break;
			}

			if (j == Length) return Index;
		}

		--Index;
	}

	return -1;
 }


int CSString::FindRI (const SSCHAR* pString) 
{
	if (pString == NULL || *pString == NULL_CHAR) return -1;
	int Length = strlen(pString);
	int Index = GetLength() - Length - 1;

	while (Index >= 0)
	{
		if (tolower(m_pString[Index]) == tolower(pString[0]))
		{
			int j = 0;

			for (j = 1; j < Length; ++j)
			{
				if (tolower(m_pString[Index+j]) != tolower(pString[j])) break;
			}

			if (j == Length) return Index;
		}

		--Index;
	}
	
	return -1;
 }


/*===========================================================================
 *
 * Class CSString Method - void Format (pString, ...);
 *
 * Creates a string based on an input string and variable argument list,
 * as per sprintf(). Invalid inputs are ignored.
 *
 * Note: Passes onto the FormatV() method which does most of the work.
 *
 *=========================================================================*/
void CSString::Format (const SSCHAR* pString, ...) {
  va_list Args;

	/* Ensure valid input */
  if (pString == NULL) {
    Empty();
    return;
   }

  va_start(Args, pString);
  FormatV(pString, Args);
  va_end(Args);
 }
/*===========================================================================
 *		End of Class Method CSString::Format()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CSString Method - void FormatV (pString, Args);
 *
 * Creates a string based on an input string and variable argument list,
 * as per svprintf(). Invalid inputs are ignored.
 *
 * NOTE: Current inputs are limited to 4000 characters due to the 
 * current simplistic implementation.
 *
 *=========================================================================*/
void CSString::FormatV (const SSCHAR* pString, va_list Args) {
	SSCHAR Buffer[4048] = { 0 } ;
  int    OutputLength;

	/* Ensure valid input */
  if (pString == NULL) {
    Empty();
    return;
   }
	
  OutputLength = SSVSNPRINTF(Buffer, 4000, pString, Args);

  if (OutputLength <= 0) {
    Empty();
    return;
   }

	/* Allocate string buffer */
  if (GetLength() < OutputLength) {
    FreeData();
    AllocString(OutputLength);
   }
  
  memmove(m_pString, Buffer, OutputLength + 1);
  GetData()->Length = OutputLength;
 }
/*===========================================================================
 *		End of Class Method CSString::FormatV()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CSString Method - void FreeData (void);
 *
 *=========================================================================*/
void CSString::FreeData (void) {

  if (GetData() != s_pSDataNull) {
    SSCHAR* pStringData = (SSCHAR *) GetData();
    delete[] pStringData;
    Init();
   }

 }
/*===========================================================================
 *		End of Class Method CSString::FreeData()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CSString Method - void FreeExtra (void);
 *
 * Ensures that the allocated and string lengths are equal, removing any
 * extra allocated buffer from the end of the string.
 *
 *=========================================================================*/
void CSString::FreeExtra (void) {
  CSStringData* pData;
  int		nAllocLength;

	/* Create an allocated string the exact size of the current buffer */
  if (GetLength() != GetData()->AllocLength) {
    nAllocLength = GetLength();
    pData = (CSStringData *) new byte[sizeof(CSStringData) + (nAllocLength+1)*sizeof(SSCHAR)];
	++g_StringAllocations;

    pData->Length = GetLength();
    pData->AllocLength = nAllocLength;
    
		/* Copy the old buffer to the new then destroy the old */
    memcpy(pData->GetData(), m_pString, (GetData()->Length+1)*sizeof(SSCHAR));
    pData->GetData()[nAllocLength] = '\0';

    FreeData();
    m_pString = pData->GetData();
   }

 }
/*===========================================================================
 *		End of Class Method CSString::FreeExtra()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CSString Method - void Init (void);
 *
 * Protected class method to intialize the string at creation.
 *
 *=========================================================================*/
void CSString::Init (void) {

	/* Putting this as global causes problems sometimes */
  static const SSCHAR*  s_pSStringNull = (const SSCHAR *)(((byte*)s_pSDataNull) + sizeof(CSStringData));

  m_pString = (SSCHAR *)s_pSStringNull;
 }
/*===========================================================================
 *		End of Class Method CSString::Init()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CSString Method - int RemoveCharsToMatch (ValidCharFunc);
 *
 * Removes characters from the string that do not match the input
 * function type (isspace, isdigit, etc...). Returns the count of removed
 * characters.
 *
 *=========================================================================*/
int CSString::RemoveCharsToMatch (ISCHARFUNC ValidCharFunc) {
  int Length   = GetLength();
  int OldIndex = 0;
  int NewIndex = 0;
  int Count    = 0;

	/* Ensure a valid function */
  if (ValidCharFunc == NULL) return (0);

  while (OldIndex < Length) {
    if (ValidCharFunc(m_pString[OldIndex])) {
      m_pString[NewIndex] = m_pString[OldIndex];
      ++NewIndex;
    }
    else {
      ++Count;
    }

    ++OldIndex;
  }
  
  m_pString[NewIndex] = NULL_CHAR;
  GetData()->Length   = NewIndex;

  return (Count);
}
/*===========================================================================
 *		End of Class Method CSString::RemoveCharsToMatch()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CSString Method - int RemoveMatchingChars (BadCharFunc);
 *
 * Removes characters from the string that match the input
 * function type (isspace, isdigit, etc...). Returns the count of characters
 * removed.
 *
 *=========================================================================*/
int CSString::RemoveMatchingChars (ISCHARFUNC BadCharFunc) {
  int Length   = GetLength();
  int OldIndex = 0;
  int NewIndex = 0;
  int Count    = 0;

	/* Ensure a valid function */
  if (BadCharFunc == NULL) return (0);

  while (OldIndex < Length) {
    if (!BadCharFunc(m_pString[OldIndex])) {
      m_pString[NewIndex] = m_pString[OldIndex];
      ++NewIndex;
    }
    else {
      ++Count;
    }

    ++OldIndex;
  }
  
  m_pString[NewIndex] = NULL_CHAR;
  GetData()->Length   = NewIndex;

  return (0);
}
/*===========================================================================
 *		End of Class Method CSString::RemoveMatchingChars()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CSString Method - CSString& ReverseTruncateAtR (pString);
 *
 * Truncate the string at the first occurence of one of the characters
 * in the given string starting at the end of the string. The end of the
 * string is saved.
 *
 *=========================================================================*/
CSString& CSString::ReverseTruncateAtR (const SSCHAR* pString) 
{
	const SSCHAR*	pParse;
	SSCHAR			Char;
	int				Index;

		/* Ignore invalid input */
	if (pString == NULL)         return (*this);
	if (IsEmpty())               return (*this);
	if (pString[0] == NULL_CHAR) return (*this);
	Index = GetLength() - 1;

	while (Index >= 0) 
	{
		pParse = pString;
		Char = m_pString[Index];

		while (*pParse != NULL_CHAR) 
		{
			if (Char == *pParse) 
			{
				Delete(0, Index + 1);
				return (*this);
			}
			++pParse;
		}

		--Index;
	}

	return (*this);
}
/*===========================================================================
 *		End of Class Method CSString::ReverseTruncateAtR()
 *=========================================================================*/


CSString& CSString::ReverseTruncateAt (const SSCHAR* pString) 
{
	const SSCHAR*	pParse;
	SSCHAR			Char;
	int				Index;

		/* Ignore invalid input */
	if (pString == NULL)         return (*this);
	if (IsEmpty())               return (*this);
	if (pString[0] == NULL_CHAR) return (*this);
	Index = 0;

	while (Index < GetLength()) 
	{
		pParse = pString;
		Char = m_pString[Index];

		while (*pParse != NULL_CHAR) 
		{
			if (Char == *pParse) 
			{
				Delete(0, Index + 1);
				return (*this);
			}
			++pParse;
		}

		++Index;
	}

	return (*this);
}


CSString& CSString::ReverseTruncateAt (const SSCHAR MatchChar) 
{
	int	Index;

	if (IsEmpty()) return (*this);
	Index = 0;

	while (Index < GetLength()) 
	{

		if (m_pString[Index] == MatchChar) 
		{
			Delete(0, Index + 1);
			return (*this);
		}

		++Index;
	}

	return (*this);
}


CSString& CSString::ReverseTruncateAtR (const SSCHAR MatchChar) 
{
	int	Index;

	if (IsEmpty()) return (*this);
	Index = GetLength() - 1;

	while (Index >= 0) 
	{

		if (m_pString[Index] == MatchChar) 
		{
			Delete(0, Index + 1);
			return (*this);
		}

		--Index;
	}

	return (*this);
}


CSString& CSString::TruncateAt (const SSCHAR MatchChar)
{
	int	Index = 0;
	int Length = GetLength();

	if (IsEmpty()) return (*this);

	while (Index < Length) 
	{

		if (m_pString[Index] == MatchChar) 
		{
			Truncate(Index);
			return (*this);
		}

		++Index;
	}

	return (*this);
}


CSString& CSString::TruncateAt (const SSCHAR* pString)
{
	const SSCHAR*	pParse;
	SSCHAR			Char;
	int				Index = 0;
	int             Length = GetLength();

	if (pString == NULL)         return (*this);
	if (IsEmpty())               return (*this);
	if (pString[0] == NULL_CHAR) return (*this);

	while (Index < Length) 
	{
		pParse = pString;
		Char   = m_pString[Index];

		while (*pParse != NULL_CHAR) 
		{
			if (Char == *pParse) 
			{
				Truncate(Index);
				return (*this);
			}
			++pParse;
		}

		++Index;
	}

	return (*this);
}


CSString& CSString::TruncateAtR (const SSCHAR MatchChar)
{
	int	Index = 0;
	int Length = GetLength();

	if (IsEmpty()) return (*this);
	Index = Length - 1;

	while (Index >= 0) 
	{

		if (m_pString[Index] == MatchChar) 
		{
			Truncate(Index);
			return (*this);
		}

		--Index;
	}

	return (*this);
}


CSString& CSString::TruncateAtR (const SSCHAR* pString)
{
	const SSCHAR*	pParse;
	SSCHAR			Char;
	int				Index = 0;
	int             Length = GetLength();

	if (pString == NULL)         return (*this);
	if (IsEmpty())               return (*this);
	if (pString[0] == NULL_CHAR) return (*this);
	Index = Length - 1;

	while (Index >= 0) 
	{
		pParse = pString;
		Char   = m_pString[Index];

		while (*pParse != NULL_CHAR) 
		{
			if (Char == *pParse) 
			{
				Truncate(Index);
				return (*this);
			}
			++pParse;
		}

		--Index;
	}

	return (*this);
}


/*===========================================================================
 *
 * Class CSString Method -
 *	bool SeperateVarValue (Variable, Value, SeperatorChar, CommentChar);
 *
 * Takes the input string and attempts to seperate it into a variable/value
 * pair.  If the CommentChar is non-NULL, everything after the last comment
 * character in a line is ignored.  The string is then split into two
 * where the first SeperatorChar is found.  Whitespace is trimmed and the
 * results stored in ppVariable and ppValue.  Returns TRUE on success.
 * FALSE is returned if no variable/value pair was found (Variable then
 * is the string with no comments and whitespace trimmed).
 * ASSERTs if given invalid input. 
 *
 * Also handles values that are surrounded by double quotes ("").
 *
 * Examples:
 *	Variable = Value
 *	Variable
 *	Variable = "Value"
 *	Variable = "Value"   # Some comment
 *
 *=========================================================================*/
bool CSString::SeperateVarValue (CSString& Variable, CSString& Value, const SSCHAR SeperatorChar, const SSCHAR CommentChar) {
  const SSCHAR* pParse;
  bool          FoundSep;
  bool          FoundQuote;
  bool		IsParsing;
  int		Index;
  int		StartValue;
  int		Length;
  
	/* Ensure valid input */
  assert(SeperatorChar != NULL_CHAR);

  pParse      = m_pString;
  FoundSep    = false;
  FoundQuote  = false;
  IsParsing   = true;
  Index       = 0;
  StartValue  = -1;
  Length      = GetLength();
  
  while (IsParsing && Index < Length && *pParse != NULL_CHAR) {

    if (*pParse == SeperatorChar && !FoundSep) {
      Variable.Copy(*this, Index);
      Variable.Trim();
      FoundSep = true;
      StartValue = Index + 1;
     }
    else if (FoundSep && *pParse == '"') {
      if (FoundQuote) {
        IsParsing = false;
       }
      else {
        FoundQuote = true;
        StartValue = Index + 1;
       }
     
     }
    else if (!FoundQuote && *pParse == CommentChar) {
      IsParsing = false;
      break;
     }
       
    ++pParse;
    ++Index;
   }

  if (!FoundSep) {
    Variable = *this;
    Variable.Trim();
    Value.Empty();
    return (false);
   }
  else if (StartValue > 0) {
    if (FoundQuote)
      Value.Copy(m_pString + StartValue, Index - StartValue - 1);
    else {
      Value.Copy(m_pString + StartValue, Index - StartValue);
      Value.Trim();
     }
   }

  return (true);
 }
/*===========================================================================
 *		End of Function SeperateVarValue()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CSString Method -
 *	bool SeperateVarValueNQ (Variable, Value, SeperatorChar, CommentChar);
 *
 * Same as SeperateVarValue() but does not handle quotes.
 *
 *=========================================================================*/
bool CSString::SeperateVarValueNQ (CSString& Variable, CSString& Value, const SSCHAR SeperatorChar, const SSCHAR CommentChar) {
  const SSCHAR* pParse;
  bool          FoundSep;
  bool		IsParsing;
  int		Index;
  int		StartValue;
  int		Length;
  
	/* Ensure valid input */
  assert(SeperatorChar != NULL_CHAR);

  pParse      = m_pString;
  FoundSep    = false;
  IsParsing   = true;
  Index       = 0;
  StartValue  = -1;
  Length      = GetLength();
  
  while (IsParsing && Index < Length && *pParse != NULL_CHAR) {

    if (*pParse == SeperatorChar && !FoundSep) {
      Variable.Copy(*this, Index);
      Variable.Trim();
      FoundSep = true;
      StartValue = Index + 1;
    }
           
    ++pParse;
    ++Index;
  }

  if (!FoundSep) {
    Variable = *this;
    Variable.Trim();
    Value.Empty();
    return (false);
  }
  else if (StartValue > 0) {
    Value.Copy(m_pString + StartValue, Index - StartValue);
    Value.Trim();
  }

  return (true);
 }
/*===========================================================================
 *		End of Function SeperateVarValueNQ()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CSString Method - void SetSize (Size);
 *
 *=========================================================================*/
void CSString::SetSize (const int Size) {

  if (Size >= GetData()->AllocLength) {
    CSStringData* pData = GetData();

    AllocCopy(Size);

    assert(pData != NULL);
    assert(pData != GetData());

		/* Free the old string data */
    if (pData != s_pSDataNull) delete [] (byte *) pData;
   }
  else {
    m_pString[Size]   = NULL_CHAR;
    GetData()->Length = Size;
   }
  
 }
/*===========================================================================
 *		End of Class Method CSString::SetSize()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CSString Method - CSString& TrimLeft (void);
 *
 * Trims whitespace from the left side of the string (according to the
 * isspace() function).
 *
 *=========================================================================*/
CSString& CSString::TrimLeft (void) {
  int StringIndex = 0;

	/* Find the first non-whitespace character from left side of string */
  while (m_pString[StringIndex] != NULL_CHAR) {
    if (!isspace(m_pString[StringIndex])) break;
    StringIndex++;
   }

	/* Shift the string, if required, to remove whitespace */
  if (StringIndex != 0) {
    memmove(m_pString, m_pString + StringIndex, (GetLength() - StringIndex + 1)*sizeof(SSCHAR));
    GetData()->Length -= StringIndex;
    assert(GetLength() >= 0);
    m_pString[GetLength()] = NULL_CHAR;
   }

  assert(m_pString[GetLength()] == NULL_CHAR);
  return (*this);
 }
/*===========================================================================
 *		End of Class Method CSString::TrimLeft()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CSString Method - CSString& TrimRight (void);
 *
 * Trims whitespace from the right side of the string (according to the
 * isspace() function).
 *
 *=========================================================================*/
CSString& CSString::TrimRight (void) {
  int StringIndex = GetLength();

	/* Find the first non-whitespace character from right side of string */
  while (StringIndex != 0) {
    StringIndex--;
    if (!isspace(m_pString[StringIndex])) break;
   }

	/* Terminate the string at the last non-whitespace SSCHAR */
  if (StringIndex != GetLength()) {
    m_pString[StringIndex + 1] = NULL_CHAR;
    GetData()->Length = StringIndex + 1;
   }

  assert(m_pString[GetLength()] == NULL_CHAR);
  return (*this);
 }
/*===========================================================================
 *		End of Class Method CSString::TrimRight()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CSString Method - void Unescape (void);
 *
 * Decodes any escaped character sequences of the form %##.
 *
 *=========================================================================*/
void CSString::Unescape (void) {
  static byte s_HexValues[256] = {
	0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
	0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
	0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
	0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 0, 0, 0, 0, 0, 0,
	0,10,11,12,13,14,15, 0, 0, 0, 0, 0, 0, 0, 0, 0,
	0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
	0,10,11,12,13,14,15, 0, 0, 0, 0, 0, 0, 0, 0, 0,
	0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
	0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
	0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
	0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
	0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
	0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
	0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
	0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
	0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0	};
  int		OldIndex;
  int		NewIndex;
  int	        OldLength  = GetLength();

  	/* Ignore an empty string */
  if (OldLength == 0 || m_pString == NULL) return;

	/* Create new string copy */
  OldIndex = 0;
  NewIndex = 0;

  while (OldIndex < OldLength) {
    switch (m_pString[OldIndex]) {
      case '%':
        m_pString[NewIndex] = (s_HexValues[m_pString[OldIndex + 1]] << 4) + s_HexValues[m_pString[OldIndex + 2]];
	++NewIndex;
        OldIndex += 3;
	break;
      default:
        m_pString[NewIndex] = m_pString[OldIndex];
	++NewIndex;
        ++OldIndex;
	break;
    }
  }

  m_pString[NewIndex] = NULL_CHAR;
  GetData()->Length   = NewIndex;
  assert(NewIndex <= OldIndex);
}
/*===========================================================================
 *		End of Class Method CSString::Unescape()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CSString& CSString Method - operator= (SrcString);
 *
 * Copies the given source string to the current object.
 *
 *=========================================================================*/
CSString& CSString::operator= (const CSString& SrcString) {

  if (m_pString != SrcString.m_pString) {
    if (GetLength() < SrcString.GetLength()) {
      FreeData();
      AllocString(SrcString.GetLength());
     }

    memcpy(m_pString, (const SSCHAR*)SrcString, (SrcString.GetLength() + 1)*sizeof(SSCHAR));
    GetData()->Length = SrcString.GetLength();
   }

  return (*this);
 }
/*===========================================================================
 *		End of Class Method CSString& CSString::operator=()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CSString& CSString Method - operator= (Char);
 *
 * Creates a one character string.
 *
 *=========================================================================*/
const CSString& CSString::operator= (const SSCHAR Char) {

  if (GetLength() < 1) {
    FreeData();
    AllocString(1);
   }

  m_pString[0] = Char;
  m_pString[1] = NULL_CHAR;
  GetData()->Length = 1;
  
  return (*this);
 }
/*===========================================================================
 *		End of Class Method CSString& CSString::operator=()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CSString& CSString Method - operator= (pSrcString);
 *
 * Copies the given string buffer to the current object.  Handles the
 * NULL string case.
 *
 *=========================================================================*/
const CSString& CSString::operator= (const SSCHAR* pSrcString) {

	/* Check for the NULL string case */
  if (pSrcString == NULL) {
    FreeData();
   }
	/* Create a normally sized string */
  else {
    int Length = (int) strlen(pSrcString);

    if (GetLength() < Length) {
      FreeData(); 
      AllocString(Length);
     }

    memcpy(m_pString, pSrcString, sizeof(SSCHAR)*(Length + 1));
    GetData()->Length = Length;
   }

  return (*this);
 }
/*===========================================================================
 *		End of Class Method CSString& CSString::operator=()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CSString Method - CSString& operator+= (pString);
 *
 * Concatenates the given string to the end of the string buffer.
 * Accepts NULL string input.
 *
 *=========================================================================*/
const CSString& CSString::operator+= (const SSCHAR* pString) {
  int NewLength;

	/* Ignore NULL inputs */
  if (pString == NULL) return (*this);

	/* Ensure an allocated buffer of the correct length */
  NewLength = (int) strlen(pString);
  return Append(pString, NewLength);
 }


const CSString& CSString::Append (const SSCHAR* pString, const int Length) {
  CSStringData* pData;
  int	        OldLength;

	/* Ignore NULL inputs */
  if (pString == NULL || Length == 0) return (*this);
  OldLength = GetLength();

	/* Ensure an allocated buffer of the correct length */
  if (OldLength + Length >= GetData()->AllocLength) {
    pData = GetData();
    AllocCopy(Length + OldLength);

    assert(pData != NULL);
    assert(pData != GetData());

    memmove(m_pString + OldLength, pString, (Length)*sizeof(SSCHAR));
    m_pString[GetLength()] = NULL_CHAR;

		/* Free the old string data */
    if (pData != s_pSDataNull) delete [] (byte *) pData;
   }
  else {
    memmove(m_pString + OldLength, pString, (Length)*sizeof(SSCHAR));
    GetData()->Length += Length;
    m_pString[GetLength()] = NULL_CHAR;
   }

	/* Ensure valid output */
  assert(m_pString[GetLength()] == NULL_CHAR);
  return (*this);
 }
/*===========================================================================
 *		End of Class Method CSString::operator+=()
 *=========================================================================*/


const CSString& CSString::Prepend (const SSCHAR* pString, const int Length)
{
	CSStringData*	pData;
	int				OldLength;

	if (pString == NULL || Length <= 0) return *this;
	OldLength = GetLength();

		/* Ensure an allocated buffer of the correct length */
	if (OldLength + Length >= GetData()->AllocLength) 
	{
		pData = GetData();
		AllocCopy(Length + OldLength);

		memmove(m_pString + Length, m_pString, OldLength * sizeof(SSCHAR));
		memcpy(m_pString, pString, Length * sizeof(SSCHAR));
		GetData()->Length += Length;
		m_pString[GetLength()] = NULL_CHAR;		

			/* Free the old string data */
		if (pData != s_pSDataNull) delete [] (byte *) pData;
	}
	else 
	{
		memmove(m_pString + Length, m_pString, OldLength * sizeof(SSCHAR));
		memcpy(m_pString, pString, Length * sizeof(SSCHAR));
		GetData()->Length += Length;
		m_pString[GetLength()] = NULL_CHAR;
	}

	return *this;
}


const CSString& CSString::Prepend (const SSCHAR Char)
{
	CSStringData*	pData;
	int				OldLength;
	int				Length = 1;

	OldLength = GetLength();

		/* Ensure an allocated buffer of the correct length */
	if (OldLength + Length >= GetData()->AllocLength) 
	{
		pData = GetData();
		AllocCopy(Length + OldLength);

		memmove(m_pString + Length, m_pString, OldLength * sizeof(SSCHAR));
		m_pString[0] = Char;
		GetData()->Length += Length;
		m_pString[GetLength()] = NULL_CHAR;		

			/* Free the old string data */
		if (pData != s_pSDataNull) delete [] (byte *) pData;
	}
	else 
	{
		memmove(m_pString + Length, m_pString, OldLength * sizeof(SSCHAR));
		m_pString[0] = Char;
		GetData()->Length += Length;
		m_pString[GetLength()] = NULL_CHAR;
	}

	return *this;
}


/*===========================================================================
 *
 * Class CSString Method - CSString& operator+= (SourceString);
 *
 * Concatenates the given string to the end of the string buffer.
 * Accepts NULL string input.
 *
 *=========================================================================*/
const CSString& CSString::operator+= (const CSString& SourceString) {
  return Append(SourceString, SourceString.GetLength());
 }
/*===========================================================================
 *		End of Class Method CSString::operator+=()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CSString Method - CSString& operator+= (SourceChar);
 *
 * Concatenates the given character to the end of the string buffer.
 *
 *=========================================================================*/
const CSString& CSString::operator+= (const SSCHAR SourceChar) {

  Append(&SourceChar, 1);
  
	/* Ensure valid output */
  assert(m_pString[GetLength()] == NULL_CHAR);
  return (*this);
 }
/*===========================================================================
 *		End of Class Method CSString::operator+=()
 *=========================================================================*/


/*===========================================================================
 *
 * Function - CSString operator+ (String1, String2);
 *
 * Friend function to the CSString class to add two CSString objects.
 *
 *=========================================================================*/
CSString operator+ (const CSString& String1, const CSString& String2) {
  CSString NewString;
 	
  NewString.ConcatStrings(String1.GetLength(), (const SSCHAR*)String1,
		          String2.GetLength(), (const SSCHAR*)String2);

  return (NewString);
 }
/*===========================================================================
 *		End of Function operator+()
 *=========================================================================*/


/*===========================================================================
 *
 * Function - CSString operator+ (pString1, String2);
 *
 * Friend function to the CSString class to add a string pointer with 
 * a CSString object.
 *
 *=========================================================================*/
CSString operator+ (const SSCHAR* pString1, const CSString& String2) {
  CSString NewString;
  	
  NewString.ConcatStrings((int) SafeStrLen(pString1), pString1,
		          String2.GetLength(),  (const SSCHAR*)String2);

  return (NewString);
 }
/*===========================================================================
 *		End of Function operator+()
 *=========================================================================*/


/*===========================================================================
 *
 * Function - CSString operator+ (String1, pString2);
 *
 * Friend function to the CSString class to add a string pointer with 
 * a CSString object.
 *
 *=========================================================================*/
CSString operator+ (const CSString& String1, const SSCHAR* pString2) {
  CSString NewString;
  	
  NewString.ConcatStrings(String1.GetLength(),  (const SSCHAR*)String1,
		          (int) SafeStrLen(pString2), pString2);

  return (NewString);
 }
/*===========================================================================
 *		End of Function operator+()
 *=========================================================================*/


/*===========================================================================
 *
 * Function - CSString operator+ (String1, SSCHAR);
 *
 * Friend function to the CSString class to add a character pointer with 
 * a CSString object.
 *
 *=========================================================================*/
CSString operator+ (const CSString& String1, const SSCHAR Char2) {
  CSString NewString;
  	
  NewString.ConcatStrings(String1.GetLength(),  (const SSCHAR*)String1,
		         1,		        &Char2);

  return (NewString);
 }
/*===========================================================================
 *		End of Function operator+()
 *=========================================================================*/


/*===========================================================================
 *
 * Function - CSString operator+ (SSCHAR, String2);
 *
 * Friend function to the CSString class to add a character pointer with 
 * a CSString object.
 *
 *=========================================================================*/
CSString operator+ (const SSCHAR Char1, const CSString& String2) {
  CSString NewString;
  	
  NewString.ConcatStrings(1, &Char1, String2.GetLength(), (const SSCHAR *)String2);

  return (NewString);
 }
/*===========================================================================
 *		End of Function operator+()
 *=========================================================================*/


/*===========================================================================
 *
 * Function - size_t SafeStrLen (pString);
 *
 * Computes the length of a string as strlen().
 *
 * Inputs: 
 *	pString - nul terminated string. Can be NULL.
 *
 * Returns:
 *	Length of string in characters. Returns 0 on NULL input.	
 *
 *=========================================================================*/
size_t SafeStrLen (const SSCHAR* pString) {

  return (pString == NULL ? 0 : strlen(pString));
 }
/*===========================================================================
 *		End of Function SafeStrLen()
 *=========================================================================*/
  

/*===========================================================================
 *
 * Function - SSCHAR* stristr (pString, pSearchString);
 *
 * Same as strstr() except with case insensitivity.  Asserts if given 
 * invalid input.
 *
 * Inputs:
 *	pString: String to search in. Cannot be NULL.
 *	pSearchString: String to search for. Cannot be NULL.
 *
 * Returns:
 *	Returns NULL if the substring is not found in the string.  
 *
 *=========================================================================*/
SSCHAR* stristr (const SSCHAR* pString, const SSCHAR* pSearchString) {
  size_t StringIndex = 0;
  size_t SearchIndex = 0;

	/* Ensure valid input */
  assert(pString != NULL && pSearchString != NULL);

	/* Special case for an empty search string */
  if (*pSearchString == NULL_CHAR) return (NULL);
  
	/* The main search loop */
  while (pString[StringIndex] != NULL_CHAR) {

    if (toupper(pString[StringIndex]) == toupper(pSearchString[SearchIndex])) {
      ++SearchIndex;

      if (pSearchString[SearchIndex] == NULL_CHAR) 
        return(((SSCHAR *)pString) + StringIndex - SearchIndex + 1);
     }
    else if (SearchIndex != 0) {
      StringIndex -= SearchIndex;
      SearchIndex = 0;
     }

    ++StringIndex;
   }

	/* Nothing found... */
  return (NULL);
 }
/*===========================================================================
 *		End of Function stristr()
 *=========================================================================*/


/*=========================================================================
 *
 * Function - TCHAR *strnncpy (pDestString, pSourceString, MaxStringLegth);
 *
 * Just like the standard strncpy function but appends a NUL character
 * to the end of the destination if required.  Returns a pointer to the
 * destination string.  ASSERTs if given invalid input.
 *
 *=======================================================================*/
SSCHAR* strnncpy (SSCHAR* pDestString, const SSCHAR* pSourceString, const size_t MaxStringLength) { 
  size_t Index = 0;

	/* Ensure valid Input */
  assert(pDestString != NULL && pSourceString != NULL);
  
	/* Start copying */
  while (Index < MaxStringLength && *pSourceString != NULL_CHAR) {
    pDestString[Index] = *pSourceString;
    ++pSourceString;
    ++Index;
   }

	/* Null terminate */
  pDestString[Index] = NULL_CHAR;
  return (pDestString);
 }
/*=========================================================================
 *		End of Function strnncpy()
 *=======================================================================*/

 
/*===========================================================================
 *
 * Function - TCHAR* ltrim (TCHAR* pString);
 *
 * Strips all space characters from the left side of the given string, 
 * returning a pointer to the first non-whitespace character. 
 * Space characters include spaces, tabs and line feeds a defined by
 * the isspace() function.  ASSERTs if given invalid input.
 *
 *=========================================================================*/
SSCHAR* ltrim (SSCHAR* pString) {
  size_t Index = 0;

	/* Ensure valid input */
  assert(pString != NULL);
  
	/* Ignore any spaces or TABs until end of string */
  while (pString[Index] != '\0' && isspace(pString[Index])) {
    ++Index;
   }

	/* Return pointer to the first non-whitespace TCHAR */
  return (pString + Index);
 }
/*===========================================================================
 *		End of Function ltrim()
 *=========================================================================*/


/*===========================================================================
 *
 * Function - TCHAR* rtrim (TCHAR* pString);
 *
 * Strips all space characters from the right side of the given string, 
 * returning a pointer to the modified string.  Space characters include
 * spaces, tabs and line feeds a defined by the isspace() function.  
 * ASSERTs if given invalid input.
 *
 *=========================================================================*/
SSCHAR* rtrim (SSCHAR* pString) {
  size_t Index;

	/* Ensure valid input */
  assert(pString != NULL);

	/* Start at the end of the string */
  Index = strlen(pString);

  while (Index != 0) {
    --Index;

		/* Terminate string and return if non-whitespace found */
    if (!isspace(pString[Index])) {
      pString[Index + 1] = NULL_CHAR;
      return (pString);
     }
   }

	/* Return an empty string */
  *pString = NULL_CHAR;
  return (pString);
 }
/*===========================================================================
 *		End of Function rtrim()
 *=========================================================================*/



/*===========================================================================
 *
 * Function - bool StringToBoolean (Flag, pString);
 *
 * Atempts to convert a string to a bool TRUE/FALSE value, returning 
 * the result in the Flag referenced variable.  Returns TRUE if the
 * string was successfully parsed to a bool, or FALSE otherwise.
 * ASSERTs if passed invalid input. 
 *	1. Checks string against 'TRUE' or 'FALSE', case insensitive
 *	2. Checks string against 'YES'  or 'NO', case insensitive
 *	3. Checks for a zero/non-zero integral value. 
 *	4. If conversion to a number failed, FALSE is returned.
 *
 * See Also: StringToBoolean (TCHAR*);
 *
 *=========================================================================*/
bool StringToBoolean (bool& Flag, const SSCHAR* pString) {
  SSCHAR* pError;
  long    Result;

  	/* Make sure the string is valid */
  assert(pString != NULL);

	/* See if the string contains explicit TRUE/FALSE strings */
  if (stricmp(pString, "TRUE") == 0 || stricmp(pString, "YES") == 0) {
    Flag = true;
    return (true);
   }
  else if (stricmp(pString, "FALSE") == 0 || stricmp(pString, "NO") == 0) {
    Flag = false;
    return (true);
   }
	/* Special case for an empty string */
  else if (*pString == NULL_CHAR) {
    return (false);
   }

	/* Convert the string to a number as a last resort */
  Result = strtol(pString, &pError, 0);
  if (*pError != NULL_CHAR) return (false);

  Flag = (bool) (Result == 0) ? false : true;
  return (false);
 }


bool StringToBoolean (const SSCHAR* pString) {
  bool Flag = false;

  StringToBoolean(Flag, pString);
  return (Flag);
 }
/*===========================================================================
 *		End of Function StringToBoolean()
 *=========================================================================*/


/*===========================================================================
 *
 * Function - int SafeStringCompare (pString1, pString2, NoCase);
 *
 * A NULL aware string comparison function.
 *
 *=========================================================================*/
int SafeStringCompare (const SSCHAR* pString1, const SSCHAR* pString2, const bool NoCase) {

  if (pString1 == NULL) {
    if (pString2 == NULL) return (0);
    return (-1);
   }
  else if (pString2 == NULL) {
    return (1);
   }
 
  if (NoCase) return stricmp(pString1, pString2);
  return strcmp(pString1, pString2);
 }
/*===========================================================================
 *		End of Function SafeStringCompare()
 *=========================================================================*/


/*===========================================================================
 *
 * Function - int SplitString (SplitStrings, Buffer, SplitChar);
 *
 *=========================================================================*/
int SplitString(CSStringArray& SplitStrings, const CSString& Buffer, const char SplitChar, const bool IgnoreConsecutive)
{
	CSString*	pNewString;
	int			StartIndex = 0;
	int			EndIndex;
	int			Count = 0;

	SplitStrings.Empty();
	if (Buffer.IsEmpty()) return 0;

	do {
		EndIndex = Buffer.FindChar(SplitChar, StartIndex);
		if (EndIndex < 0) EndIndex = Buffer.GetLength();

		if (IgnoreConsecutive)
		{
			while (Buffer[EndIndex + 1] == SplitChar)
			{
				++EndIndex;
			}
		}

		pNewString = new CSString(Buffer.Mid(StartIndex, EndIndex-StartIndex));
		pNewString->Trim();
		SplitStrings.Add(pNewString);

		StartIndex = EndIndex + 1;
		++Count;
	} while (StartIndex < Buffer.GetLength()); 

	return Count;
}
/*===========================================================================
 *		End of Function SplitString()
 *=========================================================================*/
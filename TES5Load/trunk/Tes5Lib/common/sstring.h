/*===========================================================================
 *
 * File:	SString.H
 * Author:	Dave Humphrey (dave@uesp.net)
 * Created On:	Tuesday, May 08, 2001
 *
 * Contains the definition for the CSString class for handling simple
 * dynamically allocated strings.
 *
 *=========================================================================*/
#ifndef __SSTRING_H
#define __SSTRING_H


/*===========================================================================
 *
 * Begin Required Includes
 *
 *=========================================================================*/
  #include "string.h"
  #include "assert.h"
  #include "stdarg.h"
  #include "stdio.h"
  #include "srtypes.h"
  #include "srplatform.h"
  #include <locale>
  #include "srptrarray.h"
/*===========================================================================
 *		End of Required Includes
 *=========================================================================*/


/*===========================================================================
 *
 * Begin Definitions
 *
 *=========================================================================*/

	/* Number of extra bytes to allocate when creating strings */
  #define SSTRING_ALLOC_EXTRA 4

	/* Special characters */
  #define NULL_CHAR ((SSCHAR)'\0')

	/* Quickly convert a boolean to a string */
  #define BooleanToString(Flag) ((Flag) ? "true" : "false" )

/*===========================================================================
 *		End of Definitions
 *=========================================================================*/


/*===========================================================================
 *
 * Begin Type Definitions
 *
 *=========================================================================*/

	/* Private class used for storing string data */
  class CSStringData {
    public:
	int     Length;		/* Size of string in characters */
	int     AllocLength;	/* Allocated size of string in characters */
	SSCHAR*	GetData() { return (SSCHAR *)(this+1); }
   };

  typedef int (*ISCHARFUNC) ( int c );

/*===========================================================================
 *		End of Type Definitions
 *=========================================================================*/


/*===========================================================================
 *
 * Begin Class CSString Definition
 *
 * A simple class for handling strings. 
 *
 *=========================================================================*/
class CSString {

  /*---------- Begin Private Class Members ----------------------*/
private:
  SSCHAR*	m_pString;	/* The string data */


  /*---------- Begin Protected Class Methods --------------------*/
protected:

	/* Allocate string buffers of a given size */
  void AllocString (const int StringSize);
  void AllocCopy   (const int StringSize);

	/* Create a string buffer from two source strings */
  void ConcatStrings (const int String1Size, const SSCHAR* pString1,
		      const int String2Size, const SSCHAR* pString2);

	/* Free the current string data */
  void FreeData (void);

	/* Access the string data */
  CSStringData* GetData (void) const { return (((CSStringData *)m_pString) - 1); }

	/* Initializes the string data */
  void Init (void);


  /*---------- Begin Public Class Methods -----------------------*/
public:

	/* Class Constructors */
  CSString ();
  CSString (const SSCHAR* pString);
  CSString (const SSCHAR* pString, const int Length);
  CSString (const CSString& SrcString);
  CSString (const int StringSize);
  CSString (const SSCHAR Char, const int Count);

	/* Class Destructors */
  ~CSString();
  void Destroy (void);

	/* String comparison */
  int Compare       (const SSCHAR* pString) const;
  int Compare       (const SSCHAR* pString, const bool CaseSensitive) const;
  int CompareNoCase (const SSCHAR* pString) const;

	/* Copy a number of characters from source strings */
  void Copy (const SSCHAR*   pString, const int Count);
  void Copy (const CSString& String,  const int Count);

	/* Counts the occurence of the given character in the string */
  int CountChar (const SSCHAR Char);

	/* Count the number of matching characters between the two strings */
  int CountMatchLength       (const SSCHAR* pString);
  int CountMatchLengthNoCase (const SSCHAR* pString);

	/* Return the c representation of the string */
  const SSCHAR* c_str (void) const { return (m_pString); }

	/* Delete a portion of the string */
  void Delete (const int StartIndex, const int Length = -1);

	/* Empties the string contents */
  void Empty (void);

    bool EndsWith  (const char* pString);
	bool EndsWithI (const char* pString);

	bool StartsWith  (const char* pString);
	bool StartsWithI (const char* pString);
	

	/* Encode/decode */
  void Escape   (void);
  void Unescape (void);

	/* Search for sub-strings */
  int Find      (const SSCHAR* pSearch);
  int FindI     (const SSCHAR* pSearch);
  int FindR     (const SSCHAR* pSearch);
  int FindRI    (const SSCHAR* pSearch);
  int FindChar  (const SSCHAR  Char) const;
  int FindChar  (const SSCHAR  Char, const int StartIndex) const;
  int FindCharR (const SSCHAR  Char) const;

	/* Creates a string based on a printf() format */
  void Format  (const SSCHAR* pString, ...);
  void FormatV (const SSCHAR* pString, va_list Args);
  
	/* Frees any extra memory allocated for the string */
  void FreeExtra (void);

	/* Get the length, in bytes, of the string */
  int GetLength      (void) const; 
  int GetAllocLength (void) const;

	/* Checks for an empty (zero sized) string */
  bool IsEmpty (void) const;

	/* Extract sub-strings from string */
  CSString Left  (const int Count) const;
  CSString Mid   (const int Index, const int Count) const;
  CSString Mid   (const int Index) const;
  CSString Right (const int Count) const;

	/* Makes the string lower/upper case */
  void MakeLower (void);
  void MakeUpper (void);

	/* Remove a specific set of characters from the string */
  int RemoveCharsToMatch  (ISCHARFUNC ValidCharFunc);
  int RemoveMatchingChars (ISCHARFUNC BadCharFunc);

	/* Keep the end of the string before any of the characters in the given string */
  CSString& ReverseTruncateAt  (const SSCHAR* pString);
  CSString& ReverseTruncateAt  (const SSCHAR MatchChar);
  CSString& ReverseTruncateAtR (const SSCHAR* pString);
  CSString& ReverseTruncateAtR (const SSCHAR MatchChar);

  CSString& TruncateAt (const SSCHAR MatchChar);
  CSString& TruncateAt (const SSCHAR* pString);

  CSString& TruncateAtR (const SSCHAR MatchChar);
  CSString& TruncateAtR (const SSCHAR* pString);

	/* Seperate a string of the form: Variable = Value */
  bool SeperateVarValue   (CSString& Variable, CSString& Value, const SSCHAR SeperatorChar = '=', const SSCHAR CommentChar = '#');
  bool SeperateVarValueNQ (CSString& Variable, CSString& Value, const SSCHAR SeperatorChar = '=', const SSCHAR CommentChar = '#');

  	/* Set a specific character in the string */
  void SetAt (const int Index, const SSCHAR Char);

	/* Set the maximum string size */
  void SetSize      (const int Size);
  void SetSizeEmpty (const int Size) { SetSize(Size); GetData()->Length = 0; if (Size > 0) m_pString[0] = NULL_CHAR; }

	/* Trims whitespace from left/right sides of string */
  CSString& TrimLeft  (void);
  CSString& TrimRight (void);
  CSString& Trim      (void);

	/* Truncate the string at the given index */
  void Truncate (const int Index);

	/* Updates the length from the string content */
  void UpdateLength (void);

	/* Overloaded copy operators */
        CSString& operator= (const CSString& SrcString);
  const CSString& operator= (const SSCHAR     Char);
  const CSString& operator= (const SSCHAR*    pSrcString);  
  
	/* String concatenation */
  const CSString& operator+= (const CSString& String);
  const CSString& operator+= (const SSCHAR     Char);
  const CSString& operator+= (const SSCHAR*    pString);
  const CSString& Append     (const SSCHAR* pString, const int Length);

  const CSString& Prepend (const SSCHAR* pString, const int Length);
  const CSString& Prepend (const SSCHAR Char);

	/* Addition operators, friend functions */
  friend CSString operator+ (const CSString&  String1, const CSString&  String2);
  friend CSString operator+ (const SSCHAR         Char, const CSString&  String);
  friend CSString operator+ (const CSString&   String, const SSCHAR      Char);
  friend CSString operator+ (const SSCHAR*    pString1, const CSString&  String2);
  friend CSString operator+ (const CSString&  String1, const SSCHAR*     pString2);

	/* Get a specific character from the string */
  SSCHAR operator[] (const int Index) const;
  SSCHAR GetAt      (const int Index) const;

	/* Return a const pointer to the string buffer */
  operator const SSCHAR* (void) const;


 };
/*===========================================================================
 *		End of Class CSString Definition
 *=========================================================================*/


/*===========================================================================
 *
 * Begin Begin Inline CSString Methods
 *
 *=========================================================================*/


inline CSString& TerminatePathString (CSString& PathBuffer) {
  if (PathBuffer.GetLength() == 0) return (PathBuffer);
  if (PathBuffer.GetAt(PathBuffer.GetLength() - 1) != '\\') PathBuffer += '\\';
  return (PathBuffer);
 }

	/* String comparison, case sensitive, returns as per strcmp() */
inline int CSString::Compare (const SSCHAR* pString) const {
  if (pString == NULL) return 0;
  return (strcmp(m_pString, pString));
 }

inline int CSString::Compare (const SSCHAR* pString, const bool CaseSensitive) const {
  if (pString == NULL) return 0;
  return CaseSensitive ? strcmp(m_pString, pString) : stricmp(m_pString, pString);
}

	/* String comparison, case insensitive, returns as per stricmp() */
inline int CSString::CompareNoCase (const SSCHAR* pString) const {
  if (pString == NULL) return 0;
  return (stricmp(m_pString, pString));
 }

	/* Creates a new string at most Count bytes in size */
inline void CSString::Copy (const SSCHAR* pString, const int Count) {
  //int InputSize = SafeStrLen(pString);

	/* Check for special cases */
  if (Count <= 0) {
    Empty();
    return;
   }

  if (GetLength() < Count) {
    FreeData();
    AllocString(Count);
   }

  if (pString != NULL) memcpy(m_pString, pString, Count*sizeof(SSCHAR));
  m_pString[Count] = NULL_CHAR;
  GetData()->Length = Count;
  //if (InputSize < Count) GetData()->Length = InputSize;
 }


inline int CSString::CountMatchLength (const SSCHAR* pString) {
  int Length = GetLength();
  int Index  = 0;

  if (pString == NULL) return (0);

  while (*pString != NULL_CHAR && Index < Length) {
    if (m_pString[Index] != *pString) return (Index);
    ++pString;
    ++Index;
  }

  return (Index);
}


inline int CSString::CountMatchLengthNoCase (const SSCHAR* pString) {
  int Length = GetLength();
  int Index  = 0;

  if (pString == NULL) return (0);

  while (*pString != NULL_CHAR && Index < Length) {
    if (tolower(m_pString[Index]) != tolower(*pString)) return (Index);
    ++pString;
    ++Index;
  }

  return (Index);
}


inline void CSString::Copy (const CSString& String, const int Count) {
  
	/* Check for special cases */
  if (Count <= 0) {
    Empty();
    return;
   }

  if (GetLength() < Count) {
    FreeData();
    AllocString(Count);
   }

  if (String.GetLength() >= Count) {
    memcpy(m_pString, String.c_str(), Count*sizeof(SSCHAR));
   }
  else {
    memcpy(m_pString, String.c_str(), String.GetLength()*sizeof(SSCHAR));
    memset(m_pString + String.GetLength(), 0, Count - String.GetLength());
   }

  m_pString[Count] = NULL_CHAR;
  GetData()->Length = Count;
 }



inline int CSString::Find (const SSCHAR* pString) {
  if (pString == NULL || *pString == NULL_CHAR) return (-1);
  SSCHAR* pFind = strstr(m_pString, pString);
  if (pFind == NULL) return (-1);
  return (int) (pFind - m_pString);
}

inline int CSString::FindChar (const SSCHAR Char) const {
  SSCHAR* pFind = strchr(m_pString, Char);
  if (pFind == NULL) return (-1);
  return (int) (pFind - m_pString);
 }

inline int CSString::FindChar (const SSCHAR Char, const int StartIndex) const {
  if (StartIndex >= GetLength()) return -1;
  if (StartIndex <= 0) return FindChar(Char);

  SSCHAR* pFind = strchr(m_pString + StartIndex, Char);
  if (pFind == NULL) return (-1);
  return (int) (pFind - m_pString);
 }

inline int CSString::FindCharR (const SSCHAR Char) const {
  SSCHAR* pFind = strrchr(m_pString, Char);
  if (pFind == NULL) return (-1);
  return (int) (pFind - m_pString);
 }

	/* Return the current string size */
inline int CSString::GetLength (void) const { 
  return (GetData()->Length);
 }

	/* Get the current allocated size of string */
inline int CSString::GetAllocLength (void) const {
  return (GetData()->AllocLength); 
 }

	/* Returns TRUE if the string is empty, "" */
inline bool CSString::IsEmpty (void) const { 
  return ((GetLength() == 0) ? true : false); 
 }

	/* Returns a string containing the first Count characters from the
	 * left of the string object */
inline CSString CSString::Left (const int Count) const {
  int NewCount = Count;	
  if (NewCount > GetLength()) NewCount = GetLength();
  if (NewCount < 0) NewCount = 0;

  CSString NewString(m_pString, NewCount);
  return NewString;
 }

	/* Makes the string all lower/upper case */
inline void CSString::MakeLower (void) { strlwr(m_pString); }
inline void CSString::MakeUpper (void) { strupr(m_pString); }

	/* Returns a new string starting at the 0-based index of the current string */
inline CSString CSString::Mid (const int Index) const {
  int NewIndex = Index;
  if (NewIndex > GetLength()) NewIndex = GetLength();
  if (NewIndex < 0) NewIndex = 0;
  CSString NewString(m_pString + NewIndex);
  return NewString;
 }

	/* Returns a new string starting at the 0-based index of the current string 
	 * with the given length. */
inline CSString CSString::Mid (const int Index, const int Length) const {
  int NewIndex  = Index;
  int NewLength = Length;
  if (NewIndex > GetLength()) NewIndex = GetLength();
  if (NewIndex < 0) NewIndex = 0;
  if (NewLength < 0) NewLength = 0;
  if (NewLength + NewIndex > GetLength()) NewLength = GetLength() - NewIndex;

  CSString NewString(m_pString + NewIndex, NewLength);
  return NewString;
 }

	/* Returns a string containing the first Count characters from the
	 * right side of the string object */
inline CSString CSString::Right (const int Count) const {
  int NewCount = Count;
  if (NewCount > GetLength()) NewCount = GetLength();
  if (NewCount < 0) NewCount = 0;

  CSString NewString(m_pString + GetLength() - NewCount, NewCount);
  return NewString;
 }


	/* Trim whitespace from right and left sides of string */
inline CSString& CSString::Trim (void) { 
  TrimLeft(); 
  TrimRight(); 
  return (*this); 
 }

	/* Access the (const SSCHAR*) string */
inline CSString::operator const SSCHAR* (void) const {
  return (m_pString);
 }

	/* Get the specified character from the string.  ASSERTs if given an
	   invalid index (0 returns the first character in string). */
inline SSCHAR CSString::operator[] (const int Index) const {
  return GetAt(Index);
 }

	/* Same as operator[], return a specific character in string */
inline SSCHAR CSString::GetAt (const int Index) const {
  if (Index < GetLength() && Index >= 0) return (m_pString[Index]);
  return 0;
 }

	/* Sets a specific character in the string.  ASSERTs if an invalid
	 * index is given.  0 is the first character in string. */
inline void CSString::SetAt (const int Index, const SSCHAR SSCHAR) {
  if (Index < GetLength() && Index >= 0) m_pString[Index] = SSCHAR;
 }

	/* Truncate the string at the given index */
inline void CSString::Truncate (const int Index) {
  if (Index < 0 || Index >= GetLength()) return;
  m_pString[Index] = NULL_CHAR;
  GetData()->Length = Index;
 }


inline void CSString::UpdateLength (void) {
  int Length = GetAllocLength();
  int Index = 0;

  while (Index < Length) {

    if (m_pString[Index] == NULL_CHAR) {
      GetData()->Length = Index;
      return;
     }

    ++Index;
   }
 }

	/* String comparisons */
inline bool operator== (const CSString&  String1, const CSString&  String2) { return (String1.Compare(String2) == 0); }
inline bool operator== (const SSCHAR*    String1, const CSString&  String2) { return (String2.Compare(String1) == 0); }
inline bool operator== (const CSString&  String1, const SSCHAR*    String2) { return (String1.Compare(String2) == 0); }
inline bool operator!= (const CSString&  String1, const CSString&  String2) { return (String1.Compare(String2) != 0); }
inline bool operator!= (const SSCHAR*    String1, const CSString&  String2) { return (String2.Compare(String1) != 0); }
inline bool operator!= (const CSString&  String1, const SSCHAR*    String2) { return (String1.Compare(String2) != 0); }
inline bool operator<= (const CSString&  String1, const CSString&  String2) { return (String1.Compare(String2) <= 0); }
inline bool operator<= (const SSCHAR*    String1, const CSString&  String2) { return (String2.Compare(String1) >= 0); }
inline bool operator<= (const CSString&  String1, const SSCHAR*    String2) { return (String1.Compare(String2) <= 0); }
inline bool operator>= (const CSString&  String1, const CSString&  String2) { return (String1.Compare(String2) >= 0); }
inline bool operator>= (const SSCHAR*    String1, const CSString&  String2) { return (String2.Compare(String1) <= 0); }
inline bool operator>= (const CSString&  String1, const SSCHAR*    String2) { return (String1.Compare(String2) >= 0); }
inline bool operator<  (const CSString&  String1, const CSString&  String2) { return (String1.Compare(String2) <  0); }
inline bool operator<  (const SSCHAR*    String1, const CSString&  String2) { return (String2.Compare(String1) >  0); }
inline bool operator<  (const CSString&  String1, const SSCHAR*    String2) { return (String1.Compare(String2) <  0); }
inline bool operator>  (const CSString&  String1, const CSString&  String2) { return (String1.Compare(String2) >  0); }
inline bool operator>  (const SSCHAR*    String1, const CSString&  String2) { return (String2.Compare(String1) <  0); }
inline bool operator>  (const CSString&  String1, const SSCHAR*    String2) { return (String1.Compare(String2) >  0); }



/*===========================================================================
 *		End of Begin Inline CSString Methods
 *=========================================================================*/


/*===========================================================================
 *
 * Begin Function Definitions
 *
 *=========================================================================*/

	/* Computes the standard length of a string, NULL safe */
  size_t SafeStrLen(const SSCHAR* pString);

	/* Search for a substring, as strstr(), with case insensitivity */
  SSCHAR* stristr (const SSCHAR* pString, const SSCHAR* pSearchString);

	/* Safe fixed size string copy */
  SSCHAR* strnncpy (SSCHAR* pDestString, const SSCHAR* pSourceString, const size_t MaxStringLength);

	/* Trim whitespace from a fixed length string */
         SSCHAR* ltrim (SSCHAR* pString);
         SSCHAR* rtrim (SSCHAR* pString);
  inline SSCHAR* trim  (SSCHAR* pString) { return ltrim(rtrim(pString)); }

	/* Convert a string to a boolean value */
  bool StringToBoolean (bool& Flag, const SSCHAR* pString);
  bool StringToBoolean (const SSCHAR* pString); 

	/* A NULL aware string comparison function */
  int SafeStringCompare (const SSCHAR* pString1, const SSCHAR* pString2, const bool NoCase = true);

  typedef CSrPtrArray<CSString> CSStringArray;
  int SplitString(CSStringArray& SplitStrings, const CSString& Buffer, const char SplitChar, const bool IgnoreConsecutive = false);

/*===========================================================================
 *		End of Function Definitions
 *=========================================================================*/

      	         	

#endif
/*===========================================================================
 *		End of File Sstring.H
 *=========================================================================*/

/*===========================================================================
 *
 * File:	Mwrandllist.CPP
 * Author:	Dave Humphrey (uesp@m0use.net)
 * Created On:	June 13, 2003
 *
 * Description
 *
 *=========================================================================*/

	/* Include Files */
#include "mwrandllist.h"


/*===========================================================================
 *
 * Begin Local Definitions
 *
 *=========================================================================*/
  DEFINE_FILE("MwRandLList.cpp");
/*===========================================================================
 *		End of Local Definitions
 *=========================================================================*/


/*===========================================================================
 *
 * Class CMwRandLList Constructor
 *
 *=========================================================================*/
CMwRandLList::CMwRandLList () : m_LevelLists(0) {
  //DEFINE_FUNCTION("CMwRandLList::CMwRandLList()");
  m_MaxNumber = 0;
  m_InputLine = 0;
 }
/*===========================================================================
 *		End of Class Constructor
 *=========================================================================*/


/*===========================================================================
 *
 * Class CMwRandLList Method - void Destroy (void);
 *
 *=========================================================================*/
void CMwRandLList::Destroy (void) {
  //DEFINE_FUNCTION("CMwRandLList::Destroy()");
  m_MaxNumber = 0;
  m_InputLine = 0;
  m_LevelLists.Destroy();
 }
/*===========================================================================
 *		End of Class Method CMwRandLList::Destroy()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CMwRandLList Method - bool AddLevelList (pListID, Number);
 *
 * Adds a new level list to the end of the array. Returns false on any
 * error.
 *
 *=========================================================================*/
bool CMwRandLList::AddLevelList (const TCHAR* pListID, const int Number) {
  DEFINE_FUNCTION("CMwRandLList::AddLevelList()");
  mwri_levellist_t* pNewList;

	/* Create a new list object */
  CreatePointer(pNewList, mwri_levellist_t);
  m_LevelLists.Add(pNewList);

  strnncpy(pNewList->ID, pListID, MWESM_ID_MAXSIZE);
  pNewList->Number = Number;
  if (Number > m_MaxNumber) m_MaxNumber = Number;

  return (true);
 }
/*===========================================================================
 *		End of Class Method CMwRandLList::AddLevelList()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CMwRandLList Method - bool ParseLine (pLineBuffer, ppVariable, ppListID, ppNumber);
 *
 * Parses an input line to it's components. Returns true if a level list
 * record was successfully parsed.
 *
 *=========================================================================*/
bool CMwRandLList::ParseLine (TCHAR*  pLineBuffer, TCHAR** ppVariable, 
			      TCHAR** ppListID,    TCHAR** ppNumber) {
  TCHAR* pParse = trim(pLineBuffer);
  TCHAR* pStartQuote;
  bool   HasQuote = false;
  bool   QuotedID = false;
  bool   FoundVar = false;
  bool   FoundNum = false;

  *ppNumber   = NULL;
  *ppVariable = NULL;
  *ppListID   = NULL;

  while (*pParse != NULL_CHAR) {
    
    switch (*pParse) {
      case '=':
	if (!FoundVar) {
	  *pParse = NULL_CHAR;
	  *ppVariable = rtrim(pLineBuffer);
	  FoundVar = true;
	  *ppListID = ltrim(pParse + 1);
	 }
	break;
      case '"':
	if (HasQuote) {
	  HasQuote = false;

	  if (FoundVar) {
	    QuotedID = true;
	    *pParse = NULL_CHAR;
	    *ppListID = pStartQuote;
	   }
	 }
	else {
	  pStartQuote = pParse + 1;
	  HasQuote = true;
	 }
        break;
      case '#':
	if (!HasQuote) {
	  *pParse = NULL;
	  return (FoundVar);
	 }
        break;
      case ',':
	if (!HasQuote && FoundVar) {
	  *pParse = NULL;
	  if (!QuotedID) *ppListID = trim(*ppListID);
	  FoundNum = true;
	  *ppNumber = pParse + 1;
	 }	
        break;
     }

    pParse++;
   }

  return (FoundVar);
 }
/*===========================================================================
 *		End of Class Method CMwRandLList::ParseLine()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CMwRandLList Method - bool Read (pFilename);
 *
 * Read and parse a level list data file. Returns false on any error.
 *
 *=========================================================================*/
bool CMwRandLList::Read (const TCHAR* pFilename) {
  CGenFile InputFile;
  TCHAR    LineBuffer[MWRI_MAX_LINELENGTH+1];
  int      ReadResult;
  bool	   Result;
  TCHAR*   pVariable;
  TCHAR*   pList;
  TCHAR*   pNumber;

	/* Attempt to open file for input */
  Result = InputFile.Open(pFilename, "rt");
  if (!Result) return (Result);

	/* Clear the current list, if any */
  m_LevelLists.Destroy();

	/* Input and parse entire file */
  while (!InputFile.IsEOF()) {
    ReadResult = InputFile.ReadLine(LineBuffer, MWRI_MAX_LINELENGTH);
    if (ReadResult == READLINE_MSL) InputFile.ReadLine();
    m_InputLine++;

		/* Parse the input line */
    Result = ParseLine(LineBuffer, &pVariable, &pList, &pNumber);
    if (Result) AddLevelList(pList, pNumber == NULL ? 1 : atoi(pNumber));
   }

  return (false);
 }
/*===========================================================================
 *		End of Class Method CMwRandLList::Read()
 *=========================================================================*/


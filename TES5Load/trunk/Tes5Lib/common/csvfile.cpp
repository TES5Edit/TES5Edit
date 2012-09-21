/*===========================================================================
 *
 * File:	CsvFile.CPP
 * Author:	Dave Humphrey (dave@uesp.net)
 * Created On:	Thursday, October 09, 2003
 *
 * Implements a simple CSV (Comma Seperated File) class, CCsvFile.
 *
 *=========================================================================*/

	/* Include Files */
#include "csvFile.h"


/*===========================================================================
 *
 * Begin Local Definitions
 *
 *=========================================================================*/
/*===========================================================================
 *		End of Local Definitions
 *=========================================================================*/


/*===========================================================================
 *
 * Class CCsvFile Constructor
 *
 *=========================================================================*/
CCsvFile::CCsvFile () {
  m_KeepQuotes = false;
 }
/*===========================================================================
 *		End of Class CCsvFile Constructor
 *=========================================================================*/


/*===========================================================================
 *
 * Class CCsvFile Method - void Destroy (void);
 *
 *=========================================================================*/
void CCsvFile::Destroy (void) {
 
  m_Filename.Empty();
  ClearRows();
 }
/*===========================================================================
 *		End of Class Method CCsvFile::Destroy()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CCsvFile Method - CCsvRow* AddRow (void);
 *
 * Adds a new row to the end of the CSV file. Returns the new object or
 * NULL on any error.
 *
 *=========================================================================*/
CCsvRow* CCsvFile::AddRow (void) {
  CCsvRow* pRow;

  pRow = new CCsvRow;
  m_Rows.Add(pRow);

  return (pRow);
 }
/*===========================================================================
 *		End of Class Method CCsvFile::AddRow()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CCsvFile Method - void ClearRows (void);
 *
 * Deletes all defined row objects.
 *
 *=========================================================================*/
void CCsvFile::ClearRows (void) {
  m_Rows.Empty();
 }
/*===========================================================================
 *		End of Class Method CCsvFile::ClearRows()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CCsvFile Method - int FindHeaderCol (pString);
 *
 * Looks for the given string in the header column, returning the 0-based
 * column index on success or -1 otherwise. Not case-sensitive.
 *
 *=========================================================================*/
int CCsvFile::FindHeaderCol (const SSCHAR* pString) {
  CCsvRow*  pRow;
  CSString* pColString;
  dword     ColIndex;

	/* Get the header row */
  pRow = GetRow(0);
  if (pRow == NULL) return (-1);

  for (ColIndex = 0; ColIndex < pRow->GetSize(); ColIndex++) {
    pColString = pRow->GetAt(ColIndex);
    if (pColString == NULL) continue;
    if (pColString->CompareNoCase(pString) == 0) return (ColIndex);
   }

	/* No match */
  return (-1);
 }
/*===========================================================================
 *		End of Class Method CCsvFile::FindHeaderCol()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CCsvFile Method - const TCHAR* GetElement (Row, Col);
 *
 * Returns the text of the given CSV element (0-based) or NULL.
 *
 *=========================================================================*/
const SSCHAR* CCsvFile::GetElement (const dword Row, const dword Col) {
  if (!IsValidElement(Row, Col)) return (NULL);

  return (const SSCHAR *)*((m_Rows.GetAt(Row))->GetAt(Col));
 }
/*===========================================================================
 *		End of Class Method CCsvFile::GetElement()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CCsvFile Method - bool IsMissingCells (void);
 *
 * Returns true if there are any missing or empty cells in the file.
 *
 *=========================================================================*/
bool CCsvFile::IsMissingCells (void) {
  dword RowIndex;
  bool  Result;

	/* Check all rows */
  for (RowIndex = 0; RowIndex < m_Rows.GetSize(); RowIndex++) {
    Result = IsRowMissingCells(RowIndex);
    if (Result) return (true);
   }

	/* No missing/empty cells found */
  return (false);
 }
/*===========================================================================
 *		End of Class Method CCsvFile::IsMissingCells()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CCsvFile Method - bool IsRowMissingCells (RowIndex);
 *
 * Returns true if the given row has any missing or empty cells.
 *
 *=========================================================================*/
bool CCsvFile::IsRowMissingCells (const int RowIndex) {
  CCsvRow*  pRow;
  CSString* pColString;
  dword     ColIndex;

  pRow = GetRow(RowIndex);
  if (pRow == NULL) return (true);

	/* Check all columns in the row */
  for (ColIndex = 0; ColIndex < pRow->GetSize(); ColIndex++) {
    pColString = pRow->GetAt(ColIndex);
    if (pColString == NULL) return (true);
    if (pColString->IsEmpty()) return (true);
   }

  return (false);
 }
/*===========================================================================
 *		End of Class Method CCsvFile::IsRowMissingCells()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CCsvFile Method - bool IsValidElement (Row, Col);
 *
 * Returns true if the given CSV element coordinates are valid (0-based).
 *
 *=========================================================================*/
bool CCsvFile::IsValidElement (const dword Row, const dword Col) {
  if (!m_Rows.IsValidIndex(Row)) return (false);

  CCsvRow* pRow = m_Rows.GetAt(Row);
  if (pRow == NULL) return (false);
  if (!pRow->IsValidIndex(Col)) return (false);
  if (pRow->GetAt(Col) == NULL) return (false);

  return (true);
 }
/*===========================================================================
 *		End of Class Method CCsvFile::IsValidElement()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CCsvFile Method - bool Load (pFilename);
 *
 * Attempt to load and parse the given CSV file, returning false on 
 * any error. The current contents are destroyed.
 *
 *=========================================================================*/
bool CCsvFile::Load (const SSCHAR* pFilename) {
  CSrFile  File;
  CSString Buffer;
  bool     Result;
  int	   FileSize;

	/* Clear the current contents */
  Destroy();

	/* Attempt to openb the given file for input */
  Result = File.Open(pFilename, "rb");
  if (!Result) return (false);

  m_Filename = pFilename;
  FileSize = File.GetFileSize();
  Buffer.SetSize(FileSize);

	/* Read the file text */
  Result = File.Read((SSCHAR *)(const SSCHAR *)Buffer, FileSize);
  if (!Result) return (false);

	/* Parse the file text */
  Result = ParseText(Buffer, FileSize);	    

  return (true);
 }
/*===========================================================================
 *		End of Class Method CCsvFile::Load()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CCsvFile Method - bool ParseText (pBuffer, BufferSize);
 *
 * Protected class method to parse a text buffer into the CSV row/column
 * components. Returns false on any error.
 *
 *=========================================================================*/
bool CCsvFile::ParseText (const SSCHAR* pBuffer, const int BufferSize) {
  const SSCHAR*	pParse;
  const SSCHAR*	pQuoteStart;
  const SSCHAR* pRowStart;
  const SSCHAR* pColStart;
  CSString	QuoteBuffer;
  CSString	CellBuffer;
  CSString*	pNewString;
  CCsvRow*	pRow;
  bool		InQuote;
  bool		HasQuote;
  bool		EndCell;
  bool		EndRow;
  int		Index;

	/* Initialize the loop variables */
  pParse	= pBuffer;
  pQuoteStart	= NULL;
  pRowStart	= pBuffer;
  pColStart	= pBuffer;
  InQuote	= false;
  HasQuote	= false;
  EndCell	= false;
  EndRow	= false;
  Index		= 0;

	/* Create the first row */
  pRow = AddRow();

	/* Parse the entire buffer string */
  while (Index <= BufferSize) {

    switch (*pParse) {
      case CSVFILE_COLCHAR:
        if (!InQuote) EndCell = true;
	break;
      case NULL_CHAR:
        if (pParse[-1] == CSVFILE_ROWCHAR1) break;
	if (pParse[-1] == CSVFILE_ROWCHAR2) break;
      case CSVFILE_ROWCHAR2:
        EndCell = true;
	EndRow  = true;

	if (InQuote) {
	  HasQuote = true;
	  QuoteBuffer.Copy(pQuoteStart + 1, (int)(pParse - pQuoteStart - 1));
	  InQuote = false;
	 }
	break;
      case CSVFILE_QUOTECHAR:
        if (!m_KeepQuotes) {
          if (InQuote) {
	    HasQuote = true;
	    QuoteBuffer.Copy(pQuoteStart + 1, (int)(pParse - pQuoteStart - 1));
	   }
          else {
  	    QuoteBuffer.Empty();
	    pQuoteStart = pParse;
	   }

          InQuote = !InQuote;
	  break;
        }
     };

		/* Finish a cell parse */
    if (EndCell) {
      pNewString = new CSString;
      pRow->Add(pNewString);

      if (HasQuote)
        *pNewString = QuoteBuffer;
      else if (pParse != pColStart) {
        pNewString->Copy(pColStart, (int)(pParse - pColStart));
	pNewString->Trim();
       }

      HasQuote = false;
      EndCell = false;
      pColStart = pParse + 1;
     }

		/* End of a row */
    if (EndRow) {
      pRow = AddRow();

      if (pParse[1] == CSVFILE_ROWCHAR1) {
        pParse++;
        Index++;
       }

      pRowStart = pParse + 1;
      pColStart = pRowStart;
      EndRow    = false;
     }

    Index++;
    pParse++;
   }

	/* Delete the last row if it is empty */
  if (pRow->GetSize() == 0) {
    m_Rows.Delete(m_Rows.GetSize() - 1);
   } 

  return (true);
 }
/*===========================================================================
 *		End of Class Method CCsvFile::ParseText()
 *=========================================================================*/
  

/*===========================================================================
 *
 * Class CCsvFile Method - bool Save (pFilename);
 *
 * Attempts to save the csv file to the given filename. Returns false on
 * any error.
 *
 *=========================================================================*/
bool CCsvFile::Save (const SSCHAR* pFilename) {
  CSrFile   File;
  CCsvRow*  pRow;
  CSString* pString;
  dword	    RowIndex;
  dword     ColIndex;
  bool	    Result;

	/* Attempt to open the file for output */
  Result = File.Open(pFilename, "wb");
  if (!Result) return (false);
  m_Filename = pFilename;

  for (RowIndex = 0; RowIndex < m_Rows.GetSize(); RowIndex++) {
    pRow = m_Rows.GetAt(RowIndex);
    if (pRow == NULL || pRow->GetSize() == 0) continue;

    for (ColIndex = 0; ColIndex < pRow->GetSize(); ColIndex++) { 
      pString = pRow->GetAt(ColIndex);
      Result  = true;

      if (ColIndex > 0)    Result = File.Printf(",");
      if (pString != NULL) Result = File.Printf("\"%s\"", pString->c_str());
      if (!Result) return (false);
     }

    File.Printf("\n");
   } 

  return (true);
 }
/*===========================================================================
 *		End of Class Method CCsvFile::Save()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CCsvFile Method - CSString* SetString (Row, Col, pString);
 *
 * Sets the given string. Returns the new string on NULL on any error.
 *
 *=========================================================================*/
CSString* CCsvFile::SetString (const dword Row, const dword Col, const SSCHAR* pString) {
  CCsvRow*  pRow;
  CSString* pNewString;

	/* Ignore invalid input */
  if (Row < 0 || Col < 0) return (NULL);
  pRow = GetRow(Row);
 
	/* Create the row if required */
  if (pRow == NULL) {
    while (m_Rows.GetSize() <= (dword) Row) {
      pRow = AddRow();
     }
   }

	/* Create the column if required */
  pNewString = pRow->GetAt((dword)Col);
  
  if (pNewString == NULL) {
    while (pRow->GetSize() <= (dword)Col) {
      pNewString = new CSString;
      pRow->Add(pNewString);
     }
   }

	/* Set the string value */
  (*pNewString) = pString;
  return (pNewString);
 }
/*===========================================================================
 *		End of Class Method CCsvFile::SetString()
 *=========================================================================*/

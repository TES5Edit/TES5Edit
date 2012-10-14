/*===========================================================================
 *
 * File:	CsvFile.H
 * Author:	Dave Humphrey (dave@uesp.net)
 * Created On:	Thursday, October 09, 2003
 *
 * Defines a simple CSV (Comma Seperated File) class, CCsvFile.
 *
 *=========================================================================*/
#ifndef __CSVFILE_H
#define __CSVFILE_H


/*===========================================================================
 *
 * Begin Required Includes
 *
 *=========================================================================*/
  #include "srfile.h"
  #include "srptrarray.h"
  #include "sstring.h"
/*===========================================================================
 *		End of Required Includes
 *=========================================================================*/


/*===========================================================================
 *
 * Begin Definitions
 *
 *=========================================================================*/

	/* CSV file characters */
  #define CSVFILE_COLCHAR	','
  #define CSVFILE_ROWCHAR1	'\r'
  #define CSVFILE_ROWCHAR2	'\n'
  #define CSVFILE_QUOTECHAR	'"'

/*===========================================================================
 *		End of Definitions
 *=========================================================================*/


/*===========================================================================
 *
 * Begin Type Definitions
 *
 *=========================================================================*/
  
	/* Array of string objects */
  typedef CSrPtrArray<CSString> CCsvRow;

	/* Array of CSV row pointers */
  typedef CSrPtrArray<CCsvRow> CCsvRowArray;

/*===========================================================================
 *		End of Type Definitions
 *=========================================================================*/


/*===========================================================================
 *
 * Begin Class CCsvFile Definition
 *
 * For handling a simple CSV type data file.
 *
 *=========================================================================*/
class CCsvFile {

  /*---------- Begin Private Class Members ----------------------*/
private:
  CCsvRowArray	m_Rows;		/* CSV file rows */
  CSString	m_Filename;	/* The last known filename */

  bool		m_KeepQuotes;	/* Keep or parse quote files */


  /*---------- Begin Protected Class Methods --------------------*/
protected:


  /*---------- Begin Public Class Methods -----------------------*/
public:

	/* Class Constructors/Destructors */
  CCsvFile();
  virtual ~CCsvFile() { Destroy(); }
  virtual void Destroy (void);

	/* Adds a row to the end of the csv file */
  CCsvRow* AddRow (void);

  	/* Delete all row objects */
  void ClearRows (void);

	/* Find a specific column index */
  int FindHeaderCol (const SSCHAR* pString);

	/* Access a CSV element text */
  const SSCHAR* GetElement (const dword Row, const dword Col);
  CCsvRow*      GetRow     (const dword Row) { return (IsValidRow(Row) ? m_Rows.GetAt(Row) : NULL); }

	/* Get class members */
  dword		GetNumRows  (void) const { return (m_Rows.GetSize()); }
  const SSCHAR*	GetFilename (void) const { return (m_Filename); }

	/* Is the element indices valid? */
  bool IsValidElement (const dword Row, const dword Col);
  bool IsValidRow     (const dword Row) { return (m_Rows.IsValidIndex(Row)); }

	/* Check for missing/empty cells */
  bool IsMissingCells    (void);
  bool IsRowMissingCells (const int RowIndex);

	/* Attempt to load a new CSV file */
  bool Load (const SSCHAR* pFilename);

  	/* Parse a CSV text buffer */
  bool ParseText (const SSCHAR* pBuffer, const int Size);

  	/* Attempt to save the CSV file */
  bool Save (const SSCHAR* pFilename);

	/* Set a specific string */
  CSString* SetString (const dword Row, const dword Col, const SSCHAR* pString);
  
	/* Set class members */
  void SetKeepQuotes (const bool Flag) { m_KeepQuotes = Flag; }

 };
/*===========================================================================
 *		End of Class CCsvFile Definition
 *=========================================================================*/


#endif
/*===========================================================================
 *		End of File CsvFile.H
 *=========================================================================*/

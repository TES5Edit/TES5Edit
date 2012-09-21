/*===========================================================================
 *
 * File:	Srlogfile.CPP
 * Author:	Dave Humphrey (dave@uesp.net)
 * Created On:	25 November 2011
 *
 * Implements the CSrLogFile class for simple log file output.
 *
 *=========================================================================*/

	/* Include Files */
#include "srlogfile.h"
#include "time.h"


/*===========================================================================
 *
 * Begin Local Definitions
 *
 *=========================================================================*/

	/* Global system log object */
  CSrLogFile SystemLog;

/*===========================================================================
 *		End of Local Definitions
 *=========================================================================*/


/*===========================================================================
 *
 * Class CSrLogFile Constructor
 *
 *=========================================================================*/
CSrLogFile::CSrLogFile () {
  m_pFile       = NULL;
  m_OutputError = false;

  m_Callback.Function = NULL;
  m_Callback.UserData = 0;
 }
/*===========================================================================
 *		End of Class CSrLogFile Constructor
 *=========================================================================*/


/*===========================================================================
 *
 * Class CSrLogFile Constructor
 *
 *=========================================================================*/
CSrLogFile::CSrLogFile (const SSCHAR* pFilename) {
  m_pFile = NULL;
  Open(pFilename);
 }
/*===========================================================================
 *		End of Class CSrLogFile Constructor
 *=========================================================================*/


/*===========================================================================
 *
 * Class CSrLogFile Destructor
 *
 *=========================================================================*/
CSrLogFile::~CSrLogFile () {
  Close();
 }
/*===========================================================================
 *		End of Class CSrLogFile Destructor
 *=========================================================================*/


/*===========================================================================
 *
 * Class CSrLogFile Method - void Destroy (void);
 *
 * Delete object contents.
 *
 *=========================================================================*/
void CSrLogFile::Destroy (void) {
  Close();

  m_Callback.Function = NULL;
  m_Callback.UserData = 0;
 }
/*===========================================================================
 *		End of Class Method CSrLogFile::Destroy()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CSrLogFile Method - void Close (void);
 *
 * Closes an open log file.
 *
 *=========================================================================*/
void CSrLogFile::Close (void) {

  if (m_pFile != NULL) {
    Printf("Log file closed.");
    fclose(m_pFile);
    m_pFile = NULL;
   }

 }
/*===========================================================================
 *		End of Class Method CSrLogFile::Close()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CSrLogFile Method - bool Open (pFilename);
 *
 * Opens a new log file for output. Returns false on any error.
 *
 *=========================================================================*/
bool CSrLogFile::Open (const SSCHAR* pFilename) {

	/* Ensure an open file is closed first */
  Close();

	/* Open file for output */
  m_pFile = fopen(pFilename, "wt");
  if (m_pFile == NULL) return (false);

	/* Write initial log entries */
  fprintf(m_pFile, "=========================== OPENED LOG %s ===========================\n", pFilename);
  WriteTime();
  fprintf(m_pFile, " - Current Date: ");
  WriteDate();
  fprintf(m_pFile, "\n");

  return (true);
 }
/*===========================================================================
 *		End of Class Method CSrLogFile::Open()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CSrLogFile Method - void Printf (pString, ...);
 *
 * Output a string to the log file in a standard printf() format. Calls
 * PrintfV() which does most of the output work.
 *
 *=========================================================================*/
void CSrLogFile::Printf (const SSCHAR* pString, ...) {
  va_list Args;

	/* Ignore invalid input */
  if (pString == NULL) return;

  va_start(Args, pString);
  PrintfV(pString, Args);
  va_end(Args);
 }
/*===========================================================================
 *		End of Class Method CSrLogFile::Printf()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CSrLogFile Method - void ErrPrintf (pString, ...);
 *
 * Used to print an error message to the log file. Same as Printf() except
 * any callbacks are not called..
 *
 *=========================================================================*/
void CSrLogFile::ErrPrintf (const SSCHAR* pString, ...) {
  va_list Args;

	/* Ignore invalid input */
  if (pString == NULL) return;
  m_OutputError = true;

  va_start(Args, pString);
  PrintfV(pString, Args);
  va_end(Args);

  m_OutputError = false;
 }
/*===========================================================================
 *		End of Class Method CSrLogFile::ErrPrintf()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CSrLogFile Method - void PrintfV (pString, Args);
 *
 * Output a string to the log file in a standard printf() format.
 *
 *=========================================================================*/
void CSrLogFile::PrintfV (const SSCHAR* pString, va_list Args) {

	/* Ignore invalid input and object states */
  if (pString == NULL) return;
  if (!IsOpen()) return;

	/* Output the log entry */
  WriteHeader();
  vfprintf (m_pFile, pString, Args);
  fprintf (m_pFile, "\n");
  fflush (m_pFile);

  if (m_Callback.Function != NULL && !m_OutputError) {
    m_Callback.Function(pString, Args, m_Callback.UserData);
   }
 }
/*===========================================================================
 *		End of Class Method CSrLogFile::PrintfV()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CSrLogFile Method - void WriteHeader (void);
 *
 * Protected class method that outputs a standard log line header.
 *
 *=========================================================================*/
void CSrLogFile::WriteHeader (void) {
  WriteTime();
  fprintf(m_pFile, " - ");
 }
/*===========================================================================
 *		End of Class Method CSrLogFile::WriteHeader()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CSrLogFile Method - void WriteDate (void);
 *
 * Outputs the current data to the log file in the format:
 *
 *	"Thursday, 06 of April, 2006"
 *
 *=========================================================================*/
void CSrLogFile::WriteDate (void) {
  char       DateString[33] = "";
  struct tm* pCurrentTime;
  time_t     Today;
	
	/* Ensure the log file is currently open */
  if (!IsOpen()) return;

	/* Get the current Date and convert it to local time */
  time(&Today);
  pCurrentTime = localtime(&Today); 
  if (pCurrentTime == NULL) return;

	/* Output the date line to the file */
  strftime(DateString, 32, "%A, %d of %B, %Y", pCurrentTime);
  fprintf(m_pFile, "%s", DateString);
 }
/*===========================================================================
 *		End of Class Method CSrLogFile::WriteDate()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CSrLogFile Method - void WriteTime (void);
 *
 * Outputs the current time to the log file in the format:
 *
 *	"HH:MM:SS (clock ticks)"
 *
 *=========================================================================*/
void CSrLogFile::WriteTime (void) {
  char       TimeString[17] = "";
  time_t     CurrentTime;
  struct tm* pToday;

	/* Ignore if not open */
  if (!IsOpen()) return;
	
	/* Get the current local time and ensure its valid */
  time(&CurrentTime);                
  pToday = localtime(&CurrentTime);
  if (pToday == NULL) return;

	/* Output the formatted time to log file */
  strftime(TimeString, 16, "%H:%M:%S", pToday);
  fprintf (m_pFile, "%s (%ld)", TimeString, clock());
 }
/*===========================================================================
 *		End of Class Method CSrLogFile::WriteTime()
 *=========================================================================*/

/*===========================================================================
 *
 * File:	Oberrorhandler.CPP
 * Author:	Dave Humphrey (dave@uesp.net)
 * Created On:	April 5, 2006
 *
 * Implements the CSrErrorHandler class used to record library errors.
 *
 *=========================================================================*/

	/* Include Files */
#include "stdlib.h"
#include "srerrorhandler.h"
#include "srlogfile.h"
#include "windows.h"


/*===========================================================================
 *
 * Begin Local Definitions
 *
 *=========================================================================*/

	/* The global error handler object */
  CSrErrorHandler  g_SrErrorHandler;
  CSrErrorHandler* SrErrorHandler = &g_SrErrorHandler;

/*===========================================================================
 *		End of Local Definitions
 *=========================================================================*/


/*===========================================================================
 *
 * Class CSrErrorHandler Constructor
 *
 *=========================================================================*/
CSrErrorHandler::CSrErrorHandler () {
  m_NumRecords   = 0;
  m_NumCallbacks = 0;

 }
/*===========================================================================
 *		End of Class CSrErrorHandler Constructor
 *=========================================================================*/


/*===========================================================================
 *
 * Class CSrErrorHandler Destructor
 *
 *=========================================================================*/
CSrErrorHandler::~CSrErrorHandler () {
  DeleteErrors();
 }
/*===========================================================================
 *		End of Class CSrErrorHandler Destructor
 *=========================================================================*/


/*===========================================================================
 *
 * Class CSrErrorHandler Method - void Destroy (void);
 *
 * Clears the contents of the object.
 *
 *=========================================================================*/
void CSrErrorHandler::Destroy (void) {
  DeleteErrors();
  m_NumCallbacks = 0;
 }
/*===========================================================================
 *		End of Class Method CSrErrorHandler::Destroy()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CSrErrorHandler Method - bool AddCallback (Function, UserData);
 *
 * Attempts to add the callback to the error handler.
 *
 *=========================================================================*/
bool CSrErrorHandler::AddCallback (FNSRERRORCALLBACK Function, const dword UserData) {

  if (m_NumCallbacks > SR_MAX_ERROR_CALLBACKS) return (false);

  m_Callbacks[m_NumCallbacks].Function = Function;
  m_Callbacks[m_NumCallbacks].UserData = UserData;

  ++m_NumCallbacks;
  return (true);
 }
/*===========================================================================
 *		End of Class Method CSrErrorHandler::AddCallback()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CSrErrorHandler Method - void AddErrorV (Type, Code, SubCode, Level, pString, ...);
 *
 * Adds a new error to the end of the array.
 *
 *=========================================================================*/
void CSrErrorHandler::AddError (const int Type, const int Code, const int SubCode, 
				const int Level, const SSCHAR* pString, ...) {
  va_list Args;

  va_start(Args, pString);
  AddErrorV(Type, Code, SubCode, Level, pString, Args);
  va_end(Args);
 }
/*===========================================================================
 *		End of Class Method CSrErrorHandler::AddErrorV()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CSrErrorHandler Method - void AddErrorV (Type, Code, SubCode, Level, pString, Args);
 *
 * Adds a new error to the end of the array.
 *
 *=========================================================================*/
void CSrErrorHandler::AddErrorV (const int Type, const int Code, const int SubCode,
				 const int Level, const SSCHAR* pString, va_list Args) {

	/* Free old errors as needed */
  if (m_NumRecords >= SR_MAX_ERRORS) DeleteHalf();

  m_pRecords[m_NumRecords] = new CSrError;
  ++m_NumRecords;

  if (m_MsgPrefix.IsEmpty()) {
    CSString Buffer(m_MsgPrefix);
    Buffer += pString;
    m_pRecords[m_NumRecords - 1]->CreateV(Type, Code, SubCode, Level, Buffer, Args);
  }
  else
    m_pRecords[m_NumRecords - 1]->CreateV(Type, Code, SubCode, Level, pString, Args);

	/* Output log message */
  SystemLog.ErrPrintf("*** %s ***", m_pRecords[m_NumRecords - 1]->GetErrorTypeString().c_str());
  SystemLog.ErrPrintf("               Code = %d (%d)", Code, SubCode);
  SystemLog.ErrPrintf("              Level = %s", m_pRecords[m_NumRecords - 1]->GetErrorLevelString().c_str());
  SystemLog.ErrPrintf("       User Message = %s", m_pRecords[m_NumRecords - 1]->GetErrorMessage());
  SystemLog.ErrPrintf("        Description = %s", m_pRecords[m_NumRecords - 1]->GetErrorString().c_str());

	/* Call any registered callback functions */
  DoCallbacks(m_pRecords[m_NumRecords - 1]);
 }
/*===========================================================================
 *		End of Class Method CSrErrorHandler::AddErrorV()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CSrErrorHandler Method - void DeleteErrors (void);
 *
 * Protected class method to delete all currently stored errors.
 *
 *=========================================================================*/
void CSrErrorHandler::DeleteErrors (void) {
  dword Index;

  for (Index = 0; Index < m_NumRecords; ++Index) {
    delete m_pRecords[Index];
   }

  m_NumRecords = 0;
 }
/*===========================================================================
 *		End of Class Method CSrErrorHandler::DeleteErrors()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CSrErrorHandler Method - void DeleteHalf (void);
 *
 * Protected class method that ensures there is at least SR_MAX_ERRORS/2
 * free records. Deletes the oldest records to make room as needed.
 *
 *=========================================================================*/
void CSrErrorHandler::DeleteHalf (void) {
  dword HalfCount = SR_MAX_ERRORS / 2;
  dword Index;

	/* Ignore if there aren't enough records yet */
  if (m_NumRecords <= HalfCount) return;

	/* Delete some of the older records */
  for (Index = 0; Index < m_NumRecords - HalfCount; ++Index) {
    delete m_pRecords[Index];
    m_pRecords[Index] = NULL;
   }

	/* Shift array to compensate for deleted records */
  for (Index = 0; Index < HalfCount; ++Index) {
    m_pRecords[Index] = m_pRecords[m_NumRecords - HalfCount + Index];
   }

  m_NumRecords = HalfCount;
 }
/*===========================================================================
 *		End of Class Method CSrErrorHandler::DeleteHalf()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CSrErrorHandler Method - void DoCallbacks (pError);
 *
 * Calls any registered callbacks for the given error.
 *
 *=========================================================================*/
void CSrErrorHandler::DoCallbacks (CSrError* pError) {
  dword Index;

  for (Index = 0; Index < m_NumCallbacks; ++Index) {
    m_Callbacks[Index].Function(pError, m_Callbacks[Index].UserData);
   }

 }
/*===========================================================================
 *		End of Class Method CSrErrorHandler::DoCallbacks()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CSrErrorHandler Method - bool RemoveCallback (Function);
 *
 *=========================================================================*/
bool CSrErrorHandler::RemoveCallback (FNSRERRORCALLBACK Function) {
  dword Index;

  for (Index = 0; Index < m_NumCallbacks; ++Index) {
    if (m_Callbacks[Index].Function == Function) {
      memmove(m_Callbacks + Index, m_Callbacks + Index + 1, sizeof(srerror_callback_t) * (m_NumCallbacks - Index - 1)); 
      --m_NumCallbacks;
      return (true);
     }
   }

  return (false);
 }
/*===========================================================================
 *		End of Class Method CSrErrorHandler::RemoveCallback()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CSrErrorHandler Method - void RemoveLastError (void);
 *
 * Removes the last error that occurred from the list (if any). 
 *
 *=========================================================================*/
void CSrErrorHandler::RemoveLastError (void) {

  if (m_NumRecords > 0) {
    delete m_pRecords[m_NumRecords - 1];
    --m_NumRecords;
   }

 }
/*===========================================================================
 *		End of Class Method CSrErrorHandler::RemoveLastError()
 *=========================================================================*/


/*===========================================================================
 *
 * Function - bool AddSrSystemError (pString, ...);
 *
 * Add the last system error. Returns false so it can be used in the 
 * following manner:
 *
 *	if (SomethingWrong) return AddObSystemError("Message");
 *
 *=========================================================================*/
bool AddSrSystemError (const SSCHAR* pString, ...) {
  va_list Args;
  int     ErrorCode = errno;

  va_start(Args, pString);
  SrErrorHandler->AddErrorV(SRERR_TYPE_SYSTEM, ErrorCode, 0, SRERR_LEVEL_ERROR, pString, Args);
  va_end(Args);

  return (false);
 }
/*===========================================================================
 *		End of Function AddSrSystemError()
 *=========================================================================*/


/*===========================================================================
 *
 * Function - bool AddSrUserError (Code, pString, ...);
 *
 * Add a user defined error. Returns false.
 *
 *=========================================================================*/
bool AddSrUserError (const int Code, const SSCHAR* pString, ...) {
  va_list Args;
  
  va_start(Args, pString);
  SrErrorHandler->AddErrorV(SRERR_TYPE_USER, Code, 0, SRERR_LEVEL_ERROR, pString, Args);
  va_end(Args);

  return (false);
 }
/*===========================================================================
 *		End of Function AddSrUserError()
 *=========================================================================*/


/*===========================================================================
 *
 * Function - bool AddSrGeneralError (pString, ...);
 *
 * Add a user defined error. Returns false.
 *
 *=========================================================================*/
bool AddSrGeneralError (const SSCHAR* pString, ...) {
  va_list Args;
  
  va_start(Args, pString);
  SrErrorHandler->AddErrorV(SRERR_TYPE_GENERAL, -1, 0, SRERR_LEVEL_ERROR, pString, Args);
  va_end(Args);

  return (false);
 }
/*===========================================================================
 *		End of Function AddSrGeneralError()
 *=========================================================================*/


/*===========================================================================
 *
 * Function - bool AddSrZLibError (const int Code, const SSCHAR* pString = NULL, ...);
 *
 * Adds a new zLib error. Returns false.
 *
 *=========================================================================*/
bool AddSrZLibError (const int Code, const SSCHAR* pString, ...) {
  va_list Args;
  
  va_start(Args, pString);
  SrErrorHandler->AddErrorV(SRERR_TYPE_ZLIB, Code, errno, SRERR_LEVEL_ERROR, pString, Args);
  va_end(Args);

  return (false);
 }
/*===========================================================================
 *		End of Function AddSrZLibError()
 *=========================================================================*/
 

/*===========================================================================
 *
 * Function - bool AddSrWindowsError (const SSCHAR* pString, ...);
 *
 * Adds the last recorded windows error message.
 *
 *=========================================================================*/
bool AddSrWindowsError (const SSCHAR* pString, ...) {
  va_list Args;
  dword   Code = GetLastError();
  
  va_start(Args, pString);
  SrErrorHandler->AddErrorV(SRERR_TYPE_WINDOWS, Code, 0, SRERR_LEVEL_ERROR, pString, Args);
  va_end(Args);

  return (false);
}
/*===========================================================================
 *		End of Function AddSrWindowsError()
 *=========================================================================*/

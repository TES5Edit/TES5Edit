/*===========================================================================
 *
 * File:	Oberror.CPP
 * Author:	Dave Humphrey (dave@uesp.net)
 * Created On:	April 5, 2006
 *
 * Implements the library error handler class and related functions.
 *
 *=========================================================================*/

	/* Include Files */
#include "srerror.h"
#include "zlib/zlib.h"
#include "windows.h"


/*===========================================================================
 *
 * Begin Local Definitions
 *
 *=========================================================================*/

	/* List of user defined error messages */
  srerruser_t g_UserErrors[SR_MAX_USER_ERRORS + 1];
  int         g_NumUserErrors = 0;

/*===========================================================================
 *		End of Local Definitions
 *=========================================================================*/


/*===========================================================================
 *
 * Class CSrError Constructor
 *
 *=========================================================================*/
CSrError::CSrError () {
  m_Type    = SRERR_TYPE_NONE;
  m_Code    = 0;
  m_SubCode = 0;
  m_Tag     = 0;
  m_Level   = SRERR_LEVEL_NONE;

 }
/*===========================================================================
 *		End of Class CSrError Constructor
 *=========================================================================*/


/*===========================================================================
 *
 * Class CSrError Destructor
 *
 *=========================================================================*/
CSrError::~CSrError () {
 }
/*===========================================================================
 *		End of Class CSrError Destructor
 *=========================================================================*/


/*===========================================================================
 *
 * Class CSrError Method - void Destroy (void);
 *
 * Clear class contents.
 *
 *=========================================================================*/
void CSrError::Destroy (void) {

  m_Type    = SRERR_TYPE_NONE;
  m_Code    = 0;
  m_SubCode = 0;
  m_Tag     = 0;
  m_Level   = SRERR_LEVEL_NONE;

  m_Message.Empty();
 }
/*===========================================================================
 *		End of Class Method CSrError::Destroy()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CSrError Method - void AddSystemError (Code, Level, pString, ...);
 *
 * Sets a new system level error. Input string message can be NULL.
 *
 *=========================================================================*/
void CSrError::AddSystemError (const int Code, const int Level, const SSCHAR* pString, ...) {
  va_list Args;

  va_start(Args, pString);
  CreateV(SRERR_TYPE_SYSTEM, Code, 0, Level, pString, Args);  
  va_end(Args);
 }
/*===========================================================================
 *		End of Class Method CSrError::AddSystemError()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CSrError Method - void Create (Type, Code, SubCode, Level, pString, ...);
 *
 * Creates an error with the given values. The input pString can be NULL.
 *
 *=========================================================================*/
void CSrError::Create (const int Type, const int Code, const int SubCode, 
		       const int Level, const SSCHAR* pString, ...) {
  va_list Args;

  va_start(Args, pString);
  CreateV(Type, Code, SubCode, Level, pString, Args);  
  va_end(Args);
 }
/*===========================================================================
 *		End of Class Method CSrError::Create()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CSrError Method - void Create (Type, Code, SubCode, Level, pString, Args);
 *
 * Creates an error with the given values. The error message is created
 * from the given string and argument list. The string can be NULL.
 *
 *=========================================================================*/
void CSrError::CreateV (const int Type, const int Code, const int SubCode, 
			const int Level, const SSCHAR* pString, va_list Args) {

	/* Set the basic error properties */
  m_Type    = Type;
  m_Code    = Code;
  m_SubCode = SubCode;
  m_Level   = Level;

	/* Set the error message if required */
  if (pString != NULL) {
    m_Message.FormatV(pString, Args);
   }
  else {
    m_Message.Empty();
   }
  
 }
/*===========================================================================
 *		End of Class Method CSrError::CreateV()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CSrError Method - CSString GetErrorLevelString (void);
 *
 * Returns a string descriping the error level.
 *
 *=========================================================================*/
CSString CSrError::GetErrorLevelString (void) {
  CSString Buffer;

  switch (m_Level) { 
    case SRERR_LEVEL_NONE:
        Buffer.Format("No Level (%d)", m_Level);
	break;
    case SRERR_LEVEL_NOTE:
        Buffer.Format("Note (%d)", m_Level);
	break;
    case SRERR_LEVEL_WARNING:
	Buffer.Format("Warning (%d)", m_Level);
	break;
    case SRERR_LEVEL_ERROR:
	Buffer.Format("Error (%d)", m_Level);
	break;
    case SRERR_LEVEL_CRITICAL:
	Buffer.Format("Critical (%d)", m_Level);
	break;
    default:
	Buffer.Format("Unknown (%d)", m_Level);
	break;
   }

  return (Buffer);
 }
/*===========================================================================
 *		End of Class Method CSrError::GetErrorLevelString()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CSrError Method - CSString GetErrorTypeString (void);
 *
 * Returns a string descriping the error type.
 *
 *=========================================================================*/
CSString CSrError::GetErrorTypeString (void) {
  CSString Buffer;

  switch (m_Type) { 
    case SRERR_TYPE_NONE:
        Buffer.Format("No Error Type Defined (%d)", m_Type);
	break;
    case SRERR_TYPE_USER:
        Buffer.Format("User Defined Error (%d)", m_Type);
	break;
    case SRERR_TYPE_SYSTEM:
	Buffer.Format("System Error (%d)", m_Type);
	break;
    case SRERR_TYPE_GENERAL:
	Buffer.Format("General Error (%d)", m_Type);
	break;
    case SRERR_TYPE_ZLIB:
	Buffer.Format("zLib Error (%d)", m_Type);
	break;
    case SRERR_TYPE_WINDOWS:
	Buffer.Format("Windows Error (%d)", m_Type);
	break;
    default:
        Buffer.Format("Undefined Error (%d)", m_Type);
	break;
   }

  return (Buffer);
 }
/*===========================================================================
 *		End of Class Method CSrError::GetErrorTypeString()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CSrError Method - CSString GetErrorString (void);
 *
 * Finds are returns the error description string. 
 *
 *=========================================================================*/
CSString CSrError::GetErrorString (void) {
  CSString Buffer;
  
  switch (m_Type) {

    case SRERR_TYPE_GENERAL:
	return Buffer;

    case SRERR_TYPE_USER:
	return GetUserErrorString(m_Code);

    case SRERR_TYPE_SYSTEM:
	return GetSystemErrorString(m_Code);

    case SRERR_TYPE_ZLIB:
	return GetZLibErrorString(m_Code, m_SubCode);

    case SRERR_TYPE_WINDOWS:
	return GetWindowsErrorString(m_Code);

    case SRERR_TYPE_NONE:
    default:
        Buffer.Format("Unknown error type %d. Error code %d (%d).", m_Type, m_Code, m_SubCode);
        return (Buffer);
   };

 }
/*===========================================================================
 *		End of Class Method CSrError::GetErrorString()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CSrError Method - CSString GetUserErrorString (Code);
 *
 * Get a description for the given user defined error code. Static class method.
 *
 *=========================================================================*/
CSString CSrError::GetUserErrorString (const int Code) {
  return GetSrUserErrorString(Code);
 }
/*===========================================================================
 *		End of Class Method CSrError::GetUserErrorString()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CSrError Method - CSString GetWindowsErrorString (Code);
 *
 * Get a description for the given Windows error code. Static class method.
 *
 *=========================================================================*/
CSString CSrError::GetWindowsErrorString (const int Code) {
  CSString Buffer;
  DWORD    Result;

  Buffer.SetSize(256);
  Result = FormatMessage(FORMAT_MESSAGE_FROM_SYSTEM, NULL, Code, 0, (char *)Buffer.c_str(), 250, NULL);

  if (Result == 0) Buffer.Format("Error message string for Windows error %d!", Code); 
  return Buffer;
}
/*===========================================================================
 *		End of Class Method CSrError::GetWindowsErrorString()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CSrError Method - CSString GetSystemErrorString (Code);
 *
 * Get a description for the given system error code. Static class method.
 *
 *=========================================================================*/
CSString CSrError::GetSystemErrorString (const int Code) {
  CSString Buffer;
  char*    pResult;

  pResult = strerror(Code);

  if (pResult == NULL) {
    Buffer.Format("Unknown system error code %d!", Code);
   }
  else {
    Buffer = pResult;
   }

  return (Buffer);
 }
/*===========================================================================
 *		End of Class Method CSrError::GetSystemErrorString()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CSrError Method - CSString GetZLibErrorString (Code, SubCode);
 *
 * Returns an error string based on a zlib error code.
 *
 *=========================================================================*/
CSString CSrError::GetZLibErrorString (const int Code, const int SubCode) {
  CSString Buffer;

  switch (Code) {
    case Z_OK:
	Buffer = "No zLib error!";
	break;
    case Z_STREAM_END: 
	Buffer = "zLib end of stream!";
	break;
    case Z_NEED_DICT:
	Buffer = "zLib dictionary error!";
	break;
    case Z_ERRNO: 
	Buffer = GetSystemErrorString(SubCode);
	break;
    case Z_STREAM_ERROR:  
	Buffer = "zLib stream error!";
	break;
    case Z_DATA_ERROR:  
	Buffer = "zLib data error!";
	break;
    case Z_MEM_ERROR:  
	Buffer = "zLib memory error!";
	break;
    case Z_BUF_ERROR:  
	Buffer = "zLib buffer error!";
	break;
    case Z_VERSION_ERROR:  
	Buffer = "zLib version error!";
	break;
    default: 
	Buffer.Format("Unknown zLib error code %d!", Code);
	break;
   }

  return (Buffer);
 }
/*===========================================================================
 *		End of Class Method CSrError::GetZLibErrorString()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CSrError Method - CSString MakeErrorMessage (void);
 *
 * Make and return a nice error string. Basic format is:
 *
 *	User message
 *		Specific Error description (if available)
 *
 *=========================================================================*/
CSString CSrError::MakeErrorMessage (void) {
  CSString Result;

	/* Special case for general error messages */
  if (m_Type == SRERR_TYPE_GENERAL) {
    Result = m_Message;
   }
  else if (m_Message.IsEmpty()) {
    Result = GetErrorString();
   }
  else {
    Result.Format("%s\n     %s", m_Message.c_str(), GetErrorString().c_str());
   }

  return (Result);
 }
/*===========================================================================
 *		End of Class Method CSrError::MakeErrorMessage()
 *=========================================================================*/


/*===========================================================================
 *
 * Function - void CreateSrUserErrorDef (Code, pMessage);
 *
 * Adds a user defined error description.
 *
 *=========================================================================*/
void CreateSrUserErrorDef (const int Code, const SSCHAR* pMessage) {

	/* Ensure array has enough room */
  if (g_NumUserErrors >= SR_MAX_USER_ERRORS) return;

  g_UserErrors[g_NumUserErrors].Code    = Code;
  g_UserErrors[g_NumUserErrors].Message = pMessage;

  ++g_NumUserErrors;
 }
/*===========================================================================
 *		End of Function CreateSrUserErrorDef()
 *=========================================================================*/


/*===========================================================================
 *
 * Function - void CreateSrDefaultUserErrors (void);
 *
 * Adds the default list of user errors. Should only be called once at
 * program startup.
 *
 *=========================================================================*/
void CreateSrDefaultUserErrors (void)
{
  CreateSrUserErrorDef(SRERR_USER_NULL,     "Invalid NULL input received!");
  CreateSrUserErrorDef(SRERR_USER_BADINPUT, "Invalid input received!");
  CreateSrUserErrorDef(SRERR_USER_NOTOPEN,  "File not open!");
  CreateSrUserErrorDef(SRERR_USER_OVERFLOW, "General numeric overflow!");
  CreateSrUserErrorDef(SRERR_USER_EOF,      "End of File reached!");
  CreateSrUserErrorDef(SRERR_USER_MAXINDEX, "Maximum fixed array size reached!");
  
  CreateSrUserErrorDef(SRERR_USER_SUBRECNOTFOUND, "A required subrecord was not found in the record!");
  CreateSrUserErrorDef(SRERR_USER_BADEFFECT,      "The given effect was not found in the enchantment!");
}
/*===========================================================================
 *		End of Function CreateSrDefaultUserErrors()
 *=========================================================================*/


/*===========================================================================
 *
 * Function - CSString GetSrUserErrorString (Code);
 *
 * Attempts to find the given user error string. Returns a default message
 * if the error is not found.
 *
 *=========================================================================*/
CSString GetSrUserErrorString (const int Code) {
  static bool s_Init = false;
  int Index;

	/* Ensure the user errors are initialized */
  if (!s_Init) {
    s_Init = true;
    CreateSrDefaultUserErrors();
   }

  for (Index = 0; Index < g_NumUserErrors; ++Index) {
    if (Code == g_UserErrors[Index].Code) return g_UserErrors[Index].Message;
   }

	/* No match found...create default message */
  CSString Buffer;
  Buffer.Format("No user error matching code %d was found!", Code);
  return (Buffer);
 }
/*===========================================================================
 *		End of Function GetSrUserErrorString()
 *=========================================================================*/

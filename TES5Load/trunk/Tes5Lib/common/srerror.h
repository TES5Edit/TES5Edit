/*===========================================================================
 *
 * File:	Srerror.H
 * Author:	Dave Humphrey (dave@uesp.net)
 * Created On:	25 November 2011
 *
 * Contains a simple error handler for recording library errors occuring
 * during program execution.
 *
 *=========================================================================*/
#ifndef __SRERROR_H
#define __SRERROR_H


/*===========================================================================
 *
 * Begin Required Includes
 *
 *=========================================================================*/
  #include "sstring.h"
/*===========================================================================
 *		End of Required Includes
 *=========================================================================*/


/*===========================================================================
 *
 * Begin Definitions
 *
 *=========================================================================*/

	/* Default error types */
  #define SRERR_TYPE_NONE	0	/* None or unknown type */
  #define SRERR_TYPE_USER	1	/* Standard user defined errors */
  #define SRERR_TYPE_SYSTEM	2	/* errno */
  #define SRERR_TYPE_GENERAL	3	/* General error, no error code */
  #define SRERR_TYPE_ZLIB	4	/* zLib library error */
  #define SRERR_TYPE_WINDOWS	5	/* Windows specific error */

	/* Error level/severity. Higher values means more important */
  #define SRERR_LEVEL_NONE	0
  #define SRERR_LEVEL_NOTE	2
  #define SRERR_LEVEL_WARNING	5
  #define SRERR_LEVEL_ERROR	8
  #define SRERR_LEVEL_CRITICAL	10

	/* Standard user defined error codes */
  #define SRERR_USER_NULL	1	/* Null received when it is not valid */
  #define SRERR_USER_BADINPUT	2	/* General bad input */
  #define SRERR_USER_NOTOPEN	3	/* File not open for input/output */
  #define SRERR_USER_OVERFLOW   4	/* General overflow condition */
  #define SRERR_USER_EOF        5	/* End of file reached */
  #define SRERR_USER_MAXINDEX   6	/* Max index reached in a fixed array */

	/* Skyrim specific errors */
  #define SRERR_USER_SUBRECNOTFOUND 1001	/* A required subrecord was not found in the record */
  #define SRERR_USER_BADEFFECT      1002	/* The given effect was not found in the enchantment */
  
	/* Number of user defined errors allowed (arbitrary) */
  #define SR_MAX_USER_ERRORS	100

/*===========================================================================
 *		End of Definitions
 *=========================================================================*/


/*===========================================================================
 *
 * Begin Type Definitions
 *
 *=========================================================================*/

	/* Used to hold user defined error descriptions */
  struct srerruser_t {
	int	 Code;
	CSString Message;
   };

/*===========================================================================
 *		End of Type Definitions
 *=========================================================================*/


/*===========================================================================
 *
 * Begin Class CSrError Definition
 *
 * Defines a single error/warning/note record.
 *
 *=========================================================================*/
class CSrError {

  /*---------- Begin Protected Class Members --------------------*/
protected:
  int		m_Type;		/* Type of error (DOS, Windows, etc...) */

  int		m_Code;		/* Main error code (depends on type) */
  int		m_SubCode;	/* Addition error code (if any) */

  int		m_Level;	/* Severity of the error (higher means more important) */

  CSString	m_Message;	/* User supplied error message */

  int		m_Tag;		/* Custom data */
  


  /*---------- Begin Protected Class Methods --------------------*/
protected:


  /*---------- Begin Public Class Methods -----------------------*/
public:

	/* Class Constructors/Destructors */
  CSrError();
  virtual ~CSrError();
  virtual void Destroy (void);

	/* Create a new system error message */
  void AddSystemError (const int Code, const int Level, const SSCHAR* pString, ...);

	/* Generic error creation methods */
  void Create  (const int Type, const int Code, const int SubCode, const int Level, const SSCHAR* pString, ...);
  void CreateV (const int Type, const int Code, const int SubCode, const int Level, const SSCHAR* pString, va_list Args);
  
	/* Get class members */
  int GetType    (void) const { return (m_Type); }
  int GetCode    (void) const { return (m_Code); }
  int GetSubCode (void) const { return (m_SubCode); }
  int GetLevel   (void) const { return (m_Level); }
  int GetTag     (void) const { return (m_Tag); }

  const SSCHAR* GetErrorMessage (void) const { return (m_Message); }

	/* Find the specific error description string */
  CSString GetErrorString      (void);
  CSString GetErrorTypeString  (void);
  CSString GetErrorLevelString (void);

	/* Make a nice error message description string */
  CSString MakeErrorMessage (void);

	/* Get error message code strings */
  static CSString GetUserErrorString    (const int Code);
  static CSString GetSystemErrorString  (const int Code);
  static CSString GetZLibErrorString    (const int Code, const int SubCode);
  static CSString GetWindowsErrorString (const int Code);

	/* Set class members */
  void SetType (const int Type)  { m_Type = Type; }
  void SetTag  (const int Value) { m_Tag  = Value; }
  

 };
/*===========================================================================
 *		End of Class CSrError Definition
 *=========================================================================*/


/*===========================================================================
 *
 * Begin Function Definitions
 *
 *=========================================================================*/

	/* User defined error functions */
  void     CreateSrUserErrorDef      (const int Code, const SSCHAR* pMessage);
  void     CreateSrDefaultUserErrors (void); 
  CSString GetSrUserErrorString      (const int Code);

/*===========================================================================
 *		End of Function Definitions
 *=========================================================================*/


#endif
/*===========================================================================
 *		End of File SrError.H
 *=========================================================================*/


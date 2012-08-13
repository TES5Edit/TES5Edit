/*===========================================================================
 *
 * File:	SRerrorhandler.H
 * Author:	Dave Humphrey (dave@uesp.net)
 * Created On:	25 November 2011
 *
 * Defines the CSrErrorHandler class for recording library errors.
 *
 *=========================================================================*/
#ifndef __SRERRORHANDLER_H
#define __SRERRORHANDLER_H


/*===========================================================================
 *
 * Begin Required Includes
 *
 *=========================================================================*/
  #include "srerror.h"

	/* Platform specific includes */  
#ifdef _WIN32
#else
  #include "sys/errno.h"
#endif

/*===========================================================================
 *		End of Required Includes
 *=========================================================================*/


/*===========================================================================
 *
 * Begin Definitions
 *
 *=========================================================================*/
	
	/* Number of error records saved at any one time (arbitrary) */
  #define SR_MAX_ERRORS	32

	/* Number of callbacks allowed at one time */
  #define SR_MAX_ERROR_CALLBACKS 10

/*===========================================================================
 *		End of Definitions
 *=========================================================================*/


/*===========================================================================
 *
 * Begin Type Definitions
 *
 *=========================================================================*/

	/* Error callbacks */
  typedef void (*FNSRERRORCALLBACK) (CSrError* pError, const dword UserData);

  struct srerror_callback_t {
	dword		  UserData;
	FNSRERRORCALLBACK Function;
   };

/*===========================================================================
 *		End of Type Definitions
 *=========================================================================*/


/*===========================================================================
 *
 * Begin Class CSrErrorHandler Definition
 *
 * A simple error handler for recording errors occuring during this
 * libraries execution.
 *
 *=========================================================================*/
class CSrErrorHandler {

  /*---------- Begin Protected Class Members --------------------*/
protected:

	/* Use a very simple array of pointers for storing errors */
  CSrError*		m_pRecords[SR_MAX_ERRORS];
  dword			m_NumRecords;		

  srerror_callback_t	m_Callbacks[SR_MAX_ERROR_CALLBACKS];
  dword			m_NumCallbacks;

  CSString		m_MsgPrefix;
  

  /*---------- Begin Protected Class Methods --------------------*/
protected:

	/* Helper method to clear the array */
  void DeleteErrors (void);
  void DeleteHalf   (void);

	/* Perform any required callbacks for he given error */
  void DoCallbacks (CSrError* pError);


  /*---------- Begin Public Class Methods -----------------------*/
public:

	/* Class Constructors/Destructors */
  CSrErrorHandler();
  virtual ~CSrErrorHandler();
  virtual void Destroy (void);

	/* Attempt to add a an error callback function */
  bool AddCallback (FNSRERRORCALLBACK Function, const dword UserData);

	/* General add error methods */
  void AddError  (const int Type, const int Code, const int SubCode, const int Level, const SSCHAR* pString, ...);
  void AddErrorV (const int Type, const int Code, const int SubCode, const int Level, const SSCHAR* pString, va_list Args);

	/* Clear all errors */
  void ClearErrors (void) { DeleteErrors(); }

	/* Get class members */
  CSrError* GetError     (const dword Index) { return ((Index < m_NumRecords) ? m_pRecords[Index]: NULL); }
  CSrError* GetLastError (void)              { return ((m_NumRecords > 0) ? m_pRecords[m_NumRecords - 1]: NULL); }
  dword     GetNumErrors (void) const        { return (m_NumRecords); }

	/* Remove a previously set callback */
  bool RemoveCallback (FNSRERRORCALLBACK Function);

	/* Removes the last error, if any, from the list */
  void RemoveLastError (void);

	/* Set class members */
  void SetMessagePrefix (const char* pString) { m_MsgPrefix = pString; }

};
/*===========================================================================
 *		End of Class CSrErrorHandler Definition
 *=========================================================================*/


/*===========================================================================
 *
 * Begin Global Definitions
 *
 *=========================================================================*/

	/* The global error handler object (must be valid) */
  extern CSrErrorHandler* SrErrorHandler;

  bool AddSrUserError    (const int Code, const SSCHAR* pString = NULL, ...);
  bool AddSrSystemError  (const SSCHAR* pString = NULL, ...);
  bool AddSrZLibError    (const int Code, const SSCHAR* pString = NULL, ...);
  bool AddSrGeneralError (const SSCHAR* pString = NULL, ...);
  bool AddSrWindowsError (const SSCHAR* pString = NULL, ...);


/*===========================================================================
 *		End of Global Definitions
 *=========================================================================*/


#endif
/*===========================================================================
 *		End of File Srerrorhandler.H
 *=========================================================================*/


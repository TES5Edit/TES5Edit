/*===========================================================================
 *
 * File:	Srlogfile.H
 * Author:	Dave Humphrey (dave@uesp.net)
 * Created On:	25 November 2011
 *
 * Defines the CSrLogFile class for simple debug log output.
 *
 *=========================================================================*/
#ifndef __SRLOGFILE_H
#define __SRLOGFILE_H


/*===========================================================================
 *
 * Begin Required Includes
 *
 *=========================================================================*/
  #include "stdarg.h"
  #include "stdio.h"
  #include "srtypes.h"
/*===========================================================================
 *		End of Required Includes
 *=========================================================================*/


/*===========================================================================
 *
 * Begin Definitions
 *
 *=========================================================================*/

	/* Quickly test values in debug builds */
#ifdef _DEBUG
  #define TEST_INTVALUE(Variable, Value) { if ((Variable) != (Value)) { SystemLog.Printf("%s != %d (%d)", #Variable, Value, Variable); } }
  #define TEST_INTVALUE1(Variable, Value, Data) { if ((Variable) != (Value)) { SystemLog.Printf("%s != %d (%d), %s", #Variable, Value, Variable, #Data); } }
  #define TEST_2INTVALUE1(Variable, Value1, Value2, Data) { if ((Variable) != (Value1) && (Variable) != (Value2)) { SystemLog.Printf("%s != %d && != %d (%d), %s", #Variable, Value1, Value2, Variable, #Data); } }
#else
  #define TEST_INTVALUE(Variable, Value) 
  #define TEST_INTVALUE1(Variable, Value, Data) 
  #define TEST_2INTVALUE1(Variable, Value1, Value2, Data) 
#endif

/*===========================================================================
 *		End of Definitions
 *=========================================================================*/


/*===========================================================================
 *
 * Begin Type Definitions
 *
 *=========================================================================*/

	/* Error callbacks */
  typedef void (*FNSRLOGCALLBACK) (const SSCHAR* pString, va_list Args, const dword UserData);

  struct srlog_callback_t {
	dword		  UserData;
	FNSRLOGCALLBACK Function;
   };

/*===========================================================================
 *		End of Type Definitions
 *=========================================================================*/


/*===========================================================================
 *
 * Begin Class CSrLogFile Definition
 *
 * A very simple log file class useful for outputting debuging messages
 * to a text file.
 *
 * Note that this is not derived from CSrFile on purpose. We don't need or
 * want the extra functionality of that class, especially error handler.
 *
 *=========================================================================*/
class CSrLogFile {

  /*---------- Begin Private Class Members ----------------------*/
private:
  FILE*			m_pFile;
  bool			m_OutputError;

  srlog_callback_t	m_Callback;


  /*---------- Begin Protected Class Methods --------------------*/
protected:

	/* Helper output methods */
  void WriteHeader (void);


  /*---------- Begin Public Class Methods -----------------------*/
public:

	/* Class Constructors/Destructors */
  CSrLogFile();
  CSrLogFile(const SSCHAR* pFilename);
  virtual ~CSrLogFile();
  virtual void Destroy (void);

	/* Close an opened log file */
  void Close (void);

	/* Check object state */
  bool IsOpen (void) const { return (m_pFile != NULL); }

	/* Attempt to open a log file for output */
  bool Open (const SSCHAR* pFilename);

	/* Output log entries */
  void ErrPrintf (const SSCHAR* pString, ...);
  void Printf    (const SSCHAR* pString, ...);
  void PrintfV   (const SSCHAR* pString, va_list Args);

  	/* Set a log callback function */
  void SetCallback (FNSRLOGCALLBACK Function, const dword UserData) { m_Callback.Function = Function; m_Callback.UserData = UserData; }

	/* Helper output methods */
  void WriteDate (void);
  void WriteTime (void);

 };
/*===========================================================================
 *		End of Class CSrLogFile Definition
 *=========================================================================*/


/*===========================================================================
 *
 * Begin Global Definitions
 *
 *=========================================================================*/

	/* Global system log object */
  extern CSrLogFile SystemLog;

/*===========================================================================
 *		End of Global Definitions
 *=========================================================================*/


#endif
/*===========================================================================
 *		End of File Oblogfile.H
 *=========================================================================*/

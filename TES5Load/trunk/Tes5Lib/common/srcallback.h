/*===========================================================================
 *
 * File:	Srcallback.H
 * Author:	Dave Humphrey (dave@uesp.net)
 * Created On:	25 November 2011
 *
 * Defines the CSrCallback class used for a variety of callback purposes.
 *
 *=========================================================================*/
#ifndef __SRCALLBACK_H
#define __SRCALLBACK_H


/*===========================================================================
 *
 * Begin Required Includes
 *
 *=========================================================================*/
  #include "srerrorhandler.h"
/*===========================================================================
 *		End of Required Includes
 *=========================================================================*/


/*===========================================================================
 *
 * Begin Definitions
 *
 *=========================================================================*/

	/* Callback return values */
  #define SRCALLBACK_USERABORT    -2
  #define SRCALLBACK_ERROR	  -1
  #define SRCALLBACK_OK		   0
  #define SRCALLBACK_WARNING	   1
  #define SRCALLBACK_NOFUNCTION	   2
  #define SRCALLBACK_NOTPROCESSED  3
  #define SRCALLBACK_INVALIDINPUT  4

/*===========================================================================
 *		End of Definitions
 *=========================================================================*/


/*===========================================================================
 *
 * Begin Type Definitions
 *
 *=========================================================================*/

	/* Forward class definition */
  class CSrCallback;

	/* Callback function definition */
  typedef int (*SRCALLBACK_FUNC) (CSrCallback* pCallback);

/*===========================================================================
 *		End of Type Definitions
 *=========================================================================*/


/*===========================================================================
 *
 * Begin Class CSrCallback Definition
 *
 * A general purpose callback implementation.
 *
 *=========================================================================*/
class CSrCallback {

  /*---------- Begin Protected Class Members --------------------*/
protected:
  SRCALLBACK_FUNC	m_Function;		/* The callback function */

  bool			m_Enabled;		/* Sets whether to use the callback or not */

  CSString		m_Title;		/* Various default callback texts */
  CSString		m_Label;
  bool			m_UpdateTitle;
  bool			m_UpdateLabel;

  void*			m_pUserPtr;		/* User defined data */
  long			m_UserData;			

  int64			m_TotalRecords;		/* Used to compute percent complete */
  int64			m_ProcessRecords;
  int64			m_LastCallbackRecords;	/* Last time the callback was called */

  int64			m_TotalRecords1;		
  int64			m_ProcessRecords1;
  int64			m_LastCallbackRecords1;

  int64			m_CallbackInterval;	/* How often the callback is called */
  

  /*---------- Begin Protected Class Methods --------------------*/
protected:


  /*---------- Begin Public Class Methods -----------------------*/
public:

	/* Class Constructors/Destructors */
  CSrCallback();
  void Destroy (void);

	/* Get class members */
  void*         GetUserPtr        (void) { return (m_pUserPtr); }
  long          GetUserData       (void) { return (m_UserData); }
  int64         GetTotalRecords   (void) { return (m_TotalRecords); }
  int64         GetProcessRecords (void) { return (m_ProcessRecords); }
  float         GetPercentDone    (void);
  const SSCHAR* GetTitle          (void) { return (m_Title); }
  const SSCHAR* GetLabel          (void) { return (m_Label); }
  bool		GetUpdateTitle    (void) { return (m_UpdateTitle); }
  bool		GetUpdateLabel    (void) { return (m_UpdateLabel); }

	/* Check if the callback object is valid or not */
  bool IsValid (void) { return (m_Function != NULL && m_Enabled); }

	/* Reset the callback progress */
  void Reset (void);
  
	/* Set class members */
  void SetUserData         (const long       Data) { m_UserData = Data; }
  void SetUserPtr          (      void*     pData) { m_pUserPtr = pData; }
  void SetFunction         (SRCALLBACK_FUNC  Func) { m_Function = Func; }
  void SetEnable           (const bool      Value) { m_Enabled  = Value; }
  void SetUpdateTitle      (const bool      Value) { m_UpdateTitle = Value; }
  void SetUpdateLabel      (const bool      Value) { m_UpdateLabel = Value; }
  void SetCallbackInterval (const int64     Value) { m_CallbackInterval = Value; }
  void SetTotalRecords     (const int64     Value) { m_TotalRecords     = Value; }
  void SetTotalRecords1    (const int64     Value) { m_TotalRecords1    = Value; }
  void SetLabel	           (const SSCHAR* pString, ...);
  void SetTitle	           (const SSCHAR* pString, ...);

	/* Update the callback if required */
  int ForceCallback   (const int64 ProcessRecords);
  int UpdateCallback  (const int64 ProcessRecords);
  int UpdateCallback1 (const int64 ProcessRecords);

};
/*===========================================================================
 *		End of Class CSrCallback Definition
 *=========================================================================*/


#endif
/*===========================================================================
 *		End of File SRcallback.H
 *=========================================================================*/

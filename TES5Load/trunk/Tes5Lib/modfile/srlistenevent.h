/*===========================================================================
 *
 * File:		Srlistenevent.H
 * Author:		Dave Humphrey (dave@uesp.net)
 * Created On:	26 November 2011
 *
 * Defines the CSrListenEvent class.
 *
 *=========================================================================*/
#ifndef __SRLISTENEVENT_H
#define __SRLISTENEVENT_H


/*===========================================================================
 *
 * Begin Required Includes
 *
 *=========================================================================*/
   #include "records/srrecord.h"
   #include "../common/srptrarray.h"
/*===========================================================================
 *		End of Required Includes
 *=========================================================================*/


/*===========================================================================
 *
 * Begin Definitions
 *
 *=========================================================================*/

	/* Event types */
  #define SR_EVENT_NONE			0
  #define SR_EVENT_ADDRECORD		1
  #define SR_EVENT_CLEANRECORD		2
  #define SR_EVENT_UPDATERECORD		4
  #define SR_EVENT_PREUPDATERECORD	8

  #define SR_EVENTMASK_ALL	0xffff

	/* Return codes */
  #define SR_EVENT_RESULT_ERROR		-1
  #define SR_EVENT_RESULT_OK		0
  #define SR_EVENT_RESULT_WARNING	1

	/* Event flags */
  #define SR_EVENTFLAG_NOCLOSEPREUPDATE	1
  #define SR_EVENTFLAG_NONOTIFYSOURCE	2
  
/*===========================================================================
 *		End of Definitions
 *=========================================================================*/


/*===========================================================================
 *
 * Begin Type Definitions
 *
 *=========================================================================*/

	/* Class forward definition */
  //class ISrListener;

/*===========================================================================
 *		End of Type Definitions
 *=========================================================================*/


/*===========================================================================
 *
 * Begin Class CSrListenEvent Definition
 *
 *=========================================================================*/
class CSrListenEvent {

  /*---------- Begin Protected Class Members --------------------*/
protected:
  CSrRecord*	m_pOldRecord;
  CSrRecord*	m_pNewRecord;
  dword			m_Type;
  dword			m_Flags;

  long          m_Source;


  /*---------- Begin Protected Class Methods --------------------*/
protected:


  /*---------- Begin Public Class Methods -----------------------*/
public:

	/* Class Constructors/Destructors */
  CSrListenEvent() {
	m_pOldRecord = NULL;
	m_pNewRecord = NULL;
	m_Type       = SR_EVENT_NONE;
	m_Flags	     = 0;
	m_Source     = 0;
  }

	/* Get class members */
  CSrRecord*   GetOldRecord (void) { return (m_pOldRecord); }
  CSrRecord*   GetNewRecord (void) { return (m_pNewRecord); }
  dword        GetType      (void) { return (m_Type); }
  dword        GetFlags     (void) { return (m_Flags); }
  long         GetSource    (void) { return (m_Source); }

	/* Check flag values */
  bool IsFlagNoClosePreUpdate (void) { return ((m_Flags & SR_EVENTFLAG_NOCLOSEPREUPDATE) != 0); }
  bool IsFlagNoNotifySource   (void) { return ((m_Flags & SR_EVENTFLAG_NONOTIFYSOURCE)   != 0); }

	/* Set class members */
  void SetOldRecord (CSrRecord* pRecord) { m_pOldRecord = pRecord; }
  void SetNewRecord (CSrRecord* pRecord) { m_pNewRecord = pRecord; }
  void SetType      (const dword   Type) { m_Type       = Type; }  
  void SetFlags     (const dword  Flags) { m_Flags      = Flags; }
  void SetSource    (const long     Src) { m_Source     = Src; }

};

	/* Arrays of events */
  typedef CSrPtrArray<CSrListenEvent>    CSrEventArray;
  typedef CSrRefPtrArray<CSrListenEvent> CSrRefEventArray;

/*===========================================================================
 *		End of Class CSrListenEvent Definition
 *=========================================================================*/


#endif
/*===========================================================================
 *		End of File Srlistenevent.H
 *=========================================================================*/


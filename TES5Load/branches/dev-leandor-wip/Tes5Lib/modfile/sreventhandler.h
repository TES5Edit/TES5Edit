/*===========================================================================
 *
 * File:		Sreventhandler.H
 * Author:		Dave Humphrey (dave@uesp.net)
 * Created On:	26 November 2011
 *
 * Defines the CSrEventHandler class.
 *
 *=========================================================================*/
#ifndef __SREVENTHANDLER_H
#define __SREVENTHANDLER_H


/*===========================================================================
 *
 * Begin Required Includes
 *
 *=========================================================================*/
  #include "srlistener.h"
/*===========================================================================
 *		End of Required Includes
 *=========================================================================*/


/*===========================================================================
 *
 * Begin Class CSrEventHandler Definition
 *
 *=========================================================================*/
class CSrEventHandler {

  /*---------- Begin Protected Class Members --------------------*/
protected:
  CSrRefListenerArray	m_Listeners;
  CSrEventArray			m_QueuedEvents;


  /*---------- Begin Protected Class Methods --------------------*/
protected:


  /*---------- Begin Public Class Methods -----------------------*/
public:

	/* Class Constructors/Destructors */
  CSrEventHandler();
  virtual ~CSrEventHandler() { Destroy(); }
  virtual void Destroy (void);

	/* Add/remove a listener */
  void AddListener    (ISrListener* pListener) { if (pListener != NULL) m_Listeners.Add(pListener); }
  void RemoveListener (ISrListener* pListener) { m_Listeners.Delete(pListener); }

	/* Combine any similar queued events */
  void CombineQueuedEvents (void); 

	/* Queue an event to send later */
  void QueueEvent (CSrListenEvent* pEvent) { if (pEvent != NULL) m_QueuedEvents.Add(pEvent); }

	/* Send an event immediately */
  void SendEvent          (CSrListenEvent* pEvent);
  void SendAddEvent       (CSrRecord* pNewRecord, CSrRecord* pOldRecord, const dword Flags = 0);
  void SendCleanEvent     (CSrRecord* pNewRecord, CSrRecord* pOldRecord, const dword Flags = 0);
  void SendUpdateEvent    (CSrRecord* pNewRecord, CSrRecord* pOldRecord, const dword Flags = 0);
  void SendPreUpdateEvent (CSrRecord* pRecord, const dword Flags = 0, long Source = 0);
  
        /* Send all queued events */
  void SendQueuedEvents (void);


};
/*===========================================================================
 *		End of Class CSrEventHandler Definition
 *=========================================================================*/


#endif
/*===========================================================================
 *		End of File Sreventhandler.H
 *=========================================================================*/

/*===========================================================================
 *
 * File:		Sreventhandler.CPP
 * Author:		Dave Humphrey (dave@uesp.net)
 * Created On:	26 November 2011
 *
 * Description
 *
 *=========================================================================*/

	/* Include Files */
#include "sreventhandler.h"


/*===========================================================================
 *
 * Class CSrEventHandler Constructor
 *
 *=========================================================================*/
CSrEventHandler::CSrEventHandler () 
{
}
/*===========================================================================
 *		End of Class CSrEventHandler Constructor
 *=========================================================================*/


/*===========================================================================
 *
 * Class CSrEventHandler Method - void Destroy (void);
 *
 *=========================================================================*/
void CSrEventHandler::Destroy (void) 
{
  m_QueuedEvents.Destroy();
  m_Listeners.Destroy();
}
/*===========================================================================
 *		End of Class Method CSrEventHandler::Destroy()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CSrEventHandler Method - void CombineQueuedEvents (void);
 *
 * Combine all similar queued events.
 *
 *=========================================================================*/
void CSrEventHandler::CombineQueuedEvents (void) 
{
  /* TODO? */
}
/*===========================================================================
 *		End of Class Method CSrEventHandler::CombineQueuedEvents()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CSrEventHandler Method - void SendEvent (pEvent);
 *
 *=========================================================================*/
void CSrEventHandler::SendEvent (CSrListenEvent* pEvent) {
  ISrListener*	pListener;
  dword			Index;

	/* Ignore invalid input */
  if (pEvent == NULL) return;

  for (Index = 0; Index < m_Listeners.GetSize(); ++Index) {
    pListener = m_Listeners[Index];

    if ((pEvent->GetType() & pListener->GetListenEvents()) != 0) {
       switch (pEvent->GetType()) {
         case SR_EVENT_ADDRECORD:	pListener->OnListenAddRecord(pEvent);       break;
		 case SR_EVENT_CLEANRECORD:	pListener->OnListenCleanRecord(pEvent);     break;
		 case SR_EVENT_UPDATERECORD:	pListener->OnListenUpdateRecord(pEvent);    break;
		 case SR_EVENT_PREUPDATERECORD:	pListener->OnListenPreUpdateRecord(pEvent); break;
		 default: assert(false); break;
       }
    }
  }

}
/*===========================================================================
 *		End of Class Method CSrEventHandler::SendEvent()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CSrEventHandler Method - void SendQueuedEvents (void);
 *
 * Send all queued events to listeners.
 *
 *=========================================================================*/
void CSrEventHandler::SendQueuedEvents (void) 
{
  dword Index;

  for (Index = 0; Index < m_QueuedEvents.GetSize(); ++Index) 
  {
    SendEvent(m_QueuedEvents[Index]);
  }

  m_QueuedEvents.Destroy();
}
/*===========================================================================
 *		End of Class Method CSrEventHandler::SendQueuedEvents()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CSrEventHandler Method - void SendAddEvent (pNewRecord, pOldRecord, Flags);
 *
 *=========================================================================*/
void CSrEventHandler::SendAddEvent (CSrRecord* pNewRecord, CSrRecord* pOldRecord, const dword Flags) 
{
  CSrListenEvent Event;

  Event.SetType(SR_EVENT_ADDRECORD);
  Event.SetNewRecord(pNewRecord);
  Event.SetOldRecord(pOldRecord);
  Event.SetFlags(Flags);

  SendEvent(&Event);
}
/*===========================================================================
 *		End of Class Method CSrEventHandler::SendAddEvent()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CSrEventHandler Method - void SendCleanEvent (pNewRecord, pOldRecord, Flags);
 *
 *=========================================================================*/
void CSrEventHandler::SendCleanEvent (CSrRecord* pNewRecord, CSrRecord* pOldRecord, const dword Flags) 
{
  CSrListenEvent Event;

  Event.SetType(SR_EVENT_CLEANRECORD);
  Event.SetNewRecord(pNewRecord);
  Event.SetOldRecord(pOldRecord);
  Event.SetFlags(Flags);

  SendEvent(&Event);
}
/*===========================================================================
 *		End of Class Method CSrEventHandler::SendCleanEvent()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CSrEventHandler Method - void SendUpdateEvent (pNewRecord, pOldRecord, Flags);
 *
 *=========================================================================*/
void CSrEventHandler::SendUpdateEvent (CSrRecord* pNewRecord, CSrRecord* pOldRecord, const dword Flags) 
{
  CSrListenEvent Event;

  Event.SetType(SR_EVENT_UPDATERECORD);
  Event.SetNewRecord(pNewRecord);
  Event.SetOldRecord(pOldRecord);
  Event.SetFlags(Flags);

  SendEvent(&Event);
}
/*===========================================================================
 *		End of Class Method CSrEventHandler::SendUpdateEvent()
 *=========================================================================*/
 

/*===========================================================================
 *
 * Class CSrEventHandler Method - void SendPreUpdateEvent (pRecord, Flags, Source);
 *
 *=========================================================================*/
void CSrEventHandler::SendPreUpdateEvent (CSrRecord* pRecord, const dword Flags, const long Source) 
{
  CSrListenEvent Event;

  Event.SetType(SR_EVENT_PREUPDATERECORD);
  Event.SetOldRecord(pRecord);
  Event.SetFlags(Flags);
  Event.SetSource(Source);

  SendEvent(&Event);
}
/*===========================================================================
 *		End of Class Method CSrEventHandler::SendPreUpdateEvent()
 *=========================================================================*/
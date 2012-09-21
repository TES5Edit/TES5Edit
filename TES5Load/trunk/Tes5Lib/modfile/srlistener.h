/*===========================================================================
 *
 * File:		Srlistener.H
 * Author:		Dave Humphrey (dave@uesp.net)
 * Created On:	26 November 2011
 *
 * Defines the ISrListener interface.
 *
 *=========================================================================*/
#ifndef __SRLISTENER_H
#define __SRLISTENER_H


/*===========================================================================
 *
 * Begin Required Includes
 *
 *=========================================================================*/
  #include "srlistenevent.h"
  #include "../common/srptrarray.h"
/*===========================================================================
 *		End of Required Includes
 *=========================================================================*/


/*===========================================================================
 *
 * Begin Class ISrListener Definition
 *
 *=========================================================================*/
class ISrListener {

  /*---------- Begin Protected Class Members --------------------*/
protected:


  /*---------- Begin Protected Class Methods --------------------*/
protected:


  /*---------- Begin Public Class Methods -----------------------*/
public:

	/* Events */
  virtual int OnListenAddRecord       (CSrListenEvent* pEvent) = 0;
  virtual int OnListenCleanRecord     (CSrListenEvent* pEvent) = 0;
  virtual int OnListenUpdateRecord    (CSrListenEvent* pEvent) = 0;
  virtual int OnListenPreUpdateRecord (CSrListenEvent* pEvent) = 0;
   
  virtual int GetListenEvents (void) = 0;   //Which events the listener wants

};

	/* Array of listeners */
  typedef CSrPtrArray<ISrListener>    CSrListenerArray;
  typedef CSrRefPtrArray<ISrListener> CSrRefListenerArray;

/*===========================================================================
 *		End of Class ISrListener Definition
 *=========================================================================*/


#endif
/*===========================================================================
 *		End of File Srlistener.H
 *=========================================================================*/


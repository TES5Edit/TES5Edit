/*===========================================================================
 *
 * File:	Srcallback.CPP
 * Author:	Dave Humphrey (dave@uesp.net)
 * Created On:	25 November 2011
 *
 * Description
 *
 *=========================================================================*/

	/* Include Files */
#include "srcallback.h"


/*===========================================================================
 *
 * Class CSrCallback Constructor
 *
 *=========================================================================*/
CSrCallback::CSrCallback () {
  m_Function = NULL;

  m_ProcessRecords      = 0;
  m_TotalRecords        = 0;
  m_LastCallbackRecords = 0;
  m_CallbackInterval    = 1000;

  m_TotalRecords1        = 0;
  m_ProcessRecords1      = 0;
  m_LastCallbackRecords1 = 0;

  m_Enabled     = true;
  m_UpdateTitle = false;
  m_UpdateLabel = false;

}
/*===========================================================================
 *		End of Class CSrCallback Constructor
 *=========================================================================*/


/*===========================================================================
 *
 * Class CSrCallback Method - void Destroy (void);
 *
 *=========================================================================*/
void CSrCallback::Destroy (void) {
  m_Function = NULL;

  m_Label.Empty();
  m_Title.Empty();

  m_UpdateTitle = false;
  m_UpdateLabel = false;

  m_ProcessRecords      = 0;
  m_TotalRecords        = 0;
  m_LastCallbackRecords = 0;

  m_TotalRecords1        = 0;
  m_ProcessRecords1      = 0;
  m_LastCallbackRecords1 = 0;
}
/*===========================================================================
 *		End of Class Method CSrCallback::Destroy()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CSrCallback Method - int ForceCallback (ProcessRecords);
 *
 *=========================================================================*/
int CSrCallback::ForceCallback (const int64 ProcessRecords) {

  m_ProcessRecords = ProcessRecords;
  if (!IsValid()) return (SRCALLBACK_NOFUNCTION);

  m_LastCallbackRecords = m_ProcessRecords;
  return m_Function(this);
}
/*===========================================================================
 *		End of Class Method CSrCallback::ForceCallback()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CSrCallback Method - float GetPercentDone (void);
 *
 *=========================================================================*/
float CSrCallback::GetPercentDone (void) {
  float Result;

  if (m_TotalRecords == 0) return (0.0f);

  Result = (float) ((double) m_ProcessRecords * 100.0 / (double) m_TotalRecords);

  if (m_TotalRecords1 != 0) Result += (float) ((double) m_ProcessRecords1 * 100.0 / (double) m_TotalRecords1);

  return (Result);
}
/*===========================================================================
 *		End of Class Method CSrCallback::GetPercentDone()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CSrCallback Method - void Reset (void);
 *
 *=========================================================================*/
void CSrCallback::Reset (void) {
  m_ProcessRecords      = 0;
  m_LastCallbackRecords = 0;

  m_ProcessRecords1      = 0;
  m_LastCallbackRecords1 = 0;
}
/*===========================================================================
 *		End of Class Method CSrCallback::Reset()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CSrCallback Method - void SetLabel ( pString, ...);
 *
 *=========================================================================*/
void CSrCallback::SetLabel (const SSCHAR* pString, ...) {
  va_list Args;

  if (pString == NULL) {
    m_Label.Empty();
  }
  else {
    va_start(Args, pString);
    m_Label.FormatV(pString, Args);
    va_end(Args);
  }

  m_UpdateLabel = true;
}
/*===========================================================================
 *		End of Class Method CSrCallback::SetLabel()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CSrCallback Method - void SetTitle (pString, ...);
 *
 *=========================================================================*/
void CSrCallback::SetTitle (const SSCHAR* pString, ...) {
  va_list Args;

  if (pString == NULL) {
    m_Label.Empty();
  }
  else {
    va_start(Args, pString);
    m_Title.FormatV(pString, Args);
    va_end(Args);
  }

  m_UpdateTitle = true;
}
/*===========================================================================
 *		End of Class Method CSrCallback::SetTitle()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CSrCallback Method - int UpdateCallback (ProcessRecords);
 *
 *=========================================================================*/
int CSrCallback::UpdateCallback (const int64 ProcessRecords) {

  m_ProcessRecords = ProcessRecords;
  if (!IsValid()) return (SRCALLBACK_NOFUNCTION);

  if (m_LastCallbackRecords + m_CallbackInterval <= m_ProcessRecords) {
    m_LastCallbackRecords = m_ProcessRecords;

    return m_Function(this);
  }

  return (SRCALLBACK_NOTPROCESSED);
}
/*=====================================================================1======
 *		End of Class Method CSrCallback::UpdateCallback()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CSrCallback Method - int UpdateCallback1 (ProcessRecords);
 *
 *=========================================================================*/
int CSrCallback::UpdateCallback1 (const int64 ProcessRecords) {

  m_ProcessRecords1 = ProcessRecords;
  if (!IsValid()) return (SRCALLBACK_NOFUNCTION);

  if (m_LastCallbackRecords1 + m_CallbackInterval <= m_ProcessRecords1) {
    m_LastCallbackRecords1 = m_ProcessRecords1;

    return m_Function(this);
  }

  return (SRCALLBACK_NOTPROCESSED);
}
/*=====================================================================1======
 *		End of Class Method CSrCallback::UpdateCallback1()
 *=========================================================================*/



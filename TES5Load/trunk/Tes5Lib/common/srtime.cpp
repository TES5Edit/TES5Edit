/*===========================================================================
 *
 * File:	Srtime.CPP
 * Author:	Dave Humphrey (dave@uesp.net)
 * Created On:	25 November 2011
 *
 * Description
 *
 *=========================================================================*/

	/* Include Files */
#include <windows.h>
#include "srtime.h"
#include "srlogfile.h"


/*===========================================================================
 *
 * Begin Local Definitions
 *
 *=========================================================================*/

/*===========================================================================
 *		End of Local Definitions
 *=========================================================================*/



/*===========================================================================
 *
 * Function - srhirestime_t SrGetTimerFrequency (void);
 *
 * Returns the high resolution timer frequency. Returns 1 on any error.
 *
 *=========================================================================*/
srhirestime_t SrGetTimerFrequency (void) {
  static LARGE_INTEGER  s_Freq = { 0 };
  BOOL			Result;

  if (s_Freq.QuadPart > 1) return (s_Freq.QuadPart);

  Result = QueryPerformanceFrequency(&s_Freq);
  if (!Result) return (1);

  return s_Freq.QuadPart;
}
/*===========================================================================
 *		End of Function SrGetTimerFrequency()
 *=========================================================================*/


/*===========================================================================
 *
 * Function - void SrStartTimer (Timer);
 *
 * Sets the start time of the given timer.
 *
 *=========================================================================*/
void SrStartTimer (srtimer_t& Timer) {
  LARGE_INTEGER Value;
  BOOL          Result;

  Timer.StartTime = 0;

  Result = QueryPerformanceCounter(&Value);
  if (!Result) return;

  Timer.StartTime = Value.QuadPart;
}
/*===========================================================================
 *		End of Function SrStartTimer()
 *=========================================================================*/


/*===========================================================================
 *
 * Function - double SrEndTimer (Timer, pLogMessage);
 *
 * Sets the end time of the given timer and returns the time different
 * in seconds. Returns 0 on any error. If pMessage is not NULL a timer
 * message is output to the log file.
 *
 *=========================================================================*/
double SrEndTimer (srtimer_t& Timer, const SSCHAR* pLogMessage) {
  LARGE_INTEGER Value;
  BOOL          Result;

  Result = QueryPerformanceCounter(&Value);
  if (!Result) return (0);
  Timer.EndTime = Value.QuadPart;

  if (pLogMessage != NULL) SrOutputTimerLog(Timer, pLogMessage);
  return SrGetTimerDelta(Timer);
}
/*===========================================================================
 *		End of Function SrEndTimer()
 *=========================================================================*/


/*===========================================================================
 *
 * Function - double SrGetTimerDelta (Timer);
 *
 * Returns the delta time of the given time in seconds. Returns 0 on
 * any error.
 *
 *=========================================================================*/
double SrGetTimerDelta (srtimer_t& Timer) {
  if (Timer.StartTime <= 1) return (0);
  if (Timer.EndTime   <= 1) return (0);
  return (double)(Timer.EndTime - Timer.StartTime) / (double) SrGetTimerFrequency(); 
}
/*===========================================================================
 *		End of Function SrGetTimerDelta()
 *=========================================================================*/


/*===========================================================================
 *
 * Function - void SrOutputTimerLog (Timer, pMessage);
 *
 * Outputs a standard timer message to the system log file with the given
 * message string.
 *
 *=========================================================================*/
void SrOutputTimerLog (srtimer_t& Timer, const SSCHAR* pMessage) {
  double DeltaTime = SrGetTimerDelta(Timer);

  SystemLog.Printf("%s %g seconds", pMessage ? pMessage : "Timer =", DeltaTime);
}
/*===========================================================================
 *		End of Function SrOutputTimerLog()
 *=========================================================================*/

/*===========================================================================
 *
 * File:	Srtime.H
 * Author:	Dave Humphrey (dave@uesp.net)
 * Created On:	25 November 2011
 *
 * Description
 *
 *=========================================================================*/
#ifndef __SRTIME_H
#define __SRTIME_H


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
 * Begin Type Definitions
 *
 *=========================================================================*/

	/* Used to hold timing information */
  typedef int64 srhirestime_t;

	/* Used to measure the time of an event */
  struct srtimer_t {
	srhirestime_t	StartTime;
	srhirestime_t	EndTime;
  };

/*===========================================================================
 *		End of Type Definitions
 *=========================================================================*/


/*===========================================================================
 *
 * Begin Function Definitions
 *
 *=========================================================================*/

	/* Functions for accurately timing */
  srhirestime_t SrGetTimerFrequency (void);

  void		SrStartTimer     (srtimer_t& Timer);
  double	SrEndTimer       (srtimer_t& Timer, const SSCHAR* pLogMessage = NULL);
  double    SrGetTimerDelta  (srtimer_t& Timer);

  void	SrOutputTimerLog(srtimer_t& Timer, const SSCHAR* pMessage);

/*===========================================================================
 *		End of Function Definitions
 *=========================================================================*/


#endif
/*===========================================================================
 *		End of File Srtime.H
 *=========================================================================*/

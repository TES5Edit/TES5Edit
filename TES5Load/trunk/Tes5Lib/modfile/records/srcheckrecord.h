/*===========================================================================
 *
 * File:		Srcheckrecord.H
 * Author:		Dave Humphrey (dave@uesp.net)
 * Created On:	26 November 2011
 *
 * Description
 *
 *=========================================================================*/
#ifndef __SRCHECKRECORD_H
#define __SRCHECKRECORD_H


/*===========================================================================
 *
 * Begin Required Includes
 *
 *=========================================================================*/
  #include "srrecord.h"
/*===========================================================================
 *		End of Required Includes
 *=========================================================================*/


/*===========================================================================
 *
 * Begin Type Definitions
 *
 *=========================================================================*/

	/* Function type used to check records for various purposes */
  typedef bool (*SRCHECKRECORDFUNC) (CSrRecord* pRecord, const long UserData);

	/* Used to export various file types */
  struct srexportinfo_t 
  {
	const srrectype_t*	pRecordType;
	srformid_t			GroupFormID;
	bool				RecurseGroups;
	SRCHECKRECORDFUNC	CheckFunction;
	srrecfieldid_t*		pFieldList;
  };

/*===========================================================================
 *		End of Type Definitions
 *=========================================================================*/


/*===========================================================================
 *
 * Begin Function Prototypes
 *
 *=========================================================================*/
  bool IsSrMarkerReference   (CSrRecord* pRecord, const long UserData);
  bool IsSrPlantReference    (CSrRecord* pRecord, const long UserData);
  bool IsSrTeleportReference (CSrRecord* pRecord, const long UserData);
/*===========================================================================
 *		End of Function Prototypes
 *=========================================================================*/


#endif
/*===========================================================================
 *		End of File Obcheckrecord.H
 *=========================================================================*/


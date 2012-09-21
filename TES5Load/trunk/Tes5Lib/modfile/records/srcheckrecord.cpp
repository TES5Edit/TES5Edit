/*===========================================================================
 *
 * File:	Obcheckrecord.CPP
 * Author:	Dave Humphrey (dave@uesp.net)
 * Created On:	September 11, 2006
 *
 * Description
 *
 *=========================================================================*/

	/* Include Files */
#include "srcheckrecord.h"
//#include "srrefrrecord.h"
#include "../srrecordhandler.h"



/*===========================================================================
 *
 * Function - bool IsSrPlantReference (pRecord, UserData);
 *
 * Checks if the given reference is a plant.
 *
 *=========================================================================*/
bool IsSrPlantReference (CSrRecord* pRecord, const long UserData) {
  /*
  CSrRefrRecord* pReference;
  CSrBaseRecord* pBase;

  pReference = SrCastClassNull(CSrRefrRecord, pRecord);
  if (pReference == NULL) return (false);
  if (pRecord->GetParent() == NULL) return (false);

  pBase = pRecord->GetParent()->FindFormID(pReference->GetBaseFormID());
  if (pBase == NULL) return (false);

  if (pBase->GetRecordType() == SR_NAME_FLOR) return (true); */
  return (false);
}
/*===========================================================================
 *		End of Function IsSrPlantReference()
 *=========================================================================*/


/*===========================================================================
 *
 * Function - bool IsSrMarkerReference (pRecord, UserData);
 *
 * Checks if the given reference is a marker.
 *
 *=========================================================================*/
bool IsSrMarkerReference (CSrRecord* pRecord, const long UserData) {
	/*
  CSrRefrRecord* pReference;

  pReference = SrCastClassNull(CSrRefrRecord, pRecord);
  if (pReference == NULL) return (false);

  if (pReference->IsMapMarker()) return (true); */
  return (false);
}
/*===========================================================================
 *		End of Function IsSrMarkerReference()
 *=========================================================================*/


/*===========================================================================
 *
 * Function - bool IsSrTeleportReference (pRecord, UserData);
 *
 * Checks if the given record is a reference that is a teleport location.
 *
 *=========================================================================*/
bool IsSrTeleportReference (CSrRecord* pRecord, const long UserData) {
/*
  CSrRefrRecord* pReference;

  pReference = SrCastClassNull(CSrRefrRecord, pRecord);
  if (pReference == NULL) return (false);

  if (pReference->GetTeleportData() != NULL) return (true); */
  return (false);
}
/*===========================================================================
 *		End of Function IsSrTeleportReference()
 *=========================================================================*/





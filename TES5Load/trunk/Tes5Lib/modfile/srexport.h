/*===========================================================================
 *
 * File:		Srexport.H
 * Author:		Dave Humphrey (dave@uesp.net)
 * Created On:	26 November 2011
 *
 * Description
 *
 *=========================================================================*/
#ifndef __SREXPORT_H
#define __SREXPORT_H


/*===========================================================================
 *
 * Begin Required Includes
 *
 *=========================================================================*/
  #include "records/srrecord.h"
  #include "records/srcheckrecord.h"
  #include "srrecordhandler.h"
  #include "srespfile.h"
/*===========================================================================
 *		End of Required Includes
 *=========================================================================*/


/*===========================================================================
 *
 * Begin Type Definitions
 *
 *=========================================================================*/

/*===========================================================================
 *		End of Type Definitions
 *=========================================================================*/


/*===========================================================================
 *
 * Begin Function Prototypes
 *
 *=========================================================================*/

	/* Export a CSV file */
  bool SrCsvExport (const SSCHAR* pFilename, CSrEspFile& EspFile, srexportinfo_t& ExportInfo);

  bool PrepareSrCsvExport         (srcsvinfo_t& CsvInfo, const srrecfieldmap_t* pStartFieldMap);
  bool PrepareSrCsvExportFromList (srcsvinfo_t& CsvInfo, srrecfield_t* pFieldList);

/*===========================================================================
 *		End of Function Prototypes
 *=========================================================================*/


/*===========================================================================
 *
 * Begin External Definitions
 *
 *=========================================================================*/
  extern srrecfieldid_t g_ExteriorTeleportExportFieldList[];
  extern srrecfieldid_t g_PlantExportFieldList[];
  extern srrecfieldid_t g_MapMarkerExportFieldList[];

  extern srexportinfo_t g_ExportCsvExtLocations;
  extern srexportinfo_t g_ExportCsvMapMarkers;
  extern srexportinfo_t g_ExportCsvPlants;
/*===========================================================================
 *		End of External Definitions
 *=========================================================================*/


#endif
/*===========================================================================
 *		End of File Obexport.H
 *=========================================================================*/

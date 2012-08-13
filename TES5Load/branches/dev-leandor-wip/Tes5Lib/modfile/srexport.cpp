/*===========================================================================
 *
 * File:		Srexport.CPP
 * Author:		Dave Humphrey (dave@uesp.net)
 * Created On:	26 November 2011
 *
 * Description
 *
 *=========================================================================*/

	/* Include Files */
#include "srexport.h"


/*===========================================================================
 *
 * Begin Export Field Arrays
 *
 * These arrays define what fields to output for various export types.
 *
 *=========================================================================*/
srrecfieldid_t g_ExteriorTeleportExportFieldList[] = {
	SR_FIELD_FORMID, SR_FIELD_EDITORID, SR_FIELD_RECORDTYPE, SR_FIELD_WORLDSPACE,
	SR_FIELD_FULLNAME, SR_FIELD_LOCATIONX, SR_FIELD_LOCATIONY, SR_FIELD_LOCATIONZ,
	SR_FIELD_ANGLEX, SR_FIELD_ANGLEY, SR_FIELD_ANGLEZ, 
	SR_FIELD_TELEPORTFORMID, SR_FIELD_TELEPORTNAME, 
	SR_FIELD_TELEPORTLOCX, SR_FIELD_TELEPORTLOCY, SR_FIELD_TELEPORTLOCZ,
	SR_FIELD_TELEPORTANGLEX, SR_FIELD_TELEPORTANGLEY, SR_FIELD_TELEPORTANGLEZ, 
	SR_FIELD_NONE };

srrecfieldid_t g_PlantExportFieldList[] = {
	SR_FIELD_FORMID, SR_FIELD_EDITORID, SR_FIELD_RECORDTYPE, SR_FIELD_WORLDSPACE,
	SR_FIELD_FULLNAME, SR_FIELD_LOCATIONX, SR_FIELD_LOCATIONY, SR_FIELD_LOCATIONZ,
	SR_FIELD_ANGLEX, SR_FIELD_ANGLEY, SR_FIELD_ANGLEZ, 
	SR_FIELD_BASEFORMID, SR_FIELD_BASEEDITORID, SR_FIELD_BASENAME,
	SR_FIELD_NONE };

srrecfieldid_t g_MapMarkerExportFieldList[] = {
	SR_FIELD_FORMID, SR_FIELD_EDITORID, SR_FIELD_RECORDTYPE, SR_FIELD_WORLDSPACE,
	SR_FIELD_FULLNAME, SR_FIELD_LOCATIONX, SR_FIELD_LOCATIONY, SR_FIELD_LOCATIONZ,
	SR_FIELD_ANGLEX, SR_FIELD_ANGLEY, SR_FIELD_ANGLEZ, 
	SR_FIELD_MARKERTYPE, SR_FIELD_MARKERTYPEID,
	SR_FIELD_NONE };
/*===========================================================================
 *		End of Export Field Arrays
 *=========================================================================*/


/*===========================================================================
 *
 * Begin CSV Export Information Structures
 *
 * Holds information on how to export various CSV files.
 *
 *=========================================================================*/
srexportinfo_t g_ExportCsvExtLocations = {
	&SR_NAME_WRLD,
	SR_FORMID_NULL,
	true,
	IsSrTeleportReference,
	g_ExteriorTeleportExportFieldList
};

srexportinfo_t g_ExportCsvMapMarkers = {
	&SR_NAME_WRLD,
	SR_FORMID_NULL,
	true,
	IsSrMarkerReference,
	g_MapMarkerExportFieldList
};

srexportinfo_t g_ExportCsvPlants = {
	&SR_NAME_WRLD,
	SR_FORMID_NULL,
	true,
	IsSrPlantReference,
	g_PlantExportFieldList
};
/*===========================================================================
 *		End of CSV Export Information Structures
 *=========================================================================*/


/*===========================================================================
 *
 * Function - bool PrepareSrCsvExport (CsvInfo, pStartFieldMap);
 *
 * Prepares the given CsvInfo object using the given information. Returns
 * false on any error.
 *
 *=========================================================================*/
bool PrepareSrCsvExport (srcsvinfo_t& CsvInfo, const srrecfieldmap_t* pStartFieldMap) {
  const srrecfieldmap_t* pFieldMap;
  srcsvcolinfo_t*	 pColInfo;
  CSString*		 pString;
  CCsvRow*		 pRow;
  dword			 Index;

	/* Ensure valid input */
  if (pStartFieldMap == NULL || CsvInfo.pCsvFile == NULL) return (false);
  
  CsvInfo.pEditorID   = NULL;
  CsvInfo.pRecordName = NULL;

  pRow = CsvInfo.pCsvFile->AddRow();
  assert (pRow != NULL);

	/* Enumerate all fields in class and all base classes */
  for (pFieldMap = pStartFieldMap; pFieldMap != NULL; pFieldMap = pFieldMap->pBaseFieldMap) {
    assert(pFieldMap != pFieldMap->pBaseFieldMap);

    for (Index = 0; pFieldMap->pField[Index].GetMethod != NULL; ++Index) {

		/* Ignore field if required */
      if (pFieldMap->pField[Index].IsNoCSV()) continue;
      
      pColInfo = new srcsvcolinfo_t;
      CsvInfo.ColInfos.Add(pColInfo);
      pString  = new CSString(GetSrFieldString(pFieldMap->pField[Index].FieldID));
      pRow->Add(pString);

      pColInfo->ColIndex = pRow->GetSize() - 1;
      pColInfo->FieldID  = pFieldMap->pField[Index].FieldID;
      pColInfo->Process  = true;
      pColInfo->pValue   = pString;
      pColInfo->pField   = &pFieldMap->pField[Index];
      pColInfo->UserData = 0;

      if (pFieldMap->pField[Index].FieldID == SR_FIELD_EDITORID)   CsvInfo.pEditorID   = pColInfo;
      if (pFieldMap->pField[Index].FieldID == SR_FIELD_RECORDTYPE) CsvInfo.pRecordName = pColInfo;
    }
  }

	/* Ensure required fields */
  assert(CsvInfo.pEditorID   != NULL);
  assert(CsvInfo.pRecordName != NULL);

  return (true);
}
/*===========================================================================
 *		End of Function PrepareSrCsvExport()
 *=========================================================================*/


/*===========================================================================
 *
 * Function - bool PrepareSrCsvExportFromList (CsvInfo, pFieldList);
 *
 * Initializes a CsvInfo structure in preparation for export.
 *
 *=========================================================================*/
bool PrepareSrCsvExportFromList (srcsvinfo_t& CsvInfo, srrecfieldid_t* pFieldList) {
  srcsvcolinfo_t* pColInfo;
  CSString*       pString;
  CCsvRow*        pRow;
  dword           Index;

	/* Ensure valid input */
  if (pFieldList       == NULL) return AddSrGeneralError("No CSV field list supplied!");
  if (CsvInfo.pCsvFile == NULL) return AddSrGeneralError("No CSV file supplied!");

  pRow = CsvInfo.pCsvFile->AddRow();
  if (pRow == NULL) return (false);

  for (Index = 0; pFieldList[Index] != SR_FIELD_NONE; ++Index) {
    pColInfo = new srcsvcolinfo_t;
    CsvInfo.ColInfos.Add(pColInfo);
    pString  = new CSString(GetSrFieldString(pFieldList[Index]));
    pRow->Add(pString);

    pColInfo->ColIndex = pRow->GetSize() - 1;
    pColInfo->FieldID  = pFieldList[Index];
    pColInfo->Process  = true;
    pColInfo->pValue   = pString;
    pColInfo->pField   = NULL;
    pColInfo->UserData = 0;

    if (pFieldList[Index] == SR_FIELD_EDITORID)   CsvInfo.pEditorID   = pColInfo;
    if (pFieldList[Index] == SR_FIELD_RECORDTYPE) CsvInfo.pRecordName = pColInfo;
  }

  return (true);
}
/*===========================================================================
 *		End of Function PrepareSrCsvExportFromList()
 *=========================================================================*/


/*===========================================================================
 *
 * Function - bool SrCsvExportCsvGroup (pGroup, CsvInfo, ExportInfo);
 *
 * Exports matching records/groups within the given group to the given
 * CSV file. Local function assumes valid inputs.
 *
 *=========================================================================*/
bool SrCsvExportCsvGroup (CSrGroup* pGroup, srcsvinfo_t& CsvInfo, srexportinfo_t& ExportInfo) {
  CSrBaseRecord*  pBaseRecord;
  CSrRecord*      pRecord;
  CSrGroup*       pChildGroup;
  dword		  Index;
  bool            Result;
  
  for (Index = 0; Index < pGroup->GetNumRecords(); ++Index) {
    pBaseRecord = pGroup->GetRecord(Index);
    pChildGroup = SrCastClass(CSrGroup, pBaseRecord);
    pRecord     = SrCastClass(CSrRecord, pBaseRecord);

    if (pChildGroup != NULL) {
      Result = SrCsvExportCsvGroup(pChildGroup, CsvInfo, ExportInfo);
      if (!Result) return (false);
    }
    else if (pRecord != NULL && ExportInfo.CheckFunction) {
      Result = ExportInfo.CheckFunction(pRecord, 0);

      if (Result) {
        Result = pRecord->ExportCsv(CsvInfo);
        if (!Result) return (false);
      }
    }
    else if (pRecord != NULL) {
      Result = pRecord->ExportCsv(CsvInfo);
      if (!Result) return (false);
    }
  }

  return (true);
}
/*===========================================================================
 *		End of Function SrCsvExportCsvGroup()
 *=========================================================================*/


/*===========================================================================
 *
 * Function - bool SrCsvExport (pFilename, pRecordHandler, ExportInfo);
 *
 * Attempts to export records to a CSV file using the given information.
 *
 *=========================================================================*/
bool SrCsvExport (const SSCHAR* pFilename, CSrEspFile& EspFile, srexportinfo_t& ExportInfo) {
  CSrTypeGroup*   pTypeGroup;
  CSrGroup*       pGroup;
  srcsvinfo_t     CsvInfo;
  CCsvFile        CsvFile;
  int		  GroupPos;
  bool            Result;

	/* Ensure valid input */
  if (pFilename == NULL) return (false);

	/* Initialize the CsvInfo structure */
  CsvInfo.pEditorID   = NULL;
  CsvInfo.pRecordName = NULL;
  CsvInfo.pCsvFile    = &CsvFile;

  Result = PrepareSrCsvExportFromList(CsvInfo, ExportInfo.pFieldList);
  if (!Result) return (false);

	/* Find all records to export */
  pTypeGroup = EspFile.GetTypeGroup(*ExportInfo.pRecordType);
  if (pTypeGroup == NULL) return (true);

  pGroup = pTypeGroup->FindFirstGroup(ExportInfo.GroupFormID, GroupPos);

  while (pGroup != NULL) {
    Result = SrCsvExportCsvGroup(pGroup, CsvInfo, ExportInfo);
    if (!Result) return (false);
   
    pGroup = pTypeGroup->FindNextGroup(ExportInfo.GroupFormID, GroupPos);
  }

  return CsvFile.Save(pFilename);
}
/*===========================================================================
 *		End of Function SrCsvExport()
 *=========================================================================*/

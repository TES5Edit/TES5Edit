/*===========================================================================
 *
 * File:		Srimport.CPP
 * Author:		Dave Humphrey (dave@uesp.net)
 * Created On:	26 November 2011
 *
 * General import helper routines.
 *
 *=========================================================================*/

	/* Include Files */
#include "srimport.h"


/*===========================================================================
 *
 * Function - bool SrPrepareImportCsvInfo (CsvInfo, CsvFile);
 *
 * Prepares the given CSV info structure for the input file. Returns false
 * on any error. 
 *
 *=========================================================================*/
bool SrPrepareImportCsvInfo (srcsvinfo_t& CsvInfo, CCsvFile& CsvFile) {
  srcsvcolinfo_t* pColInfo;
  CSString*       pString;
  CCsvRow*        pHeaderRow;
  dword           Index;
  int			  FieldID;
  bool			 Result;
  
	/* Clear the current information */
  CsvInfo.ColInfos.Empty();
  CsvInfo.pEditorID   = NULL;
  CsvInfo.pRecordName = NULL;
  CsvInfo.pCsvFile    = &CsvFile;

	/* Ignore if no header row */
  pHeaderRow = CsvFile.GetRow(0);
  if (pHeaderRow == NULL) return AddSrGeneralError("CSV file has no header row!");
  
  for (Index = 0; Index < pHeaderRow->GetSize(); ++Index) {
    pColInfo = new srcsvcolinfo_t;
    CsvInfo.ColInfos.Add(pColInfo);

    pColInfo->ColIndex = Index;
    pColInfo->FieldID  = SR_FIELD_UNKNOWN;
    pColInfo->pField   = NULL;
    pColInfo->Process  = false;
    pColInfo->UserData = 0;
    pColInfo->pValue   = NULL;

    pString = pHeaderRow->GetAt(Index);
    if (pString == NULL) continue;
    pColInfo->pValue = pString;

    Result = GetSrFieldValue(FieldID, *pString);

    if (!Result) {
      AddSrGeneralError("Unknown field '%s' found in column %d of CSV file!", pString->c_str(), Index);
      continue;
    }

    pColInfo->FieldID = FieldID;
    pColInfo->Process = true;

    switch (FieldID) {
      case SR_FIELD_EDITORID:
        CsvInfo.pEditorID = pColInfo;
        pColInfo->Process = false;
		break;
     case SR_FIELD_RECORDTYPE:
        CsvInfo.pRecordName = pColInfo;
        pColInfo->Process   = false;
		break;
    }
    
  }

	/* Ensure the required columns exist */
  if (CsvInfo.pEditorID   == NULL) return AddSrGeneralError("Missing required 'EditorID' column in CSV file!");
  if (CsvInfo.pRecordName == NULL) return AddSrGeneralError("Missing required 'RecordType' column in CSV file!");

  return (true);
}
/*===========================================================================
 *		End of Function SrPrepareImportCsvInfo()
 *=========================================================================*/

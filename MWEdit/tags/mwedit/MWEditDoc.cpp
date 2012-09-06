/*===========================================================================
 *
 * File:	MWEditDoc.CPP
 * Author:	Dave Humphrey (uesp@m0use.net)
 * Created On:	Monday, 03 February, 2003
 *
 * Implementation of the CMWEditDoc document class.
 *
 * 24 September 2003
 *	- Updated CleanRecord() method to dirty the document's modified flag.
 *
 *=========================================================================*/

	/* Include Files */
#include "stdafx.h"
#include "MWEdit.h"
#include "MWEditDoc.h"
#include "ESMUtils.h"
#include "windows/WinUtil.h"
#include "EsmGlobal.h"
#include "EsmScriptCompile.h"
#include "EsmGlobOptions.h"
#include "dl_time.h"
#include "EsmScriptCompile.h"
#include "ErrorDialog.h"


/*===========================================================================
 *
 * Begin Location Definitions
 *
 *=========================================================================*/

	/* Debug definitions */
#ifdef _DEBUG
  #define new DEBUG_NEW
  #undef THIS_FILE
  static char THIS_FILE[] = __FILE__;
#endif

  IMPLEMENT_DYNCREATE(CMWEditDoc, CDocument);
  DEFINE_FILE("MWEditDoc.cpp");
/*===========================================================================
 *		End of Location Definitions
 *=========================================================================*/


/*===========================================================================
 *
 * Begin Class CMWEditDoc Message Map
 *
 *=========================================================================*/
BEGIN_MESSAGE_MAP(CMWEditDoc, CDocument)
  //{{AFX_MSG_MAP(CMWEditDoc)
  ON_COMMAND(ID_FILE_SAVE,    OnFileSave)
  ON_COMMAND(ID_FILE_SAVE_AS, OnFileSaveAs)
  //}}AFX_MSG_MAP
END_MESSAGE_MAP()
/*===========================================================================
 *		End of Class CMWEditDoc Message Map
 *=========================================================================*/


/*===========================================================================
 *
 * Function - int l_FindRecNameSort (pElem1, pElem2, UserData);
 *
 *=========================================================================*/
int l_FindRecNameSort (const void* pElem1, const void* pElem2, const long UserData) {
  esmrecinfo_t* pRec1 = (esmrecinfo_t *) pElem1;
  TCHAR* pName = (TCHAR *) pElem2;  

  if (pRec1 == NULL) return (0);
  
  return StringCompare(pRec1->pRecord->GetID(), pName, false);
 }


int l_FindRecSort1 (const void* pElem1, const void* pElem2, const long UserData) {
  esmrecinfo_t* pRec1   = (esmrecinfo_t *) pElem1;
  CEsmRecord*   pRecord = (CEsmRecord   *) pElem2;  

  if (pRec1 == NULL || pRecord == NULL) return (0);
  long* pType1 = (long *) pRec1->pRecord->GetType();
  long* pType2 = (long *) pRecord->GetType();

  if (*pType1 == *pType2) {
    return StringCompare(pRec1->pRecord->GetID(), pRecord->GetID(), false);
   }
  else {
    return (*pType2 - *pType1);
   }     
 }


int l_FindRecSort2 (const void* pElem1, const void* pElem2, const long UserData) {
  esmrecinfo_t*		pRec1     = (esmrecinfo_t *) pElem1;
  esmrecsortfind_t*	pSortData = (esmrecsortfind_t *) pElem2;

  if (pRec1 == NULL || pSortData == NULL) return (0);
  long* pType1 = (long *) pRec1->pRecord->GetType();
  long* pType2 = (long *) pSortData->pType;

  if (*pType1 == *pType2) {
    return StringCompare(pRec1->pRecord->GetID(), pSortData->pID, false);
   }
  else {
    return (*pType2 - *pType1);
   }     
 }


static int l_RecSortPtr (const void* pElem1, const void* pElem2) {
  TCHAR*        pString = (TCHAR *) pElem1;
  esmrecinfo_t* pRec2   = *(esmrecinfo_t **) pElem2;

  if (pRec2 == NULL) return (0);	

  return StringCompare(pString, pRec2->pRecord->GetID(), false);
 }
/*===========================================================================
 *		End of Function l_FindRecNameSort()
 *=========================================================================*/


/*===========================================================================
 *
 * Function - int l_RecInfoSort (pElem1, pElem2, UserData);
 *
 *=========================================================================*/
int l_RecInfoSort (const void* pElem1, const void* pElem2, const long UserData) {
  esmrecinfo_t* pRec1 = (esmrecinfo_t *) pElem1;
  esmrecinfo_t* pRec2 = (esmrecinfo_t *) pElem2;

  if (pRec1 == NULL || pRec2 == NULL) return (0);	

  return StringCompare(pRec1->pRecord->GetID(), pRec2->pRecord->GetID(), false);
 }


int l_RecInfoSortType (const void* pElem1, const void* pElem2, const long UserData) {
  esmrecinfo_t* pRec1 = (esmrecinfo_t *) pElem1;
  esmrecinfo_t* pRec2 = (esmrecinfo_t *) pElem2;
  
  if (pRec1 == NULL || pRec2 == NULL) return (0);	
  long* pType1 = (long *) pRec1->pRecord->GetType();
  long* pType2 = (long *) pRec2->pRecord->GetType();

  if (*pType1 == *pType2) {
    return StringCompare(pRec1->pRecord->GetID(), pRec2->pRecord->GetID(), false);
   }
  else {
    return (*pType2 - *pType1);
   }     
  
 }
/*===========================================================================
 *		End of Function l_RecInfoSort()
 *=========================================================================*/


/*===========================================================================
 *
 * Function - int l_RecInfoSortPtr (pElem1, pElem2, UserData);
 *
 *=========================================================================*/
int l_RecInfoSortPtr (const void* pElem1, const void* pElem2, const long UserData) {
  esmrecinfo_t* pRec1 = *(esmrecinfo_t **) pElem1;
  esmrecinfo_t* pRec2 = *(esmrecinfo_t **) pElem2;

  if (pRec1 == NULL || pRec2 == NULL) return (0);	

  return StringCompare(pRec1->pRecord->GetID(), pRec2->pRecord->GetID(), false);
 }
/*===========================================================================
 *		End of Function l_RecInfoSortPtr()
 *=========================================================================*/


 /*===========================================================================
 *
 * Class CMWEditDoc Constructor
 *
 *=========================================================================*/
CMWEditDoc::CMWEditDoc() : m_RecInfo(0), m_EsmFiles(0) {
  m_NumFiles = 0;
  m_ViewChanged = false;

  //m_RecInfo.SetCompareFunc(l_RecInfoSort);
  m_RecInfoSort.InitHashTable(100000);

  //OutputFunctionDat("func1.dat");
 }
/*===========================================================================
 *		End of Class CMWEditDoc Constructor
 *=========================================================================*/


/*===========================================================================
 *
 * Class CMWEditDoc Destructor
 *
 *=========================================================================*/
CMWEditDoc::~CMWEditDoc() {
  ClearFileArray();
  ClearRecInfoArray();
 }
/*===========================================================================
 *		End of Class CMWEditDoc Destructor
 *=========================================================================*/


/*===========================================================================
 *
 * Class CMWEditDoc Method - void AddRecInfo (pFile);
 *
 * Adds all the records in the given file to the record info array.  If the
 * particular record ID already exists, it is overwritten.  Otherwise it
 * is added to the end of the info array.
 *
 *=========================================================================*/
void CMWEditDoc::AddRecInfo (CEsmFile* pFile) {
  DEFINE_FUNCTION("CMWEditDoc::AddRecInfo()");
  esmrecinfo_t* pRecInfo = NULL;
  CEsmRecord*	pRecord;
  int		Index;

  m_LoadDlg.SetProgress(100.0f);
  m_LoadDlg.SetSubLabel(_T("Adding records..."));

  for (Index = 0; Index < pFile->GetNumRecords(); Index++) {
    pRecord = pFile->GetRecord(Index);
    pRecInfo = NULL;

    if (Index % 100 == 0) {
      m_LoadDlg.SetProgress(Index * 100.0f / pFile->GetNumRecords() + 100.0f);
     }

		/* Ignore certain types of records */
    if (pRecord->IsType(MWESM_REC_TES3)) continue;
   
		/* Search for an existing record if required or create one */
    //if (m_NumFiles > 1) pRecInfo = FindRecInfo(pRecord);
    if (m_NumFiles <= 1) {
      CreatePointer(pRecInfo, esmrecinfo_t);  
      pRecInfo->pFile   = pFile;
      pRecInfo->pRecord = pRecord;

      //m_RecInfo.AddSortFast(pRecInfo);
      m_RecInfo.Add(pRecInfo);
      m_RecInfoSort.SetAt(pRecInfo);

      pRecord->SetPrevRecord(NULL);
      continue;
     }
    
    pRecInfo = FindRecordSort(pRecord);

    if (pRecInfo == NULL || !pRecInfo->pRecord->IsType(pRecord->GetType())) { 
      CreatePointer(pRecInfo, esmrecinfo_t);  
      pRecInfo->pFile   = pFile;
      pRecInfo->pRecord = pRecord;

      //m_RecInfo.AddSortFast(pRecInfo);
      m_RecInfo.Add(pRecInfo);
      m_RecInfoSort.SetAt(pRecInfo);

      pRecord->SetPrevRecord(NULL);
     }
		/* Set the previous record pointers */
    else {
      pRecord->SetPrevRecord(pRecInfo->pRecord);
      pRecInfo->pFile   = pFile;
      pRecInfo->pRecord = pRecord;
     }
   }

  if (m_NumFiles <= 1) {
    //m_RecInfo.SetCompareFunc(l_RecInfoSortPtr);
    //m_RecInfo.Sort(0);
    //m_RecInfo.SetCompareFunc(l_RecInfoSort);
   }

 }
/*===========================================================================
 *		End of Class Method CMWEditDoc::AddRecInfo()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CMWEditDoc Method - bool BackupPlugin (pFilename);
 *
 * Creates a backup of the given plugin file with the format: 
 *
 *			Plugin.esp.001
 *
 *=========================================================================*/
bool CMWEditDoc::BackupPlugin (const TCHAR* pFilename) {
  TCHAR	      BackupBuffer[_MAX_PATH+8];
  int	      Index;
  BOOL        Result;

	/* Ignore if not backing up things */
  if (!GetEsmOptBackupSaves()) return (true);

	/* Ignore if the previous filename doesn't exist */
  if (!FileExists(pFilename)) return (true);

  	/* Find the first available number */
  for (Index = 1; Index < 999; Index++) {
    snprintf (BackupBuffer, _MAX_PATH+7, _T("%s.%03d"), pFilename, Index);

    if (!FileExists(BackupBuffer)) {
      Result = CopyFile(pFilename, BackupBuffer, FALSE);

      if (!Result) {  
        ErrorHandler.AddError(ERR_WINDOWS, "File copy error!");
        return (false);
       }

      return (true);
     }
   }

  return (true);
 }
/*===========================================================================
 *		End of Class Method CMWEditDoc::BackupPlugin()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CMWEditDoc Method - bool CanCreateNew (pType);
 *
 * Returns true if the user is allowed to make new records of the given
 * type.
 *
 *=========================================================================*/
bool CMWEditDoc::CanCreateNew (const TCHAR* pType) {

  if (TSTRICMP(pType, MWESM_REC_MGEF) == 0) return (false);
  if (TSTRICMP(pType, MWESM_REC_TES3) == 0) return (false);
  if (TSTRICMP(pType, MWESM_REC_GMST) == 0) return (false);
  if (TSTRICMP(pType, MWESM_REC_SKIL) == 0) return (false);
  return (true);
 }
/*===========================================================================
 *		End of Class Method CMWEditDoc::CanCreateNew()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CMWEditDoc Method - int CleanRecord (pRecInfo);
 *
 * Removes the given record from the active file.
 *
 *=========================================================================*/
int CMWEditDoc::CleanRecord (esmrecinfo_t* pRecInfo) {
  DEFINE_FUNCTION("CMWEditDoc::CleanRecord()");
  CEsmRecord* pPrevRecord;
  CEsmRecord* pTmpRecord;

	/* Ignore if the record's file is not the active file */
  if (!pRecInfo->pFile->IsActive()) return (MWEDIT_CLEAN_OK);
  pPrevRecord = pRecInfo->pRecord->GetPrevRecord();

	/* Close any open edit windows */
  

  	/* Remove record form the active file */  
  m_ActiveFile.DeleteRecord(pRecInfo->pRecord);
  
	/* Check if we must delete the record */
  if (pPrevRecord == NULL) {
    SetModifiedFlag(TRUE);
    pTmpRecord = pRecInfo->pRecord;

    m_RecInfo.DeleteElement(pRecInfo);
    m_RecInfoSort.Delete(pRecInfo);

    DestroyPointer(pTmpRecord);
    return (MWEDIT_CLEAN_DELETE);
   }
  else {
    DestroyPointer(pRecInfo->pRecord);
  }
 
	/* Reset the recinfo contents */
  pRecInfo->pRecord = pPrevRecord;
  pRecInfo->pFile   = pPrevRecord->GetFile();
  SetModifiedFlag(TRUE);
  return (MWEDIT_CLEAN_OK);
 }
/*===========================================================================
 *		End of Class Method CMWEditDoc::CleanRecord()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CMWEditDoc Method - bool MakeActive (pRecInfo);
 *
 *=========================================================================*/
bool CMWEditDoc::MakeActive (esmrecinfo_t* pRecInfo) {
  CEsmRecord* pRecord;

  if (pRecInfo == NULL) return (false);
  if (pRecInfo->pFile->IsActive()) return (true);

	/* Attempt to copy the record into the active file */
  pRecord = m_ActiveFile.CopyRecord(pRecInfo->pRecord);
  if (pRecord == NULL) return (false);

	/* Update the recinfo structure */
  pRecord->SetPrevRecord(pRecInfo->pRecord);
  pRecord->SetFile(&m_ActiveFile);
  
  pRecInfo->pRecord = pRecord;
  pRecInfo->pFile   = &m_ActiveFile;

  SetModifiedFlag(TRUE);
  return (true);
}
/*===========================================================================
 *		End of Class Method CMWEditDoc::MakeActive()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CMWEditDoc Method - void ClearFileArray (void);
 *
 *=========================================================================*/
void CMWEditDoc::ClearFileArray (void) {
  CEsmFile* pFile;
  int	    Index;

  for (Index = 0; Index < m_EsmFiles.GetSize(); Index++) {
    pFile = m_EsmFiles.GetAt(Index);
    DestroyPointer(pFile);
   }

  m_EsmFiles.RemoveAll();
 }
/*===========================================================================
 *		End of Class Method CMWEditDoc::ClearFileArray()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CMWEditDoc Method - void ClearRecInfoArray (void);
 *
 * Deletes all entires in the rec info array.
 *
 *=========================================================================*/
void CMWEditDoc::ClearRecInfoArray (void) {
  m_RecInfo.RemoveAll();
  m_RecInfoSort.Destroy();
 }
/*===========================================================================
 *		End of Class Method CMWEditDoc::ClearRecInfoArray()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CMWEditDoc Method - void CompareScripts (void);
 *
 * Compare script data in the active plugin and current script file.
 *
 *=========================================================================*/
void CMWEditDoc::CompareScripts (void) {
  CEsmScript*	pScript1;
  CEsmScript*   pScript2;
  int		RecordPos;
  int		Count = 0;
  double        StartTime;
  double	EndTime;

  StartTime = GetHiClockTime();
  pScript1 = (CEsmScript *) m_ActiveFile.FindFirst("SCPT", RecordPos);
  SystemLog.Printf("===== Comparing scripts in active file '%s' to scripts in '%s'...", m_ActiveFile.GetFilename(), m_ScriptFilename);

  while (pScript1 != NULL) {
    pScript2 = FindScriptRecord(pScript1->GetID());

    if (pScript2 != NULL) {
      CompareScripts(pScript1, pScript2);
      ++Count;
    }
    else {
      SystemLog.Printf("Script '%s' not found in source plugin!", pScript1->GetID());
    }

    pScript1 = (CEsmScript *) m_ActiveFile.FindNext("SCPT", RecordPos);
  }

  EndTime = GetHiClockTime();
  SystemLog.Printf("===== Finished Comparing %d Scripts in %g seconds", Count, EndTime-StartTime);
}
/*===========================================================================
 *		End of Class Method CMWEditDoc::CompareScripts()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CMWEditDoc Method - void CompareScripts (pScript1, pScript2);
 *
 * Compares the two scripts.
 *
 *=========================================================================*/
void CMWEditDoc::CompareScripts (CEsmScript* pScript1, CEsmScript* pScript2) {
  int Result;

	/* Ensure valid input */
  if (pScript1 == NULL || pScript2 == NULL) return;
  SystemLog.Printf("Comparing script '%s'...", pScript1->GetID());

	/* Compare the script texts */
  Result = StringCompare(pScript1->GetScriptText(), pScript2->GetScriptText(), true);

  if (Result != 0) {
    SystemLog.Printf("\t\tError: Script texts do not match!");
    //return;
  }
  else {
    Result = StringCompare(pScript1->GetScriptText(), pScript2->GetScriptText(), false);
    SystemLog.Printf("\t\tWarning: Script texts differ in case!");
  }

	/* Compare the script compiled data */
  if (pScript1->GetScriptData() == NULL || pScript1->GetScriptData()->GetData() == NULL) {
    SystemLog.Printf("\t\tError: Script #1 has no compiled data!");
    return;
  }

  if (pScript2->GetScriptData() == NULL || pScript2->GetScriptData()->GetData() == NULL) {
    SystemLog.Printf("\t\tError: Script #2 has no compiled data!");
    return;
  }

  CompareScriptData(pScript1->GetScriptData()->GetData(), pScript1->GetScriptData()->GetRecordSize(), 
		    pScript2->GetScriptData()->GetData(), pScript2->GetScriptData()->GetRecordSize());
  
}
/*===========================================================================
 *		End of Class Method CMWEditDoc::CompareScripts()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CMWEditDoc Method - void CompareScriptData (pData1, Size1, pData2, Size2);
 *
 * Protected class method to compare the compiled data of two scripts.
 * Assumes valid inputs.
 *
 *=========================================================================*/
void CMWEditDoc::CompareScriptData (const byte* pData1, const long Size1, const byte* pData2, const long Size2) {
  const byte* pParse1 = pData1;
  const byte* pParse2 = pData2;
  long        Index1 = 0;
  long        Index2 = 0;
  long	      MismatchCount = 0;

  if (Size1 != Size2) {
    SystemLog.Printf("\t\tError: Compiled script sizes do not match (%d, %d)!", Size1, Size2);
  }

  while (Index1 < Size1 && Index2 < Size2) {

    if (*pParse1 != *pParse2) {

      if (tolower(*pParse1) == tolower(*pParse2)) {
        SystemLog.Printf("\t\t0x%04X: Case mismatch (%c, %c)", Index1, *pParse1, *pParse2);
      }
      else if (pParse1[1] == pParse2[1]) {
        SystemLog.Printf("\t\t0x%04X: %02X != %02X (single byte change)", Index1, (dword)*pParse1, (dword)*pParse2);
	++MismatchCount;
      }
      else if (pParse1[0] == pParse2[1]) {
        SystemLog.Printf("\t\t0x%04X: %02X deleted", Index1, (dword)*pParse2);
        --Index1;
	--pParse1;
	++MismatchCount;
      }
      else if (pParse1[1] == pParse2[0]) {
        SystemLog.Printf("\t\t0x%04X: %02X inserted", Index1, (dword)*pParse1);
        --Index2;
	--pParse2;
	++MismatchCount;
      }
      else {
        SystemLog.Printf("\t\t0x%04X: %02X != %02X", Index1, (dword)*pParse1, (dword)*pParse2);
        ++MismatchCount;
      }
    }

    ++Index1;
    ++Index2;
    ++pParse1;
    ++pParse2;
  }

  if (MismatchCount <= 0) 
    SystemLog.Printf("\tSUCCESS: Compiled scripts match 100%%!");
  else 
    SystemLog.Printf("\tFAILED: %d mismatches!", MismatchCount);
}
/*===========================================================================
 *		End of Class Method CMWEditDoc::CompareScriptData()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CMWEditDoc Method - bool CompileAllActiveScripts (void);
 *
 * Compiles all scripts in the active plugin.
 *
 *=========================================================================*/
bool CMWEditDoc::CompileAllActiveScripts (void) {
  CEsmScript*	pScript;
  CString	Buffer;
  int		RecordPos;
  int		SuccessCount = 0;
  int		ErrorCount = 0;
  bool		Result;
  double        StartTime;
  double	DeltaTime;
  CErrorDialog  ErrorDlg;

  StartTime = GetHiClockTime();
  pScript = (CEsmScript *) m_ActiveFile.FindFirst("SCPT", RecordPos);
  SystemLog.Printf("===== Compiling all scripts in active file '%s'...", m_ActiveFile.GetFilename());
  ErrorHandler.ClearErrorCount();

  while (pScript != NULL) {
    Result = CompileActiveScript(pScript);

    if (Result)
      ++SuccessCount;
    else
      ++ErrorCount;

    pScript = (CEsmScript *) m_ActiveFile.FindNext("SCPT", RecordPos);
  }

  DeltaTime = GetHiClockTime() - StartTime;
  SystemLog.Printf("===== Finished Compiling %d of %d Scripts in %g seconds", SuccessCount, ErrorCount + SuccessCount, DeltaTime);
  Buffer.Format(_T("Compiled %d of %d scripts in %g seconds.\r\nThe following errors or warnings occurred:"), SuccessCount, ErrorCount + SuccessCount, DeltaTime);

  if (ErrorHandler.GetErrorCount() <= 0) {
    //AfxMessageBox(Buffer, MB_OK);
    ErrorDlg.m_MessageText = Buffer;
    ErrorDlg.m_TitleText   = "Compile All Scripts in Active Plugin";
    ErrorDlg.DoModal();
  }
  else {
    //ErrorHandler.NotifyList(Buffer, "Compile All Scripts in Active Plugin");
    ErrorDlg.m_MessageText = Buffer;
    ErrorDlg.m_TitleText   = "Compile All Scripts in Active Plugin";
    ErrorDlg.DoModal();
  }

  if (SuccessCount > 0) SetModifiedFlag(TRUE);
  return (true);
}
/*===========================================================================
 *		End of Class Method CMWEditDoc::CompileAllActiveScripts()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CWMEditDoc Method - bool CompileActiveScript (pScript);
 *
 * Attempts to compile the given script. Does not update the script
 * location if not in the active file.
 *
 *=========================================================================*/
bool CMWEditDoc::CompileActiveScript (CEsmScript* pScript) {
  CEsmScriptCompile Compiler;
  CString	    Buffer;
  CEsmSubRecord*    pSubRec;
  CEsmSubSCHD*      pScriptHeader;
  int		    Result;

	/* Initialize the compiler */
  Compiler.SetDocument(this);
  Compiler.SetMsgLevel(GetEsmOptScriptWarnLevel());
  Compiler.SetScriptText(pScript->GetScriptText(), pScript->GetScriptSize());
    
	/* Perform the compile */
  Result = Compiler.Compile();

  if (Result < 0) {
    ErrorHandler.AddError(MWEDIT_ERR_COMPILEALL, "%s: Failed to compile script!", pScript->GetID());
    return (false);
  }
  
  	/* Set the script header */
  pScriptHeader = pScript->GetScriptHeader();
  if (pScriptHeader == NULL) pScriptHeader = (CEsmSubSCHD *) pScript->AllocateSubRecord(MWESM_SUBREC_SCHD);

  if (pScriptHeader != NULL) {
    pScriptHeader->GetScriptHeadData()->LocalVarSize   = Compiler.GetLocalVarDataSize();
    pScriptHeader->GetScriptHeadData()->ScriptDataSize = Compiler.GetScriptDataSize();
    pScriptHeader->GetScriptHeadData()->NumShorts      = Compiler.GetNumShortLocals();
    pScriptHeader->GetScriptHeadData()->NumLongs       = Compiler.GetNumLongLocals();
    pScriptHeader->GetScriptHeadData()->NumFloats      = Compiler.GetNumFloatLocals();
  }

	/* Set the local variable data */
  pSubRec = pScript->GetScriptVars();
  if (pSubRec == NULL) pSubRec = pScript->AllocateSubRecord(MWESM_SUBREC_SCVR);
  if (pSubRec != NULL) pSubRec->CopyData(Compiler.GetLocalVarData(), Compiler.GetLocalVarDataSize());

	/* Set the compiled script data */
  pSubRec = pScript->GetScriptData();
  if (pSubRec == NULL) pSubRec = pScript->AllocateSubRecord(MWESM_SUBREC_SCDT);
  if (pSubRec != NULL) pSubRec->CopyData(Compiler.GetScriptData(), Compiler.GetScriptDataSize());

  //ErrorHandler.AddError(MWEDIT_ERR_COMPILEALL, "%s: Successfully compiled script!", pScript->GetID());
  return (true);
}
/*===========================================================================
 *		End of Class Method CWMEditDoc::CompileActiveScript()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CMWEditDoc Method - CEsmScript* FindScriptRecord (pID);
 *
 * Looks for and returns the script with the given ID in the current
 * script file. Returns NULL if not found.
 *
 *=========================================================================*/
CEsmScript* CMWEditDoc::FindScriptRecord (const TCHAR* pID) {
  CEsmScript*	pScript;
  int		RecordPos;

  pScript = (CEsmScript *) m_ScriptFile.FindFirst("SCPT", RecordPos);

  while (pScript != NULL) {
    if (pScript->IsID(pID)) return (pScript);
    pScript = (CEsmScript *) m_ScriptFile.FindNext("SCPT", RecordPos);
  }

	/* Nothing found */
  return (NULL);
}
/*===========================================================================
 *		End of Class Method CMWEditDoc::FindScriptRecord()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CMWEditDoc Method - CEsmRecord* CopyCELLRefs (pDocument, pSourceCell, pDestCell);
 *
 * Ensures that all the cell references from the source cell/document are
 * copied into the destination cell. Returns the destination cell object.
 *
 *=========================================================================*/
CEsmRecord* CMWEditDoc::CopyCELLRefs (CMWEditDoc* pDocument, CEsmCell* pSourceCell, CEsmCell* pDestCell) {
  DEFINE_FUNCTION("CMWEditDoc::CopyCELLRefs()");
  CEsmCell*	  pCell = pSourceCell;
  CEsmSubCellRef* pCellRef;
  CEsmSubCellRef* pNewCellRef;
  int		  ArrayIndex;

	/* Iterate through all files that have a copy of the cell */
  while (pCell != NULL) {
    pCellRef = (CEsmSubCellRef *) pCell->FindFirst(MWESM_SUBREC_CREF, ArrayIndex);

		/* Copy all available unique cell reference objects */
    while (pCellRef != NULL) {
      if (!pDestCell->HasCellRef(pCellRef)) {
        CreatePointer(pNewCellRef, CEsmSubCellRef);
        pNewCellRef->Copy(pCellRef);
        pDestCell->AddCellRef(pCellRef);
       }
      
      pCellRef = (CEsmSubCellRef *) pCell->FindNext(MWESM_SUBREC_CREF, ArrayIndex);
     }
    
    pCell = (CEsmCell *)pCell->GetPrevRecord();
   }
 
  return (pDestCell);
 }
/*===========================================================================
 *		End of Class Method CMWEditDoc::CopyCELLRefs()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CMWEditDoc Method - bool CopyRecord (pSourceDoc, pRecInfo);
 *
 * Attempts to copy the given record from the source document into the active
 * file. Assumes that the input record is not already in the active file (is 
 * from another document or the clipboard for instance). If the ID exists and the
 * object types are the same, the user is prompted to overwrite. If the
 * ID exists and is a different object type, an error message is displayed.
 * Also, certain record types are ignored:
 *
 *=========================================================================*/
bool CMWEditDoc::CopyRecord (CMWEditDoc* pSourceDoc, esmrecinfo_t* pRecInfo) {
  DEFINE_FUNCTION("CMWEditDoc::CopyRecord()");
  esmrecinfo_t* pOrigRecInfo;
  esmrecinfo_t* pSameRecInfo;
  esmrecinfo_t* pNewRecInfo;
  CEsmRecord*   pNewRecord;
  CEsmRecord*   pPrevRecord = NULL;
  CString	Buffer;
  int		Result;

	/* Only accept certain types */
  if (pRecInfo == NULL) return (false);
  if (pRecInfo->pRecord->IsType(MWESM_REC_INFO)) return (false);

	/* Attempt to find an object with the same ID */
  pOrigRecInfo = FindRecord(pRecInfo->pRecord->GetID());

  if (pOrigRecInfo != NULL) {
    pSameRecInfo = FindRecord(pRecInfo->pRecord->GetID(), pRecInfo->pRecord->GetType());

		/* Objects are different type, cannot overwrite */
    if (pSameRecInfo == NULL) {
      Buffer.Format(_T("The object '%s' already exists and is a different type!"), pRecInfo->pRecord->GetID());
      Result = AfxMessageBox(Buffer, MB_OK | MB_ICONWARNING, 0); 
      return (false);
     }

		/* Prompt user if they wish to overwrite */
    Buffer.Format(_T("The %s item '%s' already exists?. Do you wish to overwrite?"), pRecInfo->pRecord->GetItemType(), pRecInfo->pRecord->GetID());
    Result = AfxMessageBox(Buffer, MB_YESNO | MB_ICONQUESTION, 0);
    if (Result != IDYES) return (false);

		/* Ensure that the current record exists in the active file */
    pNewRecInfo = CopyToActive(pOrigRecInfo);
    pNewRecInfo->pRecord->Copy(pRecInfo->pRecord);
    pNewRecord = pNewRecInfo->pRecord;
   }
  else {
    pNewRecInfo = CopyNewRecord(pRecInfo);
    pNewRecord = pNewRecInfo->pRecord;
   }

  	/* Special case for DIAL and CELL records */
  if (pNewRecord->IsType(MWESM_REC_DIAL)) {
    CreateCopyINFO(pSourceDoc, (CEsmDialogue *) pRecInfo->pRecord, (CEsmDialogue *) pNewRecInfo->pRecord);
   }
  else if (pNewRecord->IsType(MWESM_REC_CELL)) {
    CopyCELLRefs(pSourceDoc, (CEsmCell *) pRecInfo->pRecord, (CEsmCell *) pNewRecInfo->pRecord);
   }

  return (true);
 }
/*===========================================================================
 *		End of Class Method CMWEditDoc::CopyRecord()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CMWEditDoc Method - esmrecinfo_t* CopyNewRecord (pOrigRecInfo);
 *
 * Creates a copy of a new record in the active. The object's ID must not
 * currently exist.  The new recinfo object is returned.
 *
 *=========================================================================*/
esmrecinfo_t* CMWEditDoc::CopyNewRecord (esmrecinfo_t* pOrigRecInfo) {
  DEFINE_FUNCTION("CMWEditDoc::CopyNewRecord()");
  esmrecinfo_t* pNewRecInfo;
  CEsmRecord*   pNewRecord;

	/* Create the new rec info object */
  CreatePointer(pNewRecInfo, esmrecinfo_t);
   
	/* Create the new record */
  pNewRecord = m_ActiveFile.CreateCopy(pOrigRecInfo->pRecord);
  pNewRecord->SetFile(&m_ActiveFile);
  pNewRecord->SetPrevRecord(NULL);

	/* Initialize the new recinfo */
  pNewRecInfo->pFile = &m_ActiveFile;
  pNewRecInfo->pRecord = pNewRecord;

	/* Add the record/recinfo to the array and file */
  m_RecInfo.Add(pNewRecInfo);
  m_RecInfoSort.SetAt(pNewRecInfo);

  m_ActiveFile.AddRecord(pNewRecInfo->pRecord);
  return (pNewRecInfo);
 }
/*===========================================================================
 *		End of Class Method CMWEditDoc::CopyNewRecord()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CMWEditDoc Method - esmrecinfo_t* CopyToActive (pRecInfo);
 *
 * Ensures that the given record exists in the active file. Returns the
 * same recinfo.
 *
 *=========================================================================*/
esmrecinfo_t* CMWEditDoc::CopyToActive (esmrecinfo_t* pRecInfo) {
  DEFINE_FUNCTION("CMWEditDoc::CopyToActive()");
  CEsmRecord* pNewRecord;

	/* Is the record already active? */
  if (!pRecInfo->pFile->IsActive()) {

  		/* Create the new record */
    pNewRecord = m_ActiveFile.CreateCopy(pRecInfo->pRecord);
    pNewRecord->SetFile(&m_ActiveFile);
    pNewRecord->SetPrevRecord(pRecInfo->pRecord);

		/* Initialize the new recinfo */
    pRecInfo->pFile   = &m_ActiveFile;
    pRecInfo->pRecord = pNewRecord;

    m_ActiveFile.AddRecord(pNewRecord);
   }

  return (pRecInfo);
 }
/*===========================================================================
 *		End of Class Method CMWEditDoc::CopyToActive()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CMWEditDoc Method - CEsmRecord* CreateCopyDIAL (pDocument, pDialRecord);
 *
 * Copies a Dialogue record from the source document and all related INFO 
 * records into the active plugin. All INFO records are given new IDs.  The
 * new Dialogue record is returned.
 *
 *=========================================================================*/
CEsmRecord* CMWEditDoc::CreateCopyDIAL  (CEsmDialogue* pDialRecord) {
  return CreateCopyDIAL(this, pDialRecord);
 }


CEsmRecord* CMWEditDoc::CreateCopyDIAL (CMWEditDoc* pDocument, CEsmDialogue* pDialRecord) {
  DEFINE_FUNCTION("CMWEditDoc::CreateCopyDIAL");
  CEsmRecord*   pNewRecord;

	/* Create the new record */
  pNewRecord = m_ActiveFile.AllocNewRecord(pDialRecord->GetType());
  if (pNewRecord == NULL) return (NULL);
  m_ActiveFile.AddRecord(pNewRecord);

	/* Initialize the new dialogue record */
  pNewRecord->Copy(pDialRecord);
  pNewRecord->SetFile(&m_ActiveFile);

	/* Add all the dialogue info records */
  CreateCopyINFO(pDocument, pDialRecord, (CEsmDialogue *) pNewRecord);
  return (pNewRecord);
 }


CEsmRecord* CMWEditDoc::CreateCopyINFO (CMWEditDoc* pDocument, CEsmDialogue* pDialRecord, CEsmDialogue* pNewDialRecord) {
  DEFINE_FUNCTION("CMWEditDoc::CreateCopyINFO");
  esmrecinfo_t* pRecInfo;
  esmrecinfo_t* pNewRecInfo;
  CEsmInfo*     pInfo;
  CEsmInfo*     pNewInfo;
  CEsmInfo*     pLastInfo;

	/* Add all the dialogue info records */
  pRecInfo = pDocument->GetInfoStart(pDialRecord);
  pLastInfo = NULL;

  while (pRecInfo != NULL) {
    pInfo = (CEsmInfo *) pRecInfo->pRecord;

		/* Create the record/recinfo data */
    CreatePointer(pNewRecInfo, esmrecinfo_t);
    pNewInfo = (CEsmInfo *) m_ActiveFile.AllocNewRecord(MWESM_REC_INFO);

    		/* Initialize the new data */
    pNewRecInfo->pFile   = &m_ActiveFile;
    pNewRecInfo->pRecord = pNewInfo;
    pNewInfo->Copy(pInfo);
    pNewInfo->SetFile(&m_ActiveFile);
    pNewInfo->SetID(MakeNewINFOId());
    pNewInfo->SetNextName(_T(""));
    pNewInfo->SetDialParent(pNewDialRecord);

    m_ActiveFile.AddRecord(pNewInfo, pNewDialRecord);
    m_RecInfo.Add(pNewRecInfo);
    m_RecInfoSort.SetAt(pNewRecInfo);
    
    if (pLastInfo != NULL) {
      pLastInfo->SetNextName(pNewInfo->GetID());
      pNewInfo->SetPrevName(pLastInfo->GetID());
     }
    else {
      pNewInfo->SetPrevName(_T(""));
     }

    pLastInfo = pNewInfo;

		/* Get the next records */   
    if (pInfo->GetNextName()[0] == NULL_CHAR) break;
    //pRecInfo = pDocument->FindRecord(pInfo->GetNextName());    
    pRecInfo = pDocument->FindInfoRecord(pInfo->GetNextName(), pDialRecord->GetID());
   }

  return (pDialRecord);
 }
/*===========================================================================
 *		End of Class Method CMWEditDoc::CreateCopyDIAL()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CMWEditDoc Method - CEsmRecord* CreateCopy (pRecord);
 *
 * Creates a copy of the given record, adding the new record to the active
 * file. Returns the new record or NULL on any error.
 *
 *=========================================================================*/
CEsmRecord* CMWEditDoc::CreateCopy (CEsmRecord* pRecord) {
  CEsmRecord* pNewRecord;

	/* Special case for dialogue records */
  if (pRecord->IsType(MWESM_REC_DIAL)) return CreateCopyDIAL((CEsmDialogue *) pRecord);
  
	/* Create the new record */
  pNewRecord = m_ActiveFile.AllocNewRecord(pRecord->GetType());
  if (pNewRecord == NULL) return (NULL);
  m_ActiveFile.AddRecord(pNewRecord);

	/* Initialize the new record */
  pNewRecord->Copy(pRecord);
  pNewRecord->SetFile(&m_ActiveFile);

	/* Special case for CELL records */
  if (pRecord->IsType(MWESM_REC_CELL)) CopyCELLRefs(this, (CEsmCell *) pRecord, (CEsmCell *) pNewRecord);

  return (pNewRecord);
 }
/*===========================================================================
 *		End of Class Method CMWEditDoc::CreateCopy()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CMWEditDoc Method - CEsmRecord* CreateEditCopy (pRecord);
 *
 * Creates a copy of the given record, adding the new record to the active
 * file. Returns the new record or NULL on any error. Extension of the 
 * CreateCopy() method that does not copy all child INFOs for dialogue
 * records.
 *
 *=========================================================================*/
CEsmRecord* CMWEditDoc::CreateEditCopy (CEsmRecord* pRecord) {
  CEsmRecord* pNewRecord;
 
	/* Create the new record */
  pNewRecord = m_ActiveFile.AllocNewRecord(pRecord->GetType());
  if (pNewRecord == NULL) return (NULL);
  m_ActiveFile.AddRecord(pNewRecord);

	/* Initialize the new record */
  pNewRecord->Copy(pRecord);
  pNewRecord->SetFile(&m_ActiveFile);

	/* Special case for CELL records */
  if (pRecord->IsType(MWESM_REC_CELL)) CopyCELLRefs(this, (CEsmCell *) pRecord, (CEsmCell *) pNewRecord);

  return (pNewRecord);
 }
/*===========================================================================
 *		End of Class Method CMWEditDoc::CreateEditCopy()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CMWEditDoc Method - esmrecinfo_t* CreateCopy (pRecInfo, pNewID);
 *
 * Attempts to create a copy of the given record using the given ID. Returns
 * the new recinfo or NULL on any error.
 *
 *=========================================================================*/
esmrecinfo_t* CMWEditDoc::CreateCopy (esmrecinfo_t* pRecInfo, const TCHAR* pNewID) {
  DEFINE_FUNCTION("CMWEditDoc::CreateCopy()");
  esmrecinfo_t* pNewRecInfo;
  bool		Result;
  
	/* Can we create new copies of the record? */
  if (!CanCreateNew(pRecInfo->pRecord->GetType())) {
    ErrorHandler.AddError(ERR_CUSTOM, _T("Cannot create new %s records!"), pRecInfo->pRecord->GetItemType());
    return (NULL);
   }

	/* Check the new ID to ensure it is valid */
  Result = IsValidESMID(pNewID);

  if (!Result) {
    ErrorHandler.AddError(ERR_CUSTOM, _T("The new ID '%s' is not valid!"), pNewID);
    return (NULL);
   }

	/* Is the new ID unique? */
  Result = IsExistingIDDup(pNewID);

  if (Result) {
    ErrorHandler.AddError(ERR_CUSTOM, _T("The new ID '%s' already exists!"), pNewID);
    return (NULL);
   }

	/* Create the new rec info object */
  CreatePointer(pNewRecInfo, esmrecinfo_t);

	/* Copy and initialize the new record */
  pNewRecInfo->pFile = &m_ActiveFile;
  pNewRecInfo->pRecord = CreateCopy(pRecInfo->pRecord);
  pNewRecInfo->pRecord->SetFile(&m_ActiveFile);
  pNewRecInfo->pRecord->SetPrevRecord(NULL);
  pNewRecInfo->pRecord->SetID(pNewID);

  m_RecInfo.Add(pNewRecInfo);
  m_RecInfoSort.SetAt(pNewRecInfo);

  return (pNewRecInfo);
 }
/*===========================================================================
 *		End of Class Method CMWEditDoc::CreateCopy()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CMWEditDoc Method - CEsmRecord* CreateNewRecord (pType);
 *
 * Creates and returns a new record of the given type. Returns NULL on any
 * error. Does not add the record to the current active plugin.
 *
 *=========================================================================*/
CEsmRecord* CMWEditDoc::CreateNewRecord (const TCHAR* pType) {
  CEsmRecord* pRecord;

	/* Cannot create some types of records */
  if (!CanCreateNew(pType)) {
    ErrorHandler.AddError (ERR_BADINPUT, _T("Cannot create new %4.4s records!"), pType);
    return (NULL);
   }
  
	/* Create the new record */
  pRecord = m_ActiveFile.AllocNewRecord(pType);
  if (pRecord == NULL) return (NULL);

	/* Initialize the new record */
  pRecord->CreateNew(&m_ActiveFile);

  return (pRecord);
 }
/*===========================================================================
 *		End of Class Method CMWEditDoc::CreateNewRecord()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CMWEditDoc Method - esmrecinfo_t* CreateNewRecord (pType, pID);
 *
 * Creates a new record of the given type with the given ID in the active
 * file. Returns NULL on any error. Assumes that the given ID doesn't
 * already exist.
 *
 *=========================================================================*/
esmrecinfo_t* CMWEditDoc::CreateNewRecord (const TCHAR* pType, const TCHAR* pID) {
  DEFINE_FUNCTION("CMWEditDoc::CreateNewRecord()");
  esmrecinfo_t* pNewRecInfo;
  CEsmRecord*   pNewRecord;
  bool		Result;

	/* Is the new ID valid? */
  Result = IsValidESMID(pID);

  if (!Result) {
    ErrorHandler.AddError(ERR_BADINPUT, _T("The new ID '%s' is not valid!"), pID);
    return (NULL);
   }

	/* Attempt to create the new record */
  pNewRecord = CreateNewRecord(pType);
  if (pNewRecord == NULL) return (NULL);

	/* Create/initialize the new record object */
  CreatePointer(pNewRecInfo, esmrecinfo_t);
  pNewRecInfo->pFile   = &m_ActiveFile;
  pNewRecInfo->pRecord = pNewRecord;
  pNewRecord->SetFile(&m_ActiveFile);
  pNewRecord->SetID(pID);

  m_ActiveFile.AddRecord(pNewRecord);

  m_RecInfo.Add(pNewRecInfo);
  m_RecInfoSort.SetAt(pNewRecInfo);
	
  return (pNewRecInfo);
 }
/*===========================================================================
 *		End of Class Method CMWEditDoc::CreateNewRecord()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CMWEditDoc Method - void DeleteContents ();
 *
 *=========================================================================*/
void CMWEditDoc::DeleteContents() {
  ClearFileArray();
  ClearRecInfoArray();
  CDocument::DeleteContents();
 }
/*===========================================================================
 *		End of Class Method CMWEditDoc::DeleteContents()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CMWEditDoc Method - bool DeleteRecord (pRecInfo);
 *
 * Deletes (or undeletes) the given record.  Returns false if the record
 * could be deleted/undeleted.
 *
 *=========================================================================*/
bool CMWEditDoc::DeleteRecord (esmrecinfo_t* pRecInfo) {
  CEsmRecord* pRecord;

	/* Can we delete this type of record? */ /*
  if (!CanCreateNew(pRecInfo->pRecord->GetType())) {
    ErrorHandler.AddError(ERR_BADINPUT, _T("Cannot delete '%4.4s' records!"), pRecInfo->pRecord->GetType());
    return (false);
   } //*/

	/* Ensure the record is copied into the active file */
  if (!pRecInfo->pFile->IsActive()) {
    pRecord = m_ActiveFile.CreateCopy(pRecInfo->pRecord);
    pRecord->SetFile(&m_ActiveFile);
    pRecord->SetPrevRecord(pRecInfo->pRecord);
    pRecInfo->pFile = &m_ActiveFile;
    pRecInfo->pRecord = pRecord;
   }

	/* Undelete/delete record */
  pRecInfo->pRecord->DeleteToggle();

	/* If the record is undeleted, check if we need to copy the sub-records into it */
  if (!pRecInfo->pRecord->IsDeleted() && pRecInfo->pRecord->GetNumSubRecords() <= 1) {
    pRecord = pRecInfo->pRecord->GetPrevRecord();
    if (pRecord != NULL) pRecord = pRecord->GetPrevRecord();
 
    if (pRecord != NULL) {
      CString CurrentID = pRecInfo->pRecord->GetID();	/* Save current ID */
      pRecInfo->pRecord->Copy(pRecord);			/* copy old contents */
      pRecInfo->pRecord->SetID(CurrentID);		/* Restore ID */
     }  
    
   }
  
  return (true);
 }
/*===========================================================================
 *		End of Class Method CMWEditDoc::DeleteRecord()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CMWEditDoc Method - bool ExportSpellMerchants (pFilename);
 *
 * Outputs a list of spell merhcants to the given CSV file. The file is
 * overwritten if it exists. Returns false on any error.
 *
 *=========================================================================*/
bool CMWEditDoc::ExportSpellMerchants (const TCHAR* pFilename) {
  CEsmNpc*	pNpc;
  esmrecinfo_t* pRecInfo;
  CGenFile	File;
  int		ArrayIndex;
  bool		SellSpells;
  bool		Result;

	/* Attempt to initialize the given output file */
  m_NumEffectsOutput = 0;
  Result = File.Open(pFilename, "wb");
  if (!Result) return (false);

	/* Output the header row */
  Result = File.Printf(_T("ID,Name,Spell,Effect,Cell,Location\n"));
  if (!Result) return (false);

	/* Enumerate through all NPCs currently loaded */
  pRecInfo = FindFirstRecord(MWESM_REC_NPC_, ArrayIndex);

  while (pRecInfo != NULL) {
    pNpc = (CEsmNpc *) pRecInfo->pRecord;
    //SystemLog.Printf(_T("Merchant NPC = %s"), pNpc->GetID());

		/* Get the ai flags from the class or npc */
    SellSpells = ((GetNPCAiFlags(pNpc) & MWESM_AIFLAG_SPELL) != 0);
    
		/* Only continue if the NPC actually offers spells */
    if (SellSpells) {
      //SystemLog.Printf(_T("\tSells Spells = true"));
      Result = ExportSpellMerchant(pNpc, File);
      if (!Result) return (false);
     }

		/* Get the next NPC */
    pRecInfo = FindNextRecord(MWESM_REC_NPC_, ArrayIndex);
   }

  return (true);
 }
/*===========================================================================
 *		End of Class Method CMWEditDoc::ExportSpellMerchants()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CMWEditDoc Method - bool ExportSpellMerchant (pNpc, File);
 *
 * Exports a single spell merchant NPC to the given CSV file. Returns
 * false on any error.
 *
 *=========================================================================*/
bool CMWEditDoc::ExportSpellMerchant (CEsmNpc* pNpc, CGenFile& File) {
  CEsmSubCellRef*  pCellRef;
  CEsmSubNPCS*	   pSpellName;
  CEsmSpell*	   pSpell;
  esmrecinfo_t*    pRecInfo;
  int		   ArrayIndex;
  bool		   Result;

	/* Clear the effects array */
  memset(m_OutputEffects, 0, sizeof(int)*MWESM_MAX_EFFECTS);

	/* Get the first reference for the NPC, if any */
  pCellRef = FindFirstCellRef(pNpc);
  if (pCellRef == NULL) return (true);
  //SystemLog.Printf(_T("\tFound Cell Ref '%s'"), pCellRef->GetCell()->GetName());

	/* Enumerate through all spells the NPC knows */
  pSpellName = (CEsmSubNPCS *) pNpc->FindFirst(MWESM_SUBREC_NPCS, ArrayIndex);

  while (pSpellName != NULL) {
    //SystemLog.Printf(_T("\tFound Spell '%s'"), pSpellName->GetName());

		/* Find the spell record with the given name */
    pRecInfo = FindRecord(pSpellName->GetName(), MWESM_REC_SPEL);

    if (pRecInfo != NULL) {
      //SystemLog.Printf(_T("\t\tFound Spell Record"));
      pSpell = (CEsmSpell *) pRecInfo->pRecord;
      Result = ExportSpellMerchant(pNpc, pSpell, pCellRef, File);
      if (!Result) return (false);
     }

		/* Get the next spell the NPC knows */
    pSpellName = (CEsmSubNPCS *) pNpc->FindNext(MWESM_SUBREC_NPCS, ArrayIndex);
   }

  return (true);
 }
/*===========================================================================
 *		End of Class Method CMWEditDoc::ExportSpellMerchant()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CMWEditDoc Method - bool ExportSpellMerchant (pNpc, pSpell, pCellRef, File);
 *
 * Exports a single spell from a spell merchant NPC to the given CSV file. 
 * Returns false on any error.
 *
 *=========================================================================*/
bool CMWEditDoc::ExportSpellMerchant (CEsmNpc* pNpc,  CEsmSpell* pSpell,
				      CEsmSubCellRef* pCellRef, CGenFile& File) {
  CEsmSubENAM*  pEnchant;
  int		ArrayIndex;
  int		EffectID;
  bool		Result;

	/* Enumerate through all enchantments in the spell */
  pEnchant = (CEsmSubENAM *) pSpell->FindFirst(MWESM_SUBREC_ENAM, ArrayIndex);

  while (pEnchant != NULL) {
    EffectID = pEnchant->GetEffectID();
    //SystemLog.Printf(_T("\t\tFound Enchantment %d"), EffectID);

		/* Only output the effect if it is valid and not already output for the given NPC */
    if (EffectID >= 0 && EffectID < MWESM_MAX_EFFECTS && m_OutputEffects[EffectID] == 0) {
      Result = ExportSpellMerchant(pNpc, pSpell, pCellRef, EffectID, File);
      if (!Result) return (false);
      m_OutputEffects[EffectID]++;
     }

    pEnchant = (CEsmSubENAM *) pSpell->FindNext(MWESM_SUBREC_ENAM, ArrayIndex);
   }

  return (true);
 }
/*===========================================================================
 *		End of Class Method CMWEditDoc::ExportSpellMerchant()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CMWEditDoc Method - bool ExportSpellMerchant (pNpc, pSpell, pCellRef, EffectID File);
 *
 * Outputs a single effect to the given CSV spell merchant file.
 *
 *=========================================================================*/
bool CMWEditDoc::ExportSpellMerchant (CEsmNpc* pNpc,  CEsmSpell* pSpell,
				      CEsmSubCellRef* pCellRef, const int EffectID, CGenFile& File) {
  bool        Result;
  pos6data_t* pPosData = pCellRef->GetLocation();

  Result  = File.Printf(_T("\"%s\",\"%s\","), pNpc->GetID(), pNpc->GetName());
  Result &= File.Printf(_T("\"%s\",\"%s\","), pSpell->GetName(), GetESMEffect(EffectID));
  Result &= File.Printf(_T("\"%s\","), pCellRef->GetCell()->GetName());

  if (pPosData != NULL)
    Result &= File.Printf(_T("\"(%.0f,%.0f,%.0f)\"\n"), pPosData->PosX, pPosData->PosY, pPosData->PosZ);
  else
    Result &= File.Printf(_T("\"(0,0,0)\"\n"));
  
  m_NumEffectsOutput++;
  return (Result);
 }
/*===========================================================================
 *		End of Class Method CMWEditDoc::ExportSpellMerchant()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CMWEditDoc Method - CEsmSubCellRef* FindFirstCellRef (pRecord);
 *
 * Finds and returns the first reference of the given record in any cell.
 * Returns NULL on any error.
 *
 *=========================================================================*/
CEsmSubCellRef* CMWEditDoc::FindFirstCellRef (CEsmRecord* pRecord) {
  CEsmCell*       pCell;
  CEsmSubCellRef* pCellRef;
  esmrecinfo_t*   pRecInfo;
  int		  ArrayIndex;

	/* Look through all cell records */
  pRecInfo = FindFirstRecord(MWESM_REC_CELL, ArrayIndex);

  while (pRecInfo != NULL) { 
    pCell = (CEsmCell *) pRecInfo->pRecord;

		/* Try and find a reference for the record in the cell */
    pCellRef = pCell->FindFirstCellRef(pRecord);
    if (pCellRef != NULL) return (pCellRef);

    pRecInfo = FindNextRecord(MWESM_REC_CELL, ArrayIndex);
   }

	/* None found */
  return (NULL);
 }
/*===========================================================================
 *		End of Class Method CMWEditDoc::FindFirstCellRef()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CMWEditDoc Method - esmrecinfo_t* FindExistingRecord (pID, pType);
 *
 * Attempts to find a record with the given ID and of the given type.
 * If the given ID is not found, NULL is returned. If the ID is found but not
 * of the given type, the record is still returned.
 *
 *=========================================================================*/
esmrecinfo_t* CMWEditDoc::FindExistingRecord (const TCHAR* pID, const TCHAR* pType) {
  esmrecinfo_t* pRecInfo;
  TCHAR         TempBuffer[MWESM_ID_MAXSIZE*2+1];
  TCHAR*        pTempID = RemoveIDQuotes(TempBuffer, pID);
  //int           Index;

  pRecInfo = m_RecInfoSort.Get(pTempID);
  if (pRecInfo == NULL) return (NULL);
  return (pRecInfo);
  
	/* Find the record with the given ID, any type */
  //Index = m_RecInfo.FindFastFunc(l_FindRecNameSort, pTempID);
  //if (Index < 0) return (NULL);
  //pRecInfo = m_RecInfo[Index];
  
	/* Does the type match? */
  //if (pRecInfo && pRecInfo->pRecord->IsType(pType)) return pRecInfo;
  //esmrecinfo_t* pRecInfoN1 = m_RecInfo[Index - 1];
  //esmrecinfo_t* pRecInfoN2 = m_RecInfo[Index - 2];
  //esmrecinfo_t* pRecInfoP1 = m_RecInfo[Index + 1];
  //esmrecinfo_t* pRecInfoP2 = m_RecInfo[Index + 2];

	/* Check records 2 on each side of found record for matching ID and type */
  //if (pRecInfoN1 && pRecInfoN1->pRecord->IsID(pID) && pRecInfoN1->pRecord->IsType(pType)) return pRecInfoN1;
  //if (pRecInfoN2 && pRecInfoN2->pRecord->IsID(pID) && pRecInfoN2->pRecord->IsType(pType)) return pRecInfoN2;
  //if (pRecInfoP1 && pRecInfoP1->pRecord->IsID(pID) && pRecInfoP1->pRecord->IsType(pType)) return pRecInfoP1;
  //if (pRecInfoP2 && pRecInfoP2->pRecord->IsID(pID) && pRecInfoP2->pRecord->IsType(pType)) return pRecInfoP2;

	/* Return initial record with matching ID but *not* type */
  return pRecInfo;
 }
/*===========================================================================
 *		End of Class Method CMWEditDoc::FindExistingRecord()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CMWEditDoc Method - esmrecinfo_t* FindNextRecord (pType, ArrayIndex);
 *
 * Find the next record after the given input array index.  Returns NULL
 * if the record of the given type is not found.
 *
 *=========================================================================*/
esmrecinfo_t* CMWEditDoc::FindNextRecord (const TCHAR* pType, int& ArrayIndex) {
  esmrecinfo_t* pRecInfo;

  for (ArrayIndex++ ; ArrayIndex < m_RecInfo.GetSize(); ArrayIndex++) {
    pRecInfo = m_RecInfo.GetAt(ArrayIndex);
    if (pRecInfo->pRecord->IsType(pType)) return (pRecInfo);
   } 

	/* None found */
  return (NULL);
 }
/*===========================================================================
 *		End of Class Method CMWEditDoc::FindNextRecord()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CMWEditDoc Method - esmrecinfo_t* FindNextItem (ArrayIndex);
 *
 * Find the next item after the given input array index.  Returns NULL
 * if not more item records are found.
 *
 * Items are include: Armor, Weapons, Clothing, Misc, Apparatus, Probe
 * Pick, Repair, Alchemy, Book, Ingrediant, Light
 *
 *=========================================================================*/
esmrecinfo_t* CMWEditDoc::FindNextItem (int& ArrayIndex) {
  esmrecinfo_t* pRecInfo;

  for (ArrayIndex++ ; ArrayIndex < m_RecInfo.GetSize(); ArrayIndex++) {
    pRecInfo = m_RecInfo.GetAt(ArrayIndex);
    if (IsESMRecordCarryable(pRecInfo->pRecord->GetType())) return (pRecInfo);
   }
	/* None found */
  return (NULL);
 }
/*===========================================================================
 *		End of Class Method CMWEditDoc::FindNextItem()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CMWEditDoc Method - esmrecinfo_t* FindRecInfoByPtr (pRecord);
 *
 *=========================================================================*/
esmrecinfo_t* CMWEditDoc::FindRecInfoByPtr (CEsmRecord* pRecord) {
  esmrecinfo_t* pRecInfo;
  int	        Index;

  for (Index = 0; Index < m_RecInfo.GetNumElements(); ++Index) {
    pRecInfo = m_RecInfo.GetAt(Index);
    if (pRecInfo->pRecord == pRecord) return (pRecInfo);
   }

  return (NULL);
}
/*===========================================================================
 *		End of Class Method CMWEditDoc::FindRecInfoByPtr()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CMWEditDoc Method - esmrecinfo_t* FindRecInfo (pRecord);
 *
 * Returns an existing record info array element of the given item.
 * Returns NULL if it is not found.
 *
 *=========================================================================*/
esmrecinfo_t* CMWEditDoc::FindRecInfo (CEsmRecord* pRecord) {
  esmrecinfo_t* pRecInfo;
  //const TCHAR*	pID1;
  //const TCHAR*	pID2;
  //int		Index;
  //int		Result;

	/* Try a quick binary search */
  if (pRecord == NULL) return (NULL);
  pRecInfo = FindRecord(pRecord->GetID());

  if (pRecInfo != NULL) {
    if (pRecInfo->pRecord->IsSame(pRecord)) return (pRecInfo);
   }

/*
  for (Index = 0; Index < m_RecInfo.GetSize(); Index++) {
    pRecInfo = m_RecInfo.GetAt(Index);
    if (pRecInfo->pRecord->IsSame(pRecord)) return (pRecInfo);

    pID1 = pRecInfo->pRecord->GetID();
    pID2 = pRecord->GetID();
    if (tolower(*pID1) != tolower(*pID2)) continue;
    Result = TSTRICMP(pRecInfo->pRecord->GetID(), pRecord->GetID());
    if (Result > 0) break;

    //SystemLog.Printf ("%s == %s", pRecInfo->pRecord->GetID(), pRecord->GetID());
   }//*/

  return (NULL);
 }


esmrecinfo_t* CMWEditDoc::FindRecord (const TCHAR* pID) {
  //int 	Index;
  int	Length;
  TCHAR TempBuffer[MWESM_ID_MAXSIZE*2+1];

	/* Remove ID quotes if required */
  if (*pID == '"') { 
    strnncpy(TempBuffer, pID + 1, MWESM_ID_MAXSIZE*2);
    Length = TSTRLEN(TempBuffer);
    if (Length > 0) TempBuffer[Length - 1] = NULL_CHAR;

    //Index = m_RecInfo.FindFastFunc(l_FindRecNameSort, (void*) TempBuffer);
    //Index = m_RecInfo.FindBSearch(l_RecSortPtr, (void *)pID);
    return m_RecInfoSort.Get(TempBuffer);
   }
  else {
    //Index = m_RecInfo.FindFastFunc(l_FindRecNameSort, (void*) pID);
    //Index = m_RecInfo.FindBSearch(l_RecSortPtr, (void *)pID);
    return m_RecInfoSort.Get(pID);
   }

  //if (Index < 0) return (NULL);
  //return m_RecInfo[Index];
 }

	/* Looks for a given ID of the given type */
esmrecinfo_t* CMWEditDoc::FindRecord (const TCHAR* pID, const TCHAR* pType) {
  TCHAR         TempBuffer[MWESM_ID_MAXSIZE*2+1];
  esmrecinfo_t* pRecInfo;
  const TCHAR*  pNewID = pID;
  int	        Length;
  int           Index;

	/* Remove ID quotes if required */
  if (*pID == '"') { 
    strnncpy(TempBuffer, pID + 1, MWESM_ID_MAXSIZE*2);
    Length = TSTRLEN(TempBuffer);
    if (Length > 0 && TempBuffer[Length - 1] == '"') TempBuffer[Length - 1] = NULL_CHAR;
    pNewID = TempBuffer;
  }

  //SystemLog.Printf("FindRecord(%s, %4.4s)", pNewID, pType);
  pRecInfo = m_RecInfoSort.Get(pNewID);
  if (pRecInfo != NULL && pRecInfo->pRecord->IsType(pType)) return (pRecInfo);

	/* Revert to 'slow' search */
  for (Index = 0; Index < m_RecInfo.GetNumElements(); ++Index) {
    pRecInfo = m_RecInfo.GetAt(Index);

    if (!pRecInfo->pRecord->IsType(pType)) continue;
    if (!pRecInfo->pRecord->IsID(pID)) continue;
    return (pRecInfo);
  }

	/* No match */
  return (NULL);
 }


	/* Looks for a given ID which is carryable */
esmrecinfo_t* CMWEditDoc::FindRecordCarryable (const TCHAR* pID) {
  TCHAR         TempBuffer[MWESM_ID_MAXSIZE*2+1];
  esmrecinfo_t* pRecInfo;
  const TCHAR*  pNewID = pID;
  int	        Length;
  int           Index;

	/* Remove ID quotes if required */
  if (*pID == '"') { 
    strnncpy(TempBuffer, pID + 1, MWESM_ID_MAXSIZE*2);
    Length = TSTRLEN(TempBuffer);
    if (Length > 0 && TempBuffer[Length - 1] == '"') TempBuffer[Length - 1] = NULL_CHAR;
    pNewID = TempBuffer;
  }

  //SystemLog.Printf("FindRecord(%s, %4.4s)", pNewID, pType);
  pRecInfo = m_RecInfoSort.Get(pNewID);
  if (pRecInfo != NULL && IsESMRecordCarryable(pRecInfo->pRecord->GetType())) return (pRecInfo);

	/* Revert to 'slow' search */
  for (Index = 0; Index < m_RecInfo.GetNumElements(); ++Index) {
    pRecInfo = m_RecInfo.GetAt(Index);

    //if (!pRecInfo->pRecord->IsType(pType)) continue;
    if (!pRecInfo->pRecord->IsID(pID)) continue;
    if (IsESMRecordCarryable(pRecInfo->pRecord->GetType())) return (pRecInfo);
  }

	/* No match */
  return (NULL);
}


esmrecinfo_t* CMWEditDoc::FindRecordSort (CEsmRecord* pRecord) {
  return m_RecInfoSort.Get(pRecord->GetID());
  //int Index = m_RecInfoSort.FindFastFunc(l_FindRecSort1, (void*) pRecord);
  //if (Index < 0) return (NULL);
  //return (m_RecInfo[Index]);
 }


	/* Looks for a given ID of the given type with the given dialogue parent */
esmrecinfo_t* CMWEditDoc::FindInfoRecord (const TCHAR* pID, const TCHAR* pDialID) {
  //MWMAPPOS      Position;
  CEsmInfo*	pInfo;
  esmrecinfo_t* pRecInfo;
  int		Index;

	/* Revert to 'slow' search */
  for (Index = 0; Index < m_RecInfo.GetNumElements(); ++Index) {
    pRecInfo = m_RecInfo.GetAt(Index);

    if (!pRecInfo->pRecord->IsType(MWESM_REC_INFO)) continue;
    if (!pRecInfo->pRecord->IsID(pID)) continue;
    pInfo = (CEsmInfo *) pRecInfo->pRecord;

    if (pInfo->GetDialParent() && pInfo->GetDialParent()->IsID(pDialID)) return (pRecInfo);
  }

  /*

  if (m_RecInfoSort.Lookup(pID, pRecInfo)) {
    SystemLog.Printf("Lookup found info record ID %s!", pID);
  }
  else {
     SystemLog.Printf("Lookup did not find info record ID %s!", pID);
  }

  pRecInfo = m_RecInfoSort.GetFirstRecordKey(pID, Position);
  if (pRecInfo == NULL) SystemLog.Printf("No info record found for ID %s!", pID);
  
  while (pRecInfo != NULL) {
    SystemLog.Printf("Found info record ID %s!", pID);

    if (pRecInfo->pRecord->IsType(MWESM_REC_INFO)) {
      pInfo = (CEsmInfo *) pRecInfo->pRecord;

      if (pInfo->GetDialParent() != NULL && pInfo->GetDialParent()->IsID(pDialID)) {
        return (pRecInfo);
      }
      else {
        SystemLog.Printf("\t  Dialogue parent does not match (%s != %s)!", pDialID, pInfo->GetDialParent()->GetID());
      }
    }
    else {
      SystemLog.Printf("\t  No an INFO record!");
    }

    pRecInfo = m_RecInfoSort.GetNextRecordKey(pID, Position);
  }//*/

  return (NULL);
}
/*===========================================================================
 *		End of Class Method CMWEditDoc::FindRecInfo()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CMWEditDoc Method - long GetNPCAiFlags (pNpc);
 *
 * Gets the AI flags from the given NPC or the NPC's class if it is 
 * auto-calc.
 *
 *=========================================================================*/
long CMWEditDoc::GetNPCAiFlags (CEsmNpc* pNpc) {

	/* Ignore invalid input */
  if (pNpc == NULL) return (0);

	/* Return the NPC flags if the autocalc flag is cleared */
  if (!pNpc->IsAutoCalc()) return (pNpc->GetAIFlags());
  
	/* Otherwise get the class AI autocalc flags */
  esmrecinfo_t* pRecInfo = FindRecord(pNpc->GetClass(), MWESM_REC_CLAS);
  if (pRecInfo == NULL) return (0);
  CEsmClass* pClass = (CEsmClass *) pRecInfo->pRecord;

  return (pClass->GetAutoCalcFlags());
 }
/*===========================================================================
 *		End of Class Method CMWEditDoc::GetNPCAiFlags()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CMWEditDoc Method - esmrecinfo_t* GetEffectRecord (EffectID);
 *
 *=========================================================================*/
esmrecinfo_t* CMWEditDoc::GetEffectRecord (const int EffectID) {
  CEsmMagicEffect* pEffect;
  esmrecinfo_t*    pRecInfo;
  int		   RecordIndex;
  
  pRecInfo = FindFirstRecord(MWESM_REC_MGEF, RecordIndex);

  while (pRecInfo != NULL) {
    pEffect = (CEsmMagicEffect *) pRecInfo->pRecord;
    if (pEffect->IsEffect(EffectID)) return (pRecInfo);

    pRecInfo = FindNextRecord(MWESM_REC_MGEF, RecordIndex);
   }

	/* Not found */
  return (NULL);
 }
/*===========================================================================
 *		End of Class Method CMWEditDoc::GetEffectRecord()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CMWEditDoc Method - CEsmGlobal* GetGlobal (pName);
 *
 * Attempt to return the given global record, or NULL if it is not found.
 *
 *=========================================================================*/
CEsmGlobal* CMWEditDoc::GetGlobal (const TCHAR* pName) {
  esmrecinfo_t* pRecInfo;

	/* Attempt to find a record with the given ID */
  pRecInfo = FindRecord(pName, MWESM_REC_GLOB);
  if (pRecInfo == NULL) return (NULL);

	/* Ensure the record is a global */
  if (!pRecInfo->pRecord->IsType(MWESM_REC_GLOB)) return (NULL);

  return ((CEsmGlobal *)pRecInfo->pRecord);
 }
/*===========================================================================
 *		End of Class Method CMWEditDoc::GetGlobal()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CMWEditDoc Method - esmrecinfo_t* GetInfoStart (pDialog);
 *
 * Finds the start of the INFO linked list for the given dialog record.
 * Returns if the dialog has no INFO records.
 *
 *=========================================================================*/
esmrecinfo_t* CMWEditDoc::GetInfoStart (esmrecinfo_t* pDialog) {
  return GetInfoStart((CEsmDialogue *) pDialog->pRecord);
 }

esmrecinfo_t* CMWEditDoc::GetInfoStart (CEsmDialogue* pDialRecord) {
  esmrecinfo_t* pRecInfo;
  esmrecinfo_t* pPrevRecInfo;
  CEsmRecord*   pRecord;
  CEsmRecord*   pInfoRecord = NULL;
  CEsmInfo*     pInfo;
  CEsmInfo*     pLastValidInfo;
  esmrecinfo_t* pLastValidRecInfo;
  int		Index;
  
  pRecord = pDialRecord;

	/* Search for any child INFOs of the dialog in all parent plugins */ 
  while (pRecord != NULL) {
    ASSERT(pRecord->GetFile() != NULL);
    Index = pRecord->GetFile()->FindRecord(pRecord);

    if (Index >= 0) {
      pInfoRecord = pRecord->GetFile()->GetRecord(Index + 1);
      if (pInfoRecord != NULL && pInfoRecord->IsType(MWESM_REC_INFO)) break;
      pInfoRecord = NULL;
     }
	
	/* Get any previous record in another plugin */ 
    pRecord = pRecord->GetPrevRecord();
   }

  pInfo = (CEsmInfo *) pInfoRecord;

/*
  if (pInfoRecord != NULL) 
	SystemLog.Printf("%s: Start info = %s (%s)!", pDialRecord->GetID(), pInfoRecord->GetID(), pInfo->GetResponse());
  else
	SystemLog.Printf("%s: No start info found!", pDialRecord->GetID()); //*/

	/* Dialogue has no INFO child records */
  if (pInfoRecord == NULL) return (NULL);
  
  pLastValidInfo    = pInfo;
  //pLastValidRecInfo = FindRecInfoByPtr(pInfo);
  pLastValidRecInfo = FindInfoRecord(pInfo->GetID(),  pDialRecord->GetID());

/*
  if (pLastValidRecInfo == NULL) {
    SystemLog.Printf("%s: No start info recinfo found!", pDialRecord->GetID());
    return (NULL);
   } //*/

  //SystemLog.Printf("\t  Rec Start info = %s (%s)!", pLastValidRecInfo->pRecord->GetID(), ((CEsmInfo *)(pLastValidRecInfo->pRecord))->GetResponse());

  //pPrevRecInfo = FindRecord(pInfo->GetID());
  //if (pPrevRecInfo == NULL) return (NULL);
  //pInfo     = (CEsmInfo *) pPrevRecInfo->pRecord;

	/* Find the linked list head */
  while (pInfo->GetPrevName()[0] != NULL_CHAR) { 
    //pRecInfo = FindRecord(pInfo->GetPrevName());
    pRecInfo = FindInfoRecord(pInfo->GetPrevName(),  pDialRecord->GetID());
    if (pRecInfo == NULL) return (pLastValidRecInfo);

    pInfo = (CEsmInfo *) pRecInfo->pRecord;
    pPrevRecInfo = pRecInfo;

		/* Ensure the dialogue parent IDs match */
    //if (pInfo->GetDialParent() != NULL && pInfo->GetDialParent()->IsID(pDialRecord->GetID())) {
      //SystemLog.Printf("\t  Found prev info %s", pInfo->GetID());
      pLastValidInfo    = pInfo;
      pLastValidRecInfo = pRecInfo;
    //}
   }

  return (pLastValidRecInfo);
 }
/*===========================================================================
 *		End of Class Method CMWEditDoc::GetInfoStart()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CMWEditDoc Method - esmrecinfo_t* ImportScript (pFilename);
 *
 * Attempt to import the script from the given file. Returns the new/modified
 * record on success, or NULL on any error.
 *
 *=========================================================================*/
esmrecinfo_t* CMWEditDoc::ImportScript (const TCHAR* pFilename) {
  CEsmScriptCompile ScriptCompiler;
  CSString	    Buffer;
  CEsmScript*       pScript;
  CEsmSubSCHD*	    pScriptHeader;
  esmrecinfo_t*	    pRecInfo;
  bool		    Result;
  int		    iResult;

	/* Attempt to input the file */
  Result = ReadFile(Buffer, pFilename);
  if (!Result) return (NULL);

	/* Check for a too large of a script */
  if (Buffer.GetLength() > ESM_SCRIPT_MAXTEXT) {
    ErrorHandler.AddError(ERR_MAXINDEX, _T("Script text exceeds the maximum length of %d!"), ESM_SCRIPT_MAXTEXT);
    return (NULL);
   }

	/* Try compiling the script */
  ScriptCompiler.SetScriptText(Buffer, Buffer.GetLength());
  ScriptCompiler.SetDocument(this);
  iResult = ScriptCompiler.Compile();

	/* Does the script have an ID? */
  if (!ScriptCompiler.HasScriptName()) {
    ErrorHandler.AddError(ERR_CUSTOM, _T("File '%s' contains no script name!"), pFilename);
    return (NULL);
   }

	/* Find an existing script object */
  pRecInfo = FindExistingRecord(ScriptCompiler.GetScriptName(), MWESM_REC_SCPT);

	/* Ignore if an existing record of the incorrect type exists */
  if (pRecInfo != NULL && !pRecInfo->pRecord->IsType(MWESM_REC_SCPT)) {
    ErrorHandler.AddError(ERR_CUSTOM, _T("The existing record '%s' is not a script!"), ScriptCompiler.GetScriptName());
    return (NULL);
   }

	/* Create and initialize the new/modified record */
  if (pRecInfo != NULL) 
    pRecInfo = CopyToActive(pRecInfo);
  else 
    pRecInfo = CreateNewRecord(MWESM_REC_SCPT, ScriptCompiler.GetScriptName());
    
  if (pRecInfo == NULL) return (NULL);

	/* Update the script data */
  pScript = (CEsmScript *) pRecInfo->pRecord;
  pScriptHeader = pScript->GetScriptHeader();
  pScript->SetScriptText(Buffer);
  pScriptHeader->GetScriptHeadData()->LocalVarSize = ScriptCompiler.GetLocalVarDataSize();
  pScriptHeader->GetScriptHeadData()->ScriptDataSize = ScriptCompiler.GetScriptDataSize();
  pScriptHeader->GetScriptHeadData()->NumShorts = ScriptCompiler.GetNumShortLocals();
  pScriptHeader->GetScriptHeadData()->NumLongs  = ScriptCompiler.GetNumLongLocals();
  pScriptHeader->GetScriptHeadData()->NumFloats = ScriptCompiler.GetNumFloatLocals();
  pScript->GetScriptVars()->CopyData(ScriptCompiler.GetLocalVarData(), ScriptCompiler.GetLocalVarDataSize());;
  pScript->GetScriptData()->CopyData(ScriptCompiler.GetScriptData(),   ScriptCompiler.GetScriptDataSize());

  return (pRecInfo);
 }
/*===========================================================================
 *		End of Class Method CMWEditDoc::ImportScript()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CMWEditDoc Method - bool IsExistingIDDup (pID);
 *
 * Checks for an existing record with the same ID.  Does not check record
 * types that allow duplicated IDs (such as the sound gen records). Returns
 * true if the ID currently exists.
 *
 *=========================================================================*/
bool CMWEditDoc::IsExistingIDDup (const TCHAR* pID) {
  esmrecinfo_t* pRecInfo;
  MWMAPPOS      Position;

  for (pRecInfo = m_RecInfoSort.GetFirstRecordKey(pID, Position); pRecInfo != NULL; pRecInfo = m_RecInfoSort.GetNextRecordKey(pID, Position)) {

		/* Ignore certain record types */
    if (pRecInfo->pRecord->IsType(MWESM_REC_SNDG)) continue;

		/* Special case for Exterior CELLS which can have non-unique IDs */
    if (pRecInfo->pRecord->IsType(MWESM_REC_CELL)) {
      CEsmCell* pCell = (CEsmCell *) pRecInfo->pRecord;
      if (!pCell->IsInterior()) continue;
     }

		/* Compare IDs */
    if (pRecInfo->pRecord->IsID(pID)) return (true);
   }

	/* No match found */
  return (false);
 }
/*===========================================================================
 *		End of Class Method CMWEditDoc::IsExistingIDDup()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CMWEditDoc Method - bool LoadScriptFile (pFilename);
 *
 * Loads the given plugin for script comparison. Returns false on any
 * error.
 *
 *=========================================================================*/
bool CMWEditDoc::LoadScriptFile (const TCHAR* pFilename) {
  bool Result;

	/* Clear the current script comparison data */
  m_ScriptFilename.Empty();
  m_ScriptFile.Destroy();

	/* Attempt to load the plugin */
  Result = m_ScriptFile.Read(pFilename);
  if (!Result) return (false);

  m_ScriptFilename = pFilename;
  return (true);
}
/*===========================================================================
 *		End of Class Method CMWEditDoc::LoadScriptFile()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CMWEditDoc Event - BOOL OnNewDocument ();
 *
 *=========================================================================*/
BOOL CMWEditDoc::OnNewDocument() {
  CEsmTES3* pHeader;
  int       ArrayIndex;

	/* Call the base class method first */
  if (!CDocument::OnNewDocument()) return FALSE;

	/* Setup the active plugin */
  m_ActiveFile.CreateNew();
  m_ActiveFile.SetActive(true);

	/* Set the default author name */
  pHeader = (CEsmTES3 *) m_ActiveFile.FindFirst(MWESM_REC_TES3, ArrayIndex);

  if (pHeader != NULL) {
    strnncpy(pHeader->GetHeaderData()->Author, GetEsmOptDefaultAuthor(), MWESM_HEDR_AUTHORSIZE-1);
   }

  return (TRUE);
 }
/*===========================================================================
 *		End of Class Event CMWEditDoc::OnNewDocument()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CMWEditDoc Method - void Serialize (CArchive& ar);
 *
 * Description
 *
 *=========================================================================*/
void CMWEditDoc::Serialize(CArchive& ar) {
 }
/*===========================================================================
 *		End of Class Method CMWEditDoc::Serialize()
 *=========================================================================*/


#ifdef _DEBUG
/*===========================================================================
 *
 * Class CMWEditDoc Diagnostics
 * 
 *=========================================================================*/
void CMWEditDoc::AssertValid() const {
  CDocument::AssertValid();
 }

void CMWEditDoc::Dump(CDumpContext& dc) const {
  CDocument::Dump(dc);
 }
/*===========================================================================
 *		End of Class CMWEditDoc Diagnostics
 *=========================================================================*/
#endif

/*===========================================================================
 *
 * Class CMWEditDoc Method - bool LoadAppMasters (void);
 *
 *=========================================================================*/
bool CMWEditDoc::LoadAppMasters (void) {
  DEFINE_FUNCTION("CMWEditDoc::LoadAppMasters()");
  CMWEditApp* pApp = (CMWEditApp *) AfxGetApp();
  POSITION    FilePos;
  CEsmFile*   pFile;

	/* Add all the master plugins from the application data */
  for (FilePos = pApp->m_Masters.GetHeadPosition(); FilePos != NULL; pApp->m_Masters.GetNext(FilePos)) {
    pFile = GetApp()->LoadMaster(pApp->m_Masters.GetAt(FilePos), &m_LoadDlg);
    if (pFile == NULL) return (false);

    m_NumFiles++;
    AddRecInfo(pFile);
   }

  return (true);
 }
/*===========================================================================
 *		End of Class Method CMWEditDoc::LoadAppMasters()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CMWEditDoc Method - bool LoadAppPlugins (void);
 *
 *=========================================================================*/
bool CMWEditDoc::LoadAppPlugins (void) {
  DEFINE_FUNCTION("CMWEditDoc::LoadAppPlugins()");
  CMWEditApp* pApp = (CMWEditApp *) AfxGetApp();
  POSITION    FilePos;
  CEsmFile*   pFile;
  bool        Result;

	/* Add all the regular plugins */
  for (FilePos = pApp->m_Plugins.GetHeadPosition(); FilePos != NULL; pApp->m_Plugins.GetNext(FilePos)) {
    CreatePointer(pFile, CEsmFile);
    m_EsmFiles.Add(pFile);

		/* Initialize the load callback */
    m_LoadDlg.SetFilename(pApp->m_Plugins.GetAt(FilePos));
    m_LoadDlg.SetSubLabel(_T("Loading..."));
    m_LoadDlg.SetProgress(0.0f);
    pFile->SetCallback(g_EsmLoadDlgCallback, (long) &m_LoadDlg);

    Result = pFile->Read(pApp->m_Plugins.GetAt(FilePos));
    if (!Result) return (false);

    m_NumFiles++;
    AddRecInfo(pFile);
   }

  return (true);
 }
/*===========================================================================
 *		End of Class Method CMWEditDoc::LoadAppPlugins()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CMWEditDoc Method - bool LoadAppActive (void);
 *
 *=========================================================================*/
bool CMWEditDoc::LoadAppActive (void) {
  CMWEditApp* pApp = (CMWEditApp *) AfxGetApp();
  bool        Result;

	/* If no active plugin, create an empty one */
  if (pApp->m_ActivePlugin.IsEmpty()) {
    m_ActiveFile.CreateNew();
    m_ActiveFile.SetActive(true);
    return (true);
   }

	/* Initialize the load callback */
  m_LoadDlg.SetFilename(pApp->m_ActivePlugin);
  m_LoadDlg.SetProgress(0.0f);
  m_LoadDlg.SetSubLabel(_T("Loading..."));
  m_ActiveFile.SetCallback(g_EsmLoadDlgCallback, (long) &m_LoadDlg);

  m_ActiveFile.SetActive(true);
  Result = m_ActiveFile.Read(pApp->m_ActivePlugin);
  if (!Result) return (false);

  m_NumFiles++;
  AddRecInfo(&m_ActiveFile);

  return (true);
 }
/*===========================================================================
 *		End of Class Method CMWEditDoc::LoadAppActive()
 *=========================================================================*/


/*===========================================================================
 *
 * Class TCHAR* CMWEditDoc Method - const MakeNewINFOId (void);
 *
 * Creates and returns a new INFO ID string (uses a local static string).
 * The INFO id is a digit string at most 32 bytes in length and will be a
 * uniue ID for the current set of plugins/masters.
 * 
 * The ID is composed of the following:
 *	bytes  0- 9: Current system time
 *	bytes 10-19: Drive c: serial number (or clock ticks)
 *	bytes 20-29: Incremented counter per application session
 *
 *	32  bits = 10 bytes
 *	64  bits = 20 bytes
 *	80  bits = 25 bytes
 *	96  bits = 29 bytes
 *	112 bits = 34 bytes
 *	128 bits = 39 bytes
 *	
 *=========================================================================*/
const TCHAR* CMWEditDoc::MakeNewINFOId (void) {
  static TCHAR	s_Buffer[MWESM_ID_MAXSIZE+4];
  static long	s_Counter = 1;
  time_t	CurrentTime = time(NULL);
  BOOL		Result;
  DWORD		SerialNumber;
 
	/* Attempt to get a drive serial number */
  Result = GetVolumeInformation(_T("c:\\"), NULL, 0, &SerialNumber, NULL, NULL, NULL, 0);

	/* Generate a 'random' serial number if the previous call failed */  
  if (!Result) {
    SerialNumber = (DWORD) clock();
   }

	/* Make the ID string */
  snprintf (s_Buffer, 31, _T("%lu%010lu%010lu"), s_Counter, CurrentTime, SerialNumber);
  //SystemLog.Printf ("INFO = '%s'", s_Buffer);
  s_Counter++;

	/* Ensure it is unique */
  if (IsExistingIDDup(s_Buffer)) return MakeNewINFOId();
  return (s_Buffer);
 }
/*===========================================================================
 *		End of Class Method TCHAR* CMWEditDoc::MakeNewINFOId()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CMWEditDoc Event - int OnCheckNewID (pRecEditInfo);
 *
 *=========================================================================*/
int CMWEditDoc::OnCheckNewID (esmreceditinfo_t* pRecEditInfo) {
  DEFINE_FUNCTION("CEsmRecDialog::OnCheckNewID()");
  esmrecinfo_t* pRecInfo;
  CEsmRecord*   pRecord;
  CString	Buffer;
  int		Result;

	/* Is the new ID valid? */
  Result = IsValidESMID(pRecEditInfo->NewID);

  if (!Result) {
    Buffer.Format(_T("The new ID '%s' is not valid!"), pRecEditInfo->NewID);
    AfxMessageBox(Buffer);
    return (MWESM_ONSAVE_ERROR);
   }

	/* Is the new ID unique? */
  Result = IsExistingIDDup(pRecEditInfo->NewID);

  if (Result) {
    Buffer.Format(_T("The new ID '%s' already exists!"), pRecEditInfo->NewID);
    AfxMessageBox(Buffer);
    return (MWESM_ONSAVE_ERROR);
   }

	/* If the record is new, don't ask user to copy or rename */
  if (pRecEditInfo->IsNew) return (MWESM_ONSAVE_OK);

	/* Prompt user to create new or rename (or cancel) */
  Buffer.Format(_T("Object '%s' has been changed to '%s'!\n\r\n\rDo you wish to create a new object?\n\rChoose Yes to create a new object, or No to rename."), pRecEditInfo->OldID, pRecEditInfo->NewID);
  Result = MessageBox(AfxGetMainWnd()->m_hWnd, Buffer, _T("Create New Object?"), MB_YESNOCANCEL | MB_ICONQUESTION);
  if (Result == IDCANCEL) return (MWESM_ONSAVE_ERROR);

	/* Create a new copy of the record if requested */
  if (Result == IDYES) {
    pRecord = CreateEditCopy(pRecEditInfo->pRecInfo->pRecord);
    if (pRecord == NULL) return (MWESM_ONSAVE_ERROR);

    CreatePointer(pRecInfo, esmrecinfo_t);
    pRecord->SetPrevRecord(NULL);
    pRecInfo->pRecord = pRecord;
    pRecInfo->pFile   = pRecord->GetFile();
    
    pRecEditInfo->pRecInfo  = pRecInfo;
    pRecEditInfo->IsNew     = true;
    pRecEditInfo->IsCopied  = true;
    pRecEditInfo->IsRenamed = false;
   }
	/* Must rename an existing object */
  else {
    pRecEditInfo->IsCopied  = false;
    pRecEditInfo->IsRenamed = true;
    pRecEditInfo->HasAdded  = true;
   }

  return (MWESM_ONSAVE_OK);
 }
/*===========================================================================
 *		End of Class Event CMWEditDoc::OnCheckNewID()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CMWEditDoc Event - BOOL OnOpenDocument (lpszPathName);
 *
 *=========================================================================*/
BOOL CMWEditDoc::OnOpenDocument (LPCTSTR lpszPathName) {
  DEFINE_FUNCTION("CMWEditDoc::OnOpenDocument()");
  bool	Result;

	/* Clear any current info */
  ClearRecInfoArray();
  ClearFileArray();
  m_NumFiles = 0;

	/* Display the load dialog */
  m_LoadDlg.Create(IDD_LOAD_DLG, GetActiveView());
  m_LoadDlg.ShowWindow(SW_SHOWNORMAL);

	/* Load all the required plugins */
  Result = LoadAppMasters();
  if (Result) Result = LoadAppPlugins();
  if (Result) Result = LoadAppActive();

	/* Hide the load dialog */
  m_LoadDlg.CloseWindow();
  m_LoadDlg.DestroyWindow();

  if (!Result) {
    ErrorHandler.Notify(_T("Plugin Load Error!"));
    return (FALSE);
   }
  
  //m_RecInfo.SetCompareFunc(l_RecInfoSortPtr);
  //m_RecInfo.Sort(0);
  //m_RecInfo.SetCompareFunc(l_RecInfoSort);

  SetModifiedFlag(FALSE);
  return TRUE;
 }
/*===========================================================================
 *		End of Class Event CMWEditDoc::OnOpenDocument()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CMWEditDoc Event - int OnPostSaveRecord (pRecEditInfo);
 *
 * Called after the given record is updated.
 *
 *=========================================================================*/
int CMWEditDoc::OnPostSaveRecord (esmreceditinfo_t* pRecEditInfo) {

	/* Attempt to add the record if it is new */
  if (pRecEditInfo->IsNew) {
    pRecEditInfo->IsNew = false;
    UpdateAllViews(NULL, MWEDITDOC_HINT_NEWITEM, (CObject*)(void*)pRecEditInfo->pRecInfo);
   }
	/* Update the document views */
  else {
    UpdateAllViews(NULL, MWEDITDOC_HINT_UPDATEITEM, (CObject*)(void*)pRecEditInfo->pRecInfo);
   }

  SetModifiedFlag(TRUE);
  return (0);
 }
/*===========================================================================
 *		End of Class Event CMWEditDoc::OnPostSaveRecord()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CMWEditDoc Event - int OnPreSaveRecord (pRecEditInfo);
 *
 * Called before the given record is saved.  It is copied into the 
 * active plugin if required.
 *
 *=========================================================================*/
int CMWEditDoc::OnPreSaveRecord (esmreceditinfo_t* pRecEditInfo) {
  CEsmRecord* pRecord;
  int	      Result;

	/* Check if the record's ID has been changed */
  if (pRecEditInfo->HasNewID || pRecEditInfo->IsNew) {

		/* Special case for exterior cells which can have any ID */
    if (pRecEditInfo->pRecInfo->pRecord->IsType(MWESM_REC_CELL)) {
      CEsmCell* pCell = (CEsmCell *) pRecEditInfo->pRecInfo->pRecord;

      if (pCell->IsInterior()) {
        Result = OnCheckNewID(pRecEditInfo);
        if (Result != MWESM_ONSAVE_OK) return (Result);
       }
     }
    else {
      Result = OnCheckNewID(pRecEditInfo);
      if (Result != MWESM_ONSAVE_OK) return (Result);
     }

		/* Add the record to the active plugin and recinfo array */
    if (!pRecEditInfo->HasAdded) {
      pRecEditInfo->pRecInfo->pRecord->SetID(pRecEditInfo->NewID);
      m_RecInfo.Add(pRecEditInfo->pRecInfo);
      m_RecInfoSort.SetAt(pRecEditInfo->pRecInfo);
      if (!pRecEditInfo->IsCopied) m_ActiveFile.AddRecord(pRecEditInfo->pRecInfo->pRecord);
      pRecEditInfo->HasAdded = true;
     }
		/* Update the recinfo sorted array */
    else if (pRecEditInfo->HasNewID && pRecEditInfo->pRecInfo->pFile->IsActive()) {
      m_RecInfo.DeleteElement(pRecEditInfo->pRecInfo);
      m_RecInfoSort.Delete(pRecEditInfo->pRecInfo, false);

      pRecEditInfo->pRecInfo->pRecord->SetID(pRecEditInfo->NewID);

      m_RecInfo.Add(pRecEditInfo->pRecInfo);
      m_RecInfoSort.SetAt(pRecEditInfo->pRecInfo);
     }
    
   }

	/* Ignore if the current file is already active */
  if (pRecEditInfo->pRecInfo->pFile->IsActive()) return (0);

	/* Attempt to copy the record into the active file */
  pRecord = m_ActiveFile.CopyRecord(pRecEditInfo->pRecInfo->pRecord);
  if (pRecord == NULL) return (-1);

	/* Update the recinfo structure */
  pRecord->SetPrevRecord(pRecEditInfo->pRecInfo->pRecord);
  
  if (pRecEditInfo->HasNewID) {
    m_RecInfo.DeleteElement(pRecEditInfo->pRecInfo);
    m_RecInfoSort.Delete(pRecEditInfo->pRecInfo, false);

    pRecEditInfo->pRecInfo->pRecord = pRecord;
    pRecEditInfo->pRecInfo->pFile   = &m_ActiveFile;
    pRecord->SetID(pRecEditInfo->NewID);

    m_RecInfo.Add(pRecEditInfo->pRecInfo);
    m_RecInfoSort.SetAt(pRecEditInfo->pRecInfo);
  }
  else {
    pRecEditInfo->pRecInfo->pRecord = pRecord;
    pRecEditInfo->pRecInfo->pFile   = &m_ActiveFile;
  }

  SetModifiedFlag(TRUE);
  return (0);
 }
/*===========================================================================
 *		End of Class Event CMWEditDoc::OnPreSaveRecord()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CMWEditDoc Event - BOOL OnSaveDocument (lpszPathName);
 *
 *=========================================================================*/
BOOL CMWEditDoc::OnSaveDocument(LPCTSTR lpszPathName) {
  bool Result;

	/* Update the active file masters */
  UpdateMasters();

	/* Backup the previous plugin file */
  Result = BackupPlugin(m_ActiveFile.GetFilename());

  if (!Result) {
    ErrorHandler.Notify("File Copy Error");
    return (FALSE);
   }

	/* Attempt to save the active file */
  m_ActiveFile.SetCallback(NULL, NULL);
  Result = m_ActiveFile.Write(lpszPathName);
  //Result = m_ActiveFile.Write("mwedit.esp");

  if (!Result) {
    ErrorHandler.Notify("File Write Error");
    return (FALSE);
   }

  SetModifiedFlag(FALSE);
  return (TRUE);
 }
/*===========================================================================
 *		End of Class Event CMWEditDoc::OnSaveDocument()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CMWEditDoc Event - void OnFileSave (void);
 *
 *=========================================================================*/
void CMWEditDoc::OnFileSave (void) {
  BOOL Result = SetCurrentDirectory(GetMWDataPath());
  CDocument::OnFileSave();
 }

void CMWEditDoc::OnFileSaveAs (void) {
  BOOL Result = SetCurrentDirectory(GetMWDataPath());
  CDocument::OnFileSaveAs();
 }
/*===========================================================================
 *		End of Class Event CMWEditDoc::OnFileSave()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CMWEditDoc Method - bool RenameRecord (pRecInfo, pNewID);
 *
 * Attempts to rename the given record with the given ID. Returns false
 * on any error.
 *
 *=========================================================================*/
bool CMWEditDoc::RenameRecord (esmrecinfo_t* pRecInfo, const TCHAR* pNewID) {
  DEFINE_FUNCTION("CMWEditDoc::RenameRecord()");
  CEsmRecord*	pNewRecord;
  bool		Result;
  
	/* Can we create new copies of the record? */
  if (!CanCreateNew(pRecInfo->pRecord->GetType())) {
    ErrorHandler.AddError(ERR_CUSTOM, _T("Cannot rename %s records!"), pRecInfo->pRecord->GetItemType());
    return (NULL);
   }

	/* Check the new ID to ensure it is valid */
  Result = IsValidESMID(pNewID);

  if (!Result) {
    ErrorHandler.AddError(ERR_CUSTOM, _T("The new ID '%s' is not valid!"), pNewID);
    return (NULL);
   }

	/* Is the new ID unique? */
  Result = IsExistingIDDup(pNewID);

  if (Result) {
    ErrorHandler.AddError(ERR_CUSTOM, _T("The new ID '%s' already exists!"), pNewID);
    return (NULL);
   }

	/* Copy the record to the active file if required */
  if (!pRecInfo->pFile->IsActive()) {
    pNewRecord = m_ActiveFile.CreateCopy(pRecInfo->pRecord);
    pRecInfo->pFile = &m_ActiveFile;
    pNewRecord->SetPrevRecord(pRecInfo->pRecord);
   }
  else {
    pNewRecord = pRecInfo->pRecord;
   }

  m_RecInfo.DeleteElement(pRecInfo);
  m_RecInfoSort.Delete(pRecInfo, false);

	/* Change the record ID */
  pNewRecord->SetID(pNewID);

	/* Update the record position */
  m_RecInfo.Add(pRecInfo);
  m_RecInfoSort.SetAt(pRecInfo);

  return (true);
 }
/*===========================================================================
 *		End of Class Method CMWEditDoc::RenameRecord()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CMWEditDoc Method - void UpdateMasters (void);
 *
 * Adds all currently loaded masters to the active plugin.
 *
 *=========================================================================*/
void CMWEditDoc::UpdateMasters (void) {
  CEsmTES3*	 pHeader;
  int		 Index;
  int		 ArrayIndex;
  CEsmFileArray* pMasters = GetApp()->GetMasters();
  CEsmFile*      pFile;

	/* Get the active file header record */
  pHeader = (CEsmTES3 *) m_ActiveFile.FindFirst(MWESM_REC_TES3, ArrayIndex);
  if (pHeader == NULL) return;

	/* Clear the current master data */
  pHeader->DeleteSubRecords(MWESM_SUBREC_MAST);
  pHeader->DeleteSubRecords(MWESM_SUBREC_DATA);

	/* Add all masters files */
  for (Index = 0; Index < pMasters->GetSize(); Index++) {
    pFile = pMasters->GetAt(Index);
    pHeader->AddMaster(FindFilename(pFile->GetFilename()), pFile->GetFileSize());
   }

 }
/*===========================================================================
 *		End of Class Method CMWEditDoc::UpdateMasters()
 *=========================================================================*/

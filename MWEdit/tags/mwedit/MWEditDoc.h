/*===========================================================================
 *
 * File:	MWEditDoc.H
 * Author:	Dave Humphrey (uesp@m0use.net)
 * Created On:	Monday, 03 February, 2003
 *
 * Definition of the CMWEditDoc document class.
 *
 *=========================================================================*/
#ifndef __MWEditDoc_H
#define __MWEditDoc_H


/*===========================================================================
 *
 * Begin Required Includes
 *
 *=========================================================================*/
  #include "esmfile.h"
  #include "EsmLoadDlg.h"
  #include "mwrecordmap.h"
/*===========================================================================
 *		End of Required Includes
 *=========================================================================*/


/*===========================================================================
 *
 * Begin Definitions
 *
 *=========================================================================*/

	/* View update definitions */
  #define MWEDITDOC_HINT_UPDATE		1
  #define MWEDITDOC_HINT_UPDATEITEM	101
  #define MWEDITDOC_HINT_NEWITEM	102
  #define MWEDITDOC_HINT_SELECTITEM	103

	/* Return codes for the OnPreSaveRecord() and OnPostSaveRecord() events */
  #define MWESM_ONSAVE_OK		0
  #define MWESM_ONSAVE_ERROR		-1
  #define MWESM_ONSAVE_KEEPEDITTING	-2
  #define MWESM_ONSAVE_ABORTEDIT	-3

	/* Clean record returns */
  #define MWEDIT_CLEAN_OK		0
  #define MWEDIT_CLEAN_ERROR		-1
  #define MWEDIT_CLEAN_DELETE		1

  #define ESM_IMPORTSCPT_FILTER _T("Text Files (*.txt)|*.txt|All Files (*.*)|*.*||")

	/* Custom error message for compiling all scripts */
  #define MWEDIT_ERR_COMPILEALL		10931

/*===========================================================================
 *		End of Definitions
 *=========================================================================*/


/*===========================================================================
 *
 * Begin Type Definitions
 *
 *=========================================================================*/

	/* Holds information on a record being editted */
  typedef struct {
	esmrecinfo_t*	pRecInfo;	/* The record being editted */
	CString		OldID;		/* The ID of the object before being editted */
	CString		NewID;		/* The modified ID, if any */
	bool		HasNewID;
	bool		IsNew;		/* Is the record newly created? */
	bool		IsRenamed;	/* Do we need to rename the object? */
	bool		HasAdded;	/* Has a new item been added to the file yet? */
	bool		IsCopied;	
   } esmreceditinfo_t;

	/* Used to find a record of a specific type */
  typedef struct {
	const TCHAR* pID;
	const TCHAR* pType;
   } esmrecsortfind_t;


  class CMWEditApp;
/*===========================================================================
 *		End of Type Definitions
 *=========================================================================*/


/*===========================================================================
 *
 * Class CMWEditDoc Definition
 * 
 *=========================================================================*/
class CMWEditDoc : public CDocument {

  /*---------- Begin Protected Class Members --------------------------*/
protected:
  CEsmFileArray		m_EsmFiles;	/* Plugin files */
  CEsmFile		m_ActiveFile;	/* The currently active file */
  CEsmLoadDlg		m_LoadDlg;

  CEsmFile		m_ScriptFile;	/* Used for comparing scripts */
  CString		m_ScriptFilename;

  CEsmRecInfoArray	m_RecInfo;	/* Used to access the records */
  CMwIdRecordMap	m_RecInfoSort;
  int			m_NumFiles;

  CMwIdRecordMap	m_RecIdMap;
  CMwTypeRecordMap	m_RecTypeMap;

  bool			m_ViewChanged;

				/* Used when exporting spell merchants */
  int		        m_OutputEffects[MWESM_MAX_EFFECTS];
  int			m_NumEffectsOutput;


  /*---------- Begin Protected Class Methods --------------------------*/
protected:
	
	/* Create from serialization only */
  CMWEditDoc();
  DECLARE_DYNCREATE(CMWEditDoc);

	/* Adds the given file records to the record array */
  void AddRecInfo (CEsmFile* pFile);

	/* Delete all record infos in the array */
  void ClearRecInfoArray (void);
  void ClearFileArray    (void);

	/* Script compare helper */
  void CompareScriptData (const byte* pData1, const long Size1, const byte* pData2, const long Size2);

	/* Script compile helpers */
  bool CompileActiveScript (CEsmScript* pScript);

	/* Called when a plugin is loaded */ 
  bool LoadAppMasters (void);
  bool LoadAppPlugins (void);
  bool LoadAppActive  (void);

	/* Called when an object's ID has been changed */
  int OnCheckNewID (esmreceditinfo_t* pRecEditInfo);


  /*---------- Begin Public Class Methods -----------------------------*/
public:

	/* Destructor */
  virtual ~CMWEditDoc();

  	/* Add a recinfo structure to the array */
  void AddRecInfo (esmrecinfo_t* pRecInfo) { m_RecInfoSort.SetAt(pRecInfo); m_RecInfo.Add(pRecInfo); }

	/* Creates a backup of the given file */
  bool BackupPlugin (const TCHAR* pFilename);

	/* Check if the user can make new records of the given type */
  bool CanCreateNew (const TCHAR* pType);

	/* Compiles all scripts in the active plugin */
  bool CompileAllActiveScripts (void);

	/* Attempts to copy the given record into the active file */
  bool CopyRecord (CMWEditDoc* pSourceDoc, esmrecinfo_t* pRecInfo);

	/* Create a new record of the given type */
  CEsmRecord*   CreateNewRecord (const TCHAR* pType);
  esmrecinfo_t* CreateNewRecord (const TCHAR* pType, const TCHAR* pID);
  CEsmRecord*   CreateCopy      (CEsmRecord* pRecord);
  CEsmRecord*   CreateEditCopy  (CEsmRecord* pRecord);
  CEsmRecord*   CreateCopyDIAL  (CMWEditDoc* pDocument, CEsmDialogue* pDialRecord);
  CEsmRecord*   CreateCopyDIAL  (CEsmDialogue* pDialRecord);
  CEsmRecord*   CreateCopyINFO  (CMWEditDoc* pDocument, CEsmDialogue* pDialRecord, CEsmDialogue* pNewDialRecord);
  esmrecinfo_t* CreateCopy      (esmrecinfo_t* pRecInfo, const TCHAR* pNewID);
  esmrecinfo_t* CopyToActive    (esmrecinfo_t* pRecInfo);
  esmrecinfo_t* CopyNewRecord   (esmrecinfo_t* pOrigRecInfo);
  CEsmRecord*   CopyCELLRefs    (CMWEditDoc* pDocument, CEsmCell* pSourceCell, CEsmCell* pDestCell);

	/* Compare script data in the active file and the current script file */
  void CompareScripts (void);
  void CompareScripts (CEsmScript* pScript1, CEsmScript* pScript2);

	/* Attempt to toggle delete a record (the usual way) */
  int  CleanRecord  (esmrecinfo_t* pRecInfo);
  bool DeleteRecord (esmrecinfo_t* pRecInfo);
  bool MakeActive   (esmrecinfo_t* pRecInfo);

	/* Export records */
  bool ExportSpellMerchants (const TCHAR* pFilename);
  bool ExportSpellMerchant  (CEsmNpc* pNpc, CGenFile& File);
  bool ExportSpellMerchant  (CEsmNpc* pNpc, CEsmSpell* pSpell, CEsmSubCellRef* pCellRef, CGenFile& File);
  bool ExportSpellMerchant  (CEsmNpc* pNpc, CEsmSpell* pSpell, CEsmSubCellRef* pCellRef, const int EffectID, CGenFile& File);

  	/* Access particular records */
  esmrecinfo_t* FindInfoRecord   (const TCHAR* pID, const TCHAR* pDialID);
  esmrecinfo_t* FindRecInfoByPtr (CEsmRecord* pRecord);
  esmrecinfo_t* FindRecInfo      (CEsmRecord* pRecord);
  esmrecinfo_t* FindRecord       (const TCHAR* pID);
  esmrecinfo_t* FindRecordCarryable (const TCHAR* pID);
  esmrecinfo_t* FindRecord       (const TCHAR* pID, const TCHAR* pType);
  esmrecinfo_t* FindRecordSort   (CEsmRecord* pRecord);
  esmrecinfo_t* FindFirstRecord  (const TCHAR* pType, int& ArrayIndex) { ArrayIndex = -1; return (FindNextRecord(pType, ArrayIndex)); }
  esmrecinfo_t* FindNextRecord   (const TCHAR* pType, int& ArrayIndex);
  esmrecinfo_t* GetInfoStart     (esmrecinfo_t* pDialog);
  esmrecinfo_t* GetInfoStart     (CEsmDialogue* pDialog);
  esmrecinfo_t* FindFirstItem    (int& ArrayIndex) { ArrayIndex = -1; return FindNextItem(ArrayIndex); }
  esmrecinfo_t* FindNextItem     (int& ArrayIndex);
  esmrecinfo_t* FindExistingRecord (const TCHAR* pID, const TCHAR* pType);
  CEsmGlobal*   GetGlobal        (const TCHAR* pName);

	/* Find a script in the script file */
  CEsmScript* FindScriptRecord (const TCHAR* pID);

	/* Find record references in a cell */
  CEsmSubCellRef* FindFirstCellRef (CEsmRecord* pRecord);

	/* Get the main application object */
  CMWEditApp* GetApp (void) { return (CMWEditApp *) AfxGetApp(); }
  
	/* Access the document members */
  bool		    GetViewChanged	(void) { return (m_ViewChanged); }
  CEsmFile*	    GetActivePlugin	(void) { return (&m_ActiveFile); }
  CEsmFile&	    GetScriptPlugin	(void) { return (m_ScriptFile); }
  const TCHAR*      GetScriptFilename   (void) { return (m_ScriptFilename); }
  CEsmRecInfoArray* GetRecInfoArray	(void) { return (&m_RecInfo); }
  int		    GetNumEffectsOutput (void) { return (m_NumEffectsOutput); }
  int		    GetNumRecords       (void) { return (m_RecInfo.GetSize()); }

	/* Get a magic effect record */
  esmrecinfo_t* GetEffectRecord (const int EffectID);

	/* Get AI flags for the given NPC */
  long GetNPCAiFlags (CEsmNpc* pNpc);

  	/* Attempt to import a script from the filename */
  esmrecinfo_t* ImportScript (const TCHAR* pFilename);

	/* Checks for an existing object ID */
  bool IsExistingID    (const TCHAR* pID) { return (FindRecord(pID) != NULL); }
  bool IsExistingIDDup (const TCHAR* pID);

	/* Load a plugin file for script comparison */
  bool LoadScriptFile (const TCHAR* pFilename);

	/* Creates and returns a new info id */
  const TCHAR* MakeNewINFOId (void);

	/* Called before/after a record is changed */
  int OnPostSaveRecord (esmreceditinfo_t* pRecEditInfo);
  int OnPreSaveRecord  (esmreceditinfo_t* pRecEditInfo);

	/* Attempt to rename a record */
  bool RenameRecord (esmrecinfo_t* pRecInfo, const TCHAR* pNewID);

	/* Set class members */
  void SetViewChanged (const bool Flag) { m_ViewChanged = Flag; UpdateAllViews(NULL, MWEDITDOC_HINT_UPDATE, NULL); }

	/* Updates the MAST records in the current active file */
  void UpdateMasters (void);

	/* Diagnostics */
#ifdef _DEBUG
  virtual void AssertValid() const;
  virtual void Dump(CDumpContext& dc) const;
#endif

	/* ClassWizard generated virtual function overrides */
  //{{AFX_VIRTUAL(CMWEditDoc)
public:
  virtual BOOL OnNewDocument();
  virtual void Serialize(CArchive& ar);
  virtual BOOL OnOpenDocument(LPCTSTR lpszPathName);
  virtual BOOL OnSaveDocument(LPCTSTR lpszPathName);
  virtual void DeleteContents();
  //}}AFX_VIRTUAL

	/* Generated message map functions */
protected:
  //{{AFX_MSG(CMWEditDoc)
  afx_msg void OnFileSave   (void);
  afx_msg void OnFileSaveAs (void);
  //}}AFX_MSG

  DECLARE_MESSAGE_MAP()

 };
/*===========================================================================
 *		End of Class CMWEditDoc Definition
 *=========================================================================*/


//{{AFX_INSERT_LOCATION}}
//}}AFX_INSERT_LOCATION Microsoft Visual C++ will insert additional declarations immediately before the previous line.


#endif
/*===========================================================================
 *		End of File MWEditDoc.H
 *=========================================================================*/

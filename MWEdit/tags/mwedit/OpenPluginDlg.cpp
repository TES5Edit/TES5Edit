/*===========================================================================
 *
 * File:	Openplugindlg.CPP
 * Author:	Dave Humphrey (uesp@m0use.net)
 * Created On:	February 4, 2003
 *
 * Description
 *
 * 13 October 2003
 *	- Fixed bug when changing an item's active status.
 *
 *=========================================================================*/

	/* Include Files */
#include "stdafx.h"
#include "MWEdit.h"
#include "OpenPluginDlg.h"
#include "file/GenFind.h"
#include "esmutils.h"


/*===========================================================================
 *
 * Begin Local Definitions
 *
 *=========================================================================*/
#ifdef _DEBUG
  #define new DEBUG_NEW
  #undef THIS_FILE
  static char THIS_FILE[] = __FILE__;
#endif

  DEFINE_FILE("OpenPluginDlg.cpp");
/*===========================================================================
 *		End of Local Definitions
 *=========================================================================*/


/*===========================================================================
 *
 * Begin COpenPluginDlg Message Map
 *
 *=========================================================================*/
BEGIN_MESSAGE_MAP(COpenPluginDlg, CDialog)
  //{{AFX_MSG_MAP(COpenPluginDlg)
  ON_BN_CLICKED(ID_SETACTIVE, OnSetactive)
  ON_NOTIFY(NM_DBLCLK, IDC_FILE_LIST, OnDblclkFileList)
  ON_NOTIFY(LVN_COLUMNCLICK, IDC_FILE_LIST, OnColumnclickFileList)
  //}}AFX_MSG_MAP
END_MESSAGE_MAP()
/*===========================================================================
 *		End of COpenPluginDlg Message Map
 *=========================================================================*/


/*===========================================================================
 *
 * Begin Default List Sort Functions
 *
 *=========================================================================*/
int CALLBACK l_SortFiles (LPARAM lParam1, LPARAM lParam2, LPARAM lParamSort) {
  esmfileinfo_t* pFileInfo1 = (esmfileinfo_t*) lParam1;
  esmfileinfo_t* pFileInfo2 = (esmfileinfo_t*) lParam2;
  int	         SortType = lParamSort & 0xFFFF;
  int	         Flags    = lParamSort >> 16;
  int	         Result;
    
  if (SortType == OPENPLUG_SUBITEM_FILENAME) {
    Result = StringCompare(pFileInfo1->Filename, pFileInfo2->Filename, false);
   }
  else if (SortType == OPENPLUG_SUBITEM_TYPE) {
    Result = pFileInfo2->Flags - pFileInfo1->Flags;	/* Backwards on purpose */
   }
  else if (SortType == OPENPLUG_SUBITEM_DATE) {
    Result = pFileInfo1->FileDate - pFileInfo2->FileDate;
   }
 
  if (Flags) return (-Result);
  return (Result);  
 }
/*===========================================================================
 *		End of Default List Sort Functions
 *=========================================================================*/


/*===========================================================================
 *
 * Class COpenPluginDlg Constructor
 *
 *=========================================================================*/
COpenPluginDlg::COpenPluginDlg(CWnd* pParent) : CDialog(COpenPluginDlg::IDD, pParent), m_FileArray(0) {
  //{{AFX_DATA_INIT(COpenPluginDlg)
  //}}AFX_DATA_INIT
  m_LastActive      = -1;
  m_SortReverse     = false;
  m_LastSortSubItem = -1;
  m_pLastFile       = NULL;
 }
/*===========================================================================
 *		End of Class COpenPluginDlg Constructor
 *=========================================================================*/


/*===========================================================================
 *
 * Class COpenPluginDlg Destructor
 *
 *=========================================================================*/
COpenPluginDlg::~COpenPluginDlg () {
  ClearFileArray();
 }
/*===========================================================================
 *		End of Class COpenPluginDlg Destructor
 *=========================================================================*/


/*===========================================================================
 *
 * Class COpenPluginDlg Method - void ClearFileArray (void);
 *
 *=========================================================================*/
void COpenPluginDlg::ClearFileArray (void) {
  DEFINE_FUNCTION("COpenPluginDlg::ClearFileArray()");
  esmfileinfo_t* pFile;
  int		 Index;

	/* Unallocate allocated files */
  for (Index = 0; Index < m_FileArray.GetSize(); Index++) {
    pFile = m_FileArray.GetAt(Index);
    DestroyPointer(pFile); 
   }

  m_FileArray.RemoveAll();
 }
/*===========================================================================
 *		End of Class Method COpenPluginDlg::ClearFileArray()
 *=========================================================================*/


/*===========================================================================
 *
 * Class COpenPluginDlg Method - void CreateFileList (void);
 *
 *=========================================================================*/
void COpenPluginDlg::CreateFileList (void) { 
  DEFINE_FUNCTION("COpenPluginDlg::CreateFileList()");
  esmfileinfo_t* pFile;
  CFindFile	 FindFile;
  const TCHAR*	 pExtension;
  int		 Index;
  int		 ListIndex;
  bool		 FindResult;
  long		 Flags;
  CString	 FileType;
  TCHAR		 TempDate[64];
  bool		 AddFile;
  struct tm*	 pFileTime;
  
	/* Create the two columns */
  m_FileList.InsertColumn(0, _T("Filename"), LVCFMT_LEFT,   180, OPENPLUG_SUBITEM_FILENAME); 
  m_FileList.InsertColumn(1, _T("Type"),     LVCFMT_CENTER, 100, OPENPLUG_SUBITEM_TYPE);
  m_FileList.InsertColumn(2, _T("Date"),     LVCFMT_CENTER, 120, OPENPLUG_SUBITEM_DATE);

	/* Find and insert the files */
  FindResult = FindFile.FindFirst("*.es?", FA_NORMAL);
  Index = 0;

  while (FindResult) {
    pExtension = FindExtension(FindFile.GetName());
    AddFile = false;

		/* Determine the type of file found */
    if (pExtension == NULL) {
     }
    else if (TSTRICMP(pExtension, "esm") == 0) {
      AddFile  = true;
      Flags    = OPENPLUG_FLAG_MASTER;
      FileType = _T("Master");
     }
    else if (TSTRICMP(pExtension, "esp") == 0) {
      AddFile  = true;
      Flags    = 0;
      FileType = _T("Plugin");
     }
    else if (TSTRICMP(pExtension, "ess") == 0) {
      AddFile  = true;
      Flags    = OPENPLUG_FLAG_SAVEGAME;
      FileType = _T("Save Game");
     }
	
		/* Add the file to the open dialog list if required */
    if (AddFile) {
      CreatePointer(pFile, esmfileinfo_t);
      m_FileArray.Add(pFile);
      strnncpy(pFile->Filename, FindFile.GetName(), _MAX_PATH);
      pFile->Flags = Flags;
      pFile->FileDate = FindFile.GetWriteTime();
      pFileTime = localtime(&pFile->FileDate);
      
		/* Fix crash bug with file dates in the far future */
      if (pFileTime != NULL) {
	strftime(TempDate, 63, "%c", pFileTime);
      }
      else {
      	strnncpy(TempDate, "?", 32);
      }

      ListIndex = m_FileList.InsertItem(Index, FindFile.GetName());
      m_FileList.SetItemText(ListIndex, OPENPLUG_SUBITEM_TYPE, FileType);
      m_FileList.SetItemText(ListIndex, OPENPLUG_SUBITEM_DATE, TempDate);
      m_FileList.SetItemData(ListIndex, (DWORD) pFile);
     }

		/* Find the next file, if any */
    FindResult = FindFile.FindNext();
    Index++;
   }

 }
/*===========================================================================
 *		End of Class Method COpenPluginDlg::CreateFileList()
 *=========================================================================*/


/*===========================================================================
 *
 * Class COpenPluginDlg Method - void DoDataExchange (pDX);
 *
 *=========================================================================*/
void COpenPluginDlg::DoDataExchange(CDataExchange* pDX) {
  CDialog::DoDataExchange(pDX);

  //{{AFX_DATA_MAP(COpenPluginDlg)
  DDX_Control(pDX, IDC_FILE_LIST, m_FileList);
  //}}AFX_DATA_MAP
 }
/*===========================================================================
 *		End of Class Method COpenPluginDlg::DoDataExchange()
 *=========================================================================*/


/*===========================================================================
 *
 * Class COpenPluginDlg Event - void OnColumnclickFileList (pNMHDR, pResult);
 *
 *=========================================================================*/
void COpenPluginDlg::OnColumnclickFileList (NMHDR* pNMHDR, LRESULT* pResult) {
  NM_LISTVIEW*  pNMListView = (NM_LISTVIEW *) pNMHDR;
  long		Flags = 0;
  *pResult = 0;

  Flags = pNMListView->iSubItem;

  if (pNMListView->iSubItem == m_LastSortSubItem)
    m_SortReverse = !m_SortReverse;
  else {
    m_LastSortSubItem = pNMListView->iSubItem ;
    m_SortReverse = false;
   }

  Flags |= m_SortReverse ? 0x10000 : 0x00000;

  m_FileList.SortItems(l_SortFiles, Flags);
 }
/*===========================================================================
 *		End of Class Event COpenPluginDlg::OnColumnclickFileList()
 *=========================================================================*/


/*===========================================================================
 *
 * Class COpenPluginDlg Event - void OnDblclkFileList (pNMHDR, pResult);
 *
 *=========================================================================*/
void COpenPluginDlg::OnDblclkFileList(NMHDR* pNMHDR, LRESULT* pResult) {
  bool     Checked;
  int      ListIndex;
  POSITION FilePos;

	/* Try and toggle the current item state */
  FilePos = m_FileList.GetFirstSelectedItemPosition();

  if (FilePos != NULL) {
    ListIndex = m_FileList.GetNextSelectedItem(FilePos);
    Checked = (ListView_GetCheckState(m_FileList.m_hWnd, ListIndex) != 0);
    Checked = !Checked;
    ListView_SetCheckState(m_FileList.m_hWnd, ListIndex, Checked);
   }

	/* Toggle the use of the active file */
  OnSetactive();
  *pResult = 0;
 }
/*===========================================================================
 *		End of Class Event COpenPluginDlg::OnDblclkFileList()
 *=========================================================================*/


/*===========================================================================
 *
 * Class COpenPluginDlg Event - BOOL OnInitDialog ();
 *
 *=========================================================================*/
BOOL COpenPluginDlg::OnInitDialog() {
  CString Buffer;

  CDialog::OnInitDialog();

	/* Set the list extended styles */
  ListView_SetExtendedListViewStyle(m_FileList.m_hWnd,  LVS_EX_FULLROWSELECT | LVS_EX_GRIDLINES | LVS_EX_CHECKBOXES);

	/* Set title */
  Buffer.Format(_T("Open Morrowind Plugin -- %s"), GetMWDataPath());
  SetWindowText(Buffer);

	/* Fill the file list */
  CreateFileList();
	
  m_FileList.SortItems(l_SortFiles, OPENPLUG_SUBITEM_FILENAME);
  m_FileList.SortItems(l_SortFiles, OPENPLUG_SUBITEM_DATE);
  m_FileList.SortItems(l_SortFiles, OPENPLUG_SUBITEM_TYPE);
  return (TRUE);
 }
/*===========================================================================
 *		End of Class Event COpenPluginDlg::OnInitDialog()
 *=========================================================================*/


/*===========================================================================
 *
 * Class COpenPluginDlg Event - void OnOK ();
 *
 *=========================================================================*/
void COpenPluginDlg::OnOK() {
  esmfileinfo_t* pFile;
  int		 Index;
  bool		 Checked;

  m_ActivePlugin.Empty();
  m_Plugins.RemoveAll();
  m_HasActive = false;

	/* Save the currently checked files */
  for (Index = 0; Index < m_FileList.GetItemCount(); Index++) {
    pFile   = (esmfileinfo_t *) m_FileList.GetItemData(Index);
    Checked = (ListView_GetCheckState(m_FileList.m_hWnd, Index) != 0);
    //SystemLog.Printf("File %s: %ld", pFile->Filename, pFile->Flags);

    if (Checked && (pFile->Flags & OPENPLUG_FLAG_ACTIVE) != 0) {
      m_ActivePlugin = m_FileList.GetItemText(Index, OPENPLUG_SUBITEM_FILENAME);
      //SystemLog.Printf("\tActive = %s", m_ActivePlugin);
      m_HasActive = true;
     }
    else if (Checked && (pFile->Flags & OPENPLUG_FLAG_MASTER) != 0) {
      m_Masters.AddTail(m_FileList.GetItemText(Index, OPENPLUG_SUBITEM_FILENAME));
      //SystemLog.Printf("\tMaster = %s", m_FileList.GetItemText(Index, OPENPLUG_SUBITEM_FILENAME));
     }
    else if (Checked) {
      m_Plugins.AddTail(m_FileList.GetItemText(Index, OPENPLUG_SUBITEM_FILENAME));
      //SystemLog.Printf("\tPlugin = %s", m_FileList.GetItemText(Index, OPENPLUG_SUBITEM_FILENAME));
     }
   }
  
  CDialog::OnOK();
 }
/*===========================================================================
 *		End of Class Event COpenPluginDlg::OnOK()
 *=========================================================================*/


/*===========================================================================
 *
 * Class COpenPluginDlg Event - void OnSetactive ();
 *
 *=========================================================================*/
void COpenPluginDlg::OnSetactive() {
  esmfileinfo_t* pFile;
  POSITION	 FilePos;
  CString	 Buffer;
  int		 ListIndex;

  FilePos = m_FileList.GetFirstSelectedItemPosition();
  if (FilePos == NULL) return;
  ListIndex = m_FileList.GetNextSelectedItem(FilePos);

  pFile = (esmfileinfo_t *) m_FileList.GetItemData(ListIndex);
  if ((pFile->Flags & OPENPLUG_FLAG_MASTER) != 0) return;

  if ((pFile->Flags & OPENPLUG_FLAG_ACTIVE) != 0) {
    pFile->Flags &= ~OPENPLUG_FLAG_ACTIVE;
    m_FileList.SetItemText(ListIndex, OPENPLUG_SUBITEM_TYPE, _T("Plugin"));
    m_LastActive = -1;
    m_pLastFile  = NULL;
   }
  else {
    pFile->Flags |= OPENPLUG_FLAG_ACTIVE;
    m_FileList.SetItemText(ListIndex, OPENPLUG_SUBITEM_TYPE, _T("Active"));

		/* Clear the last active plugin, if any */
    if (m_pLastFile != NULL) {
      m_pLastFile->Flags &= ~OPENPLUG_FLAG_ACTIVE;
      m_FileList.SetItemText(m_LastActive, OPENPLUG_SUBITEM_TYPE, _T("Plugin"));
     }

    m_LastActive = ListIndex;
    m_pLastFile  = pFile;
   }
  
 }
/*===========================================================================
 *		End of Class Event COpenPluginDlg::OnSetactive()
 *=========================================================================*/



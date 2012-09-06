/*===========================================================================
 *
 * File:	Openplugindlg.H
 * Author:	Dave Humphrey (uesp@m0use.net)
 * Created On:	February 4, 2003
 *
 * Description
 *
 *=========================================================================*/
#ifndef __OPENPLUGINDLG_H
#define __OPENPLUGINDLG_H


/*===========================================================================
 *
 * Begin Required Includes
 *
 *=========================================================================*/
 
/*===========================================================================
 *		End of Required Includes
 *=========================================================================*/


/*===========================================================================
 *
 * Begin Definitions
 *
 *=========================================================================*/

	/* Subitem/column indices */
  #define OPENPLUG_SUBITEM_FILENAME 0
  #define OPENPLUG_SUBITEM_TYPE	    1
  #define OPENPLUG_SUBITEM_DATE	    2

	/* Item data values */
  #define OPENPLUG_FLAG_SAVEGAME 1
  #define OPENPLUG_FLAG_MASTER   2
  #define OPENPLUG_FLAG_ACTIVE   4

#ifndef ListView_SetCheckState
   #define ListView_SetCheckState(hwndLV, i, fCheck) \
      ListView_SetItemState(hwndLV, i, \
      INDEXTOSTATEIMAGEMASK((fCheck)+1), LVIS_STATEIMAGEMASK)
#endif

	/* Holds information on the files to be loaded */
  struct esmfileinfo_t {
	TCHAR  Filename[_MAX_PATH+4];
	long   Flags;
	time_t FileDate;
   };


  typedef TPtrArray<esmfileinfo_t> CEsmFileInfoArray;

/*===========================================================================
 *		End of Definitions
 *=========================================================================*/


/*===========================================================================
 *
 * Begin Class COpenPluginDlg
 *
 *=========================================================================*/
class COpenPluginDlg : public CDialog {

  /*---------- Begin Public Class Members -------------------------*/
protected:
  CStringList	 m_Plugins;
  CStringList	 m_Masters;
  CString	 m_ActivePlugin;
  int		 m_LastActive;
  bool		 m_HasActive;
  esmfileinfo_t* m_pLastFile;

  CEsmFileInfoArray m_FileArray;
  bool		    m_SortReverse;
  int		    m_LastSortSubItem;


  /*---------- Begin Protected Class Methods ----------------------*/
protected:

	/* Delete all files currently in the file array */
  void ClearFileArray (void);

	/* Fills the file list with plugins */
  void CreateFileList (void);


  /*---------- Begin Public Class Methods --------------------------*/
public:

	/* Construction */
  COpenPluginDlg(CWnd* pParent = NULL);
  ~COpenPluginDlg();

	/* Get class members */
  CString&     GetActivePlugin (void) { return (m_ActivePlugin); }
  CStringList& GetMasters      (void) { return (m_Masters); }
  CStringList& GetPlugins      (void) { return (m_Plugins); }
  bool	       HasActive       (void) { return (m_HasActive); }

	/* Dialog Data */
  //{{AFX_DATA(COpenPluginDlg)
  enum { IDD = IDD_OPENPLUGIN_DLG };
  CListCtrl	m_FileList;
  //}}AFX_DATA

	/* ClassWizard generated virtual function overrides */
  //{{AFX_VIRTUAL(COpenPluginDlg)
protected:
  virtual void DoDataExchange(CDataExchange* pDX);
  //}}AFX_VIRTUAL


protected:

	/* Generated message map functions */
  //{{AFX_MSG(COpenPluginDlg)
  virtual void OnOK();
  virtual BOOL OnInitDialog();
	afx_msg void OnSetactive();
	afx_msg void OnDblclkFileList(NMHDR* pNMHDR, LRESULT* pResult);
	afx_msg void OnColumnclickFileList(NMHDR* pNMHDR, LRESULT* pResult);
	//}}AFX_MSG

  DECLARE_MESSAGE_MAP();

 };
/*===========================================================================
 *		End of Class COpenPluginDlg
 *=========================================================================*/


//{{AFX_INSERT_LOCATION}}
//}}AFX_INSERT_LOCATION


#endif
/*===========================================================================
 *		End of File Openplugindlg.H
 *=========================================================================*/

/*===========================================================================
 *
 * File:		Srrecordlistctrl.H
 * Author:		Dave Humphrey (dave@uesp.net)
 * Created On:	26 November 2011
 *
 * Defines the CSrRecordListCtrl class used for displaying a list of 
 * record data in a CListCtrl format.
 *
 *=========================================================================*/
#ifndef __SRRECORDLISTCTRL_H
#define __SRRECORDLISTCTRL_H


/*===========================================================================
 *
 * Begin Required Includes
 *
 *=========================================================================*/
	#include "modfile/srespfile.h"
	#include "srrecordfilter.h"
/*===========================================================================
 *		End of Required Includes
 *=========================================================================*/


/*===========================================================================
 *
 * Begin Definitions
 *
 *=========================================================================*/

	/* Arbitrary number of columns allowed in a list */
  #define SR_RECLIST_MAXCOLS 100

	/* Custom messages */
  #define ID_SRRECORDLIST_ACTIVATE		(WM_APP + 101)
  #define ID_SRRECORDLIST_ALTACTIVATE	(WM_APP + 102)
  #define ID_SRRECORDLIST_DROP			(WM_APP + 103)
  #define ID_SRRECORDLIST_CHECKDROP		(WM_APP + 104)
  #define ID_SRRECORDLIST_CHAR			(WM_APP + 105)
  #define ID_SRRECORDLIST_KEYDOWN		(WM_APP + 106)
    
	/* List types */
  #define SR_RECORDLIST_RECORD	1
  #define SR_RECORDLIST_CUSTOM	2

  	/* Drag types */
  #define SR_RLDRAG_RECORD	0x0001
  #define SR_RLDRAG_CUSTOM	0x0002
  #define SR_RLDRAG_ALL		0xffff

	/* Types of list activation */
  #define SR_RLACTIVATE_NONE		0
  #define SR_RLACTIVATE_RECORD		1
  #define SR_RLACTIVATE_SUBRECORD	2
  #define SR_RLACTIVATE_DEFAULT		SR_RLACTIVATE_RECORD

	/* Number of subrecords in the custom data structure */
  //#define SR_RLMAX_SUBRECORDS 64

	/* Macro to get data from list compare function parameters */
  #define SRRL_SORTFUNC_GETPARAMS(Param1, Param2, Param3) srreclistsort_t* pSortData = (srreclistsort_t *) Param3; \
		srrlcustomdata_t* pCustomData1 = (pSortData->ListType == SR_RECORDLIST_CUSTOM) ? (srrlcustomdata_t *) Param1 : NULL; \
		srrlcustomdata_t* pCustomData2 = (pSortData->ListType == SR_RECORDLIST_CUSTOM) ? (srrlcustomdata_t *) Param2 : NULL; \
		CSrRecord* pRecord1  = (pSortData->ListType == SR_RECORDLIST_RECORD) ? (CSrRecord *) Param1 : pCustomData1->pRecord; \
		CSrRecord* pRecord2  = (pSortData->ListType == SR_RECORDLIST_RECORD) ? (CSrRecord *) Param2 : pCustomData2->pRecord; 

	/* Initialize columns flags */
  #define SRRL_INITCOL_NOEXTRAFIELDS	1
  #define SRRL_INITCOL_FORCENEW			2
  
	/* Types of color to apply to the list */
  #define SRRL_COLORMASK_ACTIVE		1
  #define SRRL_COLORMASK_IGNORE		2
  #define SRRL_COLORMASK_DELETE		4
  #define SRRL_COLORMASK_DANGEROUS	8
  #define SRRL_COLORMASK_QUEST		16

	/* Default list colors */
  #define SRRL_DEFAULT_COLOR_ACTIVE	RGB(172,255,172)
  #define SRRL_DEFAULT_COLOR_IGNORED	RGB(172,255,255)
  #define SRRL_DEFAULT_COLOR_DELETED	RGB(255,172,172)
  #define SRRL_DEFAULT_COLOR_DANGEROUS	RGB(255,255,172)
  #define SRRL_DEFAULT_COLOR_QUEST	RGB(172,172,255)

	/* Drop check results */
  #define SRRL_DROPCHECK_OK    1234
  #define SRRL_DROPCHECK_ERROR 4321
  
	/* Registry keys */
  #define SRRL_REGKEY_ROOT "Lists"
		
/*===========================================================================
 *		End of Definitions
 *=========================================================================*/


/*===========================================================================
 *
 * Begin Type Definitions
 *
 *=========================================================================*/

	/* Holds information on a single column in the displayed list */
  struct srreclistcolumn_t 
  {
	const srrecfield_t*	pField;		/* Which field this column represents */
	srrecfieldid_t		FieldID;
	TCHAR				Title[64];
	int					Width;		/* Output width */
	int					Format;		/* Output format flags */
	int					SubItem;	/* Subitem index */
	int					ColumnIndex;
	bool				Display;	/* Display the column or not */
	PFNLVCOMPARE		CompareFunc;

	srreclistcolumn_t() {
		Title[0]	= NULL_CHAR;
		pField		= NULL;
		FieldID		= 0;
		Width		= 10;
		Format		= 0;
		SubItem		= -1;
		ColumnIndex	= -1;
		Display		= false;
		CompareFunc	= NULL;
	}

	void SetTitle (const TCHAR* pString) { strnncpy(Title, pString, 62); }
  };

	/* Holds information on a single list configuration */
  struct srreclistinfo_t 
  {
	int					Type;
	const srrectype_t*	pRecordType;
	int					SortSubItem;
	srrecfieldid_t		SortField;
	bool				SortReverse;
	PFNLVCOMPARE		CompareFunc;

	srreclistcolumn_t	Columns[SR_RECLIST_MAXCOLS];
	dword				NumColumns;
  };

	/* Used to initialize column data for a list */
  struct srreclistcolinit_t
  { 
	srrecfieldid_t	FieldID;
	int				Width;
	int				Format;
	PFNLVCOMPARE	CompareFunc;
  };

	/* Used to initialize a list configuration */
  struct srreclistinfoinit_t 
  {
	const srrectype_t*		pRecordType;
	srreclistcolinit_t*		pInit;
	const srrecfieldmap_t*  pFieldMap;
	srrecfieldid_t			SortField;
  };

	/* Holds item information in a custom list */
  struct srrlcustomdata_t 
  {
	CSrRecord*				pRecord;
	CSrRefSubrecordArray	Subrecords;
	void*					pUserData;
	int						UserCount;
	int						UserData;

	srrlcustomdata_t()
	{
		pUserData = NULL;
		UserData = 0;
		UserCount = 0;
		pRecord = NULL;
	}

	void Add (CSrSubrecord* pSubrecord) { Subrecords.Add(pSubrecord); }
	dword GetSRCount (void) { return Subrecords.GetSize(); }
	CSrSubrecord* GetSR (const dword Index) { return Subrecords[Index]; }
	
	void Destroy (void)
	{
		Subrecords.Destroy();
		pRecord = NULL;
		pUserData = NULL;
		UserData = 0;
		UserCount = 0;
	}

  };

	/* Used when sorting the list */
  struct srreclistsort_t 
  {
	int				SubItem;
	int				ListType;
	srrecfieldid_t	FieldID;
	bool			Reverse;
  };

	/* An array of list information pointers */
  typedef CSrPtrArray<srreclistinfo_t>     CSrRecListInfoArray;
  typedef CSrPtrArray<srrlcustomdata_t>    CSrRLCustomDataArray;
  typedef CSrRefPtrArray<srrlcustomdata_t> CSrRLRefCustomDataArray;

	/* Color options for a specific type of record in the list */
  struct srreclistcolor_t 
  {
	bool		Enable;
	COLORREF	Color;
	int			Order;

	srreclistcolor_t() 
	{
		Enable = true;
		Color  = RGB(255,255,255);
		Order  = 1;
	}
  };

	/* List control options */
  struct srreclistoptions_t 
  {
	bool			EnableColors;
	bool			SaveState;

	srreclistcolor_t	ActiveColor;
	srreclistcolor_t	DeletedColor;
	srreclistcolor_t	IgnoredColor;
	srreclistcolor_t	DangerousColor;
	srreclistcolor_t	QuestColor;

	srreclistoptions_t() 
	{
		EnableColors = true;
		SaveState    = true;

		ActiveColor.Color    = SRRL_DEFAULT_COLOR_ACTIVE;
		DeletedColor.Color   = SRRL_DEFAULT_COLOR_DELETED;
		IgnoredColor.Color   = SRRL_DEFAULT_COLOR_IGNORED;
		DangerousColor.Color = SRRL_DEFAULT_COLOR_DANGEROUS;
		QuestColor.Color     = SRRL_DEFAULT_COLOR_QUEST;

		DeletedColor.Order   = 1;
		ActiveColor.Order    = 2;
		IgnoredColor.Order   = 3;
		QuestColor.Order     = 4;
		DangerousColor.Order = 5;

		IgnoredColor.Enable   = false;
		QuestColor.Enable     = false;
		DangerousColor.Enable = false;

	}
  };

	/* Used to test drop targets */
  struct srrldroprecords_t 
  {
	NMHDR					 Notify;
	CSrRefRecordArray*		 pRecords;
	CSrRLRefCustomDataArray* pCustomDatas;
  };
  
	/* Used for key notify events */
  struct srrlkeydown_t 
  {
		NMKEY		KeyDown;
		bool		Ctrl;
		bool		Alt;
		bool		Shift;
  };

/*===========================================================================
 *		End of Type Definitions
 *=========================================================================*/


/*===========================================================================
 *
 * Begin class CSrRecordListCtrl
 *
 *=========================================================================*/
class CSrRecordListCtrl : public CListCtrl 
{
  DECLARE_DYNCREATE(CSrRecordListCtrl);

  /*---------- Begin Protected Class Members -------------------------*/
protected:
  CSrRecListInfoArray		m_ListInfos;
  srreclistinfo_t*			m_pCurrentList;
  CSrRecordFilter*			m_pCurrentFilter;
  srfilterextra_t			m_ExtraFilter;

  bool						m_ActNormalList;
  bool						m_EnableColors;

  CSrRefRecordArray			m_DragRecords;
  CSrRLRefCustomDataArray	m_DragCustomData;

  bool						m_EnableDrag;
  int						m_DragType;
  bool						m_AcceptDrop;
  bool						m_IsDragging;
  int						m_DragIndex;
  HCURSOR					m_hBadDropCursor;
  HCURSOR					m_hGoodDropCursor;
  CImageList*				m_pDragImage;
  int						m_DropIndex;
  bool						m_LastDropValid;
  bool						m_EnableSort;
  CWnd*						m_pLastDropWnd;

  CSrRLCustomDataArray		m_CustomData;	

  bool						m_AutoResize;
  CRect						m_AutoResizeOffset;

  int						m_ActivateType;

  CSString					m_ListName;

  static srreclistoptions_t m_Options;


  /*---------- Begin Protected Class Methods -------------------------*/
protected:

	/* Create a new list info structure */
  srreclistinfo_t* CreateListInfoObject (void);

	/* Initialize list information with default values if available */
  srreclistinfo_t* CreateDefaultListInfo (const srrectype_t Type);

	/* Helper drag/drop methods */
  void DropRecords (CWnd* pDropWnd);
 
	/* Find list information related to a record type */
  srreclistinfo_t* FindListInfo (const srrectype_t Type);

  	/* Initialize column data with the given information */
  srreclistinfo_t* InitializeColumns (const srrectype_t& Type, srreclistcolinit_t* ListInit, const srrecfieldmap_t* pFieldMap, const dword Flags = 0, const srrecfieldid_t SortField = 0);

	/* Update the texts in a column */
  void SetColumnTexts (const int ListIndex, CSrRecord* pRecord, CSrRefSubrecordArray* pSubrecords);

	/* Helper sort methods */
  virtual void SortListPriv (const srrecfieldid_t FieldID);

	/* Output list information to the registry */
  void WriteListInfoRegistry (void);
  void WriteListInfoRegistry (srreclistinfo_t* pListInfo);
  void WriteListInfoRegistry (const char* pSection, srreclistcolumn_t* pColumn);

  void ReadListInfoRegistry (void);
  void ReadListInfoRegistry (srreclistinfo_t* pListInfo);
  void ReadListInfoRegistry (const char* pSection, srreclistcolumn_t* pColumn);

  const char* CreateRegSectionName (srreclistinfo_t* pListInfo);


  /*---------- Begin Public Class Methods ----------------------------*/
public:

	/* Constructor/Destructor */
  CSrRecordListCtrl();
  virtual ~CSrRecordListCtrl();

	/* Called when the parent window is resized */
  void AutoResize (const int CX, const int CY);

	/* Adds a record to the list */
  virtual int  AddRecord       (CSrRecord*  pRecord);
  virtual int  AddCustomRecord (CSrRecord*  pRecord, CSrSubrecord* pSubrecord, const int UserData = 0);
  virtual int  AddCustomRecord (srrlcustomdata_t& CustomData);
  virtual void AddAllRecords   (CSrEspFile& File);
  virtual void AddAllRecords   (CSrGroup* pTopGroup);

  void ClearSelections(void);

	/* Set default list settings */
  virtual void DefaultSettings (void);

	/* Removes all currently defined columns */
  virtual void DeleteAllColumns (void);
  virtual BOOL DeleteAllItems   (void);

	/* Finds the closest match to the given editorid string in the list */
  virtual int FindEditorID (const SSCHAR* pString);

	/* Find a record in the list */
  virtual int FindRecord (CSrRecord* pRecord);

	/* Access data from a list item */
  virtual CSrRecord*         GetRecord             (const int ListIndex);
  virtual srrlcustomdata_t*  GetCustomData         (const int ListIndex);
  virtual const srrectype_t* GetCurrentRecordType  (void) { return (m_pCurrentList ? m_pCurrentList->pRecordType : NULL); }
  virtual CSrRecord*         GetSelectedRecord     (void);
  virtual srrlcustomdata_t*  GetSelectedCustomData (void);
  virtual int                GetSelectedItem       (void);

  void GetSelectedRecords (CSrRefRecordArray& Records);

  srfilterextra_t& GetExtraFilter (void) { return m_ExtraFilter; }

	/* Access the static options member */
  static srreclistoptions_t& GetOptions (void) { return (m_Options); }

	/* Remove an item from the list */
  virtual bool RemoveItem (const int ListIndex);

	/* Deletes all items and columns from the list */
  void ResetContents (void);

	/* Select a record in the list */
  bool SelectRecord (CSrRecord* pRecord);
  void SelectRecord (const int ListIndex);
  
	/* Setup columns for the given type */
  bool SetupList (const srrectype_t Type);
  bool SetupList (CSrRecordFilter*  pFilter);
  bool SetupList (srreclistinfo_t*  pListInfo);
  bool SetupList (const srrectype_t& Type, srreclistcolinit_t* pListInit, const srrecfieldmap_t* pFieldMap);

	/* Setup a custom list definition */
  bool SetupCustomList (srreclistcolinit_t* pColumns, const srrecfieldmap_t* pFieldMap, const srrecfield_t* pCustomFields);
  
	/* Set custom list data */
  virtual void SetItemData (const int ListIndex, CSrRecord* pRecord);
  virtual void SetItemData (const int ListIndex, CSrRecord* pRecord, CSrSubrecord* pSubrecord, const int UserData);
  virtual void SetItemData (const int ListIndex, const srrlcustomdata_t CustomData);

	/* Set class members */
  void SetAutoResize       (const bool Flag) { m_AutoResize = Flag; }
  void SetAutoResizeOffset (void);
  void SetDragEnable       (const bool Flag) { m_EnableDrag = Flag; }
  void SetColorEnable      (const bool Flag) { m_EnableColors = Flag; }
  void SetSortEnable       (const bool Flag) { m_EnableSort = Flag; }
  void SetDragType         (const int  Type) { m_DragType     = Type; }
  void SetListName         (const char* pName) { m_ListName   = pName; }

	/* Set the activation type */
  void SetActivateType (const int Type) { m_ActivateType = Type; }

	/* Set a custom field value for the current list */
  bool SetCustomField (const int ListIndex, const srrecfieldid_t FieldID, const SSCHAR* pString);

	/* Sorts the current list by the given field */
  virtual void SortList (const srrecfieldid_t FieldID, const bool Reverse = false);

	/* Saves any changes in the current list */
  void UpdateCurrentList (void);

	/* Update a record in the list */
  virtual int  UpdateRecord (CSrRecord* pNewRecord, CSrRecord* pOldRecord);
  virtual void UpdateRecord (const int ListIndex);
  virtual void UpdateRecord (const int ListIndex, CSrRecord* pRecord);

protected:
  afx_msg void OnSize(UINT nType, int cx, int cy);
  afx_msg void OnItemclick(NMHDR* pNMHDR, LRESULT* pResult);
  afx_msg void OnColumnclick(NMHDR* pNMHDR, LRESULT* pResult);
  afx_msg void OnDblclk(NMHDR* pNMHDR, LRESULT* pResult);
  afx_msg void OnCustomdraw(NMHDR* pNMHDR, LRESULT* pResult);
  afx_msg void OnMouseMove (UINT nFlags, CPoint Point);
  afx_msg void OnLButtonUp (UINT nFlags, CPoint Point);
  afx_msg void OnBeginDrag (NMHDR* pNMHDR, LRESULT* pResult);
  afx_msg void OnCaptureChanged (CWnd* pWnd);
  afx_msg UINT OnGetDlgCode();
  afx_msg void OnChar(UINT nChar, UINT nRepCnt, UINT nFlags);
  afx_msg void OnKeyDown(UINT nChar, UINT nRepCnt, UINT nFlags);
  afx_msg void OnClose();
  afx_msg void OnDestroy();
  
  DECLARE_MESSAGE_MAP();

};
/*===========================================================================
 *		End of class CSrRecordListCtrl
 *=========================================================================*/


/*===========================================================================
 *
 * Begin Function Prototypes
 *
 *=========================================================================*/

  srreclistcolumn_t* FindListColumnBySubItem (srreclistinfo_t* pListInfo, const int SubItem);
  srreclistcolumn_t* FindListColumn          (srreclistinfo_t* pListInfo, const srrecfieldid_t FieldID);

  const srrecfield_t* FindSrField (const srrecfield_t* pFields, const srrecfieldid_t FieldID);

/*===========================================================================
 *		End of Function Prototypes
 *=========================================================================*/


#endif
/*===========================================================================
 *		End of File SrRecordlistctrl.H
 *=========================================================================*/

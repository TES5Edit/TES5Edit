/*===========================================================================
 *
 * File:	Esmlistctrl.H
 * Author:	Dave Humphrey (uesp@m0use.net)
 * Created On:	February 5, 2003
 *
 * Description
 *
 *=========================================================================*/
#ifndef __ESMLISTCTRL_H
#define __ESMLISTCTRL_H


/*===========================================================================
 *
 * Begin Required Includes
 *
 *=========================================================================*/
  #include "EsmFile.h"

#if !defined(NO_ESMLIST_EDIT)
  #include "EsmDlgArray.h"
#endif
/*===========================================================================
 *		End of Required Includes
 *=========================================================================*/


/*===========================================================================
 *
 * Begin Definitions
 *
 *=========================================================================*/

	/* Used for image indices */
  #define ESMLIST_IMAGE_ACTIVATOR	0
  #define ESMLIST_IMAGE_ALCHEMY		1
  #define ESMLIST_IMAGE_APPARATUS	2
  #define ESMLIST_IMAGE_ARMOR  		3
  #define ESMLIST_IMAGE_BODYPART	4
  #define ESMLIST_IMAGE_BOOK		5
  #define ESMLIST_IMAGE_CLOTHING	6
  #define ESMLIST_IMAGE_CONTAINER	7
  #define ESMLIST_IMAGE_CREATURE	8
  #define ESMLIST_IMAGE_DOOR		9
  #define ESMLIST_IMAGE_ENCHANT		10
  #define ESMLIST_IMAGE_INGREDIANT	11
  #define ESMLIST_IMAGE_LEVELCREA	12
  #define ESMLIST_IMAGE_LEVELITEM	13
  #define ESMLIST_IMAGE_LIGHT		14
  #define ESMLIST_IMAGE_LOCKPICK	15
  #define ESMLIST_IMAGE_MISC		16
  #define ESMLIST_IMAGE_NPC		17
  #define ESMLIST_IMAGE_PROBE		18
  #define ESMLIST_IMAGE_REPAIR		19
  #define ESMLIST_IMAGE_SPELL		20
  #define ESMLIST_IMAGE_STATIC		21
  #define ESMLIST_IMAGE_WEAPON		22
  #define ESMLIST_IMAGE_GLOBAL		23
  #define ESMLIST_IMAGE_SOUND		24
  #define ESMLIST_IMAGE_EFFECT		25
  #define ESMLIST_IMAGE_DIALOG		26
  #define ESMLIST_IMAGE_SETTING		27
  #define ESMLIST_IMAGE_CLASS		28
  #define ESMLIST_IMAGE_FACTION		29
  #define ESMLIST_IMAGE_RACE		30
  #define ESMLIST_IMAGE_SKILL		31
  #define ESMLIST_IMAGE_SCRIPT		32
  #define ESMLIST_IMAGE_BIRTHSIGN	33
  #define ESMLIST_IMAGE_SOUNDGEN	34
  #define ESMLIST_IMAGE_REGION		35
  #define ESMLIST_IMAGE_CELL		36
  #define ESMLIST_IMAGE_STARTSCRIPT	37

	/* Object list column sizes */
  #define ESMLIST_WIDTH_ID		160
  #define ESMLIST_WIDTH_COUNT		40
  #define ESMLIST_WIDTH_NAME		120
  #define ESMLIST_WIDTH_SCRIPT		100
  #define ESMLIST_WIDTH_MODEL		80
  #define ESMLIST_WIDTH_INVENTORY	80
  #define ESMLIST_WIDTH_ICON		ESMLIST_WIDTH_INVENTORY
  #define ESMLIST_WIDTH_PERSIST		40
  #define ESMLIST_WIDTH_BLOCKED		40
  #define ESMLIST_WIDTH_WEIGHT		50
  #define ESMLIST_WIDTH_TYPE		80
  #define ESMLIST_WIDTH_COST		50
  #define ESMLIST_WIDTH_VALUE		50
  #define ESMLIST_WIDTH_AUTOCALC	50
  #define ESMLIST_WIDTH_QUALITY		40
  #define ESMLIST_WIDTH_CLASS		60
  #define ESMLIST_WIDTH_HEALTH		50
  #define ESMLIST_WIDTH_ENCHANT		100
  #define ESMLIST_WIDTH_ENCHANTPTS	50
  #define ESMLIST_WIDTH_RATING		50
  #define ESMLIST_WIDTH_RACE		100
  #define ESMLIST_WIDTH_PART		100
  #define ESMLIST_WIDTH_FEMALE		40
  #define ESMLIST_WIDTH_PLAYABLE	40
  #define ESMLIST_WIDTH_CHANGED		40
  #define ESMLIST_WIDTH_SCROLL		40
  #define ESMLIST_WIDTH_TEACHES		75
  #define ESMLIST_WIDTH_ORGANIC		40
  #define ESMLIST_WIDTH_RESPAWN		40
  #define ESMLIST_WIDTH_ITEMLIST	200
  #define ESMLIST_WIDTH_SOUND		80
  #define ESMLIST_WIDTH_LEVEL		60
  #define ESMLIST_WIDTH_ESSENTIAL	40
  #define ESMLIST_WIDTH_MOVEMENT	60
  #define ESMLIST_WIDTH_WEAPSHLD	40
  #define ESMLIST_WIDTH_BIPED		40
  #define ESMLIST_WIDTH_CHARGE		70
  #define ESMLIST_WIDTH_EFFECT		80
  #define ESMLIST_WIDTH_ALLPC		40
  #define ESMLIST_WIDTH_LIST		200
  #define ESMLIST_WIDTH_TIME		50
  #define ESMLIST_WIDTH_RADIUS		50
  #define ESMLIST_WIDTH_USES		60
  #define ESMLIST_WIDTH_FACTION		75
  #define ESMLIST_WIDTH_RANK		50
  #define ESMLIST_WIDTH_ANIMATION	75
  #define ESMLIST_WIDTH_PCSTART		40
  #define ESMLIST_WIDTH_SPEED		60
  #define ESMLIST_WIDTH_REACH		60
  #define ESMLIST_WIDTH_CHOPMIN		40
  #define ESMLIST_WIDTH_CHOPMAX		40
  #define ESMLIST_WIDTH_THRUSTMIN	40
  #define ESMLIST_WIDTH_THRUSTMAX	40
  #define ESMLIST_WIDTH_SLASHMIN	40
  #define ESMLIST_WIDTH_SLASHMAX	40
  #define ESMLIST_WIDTH_IGNORERESIST	40
  #define ESMLIST_WIDTH_CHANCENONE	40
  #define ESMLIST_WIDTH_CALCEACH	40
  #define ESMLIST_WIDTH_UNKNOWN		40
  #define ESMLIST_WIDTH_ITEMTYPE	75
  #define ESMLIST_WIDTH_VOLUME		60
  #define ESMLIST_WIDTH_MINRANGE	60
  #define ESMLIST_WIDTH_MAXRANGE	60
  #define ESMLIST_WIDTH_SCHOOL		80
  #define ESMLIST_WIDTH_DISPOSITION	50
  #define ESMLIST_WIDTH_NPCID		90
  #define ESMLIST_WIDTH_NPCFACTION	80
  #define ESMLIST_WIDTH_NPCCELL		80
  #define ESMLIST_WIDTH_INFOFUNC	80
  #define ESMLIST_WIDTH_ATTRIBUTE	100
  #define ESMLIST_WIDTH_CREATURE	100
  #define ESMLIST_WIDTH_PRIORITY	60
  #define ESMLIST_WIDTH_CHANCE		60
  #define ESMLIST_WIDTH_REGION		100
  #define ESMLIST_WIDTH_GRID		70
  #define ESMLIST_WIDTH_REFCOUNT	60
  #define ESMLIST_WIDTH_USERDATA	40
  #define ESMLIST_WIDTH_TOPIC		120
  #define ESMLIST_WIDTH_INDEX		90
  #define ESMLIST_WIDTH_GOLD		90

	/* Object list subitem codes */
  #define ESMLIST_SUBITEM_ID		0
  #define ESMLIST_SUBITEM_COUNT		1
  #define ESMLIST_SUBITEM_NAME		2
  #define ESMLIST_SUBITEM_SCRIPT	3
  #define ESMLIST_SUBITEM_MODEL		4
  #define ESMLIST_SUBITEM_INVENTORY	5
  #define ESMLIST_SUBITEM_ICON		ESMLIST_SUBITEM_INVENTORY
  #define ESMLIST_SUBITEM_PERSIST	6
  #define ESMLIST_SUBITEM_BLOCKED	7
  #define ESMLIST_SUBITEM_WEIGHT	8
  #define ESMLIST_SUBITEM_COST		9
  #define ESMLIST_SUBITEM_VALUE		10
  #define ESMLIST_SUBITEM_AUTOCALC	11
  #define ESMLIST_SUBITEM_TYPE		12
  #define ESMLIST_SUBITEM_QUALITY	13
  #define ESMLIST_SUBITEM_CLASS		14
  #define ESMLIST_SUBITEM_HEALTH	15
  #define ESMLIST_SUBITEM_ENCHANT	16
  #define ESMLIST_SUBITEM_ENCHANTPTS	17
  #define ESMLIST_SUBITEM_RATING	18
  #define ESMLIST_SUBITEM_RACE		19
  #define ESMLIST_SUBITEM_PART		20
  #define ESMLIST_SUBITEM_FEMALE	21
  #define ESMLIST_SUBITEM_PLAYABLE	22
  #define ESMLIST_SUBITEM_CHANGED	23
  #define ESMLIST_SUBITEM_SCROLL	24
  #define ESMLIST_SUBITEM_TEACHES	25
  #define ESMLIST_SUBITEM_ORGANIC	26
  #define ESMLIST_SUBITEM_RESPAWN	27
  #define ESMLIST_SUBITEM_ITEMLIST	28
  #define ESMLIST_SUBITEM_SOUND		29
  #define ESMLIST_SUBITEM_LEVEL		30
  #define ESMLIST_SUBITEM_ESSENTIAL	31
  #define ESMLIST_SUBITEM_MOVEMENT	32
  #define ESMLIST_SUBITEM_WEAPSHLD	33
  #define ESMLIST_SUBITEM_BIPED		34
  #define ESMLIST_SUBITEM_CHARGE	35
  #define ESMLIST_SUBITEM_EFFECT1	36
  #define ESMLIST_SUBITEM_EFFECT2	37
  #define ESMLIST_SUBITEM_EFFECT3	38
  #define ESMLIST_SUBITEM_EFFECT4	39
  #define ESMLIST_SUBITEM_ALLPC		40
  #define ESMLIST_SUBITEM_LIST		41
  #define ESMLIST_SUBITEM_TIME		42
  #define ESMLIST_SUBITEM_RADIUS	43
  #define ESMLIST_SUBITEM_USES		44
  #define ESMLIST_SUBITEM_FACTION	45
  #define ESMLIST_SUBITEM_RANK		46
  #define ESMLIST_SUBITEM_ANIMATION	47
  #define ESMLIST_SUBITEM_PCSTART	48
  #define ESMLIST_SUBITEM_SPEED		49
  #define ESMLIST_SUBITEM_REACH		50
  #define ESMLIST_SUBITEM_CHOPMIN	51
  #define ESMLIST_SUBITEM_CHOPMAX	52
  #define ESMLIST_SUBITEM_THRUSTMIN	53
  #define ESMLIST_SUBITEM_THRUSTMAX	54
  #define ESMLIST_SUBITEM_SLASHMIN	55
  #define ESMLIST_SUBITEM_SLASHMAX	56
  #define ESMLIST_SUBITEM_IGNORERESIST	57
  #define ESMLIST_SUBITEM_CHANCENONE	58
  #define ESMLIST_SUBITEM_CALCEACH	59
  #define ESMLIST_SUBITEM_UNKNOWN	60
  #define ESMLIST_SUBITEM_ITEMTYPE	61
  #define ESMLIST_SUBITEM_CUSTOM	62
  #define ESMLIST_SUBITEM_VOLUME	63

  #define ESMLIST_SUBITEM_MINRANGE	65
  #define ESMLIST_SUBITEM_MAXRANGE	66
  #define ESMLIST_SUBITEM_SCHOOL	67
  #define ESMLIST_SUBITEM_DISPOSITION	68
  #define ESMLIST_SUBITEM_NPCID		69
  #define ESMLIST_SUBITEM_NPCFACTION	70
  #define ESMLIST_SUBITEM_NPCCELL	71
  #define ESMLIST_SUBITEM_INFOFUNC1	72
  #define ESMLIST_SUBITEM_INFOFUNC2	73
  #define ESMLIST_SUBITEM_INFOFUNC3	74
  #define ESMLIST_SUBITEM_INFOFUNC4	75
  #define ESMLIST_SUBITEM_INFOFUNC5	76
  #define ESMLIST_SUBITEM_INFOFUNC6	77
  #define ESMLIST_SUBITEM_ATTRIBUTE	78
  #define ESMLIST_SUBITEM_CREATURE	79
  #define ESMLIST_SUBITEM_PRIORITY	80
  #define ESMLIST_SUBITEM_CHANCE	81
  #define ESMLIST_SUBITEM_REGION	82
  #define ESMLIST_SUBITEM_GRID		83
  #define ESMLIST_SUBITEM_REFCOUNT	84
  #define ESMLIST_SUBITEM_USERDATA	85
  #define ESMLIST_SUBITEM_TOPIC		86
  #define ESMLIST_SUBITEM_PREV		87
  #define ESMLIST_SUBITEM_NEXT		88
  #define ESMLIST_SUBITEM_INDEX		89
  #define ESMLIST_SUBITEM_HAIR		90
  #define ESMLIST_SUBITEM_HEAD		91

  #define ESMLIST_SUBITEM_GOLD			111
  #define ESMLIST_SUBITEM_FIGHT			112
  #define ESMLIST_SUBITEM_ALARM			113
  #define ESMLIST_SUBITEM_FLEE			114
  #define ESMLIST_SUBITEM_HELLO			115
  #define ESMLIST_SUBITEM_NPCAPPARATUS		116
  #define ESMLIST_SUBITEM_NPCARMORS		117
  #define ESMLIST_SUBITEM_NPCBOOKS		118
  #define ESMLIST_SUBITEM_NPCCLOTHING		119
  #define ESMLIST_SUBITEM_NPCINGREDIANTS	120
  #define ESMLIST_SUBITEM_NPCLIGHTS		121
  #define ESMLIST_SUBITEM_NPCLOCKPICKS		122
  #define ESMLIST_SUBITEM_NPCMISC		123
  #define ESMLIST_SUBITEM_NPCPROBES		124
  #define ESMLIST_SUBITEM_NPCPOTIONS		125
  #define ESMLIST_SUBITEM_NPCREPAIRITEMS	126
  #define ESMLIST_SUBITEM_NPCMAGICITEMS		127
  #define ESMLIST_SUBITEM_NPCSPELLS		128
  #define ESMLIST_SUBITEM_NPCWEAPONS		129
  #define ESMLIST_SUBITEM_TRADEGOLD		130
  #define ESMLIST_SUBITEM_NPCENCHANT		131
  #define ESMLIST_SUBITEM_NPCSPELLMAKER		132
  #define ESMLIST_SUBITEM_NPCTRAINING		133
  #define ESMLIST_SUBITEM_NPCREPAIRS		134
  #define ESMLIST_SUBITEM_NPCTRAVEL1		135
  #define ESMLIST_SUBITEM_NPCTRAVEL2		136
  #define ESMLIST_SUBITEM_NPCTRAVEL3		137
  #define ESMLIST_SUBITEM_NPCTRAVEL4		138

	/* Notify message codes */
  #define ESMLIST_NOTIFY_ONDROP		0x8152
  #define ESMLIST_NOTIFY_ONKEY		0x8153
  #define ESMLIST_NOTIFY_ONEDIT		0x8154
  #define ESMLIST_NOTIFY_ONSORT		0x8155
  

#ifndef ListView_SetCheckState
   #define ListView_SetCheckState(hwndLV, i, fCheck) \
      ListView_SetItemState(hwndLV, i, \
      INDEXTOSTATEIMAGEMASK((fCheck)+1), LVIS_STATEIMAGEMASK)
#endif

/*===========================================================================
 *		End of Definitions
 *=========================================================================*/


/*===========================================================================
 *
 * Begin Type Definitions
 *
 *=========================================================================*/

	/* Used for the esm list for each type of output column */
  struct esmcoldata_t {
	const TCHAR*	pName;
	int		FieldType;
	int		Format;
	int		Width;
	int		SubItem;
	PFNLVCOMPARE    SortFunc;
	int		LastSortField;
	int		LastReverseSort;
   };

	/* Used for sort callback events */
  typedef struct {
	int	iSubItem;
	int	iColumn;
	int	iField;
	bool	Reverse;
	long	UserData1;
	long	UserData2;
   } esmlistsortdata_t;

/*===========================================================================
 *		End of Type Definitions
 *=========================================================================*/


/*===========================================================================
 *
 * Begin Class CEsmListCtrl Definition
 *
 *=========================================================================*/
class CEsmListCtrl : public CListCtrl {
  DECLARE_DYNCREATE(CEsmListCtrl);

public:
  static CImageList m_ImageList;		/* Image list for all the lists */


  /*---------- Begin Protected Class Members --------------------*/
protected:
  int		  m_LastSelItem;
  int		  m_ColSubItems[200];		/* Convert a subitem to a current column */
  esmcoldata_t*   m_pCurrentColData;

  bool		  m_ActNormalList;
  bool		  m_WantKeys;
  bool		  m_WantEditMsg;
  bool		  m_WantSortMsg;
  int		  m_LastSortField;

  bool		  m_EnableDrag;
  bool		  m_AcceptDrag;
  bool		  m_IsDragging;
  int		  m_DragIndex;
  int		  m_DropIndex;
  CImageList*	  m_pDragImage;
  CWnd*		  m_pDropWnd;
  CEsmListCtrl*	  m_pDropList;
  esmrecinfo_t**  m_ppDragRecords;
  int		  m_NumDragRecords;

  int		  m_LastSortSubItem;		/* Used when sorting the list */
  bool		  m_SortReverse;
  int		  m_IgnoreCharKey;
  
  COLORREF	  m_ActiveColor;
  COLORREF	  m_DeleteColor;

#if !defined(NO_ESMLIST_EDIT)  
  CEsmDlgHandler* m_pEsmDlgHandler;
#endif

  HCURSOR	  m_hBadDropCursor;
  HCURSOR	  m_hGoodDropCursor;


  /*---------- Begin Protected Class Methods --------------------*/
protected:


  /*---------- Begin Public Class Methods -----------------------*/
public:

	/* Construction */
  CEsmListCtrl();
  virtual ~CEsmListCtrl();

	/* Add an item to the list */
  int AddItem      (esmrecinfo_t* pRecInfo);
  int InsertRecord (const int Index, esmrecinfo_t* pRecInfo);

	/* Used to drag and drop records between lists */
#if !defined(NO_ESMLIST_EDIT)
  void DropItemOnList (CEsmListCtrl* pDropList);
#endif

	/* Edit the first selected item */
  void EditSelectedItem (void);
  void EditRecord       (const int SelIndex, const bool WantEditMsg = false);

	/* Find a specific record in the list */
  int FindRecord (esmrecinfo_t* pRecInfo);

	/* Returns the currently selected item */
  esmrecinfo_t* GetCurrentRecord (void);

	/* Get class members */
  int GetLastSortField (void) const { return (m_LastSortField); }

	/* Convert an item type to an image index */
  int GetImageIndex (CEsmRecord* pRecord);

	/* Get/set an item check */
  bool GetCheck (const int Item) { return (ListView_GetCheckState(m_hWnd, Item) == TRUE); }
  void SetCheck (const int Item, const bool Flag) { ListView_SetCheckState(m_hWnd, Item, Flag); }

	/* Access the recinfo data for an item */
  virtual esmrecinfo_t* GetRecInfo (const int Item);
  
	/* Initializes the list columns */
  void InitObjectList (esmcoldata_t* pColData);

	/* A record has been dropped on the list */
#if !defined(NO_ESMLIST_EDIT)
  int OnDropRecord (CMWEditDoc* pDocument, esmrecinfo_t* pRecInfo);
#endif

	/* Set the properties of the given armor item */
  void SetItem (const int ListIndex, esmrecinfo_t* pRecInfo, esmcoldata_t* pColInfo);
  void SetItem (const int ListIndex, esmrecinfo_t* pRecInfo) { SetItem(ListIndex, pRecInfo, m_pCurrentColData); }

	/* Set class members */
#if !defined(NO_ESMLIST_EDIT)
  void SetDlgHandler  (CEsmDlgHandler* pDlgHandler) { m_pEsmDlgHandler = pDlgHandler; }
#endif
  void SetEnableDrag  (const bool Flag)		   { m_EnableDrag  = Flag; }
  void SetAcceptDrag  (const bool Flag)		   { m_AcceptDrag  = Flag; }
  void SetWantKeys    (const bool Flag)		   { m_WantKeys    = Flag; }
  void SetWantEditMsg (const bool Flag)		   { m_WantEditMsg = Flag; }
  void SetActNormal   (const bool Flag)		   { m_ActNormalList = Flag; }
  void SetWantSortMsg (const bool Flag)		   { m_WantSortMsg = Flag; }

	/* Initializes the list control */
  void OnInitCtrl (void);

	/* Save the current column widths to the col data array */
  void UpdateColData (void);

	/* Update the given item in the list */
  void UpdateItem (const int Index);
  void UpdateItem (esmrecinfo_t* pRecInfo);

	/* ClassWizard generated virtual function overrides */
  //{{AFX_VIRTUAL(CEsmListCtrl)
  //}}AFX_VIRTUAL

	/* Generated message map functions */
protected:
  //{{AFX_MSG(CEsmListCtrl)
  afx_msg UINT OnGetDlgCode();
  afx_msg void OnColumnclick(NMHDR* pNMHDR, LRESULT* pResult);
  afx_msg void OnItemchanged(NMHDR* pNMHDR, LRESULT* pResult);
  afx_msg void OnCustomdraw(NMHDR* pNMHDR, LRESULT* pResult);
  afx_msg void OnDblclk(NMHDR* pNMHDR, LRESULT* pResult);
  afx_msg void OnBeginDrag(NMHDR* pNMHDR, LRESULT* pResult);
  afx_msg void OnMouseMove(UINT nFlags, CPoint point);
  afx_msg void OnLButtonUp(UINT nFlags, CPoint point);
  afx_msg void OnChar(UINT nChar, UINT nRepCnt, UINT nFlags);
  afx_msg void OnKeyDown(UINT nChar, UINT nRepCnt, UINT nFlags);
  afx_msg void OnKeyUp(UINT nChar, UINT nRepCnt, UINT nFlags);
  //}}AFX_MSG

  DECLARE_MESSAGE_MAP();

 };
/*===========================================================================
 *		End of Class CEsmListCtrl Definition
 *=========================================================================*/


/*===========================================================================
 *
 * Begin Function Prototypes
 *
 *=========================================================================*/

	/* Default item sort function for the list control */
  int CALLBACK l_ItemSortCallBack (LPARAM lParam1, LPARAM lParam2, LPARAM lParamSort);

/*===========================================================================
 *		End of Function Prototypes
 *=========================================================================*/



//{{AFX_INSERT_LOCATION}}
//}}AFX_INSERT_LOCATION


#endif
/*===========================================================================
 *		End of File Esmlistctrl.H
 *=========================================================================*/


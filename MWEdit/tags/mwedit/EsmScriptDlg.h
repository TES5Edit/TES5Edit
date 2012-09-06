/*===========================================================================
 *
 * File:	RtfEditView.H
 * Author:	Dave Humphrey (uesp@m0use.net)
 * Created On:	Monday, 10 February, 2003
 *
 * Interface of the CEsmScriptDlg class.
 *
 *=========================================================================*/
#ifndef __RtfEditView_H
#define __RtfEditView_H


/*===========================================================================
 *
 * Begin Required Includes
 *
 *=========================================================================*/
  #include "EsmGlobOptions.h"
  #include "contain/PtrArray.h"
  #include "esmscriptdefs.h"
  #include "CustRichEdit.h"
  #include "EsmScriptCompile.h"
  #include "EsmRecDialog.h"
  #include "windows/dl_tooltip.h"
  #include "EsmScrFuncArray.h"
  #include "editundo.h"
  #include "richole.h"
/*===========================================================================
 *		End of Required Includes
 *=========================================================================*/


/*===========================================================================
 *
 * Begin Definitions
 *
 *=========================================================================*/

	/* Word Types */
  #define ESMSCRIPT_WORDTYPE_END	-1
  #define ESMSCRIPT_WORDTYPE_UNKNOWN	0
  #define ESMSCRIPT_WORDTYPE_ALPHA	1
  #define ESMSCRIPT_WORDTYPE_INTEGER	2
  #define ESMSCRIPT_WORDTYPE_FLOAT	3
  #define ESMSCRIPT_WORDTYPE_OPERATOR	4
  #define ESMSCRIPT_WORDTYPE_STRING	5
  #define ESMSCRIPT_WORDTYPE_COMMENT	6
	
	/* Used when resizing the view */
  #define ESMSCR_VIEW_TOPMARGIN		24
  #define ESMSCR_VIEW_BOTTOMMARGIN	16
  #define ESMSCR_VIEW_RIGHTMARGIN	0
  #define ESMSCR_VIEW_LEFTMARGIN	0
  #define ESMSCR_VIEW_MINSIZE		50

  #define ESMSCR_PARSETTFUNC_NOFUNC	-1
  #define ESMSCR_PARSETTFUNC_NOCHANGE	0
  #define ESMSCR_PARSETTFUNC_UPDATE	1
  #define ESMSCR_PARSETTFUNC_NEWFUNC	2


/*===========================================================================
 *		End of Definitions
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
 * Begin Class CEsmScriptDlg Definition
 *
 *=========================================================================*/
class CEsmScriptDlg : public CEsmRecDialog {

  /*---------- Begin Protected Class Members ----------------------*/
protected:
  CEsmScript*		m_pScript;

  CEsmScriptCompile	m_Compiler;

  bool			m_UpdatingRichEdit;
  long			m_LastUpdateLineCount;

  CEsmScriptOptions*	m_pCurrentScriptOptions;

  HACCEL		m_ScriptAccel;
  CFindReplaceDialog*	m_pFindReplaceDlg;

  CBitmap		m_CopyBmp;
  CBitmap		m_CutBmp;
  CBitmap		m_UndoBmp;
  CBitmap		m_PasteBmp;
  CBitmap		m_CompileBmp;
  CBitmap		m_FindBmp;
  CBitmap		m_ReplaceBmp;
  CBitmap		m_WhiteBmp;
  CBitmap		m_BlueBmp;
  CBitmap		m_IndentBmp;

  CToolTipCtrl		m_ToolbarTip;

  CString		m_ScriptID;

  CDlToolTip		m_ToolTip;
  CFont			m_ToolTipFont;

  CString		m_ToolFunction;
  CEsmScrFuncData*	m_pToolFuncData;
  esmscrfuncinfo_t*	m_pToolFuncInfo;
  int			m_TipFuncArgIndex;
  int			m_LastTipFuncLine;

  CEditUndoStack	m_UndoStack;

  CString		m_DragBuffer;
  long			m_LastDragStartSel;
  long			m_LastDragEndSel;



  /*---------- Begin Protected Class Methods ----------------------*/
protected: 

	/* Create from serialization only */
  CEsmScriptDlg();
  DECLARE_DYNCREATE(CEsmScriptDlg);

  void FindScriptID (void);

  CString GetCurrentScriptWord (void);


public:
  //{{AFX_DATA(CEsmScriptDlg)
  enum { IDD = IDD_SCRIPT_DLG };
  CButton	m_NoFormatCheck;
  CButton	m_BlueButton;
  CButton	m_WhiteButton;
  CButton	m_ReplaceButton;
  CButton	m_FindButton;
  CButton	m_PasteButton;
  CButton	m_CutButton;
  CButton	m_UndoButton;
  CButton	m_CopyButton;
  CButton	m_CompileButton;
  CButton	m_IndentButton;
  CStatic	m_StatusLabel2;
  CStatic	m_StatusLabel1;
  CCustRichEdit	m_ScriptText;
  //}}AFX_DATA


  /*---------- Begin Public Class Methods --------------------------*/
public:

	/* Class destructor */
  virtual ~CEsmScriptDlg();
  
	/* Attempt to automatically indent the script */
  void AutoIndent (void);

	/* Change the display format to the given format */
  void ChangeScriptFormat (CEsmScriptOptions* pNewFormat);

	/* Close any open tool tips */
  void CloseToolTips (void);

	/* Return a format to display a token word with */
  CHARFORMAT2* GetScriptWordFormat (CString& ScriptWord, const int WordType);

  	/* Get class members */
  virtual bool IsModified (void);
  
  	/* Set or update the record data */
  virtual void GetControlData (void);
  virtual void SetControlData (void);

	/* Format the current text in the rich edit */
  void FormatText (void);
  void ParseLine  (const int LineIndex);

	/* Script text clipboard methods */
  void CopyText  (void);
  void CutText   (void);
  void PasteText (void);

	/* Attempt to find and open a function tool tip */
  bool OpenFunctionToolTip (void);
  int  ParseFuncToolTip    (const  TCHAR* pLineBuffer, const int CharPos);
  bool UpdateFuncToolTip   (void);

	/* Update the current position status bar */
  void UpdatePosStatus  (void);
  void UpdateSizeStatus (void);

	/* ClassWizard generated virtual function overrides */
  //{{AFX_VIRTUAL(CEsmScriptDlg)
public:
  virtual BOOL PreCreateWindow(CREATESTRUCT& cs);
  virtual BOOL PreTranslateMessage(MSG* pMsg);
protected:
  virtual void DoDataExchange(CDataExchange* pDX);
  virtual void OnInitialUpdate();
  //}}AFX_VIRTUAL


	/* Generated message map functions */
protected:
  //{{AFX_MSG(CEsmScriptDlg)
  afx_msg void OnChangeScriptText();
  afx_msg void OnUpdateScriptText();
  afx_msg void OnSize(UINT nType, int cx, int cy);
  afx_msg LRESULT OnUpdateScriptPos(WPARAM wParam, LPARAM lParam);
  afx_msg LRESULT OnUpdateScriptScroll (WPARAM wParam, LPARAM lParam);
  afx_msg void OnContextMenu(CWnd* pWnd, CPoint point);
  afx_msg void OnScriptCopy();
  afx_msg void OnScriptCompile();
  afx_msg void OnScriptCut();
  afx_msg void OnScriptFindtext();
  afx_msg void OnScriptPaste();
  afx_msg void OnScriptFuncHelp();
  afx_msg void OnScriptReplacetext();
  afx_msg LONG OnFindReplace(WPARAM wParam, LPARAM lParam);
  afx_msg void OnScriptUndo();
  afx_msg void OnUpdateScriptUndo(CCmdUI* pCmdUI);
  afx_msg void OnPastebutton();
  afx_msg void OnWhitebutton();
  afx_msg void OnBluebutton();
  afx_msg void OnEditCopy();
  afx_msg void OnUpdateEditCopy(CCmdUI* pCmdUI);
  afx_msg void OnUpdateEditCut(CCmdUI* pCmdUI);
  afx_msg void OnEditCut();
  afx_msg void OnEditPaste();
  afx_msg void OnUpdateEditPaste(CCmdUI* pCmdUI);
  afx_msg void OnNoformatcheck();
  afx_msg void OnSave();
  afx_msg void OnMove(int cx, int cy);
  afx_msg void OnKillFocus(CWnd* pWnd);
  afx_msg LRESULT OnGotoError (LPARAM lParam, WPARAM wParam);
  afx_msg void OnLButtonDown(UINT nFlags, CPoint Point);
  afx_msg void OnRButtonDown(UINT nFlags, CPoint Point);
  afx_msg void OnMsgfilterScripttext (NMHDR* pNMHDR, LRESULT* pResult);
  afx_msg void OnSetFocus( CWnd* );
  afx_msg void OnShowWindow( BOOL, UINT );
  //}}AFX_MSG

  DECLARE_MESSAGE_MAP();


// Interface Map
public:

	BEGIN_INTERFACE_PART(RichEditOleCallback, IRichEditOleCallback)
		INIT_INTERFACE_PART(CRichEditView, RichEditOleCallback)
		STDMETHOD(GetNewStorage) (LPSTORAGE*);
		STDMETHOD(GetInPlaceContext) (LPOLEINPLACEFRAME*,
									  LPOLEINPLACEUIWINDOW*,
									  LPOLEINPLACEFRAMEINFO);
		STDMETHOD(ShowContainerUI) (BOOL);
		STDMETHOD(QueryInsertObject) (LPCLSID, LPSTORAGE, LONG);
		STDMETHOD(DeleteObject) (LPOLEOBJECT);
		STDMETHOD(QueryAcceptData) (LPDATAOBJECT, CLIPFORMAT*, DWORD,BOOL, HGLOBAL);
		STDMETHOD(ContextSensitiveHelp) (BOOL);
		STDMETHOD(GetClipboardData) (CHARRANGE*, DWORD, LPDATAOBJECT*);
		STDMETHOD(GetDragDropEffect) (BOOL, DWORD, LPDWORD);
		STDMETHOD(GetContextMenu) (WORD, LPOLEOBJECT, CHARRANGE*, HMENU*);
	END_INTERFACE_PART(RichEditOleCallback)

	DECLARE_INTERFACE_MAP()

 };
/*===========================================================================
 *		End of Class CEsmScriptDlg Definition
 *=========================================================================*/


//{{AFX_INSERT_LOCATION}}
//}}AFX_INSERT_LOCATION


#endif
/*===========================================================================
 *		End of File View.H
 *=========================================================================*/


/*===========================================================================
 *
 * File:	EsmScriptDlg.CPP
 * Author:	Dave Humphrey (uesp@m0use.net)
 * Created On:	Monday, 10 February, 2003
 *
 * Implementation of the CEsmScriptDlg class.
 *
 *=========================================================================*/

	/* Include Files */
#include "stdafx.h"
#include "resource.h"
#include "EsmScriptDlg.h"
#include "MwEditDoc.h"
#include "dl_err.h"
#include "dl_str.h"
#include "dl_time.h"
#include "string/SString.h"
#include "windows/WinUtil.h"
#include "ChildFrmScript.h"
#include "EsmScriptOptions.h"
#include "MWEdit.h"
//#include "afxole.h"


/*===========================================================================
 *
 * Begin Local Definitions
 *
 *=========================================================================*/
  IMPLEMENT_DYNCREATE(CEsmScriptDlg, CEsmRecDialog);
  DEFINE_FILE("EsmScriptDlg.cpp");

  	/* Debug definitions */
#ifdef _DEBUG
  #define new DEBUG_NEW
  #undef THIS_FILE
  static char THIS_FILE[] = __FILE__;
#endif

  static UINT WM_FINDREPLACE = ::RegisterWindowMessage(FINDMSGSTRING);

/*===========================================================================
 *		End of Local Definitions
 *=========================================================================*/


/*===========================================================================
 *
 * Begin Class CEsmScriptDlg Message Map
 *
 *=========================================================================*/
BEGIN_MESSAGE_MAP(CEsmScriptDlg, CEsmRecDialog)
  //{{AFX_MSG_MAP(CEsmScriptDlg)
  ON_EN_CHANGE(IDC_SCRIPTTEXT, OnChangeScriptText)
  ON_EN_UPDATE(IDC_SCRIPTTEXT, OnUpdateScriptText)
  ON_WM_SIZE()
  ON_WM_MOVE()
  ON_WM_LBUTTONDOWN()
  ON_WM_RBUTTONDOWN()
  ON_WM_KILLFOCUS()
  ON_WM_SETFOCUS()
  ON_WM_SHOWWINDOW()
  ON_BN_CLICKED(IDC_SAVE, OnSave)
  ON_MESSAGE(CRE_UPDATEPOS, OnUpdateScriptPos)
  ON_MESSAGE(CRE_UPDATESCROLL, OnUpdateScriptScroll)
  ON_WM_CONTEXTMENU()
  ON_COMMAND(ID_SCRIPT_COPY, OnScriptCopy)
  ON_COMMAND(ID_SCRIPT_COMPILE, OnScriptCompile)
  ON_COMMAND(ID_SCRIPT_CUT, OnScriptCut)
  ON_COMMAND(ID_SCRIPT_FINDTEXT, OnScriptFindtext)
  ON_COMMAND(ID_SCRIPT_PASTE, OnScriptPaste)
  ON_COMMAND(ID_SCRIPT_REPLACETEXT, OnScriptReplacetext)
  ON_COMMAND(ID_SCRIPT_FUNCHELP, OnScriptFuncHelp)
  ON_REGISTERED_MESSAGE(WM_FINDREPLACE, OnFindReplace)    
  ON_COMMAND(ID_SCRIPT_UNDO, OnScriptUndo)
  ON_UPDATE_COMMAND_UI(ID_SCRIPT_UNDO, OnUpdateScriptUndo)
  ON_BN_CLICKED(IDC_WHITEBUTTON, OnWhitebutton)
  ON_BN_CLICKED(IDC_BLUEBUTTON, OnBluebutton)
  ON_COMMAND(ID_EDIT_COPY, OnEditCopy)
  ON_UPDATE_COMMAND_UI(ID_EDIT_COPY, OnUpdateEditCopy)
  ON_UPDATE_COMMAND_UI(ID_EDIT_CUT, OnUpdateEditCut)
  ON_COMMAND(ID_EDIT_CUT, OnEditCut)
  ON_COMMAND(ID_EDIT_PASTE, OnEditPaste)
  ON_UPDATE_COMMAND_UI(ID_EDIT_PASTE, OnUpdateEditPaste)
  ON_COMMAND(IDC_PASTEBUTTON, OnScriptPaste)
  ON_COMMAND(IDC_COPYBUTTON, OnScriptCopy)
  ON_COMMAND(IDC_CUTBUTTON, OnScriptCut)
  ON_COMMAND(IDC_UNDOBUTTON, OnScriptUndo)
  ON_COMMAND(IDC_FINDBUTTON, OnScriptFindtext)
  ON_COMMAND(IDC_REPLACEBUTTON, OnScriptReplacetext)
  ON_COMMAND(IDC_INDENTBUTTON, AutoIndent)
  ON_BN_CLICKED(IDC_COMPILEBUTTON, OnScriptCompile)
  ON_BN_CLICKED(IDC_NOFORMATCHECK, OnNoformatcheck)
  ON_MESSAGE(MSG_SCRIPTFRM_GOTOLINE, OnGotoError)
  ON_NOTIFY(EN_MSGFILTER, IDC_SCRIPTTEXT, OnMsgfilterScripttext)
  //}}AFX_MSG_MAP
END_MESSAGE_MAP()
/*===========================================================================
 *		End of Class CEsmScriptDlg Message Map
 *=========================================================================*/


/*===========================================================================
 *
 * Class CEsmScriptDlg Constructor
 *
 *=========================================================================*/
CEsmScriptDlg::CEsmScriptDlg() : CEsmRecDialog(CEsmScriptDlg::IDD) {
  //{{AFX_DATA_INIT(CEsmScriptDlg)
  //}}AFX_DATA_INIT

  m_pCurrentScriptOptions = GetEsmOptScriptOptions();

  m_UpdatingRichEdit    = false;
  m_LastUpdateLineCount = -1;
  m_LastTipFuncLine     = -1;
  m_LastDragStartSel    = 0;
  m_LastDragEndSel      = 0;

  m_ScriptAccel     = NULL;
  m_pFindReplaceDlg = NULL;
  m_pToolFuncData   = NULL;
  m_HasIDText       = false;

  m_ToolTipFont.CreatePointFont(9, _T("MS Sans Serif"));
 }
/*===========================================================================
 *		End of Class CEsmScriptDlg Constructor
 *=========================================================================*/


/*===========================================================================
 *
 * Class CEsmScriptDlg Destructor
 *
 *=========================================================================*/
CEsmScriptDlg::~CEsmScriptDlg() {
  if (m_ScriptAccel != NULL) DestroyAcceleratorTable(m_ScriptAccel);
  
  if (m_pFindReplaceDlg != NULL && IsWindow(m_pFindReplaceDlg->m_hWnd)) {
    m_pFindReplaceDlg->EndDialog(0);
   }
 }
/*===========================================================================
 *		End of Class CEsmScriptDlg Destructor
 *=========================================================================*/


/*===========================================================================
 *
 * Class CEsmScriptDlg Method - void AutoIndent (void);
 *
 *=========================================================================*/
void CEsmScriptDlg::AutoIndent (void) {
  CString       Buffer;
  CString       IndentString;
  CString       FirstWord;
  CString       Spaces;
  CString       IndentPartString;
  long          LineStart;
  long          LineEnd;
  int           LineLength;
  int           Index;
  int           i;
  int           IndentLevel = 0;
  int           NextIndentLevel = 0;
  long          DeltaSel = 0;
  long          StartSel;
  long          EndSel;
  int           StartSelLine;
  int           EndSelLine;
  int           DeltaStartSel;
  int           DeltaEndSel;

  bool IdentCommentMore = ::GetEsmOptIndentCommentsMore();
  bool IdentInitialLevel = ::GetEsmOptInitialIndentLevel();
  IndentPartString = ::GetEsmOptScriptIndentString();

  m_UpdatingRichEdit = true;
  m_ScriptText.SetRedraw(FALSE);
  m_ScriptText.HideSelection(TRUE, FALSE);

  m_ScriptText.GetWindowText(Buffer);
  m_UndoStack.CreateEntireText(Buffer);

  m_ScriptText.GetSel(StartSel, EndSel);
  StartSelLine  = m_ScriptText.LineFromChar(StartSel);
  EndSelLine    = m_ScriptText.LineFromChar(EndSel);
  DeltaStartSel = StartSel - m_ScriptText.LineIndex(StartSelLine);
  DeltaEndSel   = EndSel   - m_ScriptText.LineIndex(EndSelLine);

  for (Index = 0; Index < m_ScriptText.GetLineCount(); ++Index) {
    LineStart  = m_ScriptText.LineIndex(Index);
    LineEnd    = m_ScriptText.LineIndex(Index + 1);
    LineLength = m_ScriptText.LineLength(LineStart);
    DeltaSel   = 0;

    m_ScriptText.GetLine(Index, Buffer.GetBuffer(LineLength + 4), LineLength);
    Buffer.ReleaseBuffer(LineLength);

    Spaces = Buffer.SpanIncluding(" \t");
    DeltaSel -= Spaces.GetLength();
    Buffer.TrimLeft(" \t");
    FirstWord = Buffer.SpanExcluding(" \t\n\r.=<>!-+;:`~@#$%^&*()[]{}\\|,?'\"");
    IndentString = "";

    if (FirstWord.CompareNoCase("if") == 0 ||
	FirstWord.CompareNoCase("ifx") == 0 ||
        FirstWord.CompareNoCase("while") == 0 ||
	FirstWord.CompareNoCase("whilex") == 0) {
      ++NextIndentLevel;
    }
    else if (FirstWord.CompareNoCase("begin") == 0 && IdentInitialLevel) {
      ++NextIndentLevel;
    }
    else if (FirstWord.CompareNoCase("else") == 0 ||
            FirstWord.CompareNoCase("elseif") == 0) {
      --IndentLevel;
    }
    else if (FirstWord.CompareNoCase("end") == 0 && IdentInitialLevel) {
      --IndentLevel;
      NextIndentLevel = IndentLevel;
    }   
    else if (FirstWord.CompareNoCase("endif") == 0 ||
        FirstWord.CompareNoCase("endwhile") == 0) {        
      --IndentLevel;
      NextIndentLevel = IndentLevel;
    }
    else if (Buffer.GetLength() > 0 && Buffer.GetAt(0) == ';') {
      if (IdentCommentMore) {
        IndentString = IndentPartString;
        DeltaSel += IndentPartString.GetLength();
      }
    }

    for (i = 0; i < IndentLevel; ++i) {
        IndentString += IndentPartString;
        DeltaSel += IndentPartString.GetLength();
    }

    IndentLevel = NextIndentLevel;

    if (!Buffer.IsEmpty()) Buffer = IndentString + Buffer;

    if (Index != m_ScriptText.GetLineCount() - 1) {
        Buffer += "\r\n";
    }

    m_ScriptText.SetSel(LineStart, LineEnd);
    m_ScriptText.ReplaceSel(Buffer);

    if (StartSelLine == Index) {
        StartSel = LineStart + DeltaSel + DeltaStartSel;
    }

    if (EndSelLine == Index) {
        EndSel = LineStart + DeltaSel + DeltaEndSel;
    }
  }

  m_ScriptText.SetSel(StartSel, EndSel);
  m_ScriptText.SetFocus();

  m_ScriptText.SetRedraw(TRUE);
  m_ScriptText.HideSelection(FALSE, FALSE);
  m_UpdatingRichEdit = false;
  FormatText();
  m_ScriptText.Invalidate();
}
/*===========================================================================
 *		End of Class Method CEsmScriptDlg::AutoIndent()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CEsmScriptDlg Method - void ChangeScriptFormat (pNewFormat);
 *
 *=========================================================================*/
void CEsmScriptDlg::ChangeScriptFormat (CEsmScriptOptions* pNewFormat) {

  if (pNewFormat != NULL) {
    m_pCurrentScriptOptions = pNewFormat;
    m_ScriptText.SetBackgroundColor(FALSE, m_pCurrentScriptOptions->GetBGColor());
    m_ScriptText.SetFont(m_pCurrentScriptOptions->GetTextFont());
    FormatText();
    m_ScriptText.Invalidate();
   }

 }
/*===========================================================================
 *		End of Class Method CEsmScriptDlg::ChangeScriptFormat()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CEsmScriptDlg Method - void DoDataExchange (pDX);
 *
 *=========================================================================*/
void CEsmScriptDlg::DoDataExchange(CDataExchange* pDX) {
  CEsmRecDialog::DoDataExchange(pDX);
  //{{AFX_DATA_MAP(CEsmScriptDlg)
  DDX_Control(pDX, IDC_NOFORMATCHECK, m_NoFormatCheck);
  DDX_Control(pDX, IDC_BLUEBUTTON, m_BlueButton);
  DDX_Control(pDX, IDC_WHITEBUTTON, m_WhiteButton);
  DDX_Control(pDX, IDC_REPLACEBUTTON, m_ReplaceButton);
  DDX_Control(pDX, IDC_FINDBUTTON, m_FindButton);
  DDX_Control(pDX, IDC_PASTEBUTTON, m_PasteButton);
  DDX_Control(pDX, IDC_INDENTBUTTON, m_IndentButton);
  DDX_Control(pDX, IDC_CUTBUTTON, m_CutButton);
  DDX_Control(pDX, IDC_UNDOBUTTON, m_UndoButton);
  DDX_Control(pDX, IDC_COPYBUTTON, m_CopyButton);
  DDX_Control(pDX, IDC_COMPILEBUTTON, m_CompileButton);
  DDX_Control(pDX, IDC_STATUSBOX2, m_StatusLabel2);
  DDX_Control(pDX, IDC_STATUSBOX1, m_StatusLabel1);
  DDX_Control(pDX, IDC_SCRIPTTEXT, m_ScriptText);
  //}}AFX_DATA_MAP
 }
/*===========================================================================
 *		End of Class Method CEsmScriptDlg::DoDataExchange()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CEsmScriptDlg Method - void FindScriptID (void);
 *
 *=========================================================================*/
void CEsmScriptDlg::FindScriptID (void) {
  CString Buffer;
  TCHAR*  pString;
  TCHAR*  pString2;

  m_ScriptText.GetWindowText(Buffer);
  pString = stristr(Buffer, _T("begin "));

  if (pString == NULL) {
    m_ScriptID.Empty();
   }
  else {
    pString += 6;
    pString2 = strchr(pString, '\n');

    if (pString2 != NULL) {
      CString TempStr(pString, pString2 - pString);
      m_ScriptID = TempStr;
     }
    else {
      m_ScriptID = pString;
     }
   
    TrimStringSpace(m_ScriptID);
   }

 }
/*===========================================================================
 *		End of Class Method CEsmScriptDlg::FindScriptID()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CEsmScriptDlg Method - void FormatText (void);
 *
 *=========================================================================*/
void CEsmScriptDlg::FormatText (void) {
  int	 LineCount;
  double StartTime;
  double EndTime;
  long   StartChar;
  long   EndChar;

  StartTime = GetHiClockTime();
  m_UpdatingRichEdit = true;
  m_ScriptText.SetRedraw(FALSE);
  m_ScriptText.HideSelection(TRUE, FALSE);
  m_ScriptText.GetSel(StartChar, EndChar);
  //MessageBox("format");

  	/* Clear the current line format if no formatting is choosen */
  if (GetEsmOptNoScriptFormat()) {
    m_ScriptText.SetSel(0, -1);
    m_ScriptText.SetSelectionCharFormat(*m_pCurrentScriptOptions->GetCharFormat(ESMSCRIPT_FORMAT_DEFAULT));	
   } 
	/* Parse each line of the rich edit box */
  else {
    for (LineCount = 0; LineCount < m_ScriptText.GetLineCount(); LineCount++) {
      ParseLine(LineCount);
     }
   }

  m_ScriptText.SetRedraw(TRUE);
  m_ScriptText.SetSel(StartChar, EndChar);
  m_ScriptText.HideSelection(FALSE, FALSE);
  EndTime = GetHiClockTime();
  //SystemLog.Printf("FormatTime = %g secs", EndTime-StartTime);
  m_UpdatingRichEdit = false;

  m_LastUpdateLineCount = m_ScriptText.GetLineCount();
 }
/*===========================================================================
 *		End of Class Method CEsmScriptDlg::FormatText()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CEsmScriptDlg Method - void GetControlData (void);
 *
 *=========================================================================*/
void CEsmScriptDlg::GetControlData (void) {
  CString	 Buffer;
  CEsmSubRecord* pSubRec;
  CEsmSubSCHD*   pScriptHeader;

	/* Update the record pointer and data */
  m_pScript = (CEsmScript *) GetRecInfo()->pRecord;
  ASSERT(m_pScript != NULL);

	/* Change ID if required */
  if (m_RecEditInfo.HasNewID) {
    m_pScript->SetID(m_ScriptID);
   }

  m_ScriptText.GetWindowText(Buffer);
  m_pScript->SetScriptText(Buffer);

	/* Set the script header */
  pScriptHeader = m_pScript->GetScriptHeader();
  if (pScriptHeader == NULL) pScriptHeader = (CEsmSubSCHD *) m_pScript->AllocateSubRecord(MWESM_SUBREC_SCHD);
  pScriptHeader->GetScriptHeadData()->LocalVarSize = m_Compiler.GetLocalVarDataSize();
  pScriptHeader->GetScriptHeadData()->ScriptDataSize = m_Compiler.GetScriptDataSize();
  pScriptHeader->GetScriptHeadData()->NumShorts = m_Compiler.GetNumShortLocals();
  pScriptHeader->GetScriptHeadData()->NumLongs  = m_Compiler.GetNumLongLocals();
  pScriptHeader->GetScriptHeadData()->NumFloats = m_Compiler.GetNumFloatLocals();

	/* Set the local variable data */
  pSubRec = m_pScript->GetScriptVars();
  if (pSubRec == NULL) pSubRec = m_pScript->AllocateSubRecord(MWESM_SUBREC_SCVR);
  pSubRec->CopyData(m_Compiler.GetLocalVarData(), m_Compiler.GetLocalVarDataSize());

	/* Set the compiled script data */
  pSubRec = m_pScript->GetScriptData();
  if (pSubRec == NULL) pSubRec = m_pScript->AllocateSubRecord(MWESM_SUBREC_SCDT);
  pSubRec->CopyData(m_Compiler.GetScriptData(), m_Compiler.GetScriptDataSize());

 }
/*===========================================================================
 *		End of Class Method CEsmScriptDlg::GetControlData()
 *=========================================================================*/


/*===========================================================================
 *
 * Function - int GetESMScriptWord (WordBuffer, pEditBuffer, CharIndex, StartIndex);
 *
 * Description
 *
 *=========================================================================*/
int GetESMScriptWord (CString& WordBuffer, const TCHAR* pEditBuffer, 
			int& CharIndex, int& StartIndex) {
  TCHAR* pBuffer;
  TCHAR  TempOp[4] = "\0\0\0";
  int    WordLength;
  int    WordType;

	/* Find the start of the word */
  while (isspace(pEditBuffer[CharIndex])) {
    CharIndex++;
   }

	/* Check for the end of the string */
  if (pEditBuffer[CharIndex] == NULL_CHAR) return (ESMSCRIPT_WORDTYPE_END);
  StartIndex = CharIndex;

	/* Determine the type of the word */
  if (pEditBuffer[CharIndex] == ';') {
    WordType = ESMSCRIPT_WORDTYPE_COMMENT;

    while (pEditBuffer[CharIndex] != NULL_CHAR) {
      CharIndex++;
     }
   }
  else if (pEditBuffer[CharIndex] == '"') {
    WordType = ESMSCRIPT_WORDTYPE_STRING;
    CharIndex++;

    while (pEditBuffer[CharIndex] != '"' && pEditBuffer[CharIndex] != NULL_CHAR) {
      CharIndex++;
     }

    if (pEditBuffer[CharIndex] == '"') CharIndex++;
   }
  else if (iscsymf(pEditBuffer[CharIndex])) {
    WordType = ESMSCRIPT_WORDTYPE_ALPHA;

    while (iscsym(pEditBuffer[CharIndex])) {
      CharIndex++;
     }
   }
  else if (isdigit(pEditBuffer[CharIndex])) {
    WordType = ESMSCRIPT_WORDTYPE_INTEGER;

    while (!isspace(pEditBuffer[CharIndex]) && !ispunct(pEditBuffer[CharIndex])) {
      CharIndex++;
     }

	/* Check for a floating point */
    if (pEditBuffer[CharIndex] == '.') {
      CharIndex++;
      WordType = ESMSCRIPT_WORDTYPE_FLOAT;

      while (!isspace(pEditBuffer[CharIndex]) && !ispunct(pEditBuffer[CharIndex])) {
        CharIndex++;
       }
     }
   }
  else if (IsESMScriptOperator(pEditBuffer[CharIndex])) {
    WordType = ESMSCRIPT_WORDTYPE_OPERATOR;
    TempOp[0] = pEditBuffer[CharIndex];
    TempOp[1] = pEditBuffer[CharIndex+1];

    if (IsESMScriptOperator(TempOp)) {
      CharIndex++;
     }

    CharIndex++;
   }
  else {
    WordType = ESMSCRIPT_WORDTYPE_UNKNOWN;
    CharIndex++;
   }

	/* Copy the word into the output buffer */
  WordLength = CharIndex - StartIndex;
  pBuffer = WordBuffer.GetBuffer(WordLength);
  TSTRNCPY(pBuffer, pEditBuffer + StartIndex, WordLength);
  WordBuffer.ReleaseBuffer(WordLength);
   
  return (WordType);
 }
/*===========================================================================
 *		End of Function GetESMScriptWord()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CEsmScriptDlg Method - CHARFORMAT2* GetScriptWordFormat (ScriptWord, WordType);
 *
 * Returns a character format for the given word and type.  Returns NULL
 * if the word/type combination has no special formatting.
 *
 *=========================================================================*/
CHARFORMAT2* CEsmScriptDlg::GetScriptWordFormat (CString& ScriptWord, const int WordType) {

  switch (WordType) {
    case ESMSCRIPT_WORDTYPE_END:
	return (NULL);
    case ESMSCRIPT_WORDTYPE_ALPHA:
	if (IsESMScriptReserved(ScriptWord))
	  return (m_pCurrentScriptOptions->GetCharFormat(ESMSCRIPT_FORMAT_RESERVED));
	else if (IsESMScriptFunction(ScriptWord))
	  return (m_pCurrentScriptOptions->GetCharFormat(ESMSCRIPT_FORMAT_FUNCTION));
        else if (IsESMScriptCustomFunction(ScriptWord))
	  return (m_pCurrentScriptOptions->GetCharFormat(ESMSCRIPT_FORMAT_FUNCTION));

        return (NULL);
    case ESMSCRIPT_WORDTYPE_INTEGER:
	return (m_pCurrentScriptOptions->GetCharFormat(ESMSCRIPT_FORMAT_INTEGER));
    case ESMSCRIPT_WORDTYPE_FLOAT:
	return (m_pCurrentScriptOptions->GetCharFormat(ESMSCRIPT_FORMAT_FLOAT));
    case ESMSCRIPT_WORDTYPE_OPERATOR:
	if (IsESMScriptOperator(ScriptWord))
	  return (m_pCurrentScriptOptions->GetCharFormat(ESMSCRIPT_FORMAT_OPERATOR));
        else
	  return (m_pCurrentScriptOptions->GetCharFormat(ESMSCRIPT_FORMAT_ERROR));
    case ESMSCRIPT_WORDTYPE_STRING:
	return (m_pCurrentScriptOptions->GetCharFormat(ESMSCRIPT_FORMAT_STRING));
    case ESMSCRIPT_WORDTYPE_COMMENT:
	return (m_pCurrentScriptOptions->GetCharFormat(ESMSCRIPT_FORMAT_COMMENT));
    default:
	return (NULL);
   }
 }
/*===========================================================================
 *		End of Class Method CEsmScriptDlg::GetScriptWordFormat()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CEsmScriptDlg Method - bool IsModified (void);
 *
 *=========================================================================*/
bool CEsmScriptDlg::IsModified (void) {
  if (m_Modified) return (true);

  if (m_ScriptText.GetModify()) m_Modified = true;

  return (m_Modified);
 }
/*===========================================================================
 *		End of Class Method CEsmScriptDlg::IsModified()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CEsmScriptDlg Method - void ParseLine (LineIndex);
 *
 * Description
 *
 *=========================================================================*/
void CEsmScriptDlg::ParseLine (const int LineIndex) {
  CString	WordBuffer;
  TCHAR		LineBuffer[256];
  int		CharIndex;
  int		StartIndex;
  int		WordType;
  int		LineSize;
  int		LineCharPos;
  CHARFORMAT2*	pCharFormat;
  double StartTime;
  double EndTime;
  
  StartTime = GetHiClockTime();
  //MessageBox("ParseLine");

	/* Get the line text */
  LineSize = m_ScriptText.GetLine(LineIndex, LineBuffer, 255); 
  LineBuffer[LineSize] = NULL_CHAR;
  LineCharPos = m_ScriptText.LineIndex(LineIndex);
  CharIndex = 0;

	/* Clear the current line format */
  m_ScriptText.SetSel(LineCharPos, m_ScriptText.LineIndex(LineIndex + 1));
  m_ScriptText.SetSelectionCharFormat(*m_pCurrentScriptOptions->GetCharFormat(ESMSCRIPT_FORMAT_DEFAULT));	

	/* Parse the line */
  while (CharIndex < LineSize) {
    WordType = GetESMScriptWord(WordBuffer, LineBuffer, CharIndex, StartIndex);
    pCharFormat = GetScriptWordFormat(WordBuffer, WordType);

    if (pCharFormat != NULL) {
      m_ScriptText.SetSel(StartIndex + LineCharPos, CharIndex + LineCharPos);
      m_ScriptText.SetSelectionCharFormat(*pCharFormat);
     }
   }

  EndTime = GetHiClockTime();
  //m_ScriptText.SetSel(0,0);
  //SystemLog.Printf("\t\tParseTime = %g secs", EndTime-StartTime);
 }
/*===========================================================================
 *		End of Class Method CEsmScriptDlg::ParseLine()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CEsmScriptDlg Event - void OnChangeScriptText ();
 *
 *=========================================================================*/
void CEsmScriptDlg::OnChangeScriptText() {

	/* Ignore if we are manually updating the control somewhere else */
  if (m_UpdatingRichEdit || GetEsmOptNoScriptFormat()) return;

  CPoint CharPoint;
  RECT   Rect;
  long   StartChar;
  long   EndChar;
  int    LineIndex;
  //double StartTime;
  //double EndTime;

	/* Get the current s */
  //StartTime = GetHiClockTime();
  m_ScriptText.SetRedraw(FALSE);
  m_ScriptText.GetSel(StartChar, EndChar);
  m_ScriptText.HideSelection(TRUE, FALSE);

	/* Format the line */
  ParseLine(m_ScriptText.LineFromChar(-1));

	/* Reset the previous selection */
  m_ScriptText.SetSel(StartChar, EndChar);
  m_ScriptText.SetRedraw(TRUE);
  m_ScriptText.HideSelection(FALSE, FALSE);

	/* Determine the update area */
  m_ScriptText.GetClientRect(&Rect);
  LineIndex = m_ScriptText.LineIndex(-1);
  CharPoint = m_ScriptText.GetCharPos(LineIndex);
  Rect.top = CharPoint.y;
  LineIndex = m_ScriptText.LineFromChar(-1);

	/* Are we at the last line of the text? */	
  if (LineIndex >= m_ScriptText.GetLineCount() - 1) {
    CharPoint = m_ScriptText.GetCharPos(m_ScriptText.LineIndex(LineIndex));
    CharPoint.y += 20;
   }
  else
    CharPoint = m_ScriptText.GetCharPos(m_ScriptText.LineIndex(LineIndex + 1));

  Rect.bottom = CharPoint.y ;

	/* Perform the minimum amount of redraw possible */
  if (m_LastUpdateLineCount != m_ScriptText.GetLineCount()) {
    m_ScriptText.Invalidate(FALSE);
    m_ScriptText.RedrawWindow();
   }
  else 
    m_ScriptText.InvalidateRect(&Rect, FALSE);

  //EndTime = GetHiClockTime();
  //SystemLog.Printf("RichUpdateTime = %g secs", EndTime-StartTime);

  m_LastUpdateLineCount = m_ScriptText.GetLineCount();
  UpdateSizeStatus();
 }
/*===========================================================================
 *		End of Class Event CEsmScriptDlg::OnChangeScriptText()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CEsmScriptDlg Method - void CloseToolTips (void);
 *
 * Closes any tool tips currently open.
 *
 *=========================================================================*/
void CEsmScriptDlg::CloseToolTips (void) {
  if (m_ToolTip.IsOpen()) m_ToolTip.Hide();
  m_pToolFuncData   = NULL;
  m_LastTipFuncLine = -1;
 }
/*===========================================================================
 *		End of Class Method CEsmScriptDlg::CloseToolTips()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CEsmScriptDlg Event - void OnContextMenu (pWnd, Point);
 *
 *=========================================================================*/
void CEsmScriptDlg::OnContextMenu (CWnd* pWnd, CPoint Point) {
  CMenu  Menu;
  CMenu* pPopup;
  BOOL   Result;
  int    Index;
  CCmdUI MenuState;
  
	/* Only show the context menu for the script text control */
  if (pWnd->GetDlgCtrlID() != IDC_SCRIPTTEXT) return;

	/* Attempt to load and initialize the popup menu */
  Result = Menu.LoadMenu(IDR_SCRIPTMENU);
  if (!Result) return;
  pPopup = Menu.GetSubMenu(0);
  if (pPopup == NULL) return;

  	/* Force the update of the menu commands */
  for (Index = 0; Index < (int) pPopup->GetMenuItemCount(); Index++) {
    MenuState.m_nID = pPopup->GetMenuItemID(Index);
    MenuState.m_nIndex = Index;
    MenuState.m_pMenu = pPopup;
    MenuState.m_pOther = NULL;
    MenuState.m_pSubMenu = NULL;
    MenuState.m_nIndexMax = pPopup->GetMenuItemCount();

    if (MenuState.m_nID != 0) {
      OnCmdMsg(MenuState.m_nID, CN_UPDATE_COMMAND_UI, &MenuState, NULL);
     }
   }

	/* Display the popup menu */
  pPopup->TrackPopupMenu(TPM_LEFTBUTTON | TPM_LEFTALIGN, Point.x, Point.y, this);
 }
/*===========================================================================
 *		End of Class Event CEsmScriptDlg::OnContextMenu()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CEsmScriptDlg Event - LONG OnFindReplace (wParam, lParam);
 *
 
    CHARRANGE chrg;      // range to search
    LPSTR lpstrText;     // null-terminated string to find
    CHARRANGE chrgText;  // range in which text is found

 *=========================================================================*/
LONG CEsmScriptDlg::OnFindReplace(WPARAM wParam, LPARAM lParam) {
  CFindReplaceDialog* pDialog = CFindReplaceDialog::GetNotifier(lParam);
  FINDTEXTEX FindTextData;
  CString    Buffer;
  long	     Flags = 0;
  long	     StartSel;
  long	     EndSel;
  long	     FindResult;
  long	     ReplaceCount = 0;

	/* Determine if the find dialog is closing */
  if (pDialog->IsTerminating()) {
    m_pFindReplaceDlg = NULL;
    return (0);
   }

	/* Initialize the find structure */
  Buffer = pDialog->GetFindString();
  FindTextData.lpstrText = Buffer.GetBufferSetLength(Buffer.GetLength());
  if (pDialog->MatchCase())      Flags |= FR_MATCHCASE;
  if (pDialog->MatchWholeWord()) Flags |= FR_WHOLEWORD;
  m_ScriptText.GetSel(StartSel, EndSel);

  if (pDialog->SearchDown()) { 
    Flags |= FR_DOWN;
    FindTextData.chrg.cpMin = !pDialog->FindNext() ? StartSel : EndSel;
    FindTextData.chrg.cpMax = -1;
   }
  else {
    FindTextData.chrg.cpMin = !pDialog->FindNext() ? EndSel : StartSel;
    FindTextData.chrg.cpMax = 0;
   }

	/* Perform the search Find the text */
  if (pDialog->FindNext()) {
    FindResult = m_ScriptText.FindText(Flags, &FindTextData);

    if (FindResult == -1) {
      MessageBox(_T("No more matches found!"), _T("Find Result"), MB_OK | MB_ICONINFORMATION);
      pDialog->EndDialog(0);
     }
    else
      m_ScriptText.SetSel(FindTextData.chrgText);

   }
  else if (pDialog->ReplaceCurrent()) {
    FindResult = m_ScriptText.FindText(Flags, &FindTextData);

    if (FindResult == -1) 
      MessageBox(_T("No more matches found!"), _T("Find Result"), MB_OK | MB_ICONINFORMATION);
    else {
      m_ScriptText.SetSel(FindTextData.chrgText);
      m_ScriptText.ReplaceSel(pDialog->GetReplaceString(), TRUE);
      m_ScriptText.GetSel(StartSel, EndSel);
      m_ScriptText.SetSel(EndSel, EndSel);

      FindResult = m_ScriptText.FindText(Flags, &FindTextData);
      if (FindResult >= 0) m_ScriptText.SetSel(FindTextData.chrgText);
     }
   }
  else if (pDialog->ReplaceAll()) {
    FindResult = m_ScriptText.FindText(Flags, &FindTextData);

    while (FindResult >= 0) {
      ReplaceCount++;
      m_ScriptText.SetSel(FindTextData.chrgText);
      m_ScriptText.ReplaceSel(pDialog->GetReplaceString(), TRUE);
      m_ScriptText.GetSel(StartSel, EndSel);
      m_ScriptText.SetSel(EndSel, EndSel);
      FindTextData.chrg.cpMin = FindTextData.chrgText.cpMax;
      FindResult = m_ScriptText.FindText(Flags, &FindTextData);
     }

    Buffer.Format(_T("Found and replaced %ld matches!"), ReplaceCount);
    MessageBox(Buffer, _T("Replace Result"), MB_OK | MB_ICONINFORMATION);
    pDialog->EndDialog(0);
   }
  else {
    FindResult = -1;
   }

  Buffer.ReleaseBuffer();

  return (0);
 }
/*===========================================================================
 *		End of Class Event CEsmScriptDlg::OnFindReplace()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CEsmScriptDlg Event - void OnInitialUpdate ();
 *
 *=========================================================================*/
void CEsmScriptDlg::OnInitialUpdate() {
  CEsmRecDialog::OnInitialUpdate();

  //GetParentFrame()->RecalcLayout();
  //ResizeParentToFit();
  SetScrollSizes(MM_TEXT, CSize(0,0));

	/* This stops the richedit control from selecting all text at startup */
  GetParentFrame()->SetWindowPos(NULL, 0, 0, 640, 400, SWP_NOMOVE | SWP_NOZORDER);

	/* Initialize the script accelerator table */
  m_ScriptAccel = LoadAccelerators(AfxGetApp()->m_hInstance, MAKEINTRESOURCE(IDR_SCRIPTACCEL));

	/* Initialize the tooltip */
  m_ToolTip.Create(GetParentFrame());
  m_ToolTip.SetFont(&m_ToolTipFont);
     
/*
  m_IconPicture.OnInitialUpdate();
  double StartTime = GetHiClockTime();
  m_IconPicture.SetEsmIcon("test1.tga");
  m_IconPicture.SetEsmIcon("test1.dds");
  double EndTime = GetHiClockTime();
  SystemLog.Printf ("Time = %g secs", EndTime-StartTime); */
  //m_DefaultScriptOptions.SetNoFormat(true);

  m_Compiler.SetDocument(GetDocument());

	/* Initialize the script text control */
  m_ScriptText.SetFont(m_pCurrentScriptOptions->GetTextFont());
  m_ScriptText.SetBackgroundColor(FALSE, m_pCurrentScriptOptions->GetBGColor());
  m_ScriptText.SetEventMask(m_ScriptText.GetEventMask() | ENM_CHANGE | ENM_UPDATE | ENM_KEYEVENTS);
  //m_ScriptText.SetEventMask(m_ScriptText.GetEventMask() | ENM_CHANGE | ENM_UPDATE);
  m_ScriptText.LimitText(ESM_SCRIPT_MAXTEXT);

  VERIFY(m_ScriptText.SetOLECallback(&m_xRichEditOleCallback));
  //m_lpRichEditOle = m_ScriptText.GetIRichEditOle();
  //m_ScriptText.SendMessage(EM_SETUNDOLIMIT, 0, 0);

		/* Initialize the script text tab-stops */
  m_ScriptText.SetSel(0, -1);
  PARAFORMAT pf;
  pf.cbSize = sizeof(PARAFORMAT);
  pf.dwMask = PFM_TABSTOPS;
  pf.cTabCount = MAX_TAB_STOPS;

  for (int i = 0; i < pf.cTabCount; i++)
    pf.rgxTabs[i] = (i + 1) * 360;

  m_ScriptText.SetParaFormat(pf); 
  m_ScriptText.SetSel(0, 0);

	/* Initialize the buttons/toolbar */
  m_CopyBmp.LoadBitmap(IDB_COPYBMP);
  m_CutBmp.LoadBitmap(IDB_CUTBMP);
  m_UndoBmp.LoadBitmap(IDB_UNDOBMP);
  m_PasteBmp.LoadBitmap(IDB_PASTEBMP);
  m_CompileBmp.LoadBitmap(IDB_COMPILEBMP);
  m_FindBmp.LoadBitmap(IDB_FINDBMP);
  m_ReplaceBmp.LoadBitmap(IDB_REPLACEBMP);
  m_WhiteBmp.LoadBitmap(IDB_WHITEBMP);
  m_BlueBmp.LoadBitmap(IDB_BLUEBMP);
  m_IndentBmp.LoadBitmap(IDB_INDENTBMP);

  m_CopyButton.SetBitmap(m_CopyBmp);
  m_CutButton.SetBitmap(m_CutBmp);
  m_UndoButton.SetBitmap(m_UndoBmp);
  m_PasteButton.SetBitmap(m_PasteBmp);
  m_FindButton.SetBitmap(m_FindBmp);
  m_ReplaceButton.SetBitmap(m_ReplaceBmp);
  m_IndentButton.SetBitmap(m_IndentBmp);
  m_CompileButton.SetBitmap(m_CompileBmp);
  m_WhiteButton.SetBitmap(m_WhiteBmp);
  m_BlueButton.SetBitmap(m_BlueBmp);

  m_ToolbarTip.Create(this, 0);
  m_ToolbarTip.AddTool(&m_CopyButton, _T("Copy    Ctrl+C"));
  m_ToolbarTip.AddTool(&m_PasteButton, _T("Paste   Ctrl+V"));
  m_ToolbarTip.AddTool(&m_CutButton, _T("Cut    Ctrl+X"));
  m_ToolbarTip.AddTool(&m_UndoButton, _T("Undo    Ctrl+Z"));
  m_ToolbarTip.AddTool(&m_FindButton, _T("Find    Ctrl+F"));
  m_ToolbarTip.AddTool(&m_ReplaceButton, _T("Replace    Ctrl+H"));
  m_ToolbarTip.AddTool(&m_CompileButton, _T("Compile    Ctrl+F7"));
  m_ToolbarTip.AddTool(&m_IndentButton, _T("Indent"));
  m_ToolbarTip.Activate(TRUE);

  UpdateSizeStatus();
  UpdatePosStatus();

  SetControlData();
  //m_ScriptText.SetWindowText("test\r\na;sdlkfhjl;sdaj;skdaj;akdfj\r\n;lkal;skda\r\n\r\natasd");
  //m_UpdatingRichEdit = true;
  //m_ScriptText.SetFocus();
  //m_ScriptText.SetSel(-1, -1);
 }
/*===========================================================================
 *		End of Class Event CEsmScriptDlg::OnInitialUpdate()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CEsmScriptDlg Event - void OnKillFocus (pWnd);
 *
 *=========================================================================*/
void CEsmScriptDlg::OnKillFocus (CWnd* pWnd) {
  CloseToolTips();
  CEsmRecDialog::OnKillFocus(pWnd);
}


void CEsmScriptDlg::OnSetFocus (CWnd* pWnd) {
  //m_ScriptText.SetSel(1,2);
  CEsmRecDialog::OnSetFocus(pWnd);
}


void CEsmScriptDlg::OnShowWindow (BOOL bShow, UINT Status) {
  //m_ScriptText.SetSel(3,4);
  CEsmRecDialog::OnShowWindow(bShow, Status);
}
/*===========================================================================
 *		End of Class Event CEsmScriptDlg::OnKillFocus()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CEsmScriptDlg Event - void OnMove (cx, cy);
 *
 *=========================================================================*/
void CEsmScriptDlg::OnMove(int cx, int cy) {
  CloseToolTips();
  CEsmRecDialog::OnMove(cx, cy);
 }
/*===========================================================================
 *		End of Class Event CEsmScriptDlg::OnMove()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CEsmScriptDlg Event - void OnSize (nType, cx, cy);
 *
 *=========================================================================*/
void CEsmScriptDlg::OnSize (UINT nType, int cx, int cy) {
  RECT WndRect;
  int  Width;
  int  Height;

	/* Close any tool tips */
  CloseToolTips();

	/* Call the base class event first */
  CEsmRecDialog::OnSize(nType, cx, cy);

	/* Ignore if we are minimizing or child control is not yet valid */
  if (nType == SIZE_MINIMIZED) return;
  if (!IsWindow(m_ScriptText.m_hWnd)) return;

	/* Compute the new width/height of the main script text control */
  Width  = cx - ESMSCR_VIEW_LEFTMARGIN - ESMSCR_VIEW_RIGHTMARGIN;
  Height = cy - ESMSCR_VIEW_TOPMARGIN - ESMSCR_VIEW_BOTTOMMARGIN;
  if (Width  < ESMSCR_VIEW_MINSIZE) Width  = ESMSCR_VIEW_MINSIZE;
  if (Height < ESMSCR_VIEW_MINSIZE) Height = ESMSCR_VIEW_MINSIZE;

	/* Set the script control size */
  m_ScriptText.SetWindowPos(NULL, 0, 0, Width, Height, SWP_NOMOVE | SWP_NOZORDER);

	/* Change the position of the status labels */
  m_StatusLabel1.SetWindowPos(NULL, 0, Height + ESMSCR_VIEW_TOPMARGIN, 0, 0, SWP_NOSIZE | SWP_NOZORDER);
  m_StatusLabel2.GetWindowRect(&WndRect);
  ScreenToClient(&WndRect);
  m_StatusLabel2.SetWindowPos(NULL, WndRect.left, Height + ESMSCR_VIEW_TOPMARGIN, 0, 0, SWP_NOSIZE | SWP_NOZORDER);
 }
/*===========================================================================
 *		End of Class Event CEsmScriptDlg::OnSize()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CEsmScriptDlg Event - LRESULT OnUpdateScriptPos (wParam, lParam);
 *
 *=========================================================================*/
LRESULT CEsmScriptDlg::OnUpdateScriptPos (WPARAM wParam, LPARAM lParam) {
  UpdatePosStatus();

  if (m_pCurrentScriptOptions->GetNoToolTips()) return (0);

  if (wParam > 0) 
    UpdateFuncToolTip();
  else if (lParam > 0) {
    switch ((TCHAR) lParam) {
      case VK_RETURN:
      case VK_ESCAPE:
      case VK_HOME:
      case VK_END:
      case VK_UP:
      case VK_DOWN:
      case VK_LEFT:
      case VK_RIGHT:
        UpdateFuncToolTip();
        break;
     }
   }
  else if (wParam == -1) {
    UpdateFuncToolTip();
   }

  return (0);
 }
/*===========================================================================
 *		End of Class Event CEsmScriptDlg::OnUpdateScriptPos()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CEsmScriptDlg Event - LRESULT OnUpdateScriptScroll (wParam, lParam);
 *
 *=========================================================================*/
LRESULT CEsmScriptDlg::OnUpdateScriptScroll (WPARAM wParam, LPARAM lParam) {
  CloseToolTips();
  return (0);
}
/*===========================================================================
 *		End of Class Event CEsmScriptDlg::OnUpdateScriptScroll()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CEsmScriptDlg Event - void OnUpdateScriptText ();
 *
 *=========================================================================*/
void CEsmScriptDlg::OnUpdateScriptText() {
 }
/*===========================================================================
 *		End of Class Event CEsmScriptDlg::OnUpdateScriptText()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CEsmScriptDlg Method - BOOL PreCreateWindow (cs);
 *
 *=========================================================================*/
BOOL CEsmScriptDlg::PreCreateWindow (CREATESTRUCT& cs) {
  return CEsmRecDialog::PreCreateWindow(cs);
 }
/*===========================================================================
 *		End of Class Method CEsmScriptDlg::PreCreateWindow()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CEsmScriptDlg Method - BOOL PreTranslateMessage (MSG* pMsg);
 *
 *=========================================================================*/
BOOL CEsmScriptDlg::PreTranslateMessage(MSG* pMsg) {
  int Result;

  m_ToolbarTip.RelayEvent(pMsg);

  if (pMsg->message >= WM_KEYFIRST && pMsg->message <= WM_KEYLAST && m_ScriptAccel != NULL) {
    Result = TranslateAccelerator(m_hWnd, m_ScriptAccel, pMsg);
    return (Result);
   }

  return CEsmRecDialog::PreTranslateMessage(pMsg);
 }
/*===========================================================================
 *		End of Class Method CEsmScriptDlg::PreTranslateMessage()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CEsmScriptDlg Method - void SetControlData (void);
 *
 *=========================================================================*/
void CEsmScriptDlg::SetControlData (void) {
  CString	Buffer;  

  m_UpdatingRichEdit = true;
  
	/* Update the record pointer and data */
  m_pScript = (CEsmScript *) GetRecInfo()->pRecord;
  ASSERT(m_pScript != NULL);

	/* Update the dialog title */
  UpdateTitle(m_pScript->GetID());

	/* Set the main text */
  m_ScriptText.SetWindowText(m_pScript->GetScriptText());
  m_ScriptText.SetModify(FALSE);

  m_UndoStack.Destroy();
  
  m_UpdatingRichEdit = false;

  FormatText();

  m_ScriptText.SetSel(0, 0);
  /*
  m_ScriptText.SetSel(-1, 0);
  m_ScriptText.ReplaceSel("");
  long Start;
  long End;
  m_ScriptText.GetSel(Start, End);
  m_ScriptText.Invalidate();*/
 }
/*===========================================================================
 *		End of Class Method CEsmScriptDlg::SetControlData()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CEsmScriptDlg Method - void CopyText (void);
 *
 * Copies the currently selected text, if any, to the windows clipboard.
 * Text is copied in plain text format.
 *
 *=========================================================================*/
void CEsmScriptDlg::CopyText (void) {
  long Start;
  long End;

  m_ScriptText.Copy();
  m_ScriptText.GetSel(Start, End);
 }
/*===========================================================================
 *		End of Class Method CEsmScriptDlg::CopyText()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CEsmScriptDlg Method - void CutText (void);
 *
 *=========================================================================*/
void CEsmScriptDlg::CutText (void) {
  m_UndoStack.OnCut(&m_ScriptText);

  m_ScriptText.Cut();
  FormatText();
  m_ScriptText.RedrawWindow();
  UpdateSizeStatus();
 }
/*===========================================================================
 *		End of Class Method CEsmScriptDlg::CutText()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CEsmScriptDlg Method - void PasteText (void);
 *
 *=========================================================================*/
void CEsmScriptDlg::PasteText (void) {
  m_UndoStack.OnPaste(&m_ScriptText);

  m_ScriptText.PasteSpecial(CF_TEXT);
  FormatText();
  m_ScriptText.RedrawWindow();
  UpdateSizeStatus();
 }
/*===========================================================================
 *		End of Class Method CEsmScriptDlg::PasteText()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CEsmScriptDlg Method - void UpdatePosStatus (void);
 *
 *=========================================================================*/
void CEsmScriptDlg::UpdatePosStatus (void) {
  CString Buffer;
  long    StartSel;
  long    EndSel;
  long    CurrentLine;
  long    CurrentChar;
 
  m_ScriptText.GetSel(StartSel, EndSel);
  CurrentLine = m_ScriptText.LineFromChar(-1);
  CurrentChar = EndSel - m_ScriptText.LineIndex(CurrentLine);
  Buffer.Format(_T("Ln %d, Col %d"), CurrentLine+1, CurrentChar+1);
  m_StatusLabel1.SetWindowText(Buffer);
 }
/*===========================================================================
 *		End of Class Method CEsmScriptDlg::UpdatePosStatus()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CEsmScriptDlg Method - void UpdateSizeStatus (void);
 *
 *=========================================================================*/
void CEsmScriptDlg::UpdateSizeStatus (void) {
  CString Buffer;

  Buffer.Format(_T("%ld Lines, %d bytes"), m_ScriptText.GetLineCount(), m_ScriptText.GetTextLength());
  m_StatusLabel2.SetWindowText(Buffer);
 }
/*===========================================================================
 *		End of Class Method CEsmScriptDlg::UpdateSizeStatus()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CEsmScriptDlg Event - LRESULT OnGotoError (lParam, wParam);
 *
 *=========================================================================*/
LRESULT CEsmScriptDlg::OnGotoError (LPARAM lParam, WPARAM wParam) {
  long CharPos;

  CharPos = m_ScriptText.LineIndex(lParam - 1) + wParam - 1;

  m_ScriptText.SetSel(CharPos - 1, CharPos);
  m_ScriptText.SetFocus();
  UpdatePosStatus();

  return (0);
 }
/*===========================================================================
 *		End of Class Event CEsmScriptDlg::OnGotoError()
 *=========================================================================*/


/*===========================================================================
 *
 * Begin Script Menu Commands
 *
 *=========================================================================*/
void CEsmScriptDlg::OnScriptCopy() {
  CopyText();
  m_ScriptText.SetFocus();
 }


void CEsmScriptDlg::OnScriptCompile() {
  DEFINE_FUNCTION("CEsmScriptDlg::OnScriptCompile()");
  CEsmScriptError* pError;
  CString  	   ScriptBuffer;
  int		   Result;
  double	   StartTime;
  double	   EndTime;
  
//#if FALSE

	/* Update the error window */
  GetParentFrame()->SendMessage(MSG_SCRIPTFRM_CLEARERROR, 0, 0);

	/* Retrieve the current script text */
  m_ScriptText.GetWindowText(ScriptBuffer);

	/* Initialize the compiler */
  m_Compiler.Destroy();
  m_Compiler.SetMsgLevel(GetEsmOptScriptWarnLevel());
  m_Compiler.SetScriptText(ScriptBuffer, ScriptBuffer.GetLength());
  ErrorHandler.ClearErrorCount();
  
	/* Perform the compile */
  StartTime = GetHiClockTime();
  Result = m_Compiler.Compile();
  EndTime = GetHiClockTime();

	/* Add the last status message */
  CreatePointer(pError, CEsmScriptError);
  m_Compiler.GetErrorArray()->Add(pError);
  pError->SetLine(0);

  ScriptBuffer.Format(_T("%s: Compiled %ld lines in %.3g secs! (%d Warnings, %d Errors)"), 
		(Result < 0) ? _T("Error") : _T("Success"),
		m_ScriptText.GetLineCount(), EndTime - StartTime, m_Compiler.GetNumWarnings(), 
		m_Compiler.GetNumErrors());
  pError->SetMessage(ScriptBuffer);

	/* Display any errors or warnings in the error view */  
  GetParentFrame()->SendMessage(MSG_SCRIPTFRM_UPDATEERROR, (LPARAM) m_Compiler.GetErrorArray(), 0);

	/* Display popup modal dialog if needed */
  if (!GetEsmOptNoScriptPrompt()) {
    ScriptBuffer.Format(_T("%s: Compiled %ld lines in %.3g secs!\r\n\t%3d Warnings\r\n\t%3d Errors!\n\nSee message list at bottom of script window for details."), 
		(Result < 0) ? _T("Error") : _T("Success"), 
		m_ScriptText.GetLineCount(), EndTime - StartTime, m_Compiler.GetNumWarnings(), 
		m_Compiler.GetNumErrors());

    if (Result < 0)
      MessageBox(ScriptBuffer, _T("Compile Error!"), MB_OK | MB_ICONHAND );
    else
      MessageBox(ScriptBuffer, _T("Compile Success"), MB_OK | MB_ICONINFORMATION); 
  }

/*
  if (Result < 0)
    ErrorHandler.NotifyList("Compile aborted due to the following error(s):", "Compile Errors");
  else if (ErrorHandler.GetErrorCount() > 0)
    ErrorHandler.NotifyList("The following compiler warning(s) were found:", "Compile Warnings");
  else {
    ScriptBuffer.Format(_T("Successfully compiled %ld lines in %.3g secs!"), m_ScriptText.GetLineCount(), EndTime - StartTime);
    MessageBox(ScriptBuffer, _T("Compile Success"), MB_OK | MB_ICONINFORMATION);
   }
 */

   	
  SystemLog.Printf ("Compile Time = %g secs", EndTime - StartTime);
//#endif
 }


void CEsmScriptDlg::OnScriptCut() {
  CutText();
  m_ScriptText.SetFocus();
 }


void CEsmScriptDlg::OnScriptFindtext() { 
  CString Buffer;

	/* Don't display more than one find/replace dialog per view */
  if (m_pFindReplaceDlg != NULL && IsWindow(m_pFindReplaceDlg->m_hWnd)) {
    m_pFindReplaceDlg->ShowWindow(SW_RESTORE);
    m_pFindReplaceDlg->SetFocus();
    return;
   }

	/* Otherwise, create and display a new dialog */
  m_pFindReplaceDlg = new CFindReplaceDialog;
  Buffer = m_ScriptText.GetSelText();
  m_pFindReplaceDlg->Create(TRUE, Buffer, "", FR_DOWN, this);
 }


void CEsmScriptDlg::OnScriptPaste() {
  PasteText();
  m_ScriptText.SetFocus();
 }


void CEsmScriptDlg::OnScriptReplacetext() {
  CString Buffer;

	/* Don't display more than one find/replace dialog per view */
  if (m_pFindReplaceDlg != NULL && IsWindow(m_pFindReplaceDlg->m_hWnd)) {
    m_pFindReplaceDlg->ShowWindow(SW_RESTORE);
    m_pFindReplaceDlg->SetFocus();
    //m_pFindReplaceDlg->m_fr.lpstrFindWhat = "test";
    return;
   }

	/* Otherwise, create and display a new dialog */
  m_pFindReplaceDlg = new CFindReplaceDialog;
  Buffer = m_ScriptText.GetSelText();
  m_pFindReplaceDlg->Create(FALSE, Buffer, "", FR_DOWN, this);
 }


void CEsmScriptDlg::OnScriptUndo() {
  int Result;
  
  Result = m_UndoStack.OnUndo(&m_ScriptText);

  if (Result == EDITUNDO_ENTIRETEXT) {
    FormatText();
    m_ScriptText.Invalidate();
  }

  m_ScriptText.SetFocus();
 }


void CEsmScriptDlg::OnUpdateScriptUndo(CCmdUI* pCmdUI) {
  pCmdUI->Enable(!m_UndoStack.IsEmpty());
 }


void CEsmScriptDlg::OnWhitebutton() {
  //ChangeScriptFormat(&m_DefaultScriptOptions);
 }


void CEsmScriptDlg::OnBluebutton() {
  //ChangeScriptFormat(&m_UserScriptOptions);
 }


void CEsmScriptDlg::OnNoformatcheck() {
  //m_DefaultScriptOptions.SetNoFormat(m_NoFormatCheck.GetCheck() != 0);
  //m_UserScriptOptions.SetNoFormat(m_NoFormatCheck.GetCheck() != 0);
  FormatText();
  m_ScriptText.Invalidate();
 }


CString CEsmScriptDlg::GetCurrentScriptWord (void) {
  CString Buffer;
  TCHAR   Char;
  long    StartSel;
  long    EndSel;
  long    CurrentPos;
  long	  CurrentLine;
  int     LineStart;
  int     LineLength;
  int	  Index;

	/* Find the current location of the selection/cursor */
  m_ScriptText.GetSel(StartSel, EndSel);
  CurrentPos = StartSel;
  if (CurrentPos < 0) CurrentPos = EndSel;
  if (CurrentPos < 0) return (Buffer);

	/* Get the current line of text */
  CurrentLine = m_ScriptText.LineFromChar(CurrentPos);
  if (CurrentLine < 0) return (Buffer);
  LineLength  = m_ScriptText.LineLength(CurrentPos);
  if (LineLength <= 0) return (Buffer);
  LineStart = m_ScriptText.LineIndex(CurrentLine);
  if (LineStart < 0) return (Buffer);
  m_ScriptText.GetLine(CurrentLine, Buffer.GetBuffer(LineLength + 8));
  Buffer.ReleaseBuffer(LineLength);

	/* Delete to the right of the current position */
  Index = CurrentPos - LineStart;

  while (Index < Buffer.GetLength()) {
    Char = Buffer.GetAt(Index);

    if (isalpha(Char)) {
      ++Index;
    }
    else {
      Buffer.Delete(Index, Buffer.GetLength() - Index);
      break;
    }
  }
    
	/* Delete to the left of the current position */
  Index = CurrentPos - LineStart - 1;

  while (Index >= 0) {
    Char = Buffer.GetAt(Index);

    if (isalpha(Char)) {
      --Index;
    }
    else {
      Buffer.Delete(0, Index + 1);
      break;
    }
  }

  return (Buffer);
}


void CEsmScriptDlg::OnScriptFuncHelp() {
  CString Buffer;

  Buffer = GetCurrentScriptWord();

  

  GetApp()->OpenFuncHelpView(Buffer);
 }
/*===========================================================================
 *		End of Script Menu Commands
 *=========================================================================*/


/*===========================================================================
 *
 * Begin Standard Edit Events
 *
 *=========================================================================*/
void CEsmScriptDlg::OnEditCopy() {
  OnScriptCopy();
 }

void CEsmScriptDlg::OnUpdateEditCopy(CCmdUI* pCmdUI) {
  if (m_ScriptText.GetSelectionType() != SEL_EMPTY) 
    pCmdUI->Enable(TRUE);
  else
    pCmdUI->Enable(FALSE);
 }

void CEsmScriptDlg::OnUpdateEditCut(CCmdUI* pCmdUI) {
  OnUpdateEditCopy(pCmdUI);
 }

void CEsmScriptDlg::OnEditCut() {
  OnScriptCut();
 }

void CEsmScriptDlg::OnEditPaste() {
  OnScriptPaste();
 }

void CEsmScriptDlg::OnUpdateEditPaste(CCmdUI* pCmdUI) {
  pCmdUI->Enable(IsClipboardFormatAvailable(CF_TEXT));  	
}
/*===========================================================================
 *		End of Standard Edit Events
 *=========================================================================*/


/*===========================================================================
 *
 * Class CEsmScriptDlg Event - void OnSave ();
 *
 *=========================================================================*/
void CEsmScriptDlg::OnSave() {
  CString ScriptBuffer;

  	/* Compile the script, no error/warning output though */
  m_ScriptText.GetWindowText(ScriptBuffer);
  m_Compiler.Destroy();
  m_Compiler.SetScriptText(ScriptBuffer, ScriptBuffer.GetLength());
  m_Compiler.Compile();

	/* Update the script ID */
  FindScriptID();
  m_RecEditInfo.NewID = m_ScriptID;

  if (m_RecEditInfo.OldID.CompareNoCase(m_RecEditInfo.NewID) != 0) {
    m_RecEditInfo.HasNewID = true;
   }
  else {
    m_RecEditInfo.HasNewID = false;
   }

  CEsmRecDialog::OnSave();
 }
/*===========================================================================
 *		End of Class Event CEsmScriptDlg::OnSave()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CEsmScriptDlg Method - bool OpenFunctionToolTip (void);
 *
 * Attempt to find a function at the current cursor position and open
 * a tool tip text for it.
 *
 *=========================================================================*/
bool CEsmScriptDlg::OpenFunctionToolTip (void) {
  CEsmScrFuncData* pFunction;
  TCHAR  LineBuffer[256];
  TCHAR* pParse;
  TCHAR* pEndString;
  int    LineSize;
  int    CharPos;
  long   StartChar;
  long   EndChar;
  long   LineIndex;
  int    Index;

	/* Ignore if tool tips have been disabled */
  if (m_pCurrentScriptOptions->GetNoToolTips()) return (false);
    
	/* Get the current line text buffer */
  LineIndex = m_ScriptText.LineFromChar(-1);
  LineSize = m_ScriptText.GetLine(LineIndex, LineBuffer, 255);
  if (LineSize <= 0) return (false);
  LineBuffer[LineSize] = NULL_CHAR;

	/* Find the current position in the line */
  m_ScriptText.GetSel(StartChar, EndChar);
  CharPos = StartChar - m_ScriptText.LineIndex(-1);
  if (CharPos < 0 || CharPos >= LineSize) CharPos = LineSize - 1;
  pParse     = LineBuffer + CharPos;
  Index      = CharPos;
  pEndString = pParse;

  if (Index > 0) {
    pParse--;
    Index--;
   }

	/* Find the end of the word */
  while (__iscsym(*pEndString)) {
    pEndString++;
   }

	/* Find the start of the string */
  while (Index >= 0 && __iscsym(*pParse)) {
    Index--;
    pParse--;
   } 

	/* See if the word is a function */
  *pEndString = NULL_CHAR;
  pFunction = ((CMWEditApp *)AfxGetApp())->GetFunctionArray()->FindFunction(pParse + 1);
  SystemLog.Printf("Parse = '%s', Function = %d", pParse + 1, pFunction);

  if (pFunction == NULL && GetEsmOptAllowExtFuncs()) {
    
  }

  m_pToolFuncData = pFunction;

  if (pFunction != NULL) {
    CPoint Point = m_ScriptText.GetCaretPos();
    ClientToScreen(&Point);
    Point.x -= 25;
    Point.y += 90;

    m_ToolTip.Show(pFunction->GetExFuncForm(), &Point);
   }

  
  return (true);
 }
/*===========================================================================
 *		End of Class Method CEsmScriptDlg::OpenFunctionToolTip()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CEsmScriptDlg Method - int ParseFuncToolTip (pLineBuffer, CharPos);
 *
 * Parses the given line and updates the class members related to the
 * function tool tip. Returns false on any error.
 *
 *=========================================================================*/
int CEsmScriptDlg::ParseFuncToolTip (const TCHAR* pLineBuffer, const int CharPos) {
  esmscrfuncinfo_t* pFuncInfo;
  esmscrfuncinfo_t* pCurFuncInfo;
  CEsmScrFuncData*  pFuncData;
  CString	    WordBuffer;
  int		    ParsePos;
  int		    StartPos;
  int		    ArgCount;
  int		    TokenID;
  bool		    Result;
  bool		    StopFunc;
  bool		    HasFunc;
  bool		    LastComma;

	/* Initialize loop variables */
  ParsePos     = 0;
  HasFunc      = false;
  StopFunc     = false;
  LastComma    = false;
  ArgCount     = -1;
  pFuncInfo    = NULL;
  pCurFuncInfo = NULL;
  pFuncData    = NULL;

	/* Parse the currentline, word by word until we pass the current position */
  do {
    StartPos = ParsePos;
    Result = GetStringWord(WordBuffer, pLineBuffer, ParsePos);
    if (!Result) break;

		/* A number */
    if (isdigit(WordBuffer.GetAt(0))) {
      if (!LastComma) ArgCount++;
      LastComma = false;
     }
		/* String */
    else if (WordBuffer.GetAt(0) == '"') {
      if (!LastComma) ArgCount++;
      LastComma = false;
     }
		/* A script operator */
    else if (IsESMScriptOperator(WordBuffer)) {
      if (WordBuffer.GetAt(0) == ',') {
        ArgCount++;
        LastComma = true;
       }
      else {
        LastComma = false;
        StopFunc = true;
       }
     }
		/* A reserved word */
    else if ((TokenID = GetESMScriptResToken(WordBuffer)) != ESMSCR_TOKEN_UNKNOWN) {
      if (TokenID == ESMSCR_TOKEN_XYZ) {
        if (!LastComma) ArgCount++;
       }
      else
        StopFunc = true;

      LastComma = false;
     }
		/* A known script function or unknown symbol */
    else {
      pFuncInfo = GetESMScriptFuncInfo(WordBuffer);

      if (pFuncInfo == NULL && ::GetEsmOptAllowExtFuncs()) {
        pFuncInfo = GetESMScriptCustomFuncInfo(WordBuffer);
      }

      if (pFuncInfo != NULL) {
        pCurFuncInfo = pFuncInfo;
        ArgCount     = -1;
	HasFunc      = true;
       }
      else if (!LastComma)  {
        ArgCount++;
       }
      LastComma = false;
     }

		/* Have we passed the character position? */
    if (StartPos <= CharPos && ParsePos >= CharPos) break;
      
		/* Stop parsing a function segment */
    if (StopFunc) {
      pCurFuncInfo = NULL;
      HasFunc      = false;
      StopFunc     = false;
     }

  } while (Result && ParsePos < CharPos);


	/* Check for a current function */
  if (pCurFuncInfo != NULL) {

		/* Attempt to get the function information */
    pFuncData = ((CMWEditApp *)AfxGetApp())->GetFunctionArray()->FindFunction(pCurFuncInfo->Name);
    if (pFuncData == NULL) return (ESMSCR_PARSETTFUNC_NOFUNC);
    if (ArgCount < 0) ArgCount = 0;
    if (ArgCount >= pFuncData->GetNumParams()) ArgCount = pFuncData->GetNumParams() - 1; 

		/* Check if anything hsa changed */
    if (pFuncData == m_pToolFuncData && m_TipFuncArgIndex == ArgCount) return (ESMSCR_PARSETTFUNC_NOCHANGE);

		/* Update the class members */
    m_pToolFuncData   = pFuncData;
    m_pToolFuncInfo   = pCurFuncInfo;
    m_ToolFunction    = m_pToolFuncData->GetExFuncForm(ArgCount, 128);
    m_TipFuncArgIndex = ArgCount;

    if (pFuncData == m_pToolFuncData) return (ESMSCR_PARSETTFUNC_UPDATE);
    return (ESMSCR_PARSETTFUNC_NEWFUNC);
   }
  
  return (ESMSCR_PARSETTFUNC_NOFUNC);
 }
/*===========================================================================
 *		End of Class Method CEsmScriptDlg::ParseFuncToolTip()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CEsmScriptDlg Method - bool UpdateFuncToolTip (void);
 *
 * Attempts to update the function tool tip from the current position in
 * the script text.
 *
 *=========================================================================*/
bool CEsmScriptDlg::UpdateFuncToolTip (void) {
  //DEFINE_FUNCTION("CEsmScriptDlg::UpdateFuncToolTip()");
  CString LineBuffer;
  CPoint  Point;
  int     CharPos;
  int     Result;

	/* Ignore if we don't need to update the tooltips */
  if (m_pCurrentScriptOptions->GetNoToolTips()) return (0);

	/* Get the current line information */
  m_ScriptText.GetCurLineText(LineBuffer);
  CharPos = m_ScriptText.GetCurLineCharPos();

  Result = ParseFuncToolTip(LineBuffer, CharPos);

  if (Result == ESMSCR_PARSETTFUNC_NOFUNC) {
    CloseToolTips();
    return (false);
   }
  else if (Result >= 0) {
    int LineIndex = m_ScriptText.LineFromChar(-1);
    if (Result == ESMSCR_PARSETTFUNC_NOCHANGE && LineIndex == m_LastTipFuncLine) return (false);

    Point = m_ScriptText.GetCaretPos();
    ClientToScreen(&Point);
    Point.x -= 40;
    Point.y += 40;

    if (m_ToolTip.IsOpen()) {
      if (Result == ESMSCR_PARSETTFUNC_UPDATE) {
        Point = m_ToolTip.GetToolTipPoint();
       }

      m_ToolTip.Hide();
     }
    
    m_ToolTip.SetShowDelay(0);
    m_ToolTip.Show(m_ToolFunction, &Point);
    m_LastTipFuncLine = LineIndex;
   }

  return (true);
 }
/*===========================================================================
 *		End of Class Method CEsmScriptDlg::UpdateFuncToolTip()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CEsmScriptDlg Event - void OnLButtonDown (nFlags, Point);
 *
 *=========================================================================*/
void CEsmScriptDlg::OnLButtonDown(UINT nFlags, CPoint Point) {
  CEsmRecDialog::OnLButtonDown(nFlags, Point);
  //UpdateFuncToolTip();
 }


void CEsmScriptDlg::OnRButtonDown(UINT nFlags, CPoint Point) {
  CEsmRecDialog::OnRButtonDown(nFlags, Point);
  //UpdateFuncToolTip();
 }
/*===========================================================================
 *		End of Class Event CEsmScriptDlg::OnLButtonDown()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CEsmScriptDlg Event - void OnMsgfilterScripttext (NMHDR* pNMHDR, LRESULT* pResult);
 *
 *=========================================================================*/
void CEsmScriptDlg::OnMsgfilterScripttext (NMHDR* pNMHDR, LRESULT* pResult) {
  MSGFILTER *pMsgFilter = reinterpret_cast<MSGFILTER *>(pNMHDR);

  switch (pMsgFilter->msg) {
    case WM_KEYDOWN:
        m_UndoStack.OnKeyDown(&m_ScriptText, pMsgFilter->wParam);
	break;
    case WM_CHAR:
	m_UndoStack.OnChar(&m_ScriptText, pMsgFilter->wParam);
	break;
  }

  *pResult = 0;
}
/*===========================================================================
 *		End of Class Event CEsmScriptDlg::OnMsgfilterScripttext()
 *=========================================================================*/


/*===========================================================================
 *
 * Begin CEsmScriptDlg RichEditOleCallback Definition
 *
 * Used to detect drag events for undo.
 *
 *=========================================================================*/
BEGIN_INTERFACE_MAP(CEsmScriptDlg, CEsmRecDialog)
	// we use IID_IUnknown because richedit doesn't define an IID
	INTERFACE_PART(CEsmScriptDlg, IID_IUnknown, RichEditOleCallback)
END_INTERFACE_MAP()

STDMETHODIMP_(ULONG) CEsmScriptDlg::XRichEditOleCallback::AddRef()
{
	METHOD_PROLOGUE_EX_(CEsmScriptDlg, RichEditOleCallback)
	return (ULONG)pThis->InternalAddRef();
}

STDMETHODIMP_(ULONG) CEsmScriptDlg::XRichEditOleCallback::Release()
{
	METHOD_PROLOGUE_EX_(CEsmScriptDlg, RichEditOleCallback)
	return (ULONG)pThis->InternalRelease();
}

STDMETHODIMP CEsmScriptDlg::XRichEditOleCallback::QueryInterface(
	REFIID iid, LPVOID* ppvObj)
{
	METHOD_PROLOGUE_EX_(CEsmScriptDlg, RichEditOleCallback)
	return (HRESULT)pThis->InternalQueryInterface(&iid, ppvObj);
}

STDMETHODIMP CEsmScriptDlg::XRichEditOleCallback::GetNewStorage(LPSTORAGE* ppstg)
{
	return E_NOTIMPL;
}

STDMETHODIMP CEsmScriptDlg::XRichEditOleCallback::GetInPlaceContext(
	LPOLEINPLACEFRAME* lplpFrame, LPOLEINPLACEUIWINDOW* lplpDoc,
	LPOLEINPLACEFRAMEINFO lpFrameInfo)
{
	return E_NOTIMPL;
}

STDMETHODIMP CEsmScriptDlg::XRichEditOleCallback::ShowContainerUI(BOOL fShow)
{
	return E_NOTIMPL;
}

STDMETHODIMP CEsmScriptDlg::XRichEditOleCallback::QueryInsertObject(
	LPCLSID /*lpclsid*/, LPSTORAGE /*pstg*/, LONG /*cp*/)
{
	
	return S_OK;
}

STDMETHODIMP CEsmScriptDlg::XRichEditOleCallback::DeleteObject(LPOLEOBJECT /*lpoleobj*/)
{
	return E_NOTIMPL;
}

STDMETHODIMP CEsmScriptDlg::XRichEditOleCallback::QueryAcceptData(
	LPDATAOBJECT lpdataobj, CLIPFORMAT* lpcfFormat, DWORD reco,
	BOOL fReally, HGLOBAL hMetaPict)
{
	METHOD_PROLOGUE_EX_(CEsmScriptDlg, RichEditOleCallback)

	if (fReally && reco == RECO_DROP) {
		long StartSel;
		long EndSel;
		pThis->m_ScriptText.GetSel(StartSel, EndSel);

		if (pThis->m_LastDragStartSel >= 0 && pThis->m_LastDragEndSel >= 0 && 
			pThis->m_LastDragEndSel - pThis->m_LastDragStartSel > 0 &&
			StartSel == EndSel && StartSel >= 0) {
		   if (StartSel > pThis->m_LastDragEndSel) StartSel -= pThis->m_DragBuffer.GetLength();
		   pThis->m_UndoStack.CreateDeleteString(pThis->m_DragBuffer, pThis->m_LastDragStartSel, pThis->m_LastDragEndSel);
		   pThis->m_UndoStack.CreateInsertString(pThis->m_DragBuffer, StartSel, StartSel);
		}
	}

	return S_OK;
}

STDMETHODIMP CEsmScriptDlg::XRichEditOleCallback::ContextSensitiveHelp(BOOL /*fEnterMode*/)
{
	return E_NOTIMPL;
}

STDMETHODIMP CEsmScriptDlg::XRichEditOleCallback::GetClipboardData(
	CHARRANGE* lpchrg, DWORD reco, LPDATAOBJECT* lplpdataobj)
{
	return E_NOTIMPL;
}

STDMETHODIMP CEsmScriptDlg::XRichEditOleCallback::GetDragDropEffect(
	BOOL fDrag, DWORD grfKeyState, LPDWORD pdwEffect)
{

	METHOD_PROLOGUE_EX_(CEsmScriptDlg, RichEditOleCallback)
	pThis->m_ScriptText.GetSel(pThis->m_LastDragStartSel, pThis->m_LastDragEndSel);
	pThis->m_DragBuffer = pThis->m_ScriptText.GetSelText();

	if (!fDrag) // allowable dest effects
	{
		DWORD dwEffect;
		// check for force link
		if ((grfKeyState & (MK_CONTROL|MK_SHIFT)) == (MK_CONTROL|MK_SHIFT))
			dwEffect = DROPEFFECT_LINK;
		// check for force copy
		else if ((grfKeyState & MK_CONTROL) == MK_CONTROL)
			dwEffect = DROPEFFECT_COPY;
		// check for force move
		else if ((grfKeyState & MK_ALT) == MK_ALT)
			dwEffect = DROPEFFECT_MOVE;
		// default -- recommended action is move
		else
			dwEffect = DROPEFFECT_MOVE;
		if (dwEffect & *pdwEffect) // make sure allowed type
			*pdwEffect = dwEffect;
	}
	return S_OK;
}

STDMETHODIMP CEsmScriptDlg::XRichEditOleCallback::GetContextMenu(
	WORD seltype, LPOLEOBJECT lpoleobj, CHARRANGE* lpchrg,
	HMENU* lphmenu)
{
	METHOD_PROLOGUE_EX_(CEsmScriptDlg, RichEditOleCallback)
	HMENU TempMenu = LoadMenu(::AfxGetInstanceHandle(), MAKEINTRESOURCE(IDR_SCRIPTMENU));
	if (lphmenu && TempMenu) *lphmenu = GetSubMenu(TempMenu, 0);
	return S_OK;
}
/*===========================================================================
 *		End of CEsmScriptDlg RichEditOleCallback Definition
 *=========================================================================*/

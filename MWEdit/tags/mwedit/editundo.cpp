/*===========================================================================
 *
 * File:	Editundo.CPP
 * Author:	Dave Humphrey (uesp@m0use.net)
 * Created On:	August 22, 2006
 *
 * Description
 *
 *=========================================================================*/

	/* Include Files */
#include "stdafx.h"
#include "editundo.h"
#include "dl_str.h"
#include "windows/winutil.h"


/*===========================================================================
 *
 * Begin Local Definitions
 *
 *=========================================================================*/
  DEFINE_FILE("EditUndo.cpp");
/*===========================================================================
 *		End of Local Definitions
 *=========================================================================*/


/*===========================================================================
 *
 * Class CEditUndo Constructor
 *
 *=========================================================================*/
CEditUndo::CEditUndo () {
  //DEFINE_FUNCTION("CEditUndo::CEditUndo()");

  m_pString      = NULL;
  m_Char         = NULL_CHAR;
  m_StringLength = 0;
  m_Action       = EDITUNDO_NONE;
  m_SelStart     = 0;
  m_SelEnd       = 0;
}
/*===========================================================================
 *		End of Class CEditUndo Constructor
 *=========================================================================*/


/*===========================================================================
 *
 * Class CEditUndo Method - void Destroy (void);
 *
 *=========================================================================*/
void CEditUndo::Destroy (void) {

  DestroyArrayPointer(m_pString);

  m_StringLength = 0;
  m_Action       = EDITUNDO_NONE;
  m_SelStart     = 0;
  m_SelEnd       = 0;
}
/*===========================================================================
 *		End of Class Method CEditUndo::Destroy()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CEditUndo Method - void SetString (pString);
 *
 *=========================================================================*/
void CEditUndo::SetString (const TCHAR* pString) {
  DEFINE_FUNCTION("CEditUndo::SetString()");

  DestroyArrayPointer(m_pString);
  m_StringLength = 0;

  if (pString) {
    m_StringLength = _tcslen(pString);
    CreateArrayPointer(m_pString, TCHAR, m_StringLength + 4);
    strnncpy(m_pString, pString, m_StringLength+1);
  }

}
/*===========================================================================
 *		End of Class Method CEditUndo::SetString()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CEditUndoStack Constructor
 *
 *=========================================================================*/
CEditUndoStack::CEditUndoStack() {
  m_GroupUndos = true;
  m_Limit      = EDITUNDO_DEFAULT_LIMIT;
}
/*===========================================================================
 *		End of Class CEditUndoStack Constructor
 *=========================================================================*/


/*===========================================================================
 *
 * Class CEditUndoStack Method - void Destroy (void);
 *
 *=========================================================================*/
void CEditUndoStack::Destroy (void) {
  m_UndoStack.Destroy();
}
/*===========================================================================
 *		End of Class Method CEditUndoStack::Destroy()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CEditUndoStack Method - void CreateInsertChar (Char, StartSel, EndSel);
 *
 *=========================================================================*/
void CEditUndoStack::CreateInsertChar (const TCHAR Char, const int StartSel, const int EndSel) {
  DEFINE_FUNCTION("CEditUndoStack::CreateInsertChar()");
  CEditUndo* pUndo;

  CreatePointer(pUndo, CEditUndo);
  m_UndoStack.Add(pUndo);

  pUndo->SetChar(Char);
  pUndo->SetAction(EDITUNDO_INSERTCHAR);
  pUndo->SetSelStart(StartSel);
  pUndo->SetSelEnd(EndSel);

  if (m_UndoStack.GetNumElements() > m_Limit) {
    m_UndoStack.DeleteElement(0);
  }
}
/*===========================================================================
 *		End of Class Method CEditUndoStack::CreateInsertChar()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CEditUndoStack Method - void CreateInsertString (pString, StartSel, EndSel);
 *
 *=========================================================================*/
void CEditUndoStack::CreateInsertString (const TCHAR* pString, const int StartSel, const int EndSel) {
  DEFINE_FUNCTION("CEditUndoStack::CreateInsertString()");
  CEditUndo* pUndo;

  CreatePointer(pUndo, CEditUndo);
  m_UndoStack.Add(pUndo);

  pUndo->SetString(pString);
  pUndo->SetAction(EDITUNDO_INSERTSTRING);
  pUndo->SetSelStart(StartSel);
  pUndo->SetSelEnd(EndSel);

  if (m_UndoStack.GetNumElements() > m_Limit) {
    m_UndoStack.DeleteElement(0);
  }
}
/*===========================================================================
 *		End of Class Method CEditUndoStack::CreateInsertString()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CEditUndoStack Method - void CreateDeleteChar (Char, StartSel, EndSel);
 *
 *=========================================================================*/
void CEditUndoStack::CreateDeleteChar (const TCHAR Char, const int StartSel, const int EndSel) {
  DEFINE_FUNCTION("CEditUndoStack::CreateDeleteChar()");
  CEditUndo* pUndo;

  CreatePointer(pUndo, CEditUndo);
  m_UndoStack.Add(pUndo);

  pUndo->SetChar(Char);
  pUndo->SetAction(EDITUNDO_DELETECHAR);
  pUndo->SetSelStart(StartSel);
  pUndo->SetSelEnd(EndSel);

  if (m_UndoStack.GetNumElements() > m_Limit) {
    m_UndoStack.DeleteElement(0);
  }
}
/*===========================================================================
 *		End of Class Method CEditUndoStack::CreateDeleteChar()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CEditUndoStack Method - void CreateDeleteString (pString, StartSel, EndSel);
 *
 *=========================================================================*/
void CEditUndoStack::CreateDeleteString (const TCHAR* pString, const int StartSel, const int EndSel) {
  DEFINE_FUNCTION("CEditUndoStack::CreateDeleteString()");
  CEditUndo* pUndo;

  CreatePointer(pUndo, CEditUndo);
  m_UndoStack.Add(pUndo);

  pUndo->SetString(pString);
  pUndo->SetAction(EDITUNDO_DELETESTRING);
  pUndo->SetSelStart(StartSel);
  pUndo->SetSelEnd(EndSel);

  if (m_UndoStack.GetNumElements() > m_Limit) {
    m_UndoStack.DeleteElement(0);
  }
}
/*===========================================================================
 *		End of Class Method CEditUndoStack::CreateDeleteString()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CEditUndoStack Method - void CreateEntireText (pString);
 *
 *=========================================================================*/
void CEditUndoStack::CreateEntireText (const TCHAR* pString) {
  DEFINE_FUNCTION("CEditUndoStack::CreateDeleteString()");
  CEditUndo* pUndo;

  CreatePointer(pUndo, CEditUndo);
  m_UndoStack.Add(pUndo);

  pUndo->SetString(pString);
  pUndo->SetAction(EDITUNDO_ENTIRETEXT);
  pUndo->SetSelStart(0);
  pUndo->SetSelEnd(0);

  if (m_UndoStack.GetNumElements() > m_Limit) {
    m_UndoStack.DeleteElement(0);
  }
}
/*===========================================================================
 *		End of Class Method CEditUndoStack::CreateEntireText()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CEditUndoStack Method - bool GroupUndoInsertChar (pCtrl);
 *
 *=========================================================================*/
bool CEditUndoStack::GroupUndoInsertChar (CRichEditCtrl* pCtrl, CEditUndo* pUndo) {
  DEFINE_FUNCTION("CEditUndoStack::GroupUndoInsertChar()");
  int SelStart;
  int SelEnd;

  do {
    SelStart = pUndo->GetSelStart();
    SelEnd   = pUndo->GetSelEnd();

    pCtrl->SetSel(pUndo->GetSelStart(), pUndo->GetSelStart()+1);
    pCtrl->ReplaceSel(_T(""));
    pCtrl->SetSel(pUndo->GetSelStart(), pUndo->GetSelEnd());
    DestroyPointer(pUndo);

    pUndo = m_UndoStack.GetAt(m_UndoStack.GetNumElements() - 1);
    if (pUndo == NULL) break;

    if (pUndo->GetAction() != EDITUNDO_INSERTCHAR) break;
    if (!__iscsym(pUndo->GetChar())) break;
    if (abs(pUndo->GetSelStart() - SelStart) >= 2) break;

    m_UndoStack.DeleteElement(m_UndoStack.GetNumElements() - 1, false);
  } while (pUndo != NULL);

  return (true);
}
/*===========================================================================
 *		End of Class Method CEditUndoStack::GroupUndoInsertChar()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CEditUndoStack Event - bool OnChar (pCtrl, CharCode);
 *
 *=========================================================================*/
bool CEditUndoStack::OnChar (CRichEditCtrl* pCtrl, const int CharCode) {
  CString Buffer;
  long    StartSel;
  long    EndSel;

	/* Ignore invalid input */
  if (pCtrl == NULL || CharCode == 0) return (false);

	/* Ignore if the Control or ALT keys are pressed */
  if (GetKeyState(VK_CONTROL) & 0xf000) return (false);
  if (GetKeyState(VK_MENU)    & 0xf000) return (false);

  switch (CharCode) {
    case VK_BACK:
    case VK_DELETE:
	break;
    case VK_RETURN:
        pCtrl->GetSel(StartSel, EndSel);

    	if (EndSel - StartSel >= 1) {
	  Buffer = pCtrl->GetSelText();
	  CreateDeleteString(Buffer, StartSel, EndSel);
	}

	CreateInsertString(_T("\r\n"), StartSel, StartSel);
	return (true);
    default:
	pCtrl->GetSel(StartSel, EndSel);

	if (EndSel - StartSel >= 1) {
	  Buffer = pCtrl->GetSelText();
	  CreateDeleteString(Buffer, StartSel, EndSel);
	}

	CreateInsertChar((TCHAR) CharCode, StartSel, StartSel);
	return (true);
  }

  return (false);
}
/*===========================================================================
 *		End of Class Event CEditUndoStack::OnChar()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CEditUndoStack Event - bool OnCut (pCtrl);
 *
 *=========================================================================*/
bool CEditUndoStack::OnCut (CRichEditCtrl* pCtrl) {
  CString Buffer;
  long    StartSel;
  long    EndSel;

	/* Ignore invalid input */
  if (pCtrl == NULL) return (false);
  pCtrl->GetSel(StartSel, EndSel);

  if (EndSel - StartSel >= 1) {
    Buffer = pCtrl->GetSelText();
    CreateDeleteString(Buffer, StartSel, EndSel);
    return (true);
  }

	/* Nothing to cut */
  return (false);
}
/*===========================================================================
 *		End of Class Event CEditUndoStack::OnCut()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CEditUndoStack Event - bool OnKeyDown (pCtrl, CharCode);
 *
 *=========================================================================*/
bool CEditUndoStack::OnKeyDown (CRichEditCtrl* pCtrl, const int CharCode) {
  CString Buffer;
  long    StartSel;
  long    EndSel;
  long    CurLine;
  long    LineStart;
  long    LineLength;
  int     CharIndex;
  int     Offset;

	/* Ignore invalid input */
  if (pCtrl == NULL || CharCode == 0) return (false);

	/* Ignore if the ALT key is pressed */
  if (GetKeyState(VK_MENU) & 0xf000) return (false);

  switch (CharCode) {
    case VK_BACK:
        Offset = -1;
	break;
    case VK_DELETE:
        Offset = 0;
	break;
    default:
        return (false);
  }
        
  pCtrl->GetSel(StartSel, EndSel);

  if (EndSel - StartSel >= 1) {
    Buffer = pCtrl->GetSelText();
    CreateDeleteString(Buffer, StartSel, EndSel);
    //return (true);
  }

  CurLine    = pCtrl->LineFromChar(-1);
  LineStart  = pCtrl->LineIndex(-1);
  LineLength = pCtrl->LineLength(CurLine);
  CharIndex  = StartSel - LineStart + Offset;
  if (CurLine < 0) return (false);

  pCtrl->GetLine(CurLine, Buffer.GetBuffer(LineLength + 8), LineLength + 2);
  Buffer.ReleaseBuffer(LineLength);

	/* Check for at very end or start */
  if (Offset  < 0 && CurLine == 0 && CharIndex < 0) return (false);
  if (Offset >= 0 && StartSel >= pCtrl->GetTextLength()) return (false);

  if (CharIndex < 0 || CharIndex + Offset >= LineLength)
    CreateDeleteString("\r\n", StartSel + Offset*2, EndSel);
  else if (CharIndex >= 0 && CharIndex < Buffer.GetLength()) 
    CreateDeleteChar(Buffer[CharIndex], StartSel + Offset, StartSel);

  return (true);
}
/*===========================================================================
 *		End of Class Event CEditUndoStack::OnKeyDown()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CEditUndoStack Event - bool OnPaste (pCtrl);
 *
 *=========================================================================*/
bool CEditUndoStack::OnPaste (CRichEditCtrl* pCtrl) {
  CString Buffer;
  long    StartSel;
  long    EndSel;

	/* Ignore invalid input */
  if (pCtrl == NULL) return (false);
  pCtrl->GetSel(StartSel, EndSel);

  if (EndSel - StartSel >= 1) {
    Buffer = pCtrl->GetSelText();
    CreateDeleteString(Buffer, StartSel, EndSel);
    //return (true);
  }

	/* Get the clipboard text to insert */
  if (!GetClipboardText(Buffer)) return (false);
  if (Buffer.IsEmpty()) return (false);

  CreateInsertString(Buffer, StartSel, StartSel);
  return (true);
}
/*===========================================================================
 *		End of Class Event CEditUndoStack::OnPaste()
 *=========================================================================*/

   
/*===========================================================================
 *
 * Class CEditUndoStack Event - int OnUndo (pCtrl);
 *
 *=========================================================================*/
int CEditUndoStack::OnUndo (CRichEditCtrl* pCtrl) {
  DEFINE_FUNCTION("CEditUndoStack::OnUndo()");
  CEditUndo* pUndo;
  CString    Buffer;
  int	     UndoType = EDITUNDO_NONE;

	/* Ignore invalid input */
  if (pCtrl == NULL) return (UndoType);

  pUndo = Pop();
  if (pUndo == NULL) return (UndoType);

  switch (pUndo->GetAction()) {
    case EDITUNDO_INSERTCHAR:
        if (m_GroupUndos) return GroupUndoInsertChar(pCtrl, pUndo);
        pCtrl->SetSel(pUndo->GetSelStart(), pUndo->GetSelStart()+1);
	pCtrl->ReplaceSel(_T(""));
	pCtrl->SetSel(pUndo->GetSelStart(), pUndo->GetSelEnd());
	UndoType = EDITUNDO_INSERTCHAR;
	break;
    case EDITUNDO_INSERTSTRING:
        pCtrl->SetSel(pUndo->GetSelStart(), pUndo->GetSelStart() + pUndo->GetStringLength());
	pCtrl->ReplaceSel(_T(""));
	pCtrl->SetSel(pUndo->GetSelStart(), pUndo->GetSelEnd());
	UndoType = EDITUNDO_INSERTSTRING;
	break;
    case EDITUNDO_DELETECHAR:
        pCtrl->SetSel(pUndo->GetSelStart(), pUndo->GetSelStart());
	Buffer = pUndo->GetChar();
	pCtrl->ReplaceSel(Buffer);
	pCtrl->SetSel(pUndo->GetSelEnd(), pUndo->GetSelEnd());
	UndoType = EDITUNDO_DELETECHAR;
	break;
    case EDITUNDO_DELETESTRING:
        pCtrl->SetSel(pUndo->GetSelStart(), pUndo->GetSelStart());
	pCtrl->ReplaceSel(pUndo->GetString());
	pCtrl->SetSel(pUndo->GetSelEnd(), pUndo->GetSelEnd());
	UndoType = EDITUNDO_DELETESTRING;
	break;
    case EDITUNDO_ENTIRETEXT: {
	long StartSel;
	long EndSel;
	pCtrl->HideSelection(TRUE, FALSE);
	pCtrl->SetRedraw(FALSE);

	pCtrl->GetSel(StartSel, EndSel);
	pCtrl->SetSel(0, -1);
	pCtrl->ReplaceSel(pUndo->GetString());
	pCtrl->SetSel(StartSel, EndSel);

	pCtrl->HideSelection(FALSE, FALSE);
	pCtrl->SetRedraw(TRUE);

	UndoType = EDITUNDO_ENTIRETEXT;
	break; }
  }

  pCtrl->HideSelection(FALSE, FALSE);
  DestroyPointer(pUndo);
  return (UndoType);
}
/*===========================================================================
 *		End of Class Event CEditUndoStack::OnUndo()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CEditUndoStack Method - CEditUndo* Pop (void);
 *
 *=========================================================================*/
CEditUndo* CEditUndoStack::Pop (void) {
  CEditUndo* pUndo;

  if (m_UndoStack.GetNumElements() == 0) return (NULL);

  pUndo = m_UndoStack.GetAt(m_UndoStack.GetNumElements() - 1);
  if (pUndo == NULL) return (NULL);

  m_UndoStack.DeleteElement(m_UndoStack.GetNumElements() - 1, false);
  return (pUndo);
}
/*===========================================================================
 *		End of Class Method CEditUndoStack::Pop()
 *=========================================================================*/

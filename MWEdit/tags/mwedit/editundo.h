/*===========================================================================
 *
 * File:	Editundo.H
 * Author:	Dave Humphrey (uesp@m0use.net)
 * Created On:	August 22, 2006
 *
 * Description
 *
 *=========================================================================*/
#ifndef __EDITUNDO_H
#define __EDITUNDO_H


/*===========================================================================
 *
 * Begin Required Includes
 *
 *=========================================================================*/
  #include "dl_err.h"
  #include "contain/temarray.h"
/*===========================================================================
 *		End of Required Includes
 *=========================================================================*/


/*===========================================================================
 *
 * Begin Definitions
 *
 *=========================================================================*/

	/* Types of undo actions */
  #define EDITUNDO_NONE		0
  #define EDITUNDO_INSERTCHAR	1
  #define EDITUNDO_INSERTSTRING	2
  #define EDITUNDO_DELETECHAR	3
  #define EDITUNDO_DELETESTRING	4
  #define EDITUNDO_ENTIRETEXT	5

	/* Default undo limit */
  #define EDITUNDO_DEFAULT_LIMIT 100

/*===========================================================================
 *		End of Definitions
 *=========================================================================*/


/*===========================================================================
 *
 * Begin Class CEditUndo Definition
 *
 * Defines a single undo action for an edit control.
 *
 *=========================================================================*/
class CEditUndo {

  /*---------- Begin Private Class Members ----------------------*/
private:
  int		m_Action;

  TCHAR		m_Char;
  TCHAR*	m_pString;
  dword		m_StringLength;
  int		m_SelStart;
  int		m_SelEnd;  


  /*---------- Begin Protected Class Methods --------------------*/
protected:


  /*---------- Begin Public Class Methods -----------------------*/
public:

	/* Class Constructors/Destructors */
  CEditUndo();
  virtual ~CEditUndo() { Destroy(); }
  virtual void Destroy (void);

	/* Get class members */
  int          GetAction       (void) { return (m_Action); }
  TCHAR        GetChar         (void) { return (m_Char); }
  const TCHAR* GetString       (void) { return (m_pString); }
  dword	       GetStringLength (void) { return (m_StringLength); }
  int	       GetSelStart     (void) { return (m_SelStart); }
  int	       GetSelEnd       (void) { return (m_SelEnd); }

	/* Set class members */
  void SetAction   (const int    Action)  { m_Action   = Action; }
  void SetChar     (const TCHAR  Char)    { m_Char     = Char; }
  void SetSelStart (const int    Value)   { m_SelStart = Value; }
  void SetSelEnd   (const int    Value)   { m_SelEnd   = Value; }
  void SetString   (const TCHAR* pString);

 };

	/* Array of undo actions */
   typedef TTemplateArray<CEditUndo> CEditUndoList;

/*===========================================================================
 *		End of Class CEditUndo Definition
 *=========================================================================*/


/*===========================================================================
 *
 * Begin Class CEditUndoStack Definition
 *
 * Description
 *
 *=========================================================================*/
class CEditUndoStack {

  /*---------- Begin Private Class Members ----------------------*/
private:
  CEditUndoList		m_UndoStack;

  bool			m_GroupUndos;
  int			m_Limit;


  /*---------- Begin Protected Class Methods --------------------*/
protected:

  bool GroupUndoInsertChar (CRichEditCtrl* pCtrl, CEditUndo* pUndo);


  /*---------- Begin Public Class Methods -----------------------*/
public:

	/* Class Constructors/Destructors */
  CEditUndoStack();
  virtual ~CEditUndoStack() { Destroy(); }
  virtual void Destroy (void);

	/* Create undo actions */
  void CreateInsertChar   (const TCHAR Char, const int StartSel, const int EndSel);
  void CreateInsertString (const TCHAR* pString, const int StartSel, const int EndSel);
  void CreateDeleteChar   (const TCHAR Char, const int StartSel, const int EndSel);
  void CreateDeleteString (const TCHAR* pString, const int StartSel, const int EndSel);
  void CreateEntireText   (const TCHAR* pString);

	/* Get class members */
  dword GetSize  (void) const { return m_UndoStack.GetNumElements(); }
  dword GetLimit (void) const { return (m_Limit); }

	/* Checks if the stack is empty or not */
  bool IsEmpty (void) const { return (m_UndoStack.GetNumElements() == 0); }

	/* Helper handler functions */
  bool OnChar    (CRichEditCtrl* pCtrl, const int CharCode);
  bool OnKeyDown (CRichEditCtrl* pCtrl, const int CharCode);
  int  OnUndo    (CRichEditCtrl* pCtrl);
  bool OnPaste   (CRichEditCtrl* pCtrl);
  bool OnCut     (CRichEditCtrl* pCtrl);

	/* Push a new undo action to the top of the stack */
  void Push (CEditUndo* pUndo) { m_UndoStack.Add(pUndo); }

  	/* Remove an undo action from the top of the stack */
  CEditUndo* Pop (void);

	/* Set class members */
  void SetGroupUndos (const bool   Flag) { m_GroupUndos = Flag; }
  void SetLimit      (const dword Value) { m_Limit      = Value; }

 };
/*===========================================================================
 *		End of Class CEditUndoStack Definition
 *=========================================================================*/



#endif
/*===========================================================================
 *		End of File Editundo.H
 *=========================================================================*/

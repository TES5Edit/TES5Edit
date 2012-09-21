/*===========================================================================
 *
 * File:		Srundoitem.H
 * Author:		Dave Humphrey (dave@uesp.net)
 * Created On:	26 November 2011
 *
 * Description
 *
 *=========================================================================*/
#ifndef __SRUNDOITEM_H
#define __SRUNDOITEM_H


/*===========================================================================
 *
 * Begin Required Includes
 *
 *=========================================================================*/
  #include "srrecordhandler.h"
  #include "records/srrecord.h"
/*===========================================================================
 *		End of Required Includes
 *=========================================================================*/


/*===========================================================================
 *
 * Begin Definitions
 *
 *=========================================================================*/

	/* Undo types */
  #define SR_UNDOTYPE_NONE		0
  #define SR_UNDOTYPE_ADDRECORD		1
  #define SR_UNDOTYPE_UPDATERECORD	2
  #define SR_UNDOTYPE_CLEANRECORD	3

	/* Undo options */
  struct srundooptions_t
  {
	bool	EnableUndo;	/* Enable undo operations to be saved */
	dword	UndoLimit;	/* Number of undo operations to save */

	srundooptions_t() 
	{
		EnableUndo = true;
		UndoLimit  = 50;
	}
  };

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
 * Begin Class CSrUndoItem Definition
 *
 * Holds a single undo item definition.
 *
 *=========================================================================*/
class CSrUndoItem {

  /*---------- Begin Protected Class Members --------------------*/
protected:
  CSrRecord*	m_pRecordCopy;		/* Copy of the record updated */
  int			m_ActionType;		/* Type of action that was performed */

  CSString		m_NewEditorID;		/* The new editorid if changed */
  bool			m_IsCopy;			/* Copied from a previous version */
  bool			m_IsRenamed;		/* Renamed from a previous version */
  srformid_t	m_NewFormID;		/* Used for copied records */


  /*---------- Begin Protected Class Methods --------------------*/
protected:


  /*---------- Begin Public Class Methods -----------------------*/
public:

	/* Class Constructors/Destructors */
  CSrUndoItem();
  virtual ~CSrUndoItem() { Destroy(); }
  virtual void Destroy (void);

	/* Create a copy of the given record */
  CSrRecord* CopyRecord (CSrRecord* pRecord);

  	/* Set undo information based on the given edit information */
  bool CreateUndoInfo (sreditrecinfo_t& EditInfo);

	/* Get class members */
  CSrRecord*    GetRecord		(void) { return (m_pRecordCopy); }
  int           GetActionType	(void) { return (m_ActionType); }
  const SSCHAR* GetNewEditorID	(void) { return (m_NewEditorID); }
  bool			HasNewEditorID	(void) { return (!m_NewEditorID.IsEmpty()); }
  bool			IsCopy			(void) { return (m_IsCopy); }
  bool			IsRenamed		(void) { return (m_IsRenamed); }
  srformid_t    GetNewFormID    (void) { return (m_NewFormID); }

	/* Gets a string representation of the undo item */
  const char* MakeString (CSString& Buffer);

	/* Set class members */
  void SetRecord      (CSrRecord*      pRecord) { m_pRecordCopy = pRecord; }
  void SetActionType  (const int          Type) { m_ActionType  = Type; }
  void SetNewEditorID (const SSCHAR*   pString) { m_NewEditorID = pString; }
  void SetIsCopy      (const bool         Flag) { m_IsCopy      = Flag; }
  void SetIsRenamed   (const bool         Flag) { m_IsRenamed   = Flag; }
  void SetNewFormID   (const srformid_t FormID) { m_NewFormID   = FormID; }

};

	/* Arrays of items */
  typedef CSrPtrArray<CSrUndoItem>    CSrUndoItemArray;
  typedef CSrRefPtrArray<CSrUndoItem> CSrRefUndoItemArray;

/*===========================================================================
 *		End of Class CSrUndoItem Definition
 *=========================================================================*/


#endif
/*===========================================================================
 *		End of File Srundoitem.H
 *=========================================================================*/

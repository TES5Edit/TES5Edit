/*===========================================================================
 *
 * File:		Srundoitem.CPP
 * Author:		Dave Humphrey (dave@uesp.net)
 * Created On:	26 November 2011
 *
 * Description
 *
 *=========================================================================*/

	/* Include Files */
#include "srundoitem.h"


/*===========================================================================
 *
 * Class CSrUndoItem Constructor
 *
 *=========================================================================*/
CSrUndoItem::CSrUndoItem ()
{
  m_pRecordCopy = NULL;
  m_ActionType  = SR_UNDOTYPE_NONE;
  m_IsCopy      = false;
  m_IsRenamed   = false;
  m_NewFormID   = 0;
}
/*===========================================================================
 *		End of Class CSrUndoItem Constructor
 *=========================================================================*/


/*===========================================================================
 *
 * Class CSrUndoItem Method - void Destroy (void);
 *
 *=========================================================================*/
void CSrUndoItem::Destroy (void)
{

  if (m_pRecordCopy != NULL)
  {
    delete m_pRecordCopy;
    m_pRecordCopy = NULL;
  }

  m_ActionType  = SR_UNDOTYPE_NONE;
  m_IsCopy      = false;
  m_IsRenamed   = false;
  m_NewFormID   = 0;

  m_NewEditorID.Empty();
}
/*===========================================================================
 *		End of Class Method CSrUndoItem::Destroy()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CSrUndoItem Method - CSrRecord* CopyRecord (pRecord);
 *
 * Create a copy of the given record. Returns the new copy or NULL on any
 * error.
 *
 *=========================================================================*/
CSrRecord* CSrUndoItem::CopyRecord (CSrRecord* pRecord) {

	/* Delete the current record if any */
  if (m_pRecordCopy != NULL) {
    delete m_pRecordCopy;
    m_pRecordCopy = NULL;
  }

	/* Ignore invalid niput */
  if (pRecord == NULL) return (NULL);

	/* Create the record copy */ 
  m_pRecordCopy = CreateSrRecord(pRecord->GetRecordType());
  if (m_pRecordCopy == NULL) return (NULL);
  m_pRecordCopy->Copy(pRecord);

  return (m_pRecordCopy);
}
/*===========================================================================
 *		End of Class Method CSrUndoItem::CopyRecord()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CSrUndoItem Method - bool CreateUndoInfo (EditInfo);
 *
 *=========================================================================*/
bool CSrUndoItem::CreateUndoInfo (sreditrecinfo_t& EditInfo) 
{

	/* Clear the current information */
  Destroy();

  EditInfo.pRecordCopy = CopyRecord(EditInfo.pOldRecord);

  m_NewEditorID = EditInfo.NewEditorID;
  m_IsCopy      = EditInfo.IsCopy;
  m_IsRenamed   = EditInfo.IsRenamed;
  m_ActionType  = SR_UNDOTYPE_NONE;
  if (EditInfo.pNewRecord != NULL) m_NewFormID = EditInfo.pNewRecord->GetFormID();

  return (true);
}
/*===========================================================================
 *		End of Class Method CSrUndoItem::CreateUndoInfo()
 *=========================================================================*/


/*===========================================================================
 *
 * Class char* CSrUndoItem Method - const MakeString (Buffer);
 *
 *=========================================================================*/
const char* CSrUndoItem::MakeString (CSString& Buffer)
{
  srformid_t OldFormID = 0;
  CSString   OldEditorID;

  if (m_pRecordCopy != NULL) {
    OldFormID = m_pRecordCopy->GetFormID();
    m_pRecordCopy->GetField(OldEditorID, SR_FIELD_EDITORID);
  }

  switch (m_ActionType) {
    case SR_UNDOTYPE_ADDRECORD:
		Buffer.Format("New %s (%X)", m_NewEditorID, OldFormID);
		break;
    case SR_UNDOTYPE_CLEANRECORD:
        Buffer.Format("Clean %s (%X)", OldEditorID, OldFormID);
		break;
    case SR_UNDOTYPE_UPDATERECORD:
        if (m_IsCopy)
			Buffer.Format("Update %s (%X), copy of %s (%X)", m_NewEditorID, m_NewFormID, OldEditorID, OldFormID);
		else if (m_IsRenamed)
			Buffer.Format("Update %s (%X), renamed %s", m_NewEditorID, OldFormID, OldEditorID);
		else
			Buffer.Format("Update %s (%X)", OldEditorID, OldFormID);

		break;
    default:
        Buffer.Format("Unknown");
		break;
  }

  return (Buffer);
}
/*===========================================================================
 *		End of Class Method char* CSrUndoItem::MakeString()
 *=========================================================================*/


/*===========================================================================
 *
 * File:		Sritem1record.CPP
 * Author:		Dave Humphrey (dave@uesp.net)
 * Created On:	26 November 2011
 *
 * Implements the CSrItem1Record class for inventory type records with:
 *
 *	FULL - Item Name
 *	MODL - Model filename
 *	ICON - Icon filename
 *
 *=========================================================================*/

	/* Include Files */
#include "sritem1record.h"
#include "../srrecordhandler.h"

	
/*===========================================================================
 *
 * Begin Subrecord Creation Array
 *
 *=========================================================================*/
BEGIN_SRSUBRECCREATE(CSrItem1Record, CSrIdKeyRecord)
	DEFINE_SRSUBRECCREATE(SR_NAME_FULL, CSrLStringSubrecord::Create)
	DEFINE_SRSUBRECCREATE(SR_NAME_MODL, CSrModlSubrecord::Create)
	DEFINE_SRSUBRECCREATE(SR_NAME_ICON, CSrIconSubrecord::Create)
END_SRSUBRECCREATE()
/*===========================================================================
 *		End of Subrecord Creation Array
 *=========================================================================*/


/*===========================================================================
 *
 * Begin CObRecord Field Map
 *
 *=========================================================================*/
BEGIN_SRFIELDMAP(CSrItem1Record, CSrIdKeyRecord)
	ADD_SRFIELDALL("ItemName",  SR_FIELD_ITEMNAME, 0, CSrItem1Record, FieldItemName)
	ADD_SRFIELDALL("Model",     SR_FIELD_MODEL,    0, CSrItem1Record, FieldModel)
	ADD_SRFIELDALL("Icon",      SR_FIELD_ICON,     0, CSrItem1Record, FieldIcon)
END_SRFIELDMAP()
/*===========================================================================
 *		End of CObRecord Field Map
 *=========================================================================*/


/*===========================================================================
 *
 * Class CSrItem1Record Constructor
 *
 *=========================================================================*/
CSrItem1Record::CSrItem1Record () 
{
  m_pItemName   = NULL;
  m_pModel      = NULL;
  m_pIcon       = NULL;
}
/*===========================================================================
 *		End of Class CSrItem1Record Constructor
 *=========================================================================*/


/*===========================================================================
 *
 * Class CSrItem1Record Method - void Destroy (void);
 *
 *=========================================================================*/
void CSrItem1Record::Destroy (void) 
{
  m_pItemName = NULL;
  
  CSrIdKeyRecord::Destroy();
}
/*===========================================================================
 *		End of Class Method CSrItem1Record::Destroy()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CSrItem1Record Method - void InitializeNew (void);
 *
 *=========================================================================*/
void CSrItem1Record::InitializeNew (void) 
{

	/* Call the base class method first */
  CSrIdKeyRecord::InitializeNew();

	/* Create a new item name subrecords if required */
  if (HasFullItemName()) 
  {
    AddNewSubrecord(SR_NAME_FULL);
    if (m_pItemName != NULL) m_pItemName->InitializeNew();
  }

}
/*===========================================================================
 *		End of Class Method CSrItem1Record::InitializeNew()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CSrItem1Record Event - void OnAddSubrecord (pSubrecord);
 *
 *=========================================================================*/
void CSrItem1Record::OnAddSubrecord (CSrSubrecord* pSubrecord) 
{

  if (pSubrecord->GetRecordType() == SR_NAME_FULL)
    m_pItemName = SrCastClass(CSrLStringSubrecord, pSubrecord);
  else if (pSubrecord->GetRecordType() == SR_NAME_MODL)
    m_pModel = SrCastClass(CSrModlSubrecord, pSubrecord);
  else if (pSubrecord->GetRecordType() == SR_NAME_ICON)
    m_pIcon = SrCastClass(CSrIconSubrecord, pSubrecord);
  else
    CSrIdKeyRecord::OnAddSubrecord(pSubrecord);

}
/*===========================================================================
 *		End of Class Event CSrItem1Record::OnAddSubRecord()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CSrItem1Record Event - void OnDeleteSubrecord (pSubrecord);
 *
 *=========================================================================*/
void CSrItem1Record::OnDeleteSubrecord (CSrSubrecord* pSubrecord) 
{

  if (m_pItemName == pSubrecord)
    m_pItemName = NULL;
  else if (m_pModel == pSubrecord)
    m_pModel = NULL;
  else if (m_pIcon == pSubrecord)
    m_pIcon = NULL;
  else
    CSrIdKeyRecord::OnDeleteSubrecord(pSubrecord);

}
/*===========================================================================
 *		End of Class Event CSrItem1Record::OnDeleteSubrecord()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CSrItem1Record Method - void SetItemName (pString);
 *
 *=========================================================================*/
void CSrItem1Record::SetItemName (const SSCHAR* pString) 
{

  if (m_pItemName == NULL) 
  {
     AddNewSubrecord(SR_NAME_FULL);
     if (m_pItemName == NULL) return;
     m_pItemName->InitializeNew();
  }

  m_pItemName->SetString(pString);
}
/*===========================================================================
 *		End of Class Method CSrItem1Record::SetItemName()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CSrItem1Record Method - void SetModel (pString);
 *
 *=========================================================================*/
void CSrItem1Record::SetModel (const SSCHAR* pString) 
{

  if (m_pModel == NULL) 
  {
     AddNewSubrecord(SR_NAME_MODL);
     if (m_pModel == NULL) return;
     m_pModel->InitializeNew();
  }

  m_pModel->SetString(pString);
}
/*===========================================================================
 *		End of Class Method CSrItem1Record::SetModel()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CSrItem1Record Method - void SetIcon (pString);
 *
 *=========================================================================*/
void CSrItem1Record::SetIcon (const SSCHAR* pString) 
{

  if (m_pIcon == NULL) 
  {
     AddNewSubrecord(SR_NAME_ICON);
     if (m_pIcon == NULL) return;
     m_pIcon->InitializeNew();
  }

  m_pIcon->SetString(pString);
}
/*===========================================================================
 *		End of Class Method CSrItem1Record::SetIcon()
 *=========================================================================*/


/*===========================================================================
 *
 * Begin CSrItem1Record Get Field Methods
 *
 *=========================================================================*/
DEFINE_SRGETFIELD(CSrItem1Record::GetFieldItemName, String.Format("%s", GetItemName()))
DEFINE_SRGETFIELD(CSrItem1Record::GetFieldModel,    String.Format("%s", GetModel()))
DEFINE_SRGETFIELD(CSrItem1Record::GetFieldIcon,     String.Format("%s", GetIcon()))
/*===========================================================================
 *		End of CSrItem1Record Get Field Methods
 *=========================================================================*/


/*===========================================================================
 *
 * Begin CSrItem1Record Compare Field Methods
 *
 *=========================================================================*/
DEFINE_SRCOMPFIELDSTRING(CSrItem1Record, CompareFieldItemName, GetItemName)
DEFINE_SRCOMPFIELDSTRING(CSrItem1Record, CompareFieldModel, GetModel)
DEFINE_SRCOMPFIELDSTRING(CSrItem1Record, CompareFieldIcon, GetIcon)
/*===========================================================================
 *		End of CSrItem1Record Compare Field Methods
 *=========================================================================*/


/*===========================================================================
 *
 * Begin CSrItem1Record Set Field Methods
 *
 *=========================================================================*/
BEGIN_SRSETFIELD(CSrItem1Record::SetFieldItemName)
  SetItemName(pString);
END_SRSETFIELD()


BEGIN_SRSETFIELD(CSrItem1Record::SetFieldModel)
  SetModel(pString);
END_SRSETFIELD()


BEGIN_SRSETFIELD(CSrItem1Record::SetFieldIcon)
  SetIcon(pString);
END_SRSETFIELD()
/*===========================================================================
 *		End of CSrItem1Record Set Field Methods
 *=========================================================================*/

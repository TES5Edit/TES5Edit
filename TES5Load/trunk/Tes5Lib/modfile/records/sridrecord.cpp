/*===========================================================================
 *
 * File:		Sridrecord.CPP
 * Author:		Dave Humphrey (dave@uesp.net)
 * Created On:	26 November 2011
 *
 * Description
 *
 *=========================================================================*/

	/* Include Files */
#include "sridrecord.h"
#include "../srrecordhandler.h"


/*===========================================================================
 *
 * Begin Subrecord Creation Array
 *
 *=========================================================================*/
BEGIN_SRSUBRECCREATE(CSrIdRecord, CSrRecord)
	DEFINE_SRSUBRECCREATE(SR_NAME_EDID, CSrStringSubrecord::Create)
	DEFINE_SRSUBRECCREATE(SR_NAME_OBND, CSrBoundsSubrecord::Create)
END_SRSUBRECCREATE()
/*===========================================================================
 *		End of Subrecord Creation Array
 *=========================================================================*/


/*===========================================================================
 *
 * Begin CSrIdRecord Field Map
 *
 *=========================================================================*/
BEGIN_SRFIELDMAP(CSrIdRecord, CSrRecord)
	ADD_SRFIELDALL("EditorID",		SR_FIELD_EDITORID,		SRRF_ALNUM,		 CSrIdRecord, FieldEditorID)
	ADD_SRFIELDALL("Bounds",		SR_FIELD_BOUNDS,		0,				 CSrIdRecord, FieldBounds)
END_SRFIELDMAP()
/*===========================================================================
 *		End of CSrIdRecord Field Map
 *=========================================================================*/


/*===========================================================================
 *
 * Class CSrIdRecord Constructor
 *
 *=========================================================================*/
CSrIdRecord::CSrIdRecord () :
	m_pEditorID(NULL)
{
	m_pBounds = NULL;
}
/*===========================================================================
 *		End of Class CSrIdRecord Constructor
 *=========================================================================*/


/*===========================================================================
 *
 * Class CSrIdRecord Method - void Destroy (void);
 *
 *=========================================================================*/
void CSrIdRecord::Destroy (void) 
{
	m_pEditorID = NULL;
	m_pBounds = NULL;
  
	CSrRecord::Destroy();
}
/*===========================================================================
 *		End of Class Method CSrIdRecord::Destroy()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CSrIdRecord Method - void InitializeNew (void);
 *
 *=========================================================================*/
void CSrIdRecord::InitializeNew (void) 
{
	CSrRecord::InitializeNew();

	AddNewSubrecord(SR_NAME_EDID);
	if (m_pEditorID != NULL) m_pEditorID->InitializeNew(); 
}
/*===========================================================================
 *		End of Class Method CSrIdRecord::InitializeNew()
 *=========================================================================*/

  
/*===========================================================================
 *
 * Class CSrIdRecord Event - void OnAddSubrecord (pSubRecord);
 *
 *=========================================================================*/
void CSrIdRecord::OnAddSubrecord (CSrSubrecord* pSubrecord) {

	if (pSubrecord->GetRecordType() == SR_NAME_EDID)
	{
	    m_pEditorID = SrCastClass(CSrStringSubrecord, pSubrecord);
	}
	else if (pSubrecord->GetRecordType() == SR_NAME_OBND)
	{
	    m_pBounds = SrCastClass(CSrBoundsSubrecord, pSubrecord);
	}
	else
	{
		CSrRecord::OnAddSubrecord(pSubrecord);
	}
  
 }
/*===========================================================================
 *		End of Class Event CSrIdRecord::OnAddSubrecord()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CSrIdRecord Event - void OnDeleteSubrecord (pSubrecord);
 *
 *=========================================================================*/
void CSrIdRecord::OnDeleteSubrecord (CSrSubrecord* pSubrecord) 
{

	if (m_pEditorID == pSubrecord)
		m_pEditorID = NULL;
	else if (m_pBounds == pSubrecord)
		m_pBounds = NULL;
	else
		CSrRecord::OnDeleteSubrecord(pSubrecord);

}
/*===========================================================================
 *		End of Class Event CSrIdRecord::OnDeleteSubrecord()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CSrIdRecord Method - void SetEditorID (pString);
 *
 *=========================================================================*/
void CSrIdRecord::SetEditorID (const SSCHAR* pString) 
{

	if (m_pEditorID == NULL) 
	{
		AddNewSubrecord(SR_NAME_EDID);
		if (m_pEditorID == NULL) return;
	}

	m_pEditorID->SetString(pString);
}
/*===========================================================================
 *		End of Class Method CSrIdRecord::SetEditorID()
 *=========================================================================*/


 void CSrIdRecord::SetBoundsData (const srboundsdata_t Data)
 {
	 if (m_pBounds == NULL)
	 {
		 AddNewSubrecord(SR_NAME_OBND);
		 if (m_pBounds != NULL) m_pBounds->InitializeNew();
	 }

	 m_pBounds->GetBoundsData() = Data;
 }


/*===========================================================================
 *
 * Begin CSrIdRecord Get Field Methods
 *
 *=========================================================================*/
BEGIN_SRGETFIELD(CSrIdRecord::GetFieldEditorID)
	const SSCHAR* pString = GetEditorID();
	if (pString != NULL) String.Format("%s", pString);
END_SRSETFIELD()


BEGIN_SRGETFIELD(CSrIdRecord::GetFieldBounds)
	String.Empty();
	if (m_pBounds == NULL) return true;

	String.Format("(%hd, %hd, %hd) (%hd, %hd, %hd)", 
			m_pBounds->GetBoundsData().X1, m_pBounds->GetBoundsData().Y1, m_pBounds->GetBoundsData().Z1, 
			m_pBounds->GetBoundsData().X2, m_pBounds->GetBoundsData().Y2, m_pBounds->GetBoundsData().Z2);

END_SRSETFIELD()
/*===========================================================================
 *		End of CSrEnchRecord Get Field Methods
 *=========================================================================*/


/*===========================================================================
 *
 * Begin CSrIdRecord Compare Field Methods
 *
 *=========================================================================*/
DEFINE_SRCOMPFIELDSTRING(CSrIdRecord, CompareFieldEditorID, GetEditorID)


BEGIN_SRCOMPFIELD(CSrIdRecord::CompareFieldBounds)
	CSrIdRecord* pRecord1 = SrCastClassNull(CSrIdRecord, pRecord);
	if (pRecord1 == NULL) return 1;

	if (m_pBounds == NULL) 
	{
		if (pRecord1->m_pBounds == NULL) return 0;
		return -1;
	}
	else if (pRecord1->m_pBounds == NULL)
		return 1;

	srboundsdata_t& Data1 = m_pBounds->GetBoundsData();
	srboundsdata_t& Data2 = pRecord1->m_pBounds->GetBoundsData();

	if (Data1.X1 < Data2.X1) return -1;
	if (Data1.X1 > Data2.X1) return  1;

	if (Data1.Y1 < Data2.Y1) return -1;
	if (Data1.Y1 > Data2.Y1) return  1;

	if (Data1.Z1 < Data2.Z1) return -1;
	if (Data1.Z1 > Data2.Z1) return  1;

	if (Data1.X2 < Data2.X2) return -1;
	if (Data1.X2 > Data2.X2) return  1;

	if (Data1.Y2 < Data2.Y2) return -1;
	if (Data1.Y2 > Data2.Y2) return  1;

	if (Data1.Z2 < Data2.Z2) return -1;
	if (Data1.Z2 > Data2.Z2) return  1;

	return 0;
END_SRCOMPFIELD()
/*===========================================================================
 *		End of CSrIdRecord Compare Field Methods
 *=========================================================================*/


/*===========================================================================
 *
 * Begin CSrIdRecord Set Field Methods
 *
 *=========================================================================*/
BEGIN_SRSETFIELD(CSrIdRecord::SetFieldEditorID)
	AddSrGeneralError("Cannot set the editorID of a record from its SetField method!");
	return false;
END_SRSETFIELD()


BEGIN_SRSETFIELD(CSrIdRecord::SetFieldBounds)
	CSString Buffer(pString);

		/* Change all non-digits or (-+) into spaces */
	for (int i = 0; i < Buffer.GetLength(); ++i)
	{
		if (!isdigit(Buffer[i]) && Buffer[i] != '-' && Buffer[i] != '+') Buffer.SetAt(i, ' ');
	}

	Buffer.Trim();

	if (Buffer.IsEmpty())
	{
		DeleteSubrecords(SR_NAME_OBND);
		m_pBounds = NULL;
		return true;
	}

	CSStringArray SplitStrings;
	int Count = SplitString(SplitStrings, Buffer, ' ', true);

	srboundsdata_t Data = { 0, 0, 0, 0, 0, 0 };
	if (SplitStrings.GetSize() > 0) ::SrFieldConvertShort(SplitStrings[0]->c_str(), Data.X1);
	if (SplitStrings.GetSize() > 1) ::SrFieldConvertShort(SplitStrings[1]->c_str(), Data.Y1);
	if (SplitStrings.GetSize() > 2) ::SrFieldConvertShort(SplitStrings[2]->c_str(), Data.Z1);
	if (SplitStrings.GetSize() > 3) ::SrFieldConvertShort(SplitStrings[3]->c_str(), Data.X2);
	if (SplitStrings.GetSize() > 4) ::SrFieldConvertShort(SplitStrings[4]->c_str(), Data.Y2);
	if (SplitStrings.GetSize() > 5) ::SrFieldConvertShort(SplitStrings[5]->c_str(), Data.Z2);

	SetBoundsData(Data);
  
END_SRSETFIELD()
/*===========================================================================
 *		End of CSrIdRecord Set Field Methods
 *=========================================================================*/

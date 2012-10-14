/*===========================================================================
 *
 * File:		SrPerkDataSubrecord.CPP
 * Author:		Dave Humphrey (dave@uesp.net)
 * Created On:	3 January 2012
 *
 * Description
 *
 *=========================================================================*/

	/* Include Files */
#include "srperkdatasubrecord.h"


bool CSrPerkDataSubrecord::Copy (CSrSubrecord* pSubrecord) 
{
	CSrPerkDataSubrecord* pSubrecord1 = SrCastClassNull(CSrPerkDataSubrecord, pSubrecord);
	m_RecordSize = pSubrecord->GetRecordSize();

	if (pSubrecord1 != NULL) 
	{
		m_DataType = pSubrecord1->GetPerkDataType();
		m_Data     = pSubrecord1->GetPerkData();
		m_Data00   = pSubrecord1->GetPerkData00();
		m_Data01   = pSubrecord1->GetPerkData01();
		m_Data02   = pSubrecord1->GetPerkData02();
	}
	else 
	{
		memset(&m_Data,   0, sizeof(m_Data));
		memset(&m_Data00, 0, sizeof(m_Data00)); 
		memset(&m_Data01, 0, sizeof(m_Data01)); 
		memset(&m_Data02, 0, sizeof(m_Data02)); 
	}

	return (true);
}


dword CSrPerkDataSubrecord::ChangeFormID (const srformid_t NewID, const srformid_t OldID) 
{ 
	switch (m_DataType)
	{
		case SR_PERKDATA_TYPE00:
			if (m_Data00.QuestID == OldID)
			{
				m_Data00.QuestID = NewID;
				return 1;
			}
			break;
		case SR_PERKDATA_TYPE01:
			if (m_Data01.RecordID == OldID)
			{
				m_Data01.RecordID = NewID;
				return 1;
			}
			break;
	}
	
	return 0; 
}


dword CSrPerkDataSubrecord::CountUses (const srformid_t FormID) 
{
	switch (m_DataType)
	{
		case SR_PERKDATA_TYPE00:
			if (m_Data00.QuestID == FormID) return 1;
			break;
		case SR_PERKDATA_TYPE01:
			if (m_Data01.RecordID == FormID) return 1;
			break;
	}

	return 0;
}


bool CSrPerkDataSubrecord::FixupFormID (CSrFormidFixupArray& FixupArray) 
{
	switch (m_DataType)
	{
		case SR_PERKDATA_TYPE00: return SrFixupFormid(m_Data00.QuestID,  m_Data00.QuestID,  FixupArray);
		case SR_PERKDATA_TYPE01: return SrFixupFormid(m_Data01.RecordID, m_Data01.RecordID, FixupArray);
	}

	return true;
}


byte* CSrPerkDataSubrecord::GetData (void) 
{ 
	switch (m_DataType)
	{
		case SR_PERKDATA_TYPE00   : return (byte *)(&m_Data00); 
		case SR_PERKDATA_TYPE01	  : return (byte *)(&m_Data01); 
		case SR_PERKDATA_TYPE02	  : return (byte *)(&m_Data02); 
		case SR_PERKDATA_TYPEBASE : return (byte *)(&m_Data); 
	}
	return (byte *)(&m_Data); 
}


dword CSrPerkDataSubrecord:: GetRecordSize (void) const
{ 
	switch (m_DataType)
	{
		case SR_PERKDATA_TYPE00   : return SR_PERKDATA00_SUBRECORD_SIZE; 
		case SR_PERKDATA_TYPE01	  : return SR_PERKDATA01_SUBRECORD_SIZE;
		case SR_PERKDATA_TYPE02	  : return SR_PERKDATA02_SUBRECORD_SIZE;
		case SR_PERKDATA_TYPEBASE : return SR_PERKDATA_SUBRECORD_SIZE;
	}

	return m_RecordSize;
}


void CSrPerkDataSubrecord::InitializeNew (void) 
{ 
	CSrSubrecord::InitializeNew(); 

	m_DataType   = SR_PERKDATA_TYPEBASE;
	m_RecordSize = SR_PERKDATA_SUBRECORD_SIZE; 

	memset(&m_Data,   0, sizeof(m_Data)); 
	memset(&m_Data00, 0, sizeof(m_Data00)); 
	memset(&m_Data01, 0, sizeof(m_Data01)); 
	memset(&m_Data02, 0, sizeof(m_Data02)); 
}
   

bool CSrPerkDataSubrecord::ReadData  (CSrFile& File) 
{ 
	switch (m_RecordSize)
	{
		case SR_PERKDATA_SUBRECORD_SIZE:	m_DataType = SR_PERKDATA_TYPEBASE; return File.Read(&m_Data,   SR_PERKDATA_SUBRECORD_SIZE); 
		case SR_PERKDATA00_SUBRECORD_SIZE:	m_DataType = SR_PERKDATA_TYPE00;   return File.Read(&m_Data00, SR_PERKDATA00_SUBRECORD_SIZE); 
		case SR_PERKDATA01_SUBRECORD_SIZE:	m_DataType = SR_PERKDATA_TYPE01;   return File.Read(&m_Data01, SR_PERKDATA01_SUBRECORD_SIZE); 
		case SR_PERKDATA02_SUBRECORD_SIZE:	m_DataType = SR_PERKDATA_TYPE02;   return File.Read(&m_Data02, SR_PERKDATA02_SUBRECORD_SIZE); 
	}

	return AddSrGeneralError("%08X: Unknown PERK data size %d!", File.Tell(), m_RecordSize);
}

bool CSrPerkDataSubrecord::WriteData (CSrFile& File) 
{ 

	switch (m_DataType)
	{
		case SR_PERKDATA_TYPE00   : return File.Write(&m_Data00, SR_PERKDATA00_SUBRECORD_SIZE); 
		case SR_PERKDATA_TYPE01	  : return File.Write(&m_Data01, SR_PERKDATA01_SUBRECORD_SIZE); 
		case SR_PERKDATA_TYPE02	  : return File.Write(&m_Data02, SR_PERKDATA02_SUBRECORD_SIZE); 
		case SR_PERKDATA_TYPEBASE : return File.Write(&m_Data,   SR_PERKDATA_SUBRECORD_SIZE); 
	}

	return AddSrGeneralError("Unknown PERK data type %d!", m_DataType);
}
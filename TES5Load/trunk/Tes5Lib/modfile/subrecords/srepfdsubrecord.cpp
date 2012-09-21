/*===========================================================================
 *
 * File:		SrEpfdSubrecord.CPP
 * Author:		Dave Humphrey (dave@uesp.net)
 * Created On:	3 January 2012
 *
 * Description
 *
 *=========================================================================*/

	/* Include Files */
#include "srepfdsubrecord.h"
#include "../srrecordhandler.h"
#include "strings/srstringfile.h"


const srperkfuncinfo_t g_SrPerkFunctionInfos[17] =
{
	{ 0x00, 0x00 },  //Empty placeholder
	{ SRPERK_EFFECT_FUNCTION_SETVALUE,				0x01 },
	{ SRPERK_EFFECT_FUNCTION_ADDVALUE,				0x01 },
	{ SRPERK_EFFECT_FUNCTION_MULTVALUE,				0x01 },
	{ SRPERK_EFFECT_FUNCTION_ADDRANGEVALUE,			0x02 },
	{ SRPERK_EFFECT_FUNCTION_AVADDMULTVALUE,		0x02 },
	{ SRPERK_EFFECT_FUNCTION_ABSVALUE,				0x00 },
	{ SRPERK_EFFECT_FUNCTION_NEGABSVALUE,			0x00 },
	{ SRPERK_EFFECT_FUNCTION_ADDLEVELLIST,			0x03 },
	{ SRPERK_EFFECT_FUNCTION_ACTIVATE,				0x04 },
	{ SRPERK_EFFECT_FUNCTION_ADDSPELL,				0x05 },
	{ SRPERK_EFFECT_FUNCTION_SETGMST,				0x06 },
	{ SRPERK_EFFECT_FUNCTION_AVMULTVALUE,			0x02 },
	{ SRPERK_EFFECT_FUNCTION_AVMULTMULTVALUE,		0x02 },
	{ SRPERK_EFFECT_FUNCTION_AVADDMULTMULTVALUE,	0x02 },
	{ SRPERK_EFFECT_FUNCTION_SETTEXT,				0x07 },
	{ 0xFF, 0xFF }	//Unused placeholder
};


const srperkfuncinfo_t GetSrPerkFunctionInfo (const dword FuncType)
{
	if (FuncType >= 16) return g_SrPerkFunctionInfos[0];
	return g_SrPerkFunctionInfos[FuncType];
}


#define SRCNone				SRPERK_EFFECT_CONDNONE				
#define SRCOwner			SRPERK_EFFECT_CONDOWNER				
#define SRCTarget			SRPERK_EFFECT_CONDTARGET			
#define SRCAttacker			SRPERK_EFFECT_CONDATTACKER			
#define SRCAttackerWeapon	SRPERK_EFFECT_CONDATTACKERWEAPON	
#define SRCSpell			SRPERK_EFFECT_CONDSPELL				
#define SRCWeapon			SRPERK_EFFECT_CONDWEAPON			
#define SRCItem				SRPERK_EFFECT_CONDITEM				
#define SRCEnchantment		SRPERK_EFFECT_CONDENCHANTMENT		
#define SRCLockedRef		SRPERK_EFFECT_CONDLOCKEDREF

const srperkeffectinfo_t g_SrPerkEffectInfos[0x5C] = 
{
	{ 0x00, 3, SRPERK_EFFECT_FUNCFLAG_ALLVALUES,	{ SRCOwner, SRCWeapon, SRCTarget } },
	{ 0x01, 3, SRPERK_EFFECT_FUNCFLAG_ALLVALUES,	{ SRCOwner, SRCWeapon, SRCTarget } },
	{ 0x02, 3, SRPERK_EFFECT_FUNCFLAG_ALLVALUES,	{ SRCOwner, SRCWeapon, SRCTarget } },
	{ 0x03, 2, SRPERK_EFFECT_FUNCFLAG_ALLVALUES,	{ SRCOwner, SRCItem, 0 } },
	{ 0x04, 3, SRPERK_EFFECT_FUNCFLAG_ALLVALUES,	{ SRCOwner, SRCAttacker, SRCAttackerWeapon } },
	{ 0x05, 1, SRPERK_EFFECT_FUNCFLAG_ALLVALUES,	{ SRCOwner, 0, 0 } },
	{ 0x06, 1, SRPERK_EFFECT_FUNCFLAG_ALLVALUES,	{ SRCOwner, 0, 0 } },
	{ 0x07, 2, SRPERK_EFFECT_FUNCFLAG_ALLVALUES,	{ SRCOwner, SRCAttacker, 0 } },
	{ 0x08, 2, SRPERK_EFFECT_FUNCFLAG_ALLVALUES,	{ SRCOwner, SRCTarget, 0 } },
	{ 0x09, 2, SRPERK_EFFECT_FUNCFLAG_ADDLEVELLIST, { SRCOwner, SRCTarget, 0 } },
	{ 0x0A, 1, SRPERK_EFFECT_FUNCFLAG_ALLVALUES,	{ SRCOwner, 0, 0 } },
	{ 0x0B, 1, SRPERK_EFFECT_FUNCFLAG_ALLVALUES,	{ SRCOwner, 0, 0 } },
	{ 0x0C, 0, 0, { 0, 0, 0 } }, //Does not exist?
	{ 0x0D, 1, SRPERK_EFFECT_FUNCFLAG_ALLVALUES,	{ SRCOwner, 0, 0 } },
	{ 0x0E, 2, SRPERK_EFFECT_FUNCFLAG_ACTIVATE,		{ SRCOwner, SRCTarget, 0 } },
	{ 0x0F, 1, SRPERK_EFFECT_FUNCFLAG_ALLVALUES,	{ SRCOwner, 0, 0 } },
	{ 0x10, 1, SRPERK_EFFECT_FUNCFLAG_ALLVALUES,	{ SRCOwner, 0, 0 } },
	{ 0x11, 3, SRPERK_EFFECT_FUNCFLAG_ALLVALUES,	{ SRCOwner, SRCWeapon, SRCItem } },
	{ 0x12, 1, SRPERK_EFFECT_FUNCFLAG_ALLVALUES,	{ SRCOwner, SRCWeapon, SRCTarget } },
	{ 0x13, 1, SRPERK_EFFECT_FUNCFLAG_ALLVALUES,	{ SRCOwner, 0, 0 } },
	{ 0x14, 2, SRPERK_EFFECT_FUNCFLAG_ALLVALUES,	{ SRCOwner, SRCWeapon, 0 } },
	{ 0x15, 1, SRPERK_EFFECT_FUNCFLAG_ALLVALUES,	{ SRCOwner, 0, 0 } },
	{ 0x16, 1, SRPERK_EFFECT_FUNCFLAG_ALLVALUES,	{ SRCOwner, 0, 0 } },
	{ 0x17, 1, SRPERK_EFFECT_FUNCFLAG_ALLVALUES,	{ SRCOwner, 0, 0 } },
	{ 0x18, 1, SRPERK_EFFECT_FUNCFLAG_ALLVALUES,	{ SRCOwner, 0, 0 } },
	{ 0x19, 2, SRPERK_EFFECT_FUNCFLAG_ALLVALUES,	{ SRCOwner, SRCTarget, 0 } },
	{ 0x1A, 2, SRPERK_EFFECT_FUNCFLAG_ALLVALUES,	{ SRCOwner, SRCTarget, 0 } },
	{ 0x1B, 2, SRPERK_EFFECT_FUNCFLAG_ALLVALUES,	{ SRCOwner, SRCWeapon, 0 } },
	{ 0x1C, 3, SRPERK_EFFECT_FUNCFLAG_ALLVALUES,	{ SRCOwner, SRCWeapon, SRCTarget } },
	{ 0x1D, 3, SRPERK_EFFECT_FUNCFLAG_ALLVALUES,	{ SRCOwner, SRCSpell, SRCTarget } },
	{ 0x1E, 1, SRPERK_EFFECT_FUNCFLAG_ALLVALUES,	{ SRCOwner, SRCSpell, SRCTarget } },
	{ 0x1F, 3, SRPERK_EFFECT_FUNCFLAG_ALLVALUES,	{ SRCOwner, SRCSpell, SRCTarget } },
	{ 0x20, 2, SRPERK_EFFECT_FUNCFLAG_ALLVALUES,	{ SRCOwner, SRCItem, 0 } },
	{ 0x21, 2, SRPERK_EFFECT_FUNCFLAG_ALLVALUES,	{ SRCOwner, SRCAttacker, 0 } },
	{ 0x22, 2, SRPERK_EFFECT_FUNCFLAG_ALLVALUES,	{ SRCOwner, SRCTarget, 0 } },
	{ 0x23, 3, SRPERK_EFFECT_FUNCFLAG_ALLVALUES,	{ SRCOwner, SRCWeapon, SRCTarget } },
	{ 0x24, 3, SRPERK_EFFECT_FUNCFLAG_ALLVALUES,	{ SRCOwner, SRCAttacker, SRCAttackerWeapon } },
	{ 0x25, 3, SRPERK_EFFECT_FUNCFLAG_ALLVALUES,	{ SRCOwner, SRCWeapon, SRCTarget } },
	{ 0x26, 2, SRPERK_EFFECT_FUNCFLAG_ALLVALUES,	{ SRCOwner, SRCSpell, 0 } },
	{ 0x27, 1, SRPERK_EFFECT_FUNCFLAG_ALLVALUES,	{ SRCOwner, 0, 0 } },
	{ 0x28, 1, SRPERK_EFFECT_FUNCFLAG_ALLVALUES,	{ SRCOwner, 0, 0 } },
	{ 0x29, 2, SRPERK_EFFECT_FUNCFLAG_ALLVALUES,	{ SRCOwner, SRCSpell, 0 } },
	{ 0x2A, 2, SRPERK_EFFECT_FUNCFLAG_ALLVALUES,	{ SRCOwner, SRCSpell, 0 } },
	{ 0x2B, 2, SRPERK_EFFECT_FUNCFLAG_ALLVALUES,	{ SRCOwner, SRCTarget, 0 } },
	{ 0x2C, 1, SRPERK_EFFECT_FUNCFLAG_ALLVALUES,	{ SRCOwner, 0, 0 } },
	{ 0x2D, 2, SRPERK_EFFECT_FUNCFLAG_ALLVALUES,	{ SRCOwner, SRCTarget, 0 } },
	{ 0x2E, 2, SRPERK_EFFECT_FUNCFLAG_ALLVALUES,	{ SRCOwner, SRCTarget, 0 } },
	{ 0x2F, 2, SRPERK_EFFECT_FUNCFLAG_ALLVALUES,	{ SRCOwner, SRCTarget, 0 } },
	{ 0x30, 2, SRPERK_EFFECT_FUNCFLAG_ALLVALUES,	{ SRCOwner, SRCTarget, 0 } },
	{ 0x31, 2, SRPERK_EFFECT_FUNCFLAG_ALLVALUES,	{ SRCOwner, SRCItem, 0 } },
	{ 0x32, 1, SRPERK_EFFECT_FUNCFLAG_ALLVALUES,	{ SRCOwner, 0, 0 } },
	{ 0x33, 3, SRPERK_EFFECT_FUNCFLAG_ADDSPELL,		{ SRCOwner, SRCWeapon, SRCTarget } },
	{ 0x34, 2, SRPERK_EFFECT_FUNCFLAG_ADDSPELL,		{ SRCOwner, SRCTarget, 0 } },
	{ 0x35, 3, SRPERK_EFFECT_FUNCFLAG_ADDSPELL,		{ SRCOwner, SRCSpell, SRCTarget } },
	{ 0x36, 1, SRPERK_EFFECT_FUNCFLAG_SETGMST,		{ SRCOwner, 0, 0 } },
	{ 0x37, 2, SRPERK_EFFECT_FUNCFLAG_ALLVALUES,	{ SRCOwner, SRCSpell, 0 } },
	{ 0x38, 3, SRPERK_EFFECT_FUNCFLAG_ALLVALUES,	{ SRCOwner, SRCTarget, SRCItem } },
	{ 0x39, 2, SRPERK_EFFECT_FUNCFLAG_ALLVALUES,	{ SRCOwner, SRCTarget, 0 } },
	{ 0x3A, 1, SRPERK_EFFECT_FUNCFLAG_ALLVALUES,	{ SRCOwner, 0, 0 } },
	{ 0x3B, 2, SRPERK_EFFECT_FUNCFLAG_ALLVALUES,	{ SRCOwner, SRCLockedRef, 0 } },
	{ 0x3C, 2, SRPERK_EFFECT_FUNCFLAG_ALLVALUES,	{ SRCOwner, SRCTarget, 0 } },
	{ 0x3D, 3, SRPERK_EFFECT_FUNCFLAG_ALLVALUES,	{ SRCOwner, SRCTarget, SRCItem } },
	{ 0x3E, 1, SRPERK_EFFECT_FUNCFLAG_ALLVALUES,	{ SRCOwner, 0, 0 } },
	{ 0x3F, 1, SRPERK_EFFECT_FUNCFLAG_ALLVALUES,	{ SRCOwner, 0, 0 } },
	{ 0x40, 1, SRPERK_EFFECT_FUNCFLAG_ALLVALUES,	{ SRCOwner, 0, 0 } },
	{ 0x41, 1, SRPERK_EFFECT_FUNCFLAG_ALLVALUES,	{ SRCOwner, 0, 0 } },
	{ 0x42, 1, SRPERK_EFFECT_FUNCFLAG_ALLVALUES,	{ SRCOwner, 0, 0 } },
	{ 0x43, 3, SRPERK_EFFECT_FUNCFLAG_ADDSPELL,		{ SRCOwner, SRCAttacker, SRCAttackerWeapon } },
	{ 0x44, 2, SRPERK_EFFECT_FUNCFLAG_ALLVALUES,	{ SRCOwner, SRCSpell, 0 } },
	{ 0x45, 1, SRPERK_EFFECT_FUNCFLAG_ADDSPELL,		{ SRCOwner, 0, 0 } },
	{ 0x46, 2, SRPERK_EFFECT_FUNCFLAG_ALLVALUES,	{ SRCOwner, SRCSpell, 0 } },
	{ 0x47, 2, SRPERK_EFFECT_FUNCFLAG_ALLVALUES,	{ SRCOwner, SRCSpell, 0 } },
	{ 0x48, 2, SRPERK_EFFECT_FUNCFLAG_ALLVALUES,	{ SRCOwner, SRCSpell, 0 } },
	{ 0x49, 1, SRPERK_EFFECT_FUNCFLAG_ALLVALUES,	{ SRCOwner, 0, 0 } },
	{ 0x4A, 2, SRPERK_EFFECT_FUNCFLAG_ALLVALUES,	{ SRCOwner, SRCTarget, 0 } },
	{ 0x4B, 2, SRPERK_EFFECT_FUNCFLAG_ALLVALUES,	{ SRCOwner, SRCSpell, 0 } },
	{ 0x4C, 2, SRPERK_EFFECT_FUNCFLAG_ALLVALUES,	{ SRCOwner, SRCItem, 0 } },
	{ 0x4D, 3, SRPERK_EFFECT_FUNCFLAG_ALLVALUES,	{ SRCOwner, SRCEnchantment, SRCItem } },
	{ 0x4E, 3, SRPERK_EFFECT_FUNCFLAG_ALLVALUES,	{ SRCOwner, SRCTarget, SRCItem } },
	{ 0x4F, 3, SRPERK_EFFECT_FUNCFLAG_ALLVALUES,	{ SRCOwner, SRCEnchantment, SRCItem } },
	{ 0x50, 1, SRPERK_EFFECT_FUNCFLAG_ALLVALUES,	{ SRCOwner, 0, 0 } },
	{ 0x51, 2, SRPERK_EFFECT_FUNCFLAG_SETTEXT,		{ SRCOwner, SRCTarget, 0 } },
	{ 0x52, 1, SRPERK_EFFECT_FUNCFLAG_ALLVALUES,	{ SRCOwner, 0, 0 } },
	{ 0x53, 3, SRPERK_EFFECT_FUNCFLAG_ALLVALUES,	{ SRCOwner, SRCWeapon, SRCSpell } },
	{ 0x54, 3, SRPERK_EFFECT_FUNCFLAG_ALLVALUES,	{ SRCOwner, SRCTarget, SRCItem } },
	{ 0x55, 2, SRPERK_EFFECT_FUNCFLAG_ALLVALUES,	{ SRCOwner, SRCItem, 0 } },
	{ 0x56, 2, SRPERK_EFFECT_FUNCFLAG_ALLVALUES,	{ SRCOwner, SRCLockedRef, 0 } },
	{ 0x57, 2, SRPERK_EFFECT_FUNCFLAG_ALLVALUES,	{ SRCOwner, SRCItem, 0 } },
	{ 0x58, 2, SRPERK_EFFECT_FUNCFLAG_ALLVALUES,	{ SRCOwner, SRCSpell, 0 } },
	{ 0x59, 2, SRPERK_EFFECT_FUNCFLAG_ALLVALUES,	{ SRCOwner, SRCSpell, 0 } },
	{ 0x5A, 2, SRPERK_EFFECT_FUNCFLAG_ALLVALUES,	{ SRCOwner, SRCLockedRef, 0 } },
	{ 0xFF, 0, 0, { 0, 0, 0} } //Must be last
};

#undef SRCNone			
#undef SRCOwner		
#undef SRCTarget		
#undef SRCAttacker		
#undef SRCAttackWeapon	
#undef SRCSpell		
#undef SRCWeapon		
#undef SRCItem			
#undef SRCEnchanement	
#undef SRCLockedRef	


const srperkeffectinfo_t GetSrPerkEffectInfo (const dword EffectType)
{
	if (EffectType >= 0x5B) return g_SrPerkEffectInfos[0x5B];
	return g_SrPerkEffectInfos[EffectType];
}


CSrEpfdSubrecord::CSrEpfdSubrecord() : m_DataType(SP_EPFDTYPE_UNKNOWN)
{
}


void CSrEpfdSubrecord::Destroy()
{
	m_DataType = SP_EPFDTYPE_UNKNOWN;
}


bool CSrEpfdSubrecord::Copy (CSrSubrecord* pSubrecord) 
{
	CSrEpfdSubrecord* pSubrecord1 = SrCastClassNull(CSrEpfdSubrecord, pSubrecord);
	m_RecordSize = pSubrecord->GetRecordSize();

	if (pSubrecord1 != NULL) 
	{
		m_DataType = pSubrecord1->m_DataType;
		m_Data01   = pSubrecord1->m_Data01;
		m_Data02   = pSubrecord1->m_Data02;
		m_Data03   = pSubrecord1->m_Data03;
		m_Data04   = pSubrecord1->m_Data04;
		m_Data05   = pSubrecord1->m_Data05;
		m_Data06   = pSubrecord1->m_Data06;
		m_Data07   = pSubrecord1->m_Data07;

		m_Data07.IsLocalString = false;	//TODO: Properly inherit parent file local string setting
	}
	else 
	{
		memset(&m_Data01, 0, sizeof(m_Data01)); 
		memset(&m_Data02, 0, sizeof(m_Data02)); 
		memset(&m_Data03, 0, sizeof(m_Data03)); 
		memset(&m_Data04, 0, sizeof(m_Data04)); 
		memset(&m_Data05, 0, sizeof(m_Data05)); 
	}

	return true;
}


dword CSrEpfdSubrecord::ChangeFormID (const srformid_t NewID, const srformid_t OldID) 
{ 
	switch (m_DataType)
	{
		case SP_EPFDTYPE_LEVELLIST:
			if (m_Data03.FormID == OldID)
			{
				m_Data03.FormID = NewID;
				return 1;
			}
			break;
		case SP_EPFDTYPE_ACTIVATE:
			if (m_Data04.FormID == OldID)
			{
				m_Data04.FormID = NewID;
				return 1;
			}
			break;
		case SP_EPFDTYPE_SPELL:
			if (m_Data05.FormID == OldID)
			{
				m_Data05.FormID = NewID;
				return 1;
			}
			break;
	}
	
	return 0; 
}


dword CSrEpfdSubrecord::CountUses (const srformid_t FormID) 
{
	switch (m_DataType)
	{
		case SP_EPFDTYPE_LEVELLIST:
			if (m_Data03.FormID == FormID) return 1;
			break;
		case SP_EPFDTYPE_ACTIVATE:
			if (m_Data04.FormID == FormID) return 1;
			break;
		case SP_EPFDTYPE_SPELL:
			if (m_Data05.FormID == FormID) return 1;
			break;
	}

	return 0;
}


bool CSrEpfdSubrecord::FixupFormID (CSrFormidFixupArray& FixupArray) 
{
	switch (m_DataType)
	{
		case SP_EPFDTYPE_LEVELLIST: return SrFixupFormid(m_Data03.FormID, m_Data03.FormID, FixupArray);
		case SP_EPFDTYPE_ACTIVATE:  return SrFixupFormid(m_Data04.FormID, m_Data04.FormID, FixupArray);
		case SP_EPFDTYPE_SPELL:     return SrFixupFormid(m_Data05.FormID, m_Data05.FormID, FixupArray);
	}

	return true;
}


byte* CSrEpfdSubrecord::GetData (void) 
{ 
	switch (m_DataType)
	{
		case SP_EPFDTYPE_ONEFLOAT   : return (byte *)(&m_Data01); 
		case SP_EPFDTYPE_TWOFLOATS	: return (byte *)(&m_Data02); 
		case SP_EPFDTYPE_LEVELLIST  : return (byte *)(&m_Data03); 
		case SP_EPFDTYPE_ACTIVATE	: return (byte *)(&m_Data04); 
		case SP_EPFDTYPE_SPELL      : return (byte *)(&m_Data05); 
		case SP_EPFDTYPE_ZSTRING    : return (byte *)(m_Data06.String.c_str()); 
		case SP_EPFDTYPE_LSTRING    : 

			if (m_Data07.IsLocalString)	
			{
				if (m_Data07.IsLoaded) return (byte *)(m_Data07.String.c_str()); 
				return (byte *)(&m_Data07.StringID); 			
			}
			
			return (byte *)(m_Data07.String.c_str()); 
	}

	return (byte *)(&m_Data01); 
}


dword CSrEpfdSubrecord::GetRecordSize (void) const
{ 
	switch (m_DataType)
	{
		case SP_EPFDTYPE_LEVELLIST  : return SR_EPFDFORMID_SUBRECORD_SIZE; 
		case SP_EPFDTYPE_ONEFLOAT   : return SR_EPFDFLOAT_SUBRECORD_SIZE; 
		case SP_EPFDTYPE_TWOFLOATS	: return SR_EPFDACTORVALUE_SUBRECORD_SIZE;
		case SP_EPFDTYPE_ACTIVATE	: return SR_EPFDOTHER_SUBRECORD_SIZE;
		case SP_EPFDTYPE_SPELL      : return SR_EPFDFORMID_SUBRECORD_SIZE;
		case SP_EPFDTYPE_ZSTRING    : return m_Data06.String.GetLength() + 1;
		case SP_EPFDTYPE_LSTRING    : 

			if (m_Data07.IsLocalString) 
			{
				if (m_Data07.IsLoaded) return m_Data07.String.GetLength() + 1;
				return 4;
			}

			return m_Data07.String.GetLength() + 1;
	}

	return m_RecordSize;
}


void CSrEpfdSubrecord::InitializeNew (void) 
{ 
	CSrSubrecord::InitializeNew(); 

	m_DataType   = SP_EPFDTYPE_ONEFLOAT;
	m_RecordSize = SR_EPFDFLOAT_SUBRECORD_SIZE; 

	memset(&m_Data01, 0, sizeof(m_Data01)); 
	memset(&m_Data02, 0, sizeof(m_Data02)); 
	memset(&m_Data03, 0, sizeof(m_Data03)); 
	memset(&m_Data04, 0, sizeof(m_Data04)); 
	memset(&m_Data05, 0, sizeof(m_Data05)); 

	m_Data06.String.Empty();
	m_Data07.String.Empty();
	m_Data07.StringID = -1;
	m_Data07.IsLoaded = false;
	m_Data07.IsLocalString = false;
}


void CSrEpfdSubrecord::LoadLocalStrings (CSrRecordHandler* pHandler)
{
	if (m_DataType != SP_EPFDTYPE_LSTRING) return;

	if (m_Data07.StringID == 0)
	{
		m_Data07.IsLoaded = true;
		m_Data07.String.Empty();
		return;
	}

	CSString* pString = pHandler->FindLocalString(m_Data07.StringID);

	if (pString != NULL) 
	{
		//SystemLog.Printf("Found string '%s' for ID %d", *pString, m_StringID);
		m_Data07.String = *pString;
		m_Data07.IsLoaded = true;
	}
	else
	{
		SystemLog.Printf("Failed to find localized string id %d!", m_Data07.StringID);
	}
}
   

bool CSrEpfdSubrecord::ReadData  (CSrFile& File) 
{ 
	bool Result;

	switch (m_DataType)
	{
		case SP_EPFDTYPE_ONEFLOAT   : SR_VERIFY_SUBRECORDSIZE(SR_EPFD01_SUBRECORD_SIZE) return File.Read(&m_Data01, SR_EPFD01_SUBRECORD_SIZE); 
		case SP_EPFDTYPE_TWOFLOATS	: SR_VERIFY_SUBRECORDSIZE(SR_EPFD02_SUBRECORD_SIZE) return File.Read(&m_Data02, SR_EPFD02_SUBRECORD_SIZE); 
		case SP_EPFDTYPE_LEVELLIST  : SR_VERIFY_SUBRECORDSIZE(SR_EPFD03_SUBRECORD_SIZE) return File.Read(&m_Data03, SR_EPFD03_SUBRECORD_SIZE); 
		case SP_EPFDTYPE_ACTIVATE	: SR_VERIFY_SUBRECORDSIZE(SR_EPFD04_SUBRECORD_SIZE) return File.Read(&m_Data04, SR_EPFD04_SUBRECORD_SIZE); 
		case SP_EPFDTYPE_SPELL      : SR_VERIFY_SUBRECORDSIZE(SR_EPFD05_SUBRECORD_SIZE) return File.Read(&m_Data05, SR_EPFD05_SUBRECORD_SIZE); 
		case SP_EPFDTYPE_ZSTRING    :
			m_Data06.String.SetSize(m_RecordSize + 2);
			m_Data06.String.SetSize(m_RecordSize);
			if (m_RecordSize == 0) return (true);

			Result = File.Read((void *)(const SSCHAR *)m_Data06.String, m_RecordSize);
			if (m_Data06.String.GetAt(m_RecordSize - 1) == NULL_CHAR) m_Data06.String.Truncate(m_RecordSize - 1);

			return Result;

		case SP_EPFDTYPE_LSTRING    :

			if (m_Data07.IsLocalString)
			{
				m_Data07.IsLoaded = false;
				SR_VERIFY_SUBRECORDSIZE(4)
				return File.Read(&m_Data07.StringID, 4); 
			}
			else
			{
				m_Data07.StringID = -1;
				m_Data07.String.SetSize(m_RecordSize + 2);
				m_Data07.String.SetSize(m_RecordSize);
				if (m_RecordSize == 0) return (true);

				Result = File.Read((void *)(const SSCHAR *)m_Data07.String, m_RecordSize);
				if (m_Data07.String.GetAt(m_RecordSize - 1) == NULL_CHAR) m_Data07.String.Truncate(m_RecordSize - 1);

				return Result;
			}

			break;
	}

	return AddSrGeneralError("%08X: Unknown EPFD data type  %d!", File.Tell(), m_DataType);
}


bool CSrEpfdSubrecord::WriteData (CSrFile& File) 
{ 

	switch (m_DataType)
	{
		case SP_EPFDTYPE_ONEFLOAT   : return File.Write(&m_Data01, SR_EPFD01_SUBRECORD_SIZE); 
		case SP_EPFDTYPE_TWOFLOATS 	: return File.Write(&m_Data02, SR_EPFD02_SUBRECORD_SIZE); 
		case SP_EPFDTYPE_LEVELLIST	: return File.Write(&m_Data03, SR_EPFD03_SUBRECORD_SIZE); 
		case SP_EPFDTYPE_ACTIVATE	: return File.Write(&m_Data04, SR_EPFD04_SUBRECORD_SIZE); 
		case SP_EPFDTYPE_SPELL      : return File.Write(&m_Data05, SR_EPFD05_SUBRECORD_SIZE); 
		case SP_EPFDTYPE_ZSTRING    : return File.Write(m_Data06.String.c_str(), m_Data06.String.GetLength() + 1); 
		case SP_EPFDTYPE_LSTRING    :
			if (m_Data07.IsLocalString)	return File.Write(&m_Data07.StringID, 4);
			return File.Write(m_Data07.String.c_str(), m_Data07.String.GetLength() + 1); 
	}

	return AddSrGeneralError("WriteData(): Unknown EPFD data type %d!", m_DataType);
}


void CSrEpfdSubrecord::UpdateLocalStrings(CSrStringFile& StringFile, srlstringid_t& NextStringID)
{
	if (m_DataType != SP_EPFDTYPE_LSTRING) return;

	if (m_Data07.String.IsEmpty())
	{
		m_Data07.StringID = 0;
		return;
	}

	m_Data07.StringID = NextStringID++;
	StringFile.Add(m_Data07.StringID, m_Data07.String);
}
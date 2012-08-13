#include "SrScriptFile.h"


srscriptreftype_t g_SrScriptRefTypes[] = 
{
	 { SR_SCRIPT_REFTYPE_UNKNOWN,				"Unknown",				SR_NAME_NULL, 0  },
     { SR_SCRIPT_REFTYPE_ACTION,				"Action",				SR_NAME_AACT, 0  },
     { SR_SCRIPT_REFTYPE_ACTIVATOR,				"Activator",			SR_NAME_ACTI, 0  },
     { SR_SCRIPT_REFTYPE_ACTIVEMAGICEFFECT,		"ActiveMagicEffect",	SR_NAME_MGEF, 0  },
     { SR_SCRIPT_REFTYPE_ACTOR,					"Actor",				SR_NAME_NPC_, 0  },
     { SR_SCRIPT_REFTYPE_ACTORBASE,				"ActorBase",			SR_NAME_NPC_, 0  },
     { SR_SCRIPT_REFTYPE_ALIAS,					"Alias",				SR_NAME_NULL, 0  },
     { SR_SCRIPT_REFTYPE_AMMO,					"Ammo",					SR_NAME_AMMO, 0  },
     { SR_SCRIPT_REFTYPE_APPARATUS,				"Apparatus",			SR_NAME_APPA, 0  },
     { SR_SCRIPT_REFTYPE_ARMOR,					"Armor",				SR_NAME_ARMO, 0  },
     { SR_SCRIPT_REFTYPE_ASSOCIATIONTYPE,		"AssociationType",		SR_NAME_ASTP, 0  },
     { SR_SCRIPT_REFTYPE_BOOK,					"Book",					SR_NAME_BOOK, 0  },
     { SR_SCRIPT_REFTYPE_CELL,					"Cell",					SR_NAME_CELL, 0  },
     { SR_SCRIPT_REFTYPE_CLASS,					"Class",				SR_NAME_CLAS, 0  },
     { SR_SCRIPT_REFTYPE_CONSTRUCTIBLEOBJECT,	"ConstructibleObject",	SR_NAME_COBJ, 0  },
     { SR_SCRIPT_REFTYPE_CONTAINER,				"Container",			SR_NAME_CONT, 0  },
     { SR_SCRIPT_REFTYPE_DOOR,					"Door",					SR_NAME_DOOR, 0  },
     { SR_SCRIPT_REFTYPE_EFFECTSHADER,			"EffectShader",			SR_NAME_EFSH, 0  },
     { SR_SCRIPT_REFTYPE_ENCHANTMENT,			"Enchantment",			SR_NAME_ENCH, 0  },
     { SR_SCRIPT_REFTYPE_ENCOUNTERZONE,			"EncounterZone",		SR_NAME_ECZN, 0  },
     { SR_SCRIPT_REFTYPE_EXPLOSION,				"Explosion",			SR_NAME_EXPL, 0  },
     { SR_SCRIPT_REFTYPE_FACTION,				"Faction",				SR_NAME_FACT, 0  },
     { SR_SCRIPT_REFTYPE_FLORA,					"Flora",				SR_NAME_FLOR, 0  },
     { SR_SCRIPT_REFTYPE_FORM,					"Form",					SR_NAME_all,  0  },
     { SR_SCRIPT_REFTYPE_FORMLIST,				"FormList",				SR_NAME_FLST, 0  },
     { SR_SCRIPT_REFTYPE_FURNITURE,				"Furniture",			SR_NAME_FURN, 0  },
     { SR_SCRIPT_REFTYPE_GLOBALVARIABLE,		"GlobalVariable",		SR_NAME_GLOB, 0  },
     { SR_SCRIPT_REFTYPE_HAZARD,				"Hazard",				SR_NAME_HAZD, 0  },
     { SR_SCRIPT_REFTYPE_IDLE,					"Idle",					SR_NAME_IDLE, 0  },
     { SR_SCRIPT_REFTYPE_IMAGESPACEMODIFIER,	"ImageSpaceModifier",	SR_NAME_IMGS, 0  },
     { SR_SCRIPT_REFTYPE_IMPACTDATASET,			"ImpactDataSet",		SR_NAME_IPDS, 0  },
     { SR_SCRIPT_REFTYPE_INGREDIENT,			"Ingredient",			SR_NAME_INGR, 0  },
     { SR_SCRIPT_REFTYPE_KEY,					"Key",					SR_NAME_KEYM, 0  },
     { SR_SCRIPT_REFTYPE_KEYWORD,				"Keyword",				SR_NAME_KWDA, 0  },
     { SR_SCRIPT_REFTYPE_LEVELEDACTOR,			"LeveledActor",			SR_NAME_LVLN, 0  },
     { SR_SCRIPT_REFTYPE_LEVELEDITEM,			"LeveledItem",			SR_NAME_LVLI, 0  },
     { SR_SCRIPT_REFTYPE_LEVELEDSPELL,			"LeveledSpell",			SR_NAME_LVSP, 0  },
     { SR_SCRIPT_REFTYPE_LIGHT,					"Light",				SR_NAME_LIGH, 0  },
     { SR_SCRIPT_REFTYPE_LOCATION,				"Location",				SR_NAME_LCTN, 0  },
     { SR_SCRIPT_REFTYPE_LOCATIONALIAS,			"LocationAlias",		SR_NAME_NULL, 0  },
     { SR_SCRIPT_REFTYPE_LOCATIONREFTYPE,		"LocationRefType",		SR_NAME_LCRT, 0  },
     { SR_SCRIPT_REFTYPE_MAGICEFFECT,			"MagicEffect",			SR_NAME_MGEF, 0  },
     { SR_SCRIPT_REFTYPE_MESSAGE,				"Message",				SR_NAME_MESG, 0  },
     { SR_SCRIPT_REFTYPE_MISCOBJECT,			"MiscObject",			SR_NAME_MISC, 0  },
     { SR_SCRIPT_REFTYPE_MUSICTYPE,				"MusicType",			SR_NAME_MUSC, 0  },
     { SR_SCRIPT_REFTYPE_OBJECTREFERENCE,		"ObjectReference",		SR_NAME_REFR, 0  },
     { SR_SCRIPT_REFTYPE_OUTFIT,				"Outfit",				SR_NAME_OTFT, 0  },
     { SR_SCRIPT_REFTYPE_PACKAGE,				"Package",				SR_NAME_PACK, 0  },
     { SR_SCRIPT_REFTYPE_PERK,					"Perk",					SR_NAME_PERK, 0  },
     { SR_SCRIPT_REFTYPE_POTION,				"Potion",				SR_NAME_ALCH, 0  },
     { SR_SCRIPT_REFTYPE_PROJECTILE,			"Projectile",			SR_NAME_PROJ, 0  },
     { SR_SCRIPT_REFTYPE_QUEST,					"Quest",				SR_NAME_QUST, 0  },
     { SR_SCRIPT_REFTYPE_RACE,					"Race",					SR_NAME_RACE, 0  },
     { SR_SCRIPT_REFTYPE_REFERENCEALIAS,		"ReferenceAlias",		SR_NAME_NULL, 1  },
     { SR_SCRIPT_REFTYPE_SCENE,					"Scene",				SR_NAME_SCEN, 0  },
     { SR_SCRIPT_REFTYPE_SCROLL,				"Scroll",				SR_NAME_SCRL, 0  },
     { SR_SCRIPT_REFTYPE_SHOUT,					"Shout",				SR_NAME_SHOU, 0  },
     { SR_SCRIPT_REFTYPE_SOULGEM,				"SoulGem",				SR_NAME_SLGM, 0  },
     { SR_SCRIPT_REFTYPE_SOUND,					"Sound",				SR_NAME_SOUN, 0  },
     { SR_SCRIPT_REFTYPE_SOUNDCATEGORY,			"SoundCategory",		SR_NAME_SNCT, 0  },
     { SR_SCRIPT_REFTYPE_SPELL,					"Spell",				SR_NAME_SPEL, 0  },
     { SR_SCRIPT_REFTYPE_STATIC,				"Static",				SR_NAME_STAT, 0  },
     { SR_SCRIPT_REFTYPE_TALKINGACTIVATOR,		"TalkingActivator",		SR_NAME_TACT, 0  },
     { SR_SCRIPT_REFTYPE_TOPIC,					"Topic",				SR_NAME_DIAL, 0  },
     { SR_SCRIPT_REFTYPE_TOPICINFO,				"TopicInfo",			SR_NAME_INFO, 0  },
     { SR_SCRIPT_REFTYPE_VISUALEFFECT,			"VisualEffect",			SR_NAME_NULL, 0  },
     { SR_SCRIPT_REFTYPE_VOICETYPE,				"VoiceType",			SR_NAME_VTYP, 0  },
     { SR_SCRIPT_REFTYPE_WEAPON,				"Weapon",				SR_NAME_WEAP, 0  },
     { SR_SCRIPT_REFTYPE_WEATHER,				"Weather",				SR_NAME_WTHR, 0  },
     { SR_SCRIPT_REFTYPE_WORDOFPOWER,			"WordOfPower",			SR_NAME_WOOP, 0  },
     { SR_SCRIPT_REFTYPE_WORLDSPACE,			"WorldSpace",			SR_NAME_WRLD, 0  },
     { SR_SCRIPT_REFTYPE_NONE, NULL, SR_NAME_NULL, 0 } /* Must be last */
};


int GetSrScriptRefType (const char* pName)
{
	srscriptreftype_t* pRefTypeInfo = GetSrScriptRefTypeInfo(pName);
	if (pRefTypeInfo == NULL) return SR_SCRIPT_REFTYPE_UNKNOWN;
	return pRefTypeInfo->Type;
}


srscriptreftype_t* GetSrScriptRefTypeInfo (const char* pName)
{
	static CSrScriptRefTypeStringMap s_StringMap;
	static bool s_Init = false;

	if (!s_Init)
	{
		s_StringMap.InitHashTable(256);

		for (dword i = 0; g_SrScriptRefTypes[i].Type != SR_SCRIPT_REFTYPE_NONE; ++i)
		{
			s_StringMap.SetAt(g_SrScriptRefTypes[i].pName, &g_SrScriptRefTypes[i]);
		}

		s_Init = true;
	}

	return s_StringMap.Lookup(pName);
}


srscriptreftype_t* GetSrScriptRefTypeInfo (const int Type)
{
	static CSrScriptRefTypeIntMap s_IntMap;
	static bool s_Init = false;

	if (!s_Init)
	{
		s_IntMap.InitHashTable(256);

		for (dword i = 0; g_SrScriptRefTypes[i].Type != SR_SCRIPT_REFTYPE_NONE; ++i)
		{
			s_IntMap.SetAt(g_SrScriptRefTypes[i].Type, &g_SrScriptRefTypes[i]);
		}

		s_Init = true;
	}

	return s_IntMap.Lookup(Type);
}


CSrScriptFile::CSrScriptFile()
{
	m_IsModified = false;
	m_IsLoaded   = false;
}


CSrScriptFile::~CSrScriptFile()
{
}


void CSrScriptFile::Destroy (void)
{
	m_ScriptText.Destroy();
	m_Filename.Destroy();
	m_ScriptName.Destroy();
	m_IsModified = false;
	m_IsLoaded   = false;
}


srscriptproperty_t* CSrScriptFile::AddProperty (const srnewscriptpropertyinfo_t NewProperty)
{
	CSString Buffer;

	if (!IsLoaded())
	{
		AddSrGeneralError("Cannot add new property to an unloaded script!");
		return NULL;
	}

	Buffer.Format("\r\n%s%s property %s%s%s auto %s\r\n", NewProperty.Type.c_str(), NewProperty.Array ? "[]" : "", NewProperty.Name.c_str(), 
			NewProperty.Value.IsEmpty() ? "" : " = ", NewProperty.Value.c_str(),
			NewProperty.Hidden ? "hidden" : "");
	m_ScriptText += Buffer;

	if (!NewProperty.Document.IsEmpty())
	{
		m_ScriptText += "{ ";
		m_ScriptText += NewProperty.Document;
		m_ScriptText += " }\r\n";
	}

	srscriptproperty_t* pProperty = m_Properties.AddNew();
	pProperty->Name = NewProperty.Name;
	pProperty->Value = NewProperty.Value;
	pProperty->TypeName = NewProperty.Type;
	pProperty->RefType = SR_SCRIPT_REFTYPE_UNKNOWN;
	pProperty->Type = SR_VMAD_PROPDATA_NULL;

		/* TODO: Proper type parsing */
	if (NewProperty.Type.CompareNoCase("string") == 0)
		pProperty->Type = SR_VMAD_PROPDATA_STRING;
	else if (NewProperty.Type.CompareNoCase("int") == 0)
		pProperty->Type = SR_VMAD_PROPDATA_INT;
	else if (NewProperty.Type.CompareNoCase("bool") == 0)
		pProperty->Type = SR_VMAD_PROPDATA_BOOL;
	else if (NewProperty.Type.CompareNoCase("float") == 0)
		pProperty->Type = SR_VMAD_PROPDATA_FLOAT;
	else
	{
		pProperty->Type = SR_VMAD_PROPDATA_REFERENCE;
		pProperty->RefType = GetSrScriptRefType(pProperty->TypeName);
	}

	if (NewProperty.Array) pProperty->Type += 10;

	return pProperty;
}


bool CSrScriptFile::Load (const char* pFilename)
{
	CSrFile File;
	bool    Result;
	dword   InputBytes;

	Destroy();

	Result = File.Open(pFilename, "rb");
	if (!Result) return AddSrGeneralError("Failed to open script file '%s'!", pFilename);

	m_Filename = pFilename;
	UpdateName();

	if (File.GetFileSize() > 10000000) return AddSrGeneralError("Exceeded maximum size of script file (10000000 bytes)!");

	m_ScriptText.SetSizeEmpty(File.GetFileSize());

	Result = File.Read((char *)m_ScriptText.c_str(), File.GetFileSize(), InputBytes);
	m_ScriptText.UpdateLength();
	if (!Result) return false;	

	m_IsLoaded = true;
	return true;
}



/*
<property> ::= <type> 'Property' <identifier> <flags>
                 <function>
                 [<function>]
               'endProperty'

<auto property> ::= <type> 'Property' <identifier> ['=' <constant>] 'Auto' <flags>

flags ::= hidden conditional
*/


bool CSrScriptFile::ParseNonArrayProperty (dword& i)
{
	srscripttoken_t* pType = m_Tokens[i];
	srscripttoken_t* pID   = m_Tokens[i+2];
	if (pID == NULL || pType == NULL) return false;

	if (pID->Type   != SR_TOKEN_IDENTIFIER) return false;
	if (pType->Type != SR_TOKEN_IDENTIFIER) return false;

	srscriptproperty_t* pProperty = m_Properties.AddNew();
	pProperty->Name = pID->Token;
	pProperty->TypeName = pType->Token;

		/* TODO: Proper type parsing */
	if (pType->Token.CompareNoCase("string") == 0)
		pProperty->Type = SR_VMAD_PROPDATA_STRING;
	else if (pType->Token.CompareNoCase("int") == 0)
		pProperty->Type = SR_VMAD_PROPDATA_INT;
	else if (pType->Token.CompareNoCase("bool") == 0)
		pProperty->Type = SR_VMAD_PROPDATA_BOOL;
	else if (pType->Token.CompareNoCase("float") == 0)
		pProperty->Type = SR_VMAD_PROPDATA_FLOAT;
	else
	{
		pProperty->Type = SR_VMAD_PROPDATA_REFERENCE;
		pProperty->RefType = GetSrScriptRefType(pType->Token);		
	}
	
	/* TODO: Parse Flags? */
	i += 2;
	return true;
}


bool CSrScriptFile::ParseArrayProperty (dword& i)
{
	srscripttoken_t* pType = m_Tokens[i];
	srscripttoken_t* pID   = m_Tokens[i+4];
	if (pID == NULL || pType == NULL) return false;

	if (pID->Type   != SR_TOKEN_IDENTIFIER) return false;
	if (pType->Type != SR_TOKEN_IDENTIFIER) return false;

	srscriptproperty_t* pProperty = m_Properties.AddNew();
	pProperty->Name = pID->Token;
	pProperty->TypeName = pType->Token;

		/* TODO: Proper type parsing */
	if (pType->Token.CompareNoCase("string") == 0)
		pProperty->Type = SR_VMAD_PROPDATA_ARRAYSTRING;
	else if (pType->Token.CompareNoCase("int") == 0)
		pProperty->Type = SR_VMAD_PROPDATA_ARRAYINT;
	else if (pType->Token.CompareNoCase("bool") == 0)
		pProperty->Type = SR_VMAD_PROPDATA_ARRAYBOOL;
	else if (pType->Token.CompareNoCase("float") == 0)
		pProperty->Type = SR_VMAD_PROPDATA_ARRAYFLOAT;
	else
	{
		pProperty->Type = SR_VMAD_PROPDATA_ARRAYREFERENCE;
		pProperty->RefType = GetSrScriptRefType(pType->Token);
	}
		
		/* TODO: Parse Flags? */
	i += 4;
	return true;
}


bool CSrScriptFile::ParseProperties (void)
{
	srscripttoken_t* pProperty;
	bool             Result;

	m_Properties.Destroy();

	if (!m_IsLoaded) return AddSrGeneralError("Failed to parse properties in unloaded script '%s'!", m_ScriptName.c_str());

	Result = Tokenize();
	if (!Result) return AddSrGeneralError("Failed to parse properties in script '%s' due to token errors!", m_ScriptName.c_str());

	for (dword i = 0; i < m_Tokens.GetSize(); ++i)
	{
		if (m_Tokens[i]->Type != SR_TOKEN_EOL) continue;

		pProperty = m_Tokens[i+2];

		if (pProperty != NULL && stricmp(pProperty->Token, "property") == 0)
		{
			++i;
			ParseNonArrayProperty(i);
			continue;
		}

		pProperty = m_Tokens[i+4];

		if (pProperty != NULL && stricmp(pProperty->Token, "property") == 0)
		{
			++i;
			ParseArrayProperty(i);
			continue;
		}
		
	}
	
	return true;
}


bool CSrScriptFile::Save (const char* pFilename)
{
	CSrFile File;
	bool    Result;

	if (pFilename == NULL)
		Result = File.Open(m_Filename, "wb");
	else
		Result = File.Open(pFilename, "wb");

	if (!Result) return false;

	Result = File.Write(m_ScriptText, m_ScriptText.GetLength());
	if (!Result) return false;

	if (pFilename != NULL)
	{
		m_Filename = pFilename;
		UpdateName();
	}

	return true;
}


void CSrScriptFile::UpdateName (void)
{
	int Index = m_Filename.FindCharR('\\');
	m_ScriptName.Empty();

	if (Index < 0)
		m_ScriptName = m_Filename;
	else 
		m_ScriptName.Copy(m_Filename.c_str() + Index + 1, m_Filename.GetLength() - Index - 1);

	m_ScriptName.TruncateAt('.');
	m_ScriptRecord.SetScriptName(m_ScriptName);
}


dword CSrScriptFile::Find (srfinddata_t& FindData)
{
	const char* pResult;

	++FindData.ScriptCount;

	if (FindData.pData == NULL || FindData.DataSize <= 0) return 0;
	if (!IsLoaded()) return 0;

	if ((FindData.Flags & SR_FIND_FORMID) != 0)
	{
		return 0;
	}
	else if ((FindData.Flags & SR_FIND_COMPARETEXT) != 0)
	{
		if ((FindData.Flags & SR_FIND_CASESENSITIVE) != 0)
			pResult = stristr(m_ScriptText.c_str(), (const SSCHAR *)FindData.pData);
		else
			pResult = strstr(m_ScriptText.c_str(), (const SSCHAR *)FindData.pData);

		if (pResult == NULL) return 0;
	}
	else
	{
		int FindIndex = memcmp(m_ScriptText.c_str(), FindData.pData, FindData.DataSize);
		if (FindIndex < 0) return 0;
	}

	*(FindData.FindScripts.AddNew()) = m_ScriptName;
	if (FindData.pFindRecords) FindData.pFindRecords->Add(&m_ScriptRecord);
	++FindData.FoundScripts;

	return 1;
}

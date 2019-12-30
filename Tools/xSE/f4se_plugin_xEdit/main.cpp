#include <string>
#include <shlobj.h>
#include "common/IPrefix.h"
#include "f4se_common/f4se_version.h"
#include "f4se_common/Relocation.h"
#include "f4se_common/SafeWrite.h"
#include "f4se/PluginAPI.h"
#include "f4se/ObScript.h"
//#include "f4se/GameAPI.h"
#include "f4se/GameData.h"
//#include "f4se/ParamInfos.h"
#include "f4se/GameForms.h"
//#include "f4se/GameObjects.h"

	char xEditCommandName[] = {"xEditDump"};
	char pluginName[] = {"f4se_plugin_xEdit"};
	char pluginExt[] = {".log"};
	char pluginLogPath[] = {"\\My Games\\Fallout4\\F4SE\\"};
#ifdef _DEBUG
	char pluginEdition[] = {"-debug"};
#else
	char pluginEdition[] = {""};
#endif
#ifdef _NOGORE
	char pluginVariant[] = {"-nogore"};
#else
	char pluginVariant[] = {""};
#endif
	static char pluginLog[sizeof(pluginLogPath)+sizeof(pluginName)+sizeof(pluginEdition)+sizeof(pluginVariant)+sizeof(pluginExt)];

PluginHandle	g_pluginHandle = kPluginHandle_Invalid;
F4SEInterface * SaveF4SE;

#define REQUIRED_RUNTIME RUNTIME_VERSION_1_10_98

void OpenPluginLog()
{
	strcpy_s(pluginLog, pluginLogPath);
	strcat_s(pluginLog, pluginName);
	strcat_s(pluginLog, pluginVariant);
	strcat_s(pluginLog, pluginEdition);
	strcat_s(pluginLog, pluginExt);

	gLog.OpenRelative(CSIDL_MYDOCUMENTS, pluginLog);
#ifdef _DEBUG
	gLog.SetLogLevel(IDebugLog::kLevel_DebugMessage);
#endif
}

bool CheckParam(ObScriptCommand * iter, UInt32 paramIndex)
{
	// At least one function (1245) has numParams > 0 and params == NULL
	return iter && iter->params && iter->numParams>paramIndex;
}

UInt32 WBEncode(ObScriptParam param)
{
	switch (param.typeID)
	{
		case  00:	return    0; 	//	 00 'String' (String)
		case  01:	return    1; 	//	 01 'Integer' (Count)
		case  02:	return    3; 	//	 02 'Float' (Float)
		case  03:	return    2; 	//	 03 'ObjectID' (ObjectID)
		case  04:	return    2; 	//	 04 'ObjectRef' (ObjectReferenceID)
		case  05:	return    2; 	//	 05 'ActorValue' (Actor Value)
		case  06:	return    2; 	//	 06 'Actor' (Actor)
		case  07:	return    2; 	//	 07 'SpellItem' (Spell Item)
		case   8:	return    0; 	//	 08 'Axis' (Axis)
		case   9:	return    2; 	//	 09 'Cell' (Cell)
		case  10:	return    0; 	//	 0a 'AnimationGroup' (Animation Group)
		case  11:	return    2; 	//	 0b 'MagicItem' (Magic Item)
		case  12:	return    2; 	//	 0c 'Sound' (Sound)
		case  13:	return    2; 	//	 0d 'Topic' (Topic)
		case  14:	return    2; 	//	 0e 'Quest' (Quest)
		case  15:	return    2; 	//	 0f 'Race' (Race)
		case  16:	return    2; 	//	 10 'Class' (Class)
		case  17:	return    2; 	//	 11 'Faction' (Faction)
		case  18:	return    1; 	//	 12 'Sex' (Sex)
		case  19:	return    2; 	//	 13 'Global' (Global)
		case  20:	return    2; 	//	 14 'Furniture' (Furniture)
		case  21:	return    2; 	//	 15 'TESObject' (ObjectID)
		case  23:	return    1; 	//	 17 'QuestStage' (Stage)
		case  24:	return    2; 	//	 18 'MapMarker' (Map Marker)
		case  25:	return    2; 	//	 19 'ActorBase' (Actor Base)
		case  26:	return    2; 	//	 1a 'Container' (Container (optional))
		case  27:	return    2; 	//	 1b 'WorldSpace' (WorldSpace)
		case  28:	return    1; 	//	 1c 'CrimeType' (Crime Type)
		case  29:	return    2; 	//	 1d 'AIPackage' (Package)
		case  30:	return    2; 	//	 1e 'CombatStyle' (Combat Style (optional))
		case  31:	return    2; 	//	 1f 'MagicEffect' (Magic Effect)
		case  32:	return    2; 	//	 20 'FormType' (Form Type)
		case  33:	return    2; 	//	 21 'WeatherID' (Weather ID)
		case  35:	return    2; 	//	 23 'Owner' (Owner(optional))
		case  36:	return    2; 	//	 24 'EffectShader' (Effect Shader ID)
		case  37:	return    2; 	//	 25 'FormList' (Form List)
		case  39:	return    2; 	//	 27 'Perk' (Perk)
		case  40:	return    2; 	//	 28 'Note' (Note)
		case  41:	return    0; 	//	 29 'MiscellaneousStat' (Miscellaneous Stat)
		case  42:	return    2; 	//	 2a 'ImageSpaceModifier' (Imagespace Modifier ID)
		case  43:	return    2; 	//	 2b 'ImageSpace' (ImageSpace)
		case  46:	return    0; 	//	 2e 'EventFunction' (Event Function)
		case  47:	return    0; 	//	 2f 'EventMember' (Event Member)
		case  48:	return    0; 	//	 30 'Data ' (Data (Optional))
		case  49:	return    2; 	//	 31 'VoiceType' (VoiceType)
		case  50:	return    2; 	//	 32 'EncounterZone' (EncounterZone)
		case  51:	return    2; 	//	 33 'Idle Form' (Idle Form)
		case  52:	return    2; 	//	 34 'Message' (Message)
		case  53:	return    2; 	//	 35 'NonFormList' (ObjectID)
		case  54:	return    1; 	//	 36 'Alignment' (Alignment)
		case  55:	return    1; 	//	 37 'EquipType' (EquipType)
		case  56:	return    2; 	//	 38 'ObjectID' (ObjectID)
		case  57:	return    0; 	//	 39 'Music' (Music)
		case  58:	return    0; 	//	 3a 'CriticalStage' (CriticalStage)
		case  59:	return    2; 	//	 3b 'Keyword' (Keyword)
		case  60:	return    0; 	//	 3c 'RefType' (RefType)
		case  61:	return    2; 	//	 3d 'Location' (Location)
		case  62:	return    2; 	//	 3e 'Form' (Form)
		case  63:	return    0; 	//	 3f 'QuestAlias' (QuestAlias)
		case  67:	return    2; 	//	 43 'Scene' (Scene)
		case  68:	return    0; 	//	 44 'Source ' (Source (Optional))
		case  69:	return    0; 	//	 45 'AssociationType' (AssociationType)
		case  70:	return    0; 	//	 46 'WardState' (Ward State)
		case  71:	return    0; 	//	 47 'PackageData ' (PackageData (Possibly Null))
		case  72:	return    1; 	//	 48 'NumericPackageData' (PackageData (Numeric))
		case  74:	return    0; 	//	 4a 'PapyrusVariableName' (Papyrus Variable Name)
		case  75:	return    0; 	//	 4b 'ReferenceEffect' (Reference Effect)
		case  76:	return    2; 	//	 4c 'PackageData ' (PackageData (Location))
		case  77:	return    0; 	//	 4d 'SoundCategory' (SoundCategory)
		case  78:	return    2; 	//	 4e 'KnowableForm' (Knowable Form)
		case  79:	return    2; 	//	 4f 'Region' (Region)
		case  80:	return    2; 	//	 50 'Action' (Action)
		case  81:	return    0; 	//	 51 'MovementSelectIdleFromState' (MovementSelectIdleFromState)
		case  82:	return    0; 	//	 52 'MovementSelectIdleToState' (MovementSelectIdleToState)
		case  83:	return    0; 	//	 53 'PapyrusScript' (Papyrus Script)
		case  84:	return    1; 	//	 54 'DamageType' (Damage Type)
		case  85:	return    2; 	//	 55 'ActionTBD' (Action)
		case  86:	return    2; 	//	 56 'KeywordTBD' (Keyword)
		case  87:	return    0; 	//	 57 'FurnitureEntryType' (Furniture Entry Type)
		default:	return 0;
	}
};

class BGSLoadGameBuffer;

// 20
class TESForm_X : public BaseFormComponent
{
public:
	enum { kTypeID = 0 };	// special-case

	virtual void	Unk_07();
	virtual void	Unk_08();
	virtual bool	LoadForm(ModInfo* modInfo);		// 17 in CK, SaveForm is at 1B, make saveformbuffer is at 1A
	virtual void	Unk_0A();
	virtual bool	LoadForm2(ModInfo* modInfo);	// 1C in CK
	virtual void	Unk_0C();
	virtual bool	MarkChanged(UInt64 changed);
	virtual void	Unk_0E();
	virtual void	Unk_0F();
	virtual void	Unk_10();
	virtual void	WriteSave(); // Serialize
	virtual void	ReadSave(BGSLoadGameBuffer* save);
	virtual void	Unk_13();
	virtual void	Unk_14();
	virtual void	RevertSave();
	virtual void	InitItem();						// 22 in CK
	virtual ModInfo*	GetLastModifiedMod(); // 17 - Returns the ModInfo* of the mod that last modified the form.
	virtual ModInfo*	GetLastModifiedMod_2(); // 18 - Returns the ModInfo* of the mod that last modified the form. Calls a helper function to do so.
	virtual UInt8	GetFormType();  // 19
	virtual void	Unk_1A(); // 1A - GetDebugName(TESForm * form, char * destBuffer, unsigned int bufferSize);
	virtual bool	GetPlayerKnows(); // 1B - Gets flag bit 6.
	virtual void	Unk_1C();
	virtual void	Unk_1D();
	virtual void	Unk_1E();
	virtual void	Unk_1F();
	virtual void	Unk_20();
	virtual void	Unk_21();
	virtual void	Unk_22();
	virtual void	Unk_23();
	virtual void	Unk_24();
	virtual void	Unk_25();
	virtual void	Unk_26();
	virtual void	Unk_27();
	virtual void	Unk_28();
	virtual void	Unk_29();
	virtual void	Unk_2A();
	virtual void	LoadOBND();
	virtual void	Unk_2C();
	virtual void	LoadPTRN();
	virtual void	Unk_2E();
	virtual void	Unk_2F();
	virtual void	Unk_30();
	virtual void	Unk_31();
	virtual void	Unk_32();	// This is also a Cast
	virtual void	Unk_33();	// looks like CastAsReference
	virtual void	Unk_34();
	virtual const char *	GetFullName();  // 35
	virtual void	Unk_36();
	virtual void	Unk_37();
	virtual void	Unk_38();
	virtual void	Unk_39();
	virtual const char *	GetEditorID(); // Only returns string for things that actually store the EDID ingame
	virtual void	SetEditorID(char * editorID);
	virtual void	Unk_3C();
	virtual void	Unk_3D();
	virtual void	Unk_3E();
	virtual void	Unk_3F();
	virtual void	Unk_40();
	virtual void	Unk_41();
	virtual void	Unk_42();
	virtual void	Unk_43();
	virtual void	Unk_44();
	virtual void	Unk_45();
	virtual void	Unk_46();
	virtual void	Unk_47();
// ???	virtual void	Unk_48();
// ???	virtual void	Unk_49();

	enum {
		kFlag_IsDeleted     = 1 << 5,
		kFlag_PlayerKnows   = 1 << 6,
		kFlag_Persistent    = 1 << 10,
		kFlag_IsDisabled    = 1 << 11,
		kFlag_NoHavok       = 1 << 29,
	};

	struct Data
	{
		// Array of mods that contain this form (wether it is an original, a copy of an overwrite).
		// The builtin forms (formID < 0x0800) not overwritten in the game esm have a null mods pointer.
		// Those arrays are shared, as there is only one per combination of overwriting mods.
		// It is the same in Skyrim and Skyrim SE
		ModInfo ** entries;     // array of ModInfo* - mods that change this form.
		UInt64  size;
	};

	Data	* mods;		// 08
	UInt32	flags;		// 10	CK also
	UInt32	formID;		// 14	CK also
#ifdef EDITOR
	BSFixedString*	editorID;	// 18	It's a string at least
	UInt32			ckVCS1;		// 20	Version Control field 1
	UInt16			ckVCS2;		// 24	Version Control field 2
	UInt8			ckFormType;	// 26	some flags cannot be set if this is the Main Header:	Mask=11111110100110111010111111110100b
	UInt8			pad27;		// 27
#else
	UInt16	unk18;		// 18 - last 7 bits saved as part of CHANGE_FORM_FLAGS
	UInt8	formType;	// 1A
	UInt8	unk1B;		// 1B
	UInt32	pad1C;		// 1C
#endif
};
typedef tArray<TESForm_X*>	UnkFormXArray;

// 10
class TESFullName_X : public BaseFormComponent
{
public:
	virtual ~TESFullName_X();

	virtual void	GetExternData(void);
	virtual char *	Get(void);

	BSFixedString name;	// 08 In CK it is a BGSLocalizedString which contains a BSFixedString at offset 8
};

// 190
class ActorValueInfo_X : public TESForm
{
public:
	enum { kTypeID = kFormType_AVIF };

	TESFullName_X	fullName;             // 20
	TESDescription	description;          // 30

#if _MSC_VER == 1700
	std::function<void(Actor *, ActorValueInfo_X&, float, float, Actor *)> calcFunction;	// 48
#else
	void            * func_vtable;			// 48 - vtable of the lambda function
	void            * func;					// 50
	UInt64            unk58;				// 58
	void            * func_ptr;				// 60 - address of offset 48
#endif

	const char      * avName;               // 68
	UInt64            unk70;                // 70
	ActorValueInfo_X  * dependentAVs[0xF];    // 78

#if _MSC_VER == 1700
	std::function<float(ActorValueOwner*, ActorValueInfo_X&)> derivedFunction;	// F0
#else
	void            * derived_func_vtable;	// F0 - vtable of the lambda function
	void            * derived_func;			// F8
	UInt64            unk100;				// 100
	void            * derived_func_ptr;		// 108 - address of offset F0
#endif

	UInt32    unk110[(0x16C - 0x110) / 4];  // 110

	UInt32    avFlags;                      // 16C
	enum AVFlags
	{
		kFlag_DefaultBase_0             = (1 << 10),    // 10 | Default Base: 0
		kFlag_DefaultBase_1             = (1 << 11),    // 11 | Default Base: 1
		kFlag_DefaultBase_100           = (1 << 12),    // 12 | Default Base: 100
		kFlag_DefaultBase_UserDefined   = (1 << 13),    // 13 | Default Base: User Defined
		kFlag_DefaultBase_Derived       = (1 << 15),    // 15 | Default Base: Derived (bits 10-13 must not be set)
		kFlag_DamageIsPositive          = (1 << 26),    // 26 | Damage is Positive
		kFlag_GodModeImmune             = (1 << 27),    // 27 | God Mode Immune
		kFlag_Hardcoded                 = (1 << 31)     // 31 | Hardcoded
	};

	UInt32    avType;                       // 170
	UInt32    numDependentAVs;              // 174
	UInt32    unk178;                       // 178
	UInt32    unk17C;                       // 17C
	UInt32    unk180;                       // 180
	float     defaultBase;                  // 184
	UInt32    unk188;                       // 188
	UInt32    unk18C;                       // 18C
};
STATIC_ASSERT(offsetof(ActorValueInfo_X, avName) == 0x68);

bool xEditCommand()
{
	#if RUNTIME_VERSION == REQUIRED_RUNTIME
		static const UInt32 s_doShowChangeFlagsName = 0x00CD6940;				// Skyrim 1.9.32: 00675DB0,					Fallout3: 006C9510	FalloutNV: 0x0083FEF0
		static const UInt32 s_changeFormTypeArray = 0x037C1F10;					// Skyrim: 012724C0							Fallout3: 00F6D1D0	FalloutNV: 0x011A2428
		// xRef at second xRef to s_changeFormTypeArray, offset 0x0B
		static const UInt32 s_FormToChangeType = 0x05AAC730;					// after initialisation Skyrim: 01B2E4D0	Fallout3: 01079BD0	FalloutNV: 0x011DE360
		// first entry is NONE, then TES4
		static const UInt32 s_nickNames = 0x02C830D8;							// Array of form signatures
		// 4th to last xRef to s_nickNames. array of 159 FormTypeNickName
		static const UInt32 s_formTypeNicknames = 0x0370E7D0;					// Skyrim: 0123F2C4							Fallout3: 00F4A74C	FalloutNV: 0x01187004
		// Starts with "Misc Stats" as aMiscStats_0, first xref
		static const UInt32 s_GlobalData1Names = 0x037C18C0;					// Skyrim: 01272310, 01272334, 01272370,	Fallout3: 00F6CED8	FalloutNV: 0x011A216C
		static const UInt32 s_GlobalData2Names = s_GlobalData1Names + 12;		// 100 + index
		static const UInt32 s_GlobalData3Names = s_GlobalData2Names + 18;		// 1000 + index
		static const UInt32 s_GlobalData3NamesEnd = s_GlobalData3Names + 8;
		static const UInt64 s_DialogSubtypes = 0x0374E430;						// First is CUST Custom as aCustom_0 xRef 2
		static const UInt64 s_DialogSubtypesEnd = 0x0374F7B8;					//	past PlayerAquireFeaturedItem as aPlayeraquirefe xRef 1
		static const UInt64 s_DefaultObjectManagerObjectArray = 0x03723C50;		// First is UNUSED01, WWSP as aUnused01 xRef 1
		static const UInt64 s_DefaultObjectManagerObjectArrayEnd = 0x03726D90;	// ??_R0?AVBGSDefaultObjectManager@@@8 as BGSDefaultObjectManager `RTTI Type Descriptor'
	#else 
	#error
	#endif

	typedef char * (* _s_doShowChangeFlagsName)(UInt32 flag, UInt32 formType, bool returnDescription);
	RelocAddr <_s_doShowChangeFlagsName> doShowChangeFlagsName(s_doShowChangeFlagsName);
	RelocPtr <UInt32> changeToFormType(s_changeFormTypeArray);

	struct FormTypeNickname
	{
		char formType;
		char pad01[7];
		char *nickname;
		UInt32 unk10;
		UInt32 pad14;
	};
	RelocPtr <FormTypeNickname> formTypeNicknames(s_formTypeNicknames);	// array size = kFormType_Max

	_MESSAGE("*****************************************************************************************************");

	// create the list of signatures
	_MESSAGE("formType;formSignature; %d elements not counting the 6 specials for Papyrus", kFormType_Max);
	for (UInt32 formType = 0; formType < kFormType_Max; formType++) {
		_MESSAGE("%03d;%s", formType, formTypeNicknames[formType].nickname);
	}
	_MESSAGE("");

	_MESSAGE("*****************************************************************************************************");

	// create the list of script commands
	UInt32 i = 0;
	_MESSAGE("  wbConsoleFunctions : array[] of TFunction = (");
	for(ObScriptCommand * iter = g_firstConsoleCommand; iter->opcode < (kObScript_NumConsoleCommands+kObScript_ConsoleOpBase); ++iter, i++)
	{
			_MESSAGE("    (Index: %3d; Name: '%s'%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s),", i, iter->longName, 
				CheckParam(iter, 0) ? "; Paramtype1: pt" : "", CheckParam(iter, 0) ? iter->params[0].typeStr : "", 
				CheckParam(iter, 1) ? "; Paramtype2: pt" : "", CheckParam(iter, 1) ? iter->params[1].typeStr : "", 
				CheckParam(iter, 2) ? "; Paramtype3: pt" : "", CheckParam(iter, 2) ? iter->params[2].typeStr : "",
				CheckParam(iter, 3) ? "; Paramtype3: pt" : "", CheckParam(iter, 3) ? iter->params[3].typeStr : "",
				CheckParam(iter, 4) ? "; Paramtype4: pt" : "", CheckParam(iter, 4) ? iter->params[4].typeStr : "",
				CheckParam(iter, 5) ? "; Paramtype5: pt" : "", CheckParam(iter, 5) ? iter->params[5].typeStr : "",
				CheckParam(iter, 6) ? "; Paramtype6: pt" : "", CheckParam(iter, 6) ? iter->params[6].typeStr : "",
				CheckParam(iter, 7) ? "; Paramtype7: pt" : "", CheckParam(iter, 7) ? iter->params[7].typeStr : "",
				CheckParam(iter, 8) ? "; Paramtype8: pt" : "", CheckParam(iter, 8) ? iter->params[8].typeStr : "",
				CheckParam(iter, 9) ? "// ; More..." : "");
	}
	_MESSAGE("  );");	// Don't forget to remove the last ,

	_MESSAGE("");

	_MESSAGE("*****************************************************************************************************");

	// create the list of script commands
	i = 0;
	_MESSAGE("  wbFunctions : array[] of TFunction = (");
	for(ObScriptCommand * iter = g_firstObScriptCommand; iter->opcode < (kObScript_NumObScriptCommands+kObScript_ScriptOpBase); ++iter, i++)
	{
			_MESSAGE("    (Index: %3d; Name: '%s'%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s),", i, iter->longName, 
				CheckParam(iter, 0) ? "; Paramtype1: pt" : "", CheckParam(iter, 0) ? iter->params[0].typeStr : "", 
				CheckParam(iter, 1) ? "; Paramtype2: pt" : "", CheckParam(iter, 1) ? iter->params[1].typeStr : "", 
				CheckParam(iter, 2) ? "; Paramtype3: pt" : "", CheckParam(iter, 2) ? iter->params[2].typeStr : "",
				CheckParam(iter, 3) ? "; Paramtype3: pt" : "", CheckParam(iter, 3) ? iter->params[3].typeStr : "",
				CheckParam(iter, 4) ? "; Paramtype4: pt" : "", CheckParam(iter, 4) ? iter->params[4].typeStr : "",
				CheckParam(iter, 5) ? "; Paramtype5: pt" : "", CheckParam(iter, 5) ? iter->params[5].typeStr : "",
				CheckParam(iter, 6) ? "; Paramtype6: pt" : "", CheckParam(iter, 6) ? iter->params[6].typeStr : "",
				CheckParam(iter, 7) ? "; Paramtype7: pt" : "", CheckParam(iter, 7) ? iter->params[7].typeStr : "",
				CheckParam(iter, 8) ? "; Paramtype8: pt" : "", CheckParam(iter, 8) ? iter->params[8].typeStr : "",
				CheckParam(iter, 9) ? "// ; More..." : "");
	}
	_MESSAGE("  );");	// Don't forget to remove the last ,

	_MESSAGE("");

	_MESSAGE("*****************************************************************************************************");

	// create the list of condition commands
	i = 0;
	UInt32 j = 0;
	_MESSAGE("  wbCTDAFunctions : array[] of TCTDAFunction = (");
	for(ObScriptCommand * iter = g_firstObScriptCommand; iter->opcode < (kObScript_NumObScriptCommands+kObScript_ScriptOpBase); ++iter, i++)
	{
		if(iter->eval)
		{
			_MESSAGE("    (Index: %3d; Name: '%s'%s%s%s%s%s%s),\t\t// %3d", i, iter->longName, 
				CheckParam(iter, 0) ? "; Paramtype1: pt" : "", CheckParam(iter, 0) ? iter->params[0].typeStr : "", 
				CheckParam(iter, 1) ? "; Paramtype2: pt" : "", CheckParam(iter, 1) ? iter->params[1].typeStr : "", 
				CheckParam(iter, 2) ? "; Paramtype3: pt" : "", CheckParam(iter, 2) ? iter->params[2].typeStr : "",
				j);
			j++;
		}
	}
	_MESSAGE("  );");	// Don't forget to remove the last ,

	_MESSAGE("");

	_MESSAGE("*****************************************************************************************************");

	// create the list of condition commands for WB
	i = 0;
	_MESSAGE("# 0: no param; 1: int param; 2: formid param; 3: float param");
	_MESSAGE("condition_function_data = {");
	for (ObScriptCommand * iter = g_firstObScriptCommand; iter->opcode < (kObScript_NumObScriptCommands + kObScript_ScriptOpBase); ++iter, i++)
	{
		if (iter->eval)
		{
			_MESSAGE("    %4d: ('%s', %d, %d, %d),", i, iter->longName,
				CheckParam(iter, 0) ? WBEncode(iter->params[0]) : 0,
				CheckParam(iter, 1) ? WBEncode(iter->params[1]) : 0,
				CheckParam(iter, 2) ? WBEncode(iter->params[2]) : 0);
		}
	}
	_MESSAGE("}");	// Don't forget to add xSE functions

	_MESSAGE("");

	_MESSAGE("*****************************************************************************************************");

	// create the Changed Form flags variables
	UInt32 changeTypeCount = 50; // First being 13 = TESClass. 16 different cases, 50 valid are: 0,     1,   11h,   11h,    11h,   11h,   11h,   11h,    11h,   11h,   11h,   11h,    11h,   11h,   11h,   11h,    11h,   11h,   11h,   11h,      2,   11h,   11h,   11h,    11h,   11h,   11h,   11h,    11h,   11h,   11h,   11h,      3,     4,   11h,   11h,    11h,     5,   11h,   11h,    11h,   11h,   11h,     4,    11h,   11h,   11h,   11h,    11h,   11h,     6,     7,      7,     7,     7,     7,      7,     7,     7,     7,      7,   11h,   11h,   11h,    11h,   11h,     8,     9,    11h,   0Ah,   11h,   11h,      4,   11h,   11h,   11h,    11h,   11h,   11h,   11h,    11h,   0Bh,   11h,   11h,    11h,   11h,   11h,   11h,    11h,   11h,   11h,   11h,    11h,   0Ch,   0Dh,   11h,    11h,   11h,   11h,   11h,    11h,   11h,   11h,   11h,    0Eh,   11h,   11h,   11h,    11h,   11h,   11h,   11h,    0Fh,   10h
	for (UInt32 changeType = 0; changeType < changeTypeCount; changeType++) {
		_MESSAGE("  wbChangeFlags%03u        : IwbIntegerDef;", changeType);
	}
	_MESSAGE("");

	// create the Changed Form Data union variables
	for (UInt32 changeType = 0; changeType < changeTypeCount; changeType++) {
		UInt32 formType = changeToFormType[changeType];
		UInt32 flagValue;
		char * changeFlagsName;
		for (UInt8 flagShift = 0; flagShift < 32; flagShift++) {
			flagValue = 1 << flagShift;
			changeFlagsName = doShowChangeFlagsName(flagValue, formType, 0);
			if (strcmp("Bad Flag Name", changeFlagsName)) {
				_MESSAGE("  wbUnion%s : IwbUnionDef;", changeFlagsName);
			}
		}
	}

	_MESSAGE("*****************************************************************************************************");

	// decode the Change Type name
	_MESSAGE("  wbChangeTypes := wbKey2Data6Enum([");
	for (UInt32 changeType = 0; changeType < changeTypeCount-1; changeType++) {
		UInt32 formType = changeToFormType[changeType];
		_MESSAGE("    '%02u (%03X : %s)',", changeType, formType, formTypeNicknames[formType].nickname);
	}
	UInt32 formType = changeToFormType[changeTypeCount-1];
	_MESSAGE("    '%02u (%03X : %s)'", changeTypeCount-1, formType, formTypeNicknames[formType].nickname);
	_MESSAGE("  ]);\n");

	_MESSAGE("*****************************************************************************************************");

	// decode the Changed form flags
	for (UInt32 changeType = 0; changeType < changeTypeCount; changeType++) {
		UInt32 formType = changeToFormType[changeType];
		_MESSAGE("  // changeType: %03u = formType: %03u : %s", changeType, formType,  formTypeNicknames[formType].nickname);
		_MESSAGE("  wbChangeFlags%03u := wbInteger('Change Flags', itU32 , wbFlags([", changeType);

		UInt32 flagValue;
		char * changeFlagsName;
		char * changeFlagsDescription;
		for (UInt8 flagShift = 0; flagShift < 31; flagShift++) {
			flagValue = 1 << flagShift;
			changeFlagsName = doShowChangeFlagsName(flagValue, formType, 0);
			if (0==strcmp("Bad Flag Name", changeFlagsName)) {
				_MESSAGE("    {%02u} 'UnnamedFlag%02u',", flagShift, flagShift);
			} else {
				changeFlagsDescription = doShowChangeFlagsName(flagValue, formType, 1);
				_MESSAGE("    {%02u} '%s', // %s", flagShift, changeFlagsName, changeFlagsDescription);
			}
		}
		flagValue = 1 << 31;
		changeFlagsName = doShowChangeFlagsName(flagValue, formType, 0);
		if (0==strcmp("Bad Flag Name", changeFlagsName)) {
			_MESSAGE("    {%02u} 'UnnamedFlag%02u'", 31, 31);
		} else {
			changeFlagsDescription = doShowChangeFlagsName(flagValue, formType, 1);
			_MESSAGE("    {%02u} '%s' // %s", 31, changeFlagsName, changeFlagsDescription);
		}
		_MESSAGE("  ]));\n");
	}

	_MESSAGE("*****************************************************************************************************");

	// Build the Changed Form flags union
	_MESSAGE("  wbChangeFlags := wbUnion('Change Flags', ChangedFormFlagsDecider, [");
	for (UInt32 changeType = 0; changeType < changeTypeCount-1; changeType++) {
		_MESSAGE("    wbChangeFlags%03u,", changeType);
	}
	_MESSAGE("    wbChangeFlags%03u", changeTypeCount-1);
	_MESSAGE("  ]);\n");

	// Build the Changed Form union
	for (UInt32 changeType = 0; changeType < changeTypeCount; changeType++) {
		UInt32 formType = changeToFormType[changeType];
		UInt32 flagValue;
		char * changeFlagsName;
		for (UInt8 flagShift = 0; flagShift < 32; flagShift++) {
			flagValue = 1 << flagShift;
			changeFlagsName = doShowChangeFlagsName(flagValue, formType, 0);
			if (strcmp("Bad Flag Name", changeFlagsName)) {
				_MESSAGE("  wbUnion%s := wbUnion('%s', ChangedFlag%02uDecider, [wbNull, wbNull]);", changeFlagsName, doShowChangeFlagsName(flagValue, formType, 1), flagShift);
			}
		}
		_MESSAGE("");
	}
	_MESSAGE("");

	_MESSAGE("*****************************************************************************************************");

	// Build the Changed Form Data struct
	UInt32 flagValue = 1;
	char * changeFlagsName = doShowChangeFlagsName(flagValue, formType, 0);
	_MESSAGE("  wbChangedFormData := wbStruct('Changed Form Data', [");
	_MESSAGE("    wbInitialDataType,");
	_MESSAGE("    wbUnion('CForm Union', ChangedFormDataDecider, [");
	_MESSAGE("       wbNull");
	for (UInt32 changeType = 0; changeType < changeTypeCount; changeType++) {
		bool first = true;
		UInt32 formType = changeToFormType[changeType];
		_MESSAGE("      ,wbStruct('Change %s Data', [ {%03X}", formTypeNicknames[formType].nickname, formType);
		for (UInt8 flagShift = 0; flagShift < 32; flagShift++) {
			flagValue = 1 << flagShift;
			changeFlagsName = doShowChangeFlagsName(flagValue, formType, 0);
			if (strcmp("Bad Flag Name", changeFlagsName)) {
				if (first) {
					first = false;
					_MESSAGE("         wbUnion%s", changeFlagsName);
				} else
				_MESSAGE("        ,wbUnion%s", changeFlagsName);
			}
		}
		_MESSAGE("       ])");
	}
	_MESSAGE("    ]),");
	_MESSAGE("    wbByteArray('Undecoded Data', ChangedFormRemainingDataCounter)");
	_MESSAGE("  ]);\n");

	_MESSAGE("*****************************************************************************************************");
	_MESSAGE("\n\n\n");

	_MESSAGE("avID;avName;formID;\"fullName\";description.unk08;flags;avType");
	UInt32 firstAV = 0x2BC;
	UInt32 avID = 0;
	do
	{
		TESForm* pForm = LookupFormByID(avID+firstAV);
		ActorValueInfo_X* pActorValueInfo = NULL;

		if (pForm && pForm->formType == 98)
			pActorValueInfo = (ActorValueInfo_X*)pForm;
		if (pActorValueInfo) {
			_MESSAGE("%d;%s;%x;\"%s\";%x;%x;%x", avID, pActorValueInfo->avName, pActorValueInfo->formID, 
				pActorValueInfo->fullName.Get(), 
				pActorValueInfo->description.unk08, pActorValueInfo->avFlags, pActorValueInfo->avType);
		}
		avID++;
	} while ((avID+firstAV) < 0x800);

	_MESSAGE("*****************************************************************************************************");
	_MESSAGE("\n\n\n");

	struct DialogSubtype
	{
		const char	* name;			// 000
		char		unk008;			// 008
		char		fil009[3];		// 009
		char		shortName[4];	// 00C
		char		dstID;			// 010
		char		fil011[3];		// 011
		char		unk014;			// 014
		char		unk015;			// 015
		char		fil016[2];		// 016
		char		unk018;			// 018
		char		fil019[15];		// 019
	};	// 028

	_MESSAGE("dstID;dstName;dstType;dstShort;dstUnk014;dstUnk015;dstUnk018");
	RelocPtr <DialogSubtype>	g_DialogSubtypes(s_DialogSubtypes);
	RelocPtr <DialogSubtype>	g_DialogSubtypesEnd(s_DialogSubtypesEnd);
	DialogSubtype* curr = g_DialogSubtypes;
	UInt32 dstID = 0;
	do
	{
		char shortName[5] = "    ";
		for (UInt8 i = 0; i < 4 ; i++) shortName[i] = curr->shortName[i]; shortName[4] = 0;
		_MESSAGE("%d;\"%s\";%d;\"%s\";%d;%d;%d", dstID, curr->name, curr->dstID, shortName, curr->unk008, curr->unk014, curr->unk015, curr->unk018);
		dstID++;
		curr++;
	} while (curr < g_DialogSubtypesEnd);

	_MESSAGE("*****************************************************************************************************");
	_MESSAGE("\n\n\n");

	struct DataDOM
	{
		const char	* name;			// 000
		UInt8		formType;		// 008
		UInt8		fil009[3];		// 009
		char		shortName[4];	// 00C
		UInt32		unk010;			// 010
		UInt32		unk014;			// 014
		UInt32		formID;			// 018
		UInt32		pad01C;			// 01C
	};	// 020

	RelocPtr <DataDOM>	g_DefaultObjectManagerObject(s_DefaultObjectManagerObjectArray);
	UInt32 domCount = (s_DefaultObjectManagerObjectArrayEnd - s_DefaultObjectManagerObjectArray) / sizeof(DataDOM);
	DataDOM* dom = g_DefaultObjectManagerObject;
	_MESSAGE("domID;domName;domShort;formType;domUnk010;domUnk014;domFormID; %d elements", domCount);
	for (UInt32 domID = 0; domID < domCount ; domID++)
	{
		char shortName[5] = "    ";
		for (UInt8 i = 0; i < 4 ; i++) shortName[i] = dom->shortName[i]; shortName[4] = 0;
		_MESSAGE("%d;\"%s\";\"%s\";%d;%d;%d;%08x", domID, dom->name, shortName, dom->formType, dom->unk010, dom->unk014, dom->formID);
		dom++;
	};

	_MESSAGE("*****************************************************************************************************");
	_MESSAGE("\n\n\n");

	dom = g_DefaultObjectManagerObject;
	for (UInt32 domID = 0; domID < domCount ; domID++)
	{
		char shortName[5] = "    ";
		for (UInt8 i = 0; i < 4 ; i++) shortName[i] = dom->shortName[i]; shortName[4] = 0;
		_MESSAGE("sig2Int('%s'), '%s'", shortName, dom->name);
		dom++;
	};

	_MESSAGE("*****************************************************************************************************");
	_MESSAGE("\n\n\n");

	DefaultObjectMap * domap = *(g_defaultObjectMap);
	domap->Dump();

	_MESSAGE("*****************************************************************************************************");
	_MESSAGE("\n\n\n");

	_MESSAGE("formType;formSignature;formID;");
	DataHandler* theDH = *g_dataHandler.GetPtr();
	UnkFormXArray* unkFormArrays = (UnkFormXArray*)&(theDH->arrNONE);
	for (UInt8 i = 0; i < kFormType_Max; i++)
	{
		UnkFormXArray* a = (UnkFormXArray*) ((uintptr_t)unkFormArrays + i * sizeof(UnkFormXArray));
		for (UInt64 j = 0; j < a->count; j++)
		{
			TESForm_X* f = (*a)[j];
			if (f && !f->mods)
				_MESSAGE("%04d;%s;%08X;", f->formType, formTypeNicknames[f->formType].nickname, f->formID);
		}
	}

	_MESSAGE("*****************************************************************************************************");
	_MESSAGE("\n\n\n");

	return true;
}
  
// currently ToggleESRAM
static ObScriptCommand * s_hijackedCommand = nullptr;

void xEdit_ObScript_Init()
{
	// instead of hooking the entire classic scripting system, we're just hijacking some unused commands, just like F4SE does

	for(ObScriptCommand * iter = g_firstConsoleCommand; iter->opcode < (kObScript_NumConsoleCommands+kObScript_ConsoleOpBase); ++iter)
	{
		if(!strcmp(iter->longName, "ToggleESRAM"))
		{
			s_hijackedCommand = iter;
			break;
		}
	}

	if(!s_hijackedCommand)
	{
		_ERROR("couldn't find the obscript command to use");
	}
}

#ifndef COMMAND_ARGS
#define COMMAND_ARGS void * paramInfo, void * scriptData, TESObjectREFR * thisObj, void * containingObj, void * scriptObj, void * locals, double * result, void * opcodeOffsetPtr
#endif

bool xEditCommand_Execute(COMMAND_ARGS)
{
	return xEditCommand();
}

void xEdit_ObScript_Commit()
{
	ObScriptCommand cmd = *s_hijackedCommand;

	cmd.longName = xEditCommandName;
	cmd.shortName = "";
	cmd.helpText = "";
	cmd.needsParent = 0;
	cmd.numParams = 0;
	cmd.execute = xEditCommand_Execute;
	cmd.flags = 0;

	SafeWriteBuf((uintptr_t)s_hijackedCommand, &cmd, sizeof(cmd));
	_MESSAGE("xEdit console command '%s' installed as 0x%08x", cmd.longName, cmd.opcode);
}

extern "C"
{

bool F4SEPlugin_Query(const F4SEInterface * f4se, PluginInfo * info)
{

	OpenPluginLog();

	_MESSAGE(pluginName);

	// fill out the info structure
	info->infoVersion = PluginInfo::kInfoVersion;
	info->name = pluginName;
	info->version = 3;

	// version checks
	if(f4se->f4seVersion < F4SE_VERSION_INTEGER)
	{
		_ERROR("f4se version too old (got %08X expected at least %08X)", f4se->f4seVersion, F4SE_VERSION_INTEGER);
		return false;
	}

	if(!f4se->isEditor)
	{
		if(f4se->runtimeVersion != REQUIRED_RUNTIME)
		{
			_ERROR("incorrect runtime version (got %08X need %08X)", f4se->runtimeVersion, REQUIRED_RUNTIME);
			return false;
		}

	}
	else
	{
		return false;
	}

	// version checks pass

	return true;
}

bool F4SEPlugin_Load(const F4SEInterface * f4se)
{
	g_pluginHandle = f4se->GetPluginHandle();

	// save the F4SEinterface in cas we need it later
	SaveF4SE = (F4SEInterface *)f4se;
	//SaveCT = (NVSECommandTableInterface *)nvse->QueryInterface(kInterface_CommandTable);
	//SaveMsg = (NVSEMessagingInterface *)nvse->QueryInterface(kInterface_Messaging);
	//SaveMsg->RegisterListener(g_pluginHandle, "NVSE", MessageHandler);

	xEdit_ObScript_Init();
	xEdit_ObScript_Commit();

	return true;
}

};

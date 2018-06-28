#include <string>
#include "common/IPrefix.h"
#include "fose/PluginAPI.h"
#include "fose_common/fose_version.h"

IDebugLog		gLog("fose_plugin_xEdit.log");

PluginHandle	g_pluginHandle = kPluginHandle_Invalid;
FOSEInterface * SaveFOSE;
FOSECommandTableInterface * SaveCT;

bool CheckParam(CommandInfo * iter, UInt32 paramIndex)
{
	// At least one function (1245) has numParams > 0 and params == NULL
	return iter && iter->params && iter->numParams>paramIndex;
}

bool CheckParam(const CommandInfo * iter, UInt32 paramIndex)
{
	// At least one function (1245) has numParams > 0 and params == NULL
	return iter && iter->params && iter->numParams>paramIndex;
}

UInt32 WBEncode(ParamInfo param)
{
	switch (param.typeID)
	{
		case   0:	return    0; 	//	 00 'String' ()   0
		case   1:	return    1; 	//	 01 'Integer' ()   0
		case   2:	return    3; 	//	 02 'Float' ()   0
		case   3:	return    2; 	//	 03 'ObjectID' ()   0
		case   4:	return    2; 	//	 04 'ObjectRef' ()   0
		case   5:	return    2; 	//	 05 'ActorValue' ()   0
		case   6:	return    2; 	//	 06 'Actor' ()   0
		case   7:	return    2; 	//	 07 'SpellItem' ()   0
		case   8:	return    0; 	//	 08 'Axis' ()   0
		case   9:	return    2; 	//	 09 'Cell' ()   0
		case  10:	return    0; 	//	 0a 'AnimationGroup' ()   0
		case  11:	return    2; 	//	 0b 'MagicItem' ()   0
		case  12:	return    2; 	//	 0c 'Sound' ()   0
		case  13:	return    2; 	//	 0d 'Topic' ()   0
		case  14:	return    2; 	//	 0e 'Quest' ()   0
		case  15:	return    2; 	//	 0f 'Race' ()   0
		case  16:	return    2; 	//	 10 'Class' ()   0
		case  17:	return    2; 	//	 11 'Faction' ()   0
		case  18:	return    1; 	//	 12 'Sex' ()   0
		case  19:	return    2; 	//	 13 'Global' ()   0
		case  20:	return    2; 	//	 14 'Furniture' ()   0
		case  21:	return    2; 	//	 15 'TESObject' ()   0
		case  22:	return    0; 	//	 16 'VariableName' ()   0
		case  23:	return    1; 	//	 17 'QuestStage' ()   0
		case  24:	return    2; 	//	 18 'MapMarker' ()   0
		case  25:	return    2; 	//	 19 'ActorBase' ()   0
		case  26:	return    2; 	//	 1a 'Container' ()   0
		case  27:	return    2; 	//	 1b 'WorldSpace' ()   0
		case  28:	return    1; 	//	 1c 'CrimeType' ()   0
		case  29:	return    2; 	//	 1d 'AIPackage' ()   0
		case  30:	return    2; 	//	 1e 'CombatStyle' ()   0
		case  31:	return    2; 	//	 1f 'MagicEffect' ()   0
		case  32:	return    2; 	//	 20 'FormType' ()   0
		case  33:	return    2; 	//	 21 'WeatherID' ()   0
		case  35:	return    2; 	//	 23 'Owner' ()   0
		case  36:	return    2; 	//	 24 'EffectShader' ()   0
		case  37:	return    2; 	//	 25 'FormList' ()   0
		case  39:	return    2; 	//	 27 'Perk' ()   0
		case  40:	return    2; 	//	 28 'Note' ()   0
		case  41:	return    0; 	//	 29 'MiscellaneousStat' ()   0
		case  42:	return    2; 	//	 2a 'ImageSpaceModifier' ()   0
		case  43:	return    2; 	//	 2b 'ImageSpace' ()   0
		case  46:	return    0; 	//	 2e 'VoiceType' ()   0
		case  47:	return    2; 	//	 2f 'EncounterZone' ()   0
		case  48:	return    2; 	//	 30 'IdleForm' ()   0
		case  49:	return    2; 	//	 31 'Message' ()   0
		case  50:	return    2; 	//	 32 'ObjectID_BIS' ()   0
		case  51:	return    1; 	//	 33 'Alignment' ()   0
		case  52:	return    1; 	//	 34 'EquipType' ()   0
		case  53:	return    2; 	//	 35 'ObjectID_TBD' ()   0
		case  54:	return    2; 	//	 36 'Music' ()   0
		case  55:	return    1; 	//	 37 'CriticalStage' ()   0
		case  56:	return    2; 	//	 38 'NPCorLeveledCharacter' ()   0
		case  57:	return    2; 	//	 39 'CreatureOrLeveledCreature' ()   0
		case  58:	return    2; 	//	 3a 'LeveledCharacter' ()   0
		case  59:	return    2; 	//	 3b 'LeveledCreature' ()   0
		case  60:	return    2; 	//	 3c 'LeveledItem' ()   0
		case  61:	return    2; 	//	 3d 'AnyForm' ()   0
		default:	return 0;
	}
};

extern "C" {

bool FOSEPlugin_Query(const FOSEInterface * fose, PluginInfo * info)
{
	// fill out the info structure
	info->infoVersion = PluginInfo::kInfoVersion;
	info->name = "fose_plugin_xEdit";
	info->version = 1;

	// version checks
	if(fose->foseVersion < FOSE_VERSION_INTEGER)
	{
		_ERROR("FOSE version too old (got %08X expected at least %08X)", fose->foseVersion, FOSE_VERSION_INTEGER);
		return false;
	}

	if(!fose->isEditor)
	{
		if(fose->runtimeVersion < FALLOUT_VERSION_1_7)
		{
			_ERROR("incorrect runtime version (got %08X need at least %08X)", fose->runtimeVersion, FALLOUT_VERSION_1_7);
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

bool FOSEPlugin_Load(const FOSEInterface * fose)
{
	g_pluginHandle = fose->GetPluginHandle();

	// save the FOSEinterface in cas we need it later
	SaveFOSE = (FOSEInterface *)fose;
	SaveCT = (FOSECommandTableInterface *)fose->QueryInterface(kInterface_CommandTable);

	#if RUNTIME_VERSION == FALLOUT_VERSION_1_7
		static const UInt32 s_doShowChangeFlagsName = 0x006C9510;		// Skyrim 1.9.32: 00675DB0,					Fallout3: 006C9510
		static const UInt32 s_ChangeToFormType = 0x00F6D1D0;			// Skyrim: 012724C0							Fallout3: 00F6D1D0
		static const UInt32 s_FormToChangeType = 0x01079BD0;			// after initialisation Skyrim: 01B2E4D0	Fallout3: 01079BD0
		static const UInt32 s_RecordType = 0x00F4A74C;					// Skyrim: 0123F2C4							Fallout3: 00F4A74C
		static const UInt32 s_GlobalDataNames = 0x00F6CED8;				// Skyrim: 01272310, 01272334, 01272370,	Fallout3: 00F6CED8
	#elif RUNTIME_VERSION == FALLOUT_VERSION_1_7ng
		static const UInt32 s_doShowChangeFlagsName = 0x006D8770;		// Skyrim 1.9.32: 00675DB0,					Fallout3: 006C9510
		static const UInt32 s_ChangeToFormType = 0x00F6A1D0;			// Skyrim: 012724C0							Fallout3: 00F6D1D0
		static const UInt32 s_FormToChangeType = 0x01076BD0;			// after initialisation Skyrim: 01B2E4D0	Fallout3: 01079BD0
		static const UInt32 s_RecordType = 0x00F4774C;					// Skyrim: 0123F2C4							Fallout3: 00F4A74C
		static const UInt32 s_GlobalDataNames = 0x00F69ED8;				// Skyrim: 01272310, 01272334, 01272370,	Fallout3: 00F6CED8
	#else
	#error
	#endif

	typedef char * (* _s_doShowChangeFlagsName)(UInt32 flag, UInt32 formType, bool returnDescription);
	const _s_doShowChangeFlagsName doShowChangeFlagsName = (_s_doShowChangeFlagsName)s_doShowChangeFlagsName;
	const UInt32 * changeToFormType = (const UInt32 *)s_ChangeToFormType;
	struct RecordType {
		char * signature;
		UInt32 unknown;
		UInt32 opcode;
	};
	const RecordType * recordType = (const RecordType *)s_RecordType;

	_MESSAGE("*****************************************************************************************************");

	// create the Changed Form flags variables
	UInt32 changeTypeCount = 42;
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
		_MESSAGE("    '%02u (%03X : %s)',", changeType, formType, recordType[formType].signature );
	}
	UInt32 formType = changeToFormType[changeTypeCount-1];
	_MESSAGE("    '%02u (%03X : %s)'", changeTypeCount-1, formType, recordType[formType].signature );
	_MESSAGE("  ]);\n");

	// decode the Changed form flags
	for (UInt32 changeType = 0; changeType < changeTypeCount; changeType++) {
		UInt32 formType = changeToFormType[changeType];
		_MESSAGE("  // changeType: %03u = formType: %03u : %s", changeType, formType, recordType[formType].signature);
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
		_MESSAGE("      ,wbStruct('Change %s Data', [ {%03X}", recordType[formType].signature, formType);
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

	// create the list of condition commands for WB
	UInt32 i = 0;
	UInt32 j = 0;
	_MESSAGE("conditionFunctionData = ( #--0: no param; 1: int param; 2: formid param; 3: float param");
	for (const CommandInfo * CI = SaveCT->Start(); CI < SaveCT->End(); CI++, i++)
	{
		if (CI->eval)
		{
			_MESSAGE("    (%3d, '%s', %d, %d), # %3d", i, CI->longName,
				CheckParam(CI, 0) ? WBEncode(CI->params[0]) : 0,
				CheckParam(CI, 1) ? WBEncode(CI->params[1]) : 0,
				j);
			j++;
		}
	}
	_MESSAGE("    )");	// Don't forget to add xSE functions

	_MESSAGE("");

	_MESSAGE("*****************************************************************************************************");

	_MESSAGE("*****************************************************************************************************");
	_MESSAGE("\n\n\n");
  
	const UInt32 kFOSEOpcodeStart	= 0x1400;
	const UInt32 kFOSEOpcodeTest	= 0x2000;

	#define ALength 256
  
	char ParamType1[ALength];
	char ParamType2[ALength];

	const PluginInfo	* PI = NULL;

	_MESSAGE("*****************************************************************************************************");
	_MESSAGE("\n    // Added by Fallout NV");

	// Loop through all function in the command table looking for those where the eval member is not null
	for (const CommandInfo * CI = SaveCT->Start(); CI < SaveCT->End(); CI++)
	{
		UInt32 i = CI->opcode;

		if (i && CI && CI->eval && (kFOSEOpcodeTest>i || (kFOSEOpcodeTest+16-1)<i))
		{
			if (PI != SaveCT->GetParentPlugin(CI))	// Ok, this is bugged !!!
			{
				PI = SaveCT->GetParentPlugin(CI);
				if (PI)
					_MESSAGE("\n    // Added by %s", PI->name);
			};
			if ((CI->numParams>0) && CI->params)							// assume first parameter is passed to eval
				sprintf_s(ParamType1, ALength, " {ParamType1: %s;}", CI->params[0].typeStr);	// Name of the parameter, the type is encoded in CI->params[0]->typeID
			else
				strcpy_s(ParamType1, ALength, "");
			if ((CI->numParams>1) && CI->params)									// assume second parameter is passed to eval
				sprintf_s(ParamType2, ALength, " {ParamType2: %s;}", CI->params[1].typeStr);
			else
				strcpy_s(ParamType2, ALength, " ");
			_MESSAGE("    (Index: %d; Name: '%s';%s%s),", i - 0x1000, CI->longName, ParamType1, ParamType2);
		}
	}

	return true;
}

};

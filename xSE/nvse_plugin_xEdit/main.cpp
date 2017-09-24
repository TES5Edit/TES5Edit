#include <string>
#include "nvse/PluginAPI.h"

#ifdef NOGORE
IDebugLog		gLog("nvse_plugin_xEdit_ng.log");
#else
IDebugLog		gLog("nvse_plugin_xEdit.log");
#endif

PluginHandle	g_pluginHandle = kPluginHandle_Invalid;
NVSEInterface * SaveNVSE;
NVSECommandTableInterface * SaveCT;
NVSEMessagingInterface* SaveMsg;

bool DoTheWork()
{
	#if RUNTIME_VERSION == RUNTIME_VERSION_1_4_0_525
		static const UInt32 s_doShowChangeFlagsName = 0x0083FEF0;		// Skyrim 1.9.32: 00675DB0,					Fallout3: 006C9510
		static const UInt32 s_ChangeToFormType = 0x011A2428;			// Skyrim: 012724C0							Fallout3: 00F6D1D0
		static const UInt32 s_FormToChangeType = 0x011DE360;			// after initialisation Skyrim: 01B2E4D0	Fallout3: 01079BD0
		static const UInt32 s_RecordType = 0x01187004;					// Skyrim: 0123F2C4							Fallout3: 00F4A74C
		static const UInt32 s_GlobalDataNames = 0x011A216C;				// Skyrim: 01272310, 01272334, 01272370,	Fallout3: 00F6CED8
	#elif RUNTIME_VERSION == RUNTIME_VERSION_1_4_0_525ng
		static const UInt32 s_doShowChangeFlagsName = 0x0083FE40;
		static const UInt32 s_ChangeToFormType = 0x011A2428;
		static const UInt32 s_FormToChangeType = 0x011DE360;
		static const UInt32 s_RecordType = 0x01187004;
		static const UInt32 s_GlobalDataNames = 0x011A216C;
	#elif EDITOR
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
	UInt32 changeTypeCount = 55;
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

	_MESSAGE("*****************************************************************************************************");

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
	_MESSAGE("\n\n\n");
  
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

		if (i && CI && CI->eval && (kNVSEOpcodeTest>i || (kNVSEOpcodeTest+16-1)<i))
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
	_MESSAGE("*****************************************************************************************************");
	return true;
}

void MessageHandler(NVSEMessagingInterface::Message* msg)
{
	switch (msg->type)
	{
		case NVSEMessagingInterface::kMessage_PostPostLoad:
			_MESSAGE("Received post post load message");  // So all possible functions are declared now
			DoTheWork();
			break;
  }
}

extern "C" {

bool NVSEPlugin_Query(const NVSEInterface * nvse, PluginInfo * info)
{
	// fill out the info structure
	info->infoVersion = PluginInfo::kInfoVersion;
	info->name = "nvse_plugin_xEdit";
	info->version = 2;

	// version checks
	if(nvse->nvseVersion < NVSE_VERSION_INTEGER)
	{
		_ERROR("NVSE version too old (got %08X expected at least %08X)", nvse->nvseVersion, NVSE_VERSION_INTEGER);
		return false;
	}

	if(!nvse->isEditor)
	{
		if(nvse->runtimeVersion < RUNTIME_VERSION_1_4_0_525)
		{
			_ERROR("incorrect runtime version (got %08X need at least %08X)", nvse->runtimeVersion, RUNTIME_VERSION_1_4_0_525);
			return false;
		}

#ifdef NOGORE
		if(!nvse->isNogore)
		{
			_ERROR("incorrect runtime edition (got %08X need %08X (nogore))", nvse->isNogore, 1);
			return false;
		}
#else
		if(nvse->isNogore)
		{
			_ERROR("incorrect runtime edition (got %08X need %08X (standard))", nvse->isNogore, 0);
			return false;
		}
#endif
	}
	else
	{
		if(nvse->editorVersion < CS_VERSION_1_4_0_518)
		{
			_ERROR("incorrect editor version (got %08X need at least %08X)", nvse->editorVersion, CS_VERSION_1_4_0_518);
			return false;
		}
#ifdef NOGORE
		_ERROR("Editor only uses standard edition, closing.");
		return false;
#endif
	}

	// version checks pass

	return true;
}

bool NVSEPlugin_Load(const NVSEInterface * nvse)
{
	g_pluginHandle = nvse->GetPluginHandle();

	// save the NVSEinterface in case we need it later
	SaveNVSE = (NVSEInterface *)nvse;
	SaveCT = (NVSECommandTableInterface *)nvse->QueryInterface(kInterface_CommandTable);
	SaveMsg = (NVSEMessagingInterface *)nvse->QueryInterface(kInterface_Messaging);
	SaveMsg->RegisterListener(g_pluginHandle, "NVSE", MessageHandler);
  
	return true;
}

};

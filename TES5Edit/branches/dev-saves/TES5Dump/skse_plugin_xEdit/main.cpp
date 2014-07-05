#include <string>
#include "common/IPrefix.h"
#include "skse/skse_version.h"
#include "skse/PluginAPI.h"
//#include "skse/CommandTable.h"
//#include "skse/GameAPI.h"
//#include "skse/ParamInfos.h"
//#include "skse/GameObjects.h"

IDebugLog		gLog("skse_plugin_xEdit.log");

PluginHandle	g_pluginHandle = kPluginHandle_Invalid;
SKSEInterface * SaveSKSE;

bool DoTheWork()
{
	#if RUNTIME_VERSION == RUNTIME_VERSION_1_9_32_0
		static const UInt32 s_doShowChangeFlagsName = 0x00675DB0;		// Skyrim 1.9.32: 00675DB0,					Fallout3: 006C9510	FalloutNV: 0x0083FEF0
		static const UInt32 s_ChangeToFormType = 0x012724C0;			// Skyrim: 012724C0							Fallout3: 00F6D1D0	FalloutNV: 0x011A2428
		static const UInt32 s_FormToChangeType = 0x01B2E4D0;			// after initialisation Skyrim: 01B2E4D0	Fallout3: 01079BD0	FalloutNV: 0x011DE360
		static const UInt32 s_RecordType = 0x0123F2C4;					// Skyrim: 0123F2C4							Fallout3: 00F4A74C	FalloutNV: 0x01187004
		static const UInt32 s_GlobalDataNames = 0x01272310;				// Skyrim: 01272310, 01272334, 01272370,	Fallout3: 00F6CED8	FalloutNV: 0x011A216C
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
	UInt32 changeTypeCount = 49;
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
  
extern "C" {

bool SKSEPlugin_Query(const SKSEInterface * skse, PluginInfo * info)
{
	// fill out the info structure
	info->infoVersion = PluginInfo::kInfoVersion;
	info->name = "skse_plugin_xEdit";
	info->version = 2;

	// version checks
	if(skse->skseVersion < SKSE_VERSION_INTEGER)
	{
		_ERROR("skse version too old (got %08X expected at least %08X)", skse->skseVersion, SKSE_VERSION_INTEGER);
		return false;
	}

	if(!skse->isEditor)
	{
		if(skse->runtimeVersion < RUNTIME_VERSION_1_9_32_0)
		{
			_ERROR("incorrect runtime version (got %08X need at least %08X)", skse->runtimeVersion, RUNTIME_VERSION_1_9_32_0);
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

bool SKSEPlugin_Load(const SKSEInterface * skse)
{
	g_pluginHandle = skse->GetPluginHandle();

	// save the SKSEinterface in cas we need it later
	SaveSKSE = (SKSEInterface *)skse;
	SaveCT = (NVSECommandTableInterface *)nvse->QueryInterface(kInterface_CommandTable);
	SaveMsg = (NVSEMessagingInterface *)nvse->QueryInterface(kInterface_Messaging);
	SaveMsg->RegisterListener(g_pluginHandle, "NVSE", MessageHandler);


	return true;
}

};

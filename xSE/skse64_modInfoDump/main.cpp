#include <shlobj.h>
#include "skse64/PluginAPI.h"
#include "skse64_common/skse_version.h"
#include "skse64_common/Relocation.h"
#include "skse64_common/SafeWrite.h"
#include "skse64/ScaleformValue.h"
#include "skse64/ScaleformCallbacks.h"
#include "skse64/ScaleformMovie.h"
#include "skse64/PapyrusVM.h"
#include "skse64/PapyrusNativeFunctions.h"
#include "skse64/GameAPI.h"
#include "skse64/GameData.h"
#include "skse64/ObScript.h"

// Store plugin log in My Games, differentiating between various builds
char pluginName[] = {"skse64_ModInfoDump_plugin"};
char pluginExt[] = {".log"};
char pluginLogPath[] = {"\\My Games\\Skyrim Special Edition\\SKSE\\"};
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
char DumpCommandName[] = "DumpModInfoList";

PluginHandle	g_pluginHandle = kPluginHandle_Invalid;

// Build the pluginLog name and open it
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

/**** work go here ****/

struct ModInfo_hlp		// referred to by game as TESFile
{
	ModInfo_hlp();
	~ModInfo_hlp();

	// 18 info about currently loading form
	struct FormInfo
	{
		UInt32		recordType;			// 00 i.e. 'FACT', 'GMST'
		UInt32		unk04;				// 04 looks like size of entire record
		UInt32		formFlags;			// 08 copied to TESForm->flags
		UInt32		formID;				// 0C 
		UInt32		unk10;				// 10
		UInt16		unk14;				// 14 always initialized to 0F on SaveForm. 
		UInt16		unk16;
	};

	UInt32								unk000;				// 000
	UInt8								unk004[0xC];		// 004
	UInt32 /*NiTPointerMap<TESFile*>*/	* pointerMap;		// 010   CHECK
	UInt64								unk018[2];			// 018
	UInt8								unk028;				// 028
	UInt8								unk029;				// 029
	UInt8								pad02A[6];			// 029
	UInt64								unk030;				// 030
	BSFile*								unkFile;			// 038
	UInt64								unk040[3];			// 040
	char								name[0x104];		// 058
	char								filepath[0x104];	// 15C
	void*								unk260;				// 260 
	UInt32								unk268;				// 268 - init'd to ctor arg(0x800) or 0x10000 if arg is 0
	UInt32								unk26C;				// 26C
	UInt32								unk270;				// 270
	UInt32								unk274;				// 274 - pad?
	UInt64								unk278;				// 278
	UInt32								unk280;				// 280
	FormInfo							formInfo;			// 284 
	ChunkHeader							subRecord;			// 29C
	UInt32								unk2A4;				// 2A4
	UInt32								fileOffset;			// 2A8
	UInt32								dataOffset;			// 2AC index into dataBuf
	UInt32								subrecordBytesRead;	// 2B0 generates error on Read if != expected length
	UInt8								unk2B4[0x2D8 - 0x2B4];	// 2B4
	UInt64								unk2D8;				// 2D8
	UInt64								unk2E0;				// 2E0
	UInt8								unk2E8;				// 2E8
	UInt8								bIsBigEndian;		// 2E9
	UInt8								unk2EA;				// 2EA
	UInt8								pad2EB;				// 2EB
	WIN32_FIND_DATA						fileData;			// 2EC
	float								unk42C;				// 42C init'd to 0.94
	UInt32								unk430;				// 430
	UInt32								flags;				// 434 init'd to 0x00000800. 4000 and 40000 do stuff
	UInt8								unk438;				// 438
	UInt8								pad439[7];			// 439
	void*								unk440;				// 440
	void*								unk448;				// 448
	void*								unk450;				// 450
	void*								unk458;				// 458
	UInt32								numRefMods;			// 460 related to modindex; see 4472D0
															// formIDs in mod are as saved in GECK, must fix up at runtime
	UInt32								pad464;
	ModInfo								** refModInfo;		// 468 used to look up modInfo based on fixed mod index, double-check 
	UInt32								unk470;				// 470
	UInt32								unk474;				// 474
	UInt8								modIndex;			// 478 init to 0xFF
	UInt8								pad479[1];			// 479
	UInt16								eslIndex;			// 47A init to 0xFF
	UInt8								pad47C[4];			// 47C
	BSString							author;				// 480
	BSString							description;		// 490
	void								* dataBuf;			// 4A0 
	UInt32								unk4A8;				// 4A8 looks like size of entire record
	UInt32								pad4AC;				// 4AC
	void								* unk4B0;			// 4B0
	UInt32								unk4B8;				// 4B8
	UInt32								pad4BC;				// 4BC
	void								* unk4C0;			// 4C0

	bool IsLoaded() const { return true; }
};

STATIC_ASSERT(offsetof(ModInfo_hlp, formInfo) == 0x284);
STATIC_ASSERT(offsetof(ModInfo_hlp, subRecord) == 0x29C);
STATIC_ASSERT(offsetof(ModInfo_hlp, fileOffset) == 0x2A8);
STATIC_ASSERT(offsetof(ModInfo_hlp, fileData) == 0x2EC);
STATIC_ASSERT(offsetof(ModInfo_hlp, numRefMods) == 0x460);
STATIC_ASSERT(offsetof(ModInfo_hlp, author) == 0x480);
STATIC_ASSERT(sizeof(ModInfo_hlp) == 0x4C8);

bool DoWork(void)
{
	_MESSAGE("Dumping DataHandler::modInfoList\n"); 
	DataHandler* theDH = *g_dataHandler.GetPtr();
	UInt64 loadOrder = 0;
	gLog.Indent();
	_MESSAGE("LoadOrder\tPath\tName\tModIndex\tEslIndex"); 
	for (tList<ModInfo>::Iterator modInfo = theDH->modList.modInfoList.Begin(); !modInfo.End(); ++modInfo)
	{
		ModInfo_hlp * m = (ModInfo_hlp *)(modInfo.Get());
		_MESSAGE("LoadOrder=%04d\tPath='%s'\tname='%s'\tmodIndex=%d\teslIndex=%d.", loadOrder, m->filepath, m->name, m->modIndex, m->eslIndex);
		loadOrder += 1;
	}
	_MESSAGE("\n"); 
	gLog.Outdent();
	gLog.Indent();
	_MESSAGE("Standard Mods:"); 
	for (UInt32 i = 0; i < theDH->modList.loadedMods.count; i++)
	{
		ModInfo * modInfo = theDH->modList.loadedMods[i];
		ModInfo_hlp * m = (ModInfo_hlp *)(modInfo);
		_MESSAGE("LoadOrder=%04d\tPath='%s'\tname='%s'.", m->modIndex, m->filepath, m->name);
	loadOrder += 1;
	}
	_MESSAGE("\n"); 
	gLog.Outdent();
	gLog.Indent();
	_MESSAGE("Light Mods:"); 
	for (UInt32 i = 0; i < theDH->modList.loadedCCMods.count; i++)
	{
		ModInfo * modInfo = theDH->modList.loadedCCMods[i];
		ModInfo_hlp * m = (ModInfo_hlp *)(modInfo);
		_MESSAGE("LoadOrder=%04d\tPath='%s'\tname='%s'.", m->modIndex, m->filepath, m->name);
		loadOrder += 1;
	}
	_MESSAGE("\n"); 
	gLog.Outdent();
	return true;
}

// currently ToggleSafeZone
static ObScriptCommand * s_hijackedCommand = nullptr;

void Dump_ObScript_Init()
{
	// instead of hooking the entire classic scripting system, we're just hijacking some unused commands. Let's find one without an execute routine

	for(ObScriptCommand * iter = g_firstConsoleCommand; iter->opcode < (kObScript_NumConsoleCommands+kObScript_ConsoleOpBase); ++iter)
	{
		if(!strcmp(iter->longName, "ToggleSafeZone"))
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

#define COMMAND_ARGS void * paramInfo, void * scriptData, TESObjectREFR * thisObj, void * containingObj, void * scriptObj, void * locals, double * result, void * opcodeOffsetPtr

bool DumpCommand_Execute(COMMAND_ARGS)
{
	return DoWork();
}

void Dump_ObScript_Commit()
{
	if (s_hijackedCommand)
	{
		ObScriptCommand cmd = *s_hijackedCommand;

		cmd.longName = DumpCommandName;
		cmd.shortName = "";
		cmd.helpText = "";
		cmd.needsParent = 0;
		cmd.numParams = 0;
		cmd.execute = DumpCommand_Execute;
		cmd.flags = 0;

		SafeWriteBuf((uintptr_t)s_hijackedCommand, &cmd, sizeof(cmd));
		_MESSAGE("Dump console command '%s' installed as 0x%08x", s_hijackedCommand->longName, s_hijackedCommand->opcode);
	}
}

extern "C"
{

  bool SKSEPlugin_Query(const SKSEInterface * skse, PluginInfo * info)
  {

    OpenPluginLog();

    _MESSAGE(pluginName);

    // populate info structure
    info->infoVersion =	PluginInfo::kInfoVersion;
    info->name =		"Dump ModInfoList plugin";
    info->version =		1;

    // store plugin handle so we can identify ourselves later
    g_pluginHandle = skse->GetPluginHandle();

    if(skse->isEditor)
    {
      _MESSAGE("loaded in editor, marking as incompatible");

      return false;
    }
    else if(skse->runtimeVersion != RUNTIME_VERSION_1_5_23)
    {
      _MESSAGE("unsupported runtime version %08X (expected %08X)", skse->runtimeVersion, RUNTIME_VERSION_1_5_23);

      return false;
    }

    // ### do not do anything else in this callback
    // ### only fill out PluginInfo and return true/false

    // supported runtime version
    return true;
  }

  bool SKSEPlugin_Load(const SKSEInterface * skse)
  {
    _MESSAGE("%s load", pluginName);

    Dump_ObScript_Init();
    Dump_ObScript_Commit();

    return true;
  }

};

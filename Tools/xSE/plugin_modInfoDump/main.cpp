#include <shlobj.h>
#include "f4se/PluginAPI.h"
#include "f4se_common/f4se_version.h"
#include "f4se_common/Relocation.h"
#include "f4se_common/SafeWrite.h"
#include "f4se/ScaleformValue.h"
#include "f4se/ScaleformCallbacks.h"
#include "f4se/ScaleformMovie.h"
#include "f4se/PapyrusVM.h"
#include "f4se/PapyrusNativeFunctions.h"
#include "f4se/GameAPI.h"
#include "f4se/GameData.h"
#include "f4se/ObScript.h"

// Store plugin log in My Games, differentiating between various builds
char pluginName[] = {"f4se_ModInfoDump_plugin"};
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
char DumpCommandName[] = "DumpModInfoList";

PluginHandle	g_pluginHandle = kPluginHandle_Invalid;

F4SEScaleformInterface		* g_scaleform = NULL;
F4SEPapyrusInterface		* g_papyrus = NULL;
F4SESerializationInterface	* g_serialization = NULL;

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

bool DoWork(void)
{
	_MESSAGE("Dumping DataHandler::modInfoList\n"); 
	DataHandler* theDH = *g_dataHandler.GetPtr();
	UInt64 loadOrder = 0;
	gLog.Indent();
	_MESSAGE("LoadOrder\tPath\tName\tModIndex\tEslIndex"); 
	for (tList<ModInfo>::Iterator modInfo = theDH->modList.modInfoList.Begin(); !modInfo.End(); ++modInfo)
	{
		_MESSAGE("LoadOrder=%d\tPath='%s'\tname='%s'\tmodIndex=%d\teslIndex=%d.", loadOrder, modInfo->directory, modInfo->name, modInfo->modIndex, modInfo->eslIndex); 
		loadOrder += 1;
	}
	_MESSAGE("\n"); 
	gLog.Outdent();
	gLog.Indent();
	_MESSAGE("Standard Mods:"); 
	for (UInt32 i = 0; i < theDH->modList.loadedMods.count; i++)
	{
		ModInfo * modInfo = theDH->modList.loadedMods[i];
		_MESSAGE("LoadOrder=%d\tPath='%s'\tname='%s'.", modInfo->modIndex, modInfo->directory, modInfo->name); 
	loadOrder += 1;
	}
	_MESSAGE("\n"); 
	gLog.Outdent();
	gLog.Indent();
	_MESSAGE("Light Mods:"); 
	for (UInt32 i = 0; i < theDH->modList.lightMods.count; i++)
	{
		ModInfo * modInfo = theDH->modList.lightMods[i];
		_MESSAGE("LoadOrder=%d\tPath='%s'\tname='%s'.", modInfo->eslIndex, modInfo->directory, modInfo->name); 
		loadOrder += 1;
	}
	_MESSAGE("\n"); 
	gLog.Outdent();
	return true;
}

// currently ToggleESRAM
static ObScriptCommand * s_hijackedCommand = nullptr;

void Dump_ObScript_Init()
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

bool F4SEPlugin_Query(const F4SEInterface * f4se, PluginInfo * info)
{

	OpenPluginLog();

	_MESSAGE(pluginName);

	// populate info structure
	info->infoVersion =	PluginInfo::kInfoVersion;
	info->name =		"Dump ModInfoList plugin";
	info->version =		1;

	// store plugin handle so we can identify ourselves later
	g_pluginHandle = f4se->GetPluginHandle();

	if(f4se->isEditor)
	{
		_MESSAGE("loaded in editor, marking as incompatible");

		return false;
	}
	else if(f4se->runtimeVersion != RUNTIME_VERSION_1_10_98)
	{
		_MESSAGE("unsupported runtime version %08X (expected %08X)", f4se->runtimeVersion, RUNTIME_VERSION_1_10_89);

		return false;
	}

	// ### do not do anything else in this callback
	// ### only fill out PluginInfo and return true/false

	// supported runtime version
	return true;
}

bool F4SEPlugin_Load(const F4SEInterface * f4se)
{
	_MESSAGE("%s load", pluginName);

	Dump_ObScript_Init();
	Dump_ObScript_Commit();

	return true;
}

};

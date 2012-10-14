/*===========================================================================
 *
 * File:		Srmoddefs.CPP
 * Author:		Dave Humphrey (dave@uesp.net)
 * Created On:	3 December 2011
 *
 * Description
 *
 *=========================================================================*/

	/* Include Files */
#include "srfunctions.h"
#include "srrecordhandler.h"


/*===========================================================================
 *
 * Begin Function Parameter Type String Table
 *
 * Exported from the original TESV.exe file on 3 December 2011. At some point
 * this probably should be in an external config file that is loaded at
 * program startup to permit changes and custom functions to be easily used.
 *
 *=========================================================================*/
srfunction_t g_SrFunctions[] =
{
	 { 0x0000, "GameMode",                         "",                     0x02000000, "", 0, { } }, 
     { 0x0001, "MenuMode",                         "",                     0x22000000, "", 1, {
               { 0x0001, 1 },  } }, 
     { 0x0002, "OnActivate",                       "",                     0x03000000, "", 1, {
               { 0x0006, 1 },  } }, 
     { 0x0003, "OnAdd",                            "",                     0x03000000, "", 1, {
               { 0x001A, 1 },  } }, 
     { 0x0004, "OnEquip",                          "",                     0x03000000, "", 1, {
               { 0x001A, 1 },  } }, 
     { 0x0005, "OnUnequip",                        "",                     0x03000000, "", 1, {
               { 0x001A, 1 },  } }, 
     { 0x0006, "OnDrop",                           "",                     0x03000000, "", 1, {
               { 0x001A, 1 },  } }, 
     { 0x0007, "SayToDone",                        "",                     0x03000000, "", 1, {
               { 0x000D, 1 },  } }, 
     { 0x0008, "OnHit",                            "",                     0x03000000, "", 1, {
               { 0x0006, 1 },  } }, 
     { 0x0009, "OnHitWith",                        "",                     0x03000000, "", 1, {
               { 0x0035, 1 },  } }, 
     { 0x000A, "OnDeath",                          "",                     0x03000000, "", 1, {
               { 0x0006, 1 },  } }, 
     { 0x000B, "OnMurder",                         "",                     0x03000000, "", 1, {
               { 0x0006, 1 },  } }, 
     { 0x000C, "OnCombatEnd",                      "",                     0x03000000, "", 0, { } }, 
     { 0x000D, "Unused",                           "",                     0x03000000, "", 0, { } }, 
     { 0x000E, "Unused2",                          "",                     0x03000000, "", 0, { } }, 
     { 0x000F, "OnPackageStart",                   "",                     0x03000000, "", 1, {
               { 0x001D, 0 },  } }, 
     { 0x0010, "OnPackageDone",                    "OnPackageEnd",         0x03000000, "", 1, {
               { 0x001D, 0 },  } }, 
     { 0x0011, "ScriptEffectStart",                "",                     0x03000000, "", 0, { } }, 
     { 0x0012, "ScriptEffectFinish",               "",                     0x03000000, "", 0, { } }, 
     { 0x0013, "ScriptEffectUpdate",               "",                     0x03000000, "", 0, { } }, 
     { 0x0014, "OnPackageChange",                  "",                     0x03000000, "", 1, {
               { 0x001D, 0 },  } }, 
     { 0x0015, "OnLoad",                           "",                     0x03000000, "", 0, { } }, 
     { 0x0016, "OnMagicEffectHit",                 "",                     0x03000000, "", 1, {
               { 0x001F, 1 },  } }, 
     { 0x0017, "OnSell",                           "",                     0x03000000, "", 1, {
               { 0x0006, 1 },  } }, 
     { 0x0018, "OnTrigger",                        "",                     0x03000000, "", 1, {
               { 0x0004, 1 },  } }, 
     { 0x0019, "OnStartCombat",                    "",                     0x03000000, "", 1, {
               { 0x0006, 1 },  } }, 
     { 0x001A, "OnTriggerEnter",                   "",                     0x03000000, "", 1, {
               { 0x0004, 1 },  } }, 
     { 0x001B, "OnTriggerLeave",                   "",                     0x03000000, "", 1, {
               { 0x0004, 1 },  } }, 
     { 0x001C, "OnActorEquip",                     "",                     0x03000000, "", 1, {
               { 0x0015, 0 },  } }, 
     { 0x001D, "OnActorUnequip",                   "",                     0x03000000, "", 1, {
               { 0x0015, 0 },  } }, 
     { 0x001E, "OnReset",                          "",                     0x03000000, "", 0, { } }, 
     { 0x001F, "OnOpen",                           "",                     0x03000000, "", 0, { } }, 
     { 0x0020, "OnClose",                          "",                     0x03000000, "", 0, { } }, 
     { 0x0021, "OnGrab",                           "",                     0x03000000, "", 0, { } }, 
     { 0x0022, "OnRelease",                        "",                     0x03000000, "", 0, { } }, 
     { 0x0023, "OnDestructionStageChange",         "",                     0x03000000, "", 1, {
               { 0x0001, 1 },  } }, 

     { 0x0100, "Show",                             "TST",                  0x04000000, "Show global scripts and variables.", 1, {
               { 0x0002, 0 },  } }, 
     { 0x0101, "ShowVars",                         "SV",                   0x05000000, "Show variables on object. [player->sv]", 0, { } }, 
     { 0x0102, "ShowGlobalVars",                   "SGLV",                 0x04000000, "Show all global variables.", 0, { } }, 
     { 0x0103, "ShowQuestVars",                    "SQV",                  0x04000000, "Show quest variables. [svq QuestID]", 1, {
               { 0x000E, 0 },  } }, 
     { 0x0104, "ShowQuests",                       "SQ",                   0x04000000, "List quests.", 0, { } }, 
     { 0x0105, "ShowQuestAliases",                 "",                     0x04000000, "Show quest aliases. [ShowQuestAliases QuestID]", 1, {
               { 0x000E, 0 },  } }, 
     { 0x0106, "SetPapyrusQuestVar",               "SETPQV",               0x04000000, "Set a Papyrus property on the specified quest.", 3, {
               { 0x000E, 0 }, 
               { 0x0000, 0 }, 
               { 0x0000, 0 },  } }, 
     { 0x0107, "SetPapyrusVar",                    "SETPV",                0x04000000, "Set a Papyrus property on the selected ref.", 2, {
               { 0x0000, 0 }, 
               { 0x0000, 0 },  } }, 
     { 0x0108, "SetQuestAliases",                  "",                     0x04000000, "Set quest aliases. [SetQuestAliases QuestID]", 1, {
               { 0x000E, 0 },  } }, 
     { 0x0109, "ClearQuestAliases",                "",                     0x04000000, "Clears quest aliases. [ClearQuestAliases QuestID]", 1, {
               { 0x000E, 0 },  } }, 
     { 0x010A, "ToggleCombatStats",                "TCS",                  0x04000000, "", 0, { } }, 
     { 0x010B, "ToggleSafeZone",                   "TSZ",                  0x04000000, "Display the television 85%% safe zone.", 0, { } }, 
     { 0x010C, "ToggleAI",                         "TAI",                  0x04000000, "", 1, {
               { 0x0006, 1 },  } }, 
     { 0x010D, "ToggleCollisionGeometry",          "TCG",                  0x04000000, "Show collision geometry.", 0, { } }, 
     { 0x010E, "ToggleMaterialGeometry",           "TMG",                  0x04000000, "Show material geometry.", 0, { } }, 
     { 0x010F, "ToggleStairsGeometry",             "TSG",                  0x04000000, "Show stairs geometry.", 0, { } }, 
     { 0x0110, "ToggleBorders",                    "TB",                   0x04000000, "Show border lines for each cell.", 0, { } }, 
     { 0x0111, "ToggleSky",                        "TS",                   0x04000000, "", 0, { } }, 
     { 0x0112, "ToggleWireframe",                  "TWF",                  0x04000000, "Show the world as wireframe.", 0, { } }, 
     { 0x0113, "ToggleCollision",                  "TCL",                  0x04000000, "", 0, { } }, 
     { 0x0114, "ToggleDebugText",                  "TDT",                  0x04000000, "Show debug numbers on the screen.", 0, { } }, 
     { 0x0115, "ToggleMenus",                      "TM",                   0x04000000, "Hide all the menus. Used for taking screen shots.", 0, { } }, 
     { 0x0116, "TogglePrimitives",                 "TPR",                  0x04000000, "", 0, { } }, 
     { 0x0117, "ShowScenegraph",                   "SSG",                  0x04000000, "Create a window with the full game scene graph or the scene graph of the selected reference.", 0, { } }, 
     { 0x0118, "ShowScenegraph",                   "SFSG",                 0x04000000, "Create a window with the full game scene graph, open to the node corresponding to the selected reference (if any).", 0, { } }, 
     { 0x0119, "ToggleMagicStats",                 "TMS",                  0x04000000, "", 0, { } }, 
     { 0x011A, "ShowAnim",                         "SA",                   0x05000000, "Show Animation and Actor status.", 0, { } }, 
     { 0x011B, "Show1stPerson",                    "S1ST",                 0x04000000, "Show the 1st person Model from the 3rd person camera. If in 3rd person mode it will show both.", 0, { } }, 
     { 0x011C, "Help",                             "",                     0x04000000, "Show this help.", 2, {
               { 0x0000, 1 }, 
               { 0x0001, 1 },  } }, 
     { 0x011D, "ToggleNavMesh",                    "TNM",                  0x04000000, "Toggle blocked display.", 1, {
               { 0x0001, 1 },  } }, 
     { 0x011E, "TogglePathLine",                   "TPL",                  0x04000000, "Toggle path display.", 1, {
               { 0x0000, 1 },  } }, 
     { 0x011F, "PickRefByID",                      "PRID",                 0x04000000, "Select a reference by id for the console.", 1, {
               { 0x0004, 0 },  } }, 
     { 0x0120, "SetLightingPasses",                "SLP",                  0x04000000, "4 (0/1) values. amb|diff|tex|spec ex: 1010", 1, {
               { 0x0000, 0 },  } }, 
     { 0x0121, "ToggleLODLand",                    "TLL",                  0x04000000, "", 4, {
               { 0x0000, 1 }, 
               { 0x0000, 1 }, 
               { 0x0000, 1 }, 
               { 0x0000, 1 },  } }, 
     { 0x0122, "ToggleMapEffect",                  "TME",                  0x04000000, "", 1, {
               { 0x0000, 1 },  } }, 
     { 0x0123, "SetLODObjectDistance",             "SLOD",                 0x04000000, "", 4, {
               { 0x0002, 0 }, 
               { 0x0002, 0 }, 
               { 0x0002, 0 }, 
               { 0x0002, 0 },  } }, 
     { 0x0124, "ToggleGrassUpdate",                "TGU",                  0x04000000, "", 0, { } }, 
     { 0x0125, "CenterOnCell",                     "COC",                  0x04000000, "", 1, {
               { 0x0000, 0 },  } }, 
     { 0x0126, "SetGameSetting",                   "SetGS",                0x04000000, "", 2, {
               { 0x0000, 0 }, 
               { 0x0000, 0 },  } }, 
     { 0x0127, "SetINISetting",                    "SetINI",               0x04000000, "'setting:category' value", 2, {
               { 0x0000, 0 }, 
               { 0x0000, 0 },  } }, 
     { 0x0128, "GetINISetting",                    "GetINI",               0x04000000, "'setting:category'", 1, {
               { 0x0000, 0 },  } }, 
     { 0x0129, "CenterOnExterior",                 "COE",                  0x04000000, "", 2, {
               { 0x0001, 0 }, 
               { 0x0001, 0 },  } }, 
     { 0x012A, "CalcPathToPoint",                  "P2P",                  0x05000000, "", 0, { } }, 
     { 0x012B, "CalcLowPathToPoint",               "LP2P",                 0x05000000, "ignore locks, allow disabled doors, ignore min use", 3, {
               { 0x0001, 0 }, 
               { 0x0001, 0 }, 
               { 0x0001, 0 },  } }, 
     { 0x012C, "SetFog",                           "",                     0x04000000, "2 floats, start and end depths", 2, {
               { 0x0001, 0 }, 
               { 0x0001, 0 },  } }, 
     { 0x012D, "SetClipDist",                      "",                     0x04000000, "float, new clip distance", 1, {
               { 0x0002, 0 },  } }, 
     { 0x012E, "ToggleShadowVolumes",              "TSV",                  0x04000000, "", 0, { } }, 
     { 0x012F, "SetImageSpaceGlow",                "SISG",                 0x04000000, "", 4, {
               { 0x0001, 0 }, 
               { 0x0002, 0 }, 
               { 0x0002, 0 }, 
               { 0x0002, 0 },  } }, 
     { 0x0130, "ToggleDetection",                  "TDETECT",              0x04000000, "", 0, { } }, 
     { 0x0131, "ToggleHighProcess",                "THIGHPROCESS",         0x04000000, "", 0, { } }, 
     { 0x0132, "ToggleLowProcess",                 "TLOWPROCESS",          0x04000000, "", 0, { } }, 
     { 0x0133, "ToggleMiddleLowProcess",           "TMLOWPROCESS",         0x04000000, "", 0, { } }, 
     { 0x0134, "ToggleMiddleHighProcess",          "TMHIGHPROCESS",        0x04000000, "", 0, { } }, 
     { 0x0135, "ToggleAiSchedules",                "TAIS",                 0x04000000, "", 0, { } }, 
     { 0x0136, "SpeakSound",                       "",                     0x05000000, "", 3, {
               { 0x0000, 0 }, 
               { 0x0001, 1 }, 
               { 0x0001, 1 },  } }, 
     { 0x0137, "BetaComment",                      "BC",                   0x04000000, "Add comment to [General] 'sBetaCommentFile' file.   NOTE: select object first.   [bc 'This rock is too high.']", 1, {
               { 0x0000, 0 },  } }, 
     { 0x0138, "GameComment",                      "GC",                   0x04000000, "Adds a comment about the game to the GameCommentDB. (Ex. This monster is too hard)", 1, {
               { 0x0000, 0 },  } }, 
     { 0x0139, "ToggleCellNode",                   "TCN",                  0x04000000, "Toggle 3D for a Cell child node: 0-Actor, 1-Marker, 2-Land, 3-Water, 4-Static, 5-Active", 1, {
               { 0x0001, 0 },  } }, 
     { 0x013A, "ToggleTrees",                      "TT",                   0x04000000, "Turn trees on/off", 0, { } }, 
     { 0x013B, "SetCameraFOV",                     "FOV",                  0x04000000, "Change the camera's field of view (in deg): default 75", 2, {
               { 0x0002, 1 }, 
               { 0x0002, 1 },  } }, 
     { 0x013C, "ToggleGodMode",                    "TGM",                  0x04000000, "Toggle God mode", 0, { } }, 
     { 0x013D, "RefreshShaders",                   "RS",                   0x04000000, "Reload HLSL shaders from disk", 1, {
               { 0x0000, 1 },  } }, 
     { 0x013E, "ToggleScripts",                    "TSCR",                 0x04000000, "Turn Script processing on/off", 0, { } }, 
     { 0x013F, "ToggleConversations",              "TCONV",                0x04000000, "Toggle conversation stats", 0, { } }, 
     { 0x0140, "ToggleFullHelp",                   "TFH",                  0x04000000, "Toggle Full Help", 0, { } }, 
     { 0x0141, "ShowQuestLog",                     "SQL",                  0x04000000, "Show Quest Log", 1, {
               { 0x0001, 1 },  } }, 
     { 0x0142, "ShowFullQuestLog",                 "SFQL",                 0x04000000, "Show all log entries for a single quest", 1, {
               { 0x000E, 0 },  } }, 
     { 0x0143, "DumpTexturePalette",               "DTP",                  0x04000000, "Dump texture palette contents to file  param is sort type   f-filename, s-size, c-count)", 1, {
               { 0x0000, 1 },  } }, 
     { 0x0144, "DumpModelMap",                     "DMM",                  0x04000000, "Dump model map contents to file", 1, {
               { 0x0000, 1 },  } }, 
     { 0x0145, "CenterOnWorld",                    "COW",                  0x04000000, "[COW worldname -10 5]", 3, {
               { 0x001B, 0 }, 
               { 0x0001, 0 }, 
               { 0x0001, 0 },  } }, 
     { 0x0146, "ToggleGrass",                      "TG",                   0x04000000, "Toggle grass display.", 0, { } }, 
     { 0x0147, "CreateGrassAt",                    "cga",                  0x04000000, "", 2, {
               { 0x0002, 0 }, 
               { 0x0002, 0 },  } }, 
     { 0x0148, "AddFaceAnimNote",                  "AFAN",                 0x05000000, "", 1, {
               { 0x0000, 0 },  } }, 
     { 0x0149, "RefreshINI",                       "REFINI",               0x04000000, "Refresh INI settings from file.", 0, { } }, 
     { 0x014A, "ToggleEmotions",                   "temo",                 0x04000000, "Toggle NPC facial emotions.", 0, { } }, 
     { 0x014B, "AddDecal",                         "",                     0x04000000, "", 0, { } }, 
     { 0x014C, "TestCode",                         "",                     0x04000000, "", 2, {
               { 0x0002, 1 }, 
               { 0x0002, 1 },  } }, 
     { 0x014D, "PlayerSpellBook",                  "psb",                  0x04000000, "Add all spells to player.", 0, { } }, 
     { 0x014E, "PrintAiList",                      "pai",                  0x04000000, "Printed Ai Lists.", 0, { } }, 
     { 0x014F, "ShowQuestTargets",                 "SQT",                  0x04000000, "Show current quest targets", 0, { } }, 
     { 0x0150, "HairTint",                         "",                     0x04000000, "3 ints, RGB", 3, {
               { 0x0001, 0 }, 
               { 0x0001, 0 }, 
               { 0x0001, 0 },  } }, 
     { 0x0151, "SaveGame",                         "save",                 0x04000000, "SaveGame <filename>", 5, {
               { 0x0000, 0 }, 
               { 0x0001, 1 }, 
               { 0x0001, 1 }, 
               { 0x0001, 1 }, 
               { 0x0001, 1 },  } }, 
     { 0x0152, "LoadGame",                         "load",                 0x04000000, "LoadGame <filename>", 5, {
               { 0x0000, 0 }, 
               { 0x0001, 1 }, 
               { 0x0001, 1 }, 
               { 0x0001, 1 }, 
               { 0x0001, 1 },  } }, 
     { 0x0153, "TestAllCells",                     "TAC",                  0x04000000, "Test All Cells (0 - stop, 1 - start, 2 - interiors, 3 - current world)", 1, {
               { 0x0001, 0 },  } }, 
     { 0x0154, "RenderTestCell",                   "rtc",                  0x04000000, "runs Render Test on player's current parent cell", 0, { } }, 
     { 0x0155, "RenderTestHere",                   "rth",                  0x04000000, "runs Render Test on player's current position", 0, { } }, 
     { 0x0156, "SaveWorld",                        "",                     0x04000000, "Save hkWorld <filename>", 1, {
               { 0x0000, 0 },  } }, 
     { 0x0157, "ReloadCurrentClimate",             "rcc",                  0x04000000, "Reloads values from the current climate", 0, { } }, 
     { 0x0158, "ReloadCurrentWeather",             "rcw",                  0x04000000, "Reloads values from the current weather", 0, { } }, 
     { 0x0159, "TestSeenData",                     "tsd",                  0x04000000, "Visually displays the current seen data", 0, { } }, 
     { 0x015A, "TestLocalMap",                     "tlm",                  0x04000000, "Simulates the local map. (1 or 0 for FOW on or off)", 1, {
               { 0x0001, 0 },  } }, 
     { 0x015B, "MoveToQuestTarget",                "movetoqt",             0x04000000, "Move player to current quest target.", 2, {
               { 0x000E, 0 }, 
               { 0x0001, 1 },  } }, 
     { 0x015C, "PrintNPCDialog",                   "pdialog",              0x04000000, "Prints NPC dialog", 0, { } }, 
     { 0x015D, "ShowSubtitle",                     "",                     0x04000000, "show all dialog subtitles (1 shows always, 0 hides always)", 1, {
               { 0x0001, 1 },  } }, 
     { 0x015E, "ShowRenderPasses",                 "srp",                  0x04000000, "display render passes for the next frame", 0, { } }, 
     { 0x015F, "FreezeRenderAccumulation",         "fra",                  0x04000000, "only re-render geometry visible during this frame", 0, { } }, 
     { 0x0160, "ToggleOcclusion",                  "tocc",                 0x04000000, "toggle occlusion query for geometry", 0, { } }, 
     { 0x0161, "OutputMemContexts",                "omc",                  0x04000000, "Output Mem Context info to a file", 1, {
               { 0x0000, 1 },  } }, 
     { 0x0162, "OutputMemStats",                   "oms",                  0x04000000, "Output Mem Stats info to a file", 1, {
               { 0x0000, 1 },  } }, 
     { 0x0163, "SetMemCheckPoint",                 "smcp",                 0x04000000, "Set the current memory checkpoint (value, optional context name)", 2, {
               { 0x0001, 0 }, 
               { 0x0000, 1 },  } }, 
     { 0x0164, "GetMemCheckPoint",                 "gmcp",                 0x04000000, "Get the current memory checkpoint (optional context name)", 1, {
               { 0x0000, 1 },  } }, 
     { 0x0165, "IncMemCheckPoint",                 "imcp",                 0x04000000, "Increment the current memory checkpoint (optional context name)", 1, {
               { 0x0000, 1 },  } }, 
     { 0x0166, "OutputAllocations",                "outalloc",             0x04000000, "Output memory allocations (file, optional context name, optional start context, optional end context)", 4, {
               { 0x0000, 0 }, 
               { 0x0000, 1 }, 
               { 0x0001, 1 }, 
               { 0x0001, 1 },  } }, 
     { 0x0167, "AddWatchAddress",                  "awa",                  0x04000000, "Adds an address range to watch out for.", 2, {
               { 0x0000, 0 }, 
               { 0x0001, 0 },  } }, 
     { 0x0168, "RemoveWatchAddress",               "rwa",                  0x04000000, "Removes an address range that we no longer want to watch.", 1, {
               { 0x0000, 0 },  } }, 
     { 0x0169, "ToggleDetectionStats",             "tds",                  0x04000000, "Show the detection stats of the current seletected Ref.", 1, {
               { 0x0006, 1 },  } }, 
     { 0x016A, "SetTargetRefraction",              "str",                  0x04000000, "Sets the refractive value of the target", 1, {
               { 0x0002, 0 },  } }, 
     { 0x016B, "SetTargetRefractionFire",          "strf",                 0x04000000, "Sets the refractive fire value of the target", 2, {
               { 0x0002, 0 }, 
               { 0x0001, 0 },  } }, 
     { 0x016C, "ToggleRefractionDebug",            "trd",                  0x04000000, "Toggles refraction debug render texture", 0, { } }, 
     { 0x016D, "ToggleCharControllerShape",        "TCCS",                 0x04000000, "Toggle char controller shape type.", 0, { } }, 
     { 0x016E, "ShowHeadTrackTarget",              "SHeadT",               0x05000000, "Show the head track target if set from look function", 0, { } }, 
     { 0x016F, "SetCinematicParam",                "SCP",                  0x04000000, "Sets various values for the imagespace cinematics", 3, {
               { 0x0002, 0 }, 
               { 0x0002, 0 }, 
               { 0x0002, 0 },  } }, 
     { 0x0170, "SetTintParam",                     "STP",                  0x04000000, "Sets various values for the imagespace tint", 4, {
               { 0x0002, 0 }, 
               { 0x0002, 0 }, 
               { 0x0002, 0 }, 
               { 0x0002, 0 },  } }, 
     { 0x0171, "SetHDRParam",                      "SHP",                  0x04000000, "Sets various values for the HDR shader", 9, {
               { 0x0002, 0 }, 
               { 0x0002, 0 }, 
               { 0x0002, 0 }, 
               { 0x0002, 0 }, 
               { 0x0002, 0 }, 
               { 0x0002, 0 }, 
               { 0x0002, 0 }, 
               { 0x0002, 0 }, 
               { 0x0002, 0 },  } }, 
     { 0x0172, "VisualRefPosition",                "VRP",                  0x05000000, "Places and axis object at the ref position.", 0, { } }, 
     { 0x0173, "ShowPivot",                        "SP",                   0x05000000, "Puts a temporary yellow plus at the pivot point of the selected reference.", 0, { } }, 
     { 0x0174, "PrintHDRParam",                    "PHP",                  0x04000000, "Prints current HDR settings.", 0, { } }, 
     { 0x0175, "ToggleHDRDebug",                   "THD",                  0x04000000, "Toggles HDR debug textures.", 0, { } }, 
     { 0x0176, "RevertWorld",                      "rw",                   0x04000000, "Revert the world", 0, { } }, 
     { 0x0177, "OutputArchiveProfile",             "oap",                  0x04000000, "Output Archive profile info to a file", 1, {
               { 0x0000, 1 },  } }, 
     { 0x0178, "QuitGame",                         "qqq",                  0x04000000, "Exit game without going through menus.", 0, { } }, 
     { 0x0179, "SaveIniFiles",                     "saveini",              0x04000000, "Writes all the .ini files.", 0, { } }, 
     { 0x017A, "SetDebugText",                     "sdt",                  0x04000000, "Sets which debug text is shown.", 2, {
               { 0x0000, 1 }, 
               { 0x0001, 1 },  } }, 
     { 0x017B, "ToggleLiteBrite",                  "tlb",                  0x04000000, "Toggles lite brite render mode.", 0, { } }, 
     { 0x017C, "RunMemoryPass",                    "rmp",                  0x04000000, "Runs a cleanup memory pass", 1, {
               { 0x0001, 0 },  } }, 
     { 0x017D, "ResetMemContexts",                 "rmc",                  0x04000000, "Reset Max Mem Contexts", 0, { } }, 
     { 0x017E, "ToggleWaterSystem",                "TWS",                  0x04000000, "Toggles the water system", 0, { } }, 
     { 0x017F, "ToggleWaterRadius",                "TWR",                  0x04000000, "", 0, { } }, 
     { 0x0180, "ShowWhoDetectsPlayer",             "SWDP",                 0x04000000, " Show who detects the player", 0, { } }, 
     { 0x0181, "ToggleCombatAI",                   "tcai",                 0x04000000, "Toggles ALL Combat AI", 0, { } }, 
     { 0x0182, "ToggleFlyCam",                     "tfc",                  0x04000000, "Toggles the Free Fly camera (UFO cam).", 1, {
               { 0x0001, 1 },  } }, 
     { 0x0183, "ModWaterShader",                   "mws",                  0x04000000, "Modifies water shader settings", 2, {
               { 0x0000, 0 }, 
               { 0x0002, 1 },  } }, 
     { 0x0184, "WaterColor",                       "mwc",                  0x04000000, "Modifies water color", 4, {
               { 0x0001, 0 }, 
               { 0x0002, 0 }, 
               { 0x0002, 0 }, 
               { 0x0002, 0 },  } }, 
     { 0x0185, "BeginTrace",                       "bt",                   0x04000000, "Creates a trace file (Xenon only)", 0, { } }, 
     { 0x0186, "RunCellTest",                      "rct",                  0x04000000, "Runs a cell test", 1, {
               { 0x0001, 1 },  } }, 
     { 0x0187, "StartAllQuests",                   "saq",                  0x04000000, "Starts all quests", 0, { } }, 
     { 0x0188, "CompleteAllQuestStages",           "caqs",                 0x04000000, "Sets all quest stages", 0, { } }, 
     { 0x0189, "ToggleFogOfWar",                   "TFOW",                 0x04000000, "Turns fog of war on or off.", 0, { } }, 
     { 0x018A, "OutputLocalMapPictures",           "OLMP",                 0x04000000, "Writes out the current local map.", 0, { } }, 
     { 0x018B, "SetGamma",                         "sg",                   0x04000000, "Sets new gamma ramp.", 1, {
               { 0x0002, 0 },  } }, 
     { 0x018C, "WasteMemory",                      "wm",                   0x04000000, "Allocates some memory (in MB).", 1, {
               { 0x0002, 0 },  } }, 
     { 0x018D, "ClearAdaptedLight",                "cal",                  0x04000000, "Clears the HDR adapted light texture", 0, { } }, 
     { 0x018E, "ToggleCastShadows",                "tsh",                  0x04000000, "", 1, {
               { 0x0001, 0 },  } }, 
     { 0x018F, "SetHudGlowConstants",              "shgc",                 0x04000000, "Set parameters for HUD glow.", 4, {
               { 0x0002, 1 }, 
               { 0x0002, 1 }, 
               { 0x0002, 1 }, 
               { 0x0002, 1 },  } }, 
     { 0x0190, "CloseFile",                        "",                     0x04000000, "", 1, {
               { 0x0000, 0 },  } }, 
     { 0x0191, "SetTreeMipmapBias",                "stmb",                 0x04000000, "Set mipmap LOD bias values for tree billboards.", 2, {
               { 0x0002, 1 }, 
               { 0x0002, 1 },  } }, 
     { 0x0192, "SendSherlockDebugText",            "ssdt",                 0x04000000, "", 1, {
               { 0x0000, 1 },  } }, 
     { 0x0193, "OutputMemStats",                   "omsfw",                0x04000000, "Output Mem Stats info to a file", 1, {
               { 0x0000, 1 },  } }, 
     { 0x0194, "PlayExplosion",                    "",                     0x04000000, "Plays explosion seq in selected obj", 0, { } }, 
     { 0x0195, "SetMaxAniso",                      "sma",                  0x04000000, "Sets Depth of Field focal distance", 1, {
               { 0x0002, 0 },  } }, 
     { 0x0196, "SetMeshLODLevel",                  "smll",                 0x04000000, "Sets Depth of Field range", 1, {
               { 0x0002, 0 },  } }, 
     { 0x0197, "SetTargetDOF",                     "stdof",                0x04000000, "Sets the depth of field based on the target", 0, { } }, 
     { 0x0198, "ToggleFullScreenMotionBlur",       "tfsmb",                0x04000000, "Toggles Full screen motion blur", 0, { } }, 
     { 0x0199, "SetTriLinearThreshold",            "stlt",                 0x04000000, "Set the motion blur params", 1, {
               { 0x0002, 0 },  } }, 
     { 0x019A, "SetVel",                           "",                     0x05000000, "Sets Velocity on a reference", 2, {
               { 0x0008, 0 }, 
               { 0x0002, 0 },  } }, 
     { 0x019B, "DebugCombatBehavior",              "dcb",                  0x05000000, "Debugs the combat behavior on an actor", 0, { } }, 
     { 0x019C, "ToggleCombatDebug",                "tcd",                  0x04000000, "Toggles combat debug info", 1, {
               { 0x0000, 1 },  } }, 
     { 0x019D, "TogglePathingInfoFunction",        "TPI",                  0x04000000, "Toggle pathing information.", 0, { } }, 
     { 0x019E, "ShowInventory",                    "inv",                  0x05000000, "Shows reference inventory", 0, { } }, 
     { 0x019F, "ResetPerformanceTimers",           "rpt",                  0x04000000, "Resets the performance timers", 0, { } }, 
     { 0x01A0, "ToggleDebugDecal",                 "TDD",                  0x04000000, "Toggle debug displays for decal creation : 0-Wireframe, 1-Solid, 2-Occlusion Query, 3-Transform", 1, {
               { 0x0001, 0 },  } }, 
     { 0x01A1, "ToggleDecalRendering",             "TDR",                  0x04000000, "Toggle decal rendering", 0, { } }, 
     { 0x01A2, "SetImageSpaceModifiersEnable",     "sisme",                0x04000000, "Set imagespace modifiers enable: 0-Off, 1-On", 1, {
               { 0x0001, 0 },  } }, 
     { 0x01A3, "SetUFOCamSpeedMult",               "sucsm",                0x04000000, "Set speed mult for free camera.", 1, {
               { 0x0002, 0 },  } }, 
     { 0x01A4, "ToggleTestLight",                  "TTL",                  0x04000000, "Toggle test light (radius, magnitude).", 3, {
               { 0x0001, 1 }, 
               { 0x0002, 1 }, 
               { 0x0002, 1 },  } }, 
     { 0x01A5, "PlaceLocationMarker",              "plm",                  0x04000000, "PlaceLocationMarker x y z (optional name) (optional color )", 5, {
               { 0x0002, 0 }, 
               { 0x0002, 0 }, 
               { 0x0002, 0 }, 
               { 0x0000, 1 }, 
               { 0x0001, 1 },  } }, 
     { 0x01A6, "ClearLocationMarkers",             "clm",                  0x04000000, "", 0, { } }, 
     { 0x01A7, "ToggleMultiboundCheck",            "mbc",                  0x04000100, "Toggle all Multibound check functionality", 0, { } }, 
     { 0x01A8, "AddOcclusionPlane",                "AOP",                  0x04000000, "Add Occlusion plane (x size, y size).", 2, {
               { 0x0002, 1 }, 
               { 0x0002, 1 },  } }, 
     { 0x01A9, "SetGlobalRadialBlur",              "sgrb",                 0x04000000, "Set parameters for the global radial blur", 5, {
               { 0x0002, 0 }, 
               { 0x0002, 0 }, 
               { 0x0002, 0 }, 
               { 0x0002, 0 }, 
               { 0x0002, 0 },  } }, 
     { 0x01AA, "OutputTextureUseMap",              "OTUM",                 0x04000000, "Writes out texture use map data to file.", 1, {
               { 0x0000, 1 },  } }, 
     { 0x01AB, "ClearScreenBlood",                 "csb",                  0x04000000, "Clear screen blood", 0, { } }, 
     { 0x01AC, "ResetDialogueFlags",               "rdf",                  0x04000000, "Debug resets SayOnce, TalkedToPc, etc.", 0, { } }, 
     { 0x01AD, "GetActorValueInfo",                "GetAVInfo",            0x15000000, "Get detailed an actor value info. [player.getav luck]", 1, {
               { 0x0005, 0 },  } }, 
     { 0x01AE, "ToggleBoundVisGeom",               "tbvg",                 0x04000000, "Toggles bound visualization for a ref", 0, { } }, 
     { 0x01AF, "SetConsoleOuputFile",              "scof",                 0x04000000, "Sets the given file as target for console output.", 1, {
               { 0x0000, 0 },  } }, 
     { 0x01B0, "IgnoreRenderPass",                 "irp",                  0x04000000, "Ignore the given renderpass", 2, {
               { 0x0001, 1 }, 
               { 0x0001, 1 },  } }, 
     { 0x01B1, "PlayVATSCameras",                  "pvc",                  0x04000000, "Play this set of VATS cameras for the next VATS playback.", 1, {
               { 0x0000, 0 },  } }, 
     { 0x01B2, "SetTargetFalloff",                 "stfo",                 0x04000000, "Sets the falloff of the target", 4, {
               { 0x0002, 1 }, 
               { 0x0002, 1 }, 
               { 0x0002, 1 }, 
               { 0x0002, 1 },  } }, 
     { 0x01B3, "ToggleActorMover",                 "tam",                  0x04000000, "Toggles actor movement through pathing system", 0, { } }, 
     { 0x01B4, "CopySaves",                        "CopySaves",            0x04000000, "Copy save games from the host machine or a memory stick (ms).", 1, {
               { 0x0000, 1 },  } }, 
     { 0x01B5, "ToggleEOFImageSpace",              "teofis",               0x04000000, "Toggles end of frame imagespace effects", 0, { } }, 
     { 0x01B6, "ForceFileCache",                   "ffc",                  0x04000000, "Enumerates Miles samples and streams", 0, { } }, 
     { 0x01B7, "DumpNiUpdates",                    "dnu",                  0x04000000, "Dumps the next frame's calls to NiNode/NiAVObject::UpdateDownwardPass to NiDump*.xls (only Debug/PIX 360 builds)", 0, { } }, 
     { 0x01B8, "TestDegrade",                      "",                     0x04000000, "degrades the specified number of MB of textures. negative values degrade all possible. (only 360 builds)", 1, {
               { 0x0001, 0 },  } }, 
     { 0x01B9, "ToggleDepthBias",                  "tdb",                  0x04000000, "toggles depth bias for decals on or off", 0, { } }, 
     { 0x01BA, "ToggleSPURenderBatch",             "tSPURB",               0x04000000, "toggles the SPU render batch on or off", 0, { } }, 
     { 0x01BB, "ToggleSPUTransformUpdate",         "tSPUTU",               0x04000000, "toggles the SPU transform update on or off", 0, { } }, 
     { 0x01BC, "ToggleSPUCulling",                 "tSPUC",                0x04000000, "toggles the SPU culling on or off", 0, { } }, 
     { 0x01BD, "ModifyFaceGen",                    "mfg",                  0x04000000, "Modify FaceGen Functionality", 3, {
               { 0x0000, 0 }, 
               { 0x0001, 1 }, 
               { 0x0001, 1 },  } }, 
     { 0x01BE, "ForceRSXCrash",                    "fRSX",                 0x04000000, "Forces an RSX crash", 0, { } }, 
     { 0x01BF, "SetEmitterParticleMax",            "",                     0x04000000, "Sets the maximum number of particles emitted by a non-master particle system emitter", 1, {
               { 0x0001, 0 },  } }, 
     { 0x01C0, "SetMPSParticleMax",                "",                     0x04000000, "Sets the maximum number of particles emitted by master particle system emitter set", 1, {
               { 0x0001, 0 },  } }, 
     { 0x01C1, "SetTaskThreadSleep",               "",                     0x04000000, "Sets the task thread sleep value (-1 to disable).", 1, {
               { 0x0001, 0 },  } }, 
     { 0x01C2, "SetTaskThreadUpdateSleep",         "",                     0x04000000, "Sets the task thread update sleep value (-1 to disable).", 1, {
               { 0x0001, 0 },  } }, 
     { 0x01C3, "EvalActorTextures",                "EAT",                  0x04000000, "", 0, { } }, 
     { 0x01C4, "CreateSaveData",                   "createsaves",          0x04000000, "Creates save data.", 2, {
               { 0x0001, 0 }, 
               { 0x0001, 0 },  } }, 
     { 0x01C5, "CreateGameData",                   "",                     0x04000000, "Creates game data.", 2, {
               { 0x0000, 0 }, 
               { 0x0001, 1 },  } }, 
     { 0x01C6, "LoadFlashMovie",                   "",                     0x04000000, "Loads a Flash movie for the GUI", 1, {
               { 0x0000, 0 },  } }, 
     { 0x01C7, "ShowMenu",                         "",                     0x04000000, "Show or create a menu", 1, {
               { 0x0000, 0 },  } }, 
     { 0x01C8, "HideMenu",                         "",                     0x04000000, "Hide or close a menu", 1, {
               { 0x0000, 0 },  } }, 
     { 0x01C9, "RecvAnimEvent",                    "rae",                  0x05000000, "Simulate recieving an animation event from an animation graph.", 2, {
               { 0x0000, 0 }, 
               { 0x0000, 1 },  } }, 
     { 0x01CA, "RunConsoleBatch",                  "bat",                  0x04000000, "Run a console batch file", 1, {
               { 0x0000, 0 },  } }, 
     { 0x01CB, "LTGraph",                          "LTGraph",              0x04000000, "Sets the input-to-player movement graph", 1, {
               { 0x0000, 0 },  } }, 
     { 0x01CC, "RTGraph",                          "RTGraph",              0x04000000, "Sets the input-to-camera movement graph", 1, {
               { 0x0000, 0 },  } }, 
     { 0x01CD, "ToggleHeapTracking",               "THT",                  0x04000000, "Toggle Heap Tracking", 0, { } }, 
     { 0x01CE, "TogglePoolTracking",               "TPT",                  0x04000000, "Toggle Pool Tracking", 0, { } }, 
     { 0x01CF, "RumbleManager",                    "RM",                   0x04000000, "RumbleManager", 4, {
               { 0x0002, 1 }, 
               { 0x0002, 1 }, 
               { 0x0002, 1 }, 
               { 0x0002, 1 },  } }, 
     { 0x01D0, "InstallMemoryTracker",             "IMT",                  0x04000000, "Install Memory Tracker", 1, {
               { 0x0000, 0 },  } }, 
     { 0x01D1, "UninstallMemoryTracker",           "UMT",                  0x04000000, "Uninstall Memory Tracker", 0, { } }, 
     { 0x01D2, "CheckMemory",                      "chkmem",               0x04000000, "Check Memory", 0, { } }, 
     { 0x01D3, "SetStackDepth",                    "SSD",                  0x04000000, "Set Stack Depth", 1, {
               { 0x0001, 0 },  } }, 
     { 0x01D4, "PathToRef",                        "PTR",                  0x05000000, "Force actor to path to reference.", 1, {
               { 0x0004, 1 },  } }, 
     { 0x01D5, "StartAIControlledRobotTest",       "SPTP",                 0x04000000, "Starts player pathing memory test.", 3, {
               { 0x0000, 0 }, 
               { 0x0000, 0 }, 
               { 0x0000, 1 },  } }, 
     { 0x01D6, "TestHandleManagerWarnAndKillSDM",  "THMWAKS",              0x04000000, "Purely for testing: lists every un-destroyed handle, then destroys it.", 0, { } }, 
     { 0x01D7, "SetFaceTarget",                    "SFT",                  0x05000000, "Force actor to face a reference.", 1, {
               { 0x0004, 1 },  } }, 
     { 0x01D8, "PrecomputedLOSGeneration",         "plg",                  0x04000000, "", 3, {
               { 0x0000, 1 }, 
               { 0x0000, 1 }, 
               { 0x0000, 1 },  } }, 
     { 0x01D9, "PrecomputedLOSDebug",              "pld",                  0x04000000, "", 3, {
               { 0x0000, 1 }, 
               { 0x0000, 1 }, 
               { 0x0000, 1 },  } }, 
     { 0x01DA, "SetPathSprinting",                 "SPS",                  0x05000000, "Force actor to sprint.", 1, {
               { 0x0001, 0 },  } }, 
     { 0x01DB, "SetAnimGraphVar",                  "sgv",                  0x05000000, "Set an animation graph variable.", 5, {
               { 0x0000, 0 }, 
               { 0x0000, 0 }, 
               { 0x0000, 1 }, 
               { 0x0000, 1 }, 
               { 0x0000, 1 },  } }, 
     { 0x01DC, "SetTreeTrunkFlexibility",          "STSTF",                0x04000000, "Set the flexibility of trees trunk.", 1, {
               { 0x0002, 0 },  } }, 
     { 0x01DD, "SetTreeBranchFlexibility",         "STSBF",                0x04000000, "Set the flexibility of trees branches.", 1, {
               { 0x0002, 0 },  } }, 
     { 0x01DE, "SetTreeBranchAnimationRange",      "STSBR",                0x04000000, "Restrict the range of tree branch animations.", 2, {
               { 0x0001, 0 }, 
               { 0x0001, 0 },  } }, 
     { 0x01DF, "SetTreeLeafFlexibility",           "STSLF",                0x04000000, "Set the flexibility of trees leaves.", 1, {
               { 0x0002, 0 },  } }, 
     { 0x01E0, "SetTreeLeafAmplitude",             "STSLAMP",              0x04000000, "Set the amplitude of trees leaves.", 1, {
               { 0x0002, 0 },  } }, 
     { 0x01E1, "SetTreeLeafFrequency",             "STSLFRQ",              0x04000000, "Set the frequency of trees leaves.", 1, {
               { 0x0002, 0 },  } }, 
     { 0x01E2, "SetTreeWindDirection",             "STSWD",                0x04000000, "Set the tree system wind direction.", 2, {
               { 0x0002, 0 }, 
               { 0x0002, 0 },  } }, 
     { 0x01E3, "SetTreeWindMagnitude",             "STSWM",                0x04000000, "Set the tree system wind magnitude.", 1, {
               { 0x0002, 0 },  } }, 
     { 0x01E4, "SetBloodParam",                    "SBP",                  0x04000000, "Set blood parameters.", 2, {
               { 0x0000, 0 }, 
               { 0x0002, 1 },  } }, 
     { 0x01E5, "RegisterPrefix",                   "RPRFX",                0x04000000, "Register all resources at a path prefix.", 1, {
               { 0x0000, 0 },  } }, 
     { 0x01E6, "ToggleEventLog",                   "TEL",                  0x04000000, "Show a log of misc. events for the selected debug REFR.", 0, { } }, 
     { 0x01E7, "ExportPerfTrackingData",           "EPTD",                 0x04000000, "Export performance monitor tracking data to a file.", 0, { } }, 
     { 0x01E8, "DisplayGraphVariable",             "dgv",                  0x04000000, "Gives control of variable filters used on the animation debug text page.", 1, {
               { 0x0000, 0 },  } }, 
     { 0x01E9, "ToggleMotionDriven",               "TMD",                  0x05000000, "Toggles motion driven animation", 1, {
               { 0x0001, 1 },  } }, 
     { 0x01EA, "ToggleControlsDriven",             "TC",                   0x05000000, "Toggles controls driven character", 1, {
               { 0x0001, 1 },  } }, 
     { 0x01EB, "ToggleGUIOverlay",                 "TGO",                  0x04000000, "Toggles the graphical overlay", 0, { } }, 
     { 0x01EC, "ModifyGUIOverlay",                 "MGO",                  0x04000000, "Modifies a graphical overlay", 4, {
               { 0x0000, 0 }, 
               { 0x0000, 1 }, 
               { 0x0001, 1 }, 
               { 0x0001, 1 },  } }, 
     { 0x01ED, "SetActionComplete",                "SAC",                  0x05000000, "Sets all active actions on actor in scene complete", 0, { } }, 
     { 0x01EE, "SetConsoleScopeQuest",             "SSQ",                  0x04000000, "Sets the scope quest for all console functions. No param clears current scope quest.", 1, {
               { 0x000E, 1 },  } }, 
     { 0x01EF, "GetDistanceFromActorsPath",        "GDFAP",                0x14000000, "Prints out the distance from a reference to an actor's path.", 1, {
               { 0x0004, 0 },  } }, 
     { 0x01F0, "ClearConsole",                     "clear",                0x04000000, "Clears the console log", 0, { } }, 
     { 0x01F1, "ToggleMarkers",                    "TMK",                  0x04000000, "Toggle markers", 0, { } }, 
     { 0x01F2, "KillAllProjectiles",               "kap",                  0x04000000, "Kill all projectiles", 0, { } }, 
     { 0x01F3, "PlayTerrainEffect",                "PTFX",                 0x04000000, "Plays a terrain effect at target REFR", 1, {
               { 0x0000, 0 },  } }, 
     { 0x01F4, "CellInfo",                         "",                     0x04000000, "Toggle Cell Info", 0, { } }, 
     { 0x01F5, "Textures",                         "tx",                   0x04000000, "Toggle Texture Info", 0, { } }, 
     { 0x01F6, "Timing",                           "FPS",                  0x04000000, "Toggle Timing Info", 0, { } }, 
     { 0x01F7, "Polygons",                         "Polys",                0x04000000, "Toggle Mesh Render Info", 0, { } }, 
     { 0x01F8, "Actors",                           "Actors",               0x04000000, "Toggle Actor Info", 0, { } }, 
     { 0x01F9, "Quest",                            "Quest",                0x04000000, "Toggle Quest Event Info", 0, { } }, 
     { 0x01FA, "Particles",                        "Particles",            0x04000000, "Toggle Particle Info", 0, { } }, 
     { 0x01FB, "Memory",                           "",                     0x04000000, "Toggle Memory Info", 0, { } }, 
     { 0x01FC, "ShowNodes",                        "",                     0x05000000, "Show nodes- [All], [Off]", 1, {
               { 0x0000, 1 },  } }, 
     { 0x01FD, "SaveDebugTextPages",               "SaveDTP",              0x04000000, "Save Debug Text Pages settings to .ini file.", 0, { } }, 
     { 0x01FE, "OutputFixedStringTable",           "OFST",                 0x04000000, "Output the fixed string table to a file.", 0, { } }, 
     { 0x01FF, "AttachPapyrusScript",              "APS",                  0x04000000, "Attaches a papyrus script to a reference", 2, {
               { 0x0000, 0 }, 
               { 0x0000, 1 },  } }, 
     { 0x0200, "SaveHavokSnapshot",                "SHS",                  0x04000000, "Saves a Havok snapshot of the hkpWorld the player is currently in", 2, {
               { 0x0000, 0 }, 
               { 0x0001, 1 },  } }, 
     { 0x0201, "SetNPCWeight",                     "SNPCW",                0x05000000, "[0-100]: Sets the weight of an NPC and reloads his 3D to visualize the weight change", 1, {
               { 0x0002, 0 },  } }, 
     { 0x0202, "ShowClosestLocationForSphere",     "SCLFS",                0x04000000, "Finds the closest location where a sphere can fit in the navmesh, and displays it", 3, {
               { 0x0002, 0 }, 
               { 0x0002, 0 }, 
               { 0x0001, 0 },  } }, 
     { 0x0203, "PrintShaderMacros",                "PSM",                  0x04000000, "Given a shader and technique ID, prints the macros used to compile its shader.", 2, {
               { 0x0000, 0 }, 
               { 0x0000, 0 },  } }, 
     { 0x0204, "ToggleAudioOverlay",               "TAO",                  0x04000000, "Toggle the Audio Debug Overlay.", 0, { } }, 
     { 0x0205, "TogglePapyrusLog",                 "TPLog",                0x04000000, "Toggle the Papyrus Log Overlay.", 0, { } }, 
     { 0x0206, "ToggleContextOverlay",             "TCO",                  0x04000000, "Toggle the Context Overlay.", 0, { } }, 
     { 0x0207, "ForceOutOfMemory",                 "FOOM",                 0x04000000, "Forces an OOM state.", 0, { } }, 
     { 0x0208, "ToggleMovement",                   "TMOVE",                0x04000000, "Toggles all actor movement", 0, { } }, 
     { 0x0209, "ToggleAnimations",                 "TANIM",                0x04000000, "Toggles all actor animations", 0, { } }, 
     { 0x020A, "SetWarning",                       "",                     0x04000000, "Params: Name [0/1]. 0 is default for 2nd param.", 2, {
               { 0x0000, 0 }, 
               { 0x0001, 1 },  } }, 
     { 0x020B, "TestFadeNodes",                    "TestFN",               0x04000000, "", 0, { } }, 
     { 0x020C, "ShowLowMaxHeights",                "slmh",                 0x04000000, "", 2, {
               { 0x0001, 0 }, 
               { 0x0001, 1 },  } }, 
     { 0x020D, "ShowHighMaxHeights",               "shmh",                 0x04000000, "", 1, {
               { 0x0001, 0 },  } }, 
     { 0x020E, "EnableStoryManagerLogging",        "esml",                 0x04000000, "Enable story manager logging.", 1, {
               { 0x0000, 1 },  } }, 
     { 0x020F, "SetFramebufferRange",              "sfbr",                 0x04000000, "Set frambuffer range", 1, {
               { 0x0002, 0 },  } }, 
     { 0x0210, "DumpPapyrusStacks",                "dps",                  0x04000000, "Dumps all Papyrus stack information to the log", 0, { } }, 
     { 0x0211, "DumpPapyrusUpdates",               "dpu",                  0x04000000, "Dumps all Papyrus update registrations to the log", 0, { } }, 
     { 0x0212, "SoundCatMod",                      "scm",                  0x04000000, "In-game control of sound categories.", 3, {
               { 0x004F, 0 }, 
               { 0x0000, 0 }, 
               { 0x0002, 1 },  } }, 
     { 0x0213, "RunCompaction",                    "rcmpct",               0x04000000, "Run a pass of compaction if possible.", 0, { } }, 
     { 0x0214, "ToggleAnimatorCam",                "animcam",              0x04000000, "Toggles a 3rd-person camera mode designed for animators' ease-of-use", 0, { } }, 
     { 0x0215, "ToggleImmortalMode",               "TIM",                  0x04000000, "Toggle Immortal mode", 0, { } }, 
     { 0x0216, "SetSubgraphToDebug",               "sgd",                  0x04000000, "Subgraph To Debug", 1, {
               { 0x0001, 0 },  } }, 
     { 0x0217, "EnableRumble",                     "",                     0x04000000, "", 1, {
               { 0x0001, 0 },  } }, 
     { 0x0218, "HavokVDBCapture",                  "vdbcapture",           0x04000000, "Havok VDB Capture", 2, {
               { 0x0000, 0 }, 
               { 0x0001, 1 },  } }, 
     { 0x0219, "ToggleMapCam",                     "tmc",                  0x04000000, "toggle a view mode similar to the map camera for debugging", 0, { } }, 
     { 0x021A, "ToggleNavmeshInfo",                "tni",                  0x04000000, "toggle a view mode similar to the map camera and displays navmesh infos", 0, { } }, 
     { 0x021B, "PlaySyncAnim",                     "syncanim",             0x05000000, "Play Sync Anim", 2, {
               { 0x0000, 0 }, 
               { 0x0004, 1 },  } }, 
     { 0x021C, "SetFormKnown",                     "",                     0x04000000, "Sets the known flag on a form", 2, {
               { 0x0000, 0 }, 
               { 0x0001, 0 },  } }, 
     { 0x021D, "SetDebugQuest",                    "",                     0x04000000, "Sets the quest to be the only one startable for its event type.", 3, {
               { 0x000E, 0 }, 
               { 0x0001, 0 }, 
               { 0x0001, 0 },  } }, 
     { 0x021E, "SetQuestAliasLogging",             "sqal",                 0x04000000, "Turns alias logging on/off for a quest.", 2, {
               { 0x000E, 0 }, 
               { 0x0001, 0 },  } }, 
     { 0x021F, "SetRace",                          "",                     0x04000000, "Sets the passed in actor's race.", 1, {
               { 0x0000, 0 },  } }, 
     { 0x0220, "FindForm",                         "find",                 0x04000000, "Find a form", 2, {
               { 0x0000, 0 }, 
               { 0x0000, 1 },  } }, 
     { 0x0221, "StartPapyrusScriptProfile",        "StartPSP",             0x04000000, "Starts profiling a Papyrus script.", 1, {
               { 0x0000, 0 },  } }, 
     { 0x0222, "StopPapyrusScriptProfile",         "StopPSP",              0x04000000, "Stops profiling a Papyrus script.", 1, {
               { 0x0000, 0 },  } }, 
     { 0x0223, "StartPapyrusFormProfile",          "StartPFP",             0x04000000, "Starts profiling Papyrus scripts on a form.", 1, {
               { 0x003E, 0 },  } }, 
     { 0x0224, "StopPapyrusFormProfile",           "StopPFP",              0x04000000, "Stops profiling Papyrus scripts on a form.", 1, {
               { 0x003E, 0 },  } }, 
     { 0x0225, "PrintQuestSceneInfo",              "PrintS",               0x04000000, "Prints to the Quest Inf file the current state of scenes.", 1, {
               { 0x000E, 0 },  } }, 
     { 0x0226, "IsInvulnerable",                   "isinv",                0x05000000, "Is the actor invulnerable?", 0, { } }, 
     { 0x0227, "ExportInventoryItemInfo",          "eiii",                 0x04000000, "", 1, {
               { 0x0001, 0 },  } }, 
     { 0x0228, "CollisionMesh",                    "colmesh",              0x04000000, "Toggle Mesh Collision Info", 0, { } }, 
     { 0x0229, "IsolateRendering",                 "ir",                   0x04000000, "", 0, { } }, 
     { 0x022A, "ToggleWaterCurrentGeometry",       "twcg",                 0x04000000, "", 1, {
               { 0x0001, 0 },  } }, 
     { 0x022B, "PerformAction",                    "pa",                   0x05000000, "", 1, {
               { 0x0053, 0 },  } }, 
     { 0x022C, "StartTrackPlayerDoors",            "StartTPD",             0x04000000, "", 0, { } }, 
     { 0x022D, "StopTrackPlayerDoors",             "StopTPD",              0x04000000, "", 0, { } }, 
     { 0x022E, "CheckPlayerDoors",                 "CheckPD",              0x04000000, "", 1, {
               { 0x0001, 1 },  } }, 
     { 0x022F, "ToggleSPUMovement",                "tSPUM",                0x04000000, "toggles the SPU movement on or off", 0, { } }, 
     { 0x0230, "SetInChargen",                     "",                     0x04000000, "", 3, {
               { 0x0001, 0 }, 
               { 0x0001, 0 }, 
               { 0x0001, 0 },  } }, 
     { 0x0231, "ClearAchievement",                 "",                     0x04000000, "", 1, {
               { 0x0001, 0 },  } }, 
     { 0x0232, " ",                                "",                     0x14000000, "", 0, { } }, 

     { 0x1000, "GetWantBlocking",                  "",                     0x29000000, "", 0, { } }, 
     { 0x1001, "GetDistance",                      "",                     0x29000000, "", 1, {
               { 0x0004, 0 },  } }, 
     { 0x1002, "AddItem",                          "",                     0x09000000, "", 3, {
               { 0x0035, 0 }, 
               { 0x0001, 0 }, 
               { 0x0001, 1 },  } }, 
     { 0x1003, "SetEssential",                     "",                     0x08000000, "", 2, {
               { 0x0019, 0 }, 
               { 0x0001, 1 },  } }, 
     { 0x1004, "Rotate",                           "",                     0x09000000, "", 2, {
               { 0x0008, 0 }, 
               { 0x0001, 0 },  } }, 
     { 0x1005, "GetLocked",                        "",                     0x29000000, "", 0, { } }, 
     { 0x1006, "GetPos",                           "",                     0x29000000, "", 1, {
               { 0x0008, 0 },  } }, 
     { 0x1007, "SetPos",                           "",                     0x09000000, "", 2, {
               { 0x0008, 0 }, 
               { 0x0002, 0 },  } }, 
     { 0x1008, "GetAngle",                         "",                     0x29000000, "", 1, {
               { 0x0008, 0 },  } }, 
     { 0x1009, "SetAngle",                         "",                     0x09000000, "", 2, {
               { 0x0008, 0 }, 
               { 0x0002, 0 },  } }, 
     { 0x100A, "GetStartingPos",                   "",                     0x29000000, "", 1, {
               { 0x0008, 0 },  } }, 
     { 0x100B, "GetStartingAngle",                 "",                     0x29000000, "", 1, {
               { 0x0008, 0 },  } }, 
     { 0x100C, "GetSecondsPassed",                 "",                     0x28000000, "", 0, { } }, 
     { 0x100D, "Activate",                         "",                     0x09000100, "", 2, {
               { 0x0004, 1 }, 
               { 0x0001, 1 },  } }, 
     { 0x100E, "GetActorValue",                    "GetAV",                0x19000000, "Get an actor value. [player.getav luck]", 1, {
               { 0x0005, 0 },  } }, 
     { 0x100F, "SetActorValue",                    "SetAV",                0x09000000, "Set an actor value. [player.setav luck, 75]", 2, {
               { 0x0005, 0 }, 
               { 0x0002, 0 },  } }, 
     { 0x1010, "ModActorValue",                    "ModAV",                0x09000000, "Modify an actor value. [player.modav luck, -10]", 2, {
               { 0x0005, 0 }, 
               { 0x0002, 0 },  } }, 
     { 0x1011, "SetAtStart",                       "",                     0x09000000, "", 0, { } }, 
     { 0x1012, "GetCurrentTime",                   "",                     0x28000000, "", 0, { } }, 
     { 0x1013, "PlayGroup",                        "",                     0x09000000, "IE: PlayGroup SEQNAME 1", 2, {
               { 0x000A, 0 }, 
               { 0x0001, 0 },  } }, 
     { 0x1014, "LoopGroup",                        "",                     0x09000000, "", 3, {
               { 0x000A, 0 }, 
               { 0x0001, 0 }, 
               { 0x0001, 0 },  } }, 
     { 0x1015, "SkipAnim",                         "",                     0x09000000, "", 0, { } }, 
     { 0x1016, "StartCombat",                      "",                     0x09000000, "", 1, {
               { 0x0006, 0 },  } }, 
     { 0x1017, "StopCombat",                       "",                     0x09000000, "", 0, { } }, 
     { 0x1018, "GetScale",                         "",                     0x29000000, "", 0, { } }, 
     { 0x1019, "IsMoving",                         "",                     0x29000000, "Is the actor moving?", 0, { } }, 
     { 0x101A, "IsTurning",                        "",                     0x29000000, "Is the actor turning?", 0, { } }, 
     { 0x101B, "GetLineOfSight",                   "GetLOS",               0x19000000, "", 1, {
               { 0x0004, 0 },  } }, 
     { 0x101C, "AddSpell",                         "",                     0x09000000, "", 1, {
               { 0x0007, 0 },  } }, 
     { 0x101D, "RemoveSpell",                      "",                     0x09000000, "", 1, {
               { 0x0007, 0 },  } }, 
     { 0x101E, "Cast",                             "",                     0x09000000, "", 3, {
               { 0x000B, 0 }, 
               { 0x0004, 0 }, 
               { 0x0044, 0 },  } }, 
     { 0x101F, "GetButtonPressed",                 "",                     0x08000000, "", 0, { } }, 
     { 0x1020, "GetInSameCell",                    "",                     0x29000000, "", 1, {
               { 0x0004, 0 },  } }, 
     { 0x1021, "Enable",                           "",                     0x09000000, "", 1, {
               { 0x0001, 1 },  } }, 
     { 0x1022, "Disable",                          "",                     0x09000000, "", 1, {
               { 0x0001, 1 },  } }, 
     { 0x1023, "GetDisabled",                      "",                     0x29000000, "", 0, { } }, 
     { 0x1024, "MenuMode",                         "",                     0x28000000, "", 1, {
               { 0x0001, 1 },  } }, 
     { 0x1025, "PlaceAtMe",                        "",                     0x09000000, "", 4, {
               { 0x0015, 0 }, 
               { 0x0001, 1 }, 
               { 0x0001, 1 }, 
               { 0x0001, 1 },  } }, 
     { 0x1026, "PlaySound",                        "",                     0x08000000, "Play a 2D sound. (Optional: 1 to indicate a system sound, 0 otherwise.", 2, {
               { 0x000C, 0 }, 
               { 0x0001, 1 },  } }, 
     { 0x1027, "GetDisease",                       "",                     0x29000000, "", 0, { } }, 
     { 0x1028, "FailAllObjectives",                "",                     0x08000000, "Fail all of a quest's objectives", 1, {
               { 0x000E, 0 },  } }, 
     { 0x1029, "GetClothingValue",                 "",                     0x29000000, "", 0, { } }, 
     { 0x102A, "SameFaction",                      "",                     0x29000000, "", 1, {
               { 0x0006, 0 },  } }, 
     { 0x102B, "SameRace",                         "",                     0x29000000, "", 1, {
               { 0x0006, 0 },  } }, 
     { 0x102C, "SameSex",                          "",                     0x29000000, "", 1, {
               { 0x0006, 0 },  } }, 
     { 0x102D, "GetDetected",                      "",                     0x29000000, "", 1, {
               { 0x0006, 0 },  } }, 
     { 0x102E, "GetDead",                          "",                     0x29000000, "", 0, { } }, 
     { 0x102F, "GetItemCount",                     "",                     0x29000000, "", 1, {
               { 0x0035, 0 },  } }, 
     { 0x1030, "GetGold",                          "",                     0x29000000, "", 0, { } }, 
     { 0x1031, "GetSleeping",                      "",                     0x29000000, "", 0, { } }, 
     { 0x1032, "GetTalkedToPC",                    "",                     0x29000000, "", 0, { } }, 
     { 0x1033, "Say",                              "",                     0x09000000, "", 5, {
               { 0x000D, 0 }, 
               { 0x0001, 1 }, 
               { 0x0019, 1 }, 
               { 0x0001, 1 }, 
               { 0x0001, 1 },  } }, 
     { 0x1034, "SayTo",                            "",                     0x09000000, "", 4, {
               { 0x0006, 0 }, 
               { 0x000D, 0 }, 
               { 0x0001, 1 }, 
               { 0x0001, 1 },  } }, 
     { 0x1035, "GetScriptVariable",                "",                     0x28000000, "", 2, {
               { 0x0004, 0 }, 
               { 0x0016, 0 },  } }, 
     { 0x1036, "StartQuest",                       "",                     0x08000000, "", 1, {
               { 0x000E, 0 },  } }, 
     { 0x1037, "StopQuest",                        "",                     0x08000000, "", 1, {
               { 0x000E, 0 },  } }, 
     { 0x1038, "GetQuestRunning",                  "GetQR",                0x18000000, "", 1, {
               { 0x000E, 0 },  } }, 
     { 0x1039, "SetStage",                         "",                     0x08000000, "", 2, {
               { 0x000E, 0 }, 
               { 0x0017, 0 },  } }, 
     { 0x103A, "GetStage",                         "",                     0x28000000, "", 1, {
               { 0x000E, 0 },  } }, 
     { 0x103B, "GetStageDone",                     "",                     0x28000000, "", 2, {
               { 0x000E, 0 }, 
               { 0x0017, 0 },  } }, 
     { 0x103C, "GetFactionRankDifference",         "",                     0x29000000, "", 2, {
               { 0x0011, 0 }, 
               { 0x0006, 0 },  } }, 
     { 0x103D, "GetAlarmed",                       "",                     0x29000000, "", 0, { } }, 
     { 0x103E, "IsRaining",                        "",                     0x28000000, "", 0, { } }, 
     { 0x103F, "GetAttacked",                      "",                     0x29000000, "", 0, { } }, 
     { 0x1040, "GetIsCreature",                    "",                     0x29000001, "", 0, { } }, 
     { 0x1041, "GetLockLevel",                     "",                     0x29000000, "", 0, { } }, 
     { 0x1042, "GetShouldAttack",                  "",                     0x29000000, "", 1, {
               { 0x0006, 0 },  } }, 
     { 0x1043, "GetInCell",                        "",                     0x29000000, "", 1, {
               { 0x0009, 0 },  } }, 
     { 0x1044, "GetIsClass",                       "",                     0x29000001, "", 1, {
               { 0x0010, 0 },  } }, 
     { 0x1045, "GetIsRace",                        "",                     0x29000001, "", 1, {
               { 0x000F, 0 },  } }, 
     { 0x1046, "GetIsSex",                         "",                     0x29000001, "", 1, {
               { 0x0012, 0 },  } }, 
     { 0x1047, "GetInFaction",                     "",                     0x29000001, "", 1, {
               { 0x0011, 0 },  } }, 
     { 0x1048, "GetIsID",                          "",                     0x29000001, "", 1, {
               { 62, 0 },  } }, 
     { 0x1049, "GetFactionRank",                   "",                     0x29000000, "", 1, {
               { 0x0011, 0 },  } }, 
     { 0x104A, "GetGlobalValue",                   "",                     0x28000000, "", 1, {
               { 0x0013, 0 },  } }, 
     { 0x104B, "IsSnowing",                        "",                     0x28000000, "", 0, { } }, 
     { 0x104C, "FastTravel",                       "ft",                   0x08000000, "Player Fast Travel to Marker", 1, {
               { 0x0004, 0 },  } }, 
     { 0x104D, "GetRandomPercent",                 "",                     0x28000000, "", 0, { } }, 
     { 0x104E, "RemoveMusic",                      "",                     0x08000000, "", 1, {
               { 0x0039, 0 },  } }, 
     { 0x104F, "GetQuestVariable",                 "",                     0x28000000, "", 2, {
               { 0x000E, 0 }, 
               { 0x0016, 0 },  } }, 
     { 0x1050, "GetLevel",                         "",                     0x29000000, "", 0, { } }, 
     { 0x1051, "IsRotating",                       "",                     0x29000000, "", 0, { } }, 
     { 0x1052, "RemoveItem",                       "",                     0x09000000, "", 3, {
               { 0x0035, 0 }, 
               { 0x0001, 0 }, 
               { 0x0001, 1 },  } }, 
     { 0x1053, "GetLeveledEncounterValue",         "",                     0x29000000, "", 1, {
               { 0x0001, 0 },  } }, 
     { 0x1054, "GetDeadCount",                     "",                     0x28000000, "", 1, {
               { 0x0019, 0 },  } }, 
     { 0x1055, "AddToMap",                         "ShowMap",              0x08000000, "", 2, {
               { 0x0018, 0 }, 
               { 0x0001, 1 },  } }, 
     { 0x1056, "StartConversation",                "",                     0x09000000, "Start a conversation [Bob.StartConversation Joe, SecretTopic]", 6, {
               { 0x0004, 0 }, 
               { 0x000D, 1 }, 
               { 0x0004, 1 }, 
               { 0x0004, 1 }, 
               { 0x0001, 1 }, 
               { 0x0001, 1 },  } }, 
     { 0x1057, "Drop",                             "",                     0x09000000, "", 2, {
               { 0x0003, 0 }, 
               { 0x0001, 0 },  } }, 
     { 0x1058, "AddTopic",                         "",                     0x08000000, "", 1, {
               { 0x000D, 0 },  } }, 
     { 0x1059, "ShowMessage",                      "",                     0x08000000, "", 1, {
               { 0x0034, 0 },  } }, 
     { 0x105A, "SetAlert",                         "",                     0x09000000, "", 1, {
               { 0x0001, 0 },  } }, 
     { 0x105B, "GetIsAlerted",                     "",                     0x29000000, "", 0, { } }, 
     { 0x105C, "Look",                             "",                     0x09000000, "", 2, {
               { 0x0004, 0 }, 
               { 0x0001, 1 },  } }, 
     { 0x105D, "StopLook",                         "",                     0x09000000, "", 0, { } }, 
     { 0x105E, "EvaluatePackage",                  "evp",                  0x09000000, "", 0, { } }, 
     { 0x105F, "SendAssaultAlarm",                 "",                     0x08000000, "", 2, {
               { 0x0006, 1 }, 
               { 0x0011, 1 },  } }, 
     { 0x1060, "EnablePlayerControls",             "epc",                  0x08000000, "9 optional (0/1) values. movement|fighting|pov|looking|sneaking|menu|activate|journal|POV Type ex: 1 0 0 1 0 0 0 0 0", 9, {
               { 0x0001, 1 }, 
               { 0x0001, 1 }, 
               { 0x0001, 1 }, 
               { 0x0001, 1 }, 
               { 0x0001, 1 }, 
               { 0x0001, 1 }, 
               { 0x0001, 1 }, 
               { 0x0001, 1 }, 
               { 0x0001, 1 },  } }, 
     { 0x1061, "DisablePlayerControls",            "dpc",                  0x08000000, "9 optional (0/1) values. movement|fighting|pov|looking|sneaking|menu|activate|journal|POV Type ex: 1 0 0 1 0 0 0 0 0", 9, {
               { 0x0001, 1 }, 
               { 0x0001, 1 }, 
               { 0x0001, 1 }, 
               { 0x0001, 1 }, 
               { 0x0001, 1 }, 
               { 0x0001, 1 }, 
               { 0x0001, 1 }, 
               { 0x0001, 1 }, 
               { 0x0001, 1 },  } }, 
     { 0x1062, "GetPlayerControlsDisabled",        "gpc",                  0x28000000, "8 optional (0/1) values. movement|fighting|pov|looking|sneaking|menu|activate|journal ex: 1 0 0 1 0 0 0 0", 8, {
               { 0x0001, 1 }, 
               { 0x0001, 1 }, 
               { 0x0001, 1 }, 
               { 0x0001, 1 }, 
               { 0x0001, 1 }, 
               { 0x0001, 1 }, 
               { 0x0001, 1 }, 
               { 0x0001, 1 },  } }, 
     { 0x1063, "GetHeadingAngle",                  "",                     0x29000000, "", 1, {
               { 0x0004, 0 },  } }, 
     { 0x1064, "PickIdle",                         "",                     0x09000000, "", 0, { } }, 
     { 0x1065, "IsWeaponMagicOut",                 "",                     0x29000000, "", 0, { } }, 
     { 0x1066, "IsTorchOut",                       "",                     0x29000000, "", 0, { } }, 
     { 0x1067, "IsShieldOut",                      "",                     0x29000000, "", 0, { } }, 
     { 0x1068, "CreateDetectionEvent",             "",                     0x09000000, "", 2, {
               { 0x0004, 0 }, 
               { 0x0001, 0 },  } }, 
     { 0x1069, "IsActionRef",                      "",                     0x09000000, "", 1, {
               { 0x0004, 0 },  } }, 
     { 0x106A, "IsFacingUp",                       "",                     0x29000000, "", 0, { } }, 
     { 0x106B, "GetKnockedState",                  "",                     0x29000000, "", 0, { } }, 
     { 0x106C, "GetWeaponAnimType",                "",                     0x29000000, "", 0, { } }, 
     { 0x106D, "IsWeaponSkillType",                "",                     0x29000000, "", 1, {
               { 0x0005, 0 },  } }, 
     { 0x106E, "GetCurrentAIPackage",              "",                     0x29000000, "", 0, { } }, 
     { 0x106F, "IsWaiting",                        "",                     0x29000000, "", 0, { } }, 
     { 0x1070, "IsIdlePlaying",                    "",                     0x29000000, "", 0, { } }, 
     { 0x1071, "CompleteQuest",                    "",                     0x08000000, "", 1, {
               { 0x000E, 0 },  } }, 
     { 0x1072, "Lock",                             "",                     0x09000000, "", 2, {
               { 0x0001, 1 }, 
               { 0x0001, 1 },  } }, 
     { 0x1073, "UnLock",                           "",                     0x09000000, "", 1, {
               { 0x0001, 1 },  } }, 
     { 0x1074, "IsIntimidatedbyPlayer",            "",                     0x29000000, "", 0, { } }, 
     { 0x1075, "IsPlayerInRegion",                 "",                     0x28000000, "", 1, {
               { 0x0052, 0 },  } }, 
     { 0x1076, "GetActorAggroRadiusViolated",      "",                     0x29000000, "", 0, { } }, 
     { 0x1077, "GetCrimeKnown",                    "",                     0x29000000, "", 3, {
               { 0x001C, 0 }, 
               { 0x0006, 0 }, 
               { 0x0006, 0 },  } }, 
     { 0x1078, "SetEnemy",                         "",                     0x08000000, "", 4, {
               { 0x0011, 0 }, 
               { 0x0011, 0 }, 
               { 0x0001, 1 }, 
               { 0x0001, 1 },  } }, 
     { 0x1079, "SetAlly",                          "",                     0x08000000, "", 4, {
               { 0x0011, 0 }, 
               { 0x0011, 0 }, 
               { 0x0001, 1 }, 
               { 0x0001, 1 },  } }, 
     { 0x107A, "GetCrime",                         "",                     0x29000000, "", 2, {
               { 0x0006, 0 }, 
               { 0x001C, 1 },  } }, 
     { 0x107B, "IsGreetingPlayer",                 "",                     0x29000000, "", 0, { } }, 
     { 0x107C, "StartMisterSandMan",               "",                     0x09000000, "", 1, {
               { 0x0006, 0 },  } }, 
     { 0x107D, "IsGuard",                          "",                     0x29000000, "", 0, { } }, 
     { 0x107E, "StartCannibal",                    "",                     0x09000000, "", 1, {
               { 0x0006, 0 },  } }, 
     { 0x107F, "HasBeenEaten",                     "",                     0x29000000, "", 0, { } }, 
     { 0x1080, "GetStaminaPercentage",             "GetStamina",           0x19000000, "", 0, { } }, 
     { 0x1081, "GetPCIsClass",                     "",                     0x28000000, "", 1, {
               { 0x0010, 0 },  } }, 
     { 0x1082, "GetPCIsRace",                      "",                     0x28000000, "", 1, {
               { 0x000F, 0 },  } }, 
     { 0x1083, "GetPCIsSex",                       "",                     0x28000000, "", 1, {
               { 0x0012, 0 },  } }, 
     { 0x1084, "GetPCInFaction",                   "",                     0x28000000, "", 1, {
               { 0x0011, 0 },  } }, 
     { 0x1085, "SameFactionAsPC",                  "",                     0x29000000, "", 0, { } }, 
     { 0x1086, "SameRaceAsPC",                     "",                     0x29000000, "", 0, { } }, 
     { 0x1087, "SameSexAsPC",                      "",                     0x29000000, "", 0, { } }, 
     { 0x1088, "GetIsReference",                   "",                     0x29000001, "", 1, {
               { 0x0004, 0 },  } }, 
     { 0x1089, "SetFactionRank",                   "",                     0x09000000, "", 2, {
               { 0x0011, 0 }, 
               { 0x0001, 0 },  } }, 
     { 0x108A, "ModFactionRank",                   "",                     0x09000000, "", 2, {
               { 0x0011, 0 }, 
               { 0x0001, 0 },  } }, 
     { 0x108B, "KillActor",                        "kill",                 0x09000000, "", 3, {
               { 0x0006, 1 }, 
               { 0x0001, 1 }, 
               { 0x0001, 1 },  } }, 
     { 0x108C, "ResurrectActor",                   "resurrect",            0x09000000, "", 1, {
               { 0x0001, 1 },  } }, 
     { 0x108D, "IsTalking",                        "",                     0x29000000, "", 0, { } }, 
     { 0x108E, "GetWalkSpeed",                     "GetWalk",              0x19000000, "", 0, { } }, 
     { 0x108F, "GetCurrentAIProcedure",            "",                     0x29000000, "", 0, { } }, 
     { 0x1090, "GetTrespassWarningLevel",          "",                     0x29000000, "", 0, { } }, 
     { 0x1091, "IsTrespassing",                    "",                     0x29000000, "", 0, { } }, 
     { 0x1092, "IsInMyOwnedCell",                  "",                     0x29000000, "", 0, { } }, 
     { 0x1093, "GetWindSpeed",                     "",                     0x28000000, "", 0, { } }, 
     { 0x1094, "GetCurrentWeatherPercent",         "getweatherpct",        0x18000000, "", 0, { } }, 
     { 0x1095, "GetIsCurrentWeather",              "getweather",           0x18000000, "", 1, {
               { 0x0021, 0 },  } }, 
     { 0x1096, "IsContinuingPackagePCNear",        "",                     0x29000000, "", 0, { } }, 
     { 0x1097, "SetCrimeFaction",                  "",                     0x09000000, "", 1, {
               { 0x0011, 0 },  } }, 
     { 0x1098, "GetIsCrimeFaction",                "",                     0x29000000, "", 1, {
               { 0x0011, 0 },  } }, 
     { 0x1099, "CanHaveFlames",                    "",                     0x29000000, "", 0, { } }, 
     { 0x109A, "HasFlames",                        "",                     0x29000000, "", 0, { } }, 
     { 0x109B, "AddFlames",                        "",                     0x09000000, "", 0, { } }, 
     { 0x109C, "RemoveFlames",                     "",                     0x09000000, "", 0, { } }, 
     { 0x109D, "GetOpenState",                     "",                     0x29000000, "", 0, { } }, 
     { 0x109E, "MoveToMarker",                     "MoveTo",               0x09000100, "", 4, {
               { 0x0004, 0 }, 
               { 0x0002, 1 }, 
               { 0x0002, 1 }, 
               { 0x0002, 1 },  } }, 
     { 0x109F, "GetSitting",                       "",                     0x29000000, "", 0, { } }, 
     { 0x10A0, "GetFurnitureMarkerID",             "",                     0x09000000, "", 0, { } }, 
     { 0x10A1, "GetIsCurrentPackage",              "",                     0x29000000, "", 1, {
               { 0x001D, 0 },  } }, 
     { 0x10A2, "IsCurrentFurnitureRef",            "",                     0x29000000, "", 1, {
               { 0x0004, 0 },  } }, 
     { 0x10A3, "IsCurrentFurnitureObj",            "",                     0x29000000, "", 1, {
               { 0x0014, 0 },  } }, 
     { 0x10A4, "SetSize",                          "CSize",                0x09000000, "Shrink/Grow an actor. [player.shrink 0.0 or radius]", 1, {
               { 0x0002, 0 },  } }, 
     { 0x10A5, "RemoveMe",                         "",                     0x09000000, "", 1, {
               { 0x001A, 1 },  } }, 
     { 0x10A6, "DropMe",                           "",                     0x09000000, "", 0, { } }, 
     { 0x10A7, "GetFactionReaction",               "",                     0x08000000, "", 2, {
               { 0x0011, 0 }, 
               { 0x0011, 0 },  } }, 
     { 0x10A8, "SetFactionReaction",               "",                     0x08000000, "", 3, {
               { 0x0011, 0 }, 
               { 0x0011, 0 }, 
               { 0x0001, 0 },  } }, 
     { 0x10A9, "ModFactionReaction",               "",                     0x08000000, "", 3, {
               { 0x0011, 0 }, 
               { 0x0011, 0 }, 
               { 0x0001, 0 },  } }, 
     { 0x10AA, "GetDayOfWeek",                     "",                     0x28000000, "", 0, { } }, 
     { 0x10AB, "IgnoreCrime",                      "",                     0x09000000, "", 1, {
               { 0x0001, 0 },  } }, 
     { 0x10AC, "GetTalkedToPCParam",               "",                     0x28000000, "", 1, {
               { 0x0006, 0 },  } }, 
     { 0x10AD, "RemoveAllItems",                   "",                     0x09000000, "", 3, {
               { 0x001A, 1 }, 
               { 0x0001, 1 }, 
               { 0x0001, 1 },  } }, 
     { 0x10AE, "WakeUpPC",                         "",                     0x08000000, "", 1, {
               { 0x0001, 1 },  } }, 
     { 0x10AF, "IsPCSleeping",                     "",                     0x28000000, "", 0, { } }, 
     { 0x10B0, "IsPCAMurderer",                    "",                     0x28000000, "", 0, { } }, 
     { 0x10B1, "SetCombatStyle",                   "setcs",                0x09000000, "", 1, {
               { 0x001E, 1 },  } }, 
     { 0x10B2, "PlaySound3D",                      "",                     0x08000000, "", 1, {
               { 0x000C, 0 },  } }, 
     { 0x10B3, "SelectPlayerSpell",                "spspell",              0x08000000, "", 2, {
               { 0x0007, 0 }, 
               { 0x0044, 0 },  } }, 
     { 0x10B4, "HasSameEditorLocAsRef",            "",                     0x29000000, "", 2, {
               { 0x0004, 0 }, 
               { 0x003B, 1 },  } }, 
     { 0x10B5, "HasSameEditorLocAsRefAlias",       "",                     0x29000000, "", 2, {
               { 0x003F, 0 }, 
               { 0x003B, 1 },  } }, 
     { 0x10B6, "GetEquipped",                      "",                     0x29000000, "", 1, {
               { 0x0035, 0 },  } }, 
     { 0x10B7, "Wait",                             "",                     0x09000000, "", 1, {
               { 0x001D, 0 },  } }, 
     { 0x10B8, "StopWaiting",                      "",                     0x09000000, "", 1, {
               { 0x001D, 0 },  } }, 
     { 0x10B9, "IsSwimming",                       "",                     0x29000000, "", 0, { } }, 
     { 0x10BA, "ScriptEffectElapsedSeconds",       "",                     0x08000000, "", 0, { } }, 
     { 0x10BB, "SetCellPublicFlag",                "setpublic",            0x08000000, "Set public flag on cell. [setpublic MyCell 1]", 2, {
               { 0x0009, 0 }, 
               { 0x0001, 0 },  } }, 
     { 0x10BC, "GetPCSleepHours",                  "",                     0x08000000, "", 0, { } }, 
     { 0x10BD, "SetPCSleepHours",                  "",                     0x08000000, "", 1, {
               { 0x0001, 0 },  } }, 
     { 0x10BE, "GetAmountSoldStolen",              "",                     0x28000000, "", 0, { } }, 
     { 0x10BF, "ModAmountSoldStolen",              "",                     0x08000000, "", 1, {
               { 0x0001, 0 },  } }, 
     { 0x10C0, "GetIgnoreCrime",                   "",                     0x28000000, "", 0, { } }, 
     { 0x10C1, "GetPCExpelled",                    "",                     0x28000000, "", 1, {
               { 0x0011, 0 },  } }, 
     { 0x10C2, "SetPCExpelled",                    "",                     0x08000000, "", 2, {
               { 0x0011, 0 }, 
               { 0x0001, 0 },  } }, 
     { 0x10C3, "GetPCFactionMurder",               "",                     0x28000000, "", 1, {
               { 0x0011, 0 },  } }, 
     { 0x10C4, "SetPCFactionMurder",               "",                     0x08000000, "", 2, {
               { 0x0011, 0 }, 
               { 0x0001, 0 },  } }, 
     { 0x10C5, "GetPCEnemyofFaction",              "",                     0x28000000, "", 1, {
               { 0x0011, 0 },  } }, 
     { 0x10C6, "SetPCEnemyofFaction",              "",                     0x08000000, "", 2, {
               { 0x0011, 0 }, 
               { 0x0001, 0 },  } }, 
     { 0x10C7, "GetPCFactionAttack",               "",                     0x28000000, "", 1, {
               { 0x0011, 0 },  } }, 
     { 0x10C8, "SetPCFactionAttack",               "",                     0x08000000, "", 2, {
               { 0x0011, 0 }, 
               { 0x0001, 0 },  } }, 
     { 0x10C9, "StartScene",                       "",                     0x08000000, "", 1, {
               { 0x0043, 0 },  } }, 
     { 0x10CA, "StopScene",                        "",                     0x08000000, "", 1, {
               { 0x0043, 0 },  } }, 
     { 0x10CB, "GetDestroyed",                     "",                     0x29000000, "", 0, { } }, 
     { 0x10CC, "SetDestroyed",                     "",                     0x09000000, "", 1, {
               { 0x0001, 0 },  } }, 
     { 0x10CD, "GetActionRef",                     "getAR",                0x09000000, "", 0, { } }, 
     { 0x10CE, "GetSelf",                          "this",                 0x09000000, "", 0, { } }, 
     { 0x10CF, "GetContainer",                     "",                     0x09000000, "", 0, { } }, 
     { 0x10D0, "GetForceRun",                      "",                     0x09000000, "", 0, { } }, 
     { 0x10D1, "SetForceRun",                      "",                     0x09000000, "", 1, {
               { 0x0001, 0 },  } }, 
     { 0x10D2, "GetForceSneak",                    "",                     0x09000000, "", 0, { } }, 
     { 0x10D3, "SetForceSneak",                    "",                     0x09000000, "", 1, {
               { 0x0001, 0 },  } }, 
     { 0x10D4, "AdvancePCSkill",                   "AdvSkill",             0x08000000, "Give the player the given amount of skill usage [advskill onehanded 100]", 2, {
               { 0x0005, 0 }, 
               { 0x0002, 0 },  } }, 
     { 0x10D5, "AdvancePCLevel",                   "AdvLevel",             0x08000000, "", 0, { } }, 
     { 0x10D6, "HasMagicEffect",                   "",                     0x29000000, "", 1, {
               { 0x001F, 0 },  } }, 
     { 0x10D7, "GetDefaultOpen",                   "",                     0x29000000, "Returns 1 if this object is open by default.", 0, { } }, 
     { 0x10D8, "SetDefaultOpen",                   "",                     0x09000000, "A value of 1 will make the object open by default.", 1, {
               { 0x0001, 0 },  } }, 
     { 0x10D9, "ShowClassMenu",                    "",                     0x08000000, "", 0, { } }, 
     { 0x10DA, "ShowRaceMenu",                     "SetPlayerRace",        0x08000000, "ShowRaceMenu no parameter will bring up the race menu. SetPlayerRace raceID will change the players race to raceID and reload the players geometry.", 1, {
               { 0x000F, 1 },  } }, 
     { 0x10DB, "GetAnimAction",                    "",                     0x29000000, "Return the actors current anim action.", 0, { } }, 
     { 0x10DC, "ShowNameMenu",                     "",                     0x08000000, "", 0, { } }, 
     { 0x10DD, "SetOpenState",                     "",                     0x09000000, "A value of 1 will make the object open.", 1, {
               { 0x0001, 0 },  } }, 
     { 0x10DE, "ResetReference",                   "RecycleActor",         0x09000000, "Optional destination reference.", 1, {
               { 0x0004, 1 },  } }, 
     { 0x10DF, "IsSpellTarget",                    "",                     0x29000000, "", 1, {
               { 0x000B, 0 },  } }, 
     { 0x10E0, "GetVATSMode",                      "",                     0x28000000, "", 0, { } }, 
     { 0x10E1, "GetPersuasionNumber",              "",                     0x28000000, "", 0, { } }, 
     { 0x10E2, "GetVampireFeed",                   "",                     0x29000000, "", 0, { } }, 
     { 0x10E3, "GetCannibal",                      "",                     0x29000000, "", 0, { } }, 
     { 0x10E4, "GetIsClassDefault",                "",                     0x28000000, "", 1, {
               { 0x0010, 0 },  } }, 
     { 0x10E5, "GetClassDefaultMatch",             "",                     0x28000000, "", 0, { } }, 
     { 0x10E6, "GetInCellParam",                   "",                     0x28000000, "", 2, {
               { 0x0009, 0 }, 
               { 0x0004, 0 },  } }, 
     { 0x10E7, "UnusedFunction1",                  "",                     0x08000000, "", 0, { } }, 
     { 0x10E8, "GetCombatTarget",                  "",                     0x09000000, "", 0, { } }, 
     { 0x10E9, "GetPackageTarget",                 "",                     0x09000000, "", 0, { } }, 
     { 0x10EA, "ShowSpellMaking",                  "",                     0x08000000, "", 0, { } }, 
     { 0x10EB, "GetVatsTargetHeight",              "",                     0x28000000, "", 0, { } }, 
     { 0x10EC, "SetGhost",                         "",                     0x09000000, "A value of 1 will make the NPC act as a 'ghost'.", 1, {
               { 0x0001, 0 },  } }, 
     { 0x10ED, "GetIsGhost",                       "",                     0x29000000, "Returns 1 if the actor is acting as a 'ghost'.", 0, { } }, 
     { 0x10EE, "EquipItem",                        "EquipObject",          0x09000000, "", 3, {
               { 0x0003, 0 }, 
               { 0x0001, 1 }, 
               { 0x0044, 1 },  } }, 
     { 0x10EF, "UnequipItem",                      "UnEquipObject",        0x09000000, "", 3, {
               { 0x0003, 0 }, 
               { 0x0001, 1 }, 
               { 0x0044, 1 },  } }, 
     { 0x10F0, "SetClass",                         "",                     0x09000000, "", 1, {
               { 0x0010, 0 },  } }, 
     { 0x10F1, "SetUnconscious",                   "",                     0x08000000, "A value of 1 will be unconscious.", 1, {
               { 0x0001, 0 },  } }, 
     { 0x10F2, "GetUnconscious",                   "",                     0x29000000, "Returns 1 if is unconscious.", 0, { } }, 
     { 0x10F3, "SetRestrained",                    "",                     0x08000000, "A value of 1 will be restrained.", 1, {
               { 0x0001, 0 },  } }, 
     { 0x10F4, "GetRestrained",                    "",                     0x29000000, "Returns 1 if is restrained.", 0, { } }, 
     { 0x10F5, "ForceFlee",                        "Flee",                 0x09000100, "Forces a actor to flee if destination or cell is passed in uses them", 2, {
               { 0x0009, 1 }, 
               { 0x0004, 1 },  } }, 
     { 0x10F6, "GetIsUsedItem",                    "",                     0x28000000, "", 1, {
               { 0x0038, 0 },  } }, 
     { 0x10F7, "GetIsUsedItemType",                "",                     0x28000000, "", 1, {
               { 0x0020, 0 },  } }, 
     { 0x10F8, "IsScenePlaying",                   "",                     0x28000000, "", 1, {
               { 0x0043, 0 },  } }, 
     { 0x10F9, "IsInDialogueWithPlayer",           "",                     0x29000000, "True if actor is currently in a dialogue state with player", 0, { } }, 
     { 0x10FA, "GetLocationCleared",               "",                     0x28000000, "", 1, {
               { 0x003D, 0 },  } }, 
     { 0x10FB, "SetLocationCleared",               "",                     0x08000000, "", 2, {
               { 0x003D, 0 }, 
               { 0x0001, 0 },  } }, 
     { 0x10FC, "ForceRefIntoAlias",                "",                     0x09000000, "", 1, {
               { 0x003F, 0 },  } }, 
     { 0x10FD, "EmptyRefAlias",                    "",                     0x08000000, "", 1, {
               { 0x003F, 0 },  } }, 
     { 0x10FE, "GetIsPlayableRace",                "",                     0x29000001, "", 0, { } }, 
     { 0x10FF, "GetOffersServicesNow",             "",                     0x29000000, "", 0, { } }, 
     { 0x1100, "GetGameSetting",                   "GetGS",                0x08000000, "", 1, {
               { 0x0000, 0 },  } }, 
     { 0x1101, "StopCombatAlarmOnActor",           "SCAOnActor",           0x09000000, "", 0, { } }, 
     { 0x1102, "HasAssociationType",               "",                     0x29000000, "", 2, {
               { 0x0006, 0 }, 
               { 0x0045, 0 },  } }, 
     { 0x1103, "HasFamilyRelationship",            "Family",               0x19000000, "", 1, {
               { 0x0006, 0 },  } }, 
     { 0x1104, "SetWeather",                       "sw",                   0x08000000, "Sets the active weather to the specified type", 2, {
               { 0x0021, 0 }, 
               { 0x0001, 1 },  } }, 
     { 0x1105, "HasParentRelationship",            "IsParent",             0x19000000, "", 1, {
               { 0x0006, 0 },  } }, 
     { 0x1106, "IsWarningAbout",                   "",                     0x29000000, "", 1, {
               { 0x0025, 0 },  } }, 
     { 0x1107, "IsWeaponOut",                      "",                     0x29000000, "", 0, { } }, 
     { 0x1108, "HasSpell",                         "",                     0x29000000, "", 1, {
               { 0x0007, 0 },  } }, 
     { 0x1109, "IsTimePassing",                    "",                     0x28000000, "", 0, { } }, 
     { 0x110A, "IsPleasant",                       "",                     0x28000000, "", 0, { } }, 
     { 0x110B, "IsCloudy",                         "",                     0x28000000, "", 0, { } }, 
     { 0x110C, "TrapUpdate",                       "",                     0x08000000, "", 0, { } }, 
     { 0x110D, "ShowQuestObjectives",              "SQO",                  0x08000000, "Shows the list of current quest objectives", 1, {
               { 0x000E, 1 },  } }, 
     { 0x110E, "ForceActorValue",                  "ForceAV",              0x09000000, "Does modav XXX (value - getav XXX). [player.forceav luck 25]", 2, {
               { 0x0005, 0 }, 
               { 0x0002, 0 },  } }, 
     { 0x110F, "IncrementPCSkill",                 "IncPCS",               0x08000000, "Increase the player's skill by one point. [IncrementSkill onehanded]", 1, {
               { 0x0005, 0 },  } }, 
     { 0x1110, "DoTrap",                           "",                     0x09000000, "", 8, {
               { 0x0004, 0 }, 
               { 0x0002, 0 }, 
               { 0x0002, 0 }, 
               { 0x0002, 0 }, 
               { 0x0002, 0 }, 
               { 0x0002, 0 }, 
               { 0x0001, 0 }, 
               { 0x0002, 0 },  } }, 
     { 0x1111, "EnableFastTravel",                 "EnableFast",           0x08000000, "", 1, {
               { 0x0001, 0 },  } }, 
     { 0x1112, "IsSmallBump",                      "",                     0x29000000, "", 0, { } }, 
     { 0x1113, "GetParentRef",                     "",                     0x09000000, "", 0, { } }, 
     { 0x1114, "PlayBink",                         "",                     0x08000000, "", 5, {
               { 0x0000, 0 }, 
               { 0x0001, 1 }, 
               { 0x0001, 1 }, 
               { 0x0001, 1 }, 
               { 0x0001, 1 },  } }, 
     { 0x1115, "GetBaseActorValue",                "GetBaseAV",            0x19000000, "Get a base actor value. [player.getbaseav luck]", 1, {
               { 0x0005, 0 },  } }, 
     { 0x1116, "IsOwner",                          "",                     0x29000000, "get the ownership of the ref", 1, {
               { 0x0023, 1 },  } }, 
     { 0x1117, "SetOwnership",                     "",                     0x09000000, "", 1, {
               { 0x0023, 1 },  } }, 
     { 0x1118, "IsCellOwner",                      "",                     0x29000000, "get the ownership of the ref", 2, {
               { 0x0009, 0 }, 
               { 0x0023, 1 },  } }, 
     { 0x1119, "SetCellOwnership",                 "",                     0x08000000, "", 2, {
               { 0x0009, 0 }, 
               { 0x0023, 1 },  } }, 
     { 0x111A, "IsHorseStolen",                    "",                     0x29000000, "", 0, { } }, 
     { 0x111B, "SetCellFullName",                  "",                     0x08000000, "", 2, {
               { 0x0009, 0 }, 
               { 0x0034, 0 },  } }, 
     { 0x111C, "SetActorFullName",                 "",                     0x09000000, "", 1, {
               { 0x0034, 0 },  } }, 
     { 0x111D, "IsLeftUp",                         "",                     0x29000000, "", 0, { } }, 
     { 0x111E, "IsSneaking",                       "",                     0x29000000, "", 0, { } }, 
     { 0x111F, "IsRunning",                        "",                     0x29000000, "", 0, { } }, 
     { 0x1120, "GetFriendHit",                     "",                     0x29000000, "", 0, { } }, 
     { 0x1121, "IsInCombat",                       "",                     0x29000000, "", 1, {
               { 0x0001, 1 },  } }, 
     { 0x1122, "SetPackDuration",                  "SPDur",                0x09000000, "", 1, {
               { 0x0002, 0 },  } }, 
     { 0x1123, "PlayMagicShaderVisuals",           "PMS",                  0x09000000, "", 2, {
               { 0x0024, 0 }, 
               { 0x0002, 1 },  } }, 
     { 0x1124, "PlayMagicEffectVisuals",           "PME",                  0x09000000, "", 2, {
               { 0x001F, 0 }, 
               { 0x0002, 1 },  } }, 
     { 0x1125, "StopMagicShaderVisuals",           "SMS",                  0x09000000, "", 1, {
               { 0x0024, 0 },  } }, 
     { 0x1126, "StopMagicEffectVisuals",           "SME",                  0x09000000, "", 1, {
               { 0x001F, 0 },  } }, 
     { 0x1127, "ResetInterior",                    "",                     0x08000000, "", 1, {
               { 0x0009, 0 },  } }, 
     { 0x1128, "IsAnimPlaying",                    "",                     0x09000000, "", 1, {
               { 0x000A, 1 },  } }, 
     { 0x1129, "SetActorAlpha",                    "SAA",                  0x09000000, "", 2, {
               { 0x0002, 0 }, 
               { 0x0001, 1 },  } }, 
     { 0x112A, "EnableLinkedPathPoints",           "",                     0x09000000, "", 0, { } }, 
     { 0x112B, "DisableLinkedPathPoints",          "",                     0x09000000, "", 0, { } }, 
     { 0x112C, "IsInInterior",                     "",                     0x29000000, "", 0, { } }, 
     { 0x112D, "ForceWeather",                     "fw",                   0x08000000, "Forces the active weather to the specified type, without transition.", 2, {
               { 0x0021, 0 }, 
               { 0x0001, 1 },  } }, 
     { 0x112E, "ToggleActorsAI",                   "",                     0x09000000, "", 0, { } }, 
     { 0x112F, "IsActorsAIOff",                    "",                     0x29000000, "", 0, { } }, 
     { 0x1130, "IsWaterObject",                    "",                     0x29000000, "Water condition used for drinking animation.", 0, { } }, 
     { 0x1131, "GetPlayerAction",                  "",                     0x29000000, "", 0, { } }, 
     { 0x1132, "IsActorUsingATorch",               "",                     0x29000000, "", 0, { } }, 
     { 0x1133, "SetLevel",                         "",                     0x09000000, "", 4, {
               { 0x0001, 0 }, 
               { 0x0001, 1 }, 
               { 0x0001, 1 }, 
               { 0x0001, 1 },  } }, 
     { 0x1134, "ResetFallDamageTimer",             "",                     0x09000000, "", 0, { } }, 
     { 0x1135, "IsXBox",                           "",                     0x28000000, "", 0, { } }, 
     { 0x1136, "GetInWorldspace",                  "",                     0x29000000, "", 1, {
               { 0x001B, 0 },  } }, 
     { 0x1137, "ModPCMiscStat",                    "ModPCMS",              0x08000000, "", 2, {
               { 0x0029, 0 }, 
               { 0x0001, 0 },  } }, 
     { 0x1138, "GetPCMiscStat",                    "GetPCMS",              0x18000000, "", 1, {
               { 0x0029, 0 },  } }, 
     { 0x1139, "GetPairedAnimation",               "GPA",                  0x19000000, "See if this reference is currently playing a paired animation.", 0, { } }, 
     { 0x113A, "IsActorAVictim",                   "",                     0x29000000, "", 0, { } }, 
     { 0x113B, "GetTotalPersuasionNumber",         "",                     0x28000000, "", 0, { } }, 
     { 0x113C, "SetScale",                         "",                     0x09000000, "Set the scale of an object", 1, {
               { 0x0002, 0 },  } }, 
     { 0x113D, "ModScale",                         "",                     0x09000000, "Modify the scale of an object", 1, {
               { 0x0002, 0 },  } }, 
     { 0x113E, "GetIdleDoneOnce",                  "",                     0x28000000, "", 0, { } }, 
     { 0x113F, "KillAllActors",                    "killall",              0x08000000, "", 1, {
               { 0x0006, 1 },  } }, 
     { 0x1140, "GetNoRumors",                      "",                     0x29000000, "", 0, { } }, 
     { 0x1141, "SetNoRumors",                      "",                     0x09000000, "", 1, {
               { 0x0001, 0 },  } }, 
     { 0x1142, "Dispel",                           "",                     0x09000000, "", 1, {
               { 0x000B, 0 },  } }, 
     { 0x1143, "GetCombatState",                   "",                     0x29000000, "", 0, { } }, 
     { 0x1144, "TriggerHitShader",                 "ths",                  0x08000000, "", 1, {
               { 0x0002, 1 },  } }, 
     { 0x1145, "GetWithinPackageLocation",         "",                     0x29000000, "", 1, {
               { 0x004E, 0 },  } }, 
     { 0x1146, "Reset3DState",                     "",                     0x08000000, "", 0, { } }, 
     { 0x1147, "IsRidingHorse",                    "",                     0x29000000, "", 0, { } }, 
     { 0x1148, "DispelAllSpells",                  "",                     0x09000000, "", 0, { } }, 
     { 0x1149, "IsFleeing",                        "",                     0x29000000, "", 0, { } }, 
     { 0x114A, "AddAchievement",                   "",                     0x08000000, "", 1, {
               { 0x0001, 0 },  } }, 
     { 0x114B, "DuplicateAllItems",                "",                     0x09000000, "", 2, {
               { 0x001A, 1 }, 
               { 0x0001, 1 },  } }, 
     { 0x114C, "IsInDangerousWater",               "",                     0x29000000, "", 0, { } }, 
     { 0x114D, "EssentialDeathReload",             "",                     0x08000000, "", 1, {
               { 0x0000, 0 },  } }, 
     { 0x114E, "SetShowQuestItems",                "",                     0x08000000, "", 1, {
               { 0x0001, 0 },  } }, 
     { 0x114F, "DuplicateNPCStats",                "",                     0x09000000, "", 1, {
               { 0x0006, 1 },  } }, 
     { 0x1150, "ResetHealth",                      "",                     0x09000000, "", 0, { } }, 
     { 0x1151, "SetIgnoreFriendlyHits",            "sifh",                 0x09000000, "Set whether an actor should ignore friendly hits (0-no, 1-yes)", 1, {
               { 0x0001, 0 },  } }, 
     { 0x1152, "GetIgnoreFriendlyHits",            "gifh",                 0x19000000, "See if an actor is ignoring friendly hits", 0, { } }, 
     { 0x1153, "IsPlayersLastRiddenHorse",         "",                     0x29000000, "", 0, { } }, 
     { 0x1154, "SetActorRefraction",               "sar",                  0x09000000, "", 1, {
               { 0x0002, 0 },  } }, 
     { 0x1155, "SetItemValue",                     "",                     0x09000000, "", 1, {
               { 0x0001, 0 },  } }, 
     { 0x1156, "SetRigidBodyMass",                 "",                     0x08000000, "", 1, {
               { 0x0002, 0 },  } }, 
     { 0x1157, "ShowViewerStrings",                "svs",                  0x09000000, "", 0, { } }, 
     { 0x1158, "ReleaseWeatherOverride",           "rwo",                  0x08000000, "", 0, { } }, 
     { 0x1159, "SetAllReachable",                  "",                     0x08000000, "", 1, {
               { 0x0001, 0 },  } }, 
     { 0x115A, "SetAllVisible",                    "",                     0x08000000, "", 1, {
               { 0x0001, 0 },  } }, 
     { 0x115B, "SetNoAvoidance",                   "",                     0x08000000, "", 1, {
               { 0x0001, 0 },  } }, 
     { 0x115C, "SendTrespassAlarm",                "",                     0x09000000, "", 1, {
               { 0x0006, 0 },  } }, 
     { 0x115D, "SetSceneIsComplex",                "",                     0x08000000, "", 1, {
               { 0x0001, 0 },  } }, 
     { 0x115E, "Autosave",                         "",                     0x08000000, "", 0, { } }, 
     { 0x115F, "StartMasterFileSeekData",          "",                     0x08000000, "", 0, { } }, 
     { 0x1160, "DumpMasterFileSeekData",           "",                     0x08000000, "", 0, { } }, 
     { 0x1161, "IsActor",                          "",                     0x29000000, "", 0, { } }, 
     { 0x1162, "IsEssential",                      "",                     0x29000000, "", 0, { } }, 
     { 0x1163, "PreloadMagicEffect",               "",                     0x09000000, "", 1, {
               { 0x001F, 0 },  } }, 
     { 0x1164, "ShowDialogSubtitles",              "",                     0x08000000, "", 1, {
               { 0x0001, 1 },  } }, 
     { 0x1165, "SetPlayerResistingArrest",         "",                     0x09000000, "", 0, { } }, 
     { 0x1166, "IsPlayerMovingIntoNewSpace",       "",                     0x28000000, "", 0, { } }, 
     { 0x1167, "GetInCurrentLoc",                  "",                     0x29000000, "", 1, {
               { 0x003D, 0 },  } }, 
     { 0x1168, "GetInCurrentLocAlias",             "",                     0x29000000, "", 1, {
               { 0x003F, 0 },  } }, 
     { 0x1169, "GetTimeDead",                      "",                     0x29000000, "", 0, { } }, 
     { 0x116A, "HasLinkedRef",                     "",                     0x29000000, "", 1, {
               { 0x003B, 1 },  } }, 
     { 0x116B, "GetLinkedRef",                     "",                     0x09000000, "", 1, {
               { 0x003B, 1 },  } }, 
     { 0x116C, "DamageObject",                     "do",                   0x09000000, "", 1, {
               { 0x0002, 0 },  } }, 
     { 0x116D, "IsChild",                          "",                     0x29000001, "", 0, { } }, 
     { 0x116E, "GetStolenItemValueNoCrime",        "",                     0x28000000, "", 1, {
               { 0x0011, 0 },  } }, 
     { 0x116F, "GetLastPlayerAction",              "",                     0x28000000, "", 0, { } }, 
     { 0x1170, "IsPlayerActionActive",             "",                     0x28000000, "", 1, {
               { 0x0001, 0 },  } }, 
     { 0x1171, "SetTalkingActivatorActor",         "",                     0x09000000, "", 1, {
               { 0x0006, 1 },  } }, 
     { 0x1172, "IsTalkingActivatorActor",          "",                     0x29000000, "", 1, {
               { 0x0006, 0 },  } }, 
     { 0x1173, "ShowBarterMenu",                   "sbm",                  0x09000000, "", 1, {
               { 0x0001, 1 },  } }, 
     { 0x1174, "IsInList",                         "",                     0x29000001, "", 1, {
               { 0x0025, 0 },  } }, 
     { 0x1175, "GetStolenItemValue",               "",                     0x28000000, "", 1, {
               { 0x0011, 0 },  } }, 
     { 0x1176, "AddPerk",                          "",                     0x09000000, "", 1, {
               { 0x0027, 0 },  } }, 
     { 0x1177, "GetCrimeGoldViolent",              "getviolent",           0x19000000, "", 1, {
               { 0x0011, 1 },  } }, 
     { 0x1178, "GetCrimeGoldNonviolent",           "getnonviolent",        0x19000000, "", 1, {
               { 0x0011, 1 },  } }, 
     { 0x1179, "ShowRepairMenu",                   "srm",                  0x08000000, "", 0, { } }, 
     { 0x117A, "HasShout",                         "",                     0x29000000, "", 1, {
               { 0x0040, 0 },  } }, 
     { 0x117B, "AddNote",                          "AN",                   0x08000000, "", 1, {
               { 0x0028, 0 },  } }, 
     { 0x117C, "RemoveNote",                       "RN",                   0x08000000, "", 1, {
               { 0x0028, 0 },  } }, 
     { 0x117D, "GetHasNote",                       "GetN",                 0x28000000, "", 1, {
               { 0x0028, 0 },  } }, 
     { 0x117E, "AddToFaction",                     "Addfac",               0x09000000, "", 2, {
               { 0x0011, 0 }, 
               { 0x0001, 0 },  } }, 
     { 0x117F, "RemoveFromFaction",                "Removefac",            0x09000000, "", 1, {
               { 0x0011, 0 },  } }, 
     { 0x1180, "DamageActorValue",                 "DamageAV",             0x09000000, "Damage an actor value.", 2, {
               { 0x0005, 0 }, 
               { 0x0002, 0 },  } }, 
     { 0x1181, "RestoreActorValue",                "RestoreAV",            0x09000000, "Restore an actor value.", 2, {
               { 0x0005, 0 }, 
               { 0x0002, 0 },  } }, 
     { 0x1182, "TriggerHUDShudder",                "hudsh",                0x08000000, "Trigger shudder effect on HUD.  Params=Intensity/Duration.", 4, {
               { 0x0002, 1 }, 
               { 0x0002, 1 }, 
               { 0x0002, 1 }, 
               { 0x0002, 1 },  } }, 
     { 0x1183, "GetObjectiveFailed",               "",                     0x08000000, "", 2, {
               { 0x000E, 0 }, 
               { 0x0001, 0 },  } }, 
     { 0x1184, "SetObjectiveFailed",               "",                     0x08000000, "", 3, {
               { 0x000E, 0 }, 
               { 0x0001, 0 }, 
               { 0x0001, 0 },  } }, 
     { 0x1185, "SetGlobalTimeMultiplier",          "sgtm",                 0x08000000, "", 1, {
               { 0x0002, 0 },  } }, 
     { 0x1186, "GetHitLocation",                   "",                     0x29000000, "What BGSBodyPart::LIMB_ENUM was hit. -1 = none, 0 = torso, ...", 0, { } }, 
     { 0x1187, "IsPC1stPerson",                    "pc1st",                0x28000000, "Is the player playing in 1st person mode?", 0, { } }, 
     { 0x1188, "PurgeCellBuffers",                 "pcb",                  0x08000000, "Forcibly unloads all unattached cells in cell buffers.", 0, { } }, 
     { 0x1189, "PushActorAway",                    "",                     0x09000000, "", 2, {
               { 0x0004, 0 }, 
               { 0x0001, 0 },  } }, 
     { 0x118A, "SetActorsAI",                      "",                     0x09000000, "", 1, {
               { 0x0001, 0 },  } }, 
     { 0x118B, "ClearOwnership",                   "",                     0x09000000, "", 0, { } }, 
     { 0x118C, "GetCauseofDeath",                  "",                     0x29000000, "What killed the actor", 0, { } }, 
     { 0x118D, "IsLimbGone",                       "",                     0x29000000, "Is BGSBodyPart::LIMB_ENUM been dismembered", 1, {
               { 0x0001, 0 },  } }, 
     { 0x118E, "IsWeaponInList",                   "",                     0x29000000, "Is the current weapon in the form list", 1, {
               { 0x0025, 0 },  } }, 
     { 0x118F, "PlayIdle",                         "",                     0x09000000, "Play this idle on the current actor.", 1, {
               { 0x0000, 0 },  } }, 
     { 0x1190, "ApplyImageSpaceModifier",          "imod",                 0x08000000, "Adds an imagespace modifier to the active list", 2, {
               { 0x002A, 0 }, 
               { 0x0002, 1 },  } }, 
     { 0x1191, "RemoveImageSpaceModifier",         "rimod",                0x08000000, "Removes an imagespace modifier from the active list", 2, {
               { 0x002A, 0 }, 
               { 0x0002, 1 },  } }, 
     { 0x1192, "IsBribedbyPlayer",                 "",                     0x29000000, "", 0, { } }, 
     { 0x1193, "GetRelationshipRank",              "",                     0x29000000, "", 1, {
               { 0x0006, 0 },  } }, 
     { 0x1194, "SetRelationshipRank",              "",                     0x09000000, "", 2, {
               { 0x0006, 0 }, 
               { 0x0001, 0 },  } }, 
     { 0x1195, "SetCellImageSpace",                "",                     0x08000000, "", 2, {
               { 0x0009, 0 }, 
               { 0x002B, 0 },  } }, 
     { 0x1196, "ShowChargenMenu",                  "scgm",                 0x08000000, "", 0, { } }, 
     { 0x1197, "GetVATSValue",                     "",                     0x28000000, "", 2, {
               { 0x0001, 0 }, 
               { 0x0001, 1 },  } }, 
     { 0x1198, "IsKiller",                         "",                     0x29000000, "", 1, {
               { 0x0006, 0 },  } }, 
     { 0x1199, "IsKillerObject",                   "",                     0x29000000, "", 1, {
               { 0x0025, 0 },  } }, 
     { 0x119A, "GetFactionCombatReaction",         "",                     0x28000000, "", 2, {
               { 0x0011, 0 }, 
               { 0x0011, 0 },  } }, 
     { 0x119B, "UseWeapon",                        "",                     0x09000000, "", 9, {
               { 0x0015, 0 }, 
               { 0x0004, 0 }, 
               { 0x0004, 0 }, 
               { 0x0001, 0 }, 
               { 0x0001, 1 }, 
               { 0x0001, 1 }, 
               { 0x0001, 1 }, 
               { 0x0001, 1 }, 
               { 0x0004, 1 },  } }, 
     { 0x119C, "EvaluateSpellConditions",          "esc",                  0x09000000, "", 0, { } }, 
     { 0x119D, "ToggleMotionBlur",                 "tmb",                  0x08000000, "Toggle Motion Blur for the selected reference", 0, { } }, 
     { 0x119E, "Exists",                           "",                     0x29000000, "", 1, {
               { 0x0004, 0 },  } }, 
     { 0x119F, "GetGroupMemberCount",              "",                     0x29000000, "", 0, { } }, 
     { 0x11A0, "GetGroupTargetCount",              "",                     0x29000000, "", 0, { } }, 
     { 0x11A1, "SetObjectiveCompleted",            "",                     0x08000000, "Set objective completion status: 0-Off, 1-On", 3, {
               { 0x000E, 0 }, 
               { 0x0001, 0 }, 
               { 0x0001, 0 },  } }, 
     { 0x11A2, "SetObjectiveDisplayed",            "",                     0x08000000, "Set objective displayed status: 0-Off, 1-On", 3, {
               { 0x000E, 0 }, 
               { 0x0001, 0 }, 
               { 0x0001, 0 },  } }, 
     { 0x11A3, "GetObjectiveCompleted",            "",                     0x08000000, "Get objective completion status: 0-Off, 1-On", 2, {
               { 0x000E, 0 }, 
               { 0x0001, 0 },  } }, 
     { 0x11A4, "GetObjectiveDisplayed",            "",                     0x08000000, "Get objective displayed status: 0-Off, 1-On", 2, {
               { 0x000E, 0 }, 
               { 0x0001, 0 },  } }, 
     { 0x11A5, "SetImageSpace",                    "",                     0x08000000, "", 1, {
               { 0x002B, 1 },  } }, 
     { 0x11A6, "PipboyRadio",                      "prad",                 0x08000000, "Control the Pipboy radio. Enable, Disable, Tune", 2, {
               { 0x0000, 0 }, 
               { 0x0004, 1 },  } }, 
     { 0x11A7, "RemovePerk",                       "",                     0x09000000, "", 1, {
               { 0x0027, 0 },  } }, 
     { 0x11A8, "DisableAllActors",                 "DisAA",                0x09000000, "", 0, { } }, 
     { 0x11A9, "GetIsFormType",                    "",                     0x09000001, "", 1, {
               { 0x0000, 0 },  } }, 
     { 0x11AA, "GetIsVoiceType",                   "",                     0x29000001, "", 1, {
               { 0x0031, 0 },  } }, 
     { 0x11AB, "GetPlantedExplosive",              "",                     0x29000000, "", 0, { } }, 
     { 0x11AC, "CompleteAllObjectives",            "",                     0x08000000, "Complete all of a quest's objectives", 1, {
               { 0x000E, 0 },  } },
     { 0x11AD, "IsScenePackageRunning",            "",                     0x29000000, "", 0, { } }, 
     { 0x11AE, "GetHealthPercentage",              "",                     0x29000000, "", 0, { } }, 
     { 0x11AF, "SetAudioMultithreading",           "SAM",                  0x08000000, "", 1, {
               { 0x0001, 0 },  } }, 
     { 0x11B0, "GetIsObjectType",                  "",                     0x29000000, "", 1, {
               { 0x0020, 0 },  } }, 
     { 0x11B1, "ShowChargenMenuParams",            "scgmp",                0x08000000, "", 3, {
               { 0x0001, 0 }, 
               { 0x0001, 0 }, 
               { 0x0001, 0 },  } }, 
     { 0x11B2, "GetDialogueEmotion",               "",                     0x29000000, "", 0, { } }, 
     { 0x11B3, "GetDialogueEmotionValue",          "",                     0x29000000, "", 0, { } }, 
     { 0x11B4, "ExitGame",                         "exit",                 0x08000100, "", 0, { } }, 
     { 0x11B5, "GetIsCreatureType",                "",                     0x29000001, "", 1, {
               { 0x0001, 0 },  } }, 
     { 0x11B6, "PlayerCreatePotion",               "",                     0x08000000, "", 3, {
               { 0x001F, 0 }, 
               { 0x001F, 1 }, 
               { 0x001F, 1 },  } }, 
     { 0x11B7, "PlayerEnchantObject",              "",                     0x08000000, "", 3, {
               { 0x0015, 0 }, 
               { 0x001F, 0 }, 
               { 0x001F, 1 },  } }, 
     { 0x11B8, "ShowWarning",                      "",                     0x08000000, "", 1, {
               { 0x0000, 0 },  } }, 
     { 0x11B9, "EnterTrigger",                     "",                     0x09000000, "", 1, {
               { 0x0004, 0 },  } }, 
     { 0x11BA, "MarkForDelete",                    "",                     0x09000000, "", 0, { } }, 
     { 0x11BB, "SetPlayerAIDriven",                "",                     0x08000000, "", 1, {
               { 0x0001, 0 },  } }, 
     { 0x11BC, "GetInCurrentLocFormList",          "",                     0x29000000, "", 1, {
               { 0x0025, 0 },  } }, 
     { 0x11BD, "GetInZone",                        "",                     0x29000000, "", 1, {
               { 0x0032, 0 },  } }, 
     { 0x11BE, "GetVelocity",                      "",                     0x29000000, "Gets Velocity on a reference", 1, {
               { 0x0008, 0 },  } }, 
     { 0x11BF, "GetGraphVariableFloat",            "",                     0x29000000, "", 1, {
               { 0x0000, 0 },  } }, 
     { 0x11C0, "HasPerk",                          "",                     0x29000000, "", 1, {
               { 0x0027, 0 },  } }, 
     { 0x11C1, "GetFactionRelation",               "",                     0x29000000, "", 1, {
               { 0x0006, 0 },  } }, 
     { 0x11C2, "IsLastIdlePlayed",                 "",                     0x29000000, "", 1, {
               { 0x0033, 0 },  } }, 
     { 0x11C3, "SetNPCRadio",                      "snr",                  0x08000000, "Enable/Disable NPC radio playback: 0-Off, 1-On ", 2, {
               { 0x0001, 0 }, 
               { 0x0004, 0 },  } }, 
     { 0x11C4, "SetPlayerTeammate",                "",                     0x09000000, "", 1, {
               { 0x0001, 0 },  } }, 
     { 0x11C5, "GetPlayerTeammate",                "",                     0x29000000, "", 0, { } }, 
     { 0x11C6, "GetPlayerTeammateCount",           "",                     0x28000000, "", 0, { } }, 
     { 0x11C7, "OpenActorContainer",               "",                     0x09000000, "", 1, {
               { 0x0001, 1 },  } }, 
     { 0x11C8, "ClearFactionPlayerEnemyFlag",      "",                     0x08000000, "", 1, {
               { 0x0011, 0 },  } }, 
     { 0x11C9, "ClearActorsFactionsPlayerEnemyFlag",   "",                     0x09000000, "", 0, { } }, 
     { 0x11CA, "GetActorCrimePlayerEnemy",         "",                     0x29000000, "", 0, { } }, 
     { 0x11CB, "GetCrimeGold",                     "",                     0x29000000, "", 1, {
               { 0x0011, 1 },  } }, 
     { 0x11CC, "SetCrimeGold",                     "",                     0x09000000, "", 2, {
               { 0x0001, 0 }, 
               { 0x0011, 1 },  } }, 
     { 0x11CD, "ModCrimeGold",                     "",                     0x09000000, "", 3, {
               { 0x0001, 0 }, 
               { 0x0001, 1 }, 
               { 0x0011, 1 },  } }, 
     { 0x11CE, "GetPlayerGrabbedRef",              "",                     0x08000000, "", 0, { } }, 
     { 0x11CF, "IsPlayerGrabbedRef",               "",                     0x28000000, "", 1, {
               { 0x0004, 0 },  } }, 
     { 0x11D0, "PlaceLeveledActorAtMe",            "",                     0x08000000, "", 3, {
               { 0x0015, 0 }, 
               { 0x0001, 1 }, 
               { 0x0032, 1 },  } }, 
     { 0x11D1, "GetKeywordItemCount",              "",                     0x29000000, "", 1, {
               { 0x003B, 0 },  } }, 
     { 0x11D2, "ShowLockpickMenu",                 "slpm",                 0x08000000, "", 1, {
               { 0x0001, 1 },  } }, 
     { 0x11D3, "GetBroadcastState",                "",                     0x09000000, "", 0, { } }, 
     { 0x11D4, "SetBroadcastState",                "",                     0x09000000, "", 1, {
               { 0x0001, 0 },  } }, 
     { 0x11D5, "StartRadioConversation",           "",                     0x09000000, "", 1, {
               { 0x000D, 1 },  } }, 
     { 0x11D6, "GetDestructionStage",              "",                     0x29000000, "", 0, { } }, 
     { 0x11D7, "ClearDestruction",                 "",                     0x09000000, "", 0, { } }, 
     { 0x11D8, "CastImmediateOnSelf",              "cios",                 0x09000000, "", 1, {
               { 0x000B, 0 },  } }, 
     { 0x11D9, "GetIsAlignment",                   "",                     0x29000000, "", 1, {
               { 0x0036, 0 },  } }, 
     { 0x11DA, "ResetQuest",                       "",                     0x08000000, "", 1, {
               { 0x000E, 0 },  } }, 
     { 0x11DB, "SetQuestDelay",                    "",                     0x08000000, "", 2, {
               { 0x000E, 0 }, 
               { 0x0002, 0 },  } }, 
     { 0x11DC, "IsProtected",                      "",                     0x29000000, "", 0, { } }, 
     { 0x11DD, "GetThreatRatio",                   "",                     0x29000000, "", 1, {
               { 0x0006, 0 },  } }, 
     { 0x11DE, "MatchFaceGeometry",                "",                     0x09000000, "", 2, {
               { 0x0006, 0 }, 
               { 0x0001, 0 },  } }, 
     { 0x11DF, "GetIsUsedItemEquipType",           "",                     0x19000000, "", 1, {
               { 0x0037, 0 },  } }, 
     { 0x11E0, "GetPlayerName",                    "",                     0x08000000, "", 0, { } }, 
     { 0x11E1, "FireWeapon",                       "",                     0x09000000, "", 1, {
               { 0x0015, 0 },  } }, 
     { 0x11E2, "PayCrimeGold",                     "",                     0x09000000, "", 3, {
               { 0x0001, 1 }, 
               { 0x0001, 1 }, 
               { 0x0011, 1 },  } }, 
     { 0x11E3, "UnusedFunction2",                  "",                     0x09000000, "", 1, {
               { 0x0002, 0 },  } }, 
     { 0x11E4, "MatchRace",                        "",                     0x09000000, "", 1, {
               { 0x0006, 0 },  } }, 
     { 0x11E5, "SetPCYoung",                       "",                     0x08000000, "", 1, {
               { 0x0001, 0 },  } }, 
     { 0x11E6, "SexChange",                        "",                     0x08000000, "", 2, {
               { 0x0012, 1 }, 
               { 0x0001, 1 },  } }, 
     { 0x11E7, "IsCarryable",                      "",                     0x29000000, "", 0, { } }, 
     { 0x11E8, "GetConcussed",                     "",                     0x29000000, "", 0, { } }, 
     { 0x11E9, "SetZoneRespawns",                  "",                     0x08000000, "", 2, {
               { 0x0032, 0 }, 
               { 0x0001, 0 },  } }, 
     { 0x11EA, "SetVATSTarget",                    "",                     0x09000000, "", 1, {
               { 0x0001, 0 },  } }, 
     { 0x11EB, "GetMapMarkerVisible",              "",                     0x29000000, "", 0, { } }, 
     { 0x11EC, "ResetInventory",                   "",                     0x09000000, "", 0, { } }, 
     { 0x11ED, "PlayerKnows",                      "",                     0x28000000, "", 1, {
               { 0x0051, 0 },  } }, 
     { 0x11EE, "GetPermanentActorValue",           "GetPermAV",            0x19000000, "Get an actor value ignoring temporary modifiers. [player.getav luck]", 1, {
               { 0x0005, 0 },  } }, 
     { 0x11EF, "GetKillingBlowLimb",               "",                     0x29000000, "Which BGSBodyPart::LIMB_ENUM received the killing blow", 0, { } }, 
     { 0x11F0, "GoToJail",                         "",                     0x09000000, "", 3, {
               { 0x0011, 1 }, 
               { 0x0001, 1 }, 
               { 0x0001, 1 },  } }, 
     { 0x11F1, "CanPayCrimeGold",                  "",                     0x29000000, "", 1, {
               { 0x0011, 1 },  } }, 
     { 0x11F2, "ServeTime",                        "",                     0x08000000, "", 0, { } }, 
     { 0x11F3, "GetDaysInJail",                    "",                     0x29000000, "", 0, { } }, 
     { 0x11F4, "EPAlchemyGetMakingPoison",         "",                     0x28000000, "", 0, { } }, 
     { 0x11F5, "EPAlchemyEffectHasKeyword",        "",                     0x28000000, "", 1, {
               { 0x003B, 0 },  } }, 
     { 0x11F6, "ShowAllMapMarkers",                "tmm",                  0x08000000, "Shows/hides map markers (1 shows, 0 hides)(1 travel(default), 0 no travel)(1 all, 0 all but hidden(default)).", 3, {
               { 0x0001, 0 }, 
               { 0x0001, 1 }, 
               { 0x0001, 1 },  } }, 
     { 0x11F7, "GetAllowWorldInteractions",        "",                     0x29000001, "", 0, { } }, 
     { 0x11F8, "ResetAI",                          "",                     0x09000000, "", 0, { } }, 
     { 0x11F9, "SetRumble",                        "",                     0x08000000, "Creates rumble in the controller (left motor) (right motor) (duration)", 3, {
               { 0x0002, 0 }, 
               { 0x0002, 0 }, 
               { 0x0002, 0 },  } }, 
     { 0x11FA, "SetNoActivationSound",             "",                     0x08000000, "Set the sound to play when activation fails (Sound)", 1, {
               { 0x000C, 0 },  } }, 
     { 0x11FB, "ClearNoActivationSound",           "",                     0x08000000, "Clear the activation failure sound", 0, { } }, 
     { 0x11FC, "GetLastHitCritical",               "",                     0x29000000, "", 0, { } }, 
     { 0x11FD, "AddMusic",                         "",                     0x08000000, "", 1, {
               { 0x0039, 0 },  } }, 
     { 0x11FE, "UnusedFunction3",                  "",                     0x08000000, "", 0, { } }, 
     { 0x11FF, "UnusedFunction4",                  "",                     0x09000000, "", 0, { } }, 
     { 0x1200, "SetPCToddler",                     "",                     0x08000000, "", 1, {
               { 0x0001, 0 },  } }, 
     { 0x1201, "IsCombatTarget",                   "",                     0x29000000, "", 1, {
               { 0x0006, 0 },  } }, 
     { 0x1202, "TriggerScreenBlood",               "tsb",                  0x08000000, "Trigger screen blood", 1, {
               { 0x0001, 0 },  } }, 
     { 0x1203, "GetVATSRightAreaFree",             "",                     0x29000000, "", 1, {
               { 0x0004, 1 },  } }, 
     { 0x1204, "GetVATSLeftAreaFree",              "",                     0x29000000, "", 1, {
               { 0x0004, 1 },  } }, 
     { 0x1205, "GetVATSBackAreaFree",              "",                     0x29000000, "", 1, {
               { 0x0004, 1 },  } }, 
     { 0x1206, "GetVATSFrontAreaFree",             "",                     0x29000000, "", 1, {
               { 0x0004, 1 },  } }, 
     { 0x1207, "GetIsLockBroken",                  "",                     0x29000000, "", 0, { } }, 
     { 0x1208, "IsPS3",                            "",                     0x28000000, "", 0, { } }, 
     { 0x1209, "IsWin32",                          "",                     0x28000000, "", 0, { } }, 
     { 0x120A, "GetVATSRightTargetVisible",        "",                     0x29000000, "", 1, {
               { 0x0004, 0 },  } }, 
     { 0x120B, "GetVATSLeftTargetVisible",         "",                     0x29000000, "", 1, {
               { 0x0004, 0 },  } }, 
     { 0x120C, "GetVATSBackTargetVisible",         "",                     0x29000000, "", 1, {
               { 0x0004, 0 },  } }, 
     { 0x120D, "GetVATSFrontTargetVisible",        "",                     0x29000000, "", 1, {
               { 0x0004, 0 },  } }, 
     { 0x120E, "AttachAshPile",                    "",                     0x09000000, "", 1, {
               { 0x0001, 1 },  } }, 
     { 0x120F, "SetCriticalStage",                 "",                     0x09000000, "", 1, {
               { 0x003A, 0 },  } }, 
     { 0x1210, "IsInCriticalStage",                "",                     0x29000000, "", 1, {
               { 0x003A, 0 },  } }, 
     { 0x1211, "RemoveFromAllFactions",            "",                     0x09000000, "", 0, { } }, 
     { 0x1212, "GetXPForNextLevel",                "",                     0x28000000, "", 0, { } }, 
     { 0x1213, "ShowLockpickMenuDebug",            "slpmd",                0x08000000, "", 1, {
               { 0x0001, 1 },  } }, 
     { 0x1214, "ForceSave",                        "",                     0x08000000, "", 0, { } }, 
     { 0x1215, "GetInfamy",                        "",                     0x28000000, "", 1, {
               { 0x0011, 1 },  } }, 
     { 0x1216, "GetInfamyViolent",                 "",                     0x28000000, "", 1, {
               { 0x0011, 1 },  } }, 
     { 0x1217, "GetInfamyNonViolent",              "",                     0x28000000, "", 1, {
               { 0x0011, 1 },  } }, 
     { 0x1218, "UnusedFunction5",                  "",                     0x09000000, "", 0, { } }, 
     { 0x1219, "Sin",                              "",                     0x08000000, "", 2, {
               { 0x0002, 0 }, 
               { 0x0001, 1 },  } }, 
     { 0x121A, "Cos",                              "",                     0x08000000, "", 2, {
               { 0x0002, 0 }, 
               { 0x0001, 1 },  } }, 
     { 0x121B, "Tan",                              "",                     0x08000000, "", 2, {
               { 0x0002, 0 }, 
               { 0x0001, 1 },  } }, 
     { 0x121C, "Sqrt",                             "",                     0x08000000, "", 1, {
               { 0x0002, 0 },  } }, 
     { 0x121D, "Log",                              "",                     0x08000000, "", 2, {
               { 0x0002, 0 }, 
               { 0x0002, 1 },  } }, 
     { 0x121E, "Abs",                              "",                     0x08000000, "", 1, {
               { 0x0002, 0 },  } }, 
     { 0x121F, "GetQuestCompleted",                "GetQC",                0x18000000, "", 1, {
               { 0x000E, 0 },  } }, 
     { 0x1220, "UnusedFunction6",                  "",                     0x09000000, "", 0, { } }, 
     { 0x1221, "PipBoyRadioOff",                   "",                     0x08000000, "", 0, { } }, 
     { 0x1222, "AutoDisplayObjectives",            "",                     0x08000000, "", 1, {
               { 0x0001, 0 },  } }, 
     { 0x1223, "IsGoreDisabled",                   "",                     0x28000000, "", 0, { } }, 
     { 0x1224, "FadeSFX",                          "FSFX",                 0x08000000, "", 1, {
               { 0x0002, 0 },  } }, 
     { 0x1225, "SetMinimalUse",                    "",                     0x09000000, "", 1, {
               { 0x0001, 0 },  } }, 
     { 0x1226, "IsSceneActionComplete",            "",                     0x28000000, "", 2, {
               { 0x0043, 0 }, 
               { 0x0001, 0 },  } }, 
     { 0x1227, "ShowQuestStages",                  "SQS",                  0x08000000, "", 1, {
               { 0x000E, 0 },  } }, 
     { 0x1228, "GetSpellUsageNum",                 "",                     0x29000000, "", 1, {
               { 0x000B, 0 },  } }, 
     { 0x1229, "ForceRadioStationUpdate",          "FRSU",                 0x08000000, "", 0, { } }, 
     { 0x122A, "GetActorsInHigh",                  "",                     0x28000000, "", 0, { } }, 
     { 0x122B, "HasLoaded3D",                      "",                     0x28000000, "", 0, { } }, 
     { 0x122C, "DisableAllMines",                  "",                     0x08000000, "", 0, { } }, 
     { 0x122D, "SetLastExtDoorActivated",          "",                     0x08000000, "", 1, {
               { 0x0004, 0 },  } }, 
     { 0x122E, "KillQuestUpdates",                 "KQU",                  0x08000000, "", 0, { } }, 
     { 0x122F, "IsImageSpaceActive",               "",                     0x08000000, "", 1, {
               { 0x002A, 0 },  } }, 
     { 0x1230, "HasKeyword",                       "",                     0x29000000, "", 1, {
               { 0x003B, 0 },  } }, 
     { 0x1231, "HasRefType",                       "",                     0x29000000, "", 1, {
               { 0x003C, 0 },  } }, 
     { 0x1232, "LocationHasKeyword",               "",                     0x29000000, "", 1, {
               { 0x003B, 0 },  } }, 
     { 0x1233, "LocationHasRefType",               "",                     0x29000000, "", 1, {
               { 0x003C, 0 },  } }, 
     { 0x1234, "CreateEvent",                      "",                     0x08000000, "", 6, {
               { 0x003B, 0 }, 
               { 0x003D, 1 }, 
               { 0x0004, 1 }, 
               { 0x0004, 1 }, 
               { 0x0001, 1 }, 
               { 0x0001, 1 },  } }, 
     { 0x1235, "GetIsEditorLocation",              "",                     0x29000000, "", 1, {
               { 0x003D, 0 },  } }, 
     { 0x1236, "GetIsAliasRef",                    "",                     0x29000001, "", 1, {
               { 0x003F, 0 },  } }, 
     { 0x1237, "GetIsEditorLocAlias",              "",                     0x29000000, "", 1, {
               { 0x003F, 0 },  } }, 
     { 0x1238, "IsSprinting",                      "",                     0x29000000, "", 0, { } }, 
     { 0x1239, "IsBlocking",                       "",                     0x29000000, "", 0, { } }, 
     { 0x123A, "HasEquippedSpell",                 "hasspell",			   0x19000000, "", 1, {
               { 0x0044, 0 },  } }, 
     { 0x123B, "GetCurrentCastingType",            "getcasting",           0x19000000, "", 1, {
               { 0x0044, 0 },  } }, 
     { 0x123C, "GetCurrentDeliveryType",           "getdelivery",          0x19000000, "", 1, {
               { 0x0044, 0 },  } }, 
     { 0x123D, "EquipSpell",                       "",                     0x09000000, "", 2, {
               { 0x0007, 0 }, 
               { 0x0044, 0 },  } }, 
     { 0x123E, "GetAttackState",                   "",                     0x29000000, "0 = None, 1 = Draw, 2 = Swing, 3 = Hit, 4 = Next Attack, 5 = Follow Through, 6 = Bash", 0, { } }, 
     { 0x123F, "GetAliasedRef",                    "",                     0x08000000, "", 1, {
               { 0x003F, 0 },  } }, 
     { 0x1240, "GetEventData",                     "",                     0x28000000, "", 3, {
               { 0x002E, 0 }, 
               { 0x002F, 0 }, 
               { 0x0030, 1 },  } }, 
     { 0x1241, "IsCloserToAThanB",                 "",                     0x29000000, "", 2, {
               { 0x0004, 0 }, 
               { 0x0004, 0 },  } }, 
     { 0x1242, "EquipShout",                       "",                     0x09000000, "", 1, {
               { 0x0040, 0 },  } }, 
     { 0x1243, "GetEquippedShout",                 "",                     0x29000000, "", 1, {
               { 0x0040, 0 },  } }, 
     { 0x1244, "IsBleedingOut",                    "",                     0x29000000, "", 0, { } }, 
     { 0x1245, "UnlockWord",                       "",                     0x08000000, "", 1, {
               { 0x0041, 0 },  } }, 
     { 0x1246, "TeachWord",                        "",                     0x08000000, "", 1, {
               { 0x0041, 0 },  } }, 
     { 0x1247, "AddToContainer",                   "",                     0x09000000, "", 2, {
               { 0x0004, 0 }, 
               { 0x0001, 1 },  } }, 
     { 0x1248, "GetRelativeAngle",                 "",                     0x29000000, "", 2, {
               { 0x0004, 0 }, 
               { 0x0008, 0 },  } }, 
     { 0x1249, "SendAnimEvent",                    "sae",                  0x09000000, "Send an event to the animation graph.", 1, {
               { 0x0000, 0 },  } }, 
     { 0x124A, "Shout",                            "",                     0x09000000, "", 3, {
               { 0x0040, 0 }, 
               { 0x0001, 0 }, 
               { 0x0004, 0 },  } }, 
     { 0x124B, "AddShout",                         "",                     0x09000000, "", 1, {
               { 0x0040, 0 },  } }, 
     { 0x124C, "RemoveShout",                      "",                     0x09000000, "", 1, {
               { 0x0040, 0 },  } }, 
     { 0x124D, "GetMovementDirection",             "",                     0x29000000, "", 0, { } }, 
     { 0x124E, "IsInScene",                        "",                     0x29000000, "", 0, { } }, 
     { 0x124F, "GetRefTypeDeadCount",              "",                     0x28000000, "", 2, {
               { 0x003D, 0 }, 
               { 0x003C, 0 },  } }, 
     { 0x1250, "GetRefTypeAliveCount",             "",                     0x28000000, "", 2, {
               { 0x003D, 0 }, 
               { 0x003C, 0 },  } }, 
     { 0x1251, "ApplyHavokImpulse",                "",                     0x09000000, "", 4, {
               { 0x0002, 0 }, 
               { 0x0002, 0 }, 
               { 0x0002, 0 }, 
               { 0x0002, 0 },  } }, 
     { 0x1252, "GetIsFlying",                      "",                     0x29000000, "", 0, { } }, 
     { 0x1253, "IsCurrentSpell",                   "",                     0x29000000, "", 2, {
               { 0x0007, 0 }, 
               { 0x0044, 0 },  } }, 
     { 0x1254, "SpellHasKeyword",                  "",                     0x29000000, "", 2, {
               { 0x0044, 0 }, 
               { 0x003B, 0 },  } }, 
     { 0x1255, "GetEquippedItemType",              "",                     0x29000000, "", 1, {
               { 0x0044, 0 },  } }, 
     { 0x1256, "GetLocationAliasCleared",          "",                     0x28000000, "", 1, {
               { 0x003F, 0 },  } }, 
     { 0x1257, "SetLocationAliasCleared",          "",                     0x08000000, "", 1, {
               { 0x003F, 0 },  } }, 
     { 0x1258, "GetLocAliasRefTypeDeadCount",      "",                     0x28000000, "", 2, {
               { 0x003F, 0 }, 
               { 0x003C, 0 },  } }, 
     { 0x1259, "GetLocAliasRefTypeAliveCount",     "",                     0x28000000, "", 2, {
               { 0x003F, 0 }, 
               { 0x003C, 0 },  } }, 
     { 0x125A, "IsWardState",                      "",                     0x29000000, "", 1, {
               { 0x0046, 0 },  } }, 
     { 0x125B, "IsInSameCurrentLocAsRef",          "",                     0x29000000, "", 2, {
               { 0x0004, 0 }, 
               { 0x003B, 1 },  } }, 
     { 0x125C, "IsInSameCurrentLocAsRefAlias",     "",                     0x29000000, "", 2, {
               { 0x003F, 0 }, 
               { 0x003B, 1 },  } }, 
     { 0x125D, "LocAliasIsLocation",               "",                     0x28000000, "", 2, {
               { 0x003F, 0 }, 
               { 0x003D, 0 },  } }, 
     { 0x125E, "GetKeywordDataForLocation",        "",                     0x28000000, "", 2, {
               { 0x003D, 0 }, 
               { 0x003B, 0 },  } }, 
     { 0x125F, "SetKeywordDataForLocation",        "",                     0x08000000, "", 3, {
               { 0x003D, 0 }, 
               { 0x003B, 0 }, 
               { 0x0002, 0 },  } }, 
     { 0x1260, "GetKeywordDataForAlias",           "",                     0x28000000, "", 2, {
               { 0x003F, 0 }, 
               { 0x003B, 0 },  } }, 
     { 0x1261, "SetKeywordDataForAlias",           "",                     0x08000000, "", 3, {
               { 0x003F, 0 }, 
               { 0x003B, 0 }, 
               { 0x0002, 0 },  } }, 
     { 0x1262, "LocAliasHasKeyword",               "",                     0x28000000, "", 2, {
               { 0x003F, 0 }, 
               { 0x003B, 0 },  } }, 
     { 0x1263, "IsNullPackageData",                "",                     0x29000000, "", 1, {
               { 0x0047, 0 },  } }, 
     { 0x1264, "GetNumericPackageData",            "",                     0x29000000, "", 1, {
               { 0x0048, 0 },  } }, 
     { 0x1265, "IsFurnitureAnimType",              "",                     0x29000000, "", 1, {
               { 0x0049, 0 },  } }, 
     { 0x1266, "IsFurnitureEntryType",             "",                     0x29000000, "", 1, {
               { 0x004A, 0 },  } }, 
     { 0x1267, "GetHighestRelationshipRank",       "",                     0x29000000, "", 0, { } }, 
     { 0x1268, "GetLowestRelationshipRank",        "",                     0x29000000, "", 0, { } }, 
     { 0x1269, "HasAssociationTypeAny",            "",                     0x29000000, "", 1, {
               { 0x0045, 0 },  } }, 
     { 0x126A, "HasFamilyRelationshipAny",         "",                     0x29000000, "", 0, { } }, 
     { 0x126B, "GetPathingTargetOffset",           "",                     0x29000000, "", 1, {
               { 0x0008, 0 },  } }, 
     { 0x126C, "GetPathingTargetAngleOffset",      "",                     0x29000000, "", 1, {
               { 0x0008, 0 },  } }, 
     { 0x126D, "GetPathingTargetSpeed",            "",                     0x29000000, "", 0, { } }, 
     { 0x126E, "GetPathingTargetSpeedAngle",       "",                     0x29000000, "", 1, {
               { 0x0008, 0 },  } }, 
     { 0x126F, "GetMovementSpeed",                 "",                     0x29000000, "", 0, { } }, 
     { 0x1270, "GetInContainer",                   "",                     0x29000000, "", 1, {
               { 0x0004, 0 },  } }, 
     { 0x1271, "IsLocationLoaded",                 "",                     0x28000000, "", 1, {
               { 0x003D, 0 },  } }, 
     { 0x1272, "IsLocAliasLoaded",                 "",                     0x28000000, "", 1, {
               { 0x003F, 0 },  } }, 
     { 0x1273, "IsDualCasting",                    "",                     0x29000000, "", 0, { } }, 
     { 0x1274, "DualCast",                         "",                     0x09000000, "", 2, {
               { 0x000B, 0 }, 
               { 0x0004, 0 },  } }, 
     { 0x1275, "GetVMQuestVariable",               "",                     0x28000000, "", 2, {
               { 0x000E, 0 }, 
               { 0x004C, 0 },  } }, 
     { 0x1276, "GetVMScriptVariable",              "",                     0x28000000, "", 2, {
               { 0x0004, 0 }, 
               { 0x004C, 0 },  } }, 
     { 0x1277, "IsEnteringInteractionQuick",       "",                     0x29000000, "", 0, { } }, 
     { 0x1278, "IsCasting",                        "",                     0x29000000, "", 0, { } }, 
     { 0x1279, "GetFlyingState",                   "",                     0x29000000, "", 0, { } }, 
     { 0x127A, "SetFavorState",                    "",                     0x09000000, "", 1, {
               { 0x0001, 0 },  } }, 
     { 0x127B, "IsInFavorState",                   "",                     0x29000000, "", 0, { } }, 
     { 0x127C, "HasTwoHandedWeaponEquipped",       "",                     0x29000000, "", 0, { } }, 
     { 0x127D, "IsExitingInstant",                 "",                     0x29000000, "", 0, { } }, 
     { 0x127E, "IsInFriendStatewithPlayer",        "",                     0x29000000, "", 0, { } }, 
     { 0x127F, "GetWithinDistance",                "",                     0x29000000, "", 2, {
               { 0x0004, 0 }, 
               { 0x0002, 0 },  } }, 
     { 0x1280, "GetActorValuePercent",             "",                     0x29000000, "", 1, {
               { 0x0005, 0 },  } }, 
     { 0x1281, "IsUnique",                         "",                     0x29000000, "", 0, { } }, 
     { 0x1282, "GetLastBumpDirection",             "",                     0x29000000, "", 0, { } }, 
     { 0x1283, "CameraShake",                      "",                     0x08000000, "", 2, {
               { 0x0002, 0 }, 
               { 0x0002, 1 },  } }, 
     { 0x1284, "IsInFurnitureState",               "",                     0x29000000, "", 1, {
               { 0x0049, 0 },  } }, 
     { 0x1285, "GetIsInjured",                     "",                     0x29000000, "", 0, { } }, 
     { 0x1286, "GetIsCrashLandRequest",            "",                     0x29000000, "", 0, { } }, 
     { 0x1287, "GetIsHastyLandRequest",            "",                     0x29000000, "", 0, { } }, 
     { 0x1288, "UpdateQuestInstanceGlobal",        "",                     0x08000000, "", 2, {
               { 0x000E, 0 }, 
               { 0x0013, 0 },  } }, 
     { 0x1289, "SetAllowFlying",                   "",                     0x09000000, "", 1, {
               { 0x0001, 0 },  } }, 
     { 0x128A, "IsLinkedTo",                       "",                     0x29000000, "", 2, {
               { 0x0004, 0 }, 
               { 0x003B, 1 },  } }, 
     { 0x128B, "GetKeywordDataForCurrentLocation",  "",                     0x29000000, "", 1, {
               { 0x003B, 0 },  } }, 
     { 0x128C, "GetInSharedCrimeFaction",          "",                     0x29000000, "", 1, {
               { 0x0004, 0 },  } }, 
     { 0x128D, "GetBribeAmount",                   "",                     0x09000000, "", 0, { } }, 
     { 0x128E, "GetBribeSuccess",                  "",                     0x29000000, "", 0, { } }, 
     { 0x128F, "GetIntimidateSuccess",             "",                     0x29000000, "", 0, { } }, 
     { 0x1290, "GetArrestedState",                 "",                     0x29000000, "", 0, { } }, 
     { 0x1291, "GetArrestingActor",                "",                     0x29000000, "", 0, { } }, 
     { 0x1292, "ClearArrestState",                 "",                     0x09000000, "", 0, { } }, 
     { 0x1293, "EPTemperingItemIsEnchanted",       "",                     0x28000000, "", 0, { } }, 
     { 0x1294, "EPTemperingItemHasKeyword",        "",                     0x28000000, "", 1, {
               { 0x003B, 0 },  } }, 
     { 0x1295, "GetReceivedGiftValue",             "",                     0x09000000, "", 0, { } }, 
     { 0x1296, "GetGiftGivenValue",                "",                     0x09000000, "", 0, { } }, 
     { 0x1297, "ForceLocIntoAlias",                "",                     0x08000000, "", 2, {
               { 0x003D, 0 }, 
               { 0x003F, 0 },  } }, 
     { 0x1298, "GetReplacedItemType",              "",                     0x29000000, "", 1, {
               { 0x0044, 0 },  } }, 
     { 0x1299, "SetHorseActor",                    "",                     0x09000000, "", 1, {
               { 0x0004, 0 },  } }, 
     { 0x129A, "PlayReferenceEffect",              "pre",                  0x09000000, "", 3, {
               { 0x004D, 0 }, 
               { 0x0002, 1 }, 
               { 0x0004, 1 },  } }, 
     { 0x129B, "StopReferenceEffect",              "sre",                  0x09000000, "", 1, {
               { 0x004D, 0 },  } }, 
     { 0x129C, "PlayShaderParticleGeometry",       "pspg",                 0x08000000, "", 2, {
               { 0x003E, 0 }, 
               { 0x0002, 0 },  } }, 
     { 0x129D, "StopShaderParticleGeometry",       "sspg",                 0x08000000, "", 2, {
               { 0x003E, 0 }, 
               { 0x0002, 0 },  } }, 
     { 0x129E, "ApplyImageSpaceModifierCrossFade",  "imodcf",               0x08000000, "Adds a crossfade imagespace modifier to the active list", 2, {
               { 0x002A, 0 }, 
               { 0x0002, 1 },  } }, 
     { 0x129F, "RemoveImageSpaceModifierCrossFade",  "rimodcf",              0x08000000, "Remove a crossfade imagespace modifier from the active list", 1, {
               { 0x0002, 1 },  } }, 
     { 0x12A0, "IsAttacking",                      "",                     0x29000000, "", 0, { } }, 
     { 0x12A1, "IsPowerAttacking",                 "",                     0x29000000, "", 0, { } }, 
     { 0x12A2, "IsLastHostileActor",               "",                     0x29000000, "", 0, { } }, 
     { 0x12A3, "GetGraphVariableInt",              "",                     0x29000000, "", 1, {
               { 0x0000, 0 },  } }, 
     { 0x12A4, "GetCurrentShoutVariation",         "",                     0x29000000, "", 0, { } }, 
     { 0x12A5, "PlayImpactEffect",                 "pie",                  0x09000000, "", 8, {
               { 0x0000, 0 }, 
               { 0x0000, 1 }, 
               { 0x0002, 1 }, 
               { 0x0002, 1 }, 
               { 0x0002, 1 }, 
               { 0x0002, 1 }, 
               { 0x0001, 1 }, 
               { 0x0001, 1 },  } }, 
     { 0x12A6, "ShouldAttackKill",                 "",                     0x29000000, "", 1, {
               { 0x0006, 0 },  } }, 
     { 0x12A7, "SendStealAlarm",                   "steal",                0x09000000, "", 1, {
               { 0x0006, 0 },  } }, 
     { 0x12A8, "GetActivationHeight",              "",                     0x29000000, "", 0, { } }, 
     { 0x12A9, "EPModSkillUsage_IsAdvanceSkill",   "",                     0x28000000, "", 1, {
               { 0x0005, 0 },  } }, 
     { 0x12AA, "WornHasKeyword",                   "",                     0x29000000, "", 1, {
               { 0x003B, 0 },  } }, 
     { 0x12AB, "GetPathingCurrentSpeed",           "",                     0x29000000, "", 0, { } }, 
     { 0x12AC, "GetPathingCurrentSpeedAngle",      "",                     0x29000000, "", 1, {
               { 0x0008, 0 },  } }, 
     { 0x12AD, "KnockAreaEffect",                  "kae",                  0x09000000, "", 2, {
               { 0x0002, 0 }, 
               { 0x0002, 0 },  } }, 
     { 0x12AE, "InterruptCast",                    "",                     0x09000000, "", 0, { } }, 
     { 0x12AF, "AddFormToFormList",                "",                     0x08000000, "", 2, {
               { 0x003E, 0 }, 
               { 0x003E, 0 },  } }, 
     { 0x12B0, "RevertFormList",                   "",                     0x08000000, "", 1, {
               { 0x003E, 0 },  } }, 
     { 0x12B1, "AddFormToLeveledList",             "",                     0x08000000, "", 4, {
               { 0x003E, 0 }, 
               { 0x003E, 0 }, 
               { 0x0001, 0 }, 
               { 0x0001, 0 },  } }, 
     { 0x12B2, "RevertLeveledList",                "",                     0x08000000, "", 1, {
               { 0x003E, 0 },  } }, 
     { 0x12B3, "EPModSkillUsage_AdvanceObjectHasKeyword",        "",                     0x28000000, "", 1, {
               { 0x003B, 0 },  } }, 
     { 0x12B4, "EPModSkillUsage_IsAdvanceAction",  "",                     0x28000000, "", 1, {
               { 0x0050, 0 },  } }, 
     { 0x12B5, "EPMagic_SpellHasKeyword",          "",                     0x28000000, "", 1, {
               { 0x003B, 0 },  } }, 
     { 0x12B6, "GetNoBleedoutRecovery",            "",                     0x29000000, "", 0, { } }, 
     { 0x12B7, "SetNoBleedoutRecovery",            "",                     0x09000000, "", 1, {
               { 0x0001, 0 },  } }, 
     { 0x12B8, "EPMagic_SpellHasSkill",            "",                     0x28000000, "", 1, {
               { 0x0005, 0 },  } }, 
     { 0x12B9, "IsAttackType",                     "",                     0x28000000, "", 1, {
               { 0x003B, 0 },  } }, 
     { 0x12BA, "IsAllowedToFly",                   "",                     0x29000000, "", 0, { } }, 
     { 0x12BB, "HasMagicEffectKeyword",            "",                     0x29000000, "", 1, {
               { 0x003B, 0 },  } }, 
     { 0x12BC, "IsCommandedActor",                 "",                     0x29000000, "", 0, { } }, 
     { 0x12BD, "IsStaggered",                      "",                     0x29000000, "", 0, { } }, 
     { 0x12BE, "IsRecoiling",                      "",                     0x29000000, "", 0, { } }, 
     { 0x12BF, "IsExitingInteractionQuick",        "",                     0x29000000, "", 0, { } }, 
     { 0x12C0, "IsPathing",                        "",                     0x29000000, "", 0, { } }, 
     { 0x12C1, "GetShouldHelp",                    "",                     0x29000000, "", 1, {
               { 0x0006, 0 },  } }, 
     { 0x12C2, "HasBoundWeaponEquipped",           "",                     0x29000000, "", 1, {
               { 0x0044, 0 },  } }, 
     { 0x12C3, "GetCombatTargetHasKeyword",        "gcthk",                0x19000000, "", 1, {
               { 0x003B, 0 },  } }, 
     { 0x12C4, "UpdateLevel",                      "",                     0x08000000, "Update the player's level based on current skill usage amounts.", 0, { } }, 
     { 0x12C5, "GetCombatGroupMemberCount",        "gcgmc",                0x19000000, "", 0, { } }, 
     { 0x12C6, "IsIgnoringCombat",                 "",                     0x29000000, "", 0, { } }, 
     { 0x12C7, "GetLightLevel",                    "gll",                  0x19000000, "", 0, { } }, 
     { 0x12C8, "SavePCFace",                       "spf",                  0x08000000, "", 1, {
               { 0x0000, 0 },  } }, 
     { 0x12C9, "SpellHasCastingPerk",              "",                     0x28000000, "", 1, {
               { 0x0027, 0 },  } }, 
     { 0x12CA, "IsBeingRidden",                    "",                     0x29000000, "", 0, { } }, 
     { 0x12CB, "IsUndead",                         "",                     0x29000000, "", 0, { } }, 
     { 0x12CC, "GetRealHoursPassed",               "",                     0x28000000, "", 0, { } }, 
     { 0x12CD, "UnequipAll",                       "",                     0x08000000, "", 0, { } }, 
     { 0x12CE, "IsUnlockedDoor",                   "",                     0x29000000, "", 0, { } }, 
     { 0x12CF, "IsHostileToActor",                 "",                     0x29000000, "", 1, {
               { 0x0006, 0 },  } }, 
     { 0x12D0, "GetTargetHeight",                  "",                     0x29000000, "Get the delta on z between two references", 1, {
               { 0x0004, 0 },  } }, 
     { 0x12D1, "IsPoison",                         "",                     0x29000000, "Is the object a Poison potion", 0, { } }, 
     { 0x12D2, "WornApparelHasKeywordCount",       "",                     0x29000000, "", 1, {
               { 0x003B, 0 },  } }, 
     { 0x12D3, "GetItemHealthPercent",             "",                     0x29000000, "", 0, { } }, 
     { 0x12D4, "EffectWasDualCast",                "",                     0x29000000, "", 0, { } }, 
     { 0x12D5, "GetKnockStateEnum",                "",                     0x29000000, "", 0, { } }, 
     { 0x12D6, "DoesNotExist",                     "",                     0x28000000, "", 0, { } }, 
};

const dword g_SrFunctionCount = sizeof(g_SrFunctions)/sizeof(g_SrFunctions[0]);
/*===========================================================================
 *		End of Function Data Table
 *=========================================================================*/


/*===========================================================================
 *
 * Begin Function Parameter Type String Table
 *
 *=========================================================================*/
BEGIN_STRINGVALUE(s_SrFunctionParamTypes)
   ADD_STRINGVALUE( 0,  "String")
   ADD_STRINGVALUE( 1,  "Integer")
   ADD_STRINGVALUE( 2,  "Float")
   ADD_STRINGVALUE( 3,  "ObjectID")
   ADD_STRINGVALUE( 4,  "Reference")
   ADD_STRINGVALUE( 5,  "Actor Value")
   ADD_STRINGVALUE( 6,  "Actor")
   ADD_STRINGVALUE( 7,  "Spell")
   ADD_STRINGVALUE( 8,  "Axis")
   ADD_STRINGVALUE( 9,  "Cell")
   ADD_STRINGVALUE( 10, "Animation Group")
   ADD_STRINGVALUE( 11, "Magic Item")
   ADD_STRINGVALUE( 12, "Sound")
   ADD_STRINGVALUE( 13, "Topic")
   ADD_STRINGVALUE( 14, "Quest")
   ADD_STRINGVALUE( 15, "Race")
   ADD_STRINGVALUE( 16, "Class")
   ADD_STRINGVALUE( 17, "Faction")
   ADD_STRINGVALUE( 18, "Gender")
   ADD_STRINGVALUE( 19, "Global")
   ADD_STRINGVALUE( 20, "Furniture")
   ADD_STRINGVALUE( 21, "Weapon")
   ADD_STRINGVALUE( 22, "Variable Name")
   ADD_STRINGVALUE( 23, "Stage")
   ADD_STRINGVALUE( 24, "Map Marker")
   ADD_STRINGVALUE( 25, "Actor Base")
   ADD_STRINGVALUE( 26, "Container")
   ADD_STRINGVALUE( 27, "WorldSpace")
   ADD_STRINGVALUE( 28, "Crime Type")
   ADD_STRINGVALUE( 29, "Package")
   ADD_STRINGVALUE( 30, "Combat Style")
   ADD_STRINGVALUE( 31, "Magic Effect")
   ADD_STRINGVALUE( 32, "Form Type")
   ADD_STRINGVALUE( 33, "Weather ID")
   ADD_STRINGVALUE( 34, "Unknown34")
   ADD_STRINGVALUE( 35, "Owner")
   ADD_STRINGVALUE( 36, "Effect Shader ID")
   ADD_STRINGVALUE( 37, "Form List")
   ADD_STRINGVALUE( 38, "Unknown38")
   ADD_STRINGVALUE( 39, "Perk")
   ADD_STRINGVALUE( 40, "Note")
   ADD_STRINGVALUE( 41, "Miscellaneous Stat")
   ADD_STRINGVALUE( 42, "ImageSpace Modifier ID")
   ADD_STRINGVALUE( 43, "ImageSpace")
   ADD_STRINGVALUE( 44, "Unknown44")
   ADD_STRINGVALUE( 45, "Unknown45")
   ADD_STRINGVALUE( 46, "Event Function")
   ADD_STRINGVALUE( 47, "Event Member")
   ADD_STRINGVALUE( 48, "Data")
   ADD_STRINGVALUE( 49, "VoiceType")
   ADD_STRINGVALUE( 50, "EncounterZone")
   ADD_STRINGVALUE( 51, "Idle Form")
   ADD_STRINGVALUE( 52, "Message")
   ADD_STRINGVALUE( 53, "EquipableItem")
   ADD_STRINGVALUE( 54, "Alignment")
   ADD_STRINGVALUE( 55, "EquipType")
   ADD_STRINGVALUE( 56, "ObjectID")
   ADD_STRINGVALUE( 57, "Music")
   ADD_STRINGVALUE( 58, "CriticalStage")
   ADD_STRINGVALUE( 59, "Keyword")
   ADD_STRINGVALUE( 60, "LocationRefType")
   ADD_STRINGVALUE( 61, "Location")
   ADD_STRINGVALUE( 62, "Form")
   ADD_STRINGVALUE( 63, "QuestAlias")
   ADD_STRINGVALUE( 64, "Shout")
   ADD_STRINGVALUE( 65, "Word Of Power")
   ADD_STRINGVALUE( 66, "Unknown66")
   ADD_STRINGVALUE( 67, "Scene")
   ADD_STRINGVALUE( 68, "Casting Source")
   ADD_STRINGVALUE( 69, "AssociationType")
   ADD_STRINGVALUE( 70, "Ward State")
   ADD_STRINGVALUE( 71, "PackageData (Possibly Null)")
   ADD_STRINGVALUE( 72, "PackageData (Numeric)")
   ADD_STRINGVALUE( 73, "Furniture Anim Type")
   ADD_STRINGVALUE( 74, "Furniture Entry Type")
   ADD_STRINGVALUE( 75, "Unknown75")
   ADD_STRINGVALUE( 76, "VM Variable Name")
   ADD_STRINGVALUE( 77, "Reference Effect")
   ADD_STRINGVALUE( 78, "PackageData (Location)")
   ADD_STRINGVALUE( 79, "SoundCategory")
   ADD_STRINGVALUE( 80, "Skill Action")
   ADD_STRINGVALUE( 81, "Knowable Form")
   ADD_STRINGVALUE( 82, "Region")
   ADD_STRINGVALUE( 83, "Action")
END_STRINGVALUE()
/*===========================================================================
 *		End of Function Parameter Type String Table
 *=========================================================================*/

 
/*===========================================================================
 *
 * Begin Function Lookup Functions
 *
 *=========================================================================*/
const SSCHAR* GetSrFunctionParamTypeString (const int Value) 
{
	return s_SrFunctionParamTypesMap.FindValue(Value); 
}


bool GetSrFunctionParamTypeValue (int& Value, const SSCHAR* pString) 
{
	return s_SrFunctionParamTypesMap.FindString(Value, pString); 
}


srfunction_t* GetSrFunction	(const dword OpCode) 
{
	static TGenRefPtrMap<dword, srfunction_t, dword> s_OpCodeFuncMap;
	static bool s_FuncMapInit = false;

	if (!s_FuncMapInit)
	{
		for (dword i = 0; i < g_SrFunctionCount; ++i)
		{
			s_OpCodeFuncMap.SetAt(g_SrFunctions[i].OpCode, &g_SrFunctions[i]);
		}

		s_FuncMapInit = true;
	}

	return s_OpCodeFuncMap.Lookup(OpCode);
}


srfunction_t* GetSrFunction	(const char* pString) 
{
	static TGenRefPtrMap<const SSCHAR*, srfunction_t, const SSCHAR*> s_StringFuncMap;
	static bool s_FuncMapInit = false;

	if (!s_FuncMapInit)
	{
		for (dword i = 0; i < g_SrFunctionCount; ++i)
		{
			s_StringFuncMap.SetAt(g_SrFunctions[i].Name, &g_SrFunctions[i]);
		}

		s_FuncMapInit = true;
	}

	return s_StringFuncMap.Lookup(pString);
}
/*===========================================================================
 *		End of Function Lookup Functions
 *=========================================================================*/


/*===========================================================================
 *
 * Begin Function - bool IsSrFunctionParamFormID(ParamType);
 *
 * TODO: Ensure all FormID records are included below.
 *
 *=========================================================================*/
bool IsSrFunctionParamFormID (const dword ParamType)
{
	switch (ParamType)
	{
	case 3:
	case 4:
	case 6:
	case 7:
	case 9:
	case 10:
	case 11:
	case 12:
	case 13:
	case 14:
	case 15:
	case 16:
	case 17:
	case 19:
	case 20:
	case 21:
	case 24:
	case 25:
	case 26:
	case 27:
	case 28:
	case 29:
	case 30:
	case 31:
	case 32:
	case 33:
	case 35:
	case 36:
	case 39:
	case 40:
	case 43:
	case 52:
	case 53:
	case 59:
	case 56:
	case SR_FUNCPARAM_LOCREFTYPE:
	case 64:
		return true;
	};

	return false;
}
/*===========================================================================
 *		End of Functions IsSrFunctionParamFormID()
 *=========================================================================*/


/*===========================================================================
 *
 * Begin Function - bool IsSrFunctionParamString(ParamType);
 *
 * TODO: Ensure all correct FormID records are included below.
 *
 *=========================================================================*/
bool IsSrFunctionParamString (const dword ParamType)
{
	switch (ParamType)
	{
	case SR_FUNCPARAM_STRING:
	case SR_FUNCPARAM_VARNAME:
	case SR_FUNCPARAM_NOTE:
	case SR_FUNCPARAM_VMVARNAME:
		return true;
	};

	return false;
}
/*===========================================================================
 *		End of Functions IsSrFunctionParamString()
 *=========================================================================*/



bool priv_SrCheckFuncParamFormid (CSString& String, CSrRecordHandler* pRecordHandler)
{
	CSrRecord* pRecord = pRecordHandler->FindGeneralID(String);
	return pRecord != NULL;
}


bool priv_SrCheckFuncParamFormid (CSString& String, const srrectype_t Type, CSrRecordHandler* pRecordHandler)
{
	CSrRecord* pRecord = pRecordHandler->FindGeneralID(String);
	if (pRecord == NULL) return false;
	return (pRecord->GetRecordType() == Type);
}


bool priv_SrCheckFuncParamRecTypes (CSString& String, const CSrRecTypeArray& Types, CSrRecordHandler* pRecordHandler)
{
	CSrRecord* pRecord = pRecordHandler->FindGeneralID(String);
	if (pRecord == NULL) return false;

	for (dword i = 0; i < Types.GetSize(); ++i)
	{
		if (pRecord->GetRecordType() == Types[i]) return true;
	}

	return false;
}


bool SrCheckFunctionParam (const char* pString, const dword ParamType, CSrRecordHandler* pRecordHandler)
{
	CSString   StringValue(pString);
	int        Value;
	char*      pEndPtr;

	if (pString == NULL || pRecordHandler == NULL) return false;
	StringValue.Trim();

	switch (ParamType)
	{
		case SR_FUNCPARAM_UNKNOWN		 : return false;
		case SR_FUNCPARAM_STRING		 : return true;
		case SR_FUNCPARAM_STAGE			 : 
		case SR_FUNCPARAM_INTEGER		 : 
			strtoul(StringValue, &pEndPtr, 0);
			return !(*pEndPtr != '\0' && !isspace(*pEndPtr));
		case SR_FUNCPARAM_FLOAT			 :
			strtod(StringValue, &pEndPtr);
			return !(*pEndPtr != '\0' && !isspace(*pEndPtr));
		case SR_FUNCPARAM_OBJECTID3		 : return false;
		case SR_FUNCPARAM_REFERENCE		 : return priv_SrCheckFuncParamFormid(StringValue, SR_NAME_REFR, pRecordHandler);
		case SR_FUNCPARAM_ACTORVALUE	 : return GetSrActorValueValue(Value, StringValue);
		case SR_FUNCPARAM_ACTOR			 : return priv_SrCheckFuncParamFormid(StringValue, SR_NAME_NPC_, pRecordHandler);
		case SR_FUNCPARAM_SPELLITEM		 : return priv_SrCheckFuncParamFormid(StringValue, SR_NAME_SPEL, pRecordHandler);
		case SR_FUNCPARAM_AXIS			 : return GetSrAxisTypeValue(Value, StringValue);
		case SR_FUNCPARAM_CELL			 : return priv_SrCheckFuncParamFormid(StringValue, SR_NAME_CELL, pRecordHandler);
		case SR_FUNCPARAM_ANIMGROUP		 : return false;
		case SR_FUNCPARAM_MAGICITEM		 : return priv_SrCheckFuncParamRecTypes(StringValue, GetSrMagicItemRecordTypes(), pRecordHandler);
		case SR_FUNCPARAM_SOUND			 : return priv_SrCheckFuncParamFormid(StringValue, SR_NAME_REFR, pRecordHandler);
		case SR_FUNCPARAM_TOPIC			 : return priv_SrCheckFuncParamFormid(StringValue, SR_NAME_INFO, pRecordHandler);
		case SR_FUNCPARAM_QUEST			 : return priv_SrCheckFuncParamFormid(StringValue, SR_NAME_QUST, pRecordHandler);
		case SR_FUNCPARAM_RACE			 : return priv_SrCheckFuncParamFormid(StringValue, SR_NAME_RACE, pRecordHandler);
		case SR_FUNCPARAM_CLASS			 : return priv_SrCheckFuncParamFormid(StringValue, SR_NAME_CLAS, pRecordHandler);
		case SR_FUNCPARAM_FACTION		 : return priv_SrCheckFuncParamFormid(StringValue, SR_NAME_FACT, pRecordHandler);
		case SR_FUNCPARAM_GENDER		 : return GetSrGenderTypeValue(Value, StringValue);
		case SR_FUNCPARAM_GLOBAL		 : return priv_SrCheckFuncParamFormid(StringValue, SR_NAME_GLOB, pRecordHandler);
		case SR_FUNCPARAM_FURNITURE		 : return priv_SrCheckFuncParamFormid(StringValue, SR_NAME_FURN, pRecordHandler);
		case SR_FUNCPARAM_WEAPON		 : return priv_SrCheckFuncParamFormid(StringValue, SR_NAME_WEAP, pRecordHandler);
		case SR_FUNCPARAM_VARNAME		 : return false;
		case SR_FUNCPARAM_MAPMARKER		 : return false;
		case SR_FUNCPARAM_ACTORBASE		 : return priv_SrCheckFuncParamFormid(StringValue, SR_NAME_NPC_, pRecordHandler);
		case SR_FUNCPARAM_CONTAINER		 : return priv_SrCheckFuncParamFormid(StringValue, SR_NAME_CONT, pRecordHandler);
		case SR_FUNCPARAM_WORLDSPACE	 : return priv_SrCheckFuncParamFormid(StringValue, SR_NAME_WRLD, pRecordHandler);
		case SR_FUNCPARAM_CRIME			 : return GetSrCrimeTypeValue(Value, StringValue);
		case SR_FUNCPARAM_PACKAGE		 : return priv_SrCheckFuncParamFormid(StringValue, SR_NAME_PACK, pRecordHandler);
		case SR_FUNCPARAM_COMBATSTYLE	 : return priv_SrCheckFuncParamFormid(StringValue, SR_NAME_CSTY, pRecordHandler);
		case SR_FUNCPARAM_MAGICEFFECT	 : return priv_SrCheckFuncParamFormid(StringValue, SR_NAME_MGEF, pRecordHandler);
		case SR_FUNCPARAM_FORMTYPE		 : return priv_SrCheckFuncParamFormid(StringValue, pRecordHandler);
		case SR_FUNCPARAM_WEATHER		 : return priv_SrCheckFuncParamFormid(StringValue, SR_NAME_WTHR, pRecordHandler);
		case SR_FUNCPARAM_34			 : return false;
		case SR_FUNCPARAM_OWNER			 : return false;
		case SR_FUNCPARAM_EFFECTSHADER	 : return priv_SrCheckFuncParamFormid(StringValue, SR_NAME_EFSH, pRecordHandler);
		case SR_FUNCPARAM_FORMLIST		 : return priv_SrCheckFuncParamFormid(StringValue, SR_NAME_FLST, pRecordHandler);
		case SR_FUNCPARAM_38			 : return false;
		case SR_FUNCPARAM_PERK			 : return priv_SrCheckFuncParamFormid(StringValue, SR_NAME_PERK, pRecordHandler);
		case SR_FUNCPARAM_NOTE			 : return false;
		case SR_FUNCPARAM_MISCSTAT		 : return false;
		case SR_FUNCPARAM_IMAGESPACEID	 : return false;
		case SR_FUNCPARAM_IMAGESPACE	 : return priv_SrCheckFuncParamFormid(StringValue, SR_NAME_IMGS, pRecordHandler);
		case SR_FUNCPARAM_44			 : return false;
		case SR_FUNCPARAM_45			 : return false;
		case SR_FUNCPARAM_EVENTFUNC		 : return false;
		case SR_FUNCPARAM_EVENTMEMBER	 : return false;
		case SR_FUNCPARAM_DATA			 : return false;
		case SR_FUNCPARAM_VOICETYPE		 : return priv_SrCheckFuncParamFormid(StringValue, SR_NAME_VTYP, pRecordHandler);
		case SR_FUNCPARAM_ENCOUNTERZONE	 : return priv_SrCheckFuncParamFormid(StringValue, SR_NAME_ECZN, pRecordHandler);
		case SR_FUNCPARAM_IDLE			 : return priv_SrCheckFuncParamFormid(StringValue, SR_NAME_IDLE, pRecordHandler);
		case SR_FUNCPARAM_MESSAGE		 : return priv_SrCheckFuncParamFormid(StringValue, SR_NAME_MESG, pRecordHandler);
		case SR_FUNCPARAM_EQUIPABLEITEM  : return priv_SrCheckFuncParamRecTypes(StringValue, GetSrEquipableRecordTypes(), pRecordHandler);
		case SR_FUNCPARAM_ALIGNMENT		 : return false;
		case SR_FUNCPARAM_EQUIPTYPE		 : return priv_SrCheckFuncParamFormid(StringValue, SR_NAME_ETYP, pRecordHandler);
		case SR_FUNCPARAM_OBJECTID56	 : return false;	
		case SR_FUNCPARAM_MUSIC			 : return priv_SrCheckFuncParamFormid(StringValue, SR_NAME_MUSC, pRecordHandler);
		case SR_FUNCPARAM_CRITICALSTAGE	 : return GetSrCriticalStageTypeValue(Value, StringValue);
		case SR_FUNCPARAM_KEYWORD		 : return priv_SrCheckFuncParamFormid(StringValue, SR_NAME_KYWD, pRecordHandler);
		case SR_FUNCPARAM_LOCREFTYPE	 : return priv_SrCheckFuncParamFormid(StringValue, SR_NAME_LCTN, pRecordHandler);
		case SR_FUNCPARAM_LOCATION		 : return priv_SrCheckFuncParamFormid(StringValue, SR_NAME_LCRT, pRecordHandler);
		case SR_FUNCPARAM_FORM			 : return false;
		case SR_FUNCPARAM_QUESTALIAS	 : return false;
		case SR_FUNCPARAM_SHOUT			 : return priv_SrCheckFuncParamFormid(StringValue, SR_NAME_SHOU, pRecordHandler);
		case SR_FUNCPARAM_WORDOFPOWER	 : return priv_SrCheckFuncParamFormid(StringValue, SR_NAME_WOOP, pRecordHandler);
		case SR_FUNCPARAM_66			 : return false;	
		case SR_FUNCPARAM_SCENE			 : return priv_SrCheckFuncParamFormid(StringValue, SR_NAME_SCEN, pRecordHandler);
		case SR_FUNCPARAM_CASTSOURCE	 : return GetSrCastSourceTypeValue(Value, StringValue);
		case SR_FUNCPARAM_ASSOCTYPE		 : return priv_SrCheckFuncParamFormid(StringValue, SR_NAME_ASTP, pRecordHandler);
		case SR_FUNCPARAM_WARDSTATE		 : return GetSrWardStateTypeValue(Value, StringValue);
		case SR_FUNCPARAM_PACKDATANULL	 : return false;
		case SR_FUNCPARAM_PACKDATANUM	 : return false;
		case SR_FUNCPARAM_FURNANIM		 : return GetSrFurnitureAnimTypeValue(Value, StringValue);
		case SR_FUNCPARAM_FURNENTRY		 : return GetSrFurnitureEntryTypeValue(Value, StringValue);
		case SR_FUNCPARAM_75			 : return false;
		case SR_FUNCPARAM_VMVARNAME		 : return false;
		case SR_FUNCPARAM_REFEFEFCT		 : return false;
		case SR_FUNCPARAM_PACKDATALOC	 : return false;
		case SR_FUNCPARAM_SOUNDCATE		 : return priv_SrCheckFuncParamFormid(StringValue, SR_NAME_SNCT, pRecordHandler);
		case SR_FUNCPARAM_SKILLACTION	 : return GetSrSkillActionTypeValue(Value, StringValue);
		case SR_FUNCPARAM_KNOWFORM		 : return priv_SrCheckFuncParamRecTypes(StringValue, GetSrKnowableRecordTypes(), pRecordHandler);
		case SR_FUNCPARAM_REGION		 : return priv_SrCheckFuncParamFormid(StringValue, SR_NAME_REGN, pRecordHandler);
		case SR_FUNCPARAM_ACTION		 : return priv_SrCheckFuncParamFormid(StringValue, SR_NAME_AACT, pRecordHandler);
		default:						
			return false;
	}

	return true;
}


bool priv_SrFuncParamFormidToString (CSString& Output, const dword ParamValue, CSrRecordHandler* pRecordHandler)
{
	CSrRecord* pRecord = pRecordHandler->FindFormID(ParamValue);
	CSrIdRecord* pIDRecord = SrCastClassNull(CSrIdRecord, pRecord);

	if (pIDRecord)
	{
		Output = pIDRecord->GetEditorID();
		return true;
	}
	
	Output.Format("0x%08X", ParamValue);
	return false;
}


bool SrFunctionParamToString (CSString& Output, const dword ParamType, const dword ParamValue, CSrRecordHandler* pRecordHandler)
{
	const char* pResult = NULL;

	if (pRecordHandler == NULL) return false;

	switch (ParamType)
	{
		case SR_FUNCPARAM_UNKNOWN		 : return false;
		case SR_FUNCPARAM_STRING		 : 
			return true;
		case SR_FUNCPARAM_STAGE			 : 
		case SR_FUNCPARAM_INTEGER		 : 
			Output.Format("%d", ParamValue);
			return true;
		case SR_FUNCPARAM_FLOAT			 :
			Output.Format("%g", *(float *)&ParamValue);
			return true;
		case SR_FUNCPARAM_OBJECTID3		 : 
			Output.Format("0x%08X", ParamValue);
			return true;
		case SR_FUNCPARAM_REFERENCE		 : return priv_SrFuncParamFormidToString(Output, ParamValue, pRecordHandler);
		case SR_FUNCPARAM_ACTORVALUE	 : pResult = GetSrActorValueString((int) ParamValue); if (pResult == NULL) return false; Output = pResult; return true;
		case SR_FUNCPARAM_ACTOR			 : return priv_SrFuncParamFormidToString(Output, ParamValue, pRecordHandler);
		case SR_FUNCPARAM_SPELLITEM		 : return priv_SrFuncParamFormidToString(Output, ParamValue, pRecordHandler);
		case SR_FUNCPARAM_AXIS			 : pResult = GetSrAxisTypeString(ParamValue); if (pResult == NULL) return false; Output = pResult; return true;
		case SR_FUNCPARAM_CELL			 : return priv_SrFuncParamFormidToString(Output, ParamValue, pRecordHandler);
		case SR_FUNCPARAM_ANIMGROUP		 : 
			Output.Format("0x%08X", ParamValue);
			return true;
		case SR_FUNCPARAM_MAGICITEM		 : return priv_SrFuncParamFormidToString(Output, ParamValue, pRecordHandler);
		case SR_FUNCPARAM_SOUND			 : return priv_SrFuncParamFormidToString(Output, ParamValue, pRecordHandler);
		case SR_FUNCPARAM_TOPIC			 : return priv_SrFuncParamFormidToString(Output, ParamValue, pRecordHandler);
		case SR_FUNCPARAM_QUEST			 : return priv_SrFuncParamFormidToString(Output, ParamValue, pRecordHandler);
		case SR_FUNCPARAM_RACE			 : return priv_SrFuncParamFormidToString(Output, ParamValue, pRecordHandler);
		case SR_FUNCPARAM_CLASS			 : return priv_SrFuncParamFormidToString(Output, ParamValue, pRecordHandler);
		case SR_FUNCPARAM_FACTION		 : return priv_SrFuncParamFormidToString(Output, ParamValue, pRecordHandler);
		case SR_FUNCPARAM_GENDER		 : pResult = GetSrGenderTypeString(ParamValue); if (pResult == NULL) return false; Output = pResult; return true;
		case SR_FUNCPARAM_GLOBAL		 : return priv_SrFuncParamFormidToString(Output, ParamValue, pRecordHandler);
		case SR_FUNCPARAM_FURNITURE		 : return priv_SrFuncParamFormidToString(Output, ParamValue, pRecordHandler);
		case SR_FUNCPARAM_WEAPON		 : return priv_SrFuncParamFormidToString(Output, ParamValue, pRecordHandler);
		case SR_FUNCPARAM_VARNAME		 : 
			Output.Format("0x%08X", ParamValue);
			return true;
		case SR_FUNCPARAM_MAPMARKER		 : 
			Output.Format("0x%08X", ParamValue);
			return true;
		case SR_FUNCPARAM_ACTORBASE		 : return priv_SrFuncParamFormidToString(Output, ParamValue, pRecordHandler);
		case SR_FUNCPARAM_CONTAINER		 : return priv_SrFuncParamFormidToString(Output, ParamValue, pRecordHandler);
		case SR_FUNCPARAM_WORLDSPACE	 : return priv_SrFuncParamFormidToString(Output, ParamValue, pRecordHandler);
		case SR_FUNCPARAM_CRIME			 : pResult = GetSrCrimeTypeString(ParamValue); if (pResult == NULL) return false; Output = pResult; return true;
		case SR_FUNCPARAM_PACKAGE		 : return priv_SrFuncParamFormidToString(Output, ParamValue, pRecordHandler);
		case SR_FUNCPARAM_COMBATSTYLE	 : return priv_SrFuncParamFormidToString(Output, ParamValue, pRecordHandler);
		case SR_FUNCPARAM_MAGICEFFECT	 : return priv_SrFuncParamFormidToString(Output, ParamValue, pRecordHandler);
		case SR_FUNCPARAM_FORMTYPE		 : return priv_SrFuncParamFormidToString(Output, ParamValue, pRecordHandler);
		case SR_FUNCPARAM_WEATHER		 : return priv_SrFuncParamFormidToString(Output, ParamValue, pRecordHandler);
		case SR_FUNCPARAM_34			 : 
			Output.Format("0x%08X", ParamValue);
			return true;
		case SR_FUNCPARAM_OWNER			 : 
			Output.Format("0x%08X", ParamValue);
			return true;
		case SR_FUNCPARAM_EFFECTSHADER	 : return priv_SrFuncParamFormidToString(Output, ParamValue, pRecordHandler);
		case SR_FUNCPARAM_FORMLIST		 : return priv_SrFuncParamFormidToString(Output, ParamValue, pRecordHandler);
		case SR_FUNCPARAM_38			 : 
			Output.Format("0x%08X", ParamValue);
			return true;
		case SR_FUNCPARAM_PERK			 : return priv_SrFuncParamFormidToString(Output, ParamValue, pRecordHandler);
		case SR_FUNCPARAM_NOTE			 : 
			Output.Format("0x%08X", ParamValue);
			return true;
		case SR_FUNCPARAM_MISCSTAT		 : 
			Output.Format("0x%08X", ParamValue);
			return true;
		case SR_FUNCPARAM_IMAGESPACEID	 : 
			Output.Format("0x%08X", ParamValue);
			return true;
		case SR_FUNCPARAM_IMAGESPACE	 : return priv_SrFuncParamFormidToString(Output, ParamValue, pRecordHandler);
		case SR_FUNCPARAM_44			 : 
			Output.Format("0x%08X", ParamValue);
			return true;
		case SR_FUNCPARAM_45			 : 
			Output.Format("0x%08X", ParamValue);
			return true;
		case SR_FUNCPARAM_EVENTFUNC		 :
			Output.Format("0x%08X", ParamValue);
			return true;
		case SR_FUNCPARAM_EVENTMEMBER	 : 
			Output.Format("0x%08X", ParamValue);
			return true;
		case SR_FUNCPARAM_DATA			 : 
			Output.Format("0x%08X", ParamValue);
			return true;
		case SR_FUNCPARAM_VOICETYPE		 : return priv_SrFuncParamFormidToString(Output, ParamValue, pRecordHandler);
		case SR_FUNCPARAM_ENCOUNTERZONE	 : return priv_SrFuncParamFormidToString(Output, ParamValue, pRecordHandler);
		case SR_FUNCPARAM_IDLE			 : return priv_SrFuncParamFormidToString(Output, ParamValue, pRecordHandler);
		case SR_FUNCPARAM_MESSAGE		 : return priv_SrFuncParamFormidToString(Output, ParamValue, pRecordHandler);
		case SR_FUNCPARAM_EQUIPABLEITEM  : return priv_SrFuncParamFormidToString(Output, ParamValue, pRecordHandler);
		case SR_FUNCPARAM_ALIGNMENT		 : 
			Output.Format("0x%08X", ParamValue);
			return true;
		case SR_FUNCPARAM_EQUIPTYPE		 : return priv_SrFuncParamFormidToString(Output, ParamValue, pRecordHandler);
		case SR_FUNCPARAM_OBJECTID56	 : 
			Output.Format("0x%08X", ParamValue);
			return true;
		case SR_FUNCPARAM_MUSIC			 : return priv_SrFuncParamFormidToString(Output, ParamValue, pRecordHandler);
		case SR_FUNCPARAM_CRITICALSTAGE	 : pResult = GetSrCriticalStageTypeString(ParamValue); if (pResult == NULL) return false; Output = pResult; return true;
		case SR_FUNCPARAM_KEYWORD		 : return priv_SrFuncParamFormidToString(Output, ParamValue, pRecordHandler);
		case SR_FUNCPARAM_LOCREFTYPE	 : return priv_SrFuncParamFormidToString(Output, ParamValue, pRecordHandler);
		case SR_FUNCPARAM_LOCATION		 : return priv_SrFuncParamFormidToString(Output, ParamValue, pRecordHandler);
		case SR_FUNCPARAM_FORM			 : return priv_SrFuncParamFormidToString(Output, ParamValue, pRecordHandler);
		case SR_FUNCPARAM_QUESTALIAS	 : 
			Output.Format("0x%08X", ParamValue);
			return true;
		case SR_FUNCPARAM_SHOUT			 : return priv_SrFuncParamFormidToString(Output, ParamValue, pRecordHandler);
		case SR_FUNCPARAM_WORDOFPOWER	 : return priv_SrFuncParamFormidToString(Output, ParamValue, pRecordHandler);
		case SR_FUNCPARAM_66			 : 
			Output.Format("0x%08X", ParamValue);
			return true;
		case SR_FUNCPARAM_SCENE			 : return priv_SrFuncParamFormidToString(Output, ParamValue, pRecordHandler);
		case SR_FUNCPARAM_CASTSOURCE	 : pResult = GetSrCastSourceTypeString(ParamValue); if (pResult == NULL) return false; Output = pResult; return true;
		case SR_FUNCPARAM_ASSOCTYPE		 : return priv_SrFuncParamFormidToString(Output, ParamValue, pRecordHandler);
		case SR_FUNCPARAM_WARDSTATE		 : pResult = GetSrWardStateTypeString(ParamValue); if (pResult == NULL) return false; Output = pResult; return true;
		case SR_FUNCPARAM_PACKDATANULL	 : 
			Output.Format("0x%08X", ParamValue);
			return true;
		case SR_FUNCPARAM_PACKDATANUM	 : 
			Output.Format("0x%08X", ParamValue);
			return true;
		case SR_FUNCPARAM_FURNANIM		 : pResult = GetSrFurnitureAnimTypeString(ParamValue); if (pResult == NULL) return false; Output = pResult; return true;
		case SR_FUNCPARAM_FURNENTRY		 : pResult = GetSrFurnitureEntryTypeString(ParamValue); if (pResult == NULL) return false; Output = pResult; return true;
		case SR_FUNCPARAM_75			 : 
			Output.Format("0x%08X", ParamValue);
			return true;
		case SR_FUNCPARAM_VMVARNAME		 : 
			Output.Format("0x%08X", ParamValue);
			return true;
		case SR_FUNCPARAM_REFEFEFCT		 : 
			Output.Format("0x%08X", ParamValue);
			return true;
		case SR_FUNCPARAM_PACKDATALOC	 : 
			Output.Format("0x%08X", ParamValue);
			return true;
		case SR_FUNCPARAM_SOUNDCATE		 : return priv_SrFuncParamFormidToString(Output, ParamValue, pRecordHandler);
		case SR_FUNCPARAM_SKILLACTION	 : pResult = GetSrSkillActionTypeString(ParamValue); if (pResult == NULL) return false; Output = pResult; return true;
		case SR_FUNCPARAM_KNOWFORM		 : return priv_SrFuncParamFormidToString(Output, ParamValue, pRecordHandler);
		case SR_FUNCPARAM_REGION		 : return priv_SrFuncParamFormidToString(Output, ParamValue, pRecordHandler);
		case SR_FUNCPARAM_ACTION		 : return priv_SrFuncParamFormidToString(Output, ParamValue, pRecordHandler);
		default:				
			Output.Format("0x%08X", ParamValue);
			return false;
	}

	return true;
}


bool priv_SrFuncParamFormidFromString (int& ParamValue, CSString& String, CSrRecordHandler* pRecordHandler)
{
	char*		pEndPtr;

	if (String.IsEmpty())
	{
		ParamValue = 0;
		return true;
	}

	CSrRecord* pRecord = pRecordHandler->FindGeneralID(String);

	if (pRecord != NULL) 
	{
		ParamValue = pRecord->GetFormID();
		return true;
	}

	ParamValue = strtoul(String, &pEndPtr, 0);
	return *pEndPtr == '\0' || isspace(*pEndPtr);
}


bool SrFunctionParamFromString (int& ParamValue, const char* pString, const dword ParamType, CSrRecordHandler* pRecordHandler)
{
	CSString	StringValue(pString);
	char*		pEndPtr;
	float		fValue;

	if (pString == NULL || pRecordHandler == NULL) return false;
	StringValue.Trim();

	switch (ParamType)
	{
		case SR_FUNCPARAM_UNKNOWN		 : return false;
		case SR_FUNCPARAM_STRING		 : return false;
		case SR_FUNCPARAM_STAGE			 : 
		case SR_FUNCPARAM_INTEGER		 : 
			ParamValue = strtoul(StringValue, &pEndPtr, 0);
			return false;
		case SR_FUNCPARAM_FLOAT			 :
			fValue = (float) strtod(StringValue, &pEndPtr);
			ParamValue = *(dword *) &fValue;
			return false;
		case SR_FUNCPARAM_OBJECTID3		 : 
			ParamValue = strtoul(StringValue, &pEndPtr, 0);
			return false;
		case SR_FUNCPARAM_REFERENCE		 : return priv_SrFuncParamFormidFromString(ParamValue, StringValue, pRecordHandler);
		case SR_FUNCPARAM_ACTORVALUE	 : return GetSrActorValueValue(ParamValue, StringValue);
		case SR_FUNCPARAM_ACTOR			 : return priv_SrFuncParamFormidFromString(ParamValue, StringValue, pRecordHandler);
		case SR_FUNCPARAM_SPELLITEM		 : return priv_SrFuncParamFormidFromString(ParamValue, StringValue, pRecordHandler);
		case SR_FUNCPARAM_AXIS			 : return GetSrAxisTypeValue(ParamValue, StringValue);
		case SR_FUNCPARAM_CELL			 : return priv_SrFuncParamFormidFromString(ParamValue, StringValue, pRecordHandler);
		case SR_FUNCPARAM_ANIMGROUP		 : 
			ParamValue = strtoul(StringValue, &pEndPtr, 0);
			return false;
		case SR_FUNCPARAM_MAGICITEM		 : return priv_SrFuncParamFormidFromString(ParamValue, StringValue, pRecordHandler);
		case SR_FUNCPARAM_SOUND			 : return priv_SrFuncParamFormidFromString(ParamValue, StringValue, pRecordHandler);
		case SR_FUNCPARAM_TOPIC			 : return priv_SrFuncParamFormidFromString(ParamValue, StringValue, pRecordHandler);
		case SR_FUNCPARAM_QUEST			 : return priv_SrFuncParamFormidFromString(ParamValue, StringValue, pRecordHandler);
		case SR_FUNCPARAM_RACE			 : return priv_SrFuncParamFormidFromString(ParamValue, StringValue, pRecordHandler);
		case SR_FUNCPARAM_CLASS			 : return priv_SrFuncParamFormidFromString(ParamValue, StringValue, pRecordHandler);
		case SR_FUNCPARAM_FACTION		 : return priv_SrFuncParamFormidFromString(ParamValue, StringValue, pRecordHandler);
		case SR_FUNCPARAM_GENDER		 : return GetSrGenderTypeValue(ParamValue, StringValue);
		case SR_FUNCPARAM_GLOBAL		 : return priv_SrFuncParamFormidFromString(ParamValue, StringValue, pRecordHandler);
		case SR_FUNCPARAM_FURNITURE		 : return priv_SrFuncParamFormidFromString(ParamValue, StringValue, pRecordHandler);
		case SR_FUNCPARAM_WEAPON		 : return priv_SrFuncParamFormidFromString(ParamValue, StringValue, pRecordHandler);
		case SR_FUNCPARAM_VARNAME		 : 
			ParamValue = strtoul(StringValue, &pEndPtr, 0);
			return false;
		case SR_FUNCPARAM_MAPMARKER		 : 
			ParamValue = strtoul(StringValue, &pEndPtr, 0);
			return false;
		case SR_FUNCPARAM_ACTORBASE		 : return priv_SrFuncParamFormidFromString(ParamValue, StringValue, pRecordHandler);
		case SR_FUNCPARAM_CONTAINER		 : return priv_SrFuncParamFormidFromString(ParamValue, StringValue, pRecordHandler);
		case SR_FUNCPARAM_WORLDSPACE	 : return priv_SrFuncParamFormidFromString(ParamValue, StringValue, pRecordHandler);
		case SR_FUNCPARAM_CRIME			 : return GetSrCrimeTypeValue(ParamValue, StringValue);
		case SR_FUNCPARAM_PACKAGE		 : return priv_SrFuncParamFormidFromString(ParamValue, StringValue, pRecordHandler);
		case SR_FUNCPARAM_COMBATSTYLE	 : return priv_SrFuncParamFormidFromString(ParamValue, StringValue, pRecordHandler);
		case SR_FUNCPARAM_MAGICEFFECT	 : return priv_SrFuncParamFormidFromString(ParamValue, StringValue, pRecordHandler);
		case SR_FUNCPARAM_FORMTYPE		 : return priv_SrFuncParamFormidFromString(ParamValue, StringValue, pRecordHandler);
		case SR_FUNCPARAM_WEATHER		 : return priv_SrFuncParamFormidFromString(ParamValue, StringValue, pRecordHandler);
		case SR_FUNCPARAM_34			 : 
			ParamValue = strtoul(StringValue, &pEndPtr, 0);
			return false;
		case SR_FUNCPARAM_OWNER			 : 
			ParamValue = strtoul(StringValue, &pEndPtr, 0);
			return false;
		case SR_FUNCPARAM_EFFECTSHADER	 : return priv_SrFuncParamFormidFromString(ParamValue, StringValue, pRecordHandler);
		case SR_FUNCPARAM_FORMLIST		 : return priv_SrFuncParamFormidFromString(ParamValue, StringValue, pRecordHandler);
		case SR_FUNCPARAM_38			 : 
			ParamValue = strtoul(StringValue, &pEndPtr, 0);
			return false;
		case SR_FUNCPARAM_PERK			 : return priv_SrFuncParamFormidFromString(ParamValue, StringValue, pRecordHandler);
		case SR_FUNCPARAM_NOTE			 : 
			ParamValue = strtoul(StringValue, &pEndPtr, 0);
			return false;
		case SR_FUNCPARAM_MISCSTAT		 : 
			ParamValue = strtoul(StringValue, &pEndPtr, 0);
			return false;
		case SR_FUNCPARAM_IMAGESPACEID	 : 
			ParamValue = strtoul(StringValue, &pEndPtr, 0);
			return false;
		case SR_FUNCPARAM_IMAGESPACE	 : return priv_SrFuncParamFormidFromString(ParamValue, StringValue, pRecordHandler);
		case SR_FUNCPARAM_44			 : 
			ParamValue = strtoul(StringValue, &pEndPtr, 0);
			return false;
		case SR_FUNCPARAM_45			 : 
			ParamValue = strtoul(StringValue, &pEndPtr, 0);
			return false;
		case SR_FUNCPARAM_EVENTFUNC		 : 
			ParamValue = strtoul(StringValue, &pEndPtr, 0);
			return false;
		case SR_FUNCPARAM_EVENTMEMBER	 : 
			ParamValue = strtoul(StringValue, &pEndPtr, 0);
			return false;
		case SR_FUNCPARAM_DATA			 : 
			ParamValue = strtoul(StringValue, &pEndPtr, 0);
			return false;
		case SR_FUNCPARAM_VOICETYPE		 : return priv_SrFuncParamFormidFromString(ParamValue, StringValue, pRecordHandler);
		case SR_FUNCPARAM_ENCOUNTERZONE	 : return priv_SrFuncParamFormidFromString(ParamValue, StringValue, pRecordHandler);
		case SR_FUNCPARAM_IDLE			 : return priv_SrFuncParamFormidFromString(ParamValue, StringValue, pRecordHandler);
		case SR_FUNCPARAM_MESSAGE		 : return priv_SrFuncParamFormidFromString(ParamValue, StringValue, pRecordHandler);
		case SR_FUNCPARAM_EQUIPABLEITEM  : return priv_SrFuncParamFormidFromString(ParamValue, StringValue, pRecordHandler);
		case SR_FUNCPARAM_ALIGNMENT		 : 
			ParamValue = strtoul(StringValue, &pEndPtr, 0);
			return false;
		case SR_FUNCPARAM_EQUIPTYPE		 : return priv_SrFuncParamFormidFromString(ParamValue, StringValue, pRecordHandler);
		case SR_FUNCPARAM_OBJECTID56	 : 
			ParamValue = strtoul(StringValue, &pEndPtr, 0);
			return false;	
		case SR_FUNCPARAM_MUSIC			 : return priv_SrFuncParamFormidFromString(ParamValue, StringValue, pRecordHandler);
		case SR_FUNCPARAM_CRITICALSTAGE	 : return GetSrCriticalStageTypeValue(ParamValue, StringValue);
		case SR_FUNCPARAM_KEYWORD		 : return priv_SrFuncParamFormidFromString(ParamValue, StringValue, pRecordHandler);
		case SR_FUNCPARAM_LOCREFTYPE	 : return priv_SrFuncParamFormidFromString(ParamValue, StringValue, pRecordHandler);
		case SR_FUNCPARAM_LOCATION		 : return priv_SrFuncParamFormidFromString(ParamValue, StringValue, pRecordHandler);
		case SR_FUNCPARAM_FORM			 : 
			ParamValue = strtoul(StringValue, &pEndPtr, 0);
			return false;
		case SR_FUNCPARAM_QUESTALIAS	 : 
			ParamValue = strtoul(StringValue, &pEndPtr, 0);
			return false;
		case SR_FUNCPARAM_SHOUT			 : return priv_SrFuncParamFormidFromString(ParamValue, StringValue, pRecordHandler);
		case SR_FUNCPARAM_WORDOFPOWER	 : return priv_SrFuncParamFormidFromString(ParamValue, StringValue, pRecordHandler);
		case SR_FUNCPARAM_66			 : 
			ParamValue = strtoul(StringValue, &pEndPtr, 0);
			return false;	
		case SR_FUNCPARAM_SCENE			 : return priv_SrFuncParamFormidFromString(ParamValue, StringValue, pRecordHandler);
		case SR_FUNCPARAM_CASTSOURCE	 : return GetSrCastSourceTypeValue(ParamValue, StringValue);
		case SR_FUNCPARAM_ASSOCTYPE		 : return priv_SrFuncParamFormidFromString(ParamValue, StringValue, pRecordHandler);
		case SR_FUNCPARAM_WARDSTATE		 : return GetSrWardStateTypeValue(ParamValue, StringValue);
		case SR_FUNCPARAM_PACKDATANULL	 : 
			ParamValue = strtoul(StringValue, &pEndPtr, 0);
			return false;
		case SR_FUNCPARAM_PACKDATANUM	 : 
			ParamValue = strtoul(StringValue, &pEndPtr, 0);
			return false;
		case SR_FUNCPARAM_FURNANIM		 : return GetSrFurnitureAnimTypeValue(ParamValue, StringValue);
		case SR_FUNCPARAM_FURNENTRY		 : return GetSrFurnitureEntryTypeValue(ParamValue, StringValue);
		case SR_FUNCPARAM_75			 : 
			ParamValue = strtoul(StringValue, &pEndPtr, 0);
			return false;
		case SR_FUNCPARAM_VMVARNAME		 : 
			ParamValue = strtoul(StringValue, &pEndPtr, 0);
			return false;
		case SR_FUNCPARAM_REFEFEFCT		 : 
			ParamValue = strtoul(StringValue, &pEndPtr, 0);
			return false;
		case SR_FUNCPARAM_PACKDATALOC	 : 
			ParamValue = strtoul(StringValue, &pEndPtr, 0);
			return false;
		case SR_FUNCPARAM_SOUNDCATE		 : return priv_SrFuncParamFormidFromString(ParamValue, StringValue, pRecordHandler);
		case SR_FUNCPARAM_SKILLACTION	 : return GetSrSkillActionTypeValue(ParamValue, StringValue);
		case SR_FUNCPARAM_KNOWFORM		 : return priv_SrFuncParamFormidFromString(ParamValue, StringValue, pRecordHandler);
		case SR_FUNCPARAM_REGION		 : return priv_SrFuncParamFormidFromString(ParamValue, StringValue, pRecordHandler);
		case SR_FUNCPARAM_ACTION		 : return priv_SrFuncParamFormidFromString(ParamValue, StringValue, pRecordHandler);
		default:						
			return false;
	}

	return true;
}
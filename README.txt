#Our GitHub Issue Tracker

Our [GitHub issue tracker](https://github.com/TES5Edit/TES5Edit/issues) offers a place to submit and discuss feature requests and bug reports. When using it, please ensure that any criticism you provide is constructive.

Please do not use the tracker for general help and support on how to use xEdit.

#summary TES5Edit Readme

xEdit 3.2.1 by ElminsterAU
Updated by Hlp, Zilav, Sharlikran, Sheson

Make backups of your plugins and report any issues in the official Bethesda thread. If you have never used TES5Edit, Wiki Pages and basic videos are available.  Starting from 3.1.0 we need to remind you that we only support version 1.9.0.32 of Skyrim. Update TES5Edit and Skyrim before you post in the forum.  If you see any references to xEdit that is a short way of saying all versions of the program which would cover FO3Edit, FNVEdit, TES4Edit and TES5Edit.

TES5Edit Cleaning Guides:
TES5Edit: http://www.creationkit.com/index.php?title=Category:TES5Edit
TES5Edit Cleaning Guide (Fewer Details): http://www.creationkit.com/index.php?title=TES5Edit_Cleaning_Guide_-_TES5Edit
TES5Edit Mod Cleaning Tutorial (Detailed Instructions with Pictures): http://www.creationkit.com/index.php?title=TES5Edit_Mod_Cleaning_Tutorial

Current Official Threads:
Bethesda.net: https://bethesda.net/community/topic/57570/relz-sseedit
AFK Mods: https://afkmods.iguanadons.net/index.php?/topic/3750-wipz-tes5edit/

Rename to TES4Edit.exe to work with Oblivion.
Rename to TES5Edit.exe to work with Skyrim.
Rename to TES5VREdit.exe to work with Skyrim VR.
Rename to SSEEdit to work with Skyrim SE.
Rename to FO3Edit.exe to work with Fallout3.
Rename to FNVEdit.exe to work with New Vegas.
Rename to FO4Edit.exe to work with Fallout 4.
Rename to FO4VREdit.exe to work with Fallout 4 VR.

Fallout3 Training Manual for FO3Edit (applies to all game versions)
http://fallout3.nexusmods.com/mods/8629
Fallout New Vegas Training Manual for FO3Edit (applies to all game versions)
http://www.nexusmods.com/newvegas/mods/38413

Check for new versions here:
FO3Edit: http://www.nexusmods.com/fallout3/mods/637
FNVEdit: http://www.nexusmods.com/newvegas/mods/34703
FO4Edit: http://www.nexusmods.com/fallout4/mods/2737
FO4VREdit: http://www.nexusmods.com/fallout4/mods/2737
TES4Edit: http://www.nexusmods.com/oblivion/mods/11536
TES5Edit: http://www.nexusmods.com/skyrim/mods/25859
TES5VREdit: http://www.nexusmods.com/skyrim/mods/25859
SSEEdit: http://www.nexusmods.com/skyrimspecialedition/mods/164
Mirror: https://github.com/TES5Edit/TES5Edit/releases

xLODGen Versions:

FO3LODGen: http://www.nexusmods.com/fallout3/mods/21174
FNVLODGen: http://www.nexusmods.com/newvegas/mods/58562
TES4LODGen: http://www.nexusmods.com/oblivion/mods/15781
TES5LODGen: http://www.nexusmods.com/skyrim/mods/62698
TES5VRLODGen: http://www.nexusmods.com/skyrim/mods/62698
SSELODGen: http://www.nexusmods.com/skyrimspecialedition/mods/6642/?

Future of xEdit:

We appreciate all the thanks and support from the community.  We would like to thank all the users that made bug reports on the Nexus or in the Bug Tracker.  Zilav and Hlp continue to make various bug fixes and improvements.  Zilav has added more scripting functions while Hlp is still working on having a working Save game editor.  Currently early testing only allows you to view save games.  We were very excited recently when ElminsterAU had some time to make some optimizations to the code.  The program loads plugins faster then before and uses less memory.

Previous versions such as FO3Edit, FNVEdit, TES4Edit:

We understand that sometimes updates to programs break things.  Please use the updates with caution.  However, please use them and then report issues so we can improve the program.  Our goal is to make all versions as bug free as possible and introduce new features that are useful for the modding community for all the Bethesda games this utility supports.

xEdit Updates:

With each new version of xEdit it is recommended to restore plugins from backups and reclean them. Otherwise any fixes and updates to cleaning process won't take effect.

Version 3.2.1 contains the following changes:
- [SSE/FO4] Creation Club support (ESL plugins), forced load order for plugins in *.ccc file
- [TE5/SSE] "Generate as Objects" LODGen option
- [FO3/FNV] LODGen Atlas options
- [FO4] FO4LODGen mode
- Skyrim VR and Fallout4 VR support: rename as TES5VREdit.exe or FO4VREdit.exe, or execute with -tes5vr or -fo4vr parameters
- filtering: if 8-digits hexadecimal FormID number is provided in "Base Record EditorID contains" field, then FormID will be checked instead
- multiselection in plugins window and similar ones, right click menu options apply to selection only
- "Reset structure" right click menu in the right view pane to add missing fields if any
- "Compare selected" right click menu in Referenced By tab when several records selected of the same type
- read (TES5|SSE)MapMarkers.txt and (TES5|SSE)QuestTypes.txt if present to replace game values with custom ones including new values
- improved record definitions
- various bug fixes and optimizations
- new scripts and scripting APIs to work with json, nifs, materials, lod files

Version 3.2 contains the following changes:
- [SSE] Skyrim Special Edition support
- [SSE] SSELODGen mode
- [FO4] Fallout 4 support
- improved record definitions and error checking
- various bug fixes and optimizations
- new scripts

Version 3.1.3 contains the following changes:
- [SSE] Skyrim Special Edition support
- [FO4] Fallout 4 support
- utf-8 support for translatable strings with -cp:utf-8 command line parameter
- "Stick to" right click menu in the right view pane
- improved record definitions

Version 3.1.2 contains the following changes:
- improved record definitions and error checking
- [TES5] LODGen support for glowing meshes
- [FO3/FNV] Fixed possible error when reading LOD meshes
- [TES5] TES5LODGen avoids generating trees LOD for duplicate FormID ref numbers, bug in Skyrim causes them to not switch off properly in the game

Version 3.1.1 contains the following changes:
- [FO3/FNV] Added PBEA record
- improved record definitions
- VMAD fix for empty arrays
- xLODGen fix reading BSA archives
- xLODGen impoved removing of mesh faces under landscape LOD
- FNVLODGen and FO3LODGen

Version 3.1.0 contains the following changes:
- speed optimizations
- fixed memory leaks
- fixed sorting of INFOs in DIAL
- fixed float values rounding
- advanced ModGroups feature
- drag&drop and "Remove from selected records" support for individual flags
- fonts are changeable in Options
- new scripting functions
- new script auto execution mode with -script:"test.pas" switch or when renamed to (TES4|TES5|FO3|FNV)Script.exe
- xEdit associates itself with *.tes5pas, *.tes4pas, *.fo3pas and *.fnvpas extensions
- load Mod Organizer profile internally using command line parameter -moprofile:<profilename>
- faster -quickshowconflicts switch processing
- new -O: parameter to set the output folder for TES4LODGen generation (much faster), for example "-O:..\ModOrganizer\mods\Generated DistantLOD"
- [FO3/FNV] Optional hiding of templated actor fields
- [FNV] Don't undelete refs of TREEs with LOD, bug in the game engine causes a crash
- [TES5] TES5LODGen, in right click menu -> Other -> Generate LOD
- [TES5] Weapon/Armor/Ammunition spreadsheets
- [TES5] BODT/BOD2 and different VMAD version objects are now lined up for conflict resolution
- [TES5] Improved DOBJ handling
- [TES5] Record header flags depend on record type

Version 3.0.32 contains the following changes:
- issue 69: automatic updating of counter fields to reflect the proper amount of elements in containers
- issue 149: FormID indexes in master file header ONAM forms
- issue 162: reference rotation angle normalization (TES4LODGen hanging on several mods)
- hotkeys in plugins selection window (Enter - confirm, numpad '+' select all, '-' select none, '*' invert)
- hold Shift while starting xEdit to skip restoring window state (for users stuck with xEdit outside of viewable desktop area)
- hold Shift while clicking OK in plugins selection window for one time skipping of building references for all plugins
- exclude building references for plugins list available in options
- option to display integer values of flags and enumerations (off by default)
- Ctrl+C copies only Node text to clipboard, Esc closes the View window
- definitions update for all games to reduce false positives when checking for errors
- custom scripted filtering, demo 'Apply custom scripted filter.pas'
- new scripting functions and scripts: Weather Editor script (Ctrl+W), Worldspace Browser (Alt+F3)
- scripted persistent bookmarking of records: Ctrl+1..5 to set a bookmark, Alt+1..5 to go back
- removing offset data in WRLD is optional now, 'on' by default
- [TES5] TES5LODGen (beta version, has several issues)
- [TES5] renamed armor addon nodes (added slot numbers), please update your scripts if needed
- [TES5] Record definitions update (WTHR, DOBJ, NAVM, VMAD papyrus data, GetEventData condition), improved NavMeshes (thanks to jonwd7)
- [TES5] Added VMAD (papyrus scripts) to TREE, and LVLG (global) to LVLN. They can't be edited in CK, but it supports them and they confirmed to work in game
- [TES4] Added XRGD subrecord to REFR, INFO flags update
- [FO3] Do not remove PLD2 subrecord in PACK (as in FNV)
- [FNV] BPTD update to support body parts without BPTN name
- [FNV] Relocated CELL and WRLD groups at the end of file
- [TES4/TES5/FO3/FNV] WRLD offset data OFST definition (when 'Simple records' option is off)


Version 3.0.31 contains the following changes:
- esp files can be loaded before esm
- issue 136: no stack overflow and progress indication for long operations
- issue 137: added empty subrecords were treated as ITM leading to possible erroneous cleaning
- fixed bug when 8 chars in square brackets were treated as FormID giving errors in various places, i.e. [$PitStop]
- Ctrl+DblClick on FormID numbers in messages tab could previously not work on some of them
- INFO records sorting is now optional instead of disabled
- BSA files are loaded by exact matching with plugin names for TES5, and partial matching for previous games
- new scripting functions, UI controls and scripts: Assets manager, Assets browser (Ctrl+F3)
- [TES5] added XCZR (encounter zone reference?) subrecord in REFR
- [TES5] added PMIS record
- [TES5] removed obsolete model subrecords: MODB, MOSD, FGGA, FGGS, FGTS
- [TES5] updated LCTN definition (showed errors in USKP before)
- [TES5] optional switch to resolve aliases (show ID and name)
- [TES5] fixed error when copying PACK record
- [TES5] 'Default' water height instead of '-2147483648.00000' is being added to CELLs with water but no XCLW subrecord
- [TES5] renamed "WRLD\Object bounds" element, please update scripts if needed
- [TES5] merged patch improvements and fixes
- [TES4] updated INFO record definition to fix flags
- [TES4] fixed PGRR subrecord corruption in pathgrids when saving
- [TES4] fixed error when copying MGEF and REFR with XLOC subrecord
- [TES4] fixed "Unused data in XSED" warning
- [FO3/FNV] fixed issues when copying NPC_, definitions update.

Version 3.0.30 contains the following changes:

- Added Prev/NextMember for Record union. Use after adding a new one to select the apropriate.
- Search for required master extended upward.
- Added a second command line parameter to specify the game's ini file location.
- Ctrl+A to select all in editor window.
- "Jump to" option in record's header popup menu.
- Enable/disable autosaves in options.
- Log file is overwritten at 3MB.
- [xDump] Fatal exceptions are reported through ReportProgress to have a timestamp. It might be useful to track down the issue.
- [TES5] Blocks adding new script property and new scripts. Please use CK to create them.
- [TES4/TES5/FO3/FNV] Record definitions update (number of ITM counts may change).
Scripting:
- New scripts added.
- New scripting functions (including regular expressions).
- New UI controls (TLabeledEdit, TCheckListBox).
- Scripts can be accessed with hotkeys (Ctrl+Shift+F to call a new find cell script demo).
- Removed syntax highlighter from script editor.
Fixes:
- Variable size detection corrected.
- Out of bounds detection corrected.
- Issues 125, 126, 129, 128 (128 was "worked around").
Misc:
- Code modified for compatibility with both Delphi XE and XE3 in the same source files.
- Added BaseName property so unsorted arrays can contain structured unions.
- ByteArray length increased to 64 bits.

Version 3.0.29 contains the following changes:

- new icon provided by moiman100 https://moiman100.deviantart.com/art/Tes5edit-Icons-467927896
- [TES5] more information is decoded (Records ARMA, NVSI, MOD2, LVLO).
- [TES5] Every string value gets own ID when localizing plugin
- [TES5] Fixed error when copying VMAD scripts using drag&drop
- issue 104 : Files others than esp and esm (and ghost) are timestamped.
- issue  88 : Delete from the view pane column title contextual menu is disabled (due to a hard to reproduce bug). This is a workaround, not a fix.
- issue 119 : [TES5] The CK adds useless XLRL records when reverting a change. Those XLRL are considered benign and the record ITM.
- issue 110 : Check for errors now checks for invalid FormIDs. Also, new "Check for errors" sample script.
- Options are processed when they matter, not at the beginning.
- issue  82 : [TES5] Capitalization fixed in text are being treated as dirty edits. Description fields are case sensitive now.
Scripting:
- Scripts can use other scripts with standard pascal "uses" keyword.
- New functions available.
- New sample scripts.
Fixes:
- Compare to will not overwrite an existing file, nor will it leave temporary files behind.
- issue 125 : Condition added are no longer empty.
- issue 121 : Changing FormID of Region causes severe bugs. Reference building is delayed to after the change is done. Non region reference XCLR record are no longer removed.
- issue 120/118 : Reference not updated while adding a master. Reference lookup during the addition were sometime unreliable.
- issue 117 : Bug in script Undelete and Disable References.pas
- issue 112 : Option "Simple Record" malfunctioning.
- issue 111 : AV when saving subrecords with prefixed arrays. Sizing and memory allocation are done properly during every phase.
- issue 108 : Very slow saving after editing ESM flag. Background updating limited as much as possible during saves.
- issue 107 : Copying a quest record causes extraneous script fragment data to be generated. Sizing and memory allocation issue.
- issue 106 : Error adding a new master to plugin with own navmeshes. Fire Union decider when they can effectivly properly work, not before.
- issue 105 : Overwriting quest fragments or Quest Aliases may produce exceptions. During copy, memory is initialized properly before being used.
- issue 100 : Voice Type EditorID disappears. Memory sizing issue.
Known issue:
- issue 123 : Using Check for errors after sort master, before saving and reloading: the Cell formID will not be updated. (that is a display issue only).
- issue 102 : Objects with property names but no assigned values don't display the names. The CK does not save the property name in the plugin in that case so it is correct.
Misc:
- issue 115 : "Backup plugin" checkbox anchored to bottom of form.
- avoid firing some catched exception (to ease debugging).

Version 3.0.28 contains the following changes:

- With this version it is important to clean all of your plugins after restoring the original Nexus or Steam workshop files. (Don't ask about this in the forum)
- [TES5] Papyrus (VMAD subrecord) support and other misc record updates including Dragonborn DLC
- [TES5] "Next Object ID" error when copying records
- Text fields in records are case sensitive when matching
- Ability to change references to FormID < 800h
- Changeable conflict colors and default column width in options
- "Simple records" option for concise displaying of LAND, NAVM and NAVI records (excluding references). On by default to speed up xEdit, customizable in options
- Improved scripting functions, new demo scripts

Version 3.0.27 contains the following changes:

- [TES5] Updated dialog subtypes for patch 1.8
- Localize/delocalize utf8 strings. Translation is disabled, highly recommended to use StrEdit or other specialized tools instead
- Search by FormID/EditorID skips hidden elements

Version 3.0.26 contains the following changes:

- [TES5] BODT is unchanged (troubles with Dawnguard.esm)
- [TES5] Fixed bug in RACE with sorted biped object names. If you modified race records with previous versions, drag&drop biped object names from master to restore them.
- Additional internal functions accessible from scripts (new demo scripts)

Version 3.0.25 contains the following changes:

- [TES5] Impact data set IPDS is now sorted
- [TES5] Added DEST data to ALCH (for "Destructible bottles")
- [TES5] BODT subrecord is autoreplaced with BOD2 in ARMA, ARMO and RACE records to conform CK 1.8 format
- [TES5] Additional decoding in WRLD and RACE for new data saved with CK 1.8
- [TES5] Added back records to Merged Patch (removed in 3.0.24) but only when the winning record has no scripts
- [FNV] Updated missing INFO flags
- [TES4] Fixed error when copying SPEL record
- Pascal-based scripting system and "Apply Script" menu (check available demo scripts on how to)
- "Options" menu
- "Analyze Log" menu, currently supports
  * Skyrim papyrus log
  * Oblivion RuntimeScriptProfiler log http://www.nexusmods.com/oblivion/mods/41863
- Moved several not so often used menus to the "Other" submenu (Build ref/reachable, Merged Parch, Seq File, Localization, etc.)
- Full expand key modifier changed to ALT

Version 3.0.24 contains the following changes:

- [TES5] Updated load order handling when plugins.txt is empty and no BOSS info is available
- [TES5] Fixed event name definition in QUST
- [TES5] CELL water level fixup for better conflicts detection
- [TES5] Autoremoving legacy RNAMs from WRLD; empty keywords from NPC_, ARMO, AMMO, WEAP, ALCH, MISC
- [TES5] Removed NPC_, ARMO, AMMO, WEAP records from Merged Patch (unsafe to copy possible scripts to a new plugin)
- [FO3] No sorting of DIAL groups
- [FO3/FNV] Fixed record definition for ragdolls which crashed game after cleaning several DLCs
- Copy "Compare to" selected file to the game's data folder if it is not there
- Improved registry handling on x64 systems
- Hold CTRL key when expanding a node for full expand

Version 3.0.23 contains the following changes:

- [TES5] Merged patch updated for Skyrim, currently it merges:
  * Leveled NPCs, Items, Spells
  * NPC: Items, Spells, Head Parts, Factions
  * Race: Hairs, Eyes, Spells
  * Containers
  * Relations
  * Form Lists
  * Keywords on: Armor, Weapon, Ammo, NPC
- [TES5/FNV/FO3] When performing UDR there will be a warning message for deleted NavMeshes.
- [TES5] Updated record definitions.
  * BPDT was sorted by a localized name which is inconsistent for different languages (now sorted by a node name)
  * NPC's tints are now sorted by tint index for better conflicts detection
  * QUST aliases are no longer sorted by index
  * QUST stages are now sorted by stage index
  * Improved NavMeshes (thanks to Divstator)
- [TES5] FaceFX phonemes where empty after copying RACE record.
- [TES5] Fixed bugs when copying RACE and QUST (empty model was created for RACE; QUST location aliases were turning into ref ones).
- [TES5] Create start-enabled quests sequence SEQ file (you can select several files at once).
- [TES5] Improved error checking.
- [FNV] CHAL record was missing some challenge types from Dead Money DLC.
- [FNV] Disabled DIAL sorting, was causing errors when copying INFO records.
- No autosaves when "you know what you are doing".
- Compare with external tool option in Edit window.
- "Apply Filter for Cleaning" menu. Note that xEdit saves filter settings when you press OK button in filter window, so if you clean plugin and exit the program, your filter settings will be preserved.
- Filter option for deleted records.
- Saving messages to [TES5/FNV/FO3/TES4]Edit_log.txt upon exit.
- Fixed minor bug when Edit can't find game's folder. If your registry settings is invalid due to a Steam bug and Edit is unable to find your game, put it in the game's root folder where the game executable file is (Oblivion.exe, TESV.exe, etc).

Version 3.0.22 contains the following changes:

- Skyrim Support.
- New exceptions handler.
- Optional backups in a separate directory.
- Remember position and state of the main window.
- Fixed bug when editing with Shift+DblClick.
- [All] Wrye Bash ghosted plugins (*.esp.ghost) in plugin selection window.
- [ALL] FLST form list is no longer sorted.
- [ALL] EDID affects conflict detection.
- [TES5] Localization editor, plugin localization/delocalization with optional translation.
- [TES5] -l:language command line switch to chose default localization files.
- [TES5] Adding missed plugin files from plugins.txt/loadorder.txt to the end of plugins list.
- [FNV] WeaponModKit IMOD record support for various subrecords.
- [FNV] PLD2 subrecord is no longer removed in package.
- [FNV/FO3] Quest stage signed value overflow fix.
- [Oblivion] Fixed ownership record order in CELL.
- [Oblivion] Snowy weather definition fix (thanks to Arthmoor).

Version 3.0.19 contains improves record definitions to handle DeadMoney.esm better

Version 3.0.15 contains the following changes:

- double click on a FormID in the message view while holding CTRL jumps to that record
- fixed crash when changing perk effect type to Entry Point
- Quest Stage field for Quest + Stage Perk Effect Type now has a drop down with all stages available for the selected quest
- single click on an already selected field now opens the editor again
- fixed in-place editor to properly cover the complete field and have it's text align exactly with the text normally displayed
- MasterUpdate and MasterRestore modes are supported (Warning: highly experimental, handle with care)

Version 3.0.16 contains the following changes:
- FalloutNV.esm not marked as modified if duplicated groups have been merged
- fixed crash when looking at base effect records
- "unsaved changes" dialog should no longer appear if detail view is in edit mode

Version 3.0.13 syncs up the engine with the most current version of TES4Edit, TES4LODGen and FNVEdit.

Version 3.0.15 contains the following changes:
- double click on a FormID in the message view while holding CTRL jumps to that record
- fixed crash when changing perk effect type to Entry Point
- Quest Stage field for Quest + Stage Perk Effect Type now has a drop down with all stages available for the selected quest
- single click on an already selected field now opens the editor again
- fixed in-place editor to properly cover the complete field and have it's text align exactly with the text normally displayed

What's new in Version 2.5.3?

Fixes assert error when copying certain subrecords.

What's new in Version 2.5.1?

Bug Fix: floating point comparison is now less "fuzzy". This can result in some floating point numbers now comparing as unequal even though they are within the limit of the accuracy of single (4 byte) floating point values. But it will prevent cases where floats that should be unequal compared as equal.

What's new in Version 2.5.0?

Context menu on file node in navigation treeview -> Renumber FormIDs from...
Renumber FormIDs from will change all FormIDs of records belonging to that file (but not any override records which might be contained in that file) so that they start at the specified value.
This is useful if you have multiple modules that you plan to update in the future, but also want to always provide a merged version (e.g. using FO3Plugin). By assigning non overlapping FormIDs to the different modules, you can make sure that no FormID reassignment of conflicting FormIDs has to take place when merging.
WARNING: changing the FormIDs of an existing module will make it savegame incompatible and will break any other module that uses this module as master. If you have any dependant modules, you need to have them all loaded into FO3Edit at the time you change to FormIDs so that they will all be updated accordingly.
Also, this version has been compiled with the "large address aware" flag and will be able to use up to 4GB when running under a 64bit version of Windows.

What's new in 2.3.0 EXPERIMENTAL?
large number of small fixes to record definition, resulting in many more cases of records correctly identified as "identical to master" and a very significant reduction in potential false positives in the "Check for Errors" function.
on the fly conversion of outdated records to the most current format. This means that you will see fields show up as modified that you didn't modify yourself (mainly in Oblivion.esm, CS created files should already be up to date). It is possible to disable this function by starting FO3Edit with -nofixup as parameter. It is also possible to just these modifications (but still keep the fixups) by starting TES4Edit with -hidefixup as paramter. This function replaces the -fixupPGRD from earlier versions
New function to copy idle animations:
Bugfix to prevent dialog choices from being sorted by FormID
The Undelete and Disable function will set the Player ACHR [00000014] as Enable Parent with the "Set Enable State to Opposite of Parent" flag set. Given that the player should never end up being disabled, that should properly remove them from the gameworld, even if they are persistent references and the enabled state has already been stored in the savegame.
The Undelete and Disable function will also now properly list all affected references, just like the "Remove 'Identical to Master' Record" function does.
The selection dialog now allows double clicking an entry, this will automatically select that entry, deselect all others and close the dialog as if the OK button had been pressed.

What's new in 2.2.3?
Game Settings (GMST) will now be properly resolved based on EditorID, not FormID.
A field in the Region record was improperly defined as a Float field.

What's new in 2.2.0?
This version contains no major new functionality, but a number of bugfixes. Update is highly recommended.

TES4View is an advanced graphical esp viewer and conflict detector.

When started it will automatically find your Oblivion Data directory. You then get a dialog to select which masters/plugins you want to load with the current selection from your plugins.txt as default value. This is followed by a second dialog which lets you choose which records not to load. By default this is LAND, PGRD, ROAD and REGN because these records are very large and usually not very interesting to look at. Once you have confirmed that dialog the selected plugins will start loading them in the background. Depending on your system it should take 30 seconds to a few minutes (!) for all plugins to load. You can follow the progress in the message window. (Don't panic if it seems to freeze, it just takes time).

The tree view on the left side now shows all active masters and plugins in their correct load order. By navigating that tree view you can look at every single record in any of your masters or plugins.

Once a record has been selected the detailed contents of that record is shown on the right side. The detail view shows all versions of the selected record from all plugins which contain it. The left most column is the master. The right most column is the plugin that "wins". This is the version of the record that Oblivion sees.

Both the detail view and the record list use the same color coding to signal the conflict state of individual fields (in the detail view) and the record overall (in the record list).

Background color:
White - Single Record
Green - Multiple but no conflict
Yellow - Override without conflict');
Red - Conflict

Text color:
Black - Single Record
Gray - Hidden by Mod Group
Purple - Master
Gray - Identical to Master
Orange - Identical to Master but conflict Winner
Green - Override without conflict
Orange - Conflict winner
Red - Conflict loser

Conflict detection is not simply based on the existence of multiple records for the same FormID in different plugins but instead performs a comparison of the parsed subrecord data.

The record tree view on the left side has a context menu where you can activate filtering. Filtering is based on the same conflict categorization as the background and text color.

Yes, filtering will take a while. It has to decode and compare the contents of every single record which turns up more then once.

What's new in 1.1?

- Game Settings are handled correctly now
- Function Type and Params in Conditions are decoded completely
- Mod Groups (more about that later)
- Settings (records to skip, mod groups, filter) are loaded/saved into a .tes4viewsettings file with the same path and name as the plugins.txt (or the plugin list passed on the command line)
- Possible range check error when loading a file with errors should be gone

What are Mod Groups?

The answer to the "I installed FCOM and everything is red! What do I do now?" question.

There are groups of mods that, while raising heaps of conflict warnings, should be considered as non-conflicting. e.g. if you've installed FCOM then you are not interested in seeing conflicts between the mods that make up FCOM. The solution for this is to define a mod group. Mod groups are stored in a TES4View.modgroups file in the same directory as TES4View.exe. There already is such a file included with a few example mod groups defined. This is just an example and not meant as a guarantee that these specific mod groups are "clean" and conflicts can safely be ignored.

Not all mod groups defined in that file will necessarily show up in the selection list. Mod groups for which less then 2 plugins are currently active are filtered. If the load order of plugins doesn't match the order in the mod group it is also filtered.

What's the effect of having a mod group active?

When the detail view for a record is generated and multiple files of the same mod group modify this record, then only the newest of the files in that modgroup will be shown. So instead of seeing 5 different files with numerous conflicts you are only seeing the newest file in that mod group. This also affects conflict classification.

It's worth pointing out here that if a record is overriden by both plugins in a mod group and other plugins that normal conflict detection will still work perfectly.

Basically this system can be used to reduce a lot of noise from the conflict reports.

What's new in 1.2?

- Filtering the first time should be noticable faster
- Filtering a 2nd time should be over almost instantly
- New conflict category "Hidden by Mod Group" which can be filtered on
- When sorting by EditorID or Name the files get sorted by filename instead of load order
- Improved parsing of Path Grids
- A lot of "unknown" fields and flag values now have a proper name
- Selection dialog (used for files, record to skip, mod groups, ..) has a context menu with "Select all", "Select None" and "Invert Selection"
- added a couple more mod groups for the official plugins
- Bugfix: Filtering could wrongly filter out records with conflicts if their parent is also a record (not a group) and didn't contain a conflict
- numerous tweaks to the mechanism which assigns conflict classifications
- When filtering it is possible to "Build reference information" (adds quite a bit of additional processing time). After this has been done a new tab "Referenced By" is available if the currently selected record is referenced by any other records.
- Mod groups are applied better under certain circumstances.
- double clicking on a row in the right side treeview will open a window that shows the text of that field in a multi line memo. So you can now easily read scripts or books
- everything I've forgotton about ;)

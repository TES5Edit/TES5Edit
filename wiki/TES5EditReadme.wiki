#summary TES5Edit Readme

TES5Edit 3.0.22 EXPERIMENTAL by ElminsterAU updated for Skyrim by Zilav, and Sharlikran.

This is a very early and highly experimental release of TES5Edit. If you don't know what TES5Edit is, you probably shouldn't be using it yet.

TES5Edit Cleaning Guide http://www.creationkit.com/index.php?title=TES5Edit_Cleaning_Guide_-_TES5Edit

Warning: Experimental Version, probably contains errors.
Rename to TES4Edit.exe to work with Oblivion.
Rename to FO3Edit.exe to work with Fallout3.
Rename to FNVEdit.exe to work with New Vegas.

Fallout3 Training Manual for FO3Edit (applies to all game versions)
http://fallout3.nexusmods.com/mods/8629

Check for new versions here
https://code.google.com/p/skyrim-plugin-decoding-project/downloads/list

Important:
If you get an error about d3dx9_*.dll not being installed, you need to update your DirectX to the most current version.

The most current (March 2008) version can be found here: http://www.microsoft.com/en-us/download/details.aspx?id=35
DirectX End-User Runtime Web Installer 
or here:
DirectX End-User Runtimes Redistributable (make sure to install it after unpacking it). http://www.microsoft.com/en-us/download/details.aspx?id=23611

Whats new in 3.0.22?

* Skyrim Support.
* New exceptions handler.
* Optional backups in a separate directory.
* Remember position and state of the main window.
* Fixed bug when editing with Shift+DblClick.
* [All] Wrye Bash ghosted plugins (*.esp.ghost) in plugin selection window.
* [ALL] FLST form list is no longer sorted.
* [ALL] EDID affects conflict detection.
* [TES5] Localization editor, plugin localization/delocalization with optional translation.
* [TES5] -l:language command line switch to chose default localization files.
* [TES5] Adding missed plugin files from plugins.txt/loadorder.txt to the end of plugins list.
* [FNV] WeaponModKit IMOD record support for various subrecords.
* [FNV] PLD2 subrecord is no longer removed in package.
* [FNV/FO3] Quest stage signed value overflow fix.
* [Oblivion] Fixed ownership record order in CELL.
* [Oblivion] Snowy weather definition fix (thanks to Arthmoor).

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

Forum: http://forums.bethsoft.com/topic/1415541-wipz-tes5dumpfuture-tes5edit/ 

Be warned, this program uses a lot of memory. Performance on a system with less then 2GB of RAM will most likely be sub-optimal. Activating the filtering uses even more memory.

TES5Edit also has a little brother: TES5Dump

http://code.google.com/p/skyrim-plugin-decoding-project/downloads/list

It's based on the same parsing engine and converts any given esp or esm into a text representation. (No conflict detection or funky colors here tho I'm afraid).
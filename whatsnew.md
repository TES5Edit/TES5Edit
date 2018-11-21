# What's new in xEdit 3.3.6 BETA?

## Table of Contents for What's New

The TOC button in the top left corner of the What's New Form (also when docked in the What's New Tab) can be used to show or hide a Table of Contents.

`Double Click` or `Enter` in the TOC will scroll the selected header into view.

Width of the TOC is adjustable with a splitter.

State (visible or not) and width of the TOC is saved and restored when the Form shows again.

## Hugely improved performance for "Create Delta Patch"

Time needed for creating a delta patch for the 650MB SeventySix.esm has been reduced from over 600 minutes (10 hours) to about 5 minutes.

## Bugfixes

The following reported issues have been fixed:

* (reported on discord) - TOC building does not work on Win7
* (reported on discord) - while in "Fit All" column width mode, it is not possible to manually increase the width of columns
* (reported on discord) - HITMEs (FormID Prefix HIgher Than Master Entries) in GRUP labels can lead to problems
* (reported on discord) - Compare Selected does not initially use the correct Column Width mode
* (found by developer) - Clicking the OK button in the Module Selection Form does not always behave the same as pressing `Enter`

# What's new in xEdit 3.3.5 BETA?

## Developer message update

The developer message has been updated. 

To invite feedback about it for this BETA, it will be shown again even if it was previously shown to you.

For *this BETA release only* you will be asked afterwards if it should be shown again next time and you are going to be asked to provide any constructive feedback you might have about it's contents or presentation on the xEdit Discord.

## Bugfixes

The following reported issues have been fixed:

* (reported on discord) - changing FormID of a record does not show new FormID until after saving and restarting
* (reported on discord) - [FO4] FNAM in GLOB is wrong
* (reported on discord) - virtual "Worldspace" element on temporary exterior cells can show invalid value after changing FormID of WRLD record
* (reported on discord) - When using Copy as override (with overwriting), "No to All" does not work for records flagged as deleted
* (reported on discord) - After using Copy into (and possible other situations) the View tab may (in rare cases) be blank
* (reported on discord) - Flags do not work in Unions
* (found by developer) - Certain shortcuts work while the loader is still active when they shouldn't
* (found by developer) - Random AV after saving when closing

## Search and Zoom in What's New

A search edit and zoom trackbar have been added to the What's New Viewer.

`ALT + S` or `CTRL + F` focus the search edit.

Zoom can be controlled with `CTRL + 0, +, or -`.

`F3` when the main text is focused keeps searching from the current cursor position.

`Enter` when the search edit is focused keeps searching from the current position if the search text has remained unchanged, or starts for the start if the search text has changed.

## Save in Hamburger Menu

"Save" is now available in the Hamburger Menu.

## "Show Unsaved Hint" replaces previous "Auto Save" option

When "Show Unsaved Hint" is checked in the Options (on by default) then if there are any unsaved changes older than 10 minutes a balloon hint is being shown under the Hamburger Menu, listing the unsaved files and how long they have been unsaved.

Clicking the hint will show the usual save selection dialog.

Clicking the [X] in the hint or ignoring it for 15 seconds until it disappears on it's own will snooze it for 10 minutes.

## Ctrl + Click on View Header as Jump To

`Ctrl + Click` on the View tab Header performs now Jump To on that record.

## removed Hardcoded.dat

External Hardcoded.dat files are no longer required. The data is now compiled into the exe.

It is possible to override the data contained in the exe by placing a {GameName}.Hardcoded.Override.dat beside the exe.

## What's New compiled into exe

This What's New document is now compiled into the exe and no longer loaded from the external whatsnew.rtf

# What's new in xEdit 3.3.4 BETA?

## Bugfixes

The following reported issues have been fixed:

* #594 - "Localize plugin" function is broken
* (reported on discord) - sorting masters can under certain circumstances result in corruption of FormIDs
* (reported on discord) - adding/removing/sorting masters can leave the virtual "Worldspace" elements invalid (does not corrupt actual data)
* (found by developer) - Language selection is not aware of .strings files in .bsa/.ba2 archives
* (found by developer) - UTF8 encoding for localized strings needs a fallback mechanism if strings are not valid UTF8
* (found by developer) - ref building uses more memory than necessary
* (found by developer) - if the module selection form on opening has exactly one entry and it is checked, it shows up as unchecked
* (found by developer) - inconsistencies in the collapsing/expanding types and elements in the view tab (implementation and description below updated)
* #600 - Reporting a null xEdit app version number

## Fallout 76 support

Great progress has been made. All records have working definitions now. Reference building has been enabled and it is now possible to fully load SeventySix.esm with fully build reference building without errors.

Fallout 76 support is generally ready to the point that anyone should be able to use it to look at SeventySix.esm without much of a chance for error messages or crashes.

But significant amount of work remains to further refine the record definitions and identify the many new "Unknown" values that have been added.

## New command line parameters

Two new command line parameters have been added:

* `-autoload` - Will not show the Module Selection dialog and just load all modules that are active according to plugins.txt. It also skips the ModGroup Selection and automatically loads all valid ModGroups
* `-autogamelink` - Implies `-autoload`. Will automatically activate GameLink in Reference mode at the end of the Background Loader.

## "Hamburger" Menu

A "Hamburger Menu" button has been added to the top left corner of the main window. This button opens a menu with (currently) the following entries:

* Localization
* GameLink (if present)
* Options

More menu items that are unnecessarily (= not depending on context) in different context menus may get moved to this menu in the future.

## Codepage override using Description in File Header

The codepage for translatable strings (see below for definition) can now be overridden by placing the text `<cp:xxxx>` somewhere in the description of the module. `xxxx` can be `utf8` or any valid codepage number, e.g. `1252`. codepages with less than 4 digits must use leading 0s, e.g. `<cp:0930>`.

## Setting codepage for language in settings file

It is possible to set the codepage used for a language (new or overridding a default from the list below) by modifying the settings file (shown as "Using settings file:" in the messages log on start).

There is currently no UI support for this, but the settings file can be opened in a text editor and a `[cpoverride]` section can be added or modified like this:

```
[cpoverride]
english=utf8
klingon=6666
```

The specified value must be `utf8` or a valid codepage (which `6666` isn't, that was just an example).

The specified codepage will affect any place where a codepage is derived from language.

## Compare Selected

The Compare Selected context menu entry now shows the number of currently selected records as `Compare Selected (x)`.

# What's new in xEdit 3.3.3 BETA?

## Improved language support

Module files for the supported games store their strings generally ANSI (one byte per character) strings. This requires that the correct codepage (mapping between characters and their byte values) is used. Previous versions of xEdit had very limited support for accessing module files that didn't use the same ANSI codepage as the system ANSI codepage of the local system.

xEdit no longer simply uses the system ANSI codepage, but instead uses specific encodings for certain classes of strings.

* General strings - These are values like file names, developer comments, internal names that are never visible to the player.
* VMAD properties of type string or array of string - These only exist in Skyrim and later. They are strings stored in the module file, but in a distinctly different way then other strings.
* Localized strings - These are strings stored in external `.strings` files when a module is localized.
* Translatable strings - These are strings stored in the module file that a player of the game might get to see. For Oblivion, Fallout 3, and Fallout New Vegas, these are string fields explicitly marked as such in the xEdit record definitions. For Skyrim and newer, this also includes any localizable string (strings that will be stored in the external `.strings` files when a module is localized) if the module is not actually localized.

General strings now always explicitly use codepage 1252 (ANSI - Latin I). This can be overridden using `-cp-general:<codepage>` where `<codepage>` is either `utf8` or a codepage number. It should normally never be necessary to override this.

VMAD properties are always explicitly stored as UTF8. There is no way to override this. All supported games always expect these strings to be UTF8 and any other codepage would result in errors.

Localized strings are accessed based on the language name that's part of the filename of the `.strings` files.

For Skyrim (not SE), the following language names are recognized:

* english - 1252
* french - 1252
* polish - 1250
* czech - 1250
* danish - 1252
* finnish - 1252
* german - 1252
* greek - 1253
* italian - 1252
* japanese - UTF8
* norwegian - 1252
* portuguese - 1252
* spanish - 1252
* swedish - 1252
* turkish - 1254
* russian - 1251
* chinese - UTF8;
* hungarian - 1250
* arabic - 1256

For SSE, the following language names are recognized:

* english - 1252

For Fallout 4 and Fallout 76, the following language names are recognized:

* en - 1252

The fallback for unknown languages is always UTF8. (SSE, FO4, and FO76 always use UTF8 for anything except english.)

xEdit will automatically use the correct codepage for localized strings, even when the language is switched at runtime using the localization context menu.

The codepage for these files can be overridden byte creating a text file with the same name as the `.strings` file, but the extension `.cpoverride` instead. e.g. `Skyrim_English.cpoverride`. The file should contain a single line with the desired codepage. 

xEdit used to always default to "English" ("En" for Fallout 4) as language if not explicitly specified on the command line using `-l:<language>`. While it is still possible to use that switch to override the language selection, xEdit will now attempt to get the correct language from the `<game>.ini` file, from the iLanguage key for Oblivion, and the sLanguage key for any later games.

For localized strings, while this language setting affects the inital choice of which `.strings` files are being used for localized modules, this can be changed at runtime using the localization context menu.

Translatable string use the same codepage as localized strings, but based on the language defined at program start (either from the `<game>.ini` or explicitly using `-l:<language>`) For games before Skyrim, the same list of language names and codepages as listed above applies. Changing the language through the localization context menu after xEdit has started will *not* change the codepage being used for translatable (but not localized) strings.

The codepage used for translatable strings can be globally overridden (has priority over the language selection) using the `-cp:<codepage>` or `-cp-trans:<codepage>` command line parameter where `<codepage>` is either `utf8` or a codepage number. `-cp` is supported for backward compatibility, `-cp-trans` is preferred.

The codepage can further be overridden on a per module basis by creating a `.cpoverride` file with the same name as the module, like described above for `.strings` files. e.g. `Dragonborn.cpoverride`.

The following entries near the top of the message log provide information about the used codepages:
```
Using language: russian
Using general string encoding: 1252  (ANSI - Latin I)
Using translatable string encoding: 1251  (ANSI - Cyrillic)
Using VMAD string encoding: 65001 (UTF-8)
```

When `.strings` files are loaded, the used encoding is shown in the log:
```
[00:00] Background Loader: [Skyrim_russian.STRINGS] Using encoding: 1251  (ANSI - Cyrillic)
```

When a `.cpoverride` is in effect, it's specifically noted:
```
[Dragonborn_English.STRINGS] Using encoding (from override): 65001 (UTF-8)
```

When a module has a `.cpoverride` applied to it, it is also recorded in the log:
```
[00:04] Background Loader: [Dragonborn.esm] File loaded (CRC32:A9F83BFF)
[00:04] Background Loader: [Dragonborn.esm] Using encoding (from override): 65001 (UTF-8)
[00:04] Background Loader: [Dragonborn.esm] Start processing
```

These changes allow explicit control of all used codepages, and make xEdit's behaviour independent from the ANSI system codepage of the local OS.

## updated Skyrim.Hardcoded.dat

# What's new in xEdit 3.3.2 BETA?

## Bugfixes

The following reported issues have been fixed:

* #583 - Edited scripts not marked as not modified when manually saved
* #584 - deleting things from use template actors (sorted) sometimes moves two entries down instead of 1
* #585 - xEdit doesn't remember which monitor it was last placed on in certain situations
* #586 - keyboard selection in dropdown lists doesn't work 
* #587 - modified bold font doesn't fully get removed
* #588 - dropdown in a specific part of omod's properties doesn't work
* #589 - dropdown list's horizontal scrollbar covers up the bottommost entry 
* #590 - alt+cursor movement defaults to descriptions column if out of bound

# What's new in xEdit 3.3.1 BETA?

## Bugfixes

The following reported issues have been fixed:

* #574 - stick to row doesn't work with alt+navigation 
* #576 - Record flags aren't copied correctly when dragged and dropped 
* #577 - Data flags aren't copied when dragged and dropped 
* #579 - xEdit doesn't interpret string encoding in VMAD properties as UTF-8 even -cp:utf-8 is added

## Fallout 76 support

Significant progress has been made on updating record definitions for Fallout 76, but much more work remains to be done.

Fallout 76 mode can be enabled by renaming the exe to `FO76Edit.exe` or starting it with `-fo76` as parameter.

At the current stage of development, please expect lots of error messages and possibly crashes from incomplete record definitions.

## What's New tab

This "What's New" document is now also shown in the "What's New" tab.

# What's new in xEdit 3.3.0 BETA?

## UI Themes

xEdit now supports a number of build in UI Themes. They can be activated either through the "Theme" sub menu in the system menu (icon on the top left corner) of the main window, or via the UI Theme tab in the Options.

The UI Theme tab in the Options provides a preview of the selected theme.

In both the Theme menu and the UI Theme tab, the themes are separated into Light (darker text on lighter background) and Dark (lighter text on darker background) themes.

Themes require desktop composition to be enabled. The option to select themes is hidden if the system requirements are not met.

## Theme awareness for conflict colour

xEdit is now aware of the current colour scheme (be it the standard windows colours or from an explicitly selected Theme) as Light (darker text on lighter background) and Dark (lighter text on darker background) and will automatically use modified (lighter/darker) text and background colours based on the colours specified in the Options for signalling conflict status.

## Legend for conflict colours

At the top right corner of the View tab is now a Legend button which toggles the visibility of a Legend tool window which shows all possible combinations of Conflict This (text colour) and Conflict All (background colour).

While the Legend form is open, when changing the focused cell in the View treeview, the matching cell (Conflict This/Conflict All) in the Legend window is focused.

## High-DPI aware

xEdit is now flagged as High-DPI aware and the UI should generally scale correctly when the scale factor is set to > 100% in the windows settings. A known limitation is that window caption bars and some other elements are not scaling correctly when custom themes are used.

## ESL support

xEdit now fully supports the ESL flag in the file header (as well as the .esl extension which implicitly always sets the ESL flag).

ESL flagged modules will be loaded into a "light" slot and will have their FormIDs mapped into the FExxx space. Exactly like the game engine. This means it is now possible to have up to 253 "full" modules (00 to FD) and 4096 "light" modules (FE000 to FEFFF) loaded at the same time.

The ESL flag does not affect load order (light modules can load before full modules, the first digits of the FormID are NOT a reliable way to determine load order anymore).

xEdit will prevent files from being saved with set ESL flag if they are not compatible (contain new records with an ObjectID, that's the last digits in the FormID, > $FFF) and will warn on loading incorrectly ESL flagged modules.

ESL support can be controlled with two parameters:
`-IgnoreESL` will load all modules into full slots, ignoring the ESL flag and the .esl extension
`-PseudoESL` will load all ESL compatible modules into light slots, even without the ESL flag and the .esl extension. This works even for games that do not have ESL support in the game engine.

## Referenced By Caching

Referenced By information is now being cached after being build. The cache files only need to be rebuild if the CRC of the module or application changes. 

Refs are only saved to cache if reaching a threshold of more than 500 records in the file or ref building is taking more than 2 seconds.

The message log shows if referenced information is build or loaded, and if build, if it has been saved.

As Referenced By information is now always automatically build for the {game}.esm file as well, the first start after an update can take a few minutes, but all further starts will be able to read in the cached information in seconds.

The cache files have the extension .refcache and are stored by default in "Data\{game} Cache\". The actual used cache path is shown in the messages log.

The cache system can be controlled with these parameters:
`-DontCache` = completely disables ref caching
`-DontCacheLoad` = don't load cache files if present, but save if possible
`-DontCacheSave` = don't save cache files after building refs
`-C:{path}` = path to use for cache files	

## Multi-threaded building and loading of Referenced By information

The process of building or loading Referenced By information during start is now performed in multiple threads and will scale well with the number of CPU cores available. This can significantly speed up startup time.

## Application and module CRC32 information

The CRC32 of the application file is shown at the top of the messages log
The CRC32 of loaded modules is shown during the loading and in the navigation treeview.

## Load order handling

The load order handling has been rewritten completely from scratch and should now exactly mirror the behaviour of the game engine for all supported games.

Specifically, for TES4, FO3, and FNV load order is derived from file modify times.
For TES5/SSE and FO4 from the order in `plugins.txt`.
For TES5 (which does not contain inactive modules in it's plugins.txt) the load order for inactive modules is supplemented from `loadorder.txt`.

For SSE and FO4, files with the `.esm` and `.esl` extensions are always treated as having the ESM flag set, even if it is missing in the file.

The load order is:
1. `{game}.esm`
2. `Update.esm` - SSE
3. Official DLC in hardcoded order - SSE and FO4
4. `{game}_VR.esm` - SkyrimVR and Fallout 4 VR
5. Creation Club files in hardcoded order - SSE and FO4
6. ESM flagged files
7. non-ESM flagged files

If during loading of modules in this order a module is being loaded for which one or more required master module is not already loaded, then the required module is loaded first. This allows non-ESM flagged files to be pulled forward into the ESM block.

## New Module selection dialogs

The selection dialogs for modules (used for selecting active modules at start and target modules during adding masters, "copy as ... into" and similar operations) has been completely rewritten.

It is now using a treeview which allows you to see the required masters. 

There are columns for File Order (giving the exact reason for the position in the order), ESM flag, ESL flag (for SSE and FO4), Load Order (for active modules) and FormID Prefix.

The visible modules can be filtered using an edit above the treeview.

Modules with missing masters are shown with ~~strike-through~~ and can't be checked.

For selecting modules to be loaded, checked modules will implicitly check all required masters (shown with [.] instead of [X]).

You are able to save and load named presets of checked modules.

Double Click or Ctrl+Enter will check only the selected module and automatically close the dialog with OK.

When used for "Copy as ... into", template entries allow you to specify the desired extension and initial ESM/ESL flag values for a new file.

When used for "Copy as ... into", the previous selection is remembered.

## Optional 'Selection Forms require holding CTRL for double click'

A new option 'Selection Forms require holding CTRL for double click' has been added. Defaults to false.

With this option active, CTRL must be held down for Double Click to be accepted in the Module, Mod Group, and (old style) file selection forms.

## Fully implemented .ghost support

.ghost files are treated everywhere (except for actual file access) as if they didn't have the .ghost extension.

If a normal file and a .ghost file exist, the .ghost file is ignored.

Except in the save dialog, the UI does not show the .ghost extension.

## Completely reworked ModGroups support

ModGroups is a feature that has been in xEdit for a long time, but has gotten very little attention in the past.

This version totally overhauls the ModGroups support, adding many new features as well as providing complete UI integration for creating, editing and managing ModGroups.

A ModGroup is a way to tell xEdit that certain (non-winning) overrides of a record can be hidden (because the still visible versions account for all the changes already). By hiding away these versions they no longer participate in conflict detection which can be used to prevent false positives from showing up.

A ModGroup can never hide the winning override or the original master record.

A setup where all real conflicts have been resolved by patches and all false positives hidden by ModGroups will show an empty navigation treeview after applying a "Filter to show conflicts". With this as the starting point, adding one new mod to an existing setup with 100's of mods will result in only the conflicts caused by the addition of that new mod to show up when running "Filter to show conflicts". This makes it very easy then to adjust the load order, created targeted patches to resolve real conflicts, and finally again create new ModGroups to hide away any false positives.

### New ModGroup Selection dialog

When the background loader is complete, a new ModGroup Selection dialog is shown. This dialog is very similar to the new Modules Selection dialog and has most of it's features.

The dialog is based on a treeview, so you can directly expand the individual ModGroups to see their contents.

You can filter the treeview to more easily find a specific ModGroup.

A system for saving and loading presets is available.

### Enable/Disable and Reload ModGroups

The context menu on the View treeview has options to disable or enable ModGroups, as well as a function for reloading all ModGroups and show the ModGroup selection dialog again.

### Creating ModGroups

There are two ways to create ModGroups in the UI.

The first is by selecting 2 or more modules in the navigation treeview, and then using the "Create ModGroup..." function in the context menu, or pressing Ctrl+M with the navigation treeview focused. This will create a new ModGroup consisting of the previously selected modules and open it in the ModGroup Editor.

The second is when looking at the View tab with at least 3 records visible (master + 2 overrides). The context menu on the header of the view treeview has a "Create ModGroup..." function, which can also be called by pressing Ctrl+M while the View treeview is focused. This function will then show a Module Selection dialog listing all modules that contribute override records to the current View and where you can check the modules that should be part of this new ModGroup. After confirming the desired modules a new ModGroup will be created and the ModGroup Editor will be opened.

### ModGroup Editor

The ModGroup Editor shows the list of modules that are part of the ModGroup.

New modules can be added by pressing Insert. 
Modules can be moved up or down by pressing Ctrl + Cursor Up / Cursor Down.
CRCs can be added to a module by pressing Shift+Insert when that module is selected, or just Insert if one of the existing CRCs if that module is selected.
A selected module or CRC can be deleted by pressing Delete.

If one or more CRCs has been added to an module, then the CRC of the currently loaded module must match one of these CRCs, otherwise the module is treated as if it wasn't present.

Each module has a number of flags:
* Optional - All modules NOT flagged as optional must be present for the ModGroup to be valid.
* Target - Override records in this module can be hidden.
* Source - A override record in this module will cause the overrides with the same FormID to be hidden from all modules flagged as Target and listed above this Source in this ModGroup.
* Forbidden - If this module is loaded, the ModGroup is invalid.
* Ignore LO - If not flagged, then the module must be loaded in the same order as listed in this ModGroup. There are two possible flagged values for this column:
    * Always - The load order of the module does not matter at all.
    * in Block - all consecutive modules with this flag form a Block. Any module above the block must be loaded before any module in the block. Any module after the block must be loaded after any module in the block. The modules inside the block can load in any order.

The flags can be toggled by focusing them and pressing space, or by clicking on them with the mouse.

Before a ModGroup can be saved, it must be given a name. There are two functions to make this easier:
* Pressing Ctrl+N while having a module selected will set the name of the ModGroup to the name of the module (minus extension).
* Ctrl+C can be used on any listed module to copy it's name to the clipboard which can then be pasted into the Name edit.

After confirming the ModGroup Editor with OK, a Module Selection will be shown with all modules that are part of the ModGroup to select in which .modgroups file this ModGroup should be saved.

After saving a ModGroup the "Reload ModGroups" function will be automatically triggered and the newly added ModGroup has automatically been checked.

### .modgroups files

.modgroups files are files with the same name as a module, but the extension .modgroups. 

These are text files that contain one or more ModGroup entries.

The exact format is described in the online help.

Only .modgroups files that have the same name as a module that is present will be loaded.

ModGroups from .modgroups files that do not belong to a currently loaded module will not show errors if they are invalid.

### Editing ModGroups

As long as at least one ModGroup exists, a "Edit ModGroup..." function is shown in the context menu of the navigation treeview.

It first shows a ModGroup Selection dialog, then loads the selected ModGroup into the same ModGroup Editor as is used for creating new ModGroups.

### Deleting ModGroups

As long as at least one ModGroup exists, a "Delete ModGroups..." function is shown in the context menu of the navigation treeview.

The ModGroup Selection that is then shown allows to select one or more ModGroups for deletion.

### Updating CRCs

As long as at least one ModGroup exists, a "Update CRC in ModGroups..." function is shown in the context menu of the navigation treeview.

This function first shows a Module Selection with all modules that are part of ModGroups with either no CRC or missing the current CRC.

After that a ModGroup Selection is shown with all ModGroups that are missing the current CRC of one or more of the previously selected modules.

After choosing which ModGroups to update, the missing CRCs will be added to all checked ModGroups.

## Auto "Compare Selected"

A new option 'Auto "Compare Selected" when multi-selecting less than [x] records' has been added. Defaults to 5. Can be disabled by setting to a value smaller than 2.

When multi-selecting less than the specified number of records in the navigation treeview, the "Compare Selected" function is automatically triggered, showing the selected records side by side in the view tab.

When more records than the specified limit are selected, "Compare Selected" can still be triggered via the context menu on the navigation treeview, like before.

## Rewritten "copy [multiple] to selected records"

The "Copy to selected records" function (available in the context menu of the view treeview) has been rewritten. 

It can now only be used when in "Compare Selected" mode. In return, it now behaves exactly the same as dragging the value from the focused cell to the other cells in the same row in the view treeview. This solves all previous problems with the function.

A new "Copy multiple to selected records" functions has been added, it allows performing "Copy to selected records" for a selection from all top level entries in the current view to be performed in one operation.

## Resetting settings on start

xEdit can be started with `-resetsettings` to have it automatically reset all settings.

Holding Shift+Ctrl+Alt when starting xEdit triggers a dialog asking if all settings should be reset.

In either case, the existing settings file is being backed up and all settings are reset to their default values.

## Allow direct saving

New command line parameters have been added that allow directly saving over an existing file (instead of saving in a temporary file and waiting until xEdit is closed to rename the file) by preventing the use of memory mapped files.

`-AllowDirectSave` will load all non-official (official = game master, official dlcs, CCs) modules without using memory mapped files  
`-AllowDirectSave:a.esm,b.esl,c.esp` will load only the listed modules without using memory mapped files. The list may include official modules.

## Editing in view treeview

Double Click in the view treeview now activates the in-place editor for Integer (includes FormID), Float, and Flag fields, and opens the editor form for everything else.

Showing the in-place editor for fields with large drop down lists of potential values (especially FormIDs) has been hugely (multiple orders of magnitude) sped up.

## Element Editor Form

The Element Editor Form (opened by Double Click in the View treeview on string fields) now accepts Enter to insert line breaks and supports Ctrl+F to search in the text.

## Apply filter

A huge speed up in applying certain filters has been achieved.

"Apply Filter to show Conflict Losers" has been renamed to "Apply Filter to show Conflicts" and changed from showing [ctConflictLoses] to showing [ctIdenticalToMasterWinsConflict, ctConflictWins, ctConflictLoses].

The 3 "Apply Filter..." menu items functions have been extended with 3 "Apply Filter... (selected files only)" functions. These behave the same as the original functions, except that only selected files are added to the treeview before the filter is being applied. This will not change the filter outcome for the nodes that have been added to the treeview, and will simply prevent nodes from files that weren't included in the selection from showing up in the result. This can dramatically speed up the filter process. e.g. when applying a filter for cleaning, it's not necessary to apply that filter to any file except the one that should be cleaned.

When a filter is applied, the navigation treeview is "fossilized" (always has been that way). This means that all nodes in the treeview, visible or not, have been created at the time the filter was applied, and the treeview will not react to structural changes (like adding new records to a file) while the filter remains applied. This was not well understood by most users before. To prevent confusion, a hint is now shown above the navigation treeview explaining this while a filter is active.

When "Apply filter for Cleaning" is executed, ModGroups, "Show Master and Leafs", and "Quick Show Conflict" mode are automatically disabled.

The "By BaseRecord" check list box will now only contain records that can actually be base records (= placed in a CELL by a reference record).

When a check list box is focused, +, -, and * keys can be used to trigger "Select All", "Select None", and "Invert Selection".

If a preset has been selected in the Filter Options dialog, and the options have been changed after loading the preset, a confirmation dialog will now be shown to confirm if these changed options should be saved back into the preset.

## Reachable information

This function has been present in xEdit for a long time, but seems to have become non-functional. 

It is now possible to build reachable information for all games supported by xEdit.

A record is considered "reachable" if a normal player, starting a fresh game with the current load order, and without using the console or other tricks, is able potentially to somehow interact with that record.

Once reachable information has been build, it is possible to filter for reachable/unreachable records using the usual "Apply Filter..." function.

Correct generation of reachable information requires a lot of fine tuning of the record definitions and is still a work in progress. It currently works probably best for SSE.

## Editing "Master Files" in "File Header"

Previous versions allowed to freely edit Master Files in the File Header. Because adding or removing MAST sub records directly will not renumber the FormID's stored inside the file, this would lead to behaviour that is unexpected (and usually destructive in nature) for people that don't have a deep understanding of the internal workings for module files.

xEdit will now by default prevent any direct changes to Master Files. The correct way to add a master is to use the "Add Masters" function in the context menu of the navigation treeview. The correct way to remove a master is to make sure the file no longer contains any references to the master in question and use the "Clean Masters" function in the context menu.

To allow direct editing of the Master Files again, xEdit must now be started with `-AllowMasterFilesEdit` in addition to `-IKnowWhatImDoing`. Please only use that parameter when really required and when you actually do know what you are doing.

## Improvements to adding, sorting, and cleaning masters

"Add Masters..." now uses the new Module Selection form.

"Sort Masters" has been renamed to "Sort Masters (to match current load order)" to make it's function more clear.

"Clean Masters" has been renamed to "Clean Masters (= Remove all unused Masters)" to make it's function more clear.

All 3 functions should perform much faster and use much less memory. They will also no longer leave Elements that needed to be internally updated (but which don't have their visual value changed) visually marked as modified.

## Optional "Show File Header Flags"

A new "Show File Header Flags" option has been added. 

When this is active, the ESM, ESL, and Localized flags are shown for file nodes in the navigation treeview.

## PlayerRef [PLYR:00000014] as visible record in {game}.exe
	
PlayerRef (FormID 00000014) is now a visible record in the {game}.exe module (instead of being treated as a special hardcoded value internally). 
	
This makes it possible to track the Referenced By information for this record.

## Hardcoded.dat files updated

The {game}.Hardcoded.dat files have been updated to include more records and their filenames have been simplified.

## Copy to Clipboard on navigation treeview

Ctrl+C on the navigation treeview will copy the contents of the first column of the selected nodes to the clipboard.
Ctrl+Alt+C will copy the following value of the 3rd column.

## [Very] Quick Show Conflicts

xEdit can be started with the following parameters:

`-quickshowconflicts` - after confirming modules to be loaded, automatically load all valid mod groups and "Apply Filter to show conflicts" in a special, faster, way
`-veryquickshowconflicts` - same as above, but automatically loads the modules as specified in plugins.txt without showing the module selection dialog (except if CTRL is held when starting)

## Quick [Auto] Clean

xEdit can be started with the following parameters:

`-quickclean` - after selecting a single module, the module and required masters are loaded, a filter for cleaning is automatically applied for the selected module only, and "Undelete and Disable References" and "Remove "Identical to Master" records" are executed for the selected module.
`-quickautoclean` - same as above, but the "Filter, UDR, Remove ITM" sequence is repeated 3 times, automatically saving the file after each iteration, and finally "BOSS/LOOT Cleaning Report" is executed.

Quick Clean mode automatically turns off "Simple Records" (to ensure the largest number of possible ITMs are recognized) and sets "I Know What I'm Doing" mode (to prevent the edit warning).

## Drag'n'Drop of whole record in view treeview

In the view treeview, it is now possible to copy the contents of the whole record by dragging the header (showing the file name) of one column onto another.

## Nav mesh improvements

For TES5/SSE and FO4, triangle edges with edge links are now considered equal if they resolve to the same triangle number in the same external nav mesh, even if the edge link table index stored in them is different. (Requires "Simple Records" to be turned off.) As the CK has the habit of shuffling around the order of the entries in the edge link table, even when there were no actual changes to the edge links, this will significantly increase then number of NAVM ITMs that xEdit can detect, greatly reducing the conflict surface of cleaned mods.

For TES5/SSE and FO4, comparison of vertices in triangles is now based on the vertex coordinates instead of the vertex number.

Record definitions have been improved and standardized for all games with nav meshes.

It is now possible to Ctrl+Click on Triangle numbers in NAVM (both internal triangle numbers as well as edge links in triangle edges) to jump directly to the triangle in question, just like with FormIDs.

## Program shutdown can be interrupted

When the dialog for saving changed files is shown when closing the program, closing that dialog by pressing the [X] in the top right corner, will now interrupt the closing of the program, instead of behaving like the OK button has been pressed.

When an error happens during saving on program shutdown, the closing of the program is interrupted instead of simply continuing.

## "Compare to..."

The "Compare to..." function now handles modules with HITMEs (FormIDs with a ModID HIgher Than Master Entries) better.

It will now remember the last folder (even across session).

## "Create delta patch using..."

A "delta patch" is a module containing only the records that have changed between two versions of another module.

It is, effectively, the reverse of "Merge into Master". If you have two versions of a module and produce a delta patch, then using the "Merge into Master" process of merging the delta patch into the first version of the module will result in the 2nd version of the module. 

Creating a delta patch works similar to using "Compare to...". After loading the old version of a module normally, the "Create delta patch using..." function asks for a newer version of the same module and the name of the to be created delta patch.

It will then make a copy of the newer version into the data folder, using the specified name and .esu as extension (= Elder Scrolls Update, an extension that TES4Gecko introduced for delta patches). 

This copied file will then be loaded using the same method as "Compare to...". Any record existing in the old version of the module and not in this new version will be copied and then flagged as deleted. Any record that is identical (using the same rules as ITM detection) between the two modules will be removed from the delta patch.

This leaves the delta patch with only the records that have changed between the two versions of the module.

It is recommended that the delta patch is saved and xEdit closed after creating it.

Like with "Compare to..." last folder will be remembered (even across session).

One of the most important uses of a delta patch is when a module that another module uses as master has been updated.

Suppose you have ModA and ModB, and a CompatPatchAB. ModA got updated and you want to figure out if CompatPatchAB must be updated.

Create a delta patch between the old and new version of ModA, then restart xEdit and load: ModA, DeltaPatchA, ModB, CompatPatchAB.

It is now easily possible to go through the records in DeltaPatchA (which contains only the records that have been changed in the updated version of ModA) and see side-by-side the old values in ModA, the new values in ModA, and the values in CompatPatchAB. Wherever a value has changed between ModA and DeltaPatchA, this value can be dragged over from DeltaPatchA to CompatPatchAB.

"Create delta patch using..." can also be used to turn an .esp replacer into a patch.esp (rename outside xEdit after creating it) which can be used on top of the original .esp. 

This is especially useful in cases where for the same original .esp there are two or more .esp replacers with different functions that you normally can't use together. By changing the .esp replacers into patch.esps they can be used at the same time together with the original .esp. (May require the creation of another patch if there are conflicts between these different patches that need to be resolved.)

## .esu as fully supported module file extension

.esu is now supported as file extension for modules, equivalent to .esp

.esu is a file extension that the game engine doesn't recognize, which makes it suitable for files like delta patches that shouldn't normally be loaded into the game.

## Buttons to open Help, NexusMods, GitHub, Discord, or Patreon pages

Buttons have been added to the top right corner of the main window to open:

* Help - Online help for xEdit.
* NexusMods - The NexusMods page for xEdit, adjusted for whatever game mode xEdit is currently running as.
* GitHub - Where you can find the latest development version of xEdit, as well as report issues.
* Discord - The xEdit Discord server. Real-time chat with other xEdit users and developers. Everyone is welcome.
* Patreon - ElminsterAU's Patreon page for xEdit. Your support is absolutely essential to ensure ongoing future development of xEdit.

## Update check on GitHub

xEdit will automatically perform a check for a newer version on GitHub

This can be turned of with the "Don't check for GitHub update" function.

If an update is available, a balloon hint will be shown under the GitHub button on start.

## Patreon reminder balloon hint

A balloon hint is shown to highlight the Patreon button.

If the button is clicked or the hint closed with the [x] then it will not be shown again for a while.

The "I'm a patron or donor" option can be used to disable the hint if you have pledged on Patreon or directly donated on NexusMods to permanently disable the hint.

Please consider supporting xEdit development. Future updates as extensive as this one directly depend on the level of support from the modding community.

## Column width modes

The Column width modes (changeable via context menu on the view treeview) have been overhauled.

All Columns have a minimum width of half the standard width specified in Options.

Available options are now:
* Standard - All columns use the intial standard width specified in Options. Column width can be adjusted and will only reset when moving to a different record
* Fit All - The title column (first column) uses the standard width, the remaining space is equally distributed among all columns. The column size is automatically adjusted if the window is resized
* Fit Text - The width of the columns is automatically adjusted to fit all text currently visible on screen. The column widths are updated automatically when scrolling.
* Fit Smart - Combination of Fit Text and Fit All. The width of the columns is automatically adjusted to fit all text currently visible on screen. If the total width of all columns exceeds the client width of the treeview, then all columns except the title column (first column) are proportionally shrunk so that all columns fit inside the client width of the treeview. The column widths are updated automatically when scrolling.

## Hide no conflict and empty rows

The "Hide no conflict and empty rows" option can be enabled/disabled using the context menu of the view treeview.

When active:
* If more than one record is being displayed, all rows with a Conflict All status of Benign Conflict or lower are hidden.
* If only a single record is being displayed (which would hide all rows), empty rows are being hidden instead.
* If Compare Selected is active, all rows with a Conflict All status of Multiple but no conflict or lower are hidden.

## Option to delay updating view when scrolling through navigation treeview

A new option "Delay updating View when navigation treeview selection changes by [x] msec" has been added. Default being 50. 

This prevents the View from flickering while fast scrolling through the navigation treeview (e.g. by holding the cursor up or down key) by delaying the update of the View for the specified amount of time.

Setting it to 0 disables the behaviour and does instead make sure the view is updated for every record scrolled through.

## Optional "Align alignable array elements"

A new option "Align alignable array elements" has been added. Defaults to true.

When active, unsorted arrays (e.g. Conditions) will be aligned.

Alignment is not sorting!

As an example, without the option, a record with 2 overrides looked like this:
```
A  B  B 
B  C  A
C
```

with alignment active, it will now look like this:
```
A
B  B  B
      A
C  C
```

For arrays, their name (in the title colum = first column) will have `(sorted)` or `(aligned)` added if the array is sorted or aligned.

## Filter for View Treeview

On the View tab, above the treeview, there is now a bar with filter options. 

It's possible to filter by Name and/or Value.

The filter will only keep nodes that contain the filtered for values, as well as their parents all the way to the root.

There is an option to keep the children, siblings, and parent's siblings of nodes matching the filter.

To change focus with the keyboard use:
* Alt+N or ? for by Name filter edit
* Atl+V for by Value filter edit
* Enter to jump: by Name -> and/or -> by Value -> View treeview
* Cursor Down: from by Name or by Value filter edit to View treeview

## Improved cell focus handling in View treeview:

After Move Up/Down (menu) / Ctrl+Cursor Up/Down (keyboard) the focus will correctly stay with the moved element.

After Add (menu) / Insert (keyboard) the focus will be placed on the added element. This can be turned off with the option "Focus newly added elements in View" (defaults to true).

After drop the focus will be placed on the dropped element.

## Column sensitive row labels in View treeview

The row labels (the first column) in the View treeview will adjust based on the column which currently has the focus.

This is especially relevant in combination with alignment and elements which type and name depends on the value of some other element.

## Change to source for implicitly copied records during "[Deep] Copy as override/new into..."

When performing a "[Deep] Copy as (override/new record) into..." operation of a record that is not directly contained in a top level group (e.g. a CELL inside a WRLD or a REFR inside a CELL) it is necessary that container records are implicitly copied first.

Previous versions of xEdit used the winning override of these implicitly copied records as source.

From now on, xEdit will instead use the highest override visible to the target file (based on it's masters) as a source.

## Merge into master

To support "merge into master" functionality (for replacing the use of version control in CK) two new functions have been implemented:

## "Inject Forms into master..."

"Inject Forms into master..." (available in the context menu of a file node in the navigation treeview) will change the FormID of all New records in the file to instead be injected records (=override records without a master record in the file where they belong according to FormID prefix). 

Optionally it's possible to try and preserve the ObjectID (the not load order dependant part of the FormID) during this operation.

This does not actually yet copy the records into the master, but is a necessary first step.

Warning: The function will NOT rename any external files that might contain the FormID in their file names.

## "[Deep] copy as override (with overwriting) into..."

"(with overwriting)" changes the behaviour of the normal "[Deep] copy as override into..." function. 

Normally, that function will not overwrite an existing record with the same FormID in the target.

If the "(with overwriting)" variant is used, then an existing record in the target will trigger a confirmation dialog to decide if the record should be overwritten. The dialog also gives the choice of "Yes for all" and "No for all".

If the source record is flagged as deleted, then a confirmation dialog is shown to decide if the record should be copied (overwriting the target with a record flagged as deleted) or the existing record in the target should be removed.

After injecting forms into master, by performing a "Deep copy as override (with overwriting) into..." from all top level groups of a module, and selecting one of its masters as the target, then selecting to overwrite all existing records and having the targets of all records flagged as deleted removed, the Version Control based functionality of CK to merge a plugin into master can be emulated.

## "Compact FormIDs for ESL"

This function takes all New records with ObjectID > $FFF and attempts to change them to a free ObjectID <= $FFF. It will fail if there are too many new records in the module.

Warning: The function will NOT rename any external files that might contain the FormID in their file names.

## "Renumber FormIDs from..."

This previously existing function shares it's implementation with "Inject Forms into master..." and "Compact FormIDs for ESL".

Warning: The function will NOT rename any external files that might contain the FormID in their file names.

All 3 functions will show a list of affected record signatures before performing the renumbering.

## Generalized parameters for ONAM handling

`-FixPersistence`/`-NoFixPersistence`and `-FilterONAM`/`-NoFilterONAM` parameters are now generally available instead of just in tmMasterUpdate and tmESMify.

## Collapsible Nodes in View tab

Nodes in the View tab now have a [-] symbol that can be used to collapse them.

Collapsing or expanding a single node is stored in the elements and applies only for that one record. It may also get forgotten when navigating away from the record and coming back later. (This depends if the element gets freed or not, which depends on exactly which element it is and if it has been modified or not.)
        
When holding control while clicking the [-] in front of the node, the collapse or expansion is stored in the type definition instead of the Element and applies to all Elements of that definition. That means it will be preserved when navigating between different records.

It is possible to have the type collapsed and then expand individual elements, or have the type expanded and then collapse individual elements. When expanding or collapsing a type (by holding control) then the state of all individual elements of that type is reset to match the state of the type.

In addition to clicking on the [-], nodes can also be collapsed or expanded by double clicking on the desired row in column 0 (the title column) as long as Compare Selected is not active (which already uses double click in the title column to trigger sorting by the values in that row).

## Next Object ID in File Header

The "Next Object ID" Element in the File Header is now displayed in Hex.

When editing it, it can be set to ? to automatically set it to the highest Object ID in the Module + 1

## File Header in View when file node selected

The View tab will now show the File Header when the top level file node is selected in the navigation treeview. This makes it possible to scroll through the files and look at the File Header without having to expand each file node to select the File Header node.

## Improved feedback during long operations

During long operations (building reference or reachable information, filtering, ...) the message log will now have a "still [operation]..." message added if no other message has been logged for 10 seconds and the format of the progress information in the window caption has been standardized.

This is an ongoing change and not all long operations may have been converted to the new system yet.

## GameLink / FO4EditLink

A FO4EditLink plugin for F4SE is now included.

If that plugin is loaded into FO4, and FO4Edit is started as the same time as the game, with the same load order, then it is possible to activate GameLink using the context menu of the "Path" bar at the top of the xEdit window.

Once activated, if a reference is selected in the console in game, xEdit will automatically change the View tab to showing that record.

This function is currently only available for FO4, but might be added to other games in the future.

## General record definition improvements and fixes

A large number of improvements and fixes have been made to the record definitions for all supported games.

In many cases these changes should allow previously unrecognized ITMs to be correctly recognized as such now.

A generic mechanism has been implemented to allow setting of default values in the record definitions, so that they can be automatically set when an element of that type is added. This is especially important for elements where the default of all bytes set to 0 does not result in a valid value.

A generic mechanism has been added to allow "recursive" record definitions. This now allows VMAD Properties of type "Struct" or "Array of Struct" to contain members that are again of type "Struct" or "Array of Struct", up to arbitrary numbers of nesting levels deep.

It is now possible to add (VMAD) Scripts and Properties through the UI (both Adding and drag'n'drop).

## Using EditorID to flag ITMs as intentional

In TES5/SSE and FO4/FO76 EDIT is now flagged as case sensitive, with a conflict priority of cpOverride.

That means that changes to the case of any character will be recognized as a change. But at the same time, the EditorID will never be considered to have a higher conflict level than "override without conflict".

As the game engine treats EditorIDs always as case insensitive, changing the case of a character will not affect the game at all, but at the same time will make xEdit no longer treat the record as an ITM.

## File modification date/time on save

For games where the module file modification date/time is _not_ used to control load order (TES5 and later) xEdit will no longer preserve the existing file modification date/time on save.

## Adding of CELL (and ROAD) to WRLD, and reference (REFR, ACHR, ...), LAND, PGRD, and NAVM to CELL via the UI (or Add() function in scripts)

In the UI, it is now possible to add CELL (and ROAD in TES4) to WRLD using the normal add menu.

A dialog will be shown to specify persistent or temporary + x, y

The function will the first search for an existing CELL (copying as override into the current file if necessary) and only if no existing CELL can be found will a new one be created.

It is now also possible to add LAND, PGRD, and NAVM records to CELL through the UI.

For LAND and PGRD (each of which can only have a single record per CELL), the same search for an existing record and copy as override if necessary is implemented as for CELLs.

When adding a reference (REFR, ACHR, ...) to a temporary exterior CELL, its initial position is set to the centre of that CELL.

This functionality is also available to scripts through the existing `Add()` method.

## Updating containing CELL of reference when necessary

When a reference (REFR, ACHR, ...) needs to update it's containing group (position changed, persistent flag changed, ...) it will now internally use the functions above to find or create the right CELL. This also fixes an existing bug where changing the position of a temporary reference did not move the reference to the correct temporary CELL (only when the record was changed to persistent and back was the cell updated, and then only if the right cell already existed, new cells were not created when necessary).

## Automatic updating of navigation treeview in reaction to structural changes

The navigation treeview will now (if not fossilised) automatically update to reflect any structural changes to a module without the need to manually collapsing and expanding the parent node.

If a record is copied (as new or override) into a module for which the Group where the record is placed is currently expanded, it will show up instantly. (Before it was necessary to collapse and expand that group before the record showed up.)

This change is especially noticeable together with the automatic updating of the CELL containing a reference that was mentioned above. When the position of a reference is changed in the View tab, the navigation treeview will now instantly show that reference under it's new CELL (while keeping that reference selected in the navigation treeview).

## "Remove" in the header context menu of the View tab

The "Remove" function in the header context menu of the View tab (which had been removed in the past because it sometimes removed the whole parent group instead of just the desired record) is now fixed and available again.

## LODGen updated

Various updates have been made to LODGen mode. Thanks sheson!

## Show floating point and decompression errors

Messages will now be shown in the log for corrupted floating point values (showed up as NaN in the View and will continue to do so, but the message in the log is new).

Messages will now be shown when an error occurs during decompression of compressed records.

There are known floating point and compression errors in the original Bethesda game files. The fact that these errors are shown now instead of silently ignored as before does not mean than anything is more broken then it was. You just know about it now.

## Working Next Member / Previous Member for RUnion (e.g. Alias in QUST)

For elements where it is possible for different type of sub records to occur (e.g. ALST = Reference Alias vs. ALCS = Collection Alias vs. ALLS = Location Alias) it is now possible to switch between the different options using the Next Member and Previous Member options in the context menu of the RUnion element.

## "Apply Script..." dialog improvements

A Filter edit has been added above the script selection combobox. This filter edit will limit entries in the script combobox to ones that contain the filter text anywhere in their name.

When changing the selected script, if the current script has been modified, a confirmation dialog asks if the changes should be saved first. (Silently discarded changes previously).

When the dialog is closed, if the current script has been modified, a confirmation dialog asks if the changes should be saved. (Silently overwrote the existing script previously). When closing and not saving, the modified script is still the one that's executed.

When saving a script and the file already exists, a backup copy will be made before overwriting the file.

## Scripting improvements


`procedure AddMasterIfMissing(aeFile: IwbFile; asMasterFilename: string; aSortMasters: Boolean = True);` now takes an optional boolean parameter (defaults to true) to turn off automatic sorting of masters after adding
`procedure AddMasters(aeFile: IwbFile; aMasters: TStrings);` Adds the list of masters in aMasters to aeFile. If sorting is desired an explicit call to SortMasters is necessary.

`procedure BeginUpdate(aElement: IwbElement);` and `procedure EndUpdate(aElement: IwbElement);` can be used to prevent change notifications from bubbling up the tree. This can hugely speed up creating / modifying larger arrays. 

It can be used like this:
```pascal
var
  Properties: IwbContainer;
begin
  //...
  BeginUpdate(Properties);
  try
    // add man Property entries to Properties
  finally
    EndUpdate(Properties);
  end;
end;
```

`procedure wbFormIDErrorCheckLock;` and `procedure wbFormIDErrorCheckUnlock;` can be used to disable FormID checking (e.g. to copy as override a record where the source contains unresolvable or otherwise invalid FormIDs without failing the copy).

`Add(WorldSpace, 'CELL[P]', True)` or `Add(WorldSpace, 'CELL[1,5]', True)` can be used to add a (or return an existing) persistent or temporary worldspace CELL to a Worldspace.

`ElementEditValue` and `ElementNativeValue` now always work for Flags, no matter if the flag is currently set or not.

 
# What's New in xEdit 4.1.5b?

## Bugfixes

* #1249 - [TES5/SSE] made LCTN definitions properly formversion aware
* (reported on discord) - array access in scripts can result in incorrect RangeCheck errors on 32bit
* (reported on discord) - conflict status is not properly reset if a record is removed
* (reported on discord) - [SF] PLDT\Radius is incorrectly defined as Integer instead of Float

## Minor Changes

* #1196 - Feature Request: Extend F2 to assigning editable elements
* #1245 - [SF] more TMLM definition 
* #1248 - Information tab updates
* #1249 - [BSArchPro] warning about compressing strings 
* (reported on discord) - [SF] added PRDS to PROJ definitions

# What's New in xEdit 4.1.5a?

## Bugfixes

* #1027 - [FNV] TESClimate Moons / Phase Length field is read from the .esm incorrectly
* #1240 - Conflict colors are not refreshed when filter is re-applied
* #1242 - GBFM Component Data - Property Sheet
* #1243 - [SF] WEAP\WVAR\Value - Min/Max typo

## Minor Changes

* #1243 - [SF] Added some more summaries
* #1244 - [SF] improved RACE record definition

# What's New in xEdit 4.1.5?

## Starfield

After a monumental effort of over 400 hours by me (ElminsterAU), along with the extensive contributions from numerous other contributors, this version now includes support for Starfield, with editing enabled.

To start xEdit in Starfield game mode, use the `-sf1` parameter or rename the exe to `SF1Edit.exe`.

### Initial Module Selection

#### Reliance on Plugins.txt

SF1Edit, consistent with its approach for all previous games, will source the initial selection of active modules from the `plugins.txt` file. 

#### Ignoring sTestFile1 to sTestFile10 Entries

`sTestFile1` to `sTestFile10` within the `StarfieldCustom.ini` file will be disregarded by SF1Edit when determining which modules to initially select.

### The Immensity of Starfield's Game Data

Starfield is not just large; it's massive. Given its size, only the 64-bit version of xEdit can handle the game data.

#### First-Time Setup
On the initial start, the process of building reference information will consume memory in the 4 to 5 GB range. This setup will take over 10 minutes to complete. Although xEdit allows users to browse while this process is ongoing, it is strongly advised to refrain from any operations until the complete loading process has concluded.

#### Subsequent Startups
For subsequent launches, the cached reference information should load in just a matter of seconds.

### Known Engine Bugs and Flawed Design Decisions

Through rigorous testing and scrutiny (through decompilation) of the current game engine, a variety of bugs and design choices have been identified that negatively affect the modding capabilities of the game. It's crucial to note that the list below is not exhaustive; there are likely many undiscovered issues remaining.

#### FormID Fields Missing Mapping Code

Various record types contain FormID fields that lack the necessary engine code to map them from their file-internal FormIDs to the global, load-order adjusted FormIDs commonly displayed in xEdit and the game itself. Specific instances have been confirmed for the following records:

- Material on Impact Data Set (`IPDS`) records
- Start Scene -> Scene (`LCEP`) in Scene (`SCEN`) records
- Keyword (`KNAM`) in Sound Keyword Mapping (`KSSM`) records
- Adjacent Snap Nodes (`NNAM`) in Snap Template Node (`STND`) records
- Surface Block Array in Surface Pattern (`SFPT`) records
- Surface Patterns arrays in Surface Tree (`SFTR`) records

#### Pack-Ins (PKIN) Anomalies

Overriding Pack-Ins (`PKIN`)—even with an exact byte-for-byte copy—results in unpredictable behavior.

#### Generic Base Form (GBFM) Crashes

If `GBFM` records overridden in `BlueprintShips-Starfield.esm` are copied as an override from `Starfield.esm` into a new module listing both `Starfield.esm` and `BlueprintShips-Starfield.esm` as masters, the main record will crash to the desktop. Copying these records from `BlueprintShips-Starfield.esm` seems to prevent this issue.

#### Fragility in FormID Formats with ESL Flagging

Compared to previous games, changes in the format of file-specific FormIDs have been observed when any masters are flagged as ESL. This alteration significantly compromises the internal structure of all affected modules. Should the ESL flag status of a master change in either direction, dependent modules will become misreadable—unless all masters revert to their original ESL state.

To elaborate on the term "misreadable": While the file remains structurally valid, allowing the game, CK, and other tools to read it, the association between the contained records and their respective modules becomes scrambled. As a result, a FormID that once referenced, or a record that overrode a record in ModA, may unexpectedly appear to belong to ModB. This shift could potentially lead to overriding or referencing entirely different records of completely different types.

In addition to this fragility, this new design lacks clear advantages and adds a layer of complexity for any tools designed to support Starfield module files with ESL-flagged masters. As of the time of writing, no known tools support this new format. Consequently, no files that would be affected by this change are currently in circulation, offering Bethesda an opportunity to reverse this ill-advised alteration.

#### Caution Against Using sTestFile1 to sTestFile10 for Module Loading

Utilizing the `sTestFile1` to `sTestFile10` entries in the `StarfieldCustom.ini` file for the purpose of loading module files is highly discouraged. Doing so can create a chaotic environment where custom module files are loaded in an unexpected sequence, possibly interleaved with official files. This can lead to a variety of issues, including but not limited to, game crashes, data corruption, and other instability problems.

#### Plugins.txt Not Processed

The current game engine, as published, does not process `plugins.txt` for loading modules. It is highly recommended to use the "Plugins.txt Enabler" mod, along with a mod manager that supports `plugins.txt` for Starfield (e.g., MO2), to use module-based mods in the game.

#### General Observations about the current state of modding support in the game engine

It is evident from analyzing both the data structures in the provided module files and from decompiling game code that modding capabilities were not a consideration in the development of the game engine up to now. This can also be inferred from the fact that there has been no quality assurance testing of modding functionality from Bethesda, as various current engine bugs that appear in the context of using mods would have been obvious showstoppers. Any existing modding capabilities appear to be incidental, stemming from the engine's legacy code base and the required work needed in that context to maintain functionality within the confines of editing `Starfield.esm` using the internal version of CK2.

This does not mean that Bethesda won't or can't still fix this. It is simply a statement about the state as it is right now.

### Limitations (Implemented to Mitigate the Impact of Identified Engine Bugs and Design Flaws)

To navigate around the array of engine bugs and less-than-ideal design decisions, SF1Edit 4.1.5 imposes the following limitations:

#### Reflection-Based Data Streams

Records that contain data streams reliant on reflection—a programming technique unrelated to in-game visual reflections—cannot be copied as overrides. This limitation stems from the fact that these data streams are yet to be fully decoded. They may contain FormIDs that would require remapping when copied to a different module.

#### Unmapped FormID Fields

Any FormID field that is not mapped by the game engine can only contain a non-null value under specific conditions: 
- The module containing this field must list `Starfield.esm` as its first master. 
- Even when `Starfield.esm` is the first master, the FormID field can only take on values formatted as `00xxxxxx`, where the `xxxxxx` references a record belonging to `Starfield.esm`.

#### Pack-Ins (PKIN)

Due to their unpredictable behavior when overridden, Pack-Ins (`PKIN`) records cannot be copied as overrides in SF1Edit 4.1.5.

#### Modules with ESL or Overlay Flags

Modules with either the `ESL` or `Overlay` flags set cannot be saved in SF1Edit 4.1.5.

#### Modules with Masters Having ESL or Overlay Flags

If a module has a master file that carries either the `ESL` or `Overlay` flags, SF1Edit 4.1.5 will neither save nor read such a module.

#### Game Masters Must Be Loaded

The module selection dialog box in SF1Edit will prohibit the deselection of `Starfield.esm` and `BlueprintShips-Starfield.esm`. These files are essential and must be loaded at all times.

#### Game Masters as Required Masters for New Modules

When you create a new module, SF1Edit will automatically add `Starfield.esm` and `BlueprintShips-Starfield.esm` as masters. The "Clean Masters" function will not remove these modules, as they are considered obligatory.

#### Official Game Modules Are Read-Only

Be aware that the official game modules—namely `Starfield.esm`, `OldMars.esm`, `Constellation.esm`, and `BlueprintShips-Starfield.esm`—are read-only. You will not be able to make modifications to these modules.

### The Case for Exclusively Supporting .esm Files in Starfield

The publication of mods in the .esm format is strongly encouraged, a practice that should ideally extend to most previous Bethesda games. However, the widespread use of .esp modules for older titles renders a complete switch impractical for those games. 

For Starfield, we stand at a unique juncture where a unified effort can set the standard that all published mods should be .esm files. That means that SF1Edit will, for the time being, only support the creation and saving of .esm modules. 

#### Technical Justifications:

1. **Loading Sequence and Conflict Resolution**: The game engine necessitates that all `ESM`-flagged modules load before non-`ESM` modules. When mods are released in mixed formats (`ESM` and non-`ESM`), it creates two distinct categories that cannot intermingle. Consequently, this severely limits the ability to resolve conflicts through load order adjustments.

2. **Resource Limitations**: Temporary references like `REFR`, `ACHR`, etc., are treated differently in `ESM` and non-`ESM` modules. In `ESM` modules, these records are loaded into memory only when the player approaches them (within the `uGrid` range), offering a more efficient use of resources. In contrast, non-`ESM` modules load all these temporary references at the start of the program, keeping them in memory throughout the game's runtime. The game engine only has a fixed, finite number of reference handles available for use, regardless of the system on which it is running. Every loaded reference will use one of these handles, hence it is imperative that all modules with temporary references are `ESM` modules, to prevent issues from running out of reference handles.

3. **Consistency and Debugging**: Non-`ESM` mods are always loaded as persistent, which might not reveal certain bugs during testing. If a user later attempts to convert such a mod to `ESM`, unforeseen issues may emerge. Hence, both the development and testing phases for mods with temporary references should occur in the `ESM` environment.

Combining these factors leads to a logical conclusion: all mods, especially those with temporary references, should be released as `.esm` modules. The `.esm` file extension ensures that the game engine sets the `ESM` flag, providing users with the assurance that their entire load order is compatible and can be freely adjusted.

#### SF1Edit's Stance

In line with these considerations, SF1Edit will, for the time being, only support the creation and saving of `.esm` modules.

#### Additional Note

As an added benefit, this approach makes it easier to identify potentially problematic modules that were created and released prior to the availability of appropriate tools, as most of these will likely be in `.esp` format.

## Updated Developer Message

We've updated the Developer Message. Please take a moment to read it.

## View Pinning and Drag'n'Drop from the Navigation Treeview

In the top-left corner of the View tab (left of the filter) is a pin button. Pressing this button locks the View tab, allowing you to scroll through the left-hand Navigation Treeview without updating the View to a different record.

You can then drag and drop records from the Navigation Treeview onto compatible FormID-containing elements inside the View tab. For arrays of FormIDs, you can also drop a record onto the array itself, adding a new element with the dropped record's FormID as its value. Multi-selection of multiple records for simultaneous drag and drop is supported if the target is an array.

## Fallout 76 Support

Support for Fallout 76 has been included primarily for inspecting game data and creating delta patches to track changes in game data with each update. Module-based mods are not supported by Fallout 76. 

To start xEdit in Fallout 76 game mode, use the `-fo76` parameter or rename the exe to `FO76Edit.exe`.

Special thanks to Eckserah for continually updating the Fallout 76 definitions to keep pace with the game's constant changes.

## TES3: Morrowind Support (View-Only Capability)

xEdit 4.1.5 incorporates support for TES3 (Morrowind), with the current functionality limited to viewing game data.

### Initialization

To access this feature, launch xEdit in Morrowind game mode using the `-tes3` and `-view` parameters. Alternatively, rename the executable to `TES3View.exe`.

### Accommodating FormID Differences

Morrowind's file structure diverges significantly from the architectures of later Bethesda games, particularly concerning the absence of FormIDs—a core element in xEdit's design. To bridge this gap, xEdit generates "virtual" FormIDs for all TES3 records, enabling coherent interaction within the xEdit environment.

### Virtual Groups for Easier Display

Unlike later games, the TES3 file format doesn't categorize records into groups. To improve navigability, xEdit artificially creates "virtual" groups, aligning them with the organization expected in modern Bethesda titles.

### Handling CELL Records and References

In TES3, individual references (like `REFR`, `ACHR`, etc.) are embedded within a `CELL` record, contrary to the practice in later games where such references are stored as individual records in a child group of the `CELL`. To facilitate more straightforward viewing, xEdit extracts these embedded references and places them into a "virtual" child group under the `CELL`, each denoted as a distinct `REFR` record.

## Summaries and Collapsible Nodes in the View Tab

### Collapsing and Expanding Nodes

Within the View tab, each node provides a collapsible interface. You can toggle these nodes using the `[+]` or `[-]` symbols located to the left of the node name. Alternatively, keyboard shortcuts `+` or `-` can also be employed for the same purpose. The state of each collapsed or expanded node is remembered on a per-record basis but may be reset when navigating away from the current record.

### Bulk Operations with Ctrl Key

For bulk operations, hold down the `Ctrl` key while toggling a node. This action will collapse or expand all nodes of the same type—useful for handling array elements, for example. This state is temporarily remembered and will be applied when navigating to other records. However, this setting is session-specific and will be lost upon restarting the program.

### Default Settings and User Customization

Certain container elements in the View tab now default to a collapsed state. Users can modify this default behavior by accessing the Options within the View tab, allowing customization on a per-element-type basis.

### Element Summaries

To enhance usability, many types of container elements now feature summaries that display crucial information from the hidden elements when the node is collapsed. The process of defining these summaries is ongoing, and user feedback is highly valuable for identifying additional types of summaries to implement.

### Record-Level Summaries

In addition to container-level summaries, some records also feature overarching summaries. These are particularly useful for records lacking a defined name and are displayed in the left-hand navigation tree under the "Name" column.

### Visual Indicators for Color

Where a summary represents color attributes, a visual sample of the color is rendered within the summary for immediate reference.

## Model Information Decoding

### Understanding MODT Subrecords

The `MODT` subrecords, along with other subrecords sharing the same format, are now fully decoded. These subrecords primarily contain model-related information extracted from the .nif files. While the presence of this information doesn't appear to be critical for the game's operation—meaning that missing or incorrect `MODT` data doesn't seem to cause in-game issues—it is believed to serve optimization and read-ahead purposes.

### Texture File Hashing

Among the multiple data points, these subrecords include path and filename hashes for the texture files utilized in the model. To render these as actual filenames and paths within xEdit, the program constructs an index comprising all files in the loaded archives as well as loose files in the data folder, each matched with its respective hash. This capability, however, is limited to the files and paths that exist on the user's machine.

### Significance for TES5/SSE

Full support for decoding `MODT` is especially crucial for TES5/SSE. These games introduce complexities because they actually employ two different, mutually incompatible, formats of this subrecord based on the form version. In the past, when xEdit displayed this subrecord merely as an undecoded byte array, it enabled users to copy this data between records with different form versions using drag-and-drop actions. This practice led to the risk of causing in-game crashes because the data within a record may not align with the format expected by the game engine based on the form version of that record.

### Automatic Conversion and Error Checks

To mitigate such issues, xEdit now automates the conversion of Model Information when copied between records with differing form versions. This ensures that the subrecord data aligns with the appropriate format dictated by the form version of the receiving record. Furthermore, xEdit's error-checking functionality will identify any instances where a subrecord contains data that is incompatible with its form version.

## Effective Dialog Response (INFO) Order Inside Dialog Topic (DIAL)

### Introduction to Virtual Subrecords: INOM and INOA

The `DIAL` record now features two new, virtual subrecords—`INOM` and `INOA`. It's crucial to understand that these subrecords are not part of the actual file format. They are neither saved by xEdit nor can they be modified by users. 

### Importance of INFO Order

The sequence in which `INFO` records appear under each `DIAL` within the game engine is of paramount importance. This is because the game engine evaluates these `INFO` records in their presented order when selecting the next dialog response. 

### Complexity in Sorting Rules

Determining this order is far from straightforward. The rules governing the sort order of these records are complex and are further complicated when only some records are overridden in individual modules. This sorting depends on multiple factors:
- The initial order of the `INFO` records in the files
- The content of the `PNAM - Previous INFO` subrecord within each `INFO` record
- The load order of modules affecting any of these records

Because it is virtually impossible for humans to manually determine this resulting order, xEdit now automates this process and reconstructs the sort order for you.

### INOM Subrecord

The `INOM` subrecord displays the order of the `INFO` records, considering only the masters (recursive) of the module in which they are contained. This is most likely the order that the mod author would see when editing that module in the official editor, such as TESCS or [GE]CK.

### INOA Subrecord

On the other hand, the `INOA` subrecord shows the order of the `INFO` records when taking into account all currently loaded modules in their load order, up to the current module. Importantly, the content of the `INOA` subrecord in the winning override (i.e., the rightmost column in xEdit) will reflect what the game engine perceives when initiated with the same modules in the same order as they are presently loaded into xEdit.

### Implications for Mod Interactions

With the introduction of `INOM` and `INOA`, mod authors and users can now more easily identify potential issues in the final dialog response order due to interactions between multiple mods.

## Bugfixes

* #826 - FO4 VMADs with complex script properties now parse completely
* #864 - Subgraph data is now correctly created/overridden
* #888 - Plugins with no masters can now resolve references to hardcoded records
* #897 - Fixed Assertion Failure when using Referenced By to jump to INFO
* #904 - Fixed issue where any mod referred to in INOM and INOA would be added to a mod's master list on override
* #908 - Fixed issue where overriding a creature in FO3/FNV mode didn't properly copy NIFZ and KFFZ sections
* #954 - Fixed IMAD unknown flags in 4.1.3h
* #1060 - Fixed issue where changing values in override didn't update record color on the left side
* #1223 - [SF] Adding Entries to a complex AVMD can result in an exception
* #1234 - [FO4] "MGEF \ Magic Effect Data \ DATA - Data \ Assoc. Item" expects wrong reference type.
* #1235 - Overflow converting Cardinal to Integer when using SetLoadOrderFormID on ESL load order ID
* (reported on Discord) - Fixed JvInterpreter, in 64bit, contains a bug that can result in AVs when accessing arrays
* (reported on Discord) - Fixed Copy as Override (with overwriting) shouldn't allow targeting the source
* (reported on Discord) - Fixed Tab order on Element View/Edit Form is wrong
* (reported on Discord) - Fixed QAC not working
* (contributed) - Various improvements and fixes to .nif handling
* (contributed) - [FO4] Enhanced BSMP decoding
* (contributed) - [FO4] Added LVSP (Leveled Spells) support
* (contributed) - [FO3/FNV] Improved decoding of IMGS

## Minor Changes

* #856 - Added the ability to apply xEdit script to selected refs in the Referenced By window
* #1090 - TES4: Add support for ACRE\XLOD
* #1096 - FO4: MO*F are first-person/facebone flags
* (reported on Discord) - Added an optional 4th `aSilent: Boolean` parameter to `AddRequiredElementMasters` script function
* Updated themes to versions that came with Delphi 11.3
* Compiled with Delphi 11.3
* (contributed) - Added option to copy paths and names when right-clicking on an element (under Clipboard)

## Update Skyrim SE - Generate Large References.pas

* Now uses cell coordinates instead of the position of the reference
* Primitives are not added as large refs by default
* Improved speed

# What's new in xEdit 4.0.5?

## Bugfixes

* #1002 - FNAM Scene Flags (Stop on Quest End -> Stop Quest on End)
* #1012 - [FO4] Condition GetIsID does not accept an Enchantment ID
* #1016 - [TES5/SSE] Quests/QNAM in SMQN shouldn't show as benign conflict 
* #1034 - Incorrect encoding for cyrillic symbols for Player Dialog Prompts
* #1036 - QAC reports with multiple dirty checksums produce invalid LOOT masterlist entries
* (reported on Discord) - .strings files may not be saved if there were no changes to the .es? file
* (contributed) - CalculateFaceNormals always failed with assert
* (contributed) - fixed some scripts failing because of case sensitive comparison of element names
* (contributed) - removed duplicated script "Find plugins which could be turned into ESL.pas"

## Minor changes

* (contributed) - SSE: LIGH was missing LNAM -> LENS 
* (contributed) - updated CTDA for latest xOBSE
* (contributed) - updated CTDA for latest xNVSE
* (contributed) - added hotkey actions Ctrl+C, Ctrl+Alt+C, and Del to Referenced By tab

# What's new in xEdit 4.0.4?

## Bugfixes

* #777 - [Skyrim SE/LE] - Unknown Map Marker TNAM value 59
* #788 - For Oblivion Copy as overrides fails for MGEF
* #792 - Flipped indexes in display of blocks and sub-blocks 
* #803 - after cleaning, some new worldspaces from DLCs may not load their temporary records correctly
* #813 - Unknown field in Script Fragments decoded by Creation Kit error log
* #823 - FO3: Anchorage.esm & PointLookout.esm need Mark Modified applied during QAC 
* #848 - Records with hardcoded FormIDs show as new records instead of overrides/injected
* #853 - FNV - cleaning dead money master erases map geometry
* #855 - After cleaning dlcnukaworld.esm, items in Nuka-Town market vanish
* #860 - tooltip always disappears after a second
* #863 - FO4: DefaultObject forms (DFOB) should override via EditorID
* #871 - Updates for Static Collections [FO4] 
* #875 - TES4Edit 4.0.3 not able to copy Magic Effect Records
* #886 - Crash by confirming add of *no* master
* #880 - Minor problem with double clicking during module selection
* #894 - [Skyrim] Several RACE subrecords are not marked as required
* #909 - xEdit should double apostrophes in generated LOOT masterlist entry names
* #912 - TES4Edit crashes when trying to load Nehrim.esm
* #914 - RNAM subrecord of INFO needs to be treated as case sensitive
* #916 - DR displayed incorrectly in Armor and Armor Addons for F3/NV
* #919 - For REFR, Linked Rooms Count needs to be updated whenever the Linked Rooms are changed
* #926 - [FO4] Load order is being ignored
* #946 - GetNewFormID only allows 0 argument when it needs IwbFile as the input
* #949 - [TES4] Oblivion.esm shows as edited when using VQSC mode
* #953 - Time passed wrong for long running scripts
* #959 - Quick Auto Clean should force-enable "Remove OFST Data"
* #964 - SLGM and FLOR refs are completely valid for pack data
* #965 - Game master automatically re-added after clean masters removes it (when no masters left)
* #972 - NPC_ 'Geared Up Weapons' should only show 1 byte
* #973 - GetIsID condition with Hazard argument is reported as an error
* #974 - xNVSE inline variable declarations comes up as error in error checking
* (reported on Discord) - .esl extensions don't always force loading as ESL correctly when the module is not ESL flagged
* (reported on Discord) - [TES4] EDID and ESCE incorrectly report "Expected 4 bytes but found 0" when running "Check for Errors" on MGEF
* (reported on Discord) - EnderalSE mode incorrectly performs exact instead of partial matching when loading .bsa for loaded modules
* (reported on Discord) - Long running operations like filters and scripts can't be aborted
* (reported on Discord) - 64 bit version does not handle extended FormID range in FO4 correctly
* (reported on Discord) - saving a file without changes could discard previously queued saves for that file, resulting in data loss
* (reported on Discord) - loading a masterless file alone can crash xEdit if it contains references to hardcoded records
* (found by developer) - Need to force InternalEdit for AfterSet handlers

## Minor changes

* #827 - Allow SSEEdit to Minimize during processing
* #901 - "Unhide all..." option in column context menu
* #902 - Option to ignore MHDT conflicts when using Very Quick Show Conflicts (use `-IgnoreWorldMHDT` parameter)

## Enderal Special Edition

Initial support for Enderal Special Edition has been added.

xEdit can be renamed to `EnderalSEEdit.exe` or started with `-enderalse` as parameter.

## QuickEdit

By starting xEdit with a `-quickedit:somefile.esp` parameter, only that file (and it's required masters) will be initially selected in the Module Selection Form.

It is possible to list multiple files, e.g. `-quickedit:dawnguard.esm dragonborn.esm`.

This parameter can be combined with `-autoload` (see below).

# What's new in xEdit 4.0.3?

## Bugfixes

* #649 - Right pane filter bug
* #654 - [FO4] Check for Errors: reports error when a region / object list has SCOL entries
* #659 - When comparing records, right-clicking to Expand All produces a contextual menu that hangs the Expand All functionality
* #669 - CELL at 0,0 may be spuriously added to worldspaces during cleaning.
* #670 - [FO4] Damage magic effects mislabeled subrecord
* #674 - Invalid ITMs may be reported in rare cases when form versions differ
* #676 - Ghosted ESPs and Modgroups
* #678 - AccessViolation while generating conflict status in rare cases
* #691 - [FO4/FO76] Copying CELL data into a file can cause landscape collision to be re-enabled when it shouldn't
* #694 - scheduled save from save failure not removed on subsequent successes
* #695 - Typo in Weap>DNAM>Animation Type: Balistic -> Ballistic
* #682 - The path bar covers the forward and back buttons if the window is too small
* #696 - Double Listing of "Decrease Equip Time" in Weapon Mod Effect
* #697 - Cannot apply scripts using Classes, SysUtils, StrUtils or Windows units
* #708 - "Clean masters" function doesn't remove all masters at first use
* #718 - access violation when holding delete
* #720 - wrong order for FNAM and LNAM in MUST
* #721 - The MTNM field in RACE record is written with unnecessary terminating 0 byte
* #729 - LODGen can fail with references that have NULL or unresolvable Base FormIDs
* #732 - New CK leaves Base record listed for deleted REFRs, should not be marked as error
* #733 - changing the form id of an overridden record doesn't update the link between original and override until restart
* #734 - right side window's record overrides don't focus on currently selected mod
* #737 - Ambiguity in Skyrim's QUST definition
* #747 - Ambiguity in Skyrim's PACK definition
* #748 - Changing ANAM in Skyrim's PACK does not update the CNAM prompt
* #750 - form id override's id changes while the original fails in case id number's changed to an existing id
* (reported on Discord) - cleaning Dragonborn.esm can make Boars non-aggressive
* (reported on Discord) - crash in NAVM when triangle edge is flagged as edge link, but the number stored in the edge field can't look up a valid external NAVM via the Edge Links table
* (reported on Discord) - VeryQuickShowConflicts may very rarely not show certain conflicts
* (reported on Discord) - Hardcoded (FormID < 800) records are not handled correctly in modules that don't have the game master as a master
* (reported on Discord) - adding a new module after having performed a "Compare To" puts the new module at the wrong load order
* (reported on Discord) - error when copying nif blocks with skinning
* (reported on Discord) - double click on integer and float elements does not show in-place editor if they are inside a union
* (reported on Discord) - in very rare cases, a change might not result in the file being marked as having unsaved changes
* (reported on Discord) - changing the FormID of a record might not always update the FormID of the "Children of" group for that record
* (reported on Discord) - Module selection misbehaves for modules with missing masters
* (reported on Discord) - [TES5/SSE] BOOKs teaching SPELs should not allow NULL
* (found by developer) - TdfElement.LoadFromResource does not report if the resource can't be found
* (found by developer) - Quick [Auto] Clean allows selecting the game master (which makes no sense)
* (found by developer) - [FO4] incorrect subrecord order in CELL
* (found by developer) - injected records are not showing up in drop down of FormID in-place editor
* (found by developer) - orphaned "Children of" groups can cause Asserts when trying to display them in the nav tree view

## Minor changes

* #637 - [FO4/FO76] TTEB - Unknown in RACE record is "Blend Operation"
* #679 - [FO4/FO76] VISI and PCMB subrecords decoding
* #722 - suffix removal during formid copying
* #731 - [FO4] "Unknown 11" in the "Data-Flags" subrecord of CELL records is "Hidden from Interior Cell List"
* [FO3/FNV] Flag 0 in BOOK means "Scroll"
* [FO3/FNV] make "RuntimeScriptProfiler xSE Extension Log" available
* Report error records in PrepareSave with full path instead of just their name
* Show tooltip hint for View column headers
* Show indices for unsorted SubRecord Arrays
* [TES5/SSE] added ENCH to Knowable Forms
* Allow assigning to deleted records
* Experts can activate an option which enables an extended FormID space (`001`-`FFF` instead of `800`-`FFF`) when compacting for ESL
* Check for Errors now reports invalid ObjectID in light modules and HITMEs

## Shortened Parameters

Some parameters can be specified in a shortened way now:
* `-quickshowconflicts` as `-qsc`
* `-veryquickshowconflicts` as `-vqsc`
* `-autogamelink` as `-agl`
* `-quickclean` as `-qc`
* `-quickautoclean` as `-qac`

## Changes to QuickAutoClean

As a fix for a problem in Dawnguard.esm (see details below in previous version) QAC was marking all records in a to be cleaned file as modified, which made xEdit assemble these records from parsed data instead of just writing out the bytes that were read when the file was loaded.

This resulted in problems when cleaning Dragonborn.esm (and possibly other files).

xEdit is now only marking all records as modified in `Dawnguard.esm`

This behavior can be controlled with 2 parameters:
* `-NoAutoMarkModified` prevents mark modified from being applied to `Dawnguard.esm` (resulting in the Soul Cairn error described below)
* `-ForceMarkModified` always applies mark modified to the cleaned file (if there was anything to clean)

# What's new in xEdit 4.0.2?

## Ko-Fi

A number of users asked for a way to support xEdit development without using Patreon and/or PayPal.

It is now possible to support xEdit development with both one time and monthly donations via Ko-Fi, charged directly to a credit card using stripe.com (or via PayPal) in AU$.

The Ko-Fi Page is linked via the Ko-Fi button in the top right corner of the main form.

## GamerPoets Videos

A new "Videos" button has been added in the top right corner of the main form.

This will open a YouTube playlist with xEdit specific videos by GamerPoets.

## Bugfixes

* #634 - [FO4] Unknown Perk Entrypoint 157
* #636 - Adding a script fragment to a Quest's VMAD record doesn't update the fragmentCount field
* (reported on Discord) - xEdit remembers (unwantedly) if the main form was minimized when it was last closes and restores that state
* (reported on Discord) - When the same file is saved twice within the same second, it results in an error while renaming .save files on shutdown
* (reported on Discord) - [FNV] Unused at the end of BMDT is wrongly defined as variable size (should always be 3 bytes)
* (reported on Discord) - Collapsing of record storage (used when adding/removing/sorting masters) can under certain circumstances result in an assert while trying to save the file later
* (reported on Discord) - "Deep Copy as Override" does not check records in child groups when looking for masters that need to be added to the target
* (reported on Discord) - When using `Insert` key in the View, it is not possible to use Ctrl to flip the "Focus newly added elements in View" option
* (reported on Discord) - [SSE] DATA in WATR is Unused
* (reported on Discord) - Without theme, the icons in the top right corner have a black background (thanks shad0wshayd3 for the fix)
* (found by developer) - Saving `.esm` or `.esl` files without ESM flag for SSE stripped ONAM instead of writing it as required (the game treats files with these extension always as having ESM)
* (found by developer) - `AddMasters()` can be called with names that are not valid module files
* (found by developer) - The navigation treeview unnecessarily checks nodes of them main game masters for changes
* (found by developer) - [TES5/SSE] Words of Power in SHOU should not be alignable
* (found by developer) - [FO3/FNV] Some strings that are translatable are not flagged as such
* (found by developer) - [FO3/FNV] Sort FLST should be disabled by default
* (found by developer) - Duplicate "Children of" GRUPs should report a non-fatal error instead of asserting

## Collapsed Conditions

Collapsed Conditions now display the condition in an easily readable compact 1 line format.

Conditions are now collapsed by default. An option has been added to control this.

## Collapse Arrays with Benign Conflict Priority by Default

A new Option "Collapse Arrays with Benign Conflict Priority by Default" has been added (defaults to true).

When this option is active, Arrays with a Conflict Priority of Benign will be initially collapsed.

## Manual Cleaning functions are deprecated

Manual Cleaning functions ('Apply Filter for Cleaning', 'Undelete and Disable References', and 'Remove "Identical to Master" records' are considered obsolete with the introduction of 'Quick Auto Clean' mode and will now only show a message explaining this.

More information about Quick Auto Clean can be found in this What's New document (in multiple places below, use the search function).

## [Very] Quick Show Conflicts, Quick [Auto] Clean, and Auto Game Link Sub Modes

These sub modes of Edit mode can now be accessed using the name of the exe in addition to use of parameters.

To use these modes, you can rename the as e.g.:

* Very Quick Show Conflicts: `FO3EditVeryQuickShowConflicts.exe` or `TES4EditVQSC.exe`
* Quick Show Conflicts: `SSEEditQuickShowConflicts.exe` or `TES5EditQSC.exe`
* Quick Auto Clean: `FNVEditQuickAutoClean.exe` or `FO4EditQAC.exe`
* Quick Clean: `TES4EditQuickClean.exe` or `SSEEditQC.exe`
* Auto Game Link: `FO4EditAutoGameLink.exe` or `FO4EditAGL.exe`

These sub modes will now show in the Window Caption of the Main Window, to make it easy to see that xEdit has been started in one of these modes.

## Auto Load for Quick [Auto] Clean

The `-autoload` parameter can be used together with `-quickautoclean` or `-quickclean` parameters.

It is then necessary to specify the module that should be cleaned on the command line.

e.g.: `SSEEdit.exe -quickautoclean -autoload update.esm`

## Auto Exit

The new `-autoexit` parameter can be used together with a number of different modes (e.g. Quick [Auto] Clean, LODGen, Script) to have xEdit automatically close after the operation is finished.

## Enderal

Initial support for Enderal has been added.

xEdit can be renamed to `EnderalEdit.exe` or started with `-enderal` as parameter.

A known problem currently is that if Enderal was installed in one location and then later moved to a different location with Steam, Steam does not update the registry with the new installation path and xEdit will be unable to find Enderal's Data path.

## Fallout 76

Definitions have been updated to account for increased form version in 1.0.4 and 1.0.5 patches.

## Sorting of INFO records

Problems with INFO sorting have been fixed and INFO sorting is automatically enabled by default for all games where it applies. (There should normally never be a need to turn it off, and turning it off can result in files being written that will not result in the correct INFO order when read by the game engine or CK.)

Background Info: INFO records resolve their PNAM (previous INFO) reference at the moment they are loaded, for this to work correctly the referenced INFO record must have been loaded before. To achieve this, INFO records need to be sorted according to their PNAM before being written to file.

The Sort INFO option has been split into "Sort INFO" (default to True) and "Fill missing PNAM" (default to False, to preserve the previous behavior were Sort INFO was turned off by default).

The navigation treeview now by default shows the INFO children of DIAL records in the order derived from their PNAM values (the same order that they are also displayed in CK and the order in which they are processed by the game) instead of sorted by FormID. This can be changed using the context menu on the FormID column header of the navigations treeview.

New parameters have been added to control these two options (overriding whatever has been set in the options when used): `-SortINFO`, `-NoSortINFO`, `-FillPNAM`, and `-NoFillPNAM`.

## ONAMUpdate Mode

ONAM is the signature of a subrecord in the file header that's used to list all overridden records in temporary CELL children groups in the file. It is required for ESM flagged files to allow support for loading temporary records on-demand by the game engine. xEdit already automatically correctly writes ONAM for ESM flagged files.

ONAMUpdate mode can be used to have xEdit fully automatically create ONAM subrecords also for all non ESM flagged files. The purpose is to support a new option in SSE Engine Fixes to make the game load all files as if they were masters. Further information about this can be found in SSE Engine Fixes.

There is no reason to use ONAMUpdate mode if you aren't going to use that function in SSE Engine Fixes.

To run xEdit in ONAMUpdate mode, you can either rename it to `SSEONAMUpdate.exe` or start it with the `-ONAMUpdate` parameter.

A new Option "Always save ONAM" has been added (defaults to true). When this Option is active, xEdit will write ONAM when saving not ESM flagged files. (Without the Option, saving a non-ESM flagged file will strip out ONAM.)

When running ONAMUpdate mode, this option will be turned on and is saved in the settings file.

The option can be forced on using the `-AlwaysSaveONAM` parameter.

## .bsa/.ba2 Handling

xEdit specific code for `.bsa`/`.ba2` has been completely replaced with the code from `BSArch`.

This change adds support for TES3 `.bsa` archives as well as support for additional texture formats for FO4 and FO76 texture `.ba2` archives.

It also fixes some issues where certain `.bsa` files (e.g. extra voices when language in Steam has been set to Polish for TES5) could result in an endless loop while starting xEdit.

## Expert Options

Some Options have been moved to a new Experts tab which is only visible if you Know What You Are Doing.

## Shrinking SpeedButtons

On the "UI Settings" tab, a new "Shrink SpeedButtons in the top right corner of the main form" Option has been added. The option is also available in the context menu of the buttons. (Thanks to shad0wshayd3 for improving the implementation.)

Selecting this option will remove the captions from the Help / Videos / NexusMods / GitHub / Discord / Patreon / Ko-Fi / PayPal buttons.

# What's new in xEdit 4.0.1?

## Bugfixes

* #618 - 3.3 and 4.0.0 fail to update records when changing form IDs (breaks auto-renumbering, merging)
* #619 - Assertion failure when running REPLACE MODEL FILE NAME script
* (reported on Discord) - attempted reporting of encoding error might result in endless loop and crash
* (reported on Discord) - back/forward mouse buttons do not work in 64bit
* (reported on Discord) - Legend Form can show up with 0 size under some conditions
* (reported on Discord) - [FNV] TCFU in INFO should be called "Follow Up"
* (reported on Discord) - [TES5/SSE] "PlayerKnows" condition does not accept WOOP parameters
* (reported on Discord) - broken `.bsa`/`.ba2` crashes the loading instead of just giving an error message
* (reported on Discord) - Remove ITM should not apply to injected records
* (reported on Discord) - "Dialog Topic" and "Worldspace" Groups can be very slow to expand
* (reported on Discord) - Script access to TSearchRec is broken in 64bit
* (found by developer) - the View tab is initially visible without a record having been selected in the navigation treeview
* (found by developer) - main records do not correctly cache that they have already searched for a child group
* (found by developer) - if the focused navigation treeview node is moved outside the current visible nodes, it is not scrolled into view automatically
* (found by developer) - certain scripts with `for` loops or `case` statements might fail with `Integer required` error in 64 bit

## PayPal Button

By popular demand, a PayPal button has been added for people that prefer to make a one-off donation instead of pledging on Patreon.

## NexusMods and GitHub buttons

When a new update is available, the caption of the NexusMods and GitHub buttons will now be bold and underlined.

# What's new in xEdit 4.0.0?

## What's New

A "What's New" document has been created and is embedded inside the exe file.

It is automatically shown on program start. By checking the "Don't show until changed" checkbox, it is no longer shown on future starts until the What's New document has changed (because xEdit was updated).

### Table of Contents

The TOC button in the top left corner of the What's New Form (also when docked in the What's New Tab) can be used to show or hide a Table of Contents.

`Double Click` or `Enter` in the TOC will scroll the selected header into view.

Width of the TOC is adjustable with a splitter.

State (visible or not) and width of the TOC is saved and restored when the Form shows again.

### Search

A search edit has been added to the What's New Viewer.

`ALT + S` or `CTRL + F` focus the search edit.

`F3` when the main text is focused keeps searching from the current cursor position.

`Enter` when the search edit is focused keeps searching from the current position if the search text has remained unchanged, or starts for the start if the search text has changed.

### Zoom

A zoom trackbar has been added to the What's New Viewer.

Zoom can be controlled with `CTRL + 0, +, or -`.

## UI Themes

xEdit now supports a number of build in UI Themes. They can be activated either through the "Theme" sub menu in the system menu (icon on the top left corner) of the main window, or via the UI Theme tab in the Options.

The UI Theme tab in the Options provides a preview of the selected theme.

In both the Theme menu and the UI Theme tab, the themes are separated into Light (darker text on lighter background) and Dark (lighter text on darker background) themes.

Themes require desktop composition to be enabled. The option to select themes is hidden if the system requirements are not met.

## Theme awareness for conflict colour

xEdit is now aware of the current colour scheme (be it the standard windows colours or from an explicitly selected Theme) as Light (darker text on lighter background) and Dark (lighter text on darker background) and will automatically use modified (lighter/darker) text and background colours based on the colours specified in the Options for signaling conflict status.

## Legend for conflict colours

At the top right corner of the View tab is now a Legend button which toggles the visibility of a Legend tool window which shows all possible combinations of Conflict This (text colour) and Conflict All (background colour).

While the Legend form is open, when changing the focused cell in the View treeview, the matching cell (Conflict This/Conflict All) in the Legend window is focused.

## High-DPI aware

xEdit is now flagged as High-DPI aware and the UI should generally scale correctly when the scale factor is set to > 100% in the windows settings. A known limitation is that window caption bars and some other elements are not scaling correctly when custom themes are used.

## "Hamburger" Menu

A "Hamburger Menu" button has been added to the top left corner of the main window. This button opens a menu with (currently) the following entries:

* Localization
* GameLink (if present)
* Save
* Options

More menu items that are unnecessarily (= not depending on context) in different context menus may get moved to this menu in the future.

## ESL support

xEdit now fully supports the ESL flag in the file header (as well as the .esl extension which implicitly always sets the ESL flag).

ESL flagged modules will be loaded into a "light" slot and will have their FormIDs mapped into the FExxx space. Exactly like the game engine. This means it is now possible to have up to 253 "full" modules (00 to FD) and 4096 "light" modules (FE000 to FEFFF) loaded at the same time.

The ESL flag does not affect load order (light modules can load before full modules, the first digits of the FormID are NOT a reliable way to determine load order anymore).

xEdit will prevent files from being saved with set ESL flag if they are not compatible (contain new records with an ObjectID, that's the last digits in the FormID, > $FFF) and will warn on loading incorrectly ESL flagged modules.

ESL support can be controlled with two parameters:
`-IgnoreESL` will load all modules into full slots, ignoring the ESL flag and the .esl extension
`-PseudoESL` will load all ESL compatible modules into light slots, even without the ESL flag and the .esl extension. This works even for games that do not have ESL support in the game engine.

## Fallout 76 support

Fallout 76 mode can be enabled by renaming the exe to `FO76Edit.exe` or starting it with `-fo76` as parameter.

All records have working definitions. Reference building is supported and it is possible to fully load SeventySix.esm with fully build references without errors.

Fallout 76 support is generally ready to the point that anyone should be able to use it to look at SeventySix.esm without much of a chance for error messages or crashes.

But significant amount of work remains to further refine the record definitions and identify the many new "Unknown" values that have been added.

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

## Improved language and codepage support

Module files for the supported games store their strings generally ANSI (one byte per character) strings. This requires that the correct codepage (mapping between characters and their byte values) is used. Previous versions of xEdit had very limited support for accessing module files that didn't use the same ANSI codepage as the system ANSI codepage of the local system.

xEdit no longer simply uses the system ANSI codepage, but instead uses specific encodings for certain classes of strings.

These changes allow explicit control of all used codepages, and make xEdit's behavior independent from the ANSI system codepage of the local OS.

### String classes

There are different classes of strings in regards to codepage:

* General strings - These are values like file names, developer comments, internal names that are never visible to the player.
* VMAD properties of type string or array of string - These only exist in Skyrim and later. They are strings stored in the module file, but in a distinctly different way then other strings.
* Localized strings - These are strings stored in external `.strings` files when a module is localized.
* Translatable strings - These are strings stored in the module file that a player of the game might get to see. For Oblivion, Fallout 3, and Fallout New Vegas, these are string fields explicitly marked as such in the xEdit record definitions. For Skyrim and newer, this also includes any localizable string (strings that will be stored in the external `.strings` files when a module is localized) if the module is not actually localized.

General strings now always explicitly use codepage 1252 (ANSI - Latin I). This can be overridden using `-cp-general:<codepage>` where `<codepage>` is either `utf8` or a codepage number. It should normally never be necessary to override this.

VMAD properties are always explicitly stored as UTF8. There is no way to override this. All supported games always expect these strings to be UTF8 and any other codepage would result in errors.

Localized strings are accessed based on the language name that's part of the filename of the `.strings` files.

### Languages

For Skyrim (not SE) and older, the following language names are recognized:

* arabic - 1256
* chinese - UTF8
* czech - 1250
* danish - 1252
* english - 1252
* finnish - 1252
* french - 1252
* german - 1252
* greek - 1253
* hungarian - 1250
* italian - 1252
* japanese - UTF8
* norwegian - 1252
* polish - 1250
* portuguese - 1252
* russian - 1251
* spanish - 1252
* swedish - 1252
* turkish - 1254

For SSE, the following language names are recognized:

* english - 1252

For Fallout 4 and Fallout 76, the following language names are recognized:

* en - 1252

### Defining codepage for language in settings file

It is possible to set the codepage used for a language (new or overriding a default from the list above) by modifying the settings file (shown as "Using settings file:" in the messages log on start).

There is currently no UI support for this, but the settings file can be opened in a text editor and a `[cpoverride]` section can be added or modified like this:

```
[cpoverride]
english=utf8
klingon=6666
```

The specified value must be `utf8` or a valid codepage (which `6666` isn't, that was just an example).

The specified codepage will affect any place where a codepage is derived from language.

### Default language

xEdit used to always default to "English" ("En" for Fallout 4) as language if not explicitly specified on the command line using `-l:<language>`. While it is still possible to use that switch to override the language selection, xEdit will now attempt to get the correct language from the `<game>.ini` file, from the iLanguage key for Oblivion, and the sLanguage key for any later games.

### Localized strings

xEdit will automatically use the correct codepage for localized strings, even when the language is switched at runtime using the localization context menu.

The fallback for localized strings in unknown languages is always UTF8. (SSE, FO4, and FO76 always use UTF8 for anything except english.)

The codepage for these files can be overridden byte creating a text file with the same name as the `.strings` file, but the extension `.cpoverride` instead. e.g. `Skyrim_English.cpoverride`. The file should contain a single line with the desired codepage.

For localized strings, while this language setting affects the initial choice of which `.strings` files are being used for localized modules, this can be changed at runtime using the localization context menu.

### Translatable strings

Translatable string use the same codepage as localized strings, but based on the language defined at program start (either from the `<game>.ini` or explicitly using `-l:<language>`) For games before Skyrim, the same list of language names and codepages as listed above applies. Changing the language through the localization context menu after xEdit has started will *not* change the codepage being used for translatable (but not localized) strings.

The codepage used for translatable strings can be globally overridden (has priority over the language selection) using the `-cp:<codepage>` or `-cp-trans:<codepage>` command line parameter where `<codepage>` is either `utf8` or a codepage number. `-cp` is supported for backward compatibility, `-cp-trans` is preferred.

The codepage can further be overridden on a per module basis by creating a `.cpoverride` file with the same name as the module, like described above for `.strings` files. e.g. `Dragonborn.cpoverride`.

Alternatively, the codepage for translatable strings can now be overridden by placing the text `<cp:xxxx>` somewhere in the description (in the file header) of the module. `xxxx` can be `utf8` or any valid codepage number, e.g. `1252`. codepages with less than 4 digits must use leading 0s, e.g. `<cp:0930>`.

### Log entries

The following entries near the top of the message log provide information about the used language and codepages:
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

When a module has `<cp:XXXX>`specified in its description, it is also recorded in the log:
```
[00:12] Background Loader: [CpOverrideTest.esp] Using encoding (from File Header Description): 65001 (UTF-8)
```

## Load order handling

The load order handling has been rewritten completely from scratch and should now exactly mirror the behavior of the game engine for all supported games.

Specifically, for TES4, FO3, and FNV load order is derived from file modify times.
For TES5/SSE and FO4 from the order in `plugins.txt`.
For TES5 (which does not contain inactive modules in its plugins.txt) the load order for inactive modules is supplemented from `loadorder.txt`.

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

When the background loader is complete, a new ModGroup Selection dialog is shown. This dialog is very similar to the new Modules Selection dialog and has most of its features.

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

If one or more CRCs has been added to a module, then the CRC of the currently loaded module must match one of these CRCs, otherwise the module is treated as if it wasn't present.

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
* Ctrl+C can be used on any listed module to copy its name to the clipboard which can then be pasted into the Name edit.

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

The ModGroup Selection that is then shown allows selecting one or more ModGroups for deletion.

### Updating CRCs

As long as at least one ModGroup exists, an "Update CRC in ModGroups..." function is shown in the context menu of the navigation treeview.

This function first shows a Module Selection with all modules that are part of ModGroups with either no CRC or missing the current CRC.

After that a ModGroup Selection is shown with all ModGroups that are missing the current CRC of one or more of the previously selected modules.

After choosing which ModGroups to update, the missing CRCs will be added to all checked ModGroups.

## Compare Selected

The Compare Selected context menu entry now shows the number of currently selected records as `Compare Selected (x)`.

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

`-AllowDirectSaves` will load all non-official (official = game master, official dlcs, CCs) modules without using memory mapped files
`-AllowDirectSaves:a.esm,b.esl,c.esp` will load only the listed modules without using memory mapped files. The list may include official modules.

## "Show Unsaved Hint" replaces previous "Auto Save" option

When "Show Unsaved Hint" is checked in the Options (on by default) then if there are any unsaved changes older than 10 minutes a balloon hint is being shown under the Hamburger Menu, listing the unsaved files and how long they have been unsaved.

Clicking the hint will show the usual save selection dialog.

Clicking the [X] in the hint or ignoring it for 15 seconds until it disappears on its own will snooze it for 10 minutes.

## Reset Modified flag for elements on Save

A "Reset Modified (Bold) on Save" Option has been added (defaults to true).

With this option active, saving will reset the modified flag for elements (which caused them to show in Bold).

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

Previous versions allowed to freely editing Master Files in the File Header. Because adding or removing MAST sub records directly will not renumber the FormID's stored inside the file, this would lead to behavior that is unexpected (and usually destructive in nature) for people that don't have a deep understanding of the internal workings for module files.

xEdit will now by default prevent any direct changes to Master Files. The correct way to add a master is to use the "Add Masters" function in the context menu of the navigation treeview. The correct way to remove a master is to make sure the file no longer contains any references to the master in question and use the "Clean Masters" function in the context menu.

To allow direct editing of the Master Files again, xEdit must now be started with `-AllowMasterFilesEdit` in addition to `-IKnowWhatImDoing`. Please only use that parameter when really required and when you actually do know what you are doing.

## Improvements to adding, sorting, and cleaning masters

"Add Masters..." now uses the new Module Selection form.

"Sort Masters" has been renamed to "Sort Masters (to match current load order)" to make its function more clear.

"Clean Masters" has been renamed to "Clean Masters (= Remove all unused Masters)" to make its function more clear.

All 3 functions should perform much faster and use much less memory. They will also no longer leave Elements that needed to be internally updated (but which don't have their visual value changed) visually marked as modified.

## Optional "Show File Header Flags"

A new "Show File Header Flags" option has been added.

When this is active, the ESM, ESL, and Localized flags are shown for file nodes in the navigation treeview.

## PlayerRef [PLYR:00000014] as visible record in {game}.exe

PlayerRef (FormID 00000014) is now a visible record in the {game}.exe module (instead of being treated as a special hardcoded value internally).

This makes it possible to track the Referenced By information for this record.

## Hardcoded.dat files updated

The `Hardcoded.dat` files have been updated to include more records and they are now embedded inside the exe.

It is possible to override the data contained in the exe by placing a `{GameName}.Hardcoded.Override.dat` beside the exe.

## Tips updated

The Tips shown at program start have been updated to take into account changes made to xEdit.

The Tips no longer require the external file EditTips.txt and are now embedded in the exe.

## Copy to Clipboard on navigation treeview

Ctrl+C on the navigation treeview will copy the contents of the first column of the selected nodes to the clipboard.
Ctrl+Alt+C will copy the following value of the 3rd column.

## [Very] Quick Show Conflicts

xEdit can be started with the following parameters:

`-quickshowconflicts` - after confirming modules to be loaded, automatically load all valid mod groups and "Apply Filter to show conflicts", where any row with exactly 2 columns is always only considered as override
`-veryquickshowconflicts` - same as above, but automatically loads the modules as specified in plugins.txt without showing the module selection dialog (except if CTRL is held when starting), the filter will never show the game master, and all records with less than 2 overrides are filtered without further checking conflict status

## Quick [Auto] Clean

xEdit can be started with the following parameters:

`-quickclean` - after selecting a single module, the module and required masters are loaded, a filter for cleaning is automatically applied for the selected module only, and "Undelete and Disable References" and "Remove "Identical to Master" records" are executed for the selected module.
`-quickautoclean` - same as above, but the "Filter, UDR, Remove ITM" sequence is repeated 3 times, automatically saving the file after each iteration, and finally "BOSS/LOOT Cleaning Report" is executed.

Quick Clean mode automatically turns off "Simple Records" (to ensure the largest number of possible ITMs are recognized) and sets "I Know What I'm Doing" mode (to prevent the edit warning).

A user reported that after cleaning Dawnguard.esm, parts of the soul cairn worldspace do no longer load in the game. This is an old issue that's already present in 3.2.1 and probably before.

To fix this issue, xEdit is now marking all groups and main records as modified before saving when using Quick [Auto] Clean. This forces these elements to be individually saved, instead of simply writing out the bytes from the original file.

This means that using Quick Clean will now produce a different CRC than using the old manual method (explicitly applying filter and explicitly performing UDR and remove ITM).

## Drag'n'Drop of whole record in view treeview

In the view treeview, it is now possible to copy the contents of the whole record by dragging the header (showing the file name) of one column onto another.

## Mouse shortcut for "Jump To" in the view treeview

`Ctrl + Click` on the view treeview header performs a "Jump To" on that record.

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

## Update check

### GitHub

xEdit will automatically perform a check for a newer version on GitHub

This can be turned of with the "Don't check for GitHub update" option.

If an update is available, a balloon hint will be shown under the GitHub button on start.

### NexusMods

xEdit will automatically perform a check for a newer version on NexusMods

This can be turned of with the "Don't check for NexusMods update" option.

If an update is available, a balloon hint will be shown under the NexusMods button on start.

If xEdit is an even minor version (e.g. 4.0.x, 4.2.x, ...) when it is started for the first time (after this change) then update checking on GitHub is initially disabled (but can be turned on in the Options).

## Patreon reminder balloon hint

A balloon hint is shown to highlight the Patreon button.

If the button is clicked or the hint closed with the [x] then it will not be shown again for a while.

The "I'm a patron or donor" option can be used to disable the hint if you have pledged on Patreon or directly donated on NexusMods to permanently disable the hint.

Please consider supporting xEdit development. Future updates as extensive as this one directly depend on the level of support from the modding community.

## Column width modes

The Column width modes (changeable via context menu on the view treeview) have been overhauled.

All Columns have a minimum width of half the standard width specified in Options.

Available options are now:
* Standard - All columns use the initial standard width specified in Options. Column width can be adjusted and will only reset when moving to a different record
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

Setting it to 0 disables the behavior and does instead make sure the view is updated for every record scrolled through.

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

For arrays, their name (in the title column = first column) will have `(sorted)` or `(aligned)` added if the array is sorted or aligned.

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

After Add (menu) / `Insert` (keyboard) the focus will be placed on the added element. This can be turned off with the option "Focus newly added elements in View" (defaults to true). The meaning of the Option can be inverted by holding `CTRL` while using Add / `Insert`.

After drop the focus will be placed on the dropped element.

## Column sensitive row labels in View treeview

The row labels (the first column) in the View treeview will adjust based on the column which currently has the focus.

This is especially relevant in combination with alignment and elements which type and name depends on the value of some other element.

## Change to source for implicitly copied records during "[Deep] Copy as override/new into..."

When performing a "[Deep] Copy as (override/new record) into..." operation of a record that is not directly contained in a top level group (e.g. a CELL inside a WRLD or a REFR inside a CELL) it is necessary that container records are implicitly copied first.

Previous versions of xEdit used the winning override of these implicitly copied records as source.

From now on, xEdit will instead use the highest override visible to the target file (based on its masters) as a source.

## Merge into master

To support "merge into master" functionality (for replacing the use of version control in CK) two new functions have been implemented:

## "Inject Forms into master..."

"Inject Forms into master..." (available in the context menu of a file node in the navigation treeview) will change the FormID of all New records in the file to instead be injected records (=override records without a master record in the file where they belong according to FormID prefix).

Optionally it's possible to try and preserve the ObjectID (the not load order dependant part of the FormID) during this operation.

This does not actually yet copy the records into the master, but is a necessary first step.

Warning: The function will NOT rename any external files that might contain the FormID in their file names.

## "[Deep] copy as override (with overwriting) into..."

"(with overwriting)" changes the behavior of the normal "[Deep] copy as override into..." function.

Normally, that function will not overwrite an existing record with the same FormID in the target.

If the "(with overwriting)" variant is used, then an existing record in the target will trigger a confirmation dialog to decide if the record should be overwritten. The dialog also gives the choice of "Yes for all" and "No for all".

If the source record is flagged as deleted, then a confirmation dialog is shown to decide if the record should be copied (overwriting the target with a record flagged as deleted) or the existing record in the target should be removed.

After injecting forms into master, by performing a "Deep copy as override (with overwriting) into..." from all top level groups of a module, and selecting one of its masters as the target, then selecting to overwrite all existing records and having the targets of all records flagged as deleted removed, the Version Control based functionality of CK to merge a plugin into master can be emulated.

## "Compact FormIDs for ESL"

This function takes all New records with ObjectID > $FFF and attempts to change them to a free ObjectID <= $FFF. It will fail if there are too many new records in the module.

Warning: The function will NOT rename any external files that might contain the FormID in their file names.

## "Renumber FormIDs from..."

This previously existing function shares its implementation with "Inject Forms into master..." and "Compact FormIDs for ESL".

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

## `-autoload` command line parameter

The `-autoload` parameter will not show the Module Selection dialog and just load all modules that are active according to plugins.txt. It also skips the ModGroup Selection and automatically loads all valid ModGroups.

## GameLink / FO4EditLink

A FO4EditLink plugin for F4SE is now included.

If that plugin is loaded into FO4, and FO4Edit is started as the same time as the game, with the same load order, then it is possible to activate GameLink using the context menu of the "Path" bar at the top of the xEdit window.

Once activated, if a reference is selected in the console in game, xEdit will automatically change the View tab to showing that record.

This function is currently only available for FO4, but might be added to other games in the future.

A `-autogamelink` parameter has been added. It implies `-autoload` and will automatically activate GameLink in Reference mode at the end of the Background Loader.

## General record definition improvements and fixes

A large number of improvements and fixes have been made to the record definitions for all supported games.

In many cases these changes should allow previously unrecognized ITMs to be correctly recognized as such now.

A generic mechanism has been implemented to allow setting of default values in the record definitions, so that they can be automatically set when an element of that type is added. This is especially important for elements where the default of all bytes set to 0 does not result in a valid value.

A generic mechanism has been added to allow "recursive" record definitions. This now allows VMAD Properties of type "Struct" or "Array of Struct" to contain members that are again of type "Struct" or "Array of Struct", up to arbitrary numbers of nesting levels deep.

It is now possible to add (VMAD) Scripts and Properties through the UI (both Adding and drag'n'drop).

Version Control Info is now decoded for all games and shows as `yyyy-mm-dd User: x Index: y` or `None` (if all 0).

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

When a reference (REFR, ACHR, ...) needs to update its containing group (position changed, persistent flag changed, ...) it will now internally use the functions above to find or create the right CELL. This also fixes an existing bug where changing the position of a temporary reference did not move the reference to the correct temporary CELL (only when the record was changed to persistent and back was the cell updated, and then only if the right cell already existed, new cells were not created when necessary).

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

## Bugfixes

A large number of reported bugs have been fixed. (This is list incomplete as many bugs have been fixed before keeping of this list was started.)

* #574 - stick to row doesn't work with alt+navigation
* #576 - Record flags aren't copied correctly when dragged and dropped
* #577 - Data flags aren't copied when dragged and dropped
* #579 - xEdit doesn't interpret string encoding in VMAD properties as UTF-8 even -cp:utf-8 is added
* #583 - Edited scripts not marked as not modified when manually saved
* #584 - deleting things from use template actors (sorted) sometimes moves two entries down instead of 1
* #585 - xEdit doesn't remember which monitor it was last placed on in certain situations
* #586 - keyboard selection in dropdown lists doesn't work
* #587 - modified bold font doesn't fully get removed
* #588 - dropdown in a specific part of omod's properties doesn't work
* #589 - dropdown list's horizontal scrollbar covers up the bottommost entry
* #590 - alt+cursor movement defaults to descriptions column if out of bound
* #594 - "Localize plugin" function is broken
* (reported on discord) - sorting masters can under certain circumstances result in corruption of FormIDs
* (reported on discord) - adding/removing/sorting masters can leave the virtual "Worldspace" elements invalid (does not corrupt actual data)
* (found by developer) - Language selection is not aware of .strings files in .bsa/.ba2 archives
* (found by developer) - UTF8 encoding for localized strings needs a fallback mechanism if strings are not valid UTF8
* (found by developer) - ref building uses more memory than necessary
* (found by developer) - if the module selection form on opening has exactly one entry and it is checked, it shows up as unchecked
* (found by developer) - inconsistencies in the collapsing/expanding types and elements in the view tab (implementation and description below updated)
* #600 - Reporting a null xEdit app version number
* (reported on discord) - changing FormID of a record does not show new FormID until after saving and restarting
* (reported on discord) - [FO4] FNAM in GLOB is wrong
* (reported on discord) - virtual "Worldspace" element on temporary exterior cells can show invalid value after changing FormID of WRLD record
* (reported on discord) - When using Copy as override (with overwriting), "No to All" does not work for records flagged as deleted
* (reported on discord) - After using Copy into (and possible other situations) the View tab may (in rare cases) be blank
* (reported on discord) - Flags do not work in Unions
* (found by developer) - Certain shortcuts work while the loader is still active when they shouldn't
* (found by developer) - Random AV after saving when closing
* (reported on discord) - TOC building does not work on Win7
* (reported on discord) - while in "Fit All" column width mode, it is not possible to manually increase the width of columns
* (reported on discord) - HITMEs (FormID Prefix HIgher Than Master Entries) in GRUP labels can lead to problems
* (reported on discord) - Compare Selected does not initially use the correct Column Width mode
* (reported on discord) - Balloon Hint displays Caption in wrong font/colour when using custom themes
* (reported on discord) - Various issue with xDump when running on a file that is not the game master
* (reported on discord) - some texts are cut off in Options Form when a very wide system font is set
* (reported on discord) - xEdit doesn't always find data path correctly if installed in the game folder
* (found by developer) - Clicking the OK button in the Module Selection Form does not always behave the same as pressing `Enter`
* (found by developer) - wbOffsetDataColsCounter can cause range check for modules with faulty data
* (found by developer) - unsaved time interval is shown wrong in unsaved hint on systems configured for 12h time display
* (found by developer) - deleting the last (= there are no others) modgroup will not deactivate mod groups
* (reported on discord) - Adding, Sorting, and Cleaning Masters can lead to data corruption (Please check all modules where you made changes to masters with 3.3.6!!!)
* (reported on discord) - What's New TOC does not initially show correctly in the What's New tab if the TOC was left open previously and the "Don't show again until changed" checkbox is checked in the What's New Form at program start
* (reported on discord) - SSEEdit does not correctly display Version Control Info 1 for records with FormVersion 44
* (reported on discord) - AV during reference building
* (reported on discord) - manual cleaning of Dawnguard.esm removes 4 more records than using quick clean
* (reported on discord) - holding the cursor down key when moving elements with ctrl+cursor in the view tab can result in errors
* (reported on discord) - saving a file multiple times before closing xEdit leaves `file.save.datetime` files behind in the data folder
* (reported on discord) - the right most column in the view tab is not always resizable
* (found by developer) - Ctrl + Click on View Header does not correctly resize the columns of the View after switching to the clicked on record
* (reported on discord) - Using the mouse wheel to change the script combobox in the Apply Script Form does not load the newly selected script
* (reported on discord) - multi-selecting records in the navigation treeview, and then selecting just one of the previously selected records does not update the view tab
* (reported on discord) - after applying a script, the view tab is not updated without selecting a different record first
* (reported on discord) - saving a .strings file does not remove the modified flag for it
* (reported on discord) - after saving, previous changes to record header flags can still show as modified
* #611 - Filter bugs out when .esps are already expanded
* #612 - Edit Script to detect ESL capable plugins too restrictive
* (reported on discord) - crash from accessing a partially initialized record, caused by a pending paint event being executed if a log message is added during the initialization of the record resulting in a crash
* (reported on discord) - "[Deep] Copy as (Override|New Record)" can under certain circumstances overlook some masters that need to be added to the target file before the copy operation
* #614 - Problems with codepage translation

# What's new in xEdit 3.2.2?

- Updated version of modInfoDump xSE plugins.
- Update of the CTDA functions
- Update condition functions for FO3, FNV, and xSE plugins
- LODGen 2.2.0
- x64 fixes
- Remove unused variable after x64 updates
- Scripting updates
- New scripts
  * Add selected items into container.
  * Find ESP plugins which technically can be made ESL.
- [FO4] GNAM are INFO Group
- define position in case there is no CC list
- CC load order update
  * Sort CC plugins right after last DLC, Other ESL after last ESM
- [TES5/FO4] Updated PERK
- [FO3/FNV] NAVM update
- Ensure a return value in some scripting functions
- fixed terrain water segments for odd origins
- Disable dynamic counter fields update when creating a merged patch. With built-in removal of counter fields if zero, it causes assertions while copying list elements to the merged record. It is also not needed since merging code updates all counters itself when merging is done.
- BSArch v0.5
- New `-share` parameter when packing archives to make binary identical files use the same data in archive. Data hashes are calculated using MD5 from TForge library.

# What's new in xEdit 3.2.1?

- [SSE/FO4] Creation Club support (ESL plugins), forced load order for plugins in `*.ccc` file
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

# What's new in xEdit 3.2?

- [SSE] Skyrim Special Edition support
- [SSE] SSELODGen mode
- [FO4] Fallout 4 support
- improved record definitions and error checking
- various bug fixes and optimizations
- new scripts

# What's new in xEdit 3.1.3?

- [SSE] Skyrim Special Edition support
- [FO4] Fallout 4 support
- utf-8 support for translatable strings with -cp:utf-8 command line parameter
- "Stick to" right click menu in the right view pane
- improved record definitions

# What's new in xEdit 3.1.2?

- improved record definitions and error checking
- [TES5] LODGen support for glowing meshes
- [FO3/FNV] Fixed possible error when reading LOD meshes
- [TES5] TES5LODGen avoids generating trees LOD for duplicate FormID ref numbers, bug in Skyrim causes them to not switch off properly in the game

# What's new in xEdit 3.1.1?

- [FO3/FNV] Added PBEA record
- improved record definitions
- VMAD fix for empty arrays
- xLODGen fix reading BSA archives
- xLODGen improved removing of mesh faces under landscape LOD
- FNVLODGen and FO3LODGen

# What's new in xEdit 3.1.0?

- speed optimizations
- fixed memory leaks
- fixed sorting of INFOs in DIAL
- fixed float values rounding
- advanced ModGroups feature
- drag&drop and "Remove from selected records" support for individual flags
- fonts are changeable in Options
- new scripting functions
- new script auto execution mode with -script:"test.pas" switch or when renamed to (TES4|TES5|FO3|FNV)Script.exe
- xEdit associates itself with `*.tes5pas`, `*.tes4pas`, `*.fo3pas` and `*.fnvpas` extensions
- load Mod Organizer (1, not 2) profile internally using command line parameter `-moprofile:<profilename>`
- faster `-quickshowconflicts` switch processing
- new `-O:` parameter to set the output folder for TES4LODGen generation (much faster), for example `"-O:..\ModOrganizer\mods\Generated DistantLOD"`
- [FO3/FNV] Optional hiding of templated actor fields
- [FNV] Don't undelete refs of TREEs with LOD, bug in the game engine causes a crash
- [TES5] TES5LODGen, in right click menu -> Other -> Generate LOD
- [TES5] Weapon/Armor/Ammunition spreadsheets
- [TES5] BODT/BOD2 and different VMAD version objects are now lined up for conflict resolution
- [TES5] Improved DOBJ handling
- [TES5] Record header flags depend on record type

# What's new in xEdit 3.0.32?

- issue 69: automatic updating of counter fields to reflect the proper amount of elements in containers
- issue 149: FormID indexes in master file header ONAM forms
- issue 162: reference rotation angle normalization (TES4LODGen hanging on several mods)
- hotkeys in plugins selection window (`Enter` - confirm, numpad `+` select all, `-` select none, `*` invert)
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

# What's new in xEdit 3.0.31?

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

# What's new in xEdit 3.0.30?

- Added Prev/NextMember for Record union. Use after adding a new one to select the appropriate.
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

# What's new in xEdit 3.0.29?

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
- avoid firing some cached exception (to ease debugging).

# What's new in xEdit 3.0.28?

- With this version it is important to clean all of your plugins after restoring the original Nexus or Steam workshop files. (Don't ask about this in the forum)
- [TES5] Papyrus (VMAD subrecord) support and other misc record updates including Dragonborn DLC
- [TES5] "Next Object ID" error when copying records
- Text fields in records are case sensitive when matching
- Ability to change references to FormID < 800h
- Changeable conflict colors and default column width in options
- "Simple records" option for concise displaying of LAND, NAVM and NAVI records (excluding references). On by default to speed up xEdit, customizable in options
- Improved scripting functions, new demo scripts

# What's new in xEdit 3.0.27?

- [TES5] Updated dialog subtypes for patch 1.8
- Localize/delocalize utf8 strings. Translation is disabled, highly recommended to use StrEdit or other specialized tools instead
- Search by FormID/EditorID skips hidden elements

# What's new in xEdit 3.0.26?

- [TES5] BODT is unchanged (troubles with Dawnguard.esm)
- [TES5] Fixed bug in RACE with sorted biped object names. If you modified race records with previous versions, drag&drop biped object names from master to restore them.
- Additional internal functions accessible from scripts (new demo scripts)

# What's new in xEdit 3.0.25?

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

# What's new in xEdit 3.0.24?

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

# What's new in xEdit 3.0.23?

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

# What's new in xEdit 3.0.22?

- Skyrim Support.
- New exceptions handler.
- Optional backups in a separate directory.
- Remember position and state of the main window.
- Fixed bug when editing with Shift+DblClick.
- [All] Wrye Bash ghosted plugins (`*.esp.ghost`) in plugin selection window.
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

# What's new in xEdit 3.0.19?

- improved record definitions to handle DeadMoney.esm better

# What's new in xEdit 3.0.16?
- FalloutNV.esm not marked as modified if duplicated groups have been merged
- fixed crash when looking at base effect records
- "unsaved changes" dialog should no longer appear if detail view is in edit mode

# What's new in xEdit 3.0.15?

- double click on a FormID in the message view while holding CTRL jumps to that record
- fixed crash when changing perk effect type to Entry Point
- Quest Stage field for Quest + Stage Perk Effect Type now has a drop down with all stages available for the selected quest
- single click on an already selected field now opens the editor again
- fixed in-place editor to properly cover the complete field and have its text align exactly with the text normally displayed
- MasterUpdate and MasterRestore modes are supported (Warning: highly experimental, handle with care)

# What's new in xEdit 2.5.3?

- Fixes assert error when copying certain subrecords.

# What's new in xEdit 2.5.1?

- Bug Fix: floating point comparison is now less "fuzzy". This can result in some floating point numbers now comparing as unequal even though they are within the limit of the accuracy of single (4 byte) floating point values. But it will prevent cases where floats that should be unequal compared as equal.

# What's new in xEdit 2.5.0?

## "Renumber FormIDs from..."

Context menu on file node in navigation treeview -> Renumber FormIDs from...

Renumber FormIDs from will change all FormIDs of records belonging to that file (but not any override records which might be contained in that file) so that they start at the specified value.

This is useful if you have multiple modules that you plan to update in the future, but also want to always provide a merged version (e.g. using FO3Plugin). By assigning non overlapping FormIDs to the different modules, you can make sure that no FormID reassignment of conflicting FormIDs has to take place when merging.

**WARNING:** changing the FormIDs of an existing module will make it savegame incompatible and will break any other module that uses this module as master. If you have any dependant modules, you need to have them all loaded into FO3Edit at the time you change to FormIDs so that they will all be updated accordingly.

Also, this version has been compiled with the "large address aware" flag and will be able to use up to 4GB when running under a 64bit version of Windows.

# What's new in xEdit 2.3.0 EXPERIMENTAL?

- large number of small fixes to record definition, resulting in many more cases of records correctly identified as "identical to master" and a very significant reduction in potential false positives in the "Check for Errors" function.
- on the fly conversion of outdated records to the most current format. This means that you will see fields show up as modified that you didn't modify yourself (mainly in Oblivion.esm, CS created files should already be up to date). It is possible to disable this function by starting FO3Edit with -nofixup as parameter. It is also possible to just these modifications (but still keep the fixups) by starting TES4Edit with -hidefixup as paramter. This function replaces the -fixupPGRD from earlier versions
- New function to copy idle animations
- Bugfix to prevent dialog choices from being sorted by FormID
- The Undelete and Disable function will set the Player ACHR [00000014] as Enable Parent with the "Set Enable State to Opposite of Parent" flag set. Given that the player should never end up being disabled, that should properly remove them from the gameworld, even if they are persistent references and the enabled state has already been stored in the savegame.
- The Undelete and Disable function will also now properly list all affected references, just like the "Remove 'Identical to Master' Record" function does.
- The selection dialog now allows double clicking an entry, this will automatically select that entry, deselect all others and close the dialog as if the OK button had been pressed.

# What's new in xEdit 2.2.3?

- Game Settings (GMST) will now be properly resolved based on EditorID, not FormID.
- A field in the Region record was improperly defined as a Float field.

# What's new in xEdit 2.2.0?

This version contains no major new functionality, but a number of bugfixes. Update is highly recommended.

# What's new in xEdit 1.2?

- Filtering the first time should be noticeable faster
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
- everything I've forgotten about ;)

# What's new in xEdit 1.1?

- Game Settings are handled correctly now
- Function Type and Params in Conditions are decoded completely
- Mod Groups (more about that later)
- Settings (records to skip, mod groups, filter) are loaded/saved into a .tes4viewsettings file with the same path and name as the plugins.txt (or the plugin list passed on the command line)
- Possible range check error when loading a file with errors should be gone

# You Know What You Are Doing

You've read the whole What's New Document. Great! Hopefully this means that you know what you are doing now.

If you start xEdit with a `-IKnowWhatImDoing` parameter, it will now longer show the "Edit Warning" dialog and unhide a few hidden Options and Functions.

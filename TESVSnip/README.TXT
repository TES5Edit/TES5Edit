figments's TESsnip Fork (Skyrim Edition)
=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-

TESVSnip is a fork of the TESsnip utility bundled with Fallout Mod Manager with changes specifically for Skyrim.

In the word of the original author, TESsnip is a low level plugin editor that allows you to open esm/esp files, view the record structure and cut/copy/paste records and subrecords between different parents, including different esp's. You can also view and edit the data saved in a subrecord, in either hex or string format, as well as editing record headers.

Requirements:
  .NET 3.5

Change Log:
v 4.3
- Elements with options or flags now work for the types short and byte also (was only working for int before), both signed and unsigned.
- New string type called Istring that has an int that defines the string length. Used for MODS, MO2S, MO3S subrecords.
- The data in the TES4 record for new plugins are more sane.
- Create new GRUP (GroupRecord). (Had to fix some bugs in the GroudEditor also. Looks like it hasen't seen much use)
- Creating or pasting a record/s while having a record selected, it will be pasted on the same level as that record. (In that Group or Plugin)
- Added "Paste" to the context menu in the tree view.
- Added "Delete" to the toolbar in the tree view.
- Make "Reports" of multi selected records in the tree view.
- Make "Reports" of multi selected record in the search view.
- Fixed alot of strange tab orders in different dialogs.
- Fixed HeaderEditor so it stores the field you are standing on when you save the changes by pressing enter. (Since you didn't leave the textbox the validation that moved the data to the local variable hadn't accoured yet).
- Fixed both HeaderEditor and GroupEditor so you get a chance to correct any wrong info you have when pressing save, instead of the window just closes after the error message.
- Save Plugin Dialog is prefilled with the selected plugins filename. (No more saving the wrong plugin to the last saved plugins name).
- Saved strings files now end up in the correct place and have the right name again.
- Corrected the spell "Make ESM".
- Enable compression state in the CompressioSettings window is now saved. (Compression is not binary identical to Construction Kit, but both the Construction Kit and the Game can read it just fine)
- HexEdit window is scrollable verticaly.
- Delete subrecord now deletes all selected subrecords, not just the first one as before.
- Update the record count in the TES4 record on save.
- Backup old plugin files before overwriting them.
- Use and increment the Next ObjectID in the TES4 record as the FormID for new records.
- New spell that gives selected record new FormID and updates all references to it. The new FormID is taken from the Next Object field in the TES4 record.
- Moving the last subrecord up no longer unselects it.
- Merged in leihao UTF-8 changes.

Things I want to implement but don't know if I'm capable of.

- GroupElement for repeating elements inside a Subrecord. Usable for WMAD, MODT, MODS and a bunch of other subrecords.
- Conditions on Element level.
- Leveled List Merger

Change Log:
v 4.2
- Fix null pointer exception when editing a records with no subrecords
- Various recordstructure.xml updates
- Fix issue with duplicates in navigation history

v 4.1
- Fixed issues with MGEF (signed vs unsigned values)
- Added Copy & "Copy To" to search window
- Renamed Tools menu to Strings
- Edit Reorder Subrecords to work on multiple select or group or plugin
- Added several menu commands for manipulating strings
  - Explicitly save string table files seperate from plugin save
  - Export string table to Xml file
  - Import string table from Xml file
  - Import strings from master string tables
  - Internalize strings
  - Prune unused strings from table
  - Move Internalized strings to string table

v 4.0
- Introduce "Batch Edit" on Search Window
- Introduce "Column Selector" when using Basic Search or Search with "Type"
- Add Favorite Searches to Basic Search dialog
- Add Find References to Tree Context menu and Ctrl+LeftMouse on report links
- Fixes to RecordStructure.xml from thirdparties

v 3.9
- Introduce "Basic Search" to the find dialog drop down
- Add basic ability to select elements to search on via Basic Search
- Auto display columns involved in Basic Search

v 3.8
- Fix subrecord parent reference when using Full Record Editor to avoid issues with report
- Map Numpad-*,/,+,- to ExpandAll, CollapseAll, ExpandSelection, CollapseSelection
- Map Ctrl+Numpad-*,/ to ExpandAllSelection, CollapseAllSelection
- Fix hyperlinks so that multimaster esp/esm links resolve correctly

v 3.7
- Change default answer for deleting items to Yes.
- Change main view ordering to fix status bar being above incremental find
- Alter "Copy To" to include parent groups when copying loose records like ACHR
- Add "Report..." to tree context menu for opening standalone report for selected record

v 3.6
- Fix quick links in "Add Master..."
- Ask when closing plugin if user is sure
- Add F6 keyboard hooks for switching between windows

v 3.5
- New docking windows manager with better usability.  (Still some bugs in it)
- Fixed most performance issues with search (also capped at 1000 results via config)
- Swapped Ctrl+F and Ctrl+Shift+F so Ctrl+F opens search panel and Ctrl+Shift+F is incremental

v 3.4
- Add search results form (experimental - i.e. may have poor performance)
- force refresh of subrecord list when record selection is changed

v 3.3
- Miscellaneous fixes where subrecord parentage was lost when copy/paste of record. Fixes EDID refresh issues.
- Fix refresh of main text panel when subrecord changed
- Change location where docking windows are hooked to allow floating positions to be loaded on startup
- Remove global menu hook for Delete key and handle on a control by control basis

v 3.2
- Handle resize due to DPI scaling before main view is fully so constructed

v 3.1
- Extra error handling to try and track down errors
- Handle issue with use of Flag Dropdown combobox while control is still being initialized
- Fix with multiselect delete from key binding
- Allow Down key to open Flags Dropdown combo

v 3.0
- Major rewrite to use new TreeList control for Record List
- Include Sort and Drag/Drop on single TreeList to allow reordering
- Restructure tree controls to support multiple select operations
- Manually sort form id list rather than using native sort which lead to inconsistencies
- Remove check for VK_BACK during WM_CHAR as it is incorrect an interfers with VK_OEM_DOT
- Add modeless record Editor on context menu to allow side by side edits (experimental)

v 2.6
- Fix issue with the new FormID Editor not saving values
- Fix issue with the new Repeating Element Editor not saving values
- Fix issue with the Paste Node feature with Groups causing nodes to not be created as expected
- Fix issue with all filter on formid not showing all
- Sort records on formid editor
- Add Record Compression option. Disabled by default.

v 2.5
- Bug fix to avoid using shared memory when editing leading to incorrect values being saved

v 2.4
- Bug fix to so that repeating elements such as KWDA can be added in new control
- Add config only option to allow old subrecord editor to be used

v 2.3
- Use RTF5 control if installed
  Greatly improves text rendering when links are involved and has better layout as well
- Docking windows for Record and Subrecord (not much new but can undock and relocate)
- Reformated the main display text for subrecords to use tables
- New Medium Level Record (looks like old but overhauled for future extensibility)

v 2.2
- Add toggle all button to the ESM load filter dialog
- Add expand/collapse options to tree context and edit menus
- Add option to Add Master to plugins from Edit menu or context when plugin selected
- Bug fixes for errors preventing subrecord from loading

v 2.1
- Fix bug where hex editor was not saving changes

v 2.0
- Change REFR display so X,Y are divided by 4096 to match cell locations
- Add "Form ID Ref" search type which is a backreference search for records using given formid
- Fix Conditionals on global variables display
- Fix progress bar update / cancel during search

v 1.10
- New language handling items to better support localization (Experimental)
- Better handling for Windows Copy/Paste mode
- New Icon - Scissors snipping at Skyrim is what its supposed to be

v 1.9
- Add Setting for MaxHistoryItems in config file and default to 30
- Fix History control so that redo is truncated when a new selection is made
- Add Disable Hyperlinks since some pages are very slow to load due to hyperlink processing
- Fix subrecord copy/paste so Ctrl+C and Ctrl+V work again
- Workaround issue with richtext box causing sound to be made when setting text
- Fix bug with search backward not actually searching backward
- Hacked workaround so that Del key mostly works on the find text field and is not handled by main menu

v 1.8
- Fix QUST after change to CONDITIONAL broke it

v 1.7
- Convert Text Search to a background incremental search
  (Enables cancel during full text searches)
- Add Name w/Type and Full w/Type to allow for searches limited by record type
- Experimental short descriptions for REFR, ACHR showing location information
- Fix FirstTimeLoad of skyrim.esm where user selects cancel to options and filter is still applied
- Change main text field area to RichTextBox and add hyper links to items
- Add Forward/Back navigation buttons for the Record TreeNode


v 1.6
- Add option to use Windows Clipboard instead of internal copy
  (This is experimental and may have issues especially when copying large chunks of data)

v 1.5
- Change copy/paste semantics so appended items are not reversed

v 1.4
- Add setting to allow specification of file open or file save locations
- Add Context menu on tree to allow copy to other plugins
- Update the Sanitize Order Spell
- Substructure matching probably slower but more flexible
- Added NAVI, CELL, REFR, WRLD, LAND, PHZD, PGRE, ACHR and SCEN
- Fixed form look ups for plugins

v 1.3
- Bug fixes for crashes and other misbehaviors
- Fixed positioning for first time loading
- Synchronized RecordStructure.XML with UESP wiki
- Fixed nonconforming record search

v 1.2
- Bug fix in handling lstring which prevent sub editor from opening
- Support multiple subrecord copy/paste (only from the subrecord toolbar)
- Change IDs for GMST and EFID

v 1.1
- Major update to RecordStructure to allow inline groups
- Programatically tried to discover layout of all records so we have a better first pass
- Improved usability on the subrecords by adding toolbar
- Improved incremental search and nonconforming record search
- Improved performance when doing a lot of activities like search or generation of detailed reports
- Added Ability to exclude certain record types on load of skyrim.esm to conserve memory
- Added Str4 data type for fixed 4-byte strings

v 1.0
- Add LString data type to represent localized string
- Import the strings directory if present
- Export strings to the Strings directory if strings are present for a plugin
- Add a simple string viewer for localized strings (hard coded to English)
- Update the LString data type for thinks like FULL subrecords

Notes:
- The check box on the LString record editor is for controlling whether to
  store the integer ID (which is in Hex) or to store the actual text.
- When checked it stores the actual text.  When not checked it stores the id.

TODO:
- QUST record is mess and may require a new XML format to deal with it properly
- Substructures like MO2T and MO3T have complicated repeating structures not possible to edit currently
- Sorry the new string editor got away from me and is rather
  fiddly and not intuitive but that is in line with TESsnip anyway
- Detect localization or allow selection of localization in future
- Add/update spell to convert from ESP to ESM which also fixes LString types

Credits:
* timeslip - The original author of TESsnip
* Dave Humphrey - Maintainer of http://www.uesp.net/wiki a source ESM layout
                - Tes5Lib (http://github.com/uesp/tes5lib)
* Ails - Icons - http://ails.deviantart.com/art/420-Pixel-Art-Icons-for-RPG-129892453
* Crystal Project - Icons released under LGPL

License:
* The TESsnip code is licensed under GPL so this is by extension also GPL
* Included third party components are covered by their own license

Source:
git://github.com/figment/tesvsnip.git
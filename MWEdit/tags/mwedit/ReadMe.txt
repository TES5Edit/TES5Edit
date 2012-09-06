																				.
								MWEdit v0.10 ReadMe
								   February 2003
 						 Dave Humphrey - uesp@sympatico.ca


This is the first, initial release of MWEdit, a hopefully improved ESM/ESP editor
for The Elder Scrolls : Morrowind plugins.  Note that this current version has
many unfinished/unimplemented features and has not been thoroughly tested.  Please
use caution when editting plugins by using backup copies.  It is primarily being
released for testing and user feedback.

I initially started MWEdit as I was editting some dialogue and silently complaining
to myself on how awkward it was. Responses couldn't be moved up/down meaning I had
to completey delete and reenter data. Changing the NPC filter was terribly slow
and I couldn't copy responses/topics. So, from there I decided to go ahead and
see what I could come up with.

MWEdit is an unofficial Morrowind utility and is not related in any way to 
Bethesda Softworks.


   INSTALLATION
=================================================
Simply unzip/copy the MWEdit files into a directory of your choice and run.  MWEdit
will use the registry to find your current Morrowind directory.  If you don't have 
Morrowind installed the program will have problems finding the resource files of 
the game (textures, models, icons, etc...).


   MAJOR FEATURES
=================================================
   - Each object can have only one edit window open at a time. TESCK will open many
     windows for the same object will can lead to confusion on which one you want to
	 save.
   - The tab control has been switched to a list and all record types have been added
     to it. This presents a more consistent, and hopefully easier, editing layout.
   - The windows for editting the records have a (mostly) consistent design (Persist/
     Blocked checkboxes, Save/Cancel buttons in the same place, etc...).
   - More gracefully handling of errors (missing IDs, files, etc...) rather than simply
     terminating (current version simply ignores most errors like this).
   - Easier editting of item counts in Containers and Levelled Lists (use +/- to modify
     the count as well as the regular edit).
   - Clean/delete records from the active file easily.
   - Color coding of active and deleted records in all lists.
   - Sort records by modified/deleted status in all lists.
   - Edit records by double-clicking in all lists (NPC inventory, containers, levelled
     lists, etc...).  
   - Color coding of script code.
   - Toggle viewing of only modified items.
   - When an object ID changes you have the option to Rename, Copy, or Cancel.
   - Copy/rename most record types, including dialogue topics.
   - Change position of dialogue responses Up/Down in the list.
   - Copy dialogue responses.
   - Incremental backup plugin on save (PLUGIN.ESP.001, PLUGIN.ESP.002, etc...). For 
     large plugins you might want to periodically delete some of these files to restore
	 disk space.
   - Standard 'Save As' file menu added.
   - Loads are now slightly faster, and sometimes much faster, than the TESCS.
   - All master files are only loaded once per session which means much faster load
     times after the first time (currently you must exit the application to clear the
	 master data if required). For example, you load Morrowind.Esm with plugin #1, edit,
	 save, and close the plugin. When you next load Morrowind.Esm with plugin #2 you now
	 only need to load the plugin, reducing the load time from 30+ seconds down to only
	 a few seconds.


   FEATURES MISSING or NOT IMPLEMENTED YET
=================================================
   - Script compile (half-done, can compile parse but not output script data).
   - Just ignores blocked records currently.
   - Does not initialize records on startups (no reference count checks, no checks for
     missing or invalid record IDs).  
   - Does not force the loading of a plugin masters.  This will result in many
     missing IDs and if you edit/save records things may get messed up...not a good idea.
   - Loads deleted records from plugins rather than ignoring them.
   - Cannot edit the plugin description/author. 
   - No creature edit dialog.
   - No cell reference records dialog (blame MS for this, I had it done at one time).
   - No 3D view (hard to do, but possible).
   - Icon view not 100% (spell effect particle textures do not display).
   - No options dialog (current options just set to default).
   - Auto-calculated spell/enchant/alchemy costs not always correct (close). Also, the
     relationship between the computed spell cost and any globals/game settings is unknown.
   - The rules for an object ID are probably much stricter than what the TESCK allows.
   - No region paint.
   - Does not delete previous record on rename (TESCK does this for some record types).
   - Help file has not been touched.
   - File path messed up on save (default implementation won't accept change to default
     'Data Files' directory).
   - Some lists update slowly (NPC dialogue for instance).
   - Determines Master status solely from the ESM extension (TESCK looks at the plugin
     header and MAST records I believe).


   TESTS PERFORMED
=================================================
   - Basic tests of all edit dialogs to ensure things display are saved as they should.
   - Loading and saving of Morrowind.ESM and Tribunal.ESM with MWEdit and loading the
     new file up in the TESCK succesfully. 


   TODO/WISH/IDEA LIST
=================================================
Ideas and comments welcome...

   - Toggle display of deleted items or not.
   - Edit icons/textures with custom editor (i.e., double-clicking an icon opens PhotoShop
     or another user defined application).
   - User selectable colors for the script text (just have to make a dialog for this).
   - User options stored in registry/INI file.
   - Instead of a list for displaying the item types, have a tree view. One node with 
     alphabetical list, one with a category list,  etc... Or have a combo-list at the top
	 of the listbox that changes the listbox contents in the same manner.
   - Records are currently stored in a plain, unsorted array.  Change this to a sorted 
     array by ID and implement a binary search for record ID lookup which should greatly
	 improve the speed (slow in some circumstances with the 50000+ records typically loaded,
	 such as the cell references).
   - Make it harder to change object IDs. Perhaps a 'lock' option that prevents you from
     changing any IDs unless specifically told to.
   - Better undo system. Just copy records/sub-records on add/edit/delete and add to a pointer
     array (all mechanisms already implemented).
   - Copy/cut/paste records/sub-records. Half-implemented in the list drag/drop routines.
   - Random record generation for specific types (NPCs, containers, cells, etc...). Allow user
     definable input via file/DLLs/COM interface for random generation (lots could be done here).
   - Tooltips/function/parameter help in the script window.
   - A 'Lock' mode that would prevent changes to any records not currently in the active file
     or a read-only mode preventing any changes.
   - Edit multiple items. i.e., selecting 5 armor records and changing their weight would 
     set the weight for all 5 records.
   - Display memory usage.
   - Display history for records (which currently loaded plugins contain the record).
   - All game settings are in one list.  Seperated this in the same categories as in the
     TESCK (hard coded I think).
   - 3D view of course.  I have enough of the NIF format hacked to display at least a 
     half-decent wireframe of objects and probably textures as well (animation would be
	 significantly more difficult).
   - Thorough help documentation.
   - Integration of many of the current 3rd party utilities into the application.


   WANT TO HELP
=================================================
If the editor is well received and desired, I would welcome any assistance in continuing
to develop the editor.  There are a number of areas that would be relatively easy for 
extra help with:

   - Help files. As I'm sure most are familiar, the TESCK are quite lacking in areas.
     A complete/thorough documentation, would be a great resource, and not only for
	 the application.  The help file could include many of the excellent tutorials on
	 plugin editting and related Morrowind modding topics.
   - 3D viewer control/window for someone familiar with the DX8/9 SDK. This is a low
     priority for me at least until the bulk of the main features are completed/tested.
   - Creation of random content.  Again, lots of stuff could be done with this.

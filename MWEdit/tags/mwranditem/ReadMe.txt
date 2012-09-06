
 				           MWRandItem v1.51 - May 2003
 						Dave Humphrey, uesp@sympatico.ca

   INTRODUCTION
=======================================
MWRandItem is a simple application that can output random items (armor, weapons,
and clothing) for use in the game of Morrowind. It is a result of some discussion
on the official Morrowind message board about such as utility. 


   INSTALLATION
=======================================
Simply copy the EXE file and the 3 DAT files into a directory of your choice. The 
DAT files contain the item, effect, and unique information as described below.
If you receive an error message about a missing MFC___.DLL, just e-mail me at the
above address or find the file on the net (check Nicrosoft). Most computers already
have this file.


  CREDITS
=======================================

  Jaga Telesin - jaga-telesin@earthlink.net
		Has done a lot of testing and has made some good suggestions on improving
		the program. Also modified the BaseItems.Dat file for improved item names,
		qualities, and values.



  DAT FILES
=======================================
There are 3 DAT files (BaseItems, Effects, and Uniques) that are required since they
contain all the item and effect information for creating the random items. The files
are all text files so that new items or effects can be easily added or changed. Each
file contains a brief format description at the top of the file.

Note that the effect and unique data files are not complete. I only added a base set of
effects and unique items to give you a head start. There are many, many more effects
in particular that could be added (only simple damage and attribute effects are
included, which leaves about 100 or more effects unused).

If you do add more interesting effects, e-mail me the DAT files so I can use and 
distribute them.


   VERSIONS
=======================================

  v1.0, May 2003
		- First released version
  v1.1, 8 June 2003
		- Corrected duration problem with constant effect items
		- Changed the way cursed effect item levels are used
  v1.2, 12 June 2003
		- Can output script text file for adding items to existing levelled lists in 
		  Tribunal or Bloodmoon.
		- Item names are now properly output when they are exactly 32 bytes long.
		- Fixed a few minor bugs that could rarely result in an invalid effect/item
		  combination (such as armor with Cast When Strikes effects or Ranged weapons
		  with Constant Effect enchantments).
		- Added script text and record output for modifying levelled lists using the
		  AddToLevItem script function.
        - Included the improved BaseItems.Dat file created by Jaga Telesin.
  v1.24, 13 June 2003
		- Minor change to the way scripts are output.
  v1.25, 14 June 2003
		- Scripts are now compiled.
  v1.50, 19 June 2003
		- Added the 'Material' field to the base item records. The material is inserted
		  before the base item name unless the resulting string is >32 bytes in size.
		- If the full item name is >32 bytes, the suffix of the item is dropped.
		- Added the 4-byte short ID which uses 4-byte counter and 28 bytes of prefix.
		- Changed the ID type selection to a combo box.
		- For items with both a suffix and a prefix that are enchantments, the enchantment
		  type is compared (Constant Effect, Cast when Strikes, etc...). The prefix is choosen
		  first and all suffixes that do not match the enchantment type are ignored. If no
		  suffixes are left, the item will just have the prefix. Note: M ake sure that the
		  unique effects all have the same enchantment type as well.
		- The item level is now displayed in the output list view. For regular items, the
		  item level is that of the base item. For any magical items it is the randomly
		  choosen item level.
        - Unique item names can now be used exactly, as a suffix or prefix to the base item
		  name. See the Uniques.Dat for details.
		- The 'uninstall' script uses the "RemoveFromLevItem, list, item, -1" format, with the -1
		  specifying to remove all occurences of the item from the list.
	    - Enabled the Random Bell option. When enabled, the value specifies the approximate
		  median point for item levels. For example, a random bell value of 20 would mean
		  that about half of the items generated would be level 20 or less.
	    - Included an updated BaseItems.Dat file from Jaga again.
  v1.51 - 21 June 2003
		- Corrected another bug causing 33 byte name sub-records.
  v1.60 - 22 June 2003
		- The levelled item lists are now output with the item level sorted. There were problems
	      with using an unsorted levelled list.
		- The item level used in levelled lists was slightly changed. For unenchanted items the
		  item level is that of the base item. For enchanted items the randomly choosen item level
		  is used (same as before). For example, say the randomly choosen item level was 20 and, as
		  a result, a base item with an item level of 10 was selected. If the item had no effects it
		  would be output as a level 10 object, whereas if it had any effects it would be considered a 
		  level 20. This may slightly increase the number of lower level items but shouldn't be
		  particularily noticable.
  v1.65 - 25 June 2003
		- Change the way level lists are handled. Level lists now have a maximum of 9900 entries
		  due to a bug/feature in Morrowind which limits them to 10000 entries or less. Thus, if
		  more than 9900 items are created, more than one base level list will be made. In order
		  to add these to existing lists you can choose to output place-holder lists (PH). Each
		  PH lists contains all the base item lists at level 1. These PH lists are then used in 
		  the scripts using the AddToLevItem function to add them to existing levelled lists. 
		  Multiple PH lists are created (with the same content) and are used to adjust the chance
		  of a new random item appearing in existing lists.
		- The number of PH lists created depends on the number values in the LevelLists.Dat file.
		  Currently the number of PH lists is 5 more than the maximum number in that file.
        - Can now specify the IDs of the install and uninstall scripts.
		- Added the ability to load a base ESP file.
  v1.70 - 3 July 2003
		- Changed the way enchantment charges work. The Charge1/Charge2 parameters in the Effects.Dat
		  specify the total uses of the item.
	    - Added 'Armor' as a synonym for 'AC' in the BaseItems.Dat file.
		- Fixed a bug in the ENCH/LEVI record types which resulted in two NAME sub-records.
		- Added logging ability to record any errors parsing the various input DAT files. Messages
		  are output to MWRandItem.Log in the same directory as the EXE file. Check this file after
		  starting MWRandItem to see if there are any problems with your data files.
	    - Modified the check duplicates option to make it a bit faster. Test data for 10000 item
		  generation run is given below:
								No Check	With Check
				Old Method		11.9 sec	28.9 sec
				New Method1		33.0 sec	14.8 sec
				New Method2		12.1 sec	14.9 sec

		  I opted for the new method2 since it doesn't affect the times when duplicate checking is
		  disabled and halves the time it takes with duplicate checking enabled. Note that with
		  this method if you create 1000 items with duplicate checking off, and then another 2000
		  with it on, the first 1000 items are not included in the check. 
		- Added basic time of creation output in the message status box.
		- Added the ability to save the settings of the program to group (GRP) files. GRP files
		  are just text files much like the other DAT files. You can save group files from the
		  program and/or edit them in any text editor. They store all the creation settings found
		  in the program as well as a list of all ESP base files that you wish to include. 
        - Changed the Load ESP to Merge ESP so more than one file can be included. A note that 
		  the Merge ESP option is relatively 'dumb' in that it will not check for duplicate IDs or
		  any other possible conflicts.


   HOW IT WORKS
=======================================
Those familiar with the Diablo system of random items may find this similar (but not 
exactly the same).


   BASE ITEMS
---------------------------------------
The basic mechanism of the application is relatively simple. It starts with a list 
of unenchanted base items (BaseItems.Dat). Currently these items are all the weapons,
armor, and clothing records extracted from Morrowind.esm (minus the enchanted items,
around 550 base items). Each base item is assigned an item level (1 to 100) which 
indicates it's relative quality. Higher level items will be rarer and only encountered
by high level players.


   SUFFIXES AND PREFIXES
---------------------------------------
Next, is a list of suffixes and prefixes which are various effects which are to be
randomly applied to the base items. Each item can have a suffix, a prefix, or both,
as determined by the following chances:

		Has Suffix = 50%
		Has Prefix = 25%
		Has Both   = 12.5%

The suffix/prefix also has an item level assigned to it so that higher level effects
will be rarer. The included Effects.DAT file contains around 200 predefined
suffixes (120) and prefixes (80).


   ITEM NAME
---------------------------------------
The item name is a combination of the base item, suffix, and prefix:

		[Prefix] [Base Item] of [Suffix]

Note that item names are limited to 32 bytes, meaning that many long names with both a
prefix and a suffix will be truncated. You can prevent this by editting the base items
and effects to have shorter names or edit the random item manually in TESCK.


  ITEM VALUE
---------------------------------------
The item value is randomly calculated taking into effect the item's base price and the
overall level of effects added to it. Depending on the effect parameters (such as the
quality and multipier), you can get some very high item values (such as a Godly Daedric
Dai-Katana of ??? worth over 5 million gold). Edit the effect qualities if desired to
lower the cost of some of the higher level effects.


   UNIQUES
---------------------------------------  
If the item has both a suffix and a prefix, there is a chance it can be a unique item.

		Unique Chance = 25%

A unique item has a set name and a list of up to 6 suffixes and prefixes that will be
applied to the item. Obviously, unique items can be very powerful if so chosen. 
The included Uniques.DAT file contains around ? predefined unique items.


   LEVELLED LIST
---------------------------------------
The random items can be automatically added to a leveled item list if desired so you
can easily use the random items in your plugin. The choosen player level will match
the randomly selected level for that item and effects.

With only the predefined items, effects, and uniques, this results in a possible 
5 million random items, ignoring that each effect and unique have a range of possible 
values. Adding more effects would increase this even further, if you need more variety.


   RECORD IDS
---------------------------------------
For every item, enchantment, or list created, a unique ID must be created. There are two
options for the creation of record IDs.

The long ID has the format:

		[Prefix][Counter][CurrentTime][SerialNumber]

		[Prefix] = 0 to 8 bytes
			Optional prefix string you can use to identify your items easily.
		[Counter] = 8 byte hexadecimal number
			A counter which is incremented each item a new record is created during
			the current session.
		[CurrentTime] = 8 byte hexadecimal number
			The current time in seconds.
		[SerialNumber] = 8 byte hexadecimal number
			This is either the serial number of drive C: or the number of clock ticks
			if the serial number is not available.

The long format should pretty much be guarunteed to be unique, even if you don't specify
any prefix. It is recommended, however, that you use some prefix to indicate the mod author
and the mod itself.

The short ID has the format:

		[Prefix][Counter]

		[Prefix] = 0 to 24 bytes
			Optional user prefix string.
		[Counter] = 8 byte hexadecimal number
			Same as above, a counter for the number of records created in the current session,

This format allows you to select a long prefix string if required.


   INTERFACE DESCRIPTION
=======================================
The application's interface is relatively simple and allows you to set some basic options
for the random item creation and view the output.

	File->New
		Clear all the current items without saving. You will be prompted.
	File->Save
		Save the current items, enchantments, and lists to an ESP file. 
	File->Exit
		Exit the application.

	Output Tab View
		This tab displays all the current randomly created records along with their basic
		parameters. You can sort the list by clicking the column headers.
	Create Tab View
		The tab displays the random item creation options and the button to start the 
		random creation process.

	Item Options...Number
		Choose the number of random items to output. Note that if you have the remove
		duplicates option check you might not actually create the exact number given.
	Item Options...Level
		Choose the level range of items to create. Use this if you want to create a 
		bunch of particularily high, mid, or low level items. 
	Item Options...Weapon, Armor, Clothing
		Select the item of items to randomly create.
	Item Options...Bell Random
		When selected, this option affects the distribution of generated item levels. For
		example, a bell random value of 20 means that about half of the items would be 
		level 20 or less. Similarily a value of 80 means that half the items would be
		level 80 or less.		
	% Chance...Prefix
	% Chance...Suffix
	% Chance...Unique
		Set the various parameters affecting the chance an item will have an effect. See
		the section above for a more detailed description on how the chances are used. In
		general, however, lower %'s will result in fewer effects.
	Misc Options...ID Prefix
		The 8 byte or 24 byte optional ID prefix string depending on whether long or short
		IDs are used.
	Misc Options...ID Type
		The type of item IDs to generate.
			Long    - All item IDs are composed of a 8-byte prefix and a 24 byte random series.
						ex: dh_item_0000000153AC1981AC561AF8
			Short-8 - All item IDs are composed of a 24-byte prefix and a 8 byte counter number.
						ex: dh_item_00001AF8
			Short-4 - All item IDs are composed of a 28-byte prefix and a 4 byte counter number.
						ex: dh_item_1AF8
    Misc Options...Output Script File
		Select this option to output a script text file with the file name SCRIPT0000.TXT
		in the same directory as MWRandItem.EXE. The 0000 number is incremented each time the
		file is written. The script file contains an 'AddToLevItem' line for each item
		created during the session.
	Misc Options...Remove Duplicates
		If you create a large number of item, you will tend to generate a number of duplicate
		low level items (ex: 10 Chitin Short Swords).  With this option selected, the item name
		and value are compared against the list of existing records. If an item with the exact
		name and value already exists, the new item is discarded. Note that creating a large
		number of items with Remove Duplicates checked takes slightly longer.
    Create Leveled List
		Select this option to automatically create a leveled item list for all random items 
		created when you press the 'Create' button. This makes it easy to create a bunch of
		random items and simply use that list to populate your dungeon and NPC inventories.	
	Create Leveled List...Use ID
		If this is checked the given ID prefix is used for the list. Otherwise, a random ID 
		is generated as described previously. A 4-byte hexadecimal counter is added to the
		end of the given prefix.
    Create Leveled List...PH Lists
		Select this option to create place holder lists to better control the level list output.
		Each of the PH lists created will contain all the base level lists created (ie: one list
		for each 9900 items created). The text field specifies the PH list prefix which is appended
		to a 4-byte hexadecimal counter number.
	Create Leveled List...Change None
		The chance none value in percent for the leveled list.
    Create Leveled List...Output Script
		Select this option to output a script record containing an 'AddToLevItem' line for each
		item created during the session.
	Create
		Start to create random items using the current settings. For a typical computer, creating
		1000 items should take only a few seconds. You are notified with a message box when the
		creation is complete. Make sure to save your ESP file if desired. 


   FUTURE IDEAS
=======================================
	- No list output check


   PREFIX AND SUFFIX LIST
=======================================
The following is the list and brief description of all the pre-defined effect names
and their values. Note that some of the names have been take from Diablo II.
 
Weapon Damage Prefixes
	Useless (-70 to -50%)
	Bent (-50 to -25%)
	Weak (-25 to -5%)
	Jagged (5 to 25%)
	Deadly (25 to 50%)
	Heavy (50 to 70%)
	Vicious (70 to 90%)
	Brutal (90 to 110%)
	Massive (110 to 125%) 
	Savage  (126 to 160%)
	Ruthless  (160 to 180%)
	Merciless (180 to 200%)
	Decaying (200 to 220%)
	Crystalline (220 to 240%)

Spell Point Suffixes
	the Fool (-50 to -21)
	Dyslexia (-20 to -1)
	Magic (1 to 20)
	the Mind (21 to 40)
	Brilliance (41 to 80)
	Sorcery (81 to 120)
	Wizardry (121 to 200)

Agility Suffixes
	Paralysis (-10 to -6)
	Atrophy (-5 to -1)
	Agility (1 to 5)
	Skill (6 to 10)
	Accuracy (11 to 15)
	Precision (16 to 20)
	Perfection (21 to 30)

Strength Suffixes
	Frailty (-10 to -6)
	Weakness (-5 to -1)
	Strength (1 to 5)
	Might (6 to 10)
	Power (11 to 15)
	Giants (16 to 20)
	Titans (21 to 30)

Speed Suffixes
	Hinderance (-10 to -6)
	Delay (-5 to -1)
	Speed (1 to 5)
	Fleetness (6 to 10)
	Quickness (11 to 15)
	Switfness (16 to 20)
	Celerity (21 to 30)

Endurance Suffixes
	Illness (-10 to -6)
	Disease (-5 to -1)
	Endurance (1 to 5)
	Zest (6 to 10)
	Vim (11 to 15)
	Vigor (16 to 20)
	Life (21 to 30)

Luck Suffixes
	Mifortune (-10 to -6)
	Bad Luck (-5 to -1)
	Luck (1 to 5)
	Fortune (6 to 10)
	Blessing (11 to 15)
	Fate (16 to 20)
	Serendipity (21 to 30)

Intelligence Suffixes
	Stupidity (-10 to -6)
	Ignorance (-5 to -1)
	Intelligence (1 to 5)
	Understanding (6 to 10)
	Perception (11 to 15)
	Discernment (16 to 20)
	Aptitude (21 to 30)

Willpower Suffixes
	Foolishness (-10 to -6)
	Folly (-5 to -1)
	Willpower (1 to 5)
	Resolve (6 to 10)
	Resolution (11 to 15)
	Drive (16 to 20)
	Discipline (21 to 30)

Personality Suffixes
    Repulsion (-10 to -6)
	Revolt (-5 to -1)
	Personality (1 to 5)
	Disposition (6 to 10)
	Charm (11 to 15)
	Character (16 to 20)
	Charisma (21 to 30)

Hit Point Suffixes
	the Vulture (-50 to -21)
	the Jackal (-21 to -1)
	the Fox (5 to 20)
	the Jaguar (21 to 40)
	the Eagle (41 to 60)
	the Wolf (61 to 80)
	the Tiger (81 to 110)
	the Lion (111 to 140)
	the Mammoth (141 to 180)
	the Whale (181 to 250)
	
Fatigue Prefixes
	Hyena's (-50 to -21)
	Frog's (-21 to -1)
	Spider's (5 to 20)
	Raven's (21 to 40)
	Snake's (41 to 60)
	Serpents (61 to 80)
	Drake's (81 to 110)
	Dragon's (111 to 140)
	Wyrm's (141 to 180)
	Hydra's (191 to 250)

Armor Class Prefixes
	Vulnerable (-90 to -50%)
	Rusted (-50 to -10%)
	Fine (10 to 20%)
	Strong (20 to 30%)
	Grand (30 to 40%)
	Valiant (40 to 50%)
	Glorious (50 to 60%)
	Blesses (60 to 70%)
	Saintly (70 tp 80%)
	Awesome (80 tp 90%)
	Holy (90 to 110%)
	Godly (110 to 140%)

Weapon/Armor Condition Suffixes
	Fragility (-90 to -50%)
	Brittleness (-50 to -10%)
	Sturdiness (10 to 25%)
	Craftsmanship (25 to 50%)
	Structure (50 tp 75%)
	Expertise (75 to 125%)
	Mastery (125 to 200%)

Weight Prefixes
	Hefty (150 to 75%)
	Weighty (74 to 10%)
	Light (-10 to -24%)
	Underweight (-25 to -50%)
	Portable (-50 to -75%)
	Featherweight (-76 to -95%)
	Insubstantial (-99%)

Weapon Speed Suffixes
	the Slug (-75 to -41%)
	Slowness (-40 to -10%)
	Fleetness (10 to 25%)
	Haste (26 to 50%)
	Velocity (51 to 80%)
	Acceleration (81 to 149%)
	Ultimate Haste (150 to 200%)
	
Weapon Reach Prefixes
	Stubby (-80 to -41%)
	Short (-40 to -10%)
	Long (10 to 24%)
	Stretched (25 to 50%)
	Extended (50 to 100%)
	Infinite (101 to 150%)

Value Prefixes
	Bargain
	Cheap
	Inexpensive
	Overpriced
	Expensive
	Extravagant
	Exquisite
	Antique

Enchant Points Prefixes
	Unmagical (-80 to -50%)
	Poor (-49 to -10%)
	Magical (10 to 25%)
	Potent (26 to 50%)
	Enchanting (51 to 75%)
	Sorcerous (76 to 150%)
	
Fire Damage Suffixes
	Warmth (1 to 4)
	Burning (1 to 8)
	Fire (2 to 10)
	Magma (3 to 20)
	Explosion (5 to 30)

Cold Damage Suffixes
	Chills (1 to 4)
	Frost (1 to 8)
	Ice (2 to 10)
	Winter (3 to 20)
	Chilled Death (5 to 30)

Shock Damage Suffixes
	Bolting (1 to 4)
	Shocking (1 to 8)
	Electricity (2 to 10)
	Zapping (3 to 20)
	Lightning (5 to 30)

Poison Damage Suffixes
	Bane (1 to 4)
	Poison (1 to 8)
	Toxin (2 to 10)
	Noxious (3 to 20)
	Venom (5 to 30)

Weapon Attack Prefixes
	Sharp (1 to 5)
	Warrior's (5 to 10)
	Soldier's (10 to 20)
	Lord's (20 to 30)
	Knight's (30 to 50)
	Master's (50 to 75)
	Champion's (75 to 100)
	King's (100 to 150)

Restore Health Suffixes
	Health (+1)

Restore Fatigue Suffixes
	Fortitude (+1)
	Stoutness (+2)

Restore Magicka Prefixes
	Sorcerer's (+1)

Chameleon Prefixes
	Disguised (5 to 20%)
	Hidden (21 to 50%)
	Chameleon (51 to 80%)
	Concealed (81 to 99%)

Invisibility Suffixes
	Invisibility (100%)

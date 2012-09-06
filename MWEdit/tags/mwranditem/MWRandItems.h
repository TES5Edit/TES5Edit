/*===========================================================================
 *
 * File:	Mwranditem.H
 * Author:	Dave Humphrey (uesp@m0use.net)
 * Created On:	Friday, May 23, 2003
 *
 * Description
 *
 *=========================================================================*/
#ifndef __MWRANDITEMS_H
#define __MWRANDITEMS_H


/*===========================================================================
 *
 * Begin Required Includes
 *
 *=========================================================================*/
  #include "PtrArray.h"
  #include "GenFile.h"
  #include "utility/NameList.h"
  #include "EsmWeapon.h"
  #include "EsmArmor.h"
  #include "EsmClothing.h"
  #include "mwrandcom.h"
/*===========================================================================
 *		End of Required Includes
 *=========================================================================*/


/*===========================================================================
 *
 * Begin Definitions
 *
 *=========================================================================*/

	/* Maximum string name size */
  #define MWRI_MAX_NAMESIZE 32

	/* Temporary buffer size */
  #define MWRI_MAX_BUFFERSIZE 511

  	/* Item masks */
  #define MWRI_ITEMMASK_WEAPON		1
  #define MWRI_ITEMMASK_ARMOR		2
  #define MWRI_ITEMMASK_CLOTHING	4
  #define MWRI_ITEMMASK_MISC		8
  #define MWRI_ITEMMASK_ALL		0xFFFF

	/* Biped name indices */
  #define MWRI_ITEMBODY_NONE		-1
  #define MWRI_ITEMBODY_HEAD		0
  #define MWRI_ITEMBODY_HAIR		1
  #define MWRI_ITEMBODY_NECK		2
  #define MWRI_ITEMBODY_CHEST		3
  #define MWRI_ITEMBODY_GROIN		4
  #define MWRI_ITEMBODY_SKIRT		5
  #define MWRI_ITEMBODY_RIGHTHAND	6
  #define MWRI_ITEMBODY_LEFTHAND	7
  #define MWRI_ITEMBODY_RIGHTWRIST	8
  #define MWRI_ITEMBODY_LEFTWRIST	9
  #define MWRI_ITEMBODY_SHIELD		10
  #define MWRI_ITEMBODY_RIGHTFOREARM	11
  #define MWRI_ITEMBODY_LEFTFOREARM	12
  #define MWRI_ITEMBODY_RIGHTUPPERARM	13
  #define MWRI_ITEMBODY_LEFTUPPERARM	14
  #define MWRI_ITEMBODY_RIGHTFOOT	15
  #define MWRI_ITEMBODY_LEFTFOOT	16
  #define MWRI_ITEMBODY_RIGHTANKLE	17
  #define MWRI_ITEMBODY_LEFTANKLE	18
  #define MWRI_ITEMBODY_RIGHTKNEE	19
  #define MWRI_ITEMBODY_LEFTKNEE	20
  #define MWRI_ITEMBODY_RIGHTUPPERLEG	21
  #define MWRI_ITEMBODY_LEFTUPPERLEG	22
  #define MWRI_ITEMBODY_RIGHTPAULDRON	23
  #define MWRI_ITEMBODY_LEFTPAULDRON	24
  #define MWRI_ITEMBODY_WEAPON		25
  #define MWRI_ITEMBODY_TAIL		26
  #define MWRI_ITEMBODY_NUMPARTS	27

	/* Effect masks */
  #define MWRI_EFFMASK_NONE	   1
  #define MWRI_EFFMASK_ENCHANT	   2
  #define MWRI_EFFMASK_WEIGHT	   4
  #define MWRI_EFFMASK_DAMAGE	   8
  #define MWRI_EFFMASK_MAXDAMAGE   16
  #define MWRI_EFFMASK_MINDAMAGE   32
  #define MWRI_EFFMASK_REACH	   64
  #define MWRI_EFFMASK_SPEED       128
  #define MWRI_EFFMASK_CONDITION   256
  #define MWRI_EFFMASK_ARMOR       512
  #define MWRI_EFFMASK_ENCHANTPTS  1024
  #define MWRI_EFFMASK_SPELL	   (2048)
  #define MWRI_EFFMASK_ALL         0x7FFFFFFF

	/* Enchantment masks */
  #define MWRI_ENCMASK_NONE	   1
  #define MWRI_ENCMASK_STRIKES	   2
  #define MWRI_ENCMASK_CONSTANT    4
  #define MWRI_ENCMASK_USED	   8
  #define MWRI_ENCMASK_ONCE	   16
  #define MWRI_ENCMASK_ALL         0x7FFFFFFF

/*===========================================================================
 *		End of Definitions
 *=========================================================================*/


/*===========================================================================
 *
 * Begin Type Definitions
 *
 *=========================================================================*/

	/* Weapon specific data */
  typedef struct {
	long  Condition;
	byte  MinChop;
	byte  MaxChop;
	byte  MinSlash;
	byte  MaxSlash;
	byte  MinThrust;
	byte  MaxThrust;
	float Speed;
	float Reach;
	int   Type;
	bool  IgnoreResist;
   } mwri_weapon_t;

	/* Armor specific data */
  typedef struct {
	long  Condition;
	long  AC;
	int   Type;
   } mwri_armor_t;

   	/* Clothing specific data */
  typedef struct {
	int   Type;
   } mwri_clothing_t;

  typedef struct {
  	TCHAR  Name[MWRI_MAX_NAMESIZE+1];	/* Base item name string */
	TCHAR  Material[MWRI_MAX_NAMESIZE+1];	/* Optional material of the item */
	long   ItemType;			/* Item type value (bitmask) */
	long   BasePrice;			/* Base item price */
	long   EnchantPts;			/* Base enchantment points */
	float  Weight;				/* Base item weight */
	long   EffectMask;			/* Types of valid effects for the item */	
	long   EnchantMask;			/* Types of valid enchantments for the item */

	union {		/* Specific item type data */
		mwri_armor_t	Armor;
		mwri_weapon_t	Weapon;
		mwri_clothing_t Clothing;
	 };

	long   ItemLevel;			/* Base item level (higher level items will be rarer) (0-100) */
	TCHAR  Model[MWRI_MAX_NAMESIZE+1];	/* Model and icon filenames */
	TCHAR  Icon[MWRI_MAX_NAMESIZE+1];

				/* Male/female parts for clothing/armor */
	TCHAR MaleParts[MWRI_ITEMBODY_NUMPARTS][MWRI_MAX_NAMESIZE+1];
	TCHAR FemaleParts[MWRI_ITEMBODY_NUMPARTS][MWRI_MAX_NAMESIZE+1];
   } mwri_item_t;

	/* Pointer array of items */
  typedef TPtrArray<mwri_item_t> CMwRandItemArray;


/*===========================================================================
 *		End of Type Definitions
 *=========================================================================*/


/*===========================================================================
 *
 * Begin Class CMwRandItems Definition
 *
 * An array of base item records used for random item creation.
 *
 *=========================================================================*/
class CMwRandItems {

  /*---------- Begin Private Class Members ----------------------*/
private:
  CMwRandItemArray	m_ItemArray;	/* Array of item pointers */
  long			m_InputLine;


  /*---------- Begin Protected Class Methods --------------------*/
protected:

	/* Find a body part index */
  int FindBodyPart (const TCHAR* pString);

	/* Read item from text file */
  bool ReadItem (CGenFile& File, mwri_item_t* pNewItem);
  bool ReadItem (CGenFile& File);

	/* Parse an effect/enchant mask value string */
  long ParseEffectMask  (const TCHAR* pValue);
  long ParseEnchantMask (const TCHAR* pValue);

	/* Set item parameters from string values */
  bool SetItemParam      (mwri_item_t* pNewItem, const TCHAR* pVariable, const TCHAR* pValue);
  bool SetArmorParam     (mwri_item_t* pNewItem, const TCHAR* pVariable, const TCHAR* pValue);
  bool SetClothingParam  (mwri_item_t* pNewItem, const TCHAR* pVariable, const TCHAR* pValue);
  bool SetMiscParam      (mwri_item_t* pNewItem, const TCHAR* pVariable, const TCHAR* pValue);
  bool SetWeaponParam    (mwri_item_t* pNewItem, const TCHAR* pVariable, const TCHAR* pValue);
  bool SetMaleBodyPart   (mwri_item_t* pNewItem, const TCHAR* pVariable, const TCHAR* pValue);
  bool SetFemaleBodyPart (mwri_item_t* pNewItem, const TCHAR* pVariable, const TCHAR* pValue);


  /*---------- Begin Public Class Methods -----------------------*/
public:

	/* Class Constructors/Destructors */
  CMwRandItems();
  virtual ~CMwRandItems() { Destroy(); }
  virtual void Destroy (void);

	/* Get class members */
  int		GetNumItems (void)		{ return (m_ItemArray.GetNumElements()); }
  mwri_item_t*  GetItem     (const int Index)	{ return (m_ItemArray.GetAt(Index)); }

	/* Input items from the given filename */
  bool ReadItemFile (const TCHAR* pFilename);


 };
/*===========================================================================
 *		End of Class CMwRandItems Definition
 *=========================================================================*/


/*===========================================================================
 *
 * Begin Function Prototypes
 *
 *=========================================================================*/

	/* Initialize an item structure */
  void DefaultMwRandItem         (mwri_item_t& Item);
  void DefaultMwRandItemArmor    (mwri_item_t& Item);
  void DefaultMwRandItemClothing (mwri_item_t& Item);
  void DefaultMwRandItemMisc     (mwri_item_t& Item);
  void DefaultMwRandItemWeapon   (mwri_item_t& Item);

  	/* Find a body part string */
  const TCHAR* GetMWRandItemBodyPart (const int Index);

	/* String conversion methods */
  long ShortStringToMwRandItemMask (const TCHAR* pString);
  int  StringToMwRandItemMask (const TCHAR* pString);
  const TCHAR* MwRandItemMaskToString (const long ItemMask);
  const TCHAR* MwRandItemMaskToShortString (const long ItemMask);

/*===========================================================================
 *		End of Function Prototypes
 *=========================================================================*/


/*===========================================================================
 *
 * Begin External Variable Definitions
 *
 *=========================================================================*/
  extern valuenames_t l_MwEffectMasks[];
  extern valuenames_t l_MwEnchantMasks[];
/*===========================================================================
 *		End of External Variable Definitions
 *=========================================================================*/



#endif
/*===========================================================================
 *		End of File Mwranditem.H
 *=========================================================================*/


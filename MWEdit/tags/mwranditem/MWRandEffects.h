/*===========================================================================
 *
 * File:	Mwrandeffects.H
 * Author:	Dave Humphrey (uesp@m0use.net)
 * Created On:	Friday, May 23, 2003
 *
 * Defines the CMwRandEffects class for handling an array of prefix and 
 * suffix definitions.
 *
 *=========================================================================*/
#ifndef __MWRANDEFFECTS_H
#define __MWRANDEFFECTS_H


/*===========================================================================
 *
 * Begin Required Includes
 *
 *=========================================================================*/
  #include "PtrArray.h"
  #include "GenFile.h"
  #include "MwRandItems.h"
  #include "EsmEnchant.h"
/*===========================================================================
 *		End of Required Includes
 *=========================================================================*/


/*===========================================================================
 *
 * Begin Definitions
 *
 *=========================================================================*/

	/* Number of effects per prefix/suffic */
  #define MWRE_MAX_EFFECTS 2

	/* Effect types */
  #define MWRE_EFFECT_MIN        0
  #define MWRE_EFFECT_NONE	 0	/* No direct effect */
  #define MWRE_EFFECT_ENCHANT	 1	/* Use enchantment data */
  #define MWRE_EFFECT_WEIGHT	 2	/* Modify the item weight */
  #define MWRE_EFFECT_DAMAGE	 3	/* Modify weapons damage (all) */
  #define MWRE_EFFECT_MAXDAMAGE  4	/* Modify weapon's max damage */
  #define MWRE_EFFECT_MINDAMAGE  5	/* Modify weapon's minimum damage */
  #define MWRE_EFFECT_REACH	 6	/* Modify weapon's reach */
  #define MWRE_EFFECT_SPEED      7	/* Modify weapon's speed */
  #define MWRE_EFFECT_CONDITION  8	/* Modify weapon/armor condition */
  #define MWRE_EFFECT_ARMOR      9	/* Modify armor class by % */
  #define MWRE_EFFECT_ENCHANTPTS 10	/* Modify enchant pts by % */
  #define MWRE_EFFECT_SPELL	 11	/* Usable spell on misc items */
  #define MWRE_EFFECT_MAX        11

/*===========================================================================
 *		End of Definitions
 *=========================================================================*/


/*===========================================================================
 *
 * Begin Type Definitions
 *
 *=========================================================================*/

	/* A single enchantment effect */
  typedef struct { 
  	short EffectID;
	byte  SkillID;
	byte  AttributeID;
	byte  RangeType;
	long  Area1;
	long  Area2;
	long  Duration1;
	long  Duration2;
	long  MagMin1;
	long  MagMin2;
	long  MagMax1;
	long  MagMax2;
   } mwrand_encheff_t;

	/* Effect enchantment data */
  typedef struct {
  	long		 EnchantMask;	
	int		 EnchantType;
	int		 EnchantCost1;
	int		 EnchantCost2;
	int		 Charge1;
	int		 Charge2;
	bool		 AutoCalc;
	mwrand_encheff_t Effects[MWRE_MAX_EFFECTS];
	int		 NumEffects;
   } mwrand_enchant_t;

	/* Stores a single prefix/suffic effect */
  typedef struct {
	long  EffectMask;
	char  Name[MWRI_MAX_NAMESIZE+1];	/* Prefix/suffix unique name string */
	int   ItemLevel;			/* Level of effect (0-100) */
	bool  Cursed;				/* Is the effect considered cursed? */
	long  ItemMask;				/* Bitmask for which item types the effect is valid for */
	int   MinQuality;			/* Quality range (0 to 100,000) */
	int   MaxQuality;
	int   Multiplier;			/* General item value (-10 to 30) */

	int   EffectType;			/* General effect type */
	float MinEffect;			/* Effect parameter ranges */
	float MaxEffect;
	mwrand_enchant_t Enchantment;		/* Effect enchantment if valid */
   } mwrand_effect_t;

	/* Pointer array of effects */
  typedef TPtrArray<mwrand_effect_t> CMwRandEffectArray;

/*===========================================================================
 *		End of Type Definitions
 *=========================================================================*/


/*===========================================================================
 *
 * Begin Class CMwRandEffects Definition
 *
 * Holds an array of prefix and suffix effects used for randomly generating
 * Morrowind items.
 *
 *=========================================================================*/
class CMwRandEffects {

  /*---------- Begin Private Class Members ----------------------*/
private:
  CMwRandEffectArray	m_Prefixes;	/* Array of effects */
  CMwRandEffectArray	m_Suffixes;

  long			m_InputLine;


  /*---------- Begin Protected Class Methods --------------------*/
protected:

	/* Input an effect record from the given file */
  bool ReadEffect	 (CGenFile& File, mwrand_effect_t* pNewEffect);
  bool ReadPrefix	 (CGenFile& File);
  bool ReadSuffix	 (CGenFile& File);
  bool ReadEnchant	 (CGenFile& File, mwrand_effect_t* pNewEffect);
  bool ReadEnchantEffect (CGenFile& File, mwrand_effect_t* pNewEffect);

	/* Set an effect parameter from string values */
  bool SetEffectParam	     (mwrand_effect_t* pNewEffect, const TCHAR* pVariable, const TCHAR* pValue);
  bool SetEnchantParam	     (mwrand_effect_t* pNewEffect, const TCHAR* pVariable, const TCHAR* pValue);
  bool SetEnchantEffectParam (mwrand_effect_t* pNewEffect, const TCHAR* pVariable, const TCHAR* pValue);


  /*---------- Begin Public Class Methods -----------------------*/
public:

	/* Class Constructors/Destructors */
  CMwRandEffects();
  virtual ~CMwRandEffects() { Destroy(); }
  virtual void Destroy (void);
	
	/* Find an effect by name */
  mwrand_effect_t* FindEffect (const TCHAR* pName);

  	/* Get class members */
  int		   GetNumPrefixes (void)		{ return (m_Prefixes.GetNumElements()); }
  mwrand_effect_t* GetPrefix      (const int Index)	{ return (m_Prefixes.GetAt(Index)); }
  int		   GetNumSuffixes (void)		{ return (m_Suffixes.GetNumElements()); }
  mwrand_effect_t* GetSuffix      (const int Index)	{ return (m_Suffixes.GetAt(Index)); }

	/* Input effect data file */
  bool ReadEffectFile (const TCHAR* pFilename);

 };
/*===========================================================================
 *		End of Class CMwRandEffects Definition
 *=========================================================================*/


/*===========================================================================
 *
 * Begin Function Prototypes
 *
 *=========================================================================*/

	/* Initialize an effect or enchantments */
  void DefaultMwRandEffect	(mwrand_effect_t& Effect);
  void DefaultMwRandEnchant	(mwrand_enchant_t& Enchant);
  void DefaultMwRandEnchEffect	(mwrand_encheff_t& EnchEffect);

	/* String conversion methods */
  int  StringToMwRandEffectType (const TCHAR* pString);
  bool StringToMwRandEffectType (int& OutType, const TCHAR* pString);
  long StringToMwItemMask       (const TCHAR* pString);

/*===========================================================================
 *		End of Function Prototypes
 *=========================================================================*/




#endif
/*===========================================================================
 *		End of File Mwrandeffects.H
 *=========================================================================*/


/*===========================================================================
 *
 * File:	Mwranditemgen.H
 * Author:	Dave Humphrey (uesp@m0use.net)
 * Created On:	May 23, 2003
 *
 * Description
 *
 *=========================================================================*/
#ifndef __MWRANDITEMGEN_H
#define __MWRANDITEMGEN_H


/*===========================================================================
 *
 * Begin Required Includes
 *
 *=========================================================================*/
  #include "MWRandItems.h"
  #include "MWRandEffects.h"
  #include "MWRandUniques.h"
  #include "MWRandLList.h"
  #include "MWRandItemGroup.h"
  #include "EsmFile.h"
/*===========================================================================
 *		End of Required Includes
 *=========================================================================*/


/*===========================================================================
 *
 * Begin Definitions
 *
 *=========================================================================*/

	/* Script filename format */
  #define MWRIG_SCRIPTFILE_FORMAT	_T("script%04d.txt")
  #define MWRIG_SCRIPTFILE_WILDCARD	_T("script????.txt")

	/* Size of the script data buffers */
  #define MWRIG_SCRIPTDATA_SIZE 32000

	/* Maximum number of items allowed in a level list */
  #define MWRID_MAXITEMS_LEVELLIST 9900

	/* Number of extra PH lists to create */
  #define MWRID_EXTRA_PHLISTS 5

/*===========================================================================
 *		End of Definitions
 *=========================================================================*/


/*===========================================================================
 *
 * Begin Type Definitions
 *
 *=========================================================================*/
	/* Creation options */
  class mwrig_options_t : public mwri_group_t {
    public:

	int		 CurrentItemLevel;
	long		 CurrentEffectMask;
	float		 CurrentRatio;
	mwri_item_t*	 pCurrentItem;
	mwrand_effect_t* pCurrentPrefix;
	mwrand_effect_t* pCurrentSuffix;
	mwru_unique_t*   pCurrentUnique;
   };

/*===========================================================================
 *		End of Type Definitions
 *=========================================================================*/


/*===========================================================================
 *
 * Begin Class CMwRandItemGen Definition
 *
 * Description
 *
 *=========================================================================*/
class CMwRandItemGen {

  /*---------- Begin Private Class Members ----------------------*/
private:
  CMwRandItems		m_RandItems;		/* Data table classes */
  CMwRandEffects	m_RandEffects;
  CMwRandUniques	m_RandUniques;
  CMwRandLList		m_RandLLists;
  CMwRandItemGroup	m_GroupData;

  CMwRandItemArray	m_ValidItems;
  CMwRandEffectArray	m_ValidPrefixes;
  CMwRandEffectArray	m_ValidSuffixes;
  CMwRandUniqueArray	m_ValidUniques;

  TCHAR			m_InitialPath[_MAX_PATH + 1];

  long			m_NumNewItems;
  long			m_NumEnchantments;
  long			m_NumScripts;
  long			m_NumLevelLists;
  long			m_NumPHLists;
  bool			m_HasEnchantment;
  long			m_ExportCount;

  mwrig_options_t	m_Options;

  CEsmRecArray		m_NewRecords;		/* Newly created records */
  CEsmRecArray		m_ListRecords;
  CEsmRecArray		m_LevelLists;
  CEsmRecArray		m_PHLists;
  CEsmRecArray		m_AllRecords;
  CEsmFile		m_EsmFile;
  CEsmLevelItem*	m_pLevelItems;
  CEsmScript*		m_pScript1;
  CEsmScript*		m_pScript2;
  CSString		m_ScriptBuffer1;
  CSString		m_ScriptBuffer2;
  byte			m_ScriptData1[MWRIG_SCRIPTDATA_SIZE];
  byte			m_ScriptData2[MWRIG_SCRIPTDATA_SIZE];
  int			m_ScriptSize1;
  int			m_ScriptSize2;

  CGenFile		m_ScriptFile;


  /*---------- Begin Protected Class Methods --------------------*/
protected:

	/* Adds a single enchantment effect to the given record */
  void AddEnchantEffect (CEsmRecord* pEnchant, mwrand_encheff_t& EnchantEffect);

	/* Add the sorted leveled items to the leveled list */
  void AddLevelListItem (CEsmRecord* pRecord);
  void AddSortLevelItems (void);

	/* Add data to the compiled script buffers */
  bool AddScriptData1 (const char* pData, const int Size);
  bool AddScriptData2 (const char* pData, const int Size);

	/* Allocates a new record according to the current settings */
  CEsmRecord* AllocateNewRecord  (void);
  void        AllocateLevelList  (void);

	/* Returns true if the input item level is currently valid */
  bool CheckItemLevel   (const int Level);
  bool CheckEffectLevel (const int Level);
  bool CheckCursedLevel (const int Level);

	/* Removes any suffixes that don't match the current prefix */
  void CheckValidSuffixes (void);

	/* Check and correct weapon damage */
  void CheckWeaponDamage (CEsmWeapon* pWeapon);

	/* Check and remove item duplicates as required */
  bool CheckDuplicates (CEsmRecord* pRecord);

	/* Clear all the currently valid item arrays */
  void ClearValidItems (void);
  
  	/* Attempt to close the script file */
  bool CloseScriptFile (void);
  bool CloseScriptRecord (void);

	/* Compute any magical effects for the current item */
  void ComputeCurrentEffects (void);
  
	/* Computes a new current item level */
  void ComputeItemLevel    (void);
  void ComputeQualityLevel (void);
  int  ComputeItemLevel    (CEsmItem2* pItem);

	/* Create the given enchant for the record */
  void CreateEffect (CEsmRecord* pRecord, mwrand_effect_t* pEffect, CEsmEnchant** ppEnchant, CEsmSpell** ppSpell);

	/* Allocate and initialize the place-holder lists */
  void CreatePHLists (void);

	/* Create/add specific effect types */
  void CreateEnchantment (CEsmRecord* pRecord, mwrand_effect_t* pEffect, CEsmEnchant** ppEnchant);
  void CreateSpell       (CEsmRecord* pRecord, mwrand_effect_t* pEffect, CEsmSpell** ppSpell);
  void CreateArmor       (CEsmRecord* pRecord, mwrand_effect_t* pEffect);
  void CreateDamage      (CEsmRecord* pRecord, mwrand_effect_t* pEffect);
  void CreateEnchantPts  (CEsmRecord* pRecord, mwrand_effect_t* pEffect);
  void CreateMaxDamage   (CEsmRecord* pRecord, mwrand_effect_t* pEffect);
  void CreateMinDamage   (CEsmRecord* pRecord, mwrand_effect_t* pEffect);
  void CreateWeight      (CEsmRecord* pRecord, mwrand_effect_t* pEffect);
  void CreateReach       (CEsmRecord* pRecord, mwrand_effect_t* pEffect);
  void CreateSpeed       (CEsmRecord* pRecord, mwrand_effect_t* pEffect);
  void CreateCondition   (CEsmRecord* pRecord, mwrand_effect_t* pEffect); 

	/* Main item creation function */
  void CreateItem (void);

	/* Export record data from an ESP/ESM file */
  bool ExportArmor     (CGenFile& OutputFile, CEsmArmor* pArmor);
  bool ExportClothing  (CGenFile& OutputFile, CEsmClothing* pClothing);
  bool ExportMisc      (CGenFile& OutputFile, CEsmMisc*   pMisc);
  bool ExportWeapon    (CGenFile& OutputFile, CEsmWeapon* pWeapon);
  bool ExportBodyParts (CGenFile& OutputFile, CEsmRecord* pRecord);

	/* See if the record is a duplicate item */
  bool IsDuplicate (CEsmRecord* pRecord);

	/* Checks if the effect/item pair is valid */
  bool IsValidEffect (mwrand_effect_t* pEffect, mwri_item_t* pItem);

	/* Makes a random item and stores it in the new array */
  bool MakeRandomItem (void);

  	/* Make a new enchantment/spell object */
  void MakeEnchantment (CEsmRecord* pRecord, CEsmEnchant** ppEnchant);
  void MakeSpell       (CEsmRecord* pRecord, CEsmSpell**   ppSpell);

	/* Create base item strings  */
  const TCHAR* MakeItemID      (void);
  const TCHAR* MakeLevelListID (void);
  const TCHAR* MakePHListID    (void);
  const TCHAR* MakeItemName    (void);

	/* Attempt to open a new script file */
  bool OpenNewScriptFile   (void);
  bool OpenNewScriptRecord (void);

  	/* Create the levelled list scripts */
  bool OutputLListScripts (void);
  bool OutputPHListScripts (void);

	/* Select a base item to use */
  void SelectBaseItem (void);

	/* Select all valid items/effects/uniques based on the current settings */
  void SelectValidItems    (void);
  void SelectValidSuffixes (void);
  void SelectValidPrefixes (void);
  void SelectValidUniques  (void);

	/* Sets the new record parameters according to the current settings */
  void SetRecordItemParams (CEsmRecord*   pRecord);
  void SetRecordEffects    (CEsmRecord*   pRecord);
  void SetWeaponParams     (CEsmWeapon*   pWeapon);
  void SetArmorParams      (CEsmArmor*    pArmor);
  void SetClothingParams   (CEsmClothing* pClothing);
  void SetMiscParams	   (CEsmMisc*     pMisc);
  void SetBodyParts        (CEsmRecord*   pRecord);
  
	/* Outputs a single script entry to the script file */
  bool WriteScriptEntry   (const TCHAR* pID, const int Level);
  bool WriteScriptRecord  (const TCHAR* pID, const int Level);


  /*---------- Begin Public Class Methods -----------------------*/
public:

	/* Class Constructors/Destructors */
  CMwRandItemGen();
  virtual ~CMwRandItemGen() { Destroy(); }
  virtual void Destroy (void);

  	/* Creates all items accorinding to the current settings */
  bool CreateItems (void);
  
	/* Delete all records in the new array */
  void DestroyNewRecords (void);
  void ClearAllRecords   (void) { m_AllRecords.RemoveAll(); }

	/* Export base item data from an ESP/ESM file */
  bool ExportItemData (const TCHAR* pEsmFile, const TCHAR* pOutputFile);

	/* Get class members */
  mwrig_options_t* GetOptions     (void) { return (&m_Options); }
  CEsmRecArray*    GetNewRecords  (void) { return (&m_NewRecords); }
  CEsmFile*	   GetEsmFile     (void) { return (&m_EsmFile); }
  long		   GetNumNewItems (void) { return (m_NumNewItems); }
  long		   GetNumEnchantments (void) { return (m_NumEnchantments); }

	/* Attempt to load the data files */
  bool LoadDataFiles (void);
  bool LoadGroupFile (const TCHAR* pFilename);
  bool SaveGroupFile (const TCHAR* pFilename);

	/* Attempt to merge an existing ESP into the current records */
  bool MergeEsp (const TCHAR* pFilename, const bool Add = true);


 };
/*===========================================================================
 *		End of Class CMwRandItemGen Definition
 *=========================================================================*/


/*===========================================================================
 *
 * Begin Function Prototypes
 *
 *=========================================================================*/

	/* Set default options */
  void DefaultMWRandItemGenOptions (mwrig_options_t& Options);
   
/*===========================================================================
 *		End of Function Prototypes
 *=========================================================================*/



#endif
/*===========================================================================
 *		End of File Mwranditemgen.H
 *=========================================================================*/


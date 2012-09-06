/*===========================================================================
 *
 * File:	Esmutils.H
 * Author:	Dave Humphrey (uesp@m0use.net)
 * Created On:	February 9, 2003
 *
 * Description
 *
 *=========================================================================*/
#ifndef __ESMUTILS_H
#define __ESMUTILS_H


/*===========================================================================
 *
 * Begin Required Includes
 *
 *=========================================================================*/
  #include "string/sstring.h"
  #include "mwcommon.h"
/*===========================================================================
 *		End of Required Includes
 *=========================================================================*/


/*===========================================================================
 *
 * Begin Definitions
 *
 *=========================================================================*/

/*===========================================================================
 *		End of Definitions
 *=========================================================================*/


/*===========================================================================
 *
 * Begin Function Prototypes
 *
 *=========================================================================*/

	/* Type conversion functions */
  int ConvertBipedToBodyPart (const int BipedType);

	/* Combo/list box fill functions */
  void FillEsmArmorTypeCombo	 (CComboBox& ComboBox);
  void FillEsmAttributesCombo	 (CComboBox& ComboBox);
  void FillEsmClothTypeCombo     (CComboBox& ComboBox);
  void FillEsmSkillsCombo	 (CComboBox& ComboBox, const bool IncludeEmpty = false);
  void FillEsmScriptCombo	 (CComboBox& ComboBox);
  void FillEsmSoundCombo         (CComboBox& ComboBox);
  void FillEsmEffectsCombo	 (CComboBox& ComboBox, const bool IsAlchemy = false);
  void FillEsmEnchantCombo	 (CComboBox& ComboBox);
  void FillEsmRecordCombo	 (CComboBox& ComboBox, const TCHAR* pType, const bool IncludeEmpty = false);
  void FillEsmApparatusTypeCombo (CComboBox& ComboBox);
  void FillEsmSpellSchoolCombo	 (CComboBox& ComboBox);
  void FillEsmBodyPartsCombo	 (CComboBox& ComboBox);
  void FillEsmBodyPartsCombo	 (CComboBox& ComboBox, const int BodyPart, const bool IsFemale, const int BodyPartType, const bool AddEmpty = true);
  void FillEsmBodyRaceCombo      (CComboBox& ComboBox, const int BodyPart, const bool IsFemale, const TCHAR* pRace, const bool AddEmpty = true);
  void FillEsmGlobalTypeCombo	 (CComboBox& ComboBox);
  void FillEsmEnchantRangeCombo	 (CComboBox& ComboBox, const bool NoSelf = false);
  void FillEsmEnchantTypeCombo   (CComboBox& ComboBox);
  void FillEsmBodyPartCombo      (CComboBox& ComboBox);
  void FillEsmBodyPartTypeCombo  (CComboBox& ComboBox);
  void FillEsmLightFlickerCombo  (CComboBox& ComboBox);
  void FillEsmVisualCombo	 (CComboBox& ComboBox, const bool IsBolt);
  void FillEsmSpellTypeCombo     (CComboBox& ComboBox);
  void FillEsmWeaponTypeCombo	 (CComboBox& ComboBox);
  void FillEsmClassSpecCombo	 (CComboBox& ComboBox);
  void FillEsmClassCombo	 (CComboBox& ComboBox, const bool IncludeEmpty = false);
  void FillEsmFactionCombo	 (CComboBox& ComboBox, const bool IncludeEmpty = false);
  void FillEsmSoundGenTypeCombo	 (CComboBox& ComboBox);
  void FillEsmRegionCombo	 (CComboBox& ComboBox);
  void FillEsmRankCombo		 (CComboBox& ComboBox, const bool IncludeEmpty = false);
  void FillEsmCellCombo		 (CComboBox& ComboBox, const bool IncludeEmpty = false);
  void FillEsmNpcCombo		 (CComboBox& ComboBox, const bool IncludeEmpty = false);
  void FillEsmGenderCombo	 (CComboBox& ComboBox, const bool IncludeEmpty = false);
  void FillEsmCreatureCombo 	 (CComboBox& ComboBox, const bool IncludeEmpty = false, const bool IncludeLevel = false);
  void FillEsmRaceCombo		 (CComboBox& ComboBox, const bool IncludeEmpty = false);
  void FillEsmSoundCombo	 (CComboBox& ComboBox);
  void FillEsmInfoFuncTypeCombo  (CComboBox& ComboBox);
  void FillEsmInfoCompareOpCombo (CComboBox& ComboBox);
  void FillEsmItemCombo		 (CComboBox& ComboBox);
  void FillEsmGlobalCombo	 (CComboBox& ComboBox);
  void FillEsmJournalCombo	 (CComboBox& ComboBox);
  void FillEsmLocalCombo	 (CComboBox& ComboBox);
  void FillEsmItemCombo		 (CComboBox& ComboBox);
  void FillEsmFunctionCombo	 (CComboBox& ComboBox);
  void FillEsmBloodTypeCombo	 (CComboBox& ComboBox);
  void FillEsmSoundGenCreaCombo  (CComboBox& ComboBox);
  void FillEsmCreatureListCombo  (CComboBox& ComboBox);

	/* Select various Morrowind files */
  bool SelectEsmSound   (CString& SoundString, const TCHAR* pTitle, CWnd* pParent);
  bool SelectEsmIcon    (CString& IconString,  const TCHAR* pTitle, CWnd* pParent);
  bool SelectEsmModel   (CString& ModelString, const TCHAR* pTitle, CWnd* pParent);
  bool SelectEsmTexture (CString& TextureString, const TCHAR* pTitle, CWnd* pParent);

	/* Path functions */
  const TCHAR*	GetMWDataPath (void);
  void		SetMWDataPath (const TCHAR* pString);

	/* Attempt to update the Morrowind paths from ther registry */
  void FindMWRegistryPath (void);

	/* Checks for a valid ID */
  bool IsValidESMID (const TCHAR* pID);

	/* File input helpers */
  bool ReadFile (CSString& Buffer, const TCHAR* pFilename);

/*===========================================================================
 *		End of Function Prototypes
 *=========================================================================*/


#endif
/*===========================================================================
 *		End of File Esmutils.H
 *=========================================================================*/

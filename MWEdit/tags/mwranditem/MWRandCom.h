/*===========================================================================
 *
 * File:	Mwrandcom.H
 * Author:	Dave Humphrey (uesp@m0use.net)
 * Created On:	May 22, 2003
 *
 * Description
 *
 *=========================================================================*/
#ifndef __MWRANDCOM_H
#define __MWRANDCOM_H


/*===========================================================================
 *
 * Begin Required Includes
 *
 *=========================================================================*/
  #include "EsmFile.h"
/*===========================================================================
 *		End of Required Includes
 *=========================================================================*/


/*===========================================================================
 *
 * Begin Definitions
 *
 *=========================================================================*/

	/* Arbitrary line length when inputting files */
  #define MWRI_MAX_LINELENGTH 255
  
	/* Types of IDs */
  #define MWRID_IDTYPE_LONG	0
  #define MWRID_IDTYPE_SHORT8	1
  #define MWRID_IDTYPE_SHORT4	2

  	/* Default file names */
  #define MWRIG_DEFAULTFILE_ITEM	_T("baseitems.dat")
  #define MWRIG_DEFAULTFILE_EFFECT	_T("effects.dat")
  #define MWRIG_DEFAULTFILE_UNIQUE	_T("uniques.dat")
  #define MWRIG_DEFAULTFILE_LEVELLIST	_T("levellists.dat")


/*===========================================================================
 *		End of Definitions
 *=========================================================================*/


/*===========================================================================
 *
 * Begin Type Definitions
 *
 *=========================================================================*/

  typedef struct {
	float	IgnoreChance;
	float	EnchantChance;
	int	Number;
	float	Reach1;
	float	Reach2;
	float	Speed1;
	float	Speed2;
	int	Condition1;
	int	Condition2;
	float	Enchant1;
	float	Enchant2;
	float	Weight1;
	float	Weight2;
	int	ThrustMin1;
	int	ThrustMin2;
	int	SlashMin1;
	int	SlashMin2;
	int	ChopMin1;
	int	ChopMin2;
	int	ThrustMax1;
	int	ThrustMax2;
	int	SlashMax1;
	int	SlashMax2;
	int	ChopMax1;
	int	ChopMax2;
	float	DamageFactor;
	float	EnchantFactor;
	float	WeightFactor;
	float	ReachFactor;
	float	SpeedFactor;
	float	HealthFactor;
	float	ChanceNone;
	TCHAR	Prefix[32];
	bool	OutputList;
	bool	UseShortNumberID;
   } mwri_weapondata_t;

/*===========================================================================
 *		End of Type Definitions
 *=========================================================================*/


/*===========================================================================
 *
 * Begin Function Prototypes
 *
 *=========================================================================*/

	/* General random number generator */
  float MakeRandItemNumber (const float FromValue, const float ToValue);
  float MakeRandItemNumber (const float FromValue, const float ToValue, const float BellValue);

	/* Splits values according to a ratio (0-1.0) */
  float SplitValue (const float FromValue, const float ToValue, const float Ratio);

	/* Generate random item IDs */
  const TCHAR* MakeRandomItemId  (const TCHAR* pPrefix);
  const TCHAR* MakeNumberItemId8 (const TCHAR* pPrefix);
  const TCHAR* MakeNumberItemId4 (const TCHAR* pPrefix);

	/* Default structure initialization */
  void DefaultWeaponData (mwri_weapondata_t& WeaponData);

/*===========================================================================
 *		End of Function Prototypes
 *=========================================================================*/



#endif
/*===========================================================================
 *		End of File Mwrandcom.H
 *=========================================================================*/

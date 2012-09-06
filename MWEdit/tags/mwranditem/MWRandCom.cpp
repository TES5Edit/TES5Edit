/*===========================================================================
 *
 * File:	Mwrandcom.CPP
 * Author:	Dave Humphrey (uesp@m0use.net)
 * Created On:	May 22, 2003
 *
 * Description
 *
 *=========================================================================*/

	/* Include Files */
#include "stdafx.h"
#include "mwrandcom.h"


/*===========================================================================
 *
 * Begin Local Definitions
 *
 *=========================================================================*/
  DEFINE_FILE("MWRandCom.cpp");

	/* Used to generate a random item ID string */
  long 	l_ItemIDCount = 1;
  DWORD l_ItemSerialNumber = 0x12345678;
  bool  l_HasSerialNumber  = false;
/*===========================================================================
 *		End of Local Definitions
 *=========================================================================*/


/*===========================================================================
 *
 * Function - void DefaultWeaponData (WeaponData);
 *
 * Initializes a weapon data structure.
 *
 *=========================================================================*/
void DefaultWeaponData (mwri_weapondata_t& WeaponData) {
  WeaponData.Number = 10;
  WeaponData.ChopMin1 = 1;
  WeaponData.ChopMin2 = 10;
  WeaponData.ChopMax1 = 10;
  WeaponData.ChopMax2 = 50;
  WeaponData.SlashMin1 = 1;
  WeaponData.SlashMin2 = 15;
  WeaponData.SlashMax1 = 15;
  WeaponData.SlashMax2 = 75;
  WeaponData.ThrustMin1 = 1;
  WeaponData.ThrustMin2 = 10;
  WeaponData.ThrustMax1 = 10;
  WeaponData.ThrustMax2 = 40;
  WeaponData.EnchantChance = 0.25f;
  WeaponData.IgnoreChance  = 0.90f;
  WeaponData.Reach1 = 0.50f;
  WeaponData.Reach2 = 2.0f;
  WeaponData.Speed1 = 2.0f;
  WeaponData.Speed2 = 0.5f;
  WeaponData.Weight1 = 20.0f;
  WeaponData.Weight2 = 0.5f;
  WeaponData.Condition1 = 100;
  WeaponData.Condition2 = 10000;
  WeaponData.Enchant1 = 0;
  WeaponData.Enchant2 = 200;
  WeaponData.DamageFactor  = 1.0f;
  WeaponData.EnchantFactor = 1.0f;
  WeaponData.WeightFactor = 1.0f;
  WeaponData.ReachFactor = 1.0f;
  WeaponData.SpeedFactor  = 1.0f;
  WeaponData.HealthFactor = 1.0f;
  WeaponData.ChanceNone = 5;
  WeaponData.OutputList = true;
  WeaponData.UseShortNumberID = false;
  WeaponData.Prefix[0] = NULL_CHAR;
 }
/*===========================================================================
 *		End of Function DefaultWeaponData()
 *=========================================================================*/


/*===========================================================================
 *
 * Function - void l_GetItemSerial (void);
 *
 * Makes the item serial number for the current session. Attempts to use
 * the user's hard drive serial number if available, otherwise the current
 * clock tick count.
 *
 *=========================================================================*/
void l_GetItemSerial (void) {
  BOOL Result;

	/* Attempt to get the drive c: serial number */
  Result = GetVolumeInformation(_T("c:\\"), NULL, 0, &l_ItemSerialNumber, NULL, NULL, NULL, 0);

	/* Generate a 'random' serial number if the previous call failed */  
  if (!Result) l_ItemSerialNumber = (DWORD) clock();
  l_HasSerialNumber = true;
 }
/*===========================================================================
 *		End of Function l_GetItemSerial()
 *=========================================================================*/


/*===========================================================================
 *
 * Function - float MakeRandItemNumber (FromValue, ToValue, BellValue);
 *
 * Returns a random number in the given range ('From' can be smaller or larger
 * than 'To'). How the number is generated depends on the input flags.
 *
 * Default
 *	Random number with equal probability along the entire range.
 *
 * BellValue = Midpoint of range.
 *
 *=========================================================================*/
float MakeRandItemNumber (const float FromValue, const float ToValue, const float BellValue) {
  float Result;
  int   HalfResult;
  float FromValue1 = FromValue;
  float ToValue1   = ToValue;

	/* Determine which 'half' to use */
  HalfResult = (int) ((float) rand()/(float) RAND_MAX * 2);
  if (HalfResult == 0) ToValue1 = BellValue;
  if (HalfResult == 1) FromValue1 = BellValue;

  if (FromValue1 == ToValue1)
    Result = FromValue1;
  else if (FromValue1 > ToValue1) {
    Result = ((float) rand()/(float) RAND_MAX) * (FromValue1 - ToValue1) + ToValue1;
   }
  else {
    Result = ((float) rand()/(float) RAND_MAX) * (ToValue1 - FromValue1) + FromValue1;
   }

  return (Result);
 }


float MakeRandItemNumber (const float FromValue, const float ToValue) {
  float Result;

  if (FromValue == ToValue)
    Result = FromValue;
  else if (FromValue > ToValue) {
    Result = ((float) rand()/(float) RAND_MAX) * (FromValue - ToValue) + ToValue;
   }
  else {
    Result = ((float) rand()/(float) RAND_MAX) * (ToValue - FromValue) + FromValue;
   }

  return (Result);
 }
/*===========================================================================
 *		End of Function MakeRandItemNumber()
 *=========================================================================*/


/*===========================================================================
 *
 * Function - const TCHAR* MakeRandomItemId (pPrefix);
 *
 * Creates and returns a new random item ID string using a local static string.
 * The new ID is a digit string at most 32 bytes in length and will be a
 * unique ID for the current application. The input prefix string is added
 * to the beginning of the ID if it is not NULL (8 bytes at most).
 * 
 * The ID is composed of the following:
 *	bytes  0- 7: Current system time
 *	bytes  8-15: Drive c: serial number (or clock ticks)
 *	bytes 16-23: Incremented counter per application session
 *	bytes 24-31: Custom prefix string if present
 *
 *=========================================================================*/
const TCHAR* MakeRandomItemId (const TCHAR* pPrefix) {
  static TCHAR	s_Buffer[MWESM_ID_MAXSIZE+4];
  time_t	CurrentTime = time(NULL);
  
	/* Attempt to get a serial number if required */
  if (!l_HasSerialNumber) l_GetItemSerial();

	/* Make the ID string */
  if (pPrefix != NULL && *pPrefix != NULL_CHAR)
    snprintf (s_Buffer, 31, _T("%.8s%08lX%08lX%08lX"), pPrefix, l_ItemIDCount, CurrentTime, l_ItemSerialNumber);
  else
    snprintf (s_Buffer, 31, _T("%lX%08lX%08lX"), l_ItemIDCount, CurrentTime, l_ItemSerialNumber);

  l_ItemIDCount++;

  //SystemLog.Printf ("Item ID = '%s'", s_Buffer);
  return (s_Buffer);
 }
/*===========================================================================
 *		End of Class Method MakeRandomItemId()
 *=========================================================================*/


/*===========================================================================
 *
 * Function - const TCHAR* MakeNumberItemId8 (pPrefix);
 *
 * Makes an item ID of the format:
 *
 *	bytes 0- 7: Incremented counter per application session
 *	bytes 8-31: Custom prefix string
 *	 
 * The returned string is stored in a local static buffer.
 *
 *=========================================================================*/
const TCHAR* MakeNumberItemId8 (const TCHAR* pPrefix) {
  static TCHAR	s_Buffer[MWESM_ID_MAXSIZE+4];

	/* Make the ID string */
  if (pPrefix != NULL && *pPrefix != NULL_CHAR)
    snprintf (s_Buffer, 31, _T("%.24s%08lX"), pPrefix, l_ItemIDCount);
  else
    snprintf (s_Buffer, 31, _T("%08lX"), l_ItemIDCount);

  l_ItemIDCount++;

  //SystemLog.Printf ("Item ID = '%s'", s_Buffer);
  return (s_Buffer);
 }


const TCHAR* MakeNumberItemId4 (const TCHAR* pPrefix) {
  static TCHAR	s_Buffer[MWESM_ID_MAXSIZE+4];

	/* Make the ID string */
  if (pPrefix != NULL && *pPrefix != NULL_CHAR)
    snprintf (s_Buffer, 31, _T("%.28s%04lX"), pPrefix, l_ItemIDCount);
  else
    snprintf (s_Buffer, 31, _T("%04lX"), l_ItemIDCount);

  l_ItemIDCount++;

  //SystemLog.Printf ("Item ID = '%s'", s_Buffer);
  return (s_Buffer);
 }
/*===========================================================================
 *		End of Function TCHAR* MakeNumberItemId()
 *=========================================================================*/


/*===========================================================================
 *
 * Function - float SplitValue (FromValue, ToValue, Ratio);
 *
 * Returns a value from (FromValue to ToValue) according to the input ratio
 * (0.0 to 1.0).
 *
 *=========================================================================*/
float SplitValue (const float FromValue, const float ToValue, const float Ratio) {
  return (ToValue - FromValue) * Ratio + FromValue;
 }
/*===========================================================================
 *		End of Function SplitValue()
 *=========================================================================*/

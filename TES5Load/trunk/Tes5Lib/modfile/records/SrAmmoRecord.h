/*===========================================================================
 *
 * File:		SrAmmorecord.H
 * Author:		Dave Humphrey (dave@uesp.net)
 * Created On:	5 December 2011
 *
 * Defines the CSrAmmoRecord class.
 *
 *=========================================================================*/
#ifndef __SRAMMORECORD_H
#define __SRAMMORECORD_H


/*===========================================================================
 *
 * Begin Required Includes
 *
 *=========================================================================*/
	#include "sritem1record.h"
	#include "../subrecords/srlstringsubrecord.h"
	#include "../subrecords/srammodatasubrecord.h"
/*===========================================================================
 *		End of Required Includes
 *=========================================================================*/


/*===========================================================================
 *
 * Begin Class CSrAmmoRecord Definition
 *
 *=========================================================================*/
class CSrAmmoRecord : public CSrItem1Record 
{
  DECLARE_SRSUBRECCREATE()
  DECLARE_SRFIELDMAP()
  DECLARE_SRCLASS(CSrAmmoRecord, CSrItem1Record)

  /*---------- Begin Protected Class Members --------------------*/
protected:
  	CSrSubrecord*			m_pBoundsData;
	CSrLStringSubrecord*	m_pDescription;
	CSrAmmoDataSubrecord*	m_pAmmoData;
	CSrFormidSubrecord*		m_pPickupSound;
	CSrFormidSubrecord*		m_pDropSound;
	CSrSubrecord*			m_pModtData;

	static srammodata_t s_NullAmmoData;


  /*---------- Begin Protected Class Methods --------------------*/
protected:


  /*---------- Begin Public Class Methods -----------------------*/
public:

		/* Class Constructors/Destructors */
  CSrAmmoRecord();
  virtual void Destroy (void);

    	/* Return a new instance of the class */
  static CSrRecord* Create (void) { return new CSrAmmoRecord; }

  srammodata_t& GetAmmoData (void) { return m_pAmmoData ? m_pAmmoData->GetAmmoData() : s_NullAmmoData; }

		/* Get class members */  
  const char* GetProjectile    (void);
  srformid_t  GetProjectileID  (void) { return m_pAmmoData    ? m_pAmmoData->GetAmmoData().ProjectileID : 0; }
  bool		  GetIgnoreResist  (void) { return CheckFlagBits(GetAmmoData().Flags, SR_AMMOFLAG_IGNORERESIST); }
  bool		  GetVanishes      (void) { return CheckFlagBits(GetAmmoData().Flags, SR_AMMOFLAG_VANISHES); }
  

		/* Initialize a new record */
  void InitializeNew (void);

		/* Called to alert record of a new subrecord being added */
  virtual void OnAddSubrecord    (CSrSubrecord* pSubrecord);
  virtual void OnDeleteSubrecord (CSrSubrecord* pSubrecord);

  void SetProjectileID  (const srformid_t FormID);
  void SetProjectile    (const char* pEditorID);
  void SetIgnoreResist  (const bool Flag) { FlipFlagBits(GetAmmoData().Flags, SR_AMMOFLAG_IGNORERESIST, Flag); }
  void SetVanishes      (const bool Flag) { FlipFlagBits(GetAmmoData().Flags, SR_AMMOFLAG_VANISHES, Flag); }

		/* Begin field method definitions */
  DECLARE_SRFIELD_DESCRIPTION(CSrAmmoRecord, SR_NAME_DESC)
  DECLARE_SRFIELD_DWORD1(CSrAmmoRecord, Value, GetAmmoData().Value, GetAmmoData().Value)
  DECLARE_SRFIELD_FLOAT1(CSrAmmoRecord, Damage, GetAmmoData().Damage, GetAmmoData().Damage)
  DECLARE_SRFIELD_BOOL(CSrAmmoRecord, IgnoreResist, GetIgnoreResist, SetIgnoreResist)
  DECLARE_SRFIELD_BOOL(CSrAmmoRecord, Vanish, GetVanishes, SetVanishes)

  DECLARE_SRFIELD_EDITORID(CSrAmmoRecord, PickupSound, GetPickupSound, SetPickupSound)
  DECLARE_SRFIELD_EDITORID(CSrAmmoRecord, DropSound,   GetDropSound,   SetDropSound)
  DECLARE_SRFIELD_EDITORID(CSrAmmoRecord, Projectile,  GetProjectile,  SetProjectile)

  DECLARE_SRMETHOD_FORMID(PickupSound, m_pPickupSound, SR_NAME_YNAM)
  DECLARE_SRMETHOD_FORMID(DropSound,   m_pDropSound,   SR_NAME_ZNAM)

};
/*===========================================================================
 *		End of Class CSrAmmoRecord Definition
 *=========================================================================*/


#endif
/*===========================================================================
 *		End of File SrAmmoRecord.H
 *=========================================================================*/

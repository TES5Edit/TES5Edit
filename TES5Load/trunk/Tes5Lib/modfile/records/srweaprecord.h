/*===========================================================================
 *
 * File:		Srweaprecord.H
 * Author:		Dave Humphrey (dave@uesp.net)
 * Created On:	26 November 2011
 *
 * Defines the CSrWeapRecord class for weapon records.
 *
 *=========================================================================*/
#ifndef __SRWEAPRECORD_H
#define __SRWEAPRECORD_H


/*===========================================================================
 *
 * Begin Required Includes
 *
 *=========================================================================*/
	#include "sritem2record.h"
	#include "../subrecords/srweapdatasubrecord.h"
	#include "../subrecords/srcrdtsubrecord.h"
	#include "../subrecords/srweapdnamsubrecord.h"
	#include "../subrecords/srvmadsubrecord.h"
/*===========================================================================
 *		End of Required Includes
 *=========================================================================*/


/*===========================================================================
 *
 * Begin Class CSrWeapRecord Definition
 *
 * Holds weapon data.
 *
 *=========================================================================*/
class CSrWeapRecord : public CSrItem2Record 
{
  DECLARE_SRSUBRECCREATE()
  DECLARE_SRFIELDMAP()
  DECLARE_SRCLASS(CSrWeapRecord, CSrItem2Record)

  /*---------- Begin Protected Class Members --------------------*/
protected:
  CSrWeapDataSubrecord*		m_pWeaponData;
  CSrDwordSubrecord*		m_pVNAM;
  CSrFormidSubrecord*		m_pEquipSlot;
  CSrFormidSubrecord*		m_pSwingSound;
  CSrFormidSubrecord*		m_pStatic;
  CSrFormidSubrecord*		m_pSheathSound;
  CSrFormidSubrecord*		m_pDrawSound;
  CSrFormidSubrecord*		m_pBoundSound;
  CSrFormidSubrecord*		m_pFireSound;
  CSrFormidSubrecord*		m_pImpactSet;
  CSrFormidSubrecord*		m_pMaterial;
  CSrFormidSubrecord*		m_pBaseWeapon;
  CSrStringSubrecord*		m_pNName;
  CSrWeapDnamSubrecord*		m_pDName;
  CSrCrdtSubrecord*			m_pCrdtData;
  CSrLStringSubrecord*		m_pDescription;

  static srcrdtdata_t     s_NullCrdtData;
  static srweapdata_t     s_NullWeapData;
  static srweapdnamdata_t s_NullDnamData;


  /*---------- Begin Protected Class Methods --------------------*/
protected:


  /*---------- Begin Public Class Methods -----------------------*/
public:

	/* Class Constructors/Destructors */
  CSrWeapRecord();
  virtual void Destroy (void);

    	/* Return a new instance of the class */
  static CSrRecord* Create (void) { return new CSrWeapRecord; }

	/* Get class members */
  srformid_t        GetEquipSlotID    (void) { return m_pEquipSlot ? m_pEquipSlot->GetValue() : 0; }
  const SSCHAR*     GetEquipSlot      (void);
  srweapdata_t&     GetWeaponData	  (void) { return (m_pWeaponData ? m_pWeaponData->GetWeaponData() : s_NullWeapData); }
  srcrdtdata_t&     GetCrdtData       (void) { return m_pCrdtData ? m_pCrdtData->GetCrdtData() : s_NullCrdtData; }
  srweapdnamdata_t& GetDnamData       (void) { return m_pDName ? m_pDName->GetDnamData() : s_NullDnamData; }
  dword			    GetVNAM           (void) { return m_pVNAM ? m_pVNAM->GetValue() : 0; }
  const SSCHAR*	    GetWeaponType     (void) { return GetSrWeaponTypeString(GetDnamData().WeaponType); }
  const SSCHAR*	    GetWeaponMaterial (void);

	/* Initialize a new record */
  void InitializeNew (void);

	/* Called to alert record of a new subrecord being added */
  virtual void OnAddSubrecord    (CSrSubrecord* pSubrecord);
  virtual void OnDeleteSubrecord (CSrSubrecord* pSubrecord);

  	/* Set class members */
  void SetVNAM   (const dword Value) { if (m_pVNAM != NULL) m_pVNAM->SetValue(Value); }
  void SetWeaponType     (const char* pString) { GetSrWeaponTypeValue(GetDnamData().WeaponType, pString); }
  void SetEquipSlotID    (const srformid_t FormID);
  void SetEquipSlot      (const char* pEditorID);
  void SetWeaponMaterial (const srformid_t FormID);
  void SetWeaponMaterial (const char* pEditorID);
  	 

		/* Begin field method definitions */
  DECLARE_SRFIELD(FieldWeight)
  DECLARE_SRFIELD(FieldValue)
  DECLARE_SRFIELD(FieldDamage)
  DECLARE_SRFIELD(FieldVNAM)
  DECLARE_SRFIELD(FieldEquipSlot)

  DECLARE_SRFIELD_DESCRIPTION(CSrWeapRecord, SR_NAME_DESC)
  DECLARE_SRFIELD_METHOD(CSrWeapRecord, Type, GetWeaponType, SetWeaponType)
  DECLARE_SRFIELD_METHOD(CSrWeapRecord, Material, GetWeaponMaterial, SetWeaponMaterial)
  DECLARE_SRFIELD_DWORD1(CSrWeapRecord, Unknown1, GetCrdtData().Unknown1, GetCrdtData().Unknown1)
  DECLARE_SRFIELD_FLOAT1(CSrWeapRecord, Unknown2, GetCrdtData().Unknown2, GetCrdtData().Unknown2)
  DECLARE_SRFIELD_INT1(CSrWeapRecord, Unknown3, GetCrdtData().Unknown3, GetCrdtData().Unknown3)

  DECLARE_SRFIELD_FLOAT1(CSrWeapRecord, Unknown5, GetDnamData().Unknown2, GetDnamData().Unknown2)
  DECLARE_SRFIELD_FLOAT1(CSrWeapRecord, Unknown6, GetDnamData().Unknown3, GetDnamData().Unknown3)
  DECLARE_SRFIELD_WORD1(CSrWeapRecord, Unknown7, GetDnamData().Unknown4, GetDnamData().Unknown4)
  DECLARE_SRFIELD_FLOAT1(CSrWeapRecord, Unknown8, GetDnamData().Unknown5, GetDnamData().Unknown5)
  DECLARE_SRFIELD_FLOAT1(CSrWeapRecord, Unknown9, GetDnamData().Unknown6, GetDnamData().Unknown6)
  DECLARE_SRFIELD_FLOAT1(CSrWeapRecord, Unknown10, GetDnamData().Unknown7, GetDnamData().Unknown7)
  DECLARE_SRFIELD_FLOAT1(CSrWeapRecord, Unknown11, GetDnamData().Unknown8, GetDnamData().Unknown8)
  DECLARE_SRFIELD_FLOAT1(CSrWeapRecord, Unknown12, GetDnamData().Unknown9, GetDnamData().Unknown9)
  DECLARE_SRFIELD_FLOAT1(CSrWeapRecord, Unknown13, GetDnamData().Unknown10, GetDnamData().Unknown10)
  DECLARE_SRFIELD_FLOAT1(CSrWeapRecord, Unknown14, GetDnamData().Unknown11, GetDnamData().Unknown11)
  DECLARE_SRFIELD_DWORD1(CSrWeapRecord, Unknown15, GetDnamData().Unknown12, GetDnamData().Unknown12)
  DECLARE_SRFIELD_FLOAT1(CSrWeapRecord, Unknown16, GetDnamData().Unknown13, GetDnamData().Unknown13)

  DECLARE_SRFIELD_DWORDFLAG1(CSrWeapRecord, UnknownFlag1, GetDnamData().UnknownFlags1, GetDnamData().UnknownFlags1)

  DECLARE_SRFIELD_DWORDFLAG1(CSrWeapRecord, Unknown17, GetDnamData().ReferenceID, GetDnamData().ReferenceID)

  DECLARE_SRFIELD_EDITORID(CSrWeapRecord, SheathSound, GetSheathSound, SetSheathSound)
  DECLARE_SRMETHOD_FORMID(SheathSound, m_pSheathSound, SR_NAME_NAM8)

  DECLARE_SRFIELD_EDITORID(CSrWeapRecord, DrawSound, GetDrawSound, SetDrawSound)
  DECLARE_SRMETHOD_FORMID(DrawSound, m_pDrawSound, SR_NAME_NAM9)

  DECLARE_SRFIELD_EDITORID(CSrWeapRecord, FireSound, GetFireSound, SetFireSound)
  DECLARE_SRMETHOD_FORMID(FireSound, m_pFireSound, SR_NAME_SNAM)

  DECLARE_SRFIELD_EDITORID(CSrWeapRecord, SwingSound, GetSwingSound, SetSwingSound)
  DECLARE_SRMETHOD_FORMID(SwingSound, m_pSwingSound, SR_NAME_TNAM)

  DECLARE_SRFIELD_EDITORID(CSrWeapRecord, BoundSound, GetBoundSound, SetBoundSound)
  DECLARE_SRMETHOD_FORMID(BoundSound, m_pBoundSound, SR_NAME_UNAM)

  DECLARE_SRFIELD_EDITORID(CSrWeapRecord, Static, GetStatic, SetStatic)
  DECLARE_SRMETHOD_FORMID(Static, m_pStatic, SR_NAME_WNAM)

  DECLARE_SRFIELD_EDITORID(CSrWeapRecord, BaseWeapon, GetBaseWeapon, SetBaseWeapon)
  DECLARE_SRMETHOD_FORMID(BaseWeapon, m_pBaseWeapon, SR_NAME_CNAM)

  DECLARE_SRFIELD_EDITORID(CSrWeapRecord, MaterialObject, GetMaterialObject, SetMaterialObject)
  DECLARE_SRMETHOD_FORMID(MaterialObject, m_pMaterial, SR_NAME_BAMT)

  DECLARE_SRFIELD_EDITORID(CSrWeapRecord, ImpactSet, GetImpactSet, SetImpactSet)
  DECLARE_SRMETHOD_FORMID(ImpactSet, m_pImpactSet, SR_NAME_BIDS)

  DECLARE_SRFIELD_STRING(CSrWeapRecord, m_pNName, NName, SR_NAME_NNAM)

};
/*===========================================================================
 *		End of Class CSrWeapRecord Definition
 *=========================================================================*/


/*===========================================================================
 *
 * Begin Function Definitions
 *
 *=========================================================================*/
/*===========================================================================
 *		End of Function Definitions
 *=========================================================================*/


#endif
/*===========================================================================
 *		End of File Srweaprecord.H
 *=========================================================================*/

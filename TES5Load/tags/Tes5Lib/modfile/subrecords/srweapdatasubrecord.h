/*===========================================================================
 *
 * File:		Srweapdatasubrecord.H
 * Author:		Dave Humphrey (dave@uesp.net)
 * Created On:	26 November 2011
 *
 * Description
 *
 *=========================================================================*/
#ifndef __SRWEAPDATASUBRECORD_H
#define __SRWEAPDATASUBRECORD_H


/*===========================================================================
 *
 * Begin Required Includes
 *
 *=========================================================================*/
  #include "srsubrecord.h"
/*===========================================================================
 *		End of Required Includes
 *=========================================================================*/


/*===========================================================================
 *
 * Begin Definitions
 *
 *=========================================================================*/

	/* Standard WEAP-DATA subrecord size in bytes */
  #define SR_WEAPDATA_SUBRECORD_SIZE	10
  
	/* Weapon data flags */
  #define SR_WEAPFLAG_IGNORERESIST	0x00000001

/*===========================================================================
 *		End of Definitions
 *=========================================================================*/


/*===========================================================================
 *
 * Begin Type Definitions
 *
 *=========================================================================*/
#pragma pack(push, 1)

	/* Weapon DATA structure */
  struct srweapdata_t 
  {
	dword	Value;
	float	Weight;
	word    Damage;
  };

#pragma pack(pop)
/*===========================================================================
 *		End of Type Definitions
 *=========================================================================*/


/*===========================================================================
 *
 * Begin Class CSrWeapDataSubrecord Definition
 *
 * Description
 *
 *=========================================================================*/
class CSrWeapDataSubrecord : public CSrSubrecord {
  DECLARE_SRCLASS(CSrWeapDataSubrecord, CSrSubrecord)

  /*---------- Begin Protected Class Members --------------------*/
protected:
	srweapdata_t	m_Data;


  /*---------- Begin Protected Class Methods --------------------*/
protected:

	/* Input/output the subrecord data */
  virtual bool ReadData  (CSrFile& File) {  SR_VERIFY_SUBRECORDSIZE(SR_WEAPDATA_SUBRECORD_SIZE) return File.Read(&m_Data,  SR_WEAPDATA_SUBRECORD_SIZE); }
  virtual bool WriteData (CSrFile& File) {  SR_VERIFY_SUBRECORDSIZE(SR_WEAPDATA_SUBRECORD_SIZE) return File.Write(&m_Data, SR_WEAPDATA_SUBRECORD_SIZE); }


  /*---------- Begin Public Class Methods -----------------------*/
public:

	/* Class Constructors/Destructors */
  CSrWeapDataSubrecord() { }
  //virtual ~CSrWeapDataSubrecord() { Destroy(); }
  virtual void Destroy (void) { CSrSubrecord::Destroy(); }

 	/* Copy the content from an existing subrecord */
  virtual bool Copy (CSrSubrecord* pSubrecord) {
	CSrWeapDataSubrecord* pSubrecord1 = SrCastClassNull(CSrWeapDataSubrecord, pSubrecord);
	m_RecordSize = SR_WEAPDATA_SUBRECORD_SIZE;

	if (pSubrecord1 != NULL) {
	  m_Data = pSubrecord1->GetWeaponData();
	}
	else {
	  memset(&m_Data, 0, sizeof(m_Data));
	}
	return (true);
  }

  	/* Create a class instance */
  static CSrSubrecord* Create (void) { return (new CSrWeapDataSubrecord); }
  virtual CSrSubrecord* CreateV (void) { return new CSrWeapDataSubrecord; }

	/* Get class members */
  srweapdata_t& GetWeaponData (void) { return (m_Data); }
  virtual byte*	GetData       (void) { return (byte *)(&m_Data); }
  float         GetWeight     (void) { return (m_Data.Weight); }
  dword         GetValue      (void) { return (m_Data.Value); }
  word          GetDamage     (void) { return (m_Data.Damage); }

	/* Initialize a new record */
  void InitializeNew (void) { CSrSubrecord::InitializeNew(); memset(&m_Data, 0, sizeof(m_Data)); m_RecordSize = SR_WEAPDATA_SUBRECORD_SIZE; }

	/* Set class members */
  void SetValue  (const dword Value)   { m_Data.Value  = Value; }
  void SetWeight (const float Value)   { m_Data.Weight = Value; }
  void SetDamage (const word  Value)   { m_Data.Damage = Value; }

   
};
/*===========================================================================
 *		End of Class CSrWeapDataSubrecord Definition
 *=========================================================================*/


#endif
/*===========================================================================
 *		End of File Srweapdatasubrecord.H
 *=========================================================================*/

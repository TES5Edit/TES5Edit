/*===========================================================================
 *
 * File:		SrAmmodatasubrecord.H
 * Author:		Dave Humphrey (dave@uesp.net)
 * Created On:	16 December 2011
 *
 * Description
 *
 *=========================================================================*/
#ifndef __SRAMMODATASUBRECORD_H
#define __SRAMMODATASUBRECORD_H


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

		/* Standard AMMO-DATA subrecord size in bytes */
	#define SR_AMMODATA_SUBRECORD_SIZE	16
  
		/* Ammo data flags */
	#define SR_AMMOFLAG_IGNORERESIST	0x00000001
	#define SR_AMMOFLAG_VANISHES		0x00000002

/*===========================================================================
 *		End of Definitions
 *=========================================================================*/


/*===========================================================================
 *
 * Begin Type Definitions
 *
 *=========================================================================*/
#pragma pack(push, 1)

		/* Ammo DATA structure */
	struct srammodata_t 
	{
		srformid_t	ProjectileID;
		dword		Flags;
		float		Damage;
		dword		Value;
	};

#pragma pack(pop)
/*===========================================================================
 *		End of Type Definitions
 *=========================================================================*/


/*===========================================================================
 *
 * Begin Class CSrAmmoDataSubrecord Definition
 *
 * Description
 *
 *=========================================================================*/
class CSrAmmoDataSubrecord : public CSrSubrecord {
  DECLARE_SRCLASS(CSrAmmoDataSubrecord, CSrSubrecord)

  /*---------- Begin Protected Class Members --------------------*/
protected:
	srammodata_t	m_Data;


  /*---------- Begin Protected Class Methods --------------------*/
protected:

		/* Input/output the subrecord data */
  virtual bool ReadData  (CSrFile& File) { SR_VERIFY_SUBRECORDSIZE(SR_AMMODATA_SUBRECORD_SIZE) return File.Read(&m_Data,  SR_AMMODATA_SUBRECORD_SIZE); }
  virtual bool WriteData (CSrFile& File) { SR_VERIFY_SUBRECORDSIZE(SR_AMMODATA_SUBRECORD_SIZE) return File.Write(&m_Data, SR_AMMODATA_SUBRECORD_SIZE); }


  /*---------- Begin Public Class Methods -----------------------*/
public:

		/* Class Constructors/Destructors */
  CSrAmmoDataSubrecord() { }
  virtual void Destroy (void) { CSrSubrecord::Destroy(); }
  
  		/* Change any matching formid in the subrecord */
  virtual dword ChangeFormID (const srformid_t NewID, const srformid_t OldID) 
  {
	if (m_Data.ProjectileID == OldID) 
	{
	  m_Data.ProjectileID = NewID;
	  return (1);
	}

	return (0); 
  }

  virtual dword CountUses (const srformid_t FormID) 
  {
	  if (FormID == m_Data.ProjectileID) return 1;
	  return 0; 
  }

		/* Fixup the modindex of formids */
  virtual bool FixupFormID (CSrFormidFixupArray& FixupArray) 
  {
	return SrFixupFormid(m_Data.ProjectileID, m_Data.ProjectileID, FixupArray);
  }

 		/* Copy the content from an existing subrecord */
  virtual bool Copy (CSrSubrecord* pSubrecord) 
  {
	CSrAmmoDataSubrecord* pSubrecord1 = SrCastClassNull(CSrAmmoDataSubrecord, pSubrecord);
	m_RecordSize = SR_AMMODATA_SUBRECORD_SIZE;

	if (pSubrecord1 != NULL) {
	  m_Data = pSubrecord1->GetAmmoData();
	}
	else {
	  memset(&m_Data, 0, sizeof(m_Data));
	}
	return (true);
  }

  		/* Create a class instance */
  static CSrSubrecord* Create (void) { return (new CSrAmmoDataSubrecord); }
  virtual CSrSubrecord* CreateV (void) { return new CSrAmmoDataSubrecord; }

		/* Get class members */
  srammodata_t& GetAmmoData   (void) { return (m_Data); }
  virtual byte*	GetData       (void) { return (byte *)(&m_Data); }
  
		/* Initialize a new record */
  void InitializeNew (void) { CSrSubrecord::InitializeNew(); memset(&m_Data, 0, sizeof(m_Data)); m_RecordSize = SR_AMMODATA_SUBRECORD_SIZE; }
  
   
};
/*===========================================================================
 *		End of Class CSrAmmoDataSubrecord Definition
 *=========================================================================*/


#endif
/*===========================================================================
 *		End of File SrAmmodatasubrecord.H
 *=========================================================================*/

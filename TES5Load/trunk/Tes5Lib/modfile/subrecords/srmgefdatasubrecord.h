/*===========================================================================
 *
 * File:		Srmgefdatasubrecord.H
 * Author:		Dave Humphrey (dave@uesp.net)
 * Created On:	1 December 2011
 *
 * Description
 *
 *=========================================================================*/
#ifndef __SRMGEFDATASUBRECORD_H
#define __SRMGEFDATASUBRECORD_H


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

	#define SR_MGEFDATA_SUBRECORD_SIZE	152

		/* All flags not yet confirmed (some taken from Oblivion) */
	#define SR_MGEFFLAG_HOSTILE			0x00000001
    #define SR_MGEFFLAG_RECOVER			0x00000002
    #define SR_MGEFFLAG_DETRIMENTAL		0x00000004
	#define SR_MGEFFLAG_SNAPTONAVMESH	0x00000008
    #define SR_MGEFFLAG_NOHITEVENT		0x00000010
    #define SR_MGEFFLAG_DISPELLEFFECTS	0x00000100
    #define SR_MGEFFLAG_NODURATION		0x00000200
    #define SR_MGEFFLAG_NOMAGNITUDE		0x00000400
    #define SR_MGEFFLAG_NOAREA			0x00000800
    #define SR_MGEFFLAG_FXPERSIST		0x00001000
	#define SR_MGEFFLAG_NORECAST		0x00002000
	#define SR_MGEFFLAG_GORYVISUAL		0x00004000
	#define SR_MGEFFLAG_HIDEINUI		0x00008000
    #define SR_MGEFFLAG_POWERMAGNITUDE	0x00020000
	#define SR_MGEFFLAG_POWERDURATION	0x00040000
    #define SR_MGEFFLAG_PAINLESS		0x04000000
    #define SR_MGEFFLAG_NOHITEFFECT		0x08000000
	#define SR_MGEFFLAG_NODEATHDISPELL	0x10000000
	#define SR_MGEFFLAG_WARD			0x40000000
	#define SR_MGEFFLAG_80000000		0x80000000

/*===========================================================================
 *		End of Definitions
 *=========================================================================*/


/*===========================================================================
 *
 * Begin Type Definitions
 * 
 *=========================================================================*/
#pragma pack(push, 1)

  struct srmgefdata_t 
  {
	  dword			Flags;
	  float			BaseCost;
	  srformid_t	ObjectID;
	  int			School;
	  int			ResistType;
	  dword			Unknown1;		//0xffff0000 flags?
	  srformid_t	LightID;
	  float			TaperWeight;	//0-1
	  srformid_t	HitShaderID;
	  srformid_t	EnchantShaderID;		
	  dword			SkillLevel;
	  dword			Area;			//0-6000
	  float			CastingDelay;
	  float			TaperCurve;		//0-2
	  float			TaperDuration;	//0-5
	  float			SecondAVWeight;	//0-2
	  int			EffectType;		//0-43
	  int			ActorValue;		//-1-163
	  srformid_t	ProjectileID;
	  srformid_t	ExplosionID;	//Unknown8
	  int			CastType;		//0-2
	  int			DeliveryType;	//0-4
	  int			ActorValue2;	//-1, 25-132
	  srformid_t	CastingArtID;
	  srformid_t	HitEffectArtID;
	  srformid_t	ImpactSetID;
	  float			SkillUsageMult;	//0-10
	  srformid_t	DualCastID;		//Unknown11
	  float			DualCastScale;	//0-3
	  srformid_t	EnchantArtID;	//Unknown13
	  dword			NullData1;		//Zero
	  dword			NullData2;		//Zero
	  srformid_t	EquipAbilityID;	//Spell, Unknown16
	  srformid_t	ImageSpaceModID;//Unknown17
	  srformid_t	PerkID;			//Unknown18
	  int			SoundVolume;	//0-3
	  float			ScriptAIDataScore;		//0, 50, 9999, 100000, 1000000
	  float			ScipreAIDataDelay;		//0, 60, 10000, 600000
  };

#pragma pack(pop)
/*===========================================================================
 *		End of Type Definitions
 *=========================================================================*/


/*===========================================================================
 *
 * Begin Class CSrMgefDataSubrecord Definition
 *
 * Description
 *
 *=========================================================================*/
class CSrMgefDataSubrecord : public CSrSubrecord 
{
	DECLARE_SRCLASS(CSrMgefDataSubrecord, CSrSubrecord)

  /*---------- Begin Protected Class Members --------------------*/
protected:
	srmgefdata_t	m_Data;


  /*---------- Begin Protected Class Methods --------------------*/
protected:

		/* Input/output the subrecord data */
	virtual bool ReadData  (CSrFile& File) { memset(&m_Data, 0, sizeof(m_Data)); SR_VERIFY_SUBRECORDSIZE_MAX(SR_MGEFDATA_SUBRECORD_SIZE) return File.Read(&m_Data,  m_RecordSize); }
	virtual bool WriteData (CSrFile& File) { SR_VERIFY_SUBRECORDSIZE_MAX(SR_MGEFDATA_SUBRECORD_SIZE) return File.Write(&m_Data, m_RecordSize); }


  /*---------- Begin Public Class Methods -----------------------*/
public:

		/* Class Constructors/Destructors */
	CSrMgefDataSubrecord() { }
	virtual void Destroy (void) { CSrSubrecord::Destroy(); }
  
   			/* Change any matching formid in the subrecord */
	virtual dword ChangeFormID (const srformid_t NewID, const srformid_t OldID) 
	{
		dword Count = 0;

		if (m_Data.ObjectID == OldID)		 { m_Data.ObjectID = NewID;  ++Count;	}
		if (m_Data.LightID == OldID)		 { m_Data.LightID = NewID;  ++Count; }
		if (m_Data.HitShaderID == OldID)	 { m_Data.HitShaderID = NewID;  ++Count; }
		if (m_Data.EnchantShaderID == OldID) { m_Data.EnchantShaderID = NewID;  ++Count; }
		if (m_Data.ProjectileID == OldID)	 { m_Data.ProjectileID = NewID;  ++Count;	}
		if (m_Data.ExplosionID == OldID) 	 { m_Data.ExplosionID = NewID;  ++Count; }
		if (m_Data.CastingArtID == OldID)	 { m_Data.CastingArtID = NewID;  ++Count;	}
		if (m_Data.HitEffectArtID == OldID)  { m_Data.HitEffectArtID = NewID;  ++Count;	}
		if (m_Data.ImpactSetID == OldID) 	 { m_Data.ImpactSetID = NewID;  ++Count; }
		if (m_Data.DualCastID == OldID) 	 { m_Data.DualCastID = NewID;  ++Count;	}
		if (m_Data.EnchantArtID == OldID)	 { m_Data.EnchantArtID = NewID;  ++Count;	}
		if (m_Data.EquipAbilityID == OldID)  { m_Data.EquipAbilityID = NewID;  ++Count;	}
		if (m_Data.ImageSpaceModID == OldID) { m_Data.ImageSpaceModID = NewID;  ++Count;}
		if (m_Data.PerkID == OldID)			 { m_Data.PerkID = NewID;  ++Count;	}		
		
		return Count; 
	}

	virtual dword CountUses (const srformid_t FormID) 
	{
		return (FormID == m_Data.ImpactSetID) + (FormID == m_Data.CastingArtID) + (FormID == m_Data.EnchantArtID)
				+ (FormID == m_Data.ProjectileID) + (FormID == m_Data.HitShaderID) + (FormID == m_Data.ObjectID)
				+ (FormID == m_Data.EnchantShaderID) + (FormID == m_Data.HitEffectArtID) + (FormID == m_Data.EquipAbilityID)
				+ (FormID == m_Data.ImageSpaceModID) + (FormID == m_Data.PerkID) + (FormID == m_Data.DualCastID)
				+ (FormID == m_Data.ExplosionID) + (FormID == m_Data.LightID);
	}

			/* Fixup the modindex of formids */
	virtual bool FixupFormID (CSrFormidFixupArray& FixupArray) 
	{
		bool Result;
		Result  = SrFixupFormid(m_Data.ObjectID, m_Data.ObjectID, FixupArray);
		Result &= SrFixupFormid(m_Data.LightID, m_Data.LightID, FixupArray);
		Result &= SrFixupFormid(m_Data.HitShaderID, m_Data.HitShaderID, FixupArray);
		Result &= SrFixupFormid(m_Data.EnchantShaderID, m_Data.EnchantShaderID, FixupArray);
		Result &= SrFixupFormid(m_Data.ProjectileID, m_Data.ProjectileID, FixupArray);
		Result &= SrFixupFormid(m_Data.ExplosionID, m_Data.ExplosionID, FixupArray);
		Result &= SrFixupFormid(m_Data.CastingArtID, m_Data.CastingArtID, FixupArray);
		Result &= SrFixupFormid(m_Data.HitEffectArtID, m_Data.HitEffectArtID, FixupArray);
		Result &= SrFixupFormid(m_Data.ImpactSetID, m_Data.ImpactSetID, FixupArray);
		Result &= SrFixupFormid(m_Data.DualCastID, m_Data.DualCastID, FixupArray);
		Result &= SrFixupFormid(m_Data.EnchantArtID, m_Data.EnchantArtID, FixupArray);
		Result &= SrFixupFormid(m_Data.EquipAbilityID, m_Data.EquipAbilityID, FixupArray);
		Result &= SrFixupFormid(m_Data.ImageSpaceModID, m_Data.ImageSpaceModID, FixupArray);
		Result &= SrFixupFormid(m_Data.PerkID, m_Data.PerkID, FixupArray);
		return Result;
	}

 		/* Copy the content from an existing subrecord */
	virtual bool Copy (CSrSubrecord* pSubrecord) 
	{
		CSrMgefDataSubrecord* pSubrecord1 = SrCastClassNull(CSrMgefDataSubrecord, pSubrecord);
		m_RecordSize = SR_MGEFDATA_SUBRECORD_SIZE;

		if (pSubrecord1 != NULL) 
		{
			m_Data = pSubrecord1->GetEffectData();
		}
		else 
		{
		memset(&m_Data, 0, sizeof(m_Data));
		}

		return (true);
	}

  		/* Create a class instance */
	static CSrSubrecord* Create (void) { return (new CSrMgefDataSubrecord); }
	virtual CSrSubrecord* CreateV (void) { return new CSrMgefDataSubrecord; }

		/* Get class members */
	srmgefdata_t& GetEffectData (void) { return (m_Data); }
	virtual byte*	GetData       (void) { return (byte *)(&m_Data); }
    
		/* Initialize a new record */
	void InitializeNew (void) 
	{ 
		CSrSubrecord::InitializeNew(); 
		memset(&m_Data, 0, sizeof(m_Data)); 
		m_RecordSize = SR_MGEFDATA_SUBRECORD_SIZE; 

		m_Data.ActorValue  = -1;
		m_Data.ActorValue2 = -1;
		m_Data.ResistType = 0x27;
		m_Data.School = SR_MAGIC_SCHOOL_ALTERATION;
	}

};
/*===========================================================================
 *		End of Class CSrMgefDataSubrecord Definition
 *=========================================================================*/


#endif
/*===========================================================================
 *		End of File SrMgefDatasubrecord.H
 *=========================================================================*/

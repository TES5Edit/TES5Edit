/*===========================================================================
 *
 * File:		SrRacerecord.H
 * Author:		Dave Humphrey (dave@uesp.net)
 * Created On:	5 December 2011
 *
 * Defines the CSrRaceRecord class.
 *
 *=========================================================================*/
#ifndef __SRRACERECORD_H
#define __SRRACERECORD_H


/*===========================================================================
 *
 * Begin Required Includes
 *
 *=========================================================================*/
	#include "sridkeyrecord.h"
	#include "../subrecords/srlstringsubrecord.h"
	#include "../subrecords/srracedatasubrecord.h"
	#include "../subrecords/srbodtsubrecord.h"
	#include "../subrecords/sratkdsubrecord.h"
	#include "../subrecords/srphwtsubrecord.h"
	#include "../subrecords/srspedsubrecord.h"
	#include "../subrecords/srmpavsubrecord.h"
/*===========================================================================
 *		End of Required Includes
 *=========================================================================*/


/*===========================================================================
 *
 * Begin Type Definitins
 *
 *=========================================================================*/
struct srracemodelinfo_t
{
	CSrDataSubrecord	 Marker;		//MNAM or FNAM
	CSrStringSubrecord*	 pModel;		//ANAM
	CSrDataSubrecord*	 pModt;

	srracemodelinfo_t()
	{
		pModel = NULL;
		pModt = NULL;
	}

	~srracemodelinfo_t()
	{
		delete pModel;
		delete pModt;
	}

	void Destroy (void)
	{
		delete pModel;
		delete pModt;
		pModel = NULL;
		pModt = NULL;
	}

	void CheckNew (void)
	{
		if (pModt)
		{
			if (pModt->GetRecordSize() < 12)
			{
				SystemLog.Printf("Warning: Race MODT in model section has invalid size of %d bytes!", pModt->GetRecordSize());
			}
		}
	}

	void SetModel (const char* pString);

};


struct srraceattackinfo_t
{
	CSrAtkdSubrecord	Data;
	CSrStringSubrecord	Event;

	void CheckNew (void)
	{
		if (Event.GetRecordType() != SR_NAME_ATKE)
		{
			SystemLog.Printf("Warning: Race ATKE subrecord is not initialized!");
			Event.InitializeNew(SR_NAME_ATKE, 0);
		}
	}

	void InitializeNew (void)
	{
		Data.Initialize(SR_NAME_ATKD, SR_ATKD_SUBRECORD_SIZE);
		Data.InitializeNew();
		Event.Initialize(SR_NAME_ATKE, 0);
		Event.InitializeNew();
	}
};


struct srraceegtinfo_t
{
	CSrDataSubrecord	Marker;		//MNAM or FNAM
	CSrDwordSubrecord	Index;
	CSrStringSubrecord	Model;
	CSrDataSubrecord	Modt;

	void CheckNew();
};


struct srracehavokinfo_t
{
	CSrDataSubrecord	Marker;		//MNAM or FNAM
	CSrStringSubrecord	Model;
	CSrDataSubrecord	Modt;

	void CheckNew();
};


struct srracemoveinfo_t
{
	CSrFormidSubrecord	MoveType;
	CSrSpedSubrecord	SpeedData;

	void InitializeNew()
	{
		MoveType.Initialize(SR_NAME_MTYP, 4);
		SpeedData.Initialize(SR_NAME_SPED, SR_SPED_SUBRECORD_SIZE);
		MoveType.InitializeNew();
		SpeedData.InitializeNew();
	}

	void CheckNew()
	{
		if (SpeedData.GetRecordType() != SR_NAME_SPED) 
		{
			SystemLog.Printf("Warning: Race SPED subrecord is not initialized!");
			SpeedData.Initialize(SR_NAME_SPED, SR_SPED_SUBRECORD_SIZE);
		}
	}
};


struct srraceheaddata_t
{
	CSrDwordSubrecord	Index;
	CSrDwordSubrecord	Data;

	void CheckNew()
	{
		if (Data.GetRecordType() != SR_NAME_HEAD)
		{
			SystemLog.Printf("Warning: Race HEAD subrecord is not initialized!");
			Data.Initialize(SR_NAME_HEAD, 4);
		}
	}

	void InitializeNew()
	{
		Index.Initialize(SR_NAME_INDX, 4);
		Data.Initialize(SR_NAME_HEAD, 4);
		Index.InitializeNew();
		Data.InitializeNew();
	}

};


struct srraceheadmpadata_t
{
	CSrDwordSubrecord	Index;
	CSrMpavSubrecord	Data;

	void CheckNew()
	{
		if (Data.GetRecordType() != SR_NAME_MPAV) 
		{
			SystemLog.Printf("Warning: Race MPAV subrecord is not initialized!");
			Data.Initialize(SR_NAME_MPAV, SR_MPAV_SUBRECORD_SIZE);
		}
	}

	void InitializeNew (void)
	{
		Index.Initialize(SR_NAME_MPAI, 4);
		Data.Initialize(SR_NAME_MPAV, SR_MPAV_SUBRECORD_SIZE);
		Index.InitializeNew();
		Data.InitializeNew();
	}
};


struct srraceheadtintdata_t
{
	CSrFormidSubrecord	Tinc;
	CSrFloatSubrecord	Tinv;
	CSrWordSubrecord	Tirs;

	void CheckNew()
	{
		if (Tinv.GetRecordType() != SR_NAME_TINV) 
		{
			SystemLog.Printf("Warning: Race TINV subrecord is not initialized!");
			Tinv.Initialize(SR_NAME_TINV, 4);
		}

		if (Tirs.GetRecordType() != SR_NAME_TIRS) 
		{
			SystemLog.Printf("Warning: Race TIRS subrecord is not initialized!");
			Tirs.Initialize(SR_NAME_TIRS, 2);
		}
	}

	void InitializeNew (void)
	{
		Tinc.Initialize(SR_NAME_TINC, 4);
		Tinv.Initialize(SR_NAME_TINV, 4);
		Tirs.Initialize(SR_NAME_TIRS, 2);
		Tinc.InitializeNew();
		Tinv.InitializeNew();
		Tirs.InitializeNew();
	}
};


typedef CSrPtrArray<srraceheadtintdata_t> CSrRaceHeadTintDataArray;


struct srraceheadtintinfo_t
{
	CSrWordSubrecord	Index;
	CSrStringSubrecord*	pMaskFile;
	CSrWordSubrecord*	pTinp;
	CSrFormidSubrecord*	pColor;

	CSrRaceHeadTintDataArray	Tints;

	srraceheadtintinfo_t()
	{
		pMaskFile = NULL;
		pTinp = NULL;
		pColor = NULL;
	}

	~srraceheadtintinfo_t()
	{
		delete pMaskFile;
		delete pTinp;
		delete pColor;
	}

	void Destroy (void)
	{
		delete pMaskFile;
		delete pTinp;
		delete pColor;

		pMaskFile = NULL;
		pTinp = NULL;
		pColor = NULL;

		Tints.Destroy();
	}

	void CheckNew()
	{
		for (dword i = 0; i < Tints.GetSize(); ++i)
		{
			Tints[i]->CheckNew();
		}
	}

	void InitializeNew()
	{
		Index.Initialize(SR_NAME_TINI, 2);
		Index.InitializeNew();
	}

	void SetMaskFile (const char* pString)
	{
		if (pString == NULL || *pString == '\0')
		{
			delete pMaskFile;
			pMaskFile = NULL;
			return;
		}

		if (pMaskFile == NULL)
		{
			pMaskFile = new CSrStringSubrecord;
			pMaskFile->Initialize(SR_NAME_TINT, 0);
			pMaskFile->InitializeNew();
		}

		pMaskFile->SetString(pString);

	}

	void SetTinp (const char* pString)
	{
		if (pString == NULL || *pString == '\0')
		{
			delete pTinp;
			pTinp = NULL;
			return;
		}

		if (pTinp == NULL)
		{
			pTinp = new CSrWordSubrecord;
			pTinp->Initialize(SR_NAME_TINP, 2);
			pTinp->InitializeNew();
		}

		pTinp->SetValue((word) strtoul(pString, NULL, 0));

	}

	void SetColor (const srformid_t FormID)
	{
		if (FormID == 0)
		{
			delete pColor;
			pColor = NULL;
			return;
		}

		if (pColor == NULL)
		{
			pColor = new CSrFormidSubrecord;
			pColor->Initialize(SR_NAME_TIND, 4);
			pColor->InitializeNew();
		}

		pColor->SetValue(FormID);

	}

};


typedef CSrPtrArray<srraceheadtintinfo_t> CSrRaceHeadTintArray;
typedef CSrPtrArray<srraceheaddata_t>     CSrRaceHeadDataArray;
typedef CSrPtrArray<srraceheadmpadata_t>  CSrRaceHeadMpaArray;
typedef CSrPtrArray<srraceattackinfo_t>   CSrRaceAttackArray;
typedef CSrPtrArray<CSrDwordSubrecord>    CSrRaceMtnmArray;
typedef CSrPtrArray<srracemoveinfo_t>     CSrRaceMoveArray;
typedef CSrPtrArray<CSrStringSubrecord>   CSrRaceStringArray;
typedef CSrPtrArray<CSrFormidSubrecord>   CSrRaceFormidArray;
typedef CSrPtrArray<CSrPhwtSubrecord>     CSrRacePhwtArray;


struct srraceheadinfo_t
{
	CSrDataSubrecord		Name0;
	CSrDataSubrecord		Marker;
	CSrRaceHeadDataArray	HeadData;
	CSrRaceHeadMpaArray		MPAData;

	CSrRaceFormidArray		RacialPresets;
	CSrRaceFormidArray		HairColors;
	CSrRaceFormidArray		FeatureSets;
	CSrFormidSubrecord*		pHeadFeature;
	CSrRaceHeadTintArray	Tints;
	bool					IsMale;

	srraceheadinfo_t(const bool MaleFlag)
	{
		IsMale = MaleFlag;
		pHeadFeature = NULL;
	}

	~srraceheadinfo_t()
	{
		delete pHeadFeature;
	}

	void Destroy (void)
	{
		delete pHeadFeature;
		pHeadFeature = NULL;

		Tints.Destroy();
		RacialPresets.Destroy();
		HairColors.Destroy();
		FeatureSets.Destroy();
		HeadData.Destroy();
		MPAData.Destroy();
	}

	void CheckNew()
	{
		for (dword i = 0; i < Tints.GetSize(); ++i) Tints[i]->CheckNew();
		for (dword i = 0; i < MPAData.GetSize(); ++i) MPAData[i]->CheckNew();
		for (dword i = 0; i < HeadData.GetSize(); ++i) HeadData[i]->CheckNew();
	}

	srraceheadmpadata_t* CreateMpa (void)
	{
		srraceheadmpadata_t* pMpa = MPAData.AddNew();
		pMpa->InitializeNew();
		return pMpa;
	}

	void AddHeadData (const dword Index, const srformid_t FormID)
	{
		if (FormID == 0) return;
		srraceheaddata_t* pHeadData = HeadData.AddNew();
		pHeadData->InitializeNew();
		
		pHeadData->Index.SetValue(Index);
		pHeadData->Data.SetValue(FormID);
	}

	void AddRacePreset (const srformid_t FormID)
	{
		if (FormID == 0) return;
		CSrFormidSubrecord* pFormID = RacialPresets.AddNew();
		pFormID->Initialize(IsMale ? SR_NAME_RPRM : SR_NAME_RPRF, 4);
		pFormID->InitializeNew();
		pFormID->SetValue(FormID);
	}

	void AddHairColor (const srformid_t FormID)
	{
		if (FormID == 0) return;
		CSrFormidSubrecord* pFormID = HairColors.AddNew();
		pFormID->Initialize(IsMale ? SR_NAME_AHCM : SR_NAME_AHCF, 4);
		pFormID->InitializeNew();
		pFormID->SetValue(FormID);
	}

	void AddFeatureSet (const srformid_t FormID)
	{
		if (FormID == 0) return;
		CSrFormidSubrecord* pFormID = FeatureSets.AddNew();
		pFormID->Initialize(IsMale ? SR_NAME_FTSM : SR_NAME_FTSF, 4);
		pFormID->InitializeNew();
		pFormID->SetValue(FormID);
	}


	void SetHeadFeature (const srformid_t FormID)
	{
		if (FormID == 0)
		{
			delete pHeadFeature;
			pHeadFeature = NULL;
			return;
		}

		if (pHeadFeature == NULL)
		{
			pHeadFeature = new CSrFormidSubrecord;
			pHeadFeature->Initialize(IsMale ? SR_NAME_DFTM : SR_NAME_DFTF, 4);
			pHeadFeature->InitializeNew();
		}

		pHeadFeature->SetValue(FormID);
	}

};



struct srraceinfo_t
{
	srracemodelinfo_t		MaleModel;
	srracemodelinfo_t		FemaleModel;

	CSrRaceMtnmArray		MovementNames;
	CSrFormidArraySubrecord	VoiceTypes;
	CSrFormidArraySubrecord	HairColors;
	CSrFormidArraySubrecord	DecapitatedHeads;

	CSrWordSubrecord*		pTinl;
	CSrFloatSubrecord		PName;
	CSrFloatSubrecord		UName;

	CSrRaceAttackArray		Attacks;

	CSrDataSubrecord		Name1;

	srraceegtinfo_t			MaleEgt;
	srraceegtinfo_t			FemaleEgt;

	CSrBodtSubrecord		BodyData;	//GNAM

	CSrDataSubrecord		Name3;

	srracehavokinfo_t		MaleHavok;
	srracehavokinfo_t		FemaleHavok;

	CSrFormidSubrecord*		pMaterial;		//NAM4
	CSrFormidSubrecord*		pImpactData;	//NAM5
	CSrFormidSubrecord*		pBloodFX;		//NAM7
	CSrFormidSubrecord*		pOpenSound;		//ONAM
	CSrFormidSubrecord*		pCloseSound;	//LNAM

	CSrRaceStringArray		BodyNames;
	CSrRaceMoveArray		MovementTypes;
	CSrDwordSubrecord*		pVName;

	CSrRaceFormidArray		EquipSlots;
	CSrFormidSubrecord		UnequipSlot;

	CSrRaceStringArray		FacialKeys;
	CSrRacePhwtArray		FacialWeights;

	CSrDataSubrecord*		pName0M;
	srraceheadinfo_t		MaleHead;
	CSrDataSubrecord*		pName0F;
	srraceheadinfo_t		FemaleHead;

	CSrFormidSubrecord*		pNam8;
	CSrFormidSubrecord*		pRName;
	CSrFormidSubrecord*		pWalkMove;
	CSrFormidSubrecord*		pRunMove;
	CSrFormidSubrecord*		pSwimMove;
	CSrFormidSubrecord*		pFlyMove;
	CSrFormidSubrecord*		pSneakMove;	

	srraceinfo_t() : MaleHead(true), FemaleHead(false)
	{
		pTinl = NULL;
		pMaterial = NULL;	
		pImpactData = NULL;
		pBloodFX = NULL;	
		pOpenSound = NULL;	
		pCloseSound = NULL;
		pVName = NULL;
		pNam8 = NULL;
		pRName = NULL;
		pWalkMove = NULL;
		pRunMove = NULL;
		pSwimMove = NULL;
		pFlyMove = NULL;
		pSneakMove = NULL;	
		pName0M = NULL;
		pName0F = NULL;
	}

	~srraceinfo_t()
	{
		delete pTinl;
		delete pMaterial;	
		delete pImpactData;
		delete pBloodFX;	
		delete pOpenSound;	
		delete pCloseSound;
		delete pVName;
		delete pNam8;
		delete pRName;
		delete pWalkMove;
		delete pRunMove;
		delete pSwimMove;
		delete pFlyMove;
		delete pSneakMove;	
		delete pName0M;
		delete pName0F;
	}

	void Destroy (void)
	{
		delete pTinl;
		delete pMaterial;	
		delete pImpactData;
		delete pBloodFX;	
		delete pOpenSound;	
		delete pCloseSound;
		delete pVName;
		delete pNam8;
		delete pRName;
		delete pWalkMove;
		delete pRunMove;
		delete pSwimMove;
		delete pFlyMove;
		delete pSneakMove;	
		delete pName0M;
		delete pName0F;

		pTinl = NULL;
		pMaterial = NULL;	
		pImpactData = NULL;
		pBloodFX = NULL;	
		pOpenSound = NULL;	
		pCloseSound = NULL;
		pVName = NULL;
		pNam8 = NULL;
		pRName = NULL;
		pWalkMove = NULL;
		pRunMove = NULL;
		pSwimMove = NULL;
		pFlyMove = NULL;
		pSneakMove = NULL;	
		pName0M = NULL;
		pName0F = NULL;

		MaleModel.Destroy();
		FemaleModel.Destroy();
		FacialKeys.Destroy();
		FacialWeights.Destroy();
		EquipSlots.Destroy();
		MaleHead.Destroy();
		FemaleHead.Destroy();
		BodyNames.Destroy();
		MovementTypes.Destroy();
		Attacks.Destroy();
		MovementTypes.Destroy();
		VoiceTypes.Destroy();
		HairColors.Destroy();
		MovementNames.Destroy();
		DecapitatedHeads.Destroy();
	}

	void CheckMaleHeadMarker (void)
	{
		if (pName0M != NULL) return;
		int Count = 0;

		Count += MaleHead.FeatureSets.GetSize();
		Count += MaleHead.HairColors.GetSize();
		Count += MaleHead.RacialPresets.GetSize();
		Count += MaleHead.pHeadFeature != NULL;
		Count += MaleHead.MPAData.GetSize();
		Count += MaleHead.HeadData.GetSize();
		Count += MaleHead.Tints.GetSize();

		if (Count == 0) return;

		pName0M = new CSrDataSubrecord;
		pName0M->Initialize(SR_NAME_NAM0, 0);
		pName0M->InitializeNew();
	}

	void CheckFemaleHeadMarker (void)
	{
		if (pName0F != NULL) return;
		int Count = 0;

		Count += FemaleHead.FeatureSets.GetSize();
		Count += FemaleHead.HairColors.GetSize();
		Count += FemaleHead.RacialPresets.GetSize();
		Count += FemaleHead.pHeadFeature != NULL;
		Count += FemaleHead.MPAData.GetSize();
		Count += FemaleHead.HeadData.GetSize();
		Count += FemaleHead.Tints.GetSize();

		if (Count == 0) return;

		pName0F = new CSrDataSubrecord;
		pName0F->Initialize(SR_NAME_NAM0, 0);
		pName0F->InitializeNew();
	}

	void CheckNew()
	{
		MaleModel.CheckNew();
		FemaleModel.CheckNew();

		if (MovementNames.GetSize() != 5)
		{
			SystemLog.Printf("Warning: Race array MovementNames[] expected to be size 5 not %d!", MovementNames.GetSize());
		}
		
		if (VoiceTypes.GetArraySize() != 0 && VoiceTypes.GetArraySize() != 2)
		{
			SystemLog.Printf("Warning: Race array VoiceTypes[] should be size 0 or 2 not %d!", VoiceTypes.GetArraySize());
			VoiceTypes.ForceArraySize(2);
		}

		if (HairColors.GetArraySize() != 0 && HairColors.GetArraySize() != 2 )
		{
			SystemLog.Printf("Warning: Race array HairColors[] should be size 0 or 2 not %d!", HairColors.GetArraySize());
			HairColors.ForceArraySize(2);
		}

		if (DecapitatedHeads.GetArraySize() != 0 && DecapitatedHeads.GetArraySize() != 2)
		{
			SystemLog.Printf("Warning: Race array DecapitatedHeads[] should be size 0 or 2 not %d!", DecapitatedHeads.GetArraySize());
			DecapitatedHeads.ForceArraySize(2);
		}
		
		if (PName.GetRecordType() != SR_NAME_PNAM)
		{
			SystemLog.Printf("Warning: Race PNAM subrecord not initialized!");
			PName.Initialize(SR_NAME_PNAM, 4);
			PName.SetValue(5);
		}

		if (UName.GetRecordType() != SR_NAME_UNAM)
		{
			SystemLog.Printf("Warning: Race UNAM subrecord not initialized!");
			UName.Initialize(SR_NAME_UNAM, 4);
			UName.SetValue(3);
		}

		for (dword i = 0; i < Attacks.GetSize(); ++i) Attacks[i]->CheckNew();
						
		MaleEgt.CheckNew();
		FemaleEgt.CheckNew();
		
		if (BodyData.GetRecordType() != SR_NAME_GNAM)
		{
			SystemLog.Printf("Warning: Race GNAM subrecord not initialized!");
			BodyData.Initialize(SR_NAME_GNAM, SR_BODT_SUBRECORD_SIZE);
		}
		
		MaleHavok.CheckNew();
		FemaleHavok.CheckNew();		
		
		if (BodyNames.GetSize() != 32)
		{
			SystemLog.Printf("Warning: Race array NAME[] should be size 32 not %d!", BodyNames.GetSize());
			
			while (BodyNames.GetSize() > 32) BodyNames.Delete(BodyNames.GetSize() - 1);
			while (BodyNames.GetSize() < 32) BodyNames.AddNew()->Initialize(SR_NAME_NAME, 0);			
		}

		for (dword i = 0; i < MovementTypes.GetSize(); ++i) MovementTypes[i]->CheckNew();
		
		if (UnequipSlot.GetRecordType() != SR_NAME_UNES)
		{
			SystemLog.Printf("Warning: Race UNES subrecord is not initialized!");
			UnequipSlot.Initialize(SR_NAME_UNES, 4);
			UnequipSlot.SetValue(0);
		}		
	
		if (pName0M) MaleHead.CheckNew();
		if (pName0F) FemaleHead.CheckNew();		
	}

	void SetTinl (const char* pString)
	{
		if (pString == NULL || *pString == '\0')
		{
			delete pTinl;
			pTinl = NULL;
			return;
		}

		if (pTinl == NULL)
		{
			pTinl = new CSrWordSubrecord;
			pTinl->Initialize(SR_NAME_TINL, 2);
			pTinl->InitializeNew();
		}

		pTinl->SetValue((word) atoi(pString));
	}

	void SetVName (const char* pString)
	{
		if (pString == NULL || *pString == '\0')
		{
			delete pVName;
			pVName = NULL;
			return;
		}

		if (pVName == NULL)
		{
			pVName = new CSrDwordSubrecord;
			pVName->Initialize(SR_NAME_VNAM, 4);
			pVName->InitializeNew();
		}

		pVName->SetValue(strtoul(pString, NULL, 0));
	}

	void SetWalkMove (const srformid_t FormID)
	{
		if (FormID == 0)
		{
			delete pWalkMove;
			pWalkMove = NULL;
			return;
		}

		if (pWalkMove == NULL)
		{
			pWalkMove = new CSrFormidSubrecord;
			pWalkMove->Initialize(SR_NAME_WKMV, 4);
			pWalkMove->InitializeNew();
		}

		pWalkMove->SetValue(FormID);
	}

	void SetRunMove (const srformid_t FormID)
	{
		if (FormID == 0)
		{
			delete pRunMove;
			pRunMove = NULL;
			return;
		}

		if (pRunMove == NULL)
		{
			pRunMove = new CSrFormidSubrecord;
			pRunMove->Initialize(SR_NAME_RNMV, 4);
			pRunMove->InitializeNew();
		}

		pRunMove->SetValue(FormID);
	}

	void SetSwimMove (const srformid_t FormID)
	{
		if (FormID == 0)
		{
			delete pSwimMove;
			pSwimMove = NULL;
			return;
		}

		if (pSwimMove == NULL)
		{
			pSwimMove = new CSrFormidSubrecord;
			pSwimMove->Initialize(SR_NAME_SWMV, 4);
			pSwimMove->InitializeNew();
		}

		pSwimMove->SetValue(FormID);
	}

	void SetFlyMove (const srformid_t FormID)
	{
		if (FormID == 0)
		{
			delete pFlyMove;
			pFlyMove = NULL;
			return;
		}

		if (pFlyMove == NULL)
		{
			pFlyMove = new CSrFormidSubrecord;
			pFlyMove->Initialize(SR_NAME_FLMV, 4);
			pFlyMove->InitializeNew();
		}

		pFlyMove->SetValue(FormID);
	}

	void SetSneakMove (const srformid_t FormID)
	{
		if (FormID == 0)
		{
			delete pSneakMove;
			pSneakMove = NULL;
			return;
		}

		if (pSneakMove == NULL)
		{
			pSneakMove = new CSrFormidSubrecord;
			pSneakMove->Initialize(SR_NAME_SNMV, 4);
			pSneakMove->InitializeNew();
		}

		pSneakMove->SetValue(FormID);
	}

	void SetMaterial (const srformid_t FormID)
	{
		if (FormID == 0)
		{
			delete pMaterial;
			pMaterial = NULL;
			return;
		}

		if (pMaterial == NULL)
		{
			pMaterial = new CSrFormidSubrecord;
			pMaterial->Initialize(SR_NAME_NAM4, 4);
			pMaterial->InitializeNew();
		}

		pMaterial->SetValue(FormID);
	}

	void SetImpactSet (const srformid_t FormID)
	{
		if (FormID == 0)
		{
			delete pImpactData;
			pImpactData = NULL;
			return;
		}

		if (pImpactData == NULL)
		{
			pImpactData = new CSrFormidSubrecord;
			pImpactData->Initialize(SR_NAME_NAM5, 4);
			pImpactData->InitializeNew();
		}

		pImpactData->SetValue(FormID);
	}

	void SetBloodFX (const srformid_t FormID)
	{
		if (FormID == 0)
		{
			delete pBloodFX;
			pBloodFX = NULL;
			return;
		}

		if (pBloodFX == NULL)
		{
			pBloodFX = new CSrFormidSubrecord;
			pBloodFX->Initialize(SR_NAME_NAM7, 4);
			pBloodFX->InitializeNew();
		}

		pBloodFX->SetValue(FormID);
	}

	void SetOpenSound (const srformid_t FormID)
	{
		if (FormID == 0)
		{
			delete pOpenSound;
			pOpenSound = NULL;
			return;
		}

		if (pOpenSound == NULL)
		{
			pOpenSound = new CSrFormidSubrecord;
			pOpenSound->Initialize(SR_NAME_ONAM, 4);
			pOpenSound->InitializeNew();
		}

		pOpenSound->SetValue(FormID);
	}

	void SetCloseSound (const srformid_t FormID)
	{
		if (FormID == 0)
		{
			delete pCloseSound;
			pCloseSound = NULL;
			return;
		}

		if (pCloseSound == NULL)
		{
			pCloseSound = new CSrFormidSubrecord;
			pCloseSound->Initialize(SR_NAME_LNAM, 4);
			pCloseSound->InitializeNew();
		}

		pCloseSound->SetValue(FormID);
	}

	void SetName8 (const srformid_t FormID)
	{
		if (FormID == 0)
		{
			delete pNam8;
			pNam8 = NULL;
			return;
		}

		if (pNam8 == NULL)
		{
			pNam8 = new CSrFormidSubrecord;
			pNam8->Initialize(SR_NAME_NAM8, 4);
			pNam8->InitializeNew();
		}

		pNam8->SetValue(FormID);
	}

	void SetRName (const srformid_t FormID)
	{
		if (FormID == 0)
		{
			delete pRName;
			pRName = NULL;
			return;
		}

		if (pRName == NULL)
		{
			pRName = new CSrFormidSubrecord;
			pRName->Initialize(SR_NAME_RNAM, 4);
			pRName->InitializeNew();
		}

		pRName->SetValue(FormID);
	}

	void AddEquipSlot (const srformid_t FormID)
	{
		CSrFormidSubrecord* pFormID = EquipSlots.AddNew();
		pFormID->Initialize(SR_NAME_QNAM, 4);
		pFormID->InitializeNew();
		pFormID->SetValue(FormID);
	}

};

/*===========================================================================
 *		End Type Definitins
 *=========================================================================*/


/*===========================================================================
 *
 * Begin Class CSrRaceRecord Definition
 *
 *=========================================================================*/
class CSrRaceRecord : public CSrIdKeyRecord 
{
	DECLARE_SRSUBRECCREATE()
	DECLARE_SRFIELDMAP()
	DECLARE_SRCLASS(CSrRaceRecord, CSrIdKeyRecord)

  /*---------- Begin Protected Class Members --------------------*/
protected:
	CSrLStringSubrecord*	m_pDescription;
	CSrLStringSubrecord*	m_pItemName;
	CSrDwordSubrecord*		m_pSpellCount;
	CSrFormidSubrecord*		m_pNakedArmor;
	CSrBodtSubrecord*		m_pBodyData;
	CSrRaceDataSubrecord*	m_pRaceData;

	CSString				m_BodyPartsString;


	static srracedata_t s_NullRaceData;
	static srbodtdata_t s_NullBodtData;


  /*---------- Begin Protected Class Methods --------------------*/
protected:


  /*---------- Begin Public Class Methods -----------------------*/
public:

		/* Class Constructors/Destructors */
	CSrRaceRecord();
	virtual void Destroy (void);

	CSrFormidSubrecord* AddSpell (const srformid_t FormID);

    	/* Return a new instance of the class */
	static CSrRecord* Create (void) { return new CSrRaceRecord; }

	bool CreateRaceInfo     (srraceinfo_t& RaceInfo);
	bool CreateFromRaceInfo (srraceinfo_t& RaceInfo);

		/* Get class members */
	dword         GetSpellCount (void) { return m_pSpellCount ? m_pSpellCount->GetValue() : 0; }
	srracedata_t& GetRaceData   (void) { return m_pRaceData ? m_pRaceData->GetRaceData() : s_NullRaceData; } 
	srbodtdata_t& GetBodyData   (void) { return m_pBodyData ? m_pBodyData->GetBodtData() : s_NullBodtData; }

	const char* GetBodyParts (void) { m_BodyPartsString = GetSrBodyPartFlagString(GetBodyData().BodyParts); return m_BodyPartsString.c_str(); }

	const char* GetRaceSkillAV    (const dword Index) { return (Index < SR_RACE_MAXSKILLINDEX) ? GetSrActorValueString((int)(char)GetRaceData().Skills[Index].ActorValue) : ""; }
	byte        GetRaceSkillValue (const dword Index) { return (Index < SR_RACE_MAXSKILLINDEX) ? GetRaceData().Skills[Index].Value: 0; }
	const char* GetRaceSkillAV1   (void) { return GetRaceSkillAV(0); }
	const char* GetRaceSkillAV2   (void) { return GetRaceSkillAV(1); }
	const char* GetRaceSkillAV3   (void) { return GetRaceSkillAV(2); }
	const char* GetRaceSkillAV4   (void) { return GetRaceSkillAV(3); }
	const char* GetRaceSkillAV5   (void) { return GetRaceSkillAV(4); }
	const char* GetRaceSkillAV6   (void) { return GetRaceSkillAV(5); }
	const char* GetRaceSkillAV7   (void) { return GetRaceSkillAV(6); }

		/* Initialize a new record */
	void InitializeNew (void);

	static void InitializeDwordData   (CSrSubrecord* pSubrecord, const dword Value);
	static void InitializeFloatData   (CSrSubrecord* pSubrecord, const float Value);
	static void InitializeModtData    (CSrSubrecord* pSubrecord);
	static void InitializeFormid2Data (CSrSubrecord* pSubrecord);


		/* Called to alert record of a new subrecord being added */
	virtual void OnAddSubrecord    (CSrSubrecord* pSubrecord);
	virtual void OnDeleteSubrecord (CSrSubrecord* pSubrecord);

		/* Set class members */
	void SetBodyParts   (const char* pString) { GetSrBodyPartFlagValue(GetBodyData().BodyParts, pString); }

	void SetRaceSkillAV    (const dword Index, const char* pString) { int Value = -1; if (Index < SR_RACE_MAXSKILLINDEX) { GetSrActorValueValue(Value, pString); GetRaceData().Skills[Index].ActorValue = (byte) Value; } }
	void SetRaceSkillValue (const dword Index, const byte    Value) { if (Index < SR_RACE_MAXSKILLINDEX) GetRaceData().Skills[Index].Value = Value; }
	void SetRaceSkillAV1   (const char* pString) { SetRaceSkillAV(0, pString); }
	void SetRaceSkillAV2   (const char* pString) { SetRaceSkillAV(1, pString); }
	void SetRaceSkillAV3   (const char* pString) { SetRaceSkillAV(2, pString); }
	void SetRaceSkillAV4   (const char* pString) { SetRaceSkillAV(3, pString); }
	void SetRaceSkillAV5   (const char* pString) { SetRaceSkillAV(4, pString); }
	void SetRaceSkillAV6   (const char* pString) { SetRaceSkillAV(5, pString); }
	void SetRaceSkillAV7   (const char* pString) { SetRaceSkillAV(6, pString); }	

	void UpdateSpellCount (void);

		/* Begin field method definitions */
	DECLARE_SRFIELD_DESCRIPTION(CSrRaceRecord, SR_NAME_DESC)
	DECLARE_SRFIELD_ITEMNAME(CSrRaceRecord)
	DECLARE_SRFIELD_EDITORID1(CSrRaceRecord, NakedArmor, SR_NAME_WNAM)
	DECLARE_SRFIELD_METHOD(CSrRaceRecord, BodyParts, GetBodyParts, SetBodyParts)
	DECLARE_SRFIELD_DWORD1(CSrRaceRecord, SpellCount, GetSpellCount(), dword Tmp)

	DECLARE_SRFIELD_METHOD(CSrRaceRecord, ActorValue1, GetRaceSkillAV1, SetRaceSkillAV1)
	DECLARE_SRFIELD_METHOD(CSrRaceRecord, ActorValue2, GetRaceSkillAV2, SetRaceSkillAV2)
	DECLARE_SRFIELD_METHOD(CSrRaceRecord, ActorValue3, GetRaceSkillAV3, SetRaceSkillAV3)
	DECLARE_SRFIELD_METHOD(CSrRaceRecord, ActorValue4, GetRaceSkillAV4, SetRaceSkillAV4)
	DECLARE_SRFIELD_METHOD(CSrRaceRecord, ActorValue5, GetRaceSkillAV5, SetRaceSkillAV5)
	DECLARE_SRFIELD_METHOD(CSrRaceRecord, ActorValue6, GetRaceSkillAV6, SetRaceSkillAV6)
	DECLARE_SRFIELD_METHOD(CSrRaceRecord, ActorValue7, GetRaceSkillAV7, SetRaceSkillAV7)

	DECLARE_SRFIELD_BYTE1(CSrRaceRecord, Skill1,      GetRaceData().Skills[0].Value,      GetRaceData().Skills[0].Value)
	DECLARE_SRFIELD_BYTE1(CSrRaceRecord, Skill2,      GetRaceData().Skills[1].Value,      GetRaceData().Skills[1].Value)
	DECLARE_SRFIELD_BYTE1(CSrRaceRecord, Skill3,      GetRaceData().Skills[2].Value,      GetRaceData().Skills[2].Value)
	DECLARE_SRFIELD_BYTE1(CSrRaceRecord, Skill4,      GetRaceData().Skills[3].Value,      GetRaceData().Skills[3].Value)
	DECLARE_SRFIELD_BYTE1(CSrRaceRecord, Skill5,      GetRaceData().Skills[4].Value,      GetRaceData().Skills[4].Value)
	DECLARE_SRFIELD_BYTE1(CSrRaceRecord, Skill6,      GetRaceData().Skills[5].Value,      GetRaceData().Skills[5].Value)
	DECLARE_SRFIELD_BYTE1(CSrRaceRecord, Skill7,      GetRaceData().Skills[6].Value,      GetRaceData().Skills[6].Value)

	DECLARE_SRFIELD_FLOAT1(CSrRaceRecord, MaleHeight, GetRaceData().MaleHeight, GetRaceData().MaleHeight)
	DECLARE_SRFIELD_FLOAT1(CSrRaceRecord, FemaleHeight, GetRaceData().FemaleHeight, GetRaceData().FemaleHeight)

	DECLARE_SRFIELD_FLOAT1(CSrRaceRecord, Unknown1,  GetRaceData().Unknown1,  GetRaceData().Unknown1)
	DECLARE_SRFIELD_FLOAT1(CSrRaceRecord, Unknown2,  GetRaceData().Unknown2,  GetRaceData().Unknown2)
	DECLARE_SRFIELD_DWORDFLAG1(CSrRaceRecord, Unknown3,  GetRaceData().Unknown3,  GetRaceData().Unknown3)
	DECLARE_SRFIELD_FLOAT1(CSrRaceRecord, Unknown4,  GetRaceData().Unknown4,  GetRaceData().Unknown4)
	DECLARE_SRFIELD_FLOAT1(CSrRaceRecord, Unknown5,  GetRaceData().Unknown5,  GetRaceData().Unknown5)
	DECLARE_SRFIELD_FLOAT1(CSrRaceRecord, Unknown6,  GetRaceData().Unknown6,  GetRaceData().Unknown6)
	DECLARE_SRFIELD_FLOAT1(CSrRaceRecord, Unknown7,  GetRaceData().Unknown7,  GetRaceData().Unknown7)
	DECLARE_SRFIELD_FLOAT1(CSrRaceRecord, Unknown8,  GetRaceData().Unknown8,  GetRaceData().Unknown8)
	DECLARE_SRFIELD_FLOAT1(CSrRaceRecord, Unknown9,  GetRaceData().Unknown9,  GetRaceData().Unknown9)
	DECLARE_SRFIELD_FLOAT1(CSrRaceRecord, Unknown10, GetRaceData().Unknown10,  GetRaceData().Unknown10)
	DECLARE_SRFIELD_INT1(CSrRaceRecord, Unknown11, GetRaceData().Unknown11, GetRaceData().Unknown11)
	DECLARE_SRFIELD_INT1(CSrRaceRecord, Unknown12, GetRaceData().Unknown12, GetRaceData().Unknown12)
	DECLARE_SRFIELD_INT1(CSrRaceRecord, Unknown13, GetRaceData().Unknown13, GetRaceData().Unknown13)
	DECLARE_SRFIELD_FLOAT1(CSrRaceRecord, Unknown14, GetRaceData().Unknown14, GetRaceData().Unknown14)
	DECLARE_SRFIELD_INT1(CSrRaceRecord, Unknown15, GetRaceData().Unknown15, GetRaceData().Unknown15)
	DECLARE_SRFIELD_FLOAT1(CSrRaceRecord, Unknown16, GetRaceData().Unknown16, GetRaceData().Unknown16)
	DECLARE_SRFIELD_FLOAT1(CSrRaceRecord, Unknown17, GetRaceData().Unknown17, GetRaceData().Unknown17)
	DECLARE_SRFIELD_FLOAT1(CSrRaceRecord, Unknown18, GetRaceData().Unknown18, GetRaceData().Unknown18)
	DECLARE_SRFIELD_FLOAT1(CSrRaceRecord, Unknown19, GetRaceData().Unknown19, GetRaceData().Unknown19)
	DECLARE_SRFIELD_FLOAT1(CSrRaceRecord, Unknown20, GetRaceData().Unknown20, GetRaceData().Unknown20)
	DECLARE_SRFIELD_INT1(CSrRaceRecord, Unknown21, GetRaceData().Unknown21, GetRaceData().Unknown21)
	DECLARE_SRFIELD_FLOAT1(CSrRaceRecord, Unknown22, GetRaceData().Unknown22, GetRaceData().Unknown22)
	DECLARE_SRFIELD_FLOAT1(CSrRaceRecord, Unknown23, GetRaceData().Unknown23, GetRaceData().Unknown23)
	DECLARE_SRFIELD_FLOAT1(CSrRaceRecord, Unknown24, GetRaceData().Unknown24, GetRaceData().Unknown24)
	DECLARE_SRFIELD_FLOAT1(CSrRaceRecord, Unknown25, GetRaceData().Unknown25, GetRaceData().Unknown25)
	DECLARE_SRFIELD_INT1(CSrRaceRecord, Unknown26, GetRaceData().Unknown26, GetRaceData().Unknown26)

};
/*===========================================================================
 *		End of Class CSrRaceRecord Definition
 *=========================================================================*/


#endif
/*===========================================================================
 *		End of File SrRaceRecord.H
 *=========================================================================*/

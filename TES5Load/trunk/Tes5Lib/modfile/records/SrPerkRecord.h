/*===========================================================================
 *
 * File:		SrPerkrecord.H
 * Author:		Dave Humphrey (dave@uesp.net)
 * Created On:	5 December 2011
 *
 * Defines the CSrPerkRecord class.
 *
 *=========================================================================*/
#ifndef __SRPERKRECORD_H
#define __SRPERKRECORD_H


/*===========================================================================
 *
 * Begin Required Includes
 *
 *=========================================================================*/
	#include "sridrecord.h"
	#include "../subrecords/srlstringsubrecord.h"
	#include "../subrecords/srbytesubrecord.h"
	#include "../subrecords/srctdasubrecord.h"
	#include "../subrecords/srperkdatasubrecord.h"
	#include "../subrecords/srprkesubrecord.h"
	#include "../subrecords/srepfdsubrecord.h"
	#include "../subrecords/srarraysubrecord.h"
	#include "../subrecords/srvmadsubrecord.h"
/*===========================================================================
 *		End of Required Includes
 *=========================================================================*/


/*===========================================================================
 *
 * Begin Type Definitions
 *
 *=========================================================================*/

struct srperksectioninfo_t
{
	CSrPrkeSubrecord		Prke;
	CSrPerkDataSubrecord	Data;
	CSrConditionArray		Conditions;
	CSrByteSubrecord*		pEpft;
	CSrLStringSubrecord*	pEpf2;
	CSrDwordSubrecord*		pEpf3;
	CSrEpfdSubrecord*		pEpfd;
	CSrDataSubrecord		Prkf;

	srperksectioninfo_t()
	{
		pEpft = NULL;
		pEpf2 = NULL;
		pEpf3 = NULL;
		pEpfd = NULL;

		InitializeNew();
	}

	~srperksectioninfo_t()
	{
		delete pEpft;
		delete pEpf2;
		delete pEpf3;
		delete pEpfd;
	}

	void Destroy()
	{
		delete pEpft;
		delete pEpf2;
		delete pEpf3;
		delete pEpfd;

		pEpft = NULL;
		pEpf2 = NULL;
		pEpf3 = NULL;
		pEpfd = NULL;

		Conditions.Destroy();
	}

	dword CountSubsections (const dword PrkcType)
	{
		dword Count = 0;

		for (dword i = 0; i < Conditions.GetSize(); ++i)
		{
			if (PrkcType == Conditions[i]->Condition.GetPrkc()) ++Count;
		}

		return Count;
	}

	dword CountConditions ()
	{
		return Conditions.GetSize();
	}

	void InitializeNew (void)
	{
		pEpft = NULL;
		pEpf2 = NULL;
		pEpf3 = NULL;
		pEpfd = NULL;

		Prke.Initialize(SR_NAME_PRKE, 3);
		Prke.InitializeNew();

		Data.Initialize(SR_NAME_DATA, 4);
		Data.SetDataType(SR_PERKDATA_TYPE01);
		Data.InitializeNew();

		//Epft.Initialize(SR_NAME_EPFT, 1);
		//Epft.InitializeNew();
		//Epft.SetValue(SP_EPFDTYPE_ONEFLOAT);

		//Epfd.Initialize(SR_NAME_EPFD, 4);
		//Epfd.InitializeNew();
		//Epfd.SetDataType(SP_EPFDTYPE_ONEFLOAT);

		Prkf.Initialize(SR_NAME_PRKF, 0);
		Prkf.InitializeNew();
	}
		
	void CreateNewEpft (void)
	{
		if (pEpft) delete pEpft;
		pEpft = new CSrByteSubrecord;

		pEpft->Initialize(SR_NAME_EPFT, 1);
		pEpft->InitializeNew();
		pEpft->SetValue(SP_EPFDTYPE_ONEFLOAT);
	}

	void CreateNewEpf2 (void)
	{
		if (pEpf2) delete pEpf2;
		pEpf2 = new CSrLStringSubrecord;

		pEpf2->Initialize(SR_NAME_EPF2, 0);
		pEpf2->InitializeNew();
	}

	void CreateNewEpf3 (void)
	{
		if (pEpf3) delete pEpf3;
		pEpf3 = new CSrDwordSubrecord;

		pEpf3->Initialize(SR_NAME_EPF3, 4);
		pEpf3->InitializeNew();
	}

	void CreateNewEpfd (void)
	{
		if (pEpfd) delete pEpft;
		pEpfd = new CSrEpfdSubrecord;

		pEpfd->Initialize(SR_NAME_EPFD, 4);
		pEpfd->InitializeNew();
		pEpfd->SetDataType(SP_EPFDTYPE_ONEFLOAT);
	}

};

typedef CSrPtrArray<srperksectioninfo_t> CSrPerkSectionArray;

/*===========================================================================
 *		End of Type Definitions
 *=========================================================================*/


/*===========================================================================
 *
 * Begin Class CSrPerkRecord Definition
 *
 *
 PRKE-0
 DATA-0
 PRKF

 PRKE-1
 DATA-1
 PRKF

 PRKE-2
 DATA-2
	PRKC
	CTDA
	CIS1
	CIS2
 EPFT
 EPFD
 EPF2
 EPF3
 PRKF

 *=========================================================================*/
class CSrPerkRecord : public CSrIdRecord 
{
	DECLARE_SRSUBRECCREATE()
	DECLARE_SRFIELDMAP()
	DECLARE_SRCLASS(CSrPerkRecord, CSrIdRecord)

  /*---------- Begin Protected Class Members --------------------*/
protected:
	CSrLStringSubrecord*	m_pDescription;
	CSrLStringSubrecord*	m_pItemName;
	CSrPerkDataSubrecord*	m_pPerkData;
	CSrFormidSubrecord*		m_pNextPerk;

	CSrArraySubrecord*		m_pCurrentSection;
	CSrArraySubrecord*		m_pCurrentSubSection;

	CSrByteSubrecord*		m_pLastEPFT;

	static srperkdata_t s_NullPerkData;


  /*---------- Begin Protected Class Methods --------------------*/
protected:

	bool CreateInfo (srperksectioninfo_t& PerkInfo, const dword Index);


  /*---------- Begin Public Class Methods -----------------------*/
public:

		/* Class Constructors/Destructors */
	CSrPerkRecord();
	virtual void Destroy (void);

    	/* Return a new instance of the class */
	static CSrRecord* Create (void) { return new CSrPerkRecord; }

	bool CreateInfo     (CSrPerkSectionArray& PerkInfoArray);
	bool CreateFromInfo (CSrPerkSectionArray& PerkInfoArray);

		/* Get class members */
	srperkdata_t& GetPerkData       (void) { return m_pPerkData ? m_pPerkData->GetPerkData() : s_NullPerkData; }  
	dword         CountPerkSections (void) { return CountSubrecords(SR_NAME_PRKE); }

		/* Only count the base conditions and not the section conditions */
	dword GetBaseConditionCount (void);

	const char* GetDataUnknown1 (void) { return GetSrPerkDataUnknown1TypeString((int) GetPerkData().Unknown1); }
	const char* GetDataUnknown2 (void) { return GetSrPerkDataUnknown2TypeString((int) GetPerkData().Unknown2); }
	const char* GetDataUnknown3 (void) { return GetSrPerkDataUnknown3TypeString((int) GetPerkData().Unknown3); }

		/* Initialize a new record */
	void InitializeNew (void);

		/* Called to alert record of a new subrecord being added */
	virtual void OnAddSubrecord    (CSrSubrecord* pSubrecord);
	virtual void OnDeleteSubrecord (CSrSubrecord* pSubrecord);

	void SetDataUnknown1 (const char* pString) { int Value(1); GetSrPerkDataUnknown1TypeValue(Value, pString); GetPerkData().Unknown1 = Value; }
	void SetDataUnknown2 (const char* pString) { int Value(1); GetSrPerkDataUnknown2TypeValue(Value, pString); GetPerkData().Unknown2 = Value; }
	void SetDataUnknown3 (const char* pString) { int Value(1); GetSrPerkDataUnknown3TypeValue(Value, pString); GetPerkData().Unknown3 = Value; }


		/* Begin field method definitions */
	DECLARE_SRFIELD_FULLNAME(CSrPerkRecord)
	DECLARE_SRFIELD_DESCRIPTION(CSrPerkRecord, SR_NAME_DESC)
	DECLARE_SRFIELD_EDITORID1(CSrPerkRecord, NextPerk, SR_NAME_NNAM)

	DECLARE_SRFIELD_METHOD(CSrPerkRecord, Unknown1, GetDataUnknown1, SetDataUnknown1)
	DECLARE_SRFIELD_METHOD(CSrPerkRecord, Unknown2, GetDataUnknown2, SetDataUnknown2)
	DECLARE_SRFIELD_METHOD(CSrPerkRecord, Unknown3, GetDataUnknown3, SetDataUnknown3)

	DECLARE_SRFIELD_DWORD1(CSrPerkRecord, PerkSections, CountPerkSections(), dword Tmp)
	DECLARE_SRFIELD_DWORD1(CSrPerkRecord, ConditionCount, GetBaseConditionCount(), dword Tmp)

};
/*===========================================================================
 *		End of Class CSrPerkRecord Definition
 *=========================================================================*/


#endif
/*===========================================================================
 *		End of File SrPerkRecord.H
 *=========================================================================*/

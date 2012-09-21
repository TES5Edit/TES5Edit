/*===========================================================================
 *
 * File:		SrAvifrecord.H
 * Author:		Dave Humphrey (dave@uesp.net)
 * Created On:	5 December 2011
 *
 * Defines the CSrAvifRecord class.
 *
 *=========================================================================*/
#ifndef __SRAVIFRECORD_H
#define __SRAVIFRECORD_H


/*===========================================================================
 *
 * Begin Required Includes
 *
 *=========================================================================*/
	#include "sridrecord.h"
	#include "../subrecords/srlstringsubrecord.h"
	#include "../subrecords/sravsksubrecord.h"	
/*===========================================================================
 *		End of Required Includes
 *=========================================================================*/


typedef CSrPtrArray<CSrDwordSubrecord> CSrAvifCnamArray;

struct sravifsection_t
{
	CSrFormidSubrecord	PName;
	CSrDwordSubrecord	FName;
	CSrDwordSubrecord	XName;
	CSrDwordSubrecord	YName;
	CSrFloatSubrecord	HName;
	CSrFloatSubrecord	VName;
	CSrFormidSubrecord	SName;
	CSrAvifCnamArray	CNames;
	CSrDwordSubrecord	IName;

	void Destroy()
	{
		CNames.Destroy();
	}

	CSrDwordSubrecord* AddCName (const dword Value)
	{
		CSrDwordSubrecord* pCName = CNames.AddNew();
		pCName->Initialize(SR_NAME_CNAM, 4);
		pCName->InitializeNew();
		pCName->SetValue(Value);
		return pCName;
	}

	void CheckNew()
	{
		if (PName.GetRecordType() != SR_NAME_PNAM)
		{
			SystemLog.Printf("Warning: AVIF section is missing a valid PNAM subrecord!");
			PName.Initialize(SR_NAME_PNAM, 4);
			PName.InitializeNew();
		}

		if (FName.GetRecordType() != SR_NAME_FNAM)
		{
			SystemLog.Printf("Warning: AVIF section is missing a valid FNAM subrecord!");
			FName.Initialize(SR_NAME_FNAM, 4);
			FName.InitializeNew();
		}

		if (XName.GetRecordType() != SR_NAME_XNAM)
		{
			SystemLog.Printf("Warning: AVIF section is missing a valid XNAM subrecord!");
			XName.Initialize(SR_NAME_XNAM, 4);
			XName.InitializeNew();
		}

		if (YName.GetRecordType() != SR_NAME_YNAM)
		{
			SystemLog.Printf("Warning: AVIF section is missing a valid YNAM subrecord!");
			YName.Initialize(SR_NAME_YNAM, 4);
			YName.InitializeNew();
		}

		if (HName.GetRecordType() != SR_NAME_HNAM)
		{
			SystemLog.Printf("Warning: AVIF section is missing a valid HNAM subrecord!");
			HName.Initialize(SR_NAME_HNAM, 4);
			HName.InitializeNew();
		}

		if (VName.GetRecordType() != SR_NAME_VNAM)
		{
			SystemLog.Printf("Warning: AVIF section is missing a valid VNAM subrecord!");
			VName.Initialize(SR_NAME_VNAM, 4);
			VName.InitializeNew();
		}

		if (SName.GetRecordType() != SR_NAME_SNAM)
		{
			SystemLog.Printf("Warning: AVIF section is missing a valid SNAM subrecord!");
			SName.Initialize(SR_NAME_SNAM, 4);
			SName.InitializeNew();
		}

		if (IName.GetRecordType() != SR_NAME_INAM)
		{
			SystemLog.Printf("Warning: AVIF section is missing a valid INAM subrecord!");
			IName.Initialize(SR_NAME_INAM, 4);
			IName.InitializeNew();
		}
	}

	void InitializeNew()
	{
		PName.Initialize(SR_NAME_PNAM, 4);
		PName.InitializeNew();

		FName.Initialize(SR_NAME_FNAM, 4);
		FName.InitializeNew();

		XName.Initialize(SR_NAME_XNAM, 4);
		XName.InitializeNew();
		
		YName.Initialize(SR_NAME_YNAM, 4);
		YName.InitializeNew();
		
		HName.Initialize(SR_NAME_HNAM, 4);
		HName.InitializeNew();
		
		VName.Initialize(SR_NAME_VNAM, 4);
		VName.InitializeNew();
		
		SName.Initialize(SR_NAME_SNAM, 4);
		SName.InitializeNew();

		CNames.Destroy();
		
		IName.Initialize(SR_NAME_INAM, 4);
		IName.InitializeNew();
	}

};

typedef CSrPtrArray<sravifsection_t> CSrAvifSectionArray;


/*===========================================================================
 *
 * Begin Class CSrAvifRecord Definition
 *
 *=========================================================================*/
class CSrAvifRecord : public CSrIdRecord 
{
	DECLARE_SRSUBRECCREATE()
	DECLARE_SRFIELDMAP()
	DECLARE_SRCLASS(CSrAvifRecord, CSrIdRecord)

  /*---------- Begin Protected Class Members --------------------*/
protected:
	CSrAvskSubrecord*		m_pAvData;
	CSrLStringSubrecord*	m_pItemName;
	CSrDwordSubrecord*		m_pCnamData;
	CSrLStringSubrecord*	m_pDescription;
	CSrStringSubrecord*		m_pAnamData;


	static sravskdata_t s_NullAvskData;


  /*---------- Begin Protected Class Methods --------------------*/
protected:


  /*---------- Begin Public Class Methods -----------------------*/
public:

		/* Class Constructors/Destructors */
	CSrAvifRecord();
	virtual void Destroy (void);

    	/* Return a new instance of the class */
	static CSrRecord* Create (void) { return new CSrAvifRecord; }

		/* Get class members */
	sravskdata_t& GetAvData (void) { return m_pAvData ? m_pAvData->GetAvskData() : s_NullAvskData; }
	dword CountAvifSections (void) { return CountSubrecords(SR_NAME_PNAM); }
	const char* GetAName    (void) { return m_pAnamData ? m_pAnamData->GetString().c_str() : ""; }

	void CreateSectionInfo     (CSrAvifSectionArray& InfoArray);
	void CreateFromSectionInfo (CSrAvifSectionArray& InfoArray);

		/* Initialize a new record */
	void InitializeNew (void);

		/* Called to alert record of a new subrecord being added */
	virtual void OnAddSubrecord    (CSrSubrecord* pSubrecord);
	virtual void OnDeleteSubrecord (CSrSubrecord* pSubrecord);

		/* Set class members */
	void SetAName (const char* pString);
	
		/* Begin field method definitions */
	DECLARE_SRFIELD_ITEMNAME(CSrAvifRecord)
	DECLARE_SRFIELD_DESCRIPTION(CSrAvifRecord, SR_NAME_DESC)

	DECLARE_SRFIELD_FLOAT1(CSrAvifRecord, Unknown1, GetAvData().Unknown[0], GetAvData().Unknown[0])
	DECLARE_SRFIELD_FLOAT1(CSrAvifRecord, Unknown2, GetAvData().Unknown[1], GetAvData().Unknown[1])
	DECLARE_SRFIELD_FLOAT1(CSrAvifRecord, Unknown3, GetAvData().Unknown[2], GetAvData().Unknown[2])
	DECLARE_SRFIELD_FLOAT1(CSrAvifRecord, Unknown4, GetAvData().Unknown[3], GetAvData().Unknown[3])
	
	DECLARE_SRFIELD_DWORD1(CSrAvifRecord, Sections, CountAvifSections(), dword Tmp)
	DECLARE_SRFIELD_METHOD(CSrAvifRecord, AName, GetAName, SetAName)
	
	DECLARE_SRFIELD_METHODDWORD(CSrAvifRecord, m_pCnamData, CName, SR_NAME_CNAM)

};
/*===========================================================================
 *		End of Class CSrAvifRecord Definition
 *=========================================================================*/


#endif
/*===========================================================================
 *		End of File SrAvifRecord.H
 *=========================================================================*/

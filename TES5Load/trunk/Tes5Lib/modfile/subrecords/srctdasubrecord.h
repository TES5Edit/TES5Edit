/*===========================================================================
 *
 * File:		SrCtdtsubrecord.H
 * Author:		Dave Humphrey (dave@uesp.net)
 * Created On:	2 December 2011
 *
 * Description
 *
 *=========================================================================*/
#ifndef __SRCTDTSUBRECORD_H
#define __SRCTDTSUBRECORD_H


/*===========================================================================
 *
 * Begin Required Includes
 *
 *=========================================================================*/
	#include "srsubrecord.h"
	#include "srstringsubrecord.h"
/*===========================================================================
 *		End of Required Includes
 *=========================================================================*/


/*===========================================================================
 *
 * Begin Definitions
 *
 *=========================================================================*/

	#define SR_CTDA_SUBRECORD_SIZE	32

	#define SR_CTDA_FUNCOFFSET 4096	

/*===========================================================================
 *		End of Definitions
 *=========================================================================*/


/*===========================================================================
 *
 * Begin Type Definitions
 *
 *=========================================================================*/
#pragma pack(push, 1)

  struct srctdtdata_t 
  {
	byte		Flags		: 5;
	byte		CompareType : 3;
	byte		Unknown1[3];
	union 
	{
		float		Value;
		srformid_t	GlobalID;
	};
	word		Function;
	word		Padding;
	int			Parameter1;
	int			Parameter2;
	dword		RunOnType;
	srformid_t	ReferenceID;
	int			Parameter3;
  };

#pragma pack(pop)
/*===========================================================================
 *		End of Type Definitions
 *=========================================================================*/


/*===========================================================================
 *
 * Begin Class CSrCtdaSubrecord Definition
 *
 * Description
 *
 *=========================================================================*/
class CSrCtdaSubrecord : public CSrSubrecord 
{
	DECLARE_SRCLASS(CSrCtdaSubrecord, CSrSubrecord)

  /*---------- Begin Protected Class Members --------------------*/
protected:
	srctdtdata_t	m_Data;
	byte			m_Prkc;		/* Used as a helper with PERK records */


  /*---------- Begin Protected Class Methods --------------------*/
protected:

	static bool IsFormidParam1 (const int FunctionCode);
	static bool IsFormidParam2 (const int FunctionCode);
	static bool IsFormidParam3 (const int FunctionCode);

	bool IsFormidParam1 (void) { return IsFormidParam1(m_Data.Function); }
	bool IsFormidParam2 (void) { return IsFormidParam2(m_Data.Function); }
	bool IsFormidParam3 (void) { return IsFormidParam3(m_Data.Function); }

	bool IsStringParam1 (void);
	bool IsStringParam2 (void);
	bool IsStringParam3 (void);

		/* Input/output the subrecord data */
	virtual bool ReadData  (CSrFile& File) { SR_VERIFY_SUBRECORDSIZE(SR_CTDA_SUBRECORD_SIZE) return File.Read(&m_Data,  SR_CTDA_SUBRECORD_SIZE); }
	virtual bool WriteData (CSrFile& File) { SR_VERIFY_SUBRECORDSIZE(SR_CTDA_SUBRECORD_SIZE) return File.Write(&m_Data, SR_CTDA_SUBRECORD_SIZE); }

  /*---------- Begin Public Class Methods -----------------------*/
public:

		/* Class Constructors/Destructors */
	CSrCtdaSubrecord() { }
	virtual void Destroy (void) { CSrSubrecord::Destroy(); }

  		/* Change any matching formid in the subrecord */
	virtual dword ChangeFormID (const srformid_t NewID, const srformid_t OldID);
	virtual dword CountUses (const srformid_t FormID);

		/* Field functions */
	bool CompareFields (int& Result, const int FieldID, CSrSubrecord* pSubrecord);
	bool GetField      (CSString& Buffer, const int FieldID);
    
		/* Copy the content from an existing subrecord */
	virtual bool Copy (CSrSubrecord* pSubrecord) 
	{
		CSrCtdaSubrecord* pSubrecord1 = SrCastClassNull(CSrCtdaSubrecord, pSubrecord);
		m_RecordSize = SR_CTDA_SUBRECORD_SIZE;
	
		if (pSubrecord1 != NULL) 
		{
			m_Data = pSubrecord1->GetCtdtData();
			m_Prkc = pSubrecord1->m_Prkc;
		}
		else 
		{
			memset(&m_Data, 0, sizeof(m_Data));
		}

		return true;
	}

  		/* Create a class instance */
	static  CSrSubrecord* Create  (void) { return new CSrCtdaSubrecord; }
	virtual CSrSubrecord* CreateV (void) { return new CSrCtdaSubrecord; }

    	/* Fixup the modindex of formids */
	virtual bool FixupFormID (CSrFormidFixupArray& FixupArray);

		/* Get class members */
	srctdtdata_t& GetCtdtData (void) { return m_Data; }
	virtual byte* GetData     (void) { return (byte *)&m_Data; }
	byte		  GetPrkc     (void) { return m_Prkc; }

	bool IsUseGlobal (void) { return (m_Data.Flags &SR_CTDA_FLAG_USEGLOBAL) != 0; }
   
		/* Initialize a new record */
	void InitializeNew (void) { CSrSubrecord::InitializeNew(); memset(&m_Data, 0, sizeof(m_Data)); m_RecordSize = SR_CTDA_SUBRECORD_SIZE; }

		/* Set class members */
	void SetPrkc (const byte Value) { m_Prkc = Value; }

};
/*===========================================================================
 *		End of Class CSrCtdaSubrecord Definition
 *=========================================================================*/


/*===========================================================================
 *
 * Begin srconditioninfo_t Definition
 *
 *=========================================================================*/
struct srconditioninfo_t
{
	CSrCtdaSubrecord	Condition;
	CSrStringSubrecord* pParam1;
	CSrStringSubrecord* pParam2;

	srconditioninfo_t()
	{
		Condition.Initialize(SR_NAME_CTDA, SR_CTDA_SUBRECORD_SIZE);
		Condition.InitializeNew();
		pParam1 = NULL;
		pParam2 = NULL;
	}

	~srconditioninfo_t()
	{
		delete pParam1;
		delete pParam2;
	}

	void Copy (srconditioninfo_t& Source)
	{
		delete pParam1;
		pParam1 = NULL;
		delete pParam2;
		pParam2 = NULL;

		Condition.Copy(&Source.Condition);

		if (Source.pParam1)
		{
			pParam1 = new CSrStringSubrecord;
			pParam1->Initialize(SR_NAME_CIS1, 0);
			pParam1->Copy(Source.pParam1);
		}

		if (Source.pParam2)
		{
			pParam2 = new CSrStringSubrecord;
			pParam2->Initialize(SR_NAME_CIS2, 0);
			pParam2->Copy(Source.pParam2);
		}

	}

	void CopyParam1 (CSrSubrecord* pSubrecord)
	{
		if (pSubrecord == NULL) return;

		if (pParam1 == NULL) 
		{
			pParam1 = new CSrStringSubrecord;
			pParam1->Initialize(SR_NAME_CIS1, 0);
		}

		pParam1->Copy(pSubrecord);
	}

	void CopyParam2 (CSrSubrecord* pSubrecord)
	{
		if (pSubrecord == NULL) return;

		if (pParam2 == NULL) 
		{
			pParam2 = new CSrStringSubrecord;
			pParam2->Initialize(SR_NAME_CIS2, 0);
		}

		pParam2->Copy(pSubrecord);
	}

	void DeleteParam1 (void)
	{
		delete pParam1;
		pParam1 = NULL;
	}

	void DeleteParam2 (void)
	{
		delete pParam2;
		pParam2 = NULL;
	}	

	void DeleteParam (const dword Index)
	{
		if (Index == 0) DeleteParam1();
		else if (Index == 1) DeleteParam2();
	}

	void SetParam1 (const char* pBuffer)
	{
		if (pParam1 == NULL) 
		{
			pParam1 = new CSrStringSubrecord;
			pParam1->Initialize(SR_NAME_CIS1, 0);
		}

		pParam1->SetString(pBuffer);
	}

	void SetParam2 (const char* pBuffer)
	{
		if (pParam2 == NULL) 
		{
			pParam2 = new CSrStringSubrecord;
			pParam2->Initialize(SR_NAME_CIS2, 0);
		}

		pParam2->SetString(pBuffer);
	}

	void SetParam (const dword Index, const char* pBuffer)
	{
		if (Index == 0) SetParam1(pBuffer);
		else if (Index == 1) SetParam2(pBuffer);
	}

};

typedef CSrPtrArray<srconditioninfo_t> CSrConditionArray;
/*===========================================================================
 *		End of Type srconditioninfo_t Definition
 *=========================================================================*/


#endif
/*===========================================================================
 *		End of File SrCtdaSubrecord.H
 *=========================================================================*/

/*===========================================================================
 *
 * File:		SrVmadSubrecord.h
 * Author:		Dave Humphrey (dave@uesp.net)
 * Created On:	25 January 2012
 *
 * Decl;ares the CSrVmadSubrecord class for handling VMAD subrecords.
 *
 *=========================================================================*/
#ifndef __SRVMADSUBRECORD_H
#define __SRVMADSUBRECORD_H


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

		/* Default/latest version value */
	#define SR_VMAD_VERSIONLATEST	5

		/* Arbitrary sanity limits */
	#define SR_VMAD_MAXSCRIPTCOUNT   1000		
	#define SR_VMAD_MAXPROPERTYCOUNT 1000		
	#define SR_VMAD_MAXPROPDATACOUNT 1000
	#define SR_VMAD_MAXSTRINGLENGTH  1000

/*===========================================================================
 *		End of Definitions
 *=========================================================================*/


/*===========================================================================
 *
 * Begin srvmadpropertydata_t Definition
 *
 *=========================================================================*/
struct srvmadpropertydata_t
{
	CSString	String;
	
	union
	{
		word		wValue;
		int			iValue;
		float		fValue;
		bool		bValue;
	};

	word		QuestAlias;
	srformid_t	FormID;
	byte		Type;

	srvmadpropertydata_t() : Type(SR_VMAD_PROPDATA_NULL), wValue(0), QuestAlias(0), FormID(0)
	{
	}

	dword ComputeSize (void) const
	{
		switch (Type)
		{
			default:
			case SR_VMAD_PROPDATA_NULL:				return 0;
			case SR_VMAD_PROPDATA_REFERENCE:		return 8;
			case SR_VMAD_PROPDATA_STRING:			return String.GetLength() + 1 + 2;
			case SR_VMAD_PROPDATA_INT:				return 4;
			case SR_VMAD_PROPDATA_FLOAT:			return 4;
			case SR_VMAD_PROPDATA_BOOL:				return 1;
		};
	}

	bool CreateRawData (byte* pData, dword& Index, const dword DataSize)
	{
		word Size;

		switch (Type)
		{
			default:
			case SR_VMAD_PROPDATA_NULL:			
				return true;
			case SR_VMAD_PROPDATA_REFERENCE:		
				if (Index + 8 > DataSize) return AddSrGeneralError("srvmadpropertydata_t::CreateRawData() Failed to add 8 bytes of data!");
				memcpy(pData + Index, &wValue, 2);
				Index += 2;
				memcpy(pData + Index, &QuestAlias, 2);
				Index += 2;
				memcpy(pData + Index, &FormID, 4);
				Index += 4;
				break;
			case SR_VMAD_PROPDATA_STRING:
				Size = (word) String.GetLength() + 1;
				if (Size > SR_VMAD_MAXSTRINGLENGTH) return AddSrGeneralError("srvmadpropertydata_t::CreateRawData(): Exceeded maximum string length of %d!", SR_VMAD_MAXSTRINGLENGTH);
				if (Index + Size > DataSize) return AddSrGeneralError("srvmadpropertydata_t::CreateRawData() Failed to add %hd bytes of data!", Size);
				memcpy(pData + Index, &Size, 2);
				Index += 2;
				memcpy(pData + Index, String.c_str(), Size);
				Index += Size;
				break;
			case SR_VMAD_PROPDATA_INT:				
				if (Index + 4 > DataSize) return AddSrGeneralError("srvmadpropertydata_t::CreateRawData() Failed to add 4 bytes of data!");
				memcpy(pData + Index, &iValue, 4);
				Index += 4;
				break;
			case SR_VMAD_PROPDATA_FLOAT:			
				if (Index + 4 > DataSize) return AddSrGeneralError("srvmadpropertydata_t::CreateRawData() Failed to add 4 bytes of data!");
				memcpy(pData + Index, &fValue, 4);
				Index += 4;
				break;
			case SR_VMAD_PROPDATA_BOOL:				
				if (Index + 1 > DataSize) return AddSrGeneralError("srvmadpropertydata_t::CreateRawData() Failed to add 1 byte of data!");
				memcpy(pData + Index, &bValue, 1);
				Index += 1;
				break;
		};

		return true;
	}


	bool ParseRawData (byte* pData, dword& Index, const dword DataSize)
	{
		word Size;

		switch (Type)
		{
			default:
			case SR_VMAD_PROPDATA_NULL:			
				return true;
			case SR_VMAD_PROPDATA_REFERENCE:		
				if (Index + 8 > DataSize) return AddSrGeneralError("srvmadpropertydata_t::ParseRawData() Failed to parse 8 bytes of data!");
				memcpy(&wValue, pData + Index, 2);
				Index += 2;
				memcpy(&QuestAlias, pData + Index, 2);
				Index += 2;
				memcpy(&FormID, pData + Index, 4);
				Index += 4;
				break;
			case SR_VMAD_PROPDATA_STRING:
				if (Index + 2 > DataSize) return AddSrGeneralError("srvmadpropertydata_t::ParseRawData() Failed to parse 2 bytes of data!");
				memcpy(&Size, pData + Index, 2);
				Index += 2;
				String.Destroy();

				if (Size > 0)
				{
					if (Index + Size > DataSize) return AddSrGeneralError("srvmadpropertydata_t::ParseRawData() Failed to parse %hd bytes of data!", Size);
					String.Copy((char*)(pData + Index), Size);
					String.UpdateLength();
					Index += Size;
				}

				break;
			case SR_VMAD_PROPDATA_INT:				
				if (Index + 4 > DataSize) return AddSrGeneralError("srvmadpropertydata_t::ParseRawData() Failed to parse 4 bytes of data!");
				memcpy(&iValue, pData + Index, 4);
				Index += 4;
				break;
			case SR_VMAD_PROPDATA_FLOAT:			
				if (Index + 4 > DataSize) return AddSrGeneralError("srvmadpropertydata_t::ParseRawData() Failed to parse 4 bytes of data!");
				memcpy(&fValue, pData + Index, 4);
				Index += 4;
				break;
			case SR_VMAD_PROPDATA_BOOL:
				if (Index + 1 > DataSize) return AddSrGeneralError("srvmadpropertydata_t::ParseRawData() Failed to parse 1 byte of data!");
				memcpy(&bValue, pData + Index, 1);
				Index += 1;
				break;
		};

		return true;
	}


	dword CountUses (const srformid_t InFormID)  
	{ 
		if (Type != SR_VMAD_PROPDATA_REFERENCE) return 0;

		if (FormID == InFormID) return 1;
		return 0;
	}


	dword ChangeFormID (const srformid_t NewFormID, const srformid_t OldFormID) 
	{ 
		if (Type != SR_VMAD_PROPDATA_REFERENCE) return 0;

		if (FormID == OldFormID) 
		{
			FormID = NewFormID;
			return 1;
		}

		return 0;
	}


	bool FixupFormID (CSrFormidFixupArray& FixupArray) 
	{ 
		if (Type != SR_VMAD_PROPDATA_REFERENCE) return 0;
		bool  Result;

		Result  = SrFixupFormid(FormID, FormID, FixupArray);

		return (Result);
	}

};

typedef CSrPtrArray<srvmadpropertydata_t> CSrVmadPropertyDataArray;
/*===========================================================================
 *		End of srvmadpropertydata_t Definition
 *=========================================================================*/


/*===========================================================================
 *
 * Begin srvmadproperty_t Definition
 *
 *=========================================================================*/
struct srvmadproperty_t
{
	CSString	Name;
	byte		Type;
	byte		Unknown;

	CSrVmadPropertyDataArray	Data;

	srvmadproperty_t() : Type(SR_VMAD_PROPDATA_NULL), Unknown(1)
	{
	}

	void Destroy()
	{
		Name.Empty();
		Type = SR_VMAD_PROPDATA_NULL;
		Data.Destroy();
	}

	srvmadproperty_t(const srvmadproperty_t& Src)
	{
		Copy(Src);
	}

	srvmadproperty_t& operator=(const srvmadproperty_t& Src)
	{
		Copy(Src);
		return *this;
	}

	void Copy (const srvmadproperty_t& Src)
	{
		if (&Src == this) return;
		Destroy();
		Name    = Src.Name;
		Type    = Src.Type;
		Unknown = Src.Unknown;

		for (dword i = 0; i < Src.Data.GetSize(); ++i)
		{
			*(Data.AddNew()) = *(Src.Data[i]);
		}
	}

	dword ComputeSize (void) const
	{
		dword Size = 2;

		Size += Name.GetLength() + 1 + 2;

		if (!IsArray()) 
		{
			if (Data.GetSize() > 0) Size += Data[0]->ComputeSize();
			return Size;
		}

		Size += 2;

		for (dword i = 0; i < Data.GetSize(); ++i)
		{
			Size += Data[i]->ComputeSize();
		}

		return Size;
	}

	bool IsArray (void) const
	{
		return (Type > 10);
	}

	bool CreateRawData (byte* pData, dword& Index, const dword DataSize)
	{
		word Count = (word) Data.GetSize();
		word Size  = (word) Name.GetLength() + 1;

		if (!IsArray()) 
		{
			if (Count == 0) return AddSrGeneralError("srvmadproperty_t::CreateRawData(): Missing property data!");
			Count = 1;
			if (4 + Size + Index > DataSize) return AddSrGeneralError("srvmadproperty_t::CreateRawData(): Failed to add %d bytes of data!", 4 + Size);
		}
		else if (6 + Size + Index > DataSize) 
		{
			return AddSrGeneralError("srvmadproperty_t::CreateRawData(): Failed to add %d bytes of data!", 6 + Size);
		}
		
		if (Data.GetSize() > SR_VMAD_MAXPROPDATACOUNT) return AddSrGeneralError("srvmadproperty_t::CreateRawData(): Exceeded maximum number of property datas %d!", SR_VMAD_MAXPROPDATACOUNT);
		if (Name.GetLength() > SR_VMAD_MAXSTRINGLENGTH) return AddSrGeneralError("srvmadproperty_t::CreateRawData(): Exceeded maximum string length of %d!", SR_VMAD_MAXSTRINGLENGTH);
		
		memcpy(pData + Index, &Size, 2);
		Index += 2;
		memcpy(pData + Index, Name.c_str(), Size);
		Index += Size;

		memcpy(pData + Index, &Type, 1);
		Index += 1;

		memcpy(pData + Index, &Unknown, 1);
		Index += 1;

		if (IsArray())
		{
			memcpy(pData + Index, &Count, 2);
			Index += 2;
		}

		for (dword i = 0; i < Count; ++i)
		{
			if (!Data[i]->CreateRawData(pData, Index, DataSize)) return false;
		}

		return true;
	}

	bool ParseRawData (byte* pData, dword& Index, const dword DataSize)
	{
		word Count;
		word Size;

		Data.Destroy();
		Name.Empty();

		if (Index + 2 > DataSize) return AddSrGeneralError("srvmadproperty_t::ParseRawData(): Failed to parse 2 bytes of data!");

		memcpy(&Size, pData + Index, 2);
		Index += 2;

		if (Size > 0)
		{
			if (Index + Size > DataSize) return AddSrGeneralError("srvmadproperty_t::ParseRawData(): Failed to parse %hd bytes of data!", Size);
			Name.Copy((char *)(pData + Index), Size);
			Name.UpdateLength();
			Index += Size;
		}

		if (Index + 2 > DataSize) return AddSrGeneralError("srvmadproperty_t::ParseRawData(): Failed to parse 2 bytes of data!");

		memcpy(&Type, pData + Index, 1);
		Index += 1;

		memcpy(&Unknown, pData + Index, 1);
		Index += 1;

		if (IsArray())
		{
			if (Index + 2 > DataSize) return AddSrGeneralError("srvmadproperty_t::ParseRawData(): Failed to parse 2 bytes of data!");
			memcpy(&Count, pData + Index, 2);
			Index += 2;
		}
		else
		{
			Count = 1;
		}

		for (word i = 0; i < Count; ++i)
		{
			srvmadpropertydata_t* pPropertyData = Data.AddNew();
			pPropertyData->Type = Type % 10;
			if (!pPropertyData->ParseRawData(pData, Index, DataSize)) return false;
		}

		return true;
	}


	dword CountUses (const srformid_t FormID)  
	{ 
		if (Type != SR_VMAD_PROPDATA_REFERENCE && Type != SR_VMAD_PROPDATA_ARRAYREFERENCE) return 0;
		dword Count = 0;

		for (dword i = 0; i < Data.GetSize(); ++i)
		{
			Count += Data[i]->CountUses(FormID);
		}

		return Count;
	}


	dword ChangeFormID (const srformid_t NewFormID, const srformid_t OldFormID) 
	{ 
		if (Type != SR_VMAD_PROPDATA_REFERENCE && Type != SR_VMAD_PROPDATA_ARRAYREFERENCE) return 0;
		dword Count = 0;

		for (dword i = 0; i < Data.GetSize(); ++i)
		{
			Count += Data[i]->ChangeFormID(NewFormID, OldFormID); 
		}

		return Count;
	}


	bool FixupFormID (CSrFormidFixupArray& FixupArray) 
	{ 
		if (Type != SR_VMAD_PROPDATA_REFERENCE && Type != SR_VMAD_PROPDATA_ARRAYREFERENCE) return true;
		bool Result = true;

		for (dword i = 0; i < Data.GetSize(); ++i)
		{
			Result &= Data[i]->FixupFormID(FixupArray);
		}

		return Result;
	}
};

typedef CSrPtrArray<srvmadproperty_t> CSrVmadPropertyArray;
/*===========================================================================
 *		End of srvmadproperty_t Definition
 *=========================================================================*/


/*===========================================================================
 *
 * Begin srvmadscript_t Definition
 *
 *=========================================================================*/
struct srvmadscript_t
{
	CSString	Name;
	byte		Unknown;

	CSrVmadPropertyArray Properties;

	srvmadscript_t() : Unknown(0)
	{
	}

	void Destroy()
	{
		Properties.Destroy();
		Name.Empty();
	}

	srvmadscript_t(const srvmadscript_t& Src)
	{
		Copy(Src);
	}

	srvmadscript_t& operator=(const srvmadscript_t& Src)
	{
		Copy(Src);
		return *this;
	}

	void Copy (const srvmadscript_t& Src)
	{
		if (&Src == this) return;
		Destroy();
		Name    = Src.Name;
		Unknown = Src.Unknown;

		for (dword i = 0; i < Src.Properties.GetSize(); ++i)
		{
			Properties.AddNew()->Copy(*Src.Properties[i]);
		}
	}

	dword ComputeSize (void) const
	{
		dword Size = 1 + 2;

		Size += Name.GetLength() + 1 + 2;

		for (dword i = 0; i < Properties.GetSize(); ++i)
		{
			Size += Properties[i]->ComputeSize();
		}

		return Size;
	}

	bool CreateRawData (byte* pData, dword& Index, const dword DataSize)
	{
		word Count = (word) Properties.GetSize();
		word Size  = (word) Name.GetLength() + 1;

		if (Index + 5 + Size > DataSize) return AddSrGeneralError("srvmadscript_t::CreateRawData(): Failed to add %d bytes of data!", 5 + Size);
		if (Properties.GetSize() > SR_VMAD_MAXPROPERTYCOUNT) return AddSrGeneralError("srvmadscript_t::CreateRawData(): Exceeded maximum number of properties %d!", SR_VMAD_MAXPROPERTYCOUNT);
		if (Name.GetLength() > SR_VMAD_MAXSTRINGLENGTH) return AddSrGeneralError("srvmadscript_t::CreateRawData(): Exceeded maximum string length of %d!", SR_VMAD_MAXSTRINGLENGTH);
		
		memcpy(pData + Index, &Size, 2);
		Index += 2;
		memcpy(pData + Index, Name.c_str(), Size);
		Index += Size;

		memcpy(pData + Index, &Unknown, 1);
		Index += 1;

		memcpy(pData + Index, &Count, 2);
		Index += 2;

		for (dword i = 0; i < Count; ++i)
		{
			if (!Properties[i]->CreateRawData(pData, Index, DataSize)) return false;
		}

		return true;
	}

	bool ParseRawData (byte* pData, dword& Index, const dword DataSize)
	{
		word Count;
		word Size;

		Properties.Destroy();
		Name.Empty();

		if (Index + 2 > DataSize) return AddSrGeneralError("srvmadscript_t::ParseRawData(): Failed to parse 2 bytes of data!");

		memcpy(&Size, pData + Index, 2);
		Index += 2;

		if (Size >= 0)
		{
			if (Index + Size > DataSize) return AddSrGeneralError("srvmadscript_t::ParseRawData(): Failed to parse %hd bytes of data!", Size);
			Name.Copy((char *) (pData + Index), Size);
			Name.UpdateLength();
			Index += Size;
		}

		if (Index + 3 > DataSize) return AddSrGeneralError("srvmadscript_t::ParseRawData(): Failed to parse 3 bytes of data!");

		memcpy(&Unknown, pData + Index, 1);
		Index += 1;

		memcpy(&Count, pData + Index, 2);
		Index += 2;

		for (word i = 0; i < Count; ++i)
		{
			if (!Properties.AddNew()->ParseRawData(pData, Index, DataSize)) return false;
		}

		return true;
	}

	dword CountUses (const srformid_t FormID)  
	{ 
		dword Count = 0;

		for (dword i = 0; i < Properties.GetSize(); ++i)
		{
			Count += Properties[i]->CountUses(FormID);
		}

		return Count;
	}


	dword ChangeFormID (const srformid_t NewFormID, const srformid_t OldFormID) 
	{ 
		dword Count = 0;

		for (dword i = 0; i < Properties.GetSize(); ++i)
		{
			Count += Properties[i]->ChangeFormID(NewFormID, OldFormID); 
		}

		return Count;
	}


	bool FixupFormID (CSrFormidFixupArray& FixupArray) 
	{ 
		bool Result = true;

		for (dword i = 0; i < Properties.GetSize(); ++i)
		{
			Result &= Properties[i]->FixupFormID(FixupArray);
		}

		return Result;
	}
};

typedef CSrPtrArray<srvmadscript_t> CSrVmadScriptArray;
/*===========================================================================
 *		End of srvmadscript_t Definition
 *=========================================================================*/


/*===========================================================================
 *
 * Begin srvmaddata_t Definition
 *
 *=========================================================================*/
struct srvmaddata_t
{
	word	Version;		//2-5
	word	Unknown;		//2?

	CSrVmadScriptArray Scripts;

	srvmaddata_t() : Version(SR_VMAD_VERSIONLATEST), Unknown(2)
	{
	}

	srvmaddata_t(const srvmaddata_t& Src)
	{
		Copy(Src);
	}

	srvmaddata_t& operator=(const srvmaddata_t& Src)
	{
		Copy(Src);
		return *this;
	}

	void Copy (const srvmaddata_t& Src)
	{
		if (&Src == this) return;
		Destroy();
		Version = Src.Version;
		Unknown = Src.Unknown;

		for (dword i = 0; i < Src.Scripts.GetSize(); ++i)
		{
			Scripts.AddNew()->Copy(*Src.Scripts[i]);
		}
	}

	void Destroy()
	{
		Scripts.Destroy();
	}

	dword ComputeSize (void) const
	{
		dword Size = 2 + 2 + 2;

		for (dword i = 0; i < Scripts.GetSize(); ++i)
		{
			Size += Scripts[i]->ComputeSize();
		}

		return Size;
	}

	bool CreateRawData (byte* pData, dword& Index, const dword DataSize)
	{
		word Count = (word) Scripts.GetSize();

		if (Index + 6 > DataSize) return AddSrGeneralError("srvmaddata_t::CreateRawData(): Failed to add 6 bytes of data!");
		if (Scripts.GetSize() > SR_VMAD_MAXSCRIPTCOUNT) return AddSrGeneralError("srvmaddata_t::CreateRawData(): Exceeded maximum number of scripts %d!", SR_VMAD_MAXSCRIPTCOUNT);

		memcpy(pData + Index, &Version, 2);
		Index += 2;

		memcpy(pData + Index, &Unknown, 2);
		Index += 2;

		memcpy(pData + Index, &Count, 2);
		Index += 2;

		for (dword i = 0; i < Count; ++i)
		{
			if (!Scripts[i]->CreateRawData(pData, Index, DataSize)) return false;
		}

		return true;
	}

	bool ParseRawData (byte* pData, dword& Index, const dword DataSize)
	{
		word Count;

		Scripts.Destroy();

		if (Index + 6 > DataSize) return AddSrGeneralError("srvmaddata_t::ParseRawData(): Failed to parse 6 bytes of data!");

		memcpy(&Version, pData + Index, 2);
		Index += 2;

		memcpy(&Unknown, pData + Index, 2);
		Index += 2;

		memcpy(&Count, pData + Index, 2);
		Index += 2;

		for (word i = 0; i < Count; ++i)
		{
			if (!Scripts.AddNew()->ParseRawData(pData, Index, DataSize)) return false;
		}

		return true;
	}


	dword CountUses (const srformid_t FormID)  
	{ 
		dword Count = 0;

		for (dword i = 0; i < Scripts.GetSize(); ++i)
		{
			Count += Scripts[i]->CountUses(FormID);
		}

		return Count;
	}


	dword ChangeFormID (const srformid_t NewFormID, const srformid_t OldFormID) 
	{ 
		dword Count = 0;

		for (dword i = 0; i < Scripts.GetSize(); ++i)
		{
			Count += Scripts[i]->ChangeFormID(NewFormID, OldFormID); 
		}

		return Count;
	}


	bool FixupFormID (CSrFormidFixupArray& FixupArray) 
	{ 
		bool Result = true;

		for (dword i = 0; i < Scripts.GetSize(); ++i)
		{
			Result &= Scripts[i]->FixupFormID(FixupArray);
		}

		return Result;
	}

};
/*===========================================================================
 *		End of srvmaddata_t Definition
 *=========================================================================*/


/*===========================================================================
 *
 * Begin Class CSrVmadSubrecord Definition
 *
 *=========================================================================*/
class CSrVmadSubrecord : public CSrSubrecord
{
	DECLARE_SRCLASS(CSrVmadSubrecord, CSrSubrecord)

protected:
	srvmaddata_t	m_Data;
	byte*			m_pRawData;
	dword			m_RawDataSize;

	dword ComputeRawDataSize (void);

	bool CreateRawData (void);
	bool ParseRawData  (void);

	virtual bool ReadData  (CSrFile& File);
	virtual bool WriteData (CSrFile& File);

public:

	CSrVmadSubrecord();
	virtual ~CSrVmadSubrecord();

	virtual void Destroy();

	virtual bool Copy (CSrSubrecord* pSubecord);

	static  CSrSubrecord* Create  (void) { return new CSrVmadSubrecord; }
	virtual CSrSubrecord* CreateV (void) { return new CSrVmadSubrecord; }

	srvmadscript_t* FindScript (const char* pScriptName);

	dword GetScriptCount (void) { return m_Data.Scripts.GetSize(); }
	srvmaddata_t& GetScriptData (void) { return m_Data; }

	virtual dword GetRecordSize (void) const { return m_Data.ComputeSize(); }
	virtual byte* GetData       (void)       { return m_pRawData; }

	virtual dword CountUses    (const srformid_t FormID)  { return m_Data.CountUses(FormID); }
	virtual dword ChangeFormID (const srformid_t NewFormID, const srformid_t OldFormID)  { return m_Data.ChangeFormID(NewFormID, OldFormID); }
	virtual bool  FixupFormID  (CSrFormidFixupArray& FixupArray) { return m_Data.FixupFormID(FixupArray); }

	virtual void InitializeNew (void);

	void UpdateRawData (void) 
	{
		CreateRawData(); 
		m_RecordSize = m_RawDataSize;
	}

};
/*===========================================================================
 *		End of Class CSrVmadSubrecord
 *=========================================================================*/


#endif
/*===========================================================================
 *		End of File SrVmadSubrecord.H
 *=========================================================================*/

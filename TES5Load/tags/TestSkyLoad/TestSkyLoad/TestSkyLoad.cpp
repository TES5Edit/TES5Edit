// TestSkyLoad.cpp : Defines the entry point for the console application.
//

#include "stdafx.h"
#include <stdarg.h>
#include "modfile/SrSimpleRecordHandler.h"
#include "modfile/SrEspFile.h"
#include "bsafile/SrBsaFile.h"
#include "strings/SrStringFile.h"
#include <unordered_map>
#include <string>
#include <fstream>
#include <streambuf>


CSrSimpleRecordHandler TestFile;
CSrBsaFile BsaFile;
CSrEspFile TestFile1;
CSrStringFile Strings1;
CSrStringFile Strings2;
CSrStringFile Strings3;


struct subrecordinfo_t
{
	srrectype_t Type;
	dword       TotalCount;
	dword		SizeSum;
	dword		MinSize;
	dword		MaxSize;
	dword		MinCount;
	dword		MaxCount;

	subrecordinfo_t()
	{
		TotalCount = 0;
		SizeSum = 0;
		MinSize = 1000000000;
		MaxSize = 0;
		MinCount = 0;
		MaxCount = 0;
	}

};

typedef std::unordered_map<srrectype_t, subrecordinfo_t> CSubrecordInfoMap;

typedef std::unordered_map<srrectype_t, int> CSubrecordCountMap;

struct recordinfo_t
{
	srrectype_t Type;
	dword		TotalCount;
	dword		SizeSum;
	dword		MinSize;
	dword		MaxSize;
	dword		MinVersion;
	dword		MaxVersion;
	
	CSubrecordInfoMap SubrecordInfos;

	recordinfo_t()
	{
		TotalCount = 0;
		SizeSum = 0;
		MinSize = 1000000000;
		MaxSize = 0;
		MinVersion = 100000000;
		MaxVersion = 0;
	}
};


typedef std::unordered_map<srrectype_t, recordinfo_t> CRecordInfoMap;

CRecordInfoMap RecordInfos;


void GatherRecordInfos (CSrRecord* pRecord)
{
	CSubrecordCountMap CountMap;
	if (pRecord == NULL) return;

	dword Size = pRecord->GetSubrecordSize();
	recordinfo_t& RecordInfo = RecordInfos[pRecord->GetRecordType()];

	if (Size > RecordInfo.MaxSize) RecordInfo.MaxSize = Size;
	if (Size < RecordInfo.MinSize) RecordInfo.MinSize = Size;
	++RecordInfo.TotalCount;
	RecordInfo.SizeSum += Size;

	int Version = pRecord->GetHeader().Version;
	if (Version < RecordInfo.MinVersion) RecordInfo.MinVersion = Version;
	if (Version > RecordInfo.MaxVersion) RecordInfo.MaxVersion = Version;

	for (dword i = 0; i < pRecord->GetNumSubrecords(); ++i)
	{
		CSrSubrecord* pSubrecord = pRecord->GetSubrecord(i);
		if (pSubrecord == NULL) continue;

		CountMap[pSubrecord->GetRecordType()] += 1;

		subrecordinfo_t& SubrecordInfo = RecordInfo.SubrecordInfos[pSubrecord->GetRecordType()];

		Size = pSubrecord->GetRecordSize();
		if (Size > SubrecordInfo.MaxSize) SubrecordInfo.MaxSize = Size;
		if (Size < SubrecordInfo.MinSize) SubrecordInfo.MinSize = Size;
		++SubrecordInfo.TotalCount;
		SubrecordInfo.SizeSum += Size;
	}

		/* Update subrecord counts */
	for (CSubrecordCountMap::iterator iter = CountMap.begin(); iter != CountMap.end(); ++iter)
	{
		dword Count      = (*iter).second;
		srrectype_t Type = (*iter).first;

		subrecordinfo_t& SubrecordInfo = RecordInfo.SubrecordInfos[Type];

		if (RecordInfo.TotalCount == 1)
		{
			SubrecordInfo.MinCount = Count;
			SubrecordInfo.MaxCount = Count;
		}
		else
		{
			if (Count > SubrecordInfo.MaxCount) SubrecordInfo.MaxCount = Count;
			if (Count < SubrecordInfo.MinCount) SubrecordInfo.MinCount = Count;
		}
	}
}


void GatherGroupInfos (CSrGroup* pGroup)
{
	if (pGroup == NULL) return;

	for (dword i = 0; i < pGroup->GetNumRecords(); ++i)
	{
		CSrBaseRecord* pBaseRecord = pGroup->GetRecord(i);

		if (pBaseRecord->IsGroup())
		{
			CSrGroup* pGroup = SrCastClass(CSrGroup, pBaseRecord);
			GatherGroupInfos(pGroup);
		}
		else
		{
			CSrRecord* pRecord = SrCastClass(CSrRecord, pBaseRecord);
			GatherRecordInfos(pRecord);
		}
	}
}


void GatherTopLevelInfos (CSrEspFile& EspFile)
{
	for (dword i = 0; i < EspFile.GetNumTopLevelRecords(); ++i)
	{
		CSrBaseRecord* pBaseRecord = EspFile.GetTopLevelRecord(i);

		if (pBaseRecord->IsGroup())
		{
			CSrGroup* pGroup = SrCastClass(CSrGroup, pBaseRecord);
			GatherGroupInfos(pGroup);
		}
		else
		{
			CSrRecord* pRecord = SrCastClass(CSrRecord, pBaseRecord);
			GatherRecordInfos(pRecord);
		}
	}
}


void DumpRecordInfos (void)
{
	int RIndex = 1;
	dword TotalSize = 0;

	for (CRecordInfoMap::iterator iter = RecordInfos.begin(); iter != RecordInfos.end(); ++iter)
	{
		srrectype_t Type         = (*iter).first;
		recordinfo_t& RecordInfo = (*iter).second;

		TotalSize += RecordInfo.SizeSum;
	}

	for (CRecordInfoMap::iterator iter = RecordInfos.begin(); iter != RecordInfos.end(); ++iter, ++RIndex)
	{
		srrectype_t Type         = (*iter).first;
		recordinfo_t& RecordInfo = (*iter).second;
	
		SystemLog.Printf("%d) %4.4s Record Info:", RIndex, Type.Name);
		SystemLog.Printf("     TotalSize  = %u (%.1f)", RecordInfo.SizeSum, RecordInfo.SizeSum * 100.0f / (float) TotalSize);
		SystemLog.Printf("     TotalCount  = %u", RecordInfo.TotalCount);
		SystemLog.Printf("     AverageSize = %f bytes", (float) RecordInfo.SizeSum / RecordInfo.TotalCount);
		SystemLog.Printf("     MinSize     = %u", RecordInfo.MinSize);
		SystemLog.Printf("     MaxSize     = %u", RecordInfo.MaxSize);
		SystemLog.Printf("     MinVersion  = %u", RecordInfo.MinVersion);
		SystemLog.Printf("     MaxVersion  = %u", RecordInfo.MaxVersion);
		
		int Index = 1;

		for (CSubrecordInfoMap::iterator iter1 = RecordInfo.SubrecordInfos.begin(); iter1 != RecordInfo.SubrecordInfos.end(); ++iter1)
		{
			srrectype_t Type               = (*iter1).first;
			subrecordinfo_t& SubrecordInfo = (*iter1).second;
			
			SystemLog.Printf("     %d) %4.4s Subrecord Info: %s%s%s%s", Index, Type.Name, 
				(SubrecordInfo.TotalCount == RecordInfo.TotalCount && SubrecordInfo.MaxCount == 1) ? "One/Record " : "", 
				SubrecordInfo.MinCount > 0 ? "Required " : "",
				SubrecordInfo.MaxCount > 1 ? "ManyAllowed " : "",
				SubrecordInfo.MinSize == SubrecordInfo.MaxSize ? "FixedSize " : "VariableSize ");
			SystemLog.Printf("           TotalCount  = %u", SubrecordInfo.TotalCount);
			SystemLog.Printf("           AverageSize = %f bytes", (float) SubrecordInfo.SizeSum / SubrecordInfo.TotalCount);
			SystemLog.Printf("           MinSize     = %u", SubrecordInfo.MinSize);
			SystemLog.Printf("           MaxSize     = %u", SubrecordInfo.MaxSize);
			SystemLog.Printf("           MinCount    = %u", SubrecordInfo.MinCount);
			SystemLog.Printf("           MaxCount    = %u", SubrecordInfo.MaxCount);

			++Index;
		}
	}

}

void DumpRecordInfos1 (void)
{
	//FILE* pFile = fopen("skyrecords.csv", "wb");
	//if (pFile == NULL) return;

	int RIndex = 1;

	for (CRecordInfoMap::iterator iter = RecordInfos.begin(); iter != RecordInfos.end(); ++iter, ++RIndex)
	{
		srrectype_t Type         = (*iter).first;
		recordinfo_t& RecordInfo = (*iter).second;
	
		//fprintf(pFile, "%4.4s\n", Type.Name);
		SystemLog.Printf("%d) %4.4s Record Info:", RIndex, Type.Name);
		SystemLog.Printf("     TotalSize  = %u", RecordInfo.SizeSum);
		//SystemLog.Printf("     TotalCount  = %u", RecordInfo.TotalCount);
		//SystemLog.Printf("     AverageSize = %f bytes", (float) RecordInfo.SizeSum / RecordInfo.TotalCount);
		//SystemLog.Printf("     MinSize     = %u", RecordInfo.MinSize);
		//SystemLog.Printf("     MaxSize     = %u", RecordInfo.MaxSize);
		int Index = 1;

		for (CSubrecordInfoMap::iterator iter1 = RecordInfo.SubrecordInfos.begin(); iter1 != RecordInfo.SubrecordInfos.end(); ++iter1)
		{
			srrectype_t Type1               = (*iter1).first;
			subrecordinfo_t& SubrecordInfo  = (*iter1).second;

			//fprintf(pFile, "%4.4s, %4.4s,", Type.Name, Type1.Name);
			//if (SubrecordInfo.TotalCount == RecordInfo.TotalCount && SubrecordInfo.MaxCount == 1) fprintf(pFile, "Required ");
			//if (SubrecordInfo.MaxCount > 1) fprintf(pFile, "Many ");

			//fprintf(pFile, "\n");
			
			//SystemLog.Printf("     %d) %4.4s Subrecord Info: %s%s%s%s", Index, Type.Name, 
//				(SubrecordInfo.TotalCount == RecordInfo.TotalCount && SubrecordInfo.MaxCount == 1) ? "One/Record " : "", 
				//SubrecordInfo.MinCount > 0 ? "Required " : "",
				//SubrecordInfo.MaxCount > 1 ? "ManyAllowed " : "",
				//SubrecordInfo.MinSize == SubrecordInfo.MaxSize ? "FixedSize " : "VariableSize ");
			//SystemLog.Printf("           TotalCount  = %u", SubrecordInfo.TotalCount);
			//SystemLog.Printf("           AverageSize = %f bytes", (float) SubrecordInfo.SizeSum / SubrecordInfo.TotalCount);
			//SystemLog.Printf("           MinSize     = %u", SubrecordInfo.MinSize);
			//SystemLog.Printf("           MaxSize     = %u", SubrecordInfo.MaxSize);
			//SystemLog.Printf("           MinCount    = %u", SubrecordInfo.MinCount);
			//SystemLog.Printf("           MaxCount    = %u", SubrecordInfo.MaxCount);

			++Index;
		}
	}

	//fclose(pFile);
}

std::string::size_type myreplace(std::string& s, const std::string& from, const std::string& to)
{
	std::string::size_type cnt(std::string::npos);

	if(from != to && !from.empty())
	{
		std::string::size_type pos1(0);
		std::string::size_type pos2(0);
		const std::string::size_type from_len(from.size());
		const std::string::size_type to_len(to.size());
		cnt = 0;

		while((pos1 = s.find(from, pos2)) != std::string::npos)
		{
			s.replace(pos1, from_len, to);
			pos2 = pos1 + to_len;
			++cnt;
		}
	}

	return cnt;
}


void CreateRawClasses (const char* pBasePath)
{
	char OutputPath[512];
	char LowerTypeName[8];
	char LowerTypeName1[8];
	char UpperTypeName[8];
	FILE* pFile;
	char Buffer[512];

	std::ifstream t1("BaseRecordClass.h");
	std::string ClassHFile((std::istreambuf_iterator<char>(t1)), std::istreambuf_iterator<char>());

	std::ifstream t2("BaseRecordClass.cpp");
	std::string ClassCppFile((std::istreambuf_iterator<char>(t2)), std::istreambuf_iterator<char>());

	if (ClassHFile.length() <= 0 || ClassCppFile.length() <= 0) return;

	for (CRecordInfoMap::iterator iter = RecordInfos.begin(); iter != RecordInfos.end(); ++iter)
	{
		srrectype_t Type         = (*iter).first;
		recordinfo_t& RecordInfo = (*iter).second;

		printf("Ouputting classes for %4.4s...\n", Type.Name);

		memcpy(LowerTypeName, Type.Name, 4);
		memcpy(UpperTypeName, Type.Name, 4);
		LowerTypeName[4] = 0;
		UpperTypeName[4] = 0;
		strupr(UpperTypeName);
		strlwr(LowerTypeName);
		LowerTypeName[0] = toupper(LowerTypeName[0]);

		std::string CppFile(ClassCppFile);
		std::string HFile(ClassHFile);

		myreplace(CppFile, "%Type%", LowerTypeName);
		myreplace(HFile,   "%Type%", LowerTypeName);
		myreplace(CppFile, "%TYPE%", UpperTypeName);
		myreplace(HFile,   "%TYPE%", UpperTypeName);

		std::string SRDefs;
		std::string SRAdd;
		std::string SRDel;
		std::string SRCreate;
		int SRCount = 0;

		for (CSubrecordInfoMap::iterator iter1 = RecordInfo.SubrecordInfos.begin(); iter1 != RecordInfo.SubrecordInfos.end(); ++iter1, ++SRCount)
		{
			srrectype_t Type1               = (*iter1).first;
			subrecordinfo_t& SubrecordInfo  = (*iter1).second;

			memcpy(LowerTypeName1, Type1.Name, 4);
			LowerTypeName1[4] = 0;
			strlwr(LowerTypeName1);
			LowerTypeName1[0] = toupper(LowerTypeName1[0]);

			_snprintf(Buffer, 500, "\tCSrSubrecord*		m_p%sData;\n", LowerTypeName1);
			SRDefs += Buffer;

			_snprintf(Buffer, 500, "\tDEFINE_SRSUBRECCREATE(SR_NAME_%4.4s, CSrDataSubrecord::Create)\n", Type1.Name);
			SRCreate += Buffer;

			_snprintf(Buffer, 500, "\t%s (pSubrecord->GetRecordType() == SR_NAME_%4.4s)\n\t{\n\t\tm_p%sData = SrCastClass(CSrDwordSubrecord, pSubrecord);\n\t}\n", SRCount == 0 ? "if" : "else if", Type1.Name, LowerTypeName1);
			SRAdd += Buffer;

			_snprintf(Buffer, 500, "\t%s (m_p%4.4sData == pSubrecord)\n\t\tm_p%4.4sData = NULL;\n", SRCount == 0 ? "if" : "else if", LowerTypeName1, LowerTypeName1);
			SRDel += Buffer;			
		}

		myreplace(HFile,   "%SubRecordDefs%",	 SRDefs);
		myreplace(HFile,   "%AddSubrecords%",	 SRAdd);
		myreplace(HFile,   "%DeleteSubrecords%", SRDel);
		myreplace(HFile,   "%SubRecordCreate%",  SRCreate);

		myreplace(CppFile, "%SubRecordDefs%",	 SRDefs);
		myreplace(CppFile, "%AddSubrecords%",	 SRAdd);
		myreplace(CppFile, "%DeleteSubrecords%", SRDel);
		myreplace(CppFile, "%SubRecordCreate%",  SRCreate);

		_snprintf(OutputPath, 500, "%sSr%4.4sRecord.h", pBasePath, LowerTypeName);
		pFile = fopen(OutputPath, "wt");

		if (pFile != NULL)
		{
			fwrite(HFile.c_str(), 1, HFile.length(), pFile);
			fclose(pFile);
		}

		_snprintf(OutputPath, 500, "%sSr%4.4sRecord.cpp", pBasePath, LowerTypeName);
		pFile = fopen(OutputPath, "wt");

		if (pFile != NULL)
		{
			fwrite(CppFile.c_str(), 1, CppFile.length(), pFile);
			fclose(pFile);
		}

		//break;
	}	

}


int _tmain(int argc, _TCHAR* argv[])
{
	SystemLog.Open("testload.log");
	

	//Strings1.Load("D:\\Steam\\steamapps\\common\\skyrim\\Data\\Strings\\Skyrim_english.DLSTRINGS");
	//Strings2.Load("D:\\Steam\\steamapps\\common\\skyrim\\Data\\Strings\\Skyrim_english.ILSTRINGS");
	//Strings3.Load("D:\\Steam\\steamapps\\common\\skyrim\\Data\\Strings\\Skyrim_english.STRINGS");

	//Strings1.Dump();
	//Strings2.Dump();
	//Strings3.Dump();

	printf("Loading file...\n");
	TestFile1.Load("D:\\Steam\\steamapps\\common\\skyrim\\Data\\Skyrim.esm");
	//TestFile.GetEspFile().Save("D:\\Steam\\steamapps\\common\\skyrim\\Data\\Skyrim-2.esm");
	GatherTopLevelInfos(TestFile1);
	DumpRecordInfos();
	//DumpRecordInfos1();

	//CreateRawClasses("d:\\temp\\classes\\");

	//BsaFile.Load("D:\\Steam\\steamapps\\common\\skyrim\\Data\\skyrim - animations.bsa");
	//BsaFile.Save("D:\\Steam\\steamapps\\common\\skyrim\\Data\\skyrim - animations1.bsa");
	
	return 0;
}


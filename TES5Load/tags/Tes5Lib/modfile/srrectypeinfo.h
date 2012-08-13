#ifndef __SRRECTYPEINFO_H
#define __SRRECTYPEINFO_H


struct srrectypeinfo_t
{
	srrectype_t Type;
	const char* Name;
	int ClassID;
	const srrecfieldmap_t& FieldMap;
	CSrRecord* (*CreateFunc) (void);
};


const srrectypeinfo_t* GetSrRecTypeInfo (const srrectype_t RecordType);
const char* GetSrRecTypeName (const srrectype_t RecordType);

#endif
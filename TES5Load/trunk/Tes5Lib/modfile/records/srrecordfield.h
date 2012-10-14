/*===========================================================================
 *
 * File:	SrRecordfield.H
 * Author:	Dave Humphrey (dave@uesp.net)
 * Created On:	26 November 2011
 *
 * Records will be considered to be composed of a number of fields 
 * for the purposes of representing them in the form of strings.
 *
 *=========================================================================*/
#ifndef __SRRECORDFIELD_H
#define __SRRECORDFIELD_H


/*===========================================================================
 *
 * Begin Required Includes
 *
 *=========================================================================*/
  #include "../../common/srtypes.h"
  #include "../srfields.h"
  #include "../../common/dl_map.h"
/*===========================================================================
 *		End of Required Includes
 *=========================================================================*/


/*===========================================================================
 *
 * Begin Definitions
 *
 *=========================================================================*/

	/* Record field flags */
  #define SR_RECFIELD_FLAG_LARGE	1	/* Possibly large amount of data in field */
  #define SR_RECFIELD_FLAG_INEXACT	2	/* Cannot be expressed exactly in string form */
  #define SR_RECFIELD_FLAG_NOLIST	4	/* Is not output in lists by default */
  #define SR_RECFIELD_FLAG_NOCSV	8	/* Is not input/output to CSV files by default */
  #define SR_RECFIELD_FLAG_ALNUM	16	/* Must be alpha-numeric */

	/* Shortcuts */
  #define SRRF_NOCSV SR_RECFIELD_FLAG_NOCSV
  #define SRRF_ALNUM SR_RECFIELD_FLAG_ALNUM

	/* Macros to define/declare a compare field method */
  #define DECLARE_SRCOMPFIELD(Name)  int Name (CSrRecord* pRecord, long Reserved = 0);
  #define BEGIN_SRCOMPFIELD(Name)    int Name (CSrRecord* pRecord, long Reserved) {
  #define END_SRCOMPFIELD()          return (0); }

  #define DEFINE_SRCOMPFIELDINT(Class, Name, Function) \
	int Class::Name (CSrRecord* pRecord, long Reserved) { \
		if (pRecord == NULL) return (1); \
		Class* pRecord1 = SrCastClass(Class, pRecord); \
		if (pRecord1 == NULL) return (1); \
		return (int)this->Function() - (int) pRecord1->Function(); }

  #define DEFINE_SRCOMPFIELDDWORD(Class, Name, Function) \
	int Class::Name (CSrRecord* pRecord, long Reserved) { \
		if (pRecord == NULL) return (1); \
		Class* pRecord1 = SrCastClass(Class, pRecord); \
		if (pRecord1 == NULL) return (1); \
		dword Value1 = (dword) this->Function(); \
		dword Value2 = (dword) pRecord1->Function(); \
		if (Value1 == Value2) return (0); \
		if (Value1 > Value2)  return (1); \
		return (-1); }

   #define DEFINE_SRCOMPFIELDDWORD1(Class, Name, FuncValue) \
	int Class::Name (CSrRecord* pRecord, long Reserved) { \
		if (pRecord == NULL) return (1); \
		Class* pRecord1 = SrCastClass(Class, pRecord); \
		if (pRecord1 == NULL) return (1); \
		dword Value1 = (dword) this->FuncValue; \
		dword Value2 = (dword) pRecord1->FuncValue; \
		if (Value1 == Value2) return (0); \
		if (Value1 > Value2)  return (1); \
		return (-1); }

  #define DEFINE_SRCOMPFIELDFLOAT(Class, Name, Function, Digits) \
	int Class::Name (CSrRecord* pRecord, long Reserved) { \
		if (pRecord == NULL) return (1); \
		Class* pRecord1 = SrCastClass(Class, pRecord); \
		if (pRecord1 == NULL) return (1); \
		return (int)( ( ((float)this->Function()) - ((float)pRecord1->Function()) )  * Digits); }

#define DEFINE_SRCOMPFIELDFLOAT1(Class, Name, FuncValue, Digits) \
	int Class::Name (CSrRecord* pRecord, long Reserved) { \
		if (pRecord == NULL) return (1); \
		Class* pRecord1 = SrCastClass(Class, pRecord); \
		if (pRecord1 == NULL) return (1); \
		return (int)( ( ((float)this->FuncValue) - ((float)pRecord1->FuncValue) )  * Digits); }

  #define DEFINE_SRCOMPFIELDFLOAT1(Class, Name, FuncValue, Digits) \
	int Class::Name (CSrRecord* pRecord, long Reserved) { \
		if (pRecord == NULL) return (1); \
		Class* pRecord1 = SrCastClass(Class, pRecord); \
		if (pRecord1 == NULL) return (1); \
		return (int)( ( ((float)this->FuncValue) - ((float)pRecord1->FuncValue) )  * Digits); }

  #define DEFINE_SRCOMPFIELDSTRING(Class, Name, Function) \
	int Class::Name (CSrRecord* pRecord, long Reserved) { \
		if (pRecord == NULL) return (1); \
		Class* pRecord1 = SrCastClass(Class, pRecord); \
		if (pRecord1 == NULL) return (1); \
		return SafeStringCompare((const char *)this->Function(), (const char *)pRecord1->Function(), true); }

  #define DEFINE_SRCOMPFIELDEDITORID(Class, Name, Function) \
	int Class::Name (CSrRecord* pRecord, long Reserved) { \
		if (pRecord == NULL) return (1); \
		Class* pRecord1 = SrCastClass(Class, pRecord); \
		if (pRecord1 == NULL) return (1); \
		if (m_pParent != NULL && pRecord1 != NULL) { \
			return SafeStringCompare(m_pParent->GetEditorID(Function()), m_pParent->GetEditorID(pRecord1->Function()), true); } \
        return (1); } \

  #define DEFINE_SRCOMPFIELD(Name, Function)    int Name (CSrRecord* pRecord, long Reserved) {\
							return (Function); }
  #define BEGIN_SRCOMPFIELD(Name)    int Name (CSrRecord* pRecord, long Reserved) {
  #define END_SRCOMPFIELD()          return (0); }

	/* Macros to define/declare a get field method */
  #define DECLARE_SRGETFIELD(Name)  bool Name (CSString& String, long Reserved = 0);
  #define BEGIN_SRGETFIELD(Name)    bool Name (CSString& String, long Reserved) {
  #define END_SRGETFIELD()          return (true); }

  #define DEFINE_SRGETFIELD(Name, Function)    bool Name (CSString& String, long Reserved) {\
							Function; return (true); }

	/* Macros to define/declare a set field method */
  #define DECLARE_SRSETFIELD(Name)  bool Name (const SSCHAR* pString, long Reserved = 0);
  #define BEGIN_SRSETFIELD(Name)    bool Name (const SSCHAR* pString, long Reserved) {
  #define END_SRSETFIELD()          return (true); }

  #define DEFINE_SRSETFIELD(Name, Function)    bool Name (const SSCHAR* pString, long Reserved) {\
							Function; return (true); }

	/* Combination definitions */
  #define DECLARE_SRFIELD(Suffix) \
	bool Get##Suffix     (CSString& String, long Reserved = 0); \
	int  Compare##Suffix (CSrRecord* pRecord, long Reserved = 0); \
	bool Set##Suffix     (const SSCHAR* pString, long Reserved = 0); 	 

	/* Define a static class array to hold the field data */
  #define DECLARE_SRFIELDMAP() public: \
	static  const srrecfieldmap_t  s_FieldMap; \
	static  const srrecfield_t     s_Fields[]; \
	virtual const srrecfieldmap_t* GetFieldMap (void) const { return (&s_FieldMap); } \
	virtual const srrecfield_t*    GetFields   (void) const { return (&s_Fields[0]); } \
	virtual const srrecfield_t*    FindField   (const srrecfieldid_t FieldID);

  #define BEGIN_SRFIELDBASEMAP(Class) \
        const srrecfield_t*   Class::FindField (const srrecfieldid_t FieldID) { \
		static CSrRecFieldIDMap   s_FieldIDMap; \
		static bool s_Init = InitializeFieldMap(s_FieldIDMap); \
		return s_FieldIDMap.Lookup(FieldID); \
	} \
  	const srrecfieldmap_t Class::s_FieldMap = { NULL, Class::s_Fields }; \
	const srrecfield_t    Class::s_Fields[] = { 

  #define BEGIN_SRFIELDMAP(Class, BaseClass) \
          const srrecfield_t*   Class::FindField (const srrecfieldid_t FieldID) { \
		static CSrRecFieldIDMap   s_FieldIDMap; \
		static bool s_Init = InitializeFieldMap(s_FieldIDMap); \
		return s_FieldIDMap.Lookup(FieldID); \
	} \
	const srrecfieldmap_t Class::s_FieldMap = { &BaseClass::s_FieldMap, Class::s_Fields }; \
	const srrecfield_t    Class::s_Fields[] = { 

  #define ADD_SRFIELDMAP(Name, ID, Flags, GetMethod, SetMethod, CompareMethod) { Name, ID, Flags, (FNSRGETRECORDFIELD) GetMethod, (FNSRSETRECORDFIELD) SetMethod,  (FNSRCOMPRECORDFIELD) CompareMethod},
  #define ADD_SRFIELDALL(Name, ID, Flags, Class, AllSuffix) { Name, ID, Flags, (FNSRGETRECORDFIELD) &Class::Get##AllSuffix, (FNSRSETRECORDFIELD) &Class::Set##AllSuffix,  (FNSRCOMPRECORDFIELD) &Class::Compare##AllSuffix },

  #define END_SRFIELDMAP() { NULL, SR_FIELD_NONE, 0, NULL, NULL } };


  #define DECLARE_SRFIELD_CONDITION(Class) dword GetConditionCount (void) { return CountSubrecords(SR_NAME_CTDA); } \
			bool GetFieldConditionCount     (CSString& String, long Reserved = 0) { String.Format("%u", GetConditionCount()); return true; } \
			int  CompareFieldConditionCount (CSrRecord* pRecord, long Reserved = 0) { \
					if (pRecord == NULL) return (1); \
					Class* pRecord1 = SrCastClass(Class, pRecord); \
					if (pRecord1 == NULL) return (1); \
					dword Value1 = (dword) this->GetConditionCount(); \
					dword Value2 = (dword) pRecord1->GetConditionCount(); \
					if (Value1 == Value2) return (0); \
					if (Value1 > Value2)  return (1); \
					return (-1); } \
			bool SetFieldConditionCount     (const SSCHAR* pString, long Reserved = 0) { return false; }


	#define DECLARE_SRFIELD_FULLNAME(Class)	const char* GetItemName (void) const { return m_pItemName ? m_pItemName->GetString().c_str() : ""; } \
			void SetItemName (const SSCHAR* pString) { \
					if (m_pItemName == NULL) { \
						AddNewSubrecord(SR_NAME_FULL); \
						if (m_pItemName == NULL) return; \
						m_pItemName->InitializeNew(); } \
					m_pItemName->SetString(pString); } \
			bool GetFieldItemName     (CSString& String, long Reserved = 0) { String = GetItemName(); return true; } \
			int  CompareFieldItemName (CSrRecord* pRecord, long Reserved = 0) { \
					if (pRecord == NULL) return (1); \
					Class* pRecord1 = SrCastClass(Class, pRecord); \
					if (pRecord1 == NULL) return (1); \
					return SafeStringCompare(GetItemName(), pRecord1->GetItemName(), false); } \
			bool SetFieldItemName     (const SSCHAR* pString, long Reserved = 0) { SetItemName(pString); return true; }
	#define DECLARE_SRFIELD_ITEMNAME(Class) DECLARE_SRFIELD_FULLNAME(Class)

	#define DECLARE_SRFIELD_DESCRIPTION(Class, SRName)	const char* GetDescription (void) const { return m_pDescription ? m_pDescription->GetString().c_str() : ""; } \
			void SetDescription (const SSCHAR* pString) { \
					if (m_pDescription == NULL) { \
						AddNewSubrecord(SRName); \
						if (m_pDescription == NULL) return; \
						m_pDescription->InitializeNew(); } \
					m_pDescription->SetString(pString); } \
			bool GetFieldDescription     (CSString& String, long Reserved = 0) { String = GetDescription(); return true; } \
			int  CompareFieldDescription (CSrRecord* pRecord, long Reserved = 0) { \
					if (pRecord == NULL) return (1); \
					Class* pRecord1 = SrCastClass(Class, pRecord); \
					if (pRecord1 == NULL) return (1); \
					return SafeStringCompare(GetDescription(), pRecord1->GetDescription(), false); } \
			bool SetFieldDescription (const SSCHAR* pString, long Reserved = 0) { SetDescription(pString); return true; }

	#define DECLARE_SRFIELD_MODEL(Class, Type)	const char* GetModel (void) const { return m_pModel ? m_pModel->GetString().c_str() : ""; } \
			void SetModel (const SSCHAR* pString) { \
					if (m_pModel == NULL) { \
						AddNewSubrecord(Type); \
						if (m_pModel == NULL) return; \
						m_pModel->InitializeNew(); } \
					m_pModel->SetString(pString); } \
			bool GetFieldModel (CSString& String, long Reserved = 0) { String = GetModel(); return true; } \
			int  CompareFieldModel (CSrRecord* pRecord, long Reserved = 0) { \
					if (pRecord == NULL) return (1); \
					Class* pRecord1 = SrCastClass(Class, pRecord); \
					if (pRecord1 == NULL) return (1); \
					return SafeStringCompare(GetModel(), pRecord1->GetModel(), false); } \
			bool SetFieldModel (const SSCHAR* pString, long Reserved = 0) { SetModel(pString); return true; }


	#define DECLARE_SRFIELD_STRING(Class, Member, Name, Type)	const char* Get##Name (void) const { return Member ? Member->GetString().c_str() : ""; } \
			void Set##Name (const SSCHAR* pString) { \
					if (Member == NULL) { \
						AddNewSubrecord(Type); \
						if (Member == NULL) return; \
						Member->InitializeNew(); } \
					Member->SetString(pString); } \
			bool GetField##Name     (CSString& String, long Reserved = 0) { String = Get##Name(); return true; } \
			int  CompareField##Name (CSrRecord* pRecord, long Reserved = 0) { \
					if (pRecord == NULL) return (1); \
					Class* pRecord1 = SrCastClass(Class, pRecord); \
					if (pRecord1 == NULL) return (1); \
					return SafeStringCompare(Get##Name(), pRecord1->Get##Name(), false); } \
					bool SetField##Name (const SSCHAR* pString, long Reserved = 0) { Set##Name(pString); return true; }

	#define DECLARE_SRFIELD_METHODFLOAT(Class, Member, Name, Type)	float Get##Name (void) const { return Member ? Member->GetValue() : 0; } \
			void Set##Name (const float Value) { \
					if (Member == NULL) { \
						AddNewSubrecord(Type); \
						if (Member == NULL) return; \
						Member->InitializeNew(); } \
					Member->SetValue(Value); } \
			bool GetField##Name     (CSString& String, long Reserved = 0) { if (Member) String.Format("%g", Get##Name()); else String.Empty(); return true; } \
			int  CompareField##Name (CSrRecord* pRecord, long Reserved = 0) { \
					if (pRecord == NULL) return (1); \
					Class* pRecord1 = SrCastClass(Class, pRecord); \
					if (pRecord1 == NULL) return (1); \
					float Value1 = (float) this->Get##Name(); \
					float Value2 = (float) pRecord1->Get##Name(); \
					if (Value1 == Value2) return (0); \
					if (Value1 > Value2)  return (1); \
					return (-1); } \
			bool SetField##Name (const SSCHAR* pString, long Reserved) { \
					float Value; \
					if (!SrFieldConvertFloat(pString, Value)) return (false); \
					Set##Name(Value); return true; } 

	#define DECLARE_SRFIELD_METHODDBYTE(Class, Member, Name, Type)	byte Get##Name (void) const { return Member ? Member->GetValue() : 0; } \
			void Set##Name (const byte Value) { \
					if (Member == NULL) { \
						AddNewSubrecord(Type); \
						if (Member == NULL) return; \
						Member->InitializeNew(); } \
					Member->SetValue(Value); } \
			bool GetField##Name     (CSString& String, long Reserved = 0) { if (Member) String.Format("%u", (dword) Get##Name()); else String.Empty(); return true; } \
			int  CompareField##Name (CSrRecord* pRecord, long Reserved = 0) { \
					if (pRecord == NULL) return (1); \
					Class* pRecord1 = SrCastClass(Class, pRecord); \
					if (pRecord1 == NULL) return (1); \
					byte Value1 = (byte) this->Get##Name(); \
					byte Value2 = (byte) pRecord1->Get##Name(); \
					if (Value1 == Value2) return (0); \
					if (Value1 > Value2)  return (1); \
					return (-1); } \
			bool SetField##Name (const SSCHAR* pString, long Reserved) { \
					byte Value; \
					if (!SrFieldConvertByte(pString, Value)) return (false); \
					Set##Name(Value); return true; } 


	#define DECLARE_SRFIELD_METHODDWORD(Class, Member, Name, Type)	dword Get##Name (void) const { return Member ? Member->GetValue() : 0; } \
			void Set##Name (const dword Value) { \
					if (Member == NULL) { \
						AddNewSubrecord(Type); \
						if (Member == NULL) return; \
						Member->InitializeNew(); } \
					Member->SetValue(Value); } \
			bool GetField##Name     (CSString& String, long Reserved = 0) { if (Member) String.Format("%d", Get##Name()); else String.Empty(); return true; } \
			int  CompareField##Name (CSrRecord* pRecord, long Reserved = 0) { \
					if (pRecord == NULL) return (1); \
					Class* pRecord1 = SrCastClass(Class, pRecord); \
					if (pRecord1 == NULL) return (1); \
					dword Value1 = (dword) this->Get##Name(); \
					dword Value2 = (dword) pRecord1->Get##Name(); \
					if (Value1 == Value2) return (0); \
					if (Value1 > Value2)  return (1); \
					return (-1); } \
			bool SetField##Name (const SSCHAR* pString, long Reserved) { \
					dword Value; \
					if (!SrFieldConvertDword(pString, Value)) return (false); \
					Set##Name(Value); return true; } 

	#define DECLARE_SRFIELD_METHODWORD(Class, Member, Name, Type)	word Get##Name (void) const { return Member ? Member->GetValue() : 0; } \
			void Set##Name (const word Value) { \
					if (Member == NULL) { \
						AddNewSubrecord(Type); \
						if (Member == NULL) return; \
						Member->InitializeNew(); } \
					Member->SetValue(Value); } \
			bool GetField##Name     (CSString& String, long Reserved = 0) { if (Member) String.Format("%hd", Get##Name()); else String.Empty(); return true; } \
			int  CompareField##Name (CSrRecord* pRecord, long Reserved = 0) { \
					if (pRecord == NULL) return (1); \
					Class* pRecord1 = SrCastClass(Class, pRecord); \
					if (pRecord1 == NULL) return (1); \
					word Value1 = (word) this->Get##Name(); \
					word Value2 = (word) pRecord1->Get##Name(); \
					if (Value1 == Value2) return (0); \
					if (Value1 > Value2)  return (1); \
					return (-1); } \
			bool SetField##Name (const SSCHAR* pString, long Reserved) { \
					word Value; \
					if (!SrFieldConvertWord(pString, Value)) return (false); \
					Set##Name(Value); return true; } 

	#define DECLARE_SRFIELD_METHODDWORDF(Class, Member, Name, Type, Fmt)	dword Get##Name (void) const { return Member ? Member->GetValue() : 0; } \
			void Set##Name (const dword Value) { \
					if (Member == NULL) { \
						AddNewSubrecord(Type); \
						if (Member == NULL) return; \
						Member->InitializeNew(); } \
					Member->SetValue(Value); } \
			bool GetField##Name     (CSString& String, long Reserved = 0) { if (Member) String.Format(Fmt, Get##Name()); else String.Empty(); return true; } \
			int  CompareField##Name (CSrRecord* pRecord, long Reserved = 0) { \
					if (pRecord == NULL) return (1); \
					Class* pRecord1 = SrCastClass(Class, pRecord); \
					if (pRecord1 == NULL) return (1); \
					dword Value1 = (dword) this->Get##Name(); \
					dword Value2 = (dword) pRecord1->Get##Name(); \
					if (Value1 == Value2) return (0); \
					if (Value1 > Value2)  return (1); \
					return (-1); } \
			bool SetField##Name (const SSCHAR* pString, long Reserved) { \
					dword Value; \
					if (!SrFieldConvertDword(pString, Value)) return (false); \
					Set##Name(Value); return true; } 


	#define DECLARE_SRFIELD_METHOD(Class, Name, GetMethod, SetMethod)  \
			bool GetField##Name     (CSString& String, long Reserved = 0) { String = GetMethod(); return true; } \
			int  CompareField##Name (CSrRecord* pRecord, long Reserved = 0) { \
					if (pRecord == NULL) return (1); \
					Class* pRecord1 = SrCastClass(Class, pRecord); \
					if (pRecord1 == NULL) return (1); \
					return SafeStringCompare(GetMethod(), pRecord1->GetMethod(), false); } \
					bool SetField##Name (const SSCHAR* pString, long Reserved = 0) { SetMethod(pString); return true; }


	#define DECLARE_SRFIELD_BYTE(Class, Name, GetFunction, SetFunction) bool GetField##Name (CSString& String, long Reserved) {\
								String.Format("%d", (int) GetFunction()); return (true); } \
							int CompareField##Name (CSrRecord* pRecord, long Reserved = 0) { \
								if (pRecord == NULL) return (1); \
								Class* pRecord1 = SrCastClass(Class, pRecord); \
								if (pRecord1 == NULL) return (1); \
								byte Value1 = (byte) this->GetFunction(); \
								byte Value2 = (byte) pRecord1->GetFunction(); \
								if (Value1 == Value2) return (0); \
								if (Value1 > Value2)  return (1); \
								return (-1); } \
							bool SetField##Name (const SSCHAR* pString, long Reserved) { \
								byte Value; \
								if (!SrFieldConvertByte(pString, Value)) return (false); \
								SetFunction(Value); return true; } 

	#define DECLARE_SRFIELD_BYTE1(Class, Name, GetExpr, SetExpr) bool GetField##Name (CSString& String, long Reserved) {\
								String.Format("%d", (int) GetExpr); return (true); } \
							int CompareField##Name (CSrRecord* pRecord, long Reserved = 0) { \
								if (pRecord == NULL) return (1); \
								Class* pRecord1 = SrCastClass(Class, pRecord); \
								if (pRecord1 == NULL) return (1); \
								byte Value1 = (byte) this->GetExpr; \
								byte Value2 = (byte) pRecord1->GetExpr; \
								if (Value1 == Value2) return (0); \
								if (Value1 > Value2)  return (1); \
								return (-1); } \
							bool SetField##Name (const SSCHAR* pString, long Reserved) { \
								byte Value; \
								if (!SrFieldConvertByte(pString, Value)) return (false); \
								SetExpr = (byte) Value; return true; } 

	#define DECLARE_SRFIELD_BOOL(Class, Name, GetFunction, SetFunction) bool GetField##Name (CSString& String, long Reserved) {\
								String = BooleanToString(GetFunction()); return (true); } \
							int CompareField##Name (CSrRecord* pRecord, long Reserved = 0) { \
								if (pRecord == NULL) return (1); \
								Class* pRecord1 = SrCastClass(Class, pRecord); \
								if (pRecord1 == NULL) return (1); \
								int Value1 = (int) this->GetFunction(); \
								int Value2 = (int) pRecord1->GetFunction(); \
								if (Value1 == Value2) return (0); \
								if (Value1 > Value2)  return (1); \
								return (-1); } \
							bool SetField##Name (const SSCHAR* pString, long Reserved) { \
								bool Value; \
								if (!SrFieldConvertBoolean(pString, Value)) return (false); \
								SetFunction(Value); return true; } 

	#define DECLARE_SRFIELD_BOOL1(Class, Name, Flags, Mask) bool GetField##Name (CSString& String, long Reserved) {\
								String = BooleanToString(CheckFlagBits(Flags, Mask)); return (true); } \
							int CompareField##Name (CSrRecord* pRecord, long Reserved = 0) { \
								if (pRecord == NULL) return (1); \
								Class* pRecord1 = SrCastClass(Class, pRecord); \
								if (pRecord1 == NULL) return (1); \
								int Value1 = (int) CheckFlagBits(this->Flags, Mask); \
								int Value2 = (int) CheckFlagBits(pRecord1->Flags, Mask); \
								if (Value1 == Value2) return (0); \
								if (Value1 > Value2)  return (1); \
								return (-1); } \
							bool SetField##Name (const SSCHAR* pString, long Reserved) { \
								bool Value; \
								if (!SrFieldConvertBoolean(pString, Value)) return (false); \
								FlipFlagBits(Flags, Mask, Value); return true; } 

	#define DECLARE_SRFIELD_DWORD(Class, Name, GetFunction, SetFunction) bool GetField##Name (CSString& String, long Reserved) {\
								String.Format("%u", GetFunction()); return (true); } \
							int CompareField##Name (CSrRecord* pRecord, long Reserved = 0) { \
								if (pRecord == NULL) return (1); \
								Class* pRecord1 = SrCastClass(Class, pRecord); \
								if (pRecord1 == NULL) return (1); \
								dword Value1 = (dword) this->GetFunction(); \
								dword Value2 = (dword) pRecord1->GetFunction(); \
								if (Value1 == Value2) return (0); \
								if (Value1 > Value2)  return (1); \
								return (-1); } \
							bool SetField##Name (const SSCHAR* pString, long Reserved) { \
								dword Value; \
								if (!SrFieldConvertDword(pString, Value)) return (false); \
								SetFunction(Value); return true; } 


	#define DECLARE_SRFIELD_DWORD1(Class, Name, GetExpression, SetExpression) bool GetField##Name (CSString& String, long Reserved) {\
								String.Format("%u", GetExpression); return (true); } \
							int CompareField##Name (CSrRecord* pRecord, long Reserved = 0) { \
								if (pRecord == NULL) return (1); \
								Class* pRecord1 = SrCastClass(Class, pRecord); \
								if (pRecord1 == NULL) return (1); \
								dword Value1 = (dword) this->GetExpression; \
								dword Value2 = (dword) pRecord1->GetExpression; \
								if (Value1 == Value2) return (0); \
								if (Value1 > Value2)  return (1); \
								return (-1); } \
							bool SetField##Name (const SSCHAR* pString, long Reserved) { \
								dword Value; \
								if (!SrFieldConvertDword(pString, Value)) return (false); \
								SetExpression = Value; return true; } 

	#define DECLARE_SRFIELD_INT1(Class, Name, GetExpression, SetExpression) bool GetField##Name (CSString& String, long Reserved) {\
								String.Format("%d", GetExpression); return (true); } \
							int CompareField##Name (CSrRecord* pRecord, long Reserved = 0) { \
								if (pRecord == NULL) return (1); \
								Class* pRecord1 = SrCastClass(Class, pRecord); \
								if (pRecord1 == NULL) return (1); \
								int Value1 = (dword) this->GetExpression; \
								int Value2 = (dword) pRecord1->GetExpression; \
								if (Value1 == Value2) return (0); \
								if (Value1 > Value2)  return (1); \
								return (-1); } \
							bool SetField##Name (const SSCHAR* pString, long Reserved) { \
								int Value; \
								if (!SrFieldConvertInt(pString, Value)) return (false); \
								SetExpression = Value; return true; } 

	#define DECLARE_SRFIELD_WORD1(Class, Name, GetExpression, SetExpression) bool GetField##Name (CSString& String, long Reserved) {\
								String.Format("%hu", GetExpression); return (true); } \
							int CompareField##Name (CSrRecord* pRecord, long Reserved = 0) { \
								if (pRecord == NULL) return (1); \
								Class* pRecord1 = SrCastClass(Class, pRecord); \
								if (pRecord1 == NULL) return (1); \
								word Value1 = (word) this->GetExpression; \
								word Value2 = (word) pRecord1->GetExpression; \
								if (Value1 == Value2) return (0); \
								if (Value1 > Value2)  return (1); \
								return (-1); } \
							bool SetField##Name (const SSCHAR* pString, long Reserved) { \
								word Value; \
								if (!SrFieldConvertWord(pString, Value)) return (false); \
								SetExpression = Value; return true; } 

	#define DECLARE_SRFIELD_SHORT1(Class, Name, GetExpression, SetExpression) bool GetField##Name (CSString& String, long Reserved) {\
								String.Format("%hd", GetExpression); return (true); } \
							int CompareField##Name (CSrRecord* pRecord, long Reserved = 0) { \
								if (pRecord == NULL) return (1); \
								Class* pRecord1 = SrCastClass(Class, pRecord); \
								if (pRecord1 == NULL) return (1); \
								short Value1 = (short) this->GetExpression; \
								short Value2 = (short) pRecord1->GetExpression; \
								if (Value1 == Value2) return (0); \
								if (Value1 > Value2)  return (1); \
								return (-1); } \
							bool SetField##Name (const SSCHAR* pString, long Reserved) { \
								word Value; \
								if (!SrFieldConvertWord(pString, Value)) return (false); \
								SetExpression = (short) Value; return true; } 


	#define DECLARE_SRFIELD_DWORDFLAG1(Class, Name, GetExpression, SetExpression) bool GetField##Name (CSString& String, long Reserved) {\
								String.Format("0x%08X", GetExpression); return (true); } \
							int CompareField##Name (CSrRecord* pRecord, long Reserved = 0) { \
								if (pRecord == NULL) return (1); \
								Class* pRecord1 = SrCastClass(Class, pRecord); \
								if (pRecord1 == NULL) return (1); \
								dword Value1 = (dword) this->GetExpression; \
								dword Value2 = (dword) pRecord1->GetExpression; \
								if (Value1 == Value2) return (0); \
								if (Value1 > Value2)  return (1); \
								return (-1); } \
							bool SetField##Name (const SSCHAR* pString, long Reserved) { \
								dword Value; \
								if (!SrFieldConvertDword(pString, Value)) return (false); \
								SetExpression = Value; return true; } 


	#define DECLARE_SRFIELD_WORDFLAG1(Class, Name, GetExpression, SetExpression) bool GetField##Name (CSString& String, long Reserved) {\
								String.Format("0x%04hX", GetExpression); return (true); } \
							int CompareField##Name (CSrRecord* pRecord, long Reserved = 0) { \
								if (pRecord == NULL) return (1); \
								Class* pRecord1 = SrCastClass(Class, pRecord); \
								if (pRecord1 == NULL) return (1); \
								word Value1 = (word) this->GetExpression; \
								word Value2 = (word) pRecord1->GetExpression; \
								if (Value1 == Value2) return (0); \
								if (Value1 > Value2)  return (1); \
								return (-1); } \
							bool SetField##Name (const SSCHAR* pString, long Reserved) { \
								word Value; \
								if (!SrFieldConvertWord(pString, Value)) return (false); \
								SetExpression = Value; return true; } 


	#define DECLARE_SRFIELD_FLOAT(Class, Name, GetFunction, SetFunction) bool GetField##Name (CSString& String, long Reserved) {\
								String.Format("%g", GetFunction()); return (true); } \
							int CompareField##Name (CSrRecord* pRecord, long Reserved = 0) { \
								if (pRecord == NULL) return (1); \
								Class* pRecord1 = SrCastClass(Class, pRecord); \
								if (pRecord1 == NULL) return (1); \
								float Value1 = (float) this->GetFunction(); \
								float Value2 = (float) pRecord1->GetFunction(); \
								if (Value1 == Value2) return (0); \
								if (Value1 > Value2)  return (1); \
								return (-1); } \
							bool SetField##Name (const SSCHAR* pString, long Reserved) { \
								float Value; \
								if (!SrFieldConvertFloat(pString, Value)) return (false); \
								SetFunction(Value); return true; } 


	#define DECLARE_SRFIELD_FLOAT1(Class, Name, GetExpression, SetExpression) bool GetField##Name (CSString& String, long Reserved) {\
								String.Format("%g", GetExpression); return (true); } \
							int CompareField##Name (CSrRecord* pRecord, long Reserved = 0) { \
								if (pRecord == NULL) return (1); \
								Class* pRecord1 = SrCastClass(Class, pRecord); \
								if (pRecord1 == NULL) return (1); \
								float Value1 = (float) this->GetExpression; \
								float Value2 = (float) pRecord1->GetExpression; \
								if (Value1 == Value2) return (0); \
								if (Value1 > Value2)  return (1); \
								return (-1); } \
							bool SetField##Name (const SSCHAR* pString, long Reserved) { \
								float Value; \
								if (!SrFieldConvertFloat(pString, Value)) return (false); \
								SetExpression = Value; return true; } 


	#define DECLARE_SRFIELD_EDITORID(Class, Name, GetFunction, SetFunction) bool GetField##Name (CSString& String, long Reserved) {\
								String = GetFunction(); return (true); } \
							int CompareField##Name (CSrRecord* pRecord, long Reserved = 0) { \
								if (pRecord == NULL) return (1); \
								Class* pRecord1 = SrCastClass(Class, pRecord); \
								if (pRecord1 == NULL) return (1); \
								return SafeStringCompare(this->GetFunction(), pRecord1->GetFunction()); } \
							bool SetField##Name (const SSCHAR* pString, long Reserved) { \
								SetFunction(pString); return true; } 


	#define DECLARE_SRMETHOD_FORMID(Name, Member, Type) const char* Get##Name (void) { \
							return CSrRecord::GetEditorIDHelper(Member); } \
						srformid_t  Get##Name##ID (void) { \
								return Member ? Member->GetValue() : SR_FORMID_NULL; } \
						void Set##Name##ID (const srformid_t FormID) { \
							SetSubrecordFormID(Member, FormID, Type); } \
						void Set##Name (const char* pEditorID) { \
							SetSubrecordFormID(Member, pEditorID, Type); }


	#define DECLARE_SRFIELD_EDITORID1(Class, Name, Type) DECLARE_SRFIELD_EDITORID(Class, Name, Get##Name, Set##Name) \
														 DECLARE_SRMETHOD_FORMID(Name, m_p##Name, Type)

	#define DECLARE_SRMETHOD_FORMID1(Name, Expr) const char* Get##Name (void) { \
							return CSrRecord::GetEditorIDHelper(Expr); } \
						void Set##Name (const char* pEditorID) { \
							SetSubrecordFormID(Expr, pEditorID); }


	#define DECLARE_SRFIELD_EDITORID2(Class, Name, Expr) DECLARE_SRFIELD_EDITORID(Class, Name, Get##Name, Set##Name) \
														 DECLARE_SRMETHOD_FORMID1(Name, Expr)

/*===========================================================================
 *		End of Definitions
 *========================================================================*/


/*===========================================================================
 *
 * Begin Type Definitions
 *
 *=========================================================================*/

	/* Forward class definition */
  class CSrRecord;
  
	/* Define the type of the field get/set methods */
  typedef bool (CSrRecord::*FNSRGETRECORDFIELD)  (CSString&, long); 
  typedef bool (CSrRecord::*FNSRSETRECORDFIELD)  (const SSCHAR* pString, long); 
  typedef int  (CSrRecord::*FNSRCOMPRECORDFIELD) (CSrRecord* pRecord, long); 

	/* Holds the information on a single field */
  struct srrecfield_t
  { 
	const char*			pName;		/* Short descriptive name */
	srrecfieldid_t		FieldID;	/* Unique field identifier */
	dword				Flags;		/* Field parameters */
	FNSRGETRECORDFIELD	GetMethod;
	FNSRSETRECORDFIELD	SetMethod;
	FNSRCOMPRECORDFIELD	CompareMethod;

	bool IsLarge   (void) const { return ((Flags & SR_RECFIELD_FLAG_LARGE)   != 0); }
	bool IsInexact (void) const { return ((Flags & SR_RECFIELD_FLAG_INEXACT) != 0); }
	bool IsNoList  (void) const { return ((Flags & SR_RECFIELD_FLAG_NOLIST)  != 0); }
	bool IsNoCSV   (void) const { return ((Flags & SR_RECFIELD_FLAG_NOCSV)   != 0); }
	bool IsAlNum   (void) const { return ((Flags & SR_RECFIELD_FLAG_ALNUM)   != 0); }
  };  

	/* Holds a reference to a field pointer to a class and its base class */
  struct srrecfieldmap_t
  {
  	const srrecfieldmap_t* pBaseFieldMap;
	const srrecfield_t*    pField;
  };

  typedef TGenRefPtrMap<CSString,       srrecfield_t, const SSCHAR*>  CSrRecFieldNameMap;
  typedef TGenRefPtrMap<srrecfieldid_t, srrecfield_t, srrecfieldid_t> CSrRecFieldIDMap;

/*===========================================================================
 *		End of Type Definitions
 *=========================================================================*/


/*===========================================================================
 *
 * Begin Function Definitions
 *
 *=========================================================================*/
/*===========================================================================
 *		End of Function Definitions
 *=========================================================================*/


#endif
/*===========================================================================
 *		End of File SrRecordfield.H
 *=========================================================================*/

/*===========================================================================
 *
 * File:		SrScriptFile.H
 * Author:		Dave Humphrey (dave@uesp.net)
 * Created On:	28 January 2012
 *
 * Handles a single uncompiled PSC script file.
 *
 *=========================================================================*/
#ifndef __SRSCRIPTFILE_H
#define __SRSCRIPTFILE_H


/*===========================================================================
 *
 * Begin Required Includes
 *
 *=========================================================================*/
	#include "../common/srfile.h"
	#include "../common/srlogfile.h"
	#include "../common/textutils.h"
	#include "../common/srcallback.h"
	#include "../common/srarray.h"
	#include "../common/srptrarray.h"
	#include "../common/csvfile.h"
	#include "../modfile/srfields.h"
	#include "../modfile/srrectype.h"
	#include "../common/srtime.h"
	#include "../modfile/srfunctions.h"
	#include "../common/srblockallocator.h"
	#include "SrScriptTokens.h"
	#include "../modfile/subrecords/srvmadsubrecord.h"
	#include "srscriptrecord.h"
/*===========================================================================
 *		End of Required Includes
 *=========================================================================*/


		/* Internal type */
    #define  SR_SCRIPT_REFTYPE_UNKNOWN				-1
	#define  SR_SCRIPT_REFTYPE_NONE					0
	#define  SR_SCRIPT_REFTYPE_ACTION				1
	#define  SR_SCRIPT_REFTYPE_ACTIVATOR			2
	#define  SR_SCRIPT_REFTYPE_ACTIVEMAGICEFFECT    3
	#define  SR_SCRIPT_REFTYPE_ACTOR				4
	#define  SR_SCRIPT_REFTYPE_ACTORBASE			5
	#define  SR_SCRIPT_REFTYPE_ALIAS				6
	#define  SR_SCRIPT_REFTYPE_AMMO					7
	#define  SR_SCRIPT_REFTYPE_APPARATUS			8
	#define  SR_SCRIPT_REFTYPE_ARMOR				9
	#define  SR_SCRIPT_REFTYPE_ASSOCIATIONTYPE		10
	#define  SR_SCRIPT_REFTYPE_BOOK					11
	#define  SR_SCRIPT_REFTYPE_CELL					12
	#define  SR_SCRIPT_REFTYPE_CLASS				13
	#define  SR_SCRIPT_REFTYPE_CONSTRUCTIBLEOBJECT  14
	#define  SR_SCRIPT_REFTYPE_CONTAINER			15
	#define  SR_SCRIPT_REFTYPE_DOOR					16
	#define  SR_SCRIPT_REFTYPE_EFFECTSHADER			17
	#define  SR_SCRIPT_REFTYPE_ENCHANTMENT			18
	#define  SR_SCRIPT_REFTYPE_ENCOUNTERZONE		19
	#define  SR_SCRIPT_REFTYPE_EXPLOSION			20
	#define  SR_SCRIPT_REFTYPE_FACTION				21
	#define  SR_SCRIPT_REFTYPE_FLORA				22
	#define  SR_SCRIPT_REFTYPE_FORM					23
	#define  SR_SCRIPT_REFTYPE_FORMLIST				24
	#define  SR_SCRIPT_REFTYPE_FURNITURE			25
	#define  SR_SCRIPT_REFTYPE_GLOBALVARIABLE		26
	#define  SR_SCRIPT_REFTYPE_HAZARD				27
	#define  SR_SCRIPT_REFTYPE_IDLE					28
	#define  SR_SCRIPT_REFTYPE_IMAGESPACEMODIFIER   29
	#define  SR_SCRIPT_REFTYPE_IMPACTDATASET		30
	#define  SR_SCRIPT_REFTYPE_INGREDIENT			31
	#define  SR_SCRIPT_REFTYPE_KEY					32
	#define  SR_SCRIPT_REFTYPE_KEYWORD				33
	#define  SR_SCRIPT_REFTYPE_LEVELEDACTOR			34
	#define  SR_SCRIPT_REFTYPE_LEVELEDITEM			35
	#define  SR_SCRIPT_REFTYPE_LEVELEDSPELL			36
	#define  SR_SCRIPT_REFTYPE_LIGHT				37
	#define  SR_SCRIPT_REFTYPE_LOCATION				38
	#define  SR_SCRIPT_REFTYPE_LOCATIONALIAS		39
	#define  SR_SCRIPT_REFTYPE_LOCATIONREFTYPE		40
	#define  SR_SCRIPT_REFTYPE_MAGICEFFECT			41
	#define  SR_SCRIPT_REFTYPE_MESSAGE				42
	#define  SR_SCRIPT_REFTYPE_MISCOBJECT			43
	#define  SR_SCRIPT_REFTYPE_MUSICTYPE			44
	#define  SR_SCRIPT_REFTYPE_OBJECTREFERENCE		45
	#define  SR_SCRIPT_REFTYPE_OUTFIT				46
	#define  SR_SCRIPT_REFTYPE_PACKAGE				47
	#define  SR_SCRIPT_REFTYPE_PERK					48
	#define  SR_SCRIPT_REFTYPE_POTION				49
	#define  SR_SCRIPT_REFTYPE_PROJECTILE			50
	#define  SR_SCRIPT_REFTYPE_QUEST				51
	#define  SR_SCRIPT_REFTYPE_RACE					52
	#define  SR_SCRIPT_REFTYPE_REFERENCEALIAS		53
	#define  SR_SCRIPT_REFTYPE_SCENE				54
	#define  SR_SCRIPT_REFTYPE_SCROLL				55
	#define  SR_SCRIPT_REFTYPE_SHOUT				56
	#define  SR_SCRIPT_REFTYPE_SOULGEM				57
	#define  SR_SCRIPT_REFTYPE_SOUND				58
	#define  SR_SCRIPT_REFTYPE_SOUNDCATEGORY		59
	#define  SR_SCRIPT_REFTYPE_SPELL				60
	#define  SR_SCRIPT_REFTYPE_STATIC				61
	#define  SR_SCRIPT_REFTYPE_TALKINGACTIVATOR		62
	#define  SR_SCRIPT_REFTYPE_TOPIC				63
	#define  SR_SCRIPT_REFTYPE_TOPICINFO			64
	#define  SR_SCRIPT_REFTYPE_VISUALEFFECT			65
	#define  SR_SCRIPT_REFTYPE_VOICETYPE			66
	#define  SR_SCRIPT_REFTYPE_WEAPON				67
	#define  SR_SCRIPT_REFTYPE_WEATHER				68
	#define  SR_SCRIPT_REFTYPE_WORDOFPOWER			69
	#define  SR_SCRIPT_REFTYPE_WORLDSPACE			70


/*===========================================================================
 *
 * Begin Type Definitions
 *
 *=========================================================================*/

	/* Basic error definition for now */
class CSrScriptError
{

protected:
	CSString	m_ErrorText;
	int			m_Line;
	int			m_Character;
	int			m_UserData;
	
public:

	const char* MakeErrorString (void) { return m_ErrorText; }

	void SetUserData (const int Value) { m_UserData = Value; }
};

typedef CSrPtrArray<CSrScriptError> CSrScriptErrorArray;


struct srscriptreftype_t
{
	int					Type;
	const char*			pName;
	const srrectype_t	RecordType;
	dword				Flags;
};


typedef TGenRefPtrMap<const char*, srscriptreftype_t, const char*> CSrScriptRefTypeStringMap;
typedef TGenRefPtrMap<int, srscriptreftype_t, int> CSrScriptRefTypeIntMap;


struct srscriptproperty_t
{
	CSString	Name;
	int			Type;
	CSString	TypeName;
	int			RefType;	
	int			UserData;
	CSString	Value;
};

typedef CSrPtrArray<srscriptproperty_t> CSrScriptPropertyArray;


struct srnewscriptpropertyinfo_t
{
	CSString	Type;
	CSString	Name;
	CSString	Value;
	CSString	Document;
	bool		Hidden;
	bool		Array;
};


struct srscriptinfo_t
{
	CSString	Name;
	bool		Hidden;
	bool		Conditional;
	bool		HasSource;

	srscriptinfo_t() : Hidden(false), Conditional(false), HasSource(false)
	{
	}
};

typedef CSrPtrArray<srscriptinfo_t> CSrScriptInfoArray;
typedef TGenRefPtrMap<const char*, srscriptinfo_t, const char*> CSrScriptInfoMap;
/*===========================================================================
 *		End of Type Definitions
 *=========================================================================*/


/*===========================================================================
 *
 * Begin CSrScriptFile Definitions
 *
 *=========================================================================*/
class CSrScriptFile
{
protected:
	CSString	m_Filename;
	CSString	m_ScriptName;
	bool		m_IsModified;
	bool		m_IsLoaded;

	CSString	m_ScriptText;

	CSrScriptTokenArray		m_Tokens;

	CSrScriptPropertyArray	m_Properties;

	CSrScriptRecord	m_ScriptRecord;

protected:
	void UpdateName (void);

	bool ParseArrayProperty    (dword& i);
	bool ParseNonArrayProperty (dword& i);

	bool TokenEOL      (const char*& pParse);
	bool TokenComment  (const char*& pParse);
	bool TokenDocument (const char*& pParse);
	bool TokenNumber   (const char*& pParse);
	bool TokenAlpha    (const char*& pParse);
	bool TokenString   (const char*& pParse);
	bool TokenOperator (const char*& pParse);


public:
	CSrScriptFile();
	~CSrScriptFile();

	void Destroy (void);

	srscriptproperty_t*  AddProperty (const srnewscriptpropertyinfo_t NewProperty);

	dword Find (srfinddata_t& FindData);

	bool IsFilename   (const char* pFilename)   const { return stricmp(m_Filename, pFilename) == 0; }
	bool IsScriptName (const char* pScriptName) const { return stricmp(m_ScriptName, pScriptName) == 0; }
	bool IsModified   (void) const { return m_IsModified; }

	const char* GetFilename   (void) const { return m_Filename; }
	const char* GetScriptName (void) const { return m_ScriptName.c_str(); }
	const char* GetScriptText (void) const { return m_ScriptText; }
	bool HasScriptName (void) const { return !m_ScriptName.IsEmpty(); }
	bool IsLoaded      (void) const { return m_IsLoaded; }

	CSrScriptTokenArray&    GetTokens     (void) { return m_Tokens; }
	CSrScriptPropertyArray& GetProperties (void) { return m_Properties; }

	dword GetScriptTextLength (void) const { return m_ScriptText.GetLength(); }
	
	bool Load (const char* pFilename);
	bool Save (const char* pFilename = NULL);

	bool ParseProperties (void);

	bool Tokenize   (void);
	void DumpTokens (void);

	void SetIsModified (const bool    Value) { m_IsModified = Value; }
	void SetScriptText (const char* pString) { m_ScriptText = pString; }

};

typedef CSrPtrArray<CSrScriptFile> CSrScriptFileArray;
/*===========================================================================
 *		End of CSrScriptFile Definition
 *=========================================================================*/


/*===========================================================================
 *
 * Begin External Definitions
 *
 *=========================================================================*/
	
	extern srscriptreftype_t g_SrScriptRefTypes[];

	srscriptreftype_t* GetSrScriptRefTypeInfo (const char* pName);
	srscriptreftype_t* GetSrScriptRefTypeInfo (const int Type);
	int GetSrScriptRefType (const char* pName);

/*===========================================================================
 *		End of External Definitions
 *=========================================================================*/


#endif
/*===========================================================================
 *		End of File SrScriptFile.h
 *=========================================================================*/

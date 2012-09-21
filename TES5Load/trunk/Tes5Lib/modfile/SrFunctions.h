/*===========================================================================
 *
 * File:		SrFunctions.H
 * Author:		Dave Humphrey (dave@uesp.net)
 * Created On:	3 December 2011
 *
 * Script/console function data.
 *
 *=========================================================================*/
#ifndef __SRFUNCTIONS_H
#define __SRFUNCTIONS_H


/*===========================================================================
 *
 * Begin Required Includes
 *
 *=========================================================================*/
  #include "srmoddefs.h"  
/*===========================================================================
 *		End of Required Includes
 *=========================================================================*/


/*===========================================================================
 *
 * Begin Definitions
 *
 *=========================================================================*/

		/* Arbitrary limit on function parameter count. Max used in Skyrim is 9 */
	#define SR_FUNCTION_MAXPARAMS	10

		/* Function Flags 
		 *		Flags in the lower 16 bits are from the Skyrim function data
		 *		Flags in the upper 16 bits are custom SkyEdit flags 
		 */
	#define SR_FUNCTION_FLAG_REF		0x01000000
	#define SR_FUNCTION_FLAG_BLOCK		0x02000000
	#define SR_FUNCTION_FLAG_CONSOLE	0x04000000
	#define SR_FUNCTION_FLAG_SCRIPT		0x08000000
	#define SR_FUNCTION_FLAG_IGNORE		0x10000000
	#define SR_FUNCTION_FLAG_CONDITION	0x20000000		//Functions that should be permitted in conditions

		/* Function parameter flags */
	#define SR_FUNCPARAM_FLAG_OPT 0x01

		/* Function Parameter Types */
	#define SR_FUNCPARAM_UNKNOWN		-1
	#define SR_FUNCPARAM_STRING			0 
	#define SR_FUNCPARAM_INTEGER		1 
	#define SR_FUNCPARAM_FLOAT			2 
	#define SR_FUNCPARAM_OBJECTID3		3 
	#define SR_FUNCPARAM_REFERENCE		4 
	#define SR_FUNCPARAM_ACTORVALUE		5 
	#define SR_FUNCPARAM_ACTOR			6 
	#define SR_FUNCPARAM_SPELLITEM		7 
	#define SR_FUNCPARAM_AXIS			8 
	#define SR_FUNCPARAM_CELL			9 
	#define SR_FUNCPARAM_ANIMGROUP		10
	#define SR_FUNCPARAM_MAGICITEM		11
	#define SR_FUNCPARAM_SOUND			12
	#define SR_FUNCPARAM_TOPIC			13
	#define SR_FUNCPARAM_QUEST			14
	#define SR_FUNCPARAM_RACE			15
	#define SR_FUNCPARAM_CLASS			16
	#define SR_FUNCPARAM_FACTION		17
	#define SR_FUNCPARAM_GENDER			18
	#define SR_FUNCPARAM_GLOBAL			19
	#define SR_FUNCPARAM_FURNITURE		20
	#define SR_FUNCPARAM_WEAPON			21
	#define SR_FUNCPARAM_VARNAME		22
	#define SR_FUNCPARAM_STAGE			23
	#define SR_FUNCPARAM_MAPMARKER		24
	#define SR_FUNCPARAM_ACTORBASE		25
	#define SR_FUNCPARAM_CONTAINER		26
	#define SR_FUNCPARAM_WORLDSPACE		27
	#define SR_FUNCPARAM_CRIME			28
	#define SR_FUNCPARAM_PACKAGE		29
	#define SR_FUNCPARAM_COMBATSTYLE	30
	#define SR_FUNCPARAM_MAGICEFFECT	31
	#define SR_FUNCPARAM_FORMTYPE		32
	#define SR_FUNCPARAM_WEATHER		33
	#define SR_FUNCPARAM_34				34
	#define SR_FUNCPARAM_OWNER			35
	#define SR_FUNCPARAM_EFFECTSHADER	36
	#define SR_FUNCPARAM_FORMLIST		37
	#define SR_FUNCPARAM_38				38
	#define SR_FUNCPARAM_PERK			39
	#define SR_FUNCPARAM_NOTE			40
	#define SR_FUNCPARAM_MISCSTAT		41
	#define SR_FUNCPARAM_IMAGESPACEID	42
	#define SR_FUNCPARAM_IMAGESPACE		43
	#define SR_FUNCPARAM_44				44
	#define SR_FUNCPARAM_45				45
	#define SR_FUNCPARAM_EVENTFUNC		46
	#define SR_FUNCPARAM_EVENTMEMBER	47
	#define SR_FUNCPARAM_DATA			48
	#define SR_FUNCPARAM_VOICETYPE		49
	#define SR_FUNCPARAM_ENCOUNTERZONE	50
	#define SR_FUNCPARAM_IDLE			51
	#define SR_FUNCPARAM_MESSAGE		52
	#define SR_FUNCPARAM_EQUIPABLEITEM	53
	#define SR_FUNCPARAM_ALIGNMENT		54
	#define SR_FUNCPARAM_EQUIPTYPE		55
	#define SR_FUNCPARAM_OBJECTID56		56
	#define SR_FUNCPARAM_MUSIC			57
	#define SR_FUNCPARAM_CRITICALSTAGE	58
	#define SR_FUNCPARAM_KEYWORD		59
	#define SR_FUNCPARAM_LOCREFTYPE		60
	#define SR_FUNCPARAM_LOCATION		61
	#define SR_FUNCPARAM_FORM			62
	#define SR_FUNCPARAM_QUESTALIAS		63
	#define SR_FUNCPARAM_SHOUT			64
	#define SR_FUNCPARAM_WORDOFPOWER	65
	#define SR_FUNCPARAM_66				66
	#define SR_FUNCPARAM_SCENE			67
	#define SR_FUNCPARAM_CASTSOURCE		68
	#define SR_FUNCPARAM_ASSOCTYPE		69
	#define SR_FUNCPARAM_WARDSTATE		70
	#define SR_FUNCPARAM_PACKDATANULL	71
	#define SR_FUNCPARAM_PACKDATANUM	72
	#define SR_FUNCPARAM_FURNANIM		73
	#define SR_FUNCPARAM_FURNENTRY		74
	#define SR_FUNCPARAM_75				75
	#define SR_FUNCPARAM_VMVARNAME		76
	#define SR_FUNCPARAM_REFEFEFCT		77
	#define SR_FUNCPARAM_PACKDATALOC	78
	#define SR_FUNCPARAM_SOUNDCATE		79
	#define SR_FUNCPARAM_SKILLACTION	80
	#define SR_FUNCPARAM_KNOWFORM		81
	#define SR_FUNCPARAM_REGION			82
	#define SR_FUNCPARAM_ACTION			83

/*===========================================================================
 *		End of Definitions
 *=========================================================================*/


/*===========================================================================
 *
 * Begin Type Definitions
 *
 *=========================================================================*/

struct srfuncparam_t
{
	dword	Type;
	dword	Flags;
};

  
struct srfunction_t
{
	dword			OpCode;
	const char*		Name;
	const char*		ShortName;
	dword			Flags;
	const char*		HelpText;
	dword			NumParams;
	srfuncparam_t	Params[SR_FUNCTION_MAXPARAMS];
};

/*===========================================================================
 *		End of Type Definitions
 *=========================================================================*/


/*===========================================================================
 *
 * Begin Function Definitions
 *
 *=========================================================================*/
	srfunction_t* GetSrFunction	(const char* pString);
	srfunction_t* GetSrFunction	(const dword OpCode);
	bool GetSrFunctionParamTypeValue (int& Value, const SSCHAR* pString);
	const SSCHAR* GetSrFunctionParamTypeString (const int Value);
	bool IsSrFunctionParamFormID (const dword ParamType);
	bool IsSrFunctionParamString (const dword ParamType);

	class CSrRecordHandler;
	bool SrCheckFunctionParam (const char* pString, const dword ParamType, CSrRecordHandler* pRecordHandler);
	bool SrFunctionParamToString (CSString& Output, const dword ParamType, const dword ParamValue, CSrRecordHandler* pRecordHandler);
	bool SrFunctionParamFromString (int& ParamValue, const char* pString, const dword ParamType, CSrRecordHandler* pRecordHandler);
/*===========================================================================
 *		End of Function Definitions
 *=========================================================================*/


/*===========================================================================
 *
 * Begin External Definitions
 *
 *=========================================================================*/
	extern srfunction_t g_SrFunctions[];
	extern const dword g_SrFunctionCount;
/*===========================================================================
 *		End of External Definitions
 *=========================================================================*/


#endif
/*===========================================================================
 *		End of File SrFunctions.H
 *=========================================================================*/

/*===========================================================================
 *
 * File:		Srfields.CPP
 * Author:		Dave Humphrey (dave@uesp.net)
 * Created On:	26 November 2011
 *
 * Description
 *
 *=========================================================================*/

	/* Include Files */
#include "srfields.h"
#include "math.h"
#include "ctype.h"
#include "limits.h"


/*===========================================================================
 *
 * Begin Field Text Strings
 *
 *=========================================================================*/
BEGIN_STRINGVALUE(s_SrFields)
	ADD_STRINGVALUE( SR_FIELD_UNKNOWN,			"Unknown")
	ADD_STRINGVALUE( SR_FIELD_NONE,				"None")
	ADD_STRINGVALUE( SR_FIELD_RECORDTYPE,		"RecordType")
	ADD_STRINGVALUE( SR_FIELD_FORMID,			"FormID")
	ADD_STRINGVALUE( SR_FIELD_EDITORID,			"EditorID")
	ADD_STRINGVALUE( SR_FIELD_ITEMNAME,			"ItemName")
	ADD_STRINGVALUE( SR_FIELD_FULLNAME,			"FullName")
	ADD_STRINGVALUE( SR_FIELD_VALUE,			"Value")
	ADD_STRINGVALUE( SR_FIELD_WEIGHT,			"Weight")
	ADD_STRINGVALUE( SR_FIELD_TYPE,				"Type")
	ADD_STRINGVALUE( SR_FIELD_BIPED,			"Biped")
	ADD_STRINGVALUE( SR_FIELD_ICON,				"Icon")
	ADD_STRINGVALUE( SR_FIELD_ICON2,			"Icon2")
	ADD_STRINGVALUE( SR_FIELD_MODEL,			"Model")
	ADD_STRINGVALUE( SR_FIELD_MODEL2,			"Model2")
	ADD_STRINGVALUE( SR_FIELD_MODEL3,			"Model3")
	ADD_STRINGVALUE( SR_FIELD_MODEL4,			"Model4")
	ADD_STRINGVALUE( SR_FIELD_ARMOR,			"Armor")
	ADD_STRINGVALUE( SR_FIELD_DAMAGE,			"Damage")
	ADD_STRINGVALUE( SR_FIELD_SPEED,			"Speed")
	ADD_STRINGVALUE( SR_FIELD_REACH,			"Reach")
	ADD_STRINGVALUE( SR_FIELD_HEALTH,			"Health")
	ADD_STRINGVALUE( SR_FIELD_FLAGS,			"Flags")
	ADD_STRINGVALUE( SR_FIELD_AUTHOR,			"Author")
	ADD_STRINGVALUE( SR_FIELD_SUMMARY,			"Summary")
	ADD_STRINGVALUE( SR_FIELD_VERSION,			"Version")
	ADD_STRINGVALUE( SR_FIELD_FILETYPE,			"FileType")
	ADD_STRINGVALUE( SR_FIELD_ENCHANTMENT,		"Enchantment")
	ADD_STRINGVALUE( SR_FIELD_ENCHANTPOINTS,	"EnchantPoints")
	ADD_STRINGVALUE( SR_FIELD_QUALITY,			"Quality")
	ADD_STRINGVALUE( SR_FIELD_IGNORERESIST,		"IgnoreResist")
	ADD_STRINGVALUE( SR_FIELD_HIDEAMULET,		"HideAmulet")
	ADD_STRINGVALUE( SR_FIELD_HIDERINGS,		"HideRings")
	ADD_STRINGVALUE( SR_FIELD_TEACHES,			"Teaches")
	ADD_STRINGVALUE( SR_FIELD_SCROLL,			"Scroll")
	ADD_STRINGVALUE( SR_FIELD_NOTAKE,			"NoTake")
	ADD_STRINGVALUE( SR_FIELD_TEXT,				"Text")
	ADD_STRINGVALUE( SR_FIELD_CHARGE,			"Charge")
	ADD_STRINGVALUE( SR_FIELD_COST,				"Cost")
	ADD_STRINGVALUE( SR_FIELD_AUTOCALC,			"AutoCalc")
	ADD_STRINGVALUE( SR_FIELD_FOOD,				"Food")
	ADD_STRINGVALUE( SR_FIELD_SCRIPT,			"Script")
	ADD_STRINGVALUE( SR_FIELD_CHANCENONE,		"ChanceNone")
	ADD_STRINGVALUE( SR_FIELD_CALCULATEALL,		"CalculateAll")
	ADD_STRINGVALUE( SR_FIELD_CALCULATEEACH,	"CalculateEach")
	ADD_STRINGVALUE( SR_FIELD_ITEMLIST,			"ItemList")
	ADD_STRINGVALUE( SR_FIELD_SCRIPTTEXT,		"ScriptText")
	ADD_STRINGVALUE( SR_FIELD_USES,				"Uses")
	ADD_STRINGVALUE( SR_FIELD_LEVEL,			"Level")
	ADD_STRINGVALUE( SR_FIELD_PLAYERSTART,		"PlayerStart")
	ADD_STRINGVALUE( SR_FIELD_IGNORELOS,		"IgnoreLOS")
	ADD_STRINGVALUE( SR_FIELD_ALWAYSAPPLY,		"AlwaysApply")
	ADD_STRINGVALUE( SR_FIELD_ABSORBREFLECT,	"AbsorbReflect")
	ADD_STRINGVALUE( SR_FIELD_SILENCEIMMUNE,	"SilenceImmune")
	ADD_STRINGVALUE( SR_FIELD_RECORDCOUNT,		"RecordCount")
	ADD_STRINGVALUE( SR_FIELD_ITEMCOUNT,		"ItemCount")
	ADD_STRINGVALUE( SR_FIELD_EFFECTCOUNT,		"EffectCount")
	ADD_STRINGVALUE( SR_FIELD_USERDATA,			"UserData")
	ADD_STRINGVALUE( SR_FIELD_EFFECTID,			"EffectID")
	ADD_STRINGVALUE( SR_FIELD_EFFECTNAME,		"EffectName")
	ADD_STRINGVALUE( SR_FIELD_MAGNITUDE,		"Magnitude")
	ADD_STRINGVALUE( SR_FIELD_AREA,				"Area")
	ADD_STRINGVALUE( SR_FIELD_DURATION,			"Duration")
	ADD_STRINGVALUE( SR_FIELD_RANGE,			"Range")
	ADD_STRINGVALUE( SR_FIELD_SCHOOL,			"School")
	ADD_STRINGVALUE( SR_FIELD_ACTORVALUE,		"ActorValue")
	ADD_STRINGVALUE( SR_FIELD_EFFECTDESC,		"EffectDesc")
	ADD_STRINGVALUE( SR_FIELD_SCRIPTSCHOOL,		"ScriptSchool")
	ADD_STRINGVALUE( SR_FIELD_VISUALNAME,		"VisualName")
	ADD_STRINGVALUE( SR_FIELD_HOSTILE,			"Hostile")
	ADD_STRINGVALUE( SR_FIELD_DATANAME,			"DataName")
	ADD_STRINGVALUE( SR_FIELD_NAME2,			"Name2")
	ADD_STRINGVALUE( SR_FIELD_SCRIPTID,			"ScriptID")
	ADD_STRINGVALUE( SR_FIELD_PLAYABLE,			"Playable")
	ADD_STRINGVALUE( SR_FIELD_TIME,				"Time")
	ADD_STRINGVALUE( SR_FIELD_RADIUS,			"Radius")
	ADD_STRINGVALUE( SR_FIELD_FOV,				"FOV")
	ADD_STRINGVALUE( SR_FIELD_CARRIED,			"Carried")
	ADD_STRINGVALUE( SR_FIELD_COLOR,			"Color")
	ADD_STRINGVALUE( SR_FIELD_FADE,				"Fade")
	ADD_STRINGVALUE( SR_FIELD_FALLOFF,			"Falloff")
	ADD_STRINGVALUE( SR_FIELD_DYNAMIC,			"Dynamic")
	ADD_STRINGVALUE( SR_FIELD_NEGATIVE,			"Negative")
	ADD_STRINGVALUE( SR_FIELD_DEFAULTOFF,		"DefaultOff")
	ADD_STRINGVALUE( SR_FIELD_SPOTLIGHT,		"SpotLight")
	ADD_STRINGVALUE( SR_FIELD_SPOTSHADOW,		"SpotShadow")
	ADD_STRINGVALUE( SR_FIELD_SOUNDID,			"SoundID")
	ADD_STRINGVALUE( SR_FIELD_SOUND,			"Sound")
	ADD_STRINGVALUE( SR_FIELD_ENCHANTMENTID,	"EnchantmentID")
	ADD_STRINGVALUE( SR_FIELD_USEALLSPELLS,		"UseAllSpells")
	ADD_STRINGVALUE( SR_FIELD_TEMPLATE,			"Template")
	ADD_STRINGVALUE( SR_FIELD_TEMPLATEID,		"TemplateID")
	ADD_STRINGVALUE( SR_FIELD_CAPACITY,			"Capacity")
	ADD_STRINGVALUE( SR_FIELD_SOUL,				"Soul")

	ADD_STRINGVALUE( SR_FIELD_LOCATIONX,		"LocationX")
	ADD_STRINGVALUE( SR_FIELD_LOCATIONY,		"LocationY")
	ADD_STRINGVALUE( SR_FIELD_LOCATIONZ,		"LocationZ")
	ADD_STRINGVALUE( SR_FIELD_ANGLEX,			"AngleX")
	ADD_STRINGVALUE( SR_FIELD_ANGLEY,			"AngleY")
	ADD_STRINGVALUE( SR_FIELD_ANGLEZ,			"AngleZ")
	ADD_STRINGVALUE( SR_FIELD_TELEPORTFORMID,	"TeleportFormID")
	ADD_STRINGVALUE( SR_FIELD_TELEPORTNAME,		"TeleportName")
	ADD_STRINGVALUE( SR_FIELD_TELEPORTLOCX,		"TeleportLocX")
	ADD_STRINGVALUE( SR_FIELD_TELEPORTLOCY,		"TeleportLocY")
	ADD_STRINGVALUE( SR_FIELD_TELEPORTLOCZ,		"TeleportLocZ")
	ADD_STRINGVALUE( SR_FIELD_TELEPORTANGLEX,	"TeleportAngleX")
	ADD_STRINGVALUE( SR_FIELD_TELEPORTANGLEY,	"TeleportAngleY")
	ADD_STRINGVALUE( SR_FIELD_TELEPORTANGLEZ,	"TeleportAngleZ")
	ADD_STRINGVALUE( SR_FIELD_WORLDSPACE,		"WorldSpace")
	ADD_STRINGVALUE( SR_FIELD_MARKERTYPE,		"MarkerType")
	ADD_STRINGVALUE( SR_FIELD_MARKERTYPEID,		"MarkerTypeID")
	ADD_STRINGVALUE( SR_FIELD_BASEFORMID,		"BaseFormID")
	ADD_STRINGVALUE( SR_FIELD_BASEEDITORID,		"BaseEditorID")
	ADD_STRINGVALUE( SR_FIELD_BASENAME,			"BaseName")
	ADD_STRINGVALUE( SR_FIELD_RESPAWNS,			"Respawns")
	ADD_STRINGVALUE( SR_FIELD_OPENSOUND,		"OpenSound")
	ADD_STRINGVALUE( SR_FIELD_OPENSOUNDID,		"OpenSoundID")
	ADD_STRINGVALUE( SR_FIELD_CLOSESOUND,		"CloseSound")
	ADD_STRINGVALUE( SR_FIELD_CLOSESOUNDID,		"CloseSoundID")

	ADD_STRINGVALUE( SR_FIELD_LINECOUNT,		"LineCount")
	ADD_STRINGVALUE( SR_FIELD_SIZE,				"Size")
	ADD_STRINGVALUE( SR_FIELD_REALARMOR,		"RealArmor")
	ADD_STRINGVALUE( SR_FIELD_QUESTITEM,		"QuestItem")
	ADD_STRINGVALUE( SR_FIELD_DANGEROUS,		"Dangerous")
	ADD_STRINGVALUE( SR_FIELD_IGNORED,			"Ignored")
	ADD_STRINGVALUE( SR_FIELD_DELETED,			"Deleted")

	ADD_STRINGVALUE( SR_FIELD_MINATTENUATION,       "MinAttenuation")
	ADD_STRINGVALUE( SR_FIELD_MAXATTENUATION,       "MaxAttenuation")
	ADD_STRINGVALUE( SR_FIELD_STATICATTENUATION,    "StaticAttentuation")
	ADD_STRINGVALUE( SR_FIELD_FREQADJUSTMENT,       "FreqAdjustment")
	ADD_STRINGVALUE( SR_FIELD_STARTTIME,            "StartTime")
	ADD_STRINGVALUE( SR_FIELD_STOPTIME,             "StopTime")
	ADD_STRINGVALUE( SR_FIELD_RANDOMFREQSHIFT,      "RandomFreqShift")
	ADD_STRINGVALUE( SR_FIELD_RANDOMPLAY,           "RandomPlay")
	ADD_STRINGVALUE( SR_FIELD_RANDOMLOCATION,       "RandomLocation")
	ADD_STRINGVALUE( SR_FIELD_LOOP,                 "Loop")
	ADD_STRINGVALUE( SR_FIELD_MENUSOUND,            "MenuSound")
	ADD_STRINGVALUE( SR_FIELD_IGNOREENVIRONMENT,    "IgnoreEnvironment")
	ADD_STRINGVALUE( SR_FIELD_2DSOUND,              "2DSound")
	ADD_STRINGVALUE( SR_FIELD_360LFE,               "360LFE")
	ADD_STRINGVALUE( SR_FIELD_INGREDIANT,           "Ingrediant")
	ADD_STRINGVALUE( SR_FIELD_INGREDIANTID,         "IngrediantID")
	ADD_STRINGVALUE( SR_FIELD_SPRING,               "Spring")
	ADD_STRINGVALUE( SR_FIELD_SUMMER,               "Summer")
	ADD_STRINGVALUE( SR_FIELD_FALL,                 "Fall")
	ADD_STRINGVALUE( SR_FIELD_WINTER,               "Winter")
	ADD_STRINGVALUE( SR_FIELD_SOUNDFILE,            "SoundFile")
	ADD_STRINGVALUE( SR_FIELD_REDCOLOR,             "RedColor")
	ADD_STRINGVALUE( SR_FIELD_GREENCOLOR,           "GreenColor")
	ADD_STRINGVALUE( SR_FIELD_BLUECOLOR,            "BlueColor")
	
	ADD_STRINGVALUE( SR_FIELD_RECORDTYPE,			"Name")
	ADD_STRINGVALUE( SR_FIELD_RECORDTYPE,			"Kind")

	ADD_STRINGVALUE( SR_FIELD_CNAM,					"CName")
	ADD_STRINGVALUE( SR_FIELD_KEYWORDCOUNT,			"KeywordCount")
	ADD_STRINGVALUE( SR_FIELD_KEYWORDS,				"Keywords")
	ADD_STRINGVALUE( SR_FIELD_MATERIAL,				"Material")
	ADD_STRINGVALUE( SR_FIELD_VNAM,					"VName")
	ADD_STRINGVALUE( SR_FIELD_DESCRIPTION,			"Description")
	ADD_STRINGVALUE( SR_FIELD_EFFECTTYPE,			"EffectType")
	ADD_STRINGVALUE( SR_FIELD_CONDITIONCOUNT,		"ConditionCount")
	ADD_STRINGVALUE( SR_FIELD_OPERATOR,				"Operator")
	ADD_STRINGVALUE( SR_FIELD_REFERENCE,			"Reference")
	ADD_STRINGVALUE( SR_FIELD_FUNCTION,				"Function")
	ADD_STRINGVALUE( SR_FIELD_PARAM1,				"Param1")
	ADD_STRINGVALUE( SR_FIELD_PARAM2,				"Param2")
	ADD_STRINGVALUE( SR_FIELD_CONDFLAGS,			"CondFlags")

	ADD_STRINGVALUE( SR_FIELD_COMPONENTCOUNT,		"ComponentCount")
	ADD_STRINGVALUE( SR_FIELD_RESULTCOUNT,			"ResultCount")
	ADD_STRINGVALUE( SR_FIELD_STATION,				"Station")
	ADD_STRINGVALUE( SR_FIELD_STATION,				"CraftStation")
	ADD_STRINGVALUE( SR_FIELD_RESULTITEM,			"ResultItem")
	ADD_STRINGVALUE( SR_FIELD_CONDFLAGSEX,			"CondFlags")
	ADD_STRINGVALUE( SR_FIELD_COUNT,				"Count")
	ADD_STRINGVALUE( SR_FIELD_COMPONENT,			"Component")
	ADD_STRINGVALUE( SR_FIELD_COMPITEMNAME,			"CompItemName")
	ADD_STRINGVALUE( SR_FIELD_COMPCOUNT,			"CompCount")
	ADD_STRINGVALUE( SR_FIELD_COMPFORMID,			"CompFormID")
	ADD_STRINGVALUE( SR_FIELD_EQUIPSLOT,			"EquipSlot")
	ADD_STRINGVALUE( SR_FIELD_SKILLLEVEL,			"SkillLevel")
	ADD_STRINGVALUE( SR_FIELD_CASTINGDELAY,			"CastingDelay")	
	ADD_STRINGVALUE( SR_FIELD_BASECOST,				"BaseCost")	
	ADD_STRINGVALUE( SR_FIELD_MAGICFLAGS,			"MagicFlags")	
	ADD_STRINGVALUE( SR_FIELD_BASEENCHANT,			"BaseEnchant")	
	ADD_STRINGVALUE( SR_FIELD_ITEMTYPES,			"ItemTypes")	
	ADD_STRINGVALUE( SR_FIELD_ENCHANTCOST,			"EnchantCost")	

	ADD_STRINGVALUE( SR_FIELD_PERK,					"Perk")	
	ADD_STRINGVALUE( SR_FIELD_SPELLFLAGS,			"SpellFlags")	
	ADD_STRINGVALUE( SR_FIELD_SPELLTYPE,			"SpellType")	
	ADD_STRINGVALUE( SR_FIELD_CASTTIME,				"CastTime")	
	ADD_STRINGVALUE( SR_FIELD_CASTANIM,				"CastAnim")	
	ADD_STRINGVALUE( SR_FIELD_CASTTYPE,				"CastType")	
	ADD_STRINGVALUE( SR_FIELD_PERKID,				"PerkID")	
	ADD_STRINGVALUE( SR_FIELD_EQUIPSLOTID,			"EquipSlotID")	

	ADD_STRINGVALUE( SR_FIELD_UNKNOWN1,			"Unknown1")	
	ADD_STRINGVALUE( SR_FIELD_UNKNOWN2,			"Unknown2")	
	ADD_STRINGVALUE( SR_FIELD_UNKNOWN3,			"Unknown3")	
	ADD_STRINGVALUE( SR_FIELD_UNKNOWN4,			"Unknown4")	
	ADD_STRINGVALUE( SR_FIELD_UNKNOWN5,			"Unknown5")	

	ADD_STRINGVALUE( SR_FIELD_TYPEA,			"TypeA")
	ADD_STRINGVALUE( SR_FIELD_TYPEB,			"TypeB")
	ADD_STRINGVALUE( SR_FIELD_TYPEC,			"TypeC")
	ADD_STRINGVALUE( SR_FIELD_TYPED,			"TypeD")
	ADD_STRINGVALUE( SR_FIELD_STAFFMOD,			"StaffMod")

	ADD_STRINGVALUE( SR_FIELD_PICKUPSOUND,		"PickupSound")
	ADD_STRINGVALUE( SR_FIELD_DROPSOUND,		"DropSound")
	ADD_STRINGVALUE( SR_FIELD_VANISH,			"Vanish")
	ADD_STRINGVALUE( SR_FIELD_PROJECTILE,		"Projectile")
	ADD_STRINGVALUE( SR_FIELD_BODYPARTS,		"BodyParts")
	ADD_STRINGVALUE( SR_FIELD_RACE,				"Race")
	ADD_STRINGVALUE( SR_FIELD_BAMT,				"BAMT")
	ADD_STRINGVALUE( SR_FIELD_IMPACTDATA,		"ImpactData")
	ADD_STRINGVALUE( SR_FIELD_ANAM,				"ANAM")
	ADD_STRINGVALUE( SR_FIELD_ARMMODEL,			"ArmModel")
	ADD_STRINGVALUE( SR_FIELD_USESOUND,			"UseSound")
	ADD_STRINGVALUE( SR_FIELD_POTIONFLAGS,		"PotionFlags")
	ADD_STRINGVALUE( SR_FIELD_POTIONTYPE,		"PotionType")
	ADD_STRINGVALUE( SR_FIELD_STATIC,			"Static")
	ADD_STRINGVALUE( SR_FIELD_SPELLTOME,		"SpellTome")
	ADD_STRINGVALUE( SR_FIELD_SKILLBOOK,		"SkillBook")
	ADD_STRINGVALUE( SR_FIELD_SKILL,			"Skill")
	ADD_STRINGVALUE( SR_FIELD_SPELL,			"Spell")
	ADD_STRINGVALUE( SR_FIELD_SCALE,			"Scale")
	ADD_STRINGVALUE( SR_FIELD_USEALL,			"UseAll")
	ADD_STRINGVALUE( SR_FIELD_GLOBAL,			"Global")
	ADD_STRINGVALUE( SR_FIELD_HOLDSOUND,		"HoldSound")
	ADD_STRINGVALUE( SR_FIELD_LIGHTFLAGS,		"LightFlags")
	ADD_STRINGVALUE( SR_FIELD_FLICKER,			"Flicker")
	ADD_STRINGVALUE( SR_FIELD_FLICKERSLOW,		"FlickerSlow")
	ADD_STRINGVALUE( SR_FIELD_PULSE,			"Pulse")
	ADD_STRINGVALUE( SR_FIELD_UNKNOWN9,			"Unknown9")
	ADD_STRINGVALUE( SR_FIELD_UNKNOWN10,		"Unknown10")
	ADD_STRINGVALUE( SR_FIELD_UNKNOWN11,		"Unknown11")
	ADD_STRINGVALUE( SR_FIELD_UNKNOWN12,		"Unknown12")
	ADD_STRINGVALUE( SR_FIELD_UNKNOWN13,		"Unknown13")
	ADD_STRINGVALUE( SR_FIELD_UNKNOWN14,		"Unknown14")
	ADD_STRINGVALUE( SR_FIELD_UNKNOWN15,		"Unknown15")
	ADD_STRINGVALUE( SR_FIELD_UNKNOWN16,		"Unknown16")
	ADD_STRINGVALUE( SR_FIELD_UNKNOWN17,		"Unknown17")
	ADD_STRINGVALUE( SR_FIELD_UNKNOWN18,		"Unknown18")
	ADD_STRINGVALUE( SR_FIELD_UNKNOWN19,		"Unknown19")
	ADD_STRINGVALUE( SR_FIELD_UNKNOWN20,		"Unknown20")
	ADD_STRINGVALUE( SR_FIELD_UNKNOWN21,		"Unknown21")
	ADD_STRINGVALUE( SR_FIELD_LIGHT,			"Light")
	ADD_STRINGVALUE( SR_FIELD_HITSHADER,		"HitShader")
	ADD_STRINGVALUE( SR_FIELD_ENCHANTSHADER,	"EnchantShader")
	ADD_STRINGVALUE( SR_FIELD_CASTINGART,		"CastingArt")
	ADD_STRINGVALUE( SR_FIELD_HITEFFECTART,		"HitEffectArt")
	ADD_STRINGVALUE( SR_FIELD_EFFECTOBJECT,		"EffectObject")
	ADD_STRINGVALUE( SR_FIELD_SKILLUSAGEMULT,	"SkillUsageMult")
	ADD_STRINGVALUE( SR_FIELD_UNKNOWN8,			"Unknown8")
	ADD_STRINGVALUE( SR_FIELD_HITEFFECTART,		"HitEffectArT")
	ADD_STRINGVALUE( SR_FIELD_EQUIPABILITY,		"EquipAbility")
	ADD_STRINGVALUE( SR_FIELD_DUALCAST,			"DualCast")
	ADD_STRINGVALUE( SR_FIELD_EXPLOSION,		"Explosion")	
	ADD_STRINGVALUE( SR_FIELD_IMAGESPACEMOD,	"ImageSpaceMod")	
	ADD_STRINGVALUE( SR_FIELD_DETRIMENTAL,		"Detrimental")
	ADD_STRINGVALUE( SR_FIELD_PERCENTMAG,		"PercentMag")	
	ADD_STRINGVALUE( SR_FIELD_SELFONLY,			"SelfOnly")
	ADD_STRINGVALUE( SR_FIELD_NOAREA,			"NoArea")
	ADD_STRINGVALUE( SR_FIELD_FXPERSIST,		"FXPersist")
	ADD_STRINGVALUE( SR_FIELD_BOUND,			"Bound")
	ADD_STRINGVALUE( SR_FIELD_WARD,				"Ward")
	ADD_STRINGVALUE( SR_FIELD_SOUNDCOUNT,		"SoundCount")	
	ADD_STRINGVALUE( SR_FIELD_NNAM,				"NName")
	ADD_STRINGVALUE( SR_FIELD_SNAM, 			"SName")
	ADD_STRINGVALUE( SR_FIELD_UNAM, 			"UName")
	ADD_STRINGVALUE( SR_FIELD_NAM8, 			"Name8")
	ADD_STRINGVALUE( SR_FIELD_NAM9, 			"Name9")
	ADD_STRINGVALUE( SR_FIELD_TNAM, 			"TName")
	ADD_STRINGVALUE( SR_FIELD_WNAM, 			"WName")
	ADD_STRINGVALUE( SR_FIELD_INAM, 			"IName")
	ADD_STRINGVALUE( SR_FIELD_DNAM, 			"DName")
	ADD_STRINGVALUE( SR_FIELD_IMPACTSET, 		"ImpactSet")
	ADD_STRINGVALUE( SR_FIELD_FIRESOUND,		"FireSound")
	ADD_STRINGVALUE( SR_FIELD_BOUNDSOUND,		"BoundSound")
	ADD_STRINGVALUE( SR_FIELD_SHEATHSOUND,		"SheathSound")
	ADD_STRINGVALUE( SR_FIELD_DRAWSOUND,		"DrawSound")
	ADD_STRINGVALUE( SR_FIELD_SWINGSOUND,		"SwingSound")
	ADD_STRINGVALUE( SR_FIELD_BASEWEAPON,		"BaseWeapon")
	ADD_STRINGVALUE( SR_FIELD_MATERIALOBJECT,	"MaterialObject")
	ADD_STRINGVALUE( SR_FIELD_DESTROYMODEL,		"DestroyModel")
	ADD_STRINGVALUE( SR_FIELD_AMBIENTSOUND,		"AmbientSound")	
	ADD_STRINGVALUE( SR_FIELD_VERB,				"Verb")
	ADD_STRINGVALUE( SR_FIELD_KEYWORD,			"Keyword")
	ADD_STRINGVALUE( SR_FIELD_WATER,			"Water")
	ADD_STRINGVALUE( SR_FIELD_FEMALEMODEL,		"FemaleModel")
	ADD_STRINGVALUE( SR_FIELD_MALEMODEL	,		"MaleModel")	
	ADD_STRINGVALUE( SR_FIELD_FEMALE1STMODEL,	"Female1stModel")
	ADD_STRINGVALUE( SR_FIELD_MALE1STMODEL,		"Male1stModel")
	ADD_STRINGVALUE( SR_FIELD_FOOTSTEPS,		"Footsteps")
	ADD_STRINGVALUE( SR_FIELD_MALETEXTURE,		"MaleTexture")
	ADD_STRINGVALUE( SR_FIELD_FEMALETEXTURE,	"FemaleTexture")
	ADD_STRINGVALUE( SR_FIELD_MALE1STTEXTURE,	"Male1stTexture")
	ADD_STRINGVALUE( SR_FIELD_FEMALE1STTEXTURE,	"Female1stTexture")
	ADD_STRINGVALUE( SR_FIELD_RACECOUNT,		"RaceCount")
	ADD_STRINGVALUE( SR_FIELD_FILLEDGEM,		"FilledGem")
	ADD_STRINGVALUE( SR_FIELD_CURRENTSOUL,		"CurrentSoul")
	ADD_STRINGVALUE( SR_FIELD_SPELL1,			"Spell1")
	ADD_STRINGVALUE( SR_FIELD_SPELL2,			"Spell2")
	ADD_STRINGVALUE( SR_FIELD_SPELL3,			"Spell3")
	ADD_STRINGVALUE( SR_FIELD_POWERWORD1,		"PowerWord1")
	ADD_STRINGVALUE( SR_FIELD_POWERWORD2,		"PowerWord2")
	ADD_STRINGVALUE( SR_FIELD_POWERWORD3,		"PowerWord3")
	ADD_STRINGVALUE( SR_FIELD_RECHARGE1,		"Recharge1")
	ADD_STRINGVALUE( SR_FIELD_RECHARGE2,		"Recharge2")
	ADD_STRINGVALUE( SR_FIELD_RECHARGE3,		"Recharge3")
	ADD_STRINGVALUE( SR_FIELD_TRANSLATION,		"Translation")
	ADD_STRINGVALUE( SR_FIELD_ONEHAND,			"OneHand")
	ADD_STRINGVALUE( SR_FIELD_TWOHAND,			"TwoHand")
	ADD_STRINGVALUE( SR_FIELD_MARKSMAN,			"Marksman")
	ADD_STRINGVALUE( SR_FIELD_BLOCK,			"Block")
	ADD_STRINGVALUE( SR_FIELD_SMITHING,			"Smithing")
	ADD_STRINGVALUE( SR_FIELD_HEAVYARMOR,		"HeavyArmor")
	ADD_STRINGVALUE( SR_FIELD_LIGHTARMOR,		"LightArmor")
	ADD_STRINGVALUE( SR_FIELD_PICKPOCKET,		"PickPocket")
	ADD_STRINGVALUE( SR_FIELD_LOCKPICKING,		"LockPicking")
	ADD_STRINGVALUE( SR_FIELD_SNEAK,			"Sneak")
	ADD_STRINGVALUE( SR_FIELD_ALCHEMY,			"Alchemy")
	ADD_STRINGVALUE( SR_FIELD_SPEECHCRAFT,		"Speechcraft")
	ADD_STRINGVALUE( SR_FIELD_ALTERATION,		"Alteration")
	ADD_STRINGVALUE( SR_FIELD_CONJURATION,		"Conjuration")
	ADD_STRINGVALUE( SR_FIELD_DESTRUCTION,		"Destruction")
	ADD_STRINGVALUE( SR_FIELD_ILLUSION,			"Illusion")
	ADD_STRINGVALUE( SR_FIELD_RESTORATION,		"Restoration")
	ADD_STRINGVALUE( SR_FIELD_ENCHANTING,		"Enchanting")
	ADD_STRINGVALUE( SR_FIELD_TRAINERSKILL,		"TrainerSkill")
	ADD_STRINGVALUE( SR_FIELD_TRAINERLEVEL,		"TrainerLevel")
	ADD_STRINGVALUE( SR_FIELD_NEXTPERK,			"NextPerk")
	ADD_STRINGVALUE( SR_FIELD_PERKSECTIONS,		"PerkSections")
	ADD_STRINGVALUE( SR_FIELD_PERKSECTYPE,		"PerkSectionType")
	ADD_STRINGVALUE( SR_FIELD_PERKPRIORITY,		"PerkPriority")		
	ADD_STRINGVALUE( SR_FIELD_PERKSECDATATYPE,	"PerkSectionDataType")
	ADD_STRINGVALUE( SR_FIELD_PERKSECDATA,		"PerkSectionData")
	ADD_STRINGVALUE( SR_FIELD_PERKEFFECTTYPE,	"PerkEffectType")
	ADD_STRINGVALUE( SR_FIELD_PERKSEFFDATA,		"PerkEffectData")
	ADD_STRINGVALUE( SR_FIELD_PERKFUNCTIONTYPE,	"PerkFunctionType")
	ADD_STRINGVALUE( SR_FIELD_PRKC,				"Prkc")	
	ADD_STRINGVALUE( SR_FIELD_IMAGESPACE,		"ImageSpace")	
	ADD_STRINGVALUE( SR_FIELD_X1,				"X1")	
	ADD_STRINGVALUE( SR_FIELD_Y1,				"Y1")	
	ADD_STRINGVALUE( SR_FIELD_Z1,				"Z1")	
	ADD_STRINGVALUE( SR_FIELD_X2,				"X2")	
	ADD_STRINGVALUE( SR_FIELD_Y2,				"Y2")	
	ADD_STRINGVALUE( SR_FIELD_Z2,				"Z2")
	ADD_STRINGVALUE( SR_FIELD_BOUNDS,			"Bounds")
	ADD_STRINGVALUE( SR_FIELD_SOUNDREF,			"SoundRef")
	ADD_STRINGVALUE( SR_FIELD_CATEGORY,			"Category")
	ADD_STRINGVALUE( SR_FIELD_OUTPUTMARKER,		"OutputMarker")
	ADD_STRINGVALUE( SR_FIELD_FNAME,			"FName")
	ADD_STRINGVALUE( SR_FIELD_CNAME,			"CName")
	ADD_STRINGVALUE( SR_FIELD_SOUNDFLAGS,		"SoundFlags")
	ADD_STRINGVALUE( SR_FIELD_PARENT,			"Parent")
	ADD_STRINGVALUE( SR_FIELD_VNAME,			"VName")
	ADD_STRINGVALUE( SR_FIELD_UNAME,			"UName")
	ADD_STRINGVALUE( SR_FIELD_FACTION,			"Faction")
	ADD_STRINGVALUE( SR_FIELD_LOCATION,			"Location")
	ADD_STRINGVALUE( SR_FIELD_RANK,				"Rank")
	ADD_STRINGVALUE( SR_FIELD_MINLEVEL,			"MinLevel")
	ADD_STRINGVALUE( SR_FIELD_RESET,			"Reset")
	ADD_STRINGVALUE( SR_FIELD_SPELLCOUNT,		"SpellCount")
	ADD_STRINGVALUE( SR_FIELD_NAKEDARMOR,		"NakedArmor")
	ADD_STRINGVALUE( SR_FIELD_MALEHEIGHT,		"MaleHeight")
	ADD_STRINGVALUE( SR_FIELD_FEMALEHEIGHT,		"FemaleHeight")
	ADD_STRINGVALUE( SR_FIELD_ACTORVALUE1,		"ActorValue1")
	ADD_STRINGVALUE( SR_FIELD_ACTORVALUE2,		"ActorValue2")	
	ADD_STRINGVALUE( SR_FIELD_ACTORVALUE3,		"ActorValue3")	
	ADD_STRINGVALUE( SR_FIELD_ACTORVALUE4,		"ActorValue4")
	ADD_STRINGVALUE( SR_FIELD_ACTORVALUE5,		"ActorValue5")
	ADD_STRINGVALUE( SR_FIELD_ACTORVALUE6,		"ActorValue6")
	ADD_STRINGVALUE( SR_FIELD_ACTORVALUE7,		"ActorValue7")
	ADD_STRINGVALUE( SR_FIELD_SKILL1,			"Skill1")
	ADD_STRINGVALUE( SR_FIELD_SKILL2,			"Skill2")
	ADD_STRINGVALUE( SR_FIELD_SKILL3,			"Skill3")
	ADD_STRINGVALUE( SR_FIELD_SKILL4,			"Skill4")
	ADD_STRINGVALUE( SR_FIELD_SKILL5,			"Skill5")
	ADD_STRINGVALUE( SR_FIELD_SKILL6,			"Skill6")
	ADD_STRINGVALUE( SR_FIELD_SKILL7,			"Skill7")
	ADD_STRINGVALUE( SR_FIELD_UNKNOWN22,		"Unknown22")
	ADD_STRINGVALUE( SR_FIELD_UNKNOWN23,		"Unknown23")
	ADD_STRINGVALUE( SR_FIELD_UNKNOWN24,		"Unknown24")
	ADD_STRINGVALUE( SR_FIELD_UNKNOWN25,		"Unknown25")
	ADD_STRINGVALUE( SR_FIELD_UNKNOWN26,		"Unknown26")
	ADD_STRINGVALUE( SR_FIELD_LISTUNKNOWN1,		"ListUnknown1")
	ADD_STRINGVALUE( SR_FIELD_LISTUNKNOWN2,		"ListUnknown2")
	ADD_STRINGVALUE( SR_FIELD_LISTUNKNOWN3,		"ListUnknown3")
	ADD_STRINGVALUE( SR_FIELD_LISTUNKNOWN4,		"ListUnknown4")
	ADD_STRINGVALUE( SR_FIELD_LISTUNKNOWN5,		"ListUnknown5")
	ADD_STRINGVALUE( SR_FIELD_LISTUNKNOWN6,		"ListUnknown6")
	ADD_STRINGVALUE( SR_FIELD_LISTUNKNOWN7,		"ListUnknown7")
	ADD_STRINGVALUE( SR_FIELD_LISTUNKNOWN8,		"ListUnknown8")
	ADD_STRINGVALUE( SR_FIELD_LISTUNKNOWN9,		"ListUnknown9")
	ADD_STRINGVALUE( SR_FIELD_LISTUNKNOWN10,	"ListUnknown10")
	ADD_STRINGVALUE( SR_FIELD_LISTUNKNOWN11,	"ListUnknown11")
	ADD_STRINGVALUE( SR_FIELD_LISTUNKNOWN12,	"ListUnknown12")
	ADD_STRINGVALUE( SR_FIELD_LISTUNKNOWN13,	"ListUnknown13")
	ADD_STRINGVALUE( SR_FIELD_LISTUNKNOWN14,	"ListUnknown14")
	ADD_STRINGVALUE( SR_FIELD_LISTUNKNOWN15,	"ListUnknown15")
	ADD_STRINGVALUE( SR_FIELD_LISTUNKNOWN16,	"ListUnknown16")
	ADD_STRINGVALUE( SR_FIELD_LISTFACTION,		"ListFaction")
	ADD_STRINGVALUE( SR_FIELD_LISTMINRANK,		"ListMinRank")	
	ADD_STRINGVALUE( SR_FIELD_LISTCONDITION,	"ListCondition")
	ADD_STRINGVALUE( SR_FIELD_SECTIONCOUNT,		"SectionCount")
	ADD_STRINGVALUE( SR_FIELD_PNAME,			"PName")
	ADD_STRINGVALUE( SR_FIELD_XNAME,			"XName")
	ADD_STRINGVALUE( SR_FIELD_YNAME,			"YName")
	ADD_STRINGVALUE( SR_FIELD_HNAME,			"HName")
	ADD_STRINGVALUE( SR_FIELD_SNAME,			"SName")
	ADD_STRINGVALUE( SR_FIELD_INAME,			"IName")
	ADD_STRINGVALUE( SR_FIELD_ANAME,			"AName")
	ADD_STRINGVALUE( SR_FIELD_PERKRANK,			"PerkRank")		
	ADD_STRINGVALUE( SR_FIELD_PARAM3,			"Param3")
	ADD_STRINGVALUE( SR_FIELD_RUNON,			"RunOn")	
	ADD_STRINGVALUE( SR_FIELD_SCRIPTCOUNT,		"ScriptCount")
	ADD_STRINGVALUE( SR_FIELD_DELIVERYTYPE		,"DeliveryType")
	ADD_STRINGVALUE( SR_FIELD_RESISTTYPE		,"ResistType")
	ADD_STRINGVALUE( SR_FIELD_TAPERWEIGHT		,"TaperWeight")
	ADD_STRINGVALUE( SR_FIELD_TAPERDURATION		,"TaperDuration")
	ADD_STRINGVALUE( SR_FIELD_TAPERCURVE		,"TaperCurve")
	ADD_STRINGVALUE( SR_FIELD_SECONDAVWEIGHT	,"SecondAVWeight")
	ADD_STRINGVALUE( SR_FIELD_SOUNDVOLUME		,"SoundVolume")
	ADD_STRINGVALUE( SR_FIELD_DUALCASTSCALE		,"DualCastScale")
	ADD_STRINGVALUE( SR_FIELD_NOHITEVENT		,"NoHitEvent")
	ADD_STRINGVALUE( SR_FIELD_NOMAGNITUDE		,"NoMagnitude")
	ADD_STRINGVALUE( SR_FIELD_NORECAST			,"NoRecast")
	ADD_STRINGVALUE( SR_FIELD_GORYVISUAL		,"GoryVisual")
	ADD_STRINGVALUE( SR_FIELD_HIDEINUI			,"HideInUI")
	ADD_STRINGVALUE( SR_FIELD_POWERMAGNITUDE	,"PowerMagnitude")
	ADD_STRINGVALUE( SR_FIELD_PAINLESS			,"Painless")
	ADD_STRINGVALUE( SR_FIELD_POWERDURATION		,"PowerDuration")
	ADD_STRINGVALUE( SR_FIELD_NOHITEFFECT		,"NoHitEffect")
	ADD_STRINGVALUE( SR_FIELD_NODEATHDISPELL	,"NoDeathDispell")
	ADD_STRINGVALUE( SR_FIELD_NODURATION		,"NoDuration")
	ADD_STRINGVALUE( SR_FIELD_MENU,				"Menu")
	ADD_STRINGVALUE( SR_FIELD_COUNTEREFFECTCOUNT, "CounterEffectCount")
	ADD_STRINGVALUE( SR_FIELD_SNAPTONAVMESH,	"SnapToNavMesh")	
	ADD_STRINGVALUE( SR_FIELD_SCRIPTAIDATASCORE, "ScriptAIDataScore")
	ADD_STRINGVALUE( SR_FIELD_SCRIPTAIDATADELAY, "ScriptAIDataDelay")	
	ADD_STRINGVALUE( SR_FIELD_DISPELEFFECTS,	"DispelEffects")
	ADD_STRINGVALUE( SR_FIELD_ENCHANTTYPE,		"EnchantType")
	ADD_STRINGVALUE( SR_FIELD_CHARGETIME,		"ChargeTime")
	ADD_STRINGVALUE( SR_FIELD_EXTENDDURATION,	"ExtendDuration")
	ADD_STRINGVALUE( SR_FIELD_ADDICTION,		"Addiction")
	ADD_STRINGVALUE( SR_FIELD_ADDICTIONCHANCE,	"AddictionChance")
	ADD_STRINGVALUE( SR_FIELD_POISON,			"Poison")
	ADD_STRINGVALUE( SR_FIELD_MEDICINE,			"Medicine")
	ADD_STRINGVALUE( SR_FIELD_MESSAGEICON,		"MessageIcon")	
	ADD_STRINGVALUE( SR_FIELD_REFERENCEPERSIST,	"ReferencePersist")
	ADD_STRINGVALUE( SR_FIELD_INVENTORYMODEL,	"InventoryModel")
	ADD_STRINGVALUE( SR_FIELD_AREAIGNORESLOS,	"AreaIgnoresLOS")
	ADD_STRINGVALUE( SR_FIELD_PCSTARTSPELL,		"PCStartSpell")
	ADD_STRINGVALUE( SR_FIELD_NOABSORBREFLECT,	"NoAbsorbReflect")
	ADD_STRINGVALUE( SR_FIELD_NODUALCASTMODS,	"NoDualCastMods")
	ADD_STRINGVALUE( SR_FIELD_SCRIPTALWAYSAPPLIES, "ScriptAlwaysApplies")
	ADD_STRINGVALUE( SR_FIELD_FORCEEXPLODE		,  "ForceExplode")
END_STRINGVALUE()
/*===========================================================================
 *		End of Field Text Strings
 *=========================================================================*/


/*===========================================================================
 *
 * Get String from a Value Functions
 *
 *=========================================================================*/
const SSCHAR* GetSrFieldString (const int Value) { return s_SrFieldsMap.FindValue(Value); }
/*===========================================================================
 *		End of Get String Functions
 *=========================================================================*/


/*===========================================================================
 *
 * Begin Get a Value from a String
 *
 *=========================================================================*/
bool GetSrFieldValue (int& Value, const SSCHAR* pString) { return s_SrFieldsMap.FindString(Value, pString); }
/*===========================================================================
 *		End of Get a Value from a String
 *=========================================================================*/


/*===========================================================================
 *
 * Function - bool SrFieldConvertInt (pString, Value);
 *
 * Attempts to convert the given value to an integer value. Returns false
 * on any error.
 *
 *=========================================================================*/
bool SrFieldConvertInt (const SSCHAR* pString, int& Value)
{
  SSCHAR* pError;

  Value = strtol(pString, &pError, 0);

  if (!isspace(*pError) && *pError != NULL_CHAR)
  {
    AddSrGeneralError("The string '%s' is not a valid integer value!", pString);
    return (false);
  }

  return (true);
}


bool SrFieldConvertLong (const SSCHAR* pString, long& Value)
{
  SSCHAR* pError;

  Value = strtol(pString, &pError, 0);

  if (!isspace(*pError) && *pError != NULL_CHAR)
  {
    AddSrGeneralError("The string '%s' is not a valid integer value!", pString);
    return (false);
  }

  return (true);
}


bool SrFieldConvertDword (const SSCHAR* pString, dword& Value)
{
  SSCHAR* pError;

  Value = strtoul(pString, &pError, 0);

  if (!isspace(*pError) && *pError != NULL_CHAR)
  {
    AddSrGeneralError("The string '%s' is not a valid unsigned integer value!", pString);
    return (false);
  }

  return (true);
}


bool SrFieldConvertShort (const SSCHAR* pString, short& Value)
{
  SSCHAR* pError;
  long    lValue;

  lValue = strtol(pString, &pError, 0);
  Value  = (short) lValue;

  if (!isspace(*pError) && *pError != NULL_CHAR || lValue != (long) Value)
  {
    AddSrGeneralError("The string '%s' is not a valid short value!", pString);
    return (false);
  }

  
  return (true);
}


bool SrFieldConvertWord (const SSCHAR* pString, word& Value)
{
  SSCHAR* pError;
  dword   lValue;

  lValue = strtoul(pString, &pError, 0);
  Value  = (word) lValue;

  if (!isspace(*pError) && *pError != NULL_CHAR || lValue != (dword) Value)
  {
    AddSrGeneralError("The string '%s' is not a valid unsigned short value!", pString);
    return (false);
  }

  return (true);
}


bool SrFieldConvertByte (const SSCHAR* pString, byte& Value)
{
  SSCHAR* pError;
  dword   lValue;

  lValue = strtoul(pString, &pError, 0);
  Value  = (byte) lValue;

  if (!isspace(*pError) && *pError != NULL_CHAR || lValue != (dword) Value)
  {
    AddSrGeneralError("The string '%s' is not a valid byte value!", pString);
    return (false);
  }

  return (true);
}


bool SrFieldConvertFloat (const SSCHAR* pString, float& Value)
{
  SSCHAR* pError;
  double  dValue;

  dValue = strtod(pString, &pError);
  Value  = (float) dValue;

  if (!isspace(*pError) && *pError != NULL_CHAR)
  {
    AddSrGeneralError("The string '%s' is not a valid float value!", pString);
    return (false);
  }
  else if (dValue == HUGE_VAL || dValue == -HUGE_VAL)
  {
    AddSrGeneralError("The string '%s' would result in a float overflow!", pString);
    return (false);
  }

  return (true);
}


bool SrFieldConvertBoolean (const SSCHAR* pString, bool& Value)
{

  if (stricmp(pString, "true") == 0)
  {
    Value = true;
  }
  else if (stricmp(pString, "false") == 0)
  {
    Value = false;
  }
  else {
    AddSrGeneralError("The string '%s' is not a valid boolean value!", pString);
    return (false);
  }

  return (true);
}


bool SrFieldConvertColor (const SSCHAR* pString, srrgba_t& Value)
{
  SSCHAR* pError;
  dword   lValue;

  lValue = strtoul(pString, &pError, 16);
  Value.A = lValue >> 24;
  Value.B = (lValue >> 16) & 0xff;
  Value.G = (lValue >>  8) & 0xff;
  Value.R = lValue & 0xff;

  if (!isspace(*pError) && *pError != NULL_CHAR)
  {
    AddSrGeneralError("The string '%s' is not a valid color value!", pString);
    return (false);
  }

  return (true);
}
/*===========================================================================
 *		End of Function SrFieldConvertInt()
 *=========================================================================*/

/*===========================================================================
 *
 * File:	Srfields.H
 * Author:	Dave Humphrey (dave@uesp.net)
 * Created On:	26 November 2011
 *
 * Basic definitions for field IDs.
 *
 *=========================================================================*/
#ifndef __SRFIELDS_H
#define __SRFIELDS_H


/*===========================================================================
 *
 * Begin Required Includes
 *
 *=========================================================================*/
  #include "../common/textutils.h"
/*===========================================================================
 *		End of Required Includes
 *=========================================================================*/


/*===========================================================================
 *
 * Begin Type Definitions
 *
 *=========================================================================*/

	/* The basic field ID type */
  typedef long srfieldid_t;
  typedef srfieldid_t srrecfieldid_t;

/*===========================================================================
 *		End of Type Definitions
 *=========================================================================*/


/*===========================================================================
 *
 * Begin Definitions
 *
 *=========================================================================*/

	/* Default format strings */
  #define SR_FORMATSTR_WEIGHT "%g"

/*===========================================================================
 *		End of Definitions
 *=========================================================================*/


/*===========================================================================
 *
 * Begin Field Types
 *
 *=========================================================================*/

  #define SR_FIELD_UNKNOWN			-1
  #define SR_FIELD_NONE				0
  #define SR_FIELD_RECORDTYPE		1
  #define SR_FIELD_FORMID			2
  #define SR_FIELD_EDITORID			3
  #define SR_FIELD_ITEMNAME			4
  #define SR_FIELD_FULLNAME			4
  #define SR_FIELD_VALUE			5
  #define SR_FIELD_WEIGHT			6
  #define SR_FIELD_TYPE				7
  #define SR_FIELD_BIPED			8
  #define SR_FIELD_ICON				9
  #define SR_FIELD_ICON2			10
  #define SR_FIELD_MODEL			11
  #define SR_FIELD_MODEL2			12
  #define SR_FIELD_MODEL3			13
  #define SR_FIELD_MODEL4			14
  #define SR_FIELD_ARMOR			15
  #define SR_FIELD_DAMAGE			16
  #define SR_FIELD_SPEED			17
  #define SR_FIELD_REACH			18
  #define SR_FIELD_HEALTH			19
  #define SR_FIELD_FLAGS			20
  #define SR_FIELD_AUTHOR			21
  #define SR_FIELD_SUMMARY			22
  #define SR_FIELD_VERSION			23
  #define SR_FIELD_FILETYPE			24
  #define SR_FIELD_ENCHANTMENT		25
  #define SR_FIELD_ENCHANTPOINTS	26
  #define SR_FIELD_QUALITY			27
  #define SR_FIELD_IGNORERESIST		28
  #define SR_FIELD_HIDEAMULET		29
  #define SR_FIELD_HIDERINGS		30
  #define SR_FIELD_TEACHES			31
  #define SR_FIELD_SCROLL			32
  #define SR_FIELD_NOTAKE			33
  #define SR_FIELD_TEXT				34
  #define SR_FIELD_CHARGE			35
  #define SR_FIELD_COST				36
  #define SR_FIELD_AUTOCALC			37
  #define SR_FIELD_FOOD				38
  #define SR_FIELD_FOODITEM			38
  #define SR_FIELD_SCRIPT			39
  #define SR_FIELD_CHANCENONE		40
  #define SR_FIELD_CALCULATEALL		41
  #define SR_FIELD_CALCULATEEACH	42
  #define SR_FIELD_ITEMLIST			43
  #define SR_FIELD_SCRIPTTEXT		44
  #define SR_FIELD_USES				45
  #define SR_FIELD_LEVEL			46
  #define SR_FIELD_PLAYERSTART		47
  #define SR_FIELD_IGNORELOS		48
  #define SR_FIELD_ALWAYSAPPLY		49
  #define SR_FIELD_ABSORBREFLECT	50
  #define SR_FIELD_SILENCEIMMUNE	51
  #define SR_FIELD_RECORDCOUNT		52
  #define SR_FIELD_ITEMCOUNT		53
  #define SR_FIELD_EFFECTCOUNT		54
  #define SR_FIELD_USERDATA			55
  #define SR_FIELD_EFFECTID			56
  #define SR_FIELD_EFFECTNAME		57
  #define SR_FIELD_MAGNITUDE		58
  #define SR_FIELD_AREA				59
  #define SR_FIELD_DURATION			60
  #define SR_FIELD_RANGE			61
  #define SR_FIELD_SCHOOL			62
  #define SR_FIELD_ACTORVALUE		63
  #define SR_FIELD_EFFECTDESC		64
  #define SR_FIELD_SCRIPTSCHOOL		65
  #define SR_FIELD_VISUALNAME		66
  #define SR_FIELD_HOSTILE			67
  #define SR_FIELD_DATANAME			68
  #define SR_FIELD_NAME2			69
  #define SR_FIELD_SCRIPTID			70
  #define SR_FIELD_PLAYABLE			71
  #define SR_FIELD_TIME				72
  #define SR_FIELD_RADIUS			73
  #define SR_FIELD_FOV				74
  #define SR_FIELD_CARRIED			75
  #define SR_FIELD_COLOR			76
  #define SR_FIELD_FADE				77
  #define SR_FIELD_FALLOFF			78
  #define SR_FIELD_DYNAMIC			79
  #define SR_FIELD_NEGATIVE			80
  #define SR_FIELD_DEFAULTOFF		81
  #define SR_FIELD_SPOTLIGHT		82
  #define SR_FIELD_SPOTSHADOW		83
  #define SR_FIELD_SOUNDID			84
  #define SR_FIELD_SOUND			85
  #define SR_FIELD_ENCHANTMENTID	86
  #define SR_FIELD_LOCATIONX		87
  #define SR_FIELD_LOCATIONY		88
  #define SR_FIELD_LOCATIONZ		89
  #define SR_FIELD_ANGLEX			90
  #define SR_FIELD_ANGLEY			91
  #define SR_FIELD_ANGLEZ			92
  #define SR_FIELD_TELEPORTFORMID	93
  #define SR_FIELD_TELEPORTNAME		94
  #define SR_FIELD_TELEPORTLOCX		95
  #define SR_FIELD_TELEPORTLOCY		96
  #define SR_FIELD_TELEPORTLOCZ		97
  #define SR_FIELD_TELEPORTANGLEX	98
  #define SR_FIELD_TELEPORTANGLEY	99
  #define SR_FIELD_TELEPORTANGLEZ	100
  #define SR_FIELD_WORLDSPACE		101
  #define SR_FIELD_MARKERTYPE		102
  #define SR_FIELD_MARKERTYPEID		103
  #define SR_FIELD_BASEFORMID		104
  #define SR_FIELD_BASEEDITORID		105
  #define SR_FIELD_BASENAME			106
  #define SR_FIELD_LINECOUNT		107
  #define SR_FIELD_SIZE				108
  #define SR_FIELD_REALARMOR		109
  #define SR_FIELD_QUESTITEM		110
  #define SR_FIELD_DANGEROUS		111
  #define SR_FIELD_IGNORED			112
  #define SR_FIELD_DELETED			113
  #define SR_FIELD_USEALLSPELLS		114
  #define SR_FIELD_TEMPLATE			115
  #define SR_FIELD_TEMPLATEID		116
  #define SR_FIELD_CAPACITY			117
  #define SR_FIELD_SOUL				118
  #define SR_FIELD_RESPAWNS			119
  #define SR_FIELD_OPENSOUND		120
  #define SR_FIELD_OPENSOUNDID		121
  #define SR_FIELD_CLOSESOUND		122
  #define SR_FIELD_CLOSESOUNDID		123
  #define SR_FIELD_MINATTENUATION       125
  #define SR_FIELD_MAXATTENUATION       126
  #define SR_FIELD_STATICATTENUATION    127
  #define SR_FIELD_FREQADJUSTMENT       128
  #define SR_FIELD_STARTTIME            129
  #define SR_FIELD_STOPTIME             130
  #define SR_FIELD_RANDOMFREQSHIFT      131
  #define SR_FIELD_RANDOMPLAY           132
  #define SR_FIELD_RANDOMLOCATION       133
  #define SR_FIELD_LOOP                 134
  #define SR_FIELD_MENUSOUND            135
  #define SR_FIELD_IGNOREENVIRONMENT    136
  #define SR_FIELD_2DSOUND              137
  #define SR_FIELD_360LFE               138
  #define SR_FIELD_INGREDIANT			139
  #define SR_FIELD_INGREDIANTID			140
  #define SR_FIELD_SPRING				141
  #define SR_FIELD_SUMMER				142
  #define SR_FIELD_FALL					143
  #define SR_FIELD_WINTER				144
  #define SR_FIELD_SOUNDFILE			145
  #define SR_FIELD_REDCOLOR				146
  #define SR_FIELD_GREENCOLOR			147
  #define SR_FIELD_BLUECOLOR			148
  #define SR_FIELD_NEXTOBJECTID			149
  #define SR_FIELD_CNAM					150
  #define SR_FIELD_KEYWORDCOUNT			151
  #define SR_FIELD_KEYWORDS				152
  #define SR_FIELD_MATERIAL				153
  #define SR_FIELD_VNAM					154
  #define SR_FIELD_DESCRIPTION			155
  #define SR_FIELD_EFFECTTYPE			156
  #define SR_FIELD_CONDITIONCOUNT		157
  #define SR_FIELD_OPERATOR				158
  #define SR_FIELD_REFERENCE			159
  #define SR_FIELD_FUNCTION				160
  #define SR_FIELD_PARAM1				161
  #define SR_FIELD_PARAM2				162
  #define SR_FIELD_CONDFLAGS			163
  #define SR_FIELD_COMPONENTCOUNT		164
  #define SR_FIELD_RESULTCOUNT			165
  #define SR_FIELD_STATION				166
  #define SR_FIELD_RESULTITEM			167
  #define SR_FIELD_CONDFLAGSEX			168
  #define SR_FIELD_COUNT				169
  #define SR_FIELD_COMPONENT			170
  #define SR_FIELD_COMPCOUNT			171
  #define SR_FIELD_COMPFORMID			172
  #define SR_FIELD_COMPITEMNAME			173
  #define SR_FIELD_EQUIPSLOT			174
  #define SR_FIELD_SKILLLEVEL			175
  #define SR_FIELD_CASTINGDELAY			176
  #define SR_FIELD_BASECOST				177
  #define SR_FIELD_MAGICFLAGS			178
  #define SR_FIELD_BASEENCHANT			179
  #define SR_FIELD_ITEMTYPES			180
  #define SR_FIELD_ENCHANTCOST			181
  #define SR_FIELD_PERK					182
  #define SR_FIELD_SPELLFLAGS			183
  #define SR_FIELD_SPELLTYPE			184
  #define SR_FIELD_CASTTIME				185
  #define SR_FIELD_CASTANIM				186
  #define SR_FIELD_CASTTYPE				187
  #define SR_FIELD_PERKID				188
  #define SR_FIELD_EQUIPSLOTID			189
  #define SR_FIELD_UNKNOWN1				190
  #define SR_FIELD_UNKNOWN2				191
  #define SR_FIELD_UNKNOWN3				192
  #define SR_FIELD_UNKNOWN4				193
  #define SR_FIELD_UNKNOWN5				194
  #define SR_FIELD_TYPEA				195
  #define SR_FIELD_TYPEB				196
  #define SR_FIELD_TYPEC				197
  #define SR_FIELD_TYPED				198
  #define SR_FIELD_STAFFMOD				199
  #define SR_FIELD_PICKUPSOUND			200
  #define SR_FIELD_DROPSOUND			201
  #define SR_FIELD_VANISH				202
  #define SR_FIELD_PROJECTILE			203
  #define SR_FIELD_RATING				204
  #define SR_FIELD_BODYPARTS			205
  #define SR_FIELD_RACE					206
  #define SR_FIELD_BAMT					207
  #define SR_FIELD_IMPACTDATA			208
  #define SR_FIELD_ANAM					209
  #define SR_FIELD_ARMMODEL				210
  #define SR_FIELD_USESOUND				211
  #define SR_FIELD_POTIONFLAGS			212
  #define SR_FIELD_POTIONTYPE			213
  #define SR_FIELD_STATIC				214
  #define SR_FIELD_SPELLTOME			215
  #define SR_FIELD_SKILLBOOK			216
  #define SR_FIELD_SKILL				217
  #define SR_FIELD_SPELL				218
  #define SR_FIELD_SCALE				219
  #define SR_FIELD_USEALL				220
  #define SR_FIELD_GLOBAL				221
  #define SR_FIELD_HOLDSOUND			222
  #define SR_FIELD_UNKNOWN6				223
  #define SR_FIELD_UNKNOWN7				224
  #define SR_FIELD_UNKNOWNFLAG1			225
  #define SR_FIELD_UNKNOWNFLAG2			226
  #define SR_FIELD_UNKNOWNFLAG3			227
  #define SR_FIELD_LIGHTFLAGS			228
  #define SR_FIELD_FLICKER				230
  #define SR_FIELD_FLICKERSLOW			231
  #define SR_FIELD_PULSE				232
  #define SR_FIELD_UNKNOWN9				233
  #define SR_FIELD_UNKNOWN10			234
  #define SR_FIELD_UNKNOWN11			235
  #define SR_FIELD_UNKNOWN12			236
  #define SR_FIELD_UNKNOWN13			237
  #define SR_FIELD_UNKNOWN14			238
  #define SR_FIELD_UNKNOWN15			239
  #define SR_FIELD_UNKNOWN16			240
  #define SR_FIELD_UNKNOWN17			241
  #define SR_FIELD_UNKNOWN18			242
  #define SR_FIELD_UNKNOWN19			243
  #define SR_FIELD_UNKNOWN20			244
  #define SR_FIELD_UNKNOWN21			245
  #define SR_FIELD_LIGHT				246
  #define SR_FIELD_HITSHADER		    247
  #define SR_FIELD_ENCHANTSHADER	    248
  #define SR_FIELD_CASTINGART		    249
  #define SR_FIELD_HITEFFECTART		    250
  #define SR_FIELD_IMPACTSET			251
  #define SR_FIELD_EFFECTOBJECT		    252
  #define SR_FIELD_SKILLUSAGEMULT	    253
  #define SR_FIELD_UNKNOWN8				254
  #define SR_FIELD_ENCHANTART		    255
  #define SR_FIELD_EQUIPABILITY		    256
  #define SR_FIELD_RECOVER				257
  #define SR_FIELD_DUALCAST			    258
  #define SR_FIELD_EXPLOSION		    259
  #define SR_FIELD_IMAGESPACEMOD		260
  #define SR_FIELD_DETRIMENTAL			261
  #define SR_FIELD_PERCENTMAG			262
  #define SR_FIELD_SELFONLY				263
  #define SR_FIELD_NOAREA				264
  #define SR_FIELD_FXPERSIST			265
  #define SR_FIELD_BOUND				266
  #define SR_FIELD_WARD					267
  #define SR_FIELD_UNKNOWNFLAG4			268
  #define SR_FIELD_UNKNOWNFLAG5			269
  #define SR_FIELD_UNKNOWNFLAG6			270
  #define SR_FIELD_UNKNOWNFLAG7			271
  #define SR_FIELD_UNKNOWNFLAG8			272
  #define SR_FIELD_UNKNOWNFLAG9			273
  #define SR_FIELD_SOUNDCOUNT			274
  #define SR_FIELD_NNAM					275
  #define SR_FIELD_SNAM					276
  #define SR_FIELD_UNAM					277
  #define SR_FIELD_NAM8					278
  #define SR_FIELD_NAM9					279
  #define SR_FIELD_TNAM					280
  #define SR_FIELD_WNAM					281
  #define SR_FIELD_INAM					282
  #define SR_FIELD_DNAM					283
		/* Duplicated renamed field 284 was removed */
  #define SR_FIELD_FIRESOUND			285
  #define SR_FIELD_BOUNDSOUND			286
  #define SR_FIELD_SHEATHSOUND			287
  #define SR_FIELD_DRAWSOUND			288
  #define SR_FIELD_SWINGSOUND			289
  #define SR_FIELD_BASEWEAPON			290
  #define SR_FIELD_MATERIALOBJECT		291
  #define SR_FIELD_DESTROYMODEL			292
  #define SR_FIELD_AMBIENTSOUND			293
  #define SR_FIELD_VERB					294
  #define SR_FIELD_KEYWORD				295
  #define SR_FIELD_WATER				296
  #define SR_FIELD_FEMALEMODEL			297	
  #define SR_FIELD_MALEMODEL			298
  #define SR_FIELD_FEMALE1STMODEL		299
  #define SR_FIELD_MALE1STMODEL			300
  #define SR_FIELD_FOOTSTEPS			301
  #define SR_FIELD_MALETEXTURE			302
  #define SR_FIELD_FEMALETEXTURE		303
  #define SR_FIELD_MALE1STTEXTURE		304
  #define SR_FIELD_FEMALE1STTEXTURE		305
  #define SR_FIELD_RACECOUNT			306
  #define SR_FIELD_FILLEDGEM			307
  #define SR_FIELD_CURRENTSOUL			308
  #define SR_FIELD_SPELL1				309
  #define SR_FIELD_SPELL2				310
  #define SR_FIELD_SPELL3				311
  #define SR_FIELD_POWERWORD1			312
  #define SR_FIELD_POWERWORD2			313
  #define SR_FIELD_POWERWORD3			314
  #define SR_FIELD_RECHARGE1			315
  #define SR_FIELD_RECHARGE2			316
  #define SR_FIELD_RECHARGE3			317
  #define SR_FIELD_TRANSLATION			318
  #define SR_FIELD_ONEHAND				319
  #define SR_FIELD_TWOHAND				320
  #define SR_FIELD_MARKSMAN				321
  #define SR_FIELD_BLOCK				322
  #define SR_FIELD_SMITHING				323
  #define SR_FIELD_HEAVYARMOR			324
  #define SR_FIELD_LIGHTARMOR			325
  #define SR_FIELD_PICKPOCKET			326
  #define SR_FIELD_LOCKPICKING			327
  #define SR_FIELD_SNEAK				328
  #define SR_FIELD_ALCHEMY				329
  #define SR_FIELD_SPEECHCRAFT			330
  #define SR_FIELD_ALTERATION			331
  #define SR_FIELD_CONJURATION			332
  #define SR_FIELD_DESTRUCTION			333
  #define SR_FIELD_ILLUSION				334
  #define SR_FIELD_RESTORATION			335
  #define SR_FIELD_ENCHANTING			336
  #define SR_FIELD_TRAINERSKILL			337
  #define SR_FIELD_TRAINERLEVEL			338
  #define SR_FIELD_NEXTPERK				339
  #define SR_FIELD_PERKSECTIONS         340
  #define SR_FIELD_PERKSECTYPE			341
  #define SR_FIELD_PERKPRIORITY			342
  #define SR_FIELD_PERKSECDATATYPE		343
  #define SR_FIELD_PERKSECDATA			344
  #define SR_FIELD_PERKEFFECTTYPE		345
  #define SR_FIELD_PERKSEFFDATA			346
  #define SR_FIELD_PERKFUNCTIONTYPE		347
  #define SR_FIELD_PRKC					348
  #define SR_FIELD_IMAGESPACE			349
  #define SR_FIELD_X1					350
  #define SR_FIELD_Y1					351
  #define SR_FIELD_Z1					352
  #define SR_FIELD_X2					353
  #define SR_FIELD_Y2					354
  #define SR_FIELD_Z2					355
  #define SR_FIELD_BOUNDS				356
  #define SR_FIELD_SOUNDREF				357
  #define SR_FIELD_CATEGORY				358
  #define SR_FIELD_OUTPUTMARKER			359
  #define SR_FIELD_FNAME				360
  #define SR_FIELD_CNAME				361
  #define SR_FIELD_SOUNDFLAGS			362
  #define SR_FIELD_PARENT				363
  #define SR_FIELD_VNAME				364
  #define SR_FIELD_UNAME				365
  #define SR_FIELD_FACTION				366
  #define SR_FIELD_LOCATION				367
  #define SR_FIELD_RANK					368
  #define SR_FIELD_MINLEVEL				369
  #define SR_FIELD_RESET				370
  #define SR_FIELD_SPELLCOUNT			371
  #define SR_FIELD_NAKEDARMOR			372
  #define SR_FIELD_MALEHEIGHT			373
  #define SR_FIELD_FEMALEHEIGHT			374
  #define SR_FIELD_ACTORVALUE1			375
  #define SR_FIELD_ACTORVALUE2			376
  #define SR_FIELD_ACTORVALUE3			377
  #define SR_FIELD_ACTORVALUE4			378
  #define SR_FIELD_ACTORVALUE5			379
  #define SR_FIELD_ACTORVALUE6			380
  #define SR_FIELD_ACTORVALUE7			381
  #define SR_FIELD_SKILL1				382
  #define SR_FIELD_SKILL2				383
  #define SR_FIELD_SKILL3				384
  #define SR_FIELD_SKILL4				385
  #define SR_FIELD_SKILL5				386
  #define SR_FIELD_SKILL6				387
  #define SR_FIELD_SKILL7				388
  #define SR_FIELD_UNKNOWN22			389
  #define SR_FIELD_UNKNOWN23			391
  #define SR_FIELD_UNKNOWN24			392
  #define SR_FIELD_UNKNOWN25			393
  #define SR_FIELD_UNKNOWN26			394
  #define SR_FIELD_LISTUNKNOWN1			395
  #define SR_FIELD_LISTUNKNOWN2			396
  #define SR_FIELD_LISTUNKNOWN3			397
  #define SR_FIELD_LISTUNKNOWN4			398
  #define SR_FIELD_LISTUNKNOWN5			399
  #define SR_FIELD_LISTUNKNOWN6			400
  #define SR_FIELD_LISTUNKNOWN7			401
  #define SR_FIELD_LISTUNKNOWN8			402
  #define SR_FIELD_LISTUNKNOWN9			403
  #define SR_FIELD_LISTUNKNOWN10		404
  #define SR_FIELD_LISTUNKNOWN11		405
  #define SR_FIELD_LISTUNKNOWN12		406
  #define SR_FIELD_LISTUNKNOWN13		407
  #define SR_FIELD_LISTUNKNOWN14		408
  #define SR_FIELD_LISTUNKNOWN15		409
  #define SR_FIELD_LISTUNKNOWN16		410
  #define SR_FIELD_LISTFACTION			411
  #define SR_FIELD_LISTMINRANK			412
  #define SR_FIELD_LISTCONDITION		413
  #define SR_FIELD_SECTIONCOUNT			414
  #define SR_FIELD_PNAME				415
  #define SR_FIELD_XNAME				416
  #define SR_FIELD_YNAME				417
  #define SR_FIELD_HNAME				418
  #define SR_FIELD_SNAME				419
  #define SR_FIELD_INAME				420
  #define SR_FIELD_ANAME				421
  #define SR_FIELD_PERKRANK				422
  #define SR_FIELD_PARAM3				423
  #define SR_FIELD_RUNON				424
  #define SR_FIELD_SCRIPTCOUNT			425
	#define SR_FIELD_DELIVERYTYPE		426
	#define SR_FIELD_RESISTTYPE			427
	#define SR_FIELD_TAPERWEIGHT		428
	#define SR_FIELD_TAPERDURATION		429
	#define SR_FIELD_TAPERCURVE			430
	#define SR_FIELD_SECONDAVWEIGHT		431
	#define SR_FIELD_SOUNDVOLUME		432
	#define SR_FIELD_DUALCASTSCALE		433
	#define SR_FIELD_NOHITEVENT			434
	#define SR_FIELD_NOMAGNITUDE		435
	#define SR_FIELD_NORECAST			436
	#define SR_FIELD_GORYVISUAL			437
	#define SR_FIELD_HIDEINUI			438
	#define SR_FIELD_POWERMAGNITUDE		439
	#define SR_FIELD_PAINLESS			440
	#define SR_FIELD_POWERDURATION		441
	#define SR_FIELD_NOHITEFFECT		442
	#define SR_FIELD_NODEATHDISPELL		443
	#define SR_FIELD_NODURATION			444
	#define	SR_FIELD_MENU				445
	#define SR_FIELD_COUNTEREFFECTCOUNT	446
	#define SR_FIELD_SNAPTONAVMESH		447
	#define SR_FIELD_SCRIPTAIDATASCORE	448
	#define SR_FIELD_SCRIPTAIDATADELAY	449
	#define SR_FIELD_DISPELEFFECTS		450
	#define SR_FIELD_CHARGETIME			451
	#define SR_FIELD_ENCHANTTYPE		452
	#define SR_FIELD_EXTENDDURATION		453
	#define SR_FIELD_ADDICTION			454
	#define SR_FIELD_ADDICTIONCHANCE	455
	#define SR_FIELD_POISON				456
	#define SR_FIELD_MEDICINE			457
	#define SR_FIELD_MESSAGEICON		458
	#define SR_FIELD_REFERENCEPERSIST	459
	#define SR_FIELD_INVENTORYMODEL		460
	#define SR_FIELD_AREAIGNORESLOS		461
	#define SR_FIELD_PCSTARTSPELL		462
	#define SR_FIELD_NOABSORBREFLECT	463
	#define SR_FIELD_NODUALCASTMODS		464
	#define SR_FIELD_SCRIPTALWAYSAPPLIES	465
	#define SR_FIELD_FORCEEXPLODE			466
/*===========================================================================
 *		End of Field Types
 *=========================================================================*/


/*===========================================================================
 *
 * Begin Function Prototypes
 *
 *=========================================================================*/

  bool          GetSrFieldValue  (int& Value, const SSCHAR* pString);
  const SSCHAR* GetSrFieldString (const int Value);

  bool SrFieldConvertLong    (const SSCHAR* pString, long&  Value);
  bool SrFieldConvertInt     (const SSCHAR* pString, int&   Value);
  bool SrFieldConvertDword   (const SSCHAR* pString, dword& Value);
  bool SrFieldConvertShort   (const SSCHAR* pString, short& Value);
  bool SrFieldConvertWord    (const SSCHAR* pString, word&  Value);
  bool SrFieldConvertByte    (const SSCHAR* pString, byte&  Value);
  bool SrFieldConvertFloat   (const SSCHAR* pString, float& Value);
  bool SrFieldConvertBoolean (const SSCHAR* pString, bool&  Value);
  bool SrFieldConvertColor   (const SSCHAR* pString, srrgba_t& Value);

/*===========================================================================
 *		End of Function Prototypes
 *=========================================================================*/


#endif
/*===========================================================================
 *		End of File Srfields.H
 *=========================================================================*/


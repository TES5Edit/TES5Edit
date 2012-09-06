/*===========================================================================
 *
 * File:	Esmscriptfuncs.CPP
 * Author:	Dave Humphrey (uesp@m0use.net)
 * Created On:	Wednesday, February 12, 2003
 *
 * Description
 *
 *=========================================================================*/

	/* Include Files */
#include "esmscriptdefs.h"
#include "file/GenFile.h"

	/* Shorter definitions for convienence */
  #define VN     0
  #define VB     ESMSCR_FUNC_BYTE
  #define VS     ESMSCR_FUNC_SHORT
  #define VL     ESMSCR_FUNC_LONG
  #define VF     ESMSCR_FUNC_FLOAT
  #define VSTR   ESMSCR_FUNC_STRING
  #define VSST   ESMSCR_FUNC_SHORTSTR
  #define VEXS   ESMSCR_FUNC_EXTRASHORT
  #define VNOO   ESMSCR_FUNC_NOOPTOUT
  #define VID    ESMSCR_FUNC_ID
  #define VEFF   ESMSCR_FUNC_EFFECT
  #define VX     ESMSCR_FUNC_XYZ
  #define VOPT   ESMSCR_FUNC_OPTIONAL
  #define VNR    ESMSCR_FUNC_NOTREQ
  #define VTRB   ESMSCR_FUNC_TRIBUNAL
  #define VBM    ESMSCR_FUNC_BLOODMOON
  #define VSE	 ESMSCR_FUNC_MWSE
  #define VSV    ESMSCR_FUNC_SHORTVAR
  #define VDLG   ESMSCR_FUNC_DIALOGUE
  #define VAG    ESMSCR_FUNC_ALLOWGLOBAL
  #define VBAD   ESMSCR_FUNC_BAD
  #define VVAR   ESMSCR_FUNC_VAR
  #define VRST   ESMSCR_FUNC_RESET
  #define VCSTR  ESMSCR_FUNC_CELLSTR
  #define VCID   ESMSCR_FUNC_CELLID
  #define VEID   ESMSCR_FUNC_EFFECTID
  #define VLCID  ESMSCR_FUNC_LEVELCID
  #define VLIID  ESMSCR_FUNC_LEVELIID
  #define VSGID  ESMSCR_FUNC_SOULGEMID
  #define VCRID  ESMSCR_FUNC_CREATUREID
  #define VNPID  ESMSCR_FUNC_NPCID
  #define VSPID  ESMSCR_FUNC_SPELLID
  #define VTPID  ESMSCR_FUNC_TOPICID
  #define VREG   ESMSCR_FUNC_REGIONID
  #define VITMID ESMSCR_FUNC_ITEMID
  #define VFAC   ESMSCR_FUNC_FACTIONID
  #define VJRNID ESMSCR_FUNC_JOURNALID
  #define VRAID  ESMSCR_FUNC_RACEID
  #define VSNDID ESMSCR_FUNC_SOUNDID
  #define VSCTID ESMSCR_FUNC_SCRIPTID
  #define VANIM  ESMSCR_FUNC_ANIM
  #define VMNY   ESMSCR_FUNC_MANY
  #define VAO	 (VS|VL|VF|VSTR|VOPT)
  #define VOST   ESMSCR_FUNC_OPTSTART
  #define VNOT   ESMSCR_FUNC_NOOUTPUT
  
  // SE variables allowed, Strings, and References
  
  #define VSEV	(VSE|VAG|VSV|VVAR)
  #define VSES	(VL|VSTR)
  #define VSER	VL
  #define VSEO	(VS|VL|VF|VSTR|VOPT|VMNY) 
  #define VSEM	(VS|VL|VF|VSTR|VMNY) 
  #define VNUM	(VS|VL|VF) 

esmscrfuncinfo_t g_ScriptFunctions[] = {
/*0*/ 	{ _T("Activate"),		0x1017, VNOO,	VN, VID|VOPT, VN, VN, VN, VN, VN, VN, VN, VN, VN, VN, VN	 },	
	{ _T("AddItem"),		0x10D4, 0,	VN, VID, VS, VN, VN, VN, VN, VN, VN, VN, VN, VN, VN,		 },
	{ _T("AddSoulGem"),		0x10EB, 0,	VN, VID|VSGID, VID | VCRID, VN, VN, VN, VN, VN, VN, VN, VN, VN, VN,	 },
	{ _T("AddSpell"),		0x111D, 0,	VN, VID|VSPID, VN, VN, VN, VN, VN, VN, VN, VN, VN, VN, VN,	 },
	{ _T("AddToLevCreature"),	0x11a6, VTRB,	VN, VID|VLCID, VID|VCRID|VNPID, VF, VN, VN, VN, VN, VN, VN, VN, VN, VN,	 },
	{ _T("AddToLevItem"),		0x11a8, VTRB,	VN, VID|VLIID, VID, VF, VN, VN, VN, VN, VN, VN, VN, VN, VN,	 },
	{ _T("AddTopic"),		0x1022, 0,	VN, VID|VTPID, VN, VN, VN, VN, VN, VN, VN, VN, VN, VN, VN,	 },
	{ _T("AIActivate"),		0x10F3,	0,	VN, VID, VRST|VOPT, VN, VN, VN, VN, VN, VN, VN, VN, VN, VN,	 },
	{ _T("AIEscort"),		0x10F4, 0,	VN, VID|VNPID|VCRID, VS, VF, VF, VF, VRST|VOPT, VN, VN, VN, VN, VN, VN,	 },
	{ _T("AIEscortCell"),		0x10F5, 0,	VN, VID|VNPID|VCRID, VID|VCID, VS, VF, VF, VF, VRST|VOPT, VN, VN, VN, VN, VN,	 },
	{ _T("AIFollow"),		0x10F6, 0,	VN, VID|VNPID|VCRID, VS, VF, VF, VF, VRST|VOPT, VN, VN, VN, VN, VN, VN,	 },
	{ _T("AIFollowCell"),		0x10F7, 0,	VN, VID|VNPID|VCRID, VID|VCID, VS, VF, VF, VF, VRST|VOPT, VN, VN, VN, VN, VN,	 },
	{ _T("AITravel"),		0x10F8, 0,	VN, VF, VF, VF, VRST|VOPT, VN, VN, VN, VN, VN, VN, VN, VN,	 },
	{ _T("AIWander"),		0x10F9, 0,	VN, VF, VF, VF|VOST, VS|VOPT|VNOT, VS|VOPT, VS|VOPT, VS|VOPT, VS|VOPT, VS|VOPT, VS|VOPT, VS|VOPT, VS|VOPT, VRST|VOPT	 },
/*14*/	{ _T("BecomeWerewolf"),		0x11B3, VBM,	VN, VN, VN, VN, VN, VN, VN, VN, VN, VN, VN, VN, VN,		 },
/*15*/	{ _T("Cast"),			0x1123, 0,	VN, VID|VSPID, VID|VNPID|VCRID, VN, VN, VN, VN, VN, VN, VN, VN, VN, VN,	 },
	{ _T("CellChanged"),		0x101F, 0,	VS, VN, VN, VN, VN, VN, VN, VN, VN, VN, VN, VN, VN,		 },
	{ _T("CellUpdate"),		0x1013, VBAD,	VS, VN, VN, VN, VN, VN, VN, VN, VN, VN, VN, VN, VN,		 },
	{ _T("CenterOnCell"),		0x10d6, 0,	VN, VID|VCID, VN, VN, VN, VN, VN, VN, VN, VN, VN, VN, VN,	 },
	{ _T("CenterOnExterior"),	0x112a, 0,	VN, VS, VS, VN, VN, VN, VN, VN, VN, VN, VN, VN, VN,		 },
	{ _T("ChangeWeather"),		0x1124, 0,	VN, VID|VREG, VS, VN, VN, VN, VN, VN, VN, VN, VN, VN, VN,	 },
	{ _T("Choice"),			0x10C9, VDLG,	VN, VSTR, VSTR|VNR|VNUM, VSTR|VNR|VNUM, VSTR|VNR|VNUM, VSTR|VNR|VNUM, VSTR|VNR|VNUM, VSTR|VNR|VNUM, VSTR|VNR|VNUM, VSTR|VNR|VNUM, VSTR|VNR|VNUM, VSTR|VNR|VNUM, VSTR|VNR|VNUM,	 },
	{ _T("ClearForceJump"),		0x119e, VTRB,	VN, VN, VN, VN, VN, VN, VN, VN, VN, VN, VN, VN, VN,		 },
	{ _T("ClearForceMoveJump"),	0x11a1, VTRB,	VN, VN, VN, VN, VN, VN, VN, VN, VN, VN, VN, VN, VN,		 },
	{ _T("ClearForceRun"),		0x119b, VTRB,	VN, VN, VN, VN, VN, VN, VN, VN, VN, VN, VN, VN, VN,		 },
	{ _T("ClearForceSneak"),	0x1164, 0,	VN, VN, VN, VN, VN, VN, VN, VN, VN, VN, VN, VN, VN,		 },
	{ _T("ClearInfoActor"),		0x10CB, 0,	VN, VN, VN, VN, VN, VN, VN, VN, VN, VN, VN, VN, VN,		 },
	{ _T("COC"),			0x10d6, 0,	VN, VID|VCID, VN, VN, VN, VN, VN, VN, VN, VN, VN, VN, VN,	 },
	{ _T("COE"),			0x112a, 0,	VN, VS, VS, VN, VN, VN, VN, VN, VN, VN, VN, VN, VN,		 },
/*29*/	{ _T("Disable"),		0x10DB, 0,	VN, VN, VN, VN, VN, VN, VN, VN, VN, VN, VN, VN, VN,		 },
	{ _T("DisableLevitation"),	0x1194, VTRB,	VN, VN, VN, VN, VN, VN, VN, VN, VN, VN, VN, VN, VN,		 },
	{ _T("DisablePlayerControls"),	0x10DE, 0,	VN, VN, VN, VN, VN, VN, VN, VN, VN, VN, VN, VN, VN,		 },
	{ _T("DisablePlayerFighting"),	0x115A, 0,	VN, VN, VN, VN, VN, VN, VN, VN, VN, VN, VN, VN, VN,		 },
	{ _T("DisablePlayerJumping"),	0x1140, 0,	VN, VN, VN, VN, VN, VN, VN, VN, VN, VN, VN, VN, VN,		 },
	{ _T("DisablePlayerLooking"),	0x1143, 0,	VN, VN, VN, VN, VN, VN, VN, VN, VN, VN, VN, VN, VN,		 },
	{ _T("DisablePlayerMagic"),	0x115D, 0,	VN, VN, VN, VN, VN, VN, VN, VN, VN, VN, VN, VN, VN,		 },
	{ _T("DisablePlayerViewSwitch"),0x10E3, 0,	VN, VN, VN, VN, VN, VN, VN, VN, VN, VN, VN, VN, VN,		 },
	{ _T("DisableTeleporting"),	0x10Ef, 0,	VN, VN, VN, VN, VN, VN, VN, VN, VN, VN, VN, VN, VN,		 },
	{ _T("DisableVanityMode"),	0x114c, 0,	VN, VN, VN, VN, VN, VN, VN, VN, VN, VN, VN, VN, VN,		 },
	{ _T("DontSaveObject"),		0x115f, VTRB,	VN, VN, VN, VN, VN, VN, VN, VN, VN, VN, VN, VN, VN,		 },
	{ _T("Drop"),			0x110d, 0,	VN, VID, VS, VN, VN, VN, VN, VN, VN, VN, VN, VN, VN,		 },
	{ _T("DropSoulGem"),		0x10ed, 0,	VN, VID|VCRID, VN, VN, VN, VN, VN, VN, VN, VN, VN, VN, VN,	 },
/*42*/	{ _T("Enable"),			0x10da, 0,	VN, VN, VN, VN, VN, VN, VN, VN, VN, VN, VN, VN, VN,		 },
	{ _T("EnableBirthMenu"),	0x1129, 0,	VN, VN, VN, VN, VN, VN, VN, VN, VN, VN, VN, VN, VN,		 },
	{ _T("EnableClassMenu"),	0x1128, 0,	VN, VN, VN, VN, VN, VN, VN, VN, VN, VN, VN, VN, VN,		 },
	{ _T("EnableInventoryMenu"),	0x1118, 0,	VN, VN, VN, VN, VN, VN, VN, VN, VN, VN, VN, VN, VN,		 },
	{ _T("EnableLevelupMenu"),	0x1158, 0,	VN, VN, VN, VN, VN, VN, VN, VN, VN, VN, VN, VN, VN,		 },
	{ _T("EnableLevitation"),	0x1193, VTRB,	VN, VN, VN, VN, VN, VN, VN, VN, VN, VN, VN, VN, VN,		 },
	{ _T("EnableMagicMenu"),	0x111a, 0,	VN, VN, VN, VN, VN, VN, VN, VN, VN, VN, VN, VN, VN,		 },
	{ _T("EnableMapMenu"),		0x1119, 0,	VN, VN, VN, VN, VN, VN, VN, VN, VN, VN, VN, VN, VN,		 },
	{ _T("EnableNameMenu"),		0x1126, 0,	VN, VN, VN, VN, VN, VN, VN, VN, VN, VN, VN, VN, VN,		 },
	{ _T("EnablePlayerControls"),	0x10dd, 0,	VN, VN, VN, VN, VN, VN, VN, VN, VN, VN, VN, VN, VN,		 },
	{ _T("EnablePlayerFighting"),	0x1159, 0,	VN, VN, VN, VN, VN, VN, VN, VN, VN, VN, VN, VN, VN,		 },
	{ _T("EnablePlayerJumping"),	0x113f, 0,	VN, VN, VN, VN, VN, VN, VN, VN, VN, VN, VN, VN, VN,		 },
	{ _T("EnablePlayerLooking"),	0x1142, 0,	VN, VN, VN, VN, VN, VN, VN, VN, VN, VN, VN, VN, VN,		 },
	{ _T("EnablePlayerMagic"),	0x115c, 0,	VN, VN, VN, VN, VN, VN, VN, VN, VN, VN, VN, VN, VN,		 },
	{ _T("EnablePlayerViewSwitch"),	0x10e2, 0,	VN, VN, VN, VN, VN, VN, VN, VN, VN, VN, VN, VN, VN,		 },
	{ _T("EnableRaceMenu"),		0x1127, 0,	VN, VN, VN, VN, VN, VN, VN, VN, VN, VN, VN, VN, VN,		 },
	{ _T("EnableRest"),		0x013f, 0,	VN, VN, VN, VN, VN, VN, VN, VN, VN, VN, VN, VN, VN,		 },
	{ _T("EnableStatReviewMenu"),	0x1160, 0,	VN, VN, VN, VN, VN, VN, VN, VN, VN, VN, VN, VN, VN,		 },
	{ _T("EnableStatsMenu"),	0x1117, 0,	VN, VN, VN, VN, VN, VN, VN, VN, VN, VN, VN, VN, VN,		 },
	{ _T("EnableTeleporting"),	0x10ee, 0,	VN, VN, VN, VN, VN, VN, VN, VN, VN, VN, VN, VN, VN,		 },
	{ _T("EnableVanityMode"),	0x114b, 0,	VN, VN, VN, VN, VN, VN, VN, VN, VN, VN, VN, VN, VN,		 },
	{ _T("Equip"),			0x110e, 0,	VN, VID|VITMID, VN, VN, VN, VN, VN, VN, VN, VN, VN, VN, VN,	 },
	{ _T("ExplodeSpell"),		0x11ad, VTRB,	VN, VID|VSPID, VN, VN, VN, VN, VN, VN, VN, VN, VN, VN, VN,	 },
/*65*/	{ _T("Face"),			0x1162, 0,	VN, VF, VF, VN, VN, VN, VN, VN, VN, VN, VN, VN, VN,		 },
	{ _T("FadeIn"),			0x1131, 0,	VN, VF, VN, VN, VN, VN, VN, VN, VN, VN, VN, VN, VN,		 },
	{ _T("FadeOut"),		0x1130, 0,	VN, VF, VN, VN, VN, VN, VN, VN, VN, VN, VN, VN, VN,		 },
	{ _T("FadeTo"),			0x1145, 0,	VN, VL, VF, VN, VN, VN, VN, VN, VN, VN, VN, VN, VN,		 },
	{ _T("Fall"),			0x1166, 0,	VN, VN, VN, VN, VN, VN, VN, VN, VN, VN, VN, VN, VN,		 },
	{ _T("FillMap"),		0x13e, 0,	VN, VN, VN, VN, VN, VN, VN, VN, VN, VN, VN, VN, VN,		 },
	{ _T("FixMe"),			0x131, 0,	VN, VN, VN, VN, VN, VN, VN, VN, VN, VN, VN, VN, VN,		 },
	{ _T("ForceGreeting"),		0x10e8, 0,	VN, VN, VN, VN, VN, VN, VN, VN, VN, VN, VN, VN, VN,		 },
	{ _T("ForceJump"),		0x119d, VTRB,	VN, VN, VN, VN, VN, VN, VN, VN, VN, VN, VN, VN, VN,		 },
	{ _T("ForceMoveJump"),		0x11a0, VTRB,	VN, VN, VN, VN, VN, VN, VN, VN, VN, VN, VN, VN, VN,		 },
	{ _T("ForceRun"),		0x119a, VTRB,	VN, VN, VN, VN, VN, VN, VN, VN, VN, VN, VN, VN, VN,		 },
	{ _T("ForceSneak"),		0x1163, 0,	VN, VN, VN, VN, VN, VN, VN, VN, VN, VN, VN, VN, VN,		 },
/*77*/	{ _T("GetAcrobatics"),		0x1077, 0,	VF, VN, VN, VN, VN, VN, VN, VN, VN, VN, VN, VN, VN,		 },
	{ _T("GetAgility"),		0x102c, 0,	VF, VN, VN, VN, VN, VN, VN, VN, VN, VN, VN, VN, VN,		 },
	{ _T("GetAIPackageDone"),	0x10fb, 0,	VF, VN, VN, VN, VN, VN, VN, VN, VN, VN, VN, VN, VN,		 },
	{ _T("GetAlarm"),		0x1105, 0,	VF, VN, VN, VN, VN, VN, VN, VN, VN, VN, VN, VN, VN,		 },
	{ _T("GetAlchemy"),		0x106b, 0,	VF, VN, VN, VN, VN, VN, VN, VN, VN, VN, VN, VN, VN,		 },
	{ _T("GetAlteration"),		0x105c, 0,	VF, VN, VN, VN, VN, VN, VN, VN, VN, VN, VN, VN, VN,		 },
	{ _T("GetAngle"),		0x100c, 0,	VF, VX, VN, VN, VN, VN, VN, VN, VN, VN, VN, VN, VN,		 },
	{ _T("GetArmorBonus"),		0x1176, 0,	VF, VN, VN, VN, VN, VN, VN, VN, VN, VN, VN, VN, VN,		 },
	{ _T("GetArmorer"),		0x103e, 0,	VF, VN, VN, VN, VN, VN, VN, VN, VN, VN, VN, VN, VN,		 },
	{ _T("GetArmorType"),		0x1198, VTRB,	VF, VS, VN, VN, VN, VN, VN, VN, VN, VN, VN, VN, VN,		 },
	{ _T("GetAthletics"),		0x1053, 0,	VF, VN, VN, VN, VN, VN, VN, VN, VN, VN, VN, VN, VN,		 },
	{ _T("GetAttackBonus"),		0x10a2, 0,	VF, VN, VN, VN, VN, VN, VN, VN, VN, VN, VN, VN, VN,		 },
	{ _T("GetAttacked"),		0x1148, 0,	VS, VN, VN, VN, VN, VN, VN, VN, VN, VN, VN, VN, VN,		 },
	{ _T("GetAxe"),			0x104d, 0,	VF, VN, VN, VN, VN, VN, VN, VN, VN, VN, VN, VN, VN,		 },
	{ _T("GetBlightDisease"),	0x114a, 0,	VF, VN, VN, VN, VN, VN, VN, VN, VN, VN, VN, VN, VN,		 },
	{ _T("GetBlindness"),		0x117f, 0,	VF, VN, VN, VN, VN, VN, VN, VN, VN, VN, VN, VN, VN,		 },
	{ _T("GetBlock"),		0x103b, 0,	VF, VN, VN, VN, VN, VN, VN, VN, VN, VN, VN, VN, VN,		 },
	{ _T("GetBluntWeapon"),		0x1047, 0,	VF, VN, VN, VN, VN, VN, VN, VN, VN, VN, VN, VN, VN,		 },
	{ _T("GetButtonPressed"),	0x101e, 0,	VS, VN, VN, VN, VN, VN, VN, VN, VN, VN, VN, VN, VN,		 },
	{ _T("GetCastPenalty"),		0x1179, 0,	VF, VN, VN, VN, VN, VN, VN, VN, VN, VN, VN, VN, VN,		 },
	{ _T("GetChameleon"),		0x10c3, 0,	VF, VN, VN, VN, VN, VN, VN, VN, VN, VN, VN, VN, VN,		 },
	{ _T("GetCollidingActor"),	0x11a4, VTRB,	VS, VN, VN, VN, VN, VN, VN, VN, VN, VN, VN, VN, VN,		 },
	{ _T("GetCollidingPC"),		0x11a3, VTRB,	VS, VN, VN, VN, VN, VN, VN, VN, VN, VN, VN, VN, VN,		 },
	{ _T("GetCommonDisease"),	0x1149, 0,	VS, VN, VN, VN, VN, VN, VN, VN, VN, VN, VN, VN, VN,		 },
	{ _T("GetConjuration"),		0x1062, 0,	VS, VN, VN, VN, VN, VN, VN, VN, VN, VN, VN, VN, VN,		 },
	{ _T("GetCurrentAIPackage"),	0x10fa, 0,	VS, VN, VN, VN, VN, VN, VN, VN, VN, VN, VN, VN, VN,		 },
	{ _T("GetCurrentTime"),		0x1011, 0,	VF, VN, VN, VN, VN, VN, VN, VN, VN, VN, VN, VN, VN,		 },
	{ _T("GetCurrentWeather"),	0x10a1, 0,	VS, VN, VN, VN, VN, VN, VN, VN, VN, VN, VN, VN, VN,		 },
	{ _T("GetDeadCount"),		0x10fe, 0,	VL, VID|VNPID|VCRID, VN, VN, VN, VN, VN, VN, VN, VN, VN, VN, VN, },
	{ _T("GetDefendBonus"),		0x10a5, 0,	VF, VN, VN, VN, VN, VN, VN, VN, VN, VN, VN, VN, VN,		 },
	{ _T("GetDestruction"),		0x1059, 0,	VF, VN, VN, VN, VN, VN, VN, VN, VN, VN, VN, VN, VN,		 },
	{ _T("GetDetected"),		0x114e, 0,	VS, VID|VNPID|VCRID, VN, VN, VN, VN, VN, VN, VN, VN, VN, VN, VN,},
	{ _T("GetDisabled"),		0x10dc, 0,	VS, VN, VN, VN, VN, VN, VN, VN, VN, VN, VN, VN, VN,		 },
	{ _T("GetDisposition"),		0x1098, 0,	VF, VN, VN, VN, VN, VN, VN, VN, VN, VN, VN, VN, VN,		 },
	{ _T("GetDistance"),		0x1001, 0,	VF, VID, VN, VN, VN, VN, VN, VN, VN, VN, VN, VN, VN,		 },
	{ _T("GetEffect"),		0x1138, VSV,	VS, VEFF, VN, VN, VN, VN, VN, VN, VN, VN, VN, VN, VN,		 },
	{ _T("GetEnchant"),		0x1056, 0,	VF, VN, VN, VN, VN, VN, VN, VN, VN, VN, VN, VN, VN,		 },
	{ _T("GetEndurance"),		0x1032, 0,	VF, VN, VN, VN, VN, VN, VN, VN, VN, VN, VN, VN, VN,		 },
	{ _T("GetFactionReaction"),	0x1153, 0,	VF, VID|VFAC, VID|VFAC, VN, VN, VN, VN, VN, VN, VN, VN, VN, VN,	 },
	{ _T("GetFatigue"),		0x1092, 0,	VF, VN, VN, VN, VN, VN, VN, VN, VN, VN, VN, VN, VN,		 },
	{ _T("GetFight"),		0x10ff, 0,	VF, VN, VN, VN, VN, VN, VN, VN, VN, VN, VN, VN, VN,		 },
	{ _T("GetFlee"),		0x1102, 0,	VF, VN, VN, VN, VN, VN, VN, VN, VN, VN, VN, VN, VN,		 },
	{ _T("GetFlying"),		0x1173, 0,	VF, VN, VN, VN, VN, VN, VN, VN, VN, VN, VN, VN, VN,		 },
	{ _T("GetForceJump"),		0x119f, VTRB,	VF, VN, VN, VN, VN, VN, VN, VN, VN, VN, VN, VN, VN,		 },
	{ _T("GetForceMoveJump"),	0x11a2, VTRB,	VF, VN, VN, VN, VN, VN, VN, VN, VN, VN, VN, VN, VN,		 },
	{ _T("GetForceRun"),		0x119c, VTRB,	VF, VN, VN, VN, VN, VN, VN, VN, VN, VN, VN, VN, VN,		 },
	{ _T("GetForceSneak"),		0x1165, 0,	VF, VN, VN, VN, VN, VN, VN, VN, VN, VN, VN, VN, VN,		 },
	{ _T("GetHandToHand"),		0x1089, 0,	VF, VN, VN, VN, VN, VN, VN, VN, VN, VN, VN, VN, VN,		 },
	{ _T("GetHealth"),		0x108c, 0,	VF, VN, VN, VN, VN, VN, VN, VN, VN, VN, VN, VN, VN,		 },
	{ _T("GetHealthGetRatio"),	0x1154, 0,	VF, VN, VN, VN, VN, VN, VN, VN, VN, VN, VN, VN, VN,		 },
	{ _T("GetHeavyArmor"),		0x1044, 0,	VF, VN, VN, VN, VN, VN, VN, VN, VN, VN, VN, VN, VN,		 },
	{ _T("GetHello"),		0x1108, 0,	VF, VN, VN, VN, VN, VN, VN, VN, VN, VN, VN, VN, VN,		 },
	{ _T("GetIllusion"),		0x105f, 0,	VF, VN, VN, VN, VN, VN, VN, VN, VN, VN, VN, VN, VN,		 },
	{ _T("GetIntelligence"),	0x1026, 0,	VF, VN, VN, VN, VN, VN, VN, VN, VN, VN, VN, VN, VN,		 },
	{ _T("GetInterior"),		0x110b, 0,	VS, VN, VN, VN, VN, VN, VN, VN, VN, VN, VN, VN, VN,		 },
	{ _T("GetInvisible"),		0x1185, 0,	VF, VN, VN, VN, VN, VN, VN, VN, VN, VN, VN, VN, VN,		 },
	{ _T("GetItemCount"),		0x10fd, 0,	VL, VID|VITMID, VN, VN, VN, VN, VN, VN, VN, VN, VN, VN, VN,	 },
	{ _T("GetJournalIndex"),	0x10cd, 0,	VL, VID|VJRNID, VN, VN, VN, VN, VN, VN, VN, VN, VN, VN, VN,	 },
	{ _T("GetLevel"),		0x1157, 0,	VF, VN, VN, VN, VN, VN, VN, VN, VN, VN, VN, VN, VN,		 },
	{ _T("GetLightArmor"),		0x107a, 0,	VF, VN, VN, VN, VN, VN, VN, VN, VN, VN, VN, VN, VN,		 },
	{ _T("GetLineOfSight"),		0x10fc, 0,	VS, VID, VN, VN, VN, VN, VN, VN, VN, VN, VN, VN, VN,		 },
	{ _T("GetLocked"),		0x1161, 0,	VF, VN, VN, VN, VN, VN, VN, VN, VN, VN, VN, VN, VN,		 },
	{ _T("GetLongBlade"),		0x104a, 0,	VF, VN, VN, VN, VN, VN, VN, VN, VN, VN, VN, VN, VN,		 },
	{ _T("GetLOS"),			0x10fc, 0,	VS, VID, VN, VN, VN, VN, VN, VN, VN, VN, VN, VN, VN,		 },
	{ _T("GetLuck"),		0x1038, 0,	VF, VN, VN, VN, VN, VN, VN, VN, VN, VN, VN, VN, VN,		 },
	{ _T("GetMagicka"),		0x108f, 0,	VF, VN, VN, VN, VN, VN, VN, VN, VN, VN, VN, VN, VN,		 },
	{ _T("GetMarksman"),		0x1080, 0,	VF, VN, VN, VN, VN, VN, VN, VN, VN, VN, VN, VN, VN,		 },
	{ _T("GetMasserPhase"),		0x1146, 0,	VF, VN, VN, VN, VN, VN, VN, VN, VN, VN, VN, VN, VN,		 },
	{ _T("GetMediumArmor"),		0x1041, 0,	VF, VN, VN, VN, VN, VN, VN, VN, VN, VN, VN, VN, VN,		 },
	{ _T("GetMercantile"),		0x1083, 0,	VF, VN, VN, VN, VN, VN, VN, VN, VN, VN, VN, VN, VN,		 },
	{ _T("GetMysticism"),		0x1065, 0,	VF, VN, VN, VN, VN, VN, VN, VN, VN, VN, VN, VN, VN,		 },
	{ _T("GetParalysis"),		0x1182, 0,	VF, VN, VN, VN, VN, VN, VN, VN, VN, VN, VN, VN, VN,		 },
	{ _T("GetPCCell"),		0x1112, 0,	VS, VID|VCID|VCSTR, VN, VN, VN, VN, VN, VN, VN, VN, VN, VN, VN,	 },
	{ _T("GetPCCrimeLevel"),	0x109b, 0,	VF, VN, VN, VN, VN, VN, VN, VN, VN, VN, VN, VN, VN,		 },
	{ _T("GetPCFacRep"),		0x10d7, 0,	VF, VID|VFAC, VN, VN, VN, VN, VN, VN, VN, VN, VN, VN, VN,	 },
	{ _T("GetPCinJail"),		0x11BB, VBM,	VS, VN, VN, VN, VN, VN, VN, VN, VN, VN, VN, VN, VN,		 },
	{ _T("GetPCJumping"),		0x118c, VTRB,	VS, VN, VN, VN, VN, VN, VN, VN, VN, VN, VN, VN, VN,		 },
	{ _T("GetPCRank"),		0x110c, VNOO,	VS, VID|VFAC|VOPT, VN, VN, VN, VN, VN, VN, VN, VN, VN, VN, VN,		 },
	{ _T("GetPCRunning"),		0x118b, VTRB,	VS, VN, VN, VN, VN, VN, VN, VN, VN, VN, VN, VN, VN,		 },
	{ _T("GetPCSleep"),		0x10e0, 0,	VS, VN, VN, VN, VN, VN, VN, VN, VN, VN, VN, VN, VN,		 },
	{ _T("GetPCSneaking"),		0x118a, VTRB,	VF, VN, VN, VN, VN, VN, VN, VN, VN, VN, VN, VN, VN,		 },
	{ _T("GetPCTraveling"),		0x11BC, VBM,	VS, VN, VN, VN, VN, VN, VN, VN, VN, VN, VN, VN, VN,		 },
	{ _T("GetPCVisionBonus"),	0x11b0, 0,	VF, VN, VN, VN, VN, VN, VN, VN, VN, VN, VN, VN, VN,		 },
	{ _T("GetPersonality"),		0x1035, 0,	VF, VN, VN, VN, VN, VN, VN, VN, VN, VN, VN, VN, VN,		 },
	{ _T("GetPlayerControlsDisabled"),	0x10df, 0,	VS, VN, VN, VN, VN, VN, VN, VN, VN, VN, VN, VN, VN,	 },
	{ _T("GetPlayerFightingDisabled"),	0x115b, 0,	VS, VN, VN, VN, VN, VN, VN, VN, VN, VN, VN, VN, VN,	 },
	{ _T("GetPlayerJumpingDisabled"),	0x1141, 0,	VS, VN, VN, VN, VN, VN, VN, VN, VN, VN, VN, VN, VN,	},
	{ _T("GetPlayerLookingDisabled"),	0x1144, 0,	VS, VN, VN, VN, VN, VN, VN, VN, VN, VN, VN, VN, VN,	 },
	{ _T("GetPlayerMagicDisabled"),		0x115e, 0,	VS, VN, VN, VN, VN, VN, VN, VN, VN, VN, VN, VN, VN,	 },
	{ _T("GetPlayerViewSwitch"),		0x10e4, VBAD,	VS, VN, VN, VN, VN, VN, VN, VN, VN, VN, VN, VN, VN,	 },
	{ _T("GetPos"),			0x100a, 0,	VF, VX, VN, VN, VN, VN, VN, VN, VN, VN, VN, VN, VN,		 },
	{ _T("GetRace"),		0x1139, 0,	VS, VID|VRAID, VN, VN, VN, VN, VN, VN, VN, VN, VN, VN, VN,	 },
	{ _T("GetReputation"),		0x1095, 0,	VF, VN, VN, VN, VN, VN, VN, VN, VN, VN, VN, VN, VN,		 },
	{ _T("GetResistBlight"),	0x10b7, 0,	VF, VN, VN, VN, VN, VN, VN, VN, VN, VN, VN, VN, VN,		 },
	{ _T("GetResistCorprus"),	0x10ba, 0,	VF, VN, VN, VN, VN, VN, VN, VN, VN, VN, VN, VN, VN,		 },
	{ _T("GetResistDisease"),	0x10b4, 0,	VF, VN, VN, VN, VN, VN, VN, VN, VN, VN, VN, VN, VN,		 },
	{ _T("GetResistFire"),		0x10ab, 0,	VF, VN, VN, VN, VN, VN, VN, VN, VN, VN, VN, VN, VN,		 },
	{ _T("GetResistFrost"),		0x10ae, 0,	VF, VN, VN, VN, VN, VN, VN, VN, VN, VN, VN, VN, VN,		 },
	{ _T("GetResistMagicka"),	0x10a8, 0,	VF, VN, VN, VN, VN, VN, VN, VN, VN, VN, VN, VN, VN,		 },
	{ _T("GetResistNormalWeapons"),	0x10c6, 0,	VF, VN, VN, VN, VN, VN, VN, VN, VN, VN, VN, VN, VN,		 },
	{ _T("GetResistParalysis"),	0x10c0, 0,	VF, VN, VN, VN, VN, VN, VN, VN, VN, VN, VN, VN, VN,		 },
	{ _T("GetResistPoison"),	0x10bd, 0,	VF, VN, VN, VN, VN, VN, VN, VN, VN, VN, VN, VN, VN,		 },
	{ _T("GetResistShock"),		0x10b1, 0,	VF, VN, VN, VN, VN, VN, VN, VN, VN, VN, VN, VN, VN,		 },
	{ _T("GetRestoration"),		0x1068, 0,	VF, VN, VN, VN, VN, VN, VN, VN, VN, VN, VN, VN, VN,		 },
	{ _T("GetScale"),		0x118d, VTRB,	VF, VN, VN, VN, VN, VN, VN, VN, VN, VN, VN, VN, VN,		 },
	{ _T("GetSecondsPassed"),	0x1012, 0,	VF, VN, VN, VN, VN, VN, VN, VN, VN, VN, VN, VN, VN,		 },
	{ _T("GetSecundaPhase"),	0x1147, 0,	VF, VN, VN, VN, VN, VN, VN, VN, VN, VN, VN, VN, VN,		 },
	{ _T("GetSecurity"),		0x1071, 0,	VF, VN, VN, VN, VN, VN, VN, VN, VN, VN, VN, VN, VN,		 },
	{ _T("GetShortBlade"),		0x107d, 0,	VF, VN, VN, VN, VN, VN, VN, VN, VN, VN, VN, VN, VN,		 },
	{ _T("GetSilence"),		0x117c, 0,	VF, VN, VN, VN, VN, VN, VN, VN, VN, VN, VN, VN, VN,		 },
	{ _T("GetSneak"),		0x1074, 0,	VF, VN, VN, VN, VN, VN, VN, VN, VN, VN, VN, VN, VN,		 },
	{ _T("GetSoundPlaying"),	0x1188, 0,	VS, VID|VSNDID, VN, VN, VN, VN, VN, VN, VN, VN, VN, VN, VN,	 },
	{ _T("GetSpear"),		0x1050, 0,	VF, VN, VN, VN, VN, VN, VN, VN, VN, VN, VN, VN, VN,		 },
	{ _T("GetSpeechcraft"),		0x1086, 0,	VF, VN, VN, VN, VN, VN, VN, VN, VN, VN, VN, VN, VN,		 },
	{ _T("GetSpeed"),		0x102f, 0,	VF, VN, VN, VN, VN, VN, VN, VN, VN, VN, VN, VN, VN,		 },
	{ _T("GetSpell"),		0x111f, 0,	VS, VID|VSPID, VN, VN, VN, VN, VN, VN, VN, VN, VN, VN, VN,	 },
	{ _T("GetSpellEffects"),	0x1121, 0,	VS, VID|VSPID, VN, VN, VN, VN, VN, VN, VN, VN, VN, VN, VN,	 },
	{ _T("GetSpellReadied"),	0x11af, VTRB,	VS, VN, VN, VN, VN, VN, VN, VN, VN, VN, VN, VN, VN,	 },
	{ _T("GetSquareRoot"),		0x11ac, VVAR|VTRB|VAG,	VF, VF, VN, VN, VN, VN, VN, VN, VN, VN, VN, VN, VN,	 },
	{ _T("GetStandingActor"),	0x1114, 0,	VS, VN, VN, VN, VN, VN, VN, VN, VN, VN, VN, VN, VN,		 },
	{ _T("GetStandingPC"),		0x1113, 0,	VS, VN, VN, VN, VN, VN, VN, VN, VN, VN, VN, VN, VN,		 },
	{ _T("GetStartingAngle"),	0x100f, 0,	VF, VX, VN, VN, VN, VN, VN, VN, VN, VN, VN, VN, VN,		 },
	{ _T("GetStartingPos"),		0x100e, 0,	VF, VX, VN, VN, VN, VN, VN, VN, VN, VN, VN, VN, VN,		 },
	{ _T("GetStrength"),		0x1023, 0,	VF, VN, VN, VN, VN, VN, VN, VN, VN, VN, VN, VN, VN,		 },
	{ _T("GetSuperJump"),		0x1170, 0,	VF, VN, VN, VN, VN, VN, VN, VN, VN, VN, VN, VN, VN,		 },
	{ _T("GetSwimSpeed"),		0x116d, 0,	VF, VN, VN, VN, VN, VN, VN, VN, VN, VN, VN, VN, VN,		 },
	{ _T("GetTarget"),		0x1150, 0,	VF, VID/*|VCRID|VNPID*/, VN, VN, VN, VN, VN, VN, VN, VN, VN, VN, VN,	 },
	{ _T("GetUnarmored"),		0x106e, 0,	VF, VN, VN, VN, VN, VN, VN, VN, VN, VN, VN, VN, VN,		 },
	{ _T("GetVanityModeDisabled"),	0x114d, 0,	VS, VN, VN, VN, VN, VN, VN, VN, VN, VN, VN, VN, VN,		 },
	{ _T("GetWaterBreathing"),	0x1167, 0,	VF, VN, VN, VN, VN, VN, VN, VN, VN, VN, VN, VN, VN,		 },
	{ _T("GetWaterLevel"),		0x1190, VTRB,	VF, VN, VN, VN, VN, VN, VN, VN, VN, VN, VN, VN, VN,		 },
	{ _T("GetWaterWalking"),	0x116a, 0,	VF, VN, VN, VN, VN, VN, VN, VN, VN, VN, VN, VN, VN,		 },
	{ _T("GetWeaponDrawn"),		0x11ae, VTRB,	VF, VN, VN, VN, VN, VN, VN, VN, VN, VN, VN, VN, VN,		 },
	{ _T("GetWeaponType"),		0x1197, VTRB,	VS, VN, VN, VN, VN, VN, VN, VN, VN, VN, VN, VN, VN,		 },
	{ _T("GetWerewolfKills"),	0x11B6, VBM,	VS, VN, VN, VN, VN, VN, VN, VN, VN, VN, VN, VN, VN,		 },
	{ _T("GetWillpower"),		0x1029, 0,	VF, VN, VN, VN, VN, VN, VN, VN, VN, VN, VN, VN, VN,		 },
	{ _T("GetWindSpeed"),		0x10a0, 0,	VF, VN, VN, VN, VN, VN, VN, VN, VN, VN, VN, VN, VN,		 },
	{ _T("Goodbye"),		0x10ca, 0,	VN, VN, VN, VN, VN, VN, VN, VN, VN, VN, VN, VN, VN,		 },
	{ _T("GoToJail"),		0x10e9, 0,	VN, VN, VN, VN, VN, VN, VN, VN, VN, VN, VN, VN, VN,		 },
/*216*/	{ _T("HasItemEquipped"),	0x1199, VTRB,	VS, VID|VITMID, VN, VN, VN, VN, VN, VN, VN, VN, VN, VN, VN,	 },
	{ _T("HasSoulGem"),		0x10ea, 0,	VS, VID|VCRID, VN, VN, VN, VN, VN, VN, VN, VN, VN, VN, VN,	 },
	{ _T("HitAttemptOnMe"),		0x1116, 0,	VS, VID|VITMID, VN, VN, VN, VN, VN, VN, VN, VN, VN, VN, VN,	 },
	{ _T("HitOnMe"),		0x1115, 0,	VS, VID|VITMID, VN, VN, VN, VN, VN, VN, VN, VN, VN, VN, VN,	 },
	{ _T("HurtCollidingActor"),	0x11a5, 0,	VN, VF, VN, VN, VN, VN, VN, VN, VN, VN, VN, VN, VN,		 },
	{ _T("HurtStandingActor"),	0x1135, 0,	VN, VF, VN, VN, VN, VN, VN, VN, VN, VN, VN, VN, VN,		 },
/*222*/	{ _T("IsWerewolf"),		0x11B5, VBM,	VS, VN, VN, VN, VN, VN, VN, VN, VN, VN, VN, VN, VN,		 },
/*223*/	{ _T("Journal"),		0x10cc, VEXS,	VN, VID|VJRNID, VS, VN, VN, VN, VN, VN, VN, VN, VN, VN, VN,	 },
/*224*/	{ _T("Lock"),			0x1136, 0,	VN, VS, VN, VN, VN, VN, VN, VN, VN, VN, VN, VN, VN,		 },
	{ _T("LoopGroup"),		0x1015, 0,	VN, VANIM, VB, VB|VOPT, VN, VN, VN, VN, VN, VN, VN, VN, VN,	 },
	{ _T("LowerRank"),		0x10cf, 0,	VN, VN, VN, VN, VN, VN, VN, VN, VN, VN, VN, VN, VN,		 },
/*227*/	{ _T("MenuMode"),		0x1020, 0,	VS, VN, VN, VN, VN, VN, VN, VN, VN, VN, VN, VN, VN,		 },
	{ _T("MessageBox"),	 	0x1000, VAG|VSV|VVAR,	VN, VSTR, VF|VOPT|VNR|VMNY, VSTR|VOPT|VMNY, VN, VN, VN, VN, VN, VN, VN, VN, VN,  },
	{ _T("ModAcrobatics"),		0x1079, VSV|VVAR ,	VN, VF, VN, VN, VN, VN, VN, VN, VN, VN, VN, VN, VN,	 },
	{ _T("ModAgility"),		0x102e, VSV|VVAR ,	VN, VF, VN, VN, VN, VN, VN, VN, VN, VN, VN, VN, VN,	 },
	{ _T("ModAlarm"),		0x1107, VSV|VVAR ,	VN, VF, VN, VN, VN, VN, VN, VN, VN, VN, VN, VN, VN,	 },
	{ _T("ModAlchemy"),		0x106d, VSV|VVAR ,	VN, VF, VN, VN, VN, VN, VN, VN, VN, VN, VN, VN, VN,	 },
	{ _T("ModAlteration"),		0x105e, VSV|VVAR ,	VN, VF, VN, VN, VN, VN, VN, VN, VN, VN, VN, VN, VN,	 },
	{ _T("ModArmorBonus"),		0x1178, VSV|VVAR ,	VN, VF, VN, VN, VN, VN, VN, VN, VN, VN, VN, VN, VN,	 },
	{ _T("ModArmorer"),		0x1040, VSV|VVAR ,	VN, VF, VN, VN, VN, VN, VN, VN, VN, VN, VN, VN, VN,	 },
	{ _T("ModAthletics"),		0x1055, VSV|VVAR ,	VN, VF, VN, VN, VN, VN, VN, VN, VN, VN, VN, VN, VN,	 },
	{ _T("ModAttackBonus"),		0x10a4, VSV|VVAR ,	VN, VF, VN, VN, VN, VN, VN, VN, VN, VN, VN, VN, VN,	 },
	{ _T("ModAxe"),			0x104f, VSV|VVAR ,	VN, VF, VN, VN, VN, VN, VN, VN, VN, VN, VN, VN, VN,	 },
	{ _T("ModBlindness"),		0x1181, VSV|VVAR ,	VN, VF, VN, VN, VN, VN, VN, VN, VN, VN, VN, VN, VN,	 },
	{ _T("ModBlock"),		0x103d, VSV|VVAR ,	VN, VF, VN, VN, VN, VN, VN, VN, VN, VN, VN, VN, VN,	 },
	{ _T("ModBluntWeapon"),		0x1049, VSV|VVAR ,	VN, VF, VN, VN, VN, VN, VN, VN, VN, VN, VN, VN, VN,	 },
	{ _T("ModCastPenalty"),		0x117b, VSV|VVAR ,	VN, VF, VN, VN, VN, VN, VN, VN, VN, VN, VN, VN, VN,	 },
	{ _T("ModChameleon"),		0x10c5, VSV|VVAR ,	VN, VF, VN, VN, VN, VN, VN, VN, VN, VN, VN, VN, VN,	 },
	{ _T("ModConjuration"),		0x1064, VSV|VVAR ,	VN, VF, VN, VN, VN, VN, VN, VN, VN, VN, VN, VN, VN,	 },
	{ _T("ModCurrentFatigue"),	0x1134, VSV|VVAR ,	VN, VF, VN, VN, VN, VN, VN, VN, VN, VN, VN, VN, VN,	 },
	{ _T("ModCurrentHealth"),	0x1132, VSV|VVAR ,	VN, VF, VN, VN, VN, VN, VN, VN, VN, VN, VN, VN, VN,	 },
	{ _T("ModCurrentMagicka"),	0x1133, VSV|VVAR ,	VN, VF, VN, VN, VN, VN, VN, VN, VN, VN, VN, VN, VN,	 },
	{ _T("ModDefendBonus"),		0x10a7, VSV|VVAR ,	VN, VF, VN, VN, VN, VN, VN, VN, VN, VN, VN, VN, VN,	 },
	{ _T("ModDestruction"),		0x105b, VSV|VVAR ,	VN, VF, VN, VN, VN, VN, VN, VN, VN, VN, VN, VN, VN,	 },
	{ _T("ModDisposition"),		0x109a, VSV|VVAR ,	VN, VF, VN, VN, VN, VN, VN, VN, VN, VN, VN, VN, VN,	 },
	{ _T("ModEnchant"),		0x1058, VSV|VVAR ,	VN, VF, VN, VN, VN, VN, VN, VN, VN, VN, VN, VN, VN,	 },
	{ _T("ModEndurance"),		0x1034, VSV|VVAR ,	VN, VF, VN, VN, VN, VN, VN, VN, VN, VN, VN, VN, VN,	 },
	{ _T("ModFactionReaction"),	0x1111, 0,	VN, VID|VFAC, VID|VFAC, VS, VN, VN, VN, VN, VN, VN, VN, VN, VN,	 },
	{ _T("ModFatigue"),		0x1094, VSV|VVAR ,	VN, VF, VN, VN, VN, VN, VN, VN, VN, VN, VN, VN, VN,	 },
	{ _T("ModFight"),		0x1101, VSV|VVAR ,	VN, VF, VN, VN, VN, VN, VN, VN, VN, VN, VN, VN, VN,	 },
	{ _T("ModFlee"),		0x1104, VSV|VVAR ,	VN, VF, VN, VN, VN, VN, VN, VN, VN, VN, VN, VN, VN,	 },
	{ _T("ModFlying"),		0x1175, VSV|VVAR ,	VN, VF, VN, VN, VN, VN, VN, VN, VN, VN, VN, VN, VN,	 },
	{ _T("ModHandToHand"),		0x108b, VSV|VVAR ,	VN, VF, VN, VN, VN, VN, VN, VN, VN, VN, VN, VN, VN,	 },
	{ _T("ModHealth"),		0x108e, VSV|VVAR ,	VN, VF, VN, VN, VN, VN, VN, VN, VN, VN, VN, VN, VN,	 },
	{ _T("ModHeavyArmor"),		0x1046, VSV|VVAR ,	VN, VF, VN, VN, VN, VN, VN, VN, VN, VN, VN, VN, VN,	 },
	{ _T("ModHello"),		0x110a, VSV|VVAR ,	VN, VF, VN, VN, VN, VN, VN, VN, VN, VN, VN, VN, VN,	 },
	{ _T("ModIllusion"),		0x1061, VSV|VVAR ,	VN, VF, VN, VN, VN, VN, VN, VN, VN, VN, VN, VN, VN,	 },
	{ _T("ModIntelligence"),	0x1028, VSV|VVAR ,	VN, VF, VN, VN, VN, VN, VN, VN, VN, VN, VN, VN, VN,	 },
	{ _T("ModInvisible"),		0x1187, VSV|VVAR ,	VN, VF, VN, VN, VN, VN, VN, VN, VN, VN, VN, VN, VN,	 },
	{ _T("ModLightArmor"),		0x107c, VSV|VVAR ,	VN, VF, VN, VN, VN, VN, VN, VN, VN, VN, VN, VN, VN,	 },
	{ _T("ModLongBlade"),		0x104c, VSV|VVAR ,	VN, VF, VN, VN, VN, VN, VN, VN, VN, VN, VN, VN, VN,	 },
	{ _T("ModLuck"),		0x103a, VSV|VVAR ,	VN, VF, VN, VN, VN, VN, VN, VN, VN, VN, VN, VN, VN,	 },
	{ _T("ModMagicka"),		0x1091, VSV|VVAR ,	VN, VF, VN, VN, VN, VN, VN, VN, VN, VN, VN, VN, VN,	 },
	{ _T("ModMarksman"),		0x1082, VSV|VVAR ,	VN, VF, VN, VN, VN, VN, VN, VN, VN, VN, VN, VN, VN,	 },
	{ _T("ModMediumArmor"),		0x1043, VSV|VVAR ,	VN, VF, VN, VN, VN, VN, VN, VN, VN, VN, VN, VN, VN,	 },
	{ _T("ModMercantile"),		0x1085, VSV|VVAR ,	VN, VF, VN, VN, VN, VN, VN, VN, VN, VN, VN, VN, VN,	 },
	{ _T("ModMysticism"),		0x1067, VSV|VVAR ,	VN, VF, VN, VN, VN, VN, VN, VN, VN, VN, VN, VN, VN,	 },
	{ _T("ModParalysis"),		0x1184, VSV|VVAR ,	VN, VF, VN, VN, VN, VN, VN, VN, VN, VN, VN, VN, VN,	 },
	{ _T("ModPCCrimeLevel"),	0x109d, VSV|VVAR ,	VN, VF, VN, VN, VN, VN, VN, VN, VN, VN, VN, VN, VN,	 },
	{ _T("ModPCFacRep"),		0x10d9, 0,	VN, VF, VID|VFAC|VOPT, VN, VN, VN, VN, VN, VN, VN, VN, VN, VN,	 },
	{ _T("ModPCVisionBonus"),	0x11b2, VSV|VVAR ,	VN, VF, VN, VN, VN, VN, VN, VN, VN, VN, VN, VN, VN,	 },
	{ _T("ModPersonality"),		0x1037, VSV|VVAR ,	VN, VF, VN, VN, VN, VN, VN, VN, VN, VN, VN, VN, VN,	 },
	{ _T("ModRegion"),		0x1125, 0,	VN, VID|VREG, VB, VB, VB, VB, VB, VB, VB, VB, VB, VB, VN,	 },
	{ _T("ModReputation"),		0x1097, VSV|VVAR ,	VN, VF, VN, VN, VN, VN, VN, VN, VN, VN, VN, VN, VN,	 },
	{ _T("ModResistBlight"),	0x10b9, VSV|VVAR ,	VN, VF, VN, VN, VN, VN, VN, VN, VN, VN, VN, VN, VN,	 },
	{ _T("ModResistCorprus"),	0x10bc, VSV|VVAR ,	VN, VF, VN, VN, VN, VN, VN, VN, VN, VN, VN, VN, VN,	 },
	{ _T("ModResistDisease"),	0x10b6, VSV|VVAR ,	VN, VF, VN, VN, VN, VN, VN, VN, VN, VN, VN, VN, VN,	 },
	{ _T("ModResistFire"),		0x10ad, VSV|VVAR ,	VN, VF, VN, VN, VN, VN, VN, VN, VN, VN, VN, VN, VN,	 },
	{ _T("ModResistFrost"),		0x10b0, VSV|VVAR ,	VN, VF, VN, VN, VN, VN, VN, VN, VN, VN, VN, VN, VN,	 },
	{ _T("ModResistMagicka"),	0x10aa, VSV|VVAR ,	VN, VF, VN, VN, VN, VN, VN, VN, VN, VN, VN, VN, VN,	 },
	{ _T("ModResistNormalWeapons"),	0x10c8, VSV|VVAR ,	VN, VF, VN, VN, VN, VN, VN, VN, VN, VN, VN, VN, VN,	 },
	{ _T("ModResistParalysis"),	0x10c2, VSV|VVAR ,	VN, VF, VN, VN, VN, VN, VN, VN, VN, VN, VN, VN, VN,	 },
	{ _T("ModResistPoison"),	0x10bf, VSV|VVAR ,	VN, VF, VN, VN, VN, VN, VN, VN, VN, VN, VN, VN, VN,	 },
	{ _T("ModResistShock"),		0x10b3, VSV|VVAR ,	VN, VF, VN, VN, VN, VN, VN, VN, VN, VN, VN, VN, VN,	 },
	{ _T("ModRestoration"),		0x106a, VSV|VVAR ,	VN, VF, VN, VN, VN, VN, VN, VN, VN, VN, VN, VN, VN,	 },
	{ _T("ModScale"),		0x118f,	VSV|VVAR ,	VN, VF, VN, VN, VN, VN, VN, VN, VN, VN, VN, VN, VN,	 },
	{ _T("ModSecurity"),		0x1073, VSV|VVAR ,	VN, VF, VN, VN, VN, VN, VN, VN, VN, VN, VN, VN, VN,	 },
	{ _T("ModShortBlade"),		0x107f, VSV|VVAR ,	VN, VF, VN, VN, VN, VN, VN, VN, VN, VN, VN, VN, VN,	 },
	{ _T("ModSilence"),		0x117e, VSV|VVAR ,	VN, VF, VN, VN, VN, VN, VN, VN, VN, VN, VN, VN, VN,	 },
	{ _T("ModSneak"),		0x1076, VSV|VVAR ,	VN, VF, VN, VN, VN, VN, VN, VN, VN, VN, VN, VN, VN,	 },
	{ _T("ModSpear"),		0x1052, VSV|VVAR ,	VN, VF, VN, VN, VN, VN, VN, VN, VN, VN, VN, VN, VN,	 },
	{ _T("ModSpeechcraft"),		0x1088, VSV|VVAR ,	VN, VF, VN, VN, VN, VN, VN, VN, VN, VN, VN, VN, VN,	 },
	{ _T("ModSpeed"),		0x1031, VSV|VVAR ,	VN, VF, VN, VN, VN, VN, VN, VN, VN, VN, VN, VN, VN,	 },
	{ _T("ModStrength"),		0x1025, VSV|VVAR ,	VN, VF, VN, VN, VN, VN, VN, VN, VN, VN, VN, VN, VN,	 },
	{ _T("ModSuperJump"),		0x1172, VSV|VVAR ,	VN, VF, VN, VN, VN, VN, VN, VN, VN, VN, VN, VN, VN,	 },
	{ _T("ModSwimSpeed"),		0x116f, VSV|VVAR ,	VN, VF, VN, VN, VN, VN, VN, VN, VN, VN, VN, VN, VN,	 },
	{ _T("ModUnarmored"),		0x1070, VSV|VVAR ,	VN, VF, VN, VN, VN, VN, VN, VN, VN, VN, VN, VN, VN,	 },
	{ _T("ModWaterBreathing"),	0x1169, VSV|VVAR ,	VN, VF, VN, VN, VN, VN, VN, VN, VN, VN, VN, VN, VN,	 },
	{ _T("ModWaterLevel"),		0x1192, VTRB|VSV|VVAR ,	VN, VF, VN, VN, VN, VN, VN, VN, VN, VN, VN, VN, VN,	 },
	{ _T("ModWaterWalking"),	0x116c, VSV|VVAR ,	VN, VF, VN, VN, VN, VN, VN, VN, VN, VN, VN, VN, VN,	 },
	{ _T("ModWillpower"),		0x102b, VSV|VVAR ,	VN, VF, VN, VN, VN, VN, VN, VN, VN, VN, VN, VN, VN,	 },
	{ _T("Move"),			0x1006, 0,	VN, VX, VF, VN, VN, VN, VN, VN, VN, VN, VN, VN, VN,		 },
	{ _T("MoveWorld"),		0x1008, 0,	VN, VX, VF, VN, VN, VN, VN, VN, VN, VN, VN, VN, VN,		 },
/*309*/	{ _T("OnActivate"),		0x1018, 0,	VS, VN, VN, VN, VN, VN, VN, VN, VN, VN, VN, VN, VN,		 },
	{ _T("OnDeath"),		0x10f0, 0,	VS, VN, VN, VN, VN, VN, VN, VN, VN, VN, VN, VN, VN,		 },
	{ _T("OnKnockout"),		0x10f1, 0,	VS, VN, VN, VN, VN, VN, VN, VN, VN, VN, VN, VN, VN,		 },
	{ _T("OnMurder"),		0x10f2, 0,	VS, VN, VN, VN, VN, VN, VN, VN, VN, VN, VN, VN, VN,		 },
/*313*/	{ _T("PayFine"),		0x114f, 0,	VN, VN, VN, VN, VN, VN, VN, VN, VN, VN, VN, VN, VN,		 },
	{ _T("PayFineThief"),		0x1189, 0,	VN, VN, VN, VN, VN, VN, VN, VN, VN, VN, VN, VN, VN,		 },
	{ _T("PCClearExpelled"),	0x10d3, 0,	VN, VID|VOPT, VN, VN, VN, VN, VN, VN, VN, VN, VN, VN, VN,	 },
	{ _T("PCExpell"),		0x10d2, 0,	VN, VID|VOPT, VN, VN, VN, VN, VN, VN, VN, VN, VN, VN, VN,	 },
	{ _T("PCExpelled"),		0x109f, 0,	VN, VID|VOPT, VN, VN, VN, VN, VN, VN, VN, VN, VN, VN, VN,	 },
	{ _T("PCForce1stPerson"),	0x113d,	0,	VN, VN, VN, VN, VN, VN, VN, VN, VN, VN, VN, VN, VN,		 },
	{ _T("PCForce3rdPerson"),	0x113c, 0,	VN, VN, VN, VN, VN, VN, VN, VN, VN, VN, VN, VN, VN,		 },
	{ _T("PCGet3rdPerson"),		0x113e, 0,	VS, VN, VN, VN, VN, VN, VN, VN, VN, VN, VN, VN, VN,		 },
	{ _T("PCJoinFaction"),		0x113b, 0,	VN, VID|VOPT, VN, VN, VN, VN, VN, VN, VN, VN, VN, VN, VN,	 },
	{ _T("PCLowerRank"),		0x10d1, 0,	VN, VID|VOPT, VN, VN, VN, VN, VN, VN, VN, VN, VN, VN, VN,	 },
	{ _T("PCRaiseRank"),		0x10d0, 0,	VN, VID|VOPT, VN, VN, VN, VN, VN, VN, VN, VN, VN, VN, VN,	 },
	{ _T("PlaceAtMe"),		0x11BA, VSV|VBM,VN, VID, VS, VF, VS, VN, VN, VN, VN, VN, VN, VN, VN,		 },
	{ _T("PlaceAtPC"),		0x10e6, VSV,	VN, VID, VS, VF, VS, VN, VN, VN, VN, VN, VN, VN, VN,		 },
	{ _T("PlaceItem"),		0x1195, VTRB|VSV|VVAR,	VN, VID, VF, VF, VF, VF, VN, VN, VN, VN, VN, VN, VN,		 },
	{ _T("PlaceItemCell"),		0x1196, VTRB|VSV|VVAR,	VN, VID, VID|VCID, VF, VF, VF, VF, VN, VN, VN, VN, VN, VN,	 },
	{ _T("PlayBink"),		0x1155, VSV,	VN, VSTR, VB|VOPT, VN, VN, VN, VN, VN, VN, VN, VN, VN, VN,	 },
	{ _T("PlayGroup"),		0x1014, VSV,	VN, VANIM, VB|VOPT, VN, VN, VN, VN, VN, VN, VN, VN, VN, VN,	 },
	{ _T("PlayLoopSound3D"),	0x112e, VSV,	VN, VID|VSNDID, VN, VN, VN, VN, VN, VN, VN, VN, VN, VN, VN,	 },
	{ _T("PlayLoopSound3DVP"),	0x112f, VSV,	VN, VID|VSNDID, VF, VF, VN, VN, VN, VN, VN, VN, VN, VN, VN,	 },
	{ _T("PlaySound"),		0x1002, VSV,	VN, VID|VSNDID, VN, VN, VN, VN, VN, VN, VN, VN, VN, VN, VN,	 },
	{ _T("PlaySound3D"),		0x112c, VSV,	VN, VID|VSNDID, VN, VN, VN, VN, VN, VN, VN, VN, VN, VN, VN,	 },
	{ _T("PlaySound3DVP"),		0x112d, VSV,	VN, VID|VSNDID, VF, VF, VN, VN, VN, VN, VN, VN, VN, VN, VN,	 },
	{ _T("PlaySoundVP"),		0x112b, VSV,	VN, VID|VSNDID, VF, VF, VN, VN, VN, VN, VN, VN, VN, VN, VN,	 },
	{ _T("Position"),		0x1004, 0,	VN, VF, VF, VF, VF, VN, VN, VN, VN, VN, VN, VN, VN,		 },
	{ _T("PositionCell"),		0x1005, 0,	VN, VF, VF, VF, VF, VID|VCID, VN, VN, VN, VN, VN, VN, VN,	 },
/*338*/	{ _T("RaiseRank"),		0x10ce, 0,	VN, VN, VN, VN, VN, VN, VN, VN, VN, VN, VN, VN, VN,		 },
	{ _T("Random"),			0x1021, 0,	VS, VS, VN, VN, VN, VN, VN, VN, VN, VN, VN, VN, VN,		 },
	{ _T("RemoveEffects"),		0x1122, 0,	VN, VEFF, VN, VN, VN, VN, VN, VN, VN, VN, VN, VN, VN,		 },
	{ _T("RemoveFromLevCreature"),	0x11a7, VTRB,	VN, VID|VLCID, VID|VCRID|VNPID, VF, VN, VN, VN, VN, VN, VN, VN, VN, VN,	 },
	{ _T("RemoveFromLevItem"),	0x11a9, VTRB,	VN, VID|VLIID, VID|VITMID, VF, VN, VN, VN, VN, VN, VN, VN, VN, VN,	 },
	{ _T("RemoveItem"),		0x10d5, 0,	VN, VID|VITMID, VS, VN, VN, VN, VN, VN, VN, VN, VN, VN, VN,	 },
	{ _T("RemoveSoulGem"),		0x10ec, 0,	VN, VID|VCRID, VN, VN, VN, VN, VN, VN, VN, VN, VN, VN, VN,	 },
	{ _T("RemoveSpell"),		0x111e, 0,	VN, VID|VSPID, VN, VN, VN, VN, VN, VN, VN, VN, VN, VN, VN,	 },
	{ _T("RemoveSpellEffects"),	0x1120, 0,	VN, VID|VSPID, VN, VN, VN, VN, VN, VN, VN, VN, VN, VN, VN,	 },
	{ _T("RepairedOnMe"),		0x110f, 0,	VN, VID|VITMID, VN, VN, VN, VN, VN, VN, VN, VN, VN, VN, VN,	 },
	{ _T("Resurrect"),		0x10e7, 0,	VN, VN, VN, VN, VN, VN, VN, VN, VN, VN, VN, VN, VN,		 },
	{ _T("Rotate"),			0x1007, 0,	VN, VX, VF, VN, VN, VN, VN, VN, VN, VN, VN, VN, VN,		 },
	{ _T("RotateWorld"),		0x1009, 0,	VN, VX, VF, VN, VN, VN, VN, VN, VN, VN, VN, VN, VN,		 },
/*351*/	{ _T("SameFaction"),		0x109e, 0,	VS, VN, VN, VN, VN, VN, VN, VN, VN, VN, VN, VN, VN,		 },
	{ _T("Say"),			0x111b, 0,	VN, VSTR|VSST, VSTR, VN, VN, VN, VN, VN, VN, VN, VN, VN, VN,	 },
	{ _T("SayDone"),		0x111c, 0,	VS, VN, VN, VN, VN, VN, VN, VN, VN, VN, VN, VN, VN,		 },
	{ _T("ScriptRunning"),		0x101d, 0,	VS, VID|VSCTID, VN, VN, VN, VN, VN, VN, VN, VN, VN, VN, VN,	 },
	{ _T("SetAcrobatics"),		0x1078, VVAR|VSV,	VN, VF, VN, VN, VN, VN, VN, VN, VN, VN, VN, VN, VN,	 },
	{ _T("SetAgility"),		0x102d, VVAR|VSV,	VN, VF, VN, VN, VN, VN, VN, VN, VN, VN, VN, VN, VN,	 },
	{ _T("SetAlarm"),		0x1106, VVAR|VSV,	VN, VF, VN, VN, VN, VN, VN, VN, VN, VN, VN, VN, VN,	 },
	{ _T("SetAlchemy"),		0x106c, VVAR|VSV,	VN, VF, VN, VN, VN, VN, VN, VN, VN, VN, VN, VN, VN,	 },
	{ _T("SetAlteration"),		0x105d, VVAR|VSV,	VN, VF, VN, VN, VN, VN, VN, VN, VN, VN, VN, VN, VN,	 },
	{ _T("SetAngle"),		0x100d, VVAR|VSV,	VN, VX, VF, VN, VN, VN, VN, VN, VN, VN, VN, VN, VN,	 },
	{ _T("SetArmorBonus"),		0x1177, VVAR|VSV,	VN, VF, VN, VN, VN, VN, VN, VN, VN, VN, VN, VN, VN,	 },
	{ _T("SetArmorer"),		0x103f, VVAR|VSV,	VN, VF, VN, VN, VN, VN, VN, VN, VN, VN, VN, VN, VN,	 },
	{ _T("SetAthletics"),		0x1054, VVAR|VSV,	VN, VF, VN, VN, VN, VN, VN, VN, VN, VN, VN, VN, VN,	 },
	{ _T("SetAtStart"),		0x1010, 0,	VN, VN, VN, VN, VN, VN, VN, VN, VN, VN, VN, VN, VN,		 },
	{ _T("SetAttackBonus"),		0x10a3, VVAR|VSV,	VN, VF, VN, VN, VN, VN, VN, VN, VN, VN, VN, VN, VN,	 },
	{ _T("SetAxe"),			0x104e, VVAR|VSV,	VN, VF, VN, VN, VN, VN, VN, VN, VN, VN, VN, VN, VN,	 },
	{ _T("SetBlindness"),		0x1180, VVAR|VSV,	VN, VF, VN, VN, VN, VN, VN, VN, VN, VN, VN, VN, VN,	 },
	{ _T("SetBlock"),		0x103c, VVAR|VSV,	VN, VF, VN, VN, VN, VN, VN, VN, VN, VN, VN, VN, VN,	 },
	{ _T("SetBluntWeapon"),		0x1048, VVAR|VSV,	VN, VF, VN, VN, VN, VN, VN, VN, VN, VN, VN, VN, VN,	 },
	{ _T("SetCastPenalty"),		0x117a, VVAR|VSV,	VN, VF, VN, VN, VN, VN, VN, VN, VN, VN, VN, VN, VN,	 },
	{ _T("SetChameleon"),		0x10c4, VVAR|VSV,	VN, VF, VN, VN, VN, VN, VN, VN, VN, VN, VN, VN, VN,	 },
	{ _T("SetConjuration"),		0x1063, VVAR|VSV,	VN, VF, VN, VN, VN, VN, VN, VN, VN, VN, VN, VN, VN,	 },
	{ _T("SetDefendBonus"),		0x10a6, VVAR|VSV,	VN, VF, VN, VN, VN, VN, VN, VN, VN, VN, VN, VN, VN,	 },
	{ _T("SetDelete"),		0x11ab, VTRB,	VN, VS, VN, VN, VN, VN, VN, VN, VN, VN, VN, VN, VN,		 },
	{ _T("SetDestruction"),		0x105a, VVAR|VSV,	VN, VF, VN, VN, VN, VN, VN, VN, VN, VN, VN, VN, VN,	 },
	{ _T("SetDisposition"),		0x1099, VVAR|VSV,	VN, VF, VN, VN, VN, VN, VN, VN, VN, VN, VN, VN, VN,	 },
	{ _T("SetEnchant"),		0x1057, VVAR|VSV,	VN, VF, VN, VN, VN, VN, VN, VN, VN, VN, VN, VN, VN,	 },
	{ _T("SetEndurance"),		0x1033, VVAR|VSV,	VN, VF, VN, VN, VN, VN, VN, VN, VN, VN, VN, VN, VN,	 },
	{ _T("SetFactionReaction"),	0x1110, 0,	VN, VID|VFAC, VID|VFAC, VS, VN, VN, VN, VN, VN, VN, VN, VN, VN,	 },
	{ _T("SetFatigue"),		0x1093, VVAR|VSV,	VN, VF, VN, VN, VN, VN, VN, VN, VN, VN, VN, VN, VN,	 },
	{ _T("SetFight"),		0x1100, VVAR|VSV,	VN, VF, VN, VN, VN, VN, VN, VN, VN, VN, VN, VN, VN,	 },
	{ _T("SetFlee"),		0x1103, VVAR|VSV,	VN, VF, VN, VN, VN, VN, VN, VN, VN, VN, VN, VN, VN,	 },
	{ _T("SetFlying"),		0x1174, VVAR|VSV,	VN, VF, VN, VN, VN, VN, VN, VN, VN, VN, VN, VN, VN,	 },
	{ _T("SetHandToHand"),		0x108a, VVAR|VSV,	VN, VF, VN, VN, VN, VN, VN, VN, VN, VN, VN, VN, VN,	 },
	{ _T("SetHealth"),		0x108d, VVAR|VSV,	VN, VF, VN, VN, VN, VN, VN, VN, VN, VN, VN, VN, VN,	 },
	{ _T("SetHeavyArmor"),		0x1045, VVAR|VSV,	VN, VF, VN, VN, VN, VN, VN, VN, VN, VN, VN, VN, VN,	 },
	{ _T("SetHello"),		0x1109, VVAR|VSV,	VN, VF, VN, VN, VN, VN, VN, VN, VN, VN, VN, VN, VN,	 },
	{ _T("SetIllusion"),		0x1060, VVAR|VSV,	VN, VF, VN, VN, VN, VN, VN, VN, VN, VN, VN, VN, VN,	 },
	{ _T("SetIntelligence"),	0x1027, VVAR|VSV,	VN, VF, VN, VN, VN, VN, VN, VN, VN, VN, VN, VN, VN,	 },
	{ _T("SetInvisible"),		0x1186, VVAR|VSV,	VN, VF, VN, VN, VN, VN, VN, VN, VN, VN, VN, VN, VN,	 },
	{ _T("SetJournalIndex"),	0x11aa, VEXS,	VN, VID|VJRNID, VS, VN, VN, VN, VN, VN, VN, VN, VN, VN, VN,	 },
	{ _T("SetLevel"),		0x1156, VVAR|VSV,	VN, VS, VN, VN, VN, VN, VN, VN, VN, VN, VN, VN, VN,	 },
	{ _T("SetLightArmor"),		0x107b, VVAR|VSV,	VN, VF, VN, VN, VN, VN, VN, VN, VN, VN, VN, VN, VN,	 },
	{ _T("SetLongBlade"),		0x104b, VVAR|VSV,	VN, VF, VN, VN, VN, VN, VN, VN, VN, VN, VN, VN, VN,	 },
	{ _T("SetLuck"),		0x1039,	VVAR|VSV,	VN, VF, VN, VN, VN, VN, VN, VN, VN, VN, VN, VN, VN,	 },
	{ _T("SetMagicka"),		0x1090, VVAR|VSV,	VN, VF, VN, VN, VN, VN, VN, VN, VN, VN, VN, VN, VN,	 },
	{ _T("SetMarksman"),		0x1081, VVAR|VSV,	VN, VF, VN, VN, VN, VN, VN, VN, VN, VN, VN, VN, VN,	 },
	{ _T("SetMediumArmor"),		0x1042, VVAR|VSV,	VN, VF, VN, VN, VN, VN, VN, VN, VN, VN, VN, VN, VN,	 },
	{ _T("SetMercantile"),		0x1084, VVAR|VSV,	VN, VF, VN, VN, VN, VN, VN, VN, VN, VN, VN, VN, VN,	 },
	{ _T("SetMysticism"),		0x1066, VVAR|VSV,	VN, VF, VN, VN, VN, VN, VN, VN, VN, VN, VN, VN, VN,	 },
	{ _T("SetParalysis"),		0x1183, VVAR|VSV,	VN, VF, VN, VN, VN, VN, VN, VN, VN, VN, VN, VN, VN,	 },
	{ _T("SetPCCrimeLevel"),	0x109c, VVAR|VSV,	VN, VF, VN, VN, VN, VN, VN, VN, VN, VN, VN, VN, VN,		 },
	{ _T("SetPCFacRep"),		0x10d8, 0,	VN, VF, VID|VFAC|VOPT, VN, VN, VN, VN, VN, VN, VN, VN, VN, VN,	 },
	{ _T("SetPCVisionBonus"),	0x11b1, VVAR|VSV,	VN, VF, VN, VN, VN, VN, VN, VN, VN, VN, VN, VN, VN,	 },
	{ _T("SetPersonality"),		0x1036, VVAR|VSV,	VN, VF, VN, VN, VN, VN, VN, VN, VN, VN, VN, VN, VN,	 },
	{ _T("SetPos"),			0x100b, VVAR|VSV,	VN, VX, VF, VN, VN, VN, VN, VN, VN, VN, VN, VN, VN,	 }, /* Accepts Vars since Tribunal */
	{ _T("SetReputation"),		0x1096, VVAR|VSV,	VN, VF, VN, VN, VN, VN, VN, VN, VN, VN, VN, VN, VN,	 },
	{ _T("SetResistBlight"),	0x10b8, VVAR|VSV,	VN, VF, VN, VN, VN, VN, VN, VN, VN, VN, VN, VN, VN,	 },
	{ _T("SetResistCorprus"),	0x10bb, VVAR|VSV,	VN, VF, VN, VN, VN, VN, VN, VN, VN, VN, VN, VN, VN,	 },
	{ _T("SetResistDisease"),	0x10b5, VVAR|VSV,	VN, VF, VN, VN, VN, VN, VN, VN, VN, VN, VN, VN, VN,	 },
	{ _T("SetResistFire"),		0x10ac, VVAR|VSV,	VN, VF, VN, VN, VN, VN, VN, VN, VN, VN, VN, VN, VN,	 },
	{ _T("SetResistFrost"),		0x10af, VVAR|VSV,	VN, VF, VN, VN, VN, VN, VN, VN, VN, VN, VN, VN, VN,	 },
	{ _T("SetResistMagicka"),	0x10a9, VVAR|VSV,	VN, VF, VN, VN, VN, VN, VN, VN, VN, VN, VN, VN, VN,	 },
	{ _T("SetResistNormalWeapons"),	0x10c7, VVAR|VSV,	VN, VF, VN, VN, VN, VN, VN, VN, VN, VN, VN, VN, VN,	 },
	{ _T("SetResistParalysis"),	0x10c1, VVAR|VSV,	VN, VF, VN, VN, VN, VN, VN, VN, VN, VN, VN, VN, VN,	 },
	{ _T("SetResistPoison"),	0x10be, VVAR|VSV,	VN, VF, VN, VN, VN, VN, VN, VN, VN, VN, VN, VN, VN,	 },
	{ _T("SetResistShock"),		0x10b2, VVAR|VSV,	VN, VF, VN, VN, VN, VN, VN, VN, VN, VN, VN, VN, VN,	 },
	{ _T("SetRestoration"),		0x1069, VVAR|VSV,	VN, VF, VN, VN, VN, VN, VN, VN, VN, VN, VN, VN, VN,	 },
	{ _T("SetScale"),		0x118e, VVAR|VTRB|VSV,	VN, VF, VN, VN, VN, VN, VN, VN, VN, VN, VN, VN, VN,	 },
	{ _T("SetSecurity"),		0x1072, VVAR|VSV,	VN, VF, VN, VN, VN, VN, VN, VN, VN, VN, VN, VN, VN,	 },
	{ _T("SetShortBlade"),		0x107e, VVAR|VSV,	VN, VF, VN, VN, VN, VN, VN, VN, VN, VN, VN, VN, VN,	 },
	{ _T("SetSilence"),		0x117d, VVAR|VSV,	VN, VF, VN, VN, VN, VN, VN, VN, VN, VN, VN, VN, VN,	 },
	{ _T("SetSneak"),		0x1075, VVAR|VSV,	VN, VF, VN, VN, VN, VN, VN, VN, VN, VN, VN, VN, VN,	 },
	{ _T("SetSpear"),		0x1051, VVAR|VSV,	VN, VF, VN, VN, VN, VN, VN, VN, VN, VN, VN, VN, VN,	 },
	{ _T("SetSpeechcraft"),		0x1087, VVAR|VSV,	VN, VF, VN, VN, VN, VN, VN, VN, VN, VN, VN, VN, VN,	 },
	{ _T("SetSpeed"),		0x1030, VVAR|VSV,	VN, VF, VN, VN, VN, VN, VN, VN, VN, VN, VN, VN, VN,	 },
	{ _T("SetStrength"),		0x1024, VVAR|VSV,	VN, VF, VN, VN, VN, VN, VN, VN, VN, VN, VN, VN, VN,	 },
	{ _T("SetSuperJump"),		0x1171, VVAR|VSV,	VN, VF, VN, VN, VN, VN, VN, VN, VN, VN, VN, VN, VN,	 },
	{ _T("SetSwimSpeed"),		0x116e, VVAR|VSV,	VN, VF, VN, VN, VN, VN, VN, VN, VN, VN, VN, VN, VN,	 },
	{ _T("SetUnarmored"),		0x106f, VVAR|VSV,	VN, VF, VN, VN, VN, VN, VN, VN, VN, VN, VN, VN, VN,	 },
	{ _T("SetWaterBreathing"),	0x1168, VVAR|VSV,	VN, VF, VN, VN, VN, VN, VN, VN, VN, VN, VN, VN, VN,	 },
	{ _T("SetWaterLevel"),		0x1191, VVAR|VTRB|VSV,	VN, VF, VN, VN, VN, VN, VN, VN, VN, VN, VN, VN, VN,	 },
	{ _T("SetWaterWalking"),	0x116b, VVAR|VSV,	VN, VF, VN, VN, VN, VN, VN, VN, VN, VN, VN, VN, VN,	 },
	{ _T("SetWereWolfAcrobatics"),	0x11B9, VBM,		VN, VN, VN, VN, VN, VN, VN, VN, VN, VN, VN, VN, VN,	 },
	{ _T("SetWillpower"),		0x102a, VVAR|VSV,	VN, VF, VN, VN, VN, VN, VN, VN, VN, VN, VN, VN, VN,	 },
	{ _T("Show"),			0x010d, VBAD|VSV,	VN, VN, VN, VN, VN, VN, VN, VN, VN, VN, VN, VN, VN,	 },
	{ _T("ShowMap"),		0x1152, 0,	VN, VID|VCID|VCSTR, VN, VN, VN, VN, VN, VN, VN, VN, VN, VN, VN,	},
	{ _T("ShowRestMenu"),		0x10e5, 0,	VN, VN, VN, VN, VN, VN, VN, VN, VN, VN, VN, VN, VN,		 },
	{ _T("SkipAnim"),		0x1016, 0,	VN, VN, VN, VN, VN, VN, VN, VN, VN, VN, VN, VN, VN,		 },
	{ _T("StartCombat"),		0x1019, 0,	VN, VID|VNPID|VCRID, VN, VN, VN, VN, VN, VN, VN, VN, VN, VN, VN, },
	{ _T("StartScript"),		0x101b, 0,	VN, VID|VSCTID, VN, VN, VN, VN, VN, VN, VN, VN, VN, VN, VN,	 },
	{ _T("StopCombat"),		0x101a, 0,	VN, VN, VN, VN, VN, VN, VN, VN, VN, VN, VN, VN, VN,		 },
	{ _T("StopScript"),		0x101c, 0,	VN, VID|VSCTID, VN, VN, VN, VN, VN, VN, VN, VN, VN, VN, VN,	 },
	{ _T("StopSound"),		0x1151, 0,	VN, VID|VSNDID, VN, VN, VN, VN, VN, VN, VN, VN, VN, VN, VN,	 },
	{ _T("StreamMusic"),		0x1003, 0,	VN, VSTR|VSST, VN, VN, VN, VN, VN, VN, VN, VN, VN, VN, VN,	 },
/*446*/	{ _T("TA"),			0x113, 0,	VN, VN, VN, VN, VN, VN, VN, VN, VN, VN, VN, VN, VN,		 },
	{ _T("TCL"),			0x118, 0,	VN, VN, VN, VN, VN, VN, VN, VN, VN, VN, VN, VN, VN,		 },
	{ _T("TFOW"),			0x13a, 0,	VN, VN, VN, VN, VN, VN, VN, VN, VN, VN, VN, VN, VN,		 },
	{ _T("TGM"),			0x112, 0,	VN, VN, VN, VN, VN, VN, VN, VN, VN, VN, VN, VN, VN,		 },
	{ _T("TM"),			0x11e, 0,	VN, VN, VN, VN, VN, VN, VN, VN, VN, VN, VN, VN, VN,		 },
	{ _T("ToggleAI"),		0x113, 0,	VN, VN, VN, VN, VN, VN, VN, VN, VN, VN, VN, VN, VN,		 },
	{ _T("ToggleCollision"),	0x118, 0,	VN, VN, VN, VN, VN, VN, VN, VN, VN, VN, VN, VN, VN,		 },
	{ _T("ToggleFogOfWar"),		0x13a, 0,	VN, VN, VN, VN, VN, VN, VN, VN, VN, VN, VN, VN, VN,		 },
	{ _T("ToggleGodMode"),		0x112, 0,	VN, VN, VN, VN, VN, VN, VN, VN, VN, VN, VN, VN, VN,		 },
	{ _T("ToggleMenus"),		0x11e, 0,	VN, VN, VN, VN, VN, VN, VN, VN, VN, VN, VN, VN, VN,		 },
	{ _T("ToggleSky"),		0x115, 0,	VN, VN, VN, VN, VN, VN, VN, VN, VN, VN, VN, VN, VN,		 },
	{ _T("ToggleVanityMode"),	0x128, 0,	VN, VN, VN, VN, VN, VN, VN, VN, VN, VN, VN, VN, VN,		 },
	{ _T("ToggleWorld"),		0x116, 0,	VN, VN, VN, VN, VN, VN, VN, VN, VN, VN, VN, VN, VN,		 },
	{ _T("TS"),			0x115, 0,	VN, VN, VN, VN, VN, VN, VN, VN, VN, VN, VN, VN, VN,		 },
	{ _T("TurnMoonRed"),		0x11B7, VBM,	VN, VN, VN, VN, VN, VN, VN, VN, VN, VN, VN, VN, VN,		 },
	{ _T("TurnMoonWhite"),		0x11B8, VBM,	VN, VN, VN, VN, VN, VN, VN, VN, VN, VN, VN, VN, VN,		 },
	{ _T("TVM"),			0x128, 0,	VN, VN, VN, VN, VN, VN, VN, VN, VN, VN, VN, VN, VN,		 },
	{ _T("TW"),			0x116, 0,	VN, VN, VN, VN, VN, VN, VN, VN, VN, VN, VN, VN, VN,		 },
/*464*/	{ _T("UndoWerewolf"),		0x11B4, VBM,	VN, VN, VN, VN, VN, VN, VN, VN, VN, VN, VN, VN, VN,		 },
	{ _T("Unlock"),			0x1137, 0,	VN, VN, VN, VN, VN, VN, VN, VN, VN, VN, VN, VN, VN,		 },
/*466*/	{ _T("WakeUpPC"),		0x10e1, 0,	VN, VN, VN, VN, VN, VN, VN, VN, VN, VN, VN, VN, VN,		 },
/*467*/	{ _T("XBox"),			0x113a, 0,	VS, VN, VN, VN, VN, VN, VN, VN, VN, VN, VN, VN, VN,		},
	{ NULL }
 };

 	//{ _T("OnPCAdd"),		0,	VS, VN, VN, VN, VN, VN, VN, VN, VN, VN, VN, VN, VN },
	//{ _T("OnPCDrop"),		0,	VS, VN, VN, VN, VN, VN, VN, VN, VN, VN, VN, VN, VN },
	//{ _T("OnPCEquip"),		0,	VS, VN, VN, VN, VN, VN, VN, VN, VN, VN, VN, VN, VN },
	//{ _T("OnPCSoulGemUse"),		0,	VS, VN, VN, VN, VN, VN, VN, VN, VN, VN, VN, VN, VN },
	//{ _T("OnRepair"),		0,	VS, VN, VN, VN, VN, VN, VN, VN, VN, VN, VN, VN, VN },
	//{ _T("OnPCHitMe"),		0,	VS, VN, VN, VN, VN, VN, VN, VN, VN, VN, VN, VN, VN },
	//{ _T("PCSkipEquip"),		0,	VN, VN, VN, VN, VN, VN, VN, VN, VN, VN, VN, VN, VN },

esmscrfuncinfo_t* g_ScriptFuncAlpha[26] = {
	&g_ScriptFunctions[0],		/* A */
	&g_ScriptFunctions[14],		/* B */
	&g_ScriptFunctions[15],		/* C */
	&g_ScriptFunctions[29],		/* D */
	&g_ScriptFunctions[42],		/* E */
	&g_ScriptFunctions[65],		/* F */
	&g_ScriptFunctions[77],		/* G */
	&g_ScriptFunctions[216],	/* H */
	&g_ScriptFunctions[222],	/* I */
	&g_ScriptFunctions[223],	/* J */
	NULL,				/* K */
	&g_ScriptFunctions[224],	/* L */
	&g_ScriptFunctions[227],	/* M */
	NULL,				/* N */
	&g_ScriptFunctions[309],	/* O */
	&g_ScriptFunctions[312],	/* P */
	NULL,				/* Q */
	&g_ScriptFunctions[338],	/* R */
	&g_ScriptFunctions[351],	/* S */
	&g_ScriptFunctions[446],	/* T */
	&g_ScriptFunctions[464],	/* U */
	NULL,				/* V */
	&g_ScriptFunctions[466],	/* W */
	&g_ScriptFunctions[467],	/* X */
	NULL,				/* Y */
	NULL,				/* Z */
 };


/*===========================================================================
 *
 * Function - bool OutputFunction (File, FuncInfo);
 *
 *=========================================================================*/
bool OutputFunction (CGenFile& File, esmscrfuncinfo_t& FuncInfo) {
  int Index;

  File.Printf(_T("Function = %s\n"), FuncInfo.Name);
  File.Printf(_T("\tOptions = 0x%X\n"), FuncInfo.Flags);
  File.Printf(_T("\tOpcode = 0x%X\n"), FuncInfo.OpCode);
  File.Printf(_T("\tReturn = 0x%X, \"\"\n"), FuncInfo.Return);
  
  for (Index = 0; Index < MWESM_SCRIPT_MAXARGS; Index++) {
    if (FuncInfo.Var[Index] == 0) break;
    File.Printf(_T("\tParam%d = 0x%X, \"\"\n"), Index+1, FuncInfo.Var[Index]);
   }

  File.Printf(_T("\tDesc = \"\"\n"));
  File.Printf(_T("End\n"));
  return (true); 
 }
/*===========================================================================
 *		End of Function OutputFunction()
 *=========================================================================*/


/*===========================================================================
 *
 * Function - bool OutputFunctionDat (pFilename);
 *
 * Outputs a function text data file using the current information in 
 * the function array to the given file. Returns false on any error.
 *
 *=========================================================================*/
bool OutputFunctionDat (const TCHAR* pFilename) {
  CGenFile File;
  bool	   Result;
  int      Index;

	/* Attempt to open the file for output */
  Result = File.Open(pFilename, _T("wt"));
  if (!Result) return (false);

	/* Output all functions in array */
  for (Index = 0; g_ScriptFunctions[Index].Name[0] != NULL_CHAR; Index++) {
    Result = OutputFunction(File, g_ScriptFunctions[Index]);
    if (!Result) return (false);
   }

  return (true);
 }
/*===========================================================================
 *		End of Function OutputFunctionDat()
 *=========================================================================*/

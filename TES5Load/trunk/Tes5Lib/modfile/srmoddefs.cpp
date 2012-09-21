/*===========================================================================
 *
 * File:		Srmoddefs.CPP
 * Author:		Dave Humphrey (dave@uesp.net)
 * Created On:	26 November 2011
 *
 * Description
 *
 *=========================================================================*/

	/* Include Files */
#include "srmoddefs.h"
#include "ctype.h"
#include "subrecords/srepfdsubrecord.h"


/*===========================================================================
 *
 * Begin Global Constants
 *
 *=========================================================================*/
const srrgba_t SR_COLOR_NULL = { 0, 0, 0, 0 };
/*===========================================================================
 *		End of Global Constants
 *=========================================================================*/


/*===========================================================================
 *
 * Begin Constant String Tables
 *
 *=========================================================================*/
BEGIN_STRINGVALUE(s_SrMagicSchools)
	ADD_STRINGVALUE( SR_MAGIC_SCHOOL_ALTERATION,	"Alteration")
	ADD_STRINGVALUE( SR_MAGIC_SCHOOL_CONJURATION,	"Conjuration")
	ADD_STRINGVALUE( SR_MAGIC_SCHOOL_DESTRUCTION,	"Destruction")
	ADD_STRINGVALUE( SR_MAGIC_SCHOOL_ILLUSION,		"Illusion")
	ADD_STRINGVALUE( SR_MAGIC_SCHOOL_RESTORATION,	"Restoration")
	ADD_STRINGVALUE( SR_MAGIC_SCHOOL_NONE,			"None")
END_STRINGVALUE()

	/* Note: Same as AV but assumed to be limited in scope */
BEGIN_STRINGVALUE(s_SrMagicResistTypes)
	ADD_STRINGVALUE( SR_MAGIC_TYPE_EXTRADMG,	"Damage")
	ADD_STRINGVALUE( SR_MAGIC_TYPE_POISON,		"Poison")
	ADD_STRINGVALUE( SR_MAGIC_TYPE_FIRE,		"Fire")
	ADD_STRINGVALUE( SR_MAGIC_TYPE_SHOCK,		"Shock")
	ADD_STRINGVALUE( SR_MAGIC_TYPE_FROST,		"Frost")
	ADD_STRINGVALUE( SR_MAGIC_TYPE_DRAIN,		"Drain")
	ADD_STRINGVALUE( SR_MAGIC_TYPE_NONE,		"None")
END_STRINGVALUE()


BEGIN_STRINGVALUE(s_SrMagicDeliveryTypes)
	ADD_STRINGVALUE( SR_MAGIC_DELIVERY_SELF,			"Self")
	ADD_STRINGVALUE( SR_MAGIC_DELIVERY_TOUCH,			"Touch")
	ADD_STRINGVALUE( SR_MAGIC_DELIVERY_AIMED,			"Aimed")
	ADD_STRINGVALUE( SR_MAGIC_DELIVERY_TARGETACTOR,		"Target Actor")
	ADD_STRINGVALUE( SR_MAGIC_DELIVERY_TARGETLOCATION,	"Target Location")
END_STRINGVALUE()


BEGIN_STRINGVALUE(s_SrConditionOperators)
	ADD_STRINGVALUE( SR_CONDOP_EQUAL,			"==")
	ADD_STRINGVALUE( SR_CONDOP_NOTEQUAL,		"!=")
	ADD_STRINGVALUE( SR_CONDOP_GREATER,			">")
	ADD_STRINGVALUE( SR_CONDOP_GREATEREQUAL,	">=")
	ADD_STRINGVALUE( SR_CONDOP_LESS,			"<")
	ADD_STRINGVALUE( SR_CONDOP_LESSEQUAL,		"<=")
END_STRINGVALUE()


BEGIN_STRINGVALUE(s_SrSpellTypes)
	ADD_STRINGVALUE( SR_SPELL_TYPE_SPELL,		"Spell")
	ADD_STRINGVALUE( SR_SPELL_TYPE_DISEASE,		"Disease")
	ADD_STRINGVALUE( SR_SPELL_TYPE_POWER,		"Power")
	ADD_STRINGVALUE( SR_SPELL_TYPE_LESSERPOWER,	"Lesser Power")
	ADD_STRINGVALUE( SR_SPELL_TYPE_ABILITY,		"Ability")
	ADD_STRINGVALUE( SR_SPELL_TYPE_POISON,		"Poison")
	ADD_STRINGVALUE( SR_SPELL_TYPE_VOICE,		"Voice")
END_STRINGVALUE()


BEGIN_STRINGVALUE(s_SrBodyParts)
	ADD_STRINGVALUE( SR_BODYPARTS_SKIN				,	"Skin")
	ADD_STRINGVALUE( SR_BODYPARTS_HEAD				,	"Head")
	ADD_STRINGVALUE( SR_BODYPARTS_CHEST				,	"Chest")
	ADD_STRINGVALUE( SR_BODYPARTS_HANDS				,	"Hand")
	ADD_STRINGVALUE( SR_BODYPARTS_BEARD				,	"Beard")
	ADD_STRINGVALUE( SR_BODYPARTS_AMULET			,	"Amulet")
	ADD_STRINGVALUE( SR_BODYPARTS_RING				,	"Ring")
	ADD_STRINGVALUE( SR_BODYPARTS_FEET				,	"Feet")
	ADD_STRINGVALUE( SR_BODYPARTS_UNKNOWN1			,	"0x00000100")
	ADD_STRINGVALUE( SR_BODYPARTS_SHIELD			,	"Shield")
	ADD_STRINGVALUE( SR_BODYPARTS_ANIMALSKIN		,	"AnimalSkin")
	ADD_STRINGVALUE( SR_BODYPARTS_UNDERSKIN			,	"UnderSkin")
	ADD_STRINGVALUE( SR_BODYPARTS_CROWN				,	"Crown")
	ADD_STRINGVALUE( SR_BODYPARTS_FACE				,	"Face")
	ADD_STRINGVALUE( SR_BODYPARTS_DRAGONHEAD		,	"DragonHead")
	ADD_STRINGVALUE( SR_BODYPARTS_DRAGONLWING		,	"DragonLeftWing")
	ADD_STRINGVALUE( SR_BODYPARTS_DRAGONRWING		,	"DragonRightWing")
	ADD_STRINGVALUE( SR_BODYPARTS_DRAGONBODY		,	"DragonBody")
	ADD_STRINGVALUE( SR_BODYPARTS_UNKNOWN3			,	"0x00100000")
	ADD_STRINGVALUE( SR_BODYPARTS_UNKNOWN4			,	"0x00200000")
	ADD_STRINGVALUE( SR_BODYPARTS_UNKNOWN2			,	"0x80000000")
END_STRINGVALUE()


BEGIN_STRINGVALUE(s_SrArmorTypes)
	ADD_STRINGVALUE( SR_ARMORTYPE_NONE,		"None")
	ADD_STRINGVALUE( SR_ARMORTYPE_LIGHT,	"Light")
	ADD_STRINGVALUE( SR_ARMORTYPE_HEAVY,	"Heavy")
END_STRINGVALUE()


BEGIN_STRINGVALUE(s_SrSkillTypes)
	ADD_STRINGVALUE(SR_SKILL_ONEHAND 	 ,		"OneHand")
	ADD_STRINGVALUE(SR_SKILL_TWOHAND 	 ,		"TwoHand")
	ADD_STRINGVALUE(SR_SKILL_MARKSMAN 	 ,		"Marksman")
	ADD_STRINGVALUE(SR_SKILL_BLOCK 		 ,		"Block")
	ADD_STRINGVALUE(SR_SKILL_SMITHING 	 ,		"Smithing")
	ADD_STRINGVALUE(SR_SKILL_HEAVYARMOR  ,		"HeavyArmor")
	ADD_STRINGVALUE(SR_SKILL_LIGHTARMOR  ,		"LightArmor")
	ADD_STRINGVALUE(SR_SKILL_PICKPOCKET  ,		"Pickpocket")
	ADD_STRINGVALUE(SR_SKILL_LOCKPICKING ,		"Lockpicking")
	ADD_STRINGVALUE(SR_SKILL_SNEAK 		 ,		"Sneak")
	ADD_STRINGVALUE(SR_SKILL_ALCHEMY 	 ,		"Alchemy")
	ADD_STRINGVALUE(SR_SKILL_SPEECHCRAFT ,		"Speechcraft")
	ADD_STRINGVALUE(SR_SKILL_ALTERATION  ,		"Alteration")
	ADD_STRINGVALUE(SR_SKILL_CONJURATION ,		"Conjuration")
	ADD_STRINGVALUE(SR_SKILL_DESTRUCTION ,		"Destruction")
	ADD_STRINGVALUE(SR_SKILL_ILLUSION 	 ,		"Illusion")
	ADD_STRINGVALUE(SR_SKILL_RESTORATION ,		"Restoration")
	ADD_STRINGVALUE(SR_SKILL_ENCHANTING  ,		"Enchanting")
END_STRINGVALUE()


BEGIN_STRINGVALUE(s_SrContainerTypes)
	ADD_STRINGVALUE( 0,	"0")
	ADD_STRINGVALUE( 1,	"1")
	ADD_STRINGVALUE( 2,	"2")
	ADD_STRINGVALUE( 3,	"3")
	ADD_STRINGVALUE( 4,	"4")
END_STRINGVALUE()


BEGIN_STRINGVALUE(s_SrLightTypes)
    ADD_STRINGVALUE( 0,							"None")
	ADD_STRINGVALUE( SR_LIGHTTYPE_FLICKER,		"Flicker")
	ADD_STRINGVALUE( SR_LIGHTTYPE_FLICKERSLOW,	"FlickerSlow")
	ADD_STRINGVALUE( SR_LIGHTTYPE_PULSE,		"Pulse")
END_STRINGVALUE()


BEGIN_STRINGVALUE(s_SrEffectCastTypes)
    ADD_STRINGVALUE( SR_EFFECT_CASTTYPE_NONE,		"None")
	ADD_STRINGVALUE( SR_EFFECT_CASTTYPE_NORMAL,		"Normal")
	ADD_STRINGVALUE( SR_EFFECT_CASTTYPE_CHANNELED,	"Channeled")
END_STRINGVALUE()	


BEGIN_STRINGVALUE(s_SrActorValues)
    ADD_STRINGVALUE( -1,  "None"  )
	ADD_STRINGVALUE( 0, "Aggression" )
	ADD_STRINGVALUE( 1, "Confidence" )
	ADD_STRINGVALUE( 2, "Energy" )
	ADD_STRINGVALUE( 3, "Morality" )
	ADD_STRINGVALUE( 4, "Mood" )
	ADD_STRINGVALUE( 5, "Assistance" )
	ADD_STRINGVALUE( 6, "OneHanded" )
	ADD_STRINGVALUE( 7, "TwoHanded" )
	ADD_STRINGVALUE( 8, "Marksman" )
	ADD_STRINGVALUE( 9, "Block" )
	ADD_STRINGVALUE( 10, "Smithing" )
	ADD_STRINGVALUE( 11, "HeavyArmor" )
	ADD_STRINGVALUE( 12, "LightArmor" )
	ADD_STRINGVALUE( 13, "Pickpocket" )
	ADD_STRINGVALUE( 14, "Lockpicking" )
	ADD_STRINGVALUE( 15, "Sneak" )
	ADD_STRINGVALUE( 16, "Alchemy" )
	ADD_STRINGVALUE( 17, "Speechcraft" )
	ADD_STRINGVALUE( 18, "Alteration" )
	ADD_STRINGVALUE( 19, "Conjuration" )
	ADD_STRINGVALUE( 20, "Destruction" )
	ADD_STRINGVALUE( 21, "Illusion" )
	ADD_STRINGVALUE( 22, "Restoration" )
	ADD_STRINGVALUE( 23, "Enchanting" )
	ADD_STRINGVALUE( 24, "Health" )
	ADD_STRINGVALUE( 25, "Magicka" )
	ADD_STRINGVALUE( 26, "Stamina" )
	ADD_STRINGVALUE( 27, "HealRate" )
	ADD_STRINGVALUE( 28, "MagickaRate" )
	ADD_STRINGVALUE( 29, "StaminaRate" )
	ADD_STRINGVALUE( 30, "SpeedMult" )
	ADD_STRINGVALUE( 31, "InventoryWeight" )
	ADD_STRINGVALUE( 32, "CarryWeight" )
	ADD_STRINGVALUE( 33, "DragonRend" )
	ADD_STRINGVALUE( 34, "MeleeDamage" )
	ADD_STRINGVALUE( 35, "UnarmedDamage" )
	ADD_STRINGVALUE( 36, "Mass" )
	ADD_STRINGVALUE( 37, "VoicePoints" )
	ADD_STRINGVALUE( 38, "VoiceRate" )
	ADD_STRINGVALUE( 39, "DamageResist" )
	ADD_STRINGVALUE( 40, "PoisonResist" )
	ADD_STRINGVALUE( 41, "FireResist" )
	ADD_STRINGVALUE( 42, "ElectricResist" )
	ADD_STRINGVALUE( 43, "FrostResist" )
	ADD_STRINGVALUE( 44, "MagicResist" )
	ADD_STRINGVALUE( 45, "DiseaseResist" )
	ADD_STRINGVALUE( 46, "46" )
	ADD_STRINGVALUE( 47, "47" )
	ADD_STRINGVALUE( 48, "48" )
	ADD_STRINGVALUE( 49, "49" )
	ADD_STRINGVALUE( 50, "50" )
	ADD_STRINGVALUE( 51, "51" )
	ADD_STRINGVALUE( 52, "52" )
	ADD_STRINGVALUE( 53, "Paralysis" )
	ADD_STRINGVALUE( 54, "Invisibility" )
	ADD_STRINGVALUE( 55, "NightEye" )
	ADD_STRINGVALUE( 56, "DetectLifeRange" )
	ADD_STRINGVALUE( 57, "WaterBreathing" )
	ADD_STRINGVALUE( 58, "WaterWalking" )
	ADD_STRINGVALUE( 59, "IgnoreCrippledLimbs" )
	ADD_STRINGVALUE( 60, "Fame" )
	ADD_STRINGVALUE( 61, "Infamy" )
	ADD_STRINGVALUE( 62, "JumpingBonus" )
	ADD_STRINGVALUE( 63, "WardPower" )
	ADD_STRINGVALUE( 64, "RightItemCharge" )
	ADD_STRINGVALUE( 65, "LeftItemCharge" )
	ADD_STRINGVALUE( 66, "EquippedItemCharge" )
	ADD_STRINGVALUE( 67, "ArmorPerks" )
	ADD_STRINGVALUE( 68, "ShieldPerks" )
	ADD_STRINGVALUE( 69, "Variable01" )
	ADD_STRINGVALUE( 70, "Variable02" )
	ADD_STRINGVALUE( 71, "Variable03" )
	ADD_STRINGVALUE( 72, "Variable04" )
	ADD_STRINGVALUE( 73, "Variable05" )
	ADD_STRINGVALUE( 74, "Variable06" )
	ADD_STRINGVALUE( 75, "Variable07" )
	ADD_STRINGVALUE( 76, "Variable08" )
	ADD_STRINGVALUE( 77, "Variable09" )
	ADD_STRINGVALUE( 78, "Variable10" )
	ADD_STRINGVALUE( 79, "FavorActive" )
	ADD_STRINGVALUE( 80, "FavorsPerDay" )
	ADD_STRINGVALUE( 81, "FavorsPerDayTimer" )
	ADD_STRINGVALUE( 82, "EquippedStaffCharge" )
	ADD_STRINGVALUE( 83, "AbsorbChance" )
	ADD_STRINGVALUE( 84, "Blindness" )
	ADD_STRINGVALUE( 85, "WeaponSpeedMult" )
	ADD_STRINGVALUE( 86, "ShoutRecoveryMult" )
	ADD_STRINGVALUE( 87, "BowStaggerBonus" )
	ADD_STRINGVALUE( 88, "Telekinesis" )
	ADD_STRINGVALUE( 89, "FavorPointsBonus" )
	ADD_STRINGVALUE( 90, "LastBribedIntimidated" )
	ADD_STRINGVALUE( 91, "LastFlattered" )
	ADD_STRINGVALUE( 92, "MovementNoiseMult" )
	ADD_STRINGVALUE( 93, "BypassVendorStolenCheck" )
	ADD_STRINGVALUE( 94, "BypassVendorKeywordCheck" )
	ADD_STRINGVALUE( 95, "WaitingForPlayer" )
	ADD_STRINGVALUE( 96, "OneHandedMod" )
	ADD_STRINGVALUE( 97, "TwoHandedMod" )
	ADD_STRINGVALUE( 98, "MarksmanMod" )
	ADD_STRINGVALUE( 99, "BlockMod" )
	ADD_STRINGVALUE( 100, "SmithingMod" )
	ADD_STRINGVALUE( 101, "HeavyArmorMod" )
	ADD_STRINGVALUE( 102, "LightArmorMod" )
	ADD_STRINGVALUE( 103, "PickPocketMod" )
	ADD_STRINGVALUE( 104, "LockpickingMod" )
	ADD_STRINGVALUE( 105, "SneakMod" )
	ADD_STRINGVALUE( 106, "AlchemyMod" )
	ADD_STRINGVALUE( 107, "SpeechcraftMod" )
	ADD_STRINGVALUE( 108, "AlterationMod" )
	ADD_STRINGVALUE( 109, "ConjurationMod" )
	ADD_STRINGVALUE( 110, "DestructionMod" )
	ADD_STRINGVALUE( 111, "IllusionMod" )
	ADD_STRINGVALUE( 112, "RestorationMod" )
	ADD_STRINGVALUE( 113, "EnchantingMod" )
	ADD_STRINGVALUE( 114, "OneHandedSkillAdvance" )
	ADD_STRINGVALUE( 115, "TwoHandedSkillAdvance" )
	ADD_STRINGVALUE( 116, "MarksmanSkillAdvance" )
	ADD_STRINGVALUE( 117, "BlockSkillAdvance" )
	ADD_STRINGVALUE( 118, "SmithingSkillAdvance" )
	ADD_STRINGVALUE( 119, "HeavyArmorSkillAdvance" )
	ADD_STRINGVALUE( 120, "LightArmorSkillAdvance" )
	ADD_STRINGVALUE( 121, "PickPocketSkillAdvance" )
	ADD_STRINGVALUE( 122, "LockpickingSkillAdvance" )
	ADD_STRINGVALUE( 123, "SneakSkillAdvance" )
	ADD_STRINGVALUE( 124, "AlchemySkillAdvance" )
	ADD_STRINGVALUE( 125, "SpeechcraftSkillAdvance" )
	ADD_STRINGVALUE( 126, "AlterationSkillAdvance" )
	ADD_STRINGVALUE( 127, "ConjurationSkillAdvance" )
	ADD_STRINGVALUE( 128, "DestructionSkillAdvance" )
	ADD_STRINGVALUE( 129, "IllusionSkillAdvance" )
	ADD_STRINGVALUE( 130, "RestorationSkillAdvance" )
	ADD_STRINGVALUE( 131, "EnchantingSkillAdvance" )
	ADD_STRINGVALUE( 132, "LeftWeaponSpeedMult" )
	ADD_STRINGVALUE( 133, "DragonSouls" )
	ADD_STRINGVALUE( 134, "CombatHealthRegenMult" )
	ADD_STRINGVALUE( 135, "OneHandedPowerMod" )
	ADD_STRINGVALUE( 136, "TwoHandedPowerMod" )
	ADD_STRINGVALUE( 137, "MarksmanPowerMod" )
	ADD_STRINGVALUE( 138, "BlockPowerMod" )
	ADD_STRINGVALUE( 139, "SmithingPowerMod" )
	ADD_STRINGVALUE( 140, "HeavyArmorPowerMod" )
	ADD_STRINGVALUE( 141, "LightArmorPowerMod" )
	ADD_STRINGVALUE( 142, "PickPocketPowerMod" )
	ADD_STRINGVALUE( 143, "LockpickingPowerMod" )
	ADD_STRINGVALUE( 144, "SneakPowerMod" )
	ADD_STRINGVALUE( 145, "AlchemyPowerMod" )
	ADD_STRINGVALUE( 146, "SpeechcraftPowerMod" )
	ADD_STRINGVALUE( 147, "AlterationPowerMod" )
	ADD_STRINGVALUE( 148, "ConjurationPowerMod" )
	ADD_STRINGVALUE( 149, "DestructionPowerMod" )
	ADD_STRINGVALUE( 150, "IllusionPowerMod" )
	ADD_STRINGVALUE( 151, "RestorationPowerMod" )
	ADD_STRINGVALUE( 152, "EnchantingPowerMod" )
	ADD_STRINGVALUE( 153, "153" )
	ADD_STRINGVALUE( 154, "AttackDamageMult" )
	ADD_STRINGVALUE( 155, "HealRateMult" )
	ADD_STRINGVALUE( 156, "MagickaRateMult" )
	ADD_STRINGVALUE( 157, "StaminaRateMult" )
	ADD_STRINGVALUE( 158, "158" )
	ADD_STRINGVALUE( 159, "159" )
	ADD_STRINGVALUE( 160, "160" )
	ADD_STRINGVALUE( 161, "161" )
	ADD_STRINGVALUE( 162, "162" )
	ADD_STRINGVALUE( 163, "ReflectDamage" )
    ADD_STRINGVALUE( 164,  "164"  )
    ADD_STRINGVALUE( 165,  "165"  )
    ADD_STRINGVALUE( 166,  "166"  )
    ADD_STRINGVALUE( 167,  "167"  )
    ADD_STRINGVALUE( 168,  "168"  )
    ADD_STRINGVALUE( 169,  "169"  )
    ADD_STRINGVALUE( 170,  "170"  )
    ADD_STRINGVALUE( 171,  "171"  )
    ADD_STRINGVALUE( 172,  "172"  )
END_STRINGVALUE()	


BEGIN_STRINGVALUE(s_SrActorSkillValues)
    ADD_STRINGVALUE( -1,  "None"  )
	ADD_STRINGVALUE( 6, "OneHanded" )
	ADD_STRINGVALUE( 7, "TwoHanded" )
	ADD_STRINGVALUE( 8, "Marksman" )
	ADD_STRINGVALUE( 9, "Block" )
	ADD_STRINGVALUE( 10, "Smithing" )
	ADD_STRINGVALUE( 11, "HeavyArmor" )
	ADD_STRINGVALUE( 12, "LightArmor" )
	ADD_STRINGVALUE( 13, "Pickpocket" )
	ADD_STRINGVALUE( 14, "Lockpicking" )
	ADD_STRINGVALUE( 15, "Sneak" )
	ADD_STRINGVALUE( 16, "Alchemy" )
	ADD_STRINGVALUE( 17, "Speechcraft" )
	ADD_STRINGVALUE( 18, "Alteration" )
	ADD_STRINGVALUE( 19, "Conjuration" )
	ADD_STRINGVALUE( 20, "Destruction" )
	ADD_STRINGVALUE( 21, "Illusion" )
	ADD_STRINGVALUE( 22, "Restoration" )
	ADD_STRINGVALUE( 23, "Enchanting" )
END_STRINGVALUE()


BEGIN_STRINGVALUE(s_SrWeaponTypes)
    ADD_STRINGVALUE( SR_WEAPON_PROJECTILE	, "Projectile")
    ADD_STRINGVALUE( SR_WEAPON_1HSWORD		, "1HSword")
    ADD_STRINGVALUE( SR_WEAPON_DAGGER		, "Dagger")
    ADD_STRINGVALUE( SR_WEAPON_1HAXE		, "1HAxe")
    ADD_STRINGVALUE( SR_WEAPON_1HBLUNT		, "1HBlunt")
    ADD_STRINGVALUE( SR_WEAPON_2HSWORD		, "2HSword")
    ADD_STRINGVALUE( SR_WEAPON_2HAXEBLUNT	, "2HAxeBlunt")
    ADD_STRINGVALUE( SR_WEAPON_BOW			, "Bow")		
    ADD_STRINGVALUE( SR_WEAPON_STAFF		, "Staff")
END_STRINGVALUE()


BEGIN_STRINGVALUE(s_SrSoulGemTypes)
    ADD_STRINGVALUE( SR_SOULGEM_EMPTY	, "Empty")
	ADD_STRINGVALUE( SR_SOULGEM_PETTY	, "Petty")
	ADD_STRINGVALUE( SR_SOULGEM_LESSER	, "Lesser")
	ADD_STRINGVALUE( SR_SOULGEM_COMMON	, "Common")
	ADD_STRINGVALUE( SR_SOULGEM_GREATER	, "Greater")
	ADD_STRINGVALUE( SR_SOULGEM_GRAND	, "Grand")
END_STRINGVALUE()


BEGIN_STRINGVALUE(s_SrPerkDataUnknown1Types)
    ADD_STRINGVALUE( 1	, "1")
	ADD_STRINGVALUE( 5	, "5")
END_STRINGVALUE()


BEGIN_STRINGVALUE(s_SrPerkDataUnknown2Types)
    ADD_STRINGVALUE( 0	, "0")
	ADD_STRINGVALUE( 1	, "1")
END_STRINGVALUE()


BEGIN_STRINGVALUE(s_SrPerkDataUnknown3Types)
    ADD_STRINGVALUE( 0	, "0")
	ADD_STRINGVALUE( 1	, "1")
END_STRINGVALUE()


BEGIN_STRINGVALUE(s_SrPrkcCustomTypes)
    ADD_STRINGVALUE( SRPERK_EFFECT_CONDOWNER,			"Owner")
	ADD_STRINGVALUE( SRPERK_EFFECT_CONDTARGET,			"Target")
	ADD_STRINGVALUE( SRPERK_EFFECT_CONDATTACKER,		"Attacker")
	ADD_STRINGVALUE( SRPERK_EFFECT_CONDATTACKERWEAPON,	"Attacker Weapon")
	ADD_STRINGVALUE( SRPERK_EFFECT_CONDSPELL,			"Spell")
	ADD_STRINGVALUE( SRPERK_EFFECT_CONDWEAPON,			"Weapon")
	ADD_STRINGVALUE( SRPERK_EFFECT_CONDITEM,			"Item")
	ADD_STRINGVALUE( SRPERK_EFFECT_CONDENCHANTMENT,		"Enchantment")
	ADD_STRINGVALUE( SRPERK_EFFECT_CONDLOCKEDREF,		"Locked Reference")
END_STRINGVALUE()


BEGIN_STRINGVALUE(s_SrEpftTypes)
    ADD_STRINGVALUE( 1, "OneFloat")
	ADD_STRINGVALUE( 2, "TwoFloats")
	ADD_STRINGVALUE( 3, "LevelList")
	ADD_STRINGVALUE( 4, "Activate")
	ADD_STRINGVALUE( 5, "Spell")
	ADD_STRINGVALUE( 6, "ZString")
	ADD_STRINGVALUE( 7, "LString")
END_STRINGVALUE()


BEGIN_STRINGVALUE(s_SrPerkEffectTypes)
    ADD_STRINGVALUE( 0x00, "Calculate Weapon Damage")
	ADD_STRINGVALUE( 0x01, "Calculate My Critical Hit Chance")
	ADD_STRINGVALUE( 0x02, "Calculate My Critical Hit Damage")
	ADD_STRINGVALUE( 0x03, "Calculate Mine Explode Chance")
	ADD_STRINGVALUE( 0x04, "Adjust Limb Damage")
	ADD_STRINGVALUE( 0x05, "Adjust Book Skill Points")
	ADD_STRINGVALUE( 0x06, "Mod Recovered Health")
	ADD_STRINGVALUE( 0x07, "Get Should Attack")
	ADD_STRINGVALUE( 0x08, "Mod Buy Prices")
	ADD_STRINGVALUE( 0x09, "Add Level List On Death")
	ADD_STRINGVALUE( 0x0A, "Get Max Carry Weight")
	ADD_STRINGVALUE( 0x0B, "Mod Addiction Chance")   
		//0x0C not used in CK
	ADD_STRINGVALUE( 0x0D, "Mod Positive Chem Duration")
	ADD_STRINGVALUE( 0x0E, "Activate")
	ADD_STRINGVALUE( 0x0F, "Ignore Running for Detection")
	ADD_STRINGVALUE( 0x10, "Ignore Broken Lock")
	ADD_STRINGVALUE( 0x11, "Mod Enemy Critical Hit Chance")
	ADD_STRINGVALUE( 0x12, "Mod Sneak Attack Multiplier")
	ADD_STRINGVALUE( 0x13, "Mod Max Placeable Mines")
	ADD_STRINGVALUE( 0x14, "Mod Bow Zoom Factor")
	ADD_STRINGVALUE( 0x15, "Mod Recover Arrow Chance")
	ADD_STRINGVALUE( 0x16, "Mod Skill Use")
	ADD_STRINGVALUE( 0x17, "Mod Telekinesis Range")
	ADD_STRINGVALUE( 0x18, "Mod Telekinesis Damage Multipler")
	ADD_STRINGVALUE( 0x19, "Mod Telekinesis Damage")
	ADD_STRINGVALUE( 0x1A, "Mod Bashing Damage")
	ADD_STRINGVALUE( 0x1B, "Mod Power Attack Stamina Cost")
	ADD_STRINGVALUE( 0x1C, "Mod Power Attack Damage")
	ADD_STRINGVALUE( 0x1D, "Mod Spell Magnitude")
	ADD_STRINGVALUE( 0x1E, "Mod Spell Duration")
	ADD_STRINGVALUE( 0x1F, "Mod Secondary Value Weight")
	ADD_STRINGVALUE( 0x20, "Mod Armor Weight")
	ADD_STRINGVALUE( 0x21, "Mod Incoming Stagger Chance")
	ADD_STRINGVALUE( 0x22, "Mod Target Stagger Chance")
	ADD_STRINGVALUE( 0x23, "Mod Attack Damage")
	ADD_STRINGVALUE( 0x24, "Mod Incoming Damage")
	ADD_STRINGVALUE( 0x25, "Mod Target Damage Resistance")
	ADD_STRINGVALUE( 0x26, "Mod Spell Cost")
	ADD_STRINGVALUE( 0x27, "Mod Percent Blocked")
	ADD_STRINGVALUE( 0x28, "Mod Shield Deflect Arrow Chance")
	ADD_STRINGVALUE( 0x29, "Mod Incoming Spell Magnitude")
	ADD_STRINGVALUE( 0x2A, "Mod Incoming Spell Duration")
	ADD_STRINGVALUE( 0x2B, "Mod Player Intimidation")
	ADD_STRINGVALUE( 0x2C, "Mod Player Reputation")
	ADD_STRINGVALUE( 0x2D, "Mod Favor Points")
	ADD_STRINGVALUE( 0x2E, "Mod Bribe Amount")
	ADD_STRINGVALUE( 0x2F, "Mod Detection for Light")
	ADD_STRINGVALUE( 0x30, "Mod Detection for Movement")
	ADD_STRINGVALUE( 0x31, "Mod Soul Gem Recharge")
	ADD_STRINGVALUE( 0x32, "Set Sweep Attack")
	ADD_STRINGVALUE( 0x33, "Apply Combat Hit Spell")
	ADD_STRINGVALUE( 0x34, "Apply Bashing Spell")
	ADD_STRINGVALUE( 0x35, "Apply Reanimate Spell")
	ADD_STRINGVALUE( 0x36, "Set Game Setting")
	ADD_STRINGVALUE( 0x37, "Mod Spell Casting Noise")
	ADD_STRINGVALUE( 0x38, "Mod Pickpocket Chance")
	ADD_STRINGVALUE( 0x39, "Mod Detection Sneak Skill")
	ADD_STRINGVALUE( 0x3A, "Mod Falling Damage")
	ADD_STRINGVALUE( 0x3B, "Mod Lockpick Sweet Spot")
	ADD_STRINGVALUE( 0x3C, "Mod Sell Prices")
	ADD_STRINGVALUE( 0x3D, "Can PickPocket Equipped Item")
	ADD_STRINGVALUE( 0x3E, "Mod Lockpick Level Allowed")
	ADD_STRINGVALUE( 0x3F, "Set Lockpick Start Position")
	ADD_STRINGVALUE( 0x40, "Set Progression Picking")
	ADD_STRINGVALUE( 0x41, "Make Lockpicks Unbreakable")
	ADD_STRINGVALUE( 0x42, "Mod Alchemy Effectiveness")
	ADD_STRINGVALUE( 0x43, "Apply Weapon Swing Spell")
	ADD_STRINGVALUE( 0x44, "Mod Commanded Actor Limit")
	ADD_STRINGVALUE( 0x45, "Apply Sneaking Spell")
	ADD_STRINGVALUE( 0x46, "Mod Player Magic Slowdown")
	ADD_STRINGVALUE( 0x47, "Mod Ward Magic Absorption Percent")
	ADD_STRINGVALUE( 0x48, "Mod Ingredient Effects Learned")
	ADD_STRINGVALUE( 0x49, "Purify Alchemy Ingredients")
	ADD_STRINGVALUE( 0x4A, "Filter Activation")
	ADD_STRINGVALUE( 0x4B, "Can Dual Cast Spell")
	ADD_STRINGVALUE( 0x4C, "Mod Tempering Health")
	ADD_STRINGVALUE( 0x4D, "Mod Enchantment Power")
	ADD_STRINGVALUE( 0x4E, "Mod Soul Percent Captured to Weapon")
	ADD_STRINGVALUE( 0x4F, "Mod Soul Gem Enchanting")
	ADD_STRINGVALUE( 0x50, "Mod Number of Enchantments Allowed")
	ADD_STRINGVALUE( 0x51, "Set Activate Label")
	ADD_STRINGVALUE( 0x52, "Mod Permit Shouts")
	ADD_STRINGVALUE( 0x53, "Mod Poison Dose Count")
	ADD_STRINGVALUE( 0x54, "Should Apply Placed Item")
	ADD_STRINGVALUE( 0x55, "Mod Armor Rating")
	ADD_STRINGVALUE( 0x56, "Mod Lockpick Crime Chance")
	ADD_STRINGVALUE( 0x57, "Mod Ingredients Harvested")
	ADD_STRINGVALUE( 0x58, "Mod Spell Range to Location")
	ADD_STRINGVALUE( 0x59, "Mod Potions Created Count")
	ADD_STRINGVALUE( 0x5A, "Mod Lockpick Key Reward Chance")
END_STRINGVALUE()


BEGIN_STRINGVALUE(s_SrPerkFunctionTypes)
    ADD_STRINGVALUE( SRPERK_EFFECT_FUNCTION_SETVALUE,			"=Amount")
	ADD_STRINGVALUE( SRPERK_EFFECT_FUNCTION_ADDVALUE,			"+Amount")
	ADD_STRINGVALUE( SRPERK_EFFECT_FUNCTION_MULTVALUE,			"*Amount")
	ADD_STRINGVALUE( SRPERK_EFFECT_FUNCTION_ADDRANGEVALUE,		"+random(Min,Max)")
	ADD_STRINGVALUE( SRPERK_EFFECT_FUNCTION_AVADDMULTVALUE,		"+AV * Factor")
	ADD_STRINGVALUE( SRPERK_EFFECT_FUNCTION_ABSVALUE,			"=abs()")
	ADD_STRINGVALUE( SRPERK_EFFECT_FUNCTION_NEGABSVALUE,		"=-abs()")	
	ADD_STRINGVALUE( SRPERK_EFFECT_FUNCTION_ADDLEVELLIST,		"LevelList")
	ADD_STRINGVALUE( SRPERK_EFFECT_FUNCTION_ACTIVATE,			"Activate")
	ADD_STRINGVALUE( SRPERK_EFFECT_FUNCTION_ADDSPELL,			"Spell")
	ADD_STRINGVALUE( SRPERK_EFFECT_FUNCTION_SETGMST,			"SelectText")
	ADD_STRINGVALUE( SRPERK_EFFECT_FUNCTION_AVMULTVALUE,		"=AV * Factor")
	ADD_STRINGVALUE( SRPERK_EFFECT_FUNCTION_AVMULTMULTVALUE,	"*AV * Factor")
	ADD_STRINGVALUE( SRPERK_EFFECT_FUNCTION_AVADDMULTMULTVALUE,	"*(1 + AV*Factor)")	
	ADD_STRINGVALUE( SRPERK_EFFECT_FUNCTION_SETTEXT,			"SetText")
END_STRINGVALUE()


BEGIN_STRINGVALUE(s_SrPerkConditionTypes)
	ADD_STRINGVALUE( SRPERK_EFFECT_CONDOWNER,			"Owner")
	ADD_STRINGVALUE( SRPERK_EFFECT_CONDTARGET,			"Target")
	ADD_STRINGVALUE( SRPERK_EFFECT_CONDATTACKER,		"Attacker")
	ADD_STRINGVALUE( SRPERK_EFFECT_CONDATTACKERWEAPON,	"AttackerWeapon")
	ADD_STRINGVALUE( SRPERK_EFFECT_CONDSPELL,			"Spell")
	ADD_STRINGVALUE( SRPERK_EFFECT_CONDWEAPON,			"Weapon")
	ADD_STRINGVALUE( SRPERK_EFFECT_CONDITEM,			"Item")
	ADD_STRINGVALUE( SRPERK_EFFECT_CONDENCHANTMENT,		"Enchantment")
	ADD_STRINGVALUE( SRPERK_EFFECT_CONDLOCKEDREF,		"LockedRef")
END_STRINGVALUE()


BEGIN_STRINGVALUE(s_SrSopmContentTypes)
	ADD_STRINGVALUE( SR_SOPMCONTENTTYPE_FNAM,		"Fnam")
	ADD_STRINGVALUE( SR_SOPMCONTENTTYPE_ANAM,		"Anam")
	ADD_STRINGVALUE( SR_SOPMCONTENTTYPE_ONAM,		"Onam")
	ADD_STRINGVALUE( SR_SOPMCONTENTTYPE_ANAMONAM,	"Anam+Onam")
END_STRINGVALUE()


BEGIN_STRINGVALUE(s_SrRaceMoveNames)
	ADD_STRINGVALUE( SR_RACE_MOVENAME_WALK,		"WALK")
	ADD_STRINGVALUE( SR_RACE_MOVENAME_RUN1,		"RUN1")
	ADD_STRINGVALUE( SR_RACE_MOVENAME_SNEK,		"SNEK")
	ADD_STRINGVALUE( SR_RACE_MOVENAME_BLD0,		"BLD0")
	ADD_STRINGVALUE( SR_RACE_MOVENAME_SWIM,		"SWIM")
END_STRINGVALUE()


BEGIN_STRINGVALUE(s_SrConditionRunonTypes)
	ADD_STRINGVALUE( SR_CONDITION_RUNON_SUBJECT		,	"Subject")
	ADD_STRINGVALUE( SR_CONDITION_RUNON_TARGET		,	"Target")
	ADD_STRINGVALUE( SR_CONDITION_RUNON_REFERENCE	,	"Reference")
	ADD_STRINGVALUE( SR_CONDITION_RUNON_COMBATTARGET,	"Combat Target")
	ADD_STRINGVALUE( SR_CONDITION_RUNON_LINKEDREF	,	"Linked Ref")
	ADD_STRINGVALUE( SR_CONDITION_RUNON_QUESTALIAS	,	"Quest Alias")
	ADD_STRINGVALUE( SR_CONDITION_RUNON_PACKAGEDATA	,	"Package Data")
	ADD_STRINGVALUE( SR_CONDITION_RUNON_EVENTDATA	,	"Event Data")
END_STRINGVALUE()


BEGIN_STRINGVALUE(s_SrFurnitureAnimTypes)
	ADD_STRINGVALUE( SR_FURNANIM_SIT,		"Sit")
	ADD_STRINGVALUE( SR_FURNANIM_LEAN,		"Lean")
	ADD_STRINGVALUE( SR_FURNANIM_LAY,		"Lay")
END_STRINGVALUE()


BEGIN_STRINGVALUE(s_SrFurnitureEntryTypes)
	ADD_STRINGVALUE( SR_FURNENTRY_BEHIND,	"Behind")
	ADD_STRINGVALUE( SR_FURNENTRY_LEFT,		"Left")
	ADD_STRINGVALUE( SR_FURNENTRY_FRONT,	"Front")
	ADD_STRINGVALUE( SR_FURNENTRY_RIGHT,	"Right")
	ADD_STRINGVALUE( SR_FURNENTRY_UP,		"Up")
END_STRINGVALUE()


BEGIN_STRINGVALUE(s_SrSkillActionTypes)
	ADD_STRINGVALUE( SR_SKILLACTION_NORMAL,			"Normal")
	ADD_STRINGVALUE( SR_SKILLACTION_POWERATTACK,	"Power Attack")
	ADD_STRINGVALUE( SR_SKILLACTION_BASH,			"Bash")
	ADD_STRINGVALUE( SR_SKILLACTION_LPSUCCESS,		"Lockpick Success")
	ADD_STRINGVALUE( SR_SKILLACTION_LPBROKEN,		"Lockpick Broken")
END_STRINGVALUE()


BEGIN_STRINGVALUE(s_SrCrimeTypes)
	//ADD_STRINGVALUE( SR_CRIME_ANY,				"Any")
	ADD_STRINGVALUE( SR_CRIME_ATTACK,			"Attack")
	ADD_STRINGVALUE( SR_CRIME_ESCAPE,			"Escape")
	ADD_STRINGVALUE( SR_CRIME_MURDER,			"Murder")
	ADD_STRINGVALUE( SR_CRIME_PICKPOCKET,		"PickPocket")
	ADD_STRINGVALUE( SR_CRIME_STEAL,			"Steal")
	ADD_STRINGVALUE( SR_CRIME_TRESPASS,			"Trespass")
	ADD_STRINGVALUE( SR_CRIME_WEREWOLFTRANS,	"WerewolfTrans")
END_STRINGVALUE()


BEGIN_STRINGVALUE(s_SrWardStateTypes)
	ADD_STRINGVALUE( SR_WARDSTATE_ABSORB,	"Absorb")
	ADD_STRINGVALUE( SR_WARDSTATE_BREAK,	"Break")
	ADD_STRINGVALUE( SR_WARDSTATE_NONE,		"None")
END_STRINGVALUE()


BEGIN_STRINGVALUE(s_SrAxisTypes)
	ADD_STRINGVALUE( SR_AXIS_X,	"X")
	ADD_STRINGVALUE( SR_AXIS_Y,	"Y")
	ADD_STRINGVALUE( SR_AXIS_Z,	"Z")
END_STRINGVALUE()


BEGIN_STRINGVALUE(s_SrCastSourceTypes)
	ADD_STRINGVALUE( SR_CASTSOURCE_LEFT,	"Left")
	ADD_STRINGVALUE( SR_CASTSOURCE_RIGHT,	"Right")
	ADD_STRINGVALUE( SR_CASTSOURCE_VOICE,	"Voice")
	ADD_STRINGVALUE( SR_CASTSOURCE_INSTANT,	"Instant")
END_STRINGVALUE()


BEGIN_STRINGVALUE(s_SrCriticalStageTypes)
	ADD_STRINGVALUE( SR_CRITICALSTAGE_NONE,			"None")
	ADD_STRINGVALUE( SR_CRITICALSTAGE_DISTEND,		"Disintegrate End")
	ADD_STRINGVALUE( SR_CRITICALSTAGE_DISTSTART,	"Disintegrate Start")
	ADD_STRINGVALUE( SR_CRITICALSTAGE_GOOEND,		"Goo End")
	ADD_STRINGVALUE( SR_CRITICALSTAGE_GOOSTART,		"Goo Start")
END_STRINGVALUE()


BEGIN_STRINGVALUE(s_SrGenderTypes)
	ADD_STRINGVALUE( SR_GENDER_MALE,	"Male")
	ADD_STRINGVALUE( SR_GENDER_FEMALE,	"Female")
END_STRINGVALUE()


BEGIN_STRINGVALUE(s_SrScriptPropertyTypes)
	ADD_STRINGVALUE( SR_VMAD_PROPDATA_REFERENCE		,	"Object")
	ADD_STRINGVALUE( SR_VMAD_PROPDATA_STRING		,	"String")
	ADD_STRINGVALUE( SR_VMAD_PROPDATA_INT			,	"Int")
	ADD_STRINGVALUE( SR_VMAD_PROPDATA_FLOAT			,	"Float")
	ADD_STRINGVALUE( SR_VMAD_PROPDATA_BOOL			,	"Bool")
	ADD_STRINGVALUE( SR_VMAD_PROPDATA_ARRAYREFERENCE,	"Object[]")
	ADD_STRINGVALUE( SR_VMAD_PROPDATA_ARRAYSTRING	,	"String[]")
	ADD_STRINGVALUE( SR_VMAD_PROPDATA_ARRAYINT		,	"Int[]")
	ADD_STRINGVALUE( SR_VMAD_PROPDATA_ARRAYFLOAT	,	"Float[]")
	ADD_STRINGVALUE( SR_VMAD_PROPDATA_ARRAYBOOL		,	"Bool[]")
END_STRINGVALUE()


BEGIN_STRINGVALUE(s_SrSoundVolumes)
	ADD_STRINGVALUE( SR_SOUND_VOLUME_SILENT	 , "Silent")
	ADD_STRINGVALUE( SR_SOUND_VOLUME_NORMAL	 , "Normal")
	ADD_STRINGVALUE( SR_SOUND_VOLUME_LOUD	 , "Loud")
	ADD_STRINGVALUE( SR_SOUND_VOLUME_VERYLOUD, "Very Loud")
END_STRINGVALUE()


BEGIN_STRINGVALUE(s_SrMagicSoundTypes)
	ADD_STRINGVALUE( SR_MAGICSOUND_SHEATH,		"Sheath/Draw")
	ADD_STRINGVALUE( SR_MAGICSOUND_CHARGE,		"Charge")
	ADD_STRINGVALUE( SR_MAGICSOUND_READY,		"Ready")	
	ADD_STRINGVALUE( SR_MAGICSOUND_RELEASE,		"Release")
	ADD_STRINGVALUE( SR_MAGICSOUND_CASTLOOP,	"CastLoop")
	ADD_STRINGVALUE( SR_MAGICSOUND_ONHIT,		"OnHit")
END_STRINGVALUE()


BEGIN_STRINGVALUE(s_SrMagicEffectTypes)
	ADD_STRINGVALUE( SR_MAGICEFFECT_VALUEMOD			, "ActorValue Mod" )
	ADD_STRINGVALUE( SR_MAGICEFFECT_SCRIPT				, "Script" )
	ADD_STRINGVALUE( SR_MAGICEFFECT_DISPEL				, "Dispel" )
	ADD_STRINGVALUE( SR_MAGICEFFECT_CUREDISEASE			, "Cure Disease" )
	ADD_STRINGVALUE( SR_MAGICEFFECT_ABSORB				, "Absorb" )
	ADD_STRINGVALUE( SR_MAGICEFFECT_DUALVALUEMOD		, "Dual ActorValue Mod" )
	ADD_STRINGVALUE( SR_MAGICEFFECT_CALM				, "Calm" )
	ADD_STRINGVALUE( SR_MAGICEFFECT_DEMORALIZE			, "Demoralize" )
	ADD_STRINGVALUE( SR_MAGICEFFECT_FRENZY				, "Frenzy" )
	ADD_STRINGVALUE( SR_MAGICEFFECT_DISARM				, "Disarm" )
	ADD_STRINGVALUE( SR_MAGICEFFECT_COMMANDSUMMON		, "Command Summoned" )
	ADD_STRINGVALUE( SR_MAGICEFFECT_INVISIBILITY		, "Invisibility" )
	ADD_STRINGVALUE( SR_MAGICEFFECT_LIGHT				, "Light" )
	ADD_STRINGVALUE( SR_MAGICEFFECT_LOCK				, "Lock" )
	ADD_STRINGVALUE( SR_MAGICEFFECT_OPEN				, "Open" )
	ADD_STRINGVALUE( SR_MAGICEFFECT_BOUNDWEAPON			, "Bound Weapon" )
	ADD_STRINGVALUE( SR_MAGICEFFECT_SUMMONCREATURE		, "Summon Creature" )
	ADD_STRINGVALUE( SR_MAGICEFFECT_DETECTLIFE			, "Detect Life" )
	ADD_STRINGVALUE( SR_MAGICEFFECT_TELEKINESIS			, "Telekinesis" )
	ADD_STRINGVALUE( SR_MAGICEFFECT_PARALYSIS			, "Paralysis" )
	ADD_STRINGVALUE( SR_MAGICEFFECT_RENANIMATE			, "Reanimate" )
	ADD_STRINGVALUE( SR_MAGICEFFECT_SOULTRAP			, "Soul Trap" )
	ADD_STRINGVALUE( SR_MAGICEFFECT_TURNUNDEAD			, "Turn Undead" )
	ADD_STRINGVALUE( SR_MAGICEFFECT_GUIDE				, "Guide" )
	ADD_STRINGVALUE( SR_MAGICEFFECT_WEREWOLFFEED		, "Werewolf Feed" )
	ADD_STRINGVALUE( SR_MAGICEFFECT_CUREPARALYSIS		, "Cure Paralysis" )
	ADD_STRINGVALUE( SR_MAGICEFFECT_CUREADDICTION		, "Cure Additiction" )
	ADD_STRINGVALUE( SR_MAGICEFFECT_CUREPOISON			, "Cure Poison" )
	ADD_STRINGVALUE( SR_MAGICEFFECT_CONCUSSION			, "Concussion" )
	ADD_STRINGVALUE( SR_MAGICEFFECT_VALUEANDPARTS		, "Value and Parts" )
	ADD_STRINGVALUE( SR_MAGICEFFECT_ACCUMULATEMAG		, "Accumulate Magnitude" )
	ADD_STRINGVALUE( SR_MAGICEFFECT_STAGGER				, "Stagger" )
	ADD_STRINGVALUE( SR_MAGICEFFECT_PEAKVALUEMOD		, "Peak Value Mod" )
	ADD_STRINGVALUE( SR_MAGICEFFECT_CLOAK				, "Cloak" )
	ADD_STRINGVALUE( SR_MAGICEFFECT_WEREWOLF			, "Werewolf" )
	ADD_STRINGVALUE( SR_MAGICEFFECT_SLOWTIME			, "Slow Time" )
	ADD_STRINGVALUE( SR_MAGICEFFECT_RALLY				, "Rally" )
	ADD_STRINGVALUE( SR_MAGICEFFECT_ENHANCEWEAPON		, "Enhance Weapon" )
	ADD_STRINGVALUE( SR_MAGICEFFECT_SPAWNHAZARD			, "Spawn Hazard" )
	ADD_STRINGVALUE( SR_MAGICEFFECT_ETHEREALIZE			, "Etherealize" )
	ADD_STRINGVALUE( SR_MAGICEFFECT_BANISH				, "Banish" )
	ADD_STRINGVALUE( SR_MAGICEFFECT_SPAWNSCRIPTREF		, "Spawn Scripted Ref" )
	ADD_STRINGVALUE( SR_MAGICEFFECT_DISGUISE			, "Disguise" )
END_STRINGVALUE()


BEGIN_STRINGVALUE(s_SrEnchantmentTypes)
	ADD_STRINGVALUE( SR_ENCHANTTYPE_ENCHANT,	"Enchantment")
	ADD_STRINGVALUE( SR_ENCHANTTYPE_STAFF,		"Staff")
END_STRINGVALUE()
/*===========================================================================
 *		End of Constant String Tables
 *=========================================================================*/


/*===========================================================================
 *
 * Begin String Table Lookup Functions
 *
 *=========================================================================*/
const SSCHAR* GetSrMagicSchoolString		(const int Value) { return s_SrMagicSchoolsMap.FindValue(Value); }
const SSCHAR* GetSrMagicResistTypeString	(const int Value) { return s_SrMagicResistTypesMap.FindValue(Value); }
const SSCHAR* GetSrMagicDeliveryTypeString	(const int Value) { return s_SrMagicDeliveryTypesMap.FindValue(Value); }
const SSCHAR* GetSrConditionOperatorString	(const int Value) { return s_SrConditionOperatorsMap.FindValue(Value); }

const SSCHAR* GetSrSpellTypeString		(const int Value) { return s_SrSpellTypesMap.FindValue(Value); }
const SSCHAR* GetSrEnchantmentTypeString	(const int Value) { return s_SrEnchantmentTypesMap.FindValue(Value); }

const SSCHAR* GetSrBodyPartString		(const int Value) { return s_SrBodyPartsMap.FindValue(Value); }
const SSCHAR* GetSrArmorTypeString		(const int Value) { return s_SrArmorTypesMap.FindValue(Value); }

const SSCHAR* GetSrSkillTypeString		(const int Value) { return s_SrSkillTypesMap.FindValue(Value); }
const SSCHAR* GetSrContainerTypeString	(const int Value) { return s_SrContainerTypesMap.FindValue(Value); }
const SSCHAR* GetSrLightTypeString   	(const int Value) { return s_SrLightTypesMap.FindValue(Value); }
const SSCHAR* GetSrEffectCastTypeString (const int Value) { return s_SrEffectCastTypesMap.FindValue(Value); }
const SSCHAR* GetSrActorValueString     (const int Value) { return s_SrActorValuesMap.FindValue(Value); }
const SSCHAR* GetSrWeaponTypeString     (const int Value) { return s_SrWeaponTypesMap.FindValue(Value); }
const SSCHAR* GetSrSoulGemTypeString    (const int Value) { return s_SrSoulGemTypesMap.FindValue(Value); }

const SSCHAR* GetSrPerkDataUnknown1TypeString (const int Value) { return s_SrPerkDataUnknown1TypesMap.FindValue(Value); }
const SSCHAR* GetSrPerkDataUnknown2TypeString (const int Value) { return s_SrPerkDataUnknown2TypesMap.FindValue(Value); }
const SSCHAR* GetSrPerkDataUnknown3TypeString (const int Value) { return s_SrPerkDataUnknown3TypesMap.FindValue(Value); }

const SSCHAR* GetSrPrkcCustomTypeString (const int Value) { return s_SrPrkcCustomTypesMap.FindValue(Value); }
const SSCHAR* GetSrEpftTypeString (const int Value) { return s_SrEpftTypesMap.FindValue(Value); }
const SSCHAR* GetSrPerkEffectTypeString (const int Value) { return s_SrPerkEffectTypesMap.FindValue(Value); }
const SSCHAR* GetSrPerkFunctionTypeString (const int Value) { return s_SrPerkFunctionTypesMap.FindValue(Value); }

const SSCHAR* GetSrSopmContentTypeString (const int Value) { return s_SrSopmContentTypesMap.FindValue(Value); }
const SSCHAR* GetSrPerkConditionTypeString (const int Value) { return s_SrPerkConditionTypesMap.FindValue(Value); }
const SSCHAR* GetSrConditionRunonTypeString (const int Value) { return s_SrConditionRunonTypesMap.FindValue(Value); }
const SSCHAR* GetSrFurnitureAnimTypeString (const int Value) { return s_SrFurnitureAnimTypesMap.FindValue(Value); }
const SSCHAR* GetSrFurnitureEntryTypeString (const int Value) { return s_SrFurnitureEntryTypesMap.FindValue(Value); }
const SSCHAR* GetSrSkillActionTypeString (const int Value) { return s_SrSkillActionTypesMap.FindValue(Value); }
const SSCHAR* GetSrCrimeTypeString (const int Value) { return s_SrCrimeTypesMap.FindValue(Value); }
const SSCHAR* GetSrWardStateTypeString (const int Value) { return s_SrWardStateTypesMap.FindValue(Value); }
const SSCHAR* GetSrAxisTypeString (const int Value) { return s_SrAxisTypesMap.FindValue(Value); }
const SSCHAR* GetSrCastSourceTypeString (const int Value) { return s_SrCastSourceTypesMap.FindValue(Value); }
const SSCHAR* GetSrCriticalStageTypeString (const int Value) { return s_SrCriticalStageTypesMap.FindValue(Value); }
const SSCHAR* GetSrGenderTypeString (const int Value) { return s_SrGenderTypesMap.FindValue(Value); }
const SSCHAR* GetSrScriptPropertyTypeString (const int Value) { return s_SrScriptPropertyTypesMap.FindValue(Value); }
const SSCHAR* GetSrSoundVolumeString (const int Value) { return s_SrSoundVolumesMap.FindValue(Value); }
const SSCHAR* GetSrMagicSoundTypeString (const int Value) { return s_SrMagicSoundTypesMap.FindValue(Value); }
const SSCHAR* GetSrMagicEffectTypeString (const int Value) { return s_SrMagicEffectTypesMap.FindValue(Value); }

const SSCHAR* GetSrLightTypeFlagString 	(const dword LightFlags) 
{
	int Value = LightFlags & SR_LIGHTTYPE_MASK;
	return s_SrLightTypesMap.FindValue(Value); 
}


CSString GetSrBodyPartFlagString	(const dword Value) 
{ 
	CSString Buffer;

	for (dword i = 0; s_SrBodyParts[i].pString != NULL; ++i)
	{
		if (s_SrBodyParts[i].Value & Value)
		{
			Buffer += s_SrBodyParts[i].pString;
			Buffer += " ";
		}
	}

	return Buffer;
}


bool GetSrMagicSchoolValue			(int& Value, const SSCHAR* pString) { return s_SrMagicSchoolsMap.FindString(Value, pString); }
bool GetSrMagicResistTypeValue		(int& Value, const SSCHAR* pString) { return s_SrMagicResistTypesMap.FindString(Value, pString); }
bool GetSrMagicDeliveryTypeValue	(int& Value, const SSCHAR* pString) { return s_SrMagicDeliveryTypesMap.FindString(Value, pString); }
bool GetSrConditionOperatorValue	(int& Value, const SSCHAR* pString) { return s_SrConditionOperatorsMap.FindString(Value, pString); }

bool GetSrSpellTypeValue		(int& Value, const SSCHAR* pString) { return s_SrSpellTypesMap.FindString(Value, pString); }
bool GetSrEnchantmentTypeValue	(int& Value, const SSCHAR* pString) { return s_SrEnchantmentTypesMap.FindString(Value, pString); }

bool GetSrBodyPartValue	 (int& Value, const SSCHAR* pString) { return s_SrBodyPartsMap.FindString(Value, pString); }
bool GetSrArmorTypeValue (int& Value, const SSCHAR* pString) { return s_SrArmorTypesMap.FindString(Value, pString); }

bool GetSrSkillTypeValue      (int& Value, const SSCHAR* pString) { return s_SrSkillTypesMap.FindString(Value, pString); }
bool GetSrContainerTypeValue  (int& Value, const SSCHAR* pString) { return s_SrContainerTypesMap.FindString(Value, pString); }
bool GetSrLightTypeValue      (int& Value, const SSCHAR* pString) { return s_SrLightTypesMap.FindString(Value, pString); }
bool GetSrEffectCastTypeValue (int& Value, const SSCHAR* pString) { return s_SrEffectCastTypesMap.FindString(Value, pString); }
bool GetSrActorValueValue     (int& Value, const SSCHAR* pString) { return s_SrActorValuesMap.FindString(Value, pString); }
bool GetSrWeaponTypeValue     (int& Value, const SSCHAR* pString) { return s_SrWeaponTypesMap.FindString(Value, pString); }
bool GetSrSoulGemTypeValue    (int& Value, const SSCHAR* pString) { return s_SrSoulGemTypesMap.FindString(Value, pString); }

bool GetSrPerkDataUnknown1TypeValue (int& Value, const SSCHAR* pString) { return s_SrPerkDataUnknown1TypesMap.FindString(Value, pString); }
bool GetSrPerkDataUnknown2TypeValue (int& Value, const SSCHAR* pString) { return s_SrPerkDataUnknown2TypesMap.FindString(Value, pString); }
bool GetSrPerkDataUnknown3TypeValue (int& Value, const SSCHAR* pString) { return s_SrPerkDataUnknown3TypesMap.FindString(Value, pString); }

bool GetSrPrkcCustomTypeValue (int& Value, const SSCHAR* pString) { return s_SrPrkcCustomTypesMap.FindString(Value, pString); }
bool GetSrEpftTypeValue (int& Value, const SSCHAR* pString) { return s_SrEpftTypesMap.FindString(Value, pString); }
bool GetSrPerkEffectTypeValue (int& Value, const SSCHAR* pString) { return s_SrPerkEffectTypesMap.FindString(Value, pString); }
bool GetSrPerkFunctionTypeValue (int& Value, const SSCHAR* pString) { return s_SrPerkFunctionTypesMap.FindString(Value, pString); }

bool GetSrSopmContentTypeValue (int& Value, const SSCHAR* pString) { return s_SrSopmContentTypesMap.FindString(Value, pString); }
bool GetSrPerkConditionTypeValue (int& Value, const SSCHAR* pString) { return s_SrPerkConditionTypesMap.FindString(Value, pString); }
bool GetSrConditionRunonTypeValue (int& Value, const SSCHAR* pString) { return s_SrConditionRunonTypesMap.FindString(Value, pString); }
bool GetSrFurnitureAnimTypeValue (int& Value, const SSCHAR* pString) { return s_SrFurnitureAnimTypesMap.FindString(Value, pString); }
bool GetSrFurnitureEntryTypeValue (int& Value, const SSCHAR* pString) { return s_SrFurnitureEntryTypesMap.FindString(Value, pString); }
bool GetSrSkillActionTypeValue (int& Value, const SSCHAR* pString) { return s_SrSkillActionTypesMap.FindString(Value, pString); }
bool GetSrCrimeTypeValue (int& Value, const SSCHAR* pString) { return s_SrCrimeTypesMap.FindString(Value, pString); }
bool GetSrWardStateTypeValue (int& Value, const SSCHAR* pString) { return s_SrWardStateTypesMap.FindString(Value, pString); }
bool GetSrAxisTypeValue (int& Value, const SSCHAR* pString) { return s_SrAxisTypesMap.FindString(Value, pString); }
bool GetSrCastSourceTypeValue (int& Value, const SSCHAR* pString) { return s_SrCastSourceTypesMap.FindString(Value, pString); }
bool GetSrCriticalStageTypeValue (int& Value, const SSCHAR* pString) { return s_SrCriticalStageTypesMap.FindString(Value, pString); }
bool GetSrGenderTypeValue (int& Value, const SSCHAR* pString) { return s_SrGenderTypesMap.FindString(Value, pString); }
bool GetSrScriptPropertyTypeValue (int& Value, const SSCHAR* pString) { return s_SrScriptPropertyTypesMap.FindString(Value, pString); }
bool GetSrSoundVolumeValue (int& Value, const SSCHAR* pString) { return s_SrSoundVolumesMap.FindString(Value, pString); }
bool GetSrMagicSoundTypeValue (int& Value, const SSCHAR* pString) { return s_SrMagicSoundTypesMap.FindString(Value, pString); }
bool GetSrMagicEffectTypeValue (int& Value, const SSCHAR* pString) { return s_SrMagicEffectTypesMap.FindString(Value, pString); }

bool GetSrLightTypeFlagValue  (dword& LightFlags, const SSCHAR* pString) 
{
	int Type = LightFlags & SR_LIGHTTYPE_MASK;

	if (s_SrLightTypesMap.FindString(Type, pString)) 
	{
		LightFlags = (LightFlags & ~SR_LIGHTTYPE_MASK) | Type;
		return true;
	}

	return false;
}


bool GetSrBodyPartFlagValue	(dword& Value, const SSCHAR* pString) 
{ 
	CSString	  Source(pString);
	CSStringArray SplitStrings;
	int 		  Flag;

	Value = 0;
	SplitString(SplitStrings, Source, ' ');

	for (dword i = 0; i < SplitStrings.GetSize(); ++i)
	{
		if (GetSrBodyPartValue(Flag, *SplitStrings[i])) Value |= Flag;
	}

	return true;
}

/*===========================================================================
 *		End of String Table Lookup Functions
 *=========================================================================*/


/*===========================================================================
 *
 * Function - bool SrFixupFormid (OutputFormID, OrigFormID, FixupArray);
 *
 *=========================================================================*/
bool SrFixupFormid (srformid_t& OutputFormID, const srformid_t OrigFormID, CSrFormidFixupArray& FixupArray) 
{
  dword OldModIndex;
  dword NewModIndex;

	/* Special case for the NULL formid */
  if (OrigFormID == SR_FORMID_NULL) 
  {
    OutputFormID = SR_FORMID_NULL;
    return (true);
  }

  OldModIndex = SR_GETMODINDEX(OrigFormID);
  
  if (!FixupArray.IsValidIndex(OldModIndex)) 
  {
    AddSrGeneralError("Warning: Modindex of form 0x%08X is not valid (must be 0-%d)!", OrigFormID, FixupArray.GetSize()-1);
    //return (false); //Turn into just a warning?
  }
  
  NewModIndex  = FixupArray[OldModIndex];
  OutputFormID = SR_MAKEFORMID(OrigFormID, NewModIndex);
  return (true);
}
/*===========================================================================
 *		End of Function SrFixupFormid()
 *=========================================================================*/


/*===========================================================================
 *
 * Function - dword SrFindData (pData, Size, FindData);
 *
 *=========================================================================*/
dword SrFindData (const byte* pData, const dword Size, srfinddata_t& FindData) 
{
  if ((FindData.Flags & SR_FIND_CASESENSITIVE) != 0) return SrFindDataCase(pData, Size, FindData);
  return SrFindDataNoCase(pData, Size, FindData); 
}
/*===========================================================================
 *		End of Function SrFindData()
 *=========================================================================*/


/*===========================================================================
 *
 * Function - dword SrFindTextData (pData, Size, FindData);
 *
 *=========================================================================*/
dword SrFindTextData (const byte* pData, const dword Size, srfinddata_t& FindData)
{
  if ((FindData.Flags & SR_FIND_CASESENSITIVE) != 0) return SrFindTextDataCase(pData, Size, FindData);
  return SrFindTextDataNoCase(pData, Size, FindData); 
}
/*===========================================================================
 *		End of Function SrFindTextData()
 *=========================================================================*/
 

/*===========================================================================
 *
 * Function - dword SrFindDataNoCase (pData, Size, FindData);
 *
 *=========================================================================*/
dword SrFindDataNoCase (const byte* pData, const dword Size, srfinddata_t& FindData) {
  dword FindCount = 0;
  dword Index     = 0;
  dword FindIndex = 0;
  const byte* pParse1;
  const byte* pParse2;

	/* Ignore if given data size is too small */
  if (Size < FindData.DataSize) return (0);
  if (pData == NULL) return (0);
  
  pParse1 = pData;
  pParse2 = FindData.pData;

  while (Index < Size) {
    if (pParse2[FindIndex] == pParse1[0]) {
      ++FindIndex;

      if (FindIndex == FindData.DataSize) {
        if ((FindData.Flags & SR_FIND_OUTPUTLOG) != 0) SystemLog.Printf("\t\tFound at index %u", Index);
	++FindCount;
	if ((FindData.Flags & SR_FIND_FINDALL) == 0) return (FindCount);
	FindIndex = 0;
      }
    }
    else {
      pParse1  -= FindIndex;
      Index    -= FindIndex;
      FindIndex = 0;
    }

    ++pParse1;
    ++Index;
  }

  return (FindCount);
}
/*===========================================================================
 *		End of Function SrFindDataNoCase()
 *=========================================================================*/


/*===========================================================================
 *
 * Function - dword SrFindDataCase (pData, Size, FindData);
 *
 *=========================================================================*/
dword SrFindDataCase (const byte* pData, const dword Size, srfinddata_t& FindData) 
{
  dword FindCount = 0;
  dword Index     = 0;
  dword FindIndex = 0;
  const byte* pParse1;
  const byte* pParse2;

	/* Ignore if given data size is too small */
  if (Size < FindData.DataSize) return (0);
  if (pData == NULL) return (0);
 
  pParse1 = pData;
  pParse2 = FindData.pData;

  while (Index < Size) 
  {

    if (pParse2[FindIndex] == pParse1[0]) 
	{
      ++FindIndex;

      if (FindIndex == FindData.DataSize) 
	  {
        if ((FindData.Flags & SR_FIND_OUTPUTLOG) != 0) SystemLog.Printf("\t\tFound at index %u", Index);
		++FindCount;
		if ((FindData.Flags & SR_FIND_FINDALL) == 0) return (FindCount);
		FindIndex = 0;
      }
    }
    else
	{
      pParse1  -= FindIndex;
      Index    -= FindIndex;
      FindIndex = 0;
    }

    ++pParse1;
    ++Index;
  }

  return (FindCount);
}
/*===========================================================================
 *		End of Function SrFindDataCase()
 *=========================================================================*/


/*===========================================================================
 *
 * Function - dword SrFindTextDataNoCase (pData, Size, FindData);
 *
 *=========================================================================*/
dword SrFindTextDataNoCase (const byte* pData, const dword Size, srfinddata_t& FindData)
{
  dword FindCount = 0;
  dword Index     = 0;
  dword FindIndex = 0;
  const byte* pParse1;
  const byte* pParse2;

	/* Ignore if given data size is too small */
  if (Size < FindData.DataSize) return (0);
  if (pData == NULL) return (0);

  pParse1 = pData;
  pParse2 = FindData.pData;

  while (Index < Size)
  {

  		/* Stop searching on the first non-text character */
    if (*pParse1 < 0x05 || *pParse1 > 0x7f) break;

    if (tolower(pParse2[FindIndex]) == tolower(pParse1[0]))
	{
      ++FindIndex;

      if (FindIndex == FindData.DataSize) 
	  {
        if ((FindData.Flags & SR_FIND_OUTPUTLOG) != 0) SystemLog.Printf("\t\tFound at index %u", Index);
		++FindCount;
		if ((FindData.Flags & SR_FIND_FINDALL) == 0) return (FindCount);
		FindIndex = 0;
      }
    }
    else 
	{
      pParse1  -= FindIndex;
      Index    -= FindIndex;
      FindIndex = 0;
    }

    ++pParse1;
    ++Index;
  }

  return (FindCount);
}
/*===========================================================================
 *		End of Function SrFindTextDataNoCase()
 *=========================================================================*/


/*===========================================================================
 *
 * Function - dword SrFindTextDataCase (pData, Size, FindData);
 *
 *=========================================================================*/
dword SrFindTextDataCase (const byte* pData, const dword Size, srfinddata_t& FindData)
{
  dword FindCount = 0;
  dword Index     = 0;
  dword FindIndex = 0;
  const byte* pParse1;
  const byte* pParse2;

	/* Ignore if given data size is too small */
  if (Size < FindData.DataSize) return (0);
  if (pData == NULL) return (0);

  pParse1 = pData;
  pParse2 = FindData.pData;

  while (Index < Size)
  {

    		/* Stop searching on the first non-text character */
    if (*pParse1 < 0x05 || *pParse1 > 0x7f) break;

    if (tolower(pParse2[FindIndex]) == tolower(pParse1[0]))
	{
      ++FindIndex;

      if (FindIndex == FindData.DataSize)
	  {
        if ((FindData.Flags & SR_FIND_OUTPUTLOG) != 0) SystemLog.Printf("\t\tFound at index %u", Index);
		++FindCount;
		if ((FindData.Flags & SR_FIND_FINDALL) == 0) return (FindCount);
		FindIndex = 0;
      }
    }
    else
	{
      pParse1  -= FindIndex;
      Index    -= FindIndex;
      FindIndex = 0;
    }

    ++pParse1;
    ++Index;
  }

  return (FindCount);
}
/*===========================================================================
 *		End of Function SrFindTextDataCase()
 *=========================================================================*/


/*===========================================================================
 *
 * Function - bool SrContainsRecordType (Name, pArray);
 *
 *=========================================================================*/
bool SrContainsRecordType (const srrectype_t Name, const srrectype_t* pArray)
{
  if (pArray == NULL) return (false);

  while (*pArray != SR_NAME_NULL)
  {
    if (*pArray == Name) return (true);
    ++pArray;
  }

  return (false);
}
/*===========================================================================
 *		End of Function SrContainsRecordType()
 *=========================================================================*/


/*===========================================================================
 *
 * Function - bool SrPrepareEditorID (EditorID);
 *
 * Prepares the given editorID for use, removing whitespace and any invalid
 * characters. Returns false if the final result is not a valid editor ID.
 *
 *========================================================================*/
int sriseditorchar(int Char)
{
	return (isalnum(Char) || Char == '_');
}


bool SrPrepareEditorID (CSString& EditorID)
{

	/* Remove all whitespace */
  EditorID.Trim();

	/* Ensure the ID is only alpha-numeric */
  EditorID.RemoveCharsToMatch(sriseditorchar);

	/* Empty string is not a valid ID */
  if (EditorID.IsEmpty()) return (false);

  return (true);
}
/*===========================================================================
 *		End of Function SrPrepareEditorID()
 *=========================================================================*/


bool SrIsRecipeComponent (const srrectype_t Type)
{
	if (Type == SR_NAME_ALCH) return true;
	if (Type == SR_NAME_ARMO) return true;
	if (Type == SR_NAME_BOOK) return true;
	if (Type == SR_NAME_INGR) return true;
	if (Type == SR_NAME_MISC) return true;
	if (Type == SR_NAME_SCRL) return true;
	if (Type == SR_NAME_WEAP) return true;

	return false;
}


bool SrIsRecipeResult (const srrectype_t Type)
{
	if (Type == SR_NAME_ALCH) return true;
	if (Type == SR_NAME_ARMO) return true;
	if (Type == SR_NAME_BOOK) return true;	
	if (Type == SR_NAME_INGR) return true;
	if (Type == SR_NAME_MISC) return true;
	if (Type == SR_NAME_SCRL) return true;
	if (Type == SR_NAME_WEAP) return true;

	return false;
}


bool SrIsValidLvliRecord (const srrectype_t Type)
{
	if (Type == SR_NAME_ALCH) return true;
	if (Type == SR_NAME_AMMO) return true;
	if (Type == SR_NAME_ARMO) return true;
	if (Type == SR_NAME_BOOK) return true;	
	if (Type == SR_NAME_INGR) return true;
	if (Type == SR_NAME_LVLI) return true;
	if (Type == SR_NAME_KEYM) return true;
	if (Type == SR_NAME_MISC) return true;
	if (Type == SR_NAME_SCRL) return true;
	if (Type == SR_NAME_WEAP) return true;

	return false;
}


bool SrIsValidLvlnRecord (const srrectype_t Type)
{
	if (Type == SR_NAME_NPC_) return true;
	if (Type == SR_NAME_LVLN) return true;

	return false;
}


bool SrIsValidLvspRecord (const srrectype_t Type)
{
	if (Type == SR_NAME_LVSP) return true;
	if (Type == SR_NAME_SPEL) return true;

	return false;
}


bool SrIsValidContainerRecord (const srrectype_t Type)
{
	if (Type == SR_NAME_ALCH) return true;
	if (Type == SR_NAME_AMMO) return true;
	if (Type == SR_NAME_ARMO) return true;
	if (Type == SR_NAME_BOOK) return true;	
	if (Type == SR_NAME_INGR) return true;
	if (Type == SR_NAME_LVLI) return true;
	if (Type == SR_NAME_KEYM) return true;
	if (Type == SR_NAME_MISC) return true;
	if (Type == SR_NAME_SCRL) return true;
	if (Type == SR_NAME_WEAP) return true;

	return false;
}



const CSrRecTypeArray& GetSrEquipableRecordTypes()
{
	static CSrRecTypeArray s_Array;
	static bool s_Init = false;

	if (!s_Init)
	{
		s_Array.Add(SR_NAME_ARMO);
		s_Array.Add(SR_NAME_WEAP);
		s_Init = true;
	}

	return s_Array;
}


const CSrRecTypeArray& GetSrMagicItemRecordTypes()
{
	static CSrRecTypeArray s_Array;
	static bool s_Init = false;

	if (!s_Init)
	{
		s_Array.Add(SR_NAME_SPEL);
		s_Array.Add(SR_NAME_ENCH);
		s_Array.Add(SR_NAME_INGR);
		s_Array.Add(SR_NAME_SCRL);
		s_Array.Add(SR_NAME_ALCH);
		s_Init = true;
	}

	return s_Array;
}


const CSrRecTypeArray& GetSrKnowableRecordTypes()
{
	static CSrRecTypeArray s_Array;
	static bool s_Init = false;

	if (!s_Init)
	{
		s_Array.Add(SR_NAME_MGEF);
		s_Array.Add(SR_NAME_WOOP);
		s_Init = true;
	}

	return s_Array;
}


const CSrRecTypeArray& GetSrReferenceRecordTypes()
{
	static CSrRecTypeArray s_Array;
	static bool s_Init = false;

	if (!s_Init)
	{
		s_Array.Add(SR_NAME_REFR);
		//TODO: Add other types?
		s_Init = true;
	}

	return s_Array;
}
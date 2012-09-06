# Microsoft Developer Studio Generated NMAKE File, Based on MWEdit.dsp
!IF "$(CFG)" == ""
CFG=MWEdit - Win32 Debug
!MESSAGE No configuration specified. Defaulting to MWEdit - Win32 Debug.
!ENDIF 

!IF "$(CFG)" != "MWEdit - Win32 Release" && "$(CFG)" != "MWEdit - Win32 Debug"
!MESSAGE Invalid configuration "$(CFG)" specified.
!MESSAGE You can specify a configuration when running NMAKE
!MESSAGE by defining the macro CFG on the command line. For example:
!MESSAGE 
!MESSAGE NMAKE /f "MWEdit.mak" CFG="MWEdit - Win32 Debug"
!MESSAGE 
!MESSAGE Possible choices for configuration are:
!MESSAGE 
!MESSAGE "MWEdit - Win32 Release" (based on "Win32 (x86) Application")
!MESSAGE "MWEdit - Win32 Debug" (based on "Win32 (x86) Application")
!MESSAGE 
!ERROR An invalid configuration is specified.
!ENDIF 

!IF "$(OS)" == "Windows_NT"
NULL=
!ELSE 
NULL=nul
!ENDIF 

!IF  "$(CFG)" == "MWEdit - Win32 Release"

OUTDIR=.\Release
INTDIR=.\Release
# Begin Custom Macros
OutDir=.\Release
# End Custom Macros

ALL : ".\Release\MWEdit.hlp" ".\Release\MWEdit.cnt" "$(OUTDIR)\MWEdit.exe" "$(OUTDIR)\MWEdit.bsc"


CLEAN :
	-@erase "$(INTDIR)\ActivatorDlg.obj"
	-@erase "$(INTDIR)\ActivatorDlg.sbr"
	-@erase "$(INTDIR)\ChildFrm.obj"
	-@erase "$(INTDIR)\ChildFrm.sbr"
	-@erase "$(INTDIR)\ChildFrmFix.obj"
	-@erase "$(INTDIR)\ChildFrmFix.sbr"
	-@erase "$(INTDIR)\ChildFrmScript.obj"
	-@erase "$(INTDIR)\ChildFrmScript.sbr"
	-@erase "$(INTDIR)\ChildFrmVar.obj"
	-@erase "$(INTDIR)\ChildFrmVar.sbr"
	-@erase "$(INTDIR)\ColorStatic1.obj"
	-@erase "$(INTDIR)\ColorStatic1.sbr"
	-@erase "$(INTDIR)\CreaturePage1.obj"
	-@erase "$(INTDIR)\CreaturePage1.sbr"
	-@erase "$(INTDIR)\CreaturePage2.obj"
	-@erase "$(INTDIR)\CreaturePage2.sbr"
	-@erase "$(INTDIR)\csvfile.obj"
	-@erase "$(INTDIR)\csvfile.sbr"
	-@erase "$(INTDIR)\CustRichEdit.obj"
	-@erase "$(INTDIR)\CustRichEdit.sbr"
	-@erase "$(INTDIR)\dl_base.obj"
	-@erase "$(INTDIR)\dl_base.sbr"
	-@erase "$(INTDIR)\dl_block.obj"
	-@erase "$(INTDIR)\dl_block.sbr"
	-@erase "$(INTDIR)\dl_chr.obj"
	-@erase "$(INTDIR)\dl_chr.sbr"
	-@erase "$(INTDIR)\dl_err.obj"
	-@erase "$(INTDIR)\dl_err.sbr"
	-@erase "$(INTDIR)\dl_file.obj"
	-@erase "$(INTDIR)\dl_file.sbr"
	-@erase "$(INTDIR)\dl_log.obj"
	-@erase "$(INTDIR)\dl_log.sbr"
	-@erase "$(INTDIR)\dl_math.obj"
	-@erase "$(INTDIR)\dl_math.sbr"
	-@erase "$(INTDIR)\dl_mem.obj"
	-@erase "$(INTDIR)\dl_mem.sbr"
	-@erase "$(INTDIR)\dl_str.obj"
	-@erase "$(INTDIR)\dl_str.sbr"
	-@erase "$(INTDIR)\dl_time.obj"
	-@erase "$(INTDIR)\dl_time.sbr"
	-@erase "$(INTDIR)\dl_ToolTip.obj"
	-@erase "$(INTDIR)\dl_ToolTip.sbr"
	-@erase "$(INTDIR)\EsmActivator.obj"
	-@erase "$(INTDIR)\EsmActivator.sbr"
	-@erase "$(INTDIR)\EsmAiActivateDlg.obj"
	-@erase "$(INTDIR)\EsmAiActivateDlg.sbr"
	-@erase "$(INTDIR)\EsmAiEscortDlg.obj"
	-@erase "$(INTDIR)\EsmAiEscortDlg.sbr"
	-@erase "$(INTDIR)\EsmAiTravelDlg.obj"
	-@erase "$(INTDIR)\EsmAiTravelDlg.sbr"
	-@erase "$(INTDIR)\EsmAiWanderDlg.obj"
	-@erase "$(INTDIR)\EsmAiWanderDlg.sbr"
	-@erase "$(INTDIR)\EsmAlchemy.obj"
	-@erase "$(INTDIR)\EsmAlchemy.sbr"
	-@erase "$(INTDIR)\EsmAlchemyDlg.obj"
	-@erase "$(INTDIR)\EsmAlchemyDlg.sbr"
	-@erase "$(INTDIR)\EsmApparatus.obj"
	-@erase "$(INTDIR)\EsmApparatus.sbr"
	-@erase "$(INTDIR)\EsmApparatusDlg.obj"
	-@erase "$(INTDIR)\EsmApparatusDlg.sbr"
	-@erase "$(INTDIR)\EsmArmor.obj"
	-@erase "$(INTDIR)\EsmArmor.sbr"
	-@erase "$(INTDIR)\EsmArmorDlg.obj"
	-@erase "$(INTDIR)\EsmArmorDlg.sbr"
	-@erase "$(INTDIR)\EsmBase.obj"
	-@erase "$(INTDIR)\EsmBase.sbr"
	-@erase "$(INTDIR)\EsmBirthSign.obj"
	-@erase "$(INTDIR)\EsmBirthSign.sbr"
	-@erase "$(INTDIR)\EsmBirthSignDlg.obj"
	-@erase "$(INTDIR)\EsmBirthSignDlg.sbr"
	-@erase "$(INTDIR)\EsmBodyPart.obj"
	-@erase "$(INTDIR)\EsmBodyPart.sbr"
	-@erase "$(INTDIR)\EsmBodyPartDlg.obj"
	-@erase "$(INTDIR)\EsmBodyPartDlg.sbr"
	-@erase "$(INTDIR)\EsmBook.obj"
	-@erase "$(INTDIR)\EsmBook.sbr"
	-@erase "$(INTDIR)\EsmBookDlg.obj"
	-@erase "$(INTDIR)\EsmBookDlg.sbr"
	-@erase "$(INTDIR)\EsmCell.obj"
	-@erase "$(INTDIR)\EsmCell.sbr"
	-@erase "$(INTDIR)\EsmCellDlg.obj"
	-@erase "$(INTDIR)\EsmCellDlg.sbr"
	-@erase "$(INTDIR)\EsmCellRefDlg.obj"
	-@erase "$(INTDIR)\EsmCellRefDlg.sbr"
	-@erase "$(INTDIR)\EsmClass.obj"
	-@erase "$(INTDIR)\EsmClass.sbr"
	-@erase "$(INTDIR)\EsmClassDlg.obj"
	-@erase "$(INTDIR)\EsmClassDlg.sbr"
	-@erase "$(INTDIR)\EsmClothing.obj"
	-@erase "$(INTDIR)\EsmClothing.sbr"
	-@erase "$(INTDIR)\EsmClothingDlg.obj"
	-@erase "$(INTDIR)\EsmClothingDlg.sbr"
	-@erase "$(INTDIR)\EsmContainDlg.obj"
	-@erase "$(INTDIR)\EsmContainDlg.sbr"
	-@erase "$(INTDIR)\EsmContainer.obj"
	-@erase "$(INTDIR)\EsmContainer.sbr"
	-@erase "$(INTDIR)\EsmCreature.obj"
	-@erase "$(INTDIR)\EsmCreature.sbr"
	-@erase "$(INTDIR)\EsmCreatureDlg.obj"
	-@erase "$(INTDIR)\EsmCreatureDlg.sbr"
	-@erase "$(INTDIR)\EsmCreaturePage1.obj"
	-@erase "$(INTDIR)\EsmCreaturePage1.sbr"
	-@erase "$(INTDIR)\EsmCreaturePage2.obj"
	-@erase "$(INTDIR)\EsmCreaturePage2.sbr"
	-@erase "$(INTDIR)\EsmCreaturePage3.obj"
	-@erase "$(INTDIR)\EsmCreaturePage3.sbr"
	-@erase "$(INTDIR)\EsmCreaturePage4.obj"
	-@erase "$(INTDIR)\EsmCreaturePage4.sbr"
	-@erase "$(INTDIR)\EsmCreaturePage5.obj"
	-@erase "$(INTDIR)\EsmCreaturePage5.sbr"
	-@erase "$(INTDIR)\EsmCsvDefs.obj"
	-@erase "$(INTDIR)\EsmCsvDefs.sbr"
	-@erase "$(INTDIR)\EsmCsvImportDlg.obj"
	-@erase "$(INTDIR)\EsmCsvImportDlg.sbr"
	-@erase "$(INTDIR)\EsmDialogDlg.obj"
	-@erase "$(INTDIR)\EsmDialogDlg.sbr"
	-@erase "$(INTDIR)\EsmDialogue.obj"
	-@erase "$(INTDIR)\EsmDialogue.sbr"
	-@erase "$(INTDIR)\EsmDlgArray.obj"
	-@erase "$(INTDIR)\EsmDlgArray.sbr"
	-@erase "$(INTDIR)\EsmDoor.obj"
	-@erase "$(INTDIR)\EsmDoor.sbr"
	-@erase "$(INTDIR)\EsmDoorDlg.obj"
	-@erase "$(INTDIR)\EsmDoorDlg.sbr"
	-@erase "$(INTDIR)\EsmEffectDlg.obj"
	-@erase "$(INTDIR)\EsmEffectDlg.sbr"
	-@erase "$(INTDIR)\EsmEnchant.obj"
	-@erase "$(INTDIR)\EsmEnchant.sbr"
	-@erase "$(INTDIR)\EsmEnchantDlg.obj"
	-@erase "$(INTDIR)\EsmEnchantDlg.sbr"
	-@erase "$(INTDIR)\EsmExtCellPage.obj"
	-@erase "$(INTDIR)\EsmExtCellPage.sbr"
	-@erase "$(INTDIR)\EsmFaction.obj"
	-@erase "$(INTDIR)\EsmFaction.sbr"
	-@erase "$(INTDIR)\EsmFactionDlg.obj"
	-@erase "$(INTDIR)\EsmFactionDlg.sbr"
	-@erase "$(INTDIR)\EsmFile.obj"
	-@erase "$(INTDIR)\EsmFile.sbr"
	-@erase "$(INTDIR)\EsmFindDlg.obj"
	-@erase "$(INTDIR)\EsmFindDlg.sbr"
	-@erase "$(INTDIR)\EsmFuncHelpView.obj"
	-@erase "$(INTDIR)\EsmFuncHelpView.sbr"
	-@erase "$(INTDIR)\EsmGameSetting.obj"
	-@erase "$(INTDIR)\EsmGameSetting.sbr"
	-@erase "$(INTDIR)\EsmGlobal.obj"
	-@erase "$(INTDIR)\EsmGlobal.sbr"
	-@erase "$(INTDIR)\EsmGlobalDlg.obj"
	-@erase "$(INTDIR)\EsmGlobalDlg.sbr"
	-@erase "$(INTDIR)\EsmGlobOptions.obj"
	-@erase "$(INTDIR)\EsmGlobOptions.sbr"
	-@erase "$(INTDIR)\EsmHeaderDlg.obj"
	-@erase "$(INTDIR)\EsmHeaderDlg.sbr"
	-@erase "$(INTDIR)\EsmIconFrame.obj"
	-@erase "$(INTDIR)\EsmIconFrame.sbr"
	-@erase "$(INTDIR)\EsmInfo.obj"
	-@erase "$(INTDIR)\EsmInfo.sbr"
	-@erase "$(INTDIR)\EsmInfoDlg.obj"
	-@erase "$(INTDIR)\EsmInfoDlg.sbr"
	-@erase "$(INTDIR)\EsmIngrediant.obj"
	-@erase "$(INTDIR)\EsmIngrediant.sbr"
	-@erase "$(INTDIR)\EsmIngrediantDlg.obj"
	-@erase "$(INTDIR)\EsmIngrediantDlg.sbr"
	-@erase "$(INTDIR)\EsmIntCellPage.obj"
	-@erase "$(INTDIR)\EsmIntCellPage.sbr"
	-@erase "$(INTDIR)\EsmItem1.obj"
	-@erase "$(INTDIR)\EsmItem1.sbr"
	-@erase "$(INTDIR)\EsmItem2.obj"
	-@erase "$(INTDIR)\EsmItem2.sbr"
	-@erase "$(INTDIR)\EsmItem3.obj"
	-@erase "$(INTDIR)\EsmItem3.sbr"
	-@erase "$(INTDIR)\EsmJournalDlg.obj"
	-@erase "$(INTDIR)\EsmJournalDlg.sbr"
	-@erase "$(INTDIR)\EsmLand.obj"
	-@erase "$(INTDIR)\EsmLand.sbr"
	-@erase "$(INTDIR)\EsmLevelCrea.obj"
	-@erase "$(INTDIR)\EsmLevelCrea.sbr"
	-@erase "$(INTDIR)\EsmLevelCreaDlg.obj"
	-@erase "$(INTDIR)\EsmLevelCreaDlg.sbr"
	-@erase "$(INTDIR)\EsmLevelItem.obj"
	-@erase "$(INTDIR)\EsmLevelItem.sbr"
	-@erase "$(INTDIR)\EsmLevelItemDlg.obj"
	-@erase "$(INTDIR)\EsmLevelItemDlg.sbr"
	-@erase "$(INTDIR)\EsmLight.obj"
	-@erase "$(INTDIR)\EsmLight.sbr"
	-@erase "$(INTDIR)\EsmLightDlg.obj"
	-@erase "$(INTDIR)\EsmLightDlg.sbr"
	-@erase "$(INTDIR)\EsmListCtrl.obj"
	-@erase "$(INTDIR)\EsmListCtrl.sbr"
	-@erase "$(INTDIR)\EsmLoadDlg.obj"
	-@erase "$(INTDIR)\EsmLoadDlg.sbr"
	-@erase "$(INTDIR)\EsmLockPick.obj"
	-@erase "$(INTDIR)\EsmLockPick.sbr"
	-@erase "$(INTDIR)\EsmLockPickDlg.obj"
	-@erase "$(INTDIR)\EsmLockPickDlg.sbr"
	-@erase "$(INTDIR)\EsmMagicEffect.obj"
	-@erase "$(INTDIR)\EsmMagicEffect.sbr"
	-@erase "$(INTDIR)\EsmMisc.obj"
	-@erase "$(INTDIR)\EsmMisc.sbr"
	-@erase "$(INTDIR)\EsmMiscDlg.obj"
	-@erase "$(INTDIR)\EsmMiscDlg.sbr"
	-@erase "$(INTDIR)\EsmNpc.obj"
	-@erase "$(INTDIR)\EsmNpc.sbr"
	-@erase "$(INTDIR)\EsmNpcDlg.obj"
	-@erase "$(INTDIR)\EsmNpcDlg.sbr"
	-@erase "$(INTDIR)\EsmNpcPage1.obj"
	-@erase "$(INTDIR)\EsmNpcPage1.sbr"
	-@erase "$(INTDIR)\EsmNpcPage2.obj"
	-@erase "$(INTDIR)\EsmNpcPage2.sbr"
	-@erase "$(INTDIR)\EsmNpcPage3.obj"
	-@erase "$(INTDIR)\EsmNpcPage3.sbr"
	-@erase "$(INTDIR)\EsmNpcPage4.obj"
	-@erase "$(INTDIR)\EsmNpcPage4.sbr"
	-@erase "$(INTDIR)\EsmNpcPage5.obj"
	-@erase "$(INTDIR)\EsmNpcPage5.sbr"
	-@erase "$(INTDIR)\EsmOptions.obj"
	-@erase "$(INTDIR)\EsmOptions.sbr"
	-@erase "$(INTDIR)\EsmOptionsDlg.obj"
	-@erase "$(INTDIR)\EsmOptionsDlg.sbr"
	-@erase "$(INTDIR)\EsmProbe.obj"
	-@erase "$(INTDIR)\EsmProbe.sbr"
	-@erase "$(INTDIR)\EsmProbeDlg.obj"
	-@erase "$(INTDIR)\EsmProbeDlg.sbr"
	-@erase "$(INTDIR)\EsmRace.obj"
	-@erase "$(INTDIR)\EsmRace.sbr"
	-@erase "$(INTDIR)\EsmRaceDlg.obj"
	-@erase "$(INTDIR)\EsmRaceDlg.sbr"
	-@erase "$(INTDIR)\EsmRecDialog.obj"
	-@erase "$(INTDIR)\EsmRecDialog.sbr"
	-@erase "$(INTDIR)\EsmRecord.obj"
	-@erase "$(INTDIR)\EsmRecord.sbr"
	-@erase "$(INTDIR)\EsmRefCellPage.obj"
	-@erase "$(INTDIR)\EsmRefCellPage.sbr"
	-@erase "$(INTDIR)\EsmRegion.obj"
	-@erase "$(INTDIR)\EsmRegion.sbr"
	-@erase "$(INTDIR)\EsmRegionDlg.obj"
	-@erase "$(INTDIR)\EsmRegionDlg.sbr"
	-@erase "$(INTDIR)\EsmRepair.obj"
	-@erase "$(INTDIR)\EsmRepair.sbr"
	-@erase "$(INTDIR)\EsmRepairDlg.obj"
	-@erase "$(INTDIR)\EsmRepairDlg.sbr"
	-@erase "$(INTDIR)\EsmScrFuncArray.obj"
	-@erase "$(INTDIR)\EsmScrFuncArray.sbr"
	-@erase "$(INTDIR)\EsmScrFuncData.obj"
	-@erase "$(INTDIR)\EsmScrFuncData.sbr"
	-@erase "$(INTDIR)\EsmScript.obj"
	-@erase "$(INTDIR)\EsmScript.sbr"
	-@erase "$(INTDIR)\EsmScriptCompile.obj"
	-@erase "$(INTDIR)\EsmScriptCompile.sbr"
	-@erase "$(INTDIR)\EsmScriptDefs.obj"
	-@erase "$(INTDIR)\EsmScriptDefs.sbr"
	-@erase "$(INTDIR)\EsmScriptDlg.obj"
	-@erase "$(INTDIR)\EsmScriptDlg.sbr"
	-@erase "$(INTDIR)\EsmScriptError.obj"
	-@erase "$(INTDIR)\EsmScriptError.sbr"
	-@erase "$(INTDIR)\EsmScriptFuncs.obj"
	-@erase "$(INTDIR)\EsmScriptFuncs.sbr"
	-@erase "$(INTDIR)\EsmScriptOptions.obj"
	-@erase "$(INTDIR)\EsmScriptOptions.sbr"
	-@erase "$(INTDIR)\EsmScrTempPage1.obj"
	-@erase "$(INTDIR)\EsmScrTempPage1.sbr"
	-@erase "$(INTDIR)\EsmScrTempPage2.obj"
	-@erase "$(INTDIR)\EsmScrTempPage2.sbr"
	-@erase "$(INTDIR)\EsmScrTempPage3.obj"
	-@erase "$(INTDIR)\EsmScrTempPage3.sbr"
	-@erase "$(INTDIR)\EsmScrTempView.obj"
	-@erase "$(INTDIR)\EsmScrTempView.sbr"
	-@erase "$(INTDIR)\EsmSettingDlg.obj"
	-@erase "$(INTDIR)\EsmSettingDlg.sbr"
	-@erase "$(INTDIR)\EsmSkill.obj"
	-@erase "$(INTDIR)\EsmSkill.sbr"
	-@erase "$(INTDIR)\EsmSkillDlg.obj"
	-@erase "$(INTDIR)\EsmSkillDlg.sbr"
	-@erase "$(INTDIR)\EsmSound.obj"
	-@erase "$(INTDIR)\EsmSound.sbr"
	-@erase "$(INTDIR)\EsmSoundDlg.obj"
	-@erase "$(INTDIR)\EsmSoundDlg.sbr"
	-@erase "$(INTDIR)\EsmSoundGen.obj"
	-@erase "$(INTDIR)\EsmSoundGen.sbr"
	-@erase "$(INTDIR)\EsmSoundGenDlg.obj"
	-@erase "$(INTDIR)\EsmSoundGenDlg.sbr"
	-@erase "$(INTDIR)\EsmSpell.obj"
	-@erase "$(INTDIR)\EsmSpell.sbr"
	-@erase "$(INTDIR)\EsmSpellDlg.obj"
	-@erase "$(INTDIR)\EsmSpellDlg.sbr"
	-@erase "$(INTDIR)\EsmStartScript.obj"
	-@erase "$(INTDIR)\EsmStartScript.sbr"
	-@erase "$(INTDIR)\EsmStartScriptDlg.obj"
	-@erase "$(INTDIR)\EsmStartScriptDlg.sbr"
	-@erase "$(INTDIR)\EsmStatic.obj"
	-@erase "$(INTDIR)\EsmStatic.sbr"
	-@erase "$(INTDIR)\EsmStaticDlg.obj"
	-@erase "$(INTDIR)\EsmStaticDlg.sbr"
	-@erase "$(INTDIR)\EsmSubBase.obj"
	-@erase "$(INTDIR)\EsmSubBase.sbr"
	-@erase "$(INTDIR)\EsmSubCellRef.obj"
	-@erase "$(INTDIR)\EsmSubCellRef.sbr"
	-@erase "$(INTDIR)\EsmSubListCtrl.obj"
	-@erase "$(INTDIR)\EsmSubListCtrl.sbr"
	-@erase "$(INTDIR)\EsmSubName.obj"
	-@erase "$(INTDIR)\EsmSubName.sbr"
	-@erase "$(INTDIR)\EsmSubSCVR.obj"
	-@erase "$(INTDIR)\EsmSubSCVR.sbr"
	-@erase "$(INTDIR)\EsmTES3.obj"
	-@erase "$(INTDIR)\EsmTES3.sbr"
	-@erase "$(INTDIR)\EsmUsesDlg.obj"
	-@erase "$(INTDIR)\EsmUsesDlg.sbr"
	-@erase "$(INTDIR)\EsmUtils.obj"
	-@erase "$(INTDIR)\EsmUtils.sbr"
	-@erase "$(INTDIR)\EsmWeapon.obj"
	-@erase "$(INTDIR)\EsmWeapon.sbr"
	-@erase "$(INTDIR)\EsmWeaponDlg.obj"
	-@erase "$(INTDIR)\EsmWeaponDlg.sbr"
	-@erase "$(INTDIR)\genfile.obj"
	-@erase "$(INTDIR)\genfile.sbr"
	-@erase "$(INTDIR)\genfind.obj"
	-@erase "$(INTDIR)\genfind.sbr"
	-@erase "$(INTDIR)\GenStack.obj"
	-@erase "$(INTDIR)\GenStack.sbr"
	-@erase "$(INTDIR)\il_alloc.obj"
	-@erase "$(INTDIR)\il_alloc.sbr"
	-@erase "$(INTDIR)\il_bits.obj"
	-@erase "$(INTDIR)\il_bits.sbr"
	-@erase "$(INTDIR)\il_bmp.obj"
	-@erase "$(INTDIR)\il_bmp.sbr"
	-@erase "$(INTDIR)\il_convbuff.obj"
	-@erase "$(INTDIR)\il_convbuff.sbr"
	-@erase "$(INTDIR)\il_convert.obj"
	-@erase "$(INTDIR)\il_convert.sbr"
	-@erase "$(INTDIR)\il_cut.obj"
	-@erase "$(INTDIR)\il_cut.sbr"
	-@erase "$(INTDIR)\il_dcx.obj"
	-@erase "$(INTDIR)\il_dcx.sbr"
	-@erase "$(INTDIR)\il_dds-save.obj"
	-@erase "$(INTDIR)\il_dds-save.sbr"
	-@erase "$(INTDIR)\il_dds.obj"
	-@erase "$(INTDIR)\il_dds.sbr"
	-@erase "$(INTDIR)\il_devil.obj"
	-@erase "$(INTDIR)\il_devil.sbr"
	-@erase "$(INTDIR)\il_doom.obj"
	-@erase "$(INTDIR)\il_doom.sbr"
	-@erase "$(INTDIR)\il_endian.obj"
	-@erase "$(INTDIR)\il_endian.sbr"
	-@erase "$(INTDIR)\il_error.obj"
	-@erase "$(INTDIR)\il_error.sbr"
	-@erase "$(INTDIR)\il_fastconv.obj"
	-@erase "$(INTDIR)\il_fastconv.sbr"
	-@erase "$(INTDIR)\il_files.obj"
	-@erase "$(INTDIR)\il_files.sbr"
	-@erase "$(INTDIR)\il_gif.obj"
	-@erase "$(INTDIR)\il_gif.sbr"
	-@erase "$(INTDIR)\il_header.obj"
	-@erase "$(INTDIR)\il_header.sbr"
	-@erase "$(INTDIR)\il_icon.obj"
	-@erase "$(INTDIR)\il_icon.sbr"
	-@erase "$(INTDIR)\il_internal.obj"
	-@erase "$(INTDIR)\il_internal.sbr"
	-@erase "$(INTDIR)\il_io.obj"
	-@erase "$(INTDIR)\il_io.sbr"
	-@erase "$(INTDIR)\il_jpeg.obj"
	-@erase "$(INTDIR)\il_jpeg.sbr"
	-@erase "$(INTDIR)\il_lif.obj"
	-@erase "$(INTDIR)\il_lif.sbr"
	-@erase "$(INTDIR)\il_main.obj"
	-@erase "$(INTDIR)\il_main.sbr"
	-@erase "$(INTDIR)\il_manip.obj"
	-@erase "$(INTDIR)\il_manip.sbr"
	-@erase "$(INTDIR)\il_mdl.obj"
	-@erase "$(INTDIR)\il_mdl.sbr"
	-@erase "$(INTDIR)\il_mng.obj"
	-@erase "$(INTDIR)\il_mng.sbr"
	-@erase "$(INTDIR)\il_neuquant.obj"
	-@erase "$(INTDIR)\il_neuquant.sbr"
	-@erase "$(INTDIR)\il_pal.obj"
	-@erase "$(INTDIR)\il_pal.sbr"
	-@erase "$(INTDIR)\il_pcd.obj"
	-@erase "$(INTDIR)\il_pcd.sbr"
	-@erase "$(INTDIR)\il_pcx.obj"
	-@erase "$(INTDIR)\il_pcx.sbr"
	-@erase "$(INTDIR)\il_pic.obj"
	-@erase "$(INTDIR)\il_pic.sbr"
	-@erase "$(INTDIR)\il_pix.obj"
	-@erase "$(INTDIR)\il_pix.sbr"
	-@erase "$(INTDIR)\il_png.obj"
	-@erase "$(INTDIR)\il_png.sbr"
	-@erase "$(INTDIR)\il_pnm.obj"
	-@erase "$(INTDIR)\il_pnm.sbr"
	-@erase "$(INTDIR)\il_profiles.obj"
	-@erase "$(INTDIR)\il_profiles.sbr"
	-@erase "$(INTDIR)\il_psd.obj"
	-@erase "$(INTDIR)\il_psd.sbr"
	-@erase "$(INTDIR)\il_psp.obj"
	-@erase "$(INTDIR)\il_psp.sbr"
	-@erase "$(INTDIR)\il_pxr.obj"
	-@erase "$(INTDIR)\il_pxr.sbr"
	-@erase "$(INTDIR)\il_quantizer.obj"
	-@erase "$(INTDIR)\il_quantizer.sbr"
	-@erase "$(INTDIR)\il_raw.obj"
	-@erase "$(INTDIR)\il_raw.sbr"
	-@erase "$(INTDIR)\il_rawdata.obj"
	-@erase "$(INTDIR)\il_rawdata.sbr"
	-@erase "$(INTDIR)\il_register.obj"
	-@erase "$(INTDIR)\il_register.sbr"
	-@erase "$(INTDIR)\il_rle.obj"
	-@erase "$(INTDIR)\il_rle.sbr"
	-@erase "$(INTDIR)\il_sgi.obj"
	-@erase "$(INTDIR)\il_sgi.sbr"
	-@erase "$(INTDIR)\il_stack.obj"
	-@erase "$(INTDIR)\il_stack.sbr"
	-@erase "$(INTDIR)\il_states.obj"
	-@erase "$(INTDIR)\il_states.sbr"
	-@erase "$(INTDIR)\il_targa.obj"
	-@erase "$(INTDIR)\il_targa.sbr"
	-@erase "$(INTDIR)\il_tiff.obj"
	-@erase "$(INTDIR)\il_tiff.sbr"
	-@erase "$(INTDIR)\il_utility.obj"
	-@erase "$(INTDIR)\il_utility.sbr"
	-@erase "$(INTDIR)\il_wal.obj"
	-@erase "$(INTDIR)\il_wal.sbr"
	-@erase "$(INTDIR)\il_xpm.obj"
	-@erase "$(INTDIR)\il_xpm.sbr"
	-@erase "$(INTDIR)\ilu_alloc.obj"
	-@erase "$(INTDIR)\ilu_alloc.sbr"
	-@erase "$(INTDIR)\ilu_error.obj"
	-@erase "$(INTDIR)\ilu_error.sbr"
	-@erase "$(INTDIR)\ilu_filter.obj"
	-@erase "$(INTDIR)\ilu_filter.sbr"
	-@erase "$(INTDIR)\ilu_filter_rcg.obj"
	-@erase "$(INTDIR)\ilu_filter_rcg.sbr"
	-@erase "$(INTDIR)\ilu_internal.obj"
	-@erase "$(INTDIR)\ilu_internal.sbr"
	-@erase "$(INTDIR)\ilu_main.obj"
	-@erase "$(INTDIR)\ilu_main.sbr"
	-@erase "$(INTDIR)\ilu_manip.obj"
	-@erase "$(INTDIR)\ilu_manip.sbr"
	-@erase "$(INTDIR)\ilu_mipmap.obj"
	-@erase "$(INTDIR)\ilu_mipmap.sbr"
	-@erase "$(INTDIR)\ilu_noise.obj"
	-@erase "$(INTDIR)\ilu_noise.sbr"
	-@erase "$(INTDIR)\ilu_region.obj"
	-@erase "$(INTDIR)\ilu_region.sbr"
	-@erase "$(INTDIR)\ilu_rotate.obj"
	-@erase "$(INTDIR)\ilu_rotate.sbr"
	-@erase "$(INTDIR)\ilu_scale.obj"
	-@erase "$(INTDIR)\ilu_scale.sbr"
	-@erase "$(INTDIR)\ilu_scale2d.obj"
	-@erase "$(INTDIR)\ilu_scale2d.sbr"
	-@erase "$(INTDIR)\ilu_scale3d.obj"
	-@erase "$(INTDIR)\ilu_scale3d.sbr"
	-@erase "$(INTDIR)\ilu_scaling.obj"
	-@erase "$(INTDIR)\ilu_scaling.sbr"
	-@erase "$(INTDIR)\ilu_states.obj"
	-@erase "$(INTDIR)\ilu_states.sbr"
	-@erase "$(INTDIR)\ilu_utilities.obj"
	-@erase "$(INTDIR)\ilu_utilities.sbr"
	-@erase "$(INTDIR)\ilut_allegro.obj"
	-@erase "$(INTDIR)\ilut_allegro.sbr"
	-@erase "$(INTDIR)\ilut_directx.obj"
	-@erase "$(INTDIR)\ilut_directx.sbr"
	-@erase "$(INTDIR)\ilut_internal.obj"
	-@erase "$(INTDIR)\ilut_internal.sbr"
	-@erase "$(INTDIR)\ilut_main.obj"
	-@erase "$(INTDIR)\ilut_main.sbr"
	-@erase "$(INTDIR)\ilut_opengl.obj"
	-@erase "$(INTDIR)\ilut_opengl.sbr"
	-@erase "$(INTDIR)\ilut_sdlsurface.obj"
	-@erase "$(INTDIR)\ilut_sdlsurface.sbr"
	-@erase "$(INTDIR)\ilut_states.obj"
	-@erase "$(INTDIR)\ilut_states.sbr"
	-@erase "$(INTDIR)\ilut_win32.obj"
	-@erase "$(INTDIR)\ilut_win32.sbr"
	-@erase "$(INTDIR)\InputDialog.obj"
	-@erase "$(INTDIR)\InputDialog.sbr"
	-@erase "$(INTDIR)\MainFrm.obj"
	-@erase "$(INTDIR)\MainFrm.sbr"
	-@erase "$(INTDIR)\mwcommon.obj"
	-@erase "$(INTDIR)\mwcommon.sbr"
	-@erase "$(INTDIR)\MWEdit.obj"
	-@erase "$(INTDIR)\MWEdit.pch"
	-@erase "$(INTDIR)\MWEdit.res"
	-@erase "$(INTDIR)\MWEdit.sbr"
	-@erase "$(INTDIR)\MWEditDoc.obj"
	-@erase "$(INTDIR)\MWEditDoc.sbr"
	-@erase "$(INTDIR)\MWEditView.obj"
	-@erase "$(INTDIR)\MWEditView.sbr"
	-@erase "$(INTDIR)\namelist.obj"
	-@erase "$(INTDIR)\namelist.sbr"
	-@erase "$(INTDIR)\OpenPluginDlg.obj"
	-@erase "$(INTDIR)\OpenPluginDlg.sbr"
	-@erase "$(INTDIR)\ptrarray.obj"
	-@erase "$(INTDIR)\ptrarray.sbr"
	-@erase "$(INTDIR)\ScriptErrorDlg.obj"
	-@erase "$(INTDIR)\ScriptErrorDlg.sbr"
	-@erase "$(INTDIR)\ScriptErrorView.obj"
	-@erase "$(INTDIR)\ScriptErrorView.sbr"
	-@erase "$(INTDIR)\ScriptTemplate.obj"
	-@erase "$(INTDIR)\ScriptTemplate.sbr"
	-@erase "$(INTDIR)\SString.obj"
	-@erase "$(INTDIR)\SString.sbr"
	-@erase "$(INTDIR)\StdAfx.obj"
	-@erase "$(INTDIR)\StdAfx.sbr"
	-@erase "$(INTDIR)\TabCtrlSheet.obj"
	-@erase "$(INTDIR)\TabCtrlSheet.sbr"
	-@erase "$(INTDIR)\temarray.obj"
	-@erase "$(INTDIR)\temarray.sbr"
	-@erase "$(INTDIR)\tstfile.obj"
	-@erase "$(INTDIR)\tstfile.sbr"
	-@erase "$(INTDIR)\vc60.idb"
	-@erase "$(INTDIR)\WinUtil.obj"
	-@erase "$(INTDIR)\WinUtil.sbr"
	-@erase "$(OUTDIR)\MWEdit.bsc"
	-@erase "$(OUTDIR)\MWEdit.exe"
	-@erase ".\Release\MWEdit.cnt"
	-@erase ".\Release\MWEdit.hlp"

"$(OUTDIR)" :
    if not exist "$(OUTDIR)/$(NULL)" mkdir "$(OUTDIR)"

CPP=cl.exe
CPP_PROJ=/nologo /MD /W3 /GX /O2 /I "d:\vcsource\esp\morrow\mwedit" /D "NDEBUG" /D "WIN32" /D "_WINDOWS" /D "_AFXDLL" /D "_MBCS" /D "NODEVILLIB" /FR"$(INTDIR)\\" /Fp"$(INTDIR)\MWEdit.pch" /Yu"stdafx.h" /Fo"$(INTDIR)\\" /Fd"$(INTDIR)\\" /FD /c 

.c{$(INTDIR)}.obj::
   $(CPP) @<<
   $(CPP_PROJ) $< 
<<

.cpp{$(INTDIR)}.obj::
   $(CPP) @<<
   $(CPP_PROJ) $< 
<<

.cxx{$(INTDIR)}.obj::
   $(CPP) @<<
   $(CPP_PROJ) $< 
<<

.c{$(INTDIR)}.sbr::
   $(CPP) @<<
   $(CPP_PROJ) $< 
<<

.cpp{$(INTDIR)}.sbr::
   $(CPP) @<<
   $(CPP_PROJ) $< 
<<

.cxx{$(INTDIR)}.sbr::
   $(CPP) @<<
   $(CPP_PROJ) $< 
<<

MTL=midl.exe
MTL_PROJ=/nologo /D "NDEBUG" /mktyplib203 /win32 
RSC=rc.exe
RSC_PROJ=/l 0x1009 /fo"$(INTDIR)\MWEdit.res" /d "NDEBUG" /d "_AFXDLL" 
BSC32=bscmake.exe
BSC32_FLAGS=/nologo /o"$(OUTDIR)\MWEdit.bsc" 
BSC32_SBRS= \
	"$(INTDIR)\ActivatorDlg.sbr" \
	"$(INTDIR)\EsmAiActivateDlg.sbr" \
	"$(INTDIR)\EsmAiEscortDlg.sbr" \
	"$(INTDIR)\EsmAiTravelDlg.sbr" \
	"$(INTDIR)\EsmAiWanderDlg.sbr" \
	"$(INTDIR)\EsmAlchemyDlg.sbr" \
	"$(INTDIR)\EsmApparatusDlg.sbr" \
	"$(INTDIR)\EsmArmorDlg.sbr" \
	"$(INTDIR)\EsmBirthSignDlg.sbr" \
	"$(INTDIR)\EsmBodyPartDlg.sbr" \
	"$(INTDIR)\EsmBookDlg.sbr" \
	"$(INTDIR)\EsmClassDlg.sbr" \
	"$(INTDIR)\EsmClothingDlg.sbr" \
	"$(INTDIR)\EsmContainDlg.sbr" \
	"$(INTDIR)\EsmDialogDlg.sbr" \
	"$(INTDIR)\EsmDoorDlg.sbr" \
	"$(INTDIR)\EsmEffectDlg.sbr" \
	"$(INTDIR)\EsmEnchantDlg.sbr" \
	"$(INTDIR)\EsmFactionDlg.sbr" \
	"$(INTDIR)\EsmGlobalDlg.sbr" \
	"$(INTDIR)\EsmInfoDlg.sbr" \
	"$(INTDIR)\EsmIngrediantDlg.sbr" \
	"$(INTDIR)\EsmJournalDlg.sbr" \
	"$(INTDIR)\EsmLevelCreaDlg.sbr" \
	"$(INTDIR)\EsmLevelItemDlg.sbr" \
	"$(INTDIR)\EsmLightDlg.sbr" \
	"$(INTDIR)\EsmLockPickDlg.sbr" \
	"$(INTDIR)\EsmMiscDlg.sbr" \
	"$(INTDIR)\EsmProbeDlg.sbr" \
	"$(INTDIR)\EsmRaceDlg.sbr" \
	"$(INTDIR)\EsmRegionDlg.sbr" \
	"$(INTDIR)\EsmRepairDlg.sbr" \
	"$(INTDIR)\EsmSettingDlg.sbr" \
	"$(INTDIR)\EsmSkillDlg.sbr" \
	"$(INTDIR)\EsmSoundDlg.sbr" \
	"$(INTDIR)\EsmSoundGenDlg.sbr" \
	"$(INTDIR)\EsmSpellDlg.sbr" \
	"$(INTDIR)\EsmStartScriptDlg.sbr" \
	"$(INTDIR)\EsmStaticDlg.sbr" \
	"$(INTDIR)\EsmWeaponDlg.sbr" \
	"$(INTDIR)\CreaturePage1.sbr" \
	"$(INTDIR)\CreaturePage2.sbr" \
	"$(INTDIR)\EsmCreatureDlg.sbr" \
	"$(INTDIR)\EsmCreaturePage1.sbr" \
	"$(INTDIR)\EsmCreaturePage2.sbr" \
	"$(INTDIR)\EsmCreaturePage3.sbr" \
	"$(INTDIR)\EsmCreaturePage4.sbr" \
	"$(INTDIR)\EsmCreaturePage5.sbr" \
	"$(INTDIR)\EsmCellDlg.sbr" \
	"$(INTDIR)\EsmCellRefDlg.sbr" \
	"$(INTDIR)\EsmExtCellPage.sbr" \
	"$(INTDIR)\EsmIntCellPage.sbr" \
	"$(INTDIR)\EsmRefCellPage.sbr" \
	"$(INTDIR)\ChildFrmScript.sbr" \
	"$(INTDIR)\EsmFuncHelpView.sbr" \
	"$(INTDIR)\EsmScriptDlg.sbr" \
	"$(INTDIR)\ScriptErrorDlg.sbr" \
	"$(INTDIR)\ScriptErrorView.sbr" \
	"$(INTDIR)\EsmNpcDlg.sbr" \
	"$(INTDIR)\EsmNpcPage1.sbr" \
	"$(INTDIR)\EsmNpcPage2.sbr" \
	"$(INTDIR)\EsmNpcPage3.sbr" \
	"$(INTDIR)\EsmNpcPage4.sbr" \
	"$(INTDIR)\EsmNpcPage5.sbr" \
	"$(INTDIR)\EsmDlgArray.sbr" \
	"$(INTDIR)\EsmRecDialog.sbr" \
	"$(INTDIR)\ChildFrm.sbr" \
	"$(INTDIR)\ChildFrmFix.sbr" \
	"$(INTDIR)\ChildFrmVar.sbr" \
	"$(INTDIR)\MainFrm.sbr" \
	"$(INTDIR)\ColorStatic1.sbr" \
	"$(INTDIR)\CustRichEdit.sbr" \
	"$(INTDIR)\EsmIconFrame.sbr" \
	"$(INTDIR)\EsmListCtrl.sbr" \
	"$(INTDIR)\EsmSubListCtrl.sbr" \
	"$(INTDIR)\InputDialog.sbr" \
	"$(INTDIR)\EsmScrTempPage1.sbr" \
	"$(INTDIR)\EsmScrTempPage2.sbr" \
	"$(INTDIR)\EsmScrTempPage3.sbr" \
	"$(INTDIR)\EsmScrTempView.sbr" \
	"$(INTDIR)\ScriptTemplate.sbr" \
	"$(INTDIR)\EsmCsvImportDlg.sbr" \
	"$(INTDIR)\EsmFindDlg.sbr" \
	"$(INTDIR)\EsmHeaderDlg.sbr" \
	"$(INTDIR)\EsmLoadDlg.sbr" \
	"$(INTDIR)\EsmOptionsDlg.sbr" \
	"$(INTDIR)\EsmUsesDlg.sbr" \
	"$(INTDIR)\MWEditView.sbr" \
	"$(INTDIR)\OpenPluginDlg.sbr" \
	"$(INTDIR)\StdAfx.sbr" \
	"$(INTDIR)\csvfile.sbr" \
	"$(INTDIR)\dl_base.sbr" \
	"$(INTDIR)\dl_block.sbr" \
	"$(INTDIR)\dl_chr.sbr" \
	"$(INTDIR)\dl_err.sbr" \
	"$(INTDIR)\dl_file.sbr" \
	"$(INTDIR)\dl_log.sbr" \
	"$(INTDIR)\dl_math.sbr" \
	"$(INTDIR)\dl_mem.sbr" \
	"$(INTDIR)\dl_str.sbr" \
	"$(INTDIR)\dl_time.sbr" \
	"$(INTDIR)\dl_ToolTip.sbr" \
	"$(INTDIR)\genfile.sbr" \
	"$(INTDIR)\genfind.sbr" \
	"$(INTDIR)\GenStack.sbr" \
	"$(INTDIR)\mwcommon.sbr" \
	"$(INTDIR)\namelist.sbr" \
	"$(INTDIR)\ptrarray.sbr" \
	"$(INTDIR)\SString.sbr" \
	"$(INTDIR)\TabCtrlSheet.sbr" \
	"$(INTDIR)\temarray.sbr" \
	"$(INTDIR)\tstfile.sbr" \
	"$(INTDIR)\WinUtil.sbr" \
	"$(INTDIR)\EsmActivator.sbr" \
	"$(INTDIR)\EsmAlchemy.sbr" \
	"$(INTDIR)\EsmApparatus.sbr" \
	"$(INTDIR)\EsmArmor.sbr" \
	"$(INTDIR)\EsmBirthSign.sbr" \
	"$(INTDIR)\EsmBodyPart.sbr" \
	"$(INTDIR)\EsmBook.sbr" \
	"$(INTDIR)\EsmCell.sbr" \
	"$(INTDIR)\EsmClass.sbr" \
	"$(INTDIR)\EsmClothing.sbr" \
	"$(INTDIR)\EsmContainer.sbr" \
	"$(INTDIR)\EsmCreature.sbr" \
	"$(INTDIR)\EsmDialogue.sbr" \
	"$(INTDIR)\EsmDoor.sbr" \
	"$(INTDIR)\EsmEnchant.sbr" \
	"$(INTDIR)\EsmFaction.sbr" \
	"$(INTDIR)\EsmGameSetting.sbr" \
	"$(INTDIR)\EsmGlobal.sbr" \
	"$(INTDIR)\EsmInfo.sbr" \
	"$(INTDIR)\EsmIngrediant.sbr" \
	"$(INTDIR)\EsmItem1.sbr" \
	"$(INTDIR)\EsmItem2.sbr" \
	"$(INTDIR)\EsmItem3.sbr" \
	"$(INTDIR)\EsmLand.sbr" \
	"$(INTDIR)\EsmLevelCrea.sbr" \
	"$(INTDIR)\EsmLevelItem.sbr" \
	"$(INTDIR)\EsmLight.sbr" \
	"$(INTDIR)\EsmLockPick.sbr" \
	"$(INTDIR)\EsmMagicEffect.sbr" \
	"$(INTDIR)\EsmMisc.sbr" \
	"$(INTDIR)\EsmNpc.sbr" \
	"$(INTDIR)\EsmProbe.sbr" \
	"$(INTDIR)\EsmRace.sbr" \
	"$(INTDIR)\EsmRecord.sbr" \
	"$(INTDIR)\EsmRegion.sbr" \
	"$(INTDIR)\EsmRepair.sbr" \
	"$(INTDIR)\EsmScript.sbr" \
	"$(INTDIR)\EsmSkill.sbr" \
	"$(INTDIR)\EsmSound.sbr" \
	"$(INTDIR)\EsmSoundGen.sbr" \
	"$(INTDIR)\EsmSpell.sbr" \
	"$(INTDIR)\EsmStartScript.sbr" \
	"$(INTDIR)\EsmStatic.sbr" \
	"$(INTDIR)\EsmTES3.sbr" \
	"$(INTDIR)\EsmWeapon.sbr" \
	"$(INTDIR)\EsmSubBase.sbr" \
	"$(INTDIR)\EsmSubCellRef.sbr" \
	"$(INTDIR)\EsmSubName.sbr" \
	"$(INTDIR)\EsmSubSCVR.sbr" \
	"$(INTDIR)\EsmScrFuncArray.sbr" \
	"$(INTDIR)\EsmScrFuncData.sbr" \
	"$(INTDIR)\EsmScriptCompile.sbr" \
	"$(INTDIR)\EsmScriptDefs.sbr" \
	"$(INTDIR)\EsmScriptError.sbr" \
	"$(INTDIR)\EsmScriptFuncs.sbr" \
	"$(INTDIR)\EsmScriptOptions.sbr" \
	"$(INTDIR)\EsmBase.sbr" \
	"$(INTDIR)\EsmCsvDefs.sbr" \
	"$(INTDIR)\EsmFile.sbr" \
	"$(INTDIR)\EsmGlobOptions.sbr" \
	"$(INTDIR)\EsmOptions.sbr" \
	"$(INTDIR)\EsmUtils.sbr" \
	"$(INTDIR)\il_alloc.sbr" \
	"$(INTDIR)\il_bits.sbr" \
	"$(INTDIR)\il_bmp.sbr" \
	"$(INTDIR)\il_convbuff.sbr" \
	"$(INTDIR)\il_convert.sbr" \
	"$(INTDIR)\il_cut.sbr" \
	"$(INTDIR)\il_dcx.sbr" \
	"$(INTDIR)\il_dds-save.sbr" \
	"$(INTDIR)\il_dds.sbr" \
	"$(INTDIR)\il_devil.sbr" \
	"$(INTDIR)\il_doom.sbr" \
	"$(INTDIR)\il_endian.sbr" \
	"$(INTDIR)\il_error.sbr" \
	"$(INTDIR)\il_fastconv.sbr" \
	"$(INTDIR)\il_files.sbr" \
	"$(INTDIR)\il_gif.sbr" \
	"$(INTDIR)\il_header.sbr" \
	"$(INTDIR)\il_icon.sbr" \
	"$(INTDIR)\il_internal.sbr" \
	"$(INTDIR)\il_io.sbr" \
	"$(INTDIR)\il_jpeg.sbr" \
	"$(INTDIR)\il_lif.sbr" \
	"$(INTDIR)\il_main.sbr" \
	"$(INTDIR)\il_manip.sbr" \
	"$(INTDIR)\il_mdl.sbr" \
	"$(INTDIR)\il_mng.sbr" \
	"$(INTDIR)\il_neuquant.sbr" \
	"$(INTDIR)\il_pal.sbr" \
	"$(INTDIR)\il_pcd.sbr" \
	"$(INTDIR)\il_pcx.sbr" \
	"$(INTDIR)\il_pic.sbr" \
	"$(INTDIR)\il_pix.sbr" \
	"$(INTDIR)\il_png.sbr" \
	"$(INTDIR)\il_pnm.sbr" \
	"$(INTDIR)\il_profiles.sbr" \
	"$(INTDIR)\il_psd.sbr" \
	"$(INTDIR)\il_psp.sbr" \
	"$(INTDIR)\il_pxr.sbr" \
	"$(INTDIR)\il_quantizer.sbr" \
	"$(INTDIR)\il_raw.sbr" \
	"$(INTDIR)\il_rawdata.sbr" \
	"$(INTDIR)\il_register.sbr" \
	"$(INTDIR)\il_rle.sbr" \
	"$(INTDIR)\il_sgi.sbr" \
	"$(INTDIR)\il_stack.sbr" \
	"$(INTDIR)\il_states.sbr" \
	"$(INTDIR)\il_targa.sbr" \
	"$(INTDIR)\il_tiff.sbr" \
	"$(INTDIR)\il_utility.sbr" \
	"$(INTDIR)\il_wal.sbr" \
	"$(INTDIR)\il_xpm.sbr" \
	"$(INTDIR)\ilu_alloc.sbr" \
	"$(INTDIR)\ilu_error.sbr" \
	"$(INTDIR)\ilu_filter.sbr" \
	"$(INTDIR)\ilu_filter_rcg.sbr" \
	"$(INTDIR)\ilu_internal.sbr" \
	"$(INTDIR)\ilu_main.sbr" \
	"$(INTDIR)\ilu_manip.sbr" \
	"$(INTDIR)\ilu_mipmap.sbr" \
	"$(INTDIR)\ilu_noise.sbr" \
	"$(INTDIR)\ilu_region.sbr" \
	"$(INTDIR)\ilu_rotate.sbr" \
	"$(INTDIR)\ilu_scale.sbr" \
	"$(INTDIR)\ilu_scale2d.sbr" \
	"$(INTDIR)\ilu_scale3d.sbr" \
	"$(INTDIR)\ilu_scaling.sbr" \
	"$(INTDIR)\ilu_states.sbr" \
	"$(INTDIR)\ilu_utilities.sbr" \
	"$(INTDIR)\ilut_allegro.sbr" \
	"$(INTDIR)\ilut_directx.sbr" \
	"$(INTDIR)\ilut_internal.sbr" \
	"$(INTDIR)\ilut_main.sbr" \
	"$(INTDIR)\ilut_opengl.sbr" \
	"$(INTDIR)\ilut_sdlsurface.sbr" \
	"$(INTDIR)\ilut_states.sbr" \
	"$(INTDIR)\ilut_win32.sbr" \
	"$(INTDIR)\MWEdit.sbr" \
	"$(INTDIR)\MWEditDoc.sbr"

"$(OUTDIR)\MWEdit.bsc" : "$(OUTDIR)" $(BSC32_SBRS)
    $(BSC32) @<<
  $(BSC32_FLAGS) $(BSC32_SBRS)
<<

LINK32=link.exe
LINK32_FLAGS=/nologo /subsystem:windows /incremental:no /pdb:"$(OUTDIR)\MWEdit.pdb" /machine:I386 /out:"$(OUTDIR)\MWEdit.exe" 
LINK32_OBJS= \
	"$(INTDIR)\ActivatorDlg.obj" \
	"$(INTDIR)\EsmAiActivateDlg.obj" \
	"$(INTDIR)\EsmAiEscortDlg.obj" \
	"$(INTDIR)\EsmAiTravelDlg.obj" \
	"$(INTDIR)\EsmAiWanderDlg.obj" \
	"$(INTDIR)\EsmAlchemyDlg.obj" \
	"$(INTDIR)\EsmApparatusDlg.obj" \
	"$(INTDIR)\EsmArmorDlg.obj" \
	"$(INTDIR)\EsmBirthSignDlg.obj" \
	"$(INTDIR)\EsmBodyPartDlg.obj" \
	"$(INTDIR)\EsmBookDlg.obj" \
	"$(INTDIR)\EsmClassDlg.obj" \
	"$(INTDIR)\EsmClothingDlg.obj" \
	"$(INTDIR)\EsmContainDlg.obj" \
	"$(INTDIR)\EsmDialogDlg.obj" \
	"$(INTDIR)\EsmDoorDlg.obj" \
	"$(INTDIR)\EsmEffectDlg.obj" \
	"$(INTDIR)\EsmEnchantDlg.obj" \
	"$(INTDIR)\EsmFactionDlg.obj" \
	"$(INTDIR)\EsmGlobalDlg.obj" \
	"$(INTDIR)\EsmInfoDlg.obj" \
	"$(INTDIR)\EsmIngrediantDlg.obj" \
	"$(INTDIR)\EsmJournalDlg.obj" \
	"$(INTDIR)\EsmLevelCreaDlg.obj" \
	"$(INTDIR)\EsmLevelItemDlg.obj" \
	"$(INTDIR)\EsmLightDlg.obj" \
	"$(INTDIR)\EsmLockPickDlg.obj" \
	"$(INTDIR)\EsmMiscDlg.obj" \
	"$(INTDIR)\EsmProbeDlg.obj" \
	"$(INTDIR)\EsmRaceDlg.obj" \
	"$(INTDIR)\EsmRegionDlg.obj" \
	"$(INTDIR)\EsmRepairDlg.obj" \
	"$(INTDIR)\EsmSettingDlg.obj" \
	"$(INTDIR)\EsmSkillDlg.obj" \
	"$(INTDIR)\EsmSoundDlg.obj" \
	"$(INTDIR)\EsmSoundGenDlg.obj" \
	"$(INTDIR)\EsmSpellDlg.obj" \
	"$(INTDIR)\EsmStartScriptDlg.obj" \
	"$(INTDIR)\EsmStaticDlg.obj" \
	"$(INTDIR)\EsmWeaponDlg.obj" \
	"$(INTDIR)\CreaturePage1.obj" \
	"$(INTDIR)\CreaturePage2.obj" \
	"$(INTDIR)\EsmCreatureDlg.obj" \
	"$(INTDIR)\EsmCreaturePage1.obj" \
	"$(INTDIR)\EsmCreaturePage2.obj" \
	"$(INTDIR)\EsmCreaturePage3.obj" \
	"$(INTDIR)\EsmCreaturePage4.obj" \
	"$(INTDIR)\EsmCreaturePage5.obj" \
	"$(INTDIR)\EsmCellDlg.obj" \
	"$(INTDIR)\EsmCellRefDlg.obj" \
	"$(INTDIR)\EsmExtCellPage.obj" \
	"$(INTDIR)\EsmIntCellPage.obj" \
	"$(INTDIR)\EsmRefCellPage.obj" \
	"$(INTDIR)\ChildFrmScript.obj" \
	"$(INTDIR)\EsmFuncHelpView.obj" \
	"$(INTDIR)\EsmScriptDlg.obj" \
	"$(INTDIR)\ScriptErrorDlg.obj" \
	"$(INTDIR)\ScriptErrorView.obj" \
	"$(INTDIR)\EsmNpcDlg.obj" \
	"$(INTDIR)\EsmNpcPage1.obj" \
	"$(INTDIR)\EsmNpcPage2.obj" \
	"$(INTDIR)\EsmNpcPage3.obj" \
	"$(INTDIR)\EsmNpcPage4.obj" \
	"$(INTDIR)\EsmNpcPage5.obj" \
	"$(INTDIR)\EsmDlgArray.obj" \
	"$(INTDIR)\EsmRecDialog.obj" \
	"$(INTDIR)\ChildFrm.obj" \
	"$(INTDIR)\ChildFrmFix.obj" \
	"$(INTDIR)\ChildFrmVar.obj" \
	"$(INTDIR)\MainFrm.obj" \
	"$(INTDIR)\ColorStatic1.obj" \
	"$(INTDIR)\CustRichEdit.obj" \
	"$(INTDIR)\EsmIconFrame.obj" \
	"$(INTDIR)\EsmListCtrl.obj" \
	"$(INTDIR)\EsmSubListCtrl.obj" \
	"$(INTDIR)\InputDialog.obj" \
	"$(INTDIR)\EsmScrTempPage1.obj" \
	"$(INTDIR)\EsmScrTempPage2.obj" \
	"$(INTDIR)\EsmScrTempPage3.obj" \
	"$(INTDIR)\EsmScrTempView.obj" \
	"$(INTDIR)\ScriptTemplate.obj" \
	"$(INTDIR)\EsmCsvImportDlg.obj" \
	"$(INTDIR)\EsmFindDlg.obj" \
	"$(INTDIR)\EsmHeaderDlg.obj" \
	"$(INTDIR)\EsmLoadDlg.obj" \
	"$(INTDIR)\EsmOptionsDlg.obj" \
	"$(INTDIR)\EsmUsesDlg.obj" \
	"$(INTDIR)\MWEditView.obj" \
	"$(INTDIR)\OpenPluginDlg.obj" \
	"$(INTDIR)\StdAfx.obj" \
	"$(INTDIR)\csvfile.obj" \
	"$(INTDIR)\dl_base.obj" \
	"$(INTDIR)\dl_block.obj" \
	"$(INTDIR)\dl_chr.obj" \
	"$(INTDIR)\dl_err.obj" \
	"$(INTDIR)\dl_file.obj" \
	"$(INTDIR)\dl_log.obj" \
	"$(INTDIR)\dl_math.obj" \
	"$(INTDIR)\dl_mem.obj" \
	"$(INTDIR)\dl_str.obj" \
	"$(INTDIR)\dl_time.obj" \
	"$(INTDIR)\dl_ToolTip.obj" \
	"$(INTDIR)\genfile.obj" \
	"$(INTDIR)\genfind.obj" \
	"$(INTDIR)\GenStack.obj" \
	"$(INTDIR)\mwcommon.obj" \
	"$(INTDIR)\namelist.obj" \
	"$(INTDIR)\ptrarray.obj" \
	"$(INTDIR)\SString.obj" \
	"$(INTDIR)\TabCtrlSheet.obj" \
	"$(INTDIR)\temarray.obj" \
	"$(INTDIR)\tstfile.obj" \
	"$(INTDIR)\WinUtil.obj" \
	"$(INTDIR)\EsmActivator.obj" \
	"$(INTDIR)\EsmAlchemy.obj" \
	"$(INTDIR)\EsmApparatus.obj" \
	"$(INTDIR)\EsmArmor.obj" \
	"$(INTDIR)\EsmBirthSign.obj" \
	"$(INTDIR)\EsmBodyPart.obj" \
	"$(INTDIR)\EsmBook.obj" \
	"$(INTDIR)\EsmCell.obj" \
	"$(INTDIR)\EsmClass.obj" \
	"$(INTDIR)\EsmClothing.obj" \
	"$(INTDIR)\EsmContainer.obj" \
	"$(INTDIR)\EsmCreature.obj" \
	"$(INTDIR)\EsmDialogue.obj" \
	"$(INTDIR)\EsmDoor.obj" \
	"$(INTDIR)\EsmEnchant.obj" \
	"$(INTDIR)\EsmFaction.obj" \
	"$(INTDIR)\EsmGameSetting.obj" \
	"$(INTDIR)\EsmGlobal.obj" \
	"$(INTDIR)\EsmInfo.obj" \
	"$(INTDIR)\EsmIngrediant.obj" \
	"$(INTDIR)\EsmItem1.obj" \
	"$(INTDIR)\EsmItem2.obj" \
	"$(INTDIR)\EsmItem3.obj" \
	"$(INTDIR)\EsmLand.obj" \
	"$(INTDIR)\EsmLevelCrea.obj" \
	"$(INTDIR)\EsmLevelItem.obj" \
	"$(INTDIR)\EsmLight.obj" \
	"$(INTDIR)\EsmLockPick.obj" \
	"$(INTDIR)\EsmMagicEffect.obj" \
	"$(INTDIR)\EsmMisc.obj" \
	"$(INTDIR)\EsmNpc.obj" \
	"$(INTDIR)\EsmProbe.obj" \
	"$(INTDIR)\EsmRace.obj" \
	"$(INTDIR)\EsmRecord.obj" \
	"$(INTDIR)\EsmRegion.obj" \
	"$(INTDIR)\EsmRepair.obj" \
	"$(INTDIR)\EsmScript.obj" \
	"$(INTDIR)\EsmSkill.obj" \
	"$(INTDIR)\EsmSound.obj" \
	"$(INTDIR)\EsmSoundGen.obj" \
	"$(INTDIR)\EsmSpell.obj" \
	"$(INTDIR)\EsmStartScript.obj" \
	"$(INTDIR)\EsmStatic.obj" \
	"$(INTDIR)\EsmTES3.obj" \
	"$(INTDIR)\EsmWeapon.obj" \
	"$(INTDIR)\EsmSubBase.obj" \
	"$(INTDIR)\EsmSubCellRef.obj" \
	"$(INTDIR)\EsmSubName.obj" \
	"$(INTDIR)\EsmSubSCVR.obj" \
	"$(INTDIR)\EsmScrFuncArray.obj" \
	"$(INTDIR)\EsmScrFuncData.obj" \
	"$(INTDIR)\EsmScriptCompile.obj" \
	"$(INTDIR)\EsmScriptDefs.obj" \
	"$(INTDIR)\EsmScriptError.obj" \
	"$(INTDIR)\EsmScriptFuncs.obj" \
	"$(INTDIR)\EsmScriptOptions.obj" \
	"$(INTDIR)\EsmBase.obj" \
	"$(INTDIR)\EsmCsvDefs.obj" \
	"$(INTDIR)\EsmFile.obj" \
	"$(INTDIR)\EsmGlobOptions.obj" \
	"$(INTDIR)\EsmOptions.obj" \
	"$(INTDIR)\EsmUtils.obj" \
	"$(INTDIR)\il_alloc.obj" \
	"$(INTDIR)\il_bits.obj" \
	"$(INTDIR)\il_bmp.obj" \
	"$(INTDIR)\il_convbuff.obj" \
	"$(INTDIR)\il_convert.obj" \
	"$(INTDIR)\il_cut.obj" \
	"$(INTDIR)\il_dcx.obj" \
	"$(INTDIR)\il_dds-save.obj" \
	"$(INTDIR)\il_dds.obj" \
	"$(INTDIR)\il_devil.obj" \
	"$(INTDIR)\il_doom.obj" \
	"$(INTDIR)\il_endian.obj" \
	"$(INTDIR)\il_error.obj" \
	"$(INTDIR)\il_fastconv.obj" \
	"$(INTDIR)\il_files.obj" \
	"$(INTDIR)\il_gif.obj" \
	"$(INTDIR)\il_header.obj" \
	"$(INTDIR)\il_icon.obj" \
	"$(INTDIR)\il_internal.obj" \
	"$(INTDIR)\il_io.obj" \
	"$(INTDIR)\il_jpeg.obj" \
	"$(INTDIR)\il_lif.obj" \
	"$(INTDIR)\il_main.obj" \
	"$(INTDIR)\il_manip.obj" \
	"$(INTDIR)\il_mdl.obj" \
	"$(INTDIR)\il_mng.obj" \
	"$(INTDIR)\il_neuquant.obj" \
	"$(INTDIR)\il_pal.obj" \
	"$(INTDIR)\il_pcd.obj" \
	"$(INTDIR)\il_pcx.obj" \
	"$(INTDIR)\il_pic.obj" \
	"$(INTDIR)\il_pix.obj" \
	"$(INTDIR)\il_png.obj" \
	"$(INTDIR)\il_pnm.obj" \
	"$(INTDIR)\il_profiles.obj" \
	"$(INTDIR)\il_psd.obj" \
	"$(INTDIR)\il_psp.obj" \
	"$(INTDIR)\il_pxr.obj" \
	"$(INTDIR)\il_quantizer.obj" \
	"$(INTDIR)\il_raw.obj" \
	"$(INTDIR)\il_rawdata.obj" \
	"$(INTDIR)\il_register.obj" \
	"$(INTDIR)\il_rle.obj" \
	"$(INTDIR)\il_sgi.obj" \
	"$(INTDIR)\il_stack.obj" \
	"$(INTDIR)\il_states.obj" \
	"$(INTDIR)\il_targa.obj" \
	"$(INTDIR)\il_tiff.obj" \
	"$(INTDIR)\il_utility.obj" \
	"$(INTDIR)\il_wal.obj" \
	"$(INTDIR)\il_xpm.obj" \
	"$(INTDIR)\ilu_alloc.obj" \
	"$(INTDIR)\ilu_error.obj" \
	"$(INTDIR)\ilu_filter.obj" \
	"$(INTDIR)\ilu_filter_rcg.obj" \
	"$(INTDIR)\ilu_internal.obj" \
	"$(INTDIR)\ilu_main.obj" \
	"$(INTDIR)\ilu_manip.obj" \
	"$(INTDIR)\ilu_mipmap.obj" \
	"$(INTDIR)\ilu_noise.obj" \
	"$(INTDIR)\ilu_region.obj" \
	"$(INTDIR)\ilu_rotate.obj" \
	"$(INTDIR)\ilu_scale.obj" \
	"$(INTDIR)\ilu_scale2d.obj" \
	"$(INTDIR)\ilu_scale3d.obj" \
	"$(INTDIR)\ilu_scaling.obj" \
	"$(INTDIR)\ilu_states.obj" \
	"$(INTDIR)\ilu_utilities.obj" \
	"$(INTDIR)\ilut_allegro.obj" \
	"$(INTDIR)\ilut_directx.obj" \
	"$(INTDIR)\ilut_internal.obj" \
	"$(INTDIR)\ilut_main.obj" \
	"$(INTDIR)\ilut_opengl.obj" \
	"$(INTDIR)\ilut_sdlsurface.obj" \
	"$(INTDIR)\ilut_states.obj" \
	"$(INTDIR)\ilut_win32.obj" \
	"$(INTDIR)\MWEdit.obj" \
	"$(INTDIR)\MWEditDoc.obj" \
	"$(INTDIR)\MWEdit.res" \
	"C:\Programs\MsVs\VC98\Lib\WINMM.LIB"

"$(OUTDIR)\MWEdit.exe" : "$(OUTDIR)" $(DEF_FILE) $(LINK32_OBJS)
    $(LINK32) @<<
  $(LINK32_FLAGS) $(LINK32_OBJS)
<<

!ELSEIF  "$(CFG)" == "MWEdit - Win32 Debug"

OUTDIR=.\Debug
INTDIR=.\Debug
# Begin Custom Macros
OutDir=.\Debug
# End Custom Macros

ALL : ".\Debug\MWEdit.hlp" ".\Debug\MWEdit.cnt" "$(OUTDIR)\MWEdit.exe" "$(OUTDIR)\MWEdit.bsc"


CLEAN :
	-@erase "$(INTDIR)\ActivatorDlg.obj"
	-@erase "$(INTDIR)\ActivatorDlg.sbr"
	-@erase "$(INTDIR)\ChildFrm.obj"
	-@erase "$(INTDIR)\ChildFrm.sbr"
	-@erase "$(INTDIR)\ChildFrmFix.obj"
	-@erase "$(INTDIR)\ChildFrmFix.sbr"
	-@erase "$(INTDIR)\ChildFrmScript.obj"
	-@erase "$(INTDIR)\ChildFrmScript.sbr"
	-@erase "$(INTDIR)\ChildFrmVar.obj"
	-@erase "$(INTDIR)\ChildFrmVar.sbr"
	-@erase "$(INTDIR)\ColorStatic1.obj"
	-@erase "$(INTDIR)\ColorStatic1.sbr"
	-@erase "$(INTDIR)\CreaturePage1.obj"
	-@erase "$(INTDIR)\CreaturePage1.sbr"
	-@erase "$(INTDIR)\CreaturePage2.obj"
	-@erase "$(INTDIR)\CreaturePage2.sbr"
	-@erase "$(INTDIR)\csvfile.obj"
	-@erase "$(INTDIR)\csvfile.sbr"
	-@erase "$(INTDIR)\CustRichEdit.obj"
	-@erase "$(INTDIR)\CustRichEdit.sbr"
	-@erase "$(INTDIR)\dl_base.obj"
	-@erase "$(INTDIR)\dl_base.sbr"
	-@erase "$(INTDIR)\dl_block.obj"
	-@erase "$(INTDIR)\dl_block.sbr"
	-@erase "$(INTDIR)\dl_chr.obj"
	-@erase "$(INTDIR)\dl_chr.sbr"
	-@erase "$(INTDIR)\dl_err.obj"
	-@erase "$(INTDIR)\dl_err.sbr"
	-@erase "$(INTDIR)\dl_file.obj"
	-@erase "$(INTDIR)\dl_file.sbr"
	-@erase "$(INTDIR)\dl_log.obj"
	-@erase "$(INTDIR)\dl_log.sbr"
	-@erase "$(INTDIR)\dl_math.obj"
	-@erase "$(INTDIR)\dl_math.sbr"
	-@erase "$(INTDIR)\dl_mem.obj"
	-@erase "$(INTDIR)\dl_mem.sbr"
	-@erase "$(INTDIR)\dl_str.obj"
	-@erase "$(INTDIR)\dl_str.sbr"
	-@erase "$(INTDIR)\dl_time.obj"
	-@erase "$(INTDIR)\dl_time.sbr"
	-@erase "$(INTDIR)\dl_ToolTip.obj"
	-@erase "$(INTDIR)\dl_ToolTip.sbr"
	-@erase "$(INTDIR)\EsmActivator.obj"
	-@erase "$(INTDIR)\EsmActivator.sbr"
	-@erase "$(INTDIR)\EsmAiActivateDlg.obj"
	-@erase "$(INTDIR)\EsmAiActivateDlg.sbr"
	-@erase "$(INTDIR)\EsmAiEscortDlg.obj"
	-@erase "$(INTDIR)\EsmAiEscortDlg.sbr"
	-@erase "$(INTDIR)\EsmAiTravelDlg.obj"
	-@erase "$(INTDIR)\EsmAiTravelDlg.sbr"
	-@erase "$(INTDIR)\EsmAiWanderDlg.obj"
	-@erase "$(INTDIR)\EsmAiWanderDlg.sbr"
	-@erase "$(INTDIR)\EsmAlchemy.obj"
	-@erase "$(INTDIR)\EsmAlchemy.sbr"
	-@erase "$(INTDIR)\EsmAlchemyDlg.obj"
	-@erase "$(INTDIR)\EsmAlchemyDlg.sbr"
	-@erase "$(INTDIR)\EsmApparatus.obj"
	-@erase "$(INTDIR)\EsmApparatus.sbr"
	-@erase "$(INTDIR)\EsmApparatusDlg.obj"
	-@erase "$(INTDIR)\EsmApparatusDlg.sbr"
	-@erase "$(INTDIR)\EsmArmor.obj"
	-@erase "$(INTDIR)\EsmArmor.sbr"
	-@erase "$(INTDIR)\EsmArmorDlg.obj"
	-@erase "$(INTDIR)\EsmArmorDlg.sbr"
	-@erase "$(INTDIR)\EsmBase.obj"
	-@erase "$(INTDIR)\EsmBase.sbr"
	-@erase "$(INTDIR)\EsmBirthSign.obj"
	-@erase "$(INTDIR)\EsmBirthSign.sbr"
	-@erase "$(INTDIR)\EsmBirthSignDlg.obj"
	-@erase "$(INTDIR)\EsmBirthSignDlg.sbr"
	-@erase "$(INTDIR)\EsmBodyPart.obj"
	-@erase "$(INTDIR)\EsmBodyPart.sbr"
	-@erase "$(INTDIR)\EsmBodyPartDlg.obj"
	-@erase "$(INTDIR)\EsmBodyPartDlg.sbr"
	-@erase "$(INTDIR)\EsmBook.obj"
	-@erase "$(INTDIR)\EsmBook.sbr"
	-@erase "$(INTDIR)\EsmBookDlg.obj"
	-@erase "$(INTDIR)\EsmBookDlg.sbr"
	-@erase "$(INTDIR)\EsmCell.obj"
	-@erase "$(INTDIR)\EsmCell.sbr"
	-@erase "$(INTDIR)\EsmCellDlg.obj"
	-@erase "$(INTDIR)\EsmCellDlg.sbr"
	-@erase "$(INTDIR)\EsmCellRefDlg.obj"
	-@erase "$(INTDIR)\EsmCellRefDlg.sbr"
	-@erase "$(INTDIR)\EsmClass.obj"
	-@erase "$(INTDIR)\EsmClass.sbr"
	-@erase "$(INTDIR)\EsmClassDlg.obj"
	-@erase "$(INTDIR)\EsmClassDlg.sbr"
	-@erase "$(INTDIR)\EsmClothing.obj"
	-@erase "$(INTDIR)\EsmClothing.sbr"
	-@erase "$(INTDIR)\EsmClothingDlg.obj"
	-@erase "$(INTDIR)\EsmClothingDlg.sbr"
	-@erase "$(INTDIR)\EsmContainDlg.obj"
	-@erase "$(INTDIR)\EsmContainDlg.sbr"
	-@erase "$(INTDIR)\EsmContainer.obj"
	-@erase "$(INTDIR)\EsmContainer.sbr"
	-@erase "$(INTDIR)\EsmCreature.obj"
	-@erase "$(INTDIR)\EsmCreature.sbr"
	-@erase "$(INTDIR)\EsmCreatureDlg.obj"
	-@erase "$(INTDIR)\EsmCreatureDlg.sbr"
	-@erase "$(INTDIR)\EsmCreaturePage1.obj"
	-@erase "$(INTDIR)\EsmCreaturePage1.sbr"
	-@erase "$(INTDIR)\EsmCreaturePage2.obj"
	-@erase "$(INTDIR)\EsmCreaturePage2.sbr"
	-@erase "$(INTDIR)\EsmCreaturePage3.obj"
	-@erase "$(INTDIR)\EsmCreaturePage3.sbr"
	-@erase "$(INTDIR)\EsmCreaturePage4.obj"
	-@erase "$(INTDIR)\EsmCreaturePage4.sbr"
	-@erase "$(INTDIR)\EsmCreaturePage5.obj"
	-@erase "$(INTDIR)\EsmCreaturePage5.sbr"
	-@erase "$(INTDIR)\EsmCsvDefs.obj"
	-@erase "$(INTDIR)\EsmCsvDefs.sbr"
	-@erase "$(INTDIR)\EsmCsvImportDlg.obj"
	-@erase "$(INTDIR)\EsmCsvImportDlg.sbr"
	-@erase "$(INTDIR)\EsmDialogDlg.obj"
	-@erase "$(INTDIR)\EsmDialogDlg.sbr"
	-@erase "$(INTDIR)\EsmDialogue.obj"
	-@erase "$(INTDIR)\EsmDialogue.sbr"
	-@erase "$(INTDIR)\EsmDlgArray.obj"
	-@erase "$(INTDIR)\EsmDlgArray.sbr"
	-@erase "$(INTDIR)\EsmDoor.obj"
	-@erase "$(INTDIR)\EsmDoor.sbr"
	-@erase "$(INTDIR)\EsmDoorDlg.obj"
	-@erase "$(INTDIR)\EsmDoorDlg.sbr"
	-@erase "$(INTDIR)\EsmEffectDlg.obj"
	-@erase "$(INTDIR)\EsmEffectDlg.sbr"
	-@erase "$(INTDIR)\EsmEnchant.obj"
	-@erase "$(INTDIR)\EsmEnchant.sbr"
	-@erase "$(INTDIR)\EsmEnchantDlg.obj"
	-@erase "$(INTDIR)\EsmEnchantDlg.sbr"
	-@erase "$(INTDIR)\EsmExtCellPage.obj"
	-@erase "$(INTDIR)\EsmExtCellPage.sbr"
	-@erase "$(INTDIR)\EsmFaction.obj"
	-@erase "$(INTDIR)\EsmFaction.sbr"
	-@erase "$(INTDIR)\EsmFactionDlg.obj"
	-@erase "$(INTDIR)\EsmFactionDlg.sbr"
	-@erase "$(INTDIR)\EsmFile.obj"
	-@erase "$(INTDIR)\EsmFile.sbr"
	-@erase "$(INTDIR)\EsmFindDlg.obj"
	-@erase "$(INTDIR)\EsmFindDlg.sbr"
	-@erase "$(INTDIR)\EsmFuncHelpView.obj"
	-@erase "$(INTDIR)\EsmFuncHelpView.sbr"
	-@erase "$(INTDIR)\EsmGameSetting.obj"
	-@erase "$(INTDIR)\EsmGameSetting.sbr"
	-@erase "$(INTDIR)\EsmGlobal.obj"
	-@erase "$(INTDIR)\EsmGlobal.sbr"
	-@erase "$(INTDIR)\EsmGlobalDlg.obj"
	-@erase "$(INTDIR)\EsmGlobalDlg.sbr"
	-@erase "$(INTDIR)\EsmGlobOptions.obj"
	-@erase "$(INTDIR)\EsmGlobOptions.sbr"
	-@erase "$(INTDIR)\EsmHeaderDlg.obj"
	-@erase "$(INTDIR)\EsmHeaderDlg.sbr"
	-@erase "$(INTDIR)\EsmIconFrame.obj"
	-@erase "$(INTDIR)\EsmIconFrame.sbr"
	-@erase "$(INTDIR)\EsmInfo.obj"
	-@erase "$(INTDIR)\EsmInfo.sbr"
	-@erase "$(INTDIR)\EsmInfoDlg.obj"
	-@erase "$(INTDIR)\EsmInfoDlg.sbr"
	-@erase "$(INTDIR)\EsmIngrediant.obj"
	-@erase "$(INTDIR)\EsmIngrediant.sbr"
	-@erase "$(INTDIR)\EsmIngrediantDlg.obj"
	-@erase "$(INTDIR)\EsmIngrediantDlg.sbr"
	-@erase "$(INTDIR)\EsmIntCellPage.obj"
	-@erase "$(INTDIR)\EsmIntCellPage.sbr"
	-@erase "$(INTDIR)\EsmItem1.obj"
	-@erase "$(INTDIR)\EsmItem1.sbr"
	-@erase "$(INTDIR)\EsmItem2.obj"
	-@erase "$(INTDIR)\EsmItem2.sbr"
	-@erase "$(INTDIR)\EsmItem3.obj"
	-@erase "$(INTDIR)\EsmItem3.sbr"
	-@erase "$(INTDIR)\EsmJournalDlg.obj"
	-@erase "$(INTDIR)\EsmJournalDlg.sbr"
	-@erase "$(INTDIR)\EsmLand.obj"
	-@erase "$(INTDIR)\EsmLand.sbr"
	-@erase "$(INTDIR)\EsmLevelCrea.obj"
	-@erase "$(INTDIR)\EsmLevelCrea.sbr"
	-@erase "$(INTDIR)\EsmLevelCreaDlg.obj"
	-@erase "$(INTDIR)\EsmLevelCreaDlg.sbr"
	-@erase "$(INTDIR)\EsmLevelItem.obj"
	-@erase "$(INTDIR)\EsmLevelItem.sbr"
	-@erase "$(INTDIR)\EsmLevelItemDlg.obj"
	-@erase "$(INTDIR)\EsmLevelItemDlg.sbr"
	-@erase "$(INTDIR)\EsmLight.obj"
	-@erase "$(INTDIR)\EsmLight.sbr"
	-@erase "$(INTDIR)\EsmLightDlg.obj"
	-@erase "$(INTDIR)\EsmLightDlg.sbr"
	-@erase "$(INTDIR)\EsmListCtrl.obj"
	-@erase "$(INTDIR)\EsmListCtrl.sbr"
	-@erase "$(INTDIR)\EsmLoadDlg.obj"
	-@erase "$(INTDIR)\EsmLoadDlg.sbr"
	-@erase "$(INTDIR)\EsmLockPick.obj"
	-@erase "$(INTDIR)\EsmLockPick.sbr"
	-@erase "$(INTDIR)\EsmLockPickDlg.obj"
	-@erase "$(INTDIR)\EsmLockPickDlg.sbr"
	-@erase "$(INTDIR)\EsmMagicEffect.obj"
	-@erase "$(INTDIR)\EsmMagicEffect.sbr"
	-@erase "$(INTDIR)\EsmMisc.obj"
	-@erase "$(INTDIR)\EsmMisc.sbr"
	-@erase "$(INTDIR)\EsmMiscDlg.obj"
	-@erase "$(INTDIR)\EsmMiscDlg.sbr"
	-@erase "$(INTDIR)\EsmNpc.obj"
	-@erase "$(INTDIR)\EsmNpc.sbr"
	-@erase "$(INTDIR)\EsmNpcDlg.obj"
	-@erase "$(INTDIR)\EsmNpcDlg.sbr"
	-@erase "$(INTDIR)\EsmNpcPage1.obj"
	-@erase "$(INTDIR)\EsmNpcPage1.sbr"
	-@erase "$(INTDIR)\EsmNpcPage2.obj"
	-@erase "$(INTDIR)\EsmNpcPage2.sbr"
	-@erase "$(INTDIR)\EsmNpcPage3.obj"
	-@erase "$(INTDIR)\EsmNpcPage3.sbr"
	-@erase "$(INTDIR)\EsmNpcPage4.obj"
	-@erase "$(INTDIR)\EsmNpcPage4.sbr"
	-@erase "$(INTDIR)\EsmNpcPage5.obj"
	-@erase "$(INTDIR)\EsmNpcPage5.sbr"
	-@erase "$(INTDIR)\EsmOptions.obj"
	-@erase "$(INTDIR)\EsmOptions.sbr"
	-@erase "$(INTDIR)\EsmOptionsDlg.obj"
	-@erase "$(INTDIR)\EsmOptionsDlg.sbr"
	-@erase "$(INTDIR)\EsmProbe.obj"
	-@erase "$(INTDIR)\EsmProbe.sbr"
	-@erase "$(INTDIR)\EsmProbeDlg.obj"
	-@erase "$(INTDIR)\EsmProbeDlg.sbr"
	-@erase "$(INTDIR)\EsmRace.obj"
	-@erase "$(INTDIR)\EsmRace.sbr"
	-@erase "$(INTDIR)\EsmRaceDlg.obj"
	-@erase "$(INTDIR)\EsmRaceDlg.sbr"
	-@erase "$(INTDIR)\EsmRecDialog.obj"
	-@erase "$(INTDIR)\EsmRecDialog.sbr"
	-@erase "$(INTDIR)\EsmRecord.obj"
	-@erase "$(INTDIR)\EsmRecord.sbr"
	-@erase "$(INTDIR)\EsmRefCellPage.obj"
	-@erase "$(INTDIR)\EsmRefCellPage.sbr"
	-@erase "$(INTDIR)\EsmRegion.obj"
	-@erase "$(INTDIR)\EsmRegion.sbr"
	-@erase "$(INTDIR)\EsmRegionDlg.obj"
	-@erase "$(INTDIR)\EsmRegionDlg.sbr"
	-@erase "$(INTDIR)\EsmRepair.obj"
	-@erase "$(INTDIR)\EsmRepair.sbr"
	-@erase "$(INTDIR)\EsmRepairDlg.obj"
	-@erase "$(INTDIR)\EsmRepairDlg.sbr"
	-@erase "$(INTDIR)\EsmScrFuncArray.obj"
	-@erase "$(INTDIR)\EsmScrFuncArray.sbr"
	-@erase "$(INTDIR)\EsmScrFuncData.obj"
	-@erase "$(INTDIR)\EsmScrFuncData.sbr"
	-@erase "$(INTDIR)\EsmScript.obj"
	-@erase "$(INTDIR)\EsmScript.sbr"
	-@erase "$(INTDIR)\EsmScriptCompile.obj"
	-@erase "$(INTDIR)\EsmScriptCompile.sbr"
	-@erase "$(INTDIR)\EsmScriptDefs.obj"
	-@erase "$(INTDIR)\EsmScriptDefs.sbr"
	-@erase "$(INTDIR)\EsmScriptDlg.obj"
	-@erase "$(INTDIR)\EsmScriptDlg.sbr"
	-@erase "$(INTDIR)\EsmScriptError.obj"
	-@erase "$(INTDIR)\EsmScriptError.sbr"
	-@erase "$(INTDIR)\EsmScriptFuncs.obj"
	-@erase "$(INTDIR)\EsmScriptFuncs.sbr"
	-@erase "$(INTDIR)\EsmScriptOptions.obj"
	-@erase "$(INTDIR)\EsmScriptOptions.sbr"
	-@erase "$(INTDIR)\EsmScrTempPage1.obj"
	-@erase "$(INTDIR)\EsmScrTempPage1.sbr"
	-@erase "$(INTDIR)\EsmScrTempPage2.obj"
	-@erase "$(INTDIR)\EsmScrTempPage2.sbr"
	-@erase "$(INTDIR)\EsmScrTempPage3.obj"
	-@erase "$(INTDIR)\EsmScrTempPage3.sbr"
	-@erase "$(INTDIR)\EsmScrTempView.obj"
	-@erase "$(INTDIR)\EsmScrTempView.sbr"
	-@erase "$(INTDIR)\EsmSettingDlg.obj"
	-@erase "$(INTDIR)\EsmSettingDlg.sbr"
	-@erase "$(INTDIR)\EsmSkill.obj"
	-@erase "$(INTDIR)\EsmSkill.sbr"
	-@erase "$(INTDIR)\EsmSkillDlg.obj"
	-@erase "$(INTDIR)\EsmSkillDlg.sbr"
	-@erase "$(INTDIR)\EsmSound.obj"
	-@erase "$(INTDIR)\EsmSound.sbr"
	-@erase "$(INTDIR)\EsmSoundDlg.obj"
	-@erase "$(INTDIR)\EsmSoundDlg.sbr"
	-@erase "$(INTDIR)\EsmSoundGen.obj"
	-@erase "$(INTDIR)\EsmSoundGen.sbr"
	-@erase "$(INTDIR)\EsmSoundGenDlg.obj"
	-@erase "$(INTDIR)\EsmSoundGenDlg.sbr"
	-@erase "$(INTDIR)\EsmSpell.obj"
	-@erase "$(INTDIR)\EsmSpell.sbr"
	-@erase "$(INTDIR)\EsmSpellDlg.obj"
	-@erase "$(INTDIR)\EsmSpellDlg.sbr"
	-@erase "$(INTDIR)\EsmStartScript.obj"
	-@erase "$(INTDIR)\EsmStartScript.sbr"
	-@erase "$(INTDIR)\EsmStartScriptDlg.obj"
	-@erase "$(INTDIR)\EsmStartScriptDlg.sbr"
	-@erase "$(INTDIR)\EsmStatic.obj"
	-@erase "$(INTDIR)\EsmStatic.sbr"
	-@erase "$(INTDIR)\EsmStaticDlg.obj"
	-@erase "$(INTDIR)\EsmStaticDlg.sbr"
	-@erase "$(INTDIR)\EsmSubBase.obj"
	-@erase "$(INTDIR)\EsmSubBase.sbr"
	-@erase "$(INTDIR)\EsmSubCellRef.obj"
	-@erase "$(INTDIR)\EsmSubCellRef.sbr"
	-@erase "$(INTDIR)\EsmSubListCtrl.obj"
	-@erase "$(INTDIR)\EsmSubListCtrl.sbr"
	-@erase "$(INTDIR)\EsmSubName.obj"
	-@erase "$(INTDIR)\EsmSubName.sbr"
	-@erase "$(INTDIR)\EsmSubSCVR.obj"
	-@erase "$(INTDIR)\EsmSubSCVR.sbr"
	-@erase "$(INTDIR)\EsmTES3.obj"
	-@erase "$(INTDIR)\EsmTES3.sbr"
	-@erase "$(INTDIR)\EsmUsesDlg.obj"
	-@erase "$(INTDIR)\EsmUsesDlg.sbr"
	-@erase "$(INTDIR)\EsmUtils.obj"
	-@erase "$(INTDIR)\EsmUtils.sbr"
	-@erase "$(INTDIR)\EsmWeapon.obj"
	-@erase "$(INTDIR)\EsmWeapon.sbr"
	-@erase "$(INTDIR)\EsmWeaponDlg.obj"
	-@erase "$(INTDIR)\EsmWeaponDlg.sbr"
	-@erase "$(INTDIR)\genfile.obj"
	-@erase "$(INTDIR)\genfile.sbr"
	-@erase "$(INTDIR)\genfind.obj"
	-@erase "$(INTDIR)\genfind.sbr"
	-@erase "$(INTDIR)\GenStack.obj"
	-@erase "$(INTDIR)\GenStack.sbr"
	-@erase "$(INTDIR)\il_alloc.obj"
	-@erase "$(INTDIR)\il_alloc.sbr"
	-@erase "$(INTDIR)\il_bits.obj"
	-@erase "$(INTDIR)\il_bits.sbr"
	-@erase "$(INTDIR)\il_bmp.obj"
	-@erase "$(INTDIR)\il_bmp.sbr"
	-@erase "$(INTDIR)\il_convbuff.obj"
	-@erase "$(INTDIR)\il_convbuff.sbr"
	-@erase "$(INTDIR)\il_convert.obj"
	-@erase "$(INTDIR)\il_convert.sbr"
	-@erase "$(INTDIR)\il_cut.obj"
	-@erase "$(INTDIR)\il_cut.sbr"
	-@erase "$(INTDIR)\il_dcx.obj"
	-@erase "$(INTDIR)\il_dcx.sbr"
	-@erase "$(INTDIR)\il_dds-save.obj"
	-@erase "$(INTDIR)\il_dds-save.sbr"
	-@erase "$(INTDIR)\il_dds.obj"
	-@erase "$(INTDIR)\il_dds.sbr"
	-@erase "$(INTDIR)\il_devil.obj"
	-@erase "$(INTDIR)\il_devil.sbr"
	-@erase "$(INTDIR)\il_doom.obj"
	-@erase "$(INTDIR)\il_doom.sbr"
	-@erase "$(INTDIR)\il_endian.obj"
	-@erase "$(INTDIR)\il_endian.sbr"
	-@erase "$(INTDIR)\il_error.obj"
	-@erase "$(INTDIR)\il_error.sbr"
	-@erase "$(INTDIR)\il_fastconv.obj"
	-@erase "$(INTDIR)\il_fastconv.sbr"
	-@erase "$(INTDIR)\il_files.obj"
	-@erase "$(INTDIR)\il_files.sbr"
	-@erase "$(INTDIR)\il_gif.obj"
	-@erase "$(INTDIR)\il_gif.sbr"
	-@erase "$(INTDIR)\il_header.obj"
	-@erase "$(INTDIR)\il_header.sbr"
	-@erase "$(INTDIR)\il_icon.obj"
	-@erase "$(INTDIR)\il_icon.sbr"
	-@erase "$(INTDIR)\il_internal.obj"
	-@erase "$(INTDIR)\il_internal.sbr"
	-@erase "$(INTDIR)\il_io.obj"
	-@erase "$(INTDIR)\il_io.sbr"
	-@erase "$(INTDIR)\il_jpeg.obj"
	-@erase "$(INTDIR)\il_jpeg.sbr"
	-@erase "$(INTDIR)\il_lif.obj"
	-@erase "$(INTDIR)\il_lif.sbr"
	-@erase "$(INTDIR)\il_main.obj"
	-@erase "$(INTDIR)\il_main.sbr"
	-@erase "$(INTDIR)\il_manip.obj"
	-@erase "$(INTDIR)\il_manip.sbr"
	-@erase "$(INTDIR)\il_mdl.obj"
	-@erase "$(INTDIR)\il_mdl.sbr"
	-@erase "$(INTDIR)\il_mng.obj"
	-@erase "$(INTDIR)\il_mng.sbr"
	-@erase "$(INTDIR)\il_neuquant.obj"
	-@erase "$(INTDIR)\il_neuquant.sbr"
	-@erase "$(INTDIR)\il_pal.obj"
	-@erase "$(INTDIR)\il_pal.sbr"
	-@erase "$(INTDIR)\il_pcd.obj"
	-@erase "$(INTDIR)\il_pcd.sbr"
	-@erase "$(INTDIR)\il_pcx.obj"
	-@erase "$(INTDIR)\il_pcx.sbr"
	-@erase "$(INTDIR)\il_pic.obj"
	-@erase "$(INTDIR)\il_pic.sbr"
	-@erase "$(INTDIR)\il_pix.obj"
	-@erase "$(INTDIR)\il_pix.sbr"
	-@erase "$(INTDIR)\il_png.obj"
	-@erase "$(INTDIR)\il_png.sbr"
	-@erase "$(INTDIR)\il_pnm.obj"
	-@erase "$(INTDIR)\il_pnm.sbr"
	-@erase "$(INTDIR)\il_profiles.obj"
	-@erase "$(INTDIR)\il_profiles.sbr"
	-@erase "$(INTDIR)\il_psd.obj"
	-@erase "$(INTDIR)\il_psd.sbr"
	-@erase "$(INTDIR)\il_psp.obj"
	-@erase "$(INTDIR)\il_psp.sbr"
	-@erase "$(INTDIR)\il_pxr.obj"
	-@erase "$(INTDIR)\il_pxr.sbr"
	-@erase "$(INTDIR)\il_quantizer.obj"
	-@erase "$(INTDIR)\il_quantizer.sbr"
	-@erase "$(INTDIR)\il_raw.obj"
	-@erase "$(INTDIR)\il_raw.sbr"
	-@erase "$(INTDIR)\il_rawdata.obj"
	-@erase "$(INTDIR)\il_rawdata.sbr"
	-@erase "$(INTDIR)\il_register.obj"
	-@erase "$(INTDIR)\il_register.sbr"
	-@erase "$(INTDIR)\il_rle.obj"
	-@erase "$(INTDIR)\il_rle.sbr"
	-@erase "$(INTDIR)\il_sgi.obj"
	-@erase "$(INTDIR)\il_sgi.sbr"
	-@erase "$(INTDIR)\il_stack.obj"
	-@erase "$(INTDIR)\il_stack.sbr"
	-@erase "$(INTDIR)\il_states.obj"
	-@erase "$(INTDIR)\il_states.sbr"
	-@erase "$(INTDIR)\il_targa.obj"
	-@erase "$(INTDIR)\il_targa.sbr"
	-@erase "$(INTDIR)\il_tiff.obj"
	-@erase "$(INTDIR)\il_tiff.sbr"
	-@erase "$(INTDIR)\il_utility.obj"
	-@erase "$(INTDIR)\il_utility.sbr"
	-@erase "$(INTDIR)\il_wal.obj"
	-@erase "$(INTDIR)\il_wal.sbr"
	-@erase "$(INTDIR)\il_xpm.obj"
	-@erase "$(INTDIR)\il_xpm.sbr"
	-@erase "$(INTDIR)\ilu_alloc.obj"
	-@erase "$(INTDIR)\ilu_alloc.sbr"
	-@erase "$(INTDIR)\ilu_error.obj"
	-@erase "$(INTDIR)\ilu_error.sbr"
	-@erase "$(INTDIR)\ilu_filter.obj"
	-@erase "$(INTDIR)\ilu_filter.sbr"
	-@erase "$(INTDIR)\ilu_filter_rcg.obj"
	-@erase "$(INTDIR)\ilu_filter_rcg.sbr"
	-@erase "$(INTDIR)\ilu_internal.obj"
	-@erase "$(INTDIR)\ilu_internal.sbr"
	-@erase "$(INTDIR)\ilu_main.obj"
	-@erase "$(INTDIR)\ilu_main.sbr"
	-@erase "$(INTDIR)\ilu_manip.obj"
	-@erase "$(INTDIR)\ilu_manip.sbr"
	-@erase "$(INTDIR)\ilu_mipmap.obj"
	-@erase "$(INTDIR)\ilu_mipmap.sbr"
	-@erase "$(INTDIR)\ilu_noise.obj"
	-@erase "$(INTDIR)\ilu_noise.sbr"
	-@erase "$(INTDIR)\ilu_region.obj"
	-@erase "$(INTDIR)\ilu_region.sbr"
	-@erase "$(INTDIR)\ilu_rotate.obj"
	-@erase "$(INTDIR)\ilu_rotate.sbr"
	-@erase "$(INTDIR)\ilu_scale.obj"
	-@erase "$(INTDIR)\ilu_scale.sbr"
	-@erase "$(INTDIR)\ilu_scale2d.obj"
	-@erase "$(INTDIR)\ilu_scale2d.sbr"
	-@erase "$(INTDIR)\ilu_scale3d.obj"
	-@erase "$(INTDIR)\ilu_scale3d.sbr"
	-@erase "$(INTDIR)\ilu_scaling.obj"
	-@erase "$(INTDIR)\ilu_scaling.sbr"
	-@erase "$(INTDIR)\ilu_states.obj"
	-@erase "$(INTDIR)\ilu_states.sbr"
	-@erase "$(INTDIR)\ilu_utilities.obj"
	-@erase "$(INTDIR)\ilu_utilities.sbr"
	-@erase "$(INTDIR)\ilut_allegro.obj"
	-@erase "$(INTDIR)\ilut_allegro.sbr"
	-@erase "$(INTDIR)\ilut_directx.obj"
	-@erase "$(INTDIR)\ilut_directx.sbr"
	-@erase "$(INTDIR)\ilut_internal.obj"
	-@erase "$(INTDIR)\ilut_internal.sbr"
	-@erase "$(INTDIR)\ilut_main.obj"
	-@erase "$(INTDIR)\ilut_main.sbr"
	-@erase "$(INTDIR)\ilut_opengl.obj"
	-@erase "$(INTDIR)\ilut_opengl.sbr"
	-@erase "$(INTDIR)\ilut_sdlsurface.obj"
	-@erase "$(INTDIR)\ilut_sdlsurface.sbr"
	-@erase "$(INTDIR)\ilut_states.obj"
	-@erase "$(INTDIR)\ilut_states.sbr"
	-@erase "$(INTDIR)\ilut_win32.obj"
	-@erase "$(INTDIR)\ilut_win32.sbr"
	-@erase "$(INTDIR)\InputDialog.obj"
	-@erase "$(INTDIR)\InputDialog.sbr"
	-@erase "$(INTDIR)\MainFrm.obj"
	-@erase "$(INTDIR)\MainFrm.sbr"
	-@erase "$(INTDIR)\mwcommon.obj"
	-@erase "$(INTDIR)\mwcommon.sbr"
	-@erase "$(INTDIR)\MWEdit.obj"
	-@erase "$(INTDIR)\MWEdit.pch"
	-@erase "$(INTDIR)\MWEdit.res"
	-@erase "$(INTDIR)\MWEdit.sbr"
	-@erase "$(INTDIR)\MWEditDoc.obj"
	-@erase "$(INTDIR)\MWEditDoc.sbr"
	-@erase "$(INTDIR)\MWEditView.obj"
	-@erase "$(INTDIR)\MWEditView.sbr"
	-@erase "$(INTDIR)\namelist.obj"
	-@erase "$(INTDIR)\namelist.sbr"
	-@erase "$(INTDIR)\OpenPluginDlg.obj"
	-@erase "$(INTDIR)\OpenPluginDlg.sbr"
	-@erase "$(INTDIR)\ptrarray.obj"
	-@erase "$(INTDIR)\ptrarray.sbr"
	-@erase "$(INTDIR)\ScriptErrorDlg.obj"
	-@erase "$(INTDIR)\ScriptErrorDlg.sbr"
	-@erase "$(INTDIR)\ScriptErrorView.obj"
	-@erase "$(INTDIR)\ScriptErrorView.sbr"
	-@erase "$(INTDIR)\ScriptTemplate.obj"
	-@erase "$(INTDIR)\ScriptTemplate.sbr"
	-@erase "$(INTDIR)\SString.obj"
	-@erase "$(INTDIR)\SString.sbr"
	-@erase "$(INTDIR)\StdAfx.obj"
	-@erase "$(INTDIR)\StdAfx.sbr"
	-@erase "$(INTDIR)\TabCtrlSheet.obj"
	-@erase "$(INTDIR)\TabCtrlSheet.sbr"
	-@erase "$(INTDIR)\temarray.obj"
	-@erase "$(INTDIR)\temarray.sbr"
	-@erase "$(INTDIR)\tstfile.obj"
	-@erase "$(INTDIR)\tstfile.sbr"
	-@erase "$(INTDIR)\vc60.idb"
	-@erase "$(INTDIR)\vc60.pdb"
	-@erase "$(INTDIR)\WinUtil.obj"
	-@erase "$(INTDIR)\WinUtil.sbr"
	-@erase "$(OUTDIR)\MWEdit.bsc"
	-@erase "$(OUTDIR)\MWEdit.exe"
	-@erase "$(OUTDIR)\MWEdit.ilk"
	-@erase "$(OUTDIR)\MWEdit.pdb"
	-@erase ".\Debug\MWEdit.cnt"
	-@erase ".\Debug\MWEdit.hlp"

"$(OUTDIR)" :
    if not exist "$(OUTDIR)/$(NULL)" mkdir "$(OUTDIR)"

CPP=cl.exe
CPP_PROJ=/nologo /MDd /W3 /Gm /GX /ZI /Od /I "d:\vcsource\esp\morrow\mwedit" /D "_DEBUG" /D "WIN32" /D "_WINDOWS" /D "_AFXDLL" /D "_MBCS" /D "NODEVILLIB" /FR"$(INTDIR)\\" /Fp"$(INTDIR)\MWEdit.pch" /Yu"stdafx.h" /Fo"$(INTDIR)\\" /Fd"$(INTDIR)\\" /FD /GZ /c 

.c{$(INTDIR)}.obj::
   $(CPP) @<<
   $(CPP_PROJ) $< 
<<

.cpp{$(INTDIR)}.obj::
   $(CPP) @<<
   $(CPP_PROJ) $< 
<<

.cxx{$(INTDIR)}.obj::
   $(CPP) @<<
   $(CPP_PROJ) $< 
<<

.c{$(INTDIR)}.sbr::
   $(CPP) @<<
   $(CPP_PROJ) $< 
<<

.cpp{$(INTDIR)}.sbr::
   $(CPP) @<<
   $(CPP_PROJ) $< 
<<

.cxx{$(INTDIR)}.sbr::
   $(CPP) @<<
   $(CPP_PROJ) $< 
<<

MTL=midl.exe
MTL_PROJ=/nologo /D "_DEBUG" /mktyplib203 /win32 
RSC=rc.exe
RSC_PROJ=/l 0x1009 /fo"$(INTDIR)\MWEdit.res" /d "_DEBUG" /d "_AFXDLL" 
BSC32=bscmake.exe
BSC32_FLAGS=/nologo /o"$(OUTDIR)\MWEdit.bsc" 
BSC32_SBRS= \
	"$(INTDIR)\ActivatorDlg.sbr" \
	"$(INTDIR)\EsmAiActivateDlg.sbr" \
	"$(INTDIR)\EsmAiEscortDlg.sbr" \
	"$(INTDIR)\EsmAiTravelDlg.sbr" \
	"$(INTDIR)\EsmAiWanderDlg.sbr" \
	"$(INTDIR)\EsmAlchemyDlg.sbr" \
	"$(INTDIR)\EsmApparatusDlg.sbr" \
	"$(INTDIR)\EsmArmorDlg.sbr" \
	"$(INTDIR)\EsmBirthSignDlg.sbr" \
	"$(INTDIR)\EsmBodyPartDlg.sbr" \
	"$(INTDIR)\EsmBookDlg.sbr" \
	"$(INTDIR)\EsmClassDlg.sbr" \
	"$(INTDIR)\EsmClothingDlg.sbr" \
	"$(INTDIR)\EsmContainDlg.sbr" \
	"$(INTDIR)\EsmDialogDlg.sbr" \
	"$(INTDIR)\EsmDoorDlg.sbr" \
	"$(INTDIR)\EsmEffectDlg.sbr" \
	"$(INTDIR)\EsmEnchantDlg.sbr" \
	"$(INTDIR)\EsmFactionDlg.sbr" \
	"$(INTDIR)\EsmGlobalDlg.sbr" \
	"$(INTDIR)\EsmInfoDlg.sbr" \
	"$(INTDIR)\EsmIngrediantDlg.sbr" \
	"$(INTDIR)\EsmJournalDlg.sbr" \
	"$(INTDIR)\EsmLevelCreaDlg.sbr" \
	"$(INTDIR)\EsmLevelItemDlg.sbr" \
	"$(INTDIR)\EsmLightDlg.sbr" \
	"$(INTDIR)\EsmLockPickDlg.sbr" \
	"$(INTDIR)\EsmMiscDlg.sbr" \
	"$(INTDIR)\EsmProbeDlg.sbr" \
	"$(INTDIR)\EsmRaceDlg.sbr" \
	"$(INTDIR)\EsmRegionDlg.sbr" \
	"$(INTDIR)\EsmRepairDlg.sbr" \
	"$(INTDIR)\EsmSettingDlg.sbr" \
	"$(INTDIR)\EsmSkillDlg.sbr" \
	"$(INTDIR)\EsmSoundDlg.sbr" \
	"$(INTDIR)\EsmSoundGenDlg.sbr" \
	"$(INTDIR)\EsmSpellDlg.sbr" \
	"$(INTDIR)\EsmStartScriptDlg.sbr" \
	"$(INTDIR)\EsmStaticDlg.sbr" \
	"$(INTDIR)\EsmWeaponDlg.sbr" \
	"$(INTDIR)\CreaturePage1.sbr" \
	"$(INTDIR)\CreaturePage2.sbr" \
	"$(INTDIR)\EsmCreatureDlg.sbr" \
	"$(INTDIR)\EsmCreaturePage1.sbr" \
	"$(INTDIR)\EsmCreaturePage2.sbr" \
	"$(INTDIR)\EsmCreaturePage3.sbr" \
	"$(INTDIR)\EsmCreaturePage4.sbr" \
	"$(INTDIR)\EsmCreaturePage5.sbr" \
	"$(INTDIR)\EsmCellDlg.sbr" \
	"$(INTDIR)\EsmCellRefDlg.sbr" \
	"$(INTDIR)\EsmExtCellPage.sbr" \
	"$(INTDIR)\EsmIntCellPage.sbr" \
	"$(INTDIR)\EsmRefCellPage.sbr" \
	"$(INTDIR)\ChildFrmScript.sbr" \
	"$(INTDIR)\EsmFuncHelpView.sbr" \
	"$(INTDIR)\EsmScriptDlg.sbr" \
	"$(INTDIR)\ScriptErrorDlg.sbr" \
	"$(INTDIR)\ScriptErrorView.sbr" \
	"$(INTDIR)\EsmNpcDlg.sbr" \
	"$(INTDIR)\EsmNpcPage1.sbr" \
	"$(INTDIR)\EsmNpcPage2.sbr" \
	"$(INTDIR)\EsmNpcPage3.sbr" \
	"$(INTDIR)\EsmNpcPage4.sbr" \
	"$(INTDIR)\EsmNpcPage5.sbr" \
	"$(INTDIR)\EsmDlgArray.sbr" \
	"$(INTDIR)\EsmRecDialog.sbr" \
	"$(INTDIR)\ChildFrm.sbr" \
	"$(INTDIR)\ChildFrmFix.sbr" \
	"$(INTDIR)\ChildFrmVar.sbr" \
	"$(INTDIR)\MainFrm.sbr" \
	"$(INTDIR)\ColorStatic1.sbr" \
	"$(INTDIR)\CustRichEdit.sbr" \
	"$(INTDIR)\EsmIconFrame.sbr" \
	"$(INTDIR)\EsmListCtrl.sbr" \
	"$(INTDIR)\EsmSubListCtrl.sbr" \
	"$(INTDIR)\InputDialog.sbr" \
	"$(INTDIR)\EsmScrTempPage1.sbr" \
	"$(INTDIR)\EsmScrTempPage2.sbr" \
	"$(INTDIR)\EsmScrTempPage3.sbr" \
	"$(INTDIR)\EsmScrTempView.sbr" \
	"$(INTDIR)\ScriptTemplate.sbr" \
	"$(INTDIR)\EsmCsvImportDlg.sbr" \
	"$(INTDIR)\EsmFindDlg.sbr" \
	"$(INTDIR)\EsmHeaderDlg.sbr" \
	"$(INTDIR)\EsmLoadDlg.sbr" \
	"$(INTDIR)\EsmOptionsDlg.sbr" \
	"$(INTDIR)\EsmUsesDlg.sbr" \
	"$(INTDIR)\MWEditView.sbr" \
	"$(INTDIR)\OpenPluginDlg.sbr" \
	"$(INTDIR)\StdAfx.sbr" \
	"$(INTDIR)\csvfile.sbr" \
	"$(INTDIR)\dl_base.sbr" \
	"$(INTDIR)\dl_block.sbr" \
	"$(INTDIR)\dl_chr.sbr" \
	"$(INTDIR)\dl_err.sbr" \
	"$(INTDIR)\dl_file.sbr" \
	"$(INTDIR)\dl_log.sbr" \
	"$(INTDIR)\dl_math.sbr" \
	"$(INTDIR)\dl_mem.sbr" \
	"$(INTDIR)\dl_str.sbr" \
	"$(INTDIR)\dl_time.sbr" \
	"$(INTDIR)\dl_ToolTip.sbr" \
	"$(INTDIR)\genfile.sbr" \
	"$(INTDIR)\genfind.sbr" \
	"$(INTDIR)\GenStack.sbr" \
	"$(INTDIR)\mwcommon.sbr" \
	"$(INTDIR)\namelist.sbr" \
	"$(INTDIR)\ptrarray.sbr" \
	"$(INTDIR)\SString.sbr" \
	"$(INTDIR)\TabCtrlSheet.sbr" \
	"$(INTDIR)\temarray.sbr" \
	"$(INTDIR)\tstfile.sbr" \
	"$(INTDIR)\WinUtil.sbr" \
	"$(INTDIR)\EsmActivator.sbr" \
	"$(INTDIR)\EsmAlchemy.sbr" \
	"$(INTDIR)\EsmApparatus.sbr" \
	"$(INTDIR)\EsmArmor.sbr" \
	"$(INTDIR)\EsmBirthSign.sbr" \
	"$(INTDIR)\EsmBodyPart.sbr" \
	"$(INTDIR)\EsmBook.sbr" \
	"$(INTDIR)\EsmCell.sbr" \
	"$(INTDIR)\EsmClass.sbr" \
	"$(INTDIR)\EsmClothing.sbr" \
	"$(INTDIR)\EsmContainer.sbr" \
	"$(INTDIR)\EsmCreature.sbr" \
	"$(INTDIR)\EsmDialogue.sbr" \
	"$(INTDIR)\EsmDoor.sbr" \
	"$(INTDIR)\EsmEnchant.sbr" \
	"$(INTDIR)\EsmFaction.sbr" \
	"$(INTDIR)\EsmGameSetting.sbr" \
	"$(INTDIR)\EsmGlobal.sbr" \
	"$(INTDIR)\EsmInfo.sbr" \
	"$(INTDIR)\EsmIngrediant.sbr" \
	"$(INTDIR)\EsmItem1.sbr" \
	"$(INTDIR)\EsmItem2.sbr" \
	"$(INTDIR)\EsmItem3.sbr" \
	"$(INTDIR)\EsmLand.sbr" \
	"$(INTDIR)\EsmLevelCrea.sbr" \
	"$(INTDIR)\EsmLevelItem.sbr" \
	"$(INTDIR)\EsmLight.sbr" \
	"$(INTDIR)\EsmLockPick.sbr" \
	"$(INTDIR)\EsmMagicEffect.sbr" \
	"$(INTDIR)\EsmMisc.sbr" \
	"$(INTDIR)\EsmNpc.sbr" \
	"$(INTDIR)\EsmProbe.sbr" \
	"$(INTDIR)\EsmRace.sbr" \
	"$(INTDIR)\EsmRecord.sbr" \
	"$(INTDIR)\EsmRegion.sbr" \
	"$(INTDIR)\EsmRepair.sbr" \
	"$(INTDIR)\EsmScript.sbr" \
	"$(INTDIR)\EsmSkill.sbr" \
	"$(INTDIR)\EsmSound.sbr" \
	"$(INTDIR)\EsmSoundGen.sbr" \
	"$(INTDIR)\EsmSpell.sbr" \
	"$(INTDIR)\EsmStartScript.sbr" \
	"$(INTDIR)\EsmStatic.sbr" \
	"$(INTDIR)\EsmTES3.sbr" \
	"$(INTDIR)\EsmWeapon.sbr" \
	"$(INTDIR)\EsmSubBase.sbr" \
	"$(INTDIR)\EsmSubCellRef.sbr" \
	"$(INTDIR)\EsmSubName.sbr" \
	"$(INTDIR)\EsmSubSCVR.sbr" \
	"$(INTDIR)\EsmScrFuncArray.sbr" \
	"$(INTDIR)\EsmScrFuncData.sbr" \
	"$(INTDIR)\EsmScriptCompile.sbr" \
	"$(INTDIR)\EsmScriptDefs.sbr" \
	"$(INTDIR)\EsmScriptError.sbr" \
	"$(INTDIR)\EsmScriptFuncs.sbr" \
	"$(INTDIR)\EsmScriptOptions.sbr" \
	"$(INTDIR)\EsmBase.sbr" \
	"$(INTDIR)\EsmCsvDefs.sbr" \
	"$(INTDIR)\EsmFile.sbr" \
	"$(INTDIR)\EsmGlobOptions.sbr" \
	"$(INTDIR)\EsmOptions.sbr" \
	"$(INTDIR)\EsmUtils.sbr" \
	"$(INTDIR)\il_alloc.sbr" \
	"$(INTDIR)\il_bits.sbr" \
	"$(INTDIR)\il_bmp.sbr" \
	"$(INTDIR)\il_convbuff.sbr" \
	"$(INTDIR)\il_convert.sbr" \
	"$(INTDIR)\il_cut.sbr" \
	"$(INTDIR)\il_dcx.sbr" \
	"$(INTDIR)\il_dds-save.sbr" \
	"$(INTDIR)\il_dds.sbr" \
	"$(INTDIR)\il_devil.sbr" \
	"$(INTDIR)\il_doom.sbr" \
	"$(INTDIR)\il_endian.sbr" \
	"$(INTDIR)\il_error.sbr" \
	"$(INTDIR)\il_fastconv.sbr" \
	"$(INTDIR)\il_files.sbr" \
	"$(INTDIR)\il_gif.sbr" \
	"$(INTDIR)\il_header.sbr" \
	"$(INTDIR)\il_icon.sbr" \
	"$(INTDIR)\il_internal.sbr" \
	"$(INTDIR)\il_io.sbr" \
	"$(INTDIR)\il_jpeg.sbr" \
	"$(INTDIR)\il_lif.sbr" \
	"$(INTDIR)\il_main.sbr" \
	"$(INTDIR)\il_manip.sbr" \
	"$(INTDIR)\il_mdl.sbr" \
	"$(INTDIR)\il_mng.sbr" \
	"$(INTDIR)\il_neuquant.sbr" \
	"$(INTDIR)\il_pal.sbr" \
	"$(INTDIR)\il_pcd.sbr" \
	"$(INTDIR)\il_pcx.sbr" \
	"$(INTDIR)\il_pic.sbr" \
	"$(INTDIR)\il_pix.sbr" \
	"$(INTDIR)\il_png.sbr" \
	"$(INTDIR)\il_pnm.sbr" \
	"$(INTDIR)\il_profiles.sbr" \
	"$(INTDIR)\il_psd.sbr" \
	"$(INTDIR)\il_psp.sbr" \
	"$(INTDIR)\il_pxr.sbr" \
	"$(INTDIR)\il_quantizer.sbr" \
	"$(INTDIR)\il_raw.sbr" \
	"$(INTDIR)\il_rawdata.sbr" \
	"$(INTDIR)\il_register.sbr" \
	"$(INTDIR)\il_rle.sbr" \
	"$(INTDIR)\il_sgi.sbr" \
	"$(INTDIR)\il_stack.sbr" \
	"$(INTDIR)\il_states.sbr" \
	"$(INTDIR)\il_targa.sbr" \
	"$(INTDIR)\il_tiff.sbr" \
	"$(INTDIR)\il_utility.sbr" \
	"$(INTDIR)\il_wal.sbr" \
	"$(INTDIR)\il_xpm.sbr" \
	"$(INTDIR)\ilu_alloc.sbr" \
	"$(INTDIR)\ilu_error.sbr" \
	"$(INTDIR)\ilu_filter.sbr" \
	"$(INTDIR)\ilu_filter_rcg.sbr" \
	"$(INTDIR)\ilu_internal.sbr" \
	"$(INTDIR)\ilu_main.sbr" \
	"$(INTDIR)\ilu_manip.sbr" \
	"$(INTDIR)\ilu_mipmap.sbr" \
	"$(INTDIR)\ilu_noise.sbr" \
	"$(INTDIR)\ilu_region.sbr" \
	"$(INTDIR)\ilu_rotate.sbr" \
	"$(INTDIR)\ilu_scale.sbr" \
	"$(INTDIR)\ilu_scale2d.sbr" \
	"$(INTDIR)\ilu_scale3d.sbr" \
	"$(INTDIR)\ilu_scaling.sbr" \
	"$(INTDIR)\ilu_states.sbr" \
	"$(INTDIR)\ilu_utilities.sbr" \
	"$(INTDIR)\ilut_allegro.sbr" \
	"$(INTDIR)\ilut_directx.sbr" \
	"$(INTDIR)\ilut_internal.sbr" \
	"$(INTDIR)\ilut_main.sbr" \
	"$(INTDIR)\ilut_opengl.sbr" \
	"$(INTDIR)\ilut_sdlsurface.sbr" \
	"$(INTDIR)\ilut_states.sbr" \
	"$(INTDIR)\ilut_win32.sbr" \
	"$(INTDIR)\MWEdit.sbr" \
	"$(INTDIR)\MWEditDoc.sbr"

"$(OUTDIR)\MWEdit.bsc" : "$(OUTDIR)" $(BSC32_SBRS)
    $(BSC32) @<<
  $(BSC32_FLAGS) $(BSC32_SBRS)
<<

LINK32=link.exe
LINK32_FLAGS=/nologo /subsystem:windows /incremental:yes /pdb:"$(OUTDIR)\MWEdit.pdb" /debug /machine:I386 /out:"$(OUTDIR)\MWEdit.exe" /pdbtype:sept 
LINK32_OBJS= \
	"$(INTDIR)\ActivatorDlg.obj" \
	"$(INTDIR)\EsmAiActivateDlg.obj" \
	"$(INTDIR)\EsmAiEscortDlg.obj" \
	"$(INTDIR)\EsmAiTravelDlg.obj" \
	"$(INTDIR)\EsmAiWanderDlg.obj" \
	"$(INTDIR)\EsmAlchemyDlg.obj" \
	"$(INTDIR)\EsmApparatusDlg.obj" \
	"$(INTDIR)\EsmArmorDlg.obj" \
	"$(INTDIR)\EsmBirthSignDlg.obj" \
	"$(INTDIR)\EsmBodyPartDlg.obj" \
	"$(INTDIR)\EsmBookDlg.obj" \
	"$(INTDIR)\EsmClassDlg.obj" \
	"$(INTDIR)\EsmClothingDlg.obj" \
	"$(INTDIR)\EsmContainDlg.obj" \
	"$(INTDIR)\EsmDialogDlg.obj" \
	"$(INTDIR)\EsmDoorDlg.obj" \
	"$(INTDIR)\EsmEffectDlg.obj" \
	"$(INTDIR)\EsmEnchantDlg.obj" \
	"$(INTDIR)\EsmFactionDlg.obj" \
	"$(INTDIR)\EsmGlobalDlg.obj" \
	"$(INTDIR)\EsmInfoDlg.obj" \
	"$(INTDIR)\EsmIngrediantDlg.obj" \
	"$(INTDIR)\EsmJournalDlg.obj" \
	"$(INTDIR)\EsmLevelCreaDlg.obj" \
	"$(INTDIR)\EsmLevelItemDlg.obj" \
	"$(INTDIR)\EsmLightDlg.obj" \
	"$(INTDIR)\EsmLockPickDlg.obj" \
	"$(INTDIR)\EsmMiscDlg.obj" \
	"$(INTDIR)\EsmProbeDlg.obj" \
	"$(INTDIR)\EsmRaceDlg.obj" \
	"$(INTDIR)\EsmRegionDlg.obj" \
	"$(INTDIR)\EsmRepairDlg.obj" \
	"$(INTDIR)\EsmSettingDlg.obj" \
	"$(INTDIR)\EsmSkillDlg.obj" \
	"$(INTDIR)\EsmSoundDlg.obj" \
	"$(INTDIR)\EsmSoundGenDlg.obj" \
	"$(INTDIR)\EsmSpellDlg.obj" \
	"$(INTDIR)\EsmStartScriptDlg.obj" \
	"$(INTDIR)\EsmStaticDlg.obj" \
	"$(INTDIR)\EsmWeaponDlg.obj" \
	"$(INTDIR)\CreaturePage1.obj" \
	"$(INTDIR)\CreaturePage2.obj" \
	"$(INTDIR)\EsmCreatureDlg.obj" \
	"$(INTDIR)\EsmCreaturePage1.obj" \
	"$(INTDIR)\EsmCreaturePage2.obj" \
	"$(INTDIR)\EsmCreaturePage3.obj" \
	"$(INTDIR)\EsmCreaturePage4.obj" \
	"$(INTDIR)\EsmCreaturePage5.obj" \
	"$(INTDIR)\EsmCellDlg.obj" \
	"$(INTDIR)\EsmCellRefDlg.obj" \
	"$(INTDIR)\EsmExtCellPage.obj" \
	"$(INTDIR)\EsmIntCellPage.obj" \
	"$(INTDIR)\EsmRefCellPage.obj" \
	"$(INTDIR)\ChildFrmScript.obj" \
	"$(INTDIR)\EsmFuncHelpView.obj" \
	"$(INTDIR)\EsmScriptDlg.obj" \
	"$(INTDIR)\ScriptErrorDlg.obj" \
	"$(INTDIR)\ScriptErrorView.obj" \
	"$(INTDIR)\EsmNpcDlg.obj" \
	"$(INTDIR)\EsmNpcPage1.obj" \
	"$(INTDIR)\EsmNpcPage2.obj" \
	"$(INTDIR)\EsmNpcPage3.obj" \
	"$(INTDIR)\EsmNpcPage4.obj" \
	"$(INTDIR)\EsmNpcPage5.obj" \
	"$(INTDIR)\EsmDlgArray.obj" \
	"$(INTDIR)\EsmRecDialog.obj" \
	"$(INTDIR)\ChildFrm.obj" \
	"$(INTDIR)\ChildFrmFix.obj" \
	"$(INTDIR)\ChildFrmVar.obj" \
	"$(INTDIR)\MainFrm.obj" \
	"$(INTDIR)\ColorStatic1.obj" \
	"$(INTDIR)\CustRichEdit.obj" \
	"$(INTDIR)\EsmIconFrame.obj" \
	"$(INTDIR)\EsmListCtrl.obj" \
	"$(INTDIR)\EsmSubListCtrl.obj" \
	"$(INTDIR)\InputDialog.obj" \
	"$(INTDIR)\EsmScrTempPage1.obj" \
	"$(INTDIR)\EsmScrTempPage2.obj" \
	"$(INTDIR)\EsmScrTempPage3.obj" \
	"$(INTDIR)\EsmScrTempView.obj" \
	"$(INTDIR)\ScriptTemplate.obj" \
	"$(INTDIR)\EsmCsvImportDlg.obj" \
	"$(INTDIR)\EsmFindDlg.obj" \
	"$(INTDIR)\EsmHeaderDlg.obj" \
	"$(INTDIR)\EsmLoadDlg.obj" \
	"$(INTDIR)\EsmOptionsDlg.obj" \
	"$(INTDIR)\EsmUsesDlg.obj" \
	"$(INTDIR)\MWEditView.obj" \
	"$(INTDIR)\OpenPluginDlg.obj" \
	"$(INTDIR)\StdAfx.obj" \
	"$(INTDIR)\csvfile.obj" \
	"$(INTDIR)\dl_base.obj" \
	"$(INTDIR)\dl_block.obj" \
	"$(INTDIR)\dl_chr.obj" \
	"$(INTDIR)\dl_err.obj" \
	"$(INTDIR)\dl_file.obj" \
	"$(INTDIR)\dl_log.obj" \
	"$(INTDIR)\dl_math.obj" \
	"$(INTDIR)\dl_mem.obj" \
	"$(INTDIR)\dl_str.obj" \
	"$(INTDIR)\dl_time.obj" \
	"$(INTDIR)\dl_ToolTip.obj" \
	"$(INTDIR)\genfile.obj" \
	"$(INTDIR)\genfind.obj" \
	"$(INTDIR)\GenStack.obj" \
	"$(INTDIR)\mwcommon.obj" \
	"$(INTDIR)\namelist.obj" \
	"$(INTDIR)\ptrarray.obj" \
	"$(INTDIR)\SString.obj" \
	"$(INTDIR)\TabCtrlSheet.obj" \
	"$(INTDIR)\temarray.obj" \
	"$(INTDIR)\tstfile.obj" \
	"$(INTDIR)\WinUtil.obj" \
	"$(INTDIR)\EsmActivator.obj" \
	"$(INTDIR)\EsmAlchemy.obj" \
	"$(INTDIR)\EsmApparatus.obj" \
	"$(INTDIR)\EsmArmor.obj" \
	"$(INTDIR)\EsmBirthSign.obj" \
	"$(INTDIR)\EsmBodyPart.obj" \
	"$(INTDIR)\EsmBook.obj" \
	"$(INTDIR)\EsmCell.obj" \
	"$(INTDIR)\EsmClass.obj" \
	"$(INTDIR)\EsmClothing.obj" \
	"$(INTDIR)\EsmContainer.obj" \
	"$(INTDIR)\EsmCreature.obj" \
	"$(INTDIR)\EsmDialogue.obj" \
	"$(INTDIR)\EsmDoor.obj" \
	"$(INTDIR)\EsmEnchant.obj" \
	"$(INTDIR)\EsmFaction.obj" \
	"$(INTDIR)\EsmGameSetting.obj" \
	"$(INTDIR)\EsmGlobal.obj" \
	"$(INTDIR)\EsmInfo.obj" \
	"$(INTDIR)\EsmIngrediant.obj" \
	"$(INTDIR)\EsmItem1.obj" \
	"$(INTDIR)\EsmItem2.obj" \
	"$(INTDIR)\EsmItem3.obj" \
	"$(INTDIR)\EsmLand.obj" \
	"$(INTDIR)\EsmLevelCrea.obj" \
	"$(INTDIR)\EsmLevelItem.obj" \
	"$(INTDIR)\EsmLight.obj" \
	"$(INTDIR)\EsmLockPick.obj" \
	"$(INTDIR)\EsmMagicEffect.obj" \
	"$(INTDIR)\EsmMisc.obj" \
	"$(INTDIR)\EsmNpc.obj" \
	"$(INTDIR)\EsmProbe.obj" \
	"$(INTDIR)\EsmRace.obj" \
	"$(INTDIR)\EsmRecord.obj" \
	"$(INTDIR)\EsmRegion.obj" \
	"$(INTDIR)\EsmRepair.obj" \
	"$(INTDIR)\EsmScript.obj" \
	"$(INTDIR)\EsmSkill.obj" \
	"$(INTDIR)\EsmSound.obj" \
	"$(INTDIR)\EsmSoundGen.obj" \
	"$(INTDIR)\EsmSpell.obj" \
	"$(INTDIR)\EsmStartScript.obj" \
	"$(INTDIR)\EsmStatic.obj" \
	"$(INTDIR)\EsmTES3.obj" \
	"$(INTDIR)\EsmWeapon.obj" \
	"$(INTDIR)\EsmSubBase.obj" \
	"$(INTDIR)\EsmSubCellRef.obj" \
	"$(INTDIR)\EsmSubName.obj" \
	"$(INTDIR)\EsmSubSCVR.obj" \
	"$(INTDIR)\EsmScrFuncArray.obj" \
	"$(INTDIR)\EsmScrFuncData.obj" \
	"$(INTDIR)\EsmScriptCompile.obj" \
	"$(INTDIR)\EsmScriptDefs.obj" \
	"$(INTDIR)\EsmScriptError.obj" \
	"$(INTDIR)\EsmScriptFuncs.obj" \
	"$(INTDIR)\EsmScriptOptions.obj" \
	"$(INTDIR)\EsmBase.obj" \
	"$(INTDIR)\EsmCsvDefs.obj" \
	"$(INTDIR)\EsmFile.obj" \
	"$(INTDIR)\EsmGlobOptions.obj" \
	"$(INTDIR)\EsmOptions.obj" \
	"$(INTDIR)\EsmUtils.obj" \
	"$(INTDIR)\il_alloc.obj" \
	"$(INTDIR)\il_bits.obj" \
	"$(INTDIR)\il_bmp.obj" \
	"$(INTDIR)\il_convbuff.obj" \
	"$(INTDIR)\il_convert.obj" \
	"$(INTDIR)\il_cut.obj" \
	"$(INTDIR)\il_dcx.obj" \
	"$(INTDIR)\il_dds-save.obj" \
	"$(INTDIR)\il_dds.obj" \
	"$(INTDIR)\il_devil.obj" \
	"$(INTDIR)\il_doom.obj" \
	"$(INTDIR)\il_endian.obj" \
	"$(INTDIR)\il_error.obj" \
	"$(INTDIR)\il_fastconv.obj" \
	"$(INTDIR)\il_files.obj" \
	"$(INTDIR)\il_gif.obj" \
	"$(INTDIR)\il_header.obj" \
	"$(INTDIR)\il_icon.obj" \
	"$(INTDIR)\il_internal.obj" \
	"$(INTDIR)\il_io.obj" \
	"$(INTDIR)\il_jpeg.obj" \
	"$(INTDIR)\il_lif.obj" \
	"$(INTDIR)\il_main.obj" \
	"$(INTDIR)\il_manip.obj" \
	"$(INTDIR)\il_mdl.obj" \
	"$(INTDIR)\il_mng.obj" \
	"$(INTDIR)\il_neuquant.obj" \
	"$(INTDIR)\il_pal.obj" \
	"$(INTDIR)\il_pcd.obj" \
	"$(INTDIR)\il_pcx.obj" \
	"$(INTDIR)\il_pic.obj" \
	"$(INTDIR)\il_pix.obj" \
	"$(INTDIR)\il_png.obj" \
	"$(INTDIR)\il_pnm.obj" \
	"$(INTDIR)\il_profiles.obj" \
	"$(INTDIR)\il_psd.obj" \
	"$(INTDIR)\il_psp.obj" \
	"$(INTDIR)\il_pxr.obj" \
	"$(INTDIR)\il_quantizer.obj" \
	"$(INTDIR)\il_raw.obj" \
	"$(INTDIR)\il_rawdata.obj" \
	"$(INTDIR)\il_register.obj" \
	"$(INTDIR)\il_rle.obj" \
	"$(INTDIR)\il_sgi.obj" \
	"$(INTDIR)\il_stack.obj" \
	"$(INTDIR)\il_states.obj" \
	"$(INTDIR)\il_targa.obj" \
	"$(INTDIR)\il_tiff.obj" \
	"$(INTDIR)\il_utility.obj" \
	"$(INTDIR)\il_wal.obj" \
	"$(INTDIR)\il_xpm.obj" \
	"$(INTDIR)\ilu_alloc.obj" \
	"$(INTDIR)\ilu_error.obj" \
	"$(INTDIR)\ilu_filter.obj" \
	"$(INTDIR)\ilu_filter_rcg.obj" \
	"$(INTDIR)\ilu_internal.obj" \
	"$(INTDIR)\ilu_main.obj" \
	"$(INTDIR)\ilu_manip.obj" \
	"$(INTDIR)\ilu_mipmap.obj" \
	"$(INTDIR)\ilu_noise.obj" \
	"$(INTDIR)\ilu_region.obj" \
	"$(INTDIR)\ilu_rotate.obj" \
	"$(INTDIR)\ilu_scale.obj" \
	"$(INTDIR)\ilu_scale2d.obj" \
	"$(INTDIR)\ilu_scale3d.obj" \
	"$(INTDIR)\ilu_scaling.obj" \
	"$(INTDIR)\ilu_states.obj" \
	"$(INTDIR)\ilu_utilities.obj" \
	"$(INTDIR)\ilut_allegro.obj" \
	"$(INTDIR)\ilut_directx.obj" \
	"$(INTDIR)\ilut_internal.obj" \
	"$(INTDIR)\ilut_main.obj" \
	"$(INTDIR)\ilut_opengl.obj" \
	"$(INTDIR)\ilut_sdlsurface.obj" \
	"$(INTDIR)\ilut_states.obj" \
	"$(INTDIR)\ilut_win32.obj" \
	"$(INTDIR)\MWEdit.obj" \
	"$(INTDIR)\MWEditDoc.obj" \
	"$(INTDIR)\MWEdit.res" \
	"C:\Programs\MsVs\VC98\Lib\WINMM.LIB"

"$(OUTDIR)\MWEdit.exe" : "$(OUTDIR)" $(DEF_FILE) $(LINK32_OBJS)
    $(LINK32) @<<
  $(LINK32_FLAGS) $(LINK32_OBJS)
<<

!ENDIF 


!IF "$(NO_EXTERNAL_DEPS)" != "1"
!IF EXISTS("MWEdit.dep")
!INCLUDE "MWEdit.dep"
!ELSE 
!MESSAGE Warning: cannot find "MWEdit.dep"
!ENDIF 
!ENDIF 


!IF "$(CFG)" == "MWEdit - Win32 Release" || "$(CFG)" == "MWEdit - Win32 Debug"
SOURCE=.\ActivatorDlg.cpp

"$(INTDIR)\ActivatorDlg.obj"	"$(INTDIR)\ActivatorDlg.sbr" : $(SOURCE) "$(INTDIR)" "$(INTDIR)\MWEdit.pch"


SOURCE=.\EsmAiActivateDlg.cpp

"$(INTDIR)\EsmAiActivateDlg.obj"	"$(INTDIR)\EsmAiActivateDlg.sbr" : $(SOURCE) "$(INTDIR)" "$(INTDIR)\MWEdit.pch"


SOURCE=.\EsmAiEscortDlg.cpp

"$(INTDIR)\EsmAiEscortDlg.obj"	"$(INTDIR)\EsmAiEscortDlg.sbr" : $(SOURCE) "$(INTDIR)" "$(INTDIR)\MWEdit.pch"


SOURCE=.\EsmAiTravelDlg.cpp

"$(INTDIR)\EsmAiTravelDlg.obj"	"$(INTDIR)\EsmAiTravelDlg.sbr" : $(SOURCE) "$(INTDIR)" "$(INTDIR)\MWEdit.pch"


SOURCE=.\EsmAiWanderDlg.cpp

"$(INTDIR)\EsmAiWanderDlg.obj"	"$(INTDIR)\EsmAiWanderDlg.sbr" : $(SOURCE) "$(INTDIR)" "$(INTDIR)\MWEdit.pch"


SOURCE=.\EsmAlchemyDlg.cpp

"$(INTDIR)\EsmAlchemyDlg.obj"	"$(INTDIR)\EsmAlchemyDlg.sbr" : $(SOURCE) "$(INTDIR)" "$(INTDIR)\MWEdit.pch"


SOURCE=.\EsmApparatusDlg.cpp

"$(INTDIR)\EsmApparatusDlg.obj"	"$(INTDIR)\EsmApparatusDlg.sbr" : $(SOURCE) "$(INTDIR)" "$(INTDIR)\MWEdit.pch"


SOURCE=.\EsmArmorDlg.cpp

"$(INTDIR)\EsmArmorDlg.obj"	"$(INTDIR)\EsmArmorDlg.sbr" : $(SOURCE) "$(INTDIR)" "$(INTDIR)\MWEdit.pch"


SOURCE=.\EsmBirthSignDlg.cpp

"$(INTDIR)\EsmBirthSignDlg.obj"	"$(INTDIR)\EsmBirthSignDlg.sbr" : $(SOURCE) "$(INTDIR)" "$(INTDIR)\MWEdit.pch"


SOURCE=.\EsmBodyPartDlg.cpp

"$(INTDIR)\EsmBodyPartDlg.obj"	"$(INTDIR)\EsmBodyPartDlg.sbr" : $(SOURCE) "$(INTDIR)" "$(INTDIR)\MWEdit.pch"


SOURCE=.\EsmBookDlg.cpp

"$(INTDIR)\EsmBookDlg.obj"	"$(INTDIR)\EsmBookDlg.sbr" : $(SOURCE) "$(INTDIR)" "$(INTDIR)\MWEdit.pch"


SOURCE=.\EsmClassDlg.cpp

"$(INTDIR)\EsmClassDlg.obj"	"$(INTDIR)\EsmClassDlg.sbr" : $(SOURCE) "$(INTDIR)" "$(INTDIR)\MWEdit.pch"


SOURCE=.\EsmClothingDlg.cpp

"$(INTDIR)\EsmClothingDlg.obj"	"$(INTDIR)\EsmClothingDlg.sbr" : $(SOURCE) "$(INTDIR)" "$(INTDIR)\MWEdit.pch"


SOURCE=.\EsmContainDlg.cpp

"$(INTDIR)\EsmContainDlg.obj"	"$(INTDIR)\EsmContainDlg.sbr" : $(SOURCE) "$(INTDIR)" "$(INTDIR)\MWEdit.pch"


SOURCE=.\EsmDialogDlg.cpp

"$(INTDIR)\EsmDialogDlg.obj"	"$(INTDIR)\EsmDialogDlg.sbr" : $(SOURCE) "$(INTDIR)" "$(INTDIR)\MWEdit.pch"


SOURCE=.\EsmDoorDlg.cpp

"$(INTDIR)\EsmDoorDlg.obj"	"$(INTDIR)\EsmDoorDlg.sbr" : $(SOURCE) "$(INTDIR)" "$(INTDIR)\MWEdit.pch"


SOURCE=.\EsmEffectDlg.cpp

"$(INTDIR)\EsmEffectDlg.obj"	"$(INTDIR)\EsmEffectDlg.sbr" : $(SOURCE) "$(INTDIR)" "$(INTDIR)\MWEdit.pch"


SOURCE=.\EsmEnchantDlg.cpp

"$(INTDIR)\EsmEnchantDlg.obj"	"$(INTDIR)\EsmEnchantDlg.sbr" : $(SOURCE) "$(INTDIR)" "$(INTDIR)\MWEdit.pch"


SOURCE=.\EsmFactionDlg.cpp

"$(INTDIR)\EsmFactionDlg.obj"	"$(INTDIR)\EsmFactionDlg.sbr" : $(SOURCE) "$(INTDIR)" "$(INTDIR)\MWEdit.pch"


SOURCE=.\EsmGlobalDlg.cpp

"$(INTDIR)\EsmGlobalDlg.obj"	"$(INTDIR)\EsmGlobalDlg.sbr" : $(SOURCE) "$(INTDIR)" "$(INTDIR)\MWEdit.pch"


SOURCE=.\EsmInfoDlg.cpp

"$(INTDIR)\EsmInfoDlg.obj"	"$(INTDIR)\EsmInfoDlg.sbr" : $(SOURCE) "$(INTDIR)" "$(INTDIR)\MWEdit.pch"


SOURCE=.\EsmIngrediantDlg.cpp

"$(INTDIR)\EsmIngrediantDlg.obj"	"$(INTDIR)\EsmIngrediantDlg.sbr" : $(SOURCE) "$(INTDIR)" "$(INTDIR)\MWEdit.pch"


SOURCE=.\EsmJournalDlg.cpp

"$(INTDIR)\EsmJournalDlg.obj"	"$(INTDIR)\EsmJournalDlg.sbr" : $(SOURCE) "$(INTDIR)" "$(INTDIR)\MWEdit.pch"


SOURCE=.\EsmLevelCreaDlg.cpp

"$(INTDIR)\EsmLevelCreaDlg.obj"	"$(INTDIR)\EsmLevelCreaDlg.sbr" : $(SOURCE) "$(INTDIR)" "$(INTDIR)\MWEdit.pch"


SOURCE=.\EsmLevelItemDlg.cpp

"$(INTDIR)\EsmLevelItemDlg.obj"	"$(INTDIR)\EsmLevelItemDlg.sbr" : $(SOURCE) "$(INTDIR)" "$(INTDIR)\MWEdit.pch"


SOURCE=.\EsmLightDlg.cpp

"$(INTDIR)\EsmLightDlg.obj"	"$(INTDIR)\EsmLightDlg.sbr" : $(SOURCE) "$(INTDIR)" "$(INTDIR)\MWEdit.pch"


SOURCE=.\EsmLockPickDlg.cpp

"$(INTDIR)\EsmLockPickDlg.obj"	"$(INTDIR)\EsmLockPickDlg.sbr" : $(SOURCE) "$(INTDIR)" "$(INTDIR)\MWEdit.pch"


SOURCE=.\EsmMiscDlg.cpp

"$(INTDIR)\EsmMiscDlg.obj"	"$(INTDIR)\EsmMiscDlg.sbr" : $(SOURCE) "$(INTDIR)" "$(INTDIR)\MWEdit.pch"


SOURCE=.\EsmProbeDlg.cpp

"$(INTDIR)\EsmProbeDlg.obj"	"$(INTDIR)\EsmProbeDlg.sbr" : $(SOURCE) "$(INTDIR)" "$(INTDIR)\MWEdit.pch"


SOURCE=.\EsmRaceDlg.cpp

"$(INTDIR)\EsmRaceDlg.obj"	"$(INTDIR)\EsmRaceDlg.sbr" : $(SOURCE) "$(INTDIR)" "$(INTDIR)\MWEdit.pch"


SOURCE=.\EsmRegionDlg.cpp

"$(INTDIR)\EsmRegionDlg.obj"	"$(INTDIR)\EsmRegionDlg.sbr" : $(SOURCE) "$(INTDIR)" "$(INTDIR)\MWEdit.pch"


SOURCE=.\EsmRepairDlg.cpp

"$(INTDIR)\EsmRepairDlg.obj"	"$(INTDIR)\EsmRepairDlg.sbr" : $(SOURCE) "$(INTDIR)" "$(INTDIR)\MWEdit.pch"


SOURCE=.\EsmSettingDlg.cpp

"$(INTDIR)\EsmSettingDlg.obj"	"$(INTDIR)\EsmSettingDlg.sbr" : $(SOURCE) "$(INTDIR)" "$(INTDIR)\MWEdit.pch"


SOURCE=.\EsmSkillDlg.cpp

"$(INTDIR)\EsmSkillDlg.obj"	"$(INTDIR)\EsmSkillDlg.sbr" : $(SOURCE) "$(INTDIR)" "$(INTDIR)\MWEdit.pch"


SOURCE=.\EsmSoundDlg.cpp

"$(INTDIR)\EsmSoundDlg.obj"	"$(INTDIR)\EsmSoundDlg.sbr" : $(SOURCE) "$(INTDIR)" "$(INTDIR)\MWEdit.pch"


SOURCE=.\EsmSoundGenDlg.cpp

"$(INTDIR)\EsmSoundGenDlg.obj"	"$(INTDIR)\EsmSoundGenDlg.sbr" : $(SOURCE) "$(INTDIR)" "$(INTDIR)\MWEdit.pch"


SOURCE=.\EsmSpellDlg.cpp

"$(INTDIR)\EsmSpellDlg.obj"	"$(INTDIR)\EsmSpellDlg.sbr" : $(SOURCE) "$(INTDIR)" "$(INTDIR)\MWEdit.pch"


SOURCE=.\EsmStartScriptDlg.cpp

"$(INTDIR)\EsmStartScriptDlg.obj"	"$(INTDIR)\EsmStartScriptDlg.sbr" : $(SOURCE) "$(INTDIR)" "$(INTDIR)\MWEdit.pch"


SOURCE=.\EsmStaticDlg.cpp

"$(INTDIR)\EsmStaticDlg.obj"	"$(INTDIR)\EsmStaticDlg.sbr" : $(SOURCE) "$(INTDIR)" "$(INTDIR)\MWEdit.pch"


SOURCE=.\EsmWeaponDlg.cpp

"$(INTDIR)\EsmWeaponDlg.obj"	"$(INTDIR)\EsmWeaponDlg.sbr" : $(SOURCE) "$(INTDIR)" "$(INTDIR)\MWEdit.pch"


SOURCE=.\CreaturePage1.cpp

"$(INTDIR)\CreaturePage1.obj"	"$(INTDIR)\CreaturePage1.sbr" : $(SOURCE) "$(INTDIR)" "$(INTDIR)\MWEdit.pch"


SOURCE=.\CreaturePage2.cpp

"$(INTDIR)\CreaturePage2.obj"	"$(INTDIR)\CreaturePage2.sbr" : $(SOURCE) "$(INTDIR)" "$(INTDIR)\MWEdit.pch"


SOURCE=.\EsmCreatureDlg.cpp

"$(INTDIR)\EsmCreatureDlg.obj"	"$(INTDIR)\EsmCreatureDlg.sbr" : $(SOURCE) "$(INTDIR)" "$(INTDIR)\MWEdit.pch"


SOURCE=.\EsmCreaturePage1.cpp

"$(INTDIR)\EsmCreaturePage1.obj"	"$(INTDIR)\EsmCreaturePage1.sbr" : $(SOURCE) "$(INTDIR)" "$(INTDIR)\MWEdit.pch"


SOURCE=.\EsmCreaturePage2.cpp

"$(INTDIR)\EsmCreaturePage2.obj"	"$(INTDIR)\EsmCreaturePage2.sbr" : $(SOURCE) "$(INTDIR)" "$(INTDIR)\MWEdit.pch"


SOURCE=.\EsmCreaturePage3.cpp

"$(INTDIR)\EsmCreaturePage3.obj"	"$(INTDIR)\EsmCreaturePage3.sbr" : $(SOURCE) "$(INTDIR)" "$(INTDIR)\MWEdit.pch"


SOURCE=.\EsmCreaturePage4.cpp

"$(INTDIR)\EsmCreaturePage4.obj"	"$(INTDIR)\EsmCreaturePage4.sbr" : $(SOURCE) "$(INTDIR)" "$(INTDIR)\MWEdit.pch"


SOURCE=.\EsmCreaturePage5.cpp

"$(INTDIR)\EsmCreaturePage5.obj"	"$(INTDIR)\EsmCreaturePage5.sbr" : $(SOURCE) "$(INTDIR)" "$(INTDIR)\MWEdit.pch"


SOURCE=.\EsmCellDlg.cpp

"$(INTDIR)\EsmCellDlg.obj"	"$(INTDIR)\EsmCellDlg.sbr" : $(SOURCE) "$(INTDIR)" "$(INTDIR)\MWEdit.pch"


SOURCE=.\EsmCellRefDlg.cpp

"$(INTDIR)\EsmCellRefDlg.obj"	"$(INTDIR)\EsmCellRefDlg.sbr" : $(SOURCE) "$(INTDIR)" "$(INTDIR)\MWEdit.pch"


SOURCE=.\EsmExtCellPage.cpp

"$(INTDIR)\EsmExtCellPage.obj"	"$(INTDIR)\EsmExtCellPage.sbr" : $(SOURCE) "$(INTDIR)" "$(INTDIR)\MWEdit.pch"


SOURCE=.\EsmIntCellPage.cpp

"$(INTDIR)\EsmIntCellPage.obj"	"$(INTDIR)\EsmIntCellPage.sbr" : $(SOURCE) "$(INTDIR)" "$(INTDIR)\MWEdit.pch"


SOURCE=.\EsmRefCellPage.cpp

"$(INTDIR)\EsmRefCellPage.obj"	"$(INTDIR)\EsmRefCellPage.sbr" : $(SOURCE) "$(INTDIR)" "$(INTDIR)\MWEdit.pch"


SOURCE=.\ChildFrmScript.cpp

"$(INTDIR)\ChildFrmScript.obj"	"$(INTDIR)\ChildFrmScript.sbr" : $(SOURCE) "$(INTDIR)" "$(INTDIR)\MWEdit.pch"


SOURCE=.\EsmFuncHelpView.cpp

"$(INTDIR)\EsmFuncHelpView.obj"	"$(INTDIR)\EsmFuncHelpView.sbr" : $(SOURCE) "$(INTDIR)" "$(INTDIR)\MWEdit.pch"


SOURCE=.\EsmScriptDlg.cpp

"$(INTDIR)\EsmScriptDlg.obj"	"$(INTDIR)\EsmScriptDlg.sbr" : $(SOURCE) "$(INTDIR)" "$(INTDIR)\MWEdit.pch"


SOURCE=.\ScriptErrorDlg.cpp

"$(INTDIR)\ScriptErrorDlg.obj"	"$(INTDIR)\ScriptErrorDlg.sbr" : $(SOURCE) "$(INTDIR)" "$(INTDIR)\MWEdit.pch"


SOURCE=.\ScriptErrorView.cpp

"$(INTDIR)\ScriptErrorView.obj"	"$(INTDIR)\ScriptErrorView.sbr" : $(SOURCE) "$(INTDIR)" "$(INTDIR)\MWEdit.pch"


SOURCE=.\EsmNpcDlg.cpp

"$(INTDIR)\EsmNpcDlg.obj"	"$(INTDIR)\EsmNpcDlg.sbr" : $(SOURCE) "$(INTDIR)" "$(INTDIR)\MWEdit.pch"


SOURCE=.\EsmNpcPage1.cpp

"$(INTDIR)\EsmNpcPage1.obj"	"$(INTDIR)\EsmNpcPage1.sbr" : $(SOURCE) "$(INTDIR)" "$(INTDIR)\MWEdit.pch"


SOURCE=.\EsmNpcPage2.cpp

"$(INTDIR)\EsmNpcPage2.obj"	"$(INTDIR)\EsmNpcPage2.sbr" : $(SOURCE) "$(INTDIR)" "$(INTDIR)\MWEdit.pch"


SOURCE=.\EsmNpcPage3.cpp

"$(INTDIR)\EsmNpcPage3.obj"	"$(INTDIR)\EsmNpcPage3.sbr" : $(SOURCE) "$(INTDIR)" "$(INTDIR)\MWEdit.pch"


SOURCE=.\EsmNpcPage4.cpp

"$(INTDIR)\EsmNpcPage4.obj"	"$(INTDIR)\EsmNpcPage4.sbr" : $(SOURCE) "$(INTDIR)" "$(INTDIR)\MWEdit.pch"


SOURCE=.\EsmNpcPage5.cpp

"$(INTDIR)\EsmNpcPage5.obj"	"$(INTDIR)\EsmNpcPage5.sbr" : $(SOURCE) "$(INTDIR)" "$(INTDIR)\MWEdit.pch"


SOURCE=.\EsmDlgArray.cpp

"$(INTDIR)\EsmDlgArray.obj"	"$(INTDIR)\EsmDlgArray.sbr" : $(SOURCE) "$(INTDIR)" "$(INTDIR)\MWEdit.pch"


SOURCE=.\EsmRecDialog.cpp

"$(INTDIR)\EsmRecDialog.obj"	"$(INTDIR)\EsmRecDialog.sbr" : $(SOURCE) "$(INTDIR)" "$(INTDIR)\MWEdit.pch"


SOURCE=.\ChildFrm.cpp

"$(INTDIR)\ChildFrm.obj"	"$(INTDIR)\ChildFrm.sbr" : $(SOURCE) "$(INTDIR)" "$(INTDIR)\MWEdit.pch"


SOURCE=.\ChildFrmFix.cpp

"$(INTDIR)\ChildFrmFix.obj"	"$(INTDIR)\ChildFrmFix.sbr" : $(SOURCE) "$(INTDIR)" "$(INTDIR)\MWEdit.pch"


SOURCE=.\ChildFrmVar.cpp

"$(INTDIR)\ChildFrmVar.obj"	"$(INTDIR)\ChildFrmVar.sbr" : $(SOURCE) "$(INTDIR)" "$(INTDIR)\MWEdit.pch"


SOURCE=.\MainFrm.cpp

"$(INTDIR)\MainFrm.obj"	"$(INTDIR)\MainFrm.sbr" : $(SOURCE) "$(INTDIR)" "$(INTDIR)\MWEdit.pch"


SOURCE=.\ColorStatic1.cpp

"$(INTDIR)\ColorStatic1.obj"	"$(INTDIR)\ColorStatic1.sbr" : $(SOURCE) "$(INTDIR)" "$(INTDIR)\MWEdit.pch"


SOURCE=.\CustRichEdit.cpp

"$(INTDIR)\CustRichEdit.obj"	"$(INTDIR)\CustRichEdit.sbr" : $(SOURCE) "$(INTDIR)" "$(INTDIR)\MWEdit.pch"


SOURCE=.\EsmIconFrame.cpp

"$(INTDIR)\EsmIconFrame.obj"	"$(INTDIR)\EsmIconFrame.sbr" : $(SOURCE) "$(INTDIR)" "$(INTDIR)\MWEdit.pch"


SOURCE=.\EsmListCtrl.cpp

"$(INTDIR)\EsmListCtrl.obj"	"$(INTDIR)\EsmListCtrl.sbr" : $(SOURCE) "$(INTDIR)" "$(INTDIR)\MWEdit.pch"


SOURCE=.\EsmSubListCtrl.cpp

"$(INTDIR)\EsmSubListCtrl.obj"	"$(INTDIR)\EsmSubListCtrl.sbr" : $(SOURCE) "$(INTDIR)" "$(INTDIR)\MWEdit.pch"


SOURCE=.\InputDialog.cpp

"$(INTDIR)\InputDialog.obj"	"$(INTDIR)\InputDialog.sbr" : $(SOURCE) "$(INTDIR)" "$(INTDIR)\MWEdit.pch"


SOURCE=.\EsmScrTempPage1.cpp

"$(INTDIR)\EsmScrTempPage1.obj"	"$(INTDIR)\EsmScrTempPage1.sbr" : $(SOURCE) "$(INTDIR)" "$(INTDIR)\MWEdit.pch"


SOURCE=.\EsmScrTempPage2.cpp

"$(INTDIR)\EsmScrTempPage2.obj"	"$(INTDIR)\EsmScrTempPage2.sbr" : $(SOURCE) "$(INTDIR)" "$(INTDIR)\MWEdit.pch"


SOURCE=.\EsmScrTempPage3.cpp

"$(INTDIR)\EsmScrTempPage3.obj"	"$(INTDIR)\EsmScrTempPage3.sbr" : $(SOURCE) "$(INTDIR)" "$(INTDIR)\MWEdit.pch"


SOURCE=.\EsmScrTempView.cpp

"$(INTDIR)\EsmScrTempView.obj"	"$(INTDIR)\EsmScrTempView.sbr" : $(SOURCE) "$(INTDIR)" "$(INTDIR)\MWEdit.pch"


SOURCE=.\ScriptTemplate.cpp

!IF  "$(CFG)" == "MWEdit - Win32 Release"

CPP_SWITCHES=/nologo /MD /W3 /GX /O2 /I "d:\vcsource\esp\morrow\mwedit" /D "NDEBUG" /D "WIN32" /D "_WINDOWS" /D "_AFXDLL" /D "_MBCS" /D "NODEVILLIB" /FR"$(INTDIR)\\" /Fo"$(INTDIR)\\" /Fd"$(INTDIR)\\" /FD /c 

"$(INTDIR)\ScriptTemplate.obj"	"$(INTDIR)\ScriptTemplate.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) @<<
  $(CPP_SWITCHES) $(SOURCE)
<<


!ELSEIF  "$(CFG)" == "MWEdit - Win32 Debug"

CPP_SWITCHES=/nologo /MDd /W3 /Gm /GX /ZI /Od /I "d:\vcsource\esp\morrow\mwedit" /D "_DEBUG" /D "WIN32" /D "_WINDOWS" /D "_AFXDLL" /D "_MBCS" /D "NODEVILLIB" /FR"$(INTDIR)\\" /Fo"$(INTDIR)\\" /Fd"$(INTDIR)\\" /FD /GZ /c 

"$(INTDIR)\ScriptTemplate.obj"	"$(INTDIR)\ScriptTemplate.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) @<<
  $(CPP_SWITCHES) $(SOURCE)
<<


!ENDIF 

SOURCE=.\EsmCsvImportDlg.cpp

"$(INTDIR)\EsmCsvImportDlg.obj"	"$(INTDIR)\EsmCsvImportDlg.sbr" : $(SOURCE) "$(INTDIR)" "$(INTDIR)\MWEdit.pch"


SOURCE=.\EsmFindDlg.cpp

"$(INTDIR)\EsmFindDlg.obj"	"$(INTDIR)\EsmFindDlg.sbr" : $(SOURCE) "$(INTDIR)" "$(INTDIR)\MWEdit.pch"


SOURCE=.\EsmHeaderDlg.cpp

"$(INTDIR)\EsmHeaderDlg.obj"	"$(INTDIR)\EsmHeaderDlg.sbr" : $(SOURCE) "$(INTDIR)" "$(INTDIR)\MWEdit.pch"


SOURCE=.\EsmLoadDlg.cpp

"$(INTDIR)\EsmLoadDlg.obj"	"$(INTDIR)\EsmLoadDlg.sbr" : $(SOURCE) "$(INTDIR)" "$(INTDIR)\MWEdit.pch"


SOURCE=.\EsmOptionsDlg.cpp

"$(INTDIR)\EsmOptionsDlg.obj"	"$(INTDIR)\EsmOptionsDlg.sbr" : $(SOURCE) "$(INTDIR)" "$(INTDIR)\MWEdit.pch"


SOURCE=.\EsmUsesDlg.cpp

"$(INTDIR)\EsmUsesDlg.obj"	"$(INTDIR)\EsmUsesDlg.sbr" : $(SOURCE) "$(INTDIR)" "$(INTDIR)\MWEdit.pch"


SOURCE=.\MWEditView.cpp

"$(INTDIR)\MWEditView.obj"	"$(INTDIR)\MWEditView.sbr" : $(SOURCE) "$(INTDIR)" "$(INTDIR)\MWEdit.pch"


SOURCE=.\OpenPluginDlg.cpp

"$(INTDIR)\OpenPluginDlg.obj"	"$(INTDIR)\OpenPluginDlg.sbr" : $(SOURCE) "$(INTDIR)" "$(INTDIR)\MWEdit.pch"


SOURCE=.\hlp\MWEdit.hpj

!IF  "$(CFG)" == "MWEdit - Win32 Release"

OutDir=.\Release
TargetName=MWEdit
InputPath=.\hlp\MWEdit.hpj
InputName=MWEdit
USERDEP__MWEDI="hlp\AfxCore.rtf"	"hlp\$(TargetName).hm"	

"$(INTDIR)\MWEdit.hlp" : $(SOURCE) "$(INTDIR)" "$(OUTDIR)" $(USERDEP__MWEDI)
	<<tempfile.bat 
	@echo off 
	start /wait hcw /C /E /M "hlp\$(InputName).hpj" 
	if errorlevel 1 goto :Error 
	if not exist "hlp\$(InputName).hlp" goto :Error 
	copy "hlp\$(InputName).hlp" $(OutDir) 
	goto :done 
	:Error 
	echo hlp\$(InputName).hpj(1) : error: 
	type "hlp\$(InputName).log" 
	:done 
<< 
	

!ELSEIF  "$(CFG)" == "MWEdit - Win32 Debug"

OutDir=.\Debug
TargetName=MWEdit
InputPath=.\hlp\MWEdit.hpj
InputName=MWEdit
USERDEP__MWEDI="hlp\AfxCore.rtf"	"hlp\$(TargetName).hm"	

"$(INTDIR)\MWEdit.hlp" : $(SOURCE) "$(INTDIR)" "$(OUTDIR)" $(USERDEP__MWEDI)
	<<tempfile.bat 
	@echo off 
	start /wait hcw /C /E /M "hlp\$(InputName).hpj" 
	if errorlevel 1 goto :Error 
	if not exist "hlp\$(InputName).hlp" goto :Error 
	copy "hlp\$(InputName).hlp" $(OutDir) 
	goto :done 
	:Error 
	echo hlp\$(InputName).hpj(1) : error: 
	type "hlp\$(InputName).log" 
	:done 
<< 
	

!ENDIF 

SOURCE=.\MWEdit.rc

"$(INTDIR)\MWEdit.res" : $(SOURCE) "$(INTDIR)"
	$(RSC) $(RSC_PROJ) $(SOURCE)


SOURCE=.\StdAfx.cpp

!IF  "$(CFG)" == "MWEdit - Win32 Release"

CPP_SWITCHES=/nologo /MD /W3 /GX /O2 /I "d:\vcsource\esp\morrow\mwedit" /D "NDEBUG" /D "WIN32" /D "_WINDOWS" /D "_AFXDLL" /D "_MBCS" /D "NODEVILLIB" /FR"$(INTDIR)\\" /Fp"$(INTDIR)\MWEdit.pch" /Yc"stdafx.h" /Fo"$(INTDIR)\\" /Fd"$(INTDIR)\\" /FD /c 

"$(INTDIR)\StdAfx.obj"	"$(INTDIR)\StdAfx.sbr"	"$(INTDIR)\MWEdit.pch" : $(SOURCE) "$(INTDIR)"
	$(CPP) @<<
  $(CPP_SWITCHES) $(SOURCE)
<<


!ELSEIF  "$(CFG)" == "MWEdit - Win32 Debug"

CPP_SWITCHES=/nologo /MDd /W3 /Gm /GX /ZI /Od /I "d:\vcsource\esp\morrow\mwedit" /D "_DEBUG" /D "WIN32" /D "_WINDOWS" /D "_AFXDLL" /D "_MBCS" /D "NODEVILLIB" /FR"$(INTDIR)\\" /Fp"$(INTDIR)\MWEdit.pch" /Yc"stdafx.h" /Fo"$(INTDIR)\\" /Fd"$(INTDIR)\\" /FD /GZ /c 

"$(INTDIR)\StdAfx.obj"	"$(INTDIR)\StdAfx.sbr"	"$(INTDIR)\MWEdit.pch" : $(SOURCE) "$(INTDIR)"
	$(CPP) @<<
  $(CPP_SWITCHES) $(SOURCE)
<<


!ENDIF 

SOURCE=..\..\..\..\Source\File\csvfile.cpp

!IF  "$(CFG)" == "MWEdit - Win32 Release"

CPP_SWITCHES=/nologo /MD /W3 /GX /O2 /I "d:\vcsource\esp\morrow\mwedit" /D "NDEBUG" /D "WIN32" /D "_WINDOWS" /D "_AFXDLL" /D "_MBCS" /D "NODEVILLIB" /FR"$(INTDIR)\\" /Fo"$(INTDIR)\\" /Fd"$(INTDIR)\\" /FD /c 

"$(INTDIR)\csvfile.obj"	"$(INTDIR)\csvfile.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) @<<
  $(CPP_SWITCHES) $(SOURCE)
<<


!ELSEIF  "$(CFG)" == "MWEdit - Win32 Debug"

CPP_SWITCHES=/nologo /MDd /W3 /Gm /GX /ZI /Od /I "d:\vcsource\esp\morrow\mwedit" /D "_DEBUG" /D "WIN32" /D "_WINDOWS" /D "_AFXDLL" /D "_MBCS" /D "NODEVILLIB" /FR"$(INTDIR)\\" /Fo"$(INTDIR)\\" /Fd"$(INTDIR)\\" /FD /GZ /c 

"$(INTDIR)\csvfile.obj"	"$(INTDIR)\csvfile.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) @<<
  $(CPP_SWITCHES) $(SOURCE)
<<


!ENDIF 

SOURCE=..\..\..\..\Source\Common\dl_base.cpp

!IF  "$(CFG)" == "MWEdit - Win32 Release"

CPP_SWITCHES=/nologo /MD /W3 /GX /O2 /I "d:\vcsource\esp\morrow\mwedit" /D "NDEBUG" /D "WIN32" /D "_WINDOWS" /D "_AFXDLL" /D "_MBCS" /D "NODEVILLIB" /FR"$(INTDIR)\\" /Fo"$(INTDIR)\\" /Fd"$(INTDIR)\\" /FD /c 

"$(INTDIR)\dl_base.obj"	"$(INTDIR)\dl_base.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) @<<
  $(CPP_SWITCHES) $(SOURCE)
<<


!ELSEIF  "$(CFG)" == "MWEdit - Win32 Debug"

CPP_SWITCHES=/nologo /MDd /W3 /Gm /GX /ZI /Od /I "d:\vcsource\esp\morrow\mwedit" /D "_DEBUG" /D "WIN32" /D "_WINDOWS" /D "_AFXDLL" /D "_MBCS" /D "NODEVILLIB" /FR"$(INTDIR)\\" /Fo"$(INTDIR)\\" /Fd"$(INTDIR)\\" /FD /GZ /c 

"$(INTDIR)\dl_base.obj"	"$(INTDIR)\dl_base.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) @<<
  $(CPP_SWITCHES) $(SOURCE)
<<


!ENDIF 

SOURCE=..\..\..\..\Source\Common\dl_block.cpp

!IF  "$(CFG)" == "MWEdit - Win32 Release"

CPP_SWITCHES=/nologo /MD /W3 /GX /O2 /I "d:\vcsource\esp\morrow\mwedit" /D "NDEBUG" /D "WIN32" /D "_WINDOWS" /D "_AFXDLL" /D "_MBCS" /D "NODEVILLIB" /FR"$(INTDIR)\\" /Fo"$(INTDIR)\\" /Fd"$(INTDIR)\\" /FD /c 

"$(INTDIR)\dl_block.obj"	"$(INTDIR)\dl_block.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) @<<
  $(CPP_SWITCHES) $(SOURCE)
<<


!ELSEIF  "$(CFG)" == "MWEdit - Win32 Debug"

CPP_SWITCHES=/nologo /MDd /W3 /Gm /GX /ZI /Od /I "d:\vcsource\esp\morrow\mwedit" /D "_DEBUG" /D "WIN32" /D "_WINDOWS" /D "_AFXDLL" /D "_MBCS" /D "NODEVILLIB" /FR"$(INTDIR)\\" /Fo"$(INTDIR)\\" /Fd"$(INTDIR)\\" /FD /GZ /c 

"$(INTDIR)\dl_block.obj"	"$(INTDIR)\dl_block.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) @<<
  $(CPP_SWITCHES) $(SOURCE)
<<


!ENDIF 

SOURCE=..\..\..\..\Source\Common\dl_chr.cpp

!IF  "$(CFG)" == "MWEdit - Win32 Release"

CPP_SWITCHES=/nologo /MD /W3 /GX /O2 /I "d:\vcsource\esp\morrow\mwedit" /D "NDEBUG" /D "WIN32" /D "_WINDOWS" /D "_AFXDLL" /D "_MBCS" /D "NODEVILLIB" /FR"$(INTDIR)\\" /Fo"$(INTDIR)\\" /Fd"$(INTDIR)\\" /FD /c 

"$(INTDIR)\dl_chr.obj"	"$(INTDIR)\dl_chr.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) @<<
  $(CPP_SWITCHES) $(SOURCE)
<<


!ELSEIF  "$(CFG)" == "MWEdit - Win32 Debug"

CPP_SWITCHES=/nologo /MDd /W3 /Gm /GX /ZI /Od /I "d:\vcsource\esp\morrow\mwedit" /D "_DEBUG" /D "WIN32" /D "_WINDOWS" /D "_AFXDLL" /D "_MBCS" /D "NODEVILLIB" /FR"$(INTDIR)\\" /Fo"$(INTDIR)\\" /Fd"$(INTDIR)\\" /FD /GZ /c 

"$(INTDIR)\dl_chr.obj"	"$(INTDIR)\dl_chr.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) @<<
  $(CPP_SWITCHES) $(SOURCE)
<<


!ENDIF 

SOURCE=..\..\..\..\Source\Common\dl_err.cpp

!IF  "$(CFG)" == "MWEdit - Win32 Release"

CPP_SWITCHES=/nologo /MD /W3 /GX /O2 /I "d:\vcsource\esp\morrow\mwedit" /D "NDEBUG" /D "WIN32" /D "_WINDOWS" /D "_AFXDLL" /D "_MBCS" /D "NODEVILLIB" /FR"$(INTDIR)\\" /Fo"$(INTDIR)\\" /Fd"$(INTDIR)\\" /FD /c 

"$(INTDIR)\dl_err.obj"	"$(INTDIR)\dl_err.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) @<<
  $(CPP_SWITCHES) $(SOURCE)
<<


!ELSEIF  "$(CFG)" == "MWEdit - Win32 Debug"

CPP_SWITCHES=/nologo /MDd /W3 /Gm /GX /ZI /Od /I "d:\vcsource\esp\morrow\mwedit" /D "_DEBUG" /D "WIN32" /D "_WINDOWS" /D "_AFXDLL" /D "_MBCS" /D "NODEVILLIB" /FR"$(INTDIR)\\" /Fo"$(INTDIR)\\" /Fd"$(INTDIR)\\" /FD /GZ /c 

"$(INTDIR)\dl_err.obj"	"$(INTDIR)\dl_err.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) @<<
  $(CPP_SWITCHES) $(SOURCE)
<<


!ENDIF 

SOURCE=..\..\..\..\Source\Common\dl_file.cpp

!IF  "$(CFG)" == "MWEdit - Win32 Release"

CPP_SWITCHES=/nologo /MD /W3 /GX /O2 /I "d:\vcsource\esp\morrow\mwedit" /D "NDEBUG" /D "WIN32" /D "_WINDOWS" /D "_AFXDLL" /D "_MBCS" /D "NODEVILLIB" /FR"$(INTDIR)\\" /Fo"$(INTDIR)\\" /Fd"$(INTDIR)\\" /FD /c 

"$(INTDIR)\dl_file.obj"	"$(INTDIR)\dl_file.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) @<<
  $(CPP_SWITCHES) $(SOURCE)
<<


!ELSEIF  "$(CFG)" == "MWEdit - Win32 Debug"

CPP_SWITCHES=/nologo /MDd /W3 /Gm /GX /ZI /Od /I "d:\vcsource\esp\morrow\mwedit" /D "_DEBUG" /D "WIN32" /D "_WINDOWS" /D "_AFXDLL" /D "_MBCS" /D "NODEVILLIB" /FR"$(INTDIR)\\" /Fo"$(INTDIR)\\" /Fd"$(INTDIR)\\" /FD /GZ /c 

"$(INTDIR)\dl_file.obj"	"$(INTDIR)\dl_file.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) @<<
  $(CPP_SWITCHES) $(SOURCE)
<<


!ENDIF 

SOURCE=..\..\..\..\Source\Common\dl_log.cpp

!IF  "$(CFG)" == "MWEdit - Win32 Release"

CPP_SWITCHES=/nologo /MD /W3 /GX /O2 /I "d:\vcsource\esp\morrow\mwedit" /D "NDEBUG" /D "WIN32" /D "_WINDOWS" /D "_AFXDLL" /D "_MBCS" /D "NODEVILLIB" /FR"$(INTDIR)\\" /Fo"$(INTDIR)\\" /Fd"$(INTDIR)\\" /FD /c 

"$(INTDIR)\dl_log.obj"	"$(INTDIR)\dl_log.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) @<<
  $(CPP_SWITCHES) $(SOURCE)
<<


!ELSEIF  "$(CFG)" == "MWEdit - Win32 Debug"

CPP_SWITCHES=/nologo /MDd /W3 /Gm /GX /ZI /Od /I "d:\vcsource\esp\morrow\mwedit" /D "_DEBUG" /D "WIN32" /D "_WINDOWS" /D "_AFXDLL" /D "_MBCS" /D "NODEVILLIB" /FR"$(INTDIR)\\" /Fo"$(INTDIR)\\" /Fd"$(INTDIR)\\" /FD /GZ /c 

"$(INTDIR)\dl_log.obj"	"$(INTDIR)\dl_log.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) @<<
  $(CPP_SWITCHES) $(SOURCE)
<<


!ENDIF 

SOURCE=..\..\..\..\Source\Common\dl_math.cpp

!IF  "$(CFG)" == "MWEdit - Win32 Release"

CPP_SWITCHES=/nologo /MD /W3 /GX /O2 /I "d:\vcsource\esp\morrow\mwedit" /D "NDEBUG" /D "WIN32" /D "_WINDOWS" /D "_AFXDLL" /D "_MBCS" /D "NODEVILLIB" /FR"$(INTDIR)\\" /Fo"$(INTDIR)\\" /Fd"$(INTDIR)\\" /FD /c 

"$(INTDIR)\dl_math.obj"	"$(INTDIR)\dl_math.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) @<<
  $(CPP_SWITCHES) $(SOURCE)
<<


!ELSEIF  "$(CFG)" == "MWEdit - Win32 Debug"

CPP_SWITCHES=/nologo /MDd /W3 /Gm /GX /ZI /Od /I "d:\vcsource\esp\morrow\mwedit" /D "_DEBUG" /D "WIN32" /D "_WINDOWS" /D "_AFXDLL" /D "_MBCS" /D "NODEVILLIB" /FR"$(INTDIR)\\" /Fo"$(INTDIR)\\" /Fd"$(INTDIR)\\" /FD /GZ /c 

"$(INTDIR)\dl_math.obj"	"$(INTDIR)\dl_math.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) @<<
  $(CPP_SWITCHES) $(SOURCE)
<<


!ENDIF 

SOURCE=..\..\..\..\Source\Common\dl_mem.cpp

!IF  "$(CFG)" == "MWEdit - Win32 Release"

CPP_SWITCHES=/nologo /MD /W3 /GX /O2 /I "d:\vcsource\esp\morrow\mwedit" /D "NDEBUG" /D "WIN32" /D "_WINDOWS" /D "_AFXDLL" /D "_MBCS" /D "NODEVILLIB" /FR"$(INTDIR)\\" /Fo"$(INTDIR)\\" /Fd"$(INTDIR)\\" /FD /c 

"$(INTDIR)\dl_mem.obj"	"$(INTDIR)\dl_mem.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) @<<
  $(CPP_SWITCHES) $(SOURCE)
<<


!ELSEIF  "$(CFG)" == "MWEdit - Win32 Debug"

CPP_SWITCHES=/nologo /MDd /W3 /Gm /GX /ZI /Od /I "d:\vcsource\esp\morrow\mwedit" /D "_DEBUG" /D "WIN32" /D "_WINDOWS" /D "_AFXDLL" /D "_MBCS" /D "NODEVILLIB" /FR"$(INTDIR)\\" /Fo"$(INTDIR)\\" /Fd"$(INTDIR)\\" /FD /GZ /c 

"$(INTDIR)\dl_mem.obj"	"$(INTDIR)\dl_mem.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) @<<
  $(CPP_SWITCHES) $(SOURCE)
<<


!ENDIF 

SOURCE=..\..\..\..\Source\Common\dl_str.cpp

!IF  "$(CFG)" == "MWEdit - Win32 Release"

CPP_SWITCHES=/nologo /MD /W3 /GX /O2 /I "d:\vcsource\esp\morrow\mwedit" /D "NDEBUG" /D "WIN32" /D "_WINDOWS" /D "_AFXDLL" /D "_MBCS" /D "NODEVILLIB" /FR"$(INTDIR)\\" /Fo"$(INTDIR)\\" /Fd"$(INTDIR)\\" /FD /c 

"$(INTDIR)\dl_str.obj"	"$(INTDIR)\dl_str.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) @<<
  $(CPP_SWITCHES) $(SOURCE)
<<


!ELSEIF  "$(CFG)" == "MWEdit - Win32 Debug"

CPP_SWITCHES=/nologo /MDd /W3 /Gm /GX /ZI /Od /I "d:\vcsource\esp\morrow\mwedit" /D "_DEBUG" /D "WIN32" /D "_WINDOWS" /D "_AFXDLL" /D "_MBCS" /D "NODEVILLIB" /FR"$(INTDIR)\\" /Fo"$(INTDIR)\\" /Fd"$(INTDIR)\\" /FD /GZ /c 

"$(INTDIR)\dl_str.obj"	"$(INTDIR)\dl_str.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) @<<
  $(CPP_SWITCHES) $(SOURCE)
<<


!ENDIF 

SOURCE=..\..\..\..\Source\Common\dl_time.cpp

!IF  "$(CFG)" == "MWEdit - Win32 Release"

CPP_SWITCHES=/nologo /MD /W3 /GX /O2 /I "d:\vcsource\esp\morrow\mwedit" /D "NDEBUG" /D "WIN32" /D "_WINDOWS" /D "_AFXDLL" /D "_MBCS" /D "NODEVILLIB" /FR"$(INTDIR)\\" /Fo"$(INTDIR)\\" /Fd"$(INTDIR)\\" /FD /c 

"$(INTDIR)\dl_time.obj"	"$(INTDIR)\dl_time.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) @<<
  $(CPP_SWITCHES) $(SOURCE)
<<


!ELSEIF  "$(CFG)" == "MWEdit - Win32 Debug"

CPP_SWITCHES=/nologo /MDd /W3 /Gm /GX /ZI /Od /I "d:\vcsource\esp\morrow\mwedit" /D "_DEBUG" /D "WIN32" /D "_WINDOWS" /D "_AFXDLL" /D "_MBCS" /D "NODEVILLIB" /FR"$(INTDIR)\\" /Fo"$(INTDIR)\\" /Fd"$(INTDIR)\\" /FD /GZ /c 

"$(INTDIR)\dl_time.obj"	"$(INTDIR)\dl_time.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) @<<
  $(CPP_SWITCHES) $(SOURCE)
<<


!ENDIF 

SOURCE=..\..\..\..\Source\Windows\dl_ToolTip.cpp

"$(INTDIR)\dl_ToolTip.obj"	"$(INTDIR)\dl_ToolTip.sbr" : $(SOURCE) "$(INTDIR)" "$(INTDIR)\MWEdit.pch"
	$(CPP) $(CPP_PROJ) $(SOURCE)


SOURCE=..\..\..\..\Source\Common\File\genfile.cpp

!IF  "$(CFG)" == "MWEdit - Win32 Release"

CPP_SWITCHES=/nologo /MD /W3 /GX /O2 /I "d:\vcsource\esp\morrow\mwedit" /D "NDEBUG" /D "WIN32" /D "_WINDOWS" /D "_AFXDLL" /D "_MBCS" /D "NODEVILLIB" /FR"$(INTDIR)\\" /Fo"$(INTDIR)\\" /Fd"$(INTDIR)\\" /FD /c 

"$(INTDIR)\genfile.obj"	"$(INTDIR)\genfile.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) @<<
  $(CPP_SWITCHES) $(SOURCE)
<<


!ELSEIF  "$(CFG)" == "MWEdit - Win32 Debug"

CPP_SWITCHES=/nologo /MDd /W3 /Gm /GX /ZI /Od /I "d:\vcsource\esp\morrow\mwedit" /D "_DEBUG" /D "WIN32" /D "_WINDOWS" /D "_AFXDLL" /D "_MBCS" /D "NODEVILLIB" /FR"$(INTDIR)\\" /Fo"$(INTDIR)\\" /Fd"$(INTDIR)\\" /FD /GZ /c 

"$(INTDIR)\genfile.obj"	"$(INTDIR)\genfile.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) @<<
  $(CPP_SWITCHES) $(SOURCE)
<<


!ENDIF 

SOURCE=..\..\..\..\Source\Common\File\genfind.cpp

!IF  "$(CFG)" == "MWEdit - Win32 Release"

CPP_SWITCHES=/nologo /MD /W3 /GX /O2 /I "d:\vcsource\esp\morrow\mwedit" /D "NDEBUG" /D "WIN32" /D "_WINDOWS" /D "_AFXDLL" /D "_MBCS" /D "NODEVILLIB" /FR"$(INTDIR)\\" /Fo"$(INTDIR)\\" /Fd"$(INTDIR)\\" /FD /c 

"$(INTDIR)\genfind.obj"	"$(INTDIR)\genfind.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) @<<
  $(CPP_SWITCHES) $(SOURCE)
<<


!ELSEIF  "$(CFG)" == "MWEdit - Win32 Debug"

CPP_SWITCHES=/nologo /MDd /W3 /Gm /GX /ZI /Od /I "d:\vcsource\esp\morrow\mwedit" /D "_DEBUG" /D "WIN32" /D "_WINDOWS" /D "_AFXDLL" /D "_MBCS" /D "NODEVILLIB" /FR"$(INTDIR)\\" /Fo"$(INTDIR)\\" /Fd"$(INTDIR)\\" /FD /GZ /c 

"$(INTDIR)\genfind.obj"	"$(INTDIR)\genfind.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) @<<
  $(CPP_SWITCHES) $(SOURCE)
<<


!ENDIF 

SOURCE=..\..\..\..\Source\Common\Contain\GenStack.cpp

!IF  "$(CFG)" == "MWEdit - Win32 Release"

CPP_SWITCHES=/nologo /MD /W3 /GX /O2 /I "d:\vcsource\esp\morrow\mwedit" /D "NDEBUG" /D "WIN32" /D "_WINDOWS" /D "_AFXDLL" /D "_MBCS" /D "NODEVILLIB" /FR"$(INTDIR)\\" /Fo"$(INTDIR)\\" /Fd"$(INTDIR)\\" /FD /c 

"$(INTDIR)\GenStack.obj"	"$(INTDIR)\GenStack.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) @<<
  $(CPP_SWITCHES) $(SOURCE)
<<


!ELSEIF  "$(CFG)" == "MWEdit - Win32 Debug"

CPP_SWITCHES=/nologo /MDd /W3 /Gm /GX /ZI /Od /I "d:\vcsource\esp\morrow\mwedit" /D "_DEBUG" /D "WIN32" /D "_WINDOWS" /D "_AFXDLL" /D "_MBCS" /D "NODEVILLIB" /FR"$(INTDIR)\\" /Fo"$(INTDIR)\\" /Fd"$(INTDIR)\\" /FD /GZ /c 

"$(INTDIR)\GenStack.obj"	"$(INTDIR)\GenStack.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) @<<
  $(CPP_SWITCHES) $(SOURCE)
<<


!ENDIF 

SOURCE=..\..\..\..\Source\uesp\Morrow\mwcommon.cpp

!IF  "$(CFG)" == "MWEdit - Win32 Release"

CPP_SWITCHES=/nologo /MD /W3 /GX /O2 /I "d:\vcsource\esp\morrow\mwedit" /D "NDEBUG" /D "WIN32" /D "_WINDOWS" /D "_AFXDLL" /D "_MBCS" /D "NODEVILLIB" /FR"$(INTDIR)\\" /Fp"$(INTDIR)\MWEdit.pch" /Yu"stdafx.h" /Fo"$(INTDIR)\\" /Fd"$(INTDIR)\\" /FD /c 

"$(INTDIR)\mwcommon.obj"	"$(INTDIR)\mwcommon.sbr" : $(SOURCE) "$(INTDIR)" "$(INTDIR)\MWEdit.pch"
	$(CPP) @<<
  $(CPP_SWITCHES) $(SOURCE)
<<


!ELSEIF  "$(CFG)" == "MWEdit - Win32 Debug"

CPP_SWITCHES=/nologo /MDd /W3 /Gm /GX /ZI /Od /I "d:\vcsource\esp\morrow\mwedit" /D "_DEBUG" /D "WIN32" /D "_WINDOWS" /D "_AFXDLL" /D "_MBCS" /D "NODEVILLIB" /FR"$(INTDIR)\\" /Fp"$(INTDIR)\MWEdit.pch" /Yu"stdafx.h" /Fo"$(INTDIR)\\" /Fd"$(INTDIR)\\" /FD /GZ /c 

"$(INTDIR)\mwcommon.obj"	"$(INTDIR)\mwcommon.sbr" : $(SOURCE) "$(INTDIR)" "$(INTDIR)\MWEdit.pch"
	$(CPP) @<<
  $(CPP_SWITCHES) $(SOURCE)
<<


!ENDIF 

SOURCE=..\..\..\..\Source\Common\Utility\namelist.cpp

!IF  "$(CFG)" == "MWEdit - Win32 Release"

CPP_SWITCHES=/nologo /MD /W3 /GX /O2 /I "d:\vcsource\esp\morrow\mwedit" /D "NDEBUG" /D "WIN32" /D "_WINDOWS" /D "_AFXDLL" /D "_MBCS" /D "NODEVILLIB" /FR"$(INTDIR)\\" /Fo"$(INTDIR)\\" /Fd"$(INTDIR)\\" /FD /c 

"$(INTDIR)\namelist.obj"	"$(INTDIR)\namelist.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) @<<
  $(CPP_SWITCHES) $(SOURCE)
<<


!ELSEIF  "$(CFG)" == "MWEdit - Win32 Debug"

CPP_SWITCHES=/nologo /MDd /W3 /Gm /GX /ZI /Od /I "d:\vcsource\esp\morrow\mwedit" /D "_DEBUG" /D "WIN32" /D "_WINDOWS" /D "_AFXDLL" /D "_MBCS" /D "NODEVILLIB" /FR"$(INTDIR)\\" /Fo"$(INTDIR)\\" /Fd"$(INTDIR)\\" /FD /GZ /c 

"$(INTDIR)\namelist.obj"	"$(INTDIR)\namelist.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) @<<
  $(CPP_SWITCHES) $(SOURCE)
<<


!ENDIF 

SOURCE=..\..\..\..\Source\Common\Contain\ptrarray.cpp

!IF  "$(CFG)" == "MWEdit - Win32 Release"

CPP_SWITCHES=/nologo /MD /W3 /GX /O2 /I "d:\vcsource\esp\morrow\mwedit" /D "NDEBUG" /D "WIN32" /D "_WINDOWS" /D "_AFXDLL" /D "_MBCS" /D "NODEVILLIB" /FR"$(INTDIR)\\" /Fo"$(INTDIR)\\" /Fd"$(INTDIR)\\" /FD /c 

"$(INTDIR)\ptrarray.obj"	"$(INTDIR)\ptrarray.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) @<<
  $(CPP_SWITCHES) $(SOURCE)
<<


!ELSEIF  "$(CFG)" == "MWEdit - Win32 Debug"

CPP_SWITCHES=/nologo /MDd /W3 /Gm /GX /ZI /Od /I "d:\vcsource\esp\morrow\mwedit" /D "_DEBUG" /D "WIN32" /D "_WINDOWS" /D "_AFXDLL" /D "_MBCS" /D "NODEVILLIB" /FR"$(INTDIR)\\" /Fo"$(INTDIR)\\" /Fd"$(INTDIR)\\" /FD /GZ /c 

"$(INTDIR)\ptrarray.obj"	"$(INTDIR)\ptrarray.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) @<<
  $(CPP_SWITCHES) $(SOURCE)
<<


!ENDIF 

SOURCE=..\..\..\..\Source\Common\String\SString.cpp

!IF  "$(CFG)" == "MWEdit - Win32 Release"

CPP_SWITCHES=/nologo /MD /W3 /GX /O2 /I "d:\vcsource\esp\morrow\mwedit" /D "NDEBUG" /D "WIN32" /D "_WINDOWS" /D "_AFXDLL" /D "_MBCS" /D "NODEVILLIB" /FR"$(INTDIR)\\" /Fo"$(INTDIR)\\" /Fd"$(INTDIR)\\" /FD /c 

"$(INTDIR)\SString.obj"	"$(INTDIR)\SString.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) @<<
  $(CPP_SWITCHES) $(SOURCE)
<<


!ELSEIF  "$(CFG)" == "MWEdit - Win32 Debug"

CPP_SWITCHES=/nologo /MDd /W3 /Gm /GX /ZI /Od /I "d:\vcsource\esp\morrow\mwedit" /D "_DEBUG" /D "WIN32" /D "_WINDOWS" /D "_AFXDLL" /D "_MBCS" /D "NODEVILLIB" /FR"$(INTDIR)\\" /Fo"$(INTDIR)\\" /Fd"$(INTDIR)\\" /FD /GZ /c 

"$(INTDIR)\SString.obj"	"$(INTDIR)\SString.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) @<<
  $(CPP_SWITCHES) $(SOURCE)
<<


!ENDIF 

SOURCE=..\..\..\..\Source\Windows\TabCtrlSheet.cpp

"$(INTDIR)\TabCtrlSheet.obj"	"$(INTDIR)\TabCtrlSheet.sbr" : $(SOURCE) "$(INTDIR)" "$(INTDIR)\MWEdit.pch"
	$(CPP) $(CPP_PROJ) $(SOURCE)


SOURCE=..\..\..\..\Source\Common\Contain\temarray.cpp

!IF  "$(CFG)" == "MWEdit - Win32 Release"

CPP_SWITCHES=/nologo /MD /W3 /GX /O2 /I "d:\vcsource\esp\morrow\mwedit" /D "NDEBUG" /D "WIN32" /D "_WINDOWS" /D "_AFXDLL" /D "_MBCS" /D "NODEVILLIB" /FR"$(INTDIR)\\" /Fo"$(INTDIR)\\" /Fd"$(INTDIR)\\" /FD /c 

"$(INTDIR)\temarray.obj"	"$(INTDIR)\temarray.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) @<<
  $(CPP_SWITCHES) $(SOURCE)
<<


!ELSEIF  "$(CFG)" == "MWEdit - Win32 Debug"

CPP_SWITCHES=/nologo /MDd /W3 /Gm /GX /ZI /Od /I "d:\vcsource\esp\morrow\mwedit" /D "_DEBUG" /D "WIN32" /D "_WINDOWS" /D "_AFXDLL" /D "_MBCS" /D "NODEVILLIB" /FR"$(INTDIR)\\" /Fo"$(INTDIR)\\" /Fd"$(INTDIR)\\" /FD /GZ /c 

"$(INTDIR)\temarray.obj"	"$(INTDIR)\temarray.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) @<<
  $(CPP_SWITCHES) $(SOURCE)
<<


!ENDIF 

SOURCE=..\..\..\..\Source\Common\tstfile.cpp

!IF  "$(CFG)" == "MWEdit - Win32 Release"

CPP_SWITCHES=/nologo /MD /W3 /GX /O2 /I "d:\vcsource\esp\morrow\mwedit" /D "NDEBUG" /D "WIN32" /D "_WINDOWS" /D "_AFXDLL" /D "_MBCS" /D "NODEVILLIB" /FR"$(INTDIR)\\" /Fo"$(INTDIR)\\" /Fd"$(INTDIR)\\" /FD /c 

"$(INTDIR)\tstfile.obj"	"$(INTDIR)\tstfile.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) @<<
  $(CPP_SWITCHES) $(SOURCE)
<<


!ELSEIF  "$(CFG)" == "MWEdit - Win32 Debug"

CPP_SWITCHES=/nologo /MDd /W3 /Gm /GX /ZI /Od /I "d:\vcsource\esp\morrow\mwedit" /D "_DEBUG" /D "WIN32" /D "_WINDOWS" /D "_AFXDLL" /D "_MBCS" /D "NODEVILLIB" /FR"$(INTDIR)\\" /Fo"$(INTDIR)\\" /Fd"$(INTDIR)\\" /FD /GZ /c 

"$(INTDIR)\tstfile.obj"	"$(INTDIR)\tstfile.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) @<<
  $(CPP_SWITCHES) $(SOURCE)
<<


!ENDIF 

SOURCE=..\..\..\..\Source\Windows\WinUtil.cpp

"$(INTDIR)\WinUtil.obj"	"$(INTDIR)\WinUtil.sbr" : $(SOURCE) "$(INTDIR)" "$(INTDIR)\MWEdit.pch"
	$(CPP) $(CPP_PROJ) $(SOURCE)


SOURCE=..\..\..\..\Source\uesp\Morrow\esm\EsmActivator.cpp

!IF  "$(CFG)" == "MWEdit - Win32 Release"

CPP_SWITCHES=/nologo /MD /W3 /GX /O2 /I "d:\vcsource\esp\morrow\mwedit" /D "NDEBUG" /D "WIN32" /D "_WINDOWS" /D "_AFXDLL" /D "_MBCS" /D "NODEVILLIB" /FR"$(INTDIR)\\" /Fo"$(INTDIR)\\" /Fd"$(INTDIR)\\" /FD /c 

"$(INTDIR)\EsmActivator.obj"	"$(INTDIR)\EsmActivator.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) @<<
  $(CPP_SWITCHES) $(SOURCE)
<<


!ELSEIF  "$(CFG)" == "MWEdit - Win32 Debug"

CPP_SWITCHES=/nologo /MDd /W3 /Gm /GX /ZI /Od /I "d:\vcsource\esp\morrow\mwedit" /D "_DEBUG" /D "WIN32" /D "_WINDOWS" /D "_AFXDLL" /D "_MBCS" /D "NODEVILLIB" /FR"$(INTDIR)\\" /Fo"$(INTDIR)\\" /Fd"$(INTDIR)\\" /FD /GZ /c 

"$(INTDIR)\EsmActivator.obj"	"$(INTDIR)\EsmActivator.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) @<<
  $(CPP_SWITCHES) $(SOURCE)
<<


!ENDIF 

SOURCE=..\..\..\..\Source\uesp\Morrow\esm\EsmAlchemy.cpp

!IF  "$(CFG)" == "MWEdit - Win32 Release"

CPP_SWITCHES=/nologo /MD /W3 /GX /O2 /I "d:\vcsource\esp\morrow\mwedit" /D "NDEBUG" /D "WIN32" /D "_WINDOWS" /D "_AFXDLL" /D "_MBCS" /D "NODEVILLIB" /FR"$(INTDIR)\\" /Fo"$(INTDIR)\\" /Fd"$(INTDIR)\\" /FD /c 

"$(INTDIR)\EsmAlchemy.obj"	"$(INTDIR)\EsmAlchemy.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) @<<
  $(CPP_SWITCHES) $(SOURCE)
<<


!ELSEIF  "$(CFG)" == "MWEdit - Win32 Debug"

CPP_SWITCHES=/nologo /MDd /W3 /Gm /GX /ZI /Od /I "d:\vcsource\esp\morrow\mwedit" /D "_DEBUG" /D "WIN32" /D "_WINDOWS" /D "_AFXDLL" /D "_MBCS" /D "NODEVILLIB" /FR"$(INTDIR)\\" /Fo"$(INTDIR)\\" /Fd"$(INTDIR)\\" /FD /GZ /c 

"$(INTDIR)\EsmAlchemy.obj"	"$(INTDIR)\EsmAlchemy.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) @<<
  $(CPP_SWITCHES) $(SOURCE)
<<


!ENDIF 

SOURCE=..\..\..\..\Source\uesp\Morrow\esm\EsmApparatus.cpp

!IF  "$(CFG)" == "MWEdit - Win32 Release"

CPP_SWITCHES=/nologo /MD /W3 /GX /O2 /I "d:\vcsource\esp\morrow\mwedit" /D "NDEBUG" /D "WIN32" /D "_WINDOWS" /D "_AFXDLL" /D "_MBCS" /D "NODEVILLIB" /FR"$(INTDIR)\\" /Fo"$(INTDIR)\\" /Fd"$(INTDIR)\\" /FD /c 

"$(INTDIR)\EsmApparatus.obj"	"$(INTDIR)\EsmApparatus.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) @<<
  $(CPP_SWITCHES) $(SOURCE)
<<


!ELSEIF  "$(CFG)" == "MWEdit - Win32 Debug"

CPP_SWITCHES=/nologo /MDd /W3 /Gm /GX /ZI /Od /I "d:\vcsource\esp\morrow\mwedit" /D "_DEBUG" /D "WIN32" /D "_WINDOWS" /D "_AFXDLL" /D "_MBCS" /D "NODEVILLIB" /FR"$(INTDIR)\\" /Fo"$(INTDIR)\\" /Fd"$(INTDIR)\\" /FD /GZ /c 

"$(INTDIR)\EsmApparatus.obj"	"$(INTDIR)\EsmApparatus.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) @<<
  $(CPP_SWITCHES) $(SOURCE)
<<


!ENDIF 

SOURCE=..\..\..\..\Source\uesp\Morrow\esm\EsmArmor.cpp

!IF  "$(CFG)" == "MWEdit - Win32 Release"

CPP_SWITCHES=/nologo /MD /W3 /GX /O2 /I "d:\vcsource\esp\morrow\mwedit" /D "NDEBUG" /D "WIN32" /D "_WINDOWS" /D "_AFXDLL" /D "_MBCS" /D "NODEVILLIB" /FR"$(INTDIR)\\" /Fo"$(INTDIR)\\" /Fd"$(INTDIR)\\" /FD /c 

"$(INTDIR)\EsmArmor.obj"	"$(INTDIR)\EsmArmor.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) @<<
  $(CPP_SWITCHES) $(SOURCE)
<<


!ELSEIF  "$(CFG)" == "MWEdit - Win32 Debug"

CPP_SWITCHES=/nologo /MDd /W3 /Gm /GX /ZI /Od /I "d:\vcsource\esp\morrow\mwedit" /D "_DEBUG" /D "WIN32" /D "_WINDOWS" /D "_AFXDLL" /D "_MBCS" /D "NODEVILLIB" /FR"$(INTDIR)\\" /Fo"$(INTDIR)\\" /Fd"$(INTDIR)\\" /FD /GZ /c 

"$(INTDIR)\EsmArmor.obj"	"$(INTDIR)\EsmArmor.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) @<<
  $(CPP_SWITCHES) $(SOURCE)
<<


!ENDIF 

SOURCE=..\..\..\..\Source\uesp\Morrow\esm\EsmBirthSign.cpp

!IF  "$(CFG)" == "MWEdit - Win32 Release"

CPP_SWITCHES=/nologo /MD /W3 /GX /O2 /I "d:\vcsource\esp\morrow\mwedit" /D "NDEBUG" /D "WIN32" /D "_WINDOWS" /D "_AFXDLL" /D "_MBCS" /D "NODEVILLIB" /FR"$(INTDIR)\\" /Fo"$(INTDIR)\\" /Fd"$(INTDIR)\\" /FD /c 

"$(INTDIR)\EsmBirthSign.obj"	"$(INTDIR)\EsmBirthSign.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) @<<
  $(CPP_SWITCHES) $(SOURCE)
<<


!ELSEIF  "$(CFG)" == "MWEdit - Win32 Debug"

CPP_SWITCHES=/nologo /MDd /W3 /Gm /GX /ZI /Od /I "d:\vcsource\esp\morrow\mwedit" /D "_DEBUG" /D "WIN32" /D "_WINDOWS" /D "_AFXDLL" /D "_MBCS" /D "NODEVILLIB" /FR"$(INTDIR)\\" /Fo"$(INTDIR)\\" /Fd"$(INTDIR)\\" /FD /GZ /c 

"$(INTDIR)\EsmBirthSign.obj"	"$(INTDIR)\EsmBirthSign.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) @<<
  $(CPP_SWITCHES) $(SOURCE)
<<


!ENDIF 

SOURCE=..\..\..\..\Source\uesp\Morrow\esm\EsmBodyPart.cpp

!IF  "$(CFG)" == "MWEdit - Win32 Release"

CPP_SWITCHES=/nologo /MD /W3 /GX /O2 /I "d:\vcsource\esp\morrow\mwedit" /D "NDEBUG" /D "WIN32" /D "_WINDOWS" /D "_AFXDLL" /D "_MBCS" /D "NODEVILLIB" /FR"$(INTDIR)\\" /Fo"$(INTDIR)\\" /Fd"$(INTDIR)\\" /FD /c 

"$(INTDIR)\EsmBodyPart.obj"	"$(INTDIR)\EsmBodyPart.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) @<<
  $(CPP_SWITCHES) $(SOURCE)
<<


!ELSEIF  "$(CFG)" == "MWEdit - Win32 Debug"

CPP_SWITCHES=/nologo /MDd /W3 /Gm /GX /ZI /Od /I "d:\vcsource\esp\morrow\mwedit" /D "_DEBUG" /D "WIN32" /D "_WINDOWS" /D "_AFXDLL" /D "_MBCS" /D "NODEVILLIB" /FR"$(INTDIR)\\" /Fo"$(INTDIR)\\" /Fd"$(INTDIR)\\" /FD /GZ /c 

"$(INTDIR)\EsmBodyPart.obj"	"$(INTDIR)\EsmBodyPart.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) @<<
  $(CPP_SWITCHES) $(SOURCE)
<<


!ENDIF 

SOURCE=..\..\..\..\Source\uesp\Morrow\esm\EsmBook.cpp

!IF  "$(CFG)" == "MWEdit - Win32 Release"

CPP_SWITCHES=/nologo /MD /W3 /GX /O2 /I "d:\vcsource\esp\morrow\mwedit" /D "NDEBUG" /D "WIN32" /D "_WINDOWS" /D "_AFXDLL" /D "_MBCS" /D "NODEVILLIB" /FR"$(INTDIR)\\" /Fo"$(INTDIR)\\" /Fd"$(INTDIR)\\" /FD /c 

"$(INTDIR)\EsmBook.obj"	"$(INTDIR)\EsmBook.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) @<<
  $(CPP_SWITCHES) $(SOURCE)
<<


!ELSEIF  "$(CFG)" == "MWEdit - Win32 Debug"

CPP_SWITCHES=/nologo /MDd /W3 /Gm /GX /ZI /Od /I "d:\vcsource\esp\morrow\mwedit" /D "_DEBUG" /D "WIN32" /D "_WINDOWS" /D "_AFXDLL" /D "_MBCS" /D "NODEVILLIB" /FR"$(INTDIR)\\" /Fo"$(INTDIR)\\" /Fd"$(INTDIR)\\" /FD /GZ /c 

"$(INTDIR)\EsmBook.obj"	"$(INTDIR)\EsmBook.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) @<<
  $(CPP_SWITCHES) $(SOURCE)
<<


!ENDIF 

SOURCE=..\..\..\..\Source\uesp\Morrow\esm\EsmCell.cpp

!IF  "$(CFG)" == "MWEdit - Win32 Release"

CPP_SWITCHES=/nologo /MD /W3 /GX /O2 /I "d:\vcsource\esp\morrow\mwedit" /D "NDEBUG" /D "WIN32" /D "_WINDOWS" /D "_AFXDLL" /D "_MBCS" /D "NODEVILLIB" /FR"$(INTDIR)\\" /Fo"$(INTDIR)\\" /Fd"$(INTDIR)\\" /FD /c 

"$(INTDIR)\EsmCell.obj"	"$(INTDIR)\EsmCell.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) @<<
  $(CPP_SWITCHES) $(SOURCE)
<<


!ELSEIF  "$(CFG)" == "MWEdit - Win32 Debug"

CPP_SWITCHES=/nologo /MDd /W3 /Gm /GX /ZI /Od /I "d:\vcsource\esp\morrow\mwedit" /D "_DEBUG" /D "WIN32" /D "_WINDOWS" /D "_AFXDLL" /D "_MBCS" /D "NODEVILLIB" /FR"$(INTDIR)\\" /Fo"$(INTDIR)\\" /Fd"$(INTDIR)\\" /FD /GZ /c 

"$(INTDIR)\EsmCell.obj"	"$(INTDIR)\EsmCell.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) @<<
  $(CPP_SWITCHES) $(SOURCE)
<<


!ENDIF 

SOURCE=..\..\..\..\Source\uesp\Morrow\esm\EsmClass.cpp

!IF  "$(CFG)" == "MWEdit - Win32 Release"

CPP_SWITCHES=/nologo /MD /W3 /GX /O2 /I "d:\vcsource\esp\morrow\mwedit" /D "NDEBUG" /D "WIN32" /D "_WINDOWS" /D "_AFXDLL" /D "_MBCS" /D "NODEVILLIB" /FR"$(INTDIR)\\" /Fo"$(INTDIR)\\" /Fd"$(INTDIR)\\" /FD /c 

"$(INTDIR)\EsmClass.obj"	"$(INTDIR)\EsmClass.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) @<<
  $(CPP_SWITCHES) $(SOURCE)
<<


!ELSEIF  "$(CFG)" == "MWEdit - Win32 Debug"

CPP_SWITCHES=/nologo /MDd /W3 /Gm /GX /ZI /Od /I "d:\vcsource\esp\morrow\mwedit" /D "_DEBUG" /D "WIN32" /D "_WINDOWS" /D "_AFXDLL" /D "_MBCS" /D "NODEVILLIB" /FR"$(INTDIR)\\" /Fo"$(INTDIR)\\" /Fd"$(INTDIR)\\" /FD /GZ /c 

"$(INTDIR)\EsmClass.obj"	"$(INTDIR)\EsmClass.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) @<<
  $(CPP_SWITCHES) $(SOURCE)
<<


!ENDIF 

SOURCE=..\..\..\..\Source\uesp\Morrow\esm\EsmClothing.cpp

!IF  "$(CFG)" == "MWEdit - Win32 Release"

CPP_SWITCHES=/nologo /MD /W3 /GX /O2 /I "d:\vcsource\esp\morrow\mwedit" /D "NDEBUG" /D "WIN32" /D "_WINDOWS" /D "_AFXDLL" /D "_MBCS" /D "NODEVILLIB" /FR"$(INTDIR)\\" /Fo"$(INTDIR)\\" /Fd"$(INTDIR)\\" /FD /c 

"$(INTDIR)\EsmClothing.obj"	"$(INTDIR)\EsmClothing.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) @<<
  $(CPP_SWITCHES) $(SOURCE)
<<


!ELSEIF  "$(CFG)" == "MWEdit - Win32 Debug"

CPP_SWITCHES=/nologo /MDd /W3 /Gm /GX /ZI /Od /I "d:\vcsource\esp\morrow\mwedit" /D "_DEBUG" /D "WIN32" /D "_WINDOWS" /D "_AFXDLL" /D "_MBCS" /D "NODEVILLIB" /FR"$(INTDIR)\\" /Fo"$(INTDIR)\\" /Fd"$(INTDIR)\\" /FD /GZ /c 

"$(INTDIR)\EsmClothing.obj"	"$(INTDIR)\EsmClothing.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) @<<
  $(CPP_SWITCHES) $(SOURCE)
<<


!ENDIF 

SOURCE=..\..\..\..\Source\uesp\Morrow\esm\EsmContainer.cpp

!IF  "$(CFG)" == "MWEdit - Win32 Release"

CPP_SWITCHES=/nologo /MD /W3 /GX /O2 /I "d:\vcsource\esp\morrow\mwedit" /D "NDEBUG" /D "WIN32" /D "_WINDOWS" /D "_AFXDLL" /D "_MBCS" /D "NODEVILLIB" /FR"$(INTDIR)\\" /Fo"$(INTDIR)\\" /Fd"$(INTDIR)\\" /FD /c 

"$(INTDIR)\EsmContainer.obj"	"$(INTDIR)\EsmContainer.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) @<<
  $(CPP_SWITCHES) $(SOURCE)
<<


!ELSEIF  "$(CFG)" == "MWEdit - Win32 Debug"

CPP_SWITCHES=/nologo /MDd /W3 /Gm /GX /ZI /Od /I "d:\vcsource\esp\morrow\mwedit" /D "_DEBUG" /D "WIN32" /D "_WINDOWS" /D "_AFXDLL" /D "_MBCS" /D "NODEVILLIB" /FR"$(INTDIR)\\" /Fo"$(INTDIR)\\" /Fd"$(INTDIR)\\" /FD /GZ /c 

"$(INTDIR)\EsmContainer.obj"	"$(INTDIR)\EsmContainer.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) @<<
  $(CPP_SWITCHES) $(SOURCE)
<<


!ENDIF 

SOURCE=..\..\..\..\Source\uesp\Morrow\esm\EsmCreature.cpp

!IF  "$(CFG)" == "MWEdit - Win32 Release"

CPP_SWITCHES=/nologo /MD /W3 /GX /O2 /I "d:\vcsource\esp\morrow\mwedit" /D "NDEBUG" /D "WIN32" /D "_WINDOWS" /D "_AFXDLL" /D "_MBCS" /D "NODEVILLIB" /FR"$(INTDIR)\\" /Fo"$(INTDIR)\\" /Fd"$(INTDIR)\\" /FD /c 

"$(INTDIR)\EsmCreature.obj"	"$(INTDIR)\EsmCreature.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) @<<
  $(CPP_SWITCHES) $(SOURCE)
<<


!ELSEIF  "$(CFG)" == "MWEdit - Win32 Debug"

CPP_SWITCHES=/nologo /MDd /W3 /Gm /GX /ZI /Od /I "d:\vcsource\esp\morrow\mwedit" /D "_DEBUG" /D "WIN32" /D "_WINDOWS" /D "_AFXDLL" /D "_MBCS" /D "NODEVILLIB" /FR"$(INTDIR)\\" /Fo"$(INTDIR)\\" /Fd"$(INTDIR)\\" /FD /GZ /c 

"$(INTDIR)\EsmCreature.obj"	"$(INTDIR)\EsmCreature.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) @<<
  $(CPP_SWITCHES) $(SOURCE)
<<


!ENDIF 

SOURCE=..\..\..\..\Source\uesp\Morrow\esm\EsmDialogue.cpp

!IF  "$(CFG)" == "MWEdit - Win32 Release"

CPP_SWITCHES=/nologo /MD /W3 /GX /O2 /I "d:\vcsource\esp\morrow\mwedit" /D "NDEBUG" /D "WIN32" /D "_WINDOWS" /D "_AFXDLL" /D "_MBCS" /D "NODEVILLIB" /FR"$(INTDIR)\\" /Fo"$(INTDIR)\\" /Fd"$(INTDIR)\\" /FD /c 

"$(INTDIR)\EsmDialogue.obj"	"$(INTDIR)\EsmDialogue.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) @<<
  $(CPP_SWITCHES) $(SOURCE)
<<


!ELSEIF  "$(CFG)" == "MWEdit - Win32 Debug"

CPP_SWITCHES=/nologo /MDd /W3 /Gm /GX /ZI /Od /I "d:\vcsource\esp\morrow\mwedit" /D "_DEBUG" /D "WIN32" /D "_WINDOWS" /D "_AFXDLL" /D "_MBCS" /D "NODEVILLIB" /FR"$(INTDIR)\\" /Fo"$(INTDIR)\\" /Fd"$(INTDIR)\\" /FD /GZ /c 

"$(INTDIR)\EsmDialogue.obj"	"$(INTDIR)\EsmDialogue.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) @<<
  $(CPP_SWITCHES) $(SOURCE)
<<


!ENDIF 

SOURCE=..\..\..\..\Source\uesp\Morrow\esm\EsmDoor.cpp

!IF  "$(CFG)" == "MWEdit - Win32 Release"

CPP_SWITCHES=/nologo /MD /W3 /GX /O2 /I "d:\vcsource\esp\morrow\mwedit" /D "NDEBUG" /D "WIN32" /D "_WINDOWS" /D "_AFXDLL" /D "_MBCS" /D "NODEVILLIB" /FR"$(INTDIR)\\" /Fo"$(INTDIR)\\" /Fd"$(INTDIR)\\" /FD /c 

"$(INTDIR)\EsmDoor.obj"	"$(INTDIR)\EsmDoor.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) @<<
  $(CPP_SWITCHES) $(SOURCE)
<<


!ELSEIF  "$(CFG)" == "MWEdit - Win32 Debug"

CPP_SWITCHES=/nologo /MDd /W3 /Gm /GX /ZI /Od /I "d:\vcsource\esp\morrow\mwedit" /D "_DEBUG" /D "WIN32" /D "_WINDOWS" /D "_AFXDLL" /D "_MBCS" /D "NODEVILLIB" /FR"$(INTDIR)\\" /Fo"$(INTDIR)\\" /Fd"$(INTDIR)\\" /FD /GZ /c 

"$(INTDIR)\EsmDoor.obj"	"$(INTDIR)\EsmDoor.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) @<<
  $(CPP_SWITCHES) $(SOURCE)
<<


!ENDIF 

SOURCE=..\..\..\..\Source\uesp\Morrow\esm\EsmEnchant.cpp

!IF  "$(CFG)" == "MWEdit - Win32 Release"

CPP_SWITCHES=/nologo /MD /W3 /GX /O2 /I "d:\vcsource\esp\morrow\mwedit" /D "NDEBUG" /D "WIN32" /D "_WINDOWS" /D "_AFXDLL" /D "_MBCS" /D "NODEVILLIB" /FR"$(INTDIR)\\" /Fo"$(INTDIR)\\" /Fd"$(INTDIR)\\" /FD /c 

"$(INTDIR)\EsmEnchant.obj"	"$(INTDIR)\EsmEnchant.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) @<<
  $(CPP_SWITCHES) $(SOURCE)
<<


!ELSEIF  "$(CFG)" == "MWEdit - Win32 Debug"

CPP_SWITCHES=/nologo /MDd /W3 /Gm /GX /ZI /Od /I "d:\vcsource\esp\morrow\mwedit" /D "_DEBUG" /D "WIN32" /D "_WINDOWS" /D "_AFXDLL" /D "_MBCS" /D "NODEVILLIB" /FR"$(INTDIR)\\" /Fo"$(INTDIR)\\" /Fd"$(INTDIR)\\" /FD /GZ /c 

"$(INTDIR)\EsmEnchant.obj"	"$(INTDIR)\EsmEnchant.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) @<<
  $(CPP_SWITCHES) $(SOURCE)
<<


!ENDIF 

SOURCE=..\..\..\..\Source\uesp\Morrow\esm\EsmFaction.cpp

!IF  "$(CFG)" == "MWEdit - Win32 Release"

CPP_SWITCHES=/nologo /MD /W3 /GX /O2 /I "d:\vcsource\esp\morrow\mwedit" /D "NDEBUG" /D "WIN32" /D "_WINDOWS" /D "_AFXDLL" /D "_MBCS" /D "NODEVILLIB" /FR"$(INTDIR)\\" /Fo"$(INTDIR)\\" /Fd"$(INTDIR)\\" /FD /c 

"$(INTDIR)\EsmFaction.obj"	"$(INTDIR)\EsmFaction.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) @<<
  $(CPP_SWITCHES) $(SOURCE)
<<


!ELSEIF  "$(CFG)" == "MWEdit - Win32 Debug"

CPP_SWITCHES=/nologo /MDd /W3 /Gm /GX /ZI /Od /I "d:\vcsource\esp\morrow\mwedit" /D "_DEBUG" /D "WIN32" /D "_WINDOWS" /D "_AFXDLL" /D "_MBCS" /D "NODEVILLIB" /FR"$(INTDIR)\\" /Fo"$(INTDIR)\\" /Fd"$(INTDIR)\\" /FD /GZ /c 

"$(INTDIR)\EsmFaction.obj"	"$(INTDIR)\EsmFaction.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) @<<
  $(CPP_SWITCHES) $(SOURCE)
<<


!ENDIF 

SOURCE=..\..\..\..\Source\uesp\Morrow\esm\EsmGameSetting.cpp

!IF  "$(CFG)" == "MWEdit - Win32 Release"

CPP_SWITCHES=/nologo /MD /W3 /GX /O2 /I "d:\vcsource\esp\morrow\mwedit" /D "NDEBUG" /D "WIN32" /D "_WINDOWS" /D "_AFXDLL" /D "_MBCS" /D "NODEVILLIB" /FR"$(INTDIR)\\" /Fo"$(INTDIR)\\" /Fd"$(INTDIR)\\" /FD /c 

"$(INTDIR)\EsmGameSetting.obj"	"$(INTDIR)\EsmGameSetting.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) @<<
  $(CPP_SWITCHES) $(SOURCE)
<<


!ELSEIF  "$(CFG)" == "MWEdit - Win32 Debug"

CPP_SWITCHES=/nologo /MDd /W3 /Gm /GX /ZI /Od /I "d:\vcsource\esp\morrow\mwedit" /D "_DEBUG" /D "WIN32" /D "_WINDOWS" /D "_AFXDLL" /D "_MBCS" /D "NODEVILLIB" /FR"$(INTDIR)\\" /Fo"$(INTDIR)\\" /Fd"$(INTDIR)\\" /FD /GZ /c 

"$(INTDIR)\EsmGameSetting.obj"	"$(INTDIR)\EsmGameSetting.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) @<<
  $(CPP_SWITCHES) $(SOURCE)
<<


!ENDIF 

SOURCE=..\..\..\..\Source\uesp\Morrow\esm\EsmGlobal.cpp

!IF  "$(CFG)" == "MWEdit - Win32 Release"

CPP_SWITCHES=/nologo /MD /W3 /GX /O2 /I "d:\vcsource\esp\morrow\mwedit" /D "NDEBUG" /D "WIN32" /D "_WINDOWS" /D "_AFXDLL" /D "_MBCS" /D "NODEVILLIB" /FR"$(INTDIR)\\" /Fo"$(INTDIR)\\" /Fd"$(INTDIR)\\" /FD /c 

"$(INTDIR)\EsmGlobal.obj"	"$(INTDIR)\EsmGlobal.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) @<<
  $(CPP_SWITCHES) $(SOURCE)
<<


!ELSEIF  "$(CFG)" == "MWEdit - Win32 Debug"

CPP_SWITCHES=/nologo /MDd /W3 /Gm /GX /ZI /Od /I "d:\vcsource\esp\morrow\mwedit" /D "_DEBUG" /D "WIN32" /D "_WINDOWS" /D "_AFXDLL" /D "_MBCS" /D "NODEVILLIB" /FR"$(INTDIR)\\" /Fo"$(INTDIR)\\" /Fd"$(INTDIR)\\" /FD /GZ /c 

"$(INTDIR)\EsmGlobal.obj"	"$(INTDIR)\EsmGlobal.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) @<<
  $(CPP_SWITCHES) $(SOURCE)
<<


!ENDIF 

SOURCE=..\..\..\..\Source\uesp\Morrow\esm\EsmInfo.cpp

!IF  "$(CFG)" == "MWEdit - Win32 Release"

CPP_SWITCHES=/nologo /MD /W3 /GX /O2 /I "d:\vcsource\esp\morrow\mwedit" /D "NDEBUG" /D "WIN32" /D "_WINDOWS" /D "_AFXDLL" /D "_MBCS" /D "NODEVILLIB" /FR"$(INTDIR)\\" /Fo"$(INTDIR)\\" /Fd"$(INTDIR)\\" /FD /c 

"$(INTDIR)\EsmInfo.obj"	"$(INTDIR)\EsmInfo.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) @<<
  $(CPP_SWITCHES) $(SOURCE)
<<


!ELSEIF  "$(CFG)" == "MWEdit - Win32 Debug"

CPP_SWITCHES=/nologo /MDd /W3 /Gm /GX /ZI /Od /I "d:\vcsource\esp\morrow\mwedit" /D "_DEBUG" /D "WIN32" /D "_WINDOWS" /D "_AFXDLL" /D "_MBCS" /D "NODEVILLIB" /FR"$(INTDIR)\\" /Fo"$(INTDIR)\\" /Fd"$(INTDIR)\\" /FD /GZ /c 

"$(INTDIR)\EsmInfo.obj"	"$(INTDIR)\EsmInfo.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) @<<
  $(CPP_SWITCHES) $(SOURCE)
<<


!ENDIF 

SOURCE=..\..\..\..\Source\uesp\Morrow\esm\EsmIngrediant.cpp

!IF  "$(CFG)" == "MWEdit - Win32 Release"

CPP_SWITCHES=/nologo /MD /W3 /GX /O2 /I "d:\vcsource\esp\morrow\mwedit" /D "NDEBUG" /D "WIN32" /D "_WINDOWS" /D "_AFXDLL" /D "_MBCS" /D "NODEVILLIB" /FR"$(INTDIR)\\" /Fo"$(INTDIR)\\" /Fd"$(INTDIR)\\" /FD /c 

"$(INTDIR)\EsmIngrediant.obj"	"$(INTDIR)\EsmIngrediant.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) @<<
  $(CPP_SWITCHES) $(SOURCE)
<<


!ELSEIF  "$(CFG)" == "MWEdit - Win32 Debug"

CPP_SWITCHES=/nologo /MDd /W3 /Gm /GX /ZI /Od /I "d:\vcsource\esp\morrow\mwedit" /D "_DEBUG" /D "WIN32" /D "_WINDOWS" /D "_AFXDLL" /D "_MBCS" /D "NODEVILLIB" /FR"$(INTDIR)\\" /Fo"$(INTDIR)\\" /Fd"$(INTDIR)\\" /FD /GZ /c 

"$(INTDIR)\EsmIngrediant.obj"	"$(INTDIR)\EsmIngrediant.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) @<<
  $(CPP_SWITCHES) $(SOURCE)
<<


!ENDIF 

SOURCE=..\..\..\..\Source\uesp\Morrow\esm\EsmItem1.cpp

!IF  "$(CFG)" == "MWEdit - Win32 Release"

CPP_SWITCHES=/nologo /MD /W3 /GX /O2 /I "d:\vcsource\esp\morrow\mwedit" /D "NDEBUG" /D "WIN32" /D "_WINDOWS" /D "_AFXDLL" /D "_MBCS" /D "NODEVILLIB" /FR"$(INTDIR)\\" /Fo"$(INTDIR)\\" /Fd"$(INTDIR)\\" /FD /c 

"$(INTDIR)\EsmItem1.obj"	"$(INTDIR)\EsmItem1.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) @<<
  $(CPP_SWITCHES) $(SOURCE)
<<


!ELSEIF  "$(CFG)" == "MWEdit - Win32 Debug"

CPP_SWITCHES=/nologo /MDd /W3 /Gm /GX /ZI /Od /I "d:\vcsource\esp\morrow\mwedit" /D "_DEBUG" /D "WIN32" /D "_WINDOWS" /D "_AFXDLL" /D "_MBCS" /D "NODEVILLIB" /FR"$(INTDIR)\\" /Fo"$(INTDIR)\\" /Fd"$(INTDIR)\\" /FD /GZ /c 

"$(INTDIR)\EsmItem1.obj"	"$(INTDIR)\EsmItem1.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) @<<
  $(CPP_SWITCHES) $(SOURCE)
<<


!ENDIF 

SOURCE=..\..\..\..\Source\uesp\Morrow\esm\EsmItem2.cpp

!IF  "$(CFG)" == "MWEdit - Win32 Release"

CPP_SWITCHES=/nologo /MD /W3 /GX /O2 /I "d:\vcsource\esp\morrow\mwedit" /D "NDEBUG" /D "WIN32" /D "_WINDOWS" /D "_AFXDLL" /D "_MBCS" /D "NODEVILLIB" /FR"$(INTDIR)\\" /Fo"$(INTDIR)\\" /Fd"$(INTDIR)\\" /FD /c 

"$(INTDIR)\EsmItem2.obj"	"$(INTDIR)\EsmItem2.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) @<<
  $(CPP_SWITCHES) $(SOURCE)
<<


!ELSEIF  "$(CFG)" == "MWEdit - Win32 Debug"

CPP_SWITCHES=/nologo /MDd /W3 /Gm /GX /ZI /Od /I "d:\vcsource\esp\morrow\mwedit" /D "_DEBUG" /D "WIN32" /D "_WINDOWS" /D "_AFXDLL" /D "_MBCS" /D "NODEVILLIB" /FR"$(INTDIR)\\" /Fo"$(INTDIR)\\" /Fd"$(INTDIR)\\" /FD /GZ /c 

"$(INTDIR)\EsmItem2.obj"	"$(INTDIR)\EsmItem2.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) @<<
  $(CPP_SWITCHES) $(SOURCE)
<<


!ENDIF 

SOURCE=..\..\..\..\Source\uesp\Morrow\esm\EsmItem3.cpp

!IF  "$(CFG)" == "MWEdit - Win32 Release"

CPP_SWITCHES=/nologo /MD /W3 /GX /O2 /I "d:\vcsource\esp\morrow\mwedit" /D "NDEBUG" /D "WIN32" /D "_WINDOWS" /D "_AFXDLL" /D "_MBCS" /D "NODEVILLIB" /FR"$(INTDIR)\\" /Fo"$(INTDIR)\\" /Fd"$(INTDIR)\\" /FD /c 

"$(INTDIR)\EsmItem3.obj"	"$(INTDIR)\EsmItem3.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) @<<
  $(CPP_SWITCHES) $(SOURCE)
<<


!ELSEIF  "$(CFG)" == "MWEdit - Win32 Debug"

CPP_SWITCHES=/nologo /MDd /W3 /Gm /GX /ZI /Od /I "d:\vcsource\esp\morrow\mwedit" /D "_DEBUG" /D "WIN32" /D "_WINDOWS" /D "_AFXDLL" /D "_MBCS" /D "NODEVILLIB" /FR"$(INTDIR)\\" /Fo"$(INTDIR)\\" /Fd"$(INTDIR)\\" /FD /GZ /c 

"$(INTDIR)\EsmItem3.obj"	"$(INTDIR)\EsmItem3.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) @<<
  $(CPP_SWITCHES) $(SOURCE)
<<


!ENDIF 

SOURCE=..\..\..\..\Source\uesp\Morrow\esm\EsmLand.cpp

!IF  "$(CFG)" == "MWEdit - Win32 Release"

CPP_SWITCHES=/nologo /MD /W3 /GX /O2 /I "d:\vcsource\esp\morrow\mwedit" /D "NDEBUG" /D "WIN32" /D "_WINDOWS" /D "_AFXDLL" /D "_MBCS" /D "NODEVILLIB" /FR"$(INTDIR)\\" /Fo"$(INTDIR)\\" /Fd"$(INTDIR)\\" /FD /c 

"$(INTDIR)\EsmLand.obj"	"$(INTDIR)\EsmLand.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) @<<
  $(CPP_SWITCHES) $(SOURCE)
<<


!ELSEIF  "$(CFG)" == "MWEdit - Win32 Debug"

CPP_SWITCHES=/nologo /MDd /W3 /Gm /GX /ZI /Od /I "d:\vcsource\esp\morrow\mwedit" /D "_DEBUG" /D "WIN32" /D "_WINDOWS" /D "_AFXDLL" /D "_MBCS" /D "NODEVILLIB" /FR"$(INTDIR)\\" /Fo"$(INTDIR)\\" /Fd"$(INTDIR)\\" /FD /GZ /c 

"$(INTDIR)\EsmLand.obj"	"$(INTDIR)\EsmLand.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) @<<
  $(CPP_SWITCHES) $(SOURCE)
<<


!ENDIF 

SOURCE=..\..\..\..\Source\uesp\Morrow\esm\EsmLevelCrea.cpp

!IF  "$(CFG)" == "MWEdit - Win32 Release"

CPP_SWITCHES=/nologo /MD /W3 /GX /O2 /I "d:\vcsource\esp\morrow\mwedit" /D "NDEBUG" /D "WIN32" /D "_WINDOWS" /D "_AFXDLL" /D "_MBCS" /D "NODEVILLIB" /FR"$(INTDIR)\\" /Fo"$(INTDIR)\\" /Fd"$(INTDIR)\\" /FD /c 

"$(INTDIR)\EsmLevelCrea.obj"	"$(INTDIR)\EsmLevelCrea.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) @<<
  $(CPP_SWITCHES) $(SOURCE)
<<


!ELSEIF  "$(CFG)" == "MWEdit - Win32 Debug"

CPP_SWITCHES=/nologo /MDd /W3 /Gm /GX /ZI /Od /I "d:\vcsource\esp\morrow\mwedit" /D "_DEBUG" /D "WIN32" /D "_WINDOWS" /D "_AFXDLL" /D "_MBCS" /D "NODEVILLIB" /FR"$(INTDIR)\\" /Fo"$(INTDIR)\\" /Fd"$(INTDIR)\\" /FD /GZ /c 

"$(INTDIR)\EsmLevelCrea.obj"	"$(INTDIR)\EsmLevelCrea.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) @<<
  $(CPP_SWITCHES) $(SOURCE)
<<


!ENDIF 

SOURCE=..\..\..\..\Source\uesp\Morrow\esm\EsmLevelItem.cpp

!IF  "$(CFG)" == "MWEdit - Win32 Release"

CPP_SWITCHES=/nologo /MD /W3 /GX /O2 /I "d:\vcsource\esp\morrow\mwedit" /D "NDEBUG" /D "WIN32" /D "_WINDOWS" /D "_AFXDLL" /D "_MBCS" /D "NODEVILLIB" /FR"$(INTDIR)\\" /Fo"$(INTDIR)\\" /Fd"$(INTDIR)\\" /FD /c 

"$(INTDIR)\EsmLevelItem.obj"	"$(INTDIR)\EsmLevelItem.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) @<<
  $(CPP_SWITCHES) $(SOURCE)
<<


!ELSEIF  "$(CFG)" == "MWEdit - Win32 Debug"

CPP_SWITCHES=/nologo /MDd /W3 /Gm /GX /ZI /Od /I "d:\vcsource\esp\morrow\mwedit" /D "_DEBUG" /D "WIN32" /D "_WINDOWS" /D "_AFXDLL" /D "_MBCS" /D "NODEVILLIB" /FR"$(INTDIR)\\" /Fo"$(INTDIR)\\" /Fd"$(INTDIR)\\" /FD /GZ /c 

"$(INTDIR)\EsmLevelItem.obj"	"$(INTDIR)\EsmLevelItem.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) @<<
  $(CPP_SWITCHES) $(SOURCE)
<<


!ENDIF 

SOURCE=..\..\..\..\Source\uesp\Morrow\esm\EsmLight.cpp

!IF  "$(CFG)" == "MWEdit - Win32 Release"

CPP_SWITCHES=/nologo /MD /W3 /GX /O2 /I "d:\vcsource\esp\morrow\mwedit" /D "NDEBUG" /D "WIN32" /D "_WINDOWS" /D "_AFXDLL" /D "_MBCS" /D "NODEVILLIB" /FR"$(INTDIR)\\" /Fo"$(INTDIR)\\" /Fd"$(INTDIR)\\" /FD /c 

"$(INTDIR)\EsmLight.obj"	"$(INTDIR)\EsmLight.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) @<<
  $(CPP_SWITCHES) $(SOURCE)
<<


!ELSEIF  "$(CFG)" == "MWEdit - Win32 Debug"

CPP_SWITCHES=/nologo /MDd /W3 /Gm /GX /ZI /Od /I "d:\vcsource\esp\morrow\mwedit" /D "_DEBUG" /D "WIN32" /D "_WINDOWS" /D "_AFXDLL" /D "_MBCS" /D "NODEVILLIB" /FR"$(INTDIR)\\" /Fo"$(INTDIR)\\" /Fd"$(INTDIR)\\" /FD /GZ /c 

"$(INTDIR)\EsmLight.obj"	"$(INTDIR)\EsmLight.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) @<<
  $(CPP_SWITCHES) $(SOURCE)
<<


!ENDIF 

SOURCE=..\..\..\..\Source\uesp\Morrow\esm\EsmLockPick.cpp

!IF  "$(CFG)" == "MWEdit - Win32 Release"

CPP_SWITCHES=/nologo /MD /W3 /GX /O2 /I "d:\vcsource\esp\morrow\mwedit" /D "NDEBUG" /D "WIN32" /D "_WINDOWS" /D "_AFXDLL" /D "_MBCS" /D "NODEVILLIB" /FR"$(INTDIR)\\" /Fo"$(INTDIR)\\" /Fd"$(INTDIR)\\" /FD /c 

"$(INTDIR)\EsmLockPick.obj"	"$(INTDIR)\EsmLockPick.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) @<<
  $(CPP_SWITCHES) $(SOURCE)
<<


!ELSEIF  "$(CFG)" == "MWEdit - Win32 Debug"

CPP_SWITCHES=/nologo /MDd /W3 /Gm /GX /ZI /Od /I "d:\vcsource\esp\morrow\mwedit" /D "_DEBUG" /D "WIN32" /D "_WINDOWS" /D "_AFXDLL" /D "_MBCS" /D "NODEVILLIB" /FR"$(INTDIR)\\" /Fo"$(INTDIR)\\" /Fd"$(INTDIR)\\" /FD /GZ /c 

"$(INTDIR)\EsmLockPick.obj"	"$(INTDIR)\EsmLockPick.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) @<<
  $(CPP_SWITCHES) $(SOURCE)
<<


!ENDIF 

SOURCE=..\..\..\..\Source\uesp\Morrow\esm\EsmMagicEffect.cpp

!IF  "$(CFG)" == "MWEdit - Win32 Release"

CPP_SWITCHES=/nologo /MD /W3 /GX /O2 /I "d:\vcsource\esp\morrow\mwedit" /D "NDEBUG" /D "WIN32" /D "_WINDOWS" /D "_AFXDLL" /D "_MBCS" /D "NODEVILLIB" /FR"$(INTDIR)\\" /Fo"$(INTDIR)\\" /Fd"$(INTDIR)\\" /FD /c 

"$(INTDIR)\EsmMagicEffect.obj"	"$(INTDIR)\EsmMagicEffect.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) @<<
  $(CPP_SWITCHES) $(SOURCE)
<<


!ELSEIF  "$(CFG)" == "MWEdit - Win32 Debug"

CPP_SWITCHES=/nologo /MDd /W3 /Gm /GX /ZI /Od /I "d:\vcsource\esp\morrow\mwedit" /D "_DEBUG" /D "WIN32" /D "_WINDOWS" /D "_AFXDLL" /D "_MBCS" /D "NODEVILLIB" /FR"$(INTDIR)\\" /Fo"$(INTDIR)\\" /Fd"$(INTDIR)\\" /FD /GZ /c 

"$(INTDIR)\EsmMagicEffect.obj"	"$(INTDIR)\EsmMagicEffect.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) @<<
  $(CPP_SWITCHES) $(SOURCE)
<<


!ENDIF 

SOURCE=..\..\..\..\Source\uesp\Morrow\esm\EsmMisc.cpp

!IF  "$(CFG)" == "MWEdit - Win32 Release"

CPP_SWITCHES=/nologo /MD /W3 /GX /O2 /I "d:\vcsource\esp\morrow\mwedit" /D "NDEBUG" /D "WIN32" /D "_WINDOWS" /D "_AFXDLL" /D "_MBCS" /D "NODEVILLIB" /FR"$(INTDIR)\\" /Fo"$(INTDIR)\\" /Fd"$(INTDIR)\\" /FD /c 

"$(INTDIR)\EsmMisc.obj"	"$(INTDIR)\EsmMisc.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) @<<
  $(CPP_SWITCHES) $(SOURCE)
<<


!ELSEIF  "$(CFG)" == "MWEdit - Win32 Debug"

CPP_SWITCHES=/nologo /MDd /W3 /Gm /GX /ZI /Od /I "d:\vcsource\esp\morrow\mwedit" /D "_DEBUG" /D "WIN32" /D "_WINDOWS" /D "_AFXDLL" /D "_MBCS" /D "NODEVILLIB" /FR"$(INTDIR)\\" /Fo"$(INTDIR)\\" /Fd"$(INTDIR)\\" /FD /GZ /c 

"$(INTDIR)\EsmMisc.obj"	"$(INTDIR)\EsmMisc.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) @<<
  $(CPP_SWITCHES) $(SOURCE)
<<


!ENDIF 

SOURCE=..\..\..\..\Source\uesp\Morrow\esm\EsmNpc.cpp

!IF  "$(CFG)" == "MWEdit - Win32 Release"

CPP_SWITCHES=/nologo /MD /W3 /GX /O2 /I "d:\vcsource\esp\morrow\mwedit" /D "NDEBUG" /D "WIN32" /D "_WINDOWS" /D "_AFXDLL" /D "_MBCS" /D "NODEVILLIB" /FR"$(INTDIR)\\" /Fo"$(INTDIR)\\" /Fd"$(INTDIR)\\" /FD /c 

"$(INTDIR)\EsmNpc.obj"	"$(INTDIR)\EsmNpc.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) @<<
  $(CPP_SWITCHES) $(SOURCE)
<<


!ELSEIF  "$(CFG)" == "MWEdit - Win32 Debug"

CPP_SWITCHES=/nologo /MDd /W3 /Gm /GX /ZI /Od /I "d:\vcsource\esp\morrow\mwedit" /D "_DEBUG" /D "WIN32" /D "_WINDOWS" /D "_AFXDLL" /D "_MBCS" /D "NODEVILLIB" /FR"$(INTDIR)\\" /Fo"$(INTDIR)\\" /Fd"$(INTDIR)\\" /FD /GZ /c 

"$(INTDIR)\EsmNpc.obj"	"$(INTDIR)\EsmNpc.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) @<<
  $(CPP_SWITCHES) $(SOURCE)
<<


!ENDIF 

SOURCE=..\..\..\..\Source\uesp\Morrow\esm\EsmProbe.cpp

!IF  "$(CFG)" == "MWEdit - Win32 Release"

CPP_SWITCHES=/nologo /MD /W3 /GX /O2 /I "d:\vcsource\esp\morrow\mwedit" /D "NDEBUG" /D "WIN32" /D "_WINDOWS" /D "_AFXDLL" /D "_MBCS" /D "NODEVILLIB" /FR"$(INTDIR)\\" /Fo"$(INTDIR)\\" /Fd"$(INTDIR)\\" /FD /c 

"$(INTDIR)\EsmProbe.obj"	"$(INTDIR)\EsmProbe.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) @<<
  $(CPP_SWITCHES) $(SOURCE)
<<


!ELSEIF  "$(CFG)" == "MWEdit - Win32 Debug"

CPP_SWITCHES=/nologo /MDd /W3 /Gm /GX /ZI /Od /I "d:\vcsource\esp\morrow\mwedit" /D "_DEBUG" /D "WIN32" /D "_WINDOWS" /D "_AFXDLL" /D "_MBCS" /D "NODEVILLIB" /FR"$(INTDIR)\\" /Fo"$(INTDIR)\\" /Fd"$(INTDIR)\\" /FD /GZ /c 

"$(INTDIR)\EsmProbe.obj"	"$(INTDIR)\EsmProbe.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) @<<
  $(CPP_SWITCHES) $(SOURCE)
<<


!ENDIF 

SOURCE=..\..\..\..\Source\uesp\Morrow\esm\EsmRace.cpp

!IF  "$(CFG)" == "MWEdit - Win32 Release"

CPP_SWITCHES=/nologo /MD /W3 /GX /O2 /I "d:\vcsource\esp\morrow\mwedit" /D "NDEBUG" /D "WIN32" /D "_WINDOWS" /D "_AFXDLL" /D "_MBCS" /D "NODEVILLIB" /FR"$(INTDIR)\\" /Fo"$(INTDIR)\\" /Fd"$(INTDIR)\\" /FD /c 

"$(INTDIR)\EsmRace.obj"	"$(INTDIR)\EsmRace.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) @<<
  $(CPP_SWITCHES) $(SOURCE)
<<


!ELSEIF  "$(CFG)" == "MWEdit - Win32 Debug"

CPP_SWITCHES=/nologo /MDd /W3 /Gm /GX /ZI /Od /I "d:\vcsource\esp\morrow\mwedit" /D "_DEBUG" /D "WIN32" /D "_WINDOWS" /D "_AFXDLL" /D "_MBCS" /D "NODEVILLIB" /FR"$(INTDIR)\\" /Fo"$(INTDIR)\\" /Fd"$(INTDIR)\\" /FD /GZ /c 

"$(INTDIR)\EsmRace.obj"	"$(INTDIR)\EsmRace.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) @<<
  $(CPP_SWITCHES) $(SOURCE)
<<


!ENDIF 

SOURCE=..\..\..\..\Source\uesp\Morrow\esm\EsmRecord.cpp

!IF  "$(CFG)" == "MWEdit - Win32 Release"

CPP_SWITCHES=/nologo /MD /W3 /GX /O2 /I "d:\vcsource\esp\morrow\mwedit" /D "NDEBUG" /D "WIN32" /D "_WINDOWS" /D "_AFXDLL" /D "_MBCS" /D "NODEVILLIB" /FR"$(INTDIR)\\" /Fo"$(INTDIR)\\" /Fd"$(INTDIR)\\" /FD /c 

"$(INTDIR)\EsmRecord.obj"	"$(INTDIR)\EsmRecord.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) @<<
  $(CPP_SWITCHES) $(SOURCE)
<<


!ELSEIF  "$(CFG)" == "MWEdit - Win32 Debug"

CPP_SWITCHES=/nologo /MDd /W3 /Gm /GX /ZI /Od /I "d:\vcsource\esp\morrow\mwedit" /D "_DEBUG" /D "WIN32" /D "_WINDOWS" /D "_AFXDLL" /D "_MBCS" /D "NODEVILLIB" /FR"$(INTDIR)\\" /Fo"$(INTDIR)\\" /Fd"$(INTDIR)\\" /FD /GZ /c 

"$(INTDIR)\EsmRecord.obj"	"$(INTDIR)\EsmRecord.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) @<<
  $(CPP_SWITCHES) $(SOURCE)
<<


!ENDIF 

SOURCE=..\..\..\..\Source\uesp\Morrow\esm\EsmRegion.cpp

!IF  "$(CFG)" == "MWEdit - Win32 Release"

CPP_SWITCHES=/nologo /MD /W3 /GX /O2 /I "d:\vcsource\esp\morrow\mwedit" /D "NDEBUG" /D "WIN32" /D "_WINDOWS" /D "_AFXDLL" /D "_MBCS" /D "NODEVILLIB" /FR"$(INTDIR)\\" /Fo"$(INTDIR)\\" /Fd"$(INTDIR)\\" /FD /c 

"$(INTDIR)\EsmRegion.obj"	"$(INTDIR)\EsmRegion.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) @<<
  $(CPP_SWITCHES) $(SOURCE)
<<


!ELSEIF  "$(CFG)" == "MWEdit - Win32 Debug"

CPP_SWITCHES=/nologo /MDd /W3 /Gm /GX /ZI /Od /I "d:\vcsource\esp\morrow\mwedit" /D "_DEBUG" /D "WIN32" /D "_WINDOWS" /D "_AFXDLL" /D "_MBCS" /D "NODEVILLIB" /FR"$(INTDIR)\\" /Fo"$(INTDIR)\\" /Fd"$(INTDIR)\\" /FD /GZ /c 

"$(INTDIR)\EsmRegion.obj"	"$(INTDIR)\EsmRegion.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) @<<
  $(CPP_SWITCHES) $(SOURCE)
<<


!ENDIF 

SOURCE=..\..\..\..\Source\uesp\Morrow\esm\EsmRepair.cpp

!IF  "$(CFG)" == "MWEdit - Win32 Release"

CPP_SWITCHES=/nologo /MD /W3 /GX /O2 /I "d:\vcsource\esp\morrow\mwedit" /D "NDEBUG" /D "WIN32" /D "_WINDOWS" /D "_AFXDLL" /D "_MBCS" /D "NODEVILLIB" /FR"$(INTDIR)\\" /Fo"$(INTDIR)\\" /Fd"$(INTDIR)\\" /FD /c 

"$(INTDIR)\EsmRepair.obj"	"$(INTDIR)\EsmRepair.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) @<<
  $(CPP_SWITCHES) $(SOURCE)
<<


!ELSEIF  "$(CFG)" == "MWEdit - Win32 Debug"

CPP_SWITCHES=/nologo /MDd /W3 /Gm /GX /ZI /Od /I "d:\vcsource\esp\morrow\mwedit" /D "_DEBUG" /D "WIN32" /D "_WINDOWS" /D "_AFXDLL" /D "_MBCS" /D "NODEVILLIB" /FR"$(INTDIR)\\" /Fo"$(INTDIR)\\" /Fd"$(INTDIR)\\" /FD /GZ /c 

"$(INTDIR)\EsmRepair.obj"	"$(INTDIR)\EsmRepair.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) @<<
  $(CPP_SWITCHES) $(SOURCE)
<<


!ENDIF 

SOURCE=..\..\..\..\Source\uesp\Morrow\esm\EsmScript.cpp

!IF  "$(CFG)" == "MWEdit - Win32 Release"

CPP_SWITCHES=/nologo /MD /W3 /GX /O2 /I "d:\vcsource\esp\morrow\mwedit" /D "NDEBUG" /D "WIN32" /D "_WINDOWS" /D "_AFXDLL" /D "_MBCS" /D "NODEVILLIB" /FR"$(INTDIR)\\" /Fo"$(INTDIR)\\" /Fd"$(INTDIR)\\" /FD /c 

"$(INTDIR)\EsmScript.obj"	"$(INTDIR)\EsmScript.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) @<<
  $(CPP_SWITCHES) $(SOURCE)
<<


!ELSEIF  "$(CFG)" == "MWEdit - Win32 Debug"

CPP_SWITCHES=/nologo /MDd /W3 /Gm /GX /ZI /Od /I "d:\vcsource\esp\morrow\mwedit" /D "_DEBUG" /D "WIN32" /D "_WINDOWS" /D "_AFXDLL" /D "_MBCS" /D "NODEVILLIB" /FR"$(INTDIR)\\" /Fo"$(INTDIR)\\" /Fd"$(INTDIR)\\" /FD /GZ /c 

"$(INTDIR)\EsmScript.obj"	"$(INTDIR)\EsmScript.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) @<<
  $(CPP_SWITCHES) $(SOURCE)
<<


!ENDIF 

SOURCE=..\..\..\..\Source\uesp\Morrow\esm\EsmSkill.cpp

!IF  "$(CFG)" == "MWEdit - Win32 Release"

CPP_SWITCHES=/nologo /MD /W3 /GX /O2 /I "d:\vcsource\esp\morrow\mwedit" /D "NDEBUG" /D "WIN32" /D "_WINDOWS" /D "_AFXDLL" /D "_MBCS" /D "NODEVILLIB" /FR"$(INTDIR)\\" /Fo"$(INTDIR)\\" /Fd"$(INTDIR)\\" /FD /c 

"$(INTDIR)\EsmSkill.obj"	"$(INTDIR)\EsmSkill.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) @<<
  $(CPP_SWITCHES) $(SOURCE)
<<


!ELSEIF  "$(CFG)" == "MWEdit - Win32 Debug"

CPP_SWITCHES=/nologo /MDd /W3 /Gm /GX /ZI /Od /I "d:\vcsource\esp\morrow\mwedit" /D "_DEBUG" /D "WIN32" /D "_WINDOWS" /D "_AFXDLL" /D "_MBCS" /D "NODEVILLIB" /FR"$(INTDIR)\\" /Fo"$(INTDIR)\\" /Fd"$(INTDIR)\\" /FD /GZ /c 

"$(INTDIR)\EsmSkill.obj"	"$(INTDIR)\EsmSkill.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) @<<
  $(CPP_SWITCHES) $(SOURCE)
<<


!ENDIF 

SOURCE=..\..\..\..\Source\uesp\Morrow\esm\EsmSound.cpp

!IF  "$(CFG)" == "MWEdit - Win32 Release"

CPP_SWITCHES=/nologo /MD /W3 /GX /O2 /I "d:\vcsource\esp\morrow\mwedit" /D "NDEBUG" /D "WIN32" /D "_WINDOWS" /D "_AFXDLL" /D "_MBCS" /D "NODEVILLIB" /FR"$(INTDIR)\\" /Fo"$(INTDIR)\\" /Fd"$(INTDIR)\\" /FD /c 

"$(INTDIR)\EsmSound.obj"	"$(INTDIR)\EsmSound.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) @<<
  $(CPP_SWITCHES) $(SOURCE)
<<


!ELSEIF  "$(CFG)" == "MWEdit - Win32 Debug"

CPP_SWITCHES=/nologo /MDd /W3 /Gm /GX /ZI /Od /I "d:\vcsource\esp\morrow\mwedit" /D "_DEBUG" /D "WIN32" /D "_WINDOWS" /D "_AFXDLL" /D "_MBCS" /D "NODEVILLIB" /FR"$(INTDIR)\\" /Fo"$(INTDIR)\\" /Fd"$(INTDIR)\\" /FD /GZ /c 

"$(INTDIR)\EsmSound.obj"	"$(INTDIR)\EsmSound.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) @<<
  $(CPP_SWITCHES) $(SOURCE)
<<


!ENDIF 

SOURCE=..\..\..\..\Source\uesp\Morrow\esm\EsmSoundGen.cpp

!IF  "$(CFG)" == "MWEdit - Win32 Release"

CPP_SWITCHES=/nologo /MD /W3 /GX /O2 /I "d:\vcsource\esp\morrow\mwedit" /D "NDEBUG" /D "WIN32" /D "_WINDOWS" /D "_AFXDLL" /D "_MBCS" /D "NODEVILLIB" /FR"$(INTDIR)\\" /Fo"$(INTDIR)\\" /Fd"$(INTDIR)\\" /FD /c 

"$(INTDIR)\EsmSoundGen.obj"	"$(INTDIR)\EsmSoundGen.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) @<<
  $(CPP_SWITCHES) $(SOURCE)
<<


!ELSEIF  "$(CFG)" == "MWEdit - Win32 Debug"

CPP_SWITCHES=/nologo /MDd /W3 /Gm /GX /ZI /Od /I "d:\vcsource\esp\morrow\mwedit" /D "_DEBUG" /D "WIN32" /D "_WINDOWS" /D "_AFXDLL" /D "_MBCS" /D "NODEVILLIB" /FR"$(INTDIR)\\" /Fo"$(INTDIR)\\" /Fd"$(INTDIR)\\" /FD /GZ /c 

"$(INTDIR)\EsmSoundGen.obj"	"$(INTDIR)\EsmSoundGen.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) @<<
  $(CPP_SWITCHES) $(SOURCE)
<<


!ENDIF 

SOURCE=..\..\..\..\Source\uesp\Morrow\esm\EsmSpell.cpp

!IF  "$(CFG)" == "MWEdit - Win32 Release"

CPP_SWITCHES=/nologo /MD /W3 /GX /O2 /I "d:\vcsource\esp\morrow\mwedit" /D "NDEBUG" /D "WIN32" /D "_WINDOWS" /D "_AFXDLL" /D "_MBCS" /D "NODEVILLIB" /FR"$(INTDIR)\\" /Fo"$(INTDIR)\\" /Fd"$(INTDIR)\\" /FD /c 

"$(INTDIR)\EsmSpell.obj"	"$(INTDIR)\EsmSpell.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) @<<
  $(CPP_SWITCHES) $(SOURCE)
<<


!ELSEIF  "$(CFG)" == "MWEdit - Win32 Debug"

CPP_SWITCHES=/nologo /MDd /W3 /Gm /GX /ZI /Od /I "d:\vcsource\esp\morrow\mwedit" /D "_DEBUG" /D "WIN32" /D "_WINDOWS" /D "_AFXDLL" /D "_MBCS" /D "NODEVILLIB" /FR"$(INTDIR)\\" /Fo"$(INTDIR)\\" /Fd"$(INTDIR)\\" /FD /GZ /c 

"$(INTDIR)\EsmSpell.obj"	"$(INTDIR)\EsmSpell.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) @<<
  $(CPP_SWITCHES) $(SOURCE)
<<


!ENDIF 

SOURCE=..\..\..\..\Source\uesp\Morrow\esm\EsmStartScript.cpp

!IF  "$(CFG)" == "MWEdit - Win32 Release"

CPP_SWITCHES=/nologo /MD /W3 /GX /O2 /I "d:\vcsource\esp\morrow\mwedit" /D "NDEBUG" /D "WIN32" /D "_WINDOWS" /D "_AFXDLL" /D "_MBCS" /D "NODEVILLIB" /FR"$(INTDIR)\\" /Fo"$(INTDIR)\\" /Fd"$(INTDIR)\\" /FD /c 

"$(INTDIR)\EsmStartScript.obj"	"$(INTDIR)\EsmStartScript.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) @<<
  $(CPP_SWITCHES) $(SOURCE)
<<


!ELSEIF  "$(CFG)" == "MWEdit - Win32 Debug"

CPP_SWITCHES=/nologo /MDd /W3 /Gm /GX /ZI /Od /I "d:\vcsource\esp\morrow\mwedit" /D "_DEBUG" /D "WIN32" /D "_WINDOWS" /D "_AFXDLL" /D "_MBCS" /D "NODEVILLIB" /FR"$(INTDIR)\\" /Fo"$(INTDIR)\\" /Fd"$(INTDIR)\\" /FD /GZ /c 

"$(INTDIR)\EsmStartScript.obj"	"$(INTDIR)\EsmStartScript.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) @<<
  $(CPP_SWITCHES) $(SOURCE)
<<


!ENDIF 

SOURCE=..\..\..\..\Source\uesp\Morrow\esm\EsmStatic.cpp

!IF  "$(CFG)" == "MWEdit - Win32 Release"

CPP_SWITCHES=/nologo /MD /W3 /GX /O2 /I "d:\vcsource\esp\morrow\mwedit" /D "NDEBUG" /D "WIN32" /D "_WINDOWS" /D "_AFXDLL" /D "_MBCS" /D "NODEVILLIB" /FR"$(INTDIR)\\" /Fo"$(INTDIR)\\" /Fd"$(INTDIR)\\" /FD /c 

"$(INTDIR)\EsmStatic.obj"	"$(INTDIR)\EsmStatic.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) @<<
  $(CPP_SWITCHES) $(SOURCE)
<<


!ELSEIF  "$(CFG)" == "MWEdit - Win32 Debug"

CPP_SWITCHES=/nologo /MDd /W3 /Gm /GX /ZI /Od /I "d:\vcsource\esp\morrow\mwedit" /D "_DEBUG" /D "WIN32" /D "_WINDOWS" /D "_AFXDLL" /D "_MBCS" /D "NODEVILLIB" /FR"$(INTDIR)\\" /Fo"$(INTDIR)\\" /Fd"$(INTDIR)\\" /FD /GZ /c 

"$(INTDIR)\EsmStatic.obj"	"$(INTDIR)\EsmStatic.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) @<<
  $(CPP_SWITCHES) $(SOURCE)
<<


!ENDIF 

SOURCE=..\..\..\..\Source\uesp\Morrow\esm\EsmTES3.cpp

!IF  "$(CFG)" == "MWEdit - Win32 Release"

CPP_SWITCHES=/nologo /MD /W3 /GX /O2 /I "d:\vcsource\esp\morrow\mwedit" /D "NDEBUG" /D "WIN32" /D "_WINDOWS" /D "_AFXDLL" /D "_MBCS" /D "NODEVILLIB" /FR"$(INTDIR)\\" /Fo"$(INTDIR)\\" /Fd"$(INTDIR)\\" /FD /c 

"$(INTDIR)\EsmTES3.obj"	"$(INTDIR)\EsmTES3.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) @<<
  $(CPP_SWITCHES) $(SOURCE)
<<


!ELSEIF  "$(CFG)" == "MWEdit - Win32 Debug"

CPP_SWITCHES=/nologo /MDd /W3 /Gm /GX /ZI /Od /I "d:\vcsource\esp\morrow\mwedit" /D "_DEBUG" /D "WIN32" /D "_WINDOWS" /D "_AFXDLL" /D "_MBCS" /D "NODEVILLIB" /FR"$(INTDIR)\\" /Fo"$(INTDIR)\\" /Fd"$(INTDIR)\\" /FD /GZ /c 

"$(INTDIR)\EsmTES3.obj"	"$(INTDIR)\EsmTES3.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) @<<
  $(CPP_SWITCHES) $(SOURCE)
<<


!ENDIF 

SOURCE=..\..\..\..\Source\uesp\Morrow\esm\EsmWeapon.cpp

!IF  "$(CFG)" == "MWEdit - Win32 Release"

CPP_SWITCHES=/nologo /MD /W3 /GX /O2 /I "d:\vcsource\esp\morrow\mwedit" /D "NDEBUG" /D "WIN32" /D "_WINDOWS" /D "_AFXDLL" /D "_MBCS" /D "NODEVILLIB" /FR"$(INTDIR)\\" /Fo"$(INTDIR)\\" /Fd"$(INTDIR)\\" /FD /c 

"$(INTDIR)\EsmWeapon.obj"	"$(INTDIR)\EsmWeapon.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) @<<
  $(CPP_SWITCHES) $(SOURCE)
<<


!ELSEIF  "$(CFG)" == "MWEdit - Win32 Debug"

CPP_SWITCHES=/nologo /MDd /W3 /Gm /GX /ZI /Od /I "d:\vcsource\esp\morrow\mwedit" /D "_DEBUG" /D "WIN32" /D "_WINDOWS" /D "_AFXDLL" /D "_MBCS" /D "NODEVILLIB" /FR"$(INTDIR)\\" /Fo"$(INTDIR)\\" /Fd"$(INTDIR)\\" /FD /GZ /c 

"$(INTDIR)\EsmWeapon.obj"	"$(INTDIR)\EsmWeapon.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) @<<
  $(CPP_SWITCHES) $(SOURCE)
<<


!ENDIF 

SOURCE=..\..\..\..\Source\uesp\Morrow\esm\EsmSubBase.cpp

!IF  "$(CFG)" == "MWEdit - Win32 Release"

CPP_SWITCHES=/nologo /MD /W3 /GX /O2 /I "d:\vcsource\esp\morrow\mwedit" /D "NDEBUG" /D "WIN32" /D "_WINDOWS" /D "_AFXDLL" /D "_MBCS" /D "NODEVILLIB" /FR"$(INTDIR)\\" /Fo"$(INTDIR)\\" /Fd"$(INTDIR)\\" /FD /c 

"$(INTDIR)\EsmSubBase.obj"	"$(INTDIR)\EsmSubBase.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) @<<
  $(CPP_SWITCHES) $(SOURCE)
<<


!ELSEIF  "$(CFG)" == "MWEdit - Win32 Debug"

CPP_SWITCHES=/nologo /MDd /W3 /Gm /GX /ZI /Od /I "d:\vcsource\esp\morrow\mwedit" /D "_DEBUG" /D "WIN32" /D "_WINDOWS" /D "_AFXDLL" /D "_MBCS" /D "NODEVILLIB" /FR"$(INTDIR)\\" /Fo"$(INTDIR)\\" /Fd"$(INTDIR)\\" /FD /GZ /c 

"$(INTDIR)\EsmSubBase.obj"	"$(INTDIR)\EsmSubBase.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) @<<
  $(CPP_SWITCHES) $(SOURCE)
<<


!ENDIF 

SOURCE=..\..\..\..\Source\uesp\Morrow\esm\EsmSubCellRef.cpp

!IF  "$(CFG)" == "MWEdit - Win32 Release"

CPP_SWITCHES=/nologo /MD /W3 /GX /O2 /I "d:\vcsource\esp\morrow\mwedit" /D "NDEBUG" /D "WIN32" /D "_WINDOWS" /D "_AFXDLL" /D "_MBCS" /D "NODEVILLIB" /FR"$(INTDIR)\\" /Fo"$(INTDIR)\\" /Fd"$(INTDIR)\\" /FD /c 

"$(INTDIR)\EsmSubCellRef.obj"	"$(INTDIR)\EsmSubCellRef.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) @<<
  $(CPP_SWITCHES) $(SOURCE)
<<


!ELSEIF  "$(CFG)" == "MWEdit - Win32 Debug"

CPP_SWITCHES=/nologo /MDd /W3 /Gm /GX /ZI /Od /I "d:\vcsource\esp\morrow\mwedit" /D "_DEBUG" /D "WIN32" /D "_WINDOWS" /D "_AFXDLL" /D "_MBCS" /D "NODEVILLIB" /FR"$(INTDIR)\\" /Fo"$(INTDIR)\\" /Fd"$(INTDIR)\\" /FD /GZ /c 

"$(INTDIR)\EsmSubCellRef.obj"	"$(INTDIR)\EsmSubCellRef.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) @<<
  $(CPP_SWITCHES) $(SOURCE)
<<


!ENDIF 

SOURCE=..\..\..\..\Source\uesp\Morrow\esm\EsmSubName.cpp

!IF  "$(CFG)" == "MWEdit - Win32 Release"

CPP_SWITCHES=/nologo /MD /W3 /GX /O2 /I "d:\vcsource\esp\morrow\mwedit" /D "NDEBUG" /D "WIN32" /D "_WINDOWS" /D "_AFXDLL" /D "_MBCS" /D "NODEVILLIB" /FR"$(INTDIR)\\" /Fo"$(INTDIR)\\" /Fd"$(INTDIR)\\" /FD /c 

"$(INTDIR)\EsmSubName.obj"	"$(INTDIR)\EsmSubName.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) @<<
  $(CPP_SWITCHES) $(SOURCE)
<<


!ELSEIF  "$(CFG)" == "MWEdit - Win32 Debug"

CPP_SWITCHES=/nologo /MDd /W3 /Gm /GX /ZI /Od /I "d:\vcsource\esp\morrow\mwedit" /D "_DEBUG" /D "WIN32" /D "_WINDOWS" /D "_AFXDLL" /D "_MBCS" /D "NODEVILLIB" /FR"$(INTDIR)\\" /Fo"$(INTDIR)\\" /Fd"$(INTDIR)\\" /FD /GZ /c 

"$(INTDIR)\EsmSubName.obj"	"$(INTDIR)\EsmSubName.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) @<<
  $(CPP_SWITCHES) $(SOURCE)
<<


!ENDIF 

SOURCE=..\..\..\..\Source\uesp\Morrow\esm\EsmSubSCVR.cpp

!IF  "$(CFG)" == "MWEdit - Win32 Release"

CPP_SWITCHES=/nologo /MD /W3 /GX /O2 /I "d:\vcsource\esp\morrow\mwedit" /D "NDEBUG" /D "WIN32" /D "_WINDOWS" /D "_AFXDLL" /D "_MBCS" /D "NODEVILLIB" /FR"$(INTDIR)\\" /Fo"$(INTDIR)\\" /Fd"$(INTDIR)\\" /FD /c 

"$(INTDIR)\EsmSubSCVR.obj"	"$(INTDIR)\EsmSubSCVR.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) @<<
  $(CPP_SWITCHES) $(SOURCE)
<<


!ELSEIF  "$(CFG)" == "MWEdit - Win32 Debug"

CPP_SWITCHES=/nologo /MDd /W3 /Gm /GX /ZI /Od /I "d:\vcsource\esp\morrow\mwedit" /D "_DEBUG" /D "WIN32" /D "_WINDOWS" /D "_AFXDLL" /D "_MBCS" /D "NODEVILLIB" /FR"$(INTDIR)\\" /Fo"$(INTDIR)\\" /Fd"$(INTDIR)\\" /FD /GZ /c 

"$(INTDIR)\EsmSubSCVR.obj"	"$(INTDIR)\EsmSubSCVR.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) @<<
  $(CPP_SWITCHES) $(SOURCE)
<<


!ENDIF 

SOURCE=.\EsmScrFuncArray.cpp

!IF  "$(CFG)" == "MWEdit - Win32 Release"

CPP_SWITCHES=/nologo /MD /W3 /GX /O2 /I "d:\vcsource\esp\morrow\mwedit" /D "NDEBUG" /D "WIN32" /D "_WINDOWS" /D "_AFXDLL" /D "_MBCS" /D "NODEVILLIB" /FR"$(INTDIR)\\" /Fo"$(INTDIR)\\" /Fd"$(INTDIR)\\" /FD /c 

"$(INTDIR)\EsmScrFuncArray.obj"	"$(INTDIR)\EsmScrFuncArray.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) @<<
  $(CPP_SWITCHES) $(SOURCE)
<<


!ELSEIF  "$(CFG)" == "MWEdit - Win32 Debug"

CPP_SWITCHES=/nologo /MDd /W3 /Gm /GX /ZI /Od /I "d:\vcsource\esp\morrow\mwedit" /D "_DEBUG" /D "WIN32" /D "_WINDOWS" /D "_AFXDLL" /D "_MBCS" /D "NODEVILLIB" /FR"$(INTDIR)\\" /Fo"$(INTDIR)\\" /Fd"$(INTDIR)\\" /FD /GZ /c 

"$(INTDIR)\EsmScrFuncArray.obj"	"$(INTDIR)\EsmScrFuncArray.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) @<<
  $(CPP_SWITCHES) $(SOURCE)
<<


!ENDIF 

SOURCE=.\EsmScrFuncData.cpp

!IF  "$(CFG)" == "MWEdit - Win32 Release"

CPP_SWITCHES=/nologo /MD /W3 /GX /O2 /I "d:\vcsource\esp\morrow\mwedit" /D "NDEBUG" /D "WIN32" /D "_WINDOWS" /D "_AFXDLL" /D "_MBCS" /D "NODEVILLIB" /FR"$(INTDIR)\\" /Fo"$(INTDIR)\\" /Fd"$(INTDIR)\\" /FD /c 

"$(INTDIR)\EsmScrFuncData.obj"	"$(INTDIR)\EsmScrFuncData.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) @<<
  $(CPP_SWITCHES) $(SOURCE)
<<


!ELSEIF  "$(CFG)" == "MWEdit - Win32 Debug"

CPP_SWITCHES=/nologo /MDd /W3 /Gm /GX /ZI /Od /I "d:\vcsource\esp\morrow\mwedit" /D "_DEBUG" /D "WIN32" /D "_WINDOWS" /D "_AFXDLL" /D "_MBCS" /D "NODEVILLIB" /FR"$(INTDIR)\\" /Fo"$(INTDIR)\\" /Fd"$(INTDIR)\\" /FD /GZ /c 

"$(INTDIR)\EsmScrFuncData.obj"	"$(INTDIR)\EsmScrFuncData.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) @<<
  $(CPP_SWITCHES) $(SOURCE)
<<


!ENDIF 

SOURCE=.\EsmScriptCompile.cpp

!IF  "$(CFG)" == "MWEdit - Win32 Release"

CPP_SWITCHES=/nologo /MD /W3 /GX /O2 /I "d:\vcsource\esp\morrow\mwedit" /D "NDEBUG" /D "WIN32" /D "_WINDOWS" /D "_AFXDLL" /D "_MBCS" /D "NODEVILLIB" /FR"$(INTDIR)\\" /Fp"$(INTDIR)\MWEdit.pch" /Yu"stdafx.h" /Fo"$(INTDIR)\\" /Fd"$(INTDIR)\\" /FD /c 

"$(INTDIR)\EsmScriptCompile.obj"	"$(INTDIR)\EsmScriptCompile.sbr" : $(SOURCE) "$(INTDIR)" "$(INTDIR)\MWEdit.pch"
	$(CPP) @<<
  $(CPP_SWITCHES) $(SOURCE)
<<


!ELSEIF  "$(CFG)" == "MWEdit - Win32 Debug"

CPP_SWITCHES=/nologo /MDd /W3 /Gm /GX /ZI /Od /I "d:\vcsource\esp\morrow\mwedit" /D "_DEBUG" /D "WIN32" /D "_WINDOWS" /D "_AFXDLL" /D "_MBCS" /D "NODEVILLIB" /FR"$(INTDIR)\\" /Fp"$(INTDIR)\MWEdit.pch" /Yu"stdafx.h" /Fo"$(INTDIR)\\" /Fd"$(INTDIR)\\" /FD /GZ /c 

"$(INTDIR)\EsmScriptCompile.obj"	"$(INTDIR)\EsmScriptCompile.sbr" : $(SOURCE) "$(INTDIR)" "$(INTDIR)\MWEdit.pch"
	$(CPP) @<<
  $(CPP_SWITCHES) $(SOURCE)
<<


!ENDIF 

SOURCE=.\EsmScriptDefs.cpp

!IF  "$(CFG)" == "MWEdit - Win32 Release"

CPP_SWITCHES=/nologo /MD /W3 /GX /O2 /I "d:\vcsource\esp\morrow\mwedit" /D "NDEBUG" /D "WIN32" /D "_WINDOWS" /D "_AFXDLL" /D "_MBCS" /D "NODEVILLIB" /FR"$(INTDIR)\\" /Fo"$(INTDIR)\\" /Fd"$(INTDIR)\\" /FD /c 

"$(INTDIR)\EsmScriptDefs.obj"	"$(INTDIR)\EsmScriptDefs.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) @<<
  $(CPP_SWITCHES) $(SOURCE)
<<


!ELSEIF  "$(CFG)" == "MWEdit - Win32 Debug"

CPP_SWITCHES=/nologo /MDd /W3 /Gm /GX /ZI /Od /I "d:\vcsource\esp\morrow\mwedit" /D "_DEBUG" /D "WIN32" /D "_WINDOWS" /D "_AFXDLL" /D "_MBCS" /D "NODEVILLIB" /FR"$(INTDIR)\\" /Fo"$(INTDIR)\\" /Fd"$(INTDIR)\\" /FD /GZ /c 

"$(INTDIR)\EsmScriptDefs.obj"	"$(INTDIR)\EsmScriptDefs.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) @<<
  $(CPP_SWITCHES) $(SOURCE)
<<


!ENDIF 

SOURCE=.\EsmScriptError.cpp

!IF  "$(CFG)" == "MWEdit - Win32 Release"

CPP_SWITCHES=/nologo /MD /W3 /GX /O2 /I "d:\vcsource\esp\morrow\mwedit" /D "NDEBUG" /D "WIN32" /D "_WINDOWS" /D "_AFXDLL" /D "_MBCS" /D "NODEVILLIB" /FR"$(INTDIR)\\" /Fo"$(INTDIR)\\" /Fd"$(INTDIR)\\" /FD /c 

"$(INTDIR)\EsmScriptError.obj"	"$(INTDIR)\EsmScriptError.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) @<<
  $(CPP_SWITCHES) $(SOURCE)
<<


!ELSEIF  "$(CFG)" == "MWEdit - Win32 Debug"

CPP_SWITCHES=/nologo /MDd /W3 /Gm /GX /ZI /Od /I "d:\vcsource\esp\morrow\mwedit" /D "_DEBUG" /D "WIN32" /D "_WINDOWS" /D "_AFXDLL" /D "_MBCS" /D "NODEVILLIB" /FR"$(INTDIR)\\" /Fo"$(INTDIR)\\" /Fd"$(INTDIR)\\" /FD /GZ /c 

"$(INTDIR)\EsmScriptError.obj"	"$(INTDIR)\EsmScriptError.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) @<<
  $(CPP_SWITCHES) $(SOURCE)
<<


!ENDIF 

SOURCE=.\EsmScriptFuncs.cpp

!IF  "$(CFG)" == "MWEdit - Win32 Release"

CPP_SWITCHES=/nologo /MD /W3 /GX /O2 /I "d:\vcsource\esp\morrow\mwedit" /D "NDEBUG" /D "WIN32" /D "_WINDOWS" /D "_AFXDLL" /D "_MBCS" /D "NODEVILLIB" /FR"$(INTDIR)\\" /Fo"$(INTDIR)\\" /Fd"$(INTDIR)\\" /FD /c 

"$(INTDIR)\EsmScriptFuncs.obj"	"$(INTDIR)\EsmScriptFuncs.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) @<<
  $(CPP_SWITCHES) $(SOURCE)
<<


!ELSEIF  "$(CFG)" == "MWEdit - Win32 Debug"

CPP_SWITCHES=/nologo /MDd /W3 /Gm /GX /ZI /Od /I "d:\vcsource\esp\morrow\mwedit" /D "_DEBUG" /D "WIN32" /D "_WINDOWS" /D "_AFXDLL" /D "_MBCS" /D "NODEVILLIB" /FR"$(INTDIR)\\" /Fo"$(INTDIR)\\" /Fd"$(INTDIR)\\" /FD /GZ /c 

"$(INTDIR)\EsmScriptFuncs.obj"	"$(INTDIR)\EsmScriptFuncs.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) @<<
  $(CPP_SWITCHES) $(SOURCE)
<<


!ENDIF 

SOURCE=.\EsmScriptOptions.cpp

!IF  "$(CFG)" == "MWEdit - Win32 Release"

CPP_SWITCHES=/nologo /MD /W3 /GX /O2 /I "d:\vcsource\esp\morrow\mwedit" /D "NDEBUG" /D "WIN32" /D "_WINDOWS" /D "_AFXDLL" /D "_MBCS" /D "NODEVILLIB" /FR"$(INTDIR)\\" /Fo"$(INTDIR)\\" /Fd"$(INTDIR)\\" /FD /c 

"$(INTDIR)\EsmScriptOptions.obj"	"$(INTDIR)\EsmScriptOptions.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) @<<
  $(CPP_SWITCHES) $(SOURCE)
<<


!ELSEIF  "$(CFG)" == "MWEdit - Win32 Debug"

CPP_SWITCHES=/nologo /MDd /W3 /Gm /GX /ZI /Od /I "d:\vcsource\esp\morrow\mwedit" /D "_DEBUG" /D "WIN32" /D "_WINDOWS" /D "_AFXDLL" /D "_MBCS" /D "NODEVILLIB" /FR"$(INTDIR)\\" /Fo"$(INTDIR)\\" /Fd"$(INTDIR)\\" /FD /GZ /c 

"$(INTDIR)\EsmScriptOptions.obj"	"$(INTDIR)\EsmScriptOptions.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) @<<
  $(CPP_SWITCHES) $(SOURCE)
<<


!ENDIF 

SOURCE=..\..\..\..\Source\uesp\Morrow\esm\EsmBase.cpp

!IF  "$(CFG)" == "MWEdit - Win32 Release"

CPP_SWITCHES=/nologo /MD /W3 /GX /O2 /I "d:\vcsource\esp\morrow\mwedit" /D "NDEBUG" /D "WIN32" /D "_WINDOWS" /D "_AFXDLL" /D "_MBCS" /D "NODEVILLIB" /FR"$(INTDIR)\\" /Fo"$(INTDIR)\\" /Fd"$(INTDIR)\\" /FD /c 

"$(INTDIR)\EsmBase.obj"	"$(INTDIR)\EsmBase.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) @<<
  $(CPP_SWITCHES) $(SOURCE)
<<


!ELSEIF  "$(CFG)" == "MWEdit - Win32 Debug"

CPP_SWITCHES=/nologo /MDd /W3 /Gm /GX /ZI /Od /I "d:\vcsource\esp\morrow\mwedit" /D "_DEBUG" /D "WIN32" /D "_WINDOWS" /D "_AFXDLL" /D "_MBCS" /D "NODEVILLIB" /FR"$(INTDIR)\\" /Fo"$(INTDIR)\\" /Fd"$(INTDIR)\\" /FD /GZ /c 

"$(INTDIR)\EsmBase.obj"	"$(INTDIR)\EsmBase.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) @<<
  $(CPP_SWITCHES) $(SOURCE)
<<


!ENDIF 

SOURCE=.\EsmCsvDefs.cpp

!IF  "$(CFG)" == "MWEdit - Win32 Release"

CPP_SWITCHES=/nologo /MD /W3 /GX /O2 /I "d:\vcsource\esp\morrow\mwedit" /D "NDEBUG" /D "WIN32" /D "_WINDOWS" /D "_AFXDLL" /D "_MBCS" /D "NODEVILLIB" /FR"$(INTDIR)\\" /Fo"$(INTDIR)\\" /Fd"$(INTDIR)\\" /FD /c 

"$(INTDIR)\EsmCsvDefs.obj"	"$(INTDIR)\EsmCsvDefs.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) @<<
  $(CPP_SWITCHES) $(SOURCE)
<<


!ELSEIF  "$(CFG)" == "MWEdit - Win32 Debug"

CPP_SWITCHES=/nologo /MDd /W3 /Gm /GX /ZI /Od /I "d:\vcsource\esp\morrow\mwedit" /D "_DEBUG" /D "WIN32" /D "_WINDOWS" /D "_AFXDLL" /D "_MBCS" /D "NODEVILLIB" /FR"$(INTDIR)\\" /Fo"$(INTDIR)\\" /Fd"$(INTDIR)\\" /FD /GZ /c 

"$(INTDIR)\EsmCsvDefs.obj"	"$(INTDIR)\EsmCsvDefs.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) @<<
  $(CPP_SWITCHES) $(SOURCE)
<<


!ENDIF 

SOURCE=..\..\..\..\Source\uesp\Morrow\esm\EsmFile.cpp

!IF  "$(CFG)" == "MWEdit - Win32 Release"

CPP_SWITCHES=/nologo /MD /W3 /GX /O2 /I "d:\vcsource\esp\morrow\mwedit" /D "NDEBUG" /D "WIN32" /D "_WINDOWS" /D "_AFXDLL" /D "_MBCS" /D "NODEVILLIB" /FR"$(INTDIR)\\" /Fo"$(INTDIR)\\" /Fd"$(INTDIR)\\" /FD /c 

"$(INTDIR)\EsmFile.obj"	"$(INTDIR)\EsmFile.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) @<<
  $(CPP_SWITCHES) $(SOURCE)
<<


!ELSEIF  "$(CFG)" == "MWEdit - Win32 Debug"

CPP_SWITCHES=/nologo /MDd /W3 /Gm /GX /ZI /Od /I "d:\vcsource\esp\morrow\mwedit" /D "_DEBUG" /D "WIN32" /D "_WINDOWS" /D "_AFXDLL" /D "_MBCS" /D "NODEVILLIB" /FR"$(INTDIR)\\" /Fo"$(INTDIR)\\" /Fd"$(INTDIR)\\" /FD /GZ /c 

"$(INTDIR)\EsmFile.obj"	"$(INTDIR)\EsmFile.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) @<<
  $(CPP_SWITCHES) $(SOURCE)
<<


!ENDIF 

SOURCE=.\EsmGlobOptions.cpp

"$(INTDIR)\EsmGlobOptions.obj"	"$(INTDIR)\EsmGlobOptions.sbr" : $(SOURCE) "$(INTDIR)" "$(INTDIR)\MWEdit.pch"


SOURCE=.\EsmOptions.cpp

!IF  "$(CFG)" == "MWEdit - Win32 Release"

CPP_SWITCHES=/nologo /MD /W3 /GX /O2 /I "d:\vcsource\esp\morrow\mwedit" /D "NDEBUG" /D "WIN32" /D "_WINDOWS" /D "_AFXDLL" /D "_MBCS" /D "NODEVILLIB" /FR"$(INTDIR)\\" /Fp"$(INTDIR)\MWEdit.pch" /Yu"stdafx.h" /Fo"$(INTDIR)\\" /Fd"$(INTDIR)\\" /FD /c 

"$(INTDIR)\EsmOptions.obj"	"$(INTDIR)\EsmOptions.sbr" : $(SOURCE) "$(INTDIR)" "$(INTDIR)\MWEdit.pch"
	$(CPP) @<<
  $(CPP_SWITCHES) $(SOURCE)
<<


!ELSEIF  "$(CFG)" == "MWEdit - Win32 Debug"

CPP_SWITCHES=/nologo /MDd /W3 /Gm /GX /ZI /Od /I "d:\vcsource\esp\morrow\mwedit" /D "_DEBUG" /D "WIN32" /D "_WINDOWS" /D "_AFXDLL" /D "_MBCS" /D "NODEVILLIB" /FR"$(INTDIR)\\" /Fp"$(INTDIR)\MWEdit.pch" /Yu"stdafx.h" /Fo"$(INTDIR)\\" /Fd"$(INTDIR)\\" /FD /GZ /c 

"$(INTDIR)\EsmOptions.obj"	"$(INTDIR)\EsmOptions.sbr" : $(SOURCE) "$(INTDIR)" "$(INTDIR)\MWEdit.pch"
	$(CPP) @<<
  $(CPP_SWITCHES) $(SOURCE)
<<


!ENDIF 

SOURCE=.\EsmUtils.cpp

"$(INTDIR)\EsmUtils.obj"	"$(INTDIR)\EsmUtils.sbr" : $(SOURCE) "$(INTDIR)" "$(INTDIR)\MWEdit.pch"


SOURCE="..\..\..\DevIL\src-IL\src\il_alloc.c"

!IF  "$(CFG)" == "MWEdit - Win32 Release"

CPP_SWITCHES=/nologo /MD /W3 /GX /O2 /I "d:\vcsource\esp\morrow\mwedit" /I "d:\vcsource\devil\src-il\include" /I "d:\vcsource\devil\src-ilu\include" /I "d:\vcsource\devil\src-ilut\include" /D "NDEBUG" /D "WIN32" /D "_WINDOWS" /D "_AFXDLL" /D "_MBCS" /D "NODEVILLIB" /FR"$(INTDIR)\\" /Fo"$(INTDIR)\\" /Fd"$(INTDIR)\\" /FD /c 

"$(INTDIR)\il_alloc.obj"	"$(INTDIR)\il_alloc.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) @<<
  $(CPP_SWITCHES) $(SOURCE)
<<


!ELSEIF  "$(CFG)" == "MWEdit - Win32 Debug"

CPP_SWITCHES=/nologo /MDd /W3 /Gm /GX /ZI /Od /I "d:\vcsource\esp\morrow\mwedit" /I "d:\vcsource\devil\src-il\include" /I "d:\vcsource\devil\src-ilu\include" /I "d:\vcsource\devil\src-ilut\include" /D "_DEBUG" /D "WIN32" /D "_WINDOWS" /D "_AFXDLL" /D "_MBCS" /D "NODEVILLIB" /FR"$(INTDIR)\\" /Fo"$(INTDIR)\\" /Fd"$(INTDIR)\\" /FD /GZ /c 

"$(INTDIR)\il_alloc.obj"	"$(INTDIR)\il_alloc.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) @<<
  $(CPP_SWITCHES) $(SOURCE)
<<


!ENDIF 

SOURCE="..\..\..\DevIL\src-IL\src\il_bits.c"

!IF  "$(CFG)" == "MWEdit - Win32 Release"

CPP_SWITCHES=/nologo /MD /W3 /GX /O2 /I "d:\vcsource\esp\morrow\mwedit" /I "d:\vcsource\devil\src-il\include" /I "d:\vcsource\devil\src-ilu\include" /I "d:\vcsource\devil\src-ilut\include" /D "NDEBUG" /D "WIN32" /D "_WINDOWS" /D "_AFXDLL" /D "_MBCS" /D "NODEVILLIB" /FR"$(INTDIR)\\" /Fo"$(INTDIR)\\" /Fd"$(INTDIR)\\" /FD /c 

"$(INTDIR)\il_bits.obj"	"$(INTDIR)\il_bits.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) @<<
  $(CPP_SWITCHES) $(SOURCE)
<<


!ELSEIF  "$(CFG)" == "MWEdit - Win32 Debug"

CPP_SWITCHES=/nologo /MDd /W3 /Gm /GX /ZI /Od /I "d:\vcsource\esp\morrow\mwedit" /I "d:\vcsource\devil\src-il\include" /I "d:\vcsource\devil\src-ilu\include" /I "d:\vcsource\devil\src-ilut\include" /D "_DEBUG" /D "WIN32" /D "_WINDOWS" /D "_AFXDLL" /D "_MBCS" /D "NODEVILLIB" /FR"$(INTDIR)\\" /Fo"$(INTDIR)\\" /Fd"$(INTDIR)\\" /FD /GZ /c 

"$(INTDIR)\il_bits.obj"	"$(INTDIR)\il_bits.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) @<<
  $(CPP_SWITCHES) $(SOURCE)
<<


!ENDIF 

SOURCE="..\..\..\DevIL\src-IL\src\il_bmp.c"

!IF  "$(CFG)" == "MWEdit - Win32 Release"

CPP_SWITCHES=/nologo /MD /W3 /GX /O2 /I "d:\vcsource\esp\morrow\mwedit" /I "d:\vcsource\devil\src-il\include" /I "d:\vcsource\devil\src-ilu\include" /I "d:\vcsource\devil\src-ilut\include" /D "NDEBUG" /D "WIN32" /D "_WINDOWS" /D "_AFXDLL" /D "_MBCS" /D "NODEVILLIB" /FR"$(INTDIR)\\" /Fo"$(INTDIR)\\" /Fd"$(INTDIR)\\" /FD /c 

"$(INTDIR)\il_bmp.obj"	"$(INTDIR)\il_bmp.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) @<<
  $(CPP_SWITCHES) $(SOURCE)
<<


!ELSEIF  "$(CFG)" == "MWEdit - Win32 Debug"

CPP_SWITCHES=/nologo /MDd /W3 /Gm /GX /ZI /Od /I "d:\vcsource\esp\morrow\mwedit" /I "d:\vcsource\devil\src-il\include" /I "d:\vcsource\devil\src-ilu\include" /I "d:\vcsource\devil\src-ilut\include" /D "_DEBUG" /D "WIN32" /D "_WINDOWS" /D "_AFXDLL" /D "_MBCS" /D "NODEVILLIB" /FR"$(INTDIR)\\" /Fo"$(INTDIR)\\" /Fd"$(INTDIR)\\" /FD /GZ /c 

"$(INTDIR)\il_bmp.obj"	"$(INTDIR)\il_bmp.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) @<<
  $(CPP_SWITCHES) $(SOURCE)
<<


!ENDIF 

SOURCE="..\..\..\DevIL\src-IL\src\il_convbuff.c"

!IF  "$(CFG)" == "MWEdit - Win32 Release"

CPP_SWITCHES=/nologo /MD /W3 /GX /O2 /I "d:\vcsource\esp\morrow\mwedit" /I "d:\vcsource\devil\src-il\include" /I "d:\vcsource\devil\src-ilu\include" /I "d:\vcsource\devil\src-ilut\include" /D "NDEBUG" /D "WIN32" /D "_WINDOWS" /D "_AFXDLL" /D "_MBCS" /D "NODEVILLIB" /FR"$(INTDIR)\\" /Fo"$(INTDIR)\\" /Fd"$(INTDIR)\\" /FD /c 

"$(INTDIR)\il_convbuff.obj"	"$(INTDIR)\il_convbuff.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) @<<
  $(CPP_SWITCHES) $(SOURCE)
<<


!ELSEIF  "$(CFG)" == "MWEdit - Win32 Debug"

CPP_SWITCHES=/nologo /MDd /W3 /Gm /GX /ZI /Od /I "d:\vcsource\esp\morrow\mwedit" /I "d:\vcsource\devil\src-il\include" /I "d:\vcsource\devil\src-ilu\include" /I "d:\vcsource\devil\src-ilut\include" /D "_DEBUG" /D "WIN32" /D "_WINDOWS" /D "_AFXDLL" /D "_MBCS" /D "NODEVILLIB" /FR"$(INTDIR)\\" /Fo"$(INTDIR)\\" /Fd"$(INTDIR)\\" /FD /GZ /c 

"$(INTDIR)\il_convbuff.obj"	"$(INTDIR)\il_convbuff.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) @<<
  $(CPP_SWITCHES) $(SOURCE)
<<


!ENDIF 

SOURCE="..\..\..\DevIL\src-IL\src\il_convert.c"

!IF  "$(CFG)" == "MWEdit - Win32 Release"

CPP_SWITCHES=/nologo /MD /W3 /GX /O2 /I "d:\vcsource\esp\morrow\mwedit" /I "d:\vcsource\devil\src-il\include" /I "d:\vcsource\devil\src-ilu\include" /I "d:\vcsource\devil\src-ilut\include" /D "NDEBUG" /D "WIN32" /D "_WINDOWS" /D "_AFXDLL" /D "_MBCS" /D "NODEVILLIB" /FR"$(INTDIR)\\" /Fo"$(INTDIR)\\" /Fd"$(INTDIR)\\" /FD /c 

"$(INTDIR)\il_convert.obj"	"$(INTDIR)\il_convert.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) @<<
  $(CPP_SWITCHES) $(SOURCE)
<<


!ELSEIF  "$(CFG)" == "MWEdit - Win32 Debug"

CPP_SWITCHES=/nologo /MDd /W3 /Gm /GX /ZI /Od /I "d:\vcsource\esp\morrow\mwedit" /I "d:\vcsource\devil\src-il\include" /I "d:\vcsource\devil\src-ilu\include" /I "d:\vcsource\devil\src-ilut\include" /D "_DEBUG" /D "WIN32" /D "_WINDOWS" /D "_AFXDLL" /D "_MBCS" /D "NODEVILLIB" /FR"$(INTDIR)\\" /Fo"$(INTDIR)\\" /Fd"$(INTDIR)\\" /FD /GZ /c 

"$(INTDIR)\il_convert.obj"	"$(INTDIR)\il_convert.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) @<<
  $(CPP_SWITCHES) $(SOURCE)
<<


!ENDIF 

SOURCE="..\..\..\DevIL\src-IL\src\il_cut.c"

!IF  "$(CFG)" == "MWEdit - Win32 Release"

CPP_SWITCHES=/nologo /MD /W3 /GX /O2 /I "d:\vcsource\esp\morrow\mwedit" /I "d:\vcsource\devil\src-il\include" /I "d:\vcsource\devil\src-ilu\include" /I "d:\vcsource\devil\src-ilut\include" /D "NDEBUG" /D "WIN32" /D "_WINDOWS" /D "_AFXDLL" /D "_MBCS" /D "NODEVILLIB" /FR"$(INTDIR)\\" /Fo"$(INTDIR)\\" /Fd"$(INTDIR)\\" /FD /c 

"$(INTDIR)\il_cut.obj"	"$(INTDIR)\il_cut.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) @<<
  $(CPP_SWITCHES) $(SOURCE)
<<


!ELSEIF  "$(CFG)" == "MWEdit - Win32 Debug"

CPP_SWITCHES=/nologo /MDd /W3 /Gm /GX /ZI /Od /I "d:\vcsource\esp\morrow\mwedit" /I "d:\vcsource\devil\src-il\include" /I "d:\vcsource\devil\src-ilu\include" /I "d:\vcsource\devil\src-ilut\include" /D "_DEBUG" /D "WIN32" /D "_WINDOWS" /D "_AFXDLL" /D "_MBCS" /D "NODEVILLIB" /FR"$(INTDIR)\\" /Fo"$(INTDIR)\\" /Fd"$(INTDIR)\\" /FD /GZ /c 

"$(INTDIR)\il_cut.obj"	"$(INTDIR)\il_cut.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) @<<
  $(CPP_SWITCHES) $(SOURCE)
<<


!ENDIF 

SOURCE="..\..\..\DevIL\src-IL\src\il_dcx.c"

!IF  "$(CFG)" == "MWEdit - Win32 Release"

CPP_SWITCHES=/nologo /MD /W3 /GX /O2 /I "d:\vcsource\esp\morrow\mwedit" /I "d:\vcsource\devil\src-il\include" /I "d:\vcsource\devil\src-ilu\include" /I "d:\vcsource\devil\src-ilut\include" /D "NDEBUG" /D "WIN32" /D "_WINDOWS" /D "_AFXDLL" /D "_MBCS" /D "NODEVILLIB" /FR"$(INTDIR)\\" /Fo"$(INTDIR)\\" /Fd"$(INTDIR)\\" /FD /c 

"$(INTDIR)\il_dcx.obj"	"$(INTDIR)\il_dcx.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) @<<
  $(CPP_SWITCHES) $(SOURCE)
<<


!ELSEIF  "$(CFG)" == "MWEdit - Win32 Debug"

CPP_SWITCHES=/nologo /MDd /W3 /Gm /GX /ZI /Od /I "d:\vcsource\esp\morrow\mwedit" /I "d:\vcsource\devil\src-il\include" /I "d:\vcsource\devil\src-ilu\include" /I "d:\vcsource\devil\src-ilut\include" /D "_DEBUG" /D "WIN32" /D "_WINDOWS" /D "_AFXDLL" /D "_MBCS" /D "NODEVILLIB" /FR"$(INTDIR)\\" /Fo"$(INTDIR)\\" /Fd"$(INTDIR)\\" /FD /GZ /c 

"$(INTDIR)\il_dcx.obj"	"$(INTDIR)\il_dcx.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) @<<
  $(CPP_SWITCHES) $(SOURCE)
<<


!ENDIF 

SOURCE="..\..\..\DevIL\src-IL\src\il_dds-save.c"

!IF  "$(CFG)" == "MWEdit - Win32 Release"

CPP_SWITCHES=/nologo /MD /W3 /GX /O2 /I "d:\vcsource\esp\morrow\mwedit" /I "d:\vcsource\devil\src-il\include" /I "d:\vcsource\devil\src-ilu\include" /I "d:\vcsource\devil\src-ilut\include" /D "NDEBUG" /D "WIN32" /D "_WINDOWS" /D "_AFXDLL" /D "_MBCS" /D "NODEVILLIB" /FR"$(INTDIR)\\" /Fo"$(INTDIR)\\" /Fd"$(INTDIR)\\" /FD /c 

"$(INTDIR)\il_dds-save.obj"	"$(INTDIR)\il_dds-save.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) @<<
  $(CPP_SWITCHES) $(SOURCE)
<<


!ELSEIF  "$(CFG)" == "MWEdit - Win32 Debug"

CPP_SWITCHES=/nologo /MDd /W3 /Gm /GX /ZI /Od /I "d:\vcsource\esp\morrow\mwedit" /I "d:\vcsource\devil\src-il\include" /I "d:\vcsource\devil\src-ilu\include" /I "d:\vcsource\devil\src-ilut\include" /D "_DEBUG" /D "WIN32" /D "_WINDOWS" /D "_AFXDLL" /D "_MBCS" /D "NODEVILLIB" /FR"$(INTDIR)\\" /Fo"$(INTDIR)\\" /Fd"$(INTDIR)\\" /FD /GZ /c 

"$(INTDIR)\il_dds-save.obj"	"$(INTDIR)\il_dds-save.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) @<<
  $(CPP_SWITCHES) $(SOURCE)
<<


!ENDIF 

SOURCE="..\..\..\DevIL\src-IL\src\il_dds.c"

!IF  "$(CFG)" == "MWEdit - Win32 Release"

CPP_SWITCHES=/nologo /MD /W3 /GX /O2 /I "d:\vcsource\esp\morrow\mwedit" /I "d:\vcsource\devil\src-il\include" /I "d:\vcsource\devil\src-ilu\include" /I "d:\vcsource\devil\src-ilut\include" /D "NDEBUG" /D "WIN32" /D "_WINDOWS" /D "_AFXDLL" /D "_MBCS" /D "NODEVILLIB" /FR"$(INTDIR)\\" /Fo"$(INTDIR)\\" /Fd"$(INTDIR)\\" /FD /c 

"$(INTDIR)\il_dds.obj"	"$(INTDIR)\il_dds.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) @<<
  $(CPP_SWITCHES) $(SOURCE)
<<


!ELSEIF  "$(CFG)" == "MWEdit - Win32 Debug"

CPP_SWITCHES=/nologo /MDd /W3 /Gm /GX /ZI /Od /I "d:\vcsource\esp\morrow\mwedit" /I "d:\vcsource\devil\src-il\include" /I "d:\vcsource\devil\src-ilu\include" /I "d:\vcsource\devil\src-ilut\include" /D "_DEBUG" /D "WIN32" /D "_WINDOWS" /D "_AFXDLL" /D "_MBCS" /D "NODEVILLIB" /FR"$(INTDIR)\\" /Fo"$(INTDIR)\\" /Fd"$(INTDIR)\\" /FD /GZ /c 

"$(INTDIR)\il_dds.obj"	"$(INTDIR)\il_dds.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) @<<
  $(CPP_SWITCHES) $(SOURCE)
<<


!ENDIF 

SOURCE="..\..\..\DevIL\src-IL\src\il_devil.c"

!IF  "$(CFG)" == "MWEdit - Win32 Release"

CPP_SWITCHES=/nologo /MD /W3 /GX /O2 /I "d:\vcsource\esp\morrow\mwedit" /I "d:\vcsource\devil\src-il\include" /I "d:\vcsource\devil\src-ilu\include" /I "d:\vcsource\devil\src-ilut\include" /D "NDEBUG" /D "WIN32" /D "_WINDOWS" /D "_AFXDLL" /D "_MBCS" /D "NODEVILLIB" /FR"$(INTDIR)\\" /Fo"$(INTDIR)\\" /Fd"$(INTDIR)\\" /FD /c 

"$(INTDIR)\il_devil.obj"	"$(INTDIR)\il_devil.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) @<<
  $(CPP_SWITCHES) $(SOURCE)
<<


!ELSEIF  "$(CFG)" == "MWEdit - Win32 Debug"

CPP_SWITCHES=/nologo /MDd /W3 /Gm /GX /ZI /Od /I "d:\vcsource\esp\morrow\mwedit" /I "d:\vcsource\devil\src-il\include" /I "d:\vcsource\devil\src-ilu\include" /I "d:\vcsource\devil\src-ilut\include" /D "_DEBUG" /D "WIN32" /D "_WINDOWS" /D "_AFXDLL" /D "_MBCS" /D "NODEVILLIB" /FR"$(INTDIR)\\" /Fo"$(INTDIR)\\" /Fd"$(INTDIR)\\" /FD /GZ /c 

"$(INTDIR)\il_devil.obj"	"$(INTDIR)\il_devil.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) @<<
  $(CPP_SWITCHES) $(SOURCE)
<<


!ENDIF 

SOURCE="..\..\..\DevIL\src-IL\src\il_doom.c"

!IF  "$(CFG)" == "MWEdit - Win32 Release"

CPP_SWITCHES=/nologo /MD /W3 /GX /O2 /I "d:\vcsource\esp\morrow\mwedit" /I "d:\vcsource\devil\src-il\include" /I "d:\vcsource\devil\src-ilu\include" /I "d:\vcsource\devil\src-ilut\include" /D "NDEBUG" /D "WIN32" /D "_WINDOWS" /D "_AFXDLL" /D "_MBCS" /D "NODEVILLIB" /FR"$(INTDIR)\\" /Fo"$(INTDIR)\\" /Fd"$(INTDIR)\\" /FD /c 

"$(INTDIR)\il_doom.obj"	"$(INTDIR)\il_doom.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) @<<
  $(CPP_SWITCHES) $(SOURCE)
<<


!ELSEIF  "$(CFG)" == "MWEdit - Win32 Debug"

CPP_SWITCHES=/nologo /MDd /W3 /Gm /GX /ZI /Od /I "d:\vcsource\esp\morrow\mwedit" /I "d:\vcsource\devil\src-il\include" /I "d:\vcsource\devil\src-ilu\include" /I "d:\vcsource\devil\src-ilut\include" /D "_DEBUG" /D "WIN32" /D "_WINDOWS" /D "_AFXDLL" /D "_MBCS" /D "NODEVILLIB" /FR"$(INTDIR)\\" /Fo"$(INTDIR)\\" /Fd"$(INTDIR)\\" /FD /GZ /c 

"$(INTDIR)\il_doom.obj"	"$(INTDIR)\il_doom.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) @<<
  $(CPP_SWITCHES) $(SOURCE)
<<


!ENDIF 

SOURCE="..\..\..\DevIL\src-IL\src\il_endian.c"

!IF  "$(CFG)" == "MWEdit - Win32 Release"

CPP_SWITCHES=/nologo /MD /W3 /GX /O2 /I "d:\vcsource\esp\morrow\mwedit" /I "d:\vcsource\devil\src-il\include" /I "d:\vcsource\devil\src-ilu\include" /I "d:\vcsource\devil\src-ilut\include" /D "NDEBUG" /D "WIN32" /D "_WINDOWS" /D "_AFXDLL" /D "_MBCS" /D "NODEVILLIB" /FR"$(INTDIR)\\" /Fo"$(INTDIR)\\" /Fd"$(INTDIR)\\" /FD /c 

"$(INTDIR)\il_endian.obj"	"$(INTDIR)\il_endian.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) @<<
  $(CPP_SWITCHES) $(SOURCE)
<<


!ELSEIF  "$(CFG)" == "MWEdit - Win32 Debug"

CPP_SWITCHES=/nologo /MDd /W3 /Gm /GX /ZI /Od /I "d:\vcsource\esp\morrow\mwedit" /I "d:\vcsource\devil\src-il\include" /I "d:\vcsource\devil\src-ilu\include" /I "d:\vcsource\devil\src-ilut\include" /D "_DEBUG" /D "WIN32" /D "_WINDOWS" /D "_AFXDLL" /D "_MBCS" /D "NODEVILLIB" /FR"$(INTDIR)\\" /Fo"$(INTDIR)\\" /Fd"$(INTDIR)\\" /FD /GZ /c 

"$(INTDIR)\il_endian.obj"	"$(INTDIR)\il_endian.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) @<<
  $(CPP_SWITCHES) $(SOURCE)
<<


!ENDIF 

SOURCE="..\..\..\DevIL\src-IL\src\il_error.c"

!IF  "$(CFG)" == "MWEdit - Win32 Release"

CPP_SWITCHES=/nologo /MD /W3 /GX /O2 /I "d:\vcsource\esp\morrow\mwedit" /I "d:\vcsource\devil\src-il\include" /I "d:\vcsource\devil\src-ilu\include" /I "d:\vcsource\devil\src-ilut\include" /D "NDEBUG" /D "WIN32" /D "_WINDOWS" /D "_AFXDLL" /D "_MBCS" /D "NODEVILLIB" /FR"$(INTDIR)\\" /Fo"$(INTDIR)\\" /Fd"$(INTDIR)\\" /FD /c 

"$(INTDIR)\il_error.obj"	"$(INTDIR)\il_error.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) @<<
  $(CPP_SWITCHES) $(SOURCE)
<<


!ELSEIF  "$(CFG)" == "MWEdit - Win32 Debug"

CPP_SWITCHES=/nologo /MDd /W3 /Gm /GX /ZI /Od /I "d:\vcsource\esp\morrow\mwedit" /I "d:\vcsource\devil\src-il\include" /I "d:\vcsource\devil\src-ilu\include" /I "d:\vcsource\devil\src-ilut\include" /D "_DEBUG" /D "WIN32" /D "_WINDOWS" /D "_AFXDLL" /D "_MBCS" /D "NODEVILLIB" /FR"$(INTDIR)\\" /Fo"$(INTDIR)\\" /Fd"$(INTDIR)\\" /FD /GZ /c 

"$(INTDIR)\il_error.obj"	"$(INTDIR)\il_error.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) @<<
  $(CPP_SWITCHES) $(SOURCE)
<<


!ENDIF 

SOURCE="..\..\..\DevIL\src-IL\src\il_fastconv.c"

!IF  "$(CFG)" == "MWEdit - Win32 Release"

CPP_SWITCHES=/nologo /MD /W3 /GX /O2 /I "d:\vcsource\esp\morrow\mwedit" /I "d:\vcsource\devil\src-il\include" /I "d:\vcsource\devil\src-ilu\include" /I "d:\vcsource\devil\src-ilut\include" /D "NDEBUG" /D "WIN32" /D "_WINDOWS" /D "_AFXDLL" /D "_MBCS" /D "NODEVILLIB" /FR"$(INTDIR)\\" /Fo"$(INTDIR)\\" /Fd"$(INTDIR)\\" /FD /c 

"$(INTDIR)\il_fastconv.obj"	"$(INTDIR)\il_fastconv.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) @<<
  $(CPP_SWITCHES) $(SOURCE)
<<


!ELSEIF  "$(CFG)" == "MWEdit - Win32 Debug"

CPP_SWITCHES=/nologo /MDd /W3 /Gm /GX /ZI /Od /I "d:\vcsource\esp\morrow\mwedit" /I "d:\vcsource\devil\src-il\include" /I "d:\vcsource\devil\src-ilu\include" /I "d:\vcsource\devil\src-ilut\include" /D "_DEBUG" /D "WIN32" /D "_WINDOWS" /D "_AFXDLL" /D "_MBCS" /D "NODEVILLIB" /FR"$(INTDIR)\\" /Fo"$(INTDIR)\\" /Fd"$(INTDIR)\\" /FD /GZ /c 

"$(INTDIR)\il_fastconv.obj"	"$(INTDIR)\il_fastconv.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) @<<
  $(CPP_SWITCHES) $(SOURCE)
<<


!ENDIF 

SOURCE="..\..\..\DevIL\src-IL\src\il_files.c"

!IF  "$(CFG)" == "MWEdit - Win32 Release"

CPP_SWITCHES=/nologo /MD /W3 /GX /O2 /I "d:\vcsource\esp\morrow\mwedit" /I "d:\vcsource\devil\src-il\include" /I "d:\vcsource\devil\src-ilu\include" /I "d:\vcsource\devil\src-ilut\include" /D "NDEBUG" /D "WIN32" /D "_WINDOWS" /D "_AFXDLL" /D "_MBCS" /D "NODEVILLIB" /FR"$(INTDIR)\\" /Fo"$(INTDIR)\\" /Fd"$(INTDIR)\\" /FD /c 

"$(INTDIR)\il_files.obj"	"$(INTDIR)\il_files.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) @<<
  $(CPP_SWITCHES) $(SOURCE)
<<


!ELSEIF  "$(CFG)" == "MWEdit - Win32 Debug"

CPP_SWITCHES=/nologo /MDd /W3 /Gm /GX /ZI /Od /I "d:\vcsource\esp\morrow\mwedit" /I "d:\vcsource\devil\src-il\include" /I "d:\vcsource\devil\src-ilu\include" /I "d:\vcsource\devil\src-ilut\include" /D "_DEBUG" /D "WIN32" /D "_WINDOWS" /D "_AFXDLL" /D "_MBCS" /D "NODEVILLIB" /FR"$(INTDIR)\\" /Fo"$(INTDIR)\\" /Fd"$(INTDIR)\\" /FD /GZ /c 

"$(INTDIR)\il_files.obj"	"$(INTDIR)\il_files.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) @<<
  $(CPP_SWITCHES) $(SOURCE)
<<


!ENDIF 

SOURCE="..\..\..\DevIL\src-IL\src\il_gif.c"

!IF  "$(CFG)" == "MWEdit - Win32 Release"

CPP_SWITCHES=/nologo /MD /W3 /GX /O2 /I "d:\vcsource\esp\morrow\mwedit" /I "d:\vcsource\devil\src-il\include" /I "d:\vcsource\devil\src-ilu\include" /I "d:\vcsource\devil\src-ilut\include" /D "NDEBUG" /D "WIN32" /D "_WINDOWS" /D "_AFXDLL" /D "_MBCS" /D "NODEVILLIB" /FR"$(INTDIR)\\" /Fo"$(INTDIR)\\" /Fd"$(INTDIR)\\" /FD /c 

"$(INTDIR)\il_gif.obj"	"$(INTDIR)\il_gif.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) @<<
  $(CPP_SWITCHES) $(SOURCE)
<<


!ELSEIF  "$(CFG)" == "MWEdit - Win32 Debug"

CPP_SWITCHES=/nologo /MDd /W3 /Gm /GX /ZI /Od /I "d:\vcsource\esp\morrow\mwedit" /I "d:\vcsource\devil\src-il\include" /I "d:\vcsource\devil\src-ilu\include" /I "d:\vcsource\devil\src-ilut\include" /D "_DEBUG" /D "WIN32" /D "_WINDOWS" /D "_AFXDLL" /D "_MBCS" /D "NODEVILLIB" /FR"$(INTDIR)\\" /Fo"$(INTDIR)\\" /Fd"$(INTDIR)\\" /FD /GZ /c 

"$(INTDIR)\il_gif.obj"	"$(INTDIR)\il_gif.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) @<<
  $(CPP_SWITCHES) $(SOURCE)
<<


!ENDIF 

SOURCE="..\..\..\DevIL\src-IL\src\il_header.c"

!IF  "$(CFG)" == "MWEdit - Win32 Release"

CPP_SWITCHES=/nologo /MD /W3 /GX /O2 /I "d:\vcsource\esp\morrow\mwedit" /I "d:\vcsource\devil\src-il\include" /I "d:\vcsource\devil\src-ilu\include" /I "d:\vcsource\devil\src-ilut\include" /D "NDEBUG" /D "WIN32" /D "_WINDOWS" /D "_AFXDLL" /D "_MBCS" /D "NODEVILLIB" /FR"$(INTDIR)\\" /Fo"$(INTDIR)\\" /Fd"$(INTDIR)\\" /FD /c 

"$(INTDIR)\il_header.obj"	"$(INTDIR)\il_header.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) @<<
  $(CPP_SWITCHES) $(SOURCE)
<<


!ELSEIF  "$(CFG)" == "MWEdit - Win32 Debug"

CPP_SWITCHES=/nologo /MDd /W3 /Gm /GX /ZI /Od /I "d:\vcsource\esp\morrow\mwedit" /I "d:\vcsource\devil\src-il\include" /I "d:\vcsource\devil\src-ilu\include" /I "d:\vcsource\devil\src-ilut\include" /D "_DEBUG" /D "WIN32" /D "_WINDOWS" /D "_AFXDLL" /D "_MBCS" /D "NODEVILLIB" /FR"$(INTDIR)\\" /Fo"$(INTDIR)\\" /Fd"$(INTDIR)\\" /FD /GZ /c 

"$(INTDIR)\il_header.obj"	"$(INTDIR)\il_header.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) @<<
  $(CPP_SWITCHES) $(SOURCE)
<<


!ENDIF 

SOURCE="..\..\..\DevIL\src-IL\src\il_icon.c"

!IF  "$(CFG)" == "MWEdit - Win32 Release"

CPP_SWITCHES=/nologo /MD /W3 /GX /O2 /I "d:\vcsource\esp\morrow\mwedit" /I "d:\vcsource\devil\src-il\include" /I "d:\vcsource\devil\src-ilu\include" /I "d:\vcsource\devil\src-ilut\include" /D "NDEBUG" /D "WIN32" /D "_WINDOWS" /D "_AFXDLL" /D "_MBCS" /D "NODEVILLIB" /FR"$(INTDIR)\\" /Fo"$(INTDIR)\\" /Fd"$(INTDIR)\\" /FD /c 

"$(INTDIR)\il_icon.obj"	"$(INTDIR)\il_icon.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) @<<
  $(CPP_SWITCHES) $(SOURCE)
<<


!ELSEIF  "$(CFG)" == "MWEdit - Win32 Debug"

CPP_SWITCHES=/nologo /MDd /W3 /Gm /GX /ZI /Od /I "d:\vcsource\esp\morrow\mwedit" /I "d:\vcsource\devil\src-il\include" /I "d:\vcsource\devil\src-ilu\include" /I "d:\vcsource\devil\src-ilut\include" /D "_DEBUG" /D "WIN32" /D "_WINDOWS" /D "_AFXDLL" /D "_MBCS" /D "NODEVILLIB" /FR"$(INTDIR)\\" /Fo"$(INTDIR)\\" /Fd"$(INTDIR)\\" /FD /GZ /c 

"$(INTDIR)\il_icon.obj"	"$(INTDIR)\il_icon.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) @<<
  $(CPP_SWITCHES) $(SOURCE)
<<


!ENDIF 

SOURCE="..\..\..\DevIL\src-IL\src\il_internal.c"

!IF  "$(CFG)" == "MWEdit - Win32 Release"

CPP_SWITCHES=/nologo /MD /W3 /GX /O2 /I "d:\vcsource\esp\morrow\mwedit" /I "d:\vcsource\devil\src-il\include" /I "d:\vcsource\devil\src-ilu\include" /I "d:\vcsource\devil\src-ilut\include" /D "NDEBUG" /D "WIN32" /D "_WINDOWS" /D "_AFXDLL" /D "_MBCS" /D "NODEVILLIB" /FR"$(INTDIR)\\" /Fo"$(INTDIR)\\" /Fd"$(INTDIR)\\" /FD /c 

"$(INTDIR)\il_internal.obj"	"$(INTDIR)\il_internal.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) @<<
  $(CPP_SWITCHES) $(SOURCE)
<<


!ELSEIF  "$(CFG)" == "MWEdit - Win32 Debug"

CPP_SWITCHES=/nologo /MDd /W3 /Gm /GX /ZI /Od /I "d:\vcsource\esp\morrow\mwedit" /I "d:\vcsource\devil\src-il\include" /I "d:\vcsource\devil\src-ilu\include" /I "d:\vcsource\devil\src-ilut\include" /D "_DEBUG" /D "WIN32" /D "_WINDOWS" /D "_AFXDLL" /D "_MBCS" /D "NODEVILLIB" /FR"$(INTDIR)\\" /Fo"$(INTDIR)\\" /Fd"$(INTDIR)\\" /FD /GZ /c 

"$(INTDIR)\il_internal.obj"	"$(INTDIR)\il_internal.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) @<<
  $(CPP_SWITCHES) $(SOURCE)
<<


!ENDIF 

SOURCE="..\..\..\DevIL\src-IL\src\il_io.c"

!IF  "$(CFG)" == "MWEdit - Win32 Release"

CPP_SWITCHES=/nologo /MD /W3 /GX /O2 /I "d:\vcsource\esp\morrow\mwedit" /I "d:\vcsource\devil\src-il\include" /I "d:\vcsource\devil\src-ilu\include" /I "d:\vcsource\devil\src-ilut\include" /D "NDEBUG" /D "WIN32" /D "_WINDOWS" /D "_AFXDLL" /D "_MBCS" /D "NODEVILLIB" /FR"$(INTDIR)\\" /Fo"$(INTDIR)\\" /Fd"$(INTDIR)\\" /FD /c 

"$(INTDIR)\il_io.obj"	"$(INTDIR)\il_io.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) @<<
  $(CPP_SWITCHES) $(SOURCE)
<<


!ELSEIF  "$(CFG)" == "MWEdit - Win32 Debug"

CPP_SWITCHES=/nologo /MDd /W3 /Gm /GX /ZI /Od /I "d:\vcsource\esp\morrow\mwedit" /I "d:\vcsource\devil\src-il\include" /I "d:\vcsource\devil\src-ilu\include" /I "d:\vcsource\devil\src-ilut\include" /D "_DEBUG" /D "WIN32" /D "_WINDOWS" /D "_AFXDLL" /D "_MBCS" /D "NODEVILLIB" /FR"$(INTDIR)\\" /Fo"$(INTDIR)\\" /Fd"$(INTDIR)\\" /FD /GZ /c 

"$(INTDIR)\il_io.obj"	"$(INTDIR)\il_io.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) @<<
  $(CPP_SWITCHES) $(SOURCE)
<<


!ENDIF 

SOURCE="..\..\..\DevIL\src-IL\src\il_jpeg.c"

!IF  "$(CFG)" == "MWEdit - Win32 Release"

CPP_SWITCHES=/nologo /MD /W3 /GX /O2 /I "d:\vcsource\esp\morrow\mwedit" /I "d:\vcsource\devil\src-il\include" /I "d:\vcsource\devil\src-ilu\include" /I "d:\vcsource\devil\src-ilut\include" /D "NDEBUG" /D "WIN32" /D "_WINDOWS" /D "_AFXDLL" /D "_MBCS" /D "NODEVILLIB" /FR"$(INTDIR)\\" /Fo"$(INTDIR)\\" /Fd"$(INTDIR)\\" /FD /c 

"$(INTDIR)\il_jpeg.obj"	"$(INTDIR)\il_jpeg.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) @<<
  $(CPP_SWITCHES) $(SOURCE)
<<


!ELSEIF  "$(CFG)" == "MWEdit - Win32 Debug"

CPP_SWITCHES=/nologo /MDd /W3 /Gm /GX /ZI /Od /I "d:\vcsource\esp\morrow\mwedit" /I "d:\vcsource\devil\src-il\include" /I "d:\vcsource\devil\src-ilu\include" /I "d:\vcsource\devil\src-ilut\include" /D "_DEBUG" /D "WIN32" /D "_WINDOWS" /D "_AFXDLL" /D "_MBCS" /D "NODEVILLIB" /FR"$(INTDIR)\\" /Fo"$(INTDIR)\\" /Fd"$(INTDIR)\\" /FD /GZ /c 

"$(INTDIR)\il_jpeg.obj"	"$(INTDIR)\il_jpeg.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) @<<
  $(CPP_SWITCHES) $(SOURCE)
<<


!ENDIF 

SOURCE="..\..\..\DevIL\src-IL\src\il_lif.c"

!IF  "$(CFG)" == "MWEdit - Win32 Release"

CPP_SWITCHES=/nologo /MD /W3 /GX /O2 /I "d:\vcsource\esp\morrow\mwedit" /I "d:\vcsource\devil\src-il\include" /I "d:\vcsource\devil\src-ilu\include" /I "d:\vcsource\devil\src-ilut\include" /D "NDEBUG" /D "WIN32" /D "_WINDOWS" /D "_AFXDLL" /D "_MBCS" /D "NODEVILLIB" /FR"$(INTDIR)\\" /Fo"$(INTDIR)\\" /Fd"$(INTDIR)\\" /FD /c 

"$(INTDIR)\il_lif.obj"	"$(INTDIR)\il_lif.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) @<<
  $(CPP_SWITCHES) $(SOURCE)
<<


!ELSEIF  "$(CFG)" == "MWEdit - Win32 Debug"

CPP_SWITCHES=/nologo /MDd /W3 /Gm /GX /ZI /Od /I "d:\vcsource\esp\morrow\mwedit" /I "d:\vcsource\devil\src-il\include" /I "d:\vcsource\devil\src-ilu\include" /I "d:\vcsource\devil\src-ilut\include" /D "_DEBUG" /D "WIN32" /D "_WINDOWS" /D "_AFXDLL" /D "_MBCS" /D "NODEVILLIB" /FR"$(INTDIR)\\" /Fo"$(INTDIR)\\" /Fd"$(INTDIR)\\" /FD /GZ /c 

"$(INTDIR)\il_lif.obj"	"$(INTDIR)\il_lif.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) @<<
  $(CPP_SWITCHES) $(SOURCE)
<<


!ENDIF 

SOURCE="..\..\..\DevIL\src-IL\src\il_main.c"

!IF  "$(CFG)" == "MWEdit - Win32 Release"

CPP_SWITCHES=/nologo /MD /W3 /GX /O2 /I "d:\vcsource\esp\morrow\mwedit" /I "d:\vcsource\devil\src-il\include" /I "d:\vcsource\devil\src-ilu\include" /I "d:\vcsource\devil\src-ilut\include" /D "NDEBUG" /D "WIN32" /D "_WINDOWS" /D "_AFXDLL" /D "_MBCS" /D "NODEVILLIB" /FR"$(INTDIR)\\" /Fo"$(INTDIR)\\" /Fd"$(INTDIR)\\" /FD /c 

"$(INTDIR)\il_main.obj"	"$(INTDIR)\il_main.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) @<<
  $(CPP_SWITCHES) $(SOURCE)
<<


!ELSEIF  "$(CFG)" == "MWEdit - Win32 Debug"

CPP_SWITCHES=/nologo /MDd /W3 /Gm /GX /ZI /Od /I "d:\vcsource\esp\morrow\mwedit" /I "d:\vcsource\devil\src-il\include" /I "d:\vcsource\devil\src-ilu\include" /I "d:\vcsource\devil\src-ilut\include" /D "_DEBUG" /D "WIN32" /D "_WINDOWS" /D "_AFXDLL" /D "_MBCS" /D "NODEVILLIB" /FR"$(INTDIR)\\" /Fo"$(INTDIR)\\" /Fd"$(INTDIR)\\" /FD /GZ /c 

"$(INTDIR)\il_main.obj"	"$(INTDIR)\il_main.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) @<<
  $(CPP_SWITCHES) $(SOURCE)
<<


!ENDIF 

SOURCE="..\..\..\DevIL\src-IL\src\il_manip.c"

!IF  "$(CFG)" == "MWEdit - Win32 Release"

CPP_SWITCHES=/nologo /MD /W3 /GX /O2 /I "d:\vcsource\esp\morrow\mwedit" /I "d:\vcsource\devil\src-il\include" /I "d:\vcsource\devil\src-ilu\include" /I "d:\vcsource\devil\src-ilut\include" /D "NDEBUG" /D "WIN32" /D "_WINDOWS" /D "_AFXDLL" /D "_MBCS" /D "NODEVILLIB" /FR"$(INTDIR)\\" /Fo"$(INTDIR)\\" /Fd"$(INTDIR)\\" /FD /c 

"$(INTDIR)\il_manip.obj"	"$(INTDIR)\il_manip.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) @<<
  $(CPP_SWITCHES) $(SOURCE)
<<


!ELSEIF  "$(CFG)" == "MWEdit - Win32 Debug"

CPP_SWITCHES=/nologo /MDd /W3 /Gm /GX /ZI /Od /I "d:\vcsource\esp\morrow\mwedit" /I "d:\vcsource\devil\src-il\include" /I "d:\vcsource\devil\src-ilu\include" /I "d:\vcsource\devil\src-ilut\include" /D "_DEBUG" /D "WIN32" /D "_WINDOWS" /D "_AFXDLL" /D "_MBCS" /D "NODEVILLIB" /FR"$(INTDIR)\\" /Fo"$(INTDIR)\\" /Fd"$(INTDIR)\\" /FD /GZ /c 

"$(INTDIR)\il_manip.obj"	"$(INTDIR)\il_manip.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) @<<
  $(CPP_SWITCHES) $(SOURCE)
<<


!ENDIF 

SOURCE="..\..\..\DevIL\src-IL\src\il_mdl.c"

!IF  "$(CFG)" == "MWEdit - Win32 Release"

CPP_SWITCHES=/nologo /MD /W3 /GX /O2 /I "d:\vcsource\esp\morrow\mwedit" /I "d:\vcsource\devil\src-il\include" /I "d:\vcsource\devil\src-ilu\include" /I "d:\vcsource\devil\src-ilut\include" /D "NDEBUG" /D "WIN32" /D "_WINDOWS" /D "_AFXDLL" /D "_MBCS" /D "NODEVILLIB" /FR"$(INTDIR)\\" /Fo"$(INTDIR)\\" /Fd"$(INTDIR)\\" /FD /c 

"$(INTDIR)\il_mdl.obj"	"$(INTDIR)\il_mdl.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) @<<
  $(CPP_SWITCHES) $(SOURCE)
<<


!ELSEIF  "$(CFG)" == "MWEdit - Win32 Debug"

CPP_SWITCHES=/nologo /MDd /W3 /Gm /GX /ZI /Od /I "d:\vcsource\esp\morrow\mwedit" /I "d:\vcsource\devil\src-il\include" /I "d:\vcsource\devil\src-ilu\include" /I "d:\vcsource\devil\src-ilut\include" /D "_DEBUG" /D "WIN32" /D "_WINDOWS" /D "_AFXDLL" /D "_MBCS" /D "NODEVILLIB" /FR"$(INTDIR)\\" /Fo"$(INTDIR)\\" /Fd"$(INTDIR)\\" /FD /GZ /c 

"$(INTDIR)\il_mdl.obj"	"$(INTDIR)\il_mdl.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) @<<
  $(CPP_SWITCHES) $(SOURCE)
<<


!ENDIF 

SOURCE="..\..\..\DevIL\src-IL\src\il_mng.c"

!IF  "$(CFG)" == "MWEdit - Win32 Release"

CPP_SWITCHES=/nologo /MD /W3 /GX /O2 /I "d:\vcsource\esp\morrow\mwedit" /I "d:\vcsource\devil\src-il\include" /I "d:\vcsource\devil\src-ilu\include" /I "d:\vcsource\devil\src-ilut\include" /D "NDEBUG" /D "WIN32" /D "_WINDOWS" /D "_AFXDLL" /D "_MBCS" /D "NODEVILLIB" /FR"$(INTDIR)\\" /Fo"$(INTDIR)\\" /Fd"$(INTDIR)\\" /FD /c 

"$(INTDIR)\il_mng.obj"	"$(INTDIR)\il_mng.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) @<<
  $(CPP_SWITCHES) $(SOURCE)
<<


!ELSEIF  "$(CFG)" == "MWEdit - Win32 Debug"

CPP_SWITCHES=/nologo /MDd /W3 /Gm /GX /ZI /Od /I "d:\vcsource\esp\morrow\mwedit" /I "d:\vcsource\devil\src-il\include" /I "d:\vcsource\devil\src-ilu\include" /I "d:\vcsource\devil\src-ilut\include" /D "_DEBUG" /D "WIN32" /D "_WINDOWS" /D "_AFXDLL" /D "_MBCS" /D "NODEVILLIB" /FR"$(INTDIR)\\" /Fo"$(INTDIR)\\" /Fd"$(INTDIR)\\" /FD /GZ /c 

"$(INTDIR)\il_mng.obj"	"$(INTDIR)\il_mng.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) @<<
  $(CPP_SWITCHES) $(SOURCE)
<<


!ENDIF 

SOURCE="..\..\..\DevIL\src-IL\src\il_neuquant.c"

!IF  "$(CFG)" == "MWEdit - Win32 Release"

CPP_SWITCHES=/nologo /MD /W3 /GX /O2 /I "d:\vcsource\esp\morrow\mwedit" /I "d:\vcsource\devil\src-il\include" /I "d:\vcsource\devil\src-ilu\include" /I "d:\vcsource\devil\src-ilut\include" /D "NDEBUG" /D "WIN32" /D "_WINDOWS" /D "_AFXDLL" /D "_MBCS" /D "NODEVILLIB" /FR"$(INTDIR)\\" /Fo"$(INTDIR)\\" /Fd"$(INTDIR)\\" /FD /c 

"$(INTDIR)\il_neuquant.obj"	"$(INTDIR)\il_neuquant.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) @<<
  $(CPP_SWITCHES) $(SOURCE)
<<


!ELSEIF  "$(CFG)" == "MWEdit - Win32 Debug"

CPP_SWITCHES=/nologo /MDd /W3 /Gm /GX /ZI /Od /I "d:\vcsource\esp\morrow\mwedit" /I "d:\vcsource\devil\src-il\include" /I "d:\vcsource\devil\src-ilu\include" /I "d:\vcsource\devil\src-ilut\include" /D "_DEBUG" /D "WIN32" /D "_WINDOWS" /D "_AFXDLL" /D "_MBCS" /D "NODEVILLIB" /FR"$(INTDIR)\\" /Fo"$(INTDIR)\\" /Fd"$(INTDIR)\\" /FD /GZ /c 

"$(INTDIR)\il_neuquant.obj"	"$(INTDIR)\il_neuquant.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) @<<
  $(CPP_SWITCHES) $(SOURCE)
<<


!ENDIF 

SOURCE="..\..\..\DevIL\src-IL\src\il_pal.c"

!IF  "$(CFG)" == "MWEdit - Win32 Release"

CPP_SWITCHES=/nologo /MD /W3 /GX /O2 /I "d:\vcsource\esp\morrow\mwedit" /I "d:\vcsource\devil\src-il\include" /I "d:\vcsource\devil\src-ilu\include" /I "d:\vcsource\devil\src-ilut\include" /D "NDEBUG" /D "WIN32" /D "_WINDOWS" /D "_AFXDLL" /D "_MBCS" /D "NODEVILLIB" /FR"$(INTDIR)\\" /Fo"$(INTDIR)\\" /Fd"$(INTDIR)\\" /FD /c 

"$(INTDIR)\il_pal.obj"	"$(INTDIR)\il_pal.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) @<<
  $(CPP_SWITCHES) $(SOURCE)
<<


!ELSEIF  "$(CFG)" == "MWEdit - Win32 Debug"

CPP_SWITCHES=/nologo /MDd /W3 /Gm /GX /ZI /Od /I "d:\vcsource\esp\morrow\mwedit" /I "d:\vcsource\devil\src-il\include" /I "d:\vcsource\devil\src-ilu\include" /I "d:\vcsource\devil\src-ilut\include" /D "_DEBUG" /D "WIN32" /D "_WINDOWS" /D "_AFXDLL" /D "_MBCS" /D "NODEVILLIB" /FR"$(INTDIR)\\" /Fo"$(INTDIR)\\" /Fd"$(INTDIR)\\" /FD /GZ /c 

"$(INTDIR)\il_pal.obj"	"$(INTDIR)\il_pal.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) @<<
  $(CPP_SWITCHES) $(SOURCE)
<<


!ENDIF 

SOURCE="..\..\..\DevIL\src-IL\src\il_pcd.c"

!IF  "$(CFG)" == "MWEdit - Win32 Release"

CPP_SWITCHES=/nologo /MD /W3 /GX /O2 /I "d:\vcsource\esp\morrow\mwedit" /I "d:\vcsource\devil\src-il\include" /I "d:\vcsource\devil\src-ilu\include" /I "d:\vcsource\devil\src-ilut\include" /D "NDEBUG" /D "WIN32" /D "_WINDOWS" /D "_AFXDLL" /D "_MBCS" /D "NODEVILLIB" /FR"$(INTDIR)\\" /Fo"$(INTDIR)\\" /Fd"$(INTDIR)\\" /FD /c 

"$(INTDIR)\il_pcd.obj"	"$(INTDIR)\il_pcd.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) @<<
  $(CPP_SWITCHES) $(SOURCE)
<<


!ELSEIF  "$(CFG)" == "MWEdit - Win32 Debug"

CPP_SWITCHES=/nologo /MDd /W3 /Gm /GX /ZI /Od /I "d:\vcsource\esp\morrow\mwedit" /I "d:\vcsource\devil\src-il\include" /I "d:\vcsource\devil\src-ilu\include" /I "d:\vcsource\devil\src-ilut\include" /D "_DEBUG" /D "WIN32" /D "_WINDOWS" /D "_AFXDLL" /D "_MBCS" /D "NODEVILLIB" /FR"$(INTDIR)\\" /Fo"$(INTDIR)\\" /Fd"$(INTDIR)\\" /FD /GZ /c 

"$(INTDIR)\il_pcd.obj"	"$(INTDIR)\il_pcd.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) @<<
  $(CPP_SWITCHES) $(SOURCE)
<<


!ENDIF 

SOURCE="..\..\..\DevIL\src-IL\src\il_pcx.c"

!IF  "$(CFG)" == "MWEdit - Win32 Release"

CPP_SWITCHES=/nologo /MD /W3 /GX /O2 /I "d:\vcsource\esp\morrow\mwedit" /I "d:\vcsource\devil\src-il\include" /I "d:\vcsource\devil\src-ilu\include" /I "d:\vcsource\devil\src-ilut\include" /D "NDEBUG" /D "WIN32" /D "_WINDOWS" /D "_AFXDLL" /D "_MBCS" /D "NODEVILLIB" /FR"$(INTDIR)\\" /Fo"$(INTDIR)\\" /Fd"$(INTDIR)\\" /FD /c 

"$(INTDIR)\il_pcx.obj"	"$(INTDIR)\il_pcx.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) @<<
  $(CPP_SWITCHES) $(SOURCE)
<<


!ELSEIF  "$(CFG)" == "MWEdit - Win32 Debug"

CPP_SWITCHES=/nologo /MDd /W3 /Gm /GX /ZI /Od /I "d:\vcsource\esp\morrow\mwedit" /I "d:\vcsource\devil\src-il\include" /I "d:\vcsource\devil\src-ilu\include" /I "d:\vcsource\devil\src-ilut\include" /D "_DEBUG" /D "WIN32" /D "_WINDOWS" /D "_AFXDLL" /D "_MBCS" /D "NODEVILLIB" /FR"$(INTDIR)\\" /Fo"$(INTDIR)\\" /Fd"$(INTDIR)\\" /FD /GZ /c 

"$(INTDIR)\il_pcx.obj"	"$(INTDIR)\il_pcx.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) @<<
  $(CPP_SWITCHES) $(SOURCE)
<<


!ENDIF 

SOURCE="..\..\..\DevIL\src-IL\src\il_pic.c"

!IF  "$(CFG)" == "MWEdit - Win32 Release"

CPP_SWITCHES=/nologo /MD /W3 /GX /O2 /I "d:\vcsource\esp\morrow\mwedit" /I "d:\vcsource\devil\src-il\include" /I "d:\vcsource\devil\src-ilu\include" /I "d:\vcsource\devil\src-ilut\include" /D "NDEBUG" /D "WIN32" /D "_WINDOWS" /D "_AFXDLL" /D "_MBCS" /D "NODEVILLIB" /FR"$(INTDIR)\\" /Fo"$(INTDIR)\\" /Fd"$(INTDIR)\\" /FD /c 

"$(INTDIR)\il_pic.obj"	"$(INTDIR)\il_pic.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) @<<
  $(CPP_SWITCHES) $(SOURCE)
<<


!ELSEIF  "$(CFG)" == "MWEdit - Win32 Debug"

CPP_SWITCHES=/nologo /MDd /W3 /Gm /GX /ZI /Od /I "d:\vcsource\esp\morrow\mwedit" /I "d:\vcsource\devil\src-il\include" /I "d:\vcsource\devil\src-ilu\include" /I "d:\vcsource\devil\src-ilut\include" /D "_DEBUG" /D "WIN32" /D "_WINDOWS" /D "_AFXDLL" /D "_MBCS" /D "NODEVILLIB" /FR"$(INTDIR)\\" /Fo"$(INTDIR)\\" /Fd"$(INTDIR)\\" /FD /GZ /c 

"$(INTDIR)\il_pic.obj"	"$(INTDIR)\il_pic.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) @<<
  $(CPP_SWITCHES) $(SOURCE)
<<


!ENDIF 

SOURCE="..\..\..\DevIL\src-IL\src\il_pix.c"

!IF  "$(CFG)" == "MWEdit - Win32 Release"

CPP_SWITCHES=/nologo /MD /W3 /GX /O2 /I "d:\vcsource\esp\morrow\mwedit" /I "d:\vcsource\devil\src-il\include" /I "d:\vcsource\devil\src-ilu\include" /I "d:\vcsource\devil\src-ilut\include" /D "NDEBUG" /D "WIN32" /D "_WINDOWS" /D "_AFXDLL" /D "_MBCS" /D "NODEVILLIB" /FR"$(INTDIR)\\" /Fo"$(INTDIR)\\" /Fd"$(INTDIR)\\" /FD /c 

"$(INTDIR)\il_pix.obj"	"$(INTDIR)\il_pix.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) @<<
  $(CPP_SWITCHES) $(SOURCE)
<<


!ELSEIF  "$(CFG)" == "MWEdit - Win32 Debug"

CPP_SWITCHES=/nologo /MDd /W3 /Gm /GX /ZI /Od /I "d:\vcsource\esp\morrow\mwedit" /I "d:\vcsource\devil\src-il\include" /I "d:\vcsource\devil\src-ilu\include" /I "d:\vcsource\devil\src-ilut\include" /D "_DEBUG" /D "WIN32" /D "_WINDOWS" /D "_AFXDLL" /D "_MBCS" /D "NODEVILLIB" /FR"$(INTDIR)\\" /Fo"$(INTDIR)\\" /Fd"$(INTDIR)\\" /FD /GZ /c 

"$(INTDIR)\il_pix.obj"	"$(INTDIR)\il_pix.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) @<<
  $(CPP_SWITCHES) $(SOURCE)
<<


!ENDIF 

SOURCE="..\..\..\DevIL\src-IL\src\il_png.c"

!IF  "$(CFG)" == "MWEdit - Win32 Release"

CPP_SWITCHES=/nologo /MD /W3 /GX /O2 /I "d:\vcsource\esp\morrow\mwedit" /I "d:\vcsource\devil\src-il\include" /I "d:\vcsource\devil\src-ilu\include" /I "d:\vcsource\devil\src-ilut\include" /D "NDEBUG" /D "WIN32" /D "_WINDOWS" /D "_AFXDLL" /D "_MBCS" /D "NODEVILLIB" /FR"$(INTDIR)\\" /Fo"$(INTDIR)\\" /Fd"$(INTDIR)\\" /FD /c 

"$(INTDIR)\il_png.obj"	"$(INTDIR)\il_png.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) @<<
  $(CPP_SWITCHES) $(SOURCE)
<<


!ELSEIF  "$(CFG)" == "MWEdit - Win32 Debug"

CPP_SWITCHES=/nologo /MDd /W3 /Gm /GX /ZI /Od /I "d:\vcsource\esp\morrow\mwedit" /I "d:\vcsource\devil\src-il\include" /I "d:\vcsource\devil\src-ilu\include" /I "d:\vcsource\devil\src-ilut\include" /D "_DEBUG" /D "WIN32" /D "_WINDOWS" /D "_AFXDLL" /D "_MBCS" /D "NODEVILLIB" /FR"$(INTDIR)\\" /Fo"$(INTDIR)\\" /Fd"$(INTDIR)\\" /FD /GZ /c 

"$(INTDIR)\il_png.obj"	"$(INTDIR)\il_png.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) @<<
  $(CPP_SWITCHES) $(SOURCE)
<<


!ENDIF 

SOURCE="..\..\..\DevIL\src-IL\src\il_pnm.c"

!IF  "$(CFG)" == "MWEdit - Win32 Release"

CPP_SWITCHES=/nologo /MD /W3 /GX /O2 /I "d:\vcsource\esp\morrow\mwedit" /I "d:\vcsource\devil\src-il\include" /I "d:\vcsource\devil\src-ilu\include" /I "d:\vcsource\devil\src-ilut\include" /D "NDEBUG" /D "WIN32" /D "_WINDOWS" /D "_AFXDLL" /D "_MBCS" /D "NODEVILLIB" /FR"$(INTDIR)\\" /Fo"$(INTDIR)\\" /Fd"$(INTDIR)\\" /FD /c 

"$(INTDIR)\il_pnm.obj"	"$(INTDIR)\il_pnm.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) @<<
  $(CPP_SWITCHES) $(SOURCE)
<<


!ELSEIF  "$(CFG)" == "MWEdit - Win32 Debug"

CPP_SWITCHES=/nologo /MDd /W3 /Gm /GX /ZI /Od /I "d:\vcsource\esp\morrow\mwedit" /I "d:\vcsource\devil\src-il\include" /I "d:\vcsource\devil\src-ilu\include" /I "d:\vcsource\devil\src-ilut\include" /D "_DEBUG" /D "WIN32" /D "_WINDOWS" /D "_AFXDLL" /D "_MBCS" /D "NODEVILLIB" /FR"$(INTDIR)\\" /Fo"$(INTDIR)\\" /Fd"$(INTDIR)\\" /FD /GZ /c 

"$(INTDIR)\il_pnm.obj"	"$(INTDIR)\il_pnm.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) @<<
  $(CPP_SWITCHES) $(SOURCE)
<<


!ENDIF 

SOURCE="..\..\..\DevIL\src-IL\src\il_profiles.c"

!IF  "$(CFG)" == "MWEdit - Win32 Release"

CPP_SWITCHES=/nologo /MD /W3 /GX /O2 /I "d:\vcsource\esp\morrow\mwedit" /I "d:\vcsource\devil\src-il\include" /I "d:\vcsource\devil\src-ilu\include" /I "d:\vcsource\devil\src-ilut\include" /D "NDEBUG" /D "WIN32" /D "_WINDOWS" /D "_AFXDLL" /D "_MBCS" /D "NODEVILLIB" /FR"$(INTDIR)\\" /Fo"$(INTDIR)\\" /Fd"$(INTDIR)\\" /FD /c 

"$(INTDIR)\il_profiles.obj"	"$(INTDIR)\il_profiles.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) @<<
  $(CPP_SWITCHES) $(SOURCE)
<<


!ELSEIF  "$(CFG)" == "MWEdit - Win32 Debug"

CPP_SWITCHES=/nologo /MDd /W3 /Gm /GX /ZI /Od /I "d:\vcsource\esp\morrow\mwedit" /I "d:\vcsource\devil\src-il\include" /I "d:\vcsource\devil\src-ilu\include" /I "d:\vcsource\devil\src-ilut\include" /D "_DEBUG" /D "WIN32" /D "_WINDOWS" /D "_AFXDLL" /D "_MBCS" /D "NODEVILLIB" /FR"$(INTDIR)\\" /Fo"$(INTDIR)\\" /Fd"$(INTDIR)\\" /FD /GZ /c 

"$(INTDIR)\il_profiles.obj"	"$(INTDIR)\il_profiles.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) @<<
  $(CPP_SWITCHES) $(SOURCE)
<<


!ENDIF 

SOURCE="..\..\..\DevIL\src-IL\src\il_psd.c"

!IF  "$(CFG)" == "MWEdit - Win32 Release"

CPP_SWITCHES=/nologo /MD /W3 /GX /O2 /I "d:\vcsource\esp\morrow\mwedit" /I "d:\vcsource\devil\src-il\include" /I "d:\vcsource\devil\src-ilu\include" /I "d:\vcsource\devil\src-ilut\include" /D "NDEBUG" /D "WIN32" /D "_WINDOWS" /D "_AFXDLL" /D "_MBCS" /D "NODEVILLIB" /FR"$(INTDIR)\\" /Fo"$(INTDIR)\\" /Fd"$(INTDIR)\\" /FD /c 

"$(INTDIR)\il_psd.obj"	"$(INTDIR)\il_psd.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) @<<
  $(CPP_SWITCHES) $(SOURCE)
<<


!ELSEIF  "$(CFG)" == "MWEdit - Win32 Debug"

CPP_SWITCHES=/nologo /MDd /W3 /Gm /GX /ZI /Od /I "d:\vcsource\esp\morrow\mwedit" /I "d:\vcsource\devil\src-il\include" /I "d:\vcsource\devil\src-ilu\include" /I "d:\vcsource\devil\src-ilut\include" /D "_DEBUG" /D "WIN32" /D "_WINDOWS" /D "_AFXDLL" /D "_MBCS" /D "NODEVILLIB" /FR"$(INTDIR)\\" /Fo"$(INTDIR)\\" /Fd"$(INTDIR)\\" /FD /GZ /c 

"$(INTDIR)\il_psd.obj"	"$(INTDIR)\il_psd.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) @<<
  $(CPP_SWITCHES) $(SOURCE)
<<


!ENDIF 

SOURCE="..\..\..\DevIL\src-IL\src\il_psp.c"

!IF  "$(CFG)" == "MWEdit - Win32 Release"

CPP_SWITCHES=/nologo /MD /W3 /GX /O2 /I "d:\vcsource\esp\morrow\mwedit" /I "d:\vcsource\devil\src-il\include" /I "d:\vcsource\devil\src-ilu\include" /I "d:\vcsource\devil\src-ilut\include" /D "NDEBUG" /D "WIN32" /D "_WINDOWS" /D "_AFXDLL" /D "_MBCS" /D "NODEVILLIB" /FR"$(INTDIR)\\" /Fo"$(INTDIR)\\" /Fd"$(INTDIR)\\" /FD /c 

"$(INTDIR)\il_psp.obj"	"$(INTDIR)\il_psp.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) @<<
  $(CPP_SWITCHES) $(SOURCE)
<<


!ELSEIF  "$(CFG)" == "MWEdit - Win32 Debug"

CPP_SWITCHES=/nologo /MDd /W3 /Gm /GX /ZI /Od /I "d:\vcsource\esp\morrow\mwedit" /I "d:\vcsource\devil\src-il\include" /I "d:\vcsource\devil\src-ilu\include" /I "d:\vcsource\devil\src-ilut\include" /D "_DEBUG" /D "WIN32" /D "_WINDOWS" /D "_AFXDLL" /D "_MBCS" /D "NODEVILLIB" /FR"$(INTDIR)\\" /Fo"$(INTDIR)\\" /Fd"$(INTDIR)\\" /FD /GZ /c 

"$(INTDIR)\il_psp.obj"	"$(INTDIR)\il_psp.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) @<<
  $(CPP_SWITCHES) $(SOURCE)
<<


!ENDIF 

SOURCE="..\..\..\DevIL\src-IL\src\il_pxr.c"

!IF  "$(CFG)" == "MWEdit - Win32 Release"

CPP_SWITCHES=/nologo /MD /W3 /GX /O2 /I "d:\vcsource\esp\morrow\mwedit" /I "d:\vcsource\devil\src-il\include" /I "d:\vcsource\devil\src-ilu\include" /I "d:\vcsource\devil\src-ilut\include" /D "NDEBUG" /D "WIN32" /D "_WINDOWS" /D "_AFXDLL" /D "_MBCS" /D "NODEVILLIB" /FR"$(INTDIR)\\" /Fo"$(INTDIR)\\" /Fd"$(INTDIR)\\" /FD /c 

"$(INTDIR)\il_pxr.obj"	"$(INTDIR)\il_pxr.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) @<<
  $(CPP_SWITCHES) $(SOURCE)
<<


!ELSEIF  "$(CFG)" == "MWEdit - Win32 Debug"

CPP_SWITCHES=/nologo /MDd /W3 /Gm /GX /ZI /Od /I "d:\vcsource\esp\morrow\mwedit" /I "d:\vcsource\devil\src-il\include" /I "d:\vcsource\devil\src-ilu\include" /I "d:\vcsource\devil\src-ilut\include" /D "_DEBUG" /D "WIN32" /D "_WINDOWS" /D "_AFXDLL" /D "_MBCS" /D "NODEVILLIB" /FR"$(INTDIR)\\" /Fo"$(INTDIR)\\" /Fd"$(INTDIR)\\" /FD /GZ /c 

"$(INTDIR)\il_pxr.obj"	"$(INTDIR)\il_pxr.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) @<<
  $(CPP_SWITCHES) $(SOURCE)
<<


!ENDIF 

SOURCE="..\..\..\DevIL\src-IL\src\il_quantizer.c"

!IF  "$(CFG)" == "MWEdit - Win32 Release"

CPP_SWITCHES=/nologo /MD /W3 /GX /O2 /I "d:\vcsource\esp\morrow\mwedit" /I "d:\vcsource\devil\src-il\include" /I "d:\vcsource\devil\src-ilu\include" /I "d:\vcsource\devil\src-ilut\include" /D "NDEBUG" /D "WIN32" /D "_WINDOWS" /D "_AFXDLL" /D "_MBCS" /D "NODEVILLIB" /FR"$(INTDIR)\\" /Fo"$(INTDIR)\\" /Fd"$(INTDIR)\\" /FD /c 

"$(INTDIR)\il_quantizer.obj"	"$(INTDIR)\il_quantizer.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) @<<
  $(CPP_SWITCHES) $(SOURCE)
<<


!ELSEIF  "$(CFG)" == "MWEdit - Win32 Debug"

CPP_SWITCHES=/nologo /MDd /W3 /Gm /GX /ZI /Od /I "d:\vcsource\esp\morrow\mwedit" /I "d:\vcsource\devil\src-il\include" /I "d:\vcsource\devil\src-ilu\include" /I "d:\vcsource\devil\src-ilut\include" /D "_DEBUG" /D "WIN32" /D "_WINDOWS" /D "_AFXDLL" /D "_MBCS" /D "NODEVILLIB" /FR"$(INTDIR)\\" /Fo"$(INTDIR)\\" /Fd"$(INTDIR)\\" /FD /GZ /c 

"$(INTDIR)\il_quantizer.obj"	"$(INTDIR)\il_quantizer.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) @<<
  $(CPP_SWITCHES) $(SOURCE)
<<


!ENDIF 

SOURCE="..\..\..\DevIL\src-IL\src\il_raw.c"

!IF  "$(CFG)" == "MWEdit - Win32 Release"

CPP_SWITCHES=/nologo /MD /W3 /GX /O2 /I "d:\vcsource\esp\morrow\mwedit" /I "d:\vcsource\devil\src-il\include" /I "d:\vcsource\devil\src-ilu\include" /I "d:\vcsource\devil\src-ilut\include" /D "NDEBUG" /D "WIN32" /D "_WINDOWS" /D "_AFXDLL" /D "_MBCS" /D "NODEVILLIB" /FR"$(INTDIR)\\" /Fo"$(INTDIR)\\" /Fd"$(INTDIR)\\" /FD /c 

"$(INTDIR)\il_raw.obj"	"$(INTDIR)\il_raw.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) @<<
  $(CPP_SWITCHES) $(SOURCE)
<<


!ELSEIF  "$(CFG)" == "MWEdit - Win32 Debug"

CPP_SWITCHES=/nologo /MDd /W3 /Gm /GX /ZI /Od /I "d:\vcsource\esp\morrow\mwedit" /I "d:\vcsource\devil\src-il\include" /I "d:\vcsource\devil\src-ilu\include" /I "d:\vcsource\devil\src-ilut\include" /D "_DEBUG" /D "WIN32" /D "_WINDOWS" /D "_AFXDLL" /D "_MBCS" /D "NODEVILLIB" /FR"$(INTDIR)\\" /Fo"$(INTDIR)\\" /Fd"$(INTDIR)\\" /FD /GZ /c 

"$(INTDIR)\il_raw.obj"	"$(INTDIR)\il_raw.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) @<<
  $(CPP_SWITCHES) $(SOURCE)
<<


!ENDIF 

SOURCE="..\..\..\DevIL\src-IL\src\il_rawdata.c"

!IF  "$(CFG)" == "MWEdit - Win32 Release"

CPP_SWITCHES=/nologo /MD /W3 /GX /O2 /I "d:\vcsource\esp\morrow\mwedit" /I "d:\vcsource\devil\src-il\include" /I "d:\vcsource\devil\src-ilu\include" /I "d:\vcsource\devil\src-ilut\include" /D "NDEBUG" /D "WIN32" /D "_WINDOWS" /D "_AFXDLL" /D "_MBCS" /D "NODEVILLIB" /FR"$(INTDIR)\\" /Fo"$(INTDIR)\\" /Fd"$(INTDIR)\\" /FD /c 

"$(INTDIR)\il_rawdata.obj"	"$(INTDIR)\il_rawdata.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) @<<
  $(CPP_SWITCHES) $(SOURCE)
<<


!ELSEIF  "$(CFG)" == "MWEdit - Win32 Debug"

CPP_SWITCHES=/nologo /MDd /W3 /Gm /GX /ZI /Od /I "d:\vcsource\esp\morrow\mwedit" /I "d:\vcsource\devil\src-il\include" /I "d:\vcsource\devil\src-ilu\include" /I "d:\vcsource\devil\src-ilut\include" /D "_DEBUG" /D "WIN32" /D "_WINDOWS" /D "_AFXDLL" /D "_MBCS" /D "NODEVILLIB" /FR"$(INTDIR)\\" /Fo"$(INTDIR)\\" /Fd"$(INTDIR)\\" /FD /GZ /c 

"$(INTDIR)\il_rawdata.obj"	"$(INTDIR)\il_rawdata.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) @<<
  $(CPP_SWITCHES) $(SOURCE)
<<


!ENDIF 

SOURCE="..\..\..\DevIL\src-IL\src\il_register.c"

!IF  "$(CFG)" == "MWEdit - Win32 Release"

CPP_SWITCHES=/nologo /MD /W3 /GX /O2 /I "d:\vcsource\esp\morrow\mwedit" /I "d:\vcsource\devil\src-il\include" /I "d:\vcsource\devil\src-ilu\include" /I "d:\vcsource\devil\src-ilut\include" /D "NDEBUG" /D "WIN32" /D "_WINDOWS" /D "_AFXDLL" /D "_MBCS" /D "NODEVILLIB" /FR"$(INTDIR)\\" /Fo"$(INTDIR)\\" /Fd"$(INTDIR)\\" /FD /c 

"$(INTDIR)\il_register.obj"	"$(INTDIR)\il_register.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) @<<
  $(CPP_SWITCHES) $(SOURCE)
<<


!ELSEIF  "$(CFG)" == "MWEdit - Win32 Debug"

CPP_SWITCHES=/nologo /MDd /W3 /Gm /GX /ZI /Od /I "d:\vcsource\esp\morrow\mwedit" /I "d:\vcsource\devil\src-il\include" /I "d:\vcsource\devil\src-ilu\include" /I "d:\vcsource\devil\src-ilut\include" /D "_DEBUG" /D "WIN32" /D "_WINDOWS" /D "_AFXDLL" /D "_MBCS" /D "NODEVILLIB" /FR"$(INTDIR)\\" /Fo"$(INTDIR)\\" /Fd"$(INTDIR)\\" /FD /GZ /c 

"$(INTDIR)\il_register.obj"	"$(INTDIR)\il_register.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) @<<
  $(CPP_SWITCHES) $(SOURCE)
<<


!ENDIF 

SOURCE="..\..\..\DevIL\src-IL\src\il_rle.c"

!IF  "$(CFG)" == "MWEdit - Win32 Release"

CPP_SWITCHES=/nologo /MD /W3 /GX /O2 /I "d:\vcsource\esp\morrow\mwedit" /I "d:\vcsource\devil\src-il\include" /I "d:\vcsource\devil\src-ilu\include" /I "d:\vcsource\devil\src-ilut\include" /D "NDEBUG" /D "WIN32" /D "_WINDOWS" /D "_AFXDLL" /D "_MBCS" /D "NODEVILLIB" /FR"$(INTDIR)\\" /Fo"$(INTDIR)\\" /Fd"$(INTDIR)\\" /FD /c 

"$(INTDIR)\il_rle.obj"	"$(INTDIR)\il_rle.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) @<<
  $(CPP_SWITCHES) $(SOURCE)
<<


!ELSEIF  "$(CFG)" == "MWEdit - Win32 Debug"

CPP_SWITCHES=/nologo /MDd /W3 /Gm /GX /ZI /Od /I "d:\vcsource\esp\morrow\mwedit" /I "d:\vcsource\devil\src-il\include" /I "d:\vcsource\devil\src-ilu\include" /I "d:\vcsource\devil\src-ilut\include" /D "_DEBUG" /D "WIN32" /D "_WINDOWS" /D "_AFXDLL" /D "_MBCS" /D "NODEVILLIB" /FR"$(INTDIR)\\" /Fo"$(INTDIR)\\" /Fd"$(INTDIR)\\" /FD /GZ /c 

"$(INTDIR)\il_rle.obj"	"$(INTDIR)\il_rle.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) @<<
  $(CPP_SWITCHES) $(SOURCE)
<<


!ENDIF 

SOURCE="..\..\..\DevIL\src-IL\src\il_sgi.c"

!IF  "$(CFG)" == "MWEdit - Win32 Release"

CPP_SWITCHES=/nologo /MD /W3 /GX /O2 /I "d:\vcsource\esp\morrow\mwedit" /I "d:\vcsource\devil\src-il\include" /I "d:\vcsource\devil\src-ilu\include" /I "d:\vcsource\devil\src-ilut\include" /D "NDEBUG" /D "WIN32" /D "_WINDOWS" /D "_AFXDLL" /D "_MBCS" /D "NODEVILLIB" /FR"$(INTDIR)\\" /Fo"$(INTDIR)\\" /Fd"$(INTDIR)\\" /FD /c 

"$(INTDIR)\il_sgi.obj"	"$(INTDIR)\il_sgi.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) @<<
  $(CPP_SWITCHES) $(SOURCE)
<<


!ELSEIF  "$(CFG)" == "MWEdit - Win32 Debug"

CPP_SWITCHES=/nologo /MDd /W3 /Gm /GX /ZI /Od /I "d:\vcsource\esp\morrow\mwedit" /I "d:\vcsource\devil\src-il\include" /I "d:\vcsource\devil\src-ilu\include" /I "d:\vcsource\devil\src-ilut\include" /D "_DEBUG" /D "WIN32" /D "_WINDOWS" /D "_AFXDLL" /D "_MBCS" /D "NODEVILLIB" /FR"$(INTDIR)\\" /Fo"$(INTDIR)\\" /Fd"$(INTDIR)\\" /FD /GZ /c 

"$(INTDIR)\il_sgi.obj"	"$(INTDIR)\il_sgi.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) @<<
  $(CPP_SWITCHES) $(SOURCE)
<<


!ENDIF 

SOURCE="..\..\..\DevIL\src-IL\src\il_stack.c"

!IF  "$(CFG)" == "MWEdit - Win32 Release"

CPP_SWITCHES=/nologo /MD /W3 /GX /O2 /I "d:\vcsource\esp\morrow\mwedit" /I "d:\vcsource\devil\src-il\include" /I "d:\vcsource\devil\src-ilu\include" /I "d:\vcsource\devil\src-ilut\include" /D "NDEBUG" /D "WIN32" /D "_WINDOWS" /D "_AFXDLL" /D "_MBCS" /D "NODEVILLIB" /FR"$(INTDIR)\\" /Fo"$(INTDIR)\\" /Fd"$(INTDIR)\\" /FD /c 

"$(INTDIR)\il_stack.obj"	"$(INTDIR)\il_stack.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) @<<
  $(CPP_SWITCHES) $(SOURCE)
<<


!ELSEIF  "$(CFG)" == "MWEdit - Win32 Debug"

CPP_SWITCHES=/nologo /MDd /W3 /Gm /GX /ZI /Od /I "d:\vcsource\esp\morrow\mwedit" /I "d:\vcsource\devil\src-il\include" /I "d:\vcsource\devil\src-ilu\include" /I "d:\vcsource\devil\src-ilut\include" /D "_DEBUG" /D "WIN32" /D "_WINDOWS" /D "_AFXDLL" /D "_MBCS" /D "NODEVILLIB" /FR"$(INTDIR)\\" /Fo"$(INTDIR)\\" /Fd"$(INTDIR)\\" /FD /GZ /c 

"$(INTDIR)\il_stack.obj"	"$(INTDIR)\il_stack.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) @<<
  $(CPP_SWITCHES) $(SOURCE)
<<


!ENDIF 

SOURCE="..\..\..\DevIL\src-IL\src\il_states.c"

!IF  "$(CFG)" == "MWEdit - Win32 Release"

CPP_SWITCHES=/nologo /MD /W3 /GX /O2 /I "d:\vcsource\esp\morrow\mwedit" /I "d:\vcsource\devil\src-il\include" /I "d:\vcsource\devil\src-ilu\include" /I "d:\vcsource\devil\src-ilut\include" /D "NDEBUG" /D "WIN32" /D "_WINDOWS" /D "_AFXDLL" /D "_MBCS" /D "NODEVILLIB" /FR"$(INTDIR)\\" /Fo"$(INTDIR)\\" /Fd"$(INTDIR)\\" /FD /c 

"$(INTDIR)\il_states.obj"	"$(INTDIR)\il_states.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) @<<
  $(CPP_SWITCHES) $(SOURCE)
<<


!ELSEIF  "$(CFG)" == "MWEdit - Win32 Debug"

CPP_SWITCHES=/nologo /MDd /W3 /Gm /GX /ZI /Od /I "d:\vcsource\esp\morrow\mwedit" /I "d:\vcsource\devil\src-il\include" /I "d:\vcsource\devil\src-ilu\include" /I "d:\vcsource\devil\src-ilut\include" /D "_DEBUG" /D "WIN32" /D "_WINDOWS" /D "_AFXDLL" /D "_MBCS" /D "NODEVILLIB" /FR"$(INTDIR)\\" /Fo"$(INTDIR)\\" /Fd"$(INTDIR)\\" /FD /GZ /c 

"$(INTDIR)\il_states.obj"	"$(INTDIR)\il_states.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) @<<
  $(CPP_SWITCHES) $(SOURCE)
<<


!ENDIF 

SOURCE="..\..\..\DevIL\src-IL\src\il_targa.c"

!IF  "$(CFG)" == "MWEdit - Win32 Release"

CPP_SWITCHES=/nologo /MD /W3 /GX /O2 /I "d:\vcsource\esp\morrow\mwedit" /I "d:\vcsource\devil\src-il\include" /I "d:\vcsource\devil\src-ilu\include" /I "d:\vcsource\devil\src-ilut\include" /D "NDEBUG" /D "WIN32" /D "_WINDOWS" /D "_AFXDLL" /D "_MBCS" /D "NODEVILLIB" /FR"$(INTDIR)\\" /Fo"$(INTDIR)\\" /Fd"$(INTDIR)\\" /FD /c 

"$(INTDIR)\il_targa.obj"	"$(INTDIR)\il_targa.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) @<<
  $(CPP_SWITCHES) $(SOURCE)
<<


!ELSEIF  "$(CFG)" == "MWEdit - Win32 Debug"

CPP_SWITCHES=/nologo /MDd /W3 /Gm /GX /ZI /Od /I "d:\vcsource\esp\morrow\mwedit" /I "d:\vcsource\devil\src-il\include" /I "d:\vcsource\devil\src-ilu\include" /I "d:\vcsource\devil\src-ilut\include" /D "_DEBUG" /D "WIN32" /D "_WINDOWS" /D "_AFXDLL" /D "_MBCS" /D "NODEVILLIB" /FR"$(INTDIR)\\" /Fo"$(INTDIR)\\" /Fd"$(INTDIR)\\" /FD /GZ /c 

"$(INTDIR)\il_targa.obj"	"$(INTDIR)\il_targa.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) @<<
  $(CPP_SWITCHES) $(SOURCE)
<<


!ENDIF 

SOURCE="..\..\..\DevIL\src-IL\src\il_tiff.c"

!IF  "$(CFG)" == "MWEdit - Win32 Release"

CPP_SWITCHES=/nologo /MD /W3 /GX /O2 /I "d:\vcsource\esp\morrow\mwedit" /I "d:\vcsource\devil\src-il\include" /I "d:\vcsource\devil\src-ilu\include" /I "d:\vcsource\devil\src-ilut\include" /D "NDEBUG" /D "WIN32" /D "_WINDOWS" /D "_AFXDLL" /D "_MBCS" /D "NODEVILLIB" /FR"$(INTDIR)\\" /Fo"$(INTDIR)\\" /Fd"$(INTDIR)\\" /FD /c 

"$(INTDIR)\il_tiff.obj"	"$(INTDIR)\il_tiff.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) @<<
  $(CPP_SWITCHES) $(SOURCE)
<<


!ELSEIF  "$(CFG)" == "MWEdit - Win32 Debug"

CPP_SWITCHES=/nologo /MDd /W3 /Gm /GX /ZI /Od /I "d:\vcsource\esp\morrow\mwedit" /I "d:\vcsource\devil\src-il\include" /I "d:\vcsource\devil\src-ilu\include" /I "d:\vcsource\devil\src-ilut\include" /D "_DEBUG" /D "WIN32" /D "_WINDOWS" /D "_AFXDLL" /D "_MBCS" /D "NODEVILLIB" /FR"$(INTDIR)\\" /Fo"$(INTDIR)\\" /Fd"$(INTDIR)\\" /FD /GZ /c 

"$(INTDIR)\il_tiff.obj"	"$(INTDIR)\il_tiff.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) @<<
  $(CPP_SWITCHES) $(SOURCE)
<<


!ENDIF 

SOURCE="..\..\..\DevIL\src-IL\src\il_utility.c"

!IF  "$(CFG)" == "MWEdit - Win32 Release"

CPP_SWITCHES=/nologo /MD /W3 /GX /O2 /I "d:\vcsource\esp\morrow\mwedit" /I "d:\vcsource\devil\src-il\include" /I "d:\vcsource\devil\src-ilu\include" /I "d:\vcsource\devil\src-ilut\include" /D "NDEBUG" /D "WIN32" /D "_WINDOWS" /D "_AFXDLL" /D "_MBCS" /D "NODEVILLIB" /FR"$(INTDIR)\\" /Fo"$(INTDIR)\\" /Fd"$(INTDIR)\\" /FD /c 

"$(INTDIR)\il_utility.obj"	"$(INTDIR)\il_utility.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) @<<
  $(CPP_SWITCHES) $(SOURCE)
<<


!ELSEIF  "$(CFG)" == "MWEdit - Win32 Debug"

CPP_SWITCHES=/nologo /MDd /W3 /Gm /GX /ZI /Od /I "d:\vcsource\esp\morrow\mwedit" /I "d:\vcsource\devil\src-il\include" /I "d:\vcsource\devil\src-ilu\include" /I "d:\vcsource\devil\src-ilut\include" /D "_DEBUG" /D "WIN32" /D "_WINDOWS" /D "_AFXDLL" /D "_MBCS" /D "NODEVILLIB" /FR"$(INTDIR)\\" /Fo"$(INTDIR)\\" /Fd"$(INTDIR)\\" /FD /GZ /c 

"$(INTDIR)\il_utility.obj"	"$(INTDIR)\il_utility.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) @<<
  $(CPP_SWITCHES) $(SOURCE)
<<


!ENDIF 

SOURCE="..\..\..\DevIL\src-IL\src\il_wal.c"

!IF  "$(CFG)" == "MWEdit - Win32 Release"

CPP_SWITCHES=/nologo /MD /W3 /GX /O2 /I "d:\vcsource\esp\morrow\mwedit" /I "d:\vcsource\devil\src-il\include" /I "d:\vcsource\devil\src-ilu\include" /I "d:\vcsource\devil\src-ilut\include" /D "NDEBUG" /D "WIN32" /D "_WINDOWS" /D "_AFXDLL" /D "_MBCS" /D "NODEVILLIB" /FR"$(INTDIR)\\" /Fo"$(INTDIR)\\" /Fd"$(INTDIR)\\" /FD /c 

"$(INTDIR)\il_wal.obj"	"$(INTDIR)\il_wal.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) @<<
  $(CPP_SWITCHES) $(SOURCE)
<<


!ELSEIF  "$(CFG)" == "MWEdit - Win32 Debug"

CPP_SWITCHES=/nologo /MDd /W3 /Gm /GX /ZI /Od /I "d:\vcsource\esp\morrow\mwedit" /I "d:\vcsource\devil\src-il\include" /I "d:\vcsource\devil\src-ilu\include" /I "d:\vcsource\devil\src-ilut\include" /D "_DEBUG" /D "WIN32" /D "_WINDOWS" /D "_AFXDLL" /D "_MBCS" /D "NODEVILLIB" /FR"$(INTDIR)\\" /Fo"$(INTDIR)\\" /Fd"$(INTDIR)\\" /FD /GZ /c 

"$(INTDIR)\il_wal.obj"	"$(INTDIR)\il_wal.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) @<<
  $(CPP_SWITCHES) $(SOURCE)
<<


!ENDIF 

SOURCE="..\..\..\DevIL\src-IL\src\il_xpm.c"

!IF  "$(CFG)" == "MWEdit - Win32 Release"

CPP_SWITCHES=/nologo /MD /W3 /GX /O2 /I "d:\vcsource\esp\morrow\mwedit" /I "d:\vcsource\devil\src-il\include" /I "d:\vcsource\devil\src-ilu\include" /I "d:\vcsource\devil\src-ilut\include" /D "NDEBUG" /D "WIN32" /D "_WINDOWS" /D "_AFXDLL" /D "_MBCS" /D "NODEVILLIB" /FR"$(INTDIR)\\" /Fo"$(INTDIR)\\" /Fd"$(INTDIR)\\" /FD /c 

"$(INTDIR)\il_xpm.obj"	"$(INTDIR)\il_xpm.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) @<<
  $(CPP_SWITCHES) $(SOURCE)
<<


!ELSEIF  "$(CFG)" == "MWEdit - Win32 Debug"

CPP_SWITCHES=/nologo /MDd /W3 /Gm /GX /ZI /Od /I "d:\vcsource\esp\morrow\mwedit" /I "d:\vcsource\devil\src-il\include" /I "d:\vcsource\devil\src-ilu\include" /I "d:\vcsource\devil\src-ilut\include" /D "_DEBUG" /D "WIN32" /D "_WINDOWS" /D "_AFXDLL" /D "_MBCS" /D "NODEVILLIB" /FR"$(INTDIR)\\" /Fo"$(INTDIR)\\" /Fd"$(INTDIR)\\" /FD /GZ /c 

"$(INTDIR)\il_xpm.obj"	"$(INTDIR)\il_xpm.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) @<<
  $(CPP_SWITCHES) $(SOURCE)
<<


!ENDIF 

SOURCE="..\..\..\DevIL\src-ILU\src\ilu_alloc.c"

!IF  "$(CFG)" == "MWEdit - Win32 Release"

CPP_SWITCHES=/nologo /MD /W3 /GX /O2 /I "d:\vcsource\esp\morrow\mwedit" /I "d:\vcsource\devil\src-il\include" /I "d:\vcsource\devil\src-ilu\include" /I "d:\vcsource\devil\src-ilut\include" /D "NDEBUG" /D "WIN32" /D "_WINDOWS" /D "_AFXDLL" /D "_MBCS" /D "NODEVILLIB" /FR"$(INTDIR)\\" /Fo"$(INTDIR)\\" /Fd"$(INTDIR)\\" /FD /c 

"$(INTDIR)\ilu_alloc.obj"	"$(INTDIR)\ilu_alloc.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) @<<
  $(CPP_SWITCHES) $(SOURCE)
<<


!ELSEIF  "$(CFG)" == "MWEdit - Win32 Debug"

CPP_SWITCHES=/nologo /MDd /W3 /Gm /GX /ZI /Od /I "d:\vcsource\esp\morrow\mwedit" /I "d:\vcsource\devil\src-il\include" /I "d:\vcsource\devil\src-ilu\include" /I "d:\vcsource\devil\src-ilut\include" /D "_DEBUG" /D "WIN32" /D "_WINDOWS" /D "_AFXDLL" /D "_MBCS" /D "NODEVILLIB" /FR"$(INTDIR)\\" /Fo"$(INTDIR)\\" /Fd"$(INTDIR)\\" /FD /GZ /c 

"$(INTDIR)\ilu_alloc.obj"	"$(INTDIR)\ilu_alloc.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) @<<
  $(CPP_SWITCHES) $(SOURCE)
<<


!ENDIF 

SOURCE="..\..\..\DevIL\src-ILU\src\ilu_error.c"

!IF  "$(CFG)" == "MWEdit - Win32 Release"

CPP_SWITCHES=/nologo /MD /W3 /GX /O2 /I "d:\vcsource\esp\morrow\mwedit" /I "d:\vcsource\devil\src-il\include" /I "d:\vcsource\devil\src-ilu\include" /I "d:\vcsource\devil\src-ilut\include" /D "NDEBUG" /D "WIN32" /D "_WINDOWS" /D "_AFXDLL" /D "_MBCS" /D "NODEVILLIB" /FR"$(INTDIR)\\" /Fo"$(INTDIR)\\" /Fd"$(INTDIR)\\" /FD /c 

"$(INTDIR)\ilu_error.obj"	"$(INTDIR)\ilu_error.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) @<<
  $(CPP_SWITCHES) $(SOURCE)
<<


!ELSEIF  "$(CFG)" == "MWEdit - Win32 Debug"

CPP_SWITCHES=/nologo /MDd /W3 /Gm /GX /ZI /Od /I "d:\vcsource\esp\morrow\mwedit" /I "d:\vcsource\devil\src-il\include" /I "d:\vcsource\devil\src-ilu\include" /I "d:\vcsource\devil\src-ilut\include" /D "_DEBUG" /D "WIN32" /D "_WINDOWS" /D "_AFXDLL" /D "_MBCS" /D "NODEVILLIB" /FR"$(INTDIR)\\" /Fo"$(INTDIR)\\" /Fd"$(INTDIR)\\" /FD /GZ /c 

"$(INTDIR)\ilu_error.obj"	"$(INTDIR)\ilu_error.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) @<<
  $(CPP_SWITCHES) $(SOURCE)
<<


!ENDIF 

SOURCE="..\..\..\DevIL\src-ILU\src\ilu_filter.c"

!IF  "$(CFG)" == "MWEdit - Win32 Release"

CPP_SWITCHES=/nologo /MD /W3 /GX /O2 /I "d:\vcsource\esp\morrow\mwedit" /I "d:\vcsource\devil\src-il\include" /I "d:\vcsource\devil\src-ilu\include" /I "d:\vcsource\devil\src-ilut\include" /D "NDEBUG" /D "WIN32" /D "_WINDOWS" /D "_AFXDLL" /D "_MBCS" /D "NODEVILLIB" /FR"$(INTDIR)\\" /Fo"$(INTDIR)\\" /Fd"$(INTDIR)\\" /FD /c 

"$(INTDIR)\ilu_filter.obj"	"$(INTDIR)\ilu_filter.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) @<<
  $(CPP_SWITCHES) $(SOURCE)
<<


!ELSEIF  "$(CFG)" == "MWEdit - Win32 Debug"

CPP_SWITCHES=/nologo /MDd /W3 /Gm /GX /ZI /Od /I "d:\vcsource\esp\morrow\mwedit" /I "d:\vcsource\devil\src-il\include" /I "d:\vcsource\devil\src-ilu\include" /I "d:\vcsource\devil\src-ilut\include" /D "_DEBUG" /D "WIN32" /D "_WINDOWS" /D "_AFXDLL" /D "_MBCS" /D "NODEVILLIB" /FR"$(INTDIR)\\" /Fo"$(INTDIR)\\" /Fd"$(INTDIR)\\" /FD /GZ /c 

"$(INTDIR)\ilu_filter.obj"	"$(INTDIR)\ilu_filter.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) @<<
  $(CPP_SWITCHES) $(SOURCE)
<<


!ENDIF 

SOURCE="..\..\..\DevIL\src-ILU\src\ilu_filter_rcg.c"

!IF  "$(CFG)" == "MWEdit - Win32 Release"

CPP_SWITCHES=/nologo /MD /W3 /GX /O2 /I "d:\vcsource\esp\morrow\mwedit" /I "d:\vcsource\devil\src-il\include" /I "d:\vcsource\devil\src-ilu\include" /I "d:\vcsource\devil\src-ilut\include" /D "NDEBUG" /D "WIN32" /D "_WINDOWS" /D "_AFXDLL" /D "_MBCS" /D "NODEVILLIB" /FR"$(INTDIR)\\" /Fo"$(INTDIR)\\" /Fd"$(INTDIR)\\" /FD /c 

"$(INTDIR)\ilu_filter_rcg.obj"	"$(INTDIR)\ilu_filter_rcg.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) @<<
  $(CPP_SWITCHES) $(SOURCE)
<<


!ELSEIF  "$(CFG)" == "MWEdit - Win32 Debug"

CPP_SWITCHES=/nologo /MDd /W3 /Gm /GX /ZI /Od /I "d:\vcsource\esp\morrow\mwedit" /I "d:\vcsource\devil\src-il\include" /I "d:\vcsource\devil\src-ilu\include" /I "d:\vcsource\devil\src-ilut\include" /D "_DEBUG" /D "WIN32" /D "_WINDOWS" /D "_AFXDLL" /D "_MBCS" /D "NODEVILLIB" /FR"$(INTDIR)\\" /Fo"$(INTDIR)\\" /Fd"$(INTDIR)\\" /FD /GZ /c 

"$(INTDIR)\ilu_filter_rcg.obj"	"$(INTDIR)\ilu_filter_rcg.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) @<<
  $(CPP_SWITCHES) $(SOURCE)
<<


!ENDIF 

SOURCE="..\..\..\DevIL\src-ILU\src\ilu_internal.c"

!IF  "$(CFG)" == "MWEdit - Win32 Release"

CPP_SWITCHES=/nologo /MD /W3 /GX /O2 /I "d:\vcsource\esp\morrow\mwedit" /I "d:\vcsource\devil\src-il\include" /I "d:\vcsource\devil\src-ilu\include" /I "d:\vcsource\devil\src-ilut\include" /D "NDEBUG" /D "WIN32" /D "_WINDOWS" /D "_AFXDLL" /D "_MBCS" /D "NODEVILLIB" /FR"$(INTDIR)\\" /Fo"$(INTDIR)\\" /Fd"$(INTDIR)\\" /FD /c 

"$(INTDIR)\ilu_internal.obj"	"$(INTDIR)\ilu_internal.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) @<<
  $(CPP_SWITCHES) $(SOURCE)
<<


!ELSEIF  "$(CFG)" == "MWEdit - Win32 Debug"

CPP_SWITCHES=/nologo /MDd /W3 /Gm /GX /ZI /Od /I "d:\vcsource\esp\morrow\mwedit" /I "d:\vcsource\devil\src-il\include" /I "d:\vcsource\devil\src-ilu\include" /I "d:\vcsource\devil\src-ilut\include" /D "_DEBUG" /D "WIN32" /D "_WINDOWS" /D "_AFXDLL" /D "_MBCS" /D "NODEVILLIB" /FR"$(INTDIR)\\" /Fo"$(INTDIR)\\" /Fd"$(INTDIR)\\" /FD /GZ /c 

"$(INTDIR)\ilu_internal.obj"	"$(INTDIR)\ilu_internal.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) @<<
  $(CPP_SWITCHES) $(SOURCE)
<<


!ENDIF 

SOURCE="..\..\..\DevIL\src-ILU\src\ilu_main.c"

!IF  "$(CFG)" == "MWEdit - Win32 Release"

CPP_SWITCHES=/nologo /MD /W3 /GX /O2 /I "d:\vcsource\esp\morrow\mwedit" /I "d:\vcsource\devil\src-il\include" /I "d:\vcsource\devil\src-ilu\include" /I "d:\vcsource\devil\src-ilut\include" /D "NDEBUG" /D "WIN32" /D "_WINDOWS" /D "_AFXDLL" /D "_MBCS" /D "NODEVILLIB" /FR"$(INTDIR)\\" /Fo"$(INTDIR)\\" /Fd"$(INTDIR)\\" /FD /c 

"$(INTDIR)\ilu_main.obj"	"$(INTDIR)\ilu_main.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) @<<
  $(CPP_SWITCHES) $(SOURCE)
<<


!ELSEIF  "$(CFG)" == "MWEdit - Win32 Debug"

CPP_SWITCHES=/nologo /MDd /W3 /Gm /GX /ZI /Od /I "d:\vcsource\esp\morrow\mwedit" /I "d:\vcsource\devil\src-il\include" /I "d:\vcsource\devil\src-ilu\include" /I "d:\vcsource\devil\src-ilut\include" /D "_DEBUG" /D "WIN32" /D "_WINDOWS" /D "_AFXDLL" /D "_MBCS" /D "NODEVILLIB" /FR"$(INTDIR)\\" /Fo"$(INTDIR)\\" /Fd"$(INTDIR)\\" /FD /GZ /c 

"$(INTDIR)\ilu_main.obj"	"$(INTDIR)\ilu_main.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) @<<
  $(CPP_SWITCHES) $(SOURCE)
<<


!ENDIF 

SOURCE="..\..\..\DevIL\src-ILU\src\ilu_manip.c"

!IF  "$(CFG)" == "MWEdit - Win32 Release"

CPP_SWITCHES=/nologo /MD /W3 /GX /O2 /I "d:\vcsource\esp\morrow\mwedit" /I "d:\vcsource\devil\src-il\include" /I "d:\vcsource\devil\src-ilu\include" /I "d:\vcsource\devil\src-ilut\include" /D "NDEBUG" /D "WIN32" /D "_WINDOWS" /D "_AFXDLL" /D "_MBCS" /D "NODEVILLIB" /FR"$(INTDIR)\\" /Fo"$(INTDIR)\\" /Fd"$(INTDIR)\\" /FD /c 

"$(INTDIR)\ilu_manip.obj"	"$(INTDIR)\ilu_manip.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) @<<
  $(CPP_SWITCHES) $(SOURCE)
<<


!ELSEIF  "$(CFG)" == "MWEdit - Win32 Debug"

CPP_SWITCHES=/nologo /MDd /W3 /Gm /GX /ZI /Od /I "d:\vcsource\esp\morrow\mwedit" /I "d:\vcsource\devil\src-il\include" /I "d:\vcsource\devil\src-ilu\include" /I "d:\vcsource\devil\src-ilut\include" /D "_DEBUG" /D "WIN32" /D "_WINDOWS" /D "_AFXDLL" /D "_MBCS" /D "NODEVILLIB" /FR"$(INTDIR)\\" /Fo"$(INTDIR)\\" /Fd"$(INTDIR)\\" /FD /GZ /c 

"$(INTDIR)\ilu_manip.obj"	"$(INTDIR)\ilu_manip.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) @<<
  $(CPP_SWITCHES) $(SOURCE)
<<


!ENDIF 

SOURCE="..\..\..\DevIL\src-ILU\src\ilu_mipmap.c"

!IF  "$(CFG)" == "MWEdit - Win32 Release"

CPP_SWITCHES=/nologo /MD /W3 /GX /O2 /I "d:\vcsource\esp\morrow\mwedit" /I "d:\vcsource\devil\src-il\include" /I "d:\vcsource\devil\src-ilu\include" /I "d:\vcsource\devil\src-ilut\include" /D "NDEBUG" /D "WIN32" /D "_WINDOWS" /D "_AFXDLL" /D "_MBCS" /D "NODEVILLIB" /FR"$(INTDIR)\\" /Fo"$(INTDIR)\\" /Fd"$(INTDIR)\\" /FD /c 

"$(INTDIR)\ilu_mipmap.obj"	"$(INTDIR)\ilu_mipmap.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) @<<
  $(CPP_SWITCHES) $(SOURCE)
<<


!ELSEIF  "$(CFG)" == "MWEdit - Win32 Debug"

CPP_SWITCHES=/nologo /MDd /W3 /Gm /GX /ZI /Od /I "d:\vcsource\esp\morrow\mwedit" /I "d:\vcsource\devil\src-il\include" /I "d:\vcsource\devil\src-ilu\include" /I "d:\vcsource\devil\src-ilut\include" /D "_DEBUG" /D "WIN32" /D "_WINDOWS" /D "_AFXDLL" /D "_MBCS" /D "NODEVILLIB" /FR"$(INTDIR)\\" /Fo"$(INTDIR)\\" /Fd"$(INTDIR)\\" /FD /GZ /c 

"$(INTDIR)\ilu_mipmap.obj"	"$(INTDIR)\ilu_mipmap.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) @<<
  $(CPP_SWITCHES) $(SOURCE)
<<


!ENDIF 

SOURCE="..\..\..\DevIL\src-ILU\src\ilu_noise.c"

!IF  "$(CFG)" == "MWEdit - Win32 Release"

CPP_SWITCHES=/nologo /MD /W3 /GX /O2 /I "d:\vcsource\esp\morrow\mwedit" /I "d:\vcsource\devil\src-il\include" /I "d:\vcsource\devil\src-ilu\include" /I "d:\vcsource\devil\src-ilut\include" /D "NDEBUG" /D "WIN32" /D "_WINDOWS" /D "_AFXDLL" /D "_MBCS" /D "NODEVILLIB" /FR"$(INTDIR)\\" /Fo"$(INTDIR)\\" /Fd"$(INTDIR)\\" /FD /c 

"$(INTDIR)\ilu_noise.obj"	"$(INTDIR)\ilu_noise.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) @<<
  $(CPP_SWITCHES) $(SOURCE)
<<


!ELSEIF  "$(CFG)" == "MWEdit - Win32 Debug"

CPP_SWITCHES=/nologo /MDd /W3 /Gm /GX /ZI /Od /I "d:\vcsource\esp\morrow\mwedit" /I "d:\vcsource\devil\src-il\include" /I "d:\vcsource\devil\src-ilu\include" /I "d:\vcsource\devil\src-ilut\include" /D "_DEBUG" /D "WIN32" /D "_WINDOWS" /D "_AFXDLL" /D "_MBCS" /D "NODEVILLIB" /FR"$(INTDIR)\\" /Fo"$(INTDIR)\\" /Fd"$(INTDIR)\\" /FD /GZ /c 

"$(INTDIR)\ilu_noise.obj"	"$(INTDIR)\ilu_noise.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) @<<
  $(CPP_SWITCHES) $(SOURCE)
<<


!ENDIF 

SOURCE="..\..\..\DevIL\src-ILU\src\ilu_region.c"

!IF  "$(CFG)" == "MWEdit - Win32 Release"

CPP_SWITCHES=/nologo /MD /W3 /GX /O2 /I "d:\vcsource\esp\morrow\mwedit" /I "d:\vcsource\devil\src-il\include" /I "d:\vcsource\devil\src-ilu\include" /I "d:\vcsource\devil\src-ilut\include" /D "NDEBUG" /D "WIN32" /D "_WINDOWS" /D "_AFXDLL" /D "_MBCS" /D "NODEVILLIB" /FR"$(INTDIR)\\" /Fo"$(INTDIR)\\" /Fd"$(INTDIR)\\" /FD /c 

"$(INTDIR)\ilu_region.obj"	"$(INTDIR)\ilu_region.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) @<<
  $(CPP_SWITCHES) $(SOURCE)
<<


!ELSEIF  "$(CFG)" == "MWEdit - Win32 Debug"

CPP_SWITCHES=/nologo /MDd /W3 /Gm /GX /ZI /Od /I "d:\vcsource\esp\morrow\mwedit" /I "d:\vcsource\devil\src-il\include" /I "d:\vcsource\devil\src-ilu\include" /I "d:\vcsource\devil\src-ilut\include" /D "_DEBUG" /D "WIN32" /D "_WINDOWS" /D "_AFXDLL" /D "_MBCS" /D "NODEVILLIB" /FR"$(INTDIR)\\" /Fo"$(INTDIR)\\" /Fd"$(INTDIR)\\" /FD /GZ /c 

"$(INTDIR)\ilu_region.obj"	"$(INTDIR)\ilu_region.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) @<<
  $(CPP_SWITCHES) $(SOURCE)
<<


!ENDIF 

SOURCE="..\..\..\DevIL\src-ILU\src\ilu_rotate.c"

!IF  "$(CFG)" == "MWEdit - Win32 Release"

CPP_SWITCHES=/nologo /MD /W3 /GX /O2 /I "d:\vcsource\esp\morrow\mwedit" /I "d:\vcsource\devil\src-il\include" /I "d:\vcsource\devil\src-ilu\include" /I "d:\vcsource\devil\src-ilut\include" /D "NDEBUG" /D "WIN32" /D "_WINDOWS" /D "_AFXDLL" /D "_MBCS" /D "NODEVILLIB" /FR"$(INTDIR)\\" /Fo"$(INTDIR)\\" /Fd"$(INTDIR)\\" /FD /c 

"$(INTDIR)\ilu_rotate.obj"	"$(INTDIR)\ilu_rotate.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) @<<
  $(CPP_SWITCHES) $(SOURCE)
<<


!ELSEIF  "$(CFG)" == "MWEdit - Win32 Debug"

CPP_SWITCHES=/nologo /MDd /W3 /Gm /GX /ZI /Od /I "d:\vcsource\esp\morrow\mwedit" /I "d:\vcsource\devil\src-il\include" /I "d:\vcsource\devil\src-ilu\include" /I "d:\vcsource\devil\src-ilut\include" /D "_DEBUG" /D "WIN32" /D "_WINDOWS" /D "_AFXDLL" /D "_MBCS" /D "NODEVILLIB" /FR"$(INTDIR)\\" /Fo"$(INTDIR)\\" /Fd"$(INTDIR)\\" /FD /GZ /c 

"$(INTDIR)\ilu_rotate.obj"	"$(INTDIR)\ilu_rotate.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) @<<
  $(CPP_SWITCHES) $(SOURCE)
<<


!ENDIF 

SOURCE="..\..\..\DevIL\src-ILU\src\ilu_scale.c"

!IF  "$(CFG)" == "MWEdit - Win32 Release"

CPP_SWITCHES=/nologo /MD /W3 /GX /O2 /I "d:\vcsource\esp\morrow\mwedit" /I "d:\vcsource\devil\src-il\include" /I "d:\vcsource\devil\src-ilu\include" /I "d:\vcsource\devil\src-ilut\include" /D "NDEBUG" /D "WIN32" /D "_WINDOWS" /D "_AFXDLL" /D "_MBCS" /D "NODEVILLIB" /FR"$(INTDIR)\\" /Fo"$(INTDIR)\\" /Fd"$(INTDIR)\\" /FD /c 

"$(INTDIR)\ilu_scale.obj"	"$(INTDIR)\ilu_scale.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) @<<
  $(CPP_SWITCHES) $(SOURCE)
<<


!ELSEIF  "$(CFG)" == "MWEdit - Win32 Debug"

CPP_SWITCHES=/nologo /MDd /W3 /Gm /GX /ZI /Od /I "d:\vcsource\esp\morrow\mwedit" /I "d:\vcsource\devil\src-il\include" /I "d:\vcsource\devil\src-ilu\include" /I "d:\vcsource\devil\src-ilut\include" /D "_DEBUG" /D "WIN32" /D "_WINDOWS" /D "_AFXDLL" /D "_MBCS" /D "NODEVILLIB" /FR"$(INTDIR)\\" /Fo"$(INTDIR)\\" /Fd"$(INTDIR)\\" /FD /GZ /c 

"$(INTDIR)\ilu_scale.obj"	"$(INTDIR)\ilu_scale.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) @<<
  $(CPP_SWITCHES) $(SOURCE)
<<


!ENDIF 

SOURCE="..\..\..\DevIL\src-ILU\src\ilu_scale2d.c"

!IF  "$(CFG)" == "MWEdit - Win32 Release"

CPP_SWITCHES=/nologo /MD /W3 /GX /O2 /I "d:\vcsource\esp\morrow\mwedit" /I "d:\vcsource\devil\src-il\include" /I "d:\vcsource\devil\src-ilu\include" /I "d:\vcsource\devil\src-ilut\include" /D "NDEBUG" /D "WIN32" /D "_WINDOWS" /D "_AFXDLL" /D "_MBCS" /D "NODEVILLIB" /FR"$(INTDIR)\\" /Fo"$(INTDIR)\\" /Fd"$(INTDIR)\\" /FD /c 

"$(INTDIR)\ilu_scale2d.obj"	"$(INTDIR)\ilu_scale2d.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) @<<
  $(CPP_SWITCHES) $(SOURCE)
<<


!ELSEIF  "$(CFG)" == "MWEdit - Win32 Debug"

CPP_SWITCHES=/nologo /MDd /W3 /Gm /GX /ZI /Od /I "d:\vcsource\esp\morrow\mwedit" /I "d:\vcsource\devil\src-il\include" /I "d:\vcsource\devil\src-ilu\include" /I "d:\vcsource\devil\src-ilut\include" /D "_DEBUG" /D "WIN32" /D "_WINDOWS" /D "_AFXDLL" /D "_MBCS" /D "NODEVILLIB" /FR"$(INTDIR)\\" /Fo"$(INTDIR)\\" /Fd"$(INTDIR)\\" /FD /GZ /c 

"$(INTDIR)\ilu_scale2d.obj"	"$(INTDIR)\ilu_scale2d.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) @<<
  $(CPP_SWITCHES) $(SOURCE)
<<


!ENDIF 

SOURCE="..\..\..\DevIL\src-ILU\src\ilu_scale3d.c"

!IF  "$(CFG)" == "MWEdit - Win32 Release"

CPP_SWITCHES=/nologo /MD /W3 /GX /O2 /I "d:\vcsource\esp\morrow\mwedit" /I "d:\vcsource\devil\src-il\include" /I "d:\vcsource\devil\src-ilu\include" /I "d:\vcsource\devil\src-ilut\include" /D "NDEBUG" /D "WIN32" /D "_WINDOWS" /D "_AFXDLL" /D "_MBCS" /D "NODEVILLIB" /FR"$(INTDIR)\\" /Fo"$(INTDIR)\\" /Fd"$(INTDIR)\\" /FD /c 

"$(INTDIR)\ilu_scale3d.obj"	"$(INTDIR)\ilu_scale3d.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) @<<
  $(CPP_SWITCHES) $(SOURCE)
<<


!ELSEIF  "$(CFG)" == "MWEdit - Win32 Debug"

CPP_SWITCHES=/nologo /MDd /W3 /Gm /GX /ZI /Od /I "d:\vcsource\esp\morrow\mwedit" /I "d:\vcsource\devil\src-il\include" /I "d:\vcsource\devil\src-ilu\include" /I "d:\vcsource\devil\src-ilut\include" /D "_DEBUG" /D "WIN32" /D "_WINDOWS" /D "_AFXDLL" /D "_MBCS" /D "NODEVILLIB" /FR"$(INTDIR)\\" /Fo"$(INTDIR)\\" /Fd"$(INTDIR)\\" /FD /GZ /c 

"$(INTDIR)\ilu_scale3d.obj"	"$(INTDIR)\ilu_scale3d.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) @<<
  $(CPP_SWITCHES) $(SOURCE)
<<


!ENDIF 

SOURCE="..\..\..\DevIL\src-ILU\src\ilu_scaling.c"

!IF  "$(CFG)" == "MWEdit - Win32 Release"

CPP_SWITCHES=/nologo /MD /W3 /GX /O2 /I "d:\vcsource\esp\morrow\mwedit" /I "d:\vcsource\devil\src-il\include" /I "d:\vcsource\devil\src-ilu\include" /I "d:\vcsource\devil\src-ilut\include" /D "NDEBUG" /D "WIN32" /D "_WINDOWS" /D "_AFXDLL" /D "_MBCS" /D "NODEVILLIB" /FR"$(INTDIR)\\" /Fo"$(INTDIR)\\" /Fd"$(INTDIR)\\" /FD /c 

"$(INTDIR)\ilu_scaling.obj"	"$(INTDIR)\ilu_scaling.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) @<<
  $(CPP_SWITCHES) $(SOURCE)
<<


!ELSEIF  "$(CFG)" == "MWEdit - Win32 Debug"

CPP_SWITCHES=/nologo /MDd /W3 /Gm /GX /ZI /Od /I "d:\vcsource\esp\morrow\mwedit" /I "d:\vcsource\devil\src-il\include" /I "d:\vcsource\devil\src-ilu\include" /I "d:\vcsource\devil\src-ilut\include" /D "_DEBUG" /D "WIN32" /D "_WINDOWS" /D "_AFXDLL" /D "_MBCS" /D "NODEVILLIB" /FR"$(INTDIR)\\" /Fo"$(INTDIR)\\" /Fd"$(INTDIR)\\" /FD /GZ /c 

"$(INTDIR)\ilu_scaling.obj"	"$(INTDIR)\ilu_scaling.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) @<<
  $(CPP_SWITCHES) $(SOURCE)
<<


!ENDIF 

SOURCE="..\..\..\DevIL\src-ILU\src\ilu_states.c"

!IF  "$(CFG)" == "MWEdit - Win32 Release"

CPP_SWITCHES=/nologo /MD /W3 /GX /O2 /I "d:\vcsource\esp\morrow\mwedit" /I "d:\vcsource\devil\src-il\include" /I "d:\vcsource\devil\src-ilu\include" /I "d:\vcsource\devil\src-ilut\include" /D "NDEBUG" /D "WIN32" /D "_WINDOWS" /D "_AFXDLL" /D "_MBCS" /D "NODEVILLIB" /FR"$(INTDIR)\\" /Fo"$(INTDIR)\\" /Fd"$(INTDIR)\\" /FD /c 

"$(INTDIR)\ilu_states.obj"	"$(INTDIR)\ilu_states.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) @<<
  $(CPP_SWITCHES) $(SOURCE)
<<


!ELSEIF  "$(CFG)" == "MWEdit - Win32 Debug"

CPP_SWITCHES=/nologo /MDd /W3 /Gm /GX /ZI /Od /I "d:\vcsource\esp\morrow\mwedit" /I "d:\vcsource\devil\src-il\include" /I "d:\vcsource\devil\src-ilu\include" /I "d:\vcsource\devil\src-ilut\include" /D "_DEBUG" /D "WIN32" /D "_WINDOWS" /D "_AFXDLL" /D "_MBCS" /D "NODEVILLIB" /FR"$(INTDIR)\\" /Fo"$(INTDIR)\\" /Fd"$(INTDIR)\\" /FD /GZ /c 

"$(INTDIR)\ilu_states.obj"	"$(INTDIR)\ilu_states.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) @<<
  $(CPP_SWITCHES) $(SOURCE)
<<


!ENDIF 

SOURCE="..\..\..\DevIL\src-ILU\src\ilu_utilities.c"

!IF  "$(CFG)" == "MWEdit - Win32 Release"

CPP_SWITCHES=/nologo /MD /W3 /GX /O2 /I "d:\vcsource\esp\morrow\mwedit" /I "d:\vcsource\devil\src-il\include" /I "d:\vcsource\devil\src-ilu\include" /I "d:\vcsource\devil\src-ilut\include" /D "NDEBUG" /D "WIN32" /D "_WINDOWS" /D "_AFXDLL" /D "_MBCS" /D "NODEVILLIB" /FR"$(INTDIR)\\" /Fo"$(INTDIR)\\" /Fd"$(INTDIR)\\" /FD /c 

"$(INTDIR)\ilu_utilities.obj"	"$(INTDIR)\ilu_utilities.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) @<<
  $(CPP_SWITCHES) $(SOURCE)
<<


!ELSEIF  "$(CFG)" == "MWEdit - Win32 Debug"

CPP_SWITCHES=/nologo /MDd /W3 /Gm /GX /ZI /Od /I "d:\vcsource\esp\morrow\mwedit" /I "d:\vcsource\devil\src-il\include" /I "d:\vcsource\devil\src-ilu\include" /I "d:\vcsource\devil\src-ilut\include" /D "_DEBUG" /D "WIN32" /D "_WINDOWS" /D "_AFXDLL" /D "_MBCS" /D "NODEVILLIB" /FR"$(INTDIR)\\" /Fo"$(INTDIR)\\" /Fd"$(INTDIR)\\" /FD /GZ /c 

"$(INTDIR)\ilu_utilities.obj"	"$(INTDIR)\ilu_utilities.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) @<<
  $(CPP_SWITCHES) $(SOURCE)
<<


!ENDIF 

SOURCE="..\..\..\DevIL\src-ILUT\src\ilut_allegro.c"

!IF  "$(CFG)" == "MWEdit - Win32 Release"

CPP_SWITCHES=/nologo /MD /W3 /GX /O2 /I "d:\vcsource\esp\morrow\mwedit" /I "d:\vcsource\devil\src-il\include" /I "d:\vcsource\devil\src-ilu\include" /I "d:\vcsource\devil\src-ilut\include" /D "NDEBUG" /D "WIN32" /D "_WINDOWS" /D "_AFXDLL" /D "_MBCS" /D "NODEVILLIB" /FR"$(INTDIR)\\" /Fo"$(INTDIR)\\" /Fd"$(INTDIR)\\" /FD /c 

"$(INTDIR)\ilut_allegro.obj"	"$(INTDIR)\ilut_allegro.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) @<<
  $(CPP_SWITCHES) $(SOURCE)
<<


!ELSEIF  "$(CFG)" == "MWEdit - Win32 Debug"

CPP_SWITCHES=/nologo /MDd /W3 /Gm /GX /ZI /Od /I "d:\vcsource\esp\morrow\mwedit" /I "d:\vcsource\devil\src-il\include" /I "d:\vcsource\devil\src-ilu\include" /I "d:\vcsource\devil\src-ilut\include" /D "_DEBUG" /D "WIN32" /D "_WINDOWS" /D "_AFXDLL" /D "_MBCS" /D "NODEVILLIB" /FR"$(INTDIR)\\" /Fo"$(INTDIR)\\" /Fd"$(INTDIR)\\" /FD /GZ /c 

"$(INTDIR)\ilut_allegro.obj"	"$(INTDIR)\ilut_allegro.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) @<<
  $(CPP_SWITCHES) $(SOURCE)
<<


!ENDIF 

SOURCE="..\..\..\DevIL\src-ILUT\src\ilut_directx.c"

!IF  "$(CFG)" == "MWEdit - Win32 Release"

CPP_SWITCHES=/nologo /MD /W3 /GX /O2 /I "d:\vcsource\esp\morrow\mwedit" /I "d:\vcsource\devil\src-il\include" /I "d:\vcsource\devil\src-ilu\include" /I "d:\vcsource\devil\src-ilut\include" /D "NDEBUG" /D "WIN32" /D "_WINDOWS" /D "_AFXDLL" /D "_MBCS" /D "NODEVILLIB" /FR"$(INTDIR)\\" /Fo"$(INTDIR)\\" /Fd"$(INTDIR)\\" /FD /c 

"$(INTDIR)\ilut_directx.obj"	"$(INTDIR)\ilut_directx.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) @<<
  $(CPP_SWITCHES) $(SOURCE)
<<


!ELSEIF  "$(CFG)" == "MWEdit - Win32 Debug"

CPP_SWITCHES=/nologo /MDd /W3 /Gm /GX /ZI /Od /I "d:\vcsource\esp\morrow\mwedit" /I "d:\vcsource\devil\src-il\include" /I "d:\vcsource\devil\src-ilu\include" /I "d:\vcsource\devil\src-ilut\include" /D "_DEBUG" /D "WIN32" /D "_WINDOWS" /D "_AFXDLL" /D "_MBCS" /D "NODEVILLIB" /FR"$(INTDIR)\\" /Fo"$(INTDIR)\\" /Fd"$(INTDIR)\\" /FD /GZ /c 

"$(INTDIR)\ilut_directx.obj"	"$(INTDIR)\ilut_directx.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) @<<
  $(CPP_SWITCHES) $(SOURCE)
<<


!ENDIF 

SOURCE="..\..\..\DevIL\src-ILUT\src\ilut_internal.c"

!IF  "$(CFG)" == "MWEdit - Win32 Release"

CPP_SWITCHES=/nologo /MD /W3 /GX /O2 /I "d:\vcsource\esp\morrow\mwedit" /I "d:\vcsource\devil\src-il\include" /I "d:\vcsource\devil\src-ilu\include" /I "d:\vcsource\devil\src-ilut\include" /D "NDEBUG" /D "WIN32" /D "_WINDOWS" /D "_AFXDLL" /D "_MBCS" /D "NODEVILLIB" /FR"$(INTDIR)\\" /Fo"$(INTDIR)\\" /Fd"$(INTDIR)\\" /FD /c 

"$(INTDIR)\ilut_internal.obj"	"$(INTDIR)\ilut_internal.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) @<<
  $(CPP_SWITCHES) $(SOURCE)
<<


!ELSEIF  "$(CFG)" == "MWEdit - Win32 Debug"

CPP_SWITCHES=/nologo /MDd /W3 /Gm /GX /ZI /Od /I "d:\vcsource\esp\morrow\mwedit" /I "d:\vcsource\devil\src-il\include" /I "d:\vcsource\devil\src-ilu\include" /I "d:\vcsource\devil\src-ilut\include" /D "_DEBUG" /D "WIN32" /D "_WINDOWS" /D "_AFXDLL" /D "_MBCS" /D "NODEVILLIB" /FR"$(INTDIR)\\" /Fo"$(INTDIR)\\" /Fd"$(INTDIR)\\" /FD /GZ /c 

"$(INTDIR)\ilut_internal.obj"	"$(INTDIR)\ilut_internal.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) @<<
  $(CPP_SWITCHES) $(SOURCE)
<<


!ENDIF 

SOURCE="..\..\..\DevIL\src-ILUT\src\ilut_main.c"

!IF  "$(CFG)" == "MWEdit - Win32 Release"

CPP_SWITCHES=/nologo /MD /W3 /GX /O2 /I "d:\vcsource\esp\morrow\mwedit" /I "d:\vcsource\devil\src-il\include" /I "d:\vcsource\devil\src-ilu\include" /I "d:\vcsource\devil\src-ilut\include" /D "NDEBUG" /D "WIN32" /D "_WINDOWS" /D "_AFXDLL" /D "_MBCS" /D "NODEVILLIB" /FR"$(INTDIR)\\" /Fo"$(INTDIR)\\" /Fd"$(INTDIR)\\" /FD /c 

"$(INTDIR)\ilut_main.obj"	"$(INTDIR)\ilut_main.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) @<<
  $(CPP_SWITCHES) $(SOURCE)
<<


!ELSEIF  "$(CFG)" == "MWEdit - Win32 Debug"

CPP_SWITCHES=/nologo /MDd /W3 /Gm /GX /ZI /Od /I "d:\vcsource\esp\morrow\mwedit" /I "d:\vcsource\devil\src-il\include" /I "d:\vcsource\devil\src-ilu\include" /I "d:\vcsource\devil\src-ilut\include" /D "_DEBUG" /D "WIN32" /D "_WINDOWS" /D "_AFXDLL" /D "_MBCS" /D "NODEVILLIB" /FR"$(INTDIR)\\" /Fo"$(INTDIR)\\" /Fd"$(INTDIR)\\" /FD /GZ /c 

"$(INTDIR)\ilut_main.obj"	"$(INTDIR)\ilut_main.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) @<<
  $(CPP_SWITCHES) $(SOURCE)
<<


!ENDIF 

SOURCE="..\..\..\DevIL\src-ILUT\src\ilut_opengl.c"

!IF  "$(CFG)" == "MWEdit - Win32 Release"

CPP_SWITCHES=/nologo /MD /W3 /GX /O2 /I "d:\vcsource\esp\morrow\mwedit" /I "d:\vcsource\devil\src-il\include" /I "d:\vcsource\devil\src-ilu\include" /I "d:\vcsource\devil\src-ilut\include" /D "NDEBUG" /D "WIN32" /D "_WINDOWS" /D "_AFXDLL" /D "_MBCS" /D "NODEVILLIB" /FR"$(INTDIR)\\" /Fo"$(INTDIR)\\" /Fd"$(INTDIR)\\" /FD /c 

"$(INTDIR)\ilut_opengl.obj"	"$(INTDIR)\ilut_opengl.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) @<<
  $(CPP_SWITCHES) $(SOURCE)
<<


!ELSEIF  "$(CFG)" == "MWEdit - Win32 Debug"

CPP_SWITCHES=/nologo /MDd /W3 /Gm /GX /ZI /Od /I "d:\vcsource\esp\morrow\mwedit" /I "d:\vcsource\devil\src-il\include" /I "d:\vcsource\devil\src-ilu\include" /I "d:\vcsource\devil\src-ilut\include" /D "_DEBUG" /D "WIN32" /D "_WINDOWS" /D "_AFXDLL" /D "_MBCS" /D "NODEVILLIB" /FR"$(INTDIR)\\" /Fo"$(INTDIR)\\" /Fd"$(INTDIR)\\" /FD /GZ /c 

"$(INTDIR)\ilut_opengl.obj"	"$(INTDIR)\ilut_opengl.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) @<<
  $(CPP_SWITCHES) $(SOURCE)
<<


!ENDIF 

SOURCE="..\..\..\DevIL\src-ILUT\src\ilut_sdlsurface.c"

!IF  "$(CFG)" == "MWEdit - Win32 Release"

CPP_SWITCHES=/nologo /MD /W3 /GX /O2 /I "d:\vcsource\esp\morrow\mwedit" /I "d:\vcsource\devil\src-il\include" /I "d:\vcsource\devil\src-ilu\include" /I "d:\vcsource\devil\src-ilut\include" /D "NDEBUG" /D "WIN32" /D "_WINDOWS" /D "_AFXDLL" /D "_MBCS" /D "NODEVILLIB" /FR"$(INTDIR)\\" /Fo"$(INTDIR)\\" /Fd"$(INTDIR)\\" /FD /c 

"$(INTDIR)\ilut_sdlsurface.obj"	"$(INTDIR)\ilut_sdlsurface.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) @<<
  $(CPP_SWITCHES) $(SOURCE)
<<


!ELSEIF  "$(CFG)" == "MWEdit - Win32 Debug"

CPP_SWITCHES=/nologo /MDd /W3 /Gm /GX /ZI /Od /I "d:\vcsource\esp\morrow\mwedit" /I "d:\vcsource\devil\src-il\include" /I "d:\vcsource\devil\src-ilu\include" /I "d:\vcsource\devil\src-ilut\include" /D "_DEBUG" /D "WIN32" /D "_WINDOWS" /D "_AFXDLL" /D "_MBCS" /D "NODEVILLIB" /FR"$(INTDIR)\\" /Fo"$(INTDIR)\\" /Fd"$(INTDIR)\\" /FD /GZ /c 

"$(INTDIR)\ilut_sdlsurface.obj"	"$(INTDIR)\ilut_sdlsurface.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) @<<
  $(CPP_SWITCHES) $(SOURCE)
<<


!ENDIF 

SOURCE="..\..\..\DevIL\src-ILUT\src\ilut_states.c"

!IF  "$(CFG)" == "MWEdit - Win32 Release"

CPP_SWITCHES=/nologo /MD /W3 /GX /O2 /I "d:\vcsource\esp\morrow\mwedit" /I "d:\vcsource\devil\src-il\include" /I "d:\vcsource\devil\src-ilu\include" /I "d:\vcsource\devil\src-ilut\include" /D "NDEBUG" /D "WIN32" /D "_WINDOWS" /D "_AFXDLL" /D "_MBCS" /D "NODEVILLIB" /FR"$(INTDIR)\\" /Fo"$(INTDIR)\\" /Fd"$(INTDIR)\\" /FD /c 

"$(INTDIR)\ilut_states.obj"	"$(INTDIR)\ilut_states.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) @<<
  $(CPP_SWITCHES) $(SOURCE)
<<


!ELSEIF  "$(CFG)" == "MWEdit - Win32 Debug"

CPP_SWITCHES=/nologo /MDd /W3 /Gm /GX /ZI /Od /I "d:\vcsource\esp\morrow\mwedit" /I "d:\vcsource\devil\src-il\include" /I "d:\vcsource\devil\src-ilu\include" /I "d:\vcsource\devil\src-ilut\include" /D "_DEBUG" /D "WIN32" /D "_WINDOWS" /D "_AFXDLL" /D "_MBCS" /D "NODEVILLIB" /FR"$(INTDIR)\\" /Fo"$(INTDIR)\\" /Fd"$(INTDIR)\\" /FD /GZ /c 

"$(INTDIR)\ilut_states.obj"	"$(INTDIR)\ilut_states.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) @<<
  $(CPP_SWITCHES) $(SOURCE)
<<


!ENDIF 

SOURCE="..\..\..\DevIL\src-ILUT\src\ilut_win32.c"

!IF  "$(CFG)" == "MWEdit - Win32 Release"

CPP_SWITCHES=/nologo /MD /W3 /GX /O2 /I "d:\vcsource\esp\morrow\mwedit" /I "d:\vcsource\devil\src-il\include" /I "d:\vcsource\devil\src-ilu\include" /I "d:\vcsource\devil\src-ilut\include" /D "NDEBUG" /D "WIN32" /D "_WINDOWS" /D "_AFXDLL" /D "_MBCS" /D "NODEVILLIB" /FR"$(INTDIR)\\" /Fo"$(INTDIR)\\" /Fd"$(INTDIR)\\" /FD /c 

"$(INTDIR)\ilut_win32.obj"	"$(INTDIR)\ilut_win32.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) @<<
  $(CPP_SWITCHES) $(SOURCE)
<<


!ELSEIF  "$(CFG)" == "MWEdit - Win32 Debug"

CPP_SWITCHES=/nologo /MDd /W3 /Gm /GX /ZI /Od /I "d:\vcsource\esp\morrow\mwedit" /I "d:\vcsource\devil\src-il\include" /I "d:\vcsource\devil\src-ilu\include" /I "d:\vcsource\devil\src-ilut\include" /D "_DEBUG" /D "WIN32" /D "_WINDOWS" /D "_AFXDLL" /D "_MBCS" /D "NODEVILLIB" /FR"$(INTDIR)\\" /Fo"$(INTDIR)\\" /Fd"$(INTDIR)\\" /FD /GZ /c 

"$(INTDIR)\ilut_win32.obj"	"$(INTDIR)\ilut_win32.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) @<<
  $(CPP_SWITCHES) $(SOURCE)
<<


!ENDIF 

SOURCE=.\MWEdit.cpp

"$(INTDIR)\MWEdit.obj"	"$(INTDIR)\MWEdit.sbr" : $(SOURCE) "$(INTDIR)" "$(INTDIR)\MWEdit.pch"


SOURCE=.\MWEditDoc.cpp

"$(INTDIR)\MWEditDoc.obj"	"$(INTDIR)\MWEditDoc.sbr" : $(SOURCE) "$(INTDIR)" "$(INTDIR)\MWEdit.pch"


SOURCE=.\Resource.h

!IF  "$(CFG)" == "MWEdit - Win32 Release"

TargetName=MWEdit
InputPath=.\Resource.h

".\hlp\MWEdit.hm" : $(SOURCE) "$(INTDIR)" "$(OUTDIR)"
	<<tempfile.bat 
	@echo off 
	echo. >"hlp\$(TargetName).hm" 
	echo // Commands (ID_* and IDM_*) >>"hlp\$(TargetName).hm" 
	makehm ID_,HID_,0x10000 IDM_,HIDM_,0x10000 resource.h >>"hlp\$(TargetName).hm" 
	echo. >>"hlp\$(TargetName).hm" 
	echo // Prompts (IDP_*) >>"hlp\$(TargetName).hm" 
	makehm IDP_,HIDP_,0x30000 resource.h >>"hlp\$(TargetName).hm" 
	echo. >>"hlp\$(TargetName).hm" 
	echo // Resources (IDR_*) >>"hlp\$(TargetName).hm" 
	makehm IDR_,HIDR_,0x20000 resource.h >>"hlp\$(TargetName).hm" 
	echo. >>"hlp\$(TargetName).hm" 
	echo // Dialogs (IDD_*) >>"hlp\$(TargetName).hm" 
	makehm IDD_,HIDD_,0x20000 resource.h >>"hlp\$(TargetName).hm" 
	echo. >>"hlp\$(TargetName).hm" 
	echo // Frame Controls (IDW_*) >>"hlp\$(TargetName).hm" 
	makehm IDW_,HIDW_,0x50000 resource.h >>"hlp\$(TargetName).hm" 
<< 
	

!ELSEIF  "$(CFG)" == "MWEdit - Win32 Debug"

TargetName=MWEdit
InputPath=.\Resource.h

".\hlp\MWEdit.hm" : $(SOURCE) "$(INTDIR)" "$(OUTDIR)"
	<<tempfile.bat 
	@echo off 
	echo. >"hlp\$(TargetName).hm" 
	echo // Commands (ID_* and IDM_*) >>"hlp\$(TargetName).hm" 
	makehm ID_,HID_,0x10000 IDM_,HIDM_,0x10000 resource.h >>"hlp\$(TargetName).hm" 
	echo. >>"hlp\$(TargetName).hm" 
	echo // Prompts (IDP_*) >>"hlp\$(TargetName).hm" 
	makehm IDP_,HIDP_,0x30000 resource.h >>"hlp\$(TargetName).hm" 
	echo. >>"hlp\$(TargetName).hm" 
	echo // Resources (IDR_*) >>"hlp\$(TargetName).hm" 
	makehm IDR_,HIDR_,0x20000 resource.h >>"hlp\$(TargetName).hm" 
	echo. >>"hlp\$(TargetName).hm" 
	echo // Dialogs (IDD_*) >>"hlp\$(TargetName).hm" 
	makehm IDD_,HIDD_,0x20000 resource.h >>"hlp\$(TargetName).hm" 
	echo. >>"hlp\$(TargetName).hm" 
	echo // Frame Controls (IDW_*) >>"hlp\$(TargetName).hm" 
	makehm IDW_,HIDW_,0x50000 resource.h >>"hlp\$(TargetName).hm" 
<< 
	

!ENDIF 

SOURCE=.\hlp\MWEdit.cnt

!IF  "$(CFG)" == "MWEdit - Win32 Release"

OutDir=.\Release
InputPath=.\hlp\MWEdit.cnt
InputName=MWEdit

"$(INTDIR)\MWEdit.cnt" : $(SOURCE) "$(INTDIR)" "$(OUTDIR)"
	<<tempfile.bat 
	@echo off 
	copy "hlp\$(InputName).cnt" $(OutDir)
<< 
	

!ELSEIF  "$(CFG)" == "MWEdit - Win32 Debug"

OutDir=.\Debug
InputPath=.\hlp\MWEdit.cnt
InputName=MWEdit

"$(INTDIR)\MWEdit.cnt" : $(SOURCE) "$(INTDIR)" "$(OUTDIR)"
	<<tempfile.bat 
	@echo off 
	copy "hlp\$(InputName).cnt" $(OutDir)
<< 
	

!ENDIF 


!ENDIF 


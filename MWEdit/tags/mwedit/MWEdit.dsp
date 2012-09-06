# Microsoft Developer Studio Project File - Name="MWEdit" - Package Owner=<4>
# Microsoft Developer Studio Generated Build File, Format Version 6.00
# ** DO NOT EDIT **

# TARGTYPE "Win32 (x86) Application" 0x0101

CFG=MWEdit - Win32 Debug
!MESSAGE This is not a valid makefile. To build this project using NMAKE,
!MESSAGE use the Export Makefile command and run
!MESSAGE 
!MESSAGE NMAKE /f "MWEdit.mak".
!MESSAGE 
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

# Begin Project
# PROP AllowPerConfigDependencies 0
# PROP Scc_ProjName ""
# PROP Scc_LocalPath ""
CPP=cl.exe
MTL=midl.exe
RSC=rc.exe

!IF  "$(CFG)" == "MWEdit - Win32 Release"

# PROP BASE Use_MFC 2
# PROP BASE Use_Debug_Libraries 0
# PROP BASE Output_Dir "Release"
# PROP BASE Intermediate_Dir "Release"
# PROP BASE Target_Dir ""
# PROP Use_MFC 2
# PROP Use_Debug_Libraries 0
# PROP Output_Dir "Release"
# PROP Intermediate_Dir "Release"
# PROP Target_Dir ""
# ADD BASE CPP /nologo /MD /W3 /GX /O2 /D "WIN32" /D "NDEBUG" /D "_WINDOWS" /D "_AFXDLL" /Yu"stdafx.h" /FD /c
# ADD CPP /nologo /MD /W3 /GX /O2 /I "d:\source\common\\" /I "d:\source\uesp\morrow\esm" /I ".\\" /I "d:\source\uesp\morrow" /I "d:\source" /I "D:\VCSource\DevIL\include" /D "NDEBUG" /D "WIN32" /D "_WINDOWS" /D "_AFXDLL" /D "_MBCS" /D "NODEVILLIB" /FR /Yu"stdafx.h" /FD /c
# ADD BASE MTL /nologo /D "NDEBUG" /mktyplib203 /win32
# ADD MTL /nologo /D "NDEBUG" /mktyplib203 /win32
# ADD BASE RSC /l 0x1009 /d "NDEBUG" /d "_AFXDLL"
# ADD RSC /l 0x1009 /d "NDEBUG" /d "_AFXDLL"
BSC32=bscmake.exe
# ADD BASE BSC32 /nologo
# ADD BSC32 /nologo
LINK32=link.exe
# ADD BASE LINK32 /nologo /subsystem:windows /machine:I386
# ADD LINK32 /nologo /subsystem:windows /machine:I386

!ELSEIF  "$(CFG)" == "MWEdit - Win32 Debug"

# PROP BASE Use_MFC 2
# PROP BASE Use_Debug_Libraries 1
# PROP BASE Output_Dir "Debug"
# PROP BASE Intermediate_Dir "Debug"
# PROP BASE Target_Dir ""
# PROP Use_MFC 2
# PROP Use_Debug_Libraries 1
# PROP Output_Dir "Debug"
# PROP Intermediate_Dir "Debug"
# PROP Target_Dir ""
# ADD BASE CPP /nologo /MDd /W3 /Gm /GX /ZI /Od /D "WIN32" /D "_DEBUG" /D "_WINDOWS" /D "_AFXDLL" /Yu"stdafx.h" /FD /GZ /c
# ADD CPP /nologo /MDd /W3 /Gm /GX /ZI /Od /I "d:\source\common\\" /I "d:\source\uesp\morrow\esm" /I ".\\" /I "d:\source\uesp\morrow" /I "d:\source" /I "D:\VCSource\DevIL\include" /D "_DEBUG" /D "WIN32" /D "_WINDOWS" /D "_AFXDLL" /D "_MBCS" /D "NODEVILLIB" /FR /Yu"stdafx.h" /FD /GZ /c
# ADD BASE MTL /nologo /D "_DEBUG" /mktyplib203 /win32
# ADD MTL /nologo /D "_DEBUG" /mktyplib203 /win32
# ADD BASE RSC /l 0x1009 /d "_DEBUG" /d "_AFXDLL"
# ADD RSC /l 0x1009 /d "_DEBUG" /d "_AFXDLL"
BSC32=bscmake.exe
# ADD BASE BSC32 /nologo
# ADD BSC32 /nologo
LINK32=link.exe
# ADD BASE LINK32 /nologo /subsystem:windows /debug /machine:I386 /pdbtype:sept
# ADD LINK32 /nologo /subsystem:windows /debug /machine:I386 /pdbtype:sept

!ENDIF 

# Begin Target

# Name "MWEdit - Win32 Release"
# Name "MWEdit - Win32 Debug"
# Begin Group "Source Files"

# PROP Default_Filter "cpp;c;cxx;rc;def;r;odl;idl;hpj;bat"
# Begin Group "Forms"

# PROP Default_Filter ""
# Begin Group "Record"

# PROP Default_Filter ""
# Begin Source File

SOURCE=.\ActivatorDlg.cpp
# End Source File
# Begin Source File

SOURCE=.\EsmAiActivateDlg.cpp
# End Source File
# Begin Source File

SOURCE=.\EsmAiEscortDlg.cpp
# End Source File
# Begin Source File

SOURCE=.\EsmAiTravelDlg.cpp
# End Source File
# Begin Source File

SOURCE=.\EsmAiWanderDlg.cpp
# End Source File
# Begin Source File

SOURCE=.\EsmAlchemyDlg.cpp
# End Source File
# Begin Source File

SOURCE=.\EsmApparatusDlg.cpp
# End Source File
# Begin Source File

SOURCE=.\EsmArmorDlg.cpp
# End Source File
# Begin Source File

SOURCE=.\EsmBirthSignDlg.cpp
# End Source File
# Begin Source File

SOURCE=.\EsmBodyPartDlg.cpp
# End Source File
# Begin Source File

SOURCE=.\EsmBookDlg.cpp
# End Source File
# Begin Source File

SOURCE=.\EsmClassDlg.cpp
# End Source File
# Begin Source File

SOURCE=.\EsmClothingDlg.cpp
# End Source File
# Begin Source File

SOURCE=.\EsmContainDlg.cpp
# End Source File
# Begin Source File

SOURCE=.\EsmDialogDlg.cpp
# End Source File
# Begin Source File

SOURCE=.\EsmDoorDlg.cpp
# End Source File
# Begin Source File

SOURCE=.\EsmEffectDlg.cpp
# End Source File
# Begin Source File

SOURCE=.\EsmEnchantDlg.cpp
# End Source File
# Begin Source File

SOURCE=.\EsmFactionDlg.cpp
# End Source File
# Begin Source File

SOURCE=.\EsmGlobalDlg.cpp
# End Source File
# Begin Source File

SOURCE=.\EsmInfoDlg.cpp
# End Source File
# Begin Source File

SOURCE=.\EsmIngrediantDlg.cpp
# End Source File
# Begin Source File

SOURCE=.\EsmJournalDlg.cpp
# End Source File
# Begin Source File

SOURCE=.\EsmLevelCreaDlg.cpp
# End Source File
# Begin Source File

SOURCE=.\EsmLevelItemDlg.cpp
# End Source File
# Begin Source File

SOURCE=.\EsmLightDlg.cpp
# End Source File
# Begin Source File

SOURCE=.\EsmLockPickDlg.cpp
# End Source File
# Begin Source File

SOURCE=.\EsmMiscDlg.cpp
# End Source File
# Begin Source File

SOURCE=.\EsmProbeDlg.cpp
# End Source File
# Begin Source File

SOURCE=.\EsmRaceDlg.cpp
# End Source File
# Begin Source File

SOURCE=.\EsmRegionDlg.cpp
# End Source File
# Begin Source File

SOURCE=.\EsmRepairDlg.cpp
# End Source File
# Begin Source File

SOURCE=.\EsmSettingDlg.cpp
# End Source File
# Begin Source File

SOURCE=.\EsmSkillDlg.cpp
# End Source File
# Begin Source File

SOURCE=.\EsmSoundDlg.cpp
# End Source File
# Begin Source File

SOURCE=.\EsmSoundGenDlg.cpp
# End Source File
# Begin Source File

SOURCE=.\EsmSpellDlg.cpp
# End Source File
# Begin Source File

SOURCE=.\EsmStartScriptDlg.cpp
# End Source File
# Begin Source File

SOURCE=.\EsmStaticDlg.cpp
# End Source File
# Begin Source File

SOURCE=.\EsmWeaponDlg.cpp
# End Source File
# End Group
# Begin Group "Creature"

# PROP Default_Filter ""
# Begin Source File

SOURCE=.\CreaturePage1.cpp
# End Source File
# Begin Source File

SOURCE=.\CreaturePage2.cpp
# End Source File
# Begin Source File

SOURCE=.\EsmCreatureDlg.cpp
# End Source File
# Begin Source File

SOURCE=.\EsmCreaturePage1.cpp
# End Source File
# Begin Source File

SOURCE=.\EsmCreaturePage2.cpp
# End Source File
# Begin Source File

SOURCE=.\EsmCreaturePage3.cpp
# End Source File
# Begin Source File

SOURCE=.\EsmCreaturePage4.cpp
# End Source File
# Begin Source File

SOURCE=.\EsmCreaturePage5.cpp
# End Source File
# End Group
# Begin Group "Cell"

# PROP Default_Filter ""
# Begin Source File

SOURCE=.\EsmCellDlg.cpp
# End Source File
# Begin Source File

SOURCE=.\EsmCellRefDlg.cpp
# End Source File
# Begin Source File

SOURCE=.\EsmExtCellPage.cpp
# End Source File
# Begin Source File

SOURCE=.\EsmIntCellPage.cpp
# End Source File
# Begin Source File

SOURCE=.\EsmRefCellPage.cpp
# End Source File
# End Group
# Begin Group "Script"

# PROP Default_Filter ""
# Begin Source File

SOURCE=.\ChildFrmScript.cpp
# End Source File
# Begin Source File

SOURCE=.\EsmFuncHelpView.cpp
# End Source File
# Begin Source File

SOURCE=.\EsmScriptDlg.cpp
# End Source File
# Begin Source File

SOURCE=.\ScriptErrorDlg.cpp
# End Source File
# Begin Source File

SOURCE=.\ScriptErrorView.cpp
# End Source File
# End Group
# Begin Group "NPC"

# PROP Default_Filter ""
# Begin Source File

SOURCE=.\EsmNpcDlg.cpp
# End Source File
# Begin Source File

SOURCE=.\EsmNpcPage1.cpp
# End Source File
# Begin Source File

SOURCE=.\EsmNpcPage2.cpp
# End Source File
# Begin Source File

SOURCE=.\EsmNpcPage3.cpp
# End Source File
# Begin Source File

SOURCE=.\EsmNpcPage4.cpp
# End Source File
# Begin Source File

SOURCE=.\EsmNpcPage5.cpp
# End Source File
# End Group
# Begin Group "Base"

# PROP Default_Filter ""
# Begin Source File

SOURCE=.\EsmDlgArray.cpp
# End Source File
# Begin Source File

SOURCE=.\EsmRecDialog.cpp
# End Source File
# End Group
# Begin Group "Child"

# PROP Default_Filter ""
# Begin Source File

SOURCE=.\ChildFrm.cpp
# End Source File
# Begin Source File

SOURCE=.\ChildFrmFix.cpp
# End Source File
# Begin Source File

SOURCE=.\ChildFrmVar.cpp
# End Source File
# Begin Source File

SOURCE=.\MainFrm.cpp
# End Source File
# End Group
# Begin Group "General"

# PROP Default_Filter ""
# Begin Source File

SOURCE=.\ColorStatic1.cpp
# End Source File
# Begin Source File

SOURCE=.\CustRichEdit.cpp
# End Source File
# Begin Source File

SOURCE=.\editundo.cpp
# End Source File
# Begin Source File

SOURCE=.\EsmIconFrame.cpp
# End Source File
# Begin Source File

SOURCE=.\EsmListCtrl.cpp
# End Source File
# Begin Source File

SOURCE=.\EsmSubListCtrl.cpp
# End Source File
# Begin Source File

SOURCE=.\InputDialog.cpp
# End Source File
# Begin Source File

SOURCE=.\splitterwnd.cpp
# End Source File
# End Group
# Begin Group "ScriptTemplate"

# PROP Default_Filter ""
# Begin Source File

SOURCE=.\EsmScrTempPage1.cpp
# End Source File
# Begin Source File

SOURCE=.\EsmScrTempPage2.cpp
# End Source File
# Begin Source File

SOURCE=.\EsmScrTempPage3.cpp
# End Source File
# Begin Source File

SOURCE=.\EsmScrTempView.cpp
# End Source File
# Begin Source File

SOURCE=.\ScriptTemplate.cpp
# SUBTRACT CPP /YX /Yc /Yu
# End Source File
# End Group
# Begin Source File

SOURCE=.\ErrorDialog.cpp
# End Source File
# Begin Source File

SOURCE=.\EsmCsvImportDlg.cpp
# End Source File
# Begin Source File

SOURCE=.\EsmFindDlg.cpp
# End Source File
# Begin Source File

SOURCE=.\EsmHeaderDlg.cpp
# End Source File
# Begin Source File

SOURCE=.\EsmLoadDlg.cpp
# End Source File
# Begin Source File

SOURCE=.\EsmOptionsDlg.cpp
# End Source File
# Begin Source File

SOURCE=.\EsmScriptCompareDlg.cpp
# End Source File
# Begin Source File

SOURCE=.\EsmUsesDlg.cpp
# End Source File
# Begin Source File

SOURCE=.\MWEditView.cpp
# End Source File
# Begin Source File

SOURCE=.\OpenPluginDlg.cpp
# End Source File
# End Group
# Begin Group "Misc"

# PROP Default_Filter ""
# Begin Source File

SOURCE=.\hlp\MWEdit.hpj

!IF  "$(CFG)" == "MWEdit - Win32 Release"

# PROP Ignore_Default_Tool 1
USERDEP__MWEDI="hlp\AfxCore.rtf"	"hlp\$(TargetName).hm"	
# Begin Custom Build - Making help file...
OutDir=.\Release
TargetName=MWEdit
InputPath=.\hlp\MWEdit.hpj
InputName=MWEdit

"$(OutDir)\$(InputName).hlp" : $(SOURCE) "$(INTDIR)" "$(OUTDIR)"
	start /wait hcw /C /E /M "hlp\$(InputName).hpj" 
	if errorlevel 1 goto :Error 
	if not exist "hlp\$(InputName).hlp" goto :Error 
	copy "hlp\$(InputName).hlp" $(OutDir) 
	goto :done 
	:Error 
	echo hlp\$(InputName).hpj(1) : error: 
	type "hlp\$(InputName).log" 
	:done 
	
# End Custom Build

!ELSEIF  "$(CFG)" == "MWEdit - Win32 Debug"

# PROP Ignore_Default_Tool 1
USERDEP__MWEDI="hlp\AfxCore.rtf"	"hlp\$(TargetName).hm"	
# Begin Custom Build - Making help file...
OutDir=.\Debug
TargetName=MWEdit
InputPath=.\hlp\MWEdit.hpj
InputName=MWEdit

"$(OutDir)\$(InputName).hlp" : $(SOURCE) "$(INTDIR)" "$(OUTDIR)"
	start /wait hcw /C /E /M "hlp\$(InputName).hpj" 
	if errorlevel 1 goto :Error 
	if not exist "hlp\$(InputName).hlp" goto :Error 
	copy "hlp\$(InputName).hlp" $(OutDir) 
	goto :done 
	:Error 
	echo hlp\$(InputName).hpj(1) : error: 
	type "hlp\$(InputName).log" 
	:done 
	
# End Custom Build

!ENDIF 

# End Source File
# Begin Source File

SOURCE=.\MWEdit.rc
# End Source File
# Begin Source File

SOURCE=.\StdAfx.cpp
# ADD CPP /Yc"stdafx.h"
# End Source File
# End Group
# Begin Group "Common"

# PROP Default_Filter ""
# Begin Source File

SOURCE=..\..\..\..\Source\File\csvfile.cpp
# SUBTRACT CPP /YX /Yc /Yu
# End Source File
# Begin Source File

SOURCE=..\..\..\..\Source\Common\dl_base.cpp
# SUBTRACT CPP /YX /Yc /Yu
# End Source File
# Begin Source File

SOURCE=..\..\..\..\Source\Common\dl_block.cpp
# SUBTRACT CPP /YX /Yc /Yu
# End Source File
# Begin Source File

SOURCE=..\..\..\..\Source\Common\dl_chr.cpp
# SUBTRACT CPP /YX /Yc /Yu
# End Source File
# Begin Source File

SOURCE=..\..\..\..\Source\Common\dl_err.cpp
# SUBTRACT CPP /YX /Yc /Yu
# End Source File
# Begin Source File

SOURCE=..\..\..\..\Source\Common\dl_file.cpp
# SUBTRACT CPP /YX /Yc /Yu
# End Source File
# Begin Source File

SOURCE=..\..\..\..\Source\Common\dl_log.cpp
# SUBTRACT CPP /YX /Yc /Yu
# End Source File
# Begin Source File

SOURCE=..\..\..\..\Source\Common\dl_math.cpp
# SUBTRACT CPP /YX /Yc /Yu
# End Source File
# Begin Source File

SOURCE=..\..\..\..\Source\Common\dl_mem.cpp
# SUBTRACT CPP /YX /Yc /Yu
# End Source File
# Begin Source File

SOURCE=..\..\..\..\Source\Common\dl_str.cpp
# SUBTRACT CPP /YX /Yc /Yu
# End Source File
# Begin Source File

SOURCE=..\..\..\..\Source\Common\dl_time.cpp
# SUBTRACT CPP /YX /Yc /Yu
# End Source File
# Begin Source File

SOURCE=..\..\..\..\Source\Windows\dl_ToolTip.cpp
# End Source File
# Begin Source File

SOURCE=..\..\..\..\Source\Common\File\genfile.cpp
# SUBTRACT CPP /YX /Yc /Yu
# End Source File
# Begin Source File

SOURCE=..\..\..\..\Source\Common\File\genfind.cpp
# SUBTRACT CPP /YX /Yc /Yu
# End Source File
# Begin Source File

SOURCE=..\..\..\..\Source\Common\Contain\GenStack.cpp
# SUBTRACT CPP /YX /Yc /Yu
# End Source File
# Begin Source File

SOURCE=..\..\..\..\Source\uesp\Morrow\mwcommon.cpp
# ADD CPP /Yu
# End Source File
# Begin Source File

SOURCE=..\..\..\..\Source\Common\Utility\namelist.cpp
# SUBTRACT CPP /YX /Yc /Yu
# End Source File
# Begin Source File

SOURCE=..\..\..\..\Source\Common\Contain\ptrarray.cpp
# SUBTRACT CPP /YX /Yc /Yu
# End Source File
# Begin Source File

SOURCE=..\..\..\..\Source\Common\String\SString.cpp
# SUBTRACT CPP /YX /Yc /Yu
# End Source File
# Begin Source File

SOURCE=..\..\..\..\Source\Windows\TabCtrlSheet.cpp
# End Source File
# Begin Source File

SOURCE=..\..\..\..\Source\Common\Contain\temarray.cpp
# SUBTRACT CPP /YX /Yc /Yu
# End Source File
# Begin Source File

SOURCE=..\..\..\..\Source\Common\tstfile.cpp
# SUBTRACT CPP /YX /Yc /Yu
# End Source File
# Begin Source File

SOURCE=..\..\..\..\Source\Windows\WinUtil.cpp
# End Source File
# End Group
# Begin Group "ESM"

# PROP Default_Filter ""
# Begin Group "Records"

# PROP Default_Filter ""
# Begin Source File

SOURCE=..\..\..\..\Source\uesp\Morrow\esm\EsmActivator.cpp
# SUBTRACT CPP /YX /Yc /Yu
# End Source File
# Begin Source File

SOURCE=..\..\..\..\Source\uesp\Morrow\esm\EsmAlchemy.cpp
# SUBTRACT CPP /YX /Yc /Yu
# End Source File
# Begin Source File

SOURCE=..\..\..\..\Source\uesp\Morrow\esm\EsmApparatus.cpp
# SUBTRACT CPP /YX /Yc /Yu
# End Source File
# Begin Source File

SOURCE=..\..\..\..\Source\uesp\Morrow\esm\EsmArmor.cpp
# SUBTRACT CPP /YX /Yc /Yu
# End Source File
# Begin Source File

SOURCE=..\..\..\..\Source\uesp\Morrow\esm\EsmBirthSign.cpp
# SUBTRACT CPP /YX /Yc /Yu
# End Source File
# Begin Source File

SOURCE=..\..\..\..\Source\uesp\Morrow\esm\EsmBodyPart.cpp
# SUBTRACT CPP /YX /Yc /Yu
# End Source File
# Begin Source File

SOURCE=..\..\..\..\Source\uesp\Morrow\esm\EsmBook.cpp
# SUBTRACT CPP /YX /Yc /Yu
# End Source File
# Begin Source File

SOURCE=..\..\..\..\Source\uesp\Morrow\esm\EsmCell.cpp
# SUBTRACT CPP /YX /Yc /Yu
# End Source File
# Begin Source File

SOURCE=..\..\..\..\Source\uesp\Morrow\esm\EsmClass.cpp
# SUBTRACT CPP /YX /Yc /Yu
# End Source File
# Begin Source File

SOURCE=..\..\..\..\Source\uesp\Morrow\esm\EsmClothing.cpp
# SUBTRACT CPP /YX /Yc /Yu
# End Source File
# Begin Source File

SOURCE=..\..\..\..\Source\uesp\Morrow\esm\EsmContainer.cpp
# SUBTRACT CPP /YX /Yc /Yu
# End Source File
# Begin Source File

SOURCE=..\..\..\..\Source\uesp\Morrow\esm\EsmCreature.cpp
# SUBTRACT CPP /YX /Yc /Yu
# End Source File
# Begin Source File

SOURCE=..\..\..\..\Source\uesp\Morrow\esm\EsmDialogue.cpp
# SUBTRACT CPP /YX /Yc /Yu
# End Source File
# Begin Source File

SOURCE=..\..\..\..\Source\uesp\Morrow\esm\EsmDoor.cpp
# SUBTRACT CPP /YX /Yc /Yu
# End Source File
# Begin Source File

SOURCE=..\..\..\..\Source\uesp\Morrow\esm\EsmEnchant.cpp
# SUBTRACT CPP /YX /Yc /Yu
# End Source File
# Begin Source File

SOURCE=..\..\..\..\Source\uesp\Morrow\esm\EsmFaction.cpp
# SUBTRACT CPP /YX /Yc /Yu
# End Source File
# Begin Source File

SOURCE=..\..\..\..\Source\uesp\Morrow\esm\EsmGameSetting.cpp
# SUBTRACT CPP /YX /Yc /Yu
# End Source File
# Begin Source File

SOURCE=..\..\..\..\Source\uesp\Morrow\esm\EsmGlobal.cpp
# SUBTRACT CPP /YX /Yc /Yu
# End Source File
# Begin Source File

SOURCE=..\..\..\..\Source\uesp\Morrow\esm\EsmInfo.cpp
# SUBTRACT CPP /YX /Yc /Yu
# End Source File
# Begin Source File

SOURCE=..\..\..\..\Source\uesp\Morrow\esm\EsmIngrediant.cpp
# SUBTRACT CPP /YX /Yc /Yu
# End Source File
# Begin Source File

SOURCE=..\..\..\..\Source\uesp\Morrow\esm\EsmItem1.cpp
# SUBTRACT CPP /YX /Yc /Yu
# End Source File
# Begin Source File

SOURCE=..\..\..\..\Source\uesp\Morrow\esm\EsmItem2.cpp
# SUBTRACT CPP /YX /Yc /Yu
# End Source File
# Begin Source File

SOURCE=..\..\..\..\Source\uesp\Morrow\esm\EsmItem3.cpp
# SUBTRACT CPP /YX /Yc /Yu
# End Source File
# Begin Source File

SOURCE=..\..\..\..\Source\uesp\Morrow\esm\EsmLand.cpp
# SUBTRACT CPP /YX /Yc /Yu
# End Source File
# Begin Source File

SOURCE=..\..\..\..\Source\uesp\Morrow\esm\EsmLevelCrea.cpp
# SUBTRACT CPP /YX /Yc /Yu
# End Source File
# Begin Source File

SOURCE=..\..\..\..\Source\uesp\Morrow\esm\EsmLevelItem.cpp
# SUBTRACT CPP /YX /Yc /Yu
# End Source File
# Begin Source File

SOURCE=..\..\..\..\Source\uesp\Morrow\esm\EsmLight.cpp
# SUBTRACT CPP /YX /Yc /Yu
# End Source File
# Begin Source File

SOURCE=..\..\..\..\Source\uesp\Morrow\esm\EsmLockPick.cpp
# SUBTRACT CPP /YX /Yc /Yu
# End Source File
# Begin Source File

SOURCE=..\..\..\..\Source\uesp\Morrow\esm\EsmMagicEffect.cpp
# SUBTRACT CPP /YX /Yc /Yu
# End Source File
# Begin Source File

SOURCE=..\..\..\..\Source\uesp\Morrow\esm\EsmMisc.cpp
# SUBTRACT CPP /YX /Yc /Yu
# End Source File
# Begin Source File

SOURCE=..\..\..\..\Source\uesp\Morrow\esm\EsmNpc.cpp
# SUBTRACT CPP /YX /Yc /Yu
# End Source File
# Begin Source File

SOURCE=..\..\..\..\Source\uesp\Morrow\esm\EsmProbe.cpp
# SUBTRACT CPP /YX /Yc /Yu
# End Source File
# Begin Source File

SOURCE=..\..\..\..\Source\uesp\Morrow\esm\EsmRace.cpp
# SUBTRACT CPP /YX /Yc /Yu
# End Source File
# Begin Source File

SOURCE=..\..\..\..\Source\uesp\Morrow\esm\EsmRecord.cpp
# SUBTRACT CPP /YX /Yc /Yu
# End Source File
# Begin Source File

SOURCE=..\..\..\..\Source\uesp\Morrow\esm\EsmRegion.cpp
# SUBTRACT CPP /YX /Yc /Yu
# End Source File
# Begin Source File

SOURCE=..\..\..\..\Source\uesp\Morrow\esm\EsmRepair.cpp
# SUBTRACT CPP /YX /Yc /Yu
# End Source File
# Begin Source File

SOURCE=..\..\..\..\Source\uesp\Morrow\esm\EsmScript.cpp
# SUBTRACT CPP /YX /Yc /Yu
# End Source File
# Begin Source File

SOURCE=..\..\..\..\Source\uesp\Morrow\esm\EsmSkill.cpp
# SUBTRACT CPP /YX /Yc /Yu
# End Source File
# Begin Source File

SOURCE=..\..\..\..\Source\uesp\Morrow\esm\EsmSound.cpp
# SUBTRACT CPP /YX /Yc /Yu
# End Source File
# Begin Source File

SOURCE=..\..\..\..\Source\uesp\Morrow\esm\EsmSoundGen.cpp
# SUBTRACT CPP /YX /Yc /Yu
# End Source File
# Begin Source File

SOURCE=..\..\..\..\Source\uesp\Morrow\esm\EsmSpell.cpp
# SUBTRACT CPP /YX /Yc /Yu
# End Source File
# Begin Source File

SOURCE=..\..\..\..\Source\uesp\Morrow\esm\EsmStartScript.cpp
# SUBTRACT CPP /YX /Yc /Yu
# End Source File
# Begin Source File

SOURCE=..\..\..\..\Source\uesp\Morrow\esm\EsmStatic.cpp
# SUBTRACT CPP /YX /Yc /Yu
# End Source File
# Begin Source File

SOURCE=..\..\..\..\Source\uesp\Morrow\esm\EsmTES3.cpp
# SUBTRACT CPP /YX /Yc /Yu
# End Source File
# Begin Source File

SOURCE=..\..\..\..\Source\uesp\Morrow\esm\EsmWeapon.cpp
# SUBTRACT CPP /YX /Yc /Yu
# End Source File
# End Group
# Begin Group "SubRecords"

# PROP Default_Filter ""
# Begin Source File

SOURCE=..\..\..\..\Source\uesp\Morrow\esm\EsmSubBase.cpp
# SUBTRACT CPP /YX /Yc /Yu
# End Source File
# Begin Source File

SOURCE=..\..\..\..\Source\uesp\Morrow\esm\EsmSubCellRef.cpp
# SUBTRACT CPP /YX /Yc /Yu
# End Source File
# Begin Source File

SOURCE=..\..\..\..\Source\uesp\Morrow\esm\EsmSubName.cpp
# SUBTRACT CPP /YX /Yc /Yu
# End Source File
# Begin Source File

SOURCE=..\..\..\..\Source\uesp\Morrow\esm\EsmSubSCVR.cpp
# SUBTRACT CPP /YX /Yc /Yu
# End Source File
# End Group
# Begin Group "Script1"

# PROP Default_Filter ""
# Begin Source File

SOURCE=.\EsmScrFuncArray.cpp
# SUBTRACT CPP /YX /Yc /Yu
# End Source File
# Begin Source File

SOURCE=.\EsmScrFuncData.cpp
# SUBTRACT CPP /YX /Yc /Yu
# End Source File
# Begin Source File

SOURCE=.\EsmScriptCompile.cpp
# ADD CPP /Yu
# End Source File
# Begin Source File

SOURCE=.\EsmScriptCompileEx.cpp
# End Source File
# Begin Source File

SOURCE=.\EsmScriptDefs.cpp
# SUBTRACT CPP /YX /Yc /Yu
# End Source File
# Begin Source File

SOURCE=.\EsmScriptError.cpp
# SUBTRACT CPP /YX /Yc /Yu
# End Source File
# Begin Source File

SOURCE=.\EsmScriptFuncs.cpp
# SUBTRACT CPP /YX /Yc /Yu
# End Source File
# Begin Source File

SOURCE=.\EsmScriptOptions.cpp
# SUBTRACT CPP /YX /Yc /Yu
# End Source File
# Begin Source File

SOURCE=.\mwcustomfunc.cpp
# SUBTRACT CPP /YX /Yc /Yu
# End Source File
# End Group
# Begin Source File

SOURCE=..\..\..\..\Source\uesp\Morrow\esm\EsmBase.cpp
# SUBTRACT CPP /YX /Yc /Yu
# End Source File
# Begin Source File

SOURCE=.\EsmCsvDefs.cpp
# SUBTRACT CPP /YX /Yc /Yu
# End Source File
# Begin Source File

SOURCE=..\..\..\..\Source\uesp\Morrow\esm\EsmFile.cpp
# SUBTRACT CPP /YX /Yc /Yu
# End Source File
# Begin Source File

SOURCE=.\EsmGlobOptions.cpp
# End Source File
# Begin Source File

SOURCE=.\EsmOptions.cpp
# ADD CPP /Yu
# End Source File
# Begin Source File

SOURCE=.\EsmUtils.cpp
# End Source File
# End Group
# Begin Group "Devil"

# PROP Default_Filter ""
# Begin Source File

SOURCE="..\..\..\DevIL\src-IL\src\il_alloc.c"
# ADD CPP /I "d:\vcsource\devil\src-il\include" /I "d:\vcsource\devil\src-ilu\include" /I "d:\vcsource\devil\src-ilut\include"
# SUBTRACT CPP /YX /Yc /Yu
# End Source File
# Begin Source File

SOURCE="..\..\..\DevIL\src-IL\src\il_bits.c"
# ADD CPP /I "d:\vcsource\devil\src-il\include" /I "d:\vcsource\devil\src-ilu\include" /I "d:\vcsource\devil\src-ilut\include"
# SUBTRACT CPP /YX /Yc /Yu
# End Source File
# Begin Source File

SOURCE="..\..\..\DevIL\src-IL\src\il_bmp.c"
# ADD CPP /I "d:\vcsource\devil\src-il\include" /I "d:\vcsource\devil\src-ilu\include" /I "d:\vcsource\devil\src-ilut\include"
# SUBTRACT CPP /YX /Yc /Yu
# End Source File
# Begin Source File

SOURCE="..\..\..\DevIL\src-IL\src\il_convbuff.c"
# ADD CPP /I "d:\vcsource\devil\src-il\include" /I "d:\vcsource\devil\src-ilu\include" /I "d:\vcsource\devil\src-ilut\include"
# SUBTRACT CPP /YX /Yc /Yu
# End Source File
# Begin Source File

SOURCE="..\..\..\DevIL\src-IL\src\il_convert.c"
# ADD CPP /I "d:\vcsource\devil\src-il\include" /I "d:\vcsource\devil\src-ilu\include" /I "d:\vcsource\devil\src-ilut\include"
# SUBTRACT CPP /YX /Yc /Yu
# End Source File
# Begin Source File

SOURCE="..\..\..\DevIL\src-IL\src\il_cut.c"
# ADD CPP /I "d:\vcsource\devil\src-il\include" /I "d:\vcsource\devil\src-ilu\include" /I "d:\vcsource\devil\src-ilut\include"
# SUBTRACT CPP /YX /Yc /Yu
# End Source File
# Begin Source File

SOURCE="..\..\..\DevIL\src-IL\src\il_dcx.c"
# ADD CPP /I "d:\vcsource\devil\src-il\include" /I "d:\vcsource\devil\src-ilu\include" /I "d:\vcsource\devil\src-ilut\include"
# SUBTRACT CPP /YX /Yc /Yu
# End Source File
# Begin Source File

SOURCE="..\..\..\DevIL\src-IL\src\il_dds-save.c"
# ADD CPP /I "d:\vcsource\devil\src-il\include" /I "d:\vcsource\devil\src-ilu\include" /I "d:\vcsource\devil\src-ilut\include"
# SUBTRACT CPP /YX /Yc /Yu
# End Source File
# Begin Source File

SOURCE="..\..\..\DevIL\src-IL\src\il_dds.c"
# ADD CPP /I "d:\vcsource\devil\src-il\include" /I "d:\vcsource\devil\src-ilu\include" /I "d:\vcsource\devil\src-ilut\include"
# SUBTRACT CPP /YX /Yc /Yu
# End Source File
# Begin Source File

SOURCE="..\..\..\DevIL\src-IL\src\il_devil.c"
# ADD CPP /I "d:\vcsource\devil\src-il\include" /I "d:\vcsource\devil\src-ilu\include" /I "d:\vcsource\devil\src-ilut\include"
# SUBTRACT CPP /YX /Yc /Yu
# End Source File
# Begin Source File

SOURCE="..\..\..\DevIL\src-IL\src\il_doom.c"
# ADD CPP /I "d:\vcsource\devil\src-il\include" /I "d:\vcsource\devil\src-ilu\include" /I "d:\vcsource\devil\src-ilut\include"
# SUBTRACT CPP /YX /Yc /Yu
# End Source File
# Begin Source File

SOURCE="..\..\..\DevIL\src-IL\src\il_endian.c"
# ADD CPP /I "d:\vcsource\devil\src-il\include" /I "d:\vcsource\devil\src-ilu\include" /I "d:\vcsource\devil\src-ilut\include"
# SUBTRACT CPP /YX /Yc /Yu
# End Source File
# Begin Source File

SOURCE="..\..\..\DevIL\src-IL\src\il_error.c"
# ADD CPP /I "d:\vcsource\devil\src-il\include" /I "d:\vcsource\devil\src-ilu\include" /I "d:\vcsource\devil\src-ilut\include"
# SUBTRACT CPP /YX /Yc /Yu
# End Source File
# Begin Source File

SOURCE="..\..\..\DevIL\src-IL\src\il_fastconv.c"
# ADD CPP /I "d:\vcsource\devil\src-il\include" /I "d:\vcsource\devil\src-ilu\include" /I "d:\vcsource\devil\src-ilut\include"
# SUBTRACT CPP /YX /Yc /Yu
# End Source File
# Begin Source File

SOURCE="..\..\..\DevIL\src-IL\src\il_files.c"
# ADD CPP /I "d:\vcsource\devil\src-il\include" /I "d:\vcsource\devil\src-ilu\include" /I "d:\vcsource\devil\src-ilut\include"
# SUBTRACT CPP /YX /Yc /Yu
# End Source File
# Begin Source File

SOURCE="..\..\..\DevIL\src-IL\src\il_gif.c"
# ADD CPP /I "d:\vcsource\devil\src-il\include" /I "d:\vcsource\devil\src-ilu\include" /I "d:\vcsource\devil\src-ilut\include"
# SUBTRACT CPP /YX /Yc /Yu
# End Source File
# Begin Source File

SOURCE="..\..\..\DevIL\src-IL\src\il_header.c"
# ADD CPP /I "d:\vcsource\devil\src-il\include" /I "d:\vcsource\devil\src-ilu\include" /I "d:\vcsource\devil\src-ilut\include"
# SUBTRACT CPP /YX /Yc /Yu
# End Source File
# Begin Source File

SOURCE="..\..\..\DevIL\src-IL\src\il_icon.c"
# ADD CPP /I "d:\vcsource\devil\src-il\include" /I "d:\vcsource\devil\src-ilu\include" /I "d:\vcsource\devil\src-ilut\include"
# SUBTRACT CPP /YX /Yc /Yu
# End Source File
# Begin Source File

SOURCE="..\..\..\DevIL\src-IL\src\il_internal.c"
# ADD CPP /I "d:\vcsource\devil\src-il\include" /I "d:\vcsource\devil\src-ilu\include" /I "d:\vcsource\devil\src-ilut\include"
# SUBTRACT CPP /YX /Yc /Yu
# End Source File
# Begin Source File

SOURCE="..\..\..\DevIL\src-IL\src\il_io.c"
# ADD CPP /I "d:\vcsource\devil\src-il\include" /I "d:\vcsource\devil\src-ilu\include" /I "d:\vcsource\devil\src-ilut\include"
# SUBTRACT CPP /YX /Yc /Yu
# End Source File
# Begin Source File

SOURCE="..\..\..\DevIL\src-IL\src\il_jpeg.c"
# ADD CPP /I "d:\vcsource\devil\src-il\include" /I "d:\vcsource\devil\src-ilu\include" /I "d:\vcsource\devil\src-ilut\include"
# SUBTRACT CPP /YX /Yc /Yu
# End Source File
# Begin Source File

SOURCE="..\..\..\DevIL\src-IL\src\il_lif.c"
# ADD CPP /I "d:\vcsource\devil\src-il\include" /I "d:\vcsource\devil\src-ilu\include" /I "d:\vcsource\devil\src-ilut\include"
# SUBTRACT CPP /YX /Yc /Yu
# End Source File
# Begin Source File

SOURCE="..\..\..\DevIL\src-IL\src\il_main.c"
# ADD CPP /I "d:\vcsource\devil\src-il\include" /I "d:\vcsource\devil\src-ilu\include" /I "d:\vcsource\devil\src-ilut\include"
# SUBTRACT CPP /YX /Yc /Yu
# End Source File
# Begin Source File

SOURCE="..\..\..\DevIL\src-IL\src\il_manip.c"
# ADD CPP /I "d:\vcsource\devil\src-il\include" /I "d:\vcsource\devil\src-ilu\include" /I "d:\vcsource\devil\src-ilut\include"
# SUBTRACT CPP /YX /Yc /Yu
# End Source File
# Begin Source File

SOURCE="..\..\..\DevIL\src-IL\src\il_mdl.c"
# ADD CPP /I "d:\vcsource\devil\src-il\include" /I "d:\vcsource\devil\src-ilu\include" /I "d:\vcsource\devil\src-ilut\include"
# SUBTRACT CPP /YX /Yc /Yu
# End Source File
# Begin Source File

SOURCE="..\..\..\DevIL\src-IL\src\il_mng.c"
# ADD CPP /I "d:\vcsource\devil\src-il\include" /I "d:\vcsource\devil\src-ilu\include" /I "d:\vcsource\devil\src-ilut\include"
# SUBTRACT CPP /YX /Yc /Yu
# End Source File
# Begin Source File

SOURCE="..\..\..\DevIL\src-IL\src\il_neuquant.c"
# ADD CPP /I "d:\vcsource\devil\src-il\include" /I "d:\vcsource\devil\src-ilu\include" /I "d:\vcsource\devil\src-ilut\include"
# SUBTRACT CPP /YX /Yc /Yu
# End Source File
# Begin Source File

SOURCE="..\..\..\DevIL\src-IL\src\il_pal.c"
# ADD CPP /I "d:\vcsource\devil\src-il\include" /I "d:\vcsource\devil\src-ilu\include" /I "d:\vcsource\devil\src-ilut\include"
# SUBTRACT CPP /YX /Yc /Yu
# End Source File
# Begin Source File

SOURCE="..\..\..\DevIL\src-IL\src\il_pcd.c"
# ADD CPP /I "d:\vcsource\devil\src-il\include" /I "d:\vcsource\devil\src-ilu\include" /I "d:\vcsource\devil\src-ilut\include"
# SUBTRACT CPP /YX /Yc /Yu
# End Source File
# Begin Source File

SOURCE="..\..\..\DevIL\src-IL\src\il_pcx.c"
# ADD CPP /I "d:\vcsource\devil\src-il\include" /I "d:\vcsource\devil\src-ilu\include" /I "d:\vcsource\devil\src-ilut\include"
# SUBTRACT CPP /YX /Yc /Yu
# End Source File
# Begin Source File

SOURCE="..\..\..\DevIL\src-IL\src\il_pic.c"
# ADD CPP /I "d:\vcsource\devil\src-il\include" /I "d:\vcsource\devil\src-ilu\include" /I "d:\vcsource\devil\src-ilut\include"
# SUBTRACT CPP /YX /Yc /Yu
# End Source File
# Begin Source File

SOURCE="..\..\..\DevIL\src-IL\src\il_pix.c"
# ADD CPP /I "d:\vcsource\devil\src-il\include" /I "d:\vcsource\devil\src-ilu\include" /I "d:\vcsource\devil\src-ilut\include"
# SUBTRACT CPP /YX /Yc /Yu
# End Source File
# Begin Source File

SOURCE="..\..\..\DevIL\src-IL\src\il_png.c"
# ADD CPP /I "d:\vcsource\devil\src-il\include" /I "d:\vcsource\devil\src-ilu\include" /I "d:\vcsource\devil\src-ilut\include"
# SUBTRACT CPP /YX /Yc /Yu
# End Source File
# Begin Source File

SOURCE="..\..\..\DevIL\src-IL\src\il_pnm.c"
# ADD CPP /I "d:\vcsource\devil\src-il\include" /I "d:\vcsource\devil\src-ilu\include" /I "d:\vcsource\devil\src-ilut\include"
# SUBTRACT CPP /YX /Yc /Yu
# End Source File
# Begin Source File

SOURCE="..\..\..\DevIL\src-IL\src\il_profiles.c"
# ADD CPP /I "d:\vcsource\devil\src-il\include" /I "d:\vcsource\devil\src-ilu\include" /I "d:\vcsource\devil\src-ilut\include"
# SUBTRACT CPP /YX /Yc /Yu
# End Source File
# Begin Source File

SOURCE="..\..\..\DevIL\src-IL\src\il_psd.c"
# ADD CPP /I "d:\vcsource\devil\src-il\include" /I "d:\vcsource\devil\src-ilu\include" /I "d:\vcsource\devil\src-ilut\include"
# SUBTRACT CPP /YX /Yc /Yu
# End Source File
# Begin Source File

SOURCE="..\..\..\DevIL\src-IL\src\il_psp.c"
# ADD CPP /I "d:\vcsource\devil\src-il\include" /I "d:\vcsource\devil\src-ilu\include" /I "d:\vcsource\devil\src-ilut\include"
# SUBTRACT CPP /YX /Yc /Yu
# End Source File
# Begin Source File

SOURCE="..\..\..\DevIL\src-IL\src\il_pxr.c"
# ADD CPP /I "d:\vcsource\devil\src-il\include" /I "d:\vcsource\devil\src-ilu\include" /I "d:\vcsource\devil\src-ilut\include"
# SUBTRACT CPP /YX /Yc /Yu
# End Source File
# Begin Source File

SOURCE="..\..\..\DevIL\src-IL\src\il_quantizer.c"
# ADD CPP /I "d:\vcsource\devil\src-il\include" /I "d:\vcsource\devil\src-ilu\include" /I "d:\vcsource\devil\src-ilut\include"
# SUBTRACT CPP /YX /Yc /Yu
# End Source File
# Begin Source File

SOURCE="..\..\..\DevIL\src-IL\src\il_raw.c"
# ADD CPP /I "d:\vcsource\devil\src-il\include" /I "d:\vcsource\devil\src-ilu\include" /I "d:\vcsource\devil\src-ilut\include"
# SUBTRACT CPP /YX /Yc /Yu
# End Source File
# Begin Source File

SOURCE="..\..\..\DevIL\src-IL\src\il_rawdata.c"
# ADD CPP /I "d:\vcsource\devil\src-il\include" /I "d:\vcsource\devil\src-ilu\include" /I "d:\vcsource\devil\src-ilut\include"
# SUBTRACT CPP /YX /Yc /Yu
# End Source File
# Begin Source File

SOURCE="..\..\..\DevIL\src-IL\src\il_register.c"
# ADD CPP /I "d:\vcsource\devil\src-il\include" /I "d:\vcsource\devil\src-ilu\include" /I "d:\vcsource\devil\src-ilut\include"
# SUBTRACT CPP /YX /Yc /Yu
# End Source File
# Begin Source File

SOURCE="..\..\..\DevIL\src-IL\src\il_rle.c"
# ADD CPP /I "d:\vcsource\devil\src-il\include" /I "d:\vcsource\devil\src-ilu\include" /I "d:\vcsource\devil\src-ilut\include"
# SUBTRACT CPP /YX /Yc /Yu
# End Source File
# Begin Source File

SOURCE="..\..\..\DevIL\src-IL\src\il_sgi.c"
# ADD CPP /I "d:\vcsource\devil\src-il\include" /I "d:\vcsource\devil\src-ilu\include" /I "d:\vcsource\devil\src-ilut\include"
# SUBTRACT CPP /YX /Yc /Yu
# End Source File
# Begin Source File

SOURCE="..\..\..\DevIL\src-IL\src\il_stack.c"
# ADD CPP /I "d:\vcsource\devil\src-il\include" /I "d:\vcsource\devil\src-ilu\include" /I "d:\vcsource\devil\src-ilut\include"
# SUBTRACT CPP /YX /Yc /Yu
# End Source File
# Begin Source File

SOURCE="..\..\..\DevIL\src-IL\src\il_states.c"
# ADD CPP /I "d:\vcsource\devil\src-il\include" /I "d:\vcsource\devil\src-ilu\include" /I "d:\vcsource\devil\src-ilut\include"
# SUBTRACT CPP /YX /Yc /Yu
# End Source File
# Begin Source File

SOURCE="..\..\..\DevIL\src-IL\src\il_targa.c"
# ADD CPP /I "d:\vcsource\devil\src-il\include" /I "d:\vcsource\devil\src-ilu\include" /I "d:\vcsource\devil\src-ilut\include"
# SUBTRACT CPP /YX /Yc /Yu
# End Source File
# Begin Source File

SOURCE="..\..\..\DevIL\src-IL\src\il_tiff.c"
# ADD CPP /I "d:\vcsource\devil\src-il\include" /I "d:\vcsource\devil\src-ilu\include" /I "d:\vcsource\devil\src-ilut\include"
# SUBTRACT CPP /YX /Yc /Yu
# End Source File
# Begin Source File

SOURCE="..\..\..\DevIL\src-IL\src\il_utility.c"
# ADD CPP /I "d:\vcsource\devil\src-il\include" /I "d:\vcsource\devil\src-ilu\include" /I "d:\vcsource\devil\src-ilut\include"
# SUBTRACT CPP /YX /Yc /Yu
# End Source File
# Begin Source File

SOURCE="..\..\..\DevIL\src-IL\src\il_wal.c"
# ADD CPP /I "d:\vcsource\devil\src-il\include" /I "d:\vcsource\devil\src-ilu\include" /I "d:\vcsource\devil\src-ilut\include"
# SUBTRACT CPP /YX /Yc /Yu
# End Source File
# Begin Source File

SOURCE="..\..\..\DevIL\src-IL\src\il_xpm.c"
# ADD CPP /I "d:\vcsource\devil\src-il\include" /I "d:\vcsource\devil\src-ilu\include" /I "d:\vcsource\devil\src-ilut\include"
# SUBTRACT CPP /YX /Yc /Yu
# End Source File
# Begin Source File

SOURCE="..\..\..\DevIL\src-ILU\src\ilu_alloc.c"
# ADD CPP /I "d:\vcsource\devil\src-il\include" /I "d:\vcsource\devil\src-ilu\include" /I "d:\vcsource\devil\src-ilut\include"
# SUBTRACT CPP /YX /Yc /Yu
# End Source File
# Begin Source File

SOURCE="..\..\..\DevIL\src-ILU\src\ilu_error.c"
# ADD CPP /I "d:\vcsource\devil\src-il\include" /I "d:\vcsource\devil\src-ilu\include" /I "d:\vcsource\devil\src-ilut\include"
# SUBTRACT CPP /YX /Yc /Yu
# End Source File
# Begin Source File

SOURCE="..\..\..\DevIL\src-ILU\src\ilu_filter.c"
# ADD CPP /I "d:\vcsource\devil\src-il\include" /I "d:\vcsource\devil\src-ilu\include" /I "d:\vcsource\devil\src-ilut\include"
# SUBTRACT CPP /YX /Yc /Yu
# End Source File
# Begin Source File

SOURCE="..\..\..\DevIL\src-ILU\src\ilu_filter_rcg.c"
# ADD CPP /I "d:\vcsource\devil\src-il\include" /I "d:\vcsource\devil\src-ilu\include" /I "d:\vcsource\devil\src-ilut\include"
# SUBTRACT CPP /YX /Yc /Yu
# End Source File
# Begin Source File

SOURCE="..\..\..\DevIL\src-ILU\src\ilu_internal.c"
# ADD CPP /I "d:\vcsource\devil\src-il\include" /I "d:\vcsource\devil\src-ilu\include" /I "d:\vcsource\devil\src-ilut\include"
# SUBTRACT CPP /YX /Yc /Yu
# End Source File
# Begin Source File

SOURCE="..\..\..\DevIL\src-ILU\src\ilu_main.c"
# ADD CPP /I "d:\vcsource\devil\src-il\include" /I "d:\vcsource\devil\src-ilu\include" /I "d:\vcsource\devil\src-ilut\include"
# SUBTRACT CPP /YX /Yc /Yu
# End Source File
# Begin Source File

SOURCE="..\..\..\DevIL\src-ILU\src\ilu_manip.c"
# ADD CPP /I "d:\vcsource\devil\src-il\include" /I "d:\vcsource\devil\src-ilu\include" /I "d:\vcsource\devil\src-ilut\include"
# SUBTRACT CPP /YX /Yc /Yu
# End Source File
# Begin Source File

SOURCE="..\..\..\DevIL\src-ILU\src\ilu_mipmap.c"
# ADD CPP /I "d:\vcsource\devil\src-il\include" /I "d:\vcsource\devil\src-ilu\include" /I "d:\vcsource\devil\src-ilut\include"
# SUBTRACT CPP /YX /Yc /Yu
# End Source File
# Begin Source File

SOURCE="..\..\..\DevIL\src-ILU\src\ilu_noise.c"
# ADD CPP /I "d:\vcsource\devil\src-il\include" /I "d:\vcsource\devil\src-ilu\include" /I "d:\vcsource\devil\src-ilut\include"
# SUBTRACT CPP /YX /Yc /Yu
# End Source File
# Begin Source File

SOURCE="..\..\..\DevIL\src-ILU\src\ilu_region.c"
# ADD CPP /I "d:\vcsource\devil\src-il\include" /I "d:\vcsource\devil\src-ilu\include" /I "d:\vcsource\devil\src-ilut\include"
# SUBTRACT CPP /YX /Yc /Yu
# End Source File
# Begin Source File

SOURCE="..\..\..\DevIL\src-ILU\src\ilu_rotate.c"
# ADD CPP /I "d:\vcsource\devil\src-il\include" /I "d:\vcsource\devil\src-ilu\include" /I "d:\vcsource\devil\src-ilut\include"
# SUBTRACT CPP /YX /Yc /Yu
# End Source File
# Begin Source File

SOURCE="..\..\..\DevIL\src-ILU\src\ilu_scale.c"
# ADD CPP /I "d:\vcsource\devil\src-il\include" /I "d:\vcsource\devil\src-ilu\include" /I "d:\vcsource\devil\src-ilut\include"
# SUBTRACT CPP /YX /Yc /Yu
# End Source File
# Begin Source File

SOURCE="..\..\..\DevIL\src-ILU\src\ilu_scale2d.c"
# ADD CPP /I "d:\vcsource\devil\src-il\include" /I "d:\vcsource\devil\src-ilu\include" /I "d:\vcsource\devil\src-ilut\include"
# SUBTRACT CPP /YX /Yc /Yu
# End Source File
# Begin Source File

SOURCE="..\..\..\DevIL\src-ILU\src\ilu_scale3d.c"
# ADD CPP /I "d:\vcsource\devil\src-il\include" /I "d:\vcsource\devil\src-ilu\include" /I "d:\vcsource\devil\src-ilut\include"
# SUBTRACT CPP /YX /Yc /Yu
# End Source File
# Begin Source File

SOURCE="..\..\..\DevIL\src-ILU\src\ilu_scaling.c"
# ADD CPP /I "d:\vcsource\devil\src-il\include" /I "d:\vcsource\devil\src-ilu\include" /I "d:\vcsource\devil\src-ilut\include"
# SUBTRACT CPP /YX /Yc /Yu
# End Source File
# Begin Source File

SOURCE="..\..\..\DevIL\src-ILU\src\ilu_states.c"
# ADD CPP /I "d:\vcsource\devil\src-il\include" /I "d:\vcsource\devil\src-ilu\include" /I "d:\vcsource\devil\src-ilut\include"
# SUBTRACT CPP /YX /Yc /Yu
# End Source File
# Begin Source File

SOURCE="..\..\..\DevIL\src-ILU\src\ilu_utilities.c"
# ADD CPP /I "d:\vcsource\devil\src-il\include" /I "d:\vcsource\devil\src-ilu\include" /I "d:\vcsource\devil\src-ilut\include"
# SUBTRACT CPP /YX /Yc /Yu
# End Source File
# Begin Source File

SOURCE="..\..\..\DevIL\src-ILUT\src\ilut_allegro.c"
# ADD CPP /I "d:\vcsource\devil\src-il\include" /I "d:\vcsource\devil\src-ilu\include" /I "d:\vcsource\devil\src-ilut\include"
# SUBTRACT CPP /YX /Yc /Yu
# End Source File
# Begin Source File

SOURCE="..\..\..\DevIL\src-ILUT\src\ilut_directx.c"
# ADD CPP /I "d:\vcsource\devil\src-il\include" /I "d:\vcsource\devil\src-ilu\include" /I "d:\vcsource\devil\src-ilut\include"
# SUBTRACT CPP /YX /Yc /Yu
# End Source File
# Begin Source File

SOURCE="..\..\..\DevIL\src-ILUT\src\ilut_internal.c"
# ADD CPP /I "d:\vcsource\devil\src-il\include" /I "d:\vcsource\devil\src-ilu\include" /I "d:\vcsource\devil\src-ilut\include"
# SUBTRACT CPP /YX /Yc /Yu
# End Source File
# Begin Source File

SOURCE="..\..\..\DevIL\src-ILUT\src\ilut_main.c"
# ADD CPP /I "d:\vcsource\devil\src-il\include" /I "d:\vcsource\devil\src-ilu\include" /I "d:\vcsource\devil\src-ilut\include"
# SUBTRACT CPP /YX /Yc /Yu
# End Source File
# Begin Source File

SOURCE="..\..\..\DevIL\src-ILUT\src\ilut_opengl.c"
# ADD CPP /I "d:\vcsource\devil\src-il\include" /I "d:\vcsource\devil\src-ilu\include" /I "d:\vcsource\devil\src-ilut\include"
# SUBTRACT CPP /YX /Yc /Yu
# End Source File
# Begin Source File

SOURCE="..\..\..\DevIL\src-ILUT\src\ilut_sdlsurface.c"
# ADD CPP /I "d:\vcsource\devil\src-il\include" /I "d:\vcsource\devil\src-ilu\include" /I "d:\vcsource\devil\src-ilut\include"
# SUBTRACT CPP /YX /Yc /Yu
# End Source File
# Begin Source File

SOURCE="..\..\..\DevIL\src-ILUT\src\ilut_states.c"
# ADD CPP /I "d:\vcsource\devil\src-il\include" /I "d:\vcsource\devil\src-ilu\include" /I "d:\vcsource\devil\src-ilut\include"
# SUBTRACT CPP /YX /Yc /Yu
# End Source File
# Begin Source File

SOURCE="..\..\..\DevIL\src-ILUT\src\ilut_win32.c"
# ADD CPP /I "d:\vcsource\devil\src-il\include" /I "d:\vcsource\devil\src-ilu\include" /I "d:\vcsource\devil\src-ilut\include"
# SUBTRACT CPP /YX /Yc /Yu
# End Source File
# End Group
# Begin Source File

SOURCE=.\MWEdit.cpp
# End Source File
# Begin Source File

SOURCE=.\MWEditDoc.cpp
# End Source File
# Begin Source File

SOURCE=C:\Programs\MsVs\VC98\Lib\WINMM.LIB
# End Source File
# End Group
# Begin Group "Header Files"

# PROP Default_Filter "h;hpp;hxx;hm;inl"
# Begin Group "Forms."

# PROP Default_Filter ""
# Begin Group "Record."

# PROP Default_Filter ""
# Begin Source File

SOURCE=.\ActivatorDlg.h
# End Source File
# Begin Source File

SOURCE=.\EsmAiActivateDlg.h
# End Source File
# Begin Source File

SOURCE=.\EsmAiEscortDlg.h
# End Source File
# Begin Source File

SOURCE=.\EsmAiTravelDlg.h
# End Source File
# Begin Source File

SOURCE=.\EsmAiWanderDlg.h
# End Source File
# Begin Source File

SOURCE=.\EsmAlchemyDlg.h
# End Source File
# Begin Source File

SOURCE=.\EsmApparatusDlg.h
# End Source File
# Begin Source File

SOURCE=.\EsmArmorDlg.h
# End Source File
# Begin Source File

SOURCE=.\EsmBirthSignDlg.h
# End Source File
# Begin Source File

SOURCE=.\EsmBodyPartDlg.h
# End Source File
# Begin Source File

SOURCE=.\EsmBookDlg.h
# End Source File
# Begin Source File

SOURCE=.\EsmClassDlg.h
# End Source File
# Begin Source File

SOURCE=.\EsmClothingDlg.h
# End Source File
# Begin Source File

SOURCE=.\EsmContainDlg.h
# End Source File
# Begin Source File

SOURCE=.\EsmDialogDlg.h
# End Source File
# Begin Source File

SOURCE=.\EsmDoorDlg.h
# End Source File
# Begin Source File

SOURCE=.\EsmEffectDlg.h
# End Source File
# Begin Source File

SOURCE=.\EsmEnchantDlg.h
# End Source File
# Begin Source File

SOURCE=.\EsmFactionDlg.h
# End Source File
# Begin Source File

SOURCE=.\EsmGlobalDlg.h
# End Source File
# Begin Source File

SOURCE=.\EsmInfoDlg.h
# End Source File
# Begin Source File

SOURCE=.\EsmIngrediantDlg.h
# End Source File
# Begin Source File

SOURCE=.\EsmJournalDlg.h
# End Source File
# Begin Source File

SOURCE=.\EsmLevelCreaDlg.h
# End Source File
# Begin Source File

SOURCE=.\EsmLevelItemDlg.h
# End Source File
# Begin Source File

SOURCE=.\EsmLightDlg.h
# End Source File
# Begin Source File

SOURCE=.\EsmLockPickDlg.h
# End Source File
# Begin Source File

SOURCE=.\EsmMiscDlg.h
# End Source File
# Begin Source File

SOURCE=.\EsmProbeDlg.h
# End Source File
# Begin Source File

SOURCE=.\EsmRaceDlg.h
# End Source File
# Begin Source File

SOURCE=.\EsmRegionDlg.h
# End Source File
# Begin Source File

SOURCE=.\EsmRepairDlg.h
# End Source File
# Begin Source File

SOURCE=.\EsmSettingDlg.h
# End Source File
# Begin Source File

SOURCE=.\EsmSkillDlg.h
# End Source File
# Begin Source File

SOURCE=.\EsmSoundDlg.h
# End Source File
# Begin Source File

SOURCE=.\EsmSoundGenDlg.h
# End Source File
# Begin Source File

SOURCE=.\EsmSpellDlg.h
# End Source File
# Begin Source File

SOURCE=.\EsmStartScriptDlg.h
# End Source File
# Begin Source File

SOURCE=.\EsmStaticDlg.h
# End Source File
# Begin Source File

SOURCE=.\EsmWeaponDlg.h
# End Source File
# End Group
# Begin Group "Creature."

# PROP Default_Filter ""
# Begin Source File

SOURCE=.\CreaturePage1.h
# End Source File
# Begin Source File

SOURCE=.\CreaturePage2.h
# End Source File
# Begin Source File

SOURCE=.\EsmCreatureDlg.h
# End Source File
# Begin Source File

SOURCE=.\EsmCreaturePage1.h
# End Source File
# Begin Source File

SOURCE=.\EsmCreaturePage2.h
# End Source File
# Begin Source File

SOURCE=.\EsmCreaturePage3.h
# End Source File
# Begin Source File

SOURCE=.\EsmCreaturePage4.h
# End Source File
# Begin Source File

SOURCE=.\EsmCreaturePage5.h
# End Source File
# End Group
# Begin Group "Cell."

# PROP Default_Filter ""
# Begin Source File

SOURCE=.\EsmCellDlg.h
# End Source File
# Begin Source File

SOURCE=.\EsmCellRefDlg.h
# End Source File
# Begin Source File

SOURCE=.\EsmExtCellPage.h
# End Source File
# Begin Source File

SOURCE=.\EsmIntCellPage.h
# End Source File
# Begin Source File

SOURCE=.\EsmRefCellPage.h
# End Source File
# End Group
# Begin Group "Script."

# PROP Default_Filter ""
# Begin Source File

SOURCE=.\ChildFrmScript.h
# End Source File
# Begin Source File

SOURCE=.\EsmFuncHelpView.h
# End Source File
# Begin Source File

SOURCE=.\EsmScriptDlg.h
# End Source File
# Begin Source File

SOURCE=.\ScriptErrorDlg.h
# End Source File
# Begin Source File

SOURCE=.\ScriptErrorView.h
# End Source File
# End Group
# Begin Group "NPC."

# PROP Default_Filter ""
# Begin Source File

SOURCE=.\EsmNpcDlg.h
# End Source File
# Begin Source File

SOURCE=.\EsmNpcPage1.h
# End Source File
# Begin Source File

SOURCE=.\EsmNpcPage2.h
# End Source File
# Begin Source File

SOURCE=.\EsmNpcPage3.h
# End Source File
# Begin Source File

SOURCE=.\EsmNpcPage4.h
# End Source File
# Begin Source File

SOURCE=.\EsmNpcPage5.h
# End Source File
# End Group
# Begin Group "Base."

# PROP Default_Filter ""
# Begin Source File

SOURCE=.\EsmDlgArray.h
# End Source File
# Begin Source File

SOURCE=.\EsmRecDialog.h
# End Source File
# End Group
# Begin Group "General."

# PROP Default_Filter ""
# Begin Source File

SOURCE=.\ColorStatic1.h
# End Source File
# Begin Source File

SOURCE=.\CustRichEdit.h
# End Source File
# Begin Source File

SOURCE=.\EsmIconFrame.h
# End Source File
# Begin Source File

SOURCE=.\EsmListCtrl.h
# End Source File
# Begin Source File

SOURCE=.\EsmSubListCtrl.h
# End Source File
# Begin Source File

SOURCE=.\InputDialog.h
# End Source File
# Begin Source File

SOURCE=.\splitterwnd.h
# End Source File
# End Group
# Begin Group "Child."

# PROP Default_Filter ""
# Begin Source File

SOURCE=.\ChildFrm.h
# End Source File
# Begin Source File

SOURCE=.\ChildFrmFix.h
# End Source File
# Begin Source File

SOURCE=.\ChildFrmVar.h
# End Source File
# End Group
# Begin Group "ScriptTemplate."

# PROP Default_Filter ""
# Begin Source File

SOURCE=.\EsmScrTempPage1.h
# End Source File
# Begin Source File

SOURCE=.\EsmScrTempPage2.h
# End Source File
# Begin Source File

SOURCE=.\EsmScrTempPage3.h
# End Source File
# Begin Source File

SOURCE=.\EsmScrTempView.h
# End Source File
# Begin Source File

SOURCE=.\ScriptTemplate.h
# End Source File
# End Group
# Begin Source File

SOURCE=.\ErrorDialog.h
# End Source File
# Begin Source File

SOURCE=.\EsmCsvImportDlg.h
# End Source File
# Begin Source File

SOURCE=.\EsmFindDlg.h
# End Source File
# Begin Source File

SOURCE=.\EsmHeaderDlg.h
# End Source File
# Begin Source File

SOURCE=.\EsmLoadDlg.h
# End Source File
# Begin Source File

SOURCE=.\EsmOptionsDlg.h
# End Source File
# Begin Source File

SOURCE=.\EsmScriptCompareDlg.h
# End Source File
# Begin Source File

SOURCE=.\EsmUsesDlg.h
# End Source File
# Begin Source File

SOURCE=.\MainFrm.h
# End Source File
# Begin Source File

SOURCE=.\MWEditView.h
# End Source File
# Begin Source File

SOURCE=.\OpenPluginDlg.h
# End Source File
# End Group
# Begin Group "Misc."

# PROP Default_Filter ""
# Begin Source File

SOURCE=..\..\..\..\Source\Common\Contain\GenStack.h
# End Source File
# Begin Source File

SOURCE=.\hlp\MWEdit.hm
# End Source File
# Begin Source File

SOURCE=.\Resource.h

!IF  "$(CFG)" == "MWEdit - Win32 Release"

# PROP Ignore_Default_Tool 1
# Begin Custom Build - Making help include file...
TargetName=MWEdit
InputPath=.\Resource.h

"hlp\$(TargetName).hm" : $(SOURCE) "$(INTDIR)" "$(OUTDIR)"
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
	
# End Custom Build

!ELSEIF  "$(CFG)" == "MWEdit - Win32 Debug"

# PROP Ignore_Default_Tool 1
# Begin Custom Build - Making help include file...
TargetName=MWEdit
InputPath=.\Resource.h

"hlp\$(TargetName).hm" : $(SOURCE) "$(INTDIR)" "$(OUTDIR)"
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
	
# End Custom Build

!ENDIF 

# End Source File
# Begin Source File

SOURCE=.\resource.hm
# End Source File
# Begin Source File

SOURCE=.\StdAfx.h
# End Source File
# End Group
# Begin Group "Common."

# PROP Default_Filter ""
# Begin Source File

SOURCE=..\..\..\..\Source\File\csvfile.h
# End Source File
# Begin Source File

SOURCE=..\..\..\..\Source\Common\dl_base.h
# End Source File
# Begin Source File

SOURCE=..\..\..\..\Source\Common\dl_block.h
# End Source File
# Begin Source File

SOURCE=..\..\..\..\Source\Common\dl_chr.h
# End Source File
# Begin Source File

SOURCE=..\..\..\..\Source\Common\dl_err.h
# End Source File
# Begin Source File

SOURCE=..\..\..\..\Source\Common\dl_file.h
# End Source File
# Begin Source File

SOURCE=..\..\..\..\Source\Common\dl_log.h
# End Source File
# Begin Source File

SOURCE=..\..\..\..\Source\Common\Contain\dl_map.h
# End Source File
# Begin Source File

SOURCE=..\..\..\..\Source\Common\dl_math.h
# End Source File
# Begin Source File

SOURCE=..\..\..\..\Source\Common\dl_mem.h
# End Source File
# Begin Source File

SOURCE=..\..\..\..\Source\Common\dl_str.h
# End Source File
# Begin Source File

SOURCE=..\..\..\..\Source\Common\dl_time.h
# End Source File
# Begin Source File

SOURCE=..\..\..\..\Source\Windows\dl_ToolTip.h
# End Source File
# Begin Source File

SOURCE=..\..\..\..\Source\Common\File\genfile.h
# End Source File
# Begin Source File

SOURCE=..\..\..\..\Source\Common\File\genfind.h
# End Source File
# Begin Source File

SOURCE=..\..\..\..\Source\uesp\Morrow\mwcommon.h
# End Source File
# Begin Source File

SOURCE=..\..\..\..\Source\Common\Utility\namelist.h
# End Source File
# Begin Source File

SOURCE=..\..\..\..\Source\Common\Contain\ptrarray.h
# End Source File
# Begin Source File

SOURCE=..\..\..\..\Source\Common\String\sstring.h
# End Source File
# Begin Source File

SOURCE=..\..\..\..\Source\Windows\TabCtrlSheet.h
# End Source File
# Begin Source File

SOURCE=..\..\..\..\Source\Common\Contain\temarray.h
# End Source File
# Begin Source File

SOURCE=..\..\..\..\Source\Windows\winutil.h
# End Source File
# End Group
# Begin Group "ESM."

# PROP Default_Filter ""
# Begin Group "Records."

# PROP Default_Filter ""
# Begin Source File

SOURCE=..\..\..\..\Source\uesp\Morrow\esm\EsmActivator.h
# End Source File
# Begin Source File

SOURCE=..\..\..\..\Source\uesp\Morrow\esm\EsmAlchemy.h
# End Source File
# Begin Source File

SOURCE=..\..\..\..\Source\uesp\Morrow\esm\EsmApparatus.h
# End Source File
# Begin Source File

SOURCE=..\..\..\..\Source\uesp\Morrow\esm\EsmArmor.h
# End Source File
# Begin Source File

SOURCE=..\..\..\..\Source\uesp\Morrow\esm\EsmBirthSign.h
# End Source File
# Begin Source File

SOURCE=..\..\..\..\Source\uesp\Morrow\esm\EsmBodyPart.h
# End Source File
# Begin Source File

SOURCE=..\..\..\..\Source\uesp\Morrow\esm\EsmBook.h
# End Source File
# Begin Source File

SOURCE=..\..\..\..\Source\uesp\Morrow\esm\EsmCell.h
# End Source File
# Begin Source File

SOURCE=..\..\..\..\Source\uesp\Morrow\esm\EsmClass.h
# End Source File
# Begin Source File

SOURCE=..\..\..\..\Source\uesp\Morrow\esm\EsmClothing.h
# End Source File
# Begin Source File

SOURCE=..\..\..\..\Source\uesp\Morrow\esm\EsmContainer.h
# End Source File
# Begin Source File

SOURCE=..\..\..\..\Source\uesp\Morrow\esm\EsmCreature.h
# End Source File
# Begin Source File

SOURCE=..\..\..\..\Source\uesp\Morrow\esm\EsmDialogue.h
# End Source File
# Begin Source File

SOURCE=..\..\..\..\Source\uesp\Morrow\esm\EsmDoor.h
# End Source File
# Begin Source File

SOURCE=..\..\..\..\Source\uesp\Morrow\esm\EsmEnchant.h
# End Source File
# Begin Source File

SOURCE=..\..\..\..\Source\uesp\Morrow\esm\EsmFaction.h
# End Source File
# Begin Source File

SOURCE=..\..\..\..\Source\uesp\Morrow\esm\EsmGameSetting.h
# End Source File
# Begin Source File

SOURCE=..\..\..\..\Source\uesp\Morrow\esm\EsmGlobal.h
# End Source File
# Begin Source File

SOURCE=..\..\..\..\Source\uesp\Morrow\esm\EsmInfo.h
# End Source File
# Begin Source File

SOURCE=..\..\..\..\Source\uesp\Morrow\esm\EsmIngrediant.h
# End Source File
# Begin Source File

SOURCE=..\..\..\..\Source\uesp\Morrow\esm\EsmItem1.h
# End Source File
# Begin Source File

SOURCE=..\..\..\..\Source\uesp\Morrow\esm\EsmItem2.h
# End Source File
# Begin Source File

SOURCE=..\..\..\..\Source\uesp\Morrow\esm\EsmItem3.h
# End Source File
# Begin Source File

SOURCE=..\..\..\..\Source\uesp\Morrow\esm\EsmLand.h
# End Source File
# Begin Source File

SOURCE=..\..\..\..\Source\uesp\Morrow\esm\EsmLevelCrea.h
# End Source File
# Begin Source File

SOURCE=..\..\..\..\Source\uesp\Morrow\esm\EsmLevelItem.h
# End Source File
# Begin Source File

SOURCE=..\..\..\..\Source\uesp\Morrow\esm\EsmLight.h
# End Source File
# Begin Source File

SOURCE=..\..\..\..\Source\uesp\Morrow\esm\EsmLockPick.h
# End Source File
# Begin Source File

SOURCE=..\..\..\..\Source\uesp\Morrow\esm\EsmMagicEffect.h
# End Source File
# Begin Source File

SOURCE=..\..\..\..\Source\uesp\Morrow\esm\EsmMisc.h
# End Source File
# Begin Source File

SOURCE=..\..\..\..\Source\uesp\Morrow\esm\EsmNpc.h
# End Source File
# Begin Source File

SOURCE=..\..\..\..\Source\uesp\Morrow\esm\EsmProbe.h
# End Source File
# Begin Source File

SOURCE=..\..\..\..\Source\uesp\Morrow\esm\EsmRace.h
# End Source File
# Begin Source File

SOURCE=..\..\..\..\Source\uesp\Morrow\esm\EsmRecord.h
# End Source File
# Begin Source File

SOURCE=..\..\..\..\Source\uesp\Morrow\esm\EsmRegion.h
# End Source File
# Begin Source File

SOURCE=..\..\..\..\Source\uesp\Morrow\esm\EsmRepair.h
# End Source File
# Begin Source File

SOURCE=..\..\..\..\Source\uesp\Morrow\esm\EsmScript.h
# End Source File
# Begin Source File

SOURCE=..\..\..\..\Source\uesp\Morrow\esm\EsmSkill.h
# End Source File
# Begin Source File

SOURCE=..\..\..\..\Source\uesp\Morrow\esm\EsmSound.h
# End Source File
# Begin Source File

SOURCE=..\..\..\..\Source\uesp\Morrow\esm\EsmSoundGen.h
# End Source File
# Begin Source File

SOURCE=..\..\..\..\Source\uesp\Morrow\esm\EsmSpell.h
# End Source File
# Begin Source File

SOURCE=..\..\..\..\Source\uesp\Morrow\esm\EsmStartScript.h
# End Source File
# Begin Source File

SOURCE=..\..\..\..\Source\uesp\Morrow\esm\EsmStatic.h
# End Source File
# Begin Source File

SOURCE=..\..\..\..\Source\uesp\Morrow\esm\EsmTES3.h
# End Source File
# Begin Source File

SOURCE=..\..\..\..\Source\uesp\Morrow\esm\EsmWeapon.h
# End Source File
# End Group
# Begin Group "SubRecords."

# PROP Default_Filter ""
# Begin Source File

SOURCE=..\..\..\..\Source\uesp\Morrow\esm\EsmSubAADT.h
# End Source File
# Begin Source File

SOURCE=..\..\..\..\Source\uesp\Morrow\esm\EsmSubAI_A.h
# End Source File
# Begin Source File

SOURCE=..\..\..\..\Source\uesp\Morrow\esm\EsmSubAI_E.h
# End Source File
# Begin Source File

SOURCE=..\..\..\..\Source\uesp\Morrow\esm\EsmSubAI_F.h
# End Source File
# Begin Source File

SOURCE=..\..\..\..\Source\uesp\Morrow\esm\EsmSubAI_T.h
# End Source File
# Begin Source File

SOURCE=..\..\..\..\Source\uesp\Morrow\esm\EsmSubAI_W.h
# End Source File
# Begin Source File

SOURCE=..\..\..\..\Source\uesp\Morrow\esm\EsmSubAIDT.h
# End Source File
# Begin Source File

SOURCE=..\..\..\..\Source\uesp\Morrow\esm\EsmSubALDT.h
# End Source File
# Begin Source File

SOURCE=..\..\..\..\Source\uesp\Morrow\esm\EsmSubAMBI.h
# End Source File
# Begin Source File

SOURCE=..\..\..\..\Source\uesp\Morrow\esm\EsmSubAODT.h
# End Source File
# Begin Source File

SOURCE=..\..\..\..\Source\uesp\Morrow\esm\ESMSubBase.h
# End Source File
# Begin Source File

SOURCE=..\..\..\..\Source\uesp\Morrow\esm\EsmSubBKDT.h
# End Source File
# Begin Source File

SOURCE=..\..\..\..\Source\uesp\Morrow\esm\EsmSubBYDT.h
# End Source File
# Begin Source File

SOURCE=..\..\..\..\Source\uesp\Morrow\esm\EsmSubByte.h
# End Source File
# Begin Source File

SOURCE=..\..\..\..\Source\uesp\Morrow\esm\EsmSubCellDATA.h
# End Source File
# Begin Source File

SOURCE=..\..\..\..\Source\uesp\Morrow\esm\EsmSubCellRef.h
# End Source File
# Begin Source File

SOURCE=..\..\..\..\Source\uesp\Morrow\esm\EsmSubCLDT.h
# End Source File
# Begin Source File

SOURCE=..\..\..\..\Source\uesp\Morrow\esm\EsmSubCNDT.h
# End Source File
# Begin Source File

SOURCE=..\..\..\..\Source\uesp\Morrow\esm\EsmSubCRDT.h
# End Source File
# Begin Source File

SOURCE=..\..\..\..\Source\uesp\Morrow\esm\EsmSubCTDT.h
# End Source File
# Begin Source File

SOURCE=..\..\..\..\Source\uesp\Morrow\esm\EsmSubDATA.h
# End Source File
# Begin Source File

SOURCE=..\..\..\..\Source\uesp\Morrow\esm\EsmSubENAM.h
# End Source File
# Begin Source File

SOURCE=..\..\..\..\Source\uesp\Morrow\esm\EsmSubENDT.h
# End Source File
# Begin Source File

SOURCE=..\..\..\..\Source\uesp\Morrow\esm\EsmSubFADT.h
# End Source File
# Begin Source File

SOURCE=..\..\..\..\Source\uesp\Morrow\esm\EsmSubFloat.h
# End Source File
# Begin Source File

SOURCE=..\..\..\..\Source\uesp\Morrow\esm\EsmSubFRMR.h
# End Source File
# Begin Source File

SOURCE=..\..\..\..\Source\uesp\Morrow\esm\EsmSubHEDR.h
# End Source File
# Begin Source File

SOURCE=..\..\..\..\Source\uesp\Morrow\esm\EsmSubInfoDATA.h
# End Source File
# Begin Source File

SOURCE=..\..\..\..\Source\uesp\Morrow\esm\EsmSubIRDT.h
# End Source File
# Begin Source File

SOURCE=..\..\..\..\Source\uesp\Morrow\esm\EsmSubLHDT.h
# End Source File
# Begin Source File

SOURCE=..\..\..\..\Source\uesp\Morrow\esm\EsmSubLKDT.h
# End Source File
# Begin Source File

SOURCE=..\..\..\..\Source\uesp\Morrow\esm\EsmSubLong.h
# End Source File
# Begin Source File

SOURCE=..\..\..\..\Source\uesp\Morrow\esm\EsmSubLong64.h
# End Source File
# Begin Source File

SOURCE=..\..\..\..\Source\uesp\Morrow\esm\EsmSubMCDT.h
# End Source File
# Begin Source File

SOURCE=..\..\..\..\Source\uesp\Morrow\esm\EsmSubMEDT.h
# End Source File
# Begin Source File

SOURCE=..\..\..\..\Source\uesp\Morrow\esm\EsmSubName.h
# End Source File
# Begin Source File

SOURCE=..\..\..\..\Source\uesp\Morrow\esm\EsmSubName32.h
# End Source File
# Begin Source File

SOURCE=..\..\..\..\Source\uesp\Morrow\esm\EsmSubName512.h
# End Source File
# Begin Source File

SOURCE=..\..\..\..\Source\uesp\Morrow\esm\EsmSubNameFix.h
# End Source File
# Begin Source File

SOURCE=..\..\..\..\Source\uesp\Morrow\esm\EsmSubNPCO.h
# End Source File
# Begin Source File

SOURCE=..\..\..\..\Source\uesp\Morrow\esm\EsmSubNPCS.h
# End Source File
# Begin Source File

SOURCE=..\..\..\..\Source\uesp\Morrow\esm\EsmSubNPDT.h
# End Source File
# Begin Source File

SOURCE=..\..\..\..\Source\uesp\Morrow\esm\EsmSubPBDT.h
# End Source File
# Begin Source File

SOURCE=..\..\..\..\Source\uesp\Morrow\esm\EsmSubPos6.h
# End Source File
# Begin Source File

SOURCE=..\..\..\..\Source\uesp\Morrow\esm\EsmSubRADT.h
# End Source File
# Begin Source File

SOURCE=..\..\..\..\Source\uesp\Morrow\esm\EsmSubRIDT.h
# End Source File
# Begin Source File

SOURCE=..\..\..\..\Source\uesp\Morrow\esm\EsmSubSCHD.h
# End Source File
# Begin Source File

SOURCE=..\..\..\..\Source\uesp\Morrow\esm\EsmSubSCVR.h
# End Source File
# Begin Source File

SOURCE=..\..\..\..\Source\uesp\Morrow\esm\EsmSubShort.h
# End Source File
# Begin Source File

SOURCE=..\..\..\..\Source\uesp\Morrow\esm\EsmSubSKDT.h
# End Source File
# Begin Source File

SOURCE=..\..\..\..\Source\uesp\Morrow\esm\EsmSubSNAM.h
# End Source File
# Begin Source File

SOURCE=..\..\..\..\Source\uesp\Morrow\esm\EsmSubSPDT.h
# End Source File
# Begin Source File

SOURCE=..\..\..\..\Source\uesp\Morrow\esm\EsmSubWEAT.h
# End Source File
# Begin Source File

SOURCE=..\..\..\..\Source\uesp\Morrow\esm\EsmSubWPDT.h
# End Source File
# End Group
# Begin Group "Script1."

# PROP Default_Filter ""
# Begin Source File

SOURCE=.\EsmScrFuncArray.h
# End Source File
# Begin Source File

SOURCE=.\EsmScrFuncData.h
# End Source File
# Begin Source File

SOURCE=.\EsmScriptCompile.h
# End Source File
# Begin Source File

SOURCE=.\EsmScriptDefs.h
# End Source File
# Begin Source File

SOURCE=.\EsmScriptError.h
# End Source File
# Begin Source File

SOURCE=.\EsmScriptOptions.h
# End Source File
# Begin Source File

SOURCE=.\mwcustomfunc.h
# End Source File
# End Group
# Begin Source File

SOURCE=.\EsmCsvDefs.h
# End Source File
# Begin Source File

SOURCE=..\..\..\..\Source\uesp\Morrow\esm\EsmDefs.h
# End Source File
# Begin Source File

SOURCE=..\..\..\..\Source\uesp\Morrow\esm\EsmFile.h
# End Source File
# Begin Source File

SOURCE=.\EsmGlobOptions.h
# End Source File
# Begin Source File

SOURCE=.\EsmOptions.h
# End Source File
# Begin Source File

SOURCE=.\EsmOptionsDef.h
# End Source File
# Begin Source File

SOURCE=.\EsmRegDefs.h
# End Source File
# Begin Source File

SOURCE=.\EsmUtils.h
# End Source File
# Begin Source File

SOURCE=.\mwrecordmap.h
# End Source File
# End Group
# Begin Group "Devil."

# PROP Default_Filter ""
# Begin Source File

SOURCE=..\..\..\DevIL\include\IL\config.h
# End Source File
# Begin Source File

SOURCE=..\..\..\DevIL\include\IL\il.h
# End Source File
# Begin Source File

SOURCE=..\..\..\DevIL\include\IL\ilu.h
# End Source File
# Begin Source File

SOURCE=..\..\..\DevIL\include\IL\ilut.h
# End Source File
# End Group
# Begin Source File

SOURCE=.\MWEdit.h
# End Source File
# Begin Source File

SOURCE=.\MWEditDoc.h
# End Source File
# End Group
# Begin Group "Resource Files"

# PROP Default_Filter "ico;cur;bmp;dlg;rc2;rct;bin;rgs;gif;jpg;jpeg;jpe"
# Begin Source File

SOURCE=.\res\activato.bmp
# End Source File
# Begin Source File

SOURCE=.\res\activato.ico
# End Source File
# Begin Source File

SOURCE=.\res\alchemy.bmp
# End Source File
# Begin Source File

SOURCE=.\res\alchemy.ico
# End Source File
# Begin Source File

SOURCE=.\res\apparatu.ico
# End Source File
# Begin Source File

SOURCE=.\res\armor.ico
# End Source File
# Begin Source File

SOURCE=.\res\armor1.bmp
# End Source File
# Begin Source File

SOURCE=.\res\birthsig.bmp
# End Source File
# Begin Source File

SOURCE=.\res\birthsig.ico
# End Source File
# Begin Source File

SOURCE=.\res\bitmap1.bmp
# End Source File
# Begin Source File

SOURCE=.\res\bluebmp.bmp
# End Source File
# Begin Source File

SOURCE=.\res\bmp00001.bmp
# End Source File
# Begin Source File

SOURCE=.\res\bmp00002.bmp
# End Source File
# Begin Source File

SOURCE=.\res\bmp00003.bmp
# End Source File
# Begin Source File

SOURCE=.\res\bmp00004.bmp
# End Source File
# Begin Source File

SOURCE=.\res\bmp00005.bmp
# End Source File
# Begin Source File

SOURCE=.\res\bmp00006.bmp
# End Source File
# Begin Source File

SOURCE=.\res\bodypart.ico
# End Source File
# Begin Source File

SOURCE=.\res\book.ico
# End Source File
# Begin Source File

SOURCE=.\res\cell.bmp
# End Source File
# Begin Source File

SOURCE=.\res\cell.ico
# End Source File
# Begin Source File

SOURCE=.\res\class.bmp
# End Source File
# Begin Source File

SOURCE=.\res\class.ico
# End Source File
# Begin Source File

SOURCE=.\res\clothing.bmp
# End Source File
# Begin Source File

SOURCE=.\res\clothing.ico
# End Source File
# Begin Source File

SOURCE=.\res\compileb.bmp
# End Source File
# Begin Source File

SOURCE=.\res\containe.bmp
# End Source File
# Begin Source File

SOURCE=.\res\containe.ico
# End Source File
# Begin Source File

SOURCE=.\res\copybmp.bmp
# End Source File
# Begin Source File

SOURCE=.\res\creature.ico
# End Source File
# Begin Source File

SOURCE=.\res\cursor1.cur
# End Source File
# Begin Source File

SOURCE=.\res\cutbmp.bmp
# End Source File
# Begin Source File

SOURCE=.\res\dialog.bmp
# End Source File
# Begin Source File

SOURCE=.\res\dialog.ico
# End Source File
# Begin Source File

SOURCE=.\res\door.bmp
# End Source File
# Begin Source File

SOURCE=.\res\door.ico
# End Source File
# Begin Source File

SOURCE=.\res\door1.bmp
# End Source File
# Begin Source File

SOURCE=.\res\dropbad.bmp
# End Source File
# Begin Source File

SOURCE=.\res\effect.ico
# End Source File
# Begin Source File

SOURCE=.\res\effect1.ico
# End Source File
# Begin Source File

SOURCE=.\res\enchant.ico
# End Source File
# Begin Source File

SOURCE=.\res\faction.bmp
# End Source File
# Begin Source File

SOURCE=.\res\find_dia.bmp
# End Source File
# Begin Source File

SOURCE=.\res\find_dia.ico
# End Source File
# Begin Source File

SOURCE=.\res\findbmp.bmp
# End Source File
# Begin Source File

SOURCE=.\res\funchelp.ico
# End Source File
# Begin Source File

SOURCE=.\res\gamesett.bmp
# End Source File
# Begin Source File

SOURCE=.\res\global.bmp
# End Source File
# Begin Source File

SOURCE=.\res\global.ico
# End Source File
# Begin Source File

SOURCE=.\res\ico00001.ico
# End Source File
# Begin Source File

SOURCE=.\res\ingredia.bmp
# End Source File
# Begin Source File

SOURCE=.\res\ingredia.ico
# End Source File
# Begin Source File

SOURCE=.\res\levelcre.ico
# End Source File
# Begin Source File

SOURCE=.\res\levelite.bmp
# End Source File
# Begin Source File

SOURCE=.\res\levelite.ico
# End Source File
# Begin Source File

SOURCE=.\res\light.bmp
# End Source File
# Begin Source File

SOURCE=.\res\light.ico
# End Source File
# Begin Source File

SOURCE=.\res\light1.ico
# End Source File
# Begin Source File

SOURCE=.\res\lockpick.bmp
# End Source File
# Begin Source File

SOURCE=.\res\lockpick.ico
# End Source File
# Begin Source File

SOURCE=.\res\magiceff.bmp
# End Source File
# Begin Source File

SOURCE=.\res\misc.bmp
# End Source File
# Begin Source File

SOURCE=.\res\misc.ico
# End Source File
# Begin Source File

SOURCE=.\res\MWEdit.ico
# End Source File
# Begin Source File

SOURCE=.\res\MWEdit.rc2
# End Source File
# Begin Source File

SOURCE=.\res\MWEditDoc.ico
# End Source File
# Begin Source File

SOURCE=.\nodrop.cur
# End Source File
# Begin Source File

SOURCE=.\res\npc.bmp
# End Source File
# Begin Source File

SOURCE=.\res\npc.ico
# End Source File
# Begin Source File

SOURCE=.\res\pastebmp.bmp
# End Source File
# Begin Source File

SOURCE=.\res\probe.bmp
# End Source File
# Begin Source File

SOURCE=.\res\probe.ico
# End Source File
# Begin Source File

SOURCE=.\res\race.bmp
# End Source File
# Begin Source File

SOURCE=.\res\race.ico
# End Source File
# Begin Source File

SOURCE=.\res\region.bmp
# End Source File
# Begin Source File

SOURCE=.\res\region.ico
# End Source File
# Begin Source File

SOURCE=.\res\repair.bmp
# End Source File
# Begin Source File

SOURCE=.\res\repair.ico
# End Source File
# Begin Source File

SOURCE=.\res\replaceb.bmp
# End Source File
# Begin Source File

SOURCE=.\res\script.bmp
# End Source File
# Begin Source File

SOURCE=.\res\script1.bmp
# End Source File
# Begin Source File

SOURCE=.\res\script1.ico
# End Source File
# Begin Source File

SOURCE=.\res\setting.ico
# End Source File
# Begin Source File

SOURCE=.\res\skill.bmp
# End Source File
# Begin Source File

SOURCE=.\res\skill.ico
# End Source File
# Begin Source File

SOURCE=.\res\skill1.ico
# End Source File
# Begin Source File

SOURCE=.\res\sound.bmp
# End Source File
# Begin Source File

SOURCE=.\res\sound.ico
# End Source File
# Begin Source File

SOURCE=.\res\sound1.ico
# End Source File
# Begin Source File

SOURCE=.\res\soundgen.bmp
# End Source File
# Begin Source File

SOURCE=.\res\spell.bmp
# End Source File
# Begin Source File

SOURCE=.\res\static.bmp
# End Source File
# Begin Source File

SOURCE=.\res\static.ico
# End Source File
# Begin Source File

SOURCE=.\res\testbitm.bmp
# End Source File
# Begin Source File

SOURCE=.\res\Toolbar.bmp
# End Source File
# Begin Source File

SOURCE=.\res\uses_dia.ico
# End Source File
# Begin Source File

SOURCE=.\res\weapon.bmp
# End Source File
# Begin Source File

SOURCE=.\res\weapon.ico
# End Source File
# Begin Source File

SOURCE=.\res\whitebmp.bmp
# End Source File
# End Group
# Begin Group "Help Files"

# PROP Default_Filter "cnt;rtf"
# Begin Source File

SOURCE=.\hlp\AfxCore.rtf
# End Source File
# Begin Source File

SOURCE=.\hlp\AppExit.bmp
# End Source File
# Begin Source File

SOURCE=.\hlp\Bullet.bmp
# End Source File
# Begin Source File

SOURCE=.\hlp\CurArw2.bmp
# End Source File
# Begin Source File

SOURCE=.\hlp\CurArw4.bmp
# End Source File
# Begin Source File

SOURCE=.\hlp\CurHelp.bmp
# End Source File
# Begin Source File

SOURCE=.\hlp\EditCopy.bmp
# End Source File
# Begin Source File

SOURCE=.\hlp\EditCut.bmp
# End Source File
# Begin Source File

SOURCE=.\hlp\EditPast.bmp
# End Source File
# Begin Source File

SOURCE=.\hlp\EditUndo.bmp
# End Source File
# Begin Source File

SOURCE=.\hlp\FileNew.bmp
# End Source File
# Begin Source File

SOURCE=.\hlp\FileOpen.bmp
# End Source File
# Begin Source File

SOURCE=.\hlp\FilePrnt.bmp
# End Source File
# Begin Source File

SOURCE=.\hlp\FileSave.bmp
# End Source File
# Begin Source File

SOURCE=.\hlp\HlpSBar.bmp
# End Source File
# Begin Source File

SOURCE=.\hlp\HlpTBar.bmp
# End Source File
# Begin Source File

SOURCE=.\hlp\MWEdit.cnt

!IF  "$(CFG)" == "MWEdit - Win32 Release"

# PROP Ignore_Default_Tool 1
# Begin Custom Build - Copying contents file...
OutDir=.\Release
InputPath=.\hlp\MWEdit.cnt
InputName=MWEdit

"$(OutDir)\$(InputName).cnt" : $(SOURCE) "$(INTDIR)" "$(OUTDIR)"
	copy "hlp\$(InputName).cnt" $(OutDir)

# End Custom Build

!ELSEIF  "$(CFG)" == "MWEdit - Win32 Debug"

# PROP Ignore_Default_Tool 1
# Begin Custom Build - Copying contents file...
OutDir=.\Debug
InputPath=.\hlp\MWEdit.cnt
InputName=MWEdit

"$(OutDir)\$(InputName).cnt" : $(SOURCE) "$(INTDIR)" "$(OUTDIR)"
	copy "hlp\$(InputName).cnt" $(OutDir)

# End Custom Build

!ENDIF 

# End Source File
# Begin Source File

SOURCE=.\hlp\RecFirst.bmp
# End Source File
# Begin Source File

SOURCE=.\hlp\RecLast.bmp
# End Source File
# Begin Source File

SOURCE=.\hlp\RecNext.bmp
# End Source File
# Begin Source File

SOURCE=.\hlp\RecPrev.bmp
# End Source File
# Begin Source File

SOURCE=.\hlp\Scmax.bmp
# End Source File
# Begin Source File

SOURCE=.\hlp\ScMenu.bmp
# End Source File
# Begin Source File

SOURCE=.\hlp\Scmin.bmp
# End Source File
# End Group
# Begin Group "Docs"

# PROP Default_Filter ""
# Begin Source File

SOURCE=.\Bugs.txt
# End Source File
# Begin Source File

SOURCE=.\ChangeLog.txt
# End Source File
# Begin Source File

SOURCE=.\docs\Features.txt
# End Source File
# Begin Source File

SOURCE=E:\uesp\morrow\tech\mw_esm.txt
# End Source File
# Begin Source File

SOURCE=.\ReadMe.txt
# End Source File
# Begin Source File

SOURCE=.\docs\scripttests.txt
# End Source File
# Begin Source File

SOURCE=.\ToDo.txt
# End Source File
# Begin Source File

SOURCE=.\docs\UsingHelp.htm
# End Source File
# End Group
# Begin Source File

SOURCE=.\customfunctions.dat
# End Source File
# Begin Source File

SOURCE=.\func1.dat
# End Source File
# Begin Source File

SOURCE=.\Functions.dat
# End Source File
# Begin Source File

SOURCE=.\mwedit.log
# End Source File
# Begin Source File

SOURCE=.\MWEdit.reg
# End Source File
# Begin Source File

SOURCE=.\docs\Stats.txt
# End Source File
# Begin Source File

SOURCE=.\TemplateTest1.txt
# End Source File
# Begin Source File

SOURCE=.\test.csv
# End Source File
# End Target
# End Project

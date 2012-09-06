# Microsoft Developer Studio Project File - Name="MWRandItem" - Package Owner=<4>
# Microsoft Developer Studio Generated Build File, Format Version 6.00
# ** DO NOT EDIT **

# TARGTYPE "Win32 (x86) Application" 0x0101

CFG=MWRandItem - Win32 Debug
!MESSAGE This is not a valid makefile. To build this project using NMAKE,
!MESSAGE use the Export Makefile command and run
!MESSAGE 
!MESSAGE NMAKE /f "MWRandItem.mak".
!MESSAGE 
!MESSAGE You can specify a configuration when running NMAKE
!MESSAGE by defining the macro CFG on the command line. For example:
!MESSAGE 
!MESSAGE NMAKE /f "MWRandItem.mak" CFG="MWRandItem - Win32 Debug"
!MESSAGE 
!MESSAGE Possible choices for configuration are:
!MESSAGE 
!MESSAGE "MWRandItem - Win32 Release" (based on "Win32 (x86) Application")
!MESSAGE "MWRandItem - Win32 Debug" (based on "Win32 (x86) Application")
!MESSAGE 

# Begin Project
# PROP AllowPerConfigDependencies 0
# PROP Scc_ProjName ""
# PROP Scc_LocalPath ""
CPP=cl.exe
MTL=midl.exe
RSC=rc.exe

!IF  "$(CFG)" == "MWRandItem - Win32 Release"

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
# ADD CPP /nologo /MD /W3 /GX /O2 /D "NDEBUG" /D "WIN32" /D "_WINDOWS" /D "_AFXDLL" /D "_MBCS" /D "NO_ESMLIST_EDIT" /FR /Yu"stdafx.h" /FD /c
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

!ELSEIF  "$(CFG)" == "MWRandItem - Win32 Debug"

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
# ADD CPP /nologo /MDd /W3 /Gm /GX /ZI /Od /D "_DEBUG" /D "WIN32" /D "_WINDOWS" /D "_AFXDLL" /D "_MBCS" /D "NO_ESMLIST_EDIT" /FR /Yu"stdafx.h" /FD /GZ /c
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

# Name "MWRandItem - Win32 Release"
# Name "MWRandItem - Win32 Debug"
# Begin Group "Source Files"

# PROP Default_Filter "cpp;c;cxx;rc;def;r;odl;idl;hpj;bat"
# Begin Group "Common"

# PROP Default_Filter ""
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

SOURCE=..\..\..\..\Source\Common\File\genfile.cpp
# SUBTRACT CPP /YX /Yc /Yu
# End Source File
# Begin Source File

SOURCE=..\..\..\..\Source\Common\File\genfind.cpp
# SUBTRACT CPP /YX /Yc /Yu
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

SOURCE=..\..\..\..\Source\Common\tstfile.cpp
# SUBTRACT CPP /YX /Yc /Yu
# End Source File
# Begin Source File

SOURCE=..\..\..\..\Source\Windows\WinUtil.cpp
# End Source File
# End Group
# Begin Group "ESM"

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

SOURCE=..\..\..\..\Source\uesp\Morrow\esm\EsmBase.cpp
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

SOURCE=..\..\..\..\Source\uesp\Morrow\esm\EsmFile.cpp
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
# Begin Source File

SOURCE=..\..\..\..\Source\uesp\Morrow\esm\EsmTES3.cpp
# SUBTRACT CPP /YX /Yc /Yu
# End Source File
# Begin Source File

SOURCE=..\..\..\..\Source\uesp\Morrow\esm\EsmWeapon.cpp
# SUBTRACT CPP /YX /Yc /Yu
# End Source File
# Begin Source File

SOURCE=..\..\..\..\Source\uesp\Morrow\esm\EsmWinUtils.cpp
# End Source File
# End Group
# Begin Group "Forms"

# PROP Default_Filter ""
# Begin Source File

SOURCE=.\CreateView.cpp
# End Source File
# Begin Source File

SOURCE=.\EnchantView.cpp
# End Source File
# Begin Source File

SOURCE=..\MWEdit\EsmListCtrl.cpp
# End Source File
# Begin Source File

SOURCE=.\MWRandItemDlg.cpp
# End Source File
# Begin Source File

SOURCE=.\OutputView.cpp
# End Source File
# Begin Source File

SOURCE=.\WeaponView.cpp
# End Source File
# End Group
# Begin Group "Misc"

# PROP Default_Filter ""
# Begin Source File

SOURCE=.\hlp\MWRandItem.hpj

!IF  "$(CFG)" == "MWRandItem - Win32 Release"

# PROP Ignore_Default_Tool 1
# Begin Custom Build - Making help file...
OutDir=.\Release
InputPath=.\hlp\MWRandItem.hpj
InputName=MWRandItem

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

!ELSEIF  "$(CFG)" == "MWRandItem - Win32 Debug"

# PROP Ignore_Default_Tool 1
# Begin Custom Build - Making help file...
OutDir=.\Debug
InputPath=.\hlp\MWRandItem.hpj
InputName=MWRandItem

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

SOURCE=.\MWRandItem.rc
# End Source File
# Begin Source File

SOURCE=.\StdAfx.cpp
# ADD CPP /Yc"stdafx.h"
# End Source File
# End Group
# Begin Group "Morrowind"

# PROP Default_Filter ""
# Begin Source File

SOURCE=.\MWRandCom.cpp
# ADD CPP /Yu
# End Source File
# Begin Source File

SOURCE=.\MwRandEffects.cpp
# SUBTRACT CPP /YX /Yc /Yu
# End Source File
# Begin Source File

SOURCE=.\MwRandItemGen.cpp
# SUBTRACT CPP /YX /Yc /Yu
# End Source File
# Begin Source File

SOURCE=.\MWRandItemGroup.cpp
# SUBTRACT CPP /YX /Yc /Yu
# End Source File
# Begin Source File

SOURCE=.\MWRandItems.cpp
# SUBTRACT CPP /YX /Yc /Yu
# End Source File
# Begin Source File

SOURCE=.\MWRandLList.cpp
# SUBTRACT CPP /YX /Yc /Yu
# End Source File
# Begin Source File

SOURCE=.\MwRandUniques.cpp
# SUBTRACT CPP /YX /Yc /Yu
# End Source File
# End Group
# Begin Source File

SOURCE=.\MWRandItem.cpp
# End Source File
# End Group
# Begin Group "Header Files"

# PROP Default_Filter "h;hpp;hxx;hm;inl"
# Begin Group "Common."

# PROP Default_Filter ""
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

SOURCE=..\..\..\..\Source\Common\File\genfile.h
# End Source File
# Begin Source File

SOURCE=..\..\..\..\Source\Common\File\genfind.h
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

SOURCE=..\..\..\..\Source\Windows\winutil.h
# End Source File
# End Group
# Begin Group "ESM."

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

SOURCE=..\..\..\..\Source\uesp\Morrow\esm\EsmDefs.h
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

SOURCE=..\..\..\..\Source\uesp\Morrow\esm\EsmFile.h
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
# Begin Source File

SOURCE=..\..\..\..\Source\uesp\Morrow\esm\EsmTES3.h
# End Source File
# Begin Source File

SOURCE=..\..\..\..\Source\uesp\Morrow\esm\EsmWeapon.h
# End Source File
# Begin Source File

SOURCE=..\..\..\..\Source\uesp\Morrow\esm\EsmWinUtils.h
# End Source File
# End Group
# Begin Group "Forms."

# PROP Default_Filter ""
# Begin Source File

SOURCE=.\CreateView.h
# End Source File
# Begin Source File

SOURCE=.\EnchantView.h
# End Source File
# Begin Source File

SOURCE=..\MWEdit\EsmListCtrl.h
# End Source File
# Begin Source File

SOURCE=.\MWRandItemDlg.h
# End Source File
# Begin Source File

SOURCE=.\OutputView.h
# End Source File
# Begin Source File

SOURCE=.\WeaponView.h
# End Source File
# End Group
# Begin Group "Misc."

# PROP Default_Filter ""
# Begin Source File

SOURCE=.\Resource.h

!IF  "$(CFG)" == "MWRandItem - Win32 Release"

# PROP Ignore_Default_Tool 1
# Begin Custom Build - Making help include file...
TargetName=MWRandItem
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

!ELSEIF  "$(CFG)" == "MWRandItem - Win32 Debug"

# PROP Ignore_Default_Tool 1
# Begin Custom Build - Making help include file...
TargetName=MWRandItem
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

SOURCE=.\StdAfx.h
# End Source File
# End Group
# Begin Group "Morrowind."

# PROP Default_Filter ""
# Begin Source File

SOURCE=.\MWRandCom.h
# End Source File
# Begin Source File

SOURCE=.\MWRandEffects.h
# End Source File
# Begin Source File

SOURCE=.\MwRandItemGen.h
# End Source File
# Begin Source File

SOURCE=.\MWRandItemGroup.h
# End Source File
# Begin Source File

SOURCE=.\MWRandItems.h
# End Source File
# Begin Source File

SOURCE=.\MwRandLList.h
# End Source File
# Begin Source File

SOURCE=.\MwRandUniques.h
# End Source File
# End Group
# Begin Source File

SOURCE=.\MWRandItem.h
# End Source File
# End Group
# Begin Group "Resource Files"

# PROP Default_Filter "ico;cur;bmp;dlg;rc2;rct;bin;rgs;gif;jpg;jpeg;jpe"
# Begin Source File

SOURCE=.\res\MWRandItem.ico
# End Source File
# Begin Source File

SOURCE=.\res\MWRandItem.rc2
# End Source File
# End Group
# Begin Group "Help Files"

# PROP Default_Filter "cnt;rtf"
# Begin Source File

SOURCE=.\hlp\AfxDlg.rtf
# End Source File
# Begin Source File

SOURCE=.\hlp\MWRandItem.cnt

!IF  "$(CFG)" == "MWRandItem - Win32 Release"

# PROP Ignore_Default_Tool 1
# Begin Custom Build - Copying contents file...
OutDir=.\Release
InputPath=.\hlp\MWRandItem.cnt
InputName=MWRandItem

"$(OutDir)\$(InputName).cnt" : $(SOURCE) "$(INTDIR)" "$(OUTDIR)"
	copy "hlp\$(InputName).cnt" $(OutDir)

# End Custom Build

!ELSEIF  "$(CFG)" == "MWRandItem - Win32 Debug"

# PROP Ignore_Default_Tool 1
# Begin Custom Build - Copying contents file...
OutDir=.\Debug
InputPath=.\hlp\MWRandItem.cnt
InputName=MWRandItem

"$(OutDir)\$(InputName).cnt" : $(SOURCE) "$(INTDIR)" "$(OUTDIR)"
	copy "hlp\$(InputName).cnt" $(OutDir)

# End Custom Build

!ENDIF 

# End Source File
# End Group
# Begin Source File

SOURCE=.\baseitems.dat
# End Source File
# Begin Source File

SOURCE=.\effects.dat
# End Source File
# Begin Source File

SOURCE=.\Effects.txt
# End Source File
# Begin Source File

SOURCE=.\levellists.dat
# End Source File
# Begin Source File

SOURCE=E:\uesp\morrow\tech\mw_esm.txt
# End Source File
# Begin Source File

SOURCE=.\MWRandItem.log
# End Source File
# Begin Source File

SOURCE=.\MWRandItem.txt
# End Source File
# Begin Source File

SOURCE=.\ReadMe.txt
# End Source File
# Begin Source File

SOURCE=.\sample.dat
# End Source File
# Begin Source File

SOURCE=.\uniques.dat
# End Source File
# End Target
# End Project

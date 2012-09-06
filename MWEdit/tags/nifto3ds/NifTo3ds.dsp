# Microsoft Developer Studio Project File - Name="NifTo3ds" - Package Owner=<4>
# Microsoft Developer Studio Generated Build File, Format Version 6.00
# ** DO NOT EDIT **

# TARGTYPE "Win32 (x86) Application" 0x0101

CFG=NifTo3ds - Win32 Debug
!MESSAGE This is not a valid makefile. To build this project using NMAKE,
!MESSAGE use the Export Makefile command and run
!MESSAGE 
!MESSAGE NMAKE /f "NifTo3ds.mak".
!MESSAGE 
!MESSAGE You can specify a configuration when running NMAKE
!MESSAGE by defining the macro CFG on the command line. For example:
!MESSAGE 
!MESSAGE NMAKE /f "NifTo3ds.mak" CFG="NifTo3ds - Win32 Debug"
!MESSAGE 
!MESSAGE Possible choices for configuration are:
!MESSAGE 
!MESSAGE "NifTo3ds - Win32 Release" (based on "Win32 (x86) Application")
!MESSAGE "NifTo3ds - Win32 Debug" (based on "Win32 (x86) Application")
!MESSAGE 

# Begin Project
# PROP AllowPerConfigDependencies 0
# PROP Scc_ProjName ""
# PROP Scc_LocalPath ""
CPP=cl.exe
MTL=midl.exe
RSC=rc.exe

!IF  "$(CFG)" == "NifTo3ds - Win32 Release"

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
# ADD CPP /nologo /MD /W3 /GX /O2 /D "WIN32" /D "NDEBUG" /D "_WINDOWS" /D "_AFXDLL" /D "_MBCS" /Yu"stdafx.h" /FD /c
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

!ELSEIF  "$(CFG)" == "NifTo3ds - Win32 Debug"

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
# ADD CPP /nologo /MDd /W3 /Gm /GX /ZI /Od /D "WIN32" /D "_DEBUG" /D "_WINDOWS" /D "_AFXDLL" /D "_MBCS" /FR /Yu"stdafx.h" /FD /GZ /c
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

# Name "NifTo3ds - Win32 Release"
# Name "NifTo3ds - Win32 Debug"
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

SOURCE=..\..\..\..\Source\uesp\Morrow\mwcommon.cpp
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

SOURCE=..\..\..\..\Source\Common\tstfile.cpp
# SUBTRACT CPP /YX /Yc /Yu
# End Source File
# Begin Source File

SOURCE=..\..\..\..\Source\Windows\WinUtil.cpp
# End Source File
# End Group
# Begin Group "NIF"

# PROP Default_Filter ""
# Begin Source File

SOURCE=..\..\..\..\Source\uesp\Morrow\NIF\NifAlphaProperty.cpp
# ADD CPP /Yu
# End Source File
# Begin Source File

SOURCE=..\..\..\..\Source\uesp\Morrow\NIF\NifAmbientLight.cpp
# ADD CPP /Yu
# End Source File
# Begin Source File

SOURCE=..\..\..\..\Source\uesp\Morrow\NIF\NifAutoNormalParticles.cpp
# ADD CPP /Yu
# End Source File
# Begin Source File

SOURCE=..\..\..\..\Source\uesp\Morrow\NIF\NifAutoNormalParticlesData.cpp
# ADD CPP /Yu
# End Source File
# Begin Source File

SOURCE=..\..\..\..\Source\uesp\Morrow\NIF\NifBase.cpp
# ADD CPP /Yu
# End Source File
# Begin Source File

SOURCE=..\..\..\..\Source\uesp\Morrow\NIF\NifBillboardNode.cpp
# ADD CPP /Yu
# End Source File
# Begin Source File

SOURCE=..\..\..\..\Source\uesp\Morrow\NIF\NifBsAnimationNode.cpp
# ADD CPP /Yu
# End Source File
# Begin Source File

SOURCE=..\..\..\..\Source\uesp\Morrow\NIF\NifBSPArrayController.cpp
# ADD CPP /Yu
# End Source File
# Begin Source File

SOURCE=..\..\..\..\Source\uesp\Morrow\NIF\NifCamera.cpp
# ADD CPP /Yu
# End Source File
# Begin Source File

SOURCE=..\..\..\..\Source\uesp\Morrow\NIF\NifColorData.cpp
# ADD CPP /Yu
# End Source File
# Begin Source File

SOURCE=..\..\..\..\Source\uesp\Morrow\NIF\NifDirectionalLight.cpp
# ADD CPP /Yu
# End Source File
# Begin Source File

SOURCE=..\..\..\..\Source\uesp\Morrow\NIF\NifEndFile.cpp
# ADD CPP /Yu
# End Source File
# Begin Source File

SOURCE=..\..\..\..\Source\uesp\Morrow\NIF\NifEOF.cpp
# ADD CPP /Yu
# End Source File
# Begin Source File

SOURCE=..\..\..\..\Source\uesp\Morrow\NIF\NifFile.cpp
# ADD CPP /Yu
# End Source File
# Begin Source File

SOURCE=..\..\..\..\Source\uesp\Morrow\NIF\NifFloatArray.cpp
# ADD CPP /Yu
# End Source File
# Begin Source File

SOURCE=..\..\..\..\Source\uesp\Morrow\NIF\NifFloatData.cpp
# ADD CPP /Yu
# End Source File
# Begin Source File

SOURCE=..\..\..\..\Source\uesp\Morrow\NIF\NifGeomMorpherController.cpp
# ADD CPP /Yu
# End Source File
# Begin Source File

SOURCE=..\..\..\..\Source\uesp\Morrow\NIF\NifGravity.cpp
# ADD CPP /Yu
# End Source File
# Begin Source File

SOURCE=..\..\..\..\Source\uesp\Morrow\NIF\NifKeyFrameController.cpp
# ADD CPP /Yu
# End Source File
# Begin Source File

SOURCE=..\..\..\..\Source\uesp\Morrow\NIF\NifKeyFrameData.cpp
# ADD CPP /Yu
# End Source File
# Begin Source File

SOURCE=..\..\..\..\Source\uesp\Morrow\NIF\NifLongArray.cpp
# ADD CPP /Yu
# End Source File
# Begin Source File

SOURCE=..\..\..\..\Source\uesp\Morrow\NIF\NifMaterialProperty.cpp
# ADD CPP /Yu
# End Source File
# Begin Source File

SOURCE=..\..\..\..\Source\uesp\Morrow\NIF\NifMorphData.cpp
# ADD CPP /Yu
# End Source File
# Begin Source File

SOURCE=..\..\..\..\Source\uesp\Morrow\NIF\NifNode.cpp
# ADD CPP /Yu
# End Source File
# Begin Source File

SOURCE=..\..\..\..\Source\uesp\Morrow\NIF\NifParticleColorModifier.cpp
# ADD CPP /Yu
# End Source File
# Begin Source File

SOURCE=..\..\..\..\Source\uesp\Morrow\NIF\NifParticleGrowFade.cpp
# ADD CPP /Yu
# End Source File
# Begin Source File

SOURCE=..\..\..\..\Source\uesp\Morrow\NIF\NifParticleNode.cpp
# ADD CPP /Yu
# End Source File
# Begin Source File

SOURCE=..\..\..\..\Source\uesp\Morrow\NIF\NifParticleRotation.cpp
# ADD CPP /Yu
# End Source File
# Begin Source File

SOURCE=..\..\..\..\Source\uesp\Morrow\NIF\NifParticleSysController.cpp
# ADD CPP /Yu
# End Source File
# Begin Source File

SOURCE=..\..\..\..\Source\uesp\Morrow\NIF\NifPathController.cpp
# ADD CPP /Yu
# End Source File
# Begin Source File

SOURCE=..\..\..\..\Source\uesp\Morrow\NIF\NifPixelData.cpp
# ADD CPP /Yu
# End Source File
# Begin Source File

SOURCE=..\..\..\..\Source\uesp\Morrow\NIF\NifPosData.cpp
# ADD CPP /Yu
# End Source File
# Begin Source File

SOURCE=..\..\..\..\Source\uesp\Morrow\NIF\NifRootCollisionNode.cpp
# ADD CPP /Yu
# End Source File
# Begin Source File

SOURCE=..\..\..\..\Source\uesp\Morrow\NIF\NifRotatingParticles.cpp
# ADD CPP /Yu
# End Source File
# Begin Source File

SOURCE=..\..\..\..\Source\uesp\Morrow\NIF\NifRotatingParticlesData.cpp
# ADD CPP /Yu
# End Source File
# Begin Source File

SOURCE=..\..\..\..\Source\uesp\Morrow\NIF\NifShadeProperty.cpp
# ADD CPP /Yu
# End Source File
# Begin Source File

SOURCE=..\..\..\..\Source\uesp\Morrow\NIF\NifSkinData.cpp
# ADD CPP /Yu
# End Source File
# Begin Source File

SOURCE=..\..\..\..\Source\uesp\Morrow\NIF\NifSkinInstance.cpp
# ADD CPP /Yu
# End Source File
# Begin Source File

SOURCE=..\..\..\..\Source\uesp\Morrow\NIF\NifSourceTexture.cpp
# ADD CPP /Yu
# End Source File
# Begin Source File

SOURCE=..\..\..\..\Source\uesp\Morrow\NIF\NifStringData.cpp
# ADD CPP /Yu
# End Source File
# Begin Source File

SOURCE=..\..\..\..\Source\uesp\Morrow\NIF\NifTextKeyExtraData.cpp
# ADD CPP /Yu
# End Source File
# Begin Source File

SOURCE=..\..\..\..\Source\uesp\Morrow\NIF\NifTextureEffect.cpp
# ADD CPP /Yu
# End Source File
# Begin Source File

SOURCE=..\..\..\..\Source\uesp\Morrow\NIF\NifTextureProperty.cpp
# ADD CPP /Yu
# End Source File
# Begin Source File

SOURCE=..\..\..\..\Source\uesp\Morrow\NIF\NifTriShape.cpp
# ADD CPP /Yu
# End Source File
# Begin Source File

SOURCE=..\..\..\..\Source\uesp\Morrow\NIF\NifTriShapeData.cpp
# ADD CPP /Yu
# End Source File
# Begin Source File

SOURCE=..\..\..\..\Source\uesp\Morrow\NIF\NifUVController.cpp
# ADD CPP /Yu
# End Source File
# Begin Source File

SOURCE=..\..\..\..\Source\uesp\Morrow\NIF\NifUVData.cpp
# ADD CPP /Yu
# End Source File
# Begin Source File

SOURCE=..\..\..\..\Source\uesp\Morrow\NIF\NifVertexColorProperty.cpp
# ADD CPP /Yu
# End Source File
# Begin Source File

SOURCE=..\..\..\..\Source\uesp\Morrow\NIF\NifVertWeightsExtraData.cpp
# ADD CPP /Yu
# End Source File
# Begin Source File

SOURCE=..\..\..\..\Source\uesp\Morrow\NIF\NifVisController.cpp
# ADD CPP /Yu
# End Source File
# Begin Source File

SOURCE=..\..\..\..\Source\uesp\Morrow\NIF\NifVisData.cpp
# ADD CPP /Yu
# End Source File
# Begin Source File

SOURCE=..\..\..\..\Source\uesp\Morrow\NIF\NifWireframeProperty.cpp
# ADD CPP /Yu
# End Source File
# Begin Source File

SOURCE=..\..\..\..\Source\uesp\Morrow\NIF\NifZBufferProperty.cpp
# ADD CPP /Yu
# End Source File
# End Group
# Begin Group "3dsLib"

# PROP Default_Filter ""
# Begin Source File

SOURCE=..\..\..\Library\3dslib\LIB\FTKVC40.LIB

!IF  "$(CFG)" == "NifTo3ds - Win32 Release"

!ELSEIF  "$(CFG)" == "NifTo3ds - Win32 Debug"

# PROP Exclude_From_Build 1

!ENDIF 

# End Source File
# Begin Source File

SOURCE=..\..\..\Library\3dslib\LIB\FTKVC40D.LIB

!IF  "$(CFG)" == "NifTo3ds - Win32 Release"

# PROP Exclude_From_Build 1

!ELSEIF  "$(CFG)" == "NifTo3ds - Win32 Debug"

!ENDIF 

# End Source File
# End Group
# Begin Source File

SOURCE=.\ConvertNif3ds.cpp
# ADD CPP /Yu
# End Source File
# Begin Source File

SOURCE=.\NifTo3ds.cpp
# End Source File
# Begin Source File

SOURCE=.\hlp\NifTo3ds.hpj

!IF  "$(CFG)" == "NifTo3ds - Win32 Release"

# PROP Ignore_Default_Tool 1
# Begin Custom Build - Making help file...
OutDir=.\Release
InputPath=.\hlp\NifTo3ds.hpj
InputName=NifTo3ds

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

!ELSEIF  "$(CFG)" == "NifTo3ds - Win32 Debug"

# PROP Ignore_Default_Tool 1
# Begin Custom Build - Making help file...
OutDir=.\Debug
InputPath=.\hlp\NifTo3ds.hpj
InputName=NifTo3ds

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

SOURCE=.\NifTo3ds.rc
# End Source File
# Begin Source File

SOURCE=.\NifTo3dsDlg.cpp
# End Source File
# Begin Source File

SOURCE=.\StdAfx.cpp
# ADD CPP /Yc"stdafx.h"
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

SOURCE=..\..\..\..\Source\uesp\Morrow\mwcommon.h
# End Source File
# Begin Source File

SOURCE=..\..\..\..\Source\Common\Contain\ptrarray.h
# End Source File
# Begin Source File

SOURCE=..\..\..\..\Source\Common\String\sstring.h
# End Source File
# Begin Source File

SOURCE=..\..\..\..\Source\Windows\winutil.h
# End Source File
# End Group
# Begin Group "NIF."

# PROP Default_Filter ""
# Begin Source File

SOURCE=..\..\..\..\Source\uesp\Morrow\NIF\NifAlphaProperty.h
# End Source File
# Begin Source File

SOURCE=..\..\..\..\Source\uesp\Morrow\NIF\NifAmbientLight.h
# End Source File
# Begin Source File

SOURCE=..\..\..\..\Source\uesp\Morrow\NIF\NifAutoNormalParticles.h
# End Source File
# Begin Source File

SOURCE=..\..\..\..\Source\uesp\Morrow\NIF\NifAutoNormalParticlesData.h
# End Source File
# Begin Source File

SOURCE=..\..\..\..\Source\uesp\Morrow\NIF\NifBase.h
# End Source File
# Begin Source File

SOURCE=..\..\..\..\Source\uesp\Morrow\NIF\NifBillboardNode.h
# End Source File
# Begin Source File

SOURCE=..\..\..\..\Source\uesp\Morrow\NIF\NifBSAnimationNode.h
# End Source File
# Begin Source File

SOURCE=..\..\..\..\Source\uesp\Morrow\NIF\NifBSPArrayController.h
# End Source File
# Begin Source File

SOURCE=..\..\..\..\Source\uesp\Morrow\NIF\NifCamera.h
# End Source File
# Begin Source File

SOURCE=..\..\..\..\Source\uesp\Morrow\NIF\NifColorData.h
# End Source File
# Begin Source File

SOURCE=..\..\..\..\Source\uesp\Morrow\NIF\NifDirectionalLight.h
# End Source File
# Begin Source File

SOURCE=..\..\..\..\Source\uesp\Morrow\NIF\NifEndFile.h
# End Source File
# Begin Source File

SOURCE=..\..\..\..\Source\uesp\Morrow\NIF\NifEOF.h
# End Source File
# Begin Source File

SOURCE=..\..\..\..\Source\uesp\Morrow\NIF\niffile.h
# End Source File
# Begin Source File

SOURCE=..\..\..\..\Source\uesp\Morrow\NIF\NifFloatArray.h
# End Source File
# Begin Source File

SOURCE=..\..\..\..\Source\uesp\Morrow\NIF\NifFloatData.h
# End Source File
# Begin Source File

SOURCE=..\..\..\..\Source\uesp\Morrow\NIF\NifGeomMorpherController.h
# End Source File
# Begin Source File

SOURCE=..\..\..\..\Source\uesp\Morrow\NIF\NifGravity.h
# End Source File
# Begin Source File

SOURCE=..\..\..\..\Source\uesp\Morrow\NIF\NifKeyFrameController.h
# End Source File
# Begin Source File

SOURCE=..\..\..\..\Source\uesp\Morrow\NIF\NifKeyFrameData.h
# End Source File
# Begin Source File

SOURCE=..\..\..\..\Source\uesp\Morrow\NIF\NifLongArray.h
# End Source File
# Begin Source File

SOURCE=..\..\..\..\Source\uesp\Morrow\NIF\NifMaterialProperty.h
# End Source File
# Begin Source File

SOURCE=..\..\..\..\Source\uesp\Morrow\NIF\NifMorphData.h
# End Source File
# Begin Source File

SOURCE=..\..\..\..\Source\uesp\Morrow\NIF\NifNode.h
# End Source File
# Begin Source File

SOURCE=..\..\..\..\Source\uesp\Morrow\NIF\NifParticleColorModifier.h
# End Source File
# Begin Source File

SOURCE=..\..\..\..\Source\uesp\Morrow\NIF\NifParticleGrowFade.h
# End Source File
# Begin Source File

SOURCE=..\..\..\..\Source\uesp\Morrow\NIF\NifParticleNode.h
# End Source File
# Begin Source File

SOURCE=..\..\..\..\Source\uesp\Morrow\NIF\NifParticleRotation.h
# End Source File
# Begin Source File

SOURCE=..\..\..\..\Source\uesp\Morrow\NIF\NifParticleSysController.h
# End Source File
# Begin Source File

SOURCE=..\..\..\..\Source\uesp\Morrow\NIF\NifPathController.h
# End Source File
# Begin Source File

SOURCE=..\..\..\..\Source\uesp\Morrow\NIF\NifPixelData.h
# End Source File
# Begin Source File

SOURCE=..\..\..\..\Source\uesp\Morrow\NIF\NifPosData.h
# End Source File
# Begin Source File

SOURCE=..\..\..\..\Source\uesp\Morrow\NIF\NifRootCollisonNode.h
# End Source File
# Begin Source File

SOURCE=..\..\..\..\Source\uesp\Morrow\NIF\NifRotatingParticles.h
# End Source File
# Begin Source File

SOURCE=..\..\..\..\Source\uesp\Morrow\NIF\NifRotatingParticlesData.h
# End Source File
# Begin Source File

SOURCE=..\..\..\..\Source\uesp\Morrow\NIF\NifShadeProperty.h
# End Source File
# Begin Source File

SOURCE=..\..\..\..\Source\uesp\Morrow\NIF\NifSkinData.h
# End Source File
# Begin Source File

SOURCE=..\..\..\..\Source\uesp\Morrow\NIF\NifSkinInstance.h
# End Source File
# Begin Source File

SOURCE=..\..\..\..\Source\uesp\Morrow\NIF\NifSourceTexture.h
# End Source File
# Begin Source File

SOURCE=..\..\..\..\Source\uesp\Morrow\NIF\NifStringData.h
# End Source File
# Begin Source File

SOURCE=..\..\..\..\Source\uesp\Morrow\NIF\NifTextKeyExtraData.h
# End Source File
# Begin Source File

SOURCE=..\..\..\..\Source\uesp\Morrow\NIF\NifTextureEffect.h
# End Source File
# Begin Source File

SOURCE=..\..\..\..\Source\uesp\Morrow\NIF\NifTextureProperty.h
# End Source File
# Begin Source File

SOURCE=..\..\..\..\Source\uesp\Morrow\NIF\NifTriShape.h
# End Source File
# Begin Source File

SOURCE=..\..\..\..\Source\uesp\Morrow\NIF\NifTriShapeData.h
# End Source File
# Begin Source File

SOURCE=..\..\..\..\Source\uesp\Morrow\NIF\NifTypes.h
# End Source File
# Begin Source File

SOURCE=..\..\..\..\Source\uesp\Morrow\NIF\NifUVController.h
# End Source File
# Begin Source File

SOURCE=..\..\..\..\Source\uesp\Morrow\NIF\NifUVData.h
# End Source File
# Begin Source File

SOURCE=..\..\..\..\Source\uesp\Morrow\NIF\NifVertexColorProperty.h
# End Source File
# Begin Source File

SOURCE=..\..\..\..\Source\uesp\Morrow\NIF\NifVertWeightsExtraData.h
# End Source File
# Begin Source File

SOURCE=..\..\..\..\Source\uesp\Morrow\NIF\NifVisController.h
# End Source File
# Begin Source File

SOURCE=..\..\..\..\Source\uesp\Morrow\NIF\NifVisData.h
# End Source File
# Begin Source File

SOURCE=..\..\..\..\Source\uesp\Morrow\NIF\NifWireFrameProperty.h
# End Source File
# Begin Source File

SOURCE=..\..\..\..\Source\uesp\Morrow\NIF\NifZBufferProperty.h
# End Source File
# End Group
# Begin Group "3dsLib."

# PROP Default_Filter ""
# Begin Source File

SOURCE=..\..\..\Library\3dslib\INC\3DSFTK.H
# End Source File
# End Group
# Begin Source File

SOURCE=.\ConvertNif3ds.h
# End Source File
# Begin Source File

SOURCE=.\NifTo3ds.h
# End Source File
# Begin Source File

SOURCE=.\NifTo3dsDlg.h
# End Source File
# Begin Source File

SOURCE=.\Resource.h

!IF  "$(CFG)" == "NifTo3ds - Win32 Release"

# PROP Ignore_Default_Tool 1
# Begin Custom Build - Making help include file...
TargetName=NifTo3ds
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

!ELSEIF  "$(CFG)" == "NifTo3ds - Win32 Debug"

# PROP Ignore_Default_Tool 1
# Begin Custom Build - Making help include file...
TargetName=NifTo3ds
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
# Begin Group "Resource Files"

# PROP Default_Filter "ico;cur;bmp;dlg;rc2;rct;bin;rgs;gif;jpg;jpeg;jpe"
# Begin Source File

SOURCE=.\res\NifTo3ds.ico
# End Source File
# Begin Source File

SOURCE=.\res\NifTo3ds.rc2
# End Source File
# End Group
# Begin Group "Help Files"

# PROP Default_Filter "cnt;rtf"
# Begin Source File

SOURCE=.\hlp\AfxDlg.rtf
# End Source File
# Begin Source File

SOURCE=.\hlp\NifTo3ds.cnt

!IF  "$(CFG)" == "NifTo3ds - Win32 Release"

# PROP Ignore_Default_Tool 1
# Begin Custom Build - Copying contents file...
OutDir=.\Release
InputPath=.\hlp\NifTo3ds.cnt
InputName=NifTo3ds

"$(OutDir)\$(InputName).cnt" : $(SOURCE) "$(INTDIR)" "$(OUTDIR)"
	copy "hlp\$(InputName).cnt" $(OutDir)

# End Custom Build

!ELSEIF  "$(CFG)" == "NifTo3ds - Win32 Debug"

# PROP Ignore_Default_Tool 1
# Begin Custom Build - Copying contents file...
OutDir=.\Debug
InputPath=.\hlp\NifTo3ds.cnt
InputName=NifTo3ds

"$(OutDir)\$(InputName).cnt" : $(SOURCE) "$(INTDIR)" "$(OUTDIR)"
	copy "hlp\$(InputName).cnt" $(OutDir)

# End Custom Build

!ENDIF 

# End Source File
# End Group
# Begin Source File

SOURCE=..\NifTexture\NifFormat.txt
# End Source File
# Begin Source File

SOURCE=.\ReadMe.txt
# End Source File
# Begin Source File

SOURCE=.\ToDo.txt
# End Source File
# End Target
# End Project

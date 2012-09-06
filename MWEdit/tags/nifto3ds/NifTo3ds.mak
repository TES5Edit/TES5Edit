# Microsoft Developer Studio Generated NMAKE File, Based on NifTo3ds.dsp
!IF "$(CFG)" == ""
CFG=NifTo3ds - Win32 Debug
!MESSAGE No configuration specified. Defaulting to NifTo3ds - Win32 Debug.
!ENDIF 

!IF "$(CFG)" != "NifTo3ds - Win32 Release" && "$(CFG)" != "NifTo3ds - Win32 Debug"
!MESSAGE Invalid configuration "$(CFG)" specified.
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
!ERROR An invalid configuration is specified.
!ENDIF 

!IF "$(OS)" == "Windows_NT"
NULL=
!ELSE 
NULL=nul
!ENDIF 

!IF  "$(CFG)" == "NifTo3ds - Win32 Release"

OUTDIR=.\Release
INTDIR=.\Release
# Begin Custom Macros
OutDir=.\Release
# End Custom Macros

ALL : ".\hlp\NifTo3ds.hm" ".\Release\NifTo3ds.hlp" ".\Release\NifTo3ds.cnt" "$(OUTDIR)\NifTo3ds.exe"


CLEAN :
	-@erase "$(INTDIR)\ConvertNif3ds.obj"
	-@erase "$(INTDIR)\dl_base.obj"
	-@erase "$(INTDIR)\dl_block.obj"
	-@erase "$(INTDIR)\dl_chr.obj"
	-@erase "$(INTDIR)\dl_err.obj"
	-@erase "$(INTDIR)\dl_file.obj"
	-@erase "$(INTDIR)\dl_log.obj"
	-@erase "$(INTDIR)\dl_math.obj"
	-@erase "$(INTDIR)\dl_mem.obj"
	-@erase "$(INTDIR)\dl_str.obj"
	-@erase "$(INTDIR)\dl_time.obj"
	-@erase "$(INTDIR)\genfile.obj"
	-@erase "$(INTDIR)\genfind.obj"
	-@erase "$(INTDIR)\NifAlphaProperty.obj"
	-@erase "$(INTDIR)\NifAmbientLight.obj"
	-@erase "$(INTDIR)\NifAutoNormalParticles.obj"
	-@erase "$(INTDIR)\NifAutoNormalParticlesData.obj"
	-@erase "$(INTDIR)\NifBase.obj"
	-@erase "$(INTDIR)\NifBillboardNode.obj"
	-@erase "$(INTDIR)\NifBsAnimationNode.obj"
	-@erase "$(INTDIR)\NifBSPArrayController.obj"
	-@erase "$(INTDIR)\NifCamera.obj"
	-@erase "$(INTDIR)\NifColorData.obj"
	-@erase "$(INTDIR)\NifDirectionalLight.obj"
	-@erase "$(INTDIR)\NifEndFile.obj"
	-@erase "$(INTDIR)\NifEOF.obj"
	-@erase "$(INTDIR)\NifFile.obj"
	-@erase "$(INTDIR)\NifFloatArray.obj"
	-@erase "$(INTDIR)\NifFloatData.obj"
	-@erase "$(INTDIR)\NifGeomMorpherController.obj"
	-@erase "$(INTDIR)\NifGravity.obj"
	-@erase "$(INTDIR)\NifKeyFrameController.obj"
	-@erase "$(INTDIR)\NifKeyFrameData.obj"
	-@erase "$(INTDIR)\NifLongArray.obj"
	-@erase "$(INTDIR)\NifMaterialProperty.obj"
	-@erase "$(INTDIR)\NifMorphData.obj"
	-@erase "$(INTDIR)\NifNode.obj"
	-@erase "$(INTDIR)\NifParticleColorModifier.obj"
	-@erase "$(INTDIR)\NifParticleGrowFade.obj"
	-@erase "$(INTDIR)\NifParticleNode.obj"
	-@erase "$(INTDIR)\NifParticleRotation.obj"
	-@erase "$(INTDIR)\NifParticleSysController.obj"
	-@erase "$(INTDIR)\NifPathController.obj"
	-@erase "$(INTDIR)\NifPixelData.obj"
	-@erase "$(INTDIR)\NifPosData.obj"
	-@erase "$(INTDIR)\NifRootCollisionNode.obj"
	-@erase "$(INTDIR)\NifRotatingParticles.obj"
	-@erase "$(INTDIR)\NifRotatingParticlesData.obj"
	-@erase "$(INTDIR)\NifShadeProperty.obj"
	-@erase "$(INTDIR)\NifSkinData.obj"
	-@erase "$(INTDIR)\NifSkinInstance.obj"
	-@erase "$(INTDIR)\NifSourceTexture.obj"
	-@erase "$(INTDIR)\NifStringData.obj"
	-@erase "$(INTDIR)\NifTextKeyExtraData.obj"
	-@erase "$(INTDIR)\NifTextureEffect.obj"
	-@erase "$(INTDIR)\NifTextureProperty.obj"
	-@erase "$(INTDIR)\NifTo3ds.obj"
	-@erase "$(INTDIR)\NifTo3ds.pch"
	-@erase "$(INTDIR)\NifTo3ds.res"
	-@erase "$(INTDIR)\NifTo3dsDlg.obj"
	-@erase "$(INTDIR)\NifTriShape.obj"
	-@erase "$(INTDIR)\NifTriShapeData.obj"
	-@erase "$(INTDIR)\NifUVController.obj"
	-@erase "$(INTDIR)\NifUVData.obj"
	-@erase "$(INTDIR)\NifVertexColorProperty.obj"
	-@erase "$(INTDIR)\NifVertWeightsExtraData.obj"
	-@erase "$(INTDIR)\NifVisController.obj"
	-@erase "$(INTDIR)\NifVisData.obj"
	-@erase "$(INTDIR)\NifWireframeProperty.obj"
	-@erase "$(INTDIR)\NifZBufferProperty.obj"
	-@erase "$(INTDIR)\ptrarray.obj"
	-@erase "$(INTDIR)\SString.obj"
	-@erase "$(INTDIR)\StdAfx.obj"
	-@erase "$(INTDIR)\tstfile.obj"
	-@erase "$(INTDIR)\vc60.idb"
	-@erase "$(INTDIR)\WinUtil.obj"
	-@erase "$(OUTDIR)\NifTo3ds.exe"
	-@erase ".\Release\NifTo3ds.cnt"
	-@erase ".\Release\NifTo3ds.hlp"
	-@erase "hlp\NifTo3ds.hm"

"$(OUTDIR)" :
    if not exist "$(OUTDIR)/$(NULL)" mkdir "$(OUTDIR)"

CPP=cl.exe
CPP_PROJ=/nologo /MD /W3 /GX /O2 /D "WIN32" /D "NDEBUG" /D "_WINDOWS" /D "_AFXDLL" /D "_MBCS" /Fp"$(INTDIR)\NifTo3ds.pch" /Yu"stdafx.h" /Fo"$(INTDIR)\\" /Fd"$(INTDIR)\\" /FD /c 

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
RSC_PROJ=/l 0x1009 /fo"$(INTDIR)\NifTo3ds.res" /d "NDEBUG" /d "_AFXDLL" 
BSC32=bscmake.exe
BSC32_FLAGS=/nologo /o"$(OUTDIR)\NifTo3ds.bsc" 
BSC32_SBRS= \
	
LINK32=link.exe
LINK32_FLAGS=/nologo /subsystem:windows /incremental:no /pdb:"$(OUTDIR)\NifTo3ds.pdb" /machine:I386 /out:"$(OUTDIR)\NifTo3ds.exe" 
LINK32_OBJS= \
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
	"$(INTDIR)\genfile.obj" \
	"$(INTDIR)\genfind.obj" \
	"$(INTDIR)\ptrarray.obj" \
	"$(INTDIR)\SString.obj" \
	"$(INTDIR)\tstfile.obj" \
	"$(INTDIR)\WinUtil.obj" \
	"$(INTDIR)\NifAlphaProperty.obj" \
	"$(INTDIR)\NifAmbientLight.obj" \
	"$(INTDIR)\NifAutoNormalParticles.obj" \
	"$(INTDIR)\NifAutoNormalParticlesData.obj" \
	"$(INTDIR)\NifBase.obj" \
	"$(INTDIR)\NifBillboardNode.obj" \
	"$(INTDIR)\NifBsAnimationNode.obj" \
	"$(INTDIR)\NifBSPArrayController.obj" \
	"$(INTDIR)\NifCamera.obj" \
	"$(INTDIR)\NifColorData.obj" \
	"$(INTDIR)\NifDirectionalLight.obj" \
	"$(INTDIR)\NifEndFile.obj" \
	"$(INTDIR)\NifEOF.obj" \
	"$(INTDIR)\NifFile.obj" \
	"$(INTDIR)\NifFloatArray.obj" \
	"$(INTDIR)\NifFloatData.obj" \
	"$(INTDIR)\NifGeomMorpherController.obj" \
	"$(INTDIR)\NifGravity.obj" \
	"$(INTDIR)\NifKeyFrameController.obj" \
	"$(INTDIR)\NifKeyFrameData.obj" \
	"$(INTDIR)\NifLongArray.obj" \
	"$(INTDIR)\NifMaterialProperty.obj" \
	"$(INTDIR)\NifMorphData.obj" \
	"$(INTDIR)\NifNode.obj" \
	"$(INTDIR)\NifParticleColorModifier.obj" \
	"$(INTDIR)\NifParticleGrowFade.obj" \
	"$(INTDIR)\NifParticleNode.obj" \
	"$(INTDIR)\NifParticleRotation.obj" \
	"$(INTDIR)\NifParticleSysController.obj" \
	"$(INTDIR)\NifPathController.obj" \
	"$(INTDIR)\NifPixelData.obj" \
	"$(INTDIR)\NifPosData.obj" \
	"$(INTDIR)\NifRootCollisionNode.obj" \
	"$(INTDIR)\NifRotatingParticles.obj" \
	"$(INTDIR)\NifRotatingParticlesData.obj" \
	"$(INTDIR)\NifShadeProperty.obj" \
	"$(INTDIR)\NifSkinData.obj" \
	"$(INTDIR)\NifSkinInstance.obj" \
	"$(INTDIR)\NifSourceTexture.obj" \
	"$(INTDIR)\NifStringData.obj" \
	"$(INTDIR)\NifTextKeyExtraData.obj" \
	"$(INTDIR)\NifTextureEffect.obj" \
	"$(INTDIR)\NifTextureProperty.obj" \
	"$(INTDIR)\NifTriShape.obj" \
	"$(INTDIR)\NifTriShapeData.obj" \
	"$(INTDIR)\NifUVController.obj" \
	"$(INTDIR)\NifUVData.obj" \
	"$(INTDIR)\NifVertexColorProperty.obj" \
	"$(INTDIR)\NifVertWeightsExtraData.obj" \
	"$(INTDIR)\NifVisController.obj" \
	"$(INTDIR)\NifVisData.obj" \
	"$(INTDIR)\NifWireframeProperty.obj" \
	"$(INTDIR)\NifZBufferProperty.obj" \
	"$(INTDIR)\ConvertNif3ds.obj" \
	"$(INTDIR)\NifTo3ds.obj" \
	"$(INTDIR)\NifTo3dsDlg.obj" \
	"$(INTDIR)\StdAfx.obj" \
	"$(INTDIR)\NifTo3ds.res" \
	"..\..\..\Library\3dslib\LIB\FTKVC40.LIB"

"$(OUTDIR)\NifTo3ds.exe" : "$(OUTDIR)" $(DEF_FILE) $(LINK32_OBJS)
    $(LINK32) @<<
  $(LINK32_FLAGS) $(LINK32_OBJS)
<<

!ELSEIF  "$(CFG)" == "NifTo3ds - Win32 Debug"

OUTDIR=.\Debug
INTDIR=.\Debug
# Begin Custom Macros
OutDir=.\Debug
# End Custom Macros

ALL : ".\hlp\NifTo3ds.hm" ".\Debug\NifTo3ds.hlp" ".\Debug\NifTo3ds.cnt" "$(OUTDIR)\NifTo3ds.exe" "$(OUTDIR)\NifTo3ds.bsc"


CLEAN :
	-@erase "$(INTDIR)\ConvertNif3ds.obj"
	-@erase "$(INTDIR)\ConvertNif3ds.sbr"
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
	-@erase "$(INTDIR)\genfile.obj"
	-@erase "$(INTDIR)\genfile.sbr"
	-@erase "$(INTDIR)\genfind.obj"
	-@erase "$(INTDIR)\genfind.sbr"
	-@erase "$(INTDIR)\NifAlphaProperty.obj"
	-@erase "$(INTDIR)\NifAlphaProperty.sbr"
	-@erase "$(INTDIR)\NifAmbientLight.obj"
	-@erase "$(INTDIR)\NifAmbientLight.sbr"
	-@erase "$(INTDIR)\NifAutoNormalParticles.obj"
	-@erase "$(INTDIR)\NifAutoNormalParticles.sbr"
	-@erase "$(INTDIR)\NifAutoNormalParticlesData.obj"
	-@erase "$(INTDIR)\NifAutoNormalParticlesData.sbr"
	-@erase "$(INTDIR)\NifBase.obj"
	-@erase "$(INTDIR)\NifBase.sbr"
	-@erase "$(INTDIR)\NifBillboardNode.obj"
	-@erase "$(INTDIR)\NifBillboardNode.sbr"
	-@erase "$(INTDIR)\NifBsAnimationNode.obj"
	-@erase "$(INTDIR)\NifBsAnimationNode.sbr"
	-@erase "$(INTDIR)\NifBSPArrayController.obj"
	-@erase "$(INTDIR)\NifBSPArrayController.sbr"
	-@erase "$(INTDIR)\NifCamera.obj"
	-@erase "$(INTDIR)\NifCamera.sbr"
	-@erase "$(INTDIR)\NifColorData.obj"
	-@erase "$(INTDIR)\NifColorData.sbr"
	-@erase "$(INTDIR)\NifDirectionalLight.obj"
	-@erase "$(INTDIR)\NifDirectionalLight.sbr"
	-@erase "$(INTDIR)\NifEndFile.obj"
	-@erase "$(INTDIR)\NifEndFile.sbr"
	-@erase "$(INTDIR)\NifEOF.obj"
	-@erase "$(INTDIR)\NifEOF.sbr"
	-@erase "$(INTDIR)\NifFile.obj"
	-@erase "$(INTDIR)\NifFile.sbr"
	-@erase "$(INTDIR)\NifFloatArray.obj"
	-@erase "$(INTDIR)\NifFloatArray.sbr"
	-@erase "$(INTDIR)\NifFloatData.obj"
	-@erase "$(INTDIR)\NifFloatData.sbr"
	-@erase "$(INTDIR)\NifGeomMorpherController.obj"
	-@erase "$(INTDIR)\NifGeomMorpherController.sbr"
	-@erase "$(INTDIR)\NifGravity.obj"
	-@erase "$(INTDIR)\NifGravity.sbr"
	-@erase "$(INTDIR)\NifKeyFrameController.obj"
	-@erase "$(INTDIR)\NifKeyFrameController.sbr"
	-@erase "$(INTDIR)\NifKeyFrameData.obj"
	-@erase "$(INTDIR)\NifKeyFrameData.sbr"
	-@erase "$(INTDIR)\NifLongArray.obj"
	-@erase "$(INTDIR)\NifLongArray.sbr"
	-@erase "$(INTDIR)\NifMaterialProperty.obj"
	-@erase "$(INTDIR)\NifMaterialProperty.sbr"
	-@erase "$(INTDIR)\NifMorphData.obj"
	-@erase "$(INTDIR)\NifMorphData.sbr"
	-@erase "$(INTDIR)\NifNode.obj"
	-@erase "$(INTDIR)\NifNode.sbr"
	-@erase "$(INTDIR)\NifParticleColorModifier.obj"
	-@erase "$(INTDIR)\NifParticleColorModifier.sbr"
	-@erase "$(INTDIR)\NifParticleGrowFade.obj"
	-@erase "$(INTDIR)\NifParticleGrowFade.sbr"
	-@erase "$(INTDIR)\NifParticleNode.obj"
	-@erase "$(INTDIR)\NifParticleNode.sbr"
	-@erase "$(INTDIR)\NifParticleRotation.obj"
	-@erase "$(INTDIR)\NifParticleRotation.sbr"
	-@erase "$(INTDIR)\NifParticleSysController.obj"
	-@erase "$(INTDIR)\NifParticleSysController.sbr"
	-@erase "$(INTDIR)\NifPathController.obj"
	-@erase "$(INTDIR)\NifPathController.sbr"
	-@erase "$(INTDIR)\NifPixelData.obj"
	-@erase "$(INTDIR)\NifPixelData.sbr"
	-@erase "$(INTDIR)\NifPosData.obj"
	-@erase "$(INTDIR)\NifPosData.sbr"
	-@erase "$(INTDIR)\NifRootCollisionNode.obj"
	-@erase "$(INTDIR)\NifRootCollisionNode.sbr"
	-@erase "$(INTDIR)\NifRotatingParticles.obj"
	-@erase "$(INTDIR)\NifRotatingParticles.sbr"
	-@erase "$(INTDIR)\NifRotatingParticlesData.obj"
	-@erase "$(INTDIR)\NifRotatingParticlesData.sbr"
	-@erase "$(INTDIR)\NifShadeProperty.obj"
	-@erase "$(INTDIR)\NifShadeProperty.sbr"
	-@erase "$(INTDIR)\NifSkinData.obj"
	-@erase "$(INTDIR)\NifSkinData.sbr"
	-@erase "$(INTDIR)\NifSkinInstance.obj"
	-@erase "$(INTDIR)\NifSkinInstance.sbr"
	-@erase "$(INTDIR)\NifSourceTexture.obj"
	-@erase "$(INTDIR)\NifSourceTexture.sbr"
	-@erase "$(INTDIR)\NifStringData.obj"
	-@erase "$(INTDIR)\NifStringData.sbr"
	-@erase "$(INTDIR)\NifTextKeyExtraData.obj"
	-@erase "$(INTDIR)\NifTextKeyExtraData.sbr"
	-@erase "$(INTDIR)\NifTextureEffect.obj"
	-@erase "$(INTDIR)\NifTextureEffect.sbr"
	-@erase "$(INTDIR)\NifTextureProperty.obj"
	-@erase "$(INTDIR)\NifTextureProperty.sbr"
	-@erase "$(INTDIR)\NifTo3ds.obj"
	-@erase "$(INTDIR)\NifTo3ds.pch"
	-@erase "$(INTDIR)\NifTo3ds.res"
	-@erase "$(INTDIR)\NifTo3ds.sbr"
	-@erase "$(INTDIR)\NifTo3dsDlg.obj"
	-@erase "$(INTDIR)\NifTo3dsDlg.sbr"
	-@erase "$(INTDIR)\NifTriShape.obj"
	-@erase "$(INTDIR)\NifTriShape.sbr"
	-@erase "$(INTDIR)\NifTriShapeData.obj"
	-@erase "$(INTDIR)\NifTriShapeData.sbr"
	-@erase "$(INTDIR)\NifUVController.obj"
	-@erase "$(INTDIR)\NifUVController.sbr"
	-@erase "$(INTDIR)\NifUVData.obj"
	-@erase "$(INTDIR)\NifUVData.sbr"
	-@erase "$(INTDIR)\NifVertexColorProperty.obj"
	-@erase "$(INTDIR)\NifVertexColorProperty.sbr"
	-@erase "$(INTDIR)\NifVertWeightsExtraData.obj"
	-@erase "$(INTDIR)\NifVertWeightsExtraData.sbr"
	-@erase "$(INTDIR)\NifVisController.obj"
	-@erase "$(INTDIR)\NifVisController.sbr"
	-@erase "$(INTDIR)\NifVisData.obj"
	-@erase "$(INTDIR)\NifVisData.sbr"
	-@erase "$(INTDIR)\NifWireframeProperty.obj"
	-@erase "$(INTDIR)\NifWireframeProperty.sbr"
	-@erase "$(INTDIR)\NifZBufferProperty.obj"
	-@erase "$(INTDIR)\NifZBufferProperty.sbr"
	-@erase "$(INTDIR)\ptrarray.obj"
	-@erase "$(INTDIR)\ptrarray.sbr"
	-@erase "$(INTDIR)\SString.obj"
	-@erase "$(INTDIR)\SString.sbr"
	-@erase "$(INTDIR)\StdAfx.obj"
	-@erase "$(INTDIR)\StdAfx.sbr"
	-@erase "$(INTDIR)\tstfile.obj"
	-@erase "$(INTDIR)\tstfile.sbr"
	-@erase "$(INTDIR)\vc60.idb"
	-@erase "$(INTDIR)\vc60.pdb"
	-@erase "$(INTDIR)\WinUtil.obj"
	-@erase "$(INTDIR)\WinUtil.sbr"
	-@erase "$(OUTDIR)\NifTo3ds.bsc"
	-@erase "$(OUTDIR)\NifTo3ds.exe"
	-@erase "$(OUTDIR)\NifTo3ds.ilk"
	-@erase "$(OUTDIR)\NifTo3ds.pdb"
	-@erase ".\Debug\NifTo3ds.cnt"
	-@erase ".\Debug\NifTo3ds.hlp"
	-@erase "hlp\NifTo3ds.hm"

"$(OUTDIR)" :
    if not exist "$(OUTDIR)/$(NULL)" mkdir "$(OUTDIR)"

CPP=cl.exe
CPP_PROJ=/nologo /MDd /W3 /Gm /GX /ZI /Od /D "WIN32" /D "_DEBUG" /D "_WINDOWS" /D "_AFXDLL" /D "_MBCS" /FR"$(INTDIR)\\" /Fp"$(INTDIR)\NifTo3ds.pch" /Yu"stdafx.h" /Fo"$(INTDIR)\\" /Fd"$(INTDIR)\\" /FD /GZ /c 

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
RSC_PROJ=/l 0x1009 /fo"$(INTDIR)\NifTo3ds.res" /d "_DEBUG" /d "_AFXDLL" 
BSC32=bscmake.exe
BSC32_FLAGS=/nologo /o"$(OUTDIR)\NifTo3ds.bsc" 
BSC32_SBRS= \
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
	"$(INTDIR)\genfile.sbr" \
	"$(INTDIR)\genfind.sbr" \
	"$(INTDIR)\ptrarray.sbr" \
	"$(INTDIR)\SString.sbr" \
	"$(INTDIR)\tstfile.sbr" \
	"$(INTDIR)\WinUtil.sbr" \
	"$(INTDIR)\NifAlphaProperty.sbr" \
	"$(INTDIR)\NifAmbientLight.sbr" \
	"$(INTDIR)\NifAutoNormalParticles.sbr" \
	"$(INTDIR)\NifAutoNormalParticlesData.sbr" \
	"$(INTDIR)\NifBase.sbr" \
	"$(INTDIR)\NifBillboardNode.sbr" \
	"$(INTDIR)\NifBsAnimationNode.sbr" \
	"$(INTDIR)\NifBSPArrayController.sbr" \
	"$(INTDIR)\NifCamera.sbr" \
	"$(INTDIR)\NifColorData.sbr" \
	"$(INTDIR)\NifDirectionalLight.sbr" \
	"$(INTDIR)\NifEndFile.sbr" \
	"$(INTDIR)\NifEOF.sbr" \
	"$(INTDIR)\NifFile.sbr" \
	"$(INTDIR)\NifFloatArray.sbr" \
	"$(INTDIR)\NifFloatData.sbr" \
	"$(INTDIR)\NifGeomMorpherController.sbr" \
	"$(INTDIR)\NifGravity.sbr" \
	"$(INTDIR)\NifKeyFrameController.sbr" \
	"$(INTDIR)\NifKeyFrameData.sbr" \
	"$(INTDIR)\NifLongArray.sbr" \
	"$(INTDIR)\NifMaterialProperty.sbr" \
	"$(INTDIR)\NifMorphData.sbr" \
	"$(INTDIR)\NifNode.sbr" \
	"$(INTDIR)\NifParticleColorModifier.sbr" \
	"$(INTDIR)\NifParticleGrowFade.sbr" \
	"$(INTDIR)\NifParticleNode.sbr" \
	"$(INTDIR)\NifParticleRotation.sbr" \
	"$(INTDIR)\NifParticleSysController.sbr" \
	"$(INTDIR)\NifPathController.sbr" \
	"$(INTDIR)\NifPixelData.sbr" \
	"$(INTDIR)\NifPosData.sbr" \
	"$(INTDIR)\NifRootCollisionNode.sbr" \
	"$(INTDIR)\NifRotatingParticles.sbr" \
	"$(INTDIR)\NifRotatingParticlesData.sbr" \
	"$(INTDIR)\NifShadeProperty.sbr" \
	"$(INTDIR)\NifSkinData.sbr" \
	"$(INTDIR)\NifSkinInstance.sbr" \
	"$(INTDIR)\NifSourceTexture.sbr" \
	"$(INTDIR)\NifStringData.sbr" \
	"$(INTDIR)\NifTextKeyExtraData.sbr" \
	"$(INTDIR)\NifTextureEffect.sbr" \
	"$(INTDIR)\NifTextureProperty.sbr" \
	"$(INTDIR)\NifTriShape.sbr" \
	"$(INTDIR)\NifTriShapeData.sbr" \
	"$(INTDIR)\NifUVController.sbr" \
	"$(INTDIR)\NifUVData.sbr" \
	"$(INTDIR)\NifVertexColorProperty.sbr" \
	"$(INTDIR)\NifVertWeightsExtraData.sbr" \
	"$(INTDIR)\NifVisController.sbr" \
	"$(INTDIR)\NifVisData.sbr" \
	"$(INTDIR)\NifWireframeProperty.sbr" \
	"$(INTDIR)\NifZBufferProperty.sbr" \
	"$(INTDIR)\ConvertNif3ds.sbr" \
	"$(INTDIR)\NifTo3ds.sbr" \
	"$(INTDIR)\NifTo3dsDlg.sbr" \
	"$(INTDIR)\StdAfx.sbr"

"$(OUTDIR)\NifTo3ds.bsc" : "$(OUTDIR)" $(BSC32_SBRS)
    $(BSC32) @<<
  $(BSC32_FLAGS) $(BSC32_SBRS)
<<

LINK32=link.exe
LINK32_FLAGS=/nologo /subsystem:windows /incremental:yes /pdb:"$(OUTDIR)\NifTo3ds.pdb" /debug /machine:I386 /out:"$(OUTDIR)\NifTo3ds.exe" /pdbtype:sept 
LINK32_OBJS= \
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
	"$(INTDIR)\genfile.obj" \
	"$(INTDIR)\genfind.obj" \
	"$(INTDIR)\ptrarray.obj" \
	"$(INTDIR)\SString.obj" \
	"$(INTDIR)\tstfile.obj" \
	"$(INTDIR)\WinUtil.obj" \
	"$(INTDIR)\NifAlphaProperty.obj" \
	"$(INTDIR)\NifAmbientLight.obj" \
	"$(INTDIR)\NifAutoNormalParticles.obj" \
	"$(INTDIR)\NifAutoNormalParticlesData.obj" \
	"$(INTDIR)\NifBase.obj" \
	"$(INTDIR)\NifBillboardNode.obj" \
	"$(INTDIR)\NifBsAnimationNode.obj" \
	"$(INTDIR)\NifBSPArrayController.obj" \
	"$(INTDIR)\NifCamera.obj" \
	"$(INTDIR)\NifColorData.obj" \
	"$(INTDIR)\NifDirectionalLight.obj" \
	"$(INTDIR)\NifEndFile.obj" \
	"$(INTDIR)\NifEOF.obj" \
	"$(INTDIR)\NifFile.obj" \
	"$(INTDIR)\NifFloatArray.obj" \
	"$(INTDIR)\NifFloatData.obj" \
	"$(INTDIR)\NifGeomMorpherController.obj" \
	"$(INTDIR)\NifGravity.obj" \
	"$(INTDIR)\NifKeyFrameController.obj" \
	"$(INTDIR)\NifKeyFrameData.obj" \
	"$(INTDIR)\NifLongArray.obj" \
	"$(INTDIR)\NifMaterialProperty.obj" \
	"$(INTDIR)\NifMorphData.obj" \
	"$(INTDIR)\NifNode.obj" \
	"$(INTDIR)\NifParticleColorModifier.obj" \
	"$(INTDIR)\NifParticleGrowFade.obj" \
	"$(INTDIR)\NifParticleNode.obj" \
	"$(INTDIR)\NifParticleRotation.obj" \
	"$(INTDIR)\NifParticleSysController.obj" \
	"$(INTDIR)\NifPathController.obj" \
	"$(INTDIR)\NifPixelData.obj" \
	"$(INTDIR)\NifPosData.obj" \
	"$(INTDIR)\NifRootCollisionNode.obj" \
	"$(INTDIR)\NifRotatingParticles.obj" \
	"$(INTDIR)\NifRotatingParticlesData.obj" \
	"$(INTDIR)\NifShadeProperty.obj" \
	"$(INTDIR)\NifSkinData.obj" \
	"$(INTDIR)\NifSkinInstance.obj" \
	"$(INTDIR)\NifSourceTexture.obj" \
	"$(INTDIR)\NifStringData.obj" \
	"$(INTDIR)\NifTextKeyExtraData.obj" \
	"$(INTDIR)\NifTextureEffect.obj" \
	"$(INTDIR)\NifTextureProperty.obj" \
	"$(INTDIR)\NifTriShape.obj" \
	"$(INTDIR)\NifTriShapeData.obj" \
	"$(INTDIR)\NifUVController.obj" \
	"$(INTDIR)\NifUVData.obj" \
	"$(INTDIR)\NifVertexColorProperty.obj" \
	"$(INTDIR)\NifVertWeightsExtraData.obj" \
	"$(INTDIR)\NifVisController.obj" \
	"$(INTDIR)\NifVisData.obj" \
	"$(INTDIR)\NifWireframeProperty.obj" \
	"$(INTDIR)\NifZBufferProperty.obj" \
	"$(INTDIR)\ConvertNif3ds.obj" \
	"$(INTDIR)\NifTo3ds.obj" \
	"$(INTDIR)\NifTo3dsDlg.obj" \
	"$(INTDIR)\StdAfx.obj" \
	"$(INTDIR)\NifTo3ds.res" \
	"..\..\..\Library\3dslib\LIB\FTKVC40D.LIB"

"$(OUTDIR)\NifTo3ds.exe" : "$(OUTDIR)" $(DEF_FILE) $(LINK32_OBJS)
    $(LINK32) @<<
  $(LINK32_FLAGS) $(LINK32_OBJS)
<<

!ENDIF 


!IF "$(NO_EXTERNAL_DEPS)" != "1"
!IF EXISTS("NifTo3ds.dep")
!INCLUDE "NifTo3ds.dep"
!ELSE 
!MESSAGE Warning: cannot find "NifTo3ds.dep"
!ENDIF 
!ENDIF 


!IF "$(CFG)" == "NifTo3ds - Win32 Release" || "$(CFG)" == "NifTo3ds - Win32 Debug"
SOURCE=..\..\..\..\Source\Common\dl_base.cpp

!IF  "$(CFG)" == "NifTo3ds - Win32 Release"

CPP_SWITCHES=/nologo /MD /W3 /GX /O2 /D "WIN32" /D "NDEBUG" /D "_WINDOWS" /D "_AFXDLL" /D "_MBCS" /Fo"$(INTDIR)\\" /Fd"$(INTDIR)\\" /FD /c 

"$(INTDIR)\dl_base.obj" : $(SOURCE) "$(INTDIR)"
	$(CPP) @<<
  $(CPP_SWITCHES) $(SOURCE)
<<


!ELSEIF  "$(CFG)" == "NifTo3ds - Win32 Debug"

CPP_SWITCHES=/nologo /MDd /W3 /Gm /GX /ZI /Od /D "WIN32" /D "_DEBUG" /D "_WINDOWS" /D "_AFXDLL" /D "_MBCS" /FR"$(INTDIR)\\" /Fo"$(INTDIR)\\" /Fd"$(INTDIR)\\" /FD /GZ /c 

"$(INTDIR)\dl_base.obj"	"$(INTDIR)\dl_base.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) @<<
  $(CPP_SWITCHES) $(SOURCE)
<<


!ENDIF 

SOURCE=..\..\..\..\Source\Common\dl_block.cpp

!IF  "$(CFG)" == "NifTo3ds - Win32 Release"

CPP_SWITCHES=/nologo /MD /W3 /GX /O2 /D "WIN32" /D "NDEBUG" /D "_WINDOWS" /D "_AFXDLL" /D "_MBCS" /Fo"$(INTDIR)\\" /Fd"$(INTDIR)\\" /FD /c 

"$(INTDIR)\dl_block.obj" : $(SOURCE) "$(INTDIR)"
	$(CPP) @<<
  $(CPP_SWITCHES) $(SOURCE)
<<


!ELSEIF  "$(CFG)" == "NifTo3ds - Win32 Debug"

CPP_SWITCHES=/nologo /MDd /W3 /Gm /GX /ZI /Od /D "WIN32" /D "_DEBUG" /D "_WINDOWS" /D "_AFXDLL" /D "_MBCS" /FR"$(INTDIR)\\" /Fo"$(INTDIR)\\" /Fd"$(INTDIR)\\" /FD /GZ /c 

"$(INTDIR)\dl_block.obj"	"$(INTDIR)\dl_block.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) @<<
  $(CPP_SWITCHES) $(SOURCE)
<<


!ENDIF 

SOURCE=..\..\..\..\Source\Common\dl_chr.cpp

!IF  "$(CFG)" == "NifTo3ds - Win32 Release"

CPP_SWITCHES=/nologo /MD /W3 /GX /O2 /D "WIN32" /D "NDEBUG" /D "_WINDOWS" /D "_AFXDLL" /D "_MBCS" /Fo"$(INTDIR)\\" /Fd"$(INTDIR)\\" /FD /c 

"$(INTDIR)\dl_chr.obj" : $(SOURCE) "$(INTDIR)"
	$(CPP) @<<
  $(CPP_SWITCHES) $(SOURCE)
<<


!ELSEIF  "$(CFG)" == "NifTo3ds - Win32 Debug"

CPP_SWITCHES=/nologo /MDd /W3 /Gm /GX /ZI /Od /D "WIN32" /D "_DEBUG" /D "_WINDOWS" /D "_AFXDLL" /D "_MBCS" /FR"$(INTDIR)\\" /Fo"$(INTDIR)\\" /Fd"$(INTDIR)\\" /FD /GZ /c 

"$(INTDIR)\dl_chr.obj"	"$(INTDIR)\dl_chr.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) @<<
  $(CPP_SWITCHES) $(SOURCE)
<<


!ENDIF 

SOURCE=..\..\..\..\Source\Common\dl_err.cpp

!IF  "$(CFG)" == "NifTo3ds - Win32 Release"

CPP_SWITCHES=/nologo /MD /W3 /GX /O2 /D "WIN32" /D "NDEBUG" /D "_WINDOWS" /D "_AFXDLL" /D "_MBCS" /Fo"$(INTDIR)\\" /Fd"$(INTDIR)\\" /FD /c 

"$(INTDIR)\dl_err.obj" : $(SOURCE) "$(INTDIR)"
	$(CPP) @<<
  $(CPP_SWITCHES) $(SOURCE)
<<


!ELSEIF  "$(CFG)" == "NifTo3ds - Win32 Debug"

CPP_SWITCHES=/nologo /MDd /W3 /Gm /GX /ZI /Od /D "WIN32" /D "_DEBUG" /D "_WINDOWS" /D "_AFXDLL" /D "_MBCS" /FR"$(INTDIR)\\" /Fo"$(INTDIR)\\" /Fd"$(INTDIR)\\" /FD /GZ /c 

"$(INTDIR)\dl_err.obj"	"$(INTDIR)\dl_err.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) @<<
  $(CPP_SWITCHES) $(SOURCE)
<<


!ENDIF 

SOURCE=..\..\..\..\Source\Common\dl_file.cpp

!IF  "$(CFG)" == "NifTo3ds - Win32 Release"

CPP_SWITCHES=/nologo /MD /W3 /GX /O2 /D "WIN32" /D "NDEBUG" /D "_WINDOWS" /D "_AFXDLL" /D "_MBCS" /Fo"$(INTDIR)\\" /Fd"$(INTDIR)\\" /FD /c 

"$(INTDIR)\dl_file.obj" : $(SOURCE) "$(INTDIR)"
	$(CPP) @<<
  $(CPP_SWITCHES) $(SOURCE)
<<


!ELSEIF  "$(CFG)" == "NifTo3ds - Win32 Debug"

CPP_SWITCHES=/nologo /MDd /W3 /Gm /GX /ZI /Od /D "WIN32" /D "_DEBUG" /D "_WINDOWS" /D "_AFXDLL" /D "_MBCS" /FR"$(INTDIR)\\" /Fo"$(INTDIR)\\" /Fd"$(INTDIR)\\" /FD /GZ /c 

"$(INTDIR)\dl_file.obj"	"$(INTDIR)\dl_file.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) @<<
  $(CPP_SWITCHES) $(SOURCE)
<<


!ENDIF 

SOURCE=..\..\..\..\Source\Common\dl_log.cpp

!IF  "$(CFG)" == "NifTo3ds - Win32 Release"

CPP_SWITCHES=/nologo /MD /W3 /GX /O2 /D "WIN32" /D "NDEBUG" /D "_WINDOWS" /D "_AFXDLL" /D "_MBCS" /Fo"$(INTDIR)\\" /Fd"$(INTDIR)\\" /FD /c 

"$(INTDIR)\dl_log.obj" : $(SOURCE) "$(INTDIR)"
	$(CPP) @<<
  $(CPP_SWITCHES) $(SOURCE)
<<


!ELSEIF  "$(CFG)" == "NifTo3ds - Win32 Debug"

CPP_SWITCHES=/nologo /MDd /W3 /Gm /GX /ZI /Od /D "WIN32" /D "_DEBUG" /D "_WINDOWS" /D "_AFXDLL" /D "_MBCS" /FR"$(INTDIR)\\" /Fo"$(INTDIR)\\" /Fd"$(INTDIR)\\" /FD /GZ /c 

"$(INTDIR)\dl_log.obj"	"$(INTDIR)\dl_log.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) @<<
  $(CPP_SWITCHES) $(SOURCE)
<<


!ENDIF 

SOURCE=..\..\..\..\Source\Common\dl_math.cpp

!IF  "$(CFG)" == "NifTo3ds - Win32 Release"

CPP_SWITCHES=/nologo /MD /W3 /GX /O2 /D "WIN32" /D "NDEBUG" /D "_WINDOWS" /D "_AFXDLL" /D "_MBCS" /Fo"$(INTDIR)\\" /Fd"$(INTDIR)\\" /FD /c 

"$(INTDIR)\dl_math.obj" : $(SOURCE) "$(INTDIR)"
	$(CPP) @<<
  $(CPP_SWITCHES) $(SOURCE)
<<


!ELSEIF  "$(CFG)" == "NifTo3ds - Win32 Debug"

CPP_SWITCHES=/nologo /MDd /W3 /Gm /GX /ZI /Od /D "WIN32" /D "_DEBUG" /D "_WINDOWS" /D "_AFXDLL" /D "_MBCS" /FR"$(INTDIR)\\" /Fo"$(INTDIR)\\" /Fd"$(INTDIR)\\" /FD /GZ /c 

"$(INTDIR)\dl_math.obj"	"$(INTDIR)\dl_math.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) @<<
  $(CPP_SWITCHES) $(SOURCE)
<<


!ENDIF 

SOURCE=..\..\..\..\Source\Common\dl_mem.cpp

!IF  "$(CFG)" == "NifTo3ds - Win32 Release"

CPP_SWITCHES=/nologo /MD /W3 /GX /O2 /D "WIN32" /D "NDEBUG" /D "_WINDOWS" /D "_AFXDLL" /D "_MBCS" /Fo"$(INTDIR)\\" /Fd"$(INTDIR)\\" /FD /c 

"$(INTDIR)\dl_mem.obj" : $(SOURCE) "$(INTDIR)"
	$(CPP) @<<
  $(CPP_SWITCHES) $(SOURCE)
<<


!ELSEIF  "$(CFG)" == "NifTo3ds - Win32 Debug"

CPP_SWITCHES=/nologo /MDd /W3 /Gm /GX /ZI /Od /D "WIN32" /D "_DEBUG" /D "_WINDOWS" /D "_AFXDLL" /D "_MBCS" /FR"$(INTDIR)\\" /Fo"$(INTDIR)\\" /Fd"$(INTDIR)\\" /FD /GZ /c 

"$(INTDIR)\dl_mem.obj"	"$(INTDIR)\dl_mem.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) @<<
  $(CPP_SWITCHES) $(SOURCE)
<<


!ENDIF 

SOURCE=..\..\..\..\Source\Common\dl_str.cpp

!IF  "$(CFG)" == "NifTo3ds - Win32 Release"

CPP_SWITCHES=/nologo /MD /W3 /GX /O2 /D "WIN32" /D "NDEBUG" /D "_WINDOWS" /D "_AFXDLL" /D "_MBCS" /Fo"$(INTDIR)\\" /Fd"$(INTDIR)\\" /FD /c 

"$(INTDIR)\dl_str.obj" : $(SOURCE) "$(INTDIR)"
	$(CPP) @<<
  $(CPP_SWITCHES) $(SOURCE)
<<


!ELSEIF  "$(CFG)" == "NifTo3ds - Win32 Debug"

CPP_SWITCHES=/nologo /MDd /W3 /Gm /GX /ZI /Od /D "WIN32" /D "_DEBUG" /D "_WINDOWS" /D "_AFXDLL" /D "_MBCS" /FR"$(INTDIR)\\" /Fo"$(INTDIR)\\" /Fd"$(INTDIR)\\" /FD /GZ /c 

"$(INTDIR)\dl_str.obj"	"$(INTDIR)\dl_str.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) @<<
  $(CPP_SWITCHES) $(SOURCE)
<<


!ENDIF 

SOURCE=..\..\..\..\Source\Common\dl_time.cpp

!IF  "$(CFG)" == "NifTo3ds - Win32 Release"

CPP_SWITCHES=/nologo /MD /W3 /GX /O2 /D "WIN32" /D "NDEBUG" /D "_WINDOWS" /D "_AFXDLL" /D "_MBCS" /Fo"$(INTDIR)\\" /Fd"$(INTDIR)\\" /FD /c 

"$(INTDIR)\dl_time.obj" : $(SOURCE) "$(INTDIR)"
	$(CPP) @<<
  $(CPP_SWITCHES) $(SOURCE)
<<


!ELSEIF  "$(CFG)" == "NifTo3ds - Win32 Debug"

CPP_SWITCHES=/nologo /MDd /W3 /Gm /GX /ZI /Od /D "WIN32" /D "_DEBUG" /D "_WINDOWS" /D "_AFXDLL" /D "_MBCS" /FR"$(INTDIR)\\" /Fo"$(INTDIR)\\" /Fd"$(INTDIR)\\" /FD /GZ /c 

"$(INTDIR)\dl_time.obj"	"$(INTDIR)\dl_time.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) @<<
  $(CPP_SWITCHES) $(SOURCE)
<<


!ENDIF 

SOURCE=..\..\..\..\Source\Common\File\genfile.cpp

!IF  "$(CFG)" == "NifTo3ds - Win32 Release"

CPP_SWITCHES=/nologo /MD /W3 /GX /O2 /D "WIN32" /D "NDEBUG" /D "_WINDOWS" /D "_AFXDLL" /D "_MBCS" /Fo"$(INTDIR)\\" /Fd"$(INTDIR)\\" /FD /c 

"$(INTDIR)\genfile.obj" : $(SOURCE) "$(INTDIR)"
	$(CPP) @<<
  $(CPP_SWITCHES) $(SOURCE)
<<


!ELSEIF  "$(CFG)" == "NifTo3ds - Win32 Debug"

CPP_SWITCHES=/nologo /MDd /W3 /Gm /GX /ZI /Od /D "WIN32" /D "_DEBUG" /D "_WINDOWS" /D "_AFXDLL" /D "_MBCS" /FR"$(INTDIR)\\" /Fo"$(INTDIR)\\" /Fd"$(INTDIR)\\" /FD /GZ /c 

"$(INTDIR)\genfile.obj"	"$(INTDIR)\genfile.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) @<<
  $(CPP_SWITCHES) $(SOURCE)
<<


!ENDIF 

SOURCE=..\..\..\..\Source\Common\File\genfind.cpp

!IF  "$(CFG)" == "NifTo3ds - Win32 Release"

CPP_SWITCHES=/nologo /MD /W3 /GX /O2 /D "WIN32" /D "NDEBUG" /D "_WINDOWS" /D "_AFXDLL" /D "_MBCS" /Fo"$(INTDIR)\\" /Fd"$(INTDIR)\\" /FD /c 

"$(INTDIR)\genfind.obj" : $(SOURCE) "$(INTDIR)"
	$(CPP) @<<
  $(CPP_SWITCHES) $(SOURCE)
<<


!ELSEIF  "$(CFG)" == "NifTo3ds - Win32 Debug"

CPP_SWITCHES=/nologo /MDd /W3 /Gm /GX /ZI /Od /D "WIN32" /D "_DEBUG" /D "_WINDOWS" /D "_AFXDLL" /D "_MBCS" /FR"$(INTDIR)\\" /Fo"$(INTDIR)\\" /Fd"$(INTDIR)\\" /FD /GZ /c 

"$(INTDIR)\genfind.obj"	"$(INTDIR)\genfind.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) @<<
  $(CPP_SWITCHES) $(SOURCE)
<<


!ENDIF 

SOURCE=..\..\..\..\Source\Common\Contain\ptrarray.cpp

!IF  "$(CFG)" == "NifTo3ds - Win32 Release"

CPP_SWITCHES=/nologo /MD /W3 /GX /O2 /D "WIN32" /D "NDEBUG" /D "_WINDOWS" /D "_AFXDLL" /D "_MBCS" /Fo"$(INTDIR)\\" /Fd"$(INTDIR)\\" /FD /c 

"$(INTDIR)\ptrarray.obj" : $(SOURCE) "$(INTDIR)"
	$(CPP) @<<
  $(CPP_SWITCHES) $(SOURCE)
<<


!ELSEIF  "$(CFG)" == "NifTo3ds - Win32 Debug"

CPP_SWITCHES=/nologo /MDd /W3 /Gm /GX /ZI /Od /D "WIN32" /D "_DEBUG" /D "_WINDOWS" /D "_AFXDLL" /D "_MBCS" /FR"$(INTDIR)\\" /Fo"$(INTDIR)\\" /Fd"$(INTDIR)\\" /FD /GZ /c 

"$(INTDIR)\ptrarray.obj"	"$(INTDIR)\ptrarray.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) @<<
  $(CPP_SWITCHES) $(SOURCE)
<<


!ENDIF 

SOURCE=..\..\..\..\Source\Common\String\SString.cpp

!IF  "$(CFG)" == "NifTo3ds - Win32 Release"

CPP_SWITCHES=/nologo /MD /W3 /GX /O2 /D "WIN32" /D "NDEBUG" /D "_WINDOWS" /D "_AFXDLL" /D "_MBCS" /Fo"$(INTDIR)\\" /Fd"$(INTDIR)\\" /FD /c 

"$(INTDIR)\SString.obj" : $(SOURCE) "$(INTDIR)"
	$(CPP) @<<
  $(CPP_SWITCHES) $(SOURCE)
<<


!ELSEIF  "$(CFG)" == "NifTo3ds - Win32 Debug"

CPP_SWITCHES=/nologo /MDd /W3 /Gm /GX /ZI /Od /D "WIN32" /D "_DEBUG" /D "_WINDOWS" /D "_AFXDLL" /D "_MBCS" /FR"$(INTDIR)\\" /Fo"$(INTDIR)\\" /Fd"$(INTDIR)\\" /FD /GZ /c 

"$(INTDIR)\SString.obj"	"$(INTDIR)\SString.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) @<<
  $(CPP_SWITCHES) $(SOURCE)
<<


!ENDIF 

SOURCE=..\..\..\..\Source\Common\tstfile.cpp

!IF  "$(CFG)" == "NifTo3ds - Win32 Release"

CPP_SWITCHES=/nologo /MD /W3 /GX /O2 /D "WIN32" /D "NDEBUG" /D "_WINDOWS" /D "_AFXDLL" /D "_MBCS" /Fo"$(INTDIR)\\" /Fd"$(INTDIR)\\" /FD /c 

"$(INTDIR)\tstfile.obj" : $(SOURCE) "$(INTDIR)"
	$(CPP) @<<
  $(CPP_SWITCHES) $(SOURCE)
<<


!ELSEIF  "$(CFG)" == "NifTo3ds - Win32 Debug"

CPP_SWITCHES=/nologo /MDd /W3 /Gm /GX /ZI /Od /D "WIN32" /D "_DEBUG" /D "_WINDOWS" /D "_AFXDLL" /D "_MBCS" /FR"$(INTDIR)\\" /Fo"$(INTDIR)\\" /Fd"$(INTDIR)\\" /FD /GZ /c 

"$(INTDIR)\tstfile.obj"	"$(INTDIR)\tstfile.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) @<<
  $(CPP_SWITCHES) $(SOURCE)
<<


!ENDIF 

SOURCE=..\..\..\..\Source\Windows\WinUtil.cpp

!IF  "$(CFG)" == "NifTo3ds - Win32 Release"


"$(INTDIR)\WinUtil.obj" : $(SOURCE) "$(INTDIR)" "$(INTDIR)\NifTo3ds.pch"
	$(CPP) $(CPP_PROJ) $(SOURCE)


!ELSEIF  "$(CFG)" == "NifTo3ds - Win32 Debug"


"$(INTDIR)\WinUtil.obj"	"$(INTDIR)\WinUtil.sbr" : $(SOURCE) "$(INTDIR)" "$(INTDIR)\NifTo3ds.pch"
	$(CPP) $(CPP_PROJ) $(SOURCE)


!ENDIF 

SOURCE=..\..\..\..\Source\uesp\Morrow\NIF\NifAlphaProperty.cpp

!IF  "$(CFG)" == "NifTo3ds - Win32 Release"

CPP_SWITCHES=/nologo /MD /W3 /GX /O2 /D "WIN32" /D "NDEBUG" /D "_WINDOWS" /D "_AFXDLL" /D "_MBCS" /Fp"$(INTDIR)\NifTo3ds.pch" /Yu"stdafx.h" /Fo"$(INTDIR)\\" /Fd"$(INTDIR)\\" /FD /c 

"$(INTDIR)\NifAlphaProperty.obj" : $(SOURCE) "$(INTDIR)" "$(INTDIR)\NifTo3ds.pch"
	$(CPP) @<<
  $(CPP_SWITCHES) $(SOURCE)
<<


!ELSEIF  "$(CFG)" == "NifTo3ds - Win32 Debug"

CPP_SWITCHES=/nologo /MDd /W3 /Gm /GX /ZI /Od /D "WIN32" /D "_DEBUG" /D "_WINDOWS" /D "_AFXDLL" /D "_MBCS" /FR"$(INTDIR)\\" /Fp"$(INTDIR)\NifTo3ds.pch" /Yu"stdafx.h" /Fo"$(INTDIR)\\" /Fd"$(INTDIR)\\" /FD /GZ /c 

"$(INTDIR)\NifAlphaProperty.obj"	"$(INTDIR)\NifAlphaProperty.sbr" : $(SOURCE) "$(INTDIR)" "$(INTDIR)\NifTo3ds.pch"
	$(CPP) @<<
  $(CPP_SWITCHES) $(SOURCE)
<<


!ENDIF 

SOURCE=..\..\..\..\Source\uesp\Morrow\NIF\NifAmbientLight.cpp

!IF  "$(CFG)" == "NifTo3ds - Win32 Release"

CPP_SWITCHES=/nologo /MD /W3 /GX /O2 /D "WIN32" /D "NDEBUG" /D "_WINDOWS" /D "_AFXDLL" /D "_MBCS" /Fp"$(INTDIR)\NifTo3ds.pch" /Yu"stdafx.h" /Fo"$(INTDIR)\\" /Fd"$(INTDIR)\\" /FD /c 

"$(INTDIR)\NifAmbientLight.obj" : $(SOURCE) "$(INTDIR)" "$(INTDIR)\NifTo3ds.pch"
	$(CPP) @<<
  $(CPP_SWITCHES) $(SOURCE)
<<


!ELSEIF  "$(CFG)" == "NifTo3ds - Win32 Debug"

CPP_SWITCHES=/nologo /MDd /W3 /Gm /GX /ZI /Od /D "WIN32" /D "_DEBUG" /D "_WINDOWS" /D "_AFXDLL" /D "_MBCS" /FR"$(INTDIR)\\" /Fp"$(INTDIR)\NifTo3ds.pch" /Yu"stdafx.h" /Fo"$(INTDIR)\\" /Fd"$(INTDIR)\\" /FD /GZ /c 

"$(INTDIR)\NifAmbientLight.obj"	"$(INTDIR)\NifAmbientLight.sbr" : $(SOURCE) "$(INTDIR)" "$(INTDIR)\NifTo3ds.pch"
	$(CPP) @<<
  $(CPP_SWITCHES) $(SOURCE)
<<


!ENDIF 

SOURCE=..\..\..\..\Source\uesp\Morrow\NIF\NifAutoNormalParticles.cpp

!IF  "$(CFG)" == "NifTo3ds - Win32 Release"

CPP_SWITCHES=/nologo /MD /W3 /GX /O2 /D "WIN32" /D "NDEBUG" /D "_WINDOWS" /D "_AFXDLL" /D "_MBCS" /Fp"$(INTDIR)\NifTo3ds.pch" /Yu"stdafx.h" /Fo"$(INTDIR)\\" /Fd"$(INTDIR)\\" /FD /c 

"$(INTDIR)\NifAutoNormalParticles.obj" : $(SOURCE) "$(INTDIR)" "$(INTDIR)\NifTo3ds.pch"
	$(CPP) @<<
  $(CPP_SWITCHES) $(SOURCE)
<<


!ELSEIF  "$(CFG)" == "NifTo3ds - Win32 Debug"

CPP_SWITCHES=/nologo /MDd /W3 /Gm /GX /ZI /Od /D "WIN32" /D "_DEBUG" /D "_WINDOWS" /D "_AFXDLL" /D "_MBCS" /FR"$(INTDIR)\\" /Fp"$(INTDIR)\NifTo3ds.pch" /Yu"stdafx.h" /Fo"$(INTDIR)\\" /Fd"$(INTDIR)\\" /FD /GZ /c 

"$(INTDIR)\NifAutoNormalParticles.obj"	"$(INTDIR)\NifAutoNormalParticles.sbr" : $(SOURCE) "$(INTDIR)" "$(INTDIR)\NifTo3ds.pch"
	$(CPP) @<<
  $(CPP_SWITCHES) $(SOURCE)
<<


!ENDIF 

SOURCE=..\..\..\..\Source\uesp\Morrow\NIF\NifAutoNormalParticlesData.cpp

!IF  "$(CFG)" == "NifTo3ds - Win32 Release"

CPP_SWITCHES=/nologo /MD /W3 /GX /O2 /D "WIN32" /D "NDEBUG" /D "_WINDOWS" /D "_AFXDLL" /D "_MBCS" /Fp"$(INTDIR)\NifTo3ds.pch" /Yu"stdafx.h" /Fo"$(INTDIR)\\" /Fd"$(INTDIR)\\" /FD /c 

"$(INTDIR)\NifAutoNormalParticlesData.obj" : $(SOURCE) "$(INTDIR)" "$(INTDIR)\NifTo3ds.pch"
	$(CPP) @<<
  $(CPP_SWITCHES) $(SOURCE)
<<


!ELSEIF  "$(CFG)" == "NifTo3ds - Win32 Debug"

CPP_SWITCHES=/nologo /MDd /W3 /Gm /GX /ZI /Od /D "WIN32" /D "_DEBUG" /D "_WINDOWS" /D "_AFXDLL" /D "_MBCS" /FR"$(INTDIR)\\" /Fp"$(INTDIR)\NifTo3ds.pch" /Yu"stdafx.h" /Fo"$(INTDIR)\\" /Fd"$(INTDIR)\\" /FD /GZ /c 

"$(INTDIR)\NifAutoNormalParticlesData.obj"	"$(INTDIR)\NifAutoNormalParticlesData.sbr" : $(SOURCE) "$(INTDIR)" "$(INTDIR)\NifTo3ds.pch"
	$(CPP) @<<
  $(CPP_SWITCHES) $(SOURCE)
<<


!ENDIF 

SOURCE=..\..\..\..\Source\uesp\Morrow\NIF\NifBase.cpp

!IF  "$(CFG)" == "NifTo3ds - Win32 Release"

CPP_SWITCHES=/nologo /MD /W3 /GX /O2 /D "WIN32" /D "NDEBUG" /D "_WINDOWS" /D "_AFXDLL" /D "_MBCS" /Fp"$(INTDIR)\NifTo3ds.pch" /Yu"stdafx.h" /Fo"$(INTDIR)\\" /Fd"$(INTDIR)\\" /FD /c 

"$(INTDIR)\NifBase.obj" : $(SOURCE) "$(INTDIR)" "$(INTDIR)\NifTo3ds.pch"
	$(CPP) @<<
  $(CPP_SWITCHES) $(SOURCE)
<<


!ELSEIF  "$(CFG)" == "NifTo3ds - Win32 Debug"

CPP_SWITCHES=/nologo /MDd /W3 /Gm /GX /ZI /Od /D "WIN32" /D "_DEBUG" /D "_WINDOWS" /D "_AFXDLL" /D "_MBCS" /FR"$(INTDIR)\\" /Fp"$(INTDIR)\NifTo3ds.pch" /Yu"stdafx.h" /Fo"$(INTDIR)\\" /Fd"$(INTDIR)\\" /FD /GZ /c 

"$(INTDIR)\NifBase.obj"	"$(INTDIR)\NifBase.sbr" : $(SOURCE) "$(INTDIR)" "$(INTDIR)\NifTo3ds.pch"
	$(CPP) @<<
  $(CPP_SWITCHES) $(SOURCE)
<<


!ENDIF 

SOURCE=..\..\..\..\Source\uesp\Morrow\NIF\NifBillboardNode.cpp

!IF  "$(CFG)" == "NifTo3ds - Win32 Release"

CPP_SWITCHES=/nologo /MD /W3 /GX /O2 /D "WIN32" /D "NDEBUG" /D "_WINDOWS" /D "_AFXDLL" /D "_MBCS" /Fp"$(INTDIR)\NifTo3ds.pch" /Yu"stdafx.h" /Fo"$(INTDIR)\\" /Fd"$(INTDIR)\\" /FD /c 

"$(INTDIR)\NifBillboardNode.obj" : $(SOURCE) "$(INTDIR)" "$(INTDIR)\NifTo3ds.pch"
	$(CPP) @<<
  $(CPP_SWITCHES) $(SOURCE)
<<


!ELSEIF  "$(CFG)" == "NifTo3ds - Win32 Debug"

CPP_SWITCHES=/nologo /MDd /W3 /Gm /GX /ZI /Od /D "WIN32" /D "_DEBUG" /D "_WINDOWS" /D "_AFXDLL" /D "_MBCS" /FR"$(INTDIR)\\" /Fp"$(INTDIR)\NifTo3ds.pch" /Yu"stdafx.h" /Fo"$(INTDIR)\\" /Fd"$(INTDIR)\\" /FD /GZ /c 

"$(INTDIR)\NifBillboardNode.obj"	"$(INTDIR)\NifBillboardNode.sbr" : $(SOURCE) "$(INTDIR)" "$(INTDIR)\NifTo3ds.pch"
	$(CPP) @<<
  $(CPP_SWITCHES) $(SOURCE)
<<


!ENDIF 

SOURCE=..\..\..\..\Source\uesp\Morrow\NIF\NifBsAnimationNode.cpp

!IF  "$(CFG)" == "NifTo3ds - Win32 Release"

CPP_SWITCHES=/nologo /MD /W3 /GX /O2 /D "WIN32" /D "NDEBUG" /D "_WINDOWS" /D "_AFXDLL" /D "_MBCS" /Fp"$(INTDIR)\NifTo3ds.pch" /Yu"stdafx.h" /Fo"$(INTDIR)\\" /Fd"$(INTDIR)\\" /FD /c 

"$(INTDIR)\NifBsAnimationNode.obj" : $(SOURCE) "$(INTDIR)" "$(INTDIR)\NifTo3ds.pch"
	$(CPP) @<<
  $(CPP_SWITCHES) $(SOURCE)
<<


!ELSEIF  "$(CFG)" == "NifTo3ds - Win32 Debug"

CPP_SWITCHES=/nologo /MDd /W3 /Gm /GX /ZI /Od /D "WIN32" /D "_DEBUG" /D "_WINDOWS" /D "_AFXDLL" /D "_MBCS" /FR"$(INTDIR)\\" /Fp"$(INTDIR)\NifTo3ds.pch" /Yu"stdafx.h" /Fo"$(INTDIR)\\" /Fd"$(INTDIR)\\" /FD /GZ /c 

"$(INTDIR)\NifBsAnimationNode.obj"	"$(INTDIR)\NifBsAnimationNode.sbr" : $(SOURCE) "$(INTDIR)" "$(INTDIR)\NifTo3ds.pch"
	$(CPP) @<<
  $(CPP_SWITCHES) $(SOURCE)
<<


!ENDIF 

SOURCE=..\..\..\..\Source\uesp\Morrow\NIF\NifBSPArrayController.cpp

!IF  "$(CFG)" == "NifTo3ds - Win32 Release"

CPP_SWITCHES=/nologo /MD /W3 /GX /O2 /D "WIN32" /D "NDEBUG" /D "_WINDOWS" /D "_AFXDLL" /D "_MBCS" /Fp"$(INTDIR)\NifTo3ds.pch" /Yu"stdafx.h" /Fo"$(INTDIR)\\" /Fd"$(INTDIR)\\" /FD /c 

"$(INTDIR)\NifBSPArrayController.obj" : $(SOURCE) "$(INTDIR)" "$(INTDIR)\NifTo3ds.pch"
	$(CPP) @<<
  $(CPP_SWITCHES) $(SOURCE)
<<


!ELSEIF  "$(CFG)" == "NifTo3ds - Win32 Debug"

CPP_SWITCHES=/nologo /MDd /W3 /Gm /GX /ZI /Od /D "WIN32" /D "_DEBUG" /D "_WINDOWS" /D "_AFXDLL" /D "_MBCS" /FR"$(INTDIR)\\" /Fp"$(INTDIR)\NifTo3ds.pch" /Yu"stdafx.h" /Fo"$(INTDIR)\\" /Fd"$(INTDIR)\\" /FD /GZ /c 

"$(INTDIR)\NifBSPArrayController.obj"	"$(INTDIR)\NifBSPArrayController.sbr" : $(SOURCE) "$(INTDIR)" "$(INTDIR)\NifTo3ds.pch"
	$(CPP) @<<
  $(CPP_SWITCHES) $(SOURCE)
<<


!ENDIF 

SOURCE=..\..\..\..\Source\uesp\Morrow\NIF\NifCamera.cpp

!IF  "$(CFG)" == "NifTo3ds - Win32 Release"

CPP_SWITCHES=/nologo /MD /W3 /GX /O2 /D "WIN32" /D "NDEBUG" /D "_WINDOWS" /D "_AFXDLL" /D "_MBCS" /Fp"$(INTDIR)\NifTo3ds.pch" /Yu"stdafx.h" /Fo"$(INTDIR)\\" /Fd"$(INTDIR)\\" /FD /c 

"$(INTDIR)\NifCamera.obj" : $(SOURCE) "$(INTDIR)" "$(INTDIR)\NifTo3ds.pch"
	$(CPP) @<<
  $(CPP_SWITCHES) $(SOURCE)
<<


!ELSEIF  "$(CFG)" == "NifTo3ds - Win32 Debug"

CPP_SWITCHES=/nologo /MDd /W3 /Gm /GX /ZI /Od /D "WIN32" /D "_DEBUG" /D "_WINDOWS" /D "_AFXDLL" /D "_MBCS" /FR"$(INTDIR)\\" /Fp"$(INTDIR)\NifTo3ds.pch" /Yu"stdafx.h" /Fo"$(INTDIR)\\" /Fd"$(INTDIR)\\" /FD /GZ /c 

"$(INTDIR)\NifCamera.obj"	"$(INTDIR)\NifCamera.sbr" : $(SOURCE) "$(INTDIR)" "$(INTDIR)\NifTo3ds.pch"
	$(CPP) @<<
  $(CPP_SWITCHES) $(SOURCE)
<<


!ENDIF 

SOURCE=..\..\..\..\Source\uesp\Morrow\NIF\NifColorData.cpp

!IF  "$(CFG)" == "NifTo3ds - Win32 Release"

CPP_SWITCHES=/nologo /MD /W3 /GX /O2 /D "WIN32" /D "NDEBUG" /D "_WINDOWS" /D "_AFXDLL" /D "_MBCS" /Fp"$(INTDIR)\NifTo3ds.pch" /Yu"stdafx.h" /Fo"$(INTDIR)\\" /Fd"$(INTDIR)\\" /FD /c 

"$(INTDIR)\NifColorData.obj" : $(SOURCE) "$(INTDIR)" "$(INTDIR)\NifTo3ds.pch"
	$(CPP) @<<
  $(CPP_SWITCHES) $(SOURCE)
<<


!ELSEIF  "$(CFG)" == "NifTo3ds - Win32 Debug"

CPP_SWITCHES=/nologo /MDd /W3 /Gm /GX /ZI /Od /D "WIN32" /D "_DEBUG" /D "_WINDOWS" /D "_AFXDLL" /D "_MBCS" /FR"$(INTDIR)\\" /Fp"$(INTDIR)\NifTo3ds.pch" /Yu"stdafx.h" /Fo"$(INTDIR)\\" /Fd"$(INTDIR)\\" /FD /GZ /c 

"$(INTDIR)\NifColorData.obj"	"$(INTDIR)\NifColorData.sbr" : $(SOURCE) "$(INTDIR)" "$(INTDIR)\NifTo3ds.pch"
	$(CPP) @<<
  $(CPP_SWITCHES) $(SOURCE)
<<


!ENDIF 

SOURCE=..\..\..\..\Source\uesp\Morrow\NIF\NifDirectionalLight.cpp

!IF  "$(CFG)" == "NifTo3ds - Win32 Release"

CPP_SWITCHES=/nologo /MD /W3 /GX /O2 /D "WIN32" /D "NDEBUG" /D "_WINDOWS" /D "_AFXDLL" /D "_MBCS" /Fp"$(INTDIR)\NifTo3ds.pch" /Yu"stdafx.h" /Fo"$(INTDIR)\\" /Fd"$(INTDIR)\\" /FD /c 

"$(INTDIR)\NifDirectionalLight.obj" : $(SOURCE) "$(INTDIR)" "$(INTDIR)\NifTo3ds.pch"
	$(CPP) @<<
  $(CPP_SWITCHES) $(SOURCE)
<<


!ELSEIF  "$(CFG)" == "NifTo3ds - Win32 Debug"

CPP_SWITCHES=/nologo /MDd /W3 /Gm /GX /ZI /Od /D "WIN32" /D "_DEBUG" /D "_WINDOWS" /D "_AFXDLL" /D "_MBCS" /FR"$(INTDIR)\\" /Fp"$(INTDIR)\NifTo3ds.pch" /Yu"stdafx.h" /Fo"$(INTDIR)\\" /Fd"$(INTDIR)\\" /FD /GZ /c 

"$(INTDIR)\NifDirectionalLight.obj"	"$(INTDIR)\NifDirectionalLight.sbr" : $(SOURCE) "$(INTDIR)" "$(INTDIR)\NifTo3ds.pch"
	$(CPP) @<<
  $(CPP_SWITCHES) $(SOURCE)
<<


!ENDIF 

SOURCE=..\..\..\..\Source\uesp\Morrow\NIF\NifEndFile.cpp

!IF  "$(CFG)" == "NifTo3ds - Win32 Release"

CPP_SWITCHES=/nologo /MD /W3 /GX /O2 /D "WIN32" /D "NDEBUG" /D "_WINDOWS" /D "_AFXDLL" /D "_MBCS" /Fp"$(INTDIR)\NifTo3ds.pch" /Yu"stdafx.h" /Fo"$(INTDIR)\\" /Fd"$(INTDIR)\\" /FD /c 

"$(INTDIR)\NifEndFile.obj" : $(SOURCE) "$(INTDIR)" "$(INTDIR)\NifTo3ds.pch"
	$(CPP) @<<
  $(CPP_SWITCHES) $(SOURCE)
<<


!ELSEIF  "$(CFG)" == "NifTo3ds - Win32 Debug"

CPP_SWITCHES=/nologo /MDd /W3 /Gm /GX /ZI /Od /D "WIN32" /D "_DEBUG" /D "_WINDOWS" /D "_AFXDLL" /D "_MBCS" /FR"$(INTDIR)\\" /Fp"$(INTDIR)\NifTo3ds.pch" /Yu"stdafx.h" /Fo"$(INTDIR)\\" /Fd"$(INTDIR)\\" /FD /GZ /c 

"$(INTDIR)\NifEndFile.obj"	"$(INTDIR)\NifEndFile.sbr" : $(SOURCE) "$(INTDIR)" "$(INTDIR)\NifTo3ds.pch"
	$(CPP) @<<
  $(CPP_SWITCHES) $(SOURCE)
<<


!ENDIF 

SOURCE=..\..\..\..\Source\uesp\Morrow\NIF\NifEOF.cpp

!IF  "$(CFG)" == "NifTo3ds - Win32 Release"

CPP_SWITCHES=/nologo /MD /W3 /GX /O2 /D "WIN32" /D "NDEBUG" /D "_WINDOWS" /D "_AFXDLL" /D "_MBCS" /Fp"$(INTDIR)\NifTo3ds.pch" /Yu"stdafx.h" /Fo"$(INTDIR)\\" /Fd"$(INTDIR)\\" /FD /c 

"$(INTDIR)\NifEOF.obj" : $(SOURCE) "$(INTDIR)" "$(INTDIR)\NifTo3ds.pch"
	$(CPP) @<<
  $(CPP_SWITCHES) $(SOURCE)
<<


!ELSEIF  "$(CFG)" == "NifTo3ds - Win32 Debug"

CPP_SWITCHES=/nologo /MDd /W3 /Gm /GX /ZI /Od /D "WIN32" /D "_DEBUG" /D "_WINDOWS" /D "_AFXDLL" /D "_MBCS" /FR"$(INTDIR)\\" /Fp"$(INTDIR)\NifTo3ds.pch" /Yu"stdafx.h" /Fo"$(INTDIR)\\" /Fd"$(INTDIR)\\" /FD /GZ /c 

"$(INTDIR)\NifEOF.obj"	"$(INTDIR)\NifEOF.sbr" : $(SOURCE) "$(INTDIR)" "$(INTDIR)\NifTo3ds.pch"
	$(CPP) @<<
  $(CPP_SWITCHES) $(SOURCE)
<<


!ENDIF 

SOURCE=..\..\..\..\Source\uesp\Morrow\NIF\NifFile.cpp

!IF  "$(CFG)" == "NifTo3ds - Win32 Release"

CPP_SWITCHES=/nologo /MD /W3 /GX /O2 /D "WIN32" /D "NDEBUG" /D "_WINDOWS" /D "_AFXDLL" /D "_MBCS" /Fp"$(INTDIR)\NifTo3ds.pch" /Yu"stdafx.h" /Fo"$(INTDIR)\\" /Fd"$(INTDIR)\\" /FD /c 

"$(INTDIR)\NifFile.obj" : $(SOURCE) "$(INTDIR)" "$(INTDIR)\NifTo3ds.pch"
	$(CPP) @<<
  $(CPP_SWITCHES) $(SOURCE)
<<


!ELSEIF  "$(CFG)" == "NifTo3ds - Win32 Debug"

CPP_SWITCHES=/nologo /MDd /W3 /Gm /GX /ZI /Od /D "WIN32" /D "_DEBUG" /D "_WINDOWS" /D "_AFXDLL" /D "_MBCS" /FR"$(INTDIR)\\" /Fp"$(INTDIR)\NifTo3ds.pch" /Yu"stdafx.h" /Fo"$(INTDIR)\\" /Fd"$(INTDIR)\\" /FD /GZ /c 

"$(INTDIR)\NifFile.obj"	"$(INTDIR)\NifFile.sbr" : $(SOURCE) "$(INTDIR)" "$(INTDIR)\NifTo3ds.pch"
	$(CPP) @<<
  $(CPP_SWITCHES) $(SOURCE)
<<


!ENDIF 

SOURCE=..\..\..\..\Source\uesp\Morrow\NIF\NifFloatArray.cpp

!IF  "$(CFG)" == "NifTo3ds - Win32 Release"

CPP_SWITCHES=/nologo /MD /W3 /GX /O2 /D "WIN32" /D "NDEBUG" /D "_WINDOWS" /D "_AFXDLL" /D "_MBCS" /Fp"$(INTDIR)\NifTo3ds.pch" /Yu"stdafx.h" /Fo"$(INTDIR)\\" /Fd"$(INTDIR)\\" /FD /c 

"$(INTDIR)\NifFloatArray.obj" : $(SOURCE) "$(INTDIR)" "$(INTDIR)\NifTo3ds.pch"
	$(CPP) @<<
  $(CPP_SWITCHES) $(SOURCE)
<<


!ELSEIF  "$(CFG)" == "NifTo3ds - Win32 Debug"

CPP_SWITCHES=/nologo /MDd /W3 /Gm /GX /ZI /Od /D "WIN32" /D "_DEBUG" /D "_WINDOWS" /D "_AFXDLL" /D "_MBCS" /FR"$(INTDIR)\\" /Fp"$(INTDIR)\NifTo3ds.pch" /Yu"stdafx.h" /Fo"$(INTDIR)\\" /Fd"$(INTDIR)\\" /FD /GZ /c 

"$(INTDIR)\NifFloatArray.obj"	"$(INTDIR)\NifFloatArray.sbr" : $(SOURCE) "$(INTDIR)" "$(INTDIR)\NifTo3ds.pch"
	$(CPP) @<<
  $(CPP_SWITCHES) $(SOURCE)
<<


!ENDIF 

SOURCE=..\..\..\..\Source\uesp\Morrow\NIF\NifFloatData.cpp

!IF  "$(CFG)" == "NifTo3ds - Win32 Release"

CPP_SWITCHES=/nologo /MD /W3 /GX /O2 /D "WIN32" /D "NDEBUG" /D "_WINDOWS" /D "_AFXDLL" /D "_MBCS" /Fp"$(INTDIR)\NifTo3ds.pch" /Yu"stdafx.h" /Fo"$(INTDIR)\\" /Fd"$(INTDIR)\\" /FD /c 

"$(INTDIR)\NifFloatData.obj" : $(SOURCE) "$(INTDIR)" "$(INTDIR)\NifTo3ds.pch"
	$(CPP) @<<
  $(CPP_SWITCHES) $(SOURCE)
<<


!ELSEIF  "$(CFG)" == "NifTo3ds - Win32 Debug"

CPP_SWITCHES=/nologo /MDd /W3 /Gm /GX /ZI /Od /D "WIN32" /D "_DEBUG" /D "_WINDOWS" /D "_AFXDLL" /D "_MBCS" /FR"$(INTDIR)\\" /Fp"$(INTDIR)\NifTo3ds.pch" /Yu"stdafx.h" /Fo"$(INTDIR)\\" /Fd"$(INTDIR)\\" /FD /GZ /c 

"$(INTDIR)\NifFloatData.obj"	"$(INTDIR)\NifFloatData.sbr" : $(SOURCE) "$(INTDIR)" "$(INTDIR)\NifTo3ds.pch"
	$(CPP) @<<
  $(CPP_SWITCHES) $(SOURCE)
<<


!ENDIF 

SOURCE=..\..\..\..\Source\uesp\Morrow\NIF\NifGeomMorpherController.cpp

!IF  "$(CFG)" == "NifTo3ds - Win32 Release"

CPP_SWITCHES=/nologo /MD /W3 /GX /O2 /D "WIN32" /D "NDEBUG" /D "_WINDOWS" /D "_AFXDLL" /D "_MBCS" /Fp"$(INTDIR)\NifTo3ds.pch" /Yu"stdafx.h" /Fo"$(INTDIR)\\" /Fd"$(INTDIR)\\" /FD /c 

"$(INTDIR)\NifGeomMorpherController.obj" : $(SOURCE) "$(INTDIR)" "$(INTDIR)\NifTo3ds.pch"
	$(CPP) @<<
  $(CPP_SWITCHES) $(SOURCE)
<<


!ELSEIF  "$(CFG)" == "NifTo3ds - Win32 Debug"

CPP_SWITCHES=/nologo /MDd /W3 /Gm /GX /ZI /Od /D "WIN32" /D "_DEBUG" /D "_WINDOWS" /D "_AFXDLL" /D "_MBCS" /FR"$(INTDIR)\\" /Fp"$(INTDIR)\NifTo3ds.pch" /Yu"stdafx.h" /Fo"$(INTDIR)\\" /Fd"$(INTDIR)\\" /FD /GZ /c 

"$(INTDIR)\NifGeomMorpherController.obj"	"$(INTDIR)\NifGeomMorpherController.sbr" : $(SOURCE) "$(INTDIR)" "$(INTDIR)\NifTo3ds.pch"
	$(CPP) @<<
  $(CPP_SWITCHES) $(SOURCE)
<<


!ENDIF 

SOURCE=..\..\..\..\Source\uesp\Morrow\NIF\NifGravity.cpp

!IF  "$(CFG)" == "NifTo3ds - Win32 Release"

CPP_SWITCHES=/nologo /MD /W3 /GX /O2 /D "WIN32" /D "NDEBUG" /D "_WINDOWS" /D "_AFXDLL" /D "_MBCS" /Fp"$(INTDIR)\NifTo3ds.pch" /Yu"stdafx.h" /Fo"$(INTDIR)\\" /Fd"$(INTDIR)\\" /FD /c 

"$(INTDIR)\NifGravity.obj" : $(SOURCE) "$(INTDIR)" "$(INTDIR)\NifTo3ds.pch"
	$(CPP) @<<
  $(CPP_SWITCHES) $(SOURCE)
<<


!ELSEIF  "$(CFG)" == "NifTo3ds - Win32 Debug"

CPP_SWITCHES=/nologo /MDd /W3 /Gm /GX /ZI /Od /D "WIN32" /D "_DEBUG" /D "_WINDOWS" /D "_AFXDLL" /D "_MBCS" /FR"$(INTDIR)\\" /Fp"$(INTDIR)\NifTo3ds.pch" /Yu"stdafx.h" /Fo"$(INTDIR)\\" /Fd"$(INTDIR)\\" /FD /GZ /c 

"$(INTDIR)\NifGravity.obj"	"$(INTDIR)\NifGravity.sbr" : $(SOURCE) "$(INTDIR)" "$(INTDIR)\NifTo3ds.pch"
	$(CPP) @<<
  $(CPP_SWITCHES) $(SOURCE)
<<


!ENDIF 

SOURCE=..\..\..\..\Source\uesp\Morrow\NIF\NifKeyFrameController.cpp

!IF  "$(CFG)" == "NifTo3ds - Win32 Release"

CPP_SWITCHES=/nologo /MD /W3 /GX /O2 /D "WIN32" /D "NDEBUG" /D "_WINDOWS" /D "_AFXDLL" /D "_MBCS" /Fp"$(INTDIR)\NifTo3ds.pch" /Yu"stdafx.h" /Fo"$(INTDIR)\\" /Fd"$(INTDIR)\\" /FD /c 

"$(INTDIR)\NifKeyFrameController.obj" : $(SOURCE) "$(INTDIR)" "$(INTDIR)\NifTo3ds.pch"
	$(CPP) @<<
  $(CPP_SWITCHES) $(SOURCE)
<<


!ELSEIF  "$(CFG)" == "NifTo3ds - Win32 Debug"

CPP_SWITCHES=/nologo /MDd /W3 /Gm /GX /ZI /Od /D "WIN32" /D "_DEBUG" /D "_WINDOWS" /D "_AFXDLL" /D "_MBCS" /FR"$(INTDIR)\\" /Fp"$(INTDIR)\NifTo3ds.pch" /Yu"stdafx.h" /Fo"$(INTDIR)\\" /Fd"$(INTDIR)\\" /FD /GZ /c 

"$(INTDIR)\NifKeyFrameController.obj"	"$(INTDIR)\NifKeyFrameController.sbr" : $(SOURCE) "$(INTDIR)" "$(INTDIR)\NifTo3ds.pch"
	$(CPP) @<<
  $(CPP_SWITCHES) $(SOURCE)
<<


!ENDIF 

SOURCE=..\..\..\..\Source\uesp\Morrow\NIF\NifKeyFrameData.cpp

!IF  "$(CFG)" == "NifTo3ds - Win32 Release"

CPP_SWITCHES=/nologo /MD /W3 /GX /O2 /D "WIN32" /D "NDEBUG" /D "_WINDOWS" /D "_AFXDLL" /D "_MBCS" /Fp"$(INTDIR)\NifTo3ds.pch" /Yu"stdafx.h" /Fo"$(INTDIR)\\" /Fd"$(INTDIR)\\" /FD /c 

"$(INTDIR)\NifKeyFrameData.obj" : $(SOURCE) "$(INTDIR)" "$(INTDIR)\NifTo3ds.pch"
	$(CPP) @<<
  $(CPP_SWITCHES) $(SOURCE)
<<


!ELSEIF  "$(CFG)" == "NifTo3ds - Win32 Debug"

CPP_SWITCHES=/nologo /MDd /W3 /Gm /GX /ZI /Od /D "WIN32" /D "_DEBUG" /D "_WINDOWS" /D "_AFXDLL" /D "_MBCS" /FR"$(INTDIR)\\" /Fp"$(INTDIR)\NifTo3ds.pch" /Yu"stdafx.h" /Fo"$(INTDIR)\\" /Fd"$(INTDIR)\\" /FD /GZ /c 

"$(INTDIR)\NifKeyFrameData.obj"	"$(INTDIR)\NifKeyFrameData.sbr" : $(SOURCE) "$(INTDIR)" "$(INTDIR)\NifTo3ds.pch"
	$(CPP) @<<
  $(CPP_SWITCHES) $(SOURCE)
<<


!ENDIF 

SOURCE=..\..\..\..\Source\uesp\Morrow\NIF\NifLongArray.cpp

!IF  "$(CFG)" == "NifTo3ds - Win32 Release"

CPP_SWITCHES=/nologo /MD /W3 /GX /O2 /D "WIN32" /D "NDEBUG" /D "_WINDOWS" /D "_AFXDLL" /D "_MBCS" /Fp"$(INTDIR)\NifTo3ds.pch" /Yu"stdafx.h" /Fo"$(INTDIR)\\" /Fd"$(INTDIR)\\" /FD /c 

"$(INTDIR)\NifLongArray.obj" : $(SOURCE) "$(INTDIR)" "$(INTDIR)\NifTo3ds.pch"
	$(CPP) @<<
  $(CPP_SWITCHES) $(SOURCE)
<<


!ELSEIF  "$(CFG)" == "NifTo3ds - Win32 Debug"

CPP_SWITCHES=/nologo /MDd /W3 /Gm /GX /ZI /Od /D "WIN32" /D "_DEBUG" /D "_WINDOWS" /D "_AFXDLL" /D "_MBCS" /FR"$(INTDIR)\\" /Fp"$(INTDIR)\NifTo3ds.pch" /Yu"stdafx.h" /Fo"$(INTDIR)\\" /Fd"$(INTDIR)\\" /FD /GZ /c 

"$(INTDIR)\NifLongArray.obj"	"$(INTDIR)\NifLongArray.sbr" : $(SOURCE) "$(INTDIR)" "$(INTDIR)\NifTo3ds.pch"
	$(CPP) @<<
  $(CPP_SWITCHES) $(SOURCE)
<<


!ENDIF 

SOURCE=..\..\..\..\Source\uesp\Morrow\NIF\NifMaterialProperty.cpp

!IF  "$(CFG)" == "NifTo3ds - Win32 Release"

CPP_SWITCHES=/nologo /MD /W3 /GX /O2 /D "WIN32" /D "NDEBUG" /D "_WINDOWS" /D "_AFXDLL" /D "_MBCS" /Fp"$(INTDIR)\NifTo3ds.pch" /Yu"stdafx.h" /Fo"$(INTDIR)\\" /Fd"$(INTDIR)\\" /FD /c 

"$(INTDIR)\NifMaterialProperty.obj" : $(SOURCE) "$(INTDIR)" "$(INTDIR)\NifTo3ds.pch"
	$(CPP) @<<
  $(CPP_SWITCHES) $(SOURCE)
<<


!ELSEIF  "$(CFG)" == "NifTo3ds - Win32 Debug"

CPP_SWITCHES=/nologo /MDd /W3 /Gm /GX /ZI /Od /D "WIN32" /D "_DEBUG" /D "_WINDOWS" /D "_AFXDLL" /D "_MBCS" /FR"$(INTDIR)\\" /Fp"$(INTDIR)\NifTo3ds.pch" /Yu"stdafx.h" /Fo"$(INTDIR)\\" /Fd"$(INTDIR)\\" /FD /GZ /c 

"$(INTDIR)\NifMaterialProperty.obj"	"$(INTDIR)\NifMaterialProperty.sbr" : $(SOURCE) "$(INTDIR)" "$(INTDIR)\NifTo3ds.pch"
	$(CPP) @<<
  $(CPP_SWITCHES) $(SOURCE)
<<


!ENDIF 

SOURCE=..\..\..\..\Source\uesp\Morrow\NIF\NifMorphData.cpp

!IF  "$(CFG)" == "NifTo3ds - Win32 Release"

CPP_SWITCHES=/nologo /MD /W3 /GX /O2 /D "WIN32" /D "NDEBUG" /D "_WINDOWS" /D "_AFXDLL" /D "_MBCS" /Fp"$(INTDIR)\NifTo3ds.pch" /Yu"stdafx.h" /Fo"$(INTDIR)\\" /Fd"$(INTDIR)\\" /FD /c 

"$(INTDIR)\NifMorphData.obj" : $(SOURCE) "$(INTDIR)" "$(INTDIR)\NifTo3ds.pch"
	$(CPP) @<<
  $(CPP_SWITCHES) $(SOURCE)
<<


!ELSEIF  "$(CFG)" == "NifTo3ds - Win32 Debug"

CPP_SWITCHES=/nologo /MDd /W3 /Gm /GX /ZI /Od /D "WIN32" /D "_DEBUG" /D "_WINDOWS" /D "_AFXDLL" /D "_MBCS" /FR"$(INTDIR)\\" /Fp"$(INTDIR)\NifTo3ds.pch" /Yu"stdafx.h" /Fo"$(INTDIR)\\" /Fd"$(INTDIR)\\" /FD /GZ /c 

"$(INTDIR)\NifMorphData.obj"	"$(INTDIR)\NifMorphData.sbr" : $(SOURCE) "$(INTDIR)" "$(INTDIR)\NifTo3ds.pch"
	$(CPP) @<<
  $(CPP_SWITCHES) $(SOURCE)
<<


!ENDIF 

SOURCE=..\..\..\..\Source\uesp\Morrow\NIF\NifNode.cpp

!IF  "$(CFG)" == "NifTo3ds - Win32 Release"

CPP_SWITCHES=/nologo /MD /W3 /GX /O2 /D "WIN32" /D "NDEBUG" /D "_WINDOWS" /D "_AFXDLL" /D "_MBCS" /Fp"$(INTDIR)\NifTo3ds.pch" /Yu"stdafx.h" /Fo"$(INTDIR)\\" /Fd"$(INTDIR)\\" /FD /c 

"$(INTDIR)\NifNode.obj" : $(SOURCE) "$(INTDIR)" "$(INTDIR)\NifTo3ds.pch"
	$(CPP) @<<
  $(CPP_SWITCHES) $(SOURCE)
<<


!ELSEIF  "$(CFG)" == "NifTo3ds - Win32 Debug"

CPP_SWITCHES=/nologo /MDd /W3 /Gm /GX /ZI /Od /D "WIN32" /D "_DEBUG" /D "_WINDOWS" /D "_AFXDLL" /D "_MBCS" /FR"$(INTDIR)\\" /Fp"$(INTDIR)\NifTo3ds.pch" /Yu"stdafx.h" /Fo"$(INTDIR)\\" /Fd"$(INTDIR)\\" /FD /GZ /c 

"$(INTDIR)\NifNode.obj"	"$(INTDIR)\NifNode.sbr" : $(SOURCE) "$(INTDIR)" "$(INTDIR)\NifTo3ds.pch"
	$(CPP) @<<
  $(CPP_SWITCHES) $(SOURCE)
<<


!ENDIF 

SOURCE=..\..\..\..\Source\uesp\Morrow\NIF\NifParticleColorModifier.cpp

!IF  "$(CFG)" == "NifTo3ds - Win32 Release"

CPP_SWITCHES=/nologo /MD /W3 /GX /O2 /D "WIN32" /D "NDEBUG" /D "_WINDOWS" /D "_AFXDLL" /D "_MBCS" /Fp"$(INTDIR)\NifTo3ds.pch" /Yu"stdafx.h" /Fo"$(INTDIR)\\" /Fd"$(INTDIR)\\" /FD /c 

"$(INTDIR)\NifParticleColorModifier.obj" : $(SOURCE) "$(INTDIR)" "$(INTDIR)\NifTo3ds.pch"
	$(CPP) @<<
  $(CPP_SWITCHES) $(SOURCE)
<<


!ELSEIF  "$(CFG)" == "NifTo3ds - Win32 Debug"

CPP_SWITCHES=/nologo /MDd /W3 /Gm /GX /ZI /Od /D "WIN32" /D "_DEBUG" /D "_WINDOWS" /D "_AFXDLL" /D "_MBCS" /FR"$(INTDIR)\\" /Fp"$(INTDIR)\NifTo3ds.pch" /Yu"stdafx.h" /Fo"$(INTDIR)\\" /Fd"$(INTDIR)\\" /FD /GZ /c 

"$(INTDIR)\NifParticleColorModifier.obj"	"$(INTDIR)\NifParticleColorModifier.sbr" : $(SOURCE) "$(INTDIR)" "$(INTDIR)\NifTo3ds.pch"
	$(CPP) @<<
  $(CPP_SWITCHES) $(SOURCE)
<<


!ENDIF 

SOURCE=..\..\..\..\Source\uesp\Morrow\NIF\NifParticleGrowFade.cpp

!IF  "$(CFG)" == "NifTo3ds - Win32 Release"

CPP_SWITCHES=/nologo /MD /W3 /GX /O2 /D "WIN32" /D "NDEBUG" /D "_WINDOWS" /D "_AFXDLL" /D "_MBCS" /Fp"$(INTDIR)\NifTo3ds.pch" /Yu"stdafx.h" /Fo"$(INTDIR)\\" /Fd"$(INTDIR)\\" /FD /c 

"$(INTDIR)\NifParticleGrowFade.obj" : $(SOURCE) "$(INTDIR)" "$(INTDIR)\NifTo3ds.pch"
	$(CPP) @<<
  $(CPP_SWITCHES) $(SOURCE)
<<


!ELSEIF  "$(CFG)" == "NifTo3ds - Win32 Debug"

CPP_SWITCHES=/nologo /MDd /W3 /Gm /GX /ZI /Od /D "WIN32" /D "_DEBUG" /D "_WINDOWS" /D "_AFXDLL" /D "_MBCS" /FR"$(INTDIR)\\" /Fp"$(INTDIR)\NifTo3ds.pch" /Yu"stdafx.h" /Fo"$(INTDIR)\\" /Fd"$(INTDIR)\\" /FD /GZ /c 

"$(INTDIR)\NifParticleGrowFade.obj"	"$(INTDIR)\NifParticleGrowFade.sbr" : $(SOURCE) "$(INTDIR)" "$(INTDIR)\NifTo3ds.pch"
	$(CPP) @<<
  $(CPP_SWITCHES) $(SOURCE)
<<


!ENDIF 

SOURCE=..\..\..\..\Source\uesp\Morrow\NIF\NifParticleNode.cpp

!IF  "$(CFG)" == "NifTo3ds - Win32 Release"

CPP_SWITCHES=/nologo /MD /W3 /GX /O2 /D "WIN32" /D "NDEBUG" /D "_WINDOWS" /D "_AFXDLL" /D "_MBCS" /Fp"$(INTDIR)\NifTo3ds.pch" /Yu"stdafx.h" /Fo"$(INTDIR)\\" /Fd"$(INTDIR)\\" /FD /c 

"$(INTDIR)\NifParticleNode.obj" : $(SOURCE) "$(INTDIR)" "$(INTDIR)\NifTo3ds.pch"
	$(CPP) @<<
  $(CPP_SWITCHES) $(SOURCE)
<<


!ELSEIF  "$(CFG)" == "NifTo3ds - Win32 Debug"

CPP_SWITCHES=/nologo /MDd /W3 /Gm /GX /ZI /Od /D "WIN32" /D "_DEBUG" /D "_WINDOWS" /D "_AFXDLL" /D "_MBCS" /FR"$(INTDIR)\\" /Fp"$(INTDIR)\NifTo3ds.pch" /Yu"stdafx.h" /Fo"$(INTDIR)\\" /Fd"$(INTDIR)\\" /FD /GZ /c 

"$(INTDIR)\NifParticleNode.obj"	"$(INTDIR)\NifParticleNode.sbr" : $(SOURCE) "$(INTDIR)" "$(INTDIR)\NifTo3ds.pch"
	$(CPP) @<<
  $(CPP_SWITCHES) $(SOURCE)
<<


!ENDIF 

SOURCE=..\..\..\..\Source\uesp\Morrow\NIF\NifParticleRotation.cpp

!IF  "$(CFG)" == "NifTo3ds - Win32 Release"

CPP_SWITCHES=/nologo /MD /W3 /GX /O2 /D "WIN32" /D "NDEBUG" /D "_WINDOWS" /D "_AFXDLL" /D "_MBCS" /Fp"$(INTDIR)\NifTo3ds.pch" /Yu"stdafx.h" /Fo"$(INTDIR)\\" /Fd"$(INTDIR)\\" /FD /c 

"$(INTDIR)\NifParticleRotation.obj" : $(SOURCE) "$(INTDIR)" "$(INTDIR)\NifTo3ds.pch"
	$(CPP) @<<
  $(CPP_SWITCHES) $(SOURCE)
<<


!ELSEIF  "$(CFG)" == "NifTo3ds - Win32 Debug"

CPP_SWITCHES=/nologo /MDd /W3 /Gm /GX /ZI /Od /D "WIN32" /D "_DEBUG" /D "_WINDOWS" /D "_AFXDLL" /D "_MBCS" /FR"$(INTDIR)\\" /Fp"$(INTDIR)\NifTo3ds.pch" /Yu"stdafx.h" /Fo"$(INTDIR)\\" /Fd"$(INTDIR)\\" /FD /GZ /c 

"$(INTDIR)\NifParticleRotation.obj"	"$(INTDIR)\NifParticleRotation.sbr" : $(SOURCE) "$(INTDIR)" "$(INTDIR)\NifTo3ds.pch"
	$(CPP) @<<
  $(CPP_SWITCHES) $(SOURCE)
<<


!ENDIF 

SOURCE=..\..\..\..\Source\uesp\Morrow\NIF\NifParticleSysController.cpp

!IF  "$(CFG)" == "NifTo3ds - Win32 Release"

CPP_SWITCHES=/nologo /MD /W3 /GX /O2 /D "WIN32" /D "NDEBUG" /D "_WINDOWS" /D "_AFXDLL" /D "_MBCS" /Fp"$(INTDIR)\NifTo3ds.pch" /Yu"stdafx.h" /Fo"$(INTDIR)\\" /Fd"$(INTDIR)\\" /FD /c 

"$(INTDIR)\NifParticleSysController.obj" : $(SOURCE) "$(INTDIR)" "$(INTDIR)\NifTo3ds.pch"
	$(CPP) @<<
  $(CPP_SWITCHES) $(SOURCE)
<<


!ELSEIF  "$(CFG)" == "NifTo3ds - Win32 Debug"

CPP_SWITCHES=/nologo /MDd /W3 /Gm /GX /ZI /Od /D "WIN32" /D "_DEBUG" /D "_WINDOWS" /D "_AFXDLL" /D "_MBCS" /FR"$(INTDIR)\\" /Fp"$(INTDIR)\NifTo3ds.pch" /Yu"stdafx.h" /Fo"$(INTDIR)\\" /Fd"$(INTDIR)\\" /FD /GZ /c 

"$(INTDIR)\NifParticleSysController.obj"	"$(INTDIR)\NifParticleSysController.sbr" : $(SOURCE) "$(INTDIR)" "$(INTDIR)\NifTo3ds.pch"
	$(CPP) @<<
  $(CPP_SWITCHES) $(SOURCE)
<<


!ENDIF 

SOURCE=..\..\..\..\Source\uesp\Morrow\NIF\NifPathController.cpp

!IF  "$(CFG)" == "NifTo3ds - Win32 Release"

CPP_SWITCHES=/nologo /MD /W3 /GX /O2 /D "WIN32" /D "NDEBUG" /D "_WINDOWS" /D "_AFXDLL" /D "_MBCS" /Fp"$(INTDIR)\NifTo3ds.pch" /Yu"stdafx.h" /Fo"$(INTDIR)\\" /Fd"$(INTDIR)\\" /FD /c 

"$(INTDIR)\NifPathController.obj" : $(SOURCE) "$(INTDIR)" "$(INTDIR)\NifTo3ds.pch"
	$(CPP) @<<
  $(CPP_SWITCHES) $(SOURCE)
<<


!ELSEIF  "$(CFG)" == "NifTo3ds - Win32 Debug"

CPP_SWITCHES=/nologo /MDd /W3 /Gm /GX /ZI /Od /D "WIN32" /D "_DEBUG" /D "_WINDOWS" /D "_AFXDLL" /D "_MBCS" /FR"$(INTDIR)\\" /Fp"$(INTDIR)\NifTo3ds.pch" /Yu"stdafx.h" /Fo"$(INTDIR)\\" /Fd"$(INTDIR)\\" /FD /GZ /c 

"$(INTDIR)\NifPathController.obj"	"$(INTDIR)\NifPathController.sbr" : $(SOURCE) "$(INTDIR)" "$(INTDIR)\NifTo3ds.pch"
	$(CPP) @<<
  $(CPP_SWITCHES) $(SOURCE)
<<


!ENDIF 

SOURCE=..\..\..\..\Source\uesp\Morrow\NIF\NifPixelData.cpp

!IF  "$(CFG)" == "NifTo3ds - Win32 Release"

CPP_SWITCHES=/nologo /MD /W3 /GX /O2 /D "WIN32" /D "NDEBUG" /D "_WINDOWS" /D "_AFXDLL" /D "_MBCS" /Fp"$(INTDIR)\NifTo3ds.pch" /Yu"stdafx.h" /Fo"$(INTDIR)\\" /Fd"$(INTDIR)\\" /FD /c 

"$(INTDIR)\NifPixelData.obj" : $(SOURCE) "$(INTDIR)" "$(INTDIR)\NifTo3ds.pch"
	$(CPP) @<<
  $(CPP_SWITCHES) $(SOURCE)
<<


!ELSEIF  "$(CFG)" == "NifTo3ds - Win32 Debug"

CPP_SWITCHES=/nologo /MDd /W3 /Gm /GX /ZI /Od /D "WIN32" /D "_DEBUG" /D "_WINDOWS" /D "_AFXDLL" /D "_MBCS" /FR"$(INTDIR)\\" /Fp"$(INTDIR)\NifTo3ds.pch" /Yu"stdafx.h" /Fo"$(INTDIR)\\" /Fd"$(INTDIR)\\" /FD /GZ /c 

"$(INTDIR)\NifPixelData.obj"	"$(INTDIR)\NifPixelData.sbr" : $(SOURCE) "$(INTDIR)" "$(INTDIR)\NifTo3ds.pch"
	$(CPP) @<<
  $(CPP_SWITCHES) $(SOURCE)
<<


!ENDIF 

SOURCE=..\..\..\..\Source\uesp\Morrow\NIF\NifPosData.cpp

!IF  "$(CFG)" == "NifTo3ds - Win32 Release"

CPP_SWITCHES=/nologo /MD /W3 /GX /O2 /D "WIN32" /D "NDEBUG" /D "_WINDOWS" /D "_AFXDLL" /D "_MBCS" /Fp"$(INTDIR)\NifTo3ds.pch" /Yu"stdafx.h" /Fo"$(INTDIR)\\" /Fd"$(INTDIR)\\" /FD /c 

"$(INTDIR)\NifPosData.obj" : $(SOURCE) "$(INTDIR)" "$(INTDIR)\NifTo3ds.pch"
	$(CPP) @<<
  $(CPP_SWITCHES) $(SOURCE)
<<


!ELSEIF  "$(CFG)" == "NifTo3ds - Win32 Debug"

CPP_SWITCHES=/nologo /MDd /W3 /Gm /GX /ZI /Od /D "WIN32" /D "_DEBUG" /D "_WINDOWS" /D "_AFXDLL" /D "_MBCS" /FR"$(INTDIR)\\" /Fp"$(INTDIR)\NifTo3ds.pch" /Yu"stdafx.h" /Fo"$(INTDIR)\\" /Fd"$(INTDIR)\\" /FD /GZ /c 

"$(INTDIR)\NifPosData.obj"	"$(INTDIR)\NifPosData.sbr" : $(SOURCE) "$(INTDIR)" "$(INTDIR)\NifTo3ds.pch"
	$(CPP) @<<
  $(CPP_SWITCHES) $(SOURCE)
<<


!ENDIF 

SOURCE=..\..\..\..\Source\uesp\Morrow\NIF\NifRootCollisionNode.cpp

!IF  "$(CFG)" == "NifTo3ds - Win32 Release"

CPP_SWITCHES=/nologo /MD /W3 /GX /O2 /D "WIN32" /D "NDEBUG" /D "_WINDOWS" /D "_AFXDLL" /D "_MBCS" /Fp"$(INTDIR)\NifTo3ds.pch" /Yu"stdafx.h" /Fo"$(INTDIR)\\" /Fd"$(INTDIR)\\" /FD /c 

"$(INTDIR)\NifRootCollisionNode.obj" : $(SOURCE) "$(INTDIR)" "$(INTDIR)\NifTo3ds.pch"
	$(CPP) @<<
  $(CPP_SWITCHES) $(SOURCE)
<<


!ELSEIF  "$(CFG)" == "NifTo3ds - Win32 Debug"

CPP_SWITCHES=/nologo /MDd /W3 /Gm /GX /ZI /Od /D "WIN32" /D "_DEBUG" /D "_WINDOWS" /D "_AFXDLL" /D "_MBCS" /FR"$(INTDIR)\\" /Fp"$(INTDIR)\NifTo3ds.pch" /Yu"stdafx.h" /Fo"$(INTDIR)\\" /Fd"$(INTDIR)\\" /FD /GZ /c 

"$(INTDIR)\NifRootCollisionNode.obj"	"$(INTDIR)\NifRootCollisionNode.sbr" : $(SOURCE) "$(INTDIR)" "$(INTDIR)\NifTo3ds.pch"
	$(CPP) @<<
  $(CPP_SWITCHES) $(SOURCE)
<<


!ENDIF 

SOURCE=..\..\..\..\Source\uesp\Morrow\NIF\NifRotatingParticles.cpp

!IF  "$(CFG)" == "NifTo3ds - Win32 Release"

CPP_SWITCHES=/nologo /MD /W3 /GX /O2 /D "WIN32" /D "NDEBUG" /D "_WINDOWS" /D "_AFXDLL" /D "_MBCS" /Fp"$(INTDIR)\NifTo3ds.pch" /Yu"stdafx.h" /Fo"$(INTDIR)\\" /Fd"$(INTDIR)\\" /FD /c 

"$(INTDIR)\NifRotatingParticles.obj" : $(SOURCE) "$(INTDIR)" "$(INTDIR)\NifTo3ds.pch"
	$(CPP) @<<
  $(CPP_SWITCHES) $(SOURCE)
<<


!ELSEIF  "$(CFG)" == "NifTo3ds - Win32 Debug"

CPP_SWITCHES=/nologo /MDd /W3 /Gm /GX /ZI /Od /D "WIN32" /D "_DEBUG" /D "_WINDOWS" /D "_AFXDLL" /D "_MBCS" /FR"$(INTDIR)\\" /Fp"$(INTDIR)\NifTo3ds.pch" /Yu"stdafx.h" /Fo"$(INTDIR)\\" /Fd"$(INTDIR)\\" /FD /GZ /c 

"$(INTDIR)\NifRotatingParticles.obj"	"$(INTDIR)\NifRotatingParticles.sbr" : $(SOURCE) "$(INTDIR)" "$(INTDIR)\NifTo3ds.pch"
	$(CPP) @<<
  $(CPP_SWITCHES) $(SOURCE)
<<


!ENDIF 

SOURCE=..\..\..\..\Source\uesp\Morrow\NIF\NifRotatingParticlesData.cpp

!IF  "$(CFG)" == "NifTo3ds - Win32 Release"

CPP_SWITCHES=/nologo /MD /W3 /GX /O2 /D "WIN32" /D "NDEBUG" /D "_WINDOWS" /D "_AFXDLL" /D "_MBCS" /Fp"$(INTDIR)\NifTo3ds.pch" /Yu"stdafx.h" /Fo"$(INTDIR)\\" /Fd"$(INTDIR)\\" /FD /c 

"$(INTDIR)\NifRotatingParticlesData.obj" : $(SOURCE) "$(INTDIR)" "$(INTDIR)\NifTo3ds.pch"
	$(CPP) @<<
  $(CPP_SWITCHES) $(SOURCE)
<<


!ELSEIF  "$(CFG)" == "NifTo3ds - Win32 Debug"

CPP_SWITCHES=/nologo /MDd /W3 /Gm /GX /ZI /Od /D "WIN32" /D "_DEBUG" /D "_WINDOWS" /D "_AFXDLL" /D "_MBCS" /FR"$(INTDIR)\\" /Fp"$(INTDIR)\NifTo3ds.pch" /Yu"stdafx.h" /Fo"$(INTDIR)\\" /Fd"$(INTDIR)\\" /FD /GZ /c 

"$(INTDIR)\NifRotatingParticlesData.obj"	"$(INTDIR)\NifRotatingParticlesData.sbr" : $(SOURCE) "$(INTDIR)" "$(INTDIR)\NifTo3ds.pch"
	$(CPP) @<<
  $(CPP_SWITCHES) $(SOURCE)
<<


!ENDIF 

SOURCE=..\..\..\..\Source\uesp\Morrow\NIF\NifShadeProperty.cpp

!IF  "$(CFG)" == "NifTo3ds - Win32 Release"

CPP_SWITCHES=/nologo /MD /W3 /GX /O2 /D "WIN32" /D "NDEBUG" /D "_WINDOWS" /D "_AFXDLL" /D "_MBCS" /Fp"$(INTDIR)\NifTo3ds.pch" /Yu"stdafx.h" /Fo"$(INTDIR)\\" /Fd"$(INTDIR)\\" /FD /c 

"$(INTDIR)\NifShadeProperty.obj" : $(SOURCE) "$(INTDIR)" "$(INTDIR)\NifTo3ds.pch"
	$(CPP) @<<
  $(CPP_SWITCHES) $(SOURCE)
<<


!ELSEIF  "$(CFG)" == "NifTo3ds - Win32 Debug"

CPP_SWITCHES=/nologo /MDd /W3 /Gm /GX /ZI /Od /D "WIN32" /D "_DEBUG" /D "_WINDOWS" /D "_AFXDLL" /D "_MBCS" /FR"$(INTDIR)\\" /Fp"$(INTDIR)\NifTo3ds.pch" /Yu"stdafx.h" /Fo"$(INTDIR)\\" /Fd"$(INTDIR)\\" /FD /GZ /c 

"$(INTDIR)\NifShadeProperty.obj"	"$(INTDIR)\NifShadeProperty.sbr" : $(SOURCE) "$(INTDIR)" "$(INTDIR)\NifTo3ds.pch"
	$(CPP) @<<
  $(CPP_SWITCHES) $(SOURCE)
<<


!ENDIF 

SOURCE=..\..\..\..\Source\uesp\Morrow\NIF\NifSkinData.cpp

!IF  "$(CFG)" == "NifTo3ds - Win32 Release"

CPP_SWITCHES=/nologo /MD /W3 /GX /O2 /D "WIN32" /D "NDEBUG" /D "_WINDOWS" /D "_AFXDLL" /D "_MBCS" /Fp"$(INTDIR)\NifTo3ds.pch" /Yu"stdafx.h" /Fo"$(INTDIR)\\" /Fd"$(INTDIR)\\" /FD /c 

"$(INTDIR)\NifSkinData.obj" : $(SOURCE) "$(INTDIR)" "$(INTDIR)\NifTo3ds.pch"
	$(CPP) @<<
  $(CPP_SWITCHES) $(SOURCE)
<<


!ELSEIF  "$(CFG)" == "NifTo3ds - Win32 Debug"

CPP_SWITCHES=/nologo /MDd /W3 /Gm /GX /ZI /Od /D "WIN32" /D "_DEBUG" /D "_WINDOWS" /D "_AFXDLL" /D "_MBCS" /FR"$(INTDIR)\\" /Fp"$(INTDIR)\NifTo3ds.pch" /Yu"stdafx.h" /Fo"$(INTDIR)\\" /Fd"$(INTDIR)\\" /FD /GZ /c 

"$(INTDIR)\NifSkinData.obj"	"$(INTDIR)\NifSkinData.sbr" : $(SOURCE) "$(INTDIR)" "$(INTDIR)\NifTo3ds.pch"
	$(CPP) @<<
  $(CPP_SWITCHES) $(SOURCE)
<<


!ENDIF 

SOURCE=..\..\..\..\Source\uesp\Morrow\NIF\NifSkinInstance.cpp

!IF  "$(CFG)" == "NifTo3ds - Win32 Release"

CPP_SWITCHES=/nologo /MD /W3 /GX /O2 /D "WIN32" /D "NDEBUG" /D "_WINDOWS" /D "_AFXDLL" /D "_MBCS" /Fp"$(INTDIR)\NifTo3ds.pch" /Yu"stdafx.h" /Fo"$(INTDIR)\\" /Fd"$(INTDIR)\\" /FD /c 

"$(INTDIR)\NifSkinInstance.obj" : $(SOURCE) "$(INTDIR)" "$(INTDIR)\NifTo3ds.pch"
	$(CPP) @<<
  $(CPP_SWITCHES) $(SOURCE)
<<


!ELSEIF  "$(CFG)" == "NifTo3ds - Win32 Debug"

CPP_SWITCHES=/nologo /MDd /W3 /Gm /GX /ZI /Od /D "WIN32" /D "_DEBUG" /D "_WINDOWS" /D "_AFXDLL" /D "_MBCS" /FR"$(INTDIR)\\" /Fp"$(INTDIR)\NifTo3ds.pch" /Yu"stdafx.h" /Fo"$(INTDIR)\\" /Fd"$(INTDIR)\\" /FD /GZ /c 

"$(INTDIR)\NifSkinInstance.obj"	"$(INTDIR)\NifSkinInstance.sbr" : $(SOURCE) "$(INTDIR)" "$(INTDIR)\NifTo3ds.pch"
	$(CPP) @<<
  $(CPP_SWITCHES) $(SOURCE)
<<


!ENDIF 

SOURCE=..\..\..\..\Source\uesp\Morrow\NIF\NifSourceTexture.cpp

!IF  "$(CFG)" == "NifTo3ds - Win32 Release"

CPP_SWITCHES=/nologo /MD /W3 /GX /O2 /D "WIN32" /D "NDEBUG" /D "_WINDOWS" /D "_AFXDLL" /D "_MBCS" /Fp"$(INTDIR)\NifTo3ds.pch" /Yu"stdafx.h" /Fo"$(INTDIR)\\" /Fd"$(INTDIR)\\" /FD /c 

"$(INTDIR)\NifSourceTexture.obj" : $(SOURCE) "$(INTDIR)" "$(INTDIR)\NifTo3ds.pch"
	$(CPP) @<<
  $(CPP_SWITCHES) $(SOURCE)
<<


!ELSEIF  "$(CFG)" == "NifTo3ds - Win32 Debug"

CPP_SWITCHES=/nologo /MDd /W3 /Gm /GX /ZI /Od /D "WIN32" /D "_DEBUG" /D "_WINDOWS" /D "_AFXDLL" /D "_MBCS" /FR"$(INTDIR)\\" /Fp"$(INTDIR)\NifTo3ds.pch" /Yu"stdafx.h" /Fo"$(INTDIR)\\" /Fd"$(INTDIR)\\" /FD /GZ /c 

"$(INTDIR)\NifSourceTexture.obj"	"$(INTDIR)\NifSourceTexture.sbr" : $(SOURCE) "$(INTDIR)" "$(INTDIR)\NifTo3ds.pch"
	$(CPP) @<<
  $(CPP_SWITCHES) $(SOURCE)
<<


!ENDIF 

SOURCE=..\..\..\..\Source\uesp\Morrow\NIF\NifStringData.cpp

!IF  "$(CFG)" == "NifTo3ds - Win32 Release"

CPP_SWITCHES=/nologo /MD /W3 /GX /O2 /D "WIN32" /D "NDEBUG" /D "_WINDOWS" /D "_AFXDLL" /D "_MBCS" /Fp"$(INTDIR)\NifTo3ds.pch" /Yu"stdafx.h" /Fo"$(INTDIR)\\" /Fd"$(INTDIR)\\" /FD /c 

"$(INTDIR)\NifStringData.obj" : $(SOURCE) "$(INTDIR)" "$(INTDIR)\NifTo3ds.pch"
	$(CPP) @<<
  $(CPP_SWITCHES) $(SOURCE)
<<


!ELSEIF  "$(CFG)" == "NifTo3ds - Win32 Debug"

CPP_SWITCHES=/nologo /MDd /W3 /Gm /GX /ZI /Od /D "WIN32" /D "_DEBUG" /D "_WINDOWS" /D "_AFXDLL" /D "_MBCS" /FR"$(INTDIR)\\" /Fp"$(INTDIR)\NifTo3ds.pch" /Yu"stdafx.h" /Fo"$(INTDIR)\\" /Fd"$(INTDIR)\\" /FD /GZ /c 

"$(INTDIR)\NifStringData.obj"	"$(INTDIR)\NifStringData.sbr" : $(SOURCE) "$(INTDIR)" "$(INTDIR)\NifTo3ds.pch"
	$(CPP) @<<
  $(CPP_SWITCHES) $(SOURCE)
<<


!ENDIF 

SOURCE=..\..\..\..\Source\uesp\Morrow\NIF\NifTextKeyExtraData.cpp

!IF  "$(CFG)" == "NifTo3ds - Win32 Release"

CPP_SWITCHES=/nologo /MD /W3 /GX /O2 /D "WIN32" /D "NDEBUG" /D "_WINDOWS" /D "_AFXDLL" /D "_MBCS" /Fp"$(INTDIR)\NifTo3ds.pch" /Yu"stdafx.h" /Fo"$(INTDIR)\\" /Fd"$(INTDIR)\\" /FD /c 

"$(INTDIR)\NifTextKeyExtraData.obj" : $(SOURCE) "$(INTDIR)" "$(INTDIR)\NifTo3ds.pch"
	$(CPP) @<<
  $(CPP_SWITCHES) $(SOURCE)
<<


!ELSEIF  "$(CFG)" == "NifTo3ds - Win32 Debug"

CPP_SWITCHES=/nologo /MDd /W3 /Gm /GX /ZI /Od /D "WIN32" /D "_DEBUG" /D "_WINDOWS" /D "_AFXDLL" /D "_MBCS" /FR"$(INTDIR)\\" /Fp"$(INTDIR)\NifTo3ds.pch" /Yu"stdafx.h" /Fo"$(INTDIR)\\" /Fd"$(INTDIR)\\" /FD /GZ /c 

"$(INTDIR)\NifTextKeyExtraData.obj"	"$(INTDIR)\NifTextKeyExtraData.sbr" : $(SOURCE) "$(INTDIR)" "$(INTDIR)\NifTo3ds.pch"
	$(CPP) @<<
  $(CPP_SWITCHES) $(SOURCE)
<<


!ENDIF 

SOURCE=..\..\..\..\Source\uesp\Morrow\NIF\NifTextureEffect.cpp

!IF  "$(CFG)" == "NifTo3ds - Win32 Release"

CPP_SWITCHES=/nologo /MD /W3 /GX /O2 /D "WIN32" /D "NDEBUG" /D "_WINDOWS" /D "_AFXDLL" /D "_MBCS" /Fp"$(INTDIR)\NifTo3ds.pch" /Yu"stdafx.h" /Fo"$(INTDIR)\\" /Fd"$(INTDIR)\\" /FD /c 

"$(INTDIR)\NifTextureEffect.obj" : $(SOURCE) "$(INTDIR)" "$(INTDIR)\NifTo3ds.pch"
	$(CPP) @<<
  $(CPP_SWITCHES) $(SOURCE)
<<


!ELSEIF  "$(CFG)" == "NifTo3ds - Win32 Debug"

CPP_SWITCHES=/nologo /MDd /W3 /Gm /GX /ZI /Od /D "WIN32" /D "_DEBUG" /D "_WINDOWS" /D "_AFXDLL" /D "_MBCS" /FR"$(INTDIR)\\" /Fp"$(INTDIR)\NifTo3ds.pch" /Yu"stdafx.h" /Fo"$(INTDIR)\\" /Fd"$(INTDIR)\\" /FD /GZ /c 

"$(INTDIR)\NifTextureEffect.obj"	"$(INTDIR)\NifTextureEffect.sbr" : $(SOURCE) "$(INTDIR)" "$(INTDIR)\NifTo3ds.pch"
	$(CPP) @<<
  $(CPP_SWITCHES) $(SOURCE)
<<


!ENDIF 

SOURCE=..\..\..\..\Source\uesp\Morrow\NIF\NifTextureProperty.cpp

!IF  "$(CFG)" == "NifTo3ds - Win32 Release"

CPP_SWITCHES=/nologo /MD /W3 /GX /O2 /D "WIN32" /D "NDEBUG" /D "_WINDOWS" /D "_AFXDLL" /D "_MBCS" /Fp"$(INTDIR)\NifTo3ds.pch" /Yu"stdafx.h" /Fo"$(INTDIR)\\" /Fd"$(INTDIR)\\" /FD /c 

"$(INTDIR)\NifTextureProperty.obj" : $(SOURCE) "$(INTDIR)" "$(INTDIR)\NifTo3ds.pch"
	$(CPP) @<<
  $(CPP_SWITCHES) $(SOURCE)
<<


!ELSEIF  "$(CFG)" == "NifTo3ds - Win32 Debug"

CPP_SWITCHES=/nologo /MDd /W3 /Gm /GX /ZI /Od /D "WIN32" /D "_DEBUG" /D "_WINDOWS" /D "_AFXDLL" /D "_MBCS" /FR"$(INTDIR)\\" /Fp"$(INTDIR)\NifTo3ds.pch" /Yu"stdafx.h" /Fo"$(INTDIR)\\" /Fd"$(INTDIR)\\" /FD /GZ /c 

"$(INTDIR)\NifTextureProperty.obj"	"$(INTDIR)\NifTextureProperty.sbr" : $(SOURCE) "$(INTDIR)" "$(INTDIR)\NifTo3ds.pch"
	$(CPP) @<<
  $(CPP_SWITCHES) $(SOURCE)
<<


!ENDIF 

SOURCE=..\..\..\..\Source\uesp\Morrow\NIF\NifTriShape.cpp

!IF  "$(CFG)" == "NifTo3ds - Win32 Release"

CPP_SWITCHES=/nologo /MD /W3 /GX /O2 /D "WIN32" /D "NDEBUG" /D "_WINDOWS" /D "_AFXDLL" /D "_MBCS" /Fp"$(INTDIR)\NifTo3ds.pch" /Yu"stdafx.h" /Fo"$(INTDIR)\\" /Fd"$(INTDIR)\\" /FD /c 

"$(INTDIR)\NifTriShape.obj" : $(SOURCE) "$(INTDIR)" "$(INTDIR)\NifTo3ds.pch"
	$(CPP) @<<
  $(CPP_SWITCHES) $(SOURCE)
<<


!ELSEIF  "$(CFG)" == "NifTo3ds - Win32 Debug"

CPP_SWITCHES=/nologo /MDd /W3 /Gm /GX /ZI /Od /D "WIN32" /D "_DEBUG" /D "_WINDOWS" /D "_AFXDLL" /D "_MBCS" /FR"$(INTDIR)\\" /Fp"$(INTDIR)\NifTo3ds.pch" /Yu"stdafx.h" /Fo"$(INTDIR)\\" /Fd"$(INTDIR)\\" /FD /GZ /c 

"$(INTDIR)\NifTriShape.obj"	"$(INTDIR)\NifTriShape.sbr" : $(SOURCE) "$(INTDIR)" "$(INTDIR)\NifTo3ds.pch"
	$(CPP) @<<
  $(CPP_SWITCHES) $(SOURCE)
<<


!ENDIF 

SOURCE=..\..\..\..\Source\uesp\Morrow\NIF\NifTriShapeData.cpp

!IF  "$(CFG)" == "NifTo3ds - Win32 Release"

CPP_SWITCHES=/nologo /MD /W3 /GX /O2 /D "WIN32" /D "NDEBUG" /D "_WINDOWS" /D "_AFXDLL" /D "_MBCS" /Fp"$(INTDIR)\NifTo3ds.pch" /Yu"stdafx.h" /Fo"$(INTDIR)\\" /Fd"$(INTDIR)\\" /FD /c 

"$(INTDIR)\NifTriShapeData.obj" : $(SOURCE) "$(INTDIR)" "$(INTDIR)\NifTo3ds.pch"
	$(CPP) @<<
  $(CPP_SWITCHES) $(SOURCE)
<<


!ELSEIF  "$(CFG)" == "NifTo3ds - Win32 Debug"

CPP_SWITCHES=/nologo /MDd /W3 /Gm /GX /ZI /Od /D "WIN32" /D "_DEBUG" /D "_WINDOWS" /D "_AFXDLL" /D "_MBCS" /FR"$(INTDIR)\\" /Fp"$(INTDIR)\NifTo3ds.pch" /Yu"stdafx.h" /Fo"$(INTDIR)\\" /Fd"$(INTDIR)\\" /FD /GZ /c 

"$(INTDIR)\NifTriShapeData.obj"	"$(INTDIR)\NifTriShapeData.sbr" : $(SOURCE) "$(INTDIR)" "$(INTDIR)\NifTo3ds.pch"
	$(CPP) @<<
  $(CPP_SWITCHES) $(SOURCE)
<<


!ENDIF 

SOURCE=..\..\..\..\Source\uesp\Morrow\NIF\NifUVController.cpp

!IF  "$(CFG)" == "NifTo3ds - Win32 Release"

CPP_SWITCHES=/nologo /MD /W3 /GX /O2 /D "WIN32" /D "NDEBUG" /D "_WINDOWS" /D "_AFXDLL" /D "_MBCS" /Fp"$(INTDIR)\NifTo3ds.pch" /Yu"stdafx.h" /Fo"$(INTDIR)\\" /Fd"$(INTDIR)\\" /FD /c 

"$(INTDIR)\NifUVController.obj" : $(SOURCE) "$(INTDIR)" "$(INTDIR)\NifTo3ds.pch"
	$(CPP) @<<
  $(CPP_SWITCHES) $(SOURCE)
<<


!ELSEIF  "$(CFG)" == "NifTo3ds - Win32 Debug"

CPP_SWITCHES=/nologo /MDd /W3 /Gm /GX /ZI /Od /D "WIN32" /D "_DEBUG" /D "_WINDOWS" /D "_AFXDLL" /D "_MBCS" /FR"$(INTDIR)\\" /Fp"$(INTDIR)\NifTo3ds.pch" /Yu"stdafx.h" /Fo"$(INTDIR)\\" /Fd"$(INTDIR)\\" /FD /GZ /c 

"$(INTDIR)\NifUVController.obj"	"$(INTDIR)\NifUVController.sbr" : $(SOURCE) "$(INTDIR)" "$(INTDIR)\NifTo3ds.pch"
	$(CPP) @<<
  $(CPP_SWITCHES) $(SOURCE)
<<


!ENDIF 

SOURCE=..\..\..\..\Source\uesp\Morrow\NIF\NifUVData.cpp

!IF  "$(CFG)" == "NifTo3ds - Win32 Release"

CPP_SWITCHES=/nologo /MD /W3 /GX /O2 /D "WIN32" /D "NDEBUG" /D "_WINDOWS" /D "_AFXDLL" /D "_MBCS" /Fp"$(INTDIR)\NifTo3ds.pch" /Yu"stdafx.h" /Fo"$(INTDIR)\\" /Fd"$(INTDIR)\\" /FD /c 

"$(INTDIR)\NifUVData.obj" : $(SOURCE) "$(INTDIR)" "$(INTDIR)\NifTo3ds.pch"
	$(CPP) @<<
  $(CPP_SWITCHES) $(SOURCE)
<<


!ELSEIF  "$(CFG)" == "NifTo3ds - Win32 Debug"

CPP_SWITCHES=/nologo /MDd /W3 /Gm /GX /ZI /Od /D "WIN32" /D "_DEBUG" /D "_WINDOWS" /D "_AFXDLL" /D "_MBCS" /FR"$(INTDIR)\\" /Fp"$(INTDIR)\NifTo3ds.pch" /Yu"stdafx.h" /Fo"$(INTDIR)\\" /Fd"$(INTDIR)\\" /FD /GZ /c 

"$(INTDIR)\NifUVData.obj"	"$(INTDIR)\NifUVData.sbr" : $(SOURCE) "$(INTDIR)" "$(INTDIR)\NifTo3ds.pch"
	$(CPP) @<<
  $(CPP_SWITCHES) $(SOURCE)
<<


!ENDIF 

SOURCE=..\..\..\..\Source\uesp\Morrow\NIF\NifVertexColorProperty.cpp

!IF  "$(CFG)" == "NifTo3ds - Win32 Release"

CPP_SWITCHES=/nologo /MD /W3 /GX /O2 /D "WIN32" /D "NDEBUG" /D "_WINDOWS" /D "_AFXDLL" /D "_MBCS" /Fp"$(INTDIR)\NifTo3ds.pch" /Yu"stdafx.h" /Fo"$(INTDIR)\\" /Fd"$(INTDIR)\\" /FD /c 

"$(INTDIR)\NifVertexColorProperty.obj" : $(SOURCE) "$(INTDIR)" "$(INTDIR)\NifTo3ds.pch"
	$(CPP) @<<
  $(CPP_SWITCHES) $(SOURCE)
<<


!ELSEIF  "$(CFG)" == "NifTo3ds - Win32 Debug"

CPP_SWITCHES=/nologo /MDd /W3 /Gm /GX /ZI /Od /D "WIN32" /D "_DEBUG" /D "_WINDOWS" /D "_AFXDLL" /D "_MBCS" /FR"$(INTDIR)\\" /Fp"$(INTDIR)\NifTo3ds.pch" /Yu"stdafx.h" /Fo"$(INTDIR)\\" /Fd"$(INTDIR)\\" /FD /GZ /c 

"$(INTDIR)\NifVertexColorProperty.obj"	"$(INTDIR)\NifVertexColorProperty.sbr" : $(SOURCE) "$(INTDIR)" "$(INTDIR)\NifTo3ds.pch"
	$(CPP) @<<
  $(CPP_SWITCHES) $(SOURCE)
<<


!ENDIF 

SOURCE=..\..\..\..\Source\uesp\Morrow\NIF\NifVertWeightsExtraData.cpp

!IF  "$(CFG)" == "NifTo3ds - Win32 Release"

CPP_SWITCHES=/nologo /MD /W3 /GX /O2 /D "WIN32" /D "NDEBUG" /D "_WINDOWS" /D "_AFXDLL" /D "_MBCS" /Fp"$(INTDIR)\NifTo3ds.pch" /Yu"stdafx.h" /Fo"$(INTDIR)\\" /Fd"$(INTDIR)\\" /FD /c 

"$(INTDIR)\NifVertWeightsExtraData.obj" : $(SOURCE) "$(INTDIR)" "$(INTDIR)\NifTo3ds.pch"
	$(CPP) @<<
  $(CPP_SWITCHES) $(SOURCE)
<<


!ELSEIF  "$(CFG)" == "NifTo3ds - Win32 Debug"

CPP_SWITCHES=/nologo /MDd /W3 /Gm /GX /ZI /Od /D "WIN32" /D "_DEBUG" /D "_WINDOWS" /D "_AFXDLL" /D "_MBCS" /FR"$(INTDIR)\\" /Fp"$(INTDIR)\NifTo3ds.pch" /Yu"stdafx.h" /Fo"$(INTDIR)\\" /Fd"$(INTDIR)\\" /FD /GZ /c 

"$(INTDIR)\NifVertWeightsExtraData.obj"	"$(INTDIR)\NifVertWeightsExtraData.sbr" : $(SOURCE) "$(INTDIR)" "$(INTDIR)\NifTo3ds.pch"
	$(CPP) @<<
  $(CPP_SWITCHES) $(SOURCE)
<<


!ENDIF 

SOURCE=..\..\..\..\Source\uesp\Morrow\NIF\NifVisController.cpp

!IF  "$(CFG)" == "NifTo3ds - Win32 Release"

CPP_SWITCHES=/nologo /MD /W3 /GX /O2 /D "WIN32" /D "NDEBUG" /D "_WINDOWS" /D "_AFXDLL" /D "_MBCS" /Fp"$(INTDIR)\NifTo3ds.pch" /Yu"stdafx.h" /Fo"$(INTDIR)\\" /Fd"$(INTDIR)\\" /FD /c 

"$(INTDIR)\NifVisController.obj" : $(SOURCE) "$(INTDIR)" "$(INTDIR)\NifTo3ds.pch"
	$(CPP) @<<
  $(CPP_SWITCHES) $(SOURCE)
<<


!ELSEIF  "$(CFG)" == "NifTo3ds - Win32 Debug"

CPP_SWITCHES=/nologo /MDd /W3 /Gm /GX /ZI /Od /D "WIN32" /D "_DEBUG" /D "_WINDOWS" /D "_AFXDLL" /D "_MBCS" /FR"$(INTDIR)\\" /Fp"$(INTDIR)\NifTo3ds.pch" /Yu"stdafx.h" /Fo"$(INTDIR)\\" /Fd"$(INTDIR)\\" /FD /GZ /c 

"$(INTDIR)\NifVisController.obj"	"$(INTDIR)\NifVisController.sbr" : $(SOURCE) "$(INTDIR)" "$(INTDIR)\NifTo3ds.pch"
	$(CPP) @<<
  $(CPP_SWITCHES) $(SOURCE)
<<


!ENDIF 

SOURCE=..\..\..\..\Source\uesp\Morrow\NIF\NifVisData.cpp

!IF  "$(CFG)" == "NifTo3ds - Win32 Release"

CPP_SWITCHES=/nologo /MD /W3 /GX /O2 /D "WIN32" /D "NDEBUG" /D "_WINDOWS" /D "_AFXDLL" /D "_MBCS" /Fp"$(INTDIR)\NifTo3ds.pch" /Yu"stdafx.h" /Fo"$(INTDIR)\\" /Fd"$(INTDIR)\\" /FD /c 

"$(INTDIR)\NifVisData.obj" : $(SOURCE) "$(INTDIR)" "$(INTDIR)\NifTo3ds.pch"
	$(CPP) @<<
  $(CPP_SWITCHES) $(SOURCE)
<<


!ELSEIF  "$(CFG)" == "NifTo3ds - Win32 Debug"

CPP_SWITCHES=/nologo /MDd /W3 /Gm /GX /ZI /Od /D "WIN32" /D "_DEBUG" /D "_WINDOWS" /D "_AFXDLL" /D "_MBCS" /FR"$(INTDIR)\\" /Fp"$(INTDIR)\NifTo3ds.pch" /Yu"stdafx.h" /Fo"$(INTDIR)\\" /Fd"$(INTDIR)\\" /FD /GZ /c 

"$(INTDIR)\NifVisData.obj"	"$(INTDIR)\NifVisData.sbr" : $(SOURCE) "$(INTDIR)" "$(INTDIR)\NifTo3ds.pch"
	$(CPP) @<<
  $(CPP_SWITCHES) $(SOURCE)
<<


!ENDIF 

SOURCE=..\..\..\..\Source\uesp\Morrow\NIF\NifWireframeProperty.cpp

!IF  "$(CFG)" == "NifTo3ds - Win32 Release"

CPP_SWITCHES=/nologo /MD /W3 /GX /O2 /D "WIN32" /D "NDEBUG" /D "_WINDOWS" /D "_AFXDLL" /D "_MBCS" /Fp"$(INTDIR)\NifTo3ds.pch" /Yu"stdafx.h" /Fo"$(INTDIR)\\" /Fd"$(INTDIR)\\" /FD /c 

"$(INTDIR)\NifWireframeProperty.obj" : $(SOURCE) "$(INTDIR)" "$(INTDIR)\NifTo3ds.pch"
	$(CPP) @<<
  $(CPP_SWITCHES) $(SOURCE)
<<


!ELSEIF  "$(CFG)" == "NifTo3ds - Win32 Debug"

CPP_SWITCHES=/nologo /MDd /W3 /Gm /GX /ZI /Od /D "WIN32" /D "_DEBUG" /D "_WINDOWS" /D "_AFXDLL" /D "_MBCS" /FR"$(INTDIR)\\" /Fp"$(INTDIR)\NifTo3ds.pch" /Yu"stdafx.h" /Fo"$(INTDIR)\\" /Fd"$(INTDIR)\\" /FD /GZ /c 

"$(INTDIR)\NifWireframeProperty.obj"	"$(INTDIR)\NifWireframeProperty.sbr" : $(SOURCE) "$(INTDIR)" "$(INTDIR)\NifTo3ds.pch"
	$(CPP) @<<
  $(CPP_SWITCHES) $(SOURCE)
<<


!ENDIF 

SOURCE=..\..\..\..\Source\uesp\Morrow\NIF\NifZBufferProperty.cpp

!IF  "$(CFG)" == "NifTo3ds - Win32 Release"

CPP_SWITCHES=/nologo /MD /W3 /GX /O2 /D "WIN32" /D "NDEBUG" /D "_WINDOWS" /D "_AFXDLL" /D "_MBCS" /Fp"$(INTDIR)\NifTo3ds.pch" /Yu"stdafx.h" /Fo"$(INTDIR)\\" /Fd"$(INTDIR)\\" /FD /c 

"$(INTDIR)\NifZBufferProperty.obj" : $(SOURCE) "$(INTDIR)" "$(INTDIR)\NifTo3ds.pch"
	$(CPP) @<<
  $(CPP_SWITCHES) $(SOURCE)
<<


!ELSEIF  "$(CFG)" == "NifTo3ds - Win32 Debug"

CPP_SWITCHES=/nologo /MDd /W3 /Gm /GX /ZI /Od /D "WIN32" /D "_DEBUG" /D "_WINDOWS" /D "_AFXDLL" /D "_MBCS" /FR"$(INTDIR)\\" /Fp"$(INTDIR)\NifTo3ds.pch" /Yu"stdafx.h" /Fo"$(INTDIR)\\" /Fd"$(INTDIR)\\" /FD /GZ /c 

"$(INTDIR)\NifZBufferProperty.obj"	"$(INTDIR)\NifZBufferProperty.sbr" : $(SOURCE) "$(INTDIR)" "$(INTDIR)\NifTo3ds.pch"
	$(CPP) @<<
  $(CPP_SWITCHES) $(SOURCE)
<<


!ENDIF 

SOURCE=.\ConvertNif3ds.cpp

!IF  "$(CFG)" == "NifTo3ds - Win32 Release"

CPP_SWITCHES=/nologo /MD /W3 /GX /O2 /D "WIN32" /D "NDEBUG" /D "_WINDOWS" /D "_AFXDLL" /D "_MBCS" /Fp"$(INTDIR)\NifTo3ds.pch" /Yu"stdafx.h" /Fo"$(INTDIR)\\" /Fd"$(INTDIR)\\" /FD /c 

"$(INTDIR)\ConvertNif3ds.obj" : $(SOURCE) "$(INTDIR)" "$(INTDIR)\NifTo3ds.pch"
	$(CPP) @<<
  $(CPP_SWITCHES) $(SOURCE)
<<


!ELSEIF  "$(CFG)" == "NifTo3ds - Win32 Debug"

CPP_SWITCHES=/nologo /MDd /W3 /Gm /GX /ZI /Od /D "WIN32" /D "_DEBUG" /D "_WINDOWS" /D "_AFXDLL" /D "_MBCS" /FR"$(INTDIR)\\" /Fp"$(INTDIR)\NifTo3ds.pch" /Yu"stdafx.h" /Fo"$(INTDIR)\\" /Fd"$(INTDIR)\\" /FD /GZ /c 

"$(INTDIR)\ConvertNif3ds.obj"	"$(INTDIR)\ConvertNif3ds.sbr" : $(SOURCE) "$(INTDIR)" "$(INTDIR)\NifTo3ds.pch"
	$(CPP) @<<
  $(CPP_SWITCHES) $(SOURCE)
<<


!ENDIF 

SOURCE=.\NifTo3ds.cpp

!IF  "$(CFG)" == "NifTo3ds - Win32 Release"


"$(INTDIR)\NifTo3ds.obj" : $(SOURCE) "$(INTDIR)" "$(INTDIR)\NifTo3ds.pch"


!ELSEIF  "$(CFG)" == "NifTo3ds - Win32 Debug"


"$(INTDIR)\NifTo3ds.obj"	"$(INTDIR)\NifTo3ds.sbr" : $(SOURCE) "$(INTDIR)" "$(INTDIR)\NifTo3ds.pch"


!ENDIF 

SOURCE=.\hlp\NifTo3ds.hpj

!IF  "$(CFG)" == "NifTo3ds - Win32 Release"

OutDir=.\Release
InputPath=.\hlp\NifTo3ds.hpj
InputName=NifTo3ds

"$(INTDIR)\NifTo3ds.hlp" : $(SOURCE) "$(INTDIR)" "$(OUTDIR)"
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
	

!ELSEIF  "$(CFG)" == "NifTo3ds - Win32 Debug"

OutDir=.\Debug
InputPath=.\hlp\NifTo3ds.hpj
InputName=NifTo3ds

"$(INTDIR)\NifTo3ds.hlp" : $(SOURCE) "$(INTDIR)" "$(OUTDIR)"
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

SOURCE=.\NifTo3ds.rc

"$(INTDIR)\NifTo3ds.res" : $(SOURCE) "$(INTDIR)"
	$(RSC) $(RSC_PROJ) $(SOURCE)


SOURCE=.\NifTo3dsDlg.cpp

!IF  "$(CFG)" == "NifTo3ds - Win32 Release"


"$(INTDIR)\NifTo3dsDlg.obj" : $(SOURCE) "$(INTDIR)" "$(INTDIR)\NifTo3ds.pch"


!ELSEIF  "$(CFG)" == "NifTo3ds - Win32 Debug"


"$(INTDIR)\NifTo3dsDlg.obj"	"$(INTDIR)\NifTo3dsDlg.sbr" : $(SOURCE) "$(INTDIR)" "$(INTDIR)\NifTo3ds.pch"


!ENDIF 

SOURCE=.\StdAfx.cpp

!IF  "$(CFG)" == "NifTo3ds - Win32 Release"

CPP_SWITCHES=/nologo /MD /W3 /GX /O2 /D "WIN32" /D "NDEBUG" /D "_WINDOWS" /D "_AFXDLL" /D "_MBCS" /Fp"$(INTDIR)\NifTo3ds.pch" /Yc"stdafx.h" /Fo"$(INTDIR)\\" /Fd"$(INTDIR)\\" /FD /c 

"$(INTDIR)\StdAfx.obj"	"$(INTDIR)\NifTo3ds.pch" : $(SOURCE) "$(INTDIR)"
	$(CPP) @<<
  $(CPP_SWITCHES) $(SOURCE)
<<


!ELSEIF  "$(CFG)" == "NifTo3ds - Win32 Debug"

CPP_SWITCHES=/nologo /MDd /W3 /Gm /GX /ZI /Od /D "WIN32" /D "_DEBUG" /D "_WINDOWS" /D "_AFXDLL" /D "_MBCS" /FR"$(INTDIR)\\" /Fp"$(INTDIR)\NifTo3ds.pch" /Yc"stdafx.h" /Fo"$(INTDIR)\\" /Fd"$(INTDIR)\\" /FD /GZ /c 

"$(INTDIR)\StdAfx.obj"	"$(INTDIR)\StdAfx.sbr"	"$(INTDIR)\NifTo3ds.pch" : $(SOURCE) "$(INTDIR)"
	$(CPP) @<<
  $(CPP_SWITCHES) $(SOURCE)
<<


!ENDIF 

SOURCE=.\Resource.h

!IF  "$(CFG)" == "NifTo3ds - Win32 Release"

TargetName=NifTo3ds
InputPath=.\Resource.h

".\hlp\NifTo3ds.hm" : $(SOURCE) "$(INTDIR)" "$(OUTDIR)"
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
	

!ELSEIF  "$(CFG)" == "NifTo3ds - Win32 Debug"

TargetName=NifTo3ds
InputPath=.\Resource.h

".\hlp\NifTo3ds.hm" : $(SOURCE) "$(INTDIR)" "$(OUTDIR)"
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

SOURCE=.\hlp\NifTo3ds.cnt

!IF  "$(CFG)" == "NifTo3ds - Win32 Release"

OutDir=.\Release
InputPath=.\hlp\NifTo3ds.cnt
InputName=NifTo3ds

"$(INTDIR)\NifTo3ds.cnt" : $(SOURCE) "$(INTDIR)" "$(OUTDIR)"
	<<tempfile.bat 
	@echo off 
	copy "hlp\$(InputName).cnt" $(OutDir)
<< 
	

!ELSEIF  "$(CFG)" == "NifTo3ds - Win32 Debug"

OutDir=.\Debug
InputPath=.\hlp\NifTo3ds.cnt
InputName=NifTo3ds

"$(INTDIR)\NifTo3ds.cnt" : $(SOURCE) "$(INTDIR)" "$(OUTDIR)"
	<<tempfile.bat 
	@echo off 
	copy "hlp\$(InputName).cnt" $(OutDir)
<< 
	

!ENDIF 


!ENDIF 


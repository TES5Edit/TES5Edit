@echo off
REM -- First make map file from Microsoft Visual C++ generated resource.h
echo // MAKEHELP.BAT generated Help Map file.  Used by NIFTEXTURE.HPJ. >"hlp\NifTexture.hm"
echo. >>"hlp\NifTexture.hm"
echo // Commands (ID_* and IDM_*) >>"hlp\NifTexture.hm"
makehm ID_,HID_,0x10000 IDM_,HIDM_,0x10000 resource.h >>"hlp\NifTexture.hm"
echo. >>"hlp\NifTexture.hm"
echo // Prompts (IDP_*) >>"hlp\NifTexture.hm"
makehm IDP_,HIDP_,0x30000 resource.h >>"hlp\NifTexture.hm"
echo. >>"hlp\NifTexture.hm"
echo // Resources (IDR_*) >>"hlp\NifTexture.hm"
makehm IDR_,HIDR_,0x20000 resource.h >>"hlp\NifTexture.hm"
echo. >>"hlp\NifTexture.hm"
echo // Dialogs (IDD_*) >>"hlp\NifTexture.hm"
makehm IDD_,HIDD_,0x20000 resource.h >>"hlp\NifTexture.hm"
echo. >>"hlp\NifTexture.hm"
echo // Frame Controls (IDW_*) >>"hlp\NifTexture.hm"
makehm IDW_,HIDW_,0x50000 resource.h >>"hlp\NifTexture.hm"
REM -- Make help for Project NIFTEXTURE


echo Building Win32 Help files
start /wait hcw /C /E /M "hlp\NifTexture.hpj"
if errorlevel 1 goto :Error
if not exist "hlp\NifTexture.hlp" goto :Error
if not exist "hlp\NifTexture.cnt" goto :Error
echo.
if exist Debug\nul copy "hlp\NifTexture.hlp" Debug
if exist Debug\nul copy "hlp\NifTexture.cnt" Debug
if exist Release\nul copy "hlp\NifTexture.hlp" Release
if exist Release\nul copy "hlp\NifTexture.cnt" Release
echo.
goto :done

:Error
echo hlp\NifTexture.hpj(1) : error: Problem encountered creating help file

:done
echo.

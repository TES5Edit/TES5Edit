@echo off
REM -- First make map file from Microsoft Visual C++ generated resource.h
echo // MAKEHELP.BAT generated Help Map file.  Used by NIFTO3DS.HPJ. >"hlp\NifTo3ds.hm"
echo. >>"hlp\NifTo3ds.hm"
echo // Commands (ID_* and IDM_*) >>"hlp\NifTo3ds.hm"
makehm ID_,HID_,0x10000 IDM_,HIDM_,0x10000 resource.h >>"hlp\NifTo3ds.hm"
echo. >>"hlp\NifTo3ds.hm"
echo // Prompts (IDP_*) >>"hlp\NifTo3ds.hm"
makehm IDP_,HIDP_,0x30000 resource.h >>"hlp\NifTo3ds.hm"
echo. >>"hlp\NifTo3ds.hm"
echo // Resources (IDR_*) >>"hlp\NifTo3ds.hm"
makehm IDR_,HIDR_,0x20000 resource.h >>"hlp\NifTo3ds.hm"
echo. >>"hlp\NifTo3ds.hm"
echo // Dialogs (IDD_*) >>"hlp\NifTo3ds.hm"
makehm IDD_,HIDD_,0x20000 resource.h >>"hlp\NifTo3ds.hm"
echo. >>"hlp\NifTo3ds.hm"
echo // Frame Controls (IDW_*) >>"hlp\NifTo3ds.hm"
makehm IDW_,HIDW_,0x50000 resource.h >>"hlp\NifTo3ds.hm"
REM -- Make help for Project NIFTO3DS


echo Building Win32 Help files
start /wait hcw /C /E /M "hlp\NifTo3ds.hpj"
if errorlevel 1 goto :Error
if not exist "hlp\NifTo3ds.hlp" goto :Error
if not exist "hlp\NifTo3ds.cnt" goto :Error
echo.
if exist Debug\nul copy "hlp\NifTo3ds.hlp" Debug
if exist Debug\nul copy "hlp\NifTo3ds.cnt" Debug
if exist Release\nul copy "hlp\NifTo3ds.hlp" Release
if exist Release\nul copy "hlp\NifTo3ds.cnt" Release
echo.
goto :done

:Error
echo hlp\NifTo3ds.hpj(1) : error: Problem encountered creating help file

:done
echo.

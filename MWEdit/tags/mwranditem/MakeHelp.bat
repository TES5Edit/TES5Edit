@echo off
REM -- First make map file from Microsoft Visual C++ generated resource.h
echo // MAKEHELP.BAT generated Help Map file.  Used by MWRANDITEM.HPJ. >"hlp\MWRandItem.hm"
echo. >>"hlp\MWRandItem.hm"
echo // Commands (ID_* and IDM_*) >>"hlp\MWRandItem.hm"
makehm ID_,HID_,0x10000 IDM_,HIDM_,0x10000 resource.h >>"hlp\MWRandItem.hm"
echo. >>"hlp\MWRandItem.hm"
echo // Prompts (IDP_*) >>"hlp\MWRandItem.hm"
makehm IDP_,HIDP_,0x30000 resource.h >>"hlp\MWRandItem.hm"
echo. >>"hlp\MWRandItem.hm"
echo // Resources (IDR_*) >>"hlp\MWRandItem.hm"
makehm IDR_,HIDR_,0x20000 resource.h >>"hlp\MWRandItem.hm"
echo. >>"hlp\MWRandItem.hm"
echo // Dialogs (IDD_*) >>"hlp\MWRandItem.hm"
makehm IDD_,HIDD_,0x20000 resource.h >>"hlp\MWRandItem.hm"
echo. >>"hlp\MWRandItem.hm"
echo // Frame Controls (IDW_*) >>"hlp\MWRandItem.hm"
makehm IDW_,HIDW_,0x50000 resource.h >>"hlp\MWRandItem.hm"
REM -- Make help for Project MWRANDITEM


echo Building Win32 Help files
start /wait hcw /C /E /M "hlp\MWRandItem.hpj"
if errorlevel 1 goto :Error
if not exist "hlp\MWRandItem.hlp" goto :Error
if not exist "hlp\MWRandItem.cnt" goto :Error
echo.
if exist Debug\nul copy "hlp\MWRandItem.hlp" Debug
if exist Debug\nul copy "hlp\MWRandItem.cnt" Debug
if exist Release\nul copy "hlp\MWRandItem.hlp" Release
if exist Release\nul copy "hlp\MWRandItem.cnt" Release
echo.
goto :done

:Error
echo hlp\MWRandItem.hpj(1) : error: Problem encountered creating help file

:done
echo.

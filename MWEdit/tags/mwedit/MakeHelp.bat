@echo off
REM -- First make map file from Microsoft Visual C++ generated resource.h
echo // MAKEHELP.BAT generated Help Map file.  Used by MWEDIT.HPJ. >"hlp\MWEdit.hm"
echo. >>"hlp\MWEdit.hm"
echo // Commands (ID_* and IDM_*) >>"hlp\MWEdit.hm"
makehm ID_,HID_,0x10000 IDM_,HIDM_,0x10000 resource.h >>"hlp\MWEdit.hm"
echo. >>"hlp\MWEdit.hm"
echo // Prompts (IDP_*) >>"hlp\MWEdit.hm"
makehm IDP_,HIDP_,0x30000 resource.h >>"hlp\MWEdit.hm"
echo. >>"hlp\MWEdit.hm"
echo // Resources (IDR_*) >>"hlp\MWEdit.hm"
makehm IDR_,HIDR_,0x20000 resource.h >>"hlp\MWEdit.hm"
echo. >>"hlp\MWEdit.hm"
echo // Dialogs (IDD_*) >>"hlp\MWEdit.hm"
makehm IDD_,HIDD_,0x20000 resource.h >>"hlp\MWEdit.hm"
echo. >>"hlp\MWEdit.hm"
echo // Frame Controls (IDW_*) >>"hlp\MWEdit.hm"
makehm IDW_,HIDW_,0x50000 resource.h >>"hlp\MWEdit.hm"
REM -- Make help for Project MWEDIT


echo Building Win32 Help files
start /wait hcw /C /E /M "hlp\MWEdit.hpj"
if errorlevel 1 goto :Error
if not exist "hlp\MWEdit.hlp" goto :Error
if not exist "hlp\MWEdit.cnt" goto :Error
echo.
if exist Debug\nul copy "hlp\MWEdit.hlp" Debug
if exist Debug\nul copy "hlp\MWEdit.cnt" Debug
if exist Release\nul copy "hlp\MWEdit.hlp" Release
if exist Release\nul copy "hlp\MWEdit.cnt" Release
echo.
goto :done

:Error
echo hlp\MWEdit.hpj(1) : error: Problem encountered creating help file

:done
echo.

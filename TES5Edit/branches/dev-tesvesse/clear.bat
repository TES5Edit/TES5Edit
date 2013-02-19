REM @ECHO OFF
DEL /S *.dcu
DEL /S *.bak
DEL *.res
DEL *.drc
DEL *.cfg
DEL *.ident*
DEL *.local
DEL Resource.Res
RMDIR /S /Q __history
RMDIR /S /Q Forms\__history
RMDIR /S /Q Units\__history
REM sr /B- *.exe
REM upx --best --keep-resource=11 *.exe

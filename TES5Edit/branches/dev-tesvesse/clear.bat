@ECHO OFF
DEL /S *.dcu
DEL /S *.bak
DEL *.drc
DEL *.cfg
DEL *.ident*
DEL *.local
DEL Resource.Res
RMDIR /S /Q __history
RMDIR /S /Q Forms\__history
RMDIR /S /Q Units\__history
sr /B- *.exe
upx --best --keep-resource=11 *.exe

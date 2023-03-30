ECHO OFF
CLS
regedit /S "Files\UnInstall - Register COM Server Menus.reg"
DEL /F /Q "%windir%\RegisterCOMServer.exe"
CLS
ECHO REBOOT YOUR SYTEM, TO TAKE THE CHANGE IN EFFECT!!!

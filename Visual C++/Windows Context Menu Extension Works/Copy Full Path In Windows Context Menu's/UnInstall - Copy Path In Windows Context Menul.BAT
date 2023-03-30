ECHO OFF
CLS
regedit /S "Files\UnInstall - Copy Path Menu.reg"
DEL /F /Q "%windir%\CopyPath.exe"
CLS
ECHO REBOOT YOUR SYTEM, TO TAKE THE CHANGE IN EFFECT!!!

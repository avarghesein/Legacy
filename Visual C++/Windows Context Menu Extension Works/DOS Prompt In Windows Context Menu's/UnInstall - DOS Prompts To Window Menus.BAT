ECHO OFF
CLS
regedit /S "In File New Menu\UnInstall - DOS_PromptToNewMenu.reg"
DEL /F /Q "%windir%\StartDosFromFileNew.exe"
regedit /S "In Open Menu\UnInstall - DOS_PromptToOpenMenu.reg"
CLS
ECHO REBOOT YOUR SYTEM, TO TAKE THE CHANGE IN EFFECT!!!
PAUSE 1
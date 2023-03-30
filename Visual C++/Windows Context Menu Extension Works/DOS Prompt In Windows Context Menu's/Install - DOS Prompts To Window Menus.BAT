ECHO OFF
CLS
regedit /S "In File New Menu\Install - DOS_PromptToNewMenu.reg"
COPY "In File New Menu\StartDosFromFileNew.exe" "%windir%\StartDosFromFileNew.exe"
regedit /S "In Open Menu\Install - DOS_PromptToOpenMenu.reg"
CLS
ECHO REBOOT YOUR SYTEM, TO TAKE THE CHANGE IN EFFECT!!!
PAUSE 1

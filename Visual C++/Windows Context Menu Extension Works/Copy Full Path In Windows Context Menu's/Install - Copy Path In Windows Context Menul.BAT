ECHO OFF
CLS
regedit /S "Files\Install - Copy Path Menu.reg"
COPY "Files\CopyPath.exe" "%windir%\CopyPath.exe"
CLS
ECHO REBOOT YOUR SYTEM, TO TAKE THE CHANGE IN EFFECT!!!

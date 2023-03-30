ECHO OFF
CLS
regedit /S "Files\Install - Register COM Server Menus.reg"
COPY "Files\RegisterCOMServer.exe" "%windir%\RegisterCOMServer.exe"
CLS
ECHO REBOOT YOUR SYTEM, TO TAKE THE CHANGE IN EFFECT!!!

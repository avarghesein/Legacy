# Microsoft Developer Studio Project File - Name="Sample Server" - Package Owner=<4>
# Microsoft Developer Studio Generated Build File, Format Version 6.00
# ** DO NOT EDIT **

# TARGTYPE "Win32 (x86) Application" 0x0101

CFG=Sample Server - Win32 Unicode Release MinDependency
!MESSAGE This is not a valid makefile. To build this project using NMAKE,
!MESSAGE use the Export Makefile command and run
!MESSAGE 
!MESSAGE NMAKE /f "Sample Server.mak".
!MESSAGE 
!MESSAGE You can specify a configuration when running NMAKE
!MESSAGE by defining the macro CFG on the command line. For example:
!MESSAGE 
!MESSAGE NMAKE /f "Sample Server.mak" CFG="Sample Server - Win32 Unicode Release MinDependency"
!MESSAGE 
!MESSAGE Possible choices for configuration are:
!MESSAGE 
!MESSAGE "Sample Server - Win32 Unicode Release MinDependency" (based on "Win32 (x86) Application")
!MESSAGE "Sample Server - Win32 Unicode Release InProc DLL  server" (based on "Win32 (x86) Application")
!MESSAGE 

# Begin Project
# PROP AllowPerConfigDependencies 0
# PROP Scc_ProjName ""
# PROP Scc_LocalPath ""
CPP=cl.exe
MTL=midl.exe
RSC=rc.exe

!IF  "$(CFG)" == "Sample Server - Win32 Unicode Release MinDependency"

# PROP BASE Use_MFC 1
# PROP BASE Use_Debug_Libraries 0
# PROP BASE Output_Dir "ReleaseUMinDependency"
# PROP BASE Intermediate_Dir "ReleaseUMinDependency"
# PROP BASE Target_Dir ""
# PROP Use_MFC 2
# PROP Use_Debug_Libraries 0
# PROP Output_Dir "ReleaseUMinDependency"
# PROP Intermediate_Dir "ReleaseUMinDependency"
# PROP Ignore_Export_Lib 0
# PROP Target_Dir ""
# ADD BASE CPP /nologo /MT /W3 /GX /O1 /D "WIN32" /D "NDEBUG" /D "_WINDOWS" /D "_UNICODE" /Yu"stdafx.h" /FD /c
# ADD CPP /nologo /MD /W3 /GX /Zi /Od /D "WIN32" /D "NDEBUG" /D "_WINDOWS" /D "_UNICODE" /D "_ATL_STATIC_REGISTRY" /D "_AFXDLL" /D "BUILD_AS_SERVICE" /FR /Yu"stdafx.h" /FD /c
# ADD BASE MTL /nologo /D "NDEBUG" /mktyplib203 /win32
# ADD BASE RSC /l 0x409 /d "NDEBUG"
# ADD RSC /l 0x409 /d "NDEBUG" /d "_AFXDLL"
BSC32=bscmake.exe
# ADD BASE BSC32 /nologo
# ADD BSC32 /nologo
LINK32=link.exe
# ADD BASE LINK32 /nologo /subsystem:windows /machine:I386
# ADD LINK32 /nologo /subsystem:windows /map /debug /machine:I386 /out:"ReleaseUMinDependencyIn/Sample Server.exe"
# SUBTRACT LINK32 /incremental:yes
# Begin Special Build Tool
SOURCE="$(InputPath)"
PostBuild_Desc=Copy Lib
PostBuild_Cmds=copy    .\SampleServer.tlb    ..\Include\ 
# End Special Build Tool

!ELSEIF  "$(CFG)" == "Sample Server - Win32 Unicode Release InProc DLL  server"

# PROP BASE Use_MFC 2
# PROP BASE Use_Debug_Libraries 0
# PROP BASE Output_Dir "Unicode Release InProc DLL  server"
# PROP BASE Intermediate_Dir "Unicode Release InProc DLL  server"
# PROP BASE Target_Dir ""
# PROP Use_MFC 2
# PROP Use_Debug_Libraries 0
# PROP Output_Dir "Unicode Release InProc DLL  server"
# PROP Intermediate_Dir "Unicode Release InProc DLL  server"
# PROP Ignore_Export_Lib 0
# PROP Target_Dir ""
# ADD BASE CPP /nologo /MD /W3 /GX /O1 /D "WIN32" /D "NDEBUG" /D "_WINDOWS" /D "_UNICODE" /D "_ATL_STATIC_REGISTRY" /D "_AFXDLL" /Yu"stdafx.h" /FD /c
# ADD CPP /nologo /MD /W3 /Gm /GX /Zi /Od /D "WIN32" /D "NDEBUG" /D "_WINDOWS" /D "_WINDLL" /D "_AFXDLL" /D "_UNICODE" /D "_USRDLL" /FR /Fp"Sample Server___URelease_Inproc_server/Sample Server.pch" /Yu"stdafx.h" /Fo"Sample Server___URelease_Inproc_server/" /Fd"Sample Server___URelease_Inproc_server/" /FD /c
# ADD BASE RSC /l 0x409 /d "NDEBUG" /d "_AFXDLL"
# ADD RSC /l 0x409 /d "NDEBUG" /d "_AFXDLL"
BSC32=bscmake.exe
# ADD BASE BSC32 /nologo
# ADD BSC32 /nologo
LINK32=link.exe
# ADD BASE LINK32 /nologo /subsystem:windows /machine:I386
# ADD LINK32 /nologo /subsystem:windows /dll /pdb:"SampleServer___URelease_Inproc_server/SampleServer.pdb" /map /debug /machine:I386 /def:".\SampleServer.def" /out:"SampleServer___URelease_Inproc_server/SampleServer.dll" /implib:"SampleServer___URelease_Inproc_server/SampleServer.lib"
# SUBTRACT LINK32 /pdb:none
# Begin Special Build Tool
SOURCE="$(InputPath)"
PostBuild_Cmds=copy    .\SampleServer.tlb    ..\Include\ 
# End Special Build Tool

!ENDIF 

# Begin Target

# Name "Sample Server - Win32 Unicode Release MinDependency"
# Name "Sample Server - Win32 Unicode Release InProc DLL  server"
# Begin Group "Source Files"

# PROP Default_Filter "cpp;c;cxx;rc;def;r;odl;idl;hpj;bat"
# Begin Source File

SOURCE=.\Fun.cpp
# End Source File
# Begin Source File

SOURCE=".\Sample Server.cpp"
# End Source File
# Begin Source File

SOURCE=".\Sample Server.idl"
# ADD MTL /tlb ".\Sample Server.tlb" /h "Sample Server.h" /iid "Sample Server_i.c" /Oicf
# End Source File
# Begin Source File

SOURCE=".\Sample Server.rc"
# End Source File
# Begin Source File

SOURCE=.\StdAfx.cpp
# ADD BASE CPP /Yc"stdafx.h"
# ADD CPP /Yc"stdafx.h"
# End Source File
# End Group
# Begin Group "Header Files"

# PROP Default_Filter "h;hpp;hxx;hm;inl"
# Begin Source File

SOURCE=.\Fun.h
# End Source File
# Begin Source File

SOURCE=.\Resource.h
# End Source File
# Begin Source File

SOURCE=.\StdAfx.h
# End Source File
# End Group
# Begin Group "Resource Files"

# PROP Default_Filter "ico;cur;bmp;dlg;rc2;rct;bin;rgs;gif;jpg;jpeg;jpe"
# Begin Source File

SOURCE=.\CallBackReply.rgs
# End Source File
# Begin Source File

SOURCE=.\Fun.rgs
# End Source File
# Begin Source File

SOURCE=".\Sample Server.rgs"
# End Source File
# End Group
# End Target
# End Project

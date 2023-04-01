; CLW file contains information for the MFC ClassWizard

[General Info]
Version=1
LastClass=CThreadPoolManagerDlg
LastTemplate=CDialog
NewFileInclude1=#include "stdafx.h"
NewFileInclude2=#include "threadpoolmanager.h"
LastPage=0

ClassCount=3
Class1=CThreadPoolManagerApp
Class2=CAboutDlg
Class3=CThreadPoolManagerDlg

ResourceCount=2
Resource1=IDD_ABOUTBOX (English (U.S.))
Resource2=IDD_THREADPOOLMANAGER_DIALOG (English (U.S.))

[CLS:CThreadPoolManagerApp]
Type=0
BaseClass=CWinApp
HeaderFile=ThreadPoolManager.h
ImplementationFile=ThreadPoolManager.cpp

[CLS:CAboutDlg]
Type=0
BaseClass=CDialog
HeaderFile=ThreadPoolManagerDlg.cpp
ImplementationFile=ThreadPoolManagerDlg.cpp

[CLS:CThreadPoolManagerDlg]
Type=0
BaseClass=CDialog
HeaderFile=ThreadPoolManagerDlg.h
ImplementationFile=ThreadPoolManagerDlg.cpp
Filter=D
VirtualFilter=dWC

[DLG:IDD_ABOUTBOX]
Type=1
Class=CAboutDlg

[DLG:IDD_THREADPOOLMANAGER_DIALOG]
Type=1
Class=CThreadPoolManagerDlg

[DLG:IDD_THREADPOOLMANAGER_DIALOG (English (U.S.))]
Type=1
Class=?
ControlCount=9
Control1=IDC_STATIC_WORKERS,static,1342308352
Control2=IDC_EDIT_WORKERS,edit,1350631552
Control3=IDC_BUTTON_START_POOL_MGR,button,1342242816
Control4=IDC_STATIC_JOBS,static,1342308352
Control5=IDC_EDIT_JOBCOUNT,edit,1350631552
Control6=IDC_BUTTON_START_JOBS,button,1342242816
Control7=IDC_BUTTON_STOP_JOB_MGR,button,1342242816
Control8=IDC_STATIC_JOBS_TO_PUSH,static,1342308352
Control9=IDC_EDIT_JOBS_TO_PUSH,edit,1350631552

[DLG:IDD_ABOUTBOX (English (U.S.))]
Type=1
Class=?
ControlCount=4
Control1=IDC_STATIC,static,1342177283
Control2=IDC_STATIC,static,1342308480
Control3=IDC_STATIC,static,1342308352
Control4=IDOK,button,1342373889


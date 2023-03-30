
#pragma once

#define SERVICE_NAME  "Xecutor"
#define CONFIG_FILE   "Xecutor.Config.xml"

#define EMPTY_STRING  ""
#define SLEEP_TIME    8000
#define LOGFILE       ""
#define MAX_LOADSTRING 100

#define TIMER_NAME "SERVICE_TIMER"

enum EServiceCalledFor
{
	InstallingTheService = 0,
	UnInstallingTheService = 1,
	StartingTheService = 2,
	StoppingTheService = 3,
	ByOSForRunAsService = 4,
	ByServiceForRunAsProcess =5,
	UnKnown = 6
};

static EServiceCalledFor eCalledFor;

SERVICE_STATUS ServiceStatus;
SERVICE_STATUS_HANDLE hStatus;

HINSTANCE hInst;								
TCHAR szTitle[MAX_LOADSTRING];					
TCHAR szWindowClass[MAX_LOADSTRING];			

HWND hMainWnd = 0;


int result; 


//----------------------//

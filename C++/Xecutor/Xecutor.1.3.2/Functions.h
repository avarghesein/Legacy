
#pragma once

static HMODULE hModKernel32 = LoadLibrary("Kernel32.dll");

BOOL (_stdcall *CancelWaitableTimer(void))(HANDLE)
{
	return (BOOL(_stdcall *)(HANDLE))GetProcAddress(hModKernel32,"CancelWaitableTimer"); 
}

typedef void (APIENTRY *PTIMERAPCROUTINE)(LPVOID,DWORD,DWORD);

BOOL (_stdcall *SetWaitableTimer(void))(HANDLE,const LARGE_INTEGER *,LONG,PTIMERAPCROUTINE,LPVOID,BOOL)
{
	return (BOOL(_stdcall *)(HANDLE,const LARGE_INTEGER *,LONG,PTIMERAPCROUTINE,LPVOID,BOOL))GetProcAddress(hModKernel32,"SetWaitableTimer"); 
}

HANDLE (_stdcall *CreateWaitableTimer(void))(LPSECURITY_ATTRIBUTES,BOOL,LPCTSTR)
{
	return (HANDLE(_stdcall *)(LPSECURITY_ATTRIBUTES,BOOL,LPCTSTR))GetProcAddress(hModKernel32,"CreateWaitableTimerA"); 
}

inline int MainReturn(int iReturn)
{
	return iReturn ? 0 : -1;
}

EServiceCalledFor ParseCommandLine(CTString tsCmdLine)
{
	try
	{
		if(tsCmdLine.IsEmpty()) return ByOSForRunAsService; 
		tsCmdLine = tsCmdLine.ToUpper();  
		
		if(tsCmdLine == "-I") return InstallingTheService; 
		if(tsCmdLine == "-U") return UnInstallingTheService; 
		if(tsCmdLine == "-R") return ByServiceForRunAsProcess; 
		if(tsCmdLine == "-S") return StartingTheService;
		if(tsCmdLine == "-P") return StoppingTheService;
	}
	catch(...) {}

	return UnKnown; 
}

int WriteToLog(CTString str,CTString sFileName)
{
	FILE* log;

	if (log = _tfopen((TCHAR*)sFileName, "a+"), !log) return 0;	

	_ftprintf(log, "%s", (TCHAR*)str);

	long lSize = 0;
	try { if(log) lSize = ftell(log),fclose(log); } catch(...) {}
	if(lSize >= 5 * 1024 *1024) DeleteFile((TCHAR*)sFileName); 
	return 1;
}

int GetLogFile(CTString&);

int EventLogger(CTString tsErrorString,int iIsError)
{
	static CTString sFile;
	char sBuff[250];
	CTString tsText;

	try
	{
		if(sFile.IsEmpty()) GetLogFile(sFile);
		if(sFile.IsEmpty()) return 0;
		tsText += "\n[PID:" + CTString((ULONG)GetCurrentProcessId(),0) + "] ";				
		GetDateFormat(LOCALE_SYSTEM_DEFAULT, DATE_SHORTDATE, NULL, NULL, sBuff,250);
		tsText += (CTString)sBuff + " ";
		GetTimeFormat(LOCALE_SYSTEM_DEFAULT,/*TIME_FORCE24HOURFORMAT*/LOCALE_USE_CP_ACP, NULL, "hh':'mm':'ss tt",sBuff,250);
		tsText += (CTString)sBuff + " >" + tsErrorString;
		tsText += iIsError ? "  Error:" + CTString::GetLastErrorString() : EMPTY_STRING; 
		WriteToLog(tsText,sFile);
		return 1;
	}
	catch(...) { return 0; }
}

int LogEvent(CTString tsLogString)
{
	return EventLogger(tsLogString,0); 
}

int LogError(CTString tsErrorString)
{
	return EventLogger(tsErrorString,1); 
}


int UnKnownCall(void)
{
	LogError("Service is called for an unknown purpose!");
	return 0;
}

int GetNonServiceProcessID()
{
	HANDLE hProcessSnap = NULL; 
	PROCESSENTRY32 pe32 = {0},pe32Current = {0};
	int iFound = 0;

	pe32Current.dwSize = pe32.dwSize = sizeof(PROCESSENTRY32);

	hProcessSnap = CreateToolhelp32Snapshot(TH32CS_SNAPPROCESS, 0); 
    if (hProcessSnap == INVALID_HANDLE_VALUE) return 0;

	if (Process32First(hProcessSnap, &pe32Current)) 
    { 
		do
		{
			if(GetCurrentProcessId() == pe32Current.th32ProcessID) 
			{
				iFound = 1;
				break;
			}
		}
		while(Process32Next(hProcessSnap, &pe32Current));
		CloseHandle (hProcessSnap); 
	}
	if(!iFound) return 0;

	hProcessSnap = CreateToolhelp32Snapshot(TH32CS_SNAPPROCESS, 0); 
    if (hProcessSnap == INVALID_HANDLE_VALUE) return 0;

	iFound = 1;
	if (Process32First(hProcessSnap, &pe32)) 
    { 
		do
		{
			if(pe32Current.th32ProcessID != pe32.th32ProcessID) 
				if(!_tcscmp(pe32.szExeFile,pe32Current.szExeFile))
				{
					iFound = 1;
					break;
				}				
		}
		while(Process32Next(hProcessSnap, &pe32));
		CloseHandle (hProcessSnap); 
	}

	return iFound ? pe32.th32ProcessID : 0;  

}

int GetLogFile(CTString &tsLogFile)
{
	if(!CWindowUtility::GetExecutablePath(tsLogFile)) return 0;  
	tsLogFile += "\\";
	switch(eCalledFor)
	{
		case InstallingTheService : 
		case StartingTheService : 
		case StoppingTheService : 
		case UnInstallingTheService : 
			{
				tsLogFile += "Xecutor.Command.log";
			}
			return 1;
		case ByOSForRunAsService  : 
			{
				tsLogFile += "Xecutor.Service.log";
			}
			return 1;
		case ByServiceForRunAsProcess : 
		case UnKnown : 
		default: 
			{
				tsLogFile += "Xecutor.WindowProcess.log";
			}
			return 1;
	}
}

int StartService(void)
{
	return CNTService::Start();  
}

int StopService(void)
{
	return CNTService::Stop(); 
}

int InstallService(void)
{
	CTString tsExeFileName;

	if(!CWindowUtility::GetExeName(tsExeFileName,0)) return 0;

	int iRet = CNTService::Install(tsExeFileName);  

	return iRet;  
}

int UnInstallService(void)
{
	return CNTService::UnInstall(); 
}

int CreateProcess(PROCESS_INFORMATION **ptrToProcessInfo,STARTUPINFO **ptrToStartupInfo)
{
	CTString tsExeName;
	STARTUPINFO si;
    PROCESS_INFORMATION pi; 

	if(*ptrToProcessInfo) delete *ptrToProcessInfo;
	if(*ptrToStartupInfo) delete *ptrToStartupInfo;

    ZeroMemory(&si,sizeof(si)); si.cb = sizeof(si);
    ZeroMemory(&pi,sizeof(pi));
	if(!CWindowUtility::AcquireDeskTop(DEFAULT_WINDOW_STATION,DEFAULT_DESKTOP))
	{
		LogError("Acquiring Desktop Failed!");
		return 0;
	}
	LogEvent("Desktop Acquired");
	si.cb = sizeof(STARTUPINFO);
	si.lpDesktop = PROCESS_DESKTOP;

	LogEvent("Creating Process: Getting EXE name!"); 
	if(!CWindowUtility::GetExeName(tsExeName,0)) return 0;
	LogEvent(tsExeName);

	CTString tsCmdLine("\"" + tsExeName + " -R\"");
	LogEvent("Command Line!" + tsCmdLine);

	if((int)ShellExecute(0,"OPEN",tsExeName,"-R",0,SW_SHOWNORMAL) <= 32) 
    { 
        LogError("Creating Process Failed!");
		return 0;
    }
	pi.dwProcessId = GetNonServiceProcessID();
	LogEvent("Process Created With ID : " + CTString(pi.dwProcessId,0));
	*(*ptrToProcessInfo = new PROCESS_INFORMATION) = pi;
	*(*ptrToStartupInfo = new STARTUPINFO) = si;
	return 1; 
}

int StartProcess(int iIsStart)
{
	static PROCESS_INFORMATION *roProcess = 0;
	static STARTUPINFO *roStartupInfo = 0;

	if(iIsStart)
	{
		if(roProcess) return 1;
		if(CreateProcess(&roProcess,&roStartupInfo)) return 1;
		return 0;
	}
	else
	{  
		if(!roProcess) return 1;
		LogEvent("Posting Quit Message...!");
		PostAppMessage(roProcess->dwThreadId,CMainWindow::mQuitMessage,0,0); 
		Sleep(700);  
		HANDLE HProcess=OpenProcess(PROCESS_ALL_ACCESS,1,roProcess->dwProcessId);
		if(HProcess)
		{
			if(!TerminateProcess(HProcess,0))
			{
				LogError((CTString)"Killing Process Failed [ID - " + CTString(roProcess->dwProcessId,0) + "]");
				return 0;
			}
		}
		else LogEvent("Posting Quit Message Processed!");
		LogEvent("Process Exited [ID - " + CTString(roProcess->dwProcessId,0) + "]");
		CWindowUtility::ReleaseDeskTop(); 
		roProcess = 0,roStartupInfo = 0;
		return 1; 
	}
}

void CALLBACK TimerAPCProc(LPVOID lpArg,DWORD dwTimerLowValue,DWORD dwTimerHighValue)
{
	//LogEvent("Time(High=" + CTString(dwTimerHighValue,0) + ",Low=" + CTString(dwTimerLowValue,0) + ")");
	StartProcess(1); 
}

int StartWaitableTimer(int iIsStart)
{
	 static HANDLE hTimer = NULL;
	
	 if(iIsStart)
	 {
		if(hTimer) return 1;
		LogEvent("Creating Timer...!");

		HANDLE thTimer = 0;
		LARGE_INTEGER liDueTime;
		if(!(thTimer  = CreateWaitableTimer()(0,0,TIMER_NAME)))
		{
			LogError("Creating Timer Failed!");
			return 0;
		}
		LogEvent("Timer Created!");
		liDueTime.QuadPart = -10000000; 
		// Signal After 1 Sec: 1 sec -> 1000 milli sec; 1 milli sec -> 1000000 nano sec  
		// fun uses interval of 100 nano secs
		if(!SetWaitableTimer()(thTimer,&liDueTime,10000,TimerAPCProc,0,0))
		{ 
			LogError("Setting Timer Failed!");
			return 0;
		}
		LogEvent("Timer Set!");
		hTimer = thTimer;
		return 1;
	 }
	 else
	 {
		 if(!hTimer) return 1;
		 LogEvent("Cancelling Timer!");
		 if(!CancelWaitableTimer()(hTimer))
		 {
			LogError("Cancelling Timer Failed!");
			return 0;
		 }
		 LogEvent("Timer Cancelled!");
		 hTimer = 0;
		 StartProcess(0);
		 return 1;
	 }
}

int RunService(void)
{
	return CNTService::Run(SLEEP_TIME);     
}

//---------------

CMailServer moServer;

int LoadXml(CXmlUtility &oXmlUtil)
{
	CTString tsXmlFile;
	if(!CWindowUtility::GetExeName(tsXmlFile,1)) return 0;
	tsXmlFile += "\\" + CTString(CONFIG_FILE);
	if(!oXmlUtil.OpenXmlDocument((TCHAR*)tsXmlFile)) return 0;
	return oXmlUtil.ResetSearchPointerToRoot();
}

bool mbThreadExit;

DWORD LaunchApplications(PVOID ptrObj)
{
	CTString sExePath;
	CWindowUtility::GetExecutablePath(sExePath);
	LogEvent("Loading xml...");
	CXmlUtility oXml;
	if(!LoadXml(oXml) || !oXml.MoveToChild("PROFILES")) return -1;

	int iLevelCnt,iIndx;
	CExtendedLinkedList<CTString> oStdInArgs; 
	CTString sProf,sCurProfile,sHrs,sMins;
	LogEvent("Xml loaded, started launching applications...");
	for(iLevelCnt = oXml.LevelCount(), iIndx = 0; iIndx < iLevelCnt; ++iIndx) 
	{ 
		CConsoleProcessScheduler *oSched;
		CCommandLineProvider *oCmdLineProvider;
		IDynamicCommandLineProvider *CmdLineProvider;
		
		CmdLineProvider = (IDynamicCommandLineProvider*)(oCmdLineProvider = new CCommandLineProvider());

		sCurProfile = "PROFILES/";
		sCurProfile += (sProf = oXml[iIndx]);

		oXml.GetNodeTextFromHeirarchy(sCurProfile + "/SCRIPT",oCmdLineProvider->Script,true);
		oXml.GetNodeTextFromHeirarchy(sCurProfile + "/DUMP-FOLDER",oCmdLineProvider->DumpFolder,true);  
		oXml.GetNodeTextFromHeirarchy(sCurProfile + "/TEMPLATE-FILE",oCmdLineProvider->DumTemplateFile,true); 
		oXml.GetNodeTextFromHeirarchy(sCurProfile + "/USER-NAME",oCmdLineProvider->User,true); 
		oXml.GetNodeTextFromHeirarchy(sCurProfile + "/PASSWORD",oCmdLineProvider->Pass,true); 	
		oXml.GetNodeTextFromHeirarchy(sCurProfile + "/DATABASE",oCmdLineProvider->DataBase,true); 
		oXml.GetNodeTextFromHeirarchy(sCurProfile + "/EXTRA-OPTIONS",oCmdLineProvider->Exta,true); 
		oXml.GetNodeTextFromHeirarchy(sCurProfile + "/SCHEDULE-HOUR",sHrs,true); 
		oXml.GetNodeTextFromHeirarchy(sCurProfile + "/SCHEDULE-MIN",sMins,true); 
		oXml.GetNodeTextFromHeirarchy(sCurProfile + "/USE-EXTRA-OPTIONS-ONLY",oCmdLineProvider->UseExtaOnly,true); 

		oStdInArgs.InsertAtBack(new CTString(oCmdLineProvider->Pass)); 
		if(sHrs.Trim()  == "") sHrs = "*"; if(sMins.Trim()  == "") sMins = "*";
		oSched = new CConsoleProcessScheduler(oCmdLineProvider->Script,EMPTY_TSTRING,sHrs,sMins,oStdInArgs);   
		oSched->SetName(sProf); 
		oSched->SetDynamicCommandLineProvider(CmdLineProvider);

		CStdOutToFile *oStdOutToFile;
		IRedirectedOutput *StdOutToFile;

		StdOutToFile = (IRedirectedOutput*)(oStdOutToFile = new CStdOutToFile(sExePath,sProf,EMPTY_TSTRING)); 
		oSched->SetOutStream(StdOutToFile);
		
		moProcessList.InsertAtBack(oSched);
		LogEvent("Launching '" + sProf + "<" + oCmdLineProvider->Script + ">' = " + (oSched->Start() ? "SUCCESS!" : "FAILURE!"));
	}
	while(!mbThreadExit) SleepEx(1000,1);
	return 0;

}

DWORD EndApplications(PVOID ptrObj)
{
	bool b = moProcessList.ClearList(); 
	b &= (_fcloseall() != EOF);
	return !b;
}

//-----------

HANDLE mhThread;

int RunProcess(HINSTANCE hInstance,HINSTANCE hPrevInstance,int nCmdShow)
{
	MSG msg;
	HACCEL hAccelTable;

	hInst = hInstance;
	LoadString(hInst, IDS_APP_TITLE, szTitle, MAX_LOADSTRING);
	LoadString(hInst, IDC_XECUTOR, szWindowClass, MAX_LOADSTRING);

	hAccelTable = LoadAccelerators(hInst, (LPCTSTR)IDC_XECUTOR);

	LogEvent("Creating Window and Adding Tray Icon!"); 
	if(!CMainWindow::Create(hInst)) return -1;  
	LogEvent("Starting Message Loop");
	while (GetMessage(&msg, NULL, 0, 0)) 
	{
		if(msg.message == CMainWindow::mQuitMessage) CMainWindow::Destroy();
		else if(!CMainWindow::GetHandle() || !IsDialogMessage(CMainWindow::GetHandle(),&msg))
		{
			if (!TranslateAccelerator(msg.hwnd, hAccelTable, &msg)) 
			{
				TranslateMessage(&msg);
				DispatchMessage(&msg);
			} 
		}
	}
	LogEvent("Exiting Process!");
	return (int) msg.wParam;
}

//------------
int PostRun(ENTServiceStatus eStat)
{
	StartWaitableTimer(0);
	return 1;
}

int PreRun(ENTServiceStatus eStat)
{
	if(eStat != StartPending) 
	{
		StartWaitableTimer(1);
		DWORD dwId = 0;
		LogEvent("Starting Applications...");
		mbThreadExit = false;
		mhThread = CreateThread(0,0,&LaunchApplications,0,0,&dwId); 
		LogEvent("Starting Applications Completed");
		moServer.Start(); 
	}
	return 1;
}

int Run(ENTServiceStatus eStat)
{
	return 1;
}

int ContinueService(ENTServiceStatus eStat)
{
	 StartWaitableTimer(1);
	 return 1;
}

int PauseService(ENTServiceStatus eStat)
{
	return 1;
}

int ShutDownService(ENTServiceStatus eStat)
{
	StartWaitableTimer(0); 
	if(mhThread)
	{
		mbThreadExit = true;
		WaitForSingleObject(mhThread,INFINITE); 
		CloseHandle(mhThread);
		mhThread = 0;
	}
	DWORD dwId = 0;
	HANDLE hThread;
	LogEvent("Ending Applications...");
	WaitForSingleObject(hThread = CreateThread(0,0,&EndApplications,0,0,&dwId),INFINITE); 
	LogEvent("Ending Applications Completed");
	CloseHandle(hThread);
	moServer.Stop(); 
	return 1;
}

int StopService(ENTServiceStatus eStat)
{
	StartWaitableTimer(0); 
	if(mhThread)
	{
		mbThreadExit = true;
		WaitForSingleObject(mhThread,INFINITE); 
		CloseHandle(mhThread);
		mhThread = 0;
	}
	DWORD dwId = 0;
	HANDLE hThread;
	LogEvent("Ending Applications...");
	WaitForSingleObject(hThread = CreateThread(0,0,&EndApplications,0,0,&dwId),INFINITE); 
	CloseHandle(hThread); 
	LogEvent("Ending Applications Completed");
	moServer.Stop();
	return 1;
}



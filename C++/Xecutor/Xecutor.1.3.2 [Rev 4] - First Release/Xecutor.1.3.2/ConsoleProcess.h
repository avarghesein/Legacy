
#pragma once

class CConsoleProcess;

typedef void (*ConsoleProcessCompleted)(CConsoleProcess *ConsoleProcess,bool bGraceFullCompletion);
typedef void (*ConsoleOutputAvailable) (CConsoleProcess *ConsoleProcess,CTString tsOutData);
typedef FAR void*(*GetEnvironment)(void);

class CConsoleProcess
{
private:
	CTString mDesignation;

	STARTUPINFO msi;
    PROCESS_INFORMATION mpi;

	CTString mtsExePath,mtsCmdLine;
	CPipe mConsolePipe;
	bool mbIsRedirect;

	ConsoleProcessCompleted mcallbackProcessCompletion;
	ConsoleOutputAvailable mcallbackOutPutDataAvialble;
	
	HANDLE mThread;

	void* mpCustomObject;

	bool mbUseAsciiCodePage,mbReuseDosShell;
	static bool mbForcedConsole;

private:
	void Clear(void);
	void ClearStructure(void);
	bool SendCtrlBreak(void);
	bool ValidStdOutPipe(bool &DataAvailable);

	static DWORD ProcessMonitor(LPVOID ptrObj);
	static bool IsNTplatform(void);

	static bool IsConsoleAttached(void);
	static CTString UniqueGUID(void);
	
public:
	CConsoleProcess(void);
	CConsoleProcess(CTString Designation,ConsoleOutputAvailable CallbackOutPutDataAvialble = 0,ConsoleProcessCompleted CallbackForProcessCompletion = 0,void* CustomObject=0,bool bUseAsciiCodePage = true,bool ReuseDosShell=false);
   ~CConsoleProcess(void);
    bool Initialize(CTString Designation,ConsoleOutputAvailable CallbackOutPutDataAvialble = 0,ConsoleProcessCompleted CallbackForProcessCompletion = 0,void* CustomObject=0,bool bUseAsciiCodePage = true,bool ReuseDosShell = false);
	bool Start(CTString tsExePath,CTString tsCmdLineArgs = CTString::NullString(),bool IsRedirect = true,GetEnvironment Environment = 0);
	bool Kill(void);
	bool WaitForExit(void);
	bool WriteToConsole(CTString tsInput);
	bool ReadFromConsole(CTString &tsOutPut);
	bool IsAlive(void);
	CTString GetDesignation(void) { return mDesignation; }
	friend CConsoleProcess& operator<<(CConsoleProcess &oProcess,CTString tsString);
	friend CConsoleProcess& operator>>(CConsoleProcess &oProcess,CTString& tsString);
	void* CustomObject(void);

	static bool CreateConsole(void);
	static bool DestroyConsole(void);

	bool QuitDosShell(void);
	bool BrockenPipe(void) { if(mbIsRedirect) return mConsolePipe.IsBrocken(); else return true; }  
};

bool CConsoleProcess::mbForcedConsole = false;

CTString CConsoleProcess::UniqueGUID(void)
{
	GUID guid;
	HRESULT hr = CoCreateGuid(&guid); 
	CTString tsGuid;
	tsGuid.AppendFormat("{%.2X-%.2X-%.2X-%.2X%.2X-%.2X%.2X%.2X%.2X%.2X%.2X}", guid.Data1, guid.Data2, guid.Data3, guid.Data4[0], guid.Data4[1],guid.Data4[2], guid.Data4[3], guid.Data4[4], guid.Data4[5], guid.Data4[6], guid.Data4[7]);
	return tsGuid;
}

bool CConsoleProcess::IsConsoleAttached(void)
{
	// for NT, invalid handles are indicated by a NULL return
	// for 9x on the other hand we get INVALID_HANDLE_VALUE
	return 
		((int)GetStdHandle(STD_ERROR_HANDLE)  > 0)  ||
		((int)GetStdHandle(STD_OUTPUT_HANDLE) > 0)  ||
		((int)GetStdHandle(STD_INPUT_HANDLE)  > 0);	
}

bool CConsoleProcess::CreateConsole(void)
{
	if(IsNTplatform()) return true; 
	if(IsConsoleAttached()) return true;
	HWND (_stdcall *GetConsoleWindow)() = (HWND (_stdcall*)())GetProcAddress(GetModuleHandle(_T("kernel32.dll")), "GetConsoleWindow");
	LockWindowUpdate(GetDesktopWindow());
	if(AllocConsole())
	{
		mbForcedConsole = true;
		HWND whCon;
		if(GetConsoleWindow()) whCon = GetConsoleWindow(); else
		{
			CTString tsConsoleTitle = UniqueGUID();
			SetConsoleTitle((TCHAR*)tsConsoleTitle);
			Sleep(50);
			whCon = FindWindow(NULL,(TCHAR*)tsConsoleTitle);
		}
		if (whCon) ShowWindow(whCon, SW_HIDE);
	}
	LockWindowUpdate(0); 
	return mbForcedConsole;
}

bool CConsoleProcess::DestroyConsole(void)
{
	if(IsNTplatform()) return true; 
	if(mbForcedConsole)
	{
		FreeConsole(),mbForcedConsole = false; 
	}
	return true;
}

bool CConsoleProcess::IsNTplatform(void)
{
	OSVERSIONINFO osInfo;
	osInfo.dwOSVersionInfoSize = sizeof(OSVERSIONINFO);
	GetVersionEx(&osInfo);
	return osInfo.dwPlatformId == VER_PLATFORM_WIN32_NT;
}

CConsoleProcess& operator<<(CConsoleProcess &oProcess,CTString tsString)
{
	oProcess.WriteToConsole(tsString);  
	return oProcess;
}

CConsoleProcess& operator>>(CConsoleProcess &oProcess,CTString& tsString)
{
	oProcess.ReadFromConsole(tsString);
	return oProcess;
}

DWORD CConsoleProcess::ProcessMonitor(LPVOID ptrObj)
{
	bool bGoodExit = true,bDataAvailable = false;
	CConsoleProcess *oProcess = (CConsoleProcess*)ptrObj;
	CTString tsOutPut;

    while(oProcess->IsAlive() || (oProcess->ValidStdOutPipe(bDataAvailable) && bDataAvailable)) 
	{
		if(oProcess->mbIsRedirect)
		{
			if(oProcess->ReadFromConsole(tsOutPut))
			{
				if(oProcess->mcallbackOutPutDataAvialble) oProcess->mcallbackOutPutDataAvialble(oProcess,tsOutPut);
			}
			else
			{
				if(oProcess->BrockenPipe()) 
				{
					bGoodExit = false;
					break;
				}
			}
		}
		SleepEx(100,true); 
	}
	if(oProcess->mcallbackProcessCompletion) oProcess->mcallbackProcessCompletion(oProcess,bGoodExit);
	CloseHandle(oProcess->mThread); 
	oProcess->mThread =0,oProcess->Clear(); 
	return 0;
}

void CConsoleProcess::ClearStructure(void)
{
	ZeroMemory(&msi,sizeof(msi));
    msi.cb = sizeof(msi);
    ZeroMemory(&mpi, sizeof(mpi));
}

CConsoleProcess::CConsoleProcess(void): 
mThread(0),mtsExePath(CTString::NullString()),mtsCmdLine(CTString::NullString()),mbIsRedirect(false),
mDesignation(CTString::NullString()),mcallbackProcessCompletion(0),
mcallbackOutPutDataAvialble(0),	mpCustomObject(0),mbUseAsciiCodePage(false),mbReuseDosShell(false)
{ 
	ClearStructure();
}

CConsoleProcess::CConsoleProcess(CTString Designation,ConsoleOutputAvailable CallbackOutPutDataAvialble,ConsoleProcessCompleted CallbackForProcessCompletion,void* CustomObject,bool bUseAsciiCodePage,bool ReuseDosShell): 
mThread(0),mtsExePath(CTString::NullString()),mtsCmdLine(CTString::NullString()),mbIsRedirect(false),	mpCustomObject(0),mbUseAsciiCodePage(false),mbReuseDosShell(false)
{
	ClearStructure();
	Initialize(Designation,CallbackOutPutDataAvialble,CallbackForProcessCompletion,CustomObject,bUseAsciiCodePage,ReuseDosShell);
}

bool CConsoleProcess::Initialize(CTString Designation,ConsoleOutputAvailable CallbackOutPutDataAvialble,ConsoleProcessCompleted CallbackForProcessCompletion,void* CustomObject,bool bUseAsciiCodePage,bool ReuseDosShell)
{
	if(IsAlive()) return false; 
	mDesignation = Designation;
	mcallbackProcessCompletion = CallbackForProcessCompletion;
	mcallbackOutPutDataAvialble = CallbackOutPutDataAvialble;
	mpCustomObject = CustomObject;
	mbUseAsciiCodePage = bUseAsciiCodePage;
	mbReuseDosShell = ReuseDosShell;
	ClearStructure();
	return true;
}

CConsoleProcess::~CConsoleProcess(void)
{
	//Clear();
}

bool CConsoleProcess::IsAlive(void)
{
	if(!mpi.hProcess) return false;

	bool bActive = true;
	if(IsNTplatform())
	{
		DWORD dwExitCode = 0;
		GetExitCodeProcess(mpi.hProcess,&dwExitCode);  
		bActive = STILL_ACTIVE == dwExitCode;
	}
	if(!bActive) 
	{
		CloseHandle(mpi.hProcess); 
		mpi.hProcess = 0;
	}
	return bActive;
}

void CConsoleProcess::Clear(void)
{
	if(mbIsRedirect)
		mConsolePipe.Destroy(),mbIsRedirect = false; 
	if(mThread) 
	{
		DWORD dwExitCode;
		GetExitCodeThread(mThread,&dwExitCode); 
		STILL_ACTIVE == dwExitCode ? TerminateThread(mThread,0) : CloseHandle(mThread);
		mThread=0; 
	}	
	ClearStructure();
}

bool CConsoleProcess::Start(CTString tsExePath,CTString tsCmdLineArgs,bool IsRedirect,GetEnvironment Environment)
{  
	if(mbReuseDosShell && !IsNTplatform() && !IsRedirect) return false;

	mtsExePath = tsExePath,mtsCmdLine = tsCmdLineArgs;

	CTString tsDosShell,tsCmdLine = mtsExePath + " " + mtsCmdLine;

	if(IsAlive())
		if(mbReuseDosShell) return WriteToConsole(tsCmdLine + "\r\n"); else return false; 
			
	mbIsRedirect = IsRedirect;

	tsDosShell = IsNTplatform() ? "cmd.exe /A" : "command.com"; 
	
	tsDosShell += mbReuseDosShell ? IsNTplatform() ? 
				  " /K @echo off & prompt $S$H & " + tsCmdLine :
				  " /K echo off" : " /C " + tsCmdLine;


	CPipe oStdIn,oStdOut,oStdErr;

	if(CreateConsole(),ClearStructure(),mbIsRedirect)
	{
		bool bSuccess;

		bSuccess = oStdOut.Create();
		bSuccess = oStdOut.DuplicateWriteEnd(oStdErr);
		bSuccess = oStdIn.Create();
		bSuccess = oStdOut.DuplicateReadEnd(mConsolePipe,false);
		bSuccess = oStdIn.DuplicateWriteEnd(mConsolePipe,false);
		bSuccess = oStdOut.DestroyReadEnd(); 
		bSuccess = oStdIn.DestroyWriteEnd(); 
			
		msi.dwFlags =  STARTF_USESTDHANDLES | STARTF_USESHOWWINDOW;
		msi.hStdInput = -oStdIn;  
		msi.hStdOutput =  +oStdOut;  
		msi.hStdError = +oStdErr;  
		msi.wShowWindow = SW_HIDE;
	}

	CTString CurDir,OrgDir = CTString::GetDirectory((GetFixedDirectory)&GetCurrentDirectory);

	try
	{
		CurDir = mtsExePath.GetDirectoryPart(); 
		if(CurDir.IsEmpty() || CurDir.Trim().IsEmpty()) throw 0;
		CurDir = CurDir.Trim();
		CurDir = CurDir.Replace("\"",""); 
		SetCurrentDirectory((TCHAR*)CurDir); 
	}
	catch(...)
	{
		CurDir.Clear(); 
	}

	void *envt = 0;

	if(Environment) envt = Environment();

	bool bRet =  CreateProcess(0,TEXT((TCHAR*)tsDosShell),0,0,true,(IsNTplatform() ? CREATE_NEW_CONSOLE : 0 ) | CREATE_NEW_PROCESS_GROUP,envt,TEXT((TCHAR*)CurDir),&msi,&mpi) != 0;
	CTString kkk = CTString::GetLastErrorString(); 
	SetCurrentDirectory((TCHAR*)OrgDir); 
	if(mbIsRedirect) 
	{
		oStdOut.DestroyWriteEnd(); 
		oStdErr.DestroyWriteEnd(); 
		oStdIn.DestroyReadEnd(); 
	}
	if(bRet) 
	{
		if(mbReuseDosShell && !IsNTplatform()) WriteToConsole(tsCmdLine + "\r\n");   
		DWORD dwThreadId; 
		mThread = CreateThread(0,0,(LPTHREAD_START_ROUTINE)&ProcessMonitor,this,0,&dwThreadId); 
	}
	return bRet;
}

bool CConsoleProcess::Kill(void)
{
	if(!IsAlive()) return false; 
	bool bRet;
	if(mbReuseDosShell)
	{
		bRet = SendCtrlBreak(); 
	}
	else
	{
		bRet = TerminateProcess(mpi.hProcess,-1) != 0;  
		Clear();
	}
	if(mcallbackProcessCompletion) mcallbackProcessCompletion(this,false);
	return bRet;
}

bool CConsoleProcess::WaitForExit(void)
{
	bool bRet = WAIT_OBJECT_0 == WaitForSingleObject(mpi.hProcess,INFINITE);   
	Clear();
	if(mcallbackProcessCompletion) mcallbackProcessCompletion(this,bRet);
	return bRet;
}

bool CConsoleProcess::WriteToConsole(CTString tsInput)
{
	if(!mbIsRedirect) return false;
	return mConsolePipe.WriteToPipe(tsInput); 
}

bool CConsoleProcess::ValidStdOutPipe(bool &DataAvailable)
{
	if(DataAvailable = false,!mbIsRedirect) return false;
	return mConsolePipe.ValidReadEnd(DataAvailable); 
}

bool CConsoleProcess::ReadFromConsole(CTString &tsOutPut)
{
	if(!mbIsRedirect) return false;
	return mConsolePipe.ReadFromPipe(tsOutPut);  
}

void* CConsoleProcess::CustomObject(void)
{
	return mpCustomObject;
}

bool CConsoleProcess::SendCtrlBreak(void)
{
	if(IsAlive())
		if(GenerateConsoleCtrlEvent(CTRL_BREAK_EVENT,mpi.dwProcessId))
		{
			if(mcallbackOutPutDataAvialble) mcallbackOutPutDataAvialble(this,"<CtrlBreak>");
			return true;
		}
	return false;
}

bool CConsoleProcess::QuitDosShell(void)
{
	if(!mbReuseDosShell) return false;
	if(IsAlive())
	{
		SendCtrlBreak(),SleepEx(300,true);
		Start("exit"),SleepEx(300,true);
		if(IsAlive()) return Kill(); 
	}
	return true;
}
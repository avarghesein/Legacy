
#pragma once

//---Struct

class CWaitableTimer;
struct STimerEventArgs;

typedef void (_stdcall *TimerEventHandler)(STimerEventArgs);

struct STimerEventArgs
{
private:
	TimerEventHandler mpCallBack;
	void *mpObj;
	DWORD mdwLowTime,mdwHighTime;

public:
	STimerEventArgs(TimerEventHandler TimerCallBack,void* ObjectToReturn);
	DWORD LowTime(void);
	DWORD HighTime(void);
	void* Object(void); 

	friend class CWaitableTimer;
};

STimerEventArgs::STimerEventArgs(TimerEventHandler TimerCallBack,void* ObjectToReturn) : mpCallBack(TimerCallBack),mpObj(ObjectToReturn),mdwLowTime(0),mdwHighTime(0) {}

DWORD STimerEventArgs::LowTime(void) { return mdwLowTime; }

DWORD STimerEventArgs::HighTime(void) { return mdwHighTime; }	

void* STimerEventArgs::Object(void) { return mpObj; }

//---Class

typedef void (APIENTRY *PTIMERAPCROUTINE)(LPVOID,DWORD,DWORD);

class CWaitableTimer
{
private:

	static HMODULE hModKernel32;
	HANDLE mhTimer;
	STimerEventArgs *mpTimerEventArgs;

private:

	static HANDLE (_stdcall *CreateWaitableTimer(void)) (LPSECURITY_ATTRIBUTES,BOOL,LPCTSTR);
	static BOOL   (_stdcall *SetWaitableTimer(void))    (HANDLE,const LARGE_INTEGER *,LONG,PTIMERAPCROUTINE,LPVOID,BOOL);
	static BOOL   (_stdcall *CancelWaitableTimer(void)) (HANDLE);

	static void CALLBACK CWaitableTimer::InnerCallBack(LPVOID lpArg,DWORD dwTimerLowValue,DWORD dwTimerHighValue);

private:
	CTime mWakeTime,mTriggerPeriod;
	static CExtendedLinkedList<CWaitableTimer> gObjectsToSet;
	static HANDLE ghSetThread;
	static long glObjectCount;
	static bool gbThreadContinue;
	static DWORD TimerSettingThread(PVOID pObj);

public:
	static bool CreateTimerThread(bool Start);

	CWaitableTimer(void);
	~CWaitableTimer(void);
	bool Create(CTString tsName,STimerEventArgs* TimerEventArgs,bool bManualReset = false);
	bool Set(CTime tWakeTime,CTime tTriggerPeriodAfterWake = CTime());
	bool Cancel(void);
	bool Destroy(void);
	bool ValidTimer(void) { return mhTimer != 0; }
};

HMODULE CWaitableTimer::hModKernel32 = LoadLibrary("Kernel32.dll");

CExtendedLinkedList<CWaitableTimer> CWaitableTimer::gObjectsToSet;
HANDLE CWaitableTimer::ghSetThread = 0;
long CWaitableTimer::glObjectCount = 0;
bool CWaitableTimer::gbThreadContinue = false;

bool CWaitableTimer::CreateTimerThread(bool Start)
{
	if(Start)
	{
		if(ghSetThread) return true;
		gbThreadContinue = true;
		return (ghSetThread = CreateThread(0,0,&TimerSettingThread,0,0,0)) != 0;  
	}
	else
	{
		if(!ghSetThread) return false;
		gbThreadContinue = false;
		WaitForSingleObject(ghSetThread,INFINITE); 
		CloseHandle(ghSetThread);
		ghSetThread = 0;
	}
	return true;
}

DWORD CWaitableTimer::TimerSettingThread(PVOID pObj)
{
	LARGE_INTEGER liDueTime;
	CWaitableTimer *TimerObj = 0;

	while(gbThreadContinue)
	{
		if(gObjectsToSet.DeleteFromFront(&TimerObj))
		{
			try
			{
				liDueTime.QuadPart = -TimerObj->mWakeTime.GetTimeInMultipleOfNanoSeconds(); 
				// 1 sec -> 1000 milli sec; 1 milli sec -> 1000000 nano sec  
				// fun uses interval of 100 nano secs
				SetWaitableTimer()(TimerObj->mhTimer,&liDueTime,(long)TimerObj->mTriggerPeriod.GetTimeInMilliSeconds(),CWaitableTimer::InnerCallBack,(void*)TimerObj,0);
			}
			catch(...) {}
		}
		SleepEx(1000,true);
	}
	return 0;
}

BOOL (_stdcall *CWaitableTimer::SetWaitableTimer(void))(HANDLE,const LARGE_INTEGER *,LONG,PTIMERAPCROUTINE,LPVOID,BOOL)
{
	return (BOOL(_stdcall *)(HANDLE,const LARGE_INTEGER *,LONG,PTIMERAPCROUTINE,LPVOID,BOOL))GetProcAddress(CWaitableTimer::hModKernel32,"SetWaitableTimer"); 
}

HANDLE (_stdcall *CWaitableTimer::CreateWaitableTimer(void))(LPSECURITY_ATTRIBUTES,BOOL,LPCTSTR)
{
	return (HANDLE(_stdcall *)(LPSECURITY_ATTRIBUTES,BOOL,LPCTSTR))GetProcAddress(CWaitableTimer::hModKernel32,"CreateWaitableTimerA"); 
}

BOOL (_stdcall *CWaitableTimer::CancelWaitableTimer(void))(HANDLE)
{
	return (BOOL(_stdcall *)(HANDLE))GetProcAddress(CWaitableTimer::hModKernel32,"CancelWaitableTimer"); 
}

CWaitableTimer::CWaitableTimer(void) : mhTimer(0),mpTimerEventArgs(0) 
{ 
	++glObjectCount; 
	CreateTimerThread(true);
}

CWaitableTimer::~CWaitableTimer(void)
{
	--glObjectCount; 
	gObjectsToSet.DeleteAllItemByAddress((UINT64)this);
	if(!glObjectCount) CreateTimerThread(false);
}

bool CWaitableTimer::Create(CTString tsName,STimerEventArgs *TimerEventArgs,bool bManualReset)
{
	if(mhTimer) return true; 
	mpTimerEventArgs = TimerEventArgs;
	return (mhTimer  = CreateWaitableTimer()(0,bManualReset,tsName.IsEmpty() ? 0 : (TCHAR*)tsName)) != 0;
}

bool CWaitableTimer::Destroy(void)
{
	if(!mhTimer) return true;
	Cancel();
	bool bRet = CloseHandle(mhTimer) != 0; 
	if(bRet) 
	{
		mhTimer = 0; 
		try { if(mpTimerEventArgs) delete mpTimerEventArgs; } catch(...) {}
	}
	return bRet;
}

bool CWaitableTimer::Set(CTime tWakeTime,CTime tTriggerPeriodAfterWake)
{
	if(!mhTimer) return false;
	mWakeTime = tWakeTime;
	mTriggerPeriod = tTriggerPeriodAfterWake;
	return gObjectsToSet.InsertAtBack(this); 
}

bool CWaitableTimer::Cancel(void)
{
	if(!mhTimer) return false;
	return CancelWaitableTimer()(mhTimer) != 0;
}

void CALLBACK CWaitableTimer::InnerCallBack(LPVOID lpArg,DWORD dwTimerLowValue,DWORD dwTimerHighValue)
{
	CWaitableTimer *pObj = (CWaitableTimer*)lpArg;
	if(pObj && pObj->mpTimerEventArgs)
	{
		pObj->mpTimerEventArgs->mdwLowTime = dwTimerLowValue;   
		pObj->mpTimerEventArgs->mdwHighTime = dwTimerHighValue;   
		if(pObj->mpTimerEventArgs->mpCallBack) pObj->mpTimerEventArgs->mpCallBack(*(pObj->mpTimerEventArgs));	
	}
	return;
}
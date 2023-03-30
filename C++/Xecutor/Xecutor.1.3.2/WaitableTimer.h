
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

//---another struct
struct SSetThreadArgs
{
private:
	CWaitableTimer *mObject;
	CTime mWakeTime,mTriggerPeriodAfterWake;

	friend class CWaitableTimer;
};
//---Class

typedef void (APIENTRY *PTIMERAPCROUTINE)(LPVOID,DWORD,DWORD);

class CWaitableTimer
{
private:

	static HMODULE hModKernel32;
	HANDLE mhTimer;
	STimerEventArgs *mpTimerEventArgs;

private:

	static long ObjectCount;
	static CExtendedLinkedList<SSetThreadArgs> ObjectsToSet;
	static bool ProcessObjectCount(bool Increment);
	static DWORD SettingThread(LPVOID pObj);

private:

	HANDLE (_stdcall *CreateWaitableTimer(void)) (LPSECURITY_ATTRIBUTES,BOOL,LPCTSTR);
	BOOL   (_stdcall *SetWaitableTimer(void))    (HANDLE,const LARGE_INTEGER *,LONG,PTIMERAPCROUTINE,LPVOID,BOOL);
	BOOL   (_stdcall *CancelWaitableTimer(void)) (HANDLE);

	static void CALLBACK CWaitableTimer::InnerCallBack(LPVOID lpArg,DWORD dwTimerLowValue,DWORD dwTimerHighValue);

public:
	CWaitableTimer(void);
	~CWaitableTimer(void) {};
	bool Create(CTString tsName,STimerEventArgs* TimerEventArgs,bool bManualReset = false);
	bool Set(CTime tWakeTime,CTime tTriggerPeriodAfterWake = CTime());
	bool Cancel(void);
	bool Destroy(void);
	bool ValidTimer(void) { return mhTimer != 0; }
};

HMODULE CWaitableTimer::hModKernel32 = LoadLibrary("Kernel32.dll");

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

CWaitableTimer::CWaitableTimer(void) : mhTimer(0),mpTimerEventArgs(0) {}

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
	LARGE_INTEGER liDueTime;
	liDueTime.QuadPart = -tWakeTime.GetTimeInMultipleOfNanoSeconds(); 
	// 1 sec -> 1000 milli sec; 1 milli sec -> 1000000 nano sec  
	// fun uses interval of 100 nano secs
	return SetWaitableTimer()(mhTimer,&liDueTime,(long)tTriggerPeriodAfterWake.GetTimeInMilliSeconds(),CWaitableTimer::InnerCallBack,(void*)this,0) != 0;
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


long CWaitableTimer::ObjectCount = 0;

bool CWaitableTimer::ProcessObjectCount(bool Increment)
{
	if(Increment) ObjectCount++; else ObjectCount--;
	if(ObjectCount < 0) ObjectCount = 0;
}
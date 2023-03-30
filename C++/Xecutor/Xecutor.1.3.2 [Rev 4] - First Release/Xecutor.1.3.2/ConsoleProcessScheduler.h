
#pragma once

#include ".\ConsoleProcess.h"
#include ".\GenericExtendedQueue.h"
#include ".\WaitableTimer.h"

#include <list>


using namespace std;

typedef list<BYTE, allocator<BYTE> > LISTBYTE;

class CConsoleProcessScheduler
{
private:
	CTime mNextTriggerTime;
	bool mbAllHrs;
	bool mbAllMins;

	LISTBYTE mHrs;
	LISTBYTE mMins;

	CTString msExePath,msCmdLine,msName;

	CWaitableTimer mTimer;

	CExtendedLinkedList<CTString> mlnklstStdInputs;
	CConsoleProcess moProcess;
	
	IRedirectedOutput *mOutStream;
	IDynamicCommandLineProvider *mDynamicCmdLineProvider;

	GetEnvironment mEnvironment;

	HANDLE mhInputThread; 

private:
	static void  ConsoleProcessCompleted(CConsoleProcess *ConsoleProcess,bool bGraceFullCompletion);
	static void  ConsoleOutputAvailable(CConsoleProcess *ConsoleProcess,CTString tsOutData);
	static void  TimerEventHandler(STimerEventArgs sArgs);
	static DWORD InputThreadProc(PVOID pObj);
	bool StartProcess(void);
	bool SetTimer(void);
	bool CreateTimer(void);
	bool Schedule(void);
	bool ParseTimeArguments(CTString tsArguments,LISTBYTE& lstTime,bool& bAllTime);

public:

	CConsoleProcessScheduler(CTString tsExePath,CTString tsCmdLine,CTString tsHours,CTString tsMins,CExtendedLinkedList<CTString> &StdInputs);
	void SetOutStream(IRedirectedOutput *OutStream);
	void SetDynamicCommandLineProvider(IDynamicCommandLineProvider *DynamicCommandLineProvider); 
	void SetEnvironment(GetEnvironment Environment); 
	bool Start(void);
	bool End(void);
	inline ~CConsoleProcessScheduler(void) { End(); };
	CTString Name(bool Short = true);
	bool SetName(CTString ProfileName);
	inline bool Alive(void) { return moProcess.IsAlive(); };  
	inline CTime NextTriggerTime(void) { return mNextTriggerTime; };
	bool ResetTimer(bool bStart);
};

void CConsoleProcessScheduler::SetEnvironment(GetEnvironment Environment)
{
	mEnvironment = Environment;
}

bool CConsoleProcessScheduler::ResetTimer(bool bStart)
{
	return bStart ? Start() : mTimer.Cancel();
}

bool CConsoleProcessScheduler::Start(void)
{
	return Schedule(); 
}

bool CConsoleProcessScheduler::End(void)
{
	bool bOk = mTimer.Destroy();
	if(moProcess.IsAlive()) bOk &= moProcess.Kill();
	bOk &= mlnklstStdInputs.ClearList();  
	try { if(mOutStream) delete mOutStream; } catch(...) {} mOutStream = 0; 
	try { if(mDynamicCmdLineProvider) delete mDynamicCmdLineProvider; } catch(...) {} mDynamicCmdLineProvider = 0; 
	return bOk;
}

void CConsoleProcessScheduler::SetOutStream(IRedirectedOutput *OutStream)
{
	mOutStream = OutStream;
}

void CConsoleProcessScheduler::SetDynamicCommandLineProvider(IDynamicCommandLineProvider *DynamicCommandLineProvider)
{
	mDynamicCmdLineProvider =  DynamicCommandLineProvider;
}

CTString CConsoleProcessScheduler::Name(bool Short)
{
	if(Short) return msName;

	CTString sTmp = msName + " {"; 

	if(msExePath.Length() > 15)
	{
		sTmp += "..." + msExePath.Cut(msExePath.Length() - 15) + "}"; 
	}
	else
	{
		sTmp += msExePath + "}"; 
	}
	return sTmp;
}

bool CConsoleProcessScheduler::SetName(CTString ProfileName)
{
	msName = ProfileName;
	return true;
}

CConsoleProcessScheduler::CConsoleProcessScheduler(CTString tsExePath,CTString tsCmdLine,CTString tsHours,CTString tsMins,CExtendedLinkedList<CTString> &StdInputs)
{
	mEnvironment = 0;
	mDynamicCmdLineProvider = 0,mOutStream = 0;
	mbAllHrs = mbAllMins = false;
	mlnklstStdInputs = StdInputs;
	mhInputThread = 0;
	msExePath = tsExePath,msCmdLine = tsCmdLine;
	CTString sTmp; tsExePath.SplitByToken("\\",msName,sTmp,false);  
	ParseTimeArguments(tsHours,mHrs,mbAllHrs);
	if(mbAllHrs) for(int i = 1;i <= 24;++i) mHrs.push_back(i);  
	ParseTimeArguments(tsMins,mMins,mbAllMins);
	if(mbAllMins) for(int i = 1;i <= 60;++i) mMins.push_back(i);  
}

bool CConsoleProcessScheduler::ParseTimeArguments(CTString tsArguments,LISTBYTE& lstTime,bool& bAllTime)
{
	if(bAllTime = false,lstTime.clear(),tsArguments.Trim() == "*") 
	{
		bAllTime = true;
		return true;
	}
	CTString *pList = 0;
	ULONG ulSplitted = tsArguments.SplitByToken(",",pList);   
	if(!ulSplitted) return false;
	BYTE lVal;
	for(int i = 0;i < (int)ulSplitted;++i) 
	{
		try
		{
			if(pList[i].IsEmpty()) continue; 
			lVal = (BYTE)(long)(pList[i]);
			lstTime.push_back(lVal);  
		}
		catch(...) {}
	}
	delete[] pList;
	lstTime.sort(); 
	return true;
}

bool CConsoleProcessScheduler::CreateTimer(void)
{
	if(!mTimer.ValidTimer())
	{
		STimerEventArgs *sArg = new STimerEventArgs(CConsoleProcessScheduler::TimerEventHandler,(void*)this);
		return mTimer.Create(CTString::NullString(),sArg); 
	}
	return true;
}

bool CConsoleProcessScheduler::SetTimer(void)
{  
	mNextTriggerTime = CTime(); 

	SYSTEMTIME oSysTime;
	WORD wMilliSec,wSec,wMin,wHrs;
	LISTBYTE::iterator iTHrs,iTMins;
	bool bFlg;

	GetLocalTime(&oSysTime); 
	wHrs = oSysTime.wHour,wMin = oSysTime.wMinute,wSec = oSysTime.wSecond,wMilliSec = oSysTime.wMilliseconds;  

	CTime tCurTime(wHrs,wMin,wSec,wMilliSec),tCurDur,tMyTime;
	
	for(bFlg = false,iTHrs = mHrs.begin();iTHrs != mHrs.end();iTHrs++)   
		for(iTMins = mMins.begin();iTMins != mMins.end();iTMins++)
			if(!bFlg) 
			{
				tMyTime = CTime(*iTHrs,*iTMins);
				tCurDur = tMyTime - tCurTime;
				bFlg = true; 
			}
			else
			{
				CTime tTmp(*iTHrs,*iTMins),tDur;
				tDur = tTmp - tCurTime;
				if(tDur < tCurDur)
				{
					tCurDur = tDur;
					tMyTime = tTmp; 
				}
			}

	if(!bFlg) return false; else mNextTriggerTime = tMyTime; 
	return mTimer.Set(tCurDur); 
}

bool CConsoleProcessScheduler::Schedule(void)
{
	return CreateTimer() && SetTimer();
}

void CConsoleProcessScheduler::TimerEventHandler(STimerEventArgs sArgs)
{
	CConsoleProcessScheduler *pObj =(CConsoleProcessScheduler*)sArgs.Object(); 
	pObj->Schedule(),pObj->StartProcess(); 
}

DWORD CConsoleProcessScheduler::InputThreadProc(PVOID pObj)
{
	CConsoleProcessScheduler *ptrObj =(CConsoleProcessScheduler*)pObj; 
	long Cnt = ptrObj->mlnklstStdInputs.Count(),i = 0;
	CTString *sIn;

	while(i < Cnt)
	{
		if(!ptrObj->moProcess.IsAlive()) break; 
		sIn = ptrObj->mlnklstStdInputs[i];
		if(ptrObj->moProcess.WriteToConsole(*sIn)) ++i;
		SleepEx(350,true);
	}
	ptrObj->moProcess << _T("\r\n");
	return i == Cnt ? 0 : 1;
}

bool CConsoleProcessScheduler::StartProcess(void)
{
	if(moProcess.IsAlive()) return false;
	if(!moProcess.Initialize(msName,ConsoleOutputAvailable,ConsoleProcessCompleted,(void*)this)) return false;  
	CTString sExe,sCmd;
	if(!mDynamicCmdLineProvider || !mDynamicCmdLineProvider->GenerateCommandLine(sExe,sCmd)) 
		sExe = msExePath,sCmd = msCmdLine;

	if(!moProcess.Start(sExe,sCmd,true,mEnvironment)) return false; 
	DWORD dwId = 0;
	return (mhInputThread = CreateThread(0,0,CConsoleProcessScheduler::InputThreadProc,(void*)this,0,&dwId)) != 0;  
}

void CConsoleProcessScheduler::ConsoleProcessCompleted(CConsoleProcess *ConsoleProcess,bool bGraceFullCompletion)
{
	CConsoleProcessScheduler* ptrObj = (CConsoleProcessScheduler*)ConsoleProcess->CustomObject();
	if(ptrObj && ptrObj->mOutStream) ptrObj->mOutStream->StreamClosed(bGraceFullCompletion);
}

void CConsoleProcessScheduler::ConsoleOutputAvailable(CConsoleProcess *ConsoleProcess,CTString tsOutData)
{
	CConsoleProcessScheduler* ptrObj = (CConsoleProcessScheduler*)ConsoleProcess->CustomObject();
	if(ptrObj && ptrObj->mOutStream) ptrObj->mOutStream->WriteToStream(tsOutData);
}

#pragma once

#include "Mail.h"

class CMailServer : CMail 
{
private:
	bool mbStartServer;
	HANDLE mhThread;
	CMailSlotReader mReader; 

private:
	static DWORD _stdcall MessageServicer(LPVOID pObj);
	bool ProcessMailMessage(CMailSlotReader &Reader,MsgHeader &Header,CBytes &Bytes);

public:
	CMailServer(void);
	~CMailServer(void);
	bool Start(CTString ServerSlotName = MAIL_SLOT_SERVER);
	bool Stop(void);
};

CMailServer::CMailServer(void) : mbStartServer(false),mhThread(0) {}

CMailServer::~CMailServer(void) { Stop(); }

bool CMailServer::Start(CTString ServerSlotName)
{
	if(!Stop()) return false;
	if(!mReader.Connect(ServerSlotName)) return false; 
	mbStartServer = true;
	return (mhThread = CreateThread(0,0,CMailServer::MessageServicer,this,0,0)) != INVALID_HANDLE_VALUE; 
}

bool CMailServer::Stop(void)
{
	if(mbStartServer = false,mhThread)
	{
		if(WaitForSingleObject(mhThread,2 * 1000) == WAIT_TIMEOUT) 
			if(!TerminateThread(mhThread,0)) return false;  
		CloseHandle(mhThread); 
	}
	mhThread=0;
	return true;
}

DWORD _stdcall CMailServer::MessageServicer(LPVOID pObj)
{
	CMailServer *oMailServer = (CMailServer*)pObj;
	CBytes Bytes;
	MsgHeader Header;

	while(oMailServer->mbStartServer)
	{
		if(oMailServer->mReader.Read(Bytes))
		{
			Header = *((MsgHeader*)(BYTE*)Bytes);
			oMailServer->ProcessMailMessage(oMailServer->mReader,Header,Bytes);
		}
		SleepEx(200,true);
	}
	oMailServer->mReader.Disconnect(); 
	return 0;
}

bool CMailServer::ProcessMailMessage(CMailSlotReader &Reader,MsgHeader &Header,CBytes &Bytes)
{
	CMailSlotWriter Writer;
	CBytes OutArg,InArg;

	switch(Header.Message)
	{
		case MSG_PROFILE_CNT:
			{
				if(GetClient(Header,Bytes,Writer))
				{
					int lCnt = (int)moProcessList.Count(); 
					CTString sCnt;

					InArg.Clear(),InArg.Append((void*)&lCnt,sizeof(int)); 
					sCnt.AppendFormat("%d",lCnt); 
					if(PackMessage(Header.Message,InArg,sCnt,OutArg)) Writer.Write(OutArg);
				}
			}
			break;
		case MSG_PROFILE_GET_NAME:
			{
				if(GetArg(Header,Bytes,InArg))
				{
					int Index = *((int*)(BYTE*)InArg);
					CConsoleProcessScheduler *oSched = 0;
					CTString sName;
					try
					{
						oSched = (CConsoleProcessScheduler*)moProcessList[Index];
						sName = oSched->Name(); 
					}
					catch(...)
					{}
					if(GetClient(Header,Bytes,Writer))
					{
						InArg.Clear(); 
						if(PackMessage(Header.Message,InArg,sName,OutArg)) Writer.Write(OutArg);
					}
				}
			}
			break;
		case MSG_PROFILE_GET_STAT:
			{
				if(GetArg(Header,Bytes,InArg))
				{
					int Index = *((int*)(BYTE*)InArg);
					CConsoleProcessScheduler *oSched = 0;
					int iAlive = 0;
					CTString sStat;
					try
					{
						oSched = (CConsoleProcessScheduler*)moProcessList[Index];
						iAlive = oSched->Alive() ? 1 : 0; 
						sStat = iAlive ? "Active" : "InActive";
					}
					catch(...)
					{}
					if(GetClient(Header,Bytes,Writer))
					{
						InArg.Clear(); 
						InArg.Append((void*)&iAlive,sizeof(int));
						if(PackMessage(Header.Message,InArg,sStat,OutArg)) Writer.Write(OutArg);
					}
				}
			}
			break;

		case MSG_PROFILE_GET_SCH_TIME:
			{
				if(GetArg(Header,Bytes,InArg))
				{
					int Index = *((int*)(BYTE*)InArg);
					CConsoleProcessScheduler *oSched = 0;
					CTString sTime;
					try
					{
						oSched = (CConsoleProcessScheduler*)moProcessList[Index];
						sTime = oSched->NextTriggerTime().ToString(":",HrMinSec);    
					}
					catch(...)
					{}
					if(GetClient(Header,Bytes,Writer))
					{
						InArg.Clear(); 
						if(PackMessage(Header.Message,InArg,sTime,OutArg)) Writer.Write(OutArg);
					}
				}
			}
			break;
	}
	Writer.Disconnect(); 
	return true;
}
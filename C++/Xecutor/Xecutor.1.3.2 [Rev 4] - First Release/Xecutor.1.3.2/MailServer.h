
#pragma once

#include "Mail.h"

class CMailServer : CMail 
{
private:
	bool mbStartServer;
	HANDLE mhMailServerThread;
	CMailSlotReader mReader; 

private:
	static int Compare(CTString *Key,CConsoleProcessScheduler *oSched);
	static DWORD _stdcall MessageServicer(LPVOID pObj);
	bool ProcessMailMessage(CMailSlotReader &Reader,MsgHeader &Header,CBytes &Bytes);
	bool TerminateAll(bool ResetOnly);

public:
	CMailServer(void);
	~CMailServer(void);
	bool Start(CTString ServerSlotName = MAIL_SLOT_SERVER);
	bool Stop(void);
	bool Applications(bool Start);
};

#include "Functions.h"

CMailServer::CMailServer(void) : mbStartServer(false),mhMailServerThread(0) {}

CMailServer::~CMailServer(void) { Stop(); }

bool CMailServer::Start(CTString ServerSlotName)
{
	if(!Stop()) return false;
	if(!mReader.Connect(ServerSlotName)) return false; 
	mbStartServer = true;
	return (mhMailServerThread = CreateThread(0,0,CMailServer::MessageServicer,this,0,0)) != INVALID_HANDLE_VALUE; 
}

bool CMailServer::Stop(void)
{
	if(mbStartServer = false,mhMailServerThread)
	{
		if(WaitForSingleObject(mhMailServerThread,2 * 1000) == WAIT_TIMEOUT) 
			if(!TerminateThread(mhMailServerThread,0)) return false;  
		CloseHandle(mhMailServerThread); 
	}
	mhMailServerThread=0;
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
		case MSG_PROFILE_GET_SHORT_NAME:
			{
				if(GetArg(Header,Bytes,InArg))
				{
					int Index = *((int*)(BYTE*)InArg);
					CConsoleProcessScheduler *oSched = 0;
					CTString sName;
					try
					{
						oSched = (CConsoleProcessScheduler*)moProcessList[Index];
						sName = oSched->Name(Header.Message != MSG_PROFILE_GET_NAME); 
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

		case MSG_TERMINATE_ALL:
		case MSG_RESET_ALL:
			{
				CTString sProfile;
				bool bOk = TerminateAll(MSG_RESET_ALL == Header.Message); 
				if(GetClient(Header,Bytes,Writer))
				{
					InArg.Clear(); 
					sProfile.Clear(); 
					if(PackMessage(bOk ? MSG_OK : MSG_ERR,InArg,sProfile,OutArg)) Writer.Write(OutArg);
				}
			}
			break;

		case MSG_PROFILE_START_SCH:
		case MSG_PROFILE_STOP_SCH:
		case MSG_PROFILE_TERMINATE_SCH:
			{
				if(GetArg(Header,Bytes,InArg))
				{
					CTString sProfile;
					CConsoleProcessScheduler *oSched = 0;
					bool bOk = false;
					bOk = InArg.Convert(sProfile);  
					if(bOk) oSched = moProcessList.FindItem(&sProfile,(CompareDlgte)&CMailServer::Compare);
					if(oSched)
					{
						if(MSG_PROFILE_TERMINATE_SCH == Header.Message)
						{
							bOk = oSched->End(); 
							bOk &=  moProcessList.DeleteItemByAddress((UINT)oSched);

						}
						else
						{
							bOk = oSched->ResetTimer(Header.Message == MSG_PROFILE_START_SCH); 
						}
					}
					if(GetClient(Header,Bytes,Writer))
					{
						InArg.Clear(); 
						sProfile.Clear(); 
						if(PackMessage(bOk ? MSG_OK : MSG_ERR,InArg,sProfile,OutArg)) Writer.Write(OutArg);
					}
				}
			}
			break;

		case MSG_RESTART:
			{
				CTString sProfile;
				bool bOk = (Applications(false) != 0);
				bOk &= (Applications(true) != 0); 
				if(GetClient(Header,Bytes,Writer))
				{
					InArg.Clear(); 
					sProfile.Clear(); 
					if(PackMessage(bOk ? MSG_OK : MSG_ERR,InArg,sProfile,OutArg)) Writer.Write(OutArg);
				}
			}
			break;
	}
	Writer.Disconnect(); 
	return true;
}

int CMailServer::Compare(CTString *Key,CConsoleProcessScheduler *oSched)
{
	return (oSched->Name() == *Key); 
}

bool CMailServer::TerminateAll(bool ResetOnly)
{
	bool bOk = false;
	long i,Cnt = moProcessList.Count();
	CConsoleProcessScheduler *oSched;
	
	CExtendedLinkedList<CConsoleProcessScheduler> oTmpList(true);
	
	for(i=0 ; i < Cnt ; i++)
	{
		try
		{
			oSched = moProcessList[i];
			if(!oSched) continue;
			bOk &= ResetOnly ? oSched->ResetTimer(false) : oSched->End();
			if(!ResetOnly) oTmpList.InsertAtBack(oSched);
		}
		catch(...) { bOk &= false; }
	}
	bOk &= oTmpList.ClearList();
	return bOk;
}

bool CMailServer::Applications(bool Start)
{
	if(Start)
	{
		DWORD dwId = 0;
		LogEvent("Starting Applications...");
		mhThread = CreateThread(0,0,&LaunchApplications,0,0,&dwId); 
		if(mhThread)
		{
			WaitForSingleObject(mhThread,INFINITE); 
			CloseHandle(mhThread);
			mhThread = 0;
		}
	}
	else
	{
		if(mhThread)
		{
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
	}
	return 1;
}


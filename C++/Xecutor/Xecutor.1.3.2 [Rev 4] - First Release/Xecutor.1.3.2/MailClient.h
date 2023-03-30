
#pragma once

#include "Mail.h"

class CMailClient : CMail 
{
protected:
	CTString msServerSlot,msClientSlot,msServer,msClient;
	CMailSlotWriter mWriter;
	CMailSlotReader mReader;

protected:
	bool SendClientMessage(BYTE Msg,CBytes& Arg);
	bool SendClientMessage(BYTE Msg);
	bool RecvServerMessage(CTString& Result); 
	bool RecvServerMessage(BYTE& Result);

public:
	~CMailClient(void);
	bool Set(CTString ServerSlot = MAIL_SLOT_SERVER,CTString ClientSlot = MAIL_SLOT_CLIENT,CTString Server = CMailSlot::LocalServerName,CTString Client = CMailSlot::LocalServerName);
	int ProfileCount(void);
	bool GetProfile(int Index,CTString& Name,CTString& Status,bool ShortName = true);
	bool GetProfileTriggerTime(int Index,CTString& TriggerTime);
	bool Schedule(bool Start,CTString ProfileName);
	bool Terminate(CTString ProfileName);
	bool AllProfiles(bool Terminate);
	bool RestartService(void);
};

CMailClient::~CMailClient(void)
{
	mReader.Disconnect();
}

bool CMailClient::SendClientMessage(BYTE Msg,CBytes& Arg)
{
	CBytes OutArg;

	if(PackMessage(Msg,Arg,"\\\\" + msClient + "\\mailslot\\" + msClientSlot,OutArg))    
		if(mWriter.Connect(msServerSlot,msServer)) 
		{
			bool bOk = mWriter.Write(OutArg);
			mWriter.Disconnect();
			return bOk;
		}
	return false;
}

bool CMailClient::SendClientMessage(BYTE Msg)
{
	CBytes Bytes;
	return SendClientMessage(Msg,Bytes);
}

bool CMailClient::Set(CTString ServerSlot,CTString ClientSlot,CTString Server,CTString Client)
{
	msServerSlot = ServerSlot;
	msClientSlot = ClientSlot;
	msClient = Client;
	msServer = Server;
	mReader.Disconnect();
	return mReader.Connect(ClientSlot); 
}

bool CMailClient::RecvServerMessage(CTString& Result)
{	
	CBytes Msg,InArg;
	MsgHeader Header;

	for(int i = 1; i <= 3; i++)
	{
		if(Result.Clear(),mReader.Read(Msg))
		{
			Header = *((MsgHeader*)(BYTE*)Msg);
			return LastPart(Header,Msg,Result); 
		}
		SleepEx(100,true);
	}
	return false;
}

bool CMailClient::RecvServerMessage(BYTE& Result)
{	
	CBytes Msg;
	MsgHeader Header;

	for(int i = 1; i <= 3; i++)
	{
		if(mReader.Read(Msg))
		{
			Header = *((MsgHeader*)(BYTE*)Msg);
			Result = Header.Message; 
			return true;
		}
		SleepEx(100,true);
	}
	return false;
}

int CMailClient::ProfileCount(void)
{
	CTString sRes;

	if(SendClientMessage(MSG_PROFILE_CNT))
		if(RecvServerMessage(sRes))
			return (int)(long)sRes;

	return 0;
}

bool CMailClient::GetProfile(int Index,CTString& Name,CTString& Status,bool ShortName)
{
	CBytes Bytes;

	Name.Clear(); Status.Clear(); 
	if(!Bytes.Append((void*)&Index,sizeof(int))) return false;
	if(!SendClientMessage(ShortName ? MSG_PROFILE_GET_SHORT_NAME : MSG_PROFILE_GET_NAME,Bytes)) return false;
	if(!RecvServerMessage(Name)) return false; 
	if(!SendClientMessage(MSG_PROFILE_GET_STAT,Bytes)) return false;
	if(!RecvServerMessage(Status)) return false; 
	return true;
}

bool CMailClient::GetProfileTriggerTime(int Index,CTString& TriggerTime)
{
	CBytes Bytes;

	TriggerTime.Clear(); 
	if(!Bytes.Append((void*)&Index,sizeof(int))) return false;
	if(!SendClientMessage(MSG_PROFILE_GET_SCH_TIME,Bytes)) return false;
	if(!RecvServerMessage(TriggerTime)) return false; 
	return true;
}

bool CMailClient::Schedule(bool Start,CTString ProfileName)
{
	CBytes Bytes;
	BYTE bytResult = 0;

	if(!ProfileName.Convert(Bytes)) return false;
	if(!SendClientMessage(Start ? MSG_PROFILE_START_SCH : MSG_PROFILE_STOP_SCH,Bytes)) return false;
	if(!RecvServerMessage(bytResult)) return false; 
	return bytResult == MSG_OK;	
}

bool CMailClient::Terminate(CTString ProfileName)
{
	CBytes Bytes;
	BYTE bytResult = 0;

	if(!ProfileName.Convert(Bytes)) return false;
	if(!SendClientMessage(MSG_PROFILE_TERMINATE_SCH,Bytes)) return false;
	if(!RecvServerMessage(bytResult)) return false; 
	return bytResult == MSG_OK;	
}

bool CMailClient::AllProfiles(bool Terminate)
{
	CBytes Bytes;
	BYTE bytResult = 0;

	if(!SendClientMessage(Terminate ? MSG_TERMINATE_ALL : MSG_RESET_ALL,Bytes)) return false;
	if(!RecvServerMessage(bytResult)) return false; 
	return bytResult == MSG_OK;	
}

bool CMailClient::RestartService(void)
{
	CBytes Bytes;
	BYTE bytResult = 0;

	if(!SendClientMessage(MSG_RESTART,Bytes)) return false;
	if(!RecvServerMessage(bytResult)) return false; 
	return bytResult == MSG_OK;	;	
}
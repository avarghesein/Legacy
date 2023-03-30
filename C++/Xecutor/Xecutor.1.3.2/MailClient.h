
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

public:
	bool Set(CTString ServerSlot = MAIL_SLOT_SERVER,CTString ClientSlot = MAIL_SLOT_CLIENT,CTString Server = CMailSlot::LocalServerName,CTString Client = CMailSlot::LocalServerName);
	int ProfileCount(void);
	bool GetProfile(int Index,CTString& Name,CTString& Status);
	bool GetProfileTriggerTime(int Index,CTString& TriggerTime);
};

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

	for(int i = 0; i <= 10; i++)
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

int CMailClient::ProfileCount(void)
{
	CTString sRes;

	if(SendClientMessage(MSG_PROFILE_CNT))
		if(RecvServerMessage(sRes))
			return (int)(long)sRes;

	return 0;
}

bool CMailClient::GetProfile(int Index,CTString& Name,CTString& Status)
{
	CBytes Bytes;

	Name.Clear(); Status.Clear(); 
	Bytes.Append((void*)&Index,sizeof(int));
	if(!SendClientMessage(MSG_PROFILE_GET_NAME,Bytes)) return false;
	if(!RecvServerMessage(Name)) return false; 
	if(!SendClientMessage(MSG_PROFILE_GET_STAT,Bytes)) return false;
	if(!RecvServerMessage(Status)) return false; 
	return true;
}

bool CMailClient::GetProfileTriggerTime(int Index,CTString& TriggerTime)
{
	CBytes Bytes;

	TriggerTime.Clear(); 
	Bytes.Append((void*)&Index,sizeof(int));
	if(!SendClientMessage(MSG_PROFILE_GET_SCH_TIME,Bytes)) return false;
	if(!RecvServerMessage(TriggerTime)) return false; 
	return true;
}
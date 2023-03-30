#pragma once

class CMailSlotReader : public CMailSlot
{
public:
	CMailSlotReader(void);
	virtual ~CMailSlotReader(void);

	virtual bool Connect(CTString MailSlotName,CTString ServerName = CMailSlot::LocalServerName);
	virtual bool ConnectSpecial(CTString MailSlotFullName);
	bool Read(CTString &Message);
	bool Read(CBytes &Message);
	int  MessageCount(long *NextMessageSize = 0);
};

CMailSlotReader::CMailSlotReader(void) : CMailSlot() {}

CMailSlotReader::~CMailSlotReader(void) {}

bool CMailSlotReader::ConnectSpecial(CTString MailSlotFullName)
{
	if(IsOpen())
	{
		if(MailSlotFullName.ToUpper() == msMailSlotName.ToUpper()) return true;
		Disconnect(); 
	}
	msMailSlotName = MailSlotFullName;
	if((mhMailSlot = CreateMailslot((TCHAR*)msMailSlotName,0,MAILSLOT_WAIT_FOREVER,0)) != INVALID_HANDLE_VALUE)
	{
		return true;
	}
	return false;
}

bool CMailSlotReader::Connect(CTString MailSlotName,CTString)
{
	return CMailSlotReader::ConnectSpecial("\\\\.\\mailslot\\" + MailSlotName);
}

int  CMailSlotReader::MessageCount(long *NextMessageSize)
{
	DWORD dwCount = 0,dwNextMsgSze = 0;

	if(NextMessageSize) *NextMessageSize = 0;

	if (IsOpen()) 
		if(!GetMailslotInfo(mhMailSlot,0,&dwNextMsgSze, &dwCount,0) || dwNextMsgSze == MAILSLOT_NO_MESSAGE) return 0;

	if(NextMessageSize) *NextMessageSize = (long)dwNextMsgSze;
	return (int)dwCount;
}

bool CMailSlotReader::Read(CTString &Message)
{
	CBytes Bytes;
	if(!Read(Bytes)) return false;
	return Bytes.Convert(Message); 
}

bool CMailSlotReader::Read(CBytes &Message)
{
	long lBytsToRead = 0;

	if(IsOpen() && MessageCount(&lBytsToRead) > 0 && lBytsToRead > 0)
	{
		DWORD dwRed = 0;
		BYTE *pByts = (BYTE*)_alloca(lBytsToRead);
		if(!ReadFile(mhMailSlot,pByts,(DWORD)lBytsToRead,&dwRed,0) || dwRed <= 0) return false;
		return Message.SetMemoryBlock(pByts,lBytsToRead);
	}
	return false;
}

